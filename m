Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E520C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcu0Q-0005Sm-33; Wed, 21 Feb 2024 16:19:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctzp-0004M7-VP
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:19:20 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctzm-0001MF-Ud
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:19:17 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4127a0d8ae1so3995335e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550352; x=1709155152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/0nxiYdmkxhHFcoyS3JZWxjubFyxLiPoIZ7GwIxEsQ=;
 b=Gsel+bvNel7e5S+Im07IoAfEHdZcNSfwCNeXu2AQlCGD1vnkntdGhimisb02DgI/zO
 BIKD//3A3mZusoKRyNhAFs3eu5k4vxOzpAYz1ELUr6xAWlQSSN47H/K/UZCugHJ1ZWrL
 UodzjUQvprVTE4N9iSusTiGdY2SweNZFVBph/DB8Vq1Ld/ufDlA7gsKFF4M+eGQCEgig
 nkfczsDwYVM2z4DP0hnVBI8TWnokIM/+BXhQmAauDec/9kaBujGljtiw285VAsEwhhbV
 rzmQZoHj1jwGpvopXa3mVp6Udq6nflwr/WNtZzqah1oPCEbmGQxiIJafoRilHybkjNh/
 +Ruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550352; x=1709155152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w/0nxiYdmkxhHFcoyS3JZWxjubFyxLiPoIZ7GwIxEsQ=;
 b=BzL/nJWz5ZJxmV/f8bk8XzV/qICwTgEWjzzD8D0D8qFnSipWQUE6qzOgeItc+vb7ez
 khEKdrG0qjBx86K1LkMgUGwGTBfx53GsEFFZ+PZkwUxPNxYXUnzEPne4j3fNSuPDmgT1
 w0WWuv5wNG8O5S45vKtrHH46k38mFy7HDFlg+EN9oy9hLRkYWbZynsmLeIn4iQaL4S7U
 AzaXQf6nlRlIFquxvQ/OC3/D4Hl24H4lE5xkbN6NVLxEaMV7U03t60XLf4dUQteWgmFA
 uKLtGTtcH8QrC8DlIiQrRg0EoY2ZUb01wBiGv4Ad6/4K7228Zs36RkiZlcvknxy6hB7c
 IYxQ==
X-Gm-Message-State: AOJu0YwiZBrpTa65cyAmJefxtGY/99mxkZWlfh0dT82PKdT88dTgPK/U
 YOvDiBX4+uSpEo12zSywa8LZL0iEdVe6Mx0fcSS74ZbE58VMWH4iku3PPhMQc2QsljHt4CG2ym/
 DOFM=
X-Google-Smtp-Source: AGHT+IHyN+IOXDgmMOArYsOeWjs3fsVaeo64Fgkqjs5KXLiQD8O+hDzV+x+4jDWPWqUL/uj4kRVAgQ==
X-Received: by 2002:a05:6000:1542:b0:33d:28a9:2fd8 with SMTP id
 2-20020a056000154200b0033d28a92fd8mr13726735wry.39.1708550351870; 
 Wed, 21 Feb 2024 13:19:11 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 bk26-20020a0560001d9a00b0033d568f8310sm10168971wrb.89.2024.02.21.13.19.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Feb 2024 13:19:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 John Snow <jsnow@redhat.com>
Subject: [PULL 23/25] hw/ide: Remove the include/hw/ide.h legacy file
Date: Wed, 21 Feb 2024 22:16:23 +0100
Message-ID: <20240221211626.48190-24-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240221211626.48190-1-philmd@linaro.org>
References: <20240221211626.48190-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

There was only one prototype left in this legacy file. Move it to
ide-dev.h to finally get rid of it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20240220085505.30255-7-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS               | 1 -
 include/hw/ide.h          | 9 ---------
 include/hw/ide/ide-dev.h  | 2 ++
 include/hw/ide/internal.h | 3 +--
 4 files changed, 3 insertions(+), 12 deletions(-)
 delete mode 100644 include/hw/ide.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5535df4487..9dd98a923f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1937,7 +1937,6 @@ IDE
 M: John Snow <jsnow@redhat.com>
 L: qemu-block@nongnu.org
 S: Odd Fixes
-F: include/hw/ide.h
 F: include/hw/ide/
 F: hw/ide/
 F: hw/block/block.c
diff --git a/include/hw/ide.h b/include/hw/ide.h
deleted file mode 100644
index db963bdb77..0000000000
--- a/include/hw/ide.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef HW_IDE_H
-#define HW_IDE_H
-
-#include "exec/memory.h"
-
-/* ide/core.c */
-void ide_drive_get(DriveInfo **hd, int max_bus);
-
-#endif /* HW_IDE_H */
diff --git a/include/hw/ide/ide-dev.h b/include/hw/ide/ide-dev.h
index 1f62e58ebc..708cc0fda3 100644
--- a/include/hw/ide/ide-dev.h
+++ b/include/hw/ide/ide-dev.h
@@ -179,4 +179,6 @@ typedef struct IDEDrive {
 
 void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp);
 
+void ide_drive_get(DriveInfo **hd, int max_bus);
+
 #endif
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index d3ec16a945..20dde37f45 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -4,10 +4,9 @@
 /*
  * QEMU IDE Emulation -- internal header file
  * only files in hw/ide/ are supposed to include this file.
- * non-internal declarations are in hw/ide.h
+ * non-internal declarations are in hw/include/ide-*.h
  */
 
-#include "hw/ide.h"
 #include "hw/ide/ide-bus.h"
 
 /* debug IDE devices */
-- 
2.41.0


