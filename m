Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C2FC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOVg3-0007CE-0J; Tue, 02 Jul 2024 01:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVg1-00077t-Se
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:03:37 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVg0-0007kr-6Z
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:03:37 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42563a9fa58so26603305e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 22:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719896614; x=1720501414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+91gvHB50PukN639vXpRuhbPnrJzG8qgNtIT0wpdvQ0=;
 b=HHvVaW6juuLgxK7PB7wAVnYYhmvsAO2Q/FIWE7nUJ3AlmRa8iSUhmgLun0mK/Ce4ZI
 HLnavpyJrDkwHDzW95LWARnxszf/cbsYXLwJx/yBuyHBXPidrb5QpXJ+OnglTYCL2wdD
 v788O5D8hva7xMO8Rd/o10WrxtZ+h6tU86poeYJHSJnjI4NKzX3dusV2ds2KCuQi12sK
 1aKwOJ2hKJHuWQF8RGsY38IPE6gUHQGd/Km9+UFK0yu3fWgyrzAqj0ZLWPnBzZZxMAFT
 9/8YBbew2Ynl71HszuQ+5XDm/msQ5RUUyA7pRF/Q/nJeVnQK0LRuF3XWsNtyCz0f1ADZ
 1oBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719896614; x=1720501414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+91gvHB50PukN639vXpRuhbPnrJzG8qgNtIT0wpdvQ0=;
 b=hQfifEeeAF4LdMKoOI30iHqVo1meSbTVS9PVb5xmw+HCFxWE+8pExP/1J6X5smffp9
 Ytdm4epI8hshveNrHNfdCdxXSz93+51JoqA5SNSsGowJry7ynZH9ug75NFilUqn7MzRk
 o2h9VICHdHs3dGln1T6NGiHKsnTO042f/jY0tQ38isOTH9LoTcCBbO3AvUk985r5qhx/
 k4raDuVEQRcVe86R6fqnKkp8WtdnRoCo2Nbzsfk+l8WE/8m1RMgU1LrIsrHW4Z8CfJdC
 DrzCABQ1XTRgOAGKGwDAMvEHuwLEPA4hdpWsldSCJxqpJYd8mu5augFUhPHZjmNcNQA3
 u1wA==
X-Gm-Message-State: AOJu0YyGo7LnSoUfSo0T04p4VnH5xf511cy4s82j9t5NFaV+Bh3S7dEn
 M7QycsCzEOduPkPQQLT7+SoguBtyolBzrgHkFikBJwnkXd+cRrtlQQqk7AbyrzJokooE5puPYWy
 U
X-Google-Smtp-Source: AGHT+IGDQ2sY+VJHOtj0T8WhUCw9UjKVR3/V2ntXvnhz/eo46yvt36H/87ZR2E4SVsTE7vgxPwh9kQ==
X-Received: by 2002:a05:600c:3b09:b0:424:7bcf:2486 with SMTP id
 5b1f17b1804b1-4257a00aadamr43499815e9.4.1719896613926; 
 Mon, 01 Jul 2024 22:03:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b061eedsm173093075e9.26.2024.07.01.22.03.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Jul 2024 22:03:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/22] Remove inclusion of hw/hw.h from files that don't need it
Date: Tue,  2 Jul 2024 07:01:12 +0200
Message-ID: <20240702050112.35907-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702050112.35907-1-philmd@linaro.org>
References: <20240702050112.35907-1-philmd@linaro.org>
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

From: Thomas Huth <thuth@redhat.com>

hw/hw.h only contains the prototype of hw_error() nowadays, so
files that don't use this function don't need to include this
header.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20240701132649.58345-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/misc/xlnx-cfi-if.h | 1 -
 hw/misc/edu.c                 | 1 -
 hw/vfio/container.c           | 1 -
 3 files changed, 3 deletions(-)

diff --git a/include/hw/misc/xlnx-cfi-if.h b/include/hw/misc/xlnx-cfi-if.h
index f9bd12292d..5010401517 100644
--- a/include/hw/misc/xlnx-cfi-if.h
+++ b/include/hw/misc/xlnx-cfi-if.h
@@ -11,7 +11,6 @@
 #define XLNX_CFI_IF_H 1
 
 #include "qemu/help-texts.h"
-#include "hw/hw.h"
 #include "qom/object.h"
 
 #define TYPE_XLNX_CFI_IF "xlnx-cfi-if"
diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index fa052c44db..504178b4a2 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -26,7 +26,6 @@
 #include "qemu/log.h"
 #include "qemu/units.h"
 #include "hw/pci/pci.h"
-#include "hw/hw.h"
 #include "hw/pci/msi.h"
 #include "qemu/timer.h"
 #include "qom/object.h"
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 2e7ecdf10e..88ede913d6 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -26,7 +26,6 @@
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "exec/ram_addr.h"
-#include "hw/hw.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
 #include "sysemu/reset.h"
-- 
2.41.0


