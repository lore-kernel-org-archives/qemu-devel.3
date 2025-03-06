Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659B1C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDS6-0007GQ-5s; Thu, 06 Mar 2025 10:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDS4-0007G2-Fl
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:48:00 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDS3-0006Dh-1W
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:48:00 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43bc63876f1so7438835e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276077; x=1741880877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ibKdWczve1piqobnZ/7eakxu3MNnTBDuUSaIAp0/9Gg=;
 b=M34fM6l8WWVLS4+V+Nx0CfYrLXOxgcNvGp99Rbhw/OREoxuRp0JjKSUcjbRE4J50eT
 WdZ4iDlpypn/OdJkd0p+xKRxXj+tHalT7c2Yv0wMdqYEnSQ1nYSdRTTc59/Ohu938F3+
 ceEmxQxBGOfd+27RpNdLpcFeZ5C6lEwDfde3vu0bHbuX8GuRZqL9VDZW6uJA82I8TUi+
 X2YBYAYuA6yXpUdeSbHhokeFwU+2Rj/cPkoqKPZrpxPB55TOTLdnpwr2naQBWe8Oqs+y
 lDP0QVinZ+jrTqAgdBB4seNsWDio4ZNc+szYJH1mT+GHN1wae+QmWydAHZosMN+uRKYo
 6xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276077; x=1741880877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ibKdWczve1piqobnZ/7eakxu3MNnTBDuUSaIAp0/9Gg=;
 b=ZbGuZ/4PXOd4xqkw4AHC/f1mwgsTlV8/TrJ1B8ID9rq7lV4Cj2ZmymUkdNm0ABYZHN
 sNAduwmekiB52Np7ZtbiwX/6n0Qtg4Zz6nXniDL7esjboFAZILynqwXoh4VP484yTgiT
 gerkY39jEMTOmsBAVLZGs05Bz9eUPtpA0EVgAKrgUJZnRebsrZs3BpPbDJHJ0I6AWbkq
 FhNlRcuHQ20ptMr5kM7lQ6T/mAoET3JWiQfGzrPoUZKdohTRhun8Fo/5Q0ILWKu6SUxP
 MFXewA4uNC3dFBWaPQYl90WLv5mwdHexTd3h0DpV1ezdCrnw+bNfjYcYroryVi56vhhe
 ediw==
X-Gm-Message-State: AOJu0Yxv1K1tA0bjxKPkRAQ2tKvhqZsNAumDhMS3FYzPQOcMzeJAHPAJ
 Xag8bIipXaO9+FLCXXI4bjzD5sXRs4ggZ8Xbty3FlhTOCIhoPXiqpQMK6c8SHKiz+TK/13gdyF/
 +SPg=
X-Gm-Gg: ASbGncsdpOvRaQkLsvHiwJ3qFVOaEIT0nX2L+M7kKLQceiJWE7mKiTjBYtpYfrrf99A
 DbcE8qfkTh2u0mTaZ8jGVicZj9rO0sBk9K/X5i5mYoHJLPkkQS5p1vd6R+vOxmfBMr6eO9jHK9c
 3u6I563y7G0FCopP/01hztFBRu2qqc2GHiXVLEF28QEu+R1RgdSW1P1RizajLG/q2v2j2MFwewN
 jb1BbLZj03P4zTfnsOmW/FWnHVpBmmo2C5kjhkX5gFlYBayIWRSYBrsYrDnkBzZNA9X+5Q/6CA9
 NML4UZ9s/aaqaRkN198qOvWgfSoeQOlPuEVwv1pAagkM6mXhulkYe4HacGo4k/126/ve4l3pPxi
 o1sCqJBe+yGs6pGY0pBs=
X-Google-Smtp-Source: AGHT+IG153zJml+tWit6jd08Ss8mxkrue3nnpfcCV9mVPUxEoTPGu6m02eVvi9xQIn/MvjHKxlOArQ==
X-Received: by 2002:a05:600c:310f:b0:439:985b:17d6 with SMTP id
 5b1f17b1804b1-43bd2adb414mr61160735e9.27.1741276076849; 
 Thu, 06 Mar 2025 07:47:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4291cb9sm53396655e9.13.2025.03.06.07.47.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:47:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/54] cpus: Cache CPUClass early in instance_init() handler
Date: Thu,  6 Mar 2025 16:46:46 +0100
Message-ID: <20250306154737.70886-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Cache CPUClass as early as possible, when the instance
is initialized.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250123234415.59850-5-philmd@linaro.org>
---
 cpu-target.c         | 3 ---
 hw/core/cpu-common.c | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 667688332c9..89874496a41 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -134,9 +134,6 @@ const VMStateDescription vmstate_cpu_common = {
 
 bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
 {
-    /* cache the cpu class for the hotpath */
-    cpu->cc = CPU_GET_CLASS(cpu);
-
     if (!accel_cpu_common_realize(cpu, errp)) {
         return false;
     }
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index cb79566cc51..ff605059c15 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -238,6 +238,9 @@ static void cpu_common_initfn(Object *obj)
 {
     CPUState *cpu = CPU(obj);
 
+    /* cache the cpu class for the hotpath */
+    cpu->cc = CPU_GET_CLASS(cpu);
+
     gdb_init_cpu(cpu);
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
     cpu->cluster_index = UNASSIGNED_CLUSTER_INDEX;
-- 
2.47.1


