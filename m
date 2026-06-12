Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A769FCD98D6
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY53p-0007h4-DQ; Fri, 12 Jun 2026 12:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4623e61353=eblot@meta.com>)
 id 1wY53o-0007g7-3c; Fri, 12 Jun 2026 12:48:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4623e61353=eblot@meta.com>)
 id 1wY53l-0007nH-44; Fri, 12 Jun 2026 12:48:47 -0400
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CEWqvq4026335; Fri, 12 Jun 2026 09:48:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=s2048-2025-q2; bh=qqgVGuxYuHHijleUyX
 9CrcOTDWUcGInSWB2y8qSLIds=; b=okNofTdH7zKchqORM584ppl7Ox+5091PZS
 Kd7yw6Gqtc+A415Tv5z4sLcUY44x7IugG1M5mdJ5ZwtjssMpxeQTQnrZjJPQlpCz
 T/YwVR57CH4YS66mIYYu6sKOlgLv7crE+TNyrfRqa0XvCc+5RuomA6vFx/W8RgVZ
 lVf2J5PxlpHlatASnXXV1ar9bjwIhPpVaxcRjHCbXFXREckbiX3qTSKdlJmwQsnt
 EBre1pHriQdI9VNaJP8l7bHHcfznFdapPsf9k7EwUj1ijTwRyCO/xy9gtJ3jWDYk
 2Pi37dTABh9/5JPGUUhFX78WqPHP8wAUqyh76DaFIHloYz09Ng2g==
Received: from mail.thefacebook.com ([163.114.134.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4erkymgvg4-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 12 Jun 2026 09:48:02 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::4) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Fri, 12 Jun
 2026 16:48:00 +0000
From: Emmanuel Blot <eblot@meta.com>
Subject: [PATCH 0/4] hw/sensor: Add new device emulation for TI ADC128D818
Date: Fri, 12 Jun 2026 18:46:59 +0200
Message-ID: <20260612-i2c-adc128d818-anacapa-v1-0-9e4640cd164b@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ7CMAxA0atUnrEUu1IIXAUxuI4LZghVAgip6
 t0JML7h/xWaVbcGx2GFai9vfi8dtBtAr1Iuhp67gQPHEInRWVGyEqecKKEUUVkEadQ42mE/Tzl
 Aj5dqs79/49P57/acbqaP7w227QOxAa4qegAAAA==
X-Change-ID: 20260612-i2c-adc128d818-anacapa-13c63e97fbd0
To: <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 "Jamin Lin" <jamin_lin@aspeedtech.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 "Andrew Jeffery" <andrew@codeconstruct.com.au>, Joel Stanley
 <joel@jms.id.au>, Alexander Hansen <alexander.hansen@9elements.com>,
 William de Abreu Pinho <williampinho@meta.com>, <qemu-arm@nongnu.org>,
 Emmanuel Blot <eblot@meta.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781282877; l=1478;
 i=eblot@meta.com; s=20260602; h=from:subject:message-id;
 bh=8vfMJAKErHFkVvv+/skB8+BQHSiZXVpI90E9qaPpwgk=;
 b=kV6TqA12OEVF0KSvDe0R65xrViGkHXeKSbYPQeKkXKgcuefE8GvAVqXRSF75NzUruevyAhyRt
 vf9U0WLYdOyDqJkQ/adn5BUldyCLI9ZpHeAj9tS70G+wFti2Dkygehj
X-Developer-Key: i=eblot@meta.com; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
X-Originating-IP: [2620:10d:c085:108::4]
X-Proofpoint-ORIG-GUID: zno6GEpZzgmyHmXLOIIOKWWPD5jOjD70
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE1NSBTYWx0ZWRfX+cKIVlVjb/5r
 WTOOOY/K+4X45weVqhl8CYrRBtVH2Um15DaJ55dFkfZTBRdMMM1wjN8oTrLkaMzaHMQpD3mfsIV
 IBUeNq+SaAf+IN8oqg2FQv/pz8YWDbQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE1NSBTYWx0ZWRfX0yNxXdlPOWry
 h//v5dXcldNpX5K9rM0CuYumM44FLs4QJ5QLeY+D2VnAaO7izfGxwvRW5vkVWicD2WGhcEOFcQP
 9rjQjiOECiQw7hVnd7nMs/1cBji5gLV1hFwA0DEbejwSw0bNmnlGaUt7EapqFK3PyTb2neCRuWj
 35d8JmPGhHSJlkP8Ly+/xxtJQxUzaN845QOGbwpbnHDVmPAYieTuPO63ZpQClJBTKWq45+F/aPF
 RdX5hKYzFoGajAQsdVWk4RBtHhnH3l/T4s22pnjNGBo8um0ieVlIizLiyWfUC/toB/uyfpknDeK
 5pYAqc93DCyYLx7QblUyAU89WZHiQ/WMA0EbCNHk3i3oJNYIJ6YBfjwMsj/4eZANBQ2Lh/2kefk
 Jq1deHeBoa6VkmZEHa1awuCF/mEjyfWevAZGSss2LbbRl+EnmGbkE/+yncA+AvocnGk0Rj2Ml8T
 FHB/GomirmqD7RTWw/Q==
X-Authority-Analysis: v=2.4 cv=TK91jVla c=1 sm=1 tr=0 ts=6a2c3842 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22 a=sozttTNsAAAA:8
 a=VabnemYjAAAA:8 a=EkK5wCPZol7t6GGdW4wA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: zno6GEpZzgmyHmXLOIIOKWWPD5jOjD70
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
Received-SPF: pass client-ip=67.231.153.30;
 envelope-from=prvs=4623e61353=eblot@meta.com; helo=mx0b-00082601.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a 12-bit, 8-channel ADC I2C device, which is used on several
OpenBMC platforms.

QOM properties can be used to change input ADC values and external VREF at
run time.

Add it to AST2600-based Anacapa machine, along with some functional tests
that use QOM properties to inject voltage values into analog inputs.

Datasheet: https://www.ti.com/lit/gpn/ADC128D818

Signed-off-by: Emmanuel Blot <eblot@meta.com>
---
Emmanuel Blot (4):
      hw/sensor: adc128d818: add 12-bit 8-channel ADC device
      tests/qtest: adc128d818: add test suite
      hw/arm: anacapa: add ADC128D818 devices
      test/functional: anacapa: test ADC128D818

 hw/arm/Kconfig                              |   1 +
 hw/arm/aspeed_ast2600_anacapa.c             |  19 +-
 hw/sensor/Kconfig                           |   4 +
 hw/sensor/adc128d818.c                      | 703 +++++++++++++++++++++++
 hw/sensor/meson.build                       |   1 +
 hw/sensor/trace-events                      |   8 +
 include/hw/sensor/adc128d818.h              |  12 +
 tests/functional/arm/test_aspeed_anacapa.py |  92 ++-
 tests/qtest/adc128d818-test.c               | 855 ++++++++++++++++++++++++++++
 tests/qtest/meson.build                     |   1 +
 10 files changed, 1688 insertions(+), 8 deletions(-)
---
base-commit: 193963218accbcf65f28ab1efa773ac6d1cc634c
change-id: 20260612-i2c-adc128d818-anacapa-13c63e97fbd0

Best regards,
--  
Emmanuel Blot <eblot@meta.com>


