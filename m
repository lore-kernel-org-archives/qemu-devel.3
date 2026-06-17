Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EFECD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrwX-0001Az-0j; Wed, 17 Jun 2026 11:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZrwV-0001Ak-0h
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:12:39 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZrwT-00082p-3R
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:12:38 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-84230ab8857so2791102b3a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781709155; x=1782313955; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uxm9CDMZOFNk5XylyACfrJ54A/jd2faq1oga7Ykt2vg=;
 b=G9q7x1NQ25WRpdQEcdB91mvCKz9eeixlmMdtw6r+SNKRr/XsJU3io6Wz0s8S8x8FrA
 9TglRuC6BdL7v3CyzlICRYJBn4PE2Tf3NaukHBesl7SZdmQ5bURgwqV3g99sQEAd6zdE
 Eq9cgQFjMSP/BRmlED2KwVHkbynNXqOBuhDTPLAI/nmUIZqxJvdowJaFHNTjdz7pnUSg
 SJYMkcdp7blReaZHErbHXKaYf7c+IQjPvGghWqWVrG3738K8t0hIRw2ZMDTi/NAPvOgf
 x9BUjoIsPbiNwpUKXsZgYPZrKXz0XCVKvyuvzEsz1TQ9BthSLZg7Rbj1DixLXqkykIk0
 3brQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781709155; x=1782313955;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uxm9CDMZOFNk5XylyACfrJ54A/jd2faq1oga7Ykt2vg=;
 b=NXubS26Oq6qNmnLgGRG6IAJao5HV8om2Xhfvc3Tn82FFU/qx/ms7Wn+c/N4BC39eFY
 cU00r1uHA4Uzy0O7miV+Shq9nuZHWfysDwH7foJiPrICVh7vIs3miKHzD7FoZsb03/er
 0yXErIWGqU7r83AmbKEpOoMI5O58ZRYasv80tFBRrBRCvhktNxTSpGrAuNNkRhB4/lDH
 SerYZ0MDuI7cn1paJ/7QbNEWt7j0vy8oFN8wlJKEsMNqxLmGWR6GWP92YOfZs693ZTus
 CLBtO65nxrWuHSp/Ncr0dJYuqiv1Y8wAskuudTOBH0jSO9cb+gEgZpRZgdwtz0/xpV0a
 +ZeQ==
X-Gm-Message-State: AOJu0Yyt0QRsjOiegaeclUKjnVUSv5p4Ya2U/+94if6C2rfAT4RdqHe4
 c6tak3bnn0APfrvpotHovvQqPCi+KTNtDTiOHe0XbvpPnSURpDtFF0DegKthkuc69t8jBQxrIoy
 lDABo
X-Gm-Gg: AfdE7ck1iVkUX0TyUcSGsMlqNT8VxwOW+saDGw8Ert7vgkcVAP2wp4T/KiIRl+0Y48f
 9GzqceQIjtEcHfLX7UP18WEiMR/Z0AWJuG5ObO3ECrs7Ud2yANBO1yYDCBt/I2ImbWuzEpIw8WQ
 f5zBKsnzXegNh7d1LLOj1KvBzhrWxq7TTIgtAzqIRdHyGuJOn6L1uf0rRYJYvFQmCUw4YalTFM2
 UwU7YHmizP35TggE5K4zGTYQlCI/R7DNGEB4E+OSzEVK49oBl4LLW7XogNHGxH0+XIqT/uq3RCH
 pUrruRaKwms4JKsW69Lp2Pd7cy6eBhbuFanQlSEgQguRPrLpfsWEPEXMr28F9GGCp7K0M9PRYr9
 YCeYyIDNlW35dCVRLenbVls92Ox+UOVkO/7HmyYHqEnwb3MPT4Y3YLmYjG8HUey9ku4NrARos5S
 SKzy8k1i6QErRBaHKsfRIA8LjcO7LgNfGOc0NTTKSG05S18ewmJxJNYL/Urg==
X-Received: by 2002:a05:6a00:66c5:b0:845:31a6:d84d with SMTP id
 d2e1a72fcca58-84531a6df5bmr1581882b3a.7.1781709154972; 
 Wed, 17 Jun 2026 08:12:34 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm17457162b3a.54.2026.06.17.08.12.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 08:12:34 -0700 (PDT)
Message-ID: <41c2e3f7-a24a-4f88-a461-300600dc2d07@linaro.org>
Date: Wed, 17 Jun 2026 08:12:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] system/memory: Remove unnecessary CONFIG_USER_ONLY
 guards
To: qemu-devel@nongnu.org
References: <20260616153754.93545-1-philmd@oss.qualcomm.com>
 <20260616153754.93545-2-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260616153754.93545-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 6/16/26 08:37, Philippe Mathieu-Daudé wrote:
> This header is only used when building system units,
> checking for CONFIG_USER_ONLY is pointless.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   system/memory-internal.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/system/memory-internal.h b/system/memory-internal.h
> index 0066ffdffb6..c7573a68b5e 100644
> --- a/system/memory-internal.h
> +++ b/system/memory-internal.h
> @@ -14,7 +14,6 @@
>   #ifndef MEMORY_INTERNAL_H
>   #define MEMORY_INTERNAL_H
>   
> -#ifndef CONFIG_USER_ONLY
>   static inline AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
>   {
>       return fv->dispatch;
> @@ -57,4 +56,3 @@ static inline MemOp devend_memop(enum device_endian end)
>   }
>   
>   #endif
> -#endif

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

