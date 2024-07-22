Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EA8C3DA64
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVqqE-00062R-5L; Mon, 22 Jul 2024 07:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqq7-0005am-D5
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:23 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqq5-0002Rw-Py
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:23 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a77baa87743so434604166b.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721646260; x=1722251060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PrRW6kDAk1zqxe6ChLfrm5m8ZkEkLVOG9+rzr/DdABE=;
 b=dOJU5A2GMkruF/LwkIgq6HbbZWgHRVbeKZdQTqVSV7hI4k94cyOZo8M3D2qE2ja5pX
 4pmeWZlygJCu4p9aiTWPNxf5kjmWlKNAbbp72/gJf//yVTQluhi32jKzrt/U3yrVhWah
 GUSizjGVPEfFR/wA9IYh9hLaIWOwSITuE4rh+qVnoVQzQe59BCdmCsT4aR0xPOHMbGRc
 WTMtXoeKJR9g0urDBZl2tisNIItJ8vJleaPi11iNYcPTPAsZult1xHNfsBBd7p1g3VZp
 8hdZUy4J0FE3OhirN9jIzPkbVW8GL58IQgXuZrctSsZPY7UrS98UMIAPybq9KHVqU13L
 zA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721646260; x=1722251060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PrRW6kDAk1zqxe6ChLfrm5m8ZkEkLVOG9+rzr/DdABE=;
 b=ggEsxEkiv7hi2lCaO+9dM6AfIzZkqW5TMoG/80yEMXIqPDnExwvS6FDP/VEr6ZJUkq
 7lb8MqMsP227LfQ8boYujzyUXPh/iN1/5IJItlDmoo8YXN0lXd31kDzLDVNH0A5Vm9t5
 ZTIDCP8BaHr/8lVekByK6xLdElRZemq9espf8yjsiQEmKQBbqJm5Jc5ZngWX0ft7vW3Y
 Naan7sQJynLPyGX4KVvEXvE9f0HjWZUQTP6s5JupcZUqS9xN3PGLLG6n5SO2NeXU46GY
 PQiLQB/6j95iAAEgbJEN5YylH3IscM3Sh851d+ELEgdObT3E1M3IsKjQiig1hkgyPkvu
 lDXQ==
X-Gm-Message-State: AOJu0Yxa91HqcoCOe4+n/NKZZ4E7/WWr0ivR/iW9miZDWP0Rn3npMjnZ
 v4nDjqTBw5qBu4X9d2YbuJ59Rbjr/8wfZrz1CnxZh6pRxssyF/5LZDoJFNw2Ivw=
X-Google-Smtp-Source: AGHT+IEBcB7EGPcrXxM/6n9K+VMNhtFndgjcQj5F1VcgUSrUDhxKzNtbXp0mTfQm9Godb7jMqwYm3g==
X-Received: by 2002:a17:907:7f27:b0:a77:d7f1:42eb with SMTP id
 a640c23a62f3a-a7a4c051b22mr506743066b.23.1721646260101; 
 Mon, 22 Jul 2024 04:04:20 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c785d7fsm408521466b.29.2024.07.22.04.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 04:04:17 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5823A5FA17;
 Mon, 22 Jul 2024 12:04:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 08/16] semihosting: Include missing 'gdbstub/syscalls.h' header
Date: Mon, 22 Jul 2024 12:04:05 +0100
Message-Id: <20240722110413.118418-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722110413.118418-1-alex.bennee@linaro.org>
References: <20240722110413.118418-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

"semihosting/syscalls.h" requires definitions from
"gdbstub/syscalls.h", include it in order to avoid:

  include/semihosting/syscalls.h:23:38: error: unknown type name 'gdb_syscall_complete_cb'
  void semihost_sys_open(CPUState *cs, gdb_syscall_complete_cb complete,
                                       ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240717105723.58965-2-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240718094523.1198645-9-alex.bennee@linaro.org>

diff --git a/include/semihosting/syscalls.h b/include/semihosting/syscalls.h
index 3a5ec229eb..b5937c619a 100644
--- a/include/semihosting/syscalls.h
+++ b/include/semihosting/syscalls.h
@@ -9,6 +9,8 @@
 #ifndef SEMIHOSTING_SYSCALLS_H
 #define SEMIHOSTING_SYSCALLS_H
 
+#include "gdbstub/syscalls.h"
+
 /*
  * Argument loading from the guest is performed by the caller;
  * results are returned via the 'complete' callback.
-- 
2.39.2


