Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2184EC47E49
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 07:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSXtw-00036J-MY; Wed, 24 Jan 2024 02:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSXtt-00036B-Sq
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:42:21 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSXts-00034L-E0
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:42:21 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3394b892691so320453f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 23:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706082138; x=1706686938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iAI6SzwuMj1fhJkYbViGKDOa9P8dnzcSn0icKU6xRVc=;
 b=TdjHpQl6HeC5xhmOjRLRiK3M/4SUV3D6v9A2heARnxXi6BojDyESpya/dh30LKE6/K
 IkRzzry7eAvZ7/5mVLYUih1c7qXDwAUORLH3qZT3hO5UhE8LnEUetHhNkNH6tkjmgiy+
 vCAESeXtJLnbpbP5utI6a9nzVo+iylPF9y0f2nZsRMjm04v2FwTlDwsz4DNIpJAku2rd
 gQiICxS5t/XKd6xZany99UJYRrZrEFP2Hd6je5oT0BDf0vTW1Ye2LdJbf4MXBaxrPjUN
 8maaRiDD6+GOvi3fGmZD4HjSOIOQXSMXvqS/rugSuiuKb6dUsak0HaugT81s5HF0k6MI
 Pkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706082138; x=1706686938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iAI6SzwuMj1fhJkYbViGKDOa9P8dnzcSn0icKU6xRVc=;
 b=CWCOif9FKnrdhU2ZuNsP+XgG0jXIu2gPD3/Lvl1T4nasuTJQh6XDcQ5uvA7Ssclt+3
 mazNlEDgyg7UQgGF7SRsYZi9kTkv175x+3if3qEPJkQSAn3rT1aWS8mUAKlF49ZYTQG2
 GvYwwCZnuqXYBjQYmkTGte6sRhUJns4HUnaDDU5MLrJ5pC49TBuJ/TUgX54E2WTV+5Qu
 1PWatduNPXE7dSCoEPjN/tEqGKenll/N+e54JX4q4tOni/ZT/Y7m3zVLsovVOL6728i2
 JlxM81yeajk/q6blkN3ORfC0/zC7sduiGRSoheS3DIDDVQ5yfTJ47M4LlZcrMMc7RH5D
 Il6A==
X-Gm-Message-State: AOJu0YwsNbkKFa6V7gfvEHIjuaxhJi+0MwqO8sJkPoxe4DZv7jmq//8H
 5/Hvm4j83jQvHrTv7n5AvwNJwuemq6jSb67NoLLriR63cP5nCvVbzyH3bAyHRbcK2PpUQqQ1OMj
 Z
X-Google-Smtp-Source: AGHT+IGLYsCawyckldBMFLt8E2tj6bEkv9xYRvgwrFbangmc2csRrY8sBNkSsJiwN/U0muDyoH3LDA==
X-Received: by 2002:a05:6000:144a:b0:339:47d7:6527 with SMTP id
 v10-20020a056000144a00b0033947d76527mr281803wrx.0.1706082138385; 
 Tue, 23 Jan 2024 23:42:18 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 l11-20020a5d674b000000b003392c727cadsm9218653wrw.27.2024.01.23.23.42.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jan 2024 23:42:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Greg Kurz <groug@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/6] hw/9pfs/9p-synth: Use RCU_READ macro
Date: Wed, 24 Jan 2024 08:41:57 +0100
Message-ID: <20240124074201.8239-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240124074201.8239-1-philmd@linaro.org>
References: <20240124074201.8239-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Replace the manual rcu_read_(un)lock calls by the
WITH_RCU_READ_LOCK_GUARD macro (See commit ef46ae67ba
"docs/style: call out the use of GUARD macros").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/9pfs/9p-synth.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index 0ac79a500b..419ea69e3a 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -241,15 +241,15 @@ static struct dirent *synth_get_dentry(V9fsSynthNode *dir,
     int i = 0;
     V9fsSynthNode *node;
 
-    rcu_read_lock();
-    QLIST_FOREACH(node, &dir->child, sibling) {
-        /* This is the off child of the directory */
-        if (i == off) {
-            break;
+    WITH_RCU_READ_LOCK_GUARD() {
+        QLIST_FOREACH(node, &dir->child, sibling) {
+            /* This is the off child of the directory */
+            if (i == off) {
+                break;
+            }
+            i++;
         }
-        i++;
     }
-    rcu_read_unlock();
     if (!node) {
         /* end of directory */
         return NULL;
@@ -494,13 +494,13 @@ static int synth_name_to_path(FsContext *ctx, V9fsPath *dir_path,
         goto out;
     }
     /* search for the name in the children */
-    rcu_read_lock();
-    QLIST_FOREACH(node, &dir_node->child, sibling) {
-        if (!strcmp(node->name, name)) {
-            break;
+    WITH_RCU_READ_LOCK_GUARD() {
+        QLIST_FOREACH(node, &dir_node->child, sibling) {
+            if (!strcmp(node->name, name)) {
+                break;
+            }
         }
     }
-    rcu_read_unlock();
 
     if (!node) {
         errno = ENOENT;
-- 
2.41.0


