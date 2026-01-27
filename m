Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CF6D25931
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 09:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfXx-0000oo-3M; Tue, 27 Jan 2026 04:39:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXs-0000iv-Vp
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXr-0008Vj-1E
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769506774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ri0PpFxdGtvnr5kIAuaORUQH3My73OqYc8urlNvvvtw=;
 b=HjlR6X0wtg8cknHbxQRwdPpREgqgXzLlxF7poN0woAlm3ifS4dQrLREjkw4s9BFk397+P7
 kHrjF4TGFc+BXYktdYcHoPzenR2hZfHN/W7GtCeop3AaG0W84bdk31EOBTuBNA0gfIDyUn
 Mn0kgQpLW/fylL4fytXQPuPtZeQo/DY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-OLTc_dB1PEaR7qcozXtwwQ-1; Tue, 27 Jan 2026 04:39:32 -0500
X-MC-Unique: OLTc_dB1PEaR7qcozXtwwQ-1
X-Mimecast-MFC-AGG-ID: OLTc_dB1PEaR7qcozXtwwQ_1769506772
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47edfdc6c1aso39622685e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 01:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769506771; x=1770111571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ri0PpFxdGtvnr5kIAuaORUQH3My73OqYc8urlNvvvtw=;
 b=crnCvOPtGEtVz/SOtvWBmbfoVA70lCBrgUKwsdB45M7a8jx5pdsLyE2BKrfLql1gFk
 7yGIezh4T3c/FQxDohHpv86TkukKRCR3apnMtn95w/wo/IRi1FVjexGvzuk1Oq/VdcYv
 0UTC5CqeIWeA2aC8ztJbvW27/5eVJXDBJEBmjR4kSfsVcgYerx1svsVMVrvM/13s/20A
 SuIZ6cK3pXEdV/jPMPIKJNYLkRD5IsWfh+eIeSWCUuD9xGeSH1OqZkSDUY5im5dDOsOY
 u6/FkEnAtoo07aePC+k7eyyDjZsNxGZnX7Lj8sADU5XIZ06CgW0cTjMX8feY1hHEEPWp
 RRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769506771; x=1770111571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ri0PpFxdGtvnr5kIAuaORUQH3My73OqYc8urlNvvvtw=;
 b=hvJ0FsqbitzYv0aGqU9/8OE80wmOhtoX0TO4DoG1L+SEWyanTXIAg9sV9X/TQyCnhP
 aIAP6TSCu3YShpegL+lbl40xyXEiYDv7Vpthvk/sqeDXiC5D4qtac1vCfP1hceY3+cB6
 aAzFPBH9Hq0eE/VXXBhee+uPHFx9NuirxH16D3AxyEhE2CuNfAUL4Qjtet3m/1pzNBIe
 w0m2oBGONNctktrxMJy78lv4joNb0+zasibwOVIc57fJxvdr+uH5O2NR56KYPQ77eFUI
 VcaAWEi9l/E3s+Zb4a6MQnfrfp194mEv9RGWkyhSEUtfA+W7xPpcfvDprDdnDin2mlxU
 dnKg==
X-Gm-Message-State: AOJu0YzyYC9HNuG7EZ0GLkjZeEm8AnYc4n/vwfuA8MnH1+3rJM6rhjXi
 hgD/wuB8UKZ82Y9mP1ZUJ6g9W2t2TGjHz5ZPBVQtqY6CdAVf2D2lZst83VOsLu3LeRcsPveeHnH
 odGjcWvzbWOd69gMByYE8k/aRQKhkx+KhNWWSNBoU28OfLo09zBlt+UPtxAQjQxrUuyVd0LmFVM
 MeWqBBrpv8oOvi4Zvr+GmzoYUsYRq5cOrd5uAH1iAV
X-Gm-Gg: AZuq6aIpvXH1b1opAc6vu9Jp0EAKJoP+XG0+Rk6KdzGSX2S0LBcvGkofHrMV9t6B78o
 B3zdtzAiq8RUApvyEN8GLw4aoec8Mdf6aJIzqjWbeLwO0Mt+0g8Q/ZWk70RPgFVGMqCQH5Iv6xj
 TovK+GMbEZKPKauYEfRMBC1YPz76+Y4dJdcBbqurqsXm/kMXODKKSJAGPjtDrZ4J7zSVW0pUfz1
 ySy9VoSy3pKxN6Mv2c0cgv06UkhPaXxT4VaVkGMKWULu4baoH+yBgPnKQilT2yDVJWA796PxybX
 SRu5nIM5BvHRtj6gEdA0yB2aUDdfKMmqzD+K698ls4tMcXCBdqTEx2tnbS8wICuh/bDAQmrBYBA
 C8bEU0aUsbjoMAx8WKDw1itBQ6HnN9KYshl6idxg9QwflUD1QFIBKH7CA775omcylDB2OGzruJ8
 dviCLHFluCSwoSDw==
