Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B78105F79B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 11:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w10cJ-0003HL-Tg; Fri, 13 Mar 2026 07:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w10cG-0003H1-Gv
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 07:23:40 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w10cE-0001Np-Ee
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 07:23:40 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64ad79df972so2402468d50.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 04:23:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773401017; cv=none;
 d=google.com; s=arc-20240605;
 b=guPl63g264+IO+yfaC1IElZuGzvojvsLfHx2OvtKj5Vu2fhYw28k+52h154p2CGR0X
 4Y5GEAxz2oFamEUP/S6w9841fATy3uU2kHcRIheo6ahYRMNUrizFN1Safx2VIBuMliSj
 jR0i5REBehgaeOJPbjhv4n53ndE2u906gDkNeFTuMTy1Op4n2KJW7q8OUY+6PlMXUbxe
 p2xnVTBiJM2ssj5Tt7DPZyJdFOJnOgdzebg6OPIfC+Lh+ojc7uLnhzA+SU8eQMhJ5L2F
 V4cUO0weR+tYJUf7CKr9y51UEoLNaEbmYoWBCrzEm3bQtxu9s4p4LWoA1X1nSjm+C45y
 2qog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jIIbFzv9+nlk5uUqecp4x0ZPZ8Bzd4r0xHj2cV6GfAA=;
 fh=TI5KUJ7nZ5i/oZzH/JVeDu8repzAGZFnBS9WrD4PI+g=;
 b=Hgm37IPkcZCUk6R5cWhpZM0EIqsfn98k78dmJFVo03BdoQUi38wWalX7OByDfTzFBr
 Efv07xVdr7RI5BHLB5fiwp0k+6bwXF3MmjXjrGbjtKEgv9nyCYcXUk+u++AvNW7rWibd
 8DvW56Puc3Nbox6UVaeKxS3WjQLmI2wYFfiCLNavoAwOElas/DUPbnlfSqQPCAo35TIC
 d/w02mWvHJ9TYaiBg0q/RkJf2EE2CXCE7Zz62OG2FVx5uxHG+UdEo/lpb9vy/vpcvE52
 wLI7CZqDSTbYoKoxXvSRICgaYfVgQFWktxCl9ERGwL6b+8iZ5ESxui+8ycmH6mpUyXcX
 XO4g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773401017; x=1774005817; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jIIbFzv9+nlk5uUqecp4x0ZPZ8Bzd4r0xHj2cV6GfAA=;
 b=Lro75AjNjSoUUe1a7ph9EQDTD2un/MKtRVUSNmOOa77Mc+G7lfnul0+qdmt0WLUvD6
 k5DqOentpjawXDBkTHf+ZOOnLXX6wkEXpkeT+jaa+SUnh4mX9eceq6SMfGRRNf8hLbHg
 a5d1igVGQOcQxh5ygv3NXbdZVikrYFDvI3SQs6nqU1nHkRfv7CmR7hu0Z5gPPCYM1rfH
 3Ovql9OCt0in5bfeAArDeJ00BPRdMwAQpdS81VgGGyd2UrJ+F9kIMB/Atoh8LFJwUmxT
 EH2z+3qFXIcLhsTW6wqYl+s6DnCiPuvf3PagVISz68ZHGDzk/+4GWXd+wkmYJqIer/RG
 /ZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773401017; x=1774005817;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jIIbFzv9+nlk5uUqecp4x0ZPZ8Bzd4r0xHj2cV6GfAA=;
 b=TvDKj7vm6iGXDc9xoEqTqzcesADZGyNBAMhCzZxc/Hx/E3PF9qM7/gDkNrW88uH4SM
 iTnwNz7v+wIWqkYjHchrNuXxm4lxSX7RVNXzolnDdZA0Yan5uK8BUiblLQdFnM9jGZnc
 b0z2/LAFDCk8o6+KpRt8ZwlK6lz1cXuylqo+Af0OBQg6ZONgSFQh1xrx7xNTzHw7EY3Y
 gee1HwrBzj5SEGQUbj03T5wcej+2xzfZir285K+i6iB8PU7VwDVlLQ/Y01tTMLlCxJwO
 ORiEBxnopd5dqi4hxU+lsegveua5PlUjIJeBnnyqhQo25uVO91tcawEbirQjPjB6pzNT
 9CYQ==
X-Gm-Message-State: AOJu0YzhHivqm7i/y3jldX9+3aq8YQwxKqmLPVyC4mR1pNKpmN1tnYBE
 Sn2Syuk7Kk63DJy8yjLUKOADFG6ubkmJLy5RNiw9VGiu5QOGrAlJ2BLGpEgSAqDyXMq+H7ddNSF
 MDEMH1hcTTD+JLE4cA8plPI03eEmIPm1b/17E9Xl5vw==
