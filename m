Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE72FF9936B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrKm-00012x-PL; Thu, 23 Apr 2026 06:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrKF-0000nQ-Vd
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:30:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrKE-0005oG-Ak
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rof6tYmA3yNSs60ICHlduhezXCmfZD19VtF8nxPlTLg=;
 b=E2xPyUv7YaTbTB1rFKl7yssTxlDJCFXN7Ye1rTuIAc5aTfvatHfhh/yKwaXV0+1zILxqOg
 6vi1oqr0XocRFE21e6mlNuIv1nh3ylbPteaadurQ9L7RX/LXirBMHZHI297YWFKgYqmS2J
 LUSLlSL1DZMWex03E4a34LBBjw5thD4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-vqH1qa2_OweYdi6H6atJ_Q-1; Thu, 23 Apr 2026 06:30:24 -0400
X-MC-Unique: vqH1qa2_OweYdi6H6atJ_Q-1
X-Mimecast-MFC-AGG-ID: vqH1qa2_OweYdi6H6atJ_Q_1776940223
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4362197d1easo5041791f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940222; x=1777545022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rof6tYmA3yNSs60ICHlduhezXCmfZD19VtF8nxPlTLg=;
 b=I+zEV4OWOj7OBKqhkEWpT8ZKqzEBa7MEQ0a1KAD/CE0jO9of8diJyfY+qCckjHjTQs
 g456YiJblAw4CWNK16eGDpocFRGfSY6litDNpgJBBe3DPpWnV/qHhiEZoK7Y/3ND9Ume
 mGNFj/Njuu/u48JdLk9dyAtafQmU9VPlYNu66DPhFydNnPKxHOKzaxZV6uhtYcPvihDt
 mhhzgcGrWvUpD7STdt7eTivgNdWcStGvlh7mu3bQB8yfyM0Pqp89NDcAtA2qwS8JC3+X
 26SJ8UFU4DnS46mSabZRfM2lwcENbuoyzQwY+K+jqFQPtP0fJEcSh+6H94F8nrvbUswy
 /EOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940222; x=1777545022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rof6tYmA3yNSs60ICHlduhezXCmfZD19VtF8nxPlTLg=;
 b=RnLkzZsE5LuE3jtCfB9N/HMK+lQO6+q6OiK9IGruleeZSZHsXiM51tvurUHBsghJqQ
 aJhrRyKT8gQ0Nb23oBlWu6WCkl4rpXJKp4bQf++F8loHNYUxqVKiScIx7fp+WDHJpH0i
 2WsuJE6aNfl3lbftIyds4xQkYvbiq8vPXDKzsP25rVq8DTjfFX94viiI0E5s1oCjPeAo
 TfFWupHuvss2bZzvGg0pQQ2cJEKYVSU2nZZH50B+wUhTEQtikt2+D3NLhV9c1hqAR6NZ
 ZSA93aMqC/zkuY3+j9PMI5vtn/79B22O7C1wPXK+LFXtTdNuVVKxb004AMyR98N95Omi
 1Dgw==
X-Gm-Message-State: AOJu0Yxxef8xFTWPnBL5esNTaCleyAjYzk82hPvHTReSfNuTKco41Oz3
 mQ8ZlaPLGagJKqhp7P0dqo2MpnP/LYOhbmAncDegaLMm3O3OP0p1ndDO4KSzEsXUAEyop0TtJnt
 2ds7XwiFlgrE1ZwXLbFbJqhTq9Id+eH9vwyqMf+9Qil5sRG1C2Hf5RVDHNz1qBSB2xRyyxftvL3
 BVojRr6tUNsz2efPMpYfqTqBwVOOCdGROgkLMM57PA
X-Gm-Gg: AeBDieupXuf0maasowoNZUrBk2JB8+ZzTCHJAchtHVFBcuF7FH3h2B4Y+wmqwiRvO3l
 +jdT4gtFZx2VXSGDDbVnFXPkdVJH7/AJLoEwWOMdrFw3EA8BN6jeP8SFWOLxhPUuhjixk/g4UOQ
 ww/g04YWnXi8ep5TYeUF7XuINRRuhO2N2U4KFtIu07fIKPweKBpRPHtk8egvZD/XgFvhzIE1xxr
 2jBnrOsyUhjTyM6x9RDhevTwatYnguPMcPylZj9xnqRxsK21se5cpYvjgkEpdJJuctfvsF8+/Zt
 mIqqA1Nl/hjNA5RHSxtHC/ZRfyYiverhI8MUdEcwapgsOxbm64xApwIfZWvNncwhgkdThxiFC5F
 K2vIOoAAwhr4GJhM9SPesWl6D4oBLVeqWj7HGy7jmtt0ypmLDNiDaklwpv2hfmbrN6dW5KksJKp
 FcyGPeCCqbema2IP9zHh86278CVAj6okrxRDo=
