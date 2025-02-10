Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24821C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 19:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thZ12-00084B-EP; Mon, 10 Feb 2025 14:00:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thZ0q-0007xC-2C
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 14:00:13 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thZ0j-00024w-O7
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 14:00:03 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21f49bd087cso61828225ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 11:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739214000; x=1739818800; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q3CDA6ODBfpHSpmOuAxD23pMTfXHOcQlipMNY29uzQQ=;
 b=yam32Av3rbeErE7JkX7Mddfp1dMgyjwjkzmLwlzpjOMoBZz0XQPzZTIfe2tBpts5f0
 So+Cqa3xQrrtFWaebs+WCdv9Cw7p36C704br1KFwQZzR7dCephrzfJ44Tvbh0ZZFiOLJ
 0omwtUlf3s3zEf+sCIQn28sHxG4qtWZUwRorRO612FuaY7tJva42AJJBmuW75N7NxjVT
 wrKuZ8xvRvTqWAIqdvilEts7iI6cynJwcmi0AkZMEkNe1YWC9AaLwi4T08jbS4dYDOvq
 2l4x13sAhCL4UhOGkYXS+f/wFJzHamFNhFYGjxWghCoyz30MJGSYiDKMoqbGR4hDx1Ys
 AdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739214000; x=1739818800;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3CDA6ODBfpHSpmOuAxD23pMTfXHOcQlipMNY29uzQQ=;
 b=wE4cH6CbyQ/tuXryKaWppR8zUJklm3F84jE/ujpSa6lJNeOkssWbsOR0L02r5nDa5Y
 Z7X/8J0wACkrQU2e02Wh3F2VUI5WTymOlvl+57EBmuRq7aPIUw5omD0G82QgsPWwOFZh
 k7T1ZVsjTCIy+ZL87YaE7cdnvpNxFCDPyIJDkh3eR8M12HPU2BCNhFUN2U1hNx9b1Q80
 7nW2DH8K4HrtK8OgshNZkNTXkfwnnegRv36WPLcWukR6LAkUtXIwV8RC6FuKkvyunM44
 got7HdOqrxXHL5hODbyWsUc9dlKTWqtTeFwUp7jpIIgFHmrHmbbhMfZle6VqDGTBTwnZ
 gBSA==
X-Gm-Message-State: AOJu0YyloX17I9y/zggo7eWWEUdGeqXxVzoEh7flZIypG6NbMR4aj8vN
 UWelOj8mh6nzPUlt1JRwcEIDJ5u+G0HzJE50kcTIPkiZWkdAs65ilmS5z1ggTwPfHgN0VhAT+i0
 p
X-Gm-Gg: ASbGncsbrIRxmWCi5T/2SfC3BPC75PtJaw5VjGyqJ+E19sCE+JW2vzsahZDNH4Drq3C
 MoARYTPgzWObKgzFqE/xwwNtgAqTNw5RHEw+uonK2/dgG+av+G/8tB9boGlyp2yZxhv9UKLLVNd
 DwRRL+flFSmOXG6KjzVVXhN2Lq6AO8yl7Kul4oyZPd8PhtS4kd9thTWco+txUaCxxsTt/XJoFm+
 i5NFaev2YjORQ4jGZTBXerjt8F0TEVhoxmt9ISex3xl5ywHY3GSf74d10MhKN57f/qKcyym+x9f
 WNn8tUQlROLgThDmn0LVQP7qIUYVllPyyFDL8eNFbEnOOmY347xzX/8=
X-Google-Smtp-Source: AGHT+IHY9YXqQliCAo7Ppbol1oq3bNLcBAZ3zDH0P4ztpt7/YiysBT3+K7OVzE1ekxfIIC868ZPlvA==
X-Received: by 2002:a17:902:cec6:b0:21f:831b:ad4 with SMTP id
 d9443c01a7336-21f831b0dd1mr116639085ad.21.1739213999773; 
 Mon, 10 Feb 2025 10:59:59 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3687edbesm82549325ad.177.2025.02.10.10.59.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 10:59:59 -0800 (PST)
Message-ID: <4523e449-58fb-45c2-ae92-2a9d555b923c@linaro.org>
Date: Mon, 10 Feb 2025 10:59:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] target/arm: Report correct syndrome for UNDEFINED
 LOR sysregs when NS=0
To: qemu-devel@nongnu.org
References: <20250130182309.717346-1-peter.maydell@linaro.org>
 <20250130182309.717346-5-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250130182309.717346-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 1/30/25 10:22, Peter Maydell wrote:
> The pseudocode for the accessors for the LOR sysregs says they
> are UNDEFINED if SCR_EL3.NS is 0. We were reporting the wrong
> syndrome value here; use CP_ACCESS_TRAP_UNCATEGORIZED.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: 2d7137c10faf ("target/arm: Implement the ARMv8.1-LOR extension")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

