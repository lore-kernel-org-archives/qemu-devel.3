Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EED7D41171
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 11:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgLbi-0003Fr-J3; Thu, 15 Jan 2026 06:33:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vgLbR-0001qy-5F
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:33:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vgLbP-0003z8-0u
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768476802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Q2xDs6voA4t4GN+7fEry4HocsUdTgpQdX9oMo6deBg=;
 b=NTmw4YJIyhz7HberK8szEWq+QehMFJF3JWZMxzmVA7v4Yy+y84B04RwOV6GBSwxk1ySurg
 KyK9B16XqiME030UPPxG/YLr4hXY+mbhevmmiozSuzB+tEgbrQ5QcBe6gi6sj9pejJ5p1a
 X6/L+SY6AvwzFtICtmDLsJFajtVTtCs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-11ujmQdaP6quNWRFIPHmvQ-1; Thu, 15 Jan 2026 06:33:21 -0500
X-MC-Unique: 11ujmQdaP6quNWRFIPHmvQ-1
X-Mimecast-MFC-AGG-ID: 11ujmQdaP6quNWRFIPHmvQ_1768476800
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43284f60a8aso682611f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 03:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768476799; x=1769081599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Q2xDs6voA4t4GN+7fEry4HocsUdTgpQdX9oMo6deBg=;
 b=TiZl5FBpByeRJ+XGytmDukXN4DScDBUHYeq4khDk/3dV7GRStFj3kQAKqXHwoyWzYX
 DBm1Ru4uG+k02ysNfyyV8H5VaUmXFn29Y5yeMs6cURjxzdmdntLCPFjz2KAkfJfYarrz
 X1SY2iDXKQ6LVXhxQJ9twA9PDpctYV6OAnQ3Fhv/FoaKZhN5nmLvJZQQud92hHOdJlvv
 zZTRZgo/VvENi0I1X7tmqEO6Mg0YL/Ieout7pr6dT/lHEV4Z3PAb1DLlePu/IGXDcSIe
 03Zwc1p6YccLUoyMWhUuTjj80rSpR0/GL1vfMcmZISHIMED4VCOU2Z8NPumpBZzdwFeC
 mKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768476799; x=1769081599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6Q2xDs6voA4t4GN+7fEry4HocsUdTgpQdX9oMo6deBg=;
 b=dtgDs89IKxVQ54+in1LbyciY+H+MbnHnpq3DP7zDN1sBQ+uuhQkhnHb0Tpbfj8croL
 cVdbBu5qsOZ/X5hWwDW7btWptUfu/hJQpBYWylI2FJUrOK3snnYn0LiFmydnYckYeEq6
 +PPHp63NQc35O9sJuNwC/kQMZWwAbYNqumWuE2Izmye0p1d1Q1ESUY9tP7b15Y/O7ztU
 WiDMk47i6RH6hSZLfS57yhT4CZEtQuKAdPTlEw+mx9dD9CF9EKw2pMDDhgoMDB809em2
 NPErlqYfhd0WIYTBB2ZcotHFbz/CMIYlehi1qvB6bYKK2Z7xWlScCcQAbEOqACfo6DBi
 /PUA==
X-Gm-Message-State: AOJu0YwRmcNkUDjhc2b/KgqSzJ88GzG7Ew4Ie8bBIpJkUaar6YIk/zIk
 eHIwx8wwZKUC1+UcAOnSyRHCm857T6wNACB98e/S+Bb+qkTr8I87cp38JAD3URLXPKCJr1uwg1y
 DWoJOBHCpVieQOXI0W9PhSzHCXxGHDIq5jY23prWdfsKVRQ7ZN5eBdMM2/17oSAjj4h2Asmxb15
 4rYbEY3Ljs5fy62gniNGWfNdZ9XfFpzXmY+RzXDi32
X-Gm-Gg: AY/fxX6F/7xVwy2BEqUYeEJ7Jfnz/Y3qXWbHViI6lV14zdc2uD8UlHKSeZ9Go1Xvxoo
 QKKSkxN9DflFhJI7ybIyQsE2SU2mE1gNNWjTpFeieIF7Bvsl2xNRa7vWozGKnFgieHlc26UW37Z
 /tcmSk+vR0ilXYbaFEjm5YsbHWtgPip9mP2dqWEgTTKJ2zw6DPKxlwqeImpyFQVYNOFftazFNfb
 4FLQH5fRytr2W3sR8vk2N5qA3sTWQ+WFKx49l40m32ftlCObgdVFP0WLCF7iOIL4r0qJBW7tGEm
 IBAOOwiMIUgZRxK5GzTJOqiEVDHeTeZS2jm1lYCoEZCPtK6CVQ+sziupgYKxOitmHdq+nDpcUo+
 1ncLxG/TgJCJOBYKOAzgsI1VReJLXdSkuCPUwS79kC5GHScquIvub6MyBjjz2xYc5giuWIZ5l1C
 xSCvxWWpfYdY3AUw==
X-Received: by 2002:a05:6000:1842:b0:431:266:d138 with SMTP id
 ffacd0b85a97d-4342d5b2a4cmr7233853f8f.25.1768476799088; 
 Thu, 15 Jan 2026 03:33:19 -0800 (PST)
X-Received: by 2002:a05:6000:1842:b0:431:266:d138 with SMTP id
 ffacd0b85a97d-4342d5b2a4cmr7233806f8f.25.1768476798678; 
 Thu, 15 Jan 2026 03:33:18 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af64a643sm5374229f8f.1.2026.01.15.03.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 03:33:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 5/6] target/i386/tcg: replace havesib variable with the SIB
 byte itself
Date: Thu, 15 Jan 2026 12:33:05 +0100
Message-ID: <20260115113306.126905-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115113306.126905-1-pbonzini@redhat.com>
References: <20260115113306.126905-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 662d1d707d0..086a3bcec18 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2015,7 +2015,7 @@ static void decode_modrm(DisasContext *s, CPUX86State *env,
     int mod = (modrm >> 6) & 3;
     int rm = modrm & 7;
     bool is_vsib = decode->e.vex_class == 12;
-    bool havesib = false;
+    int sib = -1;
 
     if (mod == 3) {
         op->n = rm;
@@ -2036,14 +2036,13 @@ static void decode_modrm(DisasContext *s, CPUX86State *env,
     case MO_64:
     case MO_32:
         if (rm == 4) {
-            int code = x86_ldub_code(env, s);
-            scale = (code >> 6) & 3;
-            index = ((code >> 3) & 7) | REX_X(s);
+            sib = x86_ldub_code(env, s);
+            scale = (sib >> 6) & 3;
+            index = ((sib >> 3) & 7) | REX_X(s);
             if (index == 4 && !is_vsib) {
                 index = -1;  /* no index */
             }
-            base = (code & 7) | REX_B(s);
-            havesib = true;
+            base = (sib & 7) | REX_B(s);
         }
 
         switch (mod) {
@@ -2051,7 +2050,7 @@ static void decode_modrm(DisasContext *s, CPUX86State *env,
             if ((base & 7) == 5) {
                 base = -1;
                 disp = (int32_t)x86_ldl_code(env, s);
-                if (CODE64(s) && !havesib) {
+                if (CODE64(s) && sib == -1) {
                     base = -2;
                     disp += s->pc + s->rip_offset;
                 }
-- 
2.52.0


