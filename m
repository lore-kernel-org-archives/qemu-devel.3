Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEF5C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHxp-0007v6-D6; Fri, 25 Jul 2025 08:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ufHwV-0006VQ-M1
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:54:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ufHwS-0007xV-Oj
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753448067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EbTMLHA3rj3U1tHOFnDcGjbFJRKDBX4Jln5VLvOEkGU=;
 b=MyODRDybzgqBSnjSp7Tf6ThUkaJeeXakhg3PfDuJ7RX8emG7gTS1A4JwdjGWEHd2EufCKA
 rLOCXhRDia7bhnTejtnj6Arzt9iN455Dub/FBkFd4owoEKVBdivVmYwc6Y1gPGFSAh2gZH
 SUvjYndXORwVFocEcmBM+v1w/cm6yi0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-fsgKrMR8NZCrTXavlHXPpQ-1; Fri, 25 Jul 2025 08:54:26 -0400
X-MC-Unique: fsgKrMR8NZCrTXavlHXPpQ-1
X-Mimecast-MFC-AGG-ID: fsgKrMR8NZCrTXavlHXPpQ_1753448065
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4ff581df3so1033029f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753448064; x=1754052864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EbTMLHA3rj3U1tHOFnDcGjbFJRKDBX4Jln5VLvOEkGU=;
 b=B/TkTri7a/83vilfJHSuJp7pwS9sAUFv++t3Y/+gP4V2P/Ak7q6LJQWthYTRgQCC1l
 tTLEpmajRu22GFw0zrHruy/t8nKsFh6sSX1PDvv4P3nY1ckJRLD+4SyfwMTC3SRQcsfN
 0VjcDTKQpagAnqHFRv9fC3EGdnYLobhlqyUfKk/aEV5XzFyDBPR718zODynmX1Q8sQho
 wBAO3nyj/T2Hnm5OhB9AWdtP1ZLG664r3sD4ajKqs6g57MXb28XNx+d2MqDnvudZHXtc
 eSmxLVpz3BmRLGz1ucCHQluULRN+G/5wPp2TyKCwBl3DSVRjnY48b2r+IxQG3nPs1z9+
 MPug==
X-Gm-Message-State: AOJu0YwrZLNOnFV6HjAbgRRo48ajdqCkI9N+93oAcZgYQzloxTYlPGGz
 q3yyA+AS1z9ujualWfUNwuylNazJZJrlV81FDpyjJwyQCLtYRq0h+DDKLH5lk8VsKrn7cByVHB7
 XcLIlndLT4Di6IhW7hfoSfmiufK9JTxWX3BInCpSGGcDFbZYHO6fgV+PwiDEIZTFdIdWPo7Z7Xt
 VaBzBfv34/5Kc8JlCa0UPal5wS8AtUw6etJgcOogAs
X-Gm-Gg: ASbGncviO1LRwHge+TM1Egk5tO0VaPk+XYGxS4XjXGrHk4fen9MFS0/ihgRv0m+KC5V
 Ri4zPhCmAFPBAZSTFFMO/Ft6b8ctZpMLxa6IM3oWQa/IVJvRYCCCuITbd1hleCwyKbz0/YQwdpo
 kV1gjk8OKtX6QA9+17Vo8UwI2yWh0baAHlCco1gVB0C69ptixBx+HYmIBTyMbt8FaDX8HomXkJG
 EFKTwYDF6fjGqYYMulP05pauv4TfoFUTogTfL30CGqFyc5YM8s74Bq5K89dcLGCWYd+H7qPMFAp
 BHGwHbtTq7Ta3xxwZhuLGqJj83pTLnaLDPaLlqGgdmRF
X-Received: by 2002:a05:6000:401e:b0:3a5:6860:f47f with SMTP id
 ffacd0b85a97d-3b7765e6070mr1925554f8f.6.1753448064060; 
 Fri, 25 Jul 2025 05:54:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/M1TFfzcdD4CRVZ2W8B2Vy1QSjMjmCjznguokabjxaGRosDg9c4USOB4VdYWaiMY90593yQ==
X-Received: by 2002:a05:6000:401e:b0:3a5:6860:f47f with SMTP id
 ffacd0b85a97d-3b7765e6070mr1925526f8f.6.1753448063573; 
 Fri, 25 Jul 2025 05:54:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.154.122])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fcad219sm5011326f8f.39.2025.07.25.05.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:54:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Guenter Roeck <linux@roeck-us.net>,
 qemu-stable@nongnu.org
Subject: [PULL 4/4] target/i386: fix width of third operand of VINSERTx128
Date: Fri, 25 Jul 2025 14:54:03 +0200
Message-ID: <20250725125412.1128617-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250725125412.1128617-1-pbonzini@redhat.com>
References: <20250725125412.1128617-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Table A-5 of the Intel manual incorrectly lists the third operand of
VINSERTx128 as Wqq, but it is actually a 128-bit value.  This is
visible when W is a memory operand close to the end of the page.

Fixes the recently-added poly1305_kunit test in linux-next.

(No testcase yet, but I plan to modify test-avx2 to use memory
close to the end of the page.  This would work because the test
vectors correctly have the memory operand as xmm2/m128).

Reported-by: Eric Biggers <ebiggers@kernel.org>
Tested-by: Eric Biggers <ebiggers@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-stable@nongnu.org
Fixes: 79068477686 ("target/i386: reimplement 0x0f 0x3a, add AVX", 2022-10-18)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 853b1c8bf95..51038657f0f 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -878,10 +878,10 @@ static const X86OpEntry opcodes_0F3A[256] = {
     [0x0e] = X86_OP_ENTRY4(VPBLENDW,   V,x,  H,x,  W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
     [0x0f] = X86_OP_ENTRY4(PALIGNR,    V,x,  H,x,  W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
 
-    [0x18] = X86_OP_ENTRY4(VINSERTx128,  V,qq, H,qq, W,qq, vex6 chk(W0) cpuid(AVX) p_66),
+    [0x18] = X86_OP_ENTRY4(VINSERTx128,  V,qq, H,qq, W,dq, vex6 chk(W0) cpuid(AVX) p_66),
     [0x19] = X86_OP_ENTRY3(VEXTRACTx128, W,dq, V,qq, I,b,  vex6 chk(W0) cpuid(AVX) p_66),
 
-    [0x38] = X86_OP_ENTRY4(VINSERTx128,  V,qq, H,qq, W,qq, vex6 chk(W0) cpuid(AVX2) p_66),
+    [0x38] = X86_OP_ENTRY4(VINSERTx128,  V,qq, H,qq, W,dq, vex6 chk(W0) cpuid(AVX2) p_66),
     [0x39] = X86_OP_ENTRY3(VEXTRACTx128, W,dq, V,qq, I,b,  vex6 chk(W0) cpuid(AVX2) p_66),
 
     /* Listed incorrectly as type 4 */
-- 
2.50.1


