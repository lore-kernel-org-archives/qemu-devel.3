Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33327E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK2x-00011Y-2p; Fri, 10 Jan 2025 13:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2G-0000Gd-LO
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2D-00018L-12
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+9XJTJSHDsdt0DlshXhAnXl9FWfBL5KYyt2ZALl3vTc=;
 b=SZQvfekT+hUVblLrNc9yts7NDWnadGBl4bytMUWbp72FDJ46IzAUQpJvCsQru4HoLTWFTW
 bXDXyQ6sU/bjw8+uEwzZTJxpEd5tnc852EbHC24Z3n9LFgMbEOE7/AIzwVN61nriN3HB+w
 EkVDglweAH1lTwX1dJNR1dFNOiesWB8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-Xj2uOyKgMLyftcuwS6HTqw-1; Fri, 10 Jan 2025 13:47:03 -0500
X-MC-Unique: Xj2uOyKgMLyftcuwS6HTqw-1
X-Mimecast-MFC-AGG-ID: Xj2uOyKgMLyftcuwS6HTqw
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5d3cff6aedbso2893518a12.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534821; x=1737139621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+9XJTJSHDsdt0DlshXhAnXl9FWfBL5KYyt2ZALl3vTc=;
 b=rpSZqcBCveZl6YF+ZdxdLlMb4SeZ2rX8W8xC2Ccj2x0cZXnYYZ6j5pI2gOhUVXsKiK
 xD8TJvtFhbjx+eKUadrzppYnqIGgGnvIhfTVl3Uo1+98/dKeP6M829JosTgofTEI0PG9
 w8eGGtSUi5+16WKrD5tWUBQzFXinGOr6sI5eeTNEthOza9wc2t+p1kS4EYKXn2N+w1zj
 igI4gq0a6cZL2tQ+JPUNwch+OcqsLI21e83lVG0QLnIDaBRqh0pZnmGG7E1TgOtMmitD
 UIgjAaJOl6eQKVfPDUfjleFu4kA4/BemmvIpxBtVTCShPffQ2Do1RWzsQPOuv5Glk7mB
 ddbw==
X-Gm-Message-State: AOJu0YzSyRUSkdhra49Une2lut4Mh1hNsCJfXZiwWVMXJDvMHDZETq/C
 DtGXqj7rGherwpQdsIIx5MTD0WaT8jnghhPbMVGucxTnQ28Yjj8hVEQMAponJ0HktEgySixmreE
 0R7BPYKoAgqC4sIAd24c0uluO+3NAJadi4K7tHAIDvq6gACoKdkZWcVlA05f3snO+aO+BD7l4i2
 +GEws6NU/0RTazrA1803PLhkS3lLkBkUolhrMLVHs=
X-Gm-Gg: ASbGncslYPY+mrIoETl/AzgTC5xq/19scx4HCwhwoZgTAyVTVNuWXgSvVFlzIzLNeRr
 MtYJ/UqWqeQHYB1Ovp0Gv6X/tAggpsBA4+tZ1pvn2RG6vZM69jOwJR/dDN/ESbSuR5RQH+/66f0
 Kq7Ec4SoOcw/kTFVQQs5EqNqVquwIWiCHTphzDKHDPKhjrd2BV+YnyGYUQssrWaNcGCTlmVtNdd
 6G0750F7yN9HB6yY3kNew8YvR6roCvHyWN1Oqs6zUDtSZHy8qUKBSFPYw4=
X-Received: by 2002:a05:6402:84d:b0:5d3:fcca:cab1 with SMTP id
 4fb4d7f45d1cf-5d986288138mr6146084a12.15.1736534821534; 
 Fri, 10 Jan 2025 10:47:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKPOHbDEGpbpAsy3zpmvKziXAAFWoWus6eaNc2RMe8b04O8pFx2/U5PBE0KMxQAZHk7PZgzw==
X-Received: by 2002:a05:6402:84d:b0:5d3:fcca:cab1 with SMTP id
 4fb4d7f45d1cf-5d986288138mr6146053a12.15.1736534820974; 
 Fri, 10 Jan 2025 10:47:00 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9903c32a0sm1975682a12.44.2025.01.10.10.46.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:46:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/38] target/i386: improve code generation for BT
