Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C44CA6004
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 19:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEXTt-0005mM-J1; Wed, 07 Oct 2026 15:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manuele.conti@archimede-energia.com>)
 id 1xEXTr-0005lt-T6; Wed, 07 Oct 2026 15:39:11 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manuele.conti@archimede-energia.com>)
 id 1xEXTq-0007SF-8T; Wed, 07 Oct 2026 15:39:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrIVppOqAS6Xz/D3P12zeql9Z9Z1AobNVvFI+v+4WaMvBDZaf3IMPB7Gz/TWTIav2v63XFWfUjwBq/4vaUSIMJOUrSs53O+ihoDNBcEwRMhXRuQQz+1YO489Dzz0DmqCjDtcX38E+/11UcP+ioXTH9dzqzqYegMiOepmAIIwrGn/+mHtzwVqaXUK/YvxKM0ARUc6WHEXR3z4QMEIDiyUtj8QhuuETltrVsjh7lBK9CYLjT3PJJDrqrDrfcC2dnBeyV2uY6cvyckNKF3YSv+ogIy1cjeZYe/is8Azsg7f9BpPT4rGjfSwbo/9PZ6PjSEzi3xSoQDLHRZwqCg6qgW1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlBgxbFFHG9e0p9QM/3+wlYcg6Rrx/o6FqH44aNP3IU=;
 b=sG67G21OayoMZ4iENyaFVWhld/hPbQAML9z0E8UHnBr3PcD76bEjIzhyZhIQAtb1k0wIuMCBPuq0ppOtOOBK1vpcfSRtBUfA9tWwU0cUR4VM9tMrg2btxUh4OM5718VYmwMf6PHIg8sL7yeJ+65KoNTfA3onXi4nph5hJNBhnsYkFbRdwbOmYKlZ7vLg4WymbTb7/y1Rpa5fsjAhRTq1wHESDKuLsO+M6P4iu2CNhmxzj9QJTs8QOqyXXQqJfxnEPn4CYRO6PLvA+qJgLq5qx+DZ7Rya9uUwJER3rXEZ6+W+taOJ7qQ9WwR7a4Pu/EQzIXEIPmNHcJX6X5QGfcN0Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=archimede-energia.com; dmarc=pass action=none
 header.from=archimede-energia.com; dkim=pass header.d=archimede-energia.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ARCHIMEDENERGIA.onmicrosoft.com;
 s=selector1-ARCHIMEDENERGIA-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlBgxbFFHG9e0p9QM/3+wlYcg6Rrx/o6FqH44aNP3IU=;
 b=h6XdbKiEpoaLAUuI0YydLSNlYgvTg6xeepmGYtbCZIps3GZ0zveuk9utnF8DZk0Ou53bi/7ms/dE7StHLitJeshm7fyZB/GPBkbiVD0vZtoW2Spe3eVF67gPOKY6+27ZSqEGLKrvd7IhVtAIL67R2sL1/qy+sfBOPZ2OFU9n9lo=
