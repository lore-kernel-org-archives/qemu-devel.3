Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A860FFD006A
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 14:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwi0b-0000LE-An; Sun, 01 Mar 2026 09:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0J-0000It-Nz
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0I-0005jC-8z
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772376160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ckwtJ0FnfNcSrRYFixCj2sY19LI31H2pt20LbTzcgfo=;
 b=V7D8F6YBbWpw0UZ8Nbmuu5CgzOZngUPI0SAbex2sL4Dr3JYMGVO1OjFr7SvTQTLYCP/eSl
 ojnDEWwOFEoKsZIXcjeYbfflbUpCHFFvb1QJa1urt7PBzoboUf+VxDlqbHABR7wDD3gtYB
 pPK9bNOoEV7dF9FwrKJIgd/3/VW1wk8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-9JhirMIRMxWxgDRGhW5OuQ-1; Sun, 01 Mar 2026 09:42:38 -0500
X-MC-Unique: 9JhirMIRMxWxgDRGhW5OuQ-1
X-Mimecast-MFC-AGG-ID: 9JhirMIRMxWxgDRGhW5OuQ_1772376157
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4398f665747so3697650f8f.3
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 06:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772376156; x=1772980956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ckwtJ0FnfNcSrRYFixCj2sY19LI31H2pt20LbTzcgfo=;
 b=XsjvRIzhK8s7nUGxlwZUGmLgSLzLwsMU8TQQmF+JkzjhwfIWGejYRDx1smF6VAaEgG
 /B/fueh5b5zMYm2kljuLC3F0k+gNXa01GVsFPsfd25DjxDVE4CvqFnoLz+VkBvg4zp0s
 MJs7MX0P76ZglBc4ZixdzHr+VrQFLk0u/rk83D8y41o4oh5w2WI1noWCAaU2zCuJoX21
 CfYp3+5f+WBtdYOH355UycZKDRRVfkK0IHRHS7XbHf7ds9v9gWfJzhmSPmbcNrq2olzT
 fjVXohy4qbbLF++eu8KyK4oTZ8boTEMszwMw8ZHdVy2Yd1d/PBGbqmYUCTsP2Km/a85l
 9m2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772376156; x=1772980956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ckwtJ0FnfNcSrRYFixCj2sY19LI31H2pt20LbTzcgfo=;
 b=Jg3yYV4cwKOC12Pj4KD98XZq2Ur+5rMla+5kexjDJNZBkW6gwzh89Y7SkBjlVfY3Kg
 jxDB8pAwmonOULQkmMjpND79XUk+80kESQ9zJa6X9X4aRBHtOwSyzVA16zHtVaIpis6p
 pRPRxm6ipfSpYLZvU5+ZwhDTLaz9SJ3MdRgDsHRbfH7eAQo/sTv1nSnz5N2S6nGttn5K
 vTC1/Ot19Iu5P5361/AE6oqM5IreFq/gU5BuPQQvi/IZc2VnA65a/mvHCe8Yf93LR6RO
 k0IQliAqI9AA2QEZh24G2UP+er0EdCI8dAPHnOekVV8O3IWOXDuJC/TiQvKs39taJvz5
 y5Tg==
X-Gm-Message-State: AOJu0Yy75DLdICBGtm7zWJ8CT0wyxYTlu1G1qRFhJXh2u4n5JXNG4y05
 +f5ElXh1d/GvrkRQExXRvUGWOJSCm3fLJQLZtuql4bQ6dcQQDIFlKqbd07yg1WP2InHf1ZFovjP
 ZkdFJ1NDDkfLI60EkhwhU5Zaxf5/MheLk7v5Jra5H/YcVeocwFJCeQO0dGqc87gmuaGlm4nacGD
 IPI3b/hPXyULvUiY8twRFv5eyDKFr81uWUlkegO9qk
X-Gm-Gg: ATEYQzzI9j4W+lyn/Rh/6stodDJdEv7cxjCXH8l6s0au5RGa6kH/lMjnjvDbX6GZrjK
 rAYXD8rFEP2L4xYuevpyjnwPjFe/LUFjfVu6EUR4h+v4mqJy10+6PDixrqxtlR33j+Tt4KCWUvz
 SNmlPRe2Vi97dn26TPQjcclGyu12yMmDcvEVwOUnaFrjtuVVmtOp9z/TydWJVSKAaWszhysILwp
 Ld1u1uv/wdXtCf0WNSdSLgZFODYH8LFF3jAsw0cA+eMJPGs1PlWONfuMLpaJJyEbvGAvtf7gBdb
 0S82IQYX0t321ubOo7klhLFitePDHAsLTbogsSIBGSCw10yEL+BuMnfsGyNegrwmHTn3W368wvG
 Yk+QtCsQD+Qh6Rnw/EbJ1aXsvP4Kv97pSCRjxb9JNBqe0wJz0ouvZ8jeVI++CQL9qe413OlOdGx
 Jw850wHoJ0Tvzso6zT6XsgplV/knE=
X-Received: by 2002:a5d:64e8:0:b0:439:af0e:5798 with SMTP id
 ffacd0b85a97d-439af0e58e8mr5621131f8f.41.1772376156230; 
 Sun, 01 Mar 2026 06:42:36 -0800 (PST)
X-Received: by 2002:a5d:64e8:0:b0:439:af0e:5798 with SMTP id
 ffacd0b85a97d-439af0e58e8mr5621086f8f.41.1772376155676; 
 Sun, 01 Mar 2026 06:42:35 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c764546sm22802151f8f.29.2026.03.01.06.42.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 06:42:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/18] target/i386/tcg: implement JMPABS instruction
Date: Sun,  1 Mar 2026 15:42:07 +0100
Message-ID: <20260301144218.458140-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260301144218.458140-1-pbonzini@redhat.com>
References: <20260301144218.458140-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

This is the same as an indirect jump, just with immediate operand.
The requirement of W=0 and 0x67 are already available in the decoder.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     | 3 +++
 target/i386/tcg/decode-new.c.inc | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index c974ca9d7c5..4998712e86d 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -184,6 +184,9 @@ typedef enum X86InsnCheck {
 
     /* No REX2 prefix allowed */
     X86_CHECK_no_rex2 = 8192,
+
+    /* No 0x67 prefix allowed */
+    X86_CHECK_no_adr = 16384,
 } X86InsnCheck;
 
 typedef enum X86InsnSpecial {
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 9ee69564ab1..d8a5025ac07 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1990,6 +1990,7 @@ static const X86OpEntry opcodes_root[256] = {
 
 #ifdef TARGET_X86_64
 static const X86OpEntry opcodes_rex2_map0_A0toAF[16] = {
+    [1] = X86_OP_ENTRY1(JMP_m,   I,q, p_00 chk2(W0, no_adr)),
 };
 
 static void decode_REX2(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b,
@@ -3072,6 +3073,9 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
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
2.52.0


