Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46235C2BA18
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 10:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKEti-00020m-4C; Thu, 20 Jun 2024 06:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sKEtf-0001zW-PO; Thu, 20 Jun 2024 06:20:03 -0400
Received: from muminek.juszkiewicz.com.pl ([213.251.184.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sKEtd-0001Sz-P2; Thu, 20 Jun 2024 06:20:03 -0400
Received: from localhost (localhost [127.0.0.1])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id 8121D260836;
 Thu, 20 Jun 2024 12:19:58 +0200 (CEST)
X-Virus-Scanned: Debian amavis at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavis, port 10024)
 with ESMTP id aqoDiIFGFzgX; Thu, 20 Jun 2024 12:19:56 +0200 (CEST)
Received: from applejack.lan (83.11.22.244.ipv4.supernova.orange.pl
 [83.11.22.244])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id 49F2C2606D1;
 Thu, 20 Jun 2024 12:19:55 +0200 (CEST)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH v3 0/2] tests/avocado: make sbsa-ref working with >1 core
Date: Thu, 20 Jun 2024 12:19:47 +0200
Message-Id: <20240620-b4-new-firmware-v3-0-29a3a2f1be1e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEMCdGYC/x3MQQqAIBBA0avErBswC6WuEi1Mx5pFFiNUEN09a
 fkW/z+QSZgyDNUDQidn3lNBW1fgV5cWQg7FoJXulNEK5w4TXRhZtssJYWNtcN77PlgDpTqEIt/
 /cZze9wNwdyYLYQAAAA==
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Leif Lindholm <quic_llindhol@quicinc.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, Cleber Rosa <crosa@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, Ard Biesheuvel <ardb+tianocore@kernel.org>, 
 Rebecca Cran <rebecca@bsdio.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: softfail client-ip=213.251.184.221;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=muminek.juszkiewicz.com.pl
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Recent changes made sbsa-ref crash when more than 1 cpu core was used.
We handle it in firmware now so one patch updates it to the working
snapshot (TF-A 2.11 + EDK2 snapshot + EDK2-platforms snapshot).

Other change drops "-smp 1" from CI to make sure we test default setup
of sbsa-ref.

Previous firmware worked with 1 cpu by pure luck probably.

To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
Cc: Peter Maydell <peter.maydell@linaro.org>,
Cc: Leif Lindholm <quic_llindhol@quicinc.com>,
Cc: Radoslaw Biernacki <rad@semihalf.com>,
Cc: Cleber Rosa <crosa@redhat.com>,
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
Cc: Beraldo Leal <bleal@redhat.com>,
Cc: Ard Biesheuvel <ardb+tianocore@kernel.org>
Cc: Rebecca Cran <rebecca@bsdio.com>

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
---
Changes in v3:
- first update firmware, then use all cores (for bisecting)
- changed commit message in 'use all cores' patch

---
Marcin Juszkiewicz (2):
      tests/avocado: update firmware for sbsa-ref
      tests/avocado: use default amount of cores on sbsa-ref

 tests/avocado/machine_aarch64_sbsaref.py | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)
---
base-commit: 02d9c38236cf8c9826e5c5be61780c4444cb4ae0
change-id: 20240620-b4-new-firmware-177daccc9d76

Best regards,
-- 
Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>


