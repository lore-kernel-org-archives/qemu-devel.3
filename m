Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E5DCCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 11:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFsHo-0004Sd-Ro; Mon, 03 Nov 2025 05:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFsHV-000478-KU
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:59:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFsHR-0004cd-2R
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762167559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cbh68C6fmQ5R1KcYwKeBdnUQDfSG4HCjvnxl+QuCZ4I=;
 b=SCwZEldhre3MQ+78PLwAZlQsI8HTz+wSeH3Suwb51abst9+TH1C9+rZw6/6L4PeHGG1ipv
 HjtHXl2pB77L+TelorX72IgEQpghAhywv4lKCVk64P+9s2/qIAbUjV53nwrSoycGa4tovM
 RDKXicuCY26tFYewnwbuJjTUcYZ7zZ4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-YvLVsSD2NAujAWMC1IL9_w-1; Mon,
 03 Nov 2025 05:59:16 -0500
X-MC-Unique: YvLVsSD2NAujAWMC1IL9_w-1
X-Mimecast-MFC-AGG-ID: YvLVsSD2NAujAWMC1IL9_w_1762167554
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7CCE180120B; Mon,  3 Nov 2025 10:59:14 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4746730001A1; Mon,  3 Nov 2025 10:59:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Heiko Carstens <hca@linux.ibm.com>, qemu-stable@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 21/22] target/s390x: Use address generation for register branch
 targets
Date: Mon,  3 Nov 2025 11:58:18 +0100
Message-ID: <20251103105824.322039-22-thuth@redhat.com>
In-Reply-To: <20251103105824.322039-1-thuth@redhat.com>
References: <20251103105824.322039-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Indirect branches to addresses taken from registers go through address
generation, e.g., for BRANCH ON CONDITION Principles of Operation says:

    In the RR format, the contents of general register R2 are used to
    generate the branch address

QEMU uses r2_nz handler for the respective register operands. Currently
it does not zero out extra bits in 24- and 31-bit addressing modes as
required by address generation. The very frequently used
s390x_tr_init_disas_context() function has a workaround for this,
but the code for saving an old PSW during an interrupt does not.

Add the missing masking to r2_nz. Enforce PSW validity by replacing the
workaround with an assertion.

Reported-by: Thomas Weißschuh <linux@weissschuh.net>
Reported-by: Heiko Carstens <hca@linux.ibm.com>
Link: https://lore.kernel.org/lkml/ab3131a2-c42a-47ff-bf03-e9f68ac053c0@t-8ch.de/
Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Thomas Weißschuh <linux@weissschuh.net>
Message-ID: <20251016175954.41153-4-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/tcg/translate.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index ec9e5a07516..4d2b8c5e2be 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -5613,6 +5613,7 @@ static void in2_r2_nz(DisasContext *s, DisasOps *o)
     int r2 = get_field(s, r2);
     if (r2 != 0) {
         o->in2 = load_reg(r2);
+        gen_addi_and_wrap_i64(s, o->in2, o->in2, 0);
     }
 }
 #define SPEC_in2_r2_nz 0
@@ -6379,10 +6380,12 @@ static void s390x_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-    /* 31-bit mode */
-    if (!(dc->base.tb->flags & FLAG_MASK_64)) {
-        dc->base.pc_first &= 0x7fffffff;
-        dc->base.pc_next = dc->base.pc_first;
+    if (dc->base.tb->flags & FLAG_MASK_32) {
+        if (!(dc->base.tb->flags & FLAG_MASK_64)) {
+            assert(!(dc->base.pc_first & ~((1ULL << 31) - 1)));
+        }
+    } else {
+        assert(!(dc->base.pc_first & ~((1ULL << 24) - 1)));
     }
 
     dc->cc_op = CC_OP_DYNAMIC;
-- 
2.51.0


