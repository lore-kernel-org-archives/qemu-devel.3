Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D13C3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 18:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqGHP-0001zm-7z; Mon, 16 Sep 2024 14:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1sqGHJ-0001t8-GY
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 14:16:51 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1sqGHG-0007ia-7Y
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 14:16:49 -0400
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4E8C23F4C0
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 18:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1726510603;
 bh=l/tH5XtPcjqPv4Qv1V6eM9yCK2jhM/o/GSXWzMCOxWM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=S89paI1/2Q65xZQ9SllywlnL72H2jnoVHdOGn/Tky3SVa4A5PERg5FDGrqq5A7JzU
 CuX9TnngCEngR+ZdsXuH+AYTwFXVkH8jRF/oV/frXHmz8JyLnWEJtTpV5aIYkijQgU
 r3npWp4NZXIXCJWw5XLBvGDJpVp7wPJj7vP5v47IzEZR1K5HxV+RA9UA7bToHD2b2U
 UY7AUHaGY7nhwuGMFR9p6NUQif72pfMm46U61bB83m+M2gw9HXTIe7VtxPAMIzNXGM
 RndMu7966hB8WshKCDAfruQyhHicaDsYqmTabulmz0at07XQ633n7JHDlnxoHLj9fF
 jRlpqVo+FCyRQ==
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2f77ca80fe1so35858481fa.0
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 11:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726510602; x=1727115402;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l/tH5XtPcjqPv4Qv1V6eM9yCK2jhM/o/GSXWzMCOxWM=;
 b=AaIj5PzqbIWF9uTcIpa5E4z4y/QUoT8LYyqkOYsBAGcfJZhjYgmMYqrDHvxP4xec8G
 SKS/iCYygcLX/opNEkyUfHkVgcUBgnw9twsPGgTRrF3Nm3KmUt+th3ybABCBmkZIEBZ2
 sBr4yANNIEiErBOScvyIwPJm2jttlmu3P5zC+42wJniWhllrM6AMTm8hsI+IHkYptymZ
 P0BEIGrC1+Za1BbSM5HH5oI5WgmtlDTygONfFTWSaZrlDHBO6q+nRh5LSFnieDUQnhWP
 g7svlFjDrceD6s6LlGlNyHHksweyJ4RXbdR4eoS1RV1gzXfqqU5rlfGJO47AGQjNLAIt
 7/Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1Oxf+rYpxkSgtwQq4QNvsNpwcUEAchVVyIXIfvSQFUZ1Rl+ja46uEjzrK5ea6KNRUDjdHzsSy6l3r@nongnu.org
X-Gm-Message-State: AOJu0YwmW/xzg6bVzAX+Yjyiq2eX5Qd7TE1kz2LGvxhS4cElC67DPr5n
 9ETvE58M6svHHTqny5j1gx7BOQ4FARGiqsIrFkIGKVni7047/BnNMeaaG3eZCnOy34Y08WOBBAh
 /WqmRsYVuD9Ha7wf7LiJpx90fjgjKm+vtwByxoHnYO4jrLaFPb25vO44U6+KN9XhzPcQt
X-Received: by 2002:a05:651c:1507:b0:2f7:62f9:b9a2 with SMTP id
 38308e7fff4ca-2f78c95dc3cmr65435841fa.4.1726510602332; 
 Mon, 16 Sep 2024 11:16:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWKpBrlaMOUrkb337X80V/IciJe0UI8oaP0O9nBytnkXI7M/7avFo9tl9Ip43SOe6L550miw==
X-Received: by 2002:a05:651c:1507:b0:2f7:62f9:b9a2 with SMTP id
 38308e7fff4ca-2f78c95dc3cmr65435461fa.4.1726510601232; 
 Mon, 16 Sep 2024 11:16:41 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bb56f39sm2900815a12.39.2024.09.16.11.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 11:16:40 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] target/riscv: enable floating point unit
Date: Mon, 16 Sep 2024 20:16:33 +0200
Message-ID: <20240916181633.366449-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

OpenSBI enables the floating point in mstatus. For consistency QEMU/KVM
should do the same.

Without this patch EDK II with TLS enabled crashes when hitting the first
floating point instruction while running QEMU with --accel kvm and runs
fine with --accel tcg.

Additionally to this patch EDK II should be changed to make no assumptions
about the state of the floating point unit.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 target/riscv/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4bda754b01..c32e2721d4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -923,6 +923,13 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     if (mcc->parent_phases.hold) {
         mcc->parent_phases.hold(obj, type);
     }
+    if (riscv_has_ext(env, RVF) || riscv_has_ext(env, RVD)) {
+        env->mstatus = set_field(env->mstatus, MSTATUS_FS, env->misa_mxl);
+        for (int regnr = 0; regnr < 32; ++regnr) {
+            env->fpr[regnr] = 0;
+        }
+        riscv_csrrw(env, CSR_FCSR, NULL, 0, -1);
+    }
 #ifndef CONFIG_USER_ONLY
     env->misa_mxl = mcc->misa_mxl_max;
     env->priv = PRV_M;
-- 
2.45.2


