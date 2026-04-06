Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BE8F46C47
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 14:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9kmu-000416-DC; Mon, 06 Apr 2026 10:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9kms-00040W-BC
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9kmq-000553-S5
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775485124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+sg9BWtJy13Moaz54t3chkQyG4VgTEMPjkH1Yg9V5JY=;
 b=O88iymfWqmge8GX0H9yyk3pJkVrtwmBZNUo3ginRL2DbLDHBgbQ3zmYnDRTKI/dBCtJjDU
 EQxAZYetbDNhdLCu3EIBzDuAGKDp9nT+skt0K0M/MXhXC94RqO6OXMMZANEgqrqYcMl7zf
 RIkkTP0tX24yLcKUJKQno8v4MnKe+28=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-MmoDrjCnOA6KYEZO75OgLg-1; Mon, 06 Apr 2026 10:18:43 -0400
X-MC-Unique: MmoDrjCnOA6KYEZO75OgLg-1
X-Mimecast-MFC-AGG-ID: MmoDrjCnOA6KYEZO75OgLg_1775485122
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b24af7ca99so52828555ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 07:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775485122; x=1776089922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+sg9BWtJy13Moaz54t3chkQyG4VgTEMPjkH1Yg9V5JY=;
 b=dic6bptG4H4mQx5+zQbj8QVDov7pgkpbXj9wrQeKtGuvNLTwyan9yNwZp/ymbeY/d/
 9riZwgdGixJU/VAOfh0aSiGuTHfpqUwdZRvlwPp1e8TcZHVbtadD5I4ibFLMbr7lJZO6
 mXtug2lgp76MA5YkBtA1dfJz3OPk1OxeN3Dgdwzp1skn3tTlbcAfrCvJlwxG25PggfJg
 nPJqJYx52Lcl3h4YoiGwW5wFoz62YHT60IY4GwNusI97QISGRDAg7qQQtcgSegN2PvL7
 P1dJcDquiSREoa4k3qBW5ctJgfvzkBcuiqCL6EXq3VeT+57lQ47y4IPoKw3FtC08MEmH
 2PWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775485122; x=1776089922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+sg9BWtJy13Moaz54t3chkQyG4VgTEMPjkH1Yg9V5JY=;
 b=HGk0qCvlw/6RnGhe7AqLreye3T1SlPO2YIZMfz4DAnNWP2iC7CxoEB2dDJp7iaMnvx
 QBSafjYxfqH48zgJZaqVkyaGikl2lw3iVbD/5Gmmn5QDQnotMKPJTxnmSDfcOUrtyZw4
 1ushc8XYbMKsNs1s85feYHA9lDrIKdzHQU7jN7L6qmYBTGyY2A1gscjjn0M9cXeWhHnA
 sqQxc9BVIaLSDA9NsaAYgNSpY+vEtuVnuNJzbq1fJQXvK9ZKA+hCp2+T9+PmuaDY+1uU
 oZ9l8wSLiTCoiKqARtWI46VAyeScy7HxBrB/pddYuJyJCYq+YgMS6MU07WlZ8jO7mMBT
 epKw==
X-Gm-Message-State: AOJu0Yy0Zv16A8Y1DMQf/FjQvueFqptOSG5YO85/FA4UnjXouwetWA1g
 mXqQrRhP3qFr1PnenqxoXKXGkUJWtVonM36lmHma4KLYrn4XIWbgounbLOAcdX0RK5y1UYWVZ8H
 OfIHD5vemzj3M1EVz9U/BtUdE3LRDfFI/1eYQJ/cEyIAgZp/qhAoC7IhvEhLocmL9PUKNswwlMS
 SQZZQdddxwmJATyKLBPyifV/YZgu5wNr+0dvWD/ws=
X-Gm-Gg: AeBDieslYHJ0Nz+vOGbRBgqKTsOpTHo3aWdYL/rnCAExmCNhm/wIwSdlp57670If7Iy
 fc0ggkh+IbHiXdYOuJXcwXOPS7Nwb7LIRnNDRXb7s5nX6yUIWNVZtlWRdavmWICwGxhRBQzyEmo
 3rV0xmOy4Pit3Si818h+0oZP+TdsmxRWp7ZYY/10H5K6Ca9V9W7jQdkPs3g85/CbvhVX67RXXCQ
 7TTttmtZpPJ1fo/2HmCUO9YCF77GxdA0CrpQi0970ko8pWVw/5K/i5IV7mJzrnhZo8VL0n4cZRT
 87qGMaVgrf8hpDxLTArtNQOX8SmNzOcOnsjLCmrjDUWsV5SMbr/K9CY57Wlai/ZzPyVD1WtfSaB
 U6rymxfasJ5yBOqSWo4ywDbgnmpBt9Wo5JXNfXnwHg6HpX5NIXYDSuWgv8Cxgac1D/H0=
