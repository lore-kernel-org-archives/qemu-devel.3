Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370D7F99368
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrKn-00013H-B2; Thu, 23 Apr 2026 06:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrKE-0000nE-FC
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:30:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrK9-0005mh-Tj
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SvezQ3MLTmkGpNYucQ8nhsSa/DAi1TK3VmsXEHyf4wY=;
 b=Xo1KHFjLNekvErf6Cji7IGAHmDM5FhH7Is0CjjEvHMK3YolqaHPgLSntgW184ZEoH7QeHq
 rpIJ/F+qIgBWpmDh+A9/1EbSV0fDVkGThAd+xjFFCYPayfxkwBrcj+7d3uIIb8GsqYnCbt
 c5m4InQaFwuxvBTpJsxj/82x2eNRknw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-re61eB8AOFK1pKUH7-GGfg-1; Thu, 23 Apr 2026 06:30:15 -0400
X-MC-Unique: re61eB8AOFK1pKUH7-GGfg-1
X-Mimecast-MFC-AGG-ID: re61eB8AOFK1pKUH7-GGfg_1776940215
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48919890a95so31319045e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940214; x=1777545014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SvezQ3MLTmkGpNYucQ8nhsSa/DAi1TK3VmsXEHyf4wY=;
 b=dMlg3r8inZRJG8H86pqQR2AdPDsA3NKwfqffDMOkHramzGuM+6mzhWldzU2WN/n7BO
 yvGT6gMIbXAPVrKm7qdwi4Wjix3pd869LYhEud18p2odT28RRF2lM9wnmGY4PErM0Ozj
 WiVX7CSHB/KeqCmBOGi4x3VFEIfjIsiQuMo4/kQR8Iqmnu4AwOvEBLQrlsHzSchOKbDV
 f8Et/qiCZGrVecACrkXSWTv//UKRuGQ6xkDs/sXokbGPEmG4dAo/4f8l7d9SwFeK0AOS
 tXIab7wJ6pUubOi5LKzNX+PuWmRRudUsh/BGUQ0EvJY14rdK8vbl0ha1I/KKgmjPvDCo
 YHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940214; x=1777545014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SvezQ3MLTmkGpNYucQ8nhsSa/DAi1TK3VmsXEHyf4wY=;
 b=Cc4Lnd5b3/8yT9M/GKRoW/rWKvIvcc1+N2BSdidHxDItgCtonnscEjJtqMJiWR+SIW
 CuzrBcahfuRcX6KHqpgKGTOKS8NKBoikCcvTRLef2oFBTSMVYGLD7dCsXNTfnvdYBMqb
 v5b1DwT/L6MPk2o8d6ZJXakCLsi2jl7eQBXDr9cJYOkuNxapW1f1Eq0Bif59qa0LY5jS
 XM287+dc2cSzOoB24i55ferc0qNrtEcWhRZZSEmZRMVeoChpo5t7ItRdoSbUSLeVLu3e
 292e5pp2fYGHGLwHIwkPdRuLYXReRAnWMJyNv7QU9aE/cA3ozFvBOEcnJlQLJmrBuzH0
 H8HQ==
X-Gm-Message-State: AOJu0Yx13Zy+AeINTEZ7weGkSX3hQtrbUJ9ikRX4Q1E9aYJWbQlw8aE4
 BW4QOZZuERiPGQ7A65JjP7NUun5AI9Sr53G9RLSa91qpQ7DQpa3G5VacZB6iFkDRRfaSBBcB0Ti
 mTCYkLy/9dlyk0n6dAJRsP4/qtJ8TUmFsMg234Ruzxj2q69mlHPNRcktZ6n5DKUn4Zo9hmuYJna
 d5I8IWsVdwJIt0DsaFTqxOmCCgnJmPe7+oEhnDS1Pq
