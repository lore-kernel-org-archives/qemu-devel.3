Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4D1CE7AA5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 03:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smPBj-0002Pt-9Z; Thu, 05 Sep 2024 22:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1smPBg-0002Mr-AG; Thu, 05 Sep 2024 22:59:04 -0400
Received: from mail-psaapc01on20707.outbound.protection.outlook.com
 ([2a01:111:f400:feae::707]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1smPBd-00038K-KZ; Thu, 05 Sep 2024 22:59:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uML/g68wYZH3hSPC+WXckcM8t5zj/PCAEbLVXSJJi7xWtFZIDnoANUFCsDaIGKfc08xne0a8I+NGySSVCV2QxlsSyp90n0oN08X0mqjDgFIGbfXEgy0SIuD/WEoRqMSyP27EZo0OaDU5uipW7BPUzKpJ8ATlrRitkUk38jUzE3CylPdILVy+rW+LG8BjZ/NOEB8iL/o4QQTo43s72XKClZj4QpiUrDkH6qLbj7WAfBp3n1KNrxdIuxA5drYUAqP4GU/4IAJoBOzea3BZpLv1BAuaKrG7yBhhXfnhI4iyo4AVTlO12DNxKvMGdB3Yg4oxpIenzVBshsi+VxhaFr0uWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcpG3fQFVSoyTPEq+WAKNysTcHacTzuv7OH46xG/8sc=;
 b=FTNYfv0h88RB2OVOS0RjdnP6HlckBJEV3rsfgNHFfrDV0AecAVDdN7VwNxxWDd+eUlQ4jsU7p1dOVDrnVaqQL/uvRgeOkwjNgrKSDBlMtJQriS+OaDB2bdXDk5/xL25UjsGsgcmgN3+RkE4v6+aEsmgGIv4KxEwWElwDWHCnZdgwOJHSonLGYbT781gPw8k4H8riEVfNCbI8qDQcYTNKL6DiYLCamkkx95uyumHLUWnwgFZ77Qx0if918C7xIlkhziLhzB7YaHySb6yMFzCVWEsJpc1Kd9bbav/8v9y52I0FHmQsTTGWnqcdJ9UupBVIasAG0T3NETGyJJpArVDx3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=andestech.com; dmarc=pass action=none
 header.from=andestech.com; dkim=pass header.d=andestech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andestech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcpG3fQFVSoyTPEq+WAKNysTcHacTzuv7OH46xG/8sc=;
 b=ZkTtlgNCeeqrolNbk2TACx18yVxoT8Eoa/QW3GFukaUA6RyIgoxMPEpvs/jj0aTbwJn0BUEtbAfLpTyKd17A+wx+/d/yiqU92ibDIdLrWOP1wtCi8imu2YSvh1si72RxhWFE8fb73KX04kxRr4muuf7iUhUdLeSHQ+9KTp3YCYPMmlqIYO/ikxzVA+8xdBuAROw0iTPudgjkQoHTv7TxW5D6vU+mLgf611BePhrHnMFXzDtfn+EkmBpQwt23T2v2B9EfPKvOxwWDpaplg2LN2hBtneuNEebTYcossHEwhQsOLtA5IESZsREu2T09AEygQ6FLXkoHaBrAaa9FtwxPRA==
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com (2603:1096:101:69::14)
 by SEZPR03MB8181.apcprd03.prod.outlook.com (2603:1096:101:199::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 02:58:49 +0000
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::292f:e1ce:7df8:115e]) by SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::292f:e1ce:7df8:115e%4]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 02:58:49 +0000
From: =?utf-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>
To: Alistair Francis <alistair23@gmail.com>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alistair.francis@wdc.com"
 <alistair.francis@wdc.com>, "bin.meng@windriver.com"
 <bin.meng@windriver.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: RE: [PATCH v4 2/2] target/riscv: Add textra matching condition for
 the triggers
Thread-Topic: [PATCH v4 2/2] target/riscv: Add textra matching condition for
 the triggers