X-Received: by 2002:a17:903:2ac5:b0:2b2:42da:25cc with SMTP id
 d9443c01a7336-2b28163ad55mr138537685ad.1.1775485121701; 
 Mon, 06 Apr 2026 07:18:41 -0700 (PDT)
X-Received: by 2002:a17:903:2ac5:b0:2b2:42da:25cc with SMTP id
 d9443c01a7336-2b28163ad55mr138537045ad.1.1775485120933; 
 Mon, 06 Apr 2026 07:18:40 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([152.59.100.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478cb4fsm156732905ad.29.2026.04.06.07.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 07:18:40 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 marcandre.lureau@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Arun Menon <armenon@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 07/10] qtests: Enable starting swtpm with a given profile
Date: Mon,  6 Apr 2026 19:47:32 +0530
Message-ID: <20260406141735.25844-8-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406141735.25844-1-armenon@redhat.com>
References: <20260406141735.25844-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Stefan Berger <stefanb@linux.ibm.com>

Enable swtpm to start with a given profile by passing it to swtpm on the
command line using

   --profile name=<profile name>

Remove any existing TPM 2 state file since applying a new profile to
existing state would be refused by swtpm.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 tests/qtest/tpm-tests.c | 6 +++---
 tests/qtest/tpm-util.c  | 9 ++++++++-
 tests/qtest/tpm-util.h  | 3 ++-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
index 197714f8d9..f71d882990 100644
--- a/tests/qtest/tpm-tests.c
+++ b/tests/qtest/tpm-tests.c
@@ -43,7 +43,7 @@ void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx,
         return;
     }
 
-    succ = tpm_util_swtpm_start(src_tpm_path, &swtpm_pid, &addr, &error);
+    succ = tpm_util_swtpm_start(src_tpm_path, &swtpm_pid, &addr, NULL, &error);
     g_assert_true(succ);
 
     args = g_strdup_printf(
@@ -91,11 +91,11 @@ void tpm_test_swtpm_migration_test(const char *src_tpm_path,
     }
 
     succ = tpm_util_swtpm_start(src_tpm_path, &src_tpm_pid,
-                                &src_tpm_addr, &error);
+                                &src_tpm_addr, NULL, &error);
     g_assert_true(succ);
 
     succ = tpm_util_swtpm_start(dst_tpm_path, &dst_tpm_pid,
-                                &dst_tpm_addr, &error);
+                                &dst_tpm_addr, NULL, &error);
     g_assert_true(succ);
 
     tpm_util_migration_start_qemu(&src_qemu, &dst_qemu,
diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
index 603c5a825d..24243065c1 100644
--- a/tests/qtest/tpm-util.c
+++ b/tests/qtest/tpm-util.c
@@ -210,7 +210,8 @@ bool tpm_util_swtpm_has_tpm2(void)
 }
 
 gboolean tpm_util_swtpm_start(const char *path, GPid *pid,
-                              SocketAddress **addr, GError **error)
+                              SocketAddress **addr, const char *profilename,
+                              GError **error)
 {
     char *swtpm_argv_tpmstate = g_strdup_printf("dir=%s", path);
     char *swtpm_argv_ctrl = g_strdup_printf("type=unixio,path=%s/sock",
@@ -220,11 +221,17 @@ gboolean tpm_util_swtpm_start(const char *path, GPid *pid,
         g_strdup("--tpmstate"), swtpm_argv_tpmstate,
         g_strdup("--ctrl"), swtpm_argv_ctrl,
         g_strdup("--tpm2"),
+        profilename ? g_strdup("--profile") : NULL,
+        profilename ? g_strdup_printf("name=%s", profilename) : NULL,
         NULL
     };
+    g_autofree char *swtpm_state_file;
     gboolean succ;
     unsigned i;
 
+    swtpm_state_file = g_strdup_printf("%s/tpm2-00.permall", path);
+    g_unlink(swtpm_state_file);
+
     *addr = g_new0(SocketAddress, 1);
     (*addr)->type = SOCKET_ADDRESS_TYPE_UNIX;
     (*addr)->u.q_unix.path = g_build_filename(path, "sock", NULL);
diff --git a/tests/qtest/tpm-util.h b/tests/qtest/tpm-util.h
index 681544e7d8..ca2d7d173f 100644
--- a/tests/qtest/tpm-util.h
+++ b/tests/qtest/tpm-util.h
@@ -41,7 +41,8 @@ void tpm_util_pcrread(QTestState *s, tx_func *tx,
 bool tpm_util_swtpm_has_tpm2(void);
 
 gboolean tpm_util_swtpm_start(const char *path, GPid *pid,
-                              SocketAddress **addr, GError **error);
+                              SocketAddress **addr, const char *profilename,
+                              GError **error);
 void tpm_util_swtpm_kill(GPid pid);
 
 void tpm_util_migrate(QTestState *who, const char *uri);
-- 
2.53.0


