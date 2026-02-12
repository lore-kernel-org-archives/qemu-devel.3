Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42148EDF026
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 03:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqNTd-0007l7-Iv; Wed, 11 Feb 2026 22:34:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vqNTb-0007ig-48
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 22:34:47 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vqNTZ-0008Hd-5c
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 22:34:46 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d45d37f8e4so1500588a34.0
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 19:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770867283; x=1771472083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vOlmKgS2vbk9b1Bfi6akzOHaQXEZzYfRriG6tDHDMB4=;
 b=gNIuNuDgQOJDHqkEY+BIBVIcMLZIN7PKSROY79olAH9uSNziWHNpITiNdUlaxRbuel
 meu76HFzzPcTcBjSMo3PxZySQTToeypEmw/x9ifi74up0uSKLZc65HlcrTjVu65v+c9M
 aXB5XxVTBCatjokt7h5xIiRBHR/aWKOiPCMddi7ThQjUs1+1aR95UG9q91mdLgwqThmt
 43WPmh7eDyZkb7gqRanvR+6DaOEDShsAYRn5xb6Zwg69QLZBYv2lG4W0L6t9Nk6uY4rf
 9L+mvG5Oym6xNLdc59kwUIH0EQKLPRP2ReuDMPA1FUQAIl8ZraiMSfsoQo9pRAQGM58C
 HUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770867283; x=1771472083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vOlmKgS2vbk9b1Bfi6akzOHaQXEZzYfRriG6tDHDMB4=;
 b=TdoFZYg3OIsobRbVK/6lXvspUxt2Cob8oCs3alcpa/QnNB7iweZvejZQUUc/Tg8U8t
 gmUMTCQOztArSKPWm0FYHOgxXeYoGRPWIImZ6z16c/yUpe8GyvWqvMptZGcCqljMld0r
 isY2MoInbwRob1pJevyefMhXH5xydrJr9LD8gKjS9bfW1r82WhT+94whMqMn9uMjwFFX
 zBNef30fvcS/mlieapayEQ5FCduLEKuE7qUMhm+vd0vDyd5jOoxNNLMHR2ajnm6B6HTh
 83z/MZQQ08oh9oKrDVF37jm4JsF93k97ezGNJkQPfFEnpWGSghb41ES0HnpB3cikX7TG
 IlmA==
X-Gm-Message-State: AOJu0YzBf6+UhL7QdPieDaaitvE3HPcqu7WURSevhgxz2ejCc8aY7vvB
 VYtWefrGoWsGkgSsjc6jtgGZajlXxKOXaCrEOgZRfOPDb6R7FHl7Cqk9wlgQ2Q==
X-Gm-Gg: AZuq6aIzZHURDuGtr+PkjvKcc2qs+SpPMRheRCTM0FvZBQgBP8nvZwX9usA2Q9q2KzL
 jC7BdON+ce42QjxG/9rRu4JBwnjx6hzqqxoXvzD50mVZruBW9rZUzlt2MWjZpyiJjgKomzpt+NS
 TM9SuwydPVbRCE5PoM6xMGQd3tvUKKELLsNIJX7ehioCDKiRBGZIOpNuRPzvKmKxpvlbdxfeb9r
 zjlwuzgkptsPEzqg11mmeLDLUmNvzVT3jORiQY32xik1gje55rMEF2oN0WhYcRrUaBdhuJhWHMI
 B41CcF2KmcfhsoQWtCt0GD8JDkcsIOUYX/AWpAEqj1UaUfZyZWnEPXxwkgpqRXXBJWDnPIc/ymj
 nA9My0VcumK04vwE9Qbm1+Hy71t8bgyXvGDFr4SMOUuiHnw1M4BngrXW6oFgzyyZhEMWeUYRII7
 rP63yq6E0GGK7cHP6z7nN1XXQAIz7i2Mn1+SPStQDLamaI+kSz0e++Nw+76AJ3hp3kMmLXmisjR
 PkafN3HibxW8yy1
X-Received: by 2002:a05:6830:310a:b0:7cf:d2f3:af8a with SMTP id
 46e09a7af769-7d4b4236297mr413041a34.28.1770867283494; 
 Wed, 11 Feb 2026 19:34:43 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76e1b0csm2682858a34.14.2026.02.11.19.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 19:34:43 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH 4/8] Hexagon (target/hexagon) Introduce tag_rev_info.c.inc
Date: Wed, 11 Feb 2026 20:34:31 -0700
Message-ID: <20260212033435.3598-5-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212033435.3598-1-ltaylorsimpson@gmail.com>
References: <20260212033435.3598-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>

Table that records which CPU revision introduced or removed each opcode

Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>
Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/tag_rev_info.c.inc | 61 +++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 target/hexagon/tag_rev_info.c.inc

