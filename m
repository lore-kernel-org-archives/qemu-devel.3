Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BC7CE7B0F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 13:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJu22-000460-0D; Fri, 14 Nov 2025 08:40:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJu1x-0003vw-Kd
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:40:01 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJu1w-0000lG-2M
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:40:01 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-63bc1aeb427so1736529d50.3
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 05:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763127599; x=1763732399; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6jl37oHii/DIxVLwvpLSaLzB1Bmy1S8pFv9W4qvGKEM=;
 b=RfznKRZWKlGLSFUfHtQZS0lLMeWbKKIdXaeaGb4wK4e3/y6SiWyFzHnLcLZSPeHk3p
 ABzDGoGZgAoTo+d9a4IVsO7O3wNFYCIpCqalUlPSbGtaHd4txqyZE2gxhN9eAI1wTqVf
 whH20PKB2zoEdPjGquDtK3QzxNsjYtlj9vkKcqUMKZ1Fo+rRhSxpR79vXnipNocXwTV/
 h2DgQ764HttThy2Q7EjS7RSGHHkIb4cUoNSE2iF7b0KnjLyQ/YuJsaBPD/asX+sPvM3S
 L93KLdb/lyw4Syt2qR8ce6iK7we2Uh682Fe+lqYPCxyOLWNn4epYlzjHO5jPd36/z871
 gaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763127599; x=1763732399;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6jl37oHii/DIxVLwvpLSaLzB1Bmy1S8pFv9W4qvGKEM=;
 b=AAnWAbfMK7reVmGYNfsxBRX0ZVDMpK8le+JuAeNlKSRoZEN2ASwk8i+kAvEK2Nw3Wy
 DdtaD2EArf91Da9ssmjzDxYhui+L1oRBTeJ35Bi/HZAflDIwJHyyld62+lqoCYlJ8dmg
 cS0dGDddr0PTKD8ejdDUSTsrsYVgY4AsQ3BJoIriXplq8F4dJuto1PxGV8jesw94UBuo
 NjI11aHGXW75cpuSQcI+Fed6pRKM4AlxD+5EuqqXzmQQ2Ri7/FFLNwn83Fp7kbSEb4vm
 puiV13n/hrw8bDZvJwL10vW0b09TIETMiKOaCQyyhqGrAblbIncQIRPPugBvD23npRZt
 uE2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpX0/ZWEs5W7RlVwxoiIhFoCwga590OVBQoLez6hVeGbn3mcIwgd9JLlWv5AH40vPdNrIHvivu4ss7@nongnu.org
X-Gm-Message-State: AOJu0Yy4sofP9aL2DQAjusLyHvvwRLdnKwIoTxdE1Tks2Hca8LIBXCjD
 knIYOdy8rWF7jxLscxv9WHsKmoVFH9+33263jm6Lia3HANzdDHCB7M+3XrNrR8rhBrGAlC2dFlv
 6N7ka6PNfUqiWdwpHHHFaBU11e78uVrSlnP4kJ7327Q==
X-Gm-Gg: ASbGncv4sIlXhVjYZVECF2KvS21PJKTWm+eGVQZNlxJJWbXxwC1MYT0kAK4OYRWTIbB
 e5LFPaB2Slgwil/XGElwdQ+gkW0+42TrHmNGqgLuMEU8dz15ZtxWLgmO41LKS9iymdJFIRtHDSW
 MoUM7nsqKMNizDlpZ1qTKh59s5U2F7sjvGiChwI9CeULswjv3AX0vTNyQFFDvu6Yz5V6roDVQRJ
 xXWyWnZDPJbY7/XQP1BenYp7/MYjjRM/5nAqdWJtuXLHeQOVqY8IPAaAHe4zni0ojF/xmzJ
X-Google-Smtp-Source: AGHT+IEP/xcDIZixMX8O9WPJiyMNnhFQjhMglmBxIKE6CeohUV6P8bx+RkeCi9txOL8tSVD0BoYBcPBBCXRKTrpF7n0=
X-Received: by 2002:a53:d057:0:10b0:63c:f5a7:402 with SMTP id
 956f58d0204a3-641e76561eamr2154975d50.54.1763127598766; Fri, 14 Nov 2025
 05:39:58 -0800 (PST)
MIME-Version: 1.0
References: <20251106072818.25075-1-zhaoguohan_salmon@163.com>
In-Reply-To: <20251106072818.25075-1-zhaoguohan_salmon@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Nov 2025 13:39:46 +0000
X-Gm-Features: AWmQ_bnibtEUyNBGrExc6YBi2sUcAlbg0xcPORXfpM1jRDgeULh0lupb7314kC0
Message-ID: <CAFEAcA8iWqAgZzH7u3jYTEb-fjjsBWAp3WJY24xAKN8CpdVw9Q@mail.gmail.com>
Subject: Re: [PATCH] hw/sd/sdcard: fix potential out-of-bounds read in
 rpmb_calc_hmac
To: zhaoguohan_salmon@163.com
Cc: philmd@linaro.org, bmeng.cn@gmail.com, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, GuoHan Zhao <zhaoguohan@kylinos.cn>, 
 Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Thu, 6 Nov 2025 at 07:29, <zhaoguohan_salmon@163.com> wrote:
>
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
>
> Coverity reported a potential out-of-bounds read in rpmb_calc_hmac():
>
> CID 1642869: Out-of-bounds read (OVERRUN)
> Overrunning array of 256 bytes at byte offset 256 by dereferencing
> pointer &frame->data[256].
>
> The issue arises from using &frame->data[RPMB_DATA_LEN] as the source
> pointer for memcpy(). Although computing a one-past-the-end pointer is
> legal, dereferencing it (as memcpy() does) is undefined behavior in C.
>
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
>  hw/sd/sd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 9c86c016cc9d..bc2e9863a534 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1161,7 +1161,8 @@ static bool rpmb_calc_hmac(SDState *sd, const RPMBDataFrame *frame,
>
>          assert(RPMB_HASH_LEN <= sizeof(sd->data));
>
> -        memcpy((uint8_t *)buf + RPMB_DATA_LEN, &frame->data[RPMB_DATA_LEN],
> +        memcpy((uint8_t *)buf + RPMB_DATA_LEN,
> +               (const uint8_t *)frame + RPMB_DATA_LEN,
>                 RPMB_HASH_LEN - RPMB_DATA_LEN);
>          offset = lduw_be_p(&frame->address) * RPMB_DATA_LEN + sd_part_offset(sd);
>          do {

What is this code even trying to do ? We define a RPMBDataFrame
which is a packed struct, but now we're randomly memcpying
a lump of data out of the middle of it ??

The start of the struct is
    uint8_t stuff_bytes[RPMB_STUFF_LEN];  // offset 0
    uint8_t key_mac[RPMB_KEY_MAC_LEN];    // offset 196
    uint8_t data[RPMB_DATA_LEN];          // offset 228
    uint8_t nonce[RPMB_NONCE_LEN];        // offset 484

so frame + RPMB_DATA_LEN (256) starts 28 bytes into the data
array; and then we're copying 28 bytes of data?

The existing code (frame->data[RPMB_DATA_LEN]) doesn't make
sense either, as that's a weird way to write frame->nonce,
and the RPMB_NONCE_LEN doesn't have the same length as what
we're copying either.

Can somebody who understands this explain what this code
is intended to be doing ?

thanks
-- PMM

