Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4981DC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 15:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg3YH-0000Xr-J6; Thu, 06 Feb 2025 10:12:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg3YF-0000W7-Dm
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:12:23 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg3YD-000141-Uf
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:12:23 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so10210475e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 07:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738854739; x=1739459539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hLhEoOyFDF+F7bcPTogQbyGAms0Psz74NYqAb/clUUs=;
 b=qgm+1LDfG3UStZruvs5BDwWEQ1DejSAfwY1E5NAnp7zPgh8HRMtSNKQeWJhCzU4TQb
 7PlNJcIPJkNelz1JF8t+3qgPdTLyBpXglaqAKsuwqdvYfhKv69jP8r4zU524PuKPo+ru
 Cm7SA3S7WVRppYSC/MFH1LOoM0iRu/2hAdIlSlTayipHXNirX2zd60YLNm+YRbOE34Fd
 JBFlE1RnXA8jrl/wnTyGKt1bANhSkk8h0HeF9UdzOAcFwV/7MuxkEKNSnp0mpITfeV4R
 fXyAyY3i4BcccTOkqBQtO0qT5AY0f4bPzspoaEwVvIWpSYP/VhcbttUbVKROAsLweI0e
 mmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738854739; x=1739459539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hLhEoOyFDF+F7bcPTogQbyGAms0Psz74NYqAb/clUUs=;
 b=svIKMYZiuAXXbQoF1Z3nwj3vzE7/k+e3Ko85FWe06i+GX81ntFkRomhRARhjX4NW3e
 AUzN5HOjTW0rs53hufJ/+XZ7mjk/BZkyHBF2ygrF8Ao1jzapRkxoKTkReDirrkV7k6Ga
 nizcLrz/xqlXs9U3SDrW8gy4ZIynLwOqZEZmC+QErRPlxx4aAhQfxqSTd1Jy2Ha2kgHk
 weu4x0r7P10WlnVeIqFE+oVjrH938IZlu3OghcrrIDGMAjnNjgBvP9qmlZDIppYXWnRM
 LOnffUp1q7yAc7WuLJRROTHaWyE3toa0/YGUKdpmtr8LxeVTTFQrwZ5TilbCUB4hTtA0
 etuA==
X-Gm-Message-State: AOJu0Yw2X0aFcUdGjUWlmXKjUCEyN0z9QDp9p/nP369s4HCTQhnGKQCn
 LTzoeJWOoWDz5oGv9imLWlM+ftymUvhPzifrcldFqQNRXCd44yQTC/EPXpDjNPZNBPD2OcISEeN
 C
X-Gm-Gg: ASbGncuASd3RJJ3VV2d9rs1JTVYva1M/wdSBBo7YhN8B+E1btYYaJT8+H1O8f8BcmaJ
 OkVbH8twDswA46qP/2aE8WC3B+nbIPNXJOLxMZyVUmQkwBT/Gj0Nual+FMJJqfY0R2D6YjF9LK5
 eXWjTOg7O80bSoPY40KqWnO1hQDLzrPeed+f6aCsv4tl2p7TmSUYlgVGbPP/N47oj0M4ZPb20KO
 VMmuXbfw637chC5ZU1fdJegStuWHLLt4bWOe5oc/rwOZxpmS4QFu538/HUeeFtIwmQY60CrEP9X
 1AZE0ruAORJBQOk4djD2Ag==
X-Google-Smtp-Source: AGHT+IFNiiluCcBcvn5wfBpGsV6qswWaBJ5R2BTekarhWsuYsZfyFDcuckwhxD96VmFl/4PtH27vrQ==
X-Received: by 2002:a05:600c:4f8b:b0:436:469f:2210 with SMTP id
 5b1f17b1804b1-4390d42d7efmr49857045e9.1.1738854739471; 
 Thu, 06 Feb 2025 07:12:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391d5283b2sm23591535e9.0.2025.02.06.07.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 07:12:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jia Liu <proljc@gmail.com>
Subject: [PATCH 3/6] hw/mips/boston: Check for error return from
 boston_fdt_filter()
Date: Thu,  6 Feb 2025 15:12:11 +0000
Message-Id: <20250206151214.2947842-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206151214.2947842-1-peter.maydell@linaro.org>
References: <20250206151214.2947842-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

The function boston_fdt_filter() can return NULL on errors (in which
case it will print an error message).  When we call this from the
non-FIT-image codepath, we aren't checking the return value, so we
will plough on with a NULL pointer, and segfault in fdt_totalsize().
Check for errors here.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/mips/boston.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 364c328032a..f0e9a2461a0 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -810,6 +810,10 @@ static void boston_mach_init(MachineState *machine)
 
             dtb_load_data = boston_fdt_filter(s, dtb_file_data,
                                               NULL, &dtb_vaddr);
+            if (!dtb_load_data) {
+                /* boston_fdt_filter() already printed the error for us */
+                exit(1);
+            }
 
             /* Calculate real fdt size after filter */
             dt_size = fdt_totalsize(dtb_load_data);
-- 
2.34.1


