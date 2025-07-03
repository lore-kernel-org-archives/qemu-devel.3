Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B7AC83F09
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHiT-0003nE-J2; Thu, 03 Jul 2025 07:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHgD-0007at-DL
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:37 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHgB-0003u8-3t
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:36 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-453066fad06so54090455e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 04:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540433; x=1752145233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0cde8O5fgh1/x3P/3o29/Z35Bz+QAbkT/6eRH+3hSMk=;
 b=etg95+yg76BIJqmPnwbVYABzYWsR0+H5keU1YKGWDFTgzX+JcQ/Id+o7TE6Vd56dhG
 edy/131Jr7wIsxcKeOsDR9qS64xtNymz8y5gQvbSHFa1TSFHhoi/AJXudFvpiQ5KWyeQ
 4JpwjtT2MhJoyRC6CETOo1MjwCv2BVWHo0zRgw/NzIZAYrqM+i+k3U6WpvbZk0fnR071
 l+ObjjwkyffSA2iDZjzaPPgNwm4lod6IFiquKCyZPUL5VVHSh+jEXLqS3IUlfblMoPKT
 ZibszqL3FOLtMVVnAty/QFgL4s/11yCCJElcslgRdEK6Vn4Hx0ITScshzBAN9LhjBtOs
 Tz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540433; x=1752145233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0cde8O5fgh1/x3P/3o29/Z35Bz+QAbkT/6eRH+3hSMk=;
 b=tMHfXO5Yrd06iLrnszdUZT7EweabksS3GnCxHt62mhdYqLy6RZ8IYEfqLNfD2PRKpf
 ufPBCIIi8kwPXygUL+g42rqHFem3d369GfWVkC4Iiw1Ql2HP8BYTN3Uf8h0sQ0D7+vvl
 fQVm8iStFao+SYHjEUN+Jm6y4eW6BCZi9riI29XaWRb6nIsEiw6Z65QMWb5WsvIJGnCU
 HxlHG9w9fLvcxcuzuPwV7imQS/bCslU11XVVwZ3X/6fNSEvdLbKH16qKJxGpXxaHhR37
 47BIuzZLVj9le1ah9/O3ntpp5KvT5YuheEbYEqZX/GzhZrs/9PNt4AqskDyEy67GggMh
 5f5Q==
X-Gm-Message-State: AOJu0Yw3zGyewWyULZIhFpHUJtyJA07r3fnCXBZxl7NC7lP6TyUyWt1a
 z3lCbkllPyrWSfKhGv9kGgSeIFuTAxEi7Ey8rjpMloJFv9nNRIU2tYu/q51L2YFP0XcoWfWdGKl
 sz3llZJo=
X-Gm-Gg: ASbGnctDq6zUPY5WMaeym1j0xvkNgbpsfTWJ9Rb82+F3txNIU2f1Pa+xlVzkMeIog0A
 tf1Qo9+Q/5NexaPFnZOhWoluEAA1NZ/VkbNFCKPWeGO1Z+aBduYackfLslbWeGaEjhYte1x3CvE
 9E2EHZky8RptfClm9UAEh+0UJcYYRko6sMoU/I4iujmL08BRwkxknXoY2ABGOPmy6qrVb5vL3W9
 gfkw0pRSl+NueOYFZ9S+PibPVylrAXzYrjnRvjOaFnK3rmtU7ryEV8OS7ikw9bKyoLdzWaSl+bW
 rpDijwz036IaaVWhCKHbUY6cWfoj3WY+15Dc/LdBSdo2wcAeMGLqQbv5sFsvFHcM4Eeof8d5WBV
 0ApyiRTGqLIs=
X-Google-Smtp-Source: AGHT+IECVqwRCSSkNFpfwCHWC/LhOuR7wElBIZCz+M6yLqqaGvOgS9qRHb9tjN2lU6wMIaMMj74Yeg==
X-Received: by 2002:a05:600c:3eca:b0:43b:cc42:c54f with SMTP id
 5b1f17b1804b1-454ad20bde2mr20247315e9.14.1751540432626; 
 Thu, 03 Jul 2025 04:00:32 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52ca4sm18489036f8f.58.2025.07.03.04.00.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 04:00:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v5 55/69] accel/hvf: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Thu,  3 Jul 2025 12:55:21 +0200
Message-ID: <20250703105540.67664-56-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

By converting to AccelOpsClass::cpu_thread_routine we can
let the common accel_create_vcpu_thread() create the thread.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index c91e18bc3dd..b61f08330f1 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -207,22 +207,6 @@ static void *hvf_cpu_thread_fn(void *arg)
     return NULL;
 }
 
-static void hvf_start_vcpu_thread(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    /*
-     * HVF currently does not support TCG, and only runs in
-     * unrestricted-guest mode.
-     */
-    assert(hvf_enabled());
-
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HVF",
-             cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, hvf_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-}
-
 struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu, vaddr pc)
 {
     struct hvf_sw_breakpoint *bp;
@@ -369,7 +353,7 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 
     ops->cpu_target_realize = hvf_arch_cpu_realize;
 
-    ops->create_vcpu_thread = hvf_start_vcpu_thread;
+    ops->cpu_thread_routine = hvf_cpu_thread_fn,
     ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
 
     ops->synchronize_post_reset = hvf_cpu_synchronize_post_reset;
-- 
2.49.0


