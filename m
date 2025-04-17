Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F55C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 23:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Z7p-0006mP-Di; Thu, 17 Apr 2025 19:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Z7h-0006ji-CQ
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 19:58:27 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Z7c-0003mv-31
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 19:58:23 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso10992465e9.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 16:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744934297; x=1745539097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4TIB71h4VciWszybxzcEl/xd/juHd0n+DW/Cdreo9tI=;
 b=uuGMMlBPgeJEegXvcbGHHyNSDP33Dv+ZqT0BzaoKTypcQ4/rEHtYTRN59mN7f9AVY7
 9FV6Iekr7OJ1CtiUVBWacAZL7+lhmzT6zCargteWK32NMRQ4L6vMwG4OWThjzP18uWRU
 wPCzAkba99yZOYQ9/jd9cV5j2Mgt/3isD27/lsgBLzjn1qeTslwqD/8sA6x1xUiOxD3y
 PCaO0XB7NnDGAR1je8k0Y/PNIGpxcA10/cv0236y03Aop2Lk6FUCLj7+6Qn8mSVZDA92
 n+pMTH+xeAOLbzDzy+/kcRXONfxoh0jycZdEqRIOMXzzmfoPqggRsZBFPzx8zu0ySgFr
 olRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744934297; x=1745539097;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4TIB71h4VciWszybxzcEl/xd/juHd0n+DW/Cdreo9tI=;
 b=kqhatb+3EKLf5DFtmiGgfkI4HPLmcBJPhBuhkc3+j5TV1NY9tw+vSjeq8YAh0GplKf
 iuCUJADyifVWnTtpnMOjPpydzyTRHDWEY04Pya645NZyW3cn2JQu5l4MR0SWdYgPjLPp
 Lz7PkahNJLVR63kzYE0tIGheIzfyOVuB1BUJeQ94TzvZy0IPlysmXBWAmwOk0PJFVx2a
 7ASTHJ3QUkdVN/Ge+gTDIbwsLZ419pmAapvyW6iupWQy+5gvo/VRdWP9zm4wkHiGbqYo
 36IdgmnH5fJzews3x+asd3IH+ca2wIuMSzU0ZCVbKa+sUlJIM4sloLXXK3wAPPV0gQpp
 eMdw==
X-Gm-Message-State: AOJu0YzIXAG6n6arxmdwEKZYKpFvX1vkWagxbPPjqLOv6LTW2tydypph
 jyjiBCJy4yxXpX7+HrZdBAKPwq8U/QTEGdmKIDeFxngMW6/SBgfPqUIKKC/V9ijHpBnJzz+t3ta
 B
X-Gm-Gg: ASbGnctp27+/53uzuZd0tVbNo9di7g17ATlVMDuc0dAl+PK38YGxmTPknO76KVCFF5O
 CuPYsNUUzGg4lVJ3UhOUHmb0PC/UUS9pgOwWm2Y2RnG86mnywfX3O6CISs6pISmOxC+cNXVfMza
 ajujnUeA2LU0R4KSHpJ5ojVTpgwAWsItyNKfJwm0ubG69+hXr9bLk+yePFCN98iSAcxU3ulwlvV
 +qcNJ3saA6x6Rf97oq2ZEvApEOMbA2SiHw/rXKGDkAuIz8EZ7qJAqqE3YiIDV2jYDJ49wOVksW4
 288+WQepiLBXEDc4aTWVPMVrOkHO/ukX5LVWQPYQgtqQ/7Bj5dCewhbsL9Alv4bBzVOnItmVnIc
 hM4rL4ATX7yqzpKUKRdS+
X-Google-Smtp-Source: AGHT+IHN/QJBo0yHQ/paSEAwZYKWOVfrr8IKD7aYgpf776iUc6Yk/F0m9i1GyuJ2TOCCmx2gW1m01A==
X-Received: by 2002:a5d:588b:0:b0:39c:dfa:e1bb with SMTP id
 ffacd0b85a97d-39efbae03damr482392f8f.42.1744934296815; 
 Thu, 17 Apr 2025 16:58:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5cf2dfsm952955e9.29.2025.04.17.16.58.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 16:58:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Felipe Balbi <balbi@kernel.org>, Bernhard Beschow <shentey@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH 00/11] hw/arm: Define machines as generic QOM types
Date: Fri, 18 Apr 2025 01:58:03 +0200
Message-ID: <20250417235814.98677-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

While DEFINE_MACHINE() is a succinct macro, it doesn't
allow registering QOM interfaces to the defined machine.
Convert to the generic DEFINE_TYPES() in preparation to
register interfaces.

Philippe Mathieu-Daudé (11):
  hw/core/null-machine: Define machine as generic QOM type
  hw/arm/bananapi: Define machine as generic QOM type
  hw/arm/cubieboard: Define machine as generic QOM type
  hw/arm/digic: Define machine as generic QOM type
  hw/arm/imx: Define machines as generic QOM types
  hw/arm/integratorcp: Define machine as generic QOM type
  hw/arm/kzm: Define machine as generic QOM type
  hw/arm/msf2: Define machine as generic QOM type
  hw/arm/musicpal: Define machine as generic QOM type
  hw/arm/orangepi: Define machine as generic QOM type
  hw/arm/stm32: Define machines as generic QOM types

 hw/arm/bananapi_m2u.c      | 13 +++++++++++--
 hw/arm/cubieboard.c        | 13 +++++++++++--
 hw/arm/digic_boards.c      | 14 ++++++++++++--
 hw/arm/imx25_pdk.c         | 14 ++++++++++++--
 hw/arm/imx8mp-evk.c        | 15 +++++++++++++--
 hw/arm/integratorcp.c      | 16 +++++++++++++---
 hw/arm/kzm.c               | 14 ++++++++++++--
 hw/arm/mcimx6ul-evk.c      | 15 +++++++++++++--
 hw/arm/mcimx7d-sabre.c     | 15 +++++++++++++--
 hw/arm/msf2-som.c          | 13 +++++++++++--
 hw/arm/musicpal.c          | 16 +++++++++++++---
 hw/arm/netduino2.c         | 13 +++++++++++--
 hw/arm/netduinoplus2.c     | 13 +++++++++++--
 hw/arm/olimex-stm32-h405.c | 13 +++++++++++--
 hw/arm/orangepi.c          | 13 +++++++++++--
 hw/arm/sabrelite.c         | 14 ++++++++++++--
 hw/arm/stm32vldiscovery.c  | 13 +++++++++++--
 hw/core/null-machine.c     | 14 ++++++++++++--
 18 files changed, 213 insertions(+), 38 deletions(-)

-- 
2.47.1


