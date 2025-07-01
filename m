Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64987C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcGs-00006x-Ie; Tue, 01 Jul 2025 10:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcGg-0008DU-9d
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:47:30 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcGX-0007Zb-GS
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:47:28 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-451ebd3d149so17596145e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381238; x=1751986038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7yUgpspd0iwEkkFCIPPLyqA8sBqJmHRreN8I25G7Eg=;
 b=J6xNhOQVz5vFrRwIc+iopgrTyaVdXJ+zbFHCSHQPQTkXRKysSRvCH2zCGmhF755xCd
 ilzpJc2STBg48SpAcpXNqrw08DQlHMRnYTfUc+nhpUMNQjdYLFoBFU1TRlUsuad10Ait
 kcXKGLx6L/YVWIAQej9aChSGxRPMPkwinap7dVW91sXrcc3kGzV+ACPkapSagTuY4+Nv
 0oI8ZewmuxVkd2fR3BR+io9/+bHLFCLwIaNj4CVDXvkD4K6k9vDorzJxGKpWiQOBvJUS
 +VjmeSq315Jq5oHqahmkVS9vSMijKdjL1kfM+NsRnF/R+2VmQVLq8WDAsqAHvJNPZwS8
 XzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381238; x=1751986038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J7yUgpspd0iwEkkFCIPPLyqA8sBqJmHRreN8I25G7Eg=;
 b=CffeEc525iOQZF5DsK6TJTCr1YWxl/ZnFPlfOKku9cw6lFdnK7uORtcn6jkuvDzF5u
 b3Zf4nxhCj7M5wzei66WpFqBUqEcyF5jr4R+usF4DRAJOUWg8zGQ5j83IN+S7il5i4Pu
 Sjv1kvDaU8HQW7VlD+pcWS9MIjYV4z/Bq1hWBfPdgVsORSwRwDGAlL15BXK4ywXVEaPU
 zZ564Bsp98ON674kVGao1HJbOxk3JIGby0ok/zjTXJjuA4p4dIwW2Vc/cWvLcq/rihL9
 YWS1QpRfNMgmOdvfDoFmwUi6xn0aitTn54+NyrpxlyxytaPYbBHF7nr7nhl+gQEutkwc
 MIuQ==
X-Gm-Message-State: AOJu0Yz2aa5PMFi9Y3XI4OuefT9c9sydD2PHYV4Qak0fS4JIBJVVU8u4
 Ousccz/fJPSW49rftmAxQ4hVrlKYkPYCZjiSzzqMS541zE7LHOw2rKWtArQ5VNIzxQfRe+XlHyo
 pMhLJ
X-Gm-Gg: ASbGnctD3BGga6JHcCaCNiqM97f28cpW/TDAHY4698U1n0id+IHAOzaEV2hAnm38jMH
 dJqfTdVvKPqTEHVz7U/cYLW6yusOoRt9Vp9aW8DUDE8cBTZaTRIh+x1NsztUAvyQO6gZnyX7g5n
 WTds7usF8I35s+FzZstSJj5a9abbrTv9dmCKEEqCu7qumAtD9nVSgEI6cyFEtCQpJCJPqm2xeYz
 42EQFWfWH/cwm0+wvHZudtHgytSCSwGAqebtJ2HxOKIykWc3B3M9iezQkItqNox7UC+mM3j9Ww2
 Flni+a48g7a9dXZdNemQIPOhD65Oo2s0kgMWnMsZELVk67pes+rUyU41SDcdRy+3mtTeZW8Adil
 HphNRTHX+Aj9m1nyMcQSDkSp+w3W+7fnEVUcK
X-Google-Smtp-Source: AGHT+IFn38ZCDQXXEtThwyZh62bNqfEkVaKwct2czszk0sd2puCbPP2T3YwSm0oXXbSUnc13sTh6aw==
X-Received: by 2002:a05:600c:1389:b0:43c:f70a:2af0 with SMTP id
 5b1f17b1804b1-4539b3f67c8mr126506625e9.16.1751381238414; 
 Tue, 01 Jul 2025 07:47:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a4215dbsm166957685e9.35.2025.07.01.07.47.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:47:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 64/68] accel/tcg: Register init/exec/destroy vcpu hooks
Date: Tue,  1 Jul 2025 16:40:12 +0200
Message-ID: <20250701144017.43487-65-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 9b5caf9c4f5..c6b5a567f9d 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -216,10 +216,14 @@ static void tcg_accel_ops_init(AccelClass *ac)
     if (qemu_tcg_mttcg_enabled()) {
         ops->cpu_thread_routine = mttcg_cpu_thread_routine;
         ops->kick_vcpu_thread = mttcg_kick_vcpu_thread;
+        ops->exec_vcpu_thread = mttcg_cpu_exec;
+        ops->destroy_vcpu_thread = tcg_cpu_destroy;
         ops->handle_interrupt = tcg_handle_interrupt;
     } else {
         ops->create_vcpu_thread = rr_start_vcpu_thread;
         ops->kick_vcpu_thread = rr_kick_vcpu_thread;
+        ops->exec_vcpu_thread = rr_cpu_exec;
+        ops->destroy_vcpu_thread = rr_vcpu_destroy;
 
         if (icount_enabled()) {
             ops->handle_interrupt = icount_handle_interrupt;
@@ -233,6 +237,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
     ops->cpu_common_realize = tcg_exec_realizefn;
     ops->cpu_common_unrealize = tcg_exec_unrealizefn;
     ops->thread_precreate = tcg_vcpu_thread_precreate;
+    ops->init_vcpu_thread = tcg_vcpu_init,
     ops->cpu_reset_hold = tcg_cpu_reset_hold;
     ops->insert_breakpoint = tcg_insert_breakpoint;
     ops->remove_breakpoint = tcg_remove_breakpoint;
-- 
2.49.0


