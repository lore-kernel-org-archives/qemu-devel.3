Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17992CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPODT-0006Nv-PD; Tue, 19 May 2026 13:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPOD6-0006Le-MT
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:26:29 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPOD3-0002XI-PE
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:26:28 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48fde648a71so28595015e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 10:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779211583; x=1779816383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W7Y3ov/4uDmrOIHa6vTHJu/NH7XRpswpbX5edldRgyQ=;
 b=zQscikjrQ2FVsb1LIcGI+sJNpPwN29tpEtNwdZ92br79D+fBdbKIZ7qblnL1K8M+56
 1qDVIWU+Q6jtgF+mIrfWINjbB3ECZMCQj/9LMDQmAn+AoTE+zeW/N52Z8R6rVmzFVWYr
 xrFyuk6udB1TKQrwX2B+Pfa9V15ixYrI0/VVC0/IIlkhbPNespP4A6Bf466UM/e+MAE6
 cXCaMyuNKB8Qvd5jBUv6n00yteCjVidgxTdBna5uFmXKD32ZRPZQGUFQJ0cjQ7R26dOy
 lT/+RWdbl80qtAC3KDg5OLx0waTMzdgnnh6EbXB+tKXRdZs9xQmcQNplxGqJrRS9V3xo
 q2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779211583; x=1779816383;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7Y3ov/4uDmrOIHa6vTHJu/NH7XRpswpbX5edldRgyQ=;
 b=gXWOeqr6rtAG582WKXCOTSXgA1TmfSb3J15QwOPN0Cph/7UyOuHWTl80gvGvLSE8qz
 MKnt8U1xO+EAR1Am/we5PHoIZUxYuCuFMhhQMf//yav+LQVw3IROqXcFZj4SOmmObaEt
 qzZaMjeMeDUIz6pNKwjLT/FgCxfQ8C18cu3dPk2vKGWl2vr78uV5rtawcio1xmttGpYL
 pxW4YfFjCidm5gxy5pgUwoOFCMPRQFtgC+dqJZkmtb7XY+UsPbZYy07w4ba649trNuEO
 2v1Ef/OHPjgDNX0Da2+leha4X1NrTBmvL1AFJyU5h+sHxHldYMQERIGTwya5oWvMC9HZ
 Hk8Q==
X-Gm-Message-State: AOJu0YyidzkvMjWnUjdh+/izGDQevOa6T/dB6oFWXwsk8J/no7lq63hB
 7uvt/TDbBNMo1lX4oNtyAomGwH0hrI0GGQaBOh/CgVem+jcDoep6rvXKDsqYdFyPmvNtifRNKum
 U9GrwS2o=
X-Gm-Gg: Acq92OE9qi9+Lr0P8npeCvUWBxr5ZHxpxAnZVlAPGY9BkKvS/yUc2xYY5h3U/seIJ/N
 2KPCDrQAJGaVryQ9IBe5LIRryYdl5hqMP+gdcPPFtbG6uncXikB6OvPtg+FoQLaiU0aKMgJp5aT
 KtqK+3yaXTns6bXLWPz2XczUuAjpuuk6onmxPR+dnOjVD+Up9sS3lSccf654VTABSQlOP0/QaV5
 jvti8VpG8Fh6T6Kzgf9582PO2eEGwPtfvPz2otGbkmB1q93BMoU9O1w3ps9bdYamE9NCq3f8LY9
 Mi7/wkvBM7dNvZsXJuImuCiUbdla7MKfZwQwSLnBjl8dUEQIdoiveZNXtyWdUFFUBA/G1fxSJNc
 5BvZfPiNzIqqJlp+sQxE6985Ssy0tb/dy+73pROyUIr8JWta0qJxUQz21PhWr23H8iVSjTFK0Gl
 fDzegK74DJtzAq9xGySL9xc3Qakme1oyPrj2VWaQNssmGn5I5uCveGFdEy/e2A+cyu+J+yt0dX
X-Received: by 2002:a05:600c:8288:b0:490:2640:a982 with SMTP id
 5b1f17b1804b1-4902640aefemr16769965e9.3.1779211583306; 
 Tue, 19 May 2026 10:26:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe78aadsm108523605e9.29.2026.05.19.10.26.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 10:26:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] MAINTAINERS: Fix RISCV related paths
Date: Tue, 19 May 2026 19:26:21 +0200
Message-ID: <20260519172621.98469-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Host user-emulation headers were renamed in commits ba0e7333620
("configure: Merge riscv32 and riscv64 host architectures") and
bbf15aaf7c7 ("common-user: Move safe-syscall.* from linux-user"),
then covered in commit 355cdac7d86 ("MAINTAINERS: Add
common-user/host/riscv to RISC-V section"). Remove the obsolete
entries.

test_riscv64_sifive_u.py was renamed in commit e1a8572a8d7
("tests/functional: Move riscv32/riscv64 tests into target-specific
folders").

Reported-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 73b7ebf1d7e..0a1cc0e51a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -361,8 +361,6 @@ F: hw/riscv/
 F: hw/intc/riscv*
 F: include/hw/char/riscv_htif.h
 F: include/hw/riscv/
-F: linux-user/host/riscv32/
-F: linux-user/host/riscv64/
 F: common-user/host/riscv*
 F: tests/functional/riscv32
 F: tests/functional/riscv64
@@ -1783,7 +1781,7 @@ S: Supported
 F: docs/system/riscv/sifive_u.rst
 F: hw/*/*sifive*.c
 F: include/hw/*/*sifive*.h
-F: tests/functional/test_riscv64_sifive_u.py
+F: tests/functional/riscv64/test_sifive_u.py
 
 AMD Microblaze-V Generic Board
 M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
-- 
2.53.0


