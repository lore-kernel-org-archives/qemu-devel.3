Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF56DC3064D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 14:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMTFB-0001x9-9V; Wed, 26 Jun 2024 10:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sMTF8-0001vv-Eu
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 10:03:27 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sMTEw-0003CP-3K
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 10:03:26 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57cb9efd8d1so506860a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 07:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719410592; x=1720015392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hb6LcajEHMuf71XU0VM8Xn9J7SZV1K25f5gPBrNRxwY=;
 b=yGzwtLd9LhUr8Ycfr+MuW2jjKy2gtYEiMG//dIwo88jcUHj8Shjxc+7P1q7iw2WNlO
 cy6gctnbBjQj8HfiNuC4sj/pyFHbhLWruvM4Bt4jASPpLYM9MGFBV202eLRcb77Y+pPp
 dyRG0CowB7Yhy6kkGd3mkuCgoCSukjLjjp9qyBRli2ZAiBti0Nr3by23WTNx5EQ1DoNm
 AwaxMOCxCdaSV/4wv74VfV0vRGSbcwCJCV+CiCVKNCOC8SVwg3OtJFvX2QxEXG2eCDq4
 DMqOl6t7A3bVO7lETr7wduwBb8Wul3qIFHGJ6elt8MYE5gkRrex9JsW4hdiPtFUkPVNN
 7BRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719410592; x=1720015392;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hb6LcajEHMuf71XU0VM8Xn9J7SZV1K25f5gPBrNRxwY=;
 b=pl9N3qxAig2XZVwfPp5C386qVHFqvbYL232D55828zf4/B/80shL5IZ7czhT2Jm4Q4
 WSGW1bDeBZT5WmVCiWRI53OC5lkIJ9pa2+gV6tGBD3D6aDHhyn06PFbT36cGDQsULJUH
 I5CvLZReD/DQkhz75cnz4WfBhG4zDkDEOkqtCkdvM1415Rx38k5ZFNtK8SRXKDrtGFoS
 Gu7TCaj22A6NghEkiBSUllEtXMcX5o6RFUX7wCtEQQCTyZrDbzkrNbZtxAyisbuiFFGz
 c+hb3wJhdBs0Cko1/0ZvoovyU0Bg3TI9W0efFd5AiGDYFCXB8KDE/XV7M4NiF1FHU9iV
 61Ng==
X-Gm-Message-State: AOJu0Yw5scq7EztDo7ljFDTQQmMaQoMv1p6tJ8pbOdWjURpObXU35V9x
 NSNXILlMbNMUJ7W3gPsnbpOR3c/ggFiKFJHnxom7b49MZ4MoA0aVy5CsSh6TArc=
X-Google-Smtp-Source: AGHT+IGlV17/zBQgow1726AbkNZwtdZH1JCC1vuie9PnfspBFdgxeCw+GkOY6yUXX55JTu2Y5kiFYg==
X-Received: by 2002:a17:906:abd2:b0:a6f:e2f1:537b with SMTP id
 a640c23a62f3a-a700e706f07mr954361266b.28.1719410591717; 
 Wed, 26 Jun 2024 07:03:11 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf54923fsm617544466b.104.2024.06.26.07.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 07:03:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5A06A5F8AA;
 Wed, 26 Jun 2024 15:03:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org (open list:X86 KVM CPUs)
Subject: [RFC PATCH] target/i386: restrict SEV to 64 bit host builds
Date: Wed, 26 Jun 2024 15:03:07 +0100
Message-Id: <20240626140307.1026816-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Re-enabling the 32 bit host build on i686 showed the recently merged
SEV code doesn't take enough care over its types. While the format
strings could use more portable types there isn't much we can do about
casting uint64_t into a pointer. The easiest solution seems to be just
to disable SEV for a 32 bit build. It's highly unlikely anyone would
want this functionality anyway.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/i386/sev.h       | 2 +-
 target/i386/meson.build | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/sev.h b/target/i386/sev.h
index 858005a119..b0cb9dd7ed 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -45,7 +45,7 @@ typedef struct SevKernelLoaderContext {
     size_t cmdline_size;
 } SevKernelLoaderContext;
 
-#ifdef CONFIG_SEV
+#if defined(CONFIG_SEV) && defined(HOST_X86_64)
 bool sev_enabled(void);
 bool sev_es_enabled(void);
 bool sev_snp_enabled(void);
diff --git a/target/i386/meson.build b/target/i386/meson.build
index 075117989b..d2a008926c 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -6,7 +6,7 @@ i386_ss.add(files(
   'xsave_helper.c',
   'cpu-dump.c',
 ))
-i386_ss.add(when: 'CONFIG_SEV', if_true: files('host-cpu.c', 'confidential-guest.c'))
+i386_ss.add(when: ['CONFIG_SEV', 'HOST_X86_64'], if_true: files('host-cpu.c', 'confidential-guest.c'))
 
 # x86 cpu type
 i386_ss.add(when: 'CONFIG_KVM', if_true: files('host-cpu.c'))
@@ -21,7 +21,7 @@ i386_system_ss.add(files(
   'cpu-apic.c',
   'cpu-sysemu.c',
 ))
-i386_system_ss.add(when: 'CONFIG_SEV', if_true: files('sev.c'), if_false: files('sev-sysemu-stub.c'))
+i386_system_ss.add(when: ['CONFIG_SEV', 'HOST_X86_64'], if_true: files('sev.c'), if_false: files('sev-sysemu-stub.c'))
 
 i386_user_ss = ss.source_set()
 
-- 
2.39.2


