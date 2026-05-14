Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBA0CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa0o-0000pL-II; Thu, 14 May 2026 13:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0h-0000oh-V4
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:13 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0S-0003n2-Ri
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:00 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-47c7b282e21so3350647b6e.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780273; x=1779385073; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7ttTmY+Y3SDG3Ojtzn4Gu/mUFzguXQtXKm6IX1ywtiQ=;
 b=MT6YIn1BYW3vgXUMRypbQgtQy3HMz0G/WvbLfVt8ROGIKQQfwy84NM7KyuyMf5+FXr
 6Xekqs4DgyRnODNidK2+q815bYIs4skyMZDZLB2aZDDDQFb2fX+ECpbdFPLgrjp2Qyn7
 bp9iB9idSFepqhboqwt6DjnZ5A0HzbchCvO+A6zhDlFOJA+i/c690NqvyDe/OawVxSKI
 qUW4fMCI8YHOzPSfHFqwOIH7trRZQEB9ozZBtpT6KZwaH/ks0WnIQnh9YZO7RXnNaiUg
 WwfSsSBA3PoxBJgLFhd4MRXZxFLm/HAcVfqBt6AfPESKtBimT+40sPd2IIag0tih2GC3
 po9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780273; x=1779385073;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ttTmY+Y3SDG3Ojtzn4Gu/mUFzguXQtXKm6IX1ywtiQ=;
 b=HkcQFBEY89HPwLV5yNllWFIZLlmbbgNe0g6Q0qe2xF+gE6qFbtAotPI+LG9PRfW8fc
 N3pt1nlsLdLr2ISR0maiS4QGFv3iIPNifTfQYpG/ilFmcnlrlH6TK9+YNgAud990yRp/
 AHSMzjn9rW1wM3cZkcNIZ4sSb8VXnxJhVEHVbX6Tguna7//JauDoJE+4DkNnTAsEZj6U
 llsOh96DPzU9cI7Btj32K2Nm7QCK/q1edyGLU+SVU/tVoKrZ5MgLaWdSXT/lbOU6zzaj
 uKhtSSalojOxe5Mlfq3ZuaY8CAoAzxgqKZsikq4SexI5vvC9IybfgOGRLiE+IAhZehOd
 hMWg==
X-Gm-Message-State: AOJu0Yxgvsbes8XfC3lcq0nApvqLsjKS8stC3XCTBih5fwokPUngiOlU
 c0UCqVjUwiJNZcAZQFzvtNKxGhI/jdbnLZhC1uGjfHWnR0DH3o0LMuC+
X-Gm-Gg: Acq92OHGjDLeWgYBFoLYkCT0EnmgvxZjkD1sl82lSAqOz/ztLAw1JXpQwv0rEU8ph4R
 sy6iFD9u6IVdsUkM4h334KNi9zFRIthUY0IYzQRdwLS6IedqQOsLRWcICVTGPgzBLALF1Iu4Ge1
 UDxH5Mz2oqFvRKsiIXuJBS/qdpIPf7z40OgyMYpPt9ZI9o85SFyTOnmBkiXL997cNTWG18eJGxp
 mNdubkHjNu6dmWgOsnovJ5dJVyS3eY8+2jtH8i+ihzxxDSZzQ8a7ufpoLtWiUCZaP4kR7NLZN1n
 Nw6/5VArDfcOG0mPQS91Q9c4o7etLuZe+VdPyi60uBnxnVLSD3AtxU6fVlOjMQZ3H4p1CjSxtE1
 xbpYWzTMZv1q4jFZrUUXsOeJCwzNeSjZpZi2y1zfxe1ud/xqQGFLbjh9Lc4hyMjC2ckR1iMK/f9
 d3lGfR+6Xyn+iHfp/AG+XGsOPxf0DP9sZJDMSiAMeToYxOa3U9mmI89oA81EXo6JXVaVoTCNMRt
 f+WcBlYIBVbIrqJdrNJgIGpoquZi2psdHYNTr9IzpfTaa0s5+8MpgWdFCNii5qKfsw/FRTn59Rt
 YiI=
X-Received: by 2002:a05:6820:8188:b0:696:9364:c284 with SMTP id
 006d021491bc7-69c9c02054emr240992eaf.44.1778780272758; 
 Thu, 14 May 2026 10:37:52 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:37:52 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v7 00/35] target/mips: add missing Octeon user-mode support
Date: Thu, 14 May 2026 11:36:49 -0600
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XQwWrEIBAG4FdZPNeiJo66p75H2UMymqyl0SVmp
 WXJu1e3lIYtNDCH+WH4fpgbSW72LpHj4UZml33yMZSgng4Ez10YHfW2ZCKYANYKRid/STTi4mI
 oe0o+jNSHFBLNgkoHplGK4SCQFOIyu8F/3PnX03dO1/7N4VLNenH2aYnz570/i3r3U8X/ryrDa
 MeU4XbgWqN5GafOvz9jnEitys0vJpnewZqC9dg7NNBIZf9g7RYzO1hbMAtgLFomUQyPmNxgfOe
 jWVZMWgGgLZdd/4jBFtv7GRRMMhBaG2xtg1tsXdcvYv7IfA4CAAA=
