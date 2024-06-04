Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D609FC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQuO-0005Va-Tl; Tue, 04 Jun 2024 05:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQuN-0005UF-GV
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:56:47 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQuL-00025K-UI
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:56:47 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4214053918aso8458395e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495004; x=1718099804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jgoZWUZoZ64J/jsUK/BO8m7HZCfTE8MphpmeDDotPMw=;
 b=bZjgJBI5284J1SjHUkyo71g4FxGv0FKXFQ7qbmdsp7foBi+PD22NmzUeVL3rR2LvDo
 5UZ6+HxGxofMuFiSmmMPZjHrc458b6FK3dXYJVR6yczeoSX2EvqQf376ICBbF6o3E9Q8
 /mLdZixbEB+m0waUJW0WuI7Nz2mfd59MkvLgGpIWEBcIWYZojBPmD4A0H+XW94/hWcah
 +91LuGeooOnuRPyoKjLEQjCS3OWCfQ/W82urb9dCDOg6cgH6Ngy/zjhKJ7Pn4sr3uLFz
 NwkX/cYm2NAMjiiXqxz7t0Lvlq/bjMbnitDihIsvAghryjd8N4QM7zkAGvJmSVnoD1Rt
 AVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495004; x=1718099804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jgoZWUZoZ64J/jsUK/BO8m7HZCfTE8MphpmeDDotPMw=;
 b=RQeXTS5CdvESx9F1rgT1vM5OlJTE9yWL+v418Dv6GMi1xcAvtpTz+5nn/awM+D98yz
 A3n9xpA40dqkowMVS2OeGPTRXoiftAe+h2kobKl/ISRLNeko/y9VSCVpuFEn0uNB9MhJ
 aas87yRtjeEJ13rLCSOQ5hQkFjaS2i/GALHkHQ5q0ywh+XI7xN0wKuYkSMwu0SGU30ds
 /jGNveoJYsYiN7G/ZwCoZv7rsRmd1Mqd4pOlLbk7pExuWZnXsWdrMUsPLC29HWLN+936
 7nHCgrtIAAcdOnE6Rk10jvJT3AjwHtvFzcCSeRvaJlwx04rGaqgWWOfJTZh1tSBlEnZP
 zxyA==
X-Gm-Message-State: AOJu0YzzZ1vMcnm+6JOvgLobGQ8yrFLCsWKFYum8ZVaiUWRRZIdKOvuq
 pys8jIplVag6cgr7lRylbsILi0j4nnHL3nYR2kHQD6Bo8xFCOhu0/ikmfXf+WXu6rJTIPMk6UM/
 L
X-Google-Smtp-Source: AGHT+IFjz5uT6H7AV9C1AonhIUawUqa9v/TOZ27fTuoOI1efggQKW6efBbW3dYEmVNCqidttAZD92Q==
X-Received: by 2002:a05:600c:4454:b0:420:18e9:86d5 with SMTP id
 5b1f17b1804b1-4212e047556mr110629845e9.10.1717495004276; 
 Tue, 04 Jun 2024 02:56:44 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b83d469sm147315445e9.9.2024.06.04.02.56.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:56:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 06/32] target/i386/kvm: Improve KVM_EXIT_NOTIFY warnings
Date: Tue,  4 Jun 2024 11:55:42 +0200
Message-ID: <20240604095609.12285-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240412073346.458116-28-richard.henderson@linaro.org>
[PMD: Fixed typo reported by Peter Maydell]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/kvm/kvm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 6c864e4611..82ebddada1 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5329,7 +5329,6 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
     uint64_t code;
     int ret;
     bool ctx_invalid;
-    char str[256];
     KVMState *state;
 
     switch (run->exit_reason) {
@@ -5389,15 +5388,15 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
     case KVM_EXIT_NOTIFY:
         ctx_invalid = !!(run->notify.flags & KVM_NOTIFY_CONTEXT_INVALID);
         state = KVM_STATE(current_accel());
-        sprintf(str, "Encounter a notify exit with %svalid context in"
-                     " guest. There can be possible misbehaves in guest."
-                     " Please have a look.", ctx_invalid ? "in" : "");
         if (ctx_invalid ||
             state->notify_vmexit == NOTIFY_VMEXIT_OPTION_INTERNAL_ERROR) {
-            warn_report("KVM internal error: %s", str);
+            warn_report("KVM internal error: Encountered a notify exit "
+                        "with invalid context in guest.");
             ret = -1;
         } else {
-            warn_report_once("KVM: %s", str);
+            warn_report_once("KVM: Encountered a notify exit with valid "
+                             "context in guest. "
+                             "The guest could be misbehaving.");
             ret = 0;
         }
         break;
-- 
2.41.0


