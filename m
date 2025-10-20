Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C394ACCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAyEu-0004tt-VZ; Mon, 20 Oct 2025 18:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAyEt-0004ta-GZ
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:20:27 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAyEr-0007Tf-D4
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:20:27 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47495477241so1774855e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760998823; x=1761603623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8808EUNcwke3TPhY+Qw/CQoqBF5kKU0jpneGQtl261k=;
 b=VFeoaxiGtz+EFhdf0CtkK3k96MBZ8jNcP1GGtJeIsKDjLz4A/7SXvimQH5MvDFsilR
 yMTEbtlfmbsec0hibHZ5781J+IZW0uxN1vwYZdzNt8aHJrJRaHnb0yx6HrRH2HTEFbkW
 ynR14bZEIRb5zU/QhpDno0SdHQ/BcuSpfAA1gVouiuDK8JIMDPkXNThcOmHg+n3wOL/s
 FIqytOU5KbhfThskMqPV4ZQvIZL/Fmy7c5sfnqSewKShDKrE768oAANN9cB7wdrY3Xl4
 AZDKnSBydNY1vRtnNAU+f7UbE8lw3GLftzEwSBgd/4FTaw8B2n3FePGfBFAqqLGMIGsM
 C0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998823; x=1761603623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8808EUNcwke3TPhY+Qw/CQoqBF5kKU0jpneGQtl261k=;
 b=D/c0jRFWtGNUKihCJY57/5OD67RZVSyhewkosPbzXT1g6JotdK3fVOmNK7LgPLm2gS
 rQHp6VaBtBIX3H23dVWOHFpH/ae/gaN/4qKX63oObnO6KsGqqjpKs6W38u74oMvywSvR
 HkcythK5X+B94HRpbd04xUHbWBTwLkJNot+P2pgg9kPZiUdROE6CufGCTUWbjxzM4w+U
 Y0WPQ6CIbPyxbrNUSpxgHIammCOVNEbR8JOrPNisDy9uUWHdyeLuPGVzekGljMIzjwI8
 2BYaqk6gU4Ai4jO5fI6lGh352sJ4Th3TCl9TqJas5f0iCXpkuUD+FK9fnEETsQ656Nfi
 xv8w==
X-Gm-Message-State: AOJu0YycocfdGhwCU83xQRSoYMAinlYNDANVCGo+7XH/3eG8Tk03xSUI
 6I17cc5BSkN5oUB8SLEbOTR0DIwrQph7AlwCHiCe9Ta/0sSGWnXhhZr03FUsntqC1PVXFjMcOPc
 ClRUelEc=
X-Gm-Gg: ASbGnctAlzu2yHqrTurILfkMd5cyc1WS7fcEP5sZG/XgIHhoh7wJQJKNFw3yzJZNVpM
 kFTuErYYI/vQmVd2Nx0bp7760SRUnGDyzJsqFAIUNIEukhO7UE9Pmtn6KUd6PaNHCJNP7GTENVg
 jDpM+mScIAPSk0YKG+ps0+ZGF+AqH7Byqx2uK3PcwFrEi/oe+Cv6WOulwnKbsye2qB4YVlLccJz
 pP4v5BBEyYvXvWmJkTonaoVUuT4ZEqvs5gn9HoSxnoZlJR1z49eiOtaqfnhe2NzScaoo6lbnCqQ
 yjk6UP/4k8EqNcGSZQq1p+AiretF84pZHjVG2ePzZkJj7yWjehHNte/xmH26HFgs6QtWragHdfa
 Yxalus+NbuM+d/hEr+ETxJkbG8v7VxJOn4b0MzEc0P3zDj1V0msoQqNhPDej2+YyDRKRqQnd+ZK
 BTs0bjq0ABtZhnQ1/7r6lJiWcXfP72j/vPikUc1egu16OcUR5V7sMHMg9GptLgrtNIFPgkd5c=
X-Google-Smtp-Source: AGHT+IES2T8m0f8ghyEV4xRpbbyRCuMU/+ixyjUD/tTpsKc6pOeHIflwLfTm5Zg6+gIWreLNBXxCxg==
X-Received: by 2002:a05:600c:4748:b0:471:12c2:201b with SMTP id
 5b1f17b1804b1-4711791c503mr95830615e9.27.1760998823429; 
 Mon, 20 Oct 2025 15:20:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-474949dd479sm5098315e9.0.2025.10.20.15.20.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 15:20:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Luc Michel <luc.michel@amd.com>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v6 27/30] hw/arm/virt-acpi-build: Build only once
Date: Tue, 21 Oct 2025 00:20:07 +0200
Message-ID: <20251020222010.68708-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020220941.65269-1-philmd@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Previous commits removed the target-specificities,
we can now move virt-acpi-build.c to arm_common_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index fbd5e8da79c..4dfc7813191 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -1,7 +1,7 @@
 arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
-arm_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
+arm_common_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
 arm_common_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic_boards.c'))
 arm_common_ss.add(when: 'CONFIG_EMCRAFT_SF2', if_true: files('msf2-som.c'))
 arm_common_ss.add(when: 'CONFIG_HIGHBANK', if_true: files('highbank.c'))
-- 
2.51.0


