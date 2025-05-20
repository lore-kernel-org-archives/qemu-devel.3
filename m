Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB6FC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 17:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQh3-0000wC-63; Tue, 20 May 2025 13:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uHQh1-0000vU-54
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:23:55 -0400
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uHQgz-0005BO-6c
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:23:54 -0400
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6f8cda1ca6dso19733556d6.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 10:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1747761831; x=1748366631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QFpCQKWfCai55hlOsppdJxrjy/kx+GdCozqEY+xOp5U=;
 b=XlJJyP029R/D2MQO5glvGvl+NC8EoIuv5Yr87d8/5ZtxuwbUn+XWC/up+KNmNnJA+9
 yg485LVEllz1d7mGtr91jRRm7Mk3QusmOPLaCx2fr/PfZnpU4cVG3vez3TqvqxyYgHBY
 /PaFW3BbUGUCwrfl09sxaySvZt+a6UNXn9b3xlnmI+DIfV9t1XUoHkbKllHnwuLauGka
 +JoUzhJyaq9DIEUfK4ZPgaoWw5Mrv26SLGayyXHpk8/ThdARJrXbkqw1xg3p6whax99J
 qOC5CO1iU0CrK6umpDK/3fNKV3Vd9fty4BsQ0Fvi22FUqQdsOnetF4NIKGDlMZ2U0HWx
 9DKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747761831; x=1748366631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QFpCQKWfCai55hlOsppdJxrjy/kx+GdCozqEY+xOp5U=;
 b=swklLvPKWZK0s2TUE/kEKGKPeEjBoGhktjRJ/8zKQK3vm8e+Xbq7fTEeWdSa5G49Bd
 KxlHI975xsEBGPudU5gheA4+JZzNx2dH3KBp8Mj0rVItAFvVDywB0uTlJ0cj7tYw/QGo
 ffMvk2Y6Gq5ZkFc6beL/Z64K+u5EzXQvdQo2BJo5kfYYpw3okXbfy2tHVZTvVn+ynRCs
 NBUR1E4pO2Ij9mVCcrc5zuJfz2vqHouWgSKS1TmmNZalf7ao2UtdG013tDIejzMuBfs9
 zmVk4RwBzD5huZ5QPkoexDfzwF4mO5xeRefZ2cZfq3ljZfCNfGdmjCD2mesxXOh6MkQ+
 m5oA==
X-Gm-Message-State: AOJu0Yx2cd6uuxvlLXM/Wqqxy3JJLuxZdb/zeJuOkmlOfAg6OhByXZpv
 pa5SkXVuOOQ5UA9TyutCESP/xRiipPfRAkVDeNFP4N3b3ezDV5E2BkEdIwu8OnJKnVAXcEo5WpJ
 Woto+
X-Gm-Gg: ASbGnctO4WM5QfVkjIr90c7M7SkfOZr9SeM2DIkD/W/Cts/Wy1iWf/AaWXqaVSoDL3j
 rcBtIONwOrCyniXRCmx68Q6bAOIvx2n8snnaHZgZHlJdy2R/UflWygDxzprDz1TXy1WvehUZwiJ
 +Fii5JqvVYn40/bqcTYaCSCK/mHHGKrck5nM+MPPNxiZ/OCXwoJ/0xDQIvrTmw7TfLO/4JciYst
 rV+vW42EA4OCz51QExtdSkwBH6EpSBDQdJINT1v8Y/vg9vbreG9rM7ORYMoX63fnFrXKBvpP9YD
 IhG4DpjWfzJo3YqlFUdJYkfnJHUvGzVjqDMiIKXlD5xI4bxUU6MrgZ+TGlZlcJZAb3Ts3tJ4DSO
 IzwfM
X-Google-Smtp-Source: AGHT+IHuH/Kdt6/7i0SW6cEkmsbV5L/BlmWUCqC498TrTAhxnBke/+I0inZRZpLVkKHsOjTw8JmhmQ==
X-Received: by 2002:a05:6214:1c8e:b0:6eb:1e80:19fa with SMTP id
 6a1803df08f44-6f8b0849240mr227851636d6.1.1747761831574; 
 Tue, 20 May 2025 10:23:51 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([152.250.131.100])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-87bec155e21sm7698107241.17.2025.05.20.10.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 10:23:51 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com,
 bjorn@kernel.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 3/3] target/riscv: add profile->present flag
