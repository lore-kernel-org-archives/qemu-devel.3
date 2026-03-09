Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32A9F41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzczk-0005ZU-1M; Mon, 09 Mar 2026 11:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcyv-00040O-4Y
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:57:23 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcyp-0000pI-6g
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:57:17 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4852fdb36a8so24371855e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071833; x=1773676633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zzThGEbHDfbShZ+LqArsRWb9rcvvKyh183/KD+t4v7U=;
 b=w3AgJOl84dg9jL1OE/x53l74mCuMKnvUwf20zqcAnTawH4qfjhtzVIE5o7LYMWMp1q
 0mI4HA7RTum05igyKyGfhAY0sxZ/QLhrtB/vPKu9okxNaStqCNqqQtiwGluM5SaP3Wa3
 XKLS9FMWzO3Dp+llYaF0ACmupp4fZFT+g/nH+T5aXk6NoJpvxMM3DS6fdnP8NBgK88SS
 AShN2yP3/YRbjrjfukpptsye9toM4xxYYzBUhNGrChTH6E04jetsN0koymOqiJ8wSW2k
 EKEJaqMsGo8iUtHhhbI9QLJLp8Vh/VMS7mPWYnwJXsv1nxRpuc/MNbOAbWiDD2r/t7vW
 x0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071833; x=1773676633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zzThGEbHDfbShZ+LqArsRWb9rcvvKyh183/KD+t4v7U=;
 b=JrT3dmKaIZ+rHZR2lWHJ0nAj81vDjjidqAJ/Z9ruUO3LrNR01beOsj0v9ZqROqHyLZ
 t4k5ZunAJgamnv+i4OVfnIojcqtJ+y+49s+mZ54zCTdP/NQFmAnF7hgAQQzxLKm2Jed1
 T0kt+OtgFpt1m40SaG0BJkghn57CiWrgol5fLttBfduLnVHeKZKpRC1WkTeZm/h8cjdD
 DdTG60K0/CghskOHrrgeYeau4UqfhyNcA+gYkNlNAIuPzHwqtesbug7X5XRyK8xXnLon
 +0y4wBYl2vvxbfQ7ExAFBXk8FKrh5o6tE2MrYitpOafOKLn6VrJydoe9VHsQEaQ9Y16N
 DDLQ==
X-Gm-Message-State: AOJu0YzI2+3fclHuqNVX578Q3pJyMq/JAuRhgJRgbfZrthy5V65kJfN9
 7uMb+wYWp9w7GtPvBMFPaZsiGMtPUuGPeld4y8L+FGVq6qiZ3v8eEFxaKoarXUi8r7Brx+H58XG
 XRYjEIJw=
X-Gm-Gg: ATEYQzx/Cpf/wc2rg6ZY1tbK+1WNg05AATq6PKSNod3DAsYlE1OGEww7sKQHl4OBcZE
 trFL35klIw9I5yMO9rWb75qpTY0TBefuWdTfBsXY11sMwanYHP+BrAFyb3mY6+boAtTF97M8Biy
 gnj2vdOj31tTTJS5fDkJXnx2w1UrNNRLZnjgqc2JVitScUNlwh4MM493wD+gxU4Sd/odibSdmCZ
 Qz7+ybS2iVj9xpH684ESacF/1GqxHRZjBc/yy7OlccP1RytEroqOq5t1ljL3j7YQo2wVTf1z3PW
 GS1ZKjNh4sQSD7whE/n5sceueqw6eks63YqPMuK19HWc1A9U3GJJ5Rqff1UT4Z0wg5C8sxN8Cav
 mZB9+4XKrGiH+XEzz3E+4FpRyha5FfMiGiOw9wp9LWEUXg9/ZTDNXeOOE2GxjHOKRnb2eCvECeq
 CSclEXEd2HWHo65uAGav7ZqEy/wbpg0u5G/w9H6VDoePWshHycMpvxEVH1e+GK3aFQacxJXRRyC
 /YfHIABIfk=
X-Received: by 2002:a05:600c:3ba2:b0:485:35ba:1d81 with SMTP id
 5b1f17b1804b1-48535ba1ea6mr92788705e9.21.1773071832488; 
 Mon, 09 Mar 2026 08:57:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485419c2930sm3208125e9.0.2026.03.09.08.57.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:57:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/49] ati-vga: Implement HOST_DATA register writes
Date: Mon,  9 Mar 2026 16:52:13 +0100
Message-ID: <20260309155219.62400-44-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Chad Jablonski <chad@jablonski.xyz>

Writing to any of the HOST_DATA0-7 registers pushes the written data
into a 128-bit accumulator. When the accumulator is full a flush is
triggered to copy it to the framebuffer. A final write to HOST_DATA_LAST
will also initiate a flush. The flush itself is left for the next patch.

