Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF9AC3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPeVN-0000Ek-CV; Fri, 05 Jul 2024 04:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeV3-0008VZ-T2
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:01 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeUx-0003Bp-AT
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:01 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a77c080b521so140625866b.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720168853; x=1720773653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OZlcNQh9JE8A6UvoUX4jggiwG8ZzlIUOMNu3XJPgKMk=;
 b=tqhwIlZ6i0zbhhO9DTrUgJdHJ24GekigPUC6We5IxpZ4bBNz/gnf/VhZG1bee99Vgq
 ALijQtHZYIsSAcjczuz3OXtjduLtEpBt9J1ckcSSQMKANOJVUKYsPFGt/hyeu1SOCUEq
 aS5jw5oJd7X3ug3o1NgHaSSO/+1zMH/Llo5QjfyRodAyPvON8InqKt0qe5tKtKu2QwnK
 sUCI1WKak2fMfX5+SiK/RD7JR0DFgd+uJkX7XGKvprroy/ArIwVa23Swf2W7LcA3SJr/
 y++WuJEuNug0XP8rDWk+sp+Fg9a3FJzmiDm+IET9d/5WLSLh26j0njPZhVvL2tWHHZbu
 PIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720168853; x=1720773653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OZlcNQh9JE8A6UvoUX4jggiwG8ZzlIUOMNu3XJPgKMk=;
 b=aorJxnGcVfgYvBbICVExJwFSo7YzAd2CczDfWM7BHH5yvgxou03F/2up1rVdPtYCZl
 1NDmx1VmqPebDt7BCsBRkwAIVDQq46pHlLxZe0JbU5atwtaa+qG3IXc34ckkYwkKFC+x
 4DOfGlQ5iU/4FCmSg/bqXfAZBfxw041fe7UXsnqNZltIaNR/A5pDy1w/p3/QO4PeRdXo
 T+E1RzCzuCWN4pw9aCqOJ5jOpheda+6AplkDnJwA35jcxGjVeNbvJD8iNJSWY3RuPs/U
 zexjooSZYXG6tZjcHreI/FfdXNinCx42rL++ic0X/tbe07KId23vj0t4SgVdLKpnpomM
 AEmw==
X-Gm-Message-State: AOJu0YxER4GBSm0H2hBjljYxd4iy92qZXEkSdoX+aEJD4SENY9akCcD3
 P4Id75UZXtRJzpMrsRDTHpYMcOB/Guq//Apza9PX4swACvGR24B7dRqwkg7dIgk=
X-Google-Smtp-Source: AGHT+IGEca9c2y5QxybSWiyxK5SfQYCByhlUDq0Jc+hVCy5ZX/RyNpkogt7N/MWgjassv6y6y/fkSA==
X-Received: by 2002:a17:906:c1c4:b0:a77:d9d5:eb6d with SMTP id
 a640c23a62f3a-a77d9d5f2b4mr19526866b.61.1720168852782; 
 Fri, 05 Jul 2024 01:40:52 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77ae3f053esm156573066b.47.2024.07.05.01.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:40:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3E6D95F93A;
 Fri,  5 Jul 2024 09:40:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 06/40] tests/tcg/minilib: Constify digits in print_num
Date: Fri,  5 Jul 2024 09:40:13 +0100
Message-Id: <20240705084047.857176-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This avoids a memcpy to the stack when compiled with clang.
Since we don't enable optimization, nor provide memcpy,
this results in an undefined symbol error at link time.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240630190050.160642-2-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/minilib/printf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/minilib/printf.c b/tests/tcg/minilib/printf.c
index 10472b4f58..fb0189c2bb 100644
--- a/tests/tcg/minilib/printf.c
+++ b/tests/tcg/minilib/printf.c
@@ -27,7 +27,7 @@ static void print_str(char *s)
 
 static void print_num(unsigned long long value, int base)
 {
-    char digits[] = "0123456789abcdef";
+    static const char digits[] = "0123456789abcdef";
     char buf[32];
     int i = sizeof(buf) - 2, j;
 
-- 
2.39.2


