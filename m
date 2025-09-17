Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88541CAC598
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 17:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uywK3-0004D8-FK; Wed, 17 Sep 2025 13:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uywK0-0004Cd-LW
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 13:52:01 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uywJy-0008Nk-Ta
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 13:52:00 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-77c6516af79so123580b3a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 10:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758131517; x=1758736317; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BtOmtS5+CGon2hRJLmoisHn0h2sUrjHXBoXqsWL5poU=;
 b=KIVzjFrce9+ee0EfNMHwIyO11DFZ3/5v0yHE8jGh2L53beVdcfIcsrBdxEw5AaDX3L
 Hl6zQvAyb/5jZX42vO2FnNpEIuwdlIM1tGRSVQy8zd36UPbKTtC1z2iFTXnHvXHB/Pd+
 Nu0dDp7kjzLfO0gXapVMmsYzsKE38m5THw36ihMtWfPAsbP5LdhmbHgmV+UK2OzMB3OZ
 Q7Oz8jj7B/wH86u5W45v0Avu+/2jgqRBbOnPmJvGEGfzCWMmMdue0l3GScVzrs4vYWlj
 uIJrb22vcc+GS/B1NkKNn0o63/vSpXXQSJC1H5kETCRW6wZN5j0H4nC4lVyw+7ryYEHF
 UBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758131517; x=1758736317;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BtOmtS5+CGon2hRJLmoisHn0h2sUrjHXBoXqsWL5poU=;
 b=BDI8lzzONQgVLWcQXuuHvs/TRimqyrNyLxwPdLz72diF52546oGMsZw2gkKDq55Id+
 9h4Z0KAACMnl64LwHqabzpLML32ZF2nOG4BS7TVgNOc2HZebaP/k9uU70NYod3Pf0ofS
 yC3W9X/UvbPLAEulgASYN3BOd90b2u+/GttuWHydk5xfLJPQFbq13NaSswLait6xOcVl
 964NhPtCp3nrcddCTcT8JEhYnLDuygfHYJ0Cf0RZY6DBnURK3b/WFaRUf5nPAetfa0qI
 dz1qj0qzH6j1O2gnc2uYmN6XZkWY8FJpx9QAuogF014eVHmlIHwsdBmfvGw2EHBnOLDX
 IAYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHuQsrMAFPQlaLPSzksPxg0qnEOLd+BtSuS+091Envr4NVbJXx7MYrDuP75VR0Ep3rKiHA0yXUBNTD@nongnu.org
X-Gm-Message-State: AOJu0YxDaHWq51aqIzOOAYWcE/Aa3yfGSdJuhw69mi9o8nuCjStlLSKL
 TqqiHjj/fKBhthXl8dNpfoOaypFL9hM6wljXtWqxcuD3oPI35K1V51K+7TpwBeTUG/1BvfIzAZ5
 pWePO
X-Gm-Gg: ASbGncuWZBtAjFChpqyUXoCo1pVRrYL+dDK0c79+KTtR1MVQ9xOyTQvgLfLW4GwzkzR
 QWPNLHiyiBtAjEby150LJM2QD2KbqOLSY6+6QRF7qP5sepAyt3tkulfXvvDz7uprPsKHXdMLc0f
 0b72WCc2JBI4FX9DDOEF3xRnlK9T3QEBU1ViGKr1k0ZhJmwf6vg2uSqx1aljtrXhhwo9yYai3so
 V0zZdOQ5BtA81JZzjBhtvNiW09Pf3Kk4Opf1Jr9fdssGZ27svfLdeY/MtQgsEYbnyGoEQaQ27Uh
 iUAGOvn4w2kvsvqn8ol4nhx8LNVwkhnbF/a8jWET17nNExxn9SURBmUHIFJyGcY9r7qSKfmW/GU
 k8ZHv3kntaYgtCg6oy9HNRM8aPlyuB7eZG69b
X-Google-Smtp-Source: AGHT+IFSeitSDAh0XIcQsPsJK6aPfOUTd9VFS926JjCNU8dSX1BI307uUHcs2JqdqgWh/pCnbTTYkw==
X-Received: by 2002:a05:6a00:22d3:b0:772:4759:e45d with SMTP id
 d2e1a72fcca58-77bf907762emr3558955b3a.22.1758131517224; 
 Wed, 17 Sep 2025 10:51:57 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfe7607c8sm32285b3a.58.2025.09.17.10.51.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 10:51:56 -0700 (PDT)
Message-ID: <e3f9275a-999e-4114-9950-68e3925aab7a@linaro.org>
Date: Wed, 17 Sep 2025 10:51:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/36] target-arm queue
From: Richard Henderson <richard.henderson@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
 <ae07bd23-724a-4925-801c-d1f2b6d9abee@linaro.org>
Content-Language: en-US
In-Reply-To: <ae07bd23-724a-4925-801c-d1f2b6d9abee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 9/16/25 18:43, Richard Henderson wrote:
> On 9/16/25 11:05, Peter Maydell wrote:
>> Hi; here's an arm pullreq; various miscellaneous new features
>> and bug fixes.
>>
>> thanks
>> -- PMM
>>
>> The following changes since commit 6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8:
>>
>>    Merge tag 'pull-tcg-20250905' of https://gitlab.com/rth7680/qemu into staging 
>> (2025-09-05 09:51:27 +0200)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20250916
>>
>> for you to fetch changes up to aaf042299acf83919862c7d7dd5fc36acf4e0671:
>>
>>    hw/usb/network: Remove hardcoded 0x40 prefix in STRING_ETHADDR response (2025-09-16 
>> 17:32:06 +0100)
>>
>> ----------------------------------------------------------------
>> target-arm queue:
>>   * tests, scripts: Don't import print_function from __future__
>>   * Implement FEAT_ATS1A
>>   * Remove deprecated pxa CPU family
>>   * arm/kvm: report registers we failed to set
>>   * Expose SME registers to GDB via gdbstub
>>   * linux-user/aarch64: Generate ESR signal records
>>   * hw/arm/raspi4b: remove redundant check in raspi_add_memory_node
>>   * hw/arm/virt: Allow user-creatable SMMUv3 dev instantiation
>>   * system: drop the -old-param option
> 
> I don't understand why, but this causes failure on s390x host for hppa guest:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/11379271029
> 
> ...
> # Testing device 'elroy-pcihost'
> Broken pipe
> ../alt/tests/qtest/libqtest.c:208: kill_qemu() detected QEMU death from signal 11 
> (Segmentation fault) (core dumped)
> Aborted (core dumped)
> 
> Even more bizzarely, the failure bisects to
> 
> Author: Nicolin Chen <nicolinc@nvidia.com>
> Date:   Fri Aug 29 09:25:27 2025 +0100
> 
>      hw/arm/virt: Add an SMMU_IO_LEN macro
> 
>      This is useful as the subsequent support for new SMMUv3 dev will also
>      use the same.
> 
> which makes no sense at all.  But it's repeatable, so...

Ho hum.  It appears to be flaky.  I now see it without this patch set at all:

https://gitlab.com/qemu-project/qemu/-/jobs/11391070227


r~

