Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3EEED7B82
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCZAl-0008Od-Ad; Tue, 14 Apr 2026 04:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wCZAe-00085x-8d
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 04:31:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wCZAc-00043v-JA
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 04:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776155452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ClfWz/hTXQx5IWEI8DJH2vTF1tKQTfAQCoPQ/9w7nI8=;
 b=HuJGsoTT7Z5IyqEev4BzkDzSAzlfUxfcABi1imQa4bJnNL4NQXGGet7voWMgpXwIysYSvR
 jc+u+xkwYS9bPf+gkCYxxQP8xOeQzuxx2lmXpbVyBx1kD87egRyNigxgNZW8JYjYCJINbJ
 Hfe4fgGKIZUfK5P7bCkqb9WydjFfTjE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-fDlGMK7qOEmZP4TJG5R3eA-1; Tue, 14 Apr 2026 04:30:51 -0400
X-MC-Unique: fDlGMK7qOEmZP4TJG5R3eA-1
X-Mimecast-MFC-AGG-ID: fDlGMK7qOEmZP4TJG5R3eA_1776155450
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b2ed279eedso15400865ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 01:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776155450; x=1776760250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ClfWz/hTXQx5IWEI8DJH2vTF1tKQTfAQCoPQ/9w7nI8=;
 b=Io3FcvwnSoJ3/mjO45PO+qzBI4HNz0ZmyRq/b5CeohfbbUXjQj619HakRMy7F6z7xD
 QAFYnEAWG4ZIC0zswBmVPQqxT+9pRSth05w73PP9nDLrX0OUX+vmrFmsMMb/xoUXkSFr
 y7I98RRpyEMqG2cPIwyMVWAOm1VbCMAJIvP+sGvew5z0d7TpPjWtdh3IIVPaPSSzHWAM
 pQ37uqsm9GTx25jetsLAYVwtiBNcAEFggYEqAlG8UFeqfiFEIsO/rXhtAvmn4d+h6ie3
 lpHjkyUYDDjHc3QfGhDodBKFXgaikn/Iw9sQDIgSl7OhmbKM0xs5OuYqCrk2uIHEbKIy
 5zQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776155450; x=1776760250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ClfWz/hTXQx5IWEI8DJH2vTF1tKQTfAQCoPQ/9w7nI8=;
 b=Je9oMwmVjphBs4KqYOFlpNqHHwwtiAoWOu/OhIMNTNJJAihAyreCLalNUFj0O1TFTk
 cu3DnsqNb7LcszTmsd8fzvpjI/7QrjFVokqCaqECw1VEQhsEL7qbb78tB3J435Bg/4yk
 +OQ1Zo3qQds1ePepdbFBGY6t+z2iv5FzGl2+5J+tC5YtWFnLV4XIahz9nb7gGXfnHyth
 vpvN+i5nIu4Kb7RZeem02cD/+IPnF+3dJJdrpezpkryuRvxcnFzEoTbXtkbupw6ZLqts
 w5hJAeg7uFf9HmoJzJA8TRn0Nr+Cs9SOmfxCkbUo38QNZZWR1JIgWl3b4nsAHGFTltM4
 vMYQ==
X-Gm-Message-State: AOJu0YxvMtosrloooUpVJ/hrnSbvqe8nvzoWwkmQ7byxZxoCJNQQbyqX
 W3fiFyOCaQKk/qg6CWuU6XPbjLZT3rq3ccdZNoaAsTv2BV9kF5fjeAqx3K1OQ0SXDGSBxksW1dX
 WI4QzpwnaywGZI/IUVr9xXqBcEBMM/xZf7blrAbH2ZZBs4AC95n7iwbfaAVgz7xMRdwxlNh9kN+
 s1jBlJ+7eHRU/WYuAlNM/5H9aY0OLeB1r2yrS3Unc=
X-Gm-Gg: AeBDieu9N2jGiX6uVdtGoEEvmizlajNqUGyHX4i7+mIZpmhz/Tlx+xRr0uRpfkJyKJ/
 5MDhJ9vrOHzREXu82QWOI0pt+bav4ueBocybNQa+rtGub2pubEaPqC3eNj1hUAZKT+WhvrM90NT
 iUoSkC8MbC2LWY50H+BzRpZCZiLmtf2MKzs+F2e1yjFMmgbUqmYVT+X8oTizLNNTUb8oLdZwCFd
 JFsoo9YoRP22bFtsMPNcTdfg2HPSeqKVlM5xQTFhCmUpF0QAYRVtPzg4W8BkNbTcR4MH6yne2AK
 C7oedmnUuslODCcxjhafgJ065Nl5CmTvKBZzBQ0E46JcQUi2b9kpMR+iB4XdwZ4Mf1sGzDEqYoS
 PJDF7jLDPWxjz9nA5V/QfyaY+VVrGKRpB6G/LX8YHlj4s3boCSuDbGvdXXb04tas=
X-Received: by 2002:a17:902:724b:b0:2b0:5795:9ead with SMTP id
 d9443c01a7336-2b2d57d9aa2mr109672655ad.0.1776155449948; 
 Tue, 14 Apr 2026 01:30:49 -0700 (PDT)
X-Received: by 2002:a17:902:724b:b0:2b0:5795:9ead with SMTP id
 d9443c01a7336-2b2d57d9aa2mr109672215ad.0.1776155449320; 
 Tue, 14 Apr 2026 01:30:49 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4e0f909sm181493785ad.35.2026.04.14.01.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 01:30:48 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, marcandre.lureau@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 07/10] qtests: Enable starting swtpm with a given profile
Date: Tue, 14 Apr 2026 13:59:12 +0530
Message-ID: <20260414082915.112122-8-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414082915.112122-1-armenon@redhat.com>
References: <20260414082915.112122-1-armenon@redhat.com>
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
index 744592763f..cbba5b1c1f 100644
--- a/tests/qtest/tpm-util.c
+++ b/tests/qtest/tpm-util.c
@@ -212,7 +212,8 @@ bool tpm_util_swtpm_has_tpm2(void)
 }
 
 gboolean tpm_util_swtpm_start(const char *path, GPid *pid,
-                              SocketAddress **addr, GError **error)
+                              SocketAddress **addr, const char *profilename,
+                              GError **error)
 {
     char *swtpm_argv_tpmstate = g_strdup_printf("dir=%s", path);
     char *swtpm_argv_ctrl = g_strdup_printf("type=unixio,path=%s/sock",
@@ -222,11 +223,17 @@ gboolean tpm_util_swtpm_start(const char *path, GPid *pid,
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


