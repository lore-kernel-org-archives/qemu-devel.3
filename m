Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DB1C25B5C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tzJ-0003hX-NP; Mon, 06 May 2024 04:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1s3tz3-0003LT-Pw
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:46:05 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1s3tz2-0003XA-3R
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714985164; x=1746521164;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=i4b2WuDGoF1FnltOM1bdaEoGjw6nQCDEPh+AYW8me4Y=;
 b=XfBGIWRl25q9JinLm/u8G51886yTKcyvo48znVL2brsoCPT4cq8MzyHY
 NOp3zYEPcm+EylA28rR+qphG8vdwhUvZFPeys2g2A2BZRejw4qdtQIvIb
 RWS37PQ8cB5EIQ1RhcdKuw4skFfuHiMtN75y44o+mfg5d87KoJHnUPOmn
 YaS9p2kjYnK39JUDFx1QUEcJ7XVW6ogEMZ5j/SFfLlr2yNH1uB2vY+JPS
 LIRSsQjSWX2KnmYUTW+2DXLpK5nOthz3iPYz4R6tsWfGlLurr1Yd11OfL
 VvHM+yPz4NlG33OatDDQq+oQt5E5rv55UiphWbwPj+5DcGD6j2ZEUOUmx w==;
X-CSE-ConnectionGUID: 9tI5h7IjQkaxuVPIOswv7Q==
X-CSE-MsgGUID: O5pu1GeOT2GBG9nD1QurYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="11255010"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="11255010"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 01:46:02 -0700
X-CSE-ConnectionGUID: hTM2e8ziS8qv9zQmgRblXg==
X-CSE-MsgGUID: 8IbRaBZKQAWI1q+9ocdTog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="51287583"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by fmviesa002.fm.intel.com with ESMTP; 06 May 2024 01:46:01 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org,
	yuan1.liu@intel.com,
	nanhai.zou@intel.com
Subject: [PATCH v6 7/7] tests/migration-test: add qpl compression test
Date: Mon,  6 May 2024 00:57:51 +0800
Message-Id: <20240505165751.2392198-8-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240505165751.2392198-1-yuan1.liu@intel.com>
References: <20240505165751.2392198-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.431, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

add qpl to compression method test for multifd migration

the qpl compression supports software path and hardware
path(IAA device), and the hardware path is used first by
default. If the hardware path is unavailable, it will
automatically fallback to the software path for testing.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
---
 tests/qtest/migration-test.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 5d6d8cd634..0f75ed7c49 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2777,6 +2777,15 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
 }
 #endif /* CONFIG_ZSTD */
 
+#ifdef CONFIG_QPL
+static void *
+test_migrate_precopy_tcp_multifd_qpl_start(QTestState *from,
+                                            QTestState *to)
+{
+    return test_migrate_precopy_tcp_multifd_start_common(from, to, "qpl");
+}
+#endif /* CONFIG_QPL */
+
 static void test_multifd_tcp_uri_none(void)
 {
     MigrateCommon args = {
@@ -2857,6 +2866,17 @@ static void test_multifd_tcp_zstd(void)
 }
 #endif
 
+#ifdef CONFIG_QPL
+static void test_multifd_tcp_qpl(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = test_migrate_precopy_tcp_multifd_qpl_start,
+    };
+    test_precopy_common(&args);
+}
+#endif
+
 #ifdef CONFIG_GNUTLS
 static void *
 test_migrate_multifd_tcp_tls_psk_start_match(QTestState *from,
@@ -3760,6 +3780,10 @@ int main(int argc, char **argv)
     migration_test_add("/migration/multifd/tcp/plain/zstd",
                        test_multifd_tcp_zstd);
 #endif
+#ifdef CONFIG_QPL
+    migration_test_add("/migration/multifd/tcp/plain/qpl",
+                       test_multifd_tcp_qpl);
+#endif
 #ifdef CONFIG_GNUTLS
     migration_test_add("/migration/multifd/tcp/tls/psk/match",
                        test_multifd_tcp_tls_psk_match);
-- 
2.39.3


