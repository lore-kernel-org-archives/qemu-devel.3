Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49F5C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 20:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbnGb-00016I-IH; Wed, 07 Aug 2024 16:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbnGW-00013b-GI
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 16:28:13 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbnGU-0006r9-Dc
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 16:28:12 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-36868fcb919so136185f8f.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 13:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723062488; x=1723667288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2G3r201lny1N/UVVBwud27b5XF/bTfvVVUdxCT605jY=;
 b=LMXNPOE5J7Us2DWfjPOIELvT3ltKOZIlBxM++fqKzB+30hhlgeiZa5cWpMwZ087P/u
 LqkJIRbKmhu4dzKSVo6SkKoB90EDmJ+y+4qS/i9CaSSWc/4cVNOrMb6XrpUhZ3WYPsAm
 wa7jQPRcDw45r91tG21L2W17QkNAEFNpOLFvXzmObFrj0N/I2qMpdzUeVCqsEh0PqF/D
 qEOjp/BMSHhL3MdmIkXFqaB+5MgRrwn7HFsh6xjpoyoRqeYZMwGoMcuIh8wY17mXw3mT
 sh/gt1rHcxT60fuQEMOmJD9BvbslVkZW6ei83r2/W0id7ipkWX2aQF9kc5ASDXzkhvFF
 UL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723062488; x=1723667288;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2G3r201lny1N/UVVBwud27b5XF/bTfvVVUdxCT605jY=;
 b=bM44/qxQOzkZptt0zE+o6vBVEynQvZrZurvKViQ0fCyr57RoUXb2mbKyCDXc77Qs2o
 lOcrRuJOGNpuvYnnNxoMWcegeKH3GGfwoyr6Mx3ZXQ8IDKgCYklBj9oHQQFmydP4HRFu
 8gTsTuAGiUyPOI7lT3CDX7ve9hngR9rNHDqIEVCZtelfgR62/0Hn7JYcQ0iZ/kmn1lD3
 FgQ8DVA2aPJo5KEfPbwj+duShBDoy0NQiLKa+Gpb1kAHGCY4+mmpAln6P8zNcizUREE7
 g1s2BXOJgt21CaQyQ0ht/JEJuZPICrFuo4lyyFnaP5pqkLvJfaA1iQfUntE7yGNsR3+p
 M7IA==
X-Gm-Message-State: AOJu0YwnlD9sNtsnotiCy0Aw5NjHhEh92yPaF/Wacp13HDkGObXBS7Ws
 Z4DpovoCpy+Zvt397E+jAhXb9Dbb+EGCIi9IFWNjqXjQcjcWsOMF8OzE2K5wIB1nQaGQ/i6xlqB
 s
X-Google-Smtp-Source: AGHT+IHBylfGyK0XEULa2Ei4LOWO3osb8YRs7pziqrs63MNArdikJ2MENWRBwEtjV2ORt6tNrpMf8g==
X-Received: by 2002:a05:6000:d8c:b0:367:9988:84a0 with SMTP id
 ffacd0b85a97d-36bbc1c2b01mr14212066f8f.58.1723062487985; 
 Wed, 07 Aug 2024 13:28:07 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0cc58sm17031041f8f.2.2024.08.07.13.28.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Aug 2024 13:28:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 v2 0/4] hw/ssi/pnv_spi: Fixes Coverity CID 1558831
Date: Wed,  7 Aug 2024 22:28:00 +0200
Message-ID: <20240807202804.56038-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

v2:
- Cover PowerNV SSI in MAINTAINERS
- Use GLib API in pnv_spi_xfer_buffer_free()
- Simplify returning early

Supersedes: <20240806134829.351703-3-chalapathi.v@linux.ibm.com>

Chalapathi V (1):
  hw/ssi/pnv_spi: Fixes Coverity CID 1558831

Philippe Mathieu-Daudé (3):
  MAINTAINERS: Cover PowerPC SPI model in PowerNV section
  hw/ssi/pnv_spi: Match _xfer_buffer_free() with _xfer_buffer_new()
  hw/ssi/pnv_spi: Return early in transfer()

 MAINTAINERS      |  2 ++
 hw/ssi/pnv_spi.c | 12 +++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

-- 
2.45.2


