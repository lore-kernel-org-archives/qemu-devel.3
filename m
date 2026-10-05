Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918E9CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 12:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDhWf-0006lc-VT; Mon, 05 Oct 2026 08:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDhVm-00067P-7F
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 08:09:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDhVk-0004mN-FA
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 08:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791202179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lyP3UQF2xWV/4IztDyEFIqZ2kWG1P/DRVkR4OcGm7lU=;
 b=GyZDNUMDcFjt9STsAJYTxFCPC9XyHw4nPo30IaJP/slWPaj0OflW3Om8gSa/l5YBb8dHgn
 ArBV+MV+KBJbLoxdrUwl6lpgZnk+WPS6KnobpcUrjU4Ie4CkbGoUUkOSk+ceN/LR6HKf/v
 O2l2hoCzOu8Rfsn67TAdKe1Wun0wJ4c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-g2ND1kX1OmyDbKDx2UMaEg-1; Mon,
 05 Oct 2026 08:09:37 -0400
X-MC-Unique: g2ND1kX1OmyDbKDx2UMaEg-1
X-Mimecast-MFC-AGG-ID: g2ND1kX1OmyDbKDx2UMaEg_1791202176
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D48DD1954227; Mon,  5 Oct 2026 12:09:36 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66DB13001D29; Mon,  5 Oct 2026 12:09:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 21/24] trace: remove "disable" property from trace files
Date: Mon,  5 Oct 2026 13:08:52 +0100
Message-ID: <20261005120855.421973-22-berrange@redhat.com>
In-Reply-To: <20261005120855.421973-1-berrange@redhat.com>
References: <20261005120855.421973-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The scenarios are not significant enough to justify its use

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/display/trace-events  |  2 +-
 target/hppa/trace-events | 28 ++++++++++++++--------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/display/trace-events b/hw/display/trace-events
index c5e7e42af23..223a085922b 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -60,7 +60,7 @@ virtio_gpu_dec_inflight_fences(uint32_t inflight) "in-flight- %u"
 virtio_gpu_cmd_suspended(uint32_t cmd) "cmd 0x%x"
 
 # qxl.c
-disable qxl_io_write_vga(int qid, const char *mode, uint32_t addr, uint32_t val) "%d %s addr=%u val=%u"
+qxl_io_write_vga(int qid, const char *mode, uint32_t addr, uint32_t val) "%d %s addr=%u val=%u"
 qxl_create_guest_primary(int qid, uint32_t width, uint32_t height, uint64_t mem, uint32_t format, uint32_t position) "%d %ux%u mem=0x%" PRIx64 " %u,%u"
 qxl_create_guest_primary_rest(int qid, int32_t stride, uint32_t type, uint32_t flags) "%d %d,%d,%d"
 qxl_destroy_primary(int qid) "%d"
diff --git a/target/hppa/trace-events b/target/hppa/trace-events
index 01761a4559b..7c897610a9e 100644
--- a/target/hppa/trace-events
+++ b/target/hppa/trace-events
@@ -1,19 +1,19 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
 # mem_helper.c
-disable hppa_tlb_flush_ent(void *env, void *ent, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=%p ent=%p va_b=0x%lx va_e=0x%lx pa=0x%" PRIx64
-disable hppa_tlb_find_entry(void *env, void *ent, int valid, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=%p ent=%p valid=%d va_b=0x%lx va_e=0x%lx pa=0x%" PRIx64
-disable hppa_tlb_find_entry_not_found(void *env, uint64_t addr) "env=%p addr=%08lx"
-disable hppa_tlb_get_physical_address(void *env, int ret, int prot, uint64_t addr, uint64_t phys) "env=%p ret=%d prot=%d addr=0x%lx phys=0x%lx"
-disable hppa_tlb_fill_excp(void *env, uint64_t addr, int size, int type, int mmu_idx) "env=%p addr=0x%lx size=%d type=%d mmu_idx=%d"
-disable hppa_tlb_fill_success(void *env, uint64_t addr, uint64_t phys, int size, int type, int mmu_idx) "env=%p addr=0x%lx phys=0x%lx size=%d type=%d mmu_idx=%d"
-disable hppa_tlb_itlba(void *env, void *ent, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=%p ent=%p va_b=0x%lx va_e=0x%lx pa=0x%" PRIx64
-disable hppa_tlb_itlbp(void *env, void *ent, int access_id, int u, int pl2, int pl1, int type, int b, int d, int t) "env=%p ent=%p access_id=%x u=%d pl2=%d pl1=%d type=%d b=%d d=%d t=%d"
-disable hppa_tlb_ptlb(void *env) "env=%p"
-disable hppa_tlb_ptlb_local(void *env) "env=%p"
-disable hppa_tlb_ptlbe(void *env) "env=%p"
-disable hppa_tlb_lpa_success(void *env, uint64_t addr, uint64_t phys) "env=%p addr=0x%lx phys=0x%lx"
-disable hppa_tlb_lpa_failed(void *env, uint64_t addr) "env=%p addr=0x%lx"
+hppa_tlb_flush_ent(void *env, void *ent, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=%p ent=%p va_b=0x%lx va_e=0x%lx pa=0x%" PRIx64
+hppa_tlb_find_entry(void *env, void *ent, int valid, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=%p ent=%p valid=%d va_b=0x%lx va_e=0x%lx pa=0x%" PRIx64
+hppa_tlb_find_entry_not_found(void *env, uint64_t addr) "env=%p addr=%08lx"
+hppa_tlb_get_physical_address(void *env, int ret, int prot, uint64_t addr, uint64_t phys) "env=%p ret=%d prot=%d addr=0x%lx phys=0x%lx"
+hppa_tlb_fill_excp(void *env, uint64_t addr, int size, int type, int mmu_idx) "env=%p addr=0x%lx size=%d type=%d mmu_idx=%d"
+hppa_tlb_fill_success(void *env, uint64_t addr, uint64_t phys, int size, int type, int mmu_idx) "env=%p addr=0x%lx phys=0x%lx size=%d type=%d mmu_idx=%d"
+hppa_tlb_itlba(void *env, void *ent, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=%p ent=%p va_b=0x%lx va_e=0x%lx pa=0x%" PRIx64
+hppa_tlb_itlbp(void *env, void *ent, int access_id, int u, int pl2, int pl1, int type, int b, int d, int t) "env=%p ent=%p access_id=%x u=%d pl2=%d pl1=%d type=%d b=%d d=%d t=%d"
+hppa_tlb_ptlb(void *env) "env=%p"
+hppa_tlb_ptlb_local(void *env) "env=%p"
+hppa_tlb_ptlbe(void *env) "env=%p"
+hppa_tlb_lpa_success(void *env, uint64_t addr, uint64_t phys) "env=%p addr=0x%lx phys=0x%lx"
+hppa_tlb_lpa_failed(void *env, uint64_t addr) "env=%p addr=0x%lx"
 
 # op_helper.c
-disable hppa_tlb_probe(uint64_t addr, int level, int want) "addr=0x%lx level=%d want=%d"
+hppa_tlb_probe(uint64_t addr, int level, int want) "addr=0x%lx level=%d want=%d"
-- 
2.55.0


