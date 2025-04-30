Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1A6C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 11:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA5Jd-0000CE-BH; Wed, 30 Apr 2025 07:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uA5Ja-0000Bw-VA
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 07:09:22 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uA5JZ-0007ZX-7D
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 07:09:22 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5499659e669so8375000e87.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 04:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746011359; x=1746616159; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VkF3T6djAJFPl7/wMmZmyu43UfQDPZD+NDGPuIMKIOc=;
 b=O/EwGR0PalH4kFMSgQKatAB5nv2+6CVjHed5TGWQ7e19NRd7+yvIYP1AUXJIPQnwgI
 Mvg6n+XpnL/c99a8P8d2z3hh2rUnFXxz++ovXnLCpH11F28GnVjh4sXi0Q3vNAclv2Dn
 PyGbeo3vQ5t4P99g2eW/gJCev4x5byaB8XxmJwFCDV4S/PJen29nQcH6leqjuCU4v0nf
 9luhq6zqfcnn0w8OW8gzzPoNO3398eD483mQ4PpBqyPMPVpLeKZLz66FLrUYUbDbCgfq
 aomDaszbsBZpWpddmQveCPmx/uHvEKv19DB/WZk80M3nDPpCCSHwTyHSMNIDxbBK5UrO
 Ccqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746011359; x=1746616159;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VkF3T6djAJFPl7/wMmZmyu43UfQDPZD+NDGPuIMKIOc=;
 b=owpiQm6SDfCDjX3NYpXd0RiM3cZVZJQKQ0LT3Arlg1GGAHyQn9Kz0gAjzRWMKxgNbH
 9WLxZslglQJaUD6ZNdO1dgZStTQ9tK5CGmiBgv/XunoxhkiU3Op2oqR3FLBJMK0O3Zpi
 NuoiOYB/GVLqIvuXivbmj6wtYYt0rUZyFVefxwpw4c+eHXZ/4qbqr/KSEhjqEsXcl0fM
 rI5tPt4uGJnQAPJOgQ7L0et+AqPzoaWBiNTiEnx4jEjW2u8+9t/o9zAjlcjQ64mbn0rq
 Acoz7aMK8vDCwOrV82KjhmDLhfZfSQwjJaWxp5xHKYJXFWePfJmQMOo8tcOfyujkbK1d
 kWbw==
X-Gm-Message-State: AOJu0YxhdnagrhQwiCefR0ILx9ks7M8O///7ZSIiBbboa6nJmpKI/bJt
 HpfA9xiGCLycQZ97Y2i5xR0N+FA+rnJ56x/NAZpPR7XAfo7sOUn3
X-Gm-Gg: ASbGnctIF5pP9Fe9aRZjif747iCp3u0f0B18wJ6EKBocvAhepeL54ghX6LC1OcMchCh
 DMyLdYSMKnYCtusDN7sj3QMMKJYo2AEk2ZHj2qunD1sWjs/FGjPCYD9eKtL4FVJSIc3MxJ0HHDc
 TPO85c5ADIcfKy4YBqe3uKPjWpCe3b3jwPl7ul7tPZ/qvaXFudSOESC9WzPkyLEeuTpkHul0LyR
 H6m4IU4LsW/sx1bSHanxKRKwgapasiIW/Bg3XqKji2JgUeQRlsw9svYEUZvsBIZ2f3wqrinSLfd
 zaKmKJWG0oozqdFM23FmhQmUo0vsnzU3ooOC6ClJVcZLd4Vrl7D4Dz6nr5x3RY8dF7K20Wuoryk
 mUTbhpLQORbSCemuROiK3W3w=
X-Google-Smtp-Source: AGHT+IGRSWqoVw+zJbRWXz+hbEWduSqak3uhEs81shaM7AvLf3bo7/8cAOWKvJP7Z3N80NjN5NlyBA==
X-Received: by 2002:a05:6512:398e:b0:549:5b54:2c68 with SMTP id
 2adb3069b0e04-54ea335dfffmr770535e87.22.1746011359124; 
 Wed, 30 Apr 2025 04:09:19 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54e908796ecsm1471693e87.122.2025.04.30.04.09.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 04:09:18 -0700 (PDT)
Date: Wed, 30 Apr 2025 13:09:18 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Subject: Re: [PATCH 0/9] target/microblaze: Always use TARGET_LONG_BITS == 32
Message-ID: <aBIE3j1lpNTvisKX@zapote>
References: <20250212220155.1147144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212220155.1147144-1-richard.henderson@linaro.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Feb 12, 2025 at 02:01:46PM -0800, Richard Henderson wrote:
> Use out-of-line helpers to implement extended address memory ops.
> With this, we can reduce TARGET_LONG_BITS to the more natural 32
> for this 32-bit cpu.


Series looks good to me:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> 
> 
> r~
> 
> 
> Richard Henderson (9):
>   target/microblaze: Split out mb_unaligned_access_internal
>   target/microblaze: Split out mb_transaction_failed_internal
>   target/microblaze: Implement extended address load/store out of line
>   target/microblaze: Use uint64_t for CPUMBState.ear
>   target/microblaze: Use TCGv_i64 for compute_ldst_addr_ea
>   target/microblaze: Fix printf format in mmu_translate
>   target/microblaze: Use TARGET_LONG_BITS == 32 for system mode
>   target/microblaze: Drop DisasContext.r0
>   target/microblaze: Simplify compute_ldst_addr_type{a,b}
> 
>  target/microblaze/cpu.h                  |   5 +-
>  target/microblaze/helper.h               |  16 ++-
>  target/microblaze/helper.c               |  25 ++--
>  target/microblaze/mmu.c                  |   3 +-
>  target/microblaze/op_helper.c            | 157 +++++++++++++++++++----
>  target/microblaze/translate.c            | 118 +++++++++--------
>  configs/targets/microblaze-softmmu.mak   |   4 +-
>  configs/targets/microblazeel-softmmu.mak |   4 +-
>  8 files changed, 228 insertions(+), 104 deletions(-)
> 
> -- 
> 2.43.0
> 

