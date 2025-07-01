Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D86C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcFY-0006VR-GG; Tue, 01 Jul 2025 10:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcEX-0005Az-O0
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:45:19 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcEN-0007EB-Eg
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:45:17 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a507e88b0aso2646107f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381101; x=1751985901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mJV4IXnKJHt8hWaUBPPZ6mJUKwfXPExjXmNVkOYEHB0=;
 b=ZigjWvuwVhtINgG0ovLpAuy0Iye8F36UF9l/2FXB7YPwxBa74oL38usPZPVpYX0Iil
 qN507pAuBOZuNnKRlW0u3JTokTQ4ktDmkfyx/+H/h50n8OeWwWQOQqCZ4SIbsndwHgaC
 2arRDJBYe7Y6bCdjFjl93+6X/fMgzQpC+mr4jhXt+fT7rFGDSnO47jHIipEky3w0pGCG
 AVdGjM28H0mb+ukjkUcRPsn+z75YLj3c0w9axVql57ApPGFk5SFyqfdrK478YMMfyA2O
 9j2tneQzOWLCFBbO8x2SVJGboSLYfUmpgrenv0q+VVFiBEnXXQYfuUhfMOwNPMAH8q1a
 inQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381101; x=1751985901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mJV4IXnKJHt8hWaUBPPZ6mJUKwfXPExjXmNVkOYEHB0=;
 b=EO0b+lDEvX/isd9yNaKxmzhizGeGetIaOkGtgW/5h3q6cfuYpmPzWc17ikUzglgXmj
 t/wKnpiXD3GL+1I7h7T0byeOFFfhaI7MuUBJ+3ST5TZPYnK5djvhz6N68O5UPidveD7r
 HFUL0H2hqm4j+fJ/TMl6Ac1XjK+RWYiquLg+fnqXx2Kblve1BcdDAByOt8k84RNpFhD0
 3/gWLT/tSBpBzjWJfYnVXPHG115fyj8NSk3WUkBiDQMRnSYIJqODCaUhZMxBqJqHaWDI
 3dPZqvgLzgNdsmr+MaHbH3eDkzh1W44dAOtvFucCtPYi6F2P8mB25fiZp7F6Ubuto4dm
 ss/w==
X-Gm-Message-State: AOJu0Yx4M6HsVmKMvhD7dGJp1+bb4Zh+3uH8huAmxmS/Ttpq5bwGeuur
 AXpy936ZyRAH8HGry3iLj0iMFD5JIrCsxRy4K/9BfWwSIOESwqlpneEPgnlIcrMMhjmQpWMUAXB
 Es2Be
X-Gm-Gg: ASbGncvXDNEjXiFGtwM4oINz/V/4n37LP5uNh+q/QAfhokvgj2NAAxYWvdH35Cumer5
 /fYa2MxzHzam0p/k1M7TQPtEJJpKB8vGgSnxkr3wgFJME2KlNz4psfNOWl9Z3m7gINPjYXic34j
 gR2nVtLgxBUaeM5xamqhd7HYc4ofjN98h0RkLqa6auAStKiWz2LUwfOanF/FMQz+73eZeU0/O3I
 zvQxDQiur1s6K01+DwwalY24oWhstc2X8UPp7EiIDYVu9vk1gatWKYFmrjn0IPy5PgdnK/9XHcd
 2gRpwO79PEzmASAfbSztlIsBYl5I3l3b2gqGUH/sqK+T3bAX9tXfvdXtxK0SJwTPHX8nWMLFJrI
 YGnMCUBjmFt2zo0UCXhiHK87eX0uF6wsmNv47
X-Google-Smtp-Source: AGHT+IFFLVUIsu3rnFjZM/dNsiKwrQVxFQowqi62tWS/UnNcn1UAuSCW3eTfuxbiV7XcM/vNMbguvA==
X-Received: by 2002:a05:6000:2182:b0:3a4:f6ed:767a with SMTP id
 ffacd0b85a97d-3a8fee65064mr12506182f8f.38.1751381100666; 
 Tue, 01 Jul 2025 07:45:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80b50bsm13311230f8f.42.2025.07.01.07.44.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:44:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 53/68] accel/whpx: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Tue,  1 Jul 2025 16:40:01 +0200
Message-ID: <20250701144017.43487-54-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


