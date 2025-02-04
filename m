Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CD4C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 17:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfMwH-0001kp-0Z; Tue, 04 Feb 2025 12:42:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfMwC-0001kO-9e
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:42:16 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfMwA-00080m-LN
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:42:15 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2f9bac7699aso1784622a91.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 09:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738690933; x=1739295733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gx3nrC19vqRv8FAbpIJfoKpcehpmLqxlSfIicSN9CpY=;
 b=IpE1xOxYqrGdyklOaqHnJkLAT+QZIjPBvPdUNEMcsxqps0MBlurDYv/Qx3FWPkJIKM
 dSEdQWnhpdqRAuzzZPqWLAnYedjTPoZPTAnuo0YBCuRt56RJt1+jioMm11+6Fkik0SRK
 36nyQfiIe5bEN/eyJyAs1yyp6i22WY3FnD75SzF/2vo7dE4UqoS35bjsHtrJwCseZTLl
 npWmH73JZtxHww1RVMhOGbZYAlhYM4x1FnmvyGTBvqx0aK5Fpxqf/ahk3lwi4Lf+9PzC
 DbO4gRblgTA/NNx0OgyDFgzLq+tXuOVS+eYzsJ0bQln5ThtYkJzNccddFxYNhJCVMUQo
 WGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738690933; x=1739295733;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gx3nrC19vqRv8FAbpIJfoKpcehpmLqxlSfIicSN9CpY=;
 b=E950ts2DzV0Fy+OroPlivuKLzViTp4wC0759VJ5eV7cAAmAXOWKZCSNKmwArblrQig
 ghxWN7kDlogq5+dMMr4jaOTWzx9kxaLQ6/jiDJrsnaeOxIoizg7UA+r59ek5wcCKHlAR
 EvQ2Iei7hSFIGXjT7O5PAf1ToR8xE/tpfPFvn7R1uTDqbvEqdvRRm0w5i7QMddffVorf
 7td+N1KgZEGIfCQ0YYyCEEia6M0WNrirNITrEFG/1Pj2+BaDRQ2cA0qAs7FlmpBDGKuy
 0fK5kJsfAfi09HmsOZt7YRx8ziJB2kVEnPwoTvldeej9hsUfahOYwTvCmhYtd9ZR+roO
 TlRg==
X-Gm-Message-State: AOJu0YxxLHWsovKZLOkNAlFtuC22Lw0b6RiUCfhuAtrF/bWawgXj9LNN
 3oag8H8JhHA1om9yLK/0Imr2MPfxPq49MdU7oaAs4I7NynlEXmiUYhhOOJ8tyyg=
X-Gm-Gg: ASbGncs/93kkC4UHTL2g0RGlB/v56fwkLtu6m2TBUCByCL5ti7WULI8MpM9fyCqG/zL
 /fsSjoHx9d7WTGxC5JgB24KyjdSAFBa7yUnbsLYY6eQiXEDHB4b/VdQyDthepHpfLiKFyHf/1P8
 miDgkX1alAYTySwVEOAPsyBfL80VoxBjqBJriGeYFhOo5DmK1sIqEfgWC8VxX45TTLUpcdR2Y19
 +htccFJK9rq3Rk3jzBZXZlGLb1IEfXA5xw7FMWmQeJjitLgAmDJVxFMo7p3MhHcs/zGT+fuE9ks
 FXQOA04C3n5wV+Mc05fodIb2k+Y72N9uVHse3g38D66kVIUlsxl1oWI=
X-Google-Smtp-Source: AGHT+IEBUFQ/rTUpeHbWYkAlwTGpoBqHn71c+/rij0V5kOmZ1llWnQc4n2LOJMn5tphJQZP6z6iXYg==
X-Received: by 2002:a17:90a:fc44:b0:2ee:b2fe:eeee with SMTP id
 98e67ed59e1d1-2f83abfa2f3mr40981064a91.15.1738690931181; 
 Tue, 04 Feb 2025 09:42:11 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f8489adfacsm11483582a91.11.2025.02.04.09.42.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 09:42:10 -0800 (PST)
Message-ID: <f64811d6-e489-4e85-80a1-527fd93cce26@linaro.org>
Date: Tue, 4 Feb 2025 09:42:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] tcg: Remove TCG_OVERSIZED_GUEST
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
 mark.cave-ayland@ilande.co.uk, berrange@redhat.com, philmd@linaro.org,
 thuth@redhat.com
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-15-richard.henderson@linaro.org>
 <87cyfzceon.fsf@draig.linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87cyfzceon.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 2/3/25 05:59, Alex Bennée wrote:
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> This is now prohibited in configuration.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> <snip>
>> -#if TARGET_LONG_BITS > TCG_TARGET_REG_BITS
> 
> Is it worth keeping a compile time assert with a comment so if anyone
> attempts to hack 32 bit support back in they will find out quickly?

It's there via the assert within qatomic_set().


r~

