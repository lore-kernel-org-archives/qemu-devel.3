Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E0CFF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDKz-0008M0-DY; Wed, 29 Apr 2026 18:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDKx-0008Kc-O8
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:24:55 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDKv-0004To-HK
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:24:55 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-35da2d35eccso152379a91.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501491; x=1778106291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o8KNNbH4HUhnxEIySslVAOm/X6PsNiD+gAsa0++cdF8=;
 b=MGIJpPWtWmKYgik3fTit/FvVPG3MDPpdVWhlBpeJIn21yTeDZW+ihaGh1RAW4Mk/BY
 S2G7Yh3K954Tq3QQ5KoD8dRFq9GfU6kKjB6AoVc5qihvF+3/kFzpwPJih4O9G8pPA2rM
 UnosAH3J6c008b9INjTtFLH0cXHwvs3cy7Ul+i60mVIlgNTAs1Zr9b3YruoqomFB82/r
 96AbsELkmcvLu6dJ3WAcJIbNJ9LMQRLnSEJJ2vma7jD5dqq3kS+RoSt4ndmf73lUQaQ/
 XO+LuNrMSzPsx897lvQal25t0wq2ozdrt0fgRqdFlxNuHFvtrJSSGsPp7z3uAZEl3/vk
 9Igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501491; x=1778106291;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o8KNNbH4HUhnxEIySslVAOm/X6PsNiD+gAsa0++cdF8=;
 b=GynYOyda6ma/wiDPNua8OnY7EMD8mBDnXPabYAWNJGXL+jMdooXdl/t9p/r3jDVIMM
 FPjbQr7MqYiKVElOJ/Y/0V+TalI/j/EnuuqEEgBH3KMFWrQoMuiaUJOfi0xCZ/vPfE/i
 JT9dvyLEd1W/YglDHdcGYuLQzNu7n0LvTGvdVjQNrj38UkAvkSk0eoFHXbBgzSACWRyG
 lP1otTgtIEvJqEwJAZPzbxNSNdasKUNdJWyvsQaVNeK4fT87METVSWHWbQYMWVyAl7ba
 2of8/ISlphZ7xAWUKtKtlQ0D4SXnlM2C+aLX+KPdQXM1WjeFgMAcd3DXiN9fCDibQMq6
 xQwA==
X-Gm-Message-State: AOJu0Yyr6EaaYVCSdNkF60hB5Kl+AJZOIzJr1dZwhVkCaleZ7DoVSsh4
 SeVypHzyvRjNcTA1qTyeUhdlVa9V0UckiBlD6Z7j5tzgzdzK9JaXh0vdPInoN5zzwE2UorjC7Yf
 12TXn2S8=
X-Gm-Gg: AeBDiet2QuWXb/VqkC4kPg335SqIlThUFVH+W9XPWlRBgUM86pbxBcbNbacZQseW2g0
 nXkYm3bNjkjfM8ZZeviMwRhf3kj+tqNNWO5n4J8AX+eV+v7DbFH/IEFB2vj1UVa79tCSUX8lMMt
 +fcSaK+G/8Y1b7xAQQqk//0NqVunPmk4SR6NPFLWreLlx4PoN/R7aI80GNUmll1MZpbHOix8J17
 KN4vSs3N7PUB0T9OzGciXCHZSw7ughMfw3s40s077/xGsvoFRiePYjL9r6t0a/KsOExVhE5iMad
 zuB76FDe8e4UQH/gJTpaglf90gYBysMEt8tiM95fLrLIPweCXdSe9lcDs+7CgUeJBDnVzNea3IT
 2TNWZakaqIuwyFZ7eYTXRSBG+Q3N7WUsgH/KN/gGcO9w3sxrXnDD1i2ffPJlzhwecz94M3ImKAe
 bhtj1PK+7vOPXHYB0eZKMQCqJbBdLzaYb/lPN2+WdY
