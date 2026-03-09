Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6CDFCA179
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfoB-00044J-CG; Mon, 09 Mar 2026 14:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzfoA-00043n-7f
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzfo8-0007r6-On
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773082700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qOy9OTL1uqEbN8LPQAT/LvbFrV6eEdN3lcnzY+kqSow=;
 b=MEbjlXmxC7lHQ2R6ZE6k40ajhqgoLSuDKaPyUlV49TtsN2oG84IXobaFYCOKW2BvF/7kPJ
 PshhanSksAvvUBXOA4U2VcVkQxvtx+UOPVGN12dShWaBYZhYwQVb2vRDAlOdPhLphopCq6
 XuBDWeJYQOjjwEClvZxEvrK8vl2IeRw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-1yWuiaJoOVSXmA7tQnwsFQ-1; Mon, 09 Mar 2026 14:58:03 -0400
X-MC-Unique: 1yWuiaJoOVSXmA7tQnwsFQ-1
X-Mimecast-MFC-AGG-ID: 1yWuiaJoOVSXmA7tQnwsFQ_1773082677
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-485397788b3so17411025e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773082676; x=1773687476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qOy9OTL1uqEbN8LPQAT/LvbFrV6eEdN3lcnzY+kqSow=;
 b=mWQibCxC7O63YHQ86ljUisKsz4oRqFOhFSlOMQCskVMgQdpIe2NsaQH+J4qI6/M4sb
 ej0L4jT1oQ0q/fod0YKGVXKR1Nm+2xhlu2GFiuOiCzFIlisd6ESaWwEsQYidDGC/9hCs
 LiJGtXJ/WjT3xBnE+udY8zHWOlmLzp0JOFGNxQFcS+0EbvQzl5PTmohzOqMxbeIOCtWG
 TCaJDaCQEHbY+hVF0IFe87EaxSifk2vqm5+ZowypR1+1K0MxQtNjVB5f4L3LOu+Kkjo4
 cp7MpcmfxfU9/EUOulgiE3dEAwENfdnPNPwXFgxwZykB1skrP5WI6DEsgkDiqCkqRm8w
 TgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773082676; x=1773687476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qOy9OTL1uqEbN8LPQAT/LvbFrV6eEdN3lcnzY+kqSow=;
 b=fIac4CjJzxMf2GtDq/2uoWdvpPk6mfjg9bVeBt9zbwDyNT2+8muGWR26WEEVJnkBbk
 IlsdwbZxFOFsVsDKNp2tRkJ9rA0YQSpcaSi7Pnw9HQjs7vRYDcun1c5wg2G6JnDhWfLD
 OrexlxZuNqwtUtKz0qY7Kw2ZxRxdqaEWu2KbJhms71gdDQJYcITwh4rLm8cgK1cH18WA
 FtzY26FtBvUCdda6MWjt7fEv6LpFaoWlQwMCTsmsSVIDhJ+HwUul6x2oSruPQt6HqAUB
 6UqDHDXN3cLmvtI1hP0B8OwDTUAh+XWLkGNa0ZCz7VqiTb2/iB6uNLWOH9LB6cDLHkmh
 c1Nw==
X-Gm-Message-State: AOJu0YzUoZLq0IgePb0ZbQ6GAVU1Rrw1nwBt9i5ZhPJzc6uLQ1dMxOB0
 eY2WCCKxZh5oO9rmsTWTBlEBNuj3ctgCg0Ka+9Q+GGZJno05OR8Zco8J2UVA6C3FzfXqhye8RAv
 3aUviCSZthEm8m1HeSWJ4SSg6VnEueDWbdo65Er3gvbJbkEv3wRRz9RE8DpAHx1UGJO1icfend3
 94Wj+/Z7m45aOsVqqfdxksrYIAwLgJq52uJg+UxDC3
X-Gm-Gg: ATEYQzxr8xZcbNpxSx1yJXCASbbiC4B6Ja2RW9TSrv2uus0AuCRCXxfpVaVxDoY5MvJ
 QISVpqIG5T3v53SwjKodACxWOYeXTaVfnz7eIUY/rTh606bDxnuHaQG55zKUaKfaS0rDgwF4iuC
 SwJfGWzDWfsjKyU0gqA00AeksZT1+dNH2uEiz4DXVkuRhNU4ss5wFqVVJudHzc5qIHyeupbcc+4
 fS7iGSixI+qIIorCN9PRlPqfsWrSYhH1IUCfhgrqLr08Y9fuuatejfd1kKf6CqdKmjlCKLLKpiT
 B68IAAyfQx8o85BFUCcWnLQKc+Bc5U6SH1rWUc/OePcEv+NZMaLSmM/44j1RqgPRf7Mh2WLLnaw
 z/hZmLI8oKRyj3NXxFdNsyurkh4Yv0Zbvq27vzCeRskAcD5Z10stluAMrXeBOMaL7J7xUZ+JEGP
 eU0NFbxeTrxuJe9WK5SYa+8vQszOc=
X-Received: by 2002:a05:600d:6452:10b0:485:299d:546d with SMTP id
 5b1f17b1804b1-485299d558fmr133143375e9.8.1773082676071; 
 Mon, 09 Mar 2026 11:57:56 -0700 (PDT)
X-Received: by 2002:a05:600d:6452:10b0:485:299d:546d with SMTP id
 5b1f17b1804b1-485299d558fmr133143125e9.8.1773082675637; 
 Mon, 09 Mar 2026 11:57:55 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852f369118sm82234845e9.20.2026.03.09.11.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 11:57:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Siteshwar Vashisht <svashisht@redhat.com>
Subject: [PULL 01/10] xen-block: remove NULL pointer dereference
Date: Mon,  9 Mar 2026 19:57:43 +0100
Message-ID: <20260309185752.76865-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309185752.76865-1-pbonzini@redhat.com>
References: <20260309185752.76865-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

If params is NULL, xen_block_drive_create calls xen_block_drive_destroy
with drive == NULL.

Reported-by: Siteshwar Vashisht <svashisht@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/block/xen-block.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 5dc4ba9d076..474c12fe4ac 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -883,32 +883,29 @@ static XenBlockDrive *xen_block_drive_create(const char *id,
     QDict *driver_layer;
     struct stat st;
     int rc;
+    char **v;
 
-    if (params) {
-        char **v = g_strsplit(params, ":", 2);
-
-        if (v[1] == NULL) {
-            filename = g_strdup(v[0]);
-            driver = g_strdup("raw");
-        } else {
-            if (strcmp(v[0], "aio") == 0) {
-                driver = g_strdup("raw");
-            } else if (strcmp(v[0], "vhd") == 0) {
-                driver = g_strdup("vpc");
-            } else {
-                driver = g_strdup(v[0]);
-            }
-            filename = g_strdup(v[1]);
-        }
-
-        g_strfreev(v);
-    } else {
+    if (!params) {
         error_setg(errp, "no params");
-        goto done;
+        return NULL;
     }
 
-    assert(filename);
-    assert(driver);
+    v = g_strsplit(params, ":", 2);
+    if (v[1] == NULL) {
+        filename = g_strdup(v[0]);
+        driver = g_strdup("raw");
+    } else {
+        if (strcmp(v[0], "aio") == 0) {
+            driver = g_strdup("raw");
+        } else if (strcmp(v[0], "vhd") == 0) {
+            driver = g_strdup("vpc");
+        } else {
+            driver = g_strdup(v[0]);
+        }
+        filename = g_strdup(v[1]);
+    }
+
+    g_strfreev(v);
 
     drive = g_new0(XenBlockDrive, 1);
     drive->id = g_strdup(id);
-- 
2.53.0


