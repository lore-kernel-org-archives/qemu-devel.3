Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7E9C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 13:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyZM-0008Ld-9n; Tue, 10 Jun 2025 08:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyXs-0006s9-6Z
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:40 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyXq-0002eX-9j
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:39 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45305c280a3so9663725e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749560255; x=1750165055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8T1V36v8wKP/BAz1gGD+Xad///zXpxrmTwUCr9UV/II=;
 b=XBu8lyybs2/KKFcY5nEYlnij/fKrOspIPrY+P2TsN+/J24SlhE6mIVAARma9F5wIgf
 Gtgnc8+ESsY0Iz7QdKA8pZoVAu7TDgFP/CQRMCH6Ip1xtv7MYYy2sUVpRl9MOrBT7ifD
 Ox+Dz8WgChRP2HDHdLnBidBLrV72b3TmZzWMYRfW1uRM3ht6dSI8H7Cng9OM6NebNCGm
 r5pE7q9Wfp4P+mE2cztmzaYZr7qsJD8BNvn53e+HZNHOrh4/aZFFQ+5UKnks1rGByysh
 EuZQZXCFuzcxizwLCkf3DuGqxBZdm60lK/QuK6R8GBvgT4J0HfAZ6xd4jHx5ha+kr2Ou
 K0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560255; x=1750165055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8T1V36v8wKP/BAz1gGD+Xad///zXpxrmTwUCr9UV/II=;
 b=vdkqJFCLXY2od7QnT2j5m9t8PIls+Pc/V8Yw91qVxPnzb4GYvkRBH+oPtwjeSPRsJo
 L5XG3RRQAf5WDYk29vOhOSJwn+6rmeA6oPwOb3Ow3slu/E9DBNumK+nywYF4j0EWJs+2
 yKnFTpaUNb82anWMLVM/+Ieu2E4/svL30ZDdPcR5BqcWXGPg6Oh1ASOCEgM7KD1EorTp
 LwviZbEi/UWDYPL2Pzt6EAqX+miu+GM96+caVmvUMqr9++bUoBN4qQD34EaaU6SKuEX2
 R/zpcPqRi3kPJ9FNsubmJLhCoDF4DMC5Q2Gk/rsg7Zm3xRBikPxmLitEk/llwcFYjBtL
 GoTA==
X-Gm-Message-State: AOJu0YyNX/h1H0evYBhpo2Ey3AJ+Phke4y6OKkt0qtxn4PPhpUMlu5FF
 aLqTv/vFCRtOMiDHJLgbeYqai0Z3CQMssK1Jqd6c3aNaXjE20u40kI76UQwaaronNTh20SMhK/8
 FF8RAsbI=
X-Gm-Gg: ASbGncuNMHyoWmuCL8/MLCEA963lprZ5QPko/+aW9WlAnLKJrBjEyoTvAGXvU6fqg/m
 aZYaSxguxKs91jmD04Mh8Tn9W6+8bshq+jl5CetHXd99uHScKqnuJ1rdRaOGH31xD3Nm5AL6xUg
 bnIB4FaL7UaqusQuMswvJ+G4dVbTrgEGPmexxlHFdro0OwgADKByLTCIuFMoaZWIXkPz8mLoEUn
 yKaDc6BrSSAWQb4devITgBvK7iurEzRJLLNcTrO0XalWNucdI5iGl7Ox/h+aYEIdPJWKuuY2TpF
 OQqoZubCddDYijbMEAGgb/7pDg8UccRS9PFyPh3WSP4t29yv5eRa3fQdhMpGRnyyQdK1hNwmdZ+
 6J4tE8Fn+UmN9xlcWcDux55XhKafN8pt6fW3QobvAzg==
X-Google-Smtp-Source: AGHT+IEM9R3aOBN7bpwDcyH+VELdNiSjRcqI+UXLkLTYhF7O6qEqL3oheW9+hiGoGXMMelB9klgteA==
X-Received: by 2002:a05:600c:1d86:b0:443:48:66d2 with SMTP id
 5b1f17b1804b1-452013ab8e3mr191485635e9.16.1749560254978; 
 Tue, 10 Jun 2025 05:57:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229e009sm12603364f8f.16.2025.06.10.05.57.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Jun 2025 05:57:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/24] accel/hvf: Fix TYPE_HVF_ACCEL instance size
Date: Tue, 10 Jun 2025 14:56:22 +0200
Message-ID: <20250610125633.24411-14-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125633.24411-1-philmd@linaro.org>
References: <20250610125633.24411-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Fixes: c97d6d2cdf9 ("i386: hvf: add code base from Google repo")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250606164418.98655-7-philmd@linaro.org>
---
 include/system/hvf_int.h  | 1 +
 accel/hvf/hvf-accel-ops.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 8c8b84012d9..d774e58df91 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -44,6 +44,7 @@ typedef struct hvf_vcpu_caps {
 
 struct HVFState {
     AccelState parent;
+
     hvf_slot slots[32];
     int num_slots;
 
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index b8b6116bc84..d60446b85b8 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -366,6 +366,7 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
 static const TypeInfo hvf_accel_type = {
     .name = TYPE_HVF_ACCEL,
     .parent = TYPE_ACCEL,
+    .instance_size = sizeof(HVFState),
     .class_init = hvf_accel_class_init,
 };
 
-- 
2.49.0


