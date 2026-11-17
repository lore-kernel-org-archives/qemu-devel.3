Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F4C606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bjitvu9b
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJO4-0006iM-GM; Tue, 17 Nov 2026 08:38:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTJO1-0006dd-Q3
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:38:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTJO0-0003B9-7i
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:38:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794922691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/hNje6YUHdnu3aRo8fA0Fhrbju+nZwVH0sRanEkzr14=;
 b=bjitvu9b/ZP/VPkoRNcxw5J7A1hTWlQ0Frh5WOuwy0e4bKztlB0eIAX8VH2GvYZn403LeG
 BJ8HnHkqd1BgKUxjRGgqVKSyea7XDHB/DETI/gZ3FJjYtQ6dQzKxlYsoBeSnccNUMe4l53
 3UUqKNgneIU7z/CXkmf99xp7VZHWgJs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-gmed5SfyN0u7n52lrbg07w-1; Tue,
 17 Nov 2026 08:38:10 -0500
X-MC-Unique: gmed5SfyN0u7n52lrbg07w-1
X-Mimecast-MFC-AGG-ID: gmed5SfyN0u7n52lrbg07w_1794922689
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DFBD1954B2C
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 13:38:09 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8FF30428
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 13:38:08 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/15] target/i386/tcg: remove unused operand sizes
Date: Tue, 17 Nov 2026 14:37:48 +0100
Message-ID: <20261117133750.322253-14-pbonzini@redhat.com>
In-Reply-To: <20261117133750.322253-1-pbonzini@redhat.com>
References: <20261117133750.322253-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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
 target/i386/tcg/decode-new.h     |  4 ----
 target/i386/tcg/decode-new.c.inc | 10 ++++------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 7f7ed3b6cf4..72ab6473e4a 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -73,15 +73,11 @@ typedef enum X86OpSize {
     X86_SIZE_d,  /* 32-bit */
     X86_SIZE_dq, /* SSE/AVX 128-bit */
     X86_SIZE_p,  /* Far pointer */
-    X86_SIZE_pd, /* SSE/AVX packed double precision */
-    X86_SIZE_pi, /* MMX */
-    X86_SIZE_ps, /* SSE/AVX packed single precision */
     X86_SIZE_q,  /* 64-bit */
     X86_SIZE_qq, /* AVX 256-bit */
     X86_SIZE_s,  /* Descriptor */
     X86_SIZE_sd, /* SSE/AVX scalar double precision */
     X86_SIZE_ss, /* SSE/AVX scalar single precision */
-    X86_SIZE_si, /* 32-bit GPR */
     X86_SIZE_v,  /* 16/32/64-bit, based on operand size */
     X86_SIZE_w,  /* 16-bit */
     X86_SIZE_x,  /* 128/256-bit, based on operand size */
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 731434ff50b..19c76a12009 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -73,8 +73,8 @@
  * the V/U/H/W types to P/N/P/Q if there is no prefix, as well as changing
  * "x" to "q" if there is no prefix.
  *
- * In addition, the ss/ps/sd/pd types are sometimes mushed together as "x"
- * if the difference is expressed via prefixes.  Individual instructions
+ * In addition, the ss/sd types are sometimes mushed together as "x"
+ * if the difference is expressed via prefixes; individual instructions
  * are separated by prefix in the generator functions.
  *
  * There is a custom size "xh" used to address half of a SSE/AVX operand.
@@ -82,6 +82,8 @@
  * for 256-bit AVX operands, etc.  It is used for conversion operations
  * such as VCVTPH2PS or VCVTSS2SD.
  *
+ * pi/ps/pd are simply written as "q" or "x".
+ *
  * There are a couple cases in which instructions (e.g. MOVD) write the
  * whole XMM or MM register but are established incorrectly in the manual
  * as "d" or "q".  These have to be fixed for the decoder to work correctly.
@@ -2448,7 +2450,6 @@ static bool decode_op_size(DisasContext *s, X86OpEntry *e, X86OpSize size, MemOp
         *ot = s->dflag;
         return true;
 
-    case X86_SIZE_pi: /* MMX */
     case X86_SIZE_q:  /* 64-bit */
     case X86_SIZE_sd: /* SSE/AVX scalar double precision */
         *ot = MO_64;
@@ -2497,9 +2498,6 @@ static bool decode_op_size(DisasContext *s, X86OpEntry *e, X86OpSize size, MemOp
             *ot = MO_64;
             return true;
         }
-        /* fall through */
-    case X86_SIZE_ps: /* SSE/AVX packed single precision */
-    case X86_SIZE_pd: /* SSE/AVX packed double precision */
         *ot = s->vex_l ? MO_256 : MO_128;
         return true;
 
-- 
2.56.0



