Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF618CD6E41
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 08:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS9gs-0001TC-1S; Wed, 27 May 2026 04:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wS9ga-0001I7-75; Wed, 27 May 2026 04:32:21 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wS9gY-0003xv-5U; Wed, 27 May 2026 04:32:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unqv2xKYv1lze51e6mWNAN3+AhqAlZuZcsf+rTtAZcTXJ4KEZcdelYoqju5BUy08vBDlbtA7rqPFQwfOu1RzPmR0YZS9aKF7T36ufuaiAwjLb8K0Df4ojrdbAoenIYyRGroMjsq2UwrLLWob/AjcP08gRYWtc3B7aayAVP0EKgPBlthBOQQLtCOi+EM9DzurSM0MBpEpKr8kCsoBYD/jBieeJ1x379R1z3jMHOFQc90Xxzs3bDC/5Z2jnVlQ2ClyGE1mmC1lJCS8RyWKp6Y0qF855FZNIb22kU5mQqA0B/Ed9PyNxIcbn16CyLlqaule+YBWdTUwYl83Jzvey9bAkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSWTPWYOxHTX6l0cvhAcLKInV7KidfAXnh/bEmyHL94=;
 b=T6Qo7BeOT/9w1yBcb79/LuTxshnu0vZDKQFU0jBpArp4uHuS04x8G+A7PQK1wrk/A3z4E4jhAZ3T5MUbykrMX90pxqBSX6qy+9G94wtFHCpnD2LhovW9o6Gnpk3gcc6+7X3Mx5EgiGL4Ngjdcn/lutKTQliY++oZvaBcUvZ/lMNQ4VLyYX0RiqiEkPErSa7mj3nKnJLYER+be2I4cytlqLgCeqjVsEfpbWlFmb/rNeKC42ps1PYTRAEzk2lNnNMBei8sREghgbEbcgOltIVx2CNIb6QW39HsVyZL8aTb61/kNBZCgG9168XI/E5B39v4/Cch0pSBE/59oXlVaTIXQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSWTPWYOxHTX6l0cvhAcLKInV7KidfAXnh/bEmyHL94=;
 b=Y7pgzq8ZGPlO8aRHGw7csfYS16DyAzeWXs51JZjPcmYkdO7/KBxqp++Y+AqJgimSX8F99tsCMih4Ly2aqHq2ntWVOtwIPDHnAkYckJ4nl0CSRWNrbvDwaBpDmFTMgdbA7kNUir4B/w1ySJo57Fi2JRJwyt9bms//2XIMcou+QcRsw4pcDKoIO+PjM8w+xfT4gLDfkaTtMAriWD2o46YTSg6GZOQpKLLW5VCs69frabo7aTBGWI0cRpRQH+UeQ1dp/vYXeM+8OSdgsPWIq3l6xDblgxxi3DvD6UvT0prTGFRsXVCxGXKB2d8kNH9N7Y0utk2hdQIOzy9M7hPUZl9gag==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by AS8PR09MB6314.eurprd09.prod.outlook.com (2603:10a6:20b:57d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 08:32:02 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 08:32:02 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v10 7/7] target/riscv: Add endianness test for RISC-V BE
