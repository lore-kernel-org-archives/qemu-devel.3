Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B40E8FDD8
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQwU-00017E-Mu; Sat, 27 Dec 2025 04:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQwF-0000sr-Nw
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQwD-0007L5-Or
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iJyEkR86rzlM/d8GgTLDqMukBuix21+dQiXIBZzjT04=;
 b=T7+RV9Di1NA0ZHwKJZGilbArLgqf+0Z/1llv1uHncFcbq27h9oManYfzqjuD8JkC0RBI22
 eIKGqFOSdD0yUj0Yq6KTLCe1LhBkbRz8Iu7zPahN16f6sgzhTUQYrnMNhnC9Zpl+oo86QX
 X6Dwc6eswSq79aZPx/RcvZjL9t/9FEY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-8efl6s5JPFeEEzoCBqmUjg-1; Sat, 27 Dec 2025 04:50:15 -0500
X-MC-Unique: 8efl6s5JPFeEEzoCBqmUjg-1
X-Mimecast-MFC-AGG-ID: 8efl6s5JPFeEEzoCBqmUjg_1766829014
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4779d8fd4ecso39609595e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829013; x=1767433813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iJyEkR86rzlM/d8GgTLDqMukBuix21+dQiXIBZzjT04=;
 b=dCmi980oNUO8rv3yPUBWBsLbzu8rf2J2u26Z2Z2+mt2EXu8efDaAkw1AbFEAflF10E
 dbDt8cJm/OJ4voz9W3lshb9Si21sIgUOtSV8hEHbrv00NYjOfUYJqw7JK9GD5k3rhBmi
 vX3R/YHdoVkYrJK0XWLxffyT/uLLQE575TgGzU/Fsv7vISltiyT4RHIvfgX7er5i2teJ
 4EPCUSffsqW6D/zEtNasEdprt8ZneL0soJWsEVR8FOxGPmJZ+ChYzlhj6aOn7x+q2eU/
 LnNfmii4YSG5pO4rGTWVAsLwJNvkIfg4qlK6mtC24e6LGTT3Ar7+RHEPiwGMpttu1b5A
 n8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829013; x=1767433813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iJyEkR86rzlM/d8GgTLDqMukBuix21+dQiXIBZzjT04=;
 b=uddOaDjSh3vgbWoaA9P4orXBGUZQhtim2GmDz+bRquiRg8zMT7YOAS+V0jXEWzrevk
 oEdHf3h7qUxdWDshwUppXqL6/1Ah9wWSc33wlic/kCKyrTSF+QYeoWgh7+9CtfF9cjSW
 uNMTCzGwGlWYcs95Qj/d/1IivwkaFbZeBxcsTf75Gw2H2CtCERM7tcRvxLn2hLQtUbxi
 MXnKbfm3Fx6dRUnZ0B265X0Kn59VKzRzxPCrWtHkpxiLOJHfc1L47SbwN4PBn/nn4sZh
 vgV9c2h0cUNka9ZJwOmJgmsnsePKMbkmfWbLTZGO0ZsSGI1MKQRzD0xlU63J9ighZEZM
 Ys2g==
X-Gm-Message-State: AOJu0YwJBzWiDWP1ZiyEzomW8Y7f/iK4aS0HokfxSo5F5nrpDU+tFwum
 0UoGnv5tXYb07yr7fXolbNhz3emEIX0hVR3Xj/ZWxRqnDMKtSAuRWYXytD2l0CUVK5FLpRqQYKY
 UN7+4HC4EZGxpG/ZdVLRju9G4B5ifdbOTl6tPuif754b5D8HUUiJvQD0ombOSPTvUGU7lhb37b5
 JPKPSaLPpITQDan9osfo3w0slXGfzdth8pUFyXE41X
X-Gm-Gg: AY/fxX73bOVKGiN0YSxOZ/RTPMLgUT5q5baiNPVUwe1PwosIG7/yQXf6DE1KlSEbLDY
 VPVXeg/yKAGmj76G5Ggky6fLjsU0kj4MUlNWTjlf8VbMeXIxt2jMGFsbM/wC0O+eutC1JGyKRjI
 QmJr4plEIZUrE1SdHxNBreDMp/t0ReDgT5YBhD1Zqp8EFBEely8xx315Aa2HyT1QyHOneAfJi+/
 my2D8h99DfkcI2DuEsvZtuenikY7dkBrkts5p1MFLm0V86ktu0WNfcYIax4qUlfUzkNVujjpp5d
 CZhsmrWm8A87v7VbEAEDaicPKaZYAF1xzRWY6nYPn9+n1x5FvbVTB0o8ribyjqYGgsO4BI5XBgo
 Nq9oEZIVUUfgckwkeX93w0sG4Q1wirOAigbSQNWpk5lzYQWn73iQlxIdF4jZhD4b8JokLqd4lgh
 yNo3YZFVNeNMv93xA=
