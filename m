Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBB3C43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 17:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wecIp-0006Fx-MU; Tue, 30 Jun 2026 13:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wecIl-0006F3-Eo
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 13:31:15 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wecIj-0001E1-Ss
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 13:31:15 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38005a36edbso1438245a91.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 10:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782840671; x=1783445471; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7UWriNjdBHy+vVuTzwHGm6RzrjBtfocwaxBrddTQDoM=;
 b=rWfqc3vy4FqjmG3y3iYtzUh8hllXuEQCFZGAJ68maZGOv9CbcmV23OAXLBGKc01B6V
 V6vWImZcDjENw71wCFPVisaAv8DvoSVKbRdkjL0qm8tep61pm9hvEVneJKfwGgMyEiyj
 kEUS1PqJRR8++a4pRFwOvDId2JyTis/ox7E0kT7RWfNm6XzSNdWxAiNkkctxNBZG5izY
 Yy+aX/PO/uoOldDvwAjxfmAJx2K2CO8rQkvffv/79Yb+2QoBzf6/IrTH79H3O//tkPUF
 kePdwz/w/YLcwjxEMUuABqxpXmBC32a5fiudErxqkwqAVWs0zyON/b0c8R+tvCP3qo1j
 tgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782840671; x=1783445471;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7UWriNjdBHy+vVuTzwHGm6RzrjBtfocwaxBrddTQDoM=;
 b=KaUhwb3k24EZKqLCNv0T5AAyp75zPvuob3wK7IEZ0APdBgoC6t8FqjwaefDnvjPegz
 JEvOpxH0oSkWOXhFBtGYVwS2zGb/TbQH3dE/HCv9QM9t+sfgP+NfErwRXIyY8KKVGRf2
 5y7vckHXMNjjVALo15IQ4wJk8mzHu+jLtae+lm696hPsuWZe1qkalnh0vlTvq6/XtZ5o
 cklIBDNGwy6+1cYYOfqfqxZH/IrwsvSYOSXV3rqUJRiluUek+N2rCFV5+r6q6x4DFm1m
 cRatG5RV9agI4n/lI4I6r52YKtaK8jm73XX2D060RWVvGlZOh0HrM1A6TL2Wj15cM/bU
 tnug==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCFMLe0pO50vrsq0RG/c+Ys0iKB1q5RPpJ60sBm+3vHiTDeG6cy6a5/jNb8F6Z3M+ly7TbvD+jkIl7@nongnu.org
X-Gm-Message-State: AOJu0Yy8sxGKBhw8QyPBOTKnlwgLtHl/mNBj4EYmqkYRCiiLJ7eRzSJq
 2MLDyrtbb1G71rgHAimDhuvoaJKYvwU2xyzfogWmPtvZubx1295aphWN2tXUPB31GUs=
X-Gm-Gg: AfdE7cmiGduw96vCQfjpYabTKgEuEfdN6Kc3dZ34cymdwaje0DO/erxBPTCAiibDNAd
 EW6W9pBAKITXEY7svd7J1eDgxT8jNKOxUQS1foTr0vdjorjaxVrskUN7jJlS2/TxsV5jI+o+WHJ
 DP6ZQ5V1cdA7LqDcQFs9KD1G85xJyAEr7GcYxFgl1Et0nbb9iwZj77JncFgmurps5ryvwN7aoSx
 YxKDDxmiPx0biPGDxOSv8n2LnrSqpRt2KWBOoDXdyqDFxGzxFdf3Fi4jjlWgLkaMjrnhrD/Y30z
 e/pG12LWYV22Mko7wv4X7otrhkhknLJdSmh7Y1EoWd5/dHIEhzrdAW5SBDXlsNEZJf4KlN659k7
 Im4PQt6ONinqK2ggCklUWGQqoE8t7UDL9ziU4qKN1fNLWnBAtbB7x+EU91lhxgICSz8HLbbMQMJ
 icVZuiK4fL100jy3MpBcFw+SouH0t0N2bjRFc21pL2ythWVtbep/oyeE1nDKh4EgMy2MIt
X-Received: by 2002:a17:90b:4a89:b0:37f:eda5:5169 with SMTP id
 98e67ed59e1d1-3808bd6777dmr1240384a91.13.1782840671328; 
 Tue, 30 Jun 2026 10:31:11 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38095d76381sm289863a91.6.2026.06.30.10.31.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 10:31:10 -0700 (PDT)
Message-ID: <187d9a11-b1d0-44fa-bf91-43b723063a44@linaro.org>
Date: Tue, 30 Jun 2026 10:31:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] accel/tcg: use GTree for faster breakpoint lookups
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org,
 pbarbuda@microsoft.com, mohamed@unpredictable.fr
Cc: pbonzini@redhat.com, philmd@mailo.com, zhao1.liu@intel.com,
 laurent@vivier.eu, deller@gmx.de, pierrick.bouvier@oss.qualcomm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, rathc@linux.ibm.com,
 harshpb@linux.ibm.com, adityag@linux.ibm.com
References: <20260630171555.114844-1-shivangu@linux.ibm.com>
 <20260630171555.114844-2-shivangu@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630171555.114844-2-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/30/26 10:15, Shivang Upadhyay wrote:
> check_for_breakpoints_slow() currently performs a linear scan of
> cpu->breakpoints on every breakpoint check. As the number of
> breakpoints grows, this increases the cost of each lookup.
> 
> Replace cpu->breakpoints with a GTree to provide efficient lookups by
> address.
> 
> Additionally, maintain a second GTree, cpu->page_breakpoints, containing
> the guest page numbers of all installed breakpoints. This detaches, pc
> lookup and page lookup, into 2 different Gtrees.
> 
> Both trees are kept in sync when breakpoints are inserted or removed.
> 
> Signed-off-by: Shivang Upadhyay<shivangu@linux.ibm.com>
> ---
>   accel/tcg/cpu-exec.c      |  26 +++++----
>   cpu-common.c              | 108 +++++++++++++++++++++++++++++++-------
>   hw/core/cpu-common.c      |   1 -
>   include/exec/breakpoint.h |   1 -
>   include/hw/core/cpu.h     |  14 ++---
>   linux-user/main.c         |  13 +++--
>   6 files changed, 118 insertions(+), 45 deletions(-)

I think it would be better to use IntervalTree, so that we don't have to keep that second 
tree of pages.  Obviously, IntervalTree can query an interval, which takes care of 
querying for entries within a page.


r~

