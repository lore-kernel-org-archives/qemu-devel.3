Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CC5E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 15:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSHrv-0000o1-Dj; Mon, 30 Dec 2024 10:39:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSHro-0000kf-Tw
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:39:43 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSHrm-0002zp-I3
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:39:40 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so93077495e9.1
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 07:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735573177; x=1736177977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ijdzLVVBAgy15w9QsQgpQp9PmP6CutR0mq7PZBrBXtE=;
 b=H+FjpBkXb2fVVeMGPj8zzIgM3x8fCnOOX6kmJ3Tk1JKpe/AHGAPqCA/qLRWjop6vlx
 3/+rMBH4RSGHwpI/r9xV90d59MtX6kc/wO+A9r74hCjOpBd3Jth8ot5RSr8CAZndU5qI
 wSx+1dx5u9aOhmlPXkeYwJYQGbm9rYGa9olCmu6i1UD7Nkyoy0y06QC0lVrE3+c8jwJP
 ulTaRsuGNnjvxjyeTtGcq4tW8ZhgnZIOY9FL3OlOzGywnAyj/umsgdmhj3+nSVSTtde9
 tEM1NoGAZApDQrn56crng05cXiW3uAOmOZ/rNZBWMt9VQr2x6ToNlQn8mFbqTf7kXxcA
 R1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735573177; x=1736177977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ijdzLVVBAgy15w9QsQgpQp9PmP6CutR0mq7PZBrBXtE=;
 b=uuTksaV1oxT8nYXEH0m+8vyrrORxvD0Oxk5fmHokN0baMacsE57aVaah/eTpXBhugD
 RItK4pcmGes0AnJSIl1XxCrRME+1ui0LP8DYf+4NTVGyEMCW2TjCEG5kFaO8dm5weRRa
 60dmw20B/MCbSqWip6ofijQDrYYHtfPoNVJVsjL1uF37BKPo23QnpMbewODrr2GuNisg
 3a3FVqBG2j8qn3DHqSUUGZ309Mt1QZwTxlQFJ4WqDkVHW3UM8qr4zOtuyIDayAH57KQw
 8pLISlkwh2qCQVpMrnwoOVQ7aOgs4E1kGhPAkKwHZkjvM0WOgq4cj76rNQbGsDl+Hcfr
 znaw==
X-Gm-Message-State: AOJu0YyYtUPJOnsr/PZ7P7PmoyjVbAYk6MUSaPvmg9/Yvz9aNmo0/PEp
 kq9Xemp35hYUbs/qYW7I+/ZubO3D/5Vni1hQuVBfKujhJhOmkK49nq/FSkCq2hgyum5XfjZFKNr
 E
X-Gm-Gg: ASbGnctPghpbi/YlU7jnfeF9HxpAnEZVMNttssgRxUNYTbEVXbZjRFAiZGtXVeZ5Sy7
 bppgVBbp4SEbVnWF/XL63jQ39ZZTi5Dw+1GfaL2bI7I2EKHosSjqoiNEjDJ6ZFYk5t9BC2LOKkB
 FIbX1BzgAtVjooM9v/PgrpD6dEv2zJFAWv2Ac5nt+Awq87Ix6xKiMkJF5uvJZoXYqqcXYq4rC8W
 iNImGWpjigMT4EuRLR4DVtS+E34FkxlJ+QHDO1AGnFTQltJIHxEs6bBeAbVGCw711Ew+4ybekzu
 PYiEch8aTFrsbmBd6e71/t12xuPPA4Q=
X-Google-Smtp-Source: AGHT+IGSLZCcNYat/M8hXt0S7RDlZdVbS8Acogt9FRZA+r5YmtA265TvrSX+fVdf836skQDlgD8t+w==
X-Received: by 2002:a05:600c:4510:b0:434:feb1:adbb with SMTP id
 5b1f17b1804b1-43668b76a08mr332642445e9.31.1735573176720; 
 Mon, 30 Dec 2024 07:39:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436612008casm360093335e9.14.2024.12.30.07.39.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Dec 2024 07:39:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Song Gao <gaosong@loongson.cn>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] accel/tcg: Remove pointless initialization of
 cflags_next_tb
Date: Mon, 30 Dec 2024 16:39:27 +0100
Message-ID: <20241230153929.87137-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230153929.87137-1-philmd@linaro.org>
References: <20241230153929.87137-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

cflags_next_tb is always re-initialized in the CPU Reset()
handler in cpu_common_reset_hold(), no need to initialize
it in cpu_common_initfn().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240427155714.53669-13-philmd@linaro.org>
---
 hw/core/cpu-common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 1edc16f65c8..10d34455a85 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -245,7 +245,6 @@ static void cpu_common_initfn(Object *obj)
     /* the default value is changed by qemu_init_vcpu() for system-mode */
     cpu->nr_cores = 1;
     cpu->nr_threads = 1;
-    cpu->cflags_next_tb = -1;
 
     /* allocate storage for thread info, initialise condition variables */
     cpu->thread = g_new0(QemuThread, 1);
-- 
2.47.1


