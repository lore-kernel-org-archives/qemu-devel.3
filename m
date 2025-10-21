Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44B3CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 13:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBCs8-0000GC-8r; Tue, 21 Oct 2025 09:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBCs3-0000Em-Af
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:57:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBCs1-0007x5-8n
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761055068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vt6uwhyIK+73+a2uJbub1PjgJdGjN+jo4yTjn3+Yv3w=;
 b=IetEASl5o8w7yg3pShMovXlrz62Kk1c0WzlaMBFOOnQxlinKMw+a7GKpgHJjUbYVjikzyG
 NeHid+ujT/KKpNp9u8v6PoWcApQSak9M3pUAA/J0W8jBPjrntWzm4Ld4bXMLb9YZ0RqRFg
 Aa5a8pI4fGWgcgVoZP9zVyjhlL1FWi4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-lHsfAsHgMiG0WcsMKvDoxQ-1; Tue,
 21 Oct 2025 09:57:44 -0400
X-MC-Unique: lHsfAsHgMiG0WcsMKvDoxQ-1
X-Mimecast-MFC-AGG-ID: lHsfAsHgMiG0WcsMKvDoxQ_1761055063
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27219195609F; Tue, 21 Oct 2025 13:57:43 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 090DB19560A2; Tue, 21 Oct 2025 13:57:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/6] hw/s390x/ccw: Remove deprecated s390-ccw-virtio-4.2 machine
Date: Tue, 21 Oct 2025 15:57:32 +0200
Message-ID: <20251021135735.96145-4-thuth@redhat.com>
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251020094903.72182-2-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index ad2c48188a8..64b81345f1e 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -715,26 +715,6 @@ static void s390_nmi(NMIState *n, int cpu_index, Error **errp)
     s390_cpu_restart(S390_CPU(cs));
 }
 
-static ram_addr_t s390_fixup_ram_size(ram_addr_t sz)
-{
-    /* same logic as in sclp.c */
-    int increment_size = 20;
-    ram_addr_t newsz;
-
-    while ((sz >> increment_size) > MAX_STORAGE_INCREMENTS) {
-        increment_size++;
-    }
-    newsz = sz >> increment_size << increment_size;
-
-    if (sz != newsz) {
-        qemu_printf("Ram size %" PRIu64 "MB was fixed up to %" PRIu64
-                    "MB to match machine restrictions. Consider updating "
-                    "the guest definition.\n", (uint64_t) (sz / MiB),
-                    (uint64_t) (newsz / MiB));
-    }
-    return newsz;
-}
-
 static inline bool machine_get_aes_key_wrap(Object *obj, Error **errp)
 {
     S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
@@ -1165,19 +1145,6 @@ static void ccw_machine_5_0_class_options(MachineClass *mc)
 }
 DEFINE_CCW_MACHINE(5, 0);
 
-static void ccw_machine_4_2_instance_options(MachineState *machine)
-{
-    ccw_machine_5_0_instance_options(machine);
-}
-
-static void ccw_machine_4_2_class_options(MachineClass *mc)
-{
-    ccw_machine_5_0_class_options(mc);
-    mc->fixup_ram_size = s390_fixup_ram_size;
-    compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
-}
-DEFINE_CCW_MACHINE(4, 2);
-
 static void ccw_machine_register_types(void)
 {
     type_register_static(&ccw_machine_info);
-- 
2.51.0


