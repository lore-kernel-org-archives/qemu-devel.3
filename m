Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F283ACA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 03:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDZFs-0003hF-5Z; Sun, 04 Oct 2026 23:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDZFp-0003gc-V5; Sun, 04 Oct 2026 23:20:41 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDZFn-0000RH-S3; Sun, 04 Oct 2026 23:20:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyskR3HbVBrdMnn1l17IPHZVmzsgjffEE6AcGwzMI47GljjDFk1fCAzn6vJUWX4w2f8iQBXu6MhumImi+vD877I2t4SwYBwxV3ApMe5aDwjtAX5uH6SwF4pSQWzu1m85HuLviPKBSMNGczvHsRzHrOdUunvQZOpOSObyQrN/gWovJyGYU5dmveiflBN3U+jNdoFmCsv08tSLN0wQhoRozmkoFPeZATi8qSCkyMyVjU5iHisFBjP8nsmTRLhErhHopWuexVSmg1DbZurlU9H80phniKTeyPGKVrc0R6t955ol2pFCPAEdWfTITVkNcisK9Xx31hEqNP9kbmr4quWlLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KKFaPwRvBUFh5xcnwhdrFrAsEOD7U4KDrzyCxNpUEY=;
 b=rD6bmdO8R5AiXluu1K4qagam6U4Q4m2hNXld1PXmOnlygFwJL1FIr8BWyqQNnUcpxOhicxEwFvhusNmhGSRqxK5vZEImAQL226VwZuv/S7Civx1DSwYZVK5a/doZQcQURdwRVsZ5THaxnQ4PhUC0rdit3+GbftH1oEUcIjixr3azcykrUQQuVitzRa6q+nIcgKJfBc2ftQWVJi3cee2fajvNbUcPfYe/Lj6CYuCi2fgj/S9PE8V7Utf3wEcTh4fn2GsEr81jlXsz97htYoaP1u9a0XHXodrcpcQAy4cgB3p1WuND9auHd2rOCSDZy8ZU8zeelw38nc91qmwldpZOsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KKFaPwRvBUFh5xcnwhdrFrAsEOD7U4KDrzyCxNpUEY=;
 b=QH/F36+8kWF2CTq551DMQI3Cyxn3STlEVjGNWQoOL4D17anCpaKokyanun7lXEM5Q8weaknT9bB/iw5qpng2fEeh+t864dgeKzMo7heiT53V3FRkWh/FVaRCfi0jHM8lHcsJxf8wMGO/6TEVLdQuX8OK3GvfrHSuh/QXvQK3WJVKsW3GV7ngJ9kwlOIJjX2LSzcj3z84BkmohX/nnradMkduwfZvIpk14S3qxRFAvDyZLa6qJzKEYatSax7UXOvuZTgDIwFyn86H8MjRNukXP3U+xuwbMRO08Z9Y2Y5wNsRFp+QTtkEnKd0352E7U5I749lddRr0LKpkq98tacOQJQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYUPR06MB5945.apcprd06.prod.outlook.com (2603:1096:400:35d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 03:20:29 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 03:20:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane
 Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 4/8] hw/usb/redirect-server: Announce the exported device
Thread-Topic: [PATCH v2 4/8] hw/usb/redirect-server: Announce the exported
 device