Received: from AM7PPF9020C43FB.eurprd02.prod.outlook.com
 (2603:10a6:20f:fff1::816) by DB3PR02MB10402.eurprd02.prod.outlook.com
 (2603:10a6:10:439::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Wed, 7 Oct
 2026 19:39:07 +0000
Received: from AM7PPF9020C43FB.eurprd02.prod.outlook.com
 ([fe80::d6fd:d61:e01f:727c]) by AM7PPF9020C43FB.eurprd02.prod.outlook.com
 ([fe80::d6fd:d61:e01f:727c%3]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 19:39:07 +0000
From: Manuele Conti <manuele.conti@archimede-energia.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "alistair@alistair23.me"
 <alistair@alistair23.me>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Subject: [PATCH v2 2/2] hw/misc/stm32_rcc: Mirror clock ready and switch
 status bits
Thread-Topic: [PATCH v2 2/2] hw/misc/stm32_rcc: Mirror clock ready and switch
 status bits
Thread-Index: AQHdVpOE3GGCzNQDmk6iljvNRH/AeA==
Date: Wed, 7 Oct 2026 19:39:06 +0000
Message-ID: <15D27BC1-1A15-464A-9C9F-4719C2B10DCC@archimede-energia.com>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.700.51.1.1)
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=archimede-energia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PPF9020C43FB:EE_|DB3PR02MB10402:EE_
x-ms-office365-filtering-correlation-id: 8907b3d3-4d71-41fc-58ee-08df24aaa6b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|23010399003|10067099003|260925022911599003|260925021911599003|260925021311599003|56012099006|18002099003|38070700021;
x-microsoft-antispam-message-info: LpPwRP6Ly5E34rDniR9NApT8NWXXkLfAIix5Ia/hZgy1KBITcwYIA/XiQR4KxoBeLjDrUu0os1hlWT360Fh4VjXxK2l6iHHQDwuReQwv7GB19FwKQ20oU16emJh9YEs+o4UwjErurvdpt/rKkiSnpHYOB3tfhEOuAPw817wvsl1Ee9dW5HaP2sTfZA06rTUZ2mi4vWA6DVFH5AlknuvugXRXxuqX+LkCwjjs+KS9g7OCRJYKnIURXtEDva0IgTBO4trcMriqNTFDNg5d5LSfp8GLbgPxr+roJODFAtJM/Xh0EesSxfhL4DVVwreTg/yWmNmt5EKunVbBKVVDID+iqbzEh8kv+jtD/3scxX55IO8rohVCWyUR8Cawi35SwjP2NFLVp5Q7eLC6DHFdZDF+TQWfwRDrCJM/WtLjx3djRLomk8YeRvuOEkVh91SrFVvTX2CAk8LfWFi2FFa0N3bEEXKFhFKvEgV8arT4bQh9u40AzFrhYZhGIfStuTdYqZCUAiqhlMX268SfTCQaybnbupqg8DA08te9/f3Hiv49SxMn9D0MEmYpVWskycHE1icf2ZmCBG+0Ppp9LTOzLawRnkjT19NgKu5hSAfBoefFz7RcYkKYHIP1tEj9jCM3sMWjmYDXa5+CMIplM9X9nk7bUsQb+RhJW6JhcV62uHl7+e6qb6LLG9UcJSp1EquVoeW60mujMgOF8OUHfnzoGQkCNG2ZI7jOsfJQYFy1mdUVslw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PPF9020C43FB.eurprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(23010399003)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NJYcoP43Bv7TW2zuubSi4C7w1Bdk1cxV9ooqLZ9wUBn/HgMS4/FF1W7ezhxB?=
 =?us-ascii?Q?4q28xQBCiSffU5WwCcagjMkTfyUaVa+AWKHtybX+N9iV6viGGrinhSuexF6+?=
 =?us-ascii?Q?0oIiaHI9ztcw09uiTZBtv2217OFQeM49cJK5e+B2jQil4erdqiuUXjP2rSu4?=
 =?us-ascii?Q?Im0GDc7VEunJqS112y5H9reX9AU9GYzCGKHEYpne7fHAYi5tQKM7H0D1Q3Sa?=
 =?us-ascii?Q?isaRMByR/5IXeVsO/Z/8zT9MhM37/rYOxTV/JOjfeVvqkmObskGnQWR3GzDf?=
 =?us-ascii?Q?squiQ9dq9wIgW1b0xj5V+nNm0zxBhTKsoL/XWtg6+7d7KXzKKcbACGs5Z4CR?=
 =?us-ascii?Q?9LcvwoEhRSKKrcC9BCuAGQvwS3BEkGS40atFVXOr2rwI9UTzVrCvyl+aZhKL?=
 =?us-ascii?Q?BSCoWVOPy1FddZ0rKPrsWliyFKSzv0qJh2oq82P+HFSMAKGzgOsdfzPSnS51?=
 =?us-ascii?Q?463Md2iQ05gMPG/YcQmJz7mOlEZVi+7kr4dTdrpB6PWsiDs5g96mkKukwpZP?=
 =?us-ascii?Q?TYlhhRtX2gPOrZ4Lkr1YT5WEOn1dEgxwLFa1fjgt6i3C7jq5LUy1NgRTbZHa?=
 =?us-ascii?Q?dqPW4lX1NQuc9MQAQvmV+UM33nT1wiaEVSEZ8my9X1hrMSlXpE900cTrwIlm?=
 =?us-ascii?Q?tBiOQlPjO7tuXz6Clpen2G+mLGRtWOUJGsUxchTNwHo/hNcRAOxkW3E4LrYj?=
 =?us-ascii?Q?JR0GS+VYU1DCRtTW/jMDoMiTZqlUr/1Ua44+ybNWbFC8uiY2vsQLhuNasxYw?=
 =?us-ascii?Q?7b/LcRrBh4/WE5P8c5arN6fnFaqzKeWn/20Scg8soVZs1CmZmDW1PGRWJqX6?=
 =?us-ascii?Q?W+19oAjFfb4zVu3NPMiA+VIof3RGpe9vHoEUDiItX/mNsG5OOS6nN/Jj+Z5A?=
 =?us-ascii?Q?g72VdQ4u6n1wezGS8lEK2fkepfjclPOindJXDX+OcH81WN0MW20/mH7rxmmw?=
 =?us-ascii?Q?QKFkHQ1bJsK7Voxo4J19Q79REa21xvGid3huka9eRi8Ctf9qbwcqDf+DOG2n?=
 =?us-ascii?Q?ogYK1NvUpWZWFLVJnj/BUYvpUl7MKTh+S1uSS0HriUT2tGYqR4TPloQjlU+U?=
 =?us-ascii?Q?/xdWaANy4SO7aiv8rbRSWyR5Qx53OVLJv9PpYzLOMJwyRVz24H5bVN11BtvN?=
 =?us-ascii?Q?WTB1qkf6DfLJbyv4ALC/LMoA7fksn9k1gZPOuwn3qIrqqN0gE1klvE6IavML?=
 =?us-ascii?Q?/vmlHfH6x4TrdXfR7b74jdmt2FiDd53l2RMSuxwGx47r53zLIBYFh24CqGjU?=
 =?us-ascii?Q?IKCogByOzZaKp1xsv9tJrlJFSnFXP+WlWOx9RdD4KsyeVHhEkcySyyOZmUa8?=
 =?us-ascii?Q?uheJIr420GNpVmCMWZKxssXnD1RMW41SckhD/H3+57Rm4Dy/5ajxvt4jpfJb?=
 =?us-ascii?Q?GACzG+hgRLQ5HlxmfFPonbwr1euI7okL1fjGPCgqemu1qWtU9HGoIFtHSawE?=
 =?us-ascii?Q?IIv5yW+TMFEp4umQ+xZt1QfzQjSvWEWx9ChYagQfiAAtFnFV4KYnq0OsSfu1?=
 =?us-ascii?Q?8aSbfanCgWdEgkGWyHaTUHmXjjVn78NKsyNUg7RiSlHBCRB962aXhXQHDSnt?=
 =?us-ascii?Q?z+c30dHBcDoQSO1EWbiKtOJAonDZmhkPXyCloIWvexddLozf3/2wbf+CkEOE?=
 =?us-ascii?Q?A7N+7DuIwIAaXeA+XMQFP26caZCH4z2W8l6qsB5tEgH5kBRZQ240tkV59bV2?=
 =?us-ascii?Q?MOonErZ5KUhQjswah1IGI9Dja9M9tetC6UCLVHIe77G+m2wSEWWvsdCNL0/a?=
 =?us-ascii?Q?LL/lwk82GJ6o3o64l9KIucTLI8TUZukd1NKakvo9OoBS73HJgaVEwIe15w7J?=
x-ms-exchange-antispam-messagedata-1: KZG+Z4SP7JB6Dckv5ICn7rLedHxK93gSmZE7qn/J0hwTEHOfi7q/d99O
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D894C740EE68C146A696F4832D1CBFD8@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: archimede-energia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF9020C43FB.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8907b3d3-4d71-41fc-58ee-08df24aaa6b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 19:39:06.9159 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1f446eb6-a8f2-46bc-96fd-2665698112e8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c7kZxq4aLNFH8+R/YDxePWY4OHrIyTy8rorFKL3JfxFtVNiJoPJ9gjmd3BvMwqSniK3MoPRgMtDACRAwDWxWEd7V0oQUiiJFIsjxwZl9FrHULwQZaTK4m4qO01YPkeui
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR02MB10402
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=manuele.conti@archimede-energia.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

RM0090 7.3.1/7.3.3: oscillator ready bits follow their
corresponding enable bits, and SWS follows SW. Upstream stored raw
values, so firmware polling for ready or checking SWS never saw the
expected state.

Mirror the enable bits into the ready bits on CR writes and SW into
SWS on CFGR writes. Clock switching is instantaneous in QEMU. No
oscillator startup or PLL lock delay is modelled.

Add qtest coverage for HSION, HSEON, PLLON, PLLI2SON and SW,
including clearing the ready bits again when the oscillators are
disabled.

Signed-off-by: Manuele Conti <manuele.conti@archimede-energia.com>
---
v2:
- Mirror HSION into HSIRDY.
- Mirror PLLI2SON into PLLI2SRDY.
- Extend the qtest to cover both additional clock ready bits.

 hw/misc/stm32_rcc.c              | 19 ++++++++++
 tests/qtest/meson.build          |  2 ++
 tests/qtest/stm32f405-rcc-test.c | 62 ++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)
 create mode 100644 tests/qtest/stm32f405-rcc-test.c

