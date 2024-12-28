Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477ECE7718F
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2024 01:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRLX0-0003cX-0T; Fri, 27 Dec 2024 20:22:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gabriel.barrantes.dev@outlook.com>)
 id 1tRLWq-0003by-CX
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 20:22:10 -0500
Received: from mail-mw2nam04olkn2070.outbound.protection.outlook.com
 ([40.92.46.70] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gabriel.barrantes.dev@outlook.com>)
 id 1tRLWn-00059i-Q9
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 20:22:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdww6NdZkg72OnWD+PQORzWDf6oNOMGOMAHP48EGUWl7YzUx4Qz9OjyLIOSS1JFX1E4xMdP66TBmY4wOIVl1pr5R98yGXm639gMM9buT6+cRFTSJ1sLMJfj5Utq66u07EcHGrNZd4yVNS9mjrq9VvJetzTGVEvZHXwgZuOIaJxNyp+BGTKGD1YSDNYM7RFJbtOYoZj7cBmDQNZLzgw/quhRo6vY00HBoPt4AgZUHkITXpvK+xbRnA+WGJLx5iKYvp8cWfi6WF3TqNS7rq7ufGc45rTaw4vpeohDaOQCtYAfiMuJh8EpSdxw/mFwvBS5Lc01EIhL5GXKyktji8p3T6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/twNBLgq0twKJCEjyKjONh1T793vMySaxDSdRH2+jXA=;
 b=GyhlaCqaX8gTD73QAnZT7LTZkDlm6hMHt9rz26FHnktQdEI9Od6Jn/D5gx1aYamcc3svtprsftKAXNGtfQo8KfV+2E2B7pvp4ro34DeL/F8bDqF5W33aLbfRc1hK0zGvynIOASQZbbOlHzh8dGythzz81Q7ydfgB0522JEHeHDlnTtQ3Q20j3JjHjDLMqKMmAemcSMHMzWc/geJ5kfpu+Wti93Sg1eCJdSs0OOMPs4QIW1LJSSglSJWFqlxQDHjuWWZqQo0LrGeROoXWiRVyroIugbPSvF471w3PRzeJgV4c50mbXofPX06XlN6tntSdaA0WboFelq9f/8wt7Wd6ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/twNBLgq0twKJCEjyKjONh1T793vMySaxDSdRH2+jXA=;
 b=H15m7ykV/RPbaGK1XPuFY27iV47mczP9zlEVutyRg836cAxtAdHhXsAvcjkxwT62ZbSXEEFodBDMtyQoAhb7oKPJZn0X0pCQiKs1o07hWELeIaoRRnPew8FVPrwIS+VnaYF9TkP3zzxPfonYHvkPwxrvRHHLMJkAMgN+8JvSp8CH+NEmHw+aLqyIXqbbzyFIxDkj3ZwpAU57dZRnxprxemopA/WJirK79fiuQe6CCpe0+vACEZeVGCeJ3QK6kwWSKAm6kotKGjc5zSqZth9p8mB4wAyON4kcPso8yd4CMlpZMvLpcOZSvZImmyaQTc4MPKXwJXoko7wMXGlRf6dzFw==
