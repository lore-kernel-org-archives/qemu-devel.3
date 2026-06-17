Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2A9CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZnXa-00079F-6d; Wed, 17 Jun 2026 06:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4628a4021f=eblot@meta.com>)
 id 1wZnUu-0004Hh-23; Wed, 17 Jun 2026 06:27:54 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4628a4021f=eblot@meta.com>)
 id 1wZnUG-000824-9e; Wed, 17 Jun 2026 06:27:51 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H920He3475939; Wed, 17 Jun 2026 03:26:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=s2048-2025-q2; bh=R9xjJjJhipe6E31H6B
 EFP/vi/faWFsfX5MGgKBw9Jyk=; b=BSGRNJ3L6RHZ/KOjl6gnwS5OXe+/Cuh0aR
 xpkc+qG3/ZGqnv5owzozEwcOyQtpzdJqXSQNRtGoiUASXV0fYPfFro+sFnGWQJq7
 sJ3Uisixdx0l/DmSXFXr8D7vb5LpzhLosNuDPrxudUCFhKmCRtj7+EK9VhBj2NjN
 k1f8VX6m8bVXTIdD0xDIrakSsFdXG6PDFLtIaaSJ4Meedvma3Hd8E9WzRqfJGWwb
 CXBqTFRAqtebdE+jbCcLCIv8EeO5JU/7/ccHCE6nWXlXcy0wGTIjAQ1GlT5nzxoI
 HoG/9QJCCGvki+xycr/jZkqwmh0QspMRkflCOw1aFtmAdX9AyoIA==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4euegxbeqf-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 17 Jun 2026 03:26:28 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::30) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 17 Jun
 2026 10:26:26 +0000
From: Emmanuel Blot <eblot@meta.com>
Subject: [PATCH v2 0/4] hw/sensor: Add new device emulation for TI ADC128D818
Date: Wed, 17 Jun 2026 12:25:59 +0200
Message-ID: <20260617-i2c-adc128d818-anacapa-v2-0-fd38764f0465@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBBGr0K6dkynkAquvIdhUaaDjAk/abHRE
 O4u4AFcvuR971tU5CAc1TVbVOAkUcZhA3PKFHVueDCI31gZbay2aEAMgfOEpvQlluAGR25ygDn
 ZnKtL23ittvEUuJX3Eb7XP46v5sk077Xd6CTOY/gczwl37+9JQtBQcWELTR5t0dx6nt2Zxl7V6
 7p+AR23cNvNAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781691985; l=2210;
 i=eblot@meta.com; s=20260602; h=from:subject:message-id;
 bh=wMdbefKTRHYXgo0W7vVm6hO4iECas/to3amMtbgNOJE=;
 b=T4gNYubwPDNhuwGsKuakNOhWKTmeYVDC1HObo8X1CLjPpR+aTQPfIpmOAU7pUIp0unpDKDPIj
 v0ZhLdJCCWGA2TI4LAdWVPPDCzRrbXEOjpO3Qh0l/AEK4qQ6ZseVgqe
X-Developer-Key: i=eblot@meta.com; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
X-Originating-IP: [2620:10d:c0a8:1b::30]
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfX5FnW/38eYNXY
 W2XkL7M8JdLvF9pZO04usLCMKvhtaGi5skXun7wq2j1XRU6f0q81CHE7lgtTasT8zsjYt8mSN/w
 0PUoBLKl44qSS//tEA0bITd8qbUj+RI=
X-Proofpoint-ORIG-GUID: j9f9SvKpIdADaF3zAVTSry0KOLLQk46a
X-Proofpoint-GUID: j9f9SvKpIdADaF3zAVTSry0KOLLQk46a
X-Authority-Analysis: v=2.4 cv=Xay5Co55 c=1 sm=1 tr=0 ts=6a327654 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22 a=sozttTNsAAAA:8
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8
 a=S56xvJB5AAAA:8 a=KKAkSRfTAAAA:8 a=aow-egSQAAAA:8 a=V2NxCb60AAAA:8
 a=pGLkceISAAAA:8 a=7KBfExy5AAAA:8 a=cdpHSlppZBiW_pgzB5YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=MH9Ivq0PDQRhlrFuIVvX:22 a=cvBusfyB2V15izCimMoJ:22 a=gFNbaldVC-z-bsjSTzMo:22
 a=3L6qF29SlnrayQqPM2jZ:22 a=eL7OMsOqQ-6kYQPn45L1:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfXyLBtnZY8DmDK
 xdrHFz9d6V4gMkJ91TmbRjfPkVS5P1egDB1yD0hUzYqOg0MPlEahnnbx5HxJ9aYHC8wbRIMDHTF
 EWj5VjE0GNtDldLf+LLrWJZa8jTjyqo1Cck5uyOCXKff9A/LCZoxxQ1drNvyDnFcBTZYfoL9LTu
 AG3OsB2vwbdTpENPI/vv4fI5OsZsycsP/Im2iQC6H/6Tqi70B4VrgspTXYKUc1V0aZy+fHZg+gW
 ATmrKgPSitzzQCsDiYghMqD0poL4Fergq04UGPlIRfKKZeQLiAWk1HVZoZLXhuvrW8T3xlE1vl6
 gRmhRLQE9w/cni7B5J4A11vOM+K5Pc/p87AfMcM95HmQH/dbbuOaeQTiAmnBkQMfbTj8tdPx4Km
 +NmP7wIZFs6/Y7H5C2Xa4z+chshFHLtenlFxtBG5t3shAZOalYztckfsHsER/7FpGwbNtAcmVVo
 95FVDes5hV8xRFpH+3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
Received-SPF: pass client-ip=67.231.145.42;
 envelope-from=prvs=4628a4021f=eblot@meta.com; helo=mx0a-00082601.pphosted.com
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
Changes in v2:
- Remove clang-format useless comment sections
- Link to v1: https://lore.kernel.org/qemu-devel/20260612-i2c-adc128d818-anacapa-v1-0-9e4640cd164b@meta.com

To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@mailo.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Cédric Le Goater <clg@kaod.org>
Cc: Steven Lee <steven_lee@aspeedtech.com>
Cc: Troy Lee <leetroy@gmail.com>
Cc: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: Kane Chen <kane_chen@aspeedtech.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Joel Stanley <joel@jms.id.au>
Cc: qemu-arm@nongnu.org

---
Emmanuel Blot (4):
      hw/sensor: adc128d818: add 12-bit 8-channel ADC device
      tests/qtest: adc128d818: add test suite
      hw/arm: anacapa: add ADC128D818 devices
      test/functional: anacapa: test ADC128D818

 hw/arm/Kconfig                              |   1 +
 hw/arm/aspeed_ast2600_anacapa.c             |  16 +-
 hw/sensor/Kconfig                           |   4 +
 hw/sensor/adc128d818.c                      | 695 +++++++++++++++++++++++
 hw/sensor/meson.build                       |   1 +
 hw/sensor/trace-events                      |   8 +
 include/hw/sensor/adc128d818.h              |  12 +
 tests/functional/arm/test_aspeed_anacapa.py |  92 ++-
 tests/qtest/adc128d818-test.c               | 849 ++++++++++++++++++++++++++++
 tests/qtest/meson.build                     |   1 +
 10 files changed, 1670 insertions(+), 9 deletions(-)
---
base-commit: 193963218accbcf65f28ab1efa773ac6d1cc634c
change-id: 20260612-i2c-adc128d818-anacapa-13c63e97fbd0

Best regards,
--  
Emmanuel Blot <eblot@meta.com>


