Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F0EC9830E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 06:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBoCz-0006R6-NV; Wed, 30 Sep 2026 02:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBoCo-0006Po-VD
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 02:54:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBoCn-0005Jc-8F
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 02:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790751255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fLQU/wYzTWGa06Y9CCXo7IARxyo5SpTv4HEyzUiRnQE=;
 b=JsDkHXjY1vXoRTQzTDSGGxCmkH84rTz08zMAs04/eb/JocP1oR9jXf5bnloL+OmFTZSJLU
 HZg9YhZt0PedNWIRo5o1HIbvGwh6AcsnO4mrgljDBALkyTCnQVTDcjQlF4+lMNElkUWWO6
 JbSj+Q9amJsJt2lgGgWWMyLdTvyYnKM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-ORlR3aTFMjqQct4XkYtSIg-1; Wed, 30 Sep 2026 02:54:13 -0400
X-MC-Unique: ORlR3aTFMjqQct4XkYtSIg-1
X-Mimecast-MFC-AGG-ID: ORlR3aTFMjqQct4XkYtSIg_1790751252
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48b00febba3so198846f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 23:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790751252; x=1791356052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fLQU/wYzTWGa06Y9CCXo7IARxyo5SpTv4HEyzUiRnQE=;
 b=WKRur+7KLyfoRlx7DKTl9EoRIfd9PXdlLTwT0JHtnMCYLm89I5qxHafpzB/Iu/oPmO
 bDEz9Olw4GX5rHVoy0Qjioz0Ix7jRpD/qZB0x0iqiPPPycHdG2/oCkTJ3zpR6KxQ/6jS
 LzIVDWjwgD4MrNLuSSSrhruFNofRyZBACKPU7yKA0s8eY6lH/StU6SuCcoIEbZbMpsBk
 n3NQoHl8rDuuAa6dSyEAMayEcvafCQe9GL5Sd4OTm9pQ4NMBSOWK3KUg7o7pXmg7JJMM
 l059hMTQsm2mguRkz7x9R7Q1iG1JJoGmUhCCj3c2oQZS8/8jC+qZ/TIS2TBIdd8RcTZd
 n3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790751252; x=1791356052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fLQU/wYzTWGa06Y9CCXo7IARxyo5SpTv4HEyzUiRnQE=;
 b=OuHuAvu7oloXZ6iDb53VT92hl7IKOO5dIu1WlPEMA7GoznZvRc4ZZAzsgWB4ybfZRe
 eejOUdN59g/0mbn+NY4cj9rkO64V16Fw/m5LE4x+ZXhigMFxCspeuhH+OppxuwfuUg3p
 nOw56uy24FVQwFWwDmt/V7nBoVj9417GPSFrqFZejsBffnmaxh4tXUxWi19XLYRinkxr
 WfTqh/iqaQWmBHeBXZWixtmmemToUR7u/joD38hfSwYNFJi7tYexM/L37X1Rt1rx/iEw
 XH7v/+a70oEBtzNKsiV7W23Ek/Ghaoe5Tmp8S2GWS1ABG5nC3vgM3Ezl40PGTA35TGvL
 y81w==
X-Gm-Message-State: AFq9FYIOudXa8bthXuNBmvciIdx39kqC97fOFqDk4DKaBAzKDFdCTHg+
 hiYfYXt1aLrTPhie0Sx6HCVZWpH9uJFaYg3h2tkdWD2kCmUrG9agXURCNkW5hdDLdRlUP0x7G1t
 IXR3BzAKdBEaYJWTueH2FMJe/hXinf3a1K/LjYxji9FrHN+ZBeAxy0pNq0YaWGVkzCZ8Pb7lHJ7
 6r2+vBQ+yl8gvRsYvca+ps9bmndnw7We6TuxsOCx5Y
X-Gm-Gg: AYBFou3EeLfRC8IE20A3p1BoSn3ei3Uyh+DkZUxKYz+QZujj/ByvrPn9U59znIttIlE
 IbrX3L1uCoDyhEtlCI1SD/y+lzqHyc+vwQZAfdMTtKZStGZzUIB1pCZbKp9cSYmB4e5B6YGyYxa
 HFnCW2zXmsZs+0kvunv8GjwbiWhQ1QmYhA0HD1R/OcWRNYy8haMjXI9bII2pfrxRGIHIsh5Glof
 z5u2NtcUqf1V+5BlxVY8zwD255zhbXNnpHXvs2PwN5QouL97ltVb8m1+oqD/YuGmmkCsbt3ZCAp
 bcXiGrSrMW/Xh5WGBjJtY5yFAqF9x4cF7fVyan/I2ht55QqEePwYuQ7AREHoxI4C3rMsyDqi6zS
 KGh6N/sB5s/sE9bOoWyc8MoMBLROvlreQ9XqyC9KvQDRSk3UZ4TkM27CryJbCCv7vwBf3Yie5+h
 bwaOGn
X-Received: by 2002:adf:e187:0:b0:487:22c6:a623 with SMTP id
 ffacd0b85a97d-48b0243d9b0mr952079f8f.8.1790751252422; 
 Tue, 29 Sep 2026 23:54:12 -0700 (PDT)
X-Received: by 2002:adf:e187:0:b0:487:22c6:a623 with SMTP id
 ffacd0b85a97d-48b0243d9b0mr952043f8f.8.1790751252028; 
 Tue, 29 Sep 2026 23:54:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029fc420sm1084646f8f.28.2026.09.29.23.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 23:54:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Andrey Polivoda <apolivodaa433@gmail.com>
Subject: [PATCH 2/3] target/i386/tcg: move validate_vex() before all operand
 decoding
Date: Wed, 30 Sep 2026 08:54:05 +0200
Message-ID: <20260930065406.738374-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930065406.738374-1-pbonzini@redhat.com>
References: <20260930065406.738374-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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


