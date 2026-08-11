Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED19C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpPW-0006qX-Hb; Tue, 11 Aug 2026 12:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpP7-0005aC-N6
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpP5-00014Z-7u
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=btkZuydIPHvm5emdJ9lRUMMCGamCp4el/wjNyQd1K20=;
 b=Reo/++lJIyZCr+GI5gy22Lynh5G3JMFXanE25yAYI1im6Xk1Gom6D/tz4nnv9nxeWjMcLg
 Z3jGYAKIQq5gSruGjDOBcu+iWAdkdXgVRZ6rgUGkuIVUaJ0LdpwPGYATuE8xpFmzOeNkRE
 1MF7uDExs2gsV/WdeP0bv+TBraHtvGY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-QuN8coFtPA6QfK16VAoXRQ-1; Tue,
 11 Aug 2026 12:32:36 -0400
X-MC-Unique: QuN8coFtPA6QfK16VAoXRQ-1
X-Mimecast-MFC-AGG-ID: QuN8coFtPA6QfK16VAoXRQ_1786465955
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC20C1800145; Tue, 11 Aug 2026 16:32:35 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8CC98195DF91; Tue, 11 Aug 2026 16:32:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 80/83] hw/misc/aspeed_hace: Support 64-bit DMA for the crypto
 command
Date: Tue, 11 Aug 2026 18:29:35 +0200
Message-ID: <20260811162938.1403216-81-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

The AST2700 crypto engine addresses DRAM with 64 bits, supplying the high
half of the source, destination and context addresses through HACE80,
HACE84 and HACE88. Add those registers and a crypt_get_addr() helper that
combines the low and high halves when the SoC has 64-bit DMA, mirroring
the hash engine. SoCs without 64-bit DMA (AST2500/AST2600/AST1030) ignore
the high registers, so their behaviour is unchanged.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20260811060115.1849266-14-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_hace.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index d84f7f9cec1a..0a6e2fa82914 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -57,6 +57,11 @@
 #define CRYPT_CTX_KEY_OFFSET        0x10
 #define CRYPT_CTX_SIZE              0x30
 
+/* AST2700 64-bit DMA high address registers for the crypto command */
+#define R_CRYPT_SRC_HI      (0x80 / 4)
+#define R_CRYPT_DEST_HI     (0x84 / 4)
+#define R_CRYPT_CONTEXT_HI  (0x88 / 4)
+
 #define R_STATUS        (0x1c / 4)
 #define HASH_IRQ        BIT(9)
 #define CRYPT_IRQ       BIT(12)
@@ -670,6 +675,19 @@ static void crypt_be_add(uint8_t *ctr, size_t len, uint64_t add)
     }
 }
 
+static uint64_t crypt_get_addr(AspeedHACEState *s, int reg, int reg_hi)
+{
+    AspeedHACEClass *ahc = ASPEED_HACE_GET_CLASS(s);
+    uint64_t addr;
+
+    addr = deposit64(0, 0, 32, s->regs[reg]);
+    if (ahc->has_dma64) {
+        addr = deposit64(addr, 32, 32, s->regs[reg_hi]);
+    }
+
+    return addr;
+}
+
 /*
  * Perform an AES/DES/3DES ECB/CBC operation. The source and destination are
  * either single contiguous buffers (direct access mode) or scatter-gather
@@ -717,7 +735,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)
     }
 
     /* Fetch the IV and key from the context buffer in DRAM. */
-    ctx_addr = s->regs[R_CRYPT_CONTEXT];
+    ctx_addr = crypt_get_addr(s, R_CRYPT_CONTEXT, R_CRYPT_CONTEXT_HI);
     if (address_space_read(&s->dram_as, ctx_addr, MEMTXATTRS_UNSPECIFIED,
                            ctx, sizeof(ctx))) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -758,7 +776,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)
     dst_buf = g_malloc0(buf_len);
 
     /* Gather the source into the bounce buffer, per the selected mode. */
-    src_addr = s->regs[R_CRYPT_SRC];
+    src_addr = crypt_get_addr(s, R_CRYPT_SRC, R_CRYPT_SRC_HI);
     if (sg_mode) {
         status = crypt_prepare_sg(s, src_addr, src_buf, len, false);
     } else {
@@ -794,7 +812,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)
     }
 
     /* Scatter the result back out, per the selected mode. */
-    dst_addr = s->regs[R_CRYPT_DEST];
+    dst_addr = crypt_get_addr(s, R_CRYPT_DEST, R_CRYPT_DEST_HI);
     if (sg_mode) {
         status = crypt_prepare_sg(s, dst_addr, dst_buf, len, true);
     } else {
@@ -958,6 +976,15 @@ static void aspeed_hace_write(void *opaque, hwaddr addr, uint64_t data,
     case R_HASH_KEY_BUFF_HI:
         data &= ahc->key_hi_mask;
         break;
+    case R_CRYPT_SRC_HI:
+        data &= ahc->src_hi_mask;
+        break;
+    case R_CRYPT_DEST_HI:
+        data &= ahc->dest_hi_mask;
+        break;
+    case R_CRYPT_CONTEXT_HI:
+        data &= ahc->key_hi_mask;
+        break;
     default:
         break;
     }
-- 
2.55.0


