Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BA6C79FBF
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4KfI-0001gT-Sf; Wed, 09 Sep 2026 11:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4KfH-0001fj-7J
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4KfF-0002rF-KL
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788969405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=twO8ZHR4r2etoCOnruooLLOPg4gyrWt0G5W7nPOwx74=;
 b=KhRi58V6vOWWsWTab+HMQN9RoD/WbHNDRCFvwTljiCyMm6Mcg605kHg1eOWtB842kxnwrl
 UfN0kBspM7G6zY8bPCdt1Cn9gfxJxkXAIuFgtxKYJqyYG30ZgI0AjXtxcf8lJEYy+7UHa7
 GCtfiEnikU0ZEm3yIJ3hkpDHXZ21dsc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-LqB_FUlpMRqr9c9u-flsEg-1; Wed, 09 Sep 2026 11:56:43 -0400
X-MC-Unique: LqB_FUlpMRqr9c9u-flsEg-1
X-Mimecast-MFC-AGG-ID: LqB_FUlpMRqr9c9u-flsEg_1788969402
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4839f9edb08so3804050f8f.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 08:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788969402; x=1789574202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=twO8ZHR4r2etoCOnruooLLOPg4gyrWt0G5W7nPOwx74=;
 b=JWqmPHYOJENxg8ONhlOR2itUSlLFU+i/+Bxgz1++NE4djYGgVKJb3RzanZ7nOM1n47
 Dsg9TVQ/6wVs/RkY+hfFmabADgLJoLLX8raiW/x5sPYa8OiWQUDkYFtY4/wWMmrRvMH6
 rH3dvG94KpLl17B8AgLRQUJSBIW8agNQjVpQOPCBS4dA2m8ZbLGZ5MSu8KhOf6lpee8o
 X+Dt8WctKbfZMZ+OB+BTa1qJGlATeP4AldCMya1AJsmij8MBbsBpLbvf02ieyV2ua6Ik
 kRgOHdIsDosD9S/E8g2kq7XE2tIVraqQsn6stUA+nA9MPr+K+I47J6XSOtdUQQJul12p
 bfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788969402; x=1789574202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=twO8ZHR4r2etoCOnruooLLOPg4gyrWt0G5W7nPOwx74=;
 b=XOmZBFtk2nVmkcDToN5dAWGh1RjuCBGcH0crY7wgs8px7ksktJnp6KXUpKCumMqiy8
 x5cCD1QJPJe4dVzHPC2u8Wst+qXOJiYojEotAXBD2d4zGWAOVo88XkGPIG/moCYILaww
 ll651ZkenviqnmiAWDuz60ms7rv6tr67shdgvjHQTd7BqCakLq92yWo/hx1U8VADjFKl
 sxkmHiB19aU0T/f9odsT50ywN9UJ804/nug8DmgZX44oMYzs8GAI+CDhC8wYencpks/h
 ImWQod51NZG7wfeLQWs1sKjzFvemURUYRVrNl7tBnW0Yr+rQZIsJu10Z9JSGwLe007jB
 K/KQ==
X-Gm-Message-State: AFuF++l2r72dqt0+1GcAlc+TRx3NyLojn4IDYQvGxRnmd262GyT6qqIr
 w4beRQqWgIOxUoK7JRu1R9bcE9JyPiltq9N+gctImXvbHPK0GuR1+Ht9S0Nz87O5mHvk+0CuK5Y
 xsLvDL8ts+jjXToCjtujWWDocaK6PgEsLiJrHj0ROg2QeBFbbxiJmiabZiTH1HITRlJn7zm/BMp
 65eiL7bSBgZu1kVeYTE/IyvJpetB43WbeGpHun14c1
