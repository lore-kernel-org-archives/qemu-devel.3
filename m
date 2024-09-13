Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D3DEEEC17
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 17:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spAFN-0001R7-BG; Fri, 13 Sep 2024 13:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spAFL-0001Jn-Jf
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:38:16 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spAFJ-0007El-Oh
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:38:15 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c3ed267a7bso2763449a12.3
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 10:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726249092; x=1726853892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NGz5PDdfxAHM9W9xvRou3IwZ4GoE9mbAemCN1C/ecuY=;
 b=PRTDXtfNoqYRnTgtnEJzQZFXcEJY0LQ8K6PqTShC0UW4bH40GHQA+0brWpBCLJEn5E
 N3eIh+/F2fEQN7v+sw0FjH7LFs57qSa2wJG8ROLLwZv77zeadnOYULNuTu+ZuWceWQMQ
 PRhRHV7cT0xeM1huIzbLN0+0P2k9DJN9LadCQ2Ccz6Ft9In8jMFCacn4GY9iH5u/A/HL
 gU4vPOOWmPYZPqrZ1P2VEN78uZa9WEJGmOltjhJzyjI5bh1jVNymuIg8Jw8mUfHPLqmO
 SWMMQxUieQYkPyOlb9FnSv591uml7QVWX49p3CsShan8eUKz9iLM76iGU+i5s+8FLLaN
 vPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726249092; x=1726853892;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NGz5PDdfxAHM9W9xvRou3IwZ4GoE9mbAemCN1C/ecuY=;
 b=RYasAKpx1U+q3X+SsGITx6Gtn1i2RO50A2RAqi/m6m3zAyQ3eiKz6h9CFme7qWg1Nr
 osi9mGSic5zIy2AIbRD+ltLaBhGkM5yWsLK/v4mGA/KJY1zd9JdyK5G8OuG4bwmXXAvo
 fzqVY0CClWXqB2uJbOar4xgg1qc4e0q//rFb7IA7h9NKJ93xXTY5Wax/NET1nr9L+9nM
 4/GnnfpPkjG+g8S2q1Z8sSKMEfOUQaW5DdSoh1PcyBcBBpDUDA0+d1SLcRoQo3PSf5QJ
 3mSnYxzHtM3wlYnhaZYbfX0Ch58KclczZIfY4kCzm7cfxNr25duGd86I9XUDH95jB6po
 kk2A==
X-Gm-Message-State: AOJu0YxZOSd41Vvii5dSSIMJX5wSTioxp3bL88hNFCHZvaPCVZtr5dqg
 PFsL30VBhEcaE5jnUjIjIoSj3HiieKydFsdsYsn55rp5EgD2YpdIdYBhGXuIMZY50S2boL7EDOV
 FLZE=
X-Google-Smtp-Source: AGHT+IHnNJC/hdmKkP1wJiTEN2tKT+V0dcLGILUvRIBCQnHNuGYuwzDl58OBPaZDcFmW1lwpnHpyDQ==
X-Received: by 2002:a05:6402:1ec2:b0:5c4:b23:fe6f with SMTP id
 4fb4d7f45d1cf-5c413e14001mr5726490a12.11.1726249091714; 
 Fri, 13 Sep 2024 10:38:11 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd467desm7752124a12.40.2024.09.13.10.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 10:38:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A9A635F897;
 Fri, 13 Sep 2024 18:38:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Elisha Hollander <just4now666666@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH] contrib/plugins: avoid hanging program
Date: Fri, 13 Sep 2024 18:38:07 +0100
Message-Id: <20240913173807.189747-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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

Although we asks for instructions per second we work in quanta and
that cannot be 0. Fail to load the plugin instead and report the
minimum IPS we can handle.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reported-by: Elisha Hollander <just4now666666@gmail.com>
---
 contrib/plugins/ips.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
index 29fa556d0f..6f078689dc 100644
--- a/contrib/plugins/ips.c
+++ b/contrib/plugins/ips.c
@@ -152,6 +152,11 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     vcpus = qemu_plugin_scoreboard_new(sizeof(vCPUTime));
     max_insn_per_quantum = max_insn_per_second / NUM_TIME_UPDATE_PER_SEC;
 
+    if (max_insn_per_quantum == 0) {
+        fprintf(stderr, "minimum of %d instructions per second needed\n", NUM_TIME_UPDATE_PER_SEC);
+        return -1;
+    }
+
     time_handle = qemu_plugin_request_time_control();
     g_assert(time_handle);
 
-- 
2.39.2


