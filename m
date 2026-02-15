Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBC4E63F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 22:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrkEJ-0005XA-3z; Sun, 15 Feb 2026 17:04:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vrkEF-0005Ve-Ez
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 17:04:35 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vrkED-00051h-J9
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 17:04:34 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-45f053b7b90so1737449b6e.0
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 14:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771193066; x=1771797866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aBj+PJapUP53A+URWnuk2XhCH08ytxjfqnXbU+6yJx4=;
 b=afQ8rXxtdwTMEh8oZIcFS2KanNCJ2A+2ewp//Gqv2ENKCHOiN0/046aMoH1mAPmXhM
 dFUPSut2imPr8IlHI5FIW7RH2KTlkcDA64mTGCVVZzoQpOPKBxzVPkS/qVLrRH9uZyK4
 g6SNtwtxOPcpgmQAGpNeSEPn+G5EPJYPm+FjCElq3r2HgI+JQDB2bnP9t79Wz9X1z8cq
 zRUoDmP/WnYnNxa9Yu1KoBOwjT8Z/aRnUZuFO0pARHwg97I5tqVD6EEAOw5XlE45/TO9
 Xz/SDdtvZm0i1a08tzvAmR8D+itwUExO5F9waIm4+2TPGaPIC/vnXJtVFyh8fmPSJbZ/
 v2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771193066; x=1771797866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aBj+PJapUP53A+URWnuk2XhCH08ytxjfqnXbU+6yJx4=;
 b=O9LrWDdQ76F2oxfjAGyv440nPgElyKrSlcf1GSMo3gHIge8d6rmWRXkWttQrS+to+Z
 Z1bc0VP4lWFBY19vYWaP3AnIVpH/YI8yEgRiou5i4ZdsNNpxXIhIXEaE4FbX7gudzuNv
 OeFSb1jqFfJud+WSfLpHf7V57M0SOQzHbog98wvxc+Xg9InqCyVR/U0enQZ7CBdwVxsE
 2ew0noMGAehc8AFM5K5divmyK7j2aTnctlp1JAfK7m/zAWv1krIpFSfcKGC0Zmv1eSP8
 Q9ImyB4cjWFR/uUs7/xo9PbkZjsXz9OTtp4ytkUAOVcC/7We0FyoDyxOuMy2X9BWgpPu
 6gXA==
X-Gm-Message-State: AOJu0YzhF2PxLf5yWo6AU2ohettqNb1yJwlr+WLcDm6ZzMN+5ufnihLy
 9WVKamH1x3ZFXRpvRNfMaDKzymdDaOW8bz8T1UGLXsYCUNVo5rAemfDSWxma9Q==
X-Gm-Gg: AZuq6aITVuQfNxjNw9KamPe1oiY7TjoWlj9YkVucHqEDfh9KO7tYJMxE0Jd09vo7913
 X2Rc87zjazls8TsZjkHSC79GpsRwvR5bDv12gDgjJO+0bu3fNwk3mmnlhGhaSHyEPYaO0zSVY3i
 zGOZ488n5BWwZHk2L5FhELhppQDhyQ7FjrPjV4eH65ln32t5/w12Xm93rxkHGusbConH1KghPm4
 F1i0GDtjnp8A904ngoUfYPmzgJiP83n3eg8qO3zp8GgAcxKmhr4y49hnJYH2uO/gz9cWNI0U3IW
 YaCIhHMfG7QewYVlLilYYzwB5GIxE/8jH3h69jtn1B/tbyme63YcDoKMbVguRjXAQ0n0j1X4/ou
 pQx8WTg7kdJoiRhf84BP34bOCiTGjna+wC5i6gQOH2/7v9UVmtbgiwFMR/iMxkbNkdw3/JtxYmD
 gp7xMv5w+ih/mSINaiPBSnIE6PtOuX2o0Fp9R40fo5yheWzUeeIIlGKjqAvZsM7AmhH/m+XeHd2
 JqusPUxBosK2VjI
X-Received: by 2002:a05:6808:5142:b0:462:de55:9d48 with SMTP id
 5614622812f47-4639ef195e7mr3830356b6e.1.1771193066372; 
 Sun, 15 Feb 2026 14:04:26 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaf101db0sm13556664fac.12.2026.02.15.14.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 14:04:25 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH v2 1/8] Hexagon (target/hexagon) Properly handle Hexagon CPU
 version
Date: Sun, 15 Feb 2026 15:04:15 -0700
Message-ID: <20260215220422.212249-2-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260215220422.212249-1-ltaylorsimpson@gmail.com>
References: <20260215220422.212249-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x236.google.com
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
 target/hexagon/cpu-qom.h | 23 +++++++++++++++++++++++
 target/hexagon/cpu.h     |  2 ++
 target/hexagon/cpu.c     | 28 ++++++++++++++++++++++------
 3 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/target/hexagon/cpu-qom.h b/target/hexagon/cpu-qom.h
index 0b149bd5fe..d2f98c683a 100644
--- a/target/hexagon/cpu-qom.h
+++ b/target/hexagon/cpu-qom.h
@@ -11,11 +11,34 @@
 
 #include "hw/core/cpu.h"
 
+typedef enum {
+    HEX_VER_NONE = 0x00,
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
+    HEX_VER_ANY = 0xff,
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
index 85afd59277..2b8e761c4d 100644
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


