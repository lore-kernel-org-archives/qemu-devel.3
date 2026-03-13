Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF7F105F7A2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 12:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w11VJ-0006LI-Fs; Fri, 13 Mar 2026 08:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w11VD-0006Kp-Vm
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 08:20:28 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w11VB-0000vO-RO
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 08:20:27 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64ad8435f46so2471054d50.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 05:20:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773404423; cv=none;
 d=google.com; s=arc-20240605;
 b=lKx106pVDISs0TjcBLRPSlTE2YgePaA3DvcAuyekTglkNBMi4Q+PxSSGKyOYyJOzNW
 zV3xrg3Vs9OUA6thQujkk0IOhcPSXY6+tCAewx5EZTSRCWis23QqpTOFO8ifjSm/uT8d
 5zHzkBsbTQqJCmC8BsN/LShOmqM3arAdfSnMUSlVi547TRdUHJBfgJdYbqyD2peDKS9W
 0Y2f3sjVXMNFDzGb6TydHarByLYzyFu5wMmywdnXOrKrKZEAfseuCixK24uylOVXWDTt
 XPWtLrjnz0mih56wh3fKjxrmkP/FpA/IKmMepwOOlm2TlBsFLScQGlI3R+rcIAVJxRBR
 MfGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PgRWUtsedyaNPnBlBSFG0BGptSwHAXFB3vUXIJ8SexU=;
 fh=gS8oh9EHdcTDcglskGyIv3/M5LtfI+jKdwGYJC227W4=;
 b=f9+6vkHTK6jVOH2My9hRyRV7UyOi9Z3FKhgDQW7HLuGf5OwcAwzyC/wOxD1qZETzsm
 QlgSnT4eU+PnDXQsPLHuPh/EXybJmZwNsqYhYlAP8GgGVdV/XfjanUXa8URN3X6KBncy
 F9XXDZAnNNg6JTHuiOsUTl06MT+jO0oaI1DD6h1NjYKMc4weBQCfQ6GNQBR7yD8xjhUd
 JC+qv353m6r/f1uI5g1L52vPHfFczw6aY/Q8ssfPFYr6jePvEuWMupebyMHikoZs+WC7
 vnEt+fUKvgWFcHaXDWf9y/9V1uJO2x2dMF5BYhbZRcbYVgQozAAS03K7OmbJP7UPeIwc
 cl0g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773404423; x=1774009223; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PgRWUtsedyaNPnBlBSFG0BGptSwHAXFB3vUXIJ8SexU=;
 b=JhSI+jt87Ayl4GW0ni2wI7+SzPnmaTkfeT9AXHSy7FH+T6Sm57PUfrhyc4t8PxOrXD
 BHldYYZWAHxsxG6AdWKtuFYuCtbvb7opmZUQhua6FtbjkCPVauzsbDk4I+jkCtwqrbUZ
 YBaoX9vxokO5Wo7r+rx2gpZ6YPly/BRDZ0alqmqw+/UQBGbl1Reyzk1bm4i+nDPyqF1o
 QEVi8AHYzfT0cBRVMx7+XcJb+6bqIh/W5lPDnjP7QKmtW0BBRr/h3fkBaTmtsSftxqea
 pszO5jclYbU9OPpsrxY46NY3w2XmDe0F1k4M1Lj+CBj/G1I3yzVGIbu2jZire+kV9zrS
 xmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773404423; x=1774009223;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PgRWUtsedyaNPnBlBSFG0BGptSwHAXFB3vUXIJ8SexU=;
 b=Ige1mq7Z8UV7lYuQbq6T+BggrvafbHI2DKa7uP2GZMvC4CabnKn64HuGmSXB6h4CDH
 /8TL9GIKrLk+Hc3GzecZGxVWKZ9JGdAf5l4tU0q46Ne/LR/96ewPhZ4yohMVpDSOOL+4
 BitsZGTnZC9EQwscKJVQHhrkaU83feyjKDS5NeAlG1Ko0pfXy7n2SjlydEwwER410QR9
 wETt02eKvVe1C8HYlui9LSM0CZZxjpt3FpRweRa0Ooh8GoXmwk9WJdyciCKVaieChVnE
 2u9kJnRtUa4Hj3tgkb6npri5FbNFR9fkVfXG73ZyF7KBngZJeJNdH67uRDiiMut8oWqM
 wfRQ==
