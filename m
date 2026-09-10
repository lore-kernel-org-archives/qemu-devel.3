Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AD2C79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4kUm-0003aD-I2; Thu, 10 Sep 2026 15:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4kQl-0002Le-7P
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:27:32 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4kQQ-0004d4-Lu
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789068348; x=1789673148; i=deller@gmx.de;
 bh=ptcJhfomH/bRpx9QW4fglW83w+d1nMh9Cml7QzkflFY=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Fl5OHRs4Gmv2cVEBqsEPJLjqvdrtaLzTq6qh2H0Jnf5CL8kObyawEvJDouzlOJ/Z
 JyosDzaWc8h9uMKUeEi+O7luuaYpP64CeySjaphpsx+lTDUdSL4k6JQHWK5gOxZhj
 JSCzxZ1GQOfKvxuade0PEn+ohdmQ/64Mu6rvfhSv0/0fxgAe6fomSHrWZVkUM9CNT
 hK/TTJdIsl04El8WPttzTWrX/Npw5frZEdUJ728V7Jy9/i9xbeeTUdeR+01YZu6Xh
 4XlF5Y4ta5fNleECUJ7hUBXIncKrKIv36vPwpSfOOSkZPIzH2RT3wJpAnnofmcdH6
 Atlx/bd9qqz7AJlRtA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgesQ-1wdPOa2jrY-00euxM; Thu, 10
 Sep 2026 21:25:48 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Zhao Liu <zhao1.liu@intel.com>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 2/7] linux-user/hexagon: Add HWCAP support
Date: Thu, 10 Sep 2026 21:25:39 +0200
Message-ID: <20260910192545.768850-3-deller@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910192545.768850-1-deller@gmx.de>
References: <20260910192545.768850-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J6pOsmrqDrQYay1K9/+1zOb+Sua7gi8ZIgkkj4mM3zaYrKqLhlD
 E+aClL1HRregri9Z/PY3U6krMkbwZxfcUiiQ0WDr+D3uHhiFsikllSnahvdyIPcUCpXRkzW
 mj9GXKmusa1fpO89WbG9NYHbx9z4o8YBVZoGp4e0nVVj/YFl8PYjBSY3X7oOYykz9mUN0Ji
 G55BNbnC7wvCyUHuxohFw==
UI-OutboundReport: notjunk:1;M01:P0:fWV9WWCMq4M=;vEmdGptIzfHVWWwEOd5uN88d0iJ
 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
 TPi3Azn7kmmcJ7iECW6w7aAOaVAd2Y7Y5wQ==
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

From: Brian Cain <brian.cain@oss.qualcomm.com>

Link: https://lore.kernel.org/linux-hexagon/20260910003346.596593-1-brian.=
cain@oss.qualcomm.com/
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/hexagon/elfload.c    | 61 +++++++++++++++++++++++++++++++++
 linux-user/hexagon/target_elf.h | 30 ++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/linux-user/hexagon/elfload.c b/linux-user/hexagon/elfload.c
