Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E633C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJbt-00045N-Gj; Sun, 11 May 2025 23:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbD-0000eC-WA; Sun, 11 May 2025 23:13:05 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbC-0006wR-BM; Sun, 11 May 2025 23:13:03 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7424c24f88bso2014360b3a.1; 
 Sun, 11 May 2025 20:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019580; x=1747624380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QqTvYTP2tQvWHrwZUpaqxfqmBb67K8IMaUfsBR4L7p4=;
 b=EBTTYPEJbpFdYP7xQ55cUViYMbn20zzwDsSViPCfCRh5eaTq6Ec1ZoGDbtZ3sgZ6DJ
 bIOCQRI9vJ/hGAFRecycK9BQ7b6kM0DuGizCgs/5F432irYLIJCPlIoFJxcPsYPW/Rvq
 sN7dAaG5rvgM/xxA9724GPEfApXVk0fCqdA1czsDYWI1hPpe6yQT43XRkGa05yOZ/TIH
 AT0Xp2zRRn4j4r/m4k5yhBWnPmTH6+z7GCOUadeGx9ofNQTQYhfQL/H1LNztFFldKGhZ
 t9z9K8PnrY3gsLzommYcqbFDfUH2ql816BNYxYEPUFBNu07nCSqWRkWou1aehZqYulbV
 y/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019580; x=1747624380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QqTvYTP2tQvWHrwZUpaqxfqmBb67K8IMaUfsBR4L7p4=;
 b=KqSjlIpptatM1UMHfYN0IJaYLkwh+lYnsGR15hApo0gfbxfBqfb7kN7ZhRX5jb47Ha
 vpyjm2zxYCw7LlvyiHrfcN9+tY0wne1wpIZ0pu8nWOFLi2pnimJm/rGSDeVVcIgM+2yR
 47k4B1pjg32/MpsvuL/9N9pFB1kkz2ClUHuuMxLWETboIUJN7h4FxXtvITOljWBIStNQ
 EOFSmTYes3sxrXMSVk5G1Ko/oJLn00AGdFPlgU8z+wBzjxC1f91P7a7tv78YPBTPuIEw
 2Z8DZgWjj4PGbUQkCvi3LwefaAaDZVrnfbQI3xJY3R9clUU8Ldn2zvP5FJhDIe+wkYm7
 47kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEb0wv2K+iWwnfoxk2vHg45Pfu1lCjE/q1N4p3LPdfQOOXYu9pcLGB4z1YyIt+De22jDsztDxtmtdD@nongnu.org
X-Gm-Message-State: AOJu0YyRm+c7p/G68r/ebEnwuZBowTe0LmFSgNozC1quTydXoFXRARlG
 xRtUtXSMQsefc8FhSXTrUhkyLw6XjHUMI0IRoOK/jyXd5ZbgAvzz1wEpPQ==
X-Gm-Gg: ASbGncuKvzerlq5AWduSjiJeRd33Kf8i5tiZUpvDpLJH83jN3MHk7FvBIEv8O6HRml6
 38xp//5c1Qtc6kWOmITwaRanJXXFtVS724mbhhRO/N6p8EgTd/2KmKPwoT2+5c8l25f1fQi0Bq4
 6lyNJG3nKoOt1oYms70cXLRujuPoAclVqiqBnN3iQClpsCxeeHR7fGpsS1clTt9+lF4DnRTmXFg
 NfgNfigK8/DhhQ9s2k08wY4cxbQKPcf5Xc147so4hJuJ/wi8PmWxtl6mmxjlrRU2G1GlRcUtS6n
 ML/8JnGgBySTgamkWbRtRBfH9ZWITAFweA0h3x8aDQXD9YKr9uZc99en3A==
X-Google-Smtp-Source: AGHT+IEtDxSFp1ZRO1+PvaE/Gok1MTpdXqFdCXVQyRd+n8oi0cHs2+VqTHoE8U3ZRgeco+wDR/+9eA==
X-Received: by 2002:a05:6a20:e68d:b0:1f5:8fe3:4e29 with SMTP id
 adf61e73a8af0-215abac8b82mr17740803637.3.1747019579693; 
 Sun, 11 May 2025 20:12:59 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:12:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 30/50] ppc/xive: Add xive_tctx_pipr_present() to present new
 interrupt
Date: Mon, 12 May 2025 13:10:39 +1000
Message-ID: <20250512031100.439842-31-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
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

xive_tctx_pipr_update() is used for multiple things. In an effort
to make things simpler and less overloaded, split out the function
that is used to present a new interrupt to the tctx.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c        | 8 +++++++-
 hw/intc/xive2.c       | 2 +-
 include/hw/ppc/xive.h | 2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 27b5a21371..bf4c0634ca 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -225,6 +225,12 @@ void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
     xive_tctx_notify(tctx, ring, group_level);
  }
 
+void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
+                            uint8_t group_level)
+{
+    xive_tctx_pipr_update(tctx, ring, priority, group_level);
+}
+
 /*
  * XIVE Thread Interrupt Management Area (TIMA)
  */
@@ -2040,7 +2046,7 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas)
                              xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.w7),
                              &match)) {
         trace_xive_presenter_notify(nvt_blk, nvt_idx, match.ring, 0);
-        xive_tctx_pipr_update(match.tctx, match.ring, priority, 0);
+        xive_tctx_pipr_present(match.tctx, match.ring, priority, 0);
         return;
     }
 
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index cae4092198..f91109b84a 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1652,7 +1652,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
 
         group_level = xive_get_group_level(crowd, cam_ignore, nvx_blk, nvx_idx);
         trace_xive_presenter_notify(nvx_blk, nvx_idx, ring, group_level);
-        xive_tctx_pipr_update(tctx, ring, priority, group_level);
+        xive_tctx_pipr_present(tctx, ring, priority, group_level);
         return;
     }
 
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 8152a9df3d..0d6b11e818 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -562,6 +562,8 @@ void xive_tctx_reset(XiveTCTX *tctx);
 void xive_tctx_destroy(XiveTCTX *tctx);
 void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
                            uint8_t group_level);
+void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
+                            uint8_t group_level);
 void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring);
 void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level);
 uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring);
-- 
2.47.1