Date: Fri, 10 Jan 2025 19:45:58 +0100
Message-ID: <20250110184620.408302-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Because BT does not write back to the source operand, it can modify it to
ensure that one of the operands of TSTNE is a constant (after either gen_BT
or the optimizer's constant propagation).  This produces better and more
optimizable TCG ops.  For example, the sequence

  movl $0x60013f, %ebx
  btl %ecx, %ebx

becomes just

  and_i32 tmp1,ecx,$0x1f                   dead: 1 2  pref=0xffff
  shr_i32 tmp0,$0x60013f,tmp1              dead: 1 2  pref=0xffff
  and_i32 tmp16,tmp0,$0x1                  dead: 1  pref=0xbf80

On s390x, it can use four instructions to isolate bit 0 of 0x60013f >> (ecx & 31):

  nilf     %r12, 0x1f
  lgfi     %r11, 0x60013f
  srlk     %r12, %r11, 0(%r12)
  nilf     %r12, 1

Previously, it used five instructions to build 1 << (ecx & 31) and compute
TSTEQ, and also needed two more to construct the result of setcond:

  nilf     %r12, 0x1f
  lghi     %r11, 1
  sllk     %r12, %r11, 0(%r12)
  lgfi     %r9, 0x60013f
  nrk      %r0, %r12, %r9
  lghi     %r12, 0
  locghilh %r12, 1

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 785ff63f2ac..5c115429350 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1443,8 +1443,9 @@ static TCGv gen_bt_mask(DisasContext *s, X86DecodedInsn *decode)
     return mask;
 }
 
-/* Expects truncated bit index in s->T1, 1 << s->T1 in MASK.  */
-static void gen_bt_flags(DisasContext *s, X86DecodedInsn *decode, TCGv src, TCGv mask)
+/* Expects truncated bit index in COUNT, 1 << COUNT in MASK.  */
+static void gen_bt_flags(DisasContext *s, X86DecodedInsn *decode, TCGv src,
+                         TCGv count, TCGv mask)
 {
     TCGv cf;
 
@@ -1467,15 +1468,34 @@ static void gen_bt_flags(DisasContext *s, X86DecodedInsn *decode, TCGv src, TCGv
         decode->cc_src = tcg_temp_new();
         decode->cc_dst = cpu_cc_dst;
         decode->cc_op = CC_OP_SARB + cc_op_size(s->cc_op);
-        tcg_gen_shr_tl(decode->cc_src, src, s->T1);
+        tcg_gen_shr_tl(decode->cc_src, src, count);
     }
 }
 
 static void gen_BT(DisasContext *s, X86DecodedInsn *decode)
 {
-    TCGv mask = gen_bt_mask(s, decode);
+    TCGv count = s->T1;
+    TCGv mask;
 
-    gen_bt_flags(s, decode, s->T0, mask);
+    /*
+     * Try to ensure that the rhs of the TSTNE condition is a constant (and a
+     * power of two), as that is more readily available on most TCG backends.
+     *
+     * For immediate bit number gen_bt_mask()'s output is already a constant;
+     * for register bit number, shift the source right and check bit 0.
+     */
+    if (decode->e.op2 == X86_TYPE_I) {
+        mask = gen_bt_mask(s, decode);
+    } else {
+        MemOp ot = decode->op[1].ot;
+
+        tcg_gen_andi_tl(s->T1, s->T1, (8 << ot) - 1);
+        tcg_gen_shr_tl(s->T0, s->T0, s->T1);
+
+        count = tcg_constant_tl(0);
+        mask = tcg_constant_tl(1);
+    }
+    gen_bt_flags(s, decode, s->T0, count, mask);
 }
 
 static void gen_BTC(DisasContext *s, X86DecodedInsn *decode)
@@ -1491,7 +1511,7 @@ static void gen_BTC(DisasContext *s, X86DecodedInsn *decode)
         tcg_gen_xor_tl(s->T0, s->T0, mask);
     }
 
-    gen_bt_flags(s, decode, old, mask);
+    gen_bt_flags(s, decode, old, s->T1, mask);
 }
 
 static void gen_BTR(DisasContext *s, X86DecodedInsn *decode)
@@ -1509,7 +1529,7 @@ static void gen_BTR(DisasContext *s, X86DecodedInsn *decode)
         tcg_gen_andc_tl(s->T0, s->T0, mask);
     }
 
-    gen_bt_flags(s, decode, old, mask);
+    gen_bt_flags(s, decode, old, s->T1, mask);
 }
 
 static void gen_BTS(DisasContext *s, X86DecodedInsn *decode)
@@ -1525,7 +1545,7 @@ static void gen_BTS(DisasContext *s, X86DecodedInsn *decode)
         tcg_gen_or_tl(s->T0, s->T0, mask);
     }
 
-    gen_bt_flags(s, decode, old, mask);
+    gen_bt_flags(s, decode, old, s->T1, mask);
 }
 
 static void gen_BZHI(DisasContext *s, X86DecodedInsn *decode)
-- 
2.47.1