X-Gm-Gg: ATEYQzzFRki+PA8o+EujVdPK+48Fopiqy8bm07Dx7yCDJuHz16tug/pwa9aaCCQZK+F
 JMidsWL0lYsxfpgcnHdDjeXA0Hu2AsutMYBE+1JRzCrFWFik8vN2dJPsjh0MX/vMN45Wt0V/xJD
 Xq22G/cZozaHrkHIuanVhEf9VS4xYs0Q00DsT2mhv0KsDIfFmLpvQORtIqtXQc8XI4kOflA62tZ
 zYTuUKKrkHIxqQUtm7GGRAgdS343mOx55eHu3V4Wwvatcs6pRAqVj20V/GvTmb0KQQDD1hKIeR5
 MYay20beVhWCXY/j28BfnPod1+6Ec+EAhEiFsNFzw9MHjc3pMFMOVybV7sMrHVAp75c=
X-Received: by 2002:a05:690e:4190:b0:64c:9a66:9a13 with SMTP id
 956f58d0204a3-64e62cf446dmr2859163d50.0.1773401017097; Fri, 13 Mar 2026
 04:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1773236195.git.1774596582@qq.com>
 <tencent_7A1227883216A4103DA25F5A585E86DFE307@qq.com>
In-Reply-To: <tencent_7A1227883216A4103DA25F5A585E86DFE307@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2026 11:23:25 +0000
X-Gm-Features: AaiRm52x3JsfREpaiTVY6zqSpcaFIngynQl7BNdRnWD9XJScplkfnpho7tEUjJM
Message-ID: <CAFEAcA8wbcSdkn0dje0-sq4xM=2Bgf1DqPmG7iNLNQ8R1ao7ZA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] An interrupt is generated after the DMA transfer
 complete.
To: 1774596582@qq.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Wed, 11 Mar 2026 at 14:25, <1774596582@qq.com> wrote:
>
> From: TaoDing <1774596582@qq.com>
>
> PL080 cannot trigger interrupt correctly. Reproduce this problem in a simple way.
>
> In the versatilpb board, the interrupt output of pl080 is connected to the 17th interrupt input of pl190.
> By reading the status register of pl190, determined whether there is an interrupt generated for the corresponding input.
>
> The basic address of pl080 is 0x10130000, and the basic address of pl190 is 0x10140000.
> Read the value of the address through the qemu monitor.
>
> Configuration
>     ../configure --target-list=arm-softmmu --enable-debug
> Reproducer
>     ./qemu-system-arm -M versatilepb -m 128M -nographic -S \
>     -device loader,addr=0x00000000,data=0x11223344,data-len=4 \
>     -device loader,addr=0x00001000,data=0x00000000,data-len=4 \
>     -device loader,addr=0x10130030,data=0x00000001,data-len=4 \
>     -device loader,addr=0x10130100,data=0x00000000,data-len=4 \
>     -device loader,addr=0x10130104,data=0x00001000,data-len=4 \
>     -device loader,addr=0x10130108,data=0x00000000,data-len=4 \
>     -device loader,addr=0x1013010C,data=0x9e4bf001,data-len=4 \
>     -device loader,addr=0x10130110,data=0x0000c001,data-len=4
>
> Qemu monitor
>     (qemu) xp /1wx 0x10140008
>     10140008: 0x00000000
>
> The result correctly after fixed
>     (qemu) xp /1wx 0x10140008
>     10140008: 0x00020000
>
>
> ---
>  hw/dma/pl080.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
> index 3f8acb03de..1a39954f04 100644
> --- a/hw/dma/pl080.c
> +++ b/hw/dma/pl080.c
> @@ -309,6 +309,7 @@ static void pl080_write(void *opaque, hwaddr offset,
>          case 4: /* Configuration */
>              s->chan[i].conf = value;
>              pl080_run(s);
> +            pl080_update(s);
>              break;
>          }
>          return;

I just noticed that you used a slightly different fix here
from your other version of this patch:

https://patchew.org/QEMU/cover.1773301927.git.dingtao0430@163.com/7584486ba62bc6d767c0d132dc843067f8c5efff.1773301927.git.dingtao0430@163.com/

where you put the pl080_update() call into pl080_run().
I think I prefer this one.

For future patches, please if you're sending a different
version can you make sure you mark it as "v2" etc, so
reviewers can see that it's different, and note any
interesting changes from previous versions in either
the cover letter or below the '---' line in the relevant
patch?

thanks
-- PMM

