Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5CBC87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 06:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhiqw-0005iN-MM; Fri, 01 Aug 2025 02:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uhiqF-000575-8g
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 02:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uhiqD-0004Hd-Jw
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 02:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754028123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xY/vyLWMiPt1HzBTJL1PdPZ9hLpuMMxqRkwmaKEayzQ=;
 b=EJcrq5mM8v+5r7l7AQfn4C2eL96PgS9PEKz4VDqxw9CEhUnGEzMkzR4auefOmAlwhJU5eV
 wPzly0SxIAQ1ZDxzbfVB3BnytThJjX84z4MhOIXeJfFKeZXEQY2jsArFE0KtJ0Z1yEsMA0
 IsPAXDfCBcUR/HYnpc2Kkaz82lSIlQo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-Llgl-wwGPvmi-4sA10s5LQ-1; Fri,
 01 Aug 2025 02:01:59 -0400
X-MC-Unique: Llgl-wwGPvmi-4sA10s5LQ-1
X-Mimecast-MFC-AGG-ID: Llgl-wwGPvmi-4sA10s5LQ_1754028118
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0257E18002A5; Fri,  1 Aug 2025 06:01:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.37])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D80B51800D86; Fri,  1 Aug 2025 06:01:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-trivial@nongnu.org
Subject: [PATCH] hw/intc/loongarch_pch_pic: Fix ubsan warning and endianness
 issue
Date: Fri,  1 Aug 2025 08:01:52 +0200
Message-ID: <20250801060152.22224-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

When booting the Linux kernel from tests/functional/test_loongarch64_virt.py
with a QEMU that has been compiled with --enable-ubsan, there is
a warning like this:

 .../hw/intc/loongarch_pch_pic.c:171:46: runtime error: index 512 out of
  bounds for type 'uint8_t[64]' (aka 'unsigned char[64]')
 SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
  .../hw/intc/loongarch_pch_pic.c:171:46
 .../hw/intc/loongarch_pch_pic.c:175:45: runtime error: index 256 out of
  bounds for type 'uint8_t[64]' (aka 'unsigned char[64]')
 SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
  .../hw/intc/loongarch_pch_pic.c:175:45

It happens because "addr" is added first before substracting the base
(PCH_PIC_HTMSI_VEC or PCH_PIC_ROUTE_ENTRY).
Additionally, this code looks like it is not endianness safe, since
it uses a 64-bit pointer to write values into an array of 8-bit values.

Thus rework the code to use the stq_le_p / ldq_le_p helpers here
and make sure that we do not create pointers with undefined behavior
by accident.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/intc/loongarch_pch_pic.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index c4b242dbf41..32f01aabf0e 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -110,10 +110,10 @@ static uint64_t pch_pic_read(void *opaque, hwaddr addr, uint64_t field_mask)
         val = s->int_polarity;
         break;
     case PCH_PIC_HTMSI_VEC ... PCH_PIC_HTMSI_VEC_END:
-        val = *(uint64_t *)(s->htmsi_vector + addr - PCH_PIC_HTMSI_VEC);
+        val = ldq_le_p(&s->htmsi_vector[addr - PCH_PIC_HTMSI_VEC]);
         break;
     case PCH_PIC_ROUTE_ENTRY ... PCH_PIC_ROUTE_ENTRY_END:
-        val = *(uint64_t *)(s->route_entry + addr - PCH_PIC_ROUTE_ENTRY);
+        val = ldq_le_p(&s->route_entry[addr - PCH_PIC_ROUTE_ENTRY]);
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -129,7 +129,8 @@ static void pch_pic_write(void *opaque, hwaddr addr, uint64_t value,
 {
     LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
     uint32_t offset;
-    uint64_t old, mask, data, *ptemp;
+    uint64_t old, mask, data;
+    void *ptemp;
 
     offset = addr & 7;
     addr -= offset;
@@ -168,12 +169,12 @@ static void pch_pic_write(void *opaque, hwaddr addr, uint64_t value,
         s->int_polarity = (s->int_polarity & ~mask) | data;
         break;
     case PCH_PIC_HTMSI_VEC ... PCH_PIC_HTMSI_VEC_END:
-        ptemp = (uint64_t *)(s->htmsi_vector + addr - PCH_PIC_HTMSI_VEC);
-        *ptemp = (*ptemp & ~mask) | data;
+        ptemp = &s->htmsi_vector[addr - PCH_PIC_HTMSI_VEC];
+        stq_le_p(ptemp, (ldq_le_p(ptemp) & ~mask) | data);
         break;
     case PCH_PIC_ROUTE_ENTRY ... PCH_PIC_ROUTE_ENTRY_END:
-        ptemp = (uint64_t *)(s->route_entry + addr - PCH_PIC_ROUTE_ENTRY);
-        *ptemp = (*ptemp & ~mask) | data;
+        ptemp = (uint64_t *)&s->route_entry[addr - PCH_PIC_ROUTE_ENTRY];
+        stq_le_p(ptemp, (ldq_le_p(ptemp) & ~mask) | data);
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
-- 
2.50.1


