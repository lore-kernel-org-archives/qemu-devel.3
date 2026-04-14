Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D9BED7B92
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 09:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCZyt-0002sR-Po; Tue, 14 Apr 2026 05:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCZys-0002ri-Jj
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 05:22:50 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCZyq-0002go-MN
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 05:22:50 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488b00ed86fso55442735e9.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 02:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776158567; x=1776763367; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=napVYKet5wfgKuxipXOGqoJX84ZK+ADDAP9uEoPAauw=;
 b=Ll9ECSPJxBE8ULWo2u2KPvXkHpWX7UBKFbAZTqppI1o6wQeZyCbSbtEYBkukhxjfzs
 Jv/m1v4m7pZYkyZMPbCQOJ0PbQk8P9a63sxKdlatm5/RsxRerrCSDPXbv1BI4Rznu0m2
 B2/YZhXGn5X16XVIQGlAuUy94wSfHosB54O5/Em0GBqRotPz3HMrm9/5gFCmN0naRjS4
 KldT03rIKnk9JH2wiZW9YtwtkSZFl0AlT3KwFvDUUlxsAKc5ERY2HQsTIGLlhJOUncc4
 bsiMTCRBvdlFOVnpyCjOFqqAxF0fhK9ySvqsbX6aAgo5GFJ2xamSUQqSg+QCRZudaM0s
 Ufug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776158567; x=1776763367;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=napVYKet5wfgKuxipXOGqoJX84ZK+ADDAP9uEoPAauw=;
 b=eezmGzhGzD0DXtksN6RsaRs7Nv5EO4nZmW5aal9zwJx7YaaRsuPRzlDTY83CLXsmIs
 VpBPJ6vNgRkqDkpCV3+wrXw82MzRakBWfICI2XYVGevYEBAm5VlINYl4OfdwF0C/Au4p
 MquAOBcZgb0GF8xdNfI52L5e/3uewCXk1Wk28UTg5uehBaEHvMh3HLDohakRN1F6Cm1m
 Enhw4VskFpgy4ZgyF7ZN5qA/VtNJMq4QXKgBGzkUlsVeMf7qUZINrVEXiKMRGUWEf2yC
 LvOzRoY46pzioAiqh5yViBND4DK07g0+/ia21/TKtzHN07/R5FVjL9neuIbAOcGw/8fH
 36DQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9B+2w8iYqULKl5IPcLb6qfHeCH5PNOxjpu021w7JaKvAT04iXvIMjXr0UCy/mBnuaBD/XPlf49xlQJ@nongnu.org
X-Gm-Message-State: AOJu0YxtHSt57Br6GO2BUZHUkdSA7IGipvi6vTIhBxluhxIa7h9zvWVo
 e9+jgrzuFbVZo7a1bFDYYvfcS9SPbe/VaAlAUI9EfpoKiOFtf81gaoysZgUJfLR3gOA=
X-Gm-Gg: AeBDieu+RwaNm8MyycsScdTuOfuX0cZh1FJ1lymeTXDgAsgJEcwpHvqQHsi5Bc46d+g
 U8VVITsmXRYl7zj/n7VoJNgVWtlh7GokRC1mVUwBv4DiK/X2DzZP/qR1X4baMyaM+bBoSKqiobL
 cdvvWy6o39NaNISqVCgUy/Ga+VAXlQNDTDhxQPbcnwmzPIcldVGbVD8KoH3PBfDvr1ctDxXsIyc
 VqgRg9V2QlXOhgEe6g0ILCnVmhf3ZyGqYp+PWxIeFXwtJ32r/q2mY1+vlcdekxTBtM1LS97fo6X
 v66n97SAVpvNPH5iGoSliaqebo6ulEDr+O/76WWehFSzZtsOLsQcDgFVdIg88BpZsc5C0zeJJlV
 M1vvXWbetgDesfsJlr2GY9iZjpiOFHihZ9BhqK4rsbrBDBzrfrJEjvuYe7sqT9a3KfgKXfuM1Tw
 pBfF8jRrjY9AjMPy1iOOEHebsAxu1YPipizvJXlSphSVXv+X7mZHwkEPiYSIPCFssjDg==
