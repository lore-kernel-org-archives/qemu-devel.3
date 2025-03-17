Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B557C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 04:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu28X-0001iE-W8; Mon, 17 Mar 2025 00:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tu1zB-0008TQ-9F; Mon, 17 Mar 2025 00:21:58 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tu1z9-0000hA-O8; Mon, 17 Mar 2025 00:21:57 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22403cbb47fso68099115ad.0; 
 Sun, 16 Mar 2025 21:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742185313; x=1742790113; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ICspqdLfGPu7MEZoMgsn5HQu4uodzX6/IROIWZG4fxc=;
 b=TRrmYwJwQX3HEBcn1cwJzWC6QE5pVbBay0KhIZ1/sRCnMycDYJKIp03rapmDxb6VJy
 x7l6qpP225Ypnf52gLWlj4zhzXiPr9NIjiPlrLaiIBk8EYcfhD1MRQ8qnW1jKhDnI6w+
 JTGGM8s97J/x9nKF44HtY3/SCp7dw4dLk1vSSoBZMF3VPnOC4WClPHy5x34m7Mr8Lf9r
 tsHgefyACE1N8zhdBmRSjezdlM34HJg4ZSfOaFNICo8CzXbkjFyBo0g8EGF+/kNzmQbK
 vz63TSi8sF0PEdx6krekj0383dEFMBCI+hh0Q2/89j4R28v5r5NfvQV0wuehn1/rCvr7
 ru+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742185313; x=1742790113;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ICspqdLfGPu7MEZoMgsn5HQu4uodzX6/IROIWZG4fxc=;
 b=BZtz/ap0Z/EnULLmmxffML3dTRskT8TV0VuyYstgNIF0KVWGw/lTy0igz42S9nJzb4
 zpzkW9XuUVB00SgWDkgVZrGe/avoTDK26JkYXUfa3J6MInzE6ya/v5g0MRyTgw00+JfY
 5WHWk0pK1bADANQcBmO+1DdvnNyUdJEp9eKR9vRIBnul5B7WHraB1EA6RulEKUezlVBw
 lKoaqRTQZwy/uu6zJV1RPVGHddLsoAywdoGhgwDh6KVIIz221Eb7ZSJEOcewDmCMBOL2
 OmSArcmcgYrKTR+cxCYQfYMETmzdkkpgAVJ6A8caHHgxDY1q5UrKCvMg0GW/1xZLJzRf
 3m/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVToLKXWBE/fXHBhZ+bYYvZa1/MFnEe0mIYPBkFg8BcahYoHqa9dnirK54ctKZrw/g/ftnpTvjiPks=@nongnu.org,
 AJvYcCVUFQqLPWeKCS5ZPu/vJ9qLQvVtznvE8wTuy6u8mc9UZZTfRz7NX3nkEYnwVLR9gSvvVaO814UVA+HP@nongnu.org
X-Gm-Message-State: AOJu0Yy8sHK59bhgJ64s+9ZvMeCQP59qJaO8pRurfKq48EXsB87Sqfko
 SKvxMH873ZRX7T6jVI06QVQxj2zzXTrPfueGjxJPu8as/qQxCZxM
X-Gm-Gg: ASbGncvPW15rrjI7t3fflnUMv6hRr8CmeYZlEl5RIPXxUyZOQlAL1sqpyNo4WeMAJSD
 vmZQ18kZ7R7DJDXpjLawTxD5yo0vmA0Sz7RUS+p0iBc3TT+S+cMOKHDRiKSevDwxBkwf7TBu5B9
 5FYK1WHa4pZDOhyJT+Gm/DToGiSzI5cqrrQsRucf7S3eJ6z1aKijmygrzQKsNLHinAiuSoykYWE
 vGojMHp/OprNraW25ok0KyajV1t8CaeLEYmn6YuBDOEHXENWOFiKM/aGLe7y9GKECApuZZaLc10
 4ZbtsXiG4Y+8Qb2KkPkLAmYYPYy1yxQm+oOdK2Y=
X-Google-Smtp-Source: AGHT+IFGj9ITzTNabyd64VJNRO+izzRFDoHaLmmFbtPOWS2eu6oMQBwlX5JL3ew6RB7Bs1QHPt8Gtw==
X-Received: by 2002:a05:6a21:6191:b0:1f5:7862:7f3a with SMTP id
 adf61e73a8af0-1f5c121e71cmr15955752637.14.1742185313448; 
 Sun, 16 Mar 2025 21:21:53 -0700 (PDT)
Received: from localhost ([118.208.135.36]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167db05sm6799700b3a.92.2025.03.16.21.21.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Mar 2025 21:21:52 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Mar 2025 14:21:48 +1000
Message-Id: <D8I95DKVY8MV.2C4QYAQI25GHI@gmail.com>
Cc: <clg@redhat.com>
Subject: Re: [PATCH] ppc/amigaone: Check blk_pwrite return value
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250314200140.2DBE74E6069@zero.eik.bme.hu>
In-Reply-To: <20250314200140.2DBE74E6069@zero.eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat Mar 15, 2025 at 6:01 AM AEST, BALATON Zoltan wrote:
> Coverity reported that return value of blk_pwrite() maybe should not
> be ignored. We can't do much if this happens other than report an
> error but let's do that to silence this report.
>
> Resolves: Coverity CID 1593725
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  hw/ppc/amigaone.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
> index 483512125f..5d787c3059 100644
> --- a/hw/ppc/amigaone.c
> +++ b/hw/ppc/amigaone.c
> @@ -108,8 +108,8 @@ static void nvram_write(void *opaque, hwaddr addr, ui=
nt64_t val,
>      uint8_t *p =3D memory_region_get_ram_ptr(&s->mr);
> =20
>      p[addr] =3D val;
> -    if (s->blk) {
> -        blk_pwrite(s->blk, addr, 1, &val, 0);
> +    if (s->blk && blk_pwrite(s->blk, addr, 1, &val, 0) < 0) {
> +        error_report("%s: could not write %s", __func__, blk_name(s->blk=
));
>      }
>  }
> =20
> @@ -151,15 +151,17 @@ static void nvram_realize(DeviceState *dev, Error *=
*errp)
>          *c =3D cpu_to_be32(CRC32_DEFAULT_ENV);
>          /* Also copies terminating \0 as env is terminated by \0\0 */
>          memcpy(p + 4, default_env, sizeof(default_env));
> -        if (s->blk) {
> -            blk_pwrite(s->blk, 0, sizeof(crc) + sizeof(default_env), p, =
0);
> +        if (s->blk &&
> +            blk_pwrite(s->blk, 0, sizeof(crc) + sizeof(default_env), p, =
0) < 0
> +           ) {
> +            error_report("%s: could not write %s", __func__, blk_name(s-=
>blk));
>          }
>          return;
>      }
>      if (*c =3D=3D 0) {
>          *c =3D cpu_to_be32(crc32(0, p + 4, NVRAM_SIZE - 4));
> -        if (s->blk) {
> -            blk_pwrite(s->blk, 0, 4, p, 0);
> +        if (s->blk && blk_pwrite(s->blk, 0, 4, p, 0) < 0) {
> +            error_report("%s: could not write %s", __func__, blk_name(s-=
>blk));
>          }
>      }
>      if (be32_to_cpu(*c) !=3D crc) {


