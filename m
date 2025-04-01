Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4103C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 17:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzfmf-00054J-Lf; Tue, 01 Apr 2025 13:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tzfme-00054B-UX
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 13:52:20 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tzfmd-00025s-Cu
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 13:52:20 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-72c1425fbfcso3184123a34.3
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 10:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743529937; x=1744134737; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ea7HQfB3TRM5FsV8gbWuYrmQQgdPEoKxx0tDATpiUiw=;
 b=EfDLboBwrCQFwbMw7dz5aTltfbMqFHxsF4LwyDwUj+4FqRkDz5qwSETNs5CPE2BUvU
 oABTl80YE/5wMsPYSNsYsF7zzLW04e+hxlEc+FCN9zB7ROoKa/XuS1Wggw9j0/zZQ9On
 Wp0m+Aw2+JxpI14nsGn9qFU07KPkq3mN9AoK9w65uiLXx1drKB1Yke/4AuWzxrKsIKe3
 Izpr8Lp8mMsC3rncsq3z2dOX5ELZQ4c+waLyuq1H030OWerU8ZcbHRiJAfEgr3q6a7Cl
 w+8U3/BxJdYdc5TSyX4jZxnL2GUJaX7a5Qb4RwWhStzm45RbRLKkwsteyQ2tg+FOcwHM
 HX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743529937; x=1744134737;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ea7HQfB3TRM5FsV8gbWuYrmQQgdPEoKxx0tDATpiUiw=;
 b=Wa9n1poHFeoDvfbHXbYVXXV6qvUhsoVSw8X8dCfh4GxoZvV/1mcE+6iivl0e5vtvea
 zYnH8LmbrgQf50kyAe/Dis+X+L/seU2Mrl1W86sMJ/dv+PUpo/7YcgOTMZfex+FfcNIV
 A1Z5f4uB+VA9m4nJOM8vxnhMwZzVuY1jqNMVccHM1iqikuRIkRaFTAiZwypVT1FmZBwZ
 r4jveAw5yZ+JsFbmw2pi5I70OBi1biEt1CU0cQl+1cWHJlQxQUeQxeHxUR3XXWEizjSx
 nkrOhYQBSAcM4F6SdhqRcPDTa+Nt109uzxYp0H4L+4OcBfs0MPLKtQyQ3hHLA9WrORbq
 xDzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzl8gGertmDBVcGT6fgwcRlU6RydmtnBUksqTrGVXMkTIZlN//p0fOs1b9oWcSDdW+TnOp3JUwab+2@nongnu.org
X-Gm-Message-State: AOJu0Yx4uVW/KMSGUw+k8IJdoP78Ysm470FRZHeZ8J8vATqygMNoDdB1
 DtGjkaq1s2H/Gl2cYcra/xamquJbWnkiHni8STgMvQzYC+0CpCGVNjoL/gn/ues=
X-Gm-Gg: ASbGnctv9TqksOQ9zm4gCVbYvUdHxUZp6BzOvr9Q5SHmlIGgo+EtHAz6p3aRRlnLXBE
 GULRx5s7xnxR3tPw0jj2UoNvR9UOoMebOOWIpWoQLG6j+ND7AFcl/Cxes4nSs9EVJhV2BrqSTUL
 j1Y+4bXfyKYXjmKAQYVxrTVG84EOWBTkaJOYO5EANDUxeQ6FAbsr+Fz0uIpYZKWhEYcNxoBiq1n
 mql71fYxBDhHFPZU4gblrYD+Rge6jNyNWJNrvCHjjO57Kpt5o0XWCP3j4wRYqr1s58w2VIWaLQK
 Y5vWYZlSKYtJTn+jtyMNbK8rOwFh+ZWL83nlnB7OlEQe66BkG8YYgcV16BXl9UvpVMM+p9o1bSo
 +B+nSqdmzVLhZJ7QHOIaJNA==
X-Google-Smtp-Source: AGHT+IHh1bOuVYaxaN8B/KhIe49M7h39yhikvYgwHpKWn/f56Prr6KhHAN7zDc59zqNtfB5Awb579g==
X-Received: by 2002:a05:6871:728d:b0:2c2:544d:e140 with SMTP id
 586e51a60fabf-2cbcf4d7d6cmr8043177fac.11.1743529937432; 
 Tue, 01 Apr 2025 10:52:17 -0700 (PDT)
Received: from [172.20.102.85] (syn-071-042-197-003.biz.spectrum.com.
 [71.42.197.3]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580ccec9sm1969979a34.31.2025.04.01.10.52.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 10:52:17 -0700 (PDT)
Message-ID: <e27f3a93-66e0-4555-9ec2-b6d9e0cc5077@linaro.org>
Date: Tue, 1 Apr 2025 12:52:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 00/24] cpus: Restrict SoftMMU mmu_index() to TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250401080938.32278-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250401080938.32278-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

On 4/1/25 03:09, Philippe Mathieu-Daudé wrote:
> mmu_index() is specific to TCG SoftMMU,
> moveCPUClass::mmu_index() toTCGCPUOps::mmu_index().
> 
> Philippe Mathieu-Daudé (24):
>    hw/core/cpu: UpdateCPUClass::mmu_index docstring
>    accel/tcg: IntroduceTCGCPUOps::mmu_index() callback
>    target/alpha: Restrict SoftMMU mmu_index() to TCG
>    target/arm: Restrict SoftMMU mmu_index() to TCG
>    target/avr: Restrict SoftMMU mmu_index() to TCG
>    target/hppa: Restrict SoftMMU mmu_index() to TCG
>    target/i386: Remove unused cpu_(ldub,stb)_kernel macros
>    target/i386: Restrict cpu_mmu_index_kernel() to TCG
>    target/i386: Restrict SoftMMU mmu_index() to TCG
>    target/loongarch: Restrict SoftMMU mmu_index() to TCG
>    target/m68k: Restrict SoftMMU mmu_index() to TCG
>    target/microblaze: Restrict SoftMMU mmu_index() to TCG
>    target/mips: Restrict SoftMMU mmu_index() to TCG
>    target/openrisc: Restrict SoftMMU mmu_index() to TCG
>    target/ppc: Restrict SoftMMU mmu_index() to TCG
>    target/riscv: Restrict SoftMMU mmu_index() to TCG
>    target/rx: Restrict SoftMMU mmu_index() to TCG
>    target/s390x: Restrict SoftMMU mmu_index() to TCG
>    target/sh4: Restrict SoftMMU mmu_index() to TCG
>    target/sparc: Restrict SoftMMU mmu_index() to TCG
>    target/tricore: Restrict SoftMMU mmu_index() to TCG
>    target/xtensa: Restrict SoftMMU mmu_index() to TCG
>    hw/core/cpu: RemoveCPUClass::mmu_index()
>    exec: Restrict cpu-mmu-index.h to accel/tcg/

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

