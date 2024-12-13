Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7A2E77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBAV-00049I-2p; Fri, 13 Dec 2024 14:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7n-00080j-Im
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:59 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7j-0007g6-9t
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:53 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3eb8accbde3so1595513b6e.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117290; x=1734722090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QHvouIEJ47Vdy/hcGDRoqTZ/qz1P8ZCCWYCVL1nEzxk=;
 b=KKMJ5qXoajupy8CVMY7nGRv0mCT3/E8iSaSzAN+kDNJEIIrLvAn7+G505GO/rTcqBK
 WP3gBkmGNQ25t7wLnas+f31RiaEn0M/7pMOjG+3tsY0+DNi30sMGQcn/ZQjw/dbseShy
 3aCVl1+NYdeJx17nFccqkP50/iR4h0pJ3I2g8i4U0ik3A8UEdv1xViUD8eJX/a9qw+5H
 qIq+CrSCxWp6RHvBPsqDNn/arpQJ0cAgnV+C5F3K3DNaFZfU5N8mX+GMjdnprHplK+mx
 RptH7sQ0jbK32srjpWDbEO/URTZ3QZnaCIlnXIsOUgUf54wgj6ICud1Jyc1p1XWn299r
 qGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117290; x=1734722090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHvouIEJ47Vdy/hcGDRoqTZ/qz1P8ZCCWYCVL1nEzxk=;
 b=v8VKKhuEzWVItV2QQqqaQSDpKDDM9UpGuotjvdkQvm7vB8mZl/bC0hFRmiUtnF/2gF
 1SPuaH1Z0bVyFQWrlC46dDywfgM6ynMDsRS9C6oBY3x48N5VkocDbBfgFFgDRm9jP/WU
 AmYea1TI96+PAMqlA6tUy+C8RjGO+PTVDX9AcnkEBvsxZBDwGgUnt2Qnp6OEgocdT3Xy
 ghjFT4AwFY53ZkvQ9DCkgBL663YyWuvQ4qxYi7vGKShJ7k7uq60e224V0uVIGzyVZqaP
 Pfz4OgvLAilGjIkL0LF8BCAXbHCEbFXasbydGPOS9wEjmu9Yet/QHeDhY4HX8ehfFKCD
 j6Uw==
X-Gm-Message-State: AOJu0YyYjNucah4UzRMAWSRNkw9IAT6gpmH2vMXv3zDBufILMGExR/cH
 0lgtGGIioJneJCK48JEjQHqYiE9yIrumjEYS50VNSy1zYk8kPNP76Ul3tXGipVAAjMRNOZ1G/Nm
 wLpJN86Ca
X-Gm-Gg: ASbGnctHZN09bmbT/ZtaC4upDA7lYN3RHvHZMjySsxha9X2gg40ehIYyxDpxeFErwLp
 J+7NSftRNgNZ2E7Eez9FOI++AXowclBuzrrgVN654OSIPOExqDDZejSUmyusLSrlhJk39C+pXXX
 ypIWnicanVfaNsC2Nv7tqXqXBpwPZgmN/uAkrwsbKt4M64hEesWd1uFx49PiaYJer5AdIrNUHZF
 v2eDfi7hgkNSfErM66yDRD6kDORwY4VCnTL+JY4nMyeoyWyr6LDNHuxbvwKu5/7
X-Google-Smtp-Source: AGHT+IFjkDJt1gTcgumdap6JAylHQkV4ADKOzxNRVKRgQNfc4Dy+WvFPz8Dha7UY1S/WyMpS6eq0qA==
X-Received: by 2002:a05:6808:250b:b0:3eb:8236:d17 with SMTP id
 5614622812f47-3eb94ef2aa5mr4272725b6e.11.1734117290174; 
 Fri, 13 Dec 2024 11:14:50 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a497sm3545b6e.10.2024.12.13.11.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:14:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PATCH 62/71] hw/tricore: Constify all Property
Date: Fri, 13 Dec 2024 13:07:36 -0600
Message-ID: <20241213190750.2513964-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/tricore/tc27x_soc.c          | 2 +-
 hw/tricore/tricore_testdevice.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/tricore/tc27x_soc.c b/hw/tricore/tc27x_soc.c
index ecd92717b5..6f50cb5116 100644
--- a/hw/tricore/tc27x_soc.c
+++ b/hw/tricore/tc27x_soc.c
@@ -201,7 +201,7 @@ static void tc27x_soc_init(Object *obj)
     object_initialize_child(obj, "tc27x", &s->cpu, sc->cpu_type);
 }
 
-static Property tc27x_soc_properties[] = {
+static const Property tc27x_soc_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/tricore/tricore_testdevice.c b/hw/tricore/tricore_testdevice.c
index ae95c49565..dbdcc9704e 100644
--- a/hw/tricore/tricore_testdevice.c
+++ b/hw/tricore/tricore_testdevice.c
@@ -58,7 +58,7 @@ static void tricore_testdevice_init(Object *obj)
                           "tricore_testdevice", 0x4);
 }
 
-static Property tricore_testdevice_properties[] = {
+static const Property tricore_testdevice_properties[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.43.0