X-Received: by 2002:a05:600c:1c17:b0:480:462e:d640 with SMTP id
 5b1f17b1804b1-48069c7f78cmr15505465e9.36.1769506771176; 
 Tue, 27 Jan 2026 01:39:31 -0800 (PST)
X-Received: by 2002:a05:600c:1c17:b0:480:462e:d640 with SMTP id
 5b1f17b1804b1-48069c7f78cmr15505175e9.36.1769506770660; 
 Tue, 27 Jan 2026 01:39:30 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066bee7d0sm49719565e9.4.2026.01.27.01.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 01:39:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 10/13] target/i386/tcg: merge decode_modrm and
 decode_modrm_address split
Date: Tue, 27 Jan 2026 10:39:03 +0100
Message-ID: <20260127093906.353741-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127093906.353741-1-pbonzini@redhat.com>
References: <20260127093906.353741-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Unlike the older code in translate.c, mod=11b *is* filtered out earlier
by decode_modrm, and it would have returned bogus code.  Since the register
case is so simple, just inline decode_modrm_address into its caller instead
of removing the "if".

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 64 ++++++++++++--------------------
 1 file changed, 24 insertions(+), 40 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index b00ea3e86e8..662d1d707d0 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2007,33 +2007,34 @@ static void decode_root(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     *entry = opcodes_root[*b];
 }
 
-/* Decompose an address.  */
-static AddressParts decode_modrm_address(CPUX86State *env, DisasContext *s,
-                                         int modrm, bool is_vsib)
+/* Decode the MODRM and SIB bytes into a register or memory operand.  */
+static void decode_modrm(DisasContext *s, CPUX86State *env,
+                         X86DecodedInsn *decode, X86DecodedOp *op)
 {
-    int def_seg, base, index, scale, mod, rm;
-    target_long disp;
-    bool havesib;
-
-    def_seg = R_DS;
-    index = -1;
-    scale = 0;
-    disp = 0;
-
-    mod = (modrm >> 6) & 3;
-    rm = modrm & 7;
-    base = rm | REX_B(s);
+    int modrm = get_modrm(s, env);
+    int mod = (modrm >> 6) & 3;
+    int rm = modrm & 7;
+    bool is_vsib = decode->e.vex_class == 12;
+    bool havesib = false;
 
     if (mod == 3) {
-        /* Normally filtered out earlier, but including this path
-           simplifies multi-byte nop, as well as bndcl, bndcu, bndcn.  */
-        goto done;
+        op->n = rm;
+        if (op->unit != X86_OP_MMX) {
+            op->n |= REX_B(s);
+        }
+	return;
     }
 
+    /* Decompose an address.  */
+    int def_seg = R_DS;
+    int base = rm | REX_B(s);
+    int index = -1;
+    int scale = 0;
+    target_ulong disp = 0;
+
     switch (s->aflag) {
     case MO_64:
     case MO_32:
-        havesib = 0;
         if (rm == 4) {
             int code = x86_ldub_code(env, s);
             scale = (code >> 6) & 3;
@@ -2042,7 +2043,7 @@ static AddressParts decode_modrm_address(CPUX86State *env, DisasContext *s,
                 index = -1;  /* no index */
             }
             base = (code & 7) | REX_B(s);
-            havesib = 1;
+            havesib = true;
         }
 
         switch (mod) {
@@ -2127,26 +2128,9 @@ static AddressParts decode_modrm_address(CPUX86State *env, DisasContext *s,
         g_assert_not_reached();
     }
 
- done:
-    return (AddressParts){ def_seg, base, index, scale, disp };
-}
-
-static int decode_modrm(DisasContext *s, CPUX86State *env,
-                        X86DecodedInsn *decode, X86DecodedOp *op)
-{
-    int modrm = get_modrm(s, env);
-    if ((modrm >> 6) == 3) {
-        op->n = (modrm & 7);
-        if (op->unit != X86_OP_MMX) {
-            op->n |= REX_B(s);
-        }
-    } else {
-        op->has_ea = true;
-        op->n = -1;
-        decode->mem = decode_modrm_address(env, s, get_modrm(s, env),
-                                           decode->e.vex_class == 12);
-    }
-    return modrm;
+    op->has_ea = true;
+    op->n = -1;
+    decode->mem = (AddressParts){ def_seg, base, index, scale, disp };
 }
 
 static bool decode_op_size(DisasContext *s, X86OpEntry *e, X86OpSize size, MemOp *ot)
-- 
2.52.0


