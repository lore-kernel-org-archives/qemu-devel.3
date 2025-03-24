Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4B5C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 10:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twegf-00066F-Fp; Mon, 24 Mar 2025 06:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1twegT-00061C-0N; Mon, 24 Mar 2025 06:05:29 -0400
Received: from forward103d.mail.yandex.net ([178.154.239.214])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1twegO-00052F-94; Mon, 24 Mar 2025 06:05:28 -0400
Received: from mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:2347:0:640:6ae5:0])
 by forward103d.mail.yandex.net (Yandex) with ESMTPS id 369E26097C;
 Mon, 24 Mar 2025 13:05:15 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id D5L6Pk2LeW20-Af9uR16U; 
 Mon, 24 Mar 2025 13:05:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1742810714; bh=PnYu2LnFSsjRkXA0QzD2VorL5ifVzVkrluj+YurgsfI=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=p1AuJfdF6hFMzLEDWpx13rz9VDyceI8Rm9OAsI2UPtH4JND+EUD7kIRVIDp+RFl0p
 ihvsA2C3GtpgIpMHTNFtnmDQvndZMxxIUls1cFjSXI3HGz4loqiuDNjrGuo4eOEKV7
 +xgDFMaatiOKrmJOBr/47gZ/P1lIsPMw8oHRe1wM=
Authentication-Results: mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Ilya Chichkov <i.chichkov@yadro.com>,
 Nikita Shubin <n.shubin@yadro.com>
Subject: [PATCH 0/3] Add STM32 DMA model
Date: Mon, 24 Mar 2025 13:05:05 +0300
Message-ID: <20250324100508.2176-1-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.214;
 envelope-from=nikita.shubin@maquefel.me; helo=forward103d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The model is fully compatible with GD32F30x DMA.

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

b4 doesn't allow sending through relay, may be this should be addressed.

--- b4-submit-tracking ---
# This section is used internally by b4 prep for tracking purposes.
{
  "series": {
    "revision": 1,
    "change-id": "20250314-stm32_dma-24e7a75cec64",
    "prefixes": []
  }
}
-- 
2.48.1


