Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F5AF01830
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 12:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyTwh-00012U-Pq; Fri, 06 Mar 2026 07:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyTwR-00010U-VW
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:06:04 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyTwO-0005Mc-Ga
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:06:03 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4837f27cf2dso85439905e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 04:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772798757; x=1773403557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xjTySljdoOafAgUarglKvNAbtMoISIWDjJDpZqFUIWE=;
 b=AMDqwhM/YwBW4OflsRZaEQHyJhqajRU1T9mS/pdMEh75/Q59KRbUDxGsUUeyf7+lmt
 LP4wi93jFjOOjQ9uXLGD1ur0zt0NlbNeAD2afVrRCpJDWvMAPPmxcCBTzROVirmxo2mu
 yTzDUquZEPbwNEBpHamGJNZYEXpALZ7UMpUstLw3pvzf01kjpuS0BN3NrUDQIWdpzd2I
 E34IzSdBUa1RZZ3142DmJuiH4N2/xM3waXsjVn0Oxo0DGxVWr8Sb+dXgCvH53N2Q5hCY
 T+FPuy+64MGFcZAMegbYsz6k65Bs/8PrlIg0cxdlDb4apbCz8pgLrXgbD0iwwdfB2viX
 ia5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772798757; x=1773403557;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xjTySljdoOafAgUarglKvNAbtMoISIWDjJDpZqFUIWE=;
 b=EXyT7WfVRfKpl+8nbgNJISx6JNspW27p6gzTfAjIp4whp0jqtoC66Gsm9dLPLhI15J
 cH7xVtTWfqx81xELR65Y2erOa7bn0mv3i5gYa+N5QPIfKqfvR/AD73iBBwBCjkmED6JG
 dh8YtAlKr06GldEQQtY/l20wSHGxLz69R+PHbwbeihxiRN9wJHvGJlv0RZtBBeiKlI0z
 hyEIpE/jrGMyXZcD6FgvBqD39nTrlfIRfZpsUYa/AwCvuYMqdKyAzQPnMp4ybpcHF3mn
 ELt8fZcykdYKss5c31CLgRCSVshszOrMq/edXF+Z56ev/7cz/UcWdrwuvyjImRBdQD9c
 Fj9Q==
X-Gm-Message-State: AOJu0YwvMFcjxEBCVwF1x6EpV/xUEbU0qcnqVExVAVa759TcIOMqOJOH
 JAxlAf7PqTitc01AlwgmZZq/ZV0loRPKdy8ux8WaM4tZ36XAQx/Vq29F3YGqBiX0HNKfkTLhRHE
 WEUFA
X-Gm-Gg: ATEYQzz3Y7O2551gT6QXgO5xTQZ339fj4ph8lgZpu0xXl4LJDLL2X0lbgoGNH/el+LY
 wt9D7CfD6xk0xrFAVUYrFsjlvqaJZ/v7pMCRbG9ETLeMnEuY52Vm4ZXzd1dyYwp2gvMK+ip3auh
 WbO9yPruifv1eJRGQanDSxIqu0v72SOEhIjJ2/AJmuCHgk6WRa12IHIoXOfKJQokXUKjEvwPPzT
 L2sgNfAICOvgoQN5ttBEw8hkfUp8bLPzPPzxb6i/BUpshCopoACSIO9rzc4xLefJ7wWIR5hI6Az
 6/i2i1EbMms1gBmmsCuW3rjfYkuSCUtWLaxVbDK8NCRe/cY3euBC/DT38P80m2JjfSNZCWgAAo5
 MpT8KT0omISNyb2Js6tz/5/KTsHkCv7ahlsbuNwAWCmw7s+TqLEYoe2mG65LaOl5+ZG8vFTOYXP
 d7xmLZeYPcSp1C/oZWvZydSqbzmYKNdrKoFPvUUALcll4fINZecNrZkT8zRI5lxVsDAil8lziw3
 vVf5aAhvcbRv/ZU/2eKyMU9Ie91fl8=
X-Received: by 2002:a05:600c:4f0b:b0:480:68ed:1e70 with SMTP id
 5b1f17b1804b1-4852697a114mr28480465e9.35.1772798757167; 
 Fri, 06 Mar 2026 04:05:57 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527681e2bsm32841945e9.5.2026.03.06.04.05.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 04:05:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] MAINTAINERS: Remove people who no longer wish to be listed
Date: Fri,  6 Mar 2026 12:05:49 +0000
Message-ID: <20260306120555.2035421-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

I recently sent some emails to people who are listed in our
MAINTAINERS file but who have not sent any emails to qemu-devel in
the last few years, to ask if they still wished to be listed as a
maintainer.  (The motivation is to avoid sending people patch emails
they're no longer interested in receiving, and to give us a better
idea of which parts of the project are maintained and which are not.)

In this series I'm removing the entries for people who replied to let
me know they didn't wish to be listed in the file any more.  I also
in the last patch remove the one email address that was not
deliverable.

At the end of March I'll send more patches to remove anybody who
hasn't replied to my query by then.

In all of these cases, I'd like to say thank you on behalf of the
project for your work on QEMU, and for helping us in reviewing code
and maintainer duties.

-- PMM

Peter Maydell (6):
  MAINTAINERS: Remove Hannes Reinecke
  MAINTAINERS: Remove Cameron Esfahani
  MAINTAINERS: Remove Eduardo Habkost
  MAINTAINERS: Remove Radoslaw Biernacki
  MAINTAINERS: Remove Andrey Smirnov
  MAINTAINERS: Remove Chris Browy

 MAINTAINERS | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

-- 
2.43.0


