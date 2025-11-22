Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BD7CFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcmU-0002up-Ob; Fri, 21 Nov 2025 20:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vMbTY-0006hs-Ul
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:27:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vMbTN-0003hB-IY
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:27:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763771234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V76MNTnyuhhXMHGtNeIBFZdzBP6SOZz/Nq+ucjRpHnY=;
 b=K+3yM9RdsYJTLAmqQaatW9gtXw8KujZlueZiaemfoLA1MxK7QbOsr84qH+O7pkLKN35Fyc
 EmLO6t+6UQmTDLNI791Px51xtWO8mtfF/3E+1GLP09fHRmTyYHVoHanz2gGRiYMK91xelL
 pUrzp7c63gNQKHPdeIyxijlusMpgF8w=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-BRyUGonfOL-gl0Co6SZBQg-1; Fri, 21 Nov 2025 19:27:13 -0500
X-MC-Unique: BRyUGonfOL-gl0Co6SZBQg-1
X-Mimecast-MFC-AGG-ID: BRyUGonfOL-gl0Co6SZBQg_1763771232
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4edb35b1147so61896881cf.0
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 16:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763771232; x=1764376032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V76MNTnyuhhXMHGtNeIBFZdzBP6SOZz/Nq+ucjRpHnY=;
 b=AbMAq/uymFt6GyXagiT/7PDtWEXsaeJfvNvQMCl8FiF4dAMmAGoqUKN/HEq+g4Oe7a
 v/Y5t7UWus2lW7GFo+MZPGWSnzIoTvRcW7PPXPC8FDATG0JAjjsk1d1WTYFHyB/KyoSo
 SISWnijk9vjDr1AOkctFAmPMkc0NNKJOdsE0wifpND22NN1fDDDWQUGqJMYwH0YRNT57
 7D4A+IKjR+zZ7sfSjTkmTEx+SF6i66wBnChlUWDsJ6H0q3hp7/giT0/K4F1bjJ6NthIS
 /b6+US3CldL2YpXVtNDbUsQT+XmcG4eqrTLGRel0wMcPEVcXDIh3kaRqAp4+9lUIzy4u
 kLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763771232; x=1764376032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V76MNTnyuhhXMHGtNeIBFZdzBP6SOZz/Nq+ucjRpHnY=;
 b=vbl3l+/Yg/UBD0g84IvpzdVeAuyJ5bOWsafvQ+9USXozjLC/mn5YUxjSPCqtP9+Yaw
 kWlsQCDKrBVQVZsNWdYk3OA1aBh/rWgMpKrC6CVA8QBxtqri8u2ZRRUtwgSt9iNr1iwX
 FC2KuSWWuT9C/w56Z+WhVtc1DM4qwZooT80g2L+w37CnsGbNabHdI3kdlb75VwJ6RkGV
 wGeTqB3Z8V9DN8+LCcbFZ+wp5Gtbabam2Jx3KNbowHeeP3J7FaUcT6gosttbkDuDv4p6
 bI7jqszYB/QLN27AjF6cZn28aPz440PkHlLElp7F4xYZkadW/2A/oiqCFbrnvHh+EQUn
 LogA==
X-Gm-Message-State: AOJu0YxwLF1V1gajkhiTGPKOHfPt+dn60ynGmzcvQWTWZms+I4l4ESRr
 1o+ycZYiWKQ8FxEd1gAU+58JS8rZVGGRy2FwwDLDGplNPDUBrAac6FBTbhJieDRUkJHBdSpxTom
 pTBVng2lwK9eVttCnypfaiazENTu2jm2HpSeuJPesOVuzVc3yo6mjT45ISKQdfwluyz4Gn/UBra
 Wt8D61m+DvT0uusQZ/ILOBpi1L8qbBkY/fcLQYbg==
X-Gm-Gg: ASbGnctpqvQnYOORgCzAdMCo8NKPFMR8+lDJfb6NNkjLKsjQ4tfgfGaSteJWp+p5fdT
 j7rDu/pZyRBT1XNTIZjYtTl44b7CCNcZZIY77fhmjz80y6Y9TYK2dC/6665pInbz/mXao+lHEj4
 2pb8Y7sSMIzCEcIn8GYZuCKt0W6ne4R1HvPs9v+sZJ5gPk6zIiwRRrleRzAtryBnU9LbWCHA8EM
 keMF17NmG3qZ+PeAdLPkyaOuyDrcZNhFLtLes9YjT7qHLZChODfdUvHZ8Eoui35eNV3+cEzGhZ/
 j6t0XIQRHP0wVH86TdbYdm/gHFmwQO+R2JEON6YzKj/CTeC0XJbK/Q4nUjjzypegS9f7/Z4QQpn
 4
X-Received: by 2002:ac8:7f14:0:b0:4ee:b2b:aa23 with SMTP id
 d75a77b69052e-4ee58801af5mr54219131cf.15.1763771232116; 
 Fri, 21 Nov 2025 16:27:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOI/YTYGISscJwTlqQvpI+y94/nKvDemeAVm3XbDnRWVbMY+8mKndOHO3TN28aCWc6JFWtZg==
X-Received: by 2002:ac8:7f14:0:b0:4ee:b2b:aa23 with SMTP id
 d75a77b69052e-4ee58801af5mr54218721cf.15.1763771231481; 
 Fri, 21 Nov 2025 16:27:11 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee48e8df63sm43870291cf.30.2025.11.21.16.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 16:27:10 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 9/9] tests/migration-test: Use MEM_TYPE_MEMFD for memory_backend
Date: Fri, 21 Nov 2025 19:26:55 -0500
Message-ID: <20251122002656.687350-10-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251122002656.687350-1-peterx@redhat.com>
References: <20251122002656.687350-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251117223908.415965-5-peterx@redhat.com
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
index 1c662f86a9..e35839c95f 100644
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


