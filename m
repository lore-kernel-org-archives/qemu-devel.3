Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5502C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 13:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJXRT-0007iO-Sy; Mon, 26 May 2025 09:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJXRB-0007ds-GY
 for qemu-devel@nongnu.org; Mon, 26 May 2025 09:00:25 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJXR9-0005Rd-K0
 for qemu-devel@nongnu.org; Mon, 26 May 2025 09:00:17 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a36e950e41so1380080f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 06:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748264410; x=1748869210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uoJkKz5SKNxJHBStudSV9HJCiU/biJN0vBgIQNTr+JI=;
 b=UG+2Ocf3E+BedvbR6ardCTAnPejuJnOutSoTrxvA63j8arv0RRw82P9YP73P8PwLfz
 sTGd2t2lksMocOuDL5eZc/CH+unRBlKM6m2ENN5vxrY1zJlQ5oN87mNsr1SapUM5hPTd
 CsOKwXy6OCAvjfsjRo1mLieiIuKefnnXGf6tSpVnQmIoxrnLZ3DR5NF1JusFWiuTt1Mv
 h0SHSOZAQ+WixRIQ/pLY2kZ1TwKm+qhyY77NPbfnJ//uE3kD+VbEd2JNvcw1VXzuyC3X
 L6dOyrkuxdRgqNtxUBsJZ9QQE6RLXJ0VcNJgLTHLcY+0r087eVw7NzeyfLsNBRXqzzYN
 u6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748264410; x=1748869210;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uoJkKz5SKNxJHBStudSV9HJCiU/biJN0vBgIQNTr+JI=;
 b=tTa7LW8zxuF3jkAgjNmXnexfmtZgDmj6iakG/hLi/f+p8hnEwJt5SgDRCvPnDo43x2
 0CpF0LACqHQr9fpXfzD2OgCGj+OHqllWjdyKgCpOgV3p8NYeajNx8jcR7nmDp257D6UN
 Msv1uS5Oexm0YAJox68JyYLB0nnAfgkDK71IoMar/rvDaEYlMAx9FDAuMirHiO+mNMDA
 r16KUJJqJIVa3sHbU6gQHZVekc7XE5Ci3bR1Ht3eqY9Qsva2ndOkaykkmfPa4nXa0LyI
 0eF+RmTg77f8G1AKyusEa591c0E5IyuNw/y/fhnqIPs886JQXiFRKNqBASTnmhz4jrGp
 LaDg==
X-Gm-Message-State: AOJu0YzB5B2HW02ayGGqQPwaLw37AicFLRDED/Hb8+mVhuMk7CbUpJ86
 du3xdJWKzwTvweA7ZJjixNKG96iQF6ZPv7mKk+gU3GVNyeUrO/UC6p8nxy8l+3SM/FAP821PCgY
 8ZproNQffbQ==
X-Gm-Gg: ASbGncuglpzYpeylFSq7a7x3AM696Zm2sst8ej5ncgUUg2z7TWTo7A/6NrMX7jJ9kJG
 Wp4det1Aui6KCSu22mMFzcYGLo31HLK0lvQneeP7TB21D5OfkkeirfnU0v2zJ3vcNZOsITW+swh
 WXZWEmIn85bwQTgStk03aH0E7kEab2Cyxj9VIQdqtYpln18bghCRtcfXrAmhKXIq4mqHF3qqPTL
 ealDl4nP8u8DiC1GsvIVNqyobcjBUI9DTPhlik0iskc9NdovMkvSzEyQyxG3wRkH8pbLnpTQ2Kh
 YEL0UFP1N76yR7th4hk1ZvtUIGD0BS1VqbmCPf9s61J2LcZ/64uPU4hKVAeypBi59xAKKsZnXuR
 CREPYRE7Tbt3I+OGbWc3Lzg==
X-Google-Smtp-Source: AGHT+IHdrbNPP+M/hhkxJkcrR9gCBUsa5bsdHB5DuxilLFlafkH7Zy265NRZexSDrXHG3fGZEX/Exg==
X-Received: by 2002:a05:6000:40cd:b0:3a4:d939:62f8 with SMTP id
 ffacd0b85a97d-3a4d9396603mr2362814f8f.32.1748264410211; 
 Mon, 26 May 2025 06:00:10 -0700 (PDT)
Received: from localhost.localdomain (44.87.95.79.rev.sfr.net. [79.95.87.44])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d90912d4sm2938178f8f.47.2025.05.26.06.00.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 May 2025 06:00:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 0/3] hw/boards: Remove MachineState::usb_disabled field
Date: Mon, 26 May 2025 15:00:03 +0200
Message-ID: <20250526130006.49817-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Only add default devices checking defaults_enabled().
Remove the unused usb_disabled field in MachineState.

Based-on: <20250526112346.48744-1-philmd@linaro.org>
          "hw/ppc: Fix --without-default-devices build"

Philippe Mathieu-Daudé (3):
  hw/ppc/spapr: Only create default devices when requested
  hw/ppc/mac_newworld: Only create default devices when requested
  hw/boards: Remove MachineState::usb_disabled field

 include/hw/boards.h   | 1 -
 hw/core/machine.c     | 1 -
 hw/ppc/mac_newworld.c | 3 +--
 hw/ppc/spapr.c        | 3 +--
 4 files changed, 2 insertions(+), 6 deletions(-)

-- 
2.47.1


