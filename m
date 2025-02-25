Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33E5C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 11:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmsoS-0001ei-Tj; Tue, 25 Feb 2025 06:09:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmsnz-0001Xj-5t
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:08:54 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmsnw-0007kS-39
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:08:50 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so35821315e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 03:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740481726; x=1741086526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A0C07sYpNo4u7rDsFsSfzCKqSXgRvbHOGJATtnHgpac=;
 b=x9/V855wRzTevpCVybfEKd0VHp/zVyPA6lZlPD5nAC1m8Bc8Ow/d84o0y6wuYLX3OS
 vAaHn25OR/Pqj0CamWwAbh7WEmz5hoyPJtBgKrZKA9GzuRbMrSmXVsaM/hzoYuxJVkTJ
 aJANXQTlhSBy9X+NDM+CxU9UISY+vBvKBDAj3ZgVm4aCqYDYAOo2pC5RTv6Qh8ioFC4k
 qxcMS0zEbgukYR0a7RNwa+xES7QXZWNdd1XMNHRe/8s0oOMoW1T9CxGijFS0l9/UKKza
 01ZJPoCOLbZbbJEPkjU6zhABzdT2AYpb6krnYpvve5arKt0EKVNa0QvqyoFlVYRqx1Hq
 UDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740481726; x=1741086526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A0C07sYpNo4u7rDsFsSfzCKqSXgRvbHOGJATtnHgpac=;
 b=IbWft3SR/hgipQ8U3S64LEU8nQ6GvMbg2kHQDDMlA6MGCk+EoSfI6lShuuBhryseFa
 vd4h8XWgVvFP27MA4Pc1BKbz3J/cBl2vojHy+bj4pH82eE8W4Q++S2D5j6Tax+Ik0LXp
 W+WqnWeefSJehYaPI3M01je5IFPoywVApDKP63axEf/CYHncI3rujWQpwbCeMGUgCjvk
 P0Y3ZxY3m7bLuf1ybybbp5LyR5tDG08AyhW6qEhVz93j9HkIrxwqMcrB+PD8FADAcGbi
 CVNSsSsAHLbmq9Pp9wBRB68Eq31EavFiZFGP2bgA3S2+o7HVzhj8SScU0yaoB+XCpqVM
 MsEA==
X-Gm-Message-State: AOJu0YyDyJCvaZHmJyE7+lBeu4huK0amO/BlJ2J9eUxZnKAT4yNBInaQ
 G3LZfBbAVp0Tr5fafqyRLsF+kDnXL1NJnKyR/m17kpu6XA/Acfm7QLmAS9gUzKQ=
X-Gm-Gg: ASbGncvDSdssdEcWscDjFG2/FCWxNNmDs80UZvz1J5EcoR7ADue06rq0qwfXG2jupBY
 J29JFodnkcsIj05aDUBwpPEQLktr4GKJ5sFvWHuF7fD1hIqFkmtm6h6CxfgC5Vx0nR3jU87c3OS
 XdakG9758fR4LynYiMnqdeZ8pKoPQCC29+VBYRzHKkBYw/l3+8nDu/pupXMhqmH9joqmz+H6fRt
 oQI4diwg3oqNGVYwteSX6vdiIgtW0YTYN50wDZnejGfJdx3GhRiiX4P4gueeuVTcOjw+xgFkEIG
 es9UUXt+0ZurHutOng60mC31oUmN
X-Google-Smtp-Source: AGHT+IEp/YkWTDiYfwzWIF6eGeuCJ3KVxlWw+YREg7vHyC0o0au8uWN9LAnONCah0tHmvDHgIhfaBw==
X-Received: by 2002:a05:600c:5106:b0:439:a25a:1686 with SMTP id
 5b1f17b1804b1-439aebda0bbmr120429185e9.25.1740481726320; 
 Tue, 25 Feb 2025 03:08:46 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02d60c0sm135556145e9.12.2025.02.25.03.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 03:08:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6B7FE5F9D7;
 Tue, 25 Feb 2025 11:08:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 03/10] include/qemu: plugin-memory.h doesn't need cpu-defs.h
Date: Tue, 25 Feb 2025 11:08:37 +0000
Message-Id: <20250225110844.3296991-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225110844.3296991-1-alex.bennee@linaro.org>
References: <20250225110844.3296991-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

hwaddr is a fixed size on all builds.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/plugin-memory.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/qemu/plugin-memory.h b/include/qemu/plugin-memory.h
index 71c1123308..6065ec7aaf 100644
--- a/include/qemu/plugin-memory.h
+++ b/include/qemu/plugin-memory.h
@@ -9,7 +9,6 @@
 #ifndef PLUGIN_MEMORY_H
 #define PLUGIN_MEMORY_H
 
-#include "exec/cpu-defs.h"
 #include "exec/hwaddr.h"
 
 struct qemu_plugin_hwaddr {
-- 
2.39.5