Thread-Topic: [PATCH v10 7/7] target/riscv: Add endianness test for RISC-V BE
Thread-Index: AQHc7bNJzVhtAv4qgk2Le7unTAT5ig==
Date: Wed, 27 May 2026 08:32:00 +0000
Message-ID: <20260527083151.17876-8-djordje.todorovic@htecgroup.com>
References: <20260527083151.17876-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260527083151.17876-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|AS8PR09MB6314:EE_
x-ms-office365-filtering-correlation-id: 1ec35e9b-9383-4de2-4fdd-08debbca6d4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|11063799006|56012099006;
x-microsoft-antispam-message-info: +9V9SPl2ntSsmR5AbfszosZidy6qVxbbTQgMy+aX09414oAZ6Kp3OQ/QcLlsFjFguYdlo0dxMLTq8i2WrD2hkQO/Bn4bUhdoXxeDfArsyPDRImxLeD7hA21SMxhNc6wQ8MHYezArroVYSyN7Qy6bLTaTyDa5wwPtDDgrg36seS06VWMgEMMAGTRIxZc+7O2ncPVBWbfmQKere7rWs7t8Ap25qXevXHsAdb6ycE5FLIp5/mhHx1mnv6RWFGV2Y4YMLeJCMW1us3m5rbuBFXik8HcAPd+exNkxlB0MG+NjwiqqK9nY04m4mFkJqmBA0davoCSQMbjcen6dddN/6j61JVCafPrilBpvB4CwwhGIP1JJP5H8jRcHnUmetlLnDDbyqt1J1fhF8htY3Pvq+ezjtiHPs5gKUvrV16MlN/7uhLmaMhbic0LcDkOcU9OEOVroaqggdB8zsjBwspgZDBn9lOZd/BrpLNy9wactKLXoAldNhCyPLyKHxyv2GpSNtjM8NBuL19YKdiIrptDLnvX1igqhOsCMHTCc3ZzkGWn4qISMxGN8EU/lA3S34+jGgkLzVBLQJ4NYFRruufcwrKIbX8+OaeHjb9ggFmIy5Mj20vGmX/11HUl0qqlGzOY5sr2tzCLP6tll6RowVc5S8Y3eS6uIinpduITrVP8fsEzpwZoJypz55krK8wBWganIM4Xbwgh3T9+g+2pd6VUxu0Ubwoj571+yJQYApIflNFLgZN6ReGsmDOws0IM1UHlZyU0L
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RG8wQXpocGhLam8wNXBVNE9CTFV3alJyZllQMFgzNStRTVkySG45TVpqd3Qv?=
 =?utf-8?B?YjNuK3NtaWZwSGtlRjM1bW40VUROOU9MY0NJdFV5a0lSaHhlYitGeThRUEZG?=
 =?utf-8?B?QnVRelBpNUMwYUxSK1FFL2RkY3NRaE9MM2c4c2VJTTRJUzRlK3l2RFE4Nmx6?=
 =?utf-8?B?YkFlUWNwSzg5S1hlT005TzVnVE1VVTQwcHJFQitnWFE0bFdkU0ZrZmlQZ0g5?=
 =?utf-8?B?SkYzY2wrMTgvbGJ1TDh3bjBnckpZa0tZbUF3cGltYU5mY292UmVnVXQzVXNs?=
 =?utf-8?B?dHlsdUYxTHByODNEVS9NNDBrMW5vcGRCb1ArSjRBUkwydEcza0VtYVl5bFp5?=
 =?utf-8?B?ZGR6WmxRVzhiUzVQMGJaWVhrY0l4cHhCSThZNndRVXYzM2ZWcXBmZ3VYZGRU?=
 =?utf-8?B?OFRVVFRYa21lZERnQ1BjdTAxYVVtK1VJN0RubTNWQ3Q5MXlIZE5SMnRTRGQ0?=
 =?utf-8?B?ZllGSUIvSEhhYXBpUnRkRFBtS3MrK0F4WnJUYlpzV0l6dmZMRG95Y0piOGgx?=
 =?utf-8?B?V1F2QktTK2g0N2VCc2ZZUUJsV2R4NVVOblg4eUU0K2FKbU1GVGEwY1E2VVow?=
 =?utf-8?B?UzZ5V20xRndDUHJIM25ieVZYTGNBWEpoU0pLaUZDcUhoZ3ZBY0xXOHdUOHZD?=
 =?utf-8?B?dXBZS2RyWVN5cFZEckdVMzdVRHhKSFNWYnk5TkhJWVpSQk1sQXUzVU54NTlU?=
 =?utf-8?B?ZllFWGtxcVBLY3FJNkxWOXVHQk04cVVLbVhsQXpOMTJVbktkcWNlWHBwSVIv?=
 =?utf-8?B?ZWlGZ1pXRnBBWkhobittcWN0QUxvaEorc25TbUhFMHVzQTc4d0hjTWNMbVpy?=
 =?utf-8?B?My9aeXNUcnoxSFkzb2JZTlRTeVBBOGNJWHlRR0s3WE8vOG9PNE9LckVGbGc2?=
 =?utf-8?B?MEh0b1FqV0pvc1JqUlhVOERTNzRkZFBubFJkNytoVUVXQ1Vxc2RDcWQ1Yzd5?=
 =?utf-8?B?dyt3aU9mS3NiYUJBdWtYUzViODRIbm41K0pHNHcvTFM4dURqMGJ6OHRmY2kz?=
 =?utf-8?B?ditab254bDZkc0VQNW9OMXY2KzlkbGw5Y0UyUmxLRnJKcW1vZEFuZGVyN2lu?=
 =?utf-8?B?Y243MDY5MVYrYkxkaS96L1JzR0R6OHZMOW5zYW5pekFrOGM3d04wVmV1ZUtx?=
 =?utf-8?B?K3E4OHRSeTFyUUNZN1VlVkxBblptZ3ZoLzBTcjRaVCtkVFdiT2lpZXlwZ2Qr?=
 =?utf-8?B?eWNyMldLQVpzNG1PcEMyTmRoaW5Bek56WFg0cUxubmkzS3F4MExaekp6Sktu?=
 =?utf-8?B?QjVsbnZkc0IwdTVydUc1U3RHS0xXcDJMT0N2WEp5VDZUbGJUNG4zVFBMQTVE?=
 =?utf-8?B?QThUQVdwUGNianZSU2dydHVMWWRRWWppK3A3cGxPRG5GUjgreUt1dTczVmpr?=
 =?utf-8?B?Vmpqa2VNZWVrZlMxa2Q2MGMvSitxYWh0cUt0bm0zY1VHQm1HNmZsVXhUVGJk?=
 =?utf-8?B?ZGYreVlyTVpEYVlwaU5iNnVXL2ZmcGkwL1QwMXdtb3JVc2xjK05zZUZPZjcr?=
 =?utf-8?B?aEgraTU3bE1sZEpodW5mNmNRd3FjZWFGZkFERnRuL2hnd0UrWFRmSGFWOEll?=
 =?utf-8?B?Y3lSZGRRY1pSSFl2dEFKcnc5UGlFSUM2dFFScGthMExFcmdBWGFzWDZTVHdx?=
 =?utf-8?B?ZHAxZnN4V2NOM0txMStJMW9oSmhzNnNqUjNmRUc3UnQ4VG1vYWFHNlhTell3?=
 =?utf-8?B?Nm1BclFsKzNhRVJTQkI3UEVqRDdEWVF5NWNYcGNBWUwxSlRjeFlETlFCNFll?=
 =?utf-8?B?Mk10SW9MNDJMNWIwUlM1WmhoWEgzSHFnWVZNNUZHblF6aDFXWk9vMjE2dEVG?=
 =?utf-8?B?aWRGa2VwV0Uwa1cwbStwaFoySm4yRkYxVmZhRU4yalg4Y0F0OFNOTmlHTTF1?=
 =?utf-8?B?SEl5azllc2hMYkRBSFU2N25jVVVoKzRSVHk1R2FYZXNSMDZkYnZycHNNRWpL?=
 =?utf-8?B?UWtGSFZnSXJ4RkxXMS80blpWbDNFdFI0cmtObU5rVjNZQzNmQkFtNjM1eWp5?=
 =?utf-8?B?K0hZcUpDcW9tNDdxbzU3NXIxdnpTNkUxRUU1TmJmR2luQXFOTDZHV0toc2Js?=
 =?utf-8?B?akswcEI0am9rZ3FXQ3ZuTk5IWjJHUjhPOU4rd05qeTZzZmR3Qm5jUTNIa1FK?=
 =?utf-8?B?V0ZWbWJuNis5S09qMkg3NnJWOWd3UkRJZnMrQldLWGo1bSt2VzlERnVyRXJH?=
 =?utf-8?B?L2p4bElSSG1zbFk2VlgxMmpLSWZVVkQ4cmlFMHlyNy82eEF6VEpVU1JwK2da?=
 =?utf-8?B?MTlpK2hER2xwVk5qWmM3cFgrNzZEUlZoa1dGenE0dW9Sby8wSUxJalFsSFVu?=
 =?utf-8?B?SWR6UkcrTDlQVTNZRW1TMmd3eEdUNk1oSVB4VUQvSGFNT0JYQjNWSVZvV3Rr?=
 =?utf-8?Q?TyRx3V7ns781CO7S3dZHDTiGEKZG1JK/Z0D6c?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <708A168E6B66A64FAF23208D87DF6C82@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec35e9b-9383-4de2-4fdd-08debbca6d4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 08:32:00.8134 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rMZ/uNqyZc9SM+Y3p9PhLNB5KrP+dLlXyfo62qNY1rubGNkTiVTYzsrhcjHcN+AUJGmHxaX2BpyEqCnkBbJmpY3q0dO5muqWfs2ODhE4h68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB6314
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

