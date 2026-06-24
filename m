Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65683CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcPyJ-0001Fo-TQ; Wed, 24 Jun 2026 11:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganeshredcobra@gmail.com>)
 id 1wcPHo-0004zN-UZ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:13:09 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ganeshredcobra@gmail.com>)
 id 1wcPHn-0002GY-IJ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:13:08 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4629051c9d1so787795f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 08:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782313986; x=1782918786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QlfJoCXbjDGNlYb+upE3XSiaOkS1IdA89W46SKGJydE=;
 b=nsQBU/xxWgaChdgtlsv0a1Zsb4YBvpClRigOKdZVvgLI473h7CAE6fI71MgfdHRLA4
 f4Fy40do3BrJp1G7xUoi7ulnGrwP0PmNyhk4A8lpZ4Lmfk5M2DMpGvWD7wn1RNPrHNU7
 wpN7qH0m7H6OwcR+87EcDOW2rJ3F8fmsFqOHnWoSZECEzIuoiguaCD2xXG689UJtwFR+
 Rkzce/u0F3vgHm5PBsAWYn2cHVZ1eUHJ32VbWWDc3jhhSYAH5vfbO0HH1Fn6Jy8NbZ3W
 A/uyybx/qYpeKqzbGz5BjSMNiqPxNAF7yBHjNinPyrbMStCM0DgjjCkstXkJ5s60UvnD
 G/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782313986; x=1782918786;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QlfJoCXbjDGNlYb+upE3XSiaOkS1IdA89W46SKGJydE=;
 b=emlt0nS331ZmPxC1Z636HlsD+WS8Fwk2vSbtFwrl6+hWJnKyjAKNo/slpLk8LcK/xm
 ncAn5Hj3oa/zmk9iv61yUQrqeSVov+qeeeHAv8xujdOOUQLm9GZ7YFlmoy8i77Hn1Utr
 WhWqzXVbUh/tLGsxNKWA+CSx+pg1LB8TBdCI12rfZMd8EnO0bAyFXo+FS/H5zKna3Y52
 luZj5RlBYO4W+9aBd3TzfXsJAQQFIJxbUMTBuqdG8BGU/y7lYU9fdOYldYONLe6jyvND
 N4lpSETZZi0l6/YtTXkbOxFyX//9r3PDO0JZjhOjQUUclhV6Du3agGFRyneHKNB3Ot2S
 nR9g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/G1eSJTk2skNsBSZfU/AFGChzjE0yvwDCLKLoOmJ3OYPKM5gelQHnCtEEIGiXTVz4cFddXybBbF18@nongnu.org
X-Gm-Message-State: AOJu0Yw2BUvKe9AtCBX6j1qnchvJ4o96tmzazpKJy9reqdjG1ZEi1IpM
 yCLfL66k+khFvLC9zA+C/sGJbJEugEM4+tc5g6p4bHHLGjiwNu5AhKxD
X-Gm-Gg: AfdE7cnQQL9gOjnpmi6GYL2i4EdP6cZ69wPby2u+emyvy9G1wWZxsZXo46f3d4cebus
 BqtNtKjib1O/5jV9wIVlsUNRBuf6X/a50UmE/yuKxV8CG4WpYRXPyI6jvTxsExGhXu1SdbtY6ux
 XYUtdbFjkdOzHRHxx31JSRt0oO0AMSkoTqwsNKB+WjUkOD9cLGcjcQTXPEgEpVD2P+L0B+U0s5F
 QsS+7fL1VSNvdMIZgjri+cmMyU+AO8lznCIDVoTHrng6eNW/5IRaKVcq5iebgXN0tjwrxNjwLcb
 kXfddC6e5spaY6ZVEWD2dCToCPJpnckXu0XsKz7LFNEM05LIIGrUg3pASg85vpC4nlOhkispwKW
 Z6T7PFyo/KpOC57UcdbtoziO6FST5VGxCllsKS8qN4JiVWqzpsEpfJSPKA9SbSPlGs/M4GrmxLT
 n6REUV9J6inxliV7CsoNN1pHQPNrg=
X-Received: by 2002:a05:6000:41f8:b0:460:e4d:bd46 with SMTP id
 ffacd0b85a97d-46c0bd7c9d6mr5653052f8f.21.1782313985667; 
 Wed, 24 Jun 2026 08:13:05 -0700 (PDT)
Received: from localhost.localdomain ([86.2.40.231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c2279b7d7sm7283417f8f.31.2026.06.24.08.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 08:13:05 -0700 (PDT)
From: Ganesh Harshan <ganeshredcobra@gmail.com>
To: philmd@mailo.com
Cc: zhao1.liu@intel.com, qemu-devel@nongnu.org,
 Ganesh Harshan <ganeshredcobra@gmail.com>
Subject: [PATCH] hw/core: fix else placement in sysbus.c
Date: Wed, 24 Jun 2026 11:13:02 -0400
Message-ID: <20260624151302.31280-1-ganeshredcobra@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=ganeshredcobra@gmail.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 24 Jun 2026 11:57:03 -0400
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

Move else to the same line as the closing brace to comply
with coding style guidelines.

Signed-off-by: Ganesh Harshan <ganeshredcobra@gmail.com>
---
 hw/core/sysbus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 3e1160ee92..c07afaa802 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -132,8 +132,7 @@ static void sysbus_mmio_map_common(SysBusDevice *dev, int n, hwaddr addr,
                                             addr,
                                             dev->mmio[n].memory,
                                             priority);
-    }
-    else {
+    } else {
         memory_region_add_subregion(get_system_memory(),
                                     addr,
                                     dev->mmio[n].memory);
-- 
2.47.3


