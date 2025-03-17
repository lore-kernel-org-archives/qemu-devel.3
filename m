Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC93C28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 11:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu8Si-0003H9-N7; Mon, 17 Mar 2025 07:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tu8SZ-0003Dj-OB
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 07:16:43 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tu8SV-0003lA-JE
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 07:16:43 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-223a7065ff8so33441085ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 04:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742210198; x=1742814998;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nvZxXJ1GvFvx4INbCk9ERB4VBpXlB9W+lCDR6eWj6sU=;
 b=H+T2cYL7X13cQy/ILr0gZ4ommCJzEMgEryES6tKL7Dn+OizwwbEv8Ms6JolnzPF5O/
 6oIBNlydBU2i9RtDRyrs1DVEOp4nXa/kqiFk0MnvvrEXNl+YuwWmSpF66mIbsl2FD+af
 G5SRolE4add1EYVN8Z8kZhXW3Ebvi8hYY+lmm8gvS5IIhcr2axdZt5M1j09ZqSU7BEby
 FXY/1dLT4CVcE9lUVfZ6Ea0mT6sABXQkqRu/ugf7qEkn96kF1qEy7v7zqj0GpACY79I5
 FGjswFqhYyqPBPiZG1AJYPwdwVb1JtrybxJgB9SaDF7mDJglWSz/xdhXPC7CQZIaZM7o
 7/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742210198; x=1742814998;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nvZxXJ1GvFvx4INbCk9ERB4VBpXlB9W+lCDR6eWj6sU=;
 b=j9+fEhFHTBIGmSmZXfwlsNHeO9i5Rega+eYhkONzdL5aPFX97wK69au+QLNHxu4U8D
 f67OJsKCh9bru7xye76sxhnbAqHQ3w9iOZZxTmhbYW0Ti00s5LqEFhy+VL7WuHsfnGe5
 c6/IYBavt71FnPH2Lar+WLUWV2qFuprHO+bI+u1ABJM2o0G9mj/Y8/yKrXJTy2oIJ5C8
 SvSmH9KNvC5pY/o3/6j7Jzo6Lm6bPw1bh9XAJ7Or+hUj67fhpX78PuabEXTuz1TedXr6
 z5/lnFYtDSvaMAuczvatt199b+iOBwujL3PcUsWka/IP1PqG1lrxMTkb+PnWJsxGKySc
 RQ0A==
X-Gm-Message-State: AOJu0YxIxfi8WGNcojQoxF3vefxSM56oLWowCYjcDq8Wdrr7kToHs1Hc
 gi1M+UUeBMDs2xD7YKNDehTfxu/CHmLkJgadzB3Qt+/IHHKu5LWhJHgxD906rC0=
X-Gm-Gg: ASbGncsbYHAZUeHYd/gvYJYkokxid5AW5yIR4mtPDpHq0J6YaXAGmeLEYT0wbD7YQ4K
 Vua3g1cw7MBPJ45GCoB0hP8G91anIKQh5kuwZCA37ENiod+Rz8gyHLWXNb/osSXfoOKoLm+Mhz9
 FguK85W/rQj3BRBM4GBBGQeUtPzgD2PdgEcV6Nhj4VxEIH/UbOlb0lL3qSQZEU37SIUxxad+R70
 SFaU1eXX6t5Mf28Z5FtyCahTt+Ax5i8EYoK2rdT8OGaJr1CA7gaPLzVmVQb9kQ+Zy5o8Hz4b1Xg
 r9dbnObE07xOQ114zF4Uj6WrrX1EYti0u/Ae2o3y2bBCePfE
X-Google-Smtp-Source: AGHT+IEVqDXHHFE6x727TS/DtRWBMYY1HDZ/XgkQyqYFQrWK4neiNqcXxXDVqi8EhX3DeUmi9s6WUQ==
X-Received: by 2002:a05:6a00:4f82:b0:736:3d7c:236c with SMTP id
 d2e1a72fcca58-737223b9711mr13501161b3a.14.1742210197806; 
 Mon, 17 Mar 2025 04:16:37 -0700 (PDT)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-73711694430sm7254565b3a.122.2025.03.17.04.16.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 04:16:37 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 17 Mar 2025 20:16:23 +0900
Subject: [PATCH 2/4] target/arm: Do not imply ARM_CP_NO_GDB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-raw-v1-2-09e2dfff0e90@daynix.com>
References: <20250317-raw-v1-0-09e2dfff0e90@daynix.com>
In-Reply-To: <20250317-raw-v1-0-09e2dfff0e90@daynix.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Do not imply ARM_CP_NO_GDB when ARM_CP_NO_RAW.

A register without raw access support may still expose some state to GDB
that is managed by something else.

A register may its state with another register but may not be used for
either migration or KVM state synchronization. For example, a
multiplexing register cannot support raw access. KVM may also have
a problem when synchronizing a register.

Such a register can be flagged with ARM_CP_ALIAS | ARM_CP_NO_RAW, but
its value can be still exposed to GDB as it's usually the case for
registers flagged with ARM_CP_ALIAS. ARM_CP_NO_GDB should not be implied
in this case.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/arm/cpregs.h  | 8 ++++----
 target/arm/gdbstub.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 52377c6eb50f..99e2afc84250 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -75,10 +75,10 @@ enum {
      */
     ARM_CP_IO                    = 1 << 9,
     /*
-     * Flag: Register has no underlying state and does not support raw access
-     * for state saving/loading; it will not be used for either migration or
-     * KVM state synchronization. Typically this is for "registers" which are
-     * actually used as instructions for cache maintenance and so on.
+     * Flag: Register does not support raw access for state saving/loading; it
+     * will not be used for either migration or KVM state synchronization.
+     * Typically this is for "registers" which are actually used as instructions
+     * for cache maintenance and so on.
      */
     ARM_CP_NO_RAW                = 1 << 10,
     /*
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 30068c226273..4459e90811b8 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -270,7 +270,7 @@ static void arm_register_sysreg_for_feature(gpointer key, gpointer value,
     CPUARMState *env = &cpu->env;
     DynamicGDBFeatureInfo *dyn_feature = &cpu->dyn_sysreg_feature;
 
-    if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_NO_GDB))) {
+    if (!(ri->type & ARM_CP_NO_GDB)) {
         if (arm_feature(env, ARM_FEATURE_AARCH64)) {
             if (ri->state == ARM_CP_STATE_AA64) {
                 arm_gen_one_feature_sysreg(&param->builder, dyn_feature,

-- 
2.48.1


