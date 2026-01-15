Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135E1D44C41
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 13:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgMzA-0006O9-5b; Thu, 15 Jan 2026 08:02:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vgMyb-00056n-7p; Thu, 15 Jan 2026 08:01:25 -0500
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vgMyY-0007H3-EB; Thu, 15 Jan 2026 08:01:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ol7/dCLjEnTtR9izwyegfZ2rTnN4uaH8266qNr6g2wDHarvbOBOzHcARKQSxjDZVTnrRkUxhBycRtYo7I/bjcQjsXiMYlgHRjc6h2k5bJQLIFmo5zcms6IaTmSVN6uh0++T9bJvBGyZM1ATHQW0TqAQTogHX7giWLrLTzL7funnvDAq7FmD14FBJ8iny1BvuExfKLFJ733e3Q5jtkCuEDUK8/SV6Jq4kczB8brRAzRWOBap+wi6RRBw3WxI5JpsEIJTfA0CojqMNLgcuMR/HbFA5SDUqv5pXoxGInc1vNL/CzCwPf8WCR41Waj3LR2hnTCbHtun4ZJkUCWXvbh+Lxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSYWypAZgekTOVvGxs7zyqrKT5hIHAQzu4DxnxtghzY=;
 b=nUTn8Mt8FmQ/Rz8mRqVGEWnsDE1ccMpALRrjJTTvt/08BcNBABAoAcMTXl7GgJ+XFZAhwW2vlcnKxny1/0FsiW7CX6JFPJEykivjfxg6PLDiXPcv5V/35AvvptZuK3UaiAAMoa3FdgklL26wOQ3YXNGD8FmJExP/edg296w49H0RXook0Yb52PYJamsStwMFsPfWgO45IzlkT0tRchEK0QAWpJdkoSAWa37bFYxdulDau8CsrVRA88d73hmEBaNn3kqCl5wDGrpZEGHjSqRVZQbslY5W7gGAJcRDD2YU2ocKsVBChJVMmaCSGTbhbYqWBH9CeCB9pJGwHDcQ1l5Zrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSYWypAZgekTOVvGxs7zyqrKT5hIHAQzu4DxnxtghzY=;
 b=SZI7I4WMywsHB6dPYGnsdy1b/dKLfbZOGzIuXkWG6gvASJx2DayMHN7I9EgTkC2P8wX8tushKDekUrb4rqQa2ffR5LpIpNlPy0XMH1W0ENu6vadkOinvcJ3UDPlpTKCs7giaq1/1qB2HkYYtkzUEEn286KWH0rI06dd/Af8W56rzxfvmDI2J1XHamUteA1WKV/mlHho54WA3OjL80C3iadd773PYl+AsDrw5OYeyw1yaZE64b4u7hO/cqc3YMHiq7nOdLssUvJmK16pmVJW8Ad9l0LSScHZi8oRClydZeHDg1IJnAV5Ee13uAmhKFvURK7mnP8BsertctZpyUpCALw==
Received: from VI1PR09MB2798.eurprd09.prod.outlook.com (2603:10a6:803:e6::13)
 by AS8PR09MB6257.eurprd09.prod.outlook.com (2603:10a6:20b:5b5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.2; Thu, 15 Jan
 2026 13:01:18 +0000
Received: from VI1PR09MB2798.eurprd09.prod.outlook.com
 ([fe80::d8f:f20a:9e1a:9387]) by VI1PR09MB2798.eurprd09.prod.outlook.com
 ([fe80::d8f:f20a:9e1a:9387%7]) with mapi id 15.20.9542.001; Thu, 15 Jan 2026
 13:01:18 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v2 2/2] target/riscv: Fix null pointer dereference in
 cpu_set_exception_base
Thread-Topic: [PATCH v2 2/2] target/riscv: Fix null pointer dereference in
 cpu_set_exception_base
