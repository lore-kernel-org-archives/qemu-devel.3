Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C54CD13DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV5z-0004cR-OK; Thu, 30 Apr 2026 13:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV5q-0004Yp-7P
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV5n-0004Az-AD
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z0z3XL+n9Zll9qCigaTT2NKDDvuOn9S6esTZ+bYQfJ8=;
 b=MrLFw1ovqQkQLewglOtIdqguGD2PLjDyoHs3A2H9HZkLWp1ZblQtTB3CbD/4BLkOGvU842
 uwLcsjqmJ235+1ESudXZ9m/ls2ePk+5fI9080kQ56Q2WDHCzJv74htQjU3vJknZNecFH1M
 32ANjFIRmF1k6yxqSrznkyZupvjo8+w=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-2aOcmuJdPaaNzXoQt_lh4A-1; Thu, 30 Apr 2026 13:22:21 -0400
X-MC-Unique: 2aOcmuJdPaaNzXoQt_lh4A-1
X-Mimecast-MFC-AGG-ID: 2aOcmuJdPaaNzXoQt_lh4A_1777569741
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8ee9a11aa75so257752685a.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569740; x=1778174540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z0z3XL+n9Zll9qCigaTT2NKDDvuOn9S6esTZ+bYQfJ8=;
 b=d4J/0HbBajg106OATMq5DI1DSWJBqzNjm1a++93g5PLY/h4fyEQ6oCy44xxbxohHgH
 gbcvBRP9f93CXuhx3I9Syx3R/ZpsDoh9dkosnYigxYRL5PLLfk628mJZblEIJJp1p9R2
 MiyOLFPOzNCBIqRYuULDUN+9m3s1XaNjrS13ZaTzOcNiCfN2Yebw0Qdu0KJusa8S10Of
 vI8+o+srYO0Ca0ro2mlNdLqa2UMzRfmFAzKYG6yLTrCODJLo04LwcOJEDgEcZQ2u0k6V
 KknA9XZNC5FDkxov7j4ZIQE8ZZDV6aMYecidIhv8JqLzbeB1fCFZmQC4kAPcON0RIE2p
 kwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569740; x=1778174540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z0z3XL+n9Zll9qCigaTT2NKDDvuOn9S6esTZ+bYQfJ8=;
 b=hMfp7Rubc7QUyyRZm6lHnT5gsmM5AypP+vlbMEc+PAaoEshpl4NP8f/01FPS6wac5X
 W8A9BMJfHDJGMFS7hqFIhlTWYCfBvRhOQZL2GKzrLxac261hMn/qi3ivshQIikTTuv7E
 G+DY1LWmk4/1Kq1HLf8UDCqRgQXpMqiIARvyaqbJgWdlNxGDIAvggQJsxJCcF3FnoAMz
 ap1GbE8c3wD6vv9XYsUnFZm++RdLLWzVRUVQwJ8dfcVUTdjlRcUG+1VYw3WbAoO4eCt4
 Cj84gdgvptxA1fV8y5iycKg7Ndlnz3hSA69Z42rpSmyQ8SUxo/6mf7YOCD/EUMENswo8
 sCKg==
X-Gm-Message-State: AOJu0YymCcMj/unPdilLweRx34O2j1yyitzGCcNrNj8LMa8RcSHWZ5nM
 0GZ78zyg29PbI/FmHTOylO6APD+8xNhjZ+SwKolOOIwIw85nz2MI80Qy87JMIpc+VRbz2OrvfeW
 lY4PEvKIofctgRx3omIwGMhPQZprrAGDrTKWB12cxUSy+8gg7vSfzMSBi3mN6RDNU7Iww7wmBXj
 bYKIik98rS2lCsNAJWOO6SC31KRdrFdTGu8jIoe9j3
X-Gm-Gg: AeBDieus0KDkLulJS3TymOemwA8iPdnt/ycQFbIw+Jbeq9H5jwen+W+uAqlQ5STmwGL
 1GNQRucC1Bq0FD8WvfHiJpIaR7HDjHsYp2pH1QrtYMFHKrTMXDzs9KV6fkEbtM0GJ5zmr/DiOSa
 6Zqc1MkPsOYvKqig8i1uasrYu37xp8gRXV5Ov43IiqWtPXcmBbUU8rIN83I31HHvsWv7JgIctpb
 i1/4dKxrGTE7qGo4zJGhXbswESz5/HBa39Q/Jgu0AxqQ1tpEJ+pWgR2qpTaPqZedsRMcUXjTI5p
 LWeyPKKNUhCaSwG+EB4mcmSMQxr1wKG8oV4ep8SQRYbdeDnrsJOtPPxri77Jnh7Mz9SYawrd3Yw
 C/tpuzN6Ha25R1GtNCVb/TKR5yfd6EeIWhApkosUW1/95hvHAZYYA9ecxLAmqgDsNwRS7+yyrKz
 JDaSwj5tA3NZVXrlms1rIujLqI5AReZ9z4B+0=
