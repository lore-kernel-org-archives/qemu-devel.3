Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FA9CA5FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 06:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDcRJ-0006cT-Fa; Mon, 05 Oct 2026 02:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDcRG-0006av-VR; Mon, 05 Oct 2026 02:44:42 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDcRE-00005B-UJ; Mon, 05 Oct 2026 02:44:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5XHEQwAuWJrQBSYT9wL58EQGBE0ubG3lpZ6Ifw8FrH2IPB7Hh5gpDuDv4FcPpsLidPREb0ngxQKeYYniu37eTEj81g+IihE7TEBRczxphuSHjLmBXnOPZqGNtY4/C0GMLxadwx+eAoeCCReG4TszLMRaza+sPKnQhcuBkQIsmAWg5jPIJ6otHPvfAG/lFQG/UJwCvFYToBZgVkUpz/dwLyH25ZHKpqvi10WADJeQurthblzyLvgjkwgTeDZG9BPEyVYYUut3bb40dnR4U+0qPASxWo5fMlZApZu5O8UAnb/ZFC9nEiEuINlitAjeCOxfnsk5T0bMl2/JTev2SLlGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGERVG1KqzjNCxdcNeWz0ag+zo3h6KH3A7fmELyl07Q=;
 b=XfKIymutFh4p2YyvO2YkQbTe8jovDpziqckoNA5YnzcWIn9gYUGyFD3BXmdOSuVv6T1FYDfUeAZQXcVKZeP4f0Aj8FWobNaMDoSB7OCTiq8GHAQTpR8Y/Tz0/2yesJ4MFyWMmsy6CsBBaDWmLtkPMIi+7CHhPSeDvZ5jG40eLcrvoecEEg6SYzSx0ugUHuDkq/+yrkE5epxqw/2BNRffdunehomJ/GiJAuds20ZGSXomE9u1u72TPa185U8clWBck2r2JMVn7+juG/GuFsuhywGvnusIcjvVyn9Ojziu0qTAihT4akQuyivkssO0LxqyzdFvJlEIFdd2xG+QTlNu7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGERVG1KqzjNCxdcNeWz0ag+zo3h6KH3A7fmELyl07Q=;
 b=gecC+Vhn8UIGV2UKJUg62UM+VOWe7hDfLLTxO/Cq7+jpUuzW/GHqqYqD6pXXMm4/Np9Mr1EDt9Hafo57qsrzq+Ugs8P7zfJWLlg4JA8Xd6bFXyMlAXyjceV7Wdx057TjHLkZ1ZOYIuyLlCIigc4YEniBCinhUOd0MsOc7tYhqR2095ru6tdO80unMrhf3CqSJVhwngrw5ZYqq6X/eO2XiJOEZcHUbZO7u0aM9IEgpsPnYmBaY6fT3glhnZ7WqlsZPqllTEa0HXJH64gom/DEgNUdk8HM/TVow3ytb0vhiQ99cpzc6P7xSe7LoVw+sqUbOs7t14rN11LsgyVFjRpAGQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI6PR06MB7166.apcprd06.prod.outlook.com (2603:1096:4:24c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 06:44:29 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 06:44:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 07/11] hw/usb/aspeed-udc: Support single-stage IN transfers
Thread-Topic: [PATCH v2 07/11] hw/usb/aspeed-udc: Support single-stage IN
 transfers
