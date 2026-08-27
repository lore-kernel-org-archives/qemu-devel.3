Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4657C61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzcQB-0004Zp-FK; Thu, 27 Aug 2026 11:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1wzcQ8-0004ZJ-KF; Thu, 27 Aug 2026 11:53:40 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1wzcQ6-0003sh-SM; Thu, 27 Aug 2026 11:53:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=xfsyF+f
 1uhUR3iPOxo0SPG+llC69MlGOyjHp58/UM2bPSWTfspDsUNQ2+DB/zsLZ8stLZIpnL8D1O
 CbQs7DPen6UVOX6E4OY/d7vCJMAupHVOjgmrEBbXzeERwgcObL1O6jPS/WlrPi1Jl4Y5E9
 cHum7wIlVYnDbZplq2BHmrKSgzkHrCzI2bjeKzyE9y8BVrTpEBPwGtfXZgsL5+Z5g0yBqI
 VEuvDiVq8TNXDEcBLY6WkblrqK4dFQ8tWOWalpWqx4ybp3PqUEVaJCLNyujXO7jP++SRQd
 155t5nb5t4lIt4xnjSUtpfkqnRUCwX1rh0JneZmyHZwvWB6qVwNUuPg==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=x
 xbSfOiNAv8flfoGychITKljzJz/gDt5G30JCPaaGa4=;
 h=date:subject:cc:to:
 from:dkim-signature:dkim-signature; d=mx.catap.net; b=hOKnUZzO7WCcB0Fp
 MQmmpwUyzeL3NI62dDcySLPXtIRaBuA+9nAvBZhlgi1mUIkaWk3l+GF5i4E6Hn1TxRz0UV
 FDKe4/j++map0Li9vtjbgyInWZxbQq44+m8bRv9nbFOpNB8PHVpQIcALChcy6OkjYEbeJq
 xpJqUxpsxqYLnSLitD/uUiPoTi+Rf8RH5Y3q0waC0mAs3Jko0hIsZ4KyIrmupyMv7618EE
 zN/mk47gBrxhLAFD+Z+8UoiVjx9DI5eSJkgnIbI+MFTkMzjiqS0LFeE+UzQH6dS7HikzPK
 /XP3ugIoUtzSsWPAaTK+ggWcjlIUKF1/6b7YJS2NnaU3kw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=mK0+hTOd; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=kTPeM3Fs;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=xxbSfOiN
 Av8flfoGychITKljzJz/gDt5G30JCPaaGa4=; h=date:subject:cc:to:from;
 d=korins.ky; b=mK0+hTOdCSW4Y1U3zeteTd0aRze3GZ5rQwPlSweiChgQ3ZYt4DAq1RG
 GBl7meglaDBXrnRdGleJCbekTwGLtd/BvDZMSzb0fF+OF9HwQS8+eq2byweNj5SaJo/k+a
 1LBK0+Rj2vXElQQvpr9tinM5/WUoGeKNRSvbFr+W3tuBiDaTB9v5ihkZL/aG268+DzWSyM
 y5r2pju4Zj2wl6Ewl4NPM5MfWA1bQQDOEarRhJG5w2o42UypvfOqOax7ABUHbZNFArNU78
 /5QHEEZW4NRfIRpjNo8018DGs4wgadhrDaZwRRHcwafaq6GJDWLvRSyS4edCJ3w9xvAWTM
 AeLODZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=xxbSfOiNAv8flfoGychITKljzJz/gDt5G30JCPaaGa4=; h=date:subject:cc:to:
 from; d=korins.ky; b=kTPeM3FsuAywYSD15JVipPx99P/8GBzPTg5PdaZKU+RqNPaw2
 k4dbQ0t/QGV1UIbnaGXtFLP7FpzyAmv0OxXBg==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id 30e2e8a6
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 27 Aug 2026 17:53:34 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id c392cdbd;
 Thu, 27 Aug 2026 17:53:33 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v1 0/5] mac99: Boot OpenBSD/macppc
Date: Thu, 27 Aug 2026 17:50:33 +0200
Message-ID: <20260827155310.7223-1-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Greetings,

OpenBSD/macppc does not complete early boot on mac99: OpenPIC can
reassert an interrupt still masked by CTPR; the edge triggered
decrementer does not raise on zero; successful CUDA ADB replies omit the
original command; and the fixed CUDA shift register delay can stretch
packet delivery past the guest timeout on hosts with coarse timers.

This series corrects these four behaviours and adds a functional test
which boots the official OpenBSD 7.9 macppc CD to the installer prompt.

P.S. this is second attempt to send the same patch because first one had
wrong subject and missed qemu-ppc@



