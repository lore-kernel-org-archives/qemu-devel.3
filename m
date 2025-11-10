Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FBECCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 11:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIQ2R-0005ec-C7; Mon, 10 Nov 2025 06:26:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1vIPi3-0002KB-Sh
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:05:22 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1vIPhx-0003gq-Lc
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:05:19 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b98983bae8eso1463622a12.0
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 03:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762772712; x=1763377512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Lb2rlGVTHbET5wQXg50tkt0hb1LcaZkYx6gRbO5B25M=;
 b=g/FyD4CyrrtiFhOLsWsuP6QxNUsR263EH82Sx1G75L8zhVZlcr5pQDtOZJdHtBP9fM
 coYFGjRTMH+dHpChoC3dFv45BXnhdSo00jkMHcUooUcNqyuFESrQhqH9gvUuF5wBK9OF
 56V5aqAkQko4ahLqf1QzpfF8X7Cxsng2Bf+HnFJLFtdMqKcHgdS/nilgTLYBtzCRkOrQ
 Yhh3TklsrXiOx0CgTMIFtoY2EHuugPJJTnXRVVyLQEW4ZgSmsFNX0/5InWBYKAxFhhF9
 +fRlrE4woZ0QZJfVCeZ/8j1f7Y2QmHhLgKNhyzGxCduoIb7KsUcdf5LZn1FTp3vpf2xM
 AYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762772712; x=1763377512;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lb2rlGVTHbET5wQXg50tkt0hb1LcaZkYx6gRbO5B25M=;
 b=WfJiB0OB7sPLAZC6wqWpRthNIKizOqYhKZS2vUS6C8UwTlVeQ03LMkop1rpkxR+XOR
 7V6XI/DCyESy0QSkizf+oltlRc3g69SHm9c1qfcZwgKDHZCh0b297JkgfAIQeDm5j8tT
 KIn08l1iYqZI4Vcfl1FF2dguKe99mpqWGio4ezX8NYI7KGAIpIhRrQA6zvldlPqTj9Pm
 bi3138bJPsJ2wtcOcI/1BL7SyAD4dkLGsOt65rN9FaY/SBm91SsPV+2q1tNftJUkTiTd
 9h63D7v1lFHpSinJtqWWmcCbw4+6fjY2+Wjm/1VOG3GHR2POiMrPKJ+zTa4SQf1yt5yJ
 kscQ==
X-Gm-Message-State: AOJu0YwjqgtfRdAPQTERA/3VVRRw0LPMf/PVtygIle38pQMqgRWBByJV
 D5Z5gb4uLgjvMo5lMlofztDo2UYjNr+OdVzinVRvXdddUHuX6ujLbas6pMObcmcKWUE=
X-Gm-Gg: ASbGncvzLg2/IBLV2IMHeFG9lhMQMEn/q9xfWq7KV+q8uEIngetNExKBbAT7vMDGfm4
 +HZu6NUwrXpqpAEz0JyqaoGnRQgQTaeyIuc/etJEfJU3vdZ05u3udaGdLqGfNegnBgVDRgjcfLh
 bqxWxiT1S48KzCRlpUkUpkx/XTiOgMEKMnsSWRjmr6gPBSAM55OcpWAVJOLjZ2r2j5grQuRetqF
 N3judsDy+mwyDVF4vTYKuJBiWe4FxQdMe+GfciX0x2cSqry70e6lh2ZWDQV80bq63mRF/QHpXaN
 qwJ+Q/ztwhz3E8BU6mkIyy/Gk8GwCKdoS3To284nHqaAOj8CLVcMRY4o5X8GIWjrnS5T6b5D5bL
 aOvd1VbKgMV0DVNRjrauofK7Gehl/0N754kMSU0WV7B6CYTTto6knjLr5Ah6jhyo9YGampDU=
X-Google-Smtp-Source: AGHT+IGICWGN27heW+QGcDO7N3bj6P0xxfWAYk1tXoPnssWG5m+UICvl9FQLylD8dhcMzvCtJnMgjw==
X-Received: by 2002:a17:903:350d:b0:298:8ec:9991 with SMTP id
 d9443c01a7336-29808ec9a10mr56530935ad.37.1762772711779; 
 Mon, 10 Nov 2025 03:05:11 -0800 (PST)
Received: from ubuntu.. ([111.196.133.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651ca1b8csm145706605ad.85.2025.11.10.03.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 03:05:11 -0800 (PST)
From: Bin Meng <bmeng.cn@gmail.com>
To: QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/2] hw/sd: Fix broken ssi-sd implementation since v9.1.0
Date: Mon, 10 Nov 2025 19:05:05 +0800
Message-Id: <20251110110507.1641042-1-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pg1-x532.google.com
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


The U-Boot community reported a CI failure [1] where the
`sifive_unleashed` target failed to boot from an SD card after
upgrading from QEMU v8.2.0 to v9.2.3.

At that time, the issue was traced to commit da954d0e
("hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID handlers (CMD9 & CMD10)")
which was introduced in v9.1.0.

Testing with the latest QEMU mainline shows that the problem still
persists, although the underlying cause has changed due to refactoring
since then.

This series fixes the broken `ssi-sd` model. After applying these
patches, U-Boot successfully boots again on the `sifive_unleashed`
target using QEMU’s `sifive_u` machine.

[1] https://gitlab.com/qemu-project/qemu/-/issues/2945


Bin Meng (2):
  hw/sd: Fix incorrect idle state reporting in R1 response for SPI mode
  hw/sd: Fix ACMD41 state machine in SPI mode

 hw/sd/sd.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

-- 
2.34.1


