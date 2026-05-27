Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D40ACD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 08:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS9gW-0001Ed-Ui; Wed, 27 May 2026 04:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wS9gO-00017P-PC; Wed, 27 May 2026 04:32:10 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wS9gK-0003xi-Hy; Wed, 27 May 2026 04:32:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fc7mSrY20ZnUQDSAh/Uzeu4g77N2Qw4tjbFrojfmsyO4V8sWlZ8ZGjK5OxFjPI0OFnxspEYWDER9KJ/rnAD9kGx5iBnH59beHhUSr36OTqz7FbUZe+fZxArqg1ghxwzy58mLR4hqKV5OksipIA3MHFaCqs259Svs6skk9Cbn+7lYnF5jpB3e5gVsCrJhBOG7VFsvrnDcMwMDE+LBS8f0RElb0CU7RiYumnO2mHGVkEm+aIxI0v2nZy4zaoIJuC0/tTldusn5Ezo/saN1ilDtJCbUpy8KLkZInly77rqXcFLthPYTC7jbGH6Ckl7GdVzDS75ZdEyWk+P7teXwr8r1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzNBXPkAxlafv6DSZJPrsbEo1yIQ4uE21hrqFmZB6k0=;
 b=ylh8rR9bvC7SLT1LJbYRMW9yfwPuT5nzBFLhG4NA9ZPeDMgdNWE/AkGAQhbvcfIk/cml89aXiHLOYoqq0YbRkO51ENmtmtNAiaAZlFsjWnJ5vaWq+afhLwuHyNjBNYOIRAzze0eOrE5aaD/bqVYc47j89vvBSHKQat/2p4zx5vUlPsoQ5zAQCUO7RGJClb3B78g3KxLglLJ/cXwX5ad4UfZvVwwGn8ExScMdPV9GUDzUDTyEGNutYnksn3TSiJLaQUNI0+/IE2qMw9LZjiAtFjA1z0kMpw3J/ymNmNddkvRWTJKCkYmcDNR4SNFuE+nGurcCfhV1BStGuZDs7hOH1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzNBXPkAxlafv6DSZJPrsbEo1yIQ4uE21hrqFmZB6k0=;
 b=h+mnOrwNco/sE/gR+SShxrujxU90HFUwMsM4sTdGlQTWqPkXjbubDTUdFSM+7s8RrC39EXlvcOJaJQrNarhGxCSfc70MHU//LJA/b9smSWNtfsympHWg8ROgC6IxWQSU/YPLpZsph57uoBROKK09c7WJ88wk/tWp8q/gZ9XQTP2yqeZB/B6/MSKPktlK1/czIdOtix3PL8427/Y/Y5LMPvztzOrUW16CX9PMI9ybc5N8d44xUwu+3ih+r8wfEAJxf3E2i1Zs4wl1y2P7Ubuq/28zkATuhsJp5ZU08XYPQyU9eAapc4BYFB0oplcOl0JmJlBotSWJOkJ6pvWvHQuI1g==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by AS8PR09MB6314.eurprd09.prod.outlook.com (2603:10a6:20b:57d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 08:31:58 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 08:31:58 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v10 0/7] Add RISC-V big-endian target support
