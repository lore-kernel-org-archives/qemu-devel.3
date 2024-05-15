Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE41C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79AQ-0001Tt-HH; Wed, 15 May 2024 03:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79AP-0001Tk-GA
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:35:13 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79AN-0000ix-Jy
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:35:13 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-350513d2c6aso3663149f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715758509; x=1716363309; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6mSEDb3rx0HZDWpSEnJ/vQZewC/zq/hEOJ73qIE1ey0=;
 b=dQFbZQTq78bIWoro8n5QeIq0N2h8mNHCzokPoj9Bx6G4UwUCLGiCPN3lT0Yr/nQazX
 hVGfWibM1TZhTL1w4LDl6yGF/mgkTDSwLgaFe6dNFGF0+YkckvrwQIjPRkgNM6zNaQLb
 sxazzY6O3pLHoU49SH/uuVGEFEQfxIo7JP8VSNm8e46OFawYM79cVoqBbPJCx941K7cX
 ay4Tzr4J+U0CEkgfUkilkgDeNEtj0qeT4DMG8Pems7q0cATh4l/7PyvNYqLsmLdn0AcX
 Xe9PYNYZm2nnh6/bOy2SAK/aZQXKhJvomTCjYa86p4JclSiQwcNhESSavdBQlV6+rNwt
 VYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715758509; x=1716363309;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6mSEDb3rx0HZDWpSEnJ/vQZewC/zq/hEOJ73qIE1ey0=;
 b=kBbU50z6A3Q8Ymi07bj7MZr6RRZOr95YZuY0faBNCQUiaONgteE961OPrIcByCW0yM
 fjGdZZS/pciZK2dsY8vTbt+hSqRtsY8Gzkm8lbOGySjh1N8RxpCyvjk+VTmBA5iYVsdE
 sIELWnCTbFMuCS7ihj6BQS6Qqh2UzfbAO4woQQx0WHOIrrtJ42ynDrLusAuEFLpiVhhN
 qcDAl/4s8JSgBuvUbDwCB1wpHZ6ZAJRLziiMxIWMB++G8R91MhYg+R0rowbeLq2NQN7g
 DupEqPW4ypGBbP/+jq9O7CAnnYDCXOHJjGuP+UyNjZ14M/T9v1LPGcnF2Tx8Bi75oX7L
 mLgA==
X-Gm-Message-State: AOJu0YwofBAA9I8zJAF5hGX45Ca9tjZSYHBYT3KlQSujp86Pj6V/tGAs
 kUULzEltK6vKHgP2xXhE2vMpofDgPm3HEiDL5/UltryOcwO9+34hrFvYiEP/Ljg=
X-Google-Smtp-Source: AGHT+IHkMsSXC4WNFQiLWQA4nGYUE0DLbHBYuD6nO/0vKLM/bpTgSQxOC7ozzEzZxxPw8553mFEPHw==
X-Received: by 2002:a5d:46c7:0:b0:34c:d9f5:a8e with SMTP id
 ffacd0b85a97d-3504a61c6demr12003338f8f.7.1715758508980; 
 Wed, 15 May 2024 00:35:08 -0700 (PDT)
Received: from [10.91.1.91] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502baad1f0sm15811414f8f.89.2024.05.15.00.35.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 00:35:08 -0700 (PDT)
Message-ID: <e54b5ddc-b2f3-4799-93f2-8b46d2684c5a@linaro.org>
Date: Wed, 15 May 2024 09:35:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 32/45] target/hppa: Store full iaoq_f and page offset
 of iaoq_b in TB
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-33-richard.henderson@linaro.org>
 <ZkPFj4AUfzL5t0wZ@carbonx1>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZkPFj4AUfzL5t0wZ@carbonx1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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

On 5/14/24 22:11, Helge Deller wrote:
> * Richard Henderson <richard.henderson@linaro.org>:
>> In preparation for CF_PCREL. store the iaoq_f in 3 parts: high
>> bits in cs_base, middle bits in pc, and low bits in priv.
>> For iaoq_b, set a bit for either of space or page differing,
>> else the page offset.
>>
>> Install iaq entries before goto_tb. The change to not record
>> the full direct branch difference in TB means that we have to
>> store at least iaoq_b before goto_tb.  But we since we'll need
>> both updated before goto_tb for CF_PCREL, do that now.
> 
> Does this sentence make sense? ^^
> For me as non-native english speaker it sounds wrong, or missing commas,
> but maybe I'm just wrong...?
> Other than that...:

I reworded:

But since a later change
to enable CF_PCREL will require both iaoq_f and iaoq_b to be
updated before goto_tb, go ahead and update both fields now.


r~