X-Change-ID: 20260420-mips-octeon-missing-insns-v2-5e693770cf2c
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x232.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This series updates MIPS linux-user unaligned-access behavior and fills
in missing Octeon user-mode instruction support used by existing Octeon
binaries.

The first patches model the Linux/MIPS sysmips ABI pieces needed by
linux-user, including MIPS_FLUSH_CACHE, MIPS_ATOMIC_SET, and the
MIPS_FIXADE policy used to control unaligned scalar access fixups.
User-mode unaligned scalar accesses default to software fixups and
sysmips(MIPS_FIXADE) can toggle SIGBUS/BUS_ADRALN behavior.

The Octeon patches add integer, indexed memory, atomic, fixed-point
QMAC, multiplier, COP2 crypto, CHORD, LLM, and CvmCount RDHWR support.
The series also adds a small mips64/mips64el TCG guest test covering
representative Octeon integer, fixed-point, multiplier, RDHWR, and COP2
selector paths. The final patch corrects the Octeon68XX CP1 feature
bits and FCR defaults.

Changes since v1:
- Split BADDU/DMUL destination fixes into a separate patch.
- Split the SEQ/SNE decode refactoring into a separate patch.
- Moved Octeon multiplier state to uint64_t arrays and updated VMState.
- Switched Octeon helper ABIs to i64/uint64_t where applicable.
- Moved COP2 selector decode/support logic into octeon_translate.c.
- Added in-tree TCG tests for mips64 and mips64el linux-user.
- Used switch ranges and g_assert_not_reached() for SHA3/ZUC shared
  selector handling.
- Dropped Octeon prefixes from generic Camellia helper routines.
- Replaced the reflected GFM 64-bit carryless multiply loop with
  crypto/clmul.h.
- Moved the Octeon68XX CP1 CPU-model correction to the end of the
  series.
- Added migration coverage for Octeon COP2 crypto and LLM sparse state.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v7:
- Rebased on current qemu.git staging (edcc429e9e).
- Reordered the zero-register cleanup after the BADDU/DMUL destination fix
  and moved the multiplier-state patch next to the MTM/MTP instruction
  patches.
- Applied Philippe's MIPS_FIXADE TB-flag readability tweak.
- Used explicit MO_32/MO_64 MemOps for SAA/SAAD atomic transaction sizes.
- Folded ZCB/ZCBT decode with a decodetree wildcard and zero the cache
  block with 128-bit stores.
- Added new Reviewed-by tags from Philippe Mathieu-Daudé and Richard
  Henderson.
- Link to v6: https://lore.kernel.org/qemu-devel/20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com

Changes in v6:
- Added Octeon QMAC/QMACS fixed-point accumulator support and smoke
  coverage.
- Added Octeon RDHWR $31/CvmCount support and smoke coverage.
- Clarified MTM0/VMM0 deterministic handling of architecturally
  unpredictable multiplier lanes.
- Fixed MTP0 to zero P1 per the CN71XX register-state table and added
  smoke coverage.
- Fixed VMM0 to apply the full MTM0-style multiplier-state reset and
  added smoke coverage for MPL1.
- Cleaned up internal VMUL, LA*, COP2 payload/state, and COP2 selector
  naming to better match hardware register/selector terminology.
- Renamed the MIPS_FIXADE TB flag, HSH register word-packing helpers,
  and sparse LLM backing fields to match ABI and hardware terminology.
- Link to v5: https://lore.kernel.org/qemu-devel/20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com

Changes in v5:
- Added Richard Henderson's Reviewed-by tags for LBX, LHUX, LWUX, SAA,
  and SAAD, plus Acked-by tags for ZCB and ZCBT.
- Dropped the separate Octeon+ feature bit; QEMU has a single Octeon CPU
  model today, so SAA/SAAD stay under the existing Octeon feature bucket.
- Folded ZCBT into the ZCB decodetree entry with a selector comment.
- Link to v4: https://lore.kernel.org/qemu-devel/20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com

Changes in v4:
- Added Richard Henderson's Reviewed-by tags to the reviewed sysmips and
  Octeon translator cleanup patches.
- Kept the Octeon3 MPL3-MPL5/P3-P5 high-lane multiplier state
  documented by Cavium SDK/toolchain sources.
- Documented the Octeon3 two-source MTM/MTP forms and preserved the rt
  high-lane operands while legacy one-source encodings use rt == $zero.
