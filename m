Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FF3606A329
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I/vTLFjv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJNv-0006bo-RE; Tue, 17 Nov 2026 08:38:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTJNt-0006aa-5E
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:38:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTJNr-00037b-JG
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794922682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jdxw55erMUxd1wmjliFartPOyoUNynfcFZXGkpu034Y=;
 b=I/vTLFjvg1SEPUt8r4eVgNd0NE12prPu+U8rZC5R9rgoCX3usWznmrKToQ5Y3wcuI0dBKa
 sqowhGetJYsCojHP/o9gQ8ILz5t6y3Zo40HSPrL1qBg9B1penXoJLQeSSc8YrMBV0IGgft
 MH0Jr05j5ohTThusXd84RQV1yjrR1uo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-CzyEMZSlMsWmWVG5d5ICmw-1; Tue,
 17 Nov 2026 08:38:01 -0500
X-MC-Unique: CzyEMZSlMsWmWVG5d5ICmw-1
X-Mimecast-MFC-AGG-ID: CzyEMZSlMsWmWVG5d5ICmw_1794922680
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D4EA1800540; Tue, 17 Nov 2026 13:38:00 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 51B49588; Tue, 17 Nov 2026 13:37:59 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/15] target/i386/tcg: fix lea address calculation for CS
 register
Date: Tue, 17 Nov 2026 14:37:41 +0100
Message-ID: <20261117133750.322253-7-pbonzini@redhat.com>
In-Reply-To: <20261117133750.322253-1-pbonzini@redhat.com>
References: <20261117133750.322253-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

When the effective address calculation was simplified in commit 55a15eb3504
("target/i386/tcg: simplify effective address calculation") the refactoring
accidentally introduced the ADDSEG() macro into the CS base address inclusion
test.

Fix the logic in gen_lea_v_seg_dest() to use CODE64() instead of ADDSEG() for
the CS base address inclusion test, and at the same time split it into a switch
statement to make the logic easier to follow.

Fixes: 55a15eb3504 ("target/i386/tcg: simplify effective address calculation")
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20260927123807.492352-1-mark.cave-ayland@ilande.co.uk
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index b715921c379..d4ccddc33fd 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -625,7 +625,25 @@ static void gen_lea_v_seg_dest(DisasContext *s, MemOp aflag, TCGv dest, TCGv a0,
         ovr_seg = def_seg;
     }
 
-    has_base = ovr_seg >= R_FS || (ovr_seg >= 0 && ADDSEG(s));
+    switch (ovr_seg) {
+    case R_DS:
+    case R_ES:
+    case R_SS:
+        has_base = ADDSEG(s);
+        break;
+    case R_CS:
+        has_base = !CODE64(s);
+        break;
+    case R_FS:
+    case R_GS:
+        has_base = true;
+        break;
+    default:
+        assert(ovr_seg < 0);
+        has_base = false;
+        break;
+    }
+
     easize = CODE64(s) ? MO_64 : MO_32;
 
     if (has_base) {
-- 
2.56.0



