Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B421C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 21:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyuu-00022H-VO; Mon, 20 Jan 2025 16:02:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tZyuY-0001bJ-3T
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:02:19 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tZyuW-0002w7-Dr
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:02:17 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aaf0f1adef8so951730366b.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 13:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737406934; x=1738011734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+48eX+l7U8ZWofmz36TBzUOPc9ZUOZwyExE6gyBI1a0=;
 b=oMAXsNttBz86KeIZqg4mdPZTxKBCULiJAzjqtR92Gsro2nqC8PKb0gu+oGeemwdsYa
 6+RkeuZwxDnrj/re5umy3t24Grq4mV3+4YqVWJLom5WjutXmOppNMu1eQdEBsx7j4Qwr
 NzYmycvMoPSIHVpIUr8CZ8EX52kN3QLQGssv6B1NV3qEqnb1xj6DqvEJnXAbs+aZwAyO
 +9WCvfD3IHjtec6vToAIRQQQ9CqwXg2dnrBcTSnGDi9Ygpv7Rjxlf9EmkFtftDQp6qh5
 lfJxE2qpYhHAceMc5o9Bvby36eBGrGMkdm+t8UcuBeFlEdsp+i8nuVmowAQapw/xGCqI
 qGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737406934; x=1738011734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+48eX+l7U8ZWofmz36TBzUOPc9ZUOZwyExE6gyBI1a0=;
 b=sNkngisJeeM4E9ZTJm8RqI7/CNgdhqzhZTZOJIF1RZ1dKp0KtRF3g8NTnL7tDzYGCp
 MeOyWhDDGJNfp5pPciJJiZomXgkBE9860Om6eTKfiU/qw0fiI/stDSde9VQe5xCveKnG
 n6qnakpiYHHxznHzg5YRIqgmNp/59sAnGVWYnSmHzHJPRRXT+GEZihLtXQub1vJsk6TW
 EpFkEaEt9BH2bM9IR3DkM8wbEyQs2VlY/AT3tcRnLn1ADVzQFanXTPQd39eIovepWCNl
 JzfhpmUTO5QH1PIsIUInLdpvWPLcGZYzuijUunvS8ZAhMePHIVJtoneGbhc4HF147iLA
 Ug9g==
X-Gm-Message-State: AOJu0YxHIP5Cb2iIXfjnPA9f3NvHBAla6oc3qwPHCYa92Ri/hhE83Hvg
 P2kBIInXEHjSZWx0GdyUjT3QOxQ94hgThIpO0cV+uDtPr9yrCtwjQ//Cc/rNMTM=
X-Gm-Gg: ASbGncuAY7H3+pqJsgNnSAYHwOuD5KMPQDaWpWbah1g1VT1zwS+chWYvmNuL9zibBhJ
 7AMJfLZTkPHh2IInrIYRgoy8iL1FOxmMXdY9DdpydlRsz6RvROEUFndSNif1Jh2WMrYeX3NjKTg
 nifIFOpwnhgxp2NtMtVL6uTFJhl3g43mf0XLNUptYeI1tmyQKRey6o8PoiVXnaAxqJSMQkB9vj1
 Rj0cGlkkrUXXvldaz9HtmSCkrcGh4yd5Zpz421Hib+S+uG9X1jXjk45e858Gt0JyNRu
X-Google-Smtp-Source: AGHT+IETxmPf336ELEiXbW5XHVlzHnbDegLldjJi9NvriPfHvvRvL3Fw/A8nHshtkWoMZkw/+TdxMg==
X-Received: by 2002:a17:907:3e0b:b0:aa6:94c0:f753 with SMTP id
 a640c23a62f3a-ab38b17b9e0mr1068680966b.33.1737406934320; 
 Mon, 20 Jan 2025 13:02:14 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384c5c3e1sm660622466b.7.2025.01.20.13.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:02:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 246155F9DA;
 Mon, 20 Jan 2025 21:02:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/7] tests/qtest: don't step clock at start of npcm7xx
 periodic IRQ test
Date: Mon, 20 Jan 2025 21:02:08 +0000
Message-Id: <20250120210212.3890255-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250120210212.3890255-1-alex.bennee@linaro.org>
References: <20250120210212.3890255-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

Until there are timers enabled the semantics of clock_step_next() will
fail. Since d524441a36 (system/qtest: properly feedback results of
clock_[step|set]) we will signal a FAIL if time doesn't advance.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qtest/npcm7xx_timer-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/qtest/npcm7xx_timer-test.c b/tests/qtest/npcm7xx_timer-test.c
index 58f58c2f71..43711049ca 100644
--- a/tests/qtest/npcm7xx_timer-test.c
+++ b/tests/qtest/npcm7xx_timer-test.c
@@ -465,7 +465,6 @@ static void test_periodic_interrupt(gconstpointer test_data)
     int i;
 
     tim_reset(td);
-    clock_step_next();
 
     tim_write_ticr(td, count);
     tim_write_tcsr(td, CEN | IE | MODE_PERIODIC | PRESCALE(ps));
-- 
2.39.5


