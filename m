Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882D5CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 22:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL724-0000nU-Ta; Thu, 07 May 2026 18:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL723-0000n0-4o
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:23 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL721-00039A-Fg
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:22 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6969c864c89so817715eaf.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 15:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778192239; x=1778797039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=bGJYgNeu1anXrD/MtzlPsaaWw8rm7D4vC/8kOQ+IqjU=;
 b=mYZkAjENS80fKUje2yKdeuR2SxDPjmxCMz30pKDGZvo9bG8H8BYkYyGW6nMQBchKuQ
 IY9u8mNko/LkQopf8q8x1oVu+SqK8QkG4m9bzkHuclgzvumgpjp075Z76Vaq1c1ytqM+
 C/JqsBprnBec2sQd09GWbdBYBoqWGzrnG22OgnX+VtB+IUM0TXklEGSUzxcd7WdG//fz
 ohauTjMCnNuYkNqOwFyQY71dJzmVDI1q0nX65iTWTkZBIXYGBIZbpG/kIzDz1U2hxaha
 sVR42Z0usVXbvA9KYFVQjkBuSoRnDuMaOPVhJI7mKi3n1tqDCM5V5RLbZlylokaqMaJG
 RhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778192239; x=1778797039;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bGJYgNeu1anXrD/MtzlPsaaWw8rm7D4vC/8kOQ+IqjU=;
 b=rl0kjHH9O3O8/erLa9Ufs82eUHidZzas+sXoZVDNuFjSO9KKAcO1/tzOLn1QlZJzCd
 t8AyIXqGKeLeQGmEY3/LSgFHsTpUmxJfHNFPFWYVELvQARCsBusnJCGZwjT0/f/NWQBS
 HBM9EEe/lSFodBXgqCyAGgnDOzGgm7l1hdLCAaca4OsLJAQELBaO81Q1xvoIpJ3axliJ
 ipJaCKX3zG2s/X0cDn2WMWF9HsZK8J8+4BtXLwzNsNA87Bc67dnR03no77kH1UsE2PJw
 vPXiLOHriGIRUW/CZ27vJ3N5xwwXGeAzmNve56THf5GihETW7S07tNO1cd5JD/i6lsEj
 CR3A==
X-Gm-Message-State: AOJu0YzsZM8Pt31gV0AZTV15htxFBAjyX2sc9pqfdQLm6cv3Tr6PDt9T
 OW7Zc6RCNTs7Dx+/qmK3R3LnkTRrErpFm0/frhI7x0ezovxG2wYjjevp5MZs6QDylSgvQVBMRTs
 dOIrg
X-Gm-Gg: AeBDietm6fy2qKylmoDripIYTAMsDVsWqQcLbR9PpMa2FJf/L0VSrBPxnyFEY1mdEPa
 PGaOb1N+m+cU/6xKHOM2FR45R2DNXttTxDQXpxyMpsvhzUjlDvB/DkgnFS499tK0VEOSthlStJV
 7ghs4CaE1719W76RoSfXZvLmJrzq60JZ3i6EwkFNR0s3gf6mUK4Rz6FLLJPELwgs+b1qHMSM6Mj
 T6cR9W1nYCps+GE8hvzwk5lTFNhm3bfcg4moTSeNbfzgGZjB28rXjxe3aTsEDtNRcjkxsmwrkB+
 7DezMpvGZ7rz6NlOOoBTkvIkGuxVseSGgRDzSDhw0guU/kejg6pnsJs3o7K4fr82AiBvqEli0+K
 /rTjq/wkQ8ypMoq9rtBLHTx91sjHlVV0zaLJB3K7xk/6BggMgO2Zg83Ab847o6tf2WgU9e2uv/6
 BjK2mTdftzmPNnXOpaV/6hzhg09sRKns1uiH9UMFaksPxLyQ==
X-Received: by 2002:a05:6820:308e:b0:68c:6e:89d1 with SMTP id
 006d021491bc7-69998d603fbmr5749179eaf.41.1778192239316; 
 Thu, 07 May 2026 15:17:19 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435573e7254sm45037fac.14.2026.05.07.15.17.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 15:17:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/18] fpu: Compress float_status
Date: Thu,  7 May 2026 17:16:59 -0500
Message-ID: <20260507221717.486023-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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

Based-on: 20260507160959.449170-1-richard.henderson@linaro.org
("[PATCH v3 00/11] fpu: Export some internals for targets")

The impetus of this was the Arm FP8 work, and noticing the code
generated for clearing and copying float_status.  Being able to
reduce this to one 64-bit struct improved this quite a bit.

An in-progress iteration of this patch set used FIELD in float_status
instead of bitfields, which required all of the accessor work.  In the
end, I thought being able to print float_status from within gdb too
useful to give up lightly.  But since the accessor work was done, I
thought I'd go ahead and keep it.


r~


Richard Henderson (18):
  target/alpha: Remove CONFIG_SOFTFLOAT_INLINE
  fpu: Introduce FloatExceptionFlags
  target/alpha: Use FloatExceptionFlags
  fpu: Introduce FloatSNaNRule
  fpu: Use {get,set}_float_rounding_mode everywhere
  fpu: Use of {get,set}_floatx80_rounding_precision everywhere
  fpu: Use get_floatx80_behaviour everywhere
  fpu: Use get_float_2nan_prop_rule in partsN_pick_nan
  fpu: Use get_float_3nan_prop_rule in partsN_pick_nan_muladd
  fpu: Use get_float_infzeronan_rule in partsN_pick_nan_muladd
  fpu: Use accessors for tininess_before_rounding
  fpu: Use {get,set}_flush_to_zero everywhere
  fpu: Use accessors for ftz_before_rounding
  fpu: Use {get,set}_flush_inputs_to_zero everywhere
  fpu: Use get_default_nan_mode everywhere
  fpu: Use get_float_default_nan_pattern in partsN_default_nan
  fpu: Add accessors for rebias_{underflow,overflow}
  fpu: Reorg float_status

 include/fpu/softfloat-helpers.h |  32 ++-
 include/fpu/softfloat-types.h   |  84 ++++---
 include/fpu/softfloat.h         |  12 +-
 target/i386/ops_sse.h           |  24 +-
 target/mips/fpu_helper.h        |   3 +-
 fpu/softfloat.c                 | 122 +++++-----
 target/alpha/fpu_helper.c       |   8 +-
 target/alpha/helper.c           |   3 +-
 target/alpha/translate.c        |  18 +-
 target/arm/tcg/helper-a64.c     |  12 +-
 target/arm/tcg/vfp_helper.c     |  38 ++--
 target/hexagon/fma_emu.c        |   6 +-
 target/hppa/fpu_helper.c        |   2 +-
 target/i386/tcg/fpu_helper.c    |  65 +++---
 target/m68k/softfloat.c         | 380 ++++++++++++++++----------------
 target/mips/msa.c               |   4 +-
 target/ppc/cpu.c                |   4 +-
 target/ppc/fpu_helper.c         |  14 +-
 target/riscv/vector_helper.c    |   6 +-
 target/s390x/tcg/fpu_helper.c   |   4 +-
 target/sh4/cpu.c                |   2 +-
 target/xtensa/cpu.c             |   3 +-
 tests/fp/fp-bench.c             |   6 +-
 tests/fp/fp-test.c              |   6 +-
 fpu/softfloat-parts.c.inc       |  52 ++---
 fpu/softfloat-specialize.c.inc  | 112 +++++-----
 tests/fp/wrap.c.inc             |  12 +-
 27 files changed, 520 insertions(+), 514 deletions(-)

-- 
2.43.0


