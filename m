Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0C9CD5BA6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 10:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm9x2-0004sk-MI; Thu, 05 Sep 2024 06:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sm9x1-0004sH-JB
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 06:42:55 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sm9wz-0002Pg-Qv
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 06:42:55 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6d9f0cf5ae3so6938797b3.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 03:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725532972; x=1726137772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OGJxMImfEmD/8RUCmiXS9l8UScU1SKHCMiHAY6H8suM=;
 b=F0qECiw+stt0VHEvLUBy87uJjFStLkTR6fHdAchaB8iuthlcI14xImFXQCU79dD4wv
 aEREk+2VG8rpO+wDl7RDFjHBQVE8bCKtiQlTiFmruQVq6IdR93L6pa6Ynin9//65SIy7
 AjCMOGDDUCiPCFUuxs4stLPu9D7pMy05DPO7umu1+gyhGQ+YJbRfRxfyAuPzidjK38g5
 //KVTPqs6vPpszzHXG0s3497T/OBKY10dpRS+friRXiXx1o2ZRwMBQR4t6KzL36S9IbQ
 rT94l234nmrBOpgSlLA0Rwvp9smElWmPX4TKD7J+7q/XSnUktflFAVdZA2PsgEObPgaW
 N9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725532972; x=1726137772;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OGJxMImfEmD/8RUCmiXS9l8UScU1SKHCMiHAY6H8suM=;
 b=wDNP6GqZww3n8Eg5SLhwAUN015AvCZWlkd9e3iuG4VZBhAwk6pj3SIW3BAUQHH2mAk
 U+VS5ljaBuRZMu6mTdwWuzq1+2QhjBYnk8HxfFvmMw6fjMFPvVHLMa8wn7D3lpmf9H31
 erjUGoWddUlaeuj30AlSz7Ts4QKzPOWcBW1Qmb15IRTGVwMXA/MM8nbx4InlHzsFeSBY
 8K2lHwsxBKlr5Qb/TCADSA0lpjgp2QI8gNnOdm1if10dUa6nrS3Axkk7T6kJ2jvW1z6S
 MXcPBngxVjGPVIXykPiD+bmvoVrK7NPBnZ3XwE6KBaruLbwqGuN2jZTkmQ01nQkrXKuO
 KB1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVplLckn+UDeEljb+YJUYDzoEyg8W0+v/57WHAk8LDYSEbT/wBH2dwlVJJoQnaJ+7I9o41RYuW6wS7s@nongnu.org
X-Gm-Message-State: AOJu0YyRtdMu9EEuWmf8RHGhl0w/utKHfQmQikO3oIYyq5eJz8zSel8W
 FwTtIMbtpCyHm61DGngx4mV9SuOL/eR2jxnDyEIYK4Cuwqp0UUeYxZ6oePLwuTs=
X-Google-Smtp-Source: AGHT+IEdGN2cUyIHDOMiY3hcl0iQKkMRJGCro5F6Ns9PgdIA55Im5hU2Bg7o3Dj4xfhj7hk/ZLqElg==
X-Received: by 2002:a05:690c:6503:b0:6d7:f32:7376 with SMTP id
 00721157ae682-6d70f3275f4mr166847087b3.40.1725532972337; 
 Thu, 05 Sep 2024 03:42:52 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6db2bea5c3csm5682807b3.5.2024.09.05.03.42.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2024 03:42:51 -0700 (PDT)
Message-ID: <c24f9c04-b794-4a67-9e99-4a6f0ed217d1@linaro.org>
Date: Thu, 5 Sep 2024 12:42:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/15] disas: Remove CRIS disassembler
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240904143603.52934-1-philmd@linaro.org>
 <20240904143603.52934-15-philmd@linaro.org>
 <a88452bd-eb61-43a3-a557-0e552ab3bb27@linaro.org>
Content-Language: en-US
Cc: Thomas Huth <thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a88452bd-eb61-43a3-a557-0e552ab3bb27@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=philmd@linaro.org; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/9/24 03:30, Richard Henderson wrote:
> On 9/4/24 07:36, Philippe Mathieu-Daudé wrote:
>> --- a/include/disas/dis-asm.h
>> +++ b/include/disas/dis-asm.h
>> @@ -232,10 +232,6 @@ enum bfd_architecture
>>   #define bfd_mach_avrxmega5  105
>>   #define bfd_mach_avrxmega6  106
>>   #define bfd_mach_avrxmega7  107
>> -  bfd_arch_cris,       /* Axis CRIS */
>> -#define bfd_mach_cris_v0_v10   255
>> -#define bfd_mach_cris_v32      32
>> -#define bfd_mach_cris_v10_v32  1032
>>     bfd_arch_microblaze, /* Xilinx MicroBlaze.  */
>>     bfd_arch_moxie,      /* The Moxie core.  */
>>     bfd_arch_ia64,      /* HP/Intel ia64 */
>> @@ -448,8 +444,6 @@ int print_insn_w65              (bfd_vma, 
>> disassemble_info*);
>>  int print_insn_d10v             (bfd_vma, disassemble_info*);
>>  int print_insn_v850             (bfd_vma, disassemble_info*);
>>  int print_insn_tic30            (bfd_vma, disassemble_info*);
>> -int print_insn_crisv32          (bfd_vma, disassemble_info*);
>> -int print_insn_crisv10          (bfd_vma, disassemble_info*);
>>  int print_insn_microblaze       (bfd_vma, disassemble_info*);
>>  int print_insn_ia64             (bfd_vma, disassemble_info*);
>>  int print_insn_xtensa           (bfd_vma, disassemble_info*);
> 
> 
> This is probably worth leaving alone, since it's all imported.
> There is lots of other stuff in there (even in these hunks)
> that is not relevant to qemu.

This is no more an import, see addition in commit
aae1746c72 ("target/loongarch: Add disassembler")
and removals in 9992f57978..333f944c15 6c3014858c:

. 6c3014858c target/nios2: Remove the deprecated Nios II target
. 9992f57978 disas: Remove old libopcode s390 disassembler
. 333f944c15 disas: Remove old libopcode ppc disassembler
. 457248a54c disas: Remove old libopcode i386 disassembler
. 82f96346e1 disas: Remove old libopcode arm disassembler

I don't mind discarding this patch, but I'd like to know
how we can be consistent with this file and the future
removals.

Thanks,

Phil.


