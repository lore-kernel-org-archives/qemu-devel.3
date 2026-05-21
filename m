Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC187CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ4oC-0008Ol-AM; Thu, 21 May 2026 10:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ4nu-0008Kv-GL
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ4nr-0001t8-Ky
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779375314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KbVkSi2FA3zfV3b05kKADQgLFBaKkxPEvGcknU8X7sg=;
 b=OErsoATqivbdJuqURN1ytRjGu2Ko1Fqsaut8inOU0fRW5VUNQjzcn3ZjUVr1mWNYfIpg5M
 kSw8gku6pXwr5vsXDhPJkgg5+EJ/iTnUseYFpQ+QyFH+mEUeZC29ftZ9OhvFnJmB40MZzs
 aDzcwzgsA/rRwOmHJ6/v1keRVE0y0yo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-6EIFua6ZMxicfKq195Lx0A-1; Thu,
 21 May 2026 10:54:59 -0400
X-MC-Unique: 6EIFua6ZMxicfKq195Lx0A-1
X-Mimecast-MFC-AGG-ID: 6EIFua6ZMxicfKq195Lx0A_1779375297
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA05319560B8; Thu, 21 May 2026 14:54:56 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0CFAA3002D2D; Thu, 21 May 2026 14:54:54 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org (open list:X86 KVM CPUs)
Subject: [PATCH] target/i386/sev: fix MemoryRegion reference leaks in gpa2hva
 callers
Date: Thu, 21 May 2026 18:54:51 +0400
Message-ID: <20260521145451.1831984-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/system/memory.h | 2 ++
 target/i386/sev.c       | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 1417132f6d9..53f65a224bb 100644
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
index b44b5a1c2b9..3ae922779d7 100644
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
2.54.0


