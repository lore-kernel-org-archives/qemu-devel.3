Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E6BD0C854
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 11:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfcLS-00035a-My; Tue, 13 Jan 2026 06:13:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfcLM-00032f-44
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:13:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfcLK-0008QB-Iz
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768302826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qb23EgjldeXXapw9SozidlWY2AOWRUGUm7lYmmpRkOQ=;
 b=EIs9h6AMZ/XXjeD4aHRi2EgiVQ2RiXugsLpejaObIicueAi8tchEnB/QyeBdKIrR/CGyN5
 uNPCN6HQNPg2xXW1WErQjlXclIzleRQxbrNlg6vNmMnuC6Rbb1U8V8TpowCTQqUDSpzKY8
 Hh3M2gNMDYovhwcnUoZ6O2KNPmQC6tM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-FptF3foFOB2wR6I9Dg47vQ-1; Tue, 13 Jan 2026 06:13:44 -0500
X-MC-Unique: FptF3foFOB2wR6I9Dg47vQ-1
X-Mimecast-MFC-AGG-ID: FptF3foFOB2wR6I9Dg47vQ_1768302823
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4325b81081aso5974801f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 03:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768302823; x=1768907623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qb23EgjldeXXapw9SozidlWY2AOWRUGUm7lYmmpRkOQ=;
 b=ZftsRuuuZDd8k/+lfvPiWxt6JuR0+2aukKpmYcFoaf/beCP0lVmIgjdrbrTTTtrI+p
 Af2OM4P1ckrqOvR0e2LJOFEFIC7A1GUwZy25H0uYUMb5NBrsNH8QPRqrk91TiKBZB0oE
 OQt+2/tymn2yvAGdRZ38896V5AddLhSss27KgirUPRp5lcdbFOksIF74sg+kx2BTsntH
 r69K4P+vyjbF5jGAbd5gJ17r+3664At4DouT2lZQ8UjfSFktSiuHAWYh0ztqmsa130ZH
 d27f7+q78BPZGRYnS1dojSH6mc2to6c7q89jN7jTijFmAWRietcpBIZtaJ+mztAT/d5o
 g+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768302823; x=1768907623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qb23EgjldeXXapw9SozidlWY2AOWRUGUm7lYmmpRkOQ=;
 b=HprBlESCloVo7UzTDw9HiHrnxib8ZvUAvju2dr9fKX+qduOxPcs1kzJ3EDie0qqvJj
 kiA7Lm+qYhZheSjwCkpbq/AKkHDv5HFJAd+ZADKuHPei5to2LdQeykZhfR/zx2ibAskB
 mgFBd6JjDG+8IXuzsm9neJwkYIgQStceaJMcb8J0yEfcc9bQ5Nk3QPUTygxwVqZqQozZ
 S+D1Zooi1Gq/csENuHv/WrpdRRCAt78/1wit3hIugGdYQ6QKLUu/8Uh/Iv+DMkW1esUM
 9YVfpbMy5BvprttEEoy/OYOHl4BH7TQUTAFXMZAzclDuXnOz/2tyXa4SbDTCFxBxMrqt
 sk0Q==
X-Gm-Message-State: AOJu0Yx0kiFjAEckdAIBpjW4F7k9doJNICq2Vp0ZLNt3+zhi15MU7GyL
 8t0HzzE3vECK3m3Nh8r11q+kugD7a97WUO096WgeAnFq2+/mErimB4Qu90hYWQTJR8fZczPgVkF
 kJFPVEuHhDhWQZg7A3dCsmDqfMj2IxPJwYZt6rBYNrCNCYobWTHcn2cT0X8mN4UabI+VXGs4ajE
 LYFlK9tTAA/iCm8B5O4MvOXuzGd97ogmZ+78GjaDSc
