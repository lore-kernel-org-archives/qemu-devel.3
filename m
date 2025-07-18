Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF07BC83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 17:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucoR5-0007kR-P5; Fri, 18 Jul 2025 12:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chichikalyuk@gmail.com>)
 id 1ucnt4-0007fb-I3; Fri, 18 Jul 2025 12:24:42 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chichikalyuk@gmail.com>)
 id 1ucnt2-00076F-ML; Fri, 18 Jul 2025 12:24:42 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-55516abe02cso2326558e87.0; 
 Fri, 18 Jul 2025 09:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752855877; x=1753460677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4fvsdLfmb83aU2Sh4Qg/fqQwyzBBdQVHUoJEX1nqKVw=;
 b=YnnL1y3gejWQiS6o71FCM0gHDhGJkh+Ur5xaVsGa5LNi3Ji9SXR5uUByeKi8tX9VwM
 3d7jeJCjUyz4bWqLc+M61BoRtKdn5qDe1kbKbi/2v2ZhokBJ+o8xo3fCL0/lbdvY00h6
 GlohuLJqPZTnng3hTcjNKoH2fIco+P3kZKuWckLs1Xp4wsrmtiakVd6gToH2Mj3Yc6yd
 D9XMHoDfkI8P2onh7qHeXeCEpxumcACOqTNoS8nQ2i6wJhYKlM36diOOugftRdQL25gr
 lu/J16M3J3cVBvXna0QNu0Je6Qvaed8ceXzBmxAENmZ1g7aPIiJrlaLM72O1ZEkhqZ9m
 7TdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752855877; x=1753460677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4fvsdLfmb83aU2Sh4Qg/fqQwyzBBdQVHUoJEX1nqKVw=;
 b=L7fyvTnqdWItUxTVT8LUb+Nh3iSV+1w+TUC6j6X8nl6TaAvfDb0uqUA2TELNk2tTut
 7cNMJ1zNJ/1BirwLdglo0OVZIHdkU/bB3OZDW265sW28SxwV59QCnY0TZdlMVkI7A3K+
 z8t2eds/e5o91h7MPHm/t6vL80WCi4iqL2OHv/5Oy/7aVhJnwfyTgDY0qpLWFI1dFKuO
 3d1IKX8qrVV+Sbw3I/POTU/cAxz3cUp8vvMnHRkLbPE4I60/gE0+KHJOU7g5t98+QTcE
 QfNkyr1HXhTM7PCAFMMpLks5b4UQOqr2OcirPJhWB7iW1StPFFrllvif5NSAjz25KKQt
 G6pQ==
X-Gm-Message-State: AOJu0YyM5eQM0MTsOJdt/1MZx5FCP3+EJCjjmgivnRggyTHpvb6QGwyT
 nIY15DRHHJzKgGYYgWl+RePL0iqreMdKr52wqYrA9DAKyjIbTWTj/5bVulF9ns8TGzafPA==
X-Gm-Gg: ASbGncuynX9dHuumGk5m+M285u4Vs0XIYe8DY3Acy0sqQBLUH/atVfD5FUuOa4Uojnl
 HPJMtInMEuNtt424/I9L2ThGvuFYFxopNG8UvzTkccPFauuxxnRv94DZUK/ZMazDj9/XcaBCNZc
 YSGDoSo3uWiNCZYRkNrt7WksmVEXF2ixjp01E7HX+MSohrrlkfl5lG8WX/CTsJg6p2vh/9PpPRI
 DOU9DBWWwwGdwaiucwwMxHORbqHqlzxTrVuPkLJoXOoCSEYXBcrTDJljVbSZuysg0LCaG1m6Key
 RQ9A0YE3FBukGTOz+L63CC0SfGB9zb16HopocDkUxp6vBEUBNOWAc3nwvGagqTnD4h2l/mCrZX7
 WlXW2A+k2q9UkirFjWqcRlIKGftR2H7l68lwWElP5tFZLfDNDStC2LRwNV9NHjpguvj0kaBvD2r
 ESHh6+AL7GXXK4oA==
X-Google-Smtp-Source: AGHT+IGU25PLablMzKwTO5FI2bsrYyo8sQ1RpC8WQgSQV9PH00Xa2Pk8aLtDQR04n63VjmGRG3DrHQ==
X-Received: by 2002:a05:6512:1296:b0:553:a294:3f8 with SMTP id
 2adb3069b0e04-55a2fe38ecfmr1383553e87.14.1752855876964; 
 Fri, 18 Jul 2025 09:24:36 -0700 (PDT)
Received: from localhost.localdomain (m91-129-102-83.cust.tele2.ee.
 [91.129.102.83]) by smtp.googlemail.com with ESMTPSA id
 2adb3069b0e04-55a31dacd84sm310615e87.206.2025.07.18.09.24.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Jul 2025 09:24:36 -0700 (PDT)
From: Vadim Chichikalyuk <chichikalyuk@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Vadim Chichikalyuk <chichikalyuk@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 2/4] tests: acpi: whitelist expected blobs
Date: Fri, 18 Jul 2025 19:20:43 +0300
Message-Id: <20250718162045.49012-3-chichikalyuk@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250718162045.49012-1-chichikalyuk@gmail.com>
References: <20250718162045.49012-1-chichikalyuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=chichikalyuk@gmail.com; helo=mail-lf1-x131.google.com
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

Signed-off-by: Vadim Chichikalyuk <chichikalyuk@gmail.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..2a30472d57 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/SPCR",
\ No newline at end of file
-- 
2.39.5 (Apple Git-154)


