Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB9BCA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCZMr-0002AN-OV; Fri, 02 Oct 2026 05:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xCZMZ-00029U-7o
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:15:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xCZMX-0005Na-DP
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790932528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/oLbbqPQ31+fEOfogTgAJ+4e1RO661jqklWi1qFKGeo=;
 b=T37vGDgDGNEhiz1/eg5f0l9Ao3J5i4wjM4Mlgw6/Jucv9ZqmVY7suVUnp+y/CfVAwb8NXv
 Hq/TCC2ja5zggUmPd+7caIMIHN5hWZ0QJUUAN2BCX3qU5r+4PoY97wrwSip1HWOWYm6SB+
 /zx2TXNx2A7aFFscY/0oL2aXZqzoN6Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-G_Kp7BGqN3eUGdEIi3xdgA-1; Fri, 02 Oct 2026 05:15:26 -0400
X-MC-Unique: G_Kp7BGqN3eUGdEIi3xdgA-1
X-Mimecast-MFC-AGG-ID: G_Kp7BGqN3eUGdEIi3xdgA_1790932526
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49cdc4080ddso28090585e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 02:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790932526; x=1791537326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/oLbbqPQ31+fEOfogTgAJ+4e1RO661jqklWi1qFKGeo=;
 b=oG9CO8kEsF6SUm9UXDh9hR9sq8ZedQ0NfO7abUJyeRuc1NU+EqdsT8X5TC7ZqAt6jB
 wY290UexBz9PlTxO9ULYbGfGfqL4zaiNQd3xHL9PyQQKMfBtv0XWeFMBI3h8TL6CTyS2
 9fPlU76quBPJSQ6g+Qc3PnE795WWVNo4gmvir2K0cmm3gZQ4eyazkcEvYTSXoALKb7Dr
 Jze/i6t4kK2mOLW4sh5FwEmgJYBHEQY2vX8weTgb73E54DDO2ggiIcm4f4zdEOUEQaQv
 c1zpuz7IshJVfiq8krOFQuvNaVC/waw3B7ATh8XqUbxZqGCWiNy4jgU3j4SPgrjJ4PcF
 jEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790932526; x=1791537326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/oLbbqPQ31+fEOfogTgAJ+4e1RO661jqklWi1qFKGeo=;
 b=2oWOcQqF7T5c55SsKYRnXkHkpLP3XbILpWM9OyoiGzPUF0SRh+TI7H75YNEOWl00kK
 wK721QiL655i+G0HW2PE1o1dMjPC4hdCcR/givZqcTBLcw9Ix5dCiPt+xcied4Ml2N89
 7GGxnSXZyeEPkfUNVpdBaOlBwzpycfo3neFrMLckDtM1Clx1Z9ZG1Ll6Hy8bWcuDrL60
 CgBqYNZZ2A5vsEEi8yDmDvSHfE9nGKpt7zfy2d69dIF5FUFh5G6EsCm+lvDqFdD2Rlii
 d1XyIqwGrLSGBZlW80NFm6JuQyLVKy0ApmV8oh+m1DaMC3vG4ViCNjMqNnyWHEqflRjD
 LOxw==
X-Gm-Message-State: AFuF++kZvF5a5Lyv2tyjLZVek1XGWau8P8ifAaCkdg34qBzEqvci0+XG
 s0vLkXmoy8srq8lB8xUFpWSYRfqVg2liJIEekkgtIeChiDXhzDxofTk0sgaMAN9sBxVMsijLFNX
 yjDZop9TcBjqCVz71LLkKkFmso843FsMhY/ejJtSZgzkLP/tSJFTf5S65u5VnW+8XaRf3Tpud2V
 UoOIq17W1/0HYrjPjJgXFLB2b/600tIuIbfwsGR0YU
