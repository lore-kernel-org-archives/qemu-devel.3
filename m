Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAA1CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 14:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBCs7-0000Ft-Ff; Tue, 21 Oct 2025 09:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBCs3-0000F2-MP
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:57:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBCs1-0007xK-NU
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761055068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FEfPs3lE3YKqxHYGpmEEm9huybksF3x8fh52qUpukbg=;
 b=N3ZOid3op/tjqtO5UUm7JqsyDMMeMc91fUTRcZTI0U0uE3bRvWowjz85baOYwDxY8cLKK1
 tE0PpYGN6mbLnOGrwUR8z34xejgDNtHPq2CzpfagRN1o+oToA12G6ja22LzWGBTDebdGIQ
 BumhjH/OmfeCAWRv0Vd0jvaaxTH4ZHQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-pMJx3pEsN8qDYpIbktseFA-1; Tue,
 21 Oct 2025 09:57:45 -0400
X-MC-Unique: pMJx3pEsN8qDYpIbktseFA-1
X-Mimecast-MFC-AGG-ID: pMJx3pEsN8qDYpIbktseFA_1761055064
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3D1A195609D; Tue, 21 Oct 2025 13:57:44 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B76519560A2; Tue, 21 Oct 2025 13:57:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/6] hw/s390x/ccw: Remove SCLPDevice::increment_size field
Date: Tue, 21 Oct 2025 15:57:33 +0200
Message-ID: <20251021135735.96145-5-thuth@redhat.com>
In-Reply-To: <20251021135735.96145-1-thuth@redhat.com>
References: <20251021135735.96145-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

The SCLPDevice::increment_size field was only used by the
s390-ccw-virtio-4.2 machine, which got removed. Remove it
as now unused, along with the sclp_memory_init() method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251020094903.72182-3-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/sclp.h |  5 +----
 hw/s390x/sclp.c         | 34 +++-------------------------------
 2 files changed, 4 insertions(+), 35 deletions(-)

diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index d32f6180e0d..33f01f85bb1 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -197,12 +197,9 @@ OBJECT_DECLARE_TYPE(SCLPDevice, SCLPDeviceClass,
 struct SCLPEventFacility;
 
 struct SCLPDevice {
-    /* private */
     DeviceState parent_obj;
-    struct SCLPEventFacility *event_facility;
-    int increment_size;
 
-    /* public */
+    struct SCLPEventFacility *event_facility;
 };
 
 struct SCLPDeviceClass {
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 8602a566a49..c9a9c4bb375 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -110,7 +110,7 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     ReadInfo *read_info = (ReadInfo *) sccb;
     MachineState *machine = MACHINE(qdev_get_machine());
     int cpu_count;
-    int rnsize, rnmax;
+    int rnmax;
     int required_len = SCCB_REQ_LEN(ReadInfo, machine->possible_cpus->len);
     int offset_cpu = s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB) ?
                      offsetof(ReadInfo, entries) :
@@ -153,21 +153,14 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
 
     read_info->mha_pow = s390_get_mha_pow();
     read_info->hmfai = cpu_to_be32(s390_get_hmfai());
-
-    rnsize = 1 << (sclp->increment_size - 20);
-    if (rnsize <= 128) {
-        read_info->rnsize = rnsize;
-    } else {
-        read_info->rnsize = 0;
-        read_info->rnsize2 = cpu_to_be32(rnsize);
-    }
+    read_info->rnsize = 1;
 
     /*
      * We don't support standby memory. maxram_size is used for sizing the
      * memory device region, which is not exposed through SCLP but through
      * diag500.
      */
-    rnmax = machine->ram_size >> sclp->increment_size;
+    rnmax = machine->ram_size >> 20;
     if (rnmax < 0x10000) {
         read_info->rnmax = cpu_to_be16(rnmax);
     } else {
@@ -406,25 +399,6 @@ static void sclp_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void sclp_memory_init(SCLPDevice *sclp)
-{
-    MachineState *machine = MACHINE(qdev_get_machine());
-    MachineClass *machine_class = MACHINE_GET_CLASS(qdev_get_machine());
-    ram_addr_t initial_mem = machine->ram_size;
-    int increment_size = 20;
-
-    /* The storage increment size is a multiple of 1M and is a power of 2.
-     * For some machine types, the number of storage increments must be
-     * MAX_STORAGE_INCREMENTS or fewer.
-     * The variable 'increment_size' is an exponent of 2 that can be
-     * used to calculate the size (in bytes) of an increment. */
-    while (machine_class->fixup_ram_size != NULL &&
-           (initial_mem >> increment_size) > MAX_STORAGE_INCREMENTS) {
-        increment_size++;
-    }
-    sclp->increment_size = increment_size;
-}
-
 static void sclp_init(Object *obj)
 {
     SCLPDevice *sclp = SCLP(obj);
@@ -434,8 +408,6 @@ static void sclp_init(Object *obj)
     object_property_add_child(obj, TYPE_SCLP_EVENT_FACILITY, new);
     object_unref(new);
     sclp->event_facility = EVENT_FACILITY(new);
-
-    sclp_memory_init(sclp);
 }
 
 static void sclp_class_init(ObjectClass *oc, const void *data)
-- 
2.51.0


