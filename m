Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C532CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmif-0005AO-2g; Wed, 03 Sep 2025 08:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1utmid-00059l-0u; Wed, 03 Sep 2025 08:36:07 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1utmia-00052j-Mn; Wed, 03 Sep 2025 08:36:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiPB+brdAZozATB6YPcfS936cw3RAaoGP7ubX7c1I83TQq0Ji5/ioMDP+crf2t2U6iTTzS8qsbunob0NRqoR21mE8G6G2QR8JPd5uYEoUnl0uTfqjmDpbPyEiKMP8UeOrwl7OrL8w2Ff2ayieToxSoFhwu0xATmvMsvetqFyuwn4jK1RA7CRo77B4S1aOnTvIOXtROxQqcd/7WydG9qtbqrKSk3gZLi8+6F2ecTSAwC70mxqOZYMlRqD2cHVfJGvELfgz0Vk0g8jyEp7uC5fKe8WfWkI4kdr5xiJOwbbW8fVnPO8wkyCY+z6JJJ8utdcTK+KMbaISFt85vMTxi5rwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZ607DHvILc89lVBdNiDZ5SVgviJpdkqrxlPb+QWHNA=;
 b=LQNBFgMOUVtpfVbH8QQGNF6/emzi3F+hydToP9AJVVtx7BfnZYlOxhHQRW/c11vLvfw5MmJh2pPg3tx1tqf+L/3OzToYeDnhNZCpTVUcJcyhqaEqUPh1Lu/bx/Ex4Y7ihFUMfZUa5QZkndgBDA34sSogvexp82rlclUiKXN9yO81DHUrf25UfghciBEyP10koxBA7MbjbicI3zDzjqlOIZDUvQAhzJkY37aiKpWrhOXRoU/m9BwGW0pRAOwvdLXSloLvWByLv8oSl3vMU/ED1bL6aAx2iDuKH0dnLUEWPemd65c3J5BYgvPHQty3oWzH64P4+PUCxyb+jjj78/SIvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZ607DHvILc89lVBdNiDZ5SVgviJpdkqrxlPb+QWHNA=;
 b=NNNENrLDFXrgRW6BNTTkokAjYG0isHYh+PG1ZI9sura8Np9dEzVc9Dl6sjujqFza4vI64vaTgfeQQDHsjr/vxH3FXPqVZ4LdPkP2DCCkrPjjsAUVuAJX8bHLCCgKILVo+oe8CMY6Gvmd5dzBblDUbddnj+r0IIyLLHpwQcVH73E96pCMQc/dgHJbxkxVvm2y1LgQOFrL0ioHMwPyo18xI5AncH0UzUIxj60x2RnQb/RQqkukqIbbhe6P5OC5nTNxj6dduU3MR1KslwAWbvtNUr9tZ1v8+7ijUdgN/XDpG/tiAKbulElYXHwuQZ8wIBiHkMn0mQ/bssm/mdxP98dIXw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA3PR09MB7911.eurprd09.prod.outlook.com (2603:10a6:102:4b1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Wed, 3 Sep
 2025 12:35:56 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Wed, 3 Sep 2025
 12:35:56 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
Subject: Re: [PATCH v6 01/14] hw/intc: Allow gaps in hartids for aclint and
 aplic
Thread-Topic: [PATCH v6 01/14] hw/intc: Allow gaps in hartids for aclint and
 aplic
Thread-Index: AQHb9v6UHa5Begn5/ESGcxg9plOYvrRZCs6AgCU40YCAAC8ngIADPdKA
Date: Wed, 3 Sep 2025 12:35:56 +0000
Message-ID: <4d1e75d9-13b1-4fb8-b1f9-4917dbfb2415@htecgroup.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
 <20250717093833.402237-2-djordje.todorovic@htecgroup.com>
 <5f0fb254-fa9c-4e29-a848-6e9b3bc8274d@linaro.org>
 <046d60ed-aa62-4357-a812-721de3412573@htecgroup.com>
 <ca5816d3-a0e7-4460-aead-8f0dbcb4bc92@linaro.org>
In-Reply-To: <ca5816d3-a0e7-4460-aead-8f0dbcb4bc92@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA3PR09MB7911:EE_
x-ms-office365-filtering-correlation-id: 4a29cdd0-5542-49a8-2f34-08ddeae66dd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bUxsKzZXc1N1dzNycVM5NytRc3JPTTVQUS9SMlRXQUZ0OXl1aUt1Q29GZm5E?=
 =?utf-8?B?a2RDQzVzYm9Pd1dkaXl6ZEFaZTY0dTJucEcxMzZPZmRyZUdkZ3RXTldCcHV3?=
 =?utf-8?B?R1I4endkTkRIYVoxM2RwSVVDbzRFeXlTdmI3K0FtdkNlSVpkRHY3NWUrMHM4?=
 =?utf-8?B?TUkxY0hHYXNNbmRMK2VYby9KZCtVS3Z3YUFSUWVCYVA1dFhLYWY4M3VrTHlD?=
 =?utf-8?B?dGtSalZLS0tnS0h6UEdQcW5Cclc5di9KR2NJQTI3aVU5Yy9USXNNTjhSd1pp?=
 =?utf-8?B?dk52WCs0cThZUGFUalFweFZkczRwNWdGeWxGNlQzbStPc055dkZRV00rNlIz?=
 =?utf-8?B?VGlnWk9STTFZUXdPeWt0NjF5czV1TUJpSTZaNHAzOWhWRVRvOVMvbXBvTnQ2?=
 =?utf-8?B?UEppZXVrSTluNEk5L3VLdnZQNVFIRTRBaStXb3R0ZnpuQzIxWGxuSVV6NEla?=
 =?utf-8?B?SUl2THY1cUx3MW54WE0vSlcrNmR3L3Y2WjNSRHBac3BZL3B0WnBhMjl1OXdJ?=
 =?utf-8?B?RkIxWUJXRFVkcjlVOUtSRzh0SnM0TGl4UkJFYjkvYUticTJMcndEbVRobFBV?=
 =?utf-8?B?Y1dLZ2VYVDYzWHVJNVhVeVMzTEM1WUFnNjlYNGdpL3dxd0RMTEdYVkhiQm15?=
 =?utf-8?B?aHBJTlFyWDZibWxRU3FhdVYrdTE2MGhqVi9aSjd4SmVVRVhhNHBXQ3d2WmlL?=
 =?utf-8?B?RzRKSnI5cCs3L09kTkkxU0pvZHppMzdvL2dMK2xHbHQvYk1oU3NVaUd4WDFG?=
 =?utf-8?B?bkQ3c01McTVCY0syanJJQmthVFVXSWdudkhXa0Z0OWx2VVdTcW5PN25HZE0y?=
 =?utf-8?B?ckUrcHJrVDlCSUZxOTBSd3YrY3Z3YXVsdlRIV1llS0pXOGZwWkxITWRZdGJt?=
 =?utf-8?B?Q1IzT3J0VkhobEk0a1JEWkJnSng0TWlFYTRsSkM4aUwvQWhrQnM3LzM0Tm9h?=
 =?utf-8?B?bGFNQUozcEl3c3RnN0N4TE0yT1YvNlVkNEYwRHZWd2ZDRkNNaWF4TEluWHY4?=
 =?utf-8?B?SlZwVFM2dUZBbzF0T3EzTUV4Y2JVUVJseE11Y2xISkZMYVVLTzFXK3AzU2p5?=
 =?utf-8?B?TW5Yb0t3QUJBd2tYY3lVNXVhbVdJQXFPeHk0YVdReU1NYTgyTjJaVVIxMEg1?=
 =?utf-8?B?VEVlK1AxM2NPSkp2SFlqSGRmaE1KcGFjOVhLaElaVkIxajFURXludTlKTXdk?=
 =?utf-8?B?WXhDaWh4ZUswN3JJOHlDMndYd1NhQnRkY3ovem41TEY1WU1QbDZOdjFxUzZY?=
 =?utf-8?B?UEtYazlLV2x1c1J2T3NyYWc0T3gwRjVzYk9pS2RJUXY3akQ1U0ZYUzlFWGcx?=
 =?utf-8?B?RUcyYnJqSmMyUjg5RFJuM2xweldPbFljOGgxN0Rxb2czYVl3SzVjVWRnOVEx?=
 =?utf-8?B?Z1M5UW1kNGVLOEtEU2xZbXdQNlNKeHhmNW5qUUMyUnQ1elhKcUN3YnVGbTFt?=
 =?utf-8?B?eVQxYmJ0czNZQ0dhRVdLNC91TnRTOWdubnQyaWxoakJhbjFYVSs2MU4xYVFB?=
 =?utf-8?B?aTQ4dnplWUdzaU1zY0p0YktVVE1DMkxGeXYrQXRxQm9KSXdBNzl3SGdkL2Mz?=
 =?utf-8?B?dWZXaTh0ZEUzd2xZTjJsVmZDMG9zQ0Voc1kwOGYvTlpQOEVGTkhjMCt3UjZE?=
 =?utf-8?B?OWxQcmlMQ1llZHd6RUoxYXJ0aGZMWEMwelBYWVRySE11RXVucm1DWG9Ub3cw?=
 =?utf-8?B?d2lEck80cEpIK1dUaE5pL1BFdmhSdjUzZlQ4VDNkbElJYytOMk5Qb01ha0JR?=
 =?utf-8?B?azBSeElZeFpNQjBTRFNsMDdZQmJwdUpiRzBpNVBRRE94RGFNNjNDQXd0U3Ny?=
 =?utf-8?B?TzJzR1lOdXNVWmt1eUowektTN0lidG84eWxlS3NlTkhqWUJBWWVUUVY2VEFU?=
 =?utf-8?B?NUxLdzB4VDNwTkM0N09FeHV6ZEFsQ0NmUlpudlBDS3lRNXVGckRkckkxZzlr?=
 =?utf-8?B?QWJzK2h0MXVoWlBXemVKclhwUm5YNkh4Yk1sbUJOWXZMWmFsTEw4bGNNK0pM?=
 =?utf-8?B?eS9GSU5QLzdnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFVTUTA4RllwQXRwbXJQQlFYZmd5bHdacUJwWkRvdW5XenR0eUhGOGdSdXhp?=
 =?utf-8?B?azRrbVpmVzY0aC8vWEZUSDNNMUQ4dGRwaGJ1VS84TEswbzJ0a1U0MTg5NG5E?=
 =?utf-8?B?RmQvQThUVFRHajBjS2JrSG5rMHNJR2d2UUhFZkZQSDJ0OHMvYW9jVlpLOWhh?=
 =?utf-8?B?cmtjLzlBaW10OWRic1VnLzlybVVwRzFmUy82aDFuZ3UvWEp2NWVKYnlyazdi?=
 =?utf-8?B?ajBGUUlldVpFTVdTazZYNW0vWVV0RnA0Z0dCZGJJRkJvMituYXkvZXdWd1Jl?=
 =?utf-8?B?b2dKRjlvcXBrcjVaUTQvT3FnVDFyUnc2dVkrWm1NUkFoV1FWQmYxWCtJYTZB?=
 =?utf-8?B?Vk50VndkMWt3aDJRTS9TWmdZRzBjM2xlY3pMc2hqK0VTcXNUd3d0b0tNS01D?=
 =?utf-8?B?SnVoRTNkK3VQaHVrWG42UDJDRmJRRk45ZkFrN2oxTlJmUkxMVXRaM1JodVVa?=
 =?utf-8?B?TTFjUzhJZGx1TWE3MVFNZFp0cWlKSXBFZjk4akVwZTVHeFdhWGg1VkpwbUto?=
 =?utf-8?B?QzAzcEFRWmZjOW1aUjNadVZxVk95OWhwTTQyWXZJdkdRcnRlYTluTFNCVEpX?=
 =?utf-8?B?cnROU0pVcVFrN0UvNm9CWFVOcStoWGIxWm1MWm4xTUxoaTJLd2poZ3FjSWJX?=
 =?utf-8?B?ZlNPR0ttZ3NINzA0Rm1nL3JNM3Z2UGJHY1BNdUJNODRiZGh5alN5S3FIa1V2?=
 =?utf-8?B?Y1FZVGFIQXRVSEZ6TTkrbGVGdWVML0xvVlE5ckJIQUsrQUl2MzRiZTJGK3M2?=
 =?utf-8?B?ZlN0TVJYZEl5eHg1NUptQms4UlNxVXBDVU11R0oveEdOVXJMajh1SWRIdkFz?=
 =?utf-8?B?cEd0R3FUZGNxR0N5NVZUZXdIMy9mbXlObk9mVzk2dlhUOUdZRWFYOVJZYzhL?=
 =?utf-8?B?Y00rYjVsWUVLMEFmZGs1d2RmdWc3MStuWXgycVJJTTBjWXdxVkRhZU1icEZn?=
 =?utf-8?B?YVo3YkVJNUF6QU1WZHpsMVk5MlcrbkJJdHJ0UzVIUjNWTk5LM2VKc3R4UmZz?=
 =?utf-8?B?WG5KZkNjQWMxeFE0SjEyOG9JYTVTREtjTUJibysyaTdJT2NuTXZQamRxSmdI?=
 =?utf-8?B?Y3hsZ0h0QnYxM1BpWjFWNFpMTlNRaHdZRWN5WUpZQlYyKzk5WnFJMzBUVkRw?=
 =?utf-8?B?bTdMMmZRUlh4UDNZNjF5UENlOG8xL3lvcUR5bkkyVnVvUXQwWG93aklwM29z?=
 =?utf-8?B?ajVQMGRuNUo5Z1hORkRyL0NKT2xsaDk3WjREb2VScWpPQUU2QTRuYytBVjZ4?=
 =?utf-8?B?dGc1djFlZXkzb1k3R0VlMHU2dytaSm5nRVpyOXZjWG9EMGg5ZlphbDRaRjJw?=
 =?utf-8?B?bzg3MThSNzc1ZGZLZkVwdUZXMXJiRnVpNmJtUWpTR3R0YS84S0VmcmdieDF5?=
 =?utf-8?B?ZStRRE5QVnM1YVFmdTFGcnBwVGRFUWxSL29YSTN6MlQ3VkRWeFBBMG9Ta216?=
 =?utf-8?B?SFY4bUV6OG5WRUdKQU1lMTZUVVFKeXhlQkVqQUdXWDdCMC9WbWZIazNWVFRQ?=
 =?utf-8?B?Tk1HYm5LbzBhYVN1cjB4MzQyWXg3QjIrN0dJYXZ1UHFRdHpFS1NjMGovbmVl?=
 =?utf-8?B?dnVodEZIRGh1NWdDTmk4SHZqK2V0OVdEZElkUis1a0dZK01vVWNNTXc5Q3dK?=
 =?utf-8?B?QzlQUDIrUGtWbzZhTXZUTWRRMnRWY2g3MXBNYVlob0NtSlFqcjc5NmxPMjVL?=
 =?utf-8?B?NENsWHNUTmlZbmxMWUYzMWVoZi9BZ1gxTjdJNFhYWFpjOHFMNGJXN3hhUFpo?=
 =?utf-8?B?S0ptcnNUUHltelRxNDdyVksvYlZQNXRBQ2E3dWdYSWRzMU1ySCthOVlFUkxK?=
 =?utf-8?B?dEIyQ2RiU1ZLWlFmMzkvakFWZWZxdThVbS90UlBiNzkyZ1BicFJMY0NJandt?=
 =?utf-8?B?ZUJ6Ni9VZ0NQaWtVRXY1QTRHLzJvV3VhTEJpUmEwSHJQYll1MDdtMHgwdnl3?=
 =?utf-8?B?Uk90Ry81OUMyWklESGpDMGNlVjBISFJlK1VHaU1kbDliUHpJRFlpekZHTVhK?=
 =?utf-8?B?cW1HTWFIc0VwR2swVEtpaFkycEszWkhUZG0yK1JNYUwvL01VUmticnBIOEh5?=
 =?utf-8?B?ZGNEQmE5WHJlQ2ZrWjdsMVNmbTFBRDk0ODJHYUJ0NzBzWjZuV0xrUDJIL0ha?=
 =?utf-8?B?NFRuN29vTW14cDEwN3NpRElSZEFuVElzTUU0eTZtaXhwL280NmFOSUJHdHRL?=
 =?utf-8?Q?0k1L6F0ncRRK1Jug1VeAQ5k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F2048694325394DBF1B400284B47C97@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a29cdd0-5542-49a8-2f34-08ddeae66dd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 12:35:56.1700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k8sF6Bhmv6ceMmL4Al/t7nKi6mGQ/ux7E/d3IN4CLmdIKghWLYY7IRUg9TCf0ps69R5fO9UCccot94/WsPBSThT2XILrnE/H2QU3/qimgBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR09MB7911
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

DQpPbiAxLiA5LiAyNS4gMTM6MDUsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBD
QVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6
YXRpb24uIERvIA0KPiBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIA0KPiBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZl
Lg0KPg0KPg0KPiBPbiAxLzkvMjUgMTA6MTcsIERqb3JkamUgVG9kb3JvdmljIHdyb3RlOg0KPj4g
T24gOC4gOC4gMjUuIDE3OjUyLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+DQo+
Pj4gQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3Jn
YW5pemF0aW9uLiBEbw0KPj4+IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXINCj4+PiBhbmQga25vdyB0aGUgY29udGVudCBp
cyBzYWZlLg0KPj4+DQo+Pj4NCj4+PiBPbiAxNy83LzI1IDExOjM4LCBEam9yZGplIFRvZG9yb3Zp
YyB3cm90ZToNCj4+Pj4gVGhpcyBpcyBuZWVkZWQgZm9yIHJpc2N2IGJhc2VkIENQVXMgYnkgTUlQ
UyBzaW5jZSB0aG9zZSBtYXkgaGF2ZQ0KPj4+PiBzcGFyc2UgaGFydC1JRCBsYXlvdXRzLiBBQ0xJ
TlQgYW5kIEFQTElDIHN0aWxsIGFzc3VtZSBhIGRlbnNlDQo+Pj4+IHJhbmdlLCBhbmQgaWYgYSBo
YXJ0IGlzIG1pc3NpbmcsIHRoaXMgY2F1c2VzIE5VTEwgZGVyZWZzLg0KPj4+Pg0KPj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBDaGFvLXlpbmcgRnUgPGNmdUBtaXBzLmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1i
eTogRGpvcmRqZSBUb2Rvcm92aWMgPGRqb3JkamUudG9kb3JvdmljQGh0ZWNncm91cC5jb20+DQo+
Pj4+IC0tLQ0KPj4+PiDCoMKgIGh3L2ludGMvcmlzY3ZfYWNsaW50LmMgfCAyMSArKysrKysrKysr
KysrKysrKysrLS0NCj4+Pj4gwqDCoCBody9pbnRjL3Jpc2N2X2FwbGljLmPCoCB8IDExICsrKysr
KysrLS0tDQo+Pj4+IMKgwqAgMiBmaWxlcyBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCA1IGRl
bGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvaHcvaW50Yy9yaXNjdl9hY2xpbnQu
YyBiL2h3L2ludGMvcmlzY3ZfYWNsaW50LmMNCj4+Pj4gaW5kZXggYjAxMzlmMDNmNS4uMjJhYzQx
MzNkNSAxMDA2NDQNCj4+Pj4gLS0tIGEvaHcvaW50Yy9yaXNjdl9hY2xpbnQuYw0KPj4+PiArKysg
Yi9ody9pbnRjL3Jpc2N2X2FjbGludC5jDQo+Pj4+IEBAIC0yOTIsNyArMjkyLDEzIEBAIHN0YXRp
YyB2b2lkDQo+Pj4+IHJpc2N2X2FjbGludF9tdGltZXJfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2
LCBFcnJvciAqKmVycnApDQo+Pj4+IMKgwqDCoMKgwqDCoCBzLT50aW1lY21wID0gZ19uZXcwKHVp
bnQ2NF90LCBzLT5udW1faGFydHMpOw0KPj4+PiDCoMKgwqDCoMKgwqAgLyogQ2xhaW0gdGltZXIg
aW50ZXJydXB0IGJpdHMgKi8NCj4+Pj4gwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBzLT5u
dW1faGFydHM7IGkrKykgew0KPj4+PiAtwqDCoMKgwqDCoMKgwqAgUklTQ1ZDUFUgKmNwdSA9IFJJ
U0NWX0NQVShjcHVfYnlfYXJjaF9pZChzLT5oYXJ0aWRfYmFzZSArIA0KPj4+PiBpKSk7DQo+Pj4+
ICvCoMKgwqDCoMKgwqDCoCBDUFVTdGF0ZSAqY3B1X2J5X2hhcnRpZCA9IGNwdV9ieV9hcmNoX2lk
KHMtPmhhcnRpZF9iYXNlICsgaSk7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoY3B1X2J5X2hh
cnRpZCA9PSBOVUxMKSB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHFlbXVfbG9nX21h
c2soTE9HX0dVRVNUX0VSUk9SLCAiYWNsaW50LW10aW1lcjogaW52YWxpZA0KPj4+PiBoYXJ0aWQ6
ICV1IiwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHMtPmhhcnRpZF9iYXNlICsgaSk7DQo+Pj4NCj4+PiBEZXZpY2VSZWFsaXplKCkgaGFu
ZGxlcnMgYXJlIHBhcnQgb2YgbWFjaGluZSBtb2RlbGxpbmcsIG5vdCBndWVzdCB1c2VzLg0KPj4+
DQo+Pj4gSU9XLCB0cmlnZ2VyaW5nIHRoaXMgaXMgYSBwcm9ncmFtbWluZyBtaXN0YWtlLCBzbyB3
ZSBzaG91bGQganVzdA0KPj4+IGFib3J0KCkgaGVyZS4NCj4+DQo+PiBXZWxsLCBpZiB3ZSBkbyBp
dCB0aGF0IHdheSwgb3VyIEJvc3RvbiBib2FyZCB0YXJnZXQgZm9yIFA4NzAwIGNhbm5vdCANCj4+
IHJ1bi4NCj4NCj4gU28gdGhlIHByb2JsZW0gaXMgZWxzZXdoZXJlIDopDQoNCg0KSSBzZWUuIFdv
dWxkIHNvbWV0aGluZyBsaWtlIHRoaXMgYmUgYWNjZXB0YWJsZToNCg0KLS0tIGEvaHcvaW50Yy9y
aXNjdl9hY2xpbnQuYw0KKysrIGIvaHcvaW50Yy9yaXNjdl9hY2xpbnQuYw0KQEAgLTI3OSw3ICsy
NzksNyBAQCBzdGF0aWMgY29uc3QgUHJvcGVydHkgDQpyaXNjdl9hY2xpbnRfbXRpbWVyX3Byb3Bl
cnRpZXNbXSA9IHsNCiDCoHN0YXRpYyB2b2lkIHJpc2N2X2FjbGludF9tdGltZXJfcmVhbGl6ZShE
ZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQogwqB7DQogwqDCoMKgwqAgUklTQ1ZBY2xp
bnRNVGltZXJTdGF0ZSAqcyA9IFJJU0NWX0FDTElOVF9NVElNRVIoZGV2KTsNCi3CoMKgwqAgaW50
IGk7DQorwqDCoMKgIENQVVN0YXRlICpjcHU7DQoNCiDCoMKgwqDCoCBtZW1vcnlfcmVnaW9uX2lu
aXRfaW8oJnMtPm1taW8sIE9CSkVDVChkZXYpLCAmcmlzY3ZfYWNsaW50X210aW1lcl9vcHMsDQog
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLCBU
WVBFX1JJU0NWX0FDTElOVF9NVElNRVIsIHMtPmFwZXJ0dXJlX3NpemUpOw0KQEAgLTI5MSwxOCAr
MjkxLDE1IEBAIHN0YXRpYyB2b2lkIA0KcmlzY3ZfYWNsaW50X210aW1lcl9yZWFsaXplKERldmlj
ZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkNCiDCoMKgwqDCoCBzLT50aW1lcnMgPSBnX25ldzAo
UUVNVVRpbWVyICosIHMtPm51bV9oYXJ0cyk7DQogwqDCoMKgwqAgcy0+dGltZWNtcCA9IGdfbmV3
MCh1aW50NjRfdCwgcy0+bnVtX2hhcnRzKTsNCiDCoMKgwqDCoCAvKiBDbGFpbSB0aW1lciBpbnRl
cnJ1cHQgYml0cyAqLw0KLcKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgcy0+bnVtX2hhcnRzOyBpKysp
IHsNCi3CoMKgwqDCoMKgwqDCoCBDUFVTdGF0ZSAqY3B1X2J5X2hhcnRpZCA9IGNwdV9ieV9hcmNo
X2lkKHMtPmhhcnRpZF9iYXNlICsgaSk7DQotwqDCoMKgwqDCoMKgwqAgaWYgKGNwdV9ieV9oYXJ0
aWQgPT0gTlVMTCkgew0KLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcWVtdV9sb2dfbWFzayhMT0df
R1VFU1RfRVJST1IsICJhY2xpbnQtbXRpbWVyOiBpbnZhbGlkIA0KaGFydGlkOiAldSIsDQotwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcy0+aGFydGlk
X2Jhc2UgKyBpKTsNCi3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOw0KLcKgwqDCoMKg
wqDCoMKgIH0NCi3CoMKgwqDCoMKgwqDCoCBSSVNDVkNQVSAqY3B1ID0gUklTQ1ZfQ1BVKGNwdV9i
eV9oYXJ0aWQpOw0KLcKgwqDCoMKgwqDCoMKgIGlmIChyaXNjdl9jcHVfY2xhaW1faW50ZXJydXB0
cyhjcHUsIE1JUF9NVElQKSA8IDApIHsNCi3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVycm9yX3Jl
cG9ydCgiTVRJUCBhbHJlYWR5IGNsYWltZWQiKTsNCi3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGV4
aXQoMSk7DQotwqDCoMKgwqDCoMKgwqAgfQ0KK8KgwqDCoCBDUFVfRk9SRUFDSChjcHUpIHsNCivC
oMKgwqDCoMKgIGlmIChjcHUgPT0gTlVMTCkNCivCoMKgwqDCoMKgwqDCoCBhYm9ydCgpOw0KKw0K
K8KgwqDCoMKgwqAgUklTQ1ZDUFUgKmNwdV9yaXNjdiA9IFJJU0NWX0NQVShjcHUpOw0KK8KgwqDC
oMKgwqAgaWYgKHJpc2N2X2NwdV9jbGFpbV9pbnRlcnJ1cHRzKGNwdV9yaXNjdiwgTUlQX01USVAp
IDwgMCkgew0KK8KgwqDCoMKgwqDCoMKgIGVycm9yX3JlcG9ydCgiTVRJUCBhbHJlYWR5IGNsYWlt
ZWQiKTsNCivCoMKgwqDCoMKgwqDCoCBleGl0KDEpOw0KK8KgwqDCoMKgwqAgfQ0KIMKgwqDCoMKg
IH0NCiDCoH0NCg0KDQpUaGFua3MsDQoNCkRqb3JkamUNCg0KDQo=

