Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0189FC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2f9-0002xi-N1; Wed, 02 Jul 2025 14:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2ez-0002hn-6T
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:58:22 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2et-0002ne-FA
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:58:20 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45348bff79fso48529345e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482690; x=1752087490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZcPe3nYMdLPvpkVihaPaKQWmWCYPUgBDgbI5JlWA4I=;
 b=KK4wW6o56wqqu6joBlVnsC/EOoWQ6KDateG/s63QWf0eTMQ+9OpgaSOltNHPoTL9pL
 pAii23JZ5ghtyZpJRTeiYE1IWjbrCoCLw+iHoMXR/8nKbAKO8zLLJwdtOFgDkNUwtI4L
 EE24iTdRNYrbpNyPE9HCQs5RXENKQrooV2pmvIdnSoY9N9wVn6nU77V10xyOraH9MUKA
 cM/q+RQ+q8wSwAIzAhp5KQzUd43KhxnSocY52cuiZOtBJpJhie2fXMOXAmBagqNU+tpG
 xMqZYfP07gJXNkX//JtvxSpTQ/7mLyE2PX2zOcxC4fCT0s+AYalMPikpNa3QAWYl05DO
 ZWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482690; x=1752087490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SZcPe3nYMdLPvpkVihaPaKQWmWCYPUgBDgbI5JlWA4I=;
 b=w8Hik4EzwZSTXUjW0oWtpKc/oALNhJx9GfFYGXUV8ere9sDIBBxntHCmYiAlEIjzIA
 iJ9jR5xGZM9Lm2JP3S2K6k/IFDVpmmmHdTOGrARLUoDiZ/bH7xUqoRIeAb0hZ1LoAW1g
 Vj/17kh46hReVEq1c9XthJlT/VU3Sz0ThkocKUcdaHVhVIAKtNDSkKTHKXD8U40570/M
 NZB1is1SuZZSk1afgtkOKBcTXwqEui7Mqzb+Jo0X+1tBhf4HtC4yuOgdmtsIEXwoX6Bo
 MG39rcylegy0kH50C+vsfzaWiRGjgZUefDUlBkgRKVXz12YmmONFIt9OoUVftos8QDui
 CZIQ==
X-Gm-Message-State: AOJu0Yzdy5dDU81qnnlXpVSIttEja61St57aG84AEK4+9JR0nGZbqUsX
 2uIfZore/dNSNG82EegjGHtzK0JqcejFzh+UfEKNaDAD8lmqfVp2AYiJNEsi5nB7aeSkazyJoUF
 jEtou
X-Gm-Gg: ASbGncu9/OY9EWyloa20IdpojGKdts7g1T1eGz+NiGTD3u1ZHygcXO1XmCyJiRdEwsd
 bE9+6F09YYKoYGue4sqB5i6gtyzDgmBg8KGO72hd2y3Y82Ii7wovYzKG9luQKxlVRH9qqS6GcRD
 XJ59Kc2wtyCjOX6RJBaGhnsiyIUE8gZHdwbdUImF24W9MB/4NRuP9owvVQsa7fv1IwIY7RKHEjZ
 DXWvMaEILlpClBtwNvk3LI87W3ocPhLK/fvFuDf22DH+RdcD672MAjA7d5K713NrQ+ufoK39wxx
 ULoP4fP4kDCu0orxh3MfDlO0qaBCuBQiIsXmVFWcXoY4GL+hR7uOa9jonugtSbudl2d+Tq87M5i
 7ttJZSSpJcYyTF2iC6NQUTLz+A5UHM98qtjxV
X-Google-Smtp-Source: AGHT+IEMJc2bCpIf0tMa9zUMTXA/l80YP6s5PRbLi1vGz/HuGBykc1Hw9iizQYQBjwStGofzLQlDgA==
X-Received: by 2002:a05:600c:4509:b0:441:ac58:eb31 with SMTP id
 5b1f17b1804b1-454a3705065mr37982045e9.20.1751482690018; 
 Wed, 02 Jul 2025 11:58:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5972bsm16892625f8f.68.2025.07.02.11.58.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:58:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 38/65] accel/system: Document
 cpu_synchronize_state_post_init/reset()
Date: Wed,  2 Jul 2025 20:53:00 +0200
Message-ID: <20250702185332.43650-39-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/accel-ops.h | 8 ++++++++
 include/system/hw_accel.h  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index ac0283cffba..77bd3f586bd 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -43,6 +43,14 @@ struct AccelOpsClass {
     void (*kick_vcpu_thread)(CPUState *cpu);
     bool (*cpu_thread_is_idle)(CPUState *cpu);
 
+    /**
+     * synchronize_post_reset:
+     * synchronize_post_init:
+     * @cpu: The vCPU to synchronize.
+     *
+     * Request to synchronize QEMU vCPU registers to the hardware accelerator
+     * (QEMU is the reference).
+     */
     void (*synchronize_post_reset)(CPUState *cpu);
     void (*synchronize_post_init)(CPUState *cpu);
     /**
diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index 574c9738408..fa9228d5d2d 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -28,6 +28,14 @@
 void cpu_synchronize_state(CPUState *cpu);
 void cpu_synchronize_pre_loadvm(CPUState *cpu);
 
+/**
+ * cpu_synchronize_post_reset:
+ * cpu_synchronize_post_init:
+ * @cpu: The vCPU to synchronize.
+ *
+ * Request to synchronize QEMU vCPU registers to the hardware accelerator
+ * (QEMU is the reference).
+ */
 void cpu_synchronize_post_reset(CPUState *cpu);
 void cpu_synchronize_post_init(CPUState *cpu);
 
-- 
2.49.0


