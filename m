Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7510AD0C615
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4L3z-0004C7-VB; Fri, 25 Oct 2024 10:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3y-0004A7-DH
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:14 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3q-0007pw-F8
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:14 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-431695fa98bso20341545e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729865585; x=1730470385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWQTkVIYoMx387TeXW3tDVaYyEBBg7QXyfQFYBePRB4=;
 b=lkAQl2earbkay8EYGVF02u13RWSiTiD0htE/yj8EOZ8ReUAM4/U91P8KDfFobko5la
 CPrcz2i3MdCG0iZCkI5mmv9xZZaeRB1FHD/Rsn72T4WFWyOwZkCkGVj/HNXYXEvC+RZd
 AtGE9Elskx0r4978Zhm2KD1y4NvCbuJ7sTd4hRgOsPH/OL++YSb8k2DlAfsu6TIlC+FT
 tURhSW9NsqeNVeu9JezMvxUCl5+iPTPUPdV25YCUBgqAQyWaZUr6FF9ZIZCOHwPv9rjd
 EJkMTY3EXCxgE6lV9x0oVPwSzFtBe2a9SbmrFhKpkN8zubZB+IbvU8uxzCcd3IxilvhE
 cLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729865585; x=1730470385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LWQTkVIYoMx387TeXW3tDVaYyEBBg7QXyfQFYBePRB4=;
 b=SBblkma8woPJpjgtVxCa3cWGQ9EJmQt//vjqgTAHIQerb35NuNlhNSd1IpnZJsV/SL
 rIG8Vm8IFlVavYPOVrAAZ60wU1jhNJEme8zlhsrGKJoZLyX9NBdZ73U4kReRe1E3Yjy2
 eyLXrnBDEgwTQVWMae71mk6jme0RzTeLThIAvZIGHKudCdj/cqywmEVwOijqz8bGQ6JL
 B5Kfb3E5aob05qvgWDnENYW6HqD4gj7vvNLSH2vWKkY1Yrm8JVhfxWACZkF6qkyaK4rx
 N8/G4e2MuVUE0/8BpdfRyZsDJ4EdRbg+rlwFdEw/O1vYxS+qG6A138rk4uvD+hD6cVgk
 cuIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeplKb4XgcXcaaj5ZOTvdXBFBmJo0sUWeNO2H9Sas8RnrbucSbUKvO5ztY2ZX3T5D4FlT7/gUdfZjW@nongnu.org
X-Gm-Message-State: AOJu0YzmlymYcBmwiN48qA+9evGUE0zGT75LmKgwKL9VHp4UWKU780Dk
 0lvPmhAjj4Mxq1fFenzTd9N35p0MwPdLJcbCdV+CxmCV6bOayTrwG9NvzxEA4rg=
X-Google-Smtp-Source: AGHT+IHSPtYopQuk24YCPV4j/3lLijdSJYW/1g+JfHiVm9QFLT6tmDk6VCMAGDw3f+ncfW6XOWoYQw==
X-Received: by 2002:a05:600c:6d19:b0:425:7bbf:fd07 with SMTP id
 5b1f17b1804b1-4318c8cd0bamr52618515e9.5.1729865585055; 
 Fri, 25 Oct 2024 07:13:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b57b051sm50104535e9.42.2024.10.25.07.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 07:13:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 10/21] target/m68k: Initialize float_status fields in gdb
 set/get functions
Date: Fri, 25 Oct 2024 15:12:43 +0100
Message-Id: <20241025141254.2141506-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025141254.2141506-1-peter.maydell@linaro.org>
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

In cf_fpu_gdb_get_reg() and cf_fpu_gdb_set_reg() we use a temporary
float_status variable to pass to floatx80_to_float64() and
float64_to_floatx80(), but we don't initialize it, meaning that those
functions could access uninitialized data.  Zero-init the structs.

(We don't need to set a NaN-propagation rule here because we
don't use these with a 2-argument fpu operation.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Spotted by code-inspection while I was doing the 2-NaN propagation
patches.
---
 target/m68k/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 9d3db8419de..9bfc6ae97c0 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -36,7 +36,7 @@ static int cf_fpu_gdb_get_reg(CPUState *cs, GByteArray *mem_buf, int n)
     CPUM68KState *env = &cpu->env;
 
     if (n < 8) {
-        float_status s;
+        float_status s = {};
         return gdb_get_reg64(mem_buf, floatx80_to_float64(env->fregs[n].d, &s));
     }
     switch (n) {
@@ -56,7 +56,7 @@ static int cf_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
     CPUM68KState *env = &cpu->env;
 
     if (n < 8) {
-        float_status s;
+        float_status s = {};
         env->fregs[n].d = float64_to_floatx80(ldq_be_p(mem_buf), &s);
         return 8;
     }
-- 
2.34.1


