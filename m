Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92288D44C5A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 14:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgOZ9-0001vF-Ko; Thu, 15 Jan 2026 09:43:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgOZ8-0001rD-IR
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:43:14 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgOZ6-0000sC-Ud
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:43:14 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-78fba1a1b1eso14623007b3.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 06:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768488191; x=1769092991; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yGYX73FexNOZzJXnqTQjYpmSrqQbh8LUca7FoXltfRE=;
 b=ge0sG5Awg/OXBNAWbXj3geU5C8+wRNhVNZOokG3DTz5qE/jHr+Vbs07lSA4w36B4b2
 jG9YaeZq3idbvZFefqxzq8T5K/M3Skx47lEnZHdisyQOvT6NyFj65rrDoCjMk6Y/OCTt
 87qV/dQLlX1xz6VEq/oYZTwipXoLvAdrjKwSN0qjU4k97icz5IetKnqDWtc++pJt2aZk
 oRu5M03zFsafAGpgTRIYJUGhAnYgHcG1VkYUQUIKDbdpnKI/qcjZeI1vDWjYIG0qzJqD
 j77dfPA0iDkPP1xn82g9KvUcuU1ZFtw3fGUyU1SfOKL7ATQFPC3Z8dnKPDVjHhFdeANK
 +13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768488191; x=1769092991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yGYX73FexNOZzJXnqTQjYpmSrqQbh8LUca7FoXltfRE=;
 b=xN5BwK4lnVJO5EVTh7YFqfIfGzin3Lr8LpEKazj8kG53WeF/q9abf3fg/UKY9ekCC3
 04cCDeofjEeWNg7TnoS2dsUk/J55dgm7Lp4e+ZKeFgk0CTFY05iM+FFiPr3/whlqKLX4
 JGpjvThAJ2eb7rhxm9tJcGbvMZhObhLOajVkprWj+15UZll3lJhBw6iSXUtt8Pasuxfg
 VmOzgYHt7HsXBGiJQ1s0COcoTt7fHjKVlEdv/m8Tcr1h8/zQH2rc0cEB8050cd8gy0ii
 Zs9fsf0hogwLldMRb2tCvA0aIrlKKKEf8PTRJK+XTxeJandbF52WtaWo5iZNkzgvKUOG
 135Q==
X-Gm-Message-State: AOJu0Ywt21vf/qFpX17FFdHt4/9BtE5tCMVqdvMtwQefxbeOupKkNDaU
 ZMHjjMKuLyGDIlOStHJ95BUEjNVzvNI7Hk5JA3KL1ptHh7oFtlj0OG9qX8uLsxeWt3FLBHhFM1x
 8PA00Ew7Xy1qU94wSl4TmPL9UTEgUOCkMRpcmNi7Hvg==
X-Gm-Gg: AY/fxX68bzBcoblycHhAhrvZunsI8dyVlp7Za5JwmVrFERpxtYDBS21SNuk6Gfg0Jtx
 x6C215cporOHgWErDs99RkFBTRXPwf1rM0G7v0J+9/68WzN8Rgz3f7jZMD9WlsthB0LlMI5hetB
 usrAhr8zMgEAloofq0o4bj1isNu54CM/8GZQoINch1HbdhQSGUkapCGt+eBsO6NsDqWC5CRdval
 Pl5yjZR1IMBae2KrLu2o/AsNPxiDGDIbrcaaCR4fQ0B9GTcNs72+6TceYurgBOy3pjN8LQAZ9fh
 InKgqwZs4lkAwYaU0ajqJKc=
X-Received: by 2002:a05:690e:134b:b0:644:5317:4bd1 with SMTP id
 956f58d0204a3-6490a608ffbmr2271918d50.9.1768488191269; Thu, 15 Jan 2026
 06:43:11 -0800 (PST)
MIME-Version: 1.0
References: <20251204093502.50582-1-corvin.koehne@gmail.com>
 <20251204093502.50582-12-corvin.koehne@gmail.com>
In-Reply-To: <20251204093502.50582-12-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Jan 2026 14:43:00 +0000
X-Gm-Features: AZwV_QhU-36j7qQeSvQxqeU3zKHVzKRM4P04LJxfIOFXxOo0WCI_KbEFCdCsdOk
Message-ID: <CAFEAcA9pELkMfgcB-0WSjy2gf4T=Pn38pPRfd3wz7K0MYQHYVQ@mail.gmail.com>
Subject: Re: [PATCH v5 11/15] hw/block/m25p80: Add HAS_SR_TB flag for
 is25lp016d
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, 
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 4 Dec 2025 at 09:35, Corvin K=C3=B6hne <corvin.koehne@gmail.com> wr=
ote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> The is25lp016d has 4 Block Write Protect Bits. BP3 specifies
> whether the upper or lower range should be protected. Therefore,
> we add the HAS_SR_TB flag to the is25lp016d flags.
>
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
> ---
>  hw/block/m25p80.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index a5336d92ff..1df223ee81 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -217,7 +217,8 @@ static const FlashPartInfo known_devices[] =3D {
>      /* ISSI */
>      { INFO("is25lq040b",  0x9d4013,      0,  64 << 10,   8, ER_4K) },
>      { INFO("is25lp080d",  0x9d6014,      0,  64 << 10,  16, ER_4K) },
> -    { INFO("is25lp016d",  0x9d6015,      0,  64 << 10,  32, ER_4K) },
> +    { INFO("is25lp016d",  0x9d6015,      0,  64 << 10,  32,
> +           ER_4K | HAS_SR_TB) },
>      { INFO("is25lp032",   0x9d6016,      0,  64 << 10,  64, ER_4K) },
>      { INFO("is25lp064",   0x9d6017,      0,  64 << 10, 128, ER_4K) },
>      { INFO("is25lp128",   0x9d6018,      0,  64 << 10, 256, ER_4K) },
> --
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

