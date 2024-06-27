Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3613FC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpLu-0002hl-HK; Thu, 27 Jun 2024 09:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpLZ-0001nL-2r
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:39:34 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpLX-0006ZT-D1
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:39:32 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f70c457823so54392185ad.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719495570; x=1720100370;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IDtmLd4DIh+2XRkZ57QtXjyzkDOakOx1Ds4rKdXYuOE=;
 b=biy81hPqEVeom0tS62rhmoWFdc4gY0m71tzlpx6Ckby30aFmqMysTmlzrqKFn941PK
 kWpPIAU8DNXPFWTilUyfLdflVpF7aw0Bs0m0YcdYk0pkTY3lCvA3VQIkEtVkQd4QROcI
 +h28A3U6YpvvwgnO/56ZJBMDOOG/+6v53nv+FA2cZMDPNeCJDtqrgdi1T/v6Y8VbgbVc
 lMxD/pex0bMBr8tEhswoMEqaaROwHjxaGAqSGtcBPxH/S+MDtYA9pb4wpuheb/tZfMFd
 GastiCS36BCO2/WM1nrCWbxNZg6oDRloBAF43DwT33nEO226OWIWJC98WJXETRrt/mrB
 yfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719495570; x=1720100370;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IDtmLd4DIh+2XRkZ57QtXjyzkDOakOx1Ds4rKdXYuOE=;
 b=K4dwbD9R7BvyhTDsLCR5IM8+v1SZksHkfp/Ht3i8EH1KvX+l2MLu+rqBqwWDief1sD
 0SM53xJsXItEtOJFfH9lsIV06BhPSCLZIBPTOIon6uXcZ/GLciETNZX6W1vcCPEgGlKQ
 DLO7M/h0LXwrmfFXtzOvE/HkzR1BDKilyyL4M2gPMs/OhOGamVK3yx6GjZqW7HJgEBj2
 EX5pYWD1aiCROtgLx1X6g8evz6Fsc4IAZiU3Tg3r4lwMMDme3g8lAoAA5PN/Niqb8OCw
 LfhBC9jZHW4hy7HKdJg3rakQPKam2J1X3DKA9eXihu6HMoCkWTXMw3WeX/VAXUWx3awI
 lCYA==
X-Gm-Message-State: AOJu0YxIyVjd2hmXvdM0nifvoz7/x5Ao+4igsyEv3sKzw4STd6eX9XGe
 VX3+H9JVFCWUSMrgoWlkNe9dtwspiqpT8qqsFLQxSUPhI6krdbg3IkI6+mSu/nE=
X-Google-Smtp-Source: AGHT+IFzIGW+nsnWdJPHEbiNrp488hVRGEdrshmaBw10w7xHcEQJxXBh3T4EQrvFSPo6JhGmFg7hsQ==
X-Received: by 2002:a17:902:e846:b0:1f6:502d:ca88 with SMTP id
 d9443c01a7336-1fa23f15aa5mr134051625ad.49.1719495570044; 
 Thu, 27 Jun 2024 06:39:30 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1faac9c5266sm13108905ad.307.2024.06.27.06.39.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:39:29 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 22:37:56 +0900
Subject: [PATCH v2 13/15] tests/qtest: Delete previous boot file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-san-v2-13-750bb0946dbd@daynix.com>
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
In-Reply-To: <20240627-san-v2-0-750bb0946dbd@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
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

A test run may create boot files several times. Delete the previous boot
file before creating a new one.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/qtest/migration-test.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b7e3406471a6..5c0d669b6df3 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -129,12 +129,23 @@ static char *bootpath;
 #include "tests/migration/aarch64/a-b-kernel.h"
 #include "tests/migration/s390x/a-b-bios.h"
 
+static void bootfile_delete(void)
+{
+    unlink(bootpath);
+    g_free(bootpath);
+    bootpath = NULL;
+}
+
 static void bootfile_create(char *dir, bool suspend_me)
 {
     const char *arch = qtest_get_arch();
     unsigned char *content;
     size_t len;
 
+    if (bootpath) {
+        bootfile_delete();
+    }
+
     bootpath = g_strdup_printf("%s/bootsect", dir);
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         /* the assembled x86 boot sector should be exactly one sector large */
@@ -164,13 +175,6 @@ static void bootfile_create(char *dir, bool suspend_me)
     fclose(bootfile);
 }
 
-static void bootfile_delete(void)
-{
-    unlink(bootpath);
-    g_free(bootpath);
-    bootpath = NULL;
-}
-
 /*
  * Wait for some output in the serial output file,
  * we get an 'A' followed by an endless string of 'B's

-- 
2.45.2


