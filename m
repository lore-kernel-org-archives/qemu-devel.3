Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DF3CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 13:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulpNZ-0002RK-Mn; Tue, 12 Aug 2025 09:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulpNX-0002R9-7M
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 09:49:27 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulpNO-0005Bm-9E
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 09:49:26 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b790dbb112so3393520f8f.3
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 06:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755006552; x=1755611352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cKcO64ShFrfRsSCI/jgxMemhLXevpF/HYu5Ube0T9Dw=;
 b=ndEBB7DPjya67dKfNdU6BAKviPzrGR6Y3LAB49X7XetRwGmq7LCsThhNSFaqIR+dX1
 fu/QmVGEvwY+clumAW6r9KS4CjQVOwV53fbXD79lrgfKa1+3+OgMSfc6+C/x5liu4rCQ
 w2nNNAAf+wBDB+Vm/gTnfVzSQcuga1hD1fuwO16Gfk3jIftxJjYPWbpRt89c+i9GVSJq
 ZKne6h4XY/T3JLSLg+FfLWaIjXNLtGNl2LLq6EcMY9y29IxAHtF3n4n5GqCFtWI42cgs
 g4VSFg/FJEtuyIOzeDiYIAvz0oG9AqWmsQepeqP+jfA3C+AirndYt/QDbb75Ekv7Drc3
 Kx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755006552; x=1755611352;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cKcO64ShFrfRsSCI/jgxMemhLXevpF/HYu5Ube0T9Dw=;
 b=nyqWJqeLems82W2UG5awZ6Y4ZsDy+rKbu6W528RoCuedYDGsWhjNa6stdeDt2jzzrf
 SA2C01kFrRH90JU+LyHsHmFZoJ9qonNZtIK+DAIv3DHHcKpLR9w6pNLBepXIGsSckrl6
 N25PE8JV9VAUnF8NLOuCxUiXHYV2DHvUn4HhcLSkZkf7r4cCEAqQoBQaqcZfM0oglSG/
 zUcQeL79InMpLPullP96EYp//Wf/gyR0MxeSxVBinRUQo/zc+TNQHdVHmZuJ/TdOYaA5
 4fgj4hNGf7HpqdCrJoz9qRNhvoenr2ADqWxzeyO/3Uf9afPg0hgMGL0RH5uFrovkJJ3d
 UloQ==
X-Gm-Message-State: AOJu0YzBsx4s4VM/efwF/fE5l55a0EaIyQwVLHClTrow5FehWaGKFfzs
 d4PkiFcc7sQWQf7hflzWabKPFTswZ6qDOfnVZs+FvhwxhvOYu6ONJ7vg99NLVe/E8yJTEnnpgd1
 El0/Z
X-Gm-Gg: ASbGncviqjWC7QQrYcyGzy4wspot7N70UQAaMEbO94Jj0mro8WjX0cXrNxASSVV4KGx
 OfzTrZCJTsuIFwYK5/QwOtj1uFRzPogfykHiAvoWbHZtzVvZFNITNrrZEnIY0l7kmfNqOa9ceQi
 Aq3+QUyU5S2SDWhLgJJ0PNAdNrHj7XClfZtLv5AsNMn4Srhrjb6fd+UuREp3OFLzAlldQT1p/r+
 GRv+ThnaXUoXjvPndH8g77Zy42dccC2+MhfEd+e9HaNDTMJ3dPh7A/zkoWUj5vsz4bKfkz+j4Yr
 nagk69hqCdwzZrWl/EaDnSLb7GPjYKymH8fob+8bzUXILz8/RP/mQPy4jq3SBkCOXjWEnslyRcv
 UUx2A38srb+Fu7Tq4AywZhdQwH0rg8myCMnSbyDPU5G7Kf4QOpnZACthmu6U4bMWV5n9BV1ot
X-Google-Smtp-Source: AGHT+IHUYe4A7c1ysZzI1PQmm5BEm6pRWRY7NkaP/NXgKb8U2gwDKYIWd+s7d7VyUBN/FOSA4svl5Q==
X-Received: by 2002:a05:6000:25c2:b0:3b7:9c79:32a6 with SMTP id
 ffacd0b85a97d-3b911010e6emr2229279f8f.47.1755006551893; 
 Tue, 12 Aug 2025 06:49:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45923c34af8sm399709575e9.24.2025.08.12.06.49.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Aug 2025 06:49:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair@alistair23.me>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org
Subject: [PATCH-for-10.1 v2 0/3] hw/sd/ssi-sd: Return noise (dummy byte) when
 no card connected
Date: Tue, 12 Aug 2025 15:49:06 +0200
Message-ID: <20250812134909.69531-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Trivial fix for the issue reported by Guenter here:
https://lore.kernel.org/qemu-devel/5b2dc427-f0db-4332-a997-fe0c82415acd@roeck-us.net/

- Return dummy byte when no card is connected
- Add a test
- Document ssi_transfer()

Since v1:
- Reworded patch #1 description (Alex)
- Removed '_' test method prefix (Alex)

Philippe Mathieu-Daudé (3):
  hw/sd/ssi-sd: Return noise (dummy byte) when no card connected
  tests/functional: Test SPI-SD adapter without SD card connected
  hw/ssi: Document ssi_transfer() method

 include/hw/ssi/ssi.h                      | 14 ++++++++++++++
 hw/sd/ssi-sd.c                            |  4 ++++
 tests/functional/test_riscv64_sifive_u.py | 22 +++++++++++++++++-----
 3 files changed, 35 insertions(+), 5 deletions(-)

-- 
2.49.0


