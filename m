Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E754D0C600
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 11:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Ih0-0005YP-6X; Fri, 25 Oct 2024 07:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t4Igy-0005YB-Lr
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 07:41:20 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t4Igw-0002OO-3r
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 07:41:20 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4316a44d1bbso17920465e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 04:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729856475; x=1730461275; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Sq0PCK97dBw9m2SDXCXz9VXhfMyI2WzdsgqZwE6vrEM=;
 b=DOK8COphYaVK22O00Rth6R65QjH4pAwmeOWalEdveonQRcSS2uY083Fhp7JakzWD+9
 xUoice/c05B2muSpJ2+S1DWzxNgZeUr+TTXYZrZyzqhC3q+FlZ6oC6eEVSSnFsJYYqr4
 nmTwuWW6RDKsHlcgC2sBjqd0qdFODNBnyi5Lcv+vHf1BgnK+omkEc6F71dC+cHh8WAyS
 Qj2ZRWDo3zomGedT4Ri8n01y28I+f44mkYbBcBws5ViA66MZ2bbGGu3BdVA743QVW/on
 1FIIoVaHvz5VFgd+06n+zAOhjJAvt0NyKg4yh9qwYPE+gZXZ/LMbhoItrcY6JTMis/rf
 /itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729856475; x=1730461275;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sq0PCK97dBw9m2SDXCXz9VXhfMyI2WzdsgqZwE6vrEM=;
 b=qKA+lf7h16Tn3RbzQtTFtn0z5voj+khPSIVJLUH4OqFHGHt/922UUyCMYPqi/2Qhjd
 qfgm6yAn4zbwjm3JOqCohO+RHFCPMVxeBB/bRvwU/VgLcv4JeUw2UrQoMaqJskVi32Vv
 XpOukQ6AD8sNATynPlfa1+U0OVoAE5/0vOyzt5kiBlYjf50r7i5TTzMqPr+O330QSdUU
 K6c/n0LQrK6i85LMNSU36gjLv4FTqkxgRxI0Q8VOqQ3Y6vqJUEIRzRnUYHxxZIt6WxXx
 S+U3x0yeQaepAdqF6DQwbl29I5oXzuQ3BFZ7eKSFZqXbJc8dACnHVXJPpcoSS62cu7q3
 tWSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0bOE8wJZRmsLfmLy3hHJ6UStbmTfe9aI7zuC19YxLB3wgyrMSMOPwqvQbOto+O0iOoUm2DIcycIxX@nongnu.org
X-Gm-Message-State: AOJu0YwBX0xsjd5fdFF3P/oMI33SBb16JkWkslxetaOLzH/xeVFK0XFk
 F8OGuUFc4A8f3ImtDL+6xPZOEs1AKui3vkedVSYd3AnAZRrJv/JLbQGGKndl9o8=
X-Google-Smtp-Source: AGHT+IH+WYcAWvHEKHDdIWDJfmICaBckWFoiyWcwQ8C3xdMbePs2IHI+qeqf08jFppTXFrAbs3FPQw==
X-Received: by 2002:a05:600c:1c9c:b0:430:57f2:bae5 with SMTP id
 5b1f17b1804b1-43184189b4fmr67118315e9.27.1729856475401; 
 Fri, 25 Oct 2024 04:41:15 -0700 (PDT)
Received: from [192.168.200.153] ([185.201.60.218])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4319360eb09sm15323275e9.48.2024.10.25.04.41.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 04:41:14 -0700 (PDT)
Message-ID: <5cb882c5-a455-408b-9ec2-4e8d4bd88350@linaro.org>
Date: Fri, 25 Oct 2024 12:41:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: Fix GDB complaining about system-supplied
 DSO string table index
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20241023202850.55211-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241023202850.55211-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

On 10/23/24 21:27, Ilya Leoshkevich wrote:
> When debugging qemu-user processes using gdbstub, the following warning
> appears every time:
> 
>      warning: BFD: warning: system-supplied DSO at 0x7f8253cc3000 has a corrupt string table index
> 
> The reason is that QEMU does not map the VDSO's section headers. The
> VDSO's ELF header's e_shoff points to zeros, which GDB fails to parse.
> 
> The difference with the kernel's VDSO is that the latter is mapped as a
> blob, ignoring program headers - which also don't cover the section
> table. QEMU, on the other hand, loads it as an ELF file.
> 
> There appears to be no way to place section headers inside a section,
> and, therefore, no way to refer to them from a linker script. Also, ld
> hardcodes section headers to be non-loadable, see
> _bfd_elf_assign_file_positions_for_non_load(). In theory ld could be
> enhanced by implementing an "SHDRS" keyword in addition to the existing
> "FILEHDR" and "PHDRS".
> 
> There are multiple ways to resolve the issue:
> 
> - Copy VDSO as a blob in load_elf_vdso(). This would require creating
>    specialized loader logic, that duplicates parts of load_elf_image().
> 
> - Fix up VDSO's PHDR size in load_elf_vdso(). This would require either
>    duplicating the parsing logic, or adding an ugly parameter to
>    load_elf_image().
> 
> - Fix up VDSO's PHDR size in gen-vdso. This is the simplest solution,
>    so do it.
> 
> There are two tricky parts:
> 
> - Byte-swaps need to be done either on local copies, or in-place and
>    then reverted in the end. To preserve the existing code structure, do
>    the former for Sym and Dyn, and the latter for Ehdr, Phdr, and Shdr.
> 
> - There must be no .bss, which is already the case - but having an
>    explicit check is helpful to ensure correctness.
> 
> To verify this change, I diffed the on-disk and the loaded VDSOs; the
> result does not show anything unusual, except for what seems to be an
> existing oversight (which should probably be fixed separately):
> 
> │  Symbol table '.dynsym' contains 8 entries:
> │     Num:    Value          Size Type    Bind   Vis      Ndx Name
> │ -     0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
> │ -     6: 0000000000000000     0 OBJECT  GLOBAL DEFAULT  ABS LINUX_2.6.29
> │ +     0: 00007f61075bf000     0 NOTYPE  LOCAL  DEFAULT  UND
> │ +     6: 00007f61075bf000     0 OBJECT  GLOBAL DEFAULT  ABS LINUX_2.6.29
> 
> Fixes: 2fa536d10797 ("linux-user: Add gen-vdso tool")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> 
> v1: https://lore.kernel.org/qemu-devel/20241023144744.50440-1-iii@linux.ibm.com/
> v1 -> v2: Check that there is no bss, mention linker scripts in the
>            commit message (Richard).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

