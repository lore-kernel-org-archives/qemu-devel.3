Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8171AE8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQuo-0002Wx-3H; Sat, 27 Dec 2025 04:48:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuK-0002Ba-RK
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuJ-0006sU-9m
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NUmdt3r8IHKmZ332Dkfg2R3Sl1VyHZuITLUsOhOwT44=;
 b=FOgUj9vbnr0HJdZ1w3QZq/K9bnKgMmFx5cgurA1MMqe5V6uvC5RQlHhrbEecKyoxuNnEUG
 5afItm1MSSL9tPrU9K9fKCZQB4fGKwNyiSQUQqWmJLADHQj0+I7T/mvujqMLIm56KJVC+M
 DB9SOOIsArC5wE13oN/9xIjTcp04c60=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-SiMoCMTUNiqKZYf0QPZVKw-1; Sat, 27 Dec 2025 04:48:16 -0500
X-MC-Unique: SiMoCMTUNiqKZYf0QPZVKw-1
X-Mimecast-MFC-AGG-ID: SiMoCMTUNiqKZYf0QPZVKw_1766828896
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47918084ac1so65312025e9.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828895; x=1767433695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NUmdt3r8IHKmZ332Dkfg2R3Sl1VyHZuITLUsOhOwT44=;
 b=D0n7mRwATbSrsH+ZsmFNm/S4K2Z6uTgY3rvx9Jp5gXtqNHcnsDoirBff04JkitDM2j
 XO19SLjNARFJzBN3G3LTWAIS4Fdp1P+i9FlTpb/l7TlFNTNUXHF13DXaGeUYQkMn94cK
 1J9dnSP+GjivCv4fMYZaCensDZSTw9GZty0h1KDkOE7PxN8rwN5PvqcsHOsIaUFaWxJm
 ryH1bZSPZUEkVVk95DJ5ZV2t+A/CEM3VULCFxKe5vArkEVRnIjZR5o5prz7R+zdpd5l6
 eskTkfuwqsvOys6ndg7cHa0Ff3kx0IbhX1AK65W8foX5FwR/T7IqR3FLF42OEdvywVcc
 Wa0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828895; x=1767433695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NUmdt3r8IHKmZ332Dkfg2R3Sl1VyHZuITLUsOhOwT44=;
 b=kyRHY9ae0UDqrNiS5jTOsIkSF3ciLg+jp6jT79J5lrHgnUBQuZyQ0dXjKvBChaF9lZ
 PcUPO+G0hIQ91FPzQ6OlFtqgBH8Knta+dZQgHrns175YtePrpVqs2qfGd2BJwzwRN9Co
 j2i1n4JWyOuVy0TbEZNdgNnrB2Io3UOlSyDx/Haj71CQfi2tF2PtaWV7dFne8/dwy7+s
 TybW+D1SqvVOPPkT+Lw/yLUENqOrpQMCFjG8LhtOL5f3Wj7rDMUG9OMb1LffRhyGctva
 /ULmzjD7FUssPy0rA289FaVMB9p4wjElh8Lgk9yY6YPP4tAR3j1nVgId+3BcK4Jdtlb8
 Dopg==
X-Gm-Message-State: AOJu0YzZ5nkXowdX2BqbT++vgWwsOReG2f91Qfr1N9y+ZpGBZDW+Xlr2
 ybcI+jsXbG5ZTqelpXzweM6x3xva3fHhkYQfOkDGi/JDOHk3fpvvOAnjEiE8nif1NNmrfYcbkCS
 +UV/y93FZiCUK+72ubtOEvXfLNR1uDMKmv4JAk4gcaxxhafV8BwSAF6SOiX/5A8yDyXoN6/Cdu8
 ocgIF6hit3047eC55S7wssqauaUj6gXtd9j600edAM
X-Gm-Gg: AY/fxX7UaPCHjIEm1MUY0TG3fE9D4VZt8C+r9VMLjhCGEWjsHQbQGtrtJJkp0IGuL+p
 3rDfyICnp84DT+oXEE73nInwrnHTMvHKWsvJyBAwwDIDrHlO2HwWh/4dwoBGF4L+su1xgQOBfnu
 UZ06Zpuh8MsH4EWwUL+5ibgEjqc69vs7pgOapkudRpRqlS89royqvgrO0dGhg6mPBL6ucy0AdnN
 ABkLBSvUDm83m38AQ5A5q3aPOOyI140wThojH5GtHnV0hrttY5hyVkaJ5OwWH7+om58EaichmUH
 slq+mW80xCtGaGpopZLdzEuJFW+Ms1+bUlILCvGgwbk8SAr9FZiyGd0PXxDTi1PnvoRB4+y+P9A
 HJTPGMKYfv7coFk7s/8J06/1L2iLcTZqZU3uz379dEx6h1+49VLVs+4HokzP78izM3aZRAgdyIi
 zEMqDpRLxDiq1I63Y=
X-Received: by 2002:a05:600c:8b6d:b0:475:dd8d:2f52 with SMTP id
 5b1f17b1804b1-47d1959d1d8mr293600565e9.32.1766828894858; 
 Sat, 27 Dec 2025 01:48:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG75u6NtmaI8Pu/ALi0DJ4JOaqu9ta7+mqjIETgaCOBkUlXHY/BIPN6V7gAa7dPx2w7IjGxgw==
X-Received: by 2002:a05:600c:8b6d:b0:475:dd8d:2f52 with SMTP id
 5b1f17b1804b1-47d1959d1d8mr293600285e9.32.1766828894449; 
 Sat, 27 Dec 2025 01:48:14 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830f3sm48754467f8f.22.2025.12.27.01.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:48:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Gao <chao.gao@intel.com>
Subject: [PULL 081/153] i386/cpu: Fix supervisor xstate initialization
Date: Sat, 27 Dec 2025 10:46:46 +0100
Message-ID: <20251227094759.35658-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
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

From: Chao Gao <chao.gao@intel.com>

Arch lbr is a supervisor xstate, but its area is not covered in
x86_cpu_init_xsave().

Fix it by checking supported xss bitmap.

In addition, drop the (uint64_t) type casts for supported_xcr0 since
x86_cpu_get_supported_feature_word() returns uint64_t so that the cast
is not needed. Then ensure line length is within 90 characters.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211060801.3600039-10-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5ba4d49dc35..e9ef8b992fd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9711,20 +9711,23 @@ static void x86_cpu_post_initfn(Object *obj)
 static void x86_cpu_init_xsave(void)
 {
     static bool first = true;
-    uint64_t supported_xcr0;
+    uint64_t supported_xcr0, supported_xss;
     int i;
 
     if (first) {
         first = false;
 
         supported_xcr0 =
-            ((uint64_t) x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XCR0_HI) << 32) |
+            x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XCR0_HI) << 32 |
             x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XCR0_LO);
+        supported_xss =
+            x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XSS_HI) << 32 |
+            x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XSS_LO);
 
         for (i = XSTATE_SSE_BIT + 1; i < XSAVE_STATE_AREA_COUNT; i++) {
             ExtSaveArea *esa = &x86_ext_save_areas[i];
 
-            if (!(supported_xcr0 & (1 << i))) {
+            if (!((supported_xcr0 | supported_xss) & (1 << i))) {
                 esa->size = 0;
             }
         }
-- 
2.52.0


