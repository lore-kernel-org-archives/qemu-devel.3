Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06502C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 21:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCm4s-0006Bt-R0; Wed, 07 May 2025 17:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4j-000685-4k
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:09 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4f-0006BN-OJ
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:08 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso400517b3a.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 14:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746652382; x=1747257182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PhzgjzjJAUcmPPLua/ZuRZB9vHdvYrGvUuNJIekMSWw=;
 b=UXoayxj1qSzyopz0/v+6LRGNT6BkugIXit64uGbSgxNVQ9cKGS9kKvrRzCLY/yP17r
 +cUbotc9iMuNWW12XkJ0ivRUbOdqW/2DUo+aSRMxJiCbfrVP4BsFtzQTqgxd0PboOv/Y
 +7li9K+nf3MdpizggQVXA4p9/JTK99cl6HXsMe8vNXBvCgzeOBCPB4rCcS+qzSmXS3Dc
 4sBCevKH8kgs4LbO/iHEmzFy65MyYSkLeZL8ujOAbiw43VqJ7KK9JxNZ6q33ruMRiKa3
 WH0ktNN/+50G7vN6O5pkhQLJDcUtzaaC/WYbIAV9Kn+ELqrx0ByRi58hGkqq7olgFPJY
 rrng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746652382; x=1747257182;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PhzgjzjJAUcmPPLua/ZuRZB9vHdvYrGvUuNJIekMSWw=;
 b=accg18NUjXWyuus9ccJxgaRv0iEJDv6N9eJXRI8rk7R4gezMUVDQdve3bvmRy+jHo2
 QgWbvJ8AMkQYj6pkkEpQvRs5whn9exiMdxCdC0I7Tx2zI1ndzpoRBupYyODKDFWf8Yao
 tgAFO/0TFOUWKGN1SQ803nzvRV2e5mI8q8GmPM9zP5x1UPO8/DxaK30P+UVfG1Y7uR8g
 pHwZPVaSkntlp54OUak3WVYhw8lpjJ4SioJEYxU8JB/2/hdUVfopW5s/8q8AKl3LFXYT
 uZadX2C8MEnDo00Y3FK6wUCLk800+JFuI8juWxFbs5xpIj/s/oV3iy0bH2ustlg6UbYm
 PdaA==
X-Gm-Message-State: AOJu0YyX/B+FrXGAf59k9+2XzxNSEGRaSqVl529bpgRoXk3mLbHwd19x
 jU1HA00KbBfqGJlId5fw76RE05Uvb4v19vjU/EOggBOix9Y1R6wY/WJ+z0VWGHu3aIsNTMolkuV
 9
X-Gm-Gg: ASbGncuaGDZJQTJE7ePUQK+zxkKF9WRZNU4F4rSPW8CO8jLGiRnE19uciDQvJHRfcsk
 Z1LUDtglaXXbwSQ8Qx8EMsrZd81lhLdG4DMMrxHGirADp61N9qSHP2aO6o4Gr8LdPjmYgSWRCMi
 mcS0SfObpox8+Uje+O4AbsOQ1PuwCjOXlr/LoHSmzUoA7qneAMhYCxRdKyF47ZK3HQbj3eB7bgY
 6H+oFgHds8pPh451c5472uqIx07bZ3RLNn7hfaVuX1jvblnZfPnCzm97syKEZJT+sYpZG6sAW5G
 W1ZQJV98rTQzpeRAm1V0Fs+6PpMq0ofkRajaZ1mhvyLlCZ5EOMBLewu/8TIsQN5MOTCefdUhr4M
 =
X-Google-Smtp-Source: AGHT+IHGgdb3r8jCawbsxnwz6Xpa8kubcLXTDvYUWDxI1bV4z0VoEx9uZcLkWdSIiz13v0cJNl9WAg==
X-Received: by 2002:a05:6a00:2c86:b0:73d:f9d2:9c64 with SMTP id
 d2e1a72fcca58-740a947b507mr1445050b3a.10.1746652382128; 
 Wed, 07 May 2025 14:13:02 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902154dsm12255251b3a.90.2025.05.07.14.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 14:13:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH v5 00/24] target/m68k: fpu improvements
