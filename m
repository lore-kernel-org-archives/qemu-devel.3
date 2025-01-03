Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F1CE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 23:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTqvf-0007gk-D2; Fri, 03 Jan 2025 18:18:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTqvV-0007fo-T9
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 18:17:59 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTqvT-0004Iz-Ty
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 18:17:57 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361c705434so92102605e9.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 15:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735946274; x=1736551074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQ9HwgRLAFrCzsuWk8e8Izv39QpUuV0vSTvePsKRUFM=;
 b=W2nDLA5SNwxYZ/UBHk/ajoIY9IdzF/kfk8MTe61Ja8UStwzeZ6j19SHUPZjxGc9NLr
 6dTxI8i+1aajNIyHzB/czADzileUyn7lVzDdPyno7VgHGPeB1OEkMNCOvsvCngJZCy14
 30pnPVyaRrJ8+DyCK0mfIaNNu5UJGZI2ozlhskTMOFePbElgXR1QedHDYl48Sxl4/1Gp
 uhwjltk7CDk9e7x//+d9oOvOOoQtONF0IVdi29FduiGqJF5DPHCIt67DYf3AWO4+UCn1
 3a1dGmnlQUEAAswd+5xQdFlR6duO3Gggo2OXjQkLvIX0BG9v8hT9cZ+RufnPa0WEE3oK
 Id3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735946274; x=1736551074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KQ9HwgRLAFrCzsuWk8e8Izv39QpUuV0vSTvePsKRUFM=;
 b=TukPnJscx1nsXvrQ3Kxji4r/CKjSBkTeNQNaamwPJzuwS6zLc3jGqIUzX3q9x6Z8kh
 /xrhQVid3OOCZVFSeInyTuAfKLfwYy8yVJYL9q16RJxQRZXfL7rBJTk2FJw/69IzQbnW
 yABYFR0vyjx6h8NDyr00UAHOf2zSgFo9SoABrvvLAHf8cLbuGkOLWpOPlBYKf1dlaonS
 +le8nge4ZpSy8XM+tK/6Wx9OxK23KpWF1crlP0uVei5Vh7G0ODBgPJ+4Dt2UapWtWhFK
 wi42nqh8MUd2jZZY8HlGZsIICIy1xMAsjDDCge8P+ANIMODvCaZRRQpLhYQ7EGUQxuNl
 hg0A==
X-Gm-Message-State: AOJu0YyG4RuplPMYogg2jBhFjU/gwgv8CNQZM8aP+pclARPyaEDN8IUZ
 6V8Hd13Ad/GV/6eVLquMrKPAiDruAw8XxvAAXUKtTo3IiotIaRLL4CHcvuc02Aw+OjzmrsqJBtB
 LcW8=
X-Gm-Gg: ASbGnctr1GfrOJ977cHCzRdZmTV5X/agPoZPWLQsB/6+T1hnN0gMzJeMmJUhZbSUxJs
 PtRBTA7JHgSv7fJQQx/uh+ge97VikiXDFMisnNRBCGcn+P3VFrr+GktmFq922nABT9zuqPYjxGH
 KHraytB/kgMJVc/RQA+Y0pdPJizCLwMVM3sZNZfGOJQyiU7E7hBZo1qXd2oxLcHz08tsuHRWuG5
 eGOJc8ipRdiVD8G0ljrOASLU2fwO0a0eH6N5Et6kTipiLrnS0oJLH9xd+xSfvjI7ctB3mqe0QC3
 37JqKDUROsaXEhMxh5JH65fc58+/lnc=
X-Google-Smtp-Source: AGHT+IFAV6gT5YUvR0CYotictyVJWWs95VMlxtnxV4uDIjz8ye/gRnbAl8nyVIUP2AV5HRuP6mwC5Q==
X-Received: by 2002:a05:600c:1c21:b0:435:194:3cdf with SMTP id
 5b1f17b1804b1-436686463ecmr429598835e9.19.1735946273859; 
 Fri, 03 Jan 2025 15:17:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b119ccsm529170185e9.24.2025.01.03.15.17.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jan 2025 15:17:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 2/6] target/hexagon: Add Kconfig file
Date: Sat,  4 Jan 2025 00:17:34 +0100
Message-ID: <20250103231738.65413-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103231738.65413-1-philmd@linaro.org>
References: <20250103231738.65413-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Keep the Hexagon target in line with others.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/Kconfig         | 1 +
 target/hexagon/Kconfig | 2 ++
 2 files changed, 3 insertions(+)
 create mode 100644 target/hexagon/Kconfig

diff --git a/target/Kconfig b/target/Kconfig
index d0c7b59d9c7..17cfb4648d2 100644
--- a/target/Kconfig
+++ b/target/Kconfig
@@ -1,6 +1,7 @@
 source alpha/Kconfig
 source arm/Kconfig
 source avr/Kconfig
+source hexagon/Kconfig
 source hppa/Kconfig
 source i386/Kconfig
 source loongarch/Kconfig
diff --git a/target/hexagon/Kconfig b/target/hexagon/Kconfig
new file mode 100644
index 00000000000..7e556f35063
--- /dev/null
+++ b/target/hexagon/Kconfig
@@ -0,0 +1,2 @@
+config HEXAGON
+    bool
-- 
2.47.1