Received: from DM8PR13MB5078.namprd13.prod.outlook.com (2603:10b6:8:21::22) by
 MN2PR13MB3696.namprd13.prod.outlook.com (2603:10b6:208:1e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.17; Sat, 28 Dec
 2024 01:16:57 +0000
Received: from DM8PR13MB5078.namprd13.prod.outlook.com
 ([fe80::9415:f99c:7abe:e230]) by DM8PR13MB5078.namprd13.prod.outlook.com
 ([fe80::9415:f99c:7abe:e230%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 01:16:57 +0000
From: Gabriel Barrantes <gabriel.barrantes.dev@outlook.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>,
 "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>, Gabriel Barrantes
 <gabriel.barrantes.dev@outlook.com>
Subject: [PATCH v2] backends/cryptodev-vhost-user: Fix local_error leaks
Thread-Topic: [PATCH v2] backends/cryptodev-vhost-user: Fix local_error leaks
Thread-Index: AQHbWMHYj+WU9YSsh0KMxa/y8GKTlQ==
Date: Sat, 28 Dec 2024 01:16:57 +0000
Message-ID: <DM8PR13MB50781054A4FDACE6F4FB6469B30F2@DM8PR13MB5078.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5078:EE_|MN2PR13MB3696:EE_
x-ms-office365-filtering-correlation-id: 90c1e67a-213e-4404-36a8-08dd26dd52c7
x-microsoft-antispam: BCL:0;
 ARA:14566002|5062599005|19110799003|8060799006|8062599003|461199028|15080799006|15030799003|440099028|3412199025|102099032|3430499032|10035399004|1710799026;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?hybzcNfafX6tJMCCFILSgjQVuUKJoP3bItM3ZPhALEJBjsFc5keADuNowk?=
 =?iso-8859-1?Q?DkJDHrOOJFmnZdsfeWdppuodq5OjHU/Pyr7CR1SQ82TsVGuuFxhBTs4lnK?=
 =?iso-8859-1?Q?09j2nmcY5XxJUZcGkpZWNtrGG6nK6e/ttS74XQkn+JcyhxYN96NZ5DnQKq?=
 =?iso-8859-1?Q?hDJUswlSjcAqr6EjwArlqs9EiiajNkYfaO+AoVVszw1NNkiB8qj/hW1zcu?=
 =?iso-8859-1?Q?ZmNJoNhzTvXp5DVs+ybfkT1Yd5dUeLJ9cxIcgP6DAXES6Atf9JpC+K7hg/?=
 =?iso-8859-1?Q?QyQOjUfH5Vr6oyYZxCRPIAZPoypDJebeg+4/t4zxdyaqTOONXu7Kt9auxj?=
 =?iso-8859-1?Q?OxtjutPMvgRTE6i/awF6hlYjHQVLr7dkmLiqMBfXfrr19VRqqAyG+WqlLI?=
 =?iso-8859-1?Q?BVloFRDpYWVyopRisMqGz6W34152yrF0th6wqNCdMUyH2dkY0VyWYr5b7N?=
 =?iso-8859-1?Q?mv0iQE+bAzVrrbcwDdvVKQRgkKwvIAADwYkL6KH9g4IXwTMjr5jqjakOLR?=
 =?iso-8859-1?Q?n7XEaCdaPNF/krjWq/ORJ/518J1fYhKLIvi5b4mTAt/GkBUh4xEFNx1Q7p?=
 =?iso-8859-1?Q?hsMbl+LvEraD9yVMZcS+W67DhXmIWBd69Vtf/AYxB3InB7I6P/cSr8+W7M?=
 =?iso-8859-1?Q?aBa6COFSc6WKbxQWlmRfC1bhwG7p/jfRTkWhqhDb7Rok6HOCTBCtuD8xhw?=
 =?iso-8859-1?Q?LLD3MZovakCcexFFqgtpEtfAlTVk8Zux5FSDa7KXf0qOqKpnH5v80ah1U/?=
 =?iso-8859-1?Q?znCeSGOFOS53U+RtAh06eOT636Ckihpj+nw07FRLdBkiQpBUuxhwXseKft?=
 =?iso-8859-1?Q?Y721OMaSthsGZZYqQDU5/+RXzO/0OCHLEZDbswwT/2c9lAg1t2gXt3FUKb?=
 =?iso-8859-1?Q?1OixcM2dfIGeGBnw+YCLGnN6kjFvedQq+Y6zhRjKllu9QWT9jsHZL/fq5i?=
 =?iso-8859-1?Q?9M6zxChmdacqdn+7YrxEACXrh069XAgt9e6stAboUCfmvq8lUjfuxBhyi4?=
 =?iso-8859-1?Q?lIvzDxro7OAGlJvUVWK2w7qqNllkNVyKGoVz9NM0OjYDfXD9PVkzgCe0R+?=
 =?iso-8859-1?Q?uTWYjNkoPJLSANkvXkyOloPv9r7SohNk4/bCA3po1td60pUHDWUxmFuWOd?=
 =?iso-8859-1?Q?25WT8EumWbsp819eNi4oVo4uz3f7gSWIo+fQ8s0oWqr3/R4DOEYjGrIViC?=
 =?iso-8859-1?Q?8+Y6BWazcGxjeTm/aE+Iy0Kk1sVxY478EIdheaFLpuqgY2sT6Ywr1oHcJz?=
 =?iso-8859-1?Q?HLmQcL62XxvUU3FfOvxtAdEZXYbsqcpMps7VfJB2QLKSkumESq+e3ybz1c?=
 =?iso-8859-1?Q?/hAt?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DkcFmkxdgeAjnvj+W/b8NdVUYuMhJAsw9Z77pWhVXw3Dayri/6MsVWeO6F?=
 =?iso-8859-1?Q?550EOnZJ0CTtJUf88aUbF1Apa21OaxMDVs2SlQE9qJDB4dqJxkBSJ9/zFc?=
 =?iso-8859-1?Q?vPIISOBDgz+4YtSWCHMdyi2IMaFiE13nnOeGfadolPJcM57S3TM4QCu1B5?=
 =?iso-8859-1?Q?121C/S61e/S1LaL91yADFKcCpux+ATSl/Y2nOxX16AuIFe9WerxVQ+bBtD?=
 =?iso-8859-1?Q?bXdlzuWQ5sJZviY83m1FfFqFxG1I2f8vFQpRXVZdne2mvdvDUsneEBb08x?=
 =?iso-8859-1?Q?wRxf4RWKMhVdpP1sxwfAJybentBsOANGF6XnJ7K1GaQzW9GApEQN2X4zcl?=
 =?iso-8859-1?Q?85qNFQbEpzs94hgGM1nkf7ARbcmgGzYI/fQhqC+XNiqs5Y+l5KLyJ99vaD?=
 =?iso-8859-1?Q?+p2B3JU0L1LF28/mo2sz6Q7cRi4n72rjqTQHf7zybwjwjC2wkpesNpsyzk?=
 =?iso-8859-1?Q?lTHAEN88P2FakMuHlYWa0B3aNDPgRfKNdQIZXpFmVyUbmecVVec8GeeHDl?=
 =?iso-8859-1?Q?K1157kenIgVEbcTnS4ar4MdmodYe9/ha0w2rcf5EfZZYi1B51JGyomvEDf?=
 =?iso-8859-1?Q?aZUYwli65IyQtQbe1syDiRWRby6VTXWEXhU4JMS3R8mX7Iub6Nco6+COBl?=
 =?iso-8859-1?Q?JBVzNNIlV+CuV8wVp+2hwBfETYKZOBVtbVxYlwS7sxt0GKn4crNwtN8LmX?=
 =?iso-8859-1?Q?CFS6S0yCrP9qgu6Lkfuas7OANzLIF78kPD9OCVJH6FY0W4geOaBuwL8Kbg?=
 =?iso-8859-1?Q?xWEOI0E/bNNQsVtvsxELCatmNlNKLs92KDt6fyCUvUsIWSkwDiutU3zgcH?=
 =?iso-8859-1?Q?TaC7RRHMlsz2QAF671YHPX0wWOMx7SBuKw7dPweWru2pCoo+G2TCbfTeLB?=
 =?iso-8859-1?Q?ZbengEFmGZsLNq5nrxRDN2nIMd26d4AtJZyV9KUYLr2eD/dejze4/KqNYB?=
 =?iso-8859-1?Q?yhP/oM0vB5o7hQcRn+X6sdVioF3+P7IW6rRoa/jhDkKeLld1Lzl+yo3qQC?=
 =?iso-8859-1?Q?6zEv8bo7Z9ha3IRShB3t0rrkJKHuJ10Wxg7zrmd+Y7uCiCJLeZto8Qrs77?=
 =?iso-8859-1?Q?U1ICOne4ZV+SdCvGheY+jjv67QNjUQwkAKVke1wJU+1Ir4+e4An+eM02D9?=
 =?iso-8859-1?Q?8Wq/0UXvGi8ShS7hlQg1tsbPxqD8Xc5TSDb7A9ZN6JYRN0r2D0fm5Zb82m?=
 =?iso-8859-1?Q?O5jSkBCL8lbPf/kPwe0eteuvl5X+LGtorlVesd68TbMQYeW1aOLKGWjxow?=
 =?iso-8859-1?Q?87y9pYOnAjE9oJU9BKTybwKN+eYLOwfuaY3Q1x676MOnhZrMiM4oFqPNMR?=
 =?iso-8859-1?Q?Wg/R?=
Content-Type: multipart/alternative;
 boundary="_000_DM8PR13MB50781054A4FDACE6F4FB6469B30F2DM8PR13MB5078namp_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5078.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c1e67a-213e-4404-36a8-08dd26dd52c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2024 01:16:57.4794 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3696
Received-SPF: pass client-ip=40.92.46.70;
 envelope-from=gabriel.barrantes.dev@outlook.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_DM8PR13MB50781054A4FDACE6F4FB6469B30F2DM8PR13MB5078namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From 532af9eecee4695abb02b40f2c18b711370aa7d2 Mon Sep 17 00:00:00 2001
From: Gabriel Barrantes <gabriel.barrantes.dev@outlook.com>
Date: Fri, 27 Dec 2024 18:02:32 -0600
Subject: [PATCH v2] backends/cryptodev-vhost-user: Fix local_error leaks

Do not propagate error to the upper, directly output the error to
avoid leaks.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2714
Fixes: 2fda101de07 ("virtio-crypto: Support asynchronous mode")

Signed-off-by: Gabriel Barrantes <gabriel.barrantes.dev@outlook.com>
---
Changes in v2:

  *
Add full link to issue.
  *
Add reference to first bad commit.

---
backends/cryptodev-vhost-user.c | 4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-use=
r.
c
index 43efdf9747..f87172b330 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -281,8 +281,8 @@ static int cryptodev_vhost_user_create_session(
        break;

    default:
-        error_setg(&local_error, "Unsupported opcode :%" PRIu32 "",
-                   sess_info->op_code);
+        error_report("Unsupported opcode :%" PRIu32 "",
+                     sess_info->op_code);
        return -VIRTIO_CRYPTO_NOTSUPP;
    }

--
2.34.1


--_000_DM8PR13MB50781054A4FDACE6F4FB6469B30F2DM8PR13MB5078namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
From 532af9eecee4695abb02b40f2c18b711370aa7d2 Mon Sep 17 00:00:00 2001 <br>
From: Gabriel Barrantes &lt;gabriel.barrantes.dev@outlook.com&gt; <br>
Date: Fri, 27 Dec 2024 18:02:32 -0600 <br>
Subject: [PATCH v2] backends/cryptodev-vhost-user: Fix local_error leaks <b=
r>
<br>
Do not propagate error to the upper, directly output the error to <br>
avoid leaks. <br>
<br>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2714 <br>
Fixes: 2fda101de07 (&quot;virtio-crypto: Support asynchronous mode&quot;) <=
br>
<br>
Signed-off-by: Gabriel Barrantes &lt;gabriel.barrantes.dev@outlook.com&gt;<=
br>
---</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Changes in v2:</div>
<ul data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:false,&quot;u=
norderedStyleType&quot;:2}">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); list-s=
tyle-type: &quot;- &quot;;">
<div class=3D"elementToProof">Add&nbsp;full link to issue.</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); l=
ist-style-type: &quot;- &quot;;">
<div class=3D"elementToProof">Add reference to first bad commit.</div>
</li></ul>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
---&nbsp;&nbsp;<br>
backends/cryptodev-vhost-user.c | 4 ++-- <br>
1 file changed, 2 insertions(+), 2 deletions(-) <br>
<br>
diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-use=
r.<br>
c <br>
index 43efdf9747..f87172b330 100644 <br>
--- a/backends/cryptodev-vhost-user.c <br>
+++ b/backends/cryptodev-vhost-user.c <br>
@@ -281,8 +281,8 @@ static int cryptodev_vhost_user_create_session( <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break; <br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;default: <br>
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_setg(&amp;local_error, &q=
uot;Unsupported opcode :%&quot; PRIu32 &quot;&quot;, <br>
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sess_info-&gt;op_code); <br>
+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report(&quot;Unsupported =
opcode :%&quot; PRIu32 &quot;&quot;, <br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p;sess_info-&gt;op_code);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return -VIRTIO_CRYPTO_NOTSU=
PP; <br>
&nbsp;&nbsp;&nbsp;&nbsp;} <br>
&nbsp;<br>
-- &nbsp;<br>
2.34.1<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_DM8PR13MB50781054A4FDACE6F4FB6469B30F2DM8PR13MB5078namp_--

