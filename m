Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12027C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wilfY-0007of-3W; Sun, 12 Jul 2026 00:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilfL-0007kL-1e; Sun, 12 Jul 2026 00:19:44 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilfJ-0006kj-9j; Sun, 12 Jul 2026 00:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829781; bh=mFsIrytqWquiBVni1uJmX1hOaQaKDbrkSNEfcG/ULyY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SpJlrokgL9i1Y6ehIb2dus5NxrNs2GIwAsCfubzaYUo0fFFFMlZdbOUmw2FJVT+UY
 1Fxll7VGjxZhOXCiAoudOA/yOmydaKejzTuOAhYvAFpA9rbgSq0ssddxYMnM6Gv13F
 8002sAB60tO2MnApEwXoI2rSwaqVnwUx7lPUJ1EnTFBzqZPFHybX6x3WpqwDq1XWxb
 bL1wVKrgC2IXBFksYEiFfMdy1kKgSePXlXfHXr61d0n7J46PTU/Uxnoj9q9iv3Ipls
 Nl0dRIECLwiCcNDu0MFL2Gx5wJt0R1K9I+fr0Euj0mPNSr8VMZq6bbdDZQ6xHhi5zp
 rFnDRUvOq/5Gg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9538C1C0C02;
 Sun, 12 Jul 2026 07:16:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C82643EB962;
 Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 704E913407; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 39/75] s390x/sclp: reject invalid write event data
 headers
Date: Sun, 12 Jul 2026 07:14:57 +0300
Message-ID: <20260712041539.108341-39-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Christian Borntraeger <borntraeger@linux.ibm.com>

If a guest submits an sccb with a tiny header length but a large number
of event mask entries, the write_event_mask handler will
1. return the wrong RC (ok instead of error)
2. write to memory after the allocated sccb in qemu host memory.

Add the necessary checks.

Cc: qemu-stable@nongnu.org
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Message-ID: <20260707070728.147203-2-borntraeger@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
(cherry picked from commit d88cd8f5570f4d6e08d62e098a8b7f53cdc75536)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 2b0332c20e2..18361a3bf45 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -291,6 +291,7 @@ static void read_event_data(SCLPEventFacility *ef, SCCB *sccb)
 static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
 {
     WriteEventMask *we_mask = (WriteEventMask *) sccb;
+    uint16_t sccb_length = be16_to_cpu(sccb->h.length);
     uint16_t mask_length = be16_to_cpu(we_mask->mask_length);
     sccb_mask_t tmp_mask;
 
@@ -300,6 +301,11 @@ static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
         return;
     }
 
+    if (sccb_length < sizeof(WriteEventMask) + 4 * mask_length) {
+        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
+        return;
+    }
+
     /*
      * Note: We currently only support masks up to 8 byte length;
      *       the remainder is filled up with zeroes. Older Linux
-- 
2.47.3


