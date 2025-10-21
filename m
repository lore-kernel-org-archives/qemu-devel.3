Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AADFCCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 13:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBCsd-0000RN-2d; Tue, 21 Oct 2025 09:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBCs8-0000G4-3d
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:57:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBCs6-0007xm-0V
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761055071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pGAIDv42ZLXGZFlnkWXLQ50dypdaStkaWhAB27BHzxE=;
 b=ADbtasHfM0Rh+yyJq1rUotaRa/EMORjX4yWaTRJrNDFj2Gw3lhvVA5zU1HYEjy/Vf9/n5e
 k0lQ6UERtDgPBfXxZstUEq1Prd7wwoTvdEFJcUsYLkKkney4vNkdWa0LnlvBdQcEMRiJHj
 HYHXk2FdBUAgW2paWlx8P42lzFtrsOQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-efk3NYn8OA60PgaYQXK3rw-1; Tue,
 21 Oct 2025 09:57:47 -0400
X-MC-Unique: efk3NYn8OA60PgaYQXK3rw-1
X-Mimecast-MFC-AGG-ID: efk3NYn8OA60PgaYQXK3rw_1761055066
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D03719560A3; Tue, 21 Oct 2025 13:57:46 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1382119560A2; Tue, 21 Oct 2025 13:57:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/6] hw/core/machine: Remove MachineClass::fixup_ram_size
 callback
Date: Tue, 21 Oct 2025 15:57:34 +0200
Message-ID: <20251021135735.96145-6-thuth@redhat.com>
In-Reply-To: <20251021135735.96145-1-thuth@redhat.com>
References: <20251021135735.96145-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The MachineClass::fixup_ram_size callback, which was added
in commit 5c30ef937f5 ("vl/s390x: fixup ram sizes for compat
machines"), was only used by the s390-ccw-virtio-4.2 machine,
which got removed. Remove it as now unused.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251020094903.72182-4-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/boards.h | 7 -------
 hw/core/machine.c   | 3 ---
 2 files changed, 10 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 665b6201214..d0a69cd490b 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -250,12 +250,6 @@ typedef struct {
  *    It also will be used as a way to option into "-m" option support.
  *    If it's not set by board, '-m' will be ignored and generic code will
  *    not create default RAM MemoryRegion.
- * @fixup_ram_size:
- *    Amends user provided ram size (with -m option) using machine
- *    specific algorithm. To be used by old machine types for compat
- *    purposes only.
- *    Applies only to default memory backend, i.e., explicit memory backend
- *    wasn't used.
  * @smbios_memory_device_size:
  *    Default size of memory device,
  *    SMBIOS 3.1.0 "7.18 Memory Device (Type 17)"
@@ -325,7 +319,6 @@ struct MachineClass {
                                                          unsigned cpu_index);
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
     int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
-    ram_addr_t (*fixup_ram_size)(ram_addr_t size);
     uint64_t smbios_memory_device_size;
     bool (*create_default_memdev)(MachineState *ms, const char *path,
                                   Error **errp);
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 681adbb7ac5..7aec3916e80 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -648,9 +648,6 @@ static void machine_set_mem(Object *obj, Visitor *v, const char *name,
         mem->size = mc->default_ram_size;
     }
     mem->size = QEMU_ALIGN_UP(mem->size, 8192);
-    if (mc->fixup_ram_size) {
-        mem->size = mc->fixup_ram_size(mem->size);
-    }
     if ((ram_addr_t)mem->size != mem->size) {
         error_setg(errp, "ram size %llu exceeds permitted maximum %llu",
                    (unsigned long long)mem->size,
-- 
2.51.0