Thread-Index: AQHdVHh4Oph8AUs4jEqkyS+vBeY97A==
Date: Mon, 5 Oct 2026 03:20:28 +0000
Message-ID: <20261005032022.3980903-5-jamin_lin@aspeedtech.com>
References: <20261005032022.3980903-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261005032022.3980903-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYUPR06MB5945:EE_
x-ms-office365-filtering-correlation-id: b9be10a7-2ba8-44d5-b335-08df228f9b46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|5023799004|6133799003|10067099003|56012099006|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: k6207zW6oVERlw89uPY70FgR/hOgcOB6a3sVGLw2nRgCRJL34mSmdizWXMUQn5/Q66jhIR3qJ/VIGjnB0flFWk71XJ60fRqr8ucJ3rQZ/tSKdvxIUmOR2iHJn+GC+gJA5jYwX3VDHbS6gOh2HYeT1vahMqB/j3ng1edSMNcVEugd2Q9oRTgbOHre52+yrAI3Bb9+m8W0RCozMeksM1aBCP2b9BjzI0xH6Lw4VSG41ZX9iHNhuQg+uDmNj1nA81vz5wcXnHIIbrCIJ/6AB7g8B/uy/3iv47Tu4P+8wQcvwizDrr+cJfz6NKkLSIt9v4o8srvwZ7ocArf0cqLpPmeK1eRC7F1GbjUAaFqATa4+4Mw0YZsjdLxyN86mjh3IPu5kzmJyfeIl8hrCn8EkZnA1VIOnVdxUxRM9DHk1jCK8XF42bM0N34mHy6ptLhL+54+z5yuOrC2XdjAPc9gwPJucyaBqg+p5HK1H8uuMbZZ/2J7/8G4OIlBBXag8QgIVAMEx8SWLIaafR44oUj/WE91x4/KylGHP5np+2RRsW89SQNStGEAvEbLJVO9BVl42RyNhJYUKxWLuRUAYcHd1xzqFp/BsTvCdptZ2XgV9C5vJMOdFE+r/WoQ6cOrxzfWi0TJBgPW3YbGe1xdspl3uFA0dvUDQPJpgojZAhkg6wrtO4X0KNssvW18LL557cdFt9yZk5XunNph23Pl1p1Hwidt+n840ZjGySSz/7q9tI8t3IYA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(5023799004)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6A9cVSW9ygpRhYW4+dY5MpNiph+B/sN9Hih4tBazB8TUKsrYqQvQLAfRLhqO?=
 =?us-ascii?Q?eeLbCW2/pUasMb6IWaerH0KYxwU4cM8cRsXPe5kEUMXruRiEaG10iWllvsS6?=
 =?us-ascii?Q?mPdne0UJUIR5jg58ZCfnbrCoJhZf/+i0mf5pi8FT84jiaIldoY0nJryjhUX7?=
 =?us-ascii?Q?pwV88vF7aJK0lL88rQpyn5ghhV+hjBfuqf2/Vudwk2PTBPvq/9UX36CR7A2q?=
 =?us-ascii?Q?7DavCRygCZ0s19/gFuUvUik1Hcb2zc1tWI0YS5fzhN+gL3lrR1eynntfbk4c?=
 =?us-ascii?Q?XuZMLgytKS/jc4vcJHyh12em+hWKz++jzq1JrsQh81DUpnpnQbN6TS1JKrkr?=
 =?us-ascii?Q?GSuNYQ+HhfIF/1C/7RBKl42yWdfmUPrmIpReX6/RPL6hbCy5Oq7k0kKtxnZi?=
 =?us-ascii?Q?suh0LPP+Tx9izg8+rflpp0lAmsZS039EGUs25Qtgi7fgOumAPss5CzyBL2SJ?=
 =?us-ascii?Q?jlJ7Zq+/U37DI3KdjZ/kgE8eS4ktKKt2123o2mGVQh3kw01RNPuNc4ZWcj1x?=
 =?us-ascii?Q?ek/neclvOwPiX1ezB+ZWgVQ0bWYEwLRckQEXxExrwbGETQYhTtGX5FuDs3YR?=
 =?us-ascii?Q?NR2UfGWBxvw9YtbZ8rrX98uwx18Gxkx6S4dhOMvz14poJciQhlq+8l2SNAIv?=
 =?us-ascii?Q?Y0aG7FAHYQ0r+Zeiiu8nKnFvZ1bAWIAQZU7rg9R90Jcu/80jfQ0YwQZkll8B?=
 =?us-ascii?Q?HQ/KJUsxHcA4S27aRm3Z/oaG7NqP1Qi0dPR/P2vRbEd5rfTwUqTPqHMkEBgI?=
 =?us-ascii?Q?S18R+J8Ay/27I0UKX31+HS8dushnzBJ2HTncOURKkTyvv2rMoGy+zgBMbW5P?=
 =?us-ascii?Q?7khKa+kSXTbFiq+lxDMp0RkVlLCSbunAZiK3V3gGm537S0jsbAsBh2WO2Tse?=
 =?us-ascii?Q?ZEs6M3msQXQ5KxOb5mdBBhZfA1IpMRl6cAcgFnDq2t6glzYcTsPlJHPX4i9X?=
 =?us-ascii?Q?4EvkdQRgvosTprlr2iP9Ns4E+aacDpPfV8Mg+nnL91YJIPBppC03vWvrvges?=
 =?us-ascii?Q?n4dRJ9ko3pqX4/ovCW2pPzqg0ojUuaWkral8s9NEnJgPbhnZ9gmghG6bPEhn?=
 =?us-ascii?Q?BDbp42cheJN7vv9ras4Jjn2+hyYCxba5orZL0MZZkPMIJSQlHHC5ZV24jwa3?=
 =?us-ascii?Q?ysXkaYayufllfXVMQhIL6Kn1SQgXW9oBx2MISidhSeuXWPYZnfeB36Us+p1X?=
 =?us-ascii?Q?P1iDi4PT3nJe0WzWQcx84aeFnd0YNfgN05pOXhZIIfgb4ASXonBqQiu+2OUM?=
 =?us-ascii?Q?/k3lHVGm7LFFR0Otqukyb+7iCeOBZkz1tzOoa5C77m6+AQppSZUPfJ4xc2tf?=
 =?us-ascii?Q?V+BAUbEDX2rI1NL/Yh6+wjQKP7sZgQHDMAss2vSH1WkyD9AiWA9UbvsSh/PH?=
 =?us-ascii?Q?iPOMMxynprC+7Yoqmy2YL3cUBcuRw+tveE06Ynv9aAFHyFs0Xazp0IdSjc/v?=
 =?us-ascii?Q?HASuwvF7L7xrRJ1soXjaD4N0EDqyRlnPH4gOTRkWV9pImjdtdIj4kg5BCXZE?=
 =?us-ascii?Q?CM3w2xkHMpWu2RupIMWj7oUCWIaWU9UZAUzbKgBVGkCoZZcWhMf26G4TFv7y?=
 =?us-ascii?Q?Dsvhk5bYSMZnbmG7OTctoVIwCwRo1SX0A6zvv3lGg7vxpVunSpw2N0+wE7ik?=
 =?us-ascii?Q?L7VWUEBXGB7A3jZKRRdcK7NADQQanlOw1QG32psfwA75FsGjf/YJvS1FjS/q?=
 =?us-ascii?Q?oWAz8ovbLzvjf37LjWwhsnGkGYnd4tJa8R+q57WXHz82fEhlGZdHsjGnHuRn?=
 =?us-ascii?Q?jnSRkFw/fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SBTR9Vce52t6Kl7CvSLSmhRNJiXn7WBd+XX2/LKSepAnKo5HVZk6U8FXKFIealOlAh2z+UHQIsLGSMRJKsFD0xNcPMTCL8zUs/ETnf8wnWP3y6c6DW5M7/XukrXCARLUO8B0wl/ec+wVHFJOE2UCDbyug+rd0rdR0AizXbtuIDH1lfiruF3DxljOXWVEZDHcyxjC+8A3+YeCkHPG0kNH8l6BHPcvznnLNBtyavrys1MRCTMbXdqAqvKm5jQs9OmBICGsMeiM+1LNdLPWVidfA/b14d6zq8xMLXMcvOVl3u1MtzNCHVLo22hyNnhvWFKVxm6v6ij14MhpiiDt/cI+BA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9be10a7-2ba8-44d5-b335-08df228f9b46
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 03:20:29.0571 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p3yU5gLMvFg6Xd2A0o0kU9yLeW4y2WJMCcrc8ADYn12qvC9kQ/y3fKoCProQcWvmwVbQI0Yi1250UkKH7dZrr9YsCKDPBWFVJvB9xR7XeQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5945
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

