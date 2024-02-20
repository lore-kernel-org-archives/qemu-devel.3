Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76782C5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 17:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcTbJ-0005gd-PC; Tue, 20 Feb 2024 12:08:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcTbI-0005g3-D9
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 12:08:12 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcTbF-0007Uu-Tp
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 12:08:12 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33d2b354c72so2299225f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 09:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708448888; x=1709053688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4x4OmAqRmJ8/NCsb6tveV7GR/cM5COawqpxVQsuths0=;
 b=SoicNDZl4IzdcodTXqp07QhJuw84BLYQxRDyPU7wDD7LIzPmcTXLszBZvyrak9AsMB
 4RfFtSJVe5pn7048MoAgbUoeEv7aAxTz6PjpYqqWBd8JQFoGtGPNeU5vPS+aayUky0Mq
 SOLJHmvUifXReC2UdMmnKx5BN5iN7ZTwgqJmaScYESPU9CLKiSxA6OaArPV1fl7p4jCC
 hAaRve1oAmcZ8rM1yaiF54lqe9qjE7kmJybTXqolJAjT6h+3B79BQYs3KihbMhbomS0/
 IdPI4QpPjCIul4URPfDUGi3GL5jOnIjpyMjeJ7Fku5fWbrR8NnGfAm28/d3QxLjVbRAj
 y3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708448888; x=1709053688;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4x4OmAqRmJ8/NCsb6tveV7GR/cM5COawqpxVQsuths0=;
 b=cmTYhsXctfZp8V+pU9fHoT6yJD3PYLvBt8A0EXPkVPCSv8myFbEzSytg0AY9c8ilN8
 kKYlnwuWpJnCwAb2UOyX/cD02RkZ8isKozRW+NLAVAoafonGhUn9Ee3EL74rvwvOvfVe
 DKjElsbru+M0tN94KYOOCRyFok9Tcbb3koc9WgRtcWW/YPmTK65ZQ/8WAvMUnmnKYn78
 5hZh3Sb7recbMWdDunixZSg/7Ai9ghCDmG0t11kKo/Bjaxl++PK+EG+FDYQBIffFmOif
 NlC0NcCShJTukv8YFLsOMgXbNI7cOc7gVN5E2VG9afR5LRP7XRsejoY2FgRt1go5bANn
 tI0Q==
X-Gm-Message-State: AOJu0YwsZo9BNRHGS6kJR9k+Kcf5j8fFQqRIADpEuB/+ZkDjkEwAnKZy
 /6Vf6TIAm9yX5l1G3g/9PEmNeStBrdYdypTQBl5KEIuUDYb0N7rzfkUh9wYq3hk=
X-Google-Smtp-Source: AGHT+IGhA/4ffNZp1IVvikXSHvigb0z7uMUfooGx6o5htr5/Sp6gG0LMyfe6tKWeLwVDUbMJJDWMTw==
X-Received: by 2002:adf:db48:0:b0:33d:2a1e:99f5 with SMTP id
 f8-20020adfdb48000000b0033d2a1e99f5mr6416538wrj.23.1708448887779; 
 Tue, 20 Feb 2024 09:08:07 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 b14-20020a05600010ce00b0033d06dfcf84sm13962281wrx.100.2024.02.20.09.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 09:08:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1AAB15F85F;
 Tue, 20 Feb 2024 17:08:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [RFC PATCH] linux-user: ensure nios2 processes queued work
Date: Tue, 20 Feb 2024 17:08:03 +0000
Message-Id: <20240220170803.888143-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

While async processes are rare for linux-user we do use them from time
to time. The most obvious one is tb_flush when we run out of
translation space. We will also need this when we move plugin
vcpu_init to an async task.

Fix nios2 to follow its older, wiser and more stable siblings.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/nios2/cpu_loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/nios2/cpu_loop.c b/linux-user/nios2/cpu_loop.c
index da77ede76bd..7fe08c87501 100644
--- a/linux-user/nios2/cpu_loop.c
+++ b/linux-user/nios2/cpu_loop.c
@@ -32,6 +32,7 @@ void cpu_loop(CPUNios2State *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
+        process_queued_cpu_work(cs);
 
         switch (trapnr) {
         case EXCP_INTERRUPT:
-- 
2.39.2


