Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA51C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMoBi-00006T-Df; Wed, 04 Jun 2025 09:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoB3-0007L4-Rq
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:29:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoB2-0004mv-6f
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749043745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oiv9mkdGy8q617zYG7K09rWE+WhVRWSHIK3bd2uZ1Uc=;
 b=eR6PHBZwGfz6FP5aZwwmtRdD4eKfG+eZ0vtBKQmA2ldZlV3hahYSrRDzfm4EgX24fcwGQt
 gYsfJNI4riA0OrRDBT0ZLDgBGCtw5eBnsK0iYiNYutyIK3XhQ9XjSJLLJW8Axqj1T12wg6
 1WtDLcZWVqjPG1RdwTEWtTL1pYJBwlo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-jlcT2VBHPri96MrLMptj2Q-1; Wed, 04 Jun 2025 09:29:04 -0400
X-MC-Unique: jlcT2VBHPri96MrLMptj2Q-1
X-Mimecast-MFC-AGG-ID: jlcT2VBHPri96MrLMptj2Q_1749043743
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4edf5bb4dso3769794f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 06:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749043743; x=1749648543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oiv9mkdGy8q617zYG7K09rWE+WhVRWSHIK3bd2uZ1Uc=;
 b=CiiHKOh5JHKwzQnxxWsW+PdxrCJ1T96mpmv427yv528an6oXBc+dLSjv45q1E5pLWh
 cOHxpROcIWusPIC2ztxvkO8PYKvFAMQPaMEctLxzX2MB2m9w4GQYt6QUsvJH9EYPWGZ/
 BwgGFcu63IQqSkWmPc9G9R4FHmgjd9j1vb9XcvAnGmpcsb3P7VB43HdwCFxXsDqETdIL
 Q76OTRHA9ji7F7fVfuOIoo1JOLFNQ8hcjf89Gny7aVsjo8K46HWIax/b6IetQTrny4w4
 gk5P/v5oNuodwhm82K1o2ADNTMhUylNbk6nowGEuQ0hrfRCSuxc9JeL9aGpg1OoTyjGA
 8amA==
X-Gm-Message-State: AOJu0Yxo0hr7PfQdOjVclsHYvPAYyT6sty23TlaleoZNygf2f4f2PHyF
 YVZfmQ59p9X+uq51OGLrtl/WouHzo3vNsP/jHpozbo1mJWcQIUzXlNsYd3ZtkBKbdDNNhBY6TQf
 N8rD+qZY+0cSPKgXy4mLoCOn5iDN3fnJ2V2nDe8vVsv+uuxBqTd5ZuKgJ
X-Gm-Gg: ASbGnctkdWAulkyTYqSdU3LXjwm7/JykA4L2oy8w1evVTkctVXxI30rkd0DCNl08It8
 jTsZ9L5c3y9aWgsJt+TOcz7DTE8qRLiGZ/3XEnhmLrL3c3hiLP7ve1YhJV3s6iDPpGINQ74+4qn
 u1TCN1mtI47Jbn2CrP+QBSOl0K0orz6rediyV02PZM+JCumxAtIDXvboTs6DofaxiGpR6CSPK5F
 HUiJmJZ9yKUkWlghJeJ99IwNnQbKaBpadqGiGMPoqGsI34muNiIALp6w23XT21eJgB4kCREBFFq
 VM248IT+JvDce4vxZMg4b0yn/Cz4InIeWWvtzPFBLx2p63dtJdTtKlS2dPpQpodGEJLkRg==
X-Received: by 2002:a05:6000:1207:b0:3a5:2599:4163 with SMTP id
 ffacd0b85a97d-3a525994257mr200896f8f.47.1749043743308; 
 Wed, 04 Jun 2025 06:29:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiQY2GgcwKnT5RKi3ZCAN7r8Se6lCeVHmNL0FrikmEyx5/wfz4rsFV5BPrwL620qh0hjJItQ==
X-Received: by 2002:a05:6000:1207:b0:3a5:2599:4163 with SMTP id
 ffacd0b85a97d-3a525994257mr200874f8f.47.1749043742834; 
 Wed, 04 Jun 2025 06:29:02 -0700 (PDT)
Received: from localhost
 (p200300cfd700f306503d3c798c1bf214.dip0.t-ipconnect.de.
 [2003:cf:d700:f306:503d:3c79:8c1b:f214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f8ed32sm197816855e9.1.2025.06.04.06.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 06:29:01 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v2 12/21] block: Move qemu_fcntl_addfl() into osdep.c
Date: Wed,  4 Jun 2025 15:28:04 +0200
Message-ID: <20250604132813.359438-13-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604132813.359438-1-hreitz@redhat.com>
References: <20250604132813.359438-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move file-posix's helper to add a flag (or a set of flags) to an FD's
existing set of flags into osdep.c for other places to use.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 include/qemu/osdep.h |  1 +
 block/file-posix.c   | 17 +----------------
 util/osdep.c         | 18 ++++++++++++++++++
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 96fe51bc39..49b729edc1 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -774,6 +774,7 @@ static inline void qemu_reset_optind(void)
 }
 
 int qemu_fdatasync(int fd);
+int qemu_fcntl_addfl(int fd, int flag);
 
 /**
  * qemu_close_all_open_fd:
diff --git a/block/file-posix.c b/block/file-posix.c
index 9b5f08ccb2..045e94d54d 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1047,21 +1047,6 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
     return ret;
 }
 
-/* Sets a specific flag */
-static int fcntl_setfl(int fd, int flag)
-{
-    int flags;
-
-    flags = fcntl(fd, F_GETFL);
-    if (flags == -1) {
-        return -errno;
-    }
-    if (fcntl(fd, F_SETFL, flags | flag) == -1) {
-        return -errno;
-    }
-    return 0;
-}
-
 static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
                                  int *open_flags, uint64_t perm, Error **errp)
 {
@@ -1100,7 +1085,7 @@ static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
         /* dup the original fd */
         fd = qemu_dup(s->fd);
         if (fd >= 0) {
-            ret = fcntl_setfl(fd, *open_flags);
+            ret = qemu_fcntl_addfl(fd, *open_flags);
             if (ret) {
                 qemu_close(fd);
                 fd = -1;
diff --git a/util/osdep.c b/util/osdep.c
index 770369831b..ce5c6a7f59 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -613,3 +613,21 @@ int qemu_fdatasync(int fd)
     return fsync(fd);
 #endif
 }
+
+/**
+ * Set the given flag(s) (fcntl GETFL/SETFL) on the given FD, while retaining
+ * other flags.
+ */
+int qemu_fcntl_addfl(int fd, int flag)
+{
+    int flags;
+
+    flags = fcntl(fd, F_GETFL);
+    if (flags == -1) {
+        return -errno;
+    }
+    if (fcntl(fd, F_SETFL, flags | flag) == -1) {
+        return -errno;
+    }
+    return 0;
+}
-- 
2.49.0


