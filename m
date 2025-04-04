Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8358BC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 23:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0qmG-0008FM-Pg; Fri, 04 Apr 2025 19:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0qmF-0008FD-Eu
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 19:48:47 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0qmD-0007fL-Fg
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 19:48:47 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso1934922f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 16:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743810523; x=1744415323; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z5Gfb9kc+yhQghP0WWjULJ+Vj02i4BuHgZhJg4h0t44=;
 b=bt6KM4NaKZSzvCQJLT/SxF7bBJRzKkRl/tzuoi913D63zlmLhphR/xUJb794Guh3px
 fpIrl+BKlJUQ54SvtyEsUrjd6Pk30LchmsAPSEwUVeCYp2/EEgkFvOpVjzU+qdkJwr/c
 hYW5bwdIkTYzcBWy0ZCzmle2cu5PMXznWEt65ceiNbUO9vVtM9iH9cBU75HccR56/5Sx
 d4sGh73LwB6zIgMTPIshWMZtd4jUXZEfmpydWS1esTbSeJcTogxcPslZ5p4MrD6doMg+
 8w0Q49dpQWiTzPSjRUtRDOCWHUsO14BDstFQDkaMeGanPifIS/wLvyQ5bC4O1YORNJfE
 6CRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743810523; x=1744415323;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z5Gfb9kc+yhQghP0WWjULJ+Vj02i4BuHgZhJg4h0t44=;
 b=ToWA9eDsv3YzgFsPeKknvhmgMKNThke/PBtuQmDLDn+9TkJRVFELc2+YFW1rSx9FAq
 YrtIW4et0lmOAl4v1gA7ugmrJR74l+Y7i7PkQ3po6IjbsaSD6AbDjdRbW+auIiA5Y6cU
 RJDxEYG/wvvU/FdoWQ2DxmToyB4XYaTvyEdRPTYqbdPCwBnM7VmZ1o4PXj5zBqSmKlvk
 11yywkDfKWcwBXjjIQvBwD6bImSjZXwy/oRGqkzd9JzBwxojQufhjW5H8akmiBSmqeCp
 QsmnAQfiG/8oL455AfqPS9oI+DRItbsdn4OujV5uNyYfGgP9QmSX/uMi41aoPjJoWSXs
 bOqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8o+wJlFE4HsCP7oaiZi9uM3vca4sVfWtj95ygQbLvPhzfWQMxpuB/g93AktlCDVRjtWl6uZtrC5EG@nongnu.org
X-Gm-Message-State: AOJu0YzM6ViAB/rKVR0PbfYqn2O7Ku0Ssp0e+qrvrGeMhoPYpwzZiAuG
 VdK1teUTgnIuwH7bqMjNAxat4JJ2ZKElMJhg/pSWnrQlKCDw/aTDC82WnZX38JY=
X-Gm-Gg: ASbGnctzINMi/4vMNtYnVVW27RFZgj1v+Y4VlHJ1gCu6C5nLV0sth+8FsDZ23jHQOD2
 ElBCZEkc3pp03xfhd9N/dLoWC0fPUDedWnfo6V1fdUYg5wGoucplCV/3jzOBJUmFSZWsmFJ6iFq
 ekfntrSc/pTBYNQAFTWN1NqKxyonaOeC7HrUcuOSINSCUgH1GDJ3apIytTYb41ojkHjSEQJAW5p
 CeejhccGj43qrqnmLyxGF6eyUhPEwM4gfmN5l7iZxZ+58mSn01MF9jEG9qV0X2IPdH2eAM/ZK5v
 syA6qEikUxhSOgVp7S52g2DRJ/jh64S0PIHRDDxUi41B2horq1NtGgn3O0MpxGRZx9mnqWH5l78
 amd+dW5XOLlHDZ2dV0Q==
