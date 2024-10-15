Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868C3D216AC
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iN4-0005rU-Sz; Tue, 15 Oct 2024 10:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iN1-0005me-Ny
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:17:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iMi-0003Iq-Eb
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y+sWyoWzl7OLbzMSWkeo43oPGLPNthU9tY/ZPrpiBTU=;
 b=i8Vxy/hbR4dJncsFVvaaYTgfmvxVpWb3gJTq0CIaxtu8EpjMrxjCzPRlinriq0Jw26aJeE
 zX4ZfI+0VnYgG1JxRngUIPdJ+/RUdci7i/1+Xq6TJ7ELZvU52DeHO2tbHDFBJ3hDER2v9d
 uFmcwM8KpvyYRKGuTP1Wx04zyxmiOS0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-1qIxDB9iOOanH-HLxoJ2pA-1; Tue, 15 Oct 2024 10:17:30 -0400
X-MC-Unique: 1qIxDB9iOOanH-HLxoJ2pA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d3e8dccc9so2724190f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001848; x=1729606648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+sWyoWzl7OLbzMSWkeo43oPGLPNthU9tY/ZPrpiBTU=;
 b=PdLSMvpXM/5j2R49DysqjLXZ4s83CI0cuJb6/V7o51RKN/yZFX3XJNJKKWMK71FJp3
 dqwD7Ehvb5IhzTkinHUWAirwWOhyAFQtZWRqNmn56xGlB4bn9ltqL9H96CFiWMxlCiWH
 wu4s1xO1Fwn8Dd4xyfZzZxKqJ0sGX5hZ/ZUwCBE06Li3iqJ4dXkLXfF3LjqYYViQyy3j
 /3IhDTmDA/AMYlmKkh1lBflIFAfT5xNP1wVnA6soDtDo9Jei9vYl44j+8it3pdXFth+E
 AVJcLzILSyrxRNG1p9ozA6lsfqtu+dsjfThyyGsnqi6HMFAXAq5hMM0OzUVpIRxzzcrN
 XIIQ==
X-Gm-Message-State: AOJu0YzInqEWHyu4NhH1RrR4zd8WMYJ1CB7h0E6nFFvnqsruCgUp1q7N
 Pb1KqqShpiSVKJCqZ8v8aWCMiSFQiynXLGTQJIP+b52vMKRP6aknopRyy5fBsNXrxHQ7J557Zjp
 FDGqolsSMo3woRQL4Yq16S3ePbEmvnyPzbZHo1tumV5EW5QXD2+Z5t4lWnL2Ydyx349y/EeaC2S
 9vZqTyrrqcqFqwQy/Af7bEQIoNVPLLNBGqsiqAQMs=
X-Received: by 2002:a05:6000:e52:b0:37d:50e1:a2c1 with SMTP id
 ffacd0b85a97d-37d5529d2d2mr10586691f8f.46.1729001848608; 
 Tue, 15 Oct 2024 07:17:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHn98+33rhfygEHkkLOjgan1wXMqLK5zIkFNwnGiub6p1TsXgecO5xnXaS4Ld0kpgIk0mO2g==
X-Received: by 2002:a05:6000:e52:b0:37d:50e1:a2c1 with SMTP id
 ffacd0b85a97d-37d5529d2d2mr10586670f8f.46.1729001848118; 
 Tue, 15 Oct 2024 07:17:28 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a23csm1705482f8f.18.2024.10.15.07.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:17:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 04/25] target/i386: Make invtsc migratable when user sets
 tsc-khz explicitly
Date: Tue, 15 Oct 2024 16:16:50 +0200
Message-ID: <20241015141711.528342-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015141711.528342-1-pbonzini@redhat.com>
References: <20241015141711.528342-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

When user sets tsc-frequency explicitly, the invtsc feature is actually
migratable because the tsc-frequency is supposed to be fixed during the
migration.

See commit d99569d9d856 ("kvm: Allow invtsc migration if tsc-khz
is set explicitly") for referrence.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20240814075431.339209-10-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 089b651591b..5535f4e6ab4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1865,9 +1865,10 @@ static inline uint64_t x86_cpu_xsave_xss_components(X86CPU *cpu)
  * Returns the set of feature flags that are supported and migratable by
  * QEMU, for a given FeatureWord.
  */
-static uint64_t x86_cpu_get_migratable_flags(FeatureWord w)
+static uint64_t x86_cpu_get_migratable_flags(X86CPU *cpu, FeatureWord w)
 {
     FeatureWordInfo *wi = &feature_word_info[w];
+    CPUX86State *env = &cpu->env;
     uint64_t r = 0;
     int i;
 
@@ -1881,6 +1882,12 @@ static uint64_t x86_cpu_get_migratable_flags(FeatureWord w)
             r |= f;
         }
     }
+
+    /* when tsc-khz is set explicitly, invtsc is migratable */
+    if ((w == FEAT_8000_0007_EDX) && env->user_tsc_khz) {
+        r |= CPUID_APM_INVTSC;
+    }
+
     return r;
 }
 
@@ -6124,7 +6131,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
 
     r &= ~unavail;
     if (cpu && cpu->migratable) {
-        r &= x86_cpu_get_migratable_flags(w);
+        r &= x86_cpu_get_migratable_flags(cpu, w);
     }
     return r;
 }
-- 
2.46.2


