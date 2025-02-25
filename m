Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C77CC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 11:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmsoP-0001dU-Vh; Tue, 25 Feb 2025 06:09:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmso1-0001Xw-2J
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:08:54 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmsny-0007kr-UM
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:08:52 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-439a1e8ba83so51574225e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 03:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740481728; x=1741086528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzfASlzKsKSjymD2hL0UWygARz8YSW230udVTrSf3Pg=;
 b=ATxf8MhEWcxPrIjwLXa9t9NFhkK0b1IhDM4l7Uq3mMlRmPbOfK8ITZEQ09v5tbizZG
 1w+7XMcRdFN9CUcDEYE5ahH+jwA8RuRSAMpS8VojnGVIiBzYdK3pk8t1mruGsHhPcU4X
 oj/WpPcCWGQRIWKh22pPqlQy4kiOlhxPgr37JNiDbec8ccOukiJLtshYsMBIwDxTD93C
 6poHgCXQJVwPFGAVJH/55AdxLn3QAgemYwpFNXtUQZnfxZCdQtez31tV5H2v2SLCOTjF
 pBR8eS/842In3DTQIz2mqaVQKXTNKrVPOQpjo19P93nzLqwJAKBCfTHLe7aasVC5KBMe
 H9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740481728; x=1741086528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yzfASlzKsKSjymD2hL0UWygARz8YSW230udVTrSf3Pg=;
 b=lS5CnyvpscHU805dF7183+n5Yz8jaYyOpV36MDRfs8q81+LoSpRoUP+nK+DqL6OZRq
 qysjSAvyfi3rj71FNbSANqbLfP4lSdOLofnR+bWG4imomzrGFBctvfhB8eDTBaWizEWz
 jXBFBamS7EjOGksb3p9hVs+cS98JV1r86ud9UJNbJX5KVtuNUNq3VS3ZwxNoe0/2/fnD
 oAPoBa7+nx97t4u7de0II10ednSs2ibNi1m80mDKBBT7AMA123Rymjbo94ZESHubSLNf
 1qviox07xIu6lKFnx2XVnGUDq9KkIcCfQrLaq0WAQq8cHGCq2tm94bE5N6AiGzakChhb
 IAaQ==
X-Gm-Message-State: AOJu0YyB/mDt8GvOafQnbP06sZSMXwYtuWW9dzFDQukqCF2tNaNUVd1U
 cikp9RIflKMNcJiKw+XB8cvX8ZsWZX3wuME975J6/yUJKp2hk8izh9ej3buy7HQ=
X-Gm-Gg: ASbGncuTSU+mvRiAKxbDOs9PXSDo3iy8UFYFnRtMF6HFeWyduvDyFOOlIyEpeHpnbp/
 k94fp/dH2aRJtEGgR9TvUwDTt76BRqdPVq1sWtU1ighjNH43UGU6m6Rs7i1AyCIDcjFNxO+TuOc
 BfaDBuzEJ1LcfNNWga/dYjC2BCNZhnn1VHFIk4hsEMLtWpHJsEbKXD0DRhFgpkrNGK8t2SS0cu9
 BUzBZsy7Hgmy3qxCcSaoVI8XjvIR6xcED7OFKqEKOepXkqQfZ1M/sFQ7+tQLT7KCPf3XsUOrAOS
 X39gsPU847PfMvIjLMavH5iAlua4
X-Google-Smtp-Source: AGHT+IEoxAfbdQqWSPfDT+YzpGXh9jyalK7WloyWAl3AuXQz2RBw8Ap2Kv9nXj1vhIAeE3svxvpy+w==
X-Received: by 2002:a05:600c:1d1a:b0:439:9537:e96b with SMTP id
 5b1f17b1804b1-439aeb34990mr165336405e9.14.1740481728362; 
 Tue, 25 Feb 2025 03:08:48 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02f3e15sm136595585e9.22.2025.02.25.03.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 03:08:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9B0715FA6C;
 Tue, 25 Feb 2025 11:08:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 05/10] plugins/plugin.h: include queue.h
Date: Tue, 25 Feb 2025 11:08:39 +0000
Message-Id: <20250225110844.3296991-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225110844.3296991-1-alex.bennee@linaro.org>
References: <20250225110844.3296991-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Headers should bring in what they need so don't rely on getting
queue.h by side effects. This will help with clean-ups in the
following patches.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 plugins/plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/plugin.h b/plugins/plugin.h
index 30e2299a54..9ed20b5c41 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -13,6 +13,7 @@
 #define PLUGIN_H
 
 #include <gmodule.h>
+#include "qemu/queue.h"
 #include "qemu/qht.h"
 
 #define QEMU_PLUGIN_MIN_VERSION 2
-- 
2.39.5


