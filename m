Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942D8CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 10:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNq7T-0000lD-4p; Fri, 15 May 2026 06:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7P-0000if-G6
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:11 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7N-0001ic-NT
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:11 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48e56c1bf5dso52697415e9.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 03:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778842208; x=1779447008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dup29y+MxaZpk97qGhhclnB0cMFe7/wcvev0GZSAPHA=;
 b=GU/y0Yps8XuIFdFQd6alyurrClcxNxGqitWzfVP15MN8tpgFC2dw3RU0I74ummRABC
 kqflLPuVItseF5ZtO6N4W327TSCjlYWxfCp6jkiO5s3ZUwJAQ+qJryS1uTj7wew1uGbY
 c9zGGn1B7w4aqS1KN6KfrVZwStTld92QQUDT2glxMRyD+7iFWserXeTPnGPopHJP7giK
 zWPNz795JgHdQELpC+KBtKAi3Yemv9OA8h0pEJSkge1dFqAbxRfr02fsMD2nLw+HQDGq
 FN1D9nJAne+au1tbNccnOaP0gw2jJiwKsDlq6AhxQEHYd7XK9uZC36aeDxg5KSYifzeL
 r/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778842208; x=1779447008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Dup29y+MxaZpk97qGhhclnB0cMFe7/wcvev0GZSAPHA=;
 b=Qw9eI909EjJU0/dinKW9NTTvn83il2JYe3AxgWAq1JH9D+Ies884VPEf79ql3RpxKO
 aNF8hW36nU3AsIF+vhTyuFE3TEzE1nVQS/UISrf7pmCRHr2Qtlp8A5VB7XQdNxFH6LQw
 /xRMH0S5JG98Iz/I1V+kB9XwfULtdI5BlC5tOEuvUC7lhQqfBzAkqdQ1vJNv6bVRtoxr
 O0G2C7TYaXkreRwWug9lx5zTi4P/A/0CR3bquzQJH16313UxxULMPb2GEZj8wdXjGklE
 P011BQfIsyBn/5JqWfgxjtAevKYI0nZjw9+U1thaW9IUrmXKZ2Z89hWAdxJkMj89O+Aa
 MpZg==
X-Gm-Message-State: AOJu0YwTSaKIZOJngSDVcgvV6H0NjM7Ey7AktDH3X8o9UpQ0WHiDs7ij
 gkMOXeEQLB8WOYXOQcUYWfJjYiyILq9r6Dt8n4dCsHpXwduKb8uGkmBBuZTp7PVhyLhDkqHKTK+
 kButH
X-Gm-Gg: Acq92OGfdSoJLN5fn9emCJ02PlmORzJOkcMLfLZKy51fm9zkBFGKaoM0iQh8/4OZMCJ
 4Z3SCFtryt9xpI/JX1Jta+D5SLNbw1GTG/zPyOd96ZD1Z/4JQsx5BvytISe0eHYE7lj69XzTVMH
 D8NrEemxgaUAkQ5RgT9CWTZ/ahECrlrf5l3V1P2R6v0eaJt0wMIumlFDV8YDXmvRgoDMRNo8fB3
 zSuSnC1Lkm1pfa1aTqnNPNgxkPDDzSkiSEIYcdCRraSIqD2sU4E3UzZpCb3jGV+OzC8Enlm/kd3
 7V+Ddzk36nCplC2Z7cmtKzQmrm/j+6NU152lxUFj0vpyJwgnjb8N4iRAZ3NB581Clb5W/98kpXr
 /RWDs776cvEFBMZH7wY3oscFh1l3TeL+oWDKTl+eDugfXKM88m/xrw0Jp5UZNzXFTY1UVo5nfx1
 FnEGY/6nFA1U0CvIfb1Nkp95uwbJf9GBmJ8q9dXSenG2himydGyk/rCA3/J3ud/Gd5D3P0AO/Pf
 ziRwu7neSn8XWlwXD3VES7b6f5/Pdo=
X-Received: by 2002:a05:600c:c168:b0:48a:76a3:2b9b with SMTP id
 5b1f17b1804b1-48fe61ed360mr53301295e9.17.1778842208215; 
 Fri, 15 May 2026 03:50:08 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2949asm18194355e9.1.2026.05.15.03.50.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 03:50:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/23] tests/functional/test_kvm.py: Use -cpu max,
 not cortex-a72
Date: Fri, 15 May 2026 11:49:40 +0100
Message-ID: <20260515104945.4145203-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515104945.4145203-1-peter.maydell@linaro.org>
References: <20260515104945.4145203-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

The test_kvm test claims to run on any accelerator supporting
nested virtualization, but it specifies the cortex-a72 CPU.
This doesn't exist for KVM-only builds. Use max instead.

This fixes a failure like
  Output: qemu-system-aarch64: unable to find CPU model 'cortex-a72'

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260507194728.2034696-4-peter.maydell@linaro.org
---
 tests/functional/aarch64/test_kvm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/aarch64/test_kvm.py b/tests/functional/aarch64/test_kvm.py
index 7545f5ed55..fed18aba60 100755
--- a/tests/functional/aarch64/test_kvm.py
+++ b/tests/functional/aarch64/test_kvm.py
@@ -38,7 +38,7 @@ def _launch_guest(self, kvm_mode="nvhe"):
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                f"console=ttyAMA0 kvm-arm.mode={kvm_mode}")
 
-        self.vm.add_args("-cpu", "cortex-a72")
+        self.vm.add_args("-cpu", "max")
         self.vm.add_args("-machine", "virt,gic-version=3,virtualization=on",
                          '-kernel', kernel_path,
                          '-append', kernel_command_line)
-- 
2.43.0


