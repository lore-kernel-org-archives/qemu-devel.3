Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E882606A326
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GE00wWRT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNSLG-0006lP-8e; Sun, 01 Nov 2026 04:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xNSLB-0006jm-NX
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:59:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xNSLA-0007u9-7T
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793527143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xCUs/R5bet8njpUuEqDFyirdEGdUr7g+KQVWtZfkcLQ=;
 b=GE00wWRT9fxquBH4asUiL6YhIjhO57XUDzPY5bT9NJ1i37L4i9r9PAuuUw3XK+s4SbS9nL
 U86PtSF/CjnjSQPp6q5WgFuE1LPxK3u5MwisAlnHetjFMDJDB+UKH24g3ewSWgPjyoksf3
 j7Gjd5udwtljOZmz+hTPVux+f+21drU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-290-0h4kLKuOOXKR3VyShgxXvA-1; Sun,
 01 Nov 2026 04:59:02 -0500
X-MC-Unique: 0h4kLKuOOXKR3VyShgxXvA-1
X-Mimecast-MFC-AGG-ID: 0h4kLKuOOXKR3VyShgxXvA_1793527141
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69A8F1955F1A
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 09:59:01 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B7DED1800446
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 09:59:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/10] target/i386/tcg: remove F operand type
Date: Sun,  1 Nov 2026 10:58:47 +0100
Message-ID: <20261101095851.1557351-7-pbonzini@redhat.com>
In-Reply-To: <20261101095851.1557351-1-pbonzini@redhat.com>
References: <20261101095851.1557351-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     | 1 -
 target/i386/tcg/decode-new.c.inc | 1 -
 2 files changed, 2 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 2218a4eda3a..b40c75fa222 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -26,7 +26,6 @@ typedef enum X86OpType {
     X86_TYPE_C, /* REG in the modrm byte selects a control register */
     X86_TYPE_D, /* REG in the modrm byte selects a debug register */
     X86_TYPE_E, /* ALU modrm operand */
-    X86_TYPE_F, /* EFLAGS/RFLAGS */
     X86_TYPE_G, /* REG in the modrm byte selects a GPR */
     X86_TYPE_H, /* For AVX, VEX.vvvv selects an XMM/YMM register */
     X86_TYPE_I, /* Immediate */
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 7e5ece380af..aa22014786f 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2551,7 +2551,6 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
 {
     switch (type) {
     case X86_TYPE_None:  /* Implicit or absent */
-    case X86_TYPE_F:  /* EFLAGS/RFLAGS */
         break;
 
     case X86_TYPE_B:  /* VEX.vvvv selects a GPR, else use modrm */
-- 
2.56.0



