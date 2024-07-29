Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1CBC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 14:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYRc9-0004xF-Gc; Mon, 29 Jul 2024 10:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYRc6-0004jX-CP
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:38 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYRbv-0008Rv-SR
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:38 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-58ef19aa69dso4070789a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 07:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722264266; x=1722869066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PtcZqFWHrEGoL41FTohMyKEPDwyICpuVF7RbypBJq3A=;
 b=QaqrMGb3A82eoqzpBYuFVqSJk45CFX48XCphzCvrgkunueHPd8enJpsmB7y42XNQlS
 4vlVI+Jriv+km8WjMnGRe6QplxQi+IXu+xprRyqP306rCAg5f3ETM2NG1aCcD/ZrDSGz
 PbS6cPCiWyDfmksMcGbgBHrWRICKoQIOYw7RadoCx2n7VfjVuQMBkRW9eeULv2/nVq3Z
 ajofHPPRUog/LgeEvlHHj+HjVzgno7S47xVqca7tm5E69tGtYSYLp49KAiKspEUOkb1t
 N+3ePgiyzgUjhjSRx/p7WUfsxryNNl6KxSi1chrV8LH86PKW6Vw16SpZVjd6Cr9PqLur
 +Z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722264266; x=1722869066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PtcZqFWHrEGoL41FTohMyKEPDwyICpuVF7RbypBJq3A=;
 b=K28xaAZM7F9yFstPNPBEuFipXKaKXWJ9S6fq2iPZk0gOrO/kJVQN9e107XapkvGfwa
 z95+FzKqWhTTpcxw2gT0AVUtijafFeewPzMqPANmKwToA0bjONIZ6fqjll/2ijsMa7nn
 nulWoiaMaD+tJW9A1Li3Ly0Kodupf3+MLvyQ2Ixx+qPHiQi+bUmWflZxYBKPxRcy3oiA
 mSFMKCMBrEAOH19lsn2F4254HLWUYCFG8+JUrFuh3XMa6fuNGAZjuULm9QLO/gOqtKRq
 +6KWaiKvleV3sWxOicR2Os4lgYTReLZ3/6CxCM3BrljkL8kIzDxu8s5aL123W3eoDvNh
 guGw==
X-Gm-Message-State: AOJu0YwtMxVzEp74x5wCu47voALFMGCP3J7VVqRwXK7wcOs3yG58lyfB
 rKZXHOKvLEBdhoT76P3eTCFI5O5PogN/kF0on2C9GLS3Pzq483Qhl1bJoGGZHPA=
X-Google-Smtp-Source: AGHT+IEfRp6u/PEriMXjt4MOemKUcELeyZUUP1+B68QPt6BYX7+H57vsJn7bbn9HRz217tQp4Q2OCA==
X-Received: by 2002:a05:6402:35d6:b0:5a2:2fa5:f146 with SMTP id
 4fb4d7f45d1cf-5b021f0dcfbmr5499561a12.28.1722264266053; 
 Mon, 29 Jul 2024 07:44:26 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac6359392bsm5837519a12.33.2024.07.29.07.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 07:44:21 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 740E55FA14;
 Mon, 29 Jul 2024 15:44:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Song Gao <gaosong@loongson.cn>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 14/14] plugin/loader: handle basic help query
Date: Mon, 29 Jul 2024 15:44:14 +0100
Message-Id: <20240729144414.830369-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240729144414.830369-1-alex.bennee@linaro.org>
References: <20240729144414.830369-1-alex.bennee@linaro.org>
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

As the list of options isn't fixed we do all the parsing by hand.
Without any named arguments we automatically fill the "file" option
with the value give so check if it is requesting help and dump some
basic usage text.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 plugins/loader.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

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


