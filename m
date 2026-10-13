Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4C0CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY2x-0006lQ-8s; Tue, 13 Oct 2026 04:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY2v-0006ka-PU
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:39:41 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY2u-0007Y7-0U
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:39:41 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a0213948d3so16335175e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880778; x=1792485578; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yMqLoW+XIVeQet+rIDECiVnH/oSDnZLxZQh8AFD0o2w=;
 b=q48KTAVJRjjM7NPzja7OF5c9ebpWYLORzYv8op7q0XKMnqARCWNvhTzcmMORfHxD7+
 HCgckV2xIyUsevQ7Uo7+6BAvItrmRVaj7qgGvdhcwKGtD0SYZA/POd6b5zEPowSFyAGb
 IYPpSX695b07gdCXCOr3WIdtyHh2DgKx8k4lVETE2uLX3DGT2U7anNCV0P9G7Y9/Gcqn
 UfUmBGRWrGLl/Bk8XglI3LF4T7ZbRwPWxPVRbTam/4Tt1GJl56WA4/nceLcUEXCUZsH2
 rheKHrMXbc1JxnqvixdKOUgD2mV40ED35pzxibkbUN5mHILjLh+P0rEvW+LdKrEJb6v3
 IT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880778; x=1792485578;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yMqLoW+XIVeQet+rIDECiVnH/oSDnZLxZQh8AFD0o2w=;
 b=s8qkNPjsS7vmLgpGTEemnPWe8m2aNk1ym/mBNGhESTd0HkaiambQs3cFYT4glT48up
 PuhUVOIAkhM3TqT46RpdY+zx9+sIEGvOJ2X+HQggjxvBty6KLtJeK0x+W8dbSrEeomF2
 4WBIkIPQgCTcFsurv6ThHmYX37kb40PQWT77VZ4Kvo3Zz7S009QkP1h33FBZHvpkRcj+
 VZVFP3N1EG6o2GailntjUSzddeKsJx7AHMt0F1jeHTcahGHRvAczSWyP7WA8E+EcLS8+
 AmvSzBNvAjZFJelwEcS7Yo+cc3OH42hRA3r70IIPUlsH7G1Sd6BLujw+3Eia6P++GZzs
 REXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw66aIImc53T5rsxN+ok2RzPCjkncuafEM/hNiv9hIZJrEbs2HH0N/ctLfNj75cOdIBTLborOUrhuyx@nongnu.org
X-Gm-Message-State: AFq9FYJtUJN832DbB4r6y31rEdhLksK4zEf6cwtSMwFHn78l0k0hhXFe
 A7kLb7AtHPjvhnADog8ZDFTiCNjkx5LFR87RGzyzL2yCy8o3gaZvlZ9EV+cWB1TPc6bASWRlBM0
 4c48y2B0=
X-Gm-Gg: AYBFou1r4/Z8oA2dGo58bDRZUbRW4oIJOULd2FxLJXngibB0RSxrqAOlN1qV9DSfZDY
 L4fXGwBtcTo2lbUQGVyn9xbQhkDoFcjrtdsgG79v2NG+OtB7QUk+563Fg2V/kHxJm3tkbALjsml
 GXK2wD3+coeOpxRZZL152N3pZASy0Ie0H1rRAma2aYyTZGwfUwO23r+uOse+pCnWKC3SZ1j7SYz
 AqsO/UCMKOih6CIxP5z+/sOSpqeS1BBhWf0SHBUj/o6YyZsKW0OnMw3aU+mmxTCvvY3jR0+OD0J
 89dgz0R0ZRD2F96rZz1nAqy38i27n8cwP07LJ5hefQeS5QfG2I13YmBBppyuTkzDvS977I3Kdai
 f+zq3soGI0ad14ZPv1LKv4d4NwjLvUbCvl3iZJ2ihc4+L7TpYB29TE/W1XDANJ14zxwmMCjNJPF
 KJ4i97CWC2gIaHgumaAlRvCWetr+QTxSD3xvw7E6OcySOML7AbBbKljgiOtHqPo4SxL52JUUt/0
 WzWrTG+xiSlJADCrQ3lcs3V+nrLqWnQgIBd3wGSSzHDrv1pK/v9fZsepap/FHe+5lNxZRH5h7yp
 BaE=
X-Received: by 2002:a05:600c:154b:b0:4a1:6af4:c6be with SMTP id
 5b1f17b1804b1-4a18e4d1c0amr215390865e9.34.1791880778509; 
 Tue, 13 Oct 2026 01:39:38 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:39:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 01/86] hw/intc/arm_gicv5: Make IRS_IDR0 reads return actual
 value, not 0
Date: Tue, 13 Oct 2026 09:38:08 +0100
Message-ID: <20261013083933.1024405-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

IN the code for handling reads of IRS_IDR0, we carefully construct
the correct value starting with cs->irs_idr0 and adjusting it.
However, we never actually write the final value into *data, so
the guest will always see zero.

We didn't notice this before, because Linux happens to not care
about this register value except to check for the presence of
virtualization.

Cc: qemu-stable@nongnu.org
Fixes: 405ad2e76f13254 ("hw/intc/arm_gicv5: Implement IRS ID regs")
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 08878193dfc..ebfb0878af3 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1433,6 +1433,7 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
             /* ...which means VIRT_ONE_N is also RES0 */
             v &= ~R_IRS_IDR0_VIRT_ONE_N_MASK;
         }
+        *data = v;
         return true;
 
     case A_IRS_IDR1:
-- 
2.43.0


