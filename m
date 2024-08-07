Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070EAC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 11:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbf2Y-00064E-5J; Wed, 07 Aug 2024 07:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbf2V-00061q-2V
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 07:41:11 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbf2P-0003Ae-Pq
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 07:41:10 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a7a843bef98so187610166b.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 04:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723030864; x=1723635664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOKODoxVh76RIA5fIE8MFN9yKYyVPsEMcCL2+a1GCQw=;
 b=J3FdjDolgP+oAiBhPmoxHhO2EXfwSZ3WrXzn+8YjIZnX85yAFLnzOFKQoNDDWkMwTQ
 8dIJrIyd0Qf0EC3UlZgNldeESHLtdMSqwQQ2a0ncIxu2FW4Bqv6FYSCo8Y/NpJTPCjwG
 tipZEq8A3QvP9/bAOYGN90PFsb5lCCgtltou6rTQpvwhPbnAdBmYCwqAzvtR4+DKEb7d
 RCda6ddrey97ubbZ9WYwXueHVqim2kh7VDLUceOJsKtpXoBsHt/tny4uOd+PnfV5c0eV
 SUBhtu5BvbGRRlvKTDxY22iNTJKOrKfe+JMd9Nhwgi+eZA3cDUzKvSJlVhBV1BGCvF1A
 xEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723030864; x=1723635664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OOKODoxVh76RIA5fIE8MFN9yKYyVPsEMcCL2+a1GCQw=;
 b=aY2QHC8ci4QMUbHvy70MIeREyYUq/NrcmyeEFKGS+4Z4IXgrMRWXBywaLWkyKYweuP
 B3KbkPzDIKjNEH6df9L6gsq5wtztP7DRhcxIhGZ4vBWHvChMU05sYJs17g2cNnYepZh5
 d48dVc19Rjx9DF/fFVUaaDcm3YuxaXmg4ICu3UYjREVYTtgIFaQWQ8N8LTsY7ueHScbQ
 YSt6JPxBd0U473V8cFNaQ0UPkueGVRg7I5NY/8iVqxCi4dcr+IonsH+dwqkxv/r+Txqu
 lC4zbx1THicXGWyvD2cM5cT23cezitUEVbSTOmMVjKEtlP33kpQMSSZuckQZYoa/XTpg
 Dwsw==
X-Gm-Message-State: AOJu0Yz6G3h382NNZ6fnhX0pTK0Zueuw75096bn62fK5rO1FsdwCDMnI
 XGSlAKRNah5oRESjBnU0QPTTWwMjrybRA/QaKTqJbFGIzcFh3L3Y1qFXodnaUhs=
X-Google-Smtp-Source: AGHT+IFDR13CAqTrwOEYRvQNizP3bFNizsBPdRjCyziBwQ4ym2FSlWWYsNdQ8xaghAOY6/eGcjUoYw==
X-Received: by 2002:a17:907:6e9f:b0:a77:d441:c6f1 with SMTP id
 a640c23a62f3a-a7dc4e6cc2dmr1366667666b.33.1723030863477; 
 Wed, 07 Aug 2024 04:41:03 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8067efcf0fsm144174566b.145.2024.08.07.04.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 04:41:01 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 172525F92A;
 Wed,  7 Aug 2024 12:41:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 2/6] Makefile: trigger re-configure on updated pythondeps
Date: Wed,  7 Aug 2024 12:40:55 +0100
Message-Id: <20240807114059.2339021-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240807114059.2339021-1-alex.bennee@linaro.org>
References: <20240807114059.2339021-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

If we add additional deps for meson we need to ensure we trigger a
reconfigure to make sure everything is set up.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240731140232.22193-1-alex.bennee@linaro.org>

---
v2
  - split line with continuation
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 02a257584b..917c9a34d1 100644
--- a/Makefile
+++ b/Makefile
@@ -78,7 +78,8 @@ x := $(shell rm -rf meson-private meson-info meson-logs)
 endif
 
 # 1. ensure config-host.mak is up-to-date
-config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/scripts/meson-buildoptions.sh $(SRC_PATH)/VERSION
+config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/scripts/meson-buildoptions.sh \
+		$(SRC_PATH)/pythondeps.toml $(SRC_PATH)/VERSION
 	@echo config-host.mak is out-of-date, running configure
 	@if test -f meson-private/coredata.dat; then \
 	  ./config.status --skip-meson; \
-- 
2.39.2


