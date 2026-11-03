Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA88D606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=SpVgaQuI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOK20-0000rG-1C; Tue, 03 Nov 2026 14:18:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xOK1u-0000qD-Fh
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 14:18:47 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xOK1s-0007rw-0j
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 14:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=b8lxwQR2D5XEWs7Xoesgyd+M5Ru3/C6qqtlQIy7pMFc=; b=SpVgaQuI/H5o0X6
 DZFRkPlUeJD2JV50j5EtdnzEsxgezj1tQZrt/SQ32RodSOWvcxH8B6JY9E7TmEi7EY16+jroVLFMi
 CTtNP9yvW+AVcoMUEQGhQO+xGWSQ3ktRdpeDY9JvVdG+6+xE/rJgporr/swLkLku+o3FbLbZ9R9XM
 oY=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v1 2/6] target/hexagon: HLX,
 search for .new values in pair high register
Date: Tue,  3 Nov 2026 20:23:54 +0100
Message-ID: <20261103192358.28589-3-anjo@rev.ng>
In-Reply-To: <20261103192358.28589-1-anjo@rev.ng>
References: <20261103192358.28589-1-anjo@rev.ng>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Otherwise, the following packet

  {
      L7:6 = combine(L0, L1)
      memw(R7) = L7.new
  }

results in memw(R7) being zero-intialized, compared to L6.new which
would correctly write the lower bytes of the pair.

Fixes: ef81d1b047337e81 ("target/hexagon: decode HLX packets and add load and store")
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/decode.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index d48630da87..8921ff765d 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -110,9 +110,25 @@ static int hlx_find_new_value_producer(Packet *packet, int consumer,
 {
     for (int i = 0; i < packet->num_insns; i++) {
         Insn *insn = &packet->insn[i];
+        uint8_t regno;
 
-        if (i != consumer && GET_ATTRIB(insn->opcode, A_HLX) &&
-            insn->dest_idx != -1 && insn->regno[insn->dest_idx] == lreg) {
+        /*
+         * Skip ourselves, instructions without return values, and
+         * any non-HLX instructions.
+         */
+        if (i == consumer || !GET_ATTRIB(insn->opcode, A_HLX) ||
+            insn->dest_idx == -1) {
+            continue;
+        }
+
+        regno = insn->regno[insn->dest_idx];
+
+        /*
+         * Compare against the base register number, and against the top
+         * register for instructions returning pairs.
+         */
+        if (regno == lreg ||
+            (GET_ATTRIB(insn->opcode, A_HLX_PAIRED_ALU) && regno + 1 == lreg)) {
             return i;
         }
     }
-- 
2.52.0