Send device_connect when a device is attached and the host has greeted=0A=
us, device_disconnect when it goes away, and handle the bus reset the=0A=
host sends before enumerating.=0A=
=0A=
Wait a short time before sending device_connect. Firmware often toggles=0A=
the USB pull-up a few times while it starts its controller. If the host=0A=
starts to enumerate while the device is off, we cannot answer its first=0A=
request, and it only retries after a control timeout of several seconds.=0A=
=0A=
device_connect carries no identity. The peer asks the device itself with=0A=
GET_DESCRIPTOR as soon as it enumerates, so anything we put there would=0A=
be made up. The speed is real: it comes from the device on our port.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/usb/redirect-server.h |   2 +=0A=
 hw/usb/redirect-server.c         | 166 ++++++++++++++++++++++++++++++-=0A=
 hw/usb/trace-events              |   7 ++=0A=
 3 files changed, 174 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/hw/usb/redirect-server.h b/include/hw/usb/redirect-ser=
ver.h=0A=
index 2af881bda9..a3d5084424 100644=0A=
--- a/include/hw/usb/redirect-server.h=0A=
+++ b/include/hw/usb/redirect-server.h=0A=
@@ -31,12 +31,14 @@ struct USBRedirServer {=0A=
 =0A=
     /* usbredir over the chardev */=0A=
     struct usbredirparser *parser;=0A=
+    QEMUTimer *announce_timer;=0A=
     QEMUBH *chardev_close_bh;=0A=
     const uint8_t *read_buf;=0A=
     int read_buf_size;=0A=
     bool in_write;=0A=
     guint watch;=0A=
     bool host_connected;=0A=
+    bool device_announced;=0A=
 };=0A=
 =0A=
 #endif /* HW_USB_REDIRECT_SERVER_H */=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index c36b5c16c4..824cd274b8 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -56,6 +56,8 @@=0A=
 #include "qemu/main-loop.h"=0A=
 #include "qemu/module.h"=0A=
 #include "migration/vmstate.h"=0A=