X-Gm-Gg: AYBFou0OP5CBVwy3IS5AQEbSS+vf8iXU/81pvSV7PyNfQIzvGrQ2LMISb+uH5xDrejl
 CdLWRTe6f4Yt/YcvX+2HjSpo92o2dxh80J39pzNjHdY9uoh8SKeRs6GeuM/JKiqwX1FpDFCX5XP
 uT4fjEqEwVjoZRGSlhXGFynHIuq2rLK+O/pNn3h5gh0SeiGjWcjFePGdeqRS1I+AYKaZQH879Q1
 I+1is6AbUdj7ZexR11o+6mHJvCUdl21mss7/LDgDo3LdFCF0GBo4MxiKOb1wo5Ck2mOZjgU1uWJ
 HoxKxFNC1TODkdWuYZXiT1gdnrHOtvofT/1B5UnV/kL/FEEnL6AEBAmKLWPkkwQs2AQjY+JdhSU
 9YomSzNdRIYj9JZQucXzNIn3e4m3zJwG/sYlI2mtDu5FlpIfwW+yaY9KSX60cbbH1fsUnwZfeC8
 cLIeTF
X-Received: by 2002:a05:600c:4e93:b0:4a0:1ef1:b62b with SMTP id
 5b1f17b1804b1-4a02754f71emr40204515e9.10.1790932525605; 
 Fri, 02 Oct 2026 02:15:25 -0700 (PDT)
X-Received: by 2002:a05:600c:4e93:b0:4a0:1ef1:b62b with SMTP id
 5b1f17b1804b1-4a02754f71emr40203795e9.10.1790932525003; 
 Fri, 02 Oct 2026 02:15:25 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0394e6c5asm45777255e9.2.2026.10.02.02.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 02:15:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 07/32] target/i386/tcg: move validate_vex() before all operand
 decoding
Date: Fri,  2 Oct 2026 11:15:17 +0200
Message-ID: <20261002091518.1139575-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002091518.1139575-1-pbonzini@redhat.com>
References: <20261002091518.1139575-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
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

Operand sizes are computed in decode_insn(), because s->rip_offset has to
be known before decode_modrm() computes a RIP-relative address.  However,
validate_vex() runs later and, for X86_VEX_REPScalar instructions, it must
be able to turn e->s2 into X86_SIZE_ss or X86_SIZE_sd in presence of a
memory operand.  But right now decode_op_size() has already run, and
therefore decode->op[2].ot stays MO_128; the instruction therefore
accesses 16 bytes of memory instead of 4 or 8.

The only user of s->rip_offset is decode_modrm(), which is called from
decode_ops(), so the size computation can move there, after validate_vex().
Thanks to the previous patch, the CR0.TS and CR0.EM checks come after
decode_ops(), so #UD for an invalid VEX.L still has priority over #NM.

This way, when validate_vex() adjusts the X86OpEntry, decode_op_size()
picks up the result.  This behaves as intended by commit b7d4ec4832d
("target/i386/tcg: move VEX validation early", 2026-08-26), and fixes
REPScalar instructions that have a memory operand.

This also applies to unary operations, which need to ignore VEX.L.
While this could also be fixed by using "dq" for the operand size, it
is untidy that simply setting "s->vex_l = 0" does not do the right thing.

Fixes: b7d4ec4832d ("target/i386/tcg: move VEX validation early", 2026-08-26)
Reported-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 996e12d03d2..5212a24e470 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2478,9 +2478,13 @@ static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_
         e->decode(s, env, e, &decode->b);
     }
 
-    if (!validate_sse_prefix(s, e)) {
-        return false;
-    }
+    return validate_sse_prefix(s, e);
+}
+
+static bool decode_ops(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_func,
+                       X86DecodedInsn *decode)
+{
+    X86OpEntry *e = &decode->e;
 
     /* Compute size of operands here in order to initialize s->rip_offset.  */
     if (e->op0 != X86_TYPE_None) {
@@ -2515,13 +2519,6 @@ static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_
         assert(e->op3 == X86_TYPE_I && e->s3 == X86_SIZE_b);
         s->rip_offset += 1;
     }
-    return true;
-}
-
-static bool decode_ops(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_func,
-                       X86DecodedInsn *decode)
-{
-    X86OpEntry *e = &decode->e;
 
     if (e->op0 != X86_TYPE_None &&
         !decode_op(s, env, decode, &decode->op[0], e->op0, decode->b)) {
-- 
2.55.0


