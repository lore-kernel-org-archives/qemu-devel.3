Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDA5C36008
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 17:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twlEf-0005Xh-8C; Mon, 24 Mar 2025 13:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twlEd-0005Vd-9S
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 13:05:11 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twlEY-0004NN-Sx
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 13:05:10 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-224019ad9edso14464985ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 10:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742835904; x=1743440704; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dnMtZsLq98R3h1P1yz4LB85OQbKH4lmqtVzK+zyANIE=;
 b=jLNRjj1Nv/NUzqPkqG5fFcaKqxABxBHoeLjdFcj54W9NSR4T50G5IeweVdv9GsJlX9
 qANg/bmPlAwiv0ZjzbVDJPRRD5PlSWf1NclL+iMMH+0AiUCotvLvYFFl/HyGOO40XSG8
 fomjZysq4+ybKF+lr4GxXFHuemVHmwRwPvB2OV1oeTmH5gSXfUkEw+kFRERw19UMVbYB
 grjtnUgCas/H1GSHrhviLeWdsmT5azJMAPVcaqFN5c/38KtGBDLtYHV0bWPg4TLrp5mc
 SLpnQPpj7vzsc7c1sbgxD7iW+CyFYcRdAi7cFnXDCMsgxP+Of5Hw3lkEPCD4qzeS+Yuh
 2/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742835904; x=1743440704;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dnMtZsLq98R3h1P1yz4LB85OQbKH4lmqtVzK+zyANIE=;
 b=uJ55prbwfDLOYNUwILqcUdQw/Nrsgs4KSXGff+d4FlX8hS8ElVQ+56LS/CC0GR8a6b
 q8Gp/pihRBYNA6SdOur/5DOk4zu8VSKoYj1ePPEsr/LoUK8P2LbFawxGhzZoHgt2BWa+
 qt+fI4cMcOXONoA3j/31dTPnK1fW7cidVnqEqc1jpOAz0j+lmRqc+nWt06Lfegr9AbMp
 sswES0MHOH9LJ/oIjU0aFw2QsXU/3Kc/l7FN0NoaH9zXH8BoBn5IhWn2g8pfx1NihjRr
 dO+JHlnPDjgdtBUoZodzdCQ9g+SsX0arQYkQnFxcajHkGHVYAiOpzDLE7F16bYTbPARK
 8BOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg3yLTsuGnL4JMOenukFzO+k27hggto3GFutOY6lDUwfklmE8BYtsog1NxaDlD9riYFbdqDhsciywX@nongnu.org
X-Gm-Message-State: AOJu0Yz8ntf5kDZO/QFCqBA62N97xexquT1LYbJbcOgfusvkh0wP00BO
 usmwAeQ3XOHfDft5+oz+BH1Sbu9F9BTcLhNyt2Dv8HR1wxP0Fc7qrP4Aygg38ec=
X-Gm-Gg: ASbGncua3WJxfz62/QOKwroQCMoiuYvu+8QVAF3utiscKYm8dyIt+O310kVcpVtsgJk
 re++1ruQwMa9vTlUBIql6VOoKXBgkhaX4nEujD2r0zElz+mkX5r4gVtYH7dyRqP/ytWfwn8LBxT
 P0McAK0Z7djlbChhttd2x7ZGXgRpkMocT+cS2OQ0nvtjHkT8/VhNyVXFOTs8Ph8aZnuW7GlHA94
 oFvWuriGMhindz8weT2zglXQnMZkzbP4cD4kBr/iwXTaL7rkIwBX48X5+D6hE3TsARpTTDEVtqY
 zrTWZsLoFrde4FtmZW9FgkMK7qRooEt2gIGR1RcavVy5FB521HntMIcaOnhGIlaHh/cv8n247cn
 A9jpZXvKn
X-Google-Smtp-Source: AGHT+IGzIhlM1AIYBPtourc+0ZyavN9ILUEEN80VhWLDQaYgl8bYdb3tAiLGrK1lHT5nc440/YgvfA==
X-Received: by 2002:a17:903:8cd:b0:21f:35fd:1b7b with SMTP id
 d9443c01a7336-22780e1a303mr234397205ad.50.1742835903661; 
 Mon, 24 Mar 2025 10:05:03 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f459c4sm73727955ad.82.2025.03.24.10.05.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 10:05:03 -0700 (PDT)
Message-ID: <ab59e1ba-4117-4ffa-912b-3f1ca2f87439@linaro.org>
Date: Mon, 24 Mar 2025 10:05:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1] accel/tcg: Extract range_within_page() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250323225346.35708-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250323225346.35708-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 3/23/25 15:53, Philippe Mathieu-Daudé wrote:
> @@ -772,7 +777,7 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
>        * If all bits are significant, and len is small,
>        * this devolves to tlb_flush_page.
>        */
> -    if (bits >= TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE) {
> +    if (range_within_page(cpu, bits, len)) {
>           tlb_flush_page_by_mmuidx(cpu, addr, idxmap);
>           return;
>       }
> @@ -810,7 +815,7 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
>        * If all bits are significant, and len is small,
>        * this devolves to tlb_flush_page.
>        */
> -    if (bits >= TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE) {
> +    if (range_within_page(src_cpu, bits, len)) {
>           tlb_flush_page_by_mmuidx_all_cpus_synced(src_cpu, addr, idxmap);
>           return;
>       }

Better would be to swap the two if's in these functions:

	if (bits < TARGET_LONG_BITS) {
	}
	if (len <= TARGET_PAGE_SIZE) {
	}

at which point you don't need a helper to simplify.


r~