X-Gm-Message-State: AOJu0YyZqrsOAjK8Dv0neEydWoX88kJFlsGsQgqKVtu7BOmSNVvYowbs
 /wjudCBtOoML0PZ526AHaUgZYdhntG224m0yNuJEcxqhn+3GemzRRzkQkEVQftIofVJumMM9iZG
 gQHIa1ginVFjUfhqfsd0sPpahEravl5BWJU9YtiU5zw==
X-Gm-Gg: ATEYQzxxHp7J2hMRns8+1CQVlGNIRI67dxEdWhBezCrvlA66lnN+v6dvdCU4JhJf9d7
 QrfbLgCz0pt7NnDtqVcHiHVrdTjH1ymueBIFjPSSJ92UMh/0/RqWpSngMhmHI/aqfPgzO5JCpC1
 jU4B6BKLCH69Z1ytvpbQ7uDilqXqXfQzv4j9wLsaDoIjJsN6orLac+Z6v8r/V1VMpt7OXcows4d
 pNpvLlpCaA/ma/LK8SCsnL/p+phRUgKK8Tm/bjkFdJjhYJjhrXIRn9AwUpqE+FdJUo5LGcdliuX
 AxRc5mvBZxjsHhoRMMxDgXmgwzLbDAENpU3dRXkxjwWtQ6fSvKQ2ZortsQSCHLoJ9fM=
X-Received: by 2002:a05:690e:42c1:b0:64c:bfd0:ad6f with SMTP id
 956f58d0204a3-64e62fa057dmr2433119d50.33.1773404422795; Fri, 13 Mar 2026
 05:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1773301927.git.dingtao0430@163.com>
 <97c01f634c255f3787ab8a71bfe8ccc03e8d353c.1773301927.git.dingtao0430@163.com>