index 39b0201814..3d19a711f8 100644
=2D-- a/linux-user/hexagon/elfload.c
+++ b/linux-user/hexagon/elfload.c
@@ -3,8 +3,69 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "target_elf.h"
+#include "target/hexagon/cpu.h"
=20
=20
+abi_ulong get_elf_hwcap(CPUState *cs)
+{
+    HexagonCPUClass *mcc =3D HEXAGON_CPU_GET_CLASS(cs);
+    abi_ulong hwcaps;
+    uint32_t hex_ver;
+
+    if (!mcc->hex_def) {
+        return 0;
+    }
+
+    hex_ver =3D mcc->hex_def->hex_version;
+    switch (hex_ver) {
+    case HEX_VER_V5:
+        hwcaps =3D HWCAP_HEXAGON_ISA_V5;
+        break;
+    case HEX_VER_V55:
+        hwcaps =3D HWCAP_HEXAGON_ISA_V55;
+        break;
+    case HEX_VER_V60:
+    case HEX_VER_V61:
+        hwcaps =3D HWCAP_HEXAGON_ISA_V60;
+        break;
+    case HEX_VER_V62:
+        hwcaps =3D HWCAP_HEXAGON_ISA_V62;
+        break;
+    case HEX_VER_V65:
+        hwcaps =3D HWCAP_HEXAGON_ISA_V65;
+        break;
+    case HEX_VER_V66:
+        hwcaps =3D HWCAP_HEXAGON_ISA_V66;
+        break;
+    case HEX_VER_V67:
+        hwcaps =3D HWCAP_HEXAGON_ISA_V67;
+        break;
+    case HEX_VER_V68:
+        hwcaps =3D HWCAP_HEXAGON_ISA_V68;
+        break;
+    case HEX_VER_V69:
+        hwcaps =3D HWCAP_HEXAGON_ISA_V69;
+        break;
+    case HEX_VER_V71:
+        hwcaps =3D HWCAP_HEXAGON_ISA_V71;
+        break;
+    case HEX_VER_V73:
+        hwcaps =3D HWCAP_HEXAGON_ISA_V73;
+        break;
+    default:
+        return 0;
+    }
+
+    hwcaps |=3D HWCAP_HEXAGON_HVX;
+    hwcaps |=3D HWCAP_HEXAGON_HVX_LENGTH_128B;
+    if (hex_ver >=3D HEX_VER_V68) {
+        hwcaps |=3D HWCAP_HEXAGON_HVX_IEEE_FP;
+    }
+
+    return hwcaps;
+}
+
 const char *get_elf_cpu_model(uint32_t eflags)
 {
     static char buf[32];
diff --git a/linux-user/hexagon/target_elf.h b/linux-user/hexagon/target_e=
lf.h
index f81ae3895a..90e5032d5a 100644
=2D-- a/linux-user/hexagon/target_elf.h
+++ b/linux-user/hexagon/target_elf.h
@@ -21,4 +21,34 @@
 #define ELF_CLASS               ELFCLASS32
 #define ELF_MACHINE             EM_HEXAGON
=20
+#define HAVE_ELF_HWCAP          1
+
+enum {
+    HWCAP_HEXAGON_ISA_MASK          =3D 0x7F,
+    HWCAP_HEXAGON_ISA_V2            =3D 1,
+    HWCAP_HEXAGON_ISA_V3            =3D 2,
+    HWCAP_HEXAGON_ISA_V4            =3D 3,
+    HWCAP_HEXAGON_ISA_V5            =3D 4,
+    HWCAP_HEXAGON_ISA_V55           =3D 5,
+    HWCAP_HEXAGON_ISA_V60           =3D 6,
+    HWCAP_HEXAGON_ISA_V62           =3D 7,
+    HWCAP_HEXAGON_ISA_V65           =3D 8,
+    HWCAP_HEXAGON_ISA_V66           =3D 9,
+    HWCAP_HEXAGON_ISA_V67           =3D 10,
+    HWCAP_HEXAGON_ISA_V68           =3D 11,
+    HWCAP_HEXAGON_ISA_V69           =3D 12,
+    HWCAP_HEXAGON_ISA_V71           =3D 13,
+    HWCAP_HEXAGON_ISA_V73           =3D 14,
+    HWCAP_HEXAGON_ISA_V75           =3D 15,
+    HWCAP_HEXAGON_ISA_V77           =3D 16,
+    HWCAP_HEXAGON_ISA_V79           =3D 17,
+    HWCAP_HEXAGON_ISA_V81           =3D 18,
+    HWCAP_HEXAGON_HVX               =3D 1 << 7,
+    HWCAP_HEXAGON_CABAC             =3D 1 << 8,
+    HWCAP_HEXAGON_HVX_LENGTH_128B   =3D 1 << 9,
+    HWCAP_HEXAGON_HVX_IEEE_FP       =3D 1 << 10,
+    HWCAP_HEXAGON_AUDIO             =3D 1 << 11,
+    HWCAP_HEXAGON_HMX               =3D 1 << 12,
+};
+
 #endif
=2D-=20
2.55.0


