Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B94CFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 09:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTJP-0008J3-Jt; Mon, 24 Nov 2025 04:56:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNTGU-0004nH-26
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:53:53 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNTGR-0001pG-Ja
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:53:45 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so38959045e9.3
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 01:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763978020; x=1764582820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fp9vW/h+ca4q19x9PSWavTz6xjdxl3k4o8SOYxcHwkw=;
 b=mlWU6IqgdUcZyinutoJdfYLNiaMnYPsFm9cc+MgmxjvhlbADBC6ZGnyTjWS36GWS8g
 DXSyKxRQSwd/32e+Ilr4XJrYzqxKxesTOUfAaGkTVuZTpNhYL2IbQf1KnmKKCwtmkT+r
 OoBBApaMQMU60eeGgl4c1hWSp1tfaCJ0Aofym6grUE2clfAJqn63LdC4IrCE0NY1fcaN
 t4T0faZOQXa2h2aEvPIjGMlepkWfcyqN1QoXSg5S4554udUI9TO2oGiqSHNU8A+zh3Hf
 eqzzyhSxox5aqmEoIRZaqV8sRQ8qkJ5n1G2JqcaU0IrPJSHrHWJYxxCGRbrf5wweTmr1
 R6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763978020; x=1764582820;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fp9vW/h+ca4q19x9PSWavTz6xjdxl3k4o8SOYxcHwkw=;
 b=jmFz5U6f2Xl7NuCDMLkrYcnHFiUKeUbFJ3wTZyIzrhV/szBqoyR4Fu6BKX3t0qWZCj
 XMuWk2PoPN+BygOjvJC4UVXIG74pdQL24EPFbFHe+ceHO5XxQ6xuwE7K9bWPYhxfbgRL
 BTvhGLGDHYNLQkn+fpPz2y6m0tfal6h6otcAE/5GAbUG/6MnnNFhOJnZY56z6gYoYb67
 YjRj1xo0Zeq65J1P+9Pl8wtyZuYdcOR1YcQKw7R96ERbkoFYb4B9TYh9NuT4RR/wFRdA
 MkOcyWE4+GS17gvW07qjiL0HXXSPlkOwtv7u7mj4gJKnN9be8WnddsR+ydNfR3K/A4Sk
 kIMA==
X-Gm-Message-State: AOJu0YyXkyJxCmFsBIzh/bbWVnrtOrtgxQ3ThNm48RMiZHGzost1fuJq
 Z/GmkyvLYenisSlQ8M2Xw521fxipdfaXiNFAW3mLK8uFpHG98mLlAYeOFtjMWN160jAp1MahNFO
 HURK4
X-Gm-Gg: ASbGncs2DYSX6FmNUUWj0nJrDpc3gs3Y8dvxKXp1mXgrNzg2X2tqZOdsbbQ+fz4HM5b
 ZJJzXrKQk5Jhqx7ScMQ2EEIRmQ9Z71S58DqM3ATIq7EbwPY2gxxoIyn4kRmSQjLxfJDuWnnOQHT
 qfDheh6fZmc+aJHAt5zhsutqYXn6FsbIu371Kb/3Chh9aQkJBSZrZ4KPQYHMZYU9UcsydEfS1Pp
 bRqqIUHQ9Gohtp/KscryC0cO/R2BJt5e0sNPuuaW9CxsG08NVLZTWiVFcfy8Gu0qs9OLY9qOMkD
 gApgDBAaF1hX3Q3czkN+1VJ+AJ62dBqNL6JNHoj7ZsjZLRxo8QrI/ByVcDLZy598qyfPId7b1Rf
 XgFX/hMzHSYe150BeHnrxOIrRFIQgb8cNrvRd68SddHj1HxMokw+wvuPT1pEnebPWlgHTM4I9V+
 TayXkMUX6Owgc=
X-Google-Smtp-Source: AGHT+IGP4YKHXIJqEdJCQD491EzR13u+UrnCF5OyqhOFffvLYxiGPimxdF0LB9bFEU5XXbzRVtQS9w==
X-Received: by 2002:a05:600c:1382:b0:477:9b35:3e49 with SMTP id
 5b1f17b1804b1-477c1103274mr108397055e9.3.1763978020080; 
 Mon, 24 Nov 2025 01:53:40 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd9061sm27806282f8f.41.2025.11.24.01.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 01:53:38 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9C4CD5F83A;
 Mon, 24 Nov 2025 09:53:37 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL for 10.2 0/6] gitdm updates for 2025
Date: Mon, 24 Nov 2025 09:53:31 +0000
Message-ID: <20251124095337.537277-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

The following changes since commit fb241d0a1fd36a1b67ecced29d8b533316cf9e2d:

  Merge tag 'staging-pull-request' of https://gitlab.com/peterx/qemu into staging (2025-11-23 11:46:53 -0800)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-10.2-gitdm-241125-1

for you to fetch changes up to f5b6ca5606f8a1ed29a127847932fa2bc237ae38:

  contrib/gitdm: add more individual contributors (2025-11-24 09:48:18 +0000)

----------------------------------------------------------------
gitdm updates for 2025

With the latest updates the last year has been made possible by:

  Top changeset contributors by employer
  Linaro                    2959 (37.0%)
  Red Hat                   1919 (24.0%)
  Intel                      313 (3.9%)
  (None)                     308 (3.9%)
  ASPEED Technology Inc.     231 (2.9%)
  Loongson Technology        227 (2.8%)
  IBM                        192 (2.4%)
  Oracle                     187 (2.3%)
  Nutanix                    133 (1.7%)
  Academics (various)         99 (1.2%)

  Top lines changed by employer
  Linaro                    109812 (31.8%)
  Red Hat                   91050 (26.4%)
  ASPEED Technology Inc.    11811 (3.4%)
  Intel                     10606 (3.1%)
  IBM                       10146 (2.9%)
  (None)                    8965 (2.6%)
  Oracle                    8574 (2.5%)
  Loongson Technology       7614 (2.2%)
  Nutanix                   7404 (2.1%)
  Microsoft                 6927 (2.0%)

  Employers with the most hackers (total 433)
  Red Hat                     54 (12.5%)
  IBM                         30 (6.9%)
  Intel                       17 (3.9%)
  (None)                      13 (3.0%)
  AMD                         13 (3.0%)
  Google                      11 (2.5%)
  Rivos Inc                   10 (2.3%)
  Linaro                       9 (2.1%)
  Oracle                       8 (1.8%)
  Huawei                       8 (1.8%)

----------------------------------------------------------------
Alex Bennée (6):
      contrib/gitdm: add group-map for Huawei
      contrib/gitdm: add group-map for Microsoft
      contrib/gitdm: add University of Tokyo to academic group
      contrib/gitdm: add mapping for Eviden
      contrib/gitdm: add mapping for Nutanix
      contrib/gitdm: add more individual contributors

 contrib/gitdm/domain-map            | 2 ++
 contrib/gitdm/group-map-academics   | 3 +++
 contrib/gitdm/group-map-huawei      | 5 +++++
 contrib/gitdm/group-map-individuals | 3 +++
 contrib/gitdm/group-map-microsoft   | 8 ++++++++
 gitdm.config                        | 2 ++
 6 files changed, 23 insertions(+)
 create mode 100644 contrib/gitdm/group-map-huawei
 create mode 100644 contrib/gitdm/group-map-microsoft

-- 
2.47.3


