Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225DBFCA173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfns-0003sE-Jq; Mon, 09 Mar 2026 14:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzfnr-0003po-7o
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:58:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzfnp-0007nj-Jt
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773082684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VfikCXhkPujXGahi1K+KJCeU2o/MsWlpko/s3OY9n38=;
 b=UEsx/K9uaQo7XzA37wGqaTPKxMnFLQDnf0Gbiw+5a8L3yXmj6FeLwQcqQcTrkGJHi/xDos
 y5cXskyg0CwbZqtc1GOA+KgbLdSf+vEjrePWYzd1/cpWDu9DTSQfF2mDOyg/oXyFmEnNaS
 +XxB8sEBoXt/mRFeA4hEJKv1LdFSdzU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-FX6sVXBhPA-Kw0fiatIXEw-1; Mon, 09 Mar 2026 14:58:03 -0400
X-MC-Unique: FX6sVXBhPA-Kw0fiatIXEw-1
X-Mimecast-MFC-AGG-ID: FX6sVXBhPA-Kw0fiatIXEw_1773082682
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439af7ba802so8110918f8f.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773082682; x=1773687482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VfikCXhkPujXGahi1K+KJCeU2o/MsWlpko/s3OY9n38=;
 b=Y1+GYNBoA21LExqm0Zfz3Wm8SbKpCGAbN8UVVDXfArWGbmWjtHAQFHA6ypGlMeDHQC
 A6T0KkZ2HSWP2RHalqaRa6tbpUc//L1qlO4ap5TSXjF6fLYGr2MspCf8CyPXOQKUaV9g
 TkAX52+iz6irrakHKJ5HSOi2ww4EETz7KsWKuGlp4IOrMrjZdATYiakHtA3Tysu1hgRT
 6WoRIj+eGcw3S6MspSVCtOaGSsZbnNRxJWc9gXDEAiZWHrt7TnAv81mRPBsF0oSmnt1g
 Zid66F9DV4jFBWScoLdO2scjN24lxeTgZo/XQEp/4K5zLL/6Jx10vQKSjqc5/glUfHkO
 gHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773082682; x=1773687482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VfikCXhkPujXGahi1K+KJCeU2o/MsWlpko/s3OY9n38=;
 b=UfrBVvaE5WLysMyIo8FU5MoZwGqVMqbrD2o/hOeLw/UIr2IAiuvWTJoAv7HuvpGrqd
 tWw7kF2NcdqdSXq6qlRoM+7gLtda0mP6LJTPqlg55XlmJNxUB2+LyjNaOC8QlCgpk8Cq
 8yEgcCZtOMdZ6DvoBn1IYDNPY/ROYJocYITHv6sqIqbMMiCF9lHgKnbB+iwVnj2elnPC
 nGaCPkGor2mxxfXFTK/ESh29ta4JF9w+upUHyDCBaAIPJlbUIoPLEHIITvIPN6uwO3JP
 7lEzYg0b0Luu88m80rsHJbUWM0CfCotBWUjpRWaQ8G9jaND1Gjs6bYZ342BY+1cw0krg
 xwBA==
X-Gm-Message-State: AOJu0YwN9S9+WP00H1RfSRXigsxFf+ELTHyzh0Yt8ABzP5t2/3LABNpT
 UEre9zKrM7sM/orpB7rmz9qIY+oNsnlFHeIt9nvc9pZb6pPNRqQPznIrZlYEZHoEH7D2OegjHqp
 32ht6lOS8O94BuqB92zEvK30prULN3gOPMCSwljo5T7+2umxS7LJOuuz+zales5F7XHMxZ2KO/D
 S2D1Q16/whY2X5dvO+ZnFFM7oBFRpVmoApYOyHj9e2
X-Gm-Gg: ATEYQzw7MGL/PI9TZg/CSLxnmpFUxKCF9kO1EL0Q18CTQbFZttEJZlK+i2qxqAubIvB
 y5dy2uAIztfi9DieSqYPfsnOpElcXCha29FZ8PLR61T7BINPBaqmXCXpvnut6kzu1jg3aJqdiBE
 Y60iNJXgOQOW1cCnbeeaL/SPplxvU3fn6vkuHuvB5l77YnT7Jlf2WqebWRwxag3chjDMecThpJZ
 6XIL9/uR2HNfHDTEfHnu2Y4FScIX5/jfX+KGJc2ftGviTuPwVTLvr7gYJUk3kivTG6j+19MLLvJ
 Zc3KB6ch7iw8E+Pz9/sCb8VEQmztbbhtFqRGR1Jz4ZgN9YSILqs3gObIy7IkbGK7TVJxZit1l9s
 zW7AHqfio5iIXlYJnuqJd9m+5hrTOprmpCiBOEru+bshOg6jfUXbwWxtxz70qxd0ZUN0WRDQEqT
 7LGXg2oLD9r7uLfV+LholjKrSXTEI=
X-Received: by 2002:a05:600c:34d0:b0:477:5cc6:7e44 with SMTP id
 5b1f17b1804b1-48526923c5cmr199475015e9.11.1773082682014; 
 Mon, 09 Mar 2026 11:58:02 -0700 (PDT)
X-Received: by 2002:a05:600c:34d0:b0:477:5cc6:7e44 with SMTP id
 5b1f17b1804b1-48526923c5cmr199474495e9.11.1773082681497; 
 Mon, 09 Mar 2026 11:58:01 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dada9116sm26047682f8f.14.2026.03.09.11.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 11:57:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 03/10] target/i386/hvf/hvf.c: fix compilation
Date: Mon,  9 Mar 2026 19:57:45 +0100
Message-ID: <20260309185752.76865-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309185752.76865-1-pbonzini@redhat.com>
References: <20260309185752.76865-1-pbonzini@redhat.com>
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


