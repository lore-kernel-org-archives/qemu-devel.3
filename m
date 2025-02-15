Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E3AC021A4
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 17:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjLfz-0000gh-0w; Sat, 15 Feb 2025 12:09:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjLfx-0000gY-Bc
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 12:09:57 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjLfv-0002tm-ML
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 12:09:57 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21f44e7eae4so58553685ad.2
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 09:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739639393; x=1740244193; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jb3Y2VqacpSG4XbrCYC4Oc49d4+mYGSqoEfeHFyZtuQ=;
 b=zYk8Y60zxKmtUTAibFZsXr+vy1lsag097vuFeef14ynjpWNqctJQWie3wdDbYONuZO
 vD5BSQeg457xVI5uLIjXuuQrfbjCsG2hWhFnzScL83PMqOkkzPE2wl4KIJQYDpFMU7Dl
 9wYr6KhNa418EIXrfEgjwKOu++KMH05Mu/suFmFx/TCK3iG9js+wel8AZJn1AuJsfNcL
 qdCkTP45VDzfFiExZ+LRb3EXuW6Oerc93ISKHoo80G0BsmJVZIOFDMbEwJUoYR+pdYjT
 s7XxaICjf4TTKyLvmKmfgRalK4+aerST+dhb4wblOa+vrV1UXFb/WnThuKdCg/ANYdbi
 rGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739639393; x=1740244193;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jb3Y2VqacpSG4XbrCYC4Oc49d4+mYGSqoEfeHFyZtuQ=;
 b=rtEvdXFQA4p6+swFMUDDXxbtwDdd4JbHZYZQ+dQkcwMPiiuIlD2RUBUvTO3TimYHt2
 z2GzLFzhvGV652lO9C9MU1M/FINpTyHFiwwAnKOFYjT528w5rZd1Z/6S7rOPbZohJY+d
 IXL3Yuh5mAZhYXiLniYIjl9NAq13NbCocZnUuHr3RUFht0z/0x0jaXMxbkPWZfTvPc01
 0B1EiOeYsTDfbfWnGNBiN/3k/Oaa3mMjmXm1HFMejYqxXBuATqIl0RX6JbdEiQbuh6cX
 JW7VU+rWNwd5IR+o7M/li+QiEDpupHNkVr6sxRd6AfGnMgE5ILZ2/9LMfh0wtQ1b7EPZ
 y/wg==
X-Gm-Message-State: AOJu0YxN9YJGUhwkU7kHPeSn2gK2DM1RNh2hle5iIyV8Pj+WamiYpeQO
 4hf0J0ogU197GfvDYgwUk71ciFRQPxAIVVVg8nfzSi1SQZEYwyOB6m1hYpNiJf5075lp9DYq6PO
 G
X-Gm-Gg: ASbGncvGaoc2HBdz9KNL3KkdRPoE9+Qa5+vByx6VYmHQfK3e5Rx/pCJxCO5GS+L7TW5
 EVaU62WiKGJSKiZ91zTNAXlJAQv6n791DHk4oh84Jyvus4nGvnpF/PpP8NGCaPgo3FCtFWyCdrx
 5giYFu4PZj6kzaRqOo05qAt2bExe9lavch0OiVwOhXWRbBcMoYzFcc0WNRxvA60IepKfp7fJ9O3
 fl3Fw11dFUPiy8GMlFXjdL521dgEEVFyrjHqMeCQjTvZo9mC2coXQ/2paDTav/rMi2C0lhtxFMK
 qgAhYY6uTNBI+K/ejOuTLcnfrMpN9SUrqEbSbQ5PrQkFCZ5jTEr1PWM=
X-Google-Smtp-Source: AGHT+IFiS4EeEduzMF/Wu0L8Lmuthg7uQqoB466Jc40rrnBje36qxt4ZdxDiF2IE2f1YCI1BoMwxXA==
X-Received: by 2002:a17:903:41c8:b0:220:c9e5:f94e with SMTP id
 d9443c01a7336-2210401243cmr58513935ad.23.1739639393423; 
 Sat, 15 Feb 2025 09:09:53 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220ea7a9348sm31660485ad.211.2025.02.15.09.09.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2025 09:09:52 -0800 (PST)
Message-ID: <21d559fc-1d81-4725-9523-60949a41e5a7@linaro.org>
Date: Sat, 15 Feb 2025 09:09:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] target/rx: Remove TCG_CALL_NO_WG from helpers which
 write env
To: qemu-devel@nongnu.org
References: <20250215021654.1786679-1-keithp@keithp.com>
 <20250215021654.1786679-6-keithp@keithp.com> <87jz9r1s3h.fsf@keithp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87jz9r1s3h.fsf@keithp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 2/15/25 01:21, Keith Packard via wrote:
> 
>> Functions which modify virtual machine state (such as virtual
>> registers stored in memory) must not be marked TCG_CALL_NO_WG as that
>> tells the optimizer that virtual registers values already loaded in
>> machine registers are still valid, hence discards any changes which
>> these helpers may have made.
> 
> I still don't understand the restrictions on using these flags. I just
> had to disable this flag for other helpers which only set conditions
> codes in PSW and FPSW. Is that expected? When are these flags supposed
> to be valid?

Yes, that's expected.

The state of affairs is not helped by the rx target's misuse of tcg globals.

A target should define tcg globals for values that are used frequently for emulation.  The 
bits of the PSW certainly fit that bill, because they're touched by most arithmetic 
operations.

However, fpsw, bpsw, bpc, isp, fintv, and intb are only used in move_to/from_cr and RTFI. 
This is infrequent, so simply loading and storing to env is preferred.  E.g.

     tcg_gen_ld_i32(value, tcg_env, offsetof(CPURXState, fpsw));


r~

