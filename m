Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B621C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 12:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA6oH-0007O3-6P; Wed, 30 Apr 2025 08:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA6oF-0007N8-Bv
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 08:45:07 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA6oD-0001xz-LE
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 08:45:07 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4769f3e19a9so50646751cf.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 05:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746017104; x=1746621904; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=acnSy08jpG7LX5BTCugl4+MANK1btLlt/RkiyplDCP4=;
 b=c0ClBODUajPH/g3WtopEWOwU+Hy2oWCRAKh+pXX6ZYxYc5RLv/bJFe8WYRFWL70tZC
 G+c7oI5toPoqa0518h7ErtuacEgUe0WBK4ZsBc2P7aikZRwD32D/HY55J4mh5SrBg/Q/
 Helb/wfZNoldz5AbZRb8ytSe/qxc9aQ53/zHP6i3K0z1RILPhLJ3LVlKrUxCex8dFaoq
 Cjtit3k4HyHZVOuJabvPOMQufG2mONT481if0viG/ObGrqoizx1Dmzj2zMokvwXgtCIA
 Ox8E35CJrQ1K8jfdGmThNyNApaAq/6hgcBcyGchrkoDp7c/wTBGDo1k5dySHtpt9gDof
 ELPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746017104; x=1746621904;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=acnSy08jpG7LX5BTCugl4+MANK1btLlt/RkiyplDCP4=;
 b=fCqT31rOcRKWsv6tj83rhbzsVROD14hP1B8C8jeFBVAi/w3yZJO+RlXrLci1x41VSt
 JpQB4PMHM6PJtcfCRKhEP6In9MQqQXuyTLOgAoMGJyrQauiSunHYYQV9SZx3OmRz/zub
 iE5LF0OlryMoOr8BVF+z8CrNxsh3MPbCygM6oXS3zUSz2xaNhphtctOBHuqYdV5cMvmk
 bp8J+4k9TybSXNv65trB4SgBU+w/wuUH1oPhp4kFix5Yb2Yn6OjWkmHKXdwJjFr6t6Za
 qSoF4voEfVl8OPu0qdNeb4v3laTxLegIcY+NcZScVfnH8s+0NhW2Z7CXwqbIsdOX9Fnr
 lQjQ==
X-Gm-Message-State: AOJu0YzcEj7cni4FEDsCS/K1Kb67CInxhES5AzX0Erdsa7NuH5cRmjso
 uLjWTJei9+Xgu9ObnjovpG0WxBcNT9wXmTmPotyUxnmRwhpi8/gesbqqioeyQ+w=
X-Gm-Gg: ASbGncuSnBOI16QJLc9Yo8tqdLwDwcgcUxYuncJZ/M2P8J8EgDAAUMdqyC2I+AeAE5k
 KTUhCaHqoLd5FNWo2Y/msXZPn/TrbXVgzaMc8MS9pJVJY5J0sqIsqBFpNgUyqYJdDoVw1daYIZ0
 th+PlAIu0fhHEWl+xvondLuAk/PLJItW6U63y+P4r4TSy4HrBaz81Qfch4fNnVWtBX0BZu8q+cR
 mFvGkK9DQNTKrkZin9GSbt9629UQeUoIgCc5Z4vwf5bSf4tZrmh3DjE7vyD0am2Sh1HFFv0dumL
 TQzKQm5i26s+dhof2D67SJ9T4jkw+GikCjTcVysIHLBb8hbkt3SJ65PB9F/jvjOQ+sNcdR7reJz
 szzE0MqB8Ge0wAA==
X-Google-Smtp-Source: AGHT+IEbsXsEbw6n3vkC75V7E19nh6E92vVTTnFN1CtdSjeU73MdV0JiwyaYE1yiTEXJIiRT9UZo9g==
X-Received: by 2002:a05:6214:d06:b0:6f4:c237:9709 with SMTP id
 6a1803df08f44-6f4fced8f30mr52417876d6.25.1746017104009; 
 Wed, 30 Apr 2025 05:45:04 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f4fe6d19c0sm7771356d6.42.2025.04.30.05.45.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 05:45:03 -0700 (PDT)
Message-ID: <f63b5842-a99c-41e2-9f4d-beb91e486e16@linaro.org>
Date: Wed, 30 Apr 2025 14:45:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] target/microblaze: Always use TARGET_LONG_BITS == 32
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250212220155.1147144-1-richard.henderson@linaro.org>
 <aBIE3j1lpNTvisKX@zapote>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aBIE3j1lpNTvisKX@zapote>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=philmd@linaro.org; helo=mail-qt1-x82f.google.com
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

On 30/4/25 13:09, Edgar E. Iglesias wrote:
> On Wed, Feb 12, 2025 at 02:01:46PM -0800, Richard Henderson wrote:
>> Use out-of-line helpers to implement extended address memory ops.
>> With this, we can reduce TARGET_LONG_BITS to the more natural 32
>> for this 32-bit cpu.
> 
> 
> Series looks good to me:
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Thanks!

Richard, FYI I'm going to respin your series.

>> Richard Henderson (9):
>>    target/microblaze: Split out mb_unaligned_access_internal
>>    target/microblaze: Split out mb_transaction_failed_internal
>>    target/microblaze: Implement extended address load/store out of line
>>    target/microblaze: Use uint64_t for CPUMBState.ear
>>    target/microblaze: Use TCGv_i64 for compute_ldst_addr_ea
>>    target/microblaze: Fix printf format in mmu_translate
>>    target/microblaze: Use TARGET_LONG_BITS == 32 for system mode
>>    target/microblaze: Drop DisasContext.r0
>>    target/microblaze: Simplify compute_ldst_addr_type{a,b}

