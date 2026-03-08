Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213CEEA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMk3-0004ud-P1; Sun, 08 Mar 2026 18:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMjy-0004ZM-AZ
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:36:51 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMjv-0003Sg-3o
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:36:50 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso111177205e9.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009405; x=1773614205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=b09sap+OGQMVeE1aTDMGBHHtw11LVdZGHOH7RYaf3uM=;
 b=LqjVoNPFBVYV63LFuV/LPnkWzmFVpu3lP8doX9du1HZENCFmSP00GUv9HkR34g7hux
 Da9cbhDlkyGo7eNr67IPmB5TZKbQtp7iCnLr2yfPdSWXS9/SerzZP6d1IdGzisjmLEEz
 gOqs4NmAFNr881zjsy47Zg+vF4KmhYJlrk3fSwC+wzpRfkaEdBhbUyaPDT1QhMHA2Ije
 9Gl6+nRgw9vZBTHvwy70BrRCPWyb++VdEesfQ8LV4Q5EjT544mRMDIiOT5f7U4P3MkEG
 bouy2wJD+2EBXi9UMUW/CmJnc9WmlOzlWYE3dknFsRYLye2Ww4Bmu/bbinir5JESwWZb
 Hu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009405; x=1773614205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=b09sap+OGQMVeE1aTDMGBHHtw11LVdZGHOH7RYaf3uM=;
 b=wwPKJeffVouEDKgTIczFWqrAnlUY6jQIcy2YpFHDlhJuCE3lL6IMICNrw4VSVuJwDZ
 rCJZUEvZYhwpxbXqF7h9KxKMCLJr+RgF0tdjgeaqzVqQKPl65flQflYXoR5ygvFFpSw5
 HndmTKglRXsvblEJ6xQRXbGaV3NCAhtHOrPURqS2Z2cAJdQQg+r70mCQbHNTxAx4ckgm
 /LF3CLJCEPRWTJi6JI3jHrDzrVCxQi4fQcIcYujTRCPgYZ1CzjLedVuNUBvOypOFCfrc
 oZlb230bv8CrrOgOKFibgX+OxKg3pOtRaYuBfNDhZhMCDu/9zUPGlPvtk8xM2OzTx3ps
 RUNg==
X-Gm-Message-State: AOJu0YwjMeO8jk2ux839RjSPletE7ItqXHOeyii19FDPcG5CttDP9WxA
 4AknrYCrFFIikxPpXjVvkunHfAxU3giG5dH8mn2NETVyHnlwThPfsp3klLsb7NZv4isQ3oW1090
 5CWec8Y0=
X-Gm-Gg: ATEYQzzeVG5ASPNKWT0AEA2t27RfzhrTU4vc7BUgLMq8AbkNwFHNf6hFVyWTOPex9CD
 +3YDqHjLqqO+RJuMTpqYunXXFx5KEor2Alyt5LDn4r5r3pC1+MauZlMGw10fjCYVKbSc51N5iCY
 d00I5+l++d2lQLZUpyI5EBLRh+UEneoZwLpWCnTVKjvWaKPv07gdJffMhosrXybxzUxYzX3Ys1R
 6US+syKC7VtGW+rKZkZ22IaYIYKcdpXmLCTru/s26eRzM7pl7qPP05aP43UnB3lKGkQXeRwFdrQ
 fYrBnF2MD/T23uxam2B+5B0a1D0naB+IyGq+aeqbQVqauC7HqsLFJ3Km9nsEH0jmjs9C2A+JRUl
 ODQlnJRbiLOs8Gr9Ym619KoQk2e1MQ/uLW67FRXWBhgijy3TJYiYv8T+fdjXgMljIvuXzt2pHqc
 ue1XHK6lC3ML+YemSQOU7GKSiKUkr1JCE8ja96w9eOTr/Tff7yh6HbRcV061E3Y5nLs7pIBdC3H
 QAEBA==
X-Received: by 2002:a05:600c:4ecd:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-4853c2e648fmr10835415e9.2.1773009405238; 
 Sun, 08 Mar 2026 15:36:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852e38c013sm282732545e9.8.2026.03.08.15.36.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:36:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/49] ati-vga: Read aliased values from DP_GUI_MASTER_CNTL
Date: Sun,  8 Mar 2026 23:34:03 +0100
Message-ID: <20260308223433.25503-20-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

DP_GUI_MASTER_CNTL aliases several fields from DP_DATATYPE and DP_MIX.
These were being written correctly but not returned on a read of
DP_GUI_MASTER_CNTL.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260303024730.1489136-4-chad@jablonski.xyz>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati_regs.h | 5 +++++
 hw/display/ati.c      | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index d7127748ffe..0a0825db048 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -386,6 +386,9 @@
 #define DST_16BPP                               0x00000004
 #define DST_24BPP                               0x00000005
 #define DST_32BPP                               0x00000006
+#define DP_DST_DATATYPE                         0x0000000f
+#define DP_BRUSH_DATATYPE                       0x00000f00
+#define DP_SRC_DATATYPE                         0x00030000
 
 #define BRUSH_SOLIDCOLOR                        0x00000d00
 
@@ -437,6 +440,8 @@
 #define DP_SRC_RECT                             0x00000200
 #define DP_SRC_HOST                             0x00000300
 #define DP_SRC_HOST_BYTEALIGN                   0x00000400
+#define DP_SRC_SOURCE                           0x00000700
+#define DP_ROP3                                 0x00ff0000
 
 /* LVDS_GEN_CNTL constants */
 #define LVDS_BL_MOD_LEVEL_MASK                  0x0000ff00
diff --git a/hw/display/ati.c b/hw/display/ati.c
index 777a6b0a2ea..028efd13e19 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -460,7 +460,13 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
         val = s->regs.dst_y;
         break;
     case DP_GUI_MASTER_CNTL:
-        val = s->regs.dp_gui_master_cntl;
+        /* DP_GUI_MASTER_CNTL aliases fields from DP_MIX and DP_DATATYPE */
+        val = s->regs.dp_gui_master_cntl |
+              ((s->regs.dp_datatype & DP_BRUSH_DATATYPE) >> 4) |
+              ((s->regs.dp_datatype & DP_DST_DATATYPE) << 8) |
+              ((s->regs.dp_datatype & DP_SRC_DATATYPE) >> 4) |
+              (s->regs.dp_mix & DP_ROP3) |
+              ((s->regs.dp_mix & DP_SRC_SOURCE) << 16);
         break;
     case SRC_OFFSET:
         val = s->regs.src_offset;
-- 
2.53.0


