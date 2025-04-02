Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39683C36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 20:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u04hv-0006ix-US; Wed, 02 Apr 2025 16:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u04ht-0006hS-Qh
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 16:29:05 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u04hs-0006Wb-0V
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 16:29:05 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso1002565e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 13:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743625742; x=1744230542; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bVddreunLW8sv+urwFWfC2ocakSXidT+jQdXwIhpAW8=;
 b=H1D+PPQXNvDXdUpzSFutxI9ZUb+ESAxSNL3fLb+iL2V/Z7roYwm+5SLuvtsKrJfDd9
 nVsWW70mjReSGc50XEc7WbkNevtuBCwyQ8L7xNiu/VpIS6IyRC1T1bvwkz16/ZKsdSFR
 UwkqfexlF2VwoXPX1dM1DILIYMAEhpe40DJyUD6EbF/JRUIUkvu4siCoYJfVA8fr10bQ
 UjF5CCfoFuGTxBjeVa4lE0gPpANAhBS6m0PHs7rTybQ3ZH/2UTIF/ycS77K4KeEQEY+A
 P5L1z6NOBUyVbSFvqfFzhBASd3MWFY1QH+QVHF2e2E1pcSrDF0smzYGV4R7n6dm4Alfd
 M5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743625742; x=1744230542;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bVddreunLW8sv+urwFWfC2ocakSXidT+jQdXwIhpAW8=;
 b=VzFmQUE25pp0cjoLcL+Q/bYFIOCklyQ8N6swDNVbEAeuc83m8vfUYOlReZlzUP26Ku
 b+HAwbion6HaVLOy4kM4jGCENonBkrqot4W+ZhQFAQ5lt96wpcwudgBv/PLSoYtaMwun
 ilQnXrPR8vx/xsA/hLyoq5To+VHA3uagxQ+wYrK24oULuU4zNMlAgOmsNe+gFPrmPhHI
 wcXNN+qENqQ21XBPSDfrN94KufF7Okr2a1nhPYD2+/O4B14qTT3vJWkybyPDHHikfqCS
 i7EAlCZlUxqFrTgxx2Ke9xg42c6DlfZ7Cu1SErF7bZBm32ZjVr1LKEFBFUmKGp53R3YR
 I2Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqcnbIEoo8f4y0tavtVAaC+LFO/vQGkzhCHw8elL5D7gWrLEDaYTzbNl94WOausHkDauKRo1YpNjxP@nongnu.org
X-Gm-Message-State: AOJu0YxplBfTFF7sn9e3qB1Xj24bUaTkKZaQfNovH0Ch6hzco6azw5V9
 TzFZs1kxwgra0p3IWubln9h+5cjOwL47mn+S28K824LxmitlLrlh1w+gUJrXi/CMQGr6BxVmsz1
 w
X-Gm-Gg: ASbGncujfmyXWYfrs8TqyeO6xyal70NjznsQy0nrYi0obH9XLbcfsi7pFysiJ9F+kSk
 Mzx5lIRzwvBvmtLYmYV+BWkiN3k2pT6kdnguDj5r65+KUtxbjfK/wWJDMbqRdZfO40LE1aLaZYB
 CHjVXy8vD9A0fthx7SN5CQv2ucIunmN485N+A+dqTHf368Sokgte9DL3pwTSxdBLU6HU/I6YO1V
 xdqQaIY+Rg4edDkkmCrkbBYIYi+dB35iaIYyZC1Gn3NHZmij4xllscvRJIBgchl1jyQ/h6056C+
 cLgz8WUVP2PoDBbo7wwwTBILL4GbkfmqyoQtNxz7u7BPr7PCY24N4c3NH7HPhThJl2++ng4dXbK
 V7jAMIIOkmCOq
X-Google-Smtp-Source: AGHT+IGdee3569bX17pmeRy69rsgOP/gm1VbT6udX9T7RDVyvFYl2d2VYBSfCnkJ15jR+3USNSmrXQ==
X-Received: by 2002:a05:600c:1547:b0:43d:47e:3205 with SMTP id
 5b1f17b1804b1-43ec13acf9dmr1451195e9.11.1743625742525; 
 Wed, 02 Apr 2025 13:29:02 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1795782sm1073935e9.26.2025.04.02.13.29.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 13:29:02 -0700 (PDT)
Message-ID: <ab4adb5a-958d-4a54-ac96-b008e4866900@linaro.org>
Date: Wed, 2 Apr 2025 22:29:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 v2 0/7] tcg: Move TCG_GUEST_DEFAULT_MO ->
 TCGCPUOps::guest_default_memory_order
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250321181549.3331-1-philmd@linaro.org>
 <90135439-b3a0-4e31-84e2-ce29b90db593@linaro.org>
 <9a5958e5-bd09-472f-b11b-15515af661a5@linaro.org>
Content-Language: en-US
In-Reply-To: <9a5958e5-bd09-472f-b11b-15515af661a5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 2/4/25 22:27, Philippe Mathieu-Daudé wrote:
> On 2/4/25 22:00, Richard Henderson wrote:
>> On 3/21/25 11:15, Philippe Mathieu-Daudé wrote:
>>> Since v1:
>>> - Do not use tcg_ctx in tcg_req_mo (rth)
>>>
>>> Hi,
>>>
>>> In this series we replace the TCG_GUEST_DEFAULT_MO definition
>>> from "cpu-param.h" by a 'guest_default_memory_order' field in
>>> TCGCPUOps.
>>>
>>> Since tcg_req_mo() now accesses tcg_ctx, this impact the
>>> cpu_req_mo() calls in accel/tcg/{cputlb,user-exec}.c.
>>>
>>> The long term goal is to be able to use targets with distinct
>>> guest memory order restrictions.
>>>
>>> Philippe Mathieu-Daudé (7):
>>>    tcg: Always define TCG_GUEST_DEFAULT_MO
>>>    tcg: Simplify tcg_req_mo() macro
>>>    tcg: Define guest_default_memory_order in TCGCPUOps
>>>    tcg: Remove use of TCG_GUEST_DEFAULT_MO in tb_gen_code()
>>>    tcg: Propagate CPUState argument to cpu_req_mo()
>>>    tcg: Have tcg_req_mo() useTCGCPUOps::guest_default_memory_order
>>>    tcg: Remove the TCG_GUEST_DEFAULT_MO definition globally
>>
>> Queued to tcg-next, thanks.
> 
> Thanks but I neglected to test on linux-user and found a pair of issues,
> so I'll respin with them addressed.

Oops, wrong series (I meant the one about TCGCPUOps::mttcg_supported).
This one is OK.

