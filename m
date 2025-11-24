Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49038CFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 12:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNVpT-0001Tg-Hm; Mon, 24 Nov 2025 07:38:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1vNVnT-0004Zk-3T
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:36:00 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1vNVnO-0007Iv-VU
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:35:58 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42b31c610fcso3651499f8f.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 04:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763987735; x=1764592535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zEx+MNCEeV+X4e2mjuf3/qMtxRDSV/ZuXFhpbJkgegU=;
 b=S+eAAEOrTTempE5DwbWWZE4Qxp3EUK8+OKqg3hJYPJtdf/NIE/4ybqfVOeKKJqgjCo
 Gfn/HUMrJkCIhZ1Qmz44JIKs6r2y7Vn3jBkw6T/47hUR85B57fh9xqR7EPjwShzeTxMl
 0SO2JMwPx7cJy81Pmwi2DlNHr+t1fKAz5eqZsSGAUMm+h5190XXllmGCXiMQYAIs0iCg
 C0E14/in44RETwAWj2BdFdPsHzVp5tOWMZGJqH5x2DUOuR/6d6cTzhWGoCUCf8J0iUDu
 5fkmxT5A4QXrIZtJM3tyd25x735hzn6XanIhJiUQvioEzlvJKtmrWDVQdNuLeN9RDA5G
 zo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763987735; x=1764592535;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zEx+MNCEeV+X4e2mjuf3/qMtxRDSV/ZuXFhpbJkgegU=;
 b=EW3KKiUgXKmVAHIdxkV1Y4ExylRXdJtSi2aG/b8kQv4CLluqzPoUKAx1uvbrLS8wuj
 iJU4Pb9Gx8MBzJYDSVWiJ+lB82U71KUIdcI6bl/ZaaIpuqh49l7PbgWKVkMXi1OC+PFR
 nbqilGm94XxnCizPdgk5kvJvtBLZQFqCrN1LBT8/zAoVUZKlzwUDlew2U9KXgr9Xvwc9
 1MX3hhqQ+HKCzhFZjaSIh+/QM1ofA0NmwBTmixui6D++/uomj+W2BKeSKjEPvdw/XqU6
 u+YJ2dkpjgZz/ahpz7jQf0aJepDUwOfPNB+UWaWTxL6D6A4vS6AvhiXAAouDjnPmfB/x
 ZIGQ==
X-Gm-Message-State: AOJu0Yz6wWsmJ0o4CX79gs7Gj+fxsjymXPVC2TIJ7ISDc2+jgeZDeUoh
 WRu9Pc/BPeU8v0l7su59OAGFp+gUJ88PNita5dliommssU1FFuKUrK6MecQFuHA1
X-Gm-Gg: ASbGncu9wZefGTH0P1qumEy1D+Ir3LM9gzuCjyXs268SnGrd07WgzeIF2ZeIRrHRPL/
 g/HWAy2bgMHM3cNpsjVDko8JixDWsNE5Ns/mUNZfT4v5BWLxBODgRMbOD6mVyHi2xE/7rfd+zXV
 Lfebmsilk1PW/LzL/N3yBsddGtcPUtmRAZMNyMg5c6FeiaY84ZA6ezwU+8O1zfBwZ4r7HqSGZaY
 YcbhgV3XzXc+dDOAPMvyCoTeNVdjO1gBr68dAkclDf9F/7h+5q9BAQB+AOMC4YJDBHhSwk1lIzk
 mknEBRTQKkZm0KxvfdhhLQwrYPJiYyDJsIOpCi0xHFw+zXofz/hWDD7lEVmmijR1PQS4aleaBym
 oJtu2xOwCwo2QO5o9Yb7MkBjPjqC5t7GFUTCDr2upXViaMI9dUZg6Hes3WBHnHGLzHz1hbNfhdJ
 Ob+B6ReAhalSpkOle/Ctj44W0y86xGuWa9JWvn0U8cPhxjA+AEb5wNCLSQWzY23rl66Q==
X-Google-Smtp-Source: AGHT+IHQxiY3DCULkD9W2S0f+pgc2eduGxpB7YWpKs/apl5+hqL2i06oW1NGFBIQExIcZR341AbTcw==
X-Received: by 2002:a05:6000:2383:b0:429:c851:69bc with SMTP id
 ffacd0b85a97d-42cc1ac940cmr11366986f8f.8.1763987734535; 
 Mon, 24 Nov 2025 04:35:34 -0800 (PST)
Received: from daandemeyer-fedora-PC1EV17T (d54C349CA.access.telenet.be.
 [84.195.73.202]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd8c47sm29398449f8f.38.2025.11.24.04.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 04:35:33 -0800 (PST)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>, Paul Burton <paulburton@kernel.org>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: [PATCH v4 0/4] Add support for zboot images compressed with zstd
Date: Mon, 24 Nov 2025 13:35:17 +0100
Message-ID: <20251124123521.1058183-1-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=daan.j.demeyer@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Fedora arm64 has an EFI_ZBOOT kernel image compressed
with zstd. Let's make sure we can use it for direct kernel
boot with qemu.

Daan De Meyer (4):
  Rename LOAD_IMAGE_MAX_GUNZIP_BYTES to
    LOAD_IMAGE_MAX_DECOMPRESSED_BYTES
  Rename UBOOT_MAX_GUNZIP_BYTES to UBOOT_MAX_DECOMPRESSED_BYTES
  Use g_autofree in unpack_efi_zboot_image()
  Add support for zboot images compressed with zstd

 hw/arm/boot.c        |  4 ++--
 hw/core/loader-fit.c |  2 +-
 hw/core/loader.c     | 44 ++++++++++++++++++++++++++++----------------
 hw/nvram/fw_cfg.c    |  2 +-
 include/hw/loader.h  |  4 ++--
 5 files changed, 34 insertions(+), 22 deletions(-)

-- 
2.51.1


