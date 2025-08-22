Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C16CA0EFF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTIC-0002c2-2U; Fri, 22 Aug 2025 11:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upTH9-0001yu-AU
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 11:02:02 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upTGe-00051N-Jz
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 11:01:53 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2445827be70so21935065ad.3
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 08:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755874877; x=1756479677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bB7IRnB2X72HyfFQdO8pk3Ty2DGMB4Kj1UdkMvzsUlw=;
 b=PZ2KoEFsBrODq8+quYQVYpeR81uFLC7LaclGadJEuy3Fu3ZWAERggWajx5TEB6Xcl/
 09cldDpqZFB5ZvQyxwHQAa90icYsZqj1w4P/gZ0sph1mOUvpemeH3iCM30NBMGeCD4Jx
 EDDqlMWXs4ecaxdZ4P0ny2jH6FWUGCsEF/Scv/e94QykoVZHdWTs/vCkd9+wu1OXEKp2
 GB5nbywDPg305T31pdz8QztZDGiHJ1Wp1Vh9QN+Cv7E0XkTuklZdLfNbNLdo6jkvsbbo
 CKYtPn6LLTKZ04I5n32XSWx41Key6Ea//uEmL4OIBkoLWJlmF02esxiKhs6YK3zNestK
 bOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755874877; x=1756479677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bB7IRnB2X72HyfFQdO8pk3Ty2DGMB4Kj1UdkMvzsUlw=;
 b=C+SbTNjh36FiE8iT6+h5yFv4kZf1w2ybfbQ7H0cC3T8icH+0sArU1lI3wzUkAG4kcV
 iZW57fZi+X9hNOOEQDaLwNcKlYueRSxwC3/8u1RB7B/aLHbJADaoM2KBN6ujDfmcC9QT
 9fXO8jTneEwTh4eolqunam9M6yhMmiVxD3XV7RU+ymfnJYpQURVZySn43CMi6tYLtiyp
 8/uzfF0rAQYrbjgq1FhwBMZTzneLXNIZ/Y4ihSYvuKc0S4T9+rf7czqQlK8+OHth+PUa
 /LWgp2g7qUgqv1R7988nMsllY6k++AnEAPGR+JksSQOi/lgmrS9FzEV2Ot8NAcoU6vs/
 R/bA==
X-Gm-Message-State: AOJu0YwgClohg/Ud9Ydf25IBb48/E9joKRwfD60M8P80stdYFoasGjpp
 jDARrmu5MVRKkpznBovOLfx0QZMFwM+aLyH08v8nzn2dbXqJRKAJlqVzJcwepIoQjL3lKi4NaNh
 zuwVkYt+rlA==
X-Gm-Gg: ASbGncsihsAT6UIM+yKJY0qgwF1r+J51YQaqMP1Ran+Z45QhwTw5aW43DpEtcAOblt1
 XhMuz2jDcFtWGD5C/p+Du6wUPcHOjVWmHdDT3h/M6xffFFE8rGHSRKXihCdW/7jNBXDtjeiYvgN
 C4InVYBqt00elrH3DWeVkOOl4soVyOG9Eu/JADtb2mJ3nunii1oleeU1NpKnqPfpRF0QXFkWuKD
 jG/uxFbSaudixWz1p9wbvLbeYBzNYDx9yHC5S3vJuudWWFSie0Su6CuEkiTYOLZLXyJKbN1V6gg
 Rg4RzyC4tD4niabRMLBJWfVrq+EEdCKjoF7Pi3PxIdz0zqFu204NWnRlxQiHTRmg+bgaglqJy7l
 TZoipVBR51VMszJoTsM6johciW/dzOqw0lu8/jW7PkUt9otYOC4gVBw==
X-Google-Smtp-Source: AGHT+IGhabOmuU32VxtZOGTmb/egh9mA6ZqqqVyknwS7TOPD81KLr+AFlSDav/1kfBeViUrNKPXpaw==
X-Received: by 2002:a17:902:d483:b0:244:65c8:c1f2 with SMTP id
 d9443c01a7336-2462edf24bdmr47926685ad.20.1755874877036; 
 Fri, 22 Aug 2025 08:01:17 -0700 (PDT)
Received: from pc.taild8403c.ts.net ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed5406e4sm85929495ad.165.2025.08.22.08.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 08:01:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org, richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, philmd@linaro.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 10/12] semihosting/arm-compat-semi: eradicate target_long
Date: Fri, 22 Aug 2025 08:00:56 -0700
Message-ID: <20250822150058.18692-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250822150058.18692-1-pierrick.bouvier@linaro.org>
References: <20250822150058.18692-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

We use int64_t or int32_t depending on ret size.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 semihosting/arm-compat-semi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index f593239cc9a..55d7bf29ad6 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -501,10 +501,13 @@ void do_common_semihosting(CPUState *cs)
         break;
 
     case TARGET_SYS_ISERROR:
+    {
         GET_ARG(0);
-        common_semi_set_ret(cs, (target_long)arg0 < 0);
+        bool ret = is_64bit_semihosting(env) ?
+                   (int64_t)arg0 < 0 : (int32_t)arg0 < 0;
+        common_semi_set_ret(cs, ret);
         break;
-
+    }
     case TARGET_SYS_ISTTY:
         GET_ARG(0);
         semihost_sys_isatty(cs, common_semi_istty_cb, arg0);
-- 
2.47.2


