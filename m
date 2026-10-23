Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DF6606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 20:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fWDIrzzc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKLZA-0007Jd-2E; Fri, 23 Oct 2026 16:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xKLZ5-0007J5-BH
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xKLZ3-0006Yx-Nm
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792786110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4mxiMBpV+KgG9nak14Q7QLIPkpG9lOuCXWjXGSZDYls=;
 b=fWDIrzzc+j4evYqV1PpafEkwUgExoKueNsA6A1da6iuCzSvDCWmc8CdVP6OcMW5VP2H3rI
 yKHcOiERKUBBS7oBC8a7EhAS5j0EJNBRVZd6gRiIXs0FhamU9ka+HYvAzu/GSKYEdQOYra
 vOln6rNRNs4XlKKNUbKBzAXnpUak4yM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-VI1UZ6o5POmsLX_rWrLXtA-1; Fri,
 23 Oct 2026 16:08:29 -0400
X-MC-Unique: VI1UZ6o5POmsLX_rWrLXtA-1
X-Mimecast-MFC-AGG-ID: VI1UZ6o5POmsLX_rWrLXtA_1792786108
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F3641955EB1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 20:08:28 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 84FBF1956088; Fri, 23 Oct 2026 20:08:27 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] crypto: avoid overwriting Error object erasing keyslot
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
In-Reply-To: <20261023141303.163893-2-berrange@redhat.com>
References: <20261023141303.163893-1-berrange@redhat.com>
 <20261023141303.163893-2-berrange@redhat.com>
Date: Sat, 24 Oct 2026 00:08:21 +0400
Message-Id: <179278610144.473507.3670274283995738536.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2565;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=suLoaaWhadZY8+MUOZWKykKGOCNWZvH3v5IOL4IsgRk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2764gVF5qwRVysa+NfaS68saWm7tBMVy+h4mp
 CGfi+vhpz2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatu+uAAKCRDa6OEJdZac
 5TpwD/40Xplto6S800nUZhHDd0pToW6Kl+SeG7EFMmYytpNNM1rEIpaZMB5vz48hOk/r6ipiWmX
 2U8Up47dAFYkSZKTh3etw3au28X23u4RFBhSQUaW5oAo8FfR6Daab7C1oMz5Sy7qBSo1IEB0/K/
 DD9FVumxGmaYnAEodvrnfgi6cj6KSy17n4KTg9/QQfAHf7/zFuB7t7BHZilTuq72/8WAMfQyRhe
 tV/7feF2iGVvGg1cztgYoQ+K1Lmlp5QckON7Ybk1l8jLE+3+ex/lFUHOWoSRZIdhlslW/cwjz1v
 Z3y8I94hiJ1s5XIZmFjas+u8egSwSS6FjY5YnXiOdB0k88K49WzxplrqIZqVdJ/1U34utMp9UHP
 37IwlIJxHY+U8QYxvNe++36r2S9YmqKf9sURsRfdQDP9Wt+H4MvcvigQw8hj5Hx0St8WxqymJ20
 JQOC6zqFhsM7ZME3gIrpPN97pYO0fMZdBmhXixuPQYCUQKdg5Bl8OahKx2clKZY6v+BND0CD+rH
 bNSaBQq0CAi5lU/m0B69p1vZprGZBDW8oj9JnVxw95sI+3tL5IYRbXp7da37SaRYzDi4IjekIyQ
 6BGlCnvl0XrNO2z1viJraXcCLysGx3o2vg4xOomYaXrUFaCooKgjBfbAlEuhjq/cWC1H3m+NMcP
 0WWs1GlBiHGirYw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> When erasing a keyslot we deliberately ignore some errors and
> carry on trying to erase as much as possible. This results in
> overwriting Error objects and triggering an assertion. Don't
> pass in the &local_err, if errp is already set.
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/4697
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20261023141303.163893-2-berrange@redhat.com>
> ---
>  crypto/block-luks.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index 0926ad28f0cd..8a1df846a146 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c
> @@ -1152,22 +1152,29 @@ qcrypto_block_luks_erase_key(QCryptoBlock *block,
>  
>      if (ret < 0) {
>          error_propagate(errp, local_err);
> +        local_err = NULL;
>      }
> +
>      /*
>       * Now try to erase the key material, even if the header
>       * update failed
>       */
>      for (i = 0; i < QCRYPTO_BLOCK_LUKS_ERASE_ITERATIONS; i++) {
>          if (qcrypto_random_bytes(garbagesplitkey,
> -                                 splitkeylen, &local_err) < 0) {
> +                                 splitkeylen,
> +                                 errp && *errp ? NULL : &local_err) < 0) {

I think the current code was simpler. error_propagate() will simpliy discard local_err if errp is already set. It is just missing "local_err = NULL;"

>              /*
>               * If we failed to get the random data, still write
>               * at least zeros to the key slot at least once
>               */
> -            error_propagate(errp, local_err);
> +            if (local_err) {
> +                error_propagate(errp, local_err);
> +            }
>  
>              if (i > 0) {
>                  return -1;
> +            } else {
> +                local_err = NULL;
>              }
>          }
>          if (writefunc(block,
> @@ -1175,8 +1182,10 @@ qcrypto_block_luks_erase_key(QCryptoBlock *block,
>                        garbagesplitkey,
>                        splitkeylen,
>                        opaque,
> -                      &local_err) < 0) {
> -            error_propagate(errp, local_err);
> +                      errp && *errp ? NULL : &local_err) < 0) {
> +            if (local_err) {
> +                error_propagate(errp, local_err);
> +            }

Same, I dont see why that's necessary

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


