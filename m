Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FC2D3398C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 16:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRYXl-0004BB-U9; Fri, 05 Dec 2025 11:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRYXl-0004Aq-2R
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:20:29 -0500
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRYXi-0001ay-3S
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:20:28 -0500
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-88245cc8c92so15810816d6.0
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 08:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764951624; x=1765556424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRpPqJDEzIzTix+d/OG3pbA9XcsjVrzyGrtBXlgNnII=;
 b=lfaM16q66mG3PxYR/PdCQqbprqSKn+CZjw4Ea1uArO5cvU8cqGyrF1e4TITVF+Cmp1
 i+UbIZLrFojSI7EV71OTCt5mpVhpyEaewJdglvTcu32XGfoyvA8mr429g3Ju6k3rctAp
 SW/I4RZvQgIX36tlX9rtJeGIz79K+mI0OJWfSXX8Hhjb2ktuyykIf+scrxWCz3rPDnWN
 VrDmwFmLjnJBL1PAnIHBADWixuHVG0QsoJCEUSPUk5O9uITrcORTDAT3Mb0m5R6O0z/T
 8eqF3NadeiIBe97oM6RR8DQ3Qdug1O3u0O96Eqzqb4LItQ514G04zxTfFkLw3YZmZRTk
 WzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764951624; x=1765556424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MRpPqJDEzIzTix+d/OG3pbA9XcsjVrzyGrtBXlgNnII=;
 b=b1TzX6GpnwCxLieO4Z8l6sbRsrBMNeYzRoTuLQxGA+FRe8N+n9WRCy1E/4QM9NdoCc
 S1otGKIzLm+MAe1oifSrQR79PsovKDKx9DQ1PmIhKOvqyXryNX9TQTdf2cTc+axpPCtG
 AZ3wzD5UXmdebzN8YFryGcIgDpbrY/7C/GNb6u6x7qwifUOzX4IkH29r+QZVuBJqVLhB
 ShMaViMVkKgC8qvtFq3RTzKIhyL791gdUa5eHhpnsEnWSAbcCR2AMC0+4KIBhv38j8TE
 sffzhIVhsbHXRs6076Mh6Mh3kCVuELj2uRcUnPfP07xc1MrRBemUSxZqTagGtC1+jkSK
 89Pg==
X-Gm-Message-State: AOJu0Ywm79ObDlzICTycA8Qw6w84Ypk+KBsTM+XtO/nx283tZvT6YPLf
 2RKTaxzlvq7fHAkZuGW7jidjdNDiVNHjbw8CNcvVkvAha8Rg6GHMQztVzpMjasapOmRq7DOXKti
 HXU5aKmM=
X-Gm-Gg: ASbGnctsEw+R43rYVfmHbmXKgIQp6Bo2nXkS/la9d4sf9ve1TneHESekT+f7sIYVfYc
 SM26SrhQJmc/3+u0r5Dh2sig74ijYyJq7X7JmP2fW9Z+T3s5GTiKSmA0skk5t+wZnsFM6+g06FT
 Bl6tCenNFNDnBgOPS8r4M9AIkc1s2xL6b5NvSeNp5d1MVQA2NpQx0poJWSxMJ7q+2IHzrW9SWxv
 H45pvorWnVyS7jwLm1W89B4NXoRsLGzBCGFBHtxL/hguE+HjkXd0t6h7bzU/zZFbRLtVNPHtt+k
 yj3OGSVKYkokdUiX0MFUdDSARRSFlWjQq6Vu1cn0yEGra8A5/2DeEfAEpzbEjSoG3WBEv/lBnab
 XqMddXgu7DWczUP7haCrui+Av2kFgC7PrM3wSanjVlXBcGUxiYeJpW1I0C6iuCUFSreQALCH9hl
 b5UA0a6RrdUsMb2a9CO4j5iI5T+NrHUiarPKthAcT2MMuzsgWiNX8uumQzlRyYKXFOwC4=
X-Google-Smtp-Source: AGHT+IG/cDHKXqM4TAo1WBgAvxpOThcGndumSrK6YrZxKxHh+vVY23lPO7tXOZ/JQQctsJs0ZF0V9Q==
X-Received: by 2002:a05:6214:e61:b0:880:53da:fcbc with SMTP id
 6a1803df08f44-8882481ca77mr109489916d6.7.1764951623604; 
 Fri, 05 Dec 2025 08:20:23 -0800 (PST)
Received: from stoup.. ([172.56.17.137]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88830bfc22dsm21591636d6.43.2025.12.05.08.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 08:20:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 6/6] include/aarch64/host: Fix atomic16_fetch_{and,or}
Date: Fri,  5 Dec 2025 10:20:07 -0600
Message-ID: <20251205162007.26405-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205162007.26405-1-richard.henderson@linaro.org>
References: <20251205162007.26405-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf34.google.com
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

The tmp[lh] variables were defined as inputs to the
asm rather than outputs, which meant that the compiler
rightly diagnosed uninitialized inputs.

Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/aarch64/host/atomic128-cas.h.inc | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/host/include/aarch64/host/atomic128-cas.h.inc b/host/include/aarch64/host/atomic128-cas.h.inc
index aec27df182..52e98a0bdd 100644
--- a/host/include/aarch64/host/atomic128-cas.h.inc
+++ b/host/include/aarch64/host/atomic128-cas.h.inc
@@ -67,9 +67,9 @@ static inline Int128 atomic16_fetch_and(Int128 *ptr, Int128 new)
         "stlxp %w[tmp], %[tmpl], %[tmph], %[mem]\n\t"
         "cbnz %w[tmp], 0b"
         : [mem] "+m"(*ptr), [tmp] "=&r"(tmp),
-          [oldl] "=&r"(oldl), [oldh] "=&r"(oldh)
-        : [newl] "r"(newl), [newh] "r"(newh),
-          [tmpl] "r"(tmpl), [tmph] "r"(tmph)
+          [oldl] "=&r"(oldl), [oldh] "=&r"(oldh),
+          [tmpl] "=&r"(tmpl), [tmph] "=&r"(tmph)
+        : [newl] "r"(newl), [newh] "r"(newh)
         : "memory");
 
     return int128_make128(oldl, oldh);
@@ -87,9 +87,9 @@ static inline Int128 atomic16_fetch_or(Int128 *ptr, Int128 new)
         "stlxp %w[tmp], %[tmpl], %[tmph], %[mem]\n\t"
         "cbnz %w[tmp], 0b"
         : [mem] "+m"(*ptr), [tmp] "=&r"(tmp),
-          [oldl] "=&r"(oldl), [oldh] "=&r"(oldh)
-        : [newl] "r"(newl), [newh] "r"(newh),
-          [tmpl] "r"(tmpl), [tmph] "r"(tmph)
+          [oldl] "=&r"(oldl), [oldh] "=&r"(oldh),
+          [tmpl] "=&r"(tmpl), [tmph] "=&r"(tmph)
+        : [newl] "r"(newl), [newh] "r"(newh)
         : "memory");
 
     return int128_make128(oldl, oldh);
-- 
2.43.0


