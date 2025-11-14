Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741EDCEACC9
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 20:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK07r-0005SF-9y; Fri, 14 Nov 2025 15:10:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK03F-0007dn-Ew
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:05:46 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK03D-00053m-Cg
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:05:45 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4710a1f9e4cso17436965e9.0
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 12:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763150741; x=1763755541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+enfdV4r2hJtBFLjqs3VDHGFKcX6EfroLeDHFeq+E4=;
 b=VHqtH0LKpXOAPU9y49oI9WhwrR7wW5B3XNgt5vJ4hf87sTOrqfwWLKGrXLrOAqRuTe
 HeOLt9McLKBLb41o1erYuMISVo8AK6DTmxhIxym6H9z4z8eqvjhxlidMqs8wGeokbV5h
 RcgawP6mOQsqA9TQWcYQlGl9IEYJ2S0KCuUCr/6NwNB33agMEWTl4oYRrzuiGK4DFVKX
 iLFbLKOxqm9Rn2Pt1E15TVy0oOPcczmG5H4VuUyPheyo16HbJ9SBHlycsaW1jgFPWO9o
 fdEk7YZubOnOEIvMcYP7OpgbQIAgZJNns+WtHxfQQqvksgxWSGByor/rnTW95dlIlp+1
 Wvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763150741; x=1763755541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G+enfdV4r2hJtBFLjqs3VDHGFKcX6EfroLeDHFeq+E4=;
 b=DlxGQPicvv1UYVqxZHKbPK7BjPDiLpZpXKdF7BfC9KiXC3uGzuy6X/SdJyb1pdUk2F
 BWuaPjo5f6hRObJwz9CZs7OIKebB42OFcZInHEGR7PfvYqCeng+qH+8AYn7wL8NGQNl2
 FzMMawOznoJP6wX6J9Fg0tVDdrI6zYXk4viY0wFMHI2wYcCaK2/IBXNxaalI4GsU8RR7
 QeTe4aLKHBarAYkXCKiBaKMN5x6WFTYCnumegX3P9C80GpVhtvgcQBMLHG65XrswFJag
 60qjIGkGKx0c0O2OKDMsnv3k+onh80If0SUZagqEdAiEY1t2e+dVTc5UmLErCZWv8uRI
 X+7g==
X-Gm-Message-State: AOJu0YyRf2Ndn8SQJtBTn2ccQwJO2lTvAAuH3Qas35jIYcDUKhhwRJRT
 JAgA8XbEda8IVuC1LNkuS1UVKKvHLbfNzfzc6684/JkCpam+DxQgseyjHDaF3tGVDHId1eRmfjs
 X9V0APN80NA==
X-Gm-Gg: ASbGncsolfD0ds7mSZakC9isBjJg/JzuQhOJNItOnJHxiU6H3jbUy2LYFDAYrzIhmHQ
 oxYnLg0mQJd4IMkwLqKfagah0d7f/f6js1t9VWpMOPNQqfG3QXSw/3iZBX4JR96dP/dbJ3E1ui/
 ywdAzur9a6M8s9bgCkm4+I6Rj3kt8H4Pg/fWK6p5dFRVYH/5UUrlYIRAldPWRUPc0QZ4VweKxFJ
 oofgX+IymfmNJoYOAiQE5eTeJAEpmyaENQPfGaTzEmWbPLz5O2xiIPVIp0RGHBVByIboyrLDJ1p
 V+36XahGnn7aMspfJNvcQJxCwno6k+yNJM+uRmLDbz+jCJh2unOAHuH0iILzw33DBB/i1TNZPHx
 TZ8jdoADVbQukIRF8aS/L1rApQxxu79C9aHHRkSeSvXHinwzy8nLi8gH9gYXq6yz2zMee3rle0z
 BVYvTiuSqfo4zTRjFgP2OXbmBuFtaafl95CQMcjken/9wnkDQ/1g==
X-Google-Smtp-Source: AGHT+IEmkCGEFEpfwFOoJMz5p3ff95hwwwxWCOFIfxL/9EcrJ30HV5MaqqnNlRk9FaTnJ0L1uvOwDw==
X-Received: by 2002:a05:600c:a43:b0:477:5af7:6fa with SMTP id
 5b1f17b1804b1-4778fea84e4mr42741865e9.32.1763150741056; 
 Fri, 14 Nov 2025 12:05:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779527a656sm22876285e9.10.2025.11.14.12.05.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 14 Nov 2025 12:05:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v5 10/19] accel/hvf: Remove mac_slots
Date: Fri, 14 Nov 2025 21:04:12 +0100
Message-ID: <20251114200422.4280-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114200422.4280-1-philmd@linaro.org>
References: <20251114200422.4280-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This data structure is no longer used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-all.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 5781b17fa4e..ed28e073643 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -22,15 +22,6 @@
 
 bool hvf_allowed;
 
-struct mac_slot {
-    int present;
-    uint64_t size;
-    uint64_t gpa_start;
-    uint64_t gva;
-};
-
-struct mac_slot mac_slots[32];
-
 const char *hvf_return_string(hv_return_t ret)
 {
     switch (ret) {
-- 
2.51.0


