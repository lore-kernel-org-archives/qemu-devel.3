Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4DBC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 16:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOg5Y-0006ev-DB; Tue, 02 Jul 2024 12:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOg5W-0006eH-CJ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:10:38 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOg5U-0008QW-FC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:10:38 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52ce6c8db7bso6752650e87.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 09:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719936634; x=1720541434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=meeckgI4VIWDYOJOBwaUzIzKqWBLrnAVpWbI7HYkDIY=;
 b=KWufI3OS9XZqoxbS+AbHE/Q/AzWbVbhQdOII6EJpgNae3ec/nAsK1woVTwsBBlfHLD
 xKeKUL3ikN6DyjuI7V4CRTf8jF9WqixHibvmUO10Pnk8gWIntapzVv+pPBE+vV42i3SN
 RjCLJysP7ZNuoEm0F7MoICHd7JMXQR9cqB0wNGs+Z/GOJICd5e4GXnhJea1ePlmimNM7
 M79nvEryukBYYLI9nPzTuiTJl6/A9GZKKosaHS+XBKCjj/izDqCC76RtrEloysJr3rWD
 9ZTPzRjZ9hEju20GX08+9/7+cOfrn3HJT0/uk6uvNBUgxYec2IF5qKWyBQqD8uWHC39W
 Od9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719936634; x=1720541434;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=meeckgI4VIWDYOJOBwaUzIzKqWBLrnAVpWbI7HYkDIY=;
 b=WVL6Z4zxoS1Fcz1tkfpnHUpcndt5EKQMZvqqLQtlUP2ejAMuj6J6HlulP1kAmvtryQ
 wgZuf4+K9/3mlxw4/1aamlKFj5vXd1DUiAdAf3g7UN/8FOb0lY3XX2VQFXc9dk21B94D
 tUzOucCc1BagoxyoXD3WdP24GsjEfmXf2nV7dBh31dAhaoZXo3cwVwVp7PVfbbjq30l/
 GSsmsh2PHkwjjyCj7/QXQjyzJkYbUy4zZEugKWVI8aFIQG19jESC2I/Y33jTU6ePlW6K
 IlsKeDHuT5mt3YH4LLvQkxtMDu9AT+ALDklm3hkG7IHZW2C7Mum5WK/aoZssyBvuvKKA
 +vWw==
X-Gm-Message-State: AOJu0YwF7F3NQH/Wdz/8VsUUDoNQe9l+N1J0+h/KJA7mogIcsFIaMOLD
 x4XjA1roLZ+ATUgBLg1LICDKL3F4urjqgu4MEPIZKqI9GSIYz0X8iJGznukt+vRQyhKAavBriST
 V
X-Google-Smtp-Source: AGHT+IGyERsoHxJybXoKsIV0Y757Iu54pmoheYA8eW5txRerl9o0Cn5sb1nRfBVDj5LMgoYzmlZVFQ==
X-Received: by 2002:a05:6512:318c:b0:52c:9f24:a253 with SMTP id
 2adb3069b0e04-52e827528eemr7057744e87.64.1719936634313; 
 Tue, 02 Jul 2024 09:10:34 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e1688sm13677581f8f.60.2024.07.02.09.10.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 09:10:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-block@nongnu.org
Subject: [PATCH v43 0/2] hw/sd/sdcard: Cleanups before adding eMMC support
Date: Tue,  2 Jul 2024 18:10:29 +0200
Message-ID: <20240702161031.59362-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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

Addressing review comments from Daniel on v42:
https://lore.kernel.org/qemu-devel/20240628070216.92609-1-philmd@linaro.org/
(patches already reviewed not reposted)

Supersedes: <20240628070216.92609-1-philmd@linaro.org>

Philippe Mathieu-Daudé (2):
  hw/sd/sdcard: Use spec v3.01 by default
  hw/sd/sdcard: Do not store vendor data on block drive (CMD56)

 hw/core/machine.c |  1 +
 hw/sd/sd.c        | 18 ++++++++++--------
 2 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.41.0


