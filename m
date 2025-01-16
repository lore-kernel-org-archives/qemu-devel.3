Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A25AC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 18:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYUGR-0005ZN-45; Thu, 16 Jan 2025 13:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYUGG-0005Qh-M0
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 13:06:35 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYUGE-0007m4-UY
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 13:06:32 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2166651f752so28326405ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 10:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737050789; x=1737655589; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xac+6A1Y2C+n5cihSg1LX3BrLkOH2xWlx2UzQvJhWY8=;
 b=pOfk8Mnq9gY0FwL0ZHsqBfasXNOiYIeuIV3aa7d0W9d16ULEONEKoUx0Z8VD9OxdE8
 JF0BQWY8//SgyCQZTp/SEtVn6/E7dyozxSE+epNji9XWPTlAyTofF8kxpsfmb6LpT5RE
 1PPOsQzkGl3yX4+ToFm5yxyQLGKJY9WtFeEDHir7BJoBMs0Q8GIr82cFi+xcF0qIPHLA
 WLLK7lFM3+KSZGnl7r54YxPRIKwMEEDUXkv094tD25sMrx1dj7wtkUTd+0eBleaVF30C
 Hns/4Fq4+Dmol/vqQIkFmQjUWyIX5/oi9TVxSHTrSR9VloVQvhdk4KAO7SCtnjaRFRii
 XnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737050789; x=1737655589;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xac+6A1Y2C+n5cihSg1LX3BrLkOH2xWlx2UzQvJhWY8=;
 b=Tpsoh92fZaFcQ33EDv8cnQiIU/IpxLz6Z5gjbxj069Esl5+thd4a/r5ag0bn7ztQXN
 gwtjWDZWTOh7tPmYgr8s9mIXiHFZdEyKQkdAbHFYbGevL/4U4kUGwD5cGlhwCCR8Qaq0
 jP77lDIolxtT+DqHdBca08N8fb+nHLfzEkhAmJ80+cCtPpFzOGBNQNggmRLwBR0vF8lG
 oSXrLUdIk7CAiWIL0D0cSYR7F5+smy5MwY1n/HDOMR4shyUYtWh2PDoj0EXG5FQGQAeq
 4pf8hRCWBFhBK7Zrf7APs71S9pggI5KqhthEXcvBB9S9+VrO0Ynn2JnJHxDPSgLrq91x
 ACUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGkiYmAcHVAyo5DZgE/cg2EpPHRdwF4Bn+2LI6Ai5qDWK7h2PGPhvp3+GnkjCNNUaR7UywI1vQ2Wtu@nongnu.org
X-Gm-Message-State: AOJu0Yz+NJadrO/ViuKHwSFAs23a2UVQLuQzA8qwRL0OjStftW8dub7G
 BFOJt2Rbom92JdfXDpqYcH482lPBpd0ITmQ4D8S3YfqH6N5EyoxiOmvdHh04FR0=
X-Gm-Gg: ASbGncsAhWooSNcMBtZ/NclfSKWFjoMbq5xW6zUiPMWeSF7QnVZ09XaoWQDE2DjQzN6
 wK0OllmuE42syRLHR/qKgDVyjTKqcS+3jI9Tl7G/4+1wuOi43sGpaltWXpLTZVT+AkTB0Ddbc29
 FlL8JMJ60DnXMWysFB27oKS1pamO2c8yiHunnLY4O3IdtHlrVZbycmHvZ/Kif7XIWxs6Yd9gf9G
 IcuCjZfqKEMBb3plqHizTj+aJMskNh959pIHvafyWloypPrSTdwX3VBe4TBZX1EggIKygFJtX4g
 4YkE6jnSAQ0fTqA5MrZXpNg=
X-Google-Smtp-Source: AGHT+IH+rX2caxPIiuID6Hxez0Nz/LpPZmgLqXF3WTrO/SRLeniuF8OxqFv8HlxDMrz6JicRRuFSnw==
X-Received: by 2002:a05:6a00:170a:b0:72a:bcc2:7748 with SMTP id
 d2e1a72fcca58-72d21df4385mr50468288b3a.0.1737050789475; 
 Thu, 16 Jan 2025 10:06:29 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72dab7f2db6sm322205b3a.13.2025.01.16.10.06.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 10:06:29 -0800 (PST)
Message-ID: <a1ec763b-39b8-49bb-829c-3e02aac99101@linaro.org>
Date: Thu, 16 Jan 2025 10:06:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/21] hw/i386/pc: Remove unused pc_compat_2_3 declarations
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250115232247.30364-1-philmd@linaro.org>
 <20250115232247.30364-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250115232247.30364-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 1/15/25 15:22, Philippe Mathieu-Daudé wrote:
> We removed the implementations in commit 46a2bd52571
> ("hw/i386/pc: Remove deprecated pc-i440fx-2.3 machine")
> but forgot to remove the declarations. Do it now.
> 
> Fixes: 46a2bd52571 ("hw/i386/pc: Remove deprecated pc-i440fx-2.3 machine")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/i386/pc.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index a558705cb9a..103b54301f8 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -302,9 +302,6 @@ extern const size_t pc_compat_2_5_len;
>   extern GlobalProperty pc_compat_2_4[];
>   extern const size_t pc_compat_2_4_len;
>   
> -extern GlobalProperty pc_compat_2_3[];
> -extern const size_t pc_compat_2_3_len;
> -
>   #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
>       static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *data) \
>       { \

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

