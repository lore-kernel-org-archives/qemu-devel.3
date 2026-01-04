Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5E3C2A070
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Jan 2026 23:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcXmo-0002gO-Qn; Sun, 04 Jan 2026 18:45:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcXml-0002fs-Oz
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 18:45:25 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcXmj-0003h0-O7
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 18:45:23 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a0c09bb78cso9071885ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 15:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767570320; x=1768175120; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5Ldq22cQzenKIc+XVXMbmrdzI3fIf0MLJBNY87E6Cyo=;
 b=N3gUYGVT9E8jrTQIGVp2PTK/L2dIDN0237MJGCxN2/hSdW+Ch7k4WInV9zzrviGwa6
 fQx4ylPzYkjtSO/tFyKMW9gvk+gf4vPddSXp9XYBZc9xEoMVqcP6WSKfNKCmqW+B9gZJ
 5OXkx1IP9Ig2GiIrS9PmtUXbAq9YzCCNqkS/dlpdRzJGpVgXw895a+zo1cnAMt+YWL+9
 Dj4XyUfVVmxS367oKVcRMHuYsizGpgfbvLO61kV5by0hsAWKw2UppCmOxSYd0nwEjgdF
 9WtuEhcep1zv5v0BN0xhcuKTSGEVJQxeiOUHecFAncKS8RoUzcUChK6E2KrQ9MbXPWFO
 Marw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767570320; x=1768175120;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Ldq22cQzenKIc+XVXMbmrdzI3fIf0MLJBNY87E6Cyo=;
 b=n5NbNTXTkCNcyvKaVu/qsYL1pEiXQtF7Imuymke/IGcnyRMPPjC5pHoMJVsyOW1Djo
 7rDbd6bY3+LQR39wmIOOrl/A0epqwsMFcCTECr0RdAdefwxvNOzz3NOTLzq2v8vNbssF
 U5fCPXvtH3drt8QINeT/vnICyjGolyUfazyH0gYB250ZH1QMaev0KR2DvzXvaJ59Iuvg
 tXPLIL1rUC+5Hw8Dye/j/8bKKDmd4/ieqkBacLj79k0tsPs0nb3f1JMfCgiDBw1p547B
 REgMv3N94Tf0ze3izAcYGwPUf6zK3AEkUyeTKFzU8sa+qjHnXumwTq2sE8OOPaxOw080
 ttvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZuYbaUEwBvTdOV1icmatQHAckj5/MkceLV4rmdUhyV3tU91w8KGgjIIX5waNcli1gGRAEYf40/ane@nongnu.org
X-Gm-Message-State: AOJu0Yy3vV3bUC4Pgis6PTOFXZLsg9oqfOWwNm3mO0WCn/NuaNHF8WuN
 /buCbgRlRN8K2VjKyxHH39z3k1HznEqwW1P0e4NU7zUqymIzyo1tjFQFUwPX9uWp+ZojpPVJpZa
 drqCcQaM=
X-Gm-Gg: AY/fxX7IAohl9wrsIISNHLpuPI80Q62/68Wsp8TkFV3M6yLj0dsc54sUjq1OiBnDE/B
 CyVsM8OWPr5rAzFoKAzbeCq+1YwbqrU3FpS0b9qu0xZ/WTpRlVOJl5gSKTLOhGdKLMHlx4+fPN1
 FTgcyGGuOtdIxIlqcOd49214X5QygF74JUdf9Qu1j2oUiJyir1qQFY7MBva2bgoV++gpRXTV16R
 nMTCx5JsNGWz1dGx0UI1+8E28jrIFaDubGQF2jN3/G4aD5SwEiebxVRsQF4wuWdDo8xAtulGrnd
 pMZR2EgG4vMJMK2VjSmTsGjf4t5SQqDuw1GAvMno8K7vBBwjzLkLJ4T/CuyW+GfRPszka7e4/fq
 anQ81HCcmFvUA9GJ4fa2/1HYJQn3pzqJz0WmMYEP7xdVDZXgrwjcZ3XSaw3TE7GJpNyrjCV1hy8
 gqifp0PmxOC8nPswiT1Qh7/X0WUh2Keg==
X-Google-Smtp-Source: AGHT+IGsch2w0m/4kBoB30cf1T85LLN4GkYvZA5ImWj99M63mncBFnxk1AfsXFYJ+wJPQhjb+rdAcg==
X-Received: by 2002:a17:903:196b:b0:295:55fc:67a0 with SMTP id
 d9443c01a7336-2a3c0940c78mr55161505ad.2.1767570319663; 
 Sun, 04 Jan 2026 15:45:19 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d4cbe5sm437139555ad.60.2026.01.04.15.45.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 15:45:19 -0800 (PST)
Message-ID: <c5650230-d14a-4e6e-a5a4-e26ca4c5b2b6@linaro.org>
Date: Mon, 5 Jan 2026 10:45:14 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] m68k: fix CAS2 writeback when Dc1==Dc2
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20251226213707.331741-1-laurent@vivier.eu>
 <1c2fc596-7196-4901-b9aa-91a1a6efd71d@linaro.org>
 <46bee198-d686-48a8-8353-201b7729fb29@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <46bee198-d686-48a8-8353-201b7729fb29@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 12/30/25 01:31, Laurent Vivier wrote:
> Le 29/12/2025 à 00:13, Richard Henderson a écrit :
>> On 12/27/25 08:37, Laurent Vivier wrote:
>>> According to Programmer's Reference Manual, if Dc1 and Dc2 specify the
>>> same data register and the comparison fails, memory operand 1 is stored
>>> in the data register.
>>
>> Where does it say that?
>>
>> All I see is the pseudocode
>>
>> CAS2
>> Destination 1 – Compare 1 → cc;
>> If Z, Destination 2 – Compare 2 → cc
>> If Z, Update 1 → Destination 1; Update 2 → Destination 2
>> Else Destination 1 → Compare 1; Destination 2 → Compare 2
>>
>> which *suggests* that Dc2 is the final store.
>>
> 
> This suggests but later it's explicit:
> 
> MP68000PA/AD REV.1
> MOTOROLA M68000 FAMILY Programmer’s Reference Manual
> (Includes CPU32 Instructions)
> https://www.nxp.com/docs/en/reference-manual/M68000PRM.pdf
> 
> CAS/CAS2 Compare and Swap with Operand
> 
> P 4-68
> 
> Instuction Fields:
> 
> Dc1, Dc2 fields — Specify the data registers that contain the test values to be compared
> to the first and second memory operands, respectively. If Dc1 and Dc2 specify the
> same data register and the comparison fails, memory operand 1 is stored in the
> data register.
> 
> Thanks,
> Laurent

Right you are.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

