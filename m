Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79966C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 15:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZXI8-0002cq-IX; Thu, 01 Aug 2024 11:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZXI5-0002R1-Js
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:00:30 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZXI3-0005AS-Tm
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:00:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42803bbf842so62129745e9.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 08:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722524425; x=1723129225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N2nhULmOiEqic4xiNqVYtuowgyZy0nX3QYeNyKoEIPU=;
 b=ydk96koT7UGfqyDY9kvDR58zt/eYJaYMBvvUZDNSqHz11EBDX+hUpeW6NzbpPI1PPl
 PkeHqsvTQeoc/RnQor/ZMMRv9LI5B+bYSubuEvRl8bC3Zkl/L674M9bE8raT/WGo5HKX
 6ArLiWeIZsFMavnTX3Ar3V/ZMa/5PC7povSUp2BCYaVSFNXyxBPlgTPwWvKkkET/w+KL
 8/o8tfKECIlGRu1y42LqO7Ri7oUNnwObFoI55kyChKV82U6EMXcDVPrEtbUIanloZL5T
 LrKkeRsM6VAhvo8nPU03ylDctwPMF7ZWdz8OypszaRzAZaUWmcUwFQFxSGol6Bwetpun
 xixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722524425; x=1723129225;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N2nhULmOiEqic4xiNqVYtuowgyZy0nX3QYeNyKoEIPU=;
 b=dGc9FdPnxlV/4RMGzHSgwaw9B6tv8aonOVXvh+uAyic1EoprggTavCWs1jLK108kvS
 CdPEqEuMC0QQXVnpd8Fv3ReMhloDNe5D6aPiiSBQ5qyOZkRPdykoBXepnxEXJuoQefWZ
 p5fH0S2xWKgMzpzFjh5SH3OI+NlCzrH8k1YhXP/yG6ojoO2Tzws7N2LUIevlSJLlVUXw
 LJPA2jbXV7+UV0jhscPw45s1seW8p2TZwCuWKvTCeaiRnNgykm/MylmklXFqzqB3icku
 ud8vk0HuyoVTAW+V2tvKSVzc+4WEm7QlMjSPbOzzruGLO/rC6fVFrqu2O4InDixuaoew
 V8Rg==
X-Gm-Message-State: AOJu0YxXthLrulXxptGRPY03IlnkqCxdsfyZ95h8F8IvsoM1MO4wrI/X
 RD9RV8yqN680b/leKEzqElsOwmXswLc3ntNAMfQJoKObL9q/VWLtDpkKcMtq410s9DXW1vlZWpl
 ZHNg=
X-Google-Smtp-Source: AGHT+IHwJBa7Tp2FfdX4EcE9lJHVYPh8bQwaQ+9KfNcSaWBX6JpQtAQT+jfT8F9Fnc8nzRikw5c4aA==
X-Received: by 2002:a05:600c:a4c:b0:426:6e9a:7a1e with SMTP id
 5b1f17b1804b1-428e6b95ac9mr1051285e9.35.1722524424857; 
 Thu, 01 Aug 2024 08:00:24 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b3687003dsm19568212f8f.115.2024.08.01.08.00.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Aug 2024 08:00:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH-for-9.1 v3 0/2] hw/pci-host/gt64120: Set PCI base address
 register write mask
Date: Thu,  1 Aug 2024 17:00:19 +0200
Message-ID: <20240801150021.52977-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

v3: Move comment from patch 2 to 1
v2: Move reset values from Realize to ResetHold (mst)

Philippe Mathieu-Daudé (2):
  hw/pci-host/gt64120: Reset config registers during RESET phase
  hw/pci-host/gt64120: Set PCI base address register write mask

 hw/pci-host/gt64120.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

-- 
2.45.2


