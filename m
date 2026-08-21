Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A643C5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 13:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxPFu-00022D-PR; Fri, 21 Aug 2026 09:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxPFt-00021w-Mb
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:25:57 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxPFs-0006O6-7Y
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:25:57 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47f93b2fe4cso484886f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 06:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787318754; x=1787923554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7qgF4ndg7sYDk4YXCCPDuz+kgVI3CZtZ6ulD+Vgtriw=;
 b=hFIWdvr9TJ3RaJc/rq5JzLYA/8cXqwOgn9MxYNhIQLfFSQ+071NlkMJcQZSzFxp9mp
 IQHzlILbLma8hD787RQ8HmrtcLqNmCacMIY2P/zEEeEnM+XPqzDS1x/erxGzvqNm6Gpq
 6Gp5XF1VpwpnA+xF/fLAAv/kD57yHTHbANaMNylczOg0tWW7Dg31Y/GQzi1K6Eo78IrN
 eApa7E/fjbPcLvfJGyCHIEujk14v0ZaCqZ6WGJfgRwAPrvV6MkXkp2JpLBh0GLXfQQdR
 JZxcfHM+L9XjiYFSacxG1EKMLx5P/ql4CNTq9XZUFxQRikCxOYdwGp9UC7lFsKAASLgo
 WEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787318754; x=1787923554;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7qgF4ndg7sYDk4YXCCPDuz+kgVI3CZtZ6ulD+Vgtriw=;
 b=ZcpJXLPqoKIAZwvudASsyAV697sqHsRkcz9kcRWQEGOPS2N411Mk4LaT3sXebvuvCM
 0YrbJPP7wmhEhV3oieByNq+ayGosJ4jKCMCbYQlpK7o+de39D7NCcNWelHcfZH70DiSH
 Zd+1cRmhgguCeLf68i8Ycw+YKnBtIuUyU66T9l/Z19RT478Ba1k4FYKpeXSeVJ3nfVUM
 uGk7IHAeAtbhcrkGCxzQPd0RSJJGmH7/JdXO0JzNTDTgOKy9zYJL6dH/oC0eOuMG6EbA
 he6jMna9eLHzQXOrNbsSNVXyBhLwjdOIeTi9CDRFsnb6r0eMUKVWZZkZf9QvuCXhaH7n
 afHQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpaMhSz6P0xYpv7rNhpaNIsFmoKgDadoJ7IITC1YVJezl+TBQfs3kSUsMZklB083513Jagvxjw2HDFK@nongnu.org
X-Gm-Message-State: AFuF++mNf8Lq6vSenfjBfVeP9WoQN80FR8lXyH4Ds90DmJE4RYjn21jg
 vND7RfK5N0QTZEobXYUU1honxmiZpE32OxXq/ykQ6SSPY3cr+yiK4aPregx6tSbEBf8=
X-Gm-Gg: AR+sD119ffIpTxiwx05siJsuGXfDCeX7Anw+ZJYokpY2c3nasUf5MzppF2B6SmsbiDg
 i3J3PGYBP51xcUJttYrHttq/T6TQb/LVnfwHFlqER1u0PcLujvGO744Y8OoppYAke8+yWcPb+GZ
 nMi5R1BaX8U49YDvg/pjeXhq346nbXCRL7uPMy4tFhvs1/3uI5Q7lyMjTlk/KFwZhf1EDnre4LG
 k43Wdb9SwFsIqsSY1AWsff4QVyqF3YRGqmw6umuAyV1uWwfXcBp13p60lrFw5X+UG5BrSqtKuI+
 luK+mublrIzYAZdW4bLZLI9ruG/ZKOj9HTOw/yRM99XEvcqULecp8H/Q/lZErPA9PZSzXaHzImO
 BJxZqJdLy4YJLuBigQ2qPRRBXnXpC5ouqdX+lj6JX9JVLJh7moET+EzKv1h9hwOGzZrhLSaO/0X
 4JR7mLowlM9iOtoQTPEiVEOcEQzZBU3Aahsy++W8aK1D86GBBhtoMsePpCtEwTNscxCIlzzzoaH
 eFEmiH9TA5Mid50y5YOL0k49DXtGnxb9ric6oNAU+TjCkxXv1Vg9n0trrluKT6wAYLpmg==
X-Received: by 2002:a05:6000:2310:b0:482:a8b1:aa6d with SMTP id
 ffacd0b85a97d-482c0b83793mr9459964f8f.10.1787318754525; 
 Fri, 21 Aug 2026 06:25:54 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1450e54sm18770327f8f.11.2026.08.21.06.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 06:25:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/3] target/arm: UNDEF various things for pre-v6T2
Date: Fri, 21 Aug 2026 14:25:47 +0100
Message-ID: <20260821132550.168896-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We were missing feature checks for various parts of the 16-bit Thumb
encoding space, with the result that we didn't UNDEF when we should
for these on pre-v6T2 CPUs:
 * CBZ/CBNZ
 * IT
 * the "hint space" (which doesn't become NOPs until v6T2)

This patchset fixes up those mistakes so we UNDEF when the hardware
does. M-profile makes this a little more complicated, so the
precise test is different in the three cases.

thanks
-- PMM

Peter Maydell (3):
  target/arm: Make CBZ/CBNZ UNDEF before v6T2
  target/arm: Make IT insn undef when not present
  target/arm: Make Thumb T1 hint space UNDEF before v6T2

 target/arm/tcg/t16.decode  |  3 +++
 target/arm/tcg/translate.c | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

-- 
2.43.0


