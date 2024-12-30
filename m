Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118A0E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 15:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSHru-0000mA-6l; Mon, 30 Dec 2024 10:39:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSHrk-0000kB-N6
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:39:37 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSHri-0002z2-LQ
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:39:35 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436341f575fso97562015e9.1
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 07:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735573172; x=1736177972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Kqn0cAQx0AmcHu5Vup+xt9QSQKA5PMZMIOpGbeQbdm8=;
 b=wFJ+SBrJhYThojybgE+bD9imCt8eNCyqS/Xp6iUDyZQyRj2cWCl3M636OkCYuGiV2d
 ZfJ3sjnKET2Y2xSg0hogjIGvNuidFHnc7+aThsDgilnhS7zwcyDh4EzjBXwogCBqf2uO
 AAy4xdubYrxamDVWHFBZcKV7bcuKjKFo6kviwi2x9w0Lf5c3t0JbZ8cDHzvrBk+oScX8
 nqw4mmCGUY8DUz83Mng9DM9tNORftw7e1sNrBZGGwMaTo1I6+S4tD5Qgl7CKEL63H/ge
 NO999CctOrQVD9eP5JC+GtfiuA5WzI8S73IFUhy25nY3I79zjw4Ly7YXIHk3cQzgV9zU
 /r8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735573172; x=1736177972;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kqn0cAQx0AmcHu5Vup+xt9QSQKA5PMZMIOpGbeQbdm8=;
 b=edPeWY6MtC4WzcPEB9jZJkxiWd8fxLa1uUCxKyP/Jnp1axB0xP7tJNAnY6iG3wl5ov
 mEpvmoAFfRrpcghFnjJjBWqEV+MsiPKQ4x1JvGIEic7AIeIAzBXb2lO8wj+cSeFVA7fX
 L9z5tPbBychRLX73VfMZyADc6z/ez/zPkQHjUILMPpSEgvxHzM0PWUefJbRUoTigvPqV
 BHVuAnrXWaP74u33qPaAwuI3DfOds1zkfw17HUi9z086ng9RZYyVHdYI4UhUWRet64mn
 SqY8Wy0eN8Xrsj8CZ/9/rfOMj0hoiJ1mc1JBRtYpM+AHGWO+XbF9XKLsAwVOFuYnJoNA
 EPZg==
X-Gm-Message-State: AOJu0YzXOrWrWbPSfklL2enzAZf2awkHWDt7+jXex0xVhq5aiDFX1hER
 sROHZfBKg5V64f7vKVDoOQ//AhqU9sEAoFUFvTmNcbAm+vxhSWMQ7OS513l7HMnLBDQezXarTpm
 1
X-Gm-Gg: ASbGnctRxCdYTFVrKfj41tuiF2iLkGpOzPKfzyirCAG5zNLmyddQCeIc/lCLae8Q6+M
 +Q+poplW0kZCJeRLX5jH8h66yZwYkh8voPz6WT2EO83I18KqQBAk5et7sSR6PaO3WINog/8psmD
 8qGtpZXLjIQm0epfdNycJ+GFmI6RGDv6pQ/Yx1C4L72DbXP3NqrSiVEN2F2soPdog/WJ0GrSShR
 mSl+pyFi1sHzr5poJo9nEmyVuGi1K+BBNqghv451VnX1m2z6ON/Lwnld4Jp8paLUdkiPeQQcs/d
 N477a6q/L7g1AKfLr6JmkRmM+Uerejc=
X-Google-Smtp-Source: AGHT+IEfTPNludT2ACWF9yVZ48vmZAb4Xj7JXhqw0JZoPA0rZ4dFN9lwiG637e+xQh8YjiIu20RfNg==
X-Received: by 2002:a05:600c:450d:b0:436:2238:97f6 with SMTP id
 5b1f17b1804b1-4366835c1ccmr240895605e9.1.1735573171924; 
 Mon, 30 Dec 2024 07:39:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b119d7sm392047955e9.20.2024.12.30.07.39.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Dec 2024 07:39:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Song Gao <gaosong@loongson.cn>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] cpus: Avoid re-initializing fields cleared in
 cpu_common_reset_hold()
Date: Mon, 30 Dec 2024 16:39:26 +0100
Message-ID: <20241230153929.87137-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Having this call tree:

  cpu_reset()
  -> device_cold_reset()
     -> DeviceClass::reset()
        -> target_cpu_reset()
           -> ResettablePhases::hold()
              -> CPUClass::phases::hold()
                 -> cpu_common_reset_hold()

If we call cpu_reset(), common fields will be reset in
cpu_common_reset_hold(), we don't need to manually do it.

Remove the pointless re-assignments on CPUState.

Based-on: <20241230152519.86291-1-philmd@linaro.org>

Philippe Mathieu-Daudé (3):
  accel/tcg: Remove pointless initialization of cflags_next_tb
  target/cpus: Remove pointless re-assignment of
    CPUState::exception_index
  target/cpus: Remove pointless re-assignment of CPUState::halted

 hw/core/cpu-common.c      | 1 -
 hw/misc/mips_cpc.c        | 1 -
 hw/ppc/e500.c             | 1 -
 target/arm/arm-powerctl.c | 2 --
 target/hppa/cpu.c         | 2 --
 target/loongarch/cpu.c    | 1 -
 target/openrisc/cpu.c     | 1 -
 7 files changed, 9 deletions(-)

-- 
2.47.1


