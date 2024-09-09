Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B80AECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 16:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snhA7-00024o-Ff; Mon, 09 Sep 2024 12:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhA5-00022j-F4
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:22:45 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhA3-0007fk-4R
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:22:44 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-718a3b8a2dcso2546793b3a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 09:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725898961; x=1726503761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lOQChnUkVXUAx+y325Z3070TgSIayRy3/U0PP6+k2eQ=;
 b=QVYeO3FIIRQoxu3ylzAJF1i6s5asbRJRZTTY5UBRiS34gZct3XhOWowwlb+wsZ46Or
 88h7++ZCVKTEHYY7nc8Do564A8g8n79u7NCegQLu4ojPuaXMK9K/W7CY7vOB0QHiwBTM
 E6YJ/pSs6HS3ZqbP6NXt3xmBWfFWy2muhirWclzVnwweHTH/RUdhYtJYIcAfMIzu7IJC
 Zb8r9FITO6uNlhne1umCfX0MvKun1mmqrMsv8rFJiLx4jYURgDuTGTkBJ4dGqCqOsLvT
 UcJctbk6MXpbklQU6lHRoecsn81REFJbPrK88UH5MQ8ptBwJqlY6ihrf0dL5BhUhRCvq
 e3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725898961; x=1726503761;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lOQChnUkVXUAx+y325Z3070TgSIayRy3/U0PP6+k2eQ=;
 b=ufu+UcFT4UeBZohYr0joMsHkR59t0iwp/d4DbnN0KYIRhCAFjsFDqteRyJE3CYHKgi
 rw74MNeOaqBndGO5HW8MBCn8YRCAzdcH+0GXMJAM95leQwHz9PQK9rv71+IhQtdCc8QN
 btzGH+KTDB/ukU1BfxS3AU4kdWxVmQh5e/hC37hxmpo4P8kGP72hLWKGktsZSwmFCx4U
 GvnYI61v1pH29tA0os1WeR5syaKd3UdjiLyaey35XczVKrQ0VQT4GKkKRLxlXvlN84Wx
 ycJKVxzTmPIAuD2QsJueFqrqFnhhZS62T47d9tUDQKElLHcUZtlk5zxBz/m2m2iZrpJw
 g+Vg==
X-Gm-Message-State: AOJu0YwN2c/B3iJ6NNL08hN36bGfKbDd/9JMtiDVXx3ZKp6jJwCyIiND
 a0gtDuVgEjto8ENAccTkUpr63dzVUp4d8EMvhql0oiIgXV0/9WzecWfJuVrz32EGwSA8GeyWC5+
 w
X-Google-Smtp-Source: AGHT+IGKLn+aVxxq5Rs1EG/tEqxIEn8arKX1qv6lIyzOzPZvLJT0nXIDVaZbyzMB/vu2MCuN7k1pBA==
X-Received: by 2002:a05:6a20:43a0:b0:1cf:36dd:32e5 with SMTP id
 adf61e73a8af0-1cf36dd3526mr4864704637.15.1725898961310; 
 Mon, 09 Sep 2024 09:22:41 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f35d79sm35753305ad.288.2024.09.09.09.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 09:22:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 00/29] target/arm: AdvSIMD decodetree conversion, part 4
Date: Mon,  9 Sep 2024 09:22:10 -0700
Message-ID: <20240909162240.647173-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

First post-9.1 queue flush.

r~

Richard Henderson (29):
  target/arm: Replace tcg_gen_dupi_vec with constants in gengvec.c
  target/arm: Replace tcg_gen_dupi_vec with constants in translate-sve.c
  target/arm: Use cmpsel in gen_ushl_vec
  target/arm: Use cmpsel in gen_sshl_vec
  target/arm: Use tcg_gen_extract2_i64 for EXT
  target/arm: Convert EXT to decodetree
  target/arm: Convert TBL, TBX to decodetree
  target/arm: Convert UZP, TRN, ZIP to decodetree
  target/arm: Simplify do_reduction_op
  target/arm: Convert ADDV, *ADDLV, *MAXV, *MINV to decodetree
  target/arm: Convert FMAXNMV, FMINNMV, FMAXV, FMINV to decodetree
  target/arm: Convert FMOVI (scalar, immediate) to decodetree
  target/arm: Convert MOVI, FMOV, ORR, BIC (vector immediate) to
    decodetree
  target/arm: Introduce gen_gvec_sshr, gen_gvec_ushr
  target/arm: Fix whitespace near gen_srshr64_i64
  target/arm: Convert handle_vec_simd_shri to decodetree
  target/arm: Convert handle_vec_simd_shli to decodetree
  target/arm: Use {,s}extract in handle_vec_simd_wshli
  target/arm: Convert SSHLL, USHLL to decodetree
  target/arm: Push tcg_rnd into handle_shri_with_rndacc
  target/arm: Split out subroutines of handle_shri_with_rndacc
  target/arm: Convert SHRN, RSHRN to decodetree
  target/arm: Convert handle_scalar_simd_shri to decodetree
  target/arm: Convert handle_scalar_simd_shli to decodetree
  target/arm: Convert VQSHL, VQSHLU to gvec
  target/arm: Widen NeonGenNarrowEnvFn return to 64 bits
  target/arm: Convert SQSHL, UQSHL, SQSHLU (immediate) to decodetree
  target/arm: Convert vector [US]QSHRN, [US]QRSHRN, SQSHRUN to
    decodetree
  target/arm: Convert scalar [US]QSHRN, [US]QRSHRN, SQSHRUN to
    decodetree

 target/arm/helper.h             |   34 +-
 target/arm/tcg/translate.h      |   14 +-
 target/arm/tcg/gengvec.c        |  121 +-
 target/arm/tcg/neon_helper.c    |   55 +-
 target/arm/tcg/translate-a64.c  | 2081 +++++++++++++------------------
 target/arm/tcg/translate-neon.c |  179 +--
 target/arm/tcg/translate-sve.c  |  128 +-
 target/arm/tcg/a64.decode       |  257 ++++
 target/arm/tcg/neon-dp.decode   |    6 +-
 9 files changed, 1377 insertions(+), 1498 deletions(-)

-- 
2.43.0


