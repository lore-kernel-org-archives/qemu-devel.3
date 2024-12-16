Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C863E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 16:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNDkE-0007g1-7E; Mon, 16 Dec 2024 11:14:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNDjl-0007Qs-OC
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:14:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNDjk-00075v-DG
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734365663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g/CnB5IoNrKWMuDTkN+UMJbePcwmIWh00AwU0aoHclg=;
 b=bd8k1oZArq9SFODIy+El+MEQAvKSXUv3H/uVY4+TB8/GwuyumGq9KMDsl5Cj5leK37gKGT
 7fYC3HUfMZyiTFTj0oyzRO9cIwzGiSk+vQRHpBYWjNo6s+pvUmZlRj3SMEvHZp60zJiipk
 ib9XFQJM5GO1Jy4UK7mI9ONozYuuX4M=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-hukpzl-hNjW3j0xSKUmeMA-1; Mon, 16 Dec 2024 11:14:21 -0500
X-MC-Unique: hukpzl-hNjW3j0xSKUmeMA-1
X-Mimecast-MFC-AGG-ID: hukpzl-hNjW3j0xSKUmeMA
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3a9d195e6e5so44134315ab.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 08:14:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734365660; x=1734970460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g/CnB5IoNrKWMuDTkN+UMJbePcwmIWh00AwU0aoHclg=;
 b=X54M6y/jq7cmttheAHzoNKwOTmkscPuX6ZXhBYdwwsNw245PvmlmeYdpdxUb0gsrH6
 +730pUERhb4Ah57/oBUo/YsbSxAx3KI+yv6LBaZ4W2N+hIf24sgVdu09rFSKLGToZuf1
 mVViiwtmBtZXXrDed31QCnxxDPbx4a+c0AKRnfNBvk3gBIkcq+pk407qNJBJS1n7grfh
 Q8cfkVLI4QSbEOtttQgnPcH37bCEFK6HdCKrr2WdWyXXdJz9oFF2KsYDd2HTUXDwoa+M
 Gw5yP2Yv6cRYEYgHEUl3UXWYEbPJ1qoZUvwoqk0+H/tYHnUEYmZpEjpppQnooT4YaBlC
 ezwA==
X-Gm-Message-State: AOJu0Yz1bBc8f8WagYoiuSy+Np4MseQB7mDEWOiAJJVz8ouO2sGwjYfW
 UgNF6iF6MrPjVo5kKCAO71Ru+PD5K0Z9s4n7sJ8O7uXc7tN9F7yOYo2l/d8cQbckVGVWa+l/50G
 ybfMPVum06/jabLt2MtbPSC9BBl8dlnmrBMcVo2PXhOEzSNF9Zs1LAvSgUOd0gHFBL5oSETfH7L
 gz6uBXwjP6iP7WWJeeHIDpvpGyIpl8n/I7Cw==
X-Gm-Gg: ASbGncvxagLMs2EhsTAcIq+e/Jfmrhaeze6euOqRnAYKxfGo07p+ouZfVoQNFBNyt6N
 6ZbI/hVXsfthJ5KSel4MIR5pW1BTG7j4W0d5HyyrimQsGMtdL6Qmuo/K5ZlY0PsqgtuTSa3nN03
 8iYkx8GZA3mVRMh9+c3paHBU6jmQkpgo55Bq1thoVH4xUSI3fgXDHZMu7vE+zWGOtKdifzc31vn
 nJayAJd6a8CoVYRoAsrLIU1idcdjxOZciqkkucSqbe/E/xvCvYiojTDg1XQI5lJh58+QCPBsXAa
 oU9vGtTNDbHfcIAQR9xH
X-Received: by 2002:a05:6e02:1c4d:b0:3a7:7a68:44e2 with SMTP id
 e9e14a558f8ab-3aff243f5acmr123265365ab.15.1734365660536; 
 Mon, 16 Dec 2024 08:14:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpdtPtt/n3cDmBJ/BANd5WmoQq9jHhGyKFGkNQUaETrosrZeDrpzjT3m11uiFrUcXySoFQ6A==
X-Received: by 2002:a05:6e02:1c4d:b0:3a7:7a68:44e2 with SMTP id
 e9e14a558f8ab-3aff243f5acmr123265115ab.15.1734365660162; 
 Mon, 16 Dec 2024 08:14:20 -0800 (PST)
Received: from x1n.. (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3b248cb74fbsm15895765ab.34.2024.12.16.08.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 08:14:19 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH 3/3] tests/migration: Drop arch_[source|target]
Date: Mon, 16 Dec 2024 11:14:13 -0500
Message-ID: <20241216161413.1644171-4-peterx@redhat.com>
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

Coverity complained about them. These two variables are never used now
after commit 832c732c5d ("migration-test: Create arch_opts"), and/or commit
34cc54fb35 ("tests/qtest/migration-test: Use custom asm bios for ppc64").

Resolves: Coverity CID 1568379
Resolves: Coverity CID 1568380
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/framework.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index a902936039..47ce07856e 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -197,8 +197,6 @@ static void cleanup(const char *filename)
 int migrate_start(QTestState **from, QTestState **to, const char *uri,
                   MigrateStart *args)
 {
-    g_autofree gchar *arch_source = NULL;
-    g_autofree gchar *arch_target = NULL;
     /* options for source and target */
     g_autofree gchar *arch_opts = NULL;
     g_autofree gchar *cmd_source = NULL;
@@ -307,12 +305,11 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
                                  "-name source,debug-threads=on "
                                  "-m %s "
                                  "-serial file:%s/src_serial "
-                                 "%s %s %s %s %s",
+                                 "%s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  machine, machine_opts,
                                  memory_size, tmpfs,
                                  arch_opts ? arch_opts : "",
-                                 arch_source ? arch_source : "",
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_source ? args->opts_source : "",
                                  ignore_stderr);
@@ -329,12 +326,11 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
                                  "-m %s "
                                  "-serial file:%s/dest_serial "
                                  "-incoming %s "
-                                 "%s %s %s %s %s",
+                                 "%s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  machine, machine_opts,
                                  memory_size, tmpfs, uri,
                                  arch_opts ? arch_opts : "",
-                                 arch_target ? arch_target : "",
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr);
-- 
2.47.0


