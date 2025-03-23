Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B8AC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 22:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twTdh-0001pU-Jv; Sun, 23 Mar 2025 18:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twTdg-0001pI-T2
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:17:52 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twTde-0003dp-Ss
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:17:52 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22401f4d35aso75051545ad.2
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 15:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742768268; x=1743373068; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SQ6hU4NEtsbcSc2GDiDAt8t8vZmN3Jr68Nr5mZDVvyg=;
 b=uTKp2TeJp0MBYjfOn6EwsvPBAC+ocbK32n30Z8jyherMx+pG6/hJKflHNs+t3HMcKQ
 Y0O3PyKai+DLJ4zz6LNtAQcYUxIlZDpGnii6LkPaR7q846XZL+ZfsVTFSn0RitugChJD
 AEcocpa43z1MSAdOCort6JUHpZg/5cpvEFqLi7tv2rxIZdFVzw/2wb1rSAvtgQX1BJ6c
 fGV/wPvO0sXHtXga2PJouu+aeo4A6MYg2BVbLga2nl0AAj9iayneLGhBCWAKpQQox6JC
 fG7FQxIuUnUhSu2U/Z/jt3hW513BjWvnhmCXpawCeB9c+rhhUktq/DBfp0SQ5uF3yXVa
 e4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742768268; x=1743373068;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SQ6hU4NEtsbcSc2GDiDAt8t8vZmN3Jr68Nr5mZDVvyg=;
 b=dZG0il06iUIj+KLQYbDf0mePMzPYnGI9B22lliULdEb2hTOtNqTotDCWoRpbpvsCS7
 pr7QgvYrMEw5cz4m4qUWOdOcpURMg/eIOQtRokcRxc9X/ejWD4gnS1xEf9zl/3rjmavq
 nOByBccjd6kRKw55bC2rrCQ4p5ouz7e2S7hBj/iMpHmOG5+3AkiA/lq8ITqIqS23O9Ra
 ktU87ewfGrOFkTJtFBbaLQYFRtNmjmqKi+us3ziKQPKrPdnD6oG7rBdrTS2QXgosUKYn
 YGzfxaXFuIfwE9f74UTYB+3yjk+c3F1LEY4PKOt5iUuExUG02mkGqob44fZrruvPSX8p
 AUgw==
X-Gm-Message-State: AOJu0YwZAdtCZzN2D9+amaWTeBdi4hAsXE2Vs8t3KkgINmE4MgWwSZxl
 oPFPupGkNRH0taiexkAjUOBt8hoZ50O6BQuhXk3CtzmQF1lMI+Tr+moYvcUhl9w=
X-Gm-Gg: ASbGncs/D2jmG3IuFFVMQN/e5/xbpai/Z2kRdGYenVGCShkYrmwSIcyfsj5ZJl+S1hN
 FHSI/khV4c1M9RqMI32OhhMc1dp10TuYQwCGUdGMQXhgZVdwMWwWLwziUTqzhJ/1dslcVuzKt1h
 3fz5w7BTJZC+WOUqOFpLoRD0iW4LSjvp4LQdtRserBssuwyQkv9oTr0s/05Mzrx8/k6omdDRBdh
 kvdsrnSlrwTdfI2pM74jYepw0H4qOJfdM5xX5qb4cD6R0NIgZHPcV8srJ6tBoxNMk9Kq3o4bRaK
 eyJVvk36aQP8aaFldrsy5/MtHgDLmchCa/UTl/KAvYj5MbaPvHNRYHNsZx2z6NuLHaf/Q4Kfj9T
 b55ZK+ZuO
X-Google-Smtp-Source: AGHT+IGzwWGs7xSdHSGQMvA3cKVS3OsdGl3aG1pHofT3kBuEddUqF8gp92LZMB2EX7l0uIPQfeQlrA==
X-Received: by 2002:a05:6a00:ac4:b0:736:4c93:1bdf with SMTP id
 d2e1a72fcca58-73905a275famr15358527b3a.18.1742768268399; 
 Sun, 23 Mar 2025 15:17:48 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390614de5fsm6288049b3a.127.2025.03.23.15.17.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 15:17:48 -0700 (PDT)
Message-ID: <fd7ecaa3-5995-4124-a7bc-8393dd4e6d7b@linaro.org>
Date: Sun, 23 Mar 2025 15:17:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 4/4] tcg: Convert TARGET_SUPPORTS_MTTCG to
 TCGCPUOps::mttcg_supported field
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20250321155925.96626-1-philmd@linaro.org>
 <20250321155925.96626-5-philmd@linaro.org>
 <8cc6f6a4-b868-4dc8-bc14-25b438ad62a5@linaro.org>
 <5bd8498c-b5ff-4fb1-94d7-a2efa2f20fd9@linaro.org>
 <cc7d5557-0e0a-b7df-1eab-8f9d86444d2b@eik.bme.hu>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cc7d5557-0e0a-b7df-1eab-8f9d86444d2b@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/23/25 15:13, BALATON Zoltan wrote:
> On Sun, 23 Mar 2025, Philippe Mathieu-Daudé wrote:
>> On 23/3/25 20:07, Richard Henderson wrote:
>>>> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
>>>> index 28fbbb8d3c1..ed79cc1a6b7 100644
>>>> --- a/target/ppc/cpu_init.c
>>>> +++ b/target/ppc/cpu_init.c
>>>> @@ -7490,6 +7490,7 @@ static const TCGCPUOps ppc_tcg_ops = {
>>>>     .translate_code = ppc_translate_code,
>>>>     .restore_state_to_opc = ppc_restore_state_to_opc,
>>>> +  .mttcg_supported = TARGET_LONG_BITS == 64,
>>>>     .guest_default_memory_order = 0,
>>>
>>> Similarly.  I'd be surprised if ppc32 can't use mttcg, really.
>>
>> Per Cédric on IRC our ppc32 implementations are single core,
>> so never tested for mttcg.
> 
> We're just trying to implement more CPUs for G4 mac99 and tested it with -smp 2 and it 
> seems to generally work but we need to implement more of the Mac hardware for this but we 
> could already run Mac OS X with two CPUs and mttcg and Linux too if we add a delay on boot 
> when second CPU is started (it may need implementing timebase control as done on the G4 
> Mac to avoid that but if it gets past that it seems to work). So please leave this 
> enabled. Not tested does not mean it does not work so only disable if there's a known 
> problem.

MTTCG is not enabled for qemu-system-ppc right now.
Phil's patch does not current change behaviour.


r~

