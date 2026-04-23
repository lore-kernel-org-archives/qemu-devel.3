Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE829F589B3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFtfE-000542-SZ; Thu, 23 Apr 2026 09:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFtf7-00053S-76
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:00:09 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFtf5-0004Ak-FQ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:00:08 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-35fb7c1a455so2587784a91.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 06:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776949206; x=1777554006; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O+sgP29uMaU8WHbJ/EjASH6nCteNCOPnKVzqlQC7zHc=;
 b=my++W8L1vbyw+bMz2+UBEQZk/EJVJwQbCRzBGKpZVpD3FH4SRg2GAiStnzhfo8kvWJ
 iK8vF/RG6q+FAZFWUeVRgp+gFEWVkR5B/o3mYui3qpSa/h4Rsv2laGVQfqVgP5lkPTJn
 j8Wz5aDwH6b1Kstc7yGbJf+jw/T06Cgrl1hoOdzRkcMDgRq4czCuS46pIKl4YGmTWD9p
 oCFy3hLc0BzQhTfnaNI0n8VhulkInOkedZBRphUZpI5Q+N8mhxa6o/iAQn8r5vi7lOiF
 k0GYyTKwzdxPSI4+j8L0ZMKyr0qm+xUMQlafTTfs4si48rR2dlU259oZ4vY96/0EKeTn
 mRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776949206; x=1777554006;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O+sgP29uMaU8WHbJ/EjASH6nCteNCOPnKVzqlQC7zHc=;
 b=X+6THKLhYeRTRG2O+BRmUMtaon80bdqAKuAvj3EtKxqAjpsxErYrnXvFgqCUxKTUhl
 v008+mgfOpgtbMzWGJdmdglAhcyOKRfstJnKGHTJ5+OAE5hWvSe3KmphKCpyh7RQke5V
 1VfL5L5FMXp5ca46HP+x3OgGmDWtNM/gNnbMs7jwAFlsRmfGxRLxPB0/CEZqFYrygYgv
 3aFzNwEwFaabxZkdyMZmwMxZo48yFeFfigi32/CgIDj5D87YZBdE160EBR81sCRLUuGm
 78AVFPOTwG2NfesRfImJUIC/mLZHY5sHACSYCVkAJqDYmqd9wk21juqTIfA11RcbeM1C
 k00Q==
X-Gm-Message-State: AOJu0YyMFqHNfbepga8yU+9T/l2j7F7qlFunRFZtGxlKtFxXJzFJaEBm
 Zi+M34VHbJBPo/y/pXycFHg/cSXi1y7AIxzod+l9cvZUmoaIaoV7Bq4kZKP0R9CGuOo=
X-Gm-Gg: AeBDiet7B0VC2OpZf6JHCuqtpeN/lv7A7pl2Ynl0N2NLswR/O48w6uYzo0B8JWvjInf
 O71T0N4OJ6Rs/rISulSdTFCHeBcDWWTAMMmqFzSko8ZKvnmuNSOzQ/ckedx088PkSUWjmOuPNTJ
 n/GDx8oVKC03clC1mcI5vwAl0us6Iv8LKS4zpWMXxl2i/+Wj9WRYaAJMC4SjnGwqyK4ydrVzxqd
 WQCfqqvYxm9wusvlLKXa60rJBmYGGW6X06VVYtcmpGFuNmcFIMBWDxCR9RpP86ALM0+QeDRFP8t
 /91w31sSV5F7bTc9I4NtGYHBDXgmm6KUhmbNjbY4T0/9RjXsyiYot8K1qvf0Q0ZA7qVIWW/VahB
 PQpTRIy7EBd6bZ5RBQh4FI30fbC89ZYQh7Mph1/ZdqQTWlm9nkniM9p9HKngH4Rpu2Nhxj28YW6
 Zfj4jM33IwwW2sQZn3XrXMBnHjIO+DUPhel8S3QzzHbwI9WCkYrA==
X-Received: by 2002:a17:90b:384e:b0:35e:5a24:3c43 with SMTP id
 98e67ed59e1d1-3614040861dmr27920163a91.8.1776949205417; 
 Thu, 23 Apr 2026 06:00:05 -0700 (PDT)
Received: from [192.168.1.134] ([110.239.0.232])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab3ac1fsm207328715ad.70.2026.04.23.06.00.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 06:00:04 -0700 (PDT)
Message-ID: <8c223aa8-f8a2-485a-b9db-56b022d86cc2@linaro.org>
Date: Thu, 23 Apr 2026 22:59:58 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 29/32] target/arm: implement global monitor events
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
 <20260422125250.1303100-30-alex.bennee@linaro.org>
 <ede428ce-a99e-4630-a000-7d8356f08ac7@linaro.org>
 <87se8lx4jq.fsf@draig.linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <87se8lx4jq.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/23/26 22:08, Alex Bennée wrote:
>> Um, no.  Just because STLR is used in the example, *any* change to the
>> memory region must raise the event.  There's nothing special about
>> STLR vs STL vs STB etc.
> 
> I think in the context of locks the release is important.

No, it's not.  Notice the aa32 example uses STR.


>> The only thing I can think that would handle this is to set up a
>> watchpoint in WFE before going to sleep, then wake on the watchpoint
>> trigger.  Disabling the watchpoint on any other wakeup could be
>> annoying.
> 
> The global monitor and the event stream are different things though. So
> if we are committing to fully modelling the monitor (which would also
> solve the ABA issue) it couldn't just be active while doing WFEs.

I didn't suggest fully modeling the monitor.


> We could generate a postscript for every store which might be cheaper
> than slow-pathing a whole page for the global monitor. If we supported
> sub-pages maybe slow-pathing a cache-lines worth of address space makes
> more sense.

Not a chance.

> Another option would be exposing a exclusive address mask as a dedicated
> register to the backend and making the check part of the softmmu
> generated code?

I'm not sure I understand this suggestion.

> I guess we could put the monitor active state in tb_flags to avoid the
> cost of code generation when no one uses ldstexcl because they have
> access to far atomics instead?

Monitor active state is a global thing.  I really don't see how you're going to 
synchronize selection of that tb state globally.


r~

