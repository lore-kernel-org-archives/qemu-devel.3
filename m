Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741BAFF8864
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzio-0006t7-VG; Sun, 26 Apr 2026 09:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGziY-0006jw-Ld
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:16 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGziW-0008Ea-2b
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:14 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c76bde70ec9so3669682a12.2
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210810; x=1777815610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FXTxN+J9no8re62AJqbCq+vPW8iZVDA6DVJLTKCpZGc=;
 b=tRCQsfbS0T3S9vl1A1O8WlKbxySfx71IrQ47MDALW/4Z5dIz4xwbmg2d+VI/UvvOdF
 nQGR/V6t1jGEyKfHe3FsSDxu8TtC6hMq3sOYXAAFNRqAC3yt3HRiUnMTmmOmtBfYKK/0
 6HzXWWigYO+LPRkG2pZA/ZxfbCaffF9EQsNUueiDW5ce3FxR/iyhgT77SiAEWKdV+a5R
 qtLxI1jifOHEerXW3Q3P0XMZkgeBDrjxeSbQzenwcYRuBtedY9zJVMLFF8yGfl2FJlDM
 614eCoruSPCB8JnMjSy/knqdfZs8BdnWSNhkFFKbcw2X8dfvAbCgioa79w6UYJvcm81b
 WXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210810; x=1777815610;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FXTxN+J9no8re62AJqbCq+vPW8iZVDA6DVJLTKCpZGc=;
 b=OlyurRrPoM7AwtuQLCZjny2WlzkRCjEDGRxclcpNe8tRA0jEXJ9oOY2P29OiB31RXy
 2lyazY0jy6ZIIeqUBQWkGva9dlGFOmy44AUz1NMJT2Bxjw23/sBm2xfFNIlOankHnlSR
 HbFSqq96KybiEL0+X51wxhnre7acBoKRfl9av1GcYIS1Q58ZFoQGy1i+7lkP55434OrM
 RpdrFaPGWLVQApgyZ5ULgEOUpf0USEwsbagCSQBzcqeFblkaCquZCIHKcVRx9EAKl+mB
 UTyrp94OCxlQvv4cguVmIjJq1qonToMm8R+B8IWFp4qhZcyFiWNiDzCi8OLq0S3PlSDe
 8Hsg==
X-Gm-Message-State: AOJu0Yw8il5hEqlwx7oMb3z98btDIXB9BHJ5AADM//Q1TxdTvrg5/eeN
 XMi8oviqccpfLYMu105/l4vFMNGSFO5EzzWZMB39rYOhZk3bZgpB53itw1hbX9BpwIRuFQbH8S0
 rsKf+WyQ=
X-Gm-Gg: AeBDiespRj/x0J9+AzJ6y3AN30qdOoKYN/fpoPL2RbN939wsJkqIUViESh9lvPT7+UP
 iTNi+INm7TmSNdxLxerOA3UcdVF5guzjX3Vhde/lq33EMZXad0rQOb6ja4dHs2ilmWvBC1FjCEq
 Kfr8RdF7+8HPzbx8F4qN52yirLzXzk8seD+aurrLXyfnHb0JjV/ckA3K4MIO7m7SDWISiUwxBo3
 PLCrdsJybD8dmDAK3qvPtCrvQ7DbzUKdlZfGodqEuVSfX7jBEjHsOORmZ6ztNh4Iz9HCnHnezQW
 Q5E+3+AEKPw6HOnu/paVKwWjk+5JVZ1Jjdd6QXggw9v6yMWjV5F2B7HvZM3Z6xdgJxH99LMX0kr
 ORKo2pBNzC/DEFixZu0DACxHEsuAYbJbay+INKc0H/lM+Ka9dpizapd+lmNOOin2NgjfiIQC9yU
 ngB4iQdIDudhAc0UVe+BRDGyjbXTaENRP/VZuQRDEb
X-Received: by 2002:a17:902:f545:b0:2b4:61cc:37a8 with SMTP id
 d9443c01a7336-2b5f9eceb9amr429362575ad.17.1777210808276; 
 Sun, 26 Apr 2026 06:40:08 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.40.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:40:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [RFC PATCH 00/84] fpu: Export some internals for targets
