Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68440D216AA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iEh-00018A-71; Tue, 15 Oct 2024 10:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t0iEe-00016T-7R
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:09:16 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t0iEc-00021N-Jt
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:09:15 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71e6d988ecfso1377345b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729001352; x=1729606152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n7khBWuAQuhlzuhiV0IiArZ/4WVz7fsPkQXZudGKbtc=;
 b=A5mDGxjU15o3h//io/e4sk7cwvsp4stFX3Q7838SQAVrUzI2J/n+PBJ2Ca2WEole7M
 FaIcBtWVvzlTb5r3AxKRWPPhUjW/Kzc2rzsjKUJxNfh87m51dFRtTuTFXUCcSVhrB9bb
 GQ9LOxvZRTU6uASSi1LFHaBYamjaLt2thnKGab+VP9fqHLRur1yKmlH4vbmpjKrbvbNn
 vXFW78nCuLcT0fgzIpppTfSLbPFiYlDEI8kUNdvJnpSivETmIs2B90cZ13Tcw6bEthK6
 y2Wqhqs44lze7mOkcG8QlSwfdXtXxkfrgUqzIWbpYcNsdIoz45etDMBGUWk1nbLDoczZ
 A8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001352; x=1729606152;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n7khBWuAQuhlzuhiV0IiArZ/4WVz7fsPkQXZudGKbtc=;
 b=neVX3+PFh8Pa4yDiSSGFLyjHvB0RKPksw8Aa55BMRNMKOXXWSbLQmQzlUVzV9QCnoz
 fU5LqggIFGLdpJDvdTQql2JTTeDukCwFPPg2CJ+8cfO0MYgDbPnvcNSsw8XkT+/Uul6I
 xWkkj+6DTvoEquePX8Z+fCjRKuulCEUG3kVuVj7lLI2hAoKf8L2qX94AAUfmxvJPvFXz
 Jj/DUpaI+DYzJm3FyXUUPLIkySK2Cd7OQgPDXhCUqhagKIfNV51aChfgYrAG16Sj+tJu
 JF08MKuFreUaGQg99PZ0BKrTm0S7qsKUp3LgAKiM723qzepXXUuscLyvAHu7+0Gn4mzP
 e17A==
X-Gm-Message-State: AOJu0YyfHsXyxbm15PWmDSiV94ruTm4+5fa8XgkJ1WoSHTCZlhlvzeCk
 3W+WAayUHCfIluOk8US4Nl10Dtrrk4G1P1X4jAweMPTb/ZhqeCEbSuXu7cbP4M9Bmkv1Vqp1J0o
 Z
X-Google-Smtp-Source: AGHT+IH+qPJfMYCyQwynmvX0S6oRyC7hLuojsz3NocZGJ2qtFGTZtTIstxfPJd8ucAksOVaHKBrbBg==
X-Received: by 2002:a05:6a00:2306:b0:71e:6f32:df07 with SMTP id
 d2e1a72fcca58-71e6f33c757mr6595863b3a.1.1729001351801; 
 Tue, 15 Oct 2024 07:09:11 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:3301:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e774caab8sm1325614b3a.145.2024.10.15.07.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:09:11 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH] tests/tcg/aarch64: Use raw strings for regexes in test-mte.py
Date: Tue, 15 Oct 2024 14:08:06 +0000
Message-Id: <20241015140806.385449-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x429.google.com
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

Use Python's raw string notation instead of string literals for regex so
it's not necessary to double backslashes when regex special forms are
used. Raw notation is preferred for regex and easier to read.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/tcg/aarch64/gdbstub/test-mte.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/aarch64/gdbstub/test-mte.py b/tests/tcg/aarch64/gdbstub/test-mte.py
index a4cae6caa0..9ad98e7a54 100644
--- a/tests/tcg/aarch64/gdbstub/test-mte.py
+++ b/tests/tcg/aarch64/gdbstub/test-mte.py
@@ -23,8 +23,8 @@
 from test_gdbstub import arg_parser, main, report
 
 
-PATTERN_0 = "Memory tags for address 0x[0-9a-f]+ match \\(0x[0-9a-f]+\\)."
-PATTERN_1 = ".*(0x[0-9a-f]+)"
+PATTERN_0 = r"Memory tags for address 0x[0-9a-f]+ match \(0x[0-9a-f]+\)."
+PATTERN_1 = r".*(0x[0-9a-f]+)"
 
 
 def run_test():
-- 
2.34.1


