Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE5FEDF026
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 03:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqNTZ-0007i1-9P; Wed, 11 Feb 2026 22:34:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vqNTX-0007hK-JG
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 22:34:43 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vqNTW-0008H5-34
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 22:34:43 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d189e5b05eso3103076a34.0
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 19:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770867280; x=1771472080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xRXKnuEh2uHJat43zyXFYeTE1jG7/LV3dKmllN9ZhII=;
 b=ckoSkvOhTpn8nHaMST198ARZ7VDlXPn6ooPdCh36SnRAAakHHAGAF1p9wtVk6/0ad7
 enXvscUM0nUsChsyZhMVe8aswHqh+TmGBsERZq6sqGsUvm+lTVooYQp/Oo3vv8RyHHhk
 tWOkDCMpqQDr3gULZGOuWNsBmSttM+rbr/H9qdmrGKCScyNrDNWCQZUVEpKrCJFogmb3
 w24ZfjjuoMxdsuc6cWVRr30AbGY8z25KxWZpdJf9Ov7BvlP4L+n8AG0A8yWW5PcR8QRz
 TTnjaPIM3LYx0x5/Wm7yesZbQPOJ2w3qqRdEz4Brk0nPxYDRYdcyM4l+LgJ5qkiBTfOD
 ytwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770867280; x=1771472080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xRXKnuEh2uHJat43zyXFYeTE1jG7/LV3dKmllN9ZhII=;
 b=HovnY2NCcMKc7S2gxM9bVM5zKahJMDdsvQzqFj/qeSgcKhseahZkBuLYGyu3h0wjXy
 brQh+JQfpUwUL3s9tRZ3r/o6T3m/vXnxyaLxKgSKNanfE94MGHwwDGtYnjgNngUSmL7H
 4cb739eXaa7W1w388xIhPJrDl32kxCdY29oVfx92IrQkVAvgrJaSjC2V/Oe5vrYmbrXP
 U1bwMLdp392T/VpufR1MVcuzM2En6YXqN+en2ifjoD8nucbqRQkNAj6EBe6lWnatIMGH
 gaiezBqXJDTG/7lRawhwMHroDYSTIQBvTOHWq/lRQ8QvlwwDRQ4iHc1BRaEmZcoFZUXB
 cjxA==
X-Gm-Message-State: AOJu0YxONTQLxK9WNwJ3iFQsIpQDQkF+HJ55j/CWcapStsfhtlaZ7tyU
 bi19tcd3QzSY5CCI7XeHw13OZGL7+ikoWstjl4GR51coR2uw5RIXOwdwtLG8eQ==
X-Gm-Gg: AZuq6aKoEzmWodtdkjBjvSnm05hi7Rji9fA6qtpMqZWd4dhEuAqAAZ5IlL56+56ynM1
 YNVRLS3xEKLy8nfzRc0TYSS0hLdkcZ2RV5WHWABJGFEezITROAPDTSPVmHg7sefY3m3TVlEo95D
 ej6qOOhbIoWbFVkERFcsKvsqCDDvJ3hQcK4Nn/UIJlCoM2oVkY6LKrfHwiJ17unmE3B7tnIK/CX
 XYcesw1XUOJOn37bqwlYGWVsxj9lauOqtq/TUn4v15MpLHWuaw+A2NzoXLz65JAo3NiziwOifmF
 y8Dsa7QuMMD7QgXq7WWGxtwz4Wf0fTF9eT3RtythlUEt6S0loqxk+y0bSySbSBDfmP/YWfl3Lcz
 d6LQl7NsLumzWVKVJppKlwrjYiKuWApiPEBWltdsgaTCH8+am9oq10a9Wby0L2vcxX23S+3cpFe
 v2UI5047W499qHPO3kciyW+vVirb1u5iOaUsHf9n8lvrGBhTImBuz3azdrE0ZHAkAIjMNvsk2DI
 7NCuAp2eRsAdRoH
X-Received: by 2002:a05:6830:2650:b0:7cf:cb09:b7e8 with SMTP id
 46e09a7af769-7d4b2b1d5eamr741931a34.36.1770867280515; 
 Wed, 11 Feb 2026 19:34:40 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76e1b0csm2682858a34.14.2026.02.11.19.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 19:34:40 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH 1/8] Hexagon (target/hexagon) Properly handle Hexagon CPU
 version
Date: Wed, 11 Feb 2026 20:34:28 -0700
Message-ID: <20260212033435.3598-2-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212033435.3598-1-ltaylorsimpson@gmail.com>
References: <20260212033435.3598-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the following CPU versions that were previously missing
    v5
    v55
    v60
    v61
    v62
    v65

Create an enum with the known Hexagon CPU versions
Add a field to HexagonCPUClass to note the Hexagon CPU version

Co-authored-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/cpu-qom.h | 21 +++++++++++++++++++++
 target/hexagon/cpu.h     |  2 ++
 target/hexagon/cpu.c     | 28 ++++++++++++++++++++++------
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/target/hexagon/cpu-qom.h b/target/hexagon/cpu-qom.h
index 0b149bd5fe..830a2f8cf8 100644
--- a/target/hexagon/cpu-qom.h
+++ b/target/hexagon/cpu-qom.h
@@ -11,11 +11,32 @@
 
 #include "hw/core/cpu.h"
 
