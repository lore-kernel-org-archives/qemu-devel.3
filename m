Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782BBCF6497
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 00:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLsMK-00039l-Qy; Wed, 19 Nov 2025 19:17:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLsMH-00038g-PN
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 19:17:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLsMF-0007Qh-VU
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 19:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763597827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+VnR7WQ4phvEKh0Jwt424ldKYy6fvpgQ+MNLeSCq/oA=;
 b=LA6wBKTvMI3mSaJJGuiK1czNv/uhDJn8Ngjk8c2/YKVxfZDmn+gxpE9TAXPTpvm11jURbk
 sxior2efXxkyyUZ7K+KOO7ftF5DLAtFi14ud7H6GCPReS6A4oowr0ouvdwSY9KIJzkOyhL
 V6F/k60glGhF7jlzo3CWjK4g792DtmU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-lV0o60ajPtiag8ua0lqAjg-1; Wed, 19 Nov 2025 19:17:05 -0500
X-MC-Unique: lV0o60ajPtiag8ua0lqAjg-1
X-Mimecast-MFC-AGG-ID: lV0o60ajPtiag8ua0lqAjg_1763597825
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b352355a1so664924f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 16:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763597824; x=1764202624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+VnR7WQ4phvEKh0Jwt424ldKYy6fvpgQ+MNLeSCq/oA=;
 b=nrl5YH79EV9Exw0vWDfpwKLCUEyTNL03+jDc3rtjc9koUUdCeHqvpIS3F+/iIQi6Ui
 O1bB5WvrEQhd+7jekB/xCsef6evVpO2ES3fyblrIrmDEVB3r/i3uZezsNJuwZ2mBxuco
 ptMbEbkIDEZQbbWmWpvRYh+STMGzp96Dtue8eEo8gwCO/dZGHqgdRuiX5oCvEr3TUqrj
 mynJAs6r980m96Usth7cIomZlfovZumnO6TcP3Vo5/nHIZ0URTndsavV6ubsHyVXwbAL
 CGsXgB8eJ1TrXlRaIN+aIM6Nk6B2lnlp12H1avGYdAI7ECODbhWasY2EHazt2MH224iF
 LDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763597824; x=1764202624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+VnR7WQ4phvEKh0Jwt424ldKYy6fvpgQ+MNLeSCq/oA=;
 b=LmXAG2Fe48nhU0PRDg7qClExcDn1ftIZ4tm9ZfnD6TAzv6xRc824wblBUd/YaFKfYB
 las3kZxF2r+zREDuVWavpUUq185bB6Lqv9A2ofRtoFKdl3igK4qb9vZjgFA1CCR8cTMR
 Qoddi4tSFdNeu5qbsm12Sp3gjeY6IHuy5djUH84KqoDwkMDUgCich+ce1p8gV6gEgR+c
 uz0rYbHNoXwoxjSScJLXfidU3Rf2fmOQzICIzayIInJ/trO1aNfSGfJ7HLW7LeWMXy3H
 9mBubZE6EJdkRvKSHyM5/+DyyhawaBivSxmbF0BrHbYaBr0G8F9VT4gUBEBhV8CWlHTo
 YOzQ==
X-Gm-Message-State: AOJu0Yx7/xqjpeK+weR+ZG9g5/Qe4BGdjSJWtGlrgzxJKCYs8Y6P1gJU
 V+7T/IqQsdTyzP5xWJVB/L2erb2XBsljjgmqndtJQfygWWjgEPgelDHgrh6Bqdfdhz7Idpn6154
 C5/RHYeCe1WNYJh7AyhL9n85fiy5ye7VCBBTxWhnEUEGj39O/Xx8Nqu9vumguNgJyzun+E4u/zT
 QkcQO1nhMNW1Af+RAFhmAlmZNh70iPKIJzo9cAipTF
