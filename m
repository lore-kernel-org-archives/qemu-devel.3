Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82D5E6ADCB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 22:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEcVc-0005ma-E1; Fri, 22 Nov 2024 17:52:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVa-0005kb-40
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:14 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVY-0003k1-Hs
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:13 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-724f41d550cso14411b3a.2
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 14:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732315931; x=1732920731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jh2KAOoXCu+5HX1Ub1qOT8gx+CtOclpTuzbQi0PzGg4=;
 b=RPJACEURXfd3jy+BSXOchv9Au+ZkNeWRDBHnrApOpt134EkAZuFh9zOElRUKi+Kko7
 eSs6/HHK9cZYSe5rxsEC7xQj6U2eIOo7/9SKkt9bYVxqZ6fepfFSdw6K8Por+7RYYHiU
 XFia3YXlYJn3Gi6gi0pvf3FTdc2ywqJkgZBWlcOv3PCBwVl6JeybPlCrDO/jIBUgeaaO
 /JAGyQjLay9jTKU9G+HzJi/5VZc2IJ2egDvR3e4aEb/47PToAz8Zx5FzJOrOqjwArXoS
 goEC341KVwI4s9k9bLsb30MSA/XWQ83gdX/lnqrL7pk+u/H0R8mIaycx1kVWWL8lIO1g
 8Ouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732315931; x=1732920731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jh2KAOoXCu+5HX1Ub1qOT8gx+CtOclpTuzbQi0PzGg4=;
 b=Ku/SuURgJ0yFRXBPn5zttEIhxntpR/9zKWn4PqIz72wjq7mc+CpcDfMGpjX9i2GM0s
 YeMB6Qn5bmRy7kHmp7YW8ipfotmFH40YhvZ9duWA7hjs1UrvVpt8i/httSoF+SYXwhMR
 taIyYc50nU/DmJ5l790xNrmezuWdNLtfGBNXi3zcQqe7dY4LuBaJskE6ksAW5VgUzoFJ
 JidUkif4AgqS1ohQWn3DUgUo1p4Jd5JG5YPSgTB9XSY7SCrLN7R6QrHlbDFmmp+M6PTw
 PBnJHsEjrRSZgaol9x97WgFqZWrURP+uK9hoJHVz60cgUucatLePtiDGIQBqsGKOMrZY
 zmng==
X-Gm-Message-State: AOJu0YwPSbPuBY7k6AcBXB5JulLjNJ4DjeriKyD/xcwQt32QnMnAQ4Fe
 H7kntph/SufONxnw+1bf42Bo0IZFUXuUUwNfXQ1qYKnUfdbuTBzNNvmMDUlnYJtA9IaNkQWarCI
 1
X-Gm-Gg: ASbGncsMgIuI9jaiE1aS2Rpw7sL+jCTz1znKgDEfjRwLQ/LV2WTMOOleGEkNowHiH6K
 1fSgiXnMoVpv26C7TYdeQ217ertV+KkW3UTv33y0ugMmSplU0wDZzYvLDnRSH69ATJGhsS4xlkX
 uiStHegCZgCQjjrSOFWnLiyAKVedCv+iAKyIQOvUu6IVsPsDfc8mUhGaE2Sltmxa5lTVs3CNKU3
 NwFrRnK6/p8ruazPXbBwMOV4/TP+Xs3elab43CLYxCW/BCqi/CfYPG/8FDypY6bHwKAOgX9uD6A
 togjhPZkUuicPg==
X-Google-Smtp-Source: AGHT+IEStFLEesM8Tyny8zetwIImMe0p2S2LbXrloI6mTqNFP2JV71CJkaDyZ5xgR6NMmGCl+BTq1w==
X-Received: by 2002:a17:902:f78f:b0:212:4835:10a with SMTP id
 d9443c01a7336-2129f24ca1dmr68367355ad.34.1732315930828; 
 Fri, 22 Nov 2024 14:52:10 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc1539fsm21450335ad.192.2024.11.22.14.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 14:52:10 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 07/12] docs/system/arm/fby35: update link to product page
Date: Fri, 22 Nov 2024 14:50:44 -0800
Message-Id: <20241122225049.1617774-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/system/arm/fby35.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/arm/fby35.rst b/docs/system/arm/fby35.rst
index 742b887d44c..bf6da6baa2a 100644
--- a/docs/system/arm/fby35.rst
+++ b/docs/system/arm/fby35.rst
@@ -12,7 +12,7 @@ include various compute accelerators (video, inferencing, etc). At the moment,
 only the first server slot's BIC is included.
 
 Yosemite v3.5 is itself a sled which fits into a 40U chassis, and 3 sleds
-can be fit into a chassis. See `here <https://www.opencompute.org/products/423/wiwynn-yosemite-v3-server>`__
+can be fit into a chassis. See `here <https://www.opencompute.org/products-chiplets/237/wiwynn-yosemite-v3-server>`__
 for an example.
 
 In this generation, the BMC is an AST2600 and each BIC is an AST1030. The BMC
-- 
2.39.5


