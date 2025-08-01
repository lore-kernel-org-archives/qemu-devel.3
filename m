Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C9CC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 21:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhxJU-0000z7-Fq; Fri, 01 Aug 2025 17:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhx5i-0002Hp-OS
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 17:15:03 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhx5b-0004dK-Et
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 17:14:56 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-240b3335c20so14972115ad.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 14:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754082893; x=1754687693; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WjPpNgwTrvPmeak9CL/Zk2hsWJxggUt/1fB5HDCVvVI=;
 b=suTSS4DJIYBUeLyzWflyeKnKcTq70M8kQ0MeMRIw3eJFiRlRKMkf6/wGbfYNMfuA2i
 C/EoS7HojvUuSby6M9ARqX99hKvBJ5L0+n1h9xp1Nyd8J/sB5yLcpo5HIPDGt7Lcj90H
 XYFno0QyyGzytpP/isxDJUGdzknsh0JxsOVhcwFDhZuhxMPE61rNQMyeFrUJOPsDKozS
 JgWdg2pl69oLx8JRGi1OTxLUVIkfWsFWFAh5+ZOTvqp4GmANDNjuBKqJZDqTuBu0VGuh
 9Ko5HomzLYbyqu3VcCFXZwFSI987D6AMLU0u7sr72nm77pgGnBqTMS5u6zUY4grrQAfD
 tdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754082893; x=1754687693;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WjPpNgwTrvPmeak9CL/Zk2hsWJxggUt/1fB5HDCVvVI=;
 b=Ztjr3q47PH/J2n0ZLEF5tojSdCTroTYqy05Ks5luDAw+XZya8RwKtihD2syMPJlIQh
 oGNs7wYi7TEPo1Z+DLOD6zFui9i10/eKWAZrB+vgKSu+KKm4DAFQt9x2TpTq+nR33+Ds
 YYfCJCNXrsTYtBAzVfKxn93AFlTB+mkRNxkDvKvPFiQGq+9e+81TmvUzQf31aWcmmZqX
 SUUhjRDX9FngjzMQCUD+xANohsCO85gprgDiMoFn463PvBRf2DzmHiEWOHJQf+WF0RIY
 Olz4EIkvjtzAaszy+sv9wKSWCNCK1DnXynK/Y87WzNcXxNnVAoUnHD2H9m3jjdPU37sD
 PsVA==
X-Gm-Message-State: AOJu0YxMJ2gZeVgf4/4i+NXXsif8GwsYk8p/QxFov5NfmmvHjoCijg9f
 7nyCfjaNVmxdKF9IlMtBlaT+oUDHifQsVyifCGGlLkUM9GSW39Z6d88F1wred2dMQjA=
X-Gm-Gg: ASbGncvGNKtTQUSI8Sg3784NrkH/pAW3Yi95EfnYXQvgZG/tIw1OlvFfGBxc1ROzssq
 m+ql2J86HSAFX1/RuO4Cjzol+1Jjpm1N2t4CwvU1JO4UOcezcdYg5yU0vwtKwFlycqP38Dbu4Ls
 tw53oPc2VF1ciSdvN/UQAOLP4tEToY0aRR6NGQkV3LYn9LCTxuhwgQCSGSN/j75fdLBDSanNYnv
 jsHcCyEuDwEGLJKx0Zwh80nkLh33gB/arK7QM+jde93KxYJRmyNzSvnut1e28twbC4LRap6o6nE
 w9T/RYvCmBCCaD25kbMoIUVdEa36AmhGtqgfiybOTqKBzpXvqbKSQCvSzXb77cXKqvpN8vsvT3z
 zHI9eRwbsYZDl1cRegrVtMu1mCMdgI+FPE0OUAMue
X-Google-Smtp-Source: AGHT+IEqIoTtjuvvJCyfAqY3ugKn1tIyLPt4rujhtHluRsNc3jfpYCTDDy6RF7irw9obr0QfqMiiLA==
X-Received: by 2002:a17:903:2310:b0:224:1eab:97b2 with SMTP id
 d9443c01a7336-24247042aafmr14560875ad.53.1754082893545; 
 Fri, 01 Aug 2025 14:14:53 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f21c65sm51941765ad.73.2025.08.01.14.14.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 14:14:53 -0700 (PDT)
Message-ID: <ac883fa3-df62-47a9-97b8-8206dfdef47b@linaro.org>
Date: Sat, 2 Aug 2025 07:14:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/89] linux-user/i386: Create init_main_thread
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-24-richard.henderson@linaro.org>
 <CAFEAcA_bRSRDxxj-OpDRYSh+P_BwO2iMLqqHPUerma69Lhxw7w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA_bRSRDxxj-OpDRYSh+P_BwO2iMLqqHPUerma69Lhxw7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/2/25 02:17, Peter Maydell wrote:
>> -static inline void init_thread(struct target_pt_regs *regs,
>> -                               struct image_info *infop)
>> -{
>> -    regs->esp = infop->start_stack;
>> -    regs->eip = infop->entry;
>> -
>> -    /* SVR4/i386 ABI (pages 3-31, 3-32) says that when the program
>> -       starts %edx contains a pointer to a function which might be
>> -       registered using `atexit'.  This provides a mean for the
>> -       dynamic linker to call DT_FINI functions for shared libraries
>> -       that have been loaded before the code runs.
>> -
>> -       A value of 0 tells we have no such handler.  */
> 
> This seems like a useful comment to retain -- it's nice
> to know whether we're zeroing a register as an ABI requirement
> versus just being tidy.

Fair.

>> +    memset(env->regs, 0, sizeof(env->regs));
> 
> Are we not allowed to assume the regs are zero out of reset ?

For whatever reason, x86 doesn't do that.
Eliding this line causes failures.

I think the SVR4 comment applies to x86_64 as well.  Yep, glibc/sysdeps/x86_64/start.S 
contains the same comment, although the linux kernel source does not.  The kernel simply 
zeros all registers regardless of normal (x64) vs compat (x32).

I'll move the one comment and expand it.


r~

