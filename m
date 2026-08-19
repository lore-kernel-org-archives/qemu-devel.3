Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A4DC5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 18:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwlQu-0005Vf-RQ; Wed, 19 Aug 2026 14:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wwlQs-0005UK-I3
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:54:38 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wwlQq-0007Na-87
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:54:38 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49978908b35so9744875e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 11:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787165675; x=1787770475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xy6npAxreR3WN5RNBLJXXOS1U38mC2qbi1jMTA5TtLk=;
 b=LNDAujTlAO8PBQrNjHqX26kU8pygtu/IwqUa5tPV6kUvwStTwoA1HDSSh2oz0MNsz0
 HVhvDZgheScXqMViF6qimg1qnYAU8wUGkvmWO3rONyNILA8COTi2Z5bOJyEaonEv/4ci
 Ymq3Xj7PmQ1NzwB+glqWbtbOzeHSKUASGR2qw6056MI5MSPc5mn5J4uRzAektG7rsnrS
 Qcgx3hH4CuoJ6lkKv1KRjl4MjvddlfqUz6Jsh6y9ShIu9QGpxLLfo4s/gmOvZgv0rP4t
 Go0xYQ0ity+HeijVSCAmEd54Z0QlG5E1jaQsaS0Bi12Svu1rCppqyIpYeAFFWQWV00/j
 wqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787165675; x=1787770475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xy6npAxreR3WN5RNBLJXXOS1U38mC2qbi1jMTA5TtLk=;
 b=DU/IzlYVdLrGSoy9H3goOafr49/v+Rct2HThupsWmkvvRGjU1vRkEztZjQq2WH5iz6
 KEvkBh46AE9Y8ThLY5P0gdDoxuNozxuLijkBt0wm6rjpHTj4epRVYmnmsvbj/+iX5fAQ
 h8pqZRX6i0X6SPT/xOOvsudX0GIXhC/4zB2ESMnb/LCkS33jOkua4KIQUymuHrPF7KXX
 0JKC2M8ttTiEtGuQToRLPSQn6W3T1RlqmzLj51m37YGMPT/mXBhpftHeap+ylqxVs2wz
 kvAtF3vVXTFnN2TvzT1cOEOwtTZHjWOBbpZzNfLhB97DOiAp0I+fSN19DYeQ/jhtecpY
 JYcQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGndlfj1/9Lm2YXmicYhfvn0R6O8Id+BRHXhGF9J5jW/tdK7108AzlHfTOq/IGcOUT48IMlB91w2r1@nongnu.org
X-Gm-Message-State: AOJu0YxSi2QiVVl3kIbfzBFS4P0sk0VebwPLXAmT2HRYR+K4NIHFsDmw
 Kjvf9ZCLlRlrzheopAOh9bp0m7JL4nhLT1FYMahRMS39g0u9+R6p56hoK7057XkSmTE=
X-Gm-Gg: AR+sD11Jnqo85Olfispe2VC8QFfC0Tqxm/gV4U1ajm7/8PI5QU06cOwpcf3tHWlIyNw
 VRwoIZ4LqnnpDt5rjXSNSQW0XNlThmjY6sMXo1F1p/HQ0VuAZMVAj9LMA0KMA4QPyDCfydAesVY
 npAyCPIIig5TDkVlU2HDlkd0x7LbI45Uf81/m7WR88QCmPL5gzQ4VlvCfyrCo/cuSf6oLFYc7WW
 7HDEsgT4Kv62961IKjiCc/kmIXzca9oh3rA+zETjN+NFLhlXsK5d6UdoQd1Bh9k3MGhu/Q3KnKe
 CAI9Xou6xQRk2iGq576sYSCWvf5onb6iEGK37OuwRIw4sgjDR/OjsEoo4uSr9nBDGF7M3SYG/QE
 3V03NVXbhmqwOzldp9IhaY/z6z6Kr9yiZvAwjfJV58p5hh74GR/S0yWFZhDPThj8N6D32ulhbCl
 AQLthB9F/Tx8ZOfP69/iIAwdE9GnycS+485nJ/JGDm1Vd2NVEIdMOvTFJD7PPXBtpd7xAg6S18J
 OOVayYzjSM9vZIYz9twJhXgtxZYaQ4W4AUBBkSXdFyfXsreUw6gNyYgDYL0oJkTEwjfFg==
X-Received: by 2002:a05:600c:3596:b0:495:4749:16a7 with SMTP id
 5b1f17b1804b1-499aa1e269emr122257365e9.14.1787165674692; 
 Wed, 19 Aug 2026 11:54:34 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b145c9d7sm7995048f8f.15.2026.08.19.11.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 11:54:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH 2/5] hw/arm: Remove spurious WM8750 dependency from Realview
 Kconfig
Date: Wed, 19 Aug 2026 19:54:27 +0100
Message-ID: <20260819185430.3467629-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819185430.3467629-1-peter.maydell@linaro.org>
References: <20260819185430.3467629-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The REALVIEW Kconfig stanza has a "select WM8750"; however the board
itself doesn't actually use this i2c audio device: its audio is
provided by the pl041 (which connects to an LM4549). Remove the
spurious dependency.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 260d2f0751..5e9a0bd8dc 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -155,7 +155,6 @@ config REALVIEW
     select ARM11MPCORE
     select ARM_TIMER
     select VERSATILE_PCI
-    select WM8750 # audio codec
     select LSI_SCSI_PCI
     select PCI
     select PL011 # UART
-- 
2.43.0


