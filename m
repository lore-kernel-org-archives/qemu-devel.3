Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E95E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 03:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN28w-0007Hj-3D; Sun, 15 Dec 2024 22:51:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28t-0007GL-Nm
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:35 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28s-0005yz-2O
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:35 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-71e2851de95so814206a34.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 19:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734321093; x=1734925893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iyJAxwEKb2I5MPVS5DJzWXO9WaSZYlw8mVsU36qO0T4=;
 b=XlWgCH4LVC07xHxfWmSToyFBLrXP4SLR1YvVJyETI0IwOV2A1nteEsnBfkgQiJPZbJ
 65SIcwmychAkYQIjbPh6cyYn7idbd2jokuPQo7SHkLjbqBWYpdtWhLyEql0DAAdL5Zvs
 gq8LfNe7uAoXkpVv93No6ByhW1ZorCzpY2lFniO/9sthHcOlTPi9whW7y5lnDsbd76DZ
 w3zGfCR2vUNjAi1G4IFM+cgbwPmj3q4Dxj/gihOAGGWDv/bCl2SR+XypkFmYxQR3oTth
 pFBkHokvEPmHc+Q5Sq0H6/hFWFTrj1fJeJntcFM5Z0GbMYZH+KQWr1ldAr3vNl6DBnal
 mJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734321093; x=1734925893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iyJAxwEKb2I5MPVS5DJzWXO9WaSZYlw8mVsU36qO0T4=;
 b=pdf+FHoFWHdEdBtFZyrRsKAqf+ZVdy7M9cx7MgGTUIT8Dib2T2BUFgBordkaroaJrA
 il3wQjyXKvWOQGAzpGEAR+dcijilJFQ/ui0hnyZX5DHtvUFA4YJop+qW9VNo2EhJ6/0o
 X6uWnbNKEDRCU/8naycWMAx8TDpVw1ofuK58rmTR70v0GUv26ZLq0T3R1lMoZsNJ6Lmw
 7/H7JfAJBAfPFdeNolpitqQlhRfzWN8h1ZTcKr9On81YgMjEXCEAKwmYQxqLfIiNtEtL
 LXKcsCw7i+6LV+awhgOBkSwVysIGmvRrWo2VaOrcUhsq+OMA37c/RpiHLiyDcYKNxHIu
 J3hw==
X-Gm-Message-State: AOJu0YwpXfp2eN133x5lJOb+nn5mnhvHazBvIDzceKCG7K9LQ7YqMDhl
 Rkr9QdEmrTIgloUG8GbuMw4nAT4FxlBeJKIWPBIzeD4CEiemzIoPF10/pGmxPgH+pR3OgxRTImp
 KWV3LhyBF
X-Gm-Gg: ASbGncvfgoSLkIyx8O4o/XDYx5Z2mReTQtfjY8RSJHFXUXoM+rTWIUtOXSOfmF2QQG9
 l3wGUIg7U3PXTETL3BAGypMIoppGR/vsDpWREAPEEiPrEiODlHVmiP/CJv2UU4FBg1vjHgLWrsV
 L8XrRA8+5fgxRb8iO3f/oM2BYZNKLRejaqPnOG8tunwbntE5JrsDiS4hZuEt0zWE5gKyikorhyH
 OHS9zWFAw2t0C9k0NGgUGiIH0nvjtrmmyxPgETRoHD094/RXhN0ai33DAPZGmSN3fq6AnilpxZt
 MiCwa524QzC+oqjS6qMsuv5XcYS/pkoI17sPZNvw1/8=
X-Google-Smtp-Source: AGHT+IGEkbAWfNJHhJbzQPBOnqRB8jt9fgFm8Rft3ZFDTTXs5F+GU7kzJXRG5JI8pHmaR/qNDzGBhA==
X-Received: by 2002:a05:6830:3103:b0:71d:3fe2:2051 with SMTP id
 46e09a7af769-71e3ba26766mr6051708a34.22.1734321092658; 
 Sun, 15 Dec 2024 19:51:32 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a93a6d1sm1287493eaf.33.2024.12.15.19.51.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 19:51:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/24] hw/tricore: Remove empty Property lists
Date: Sun, 15 Dec 2024 21:50:52 -0600
Message-ID: <20241216035109.3486070-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216035109.3486070-1-richard.henderson@linaro.org>
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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