X-Received: by 2002:a05:600c:4f08:b0:475:d9de:952e with SMTP id
 5b1f17b1804b1-47d18b83218mr274675995e9.1.1766829013547; 
 Sat, 27 Dec 2025 01:50:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZaKPzCKcLuF2mOYRYzhfgiDmh8r+Sn770aeozDEJghwuwFm6LXpOzuRo5A9H0WdWUgONamg==
X-Received: by 2002:a05:600c:4f08:b0:475:d9de:952e with SMTP id
 5b1f17b1804b1-47d18b83218mr274675755e9.1.1766829013171; 
 Sat, 27 Dec 2025 01:50:13 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be27b749esm489786665e9.14.2025.12.27.01.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:50:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 122/153] target/i386/tcg: simplify effective address calculation
Date: Sat, 27 Dec 2025 10:47:27 +0100
Message-ID: <20251227094759.35658-48-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Split gen_lea_v_seg_dest into three simple phases (extend from
16 bits, add, final extend), with optimization for known-zero bases
to avoid back-to-back extensions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 64 ++++++++++++-------------------------
 1 file changed, 20 insertions(+), 44 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 0cb87d02012..20cc49a9742 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -627,54 +627,30 @@ static TCGv eip_cur_tl(DisasContext *s)
 static void gen_lea_v_seg_dest(DisasContext *s, MemOp aflag, TCGv dest, TCGv a0,
                                int def_seg, int ovr_seg)
 {
-    switch (aflag) {
-#ifdef TARGET_X86_64
-    case MO_64:
-        if (ovr_seg < 0) {
-            tcg_gen_mov_tl(dest, a0);
-            return;
+    int easize;
+    bool has_base;
+
+    if (ovr_seg < 0) {
+        ovr_seg = def_seg;
+    }
+
+    has_base = ovr_seg >= R_FS || (ovr_seg >= 0 && ADDSEG(s));
+    easize = CODE64(s) ? MO_64 : MO_32;
+
+    if (has_base) {
+        if (aflag < easize) {
+            /* Truncate before summing base.  */
+            tcg_gen_ext_tl(dest, a0, aflag);
+            a0 = dest;
         }
-        break;
-#endif
-    case MO_32:
-        /* 32 bit address */
-        if (ovr_seg < 0 && ADDSEG(s)) {
-            ovr_seg = def_seg;
-        }
-        if (ovr_seg < 0) {
-            tcg_gen_ext32u_tl(dest, a0);
-            return;
-        }
-        break;
-    case MO_16:
-        /* 16 bit address */
-        tcg_gen_ext16u_tl(dest, a0);
+        tcg_gen_add_tl(dest, a0, cpu_seg_base[ovr_seg]);
         a0 = dest;
-        if (ovr_seg < 0) {
-            if (ADDSEG(s)) {
-                ovr_seg = def_seg;
-            } else {
-                return;
-            }
-        }
-        break;
-    default:
-        g_assert_not_reached();
+    } else {
+        /* Possibly one extension, but that's it.  */
+        easize = aflag;
     }
 
-    if (ovr_seg >= 0) {
-        TCGv seg = cpu_seg_base[ovr_seg];
-
-        if (aflag == MO_64) {
-            tcg_gen_add_tl(dest, a0, seg);
-        } else if (CODE64(s)) {
-            tcg_gen_ext32u_tl(dest, a0);
-            tcg_gen_add_tl(dest, dest, seg);
-        } else {
-            tcg_gen_add_tl(dest, a0, seg);
-            tcg_gen_ext32u_tl(dest, dest);
-        }
-    }
+    tcg_gen_ext_tl(dest, a0, easize);
 }
 
 static void gen_lea_v_seg(DisasContext *s, TCGv a0,
-- 
2.52.0