X-Gm-Gg: AY/fxX6Dnh5OhEBUVNKPwLWJ95+LFMD7ECv3IKpdZyCdZt5KmLea2RXShcgoR4+rlAP
 wzpVeWAEVk2Y5/5c6j4Qr0BFg2+vJJjyHYpEQHToDrybx89T8DaFu/aW77cEDwvnHBGkRxpl0kQ
 OyokPauc30elpyMrnjC9tLTMx7hpakhQ3M7orlos61EVENkXRGS1Gv0+ph7LyiSH5V4/qlybNR9
 BSp6z+CziU9d0LJzYaIve4ezvGpJ/RGxW0MgWAE7iYx1HL2HQOLw6tWiqGKjwlVjY7wVyxfyd8O
 Z3EbWfs+bcpYN3/hQqJfTuociIhQQh5r7dTaFacfeT+g/kQTVTJ8BKDAVQ+ZqUi11QCRiTiKNuM
 ta9AyxAx04kFrU9vT5O39tOlOV1ZtGdGI/85QdVIrY0NBSZ1CBRGEw/HAS4+xZotfniPUVzCbxt
 5xqPGx7tfMqy1jWw==
X-Received: by 2002:a05:6000:18a6:b0:42f:f627:3aa3 with SMTP id
 ffacd0b85a97d-432c37a752bmr25807457f8f.56.1768302823083; 
 Tue, 13 Jan 2026 03:13:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8Jf2FAuIq3elFQsjFEMmOq3UMXTL7D0/wN+J0uQ2wkxC5cXwMa9BfxSyzu5etwFiZyzUr1Q==
X-Received: by 2002:a05:6000:18a6:b0:42f:f627:3aa3 with SMTP id
 ffacd0b85a97d-432c37a752bmr25807423f8f.56.1768302822598; 
 Tue, 13 Jan 2026 03:13:42 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432d286cdecsm29960138f8f.7.2026.01.13.03.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 03:13:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 3/7] target/i386/tcg: do not mark all SSE instructions as
 unaligned
Date: Tue, 13 Jan 2026 12:13:29 +0100
Message-ID: <20260113111333.1138160-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113111333.1138160-1-pbonzini@redhat.com>
References: <20260113111333.1138160-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

If the vex_special field was not initialized, it was considered to be
X86_VEX_SSEUnaligned (whose value was zero).  Add a new value to
fix that.

Cc: qemu-stable@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |  2 ++
 target/i386/tcg/decode-new.c.inc | 11 +++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 7f23d373ea7..92822969003 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -242,6 +242,8 @@ typedef enum X86InsnSpecial {
  * section of the manual.
  */
 typedef enum X86VEXSpecial {
+    X86_VEX_None,
+
     /* Legacy SSE instructions that allow unaligned operands */
     X86_VEX_SSEUnaligned,
 
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 9d3a7c0d426..f662364c600 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1068,15 +1068,15 @@ static void decode_0F10(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
 static void decode_0F11(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
     static const X86OpEntry opcodes_0F11_reg[4] = {
-        X86_OP_ENTRY3(MOVDQ,   W,x,  None,None, V,x, vex4), /* MOVUPS */
-        X86_OP_ENTRY3(MOVDQ,   W,x,  None,None, V,x, vex4), /* MOVUPD */
+        X86_OP_ENTRY3(MOVDQ,   W,x,  None,None, V,x, vex4_unal), /* MOVUPS */
+        X86_OP_ENTRY3(MOVDQ,   W,x,  None,None, V,x, vex4_unal), /* MOVUPD */
         X86_OP_ENTRY3(VMOVSS,  W,x,  H,x,       V,x, vex5),
         X86_OP_ENTRY3(VMOVLPx, W,x,  H,x,       V,q, vex5), /* MOVSD */
     };
 
     static const X86OpEntry opcodes_0F11_mem[4] = {
-        X86_OP_ENTRY3(MOVDQ,      W,x,  None,None, V,x, vex4), /* MOVUPS */
-        X86_OP_ENTRY3(MOVDQ,      W,x,  None,None, V,x, vex4), /* MOVUPD */
+        X86_OP_ENTRY3(MOVDQ,      W,x,  None,None, V,x, vex4_unal), /* MOVUPS */
+        X86_OP_ENTRY3(MOVDQ,      W,x,  None,None, V,x, vex4_unal), /* MOVUPD */
         X86_OP_ENTRY3(VMOVSS_st,  M,ss, None,None, V,x, vex5),
         X86_OP_ENTRY3(VMOVLPx_st, M,sd, None,None, V,x, vex5), /* MOVSD */
     };
@@ -2624,6 +2624,9 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
     X86OpEntry *e = &decode->e;
 
     switch (e->vex_special) {
+    case X86_VEX_None:
+        break;
+
     case X86_VEX_REPScalar:
         /*
          * Instructions which differ between 00/66 and F2/F3 in the
-- 
2.52.0


