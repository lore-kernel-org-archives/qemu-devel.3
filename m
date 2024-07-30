Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A4AC3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpck-0000LE-1n; Tue, 30 Jul 2024 12:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpch-0000AA-Qd
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:51 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpcg-0003ZC-CI
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:51 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5a156557026so6753240a12.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722356569; x=1722961369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1FnPcjctlWpwnIFsnPkrtWmDcvPIDAiyzZ72o/WD8fs=;
 b=W76MdMTSXRdneTXg1r7k6NtNSY9DUWHznBcqWk6UHJq8fAOyRUBiJT4gK1Y27mMldS
 EUiVYHflfCbahxRkgeZIsTffbWTXYpIw/+VlhfexQV6AWDxfn0M/3B3iOYKkqMW2niSy
 lzDSJnJnPrWbJ8NKGYlOdKq9mpxdAa37CTmdtm3Hy4zgTeYKWK1Tr04OqIhauMJ/iulu
 ghFGU0MZRZeuKN6nEyPqGpsMityQIQrZKFEShggWQ5jzz5p1Sx1AoIbu8QUlyTsA6IRo
 XThb8ZW0lX2BD75hSHUhZ//SACYCjcpliNuf55nk3Miro6jT6x/reab4hy7NcnRP6qwv
 ORsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722356569; x=1722961369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1FnPcjctlWpwnIFsnPkrtWmDcvPIDAiyzZ72o/WD8fs=;
 b=SNjd7ajCzYuQttLkKtnXHNorKBMhTTUeP6rH4c+wWVXaz+iC3YIU2l85+hrE7KD02y
 QwT0/0WfSnFLeoBCx4ZdyDqjoBCiHpi+Nn8aUXMANBZtC2NFSvBVDmaUm6Q2xBQuHUE/
 xEQyzk6Mpy8vA26doG7ylyjxQtRZkMCd7a7yErpOZwqxAD69KFiwaUYzfy4s4WJ4RloN
 ZjDuV1nAwk9MLLgI4FmaMtKq2tlGjrJJGeYpohjGh2FuRc5mbXg0HHcjzIRxxae0Arut
 zJByaSrWTpYVTSuFPR0AIa2XYMyDzp0w0edtV+fu5SHXYS3FiHsMc6Wtf1mQYwEiWPIZ
 xQ/g==
X-Gm-Message-State: AOJu0YxV+t8eprhkQUs25rF55ft/96rGmqq4jSp9JwBlO4yrE33wLAYi
 sZer1jxmuf2o47P8SeJFPH4ERMpBBq35IfsIyfrZt0U8yJ+Ic8i+BlKFzGSJde0=
X-Google-Smtp-Source: AGHT+IH3I7QWyyBvNjPOHMrKkS5mMCFLYcBitutESaCpFmW4NMr9cAmo5fMt/d75VXTSQitBwHK8Fg==
X-Received: by 2002:a17:907:3da8:b0:a7a:a892:8e05 with SMTP id
 a640c23a62f3a-a7d3ff9e775mr994858566b.33.1722356568591; 
 Tue, 30 Jul 2024 09:22:48 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab4de06sm660840666b.71.2024.07.30.09.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:22:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2FE925FA11;
 Tue, 30 Jul 2024 17:22:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 14/14] plugin/loader: handle basic help query
Date: Tue, 30 Jul 2024 17:22:37 +0100
Message-Id: <20240730162237.1425515-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730162237.1425515-1-alex.bennee@linaro.org>
References: <20240730162237.1425515-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

As the list of options isn't fixed we do all the parsing by hand.
Without any named arguments we automatically fill the "file" option
with the value give so check if it is requesting help and dump some
basic usage text.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240729144414.830369-15-alex.bennee@linaro.org>

diff --git a/plugins/loader.c b/plugins/loader.c
index 513a429c57..ebc01da9c6 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
+#include "qemu/help_option.h"
 #include "qapi/error.h"
 #include "qemu/lockable.h"
 #include "qemu/option.h"
@@ -98,7 +99,12 @@ static int plugin_add(void *opaque, const char *name, const char *value,
     bool is_on;
     char *fullarg;
 
-    if (strcmp(name, "file") == 0) {
+    if (is_help_option(value)) {
+        printf("Plugin options\n");
+        printf("  file=<path/to/plugin.so>\n");
+        printf("  plugin specific arguments\n");
+        exit(0);
+    } else if (strcmp(name, "file") == 0) {
         if (strcmp(value, "") == 0) {
             error_setg(errp, "requires a non-empty argument");
             return 1;
-- 
2.39.2


