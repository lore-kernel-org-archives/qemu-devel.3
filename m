Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40B1E7718B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 01:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPtug-0006ye-HI; Mon, 23 Dec 2024 20:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gabriel.barrantes.dev@outlook.com>)
 id 1tPsDX-0005Fv-84
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 18:52:07 -0500
Received: from mail-dm6nam10olkn2077.outbound.protection.outlook.com
 ([40.92.41.77] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gabriel.barrantes.dev@outlook.com>)
 id 1tPsDV-0000kI-Js
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 18:52:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTN9BefyOejeMughG8uNKEzGPVp7TfQC/JFTBmGyDTbvT2GBR4KVxgZvN2wUvqu9mw72KZuzGManmt/Sb3iuuHnkVAgd2JTF7cxbX9yfyul0/UlFffXSxsXlAYhdEnLrznS3qKfl+sagp0QSGPrhqHF2Y24gjGsgYURbt0kFupMRr74IPHYd1D/pq+1WDRkpFkS7O2feapghzjOd/hkaFKodlsuILuhlYkUmKeEeuFNUWLjdMaN0Jw4fRQCO7Z9qhEfeIObZE78aI14jEGRYLxMmxJJ2OF74cwIV9RAGiK3Dt7fHz8/8Q1Bc3KSkYmYnAAfv+PEJPwUgLItF2DSO9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtqeXWNq7zTpQp4B8ESToRKv/if1o51X0tuM51tz++I=;
 b=SW6VCgAFcBEXnvsVU4iW/hJD7AmKKV1Zw7eUc/NIFuFhhYrSkPY3KFMnxZbYUKsTa/FkpI/GudAu+fn/JpZl+yV4bDiRdfqzZ7P3Tj2Y+1aCfDi5iQKY82f5+fQPEAkMWHUc3anhx99ZS9ys09YynI0kBBFpzFiEkr2vqU5tRWY+zJHkASHIpNNotoRDQwpGcgLcnmyfJ+gwy6cYOa//cUKW/e16iazE25g7HQjZQ68NfTGqhmZ1FuUsPtZYWnUdHlLwoxP/uynuDktVtzsRi9JfZ3VUIJWIPodbl7rZLDJcP9N/1UdrS9c1CaQEy6gj7qC+mQOabCcD99KPVqG6xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtqeXWNq7zTpQp4B8ESToRKv/if1o51X0tuM51tz++I=;
 b=mwD7REkShh89ZPRXylph5v6dJyC0mREjv/m4EtFc4H45PDYwjLrhy3HHzLEV6kElzm/JhIz2D0jH+Lk1EvUQXRbz1wYnzQ7B9B5CJbYbcQlTSiWKFDbRYntHncKEiFwUcD2qBOQFjY2dHXH0RYKC9juGuxH3dZiVH4+oObkkvgHb98J4bATIWub2VAN0IdCyhlwAuaWk15Y3WOopAKtjy4XHIOLe5A7XO6fUdEyR0VL+BVmL1CnJrUjQSh3J0YwqjPpb2uTnkzJKmxn7cAPltBmG1yiRNBwKD4kcpS54teHjEkzlgwicQxJ3I7vJ/XnZJjD1ENQBr0lTEcW1MKFh4A==
