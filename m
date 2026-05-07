Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45160CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 12:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKxU7-0008SN-P1; Thu, 07 May 2026 08:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKxU2-0008Ru-Tv
 for qemu-devel@nongnu.org; Thu, 07 May 2026 08:05:38 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKxU0-0002AD-QZ
 for qemu-devel@nongnu.org; Thu, 07 May 2026 08:05:38 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-835399c11e0so280805b3a.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 05:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778155535; x=1778760335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uiJFEVwmPmAwFk5yNViinwxDNqH4/28NbHcjZ3MgTZE=;
 b=DqayFYIf0pQug+NYz71JYJRFzXeHEPri1RZyIznh68a8DYYC9GTKh++XJf46xetOOe
 N9whhjtRyntxbPMUZN4tTZFKfHmVSdGPxpum6OzBuoYBXA42jEgXvzA/lKEsfAhDTc7R
 +dN3xylLEE+AfUVAca+R23FNch7juBM6nPDL33e3JqtC1j2+zksfE53oz52UiCyrIHW5
 pkOXbqLStk8qA7pzHRgl6EZqfqIhSsuYgSWZUKnBM02E2dFxY29BLFv+yxzwIuUBCLjK
 F6GAKxlXMC0kUvebBRWYbSsB+Z954tNBGEh13o1PPPApMx3UXhKQ5DhjY/+lwkiGNWu3
 iU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778155535; x=1778760335;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uiJFEVwmPmAwFk5yNViinwxDNqH4/28NbHcjZ3MgTZE=;
 b=SXYSYoB8fwT/UstRhiGBqUjBAOEloB+MwM05ZUimD2wfoJcDE6ypAwhwY7WnLKeiqc
 0ZzqPtrPqYLloIEEHFN6bvw7hVFBQZ3RHCPiuZkDft49JyQGBZOAeulTl4a1N2N/R5FP
 2u5MjGfSJFQY2bQk9YYSLa9qtk5R5lzIfjpqoBAid7coUGfdvcwpB6s3P89iTbUyGiTB
 Frhj+UcZpT4AzyJUlgqHmWozW4nJJcedy7DUWhG6ZNPEnuop3cfXTh3bs7vmHIh6A/dD
 JtoWToAE0xYRwtclGWupdCuXcEPM8kAn83YXeL2lV7VEY5yeZbslyzPUtqgY/+34ZvTV
 /l/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ENJTnJ79VRUp6loZAB+Js/N9tkJIt/9rylbsl8l8vu9pZdziNMo4LFKN2nqGBoquYEET/NqgS+yux@nongnu.org
X-Gm-Message-State: AOJu0YzZqlX1iKRj8EVI7U7phSayLrtPZPkHX593CLouqQ1T/IvttP1l
 NmPs/E80KDh8VIxTXvpg0ZnNyEpJ4rLuaaHD9jUhu9YsTyYL08jIPv1o
X-Gm-Gg: AeBDiesZN/KObs1QRBXPM/WRWWym/K8sPn69OthrRMCm3Kr0kFcw/laEuZstgfmXhjh
 325Epa07H3Al/kNE8Q44bSMRdhE24guOaMzLlfgMx+vxQPtaEZdItWNXEcIol1rZEX+zFA9ELTo
 Jhl7GXgPyeIJY456CNA6Vsq/1xgD41kGvUDOkpBrFjl9x/SqSIok+9URORJwmothmAmI1VMJ/Hf
 V71IOAsQPO17uDvdrX7TSgoSnM9hLSugcV2DhkLpPtUmbVkFPrEX7Qupx/3xTCgZRguSLwtF595
 1Z+SKgRLqRqB5roX2V5eWsn7DvSMwIwTseFJ99wrPy/P3rGTe+uUU75ct+cZxFzq46CkJ0aqhRo
 pCY2MP4MNDvU5tEI/Y6uldN2ZA4pMYfsqAjyfjUH0tFbD0FZIKxNTtueR5HLjluWpMr88GXJJt1
 idWiMsouLq/92irf1CQWP47wTnFH72VAHdrX/7jlUXM/FJhJ33yXVgEpaWAmZ5ZEzY2nr1NSTR7
 1Qj2mCA
X-Received: by 2002:a05:6a00:124c:b0:834:df57:9d36 with SMTP id
 d2e1a72fcca58-83a5d18fe2amr7791510b3a.25.1778155534592; 
 Thu, 07 May 2026 05:05:34 -0700 (PDT)
Received: from localhost (124.158.97.178.qld.leaptel.network. [124.158.97.178])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83967dbd995sm7930951b3a.43.2026.05.07.05.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 05:05:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Corey Minyard <cminyard@mvista.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Chris Rauer <crauer@google.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] hw/i2c: Add designware i2c controller
Date: Thu,  7 May 2026 22:05:18 +1000
Message-ID: <20260507120524.111056-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

Hi,

This series contains the DW I2C model written by Chris Rauer and
updated for the Tenstorrent Atlantis machine recently. There was
some more review comment on that submission and so we decided to
take the I2C device out of that series and work on it separately,
see here:

https://lore.kernel.org/qemu-devel/20260425131721.932250-1-joel@jms.id.au/T/#mb1ef2824c2f1f37bf4574dc1ef0fb95566c3a2f2

The big thing suggested was to move to the QEMU register API. That
is a big change and difficult to review, so I have split that and
a some smaller changes out into their own patches. I don't expect
detailed reviews on the register API patch -- it's quite mechanical
and I did attempt to verify it by diff'ing register traces. But it
would be good to make sure maintainers are happy to go that way.

Unfortunately the patch 1 was quite well reviewed and tested so
incremental changes would be preferable, but it is painful to maintain
migration compatibility across these changes.

Thanks,
Nick

Chris Rauer (1):
  hw/i2c: Add designware i2c controller

Nicholas Piggin (3):
  [RFC] hw/i2c/designware_i2c: Switch to Fifo8
  [RFC] hw/i2c/designware_i2c: Switch to QEMU register API
  [RFC] hw/i2c/designware_i2c: add SMBUS_INTR_MASK

 MAINTAINERS                     |   8 +
 hw/i2c/Kconfig                  |   5 +
 hw/i2c/designware_i2c.c         | 742 ++++++++++++++++++++++++++++++++
 hw/i2c/meson.build              |   1 +
 hw/i2c/trace-events             |   4 +
 include/hw/i2c/designware_i2c.h |  56 +++
 roms/seabios-hppa               |   2 +-
 7 files changed, 817 insertions(+), 1 deletion(-)
 create mode 100644 hw/i2c/designware_i2c.c
 create mode 100644 include/hw/i2c/designware_i2c.h

-- 
2.53.0


