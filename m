Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6ADC83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtIC-0003VL-5U; Mon, 21 Jul 2025 12:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtHs-00037O-UA
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:22:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtHp-0001Lj-7e
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753114964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IKlPWOpl+9mEBH6KpFIBAbr5kvTW7uY4p2qdsndGhfo=;
 b=F/HnZY6YXZtfj5VJKBN9G/2peuYVPPx5NI0K7PdKoVopc110XmOpgneu6jhJ1B3ks3Xx2r
 7IXYiRkvUDLu0no1nbaqZwWzC2ccZBj1puvExe2wEXEmHhDs3poRVGQNVs9lm74C/xd9B4
 UrmayPPh/Ok9MOzDNlc8n7ME6G/xwg0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-OCOxaZ7eMNSF81Jnw4tCNQ-1; Mon,
 21 Jul 2025 12:22:41 -0400
X-MC-Unique: OCOxaZ7eMNSF81Jnw4tCNQ-1
X-Mimecast-MFC-AGG-ID: OCOxaZ7eMNSF81Jnw4tCNQ_1753114960
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3183C180028C; Mon, 21 Jul 2025 16:22:40 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AD953195608D; Mon, 21 Jul 2025 16:22:37 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 01/50] ppc/xive: Fix xive trace event output
Date: Mon, 21 Jul 2025 18:21:44 +0200
Message-ID: <20250721162233.686837-2-clg@redhat.com>
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

From: Nicholas Piggin <npiggin@gmail.com>

Typo, IBP should be IPB.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-2-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/trace-events | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 334aa6a97bad..9ed2616e58fe 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -274,9 +274,9 @@ kvm_xive_cpu_connect(uint32_t id) "connect CPU%d to KVM device"
 kvm_xive_source_reset(uint32_t srcno) "IRQ 0x%x"
 
 # xive.c
-xive_tctx_accept(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IBP=0x%02x PIPR=0x%02x CPPR=0x%02x NSR=0x%02x ACK"
-xive_tctx_notify(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IBP=0x%02x PIPR=0x%02x CPPR=0x%02x NSR=0x%02x raise !"
-xive_tctx_set_cppr(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IBP=0x%02x PIPR=0x%02x new CPPR=0x%02x NSR=0x%02x"
+xive_tctx_accept(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IPB=0x%02x PIPR=0x%02x CPPR=0x%02x NSR=0x%02x ACK"
+xive_tctx_notify(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IPB=0x%02x PIPR=0x%02x CPPR=0x%02x NSR=0x%02x raise !"
+xive_tctx_set_cppr(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IPB=0x%02x PIPR=0x%02x new CPPR=0x%02x NSR=0x%02x"
 xive_source_esb_read(uint64_t addr, uint32_t srcno, uint64_t value) "@0x%"PRIx64" IRQ 0x%x val=0x%"PRIx64
 xive_source_esb_write(uint64_t addr, uint32_t srcno, uint64_t value) "@0x%"PRIx64" IRQ 0x%x val=0x%"PRIx64
 xive_router_end_notify(uint8_t end_blk, uint32_t end_idx, uint32_t end_data) "END 0x%02x/0x%04x -> enqueue 0x%08x"
-- 
2.50.1


