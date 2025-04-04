Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3ACC3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 01:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0VZ1-0008J8-4Z; Thu, 03 Apr 2025 21:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0VYw-0008IF-G9
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 21:09:38 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0VYt-000817-Ek
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 21:09:37 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so1267569b3a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 18:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743728974; x=1744333774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CU6NEy9CLtG6+OKRjCwFFP8/1QLHp65Fq8Qbm2hbk8U=;
 b=AxChLbVX7DErS5F0R0WJ2oAhgezkGAGl7NSUoHxbazXDb5Gyy6bEGmx7S5G/47ChGo
 yFC+QYWNE4Gl2DiVU/Y/tqEaNrUZM1R42ILELM4u2ISMQLP4NtmCq4LIEZatn6JodkH2
 Ni9krHkgFtXjrfS/Yxz3FYFvPWfKZk30OflYTKwvzULElwffR+LB+gcqvrw1BHTIX1FH
 7DutCeGHINKoK5Yf7Q4WbDiZUugfcOps6KR8MdriPLhQFaWghmlbz7UsPAXSXYREsJr7
 gUOkvO+CbgltdYTMo94Q4Z2m1qwSutj1r2xonY661ihctGrasfG4PH08iH9ivLQY5rpa
 sOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743728974; x=1744333774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CU6NEy9CLtG6+OKRjCwFFP8/1QLHp65Fq8Qbm2hbk8U=;
 b=C5QN2Wj7PwL/rEEBrJ+1pZQS4CxeCiXJVfOb8oB9E6njAII6U0VR5SBhob2+jNkHNW
 KJp/HkHJZFOu/3x6cHBKkbZx57eSZlx/gdXtCLSnTArG8URKBy9ODwQoLWDKlLhIG4cb
 B7Yj7YZRBG/KyKzLG+NNfXEIb/NekVKp6N39ON2s2srKctg8fRRSLertQm6aLzMid3G0
 YxhKGcNgbXCcDIXWqKJRif1xSgZbEFVh9A+UsKeOTxvoQmCYTasXuxZ2EMIMcd+/S9na
 VLZ8MEu5L1IemILceK0EY/Oj4gimGhRT/39+IOep/63efuSKvIRK0n6K+zgdTMM1QJyd
 pG4A==
X-Gm-Message-State: AOJu0YyIEU7BLPlYOdeno6mGqGaShZZmE+BPZnw2EuyXz6yXCDa4+YWa
 Sjuq9Bu5PfRi4ezezahV0Pv7j0BfGApCp6I3d4yrTvlubQ5OuCeK7M3Z8SR2cJz4dDMlnZNcZ6Y
 7
X-Gm-Gg: ASbGncv2WPPknAfW/lko/fZque2T3ULYEjrDkiMB9PXOdf09SDEJRqChHB9CHv/eVlV
 HMROADOGr6/YEBF+KCKsPiaQhVSAbwSlRHtiUJMl6MesRmrS81Oodj4lATRRZytMi+/Fog9wh4Y
 0VtXWiIK3+EpXbVNXcb5zqY/ef40tEGupHLRI+QUI9ZYEsHt0sfpfwAX2qdPUSzUMKOfjYh3ovo
 GWoLQ/QLFIEHJGkpMdtxkywh9GRKc/KLAW7nG1fwBhQN3MANNll7x7Ez24JAQvZDngyUYLTRVzQ
 9oY89Qw7rKq+2b7CUjs1sSMhx0Zpmw4GGSJD8cR9VgmMOofM8bw=
X-Google-Smtp-Source: AGHT+IE2Jw3LfeT/r2OUagy2Iogj7bT0mMi8d36rlTLM4X1OKG6TjERnI+Sh5yIjKaPQv/n9t59ozw==
X-Received: by 2002:a05:6a20:7f9e:b0:1f5:97c3:41b9 with SMTP id
 adf61e73a8af0-2010444e36dmr1860961637.5.1743728973975; 
 Thu, 03 Apr 2025 18:09:33 -0700 (PDT)
Received: from stoup.. ([75.147.178.105]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee2d9sm2171755b3a.39.2025.04.03.18.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 18:09:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 2/6] tests/functional/test_aarch64_rme_virt: fix sporadic
 failure
Date: Thu,  3 Apr 2025 18:09:26 -0700
Message-ID: <20250404010930.164329-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404010930.164329-1-richard.henderson@linaro.org>
References: <20250404010930.164329-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This test was randomly failing on our CI, and on dev machines,
especially with QEMU debug builds.

>From the information collected, it's related to an implementation choice
in edk2 QEMU virt support. The workaround is to disable KASLR, to avoid
accessing protected memory.
Note: this is *not* needed for the similar test_aarch64_rme_sbsaref.

More information is available on the associated GitLab issue.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2823
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250328183816.2687925-1-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250403203241.46692-2-philmd@linaro.org>
---
 tests/functional/test_aarch64_rme_virt.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/functional/test_aarch64_rme_virt.py b/tests/functional/test_aarch64_rme_virt.py
index f4ad4d33d5..a1abf584f0 100755
--- a/tests/functional/test_aarch64_rme_virt.py
+++ b/tests/functional/test_aarch64_rme_virt.py
@@ -87,7 +87,9 @@ def test_aarch64_rme_virt(self):
         self.vm.add_args('-fsdev', f'local,security_model=none,path={rme_stack},id=shr0')
         self.vm.add_args('-device', 'virtio-net-pci,netdev=net0')
         self.vm.add_args('-netdev', 'user,id=net0')
-        self.vm.add_args('-append', 'root=/dev/vda')
+        # We need to add nokaslr to avoid triggering this sporadic bug:
+        # https://gitlab.com/qemu-project/qemu/-/issues/2823
+        self.vm.add_args('-append', 'root=/dev/vda nokaslr')
 
         self.vm.launch()
         # Wait for host VM boot to complete.
-- 
2.43.0


