Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E4DC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHbp-0003Yd-NE; Thu, 03 Jul 2025 06:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHbn-0003U7-0a
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:56:03 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHbk-0000hu-AY
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:56:02 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4538a2fc7ffso6133665e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540158; x=1752144958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uxv4WhKLwrx5svsx0yY+vpPljgpJNa1VqbPNSHemHI8=;
 b=P/mzv42460hiqJVm9npV4IBOaFfm3msQBWX+lhQJuToagU6bGdRkczOrxc3HUZnI2K
 rHVYZdzyKzpy6yMAyMKim5OTO5l8mDfjpDq/I6RI2gMcKyG5zT0CZcV0W/W3/R7BZU6Z
 IoiONvwBIAmGkP4/g3GRBXrPEXfD2pMErRt2Q6/pW+dR+mODQNc6CBET6YsYiDUd7mnZ
 MtZj0qBtvkMgchNGUjY5hKtXotVRgsq1xAjN46y2odv/Kpdy/su5r5yBflVLB4fgfRXP
 qGEdOWvt5Qic/xp47DP7FaA97Q33kdaQX4GrakutzD02JjnmWPD7/vpZ1RDu5+hmVapL
 4INg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540158; x=1752144958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uxv4WhKLwrx5svsx0yY+vpPljgpJNa1VqbPNSHemHI8=;
 b=ABhVk1tQR9DBxxPoT1w6BKK7HRyERVojsFPHEOWPkNKP41u7Jv8acBrrT4GbQkqu/t
 vSSOFmvtgmhtVyMXs6SLeO3eR0yKrb5tsTjixWLVY+ar0LKx+lowl9XZij+Mj427q0rH
 3eLxjT/30CTvMJkR48Rsl6qtZ9Hpb6HMbIOlupGGImKhdXI6X/jKPYxAtE1oZVhMeB7b
 UXMDzqDreU77uEg+NyQ2WVRMewWiJ5eu0kUAHdZXRl7pcfCguW7oisbAT1RorcEt/PUk
 HkgX4EuhVpRfaXoOZA59zesLFqUg5vWdirga4A6Poufe1adhTOp2juORC0Tl5Vpk+eVC
 0Lgg==
X-Gm-Message-State: AOJu0YwRrc1cPwWDowGLaG261jzB0OScWiKBV5B94muoWTa2cKJgqOm1
 cu40gu4+8yJiBwp4wk9tcjkg/VEJYputmoSzZi3N5HqOXFQuPC2aku34XctlnCLctaFGsf1U9O0
 NvWIVh7o=
X-Gm-Gg: ASbGnct3vXebuhk4N3jSIoV6AaY53hsDKnMuV61IFMY3/1GK+8ruN5ltU2EAhKTytLs
 tvULOAJ+RxjuGduWrWeBWU/C+gPb4l/n11T4hz/vzIaG4EUAdAeKCX4QNOr3Tg+MJtezOdH7oEQ
 EPhAwFEPF0gu7A7066jDl+UvR0eMl2rJ3ohQ/X6iu+a1+dyRiMEeWZwvPHsNNM3xB6Lz0O52TYe
 PUzBoo6iFnTjG3q7/6KkJ8S9C6yy4K5U1U0EU+iD8tOPg0eUuaJo6uRtqw5yxoII8iwSMfGByy6
 A74J1cSLUeq/vhAkEXblUZBe0QTiZCHxjbdTyADlc65V8nIr3TeLUSB6dxrDzPG7i4prtzLKNNR
 nssysHYr2EfE=
X-Google-Smtp-Source: AGHT+IG1H8ch3ShI0aRQrECwXhkob5OWrVYrH2E7ESnTzOKHx1oaywxwnUfPeiJs+ptFSaoNI/+HhQ==
X-Received: by 2002:a05:600c:3b89:b0:453:84a:e8d6 with SMTP id
 5b1f17b1804b1-454ab2ecdafmr23612155e9.1.1751540158345; 
 Thu, 03 Jul 2025 03:55:58 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f842sm17994943f8f.86.2025.07.03.03.55.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:55:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH v5 03/69] system/cpus: Defer memory layout changes until vCPUs
 are realized
Date: Thu,  3 Jul 2025 12:54:29 +0200
Message-ID: <20250703105540.67664-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

vCPUs are not really usable until fully realized. Do not attempt
to commit memory changes in the middle of vCPU realization. Defer
until realization is completed and vCPU fully operational.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/physmem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/system/physmem.c b/system/physmem.c
index ff0ca40222d..8b2be31fa7e 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2792,6 +2792,14 @@ static void tcg_commit(MemoryListener *listener)
     cpuas = container_of(listener, CPUAddressSpace, tcg_as_listener);
     cpu = cpuas->cpu;
 
+    if (!qdev_is_realized(DEVICE(cpu))) {
+        /*
+         * The listener is also called during realize, before
+         * all of the tcg machinery for run-on is initialized.
+         */
+        return;
+    }
+
     /*
      * Defer changes to as->memory_dispatch until the cpu is quiescent.
      * Otherwise we race between (1) other cpu threads and (2) ongoing
-- 
2.49.0