diff --git a/hw/misc/stm32_rcc.c b/hw/misc/stm32_rcc.c
index 5cfb39e560..814c5ea3b0 100644
--- a/hw/misc/stm32_rcc.c
+++ b/hw/misc/stm32_rcc.c
@@ -90,6 +90,25 @@ static void stm32_rcc_write(void *opaque, hwaddr addr,
     }
=20
     switch (addr) {
+    case STM32_RCC_CR:
+        /*
+         * Oscillators become ready immediately in QEMU.
+         * Mirror enable bits into ready bits. See RM0090 7.3.1.
+         */
+        value =3D deposit32(value, 1, 1, extract32(value, 0, 1));
+        value =3D deposit32(value, 17, 1, extract32(value, 16, 1));
+        value =3D deposit32(value, 25, 1, extract32(value, 24, 1));
+        value =3D deposit32(value, 27, 1, extract32(value, 26, 1));
+        s->regs[addr >> 2] =3D value;
+        return;
+    case STM32_RCC_CFGR:
+        /*
+         * System clock switching is instantaneous in QEMU.
+         * Mirror SW[1:0] into SWS[3:2]. See RM0090 7.3.3.
+         */
+        value =3D deposit32(value, 2, 2, extract32(value, 0, 2));
+        s->regs[addr >> 2] =3D value;
+        return;
     case STM32_RCC_AHB1_RSTR ... STM32_RCC_AHB3_RSTR:
     case STM32_RCC_APB1_RSTR ... STM32_RCC_APB2_RSTR:
         prev_value =3D s->regs[addr / 4];
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -238,8 +238,10 @@ qtests_stm32l4x5 =3D \
    'stm32l4x5_usart-test']
