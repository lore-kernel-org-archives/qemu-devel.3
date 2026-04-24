Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7896BFED3FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGMAh-0003g7-89; Fri, 24 Apr 2026 15:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGMAf-0003ek-JB
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:26:37 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGMAd-0001Zq-Ty
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:26:37 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso76949405e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777058794; x=1777663594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V9PU/lBCiMa2O6gmY4jmhZxi1sRtg1xdoyCtvP9seb4=;
 b=VN9Ynnhen2Qp620MluMUXdwjyPFxgtSAOQBXdb/wutzaQEETyidzr7vRc4J3rMk4Ij
 7/maoZF1lXrBqQwyLqPDI+snBtiyBTxKTFSxOymt5/d5TFU6JbKaXieeV+adNYraQmHE
 flot72r1/0i9d0Q2+e+zCFXi68uvUgHOILWOEA6RbLCy8QBqAVpN13XRBozHumkaAS2o
 U02IS9i3TpUZ2TzwDKkvjErs8yOtjgargrGqCU9RDGYS6hjRXlGlsqlTwZOG8j6IAA00
 e9ELFiMNe5pAuqRcqeFP/FDLco5a9QMOdS/h7glUhXsQ+2H7XQe5BvK5KhgMekcYhDTW
 2eDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777058794; x=1777663594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=V9PU/lBCiMa2O6gmY4jmhZxi1sRtg1xdoyCtvP9seb4=;
 b=hKinHiLFeuD8xPpR7NKWq+X/NRiHqM7tq58ZpGf1lUuNK5FHQYreq/a7x975VMnEbD
 1/vsNugAyjPtapNEH5lUoVyLNvYvQaWnOuv/qY2qPzxHgfgM4GpDndmwAAXoPc4UU+W3
 CPRPwjNhZgDgdcYgQWi5za1BIuYnCUmWKoYHcsrvOEZBvIP/g8GJ81PhVw7QtWL4LyO/
 mWzWdb9SDWKKUnBqzG3WbLmWtT9xeIiilfZD47MtsT3LDnXRrbIWYg/KAhk4hHmZ6ddU
 cANw6w00j0xLZiEYCVhQoI4IBr6mWCcVsVbueyzkJzFuHeTxrVN5XCS4V0rEGi8PY1ki
 y6Sg==
X-Gm-Message-State: AOJu0Yy1c9Xc3Bws9S0jr5paxlHD/vaR89MriI/QHvgaU2akfJAJp26h
 /Ldd/sw0BeStLhWSpBI7oEIbtGVB68j/Na8jDauM1amzdBeQypKQobUFwgB1X4XG541dODCzQIv
 Sxi7KcHI=
X-Gm-Gg: AeBDieuWZYTiJM9b2/K5y2YzKw8YnMKAklkOU7z21mBC+tSl4yEAzWHN15ERZXpKPMJ
 8voq3r7F1kr5DQnkbD1TPMMCpx0t79yzNaLD/aGOVu5Ew81V6LzwWMiN5xFINYVeFxM39zVJZHy
 jVKNYnaRvIesG3LE5/5OeOJtOsmQNpsxuDhKwMKdicCGP43BGXOh9zFbbEgbYtdwAbavbgPTUL7
 vZ1Kq5bDkmKSP8tq/uKe/Vh/Ku9thZrNtOtX0rN3lCRIof9XVR8jr0btlC0Iu3ZqpKqo/Xxdy9Y
 15NDMyA2T9AkP+zN2cEeB403MMibVDTxnPnHLvb7+z5peNv6gG1O8JajJ1p+uPf6eC4SsxwxQvj
 Nt5rP9KCZhY6SfDQ6xkUWX86nDVhSUejynjIJ1Vj4py5l66cUDbrPsjcj70WeRm8/qXv8mk3pIT
 uqC9w8mZ4f2Reqe/xd+F2gTAqgJbDQxpFh0yn5/OKJL+bUxUlW+4BV/75l1jwv+pyxF16fXY3Eg
 rfQ2ZTdWJU=
X-Received: by 2002:a05:600c:621a:b0:48a:6268:18a9 with SMTP id
 5b1f17b1804b1-48a626818cdmr90542525e9.13.1777058793834; 
 Fri, 24 Apr 2026 12:26:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a4b329542sm577354225e9.3.2026.04.24.12.26.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Apr 2026 12:26:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v4 51/62] hw/usb/hcd-ehci.h: Fix coding style issues reported
 by checkpatch
Date: Fri, 24 Apr 2026 21:25:39 +0200
Message-ID: <20260424192543.22614-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424192543.22614-1-philmd@linaro.org>
References: <20260424192543.22614-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260424080508.53992-4-jamin_lin@aspeedtech.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/hcd-ehci.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index 3aec0e047c9..736407fd521 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -43,7 +43,8 @@ typedef struct EHCIPacket EHCIPacket;
 typedef struct EHCIQueue EHCIQueue;
 typedef struct EHCIState EHCIState;
 
-/*  EHCI spec version 1.0 Section 3.3
+/*
+ * EHCI spec version 1.0 Section 3.3
  */
 typedef struct EHCIitd {
     uint32_t next;
@@ -74,7 +75,8 @@ typedef struct EHCIitd {
 #define ITD_BUFPTR_MULT_SH       0
 } EHCIitd;
 
-/*  EHCI spec version 1.0 Section 3.4
+/*
+ * EHCI spec version 1.0 Section 3.4
  */
 typedef struct EHCIsitd {
     uint32_t next;                  /* Standard next link pointer */
@@ -118,7 +120,8 @@ typedef struct EHCIsitd {
     uint32_t backptr;                 /* Standard next link pointer */
 } EHCIsitd;
 
-/*  EHCI spec version 1.0 Section 3.5
+/*
+ * EHCI spec version 1.0 Section 3.5
  */
 typedef struct EHCIqtd {
     uint32_t next;                    /* Standard next link pointer */
@@ -148,7 +151,8 @@ typedef struct EHCIqtd {
 #define QTD_BUFPTR_SH                 12
 } EHCIqtd;
 
-/*  EHCI spec version 1.0 Section 3.6
+/*
+ * EHCI spec version 1.0 Section 3.6
  */
 typedef struct EHCIqh {
     uint32_t next;                    /* Standard next link pointer */
@@ -230,7 +234,8 @@ struct EHCIQueue {
     int async;
     int transact_ctr;
 
-    /* cached data from guest - needs to be flushed
+    /*
+     * cached data from guest - needs to be flushed
      * when guest removes an entry (doorbell, handshake sequence)
      */
     EHCIqh qh;             /* copy of current QH (being worked on) */
@@ -268,7 +273,7 @@ struct EHCIState {
      */
     uint8_t caps[CAPA_SIZE];
     union {
-        uint32_t opreg[0x44/sizeof(uint32_t)];
+        uint32_t opreg[0x44 / sizeof(uint32_t)];
         struct {
             uint32_t usbcmd;
             uint32_t usbsts;
-- 
2.53.0