Thread-Topic: [PATCH v10 0/7] Add RISC-V big-endian target support
Thread-Index: AQHc7bNIrHYMrP0N40iRX0/KWfcOQg==
Date: Wed, 27 May 2026 08:31:58 +0000
Message-ID: <20260527083151.17876-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|AS8PR09MB6314:EE_
x-ms-office365-filtering-correlation-id: 5ae6168a-fe0b-4698-f40a-08debbca6ae3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|6133799003|11063799006|56012099006;
x-microsoft-antispam-message-info: 70RkdPm31cP1sd5oEqNrZ3bcr5Ph5xlfP889bB1M9GTSpQ+siTPPF3HGvOBcGq5FghQFmgSvd4SyHLZN55obqDUP37140Xs5fqLmq0tw7rDxn6eWmLEx1J/Sn6oweQ//41wSRM1ZeOCyC6Oo1pCR2PHw+NAgw/NTWW+cmCNW5aB1OEvKiKXCQ1P3cIqGB1qmRYgEZnJhUygC0WRCLJkkjDe+7YFjvyoRci0xx907i0v/VqHpW3RWO4gjN3DSPHmndNxwjzqMaI6H6Uam51tEkFwBnkBNqTz+cOZmxr/KUguLfXqVlzBjMm+K9hsn21bHfdC/K1+wNJPjpWKPZLJORVu+PAnmRQAOeoyTg8Ua7lM6Ne0lXzz7VeG4WbgP0pSl3bO8q8h21Ef/HZXl8vRJnjioDfB4mCMvGFlu+zsMwVIJqJl7O7NQH+ufWAF701gG6CYxwFvCZbERqpeuBLKePrYujqGlXh9t+Yk8lOIR3uHEWgEVK9RKCCc+ZNy70QOfeUdo5tHkvlOlPTBfrgypMXASs3kPkVWGMXhbO8MSeHClpcDlCk/0NpuvL3CzAICedJApmyMILLqkXQixQGngeYefg3J5Hd/jD+2thJqJZ8owG41yC8E2HJePS8rUzmhO+B5HS4D0pXD3IH331cY4KhhKy2hxboLPkAaZdu1ZW6YaGTHUl64HcUeORO2YdPcpG0e64Qm03qs9nXQB0X9v960mtp8J4HLSVp93pVSKDVQgEKNeZC5s9ZbXxIl+mqyo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlU5MWlOZ2xUYkxYMGRJbUdWYWVrS1dUaklDcmhBYVJwNlhXZ0poK2MyOEdF?=
 =?utf-8?B?VU83eXBUNFRZdTJhVFpYMHRLZ2FlTk54VVFTSnl3TmNGbXpIbzlYb3hDTjJn?=
 =?utf-8?B?S1RKNGwvYzVGVEYrUXZBc1Qvait1MW1jZzBBd28wNG11STdmL3JmN0trV1pr?=
 =?utf-8?B?aC9QVVdKbDF2clhZMzgzSnRId0daYnZkSVMycWZMVEpVenNFY1I5UTBwUEVB?=
 =?utf-8?B?OEhJOWpmTU5xVmhUMWxheFdaMW1ST055a3JjTURVRTdmeHh2clRtUkNRMEpS?=
 =?utf-8?B?TlFSTlZzbk5lV2pUSXU4N2dMb2VvYll3TlJzeUlOK2pPczhPYU4xazhSTDhw?=
 =?utf-8?B?d2RpSEVITzBQazhoNFY3Ujk5ZUpBWWdsUFM0WXlKMGtSVU9BQ29TN29ETzlT?=
 =?utf-8?B?cysyQS9IOTVSSjZxRkdJbXVpREhHaTBJbWgxR2VEMkhtWjVUaHpNbVZkcVVD?=
 =?utf-8?B?V2JMYWM4TC9tYWRkWlNBU3BMTEtXWld5aVBvQjhjam9BTkJYNFV6cnJjVUJG?=
 =?utf-8?B?azN3VnhOdWFuL29jNk5BVjNjNEdBVDVRMldiNHJJUTlheW5kUmFIM3BSOUdw?=
 =?utf-8?B?c0FxNlhVNVlHSmt0RnZrMTdQYTE5YmVrcWhEWWEyWmZzV1NHRnlTOXRidS9O?=
 =?utf-8?B?RlFqWHBScXVRVlovQlBCeVQ3S1ExckxZT1BQbG9ONzNwRWZmWjcxenlQWEJ1?=
 =?utf-8?B?VGdqUFBjQ2h3UkNTbSs1dkhHdWJxUkJRaCtLbXVJdjlzTWpnRDVxSFlEVGVV?=
 =?utf-8?B?MkhBQjQ5Wk0venJMZHU3Nm1FRW1jVGNieWFSMVdJdTlVLy9sZng4eDcwdDlK?=
 =?utf-8?B?K2Z2UTRWeE80bmh3djhNVU1zUGJBMldUdVpYMnV2czk1d2RNYUVvblJqYXpy?=
 =?utf-8?B?YWZPRFF5T1hDeWNISHhPa09jT2w2OTBFRmwxcXVmeTJjYzBlTEd2UDVMS2Zs?=
 =?utf-8?B?Q2dHTklDREVlZFRyU3k4S2c4M2NJS1lkNVZibmV2eExoME03bjRlM05HS0F4?=
 =?utf-8?B?NWNib2I2Nk1VeUVvYi9KWTUzVXdrZGRkZ1IvTXZTMWQrc29SeVBHUEJta24y?=
 =?utf-8?B?Y2NHYVA2TERvdENQQzl6eGNLSG14Um9udytBRUNwUkRTWXBXSzdJZEtBb2FT?=
 =?utf-8?B?YW5BNE1RYmtQZGJrbzZxZStYc0tTY1Q5eWJ3Q3dsYTQ3TU9YbWk5RWNnbkdo?=
 =?utf-8?B?NWpQK1ZBSHpoaVp5NkovMWF4UVo2dUFOdlBKMVZubzN2QWhFVjVGN0FOc1NT?=
 =?utf-8?B?NmQyNCtsTmczQkcrU3dHN1Q3NC9OSW85U1lMazBUdmozMVNTSWlXL0dHaUlO?=
 =?utf-8?B?VnVwdlBydExMb3BvYlVnTDY3QXkwa1lwZDdDUjhiazc4V1BKMzJPZnl4OEhp?=
 =?utf-8?B?bmlyTnhTZXR0S01WRG9WYU5nK1V1WlhtakQ2ZVFUUzRFQWdXQkJOUHJiSGFx?=
 =?utf-8?B?NzlIVWcrb3FLalhBa3JlVWo4WDJqT2ZCQnFER2dyeHQ5V0t3WnZiVmpuNEVa?=
 =?utf-8?B?YS9vcllNazVZenR1MDJlc2FkNWQ1c2xCSXg0ZlQ3TTB5NWozS0h3S2ZYYUVm?=
 =?utf-8?B?Ry93eTlNSlNCamhNQ0xublhSNVNva2RFVC9VUFkzQi8vd3BrOStPQ1Y2MjIx?=
 =?utf-8?B?M0htM011VmYzTXlNSnFpUFJHSEo3cm56dUVyb0taTjY5N2xYMlowZHRCeFR3?=
 =?utf-8?B?THlKMy9CcGU4UXRUc2ZkQzh2UU5hL1FBUHJDSCt6dVk4UktGeEJXNTF1NG52?=
 =?utf-8?B?cVB6bmQ4Nnd0NndXMi9tbEs2UTcxdW1OellyQmovekdibFVkQzdVQWtueUFj?=
 =?utf-8?B?Z2FSZkg4OFluZkZOaDZrRmIxV0cyZSs5S3h6Z3oxUFROTllsK01BTnJzQmNG?=
 =?utf-8?B?d2N1emdiZzlpWFFDTjhuaHZwMWZDNjI5VExWRVVaTC90dTFqYlg0aDlTRDFn?=
 =?utf-8?B?TFNBNStwOS9ZQitrUExyZ3h2M2lXUytBZDNETWZVOEJiTE1ZRThrR09sdjc2?=
 =?utf-8?B?T1IzNzRnUFRPdlRTZi9RY3lLL0dENDVFNzU5Zm1Yb0gzSnU1WXA0T0dCS0RU?=
 =?utf-8?B?Z0dFaXNaUTlYM25VTDF3RFdrd1p3NWE5SDB2K3RqTmJEeEl0Wk41bVdKT2Jz?=
 =?utf-8?B?ZTZ4ajFNbklkZHExRmJTQVlxcFYrdXlGK3ZtZk1Ya0xxd0p5WnlZaU9HUmtN?=
 =?utf-8?B?SzZrbjh5TVVlQWlldm5FRWdvRmdCWGY0TmFYQU9aNUQwbmNnaTNlMzZSeEtL?=
 =?utf-8?B?c1czMEl6ejF5MS9KQ0xyT3BUNGFxMU5MWEZVV0FxU05aVnU1dEh5RXhYVE9C?=
 =?utf-8?B?czE5dEVSNnpmUk9oL3puaE0vQm9UMFU2bThob2lZRGtNVVBNUS9pbFVuZzh0?=
 =?utf-8?Q?JbFwQ36o46LmCGmDXWKdvzn4UxLbacvToDWKT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C52FCB14AA3C204386C3F90AD474E0BE@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae6168a-fe0b-4698-f40a-08debbca6ae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 08:31:58.4088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EolRZKTe0LmcbDVnzVVosybfh3wTiwcwZIHaxKlyX1B71BbGoD3jJpmDs1u/0lXahyIaBuQdWwAyLlb62TvJoW+0JZ5lEXXvSxVzaYiVofU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB6314
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