Thread-Index: AQHchh8Jxu0w5jrN7kyQfenDGAsTbA==
Date: Thu, 15 Jan 2026 13:01:17 +0000
Message-ID: <20260115130110.2825796-3-djordje.todorovic@htecgroup.com>
References: <20260115130110.2825796-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260115130110.2825796-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR09MB2798:EE_|AS8PR09MB6257:EE_
x-ms-office365-filtering-correlation-id: 6ab8c88e-4d72-4253-763b-08de54362c66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?YTU0T1BwbklyR0plQ1pVa0JnY3daVU83WitySHVXcWxWbXNpaGpyMFpGa2Iy?=
 =?utf-8?B?djFIenE1UndsOVdXTXFpSVhXUkF5dllmYmE4U0ozK2FmQkNEUFcwS3RCZFgy?=
 =?utf-8?B?M2daUDZaMC9tUUsvdEoxQXArd2xTcGtra1dSM3QzVXM4TXBvdDNXK3pWbVd2?=
 =?utf-8?B?OWlsQjNZUTNDbHF4WDZuTGRBclRpVm9GREV3c2pTdnhEa1dXeklNUk9hNjRH?=
 =?utf-8?B?RWVPU3BoeVJ1TGFtSmt1K2ZjR2N2N0h3ZSs0UzJaSlVSWnhBcDhrdkxIRFh6?=
 =?utf-8?B?RUYwVFFOaUovejVHQ3ZNRmV1N3RpMWh0ajBhbGtPTWhaUERnVi9XMEVNdjBh?=
 =?utf-8?B?TlowV1Q1Q0RSZlNiSUlFNEV1Qk5nUWdxdVcrRUt1aUlhNlNDOFpmd2pMdGtw?=
 =?utf-8?B?T1lZRXI5WktiN0dvaytZSXZpTldaL1RGSEVHNmp4bTNpWHFXTjIxMFd3TFNI?=
 =?utf-8?B?Y0xlZXZCRjU3a1daRmhyaGFsQ1FHSjlONFlwK3llWGNKUnUzbXFuRFRXWVJH?=
 =?utf-8?B?Yi9CVEJXOTZPQitIN0V6MmxkbHU0U3p0bEF6S05ieitWUEpFNEovNDdhOTFL?=
 =?utf-8?B?c1NhR3o1QmFWZGIwN054Tm5TSWR2ejlYSmVvbVNSSU5jSGZERzRCZVo0eEdK?=
 =?utf-8?B?TTR6di9peG9qaEUyWitxMi9Ra1hNQjk4S2kwUVZ0UVBsMWtyL3g5S0swSFgv?=
 =?utf-8?B?NjhZT1A0NHFHbTdzWnFqY3hLT1U0aS9ISUhVcnU5NzBVemZlb2R4bVpOaWVF?=
 =?utf-8?B?Y0dFR081OTVmYmZSZi9DRUl1d1JRRy9xMmVkU0J2T08rWkY5ekVad0xwVU1B?=
 =?utf-8?B?N0dpbjlUa0k1aElDbUdTODBXZStoZ3NvTlpDNjBDdEFQNzlQOWRGbzR6Ulg0?=
 =?utf-8?B?TEFZR0dxM1dwUXNkUzY2OUZpTGVjNm8wOGs3Y2F1cllCL0RZeDVSZ09PWkI5?=
 =?utf-8?B?T2RXYWhEby9mTmwwTjFERHR3ZDdkSmp4cXRQZ0JzOEQ2Sk9VTEhrYlpySnA2?=
 =?utf-8?B?Mmsyd051ajM4anM3dkZIZ1huL0t4eVF2NWJqenlZcFByYW5rOEx4aksvWW5K?=
 =?utf-8?B?b3FnR0d2RTJzejdQMllUK0FXTmwraFRKcE9UUDcxYmtLYVVveTdPYjJ1UlhR?=
 =?utf-8?B?SzNIajBqVWY0STFqVzNHd2tIbmdtNmtFZjdKT1dsKzhuWWNhVHdKdTN6TVRr?=
 =?utf-8?B?NUVHSnhUbXdwNjRhQlQ0aEJ5Q01PdzhCandpSVc1L21xdzl5bXAzZHVJOTlM?=
 =?utf-8?B?c2ZDSHBFU1lsSTNBN3VQaytiL240amJuZVE1YkFINnlCMlBJY1dMdFVrbUcy?=
 =?utf-8?B?M3Fxc0F6OW9JTWJ4cTRPeFpmRVN4a2NUS0dBL2dzbDU5cUN1VlRURFVldXNR?=
 =?utf-8?B?a2VLQUN6dkl6V0E0QVdGWjA3bk4xYWZJOExHRXkyLzkyeTBPN3ZFZENnTHly?=
 =?utf-8?B?bUhrcWRxaWREdDJRZ084OEFaQXdodDZZak51K3RjbVdWRW90RThSdjFpUGZG?=
 =?utf-8?B?amNLdnJiOW81NnMydUNUeGZlaHh4a0Rtd1lUMEF5WnZmN3FibkI5VkRZOGh2?=
 =?utf-8?B?dldQd1Q0MURWNlNja1BsQ1FQaWMzYkVQSE9RSEZjd2hQK1FwcTczR3VUTmFT?=
 =?utf-8?B?am55K1FST1A0aXlPT05qSXp6SWNhbWdkbGVaTUcwaVlFN1VyK3BaTnBTV0VE?=
 =?utf-8?B?NVc4SnZ0elQyeDF0Ukd5a04xMmNILytVMnU4QVRnN2s4V25nMGxXYnkvbmUv?=
 =?utf-8?B?aWltaHdjbWFUQjV1Z0FqNW5jamtXejc5N1R3OWFSYVpTL0F1enFOcG1IbGlF?=
 =?utf-8?B?T1RoaVMzV1c1ZWFtUE55TDZ3ZzRPMTFnUTVpV2FEYTVQeW0ybVJYV1NxUmpF?=
 =?utf-8?B?Yk1taUd4Nno2NzNrYStlQ0Q5bWFtcituRXFDOVVmVXhNQnJLQXJJUjgxSG5O?=
 =?utf-8?B?anBZbXBEUHhtMy85MFJyU2c1WUVKdWdwYi8xaGFqWURTaG5seE02aTEvSnZx?=
 =?utf-8?B?ZURCQzFoTFhlL0JxanV1c0dVRkVSRGJsSEhMYXpvWUtHL2dXZkFRUUdlWkt1?=
 =?utf-8?B?N0NEaWw3WFB6bnk3S3ZQd3ovUElXaUZxMlRiN3pkNDkrb0ZyTzdHWUVqL1Bs?=
 =?utf-8?B?a0ppWTgyZnNseFFMZkU3blRpYmltcklPVHZaTkFXN0Zvbk5Vczh6b1lLT1lW?=
 =?utf-8?Q?9sUTmVOE3Ru2QMkncykUIkw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR09MB2798.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXNsdUp2ZEtOT1lTOXJsdGpKN0VtMXpqckVPY3hJdUVzOG5EL2RpampOMlZr?=
 =?utf-8?B?bDI1dkJDVnJROENlaWZUZUJ5Tm9jZm9ZdERtNEo4VmlrTDRPejlCMGVNcTBy?=
 =?utf-8?B?cU1qUi9XSUI0SjZVWXFmYWFNYXlsNmFyVWdCWUJMUjZBWFlWd041OENsbGhQ?=
 =?utf-8?B?b3NLNDFONlNyZzVkWW0xSVFtbTdkcTFHeGdDNi9zcXFUdlVJVVBlbzZIMXh5?=
 =?utf-8?B?akI5ZTJSbXZZb3IwcGgyZFZSeEZyVmdIMnJLWnowWGdhV3QrNXZ2dDBFbUJK?=
 =?utf-8?B?NHVxSUpHcXFmMzdHeGd3ZlhTVTBLWUFZTWhGWnAwQUFCc1NOdDgyVFovZjRq?=
 =?utf-8?B?ZHVEMUNIcmR0L2FHcVpxdlhSOXZNamppQmdlQ2ZLQUVWNjNWSFJHaG9CdlpO?=
 =?utf-8?B?UExxZnJWWG92Uk9Sb0ErVnBHRDZvazlxaFd1dHZHdDJkZVlRUXlvQkN6VEpL?=
 =?utf-8?B?T1FncnBNd0N4SkVRTHNMczd3NFovS01uMm8vUVJyUTdvUDFpV3hDcDRmUEI3?=
 =?utf-8?B?SUpTNDUraFgwZGE4ZVBMb2MwNWF6bXZuUHN3VndCQThEdHZjYUJpSXo5Vldw?=
 =?utf-8?B?dkpWSS9WeGgyOXNjVW9RUHdRcFlRSHplVTR4VDNCZ1dacDdGbTFUaWRhMDdO?=
 =?utf-8?B?QTR5SjNYMnJFanhkN2g1TkJsSkFyWHpMWXgvUTB4UzRsT2VEMFMrQXRZRmpY?=
 =?utf-8?B?VExOY3gwQ2JMWUwvNmt1YlJld0dKblcrZ2Y2LzlqVWJOVUFUWnRiWkxoakF3?=
 =?utf-8?B?SEZiVUZkc1F6cWtOOHk4am0rLzV3QUlHdTZreWJzdVoxZkczSk9WdkNCV0lL?=
 =?utf-8?B?WVA3TjVvdXVTQzJRV1N5VlBLT1g2RXd6TmZDaW5BZi92d0ZQL2FNWG8vN0JD?=
 =?utf-8?B?OHh5THdFMU5SRnJyUFBKeXBTeXpjL2NEVGkvL3JieFJvc2E4R3NqcVFhMVRs?=
 =?utf-8?B?dFpVbUUweFRFcUp3OHJNZ2ViUkxKaE5Xdlo1dmlNc0lwL0lKd1ZVOG9TMjRn?=
 =?utf-8?B?eVVwNk4xVG1BTGZSTTBHTU84d2tsdnc3LzYzOEdZeE1pZ2haRFN6bnZvZm5J?=
 =?utf-8?B?QXh0cnFGemtjNzVhYkwzMFU0RGhqMEU5cjM4Qnc1aGl1dnVpcnFSN1ZXbFY5?=
 =?utf-8?B?eUpHN0l2eWozS2RpMmRCMXo2bXB3elBmMWlPaWVWQVlPK3pQU3JxWHJDcWw2?=
 =?utf-8?B?QklOa1FqUWJLSUFFVWNXMDBLbGR4bTh5ZlZGZTRnWkM2bGtxNWNrRERveW9C?=
 =?utf-8?B?VFJVT3VNRXNLajF4QXRZS1h2SVBEakVpTUhBQnkwZDlHNjdxeVNjQUt4alBI?=
 =?utf-8?B?UktKSXo0dGpyL0ZHQjlONW1kMS9maUtCMDVlem1HU09MSjBJSkFpL3JFV3JU?=
 =?utf-8?B?aE9pVUdSMkp6VUJGWVloQUVsNmlWR0s0OFI2VEw0TnNDcC94bWhBOStoQ0Nu?=
 =?utf-8?B?cVlXOGRqc2xWaGNLUDVhWlVmRzdGdmpsK0NSS0sybmU4bi9MdXlMaDlSZFIz?=
 =?utf-8?B?a0pNa2xpQmlXZGxWWTdJT0VqL0ZBUFBEWmppTWI3ZFQ3cHVBUHg1bGpxZkl3?=
 =?utf-8?B?MWdaWndxZnFKUWx4ZzdyWUFXdUF0YnhqcFpxNmlGYW1DQVUvU0tBNkF4U1lt?=
 =?utf-8?B?UEpzeFA0bGdkM0pvdGg0OE1lZDZkdldVV0ZmdFlLOU5CSWc1SnQ1QzV2Q3h5?=
 =?utf-8?B?NzBmMnFkQ2ROVmQzcDVKM05XakJ3MVV3Yk5GanlkNmQ1dmtlLzI1bVZ2MWds?=
 =?utf-8?B?dm5yTVNiOHNhTDI3ZkVxZTdSMml5dW1VUFV1N2tVRkVNaEd6U3E5NTN3bFA5?=
 =?utf-8?B?aFZKMVZaL0dhZ0NJUlZlMU5OeVRlcjVQVFNaVEZhekRhMGx5MzBOZ1RTZDh5?=
 =?utf-8?B?bnhjYWhjSWhxOGlONWkyQXF4RXNIeFVGUUMyMzNMOVRLbzhDR09XL2hvV3Na?=
 =?utf-8?B?RHp2VU4vK2RuZG1sekNCcFh2TnZtNGxlNnhnenFIaUJrZ3FjbTBSQ0tpYkQw?=
 =?utf-8?B?T05YQS90aWxVK2dlWmU3MXE1dVpJRUtHY1VXallNblpoTmNVQ3d3elJxaDRT?=
 =?utf-8?B?RHdZL05tUDQwak9mV0FLK1RjbUIxbkJUTTlQQnVWdnpabnZ6TWMybzlDMkxi?=
 =?utf-8?B?VGNMMzNGMEhXa1hvNFZMZkdTZlQ0VEplLzNPS3RUbXI1US9KRys4MDVaZElw?=
 =?utf-8?B?OEZhWUxtL1FCVnAvajN3d3BUZm5PSE1ZTFYvVEo3dFA3RHZmcWdVRTlVREl6?=
 =?utf-8?B?SVliR2wvTjNlcmxFY2M2aElraFpQbWNkOUgrenk3MG5TcTI2REZxNTRGYno4?=
 =?utf-8?B?eHYwajY4TmJ2WnNmdGduZFpsM3MzODg1N0VpMGxJQm9lS09ZZmk0NnJKazFk?=
 =?utf-8?Q?32qvAMifh+sPtl6Nxb2Tn9v2aaDi2rWe6ad+h?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DFEE2C2D57E7043B75E440209ED23CF@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB2798.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab8c88e-4d72-4253-763b-08de54362c66
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 13:01:17.1758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GVzKNUf/Qt14RudbkTZ4wVlS2pHPLLJYzqH3nIR4F94jBy+dOk25QeVSaQv51HChcqn/V+Fp88SvBxG9uac8WL9oXPX3t7mq3Hq9Nq3k/lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB6257
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

