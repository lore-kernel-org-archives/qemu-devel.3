Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC781C30653
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpAW-0003b1-KR; Thu, 27 Jun 2024 09:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpAV-0003aj-BQ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:28:07 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpAT-0002nS-GO
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:28:07 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-706642b4403so1312585b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719494883; x=1720099683;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l0M/V+6MN1TB5i2xeWsRvtc78YlFuIst6Zh1syeTNyQ=;
 b=X1PcPiTDOeBDlG5snZDGI3HMEizHiDExNOgRGcV96khCwdvhjOPQy4UGexdDBtWQtF
 dk3py/F6l205iYQ03qPqvR6FFSrzzSHZhScDgiLQg/h+WsEW6W5UkF7YF1WpZiZ1CZdH
 B1C+e+y4gijoYvHNvt1IQ37KX5qdq6QCyreYItZzcQXjtWhACUl09HU964PvjUOHC5Vz
 Xm9/CXv9wdWM0iJEGVxameC2ynx5edQKxZBYwvWW9lx6BOshMVnQHvCLgqvaXLcIUoO6
 bvV1tq8Tc4zC7AlIKlQNjfQIKi1TBlrp1I9pVN9SoF+1ucXRL0hjwT/q4VL0kvsbumSe
 JrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719494883; x=1720099683;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l0M/V+6MN1TB5i2xeWsRvtc78YlFuIst6Zh1syeTNyQ=;
 b=aOzOOWtOWWW3SzOB05OAqylBcaLF+XI+BgtPEMyJ0QUxFJT2UjRqWr48qTsuKi+t7Z
 t8MV7qekG92eGqU+HNQcY3C8j59drqwjEj7boBtLIR5vCCe28OMvd2bmMyWlL41Mk7Z3
 GRLExv3DkMD750r/PVmu6uUyrs62oAjBgpleE4JK5gvm+knpi7Q8LHuwIBBJ7yjwhWpi
 5pKpj8fZrD5g66VjuAZR2IW2O6dnaU+5wU8quYPFsyKGbg/ur8J6INXtxIb1nhwN6u2w
 SRlwLmOOtWZkcp9vhCdmO2QY7AvTan2Q6or7BL0Lv/NJ9Z/30quz4DQP2ugjLIDojT/l
 K5Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf6Y/CbaZzKn4dG+RXF+k2I3DTCfzPUSDpAggJCxHeWueHxP9q7l3cjSVp/y5LqJHcHbOIuYaRsMzTfNznHs+honXKAfI=
X-Gm-Message-State: AOJu0Yw4PLTwwpUdsbgoyymw2LuaPrJuBJQdtjLYYW2BV96PmaRgLmDf
 St+l6ycgYOJyvSDLkJY82d+ADtdcUD+xLDXxsjy590Hq6KSmpWXOagzmnkI9a8AIvcAXTVZnxXE
 mLpA=
X-Google-Smtp-Source: AGHT+IGkESvHeW0+wsDr+Oqk/vtZiUzjfNANomyo8gi46PVb7QEP0a+RYbqMK9Q6QrLe1PvTHXIbFQ==
X-Received: by 2002:a05:6a20:4f95:b0:1bd:a03f:21f6 with SMTP id
 adf61e73a8af0-1bda03f248cmr5248410637.20.1719494883549; 
 Thu, 27 Jun 2024 06:28:03 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a072e5sm1313246b3a.105.2024.06.27.06.28.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:28:03 -0700 (PDT)
Message-ID: <d30df7ac-62c7-44cd-ba88-a7f757f034d8@daynix.com>
Date: Thu, 27 Jun 2024 22:28:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] tests/tcg/aarch64: Fix inline assemblies for clang
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240626-tcg-v1-0-0bad656307d8@daynix.com>
 <878qyrpzgw.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <878qyrpzgw.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/06/26 23:09, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> Unlike GCC, clang checks if the operands in assembly matches with the
>> type in C. It also does not support "x" constraint for AArch64 and
>> complains about them.
> 
> When are the test cases ever built with clang? Is this for Arm on Arm
> testing only?

I ran test QEMU built with clang on Asahi Linux.

