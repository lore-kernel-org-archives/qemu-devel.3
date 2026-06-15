Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56FECD98C7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 10:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ4uc-0000Uh-0Z; Mon, 15 Jun 2026 06:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZ4to-0000QU-SC
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:50:44 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZ4tk-0001SC-Th
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:50:35 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490afc47455so13527725e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 03:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781520631; x=1782125431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=bElw+ObnrJANhvVaMpMY5W3cKHNMW4adXEFOoSTdva4=;
 b=cUVzOzHK1LpkIRp2YGOF6ur4gw9P9F46tUFLfawQm1v3MZqIu+iCDjVTfkaBnsIH/7
 Em4WoL8lySYtO/Ak6LNht9OcfxigCjIv3try8NjHRRvuFcPehq2lERyqqGi3QoBGU6GT
 42mxMcKrm7WZ2YJYhZYksO49uma0MRQWYcUzfLEX1hxTMUMTsGObpHhdt4fd8JnD6RQz
 J2qga0YbiC2dSyWgjn0ONz4Yfy8d9Cea+f2siWqo2E7NgY+tMNGxSLe+cUblbtn1YEZd
 DRkcFB80JkEBZQeUbRgqamv4Zvhk+eGkVUk0XScvcwMqAO62s8F+SNYq6/YQ0bhPwjlj
 1tEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781520631; x=1782125431;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bElw+ObnrJANhvVaMpMY5W3cKHNMW4adXEFOoSTdva4=;
 b=Q792wZbQmP9nRy2pssDm1ivuf7ZJVke4THzZ6QzhEXFb+s+fSJkg59WqoXgQlVmo0S
 r3bzEoN1HADtY5Q3Y83BWSrCK6AoiPZhNoy5l3FoSVB2HpwpIM9ijW3gE7xgax1iQiIB
 9EDxmhICWf9u1HQBxq2VPuPY7BRay/4MJBZQIOLIkf0uCG8GZWmbIrHacGLg27xPmfOA
 PeFYQXs/o+a2MJYKsj8YvhAOzWNXUz2nfWnZvXP2tA0hEOiBgnIx5Ha6P/m+pRkbGCma
 2LWA3tFWpSGXgvi9zIJkFGTQQWgjZqGxY2LDe1er3ya/hdeMxQtzYr5h5Y2WRuPnoSwq
 LRwg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9O613CeSzU6k2yRYMzbiHSaRwH/IoxmlDA5a8Cya4WEtVsjxkKt72Bulr6MchT5+hZXLTc65uhrS3v@nongnu.org
X-Gm-Message-State: AOJu0YxIZNHK2VfgJoz2BfL+9p5P5nEpvpNc0Z14sxtdU+B1K2xIAe97
 DOzbVCaFK6AN8BJhWSlqpGqr/oE6BHpiHbL8fxVbC7WP+2cfQ+WyAUMVAtlK9Re50mc=
X-Gm-Gg: Acq92OGU0S56c8d9jJ9PsvXcnYSn9w7n65Cw22AOfjpcLAppaDEuaXfcxMjepeltNUn
 FJ+yHFd/kBpOK9N2UL0j+bqAqwUfXn0nFvvw966as+f+O6IB58tFM/J/3HeIMGlBJGo2cOeHyg3
 UvDZ+khw3ML810nw1bDYgdL0TmnhmgRpHKS/ooShr2FDd/DbYYMFiRP+wOGgjFZxIsGkmZGiEjH
 eAUY/MnNRRjbNzWsbDKFcFI9j7keN1KtFQWmPL/mzhqbAzP3eMu9R515DwFZwT8sZ2xkEYq5VBJ
 V3O4+d3mu3ED6XWAgegZ54uwubpW2+gVLL+8BT1/JeO7lq0KBkxgpvsH/HxVdORqjbIHBHZ7NBY
 rB4pv9yOTGZWybEUSAbkUnqFas58cqqMQe/Qs3bKG8kYh8B0vnS7wyoZrdiW4TsQ5GL5+Zr7BLl
 774DzJtqJvyCK8zqKLGtrDnuzUJkuoVtc9/5bPN12pFCm9GiOMcrIkMp5Z8XniB829ILcYt2MNM
 maG21oAm+d3mE2vKaGgUrDHpNw0DQkLGHd/Hd29clM=
X-Received: by 2002:a05:600c:c04b:10b0:490:be1e:6ce6 with SMTP id
 5b1f17b1804b1-490ec4d6ae3mr130077615e9.9.1781520630962; 
 Mon, 15 Jun 2026 03:50:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f263945sm33863674f8f.8.2026.06.15.03.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 03:50:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/5] arm: GICv5: minor fixes
Date: Mon, 15 Jun 2026 11:50:24 +0100
Message-ID: <20260615105029.2898872-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patchset has some fixes for minor GICv5 issues that I noticed
while I've been working on the GICv5 virtualization support:
 - 2 actual (but minor) bugs
 - the GICv5 spec now has a final URL we can cite
 - a minor cleanup of how we say "no pending interrupt"
 - the ICC_HAPR_EL1 register is removed in the latest version
   of the spec, so we can drop it from our implementation

thanks
-- PMM

Peter Maydell (5):
  arm/gicv5: Add URL to GICv5 specification
  target/arm: GICv5 cpuif: Recalculate IRQ/FIQ on ICC_PCR_EL1 write
  target/arm: GICv5 cpuif: Tag ICC_PPI_PRIORITYR<n> regs as
    ARM_CP_NO_RAW
  target/arm: GICv5 cpuif: Remove ICC_HAPR_EL1
  hw/intc/gicv5: Define and use GICV5_PENDING_IRQ_NONE

 hw/intc/arm_gicv5.c               | 11 +++++++----
 include/hw/intc/arm_gicv5_types.h |  4 ++++
 target/arm/tcg/gicv5-cpuif.c      | 29 ++++++++++-------------------
 3 files changed, 21 insertions(+), 23 deletions(-)

-- 
2.43.0