SGkgYWxsLA0KIA0KVGhpcyBzZXJpZXMgYWRkcyBiaWctZW5kaWFuIGRhdGEgc3VwcG9ydCBmb3Ig
UklTQy1WIHN5c3RlbSBlbXVsYXRpb24uDQogDQpGb2xsb3dpbmcgdGhlIGRpc2N1c3Npb24gb24g
cHJldmlvdXMgdmVyc2lvbnMsIHRoaXMgc2VyaWVzIG1vZGVscw0KZml4ZWQtZW5kaWFuIGhhcnRz
LCBub3QgYSBtaXhlZC1lbmRpYW4gaW1wbGVtZW50YXRpb24gd2hlcmUgc29mdHdhcmUgY2FuDQp0
b2dnbGUgTUJFL1NCRS9VQkUgYXQgcnVudGltZS4gVGhlIHJlc2V0IHZhbHVlIG9mIE1CRS9TQkUv
VUJFIGlzIHNlbGVjdGVkDQpmcm9tIHRoZSBDUFUgY29uZmlndXJhdGlvbi4gVGhlc2UgYml0cyBy
ZW1haW4gb3V0c2lkZSB0aGUNCm1zdGF0dXMvbXN0YXR1c2gvc3N0YXR1cyB3cml0YWJsZSBtYXNr
cywgc28gdGhleSBhcmUgZWZmZWN0aXZlbHkgaGFyZHdpcmVkDQp0byAwIGZvciB0aGUgZGVmYXVs
dCBsaXR0bGUtZW5kaWFuIENQVXMgYW5kIHRvIDEgd2hlbiBgYmlnLWVuZGlhbj1vbmAuDQogDQpU
aGUgdXNlci12aXNpYmxlIGBiaWctZW5kaWFuYCBDUFUgcHJvcGVydHkgaXMgZXhwb3NlZCBvbmx5
IGFmdGVyIHRoZSBkYXRhDQpwYXRoLCBib290IHBhdGgsIGFuZCBwYWdlLXRhYmxlIHdhbGsgc3Vw
cG9ydCBhcmUgaW4gcGxhY2UsIHNvIHRoZSBzZXJpZXMNCnJlbWFpbnMgYmlzZWN0YWJsZS4NCg0K
RGpvcmRqZSBUb2Rvcm92aWMgKDcpOg0KICB0YXJnZXQvcmlzY3Y6IERlZmluZSBNU1RBVFVTX1NC
RSBhbmQgTVNUQVRVU19NQkUgYml0IG1hc2tzDQogIHRhcmdldC9yaXNjdjogQWRkIGJpZy1lbmRp
YW4gQ1BVIGNvbmZpZ3VyYXRpb24gZmllbGQgYW5kIHJlc2V0IGxvZ2ljDQogIHRhcmdldC9yaXNj
djogSW1wbGVtZW50IHJ1bnRpbWUgZGF0YSBlbmRpYW5uZXNzIHZpYSBNU1RBVFVTIGJpdHMNCiAg
aHcvcmlzY3Y6IE1ha2UgYm9vdCBjb2RlIGVuZGlhbm5lc3MtYXdhcmUgYXQgcnVudGltZQ0KICB0
YXJnZXQvcmlzY3Y6IEZpeCBwYWdlIHRhYmxlIHdhbGsgZW5kaWFubmVzcyBmb3IgYmlnLWVuZGlh
biBoYXJ0cw0KICB0YXJnZXQvcmlzY3Y6IEV4cG9zZSBiaWctZW5kaWFuIENQVSBwcm9wZXJ0eSBh
bmQgYWRkIGRvY3VtZW50YXRpb24NCiAgdGFyZ2V0L3Jpc2N2OiBBZGQgZW5kaWFubmVzcyB0ZXN0
IGZvciBSSVNDLVYgQkUNCg0KIGRvY3Mvc3lzdGVtL3RhcmdldC1yaXNjdi5yc3QgICAgICAgICAg
ICAgICAgICB8IDI5ICsrKysrKysNCiBody9yaXNjdi9ib290LmMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCA4MSArKysrKysrKysrKysrKysrLS0tDQogaW5jbHVkZS9ody9yaXNjdi9i
b290LmggICAgICAgICAgICAgICAgICAgICAgIHwgIDEgKw0KIHRhcmdldC9yaXNjdi9jcHUuYyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8IDE1ICsrLS0NCiB0YXJnZXQvcmlzY3YvY3B1Lmgg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAyMyArKysrKysNCiB0YXJnZXQvcmlzY3YvY3B1
X2JpdHMuaCAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArDQogdGFyZ2V0L3Jpc2N2L2NwdV9j
ZmdfZmllbGRzLmguaW5jICAgICAgICAgICAgIHwgIDEgKw0KIHRhcmdldC9yaXNjdi9jcHVfaGVs
cGVyLmMgICAgICAgICAgICAgICAgICAgICB8IDI4ICsrKysrLS0NCiB0YXJnZXQvcmlzY3YvaW5z
bl90cmFucy90cmFuc19ydmEuYy5pbmMgICAgICAgfCAgNCArLQ0KIHRhcmdldC9yaXNjdi9pbnNu
X3RyYW5zL3RyYW5zX3J2ZC5jLmluYyAgICAgICB8ICA0ICstDQogdGFyZ2V0L3Jpc2N2L2luc25f
dHJhbnMvdHJhbnNfcnZmLmMuaW5jICAgICAgIHwgIDQgKy0NCiB0YXJnZXQvcmlzY3YvaW5zbl90
cmFucy90cmFuc19ydmkuYy5pbmMgICAgICAgfCAgOCArLQ0KIHRhcmdldC9yaXNjdi9pbnNuX3Ry
YW5zL3RyYW5zX3J2emFjYXMuYy5pbmMgICB8ICA0ICstDQogdGFyZ2V0L3Jpc2N2L2luc25fdHJh
bnMvdHJhbnNfcnZ6YWxhc3IuYy5pbmMgIHwgIDQgKy0NCiB0YXJnZXQvcmlzY3YvaW5zbl90cmFu
cy90cmFuc19ydnpjZS5jLmluYyAgICAgfCAgNCArLQ0KIHRhcmdldC9yaXNjdi9pbnNuX3RyYW5z
L3RyYW5zX3J2emZoLmMuaW5jICAgICB8ICA0ICstDQogdGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMv
dHJhbnNfcnZ6aWNmaXNzLmMuaW5jIHwgIDQgKy0NCiB0YXJnZXQvcmlzY3YvaW5zbl90cmFucy90
cmFuc194bWlwcy5jLmluYyAgICAgfCAgOCArLQ0KIHRhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3Ry
YW5zX3h0aGVhZC5jLmluYyAgICB8IDE2ICsrLS0NCiB0YXJnZXQvcmlzY3YvaW5zbl90cmFucy90
cmFuc196aWxzZC5jLmluYyAgICAgfCAgNCArLQ0KIHRhcmdldC9yaXNjdi9pbnRlcm5hbHMuaCAg
ICAgICAgICAgICAgICAgICAgICB8ICA5ICstLQ0KIHRhcmdldC9yaXNjdi90Y2cvdGNnLWNwdS5j
ICAgICAgICAgICAgICAgICAgICB8ICAzICsNCiB0YXJnZXQvcmlzY3YvdHJhbnNsYXRlLmMgICAg
ICAgICAgICAgICAgICAgICAgfCAyMiArKy0tLQ0KIHRlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC9t
ZXNvbi5idWlsZCAgICAgICAgICB8ICAxICsNCiB0ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVz
dF9lbmRpYW5uZXNzLnB5ICAgfCA1NyArKysrKysrKysrKysrDQogMjUgZmlsZXMgY2hhbmdlZCwg
MjYwIGluc2VydGlvbnMoKyksIDgwIGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCB0
ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9lbmRpYW5uZXNzLnB5DQoNCi0tIA0KMi4zNC4x
DQo=

