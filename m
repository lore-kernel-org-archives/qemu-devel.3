Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7359DC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkkH-0002Rq-9j; Sun, 27 Sep 2026 05:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkk7-0002PR-09
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:19 -0400
Received: from mail-pj2-x0c.google.com ([2607:f8b0:4864:39::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkk5-0007O5-Bm
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:18 -0400
Received: by mail-pj2-x0c.google.com with SMTP id
 98e67ed59e1d1-3a0eeda3e03so309230a91.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499616; x=1791104416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+yjjV+A7iYyzKjGgR+UNc4f/t+ifl8d6M9mByR9w2bU=;
 b=gNq5YHMKYxoUVkXzci+Wlz89vYAktiwM1SBpSjyL9r+mnd3LfKQ6Ae25e/jdFZPKcW
 VfBLW0MO+zH6SKQMQqrOnYM9qoa2R7+1rSQAEMzHtvtg/WV5iqnkqZDUaxYqtguuJJ7T
 SEf1XtwdgHgB20QBxGwVqcJ/6nsuptc9Bf2wCG6mhA2vzrRnULIspxw+chKPFGkHFZwf
 xXfhTuVldpDtljYYJrFcrszwCDne6YKIP16xyKXB/EodnmV970ppzG3egRTuUpz/+FQE
 se8sa+Oly4pozjxV2RxWobD04bPpMepd0ruz/AnUyCJjaP+SIOo2twsma8NMvYPROYrx
 bCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499616; x=1791104416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+yjjV+A7iYyzKjGgR+UNc4f/t+ifl8d6M9mByR9w2bU=;
 b=XItDvQ59WEeBsq9gJGjrsPClegfdGPTAohEAGljRodiW/Q69amfQ9KX1ygSQum2a3a
 FJWySa94BQ+BD+uKvbz50O35HayZXoo9wI5+AZEZ5hgOWmbVOZsMMid1MsHa6PoI8dJT
 bUfpdn2xwF+K2UlUQhW+wgee56t46JqkcyFl3SJnWyTg6m1e5sTbxoLv9s4S3j+QdEuH
 YCS6QlFrpL/09x3mbkQ9e8VK/W0UD1VW6wK/FxQ3eL/9qK6iOPc8eSiYtAsKMznIy8vx
 OFILAQRD+/RYwQ2Z9lQPucm/EHaw+vAL4Q+fRJqKe40N7YjEeFBpCkJbUntBcfbYg0Jg
 pcTg==
X-Gm-Message-State: AFq9FYLxbMpziVXeECpEAbe14fRQqhjW1X3XjRH5XLQYQ9AmK1Feip6q
 Yp7kwczv/vWt/tiR6MqRjVkkUJGKjag6ICutqJdJFttHws5KZfvKeKDiggjv+1aDcpgZXVN5YZL
 +XS4U
X-Gm-Gg: AYBFou1N56U3ULaP5IbrjAmpxMlKk4eM5//h3q3DR6gVyFakTgMffxqGHpUNxSEc9BK
 Yp7gt0Kk3xz+txjvJCAAvtzpxe6vrzy5CU0zZ/J8/XdKx9Xj0UrB3silvjzamdW41agzUyQE84I
 zJUZ07iOWp/FsdVzfcX5SiVcAmvte3jcU3DEOG5BCuHJbqp6n1MQ3gLxx+b+RW3rH5JWrcHUbc/
 3ndajxVbLfP3bSGY9RwwZZDJDNgZ0So6DohM0ZoQLRaZ9WZxuqJ/URTJuU3c2pvAKAjJT8Mmb2p
 G/jEvwXX5jAwiI0L7NGtD3JzQXsejqFbdDq29AMPyuiocU1s1v4b9xeLkyZUDL6GrL7XcX9XzwT
 Lf1mUyG/C9r3qKQr2Z2+yjn8mWoCxfdN6OmJptEcnYl6AzNlPDugsHgcQyFNTqkBkDw/SDabtcp
 Y1QF+ODXRteNt08sfhfVb4e1p5zzxwmE3mK7OfOGTzf08BufxivbJmQkYFWVyhoD02OV3zSb2TQ
 fsSn/f2MFxD4Cp3GmSa3bwM9tq/mQs=
X-Received: by 2002:a17:90b:28c6:b0:3a0:e25f:83c7 with SMTP id
 98e67ed59e1d1-3a0e25f8455mr1956102a91.41.1790499615606; 
 Sun, 27 Sep 2026 02:00:15 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 002/101] include/qemu/compiler: Define QEMU_ALIAS
Date: Sun, 27 Sep 2026 01:58:32 -0700
Message-ID: <20260927090011.10724-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/compiler.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 3661dc5fbaa..8fa4552ef8f 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -230,6 +230,13 @@
 # define QEMU_UNINITIALIZED
 #endif
 
+/*
+ * Alias the current function definition to another.
+ */
+
+#define QEMU_ALIAS(N) \
+    __attribute__((alias(stringify(glue(__USER_LABEL_PREFIX__, N)))))
+
 /*
  * http://clang.llvm.org/docs/ThreadSafetyAnalysis.html
  *
-- 
2.53.0


