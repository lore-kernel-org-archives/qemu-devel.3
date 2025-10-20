Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DB2CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 11:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAo3U-00070t-Gk; Mon, 20 Oct 2025 07:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vAo3Q-00070f-VX
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:27:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vAo3O-00082M-W1
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760959673;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t7L+POjpZ+nexZn+121R/bpzOmbKvh3DTBgM3o1BvLY=;
 b=b/ognUeXpTpAFpuoVfe3BTgx0V9aSLJWodiaEDSUrZfEYVgZB/01bZuUHftWuIKs418a+3
 18zU4O6dVtruLkjRJIrYKpWfzd5f9kihJAlSEBZZf0hT6DVvQsXFTwE5r2abXGsq+E0sYk
 C0ANdPmi7cOBQfoJcni+tUTVrirK5W8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-RpbweNPWN-6wkoKU3nVfjw-1; Mon,
 20 Oct 2025 07:27:51 -0400
X-MC-Unique: RpbweNPWN-6wkoKU3nVfjw-1
X-Mimecast-MFC-AGG-ID: RpbweNPWN-6wkoKU3nVfjw_1760959671
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEF6F195608D
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 11:27:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.161])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4AE01800577; Mon, 20 Oct 2025 11:27:49 +0000 (UTC)
Date: Mon, 20 Oct 2025 12:27:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 4/6] crypto: stop requiring "key encipherment" usage
 in x509 certs
Message-ID: <aPYcsgMUo7zwqRHY@redhat.com>
References: <20250919101022.1491007-1-berrange@redhat.com>
 <20250919101022.1491007-5-berrange@redhat.com>
 <b7ffwoujpgryclocsq5tf6nmz24ziaastfjbt2av2gftc5pvbr@qroqdsicq3so>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7ffwoujpgryclocsq5tf6nmz24ziaastfjbt2av2gftc5pvbr@qroqdsicq3so>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 16, 2025 at 10:41:47AM -0500, Eric Blake wrote:
> On Fri, Sep 19, 2025 at 11:10:20AM +0100, Daniel P. Berrangé wrote:
> > This usage flag was deprecated by RFC8813, such that it is
> > forbidden to be present for certs using ECDSA/ECDH algorithms,
> > and in TLS 1.3 is conceptually obsolete.
> > 
> > As such many valid certs will no longer have this key usage
> > flag set, and QEMU should not be rejecting them, as this
> > prevents use of otherwise valid & desirable algorithms.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  crypto/tlscredsx509.c                 | 10 +-------
> >  docs/system/tls.rst                   | 13 +++-------
> >  tests/unit/crypto-tls-x509-helpers.h  |  6 ++---
> >  tests/unit/test-crypto-tlscredsx509.c | 36 +++++++++++++--------------
> >  tests/unit/test-crypto-tlssession.c   | 14 +++++------
> >  tests/unit/test-io-channel-tls.c      |  4 +--
> >  6 files changed, 34 insertions(+), 49 deletions(-)
> 
> My understanding is that the reason you coded all the sanity checks
> into qemu was to provide saner error messages for users that create
> invalid keys than what gnutls does (keys are already hard enough to
> create securely, so it is nice to be told how to fix your key rather
> than just "it didn't work").  I also understand that newer algorithms
> really can't use this flag, and we don't want to reject use of better
> algorithms, so this patch makes sense as documented.

Yes, admin configuration mistakes with TLS certs are an incredibly
common problem, frustratingly hard to diagnose, especially when the
failure only happens at runtime, not startup. So this code is mostly
about "sanity checks" on configuration.

> Still, is there any risk that for older algorithms, where the 'key
> encipherment' bit did matter, that we could now end up processing an
> incomplete key that we would have previously rejected with a nice
> message but which now goes to gnutls and reverts back to the poorer
> error message quality or even worse being used despite being a
> security risk?  I don't think it is a high risk - fewer people would
> be generating certificates that explicitly request an older algorithm
> but not following all the recommended steps, compared to the more
> common case of people following your documentation and getting the
> newest defaults that just work; anyone determined enough to get an
> older algorithm deserves the breakage if their explicit instructions
> to override the default are weaker than normal.

Yes, it is a slight degradation in the checks we are doing in
certain scenarios. As the world moves increasingly towards
eliptic curves and/or post-quantum crypto, the check is less
and less important. So its an acceptable tradeoff. I've got
another series coming soon that supports post-quantum crypto
better in QEMU

> In saying that, I'm hoping that gnutls still diagnoses certs that
> cannot be properly used for the purpose at hand (whether or not the
> 'key encipherment' bit must be set or cleared), even if it gives a
> less-than-stellar diagnostic message about rejecting a cert.  If I'm
> wrong, and an incomplete cert with an older algorithm but missing the
> bit turns into a security bypass, it's much more than QEMU that would
> be impacted.  So, I'm comfortable with:
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


