Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75337E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 20:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSinR-0001mX-3p; Tue, 31 Dec 2024 15:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSinK-0001Bw-L2
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:24:50 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSinG-00011k-1f
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:24:49 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43618283d48so75091835e9.1
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 12:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735676683; x=1736281483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kYhhix/9PVscVBbQFIH04IFrmOJJ4Qi4bOjmujehVDo=;
 b=jnLNRf42L517PD/EkOg2vVWwQgeUoUnXveTfBP9eLcpraDScT3Jtd7tV3Mdrwq1ffr
 5xX5h0P6xpcwCTl9nRYWuYvpIFqMuhi+aJ8CpXr6q2FTtpmwg9wbwdyl8NUVp0iRxFUG
 wtQEzIxv+5ndPW5wk7zyGA/x4jHBaXH98K+HykvWp3eCT6WCTPzMsbzsaDliCItGanc7
 AIKHD79zB7rPbH1EUK48iGMtE9OroNaFD9rXqtTMhGTi77kRUMXzoXMEph7Y9fubMxb2
 o/wgmHlp0/1ckY1o6nMcOz7mVL8epcrZBFLUbSx8QexsV7BM2JD3F2PYQN9v59UK3NOU
 PO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735676683; x=1736281483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kYhhix/9PVscVBbQFIH04IFrmOJJ4Qi4bOjmujehVDo=;
 b=oMFFzzHZl+LzprGuSvMdY0Lugf2rQI+s1pLRzCl2ctc3rVHJi06qCNSVMBrLObiD4M
 7fbpGbpdeuXQiL4SvGQDb/FXDJRUvUVHmjZcvfgmmdzp3u0TDDLv/rDzNSOPmSolR77t
 iagAlO9x/+ehOozWMbzj2iD4yTNIt8Bar+6FLcmJa5bPNCqobKA/yYfLOtGuoB6VrX8T
 b4uPhKAlphEfGon7OYUnn6LnM1UhDUQugEe6qqeogh3cpymGGdWGkH2hsAeI5BPxry+1
 uSQpi8bkC2ffSRNoTamOcOR3fhQ+yXV/QHwquIoOlGWhnPBznT+cjsP9BquUuYK8ksJv
 5meg==
X-Gm-Message-State: AOJu0Yydt0JyvwiXJ9KDbdhGiraunRsOqDdK1iiDZFQXpFz8EYjrHljM
 phL3drL5XDoa7zjK0S9AYnkZcQhI8L5n/JnNMsMQEh0Fl/g89BdqlElPxXBcbf6IM/zFG4ZaZR6
 ywVQ=
X-Gm-Gg: ASbGnctn4Qfp9facwDUXbyq+P13z5EOdYVrGGlDVBPE4h6FwmYu471eDo0HO48BvVqf
 8tzpRv1zu61jmbaYB9RRRjW6LkidB7gz8NYHZkPzgGZyeJrkZlF9Ibogoia1c6SNpOB08OB/xo+
 6aIUJfBBqybMuMxS2jw/zlczqPR9b5YZi+EiIZUPSuuVOQz04QqKfsPf/RI8sRSwT0T/16BOsmH
 RBHItawFUp/pkeScYtxw4oa6kCXu9n8r10kKvHeSc0spVkcX79AYQmGa1vcmNMKSJ3v7+DRDtcz
 ny3CmLmfglrMdKTWp7Ik8W33kuVnwBE=
X-Google-Smtp-Source: AGHT+IFKw7tzJFLtNW8lvUXDhFv1n5Mf/kbuYAXj/2t1cf0hWJcwQfRmrkhOwveb8xQcpoXH7cQX8w==
X-Received: by 2002:a05:600c:3b23:b0:434:9499:9e87 with SMTP id
 5b1f17b1804b1-43668b5e194mr296086495e9.25.1735676683417; 
 Tue, 31 Dec 2024 12:24:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611ea3d5sm402023665e9.5.2024.12.31.12.24.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 12:24:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/29] MAINTAINERS: Add myself as maintainer for apple-gfx,
 reviewer for HVF
Date: Tue, 31 Dec 2024 21:22:26 +0100
Message-ID: <20241231202228.28819-28-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231202228.28819-1-philmd@linaro.org>
References: <20241231202228.28819-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

I'm happy to take responsibility for the macOS PV graphics code. As
HVF patches don't seem to get much attention at the moment, I'm also
adding myself as designated reviewer for HVF and x86 HVF to try and
improve that.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Roman Bolshakov <rbolshakov@ddn.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241223221645.29911-6-phil@philjordan.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38a290e9c2c..2101b512175 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -509,6 +509,7 @@ F: target/arm/hvf/
 X86 HVF CPUs
 M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
+R: Phil Dennis-Jordan <phil@philjordan.eu>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: target/i386/hvf/
@@ -516,6 +517,7 @@ F: target/i386/hvf/
 HVF
 M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
+R: Phil Dennis-Jordan <phil@philjordan.eu>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: accel/hvf/
@@ -2631,6 +2633,11 @@ F: hw/display/edid*
 F: include/hw/display/edid.h
 F: qemu-edid.c
 
+macOS PV Graphics (apple-gfx)
+M: Phil Dennis-Jordan <phil@philjordan.eu>
+S: Maintained
+F: hw/display/apple-gfx*
+
 PIIX4 South Bridge (i82371AB)
 M: Hervé Poussineau <hpoussin@reactos.org>
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
-- 
2.47.1


