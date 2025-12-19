Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A95D7879C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdTk-0003ae-IM; Fri, 19 Dec 2025 11:37:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdTj-0003aJ-3T
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:37:19 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdTh-0000Q3-Ki
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:37:18 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso19209135e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766162233; x=1766767033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TY+NKK5QrerogI70RsrGnC20hTX4QQeP/jfJOPR/wec=;
 b=gvBv1xrY0QScZkc1faTe2pgbKFN4CQvDaXMgStLmVLkzBAwuVWfNlPMGIXLubvw11S
 DOxKKQQyjxPRyJ+pDx8U+CUWEBlsVKCNs6jOPdBmxWPGcYnHsFemdsvZ42Sv7BOKsWN+
 XLOf3vVQchS9RqTMZdpcbRtxYV9HdijRRM4g4gi6EA9xhpddsM2V01DlS0kd52cmKyAw
 N5GwGZjWvtqdhH5o6fg+zHUAbnHncDyxIknEn6/2EBoSQNzC04LyUVvFIqhK5ESa65m7
 748nrZ9p0oWGBLeeKJV+CLqj3qAN7KVFEn9Bs9CrfkbUmPVBQ/Ej0ifjrvhRzshX/ggU
 WwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766162233; x=1766767033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TY+NKK5QrerogI70RsrGnC20hTX4QQeP/jfJOPR/wec=;
 b=YhxGc1gJIkStwRmxSgZwDdTPW2QQHWj1kTqTEl2YEYozh7MR5nlhyiNoTSnrUDfWBk
 g6tYKUIY0khC1VpzXmBlFO3ge7qgkwwQ6LjDgdYPYDS3Xl9AmP34K5n8BhL6zzP+SpG5
 jJ8Be1YXihtWKH/NHq1QfGMaKYabRznKXZEgnByTkgRK+Cdt8cKiGqpzrl2CfYCTgk0s
 2HeMfXr+jDuLVHESR5+Lt7/7mezlchPyC5cQccYIR4EAj1N35uugq4KgBm+wo8gmUFHl
 HU2mGceUFhN9FYG8eeYjumGutaIMM0yd1VKGZN1O4xG9K9bxZyReVx1NafBmSi9dO+h3
 ypcg==
X-Gm-Message-State: AOJu0YycZ5VcfZHjAYqSa0UOgLwZ/6tEj3WIspm0DHEzrUkosed2kWGq
 PRKi1q5gMCJRm95YsUwUYJ3VYNemo2/PS39n1umItieiPtZZz1nk/nqasWgmaNA/FE32pdvl1iv
 ik13RR8g=
X-Gm-Gg: AY/fxX6IfCSCFsYLgwfsHXLfGIq8XBjeqdWNQCTxPgD8h3UF6rvs5ee0JlfZ1bJU31V
 io9xgULUN2HYH4/UKHXC0M7a1Yfp9WlPIyzk1LP1FAr1mN/bMEkhB7EEEoGa244yMPcwFwtz8BI
 HVmuTIeYJmgKvneyOg5g+g6iZIaOsllvfFvFNMwKJ9BS/nU6kn+TOrPnY5D5Cu2rkRn1E0pIcGN
 RyP2MCrX5fOzY8YuEupwPepvbU6Lci8Ze+exmWLjgiNVv2zz+WO8K6X7jp00T1Quw7u8nDaqKHr
 h0DEQBEYROFiEr6h5zs446xpFjen48MM3XdtbHjP5/TC2UOixIvVHlsCw4nNRN19BmbztjSG8i8
 di5PYc1TWuk930z5i6onK/GB21SG7O3gp9T9adLtnQrLoL18ufBoanlJwslP1dYXxqcJ0qEgOuG
 b+B6LvZ5KJgOgNOZaXz2J3B+m9Yje3Yv1NrHohj72AOFqPybimlGyATJiReDKd
X-Google-Smtp-Source: AGHT+IEcLPlqf7J+bzderohbYPYsunZArQQqGrvtwE2ok8qIrAqefFxt3a1S3zG4+zC2SyUPD1VOIA==
X-Received: by 2002:a05:600c:c08a:b0:46e:1abc:1811 with SMTP id
 5b1f17b1804b1-47d197f67edmr24265185e9.27.1766162233572; 
 Fri, 19 Dec 2025 08:37:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d1936d220sm53976365e9.8.2025.12.19.08.37.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:37:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/9] target/sparc: Use address_space_ld/st[n]_be() in
 ld/st_asi helpers
Date: Fri, 19 Dec 2025 17:36:43 +0100
Message-ID: <20251219163650.74303-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219163650.74303-1-philmd@linaro.org>
References: <20251219163650.74303-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Do not open-code address_space_{ld,st}n(), use it passing
the access size as argument. Directly expand to the big-endian
variant (with the '_be' suffix) since we only build the SPARC
targets as big-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/ldst_helper.c | 42 ++++----------------------------------
 1 file changed, 4 insertions(+), 38 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index a87a0b3eee0..e9139814c26 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -701,25 +701,8 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
         MemTxResult result;
         hwaddr access_addr = (hwaddr)addr | ((hwaddr)(asi & 0xf) << 32);
 
-        switch (size) {
-        case 1:
-            ret = address_space_ldub(cs->as, access_addr,
-                                     MEMTXATTRS_UNSPECIFIED, &result);
-            break;
-        case 2:
-            ret = address_space_lduw(cs->as, access_addr,
-                                     MEMTXATTRS_UNSPECIFIED, &result);
-            break;
-        default:
-        case 4:
-            ret = address_space_ldl(cs->as, access_addr,
-                                    MEMTXATTRS_UNSPECIFIED, &result);
-            break;
-        case 8:
-            ret = address_space_ldq(cs->as, access_addr,
-                                    MEMTXATTRS_UNSPECIFIED, &result);
-            break;
-        }
+        ret = address_space_ldn_be(cs->as, access_addr, size,
+                                   MEMTXATTRS_UNSPECIFIED, &result);
 
         if (result != MEMTX_OK) {
             sparc_raise_mmu_fault(cs, access_addr, false, false, false,
@@ -1066,25 +1049,8 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
             MemTxResult result;
             hwaddr access_addr = (hwaddr)addr | ((hwaddr)(asi & 0xf) << 32);
 
-            switch (size) {
-            case 1:
-                address_space_stb(cs->as, access_addr, val,
-                                  MEMTXATTRS_UNSPECIFIED, &result);
-                break;
-            case 2:
-                address_space_stw(cs->as, access_addr, val,
-                                  MEMTXATTRS_UNSPECIFIED, &result);
-                break;
-            case 4:
-            default:
-                address_space_stl(cs->as, access_addr, val,
-                                  MEMTXATTRS_UNSPECIFIED, &result);
-                break;
-            case 8:
-                address_space_stq(cs->as, access_addr, val,
-                                  MEMTXATTRS_UNSPECIFIED, &result);
-                break;
-            }
+            address_space_stn_be(cs->as, access_addr, val, size,
+                                 MEMTXATTRS_UNSPECIFIED, &result);
             if (result != MEMTX_OK) {
                 sparc_raise_mmu_fault(cs, access_addr, true, false, false,
                                       size, GETPC());
-- 
2.52.0


