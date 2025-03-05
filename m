Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42937C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdx8-0001WJ-Fi; Tue, 04 Mar 2025 20:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdx4-0001U7-KU
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:40 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdx1-0008Mm-UR
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:37 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-223594b3c6dso108662695ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139614; x=1741744414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZBEKcLD/t7V+wqyWsb5h8cuBdhinzK3N2UdwWuTfii4=;
 b=MHA9k3p164NDUpcEpIflfWQsQtkXW2O5AimW19JXBsKiWVNxiVOVxpNi9alXu6Ek2E
 sDD8c3hSqtTEsVk9OoPuIzLA2CkTSYnMXazlSkoYSZJ2NuNxfgWTVTvCYBnTqnR4USmR
 DB2ELyxir949eMOoJtuaxUpmcIEvZqo9DVF33yyfqId4fhiwT9DWVoqm7omUGsbeeb3k
 uPBdI+5JxuzMPKcwVb92M1pRjlvcePZvVW4mAuUqknSNhUjVQ8fa/mRCpsZHeRKbuMyC
 LjWG2roGbW/3C7iDc08L6V4Z5ZQO1egpc6oISwISoJTEKy3pnanIicxu/UsDCRhqOrAg
 xQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139614; x=1741744414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZBEKcLD/t7V+wqyWsb5h8cuBdhinzK3N2UdwWuTfii4=;
 b=EPvoAabSV4GW3TCrLF/UONLIPfE4xS6PD1A+2D2xIPul1S2I2ckGle/EQoEE01NKc6
 PU1Nbef36ysG9kSnNAMHf7C2x6QF0jUZAk1y1NGbD5P0q2MceOoYeeu9fHOvng8XemzF
 v0SDHha4NUA5Lv4aHCy1pKJhAI4hn8ueCTtJKQShiG3hAtlQ7c3b3YChvuHPTJWC288Q
 pJY+mLJuikbLUrp3Ykb0/qqzLFESp77c7bgBgD0NIhEUzXoqBVE/4yOyrYhql1YVXtI7
 KQHnVWpQ/zH5Yv1PxO24c0EffjDCzJNkbeZBqbEZEj326rII1yvlM0e2aK0lWDqu8Hv0
 lGZg==
X-Gm-Message-State: AOJu0YyJYHjn7RCixrX/I1N0p9K14w3jtbJzylPY08qPFjlKZy9idPwy
 XZs2sM9aHnAo5VgUiqPjilSIABcy1sP9B9T8uYF1qVo/XNMy1fmjSzl8/3WWels=
X-Gm-Gg: ASbGncsAcy232ISjLdDEUNJ4riT0jIikNh9D0kbvfYi31xH78qrEgjZSJLGDn5FjK+h
 CP7iYVEL4PPoLFa8VzMq1phlY+La7Y9GHR1iydm9ZCFsEKNN+cWDOGQlW+NOmSJtO5KgwCvmIpL
 xlmbtlVYGriUguHyTQ4ECTDOhz62+EvLQ7oE6ChNqOAiqhwQLlC80qURQoZ1aBbpnudkHFL/gjz
 wmdPu6YiAoc8MYmvLG3mk+YZN5AeIGkse5Y38d1x0wxpLcVZINaUWSuxfAAKxM6tm7qUP+hT5ZE
 UlXNU6o31lf0p4gnKmma4IMB2SPEnXjt2Gi+i9padJ3xPgiV4GLMDNug3+9inbrKPFyeIxejFJk
 cpTbBstkV42PiD7aeGOndTtQW2tzL6KY67EzXA6jqTKfiq+J2yi0=
X-Google-Smtp-Source: AGHT+IFMx0l8OZiOIOFDePTBbTjc2CJW1ir5fVrQjEFoqwnVnp6ujy0FcaQdddAfkmpbtMed5dsdag==
X-Received: by 2002:a17:902:e751:b0:21b:d2b6:ca7f with SMTP id
 d9443c01a7336-223f1d6ce53mr21187765ad.32.1741139614074; 
 Tue, 04 Mar 2025 17:53:34 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:53:33 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 07/59] target/riscv: rvv: Fix incorrect vlen comparison in
 prop_vlen_set
Date: Wed,  5 Mar 2025 11:52:15 +1000
Message-ID: <20250305015307.1463560-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
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

From: Max Chou <max.chou@sifive.com>

In prop_vlen_set function, there is an incorrect comparison between
vlen(bit) and vlenb(byte).
This will cause unexpected error when user applies the `vlen=1024` cpu
option with a vendor predefined cpu type that the default vlen is
1024(vlenb=128).

Fixes: 4f6d036ccc ("target/riscv/cpu.c: remove cpu->cfg.vlen")
Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250124090539.2506448-1-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d7ecf729d0..99436f1750 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2027,6 +2027,7 @@ static void prop_vlen_set(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
+    uint16_t cpu_vlen = cpu->cfg.vlenb << 3;
     uint16_t value;
 
     if (!visit_type_uint16(v, name, &value, errp)) {
@@ -2038,10 +2039,10 @@ static void prop_vlen_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (value != cpu->cfg.vlenb && riscv_cpu_is_vendor(obj)) {
+    if (value != cpu_vlen && riscv_cpu_is_vendor(obj)) {
         cpu_set_prop_err(cpu, name, errp);
         error_append_hint(errp, "Current '%s' val: %u\n",
-                          name, cpu->cfg.vlenb << 3);
+                          name, cpu_vlen);
         return;
     }
 
-- 
2.48.1


