Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB62FF60D8
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 06:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7T3h-000375-1D; Tue, 31 Mar 2026 02:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7T3f-00036l-HQ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7T3d-0001KS-K8
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774940316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2ZUJNaxOsCTBLh08NnJ9ojiTGlUxdcHds8nirOg4kP0=;
 b=Ckye4ylCoqswuWZZnBI85Rq/pOa7TT7CLobWX4FPN6NR25gH3ljuY01g6NW5XWQlACqfmf
 rzNUcID5zePGYAK2EQMQA3oEAai8lESvreoWRtTuqyqAIl2HYY4ZXNCg0WnMS6Vrxp/anH
 V3noZCZ7RhEmZl2HyWgJzEsKxmsPlQA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-J2cTbLF7P0y1wdyTi4bHNA-1; Tue, 31 Mar 2026 02:58:35 -0400
X-MC-Unique: J2cTbLF7P0y1wdyTi4bHNA-1
X-Mimecast-MFC-AGG-ID: J2cTbLF7P0y1wdyTi4bHNA_1774940314
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-487018c8244so34371995e9.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 23:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774940313; x=1775545113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2ZUJNaxOsCTBLh08NnJ9ojiTGlUxdcHds8nirOg4kP0=;
 b=aeKUya/tFgiQRhEVRNFaeSTTltiZNtNBrHmoAgE6OSr9mtEjBOm2/aDfOemCZxFZ0i
 NToo1CNPTkml3GIB2cU+q8CmA/im2X8tqRMfJAagTHrEHgVaBmRBDAZQTNyTbMUyhQCc
 /ibIVEdVp66oer561z1GpKnaDF94hG1/lvZLIDrIG42E7bY0e6rph6hR6lno2agG+PKH
 9N6H28p9seX2PKRUudY9/4W39gV6vsFJT4W9A4umgX4KsBSb1WfKKqO72SOrlNmS+7fW
 wbPCzbf8hiqds5zloTSMmIdpO6Lo183ZOWfR8G84OEXaA8ywluAr9bb4N8XPRkM5Wx4x
 mH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774940313; x=1775545113;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ZUJNaxOsCTBLh08NnJ9ojiTGlUxdcHds8nirOg4kP0=;
 b=BtdFnvrwDZaBw7FDADBVJa61RmNNtNeNodnsAxcAPJeVN6iD+rmOZmERFoqqAU/2KM
 H+1rkRxj+OqvAygZ3Zp2N/a36jam83mcpeMzxMuUuXyMOPbh3Vy8jlcdZfa4hm4v2dyk
 QVQpKlf3MxLZ1+VFCIqoMEbLOYNN4xCmTtgbzPgkdFRV7fsyHMpWA9zhZRbTU7upF8Cf
 EQDww8pmscc119mOq8dx2L1Oz0Brnt2SkjVsHI2r9PAF80B77lS/pHbfK9zyH7BjZgqn
 iNizCjgbCvMjYaJ4RovfsAiphKoU6H5ElMD2Thzy4xIQ2A3OtaY6QVws/Gp4zXsmDow0
 y2ag==
X-Gm-Message-State: AOJu0Yy4VngPsmQNGtH8FfFwKxh4s2lpTeC9rRgxQEt9pUzKhL/wBwgP
 rnqr2QFArZmM25l72/TZPpVNShrgLzv6UIYHx6sfjn+atPPTB7LIsD3uIoj4JNjTybQJCuVawxE
 eTC2DzzKIQPal+iDqfrdQxJWnVOVFftfQLv4GG/W2TY063PvuzzCkOAAYHoiuEpVTFvi2RYLHoB
 XwIZ7mYxGhSMS+5gnlB78XcZqR+UI0UZ7aIsb1Lwxp
X-Gm-Gg: ATEYQzzHnYy5APKU6Dc+SXqLYpj3UERmEQIMjmGKV+ta5R0xNaqPRN9GK4ERoypAu7h
 cPhUyS4zjU0kwn4Nxruv8hJZSfei5Q0Kg5f23rKaSUNYrVpylTjLB/PHXei11oJ185BbQ4JZW+m
 KUuZ7aU5A5QIg3qRVk1Ntt7+ThEomR3mfV3tPpEjkYwx8ame2D0FCDNe+GODw1J1bvzumkTlqbj
 cmpPFHYs6tM58BDK1zhhyors2bop/PKUyqYo0NyE5TAkeRiAG3RFBuxvhrbBENiWupbtQctR+uA
 YTK1ypYkY7Pz6HCC25y1jyRhhRvfWzUcPYU0/CGTDVakDhjl8uOvNNacLSmbRg+4ABP8m9QFZdX
 spWCPjTbvqz8ctU9ns7enPgxnzIr6KP+tcYnPCcjJ58AppSV2ciq+IJn3/JYcZKEOuK7cYunAh8
 ByVCEeQ2oV+8K2fCymyOOTLHEm
X-Received: by 2002:a05:600c:4fc9:b0:485:2fe9:336f with SMTP id
 5b1f17b1804b1-487280ba3a8mr240440825e9.30.1774940313472; 
 Mon, 30 Mar 2026 23:58:33 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc9:b0:485:2fe9:336f with SMTP id
 5b1f17b1804b1-487280ba3a8mr240440425e9.30.1774940312841; 
 Mon, 30 Mar 2026 23:58:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21f173dsm28238720f8f.15.2026.03.30.23.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 23:58:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] target/i386/tcg: fix decoding of MOVBE and CRC32 in 16-bit
 mode
Date: Tue, 31 Mar 2026 08:58:31 +0200
Message-ID: <20260331065831.423094-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

   67 F2 0F 38 F0 02             crc32 ax, word [edx]
   66 67 F2 0F 38 F0 02          crc32 eax, dword [edx]

versus

                                 bits 32
   66 0F 38 F0 02                movbe ax, [edx]
   0F 38 F0 02                   movbe eax, [edx]

   66 F2 0F 38 F1 02             crc32 eax, word [edx]
   F2 0F 38 F1 02                crc32 eax, dword [edx]

The instruction is listed correctly in the APX documentation
as "SCALABLE" (which means it has v-size operands).

Cc: qemu-stable@nongnu.org
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


