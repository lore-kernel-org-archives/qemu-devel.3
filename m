Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BEDC71141
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Jun 2025 11:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQOfi-0002hD-Gx; Sat, 14 Jun 2025 07:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hasueng@gmail.com>) id 1uQOfg-0002h1-Sy
 for qemu-devel@nongnu.org; Sat, 14 Jun 2025 07:03:36 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hasueng@gmail.com>) id 1uQOff-00088K-4K
 for qemu-devel@nongnu.org; Sat, 14 Jun 2025 07:03:36 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b2eeada3df1so312372a12.1
 for <qemu-devel@nongnu.org>; Sat, 14 Jun 2025 04:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749899012; x=1750503812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ew6FhwV7k+RCBqhhgmkMcyj1wtfFtnRN4ZJrEDhTzag=;
 b=g+2AAw72tlLJ18v/7gPkKNfTRk+n+4Nodo55Om7+FJ2KDJyWvVgpFHR14TCl3EoF09
 HwQpylhQAR5VbiYdrhpn4qnPBAZHvt1AFtSKTNAppH9+xnRdYk4FzlMdJI98mbvdQVRL
 7mKDVG7WofSuB/RL2ZgWFOKNilPRxA9glhXk/EbA0e8idbqj1IbUcWyll3dtTMgHAKO2
 Z7WDFAvwqCm60YMKN5gYrtueHYdVFgEfhfAumbQvTbFcXBRGpeVU2H2MH4bBTX3JLERD
 c81VMks+k43ikjvd+3tkyqbpzrwPMVZz/GOOp/vKezWUZf6cNzjny+zPzWRVm1NbcbK3
 tOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749899012; x=1750503812;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ew6FhwV7k+RCBqhhgmkMcyj1wtfFtnRN4ZJrEDhTzag=;
 b=kJjM1YLReBwkfKnvumS7eZ12TKAosEzUxwuEugcRz0VIYhb5n8QbGzniMwW1T1sGNp
 R44cAhSFu4oyAZtq0yAE4TF3O7aWBabdP+eKUA1FgwQ0JAhxXDG2/nx3kftkY+cH4b/9
 CsqR/ttV416cdxcyDhKdWeyU5IvGI2IRfCLNr/E1fe7FGW700zdzksSV57buPvwZ7xI2
 mnxa2AYX1AaEzKPzm2e7hOT3JDm9LZ0lu5T/3bc5Ms7+NaDftGa1b7Tx96ZCs8TW1DB4
 fXhtNWtSnIjNgqJEUGcsaHrzTOMA5PkRpWdKOc93cph1RLbw+GKJZpSc1xZn/A3AHYBr
 7qMg==
X-Gm-Message-State: AOJu0Yx5SiYdsKL7TuO1nSDL6sfHRHo+K347/3SxDLm3neGUrrbvzpEZ
 rg2L2g13vJ0snhU139tTxuSYDe5Gwr4cTEJI7tTvZybwr8DaReDlNqqAlHwrjyubzFY=
X-Gm-Gg: ASbGnctGnCRtrpI5Z292ymWL4FccZ/Zk2Yw1ubJEl8f49l1sBep177ktyTghIMS2AoF
 gS1EKGurrg0U2G2ccfAoMa7w3wH33fhgZsv40J5Jw/sgnAIG/WBFT0ClOMTZsSaYRzo3izeNZOQ
 lpSXAE+33PtdobHI0FaTgcpfphmnxYYr9VtKXTcY8jKz1Qqtk3YfyC28hbeZi8sC8+YBDYWHp0W
 pztM74sfvvrme837n+EKChcLu/A1WMoEvVWETQfC67No2aJPjoxWkO6JzOStCyKT0uI/jaSkohw
 RnMw1J5SNF32B4zc6Ko8klTKZQPWcvFZFBlbSAWVr57S3iIbIad3R4WG
X-Google-Smtp-Source: AGHT+IHW8f352DJTHNwY13hBpzBUHbrFmCcRxESA5/JbyMur9UUn+2uzCqWAKTElaL/C4R3nlO4ZzQ==
X-Received: by 2002:a05:6a20:a109:b0:214:70c9:37d3 with SMTP id
 adf61e73a8af0-21fbd66f922mr1599214637.9.1749899012515; 
 Sat, 14 Jun 2025 04:03:32 -0700 (PDT)
Received: from bong-com.. ([210.97.55.153]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-748900064d1sm3242602b3a.61.2025.06.14.04.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Jun 2025 04:03:32 -0700 (PDT)
From: Haseung Bong <hasueng@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, thuth@redhat.com,
 imp@bsdimp.com, kevans@freebsd.org, Haseung Bong <hasueng@gmail.com>
Subject: [PATCH] Subject: [PATCH] tests/vm: update openbsd image to 7.7
Date: Sat, 14 Jun 2025 20:03:23 +0900
Message-ID: <20250614110323.68832-1-hasueng@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=hasueng@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Update tests/vm/openbsd to release 7.7

Signed-off-by: Haseung Bong <hasueng@gmail.com>
---
 tests/vm/openbsd | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 5e4f76f398..2ea86a01ba 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -22,8 +22,8 @@ class OpenBSDVM(basevm.BaseVM):
     name = "openbsd"
     arch = "x86_64"
 
-    link = "https://cdn.openbsd.org/pub/OpenBSD/7.6/amd64/install76.iso"
-    csum = "60cba8cb391b50bba8fa10fc768bd0529636f5345d82133c93e22c798d8e5269"
+    link = "https://cdn.openbsd.org/pub/OpenBSD/7.7/amd64/install77.iso"
+    csum = "da0106e39463f015524dca806f407c37a9bdd17e6dfffe533b06a2dd2edd8a27"
     size = "20G"
     pkgs = [
         # tools
-- 
2.43.0


