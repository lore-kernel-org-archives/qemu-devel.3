Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12BACEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 22:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL7sr-00055y-LT; Mon, 17 Nov 2025 17:39:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vL7si-00053t-Iu
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 17:39:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vL7sd-0003Vx-SK
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 17:39:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763419162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ih8mt1S/dK6l1RZ22LUm8+7bTSCfVNi+19N02b7VVyM=;
 b=Bw4R7YpCoOdLD5pJ5/jtNmXk+GGX5BRqmZznvCuhthAJqu/UK0Kzz8ablAJQM8d2JX9bl7
 SVkPeT+wya9yggtSk85YcFj3UX6xGzjjlLOUpKHNtvKssP/qxwdjk+AjaCkoclA0bhKnmK
 campLBJt7mtvtR5WC1HvodkikyK416k=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-6oUDAlreMeGMgMYWgEwjgw-1; Mon, 17 Nov 2025 17:39:21 -0500
X-MC-Unique: 6oUDAlreMeGMgMYWgEwjgw-1
X-Mimecast-MFC-AGG-ID: 6oUDAlreMeGMgMYWgEwjgw_1763419161
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4ed7591799eso143558281cf.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 14:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763419160; x=1764023960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ih8mt1S/dK6l1RZ22LUm8+7bTSCfVNi+19N02b7VVyM=;
 b=ATbna1Fsu90DzMAJKv/WyJ6oR/kdMBoGUVzimeb9IRQWCGnC70mvsSaFmkYlylolGf
 AQgk9MAhi11iZIFNpL4QYlImoh4xuxLeEvxfJDJ4DJ/Dea+1MJLnypmAJfuRewzwhHGS
 t7W/ZvIpzgd4h1nDcD2BZNQcAe8WoDgkZCB6FfoV7df8GekPJTmvMSBRi8PBjJYlb5b7
 czLtcbq9WHp4TW4qtTtADT/nZj/zqEQ2duXzTUQbxQFq7iYh4tuN5ryO6bai6X7WFUxN
 FyNRldIGhlbCe1Mus4J+O9gYEHc2iHGgK8yicpQke8dhyT48c4aczk7iVrcSV+OHlEIr
 Ud8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763419160; x=1764023960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ih8mt1S/dK6l1RZ22LUm8+7bTSCfVNi+19N02b7VVyM=;
 b=hbypg8ruznOH3qQv+hmS0MySPaEabQlNxwPsZCaya1CXYbnk5qmLtdYA94kbXCtv6E
 gGEdkGAjEzMPIOa9Ia/1TAfCVpLkxNv0iQ8i0U+RMUAAGxJVcf31jsHdqX0VP0kHl5hV
 GbpBXkm9ILl6Oks+zYKlXGTyKMgqW6HFkWk8fao63+wVXRHoeo8ad/G1HLVslmcSDUvT
 gtNRCPXKQPl0vt/3TeuOxkUfawTLGvcSdOBpiGY6OXDoVIxnRTe0C8ktQw91aF339jX7
 6PNhR2yAob0rtk7xrkbCs5KV8gKCLzuXv2G3EDQYJaX51t9Y9vIL5P9Is/zcnhjpVo9Q
 aO9g==
X-Gm-Message-State: AOJu0Yzxx+m/iLLg0lCFy97p63cXcPE0/kPgAXOTXphAiNnCTMtsOVb/
 TVPKb+lQZbZLPi6g+KM3zA4JRASWfasQTGTtU5cC5t7T5h6ppL8h30ZaKR9lUsZf6rcJd1jPFjt
 H2ZUB2BWj+UGHe5Ui+yQwti73ZHKDfw7XOeEQ6oOTxSy8ZRqFtTSn+oFaXZ9oYZyLe/sY1nhAqm
 lDRssqhAPoKWVm826VZWxr4wbTqh1ilXmXhjn89A==
