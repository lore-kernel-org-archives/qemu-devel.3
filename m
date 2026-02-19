Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B542CE9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Mi-0007Jk-00; Thu, 19 Feb 2026 05:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Mg-0007IO-23
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:34 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MX-00065k-2R
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:28 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-483487335c2so7589175e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497262; x=1772102062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M31IU/68Ir/y3L9oSFn7MeWv0qnqpBZFnVrNA/xiATA=;
 b=DsZtw0WP+xOsrogy+gwTGmNJT1aX9z9zrmawLLsy/aixhm0sraUv3X7FYezvygrXV4
 ihX3k1EfviRBTjl+VnjyXy4aeCEx/J9awTqcU39nUmocc0PKn2AMh1Wxogpjt8im6xVx
 ispjrFlkHQrakebRVFpKk+WnQmxAURojyY9SifwhvpGwDioMRHTAZzEDVgin+sj3EXr6
 orRdy+EtUq0c+KQpHzfcJlxtIQV4ScH79m+BrbwekvBSoQ/B3Yc5zf2n2GTonoDA+5jH
 KETt1Qqjo/5ur3Qskf0YEcaz9HG+50eNYVtX1ZiY99aI0thRu3FY/ZbOtNTsM9kR/QZa
 xJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497262; x=1772102062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M31IU/68Ir/y3L9oSFn7MeWv0qnqpBZFnVrNA/xiATA=;
 b=kQKcbTre5T0BVkIMfw7A7pxRqQWi1JuGanFDjt6ofUMrOKG0zmisUW/mX/nCgDzgYV
 gQYT43JrpAfmMQYYWqGtqISRzBI/asqwRGGvvwVxjnwuAcuZsVhu+M0eNHVaTVhYC6/4
 JtaIu9giwpg0yIGKHwoDARhVYAwoL75aDqcWzBn9to0ZEzKWHGBNAZPfNEwzp/HdR/md
 ggsxQU5yeObQNB49Lzx9A81IzXD/4ib3+fyqI4QfwibKfT+XYnsmy96CizMRKonrPhoZ
 8djfC6D4GfalZUSBICD4+5zgs+Re6e9jc6x2g+qxJKSayN46MG+XNbGytBm682p+QwYA
 /iUA==
X-Gm-Message-State: AOJu0YyNyGSyqixzQjDU+1MpHfrI2kyJods6Vla0coymzz1k56Z7pmBm
 Mt8VcLBJten6bndCWQ93hpJs0Vr8BNPICE/Nr5ru3vBqRaljheDUjan0A7Zr99OL1lYPyGMbY37
 9gyZg
X-Gm-Gg: AZuq6aJkvVBSkcyGtEHv1zwqnA2Ioc8XNmqH4ZY8Ojuf56fAv4cOdYT+Vlj3XDrErYq
 ppqcui3wuHIDJIdimwmiPEpnU3Fm8xFDEg3eolWt2H+8z0ZUkz7/k58Ksfl0aooqMpUhysJlNff
 ia8a6oTFsYP00j2phvPTX4acZVOpLAIPhImK8VgNyWPegfopkFp0MZfK2/JPll8XvsfbdL5smGY
 Oz1x2LR3OIq5yYpAf5ISSKp1FvzB6KgrkGbTcAS41XO8H3TWlcG5fO4cDOVNJhnsAQpzm5d0EsW
 ugjKMZMyfl+SBCQMXN9KuZ8c2UBi48MgC8CrF+OGO6BSO5jwGOz3sVXGaEsb5g2C5n/GXpddYUJ
 SsxgQcwdj4niMk/n94m19nUPoctXZXLlQzDYazTWi4V9rvSezI5P0XwClgUB/GyTpvKuwr8Jtjm
 P2qyJ3P3BE7rGDd9hFE8GQDkWW0LJEP/SRk/eJwSGUxhYwK0cJXMD1eSxpUkLLvqGL6hYqBlYRX
 Y+BrsP7zVYNC0Eb2UrkiznEZqoxpvv7v0jkoyEBJw==
X-Received: by 2002:a05:600c:3485:b0:47e:e9c9:23bc with SMTP id
 5b1f17b1804b1-4839e669135mr28637895e9.30.1771497261576; 
 Thu, 19 Feb 2026 02:34:21 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/32] hw/usb/hcd-ohci: Implement frame number overflow event
Date: Thu, 19 Feb 2026 10:33:49 +0000
Message-ID: <20260219103405.3793357-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

According to the USB OHCI specification section 6.5.6
("FrameNumberOverflow Event"), when bit 15 of the frame count changes
(either from 1 to 0 or 0 to 1) a FrameNumberOverflow interrupt should
be generated.

This fixes usb-audio on mac99,via=pmu with MacOS 9.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3274
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Tested-by: Elisey Konstantinov <elisey.konstantinov@gmail.com>
Message-id: 20260212185425.2F854596A29@zero.eik.bme.hu
[PMM: added brief comment, tweaked commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/usb/hcd-ohci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index c7e9c71903..1aeed9286f 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -1246,6 +1246,10 @@ static void ohci_frame_boundary(void *opaque)
     hcca.frame = cpu_to_le16(ohci->frame_number);
     /* When the HC updates frame number, set pad to 0. Ref OHCI Spec 4.4.1*/
     hcca.pad = 0;
+    /* FrameNumberOverflow happens when bit 15 of frame number changes */
+    if (ohci->frame_number == 0x8000 || ohci->frame_number == 0) {
+        ohci_set_interrupt(ohci, OHCI_INTR_FNO);
+    }
 
     if (ohci->done_count == 0 && !(ohci->intr_status & OHCI_INTR_WD)) {
         if (!ohci->done) {
-- 
2.43.0


