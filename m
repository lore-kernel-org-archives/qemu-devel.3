Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E4DC77B7C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk5v-0003nf-K0; Fri, 20 Jun 2025 18:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfaY-0007p9-41
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:31:43 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfaW-0006WU-E6
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:31:41 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a375e72473so1020738f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440698; x=1751045498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JZclnTaDZFg6r1Aoj3yhjSkf0bRe+K8pRv4Ydn/ndNI=;
 b=bXXcywhsYOOGYLu3f6xVDokpyLDSdmt8SA6/AE05yMUgM1tIWXH05byWi60popFzdk
 fwumYl2JKwA6hyi6RjywpAmbUj3CROYvhfv2gk2VoScYgksnid9nXiIDcbWMK92Cq35x
 OtVjQzyzShnoTVirv44NVgm0Cd73FH2yWJ9pzcymrKWuJhmKM+PxX6/5vTz8/T2Q8T9z
 TnTiXaz26q57RlYxMceB5cA952a9GHYPb5Cf80/JahmEaphTagtmUVzbtKQziagPRXkg
 TLp4r105boTKUieI5y1f0jmNlkbO2vuKZxv/+Rn669LSKEkaHmB61rz3b+uZOe+4aDqn
 cPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440698; x=1751045498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JZclnTaDZFg6r1Aoj3yhjSkf0bRe+K8pRv4Ydn/ndNI=;
 b=OucYCJK0oDSa4wO/bUit1qPTSnZ9iXw65w7GXRFqOLh5vV7r0YVorjuVXjMdFrRNda
 SWxumfzVK/Dd/FEtqKgYV8f2TFHJXHUJtAQYeAYICJy1MqNTgr9WIUl3eaaZEdPP1VxO
 tF0TDDQJR4NvlJkuFMJDcRs4tP8DrB2OYyVaahvRGqVOmsLFTKYnM7DG3LRwF+g5MFtK
 1+gD+02ysznFkI2Ls2IYLUucs9Xme0/tBBMlpWQ+DPvvHsIP8B+oD0GkNfSwJV29jN4j
 hq7dfNgVOc+EKV91TwEIX0O2j7J3ztL+w5vj9xCJniozFH6LYJpBgfMvARC36gmiNjW8
 BhDw==
X-Gm-Message-State: AOJu0YwkZHBMyOIMxPQ8HKk3O2xZD/aVg84aXO1DUjWdo6hQ4X6+wK1q
 /15WLKHm42B4unvAegczMgNemCQet9y/qr6vIvzD2+wmFExG3AIAjb5B0xiN4XmoaE/jEZ/jlUv
 sTN+/7T2ULA==
X-Gm-Gg: ASbGnctnBx0ev4h4YIUTwE1kdBodY8X4Ok1Yr9fJ/qSFW+m3T1/EoS8fw2lggxwT6h4
 Vvh3MmFYkxJWw7R9j3u/NcgXR14vtZp7oEKEhHhiCzYA0a8frhspzLw9XNRLtTW7O4EG/EB5r/h
 tIUpjEom+UGO2uG9NuFwUGBSroPLN8dnjXYcWCPsnXmnjcnRJnMK8jLn974YcsuSWylgYjR4W12
 WPuxT7UWNclmxJEW4AwMtSJaiuw6Vjcpp8APWq3TTCWd45XOWIGesYrLkAlRszJKfeIiP17Gro7
 3LZvMvEiHO/NVntZ8jnSRUKPqENXxDYjhPAGRpmeCiBflkuU1U27k/wwlizwphxXQdaYuy/9LUw
 CXiiPS2QvuOBTNPvJ+ipM4MBUygunRk5STyLD7GWScvX7LbuIP8a7Yje3
X-Google-Smtp-Source: AGHT+IGTs2Hq93jZUWnAmXk0CY1zDihl2muD+p0ZrS+pLKW7Zulno9pT99U734OXKW/stvxnW444YA==
X-Received: by 2002:a05:6000:18a8:b0:3a4:cfbf:51a0 with SMTP id
 ffacd0b85a97d-3a6d12a27b4mr3772674f8f.21.1750440697658; 
 Fri, 20 Jun 2025 10:31:37 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1188139sm2549029f8f.73.2025.06.20.10.31.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:31:37 -0700 (PDT)
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
Subject: [RFC PATCH RESEND 25/42] accel/split: Empty ops_init()
Date: Fri, 20 Jun 2025 19:27:33 +0200
Message-ID: <20250620172751.94231-26-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
 accel/split/split-accel-ops.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
index 5a36e22f205..375821f1064 100644
--- a/accel/split/split-accel-ops.c
+++ b/accel/split/split-accel-ops.c
@@ -124,11 +124,6 @@ static void *split_cpu_thread_routine(void *arg)
     return NULL;
 }
 
-static void split_ops_init(AccelClass *ac)
-{
-    g_assert_not_reached();
-}
-
 static bool split_cpu_common_realize(CPUState *cpu, Error **errp)
 {
     AccelState *as = current_accel();
@@ -306,7 +301,6 @@ static void split_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
-    ops->ops_init = split_ops_init;
     ops->cpu_common_realize = split_cpu_common_realize;
     ops->cpu_common_unrealize = split_cpu_common_unrealize;
     ops->cpu_reset_hold = split_cpu_reset_hold;
-- 
2.49.0


