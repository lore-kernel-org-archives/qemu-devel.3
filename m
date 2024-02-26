Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC53C54E51
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 17:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeIa-0006O7-V3; Mon, 26 Feb 2024 11:57:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reeIX-0006Ma-De
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:57:49 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reeHo-0007jI-2o
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:57:49 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33d32f74833so1881196f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708966622; x=1709571422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xq3bg3O489fduJkQRD4v3a7EWyBdeXHXm96vjazL+zo=;
 b=HXUixjkbqaiZxTDyLqCoRhEqNvwEt0AwA7XVBWlhHxqoV5vXMuRwvc013urd+z3oW3
 tNgwyNvjWHNTx8t6GuG8iDysOqVFPG20pqVSGA5hEKl///ta+lOzBC0Buji7WQlZ7yph
 godirIcpmGpS31/OJYhnXQ5rq9fvwVMerLTjwPeu9MdJNdgvVuG3mgxBHSSzjW52yLc8
 FacQKnCvNCbGZ/9BXZVWDy7c1DspFfiSSS7cXeZcbKVL+iInz6Ye7Pz2rgPB7yqBAASz
 mETU5czV1tcsZqhyJWixCkL8Tsox/w+j8AdgpH3+f/d42GtzfgZgJ7u/T9u1ZeuOx1qP
 jwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708966622; x=1709571422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xq3bg3O489fduJkQRD4v3a7EWyBdeXHXm96vjazL+zo=;
 b=UvkEEV4FFRAWj0x9WxQ1aCi+ce2d0ZpGCDHBuPIt4yRfuLt4J66ToJcsEYIggWncUT
 YhHRrgFPYSXn4DWFiKCkCXm71W4OrjbQJb9BdGA9j+S7i64cAfkWJCTi9mlJYhIQ8L2N
 Q14HBdpQ4ExxUt5C1NuK8f81PbD3rLsbnc+dT5naavb4Z49XCvH0xhADBeyrX3vNl1Wc
 cs4kjE/8qDxZOi0xJ+Pb3bQy9KFPmcU3KPCkY7TkfHRglYGHmR7CRs9dJpJnq7W6DHyt
 z47E7SPyqbdjirZzTV20sglc8zxZBY6NFRB20usufXEkMHTwgn8KvUcV9AhoJdUCLGJh
 dO9w==
X-Gm-Message-State: AOJu0YxLJuDGsqZCkJFpz4P2JDugNpdoAap8sU2+lo2Eb8IzBiXDldAG
 bgRf1SZj8FuKBDafkirPog0oqNwQL/EtaCEYkFNIpCb1G+JDhn5oJInoNRJUAvA=
X-Google-Smtp-Source: AGHT+IF83sYTpsao141vDZtxlciTvsvDsdhgKVmiGEogP5UlDGeHiDTtbN/kBpy4VylhVfLjMsOLPQ==
X-Received: by 2002:a5d:598c:0:b0:33b:4818:f438 with SMTP id
 n12-20020a5d598c000000b0033b4818f438mr6435914wri.50.1708966622510; 
 Mon, 26 Feb 2024 08:57:02 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm8724194wrm.117.2024.02.26.08.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 08:56:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 464125F928;
 Mon, 26 Feb 2024 16:56:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Brian Cain <bcain@quicinc.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 15/27] plugins: fix order of init/idle/resume callback
Date: Mon, 26 Feb 2024 16:56:34 +0000
Message-Id: <20240226165646.425600-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226165646.425600-1-alex.bennee@linaro.org>
References: <20240226165646.425600-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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


