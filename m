Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE165C8303D
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcGn-0008MH-Et; Tue, 01 Jul 2025 10:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcFq-0007ug-S7
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:46:42 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcFl-0007WC-UV
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:46:36 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a525eee2e3so3672973f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381192; x=1751985992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FL4Z1JJfVmMUZm0/Ew/5hEBjQo27MY9J0Ii/7EGBd6w=;
 b=d/PoaqtbHBlDH79l2QniJs7ifG0E7tJVtsx176pIS7k5LgiWbzkXGZGxYJyaBIARho
 bQUsmBBOcJ7Am3o6veVhgbQoKszAbyAZ7OH2KzW7QXuvhky/Tmxl7G2jEfYoR9QOM9IF
 HTAm5R7SvpKArwfZ4fQbvDse92xzJZJGb5YYijZIz+11lvi03SClOB8hAN5KhyMUBka8
 GHcYlp0rMF0dw1TqKySnUP1jXao2MNNQjjXo6RaUmfEqhkWTqcUJ5sMWVRpAvX8Ep28p
 +6YlUT3S1JhFMi7cMZCeBOPtj9u8lyBWTEcbu2dj4llKjv8+vooOKQrNBx6lYlUJV53+
 7+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381192; x=1751985992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FL4Z1JJfVmMUZm0/Ew/5hEBjQo27MY9J0Ii/7EGBd6w=;
 b=MB+UGDNrwYfEL5ajyqQNFfzUASJ38PotBDhgXgFEhd+d/8fWXBkAKhzgOFyOSHpGCL
 bLNTZRRXktYNfPY8P2Es9kGOSBhIVLu2S2p69h/w9PKWM6g2pZVkh36Rp1c9P3SEfF7x
 LXPTIllqJCtGImXDKnmv9IwyIh+2dNceLJsfvHrl2e8rNgk2Q7vTBV+8ZBxtUSNqqpI2
 sk+r1vnPzf6PE772/R1UKW3WA2goLWTOxL5KaRtLSsmuXgno6HyIV6zfyOqcQBaTEoB2
 NRy+X04JZaMsNFmMcmmVP0+4GwSQx/7Ehux4TmORPJoqDTnaJZmL1N9rc7XmFVPHImgI
 7BEg==
X-Gm-Message-State: AOJu0Yx+WxBLk1UOoI2Z30ChByLRKdUGVG82odqOdsbt9INasd1u7wWT
 aM9MrZ0YV78AvjeLghDrXYXJR431GCZyX4zq6Hx3s2fsdc3WslXxtW738IkPLHGuAz7MB3gXRrL
 bwphJ
X-Gm-Gg: ASbGncu24A3pieXcN/xaeMfx4m0vF5ykicN2a07NuiwIEqdvyts3DiFr4dxkSUgp3EQ
 6VxzrLWXhu1ttv/kqZLlQFNX8EfFEvf49stt4gIRSrkxERXX1p88O+EFMH0oz/ecUeqr2f0bSD/
 Va4a7cSPJe8eeLst6/VYg23Qx5XPWtH7iKAGukuHlMwMg6Irte8e+3HeVsCAS0Wg2CNpAULnoZL
 LgnbpYx5k7o7yHj6KCInbTaEDYQy+CZeyOyRthFZ+i8Du10vjhOdZrcJuh8dXWQBfX1EXMPfYTP
 DHVPi6taGpnqSpnfEqXqTTgYJk9ZuyYvFanElHfl/M4Rx/IVj0a8dKNnYOkx6fFXVkEPP+sry+u
 HUKNzYUbzHRUY9jtDL7aEsakJAMR55VETjmOF
X-Google-Smtp-Source: AGHT+IHnWmLdIDgfirMf5wozhxeIz5isTLSPUPIGzyJqKPAQ/edMoYtX4Om9YGgHMV/Gc6jwe6wUUQ==
X-Received: by 2002:a5d:5f91:0:b0:3a3:67bb:8f46 with SMTP id
 ffacd0b85a97d-3a90b9bea87mr16637740f8f.57.1751381191768; 
 Tue, 01 Jul 2025 07:46:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f44dsm13331985f8f.87.2025.07.01.07.46.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:46:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 58/68] accel/tcg: Factor mttcg_cpu_exec() out for re-use
Date: Tue,  1 Jul 2025 16:40:06 +0200
Message-ID: <20250701144017.43487-59-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
 accel/tcg/tcg-accel-ops-mttcg.h |  1 +
 accel/tcg/tcg-accel-ops-mttcg.c | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-mttcg.h b/accel/tcg/tcg-accel-ops-mttcg.h
index 8bf2452c886..72eb1a71d61 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.h
+++ b/accel/tcg/tcg-accel-ops-mttcg.h
@@ -14,5 +14,6 @@
 void mttcg_kick_vcpu_thread(CPUState *cpu);
 
 void *mttcg_cpu_thread_routine(void *arg);
+int mttcg_cpu_exec(CPUState *cpu);
 
 #endif /* TCG_ACCEL_OPS_MTTCG_H */
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 2d31b00ee59..8a0295e2410 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -109,10 +109,7 @@ void *mttcg_cpu_thread_routine(void *arg)
 
     do {
         if (cpu_can_run(cpu)) {
-            int r;
-            bql_unlock();
-            r = tcg_cpu_exec(cpu);
-            bql_lock();
+            int r = mttcg_cpu_exec(cpu);
             switch (r) {
             case EXCP_DEBUG:
                 cpu_handle_guest_debug(cpu);
@@ -148,3 +145,14 @@ void mttcg_kick_vcpu_thread(CPUState *cpu)
 {
     cpu_exit(cpu);
 }
+
+int mttcg_cpu_exec(CPUState *cpu)
+{
+    int ret;
+
+    bql_unlock();
+    ret = tcg_cpu_exec(cpu);
+    bql_lock();
+
+    return ret;
+}
-- 
2.49.0


