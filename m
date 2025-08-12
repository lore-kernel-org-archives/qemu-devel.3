Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B4ACA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 16:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulsJC-0002b4-GQ; Tue, 12 Aug 2025 12:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulsJ4-0002aY-FQ
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 12:57:02 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulsIs-0007QO-3w
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 12:57:01 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-458b49c98a7so37250975e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755017804; x=1755622604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DStH15PbtZJttOZB03ZfwL8Sd1nE6zfa3cb0b/o4sEc=;
 b=iaP0el4KjVulecPTxWnwU1R8ACZUuDO6hBNCGyGZGoWPDsPmORnjoz/lbf1GwljwVG
 HIiYGXrYc/x6jv2XKt8i8KZfxEK+7Kddk6vNWUGfoNdswC+sMtismMgqOg9dEMxkJVsQ
 izhQNIR3uaFr54EQ1QIHhOGrQzesc/mn9SVUwV0BQpQ95Yz+hUAloSi0bwswu25naArU
 /h3XuQY26JJAvTrRkaAAQx9ZdNyDDUD8I5OV3XXdbglYTFxFI0LPuvOZjooKroJv8N+n
 d0kOUJKSlj3bW4dWPyaxb5RyMv0A3U3x7PXHck6sMVYHBQYcfBOqDFikVaBfxFrTi0Dp
 Z7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755017804; x=1755622604;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DStH15PbtZJttOZB03ZfwL8Sd1nE6zfa3cb0b/o4sEc=;
 b=reN/zUaii/DTPAvBCHCesUcbS9nVMTM/al7h4xHame8McjnrKZz7yz5s4eoP3DBiSZ
 KlEKI6MkDJd1mUjwPWjfXvXqwtKCRJWdBzoPUOg2vojAL2wEL7imwznAnuV6/9K95neH
 H+Ox8w0zFd4d7FdQsHEtwQfCcSBxiLz690DvHNmR3cSz1UtLa6/e/U4Kymzt3t0+EnSv
 R+Q60Tykf45tQNhwnRphZpAFL9x3ZGaU1k8ei8tE1kX1xm7O2AJ1FGXDsL4XiKFf3y8C
 YXnsjWmhZ6/LOyBsu3ngUY55IPTSx1lpQuD+5+D+Xyxb81oy/8kFX2upE0NAIKTWmRvt
 dxCw==
X-Gm-Message-State: AOJu0YzdQ2Dhh3SN0+h7TyMBvzzoOV9o7CfChpnM+3cHigRLjMTotaY3
 7FAwq0rja1VzJPPJHh0bgJOYEzvPTANlKeKst7cA9odvw8YJvXwPtde0DFONWcmp5WcqfD+LnOx
 5YRkJ
X-Gm-Gg: ASbGncvfCk10KQDhuY92lM9f9gBsQZ7n8+lazmvP+ba/Ii5phOx8ubG2I2FlWGzJie8
 i6/fw2xJ6AZaZsO9+flX6EkgWjeccOjdBuTZjfguOnFcVW9m39mZffjG0D5KzBFqgjLIBD3XSJD
 ouuZLYhPQj8AlmxA3WPpuMiZ7T88u3YtBaqprH9Zb7vpWofuKgx/rfzi0ZqD4NtK8gh9/w325Yk
 VCKB6DUEyJvfX84uMC3n2c6VNT3oyA+wuI6AHehrLKt5rQF4cjCOLZqVmFgO/boaRZVRPON2qpA
 D76WGultxwiMaf4PQbR503zj5V3iIzT72FDWxXeqIDrDOt3lzB6U0YWD+7BWvbVosuCh5Yarj2t
 lK/i1wGtzSyIhOJrdWOeV6H1Oq6lvAS32PWYdeRaTB9FZtr5FCFbd8AlbLFKP2Jquj4OZzBx8
X-Google-Smtp-Source: AGHT+IHOdcg1ahm19PAnYGLD9YN0XqS4vZ6svUebsw9u3rAqq+oZN5b0CHOtiHgKTnLX1e2gj1JiqA==
X-Received: by 2002:a5d:5f53:0:b0:3b7:88e5:ce57 with SMTP id
 ffacd0b85a97d-3b917305378mr97643f8f.27.1755017804355; 
 Tue, 12 Aug 2025 09:56:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4696c8sm43792913f8f.55.2025.08.12.09.56.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Aug 2025 09:56:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 0/2] SD/MMC patches for 2025-08-12
Date: Tue, 12 Aug 2025 18:56:40 +0200
Message-ID: <20250812165642.81157-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

The following changes since commit 624d7463043c120facfab2b54985fcfb679d5379:

  Merge tag 'pull-nvme-20250811' of https://gitlab.com/birkelund/qemu into staging (2025-08-11 12:57:55 -0400)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/sdmmc-20250812

for you to fetch changes up to 7db162fa013878b06a528686ece79ad99f699c71:

  tests/functional: Test SPI-SD adapter without SD card connected (2025-08-12 18:52:12 +0200)

----------------------------------------------------------------
SD/MMC patches queue

- Return noise (dummy byte) when no SD card connected over SPI

----------------------------------------------------------------

Philippe Mathieu-Daudé (2):
  hw/sd/ssi-sd: Return noise (dummy byte) when no card connected
  tests/functional: Test SPI-SD adapter without SD card connected

 hw/sd/ssi-sd.c                            |  4 ++++
 tests/functional/test_riscv64_sifive_u.py | 22 +++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.49.0