diff --git a/target/hexagon/tag_rev_info.c.inc b/target/hexagon/tag_rev_info.c.inc
new file mode 100644
index 0000000000..ed7fb68aaf
--- /dev/null
+++ b/target/hexagon/tag_rev_info.c.inc
@@ -0,0 +1,61 @@
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HEXAGON_TAG_ARCH_TABLE_H
+#define HEXAGON_TAG_ARCH_TABLE_H
+
+struct tag_rev_info { int introduced, removed; };
+
+static const struct tag_rev_info tag_rev_info[XX_LAST_OPCODE] = {
+    [A7_clip] = { .introduced = 0x67, .removed = 0x0 },
+    [A7_croundd_ri] = { .introduced = 0x67, .removed = 0x0 },
+    [A7_croundd_rr] = { .introduced = 0x67, .removed = 0x0 },
+    [A7_vclip] = { .introduced = 0x67, .removed = 0x0 },
+    [F2_dfmax] = { .introduced = 0x67, .removed = 0x0 },
+    [F2_dfmin] = { .introduced = 0x67, .removed = 0x0 },
+    [F2_dfmpyfix] = { .introduced = 0x67, .removed = 0x0 },
+    [F2_dfmpyhh] = { .introduced = 0x67, .removed = 0x0 },
+    [F2_dfmpylh] = { .introduced = 0x67, .removed = 0x0 },
+    [F2_dfmpyll] = { .introduced = 0x67, .removed = 0x0 },
+    [J2_callrh] = { .introduced = 0x73, .removed = 0x0 },
+    [J2_jumprh] = { .introduced = 0x73, .removed = 0x0 },
+    [L2_loadw_aq] = { .introduced = 0x68, .removed = 0x0 },
+    [L4_loadd_aq] = { .introduced = 0x68, .removed = 0x0 },
+    [M7_dcmpyiw] = { .introduced = 0x67, .removed = 0x0 },
+    [M7_dcmpyiw_acc] = { .introduced = 0x67, .removed = 0x0 },
+    [M7_dcmpyiwc] = { .introduced = 0x67, .removed = 0x0 },
+    [M7_dcmpyiwc_acc] = { .introduced = 0x67, .removed = 0x0 },
+    [M7_dcmpyrw] = { .introduced = 0x67, .removed = 0x0 },
+    [M7_dcmpyrw_acc] = { .introduced = 0x67, .removed = 0x0 },
+    [M7_dcmpyrwc] = { .introduced = 0x67, .removed = 0x0 },
+    [M7_dcmpyrwc_acc] = { .introduced = 0x67, .removed = 0x0 },
+    [M7_wcmpyiw] = { .introduced = 0x67, .removed = 0x0 },
+    [M7_wcmpyiw_rnd] = { .introduced = 0x67, .removed = 0x0 },
+    [M7_wcmpyiwc] = { .introduced = 0x67, .removed = 0x0 },
+    [M7_wcmpyiwc_rnd] = { .introduced = 0x67, .removed = 0x0 },
+    [M7_wcmpyrw] = { .introduced = 0x67, .removed = 0x0 },
+    [M7_wcmpyrw_rnd] = { .introduced = 0x67, .removed = 0x0 },
+    [M7_wcmpyrwc] = { .introduced = 0x67, .removed = 0x0 },
+    [M7_wcmpyrwc_rnd] = { .introduced = 0x67, .removed = 0x0 },
+    [R6_release_at_vi] = { .introduced = 0x68, .removed = 0x0 },
+    [R6_release_st_vi] = { .introduced = 0x68, .removed = 0x0 },
+    [S2_storew_rl_at_vi] = { .introduced = 0x68, .removed = 0x0 },
+    [S2_storew_rl_st_vi] = { .introduced = 0x68, .removed = 0x0 },
+    [S4_stored_rl_at_vi] = { .introduced = 0x68, .removed = 0x0 },
+    [S4_stored_rl_st_vi] = { .introduced = 0x68, .removed = 0x0 },
+    [V6_v6mpyhubs10] = { .introduced = 0x68, .removed = 0x0 },
+    [V6_v6mpyhubs10_vxx] = { .introduced = 0x68, .removed = 0x0 },
+    [V6_v6mpyvubs10] = { .introduced = 0x68, .removed = 0x0 },
+    [V6_v6mpyvubs10_vxx] = { .introduced = 0x68, .removed = 0x0 },
+    [V6_vasrvuhubrndsat] = { .introduced = 0x69, .removed = 0x0 },
+    [V6_vasrvuhubsat] = { .introduced = 0x69, .removed = 0x0 },
+    [V6_vasrvwuhrndsat] = { .introduced = 0x69, .removed = 0x0 },
+    [V6_vasrvwuhsat] = { .introduced = 0x69, .removed = 0x0 },
+    [V6_vassign_tmp] = { .introduced = 0x69, .removed = 0x0 },
+    [V6_vcombine_tmp] = { .introduced = 0x69, .removed = 0x0 },
+    [V6_vmpyuhvs] = { .introduced = 0x69, .removed = 0x0 },
+};
+
+#endif /* HEXAGON_TAG_ARCH_TABLE_H */
-- 
2.43.0


