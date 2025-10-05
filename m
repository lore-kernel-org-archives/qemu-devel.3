Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514FCCAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 18:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5TwV-0004zt-DG; Sun, 05 Oct 2025 14:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1v5TwU-0004zd-N3
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 14:58:46 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1v5TwT-0004p6-4d
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 14:58:46 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-36453927ffaso40569551fa.2
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 11:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759690721; x=1760295521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nexgf6hd/Qhctp9El5zgWCdHTRWfKODP1WxaKeNvDkM=;
 b=aTOtNZLYYvRqLvoP5FibeRi5jziIm7donpzmpu+si01DTC6gjaamxHPnQWwCTAZYmi
 qhS+oFarFhTyED9YkNn2i79M/OtNA/IRhmrVwWRoagEKjQl+y4REbrHlJD3bH6haNls3
 xsWA7SrFcFq7gi2OWHbjQQeXvecNDS697q02k1W9rs9s9aLd1JyCBYV5TE1K+j5P5ztG
 xwVTn/jlEzoEglrmBpao2BVz/n8v1oxWFdTxUNzUNakTW4ZCGauXTnTVM6e1RXspOoH0
 QvfY4enINACI7hVz8c72Ljiva3jhQu2lsH8Q5kV2jEHZ9XGCF54lRgMt9RONFwyqW7uL
 kStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759690721; x=1760295521;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nexgf6hd/Qhctp9El5zgWCdHTRWfKODP1WxaKeNvDkM=;
 b=aBtgxJ1Cs3UQfGh66iwENGARlAZo5XuvXlG/8aWxY0JzDG8qQ8X0eKmBMwSVEor+lo
 EealKWD5yMerRC76huHDs2WYaEtOx7L2pOJcc+SoMaYHi1yP3hHSxV1CMnthdYAczMjr
 Ntny6XsSr/nqqJTUjWixCVOkSXpo6DDROmijgtfd7bupWcKxdkJh+nyLg74faklbqb8z
 3rWrouu7Yd20InQZZtgI9YhT3sUXJXr6aqMzhybkBwg5lSxK7GPMvnqk+3ipdmBfKUf2
 yjx8+aPVvWCk4ONVWJ5FDU0gc8XEtqof18jHVdQZIJYRl3oUBVCQrp+YS2eCobXIMtQa
 ItwQ==
X-Gm-Message-State: AOJu0YwqHEyDpD1X62PnzhKnYhwk8yW4RpCPHfhBXXTkso0XpyRe4sVv
 Q/k5ukjV+JH4nkUvdwXqyy4P3BRlPrkbJgGtSmMrtL1ZFpdkWkUHhBpgNhX9lfvyUi0=
X-Gm-Gg: ASbGnctQx9JGvGjIfmbF7CPBt3w3+sFBxw0KZXfhEHUW8kj6ENoIlmZaXZ+5HjTKDxB
 wz5+bmC6Lrq346Vl0G3v8osEhPrJnUAMpv0wRysdmhNAR62P9OEOx4nr2TWaTIev+0p8L56uOY8
 P1WX4SGk7plij8OHuRd29VlXohu6vewUb4N91lHGyKApahH8I/T/6fXindI3DJgwlbId1rFSHr7
 Lsjn2pBbBvkkcMO39SKiOaPoIEnO8UmajgtkOQdLp3gBhjF290yP5vBNGHMShPWPRbBhSE89mnj
 vK9UDOCZ34NQJjAwrt3AiZY7nHknQ0WuQfK6h6KGH65G9EMwkIQ1IaarKkwQQoHjNq1aWoq3fmo
 1IuMGhPNUEc+ncTaWMRWHRd0yCVxxCr8wbh3NBRSVFCIGrAvvYVDmXD1TZPpYfElqsQ==
X-Google-Smtp-Source: AGHT+IHGZzK+qFL/EMh8xEDEju2gdTFQ+4nuts5JR/meh2fYpAzXBvYHu89SWnN0KMN+M3BfBnIeUA==
X-Received: by 2002:a2e:be8d:0:b0:372:8e46:3705 with SMTP id
 38308e7fff4ca-374c3886fa3mr32017271fa.44.1759690721242; 
 Sun, 05 Oct 2025 11:58:41 -0700 (PDT)
Received: from xpahos-osx.yandex.net ([2a02:6bf:8080:c37::1:1])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-373ba49fd69sm37384161fa.43.2025.10.05.11.58.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Oct 2025 11:58:39 -0700 (PDT)
From: Alexander Gryanko <xpahos@gmail.com>
X-Google-Original-From: Alexander Gryanko <xpahos@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-trivial@nongnu.org,
 Alexander Gryanko <xpahos@gmail.com>
Subject: [PATCH v2] system/runstate.c: Add a newline character to correctly
 log guest errors
Date: Sun,  5 Oct 2025 21:58:34 +0300
Message-ID: <32D0DF37-A1B3-4532-B350-082E19E4EABB@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251004-add-newline-guest-error-log-62d68638b28c
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759599468; l=1584;
 i=xpahos@gmail.com; s=20251004; h=from:subject:message-id;
 bh=rvwWS/RTpcBRE43Pzrs+MfGd8cC10dbKpihj81a/57o=;
 b=+LjQuITtD0JEG02JJvL+AhM2l1Uq5u9EEFQc1OfrIm1pLBzveSkMxF6uRDo5Gjvprys68NKRZ
 mR8UXF/vEJTCFYsQYKk4oBFYMZV4I03p5jP5mC001Q4Wzc0uGXWbtML
X-Developer-Key: i=xpahos@gmail.com; a=ed25519;
 pk=bsSvP3Tn7PVKgjJT3BMV3jlAwSqreKIM4099C1r51eg=
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=xpahos@gmail.com; helo=mail-lj1-x22e.google.com
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
Message-ID: <20251005185834.-gxMlKhpaFOMGicBr2tIAJBRcoIn4rRRGQluhy5x-9E@z>

From: Alexander Gryanko <xpahos@gmail.com>

The pvpanic handler calls the qemu_system_guest_panicked
function with a NULL parameter, which results in the absence
of a newline character in the guest error log.
The qemu_system_guest_crashloaded function has no additional
logic, but also omits the newline character.
The qemu_system_guest_pvshutdown has no reporting in the
guest error log.

Signed-off-by: Alexander Gryanko <xpahos@gmail.com>
---
 system/runstate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/system/runstate.c b/system/runstate.c
index 6178b0091a..8b4bf75cd6 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -674,18 +674,21 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
         }
 
         qapi_free_GuestPanicInformation(info);
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR, "\n");
     }
 }
 
 void qemu_system_guest_crashloaded(GuestPanicInformation *info)
 {
-    qemu_log_mask(LOG_GUEST_ERROR, "Guest crash loaded");
+    qemu_log_mask(LOG_GUEST_ERROR, "Guest crash loaded\n");
     qapi_event_send_guest_crashloaded(GUEST_PANIC_ACTION_RUN, info);
     qapi_free_GuestPanicInformation(info);
 }
 
 void qemu_system_guest_pvshutdown(void)
 {
+    qemu_log_mask(LOG_GUEST_ERROR, "Guest shutdown requested\n");
     qapi_event_send_guest_pvshutdown();
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
 }

---
base-commit: 81e3121bef89bcd3ccb261899e5a36246199065d
change-id: 20251004-add-newline-guest-error-log-62d68638b28c

Best regards,
-- 
Alexander Gryanko <xpahos@gmail.com>


