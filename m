Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21430CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCZMz-0002C3-1x; Fri, 02 Oct 2026 05:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xCZMb-00029v-SI
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:15:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xCZMa-0005Nz-Bc
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790932531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LpKljmHzfmHceX3soTNWw65aPAyZeluzaSunMbjO8To=;
 b=INN99xVrmKYLN3T3oQrTDCyMGBiDDLKeNTC4hYEJoLST4r5aSdWE7VOdUrNTvgflC11rYG
 gSkiGLH/MOqdqA5ZN5/DDe1MOnoUHgq4/9mY28fiQJkkvDhWOe/DOr+mZdv8VhC5vFdkSN
 IyfsTgTDnX7q6eV5YnI9SPl2ipYiGwI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-ePb1a4U_PrqE1CJDf7S3DA-1; Fri, 02 Oct 2026 05:15:29 -0400
X-MC-Unique: ePb1a4U_PrqE1CJDf7S3DA-1
X-Mimecast-MFC-AGG-ID: ePb1a4U_PrqE1CJDf7S3DA_1790932528
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4994d67d0e3so54258875e9.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 02:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790932528; x=1791537328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LpKljmHzfmHceX3soTNWw65aPAyZeluzaSunMbjO8To=;
 b=qXF21JNJuNauXs+Sr/DbKYTE/YKCox6ziISjTChT+l0ASQXwUOk6WxSMLKay9RgUSO
 sIIjtOkjDSHVhQuM5mjBnbGeMJe7pVFEcY7JFN2CN2eoYUyyXYD9dG+zXvNztKeoRjQi
 VLXcBQJThsLCBCEsu5JGKnlHKZlBE5IrxDusPCy8L6hKPo3Rtjl5AP5Gs31DdYo6v3SE
 CPDq10wenSlTWhaqkps70aBMJ+n5dDCnizpWoTXiKLDBkwBKzR4/GVW//RdovJnBHYbk
 hhhGW/92LgVkb4GFu/voVhX3+IjnIN0teVuMxV+fYVAZwwGC37qut6vU3zr3MtWhI0oi
 WhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790932528; x=1791537328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LpKljmHzfmHceX3soTNWw65aPAyZeluzaSunMbjO8To=;
 b=pPUawa0lzS/tp0bqXOp45b93KuGWKbLKQD86K7IKuIIg+QAE/kcB9tweGlRLATcBun
 5K5EuqDEEdatSzPzIe7d4H5qAMKuphVDpTkd7Yv3uTIL8JLZqYddpzJb/krbIAzomn9R
 fQjxeuJfWhL5xCZ8NSIoZ3qmaumfBWXSst7iruotkk2VhU/wNTNkcKg2RQsw9bhPOz50
 ErhY4g64cLpVOCZPmDOfdYOKVevQdJyCk64RYB3afnh3dC3tw8pSMGWaM5FN93/mFGVh
 OMfZzAe43QlGXyXz4E5OkOac6gK+NUWlzI3CoROODnKVK+gsidYetH0sepIGoZt4YUo9
 9vkQ==
X-Gm-Message-State: AFuF++k1GesSVc1AUO9f/OjvFPBr4JzqzN638picroQR8bRZpej+KBpo
 FwoRcGXaUNX2Tqse4Cd7a9rhpxC1C+Cz8iD463xQMMx5HTJZok60VLb/8zcvNJLAIOeG/gooedJ
 WQ2XFAJOfDP7prvbpeVgmGN+fRfi6sLox+rfxdzDANDR6et8/DylY25/ewQrrKOdYrHo/j4xKH2
 8fYeTx3jMjPAd21Vqfgj1K6ZE2WsnNEQ7VT6DbIeVA
X-Gm-Gg: AYBFou0SzJG0Hbv8MnxZ5fz0JXmkhxwYBRrYMh2HBDVz67zQWlvb2QI4yjjsqru228F
 sZw36rwuQ1ZehMg+Ze1lCnX3O88hRTbgliEB4/wempyLT5f55wd111LZ/CvuH5lRynexNtmJkQJ
 eXpLXn3DSjsrhxDpDfNQ4M8TFd9myrw1XjAvCKtvFdPpt7PsqKumAU/Lok18XAQGOSz5WVEt5Cz
 QF+w7/808ARMCiFbujSMRka2caT37NOCKgeMGPsjI4nJhfc0Vypy2r5H14XGuS34GsNywJeB81l
 d53wz/frYWc2uIY3SXtgq80KLT3hhJA+oRk/prSgk/rQvJK12YT8m+jL4/9CI9XTNr7eG9Tx8Kw
 CbUCVAkq2I+qmXyMQ5OWA/DpJQihEIFTqOrx+0NIP1lHyc0dC984AMYuo+Ide2WobjUJeB08rej
 1DXCZn
X-Received: by 2002:a05:600c:19cb:b0:4a0:98c:e082 with SMTP id
 5b1f17b1804b1-4a02759fc4cmr40250705e9.13.1790932528311; 
 Fri, 02 Oct 2026 02:15:28 -0700 (PDT)
X-Received: by 2002:a05:600c:19cb:b0:4a0:98c:e082 with SMTP id
 5b1f17b1804b1-4a02759fc4cmr40250145e9.13.1790932527730; 
 Fri, 02 Oct 2026 02:15:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027734b49sm68467885e9.10.2026.10.02.02.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 02:15:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 08/32] target/i386/tcg: clarify return value of decode_insn
Date: Fri,  2 Oct 2026 11:15:18 +0200
Message-ID: <20261002091518.1139575-4-pbonzini@redhat.com>
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

It is clearer if decode_insn() returns whether a generator exists;
if it does not, the entry is empty and all other checks such as
validate_sse_prefix() or has_cpuid_feature() are moot.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 5212a24e470..388cc3a7ccd 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2478,7 +2478,7 @@ static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_
         e->decode(s, env, e, &decode->b);
     }
 
-    return validate_sse_prefix(s, e);
+    return !!e->gen;
 }
 
 static bool decode_ops(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_func,
@@ -2984,12 +2984,11 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     decode.cc_op = -1;
     decode.b = b;
     if (!decode_insn(s, env, decode_func, &decode)) {
-        goto illegal_op;
-    }
-    if (!decode.e.gen) {
         goto unknown_op;
     }
-
+    if (!validate_sse_prefix(s, &decode.e)) {
+        goto illegal_op;
+    }
     if (!has_cpuid_feature(s, decode.e.cpuid)) {
         goto illegal_op;
     }
-- 
2.55.0


