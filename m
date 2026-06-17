Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13F8CD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZtII-0006Z6-Er; Wed, 17 Jun 2026 12:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZtIF-0006Yw-TZ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:39:12 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZtIE-0003nY-Bf
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:39:11 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2c6d4851142so3842185ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 09:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781714348; x=1782319148; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D9RuLDkmq20oVwlDgyx/zu40GhPu7vG0lbWyEwFB96s=;
 b=maiQfUjcnOwa/MVL+WdfDWKcpBw9U1aytssRsP3BaOZSzKvLVLRZeaVrgc8/ZQXoYx
 mjhhX/JezqMxeDDmMsI2TD02nrVorVmbj0w/R0Y1GO3Z1cuebpTF+zame7GBC+6lXSmF
 sC4uGbe4x6Qa7bhBcg8h5GaDIzNFirKS/6nKzES1TZ2bd/eEE5z/Jh6ufrkEHOHc6mDP
 a96uBnPivB13ncFzpH/KGjvOg777ZeiG/sL0Lq2sOapkSpsoEmQIvDyWn7M2wyjKSNra
 b/ZpJLgE3FRRam/VdH5mmiO2qqEPREWxsQCBbF+tMstHe4WRSXmrkLwbL/EN4kx06Puk
 qL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781714348; x=1782319148;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D9RuLDkmq20oVwlDgyx/zu40GhPu7vG0lbWyEwFB96s=;
 b=lvtfRxY5PmeuzwGWbyAWf3kZ2ex//s7GEumnNjNYqF+7BTMHVRN/kZctC7Wgwi+Pe3
 Xbcg8iRW9OIWNDpYhjPLBDv5nRqxYlPVKjXBQ7ezU8E/MZY+C/zAAebbUJqkEV4w8ySh
 IYh0aSCtuDbl3YI6YUqnXaxyK92TZeHC32a7rpV11IORDmTRK50feG9qJldUwyXtObg+
 GFVTkUb6Mp1tGFUs45VnuWU8Kpfca2KGLKIikozGyRNtdKV36edenQVgCWoll8q/N1Gv
 wmbzPikcOzdoTE9uBEbJcTT+bHCPal4foSyS4O4wtiNTFibgYJyr4bXrAx/7VxQb95Wr
 Jq3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9swHUqgcHb5S+lF8B2vyeGy450MhItHZ9efpOU/m1y9fOXGYYUym4FxZQBI8WZtmj8PqNXnqSkhFA6@nongnu.org
X-Gm-Message-State: AOJu0YzmPQyzgFlkRJ9ENFmhreREIrrPoGZ4TWWmoD7I1+N5TzBW4ooR
 DemA2vmslIY1xFTDMsC+L2slqm3S4Mj0sPhMdJGlNLEAdQ3KbrN1uLVuFKGB+g+DTxY=
X-Gm-Gg: AfdE7ckGBmfg6CkV7t0SnsX2vFrPJBfRyvMqI3CvLG+1Na9Y0+3r7+m3myEv8iTsJ9P
 JSxR0WP6oggeRpfu893ww1hWaXsm2w50/Y+OY7eRSBc6Y66RnIiIwQ13iYfjZRDY21BkkVus14w
 GVMw3T2IaCsC6XCzft5lCe1HXaeH5zZHC6iaa9kmV4psrfrDpidd3ZjZf6FNS8B2BUOS+b87Own
 opleQoEmxm+1TWSkFkXBHcjPcn0KGCURNHX/M0+IEUONVwWrcvUDA0fKe+epkatQPbCF0N6Ft+6
 jfc5SuwT3sYC0Xd4d5YHdDYgc03nkrww5LZk4viHB3czxt4PwZalUVFSNL4HvJ47O0cttkAiCYk
 hxYELrwBkNFJ0xBb7lt6JZHd6lQLRfggQER54OE/oPthySgbODhgxYnb9H/h2dT+DNs9DR+Lykx
 LRro6MJkZAkCD6KK44B8HQ5Rem4ppHBq/VEaLkViL+ec2HoFD+FET8YkSeoQ==
X-Received: by 2002:a17:902:ce06:b0:2b2:4fc1:f653 with SMTP id
 d9443c01a7336-2c6de3d8a04mr1937765ad.3.1781714348472; 
 Wed, 17 Jun 2026 09:39:08 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f2e59e1sm169782725ad.17.2026.06.17.09.39.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 09:39:07 -0700 (PDT)
Message-ID: <e80e37f7-8d7e-40fa-aa3a-ea875cefed37@linaro.org>
Date: Wed, 17 Jun 2026 09:39:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] accel/tcg: Have cpu_loop_exit_requested() take
 const cpu and un-inline
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260616191716.12932-1-philmd@oss.qualcomm.com>
 <20260616191716.12932-9-philmd@oss.qualcomm.com>
 <8633117c-e2e7-4e68-8684-6b7bb6b6fc20@linaro.org>
 <1ed6596c-0e54-4296-a294-ce44e1008341@oss.qualcomm.com>
 <dcd513f8-80d6-40ef-8b99-b232c507c158@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <dcd513f8-80d6-40ef-8b99-b232c507c158@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 6/17/26 09:25, Philippe Mathieu-Daudé wrote:
> On 17/6/26 17:34, Philippe Mathieu-DaudÃ© wrote:
>> On 17/6/26 16:44, Richard Henderson wrote:
>>> On 6/16/26 12:17, Philippe Mathieu-Daudé wrote:
>>>> Of the 5 calls in our codebase, 4 are unlikely(), so not worth
>>>> inlining in header. Since the CPUState is simply read-only
>>>> accessed, make the argument const.
>>>
>>> Unlikely to trigger, but still called within inner loops.
>>> Please keep this inline.
>>
>> Why not inline all of them then? What is so special about
>> this particular one?
>>
> 
> I'd really like to not pull the whole "hw/core/cpu.h" there:
> 
> include/accel/tcg/cpu-loop.h:87:38: error: incomplete definition of type 'const 
> CPUState' (aka 'const struct CPUState')
>     87 |     return (int32_t)qatomic_read(&cpu->neg.icount_decr.u32) < 0;
>        |                                   ~~~^
> 

Then perhaps we should leave this one in cpu-common.h.

r~

