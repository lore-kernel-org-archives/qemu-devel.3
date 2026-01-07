Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16298CFD652
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 15:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdVFK-0007vh-MU; Wed, 07 Jan 2026 10:14:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdVEn-0007mQ-Ia
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 10:14:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdVEk-0007Nn-6E
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 10:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767798851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ML8OL3iKvgCC+Xcm6fSbC6KGxridnBQyXVL/pHGenBk=;
 b=Mue48PhM3pVn1A0VQ8CXf7fIoOkfkxpzwE30nI3ezfDc2b0S+8DGQtIFTiM0POWiByuWDs
 vDkvAniRRfbENf9TCuzcoxGQexj2TzDBRffXhs5Urt5uQzrM/hHKMg5xzDvjAnIiY9QT8E
 SwRE5Qk7s2AsgSLZYdI4221KlxsvHL0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-Jv8KUbk2O1WofMJi5vbPXg-1; Wed, 07 Jan 2026 10:14:10 -0500
X-MC-Unique: Jv8KUbk2O1WofMJi5vbPXg-1
X-Mimecast-MFC-AGG-ID: Jv8KUbk2O1WofMJi5vbPXg_1767798849
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477cf2230c8so20306065e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 07:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767798849; x=1768403649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ML8OL3iKvgCC+Xcm6fSbC6KGxridnBQyXVL/pHGenBk=;
 b=mm/h9T2mwm+AYDY9axs9xy6X9xUuQ8N8yiEVA1dPGcWab5rG8iHUGgic9SyMpPHinf
 O8v5nuffH8nmhHImkxgM0519i4lm00S4eo/sDrksoK2QQDOC00RI1z1QnAIy8AH+35ji
 zP6FTnfydMlr18eejZlH4HelEd2MfosQh5yQhYdEmuXPfO2YVfwhqftK1ctfn9MKpzbq
 6r/Eoy2L91x3KKZoTu/q5H/xMU8XkCb2aCdtQc/Kvi4nWaahe85shQ5IePRurZiQoGXt
 MmmRG+n5MHCkQdyCkRoHcYQm2RsPfIabrXdnJ0C6REavUXj8VmWt05tCk/glLsa1Y4a6
 6jEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767798849; x=1768403649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ML8OL3iKvgCC+Xcm6fSbC6KGxridnBQyXVL/pHGenBk=;
 b=TUnBRd1Qx1mtrq3PVs8n4iHGKayzP+kjOwHB4QtM+FPl+Ac/Phc+0GHnyuY32OKrwg
 4oveGt+ytORzQ35ZsvXIUWbXnx9ggXeokcPLElPdwCsXifoCAggH4hvH1OjUECLrlWr2
 QeZjn+W3OH7wmSfJ6Odyr1CgAuoUrVeAIcMzzXMEVaXnjeXh+dxBc1RJBpWJjKVf/Ukv
 JFPT+uC27TpQx5e8UEf6dKJreSXCrUBbzPgGV/dEbNs4Y3znuRMCMN431dQ1n7Xkl0z1
 +8YX19zXKrexxaBCTkPZRhc5YeC832OHCGMP0JeHB8tuwN/zfjNAI+yVjkTM00nxgalq
 FS6A==
X-Gm-Message-State: AOJu0Yznt+EpEa1Z3ZCmF+Ca/nXyRkTVewSBukbwNe4x6lpowhRIL54x
 khhlJU09UofIxW+pgC0nMmaoScO3uRhBnkuNudeZAxyf7grdTNLOImr0xAMZz3zlRvodZRh9P+j
 rbkRGGTeuX+UZZxNgjsoscIA5WsApfDC9dQasAYAOEh9/0Urx6xakPJOvsKJ1sC9oLWnEhY6V1R
 wsXQi52wZ6LOnJUBIFbb1JUxqeOVJJJhVpDqr0OO4S
X-Gm-Gg: AY/fxX7robVBuq17kQ9g2tf64kMWde6YWByEsI2tFjpxoh2C7mb2V7ht1raK4LrHcY3
 5o8KkyYaSsjDRE4gSGakIrl+cOIDt0IDY2MPxzbiwo+h1lRFWYYGLbWr82qRgb3z2ZLKEFjzgUQ
 K8idKoisnLvtkKlZMEXnAA/7pgkGbIaGEYqSbx2P5JszqqPip3DWSdWsPKsz0TLQvl/OSOfmNmH
 v5XX2PgBb1R18U6f/5neHkr+I+V1oZ3yhdM9u/pYpmYJT6+BAaTfGiJk1SgMfFW3XfRQkjiSzca
 oiRx96PHa/qYwq55+KFCzbuoxkdDKnlb+jn/49DdCNfn0W15q6M518w3qqOnIhcthOXYI9+Zew+
 tS8uvumIpGY+HsTARXpcqJTgAJx2GRs6Ekq0eGHxlmJYRUJazGsHx/wHJfI2xWmxJoFV+99zVmV
 5Wg7Xbv2Am45JL6Q==
X-Received: by 2002:a05:600c:45ca:b0:475:e09c:960e with SMTP id
 5b1f17b1804b1-47d84b38676mr34075275e9.32.1767798848610; 
 Wed, 07 Jan 2026 07:14:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZC+iCkA1gEdtHhCPALFp0EreNnpwCr+7E7vwLulZpwul8Ojd8pvMJuMzf6EfMcYytlOFbxQ==
X-Received: by 2002:a05:600c:45ca:b0:475:e09c:960e with SMTP id
 5b1f17b1804b1-47d84b38676mr34073995e9.32.1767798847155; 
 Wed, 07 Jan 2026 07:14:07 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d87166d0csm14722455e9.6.2026.01.07.07.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 07:14:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH 2/5] target/i386/tcg: do not mark all SSE instructions as
 unaligned
Date: Wed,  7 Jan 2026 16:13:57 +0100
Message-ID: <20260107151400.273916-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107151400.273916-1-pbonzini@redhat.com>
References: <20260107151400.273916-1-pbonzini@redhat.com>
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

If the vex_special field was not initialized, it was considered to be
X86_VEX_SSEUnaligned (whose value was zero).  Add a new value to
fix that.

Cc: qemu-stable@nongnu.org
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


