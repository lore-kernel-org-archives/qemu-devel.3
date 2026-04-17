Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD4FF8E4A5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 05:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDbNj-00051e-LS; Fri, 17 Apr 2026 01:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDbMR-0004o4-Qz
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 01:03:28 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDbMP-0007zw-Cp
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 01:03:23 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488b150559bso2012055e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 22:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776402200; x=1777007000; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pvb3bNG08lnpUPao/ej6REPgY4ZlsumcDKfgpuSmjHs=;
 b=xHs17Qy53Jt1UAq1MiEArFc2biJ6xTQBl/qfqwLn1EbQ6WFSnO5erGmioRJDGh/kbp
 BzSOMSB4Nl2Mer+t6XEbDicrHrz8sOUxA7VDZDVbvZyonKB1RlGdAQegne2eRGJ94qD3
 ncu71ZL4KWIdcVUuRsYJANgMMgs/fdEVwSHvsgRnyCdcYvALeUfDyJ5LEdx4sQEPnyLD
 Ce4L/PTFua0AfqFIRRdLNKeH7Sl75fZQDxTqVh4XKLEdSTrkqxwNaPXbnAF0kgCMhImr
 J/rN5oGdN4WKwYUi5fMdL+ytrRcmXe8/hkWlDt5Qut81rqoKuULmNps2Clp6VuzZ1Ims
 s/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776402200; x=1777007000;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pvb3bNG08lnpUPao/ej6REPgY4ZlsumcDKfgpuSmjHs=;
 b=ZM+nWLHysGgzzzM5WqPl8Psck9OyfY9CMiKTmPXIjvMnhfTcmt4zF2aIynsQNlESF4
 1+It6ORchwv3kM0Z8nrm779jw709rqGPy3gM0P7QHCk53creSUNPKbSi9yd7P3llI2BM
 xm/SiXZ7lOTK67n9hwrZJLrzGi+SYbPUaCE/vb23EyShkWXhtgCPrldCTs1rVU2FyUQ/
 nhnzMrJgmVWJ+HlBkxRjYzXIMAt09ycrejkqLZE56mI6roUhv8iFuymo8ZdeTXqrcF3M
 HEMHmUOIsbvDxCWwG3HOW22oWkqjNIm+x/A1H3Xkg2fASlSlAHlbWmGyMqnjVHCK+B4Q
 IGdA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9CAK/v2+MbFOFRdDFqP3daa+llleybcPAw9xcIP+T3982Q1ouDUJBVMzScNgAe6QU2NKuqvbDajBOU@nongnu.org
X-Gm-Message-State: AOJu0YwdpzCraoMFjaPVcdkwncA/p8J6+e6tJsGZLxvRmGMTbZvOP3P6
 Gfylo4RXjiMKUS/Jm14JEXiQ22FggGAIsz5zqyad5IPnH9XSzjPxu9zAOJdGGno99EU=
X-Gm-Gg: AeBDievFIzVWDSgwRwrlYwEZrQgIbE5Nulr0+bFGVfYA+S0zb4ggPdHl6EBUpF6xCwd
 tOV2w/cYQssWVynn9LmLUrLDJkH+TS9AvlrfUCE6SvVk6EbLIgYPRmHhMJlBoib91aAlW9ENlwA
 Ralc+qNQ7QSplbwMbJ659INEFIoahtpJHK5WAu2UxaszQL3nnLy1MKqijog/OrGKh+6H6mMIOA5
 oWvlrCg5xDc8Tig+IzPCSnQucp+g3jAdO9A2hfuhheRYjjhDFZodyX/CTmD4HQMALVvFI5g63k6
 pEolPpbaThH4ylWp9FHUCVk9h6ORsBoZScZDBM0T50Y0T86M4voQmUSEkeLf0pLH9MXwDNblYTF
 2aBTB9jn1WEskChctkTtxurBruryl9ccE9VoURZBVj9WMdlefgCU9Bpp6meo/kATHv+3H3VUyj2
 T97XAvsuvoHB9O2xiDmAobmHjpWtw13ZaJUXq+QzoDJrh6ub2Kz3ifL2+fl58rX6JXlKCb1gLID
 cQA
X-Received: by 2002:a05:600d:8408:b0:486:ff92:63e5 with SMTP id
 5b1f17b1804b1-488fb73dc6fmr13087135e9.6.1776402199616; 
 Thu, 16 Apr 2026 22:03:19 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc18bccfsm13144545e9.8.2026.04.16.22.03.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 22:03:19 -0700 (PDT)