Unaligned HOST_DATA* writes result in, from what I can tell, undefined
behavior on real hardware. A well-behaved driver shouldn't be doing this
anyway. For that reason they are not handled here at all.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <235adb69787c818afd023e7f32286166cc70744c.1773020351.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati_int.h  |  9 +++++++++
 hw/display/ati_regs.h |  9 +++++++++
 hw/display/ati.c      | 26 ++++++++++++++++++++++++++
 hw/display/ati_dbg.c  |  9 +++++++++
 4 files changed, 53 insertions(+)

diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 874c63eb544..063efc7bbaa 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -96,6 +96,14 @@ typedef struct ATIVGARegs {
     uint32_t default_tile;
 } ATIVGARegs;
 
+typedef struct ATIHostDataState {
+    bool active;
+    uint32_t row;
+    uint32_t col;
+    uint32_t next;
+    uint32_t acc[4];
+} ATIHostDataState;
+
 struct ATIVGAState {
     PCIDevice dev;
     VGACommonState vga;
@@ -114,6 +122,7 @@ struct ATIVGAState {
     MemoryRegion io;
     MemoryRegion mm;
     ATIVGARegs regs;
+    ATIHostDataState host_data;
 };
 
 const char *ati_reg_name(int num);
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 3999edb9b71..48f15e9b1da 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -252,6 +252,15 @@
 #define DP_T12_CNTL                             0x178c
 #define DST_BRES_T1_LNTH                        0x1790
 #define DST_BRES_T2_LNTH                        0x1794
+#define HOST_DATA0                              0x17c0
+#define HOST_DATA1                              0x17c4
+#define HOST_DATA2                              0x17c8
+#define HOST_DATA3                              0x17cc
+#define HOST_DATA4                              0x17d0
+#define HOST_DATA5                              0x17d4
+#define HOST_DATA6                              0x17d8
+#define HOST_DATA7                              0x17dc
+#define HOST_DATA_LAST                          0x17e0
 #define SCALE_SRC_HEIGHT_WIDTH                  0x1994
 #define SCALE_OFFSET_0                          0x1998
 #define SCALE_PITCH                             0x199c
diff --git a/hw/display/ati.c b/hw/display/ati.c
index 9a7c5703b0f..16dbb743e1a 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1023,6 +1023,27 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     case SRC_SC_BOTTOM:
         s->regs.src_sc_bottom = data & 0x3fff;
         break;
+    case HOST_DATA0:
+    case HOST_DATA1:
+    case HOST_DATA2:
+    case HOST_DATA3:
+    case HOST_DATA4:
+    case HOST_DATA5:
+    case HOST_DATA6:
+    case HOST_DATA7:
+    case HOST_DATA_LAST:
+        if (!s->host_data.active) {
+            break;
+        }
+        s->host_data.acc[s->host_data.next++] = data;
+        if (addr == HOST_DATA_LAST) {
+            qemu_log_mask(LOG_UNIMP, "HOST_DATA finish not yet implemented\n");
+            s->host_data.next = 0;
+        } else if (s->host_data.next >= 4) {
+            qemu_log_mask(LOG_UNIMP, "HOST_DATA flush not yet implemented\n");
+            s->host_data.next = 0;
+        }
+        break;
     default:
         break;
     }
@@ -1128,6 +1149,11 @@ static void ati_vga_reset(DeviceState *dev)
     /* reset vga */
     vga_common_reset(&s->vga);
     s->mode = VGA_MODE;
+
+    s->host_data.active = false;
+    s->host_data.next = 0;
+    s->host_data.row = 0;
+    s->host_data.col = 0;
 }
 
 static void ati_vga_exit(PCIDevice *dev)
diff --git a/hw/display/ati_dbg.c b/hw/display/ati_dbg.c
index 3ffa7f35df9..5c799d540a9 100644
--- a/hw/display/ati_dbg.c
+++ b/hw/display/ati_dbg.c
@@ -252,6 +252,15 @@ static struct ati_regdesc ati_reg_names[] = {
     {"MC_SRC1_CNTL", 0x19D8},
     {"TEX_CNTL", 0x1800},
     {"RAGE128_MPP_TB_CONFIG", 0x01c0},
+    {"HOST_DATA0", 0x17c0},
+    {"HOST_DATA1", 0x17c4},
+    {"HOST_DATA2", 0x17c8},
+    {"HOST_DATA3", 0x17cc},
+    {"HOST_DATA4", 0x17d0},
+    {"HOST_DATA5", 0x17d4},
+    {"HOST_DATA6", 0x17d8},
+    {"HOST_DATA7", 0x17dc},
+    {"HOST_DATA_LAST", 0x17e0},
     {NULL, -1}
 };
 
-- 
2.53.0