X-Google-Smtp-Source: AGHT+IEbuiCTrKzWSCQCunH69102MBK2CKTjiA44CD2XalNOZy2PnczpjMdDwhMoQvJxL/IbRYm/bg==
X-Received: by 2002:a5d:584c:0:b0:391:ab2:9e71 with SMTP id
 ffacd0b85a97d-39d6fc29654mr784904f8f.20.1743810522885; 
 Fri, 04 Apr 2025 16:48:42 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301ba2dfsm5516899f8f.60.2025.04.04.16.48.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 16:48:41 -0700 (PDT)
Message-ID: <99187f31-f55d-4c39-bd9c-13dbbef321dc@linaro.org>
Date: Sat, 5 Apr 2025 01:48:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v3 14/19] tcg: Remove the TCG_GUEST_DEFAULT_MO
 definition globally
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250403220420.78937-1-philmd@linaro.org>
 <20250403220420.78937-15-philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20250403220420.78937-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Hi Richard,

On 4/4/25 00:04, Philippe Mathieu-Daudé wrote:
> By directly using TCGCPUOps::guest_default_memory_order,
> we don't need the TCG_GUEST_DEFAULT_MO definition anymore.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   docs/devel/multi-thread-tcg.rst |  4 ++--
>   target/alpha/cpu-param.h        |  3 ---
>   target/arm/cpu-param.h          |  3 ---
>   target/avr/cpu-param.h          |  2 --
>   target/hexagon/cpu-param.h      |  3 ---
>   target/hppa/cpu-param.h         |  8 --------
>   target/i386/cpu-param.h         |  3 ---
>   target/loongarch/cpu-param.h    |  2 --
>   target/m68k/cpu-param.h         |  3 ---
>   target/microblaze/cpu-param.h   |  3 ---
>   target/mips/cpu-param.h         |  2 --
>   target/openrisc/cpu-param.h     |  2 --
>   target/ppc/cpu-param.h          |  2 --
>   target/riscv/cpu-param.h        |  2 --
>   target/rx/cpu-param.h           |  3 ---
>   target/s390x/cpu-param.h        |  6 ------
>   target/sh4/cpu-param.h          |  3 ---
>   target/sparc/cpu-param.h        | 23 -----------------------
>   target/tricore/cpu-param.h      |  3 ---
>   target/xtensa/cpu-param.h       |  3 ---
>   target/alpha/cpu.c              |  3 ++-
>   target/arm/cpu.c                |  3 ++-
>   target/arm/tcg/cpu-v7m.c        |  3 ++-
>   target/avr/cpu.c                |  2 +-
>   target/hexagon/cpu.c            |  3 ++-
>   target/hppa/cpu.c               |  8 +++++++-
>   target/i386/tcg/tcg-cpu.c       |  5 ++++-
>   target/loongarch/cpu.c          |  2 +-
>   target/m68k/cpu.c               |  3 ++-
>   target/microblaze/cpu.c         |  3 ++-
>   target/mips/cpu.c               |  2 +-
>   target/openrisc/cpu.c           |  2 +-
>   target/ppc/cpu_init.c           |  2 +-
>   target/riscv/tcg/tcg-cpu.c      |  2 +-
>   target/rx/cpu.c                 |  3 ++-
>   target/s390x/cpu.c              |  6 +++++-
>   target/sh4/cpu.c                |  3 ++-
>   target/sparc/cpu.c              | 23 ++++++++++++++++++++++-
>   target/tricore/cpu.c            |  3 ++-
>   target/xtensa/cpu.c             |  3 ++-
>   40 files changed, 66 insertions(+), 101 deletions(-)

I forgot this:

-- >8 --
diff --git a/include/exec/poison.h b/include/exec/poison.h
index bc422719d80..413dfd16f24 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -38,3 +38,2 @@
  #pragma GCC poison TARGET_BIG_ENDIAN
-#pragma GCC poison TCG_GUEST_DEFAULT_MO
  #pragma GCC poison TARGET_HAS_PRECISE_SMC

---

Could you squash it in your tcg-next tree?

Thanks,

Phil.

