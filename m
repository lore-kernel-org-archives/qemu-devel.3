Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF52CF31A7
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 11:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLgG9-0006JH-QA; Wed, 19 Nov 2025 06:22:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLgG8-0006H5-8g
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:22:00 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLgG6-0006R8-RU
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:22:00 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42b3ac40ae4so4007421f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 03:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763551317; x=1764156117; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3tvGCO+spDxkBwlHG1v9svfAPielplP2gHFj6KYX0Kw=;
 b=K062l+6oxCuDxwI3PtdrKcAOfts/pxgbZmXYdZ2duAfSt0mqWlRTpFufsNLnuD5qAo
 C0nuzt1O1W40cU8GY9XOnR7fu5kVGXEuYwN9WlSg5hf2Pv7sFB70U0jZwB7L+mLDpyjn
 t2EB9OhzI6Z9pnp3W+k9PCoIq2U0An8jB/F8P5wjPS/foiUME5MR9DagUmdajDwFSLG7
 UlY5lKuCIfpPDvD6dJN+fBeDeKwfwdbaHyAFwGM0r8LDC/lORZ68cxSebDcM4pKxCyvZ
 4B51oBTxROVh/gk8gNjCwsMFga3Z71F4c4TctptMT3MHLgAsPJn8hO7A6EWONP0SLSpi
 Jh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763551317; x=1764156117;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3tvGCO+spDxkBwlHG1v9svfAPielplP2gHFj6KYX0Kw=;
 b=h5JMCwhXp7awZ4dlbMnvQgrLmJ9LfEc3DbJ/AakIxLd3XfLbIvM2qoKKYyUZfSWY9p
 Dj4gSmTKCseM/wjtwghXyRmfMjc5obNw/yZP9clro/tfUGIFEKQ7kWGwmAvIpk3cttNV
 v8YZb1bpUQwJI6gTfomt9SuhlFLQH7uoqyqNifrhKRxsgzlX1w1tLMnU98cwx+406TBu
 BVC++7k0E7pcHW4RnbFaZqDAZU80ompmbxyNW59pqcBtxYplJCa+RzKOXtm0VLiQiyLB
 fc6pbKDReK/KS1Cduk96bp8//nTPmjSazFZhbWCbo1hAlFLPkreYaa1UoDvJUr2WN8j1
 SLVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwlCx8kITv2ZClogkwvp6+qbq6199aLOjRzpnyGBcvhLUOK6pKJo5sRQky7gVFQNprDnLCfEiT7OYl@nongnu.org
X-Gm-Message-State: AOJu0YxdeO5c2qQHiD9NxYlZolNYExcnOUpWgNUObqpJAgkUzvY0SGzj
 R2C21oh79fnKzPeP/OAitli+toMj7dffyanppJewWeLqX3o0OqsGudwM0DHcYclZcdU=
X-Gm-Gg: ASbGnctRE2+qHCASb3VwKks+80KOnCKfFujsEOKNWhfJLGEFqy4jtnpqo5Gr4Dmurso
 emoRTB1OKQBP3pg2nj9X6b9mth/bzs4oaawuZYmCd4lnpIdHbYAn4b5ExzwPPyOmI1Zk1y1jksN
 DRbtb9C/SdQnij1iYnpr232qVBWL5dRyd5i+Fc6wLHkpYVOllxfVSPHcFBL87cRFjdOcdL1t6w0
 0rrbz/VPw1E7qWuqYGi567qHvgG/eJlognBYc3YKrUZRuKxAhv7AYpyXwbO3TFue6NKH6R/gUyL
 lH0cqtLemvpCD+137pnW7u1J20N6FE/cYC+tdUAypT8B6jQ4KHySdMtkGtpeFYumJydReycjnjp
 8UOFDxv0Nq5dhx0irhF6Z+SEaJhnMs16rh/hZqzv/K9REi3vlU5L2UkmPt8cKZUaXRubezyrSrJ
 CJ1bGD/fR6/t+4db5Li92nT0R/vdT+KzvCsmN5SQNaGfqG6Ur67rOCFLUhYOXXeGMmteCvr1go3
 Y38DQ==
X-Google-Smtp-Source: AGHT+IEABwIUuG9cgCTByjKHaJ/8KGlhcj+La7UTo15cC78kMQtVUHces0ThHHTxKYGRiSNKYcthew==
X-Received: by 2002:a05:6000:4024:b0:42b:3b55:8928 with SMTP id
 ffacd0b85a97d-42b59344ab4mr18786360f8f.20.1763551316976; 
 Wed, 19 Nov 2025 03:21:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:ed5:b1f0:90e8:1fdb:2cba:9db1?
 ([2a01:e0a:ed5:b1f0:90e8:1fdb:2cba:9db1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f1fd50sm37685360f8f.38.2025.11.19.03.21.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 03:21:56 -0800 (PST)
Message-ID: <18f5e9b1-d4f3-4c7c-90ce-aa9ca5032f40@linaro.org>
Date: Wed, 19 Nov 2025 12:21:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] linux-user: fix reserved_va page leak in do_munmap
To: Matthew Lugg <mlugg@mlugg.co.uk>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, peter.maydell@linaro.org
References: <20251117170954.31451-1-mlugg@mlugg.co.uk>
 <20251117170954.31451-4-mlugg@mlugg.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251117170954.31451-4-mlugg@mlugg.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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

On 11/17/25 18:09, Matthew Lugg wrote:
> The old logic had an off-by-one bug. For instance, assuming 4k pages on
> host and guest, if 'len' is '4097' (indicating to unmap 2 pages), then
> 'last = start + 4096', so 'real_last = start + 4095', so ultimately
> 'real_len = 4096'. I do not believe this could cause any observable bugs
> in guests, because `target_munmap` page-aligns the length it passes in.
> However, calls to this function in `target_mremap` do not page-align the
> length, so those calls could "drop" pages, leading to a part of the
> reserved region becoming unmapped. At worst, a host allocation could get
> mapped into that hole, then clobbered by a new guest mapping.
> 
> Signed-off-by: Matthew Lugg<mlugg@mlugg.co.uk>
> ---
>   linux-user/mmap.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

