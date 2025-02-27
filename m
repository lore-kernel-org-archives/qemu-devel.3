Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1039C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnewY-0001j1-Ox; Thu, 27 Feb 2025 09:32:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <f61fab31.AVMAAGOvbr8AAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHdv@a3031119.bnc3.mailjet.com>)
 id 1tnew7-0001E3-2U
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:32:30 -0500
Received: from o47.p38.mailjet.com ([185.250.237.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <f61fab31.AVMAAGOvbr8AAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHdv@a3031119.bnc3.mailjet.com>)
 id 1tnew2-0006KT-Tk
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:32:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; q=dns/txt;
 d=randomman.co.uk; i=roy.hopkins@randomman.co.uk; s=mailjet; x=1740673935;
 h=message-id:mime-version:from:from:to:to:subject:subject:date:date:list-unsubscribe:list-unsubscribe-post:
 cc:feedback-id:in-reply-to:references:x-csa-complaints:x-mj-mid:x-mj-smtpguid:
 x-report-abuse-to:content-transfer-encoding;
 bh=N34gnjt0KmJO9ZHcaGfyS1ufcGwyQfSRWZhpavih2ss=;
 b=G0PyAVpFqhFqqTXNVGUNhkibtTh9zXcm5OY1cXvGTDyH+p0VwcxzaH+Z5
 3zUCBLuXhOsrS6JuUtTzfkRWiSWNK48eWNro5JSPJe7jBTKp4cy5REXASGH6
 rats+jopAISxj5JnYPkQMMnUVoNabe50aGuG42NWpNy5FmnpmCQ4sFu3cFyA
 kjUspA8it2/jAhuXx/V5h9vA1FEgXDK2Fq5X6kyNfkoH3oH4hgOXx9H+sIj1
 YGa57BaDo9v/ldm5dn2afPCw6TZ/fVpk5sZuQVZhUtpdSayAvELs3nAW5IrB
 lC7C4xDOlwEyvppKbvvT3Qwa6TW7dRFX65EdbQlBQzVmA==
Message-Id: <f61fab31.AVMAAGOvbr8AAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHdv@mailjet.com>
MIME-Version: 1.0
From: Roy Hopkins <roy.hopkins@randomman.co.uk>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 07/16] target/i386: Allow setting of R_LDTR and R_TR with
 cpu_x86_load_seg_cache()
Date: Thu, 27 Feb 2025 14:29:25 +0000
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>, Paolo Bonzini
 <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alistair Francis
 <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>, Joerg Roedel <jroedel@suse.com>
Feedback-Id: 42.3031119.2785883:MJ
In-Reply-To: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
References: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
X-CSA-Complaints: csa-complaints@eco.de
X-MJ-Mid: AVMAAGOvbr8AAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHdvu8JwhCDSQ8K5qOiPmiS8WgAqgls
X-MJ-SMTPGUID: 4f7fcd89-1b36-4b89-9f61-f30a6134c79b
X-REPORT-ABUSE-TO: Message sent by Mailjet please report to
 abuse@mailjet.com with a copy of the message
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.250.237.47;
 envelope-from=f61fab31.AVMAAGOvbr8AAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHdv@a3031119.bnc3.mailjet.com;
 helo=o47.p38.mailjet.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The x86 segment registers are identified by the X86Seg enumeration which
includes LDTR and TR as well as the normal segment registers. The
function 'cpu_x86_load_seg_cache()' uses the enum to determine which
segment to set. However, specifying R_LDTR or R_TR results in an
out-of-bounds access of the segment array.

Possibly by coincidence, the function does correctly set LDTR or TR in
this case as the structures for these registers immediately follow the
array which is accessed out of bounds.

This patch adds correct handling for R_LDTR and R_TR in the function.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 target/i386/cpu.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c67b42d34f..f49f0d9711 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2359,7 +2359,14 @@ static inline void cpu_x86_load_seg_cache(CPUX86State *env,
     SegmentCache *sc;
     unsigned int new_hflags;
 
-    sc = &env->segs[seg_reg];
+    if (seg_reg == R_LDTR) {
+        sc = &env->ldt;
+    } else if (seg_reg == R_TR) {
+        sc = &env->tr;
+    } else {
+        sc = &env->segs[seg_reg];
+    }
+
     sc->selector = selector;
     sc->base = base;
     sc->limit = limit;
-- 
2.43.0