X-Received: by 2002:a17:90a:dfc5:b0:364:78a5:8d39 with SMTP id
 98e67ed59e1d1-364c30cf1ddmr159914a91.20.1777501491516; 
 Wed, 29 Apr 2026 15:24:51 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:24:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 00/48] fpu patch queue
Date: Thu, 30 Apr 2026 08:23:57 +1000
Message-ID: <20260429222445.26301-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

The following changes since commit 282771e1f9b9b6e0147adf5f9d676325175b1767:

  Merge tag 'pull-riscv-to-apply-20260429-1' of https://github.com/alistair23/qemu into staging (2026-04-29 09:22:51 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-fpu-20260430

for you to fetch changes up to df540b566ebb97a24c2880397ad277f12f8f4b31:

  fpu: Change parts_float_to_float_widen to parts64_to_parts128 (2026-04-30 08:10:05 +1000)

----------------------------------------------------------------
fpu: Drop PARTS_GENERIC_64_128{_256}
fpu: Drop FRAC_GENERIC_64_128{_256}
fpu: Constify frac{64,128,256}_* inputs
fpu: Return struct from *_unpack_canonical
fpu: Inline some *_unpack_raw into only caller
fpu: Change parts_float_to_float_narrow to parts128_to_parts64
fpu: Change parts_float_to_float_widen to parts64_to_parts128

----------------------------------------------------------------
Richard Henderson (48):
      fpu: Drop parts_canonicalize
      fpu: Drop parts_uncanon
      fpu: Drop parts_uncanon_normal
      fpu: Drop parts_default_nan
      fpu: Drop parts_silence_nan
      fpu: Drop parts_return_nan
      fpu: Drop parts_pick_nan
      fpu: Drop parts_pick_nan_muladd
      fpu: Reverse the order of softfloat-parts* inclusions
      fpu: Drop parts_{add,sub}_normal
      fpu: Drop parts_addsub
      fpu: Drop parts_mul
      fpu: Drop parts_muladd_scalbn
      fpu: Drop parts_div
      fpu: Drop parts_modrem
      fpu: Drop parts_sqrt
      fpu: Drop parts_round_to_int_normal
      fpu: Drop parts_round_to_int
      fpu: Drop parts_float_to_sint
      fpu: Drop parts_float_to_uint
      fpu: Drop parts_float_to_sint_modulo
      fpu: Drop parts_sint_to_float
      fpu: Drop parts_uint_to_float
      fpu: Drop parts_minmax
      fpu: Drop parts_compare
      fpu: Drop parts_scalbn
      fpu: Drop parts_log2
      fpu: Drop parts_float_to_float
      fpu: Drop PARTS_GENERIC_64_128{_256}
      fpu: Drop FRAC_GENERIC_64_128{_256}
      fpu: Constify frac{64,128,256}_* inputs
      fpu: Return structure from unpack_raw64
      fpu: Return struct from float4_e2m1_unpack_canonical
      fpu: Return struct from float8_e4m3_unpack_canonical
      fpu: Return struct from float8_e5m2_unpack_canonical
      fpu: Inline float16_unpack_raw into callers
      fpu: Return struct from float16a_unpack_canonical
      fpu: Return struct from float16_unpack_canonical
      fpu: Inline bfloat16_unpack_raw into callers
      fpu: Return struct from bfloat16_unpack_canonical
      fpu: Inline float32_unpack_raw into callers
      fpu: Inline float64_unpack_raw into callers
      fpu: Return struct from float{32,64}_unpack_canonical
      fpu: Inline floatx80_unpack_raw into only caller
      fpu: Return struct from float128_unpack_raw
      fpu: Return struct from float128_unpack_canonical
      fpu: Change parts_float_to_float_narrow to parts128_to_parts64
      fpu: Change parts_float_to_float_widen to parts64_to_parts128

 fpu/softfloat.c                  | 1654 ++++++++++++++++----------------------
 fpu/softfloat-parts-addsub.c.inc |   22 +-
 fpu/softfloat-parts.c.inc        |  376 ++-------
 3 files changed, 776 insertions(+), 1276 deletions(-)