- Simplified SAA/SAAD translation to use the i64 TCG atomic add path for
  both word and doubleword sizes.
- Marked SAA/SAAD as Octeon+ instructions and gated them behind a
  separate Octeon+ feature bit.
- Simplified LA* translation to use i64 TCG atomic helpers for word and
  doubleword operations, with MO_SL selecting word result sign-extension.
- Link to v3: https://lore.kernel.org/qemu-devel/20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com

Changes in v3:
- Rebased on current qemu.git master.
- Split sysmips support into separate MIPS_FLUSH_CACHE, MIPS_ATOMIC_SET,
  and MIPS_FIXADE patches.
- Made MIPS_ATOMIC_SET always use the MIPS separate error-result register
  path for successful returns.
- Removed redundant Octeon MIPS64 checks and target-long guards from the
  translator paths.
- Removed zero-register fast paths where gen_store_gpr() already handles
  discarded writes.
- Reworked SEQ/SNE decode and LA* translator helpers as requested.
- Split the Octeon arithmetic/memory patch into narrower state, indexed
  load, SAA/SAAD, ZCB, multiplier, and test patches.
- Switched Octeon multiplier limb accumulation to uadd64_overflow().
- Link to v2: https://lore.kernel.org/qemu-devel/20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com

To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Helge Deller <deller@gmx.de>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Rikalo <arikalo@gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>

---
James Hilliard (35):
      linux-user/mips: implement sysmips(MIPS_FLUSH_CACHE)
      linux-user/mips: implement sysmips(MIPS_ATOMIC_SET)
      linux-user/mips, target/mips: honor MIPS_FIXADE for unaligned accesses
      target/mips: fix Octeon arithmetic destination handling
      target/mips: drop Octeon zero-register fast paths
      target/mips: split Octeon SEQ/SNE decode
      target/mips: add Octeon LBX instruction
      target/mips: add Octeon LHUX instruction
      target/mips: add Octeon LWUX instruction
      target/mips: add Octeon SAA instruction
      target/mips: add Octeon SAAD instruction
      target/mips: add Octeon ZCB instruction
      target/mips: add Octeon ZCBT instruction
      target/mips: add Octeon multiplier state
      target/mips: add Octeon MTM0 instruction
      target/mips: add Octeon MTP0 instruction
      target/mips: add Octeon MTP1 instruction
      target/mips: add Octeon MTP2 instruction
      target/mips: add Octeon MTM1 instruction
      target/mips: add Octeon MTM2 instruction
      target/mips: add Octeon VMULU instruction
      target/mips: add Octeon VMM0 instruction
      target/mips: add Octeon V3MULU instruction
      target/mips: add Octeon QMAC instructions
      tests/tcg/mips: add Octeon instruction smoke test
      target/mips: add Octeon LA* atomic instructions
      target/mips: add Octeon COP2 crypto core support
      target/mips: add Octeon SMS4 crypto support
      target/mips: add Octeon SHA3 crypto support
      target/mips: add Octeon ZUC crypto support
      target/mips: add Octeon Camellia crypto support
      target/mips: add Octeon CHORD and LLM COP2 support
      target/mips: add Octeon CvmCount RDHWR support
      tests/tcg/mips: cover Octeon QMAC and CvmCount
      target/mips: expose Octeon68XX floating-point support

 MAINTAINERS                                   |    2 +
 linux-user/mips/cpu_loop.c                    |    5 +
 linux-user/mips/target_syscall.h              |    3 +
 linux-user/mips64/target_syscall.h            |    3 +
 linux-user/syscall.c                          |   56 +
 target/mips/cpu-defs.c.inc                    |   10 +-
 target/mips/cpu.c                             |   77 +-
 target/mips/cpu.h                             |  257 +++
 target/mips/helper.h                          |    9 +
 target/mips/internal.h                        |    3 +
 target/mips/system/machine.c                  |  142 ++
 target/mips/tcg/meson.build                   |    1 +
 target/mips/tcg/octeon.decode                 |   50 +-
 target/mips/tcg/octeon_crypto.c               | 2479 +++++++++++++++++++++++++
 target/mips/tcg/octeon_translate.c            |  573 +++++-
 target/mips/tcg/op_helper.c                   |  176 +-
 target/mips/tcg/translate.c                   |   34 +-
 target/mips/tcg/translate.h                   |    1 +
 tests/tcg/mips/Makefile.target                |   11 +
 tests/tcg/mips/user/isa/octeon/octeon-insns.c |  332 ++++
 tests/tcg/mips64/Makefile.target              |   20 +
 tests/tcg/mips64el/Makefile.target            |    8 +
 22 files changed, 4193 insertions(+), 59 deletions(-)
---
base-commit: edcc429e9e41a8e0e415dcdab6aa52ad17ef8889
change-id: 20260420-mips-octeon-missing-insns-v2-5e693770cf2c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>