X-Gm-Gg: ASbGncv35EZsI67G+9QRdrnxZYH1wilUthaXclKd07jMVvmozrETmztVijPy5OueD9b
 FGYaodA8RuXz/UpBKxWEj2aUYkt8CHhZC/M1MxFTe/y981ulVsxiQRAKEmK67T6qcOmCTadPFkn
 BYc6HLHGx0fpn5IRCuX8uq5cxIGXPnSxXWH6doyMJ4XB9piW1X1KQOoA8i4V2MjzY/cILDiBfuU
 78KPQ+wEOfDoY7acWaIghNlJ58k9mqfy1TupJ3gJYOjFrjwue4wZqw50Nrwh+nPE/Ng5WjdXwUS
 qJAUs2/VC1uGmFhhjvaOTJXJ7GgzOX/1uO0Mge1h53olOOvJc4bmGKdEKpaha+SQCvhfHROyKM6
 dHztDQaZw12mUFczerkfAIIG+doIIPinl0yiME1J2dINbzatnYN/55mtJv6EROc/7w7+NVMgmx1
 ussmsGdYiH+a50b7c=
X-Received: by 2002:a05:600c:5952:b0:477:3fcf:368c with SMTP id
 5b1f17b1804b1-477b9ee4fbfmr2115715e9.9.1763597823842; 
 Wed, 19 Nov 2025 16:17:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNPTSYh1ymhmLyrT7IPljGvzm4VXNO4iGtc/i1HKup8BrNsnZ0PnP/2mI5ru6Hdtz0fPeAlg==
X-Received: by 2002:a05:600c:5952:b0:477:3fcf:368c with SMTP id
 5b1f17b1804b1-477b9ee4fbfmr2115565e9.9.1763597823456; 
 Wed, 19 Nov 2025 16:17:03 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b10804c8sm76635165e9.15.2025.11.19.16.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 16:17:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 05/10] target/i386: svm: fix sign extension of exit code
Date: Thu, 20 Nov 2025 01:16:44 +0100
Message-ID: <20251120001649.1085913-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120001649.1085913-1-pbonzini@redhat.com>
References: <20251120001649.1085913-1-pbonzini@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The exit_code parameter of cpu_vmexit is declared as uint32_t, but exit
codes are 64 bits wide according to the AMD SVM specification.  And because
uint32_t is unsigned, this causes exit codes to be zero-extended, for example
writing SVM_EXIT_ERR as 0xffff_ffff instead of the expected 0xffff_ffff_ffff_ffff.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2977
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/helper-tcg.h        | 2 +-
 target/i386/tcg/system/svm_helper.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index be011b06b7c..e41cbda407a 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -99,7 +99,7 @@ void cpu_load_eflags(CPUX86State *env, int eflags, int update_mask);
 
 /* system/svm_helper.c */
 #ifndef CONFIG_USER_ONLY
-G_NORETURN void cpu_vmexit(CPUX86State *nenv, uint32_t exit_code,
+G_NORETURN void cpu_vmexit(CPUX86State *nenv, uint64_t exit_code,
                            uint64_t exit_info_1, uintptr_t retaddr);
 void do_vmexit(CPUX86State *env);
 #endif
diff --git a/target/i386/tcg/system/svm_helper.c b/target/i386/tcg/system/svm_helper.c
index 505788b0e26..4b86796518f 100644
--- a/target/i386/tcg/system/svm_helper.c
+++ b/target/i386/tcg/system/svm_helper.c
@@ -128,7 +128,7 @@ static inline bool virtual_gif_enabled(CPUX86State *env)
     return false;
 }
 
-static inline bool virtual_vm_load_save_enabled(CPUX86State *env, uint32_t exit_code, uintptr_t retaddr)
+static inline bool virtual_vm_load_save_enabled(CPUX86State *env, uint64_t exit_code, uintptr_t retaddr)
 {
     uint64_t lbr_ctl;
 
@@ -723,7 +723,7 @@ void helper_svm_check_io(CPUX86State *env, uint32_t port, uint32_t param,
     }
 }
 
-void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1,
+void cpu_vmexit(CPUX86State *env, uint64_t exit_code, uint64_t exit_info_1,
                 uintptr_t retaddr)
 {
     CPUState *cs = env_cpu(env);
@@ -732,7 +732,7 @@ void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1,
 
     qemu_log_mask(CPU_LOG_TB_IN_ASM, "vmexit(%08x, %016" PRIx64 ", %016"
                   PRIx64 ", " TARGET_FMT_lx ")!\n",
-                  exit_code, exit_info_1,
+                  (uint32_t)exit_code, exit_info_1,
                   x86_ldq_phys(cs, env->vm_vmcb + offsetof(struct vmcb,
                                                    control.exit_info_2)),
                   env->eip);
-- 
2.51.1


