Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6A3D15DB8
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2v4H-00015A-9W; Mon, 21 Oct 2024 12:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2v43-0000fE-35
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:15:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2v41-0003Yj-6w
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729527323;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K+Sf84LNtkWhZSNJu918iOwf7O1lcTMVvlby8MOZe7s=;
 b=Ygh0uPpTOxDFKBBWu+SpQ2mV153Ml8dAspZI962fuDzqoLu/twEDDNxxYXh/ZDCw2v9ftN
 MREtD6BPWA5LjYl1b+vy5hZxkm/9JZDFogMlqwAwcnyhEGc9ac2+PkSanFJq4QcmRdUrpE
 JuaCzzf+YLoMmJ+ScR7fvpYLUSuw86U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-IHj9vUGeMiaxcOsxprSAqA-1; Mon,
 21 Oct 2024 12:15:22 -0400
X-MC-Unique: IHj9vUGeMiaxcOsxprSAqA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CA0A1955BEE; Mon, 21 Oct 2024 16:15:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DB5A1956056; Mon, 21 Oct 2024 16:15:19 +0000 (UTC)
Date: Mon, 21 Oct 2024 17:15:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/3] crypto: fix regression in hash result buffer
 handling
Message-ID: <ZxZ-FWjs1zlaD2Xm@redhat.com>
References: <20241016102006.480218-1-berrange@redhat.com>
 <CAFfO_h4qVKBS88LZmbG9-W70HeWmsCw40wG0zHKo7xMB=F=Owg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFfO_h4qVKBS88LZmbG9-W70HeWmsCw40wG0zHKo7xMB=F=Owg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Oct 16, 2024 at 07:33:56PM +0600, Dorjoy Chowdhury wrote:
> On Wed, Oct 16, 2024 at 4:20 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> >
> >
> > Daniel P. Berrangé (3):
> >   crypto/hash: avoid overwriting user supplied result pointer
> >   tests: correctly validate result buffer in hash/hmac tests
> >   include/crypto: clarify @result/@result_len for hash/hmac APIs
> >
> >  crypto/hash-gcrypt.c          | 15 ++++++++++++---
> >  crypto/hash-glib.c            | 11 +++++++++--
> >  crypto/hash-gnutls.c          | 16 +++++++++++++---
> >  crypto/hash-nettle.c          | 14 +++++++++++---
> >  include/crypto/hash.h         | 30 +++++++++++++++++++++++-------
> >  include/crypto/hmac.h         | 17 ++++++++++++-----
> >  tests/unit/test-crypto-hash.c |  7 ++++---
> >  tests/unit/test-crypto-hmac.c |  6 ++++--
> >  8 files changed, 88 insertions(+), 28 deletions(-)
> >
> 
> Reviewed-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> 
> 
> @Daniel the api documentation for "qcrypto_hash_bytesv" also needs to
> be updated.

Opps, yes, I'll make exactly the same docs change for that too, and
the equiv hmac  API.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


