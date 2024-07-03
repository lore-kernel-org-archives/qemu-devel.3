Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845ECC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvpe-0000RY-UE; Wed, 03 Jul 2024 04:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvpb-0000Py-Hf
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:59:15 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvpY-0005pD-MD
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:59:15 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2ebec2f11b7so58250311fa.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719997150; x=1720601950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wS2U9HJjfkSENe7/SIRB2TngbCMtAJMpJXX2MGQJH8I=;
 b=C4M0DC2iliGJdFSYFrMP/h//WkcOeoPfqQSojo8eQd288WQMyyDQJrV7FuSnLfeBzt
 O/gA4xa+t+YQrHVNxlEupM+M1EA8a5QHqzOlkA0foyVdMl0lEn7+Le5l3wptIjWR+Uth
 QtURFlqtCyCm/X9Lork1I4EE7fogL6ybHSImZW1Z/rZ8xW4zYDmhLZg56SCU8sKUPDhs
 JHUMin8EFtaTsLFYO9zu/kUQtcJAKPPdhIbH8tjzNVkf4YdxlbY782bMU+ykfd/q9xam
 Ni5gA3APItiD9GUmjxptmFhJiSVHgnQuXBxwSzfoRk31NcbJMabgIkfHehhiPANH0aEt
 mhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719997150; x=1720601950;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wS2U9HJjfkSENe7/SIRB2TngbCMtAJMpJXX2MGQJH8I=;
 b=uWj/aL1mTNv+fTjqhJCu5IjfnC1CkqPX8qxTPghhtfuW8GRRUI7P6AUCfXzZmmjMcG
 DE3K2x71AXTCBt5A2NJWBc3LU9W1I2ahTgOg1FNWwp3cYDzX+HFUo8E+CuzraP9kUzSl
 mj15GnX0vYhXla5WxLiKMknhGYjlyQrBylhqrfBzfbiq2EqUn+E+XU5bpZ4S25i0bgs0
 cwvYzcU9rcF1tmG/h58RvOEQ/PufHiUQJm+pPzC8kulMjTXgLFry7dSigxxabnTC2ll7
 6yoVH4SZ2yaLQwZdLQVR4aU0AD4n8IIH4cA5mJpiMFu5Wsvm4bDkHRUWmq/7qLG8RgLF
 ypEw==
X-Gm-Message-State: AOJu0YzYVuLbI0ZoH01rITJ4Chr7T4pdrgD3XKN0GGD2FcUKSGKQTkaP
 aG70ZwoX8oTpSSoiSLCjlP1l09S8qAnCWTuVk6dwF7wneIroPXYFqrSF7v0BAoTejfRMpup2WLk
 1
X-Google-Smtp-Source: AGHT+IHqg5ZuAP2AXiXy4PZxcR/BVJYSO9kG3a0LCGcjJ4dl/sfnZloKZ6l0zf823H+dPlbiJECpGw==
X-Received: by 2002:a2e:a813:0:b0:2ee:7b7d:66ee with SMTP id
 38308e7fff4ca-2ee7b7d68f1mr17810411fa.41.1719997150552; 
 Wed, 03 Jul 2024 01:59:10 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a1030dfsm15250922f8f.100.2024.07.03.01.59.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Jul 2024 01:59:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v45 0/3] hw/sd/sdcard: Cleanups before adding eMMC support
Date: Wed,  3 Jul 2024 10:59:04 +0200
Message-ID: <20240703085907.66775-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

(patches from v42 already reviewed not reposted)

- Addressed review comments from Daniel & Luc wrt migration
- Remove old comment

Philippe Mathieu-Daudé (3):
  hw/sd/sdcard: Remove leftover comment about removed 'spi' Property
  hw/sd/sdcard: Use spec v3.01 by default
  hw/sd/sdcard: Do not store vendor data on block drive (CMD56)

 hw/core/machine.c |  1 +
 hw/sd/sd.c        | 35 ++++++++++++++++++++---------------
 2 files changed, 21 insertions(+), 15 deletions(-)

-- 
2.41.0


