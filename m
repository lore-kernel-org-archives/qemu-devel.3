Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85DEC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVqqI-0006JL-4H; Mon, 22 Jul 2024 07:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqqD-0005zM-B5
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:29 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqqB-0002Uv-48
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:29 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ebe40673d8so51617151fa.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721646265; x=1722251065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OsxJlG2O21VU9fz45mO2VxagozV0j39OOaB75wjf6W8=;
 b=XUZL3zDxrjx/biO+Lxu2gvXLnHHvvK5qnYleovcclpmnv4HmJ1NEs/UdaA0n9NUgtK
 SvAU2PgLERQmgtUothD6G77VqjgsLNbbiNDHsCnnIHKfkAfOqAQ0ufR8Tuif/ltsO2g0
 /M3X+Als1upx7z39oph2O5IKl0TdIFtx29x1Enrde7kBhJyvm/n0rOp6TMvS7RF8ByM0
 azHXbagQTtHMsRMQoer6V8TsdTpmA6r6m28GW0vxumloRLfXR2TPlZuQE8PF+UYZJCa3
 MOg9O+ErPw4Bk94i05KSf6UviGJ5eudQHKivaf9BbdnNWwmEX/8hLTpFMZXzjW2dgvci
 EjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721646265; x=1722251065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OsxJlG2O21VU9fz45mO2VxagozV0j39OOaB75wjf6W8=;
 b=uSOMl2JzBn5Cenp0fP5RjYRwCkY5sVBt3bIWrtOKxKJVSQLMjSzT5KcFl3gscuS8ol
 dDdVtQttgEt/iaWhfNqXg/JSdmX/zvyIq52vEmZkqmQeiLwu70rNFUVz1PutTqmji4V4
 p60rXNaY/t6nswrQllAsist7BvecQXoUOFdQXU59teDW2mxPmRhbulMNxvtp35iFOEN+
 LblpompQ1U1OdBRY2gJlaDadTFMimn54UmwloYD1qs6deF29xC39Pc+SfBQ7DUdO3l7q
 taFz5w1KjMLRHZsCPf4vw1aAXgeFu3A0XEhT5l4us43caAomIp/tmUaTJ1USD5qPzHhx
 30mw==
X-Gm-Message-State: AOJu0Ywv01mHTUWIqHCCJDeZoJTND5aQYi4w53g9s2lUZqOAIIZCIZZT
 G0Oe9KNJqayWHQ88IPI1MVH0bqv98NilWhkz285lQL+qg6kEt8G8O7MpMwgpPrc=
X-Google-Smtp-Source: AGHT+IH0oGuucvRaBmDOinGpsbkgFkoB4EnEQtWpz41SZJ22X8B7xhDK5Ntm5bH7AQxJJTPxxZZWgg==
X-Received: by 2002:a2e:8006:0:b0:2ef:2c0f:283e with SMTP id
 38308e7fff4ca-2ef2c0f35cdmr24288051fa.12.1721646264920; 
 Mon, 22 Jul 2024 04:04:24 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30aaa3505sm5954123a12.34.2024.07.22.04.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 04:04:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A2365620FA;
 Mon, 22 Jul 2024 12:04:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 11/16] target/m68k: Restrict semihosting to TCG
Date: Mon, 22 Jul 2024 12:04:08 +0100
Message-Id: <20240722110413.118418-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722110413.118418-1-alex.bennee@linaro.org>
References: <20240722110413.118418-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x236.google.com
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

The semihosting feature depends on TCG (due to the probe_access
API access). Although TCG is the single accelerator currently
available for the m68k target, use the Kconfig "imply" directive
which is more correct (if we were to support a different accel).

Reported-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240717105723.58965-5-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240718094523.1198645-12-alex.bennee@linaro.org>

diff --git a/target/m68k/Kconfig b/target/m68k/Kconfig
index 9eae71486f..23aae24ebe 100644
--- a/target/m68k/Kconfig
+++ b/target/m68k/Kconfig
@@ -1,3 +1,3 @@
 config M68K
     bool
-    select SEMIHOSTING
+    imply SEMIHOSTING if TCG
-- 
2.39.2


