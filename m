Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5B7CCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 21:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJWV-0006g0-0L; Tue, 21 Oct 2025 17:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJVu-0006Wr-TI
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:03:29 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJVs-00032C-O9
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:03:26 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-471b80b994bso43204585e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 14:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761080602; x=1761685402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJ3ixfClpg8mA00v0V9RN1om183YDcGw634WpNvfvI8=;
 b=y44QMRwxuy6i/Dgx1FNqiRG9etI+bZZFNveEjFDu+7+2TQNz9zwWNwtmUhgYtbPOiN
 uEYkDhFbcpJZDipTXrmB1jYxLzQKm9viwq9czEpD2t8sHhh6VngL9orX/e2vh1V0OU99
 T325VNcH9ejlnG0l8K2OuYVdmrr+cp8K88G/1BMOEmDF9B2af6FJd41NlI9PGjGPBapR
 pVAAdxaJElPYn6D1rdrwrLl1eO7Lo4mAL6Sb3O+9x/X6Ilk8mjpC5J0szls47x72iYNg
 3xEjDSPBTzJkS6RK1eJvyc7Fx8S0lppxMbMv10kN4glR5aWtB4mFP6BBLHAX/j0vPVS2
 NJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761080602; x=1761685402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JJ3ixfClpg8mA00v0V9RN1om183YDcGw634WpNvfvI8=;
 b=s6Zc1F2mSvlQ8fOLnoLqP0wF9kG8YGUqVyW/NTCLbyRrj8LV0OfgVKLuNBqbKPHLXk
 AkVkr9hhr9JdZ+z7csKh3E6pDLCWi20sOiYBqgYJrlpggXuxXal+EwFWP7u+OM2q9FUZ
 qACxZvYdr0DthRHHPTZ0qF06QvnftPFkiMLFcn+mmWusN/XdJkChUbxiRXDiG8luZyFQ
 v2h6IhY2wKS7LXSmb6gOqjqZVBVqGERUNDg0MosRqZdjD3tm92sRJ645flXCfw3tWDYi
 t+sDe/2ZAQFeAKe7GFcuOgpYJu5yo7EDHYkaOSC6YGTAZewBfyCVlKuNlFi4I8r9gGUs
 6kJw==
X-Gm-Message-State: AOJu0YxBmhOZLv8oCDvwCzSG64i333k3Hf6o2jSHRynEOJE3s6g90Luj
 L8LbPVBFv0Pf+AUTM63xXQBizAxXuR7Z2ZnwXhW1Y8A4QbT7cTEycq9miHnftJm1kUCUh9Fkhk1
 dGJcjIVU=
X-Gm-Gg: ASbGncs9P+vLcE9hRm3ljUet1cFudHR9n7N9mgvZUn0by7BVTo+GNTiqY8gWtrk2t4i
 o6wvzjykm/aEju+ePoP+PmcUKiBLuuP2jg5jisnAQf2nzveprP774nH3rQg3HhfxKrCu+tjEEad
 dNIsE/Q0r4N7LP/uJ6p3QGrHHsZY6gPT8JQWKCYWMaUHra0UH4x1xifmySrtrdTmCF0USwTroJl
 lJWQxz1ZQJ9d3MRyL29jYfPOoYqZsrKIRtOtSnAAyQl73SilOttWR1QlWtfPorrjdyiCNcxMcMQ
 XZ/O/sI85KyLbyQ6djScx6bfQ9NTy5yYFRzsyvFtGmA+4ivuwuASaL8gVbjKVox7JxjIRbbp2E7
 EM6LoLUE5uH7GaT56cDlYdwFpd1Nc/SbW1sxvYlj1UqsGFj+k6ZF1HrLkeRGj1lqC2MFIcbx0jZ
 CLfsBNWbL77K4k+i+QMYZ5n3xQctDB1uR5AuxjaHwSPGYZ50RBO2Rr+gpagLZH
X-Google-Smtp-Source: AGHT+IGOJ1cHOBGtyG4jOMNDRNFiIU1lBxvwITh6/0NB7YbTNx7z9/jfUGKw3EgM1s9MSiFBWMBHNA==
X-Received: by 2002:a05:600c:8b0c:b0:471:15df:9fcd with SMTP id
 5b1f17b1804b1-47117911c51mr140610065e9.25.1761080601735; 
 Tue, 21 Oct 2025 14:03:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496d23237sm23027555e9.10.2025.10.21.14.03.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 14:03:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 17/19] hw/arm/virt-acpi-build: Build only once
Date: Tue, 21 Oct 2025 23:01:41 +0200
Message-ID: <20251021210144.58108-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021205741.57109-1-philmd@linaro.org>
References: <20251021205741.57109-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Previous commits removed the target-specificities,
we can now move virt-acpi-build.c to arm_common_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 531a635936a..df4c1be3b3b 100644
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


