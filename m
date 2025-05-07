Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38360C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoPx-0000HZ-Ek; Wed, 07 May 2025 19:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPh-0008K1-Ru
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:58 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPf-0002Tc-34
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:57 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-306b6ae4fb3so537412a91.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661374; x=1747266174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Emf7r2NlJCGBegzvSaP4+YNHnVcvC5KK1KGZi+oKRes=;
 b=l/NRFdx7KeK6SGnj3SaZFCDFnLrSixgR7dYe1UpedJA0nZKVqQs6TQPaYCnBM9tnPJ
 Bzt+um0J8d6pHqKlIqekz18WTBiPbU+CKrDUSVxjcdyC5TYFNSkNA9KiOyAnCTr2tvlV
 3ab47skfYHQ9ctALsoBAmkIKfuYf2KkXYLLAIfsKgLYGVOqT0CoL9OiysPdYe8KcOcd/
 6TO5KAhGxwyeHh/3FBjt1FobOkXwLZZpHgYmVk3HvAPcmwF3208PESrjOVgDQhjUytKD
 gKwtQ0pBVGiA1YcBdIGKFIeZ62f9S/Z3fynx93zzrHrxFxI09t57mssUcvWoCBsoUiKL
 1cAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661374; x=1747266174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Emf7r2NlJCGBegzvSaP4+YNHnVcvC5KK1KGZi+oKRes=;
 b=tzm1YTE5wankHsRiwrVgx7tQq/HkW6AA9tikooNmW5ROORaayhkqf5CrL0dCx95/hi
 oV14+x2B6BDFfiqVHP/diZlYhU/zODvqtheJlBi+Gx4Ja5LksSKTRSHXiBZe6ECIo+z1
 f0LrSOXsvvR4Z1ETMBA6M8eg42Xo1ASacz3Iz07K6qrkPKMqDXTQ4GPQTcN9KRnVMWIA
 GFy0z1hWuix9owcRimAjNF0JKeTDT8pDyR9iwWl9L1FUjuVb2GJl8C1WQZmRH1AkXm1U
 TcH7oAH+p2pfuu1p4/fSQEsB11C/90N1Kpav+XkmTouKx+q4dsl4vtTDKo9cDOLdUWUR
 Uaog==
X-Gm-Message-State: AOJu0YyOrNb5lHKofjJuCZnKwYn9BJr8uwuPJteOVx/Lyc6lwOEYb8Dc
 +XYlpuvKBSXC8XwEKQy6FGD0pWRjEZVAsx9TkhHugFoFIz5JvOzbzk9+ZiUmolE8JlHSW53OLh+
 iWSj64g==
X-Gm-Gg: ASbGncudnYL2KL2Ua5neY7QYU/FXBTXLTDZEUu3COipLwdZZ7ZfEbPIMjOrYg5/VUdv
 JqPIGBr5/EeDpJKpYHMHPYBQwJvHfmYhgxUcEhOHO1F1iGvTi1V1YHV9NEe3CGFgzXtMjIjbx6p
 9fQfdASLW96k8ad+mQlw1tYWcUz8sHMeuJH48oonG8lXmM85CJg0GXc7Vj1unXGYGOy/s3EPskl
 s7cc7XTKTGTkiwV3XT1OZ3cACq/QPreON1fIWACs+MVXI1kdlgv+4P4PtcC8B2VOoKssOGTprE4
 DRM63yvpEWuC/HFEWaWnn2wuCj12eYuqaPsdlobO
X-Google-Smtp-Source: AGHT+IE1rBPDLrD6YLcWU3G7gZr3FdqQdmTaG8RZa7lQY5J0VPLlZx24DjvL1QOATkDhsEsdcxhtug==
X-Received: by 2002:a17:90b:278e:b0:30a:2173:9f0b with SMTP id
 98e67ed59e1d1-30aac290fe1mr8070966a91.28.1746661373761; 
 Wed, 07 May 2025 16:42:53 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:42:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 12/49] target/arm/cpu32-stubs.c: compile file twice (user,
 system)
Date: Wed,  7 May 2025 16:42:03 -0700
Message-ID: <20250507234241.957746-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

It could be squashed with commit introducing it, but I would prefer to
introduce target/arm/cpu.c first.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 89e305eb56a..de214fe5d56 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -11,13 +11,9 @@ arm_ss.add(zlib)
 arm_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
 arm_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
-arm_ss.add(when: 'TARGET_AARCH64',
-  if_true: files(
-    'cpu64.c',
-    'gdbstub64.c'),
-  if_false: files(
-    'cpu32-stubs.c'),
-)
+arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
+  'cpu64.c',
+  'gdbstub64.c'))
 
 arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
@@ -32,8 +28,12 @@ arm_system_ss.add(files(
 
 arm_user_ss = ss.source_set()
 arm_user_ss.add(files('cpu.c'))
+arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
+  'cpu32-stubs.c'))
 
 arm_common_system_ss.add(files('cpu.c'), capstone)
+arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
+  'cpu32-stubs.c'))
 
 subdir('hvf')
 
-- 
2.47.2