+#include "qemu/timer.h"=0A=
+#include "qemu/cutils.h"=0A=
 #include "hw/usb/redirect-server.h"=0A=
 #include "hw/core/qdev-properties.h"=0A=
 #include "hw/core/qdev-properties-system.h"=0A=
@@ -63,10 +65,115 @@=0A=
 =0A=
 #define USBREDIR_SERVER_VERSION "qemu " TYPE_USB_REDIR_SERVER " " QEMU_VER=
SION=0A=
 =0A=
+/* Wait this long after attach before we announce the device. */=0A=
+#define USBREDIR_SERVER_ANNOUNCE_DEBOUNCE_MS 10=0A=
+=0A=
+/*=0A=
+ * The device is whatever USBDevice the user plugged into our port with=0A=
+ * "-device <device>,bus=3D<id>.0". NULL until then.=0A=
+ */=0A=
+static USBDevice *usbredir_server_device(USBRedirServer *s)=0A=
+{=0A=
+    return s->port.dev;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Device announcement=0A=
+ */=0A=
+=0A=
+static uint8_t usbredir_server_speed(USBDevice *device)=0A=
+{=0A=
+    switch (device->speed) {=0A=
+    case USB_SPEED_LOW:=0A=
+        return usb_redir_speed_low;=0A=
+    case USB_SPEED_FULL:=0A=
+        return usb_redir_speed_full;=0A=
+    default:=0A=
+        return usb_redir_speed_high;=0A=
+    }=0A=
+}=0A=
+=0A=
+static void usbredir_server_announce_device(USBRedirServer *s)=0A=
+{=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    struct usb_redir_interface_info_header iface_info =3D {=0A=
+        .interface_count =3D 0,=0A=
+    };=0A=
+    struct usb_redir_device_connect_header conn =3D {=0A=
+        .speed =3D usbredir_server_speed(device),=0A=
+    };=0A=
+=0A=
+    if (s->device_announced) {=0A=
+        return;=0A=
+    }=0A=
+    s->device_announced =3D true;=0A=
+=0A=
+    /* Put the device in DEFAULT state. The host may not reset the bus. */=
=0A=
+    device->addr =3D 0;=0A=
+    device->state =3D USB_STATE_DEFAULT;=0A=
+=0A=
+    /* Send this before device_connect. The peer needs it to accept us. */=
=0A=
+    usbredirparser_send_interface_info(s->parser, &iface_info);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+=0A=
+    trace_usbredir_server_announce(conn.speed);=0A=
+    usbredirparser_send_device_connect(s->parser, &conn);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
 /*=0A=
  * USB port ops=0A=
  */=0A=
 =0A=
+static void usbredir_server_schedule_announce(USBRedirServer *s)=0A=
+{=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+=0A=
+    if (!s->host_connected || s->device_announced || !device ||=0A=
+        !device->attached) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    timer_mod(s->announce_timer,=0A=
+              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +=0A=
+              USBREDIR_SERVER_ANNOUNCE_DEBOUNCE_MS);=0A=
+}=0A=
+=0A=
+static void usbredir_server_do_announce(void *opaque)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+=0A=
+    /* Only announce if the device is still attached and the host is here.=
 */=0A=
+    if (s->host_connected && s->parser && device && device->attached) {=0A=
+        usbredir_server_announce_device(s);=0A=
+    }=0A=
+}=0A=
+=0A=
+static void usbredir_server_port_attach(USBPort *port)=0A=
+{=0A=
+    USBRedirServer *s =3D port->opaque;=0A=
+=0A=
+    trace_usbredir_server_attach();=0A=
+    usbredir_server_schedule_announce(s);=0A=
+}=0A=
+=0A=
+static void usbredir_server_port_detach(USBPort *port)=0A=
+{=0A=
+    USBRedirServer *s =3D port->opaque;=0A=
+=0A=
+    trace_usbredir_server_detach(s->device_announced);=0A=
+=0A=
+    timer_del(s->announce_timer);=0A=
+=0A=
+    if (s->host_connected && s->parser && s->device_announced) {=0A=
+        trace_usbredir_server_disconnect();=0A=
+        usbredirparser_send_device_disconnect(s->parser);=0A=
+        usbredirparser_do_write(s->parser);=0A=
+    }=0A=
+    s->device_announced =3D false;=0A=
+}=0A=
+=0A=
 static void usbredir_server_port_child_detach(USBPort *port, USBDevice *ch=
ild)=0A=
 {=0A=
     /* We only export the device on our own port. Nothing to do. */=0A=
@@ -78,6 +185,8 @@ static void usbredir_server_port_wakeup(USBPort *port)=
=0A=
 }=0A=
 =0A=
 static USBPortOps usbredir_server_port_ops =3D {=0A=
+    .attach =3D usbredir_server_port_attach,=0A=
+    .detach =3D usbredir_server_port_detach,=0A=
     .child_detach =3D usbredir_server_port_child_detach,=0A=
     .wakeup =3D usbredir_server_port_wakeup,=0A=
 };=0A=
@@ -181,13 +290,53 @@ static int usbredir_server_write(void *priv, uint8_t =
*data, int count)=0A=
     return ret;=0A=
 }=0A=
 =0A=
