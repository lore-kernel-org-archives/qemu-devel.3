Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A45109C046
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RM5-0004rh-7T; Wed, 25 Mar 2026 12:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RM4-0004po-BT
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RM2-0004di-Lj
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0BvefcsBM41Sy57yzhbmwo6+n/NVrQ/jhC7lYqP5BXE=;
 b=H3SWsycI+d4qHohlfJt8XEbjEhiGscaxVtSPyMVHQaBRRdq7f07dhfqVWafaxpEDk8npjI
 5ukievNeZhdFY9sgwYqO+v4HX6tXHt1Ey7lNIDuBcMuviwcXOti+DzBbtbVLkU28xm72k+
 iqP2t2jGAaBEPIqy26uZXmdKEmws9TI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-ugOQ7RwDMEmt8Mjc_yjBKg-1; Wed, 25 Mar 2026 12:45:12 -0400
X-MC-Unique: ugOQ7RwDMEmt8Mjc_yjBKg-1
X-Mimecast-MFC-AGG-ID: ugOQ7RwDMEmt8Mjc_yjBKg_1774457111
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48553fdd03dso420055e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774457110; x=1775061910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0BvefcsBM41Sy57yzhbmwo6+n/NVrQ/jhC7lYqP5BXE=;
 b=JEml2RmBjVepA+I1/2Lx2EfRP5MEPBh7Jcn9C+0+4xMiUGbLm/b/xgxISYkYzhzcD3
 dNCzVDu19XNGyZRljmWowbkDb4diR1uJPSmplke+T+j7J4Lc5X3fyUPgfJ2vhAVmgK0e
 oiTEDsilnnkyGMlHsiS/J0siGoIubutZmmdJTDjmSdI6PCHvQyUOC94JaWV4D8pGcHVn
 lwEoO3yfBk09lezDXsDxKvyRG/fK7X26Ehvy94ju+UdlzwgMJ0r7/5Uz9hQGr0l0sGZm
 eSw/BHqOiS0FF9LkWfzI3s7dhHwY1V8CxKQnqX97mAJNwRK1prJqImgEkv+MyC6Junyv
 ta1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457110; x=1775061910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0BvefcsBM41Sy57yzhbmwo6+n/NVrQ/jhC7lYqP5BXE=;
 b=qcfsqfUaISyFT6WjmxXPGWaE/G4w6fKcZHpuLeaGAV9XOsgj/xs46WQQpw0mpUiGAF
 gFpHz63P2ioh/qfC5DfaOI73kQ0En7i1/q8h8HD9GA7sVQoMqiwy/lUDw1afxnVEmSAv
 WCg7rJnhYfvdI93fkqkMgO63qUgWexoraoxdivmeqgVf8y1yF+XkABTZ5saVcKcK7reK
 D01GqGxA0QDh1WL5zrT0VaF0VJyWg/9S3hH1fQRSl9Ol40yJe2fOzFBDAw911wWpwQv2
 wFPoVXjVsOketIPuaeM5j8fURAIDz6gj/65brea41oUi8+kEG5MIDVap17LbmOW5sfyv
 f2WA==
X-Gm-Message-State: AOJu0Yw/3WU17LYYhEq/Kq0qQD4jv7/GX9GDNNcz3IcR15BGRUad1+Hp
 qXn1vQlTB9zCtetf0Cge3/qscUfCNfg1qLISK/iuFpnWPdb0aOM6wJZJ1PydQ9Qs6ORgZnK0mAB
 /RGkHvTlZWPJPNW5Zd7UE23DZvSlQwnl0qBRZbbUVsItXfEV+jVe7i1F9Ef8Wv5HwA88B4J/lMt
 8D/c2fahPF4j64sRKO4wgNBINqaxkwrW2IBCxUJpLh
X-Gm-Gg: ATEYQzzxbjzYs8uSE6Zd9/iW4a/eYtpzBPiQVFUlXD+ceZnSHNlkdHEh9TQD293MrEa
 Bq6GOPhoANk9D+toJdaxcOgAMpWiQydEsOm/XVmQSRsdbjQQtFwWaV6xpkbD7lC8rIubIhlO4tc
 y/6i/makcSFi7nhKXkZHASHsmcjqDs90Ndh9Zn2ZfCJqxus5NiqGm8uy2oHgS84dNfB2PJlJKNO
 HQ7fgE3FaI6ajqZzbjdAei/PSkqTtMx4hP+b4ZOAjyDxHhZ9bWWSM2SCSFsdaluMAG4DjwIDSao
 5sUYPQQPkgZUA6RG41FWjIDA8cq2by77W9QLBxarlocZEXx2DwDcY1U1b+pGG03hAehUqQMGpqp
 a9tSGrJ+S6qyjYISQ2W6g4xAlXlpZVbBeDmpDsaGj5g48WOYjAtogFZKCxbm68Bi5v87VO04hNO
 yRMeLkT/TbKCOMSGsZDhAigLIL
X-Received: by 2002:a05:600c:3b12:b0:487:1c2:6a56 with SMTP id
 5b1f17b1804b1-48715fc385amr70165715e9.3.1774457110401; 
 Wed, 25 Mar 2026 09:45:10 -0700 (PDT)
X-Received: by 2002:a05:600c:3b12:b0:487:1c2:6a56 with SMTP id
 5b1f17b1804b1-48715fc385amr70165085e9.3.1774457109814; 
 Wed, 25 Mar 2026 09:45:09 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48711764625sm147771045e9.14.2026.03.25.09.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:45:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 08/19] whpx: i386: don't restore segment registers after MMIO
 handling
Date: Wed, 25 Mar 2026 17:44:42 +0100
Message-ID: <20260325164453.72127-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325164453.72127-1-pbonzini@redhat.com>
References: <20260325164453.72127-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260324151323.74473-6-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index c0c7ba91772..69d141e7cce 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -416,19 +416,21 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
     assert(whpx_register_names[idx] == WHvX64RegisterRflags);
     lflags_to_rflags(env);
     vcxt.values[idx++].Reg64 = env->eflags;
-
-    /* Translate 6+4 segment registers. HV and QEMU order matches  */
     assert(idx == WHvX64RegisterEs);
-    for (i = 0; i < 6; i += 1, idx += 1) {
-        vcxt.values[idx].Segment = whpx_seg_q2h(&env->segs[i], v86, r86);
-    }
 
-    assert(idx == WHvX64RegisterLdtr);
-    /*
-     * Skip those registers for synchronisation after MMIO accesses
-     * as they're not going to be modified in that case.
-     */
     if (level > WHPX_LEVEL_FAST_RUNTIME_STATE) {
+
+        /* Translate 6+4 segment registers. HV and QEMU order matches  */
+        for (i = 0; i < 6; i += 1, idx += 1) {
+            vcxt.values[idx].Segment = whpx_seg_q2h(&env->segs[i], v86, r86);
+        }
+
+        assert(idx == WHvX64RegisterLdtr);
+        /*
+         * Skip those registers for synchronisation after MMIO accesses
+         * as they're not going to be modified in that case.
+         */
+
         vcxt.values[idx++].Segment = whpx_seg_q2h(&env->ldt, 0, 0);
 
         assert(idx == WHvX64RegisterTr);
-- 
2.53.0


