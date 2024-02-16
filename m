Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71EEC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 15:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb0FR-000439-An; Fri, 16 Feb 2024 10:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rb0FN-00040o-Tb
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 10:35:30 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rb0FH-00089f-Eb
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 10:35:24 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a3de25186fbso88559366b.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 07:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708097721; x=1708702521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5HOBSsoYfdBIXejJenW3gKcLKAp6yUaDTVDJ5Gv25Ps=;
 b=cBUPFm/9ARt4iwX3YvtP2YQXmFTos1TjqTfIXGfPzBi55fri9o8P21yfBu16bv/gvW
 o4tsTCuAOJLhoaAK9bQRBoyIVgfnSe6L1dROZNczLYcbXrkSGRFUVgxyPTEeies+fNWc
 LtX+pcvd2TpeHZ82iZW6TRFqWrwetGmJLnD3parO8+P6mO8UZa94LpJGY8wuYvH9BiC7
 CF/0IIFKWwkG1Irbe8hk04WhCifEwXF0VaHK+esJC/GCDWAnnnP4Hs+okv6qxnIOsqLm
 /bKrryBJKU8Hu8PHfN//7sLYb2g/AOJ9kWsP9BqpAy6v8xLL8+dJlTul0wwChAyT+21V
 Iyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708097721; x=1708702521;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5HOBSsoYfdBIXejJenW3gKcLKAp6yUaDTVDJ5Gv25Ps=;
 b=ImM/n/Ym+TZEdDzGRtX69MJ10u3RemAYEcZ0WWEaDXx07MIo/Z8RDiFfAuoEzY6fm+
 +7pN1zq9BVsOypcOI4PJ6V0JMqqEADHAHXN0Aldn3pafmDD5JqhdDY00ZnkFRt3C/yaS
 GLg0OAwFFyGsTkC4UIdTnacU54vf9sikxJJ4rFg/RFoqHYN7E4Wda1fqyjK2X4leFJ4l
 NLe24qN4J7zzWji9kGMiySyAu1CPDhoZlAZhWdSH82vgQf1HMJOyPoRUfRSMlhlLsC9i
 lF/tOq1+brdkcPmG5+Rh52Qq/0uokUw0zz/PXDzpp4PzJshk3ChE/uU3NJj/Ugabr+dD
 /2YQ==
X-Gm-Message-State: AOJu0YwW1AyI14s9pCNFgmhrQ9Znh8LtL9lKQblRrOJT0Oyv94X0Y6FE
 L3hEEqcuZQ2fF+ko0QoNL1mwecvnP4CnMPIGC2cJGwL0juLjN7U3w3pmCPVgN+vHVt/aa5gFvEg
 Z
X-Google-Smtp-Source: AGHT+IGNmgGH50mBITVJX2YF+q7t94xFy9AFmwyf0NoIqAfPCc9XxsBjfL9Fg2OGn0M5lytBsv2j4A==
X-Received: by 2002:a17:906:8c6:b0:a3d:d9a1:e84e with SMTP id
 o6-20020a17090608c600b00a3dd9a1e84emr1587399eje.38.1708097720897; 
 Fri, 16 Feb 2024 07:35:20 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 lj8-20020a170907188800b00a3dd52e758bsm45098ejc.100.2024.02.16.07.35.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 07:35:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/6] hw: Remove sysbus_address_space()
Date: Fri, 16 Feb 2024 16:35:11 +0100
Message-ID: <20240216153517.49422-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Pass address space as link property for devices where
it seems to matter, otherwise just use get_system_memory().

Philippe Mathieu-Daudé (6):
  hw/arm: Inline sysbus_create_simple(PL110 / PL111)
  hw/display/pl110: Pass frame buffer memory region as link property
  hw/arm/exynos4210: Inline sysbus_create_varargs(EXYNOS4210_FIMD)
  hw/display/exynos4210_fimd: Pass frame buffer memory region as link
  hw/i386/kvmvapic: Inline sysbus_address_space()
  hw/sysbus: Remove now unused sysbus_address_space()

 include/hw/sysbus.h          |  1 -
 hw/arm/exynos4210.c          | 12 +++++++-----
 hw/arm/realview.c            |  7 ++++++-
 hw/arm/versatilepb.c         |  8 +++++++-
 hw/arm/vexpress.c            | 15 +++++++++++++--
 hw/core/sysbus.c             |  5 -----
 hw/display/exynos4210_fimd.c | 19 ++++++++++++++++---
 hw/display/pl110.c           | 20 ++++++++++++++++----
 hw/i386/kvmvapic.c           | 12 ++++++------
 9 files changed, 71 insertions(+), 28 deletions(-)

-- 
2.41.0