Received: from DM8PR13MB5078.namprd13.prod.outlook.com (2603:10b6:8:21::22) by
 DM4PR13MB5834.namprd13.prod.outlook.com (2603:10b6:8:41::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.16; Mon, 23 Dec 2024 23:46:59 +0000
Received: from DM8PR13MB5078.namprd13.prod.outlook.com
 ([fe80::9415:f99c:7abe:e230]) by DM8PR13MB5078.namprd13.prod.outlook.com
 ([fe80::9415:f99c:7abe:e230%5]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 23:46:59 +0000
From: Gabriel Barrantes <gabriel.barrantes.dev@outlook.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>,
 "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>, Gabriel Barrantes
 <gabriel.barrantes.dev@outlook.com>
Subject: [PATCH] backends/cryptodev-vhost-user: Fix local_error leaks
Thread-Topic: [PATCH] backends/cryptodev-vhost-user: Fix local_error leaks
Thread-Index: AQHbVZStpmoWkKHHv0+a+lCeigXtJA==
Date: Mon, 23 Dec 2024 23:46:57 +0000
Message-ID: <DM8PR13MB5078933D25141B3F23ECA782B3022@DM8PR13MB5078.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5078:EE_|DM4PR13MB5834:EE_
x-ms-office365-filtering-correlation-id: 42f52202-04e2-42e7-d80f-08dd23ac16b4
x-microsoft-antispam: BCL:0;
 ARA:14566002|8062599003|8060799006|5062599005|15030799003|461199028|19110799003|15080799006|3430499032|102099032|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?q6OvQQ2YAbaIVJVQw1yXXENW0gO8O98nxbGTPLKDgmPXohzuiiAEa1hocY?=
 =?iso-8859-1?Q?n1HhD2NcUHeL6mwyRNiQooVs/qFJzN9TQarCwnY4S2w/0VYMjwqaO28vPN?=
 =?iso-8859-1?Q?mNZO9aTWiwfdkMSjoDZUdxdn4mOW0N+yIn/Z6ZAYMM3C1SDYGYPl9RoY9B?=
 =?iso-8859-1?Q?IUgEPdfEKQ8+qngMnEdi9fCOqqJQ56LqlBXTrZs4mKJZljVtUp3dAK5L29?=
 =?iso-8859-1?Q?CMO05Eo92hHsAwMB8HXfOObgE8wMlgDFke6G1u0Q8aBj0TfCdH/cXFCqJL?=
 =?iso-8859-1?Q?q87iGISJ9L2VSd0ObouuRzkSjMJRuVtyLIXnNCms1VSSi02rJO+/6s5aIL?=
 =?iso-8859-1?Q?tPnufw30l9PYEIZGpelFotYppVSjNa2kLZso/sPqusTVKwmdoVBej8GR+g?=
 =?iso-8859-1?Q?t8MWByTV92NZvxiCsVVm7DmAViBPhD1jLq+jf2PB0K1OZYpbK99/cmvNZP?=
 =?iso-8859-1?Q?X21tvBx2g848k2kQn1SCHVXLJXWxq4XLEWGFHbHlZtmjrNuBsDTzCIlXzG?=
 =?iso-8859-1?Q?p6vVHEas8SpzLQQD8kaRf0SQn066dM5TYx/NmfulT0BLCuPgGKegmR50XI?=
 =?iso-8859-1?Q?m5QCRYIYIVlkotbmw4kLaRclGXxy0eLciOaTuWBfGqiAGeT0XNCRj+NUaH?=
 =?iso-8859-1?Q?wZQwuyk3Bzv84s6M4P7aSS22ONbd2ttJasgcV+8xjtMHlk0+sAdS8TmwaD?=
 =?iso-8859-1?Q?tpf+2pUPocPjnEuL4rWLeSCfVw/x/oP06RItSZTebYDmihmIy5LzY9ny7l?=
 =?iso-8859-1?Q?LKD6RgTgK6kk3zzyfvFO9ITyV0p0ce4NzTm4HpyrqkSj/E0fUT70GbO5iq?=
 =?iso-8859-1?Q?OtnVgPsoksFS0BaIyXFXYqfOxn+iLSTrXYaJTSfaq9OumTOHAbNy2/Xolp?=
 =?iso-8859-1?Q?MooCtkDbu8AMP2Wfz54gQv2pLNOuLUsA1AbzI8rFquzjSjsapp20Yuha6c?=
 =?iso-8859-1?Q?SNIuz2AdDoqOBIrr3hJdbFvW13sPlrRmaF21Cf8+yUPXC2gFN5rDMQ+TEC?=
 =?iso-8859-1?Q?koT3Ys+44kwITW89Fk1UBBbCU2zQXHCg1QmtisTBcXW+5JSqV+Avz8HLiE?=
 =?iso-8859-1?Q?g3fQSVKRmj9Hj71Ng6yTPmGkZlbXf6/+2XpsAh0OFgs0zriPrazico4sIM?=
 =?iso-8859-1?Q?cq0jA8wxgQ9zTobaCdqpAsMMckDlYx/PYSbI1OwsYQLdSU0erEMCTNs6SS?=
 =?iso-8859-1?Q?Zg8ExLoO5Hxu8g=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BrPrM+iz3wrkZU5UoZzRNGUnwS2Qlr51lWnP3uJ3ZKozhOgRzado4XHmg1?=
 =?iso-8859-1?Q?7ZmEbts4rJCzaM/ZwO9S8G537cCW5K/lbVLe32gl4iWZPC+ssCfLKhVCOt?=
 =?iso-8859-1?Q?L/WAqWQsFB8VAgCAGE3A4g20i59gQmmU7iLI6tszQwup0j4RNtgLPPm7va?=
 =?iso-8859-1?Q?1KKlk//YkBneypL4lb36X0+L03OoJnBM1IuRaR2eXHiS2YvV+nDKhLX6UV?=
 =?iso-8859-1?Q?SBDvMYQIMjS3qaWLlsPDi/WMHA2o+TyUn+NpbR17UCtxf52DrtAE54ewSw?=
 =?iso-8859-1?Q?qHhzhJlcOiQY05M4yFDc1nQ31CqvTj1Ncs0cdzt1w42sgoB3tdGe+EV6Tr?=
 =?iso-8859-1?Q?Npm6fkgp18pYZiqpP8oPOc+z0KoRsYBk8YCJmNmp/BDm5ifbayqsYOIhUQ?=
 =?iso-8859-1?Q?cC1EISdT/q655tOPiTP33cIZcl9+B9gPXZhEClkD5JYXWdrPIDf0YR/Xme?=
 =?iso-8859-1?Q?tnZ65W2AoMU5lCFG8fpKXivRwjqIl2bdNfkrsqTdolbf/Z+ehfTj6Jn7VT?=
 =?iso-8859-1?Q?UpQ8B996tr4jKR6p8X4WpX9BYt3BPlq34CeiYQYh3RFNZlHwIPgG+JG6pE?=
 =?iso-8859-1?Q?ZIVOt4o62rKxyXe3PBrHhKIb/BW5JTxJVmXQB9jJ6jiyzAA5MVojNNm627?=
 =?iso-8859-1?Q?s9ydd+TpED8oi9+dojNcri0G7E50EIpbI9Lu2VHfecdmD5pwOYK92ArWt/?=
 =?iso-8859-1?Q?4t+gFmUuYyQXn1jBBUYzyndZHKABAkoHHNgyYm2EwQs6njzy8FXJ2ZSK9t?=
 =?iso-8859-1?Q?P+t3iE5x5QvmE7sVJM8IXkCWxEUgCfVfoM6rEiaB2f1cypc9JX8dXI5+MH?=
 =?iso-8859-1?Q?ZEVWbeHwqpZHvRRbliS2BJOX5RGrjtwgUZrvDCqdCYIe7/CiMBx8M0dTB6?=
 =?iso-8859-1?Q?3yQ8XrejgdF5CP7atI6BPPr5SelAMds2u1kaVsWINfhYp9j7x3Ya4rKWCw?=
 =?iso-8859-1?Q?8H4xdt8wI1/gizxh/rzDYkFqaUrk9R191MxZTYsXf6CAtNcIkGgcj4RmTl?=
 =?iso-8859-1?Q?ZV8iAAJBSwZS6sjAQqSP1+mYZ6FysQs23Eo2cNdbpxTJqEtBomrzRdW9CJ?=
 =?iso-8859-1?Q?Udq3s0tA9Vk6nqKXqffWpAT1v8GTCY9baLsw6NMWUj2lP9tcJi0cQpVGzO?=
 =?iso-8859-1?Q?FgyJuAoBSZBE6kS17xZtlmXgiqNq+K11fA+eAPYQdAI+dkuKVwP3ozSthj?=
 =?iso-8859-1?Q?S8y1QzveCcTaoVsRvD4i6hQA2fMwVqO+6bvyuh+32+Azq6RxepEmAVP9F6?=
 =?iso-8859-1?Q?QSLaZcCvVtmvXG5rrdy+zxMuy3VnpIwHYPlUvBJUjqTWZ4J257EPSo39d/?=
 =?iso-8859-1?Q?0BNS?=
Content-Type: multipart/alternative;
 boundary="_000_DM8PR13MB5078933D25141B3F23ECA782B3022DM8PR13MB5078namp_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5078.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f52202-04e2-42e7-d80f-08dd23ac16b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2024 23:46:57.8236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR13MB5834
Received-SPF: pass client-ip=40.92.41.77;
 envelope-from=gabriel.barrantes.dev@outlook.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 23 Dec 2024 20:40:44 -0500
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

--_000_DM8PR13MB5078933D25141B3F23ECA782B3022DM8PR13MB5078namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From c808fa797942b9bd32221594b7eef690a7558b14 Mon Sep 17 00:00:00 2001
From: Gabriel Barrantes <gabriel.barrantes.dev@outlook.com>
Date: Mon, 23 Dec 2024 14:58:12 -0600
Subject: [PATCH] backends/cryptodev-vhost-user: Fix local_error leaks

Do not propagate error to the upper, directly output the error to
avoid leaks.

Closes: #2714

Signed-off-by: Gabriel Barrantes <gabriel.barrantes.dev@outlook.com>
---
backends/cryptodev-vhost-user.c | 4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-use=
r.c
index 43efdf9747..09bfbddb47 100644
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
2.43.0



--_000_DM8PR13MB5078933D25141B3F23ECA782B3022DM8PR13MB5078namp_
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
From c808fa797942b9bd32221594b7eef690a7558b14 Mon Sep 17 00:00:00 2001 <br>
From: Gabriel Barrantes &lt;gabriel.barrantes.dev@outlook.com&gt; <br>
Date: Mon, 23 Dec 2024 14:58:12 -0600 <br>
Subject: [PATCH] backends/cryptodev-vhost-user: Fix local_error leaks <br>
<br>
Do not propagate error to the upper, directly output the error to <br>
avoid leaks. <br>
<br>
Closes: #2714 <br>
<br>
Signed-off-by: Gabriel Barrantes &lt;gabriel.barrantes.dev@outlook.com&gt; =
<br>
--- <br>
backends/cryptodev-vhost-user.c | 4 ++-- <br>
1 file changed, 2 insertions(+), 2 deletions(-) <br>
<br>
diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-use=
r.c <br>
index 43efdf9747..09bfbddb47 100644 <br>
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
+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sess_info-&gt;op_code); <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return -VIRTIO_CRYPTO_NOTSU=
PP; <br>
&nbsp;&nbsp;&nbsp;&nbsp;} <br>
&nbsp;<br>
-- &nbsp;<br>
2.43.0 <br>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_DM8PR13MB5078933D25141B3F23ECA782B3022DM8PR13MB5078namp_--