+typedef enum {
+    HEX_VER_V5 = 0x04,
+    HEX_VER_V55 = 0x05,
+    HEX_VER_V60 = 0x60,
+    HEX_VER_V61 = 0x61,
+    HEX_VER_V62 = 0x62,
+    HEX_VER_V65 = 0x65,
+    HEX_VER_V66 = 0x66,
+    HEX_VER_V67 = 0x67,
+    HEX_VER_V68 = 0x68,
+    HEX_VER_V69 = 0x69,
+    HEX_VER_V71 = 0x71,
+    HEX_VER_V73 = 0x73,
+} HexagonVersion;
+
 #define TYPE_HEXAGON_CPU "hexagon-cpu"
 
 #define HEXAGON_CPU_TYPE_SUFFIX "-" TYPE_HEXAGON_CPU
 #define HEXAGON_CPU_TYPE_NAME(name) (name HEXAGON_CPU_TYPE_SUFFIX)
 
+#define TYPE_HEXAGON_CPU_V5 HEXAGON_CPU_TYPE_NAME("v5")
+#define TYPE_HEXAGON_CPU_V55 HEXAGON_CPU_TYPE_NAME("v55")
+#define TYPE_HEXAGON_CPU_V60 HEXAGON_CPU_TYPE_NAME("v60")
+#define TYPE_HEXAGON_CPU_V61 HEXAGON_CPU_TYPE_NAME("v61")
+#define TYPE_HEXAGON_CPU_V62 HEXAGON_CPU_TYPE_NAME("v62")
+#define TYPE_HEXAGON_CPU_V65 HEXAGON_CPU_TYPE_NAME("v65")
 #define TYPE_HEXAGON_CPU_V66 HEXAGON_CPU_TYPE_NAME("v66")
 #define TYPE_HEXAGON_CPU_V67 HEXAGON_CPU_TYPE_NAME("v67")
 #define TYPE_HEXAGON_CPU_V68 HEXAGON_CPU_TYPE_NAME("v68")
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 656b7dc044..071fc2b6b7 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -117,6 +117,8 @@ typedef struct HexagonCPUClass {
 
     DeviceRealize parent_realize;
     ResettablePhases parent_phases;
+
+    HexagonVersion hex_version;
 } HexagonCPUClass;
 
 struct ArchCPU {
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 58a22ee41f..09a0de3c2f 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -27,12 +27,22 @@
 #include "exec/gdbstub.h"
 #include "accel/tcg/cpu-ops.h"
 
-static void hexagon_v66_cpu_init(Object *obj) { }
-static void hexagon_v67_cpu_init(Object *obj) { }
-static void hexagon_v68_cpu_init(Object *obj) { }
-static void hexagon_v69_cpu_init(Object *obj) { }
-static void hexagon_v71_cpu_init(Object *obj) { }
-static void hexagon_v73_cpu_init(Object *obj) { }
+#define HEX_CPU_INIT(NAME, VER) \
+static void hexagon_##NAME##_cpu_init(Object *obj) \
+{ HEXAGON_CPU_GET_CLASS(obj)->hex_version = VER; }
+
+HEX_CPU_INIT(v5, HEX_VER_V5)
+HEX_CPU_INIT(v55, HEX_VER_V55)
+HEX_CPU_INIT(v60, HEX_VER_V60)
+HEX_CPU_INIT(v61, HEX_VER_V61)
+HEX_CPU_INIT(v62, HEX_VER_V62)
+HEX_CPU_INIT(v65, HEX_VER_V65)
+HEX_CPU_INIT(v66, HEX_VER_V66)
+HEX_CPU_INIT(v67, HEX_VER_V67)
+HEX_CPU_INIT(v68, HEX_VER_V68)
+HEX_CPU_INIT(v69, HEX_VER_V69)
+HEX_CPU_INIT(v71, HEX_VER_V71)
+HEX_CPU_INIT(v73, HEX_VER_V73)
 
 static ObjectClass *hexagon_cpu_class_by_name(const char *cpu_model)
 {
@@ -395,6 +405,12 @@ static const TypeInfo hexagon_cpu_type_infos[] = {
         .class_size = sizeof(HexagonCPUClass),
         .class_init = hexagon_cpu_class_init,
     },
+    DEFINE_CPU(TYPE_HEXAGON_CPU_V5,               hexagon_v5_cpu_init),
+    DEFINE_CPU(TYPE_HEXAGON_CPU_V55,              hexagon_v55_cpu_init),
+    DEFINE_CPU(TYPE_HEXAGON_CPU_V60,              hexagon_v60_cpu_init),
+    DEFINE_CPU(TYPE_HEXAGON_CPU_V61,              hexagon_v61_cpu_init),
+    DEFINE_CPU(TYPE_HEXAGON_CPU_V62,              hexagon_v62_cpu_init),
+    DEFINE_CPU(TYPE_HEXAGON_CPU_V65,              hexagon_v65_cpu_init),
     DEFINE_CPU(TYPE_HEXAGON_CPU_V66,              hexagon_v66_cpu_init),
     DEFINE_CPU(TYPE_HEXAGON_CPU_V67,              hexagon_v67_cpu_init),
     DEFINE_CPU(TYPE_HEXAGON_CPU_V68,              hexagon_v68_cpu_init),
-- 
2.43.0