X-Received: by 2002:a05:620a:4627:b0:8d0:191:69b5 with SMTP id
 af79cd13be357-8fab2140c16mr479873585a.54.1777569740314; 
 Thu, 30 Apr 2026 10:22:20 -0700 (PDT)
X-Received: by 2002:a05:620a:4627:b0:8d0:191:69b5 with SMTP id
 af79cd13be357-8fab2140c16mr479862885a.54.1777569739527; 
 Thu, 30 Apr 2026 10:22:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fbb0fe8572sm25554785a.14.2026.04.30.10.22.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:22:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/58] target/i386/tcg: simplify decoding of 0F 38 F0...FF
Date: Thu, 30 Apr 2026 19:21:09 +0200
Message-ID: <20260430172204.1006673-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

These lines are shown in the manual with a weird representation that
confers a special meaning to 0x66 0xF2 prefixes.  In reality, this is
just the CRC32 instruction (chosen by 0xF2) plus a data size override
prefix.  All other instruction in the range that use the 0xF2 prefix
are VEX-encoded and therefore they do not support multiple prefixes.
Because of this, it is possible to handle the four prefixes normally
using decode_by_prefix; the 0x66 0xF2 combination for CRC32 is handled
naturally by the "v" operand size.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index c8b5bd6ad26..ac181308ca4 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -873,8 +873,8 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
     [0xef] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
 };
 
-/* five rows for no prefix, 66, F3, F2, 66+F2  */
-static const X86OpEntry opcodes_0F38_F0toFF[16][5] = {
+/* four rows for no prefix, 66, F3, F2 (including 66+F2 operand size override) */
+static const X86OpEntry opcodes_0F38_F0toFF[16][4] = {
     /*
      * MOVBE and CRC32 are incorrectly listed as always doing 32-bit operation
      * without prefix and 16-bit operation with 0x66.
@@ -884,49 +884,42 @@ static const X86OpEntry opcodes_0F38_F0toFF[16][5] = {
         X86_OP_ENTRYwr(MOVBE, G,v, M,v, cpuid(MOVBE)),
         {},
         X86_OP_ENTRY2(CRC32, G,d, E,b, cpuid(SSE42)),
-        X86_OP_ENTRY2(CRC32, G,d, E,b, cpuid(SSE42)),
     },
     [1] = {
         X86_OP_ENTRYwr(MOVBE, M,v, G,v, cpuid(MOVBE)),
         X86_OP_ENTRYwr(MOVBE, M,v, G,v, cpuid(MOVBE)),
         {},
         X86_OP_ENTRY2(CRC32, G,d, E,v, cpuid(SSE42)),
-        X86_OP_ENTRY2(CRC32, G,d, E,v, cpuid(SSE42)),
     },
     [2] = {
         X86_OP_ENTRY3(ANDN, G,y, B,y, E,y, vex13 cpuid(BMI1)),
         {},
         {},
         {},
-        {},
     },
     [3] = {
         X86_OP_GROUP3(group17, B,y, None,None, E,y, vex13 cpuid(BMI1)),
         {},
         {},
         {},
-        {},
     },
     [5] = {
         X86_OP_ENTRY3(BZHI, G,y, E,y, B,y, vex13 cpuid(BMI1)),
         {},
         X86_OP_ENTRY3(PEXT, G,y, B,y, E,y, vex13 zextT0 cpuid(BMI2)),
         X86_OP_ENTRY3(PDEP, G,y, B,y, E,y, vex13 zextT0 cpuid(BMI2)),
-        {},
     },
     [6] = {
         {},
         X86_OP_ENTRY2(ADCX, G,y, E,y, cpuid(ADX)),
         X86_OP_ENTRY2(ADOX, G,y, E,y, cpuid(ADX)),
         X86_OP_ENTRY3(MULX, /* B,y, */ G,y, E,y, 2,y, vex13 cpuid(BMI2)),
-        {},
     },
     [7] = {
         X86_OP_ENTRY3(BEXTR, G,y, E,y, B,y, vex13 zextT0 cpuid(BMI1)),
         X86_OP_ENTRY3(SHLX, G,y, E,y, B,y, vex13 cpuid(BMI1)),
         X86_OP_ENTRY3(SARX, G,y, E,y, B,y, vex13 sextT0 cpuid(BMI1)),
         X86_OP_ENTRY3(SHRX, G,y, E,y, B,y, vex13 zextT0 cpuid(BMI1)),
-        {},
     },
 };
 
@@ -936,15 +929,7 @@ static void decode_0F38(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     if (*b < 0xf0) {
         *entry = opcodes_0F38_00toEF[*b];
     } else {
-        int row = 0;
-        if (s->prefix & PREFIX_REPZ) {
-            /* The REPZ (F3) prefix has priority over 66 */
-            row = 2;
-        } else {
-            row += s->prefix & PREFIX_REPNZ ? 3 : 0;
-            row += s->prefix & PREFIX_DATA ? 1 : 0;
-        }
-        *entry = opcodes_0F38_F0toFF[*b & 15][row];
+        *entry = *decode_by_prefix(s, opcodes_0F38_F0toFF[*b & 15]);
     }
 }
 
-- 
2.54.0


