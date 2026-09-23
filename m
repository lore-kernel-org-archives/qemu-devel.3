Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B18C98311
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Qq6-0000L6-5P; Wed, 23 Sep 2026 13:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Qo3-0006nW-6F
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:31:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Qo1-0003kL-FA
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790184652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OcOOAk0eswPaNGGDKfx6f/1GOBrGMNRRiT7vRvwEJ6k=;
 b=EK9tadFt/ozsXIY9erk3tXA4gnsxCycUQ0ChWJCvh3nhuOiXdz57XPdK6xrkpKFYygwTF8
 nxJKxsLrp8WDXrHo0iq3ylC6eim50ePUpOrD1cJllvkKqZBmHLPd483e0dRDzIEwq/8q/M
 yn2owIUNX2kd0cfBXQ888vZR/9xzzHI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-GQEscC-XMUOQCiq1eq04dg-1; Wed, 23 Sep 2026 13:30:51 -0400
X-MC-Unique: GQEscC-XMUOQCiq1eq04dg-1
X-Mimecast-MFC-AGG-ID: GQEscC-XMUOQCiq1eq04dg_1790184650
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4870a0fe60fso852105f8f.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790184649; x=1790789449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OcOOAk0eswPaNGGDKfx6f/1GOBrGMNRRiT7vRvwEJ6k=;
 b=nIweUsFPtjj+VNG9N23uuStwlWa8gJsTpfyffJpcQNouQpVCjB6L5NWXLf3hF3gTqT
 5StpxepZfdzzDFCYi9nKM3WjLirOQSw1bcmM94XwIqYmOExYc9zTvmP/SIgC1eQmONTf
 nY27so82AHIRNrUD4vj2rN2TcPvF7HCHxZToR6SJJp9DCXBsALHcGn01+iPwVcCN+Bv6
 9Lk8dTTgqvV9kcwz1jiqSOrQZmd9sKX0Zk5qu4XrRNWg2xaAoXAy6sZFoky98g6vJv12
 GhrY4Yk68JQ9NAE5vm0j0OV30VRYymFGrBdrjriTwRl+nZOxmHUFW0/6sMXogbcnUwQy
 FLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790184649; x=1790789449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OcOOAk0eswPaNGGDKfx6f/1GOBrGMNRRiT7vRvwEJ6k=;
 b=lyEYpyThuq5aCFxOEDkNrINnqU0dH/zgDwbYgbCJgFNSsq73JRoWJx7+aJBQLCIWcG
 YMSjGwiluiu4cPmJruSA6Wdod1d8oGA0hQtMH6ZXqEbCxxXLFMt43o/irMXTyO1Bnp42
 pkVAa52iXeB0XbFbcCR4rtKBj33772W64a9ihYwnHyg9IRkQxvL6zq2K5W2aFlRJYcMT
 c9wzqi7qRfuB5hxzp6EjMQuFrAMxKlau8MtLK5DXRWvBMQrUCagCXUy65LTJZRSaF2Mk
 b0sKFkn1GHaM719A4ZL30LyXgyfmoR0zOzGHRbB9GIR+/5AMXDonCNmuWV8tZ6q7Uo0m
 uZww==
X-Gm-Message-State: AFuF++m+JrtIimZPnhZtn+haxlrTQROvvc9p8ZB8HhGazQtWa/9cyeNu
 9ypv+YOz8Vuhda20GhzJ+DVsckqWdXV8dR06Nv1LwW1oKmDGKl5A0kUXFilZaYYl1oui3NNYS8y
 YSv7M+MQnqD3OGhS3fczA13+vvo8hc2/GQaBRqArOyLYQ5eFwQ9Cgn1dOfA03gu+gQoWYDAmOxr
 coRTmYadMv2Tcz/NQCJhNca+ZmpjtIvhnEdamEBXXc
X-Gm-Gg: AYBFou2FCjEfZ3W1ft+ZMmjdzakxINNeBejhTj3i24zC0hFCUtSP29BFeORZMQleo6V
 OxKqMZyovEVy61Tnf4ZWUYLIjc8L4qNeG0cyor+R2PNUZSBDE0CaCeHJ/AXgBnmVLFRcOw5lKxJ
 Ix+V9Y1RnGlqh8b45tIMWn10sZ2OcZPmXNI8Dv86kwLnmYwbA6aTjTaeOSPgcB9KDI7maOI/jo3
 IApQEUMd4hpVVypTyFJIxazESjhQwW1Hj7QDasD5ir027g/HeEVDZbiOYj0nKx4xDDS6XDmOTvI
 7dhoEpO9/78J5k/JnnWeMzt/MejZRnLk3FXYFh8VnX8zLRjP4uj0sNtEH7d+peSdCueJ7ZnhhYE
 ayeyQTJ2zcMNyxyESffORc36pGj+eyjRFZn0zXJn2Xqg57ScBN5/ptcr2Fmo2633AXbBhF58l5p
 BIwLzFz/1/evv/MZg=
X-Received: by 2002:a05:600c:354e:b0:49c:fc6e:a3d8 with SMTP id
 5b1f17b1804b1-49fdf13d72cmr52432675e9.23.1790184649727; 
 Wed, 23 Sep 2026 10:30:49 -0700 (PDT)
X-Received: by 2002:a05:600c:354e:b0:49c:fc6e:a3d8 with SMTP id
 5b1f17b1804b1-49fdf13d72cmr52432375e9.23.1790184649315; 
 Wed, 23 Sep 2026 10:30:49 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdf9691e2sm81758945e9.1.2026.09.23.10.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 10:30:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com,
	zhao1.liu@intel.com
Subject: [PATCH 10/17] target/i386/tcg: implement JMPABS instruction
Date: Wed, 23 Sep 2026 19:30:14 +0200
Message-ID: <20260923173021.317809-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923173021.317809-1-pbonzini@redhat.com>
References: <20260923173021.317809-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This is the same as an indirect jump, just with immediate operand.
The requirement of W=0 and 0x67 are already available in the decoder.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     | 3 +++
 target/i386/tcg/decode-new.c.inc | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index b4b0567e7ca..cbc85498a1c 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -190,6 +190,9 @@ typedef enum X86InsnCheck {
 
     /* No REX2 prefix allowed */
     X86_CHECK_no_rex2 = 8192,
+
+    /* No 0x67 prefix allowed */
+    X86_CHECK_no_adr = 16384,
 } X86InsnCheck;
 
 typedef enum X86InsnSpecial {
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index c2b252c01be..b6d909d5f2b 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1993,6 +1993,7 @@ static const X86OpEntry opcodes_root[256] = {
 
 #ifdef TARGET_X86_64
 static const X86OpEntry opcodes_rex2_map0_A0toAF[16] = {
+    [1] = X86_OP_ENTRYr(JMP_m,   I,q, p_00 chk2(W0, no_adr)), /* JMPABS */
 };
 
 static void decode_REX2(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b,
@@ -3119,6 +3120,9 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         if ((decode.e.check & X86_CHECK_no_rex2) && (s->prefix & PREFIX_REX2)) {
             goto illegal_op;
         }
+        if ((decode.e.check & X86_CHECK_no_adr) && (s->prefix & PREFIX_ADR)) {
+            goto illegal_op;
+        }
         if ((decode.e.check & X86_CHECK_VEX128) && s->vex_l) {
             goto illegal_op;
         }
-- 
2.55.0


