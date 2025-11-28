Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70CBD111A8
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 02:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOo8i-0005s3-25; Thu, 27 Nov 2025 21:23:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vOo8g-0005rW-QK
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 21:23:14 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vOo8f-0001KZ-EK
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 21:23:14 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2958db8ae4fso13795595ad.2
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 18:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1764296592; x=1764901392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mmu7hkgx+10lwQ6Vuavwga5BgiRnZBxs5WVuNfqxX3Q=;
 b=nrOkRhInMSJoQ5BKdyUnY05sWf02MXhfqSOs86W7/QK07+2/T3GIfDhNPGm2QLR4Ao
 jllttgivz6jrRlM6Yfn/lz8reXF8JXz+vglaaAxr+dsLoZWD6iSE6LZ9hIu0R6daAWqb
 d7FEvYz5mzJGtFhh1NApvfz1ZtgP+KZV9kz8NDxEAXlcTLLbE6NRtZeGrNDyOQqQC5q4
 JBnKGfHigkIDCGkjXd1yWgx23odq+G9tqwJGaQ8DtaI6LQw8eIHu+BMnnVoOsNNA3050
 mtdRo/sDNX8hcyGB4AKvirJLBhGfcV1OERXqxo1wZh669iReRODRRiRGgeFLBGgI27sV
 rkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764296592; x=1764901392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mmu7hkgx+10lwQ6Vuavwga5BgiRnZBxs5WVuNfqxX3Q=;
 b=mty4uvV8Td33vZSXbEHhUaehrsn3l4eAW/CoBTSIQWAAmZXvbHmfpaOjR6jo1wXyIp
 G/2R98etXdeylWkv5oGwcvPAGP5AYMZt4AKkWhTjAkBdgN5eMnIssGCLs0LCoxnO+yhm
 BXRcZLqWYk6IhYQrpp0BYSTs9K3H63EoT2VVJuaO0q3ZZ/nZlSUDq246wWFvsVX8vIz0
 j1TxqX6rXBUfL2y0BWx3AONXGQDXDDkZzYfGzHLilTcXAa7O83cqSyQ5yVVP/PgUHUsG
 +nRqJtSXyqqeVYPuUD7LFZv6Ez6N0AuZ9IJnRxkTS625LVDd+0jXJRZdYvdtNpio9iqu
 4Pqg==
X-Gm-Message-State: AOJu0Yydq4ETE3XwjEqSNlOHhM9zBY0bLifMs2rXKUZ216xGexWANSs0
 co0TENOFmzt4UDBM9lHlbEAmEZu2i2YyACTvCEaIn/g8aV1B6FUFCH6D0hXRv0EeTZ0N8ZAc+mF
 pAtK2x3ntyJ0wlZSVLNeWeNJDEah78YUOiD7nkJboZWUv/tnbgUK2PkU16HUV+6k9I1fyptqxkc
 JOyjgQyXaEd9o2IpbHiOs0ZZanV9A+fq68EtpaEQTUaKJWJw==
X-Gm-Gg: ASbGncuhSxb8QYDPdEc7ckm2bCy/veHcODVNFd4t+/tlwWqjnhTsMqO37YHP+g5U/Ma
 MNUml5R0es8VeppXFUsL+bmhn0/4ga6GLNt6Pv5c/72UZqUkPs9iE9DC0GlMASxgysJl1tENdTv
 gBbHtaIT6ouw7zgqDaGjUtXHnxVT8Tca4/BgZRAk9ju39Dnt56k8QKikMmfCbNEuTH9e++WHwgN
 1X1d0Xlzl9a1rZ4P2CWEeVq0JRUucJKraCZvkqcavY8sBsREIrjnjQA/6yAHQIkADKqxOOPbB6u
 q08Lz16ODvlCAsKDwGWNogV+QATmrpdAMeIMeDfIctemU9Kch1K7BBR1ANrRHcgtbmopMRS/s9d
 O4Se1Z52DbYgIRkvyOKBD+DexGDxUkhAh4acZnvu9A5Bal/CW7kdoCdk6GTqqC/Mo1lEEvGZ177
 71Yzi6YNVBJEDnnR89M/gdTEaWI0larZuNH9upwlTCMXQNNJm1
X-Google-Smtp-Source: AGHT+IERSDcVYb67o+NaYrCxqVVpdHnxOilBbMO3evkG7HmG4RRiZEIvlKOZjgZa1RabsEuciS0+bQ==
X-Received: by 2002:a17:903:11c7:b0:295:bedb:8d7 with SMTP id
 d9443c01a7336-29b6c694376mr254173225ad.48.1764296591429; 
 Thu, 27 Nov 2025 18:23:11 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29bce4418c4sm28652845ad.24.2025.11.27.18.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 18:23:10 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 2/2] target/riscv: Update MISA.X for non-standard extensions
Date: Fri, 28 Nov 2025 10:23:01 +0800
Message-ID: <20251128022302.970294-3-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251128022302.970294-1-frank.chang@sifive.com>
References: <20251128022302.970294-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x630.google.com
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

From: Frank Chang <frank.chang@sifive.com>

MISA.X is set if there are any non-standard extensions.
We should set MISA.X when any of the vendor extensions is enabled.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.h         |  1 +
 target/riscv/tcg/tcg-cpu.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8899bf7667a..2e0c92fe593 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -69,6 +69,7 @@ typedef struct CPUArchState CPURISCVState;
 #define RVH RV('H')
 #define RVG RV('G')
 #define RVB RV('B')
+#define RVX RV('X')
 
 extern const uint32_t misa_bits[];
 const char *riscv_get_misa_ext_name(uint32_t bit);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 752eee32289..61d7666288e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1181,6 +1181,20 @@ static void riscv_cpu_update_misa_c(RISCVCPU *cpu)
     }
 }
 
+/* MISA.X is set when any of the non-standard extensions is enabled. */
+static void riscv_cpu_update_misa_x(RISCVCPU *cpu)
+{
+    CPURISCVState *env = &cpu->env;
+    const RISCVCPUMultiExtConfig *arr = riscv_cpu_vendor_exts;
+
+    for (int i = 0; arr[i].name != NULL; i++) {
+        if (isa_ext_is_enabled(cpu, arr[i].offset)) {
+            riscv_cpu_set_misa_ext(env, env->misa_ext | RVX);
+            break;
+        }
+    }
+}
+
 void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 {
     CPURISCVState *env = &cpu->env;
@@ -1189,6 +1203,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     riscv_cpu_init_implied_exts_rules();
     riscv_cpu_enable_implied_rules(cpu);
     riscv_cpu_update_misa_c(cpu);
+    riscv_cpu_update_misa_x(cpu);
 
     riscv_cpu_validate_misa_priv(env, &local_err);
     if (local_err != NULL) {
-- 
2.43.0


