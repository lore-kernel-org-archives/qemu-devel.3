Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46014C36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 20:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u04g1-0005xs-4C; Wed, 02 Apr 2025 16:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u04fz-0005xb-B8
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 16:27:07 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u04fw-0005Yw-U9
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 16:27:06 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso1300195e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 13:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743625622; x=1744230422; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XWa9oO2ej8Q2GrE0B//On0RuixeoCWdztWdmrmkWefw=;
 b=hBCEwhJwRDXEsJ7kFL5sS8jDtm0jJ5SmMLOrURtb+8BaAYMhWGpoe8Svz3a9xA5GCT
 10cnZY8yBA90sq8y0zdZdF6wjPAUvzIudyZHwMrd8auM17B7Mht6rPOHuu4bKaidk8EO
 t6ncPEYxkBOpeOdkRM6QuKyktAbtQbLdNZH6fqtBuE48sh/Ywrs8I6E/PvpfXzBf07tO
 f6YEkrLZvW5iBKnLrkiqAiQlLi45rzYcv7w2J6MOkqj9CjdNil+ZMsWz1ZFQShwEnpZI
 dg+PDEUPo/Ye1gi53I72oIZk0OdbO9Vn0cUKaq4SDw5BaEHQfSxiH20hpjyBJg0MfLh5
 fNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743625622; x=1744230422;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XWa9oO2ej8Q2GrE0B//On0RuixeoCWdztWdmrmkWefw=;
 b=qHYprhUnqBo96fm3EmrvUF56tURE3O+Q3l7nn48b9FmTnkWBi+4UsFSBw69MTD3X68
 +K5WZsHugWmEYmQBvXg6Odk4ZDvUfdFT4Bl2E+FpPWHBExTpoRTezvtCWlv7pslsHmGR
 gDdsOufSH9RLFXuI96ug5FJa6bUDJCkJKKJCaozJC3uluggQTM3bh5xUPjWAdTs0j7v+
 VCwWv4A8fB1egpUL4CdFrpbtRD5oKfRWBVe4XnVqBLuYSpIzC798Z+WG95T7f4Az1Syj
 ECGhBxFfvjEXha/GTi68FGbYAIhtd8PeB27tjjjwNC2dCejaYQtxJD+hHvgz/NztQFV+
 257g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmmDKQqldKPtZSfY//yaIRy7+MAAUM1A6RXJN/gGRErhuDZaX4LeWBXBV0OOqYvBOxCXa0HVVeX0RC@nongnu.org
X-Gm-Message-State: AOJu0YwevYM9GzsilJ2SMy6G9QloBxF/qOT3+Rq1jJ0xTSCix2jIOQ/A
 zsJdYYWNP3dMphi5Dr/a6CVBFhPI4ioRFIHohd7QyqLXmNh3v0iPWHRym1Re/qw=
X-Gm-Gg: ASbGncsQqRc2XtTLitkkSZ6Ma7Eq9LDf00yuAUaRYky/Zy4+aWuiMySrRX7BihFfTOG
 J3Nym8x27BA1mapt4e/g+VgDEjKpliaurQF1r3pDZUhm3fOTUNXZF1gMNnCWTBSuDXUmNNy8wt3
 VgryLUAhMwZtL/cEWvKL63uWcx1E76qLTYo+2mL5FRBFTOzkEfyu3uHSOqZx2b9RZKG/pAXRB9x
 2VBzhzSUfUOTQ96z+b/cfly9WprqtGf8jFHmwCFDK0Yfn1gcwA+guajOepatoRFcYoh5/LApCZd
 sQTx3rcNl3a9jNjt7T8EJXhL0IcdKgrJemprMK/0uH6hTC1NSOQlkKh6ZZhDkhbvZhYWOgx/SCL
 aGTySsPZsMfAg
X-Google-Smtp-Source: AGHT+IFCJ46SlaFNG9DKBUYPDVuPPUsaalw5cZZV4hh0BZKMEvcMnNRDnU00+2nfdXJMmmqdnPnTEA==
X-Received: by 2002:a05:600c:4e56:b0:43c:fc00:f94f with SMTP id
 5b1f17b1804b1-43ec14cd51cmr1295375e9.23.1743625622306; 
 Wed, 02 Apr 2025 13:27:02 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43eb60cd74dsm31012355e9.20.2025.04.02.13.27.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 13:27:01 -0700 (PDT)
Message-ID: <9a5958e5-bd09-472f-b11b-15515af661a5@linaro.org>
Date: Wed, 2 Apr 2025 22:27:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 v2 0/7] tcg: Move TCG_GUEST_DEFAULT_MO ->
 TCGCPUOps::guest_default_memory_order
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250321181549.3331-1-philmd@linaro.org>
 <90135439-b3a0-4e31-84e2-ce29b90db593@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <90135439-b3a0-4e31-84e2-ce29b90db593@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 2/4/25 22:00, Richard Henderson wrote:
> On 3/21/25 11:15, Philippe Mathieu-Daudé wrote:
>> Since v1:
>> - Do not use tcg_ctx in tcg_req_mo (rth)
>>
>> Hi,
>>
>> In this series we replace the TCG_GUEST_DEFAULT_MO definition
>> from "cpu-param.h" by a 'guest_default_memory_order' field in
>> TCGCPUOps.
>>
>> Since tcg_req_mo() now accesses tcg_ctx, this impact the
>> cpu_req_mo() calls in accel/tcg/{cputlb,user-exec}.c.
>>
>> The long term goal is to be able to use targets with distinct
>> guest memory order restrictions.
>>
>> Philippe Mathieu-Daudé (7):
>>    tcg: Always define TCG_GUEST_DEFAULT_MO
>>    tcg: Simplify tcg_req_mo() macro
>>    tcg: Define guest_default_memory_order in TCGCPUOps
>>    tcg: Remove use of TCG_GUEST_DEFAULT_MO in tb_gen_code()
>>    tcg: Propagate CPUState argument to cpu_req_mo()
>>    tcg: Have tcg_req_mo() useTCGCPUOps::guest_default_memory_order
>>    tcg: Remove the TCG_GUEST_DEFAULT_MO definition globally
> 
> Queued to tcg-next, thanks.

Thanks but I neglected to test on linux-user and found a pair of issues,
so I'll respin with them addressed.

