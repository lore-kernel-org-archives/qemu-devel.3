Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCB8CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Q7J-0007uB-9I; Thu, 16 Oct 2025 11:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v9Q7F-0007rM-H6
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:42:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v9Q75-0006pN-Pe
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760629314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LbqxUbjGjMydToe30ff2DVVeXFQQlvB2Gjo1LGgYUQQ=;
 b=iOcpfFRfYvDkrKRfSqtAtzs2cfXrSSYL7+IvoV5YyTnuXDtQjUjNI/5ASCa34XZx8kjDya
 dm9tmNI5XuDG3+aJcjL/KzeYB93w/5qf4u/Ml0tI4U3dCpG3yueDD7fdRso7M61D9s9oS3
 M23pR/vRe8Dcl7M6xrv+R3tKQZ9UdgQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-gWKZEq4fNP6DRXyDnq5ctw-1; Thu,
 16 Oct 2025 11:41:52 -0400
X-MC-Unique: gWKZEq4fNP6DRXyDnq5ctw-1
X-Mimecast-MFC-AGG-ID: gWKZEq4fNP6DRXyDnq5ctw_1760629311
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 785F8195608D
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 15:41:51 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.155])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 246C2300019F; Thu, 16 Oct 2025 15:41:49 +0000 (UTC)
Date: Thu, 16 Oct 2025 10:41:47 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 4/6] crypto: stop requiring "key encipherment" usage
 in x509 certs
Message-ID: <b7ffwoujpgryclocsq5tf6nmz24ziaastfjbt2av2gftc5pvbr@qroqdsicq3so>
References: <20250919101022.1491007-1-berrange@redhat.com>
 <20250919101022.1491007-5-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919101022.1491007-5-berrange@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 19, 2025 at 11:10:20AM +0100, Daniel P. Berrangé wrote:
> This usage flag was deprecated by RFC8813, such that it is
> forbidden to be present for certs using ECDSA/ECDH algorithms,
> and in TLS 1.3 is conceptually obsolete.
> 
> As such many valid certs will no longer have this key usage
> flag set, and QEMU should not be rejecting them, as this
> prevents use of otherwise valid & desirable algorithms.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  crypto/tlscredsx509.c                 | 10 +-------
>  docs/system/tls.rst                   | 13 +++-------
>  tests/unit/crypto-tls-x509-helpers.h  |  6 ++---
>  tests/unit/test-crypto-tlscredsx509.c | 36 +++++++++++++--------------
>  tests/unit/test-crypto-tlssession.c   | 14 +++++------
>  tests/unit/test-io-channel-tls.c      |  4 +--
>  6 files changed, 34 insertions(+), 49 deletions(-)

My understanding is that the reason you coded all the sanity checks
into qemu was to provide saner error messages for users that create
invalid keys than what gnutls does (keys are already hard enough to
create securely, so it is nice to be told how to fix your key rather
than just "it didn't work").  I also understand that newer algorithms
really can't use this flag, and we don't want to reject use of better
algorithms, so this patch makes sense as documented.

Still, is there any risk that for older algorithms, where the 'key
encipherment' bit did matter, that we could now end up processing an
incomplete key that we would have previously rejected with a nice
message but which now goes to gnutls and reverts back to the poorer
error message quality or even worse being used despite being a
security risk?  I don't think it is a high risk - fewer people would
be generating certificates that explicitly request an older algorithm
but not following all the recommended steps, compared to the more
common case of people following your documentation and getting the
newest defaults that just work; anyone determined enough to get an
older algorithm deserves the breakage if their explicit instructions
to override the default are weaker than normal.

In saying that, I'm hoping that gnutls still diagnoses certs that
cannot be properly used for the purpose at hand (whether or not the
'key encipherment' bit must be set or cleared), even if it gives a
less-than-stellar diagnostic message about rejecting a cert.  If I'm
wrong, and an incomplete cert with an older algorithm but missing the
bit turns into a security bypass, it's much more than QEMU that would
be impacted.  So, I'm comfortable with:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


