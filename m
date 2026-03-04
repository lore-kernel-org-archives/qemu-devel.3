Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1328CEF8FE1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmEB-0006eJ-TL; Wed, 04 Mar 2026 08:25:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmE9-0006dL-Kx
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:25:25 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmE7-00022E-VG
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:25:25 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-827270d50d4so7218019b3a.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772630722; x=1773235522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KYaM3deaXWKjXESkvf/AADIweQOeQAjqnNUZ5ZKK2dY=;
 b=J5V64qnjp4qpqSinn8KBKFR32CYgZOO/Yo7z+iwSvbSKLX/NHA8EEIAAUKLAeq1lLl
 qGnHLzThL9bHdLTPXi/3XXD83bzr4cl5+LHHW8mZaDrjTb8+hMU7Y8iPjZWepBL8RyRU
 GOmXD5Xl+dH/ipF0ZSkt5qrgdflNhy1BLhUGlIMVuCjJobeZq5709aEMghSZHhKPR49l
 UeO57BfIbC6gS6B9yixUth3nmAeu75a08RIVVBb0mBXFQkEf4AC192pfJ+s7n0ivV+KI
 QaxPMEZlRBtarHjtL/Qhm0CJsKVuSN3BfjAiIZQwT7VcZBAEBbJdqXA403NO5hdyZRP8
 T97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772630722; x=1773235522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KYaM3deaXWKjXESkvf/AADIweQOeQAjqnNUZ5ZKK2dY=;
 b=eq+W/oML53/0ukL73/1rdDc+YFkqMgyOM6CBRg883gJJNwMoTpLoR1P05vK6skwM7K
 8ZfEjDeNNBeIJyYnDXTh0nuo8T8tY6UIzD0pDlNxsL1SwofBNLT+QNWyXaIclA6gVjJ8
 G/MwcGkDd7q3jMiDVjV7C9wbsEY6wfNbrqMzKu6jO3ccctvN9290EXl1YEeld1qbd1gm
 /7xR+XQe9xtQCj+ydWlcsPxX8plmWEtYzWF4p8UqYI0Qx6/2KWQ8+EPIBAYJgu9zvg8H
 9NYaDS/FhepRNC41ZlcWNhz8ZBA1xTzCPsF95rsYrwDagpd2YCOEh5EddPuX/7GET1Sv
 +gpg==
X-Gm-Message-State: AOJu0YwPodau5yVJLFSRZoNfNtVRenahYTGeZMNNUjEj7lXFWBjkRkci
 FMxBYu1VZ/uQDArfncGAooaZA8N4Ap8hEsBy4BEVhMeW1vyLaE7J0p35ePNRr8xYl/9iWziSxAb
 OwoGqWf7c9OuXCKHwXQE+9/pBpwxWI78hphB34qNh8oefKXN13Lo2Z7o+Ybh7gPBa9Zda60ViOX
 rKGC+3KzctP3EPk6oEWK1TIEPWq8KD8xPA5W5bW7jCPg==
X-Gm-Gg: ATEYQzwZfDCsfqOELeiqIlOAG9SGqU8v23gDo6zp4TpQQ2P1+1QGNBsU3xVsKe8Fljd
 jipnNDch9sPfGU93JJONwvz/wuMhtsUw6yFeme77QjYke9Z3v1YnFmzZB8cnHkSwUehNJARrNmL
 JUiL0rEPLjIBedP96WRehiSKwB4KMJGlQauORCdLm9ienLeXIUHjosD30Hr0lZ7uZ0Dz6tSHQz7
 f1UpTklGGMuKNSHBmeiWKMQPrnP8I+md6ez9qHvnPdoz91f8b8VliHARNiqREz1vpIgxzoxTaoX
 WpQFoO4oOyZWxhzCnTMpGonlQSbqRLppKAz//vN/hgeQmL567FCDtXAuHKsZ+VlLSGcCNTHwS1Q
 C50Xhse2H8iucCrfSwDaH6kd2PVx553PNLd+vI0GN5zue4lIYl63zaf1wFyYacaHIa5uTrxFMzw
 /JQOxd3lcQMO1ZRosmpi6C4cBpQCAY5EFZ/6jYtAMeOg/xTMFZEY8Ug1tCnZLGftyl6PG6GuAmt
 7oW8u/Y2/OAOGBRrJgmEXZkQhRQFpt7pJE2xQ==
X-Received: by 2002:a05:6a00:2303:b0:827:3883:7318 with SMTP id
 d2e1a72fcca58-82972c32365mr2212375b3a.31.1772630722326; 
 Wed, 04 Mar 2026 05:25:22 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739db1d6dsm16968505b3a.26.2026.03.04.05.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:25:21 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v4 1/9] target/riscv: Add cfg properities for Zvfbfa extensions
Date: Wed,  4 Mar 2026 21:25:05 +0800
Message-ID: <20260304132514.2889449-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304132514.2889449-1-max.chou@sifive.com>
References: <20260304132514.2889449-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42e.google.com
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

The Zvfbfa extension adds more complete BF16 vector compute support
and requires the Zve32f and Zfbfmin extensions.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                | 1 +
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/tcg/tcg-cpu.c        | 8 ++++++++
 3 files changed, 10 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9be79622f4..2ddc26c837 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -189,6 +189,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zve64f, PRIV_VERSION_1_10_0, ext_zve64f),
     ISA_EXT_DATA_ENTRY(zve64d, PRIV_VERSION_1_10_0, ext_zve64d),
     ISA_EXT_DATA_ENTRY(zve64x, PRIV_VERSION_1_10_0, ext_zve64x),
+    ISA_EXT_DATA_ENTRY(zvfbfa, PRIV_VERSION_1_13_0, ext_zvfbfa),
     ISA_EXT_DATA_ENTRY(zvfbfmin, PRIV_VERSION_1_12_0, ext_zvfbfmin),
     ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 70ec650abf..3696f02ee0 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -99,6 +99,7 @@ BOOL_FIELD(ext_zvks)
 BOOL_FIELD(ext_zvksc)
 BOOL_FIELD(ext_zvksg)
 BOOL_FIELD(ext_zmmul)
+BOOL_FIELD(ext_zvfbfa)
 BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 988b2d905f..720ff0c2a3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -720,6 +720,14 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvfbfa) {
+        if (!cpu->cfg.ext_zve32f || !cpu->cfg.ext_zfbfmin) {
+            error_setg(errp, "Zvfbfa extension requires Zve32f extension "
+                             "and Zfbfmin extension");
+            return;
+        }
+    }
+
     if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
         error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
         return;
-- 
2.52.0