Date: Sun, 26 Apr 2026 23:38:37 +1000
Message-ID: <20260426134002.865628-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Expose enough softfloat infrastructure so that we can move the
s390_divide_to_integer code back into target/s390x/, and to
perform the Arm FPDotAdd operation without using either float64
intermediates and round-to-odd.

The motivation is the Arm FP8DotAdd operation, which has up to
8 multiplies, 9 additions, and 1 scaling operation before rounding.

Rather than export the code as-is, with functions that sometimes
(but not always) return a pointer to one of the inputs, and may
or may not modify one or all of them as scratch space, return a
new structure instead.

This turns out to improve code as well, because we compile with
-ftrivial-auto-var-init=zero.  A pattern such as

    FloatParts t;
    foo(&t, ...);

will zero t before calling foo, whereas

    FloatParts t = foo(...);

will not.

I have not converted everything, only enough to do the testing
of the target/ patches at the end.  Comments?


r~


Richard Henderson (84):
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
  fpu: Inline float8_e4m3_pack_raw to single caller
  fpu: Inline float8_e5m2_pack_raw into single caller
  fpu: Inline float16_pack_raw into callers
  fpu: Inline bfloat16_pack_raw into callers
  fpu: Inline float32_pack_raw into callers
  fpu: Inline float64_pack_raw into callers
  fpu: Mark unpack_raw64 QEMU_ALWAYS_INLINE
  fpu: Mark pack_raw64 QEMU_ALWAYS_INLINE
  fpu: Split FloatParts{64,128} to softfloat-parts.h
  fpu: Export FloatFmt structures
  fpu: Export unpack_canonical and round_pack_canonical routines
  fpu: Return struct from parts{64,128}_default_nan
  fpu: Return struct from parts{64,128}_silence_nan
  fpu: Return struct from parts{64,128}_return_nan
  fpu: Sink exp_bias adjustment in float64r32_pack_raw
  fpu: Return struct from parts{64,128}_pick_nan
  fpu: Return struct from parts{64,128}_div
  fpu: Return struct from parts{64,128}_round_to_int
  fpu: Use parts64_round_to_int in parts_s390_divide_to_integer
  fpu: Export default_nan and pick_nan routines
  fpu: Introduce parts64_round_canonical
  fpu: Export parts{64,128}_div
  fpu: Export parts{64,128}_round_to_int
  fpu: Return struct from parts{64,128}_pick_nan_muladd
  fpu: Introduce record_denormals_used
  fpu: Return struct from parts{64,128}_muladd_scalbn
  fpu: Drop QEMU_FLATTEN from muladd routines
  fpu: Export parts{64,128}_compare
  fpu: Return struct from parts{64,128}_mul
  fpu: Hoist nan check in partsN_addsub
  fpu: Return struct from parts{64,128}_addsub
  fpu: Simplify 0 +/- N case in parts_addsub
  target/s390x: Move float{32,64}_s390_divide_to_integer
  target/arm: Use FloatParts64 in bfdotadd_ebf
  target/arm: Drop oddstatus from is_ebf and bfdotadd_ebf
  target/arm: Use FloatParts64 in f16_dotadd

 include/fpu/softfloat-parts.h    |  223 ++++
 include/fpu/softfloat.h          |   11 -
 target/arm/tcg/vec_internal.h    |   12 +-
 fpu/softfloat.c                  | 2124 +++++++++++-------------------
 target/arm/tcg/sme_helper.c      |  102 +-
 target/arm/tcg/vec_helper.c      |  127 +-
 target/s390x/tcg/fpu_helper.c    |  135 ++
 fpu/softfloat-parts-addsub.c.inc |   22 +-
 fpu/softfloat-parts.c.inc        |  723 ++++------
 fpu/softfloat-specialize.c.inc   |   42 +-
 10 files changed, 1529 insertions(+), 1992 deletions(-)
 create mode 100644 include/fpu/softfloat-parts.h

-- 
2.43.0


