Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D1BC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 08:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzuVT-0001yN-3V; Thu, 25 Apr 2024 04:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzuVL-0001tQ-4B
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 04:30:55 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzuVG-0005SE-LU
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 04:30:52 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a52223e004dso74102166b.2
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 01:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714033848; x=1714638648; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tZ3/6YhofnYJIVLe11MJ4UpdhXlzdTRi2JtZxyvTnHI=;
 b=lTGID9KNHfaMkqbOIfdfktcTadym7hOmgvHpfnYGsBTJEzr8i/r74qY8TUTO6qlm+c
 cEs4jCWD705h4oA2EfK8NYupNArKjuwTBRqP/hjQv+NEKTzatnx1fIi+Au5je6NK/FqA
 b4uhg82jBAMb87QNJY/TzeAX3dq2CHibihLywNLqrzJve0weUSXIiqXB2P7yY3r1EU+G
 o7fpCo+7wq3V9v64hRcsQ9uqAyMeKO9/Jkz5jBQB39A6pn+9EGZS1ujrH/2picMbJ1mx
 8pCX3O+V5wt2P01E70jqFGgMlRDRLmnVI0pcEaTGDXRGvMizDqQXLBd46YE3rn2rZfpY
 12Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714033848; x=1714638648;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tZ3/6YhofnYJIVLe11MJ4UpdhXlzdTRi2JtZxyvTnHI=;
 b=rd7xWBkJ3iq6NjS5Uh5QOJbnfj9U9x3jODa2wrO3quMWbORggMhrbT68vtgS8EAuzU
 46OSryyGABjZ19Xfy9U5042B7aQB+ktOeSCeAd0QtKQ1eFLqS4osJ+Z7gW8KkHOcLIqu
 TWjyKaCJNhITUOpttr2X6MU2/8qLnghUqgTEMJsTmR+dVZQ0Km3MsQ9pKowt0/jkJwTZ
 hjYfTVzlPcf+ewPqdjT/IyaoG4LBX1QN8l1ScbSB4f/ltsnf6AxYIQodkGWjuzjNsB3q
 HIZ8+J/fCAVPGe3cBIjzHAdlsGTUNhvwwOk+u6Y97jEn1qLH4+qx+oidvtNP5r6P7zMn
 kZiw==
X-Gm-Message-State: AOJu0Yz2/kviMqyAi88Fkm971XegKQ9rJ3YKDGaGCE9KZWpvqdft/bOo
 4vUx07s3Inpyhxn2durvzq/Z8xao7sX8I6MXKmQ2ye7AAhWN1T/MAaVDyTeeezo=
X-Google-Smtp-Source: AGHT+IGbxmvKPuF7F+Qe1o2T+PT4u6mNxMQq2gs4ua6p8aEqwoV+d0VmlM+jfXg6mkwgsGfHemKX2Q==
X-Received: by 2002:a17:906:3b5b:b0:a55:33a5:9116 with SMTP id
 h27-20020a1709063b5b00b00a5533a59116mr4508604ejf.33.1714033847972; 
 Thu, 25 Apr 2024 01:30:47 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.201])
 by smtp.gmail.com with ESMTPSA id
 i7-20020a1709061e4700b00a52244ab819sm9434096ejj.170.2024.04.25.01.30.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Apr 2024 01:30:47 -0700 (PDT)
Message-ID: <86326b55-3435-4ceb-8630-e44ce3b15d93@linaro.org>
Date: Thu, 25 Apr 2024 10:30:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/24] exec: Rename 'exec/user/guest-base.h' as
 'user/guest-base.h'
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Riku Voipio <riku.voipio@iki.fi>
References: <20240418192525.97451-1-philmd@linaro.org>
 <20240418192525.97451-15-philmd@linaro.org>
 <mneadkx4ytvujstobsjifz7hoizsbbpes5opi7i2lyodl3tgs2@7jzadxaldrpi>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <mneadkx4ytvujstobsjifz7hoizsbbpes5opi7i2lyodl3tgs2@7jzadxaldrpi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 25/4/24 09:39, Anton Johansson wrote:
> On 18/04/24, Philippe Mathieu-Daudé wrote:
>> The include/user/ directory contains the user-emulation
>> specific headers. Move guest-base.h there too.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/exec/cpu-all.h               | 2 +-
>>   include/{exec => }/user/guest-base.h | 4 ++--
>>   tcg/tcg.c                            | 2 +-
>>   3 files changed, 4 insertions(+), 4 deletions(-)
>>   rename include/{exec => }/user/guest-base.h (72%)
> 
> Patch looks good, but the difference between user/ and exec/user is not
> entirely clear to me :)

Neither it is for me. In next batch (part 3) all headers are
moved to user/.

> Reviewed-by: Anton Johansson <anjo@rev.ng>

Thanks!

