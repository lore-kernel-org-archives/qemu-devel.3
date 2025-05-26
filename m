Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24DCC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 11:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJVvu-0006EG-5w; Mon, 26 May 2025 07:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJVvs-0006Dn-Rt
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:23:52 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJVvq-0001og-LJ
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:23:52 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a376ba6f08so1308149f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 04:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748258628; x=1748863428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eBGwQlwZ+6QGRXgMdQzQc4jM3DmB7HQy60eVzHQoFMU=;
 b=nT3z7VtfPu1/fwTZHaTY1M6/AAHA+z0XMOHao2zT0OI6LxiZcOaZQyYO9+YmylxFM6
 pFFj8TuEpBwf7ELhC6Q23u2LSzW3BZ2h1srmcGcEOkYcWRDS8ByQigBDOS4lEzTnxDp+
 LtRa7t975QeHzX85dnfm4Bg3RBJORxQ8diXqnAr3VoxNWqKeBX64Sy2+r4boWwqhuUQW
 3eYiwF516awUcqb8TzV7xRvHzdz7pgmXQG9rkqpEtwmlR5+qY0Vb8AmWYKXHNgqgg38X
 Q5C/RPVYZMLekfKTNgeuowmoj/QwvRaOj/23W/0Vppn4RuSBQUtYXmEfZCwmIpPHPmlT
 NnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748258628; x=1748863428;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eBGwQlwZ+6QGRXgMdQzQc4jM3DmB7HQy60eVzHQoFMU=;
 b=mO3z7csh4lEZ9ZwXzh1eQmLbNQtVyjy4jArSqOCVITuqiTCW59uk2tETyS8ucn/eaE
 ZYSJDJ+UVt6qqyY4vSbi7PNCeoxIeZpBBUsaiWox/7WG6OVvL0KEL+B8gD+IlqQ3mFMI
 07hz5JVig44lupcVgpdxYSF6aO/T1ANs4HS2m0KWqwuNvIBceVDtVAZDg/5uB/+H1AxR
 KCRv4h7+qhM+d1mgpbi/3DTnc+jQ7Or+mbf2Xgh9sCnV6VioSUr9AqZJT5f1LZtuzFn0
 nydgUloq/7BFKx4mHLx/3J7bLQk/ZaJnx+uAgh4cDyPZTTSjayDXHdk0IWrqL1ilrc1i
 Q3SA==
X-Gm-Message-State: AOJu0Yytas82xdal1Jp52ySfCIxiijzoRA7fwwE020HBLixzy74ebMgV
 ofuL6GbJDH8U3kJABxr07+P6jT+cf5zOgekP+b8tS/bzSpPPzXPIXbzP8C8JmqRwCHMYPhSVz8F
 Rp3bI7uDyzg==
X-Gm-Gg: ASbGnct1YOrHqFDqzGrL8R7k4CYlX1mccRTa7yXijPr8cayA0cO4e7t8ZIcM0AzPlcu
 f0aVQpU4UXomEbzXfQkXAfALcxqaT2HSdcM898ya8G5gj+Ia0eDpLbnFpCwbkHalP2lk6PXUhZO
 uIF3bBbyZUR4/xA51gc/VhlJ9bP4DbWuBZfn/zZXwIqjAmpW9SVXAKyKY6gqPUFfv6+wTHOJUbT
 RpJjsbBrkr1+reDcNNsl9RytWjzLnYBUC3dv9z/rOz8f0pAiNCNSUZb3NIXMVHpltkJjGYm4/HH
 uMWV1uPiekuit1/GHosqcqsEOHx47t2FOCMwB2p2KFvxQy0N1MFxhRAD6W3eVUFtY45OWoEAzYJ
 6+iyUyWzdOjHXEc7A1z3iluJDUB9xQXQ=
X-Google-Smtp-Source: AGHT+IF2aYSU4hmJgFiOP1+lPWO9giag8jHZGAwVIdjRhKWB+y7bRp6vXHqUShYNZDwoxdkjgCxigQ==
X-Received: by 2002:a5d:588f:0:b0:3a0:8495:cb75 with SMTP id
 ffacd0b85a97d-3a4cb449dfemr6832152f8f.9.1748258628187; 
 Mon, 26 May 2025 04:23:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a37fb452e5sm17011426f8f.20.2025.05.26.04.23.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 May 2025 04:23:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] hw/ppc: Fix --without-default-devices build
Date: Mon, 26 May 2025 13:23:43 +0200
Message-ID: <20250526112346.48744-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Fix build issue reported by Thomas:
https://lore.kernel.org/qemu-devel/2d6dead5-f56c-43cf-b7d1-9567fef99616@redhat.com/

Philippe Mathieu-Daudé (3):
  hw/acpi: Build IPMI stubs when ACPI is disabled
  hw/ppc: PowerNV machines expose a I2C bus
  hw/ppc: Add stub for pnv_chip_find_core()

 hw/ppc/pnv_stub.c   | 15 +++++++++++++++
 hw/acpi/meson.build | 10 ++++++++--
 hw/ppc/Kconfig      |  1 +
 hw/ppc/meson.build  |  3 ++-
 4 files changed, 26 insertions(+), 3 deletions(-)
 create mode 100644 hw/ppc/pnv_stub.c

-- 
2.47.1


