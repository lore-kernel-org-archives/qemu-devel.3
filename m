Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAECE6894F
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MG7-0007Jw-B5; Wed, 30 Oct 2024 23:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MG5-0007Jf-OG
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:54:05 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MG4-0003vF-Ax
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:54:05 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-207115e3056so5059875ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346842; x=1730951642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zkMM+SpFMUglcfQaluT/IwK1QZ7oQxstOZNmSOLZ8cc=;
 b=coJLaFGVd4pJHIKu7+YTZbwr4099XHQIVh+x8fCMj6iNnsurAapQO4g/MomxFPK9mc
 e9JdZNqI41l+9vK91sRrrUS6B68V0hG6FN4VuFR5JaGA4QF68QIvT/ry6zEozoMuCE6S
 fQ54d3dgBZ4Ui7mxZnv3c2oY/WkGyyhEOe4KJ3CXMddmc2IyDLFHKH8ODXEHSYkOWhBe
 Dz+abLyJFO0LU3g2F2rmQgvcy1IiBAwY7wSXK0D6nVybFkDNF77YzQO9iWZdw2oAyv31
 jB2qqR1lR496yR2IP/DBm9eBW7FoWk4n1hpHIlrRIjcolrFdy+cfdhSczHWDaLY6yvpd
 mBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346842; x=1730951642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zkMM+SpFMUglcfQaluT/IwK1QZ7oQxstOZNmSOLZ8cc=;
 b=sApzUqjcW0H8cEEws6aheepPNxrLOQriW7QekvgMGzB08FW160BDtXAAgtwpL7RJ7i
 rzOH8dxgjAdkkB5R1al/0i9K0Sj13txQABCMkpSC/ntLN8atESFPoYiTFh7YC2AE7mCe
 q3ZCigRNk62L5t+UwZkBPk3RTuLAEOn+XvroAQdvmrDpT351c1svSDb49ZRAr8y2BTsW
 +UnbOQ04rrd53EBa1c/5/SX4wnnRUBUqYHPd2OyigzMTqpSD87RAj6buyrlhiauFPPqd
 S3eKGkiBZ8Mypy3jGMmLZ/vXxNz6yjafXyvW0F2bvzMPKCyHVjiphW3/qxQw6KHVa6nY
 lSVg==
X-Gm-Message-State: AOJu0YxP7obYRlrahjJadtuNcRpNeTY1cklGd78AC5984E/BwH1xRetc
 tk2iCROamnHJK1vfj/vvxBMcbNhlxxnB72SPJQWb8oazM3C1VK6QH9U2F8cd
X-Google-Smtp-Source: AGHT+IFAsR9ahUI3y+OceZKLRZtsJbREhCNARElu94LtcXJWVPKMvmNIJPKzh7NeQboMn8SZdMInXA==
X-Received: by 2002:a17:903:244d:b0:20c:bb35:dae2 with SMTP id
 d9443c01a7336-210c69e1c8emr218143015ad.28.1730346842559; 
 Wed, 30 Oct 2024 20:54:02 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:54:02 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rob Bradford <rbradford@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 12/50] target/riscv: Set vtype.vill on CPU reset
Date: Thu, 31 Oct 2024 13:52:40 +1000
Message-ID: <20241031035319.731906-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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

From: Rob Bradford <rbradford@rivosinc.com>

The RISC-V unprivileged specification "31.3.11. State of Vector
Extension at Reset" has a note that recommends vtype.vill be set on
reset as part of ensuring that the vector extension have a consistent
state at reset.

This change now makes QEMU consistent with Spike which sets vtype.vill
on reset.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240930165258.72258-1-rbradford@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0c8e017f71..2a78cd639b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1010,6 +1010,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     cs->exception_index = RISCV_EXCP_NONE;
     env->load_res = -1;
     set_default_nan_mode(1, &env->fp_status);
+    env->vill = true;
 
 #ifndef CONFIG_USER_ONLY
     if (cpu->cfg.debug) {
-- 
2.47.0