Thread-Index: AQHdVJT3dB4esZYqak6Wz7x0Q2UnLA==
Date: Mon, 5 Oct 2026 06:44:27 +0000
Message-ID: <20261005064418.3060881-8-jamin_lin@aspeedtech.com>
References: <20261005064418.3060881-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261005064418.3060881-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI6PR06MB7166:EE_
x-ms-office365-filtering-correlation-id: de5c1af9-3df5-41b2-68e4-08df22ac1b01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|10067099003|38070700021|260925022911599003|260925021911599003|260925021311599003|56012099006|5023799004;
x-microsoft-antispam-message-info: np3mVCSR0vj6xIcX0bArVjMsE1ScLO90g/fO86Ui/Y3aZ22qsEFpP3KDAlx1Ej3jIXR9FdZkGU7pzRFxlH9mN5oaeyfKk+Rp89FizwxcQcHENagDSQJ4sRcw1/ME/8kxvBnRFLOUEf8OZsaK6ziT1c1SgfOHQq6n9fwICI3adIr7qFwZ4EVhMuCN7KhwGX4CpHqqj2c/RxheUBrUg5y08ffftSQQP5lbh18tu/qo7BFwLck+wBmTmBqqzS1/fyayxy6mnGFq5sWUu6QZt80+OuWiK8yuQZ5Zlm1/NWWu0ERkH4mnuaaNOCaWffAgOzxsHrYYtHPdrhXv6XakmK8YiRD/RHnvJF7GsviWcjoRtsH1/9eaFs52BeQRByF62GlDBD7aKLWdb+McnHCda6X8K2W3XQqiDtmRA3W1uSI+WkMIJoL9nsQKEZL4UvB6VzEJ5qvbR2K8mJpLB7GBpErutTeQ2a1+xLDErgS8sP8YbvTd3fTcfpfOqvMz70lcLjV0SIfHzuxNGk4J21VmSj/7ugBcfgORjwgab+q5YcWoDxQM4x9ExYG1wptYs/GAu8kNkAMElDMGyhn1UsT6Ku78h5l7sz0/s9VO1ekMPbIFlaT+7Vm6nSbzLTshFqhQ8tVpLB/Whb3Ai+AzRooz4sNxlX8KOU7hmrKXlk1yFoMW2xq3k0rLGKgYJpDuw1tRTzunwHzOsKN9AqCOfmc4cK5ECcU3Wkk4oOti0Sp9N1PAQHM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(38070700021)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(5023799004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?P7mwVXJ8x2h4FkM1V5vEUFQUwlgKlENRmYN/+Mg6z/BzZthXoqGLyUvAFa?=
 =?iso-8859-1?Q?XyFedrfYaDZ0vzhS6V48/PmrdsaCR1cWqS/JkamzEsWKfqsnaoD9xQlcDY?=
 =?iso-8859-1?Q?YXrpTupSNSzcNKiM14D7ufoqDSrI7zn0L52bap33S7WcdIWlhtF6muHFVN?=
 =?iso-8859-1?Q?LUl4PwRc0268D7DHHTPMjgzPpRchFvwvDmg9ySP1dcIDobxtpz2P68kfix?=
 =?iso-8859-1?Q?3NrcTEV1GIou8BBqLNGrE/ojrqBfivPcKK1i52hTykK5H71pGru3N0ICBH?=
 =?iso-8859-1?Q?pbWHMNSL+tgndYDisCXXaBO7HJQNjbzq8VQWGiksIxNMIi8SbQJGiyIkeS?=
 =?iso-8859-1?Q?K78W4l0j4O1AmDexCsSXv/5AvABEjtXIIjAlFAnaJUJsSG5b//Mv93zQMl?=
 =?iso-8859-1?Q?7W2MDv9Fk6E4gzYossgHmkpvKRru8XuuhxsskegWKbHsBbdCwW30kH2q/X?=
 =?iso-8859-1?Q?giZFGUmtTpdPFv0G+mH0OQuf+WAOq2mOvtWCf3TBT0TaDUio0wtIdlcf+i?=
 =?iso-8859-1?Q?LqNDzXRhjkzapZjAQguXR5R5K6IM/5xMMLp8E3CBjCi0/B4gE41jazFGSQ?=
 =?iso-8859-1?Q?lxJHXJ3h0lVGSCrtHw4w3okuG/MJ/BWYpIXO7LoGgQk5GuP2pNURdQfS/Z?=
 =?iso-8859-1?Q?AoTM/FDOVU8KA7lQcUFnen9oSMvDmKJgY5rluCUkEodYS1VfAfTGqzefsL?=
 =?iso-8859-1?Q?hgAq7jpmeonBaSsMRfCcH9FUkWOQJ/yI5W1BFzjkbVujZzTlMmtFXS5tXA?=
 =?iso-8859-1?Q?GcRPgRNMdSWB/GBgJDa70cYoWMd0pL/n5JD9DgkVfZd3y3muYMtTSNEzpZ?=
 =?iso-8859-1?Q?jSpYpynk7Hg1uyLSpCQQkTeZSv+Zj6CxG1qCl+AhQM2FkT5s6/GETr1cPl?=
 =?iso-8859-1?Q?qR6TjDFJvLUZPkEp21kX02PLbAYhQ9mQFhXRBvnXYaRl86dPadaLYDbWT/?=
 =?iso-8859-1?Q?RCZp7AVTWZ+lX8q1/gTWONNy8RZ5uQQUVv2JvtGR7Dy+TtfJ0hZAlHr3Mn?=
 =?iso-8859-1?Q?t9JmLEfz9zhAEr2Qeog/sYd+5jj77sybXN+0eEn6BEN2R/W5rYU1MaFLK7?=
 =?iso-8859-1?Q?NABX6+8ehrst+fVCb3dKAiu8RoMBfCVVxdkVUV4acDWakqNtY8xinolTEo?=
 =?iso-8859-1?Q?GTut5GEXELJiMcmRmg5IM2/Xn+/Ljw44Z0sEHTA5dcSaz4nuVxMzJfXC+K?=
 =?iso-8859-1?Q?yUZJRLKtu991oqxdKk35WPd9EEZZfRqkzk0/LcOLlnOcyU3O6JzVX2L9XE?=
 =?iso-8859-1?Q?JvccXsT8f0CvnC/sNPnKCiUjVsPICdNQK+ZTfFzaf6acdEo+vjji4+qhDt?=
 =?iso-8859-1?Q?jZiL4/oZqqefxweI+4FU7M1UwHvK4sfbkbFbfw5vP7yCj5l1ETA3dAwtBF?=
 =?iso-8859-1?Q?vpOhuWdJU3mJZ74FL3YbwecLJxIqk+LO4C7fybgOV20yUgx8eLfTPp8Fgu?=
 =?iso-8859-1?Q?j+H978by6IrpOWrhGc+1yNxoeUsOERFoD6ZxXQlWLBCw1rQdLWB+lFft0x?=
 =?iso-8859-1?Q?hSagBpetyqjF42QuAXg9F2MvSW/lUOhS00RGHQjUemxYpNaXw3Q63j2bhB?=
 =?iso-8859-1?Q?erUcRv33KALZt0/l/PoiWpivq3KQYjB7piEdLygSMgNYTwXzDoQqHMU6NE?=
 =?iso-8859-1?Q?nS9TgyyX//zkFFAcKfaoWpNehpKUPfTOJYy1oXUCxbCGXMsZdOezpGdl+2?=
 =?iso-8859-1?Q?POL0gvpC5pYtRFtUXdvYIchMkqFTFJJDrEDJjl0OUrUv9Ehcb5nWse+iRR?=
 =?iso-8859-1?Q?iPmrbTTCxNplSsJDYG+2Suatp1LdcoJ0BdJxH7YJW8/HvtTJYtpLjTz5rl?=
 =?iso-8859-1?Q?lRBn+jKGcQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NAYycrbT6i6264SufGXiqhIr3jDgUwgOAY6WgR8uJe3RRkwAaPEJ52A9Mj8dl8O1VVt2bbrMw1sLYC+5CoFQoNrCvCDGztkudEfLKxg5xsZf3aXgKb6L7IKFr1XG8CZKpJZFPqgkzkCQOckSmea3OpUAaw0jnuFLQXXskrXtH38zHrKygN83F5UcwjMVh7eoocZyo4O++DAcmT+vONDRgnr9elKkUPNEQzfejjWxCVEYTTquo2uZ09VLx86ePcFxKS9W3n0WGK6vH4Q4QBUoVeEnIdbBUX8pPm++DqKx/29/RRY9EOAp9XhkhJLzAKcf8VbDBo8vyype294KCRtGyw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5c1af9-3df5-41b2-68e4-08df22ac1b01
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 06:44:27.3376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ewjkNlcUrHwRbLhu0wq5JLQmdyY7eAJ7Vi3vpZGmr9qagMj0OAHGmWEc92uHo/X88a1JaqL+1PuNhGiv4mFcPV58Z4ReykXTL9+archheg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7166
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The controller can send an IN endpoint's data from a descriptor ring or=0A=
from a single buffer. Only the descriptor ring was modelled, so an IN=0A=
endpoint in single stage mode sent nothing.=0A=
=0A=
Add the path: one buffer at EP_DMA_BUFF, its length in PKT_SIZE, queued=0A=
by setting the write pointer. How to tell whether anything is queued=0A=
also depends on the mode. A descriptor ring is empty when its two=0A=
pointers are equal. A single stage buffer is queued by the write=0A=
pointer alone.=0A=
=0A=
The buffer can hold more than the host asks for in one request, so keep=0A=
an offset into it. The rest goes out when the host asks again, and the=0A=
guest is told only once all of it has gone.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/usb/aspeed-udc.h |   2 +=0A=
 hw/usb/aspeed-udc.c         | 108 ++++++++++++++++++++++++++++++++++--=0A=
 2 files changed, 106 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/include/hw/usb/aspeed-udc.h b/include/hw/usb/aspeed-udc.h=0A=
index 42916c0bd6..6665609501 100644=0A=
--- a/include/hw/usb/aspeed-udc.h=0A=
+++ b/include/hw/usb/aspeed-udc.h=0A=
@@ -53,6 +53,8 @@ typedef struct AspeedUDCEP {=0A=
     USBPacket *pkt;=0A=
     /* bytes of the current IN descriptor already served */=0A=
     uint32_t desc_off;=0A=
+    /* bytes of the single-stage IN buffer already sent */=0A=
+    uint32_t single_buf_off;=0A=
 } AspeedUDCEP;=0A=
 =0A=
 struct AspeedUDCGadget {=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index c48e2c5f1b..dcced1b8fb 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -566,6 +566,60 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_in_desc(=
AspeedUDCState *s,=0A=
     return done ? ASPEED_UDC_XFER_DONE : ASPEED_UDC_XFER_MORE;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * IN transfer: the guest gadget driver put one buffer in EP_DMA_BUFF, its=
=0A=
+ * length in PKT_SIZE, and kicked it with the write pointer. Copy that=0A=
+ * buffer into the host's IN packet.=0A=
+ *=0A=
+ * The buffer can hold more than the host asked for. Copy what fits and=0A=
+ * remember how far we got in single_buf_off, so the rest goes out when=0A=
+ * the host asks again.=0A=
+ *=0A=
+ * A buffer smaller than the packet makes a short packet, and in USB a=0A=
+ * short packet ends the transfer.=0A=
+ */=0A=
+static AspeedUDCXferResult aspeed_udc_ep_xfer_in_single(AspeedUDCState *s,=
=0A=
+                                                        int ep, USBPacket =
*p)=0A=
+{=0A=
+    QEMUIOVector *pktiov =3D p->combined ? &p->combined->iov : &p->iov;=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    uint32_t buf_len =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, PKT=
_SIZE);=0A=
+    uint32_t left =3D buf_len > e->single_buf_off ?=0A=
+                    buf_len - e->single_buf_off : 0;=0A=
+    uint32_t pkt_space =3D pktiov->size > (uint32_t)p->actual_length ?=0A=
+                         pktiov->size - (uint32_t)p->actual_length : 0;=0A=
+    uint32_t addr =3D e->regs[R_EP_DMA_BUFF];=0A=
+    uint32_t len =3D MIN(left, pkt_space);=0A=
+=0A=
+    if (len && !aspeed_udc_ep_copy_to_pkt(s, ep, addr + e->single_buf_off,=
=0A=
+                                          len, p)) {=0A=
+        return ASPEED_UDC_XFER_ERROR;=0A=
+    }=0A=
+=0A=
+    e->single_buf_off +=3D len;=0A=
+=0A=
+    /*=0A=
+     * The packet is full, but the buffer is not finished. Complete the=0A=
+     * packet. Do not ACK, and leave WPTR set: the guest still owns the=0A=
+     * buffer, and the next IN request sends the rest.=0A=
+     */=0A=
+    if (e->single_buf_off < buf_len) {=0A=
+        return ASPEED_UDC_XFER_DONE;=0A=
+    }=0A=
+=0A=
+    /* All of the buffer went out. Retire it and tell the driver. */=0A=
+    e->single_buf_off =3D 0;=0A=
+    e->regs[R_EP_DMA_STS] =3D FIELD_DP32(e->regs[R_EP_DMA_STS], EP_DMA_STS=
,=0A=
+                                       PKT_SIZE, buf_len);=0A=
+    e->regs[R_EP_DMA_STS] =3D FIELD_DP32(e->regs[R_EP_DMA_STS], EP_DMA_STS=
,=0A=
+                                       WPTR, 0);=0A=
+    e->regs[R_EP_DMA_CTRL] =3D FIELD_DP32(e->regs[R_EP_DMA_CTRL], EP_DMA_C=
TRL,=0A=
+                                        PROC_STS, EP_DMA_CTRL_STS_TX_IDLE)=
;=0A=
+    aspeed_udc_raise_ep_ack(s, ep);=0A=
+=0A=
+    return ASPEED_UDC_XFER_DONE;=0A=
+}=0A=
+=0A=
 /*=0A=
  * OUT transfer: receive data from the host by copying its OUT packet into=
 the=0A=
  * buffer the guest gadget driver set up.=0A=
@@ -667,6 +721,40 @@ static void aspeed_udc_ep_in_kick_desc(AspeedUDCState =
*s, int ep,=0A=
     }=0A=
 }=0A=
 =0A=
+/*=0A=
+ * IN kick: the guest gadget driver wrote EP_DMA_STS to queue one buffer t=
o=0A=
+ * send to the host. If a host IN request is already waiting (parked becau=
se=0A=
+ * there was no data before), send the buffer now and finish the request.=
=0A=
+ */=0A=
+static void aspeed_udc_ep_in_kick_single(AspeedUDCState *s, int ep)=0A=
+{=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    USBPacket *p =3D e->pkt;=0A=
+=0A=
+    /* Do nothing if no host request is waiting, or no buffer was queued. =
*/=0A=
+    if (!p || !FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* A kick serves a newly queued buffer, so start from its beginning. *=
/=0A=
+    e->single_buf_off =3D 0;=0A=
+=0A=
+    switch (aspeed_udc_ep_xfer_in_single(s, ep, p)) {=0A=
+    case ASPEED_UDC_XFER_DONE:=0A=
+        e->pkt =3D NULL;=0A=
+        p->status =3D USB_RET_SUCCESS;=0A=
+        usb_packet_complete(USB_DEVICE(s->usbgadget), p);=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_ERROR:=0A=
+        e->pkt =3D NULL;=0A=
+        p->status =3D USB_RET_IOERROR;=0A=
+        usb_packet_complete(USB_DEVICE(s->usbgadget), p);=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_MORE:=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * OUT kick: the guest gadget driver wrote EP_DMA_STS to give us a buffer =
for=0A=
  * OUT data. If an OUT packet is already waiting (parked because there was=
 no=0A=
@@ -739,6 +827,8 @@ static void aspeed_udc_ep_write(void *opaque, hwaddr of=
fset, uint64_t data,=0A=
         } else {=0A=
             if (FIELD_EX32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL, DESC_OP_EN=
)) {=0A=
                 aspeed_udc_ep_in_kick_desc(s, e->index, old_val);=0A=
+            } else {=0A=
+                aspeed_udc_ep_in_kick_single(s, e->index);=0A=
             }=0A=
         }=0A=
         break;=0A=
@@ -774,6 +864,7 @@ static void aspeed_udc_reset_hold(Object *obj, ResetTyp=
e type)=0A=
         memset(s->ep[i].regs, 0, sizeof(s->ep[i].regs));=0A=
         s->ep[i].pkt =3D NULL;=0A=
         s->ep[i].desc_off =3D 0;=0A=
+        s->ep[i].single_buf_off =3D 0;=0A=
     }=0A=
 =0A=
     /* Device-reset default: root, DMA and EP-pool soft-reset bits set */=
=0A=
@@ -896,22 +987,31 @@ static int aspeed_udc_find_ep(AspeedUDCState *s, int =
ep_nr, bool is_out)=0A=
 static void aspeed_udc_ep_data_in(AspeedUDCState *s, int ep, USBPacket *p)=
=0A=
 {=0A=
     AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    bool is_desc =3D FIELD_EX32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL, DESC_=
OP_EN);=0A=
     uint32_t rptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RPTR);=
=0A=
     uint32_t wptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR);=
=0A=
+    AspeedUDCXferResult res;=0A=
 =0A=
-    if (rptr =3D=3D wptr) {=0A=
+    /*=0A=
+     * In descriptor mode the ring is empty when the pointers meet;=0A=
+     * in single-stage mode one buffer is queued by setting the write poin=
ter.=0A=
+     */=0A=
+    if (is_desc ? (rptr =3D=3D wptr) : (wptr =3D=3D 0)) {=0A=
         /*=0A=
          * No IN data is queued yet. Save the packet and return ASYNC=0A=
          * instead of NAK. A NAK would make the host retry slowly.=0A=
-         * aspeed_udc_ep_in_kick_desc() serves and completes this packet l=
ater,=0A=
-         * once the guest gadget driver queues descriptors.=0A=
+         * The kick from the guest gadget driver serves and completes this=
=0A=
+         * packet later, once it queues something to send.=0A=
          */=0A=
         e->pkt =3D p;=0A=
         p->status =3D USB_RET_ASYNC;=0A=
         return;=0A=
     }=0A=
 =0A=
-    switch (aspeed_udc_ep_xfer_in_desc(s, ep, p)) {=0A=
+    res =3D is_desc ? aspeed_udc_ep_xfer_in_desc(s, ep, p)=0A=
+                  : aspeed_udc_ep_xfer_in_single(s, ep, p);=0A=
+=0A=
+    switch (res) {=0A=
     case ASPEED_UDC_XFER_DONE:=0A=
         p->status =3D USB_RET_SUCCESS;=0A=
         break;=0A=
-- =0A=
2.43.0=0A=

