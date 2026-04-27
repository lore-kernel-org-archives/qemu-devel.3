Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A167FF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH1W-00017Y-Qo; Mon, 27 Apr 2026 04:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH18-0000na-Kg
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:08:37 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH16-0001ca-TD
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:08:34 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43d77f60944so7303917f8f.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277310; x=1777882110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UfM0rjL9l7HImwIhQNZz86yWfS4Ppx2p9yTZq5d663s=;
 b=EHS+Mcx6CHsrAT5+EfeEVoSInqXK5jx/3jCuMDP4G8BwMS4i3vdcruOXShk1HWzBbK
 vM6uwzLtF+OolhIzPIRK62gH+9c6Cmu+b9rMJAK2u4D+BgbrxXYvPjChGTp1nly2HpYg
 tQt430Ni3gm2v1j0cm70RfK56IIna+nBnBhQZKibo04RqmBiO2H8MeE3OZ6qabw14/n4
 S+aK7cA80a/VDo8ZYGC7nXeae7O/Y/FW9vVa2WQKcnKqqMhmKZwqGuSFSH+H5HuX5TaH
 VQXu9OfPrDCsb8RsZ6eQ07mhtttZTU4p9NdKp3bAXvIGryqa28gtbezFMNnB8lwF3hyn
 Kd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277310; x=1777882110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UfM0rjL9l7HImwIhQNZz86yWfS4Ppx2p9yTZq5d663s=;
 b=UM5W9yhsdNJbnPoA8MS7JBbkwjxg2R86lV/ZtQMWP9Zx1I+XldIBr5btONybeQYs2d
 /nP8lIgXYo/pilnOOPWC7dBfhI5MPlIENOyq570yOlooLXJ7vIDRytNjko3lEE9s1Zm0
 nMIOX0EB96vb/dgOKh6qmgOinek56ncIQEd4yaSkrg/PiISDA4NmVlYJ7ThCZJhnl0no
 PmwXVDUXa4CzvLb3xgDZVIjLgM9JLNpthAqrTPq22r1RjwOtAK+gGmjInHwehqSrulDM
 MQLxQiOAKpS0d3I2PcrnG3lqI9w3JD4e8nKBJTPkfoXdXNo5afB9SaIngLuEKoZCw/zV
 v71Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+c3HVHGHvPJHIBhHOaB1FiDhz0YDzsGlCLAvvieUckRsWjlfyof7urIrXDqyMRLoIROuT5MkvwDIUv@nongnu.org
X-Gm-Message-State: AOJu0Yz/0Qn7tWizipz0gmTJJFmDI9kI8RF0yDnSh31dxcLFQEmih19U
 QmpdeNLLpXtWIt0Yg3v91hN9CS04r0KVIgub/p327+XdyApazXwb2zlwFyreUFMhaS4fSTzc2sH
 D7RNBPSs=
X-Gm-Gg: AeBDieuoAYpAeaPvRcH5ZMKeL+7l2XFqSHXLhsv8fbU6xy9q4ZMypzULj5MkwSkjQe3
 jJ2aZyEMFmsfl2LmBvwELMGRes2JrFAi5jaHzIfAB4e0Py5xyUVHKlJL5TURzBZMHGm0Rdty3Ra
 7RxFhs6GCNIXcaJ5YZM8NPkQpEWZXoftzN4ilLZdFWzGFWLLkmSSXlwH/mFJxS2S5FDcRC1OAI2
 0Dm/qadLM5UIgCwIy7qlywPc6d39LwbTmRdukq3FOclsOQLeqwk/4EC6KB+13Z2chZ46XKakuK0
 hwl7iOSIqgZsubgBCRccTvB22Jr3Z0CQfXghyWAHH6bYDI0J4rIOyvHV1NLrRAK6mMnVc5DfTTK
 Q2d2VHvAsFsOER1nsgQ8OKkS0JfOjfPZYtXXipuh5+7qI240k8r1tPoCyOdywpFuBs/ZqoRU9EH
 NQf8+WFFq1Msj5DYI0RRojKLIICkzblvbDTwo1lDRJH3TtQkxM9WzxJnmKMgzlz3EBld3NoDjs4
 /fsJhg49ozDIlhrQ6mp9g==
X-Received: by 2002:a5d:5f82:0:b0:437:711c:8754 with SMTP id
 ffacd0b85a97d-43fe3dc842bmr66027146f8f.7.1777277309482; 
 Mon, 27 Apr 2026 01:08:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4411c9f4f03sm48330850f8f.1.2026.04.27.01.08.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:08:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 07/32] monitor: Restrict monitor_set_cpu() method scope
Date: Mon, 27 Apr 2026 10:07:13 +0200
Message-ID: <20260427080738.77138-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

As mentioned in commit 755f196898e ("qapi: Convert the cpu
command") 15 years ago, the monitor_set_cpu() method is a
temporary bridge between QMP -> HMP and shouldn't be used
elsewhere. Make its scope internal to monitor/.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/monitor/monitor.h  | 1 -
 monitor/monitor-internal.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 296690e1f1c..55649a86641 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -37,7 +37,6 @@ int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
 int monitor_printf(Monitor *mon, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
 void monitor_printc(Monitor *mon, int ch);
 void monitor_flush(Monitor *mon);
-int monitor_set_cpu(Monitor *mon, int cpu_index);
 int monitor_get_cpu_index(Monitor *mon);
 
 int monitor_puts_locked(Monitor *mon, const char *str);
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index feca111ae31..80b4a8150bf 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -175,6 +175,7 @@ void monitor_data_destroy(Monitor *mon);
 int monitor_can_read(void *opaque);
 void monitor_list_append(Monitor *mon);
 void monitor_fdsets_cleanup(void);
+int monitor_set_cpu(Monitor *mon, int cpu_index);
 
 void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
 void monitor_data_destroy_qmp(MonitorQMP *mon);
-- 
2.53.0


