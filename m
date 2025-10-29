Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B4DCCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 13:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE6IV-00015T-4a; Wed, 29 Oct 2025 09:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE6IP-000150-CC
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:33:01 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE6IB-0000qQ-2p
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:33:01 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-475dc6029b6so46675445e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 06:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761744762; x=1762349562; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tBRVXWIuoG6UnszO8RQqkG/b216T/xbuCglwkaMOIh4=;
 b=VnO5LvZWDBuLeMRy8iiz3SZwxaHNoxpm+MCR0TR/p9+AObyew9m6cPQt4e4OCngsqw
 tAOWybIatGVNFxOdPS80S4/9D1e2MhoNSDysKny8XDW+XwL1bppb8mw/BdvXRx/N+Km8
 jJZBol4YkCoOmpZv1/U1nvAjupa3JtSdhdB8USABQZKj1TvxTHHRNV1sUFEXTGvkNJpz
 18ah1qCD79dhBtC3qr0bHBEfGymfX/U1jiqvjzj58VSlFEN5NR2CNQ02C8tXhSNejjZx
 sBGJ0pu0cmMbVrsu2PhNgB4cPQcT2fVjtgRpOt+M+orgFGh0s/q58GaEFoXNZiECCFCP
 Xxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761744762; x=1762349562;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tBRVXWIuoG6UnszO8RQqkG/b216T/xbuCglwkaMOIh4=;
 b=qwSbZrQexqj0lvLQmxs0XDgqv9Wv/cJ6Za4jBZan9nmxrf4d92/QIODq4GFOZCSLo+
 +F9BdEV15KPevqbPYWcxX0hjlvBTPTV0q3IBShblRdTPsCi+HRVEYQF3NuqJ33yQyOXh
 3htPSAJMm/8anTY8TWZmzm6IUbBhzCxxuaBtVbDb3WJQehswhYU7DRiHlhSM3hgT0kKD
 iueYTu+OFpAoqDg/DkM4k0CcOAT1+7i/yBNkm4+Ihd6QF12jpwxFfe0oZg7PJdYM8VOc
 Ry+5D/b7uOBgkDOKmcetXzM4pnc1YCwp75foex9CCL3fcjtlPVm8GlVmmo1T8oGbR1RP
 AEuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLNgH7xCtf3DY2haFvspi/CWwoHiNHT/tks07YJsMOSPTbeUmcW22uhxO+JxVUW+D86jSEyUohF0A4@nongnu.org
X-Gm-Message-State: AOJu0YzruEBh6T824k5m+DYZDtcF3ii9YjKsJJ2q7pyfuts6yD4q3QUL
 L0OoGmlCx3esjMDQvwrry1RLkPHi48clXRV5OeU3DhRomiQs7+WEGDmqZIRZLr/XskUcfyvvY17
 XDEdArwo=
X-Gm-Gg: ASbGnctvYYZEi1TBlJ8wHtOejQ2lbjc2eYfx1YQDjTxZ376vRIfrqY/fq0dyJFDQAr9
 N5l01UYLy2K1OZIVhYRFVuoiI4n0vKb6S3nVtWizSdsKnjWtbfypQGjgpg/qX1nE5EL/UiQYsmZ
 jvkLEfcYKgVIT4hyfFUxC/TqXppu5fZTmTs3Tph3ncdSmR5ogTlkS6/zjzCzknmvBUlqcOnaebG
 9fHNkhC4Yh0MxeMxgNWM+VQzzTWU3hgcchRCIYbwRD2Zpk84cX/sYb1Nxn3hzq2hB1y72rGRT+L
 fNQ/umVHezOVRZal5a0eRQJ5qEFjj6nih29Gb042Vif+xNYsiZ5uPB+/45SRgrBemlPzGs9aDiy
 vHaLf8WdPH1NaloI0RsQzq6UG/XXe4Rf4ii6xrLyKdTwwZPTL3SKtZ/8ROLA7tVI4zvXKEvxwwZ
 +15FKDlS7D/Jw6qKrznkb98Li7Qt+KmueZ0oCvILAc/og=
X-Google-Smtp-Source: AGHT+IE8aVzaLRWLcxrbcIsqtJL7gJwtkyR5jTxzBSbPQdXYdTZHZAqtPIaJ3ZxqaNLHG26G3l6FGA==
X-Received: by 2002:a05:600c:4e50:b0:45d:d505:a1c3 with SMTP id
 5b1f17b1804b1-4771e1f1ca3mr29093855e9.37.1761744761970; 
 Wed, 29 Oct 2025 06:32:41 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e387aa9sm47102705e9.4.2025.10.29.06.32.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 06:32:41 -0700 (PDT)
Message-ID: <aaec51ff-eb4e-4b4e-a071-894862de0ded@linaro.org>
Date: Wed, 29 Oct 2025 14:32:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Introduce and use MO_ALIGN_TLB_ONLY
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20251022001741.222499-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251022001741.222499-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 22/10/25 02:17, Richard Henderson wrote:
> For Arm, we need 3 cases: (1) the alignment required when accessing
> Normal memory, (2) the alignment required when accessing Device memory,
> and (3) the atomicity of the access.
> 
> When we added TLB_CHECK_ALIGNED, we assumed that cases 2 and 3 were
> identical, and thus used memop_atomicity_bits for TLB_CHECK_ALIGNED.
> 
> This is incorrect for multiple reasons, including that the atomicity
> of the access is adjusted depending on whether or not we are executing
> within a serial context.
> 
> For Arm, what is true is that there is an underlying alignment
> requirement of the access, and for that access Normal memory
> will support unalignement.
> 
> Introduce MO_ALIGN_TLB_ONLY to indicate that the alignment
> specified in MO_AMASK only applies when the TLB entry has
> TLB_CHECK_ALIGNED set; otherwise no alignment required.
> 
> Introduce memop_tlb_alignment_bits with an additional bool
> argument that specifies whether TLB_CHECK_ALIGNED is set.
> All other usage of memop_alignment_bits assumes it is not.
> 
> Remove memop_atomicity_bits as unused; it didn't properly
> support MO_ATOM_SUBWORD anyway.
> 
> Update target/arm finalize_memop_atom to set MO_ALIGN_TLB_ONLY
> when strict alignment isn't otherwise required.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3171
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> PS: There are a number of uses of align_mem for AdvSIMD, SVE and SME.
> I have not re-familiarized myself with the effects of SCR.A and
> Normal/Device memory for those cases.  I may well have missed something.
> 
> ---
>   include/exec/memop.h            | 43 +++++++++++++++------------------
>   target/arm/tcg/translate.h      |  4 +--
>   accel/tcg/cputlb.c              | 13 +---------
>   target/arm/ptw.c                |  2 +-
>   target/arm/tcg/translate-a64.c  | 10 +++-----
>   target/arm/tcg/translate-neon.c |  2 +-
>   tcg/tcg.c                       | 10 +++++---
>   7 files changed, 35 insertions(+), 49 deletions(-)

To the best of my knowledge,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


