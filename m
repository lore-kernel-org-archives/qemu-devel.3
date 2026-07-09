Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59E1C44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whqcC-0007qt-HE; Thu, 09 Jul 2026 11:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whqc9-0007q3-7v; Thu, 09 Jul 2026 11:24:37 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whqc7-00084O-1G; Thu, 09 Jul 2026 11:24:37 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id A09692003E3;
 Thu,  9 Jul 2026 17:24:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783610670;
 bh=CXVE3rlSgcDs2PF76Z4rgYZ5WHvy9/IeZPv8mWXj+kI=;
 h=From:Subject:Date:To:Cc:From;
 b=Wq98Gktr1eccdCyjJonxtLrtmNlHJ8fCG/LBZg2gj6prGceVmfjYP0hg+e/+/bFh0
 fdFjkdBoMtjfvQL7OE8UjTGDlSSr9f6162C+We2evMsBZy8zBfVlWecp0mqtJsEi0J
 lzeglGbfdZQYMWTX9JEFSLLGK0rx6KH5NAXyJEBPO0fgTF2BFeqOenzvUqNmADSRUI
 fdya7m08l2FaeQh0gge3vi1jHjQ94S53hV1Ohd1qG7sufa8iNe0fYPxF1dYbSGnUZ+
 XTIzhN5GJkATzzD3qiVBmOnwt3cJIqgUnfq0r1BIai5DQLYnN75JRISPIDlZY+gvNE
 xDYfc/XbAZRdA==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Subject: [PATCH 00/29] hw/arm: improve Aspeed Catalina BMC emulation
Date: Thu, 09 Jul 2026 17:23:38 +0200
Message-Id: <20260709-catalina-upgrade-v1-0-814575bc076b@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBG4avIrA2kEYx6leJimvy1I5JKolIQ7
 26qy2/x3k4JUZCoK3aK2CTJN2Q8yoLch8MAJT6bjDa1trpSjheeJLBa5yGyh6rAsL711jQt5Wy
 OeMvvWj7722l9jXDL/0PHcQLVqDAFdAAAAA==
X-Change-ID: 20260703-catalina-upgrade-3eae7d9d7289
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Corey Minyard <cminyard@mvista.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610646; l=5193;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=CXVE3rlSgcDs2PF76Z4rgYZ5WHvy9/IeZPv8mWXj+kI=;
 b=Hih4jgE2aMzYX4zUI7WYfftehhNULRLjnj7GB9+vYIUd3xweC3FTcFKKW+5FWwlYYYMkd1rov
 2OYzXuTorlhATrfSqthKWCs5FQs+AxjW/2rCcGXFnPCxNSuWOvhng2u
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=212.27.42.2; envelope-from=emmanuel.blot@free.fr;
 helo=smtp2-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series improves emulation of the Aspeed-based Catalina BMC machine,
mostly around its I2C buses: the GPIO expanders the board relies on and
the temperature sensors sitting next to them.

The bulk of the work is on the PCA95xx I/O expander models. The existing
PCA9552 and PCA9554 drivers only really covered the exact parts a couple
of boards happened to use, and some of their register and pin behaviour
did not match the datasheets. Catalina needs a few more variants and
expects them to act like the real chips, so:

 - the PCA9552 driver now provides proper PCA9555/PCA9535 types, applies
   input polarity inversion on reads, and handles the command register
   as the datasheet describes (auto-increment and wrapping);

 - the PCA9554 driver gains the 4-bit PCA9536 variant, reflects
push-pull
   outputs back into the input register, and grows an opt-in mode that
   honours the configured pin direction instead of forcing pins to
   outputs;

 - both drivers expose each line as a "pinN" QOM property, which lets an
   external actor drive an input pin. The property also allows reading
   the value driven onto an output-configured pin, which is the more
   useful capability, but nothing exercises it yet.

Along the way both models get a fair bit of cleanup (DEFINE_TYPES, the
Resettable interface, state moved out of the headers, default
descriptions derived from the instantiated type).

On the machine itself, Catalina now instantiates its PCA9555 expanders
as their own type, gains the NIC and FIO temperature sensors present on
real hardware, and drives the pca9554 expander input pins from outside
the guest.

Finally, the register-level behaviour of both expanders is covered by
new qtests, and the functional test that boots the OpenBMC image now
exercises the expanders end to end, both through QOM and through the
guest's gpio tooling.

Note that the "hw/i2c: parent slaves created with
i2c_slave_create_simple"
patch is only a temporary dependency here: it already belongs to the
separate ADC128D818 series currently under review, and will be dropped
from this series before it is submitted for final review.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
Emmanuel Blot (29):
      hw/gpio: pca9552: register types with DEFINE_TYPES()
      hw/gpio: pca9552: move PCA955xState definition out of the header
      hw/gpio: pca9552: rename I2CSlave member to parent_obj
      hw/gpio: pca9552: default description to the instantiated type name
      hw/gpio: pca9552: declare pca9555 device as an alias of pca9535 device
      hw/gpio: pca9552: use the Resettable interface instead of legacy reset
      hw/gpio: pca9552: apply input polarity inversion on read
      hw/gpio: pca9552: conform GPIO command handling to the datasheet
      hw/gpio: pca9552: expose GPIO pins as pin%d QOM properties
      tests/qtest: add PCA9555 register access tests
      tests/qtest: pca9555: test output-to-input reflection and pull-ups
      tests/qtest: pca9555: test polarity inversion
      tests/qtest: pca9555: test auto-increment and command wrapping
      tests/qtest: pca9552: test behaviour specific to the LED variant
      hw/gpio: pca9554: add PCA9536 support
      hw/gpio: pca9554: add hw-dir property honoring the configured pin direction
      hw/gpio: pca9554: reflect push-pull outputs in the input register
      hw/gpio: pca9554: expose pin%d as a string property
      tests/qtest: add PCA9554 register access tests
      tests/qtest: pca9554: test output-to-input reflection and pull-ups
      tests/qtest: pca9554: test polarity inversion
      tests/qtest: pca9554: test absence of command auto-increment
      tests/qtest: pca9554: test the PCA9536 4-bit variant
      hw/arm: catalina: model PCA9555 IO expanders with their own type
      hw/arm: catalina: add NIC and FIO temperature sensors
      hw/i2c: parent slaves created with i2c_slave_create_simple
      test/functional: catalina: test PCA9555 IO expander via QOM
      hw/arm: catalina: drive pca9554 io expander input pins externally
      test/functional: catalina: test PCA9554 IO expander via QOM

 hw/arm/aspeed_ast2600_catalina.c             |  67 ++++---
 hw/gpio/pca9552.c                            | 256 ++++++++++++++++++++-------
 hw/gpio/pca9554.c                            | 175 ++++++++++--------
 hw/i2c/core.c                                |   3 +
 include/hw/gpio/pca9552.h                    |  31 +---
 include/hw/gpio/pca9554.h                    |   3 +
 include/hw/i2c/i2c.h                         |   7 +-
 tests/functional/arm/test_aspeed_catalina.py |  81 +++++++++
 tests/qtest/meson.build                      |   2 +
 tests/qtest/pca9552-test.c                   |  76 ++++++++
 tests/qtest/pca9554-test.c                   | 223 +++++++++++++++++++++++
 tests/qtest/pca9555-test.c                   | 251 ++++++++++++++++++++++++++
 12 files changed, 994 insertions(+), 181 deletions(-)
---
base-commit: f893c46c3931b3684d235d221bf8b7844ddbf1d7
change-id: 20260703-catalina-upgrade-3eae7d9d7289

Best regards,
--  
Emmanuel Blot <emmanuel.blot@free.fr>


