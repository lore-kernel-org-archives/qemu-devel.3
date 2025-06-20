Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DAEC7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk3j-0000be-E0; Fri, 20 Jun 2025 18:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfYx-0007JI-7S
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:30:07 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfYq-00061A-Vy
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:30:02 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so16798685e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440595; x=1751045395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vThCFLHwdX0jozfNEMhw80T1SRG5zycaGSit+lftu24=;
 b=Fh0Nw7Xb+cDSTozx6PgL1HQ/f384qCfbHgJJ0Zj+lVSqFoaPro8nlYEAHoDodoS2aT
 psHj4rI69uYi/WPycu7bgNko0/FAXIVwnWPHWFsqJnkYslLD/IN/Pk5P5TGbWo4l2I4m
 tIHDTT9SPmIeKzdNtxVRLDztmxjqLGDLpNo4fNczAIu6UXLuFTo0khRdXDc40LmkWAN6
 YXN5ir/vuMwMJKM0QZr4xNVwKSDm86aA0xFBp4x+Du1h9cdPwrIfsV98XqwBwJLeI6mk
 e2ITwS0/5KeAgTTBo0AU0ceFs8igyFgNV60iUdMyMIDXXNb614qemJRBs//zfETjYev0
 Egog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440595; x=1751045395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vThCFLHwdX0jozfNEMhw80T1SRG5zycaGSit+lftu24=;
 b=mUNZ/l66gYEukZVUTq8RHfGmQy1n6aFuwdJ6l59Wy/hy6RSWESIvO5rWk1Knmv4Oja
 fBNbEv+FY5tlBSN+Vxld4bmwRfzjxHzdABnV6ke7+7AI4l7R+zdwU175kbl36MpdrvCs
 NWYV9V6W1tCraiuC1QGSgEtG8DnoleU/+sJ11vktkk2786tTnC1nb0lk/JH17NXCqqDK
 2ZW5mA4I2WMF1/5WLMDqotYgIr41y6ynybCNabyBsj6QVJie3ZBo9XXIjrPdhXpoFrz2
 n9DvBLvwYwmpLP4vt4/WlOsxGH3RChzGfXPCqBh3xSix8ym8dnkQ0rHiYj8To0MGFsw1
 aBJw==
X-Gm-Message-State: AOJu0YynnEkoA+QMEnbdj+1Voq77Kg/CggUjpnReyKUwrw2Z1wuhbADa
 lbvksvOuTEmN0OtDRlwskaT0Tg8isG3X20z6sjTqJgajgjNzwTzguQ/l5xvlKG3dbv6/uhwpPkb
 cnuuGUSwlIw==
X-Gm-Gg: ASbGncuG8Lca2FPYYRd61Icj5Oqm/b+Y92WX/Bc82SpxZQxMtjvXwCmHNBMFcVOOAKL
 jaiYQnKVDNPYUsG5Ae7YT45mWqhs89+m6WM5H5N20kPzvNRMVoC+mn07spR8NvoPVTRCetbzshT
 nkg0DLPRmJnVkguRmHtAocoh4kWJmcBkTE6qqZwyXTXXD5+RRtVEuvy9ZAPxtj/a2Za+jRLgU6x
 aNnxGaEKDam+G+rUbqTEz0tUV9jdTb+kxCOiE6NKSUagc9NGGK7kdHf82fwk50bo9Jf3LVS3ue8
 9af7fg83QO/M6ZSEapywWpvgnkDEurM2GjjwYLjwMpUrEsxT07NAUPqVHnhgED2Gwr3bZaXE7XO
 dhuuoChfLuInisnKX3ZsSx3rRwwCUov7wgZonlOdyUi0YsjalDpsH/Z4U
X-Google-Smtp-Source: AGHT+IFD6wcbe0inptceaX4+HnEDtMHMHmK8Q70KSUWQHISNCSdYxtoH5BeEBhHQltTUTpQr4/a4hg==
X-Received: by 2002:a05:600c:5026:b0:43e:afca:808f with SMTP id
 5b1f17b1804b1-453657bfb1dmr41591125e9.31.1750440594991; 
 Fri, 20 Jun 2025 10:29:54 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1189977sm2531875f8f.82.2025.06.20.10.29.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:29:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 15/42] accel/split: Implement
 synchronize_pre_resume()
Date: Fri, 20 Jun 2025 19:27:23 +0200
Message-ID: <20250620172751.94231-16-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/split/split-accel-ops.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
index 6b3ddf21a17..65feb929404 100644
--- a/accel/split/split-accel-ops.c
+++ b/accel/split/split-accel-ops.c
@@ -175,7 +175,17 @@ static void split_synchronize_pre_loadvm(CPUState *cpu)
 
 static void split_synchronize_pre_resume(bool step_pending)
 {
-    g_assert_not_reached();
+    AccelState *as = current_accel();
+    SplitAccelState *sas = SPLIT_ACCEL(as);
+    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
+    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
+
+    if (hwc->ops->synchronize_pre_resume) {
+        hwc->ops->synchronize_pre_resume(step_pending);
+    }
+    if (swc->ops->synchronize_pre_resume) {
+        swc->ops->synchronize_pre_resume(step_pending);
+    }
 }
 
 static void split_handle_interrupt(CPUState *cpu, int mask)
-- 
2.49.0


