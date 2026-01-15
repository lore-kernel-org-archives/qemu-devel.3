Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7AED41171
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 11:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgLbg-0002i8-VK; Thu, 15 Jan 2026 06:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vgLbT-0001rD-Oi
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:33:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vgLbS-0003yy-9e
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768476801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WtT97AhDNUhLb3iJdTChN/XGeNrYbFEBZVOX0BIlrhk=;
 b=TBfxLzcEEgiCAlSNSt9ygS9n5FeaVIpUzhWvV7zkvTZQERRKRa0yaKamgAv5lnYdhjTygE
 mSOGD5B2Zt9Gq1x/bNaLsqfPdtOHjsd5fW3a4g+4Q88Ct5xF4dpk3SX7lvN8Hl2wFhDpFY
 9szBTDGTCYCOeC7VztL00lmOjQyIJ34=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-LTd4-1GdOper9F1NIk3pHQ-1; Thu, 15 Jan 2026 06:33:16 -0500
X-MC-Unique: LTd4-1GdOper9F1NIk3pHQ-1
X-Mimecast-MFC-AGG-ID: LTd4-1GdOper9F1NIk3pHQ_1768476792
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430fdc1fff8so480728f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 03:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768476791; x=1769081591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WtT97AhDNUhLb3iJdTChN/XGeNrYbFEBZVOX0BIlrhk=;
 b=oQiDNGkRomdXsomp6WoBhg177qHPRg4KVntpUDkA/HOVgFrMAzpGaPzVS8TvqbBnJz
 a+qjaRFIS/MYdJ7RtcU+x7N4SJjY03OHw9pQVSEsI88CYXih+H0+6QPHmPtgE2dX5Kfq
 sjcnF1ebK+NvVh+QQ6HVE+Sbyg1jn6qxSbeyNJV/SArBz5dwp+np6PN6DM3Cxe5r4b5R
 uoDk5po/Sp+Tr2PhrwhZL58M0fpfJCnRhX5aQDYZT5PAWU/z63dyIAPaVGz/ZA20w9g4
 QP5pwvu1hv0wE44MCYjVX6wlQ0lymJtIECp37jxCaOHrWl60gOH2monePJE2K/B1cn7e
 2Z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768476791; x=1769081591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WtT97AhDNUhLb3iJdTChN/XGeNrYbFEBZVOX0BIlrhk=;
 b=VXEg9zuXgcjzz0VlZHrC1ZVturcLDogqvNUUB/871wniXv1Rw9+wwxSCrCcBi5XStY
 Ty/LHnZQSS27DndEPNCGghFGUzApnwfHPJHJRBdTVRSL1i6gxTz4HTfZDtCmPpawyMv2
 zOC+kuqQ+8IDThS3vn5aqVOlhVy5zZH8TysMtrQ+CZQIQKqBk10HYuY1Wbu6WOvGBCE6
 7bxe4k86io52G/JihZJG20fs/TMraHaAwDVcZuxhiO8a3+/IO/OIcyxGVC8xOO7nKVLF
 3IhwzjirA+F/tI2Mz8Pp3nrjGPiW61GMsfoxA2ghRu1qehdwdzvlrUyvSbK7rACX2937
 GW9w==
X-Gm-Message-State: AOJu0Yz2BnJ6Ghn21qtLKOhVj51wZhIAuvkW+KjvkpGQcj/V/pzT/UJ1
 ZzNcvzY7UCiFcJzvoVVXPYMapkXNqnS+EOeHMjag4XHeRfE2RiXUG+mjc3yai5IVsjHiUpktDqZ
 zc7YaI530y8PcJ5BgxTk0sdVIoOmvks3SaLW+J4zwGvPesVJeeRqASzfUzNscJdZgT5SnRCUiSo
 MskFeB5SivTi/XuF/qVfl5mon5Q6iKxPg+ZNWNtODX
X-Gm-Gg: AY/fxX4cc/5jxzypTs6G0VDGhw1QbQImFBEP8gIq3tZhn406J9jmA/O5gqm67gGXvHg
 Wtlj4xW86vSdyzdnDHEp0fW9oraCug7bka5/lxFoItTWptNxIs0+mloaBDo3YSwe6f3ICJeKwjr
 pGQbBK+flAzuHFZocmr1gDgcKjqT6ypqyDROO4kVNwj1+CQg7uld/1MlLYf1+2IDVDie1Xlucwi
 gZpycBS6cn+YZaca5X8/ed7Bd3I41WIL2nDfyMhhepg14jJ9lp0Nv0WoMSD4ZJaIV6yeBgZFY0y
 Xvu3jIlivu32iIxvYs1TxoM0vLgMHPVHjCEtwaDaFAqoYujPoS7b2E+iXvCCganyIW6ndAxv2Jt
 lGtY6jIi9OqpNB/FdDid1htvEZewN5e8c9UYwzT0WoDtMr4WmAbWFN53bh//btdFL8RwdWMwoZT
 I+7HuE2JeDIOx0Pw==
