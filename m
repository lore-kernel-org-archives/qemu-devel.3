Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A23EE9A03B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsSWy-0002Kv-PG; Tue, 17 Feb 2026 16:22:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vsSWx-0002Kf-F6
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:22:51 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vsSWv-0002GP-Pl
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:22:51 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-463901a0accso1266719b6e.2
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 13:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771363368; x=1771968168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=skR/SiHX5tUzsrNyUf6oGHdPMgeYRIgY8rersYjSrdQ=;
 b=DJ3RVJr8JZz/4rbZX7KeB2k3X0pdFkyN7XPYKURrVH4ohGZAVcBG/9qFJqBfbu6eSu
 H2Y71+FH4RofmOvL+laSlAwsOkw16yipdh5E+tQscUX/p3LYiU5NQhMJopw5sdi3ZCbX
 Jy4YCWiG2JodB6OxCqnmPDtqpNsp735u049dsKse1lNsYFqO0mo9B7egGVfP9Gjn9QlT
 rZ6Dh4LkCytMhOMDgkzseIBnT1+RbLupJ7h2mmByXMveiTj/jiUiA5VqLd5hCJuOpTLx
 h4/r7xMv2UxMESmimUHyuVG6y8vxENXULwHGy2dBbgO8f681ugPAWO+2BZI/nhnGSHk8
 5kvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771363368; x=1771968168;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=skR/SiHX5tUzsrNyUf6oGHdPMgeYRIgY8rersYjSrdQ=;
 b=wHlDToIaND+xIxwzyX0YheNflDC5+M8kKfWEDghG1hDtMmgkg/x2giOLvgePK2w2I3
 E1JI7jgB0ivx3+4hj0p4IMXgvYKDmrGedeHqSmUDVAwf5Rb+FU3Q7uz7PDBXl54wWJkB
 ivJbsVaGtnwhM3ilu+AMyYPvJCUeCPd0hVEhpGWCpQAxjAxUgfB0s0ke3cUBHWGTCY+n
 syZVaUddEMKnu34ACFNNDa+I82ZBih4/FJDH7nXqHRFqtgOA3t39BhjnzZY0mt6ElwWm
 ZrALu/aytUPRjLqbg3SW060ZlFYxy7hEkjNJIvFt8Q7arBYaMuk8PUtwpzLNO+Kcgk9p
 Uxcg==
X-Gm-Message-State: AOJu0YwCzyOZrMfcSnfOGYHWvizNOSud3UVzDIk1xvHMxciJ4zHzZ+Cd
 17xj6wbAN2DlGn+f5Ibi584CgxotTpNtu4oZ5jJ2p6oFT1BV1th/QYu6Ut8cjw==
X-Gm-Gg: AZuq6aIFbhuBl12+2INRvW8IY2Pubuh1p3/Mz+UGsXkW5+LGUJd1Ditx8YKHb+Yp0Hf
 /xOz8V84FC0V3WGfo7q/+Ef5wFyx/V6bKCAmL5KqB7k0IoJ8Lx2l6pC2CM5iNUp0BK8tfiMk6Xf
 IXJVNKE80+0nsdS3d9J6QuVKZxuspC69dDtERLVWFxPVOyeOzkk0u/egoc53RUF9kZ2czKUvACx
 Fnr7dYBU18pBqWEYeQ3jZgkhCgxMlRxe7dQMolHLWrPVc+tgEAa1WFpA8MlOQo/9wKjOaktVtRu
 X2vnQknji1IiwIcZEZVymxRPToN/T3r2UTB88wFvhnDKC5V9z0yVeQF1edFtuJpdRBXY32RXvcD
 RcMTRV2ww4xiqKJF+r19i0+wlmQe3mb5g/zt8HAyabBoSecoaju28Tj4SSVgf5ruP/4HtBtkuq+
 LuHJFELmovJsNaTKEZMiho2H1pytTHiXQX+VEpQYXaz712rxKXlRyggvBwx2MBnG20R9A62QZdM
 rhCLLC0s7YMhWe4
X-Received: by 2002:a05:6808:660f:b0:463:9a77:a552 with SMTP id
 5614622812f47-463b408fb9dmr6161463b6e.45.1771363368184; 
 Tue, 17 Feb 2026 13:22:48 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4636ae8f86fsm12899319b6e.3.2026.02.17.13.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 13:22:47 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH v3 0/8] Hexagon (target/hexagon) Check opcodes versions
Date: Tue, 17 Feb 2026 14:22:37 -0700
Message-ID: <20260217212245.95321-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x22f.google.com
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

Currently, all versions of Hexagon CPU are treated the same, and all
opcodes are able to run on any version.  This series changes the behavior
such that only the opcodes available on the currently executing Hexagon
CPU version can execute.

Changes include:
Mark which Hexagon CPU version is currently executing
Check that each opcode is supported in the Hexagon CPU version
If not, generate INVALID_PACKET opcode, which is converted to SIGILL
Properly handle disassembly (-d in_asm)
Test case added

Co-authored-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>

Changes in v2:
- Rebase with Brian Cain's "Handle some invalid encodings" series
- Add older opcodes to tag_rev_info.c.inc
- Change tag_rev_info to use HexagonVersion
      Suggested by Richard Henderson <richard.henderson@linaro.org>
- Disassembly includes valid opcodes inside packet with invalid opcodes
- Remove unused function - snpring_a_pkt_debug

Changes in v3:
- Use a struct to hold Hexagon definition rather than a simple enum
      Suggested by Anton Johansson <anjo@rev.ng>

Brian Cain (1):
  tests/tcg/hexagon: Add test for revision-gated instruction decoding

Matheus Tavares Bernardino (1):
  Hexagon (target/hexagon) Introduce tag_rev_info.c.inc

Taylor Simpson (6):
  Hexagon (target/hexagon) Properly handle Hexagon CPU version
  Hexagon (linux-user/hexagon) Identify Hexagon version in ELF file
  Hexagon (target/hexagon) Add Hexagon definition field to DisasContext
  Hexagon (target/hexagon) Check each opcode against current CPU
    definition
  Hexagon (target/hexagon) Disassembly of invalid packets
  Hexagon (target/hexagon) Remove snprint_a_pkt_debug

 target/hexagon/cpu-qom.h             |  27 ++
 target/hexagon/cpu.h                 |   2 +
 target/hexagon/cpu_bits.h            |   4 +-
 target/hexagon/decode.h              |   2 +
 target/hexagon/printinsn.h           |   4 +-
 target/hexagon/translate.h           |   1 +
 disas/hexagon.c                      |   3 +-
 linux-user/hexagon/elfload.c         |  43 +-
 target/hexagon/cpu.c                 |  48 ++-
 target/hexagon/decode.c              |  52 ++-
 target/hexagon/printinsn.c           |  40 +-
 target/hexagon/translate.c           |   1 +
 tests/tcg/hexagon/check_rev_gating.c | 141 ++++++
 target/hexagon/tag_rev_info.c.inc    | 613 +++++++++++++++++++++++++++
 tests/tcg/hexagon/Makefile.target    |   6 +
 15 files changed, 911 insertions(+), 76 deletions(-)
 create mode 100644 tests/tcg/hexagon/check_rev_gating.c
 create mode 100644 target/hexagon/tag_rev_info.c.inc

-- 
2.43.0


