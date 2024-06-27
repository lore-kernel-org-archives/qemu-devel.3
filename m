Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AE4C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlxA-0005oj-QZ; Thu, 27 Jun 2024 06:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlx4-0005Ns-Eh
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:04 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwv-0001gc-JT
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:01 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6fa11ac8695so4553853a34.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482512; x=1720087312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4VavWRGjlSUvFItRJ7LlymYt3dfzs/4J/YRywHyYUT4=;
 b=HdsAfD/tfAgt9gJZRpkeGxVh0VewjVAwVwO0AQy8wsqAvXQMKSqMq4vidgKRqwxqy+
 AMRqAMqOqJ9f2qwfjusMcDNyFJ0DBdD2Fu11kL7GuBjxcNmFULlXG5DoNMv6ZL6SeHM+
 9MXkrQvqp35uSLmuaIdwFBgpkcFOVr2Vh68rY4PFMzpH7urm5+uwi0dXtf2MQEunF/Wm
 GL6gtYmyZykGJd26bI/qeLV6cWz3349pFv3+4zg6fsqjOCS16xO3qIzN8aYzfNfMP1Kw
 CA1Pp/RTO9U53u9fpPlyxe1tkFZ9MXYmmufjR3SNNejv7L0whCBQ+t0ubIgKREui/HPE
 +QdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482512; x=1720087312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4VavWRGjlSUvFItRJ7LlymYt3dfzs/4J/YRywHyYUT4=;
 b=M3GCQbUp185TICG7G8KYJa0LVmW+jQdLrJvwhUoSOAU90H8NOsVm9mufIoPemasGXQ
 10gvwTn7nMC6kAn95tU2Xe2pBkADzR+4HASDTg6ZgafdysRbXbAM1WNqJA70lysbkzu9
 +pBSgr++9sMkCB6SI1NKqeFrNJOuHottZquETWaWspEL7muMOZWck/wcpEc1eTx3jegi
 hxsBIGV7xIkw6EL6v1piamkKobk6mSRXjgN+9UYqBCXTvwpdTiMfkJpylF/eB71FBdlH
 5jEdlVfegtqSqyOgelTHfHH3MumB9chZo5Ghqtu7FnxECgew/Iiv0ZVFvzQxsCelhVk1
 iqbg==
X-Gm-Message-State: AOJu0YxWtU5miCdTUtJo7vuq32vZZtj1Uw+XCdHnWhBi3gDbYeyUIHp7
 5HGuFglUsTvGNiD0wE20KJo8XWGrF+5uzWedp9jsaj8Y0ej21yDryyTuvGc5
X-Google-Smtp-Source: AGHT+IGCJ3gvtZPhr+7l5Ak6zzh/8JpdZXn298Nr0iWrnT8sforOauQ/Ug94EeZ+xh+NFPjj8+/sJw==
X-Received: by 2002:a05:6870:8a24:b0:25c:ba98:27e with SMTP id
 586e51a60fabf-25d06c6e4acmr14064728fac.32.1719482511967; 
 Thu, 27 Jun 2024 03:01:51 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:01:51 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jim Shu <jim.shu@sifive.com>,
 "Fea . Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 15/32] target/riscv: Reuse the conversion function of priv_spec
Date: Thu, 27 Jun 2024 20:00:36 +1000
Message-ID: <20240627100053.150937-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x329.google.com
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

From: Jim Shu <jim.shu@sifive.com>

Public the conversion function of priv_spec in cpu.h, so that tcg-cpu.c
could also use it.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240606135454.119186-2-fea.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  1 +
 target/riscv/cpu.c         |  2 +-
 target/riscv/tcg/tcg-cpu.c | 13 ++++---------
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6fe0d712b4..b4c9e13774 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -830,4 +830,5 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 /* Implemented in th_csr.c */
 void th_register_custom_csrs(RISCVCPU *cpu);
 
+const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 69a08e8c2c..fd0f09c468 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1790,7 +1790,7 @@ static int priv_spec_from_str(const char *priv_spec_str)
     return priv_version;
 }
 
-static const char *priv_spec_to_str(int priv_version)
+const char *priv_spec_to_str(int priv_version)
 {
     switch (priv_version) {
     case PRIV_VERSION_1_10_0:
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index fa8a17cc60..4c6141f947 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -76,16 +76,11 @@ static void riscv_cpu_write_misa_bit(RISCVCPU *cpu, uint32_t bit,
 
 static const char *cpu_priv_ver_to_str(int priv_ver)
 {
-    switch (priv_ver) {
-    case PRIV_VERSION_1_10_0:
-        return "v1.10.0";
-    case PRIV_VERSION_1_11_0:
-        return "v1.11.0";
-    case PRIV_VERSION_1_12_0:
-        return "v1.12.0";
-    }
+    const char *priv_spec_str = priv_spec_to_str(priv_ver);
 
-    g_assert_not_reached();
+    g_assert(priv_spec_str);
+
+    return priv_spec_str;
 }
 
 static void riscv_cpu_synchronize_from_tb(CPUState *cs,
-- 
2.45.2


