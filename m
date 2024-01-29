Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9603C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 15:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUTt1-0004hz-8e; Mon, 29 Jan 2024 10:49:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rUTsx-0004a3-Mv
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:49:23 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rUTsw-0005pJ-1Q
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:49:23 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5d8b887bb0cso1661186a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 07:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706543353; x=1707148153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cvTjX7nz6MBes8DNVL7PzokPg6gUDIAnXr1el7ubK+A=;
 b=hZ+vjdbm/wwgUFPxZK/w8dfmK7W7S2d89bzug0UA/+gdx972XDbqzPUi8CtKd8hgD+
 lyoDkaOP/b2oyN0NrzVgkYNlipMttyz4pfqtkje/6ahMwHZcFMuNwLj55xLfArlsa5ID
 6ci2Fb02gnoz8Wl0mUBVv5lOH0LsieIHJiOMN9X6//1wJG8mr/Yxp/QCKF6DRaepI/Y9
 7mTDbgmoGYCXfL150z3e4STYlWLtfqXdJvywB3o2RYAMU4dl3z50vlBA7KrA3CSmEQvH
 FpOWh7Z8aurJuKBamnJ6FI9qdmuR+Obb38RWsoJG282cUtcxRsEdo+NXH4yc9Q8EQxbA
 0kkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706543353; x=1707148153;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cvTjX7nz6MBes8DNVL7PzokPg6gUDIAnXr1el7ubK+A=;
 b=QB1lgkxZmwKqFq3rmq5wg6l5ufl3rZZnZ+7Yk7guBDJVBdaCkmHKyKh2GsCH40q1hh
 7a8AV9eegi/h+K1e6TyLuVHpxNxwG3o5hfvfnM12M1n3ctWMucH9aQj9dsk2WQHdZyYF
 +SlFo0k/5yUUzuixFVaYYx6RHBwpUhOQgNx24qLWDDgifCoI3x8vPyabCfmbWBL/77IY
 wMp8e5S5A8KFB0Cqi1tjF87ZSMXQ6GnX+Kvt+teZ0nOjvvpRJ5jyA1J6PQiRNZS9ery8
 erKbZpo8Wvqgb8uZh3jV2iX6WbPbsBVrSCGwMsvM1hJpX4QPrC65xmTcEdPM0ZKpvCa1
 ljRQ==
X-Gm-Message-State: AOJu0YyF0w+VkhzPZlCVHTrGmiU9HVJrxGcxgrPOQp9/IeQHxXqFlpQf
 3+Sg03J3g84LU8a5n2HVFVqgQq/1FK5lL9YrIpjFoB0wtpC6//1jmCtYN8oIU04=
X-Google-Smtp-Source: AGHT+IFXuzkuJTA2iI8kuSklfcgyws9ADA1OwXc7NvbSxzMivGSLxWY8tcLT3OEdUC0TA3h40m5IWQ==
X-Received: by 2002:a05:6a20:d48b:b0:19c:9f1b:1d8b with SMTP id
 im11-20020a056a20d48b00b0019c9f1b1d8bmr4903686pzb.16.1706543353308; 
 Mon, 29 Jan 2024 07:49:13 -0800 (PST)
Received: from localhost.localdomain ([49.47.195.100])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a170902c70100b001d90143a21fsm34213plp.263.2024.01.29.07.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 07:49:12 -0800 (PST)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: Rayhan Faizel <rayhan.faizel@gmail.com>
Subject: [PATCH 0/2] Add BCM2835-SPI0 to BCM2835
Date: Mon, 29 Jan 2024 21:19:06 +0530
Message-Id: <20240129154908.2761091-1-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch series implements the SPI controller for BCM2835 boards.

Rayhan Faizel (2):
  hw/ssi: Implement BCM2835 SPI Controller
  hw/arm: Connect SPI Controller to BCM2835

 docs/system/arm/raspi.rst            |   3 +-
 hw/arm/Kconfig                       |   1 +
 hw/arm/bcm2835_peripherals.c         |  17 +-
 hw/ssi/Kconfig                       |   4 +
 hw/ssi/bcm2835_spi.c                 | 288 +++++++++++++++++++++++++++
 hw/ssi/meson.build                   |   1 +
 include/hw/arm/bcm2835_peripherals.h |   3 +-
 include/hw/ssi/bcm2835_spi.h         |  81 ++++++++
 8 files changed, 392 insertions(+), 6 deletions(-)
 create mode 100644 hw/ssi/bcm2835_spi.c
 create mode 100644 include/hw/ssi/bcm2835_spi.h

-- 
2.34.1


