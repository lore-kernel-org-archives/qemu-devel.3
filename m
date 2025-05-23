Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C7FC54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 11:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIQi2-00087a-QA; Fri, 23 May 2025 07:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1uIQhz-00083l-19; Fri, 23 May 2025 07:37:03 -0400
Received: from forward101d.mail.yandex.net ([2a02:6b8:c41:1300:1:45:d181:d101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1uIQhu-0003g1-1A; Fri, 23 May 2025 07:37:02 -0400
Received: from mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:4946:0:640:90b4:0])
 by forward101d.mail.yandex.net (Yandex) with ESMTPS id 07116609AC;
 Fri, 23 May 2025 14:36:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id kaOXlq9LjuQ0-loQT8Ebu; 
 Fri, 23 May 2025 14:36:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1748000208; bh=/Ac7Kr+qv8lbKM3uWgQy8/nU9okYf3HNN2H4+zC/egw=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=jludvZwx2yA4suUXjRQvKy6+GCxo+5opHd06PAPbrlOKh6CFp6zEjJ233MTVBdenm
 WuNa+US61W/ZYCoga2Hw4Y4Bs0EsFWw5aNUeMYmfOLmpDHwUFiOV/hVS9Bft4Q25VK
 Rl521SRB+r/xt/28kHWChpqp6qIX63iVLv69XLk4=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Ilya Chichkov <i.chichkov@yadro.com>,
 Nikita Shubin <n.shubin@yadro.com>
Subject: [PATCH v2 0/3] Add STM32 DMA model
Date: Fri, 23 May 2025 14:36:44 +0300
Message-ID: <20250523113647.4388-1-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:d101;
 envelope-from=nikita.shubin@maquefel.me; helo=forward101d.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Nikita Shubin <n.shubin@yadro.com>

Add STM32 DMA model and include it in STM32F100 SoC.

The model is fully compatible with GD32F303x DMA.

To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alistair Francis <alistair@alistair23.me>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Ilya Chichkov <i.chichkov@yadro.com>
Signed-off-by: Nikita Shubin <n.shubin@yadro.com>

---
Changes in v2:

- hw/dma: Add STM32 platfrom DMA controller emulation:
    - s/GD32F30x/GD32F303x/
    - fixed flags issue, as we might not raise an interrupt,
      but we should set the flag anyway
    - check Enabled Interrupt and raised flags at the same time,
      if flag mask matches enabled mask set GIFCx flag and raise
      interrupt

Fabiano Rosas:

- tests/qtest: add qtests for STM32 DMA:
    - + g_autofree
    - fix qmp() leak with qobject_unref()

- Link to v1: https://lore.kernel.org/qemu-devel/20250324100508.2176-1-nikita.shubin@maquefel.me

--- b4-submit-tracking ---
# This section is used internally by b4 prep for tracking purposes.
{
  "series": {
    "revision": 2,
    "change-id": "20250314-stm32_dma-24e7a75cec64",
    "prefixes": [],
    "history": {
      "v1": [
        "20250324100508.2176-1-nikita.shubin@maquefel.me"
      ]
    }
  }
}
-- 
2.48.1


