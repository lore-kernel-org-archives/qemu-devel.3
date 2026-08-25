Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB87EC61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyqHf-0004gs-1q; Tue, 25 Aug 2026 08:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHa-0004gO-OM
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHX-0000I1-Sr
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787660974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eE17Ge5pQll+CKBZcZE4tJbV0rcAbPkHpSAYrj5d3UE=;
 b=MVRcCCx8vrDd2sdDx/YsB0eMOub3CUkXSt+jIST0fHMJ9163MNGt9+lTWjPji7Oo3x9fqY
 KDew68HPWq+QOwzf33MIm2Gusfd4C3Zxih06GqBAhXYj8yTtRLn0VlI4wn+cUsQk+wQZUI
 ePlybxRqO5NerHiNNyFDIHUMiyXlu9g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-VlfdSW4PN_-i3HPcW_xg1Q-1; Tue, 25 Aug 2026 08:29:33 -0400
X-MC-Unique: VlfdSW4PN_-i3HPcW_xg1Q-1
X-Mimecast-MFC-AGG-ID: VlfdSW4PN_-i3HPcW_xg1Q_1787660972
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c1670dd0f5dso157070066b.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 05:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787660972; x=1788265772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eE17Ge5pQll+CKBZcZE4tJbV0rcAbPkHpSAYrj5d3UE=;
 b=BydEQEtbFCycFrnZ6/ohHYPAr/YCttGpkw8dRcIVGjgEQIbC6lflvAS//WVQ/fUZNT
 7umfHwVH6KmcJfLlWKiT+mXO1vde4zUvtBnQ3lAzyUk+wtVxluwhK0YronXxA9r/0I71
 nwxgCMDsGrZxkdCEmTRmfFwyoqFhNRu+JV2l55m2kaRM8nMb5ZXUyQIrNBOr0E1NyR56
 NHIRXtofl1+m79x18paK+HGV5rTCwJXQ2nv3cEbeVorMSOOklqAjSpw4kmSW0UU3mcnU
 VfvjMVCz4IQs/yJ/2GTOcmjevBdIVlb+Jha3kg3MmXe4Yg9SynZrvp3pYaakqf0W0/Ce
 c4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787660972; x=1788265772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eE17Ge5pQll+CKBZcZE4tJbV0rcAbPkHpSAYrj5d3UE=;
 b=CVJeIZzYi5s+vWA9Ye1v5jtaXfo/5daDS86atbrCWBFLTi+UUm2soXQCLz31fzBcG7
 bU+24K9+vt4dWfwuQAPZ2MAo8JA5cpviaoJFRge2CK4fr2TkcjaZPqLNZ0KbZLl+H/Ec
 TSrYKlpbrynG3wMyXUeMNi3f4gzhBpSHohcTmAFYdrz28Pgp8TzOv4KZEVKL0Wkvo5IM
 SA2hYpkRFqwCK3PAaFAYAu23QszWxzINPjcjon+PFGxYrK3D2FzI00oLLT6Lx1p+KxDO
 xVDUY7d3e+XH2kRe6R1ZT5w568qW4lPQRuaayZmhVei7aQwq2SKy0PjT8ZW8/O6X70tV
 5XSQ==
X-Gm-Message-State: AFuF++kIar3Ki5OvdQkdiu6TBZMX1E4wC+IrEFcfnHvi2aciycYsnIHB
 6r/Lh2sEbuvmR0nFKSXhfgdBFHNgzNkk+rbL6eOgscYe9+blpjCjKW0OE3fzhDHYFEGBjZjiCGW
 8hEKbHwURmql4crx3ahagZVdR7RiHc8Joj2/XEETzWpKyeTf1EnezchpKLRCcXxW+Oeq5AIPzTo
 f1/daxee21TigeK59kFtaRIXb9MFwW9+WgKCQbmBW5
X-Gm-Gg: AR+sD11BmWlCKfGW/ki0wyd4bDdSQQKrrGJZlHOU5jgaxeMvwfrL/DlAJLHlaTl1Bhx
 PIMZbtsa+vHasn9M/6oibtCpEEFuX7ptgUpSUn4dpfZZZ21+0PedzazFx/rSc5TZ0/GpEb2Y9Eh
 8hYxFHGsR3+hDo1Nx3/nF0Fv7im7PD0zXZWRaVkQbalotHpd3lzZz9ipVj6izcYjTBJbUz1/XLt
 PZm9wHQpBILxhkEOGXslLGKDX7k2KGkcpTkEZC6MCIX6bxuDiLOOWq3f+ef9fabxN9T0ZKSsQPY
 MhtpdqH3DF4w60M4z6V2gzSeQMjaREO1nrc5/f3hY1ZPeWV5LFSNHr+0ZGk8SFCMhjCEBTvSQRO
 OUOIf7RjC3rsW64aWa8RFOBMmi4R6tOzMK+DP6vollx4NoSC3C3EpyaNW0wotGjTz0ldBsANxRc
 DIXlc=
X-Received: by 2002:a17:907:c0b:b0:c24:42b1:3092 with SMTP id
 a640c23a62f3a-c2491e83af8mr2986998366b.15.1787660972299; 
 Tue, 25 Aug 2026 05:29:32 -0700 (PDT)
X-Received: by 2002:a17:907:c0b:b0:c24:42b1:3092 with SMTP id
 a640c23a62f3a-c2491e83af8mr2986992566b.15.1787660971869; 
 Tue, 25 Aug 2026 05:29:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25026bdb17sm115700066b.32.2026.08.25.05.29.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:29:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/20] target/i386/tcg: move check bits out of validate_vex
Date: Tue, 25 Aug 2026 14:29:05 +0200
Message-ID: <20260825122921.431739-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825122921.431739-1-pbonzini@redhat.com>
References: <20260825122921.431739-1-pbonzini@redhat.com>
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

JMPABS will need the W0 check; move all of these checks
together with the others in disas_insn.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 9c429e113de..47bc30a22fc 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2723,24 +2723,6 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
     if (s->flags & HF_EM_MASK) {
         goto illegal;
     }
-
-    if (e->check) {
-        if (e->check & X86_CHECK_VEX128) {
-            if (s->vex_l) {
-                goto illegal;
-            }
-        }
-        if (e->check & X86_CHECK_W0) {
-            if (s->vex_w) {
-                goto illegal;
-            }
-        }
-        if (e->check & X86_CHECK_W1) {
-            if (!s->vex_w) {
-                goto illegal;
-            }
-        }
-    }
     return true;
 
 nm_exception:
@@ -3000,6 +2982,15 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
         }
+        if ((decode.e.check & X86_CHECK_VEX128) && s->vex_l) {
+            goto illegal_op;
+        }
+        if ((decode.e.check & X86_CHECK_W0) && s->vex_w) {
+            goto illegal_op;
+        }
+        if ((decode.e.check & X86_CHECK_W1) && !s->vex_w) {
+            goto illegal_op;
+        }
     }
 
     switch (decode.e.special) {
-- 
2.55.0