QWRkIGZ1bmN0aW9uYWwgdGVzdCBmb3IgUklTQy1WIGJpZy1lbmRpYW4uDQoNClNpZ25lZC1vZmYt
Ynk6IERqb3JkamUgVG9kb3JvdmljIDxkam9yZGplLnRvZG9yb3ZpY0BodGVjZ3JvdXAuY29tPg0K
UmV2aWV3ZWQtYnk6IFRob21hcyBIdXRoIDx0aHV0aEByZWRoYXQuY29tPg0KUmV2aWV3ZWQtYnk6
IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCi0tLQ0KIHRlc3Rz
L2Z1bmN0aW9uYWwvcmlzY3Y2NC9tZXNvbi5idWlsZCAgICAgICAgfCAgMSArDQogdGVzdHMvZnVu
Y3Rpb25hbC9yaXNjdjY0L3Rlc3RfZW5kaWFubmVzcy5weSB8IDU3ICsrKysrKysrKysrKysrKysr
KysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgNTggaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEw
MDY0NCB0ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9lbmRpYW5uZXNzLnB5DQoNCmRpZmYg
LS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvbWVzb24uYnVpbGQgYi90ZXN0cy9mdW5j
dGlvbmFsL3Jpc2N2NjQvbWVzb24uYnVpbGQNCmluZGV4IGI5OTZjODlkN2QuLjU4NzEyMTFlODkg
MTAwNjQ0DQotLS0gYS90ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvbWVzb24uYnVpbGQNCisrKyBi
L3Rlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC9tZXNvbi5idWlsZA0KQEAgLTExLDYgKzExLDcgQEAg
dGVzdHNfcmlzY3Y2NF9zeXN0ZW1fcXVpY2sgPSBbDQogXQ0KIA0KIHRlc3RzX3Jpc2N2NjRfc3lz
dGVtX3Rob3JvdWdoID0gWw0KKyAgJ2VuZGlhbm5lc3MnLA0KICAgJ2Jvc3RvbicsDQogICAnc2lm
aXZlX3UnLA0KICAgJ3R1eHJ1bicsDQpkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9yaXNj
djY0L3Rlc3RfZW5kaWFubmVzcy5weSBiL3Rlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC90ZXN0X2Vu
ZGlhbm5lc3MucHkNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwMDAwLi45ZTBi
M2I3ZGI1DQotLS0gL2Rldi9udWxsDQorKysgYi90ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVz
dF9lbmRpYW5uZXNzLnB5DQpAQCAtMCwwICsxLDU3IEBADQorIyEvdXNyL2Jpbi9lbnYgcHl0aG9u
Mw0KKyMNCisjIEZ1bmN0aW9uYWwgdGVzdHMgZm9yIFJJU0MtViBiaWctZW5kaWFuIHN1cHBvcnQN
CisjDQorIyBDb3B5cmlnaHQgKGMpIDIwMjYgTUlQUw0KKyMNCisjIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQorDQorZnJvbSBxZW11X3Rlc3QgaW1wb3J0IFFlbXVT
eXN0ZW1UZXN0LCBBc3NldA0KK2Zyb20gcWVtdV90ZXN0IGltcG9ydCB3YWl0X2Zvcl9jb25zb2xl
X3BhdHRlcm4NCisNCisNCitjbGFzcyBSaXNjdkJpZ0VuZGlhbihRZW11U3lzdGVtVGVzdCk6DQor
ICAgICIiIg0KKyAgICBUZXN0cyBmb3IgUklTQy1WIHJ1bnRpbWUgYmlnLWVuZGlhbiBkYXRhIHN1
cHBvcnQuDQorDQorICAgIFVzZXMgYSBiYXJlLW1ldGFsIFJWNjQgRUxGIHRoYXQgZGV0ZWN0cyBk
YXRhIGVuZGlhbm5lc3MgYXQgcnVudGltZQ0KKyAgICBieSBzdG9yaW5nIGEgMzItYml0IHdvcmQg
YW5kIHJlYWRpbmcgYmFjayBieXRlIDAuIFByaW50cyAiRU5ESUFOOiBCRSINCisgICAgb3IgIkVO
RElBTjogTEUiIHRvIHRoZSBOUzE2NTUwQSBVQVJUIG9uIHRoZSB2aXJ0IG1hY2hpbmUuDQorICAg
ICIiIg0KKw0KKyAgICB0aW1lb3V0ID0gMTANCisNCisgICAgQVNTRVRfQkVfVEVTVCA9IEFzc2V0
KA0KKyAgICAgICAgJ2h0dHBzOi8vZ2l0aHViLmNvbS9NSVBTL2xpbnV4LXRlc3QtZG93bmxvYWRz
L3Jhdy9tYWluLycNCisgICAgICAgICdyaXNjdmJlLWJhcmVtZXRhbC9iZS10ZXN0LWJhcmUtbWV0
YWwuZWxmJywNCisgICAgICAgICc5YWQ1MWI2NzVlMTAxZGU2NTkwOGZhZGJhYzA2NGVkMWQwNTY0
YzE3NDYzNzE1ZDA5ZGQ3MzRkYjg2ZWEwZjU4JykNCisNCisgICAgZGVmIF9ydW5fYmFyZV9tZXRh
bChzZWxmLCBiaWdfZW5kaWFuPUZhbHNlKToNCisgICAgICAgIHNlbGYuc2V0X21hY2hpbmUoJ3Zp
cnQnKQ0KKyAgICAgICAga2VybmVsID0gc2VsZi5BU1NFVF9CRV9URVNULmZldGNoKCkNCisgICAg
ICAgIHNlbGYudm0uYWRkX2FyZ3MoJy1iaW9zJywgJ25vbmUnKQ0KKyAgICAgICAgc2VsZi52bS5h
ZGRfYXJncygnLWtlcm5lbCcsIGtlcm5lbCkNCisgICAgICAgIGlmIGJpZ19lbmRpYW46DQorICAg
ICAgICAgICAgc2VsZi52bS5hZGRfYXJncygnLWNwdScsICdydjY0LGJpZy1lbmRpYW49b24nKQ0K
KyAgICAgICAgc2VsZi52bS5zZXRfY29uc29sZSgpDQorICAgICAgICBzZWxmLnZtLmxhdW5jaCgp
DQorICAgICAgICBleHBlY3RlZCA9ICdFTkRJQU46IEJFJyBpZiBiaWdfZW5kaWFuIGVsc2UgJ0VO
RElBTjogTEUnDQorICAgICAgICB3YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4oc2VsZiwgZXhwZWN0
ZWQpDQorDQorICAgIGRlZiB0ZXN0X2JhcmVfbWV0YWxfbGl0dGxlZW5kaWFuKHNlbGYpOg0KKyAg
ICAgICAgIiIiDQorICAgICAgICBCb290IGJhcmUtbWV0YWwgRUxGIG9uIHZpcnQgd2l0aCBkZWZh
dWx0IGxpdHRsZS1lbmRpYW4gQ1BVLg0KKyAgICAgICAgRXhwZWN0cyAiRU5ESUFOOiBMRSIgb24g
VUFSVC4NCisgICAgICAgICIiIg0KKyAgICAgICAgc2VsZi5fcnVuX2JhcmVfbWV0YWwoYmlnX2Vu
ZGlhbj1GYWxzZSkNCisNCisgICAgZGVmIHRlc3RfYmFyZV9tZXRhbF9iaWdlbmRpYW4oc2VsZik6
DQorICAgICAgICAiIiINCisgICAgICAgIEJvb3QgYmFyZS1tZXRhbCBFTEYgb24gdmlydCB3aXRo
IGJpZy1lbmRpYW49b24gQ1BVIHByb3BlcnR5Lg0KKyAgICAgICAgRXhwZWN0cyAiRU5ESUFOOiBC
RSIgb24gVUFSVC4NCisgICAgICAgICIiIg0KKyAgICAgICAgc2VsZi5fcnVuX2JhcmVfbWV0YWwo
YmlnX2VuZGlhbj1UcnVlKQ0KKw0KKw0KK2lmIF9fbmFtZV9fID09ICdfX21haW5fXyc6DQorICAg
IFFlbXVTeXN0ZW1UZXN0Lm1haW4oKQ0KLS0gDQoyLjM0LjENCg==

