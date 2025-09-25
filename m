Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931FCCAC5B1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 16:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1p3E-00012h-7a; Thu, 25 Sep 2025 12:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1p33-0000yW-PP
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 12:42:30 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1p2u-0006gO-NL
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 12:42:24 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-71d60528734so11120637b3.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 09:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758818532; x=1759423332; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0BsKxJ8F8BEQVgPe0W0T+jLPmwKYlnkZfHox+8F8rik=;
 b=EvBRHEj0b4ac5TVRWblwVDvL9PM4lawi7pcgtQm/1BxRECkgbg3oP+/WracSMgXdeK
 ZmGm/+7OGcFSCi1g/znkBdHeBGfsHgZfKp9w6Nm/LjNLeHiGi3pmr3mLu6RGGOlwfI3b
 seko+oL2kA7skdT1qpzfbLq7u/CIuM9n6coqcKS+b2vXNDU3nO0ZBSDeBE9OxYAtv+y5
 g2anUugPtRpBC86v6Aed06iPVDmyS8YgmQk1jsboBGfmAj+cxyR6WTRqbKPd2/20TRGj
 ZIHrg/pW1TE0y3UVSPM/7GBfoQRJWktnuulXIDA07Dti9pnjPCIA6gxdrHmLe4YrczxR
 f+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758818532; x=1759423332;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0BsKxJ8F8BEQVgPe0W0T+jLPmwKYlnkZfHox+8F8rik=;
 b=c/9TYNcyojPgq3JhUuH2WalfsFxdX/Ds3mvvsxepcHiZ55O3XkEqJA4hMc1vcJahN6
 qI84cAxrlp2TM7sqZmINRhxCPpLz6518VY9wCfOHDk30eYAnsfNL7p0JlR6MbZsDChNc
 QeAvcHU2qP+mVhZ2lhLfxkbC/1396H2aWKzRbNck7WZIA/L29jWlYL7PYZXj5CoAvMyV
 ZYQzxmjphvaMpFwNQfU/MMbcrMpMndItk1iTlsh3TUuKozZ5Kt0UCLBuv6GKvCumejGD
 PC2wwF/0a7p2o0JRxNxq0GHAUxfccRAH052wTMMjhgHs3w+XYxsULwVFT5Q/lJXZO6+O
 sKFQ==
X-Gm-Message-State: AOJu0YzCe9jhkDUlDxgUUg47NmqoAFZlDtXRwD5v27tukUK5RMavTybt
 avqyfmnII3/BcyJBEbWQxByO56A+Wz0w5E4aLOwOAYU5wLEfmnJIob8+0RrrRQZO0Wsw2bCq7iy
 sOR9mKO9tZLfgeUSvhkNE8Btq0VKPPi3hqzYG9DK4CQ==
X-Gm-Gg: ASbGncuqa+c2e65Nz0WLtgVkGjP6Q55kuagMOvxcuYwCM7hQJ9nYfGQpGXAIvdZz+go
 14Vw3yky+N1YqBDm+K6S2+rcehY/gf184Ehwy/41AGblrH4ePUwZ9jT/bGroLnQjicGUV9p8uji
 j2Qn7yeT/bWqpgqI/EUrHNoLfTeGbI6ELKXra/RQ3q8MbJ0AB/5trkiAFigRRMt3Mgtpy03OdHw
 7bki/6E
X-Google-Smtp-Source: AGHT+IHSpPoZj4id4c5WN52KR2UB/7TwaYDCn7M1Sw2NOgQp4YFmAzQVHuXKbbaDcB5ZBpJmhEczRhtpOiaMwiweBKw=
X-Received: by 2002:a05:6902:2089:b0:eae:987a:1e32 with SMTP id
 3f1490d57ef6-eb37fbfc092mr4063365276.16.1758818531908; Thu, 25 Sep 2025
 09:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
 <20250909-pcie-root-upstream-v1-4-d85883b2688d@google.com>
In-Reply-To: <20250909-pcie-root-upstream-v1-4-d85883b2688d@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Sep 2025 17:42:00 +0100
X-Gm-Features: AS18NWBYFPfPWb46_T2as1obl6NS_c4V5RVGA0ExkzXdSqEA871l4qMU8qeRW-o
Message-ID: <CAFEAcA-cKA1uNAVjETGRjDTLzp5psY5k9nRNjS5Cr2gZ7KY7fQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] hw/pci-host: add Nuvoton PCIe root port
To: Yubin Zou <yubinz@google.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 qemu-arm@nongnu.org, Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Tue, 9 Sept 2025 at 23:11, Yubin Zou <yubinz@google.com> wrote:
>
> From: Titus Rwantare <titusr@google.com>
>
> Signed-off-by: Titus Rwantare <titusr@google.com>

> --- a/hw/pci-host/npcm_pcierc.c
> +++ b/hw/pci-host/npcm_pcierc.c
> @@ -203,6 +203,7 @@ static void npcm_pcierc_write_window(NPCMPCIERCState *s, hwaddr addr,
>      npcm_pcie_update_window_maps(s);
>  }
>
> +/* read root complex configuration registers */
>  static uint64_t npcm_pcierc_cfg_read(void *opaque, hwaddr addr, unsigned size)
>  {
>      NPCMPCIERCState *s = NPCM_PCIERC(opaque);
> @@ -248,6 +249,7 @@ static uint64_t npcm_pcierc_cfg_read(void *opaque, hwaddr addr, unsigned size)
>      return ret;
>  }
>
> +/* write root complex configuration registers */
>  static void npcm_pcierc_cfg_write(void *opaque, hwaddr addr, uint64_t data,
>                                    unsigned size)
>  {

These comments look like they should have been in
a previous patch where the functions were added.

thanks
-- PMM

