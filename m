Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25D6D6554E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 14:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVsaS-0001qn-Lu; Wed, 17 Dec 2025 09:33:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVsZh-0001aQ-7i
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:32:24 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVsZe-000753-QZ
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:32:19 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477bf34f5f5so43221725e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 06:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765981936; x=1766586736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XUbyBOmogDSj3+4c56O0TI6S8LRQ6OyrdzdZ0KcvzLg=;
 b=YsqxErFsQ27g95sS63o1nCH5F4ShIdelRUrNx3JyyvRZx039r08rLRJzUOUqaWR4n0
 EQgxATXGWqhIwZqnGuyBIKIBOdEuQeoGcWvvSg1suRZPtxwKU1npFn7wZk7jOHntB9qx
 3/ZyUBAnAIZsgBVgKTJNVa4PURea9Bel4szdQ6bGJD8RpKvJjFJmdqqHHxthtWWPlaC0
 ZmA8zOKCHeDdON3OV0EJOG08sLkld0r6byz0xNpLGfR6RDnBrgjTBaCRB47/v9pbiNMQ
 WU3YrNSGxkysdkLaxha2QdmE3h6QsUWSUvTgz5zBcaU2CAydUnSBpebh/8BU94NysWAh
 S6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765981936; x=1766586736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XUbyBOmogDSj3+4c56O0TI6S8LRQ6OyrdzdZ0KcvzLg=;
 b=lcrG+2w1bXwSS90ghXvmK0dA015hjgSlsWAey+WhC2K0OCoruSm1PXjd3fGIV1vxNw
 VbMHChItn+GbvU1Fr0vUpKxCkP8xSO+RXk82amu+YhP6b5nq4e88UveEm/0RNNGf4tDJ
 6MwsYamg68IHSTkB0G9Darot8STeCT3ucXAKaEn8KTGlTaGEWMaz3LCKGRX23U3o2LKr
 /LmBrstIXHnK7hLsI8whE/JloPfUrnHfSSoquvG+i+4PBhcMP2Gclai8ufkuwOu9H9/i
 JH7pgAjPNYISlieXpQ6qOIW/TK24cafcnsuiUrIFYIKMEuUtvWsRr5IO5cfdytO29EQI
 byJw==
X-Gm-Message-State: AOJu0YxbUjYJhl13I2r1ZExLcAY3fUmAi99Fd2NXQTAI5IQvRqZpyE5Q
 C7njgoiB4TDCSiVwUtWQ+FJUnXUPxjRX7H1otmiOquxi8X6B6HdkN09kdoJijngZhCNlZynkhYJ
 sK6pFmoiVFg==
X-Gm-Gg: AY/fxX62aRalG1sNWQqREfOejGYJxhjH/T6wp+vuSLTI8ZnICcdY8Ezbi/LGXp4iOQS
 NW4T1mp4ooDGBq6hc3YcoYrDzQScYWgO6Gzl00uRU1NXhZLMO3VfPM0PWHUoVsizzKerK2Wk13+
 OLHaRYOWHEKiP+EP2EUJCp6gYJ6JbfmXszeYhcI7FQX85OMCtk7j3bIPYd9Aazx0S743fSvucKQ
 3de27A494Iz9mBIxa/WdCw7oBi0MXgBj3u39bxuoiTaHn3wmPCa3La+e9V2KMH8h60dZ+jMr+n8
 wIGH/iDQG6y0whRmNgFbsZ7oROnOn5lhD2ApuGG26TpDgy6l2QUR3YeRulcNiRyM18XRsdAIYdN
 Qq3rTmfNUVFdVEh3L9wnBvmiYOyol4HUOwafrzy3k7HBerorT3kgGGV4caWmAsQcB3K+zeH3BX3
 5wE8kXksEFtwufoO3X7ZXTv/Rn+VuCyQTkcvq0mZxkSv52ynJ8Hfla7EuwWATY
X-Google-Smtp-Source: AGHT+IG1Sq0CNmTwPcwxmZQwoHtUbY7reyVlCsgJ98GdeAMI7tHBSUVhBVE1wrLWSIs8t3uhywPwkg==
X-Received: by 2002:a05:600c:1c1a:b0:477:5c58:3d42 with SMTP id
 5b1f17b1804b1-47bda747ed7mr54588085e9.10.1765981935987; 
 Wed, 17 Dec 2025 06:32:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47bdc1edd26sm40175975e9.13.2025.12.17.06.32.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Dec 2025 06:32:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@kernel.org>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH 03/14] hw/arm: Update bootloader generated with '-kernel'
 using stl_phys()
Date: Wed, 17 Dec 2025 15:31:39 +0100
Message-ID: <20251217143150.94463-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217143150.94463-1-philmd@linaro.org>
References: <20251217143150.94463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

When the MemTxAttrs value is not specified and no MemTxResult
provided, address_space_ld/st() is equivalent to the simpler
ld/st_phys() API variant. Use the latter.

The _notdirty() variant is supposed to /not/ mark the updated
CODE page as dirty, to not re-translate it. However this code
is only used with the '-kernel' CLI option after the machine
is created and /before/ the vCPUs run, and *only* during the
first (cold) reset; not during following (hot) resets. The
optimisation is totally not justified, since we haven't
translated any guest code yet. Replace by the normal stl_phys()
helper.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/aspeed.c | 3 +--
 hw/arm/boot.c   | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 3a5071a3841..8ce82f1f622 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -77,8 +77,7 @@ static void aspeed_reset_secondary(ARMCPU *cpu,
     CPUState *cs = CPU(cpu);
 
     /* info->smp_bootreg_addr */
-    address_space_stl_notdirty(as, AST_SMP_MBOX_FIELD_GOSIGN, 0,
-                               MEMTXATTRS_UNSPECIFIED, NULL);
+    stl_phys(as, AST_SMP_MBOX_FIELD_GOSIGN, 0);
     cpu_set_pc(cs, info->smp_loader_start);
 }
 
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index b91660208f5..5ca9c8db5cc 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -266,8 +266,7 @@ static void default_reset_secondary(ARMCPU *cpu,
     AddressSpace *as = arm_boot_address_space(cpu, info);
     CPUState *cs = CPU(cpu);
 
-    address_space_stl_notdirty(as, info->smp_bootreg_addr,
-                               0, MEMTXATTRS_UNSPECIFIED, NULL);
+    stl_phys(as, info->smp_bootreg_addr, 0);
     cpu_set_pc(cs, info->smp_loader_start);
 }
 
@@ -277,8 +276,7 @@ static inline bool have_dtb(const struct arm_boot_info *info)
 }
 
 #define WRITE_WORD(p, value) do { \
-    address_space_stl_notdirty(as, p, value, \
-                               MEMTXATTRS_UNSPECIFIED, NULL);  \
+    stl_phys(as, p, value);       \
     p += 4;                       \
 } while (0)
 
-- 
2.52.0


