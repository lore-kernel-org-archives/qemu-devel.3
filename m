Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCF2E6ADCB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 22:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEcVU-0005gd-0a; Fri, 22 Nov 2024 17:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVS-0005fl-D0
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:06 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVQ-0003hj-KT
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:06 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7240d93fffdso2196385b3a.2
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 14:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732315922; x=1732920722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3RE9rF5AKD1oZJblYJ9hXth9MAj94ccpqKJC2kiz+iE=;
 b=BQpDxo4rVOgquB+RZXVD2+KQ0NW6Zku+sUavnPWiJV6PPJ4Ved5Las276oULs4PHAF
 01HYdfVvR2APYLZxhZ57swYWC5kfSz09JsuKNPIkW4pvBUVqbkdy/opm/8svn2mogEdA
 MQXKPFkmjfulvVenEgtXh4wm+HaIgSerhq+se2SUwzS+o9nz42TXPIpGd12N1m5lXXLp
 8Uh7rdvCsrViupGmc+2mq9Ibti6yAmMQr3EE/GdEOU1nJCLNys+dMFcuooIC0sykRx1P
 48W0NwulLzAwIQycn1NX16BaNNdWlby1lqThb+uKhNrJab1PMBFFA6s+IJMGoCB+1JkT
 H/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732315922; x=1732920722;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3RE9rF5AKD1oZJblYJ9hXth9MAj94ccpqKJC2kiz+iE=;
 b=QoYDngoyiX00qZh66qWXqIBSMEBSpAePrOETpHCzA8EfDor2Ijt2ao4vIjhYY85BYn
 BLEScU5XzGkMDKRf+OJk4whR6v2pkdcp8JfuwJMeTqI16PSnJgHU8aUptEQT3ke4QCZn
 pPIo3tI7gi3bjE2Kup4V2L/Cze8Zzv1FGHsjMVH+2+QFg0/WFsijmvJQY6LW9jgXzY6M
 SwjWQNYe7TEhte7umxrhdbgqM9ODKxfE5MeONDNB0jtbSeeFXQkKPdwo/KYU0U3gG4gZ
 7/QisIO92BntWcs5RfEf+MffUdZOUhxr20t7Jd0r3v9ODxb6x7fHXcJL5oTQKJB/+eRu
 cEUQ==
X-Gm-Message-State: AOJu0YzefDiQHXCLHUK4ecGm892AVnr926elBPzDsN+4MaNMREB7OWKu
 UAkbmNxElMkf577DBga9OJ5qyAqIgOIiV1683z6lZ8bf49VdyuG0x1JaJ10NzJmhvJ1wQuOZjzV
 Q
X-Gm-Gg: ASbGncus3/leyZq+DnWDZ4m8nh5Ud8LDFZ87/pWLq+gi7cGHzOFNCGELXLLdLn6y8S4
 qh0b+zQ2jeKouIB/YeLDCNp5GiGXX/G8l8nBfoxU+J/GGSDm/CFr6eheLMh0Al5OgDcB2LARMxN
 blOIFgJ4d1S//QzQEHyc+pQ9g4JYc5TbgcxoAlubAvzOfQGl1ATH/aZn4oqRQQZOnarFN+j3+Jn
 M9+lYk+5ItI29GO9o1L+fQrGZNMmJ4IgfszFCnm5eaC7VLpEKbTzxlrXZ0ENy8ugVCQgUW5dj+y
 SchAl9Gtu9lujQ==
X-Google-Smtp-Source: AGHT+IF+uxbfiAc//ISdHz+mfT+Op/JpZhqM9YLIplb/JtdMLpTPYfOmx0XtRWSn+jco0UXLU2ToAA==
X-Received: by 2002:a17:903:2311:b0:20c:5e86:9b53 with SMTP id
 d9443c01a7336-2129f65e87dmr53602505ad.3.1732315922258; 
 Fri, 22 Nov 2024 14:52:02 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc1539fsm21450335ad.192.2024.11.22.14.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 14:52:01 -0800 (PST)
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
Subject: [PATCH 00/12] Minor fixes for Arm documentation
Date: Fri, 22 Nov 2024 14:50:37 -0800
Message-Id: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

Pierrick Bouvier (12):
  docs/system/arm/emulation: mention armv9
  docs/system/arm/emulation: fix typo in feature name
  docs/system/arm/emulation: add FEAT_SSBS2
  target/arm/tcg/: fix typo in FEAT name
  docs/system/arm/: add FEAT_MTE_ASYNC
  docs/system/arm/: add FEAT_DoubleLock
  docs/system/arm/fby35: update link to product page
  docs/system/arm/orangepi: update links
  docs/system/arm/fby35: document execute-in-place property
  docs/system/arm/xlnx-versal-virt: document ospi-flash property
  docs/system/arm/virt: document missing properties
  docs/system/arm/aspeed: add missing model supermicrox11spi-bmc

 docs/bypass-iommu.txt                |  2 ++
 docs/system/arm/aspeed.rst           |  7 ++++---
 docs/system/arm/emulation.rst        | 11 +++++++----
 docs/system/arm/fby35.rst            |  5 ++++-
 docs/system/arm/orangepi.rst         |  4 ++--
 docs/system/arm/virt.rst             | 15 +++++++++++++++
 docs/system/arm/xlnx-versal-virt.rst |  3 +++
 target/arm/tcg/cpu32.c               |  2 +-
 8 files changed, 38 insertions(+), 11 deletions(-)

-- 
2.39.5


