Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAD1E69183
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 17:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEXZL-0002aS-UC; Fri, 22 Nov 2024 12:35:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEXZI-0002aG-3r
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 12:35:44 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEXZG-0002xH-2F
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 12:35:43 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ffa974b2b0so8681521fa.3
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 09:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732296940; x=1732901740; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fbn1TNQgQp6L2F6yLvsmne3Cm9U7hH7AIQw6n8Wn6vY=;
 b=sK01rDrTvbbsA6Chro6L9QDtyfd8/NGhG6fZm2hkxughGHwd0hCU+bfWTmtVhmuASa
 gZeGP1qOhv2QHMDHreNGf3YVeVpLBPQdtjT78/swrQ9pGWPtvtPEcNfIQ6GiVlNdLIev
 F68TuPKTj16wytYruGuQ2/CbegxjhlVfOiDi4yj+qZQVFk+VnjBgEVaYf5EnA/3C4hBX
 C+T/ZTs2XbT3Z7SzMHD8tin4X+TWu5OKsUyHmUu8ck6OeD4Z5l5H9JFZqkEx7Wwyjrme
 OJ3ImARXcJYqmo1Q3FsdOlVsYxJD2kY4nhJkpwQqbJeJlFS2rhSIKGto3RBYe/yRntxL
 u4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732296940; x=1732901740;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fbn1TNQgQp6L2F6yLvsmne3Cm9U7hH7AIQw6n8Wn6vY=;
 b=MSasFnWVTr2Ob8dJb7NlZvC8L+wxMgcSFNhvyTafdzoTMxA/cB5qGG5HM/igdeUtga
 Tdg1ybOsJ2qx2Jr6tKecyPE0usb0okw7LgIMW5UpvhRIgH2EsSSqFt+hvEEUhYte53Av
 yGGCzddI9fKYXbiJw7LTygo5/oT02sQpabChgo3+J6r4HovFsEW+qb/BT2QcuMoMZe+L
 Xut+r+f7R6fjKerc7cn+qrJMlaywuZBYa2P6NhokvQcAsXo+YXceEkOT0ctnFhb6+gwl
 uxiSOOC30/0EQ8AOzvdEvAbVopNx3yEfgwY9lNJd6QHjZ7Ii4XZGUWG7mHffHls+8YxW
 I4Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQIMwXAIsJGepia9/CO1xb3iDD2V2lMB11ks+3zogg6GwTrZOa25XC7ByNttxwkWfxMBcbPeE2Or/Q@nongnu.org
X-Gm-Message-State: AOJu0YyFUZt2AHGrXhKFVwr5v0kz4E8Ie+QViuQUdgzAQ7sdMHzrqxbD
 l4gmmclvuNtUU16YQNUt4Fb9uvJbGEXwVKWtxiJqYtN84kNzujvNJhO4yd6Q94s=
X-Gm-Gg: ASbGncuk4hsGVwWJOA5AjFRFj5ibEMbTmLW11gqUMHbOgEqtLH0oCNI0JJTNyQ2Z6Xv
 Y6wfMsvMni76ZNa906+prbfiAkibGfYhkqOPmnfP7sHt8EZ2pHlibDH2n7k9lfkqxc68q2eCR20
 WQzMIwaNoVAMfxQzIZALTEtrKTGN890FYbalNcaTjqlXJ02HrLQIHdPAF7uKrktfqpiaokyH7Vu
 rTqA7wMyrlQKKDTRHPdJ+3DA22LQXGAi1m6dLNwQYq+LF3l470iLR7P4/okJurVZxbO7nI=
X-Google-Smtp-Source: AGHT+IEsnOxiQu6pnnXliElH4K7uHZSB/TGXAgUsQPJdynPP6vSRxU9gTb2bpWu+JDBraEJBAEvMBw==
X-Received: by 2002:a2e:be8b:0:b0:2fb:3d1d:dd96 with SMTP id
 38308e7fff4ca-2ffa7131dc0mr20314701fa.20.1732296939977; 
 Fri, 22 Nov 2024 09:35:39 -0800 (PST)
Received: from [192.168.170.227] ([187.210.107.181])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ffa538f922sm4173041fa.114.2024.11.22.09.35.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 09:35:39 -0800 (PST)
Message-ID: <a6785c40-fa77-4cff-8244-479fc539fbfd@linaro.org>
Date: Fri, 22 Nov 2024 11:35:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 02/43] accel/tcg: Add bitreverse and funnel-shift
 runtime helper functions
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-3-anjo@rev.ng>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241121014947.18666-3-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x233.google.com
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

On 11/20/24 19:49, Anton Johansson wrote:
> Adds necessary helper functions for mapping LLVM IR onto TCG.
> Specifically, helpers corresponding to the bitreverse and funnel-shift
> intrinsics in LLVM.
> 
> Note: these may be converted to more efficient implementations in the
> future, but for the time being it allows helper-to-tcg to support a
> wider subset of LLVM IR.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   accel/tcg/tcg-runtime.c | 29 +++++++++++++++++++++++++++++
>   accel/tcg/tcg-runtime.h |  5 +++++
>   2 files changed, 34 insertions(+)

For things in tcg-runtime.c, we generally have wrapper functions in 
include/tcg/tcg-op-common.h which hide the fact that the operation is being expanded by a 
helper.

We would also have tcg_gen_bitreverse{8,16,32}_i64, and *_tl macros in include/tcg/tcg-op.h.

I've been meaning to add something like these for a while, because they are common to 
quite a few targets.

> +uint32_t HELPER(bitreverse8_i32)(uint32_t x)
> +{
> +  return revbit8((uint8_t) x);
> +}

Also common is bit-reversing every byte in the word, not just the lowest.
Worth implementing both?  Or simply zero-extending the input/output when the target only 
requires the lowest byte?

We might want to audit the other targets to determine which forms are used...


r~