X-Received: by 2002:a05:600c:4715:b0:488:9e54:94c0 with SMTP id
 5b1f17b1804b1-488d67e7dd4mr245692415e9.8.1776158566868; 
 Tue, 14 Apr 2026 02:22:46 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ee042ff9sm40765095e9.14.2026.04.14.02.22.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 02:22:45 -0700 (PDT)
Message-ID: <7eb32749-dd83-48ea-94a4-41935cc90aca@linaro.org>
Date: Tue, 14 Apr 2026 11:22:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/17] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit
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
References: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
 <20260414080025.3005916-7-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260414080025.3005916-7-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 14/4/26 10:00, Jamin Lin wrote:
> Change internal EHCI descriptor addresses from uint32_t to uint64_t.
> 
> The following fields are updated:
> - EHCIPacket::qtdaddr
> - EHCIQueue::{qhaddr, qtdaddr}
> - EHCIState::{a_fetch_addr, p_fetch_addr}
> 
> Update get_dwords() and put_dwords() to take 64-bit addresses and
> propagate the type change through the descriptor traversal paths.
> 
> Adjust NLPTR_GET() to operate on 64-bit values:
> 
>      #define NLPTR_GET(x) ((x) & ~0x1fULL)
> 
> so that link pointer masking works correctly when descriptor
> addresses exceed 32-bit space. The previous mask (0xffffffe0)
> implicitly truncated addresses to 32 bits.
> 
> This patch does not change the on-wire descriptor layout yet.
> It only removes the internal 32-bit address limit and prepares
> for later patches that will add full 64-bit QH/qTD/iTD/siTD support.
> 
> Update the EHCI trace-events prototypes for QH, qTD, iTD, and siTD to
> use uint64_t for the address argument and print it with PRIx64. This
> ensures full 64-bit addresses are shown in trace output and improves
> debugging of queue heads and transfer descriptors.
> 
> Since the type of fetch_addr changes from 32-bit to 64-bit,
> bump the VMState version.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/hcd-ehci.h   | 12 ++++++----
>   hw/usb/hcd-ehci.c   | 57 +++++++++++++++++++++++++++------------------
>   hw/usb/trace-events | 24 +++++++++----------
>   3 files changed, 53 insertions(+), 40 deletions(-)


> @@ -294,8 +294,10 @@ struct EHCIState {
>       EHCIQueueHead pqueues;
>   
>       /* which address to look at next */
> -    uint32_t a_fetch_addr;
> -    uint32_t p_fetch_addr;
> +    uint32_t a_fetch_addr_pre_v3;
> +    uint32_t p_fetch_addr_pre_v3;
> +    uint64_t a_fetch_addr;
> +    uint64_t p_fetch_addr;


> @@ -2441,6 +2445,11 @@ static int usb_ehci_post_load(void *opaque, int version_id)
>           }
>       }
>   
> +    if (version_id < 3) {
> +        s->a_fetch_addr = s->a_fetch_addr_pre_v3;
> +        s->p_fetch_addr = s->p_fetch_addr_pre_v3;
> +    }
> +
>       return 0;
>   }
>   
> @@ -2472,7 +2481,7 @@ static void usb_ehci_vm_state_change(void *opaque, bool running, RunState state)
>   
>   const VMStateDescription vmstate_ehci = {
>       .name        = "ehci-core",
> -    .version_id  = 2,
> +    .version_id  = 3,
>       .minimum_version_id  = 1,
>       .pre_save    = usb_ehci_pre_save,
>       .post_load   = usb_ehci_post_load,
> @@ -2501,8 +2510,10 @@ const VMStateDescription vmstate_ehci = {
>           /* schedule state */
>           VMSTATE_UINT32(astate, EHCIState),
>           VMSTATE_UINT32(pstate, EHCIState),
> -        VMSTATE_UINT32(a_fetch_addr, EHCIState),
> -        VMSTATE_UINT32(p_fetch_addr, EHCIState),
> +        VMSTATE_UINT32_V(a_fetch_addr_pre_v3, EHCIState, 2),
> +        VMSTATE_UINT32_V(p_fetch_addr_pre_v3, EHCIState, 2),

IIUC we want VMSTATE_UINT32_TEST(..., 3) here, for "<3".

> +        VMSTATE_UINT64_V(a_fetch_addr, EHCIState, 3),
> +        VMSTATE_UINT64_V(p_fetch_addr, EHCIState, 3),

These ones are correct (">=3").

>           VMSTATE_END_OF_LIST()
>       }
>   };


