Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030C7E6C5F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 03:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIJk2-0007yj-7s; Mon, 02 Dec 2024 22:38:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tIJjz-0007y0-UD
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 22:38:23 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tIJjy-0005ar-GM
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 22:38:23 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-215b13e9ccbso9768685ad.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 19:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1733197101; x=1733801901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6+unVT0iJ51qHfPa5G/FCD6L8b3hBokRmjj3mo3WsF0=;
 b=XVLMS7SBUPWYQbdoiCxUCRb3t/5uQtjRr1kqj9lTWXqVjuiX07V7B7Y4OoHTwGcPuG
 Cw07FznL06sHkc+nIM+7AlFq6KRn0eRNc3Jm86NSCmsgUUqARZjXVo7G/D9sVS4qDkuJ
 4Fs/mOdH6yoU/9/YumXw5EnmpxVSetkaJyjwJ6d9hRpfhy04h5clV1zmaYcPG4ARehtz
 YR4nm8zsswya3XdctCVOzikxYb634yA/EMzh35j8bUYgEHvgTLnuKpeNqKW6HFaFjM+j
 LhsFTUb80rcae7279cdrqX4WDDwMNLc0pEWuHZNrqHtyQQYMTwt9+cghDshM79L+9+yC
 XSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733197101; x=1733801901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6+unVT0iJ51qHfPa5G/FCD6L8b3hBokRmjj3mo3WsF0=;
 b=vR4mvuqhQX1Bq717nkfJl5WTg2Ycdjx61QhJClOa1HLhGOwWTsKpRN9L26TpVD+NwX
 E+2BK713pX4KlsVyyM0QRCreNb9v5yNtL5ug/M/cvlcsBzoobnMwkjfoyv5QkJW9SmTO
 e6oyhLdIeabCLyiJD1fIv5mxbPKe+x2K+kiTHH3PIP2xMGycSw3YlfWbauxod0QvdHwL
 j/jDsGYyuRNIHw7tJIzMGUCksqOFoRrCGvO4rS5Xv0OZoZuGJ0HqA58VGzJCZn2aMMH1
 9okDrePpF1vgByhlaaKwEiQ1PkZNrP2xljd+CxNXZUh0V2kXnnAXpmScKSPg7r1aIaCp
 Co8A==
X-Gm-Message-State: AOJu0YwiqPtee7qC0Wrk410ZC1EpMeIEwdhDYZSqefp2hkUIB+6Ca12Y
 O5Zt26ViqTqV7mSWb7UBzPOqp9HUEPjZSl2oV9jmgOHH94AsnbWQ01O1RT7aDSHK1gzJXY4/MPz
 ytrHcjR9y4KsiBDdt/0lmvnowfFC+eqKfUeYAWDGY8o5G1ZBkVVa6nPc9mZ93h2ikNtYK8y1XrX
 e1rDHSHD7UMCTxkHeObylvAcDcZ3DEC9fnsI5hEA==
X-Gm-Gg: ASbGncvgcC9ErqwaRP9tjvxVGWsw+dnn1dP3oBmQy98yIGC/pulXdz9R7fnxrZB5acJ
 ZWhv2Pm9bOv7N+cT8pJvvaAb4kzTRZf0hInutiD5rkHY5TbOiZqhQTIt6rkabDKcteMlp1xZd9/
 vQbQaggUeBAxaGs3B/xSq4VSOptEPuU4bBjo53owA/mRgVKzijCDVBosL1VvQilWxVDFw4exVmR
 o0gvv3hP//bD8GSqLebYvZ5/noDEruCQFUFh4LR2ZjiGfffL1AuawrfrHJZo1Y7QCMMYfnB3h/y
 lFCBtRiy
X-Google-Smtp-Source: AGHT+IF54AoRZSJTTdV3rrBFyBeOMkXnmI3hPNSBNW1iG7cEI8X5C1ycKaeDLOBAh+umz6H6YnODQQ==
X-Received: by 2002:a17:903:2310:b0:215:58f0:2606 with SMTP id
 d9443c01a7336-215bcfbce9amr15371325ad.2.1733197100285; 
 Mon, 02 Dec 2024 19:38:20 -0800 (PST)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21566732e1fsm47111135ad.134.2024.12.02.19.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 19:38:19 -0800 (PST)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, "Fea.Wang" <fea.wang@sifive.com>
Subject: [PATCH v5 6/6] target/riscv: Check svukte is not enabled in RV32
Date: Tue,  3 Dec 2024 11:49:32 +0800
Message-Id: <20241203034932.25185-7-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203034932.25185-1-fea.wang@sifive.com>
References: <20241203034932.25185-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=fea.wang@sifive.com; helo=mail-pl1-x629.google.com
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

The spec explicitly says svukte doesn't support RV32. So check that it
is not enabled in RV32.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
---
 target/riscv/tcg/tcg-cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index c62c221696..3b99c8c9e3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -652,6 +652,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (mcc->misa_mxl_max == MXL_RV32 && cpu->cfg.ext_svukte) {
+        error_setg(errp, "svukte is not supported for RV32");
+        return;
+    }
+
     /*
      * Disable isa extensions based on priv spec after we
      * validated and set everything we need.
-- 
2.34.1