Thread-Index: AQHa92I9qtoNIwkdIkmomh2Q9nvMzrJJ+NGAgAAnn9A=
Date: Fri, 6 Sep 2024 02:58:49 +0000
Message-ID: <SEYPR03MB6700780FEE9EBD51489F79F8A89E2@SEYPR03MB6700.apcprd03.prod.outlook.com>
References: <20240826024657.262553-1-alvinga@andestech.com>
 <20240826024657.262553-3-alvinga@andestech.com>
 <CAKmqyKOV=Acs4M0Yo-kQCJkJci7rZkgMb7nUe8Bxfvmry_gc+w@mail.gmail.com>
In-Reply-To: <CAKmqyKOV=Acs4M0Yo-kQCJkJci7rZkgMb7nUe8Bxfvmry_gc+w@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=andestech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6700:EE_|SEZPR03MB8181:EE_
x-ms-office365-filtering-correlation-id: dec441f4-0f88-4d9d-1de4-08dcce1fd50c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S3hnendNWU56b0tTV2svL0J1ZjF2aUxGUi8yQ2JORzNDOWZOSmQ2Mlh4SXRo?=
 =?utf-8?B?YUZwTnlrS1lZVERCbXRzSzdsbmNSMy9yQ2wwVlhqaWd0NEZieUQ4SEtiTG4z?=
 =?utf-8?B?bDF1RDBuQkRIZjdBMzdXbk1ZOFhLL3ozc1hWUTFnelg0WHFOaTMyK2kvNWpP?=
 =?utf-8?B?WEQ2L3A4QUQrTGFZN1VIY3NiM1Z2d2p1a0puQXdna3hrb3NyL052eXV1NlNh?=
 =?utf-8?B?dlllc1REbjl6QlJRc1ZLM3NHVUR1bnlNcmgyVUcvSktjbGQvcmxIVTJMREsv?=
 =?utf-8?B?OFY1bzdwaTZjYXFRWkZyNjJRRDdobWcwTGM5OEw1Mml2bFRIdTZlYmUzS0hX?=
 =?utf-8?B?SEFHZjZFVG9pdVVqTmIwdTY2d0VmS3N1Z0EyZG50TzRPdjZuOFFkQjRPSlJF?=
 =?utf-8?B?SzNxR1pKYVVSWGJYYjZlZmNWRmw2VDByOWkrVmpwWUwvUEJHZEF3L1d2Tk1W?=
 =?utf-8?B?aGZlY3JCN3poalpTUVV1cEVhUlBDL3RQUUZ3aDh3dlZxQXBSaVJDVExRTDc0?=
 =?utf-8?B?VDVVUGFIMTM2R3I3MFBoV0xITG9PMURHRzZoWXlVOWJQMEhORmdIWUlFU1J1?=
 =?utf-8?B?eEtsd3lrQmFEL3BLbmk2MkVUZEh3dUxERU1EWFFqU2xFM3lwUjB3SGk1bHpk?=
 =?utf-8?B?KzdndHkvVXlGNEJKM1lpdm1oblhSclROcnFJZWtQT2FNcHN2R21iZ2ViVEZK?=
 =?utf-8?B?Q2haWW9wbm1jZmhsOVVIZVRJSjA1VDFNcFByckx5d1piNS9FR25xTTBOTmtM?=
 =?utf-8?B?NjN5U3BuZ0c3Y0xMcWlUWWRrUSt1T3N1Uk9EN21qU0czL3A2OVRzYVVWMlVR?=
 =?utf-8?B?dlBjcGZjd2JzaUViTGVhS1ZnbVFLK2IrMWxUYVBrL252WmtacFdXbGRUdkpy?=
 =?utf-8?B?NTZ1djJBLzFnUG9pOFdIMGJ6cGdhNjBEODhLdU5UM1NKaUxOWlpnbFVaKzEz?=
 =?utf-8?B?UGtUZG5lN2wxOFpWYzJQT1RyS3VpZGd5d3ZGZnZ1MWFiVVUrOFhUVjZVQ05I?=
 =?utf-8?B?bk5teFNtNnpJYi8zckZ5MmRuWjlwWEdJN3JmeWlFL3g3ZUViYStFTkRjZjB1?=
 =?utf-8?B?Y2ZDNDM3QXVpcHoxQURPby9ucnRZYzhzeXFjcVBJZjFid3NudTdpU3ZhUU5D?=
 =?utf-8?B?ZnpDYTh1ZWxyODZzcWUwNlFQOHNOQXAwTlY2cnIyaXNZd1hYTWppdS96ZGcz?=
 =?utf-8?B?N2h2eXY2amVUcW1aTmRLbFhiQm9HdnlIRVNpVFI3Q1E5UDcxUnVFQVVCNWdY?=
 =?utf-8?B?ZEZ3TDRDK1duUlB0WWw0Q3lEd1grL21peHozdWNTUERqOHVQa0xkNERzK00w?=
 =?utf-8?B?a0hIZ294a0VOSTI1em8xN04yaHllclpsTUZhQ05MZ3JieW5nT3ZpcXU2M0E3?=
 =?utf-8?B?ZFF2SWFlbE9oc1RHeWFETzBLc0lNdzlQQTMrVjlyZllYVWErRWlneEc2bmZR?=
 =?utf-8?B?ekJnWEJPOE05WEZjNks5cm1hTzVRSkFiaDZMYzI1NmZRUUtmbnRUNDdWNGNp?=
 =?utf-8?B?d1MvcnJFaW5BR0lPWXZBWlZTa0Q2SEF5ZlM3UCtLalJhRVRzRCtmeFVURU1E?=
 =?utf-8?B?Ujl2akdQK1ZkdzZ6a01tandQMWl3S0tUblJiWkVPRHVoOGg0MmJoMUw3eVZ5?=
 =?utf-8?B?M3loemwyamtDZHIwSGFZa1N6M2ZNVWVJYWdPOXErNWRlajF5MlVraHR6ZXR2?=
 =?utf-8?B?TFpSRDU2aVlqWExFQnRta0RxdGpiMUtFakJsRm5Ec2ZyZERLdjBKd1AwT3hx?=
 =?utf-8?B?ZzNjNlcrZzdtYzBZYThBMUpPTExMRW5ORmM2Qlgzck9LVVlyVnRoc0JZN2V3?=
 =?utf-8?B?a01TQ0NsSm4rSzdLbGJvYmJhUDRBUzdrZGRsa3M0QllYTFp4bHlUZmcveWIx?=
 =?utf-8?B?NUsvNm8yNk5hMFRuaUUyUnQ3R2RkWmM4aGVzN3JHaDZleEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR03MB6700.apcprd03.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlRmTUFIL2plYTlUb2tLRHBEYmFOZUJHN3ZVZ0srSGJRSDJWSWRabmtJU3dU?=
 =?utf-8?B?M2FWNm55Tms5bk1kZldpRGVqZmIyc1hZUHlqcHpZYktQMk1FbWM2MXlXRlZw?=
 =?utf-8?B?Rk1FQWorOFJOV3dFRllVMWtZaGh1ZDlJeVVrbzQydG5OYVRmM2tNdkRFNFpq?=
 =?utf-8?B?YUs4OVgvL29rWE03L2NlMUlnelBVTEkvdjRSdWd4SVFtVmxHT1lvNVplWTMy?=
 =?utf-8?B?V3RIZ1o0NnQ3dVZoVkpOdkNTN3FJVEExSHNNQzdPSHhaMytaV0xuQ0toc3No?=
 =?utf-8?B?OWVzbWFnL0xXUUhWckRrNURXMmh0czY2N0p6N1VyTTBhRDhzeVRTSnpaVFc3?=
 =?utf-8?B?MXR3aFlaQXh2b3lFQ1RRRSszVXRWSkZMbTVFaFdVVkpMSDNUWFpreE9hd00w?=
 =?utf-8?B?UTlhVkR5aVZvTVpXL09pNzdGZjJSdW5DZXFEQ1Y4MGdZU1ZxdEN3ZXVjYm5K?=
 =?utf-8?B?M01KT2hicXRrWE9LNUhOaGprRWY2NUJmTU5zQnJZaWpJaFN0WGtkVjF2Z0x0?=
 =?utf-8?B?VldQeEx0Rnc1SWFPM3BQODJCaHRNR283dS8wQ3N6VG1qMEZWaUROZzdzYmRr?=
 =?utf-8?B?MFZKd1YxaFQ0NG9sd2JhaUloNGRIcWpkQy94MUxvbWg0ZDczcitRb0p5VGc3?=
 =?utf-8?B?cW5hU1lKSzRsQzFQc1YxSDZHcFFlL285a2czMGRSeGg0V1VoMXFEVWdXN3lL?=
 =?utf-8?B?b2VDTUxNR00zUXhSREcxWnY0UXdNYUFIU0lsVWhCYjYwQVBQTG5ESnBvVHBh?=
 =?utf-8?B?REp3TXdVa3E5eVRZMVZZWWkrUlpGY0FHMlV4N2l2R3dEd3RaNjFjd3Ntbnlm?=
 =?utf-8?B?Z0RkUWZVejN3REpXeXd0bVowbzg0a3VJcU13c29oNXF3ZDREcWdCZzhxaGNI?=
 =?utf-8?B?ZlNOa3JSaVRYQjM3aStrK2lyb3dGSnhZUjRsYlJHaDRDazZ0OXBZbU83ZXFl?=
 =?utf-8?B?cXUvak1FTG16WHJEVW43c0R3eXNoMkNpQjhMNlVZa3E2QVpuZG0yYVBxTks5?=
 =?utf-8?B?TXBnUFJrcUNNcUpnUytDeGFvUFgwSmw2RFF5Wm55K3YwOXVtRlZmVEdlQ0NY?=
 =?utf-8?B?OWVvZVFjWWdUM2tSM3FsNnlPS2hQNjU5d05UWlBsamFiVTU0c3c0OTBtOFUw?=
 =?utf-8?B?bU1oTmswOTJDeFA1VEJxMURJZEZMYU5ZaFhSR2tJLy8wZW42NStlOVlGMmZI?=
 =?utf-8?B?N0RQemE4SE00ZU1HVUhPcm55UDFHMFc2THdhQmNrc2JhdCsydG0vVVBVbm1p?=
 =?utf-8?B?blNzNUdwVEx6T09KR0pFQ1l5U0ZFN2dBeit6K1NtVE1HcU83VHRDaFZOWDR4?=
 =?utf-8?B?TVBEYVhKTVZjVXh6Z3Z3N3dVblhseEYwK1o4cTZkSHFLbEpxVW5HZ1RJd0tW?=
 =?utf-8?B?aWsreW0rZ1F2aHcvbEJRSUxXaWZGbEZ2RmRjQW16NHRTRDNxR3N0QmRLd2Qx?=
 =?utf-8?B?WEorQVBudm5CbU5NU0kwR1hVWXlpR09DNHBITUZMejRCNjMrd1FPMTd2aTRw?=
 =?utf-8?B?M0t2TDFOdm83QUR3UUlSUXh3bWdoc2FtWWk1ZCtlRmFwS29KMU56RmlpT2hl?=
 =?utf-8?B?TnhDTVZaSzUvbjFTUXdHRks3S3hMOXA1eFZiaGU3VmMvNDc2SE8rMXk4VmRX?=
 =?utf-8?B?WE9vWHhvU3NxVVpjWnFIRjl1algxMFRsRGIwT1RsV1AwQ0l4eWEwa0JML1BB?=
 =?utf-8?B?bmR2VDRzUXZsUkFWbkFpaG53K0NiRENZRDZlQUFTSDNjT1dPV0RmeXkyazV0?=
 =?utf-8?B?SFJyU2JVcVcrK1lBVnpEbnJucE5UeEtiM1J3cUVRdldYWFUvMlJaSk5MNHBo?=
 =?utf-8?B?a21qRjFORGNGUk1Jcktsei9RTlNobnd4NW5VdWdVZE5FN2szaUlSNFVtRWhs?=
 =?utf-8?B?Y3NNZ3l6TEcrdnY0OCtnMm5oTStET201RTM4U00rY3UwT0hRcXB5R1hVdUZU?=
 =?utf-8?B?UVJQZTZKVm1Ea2FNczcyTytEMXpudlRVVTdPOHBxSTdIb0ZQdFJYKzN6QVRz?=
 =?utf-8?B?cXNGaTJEa1FJWGt4ZVJqSnJiVmFabmpWTzU5NVdGRXo3Zm1YVlFHbDBLNTBJ?=
 =?utf-8?B?eUJXY1B3ZnU2Y0Nwdzdrb3BjV2FzYzd2ZWUzekhCbndxZlZOTEMyRU5IUzBw?=
 =?utf-8?Q?/c6irWs9edq02gbpFiOgSoz2O?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: andestech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6700.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec441f4-0f88-4d9d-1de4-08dcce1fd50c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 02:58:49.2927 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3ec21b7-ec6c-4041-9add-61aea8171458
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZPNV6QCFy52G1zmO9EqOIAcZHfJgrOiJD8mGUIWpYz9YxxFarkCC12Tds4tIf5VM+v9ivVYkVW6CrwZMnQeZTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8181
Received-SPF: pass client-ip=2a01:111:f400:feae::707;
 envelope-from=alvinga@andestech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgQWxpc3RhaXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxp
c3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIyM0BnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgU2Vw
dGVtYmVyIDYsIDIwMjQgODoyOSBBTQ0KPiBUbzogQWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy
5ZiJKSA8YWx2aW5nYUBhbmRlc3RlY2guY29tPg0KPiBDYzogcWVtdS1yaXNjdkBub25nbnUub3Jn
OyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbTsgYmlu
Lm1lbmdAd2luZHJpdmVyLmNvbTsgbGl3ZWkxNTE4QGdtYWlsLmNvbTsNCj4gZGJhcmJvemFAdmVu
dGFuYW1pY3JvLmNvbTsgemhpd2VpX2xpdUBsaW51eC5hbGliYWJhLmNvbQ0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHY0IDIvMl0gdGFyZ2V0L3Jpc2N2OiBBZGQgdGV4dHJhIG1hdGNoaW5nIGNvbmRp
dGlvbiBmb3IgdGhlDQo+IHRyaWdnZXJzDQo+DQo+IFtFWFRFUk5BTCBNQUlMXQ0KPg0KPiBPbiBN
b24sIEF1ZyAyNiwgMjAyNCBhdCAxMjo0OOKAr1BNIEFsdmluIENoYW5nIHZpYQ0KPiA8cWVtdS1k
ZXZlbEBub25nbnUub3JnPiB3cm90ZToNCj4NCj4gWW91ciBGcm9tIGlzIHN0aWxsIHdyb25nDQoN
Ck9oIHNvcnJ5IGZvciBpbmNvbnZlbmllbmNlLiBTZWVtcyBpdCByYW5kb21seSBoYXBwZW5zIG9u
IG91ciBzZXJ2ZXIuDQpJIHdpbGwgYXNrIG15IGNvbGxlYWd1ZXMuDQoNCj4NCj4gPg0KPiA+IEFj
Y29yZGluZyB0byBSSVNDLVYgRGVidWcgc3BlY2lmaWNhdGlvbiwgdGhlIG9wdGlvbmFsIHRleHRy
YTMyIGFuZA0KPiA+IHRleHRyYTY0IHRyaWdnZXIgQ1NScyBjYW4gYmUgdXNlZCB0byBjb25maWd1
cmUgYWRkaXRpb25hbCBtYXRjaGluZw0KPiA+IGNvbmRpdGlvbnMgZm9yIHRoZSB0cmlnZ2Vycy4g
Rm9yIGV4YW1wbGUsIGlmIHRoZSB0ZXh0cmEuTUhTRUxFQ1QgZmllbGQNCj4gPiBpcyBzZXQgdG8g
NCAobWNvbnRleHQpLCB0aGlzIHRyaWdnZXIgd2lsbCBvbmx5IG1hdGNoIG9yIGZpcmUgaWYgdGhl
DQo+ID4gbG93IGJpdHMgb2YgbWNvbnRleHQvaGNvbnRleHQgZXF1YWwgdGV4dHJhLk1IVkFMVUUg
ZmllbGQuDQo+ID4NCj4gPiBUaGlzIGNvbW1pdCBhZGRzIHRoZSBhZm9yZW1lbnRpb25lZCBtYXRj
aGluZyBjb25kaXRpb24gYXMgY29tbW9uDQo+ID4gdHJpZ2dlciBtYXRjaGluZyBjb25kaXRpb25z
LiBDdXJyZW50bHksIHRoZSBvbmx5IGxlZ2FsIHZhbHVlcyBvZg0KPiA+IHRleHRyYS5NSFNFTEVD
VCBhcmUgMCAoaWdub3JlKSBhbmQgNCAobWNvbnRleHQpLiBXaGVuIHRleHRyYS5NSFNFTEVDVA0K
PiA+IGlzIDAsIHdlIHBhc3MgdGhlIGNoZWNraW5nLiBXaGVuIHRleHRyYS5NSFNFTEVDVCBpcyA0
LCB3ZSBjb21wYXJlDQo+ID4gdGV4dHJhLk1IVkFMVUUgd2l0aCBtY29udGV4dCBDU1IuIFRoZSBy
ZW1haW5pbmcgZmllbGRzLCBzdWNoIGFzDQo+ID4gdGV4dHJhLlNCWVRFTUFTSywgdGV4dHJhLlNW
QUxVRSwgYW5kIHRleHRyYS5TU0VMRUNULCBhcmUgaGFyZHdpcmVkIHRvDQo+ID4gemVybyBmb3Ig
bm93LiBUaHVzLCB3ZSBza2lwIGNoZWNraW5nIHRoZW0gaGVyZS4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEFsdmluIENoYW5nIDxhbHZpbmdhQGFuZGVzdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4g
IHRhcmdldC9yaXNjdi9kZWJ1Zy5jIHwgNDUNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLQ0KPiA+ICB0YXJnZXQvcmlzY3YvZGVidWcuaCB8ICAzICsrKw0K
PiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvZGVidWcuYyBiL3RhcmdldC9yaXNjdi9k
ZWJ1Zy5jIGluZGV4DQo+ID4gZDZiNGEwNjE0NC4uYzc5YjUxYWYzMCAxMDA2NDQNCj4gPiAtLS0g
YS90YXJnZXQvcmlzY3YvZGVidWcuYw0KPiA+ICsrKyBiL3RhcmdldC9yaXNjdi9kZWJ1Zy5jDQo+
ID4gQEAgLTM2NCwxMSArMzY0LDU0IEBAIHN0YXRpYyBib29sIHRyaWdnZXJfcHJpdl9tYXRjaChD
UFVSSVNDVlN0YXRlDQo+ICplbnYsIHRyaWdnZXJfdHlwZV90IHR5cGUsDQo+ID4gICAgICByZXR1
cm4gZmFsc2U7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgYm9vbCB0cmlnZ2VyX3RleHRyYV9t
YXRjaChDUFVSSVNDVlN0YXRlICplbnYsIHRyaWdnZXJfdHlwZV90IHR5cGUsDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCB0cmlnZ2VyX2luZGV4KSB7DQo+ID4gKyAg
ICB0YXJnZXRfdWxvbmcgdGV4dHJhID0gZW52LT50ZGF0YTNbdHJpZ2dlcl9pbmRleF07DQo+ID4g
KyAgICB0YXJnZXRfdWxvbmcgbWh2YWx1ZSwgbWhzZWxlY3Q7DQo+ID4gKw0KPiA+ICsgICAgaWYg
KHR5cGUgPCBUUklHR0VSX1RZUEVfQURfTUFUQ0ggfHwgdHlwZSA+DQo+IFRSSUdHRVJfVFlQRV9B
RF9NQVRDSDYpIHsNCj4gPiArICAgICAgICAvKiB0ZXh0cmEgY2hlY2tpbmcgaXMgb25seSBhcHBs
aWNhYmxlIHdoZW4gdHlwZSBpcyAyLCAzLCA0LCA1LCBvciA2DQo+ICovDQo+ID4gKyAgICAgICAg
cmV0dXJuIHRydWU7DQo+DQo+IFNob3VsZG4ndCB0aGlzIGJlIGZhbHNlPw0KDQpNeSBpZGVhIGlz
OiBvbmx5IHR5cGUgMiwgMywgNCwgNSwgNiB0cmlnZ2VycyBuZWVkIHRvIGZ1cnRoZXIgY2hlY2sg
dGV4dHJhIENTUi4NCk90aGVyIHR5cGVzIG9mIHRyaWdnZXIgc2hvdWxkIGJ5cGFzcyBjaGVjayBv
biB0ZXh0cmEgQ1NSLCB3aGljaCBtZWFucyB0aGV5IHBhc3MgdGhlIGNoZWNrIG9uIHRleHRyYSBD
U1IuDQpUaHVzLCByZXR1cm4gdHJ1ZSBzaG91bGQgYmUgY29ycmVjdC4NCg0KDQpBbHZpbg0KDQo+
DQo+IEFsaXN0YWlyDQo+DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgc3dpdGNoIChyaXNj
dl9jcHVfbXhsKGVudikpIHsNCj4gPiArICAgIGNhc2UgTVhMX1JWMzI6DQo+ID4gKyAgICAgICAg
bWh2YWx1ZSAgPSBnZXRfZmllbGQodGV4dHJhLCBURVhUUkEzMl9NSFZBTFVFKTsNCj4gPiArICAg
ICAgICBtaHNlbGVjdCA9IGdldF9maWVsZCh0ZXh0cmEsIFRFWFRSQTMyX01IU0VMRUNUKTsNCj4g
PiArICAgICAgICBicmVhazsNCj4gPiArICAgIGNhc2UgTVhMX1JWNjQ6DQo+ID4gKyAgICBjYXNl
IE1YTF9SVjEyODoNCj4gPiArICAgICAgICBtaHZhbHVlICA9IGdldF9maWVsZCh0ZXh0cmEsIFRF
WFRSQTY0X01IVkFMVUUpOw0KPiA+ICsgICAgICAgIG1oc2VsZWN0ID0gZ2V0X2ZpZWxkKHRleHRy
YSwgVEVYVFJBNjRfTUhTRUxFQ1QpOw0KPiA+ICsgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgZGVm
YXVsdDoNCj4gPiArICAgICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOw0KPiA+ICsgICAgfQ0K
PiA+ICsNCj4gPiArICAgIC8qIENoZWNrIG1odmFsdWUgYW5kIG1oc2VsZWN0LiAqLw0KPiA+ICsg
ICAgc3dpdGNoIChtaHNlbGVjdCkgew0KPiA+ICsgICAgY2FzZSBNSFNFTEVDVF9JR05PUkU6DQo+
ID4gKyAgICAgICAgYnJlYWs7DQo+ID4gKyAgICBjYXNlIE1IU0VMRUNUX01DT05URVhUOg0KPiA+
ICsgICAgICAgIC8qIE1hdGNoIGlmIHRoZSBsb3cgYml0cyBvZiBtY29udGV4dC9oY29udGV4dCBl
cXVhbCBtaHZhbHVlLiAqLw0KPiA+ICsgICAgICAgIGlmIChtaHZhbHVlICE9IGVudi0+bWNvbnRl
eHQpIHsNCj4gPiArICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ICsgICAgICAgIH0NCj4g
PiArICAgICAgICBicmVhazsNCj4gPiArICAgIGRlZmF1bHQ6DQo+ID4gKyAgICAgICAgYnJlYWs7
DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgcmV0dXJuIHRydWU7DQo+ID4gK30NCj4gPiAr
DQo+ID4gIC8qIENvbW1vbiBtYXRjaGluZyBjb25kaXRpb25zIGZvciBhbGwgdHlwZXMgb2YgdGhl
IHRyaWdnZXJzLiAqLw0KPiA+IHN0YXRpYyBib29sIHRyaWdnZXJfY29tbW9uX21hdGNoKENQVVJJ
U0NWU3RhdGUgKmVudiwgdHJpZ2dlcl90eXBlX3QNCj4gdHlwZSwNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaW50IHRyaWdnZXJfaW5kZXgpICB7DQo+ID4gLSAgICByZXR1
cm4gdHJpZ2dlcl9wcml2X21hdGNoKGVudiwgdHlwZSwgdHJpZ2dlcl9pbmRleCk7DQo+ID4gKyAg
ICByZXR1cm4gdHJpZ2dlcl9wcml2X21hdGNoKGVudiwgdHlwZSwgdHJpZ2dlcl9pbmRleCkgJiYN
Cj4gPiArICAgICAgICAgICB0cmlnZ2VyX3RleHRyYV9tYXRjaChlbnYsIHR5cGUsIHRyaWdnZXJf
aW5kZXgpOw0KPiA+ICB9DQo+ID4NCj4gPiAgLyogdHlwZSAyIHRyaWdnZXIgKi8NCj4gPiBkaWZm
IC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2RlYnVnLmggYi90YXJnZXQvcmlzY3YvZGVidWcuaCBpbmRl
eA0KPiA+IGMzNDc4NjM1NzguLmY3NmI4Zjk0NGEgMTAwNjQ0DQo+ID4gLS0tIGEvdGFyZ2V0L3Jp
c2N2L2RlYnVnLmgNCj4gPiArKysgYi90YXJnZXQvcmlzY3YvZGVidWcuaA0KPiA+IEBAIC0xMzEs
NiArMTMxLDkgQEAgZW51bSB7DQo+ID4gICNkZWZpbmUgSVRSSUdHRVJfVlUgICAgICAgICAgIEJJ
VCgyNSkNCj4gPiAgI2RlZmluZSBJVFJJR0dFUl9WUyAgICAgICAgICAgQklUKDI2KQ0KPiA+DQo+
ID4gKyNkZWZpbmUgTUhTRUxFQ1RfSUdOT1JFICAgICAgIDANCj4gPiArI2RlZmluZSBNSFNFTEVD
VF9NQ09OVEVYVCAgICAgNA0KPiA+ICsNCj4gPiAgYm9vbCB0ZGF0YV9hdmFpbGFibGUoQ1BVUklT
Q1ZTdGF0ZSAqZW52LCBpbnQgdGRhdGFfaW5kZXgpOw0KPiA+DQo+ID4gIHRhcmdldF91bG9uZyB0
c2VsZWN0X2Nzcl9yZWFkKENQVVJJU0NWU3RhdGUgKmVudik7DQo+ID4gLS0NCj4gPiAyLjM0LjEN
Cj4gPg0KPiA+DQpDT05GSURFTlRJQUxJVFkgTk9USUNFOg0KDQpUaGlzIGUtbWFpbCAoYW5kIGl0
cyBhdHRhY2htZW50cykgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIGFuZCBsZWdhbGx5IHByaXZp
bGVnZWQgaW5mb3JtYXRpb24gb3IgaW5mb3JtYXRpb24gcHJvdGVjdGVkIGZyb20gZGlzY2xvc3Vy
ZS4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgeW91IGFyZSBoZXJlYnkg
bm90aWZpZWQgdGhhdCBhbnkgZGlzY2xvc3VyZSwgY29weWluZywgZGlzdHJpYnV0aW9uLCBvciB1
c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaXMgc3RyaWN0bHkgcHJvaGli
aXRlZC4gSW4gdGhpcyBjYXNlLCBwbGVhc2UgaW1tZWRpYXRlbHkgbm90aWZ5IHRoZSBzZW5kZXIg
YnkgcmV0dXJuIGUtbWFpbCwgZGVsZXRlIHRoZSBtZXNzYWdlIChhbmQgYW55IGFjY29tcGFueWlu
ZyBkb2N1bWVudHMpIGFuZCBkZXN0cm95IGFsbCBwcmludGVkIGhhcmQgY29waWVzLiBUaGFuayB5
b3UgZm9yIHlvdXIgY29vcGVyYXRpb24uDQoNCkNvcHlyaWdodCBBTkRFUyBURUNITk9MT0dZIENP
UlBPUkFUSU9OIC0gQWxsIFJpZ2h0cyBSZXNlcnZlZC4NCg==

