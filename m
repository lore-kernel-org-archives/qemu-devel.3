Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D640FFDEE4E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 21:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG1bi-0007yL-PJ; Thu, 23 Apr 2026 17:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wG1bg-0007xw-NG
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:29:08 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wG1bf-0004gS-1E
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:29:08 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488ad135063so63289235e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 14:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776979745; x=1777584545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xSk7gcQSFSua6STZ1DaIl0zKSTGp5kyvxv0Riljs2pk=;
 b=oy1BONs4N4zabKwff0jSdFnd9SfELNZQBzBDEiSsT+DtQipEYUrwBxqQzVgBjh1WXt
 BxQ92n/odCTpjOsf6C8iGxtz3ujxB/Lpxov4oU0Bz4pTTMmrtANSwJGfHF0tnGaxxLRD
 FWy1n9GrpWJWh9LJp9TDG/G2WsyGK498M90tjsQOl4d858JiVNvmInbeePQhNSora5ip
 ic3r3x3TPJ0SPC5E3knsx/1lGj3q9w6DFj5ikKbjJfJFI3uFGBZ7/9IZWg1Qgv6W9fJV
 oByHMMp8sBesJVMQMFo6AoYYHWWKBzaywS+8Mh4eXv+KQHjol2/xwZay5V7ULQ02l3+i
 CAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776979745; x=1777584545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xSk7gcQSFSua6STZ1DaIl0zKSTGp5kyvxv0Riljs2pk=;
 b=UpdgwTo2ZXrJe3ec8up9JhStyYXZ8wYsBBG9qZ6N1Dtv8yM6wq5LhYzqVTXB7l1xZR
 VVV5zMNP1RdeYffLLg4fRfWp7ahAUu1oZhEkmYYiQnpC68LvJ4fJD8iebcp+ePR42tTG
 ACB7nDilFhtMKqAAarMvhYNIyxdo0SzJ/8U6XuWW/hNSV3cpCqrR3xPbYJEFCqpIXLQ2
 xFHZF7AjhW710a10CkRCg0fRaUXTQS1tci7FddxCnvd8ck5Gtouns/BkJSstF8GzOwSg
 i7rQuhpFQ1C3JNzUfENSqAPRwAxflch7WTeOXSxSWUvhX1l3W+pKInc+ZM2aXHHrL8rl
 epcw==
X-Gm-Message-State: AOJu0YzdHRfcB/Ph+XDQ3fO+xvBLwtqVIgYgZXRQnVbbmjQalt6FCPW+
 IEQ56Jslv47Qpbm29Pd7/Joy/NDOxzpaEld8eL4Dfj2RtNC+qrhofsJAEv1wVtNe+Z6MxjTj1oh
 liVl6GiI=
X-Gm-Gg: AeBDiesJ1GekKRr7zwqRYzdsMWqLT29fp+SXTmN8ExMWTM8g/nm2YbOUYFF6weEOluR
 KwrD0D+D5DR7MFQOyFcKH5/67AxPeT2V8smcxQF9zcv/Mv5tVsToW7tj4IQUkJ/2exFSsu6WCke
 R42boXPS+wCd73CosvkUNGYUUHNoRrgDn+DwrV3OGKiIBGI2ETbZvtjgnryd+2ICr1cLYNqPVYZ
 CKNFY9C0ZszkhWG0yhtmQKv7OyQpfCeu+To8TS4NJ+vsOms6To7ZA1x0vS5/uOFPvj92m7HfApZ
 zxiIe4cR8l3L3lptmS5HYuAVGu7aArqNqOvHTGyOegyL0ZxA2z41YtS4NFcp7v3h0Tjr6XcF43X
 V+maZC+eRpjCVwnjl998RqUpZjTmMsoKctLB2qUHwW2dS55p++P6S3PfMB6FFJqeUrqCt16mXtY
 L4bo+9oFntTFs+y9eB29Y/XGoQb2gk++uXvHj3e/d6rDY/FT/+wSIHj/qJDomeZPfCqkFYb2sSf
 DngLGhIS9I=
X-Received: by 2002:a05:600c:821a:b0:48a:56de:d620 with SMTP id
 5b1f17b1804b1-48a5aeb78camr119387245e9.14.1776979745179; 
 Thu, 23 Apr 2026 14:29:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a525a0b1asm130435725e9.2.2026.04.23.14.29.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 14:29:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 46/52] MAINTAINERS: Merge PCIe DOE section within SPDM
Date: Thu, 23 Apr 2026 23:28:54 +0200
Message-ID: <20260423212856.68734-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423212856.68734-1-philmd@linaro.org>
References: <20260423212856.68734-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

SPDM depends on PCIe DOE, so it makes sense to cover
these files there. Cover the spdm.rst document. Add
Tao Tang who volunteered to be designated reviewer:
https://lore.kernel.org/qemu-devel/44abaece-6a6f-43c6-b29a-53d6eb08033c@phytium.com.cn/

Cc: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20260422080406.62638-6-philmd@linaro.org>
---
 MAINTAINERS | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 53031fb8ff0..7d639114467 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2148,11 +2148,6 @@ F: docs/pci*
 F: docs/specs/*pci*
 F: docs/system/sriov.rst
 
-PCIE DOE
-S: Orphan
-F: include/hw/pci/pcie_doe.h
-F: hw/pci/pcie_doe.c
-
 ARM PCI Hotplug
 M: Gustavo Romero <gustavo.romero@linaro.org>
 L: qemu-arm@nongnu.org
@@ -3690,11 +3685,15 @@ F: tests/qtest/*tpm*
 F: docs/specs/tpm.rst
 T: git https://github.com/stefanberger/qemu-tpm.git tpm-next
 
-SPDM
+SPDM, PCIe DOE
 M: Alistair Francis <alistair.francis@wdc.com>
+R: Tao Tang <tangtao1634@phytium.com.cn>
 S: Maintained
 F: backends/spdm-socket.c
 F: include/system/spdm-socket.h
+F: include/hw/pci/pcie_doe.h
+F: hw/pci/pcie_doe.c
+F: docs/specs/spdm.rst
 
 Checkpatch
 S: Odd Fixes
-- 
2.53.0