X-Gm-Gg: AYBFou0b270rwxMgFrsP0BWSOUHUNwEb5e786J+bOSu4Nf07buOcJ1vGQbP29jYhIWz
 z7h9vJFHRK2PRelfvXW27djsGcKsUu4mqSgwixQ6au+WIxePcWl+hTspFU5+pTGFHhpwMz+JTNg
 QN8yY21+hAHRhi6Q/Cn1l7lXh1LfZgo9z/BPEM5jSscLU0AKOZgb+1KkEXt7XSb9fYUTLp2WCll
 LOrBfkZYZkvGWLSHH97bzkEuBCeztoHP7XkominezyjmtgbJ1kQczPfGrBuZQw8/535np9XbXox
 pPltkdOCciM0fQCyI349eqwh0wqRsbX0yCtZfECsHrEjaTdMpVQ/SKtqngR8X9ewsTpiYDnhCSJ
 BPH2al4MNPKI6uLjooJJoSar/0AJSVylK6nlxf3Dkt2rlasM5KguGLakuUZ0GOYuYuh5an7+Zhk
 NSREuM
X-Received: by 2002:a05:6000:4909:b0:485:8c17:9764 with SMTP id
 ffacd0b85a97d-4858c179966mr33618878f8f.38.1788969402399; 
 Wed, 09 Sep 2026 08:56:42 -0700 (PDT)
X-Received: by 2002:a05:6000:4909:b0:485:8c17:9764 with SMTP id
 ffacd0b85a97d-4858c179966mr33618839f8f.38.1788969401880; 
 Wed, 09 Sep 2026 08:56:41 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588135600sm39517128f8f.2.2026.09.09.08.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 08:56:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Andrey Polivoda <apolivodaa433@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/12] target/i386: Mark MOVNTI as not valid with prefixes 0x66, 0xF2,
 0xF3
Date: Wed,  9 Sep 2026 17:56:18 +0200
Message-ID: <20260909155624.1082893-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909155624.1082893-1-pbonzini@redhat.com>
References: <20260909155624.1082893-1-pbonzini@redhat.com>
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

From: Andrey Polivoda <apolivodaa433@gmail.com>

According to both table A-3 in Volume 2 of Intel 64 and IA-32 Architectures
Software Developer's Manual and table A-3 in Volume 3 of AMD64 Architecture
Programmer's Manual, 0F C3 is decoded as MOVNTI only if the instruction is
not preceded by prefixes 0x66, 0xF2, or 0xF3.

Currently, QEMU does not check the presence of these prefixes when decoding
0F C3, which leads to QEMU happily executing 0F C3 as MOVNTI instead of raising
an expected #UD when any of these prefixes are present, which does not match
the behavior of the real hardware.

This patch fixes this bug by correcting the decode table for MOVNTI so that
it requires that none of the 0x66, 0xF2, and 0xF3 prefixes is present.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Fixes: 3519b813e1f1 ("target/i386: port extensions of one-byte opcodes to new decoder")
Signed-off-by: Andrey Polivoda <apolivodaa433@gmail.com>
Link: https://lore.kernel.org/r/20260818145837.550059-1-apolivodaa433@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 1f071f0a5f0..459452b04e3 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1374,7 +1374,7 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xc0] = X86_OP_ENTRY2(XADD,       E,b, G,b,            lock),
     [0xc1] = X86_OP_ENTRY2(XADD,       E,v, G,v,            lock),
     [0xc2] = X86_OP_ENTRY4(VCMP,       V,x, H,x, W,x,       vex2_rep3 p_00_66_f3_f2),
-    [0xc3] = X86_OP_ENTRY3(MOV,        EM,y,G,y, None,None, cpuid(SSE2)), /* MOVNTI */
+    [0xc3] = X86_OP_ENTRY3(MOV,        EM,y,G,y, None,None, cpuid(SSE2) p_00), /* MOVNTI */
     [0xc4] = X86_OP_ENTRY4(PINSRW,     V,dq,H,dq,E,w,       vex5 mmx p_00_66),
     [0xc5] = X86_OP_ENTRY3(PEXTRW,     G,d, U,dq,I,b,       vex5 mmx p_00_66),
     [0xc6] = X86_OP_ENTRY4(VSHUF,      V,x, H,x, W,x,       vex4 p_00_66),
-- 
2.55.0


