Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C497FC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 17:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfLSP-0002XE-5R; Thu, 02 Jul 2026 13:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLSO-0002Wi-0f
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:44:12 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLSM-0003tr-Io
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:44:11 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-845e47133c9so522112b3a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 10:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783014249; x=1783619049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=58KFP0d58YCzYhxpZL5hhXQOtVw2kPpIKTHIW7aDVsc=;
 b=UDoL5WwsgQyzUKMuadbnQk1wZCfyEhWCkThPhBXKJddOU5xB5NOlQ8y4jzLwhcBEOr
 3At177FJRLfmLgd4cFEZtjJU+d5YnWtKIi/dpyuKGWfW0vK5JWDijRqvvzgHgZnHn862
 bax/hPfBImhFi2MhRpDENNZCW2+evKgtcCqBVogFEbZksvOs7m/pweghINbqQKCmP+N1
 sHS6IJb6VViI9LjIwqtvxNdQcUQJppA5EDtNHQYh9Zz33c+72sapOxzBgZAT+qJxiBoX
 1wp5CwPyvvatJ/SyI41RWTXs9YTaKblYgCL+v8PnLRjDnY2hPK6ybiYvij1qFEc+4W7M
 7bQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783014249; x=1783619049;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=58KFP0d58YCzYhxpZL5hhXQOtVw2kPpIKTHIW7aDVsc=;
 b=Clb3LuHo+NgYehqg8EIhbCTaycrOOBULYtcuP0KhDZ3NpXouGmAhUI9C3D7AjmcrtC
 dQjwroXHK/bMgnNOgYSXCmBtTj5FJFTkWiJTdMvWH1MowVjYFMgWIblkCi6W5buasAqq
 StKN4IzVB5vhmS1sGRxjGU8984RdnOKQTI4xcmcPrkheppr4G7lnvQr+PGRd+VV8Q+nM
 lzr8y+WYfTx8iyGNNyTnX/nxNddqgXvRq+bLYtrdfHcDAu98rqCRGudcqzRwFzt0XLvd
 bzmo0mptmIU6HYSNTT0niNYD7F0BoG1JEXi1iWgG6g4TUrKLtexbx5350mtiji+U+x8v
 cxig==
X-Forwarded-Encrypted: i=1;
 AFNElJ9LePPcdMAkQ7h1RGXfKFrh1kj7kuGbPhkw51ppWjE14MB23R0wDbrUJOHWgo+RP6MlGtK3WzafXfEK@nongnu.org
X-Gm-Message-State: AOJu0Yy+yZhBLey8dp97rEXeSHtaQlLv4JbXftP+EzdNONa2DTGGvG2e
 O96N5qIGFJdq4gLzUe+pR1qtB6ObotHkLs2gom28iEQJHmZaApE9V9MqsFaq0QHOes0=
X-Gm-Gg: AfdE7ck+FtUVKi3sxDoC79HagSbjqy2lTYbD93nFSnaMIlztvm2sD3bm6xNET0fzMIH
 j/zMJivVxbkn7KBYlbaW4NeJ9kOAfFGeSAAx6xQyzZhLq/OcrY5uFijC+mruGkPS6VLpOfup6Xm
 FslxjJA8UhvRle7WL2rwmXM17p5cIbyJXtqNGOQG/2x0dzxqIRb99ZSuo4LfRXo/TT4ENVfUhcU
 3r8eP4tF+mVi9vL1igJSPstesHaqcBZozXnQyWLDbxnzSoSiXctdyCqZ9hQNRGOoMP0EobqcPZj
 DolaP6bBjcPz2M2fxDLSXSffFUG2A2MQy8ptKizjenY6rpKSB+dT7jhIXmHKi0Gr4XSal7Z54bV
 xPmKB4Gx4CGRK9utIoVj79vruJn2brilVVYv/vZXasB747/plEo8bAuEksvdYsAD2NugAw34Tj7
 DiQ4DXzOOlnVUdpsePxKqdbGhAcksR5eb/bk/oMpK2ZVKtZMCw1QjVHZLVNw==
X-Received: by 2002:a05:6a20:5483:b0:3bf:6763:f0d0 with SMTP id
 adf61e73a8af0-3c01c5e99femr891141637.4.1783014249053; 
 Thu, 02 Jul 2026 10:44:09 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9e91b07646sm1497690a12.16.2026.07.02.10.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 10:44:08 -0700 (PDT)
Message-ID: <16194822-eef6-4029-b301-fa5c0d3ec2f6@linaro.org>
Date: Thu, 2 Jul 2026 10:44:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/33] cpu: Define BreakpointFlags type
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-19-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-19-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 6/30/26 15:00, Philippe Mathieu-Daudé wrote:
> Use the BreakpointFlags typedef to better follow when
> we deal with breakpoint flags (BP_*).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/accel/tcg/cpu-ops.h |  6 ++++--
>   include/exec/breakpoint.h   |  3 ++-
>   include/exec/watchpoint.h   |  8 +++++---
>   include/hw/core/cpu.h       | 11 ++++++-----
>   accel/tcg/cputlb.c          | 12 +++++++-----
>   accel/tcg/tcg-accel-ops.c   | 10 +++++-----
>   accel/tcg/user-exec-stub.c  | 11 ++++++-----
>   accel/tcg/watchpoint.c      |  9 +++++----
>   cpu-common.c                |  8 ++++----
>   system/watchpoint.c         |  8 ++++----
>   target/arm/tcg/debug.c      |  4 ++--
>   target/arm/tcg/mte_helper.c |  3 ++-
>   target/ppc/cpu.c            |  2 +-
>   target/ppc/kvm.c            |  5 +++--
>   target/riscv/cpu_helper.c   |  2 +-
>   target/riscv/debug.c        | 12 +++++-------
>   target/s390x/tcg/debug.c    |  3 ++-
>   target/xtensa/dbg_helper.c  |  2 +-
>   18 files changed, 65 insertions(+), 54 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

