Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055FFCAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 16:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1SQi-0001BS-Vn; Wed, 24 Sep 2025 12:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1SQZ-00019U-Hm
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 12:33:12 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1SQS-0007gX-K3
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 12:33:10 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3e8ef75b146so76205f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 09:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758731577; x=1759336377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6ZpO0tGpAKOiTdbynPfvh3ZqMVhari1Z0pTYtC00gJg=;
 b=nT6eiTzeRNMdZquXaYroqioZIltdz5rhl69Rnd6Ze4huZBT2C4TQSQdDATCriCksFN
 2aR9KagA2da9Ei/9hCkgtXa4iET/kdSdmk8LA6grEgHzOE8oIb27MOdwvbknWqJiWwsY
 nDrOudkhNa6DxBT9LlrJRDYEaXGecauwAh4xXZjuxU3E4l03CxVrU0ou2qbH3XWs0hZD
 Cwj42qUqnfrtO8MJ8gyhQ/joRlRdnXtVyYMy1BQyx8Jld709xT5BI3Yq0vpY+L95nP1Y
 oR7h2xuMR1N3RphA3Br7c5/6ww0i3YrOVseGHDpBiVvvUWXZDLpuaRY2fbD3o+IaguDz
 h5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758731577; x=1759336377;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6ZpO0tGpAKOiTdbynPfvh3ZqMVhari1Z0pTYtC00gJg=;
 b=IUqV8NRBY+A33eBV2BDpukXGL5SSszwhsQeO+BHdp2MpAJ/o3bN5I6OfyO1bOcCZ6b
 Xxp0Jlw7fllk13Uo9V2IuUnnAyCFWzMRaHBxqDS1Wy0H+djOla6YLflhUjWGt6LpZ8sj
 u5ymmvOIJXQsQXPsLXTOEVm38THjkseldDGOllEGYKKKFhyxJACPI5TLvSKidBfWu4K1
 Cvr2c+EUARLRBbZ7wLZgzYV9noDhUV4StKA0F7A1PwqfnzwR706w9MDbymMFt61XB5DS
 4LdTRxekq2jGUo352gNsJGPYcHZML2FB4Hbq+M3nfTPRQCYBjN1wlcLzauwpdqDKXzBi
 StbA==
X-Gm-Message-State: AOJu0Yy4ueZ7pzPYUuLX6D5FKFTWu7OhTFTIMqiH4CuV3GBIMY2iuyoa
 CBGiwM+rHWwh02LCENsYkr8EpONVaEgCo5UK6cLfS9gtgMHqmaN+9XvxKyNH5CecISZ4CjhFglt
 LP/ZpfFKXXA==
X-Gm-Gg: ASbGncsSAC+HmWW2etEEnP4ylzO8GxDkpB3gOopbNKga+P38iyFLK5rIxJu8NgC/zpg
 KaHGfExt+8In8b0q2uOMjlZfpjaZMcM1BJ7Nw61AFH1S8CHf4+duDIieX9qWp/ApW9FNUYGaj2o
 kjwRpcVoKqMLSTDJMxJThdE68a7oXoKaC7Fg18sJqrP6Z4eV0w5dMaITx1wLgvceGhGBSZpL6fB
 Uq4JEtRnEnOhMtF0UwzOUhajL9B6nJSOMzZsXPYiQtzgv9lGYiQy13GZ6IGdPwBKY/MbYd6H5Ep
 9mfIc4YR7bubAo+TmpKs8jqKUfXyDIIu5wgFa42kDx6nmvqGMDeFf8wb0pUMQIwiK3IMhMRUIyK
 1VwrxZJwxdguOKnmYzWjAD8fHUrRM+FLcE0kJ+mfD7j/iGokJI0c5yLiT3Jj8g5Io0GBfe3Xe
X-Google-Smtp-Source: AGHT+IFgR6XA2BaMcmG56i6REZERAS/hekSQIzS6oO0h/1Qt1HxWOKd8Erei9zvQ4B+h+5euR3IwxQ==
X-Received: by 2002:a05:6000:2388:b0:3e7:4697:297a with SMTP id
 ffacd0b85a97d-40e47ee046amr613525f8f.24.1758731577065; 
 Wed, 24 Sep 2025 09:32:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3f99178390csm15831947f8f.44.2025.09.24.09.32.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 09:32:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] target/arm: Few tracing improvements around power/reset
Date: Wed, 24 Sep 2025 18:32:51 +0200
Message-ID: <20250924163255.51145-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Few patches adding trace events to power/reset methods
which have been helpful when debugging nested guest
behavior under HVF.

Philippe Mathieu-Daudé (3):
  target/arm: Convert power control DPRINTF() uses to trace events
  target/arm: Trace emulated firmware reset call
  target/arm: Trace vCPU reset call

 target/arm/arm-powerctl.c | 26 ++++++++------------------
 target/arm/cpu.c          |  6 ++++++
 target/arm/trace-events   | 10 ++++++++++
 3 files changed, 24 insertions(+), 18 deletions(-)

-- 
2.51.0