X-Gm-Gg: ASbGnct0psEZ+04nPUf0flFsVqvwzI9hVEN2VVE4UNxGqx0ascWOSrG78T3I00yKB08
 jqA0j0OXmHZcUNfFK7PJSutsK0mmjc5tVthYAE0q2CJzqqV6nWGmivpPdzK+JOCUL05JJuAsgy+
 D6dNQCw8w3Crf4TdSMkYYHsPteBSyp/c0gpXDsHh0fmNljFLEJeFlu8FFJQ+gyFj5zX5aI8OWBn
 Sn4gZq0bJc4foMYH9jh+FfrMbRqWcf4OG8sSbFH2HnwBEJLzFVxgUp8i5SInuopwehxSHXZ7bCs
 1phWz7FG/0yoytZz8g6TS8ZeaABl5zLgI4psUXVRJ/DXvb1APryybDsRmrJAQEeSHL4QG4jxzNg
 =
X-Received: by 2002:a05:622a:4a15:b0:4ed:df82:ca30 with SMTP id
 d75a77b69052e-4edfc875136mr175173791cf.13.1763419160227; 
 Mon, 17 Nov 2025 14:39:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSgbJNRUEz0YasY2a4WtBYI9gwZaFtYrHBh9hcW3zoxmt5sTrzVtoZtqSWPCg3uNne1Z3wKQ==
X-Received: by 2002:a05:622a:4a15:b0:4ed:df82:ca30 with SMTP id
 d75a77b69052e-4edfc875136mr175173391cf.13.1763419159651; 
 Mon, 17 Nov 2025 14:39:19 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee1c21ea34sm37693521cf.30.2025.11.17.14.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 14:39:19 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 4/4] tests/migration-test: Use MEM_TYPE_MEMFD for
 memory_backend
Date: Mon, 17 Nov 2025 17:39:08 -0500
Message-ID: <20251117223908.415965-5-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251117223908.415965-1-peterx@redhat.com>
References: <20251117223908.415965-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The only two users of memory_backend as of now (cpr-exec, cpr-transfer)
uses memfd as backend, now we fully support it.  We can move memory_backend
usage to mem_type and drop it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/framework.h |  5 -----
 tests/qtest/migration/cpr-tests.c |  6 ++----
 tests/qtest/migration/framework.c | 10 +++-------
 3 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 9dec21c344..ed85ed502d 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -134,11 +134,6 @@ typedef struct {
     bool suspend_me;
     /* enable OOB QMP capability */
     bool oob;
-    /*
-     * Format string for the main memory backend, containing one %s where the
-     * size is plugged in.  If omitted, "-m %s" is used.
-     */
-    const char *memory_backend;
 
     /* Do not connect to target monitor and qtest sockets in qtest_init */
     bool defer_target_connect;
diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 70f8e69633..2a186c6f35 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -89,8 +89,7 @@ static void test_mode_transfer_common(bool incoming_defer)
         .start.opts_source = opts,
         .start.opts_target = opts_target,
         .start.defer_target_connect = true,
-        .start.memory_backend = "-object memory-backend-memfd,id=pc.ram,size=%s"
-                                " -machine memory-backend=pc.ram",
+        .start.mem_type = MEM_TYPE_MEMFD,
         .listen_uri = incoming_defer ? "defer" : uri,
         .connect_channels = connect_channels,
         .cpr_channel = cpr_channel,
@@ -235,8 +234,7 @@ static void test_mode_exec(void)
     MigrateCommon args = {
         .start.only_source = true,
         .start.opts_source = "-machine aux-ram-share=on -nodefaults",
-        .start.memory_backend = "-object memory-backend-memfd,id=pc.ram,size=%s"
-                                " -machine memory-backend=pc.ram",
+        .start.mem_type = MEM_TYPE_MEMFD,
         .connect_uri = uri,
         .listen_uri = listen_uri,
         .start_hook = test_mode_exec_start,
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 4d1663356a..81eae09c92 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -366,13 +366,9 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
         ignore_stderr = "";
     }
 
-    if (args->memory_backend) {
-        memory_backend = g_strdup_printf(args->memory_backend, memory_size);
-    } else {
-        mem_object = migrate_mem_type_get_opts(args->mem_type, memory_size);
-        memory_backend = g_strdup_printf("-machine memory-backend=%s %s",
-                                         MIG_MEM_ID, mem_object);
-    }
+    mem_object = migrate_mem_type_get_opts(args->mem_type, memory_size);
+    memory_backend = g_strdup_printf("-machine memory-backend=%s %s",
+                                     MIG_MEM_ID, mem_object);
 
     if (args->use_dirty_ring) {
         kvm_opts = ",dirty-ring-size=4096";
-- 
2.50.1