In-Reply-To: <97c01f634c255f3787ab8a71bfe8ccc03e8d353c.1773301927.git.dingtao0430@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2026 12:20:10 +0000
X-Gm-Features: AaiRm507PHi0Q49DBYNuHfYHkoy2xSdRcjE4eanSYety7J-Z_SJWAe1nJU7ivNQ
Message-ID: <CAFEAcA-kBmfYzpx5WKwhy5M+zAztoMsP6NAhnoJ5S6KdxnWArQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] The swidth and dwidth of pl080 are not equal.
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Thu, 12 Mar 2026 at 08:02, Tao Ding <dingtao0430@163.com> wrote:
>
> The amount of data transmitted each time is the maximum value between s and w,
> but it should be noted that the remaining transmission amount is less than the width.
>
> Configure swidth to 1 byte, width to 4 bytes, and transfer size to 4.
>
> Configuration
>     ../configure --target-list=arm-softmmu --enable-debug
> Reproducer
>     ./qemu-system-arm -M versatilepb -m 128M -nographic -S \
>     -device loader,addr=0x00000000,data=0x44332211,data-len=4 \
>     -device loader,addr=0x00001000,data=0x00000000,data-len=4 \
>     -device loader,addr=0x10130030,data=0x00000001,data-len=4 \
>     -device loader,addr=0x10130100,data=0x00000000,data-len=4 \
>     -device loader,addr=0x10130104,data=0x00001000,data-len=4 \
>     -device loader,addr=0x10130108,data=0x00000000,data-len=4 \
>     -device loader,addr=0x1013010C,data=0x9e47f004,data-len=4 \
>     -device loader,addr=0x10130110,data=0x0000c001,data-len=4
>
> Qemu monitor
>     (qemu) xp /1wx 0x00001000
>     00001000: 0x00002211
>
> The result correctly after fixed
>     (qemu) xp /1wx 0x00001000
>     00001000: 0x44332211
>
> Signed-off-by: Tao Ding <dingtao0430@163.com>
> ---
>  hw/dma/pl080.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
> index 0979a687aa..4f97943b28 100644
> --- a/hw/dma/pl080.c
> +++ b/hw/dma/pl080.c
> @@ -160,26 +160,34 @@ again:
>
>              /* Transfer one element.  */
>              /* ??? Should transfer multiple elements for a burst request.  */
> -            /* ??? Unclear what the proper behavior is when source and
> -               destination widths are different.  */
>              swidth = 1 << ((ch->ctrl >> 18) & 7);
>              dwidth = 1 << ((ch->ctrl >> 21) & 7);
> -            for (n = 0; n < dwidth; n+= swidth) {
> +            xsize = (dwidth < swidth) ? swidth : dwidth;

I think this can be more clearly written as
     xsize = MAX(swidth, dwidth);
since we're editing the line anyway.

> +            xsize = (xsize < size * swidth) ? xsize : (size * swidth);

   xsize = MIN(xsize, size * swidth);

So this is handling the case where our destination width is larger
than the remaining amount the transfer size says we should be reading
from the source, which is cases like
"source width = 1, dest width = 4, transfer count not a multiple of 4".
The TRM is unfortunately very vague about what the hardware does here.
I think the hardware designers considered this to be a programming error:
in the "Software considerations" section of the TRM one of the items is:

 * If the source width is less than the destination width, the
   TransferSize value multiplied by the source width must be an
   integral multiple of the destination width.

> +            for (n = 0; n < xsize; n += swidth) {
>                  address_space_read(&s->downstream_as, ch->src,
>                                     MEMTXATTRS_UNSPECIFIED, buff + n, swidth);
> -                if (ch->ctrl & PL080_CCTRL_SI)
> +                if (ch->ctrl & PL080_CCTRL_SI) {
>                      ch->src += swidth;
> +                }
>              }
> -            xsize = (dwidth < swidth) ? swidth : dwidth;
> -            /* ??? This may pad the value incorrectly for dwidth < 32.  */
> -            for (n = 0; n < xsize; n += dwidth) {
> -                address_space_write(&s->downstream_as, ch->dest + n,
> -                                    MEMTXATTRS_UNSPECIFIED, buff + n, dwidth);
> -                if (ch->ctrl & PL080_CCTRL_DI)
> -                    ch->dest += swidth;
> +            if (xsize < dwidth) {
> +                address_space_write(&s->downstream_as, ch->dest,
> +                                    MEMTXATTRS_UNSPECIFIED, buff, xsize);
> +                if (ch->ctrl & PL080_CCTRL_DI) {
> +                    ch->dest += dwidth;
> +                }

Here we choose to handle the "swidth and tsize say we should
read e.g. 2 bytes from the source but dwidth is e.g. 4" case
by performing a 2 byte write to the destination. I don't think this
is what the hardware would do.

There is this interesting bit in the "software considerations" section:

 * While writing, the TransferSize bit-field is like a control register
   because it determines how many transfers the DMAC performs. However,
   during read-back, TransferSize behaves like a status register because
   it returns the number of remaining transfers in terms of source width.
   So when TransferSize is read back, it returns the number of
   destination-transfer-completed stored in a separate counter called
   TrfSizeDst multiplied by a factor.

My best guess from stuff like this is that the way the PL080 works
internally is that for each dest-write it needs to do for the transfer
it does the appropriate number of source-reads. If the guest
misprograms it such that that means it reads more than
(transferwidth * swidth) that will result in reading more data
from the source than intended, but that would be a software bug.

I would suggest doing something like that, but at any rate
commenting and doing a LOG_GUEST_ERROR if there's a mismatch in
swidth/dwidth/tsize such that we wouldn't have enough bytes to
do a full destination-write.

> +            } else {
> +                for (n = 0; n < xsize; n += dwidth) {
> +                    address_space_write(&s->downstream_as, ch->dest,
> +                                        MEMTXATTRS_UNSPECIFIED, buff + n, dwidth);
> +                    if (ch->ctrl & PL080_CCTRL_DI) {
> +                        ch->dest += dwidth;
> +                    }
> +                }
>              }
>
> -            size--;
> +            size -= xsize / swidth;

This change is correct (the transfer size field in the control register
is supposed to count down by 1 for each swidth-sized data unit we
transfer, and our loop can do more than one swidth read), and probably
the most important bugfix in this patch, because it's the one that
matters for normal correct use of the PL080.

>              ch->ctrl = (ch->ctrl & 0xfffff000) | size;
>              if (size == 0) {
>                  /* Transfer complete.  */
> --
> 2.43.0

thanks
-- PMM

