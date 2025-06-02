Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458EFC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 09:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM18z-0006un-Bu; Mon, 02 Jun 2025 05:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uM18o-0006pr-AK
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 05:07:34 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uM18k-0005Vq-VR
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 05:07:34 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4508287895dso29422285e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 02:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748855248; x=1749460048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1eCV4vIb6ahPQ4VMmy3NO5u2F3ZquGRz6jC1wZD8HCo=;
 b=iHdhkBtEFqkbkUXeBIbtCl8LrjJBF4owJ3T8e4Zqmt5XUTeEDSTXSUiMpGs/G6Tn0z
 DSfLKuhBm+YX090oz+BRlU0wq8mm+MlyaMrul0YemXYzhPH6ASuUTtm80ez7fn9imHF0
 O7WN0ygsVvPi43moA0R9SJIYk9xteEs/tdF7f4Qxy0yLGIer+VAMJq0KYF7URyphF1lj
 pHp4p0hP/JSpfQl/e9eN/wGhOnuCXpLDI7lYpfY1F7jXkh+4uFgoFrrDEbrGCoa6uS+H
 BAW85M+gUyKbJmDxDmDVRCZr2gT94okU9HtBeALIEGM5Y5bxev/KbOOmAwmcmcJVECfN
 t05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748855248; x=1749460048;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1eCV4vIb6ahPQ4VMmy3NO5u2F3ZquGRz6jC1wZD8HCo=;
 b=ixqE5e/6Mek76NcytKAzCBR+1pq3SynF3SIXK//yl0c885wNXOwp5OkEvCAgIHYtwY
 OI/JFBS6ZDzBuTNYD/IduRly9zSCIb4JIHnpcedCcUUWBd900M4/Yfm5WuamuXLLrmEu
 Kmj9cDfJxNOP9s5wG1hiPmDpRcURbj+g4W/kld7RY90OTAS2aDjhh3ORGln7MtyxC0WX
 BjNpPHIu0Z4jRIzn0BU82PZSH4DSmtmiBZvuQ7fkXanYjMiFFXy6wrNIRafSK6q0Nevj
 5B+6BYv11uovjt7/jjnsxVceDzqm359ftelzI+haakozppMLiPUL/KzeUSzlDUcrHUCz
 ZwaQ==
X-Gm-Message-State: AOJu0YxP+hYq6/6u4pk6XyA5f9q5pBsbeAi8xc6rozMP5AHojglDIUne
 DKEHRLJdUSbqUpM3EoYtvHDxQKFyB+ihb9COOymLkDAUfb2iqqZ9+MVSrSyC460YNNRiv0QnabP
 GzkJaR/8=
X-Gm-Gg: ASbGnct1ldgUNSL0HOyi9kcW9qSZSpCHq50o/fTbdgRDKr6fzCITmuBDRBz4SxRLw6i
 l4Z+DlUc7dAv63kkq8E0VlWbQo8/VSjjXYcYS53lWTbgzyd11z+UdKoEpyMszD6Nkv64xaz722J
 05mly9v9gLv8UjHcnQE8p3gNjtEd8VHl7497izqI1Q3ThvPdKxvk+2EBqE6aQpyjESZwfFm8oBv
 DIqqHQghg/WtWuTBHoZLoFQ2+dCuBmwdQ7O0z6EujFtpfgK7HnqZsM4auoe7oX+VtvKEjEKgpiv
 tI7G+TcJDhP3vpo4c4Blzg78gu/AFx9qFWalftUQ7kGhpZpcQFqALoRQM+vh3Fx3JAZ9HizT7TY
 WIQ5JiG4PTw3rHQFm33NYjyCruQ==
X-Google-Smtp-Source: AGHT+IG/JDThagdN4WcU4bJZlqxBYP/4A4hRKPuK75hhGw0dEwqqjsH++f375AiVs0Ah1Q9UmYAYkw==
X-Received: by 2002:a05:600c:3f92:b0:442:f904:1305 with SMTP id
 5b1f17b1804b1-450d6b5999bmr115983235e9.6.1748855248625; 
 Mon, 02 Jun 2025 02:07:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb8990sm115959275e9.32.2025.06.02.02.07.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Jun 2025 02:07:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] system/cpus: Only kick running vCPUs
Date: Mon,  2 Jun 2025 11:07:26 +0200
Message-ID: <20250602090726.41315-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

We shouldn't kick a stopped vCPU, as it will be resumed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC: Better to assert and fix call sites?
---
 system/cpus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/system/cpus.c b/system/cpus.c
index d16b0dff989..4835e5ced48 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -494,6 +494,11 @@ void cpus_kick_thread(CPUState *cpu)
 void qemu_cpu_kick(CPUState *cpu)
 {
     qemu_cond_broadcast(cpu->halt_cond);
+
+    if (!cpu_can_run(cpu)) {
+        return;
+    }
+
     if (cpus_accel->kick_vcpu_thread) {
         cpus_accel->kick_vcpu_thread(cpu);
     } else { /* default */
-- 
2.49.0


