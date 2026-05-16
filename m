Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948EDCD4F25
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 18:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOJTN-0003YH-CB; Sat, 16 May 2026 14:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOJTL-0003Y4-Lv
 for qemu-devel@nongnu.org; Sat, 16 May 2026 14:10:47 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOJTK-0004IL-6E
 for qemu-devel@nongnu.org; Sat, 16 May 2026 14:10:47 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2bd9c3b550aso6529675ad.2
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 11:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778955044; x=1779559844; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9ZJ4RRoSKVH7q7+F0JXKNuoRLeBQSw0eVAJq3rndSO0=;
 b=CbdQL3Xp2cl4EGw5YTMhZ+6RBFZa0Li9EC2sA39jyQaig9HGhIG/cNYzOHjR+YXvRT
 3rhCX+v08R1ZSocVw8STTOQOcbvLQZ0jViqpobrLeHmBJuLZDSvj0JHuzNjLKEvTCcfG
 sBGbHKpo/JiB74LNYmiXguCdi9rU9H1hVZ4SQhpdiNvZIq38EkLV3SLxzbClmPb6H651
 bzwLzqXV4vCEvWxTjMRGFDs1eCbrBWqMTTOZBWCGuIGoRQORQzuOiGgdg/xqsKsn7SaT
 F2D6ZE0Vo6Z9BgyIJnrqE2yHXym8Vq82P6r6kg88CTERgtTkddfo2mdgu9rmbngI7tIE
 OAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778955044; x=1779559844;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ZJ4RRoSKVH7q7+F0JXKNuoRLeBQSw0eVAJq3rndSO0=;
 b=SuELEjfJjSh6qoeHC4bh8gdeXmjaoSDR30B2quucwg2lx2vr6qQGaANyxdie73Pebx
 njLodKiCXu3KovMqIxvc+MBouuSdG4+P77nL4LkNVw8r8N9MyEIvXHmG0jfgG24/Nmff
 g1aZKGlvqL/u/22pZmiyU0QJN9uu4wTK71LIetIBJwQWSny4BbE809WfqkGyc/7fdng+
 vPksDYK+u1KvoB9sFMNA1b/FA6pT7kt0HnP5lSeYtUIgVV/qTDFA4d39oBbT3J0QahrY
 ixq1fp0WoOTIBEonA4WfuKHPHOsgvO9M+SneMRpid1dk5acJW1j01NY9nHF3KfMTGS6P
 vR/w==
X-Gm-Message-State: AOJu0Yy5ySmmWclXNWh/oKzUhOHjdLUNuHB8mjKZpQYorz6gqtOHjrU/
 CGGV7edi8dR8Z5UdJmsrTUPXCI0FYvL1tz6nPBlcJcqGX1UxShyTQY6E+ng2TXrcH1gkDA/I4mW
 jLRIn
X-Gm-Gg: Acq92OEsjCe4NFSxnIJ9l0bQSXsNce2d8i6auPET4P3alPS0qhqtkZq2T4E1aqyQK0P
 9ZnCCCT23l1I4F69cK0Rb+hnqOkr2OpqES6dP4PapWu6WbFKMlJTV/L7xVkBzZX/5IjiHj60Aaz
 U25d3mYza2SyevU4AG+EBYP94UHvNdWaJtxd29UcfGUIfPZpRIFtTNIBya38WDxUMdTImpB/Y2n
 h+wbrEflNmfTrTrdfODOVkMTpEMbmCWgtKKQ4t18gZAdZq58z4vvcL2SBmxedthQ8WNEds8CM+F
 RAEIUeFkuWhpZMfoa0GFGC2C4HMNSoLCma4oRzj3iV88vp2LzyMCWLt1eK2sraa7AWk2C15M3GI
 rtDjumy7yahRgKMV2KnLvnPG9DLtysGPW9URsStZj5WTfQhPXyozvrCjHEs5/eItmL6Vi8rSF/3
 EoqL+2K4L6sNbxj451w2VR5HYGVEWySg0y40Js
X-Received: by 2002:a17:902:d702:b0:2b7:88f9:9c3d with SMTP id
 d9443c01a7336-2bd7e7cb191mr67707465ad.12.1778955044458; 
 Sat, 16 May 2026 11:10:44 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5f2e7sm93970055ad.5.2026.05.16.11.10.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 May 2026 11:10:44 -0700 (PDT)
Message-ID: <8ff8207f-f373-4e97-803d-57a21d7436ff@linaro.org>
Date: Sat, 16 May 2026 11:10:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/intc/arm_gicv5: Add missing early return in
 gicv5_set_handling()
To: qemu-devel@nongnu.org
References: <20260512093856.3197700-1-peter.maydell@linaro.org>
 <20260512093856.3197700-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260512093856.3197700-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 5/12/26 02:38, Peter Maydell wrote:
> In gicv5_set_handling(), if the guest tried to set the handling mode
> on a nonexistent SPI then we print a GUEST_ERROR log message.
> However, we forgot to then return, so execution continues into a NULL
> pointer dereference.
> 
> Add the missing "return", bringing the code structure in to line with
> the equivalent parts in other functions like gicv5_set_pending() and
> gicv5_set_target().
> 
> CID: 1659596
> Fixes: 5beb48ab53d ("hw/intc/arm_gicv5: Make gicv5_set_* update SPI state")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv5.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
> index 7ad274e369..6b1dd04991 100644
> --- a/hw/intc/arm_gicv5.c
> +++ b/hw/intc/arm_gicv5.c
> @@ -926,6 +926,7 @@ void gicv5_set_handling(GICv5Common *cs, uint32_t id,
>           if (!spi) {
>               qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_handling: tried to set "
>                             "priority of unreachable SPI %d\n", id);
> +            return;
>           }
>   
>           spi->hm = handling;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

