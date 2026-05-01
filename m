Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC2FFF885A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkuE-00040m-Mh; Fri, 01 May 2026 06:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIku6-0003yy-OS
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:28 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIku4-0008Tk-JY
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:25 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so23185085e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777630523; x=1778235323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uHU9h2+WU5EN+SU5sswOD5/FpuOCYQGm063E2pBhKIc=;
 b=BKXbraPhsN7nJ81XDwL7u/KrPD+82YqYaE5BjCWFow5swVrkExiC7vMXW7oxXswAE8
 Z1+Yj2RiydSz2JEkQrHWcZDB5QUUtStZc3VPKWMvYnXKRIAPpj5VVm+v/5JmjUF9xhAZ
 deyJB+G3nwIYvABYESk1/PwbAiOBu7SPfq0nigwuoQMVF9KuTupBLEZ0PXKTwhiWe4h7
 DKjXSkqe0kpvvFu266TWgAzPcdQOq5nsPnoINcdJoIWFOoUIADdeKVQ3WWv1j1EsxE2Z
 5BdgLmaRtyVnoZAZYKeyNvWvFTptoBsTKI+y8Xes4lhPUUCUl264FCMDzLkcR0bccQe4
 5ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777630523; x=1778235323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uHU9h2+WU5EN+SU5sswOD5/FpuOCYQGm063E2pBhKIc=;
 b=QIeAL7qKFqEmwp+PC2QRtEDDWU1q8IPDaiSDhHTxGQba54nItFSuuwB+nMErx4GNyN
 G9mKvF49RovEyNTwVUzgqirxYayvyopijTKryacWa18rDegfcd1abeTrsYyhamQTmrp+
 XChVBgmdw1X/5b+O9WHskdmmVwqpCHc7siqDjujyHo8Nxm5UYTXCCyZHEsk24Rbr6Xp+
 8sVSWpo7sTabZL+cPczFUD4pTzRZldIVtvC2ZNkI93QrRAlpqWplSroGlD2xf4tkWKFn
 BZPgg/w/gxJdwPMxdNkS4epKHQ+8pf/wvGmoImCVWdvZzKD0jxvnIrg66xhQaGRyYAxK
 uZig==
X-Gm-Message-State: AOJu0Yz/9qy5zTnTf9dQ8kTeaAG3C0HnI+W9l6G4VOrSTzQjTuCxDDwT
 PWzdSjEF+p8zZ9h08yGDkZOlrWmqYy+55UFwm+mQ3LW6MtKazVzsMsvts2pHmbNpw0ELz/fx4qz
 ZJ8A5
X-Gm-Gg: AeBDievEDi2vyBYPbmw22SvRTCFzHsnImsohMkhXSOt2LlfEIZr/MzY5C5XiEfslmgs
 6yC2kba6211ZON2FO3Kzk+uXogLXJgAPgYr4240Eqt1BeBs/woFnxwSIT2uOiiRc6GFVnCgTSnY
 nXIgIOn0oNQ0YXeLMWcHlgNYtCU+pcj9C/gbIus6eOzN3xSFkqi2HvjPA2dgY4NkOnItfhnKnb0
 Bt88RU14WybWivTPACi8V9vhLyJPkpQIPsRqh+VGRcBtgIzun+yPhJnsSB8yZVrkbWmdnbIwsQn
 XvTFxn5jAMVSRhuQ0xO1sfWns9sKk7UsDGxRAd4pmq4rbBXg7Ba3XC7ria7bDwkW/XXGX3QJzV6
 QG1j8Qyr/bMTTckNb2oykiR4VJQnj8EIokLIh0D0Ww6skiqt6Bmy3ayGF5VFKp0UlNKVH1CwHNa
 r4i6K8z+r6NA7cL0v3hpOvGtNIl2qFfU2immX/wFHwd/sn71CA6tdBmCmOYzKEVXEl+omkcrfFE
 aaXFeI5jZd73vW2ucKFZ4bw6koRtV4QVRa1c2tfMQ==
X-Received: by 2002:a05:600c:a40a:b0:48a:53cb:85f4 with SMTP id
 5b1f17b1804b1-48a8eb9a7a1mr28177265e9.24.1777630522889; 
 Fri, 01 May 2026 03:15:22 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fede418sm12863335e9.6.2026.05.01.03.15.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 03:15:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/28] hw/net/allwinner-sun8i-emac: Flush queued packets when
 rx is enabled
Date: Fri,  1 May 2026 11:14:48 +0100
Message-ID: <20260501101505.3485916-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501101505.3485916-1-peter.maydell@linaro.org>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: 宋文武 <iyzsong@member.fsf.org>

The RX_CTL_0 register includes the RX_EN receive-enable bit,
which allwinner_sun8i_emac_can_receive() checks. That means that
if the guest sets it we need to call qemu_flush_queued_packets()
as we might now be able to handle them.

This fixes a bug where networking didn't work in u-boot on the
orangepi-pc machine.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3459
Signed-off-by: 宋文武 <iyzsong@member.fsf.org>
Message-id: 20260430040753.3337-1-iyzsong@envs.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: expanded commit message, removed unneeded RX_EN test]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/allwinner-sun8i-emac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.c
index 9b7c67ae8e..8ddaa6101f 100644
--- a/hw/net/allwinner-sun8i-emac.c
+++ b/hw/net/allwinner-sun8i-emac.c
@@ -727,6 +727,9 @@ static void allwinner_sun8i_emac_write(void *opaque, hwaddr offset,
         break;
     case REG_RX_CTL_0:          /* Receive Control 0 */
         s->rx_ctl0 = value;
+        if (allwinner_sun8i_emac_can_receive(nc)) {
+            qemu_flush_queued_packets(nc);
+        }
         break;
     case REG_RX_CTL_1:          /* Receive Control 1 */
         s->rx_ctl1 = value | RX_CTL1_RX_MD;
-- 
2.43.0