X-Gm-Gg: AeBDiesETDzaQ7w7JGmBCbiR6h9GM1dIfriIYt1BSJdzbXY5NfBOEJuZVilxV7xzJXp
 hH80QXVvkIbTbEdH2ySC/zb91nX/7jz3QWM0fkuWO5dmqQ0NUd0+8T68wD7hhbSL6yb3H6p5Vuw
 H2rWdDdRKD9LIkHh+3Vx8+Qrsnyx6pdJ8EOBAdH2kMZVsAVF0IHRUiYBGSCNbWRCwPHYMiIiZGC
 u3Q61OvOSDSo9zsz1smfe/R775RDuNXAIULwl9LiPfMyzig1+Z+q3rOQvxwHGZ87wjDCmy+5gQ4
 JZaciezuZUkMC0X2eiG/xcd17xIkgzJ8yBkqHEuqZ/0sZRSI+jQL4AdPAeQ4l4EUx7fOky/9zQY
 7q2GPm5TAj+tBiWjMXEwtlgnW2PIAaexGHBhVJPkcfhCSa+lVDGvt8j0gjUKJ826v9dKBg7jhMy
 1q1JPL240hV3ZM8bZ+dk+Yub1wJbTTRQ52cqk=
X-Received: by 2002:a05:600c:64c7:b0:488:a2ac:a334 with SMTP id
 5b1f17b1804b1-488fb73aa3bmr395055905e9.3.1776940213384; 
 Thu, 23 Apr 2026 03:30:13 -0700 (PDT)
X-Received: by 2002:a05:600c:64c7:b0:488:a2ac:a334 with SMTP id
 5b1f17b1804b1-488fb73aa3bmr395055225e9.3.1776940212695; 
 Thu, 23 Apr 2026 03:30:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891bb3d121sm484876215e9.14.2026.04.23.03.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:30:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PULL 17/25] meson: Don't require nm for non-modular builds
Date: Thu, 23 Apr 2026 12:29:14 +0200
Message-ID: <20260423102922.443639-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
References: <20260423102922.443639-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Kostiantyn Kostiuk <kkostiuk@redhat.com>

In the MSVC build environment, nm is missing; at the same time,
scripts/undefsym.py exits with code 0 at the beginning
for non-modular builds.

So, this change is harmless because it already didn't do anything
in non-modular builds, but remove the additional tool requirements.

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/r/20260327134401.270186-16-kkostiuk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/meson.build b/meson.build
index 09cdd317699..a962b181e64 100644
--- a/meson.build
+++ b/meson.build
@@ -3906,6 +3906,9 @@ modinfo_generate = find_program('scripts/modinfo-generate.py')
 modinfo_files = []
 audio_modinfo_files = []
 
+block_syms = []
+qemu_syms = []
+
 block_mods = []
 system_mods = []
 emulator_modules = []
@@ -4021,18 +4024,18 @@ if enable_modules
   if emulator_modules.length() > 0
     alias_target('modules', emulator_modules)
   endif
-endif
 
-nm = find_program('nm')
-undefsym = find_program('scripts/undefsym.py')
-block_syms = custom_target('block.syms', output: 'block.syms',
-                             input: [libqemuutil, block_mods],
-                             capture: true,
-                             command: [undefsym, nm, '@INPUT@'])
-qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
-                             input: [libqemuutil, system_mods],
-                             capture: true,
-                             command: [undefsym, nm, '@INPUT@'])
+  nm = find_program('nm')
+  undefsym = find_program('scripts/undefsym.py')
+  block_syms = custom_target('block.syms', output: 'block.syms',
+                              input: [libqemuutil, block_mods],
+                              capture: true,
+                              command: [undefsym, nm, '@INPUT@'])
+  qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
+                              input: [libqemuutil, system_mods],
+                              capture: true,
+                              command: [undefsym, nm, '@INPUT@'])
+endif
 
 authz_ss = authz_ss.apply({})
 libauthz = static_library('authz', authz_ss.sources() + genh,
-- 
2.53.0