X-Received: by 2002:a05:6000:310d:b0:441:202e:3d2d with SMTP id
 ffacd0b85a97d-441202e3f4bmr17381114f8f.19.1776940222099; 
 Thu, 23 Apr 2026 03:30:22 -0700 (PDT)
X-Received: by 2002:a05:6000:310d:b0:441:202e:3d2d with SMTP id
 ffacd0b85a97d-441202e3f4bmr17381045f8f.19.1776940221494; 
 Thu, 23 Apr 2026 03:30:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a174sm57683843f8f.18.2026.04.23.03.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:30:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 21/25] target/i386/tcg: fix decoding of MOVBE and CRC32 in
 16-bit mode
Date: Thu, 23 Apr 2026 12:29:18 +0200
Message-ID: <20260423102922.443639-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
References: <20260423102922.443639-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Table A-4 of the SDM shows

                    F0                     F1
--------------------------------------------------------
     NP           MOVBE Gy,My           MOVBE My,Gy
     66           MOVBE Gw,Mw           MOVBW Mw,Gw
     F2           CRC32 Gd,Eb           CRC32 Gd,Ey
  66+F2           CRC32 Gd,Eb           CRC32 Gd,Ew

However, this is incorrect.  Both MOVBE and (for 0xF1) CRC32
take Gv, Ev or Mv operands.  In 16-bit mode therefore the
operand is of 16-bit size without prefix and 32-bit mode
with 0x66 (the data size override).

For example, with NASM you get:

                                 bits 16
   67 0F 38 F0 02                movbe ax, [edx]
   66 67 0F 38 F0 02             movbe eax, [edx]

   67 F2 0F 38 F1 02             crc32 ax, word [edx]
   66 67 F2 0F 38 F1 02          crc32 eax, dword [edx]

versus

                                 bits 32
   66 0F 38 F0 02                movbe ax, [edx]
   0F 38 F0 02                   movbe eax, [edx]

   66 F2 0F 38 F1 02             crc32 eax, word [edx]
   F2 0F 38 F1 02                crc32 eax, dword [edx]

The instruction is listed correctly in the APX documentation
as "SCALABLE" (which means it has v-size operands).

Cc: qemu-stable@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index bc105aab9ea..c8b5bd6ad26 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -875,19 +875,23 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
 
 /* five rows for no prefix, 66, F3, F2, 66+F2  */
 static const X86OpEntry opcodes_0F38_F0toFF[16][5] = {
+    /*
+     * MOVBE and CRC32 are incorrectly listed as always doing 32-bit operation
+     * without prefix and 16-bit operation with 0x66.
+     */
     [0] = {
-        X86_OP_ENTRYwr(MOVBE, G,y, M,y, cpuid(MOVBE)),
-        X86_OP_ENTRYwr(MOVBE, G,w, M,w, cpuid(MOVBE)),
+        X86_OP_ENTRYwr(MOVBE, G,v, M,v, cpuid(MOVBE)),
+        X86_OP_ENTRYwr(MOVBE, G,v, M,v, cpuid(MOVBE)),
         {},
         X86_OP_ENTRY2(CRC32, G,d, E,b, cpuid(SSE42)),
         X86_OP_ENTRY2(CRC32, G,d, E,b, cpuid(SSE42)),
     },
     [1] = {
-        X86_OP_ENTRYwr(MOVBE, M,y, G,y, cpuid(MOVBE)),
-        X86_OP_ENTRYwr(MOVBE, M,w, G,w, cpuid(MOVBE)),
+        X86_OP_ENTRYwr(MOVBE, M,v, G,v, cpuid(MOVBE)),
+        X86_OP_ENTRYwr(MOVBE, M,v, G,v, cpuid(MOVBE)),
         {},
-        X86_OP_ENTRY2(CRC32, G,d, E,y, cpuid(SSE42)),
-        X86_OP_ENTRY2(CRC32, G,d, E,w, cpuid(SSE42)),
+        X86_OP_ENTRY2(CRC32, G,d, E,v, cpuid(SSE42)),
+        X86_OP_ENTRY2(CRC32, G,d, E,v, cpuid(SSE42)),
     },
     [2] = {
         X86_OP_ENTRY3(ANDN, G,y, B,y, E,y, vex13 cpuid(BMI1)),
-- 
2.53.0


