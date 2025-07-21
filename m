Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5F9C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtIO-0003ov-97; Mon, 21 Jul 2025 12:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtI9-0003NK-6h
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtI7-0001Pd-0Y
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753114981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oxjl9Plxfxd+LhAa4iwUt8737MCf+RsKZaagKDT9fCg=;
 b=Rn5pImcLyx3bsZ0bkj3+mDsKj0qJ7OuDZYDxLCJvBxR5seqkGvIIXhF/kRr+3L9De+gEfW
 NV1ENn1hyDDXhqZ1iGjZyARAsnthHYRk53cj+M6VjzEMwUBr7dG/WSWUSORYZh7dvmL4lE
 fNYOGxS1/SN10xNca0GJ+/bIoDxDsnk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-6nDJDb2UPqio7kv6Qbq2Eg-1; Mon,
 21 Jul 2025 12:22:59 -0400
X-MC-Unique: 6nDJDb2UPqio7kv6Qbq2Eg-1
X-Mimecast-MFC-AGG-ID: 6nDJDb2UPqio7kv6Qbq2Eg_1753114978
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0219E18002B1; Mon, 21 Jul 2025 16:22:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 880C0195608D; Mon, 21 Jul 2025 16:22:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Kowal <kowal@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/50] ppc/xive2: Reset Generation Flipped bit on END Cache
 Watch
Date: Mon, 21 Jul 2025 18:21:50 +0200
Message-ID: <20250721162233.686837-8-clg@redhat.com>
In-Reply-To: <20250721162233.686837-1-clg@redhat.com>
References: <20250721162233.686837-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Michael Kowal <kowal@linux.ibm.com>

When the END Event Queue wraps the END EQ Generation bit is flipped and the
Generation Flipped bit is set to one.  On a END cache Watch read operation,
the Generation Flipped bit needs to be reset.

While debugging an error modified END not valid error messages to include
the method since all were the same.

Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-8-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/pnv_xive2.c | 3 ++-
 hw/intc/xive2.c     | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 6b724fe762f6..ec247ce48ff7 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1325,10 +1325,11 @@ static uint64_t pnv_xive2_ic_vc_read(void *opaque, hwaddr offset,
     case VC_ENDC_WATCH3_DATA0:
         /*
          * Load DATA registers from cache with data requested by the
-         * SPEC register
+         * SPEC register.  Clear gen_flipped bit in word 1.
          */
         watch_engine = (offset - VC_ENDC_WATCH0_DATA0) >> 6;
         pnv_xive2_end_cache_load(xive, watch_engine);
+        xive->vc_regs[reg] &= ~(uint64_t)END2_W1_GEN_FLIPPED;
         val = xive->vc_regs[reg];
         break;
 
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 01cf96a2af65..edf5d9eb94cb 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -374,8 +374,8 @@ static void xive2_end_enqueue(Xive2End *end, uint32_t data)
         qgen ^= 1;
         end->w1 = xive_set_field32(END2_W1_GENERATION, end->w1, qgen);
 
-        /* TODO(PowerNV): reset GF bit on a cache watch operation */
-        end->w1 = xive_set_field32(END2_W1_GEN_FLIPPED, end->w1, qgen);
+        /* Set gen flipped to 1, it gets reset on a cache watch operation */
+        end->w1 = xive_set_field32(END2_W1_GEN_FLIPPED, end->w1, 1);
     }
     end->w1 = xive_set_field32(END2_W1_PAGE_OFF, end->w1, qindex);
 }
-- 
2.50.1


