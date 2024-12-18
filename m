Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D692E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuKV-0001JR-CZ; Wed, 18 Dec 2024 08:43:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKQ-0001Go-1N
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:06 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKO-0005eV-Hr
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:05 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3eb8bdcac2eso1214603b6e.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529383; x=1735134183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iyJAxwEKb2I5MPVS5DJzWXO9WaSZYlw8mVsU36qO0T4=;
 b=LEJLoPCYcosDRVdqJEJ+fWd22omGdmOEb3NLe/p2w7lkvCvgSar9kqN3M41FzgyXbT
 uYjwK9FVXDD7UdzoxyBTQcst2yn0cVD91n83fraqB4uxA6mqyKMH2HKGZM9ggqyoh0Ns
 i7phf7tObwG2qmC3k07sZa3Dr9L/yKtiqhGa0OJBhVryteieEbGeEqEXeOl+WaucDo49
 Pc2j6V7SCK+cgFxXaLaWm1gl4h4Yx3C+YCmNt8UdRzzZHugdXmJTHAWrbn1SUCy3QK05
 aVVNHk1GMpuuspxOnSlm29KQ8ARzw8AYWNzpvK+UgnfC+EBe2afyTjJEYZ73raXMYkUR
 h2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529383; x=1735134183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iyJAxwEKb2I5MPVS5DJzWXO9WaSZYlw8mVsU36qO0T4=;
 b=N8F621PQp5bxSPJUDNppw+jErAtQCSA+ifXijPObDDyN/uyKuHtEDE0RtidXrYPl/z
 nq8ACAZXxPV8WpClO0H6cciAvT/QK4zgP1rRPnndMDcDhgiBtCkVBa6+yQDLTDah+fIh
 aMIhF25HfxohR6sO3u3hMnkM17Hk6gYMIKl1F40LIW9KhrqFHkcD2v+tOeywrhEyfncF
 ITsTKxXSuBuoQxxVkmBUFjwYG7W7us8RIEwSTOTv0hgfP44wG/VPOcffgxVHbjiH2Xb2
 5uQurt5Bd/E9xDyzkluFo4mmrHvuNdzWAti74gwwo7QJdF/t9vputWLOLFoYgKZqMcLz
 UGGQ==
X-Gm-Message-State: AOJu0YwRWPTWQSWiq55b0AFHPo60a1XHlXMdu+yDWMNKD56TnrmgOZmw
 f7XxlK0tBV1igvzkrViAYos7DzU1aVfz3g/EIQ6//aBDOkzuv/NTEj8L3/ERcJhrHAfBhbK64zh
 FwA/iQnZ1
X-Gm-Gg: ASbGncuo/U7pZqGC6oAWjBMsfrPki5ep7MgndJPmJ3FD1aqAjprGB3eePE+BWgr9Hap
 qFhtVJsleK04YUhKZ2Q1rwurH0bjfjAdl2Z2VgpbBnhXK6loxTrCUt1J53xArYVHDWmzSNS8V0v
 tsb4Syob0as164Ny7BQTRoEfrK0lHELKlGgm/naQVzsQLo6dwoh2tCDu28KYUNFPKry/Ap6cMrF
 MzFiNYRVhOzRAZX9Ci0gObnTHoFjsA8iAKwbC6ovA6XLYXse0HPw8Bz3EWfWGeb
X-Google-Smtp-Source: AGHT+IGSAsvXBcA7n8cGyuLNW9n/e9uOoGuntCeDVfdGHIvjD3t6SF0xU3/b1e9gL1db1IhfRodLpQ==
X-Received: by 2002:a05:6808:3a12:b0:3eb:4b4c:80c9 with SMTP id
 5614622812f47-3eccbeaefe0mr1973170b6e.0.1734529383377; 
 Wed, 18 Dec 2024 05:43:03 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a502sm2870951b6e.9.2024.12.18.05.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:43:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 07/24] hw/tricore: Remove empty Property lists
Date: Wed, 18 Dec 2024 07:42:34 -0600
Message-ID: <20241218134251.4724-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218134251.4724-1-richard.henderson@linaro.org>
References: <20241218134251.4724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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
 hw/tricore/tc27x_soc.c          | 5 -----
 hw/tricore/tricore_testdevice.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/hw/tricore/tc27x_soc.c b/hw/tricore/tc27x_soc.c
index ecd92717b5..81bb16d89b 100644
--- a/hw/tricore/tc27x_soc.c
+++ b/hw/tricore/tc27x_soc.c
@@ -201,16 +201,11 @@ static void tc27x_soc_init(Object *obj)
     object_initialize_child(obj, "tc27x", &s->cpu, sc->cpu_type);
 }
 
-static Property tc27x_soc_properties[] = {
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void tc27x_soc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = tc27x_soc_realize;
-    device_class_set_props(dc, tc27x_soc_properties);
 }
 
 static void tc277d_soc_class_init(ObjectClass *oc, void *data)
diff --git a/hw/tricore/tricore_testdevice.c b/hw/tricore/tricore_testdevice.c
index ae95c49565..e60866d76f 100644
--- a/hw/tricore/tricore_testdevice.c
+++ b/hw/tricore/tricore_testdevice.c
@@ -58,15 +58,10 @@ static void tricore_testdevice_init(Object *obj)
                           "tricore_testdevice", 0x4);
 }
 
-static Property tricore_testdevice_properties[] = {
-    DEFINE_PROP_END_OF_LIST()
-};
-
 static void tricore_testdevice_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    device_class_set_props(dc, tricore_testdevice_properties);
     device_class_set_legacy_reset(dc, tricore_testdevice_reset);
 }
 
-- 
2.43.0