QWRkIG1pc3NpbmcgcmV0dXJuIHN0YXRlbWVudCBhZnRlciBsb2dnaW5nIHRoZSBlcnJvciB3aGVu
IGNzIGlzIE5VTEwuDQpXaXRob3V0IHRoaXMsIHRoZSBmdW5jdGlvbiBjb250aW51ZXMgdG8gZGVy
ZWZlcmVuY2UgdGhlIG51bGwgcG9pbnRlci4NCg0KUmVzb2x2ZXM6IENvdmVyaXR5IENJRCAxNjQ0
MDc3DQoNClNpZ25lZC1vZmYtYnk6IERqb3JkamUgVG9kb3JvdmljIDxkam9yZGplLnRvZG9yb3Zp
Y0BodGVjZ3JvdXAuY29tPg0KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxw
aGlsbWRAbGluYXJvLm9yZz4NClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFp
ci5mcmFuY2lzQHdkYy5jb20+DQotLS0NCiB0YXJnZXQvcmlzY3YvY3B1LmMgfCAxICsNCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9j
cHUuYyBiL3RhcmdldC9yaXNjdi9jcHUuYw0KaW5kZXggM2I5ZDE3ZDU4ZC4uMTBlY2U0YmY2MyAx
MDA2NDQNCi0tLSBhL3RhcmdldC9yaXNjdi9jcHUuYw0KKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdS5j
DQpAQCAtODMsNiArODMsNyBAQCB2b2lkIGNwdV9zZXRfZXhjZXB0aW9uX2Jhc2UoaW50IHZwX2lu
ZGV4LCB0YXJnZXRfdWxvbmcgYWRkcmVzcykNCiAgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX0dV
RVNUX0VSUk9SLA0KICAgICAgICAgICAgICAgICAgICAgICAiY3B1X3NldF9leGNlcHRpb25fYmFz
ZTogaW52YWxpZCB2cF9pbmRleDogJXUiLA0KICAgICAgICAgICAgICAgICAgICAgICB2cF9pbmRl
eCk7DQorICAgICAgICByZXR1cm47DQogICAgIH0NCiAgICAgY3B1ID0gUklTQ1ZfQ1BVKGNzKTsN
CiAgICAgY3B1LT5lbnYucmVzZXR2ZWMgPSBhZGRyZXNzOw0KLS0gDQoyLjM0LjENCg==

