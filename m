Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA90CDD55D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 21:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr1tb-0005ad-MJ; Wed, 18 Sep 2024 17:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sr1tZ-0005QM-9S
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 17:07:29 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sr1tX-0001ey-Jx
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 17:07:28 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c42f406fa5so108497a12.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 14:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726693646; x=1727298446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJpVIU5QQnwL+VksdQ4VURK2afv6KY7pJOWQu7Phvmw=;
 b=SWUvD0+AqGdL22pOh/W4tLpWRbF+KPSX+mWCJpLSwUeqSWIwrhhrWP/6kWx0Cwo742
 JNxYDQU1ayVWTvkm97spYOtipr4Y+/BSmIFL2EC8rGxxgYtDCZb3oV81YX5K/hcnW0E6
 fDV6KdmrJqu2KQmVCTUNx+472PywKPOCVQ6fCrUckg/MZOCC7pSf9HRNPIcTc2xXLwXN
 jYtY3N5HO+BJv6eyxWfoRaG4QwSt53vg0duc0/K7HowHkmW60uq1pTsOsqiKBIFhGBG7
 1LjFNnCCyCXyola9aJ5hqYLBpRDaV3He4DLKJqkQW4cu1+iONfFFZx3roXWZqfe9YBzb
 9SCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726693646; x=1727298446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cJpVIU5QQnwL+VksdQ4VURK2afv6KY7pJOWQu7Phvmw=;
 b=rF1pJ21l4nlkFcg3nk9XeiDX/nLeJKSlZEoWYHh/ZcqNz3sr09JLn8A7fqcYAVhA0a
 wog3TBYvW7C8If70A7Qq711kAlfZ2SvlaQSYdRPLK5WKSxmK4UsDAsZu5cyc7YuABfdA
 AIkkebDcljN6vYSO39sP2rRZyl5DI5iBTNm63cRDp4Ra9pOrO7hvjf1qQEU6jXFmTAzm
 YHRjHVJDsHvR+9wWz7Kk8J4/HUNTaregwnfM4qjTjQR6BdzaKClqRT/cvvGdeR5uLYfP
 4eHNPnBaNupd6sYg06K5TwwVEgF2nMPN0Zx/xWm/GUp1NuAt4HkZgFepLozh7DFpcT0v
 SSdQ==
X-Gm-Message-State: AOJu0Yzsl6j9q4JRKyFg9LBnsnjnvESXMfn6qN/2Gunk+IxopqY/l2gN
 odHgG/3qrkhpNALtujMzjbLGPEowAdo7oqn0rg7SvNeH6GX6HcqcCV5fVGXmfUA=
X-Google-Smtp-Source: AGHT+IHeXBCMp+lPkW5qsWyBrr8B0Tf6YEaWCT1pKwmSEC4U+puObq/jK4qo7MSxxqKSQO/XMhj/RA==
X-Received: by 2002:a05:6402:5d3:b0:5c3:c530:e99a with SMTP id
 4fb4d7f45d1cf-5c41e1930c7mr29715024a12.15.1726693646069; 
 Wed, 18 Sep 2024 14:07:26 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bb89d50sm5389238a12.78.2024.09.18.14.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 14:07:22 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 075ED5FC95;
 Wed, 18 Sep 2024 22:07:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Elisha Hollander <just4now666666@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 18/18] contrib/plugins: avoid hanging program
Date: Wed, 18 Sep 2024 22:07:12 +0100
Message-Id: <20240918210712.2336854-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240918210712.2336854-1-alex.bennee@linaro.org>
References: <20240918210712.2336854-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

Reported-by: Elisha Hollander <just4now666666@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240916085400.1046925-19-alex.bennee@linaro.org>

diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
index 29fa556d0f..e5297dbb01 100644
--- a/contrib/plugins/ips.c
+++ b/contrib/plugins/ips.c
@@ -152,6 +152,12 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     vcpus = qemu_plugin_scoreboard_new(sizeof(vCPUTime));
     max_insn_per_quantum = max_insn_per_second / NUM_TIME_UPDATE_PER_SEC;
 
+    if (max_insn_per_quantum == 0) {
+        fprintf(stderr, "minimum of %d instructions per second needed\n",
+                NUM_TIME_UPDATE_PER_SEC);
+        return -1;
+    }
+
     time_handle = qemu_plugin_request_time_control();
     g_assert(time_handle);
 
-- 
2.39.5