X-Received: by 2002:a05:6000:3106:b0:42f:bab5:9533 with SMTP id
 ffacd0b85a97d-4342c4f9c46mr6929830f8f.17.1768476790693; 
 Thu, 15 Jan 2026 03:33:10 -0800 (PST)
X-Received: by 2002:a05:6000:3106:b0:42f:bab5:9533 with SMTP id
 ffacd0b85a97d-4342c4f9c46mr6929790f8f.17.1768476790193; 
 Thu, 15 Jan 2026 03:33:10 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af6d9039sm5479938f8f.30.2026.01.15.03.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 03:33:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH 1/6] target/i386/tcg: fix a few instructions that do not
 support VEX.L=1
Date: Thu, 15 Jan 2026 12:33:01 +0100
Message-ID: <20260115113306.126905-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115113306.126905-1-pbonzini@redhat.com>
References: <20260115113306.126905-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Match the contents of table 2-17 ("#UD Exception and VEX.L Field Encoding")
in the SDM, for instruction in exception class 5.  They were incorrectly
accepting 256-bit versions that do not exist.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 09e3d8884cf..e44b92710cf 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -628,7 +628,7 @@ static void decode_0F7E(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     static const X86OpEntry opcodes_0F7E[4] = {
         X86_OP_ENTRY3(MOVD_from,  E,y, None,None, P,y, vex5 mmx),
         X86_OP_ENTRY3(MOVD_from,  E,y, None,None, V,y, vex5),
-        X86_OP_ENTRY3(MOVQ,       V,x, None,None, W,q, vex5),  /* wrong dest Vy on SDM! */
+        X86_OP_ENTRY3(MOVQ,       V,dq,None,None, W,q, vex5),  /* wrong dest Vq on SDM! */
         {},
     };
     *entry = *decode_by_prefix(s, opcodes_0F7E);
@@ -693,7 +693,7 @@ static void decode_0FD6(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
 {
     static const X86OpEntry movq[4] = {
         {},
-        X86_OP_ENTRY3(MOVQ,    W,x,  None, None, V,q, vex5),
+        X86_OP_ENTRY3(MOVQ,    W,dq, None, None, V,q, vex5),
         X86_OP_ENTRY3(MOVq_dq, V,dq, None, None, N,q),
         X86_OP_ENTRY3(MOVq_dq, P,q,  None, None, U,q),
     };
@@ -1102,7 +1102,7 @@ static void decode_0F12(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     };
     static const X86OpEntry opcodes_0F12_reg[4] = {
         X86_OP_ENTRY3(VMOVHLPS,  V,dq, H,dq,       U,dq, vex7),
-        X86_OP_ENTRY3(VMOVLPx,   W,x,  H,x,        U,q,  vex5), /* MOVLPD */
+        X86_OP_ENTRY3(VMOVLPx,   W,dq, H,dq,       U,q,  vex5), /* MOVLPD */
         X86_OP_ENTRY3(VMOVSLDUP, V,x,  None,None,  U,x,  vex4 cpuid(SSE3)),
         X86_OP_ENTRY3(VMOVDDUP,  V,x,  None,None,  U,x,  vex5 cpuid(SSE3)),
     };
@@ -1465,7 +1465,7 @@ static const X86OpEntry opcodes_0F[256] = {
     [0x6b] = X86_OP_ENTRY3(PACKSSDW,   V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
     [0x6c] = X86_OP_ENTRY3(PUNPCKLQDQ, V,x, H,x, W,x,  vex4 p_66 avx2_256),
     [0x6d] = X86_OP_ENTRY3(PUNPCKHQDQ, V,x, H,x, W,x,  vex4 p_66 avx2_256),
-    [0x6e] = X86_OP_ENTRY3(MOVD_to,    V,x, None,None, E,y, vex5 mmx p_00_66),  /* wrong dest Vy on SDM! */
+    [0x6e] = X86_OP_ENTRY3(MOVD_to,    V,dq,None,None, E,y, vex5 mmx p_00_66),  /* wrong dest Vy on SDM! */
     [0x6f] = X86_OP_GROUP0(0F6F),
 
     [0x78] = X86_OP_GROUP0(0F78),
-- 
2.52.0


