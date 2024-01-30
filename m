Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3356C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 08:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUjRg-0002Fm-Go; Tue, 30 Jan 2024 03:26:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUjRf-0002FP-5Z
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:26:15 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUjRd-0003GX-JY
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:26:14 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55f279dca99so1723740a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 00:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706603172; x=1707207972; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3hFoYlaUcAhHmUYLVMa1OMNE/MF2MZe2XiXWbWUAdUg=;
 b=fF2+ATC9j4765fDkWtw3eEePRmCmiD4823zsUj7kIMYhPSp54aLI7yMw9JCGw6sYcw
 b17jrAr9uord2oB/EWFzboPKFQyRR0QWx+NI/ZtZOAHlf1h6/MsP/lprqHyHocodW5Of
 6O1QmUMXWulp32/q959MgnIeKLO68XETZuMl/rdo6DeMNRhwARUAhb7KHTwbSHSxJVw1
 eTWIEffZbkR8B0OOc+fBMd8PAQZsZvnxBdlo2KMvblqR1EhBy9KWZZXnAheqDRNDhd9T
 HTooMJL0q90KXSjxP0nVSNFpqh9dXcRmx6u+7GVaE+8jPlUQ510KUxNAIqS0Lh4l+l+Y
 BL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706603172; x=1707207972;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3hFoYlaUcAhHmUYLVMa1OMNE/MF2MZe2XiXWbWUAdUg=;
 b=Na+QVtgACjcuKlvtI69mMyVZcUyecgrwN4Qo64G32lr2pnSRQWJ8tSnJ03aBobpsT1
 X6YJiV322alo0zDU8EcrExbd1vIGtHrGZczs+Qxl6kQRw44CWv0ZcjUFeuEj/GoEeE5S
 Gk/3KDWMTWK3891kn/8v6c1EzC8890+kUdeAY254FiE6vakU8KuR9xKhM09PbXiHjOzb
 SvDfwpY7oHhpmTwb5oc6UzGsxjpLVdobuTlWiWpCaDkULWhJNKlCrmS4P6uG/ZlbWM/f
 +F8PkYOnH4oEQLHl9lefPxzmOKMlw47ClN/+zg2BQakYnyVQ9mUgrFEoSMWAHPe9Cj5R
 B87Q==
X-Gm-Message-State: AOJu0YxipV1jKihS3YMjr0g2MXOemZYGB5J4o1eIdWJaJFStiFuRTLby
 fz2V5OA0jKm+lX+Gf/ELV1R5Ece+UdCZoZhOmF6y+cud0EwsE1Aitg7wGHxonzU=
X-Google-Smtp-Source: AGHT+IFquD5s/9XfQgfT29qDEzNNm0g35hHf8skLr+whUPkC7v64R7ffvVGxgSNmct6OBnuu1pvZ/A==
X-Received: by 2002:a17:906:138d:b0:a35:53e8:c5d4 with SMTP id
 f13-20020a170906138d00b00a3553e8c5d4mr4223913ejc.73.1706603171939; 
 Tue, 30 Jan 2024 00:26:11 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 ub11-20020a170907c80b00b00a353ca3d907sm3762676ejc.217.2024.01.30.00.26.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 00:26:11 -0800 (PST)
Message-ID: <51e69a4f-9003-45b0-9350-24728d952d86@linaro.org>
Date: Tue, 30 Jan 2024 09:26:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/33] include/exec: Change cpu_mmu_index argument to
 CPUState
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng
References: <20240129233043.34558-1-richard.henderson@linaro.org>
 <20240129233043.34558-34-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240129233043.34558-34-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

What is the rationale here? (I'm trying to generically understand
in which case one is better than another).

On 30/1/24 00:30, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h            |  2 +-
>   include/exec/cpu-common.h         |  3 +--
>   target/sparc/cpu.h                |  2 +-
>   accel/tcg/cputlb.c                | 22 +++++++++-------
>   semihosting/uaccess.c             |  2 +-
>   target/cris/translate.c           |  2 +-
>   target/hppa/mem_helper.c          |  2 +-
>   target/hppa/op_helper.c           |  8 +++---
>   target/i386/tcg/translate.c       |  2 +-
>   target/loongarch/tcg/tlb_helper.c |  4 +--
>   target/m68k/op_helper.c           |  2 +-
>   target/microblaze/helper.c        |  3 +--
>   target/microblaze/mmu.c           |  2 +-
>   target/microblaze/translate.c     |  2 +-
>   target/nios2/translate.c          |  2 +-
>   target/openrisc/translate.c       |  2 +-
>   target/sparc/ldst_helper.c        |  2 +-
>   target/sparc/mmu_helper.c         |  2 +-
>   target/tricore/helper.c           |  2 +-
>   target/tricore/translate.c        |  2 +-
>   target/xtensa/mmu_helper.c        |  2 +-
>   accel/tcg/ldst_common.c.inc       | 42 ++++++++++++++++++++-----------
>   22 files changed, 65 insertions(+), 49 deletions(-)


