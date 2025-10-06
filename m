Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E23CCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 22:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5trN-0003Di-4W; Mon, 06 Oct 2025 18:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v5trM-0003DZ-6P
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 18:39:12 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v5trF-0004ju-S7
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 18:39:11 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so4539637b3a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 15:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759790340; x=1760395140; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y2PygMhf3v0Kovba2sxm9sQW1MmkM6HCjocmr9Uv5fg=;
 b=PtKv3BxjCQ4FhPW5LyPhDc3UmOO8cOYtu4AThQFF9+TgsGDvOi93Mo8/gZzOmxXysj
 NE6HVGEV3/HUwHgPKgfiwuUXHc7/05SDtjQuRkRGoM4/W9jucYLtaLe2abmRks/A9FkA
 lBlkksyaHlaWBlGhRtcb023QLbO6bM/GL4iiPJKhqScRGzTDgd0RMrQj8vCHUm9GyXym
 yr/t96aTPwOcNjYhMjX4Xt/t794VeoBTPLSYmAxgCKxcc+WJr4m7/lM5/dDK7jXninBQ
 IziZvbRo4kMKRLg/IY4MommEQl9xQrLkgeGjVwGNmZL5za5QpISGjxglk+XUx358GlWp
 7laQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759790340; x=1760395140;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y2PygMhf3v0Kovba2sxm9sQW1MmkM6HCjocmr9Uv5fg=;
 b=EY0HCiTzOvSQVaQRh1KycAO9OuCRaC13uiaLs/vvuitNiIRWrFIyxRHqyXGJAYAbZe
 G92SiKvP8NiM0zyqAPG6RslOFXw0DNeo719xuUNLrQqXTNVqsz4/te+tMxRaHLtdmzw4
 eyKDkxkRr3DeZQZhjhubzcq5ecWdED4xDSwEgcwK5QtKLuG8u37SXAktT5SE2mJreKOK
 rQqEKgTXC/puO8sa5yyUHW5Gfw3pOPK7yHEmZIYhkU9clpmnfJpLfDGrE8/35ujbr9pL
 zlpjp4tpy4fLswpXmFDM8ZQJo6pqBXF62+A0Mk8kWhUla+tpZEZV0AxAnhYPyoLGoBta
 S/Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcOpKgdfINa5IRCCsC8YkhzDrw2vRTeqlf4n+1Elrd6fW7jQkxzeTUX9r84J2YTOoRp3HZKDcShAQt@nongnu.org
X-Gm-Message-State: AOJu0YwkaBDnEWJCaChFfuCQxtWvnZkehBvht/OAxxcAMdOkpiBO29YZ
 lyQt2TXETQ6n/2WpNOBJFiDUqZzzhgZq90HSRhWaYusry59e8RlhwrLo1CyHzmqNr01psXLkWWD
 Xb7VpgIg=
X-Gm-Gg: ASbGncu3b7YoE9miGS+dcHLN8FlkqhCZeZi5NFsW+Oha2nV33VzAai/R4GjFOlO+Kwp
 3QnqWBBmkwnZ6eJxd6g2EwSOx/xs74XlcEFPeT0L+qL/gEP5ut9aK5wvc7UTwda0n7+JGtlSN0t
 /5VYqePnpnWDmsRB5aZ6LGXHvwbmqsrMdQKFoiFjVWYtAwQqqmTLdjNNpB+4yu5b6a3/cO71CfN
 nTeQabOC3e2NAmJvPoFkosgognPOeVJqm4NVyGGQiuRTOvwlUReXrB78bfa2RKw9tnRXtB1ninm
 xt8Y07/BRtmtrWe7kjpNFQPOAYFQ7MUbrQwxFi8SANvm7kW0KKKuts+fXUQOzKZ1KMc8E25YLwC
 Z0GBDdIvoDMbiJtoIJpstj52CD/4dWndsNOTmwH/SgNE7hm4PRt+FkS7ffGwEqrma
X-Google-Smtp-Source: AGHT+IG5CTfAsRi1crHJMZ+yl1Y2jzlUmjBp3yr7HpdzN+HbQMjqRRx4OtVBXHrndYR51vWB2VnmRg==
X-Received: by 2002:a05:6a20:6a15:b0:2d7:1689:e3bb with SMTP id
 adf61e73a8af0-32d96e984f2mr1496893637.22.1759790340181; 
 Mon, 06 Oct 2025 15:39:00 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b609ba636c2sm12854202a12.16.2025.10.06.15.38.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 15:38:59 -0700 (PDT)
Message-ID: <411110f3-dcc6-457e-a64b-c038e616d8ae@linaro.org>
Date: Mon, 6 Oct 2025 15:38:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/25] target/hppa: call plugin trap callbacks
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <cover.1759744337.git.neither@nut.email>
 <bfdf4d5590d40c345a96fda9bc2dda992721f073.1759744337.git.neither@nut.email>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <bfdf4d5590d40c345a96fda9bc2dda992721f073.1759744337.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 10/6/25 02:57, Julian Ganz wrote:
> @@ -212,6 +214,48 @@ void hppa_cpu_do_interrupt(CPUState *cs)
>       env->iasq_f = 0;
>       env->iasq_b = 0;
>   
> +    switch (i) {
> +    case EXCP_HPMC:
> +    case EXCP_POWER_FAIL:
> +    case EXCP_RC:
> +    case EXCP_EXT_INTERRUPT:
> +    case EXCP_LPMC:
> +    case EXCP_PER_INTERRUPT:
> +    case EXCP_TOC:
> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
> +        break;
> +    case EXCP_ITLB_MISS:
> +    case EXCP_IMP:
> +    case EXCP_ILL:
> +    case EXCP_BREAK:
> +    case EXCP_PRIV_OPR:
> +    case EXCP_PRIV_REG:
> +    case EXCP_OVERFLOW:
> +    case EXCP_COND:
> +    case EXCP_ASSIST:
> +    case EXCP_DTLB_MISS:
> +    case EXCP_NA_ITLB_MISS:
> +    case EXCP_NA_DTLB_MISS:
> +    case EXCP_DMP:
> +    case EXCP_DMB:
> +    case EXCP_TLB_DIRTY:
> +    case EXCP_PAGE_REF:
> +    case EXCP_ASSIST_EMU:
> +    case EXCP_HPT:
> +    case EXCP_LPT:
> +    case EXCP_TB:
> +    case EXCP_DMAR:
> +    case EXCP_DMPI:
> +    case EXCP_UNALIGN:
> +    case EXCP_SYSCALL:
> +    case EXCP_SYSCALL_LWS:

These last two are linux-user syscalls.  Don't you want hostcall?

> +        qemu_plugin_vcpu_exception_cb(cs, last_pc);
> +        break;
> +    default:
> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);

g_assert_not_reached().


r~

