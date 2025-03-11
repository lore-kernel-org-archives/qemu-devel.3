Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCC5C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts57v-0002Am-9q; Tue, 11 Mar 2025 15:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts57s-00028J-MW
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:18:53 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts57q-0002T2-MK
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:18:52 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22355618fd9so112989815ad.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741720728; x=1742325528; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e8Xmnm4KLCJpMW4A+Y3g2MTRk644I6eBf7N6mpkQYVM=;
 b=PkImvcq3x00pdO/zsky7i4NTEWd5UWFtBc8RBDb06NqawJwJremnXai6B4e4ojx3PS
 NAG8psadzy+alS339kNPWyapKk9wmAXHp9C2UnshwiAvlQyMiH0oSu0LziGgs8OZhG0v
 BQRIBwfCYTpInQ/wn5/G5q5FPXn7e7xLlrRoN7LAjXeVyh2ZI2tqh+yfOfa9yRP9Wtoj
 jxit635+fz/RHqw5u2XiCm3ODP/CXiYGtvECbwhQtXzSyogq94OrP1IccJbBDvjtv5O8
 KljFgh5lIzigfw2K6cEVmMczNHWlyAgl51C/gHvrgZ9Dgdy76jVWX+6jv4MnAuDKHW7z
 gBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741720728; x=1742325528;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e8Xmnm4KLCJpMW4A+Y3g2MTRk644I6eBf7N6mpkQYVM=;
 b=janfvracvyHFGoGt9WmpAR6j9hT9a2BiyMGNoOIc12ctZde9T0WTKZW9Fsua8er+m6
 j1yzaGJYqenJlOh4sW2DLiwKi28kUHaY99NcYARQGK6xy9QAewMCwVrBMidgu5P+3qrC
 EE+gwzvzlHFDzap9ao5eJgfEpJeHlgp7femVuqSzteMRZ9mvwpiqWFSW+mHCNRju1nzJ
 vID3IXsGpm8Uo/6p5t1Ssw5TbQo3vN+nnTZm3tYFP04Gd5lhA+mktauigL1joE6nS41E
 uUXUBbrhdkWthywjzXN5Cyj3/ztEPqgsvXhK7kK5lkm9DHgmIxwrI/o/BROk7FOQPxGt
 eMAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEFn/pNaf3p35Q2afUEgo9yI578771oCetv5b6uKBYzOG3D0nLpJrVlTPzzXOo1Wqu5b3+k0Ks0VyB@nongnu.org
X-Gm-Message-State: AOJu0YwazyHPZqqIRZlSYHeAevbtMTDMO4VY0cW4rr+PJUn6gA1u35qh
 2c9+HDZPvzoJL9DlmsN0MSoFYVUz+rrCW19yVGVe3pVMTd9TWAc6KyYzq+RkeCU=
X-Gm-Gg: ASbGnct44ZqChse9qX/ra9EJfQHXULBcMj7kmmyfSGCOdekfU2UlMA20bDeB5oEZzNc
 OtDQrNLqpnmDBVMqCBKGVL3wJRSjQPHqZqf3s1u1SVyAC0SJjAvxer8lySioQRvPpiHaj7cVaSK
 epXBuO1kmLPwb6PTi9+G9i0Y7fsted8xh9B2aNJ16qIj86qqjC+ytMI6E2cIrQNvL4jla9gX5TG
 tkOXy+08eNs4E8N95E6o71dMLF2bOdZ6smV3jHeFcOhSXxhZwtrRbEFIr4VQwDLBT6qNCuKrAqT
 cFmx+ZG+B7Hcjz5RZl3AJmF2H2dKx8SrQ3fg2td/kvOgzDNzmsLquMphGDaPo0Dtqb9vSt0x4LU
 6WV/Z7eg2
X-Google-Smtp-Source: AGHT+IF9tTdhE6AsJbONZZ2PRZHUmcK+UWwKhFiYa+k3jsfyLdHTX5LtOIBHyFMFaxXH0WXeniJ92g==
X-Received: by 2002:a17:903:2d1:b0:221:7b4a:476c with SMTP id
 d9443c01a7336-22592e2d657mr62485475ad.18.1741720728593; 
 Tue, 11 Mar 2025 12:18:48 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91cb0sm101683245ad.184.2025.03.11.12.18.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 12:18:48 -0700 (PDT)
Message-ID: <74dc2bbd-2813-4470-8c13-843d93e2426a@linaro.org>
Date: Tue, 11 Mar 2025 12:18:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/16] exec/memory_ldst_phys: extract memory_ldst_phys
 declarations from cpu-all.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
 <20250311040838.3937136-5-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250311040838.3937136-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 3/10/25 21:08, Pierrick Bouvier wrote:
> They are now accessible through exec/memory.h instead, and we make sure
> all variants are available for common or target dependent code.
> 
> Move stl_phys_notdirty function as well.
> Cached endianness agnostic version rely on st/ld*_p, which is available
> through tswap.h.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/exec/cpu-all.h              | 29 -----------------------------
>   include/exec/memory.h               | 10 ++++++++++
>   include/exec/memory_ldst_phys.h.inc |  5 +----
>   3 files changed, 11 insertions(+), 33 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

