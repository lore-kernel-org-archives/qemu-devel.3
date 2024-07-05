Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F51C3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPeVo-0001rF-Tm; Fri, 05 Jul 2024 04:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeVH-0000B2-Q5
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:17 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeVD-0003I2-LR
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:14 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a77baa87743so154558866b.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720168868; x=1720773668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lvuQOiGW9BFlfC8YjQOeAwRsNcaM68CdeZDfIgp7wbI=;
 b=pb/TUa4p8EIwBtGtYE14DnQa/qmg3QKIbizRuIy8zZpEuJqEtswRYIiURfcyOeGUV+
 DLvEkl5igHp+A2b34hsOGgxJVD+WkwMVdMQWmKAA2levolWYzDro1Yb/p/+5QNp36ggM
 AhTvt3NW8qZVEDiD3Xh+W0E009iXX/mineUG5TPzb2wYWYU3kYw+X0cL1TkvpmswEccx
 Sl0dmt0APJ9GRzlUE5vP4vl+R2Gwp2C1izP3Qd9JHkav1xSbAhL9yf+9h7Tvn5SVhRdS
 MI39GK0clq4FPJkaM92sDEW847rz4Oc4y9a0CQ7LSdybMC5MmVxVJq7npyBiR2RgoutJ
 S9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720168868; x=1720773668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lvuQOiGW9BFlfC8YjQOeAwRsNcaM68CdeZDfIgp7wbI=;
 b=JUNtVZtMnBT4MXZfXgtFjmDdCZZ37Ct3/ac41s4QjcZg0M+QSUDixlvy4kT9JL5gYY
 eNJg4V7OwDSKCpJp50GkRLK412W915Gobu3sqjlLFzR6F+/lfJ0Bhg6ujZRPCiKeMYny
 2BP2LkId1uQ+Dg3jmrZ9yRVEeoNmNFePaW3RWNXzm5yE+eoynArONFDCrKf09A22wx3V
 NNcbrnmqHIqKxS3B3yPnP9fdB9vbF14knD8aNlUUJSTgWZD0tkI9tgxxi4n7d0XTlG+x
 c97gXaTv3O+k2Q9KQ1jlZm/IYcaIk65XCJj5sdX3XZT3Xo1H1R4aarTxZa8JWAhrSOt2
 R4Nw==
X-Gm-Message-State: AOJu0YxfYilBMNHI5Fk+xz5ZxbTpoxjyQU1WgDWEi3cYRE8QGh9kTxBQ
 0sXWAy85TthA/85UOCaHBL+mQYgkS8qCD8XmhF7ubZ8781LVAMACigV2bKikK4o=
X-Google-Smtp-Source: AGHT+IEEeCMWOVzRLbNVbM2FEBrAPwUAOjM9enpMEEM6qfqWvnFtjEcdslg6UkgYLyB4ykj0j3iOOA==
X-Received: by 2002:a17:906:34d3:b0:a72:a05a:6601 with SMTP id
 a640c23a62f3a-a77ba455f83mr340685566b.14.1720168868164; 
 Fri, 05 Jul 2024 01:41:08 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77c3ef218bsm76340466b.71.2024.07.05.01.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:41:01 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6572862155;
 Fri,  5 Jul 2024 09:40:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 28/40] plugins: Free CPUPluginState before destroying vCPU
 state
Date: Fri,  5 Jul 2024 09:40:35 +0100
Message-Id: <20240705084047.857176-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

cpu::plugin_state is allocated in cpu_common_initfn() when
the vCPU state is created. Release it in cpu_common_finalize()
when we are done.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240606124010.2460-3-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/plugin.h | 3 +++
 hw/core/cpu-common.c  | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index bc5aef979e..af5f9db469 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -149,6 +149,9 @@ struct CPUPluginState {
 
 /**
  * qemu_plugin_create_vcpu_state: allocate plugin state
+ *
+ * The returned data must be released with g_free()
+ * when no longer required.
  */
 CPUPluginState *qemu_plugin_create_vcpu_state(void);
 
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index f131cde2c0..8f6cb64da3 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -283,6 +283,11 @@ static void cpu_common_finalize(Object *obj)
 {
     CPUState *cpu = CPU(obj);
 
+#ifdef CONFIG_PLUGIN
+    if (tcg_enabled()) {
+        g_free(cpu->plugin_state);
+    }
+#endif
     g_array_free(cpu->gdb_regs, TRUE);
     qemu_lockcnt_destroy(&cpu->in_ioctl_lock);
     qemu_mutex_destroy(&cpu->work_mutex);
-- 
2.39.2


