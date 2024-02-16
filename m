Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4810DC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 16:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb1Dm-0001UC-Tw; Fri, 16 Feb 2024 11:37:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rb1Dl-0001SR-Lv
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 11:37:53 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rb1DY-000462-1U
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 11:37:53 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33d07ee22eeso619313f8f.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 08:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708101458; x=1708706258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xq3bg3O489fduJkQRD4v3a7EWyBdeXHXm96vjazL+zo=;
 b=AkNDxkuIHxHQFNZUp/7MrvxkivggZjgRSvuOUTGJhOAIq6+wi/S/I1TwQQGYMu6QUL
 GvPveafpCl7b4n5aiYD9Vt6bDEF2h2WDLiEZXk2fZX1lprTfLjyXit2EBmLjEr9imY5o
 dWJ9wgKEIS82uewDUz/y0dJQ/nj0w1jmwjbtZ88SMd9wHmp3qM6Di67uj75qxT5klDLu
 yZdIMqFLqr6igdtNDDA2kuIS8gjJYI0ToGv4dWq8ih33DelKMJFqfkTfmCYjWuDoYD7y
 jQd/8iL7gE/vRe44kR1xcAloD8Yo60JmwmT/f/qbb8oNRVi969SFIM0sml4QKU9bsXNy
 MCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708101458; x=1708706258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xq3bg3O489fduJkQRD4v3a7EWyBdeXHXm96vjazL+zo=;
 b=ZP4lzVReTSoU/72y42o0mxdB7cddigcvh+17hx6/+NHZp2l8GwTVsvY1gRGji/v7lg
 S7CQB87X5pXU+FKO6yISk03LUC0Qcq5FPsfo4cM73up58SBfDfkJJ2GAKxYx6xnFx/iW
 vkAbQ/pduVwrj6RPXrvKE+Z2w+pjLflg2gURzXaz4jkzD29zP7KvXdZc5oizHPFZSLCF
 MAIjaqrfD7iSFIr8Mr7oq/6ceOKjmHXBtIe7ra3NbKDlTQ+Vi/MqM+0DYQgTwOG9I7g2
 sOZyfygCBHAiYUNxGhQVZrxTMgBCixtCenshAlkRCcO4qI/EUzBOQyvbYZRV2W13TyAz
 a/Mw==
X-Gm-Message-State: AOJu0YyfojKleMjFrDplb0UCOiOpOZuVvWypJHgkWH9UcjXcK5CcNS9Q
 b9Y1B5bCY8xgQQuhAmrUr3OKdlKrC5NzH+aRT3rBWfnNOTTonXtm+DmYEhikeHA=
X-Google-Smtp-Source: AGHT+IF+azCIgmKTLCdw0EDUXddFCfFLrJsvyIrp67MlYlm7BX/FXDp3hmA3dwjC+AJ82R4hvc78vQ==
X-Received: by 2002:adf:f50e:0:b0:33b:304d:36b7 with SMTP id
 q14-20020adff50e000000b0033b304d36b7mr4393268wro.56.1708101458266; 
 Fri, 16 Feb 2024 08:37:38 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o11-20020adfcf0b000000b0033b4dae972asm2631828wrj.37.2024.02.16.08.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 08:37:35 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AE4365F9E0;
 Fri, 16 Feb 2024 16:30:27 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Song Gao <gaosong@loongson.cn>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Yanan Wang <wangyanan55@huawei.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 14/23] plugins: fix order of init/idle/resume callback
Date: Fri, 16 Feb 2024 16:30:16 +0000
Message-Id: <20240216163025.424857-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216163025.424857-1-alex.bennee@linaro.org>
References: <20240216163025.424857-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We found that vcpu_init_hook was called *after* idle callback.
vcpu_init is called from cpu_realize_fn, while idle/resume cb are called
from qemu_wait_io_event (in vcpu thread).

This change ensures we only call idle and resume cb only once a plugin
was init for a given vcpu.

Next change in the series will run vcpu_init asynchronously, which will
make it run *after* resume callback as well. So we fix this now.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240213094009.150349-4-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 plugins/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/plugins/core.c b/plugins/core.c
index caa66311351..2392bbb8889 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -391,12 +391,17 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
 
 void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 {
-    plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_IDLE);
+    /* idle and resume cb may be called before init, ignore in this case */
+    if (cpu->cpu_index < plugin.num_vcpus) {
+        plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_IDLE);
+    }
 }
 
 void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
 {
-    plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
+    if (cpu->cpu_index < plugin.num_vcpus) {
+        plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
+    }
 }
 
 void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
-- 
2.39.2


