Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E74CA0FE0
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 11:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjzUY-0003Ic-9D; Fri, 30 Aug 2024 07:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjzUW-0003Bs-JX
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjzUU-000656-Ly
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725016107;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=FQt9VQxn2dlhs5gj5G2FeY+W78UI+q2R099do50/Alg=;
 b=JJk9OwP3iQXMVpDOwQ4gEiYGRTb9WtLDU3rN3yl1Cc1isyYuUlIgD9k+1u7EJfrGUbp9NQ
 DUoPo4ee+JJmWSGiOpWbmgfZAOwF7HJqMuC9CmPC/rQyv3eP57CIsSoDtP8JOgg/UljSYj
 VglD8ufKXjVKYSqIx/Jp2CcZc3UFmmM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-d-0vf9CPPFKpdlKc09dE8g-1; Fri,
 30 Aug 2024 07:08:24 -0400
X-MC-Unique: d-0vf9CPPFKpdlKc09dE8g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60BCB1955F42; Fri, 30 Aug 2024 11:08:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.49])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3852300019C; Fri, 30 Aug 2024 11:08:21 +0000 (UTC)
Date: Fri, 30 Aug 2024 12:08:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Tiago Pasqualini <tiago.pasqualini@canonical.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] crypto: run qcrypto_pbkdf2_count_iters in a new thread
Message-ID: <ZtGoIvroHBwF53oF@redhat.com>
References: <20240813131928.842265-1-tiago.pasqualini@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240813131928.842265-1-tiago.pasqualini@canonical.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Aug 13, 2024 at 10:19:28AM -0300, Tiago Pasqualini wrote:
> CPU time accounting in the kernel has been demonstrated to have a
> sawtooth pattern[1][2]. This can cause the getrusage system call to
> not be as accurate as we are expecting, which can cause this calculation
> to stall.
> 
> The kernel discussions shows that this inaccuracy happens when CPU time
> gets big enough, so this patch changes qcrypto_pbkdf2_count_iters to run
> in a fresh thread to avoid this inaccuracy. It also adds a sanity check
> to fail the process if CPU time is not accounted.
> 
> [1] https://lore.kernel.org/lkml/159231011694.16989.16351419333851309713.tip-bot2@tip-bot2/
> [2] https://lore.kernel.org/lkml/20221226031010.4079885-1-maxing.lan@bytedance.com/t/#m1c7f2fdc0ea742776a70fd1aa2a2e414c437f534
> 
> Resolves: #2398
> Signed-off-by: Tiago Pasqualini <tiago.pasqualini@canonical.com>
> ---
>  crypto/pbkdf.c         | 42 +++++++++++++++++++++++++++++++++++-------
>  include/crypto/pbkdf.h | 10 ++++++++++
>  2 files changed, 45 insertions(+), 7 deletions(-)

Mostly looks good, but one minor issue...

> diff --git a/include/crypto/pbkdf.h b/include/crypto/pbkdf.h
> index 2c31a44a27..b3757003e4 100644
> --- a/include/crypto/pbkdf.h
> +++ b/include/crypto/pbkdf.h
> @@ -153,4 +153,14 @@ uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgorithm hash,
>                                      size_t nout,
>                                      Error **errp);
>  
> +typedef struct CountItersData {
> +    QCryptoHashAlgorithm hash;
> +    const uint8_t *key;
> +    size_t nkey;
> +    const uint8_t *salt;
> +    size_t nsalt;
> +    size_t nout;
> +    Error **errp;
> +    uint64_t iterations;

Super fussy here, but lets make 'Error **errp' the very
last item in the struct.

> +} CountItersData;
>  #endif /* QCRYPTO_PBKDF_H */

...this should remain in the pbkdf.c file, since it is not intended to
be part of the public API.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