=20
 qtests_arm =3D \
+  (config_all_devices.has_key('CONFIG_OLIMEX_STM32_H405') ? \
+   ['stm32f405-rcc-test'] : []) + \
   (config_all_devices.has_key('CONFIG_OLIMEX_STM32_H405') ? \
    ['stm32f405-timer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + =
\
   (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-=
dualtimer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_TIMER') ? ['cmsdk-apb-time=
r-test'] : []) + \
diff --git a/tests/qtest/stm32f405-rcc-test.c b/tests/qtest/stm32f405-rcc-t=
est.c
new file mode 100644
index 0000000000..1a8819b6f5
--- /dev/null
+++ b/tests/qtest/stm32f405-rcc-test.c
@@ -0,0 +1,62 @@
+/*
+ * STM32F405 RCC tests
+ *
+ * Copyright (c) 2026 Manuele Conti <manuele.conti@archimede-energia.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+
+#define RCC_BASE        0x40023800
+#define RCC_CR          (RCC_BASE + 0x00)
+#define RCC_CFGR        (RCC_BASE + 0x08)
+
+#define CR_HSION        (1U << 0)
+#define CR_HSIRDY       (1U << 1)
+#define CR_HSEON        (1U << 16)
+#define CR_HSERDY       (1U << 17)
+#define CR_PLLON        (1U << 24)
+#define CR_PLLRDY       (1U << 25)
+#define CR_PLLI2SON     (1U << 26)
+#define CR_PLLI2SRDY    (1U << 27)
+
+static void test_cr_ready_bits(void)
+{
+    uint32_t on =3D CR_HSION | CR_HSEON | CR_PLLON | CR_PLLI2SON;
+    uint32_t ready =3D CR_HSIRDY | CR_HSERDY | CR_PLLRDY | CR_PLLI2SRDY;
+
+    writel(RCC_CR, on);
+    g_assert_cmphex(readl(RCC_CR), =3D=3D, on | ready);
+
+    writel(RCC_CR, 0);
+    g_assert_cmphex(readl(RCC_CR), =3D=3D, 0);
+}
+
+static void test_cfgr_switch_status(void)
+{
+    unsigned int sw;
+
+    for (sw =3D 0; sw < 4; sw++) {
+        writel(RCC_CFGR, sw);
+        g_assert_cmphex(readl(RCC_CFGR), =3D=3D, sw | (sw << 2));
+    }
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/stm32f405/rcc/cr-ready-bits", test_cr_ready_bits);
+    qtest_add_func("/stm32f405/rcc/cfgr-switch-status",
+                   test_cfgr_switch_status);
+
+    qtest_start("-machine olimex-stm32-h405");
+    ret =3D g_test_run();
+    qtest_end();
+
+    return ret;
+}
--=20
2.54.0 (Apple Git-157)


