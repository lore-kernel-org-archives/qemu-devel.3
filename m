Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D84D19515
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 09:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfXw-0000me-59; Tue, 27 Jan 2026 04:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXm-0000gm-JS
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXk-0008Ud-0q
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769506766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TLcvh1Gbzq7JQhWWprLKhfjY3EqWo/Phz+itTE6VFOs=;
 b=UoQxUPlM8SZn+fGzmmGfQKfAdksfLjyVahlDHlOGjEoa116Dcr+mj1V2iLOJ8jjzI+tihc
 /K4Z2lgZPatEgW/n5jtnpY0djXi5U8sh8Li/0wXx1C9GMivEKToPKE782ScCJwIcoKSbqM
 AIOkHpEqg2f9Xy7uTIi40Qmmnnz2sRc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-Y8M9jT0IN-W3T1s3kHUsDg-1; Tue, 27 Jan 2026 04:39:25 -0500
X-MC-Unique: Y8M9jT0IN-W3T1s3kHUsDg-1
X-Mimecast-MFC-AGG-ID: Y8M9jT0IN-W3T1s3kHUsDg_1769506764
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48069a43217so4202255e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 01:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769506763; x=1770111563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TLcvh1Gbzq7JQhWWprLKhfjY3EqWo/Phz+itTE6VFOs=;
 b=CR6yya5xoazZTl0/76SXhk78BKizXU/SSH+NlT+T/Tp+ES1UQUgDIqAo6fgYD8UCCY
 wn0nf47+Iyc4DONifwGE90WMq/JauWARt43B7vgEQn7hRbhbc2YhRH/qXmb1ngntIDv/
 yadfXoGM3B3HR5QWH+cMdQ8vsz5GSMbdcFcdPHNl+eSDrNpEmA3NoJaqEdaSSfJJ7pkA
 cLoP3RhJN48cKOhVO613RIcR0Q8H5VU3YrvLa2MgtlwwMHkFga3eLjDPzVYsh15Kup0u
 5mq51M6/vG/UJBqxqwbYa34f2g/+8m3JfKtGQtBGebELapwvPfqMbmZVrnJhq7/FGCJJ
 2ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769506763; x=1770111563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TLcvh1Gbzq7JQhWWprLKhfjY3EqWo/Phz+itTE6VFOs=;
 b=CYU1NUg5GWX69l/KwPkvB2RPWepZRE4YdSkMNjj6vQa2WLyESTC6y2w42L9/8HnYc8
 t1/iqqsJ+Y2SRvK3TJMahSEdTDUboNx5XaVKYkSzZatWAJlaqbPbWftilLen65pW/yJX
 0Qqt4pFZTVsbbeb0zGEK3w8CuG8pTVM3lVoxqWWJ3QUmAK7s/fckE0otGor4KMXYhs3S
 joe8eNxY+JoNTm9JosxcOzWP5jrpCzvtmWNeoj3DuT8Bek8ltZ3yePlK0723G53Jvdub
 Ix4WpDpsaz/gG09BRa+q9k8yt1MiTpWevoTbc+2wNTNgI5z4//T7AznPNvGI1+1xlAIS
 nVUg==
X-Gm-Message-State: AOJu0YxbxW6svSlkqa6OypDwrY7haKvQH+Ms/9XUrH81YnFY+w6Q0ssW
 c8JuUcTcAZsAfjK/WI1qCyWb9PylklKjx1fAlNfIvv3APDhQqaf9x/Go3nhVgCGzV6ytslwa09y
 8WyBfR45lQ5YJM22823uiQBcJuEOLAZw6p71C+bFsK9Xfq9DYgD907PVRlLgbec+P3QH17zSZ8F
 6DJXVBOG7FaNNNWKWEwniALfSc7BVTRCLt8jjD1fml
X-Gm-Gg: AZuq6aKHgF2VH2u4uRAUnGpHHwQipi220lL1GzSkg91RbuJ0IrrWE5oqdRwihI7BE3S
 2D69E+asQUwtONSR1M2bgDbeEkU/jWGak3FiuWh5XsyWztcVNjHCKuOtr42C1VDOYTitquuDdES
 D/3NLsJSdoSQMRb4xlPKIL5yOvaHiMz9BRCxsSkkxUpk5QcdX7uONUrCkTqwwEI0hU3mILhbPH4
 2FrugCoc9l+R5w7FDlnvXlzVnWeGptzXbEjpkfgCefoFVsEnXEJXSHOfp89nwJBW5MImd+C0w4+
 /9qyFWtHrZBybbSnjj+Shlo6BXKPVPXfz1l8PsiA5Vj5eFUpOAoiujwMtX2RO2lQFpjCmEVHu14
 NF7/2gY0wu1n4jE496kgguFf9RfnrV4SIzN3wgntWLU4LunNkV4R0SQGezzLNrlHNvjsQqFxkd5
 waCaGZNqcc07bb9g==
X-Received: by 2002:a05:600c:820d:b0:477:7b16:5f77 with SMTP id
 5b1f17b1804b1-48069c3fa76mr13643245e9.3.1769506762994; 
 Tue, 27 Jan 2026 01:39:22 -0800 (PST)
X-Received: by 2002:a05:600c:820d:b0:477:7b16:5f77 with SMTP id
 5b1f17b1804b1-48069c3fa76mr13642915e9.3.1769506762386; 
 Tue, 27 Jan 2026 01:39:22 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c01783sm37555852f8f.3.2026.01.27.01.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 01:39:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/13] target/i386/tcg: fix a few instructions that do not
 support VEX.L=1
Date: Tue, 27 Jan 2026 10:39:00 +0100
Message-ID: <20260127093906.353741-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127093906.353741-1-pbonzini@redhat.com>
References: <20260127093906.353741-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Match the contents of table 2-17 ("#UD Exception and VEX.L Field Encoding")
in the SDM, for instruction in exception class 5.  They were incorrectly
accepting 256-bit versions that do not exist.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


