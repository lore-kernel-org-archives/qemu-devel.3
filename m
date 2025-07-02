Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C107C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2hH-0007RP-UM; Wed, 02 Jul 2025 15:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2gf-0006ik-TE
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:00:08 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2gX-0003DL-G9
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:00:04 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45363645a8eso51012895e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482790; x=1752087590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mJV4IXnKJHt8hWaUBPPZ6mJUKwfXPExjXmNVkOYEHB0=;
 b=UMsZMYF7ISYZ1lDAM/wHlqdRXrmyfP2rcP8VTGahgUpYKvEAt3GJQj0mGFDT7gltlr
 kziDhGmydxHP+hJgGLoFSGpB7wLBU/0jpWUOQ7VCKS3137GejpC7ZfRc24TfkoYc4Tbk
 O9k9UQ17iDjIt/poe4B3cNC0lXbNowTlzLteGd7UoZ1k6K8akeVksXOVzDWuNfr9Ut37
 uAT8JTDuOwF6QMEBDY3mHvdo9tTrXmVkd69y4ti484mFCbDrEgK2xr9fVMXOr72DSdNo
 pdTYdl34EMdijW/VjTAkkZsE75n8Gna3tdFafYIXAaW9tZUvs6CNf8w+AP+hUIOOgLkt
 8jsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482790; x=1752087590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mJV4IXnKJHt8hWaUBPPZ6mJUKwfXPExjXmNVkOYEHB0=;
 b=tgfpypnl4yxT3rfvrnH00ayS7rQ83081H6dN17XCU8dCv8z98rX4ndbl4+baY+09wM
 LPovJw17HnykgPczblmY8MShZ5xLNKK9of9bJbSsSazsrWgHwdlIGx/3SUELpKIDbMkS
 tufDxQ0qnOIb+MQDsXb1PIUn7wCUb/coLKeHn0NnlCd9iUG6aE8BcQLZ3GkqlJsbIZSj
 oASHufi9JWNp7B0RZ6Rw47rXSycqPy4UVfz2yWQqskFT7GBjN50mc3SkKTQFSI77ci+D
 zjz9Illhfc1QwSig8DRCBXXSlA5fq3l6Lq+Co5gVlBbebPgiYZck90uNqdhkXBA/PAgv
 uXeA==
X-Gm-Message-State: AOJu0YzwrIBn1dGtTDlyeu+rPEkd8yzjA3ijTMp8NOaHottSuLdVe2Oa
 3pDxU7sQslIj7toQhEINFlL/S/EWG51ohRURh0UjBQ9mdWg7j87HrEqcXb2Pt92+AIBfX4WulGT
 dsRDR
X-Gm-Gg: ASbGncviA9h/GMWVNC5zQ9MPICWwI3R/ZV9VUf6DrlKhLxvzLu+piVKRpTILB/fcvxr
 iDu9ePTv3qQE2eCrFfiTRJsGg+aFCPvHAbD/xc3XyMYpGmVC+NQ77WvNQaazszIqFVrjIH1peq1
 Z6jQfUD+BVBJ/zHUhg4nL0Y/HKLqXphva3KGqF/dFkOeXlObtOw1Zt74rlTtJXC+snyrjgyXX8f
 ZcCAcwMk9RyDACHTl0aozcBkkKdUnZ8EgYquQ1DSeVEmoYaZt/Y5CknPkZsaqR40K+iAYZTbuHZ
 D1H3gHhE7T0+fV/qc8HqIJ1Z0309qEqyK739G6VZ5ZDqVemYiCImsmo+WEw0A3+weDv3wwI+wpn
 ULns9rAjEKDbxQGzkVlq0bXCs/xrBKXCPmsBb
X-Google-Smtp-Source: AGHT+IH031cq/gUIMg0JtuupqLORNupxi1DmHK0HKX2NvkRiddDxkZA74do6v/MuRt4t3c76lsFp/g==
X-Received: by 2002:a05:600c:6994:b0:453:6150:de50 with SMTP id
 5b1f17b1804b1-454aa627b7dmr3409135e9.28.1751482789743; 
 Wed, 02 Jul 2025 11:59:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c8013fesm16935710f8f.38.2025.07.02.11.59.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:59:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: [PATCH v4 53/65] accel/whpx: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Wed,  2 Jul 2025 20:53:15 +0200
Message-ID: <20250702185332.43650-54-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

By converting to AccelOpsClass::cpu_thread_routine we can
let the common accel_create_vcpu_thread() create the thread.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/whpx/whpx-accel-ops.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
index 011810b5e50..8cbc6f4e2d8 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/target/i386/whpx/whpx-accel-ops.c
@@ -61,16 +61,6 @@ static void *whpx_cpu_thread_fn(void *arg)
     return NULL;
 }
 
-static void whpx_start_vcpu_thread(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/WHPX",
-             cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, whpx_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-}
-
 static void whpx_kick_vcpu_thread(CPUState *cpu)
 {
     if (!qemu_cpu_is_self(cpu)) {
@@ -87,7 +77,7 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
-    ops->create_vcpu_thread = whpx_start_vcpu_thread;
+    ops->cpu_thread_routine = whpx_cpu_thread_fn;
     ops->kick_vcpu_thread = whpx_kick_vcpu_thread;
     ops->cpu_thread_is_idle = whpx_vcpu_thread_is_idle;
 
-- 
2.49.0


