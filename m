Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6A4D3C545
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTK8M-0004BH-Eg; Wed, 10 Dec 2025 08:21:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK8J-000483-KR
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:21:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK8H-0004Zx-JJ
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:21:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765372888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+HYm/UyYSx/CQl46QHlKqzDUpapeLZeztYDRM6CSpoc=;
 b=Rhw7Vp715YO+sHsW2C05iQ3wBpVSi1Y975Xb4QYL0N4Qz6BJKVINdGGYgV2uTSbUpeT140
 hIaroNrNFUeDnEa6IXX8g1nGjkGl6k0XpGBL1JA3Q3Qz45vf9xXqkVW9JJ2SbXhlE3qmwm
 2zBGqdAzmW4xP2jzW8rsmGAVSs18Rqw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-koTLtDL1OmOTOwhrr3wEuA-1; Wed, 10 Dec 2025 08:17:12 -0500
X-MC-Unique: koTLtDL1OmOTOwhrr3wEuA-1
X-Mimecast-MFC-AGG-ID: koTLtDL1OmOTOwhrr3wEuA_1765372632
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47788165c97so41915665e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 05:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765372631; x=1765977431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+HYm/UyYSx/CQl46QHlKqzDUpapeLZeztYDRM6CSpoc=;
 b=GSEzHDs1FFdJKe7eei1Z64qyO2rn2UlDC0BH23uA9hMG9uGSLfFX7p5DDKOISQEKxE
 P+Yj6ObMx80YP0Viq9NPoPQq0ajW/zEQLe2vZLwSvCUJYP+kWc0VUR6fTlfEPDPjFUk5
 nFmX8m4Vnmj5j2qbmky5S7Jx+hyYOjWbslBHsmlbrZxtXnYnDSNOxDKh58hb7zJUJHVA
 ICWA4N2zCc85X6nlGIsoznI6ZJDTEQ/oi2IOpKTwaTyZM6m0knshLcrMmMiWn34rS6VQ
 rkQEkQfmpFEq8S1jQl1Y7wDP2XBPG+PS7gM1fchDGbu46TpL+poyQbvBl+uh4BD4Ay9I
 2iDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765372631; x=1765977431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+HYm/UyYSx/CQl46QHlKqzDUpapeLZeztYDRM6CSpoc=;
 b=Tfi5WTTTGmK6FaIi5YlQ56P8X51ko5LpxPcPSm5+di9JTaKHEpuu1C9iLPByK5M/xw
 wy/qc04UN/KmfEMknpAMVdMNx5XANmY9BLu3KvXbzfDVt/CfIsiuwYT6gnVhcUMdOML8
 FHRefxjtdR+ay9K5OuoQBHNXdmjzvJLrAa4GYiboUpYFtT9yqgBgTVxUvnvQvAZGXlHG
 zyI8AgBfRBuwYSg7k44BbUhbuBN8hZcazGp+GPRgCJZ36p7NoD8hURxDfxNyeZi/PDEN
 eF3BwtEXbUgrqoCdpBypI8bBcQ9h1z2FtKtg5SZ+VkP8J79u3bDUmIrPd5kSQrf3VMba
 QqTQ==
X-Gm-Message-State: AOJu0YxIZ9q7IJAgBjoR5QVN1P9dftiRxFH2lemadh/UYqfwLk1fbsNv
 gKl0feUPeKjL8OwutwXfVUxgv+DjbU/SYkq/aFIMBZk1XaAfuxKBGJu1os0g1gbQxFozs4t2S2m
 5bo1zkHP95h7cAEfScbZjr43EkIVHy5p1FvK+/v8aS6AlHWnwqyuVlTcroNoIqt26T2fkY/uHjP
 wj/jX686w6a80yxyNXQczAJZHNzw/HN4QKcXqXTGtf
X-Gm-Gg: ASbGnctFmfwhuzqDe3p3CCsdti4qCp+R+qfRRSB4PxZN7T6yBIMw2YI3VoKlPa9+U1f
 P0mp2vJxsKX1F2t+sWuaCm8TRKmujdgVpvMLmdgbp6HFV4+Wmgo4ijRIvZMyZ6mT4PDF7H7JVfO
 RQbnTsl9nwi4J9Y6V4Yc//yVWV7vi3RIj2c/dXXUBJiNZmf/t1CaDTVVXiJW74vCRnOfPuulm+T
 R+esMWRwd6hOySlLgwi3Lm/+LUlfrTBHwWiCbl8q91REBvirx59QWuqyrzn/198dZhAHhB2WzzN
 +9wTJBV7uRcFxyA1wvip4k2CP2vN3HhWQIQluW8GBrXMobGNPZkZYYYOZqdFV9Tz+acU8r46+jP
 Wyh+hJ06/ptwu33Zh+CLYMe2jPRh5gGNKrFQCF5XjWzwVOZXpFPMCaDmJ9kVvVn9+T5k2CNWvur
 fu5xT/00gbL/GmAss=
X-Received: by 2002:a05:600c:a68a:b0:479:2f95:5179 with SMTP id
 5b1f17b1804b1-47a8379de88mr17317225e9.15.1765372630764; 
 Wed, 10 Dec 2025 05:17:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECfoV19pI8VZotoIRMGee1WJEiJi37fRZcJ1vZTY/jSNodvnCLhkRHHEkZNk+29BDNAIzGaw==
X-Received: by 2002:a05:600c:a68a:b0:479:2f95:5179 with SMTP id
 5b1f17b1804b1-47a8379de88mr17316965e9.15.1765372630230; 
 Wed, 10 Dec 2025 05:17:10 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a82d15f3csm46539085e9.1.2025.12.10.05.17.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 05:17:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/18] target/i386/tcg: simplify effective address calculation
Date: Wed, 10 Dec 2025 14:16:43 +0100
Message-ID: <20251210131653.852163-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210131653.852163-1-pbonzini@redhat.com>
References: <20251210131653.852163-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 64 ++++++++++++-------------------------
 1 file changed, 20 insertions(+), 44 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 0cb87d02012..2ab3c2ac663 100644
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
+    has_base = ovr_seg >= 0 && (ADDSEG(s) || ovr_seg >= R_FS);
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


