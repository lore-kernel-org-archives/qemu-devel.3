Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF081C3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 06:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQiIu-0002cR-2e; Mon, 08 Jul 2024 02:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQiIr-0002Oi-Ce
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 02:56:50 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQiIp-0001xd-QV
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 02:56:49 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-73aba5230b6so2253738a12.1
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 23:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720421806; x=1721026606;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MN/3EfVBXv6jlnRXRpQP7cJiMDwiSYrMczZXVrsioJo=;
 b=CVHIBlG6ZYWbm6eW/FFo4zw6tgCIxUd4I8YE1vobOK1hismy1p1kXvIXr7+y804g+Y
 T2vGjxo9c0D14yqxSYy7X/N/h8uh5gZfmxPI2+YUMkA9TTGoXzGFzuc6sTcXIuN5atRj
 5a59DXKScNUlUk1VYgMi/zM+c1Yn7ab8XT5OnaZDcpsEvTJ7RAaMSgssCNVV9nDAXZG4
 pt1wEW80x4oMjAsgfnIhHjubT9YGgtHPr9llmoeHAnf9QKopChZmBiuqwHJrnAuUyRar
 XzjBXFgCJapN7GzFfREuHC0X9BpfKqI3Q77MVec0FMrqxnqlQR5m6n+3nXI0pqYjjpcE
 Q80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720421806; x=1721026606;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MN/3EfVBXv6jlnRXRpQP7cJiMDwiSYrMczZXVrsioJo=;
 b=OiWYn4L0jnu9JQamA06weQ1HLmFWMxAjQN6KqaQg5CBwWUKJbA6iS8n2EchYLrQkAz
 nvwdCFvLeK7Hdv8WDAc9S48FfAtDwvqoHJZEaw70R096jQJCpzi8qJ0zYoeUuEjfUKdY
 NesMObdvN1J5osYF3mKSJ4hzawwTFeYoqO8G/vF2g+QYTSLaM5OG7r0sVk7NBphZaUky
 pn9gGlI3GNU0nLcb6LxLm63IgIlBPo0wLOWBHdC3Wq/ZpLJkxxCFO24EQ8jKAAq/NbEa
 FvrotpmeFy5FkqJansnsuc8F0NfENni1YvEgoCt6uWxVcO1IDsCym6J0NBxihF8/ILUk
 gO3w==
X-Gm-Message-State: AOJu0YzUCYeDsz5r+zMVuYubAzT7oc97UD8qtoqni/683QSzb6lPKesA
 It0sGOxjFzVgQ0aRWJER5uEXUSF8P5SRzAH3ZJYeiyVHzFKcloTbz6hxscfFjQw=
X-Google-Smtp-Source: AGHT+IHP6b2+9XmIFVTQc3FtbQmi+g9ayoGwvJXvh/X9w5iLuVeTzCzpwSPN6ELi+UNELouIc67xUg==
X-Received: by 2002:a05:6a20:cfa3:b0:1bd:2c3d:ccae with SMTP id
 adf61e73a8af0-1c0cd203e34mr14896527637.29.1720421806264; 
 Sun, 07 Jul 2024 23:56:46 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70b27349696sm2284625b3a.75.2024.07.07.23.56.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jul 2024 23:56:46 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 08 Jul 2024 15:55:20 +0900
Subject: [PATCH v3 9/9] tests/qtest: Delete previous boot file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-san-v3-9-b03f671c40c6@daynix.com>
References: <20240708-san-v3-0-b03f671c40c6@daynix.com>
In-Reply-To: <20240708-san-v3-0-b03f671c40c6@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::52a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/migration-test.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 70b606b88864..6c06100d91e2 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -144,12 +144,23 @@ static char *bootpath;
 #include "tests/migration/ppc64/a-b-kernel.h"
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
@@ -177,13 +188,6 @@ static void bootfile_create(char *dir, bool suspend_me)
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


