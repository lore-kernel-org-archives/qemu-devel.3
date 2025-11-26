Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16622D111A5
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 21:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOMkq-0003JI-P6; Wed, 26 Nov 2025 16:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1vOMko-0003Iz-9g
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 16:08:47 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1vOMkn-0006QF-0E
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 16:08:46 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so1361105e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 13:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764191322; x=1764796122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=32XumUilB+w7sTx0WIPuMLTNtwG2NKGEm829/Inhxfg=;
 b=Ub6xWKrigx+weSrLU/SudTQ4wNqIX7qtX/bWZW4soTOTU11iHJPcDUKR9hlB2It+RG
 xacdNllmhIjcYOgGY46dUxbDZQEwYPqhK+9oJ9ZBoSjL8zoK513q+NAEWpr452cwkZkm
 RF88L1XV9fbRjqxDWYWkAFnY59uG03iCjMl1LoiNGARDIonkeeeOEc8uY1Tlu6vJ8zbj
 GQFLfIU+57lopf1n3XtL2ENETFbaOS9qzsgfUv5jQtxzXUz/P0BagtiETywsBNojxrvr
 hrGZFRnRjiBFgAmEgsrgpSDrLW1U4ulV82eENCFSwGUFtvGebmDhDjhHC5tRULMWr0wC
 10eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764191322; x=1764796122;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=32XumUilB+w7sTx0WIPuMLTNtwG2NKGEm829/Inhxfg=;
 b=UnIAVKXUzRx2a0bttGeDlaK+LHwoOD3mLpF7owYHhBPoSt5apskZ4bbxZhpEbzoz3Q
 Egcj6h7QY487ZGNe2NUS6ZmzTqhrsyvcDSWQA0uosMWK9AlH2cjKQWZOG17Ca2C339Yz
 lUj+LxVwdMX8d0VMDBHn57Y8aoGnH0fNwjqh2aAtutEuf7AmE1hduEATGEaPHeJwJDGR
 xvvzt1t7dmE5r6vx/y0Gql7JBjDNh/PKqu5o+GW6rGvcmNyXbu3l+9IJtkbwkXYxC4Wj
 T1YFDXV7ac7dXvBtPnvGpAmyQU/X5rZFb7y8+YjlRJA3GH8shzZL7LJCRSLsdlV+6IIs
 ubZw==
X-Gm-Message-State: AOJu0Yw3vspF1nyH7qoNH89Bwzd8k/glwMpkRTcpOj3OqjZGJV9oDIyX
 WOMVbH4VXVPm85L8TpDd7JbHec8qDkbh7vpShbW1IEPE+uS3NrqU0t3Qf5I8+g==
X-Gm-Gg: ASbGncsJ9FnwFXMv5KWCS8ETSmm5yzvQyvh3OkTgEK2vHMrS3QLqVdM3B4Ns8SVLqnk
 tNtNiuLhuOQyRZTZbbZQku6fY3um6G3pyn9GecaqUvN2rfkhsdEDLDmy9deTRRV5r7dmkuffk9h
 fZnd+dabaxKAGsLPDdTm5LpX/4Tglrcd/NtaPCyrW30+ftQUFurQejD1fMF3mUkEfmao5whETBB
 VNadBDOWA1QnSPVomX5vcwbn95uE0zyL1xJy2hw1IOyeBR24X8cvpOTUDgps0SUHstuPrbaDCR8
 ED2EpOxaNxpRZ8/hDCzJFLZGEsx3WfvIexsluYE/lXB6UyTeLlZJXxIdzVL5dMQAdPROG6BXlWk
 mH0yV6W6eSMj0qY3SUDM8N2omGwvJ7oSfUD7neOw+23Qp1IOg53G3hCbyes8EpubZP2egUGIJQj
 5OHaOcMDSOQ/AmKCo=
X-Google-Smtp-Source: AGHT+IGAVNd6NB5K03h4V6kyIUFC/9OoDoz0uhRhFjAcirtWFQ5ZHsIlhhr5ligbYcaMpBdPc3HS4w==
X-Received: by 2002:a05:600c:35c6:b0:477:a36f:1a57 with SMTP id
 5b1f17b1804b1-47904acae1fmr93313765e9.3.1764191321763; 
 Wed, 26 Nov 2025 13:08:41 -0800 (PST)
Received: from osama.. ([2c0f:fc89:129:990a:83a3:6137:cef9:6de9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790ab8bb21sm65626785e9.0.2025.11.26.13.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 13:08:40 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: qemu-devel@nongnu.org,
	pbonzini@redhat.com
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] hw/core: remove duplicate include
Date: Wed, 26 Nov 2025 23:08:32 +0200
Message-ID: <20251126210832.34011-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=osama.abdelkader@gmail.com; helo=mail-wm1-x32b.google.com
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

qemu/target-info.h is included twice.
---
 system/vl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/system/vl.c b/system/vl.c
index 5091fe52d9..d2b53ea772 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -41,7 +41,6 @@
 #include "qemu/help_option.h"
 #include "qemu/hw-version.h"
 #include "qemu/uuid.h"
-#include "qemu/target-info.h"
 #include "system/reset.h"
 #include "system/runstate.h"
 #include "system/runstate-action.h"
-- 
2.43.0


