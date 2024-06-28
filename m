Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE479C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 12:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNAx8-0005JU-DT; Fri, 28 Jun 2024 08:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwa-0004qb-0k
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:13 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwX-0005i0-Cf
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:10 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57cc1c00ba6so804009a12.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 05:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719578587; x=1720183387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3DQ61RwLoSVOVHG6QMt3R+zEIysd/qF4AyFLX7PuacQ=;
 b=JOJ3zBO9t2biOzQayGUbVnjUF+veRAHqJ8NYy5Yh64rB4MKzXV3wyly5bNMx508sVp
 RcUzjbPrE47ledquJk+BowuEeSRBtWs2FJg/XYmg8/oSFmyGT30RrvkYo+1PaE/OgXC0
 zoDnJ8h+YTjcBhjDFbqYxVlVHp5o+WfU5dbG0Yx5SxZlEw03YADYpIi21y53ntNgcZCP
 3iGr30T9NkDY+G/QjrbQb9ivJXfZFNIFESurlxasMp8zoFPDEw98wRAGKLKSX/0jpe2V
 FBZne0EDR6S2EF703izzCO7o1d2vYoAyf/MErTNMpHqFhE1u2J7JULwV9zgPihiUqqcy
 xTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719578587; x=1720183387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3DQ61RwLoSVOVHG6QMt3R+zEIysd/qF4AyFLX7PuacQ=;
 b=j6DPS38J0QA5gJzVLNU7qCPf0+CVV84hpr0eY/cKZYj7hyoocDzj0gdNkm748vpJwb
 3CPyFkz6sdbT1hLhGca5Esg5D6QOtB4X7EdbN7UqQbCuaTPnGkFFEIpTi+KnvNP8gfwN
 mGO3qiw6GGdav9H3sn2uiBiz92UWGrRtiE9slDzhkzs1lDHmpcAXu4p3Dke7DE0Qf9hk
 V+QG8fOlAAs61j5YKt5V9ip4ZVZwnvlsmDkv4SZ34EjgRA6c2EE1/LXSzA6JXSp3QzGc
 kFM40LeM7yTTwG7tjkrbK0SJsGf809fm5U9PbFHkhBtzPwE5orwJAN8rAHBMTtE8f5jL
 ZNOQ==
X-Gm-Message-State: AOJu0Yw65POfzee4V4R4QltEFJx6DTxx896102NfDTnobyN2+2j69FUB
 MFEJxWGEfcT3eDO9GGS/kRXueaPq4ULsWLyByarGFjDmE+3J20DeVM4RzhDSUdQ=
X-Google-Smtp-Source: AGHT+IE/8csk/xO/MRYnaLNzQmnsiJuX+9poWWVIPomu9QcaVkLrD85zr0uNiuFfwH3O2tH660bY8Q==
X-Received: by 2002:a17:907:268e:b0:a72:ae79:8350 with SMTP id
 a640c23a62f3a-a72ae798498mr127887066b.29.1719578586413; 
 Fri, 28 Jun 2024 05:43:06 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf6295csm76398266b.72.2024.06.28.05.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 05:43:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E64D55FA37;
 Fri, 28 Jun 2024 13:42:59 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 10/23] plugins/lockstep: make mixed-mode safe
Date: Fri, 28 Jun 2024 13:42:45 +0100
Message-Id: <20240628124258.832466-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628124258.832466-1-alex.bennee@linaro.org>
References: <20240628124258.832466-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The ExecState is shared across the socket and if we want to compare
say 64 bit and 32 bit binaries we need the two to use the same sizes
for things.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/lockstep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index 111ec3fa27..761bcdf363 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -57,7 +57,7 @@ typedef struct {
 /* The execution state we compare */
 typedef struct {
     uint64_t pc;
-    unsigned long insn_count;
+    uint64_t insn_count;
 } ExecState;
 
 typedef struct {
@@ -148,7 +148,7 @@ static void report_divergance(ExecState *us, ExecState *them)
 
         g_string_printf(out,
                         "Δ insn_count @ 0x%016" PRIx64
-                        " (%ld) vs 0x%016" PRIx64 " (%ld)\n",
+                        " (%"PRId64") vs 0x%016" PRIx64 " (%"PRId64")\n",
                         us->pc, us->insn_count, them->pc, them->insn_count);
 
         for (entry = log, i = 0;
-- 
2.39.2


