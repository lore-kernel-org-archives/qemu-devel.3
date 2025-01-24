Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851BFC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbFdS-0005qG-Ql; Fri, 24 Jan 2025 04:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tbFdR-0005po-Bd
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:05:53 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tbFdP-0007cQ-Qb
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:05:53 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-216634dd574so22714565ad.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1737709550; x=1738314350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DiqkhodxlgaG5f3W+fdsVvVKaK/k4IU2znZnb436zgQ=;
 b=XXJ0c9AGtdTA2kHq64hEUbMZ1wbkA7uw7x0FfMnB661ktFJ9Zlr9kKsny9eK1rOEvp
 itgW/H0vJySPLqieGhvAHqUevqs08ZHER1BnNebmw4hzTWymv4/T6e9nHZA0+M+Coyjp
 IIt27cH2FZCNPRWGt8lztGvxwFpbbbUSOIs6g/6qKU5Wg/DundwdXcYE0R+gKHjPrHV4
 2D5PnbBeYs+T0O1ZtQ58VLQ+VGJUFuit45O7lEmk/IWQrdQXzdgW7GVBkwxPiLKg7F34
 d96cBiJEgjzYPoR1HXNKhurl1NSI6ViBiFKYQHPangknZazYBmRg7kdELk7gd4iFIQpc
 4iGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737709550; x=1738314350;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DiqkhodxlgaG5f3W+fdsVvVKaK/k4IU2znZnb436zgQ=;
 b=IkNj8xv8JFxgsRpUU66Es+PD1jkewCBbFuXMZfeaj5xsx9Nctn6+smZ+rD8Yn4mo81
 FBj+BftRG/FM1BM32bgqD7l49WAkvoe3RU88OL6waBR7yPToBrkI6eDRtBC/fV6gumq5
 JdIHy79zDsOoC0A6E4Mv95GhhwpRwA/rvAsX8x+uFO3UjUL2qktU7WFHEoxViTR1A6rP
 vkjJMRLAGD8VXW13vAmTt3mqf7aFCqzBSVgQaLBBA41f/FeCo1aHu8b2I0cNPAAJA3f8
 ybVEOYKvsL87GkLxhCp1DlqQ63lSZoj/bczMWaONhdHWHKep2O/WgdVvvBKht9uqidAX
 rowA==
X-Gm-Message-State: AOJu0YyK/CzMjbrg2hq7cFa3mHrTy0alxV9ZNMJrketrR5MKw8SEn9y8
 LNmWm7aw8He7mzEM/5+l1sa/VV8eB/mUkXy+NC1/l7sCxIvNL/rE9O++ID7pbTIbW/KPWlYcmZW
 FjJuzc7Lz10jZy6IMDlVaToSnQrsRtYxALkGlFxgbLc1fN2VgNi10dtRMIDByH4El/eazH9xSN7
 sD3idPpvkkjl8qD4LkKKqGUZTcorY+C/vPe6Ev7w==
X-Gm-Gg: ASbGncugWYqJvf5DJ2m8yvGoXoBOal8U8prKO4kmcWGv0eszvQMOAdfvL68r/IBiIs5
 bYdk/pAjjmbcoBEzWUEeWrydPknzidhgqKawgRXfUkYtAs8yWJkcRDXlK9XAtx67C6V0actYsFg
 Kk13M1Rqpe2vQBmuuuZ0puYQg6oHj7TJMnx8cBAYghuSvsbxD2KF5nSwaH5txQ5ABzjFJyUJiKg
 +bTQVFRykV0sTarj1HlA3MRNovtwrIyclwrHux2XvzhcFsRy4A9gbWe92Y3RBnRvznf8j/+evTm
 sdWx45rr3c5657yUmDW+/tib9w38b8r7NPedvjAb3YiCZ9atnA==
X-Google-Smtp-Source: AGHT+IGg7sy4Qx//uj8busZ4yeVErd5dWFBIcVRX9nSoNaPvDpdg676uaqV97tJU4lzWfHSiTG02Kw==
X-Received: by 2002:a17:902:c411:b0:216:84e9:d334 with SMTP id
 d9443c01a7336-21c35577e88mr407045865ad.33.1737709548608; 
 Fri, 24 Jan 2025 01:05:48 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ac48f897f8dsm1150655a12.22.2025.01.24.01.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:05:48 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH] target/riscv: rvv: Fix incorrect vlen comparison in
 prop_vlen_set
Date: Fri, 24 Jan 2025 17:05:38 +0800
Message-Id: <20250124090539.2506448-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62e.google.com
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

In prop_vlen_set function, there is an incorrect comparison between
vlen(bit) and vlenb(byte).
This will cause unexpected error when user applies the `vlen=1024` cpu
option with a vendor predefined cpu type that the default vlen is
1024(vlenb=128).

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3d4bd157d2c..2f53acbab59 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2034,6 +2034,7 @@ static void prop_vlen_set(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
+    uint16_t cpu_vlen = cpu->cfg.vlenb << 3;
     uint16_t value;
 
     if (!visit_type_uint16(v, name, &value, errp)) {
@@ -2045,10 +2046,10 @@ static void prop_vlen_set(Object *obj, Visitor *v, const char *name,
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
2.34.1


