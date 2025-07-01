Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2764BC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcDD-0002q7-R2; Tue, 01 Jul 2025 10:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcD1-0002Xe-7h
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:43:43 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcCs-00075S-S4
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:43:42 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45348bff79fso33270475e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381011; x=1751985811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zOj2l0QjwiOWVtDmZos93I73sy6okOj775eGXYWLug4=;
 b=CXxQHAkeRXxb2aXxpDkrP9TniwfePunpRwLYpHtpkl5fXgcAxm3f/1R0BBD57QlCS6
 s5/XHvJ8Ma3mpPeQ5ypch2gpQV4x+Tx94UaZTXCo1VUihAYMGNjPW4lmEUbPT5fPGY15
 au4g22YRrV+A6eoyDWbSpwwxRoWCbpNrCxm+RbGbvdNz84CdVgNkZTMMcraPPRujlz9B
 qB1F+Himb4LAebvyRNQXaDFtXpyyTRswsV+kvvd3k+17imLN9d4s1HJ+1cMJ+XSmdGxO
 cmq7PqSl0xxPE77vf9+hs+ynxz+L4juQxlUB3NBwGIBWSSOIuwaWvd5inmibxAHHL7tZ
 qMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381011; x=1751985811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zOj2l0QjwiOWVtDmZos93I73sy6okOj775eGXYWLug4=;
 b=X8a2T1lavO4F0WsCWYA5MfMVJqU+pc+Oca83cZ4vDN03F9dBtbO0m9H37Ae8PQPyyw
 WViaa6M0TZKFr63coIlKkWsqUmYzJ+cum7b3BNc9BotVg2U9vFnXvf7dN/6ndTyvdtkM
 OpUjrdbjhmnFvCmw0D0nLmMEnkxYaV2xGYjZczSDsT2IXhDPcPiwiZJxdiZnh85dtlaT
 S7rcMcgjvpoCpjygZvprNBKhg8B2KMLei9uQU0ISaZuxiddn+lhUR0fvBvVeQsbjLs6M
 Lt05moR6Zz+RPGnvu4h5ViBXaaXauLPgZ5sNzGDXUHU/Hft+As2mQ2YKs856yFF4evq7
 3X/g==
X-Gm-Message-State: AOJu0YzZ00mVlqPgsZBQ4hwQH7/XL4xa2is89AY5Mpazx8V5y5lLnu4V
 NUy5apWI1jAVggvYstJ9MurZC5/sme0EuNSpJZP/t5lzYmdn0LoUpYO5tguBPfepLOXH5ppbgb2
 tKr7Y
X-Gm-Gg: ASbGnctTdVfFX3jeD6jXD0q9jnWjIjMJmqPkcXxlXdwr0SHy5nqCFJKLnjLh1PT3Enf
 cDT9EiERq0+pkUu7HGdTqaoUwIIfH6K5//KejaydLDZkE6jZs+l6zcdGg8BCenqR2ZDj2YnE8ew
 XlFSyeBXzZQ4nMqaknrO0HiybRqKA88wxFIamgJURatGDMOOZYYHHVcroP5x9sMwLudR4AcJVrs
 xwxIYefLP3NgK0QNvs2IBB1Cin4wivEZkklvghXNJeUQfH3WLFx+5SrlXyNSB56D+8zzzL+j9IM
 llwBxWYOnHl7Qv3Sojn0g13NfrmsubsT79rysRl0gl/2N32B8iwFVW/qmn+8MaoaHg/wvpwmq+h
 Wv5caFCm0IdKKrmFiQ0FR931SpitLWk00uOW1
X-Google-Smtp-Source: AGHT+IFDgs27rF5aT3DZSi9tV0BJMuNSr5Rf8VyHqKO1wPRfB/7Xyhej5iiOtcfCWNGxOG1HbD8w2g==
X-Received: by 2002:a05:6000:1a8f:b0:3a5:541c:b40f with SMTP id
 ffacd0b85a97d-3a8f435e1c6mr15395089f8f.9.1751381011234; 
 Tue, 01 Jul 2025 07:43:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538233c49fsm196722935e9.7.2025.07.01.07.43.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:43:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 36/68] accel/kvm: Remove kvm_cpu_synchronize_state() stub
Date: Tue,  1 Jul 2025 16:39:44 +0200
Message-ID: <20250701144017.43487-37-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
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

Since commit 57038a92bb0 ("cpus: extract out kvm-specific code
to accel/kvm") the kvm_cpu_synchronize_state() stub is not
necessary.

Fixes: e0715f6abce ("kvm: remove kvm specific functions from global includes")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/stubs/kvm-stub.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index b9b4427c919..68cd33ba973 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -29,10 +29,6 @@ void kvm_flush_coalesced_mmio_buffer(void)
 {
 }
 
-void kvm_cpu_synchronize_state(CPUState *cpu)
-{
-}
-
 bool kvm_has_sync_mmu(void)
 {
     return false;
-- 
2.49.0


