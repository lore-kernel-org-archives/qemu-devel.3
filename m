Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328F0E77170
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 12:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIoxE-0008BB-HM; Wed, 04 Dec 2024 07:58:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tIox5-00084u-Rh
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 07:58:03 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tIox4-0000By-3F
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 07:57:59 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385e1721716so2648889f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 04:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733317074; x=1733921874;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AdfctVdNv45/VmWP+SA5e4bfBEoBz0UqYA7wpbj9RiY=;
 b=bwMA+H/iMSonJS3+RDyPvkbUdiEo/7guL+v+Q68zahU5CdSZPSScTeyLf/fHgCF1rc
 T+djVy6S3KyuDqONrC7f7p+enNVOzL6iqlHR8SuWg+KURw/jJcwBVwLIyv2OsD2z3IUG
 5AU5rZ56dBh4y6CYQywc5PVxFIBK1I/cyn1LsE+yChykixF5+NbVQ21qArUxIYas1yg/
 bhSxFdeiV6eE9UiU2fm9KjjTrsrWSsRr1cBkyNnXYQHqwOJZ4jk+tx5dvdwXagZL1T5V
 wa9Q0lKsqc5Hpu0gIQ0SF13g/6Yx0R778nJO9m7qKv2eIvq6+pN2RmlGTimxe/8bqtgD
 dKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733317075; x=1733921875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AdfctVdNv45/VmWP+SA5e4bfBEoBz0UqYA7wpbj9RiY=;
 b=OeZxmgsA6/CDPmHM91zEx+phdQCNSZMr9eXHK7lWUe1BJzSYFLXK5YMZKHM/K137kS
 77EfbyurOKig3YDRsjyAoYGByxfGy/TuOBKXr7aYCz8KOAYN/kelQNVJvwy6x+ilU56q
 nwpq9/80zwgsXfv+5jKjmNfdQUx4M/92YbRehIGU7pftZRefkiHwgv8zGDAwCDU22gbM
 M0AbbMIDIbJTA6P6AFWelIqLEloaqS6/B0EhLNKj8PfZJcfYTBzZKrPjPL+qTbQVvsJu
 H3+GYp0pE2prC/uvzCgu2IyWEmHpCGXmUqWjML1t9LF6qbU+VZ+ZX4irHQ0uQT16xGYv
 Y4vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKzJba/B9ujVgl2HaxZo52rmp0vaAR3TR1bLTegGNlgUPG6fCaBbPbBNI1yfcf33IigqgSSEC9oQBh@nongnu.org
X-Gm-Message-State: AOJu0Yz8kTGVtX8WaER78vFUA5QxvzCdxLXtTf6b3wO+urHvAhVdpI0M
 qOo7/+TERXxLKyYXI7HVrwNvBsnb7BIib1Gm1+95wYwc4gRN0lJfKtEf3jHRZGM=
X-Gm-Gg: ASbGnctesqxdnKYweT6vTrl2kbODiiGZXiLPcrWPeDFF6EUcgSlXOxxYDkcSXwK0OJ2
 KjB+nrq0KVzmfKGysdKopU2Mj78oIikypTcrXwTMJ7htBH1iVIFWZAusxFCMiEnk9IVIPtBEjNw
 ZzDOf+xfWNTCSovWFZodp/E0BjqWa/wB5zfb68WDxWUOERETAUL3FWhfY0IppvkpdUA18cMEkM2
 DpSXlWw1BWay16ffCdBbhm/0VMaQyfbMwN0ECriGncAekoD3AoamMqkvofE5bwESgmhc0c224RY
 3kvDqQ==
X-Google-Smtp-Source: AGHT+IFsnyml7eLyL8nD58SX/Ykhd+WFATkHK4nrvyDmdvnvZFFQQgf2F3F1C2ODw+bDkjHLgO4+4g==
X-Received: by 2002:a05:6000:4601:b0:385:fb40:e57b with SMTP id
 ffacd0b85a97d-385fd3cd413mr5382365f8f.15.1733317074609; 
 Wed, 04 Dec 2024 04:57:54 -0800 (PST)
Received: from rkanwal-XPS-15-9520.ba.rivosinc.com ([137.59.223.84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385deeb6acdsm15826428f8f.81.2024.12.04.04.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 04:57:54 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, beeman@rivosinc.com,
 tech-control-transfer-records@lists.riscv.org, jason.chien@sifive.com,
 frank.chang@sifive.com, richard.henderson@linaro.org
Subject: [PATCH v4 7/7] target/riscv: machine: Add Control Transfer Record
 state description
Date: Wed,  4 Dec 2024 17:56:45 +0500
Message-Id: <20241204-b4-ctr_upstream_v3-v4-7-d3ce6bef9432@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204-b4-ctr_upstream_v3-v4-0-d3ce6bef9432@rivosinc.com>
References: <20241204-b4-ctr_upstream_v3-v4-0-d3ce6bef9432@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add a subsection to machine.c to migrate CTR CSR state

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 target/riscv/machine.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index e1bdc31c7c53a8a4f539113d501c8e46f7a914e9..b67e660ef03b6053fa00d5a79e2ab20ecf3331b8 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -311,6 +311,30 @@ static const VMStateDescription vmstate_envcfg = {
     }
 };
 
+static bool ctr_needed(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+
+    return cpu->cfg.ext_smctr || cpu->cfg.ext_ssctr;
+}
+
+static const VMStateDescription vmstate_ctr = {
+    .name = "cpu/ctr",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = ctr_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(env.mctrctl, RISCVCPU),
+        VMSTATE_UINT32(env.sctrdepth, RISCVCPU),
+        VMSTATE_UINT32(env.sctrstatus, RISCVCPU),
+        VMSTATE_UINT64(env.vsctrctl, RISCVCPU),
+        VMSTATE_UINT64_ARRAY(env.ctr_src, RISCVCPU, 16 << SCTRDEPTH_MAX),
+        VMSTATE_UINT64_ARRAY(env.ctr_dst, RISCVCPU, 16 << SCTRDEPTH_MAX),
+        VMSTATE_UINT64_ARRAY(env.ctr_data, RISCVCPU, 16 << SCTRDEPTH_MAX),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool pmu_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
@@ -461,6 +485,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_jvt,
         &vmstate_elp,
         &vmstate_ssp,
+        &vmstate_ctr,
         NULL
     }
 };

-- 
2.34.1


