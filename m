Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B10E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 22:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJhF5-00011m-Hw; Fri, 06 Dec 2024 17:56:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJhF3-00011V-Rq
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:56:09 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJhF0-0004E2-HL
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:56:09 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5f205c4625dso714521eaf.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 14:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733525765; x=1734130565; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pVG3n+XjIPPUlwnPR/IllpTHmNBM+SnUk7x6s5Gz60A=;
 b=JDAJGXPWZYq7DGguvlHXsb39X041EU2kmYUKJghlK+ntVBVQMmTBroUj9mzJkQiGQd
 STlQwF7RGuQaKo0C8jgKuZbGSjY3b6s6g3OUbLVMeHS9Jkbky/33zMhQ/latmEoBr610
 8AhYootSnuLLlKJ7+A6ngRUKAJDdFNahiMxklEvCtSuB9H1bz0w/29us6jRINFV/swIY
 jaa9cVQ4H2EFVKyxZ6LbFrq0Zp+DH+WxSFvGP10n9q8iX7tPOd9Fkah6pz/ZsK+fjGXc
 Hb087ND9BKJhv+cYio6WqCb3BMxEnIwzpusi1Dg/WICsWKp/z4DhA8koTPqaipe8vSri
 G5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733525765; x=1734130565;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pVG3n+XjIPPUlwnPR/IllpTHmNBM+SnUk7x6s5Gz60A=;
 b=njFszHD6Pe+fwAamTj2nNR6ez3bT0/zJ+jzWpgGtUsrpiqLhL2qOnuR4J+0v9+X3M7
 0+ivyVnSdrsPD3cpw5gA7K/Qbh+Wkb1PiHVdTkN1CsCDrDA8CgD939uyQNGLcBVwmnCK
 xO3GqR0++DLkbmgyXsU1ERO6l22uSWxuWB0HFmzDXkuD1bGEm4wXU1pLoS/yMvADkL3V
 kEylyYTcY0j/6wDn1S/6anMUTLofcy1vWRQjeilvByuLbfcnyNAfzLU1a5WEEel2qrDX
 xgcbwQk1RDdGgCEbuUZUQ6cnmPLsoseOEYECWmcUyKU0eWGG732fN3g4Q+ogPGAZt08b
 5+9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqAFGO/nXcHso0k9lI6D6PmGmAR8uq8QWnu3W/3ET+0EjchdWpOt4Q+GVdNwmiAU2QG6J94WJpfV//@nongnu.org
X-Gm-Message-State: AOJu0YzwS5NOGaXrXi8YNjQ/h4pjzZJHSWVS51Ahi9XsYoxiB6FHoqO/
 0EK4dlW+clFk+Wl4o1q47VqZp0z/HM7j2ou2n/GbnpfsGCCjXRge81bNUXywO9M=
X-Gm-Gg: ASbGnctjD+GmjXdVaQIGbwNBQG6F+P1aIasSzHPqu1C2FoxCETHRoPrF9UBvs4sPJpR
 zHWjOJK8sKOYp3AjKtu6aFbslN14H/xPETY1qwWZ3HHjV1iFgAN7xAbGA8fF+pukGTxuGwsFv1A
 ho+tDOPuvILPqSwlJqKDrqwaj+vi5GgUYrNBmMCeAkHC7F8YqNkFRH25q9fu49RJ+E8QWZEv5vg
 Ka8Q4GL/ps67+pgXM+ryub3xlBmpD96cDZYeMExAT0ao97PWoofkhhFljH1k1Z3zHeTaYgoMBII
 ZOKHRnLPqP5plQTSpUbbsdBNcht9
X-Google-Smtp-Source: AGHT+IFiPtmx4ZmXtAaY17oZoPSM6njylgnPfE9MOH55D4zyacrxWQ3Fm1I15a3cV7Hhiu47vy7lDA==
X-Received: by 2002:a05:6830:438a:b0:71d:4bd9:8b98 with SMTP id
 46e09a7af769-71dcf6c8a75mr2659931a34.25.1733525764983; 
 Fri, 06 Dec 2024 14:56:04 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc493b033sm987449a34.8.2024.12.06.14.56.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 14:56:04 -0800 (PST)
Message-ID: <21c28157-6d3b-4b07-9dd6-241b3198be93@linaro.org>
Date: Fri, 6 Dec 2024 16:56:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 11/11] tests: add plugin asserting correctness of
 discon event's to_pc
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <cover.1733063076.git.neither@nut.email>
 <36d316bf3e8b0aca778c5e8d1acde39a7f361946.1733063076.git.neither@nut.email>
 <d4b17c7d-c1d2-4e43-8eee-d1667e3ee5a2@linaro.org>
 <0e4171ca0baa8727c0bbec7a25fd72d8b8e1e4b8@nut.email>
 <997e809f-832c-4bbd-b27e-a722ac835b34@linaro.org>
 <450f3beedf979437fa3de8bfab1ee72f66c67ada@nut.email>
 <cda016be-c82e-4b54-a506-22afe6ec2eb2@linaro.org>
 <c850ee89e15d2775e7c0137a218286e7060874dd@nut.email>
 <867d8a3a-ddf4-4655-9bfc-51c1a2ad8203@linaro.org>
 <b02abe90-d57b-4010-aace-1b47d92e5c26@linaro.org>
 <70666b89-1f04-4615-ae16-e1eefac2a446@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <70666b89-1f04-4615-ae16-e1eefac2a446@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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

On 12/6/24 14:40, Pierrick Bouvier wrote:
> Do we have an architecture agnostic pc representation, or do we have to add this for every 
> target in {arch}_cpu_exec_interrupt?

We have CPUClass.get_pc, which is almost certainly what you want.

The call to TCGCPUOps.cpu_exec_interrupt is only a hint that an interrupt might be ready: 
interrupts can still be masked, etc.

 From the current bool return value you can tell if a discontinuity actually occurred. 
But if you want to categorize that event in any way you need to update each architecture.

You could simplify such updates by changing the return type from bool to an enum.  While 
you would have to simultaneously update all targets for the change in function signature, 
if you select enumerators such that 0 -> no-op and 1 -> uncategorized, then you can also 
tell if a target has been updated.  Because this is still C, the current return true/false 
statements will Just Work.  :-)

On the other hand, the previous patches to add plugin calls to each cpu_exec_interrupt are 
in the end approximately the same level of difficulty, and is more straightforward, so YMMV.


> Beyond the scope of interruptions, are we guaranteed this instruction pointer (per arch) 
> is always updated between instructions? Any corner cases?

Not "between instructions" or even "between TB".  But you are guaranteed that pc is 
updated by the time we get to cpu_handle_interrupt, where cpu_exec_interrupt is called.


r~

