Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309FBC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 13:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ9qR-0006Yo-9k; Wed, 31 Jul 2024 09:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1sZ9qP-0006Xr-BU
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 09:58:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1sZ9qN-0002Ei-L1
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 09:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722434298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DwrF+ZiIqSx6mFuTqzFeL3usnShG71uPJ0K3OXMr8ns=;
 b=GnkTGq8FUMvBA4JWRVZpahQbed+WsMQzDTGPXgsxgT1/hZPLHPWqpH0Vy1N2AajA9zibrw
 XOEpLkN2Vi/Ha74CU7ju73PNkPvsGD1mfc/ymyzqnXegtQNbjOISAEtKWQ2ffNT0N0Sopp
 +Np8i/D3Kd13oSF4VAtdCn3Oc8MkKmI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-k_LFr1fBNwqk1L1dozbOAw-1; Wed,
 31 Jul 2024 09:57:06 -0400
X-MC-Unique: k_LFr1fBNwqk1L1dozbOAw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20C121955BFE; Wed, 31 Jul 2024 13:57:05 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.45.226.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40EE119560B2; Wed, 31 Jul 2024 13:57:00 +0000 (UTC)
Date: Wed, 31 Jul 2024 15:56:26 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] qdev-monitor: QAPIfy QMP device_add
Message-ID: <ZqpCinmDOyKuzJnO@angien.pipo.sk>
References: <20240708143027.480821-1-stefanha@redhat.com>
 <87ttgyd4j9.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttgyd4j9.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 09, 2024 at 16:27:22 +0200, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
> 
> > The QMP device_add monitor command converts the QDict arguments to
> > QemuOpts and then back again to QDict. This process only supports scalar
> > types. Device properties like virtio-blk-pci's iothread-vq-mapping (an
> > array of objects) are silently dropped by qemu_opts_from_qdict() during
> > the QemuOpts conversion even though QAPI is capable of validating them.
> > As a result, hotplugging virtio-blk-pci devices with the
> > iothread-vq-mapping property does not work as expected (the property is
> > ignored). It's time to QAPIfy QMP device_add!
> 
> This patch doesn't fully QAPIfy device_add: we still lack a schema
> and use 'gen': false.  It gets us closer, though.
> 
> > Get rid of the QemuOpts conversion in qmp_device_add() and call
> > qdev_device_add_from_qdict() with from_json=true. Using the QMP
> > command's QDict arguments directly allows non-scalar properties.
> >
> > The HMP is also adjusted since qmp_device_add()'s now expects properly
> > typed JSON arguments and cannot be used from HMP anymore. Move the code
> > that was previously in qmp_device_add() (with QemuOpts conversion and
> > from_json=false) into hmp_device_add() so that its behavior is
> > unchanged.
> >
> > This patch changes the behavior of QMP device_add but not HMP
> > device_add. QMP clients that sent incorrectly typed device_add QMP
> > commands no longer work. This is a breaking change but clients should be
> > using the correct types already. See the netdev_add QAPIfication in
> > commit db2a380c8457 for similar reasoning.
> 
> Another one is 9151e59a8b6e: it QAPIfied object-add.
> 
> Both commits eliminated the roundtrip through QemuOpts, and weaned the
> command off 'gen': false.
> 
> This commit eliminates the roundtrip, but keeps 'gen': false.  Best we
> can do now, but I'd like the commit message to make this clear.
> 
> > Markus helped me figure this out and even provided a draft patch. The
> > code ended up very close to what he suggested.
> >
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Cc: Daniel P. Berrangé <berrange@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  system/qdev-monitor.c | 41 ++++++++++++++++++++++++++++-------------
> >  1 file changed, 28 insertions(+), 13 deletions(-)

[...]

> Have a look at this TODO in vl.c:
> 
>     QTAILQ_FOREACH(opt, &device_opts, next) {
>         DeviceState *dev;
>         loc_push_restore(&opt->loc);
>         /*
>          * TODO Eventually we should call qmp_device_add() here to make sure it
>          * behaves the same, but QMP still has to accept incorrectly typed
>          * options until libvirt is fixed and we want to be strict on the CLI
>          * from the start, so call qdev_device_add_from_qdict() directly for
>          * now.
>          */

So at least this TODO should already be handled on libvirt's side.

With modern qemu libvirt is using JSON for -device and exactly the same
JSON for device_add. From what I remember from the time when I've
converted -device to use JSON, -device already required the correct
types, which would mean that also libvirt uses the correct types now.


