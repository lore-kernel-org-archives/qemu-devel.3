Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3081CE7717D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 19:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJdus-00043Z-Uy; Fri, 06 Dec 2024 14:23:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJdur-00043H-Nw
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:23:05 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJduq-0003SB-4w
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:23:05 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-215b4681c94so20851025ad.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 11:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733512982; x=1734117782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3hKItZAJNPd3ymbmjbZvXdDTlbJIfy+hGFNvN3P9UFc=;
 b=B/Bcv3SUNi8jSVp6TG9L/zblJu187xlCkrDnMJPhbnajZVIfpYWPgVDBRn/EfoJbVd
 57cgOIJVdoZioGh2Lb/2YXyY5KE9L+PCZY60/kuDYEwnoaipPEVpw49Kl7SWcrdxGsLv
 kyTgeYY5rZQbNbVkd2/FmAKPAFjBNSde0AVvA64vDA0anhkEuEaxwu3kOOIp2kDWKLYF
 oaDq+CZwQIve0nM+0AC6UA8ZFZC6kYCGtyp1Zt7Uw9YUQAKtUU2f6pN6yN63BiRCUIUJ
 QmpKw4whARyx/qnH064I0++bwGE5aQs25vLhvISgBi/MDd96ktdedxM+0pWeLrpy11rH
 n15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512982; x=1734117782;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3hKItZAJNPd3ymbmjbZvXdDTlbJIfy+hGFNvN3P9UFc=;
 b=XyFyDHGvT3pMqEEIF9/qjGVPhmhug8/PNFbpmArKlycHFT2vOuTe+JHnrKu8jmj1BW
 QcMkeSxfD7vC1HFX0R2J5tIEzceWQe0qoLAg+KSZO+LQ/WAlgbLRrYRSPPDoyNBGCo09
 o2GG1WDAigLSuGu9gApMis/RSXnzykKiovdYp/6cYpTCoHWD3SVkgM9Zu/So/QQUSF9b
 t8drZlJQFhtaAIfrJIBxaDFjn/LXP+vUPTV/9mnIIPDxvzco5Evcc+3s/LUT1hy2R0/L
 wdnh/VxCkDY4Ion1IbkGvyxg0dEuZYdhfUp+7KD1aM8ZdSYO1DI1wsVwT4PWkzeQMQfa
 v89w==
X-Gm-Message-State: AOJu0YxAWSbwvwa5KYM963oopOlylIaZkNcbxA5Ivbvt/pD+Q4Wrj8GY
 TcKhJHozM7RlxJIka6j1I1U5/nPyjA5PHKcoJEa/Z+93R+yNVHvANSoM0MwzQIM4CEGL1Hr/nFM
 WCN0=
X-Gm-Gg: ASbGncsvn+AY/NfU6hIbEv0SEcz9UFHOprJS+5lfPQkUeSLUM5vKZo0Pyz6jPOCSpP3
 qDtmCDa0rj6KscJDk+cI8xolzgfa/NU3wl9Z7FClVJJupdR7puslTpYzuCOaGS7wlIQlUm0nWpl
 aU+DC3F2xjNp8+DcBNGAjvvt6hT1BrQP+2KZekjzrFGZRgLq/WO1Pm/Kk76aplEiUslEG5avn7Q
 eO8vNUW+bU3VUU7hYIK1Y1q1AFPTOCnL5Q1ziFr6FhaCKkvuH+AC4ZKZzNPP86vPgQdbbMzf1Y5
 XzcJMo0i
X-Google-Smtp-Source: AGHT+IFJJHGwYzVBkOfGVJ5LnuLUXN/xsurWyrTNL7jCU4Fz6n2FH6s37rNgmvazlAvLzVi56ZGhCQ==
X-Received: by 2002:a17:902:f54d:b0:212:68e2:6c81 with SMTP id
 d9443c01a7336-21614d4ac70mr58652955ad.24.1733512982220; 
 Fri, 06 Dec 2024 11:23:02 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2161e5a6f23sm11720395ad.266.2024.12.06.11.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 11:23:01 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Troy Lee <leetroy@gmail.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, alex.bennee@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 0/4] Minor fixes for Arm documentation
Date: Fri,  6 Dec 2024 11:22:50 -0800
Message-Id: <20241206192254.3889131-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

Reviewed following things:
- system/arm/cpu-features (options)
- system/arm/virt (options)
- boards documented and listed with -machine help (arm and aarch64)
- grep object_class_property_set_description hw/arm: ensure all options are
  documented
- reviewed boards description
- reviewed all Arm features (FEAT_) from: https://developer.arm.com/documentation/109697/2024_09/Feature-descriptions/

The Arm section of the documentation is in very good shape, and this series only
has minors fixes.

v2:
- ensure link for orangepi is http, so we can't switch to https
- left patches from v1

v3:
- fix for fby35 asked by Cédric Le Goater

Pierrick Bouvier (4):
  docs/system/arm/orangepi: update links
  docs/system/arm/fby35: document execute-in-place property
  docs/system/arm/xlnx-versal-virt: document ospi-flash property
  docs/system/arm/virt: document missing properties

 docs/system/arm/fby35.rst            |  5 +++++
 docs/system/arm/orangepi.rst         |  4 ++--
 docs/system/arm/virt.rst             | 16 ++++++++++++++++
 docs/system/arm/xlnx-versal-virt.rst |  3 +++
 4 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.39.5


