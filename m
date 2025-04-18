Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD15CC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 00:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5ZxG-0001yG-5e; Thu, 17 Apr 2025 20:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5ZxE-0001wj-QO
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 20:51:40 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5ZxC-000608-W6
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 20:51:40 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so10936265e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 17:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744937497; x=1745542297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcN3OSzYH87XaR5VdWjr7Gc7b57JUTMWUSMgbSiV6+A=;
 b=FYCOtZ46YaXyt24K4JBYLDBH0FgMneKJ5OiqqLhhw5dW5yzIZOIBDciht9O9kVFpCT
 XnrYzQ0BcPzoPjncqgNcvHDpipmMMrcswFoqegXWCPsOCHIdbdIa80rX38mmSkSSabUX
 bj2X9nEkrhRMdft4yKMp8m2LBANaLLi1GADPjE4P2vdZBF8Ivx4yoL8KlJ65EqNu5vda
 feEBZsukvZrZyx+RFrlBR8pihITZb8hb77fwi++WSYua/foG7quNPDQcS5onDZ5UA0m0
 UW4MttSJOe8RI0SMy71GvTDCI8+P3Q1VBqA8weQEMW07ji1pPiGyvJQTjB8Kppd0CSFi
 TCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744937497; x=1745542297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HcN3OSzYH87XaR5VdWjr7Gc7b57JUTMWUSMgbSiV6+A=;
 b=bNR1znt3j4OZmmYOuR5DQiuA7dFhsiOqn5siF4MoGf7iZt1YtyAzDo33yNFrudgYZl
 5DNeQJryXzzAB4nGtnnBX9cDCFJovJqLQGkNJRz961EazLanOUnl+VLNyyW92m8vSObE
 v35YGS81pAvQz/QK5kU2Id/5jgVaPQLc4HQ5tcgkKMxqcxomJfo7u8rgk4Osn+i7cD8G
 9HEUGuoLBwvk/0wQ2bqdhES1LRjTdMB5ED9lqdhYOnURbsCe4+31PSroRjv1At1aB61q
 XE9KmWdOw14pmxTXlhOuf/VggRJA/82Sryu7pROAXgubrCEdITu5Jzt4C1XtGJ2PQMB5
 lOVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHP4AeWIrK2mw3PlugILwwTkvwhACo0uIvWaix6iYw2A+iviAbUPVvFeC3ZUAE8gZMhWAOzMS7XYoa@nongnu.org
X-Gm-Message-State: AOJu0YzgYl11fwa3hF1NeXB8W2g0s/VIiC38jp01C0SvO21n4q8YHDR9
 Chj8lPIVbMTHoyN1GHDUfkJIMScUvd0allg5vmRM56Rf70AAiWiYgLnV04SZrgI=
X-Gm-Gg: ASbGnctioe0617TQJETyN3zPaXgiOgjOqGbnbiE0axF/y7T7PN2+HZiJRxBwfrEFeXR
 0wXTWFChpuaMvRzfW+I1+QZJsXNs1Yrd5hUyWhfMH5juhuWrLMe+u1s2GBVKmMRkQgy/TbHrTCP
 HKem5n3U61X2Gl42KGo28Ee96+eE88UIDXhRxyxcfCysQkow7oNdZ/ahIl5er0j8M2LPlSUREyF
 YRlGR+gRXL4ft01NUjbYB4CVM/0dvWxRi0i4BT+F1ojS1nXp+w261+iBGrxTmeAWn4ZVHIiCc6m
 jx36+5buz0rLjYetxLWJl91+aYiyctZf/I0Ob2xXu+ijRcyPjH/UGCWIIkNxImhJkGC/D5ERNVr
 l/Vy3DBKuXccitCiarau0SuI2NVgnJ6Q=
X-Google-Smtp-Source: AGHT+IG0yw2/OpeoSXiMUPSQ2kRNwVDvWRW231w/OLeOkpGyhhNxZOWTdYBJgWdsIhCrf2wcbNeQRQ==
X-Received: by 2002:a05:600c:4e0b:b0:43a:ed4d:716c with SMTP id
 5b1f17b1804b1-4406ac0ef62mr5423695e9.22.1744937497566; 
 Thu, 17 Apr 2025 17:51:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa421c79sm1161834f8f.1.2025.04.17.17.51.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 17:51:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v2 07/11] hw/core: Allow ARM/Aarch64 binaries to use the
 'none' machine
Date: Fri, 18 Apr 2025 02:50:55 +0200
Message-ID: <20250418005059.4436-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418005059.4436-1-philmd@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_XBL=0.375, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When we'll start to use target_machine_interface_typename()
to filter machines for the ARM/Aarch64 binaries, the 'none'
machine will be filtered out. Register the proper interfaces
to keep it available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/null-machine.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 1ccaf652eb4..614b52dae0d 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -62,6 +62,11 @@ static const TypeInfo null_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("none"),
         .parent         = TYPE_MACHINE,
         .class_init     = null_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
-- 
2.47.1


