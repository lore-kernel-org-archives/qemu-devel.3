Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2F8C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 13:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubIqP-0008JU-6c; Mon, 14 Jul 2025 09:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubHtT-0007AF-Oj
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:02:53 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubHtM-0003rz-80
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:02:51 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6088d856c6eso7909881a12.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 05:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752494560; x=1753099360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BiRpZlbPIOoFEj6iYHlDTcy2zJQpuVJMb5R6Mh4QsuA=;
 b=bI/DJ+3Q/T1Mkm25lHY35VWamh4iI+Ms3BAvO8yZpfdbIk13qcPZ9jZlWMB62wsoNq
 LU8aVtp+ZBoN/XWj0/uxxK204Sv2NfQBOLmn1pVDsvlYG9pktmE5FLIEcOCCeVBD81c7
 wJBDTk4JaewhzGed1OK4KFMwOQO8AS+Gr6TmffrFd6L45EiZ0tFuwXUrkYmcZMrzNdPb
 +fgtFLuAfn80IFTnrYV///Uab4NmG1o9op8lxvS0LWqfNgjI18M97dorwl5vthoCMfJE
 BBwhybarT0vrQu8opSoO0R2Hpa4VXFsErE58i4tmeeCBqg/1BLQekJGxZfNRpXbiVWEY
 zUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752494560; x=1753099360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BiRpZlbPIOoFEj6iYHlDTcy2zJQpuVJMb5R6Mh4QsuA=;
 b=d+vZCUXnzu5AwRraqpuwbJ3l+rXb1JGD+K9EZtMQx6u6YKr6JPabtskxtnMaT1Fyqk
 KZZ34UUWpcLxa0yfZnAj9QcdtjZ9WfJaT1XIEqhho6jZ34snc/lyzelw3kYS96m13iNV
 N1MZJzRbqEC0DPWR327LDcOf3wR8PVJ/1GJtPfcgPpvG5pBd4rLgmwZhPPtfnlHiqBMV
 xbHxdq+hG8kLJCmuUuInNRk86uOeeiscHWDjqL3uUF2kO52ffTfcOSYLcjON5alBpSCK
 h7UU5e64Jc4pz4V6qN7bAe1jk7oN4qV67Kvr4uQHm2VVAPrvKlw20E6oLV0R60PgCtmR
 b+BA==
X-Gm-Message-State: AOJu0YyC1UYy1EWZOnpfj5YnlYJtzbftuMGvwoOGJ5ZPaTwEuHOmt51C
 NDqK7niwUF6TI4LHL4MhZBQKp/2DhTXD3OBjSdTqwBntp/AEpIZP33Of2dGLPX28LmmkmueKo39
 gLwnXlnE=
X-Gm-Gg: ASbGncvVpu4j8bWR1HYpgLgYHF417G3gtWp2WKSIEJbhw6N6pvJ+9U0ko2O7/DWu1vv
 MWpaLxA4atEljbLonSyUFLaKe42Ln05QonoKNKnktijb3SIBLrqkXx1l8Xmultygj8HGT6348oq
 OGq8SKheZdnK0ckPXfUnz6n0+S7PwyR9gdhcmaU9Q8KQHaD5xVkE6YY3nH51V9XPbxJJb9WgQl5
 Y6BhhoTbqZSPx5GXkA/LPXlA60jbefTkbIqsWlrpSEKBOyQ4A+Yk32P+kFKYJP2fd8RfDJwlMHb
 30YLCg4ZLLa+l8CL4VNf0MitmXIkGceFAcmF89XNCwWu3Et46wErUrNQZ9MyIsRlAF8I0ltXsJ+
 J1YER1ZB0pvDlAZogaojeUMk=
X-Google-Smtp-Source: AGHT+IGK/sG2ZiphqscgNya2lAFzsfFtfraCLdcqgYqXGnm4qrQbv3ArBGB/KEENND9VqorKPcamnw==
X-Received: by 2002:a17:907:9715:b0:ae3:b654:165b with SMTP id
 a640c23a62f3a-ae70117eb3cmr1149381166b.24.1752494560130; 
 Mon, 14 Jul 2025 05:02:40 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e7c09dfdsm808837366b.0.2025.07.14.05.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 05:02:39 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 329E75F8BD;
 Mon, 14 Jul 2025 13:02:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 5/8] plugins: fix inclusion of user-mode APIs
Date: Mon, 14 Jul 2025 13:02:31 +0100
Message-ID: <20250714120234.1524401-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250714120234.1524401-1-alex.bennee@linaro.org>
References: <20250714120234.1524401-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

In 903e870f24 (plugins/api: split out binary path/start/end/entry
code) we didn't actually enable the building of the new plugin helper.
However this was missed because only contrib plugins like drcov
actually used the helpers.

With that fixed we discover we also need some more includes to be able
to extract the relevant data from TaskState.

Fixes: 903e870f24 (plugins/api: split out binary path/start/end/entry code)
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3014
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250710104531.3099313-6-alex.bennee@linaro.org>

diff --git a/linux-user/plugin-api.c b/linux-user/plugin-api.c
index 66755df526..8d6fbb60e0 100644
--- a/linux-user/plugin-api.c
+++ b/linux-user/plugin-api.c
@@ -12,4 +12,5 @@
 
 #include "qemu/osdep.h"
 #include "qemu.h"
+#include "loader.h"
 #include "common-user/plugin-api.c.inc"
diff --git a/common-user/plugin-api.c.inc b/common-user/plugin-api.c.inc
index 5b8a1396b6..63f3983271 100644
--- a/common-user/plugin-api.c.inc
+++ b/common-user/plugin-api.c.inc
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qemu/plugin.h"
+#include "accel/tcg/vcpu-state.h"
 #include "qemu.h"
 
 /*
diff --git a/linux-user/meson.build b/linux-user/meson.build
index f47a213ca3..efca843369 100644
--- a/linux-user/meson.build
+++ b/linux-user/meson.build
@@ -27,7 +27,10 @@ linux_user_ss.add(libdw)
 linux_user_ss.add(when: 'TARGET_HAS_BFLT', if_true: files('flatload.c'))
 linux_user_ss.add(when: 'TARGET_I386', if_true: files('vm86.c'))
 linux_user_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING', if_true: files('semihost.c'))
-linux_user_ss.add(when: 'CONFIG_TCG_PLUGINS', if_true: files('plugin-api.c'))
+
+if get_option('plugins')
+  linux_user_ss.add(files('plugin-api.c'))
+endif
 
 syscall_nr_generators = {}
 
-- 
2.47.2


