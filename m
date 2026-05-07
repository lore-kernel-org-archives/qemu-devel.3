Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A2BCD3436
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoWa-000054-He; Wed, 06 May 2026 22:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVl-0007Wg-PG
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:54 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVf-0000ZE-TC
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:46 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d4be94eeacso417700a34.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778121041; x=1778725841;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WC0vAoB2JrxhCnH6uJJk5wBT6sf05K3174sq655JkzM=;
 b=hqmZ5LmfgXi7oalJEfi/uvyJtfJxa+cktQefDRE3LNXo926k6tQi3c9qFPcze9/f1X
 fG8yDDaj2plIwW0sw3wa6lZxkx2KgaWkQTNiQnKK2MkhFWyZgZ4rmHW6a6OxVHzRCgfv
 EsshHHxdwcs+yovs6hCfgFDbApF5Xv0eO/YXayR1zQeuPBYsbHiDbO0Swc+LIid5ItGX
 BX7YGqXwStjAXt78NMHumiHit1Qc/37tNlKJ6NhHywHi4QliLVNwKQCgLsiwK0TL8cip
 ZubYBc9NSmZuBHd6FbFbgG5W1dkneRV3FujGoZ1d1rRsU+Ceh3kfNgfzxHREHd8JVI6A
 2kJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778121041; x=1778725841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WC0vAoB2JrxhCnH6uJJk5wBT6sf05K3174sq655JkzM=;
 b=r+ZRhRt7Q9VXTZpcyGGljDzX3ukH8qnzQiMYxrbQCTgZrjWTVnostDrStaz9qtNj0V
 BsfhkxTYsoHraOs0+VZ/YglSqyhV3XcEpcTeLwKXgsuC9tcf8aEOpcauosy14xhkQ/cu
 1py6HaMdrXayF60AYSrVIHcOHzoy85ySGKPRKlEzlJfvR0yQsP1IzGWrEjvvV4a8yqXc
 8xw2EuG+laRwEEJnYgO2YbPfTMaNGWSo0gr7kkrZyeU/AeCiPbIgdwXDbfo+BUeiH15p
 rokS5tBC55a/J93exELEjAaVlCFz5T4af1oMPUj3XisOXmpuHqQUzB7weJmyPsH9LHYZ
 7FPQ==
X-Gm-Message-State: AOJu0YwcjAmHN0y9oF2YLVINPfSw4aZC5d6/jWraeyrEqSplmFv0GWQZ
 ShjFROESy+4fMATgd+ezv1fzEDrE21Oo9gQEa+X8T55pK8P0Ztv6Fqv6p3B68WUGVCAJf3jvfX7
 HHBj0tAw=
X-Gm-Gg: AeBDiesDnVgMl+LO3x4wTFRaQQShmoJkPZXBFQiWh1DxK0gL/7mRgf/MvZb+O8ylFg+
 gcyrJ/1tji3hTBXZgQF0Uki/QnoflDW+ADzOI2B/Cr3lXR/dO5tb1tJn4ozHl+5K+RAsZsBfwi2
 THpcCeKsVfvr0r0KjmNS7PBVTCRxO1x1SpQdoWiXX/eNUFvM7/OUmXtr3t2REOmLQlazsukvqAN
 IEYNKVhK8Jv2IezhPNadsom13VBrWQHdpU5H5n7J6SQBT19nPMVXkU1Xn8BVyqWZ1z/oLrOyCvR
 E6g7XbkTSLiZ4w/aqQPRFYtn5t7KzFD6fAiWGZRyU2JeHbolM/qtcZ761PVvKA4NpFBKZLS0L2e
 CE42QFr72d69PNdCS70qarWpvAKMgVQ5+T7xEbdRSvJFs8nlBdPetVVZ4KutAD92rC5SMXatIgM
 Z5kIrVsK/WbWezEzpVhqwK
X-Received: by 2002:a05:6830:828d:b0:7dc:db04:d316 with SMTP id
 46e09a7af769-7e1deece6dbmr3972933a34.8.1778121040966; 
 Wed, 06 May 2026 19:30:40 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ded1915908sm12465247a34.14.2026.05.06.19.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:30:40 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 19/25] bsd-user: Add log_unsupported_ioctl function
Date: Wed,  6 May 2026 20:28:21 -0600
Message-ID: <20260507022827.44499-20-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022827.44499-1-imp@bsdimp.com>
References: <20260507022827.44499-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32e;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Add helper function to log detailed information about unsupported
ioctl commands, including direction, group, and parameter length.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index 94110d4ad5..2d84adce71 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -217,3 +217,27 @@ static IOCTLEntry ioctl_entries[] = {
 #include "os-ioctl-cmds.h"
     { 0, 0 },
 };
+
+static void log_unsupported_ioctl(unsigned long cmd)
+{
+    gemu_log("cmd=0x%08lx dir=", cmd);
+    switch (cmd & IOC_DIRMASK) {
+    case IOC_VOID:
+        gemu_log("VOID ");
+        break;
+    case IOC_OUT:
+        gemu_log("OUT ");
+        break;
+    case IOC_IN:
+        gemu_log("IN  ");
+        break;
+    case IOC_INOUT:
+        gemu_log("INOUT");
+        break;
+    default:
+        gemu_log("%01lx ???", (cmd & IOC_DIRMASK) >> 29);
+        break;
+    }
+    gemu_log(" '%c' %3d %lu\n", (char)IOCGROUP(cmd), (int)(cmd & 0xff),
+             IOCPARM_LEN(cmd));
+}
-- 
2.52.0


