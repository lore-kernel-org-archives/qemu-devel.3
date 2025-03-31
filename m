Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E985C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 23:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzOBi-0006pn-6g; Mon, 31 Mar 2025 19:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzOBh-0006pD-Ca
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 19:05:01 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzOBf-0005m4-HN
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 19:05:01 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39c13fa05ebso923076f8f.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 16:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743462298; x=1744067098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YlaEyhXAp6ocXg8HeW9O6/zASqUSt0dLhdV4fK8vO5o=;
 b=C8pT92wb0FbRLoZD05rAyMUuPZU+OvOpWqBa7MhNug4tr2LFb56MmepYb17293eUOg
 7UG45qPUPNKufVBMgTFneG+8n1mJQmFiD9brduhTjtyZWMvxYPfZrjaA46Lc/+YOfmFF
 GDPfpdYdl1jzpokQfaS9PQHuwMPWcrZ5Y1W8GAPTixZVqDrPWyjBLIQXDpefg7VFoDdx
 qK49geabIZiA2FuPzWNsNRUuSaiJYcHx9NjyRVLDcS0dpLnhQ03XF5xWdiNXmYiKnKT9
 3tPACA76V9vwflyIKsykY5ZyxYJo/qnroDwvuy3SdBamb8EOVicWPjHs5sStWSGSSNq3
 3eqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743462298; x=1744067098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YlaEyhXAp6ocXg8HeW9O6/zASqUSt0dLhdV4fK8vO5o=;
 b=vQmo8nAgJQiqaH7CsMGhFfhisnPAxFt49xEa0gWfpAJPmh+eZHcYfvtJGsXsl87hOp
 iTlyzyjzecKLm+6zZoE7h//P4XiG9crav77NvKTQj+st68tBpgnfzjs/5r9DXwnmV/md
 1eepxOh+jPAzOy2ZbfWlmqygD/0snNVOqf+HrvsMhfplq+1RzQcYI/H3SaT3fF5qvr2s
 QVgBCmHtLeyISMSTcYzOxICV9tcquoEMgrZqN0p279gUZyQ9fY+XJ7eiADXssFv8z6fV
 iTVxpr9SZ5FHdGsoGP45mXraUCzaP6laJs6FdUuH9STE/5fXEKD/ioaQj5rukwr9YTzE
 CnRw==
X-Gm-Message-State: AOJu0Yz5Ez/I2szd+HRirnu3Gw1/nHFk2WSguMJyEtVoLgM0NUILkj/s
 XVy9anH1W3SciNqGLhvxjcWaj/bfe/3esRMWLFf6jnYQNFAosxgX2T9Nshtl8zHnGzoO1sBjWit
 0
X-Gm-Gg: ASbGncshAbJfRevHcflulLOtHnJpEzZZPJB/0Bt0CRsiyjDEMKWm8gKGpPtC1O8CB6+
 Ui4l+SfTqJnvsRn23uDczUjpJ+zoSqDetrQyQfCk+uVmumEnGLQOP67DXxruS8/x2KT3dVX7UCq
 lFbZrxj1bHEf5Bn0cP0U5kY33iZWIiHQ/u5V2g8IAr965pWrMnfTTrlGnpTWYv8pUHUZkd+zwyR
 pI4u7PY7n1ev3p/6v74clneqSyzQodiAwRISq2Rm2b9AZ9dRmeItd8YZ8sDaOxJJhehEabVGL+l
 0jT8+a0gMuWj/XJtlJFV65bHuQHjZ8S1M7gvUZxTXzic+lQgX215W+VFVd3MtRT9v0RPMqPPMpH
 ooO7Uz1pCNBn+egqUzxl2mijUtfbTwg==
X-Google-Smtp-Source: AGHT+IGwoMF+YRQ+3eICOIA9vfUiwZjjDbrkCivGMOmqJmDw/sK50eUG0NhFdKTk1oQSKpWRxfavZg==
X-Received: by 2002:a5d:6d8d:0:b0:39a:ca04:3dff with SMTP id
 ffacd0b85a97d-39c1211805dmr7884916f8f.40.1743462297814; 
 Mon, 31 Mar 2025 16:04:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e0afsm12611613f8f.65.2025.03.31.16.04.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 16:04:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 2/2] hw/misc/aspeed_scu: Correct minimum access size
 for AST2500 / AST2600
Date: Tue,  1 Apr 2025 01:04:44 +0200
Message-ID: <20250331230444.88295-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331230444.88295-1-philmd@linaro.org>
References: <20250331230444.88295-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Joel Stanley <joel@jms.id.au>

Guest code was performing a byte load to the SCU MMIO region, leading
to the guest code crashing (it should be using proper accessors, but
that is not Qemu's bug). Hardware and the documentation[1] both agree
that byte loads are okay, so change all of the aspeed SCU devices to
accept a minimum access size of 1.

[1] See the 'ARM Address Space Mapping' table in the ASPEED docs. This
is section 6.1 in the ast2400 and ast2700, and 7.1 in the ast2500 and
ast2600 datasheets.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2636
Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Troy Lee <leetroy@gmail.com>
Message-ID: <20241118021820.4928-1-joel@jms.id.au>
[PMD: Rebased, only including SCU changes]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/aspeed_scu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 6703f3f9691..1af1a35a081 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -443,7 +443,7 @@ static const MemoryRegionOps aspeed_ast2500_scu_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
-    .valid.min_access_size = 4,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .valid.unaligned = false,
 };
@@ -787,7 +787,7 @@ static const MemoryRegionOps aspeed_ast2600_scu_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
-    .valid.min_access_size = 4,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .valid.unaligned = false,
 };
-- 
2.47.1


