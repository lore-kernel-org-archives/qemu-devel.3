Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652E1C36002
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 01:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twtEe-0001ao-8N; Mon, 24 Mar 2025 21:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtEb-0001Ze-Pd
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:37:41 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtEY-0007Qj-9i
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:37:41 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2240b4de12bso26594005ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 18:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742866652; x=1743471452; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PdIuuyzjE10djLKABnFHUca/VobMzDkIZQ/hl9k6w4Q=;
 b=gIL39EQouNygW9Feru1ohsxoKsx6Unkd4NI5i5cLX+IrFLdybNa5j+A+nCPRhGMOWq
 WsAE4p0stZ2AhbbY7w++a3Ko84e4hoEg4Mobc7vwD8zVBBbklSHpXG2vjZa37IBMlFTL
 sjou5cf1gurcUhGhhZIIjiYlIGpxSXEPuKGRCPuCU8KFETp+lXbGGdffyJW5gt61Jci3
 +xwgcIhQdyOzAj1M2PEpc92RKD/3xJys5twXxtoqDX9OHYdLxYBU7L2RxICjmuRGQK+x
 TtdqOnLE25Yj79J0AXxQxrU4TPyaZxUJ0vSDvmj6QFKK8UJ0YXjpjRTBnb5xNvuaK/8J
 RzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742866652; x=1743471452;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PdIuuyzjE10djLKABnFHUca/VobMzDkIZQ/hl9k6w4Q=;
 b=uUWlqSHqmHEMJ7NeN2IMZnEgGDXlq7HSiPl4FgqAR6kVTFO2DNYPw1vfQfyha0tb8l
 BaMgYq6744gJ5rZLuiPtSB7VcUOO/kNSsgi2/NyBttoPgfQpqYuN7gQP7Lbpg74LiIG+
 N1iYmm9TLHoDfDRLo2f1VSRsyj8QP1drBpMBQs4OMWCnl4WQGgC8CttBPkA7WrU/p44M
 bVUzAJOIfDdqn3hSiU/4cPvQMUfKn4WyrZFLQem/phXz6rkefZ3mvVJ0Nn/SahH0+Cnt
 Q2A/lbRpNQ3xOjifb9rANEbRA91GcXgCYoIReYfG4m3tlbEMhR/7D8WcCwi6snCItsSf
 oGEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHM6RPUyty7yB/VaIodtkvumqV0Xdk//5LOJtbKEwfRn/QCtIbk7N0kjyqYL1D8Ou/tk22ANKUhzu7@nongnu.org
X-Gm-Message-State: AOJu0Yw1q1AuLpLAGxEYiOEkEI6PObHZ2UiH9UwZ/6sdNf4y6QGxY71j
 oW0UOqZE8r1C4FpKZykPLYbT6/tBT8u400KYHgDjdaqJdtS8whzFHUIdRQ9X+ac=
X-Gm-Gg: ASbGncvmixgnggn29JL/APl2kwu0dqn50lLFxWecBwoFpSq8v3XkbTmSQ70+oc/+J9r
 ah9DsJsIepKpQB7Nu6qn69YrJzpeBdWBN0dWOpM4UREwIuSqcqScqIRaj1A+R5EDpCfC0cYed/u
 qRz8XhI4uef2ML1t5t4vpUMRYAMfVIO22hfwUYRUwYvF22Qxc1OhE+gYx2Cb0vfpkW8CVnalXfq
 Z8D6wosD3wnHN9wjZrdSoIPQzEYpY1CfFRUaLO0WvVPGPhECI8oG8uBBFtH6Znv0N3KFtYvZWrR
 RgHvFjmiWBScxq+jub3/HXOFXrhl51FP5jtLtiIBFagRXBV3bEcuyg1cuvYLV4GeMKw0
X-Google-Smtp-Source: AGHT+IGbUvvMCBthX6qLdWTxiDMXFJQ5zTF7lLjWQwRSvA9e4uCV/Gza3enG+chm0Jn3eMp6/t1aXg==
X-Received: by 2002:a05:6a00:4648:b0:736:a973:748 with SMTP id
 d2e1a72fcca58-73905a2515emr21873570b3a.22.1742866651627; 
 Mon, 24 Mar 2025 18:37:31 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73905fa38e1sm8784770b3a.35.2025.03.24.18.37.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 18:37:31 -0700 (PDT)
Message-ID: <76becbf8-650c-4435-8719-4083c5a7c6ba@linaro.org>
Date: Mon, 24 Mar 2025 18:25:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/17] hw/avr: Pass mcu_type to class_base_init via
 .class_data
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-16-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250323173730.3213964-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 3/23/25 10:37, Richard Henderson wrote:
> We want to be able to do more common work on MachineClass.
> Pass the class name as a string in .class_data.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/avr/arduino.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


