Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A248C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaBG9-00079N-Mu; Fri, 11 Jul 2025 06:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uaBFl-000740-9b
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:45:19 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uaBFh-00088J-M8
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:45:17 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so19498685e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 03:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752230712; x=1752835512; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jF06BaIoqQ4o5qrjHCHKDptQ8Bx8plMl4UyhaNJzVwU=;
 b=Q8tDCLlW3++fyJlig2HeYmlEQohwHNHMwCMT69uP+I88o1A38bwUQSoVTW872HIKqS
 bA1Bwiks/I7/qSb+EkGpLajYl/Tz9UGt3DE2rLy+3kdNtgcLEG18zrLhaHtNdu7lDW95
 BYXtwkJgNIWOGDtn1Jm5kGm5l2NdK0IYlgMVQri9+6QqQwVkgqOfvRwrttusy8PuyDlB
 ni4Pepa+AtHC1hzH4hcwuuOvxLSeNRJTACNyqlZm2HTVPyHk7Rw0RqMY3d0ez6LGK7pP
 o08b+dqgGc/7O+yeyGEzSNhJJkZDkx/X+C/jErk2nYwdQITtpwFFqKuJ/4MjSJTzMbcz
 EgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752230712; x=1752835512;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jF06BaIoqQ4o5qrjHCHKDptQ8Bx8plMl4UyhaNJzVwU=;
 b=fpQGTan/C3E2m0Ig7AdCKCJ9N3R/WeLwBekhsEQZ5qOmSvkPeOHljell3OjKuipcY0
 9+TDJhXPa9Wu4uVoP5NHzrDrntIsDpF6j10OeGc9/88obKroPve0TR/nuKew8rO9jFOG
 knsifS2nC4a/p+dEofmySRMcY5So/bQRkApEByLZRRfYL3TaNS7JW5/j5TG68HOx42BH
 MpMGfbACVFLnz/Gafbfq2W45UROH/E2TN7HVPXuy2PhWyj0dSfgNv4LpBU+/QyxUBFrh
 ophYNiDkS0nmnqW+XCJpwxWlNjFesxooWHJ0RxUASpKHnA3nniq1seCYyvTEsjRgVr8H
 CskA==
X-Gm-Message-State: AOJu0Yxdf6X2NhOxrsvvpRMVROfpThJpLzTE8KjItTbnpVANfC4PimZY
 PTcRhO/GiI30K4rCutuowyhmE0T0ElWKhlCyOM5HCV314nsSnxT0VwjW7LoTKbLKevo=
X-Gm-Gg: ASbGnct4y94DwMVA4dpTWPfuoyHZmH8tSFVwiVlapZya414u4J8Llu5kfofod2bi9b2
 Tok2foq6MuDUd0MQbgqoz5d/p+k8zLlnC13dYcBqYA/xvAor9IdqfWafd+dGuWUxhWPybXtUspA
 9Crul5f3sOhs2s2ookr+c26H06eBHh7juGl0QUeD3a41w9qQXG7RtY2Y8wPwZOl1/s//W4XaQU5
 g/Cn493OG52Hyem3IBiqYKgwdVtDnttX5AHiEEMaXeA2o+lHD+3IO21MX/YRrAu8jBt3EhjWycQ
 l9Zdx8yNfF1oau7tU4vvmhX3BwbZZGWbak/pTrNqCHOmGP544LOT24/Adw3ROV/l1t6AC9+FWH1
 Jpeso0dEaDAb9BoW3hjJOmUl2g6SqUFDkt4BE9VTMgrg54DrqUlm1PEWy8aqWvi1g3jrTxZseqC
 Pc8fZj
X-Google-Smtp-Source: AGHT+IEAlBc/SiofnuLerJTNNIMWGHIeBqYEYsVL7S8eYentnkT4kTA1eiz1utBHFePEp2OYvmk5Jg==
X-Received: by 2002:a05:600c:1c95:b0:453:86cc:739c with SMTP id
 5b1f17b1804b1-454ec14a50bmr22232225e9.1.1752230711651; 
 Fri, 11 Jul 2025 03:45:11 -0700 (PDT)
Received: from [192.168.1.47] (lfbn-mon-1-587-20.w2-4.abo.wanadoo.fr.
 [2.4.165.20]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d5f5sm4155257f8f.56.2025.07.11.03.45.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 03:45:11 -0700 (PDT)
Message-ID: <9a4e5e05-f96c-4e8f-8b8a-a5480267e789@linaro.org>
Date: Fri, 11 Jul 2025 12:45:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 09/36] accel/tcg: Unregister the RCU before exiting RR
 thread
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250704132439.25743-1-philmd@linaro.org>
 <20250704132439.25743-3-philmd@linaro.org>
 <CAFEAcA8e4jcoBup890sjNFmOkSJqCdC4JpDJT1H_OZS6n6=xhg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8e4jcoBup890sjNFmOkSJqCdC4JpDJT1H_OZS6n6=xhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 10/7/25 16:33, Peter Maydell wrote:
> On Fri, 4 Jul 2025 at 14:25, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Although unreachable, still unregister the RCU before exiting
>> the thread, as documented in "qemu/rcu.h":
>>
>>   /*
>>    * Important !
>>    *
>>    * Each thread containing read-side critical sections must be registered
>>    * with rcu_register_thread() before calling rcu_read_lock().
>>    * rcu_unregister_thread() should be called before the thread exits.
>>    */
>>
>> Unregister the RCU to be on par with what is done for other
>> accelerators.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Acked-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>> Message-Id: <20250702185332.43650-66-philmd@linaro.org>
>> ---
>>   accel/tcg/tcg-accel-ops-rr.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
>> index 6eec5c9eee9..a578698d071 100644
>> --- a/accel/tcg/tcg-accel-ops-rr.c
>> +++ b/accel/tcg/tcg-accel-ops-rr.c
>> @@ -302,6 +302,8 @@ static void *rr_cpu_thread_fn(void *arg)
>>           rr_deal_with_unplugged_cpus();
>>       }
>>
>> +    rcu_unregister_thread();
>> +
>>       g_assert_not_reached();
>>   }
> 
> This has reintroduced CID 1547782 (unreachable code).
> 
> We can't get to this point, so why are we trying to call a
> function here ? This is not a place where the thread can exit.

The goal is to unify accelerators vcpu thread logic and
eventually remove AccelOpsClass::create_vcpu_thread(), superseded
by AccelOpsClass::cpu_thread_routine(). I couldn't finish RR for
10.1 but squeezed this patch in. Let's revert it, and I'll
re-commit it later.