Date: Wed,  7 May 2025 14:12:35 -0700
Message-ID: <20250507211300.9735-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

v3: https://lore.kernel.org/qemu-devel/20240909172823.649837-1-richard.henderson@linaro.org/
v4: https://lore.kernel.org/qemu-devel/20250224171444.440135-1-richard.henderson@linaro.org/

Changes for v5:
  - Rebase from February.  :-/
  - Use ldl_be_p in m68k_fpu_gdb_set_reg (phil).

Patches needing review:
  03-target-m68k-Keep-FPSR-up-to-date.patch
  05-target-m68k-Update-FPSR-for-FMOVECR.patch
  09-target-m68k-Use-OS_UNSIZED-in-LEA-PEA-JMP.patch
  10-target-m68k-Move-pre-dec-post-inc-to-gen_lea_mode.patch
  11-target-m68k-Split-gen_ea_mode-for-load-store.patch
  21-target-m68k-Implement-packed-decimal-real-loads-a.patch


r~


Richard Henderson (24):
  target/m68k: Add FPSR exception bit defines
  target/m68k: Restore fp rounding mode on vm load
  target/m68k: Keep FPSR up-to-date
  target/m68k: Update FPSR.EXC
  target/m68k: Update FPSR for FMOVECR
  target/m68k: Introduce M68K_FEATURE_FPU_PACKED_DECIMAL
  target/m68k: Merge gen_ea into SRC_EA and DEST_EA
  target/m68k: Use g_assert_not_reached in gen_lea_mode and gen_ea_mode
  target/m68k: Use OS_UNSIZED in LEA, PEA, JMP
  target/m68k: Move pre-dec/post-inc to gen_lea_mode
  target/m68k: Split gen_ea_mode for load/store
  target/m68k: Remove env argument to gen_lea_indexed
  target/m68k: Remove env argument to gen_lea_mode
  target/m68k: Remove env argument to gen_load_mode
  target/m68k: Remove env argument to gen_store_mode
  target/m68k: Remove env argument to gen_ea_mode_fp
  target/m68k: Split gen_ea_mode_fp for load/store
  target/m68k: Move gen_addr_fault into gen_{load,store}_mode_fp
  target/m68k: Merge gen_load_fp, gen_load_mode_fp
  target/m68k: Merge gen_store_fp, gen_store_mode_fp
  target/m68k: Implement packed decimal real loads and stores
  tests/tcg/m68k: Add packed decimal tests
  target/m68k: Make vmstate variables static
  target/m68k: Implement FPIAR

 target/m68k/cpu.h                |   27 +-
 target/m68k/helper.h             |    5 +-
 target/m68k/cpu.c                |   38 +-
 target/m68k/fpu_helper.c         |  330 +-
 target/m68k/gen-floatx80-pow10.c |   33 +
 target/m68k/helper.c             |   18 +-
 target/m68k/translate.c          |  789 +++--
 tests/tcg/m68k/packeddecimal-1.c |   41 +
 tests/tcg/m68k/packeddecimal-2.c |   46 +
 target/m68k/floatx80-pow10.c.inc | 4935 ++++++++++++++++++++++++++++++
 tests/tcg/m68k/Makefile.target   |    4 +-
 11 files changed, 5746 insertions(+), 520 deletions(-)
 create mode 100644 target/m68k/gen-floatx80-pow10.c
 create mode 100644 tests/tcg/m68k/packeddecimal-1.c
 create mode 100644 tests/tcg/m68k/packeddecimal-2.c
 create mode 100644 target/m68k/floatx80-pow10.c.inc

-- 
2.43.0


