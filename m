Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD61D2E022
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 08:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3WX9-0003p3-2n; Wed, 23 Oct 2024 04:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3WWl-0003oh-A7
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:15:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3WWh-00044m-1K
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729671328;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WgZRFpJl3xNk12mHLYvfK/L/5J8DumlFSIBnmIxDmIg=;
 b=O30G0XT72KWx9oY7oWwUsZObzAt72EP79SZf7kiok7H5PzmeT5Iyr97hVAmhNLEUFXyrYt
 qubmzZgtdgFSo2OT7yRHXQa9Z/kgFmpmBtfLFoWnxYx/oLqG25TiweC5AYwAtXsy6cT+pi
 amv6nUtnuf2G69GVDeRXEA7AFy9j2jc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-Yf5Txts9OaG6eANLgtIoJA-1; Wed,
 23 Oct 2024 04:15:25 -0400
X-MC-Unique: Yf5Txts9OaG6eANLgtIoJA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9836C19560BE; Wed, 23 Oct 2024 08:15:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 501021956056; Wed, 23 Oct 2024 08:15:20 +0000 (UTC)
Date: Wed, 23 Oct 2024 09:15:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Alejandro Zeise <alejandro.zeise@seagate.com>, Kunwu <chentao@kylinos.cn>
Subject: Re: [PULL 08/17] crypto/hash: Implement and use new hash API
Message-ID: <ZxiwlPx7b7kIyxyw@redhat.com>
References: <20241010162024.988284-1-berrange@redhat.com>
 <20241010162024.988284-9-berrange@redhat.com>
 <cae8193d-6693-45d7-959f-eef536ec4589@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cae8193d-6693-45d7-959f-eef536ec4589@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Oct 22, 2024 at 09:10:50PM +0200, Thomas Huth wrote:
> On 10/10/2024 18.20, Daniel P. Berrangé wrote:
> > From: Alejandro Zeise <alejandro.zeise@seagate.com>
> > 
> > Changes the public hash API implementation to support accumulative hashing.
> > 
> > Implementations for the public functions are added to call the new
> > driver functions that implement context creation, updating,
> > finalization, and destruction.
> > 
> > Additionally changes the "shortcut" functions to use these 4 new core
> > functions.
> > 
> > Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
> > [ clg: - Reworked qcrypto_hash_bytesv() error handling
> >         - Used hash->driver int qcrypto_hash_new(), qcrypto_hash_free()
> >           qcrypto_hash_updatev()
> >         - Introduced qcrypto_hash_supports() check in
> >           qcrypto_hash_new()
> >         - Introduced g_autofree variables in qcrypto_hash_finalize_digest()
> >           and qcrypto_hash_finalize_base64()
> >         - Re-arrranged code in qcrypto_hash_digestv() and
> >           qcrypto_hash_digest()
> >         - Checkpatch fixes ]
> > Signed-off-by: Cédric Le Goater <clg@redhat.com>
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   crypto/hash.c | 161 ++++++++++++++++++++++++++++++++++++++++----------
> >   1 file changed, 131 insertions(+), 30 deletions(-)
> 
>  Hi,
> 
> something recently broke qemu-iotest 081 in raw mode and bisecting it
> pointed me to this commit here.

snip

> Could you please have a look?

This is fixed by my current pending pull request


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


