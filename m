Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20B2FCA161
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzee9-0002g1-60; Mon, 09 Mar 2026 13:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzee2-0002dF-MJ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:43:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzee0-00025p-BP
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773078231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VfikCXhkPujXGahi1K+KJCeU2o/MsWlpko/s3OY9n38=;
 b=VtSR4o8ROatTGDdsZfD8Fa+2Il9uVO3AxqBgpGC039/ybkxLYIb0gkKtkQAlBVfHzFXvqu
 Z53wfwpBWfOI/uCJPPktXicdMPZcpzc6UnFdc32RJnrAODZN7161XhG+9Nye7uOJBQA9Zm
 j2u0coVpRsBxeqb6a9BdfRR7gDNP+/g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-8-hpmSIWOlG_XTo9iexjdg-1; Mon, 09 Mar 2026 13:43:50 -0400
X-MC-Unique: 8-hpmSIWOlG_XTo9iexjdg-1
X-Mimecast-MFC-AGG-ID: 8-hpmSIWOlG_XTo9iexjdg_1773078229
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4839fc4cef6so111316335e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773078228; x=1773683028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VfikCXhkPujXGahi1K+KJCeU2o/MsWlpko/s3OY9n38=;
 b=B9niDcVCccsFEO7TtPzHWJp6YEeimUoE64fkLtK4ER5K0917yBoPIqXt/g0nQrVb+9
 3yLfXgHMgngFAjBrjOKIhyTFj3sor3DTx5lxaH2bgy/blS6VkFeSp1hYCNnev8I1V+CN
 FAKeZTq/LNfYjdMk0w/zFYBxjHS6GS8/e4lCJK4UwxPOjpGLyGk05sDvxWqPS2GEFGLj
 YQWN0fAzyVUzdZQFXbogPVK4IXSJTFic9V8M8L9/2Y67hseXkUBUq1A3jeHU3oe9JOPg
 UgnQ8MviEt9hQbzG6mVfz8M/plOleVMrjaKb1mViu1R9nRRvUBMoo/c+2MhCyxWqpzgx
 SvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773078228; x=1773683028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VfikCXhkPujXGahi1K+KJCeU2o/MsWlpko/s3OY9n38=;
 b=Nr7rLy3/6+DZ4hDWoMuIdla6sw1Jw1lMVFmfsHaoIkTDfUxBo+1G/g+MaWqy2Bjawm
 9xZGfBnVumDqVThOIHR6gK5xJpkNQRS827ui7YFhdIB+ylq9jfJqQu7U9B+UChUekm6q
 ylqh+EJal7moogGM5cCYQhHOobP6OlwMvV8FE9zcgSIeBuD+tcxpOFvueufTiqFeibpz
 3QCc03nF2ntgsXYIRFsPIq1ySlCEHAx4KIKV0/GFuFw5p8xxOPsHnKwo1qb9KEmTfsrd
 3AbE2wLCsIVW+Yugo1tpWkCbrhgu1uXXMzhA7lQ/CnEOvfRg1XYrCxJOX1i5H+2l9DDp
 ck8A==
X-Gm-Message-State: AOJu0Ywnw5+ZTiO5KMWe7cWPqCnlVv7WLLRffJwKxPbTG+nLwcppj4ll
 aEDW/3XF14EE7wY/XCRZxLFda2f7EsT5yKCzdgGYg8nDv0RoXsg0xI0TiAfnBfpsOf+eif/vkA0
 smFreaJXparp/nb3hRU9KF5422W9MUCXq5qlWO2EVvTlKb0drohg6aAXYYtTPRlXoA2i/TdszSK
 2/aGthDLdAEzlKk0jAj3bYokaUSXKG1LWpaOAw85Cb
