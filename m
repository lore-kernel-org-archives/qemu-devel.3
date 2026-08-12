Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D926C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAMs-0002sx-IT; Wed, 12 Aug 2026 10:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAKq-00070j-CW; Wed, 12 Aug 2026 10:53:44 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAKo-0007Fe-1g; Wed, 12 Aug 2026 10:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546231; bh=e9Yiez50CyAc97C5W2GTEJdMhwa/z8xGuqOgDjBHJFc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=uRItuMTSn5uHIyaregwnOOMo7JjWvAzBLuVztHARolsK2ThKVBnywfryGdLdP5z1+
 uC8Rnt5WXLRNDz1mGLmcdxNUrnxght3zsY7JXLJ9oxNL5oMVkHZKCBhS3qA9Srn6EW
 fwGxPlW2/NBeErTkrVzU+e3aeapmggTTyt7SuFnwTM7h+t9ORGvf9pF/HbMiSAUUiu
 d+8bmYWxdANdbjViVlydiNOXtH9F3uDnVwzgRD0qpmtKbwvs4W64X2syWVXIF6Q63x
 T6Yh/ihVx5nlwMQD3DOftTbrVPbxC3eEDsFyCO8S+nWTBhAcs7+W3zMnQR7646QCSV
 XzIqJKQbstapQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B81811CA62A;
 Wed, 12 Aug 2026 17:50:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1EF8A409D6C;
 Wed, 12 Aug 2026 17:50:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7EDC62F9AF; Wed, 12 Aug 2026 17:50:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 038/120] target/i386/sev: fix MemoryRegion reference
 leaks in gpa2hva callers
Date: Wed, 12 Aug 2026 17:48:21 +0300
Message-ID: <20260812144955.649205-38-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

gpa2hva() returns a referenced MemoryRegion via its p_mr out-parameter
(inherited from memory_region_find()), but both SEV callers were failing
to release it.

Fixes: c7f7e6970d3b ("sev: add sev-inject-launch-secret")
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260521145451.1831984-1-marcandre.lureau@redhat.com>
(cherry picked from commit 415f2759d7b3294e15c783849a08deb26885cabc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/system/memory.h b/include/system/memory.h
index d7b18b632d5..f38ad693cfa 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1343,6 +1343,8 @@ void memory_region_ref(MemoryRegion *mr);
  */
 void memory_region_unref(MemoryRegion *mr);
 
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(MemoryRegion, memory_region_unref)
+
 /**
  * memory_region_init_io: Initialize an I/O memory region.
  *
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 9dde972c118..9eddf921341 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1573,7 +1573,7 @@ snp_populate_metadata_pages(SevSnpGuestState *sev_snp,
     OvmfSevMetadataDesc *desc;
     int type, ret, i;
     void *hva;
-    MemoryRegion *mr = NULL;
+    g_autoptr(MemoryRegion) mr = NULL;
 
     for (i = 0; i < metadata->num_desc; i++) {
         desc = &metadata->descs[i];
@@ -2067,7 +2067,7 @@ int sev_inject_launch_secret(const char *packet_hdr, const char *secret,
     int error, ret = 1;
     void *hva;
     gsize hdr_sz = 0, data_sz = 0;
-    MemoryRegion *mr = NULL;
+    g_autoptr(MemoryRegion) mr = NULL;
     SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
 
     if (!sev_common) {
-- 
2.47.3


