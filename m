Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F080CC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvih-0001Vi-VZ; Wed, 03 Jul 2024 04:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvig-0001Ui-11
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:52:06 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOviV-0003jF-GZ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:52:00 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ebe40673d8so67783401fa.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719996713; x=1720601513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=30ooK7pvc4r31wTfme1GfubhHoLiEKcc7Cn5iSBvJNU=;
 b=MBMF3DLgr7yIi359sDeVtZOibMVigcz2Lnw5IGHLqH3O+gu+jnQP0VhwqErIOnsnze
 6Zr930hXEBfEkvcyLZup7eknRFAJkfO7362hy2Iap3HVrluFZ7IVGh2xFWNvtnpUhYqS
 3JidFs2UeeHNDeh7Abji4wa89EzNGXbcZE+stPwLS7IQGyUekNvNtO9wEZZvXOaiHImV
 re4Ha1h+AeOuyqrs+iMt4aZlvGuszOAiRE+9DO5lI0FEgwcLmJBNFUb936eUyLEuytCr
 jkJbSn7QgGtE7sEXIcqo240EDUVE2kJQqqKddzYEX4nkf3tcK20VgDI6WsxolmpPK14N
 DLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719996713; x=1720601513;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=30ooK7pvc4r31wTfme1GfubhHoLiEKcc7Cn5iSBvJNU=;
 b=kAjAHsZgTbrfzlOqB5WfG2DLo1sKNKDHSkwWv7tK3uxeHL8kldXxR6LbeBduqKBm9R
 txsxz51biw7yZLiIE1NpHcB7zFb2XtiImsSIVZbRvlIvnmamYOdOWSCwG3/NsSaBy981
 tM97SgNje4PLPFe6hrcZKfdi23r9Dl5xMaWH5z7U2WkAlOpi2f3C9wr8Y8+KdjlXF44/
 cwWzq8elf30h0KrKJ1I7w1y7qYwwTQNW8AcP1u++DJdkrJksSs/DgRUjY5R+MKV5EF45
 QwcQq3ppUEg5hsTvv9urcmBzpia/ZwQ80hlfK0tJbOdMmudslD7y6Az8YAG3USCbgCKe
 95XA==
X-Gm-Message-State: AOJu0YxvnKoDnrjMkq6r6vwWN6iyvhbBmgFvN0ZF3XEX5t48RwvcFj9x
 f112U4lkyY9x8c+XVNfFSlNAsdw1rLKnMCU6APt8yZjTRggVvvf+7fVyFNSwI4aiGiNVkTvoats
 2
X-Google-Smtp-Source: AGHT+IHCTfl2BpNdrOW3oIsvUop27uwYSlsWwKJ6U3llTQ5/L5POLlidarhprwyGdKdQ4iS7fwIJ2w==
X-Received: by 2002:a05:6512:1043:b0:52c:891f:d732 with SMTP id
 2adb3069b0e04-52e82735c74mr7583052e87.56.1719996712126; 
 Wed, 03 Jul 2024 01:51:52 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3d004sm231168265e9.4.2024.07.03.01.51.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Jul 2024 01:51:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v44 0/3] hw/sd/sdcard: Cleanups before adding eMMC support
Date: Wed,  3 Jul 2024 10:51:45 +0200
Message-ID: <20240703085148.66188-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
  hw/sd/sdcard: Use spec v3.01 by default
  hw/sd/sdcard: Do not store vendor data on block drive (CMD56)
  hw/sd/sdcard: Remove leftover comment about removed 'spi' Property

 hw/core/machine.c |  1 +
 hw/sd/sd.c        | 32 ++++++++++++++++++++------------
 2 files changed, 21 insertions(+), 12 deletions(-)

-- 
2.41.0


