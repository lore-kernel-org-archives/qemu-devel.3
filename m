Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07543606A33B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sfm3i30o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xODiO-0000B7-1v; Tue, 03 Nov 2026 07:34:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xODiH-00009c-Ld
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 07:34:05 -0500
Received: from out-140.mta1.migadu.com ([95.215.58.140] helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xODiF-0005ML-Ow
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 07:34:05 -0500
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=WYdlRMcPEa7W81bJ23TK/XD9IqWX5ZXNvNIkVH759EI=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793709241; v=1; x=1794314041;
 b=sfm3i30ogrJm5zgfwF7BhBAFEATlju1NGXiIAsMxPfQ/+LxxH6cCfXOAqPf62he9pX7FUtye
 8kn/FGMj1FVvTAZ/8lkYsgJVOZaCh+rexB4/Q6Rt3qd5/L0qzaq20r8dovNnNmM9HQCVyYVlXbj
 /mInMoG8YTkE5JBQ7b1migVY=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 29a5066799d6f858;
 Tue, 03 Nov 2026 12:34:01 +0000
X-Mizu-Trace-ID: 29a5066799d6f858
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, jamin_lin@aspeedtech.com, philmd@oss.qualcomm.com,
 clg@redhat.com, peter.maydell@linaro.org, kraxel@redhat.com,
 marcandre.lureau@redhat.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, junjie.cao@linux.dev
Subject: [PATCH 1/2] hw/usb/hcd-ehci: idle the schedule after a failed
 descriptor read
Date: Tue,  3 Nov 2026 06:33:49 -0600
Message-ID: <20261103123350.1253202-2-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103123350.1253202-1-junjie.cao@linux.dev>
References: <20261103123350.1253202-1-junjie.cao@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.215.58.140; envelope-from=junjie.cao@linux.dev;
 helo=mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since get_dwords() started checking the DMA result, a failed descriptor
read raises HSE, clears Run/Stop and makes the state function return
without advancing.  That leaves the schedule in WAITLISTHEAD, FETCHQH,
FETCHSITD or FETCHQTD, none of which ehci_advance_async_state() or
ehci_advance_periodic_state() accept: the next frame hits their
g_assert_not_reached().

A guest gets there by pointing ASYNCLISTADDR, a QH's next qTD or a
frame list entry at an address outside guest memory; QEMU aborts on the
second frame.

Return the schedule to EST_ACTIVE at those four sites, so the next pass
sees Run/Stop clear and tears it down the way a stopped schedule is.
The iTD and fill-queue reads already take the existing controller-reset
path on error and are left alone.

Fixes: 2b2a0e4f465a ("hw/usb/hcd-ehci: Check for DMA errors in get_dwords()/put_dwords()")
Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
---
 hw/usb/hcd-ehci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index f371e567f3..938707043f 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -330,6 +330,15 @@ static int ehci_get_state(EHCIState *s, int async)
     return async ? s->astate : s->pstate;
 }
 
+/*
+ * get_dwords() has raised HSE and cleared Run/Stop.  Park the schedule
+ * in EST_ACTIVE so the next advance pass idles it instead of asserting.
+ */
+static void ehci_abandon_pass(EHCIState *ehci, int async)
+{
+    ehci_set_state(ehci, async, EST_ACTIVE);
+}
+
 static void ehci_set_fetch_addr(EHCIState *s, int async, uint64_t addr)
 {
     if (async) {
@@ -1600,6 +1609,7 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  int async)
     for (i = 0; i < MAX_QH; i++) {
         if (!get_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &qh,
                         ehci_qh_dwords(ehci))) {
+            ehci_abandon_pass(ehci, async);
             return 0;
         }
         ehci_trace_qh(NULL, NLPTR_GET(entry), &qh);
@@ -1703,6 +1713,7 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)
     memset(&qh, 0, sizeof(qh));
     if (!get_dwords(ehci, NLPTR_GET(q->qhaddr),
                     (uint32_t *) &qh, ehci_qh_dwords(ehci))) {
+        ehci_abandon_pass(ehci, async);
         q = NULL;
         goto out;
     }
@@ -1807,6 +1818,7 @@ static int ehci_state_fetchsitd(EHCIState *ehci, int async)
 
     if (!get_dwords(ehci, NLPTR_GET(entry), (uint32_t *)&sitd,
                     sizeof(EHCIsitd) >> 2)) {
+        ehci_abandon_pass(ehci, async);
         return 0;
     }
     ehci_trace_sitd(ehci, entry, &sitd);
@@ -1867,6 +1879,7 @@ static int ehci_state_fetchqtd(EHCIQueue *q)
 
     addr = NLPTR_GET(q->qtdaddr);
     if (!get_dwords(q->ehci, addr +  8, &qtd.token,   1)) {
+        ehci_abandon_pass(q->ehci, q->async);
         return 0;
     }
     barrier();
@@ -1878,6 +1891,7 @@ static int ehci_state_fetchqtd(EHCIQueue *q)
         (q->ehci->caps_64bit_addr &&
          !get_dwords(q->ehci, addr + offsetof(EHCIqtd, bufptr_hi),
                      qtd.bufptr_hi, ARRAY_SIZE(qtd.bufptr_hi)))) {
+        ehci_abandon_pass(q->ehci, q->async);
         return 0;
     }
     ehci_trace_qtd(q, NLPTR_GET(q->qtdaddr), &qtd);
-- 
2.43.0


