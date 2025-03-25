Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D34C36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 22:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txCzO-0000W4-0r; Tue, 25 Mar 2025 18:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txCzM-0000Vk-Pp
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:43:16 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txCzK-0006sw-P3
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:43:16 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso1030807f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 15:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742942593; x=1743547393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Eqseea59F60LhLSYlLeLzcWV1Hj125jM/6Dr/ONihS0=;
 b=T0cFc6vwKndGVMArWnTsOdBoV2ET0CnBH8dvOgPeMKk/drIFv9KaE/pTXxCeAqU0qq
 daFQQEiUoW4YivWsJakGDTk/HG+F5hw/pgEsvLzIkzWT+J0G2DYReThhhiOyONhzqN7Z
 L5n00UctaeQ0ywCJLaccbMPexO0OzwkBWN8N1JxQl4B45luDDb9ixWgGSPdTvxAVX1Pi
 3QkNhE7zKpvuYLdhGKSrDW0r/L8+9MeYSHx6iLCM14tOeKeV25Omb8XrLffnPDMQNL1d
 671m3Px2mdtwEszp5EV1H/HB7VApfeF8/mF+YbnuIAKME7AyTo8VFFs1ybVr41sn7IQc
 YkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742942593; x=1743547393;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Eqseea59F60LhLSYlLeLzcWV1Hj125jM/6Dr/ONihS0=;
 b=NTLZjGrvul/QlCfan0EgDio+o6AIhg1PC+3o8+1NgjvjW6Dab7Uz7M0A4vwVXXzLBQ
 VP6gCaq3x08YNVzHozLUCPgx3BnMdwJpn/9ZwebPka2rYhH6nrdydGRkL72vS7PGfLo+
 lo8WdagEvNOyyeusqw1TMXVwGygLh+QTJmdVmkfWICZjkTO8Ew1T7erKDKcIF/zedhr7
 /U+6hz+79HXSjb7OevcvHlLskxux49Y/hjtTONR/Vl/roTy1efLlHjWyMEHmvzeIOoSi
 vB4VvYmc8LhQWglvd+bTR16iLaZ2bgZWSdXv+scfx5XIYelmo6xk9q6DzhG3yZ5BBkhH
 1bwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVblVmuTe+rfjzkZgoW/q8KBJZiz/mOyNuY24PoGfMxxKCrhCFE3Q1hQW7ANaBIYR8J1WWK1EFu2lnr@nongnu.org
X-Gm-Message-State: AOJu0Yy/CSw0IEkrIivLR5Bgli8vpQWTBjP6SS4OcuULgnR5y1AdfFXX
 p2SUy0zEdfNA7tJYE5bcvgPWlooMkPTKWg6NRM7pIpTOsdXZLe47tWFUHmv7vDo=
X-Gm-Gg: ASbGnctydAZMqXCca4AUv2Vu54/01cq2JZJn4ywHOkI7dFx0TjALVX8nR7d87BNjxen
 xaKi1J+QNAzWxSQ1xQB7lRYS7iqhgief77vBLvZKMcUqdro7gX/RC1DQOAgJ87ON84jvRvDIz80
 gFg9VHBqK6drRqu0ThrrVi3Q6Csyg4k5C1m8Gt2ntS6vEsqaVlh8AO7Nj09bwE7fnG34dg97OmR
 2xmkY6f7f8IxBDCc0uN2m4Xq5vkZ/+SQFqzhk9XkR0/gwrV1mJO3XEpgoJJGLc9pswFvG25gXKj
 MwKDtvpbuV0sG3fnreojdcvHaoip12+Kb8fmajWEx1HaZYfbI83U7hzrkq9cbFTDfz636SkLQgs
 kAvSW3dnR+y76hMouZVE=
X-Google-Smtp-Source: AGHT+IEemPYF2Kr1pWD22Ty1fD8CXyfT4pPzgZuSjKa5os32FdFwep3vfinEsjhCpPJGholhCh9ZSg==
X-Received: by 2002:a5d:47a5:0:b0:391:3d97:bd33 with SMTP id
 ffacd0b85a97d-3997f8f9fb9mr17440490f8f.13.1742942592870; 
 Tue, 25 Mar 2025 15:43:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fceb780sm167151185e9.4.2025.03.25.15.43.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 15:43:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>, Samuel Tardieu <sam@rfc1149.net>,
 qemu-block@nongnu.org, Patrick Leis <venture@google.com>,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, Hanna Reitz <hreitz@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH-for-10.0 00/12] hw: Categorize few devices and add their
 descriptions
Date: Tue, 25 Mar 2025 23:42:58 +0100
Message-ID: <20250325224310.8785-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Few devices are user-creatable but miss a description,
and sometimes are not categorized (or mis-categorized).

Some, being qdev and not sysbus, are automatically
user-creatable, but are part of SoC.

Fix that.

Philippe Mathieu-Daudé (12):
  hw/audio/wm8750: Categorize and add description
  hw/block/m25p80: Categorize and add description
  hw/display/dm163: Add description
  hw/dma/i82374: Categorize and add description
  hw/gpio/pca9552: Categorize and add description
  hw/i2c/pca954x: Categorize and add description
  hw/misc/axp2xx: Categorize and add description
  hw/misc/pll: Do not expose as user-creatable
  hw/nvram/xlnx-efuse: Do not expose as user-creatable
  hw/rtc: Categorize and add description
  hw/sensor/temp: Categorize and add description
  hw/s390x/zpci: Re-categorize as BRIDGE

 hw/audio/wm8750.c        | 2 ++
 hw/block/m25p80.c        | 2 ++
 hw/display/dm163.c       | 2 +-
 hw/dma/i82374.c          | 2 ++
 hw/gpio/pca9552.c        | 2 ++
 hw/i2c/i2c_mux_pca954x.c | 8 +++++++-
 hw/misc/axp2xx.c         | 5 +++++
 hw/misc/bcm2835_cprman.c | 8 ++++++++
 hw/misc/npcm_clk.c       | 6 ++++++
 hw/misc/stm32l4x5_rcc.c  | 4 ++++
 hw/nvram/xlnx-efuse.c    | 2 ++
 hw/rtc/ds1338.c          | 2 ++
 hw/rtc/m41t80.c          | 2 ++
 hw/rtc/rs5c372.c         | 2 ++
 hw/s390x/s390-pci-bus.c  | 2 +-
 hw/sensor/dps310.c       | 2 ++
 hw/sensor/emc141x.c      | 6 ++++++
 hw/sensor/tmp105.c       | 2 ++
 hw/sensor/tmp421.c       | 4 ++++
 19 files changed, 62 insertions(+), 3 deletions(-)

-- 
2.47.1


