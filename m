Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512C3C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 09:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1NAm-0004it-4m; Mon, 29 Apr 2024 05:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1NAf-0004hv-97
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 05:19:39 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1NAb-0003Ge-SI
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 05:19:36 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41c7ac6f635so691665e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 02:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714382370; x=1714987170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQN2VxcIOLVMa1LnNXtGEPc0ePXAKKxeCQuVKvwbEdE=;
 b=CtodmkqRy+BGq8YF6UZkCbieRmi8fh2BkYIlVcukIabwNiCFDYsDl45DvokG8L0kUa
 XDLNPbRnPGKXTa945MQtR1isEd9pe71SyKnYM1UMIT6jWplRAsF4Ykf9Mj4oK1fdrsFj
 /m7VdfNz6d1vSBZzRgEzB6nGLgTy2pgXGsPesujudt6ydxorpubIc4s8Jqij7Y4OoX7n
 c1G3PvtEUIOVPuqQ1nwZ64cWYeUsXtQGcTK6+I7V8KS/AcvulqVHjg/KGjA9fGlPt8NH
 1JqD1tzR/jcDb7KIBpI188MZEh/KeY1jZ42+WfsDUXzc0DCGqO0R42kW4NTPM7GuvHBh
 pVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714382370; x=1714987170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQN2VxcIOLVMa1LnNXtGEPc0ePXAKKxeCQuVKvwbEdE=;
 b=Px2H4yZ5ybSx47NP1NzSLEWHIOvncMuqWDj+2R1fehZsTVWdt8pB8S0kopW/5F//vL
 Cv7/x4pb2HbciRYE/UhzxHiosHurJozP54AJ2BVRTCsJtpZViRWnf/23/4qxW3LROqKq
 dLG8ojsP/3O3eoFfsjDGCIOczaL81U6M/Ijq+M78Om/v7NFlpcoN/0asCCJ2yki2hHHz
 i9rW9/qqcQpjLE1YIF2k1Tch2flDomEY43jUBuy0B9pDwO024WEO7MLMy+ZMKF0hxg+P
 Qk5lt9PFY1gQkimK1BmXNStA9K4Bf3TyOxa7egDK/ye+skVXlFe9oindUswSo1CLpCfv
 eugg==
X-Gm-Message-State: AOJu0Yy7Ua5G5MSg6ATSBk0V9RkHlZSmZI4hOkD1NIHOfxKCCu1gRcfK
 WgLFug3f8ZU9VyDK6C97ZyopZ/9CA4Osd7BBDCu1N1Ry2P1CbWKo8KncJ0frhVN/B6IqImqawO2
 VTJ8=
X-Google-Smtp-Source: AGHT+IFUb8nnkBI6J6w+hR1tBSUkMCDkTNUaWuF0Tdbu7nO/tlUvbVaCwtKsiL1Gi84r4JHBjobHxg==
X-Received: by 2002:a05:600c:470e:b0:41b:f979:e19b with SMTP id
 v14-20020a05600c470e00b0041bf979e19bmr4381596wmo.39.1714382370256; 
 Mon, 29 Apr 2024 02:19:30 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 z18-20020a5d6412000000b00347ec0469b2sm28842076wru.46.2024.04.29.02.19.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Apr 2024 02:19:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] accel/nvmm: Fix NULL dereference in nvmm_init_vcpu()
Date: Mon, 29 Apr 2024 11:19:18 +0200
Message-ID: <20240429091918.27429-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240429091918.27429-1-philmd@linaro.org>
References: <20240429091918.27429-1-philmd@linaro.org>
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

When mechanically moving the @dirty field to AccelCPUState
in commit 79f1926b2d, we neglected cpu->accel is still NULL
when we want to dereference it.

Reported-by: Volker Rümelin <vr_qemu@t-online.de>
Suggested-by: Volker Rümelin <vr_qemu@t-online.de>
Fixes: 79f1926b2d ("accel/nvmm: Use accel-specific per-vcpu @dirty field")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/nvmm/nvmm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index f9cced53b3..65768aca03 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -982,7 +982,7 @@ nvmm_init_vcpu(CPUState *cpu)
         }
     }
 
-    cpu->accel->dirty = true;
+    qcpu->dirty = true;
     cpu->accel = qcpu;
 
     return 0;
-- 
2.41.0