Message-ID: <c03af2eb-c7e9-4954-9a53-b1575c7073f6@linaro.org>
Date: Fri, 17 Apr 2026 07:03:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/17] hw/usb/hcd-ehci: Implement 64-bit QH descriptor
 addressing
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-10-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260416014928.1279360-10-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 16/4/26 03:49, Jamin Lin wrote:
> EHCI supports 64-bit control data structure addressing when the
> 64-bit Addressing Capability bit in HCCPARAMS is set. In that mode,
> the CTRLDSSEGMENT register supplies the upper 32 bits which are
> concatenated with 32-bit link pointer fields to form full 64-bit
> descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).
> 
> The current implementation assumes 32-bit QH descriptor addresses
> and directly uses link pointer values without applying the
> CTRLDSSEGMENT upper dword.
> 
> Introduce a helper, ehci_get_desc_addr(), to construct full 64-bit
> descriptor addresses when 64-bit capability is enabled. Update QH
> traversal paths (async list walk, horizontal QH link, and periodic
> schedule entry handling) to use the translated 64-bit addresses.
> 
> EHCI 64-bit buffer pointer fields are defined in Appendix B as
> split 32-bit low/high parts located at separate offsets, rather
> than a single contiguous 64-bit field. Therefore, the buffer
> pointers cannot be represented as uint64_t bufptr[5] without
> violating the descriptor layout defined by the specification.
> 
> Introduce ehci_get_buf_addr() to construct full 64-bit buffer
> addresses from bufptr[] and bufptr_hi[] fields. Use this helper
> when calculating transfer buffer addresses so that data buffers
> above 4GB are correctly handled.
> 
> Also add bufptr_hi[5] to EHCIqh to support 64-bit buffer pointer
> fields as defined in Appendix B.
> 
> When 64-bit capability is disabled, descriptor addresses remain
> 32-bit and existing behaviour is unchanged.
> 
> Note: Similar split 64-bit buffer pointer handling is required for
> qTD, iTD and siTD descriptors, which will be addressed in follow-up
> changes.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/hcd-ehci.h   |  4 ++++
>   hw/usb/hcd-ehci.c   | 48 ++++++++++++++++++++++++++++++++++-----------
>   hw/usb/trace-events |  2 +-
>   3 files changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> index fe4c508c32..773f376834 100644
> --- a/hw/usb/hcd-ehci.h
> +++ b/hw/usb/hcd-ehci.h
> @@ -141,6 +141,9 @@ typedef struct EHCIqtd {
>   #define QTD_BUFPTR_SH                 12
>   } EHCIqtd;
>   
> +/* QH overlay: altnext_qtd, token, bufptr[5], bufptr_hi[5] */
> +#define EHCI_QH_OVERLAY_COUNT 12
> +
>   /*
>    * EHCI spec version 1.0 Section 3.6
>    */
> @@ -194,6 +197,7 @@ typedef struct EHCIqh {
>   #define BUFPTR_FRAMETAG_MASK          0x0000001f
>   #define BUFPTR_SBYTES_MASK            0x00000fe0
>   #define BUFPTR_SBYTES_SH              5
> +    uint32_t bufptr_hi[5];
>   } EHCIqh;
>   
>   enum async_state {
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index b9e4251d62..37ae637e08 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -147,6 +147,24 @@ static const char *addr2str(hwaddr addr)
>       return nr2str(ehci_mmio_names, ARRAY_SIZE(ehci_mmio_names), addr);
>   }
>   
> +static uint64_t ehci_get_buf_addr(EHCIState *s, uint32_t hi, uint32_t low,
> +                                  uint32_t mask)

Rename @mask as @low_mask? Or directly use 64-bit?

static uint64_t ehci_get_buf_addr(const EHCIState *s,
                                   uint32_t hi, uint32_t lo,
                                   uint64_t mask)
{
     uint64_t addr = s->caps_64bit_addr ? deposit64(lo, 0, 32, hi): lo;

     return addr & mask;
}

> +{
> +    uint64_t addr;
> +
> +    addr = (uint64_t)(low & mask);
> +    if (s->caps_64bit_addr) {
> +        addr |= (uint64_t)hi << 32;
> +    }
> +
> +    return addr;
> +}
> +
> +static uint64_t ehci_get_desc_addr(EHCIState *s, uint32_t low)
> +{
> +    return ehci_get_buf_addr(s, s->ctrldssegment, low, UINT32_MAX);
> +}