-/* The remote host greets us once the socket is up. */=0A=
+/*=0A=
+ * usbredirparser message callbacks=0A=
+ */=0A=
+=0A=
 static void usbredir_server_hello(void *priv,=0A=
                                   struct usb_redir_hello_header *hello)=0A=
 {=0A=
     USBRedirServer *s =3D priv;=0A=
+    char version[sizeof(hello->version) + 1];=0A=
+=0A=
+    pstrcpy(version, sizeof(version), hello->version);=0A=
+    trace_usbredir_server_hello(version);=0A=
 =0A=
     s->host_connected =3D true;=0A=
+    usbredir_server_schedule_announce(s);=0A=
+}=0A=
+=0A=
+static void usbredir_server_reset(void *priv)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+=0A=
+    trace_usbredir_server_bus_reset(device && device->attached);=0A=
+    usb_device_reset(device);=0A=
+}=0A=
+=0A=
+static void usbredir_server_filter_reject(void *priv)=0A=
+{=0A=
+    trace_usbredir_server_filter_reject();=0A=
+}=0A=
+=0A=
+static void usbredir_server_filter_filter(void *priv,=0A=
+    struct usbredirfilter_rule *rules, int rules_count)=0A=
+{=0A=
+    /* We accept any host. The callback owns the rules, so free them. */=
=0A=
+    free(rules);=0A=
+}=0A=
+=0A=
+static void usbredir_server_device_disconnect_ack(void *priv)=0A=
+{=0A=
+    /* The host saw our device_disconnect. Nothing to do. */=0A=
+}=0A=
+=0A=
+static void usbredir_server_interface_info(void *priv,=0A=
+    struct usb_redir_interface_info_header *hdr)=0A=
+{=0A=
+    /* The host should not send this to a device. Nothing to do. */=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -211,6 +360,14 @@ static void usbredir_server_create_parser(USBRedirServ=
er *s)=0A=
 =0A=
     /* Callbacks for messages the remote host sends to us */=0A=
     s->parser->hello_func =3D usbredir_server_hello;=0A=
+    s->parser->reset_func =3D usbredir_server_reset;=0A=
+=0A=
+    /* The parser calls these directly, so they must not be NULL. */=0A=
+    s->parser->filter_reject_func =3D usbredir_server_filter_reject;=0A=
+    s->parser->filter_filter_func =3D usbredir_server_filter_filter;=0A=
+    s->parser->device_disconnect_ack_func =3D=0A=
+        usbredir_server_device_disconnect_ack;=0A=
+    s->parser->interface_info_func =3D usbredir_server_interface_info;=0A=
 =0A=
     /* Capabilities: 64-bit IDs, connect_device_version, ep_info sizes */=
=0A=
     usbredirparser_caps_set_cap(caps, usb_redir_cap_connect_device_version=
);=0A=
@@ -238,7 +395,10 @@ static void usbredir_server_create_parser(USBRedirServ=
er *s)=0A=
 static void usbredir_server_destroy_parser(USBRedirServer *s)=0A=
 {=0A=
     s->host_connected =3D false;=0A=
+    s->device_announced =3D false;=0A=
 =0A=
+    /* The announce timer may still be pending. */=0A=
+    timer_del(s->announce_timer);=0A=
     g_clear_handle_id(&s->watch, g_source_remove);=0A=
 =0A=
     if (s->parser) {=0A=
@@ -336,6 +496,8 @@ static void usbredir_server_realize(DeviceState *dev, E=
rror **errp)=0A=
                       USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |=0A=
                       USB_SPEED_MASK_HIGH);=0A=
 =0A=
+    s->announce_timer =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,=0A=
+                                     usbredir_server_do_announce, s);=0A=
     s->chardev_close_bh =3D qemu_bh_new_guarded(usbredir_server_chardev_cl=
ose_bh,=0A=
                                               s, &dev->mem_reentrancy_guar=
d);=0A=
 =0A=
@@ -353,6 +515,8 @@ static void usbredir_server_unrealize(DeviceState *dev)=
=0A=
     qemu_chr_fe_deinit(&s->cs, true);=0A=
     usbredir_server_destroy_parser(s);=0A=
 =0A=
+    timer_free(s->announce_timer);=0A=
+=0A=
     if (s->chardev_close_bh) {=0A=
         qemu_bh_delete(s->chardev_close_bh);=0A=
         s->chardev_close_bh =3D NULL;=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index d141661673..2cc6a244b9 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -399,3 +399,10 @@ usbredir_server_chardev_open(void) "chardev opened"=0A=
 usbredir_server_chardev_close(void) "chardev closed"=0A=
 usbredir_server_write_recursion(void) "recursive write, leaving it queued"=
=0A=
 usbredir_server_log(const char *msg) "%s"=0A=
+usbredir_server_hello(const char *version) "peer is %s"=0A=
+usbredir_server_attach(void) "device attached"=0A=
+usbredir_server_detach(bool announced) "device detached, was announced %d"=
=0A=
+usbredir_server_announce(uint8_t speed) "device_connect speed %u"=0A=
+usbredir_server_disconnect(void) "device_disconnect sent"=0A=
+usbredir_server_bus_reset(bool attached) "bus reset, attached %d"=0A=
+usbredir_server_filter_reject(void) "host rejected our device"=0A=
-- =0A=
2.43.0=0A=