Date: Tue, 20 May 2025 14:23:36 -0300
Message-ID: <20250520172336.759708-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520172336.759708-1-dbarboza@ventanamicro.com>
References: <20250520172336.759708-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qv1-xf2b.google.com
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

Björn reported in [1] a case where a rv64 CPU is going through the
profile code path to enable satp mode. In this case,the amount of
extensions on top of the rv64 CPU made it compliant with the RVA22S64
profile during the validation of CPU 0. When the subsequent CPUs were
initialized the static profile object has the 'enable' flag set,
enabling the profile code path for those CPUs.

This happens because we are initializing and realizing each CPU before
going to the next, i.e. init and realize CPU0, then init and realize
CPU1 and so on. If we change any persistent state during the validation
of CPU N it will interfere with the init/realization of CPU N+1.

We're using the 'enabled' profile flag to do two distinct things: inform
cpu_init() that we want profile extensions to be enabled, and telling
QMP that a profile is currently enabled in the CPU. We want to be
flexible enough to recognize profile support for all CPUs that has the
extension prerequisites, but we do not want to force the profile code
path if a profile wasn't set too.

Add a new 'present' flag for profiles that will coexist with the 'enabled'
flag. Enabling a profile means "we want to switch on all its mandatory
extensions". A profile is 'present' if we asserted during validation
that the CPU has the needed prerequisites.

This means that the case reported by Björn now results in
RVA22S64.enabled=false and RVA22S64.present=true. QMP will recognize it
as a RVA22 compliant CPU and we won't force the CPU into the profile
path.

[1] https://lore.kernel.org/qemu-riscv/87y0usiz22.fsf@all.your.base.are.belong.to.us/

Reported-by: Björn Töpel <bjorn@kernel.org>
Fixes: 2af005d610 ("target/riscv/tcg: validate profiles during finalize")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.h            | 15 +++++++++++++++
 target/riscv/riscv-qmp-cmds.c |  2 +-
 target/riscv/tcg/tcg-cpu.c    | 11 +++--------
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b56d3afa69..82ca41d55b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -82,7 +82,22 @@ typedef struct riscv_cpu_profile {
     struct riscv_cpu_profile *s_parent;
     const char *name;
     uint32_t misa_ext;
+    /*
+     * The profile is enabled/disabled via command line or
+     * via cpu_init(). Enabling a profile will add all its
+     * mandatory extensions in the CPU during init().
+     */
     bool enabled;
+    /*
+     * The profile is present in the CPU, i.e. the current set of
+     * CPU extensions complies with it. A profile can be enabled
+     * and not present (e.g. the user disabled a mandatory extension)
+     * and the other way around (e.g. all mandatory extensions are
+     * present in a non-profile CPU).
+     *
+     * QMP uses this flag.
+     */
+    bool present;
     bool user_set;
     int priv_spec;
     int satp_mode;
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index d0a324364d..ad8efd180d 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -121,7 +121,7 @@ static void riscv_obj_add_profiles_qdict(Object *obj, QDict *qdict_out)
 
     for (int i = 0; riscv_profiles[i] != NULL; i++) {
         profile = riscv_profiles[i];
-        value = QOBJECT(qbool_from_bool(profile->enabled));
+        value = QOBJECT(qbool_from_bool(profile->present));
 
         qdict_put_obj(qdict_out, profile->name, value);
     }
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index af202c92a3..396fac0938 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -840,16 +840,11 @@ static void riscv_cpu_check_parent_profile(RISCVCPU *cpu,
                                            RISCVCPUProfile *profile,
                                            RISCVCPUProfile *parent)
 {
-    const char *parent_name;
-    bool parent_enabled;
-
-    if (!profile->enabled || !parent) {
+    if (!profile->present || !parent) {
         return;
     }
 
-    parent_name = parent->name;
-    parent_enabled = object_property_get_bool(OBJECT(cpu), parent_name, NULL);
-    profile->enabled = parent_enabled;
+    profile->present = parent->present;
 }
 
 static void riscv_cpu_validate_profile(RISCVCPU *cpu,
@@ -910,7 +905,7 @@ static void riscv_cpu_validate_profile(RISCVCPU *cpu,
         }
     }
 
-    profile->enabled = profile_impl;
+    profile->present = profile_impl;
 
     riscv_cpu_check_parent_profile(cpu, profile, profile->u_parent);
     riscv_cpu_check_parent_profile(cpu, profile, profile->s_parent);
-- 
2.49.0


