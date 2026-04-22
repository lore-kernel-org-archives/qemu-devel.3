Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E503FF9B60C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUra-0006oQ-Bg; Wed, 22 Apr 2026 06:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFUrW-0006n9-Am
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:31:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFUrU-00070U-8C
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776853874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ClfWz/hTXQx5IWEI8DJH2vTF1tKQTfAQCoPQ/9w7nI8=;
 b=A/JJ5zXK7TqUOzZyEB+qaCxxnJaWD1pTV1TRvg8B/EF74l0ILpfPYATjECBJHC0bK2tbDS
 s274iYon0DWbpfd0KK915BUz1ftjAIGdwH2Yya8uMA3DDxTlRNXif1+T5GZqu1omKKKKK2
 XbK7xTnBaiHPDI1KUce2KNuMTDLw1jM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-stoXvoDwPyCAwZmxvAbJ6A-1; Wed, 22 Apr 2026 06:31:11 -0400
X-MC-Unique: stoXvoDwPyCAwZmxvAbJ6A-1
X-Mimecast-MFC-AGG-ID: stoXvoDwPyCAwZmxvAbJ6A_1776853870
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3568090851aso12982377a91.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776853870; x=1777458670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ClfWz/hTXQx5IWEI8DJH2vTF1tKQTfAQCoPQ/9w7nI8=;
 b=no9rwZAxuy968ya+uuC74OrhJNui3EBsOdH6x9KOXKp1yO2svBjPXL5UWi01Ml6w/n
 qy3bGugo6cJA2Gf8peH2+Y7nMHaZeFTvClrkU3e4wQRkfeWfIIJ+w5kaThOnDWXfTUhT
 CNYNOaS/xr4D+qMyhVv4sE++fLY6ohM7YSKDm8H+YvYVpw/jaiuae2G7qWRcvS4U1cJS
 LLV1mJ5qY78yNQPM44N39CjfC3vKSb0EGXaJkVXPsiiyWeXNXq38MXAaIrQUpm37nJGO
 UURtiSUCh7V95LK7pGp4GWmq9ztZ3sr7YFcrxv0nx+7Hdr5goKl3ShRjwjG8AiSpfLBm
 kusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776853870; x=1777458670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ClfWz/hTXQx5IWEI8DJH2vTF1tKQTfAQCoPQ/9w7nI8=;
 b=Ghc/SicLUw1WrlzbQX+SkEatM71goWSVtq7Jc5F+4Oadpw6vyd9v58g+j1XYH81VyL
 8ITfhfkmzIBrEFRPkuD5qeLjfPf0uUlhdE4TTE109k/QyKXa0FpWLEKJNAIicSSIHQyC
 LhSg2qbq3/Y12w+WTSjKeLXCUC9hJxJ13VJl0NBRscqNS83rSAWX37aoG3jjTY7y4RWe
 5ec+DyP351GufozCWVwPXw6SwgSJINbJdiWimfVJ8aRVv2rOK0YrRVG4yranzQoALvLl
 MIQLSNd8CS0VYKAEEz8y1K6xLwSDPBLH5Y3vet11EsJOBOdKTJbQPcVi76aPJ9WF1pu6
 gd9g==
X-Gm-Message-State: AOJu0YyeaPKO+53tbd4cZEpbs8wUUfjQ/ueRse2cn+mS0JgseWJzlx8d
 NhkjGKA+OwbjXzK3LxXI/I8e+CtHnfKf/UgyWy5DKpeqOyc5stkTdamzD56JFt5FwJ2IOHDtAXc
 5K2D1skQlfll4Qj0mCCXoFaW40hqMQLm2MZMv847UxryvWwdhSrzgzATiMtA8Z14LNDEnEBxL4P
 2KTeUBpHpOpPJZPfW9ZLKUN2I8IRYjQ9wuBQAb0f8=
X-Gm-Gg: AeBDieuD9r11pxlkDDpwoqjEIJGQVmj2fhsk/5PoeiXgWc0psAyWYNoQ1Mjr4OP6Prw
 YOQyxdmN87jnOsg2wrv+pMLEQglmyVbOJ9wqSv2pxla6gkxqVgTPZTCHPf7L65EoXSdNxIerShh
 fSE8zGKDj0YoHtQg46CJwT82d+wXpSNJQk0VP5SOKGyGHi+xSJzK8aMEbXnMX+w6RO1LEIXw8MA
 s3AtBwzYaCY7wGXnZt+3NtlwYGts/vmf2CD9uw7xQ342aNKf0O2YCciGL6seB1J4KnofRFW1AnQ
 QZ2g9RdN2B6AP39fBw5n59St0ixjfq9bPGtuWajSeaSp7NubtQ2vobCGblOgzFhzHzYzp/j+NEk
 3qEiNUXsclaU04HEAK3wRD+WksX5ogIU3rXig7Ww1aaHJE3GqmhWXA1cSrI6tPolO6cqaAjfmgA
 ==
X-Received: by 2002:a05:6a20:72a4:b0:3a3:327:c5c9 with SMTP id
 adf61e73a8af0-3a30327ca1amr3092197637.26.1776853869890; 
 Wed, 22 Apr 2026 03:31:09 -0700 (PDT)
X-Received: by 2002:a05:6a20:72a4:b0:3a3:327:c5c9 with SMTP id
 adf61e73a8af0-3a30327ca1amr3092126637.26.1776853869327; 
 Wed, 22 Apr 2026 03:31:09 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7976f920e1sm12589666a12.2.2026.04.22.03.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:31:09 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Igor Mammedov <imammedo@redhat.com>,
 marcandre.lureau@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Ani Sinha <anisinha@redhat.com>, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v5 07/10] qtests: Enable starting swtpm with a given profile
Date: Wed, 22 Apr 2026 16:00:15 +0530
Message-ID: <20260422103018.123608-8-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422103018.123608-1-armenon@redhat.com>
References: <20260422103018.123608-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


