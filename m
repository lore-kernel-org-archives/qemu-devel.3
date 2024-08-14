Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBC2C52D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 10:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seBIq-0005fF-Ki; Wed, 14 Aug 2024 06:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seBIo-0005ea-OR
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 06:32:26 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seBId-0005c9-Ge
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 06:32:26 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fc587361b6so54528185ad.2
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 03:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723631533; x=1724236333; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p1CE16s1oNTa6aMp4eguF+7xcB5ldZgc2XEnbBRZpm0=;
 b=Gr62rwz1zylB/iZk0ZmDaNE4ZimPKvRDUVv5UTbqvuGc/Wri2maQ9hv80kUwZk2mEL
 IoeqXPOfLRB0jEP3bp7z3Maza8AYiMOhpQ7bUvhm4BFiZ6dpzxZxtwioRw9phXrQwLDX
 SoHNwouYpQbKrgO5BaD8yzcw1b3YiTfXUEtNhZo0u56ZHwpqvkw+qhP/P0C/o9w5PNik
 Ir4DhkgvnwUMHeIs0aDEMdWQhBGf6OaTooO87mq5GTXzcaC+vk+WaZe+cSJ91nCT/TGr
 033FQ65HlenGIS36nGCQdFN6wzQlUGi7T18gxci9lMIGMdN3K/fLZpTs2EHqbGp8XihY
 6ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723631533; x=1724236333;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p1CE16s1oNTa6aMp4eguF+7xcB5ldZgc2XEnbBRZpm0=;
 b=sJUsVaXwsmh1spWqif2AVqukvMGMUxS4oXHjhnMGQlUMGh+PIa1RhfrDK9NF5trOlC
 1TMqx5/eq+hue8EVQ4CgbV+YVybBWLtZ91pMrUHLO0BzTr0anRNSNOV9FbEkH28jgWhK
 31yxpMvrT1tcRAyMnGxzp5sbkhyvpD5Ooz1PkTiUKWxCZK25ACkJFIm9GsssWfTpjOx1
 wWZn96kvyyybAEzKWfXCeX51ZwVKceVgP76fj25eCtqJhZ/VBjwT/JzIazoxtIKe1qT6
 H1Ua51STsw3QWNB25lJ//TAmABA2t3p9iK5j7xzOBITrJHGLX6EqL1XScnRb9uo3i/od
 pe9w==
X-Gm-Message-State: AOJu0YxV669KtuaC61uZ31qwU648YLk7E9irCoViYO3kx4h05JnQSZcn
 CJGG2eCzLIBj6ICpq6ETQGiBIxlKzxmr/nCOEM61bbqOT3bjX1FLt9Yz+564R9FNnwROwPL5Q3d
 tvCo=
X-Google-Smtp-Source: AGHT+IFoRkZPcb3wB6tl9HZsa2i5HWXJ8Tg/LoMez33JHGxLwCh/B2J8F/TBYbVF8G4xq+CxNpCAIw==
X-Received: by 2002:a17:902:e5c7:b0:1fd:a942:154d with SMTP id
 d9443c01a7336-201d63baf3amr23452005ad.22.1723631533100; 
 Wed, 14 Aug 2024 03:32:13 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd1c45c3sm26906575ad.256.2024.08.14.03.32.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 03:32:12 -0700 (PDT)
Message-ID: <15afdbc3-c287-4b4e-a42a-e6f985b0b84e@linaro.org>
Date: Wed, 14 Aug 2024 20:31:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/i386: Fix carry flag for BLSI
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240801075845.573075-1-richard.henderson@linaro.org>
 <c119648c-179d-4332-a658-8ce5153e1dea@linaro.org>
Content-Language: en-US
In-Reply-To: <c119648c-179d-4332-a658-8ce5153e1dea@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/7/24 15:41, Richard Henderson wrote:
> On 8/1/24 17:58, Richard Henderson wrote:
>> Fix #2175.
>>
>> r~
>>
>> Richard Henderson (2):
>>    target/i386: Split out gen_prepare_val_nz
>>    target/i386: Fix carry flag for BLSI
>>
>>   target/i386/cpu.h                        |  5 +++++
>>   target/i386/tcg/cc_helper.c              | 18 ++++++++++++++++
>>   target/i386/tcg/translate.c              | 27 +++++++++++++++++-------
>>   tests/tcg/x86_64/test-2175.c             | 24 +++++++++++++++++++++
>>   target/i386/tcg/cc_helper_template.h.inc | 18 ++++++++++++++++
>>   target/i386/tcg/emit.c.inc               |  2 +-
>>   tests/tcg/x86_64/Makefile.target         |  1 +
>>   7 files changed, 86 insertions(+), 9 deletions(-)
>>   create mode 100644 tests/tcg/x86_64/test-2175.c
>>
> 
> Ping.

Ping 2.


r~

