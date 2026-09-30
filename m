Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACB5CA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBw0Z-0002aM-1E; Wed, 30 Sep 2026 11:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0W-0002YR-Ns
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:14:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0U-0000lA-U0
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790781246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SX/NPkX49pXCc6ef7nu6Mpt5rBrWjUkLaeEJs6w9K1Q=;
 b=DRpP/9Tr3YetDLqliYVmfqETTfAGUrRZDjoH1lMvl3KREdYeDVwfdXzHcULso8ilhXG5cY
 5+6qp7aRkiK17JftL6ASp7a500t/u1xQBP+gcZhmMLM+xzA40wjTqD1lU/E15VHg4lcjf+
 lZOugWTMOFGEP7I8teIsrgDdfBuvo3w=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-WE2Wh1l7ME-CDIyikn69JA-1; Wed, 30 Sep 2026 11:14:04 -0400
X-MC-Unique: WE2Wh1l7ME-CDIyikn69JA-1
X-Mimecast-MFC-AGG-ID: WE2Wh1l7ME-CDIyikn69JA_1790781244
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-8acb6172b5fso6203897b3.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 08:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790781244; x=1791386044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SX/NPkX49pXCc6ef7nu6Mpt5rBrWjUkLaeEJs6w9K1Q=;
 b=C+xYpbGluje56BO7pwPPIl0K74Os8NlfNTATCi4kaHHm/ZPjwy9PnPNfuvGnKy9Gbb
 bx9S/uHQXiOvyJ9r9slME1ik5FEvXqjxoIsA3ZxtCQ5PJwo/82wxbszlFmgOXlm82M5+
 PzRvglzKmc15x9YwlRojOGv1SA5WE1I4mxlOSqyg0jqo1xGW61aCa0RmW0wy1aYF18sT
 SiT5QYab/3x6SPyb8RjKLUYNPm5D9hPwvJsv9wsh+aHR9lnhMSFphuRjgsrnYAYt+Rkr
 UN1ExzZ187yQbSlGxBw6q2fWh4bqvFClVyNgWijAC1E+1VKng7YQTG9k1UnrM0+Xoixa
 pDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790781244; x=1791386044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SX/NPkX49pXCc6ef7nu6Mpt5rBrWjUkLaeEJs6w9K1Q=;
 b=KOvw/26sIPd2Xb+Yav7VYGbffszdKuba6+p8UqqqeXhV65rreGDxspp48QTpChszsr
 TYeedySlJ/knxHsHyWv2JYEIs+5T+ifJ0491y7dOvBpvMD6yaVWbyfejdjYliT388Q8Z
 GRLU/qejtOKocMgBztXD4Een+seOpOm7rkzMWF4YL/Hf072S2jeaoVQJOnUweru3gUjC
 0sZmwSpeyBea/lFKHh1TLWjvnxbXBZb5lPOKnukli0QrLIERO7iERok5jpE5q7MKZWwU
 SQFtRfEmFGc9+4IZSTJK6X1q5fzVFtHkOOBevonVogSKZ0BIFCspxmYbHiD0Ldp+HDUB
 CcGQ==
X-Gm-Message-State: AFq9FYKcgXM3FU/DSmDNuts4HzqFjEm3OvMEBFAW+UPfkyh6XpS+s5cd
 rGy5+uxxNQfIgxV2Jr0v9XklDLeAFWdoXDrMw/Hhqyo6JBImMwTQAyJjss6QMLwLQdEAvxoJBse
 LvAMLn1rbxQwR6i1NRsmCexCiWpPB8NNJ5LXx54rLX6zELp6xHkPnzQgRkhBD1ZJEyyySX/CeTD
 rTQe0wXkHcwzS2euoB1mJb/Q6I/XtBCpiCgHzGQzKe
X-Gm-Gg: AYBFou086O3Nb4NYQ/A2BfU7ndBsWPanHaiDsxvxLkQfiye1yTTBDVL2RvAUWgeaHBS
 TC7sPgAxGdhloLxWDrifPuBISfa4vaJ9JuS1ipzyAffrGbEMSQkvapQT4FF9+0NE82weotuTa3V
 yux1zoMTlliO0URr0Ci9rbb2HxdTdDLafyMRsn43pxkmomt3su6mT6YukpoPXBead+4eUzfBbdC
 cllWLVSvpIj6ay5Iu0mwmXkn37YCQo5MwxK+PUrrUKQfCN1rvMXRDGjF+k/AKqMbC+nUAvKafbx
 6OyNUWqx36oELUQYGgOCv9VKylo1P04UQBlksn+3afXOmSpjrZr37wD6qB424h9JSa+eqFs=
X-Received: by 2002:a05:690e:4503:20b0:671:83b7:d703 with SMTP id
 956f58d0204a3-676834fc559mr684075d50.91.1790781243651; 
 Wed, 30 Sep 2026 08:14:03 -0700 (PDT)
X-Received: by 2002:a05:690e:4503:20b0:671:83b7:d703 with SMTP id
 956f58d0204a3-676834fc559mr684048d50.91.1790781242787; 
 Wed, 30 Sep 2026 08:14:02 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917a89edf7fsm1659176d6.21.2026.09.30.08.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:14:02 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Michael Roth <michael.roth@amd.com>
Subject: [PULL 12/12] tests/migration-test: Add a precopy test for guest-memfd
Date: Wed, 30 Sep 2026 11:13:40 -0400
Message-ID: <20260930151340.2817042-13-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930151340.2817042-1-peterx@redhat.com>
References: <20260930151340.2817042-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a plain tcp test for guest-memfd.  Note that the test will be
automatically skipped whenever not supported (e.g. qemu compiled without
KVM, or host kernel doesn't support kvm, or old kernels, etc.).

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Link: https://lore.kernel.org/r/20260929235109.1398509-13-michael.roth@amd.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/precopy-tests.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index a23d51126b..d57ffcac23 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -182,6 +182,13 @@ static void test_precopy_tcp_plain(char *name, MigrateCommon *args)
     test_precopy_common(args);
 }
 
+static void test_precopy_tcp_plain_gmemfd(char *name, MigrateCommon *args)
+{
+    args->start.mem_type = MEM_TYPE_GUEST_MEMFD;
+
+    test_precopy_common(args);
+}
+
 static void test_precopy_tcp_switchover_ack(char *name, MigrateCommon *args)
 {
     /*
@@ -1108,6 +1115,8 @@ void migration_test_add_precopy(MigrationTestEnv *env)
         return;
     }
 
+    migration_test_add("/migration/precopy/tcp/plain/guest-memfd",
+                       test_precopy_tcp_plain_gmemfd);
     migration_test_add("/migration/precopy/tcp/plain/switchover-ack",
                        test_precopy_tcp_switchover_ack);
 
-- 
2.55.0


