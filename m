Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D12E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 16:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNDk2-0007TC-D1; Mon, 16 Dec 2024 11:14:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNDjj-0007QM-3J
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:14:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNDjh-00075Q-0K
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734365659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CvherdBf5rf3JXCiMOjI4Z7bSXnBurw8KTrk/OuOE+M=;
 b=dmaTNZQ3sZdBIRh2k0R2prSEo4tj08OdXok3/NYjvlXRLeCTBW/pqLkEWB9TKnkF6+AVhe
 lI83nxbaQUg7/K0D3imQB1rvpH/yLtL4OPt+qOHjq137yN2mg4f71BYCjAdE/SO8+OEVun
 JaQOmXA8W2W8uiwQN/4IFglw+/u2MAM=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-ONouCXh3PKOcQXX_I26Nvw-1; Mon, 16 Dec 2024 11:14:18 -0500
X-MC-Unique: ONouCXh3PKOcQXX_I26Nvw-1
X-Mimecast-MFC-AGG-ID: ONouCXh3PKOcQXX_I26Nvw
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3a9cd0b54c1so45536135ab.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 08:14:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734365657; x=1734970457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CvherdBf5rf3JXCiMOjI4Z7bSXnBurw8KTrk/OuOE+M=;
 b=iZmzlfgLrDJmMwPt4qT1Ibq2Ca64BBOwhjBeR89tjhLgn/dy/ZfI0bDGZ6VhKm96bk
 eZsFN9/UO8ez3gi9TeCcTvH3P0yxD3m1DUpC3CLpcUh2SjrCxgHydp1R6c+4Qk8mtxxQ
 DZKSFUEq3RIIbj0Ms5nkdAAobeQ74/+M7jfauVNjTSFyEkUv+zhQxO7nM86LyCxcgfaR
 DyPNobnoBz8ML7qEr8pkp24eUjKezghuUqi4WYl223kDr7S9kiedD17JFBUR/mZHQk15
 E2DQzha5D8HhjpUQzOopr9ywndv2xpQcug0PWpq22QVwl4F25xCgDo6s89CKrZO7ZPsn
 TsRg==
X-Gm-Message-State: AOJu0YzGotknxtl0/3qgnUY8Uy8xgXdKRu4Sd968HpSLKbCayCA91Vyu
 CZ1u0PMq/Rkb+NS+m7C3gOoAeLaSLuMaKFAo9va+RZPz+6LK2+/DddZiqpVp7H33D67dFfr7MAj
 x6aTV5G98hH43nQa7K3BApyk9O3yX4u130is17/rwfE+hIRpckdzorYKq/fHO8sfaK27PH8UA/W
 ieDRDhFK23RPqc+YyK5kh1hkkpiFIgCJlldw==
X-Gm-Gg: ASbGncu7xto53uTQq0MPnsfM1sQs+a86Zng0T5lQfHIFdj4trrZ15LhjheeUAmGFKs7
 FUqKZNcrTd8MGCPoyf4ysG800c23hqbqa6DHJh7u9LYylW2Qv4mQAEqEz7zxAjW7q9kP/UQz9/y
 LNuSnWF6JrXOo02HPpPcKhfk2hxLU+yX/L0qpPH8U8ft+W/shKBWsF0eHOwuI2KoE+ZlW5PkqBi
 JMH3X8atLxhOCZQadu7nRk5nBfSUSy2ta2r7QDXNWffyYMaJr1zHv2+hQsk1VpcqBWSE8+78oBl
 woq4Fqud6P28HcRmhXlX
X-Received: by 2002:a05:6e02:1a84:b0:3a7:8720:9de8 with SMTP id
 e9e14a558f8ab-3afee9a26a9mr141621075ab.5.1734365657362; 
 Mon, 16 Dec 2024 08:14:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdkqi5dSMkPNwgvZ9pg24TKari3UnSfuMVbqp9yvxokvS1Npp0k7HVuMJnMzeY1CEbI8hLxQ==
X-Received: by 2002:a05:6e02:1a84:b0:3a7:8720:9de8 with SMTP id
 e9e14a558f8ab-3afee9a26a9mr141620705ab.5.1734365656922; 
 Mon, 16 Dec 2024 08:14:16 -0800 (PST)
Received: from x1n.. (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3b248cb74fbsm15895765ab.34.2024.12.16.08.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 08:14:16 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH 1/3] osdep: Add qemu_mkdir_with_parents()
Date: Mon, 16 Dec 2024 11:14:11 -0500
Message-ID: <20241216161413.1644171-2-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216161413.1644171-1-peterx@redhat.com>
References: <20241216161413.1644171-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

QEMU uses g_mkdir_with_parents() a lot, especially in the case where the
failure case is ignored so an abort is expected when happened.

Provide a helper qemu_mkdir_with_parents() to do that, and use it in the
two cases in qga/.  To be used in more places later.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qemu/osdep.h     | 7 +++++++
 qga/commands-posix-ssh.c | 8 ++------
 util/osdep.c             | 6 ++++++
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index fdff07fd99..dc67fb2e5e 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -828,6 +828,13 @@ static inline int platform_does_not_support_system(const char *command)
 }
 #endif /* !HAVE_SYSTEM_FUNCTION */
 
+/**
+ * qemu_mkdir_with_parents:
+ *
+ * Create directories with parents.  Abort on failures.
+ */
+void qemu_mkdir_with_parents(const char *dir, int mode);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
index 246171d323..a39abcbaa5 100644
--- a/qga/commands-posix-ssh.c
+++ b/qga/commands-posix-ssh.c
@@ -18,7 +18,6 @@ static struct passwd *
 test_get_passwd_entry(const gchar *user_name, GError **error)
 {
     struct passwd *p;
-    int ret;
 
     if (!user_name || g_strcmp0(user_name, g_get_user_name())) {
         g_set_error(error, G_UNIX_ERROR, 0, "Invalid user name");
@@ -30,8 +29,7 @@ test_get_passwd_entry(const gchar *user_name, GError **error)
     p->pw_uid = geteuid();
     p->pw_gid = getegid();
 
-    ret = g_mkdir_with_parents(p->pw_dir, 0700);
-    g_assert(ret == 0);
+    qemu_mkdir_with_parents(p->pw_dir, 0700);
 
     return p;
 }
@@ -263,11 +261,9 @@ test_authorized_keys_set(const char *contents)
 {
     g_autoptr(GError) err = NULL;
     g_autofree char *path = NULL;
-    int ret;
 
     path = g_build_filename(g_get_home_dir(), ".ssh", NULL);
-    ret = g_mkdir_with_parents(path, 0700);
-    g_assert(ret == 0);
+    qemu_mkdir_with_parents(path, 0700);
     g_free(path);
 
     path = test_get_authorized_keys_path();
diff --git a/util/osdep.c b/util/osdep.c
index 770369831b..3a724c1814 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -613,3 +613,9 @@ int qemu_fdatasync(int fd)
     return fsync(fd);
 #endif
 }
+
+void qemu_mkdir_with_parents(const char *dir, int mode)
+{
+    int ret = g_mkdir_with_parents(dir, 0700);
+    g_assert(ret == 0);
+}
-- 
2.47.0


