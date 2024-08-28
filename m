Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3831FC5AE5A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 14:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjJWa-000764-An; Wed, 28 Aug 2024 10:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjJWX-00075P-Ou
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 10:19:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjJWV-0006Rb-0b
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 10:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724854784;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JNRHomEDXx9z9409hVeFmHx8gqVMt3a2fK9g6Y3TbVU=;
 b=gApfeFPBWsQyNv5LVAnbbGRlJTDexgCPIqROhGYaR9TxiRy2zP1FwyUflQQzWekpUxru5a
 Ag6ra8fThhyx/2xp2pU6RMjBr21+5Jx4NWkWjJBeLwH+pYrmHo4GAacyYQcJBqFP+I3oX7
 Ot059M87XqSQdOKqTra5z/rsZ2mMoWU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-_weIMNJlMqegwZH_472fQw-1; Wed,
 28 Aug 2024 10:19:41 -0400
X-MC-Unique: _weIMNJlMqegwZH_472fQw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 917081955D4E; Wed, 28 Aug 2024 14:19:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.92])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C4881956052; Wed, 28 Aug 2024 14:19:36 +0000 (UTC)
Date: Wed, 28 Aug 2024 15:19:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 pkrempa@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com
Subject: Re: [PATCH v3 1/2] qdev-monitor: avoid QemuOpts in QMP device_add
Message-ID: <Zs8x9QfxmUa-hI1r@redhat.com>
References: <20240827192751.948633-1-stefanha@redhat.com>
 <20240827192751.948633-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240827192751.948633-2-stefanha@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Aug 27, 2024 at 03:27:50PM -0400, Stefan Hajnoczi wrote:
> The QMP device_add monitor command converts the QDict arguments to
> QemuOpts and then back again to QDict. This process only supports scalar
> types. Device properties like virtio-blk-pci's iothread-vq-mapping (an
> array of objects) are silently dropped by qemu_opts_from_qdict() during
> the QemuOpts conversion even though QAPI is capable of validating them.
> As a result, hotplugging virtio-blk-pci devices with the
> iothread-vq-mapping property does not work as expected (the property is
> ignored).
> 
> Get rid of the QemuOpts conversion in qmp_device_add() and call
> qdev_device_add_from_qdict() with from_json=true. Using the QMP
> command's QDict arguments directly allows non-scalar properties.
> 
> The HMP is also adjusted since qmp_device_add()'s now expects properly
> typed JSON arguments and cannot be used from HMP anymore. Move the code
> that was previously in qmp_device_add() (with QemuOpts conversion and
> from_json=false) into hmp_device_add() so that its behavior is
> unchanged.
> 
> This patch changes the behavior of QMP device_add but not HMP
> device_add. QMP clients that sent incorrectly typed device_add QMP
> commands no longer work. This is a breaking change but clients should be
> using the correct types already. See the netdev_add QAPIfication in
> commit db2a380c8457 for similar reasoning and object-add in commit
> 9151e59a8b6e. Unlike those commits, we continue to rely on 'gen': false
> for the time being.
> 
> Markus helped me figure this out and even provided a draft patch. The
> code ended up very close to what he suggested.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  system/qdev-monitor.c | 44 ++++++++++++++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 15 deletions(-)


Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


