Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AB6CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 12:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v66R6-00043k-I2; Tue, 07 Oct 2025 08:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66R2-00043T-CF
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 08:04:52 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66Qr-0002NK-RM
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 08:04:51 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42421b1514fso2907241f8f.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 05:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759838677; x=1760443477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M7Mgd7EkPdKSfhCjuk7ndXTip3GHUcWefr6E/eQKgoA=;
 b=ylSzixdF6MlYWsraeByrLgC48M4NjjOliXloVejhx+HHLSyftFLfzUK1O0cyWv3qix
 mmWBeUNfN/l1Vj+WRnvp/mKR+BwxAet+kt3cYO83m8tFNDYB7aDuFJuhqvicYicDhuif
 ASWQ6agmd0/qb1zFMsvGVJ5c+dqf4PAYvDlx9nvtDX1lsB3Mp51jh6u7R3J6Vu+MII2x
 G2CDFm1lJEUE8FW1knBIgRwdE+GJSlD2AXlnch319h8SkflHe7RSJVjW9SLab0L0ZHxz
 xJlaJbmZkqQIqhb98k+zzP+7zpY2fJXzJMlKJpJsJHzrjljXTYgmXfOOcJEa0zX1fdaF
 mbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759838677; x=1760443477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M7Mgd7EkPdKSfhCjuk7ndXTip3GHUcWefr6E/eQKgoA=;
 b=iIYx6s3it6k91KzErXo77aRmaBpDtQKypfokygM+EXDn1ZRi1gB+QyvQdIqF1TYfrK
 uzlsutNiyBJ2dtVrF1w0FU41wqwvSu5si3w83rNpPBwyXxx8gnGlJe16eZJmnbJhZU5F
 oG8vaTprmaa7mDMqC1JsrCGp8EEODtfgoq8ycF4XeqjeNU8LIb5xB/uFLG0BpHoA566+
 UrkCm5Cw4sTle+5k5CWnJKS2GGKMhrDWotXsrd+MYeBqTqyF5w4Tc+46nu6R29CNEAW6
 Hn17iHlIt2ynuQjIEFj/AJ/99OllLJEvwkCCg6u54jG1c2yQKy/3ygninx0xYcEst/NZ
 YTmw==
X-Gm-Message-State: AOJu0YyRUxgbZN0Np7oBtz+qz/bcdfnFf0+ZZns242Y2YwAg4zk9LNKG
 DaGv+aDzT4h4Y8yFpMf77Yy0p9onDFmxljdjKFen8HhGvl1/Qh+irFC2Id1bSVU/+Fc=
X-Gm-Gg: ASbGncto9mzlXYWNp6f2RxbmdPl/kkuntY4wXeNdmGHJWknL6Sq81jLTcYwhcyRodOU
 ULZAT3TQotpIbC9ASnAFY9RGFBwjn8USB0wkCYbq/4imhS/VlPMYpszHln10dn+OY73jPLtQYeb
 P7E7Aj/JiH7jy4+2BXvaJEJajn/W6NNcOAhZZEDJ27flWBBgzXXpPF2Kpn5iycBcoid6H+MQJcE
 448S9qQax0pATr4R9IitXj5iPDSupLLUFalIL2Lnc2gecH7D9888hbK94L2xNSne13+jIHtNCpD
 lt8oR0KSNcG1sqtyDqvXPAdUsvbjWLMAXW/BgNkCSaYtdBx8TDmm4pPcD2p8LWiCqBL682U0V9R
 Ld/zegJnkbnXP5CIvGEbm1QZfPXHhzqFm/Vr89SOLn1mIqE6hyLETCN0cZm+92A==
X-Google-Smtp-Source: AGHT+IH4BiMrNErjv+gRrlQf6aUqwG3bGP+pBNdEfeHaYTAoXmejcUG6PyGlgOIDiHGMj4T7s+R82w==
X-Received: by 2002:a05:6000:603:b0:3ea:6680:8fc4 with SMTP id
 ffacd0b85a97d-42567139e59mr8727394f8f.8.1759838676767; 
 Tue, 07 Oct 2025 05:04:36 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6c49sm25357882f8f.3.2025.10.07.05.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 05:04:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7DE0E605F4;
 Tue, 07 Oct 2025 12:55:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Vladimir Lukianov <1844144@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 17/17] record/replay: fix race condition on
 test_aarch64_reverse_debug
Date: Tue,  7 Oct 2025 12:55:25 +0100
Message-ID: <20251007115525.1998643-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007115525.1998643-1-alex.bennee@linaro.org>
References: <20251007115525.1998643-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Vladimir Lukianov <1844144@gmail.com>

Ensures EVENT_INSTRUCTION written to replay.bin before EVENT_SHUTDOWN_HOST_QMP

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2921
Signed-off-by: Vladimir Lukianov <1844144@gmail.com>
Message-ID: <20250603125459.17688-1-1844144@gmail.com>
[AJB: fix re-base file mode]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/replay/replay.c b/replay/replay.c
index a3e24c967ae..b2121788c1d 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -263,6 +263,8 @@ bool replay_has_interrupt(void)
 
 void replay_shutdown_request(ShutdownCause cause)
 {
+    replay_save_instructions();
+
     if (replay_mode == REPLAY_MODE_RECORD) {
         g_assert(replay_mutex_locked());
         replay_put_event(EVENT_SHUTDOWN + cause);
diff --git a/tests/functional/aarch64/test_reverse_debug.py b/tests/functional/aarch64/test_reverse_debug.py
index 906f10aec55..ec3348c96d8 100755
--- a/tests/functional/aarch64/test_reverse_debug.py
+++ b/tests/functional/aarch64/test_reverse_debug.py
@@ -25,7 +25,6 @@ class ReverseDebugging_AArch64(ReverseDebugging):
          'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz'),
         '7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cbbf7')
 
-    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2921")
     def test_aarch64_virt(self):
         self.set_machine('virt')
         self.cpu = 'cortex-a53'
-- 
2.47.3


