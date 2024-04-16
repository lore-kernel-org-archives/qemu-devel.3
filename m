Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE820C04FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 04:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwa5G-0007ko-U6; Tue, 16 Apr 2024 00:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwa5G-0007kX-0h
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 00:06:14 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwa5E-00079M-Bh
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 00:06:13 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e424bd30fbso30660475ad.0
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 21:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713240371; x=1713845171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PR3CJUUo2/VGKB2RGbMarxktvJK4SxiTMKyT7dvFViA=;
 b=a9kATrHLxQbwqaTS0CBnaGFiDv/30/L4miY5zwQT28cpRfp/sNzpi/UDR4menPtcz9
 r99pDBpfrun/6Ina355rmJgWq2eLlE2dg4/aubIdbjLV5V0VJ//QiEXrGfp8whtGAUKS
 ID60WxBSdmg1lagUI3xAuk7Vr+YOR54rjfctEjZSm24VeRoBq5kTWAEkW54+TOYdb+1L
 Rk0oPp7VkVhFU3uSEVxv+tgYFp7uIO+pGKCJNW90oDLGKduC+dtfoVITJKzOtiB6NMc+
 6YsR5YrMegW1ehKWG06tucztFL5aRaXv+5+ZBk9CijprMneiaar3eGn+BkPcGQATeFGK
 ItRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713240371; x=1713845171;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PR3CJUUo2/VGKB2RGbMarxktvJK4SxiTMKyT7dvFViA=;
 b=C7ql3PLJGU0GCrI9EwbCkPzCKkJwuHSgHf2NV/3AeAyEZTcg9z78oToy1+l1KtJ67B
 G9I0yg1Hj5A2KxbV2deNyW8lpMvPvLdRurnuIaHpUhsTi/dw3kwojrvgo7Wy39LW1VvY
 mgTzHE+Bh4JHuZ/9j4NA3kxbTIbZ33QzPdOsjlrvTTHuVyKQHLgvLUu/GO+eXRUPVcM0
 mDdt7ADIfTyUhS9UctFWf7ZiAuF/VxoRba9pUgRzBJeNnC+u/gklLJmf3fkCHCyDURcd
 4gfXRKelxdSV5ds0NEa61diaUqFxxJWr51PT6rolAslctRWySrHr8hNm1S2Plv4LD3rG
 QImg==
X-Gm-Message-State: AOJu0YxVRDaCNH18q0M6cjtrlfAF05MISKeIPrsre2UuEcmp8fCHVq5j
 +QvaJj46/OK/SWaky/AOa5IXmRAwpCy+cGvVBDhHEGLjX/f9eJh9zUQKbWiYFRW6ZRjHmLhN6J3
 /
X-Google-Smtp-Source: AGHT+IGNf8u3huH3UiD0WahIySbT4FysItlxRHM/9pv7kmew1LTwirawPf/XuslLnl+m23X+JT8OVQ==
X-Received: by 2002:a17:902:e786:b0:1e6:3494:61fc with SMTP id
 cp6-20020a170902e78600b001e6349461fcmr6334476plb.0.1713240371009; 
 Mon, 15 Apr 2024 21:06:11 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 l1-20020a170902f68100b001e3e244e5c0sm8694439plg.78.2024.04.15.21.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 21:06:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
Subject: [PATCH 0/7] plugins: Use unwind info for special gdb registers
Date: Mon, 15 Apr 2024 21:06:02 -0700
Message-Id: <20240416040609.1313605-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Based-on: 20240404230611.21231-1-richard.henderson@linaro.org
("[PATCH v2 00/21] Rewrite plugin code generation")

This is an attempt to fix
https://gitlab.com/qemu-project/qemu/-/issues/2208
("PC is not updated for each instruction in TCG plugins")

I have only updated target/i386 so far, but basically all targets
need updating for the new callbacks.  Extra points to anyone who
sees how to avoid the extra code duplication.  :-)


r~


Richard Henderson (7):
  tcg: Introduce INDEX_op_plugin_pc
  accel/tcg: Set CPUState.plugin_ra before all plugin callbacks
  accel/tcg: Return the TranslationBlock from cpu_unwind_state_data
  plugins: Introduce TCGCPUOps callbacks for mid-tb register reads
  target/i386: Split out gdb-internal.h
  target/i386: Introduce cpu_compute_eflags_ccop
  target/i386: Implement TCGCPUOps for plugin register reads

 include/exec/cpu-common.h     |  9 +++--
 include/hw/core/cpu.h         |  1 +
 include/hw/core/tcg-cpu-ops.h | 13 +++++++
 include/tcg/tcg-op-common.h   |  1 +
 include/tcg/tcg-opc.h         |  1 +
 target/i386/cpu.h             |  2 +
 target/i386/gdb-internal.h    | 65 +++++++++++++++++++++++++++++++
 accel/tcg/plugin-gen.c        | 50 +++++++++++++++++++++---
 accel/tcg/translate-all.c     |  9 +++--
 plugins/api.c                 | 36 +++++++++++++++++-
 target/i386/gdbstub.c         |  1 +
 target/i386/helper.c          |  6 ++-
 target/i386/tcg/cc_helper.c   | 10 +++++
 target/i386/tcg/tcg-cpu.c     | 72 +++++++++++++++++++++++++++--------
 tcg/tcg-op.c                  |  5 +++
 tcg/tcg.c                     | 10 +++++
 16 files changed, 258 insertions(+), 33 deletions(-)
 create mode 100644 target/i386/gdb-internal.h

-- 
2.34.1


