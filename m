Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5C8C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE78A-0001qA-8l; Mon, 03 Jun 2024 08:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE788-0001pq-Ts
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:49:41 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE786-0000eQ-UJ
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:49:40 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-35a264cb831so3854036f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717418977; x=1718023777; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=96hRe2basYjgPdOdUfJQMwXYK78xg9OLqAk0hS7o4CM=;
 b=SH4y2mRxWddb/Na70w8ETMeRJJcX2VK+Uim6TLuT1hu0a1ATm5bEh+RPjEiCBc2v1I
 LZ/4HnhFxD1ZchnMCfZqBPaP0+oiFuOF8ZfmjG07WezHJNejrC9OtXZBvVvOhrf+T1Oe
 KJ3xhYfMVPUqDySKeMkyhC/RF0FD0c6KGUxqOJ8uz1umfKXzqTqm6+0INzO3mS4/eT6m
 EuGw6R+om+4zuqc3RtqWPwh5g6+Xgoie/FUcdDSbnVdzVSP6EjshOpVaD+rPFvX5byZY
 HkeVIxA4BDbEJ2+Hsu1CCH2AGZQ/YQ3j7dAprrUFHIgTM8SF85rBJO2bOPg1oYvuPp/u
 Xaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717418977; x=1718023777;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=96hRe2basYjgPdOdUfJQMwXYK78xg9OLqAk0hS7o4CM=;
 b=cBwHzCggjLAy5rAc8/AOMDXbbGcygil9NAU7RN0ScQ8Uen3+BNsfxatXU055O0VmkF
 FDsLp1AjApfVoGP04b6PHTV7G1I594PI4F21Yj2ZZZ3FzkADUthfuzB3D0T3j01Wup/3
 aZhy/CB6L2e8MBVYwL5JAafuo+kEz3/SqaScESw0+UyRXoRKilpv5qRtAFXFQ9nV096r
 YFQit2w+FIj7nxYDz4M4m0CuNy+m+D7noNIXQY9uNmgiG+lpy3uPqKdkr6hV9qPSPLTi
 9O/yYAvAB9k9rQo11WR1BDq7q4oXpvog9e7nh+rfiYp6UvT2oxR+o7nN8Wy/HMvYu3Ro
 shGw==
X-Gm-Message-State: AOJu0YxNASXi7DngX8+Dh7loE38mlXB4HX+90dwMwugM2Tiuicis8TmW
 Z5G2FDXPQtRjJXmZ+boxfTl4O3xULroqS0pHrBxA11q78wBxMDmi8xPr6utAb1LGCMyb1YTvwu4
 0
X-Google-Smtp-Source: AGHT+IFRCA9N3H3BJhIQ1LDS/k3JC/p4W0hQE6MqMC+zv9o6Z6f37kZ9FpySgny4+hoDfz1LT8izZA==
X-Received: by 2002:a5d:6b4b:0:b0:354:e72f:d5d7 with SMTP id
 ffacd0b85a97d-35e0f272bddmr5873063f8f.24.1717418976675; 
 Mon, 03 Jun 2024 05:49:36 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04d954fsm8654706f8f.52.2024.06.03.05.49.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 05:49:36 -0700 (PDT)
Message-ID: <5da7229b-4ff1-45c6-8af1-abc2de7a521a@linaro.org>
Date: Mon, 3 Jun 2024 14:49:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qga: Remove deprecated 'blacklist' argument / config key
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, devel@lists.libvirt.org,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
References: <20240530070413.19181-1-philmd@linaro.org>
 <02ffad89-1f0a-4e75-9d4e-9e38b799bbf7@linaro.org>
Content-Language: en-US
In-Reply-To: <02ffad89-1f0a-4e75-9d4e-9e38b799bbf7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/6/24 13:23, Philippe Mathieu-Daudé wrote:
> On 30/5/24 09:04, Philippe Mathieu-Daudé wrote:
>> The 'blacklist' argument / config key are deprecated since commi
> 
> Typo "commit".

Fixed while applying, thanks.

>> 582a098e6c ("qga: Replace 'blacklist' command line and config file
>> options by 'block-rpcs'"), time to remove them.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   docs/about/deprecated.rst       | 18 ------------------
>>   docs/about/removed-features.rst | 18 ++++++++++++++++++
>>   qga/main.c                      |  6 ------
>>   3 files changed, 18 insertions(+), 24 deletions(-)
> 


