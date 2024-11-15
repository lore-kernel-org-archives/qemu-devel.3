Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63283D68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC0TO-000101-MJ; Fri, 15 Nov 2024 12:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC0TN-0000zr-Fp
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:51:09 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC0TL-0004ll-Uq
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:51:09 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7f71f2b1370so1524366a12.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 09:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731693066; x=1732297866; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sSV3VnbEJAOd/AVQxoTdGgOhaSey6SGWjW1QwZMuWJ4=;
 b=HdpeJfc5Iz6dGidvcFqz6ZeaQMmox5RNA88Kn7cMzav/yI3fVALsWhGTVwcOUqRnES
 pwt8ZgCPyrhvFYHHH83uCao1KbDfvYPNRmw316N1ow7SndVbcF3B6iXk/1dKw3jBCh4+
 tkwdqTUhQFkCz8Hns/eMBhqfR3lg5rg9IKV0tJzIn9D0hCLwcmdrON1P/D/lrBXPJyMV
 lyYBGOTYDKS9r5n5iWDIslBXgHYlzFMTbgzDuPc364XFppVznc+YympQN3wufH0Blc2k
 dbU8nCuMmqdyyhU056fU1MQHVHbuBN13jEyoVbh6yMRjCne3sMU5GmLljaMzCIeReQqG
 bVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731693066; x=1732297866;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sSV3VnbEJAOd/AVQxoTdGgOhaSey6SGWjW1QwZMuWJ4=;
 b=lGYSq4yi+C3gCNlAs/zojhZJisP2lLHBG359nxlpraJX6SbmRsdr0HNP1JXzmGBofN
 ejTNBUNUzr55ItF7/G5yT81tL3qCsc97NEY601HPnX/Y3jvuHFEt5Ad7AsVnOB3JsX9E
 /Xyy5SS6NGactQcd6k7oYHEdGw+T5YFMbn09SBTBQlAENBzLJ3Terl70MpLFuz0o2o2x
 Ss9TpZ4RTRzxymK5B0p023Iv2NbEaRUNKwDtJ0v0kh9+FwjY93hYAOo3Sx6F7w7bPiW5
 H/Boju5Y54h8q9/gI5peUe15TOGcAYxuxJQnWGYZy/r18G2gdPDdwpabBpAV734xvh0W
 Ut3w==
X-Gm-Message-State: AOJu0Yy0w5d4EZwKMJ5cPFHOvb2RGnL/ek4/y5JsJ5GCnGyZMhoIKS0I
 bMJY+NUDAVcw5diycchibrAiMA+lu9GmmUzepi54Xu3v6POtjdtZsFaLkuG5RXgsHGJdS/TXGKP
 /
X-Google-Smtp-Source: AGHT+IHIYv3h0rzbmeVW17V//PX06ZKxTgE8sgVja/k0RDKd4Pd2G93yMNXLdjlambbgn+Al6Qtx7g==
X-Received: by 2002:a05:6a20:7faa:b0:1db:d756:6136 with SMTP id
 adf61e73a8af0-1dc90b07cd9mr4480734637.3.1731693066108; 
 Fri, 15 Nov 2024 09:51:06 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f8c1c176a5sm1553046a12.3.2024.11.15.09.51.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 09:51:05 -0800 (PST)
Message-ID: <68bb9f65-c2b3-425f-9f0d-1742de2d1ad1@linaro.org>
Date: Fri, 15 Nov 2024 09:51:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] hw/core/cpu: Pass CPUArchState to set/get_pc()
 handlers
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241115152053.66442-1-philmd@linaro.org>
 <20241115152053.66442-9-philmd@linaro.org>
 <CAFEAcA8X8zp7oXKjiVOL_uCGdM8r00jW6S1efkm-M6f4fEuGdg@mail.gmail.com>
 <483152fa-78a1-4e65-bec3-e7fb31b96929@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <483152fa-78a1-4e65-bec3-e7fb31b96929@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 11/15/24 08:21, Paolo Bonzini wrote:
> On 11/15/24 16:54, Peter Maydell wrote:
>> On Fri, 15 Nov 2024 at 15:22, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>
>>> CPUClass set_pc() and get_pc() handlers are target specific.
>>> Rather than passing a generic CPUState and forcing QOM casts,
>>> we can directly pass the target CPUArchState, simplifying.
>>
>>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>>> index db8a6fbc6e..70f5f8c3bf 100644
>>> --- a/include/hw/core/cpu.h
>>> +++ b/include/hw/core/cpu.h
>>> @@ -160,8 +160,8 @@ struct CPUClass {
>>>       int64_t (*get_arch_id)(CPUState *cpu);
>>>       bool (*cpu_persistent_status)(CPUState *cpu);
>>>       bool (*cpu_enabled_status)(CPUState *cpu);
>>> -    void (*set_pc)(CPUState *cpu, vaddr value);
>>> -    vaddr (*get_pc)(CPUState *cpu);
>>> +    void (*set_pc)(CPUArchState *env, vaddr value);
>>> +    vaddr (*get_pc)(CPUArchState *env);
>>>       int (*gdb_read_register)(CPUState *cpu, GByteArray *buf, int reg);
>>>       int (*gdb_write_register)(CPUState *cpu, uint8_t *buf, int reg);
>>>       vaddr (*gdb_adjust_breakpoint)(CPUState *cpu, vaddr addr);
>>
>> This is effectively the table of methods for the CPUClass
>> class. I think that methods on class A should take a pointer to the
>> object of that type, not to something else.
> 
> Yeah, the diffstat is enticing but I agree.  It's particularly confusing because there 
> isn't a single type called CPUArchState*, it's different depending on which target/ 
> subdirectory you're compiling. In a multi-target binary it'd have to be void*, and then 
> you get back the casts.

Likewise.  Any cleanup should be to swap the QOM casts with cpu_env() within the 
individual methods.


r~

