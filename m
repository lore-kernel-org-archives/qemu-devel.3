Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D34B606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PjP2e81A
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJNw-0006cB-Vy; Tue, 17 Nov 2026 08:38:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTJNw-0006bp-1O
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:38:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTJNu-00039W-CG
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:38:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794922685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+2gaaMxgG4mjw0pyjAnd/TnUbLRUfQoPFqZhgO2YvNY=;
 b=PjP2e81A+Z5zvCnvQCsnpta7dzDnl6sGmkNlxbrz8vsJONgggAbY9clh2ssL6YDrRoPGkx
 ZNiQdCvw8LoMnrppOS6YFP0Lk/97yWn5/1MfIxFGQJbMG5UFSCWv95+ah29kbyku3pAXsN
 TjzTBXEP6HxEfkoYZSMQrbO1A6NvNo4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-hVZrsnwePRuKILhXfH7jfQ-1; Tue,
 17 Nov 2026 08:38:04 -0500
X-MC-Unique: hVZrsnwePRuKILhXfH7jfQ-1
X-Mimecast-MFC-AGG-ID: hVZrsnwePRuKILhXfH7jfQ_1794922683
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3577E1956062; Tue, 17 Nov 2026 13:38:03 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 53DB841F; Tue, 17 Nov 2026 13:38:01 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: NickSampanis <nicksampanis@gmail.com>
Subject: [PULL 08/15] target/i386/tcg: Fix 64-bit RSP truncation on retf in
 64-bit mode
Date: Tue, 17 Nov 2026 14:37:43 +0100
Message-ID: <20261117133750.322253-9-pbonzini@redhat.com>
In-Reply-To: <20261117133750.322253-1-pbonzini@redhat.com>
References: <20261117133750.322253-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: NickSampanis <nicksampanis@gmail.com>

When executing retf in 64-bit mode with a 16- or 32-bit operand size,
`helper_ret_protected()` is invoked with a shift of 0 or 1. However,
in 64-bit mode, operand size should only govern the number of bytes
that are popped, not how wide the stack pointer is because in 64-bit
mode the SS attributes are ignored.

By falling back to `get_sp_mask(SS.flags)`, QEMU applied a 16-bit mask
(`0xffff`) with `SS.B` clear, and a 32-bit mask (`0xffffffff`) with
`SS.B` set.  As a result, a 64-bit RSP pointing above 4 GiB was
truncated. As observed in testing, the truncated stack pop read the wrong
address, loading corrupted values for the new CS and RIP which resulted
in a `#GP` fault and then a triple fault.

Fix this by ensuring that `helper_ret_protected()` uses the full 64-bit
stack pointer with no mask applied whenever the active code segment (CS)
is running in 64-bit mode.

Signed-off-by: NickSampanis <nicksampanis@gmail.com>
Link: https://lore.kernel.org/r/20261025231803.870-2-nicksampanis@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 45bffcd7380..af18aec694d 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -2056,7 +2056,7 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
     sa.mmu_index = x86_mmu_index_pl(env, cpl);
 
 #ifdef TARGET_X86_64
-    if (shift == 2) {
+    if (shift == 2 || (env->hflags & HF_CS64_MASK)) {
         sa.sp_mask = -1;
     } else
 #endif
-- 
2.56.0