X-Gm-Gg: ATEYQzw2SLdwTYeFQP7hEWD5Le2O/nRJ7O/Thb3fYl5gJEy4HGL/5oNzJ0Ha8WE9Wnd
 T3TSBkgp6uBxcIUTnuv4YuFJi5q4oMXp/QTUq18YYA7fETJG21cTT/g7Z532mACl8/HBOcDl33q
 uwgz5Zx2O5rlwo+4qyrlhi+t6DGVWb3J2FmZWp33vj4w6R+Pn8Pecvn/F6hx6WSlQhnDEVnlbJv
 VpIoVWSmDAUow3NrrSPgOgZnwpyHi1778FwfPx0xFtBevHoA2uHMjj2e4qK8P0L6viMoQkUDlgS
 tugiU7ehWSoB5H2jo5y22bqiWOEVe1XczFRbsZCNNyghW+Rv/GUk7/LfJtKmc+bWFkMxfBDMq1b
 nYb2qFb+POTWWau8t1LTJmgBG/ASaq0v95Ganw1V8zO9/OEvwxR0ncp4jPQsY6dMeSKTABSM1Kw
 m7RhW0foFSxVwtEyss0uhNPv71UbI=
X-Received: by 2002:a05:600c:8b4b:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-485419f1614mr7865735e9.11.1773078228128; 
 Mon, 09 Mar 2026 10:43:48 -0700 (PDT)
X-Received: by 2002:a05:600c:8b4b:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-485419f1614mr7865305e9.11.1773078227611; 
 Mon, 09 Mar 2026 10:43:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm138774185e9.4.2026.03.09.10.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 10:43:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 03/10] target/i386/hvf/hvf.c: fix compilation
Date: Mon,  9 Mar 2026 18:43:33 +0100
Message-ID: <20260309174340.52174-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309174340.52174-1-pbonzini@redhat.com>
References: <20260309174340.52174-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

../target/i386/hvf/hvf.c:476:31: error: use of undeclared identifier 'cpu'
  476 |     X86CPU *x86_cpu = X86_CPU(cpu);
      |                               ^
../target/i386/hvf/hvf.c:479:24: error: use of undeclared identifier 'cpu'
  479 |     env->cr[0] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
      |                        ^
../target/i386/hvf/hvf.c:480:24: error: use of undeclared identifier 'cpu'
  480 |     env->cr[3] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
      |                        ^
../target/i386/hvf/hvf.c:481:23: error: use of undeclared identifier 'cpu'
  481 |     env->cr[2] = rreg(cpu->accel->fd, HV_X86_CR2);
      |                       ^
../target/i386/hvf/hvf.c:486:31: error: use of undeclared identifier 'cpu'
  486 |     X86CPU *x86_cpu = X86_CPU(cpu);
      |                               ^
../target/i386/hvf/hvf.c:489:11: error: use of undeclared identifier 'cpu'
  489 |     wvmcs(cpu->accel->fd, VMCS_GUEST_CR0, env->cr[0]);
      |           ^
../target/i386/hvf/hvf.c:490:11: error: use of undeclared identifier 'cpu'
  490 |     wvmcs(cpu->accel->fd, VMCS_GUEST_CR3, env->cr[3]);
      |           ^
7 errors generated.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260307181856.2209-2-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index a70f8461b04..c0d028b1473 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -472,21 +472,21 @@ static void hvf_cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
 
 static void hvf_load_crs(CPUState *cs)
 {
-    X86CPU *x86_cpu = X86_CPU(cpu);
+    X86CPU *x86_cpu = X86_CPU(cs);
     CPUX86State *env = &x86_cpu->env;
 
-    env->cr[0] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
-    env->cr[3] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
-    env->cr[2] = rreg(cpu->accel->fd, HV_X86_CR2);
+    env->cr[0] = rvmcs(cs->accel->fd, VMCS_GUEST_CR0);
+    env->cr[3] = rvmcs(cs->accel->fd, VMCS_GUEST_CR3);
+    env->cr[2] = rreg(cs->accel->fd, HV_X86_CR2);
 }
 
 static void hvf_save_crs(CPUState *cs)
 {
-    X86CPU *x86_cpu = X86_CPU(cpu);
+    X86CPU *x86_cpu = X86_CPU(cs);
     CPUX86State *env = &x86_cpu->env;
 
-    wvmcs(cpu->accel->fd, VMCS_GUEST_CR0, env->cr[0]);
-    wvmcs(cpu->accel->fd, VMCS_GUEST_CR3, env->cr[3]);
+    wvmcs(cs->accel->fd, VMCS_GUEST_CR0, env->cr[0]);
+    wvmcs(cs->accel->fd, VMCS_GUEST_CR3, env->cr[3]);
     wreg(cs->accel->fd, HV_X86_CR2, env->cr[2]);
 }
 
-- 
2.53.0


