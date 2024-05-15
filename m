Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50E0C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78qG-0004WD-GE; Wed, 15 May 2024 03:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qD-0004Vk-PX
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:23 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qA-0000oJ-Qb
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715757258; x=1747293258;
 h=from:to:cc:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=8lPi7Zz9eqYvxEulJPp2J82yOe13m3FXOzxMPp9NeoI=;
 b=Sm1wXUV50RAyr8bQ2J7OlG8fyqb9CVQ7tK416PvuSuHjAvrPgCQDYMEW
 HjYeYXc8ZV/ByGHfNpDtkRdT9YEl4Mx8AOWVya4SlKsrfkT5BKyj3WeK6
 uPCgmVpUCaStF3SALWCGqSRD9v55agm8UiCZKDpkaPJI3eRUgp+vMuWLv
 DhGgSY3tYgGdW8L5ksqSW1yt5Ib8u7Uz5jtYdeXQMB5hCqD6SYmQ5+gk9
 InciOMC3XzeOlLtv5DKty7Xlcg1SVD0jmSg8IMlmy5yIJvyfQ+3237alU
 p85sAJ8dnoqJ0LOqFhV+0gwH2w36tNnIknDW88V1zNQuCWb0vcTIWaLDb Q==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12581792"
X-MGA-submission: =?us-ascii?q?MDFBM0nTZpxeQ4gqaxdP8IcduaQm59a6CFt79H?=
 =?us-ascii?q?L8TWaF29QtAId/LC+FBvm+wN4M3nzGXU9xARpbmYEyHRF7ObQqz1fdU8?=
 =?us-ascii?q?8gytaooy8ZNvqlALjlI0VYpPl74rsBH1MJdW1kO0qB0yL8m+9Pf/dOb9?=
 =?us-ascii?q?W1EGR2ytStierUlQlLN4rN+w=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 09:14:16 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHF/XECgzHqntbkKtGJ6j4z9BtOPmjT+LQeRqg0eEhiUvKF7psPKv8N42t3Q9R9kX30Dnx2clU+jvxFM+AZyG4VnCSRZIxRIwabWjn1GVlWvZsZhzLEoAOoAO9CEkGKckrja03GBYLeBUj9+LwB3ulLSVWqEwMT9rY7zFkmLBCwmPGD+Bz/yxa74WYfnU6D2X3AgSMIj7iA9sbDaeuSU2/bapQYn4/aDvFjNnbEmphvBNTDqg3eEbp1hENI0yqZasKjDGbfadNf8F1/fUAQ8V9jlQ7bqzJCkK2a4aZEnGvTPqAuBtraXoqUv1MMISGWk1S1NPQnbgE2WUoV3HHPuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lPi7Zz9eqYvxEulJPp2J82yOe13m3FXOzxMPp9NeoI=;
 b=hKvfwX6VFrlrEjyztLF82pnH6LGri1kUyFFQeKVX/hrEqtyeQX+Yf88IkjMAoaHqBFnl3Vo/gPFMIz9m8imdK2JF+aAUW8QGzqbDNHcLeohzT1IeYwVMbeq8LKZotzU6/qHPF6b64ZcMBi0y0/sfi+oCanE8MXQNbUmo0MbCMyLr2Pg/vthPUXiPMxvq9fScPbYvqxUAYcWYsyapBGAYMYYkoV1hhZ7jistlZ4ZPw1FaP4LST9M0XRlpWMRFHcex4gU+VaQB1ZXblvQm0ZaQiggQyUDk1TAygAZV0io58EYDciTDJ8u61RXFunyaU9IdEbVaWc2SwQdl1WkYJbAdxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS5PR07MB9896.eurprd07.prod.outlook.com (2603:10a6:20b:676::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 07:14:13 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.056; Wed, 15 May 2024
 07:14:13 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v2 00/25] ATS support for VT-d
Thread-Topic: [PATCH ats_vtd v2 00/25] ATS support for VT-d
Thread-Index: AQHappd932DmfjK6V0eT722xTxdApQ==
Date: Wed, 15 May 2024 07:14:13 +0000
Message-ID: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS5PR07MB9896:EE_
x-ms-office365-filtering-correlation-id: 733a7c1a-1ece-492b-097e-08dc74aea000
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?MmVMNmZXUzBYcVFxVUJwVFZHQVZlbjk3MWVlajR2YW41bFRPSjV4WE1HeDNW?=
 =?utf-8?B?SDRxTmFsYVN0SmptZXFZMHA1aU5DV2xVQ2RLb0dCSnZmTVN0TGRhNjFqWFFZ?=
 =?utf-8?B?WkorR2liS3hla3lNWEo5aGVOeW1GK21qcjVMdUYrdzlocEZSTkJNOHdWalVB?=
 =?utf-8?B?UVJpVUNrZ1dkR1F2bGs5TGRBQ1NkL0dnSWNPU2UxejhsZWU1d0NEaStYZExs?=
 =?utf-8?B?d0hkM0JQdk9QdGZVVlNNTVV5QmwxV2tnbXBNZllxNDlnOTI0RnlFc3ZLelFh?=
 =?utf-8?B?MGd5ay91NitsdlZpSldsRUdCSEdYOHFQR0ZaNEJwRmJjcE1WZTVNbjl3aUFa?=
 =?utf-8?B?cTJVRTR5L2xJSndmMlAwa1BvY3F6cHBLQmtkMGtxdndKTzhEb2RWdmp3K2Ur?=
 =?utf-8?B?U0ZicjFPWmdHdFlxL09xM3VvRVJCOEhiNnA2dWNPdTcvcGF4MnZNdUdlLzc0?=
 =?utf-8?B?Y2tWUmhBaVFSbU9wQkNRc0l4NmtBQ1pjT1JWTmlLWWF6OXNCNkZ0UTc1Y2tm?=
 =?utf-8?B?T1J0S1VPVzg5T0xpZ0Qrb25IRk5jK2N6ZHZOdlE5MVhlRGU2aytwa1RIUUd2?=
 =?utf-8?B?VXpQanVhL3Vpek0xTXRFK3dMeVc5L0pmbit3TElPZ0J1eG9WL2RDLzk5SnZQ?=
 =?utf-8?B?U2ZPV2QzS2xIVVVyL251bUsvRURNOFBxMGhFZVBUTmpwQzlhTUVvcm15bmow?=
 =?utf-8?B?U3FTVksxcXhzNG1uUW5WMGxmVkgzbEI0bjFVd0NDRENWQzIwUERsSzBqRWRk?=
 =?utf-8?B?RitFTDhxMVlyRGhaSm96clJZOVUyVDBma29uR3NqWFA1aERUSjRpRTdhdGM0?=
 =?utf-8?B?SllMeXJmNGxLaVFIWTlYV25HL05rdVk1Z2w1R2NteVljYUdqZ0xHNG5lNC9o?=
 =?utf-8?B?RFFJVkhqbFMvWXJhazZScmZiUi82eTlodTR6dm9ZbXR0dUFsaldPUFRXK0Np?=
 =?utf-8?B?ODd5MjA4cWJITkhKTFZibkdobzF1ZGdmaTZ5Tk9tUXlhUUZQVEsveU9YRmdj?=
 =?utf-8?B?YmJUUzVRNWF0SmFRMHVMRWc0Y3FpRm1jV3N0RmFiQTFTd1VBZjNYbmNzZG1H?=
 =?utf-8?B?WitlTUhkY0NuRkpPbmlEY1Y2VVl1aWNhRkliL29YWkRvOGttSHRaelBESjNJ?=
 =?utf-8?B?QktFWUowZncyMzh5VkJVTEp6YWpHL1g2WFdFR0VaeFhTazUwTHROb1k2M21I?=
 =?utf-8?B?WldCOHlhRDZ4L0sxZGxVRDN2dWxETlFwQnlqdkVhR1FLR1ZhZmZPMmxTRSts?=
 =?utf-8?B?cHVpS1B1YmNQWDhFUlphaEp1WFVmWEVaN1JGTXRsN3VzeUcwQjBwKzB1Y0JU?=
 =?utf-8?B?MU11UTd0N3NGWUxxY0prUzg4d0s5OTdkMThmVm9zSjg2SlVydm9lcVpYTHhL?=
 =?utf-8?B?eUs2NXFmeVppNlVUL2hNdURUZHkxUjJ5dSsvVVhUcUNBNy8xWHlDVzIxNzdV?=
 =?utf-8?B?K2M0YzcwRFN6VnkvbGN3UEdHK1IvWGFsL1FPV0s0b2FCVXBXREpObjFQclJm?=
 =?utf-8?B?RlFpWHdVYWQ5SlJqUjVDTFpPbW5GK2t3U1F4MVBiUGkvVnpPN1lhZnBaaFZI?=
 =?utf-8?B?SExXMlFIRkxKcGovcmhwZ2g5a3pSeDhuZ25zMlhWQVV1VTJKNHFwbG1kZ080?=
 =?utf-8?B?MTJITUVHOEVidDhJdHcza0x0a0ZZR1cxanlCK0hVMVRQVS9GU0JjMk5WQVUx?=
 =?utf-8?B?SXZwMGk2RXJhVFc3TDBQY2ZjVk02bkpVU1NObmdVL1RXNmwvUGlqNlhRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGltMm11RzRUbE81SlhFS2pYeVJSSmptd25FNnRsZjY0UXk1aXNhbEI3ZHBn?=
 =?utf-8?B?Um54RVFJOFlDMS9GeTNIT1ZqY2JkSmVYc1UvNU1jMFZZVjJpcXZaOG91YUJ6?=
 =?utf-8?B?azVtQXRsNUkwaSttMCsxY0RqQ1RrU1hmRjh1TTlhUmo4Q2RYVGVvNEZGTFRa?=
 =?utf-8?B?MEJxTTd3b1Z1aGdvUlVrT1R5VzVkc1drQWhvcFlRN01SSjBLLy9FSHp6dVgv?=
 =?utf-8?B?MjlJcUtyVnZpMm5MZndNN1pYR2ltWDRpbnZmeS94NEMyWVZBdWdkWWFzcm0r?=
 =?utf-8?B?dXQxMmVURW1pRVB1ZzBYdkhBRWNPTjhsOGMxK3hVb2p0d1VhdWl6L3lGdzJr?=
 =?utf-8?B?aEg4TWJmMXZlYUxDdTA0MWV0M2IvQ2N6dnYvTFRoRUl4bHBNaXFqY3BPem9t?=
 =?utf-8?B?aDhEbzk3Y0hBc2UrWUxCQVR6MTZWTHpUaW16dG1uUzlXQmZaZjloQ2lXaXY0?=
 =?utf-8?B?OFhuZFFEZGdaWnV6UGJFam91WUFSZ0FYR3NLWFNVRmFNSnNGMllZNFFodzB4?=
 =?utf-8?B?U2puQmExeWQ5aVF0RHJtaHlPb3FsVW5hdnRwUlNORDhLaTVpNDBvRTlLWWwz?=
 =?utf-8?B?ODhiMENtQ0V5YUYxakR4cGVkVDMxTWMwSGo0NjlVc1JWNEo1ZWtpWXR5Lys5?=
 =?utf-8?B?WDBsL3FGTldaRm9uSTBTSG10Y25NcjhCVVV3d0w0aDl1RnR2dnBrbDZqZUt0?=
 =?utf-8?B?NVFNNFozTTk2WEJWbUs0ZFBUbXlpYUFtRisxM1dNY3hDVjBkUllaUmRoWUxi?=
 =?utf-8?B?UFkweVZhWkNPOSs1Y1dWNjg0d2NpZVlzVThaZ0w2L3Mwb2tkQ0dqRitrQ0Rl?=
 =?utf-8?B?UlNUamYwVkhyMmV4NUVhN2J2SGhnYW5jZGE5aXB2aG9iMEVId2s5QnF3RVJG?=
 =?utf-8?B?bXljeEJCcFZFS3pualZscm8wV3YwMU94T01kNWJTczU2bFZxanNlNTFGTFJl?=
 =?utf-8?B?UWJ1SjA4a1QwenM4ZElEdnpUT2VjdEpkK1ZncUhtckhNdVlpV2VieFoyelFw?=
 =?utf-8?B?UklzOGQ0VGpacWVRNGlmZTlpNVVqWGcwaEEvWm9KODQzZHcrRDhvOGdkY3pH?=
 =?utf-8?B?RTFCT1ZyaFgrd2NXdVpDTjdVYlRPbjdZc1RlcksrYjRPcTFFZVc1TldyODFh?=
 =?utf-8?B?NG4wakZWYmFFUW9QZ2FRbEI2NHFtcHdBcDJYajdNK2pkYk1ua2xzK3o1M0lX?=
 =?utf-8?B?UDBVTmtvQnFKS3hHekRJSGtEK00xbW14YXNZeVpZMHNJVGtOMHlqQ0x4MVo0?=
 =?utf-8?B?a2Z1SURRaFAwZVBRVEhvb3MrTFlOd2hINkV4QkxvMFRvQzU2ajl5WnNPOS9B?=
 =?utf-8?B?Qjd5OXlmQ25wQm9RbHhpY3ZlUkZWWkdEcDBtbTlsdEtXVEUrMS9XUndyOEc2?=
 =?utf-8?B?L0NVQXZuRU11SkhrTmV0alh6aExhNkEyMU1xKzZaYXU4dGxRYWpNWkQ1blQy?=
 =?utf-8?B?V0ZLNldmSHphVXpKZEIzS1JtUkx2My9GMzlsRXoxWlhLMlRTc2V2UGttUm1t?=
 =?utf-8?B?bURaTG1CcHpVOTJtbTk5UXcyeFFsckF2QXhLOTdZUlkwOXNKRGx1YUVBaFJz?=
 =?utf-8?B?RDZ6MjRNYW0zalg4aVVLRm1xYWM1QXowdmVTSXJtOWJRSnFzWTh1QmFRNGZL?=
 =?utf-8?B?TXRNTzduKzh3MlNFdk95eHBUK1B5azhwOElIVXFabmlyRzJqQkFPM1lYQXcy?=
 =?utf-8?B?cGFQYTB5bGZQbktjVUhrRCtLM0JRK1A2V3pvOCtEN1RldzIxUmN5VG85cGM4?=
 =?utf-8?B?QXlGLy9tV2NzOXFweDFRVjczczhCbjQ4RUF1Z2xseVpvQ1cvc0hXZS9jTDZY?=
 =?utf-8?B?VzErb2I4YXBZbVgvRE13R2s2eFpkM25GZVEzVzRKSEI0RU9UN2Vzank0N3lE?=
 =?utf-8?B?YmZxOVVtK0Y1ZWpaNG8wRmtPNmZsVTU5R1hOVy9QQlNpRG9tdGZzaWh4NVBZ?=
 =?utf-8?B?cGQ2dGsyaEJxckVXTkhpd3lkYmhVSzlvMFdxbjFUMGlFODJkNFBBYXlvNGg4?=
 =?utf-8?B?eEcvdHZkcnNzaVpDdE82QTZnVXlWVjZyR1pXSjRGUXJ3WnZDaFBsQi9mYmZI?=
 =?utf-8?B?aFJ2aW1wMUJxdTJ6UDZJNEF5SHFkckZBbzBhQTJjMnpPTUlsRzBJMzZGNURK?=
 =?utf-8?B?SWVkNmE3WjBiOHV1R1pqMUVGVTVjYWprREIwMERmbEdHdVBZS2piTEgwY0kz?=
 =?utf-8?Q?whl2jrnFOacewaX7aaiNaLE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27E6B47C62E2EB4ABA1201F9905AB885@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733a7c1a-1ece-492b-097e-08dc74aea000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:14:13.6948 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gkkK/QWb1vLXFnb4jL1ZsSOhofuuF0aAHxyTeXYGBXIIRmCIYaVXwGHQmQ4pVBJWIz12TmqucE/Uc5FJS3DAFuoHVvHO7+h30TctqAirTaMDk7/mTdEqgr3aYO8s0PN+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB9896
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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

VGhpcyBzZXJpZXMgYmVsb25ncyB0byBhIGxpc3Qgb2Ygc2VyaWVzIHRoYXQgYWRkIFNWTSBzdXBw
b3J0IGZvciBWVC1kLg0KDQpBcyBhIHN0YXJ0aW5nIHBvaW50LCB3ZSB1c2UgdGhlIHNlcmllcyBj
YWxsZWQgJ2ludGVsX2lvbW11OiBFbmFibGUgc3RhZ2UtMSB0cmFuc2xhdGlvbicgKHJmYzIpIGJ5
IFpoZW56aG9uZyBEdWFuIGFuZCBZaSBMaXUuDQoNCkhlcmUgd2UgZm9jdXMgb24gdGhlIGltcGxl
bWVudGF0aW9uIG9mIEFUUyBzdXBwb3J0IGluIHRoZSBJT01NVSBhbmQgb24gYSBQQ0ktbGV2ZWwN
CkFQSSBmb3IgQVRTIHRvIGJlIHVzZWQgYnkgdmlydHVhbCBkZXZpY2VzLg0KDQpUaGlzIHdvcmsg
aXMgYmFzZWQgb24gdGhlIFZULWQgc3BlY2lmaWNhdGlvbiB2ZXJzaW9uIDQuMSAoTWFyY2ggMjAy
MykuDQpIZXJlIGlzIGEgbGluayB0byBhIEdpdEh1YiByZXBvc2l0b3J5IHdoZXJlIHlvdSBjYW4g
ZmluZCB0aGUgZm9sbG93aW5nIGVsZW1lbnRzIDoNCiAgICAtIFFlbXUgd2l0aCBhbGwgdGhlIHBh
dGNoZXMgZm9yIFNWTQ0KICAgICAgICAtIEFUUw0KICAgICAgICAtIFBSSQ0KICAgICAgICAtIERl
dmljZSBJT1RMQiBpbnZhbGlkYXRpb25zDQogICAgICAgIC0gUmVxdWVzdHMgd2l0aCBhbHJlYWR5
IHRyYW5zbGF0ZWQgYWRkcmVzc2VzDQogICAgLSBBIGRlbW8gZGV2aWNlDQogICAgLSBBIHNpbXBs
ZSBkcml2ZXIgZm9yIHRoZSBkZW1vIGRldmljZQ0KICAgIC0gQSB1c2Vyc3BhY2UgcHJvZ3JhbSAo
Zm9yIHRlc3RpbmcgYW5kIGRlbW9uc3RyYXRpb24gcHVycG9zZXMpDQoNCmh0dHBzOi8vZ2l0aHVi
LmNvbS9CdWxsU2VxdWFuYS9RZW11LWluLWd1ZXN0LVNWTS1kZW1vDQoNCnYyDQogICAgLSBoYW5k
bGUgaHVnZSBwYWdlcyBiZXR0ZXIgYnkgZGV0ZWN0aW5nIHRoZSBwYWdlIHRhYmxlIGxldmVsIGF0
IHdoaWNoIHRoZSB0cmFuc2xhdGlvbiBlcnJvcnMgb2NjdXINCiAgICAtIENoYW5nZXMgYWZ0ZXIg
cmV2aWV3IGJ5IFpoZW5aaG9uZyBEdWFuIDoNCiAgICAJLSBTZXQgdGhlIGFjY2VzcyBiaXQgYWZ0
ZXIgY2hlY2tpbmcgcGVybWlzc2lvbnMNCiAgICAJLSBoZWxwZXIgZm9yIFBBU0lEIGFuZCBBVFMg
OiBtYWtlIHRoZSBjb21taXQgbWVzc2FnZSBtb3JlIGFjY3VyYXRlICgncHJlc2VudCcgcmVwbGFj
ZWQgd2l0aCAnZW5hYmxlZCcpDQogICAgCS0gcGNpZV9wYXNpZF9pbml0OiBhZGQgUENJX1BBU0lE
X0NBUF9XSURUSF9TSElGVCBhbmQgdXNlIGl0IGluc3RlYWQgb2YgUENJX0VYVF9DQVBfUEFTSURf
U0laRU9GIGZvciBzaGlmdGluZyB0aGUgcGFzaWQgd2lkdGggd2hlbiBwcmVwYXJpbmcgdGhlIGNh
cGFiaWxpdHkgcmVnaXN0ZXINCiAgICAJLSBwY2k6IGRvIG5vdCBjaGVjayBwY2lfYnVzX2J5cGFz
c19pb21tdSBhZnRlciBjYWxsaW5nIHBjaV9kZXZpY2VfZ2V0X2lvbW11X2J1c19kZXZmbg0KICAg
IAktIGRvIG5vdCBhbHRlciBmb3JtYXR0aW5nIG9mIElPTU1VVExCRW50cnkgZGVjbGFyYXRpb24N
CiAgICAJLSB2dGRfaW92YV9mbF9jaGVja19jYW5vbmljYWwgOiBkaXJlY3RseSB1c2Ugcy0+YXdf
Yml0cyBpbnN0ZWFkIG9mIGF3IGZvciB0aGUgc2FrZSBvZiBjbGFyaXR5DQoNCkNsw6ltZW50IE1h
dGhpZXUtLURyaWYgKDI1KToNCiAgaW50ZWxfaW9tbXU6IGZpeCBGUkNEIGNvbnN0cnVjdGlvbiBt
YWNyby4NCiAgaW50ZWxfaW9tbXU6IG1ha2UgdHlwZXMgbWF0Y2gNCiAgaW50ZWxfaW9tbXU6IGNo
ZWNrIGlmIHRoZSBpbnB1dCBhZGRyZXNzIGlzIGNhbm9uaWNhbA0KICBpbnRlbF9pb21tdTogc2V0
IGFjY2Vzc2VkIGFuZCBkaXJ0eSBiaXRzIGR1cmluZyBmaXJzdCBzdGFnZQ0KICAgIHRyYW5zbGF0
aW9uDQogIGludGVsX2lvbW11OiByZXR1cm4gcGFnZSB3YWxrIGxldmVsIGV2ZW4gd2hlbiB0aGUg
dHJhbnNsYXRpb24gZmFpbHMNCiAgaW50ZWxfaW9tbXU6IGV4dHJhY3QgZGV2aWNlIElPVExCIGlu
dmFsaWRhdGlvbiBsb2dpYw0KICBpbnRlbF9pb21tdTogZG8gbm90IGNvbnNpZGVyIHdhaXRfZGVz
YyBhcyBhbiBpbnZhbGlkIGRlc2NyaXB0b3INCiAgbWVtb3J5OiBhZGQgcGVybWlzc2lvbnMgaW4g
SU9NTVVBY2Nlc3NGbGFncw0KICBwY2llOiBhZGQgaGVscGVyIHRvIGRlY2xhcmUgUEFTSUQgY2Fw
YWJpbGl0eSBmb3IgYSBwY2llIGRldmljZQ0KICBwY2llOiBoZWxwZXIgZnVuY3Rpb25zIHRvIGNo
ZWNrIGlmIFBBU0lEIGFuZCBBVFMgYXJlIGVuYWJsZWQNCiAgaW50ZWxfaW9tbXU6IGRlY2xhcmUg
c3VwcG9ydGVkIFBBU0lEIHNpemUNCiAgaW50ZWxfaW9tbXU6IGFkZCBhbiBpbnRlcm5hbCBBUEkg
dG8gZmluZCBhbiBhZGRyZXNzIHNwYWNlIHdpdGggUEFTSUQNCiAgaW50ZWxfaW9tbXU6IGFkZCBz
dXBwb3J0IGZvciBQQVNJRC1iYXNlZCBkZXZpY2UgSU9UTEIgaW52YWxpZGF0aW9uDQogIHBjaTog
Y2FjaGUgdGhlIGJ1cyBtYXN0ZXJpbmcgc3RhdHVzIGluIHRoZSBkZXZpY2UNCiAgcGNpOiBhZGQg
SU9NTVUgb3BlcmF0aW9ucyB0byBnZXQgYWRkcmVzcyBzcGFjZXMgYW5kIG1lbW9yeSByZWdpb25z
DQogICAgd2l0aCBQQVNJRA0KICBwY2k6IGFkZCBhIHBjaS1sZXZlbCBpbml0aWFsaXphdGlvbiBm
dW5jdGlvbiBmb3IgaW9tbXUgbm90aWZpZXJzDQogIGludGVsX2lvbW11OiBpbXBsZW1lbnQgdGhl
IGdldF9hZGRyZXNzX3NwYWNlX3Bhc2lkIGlvbW11IG9wZXJhdGlvbg0KICBpbnRlbF9pb21tdTog
aW1wbGVtZW50IHRoZSBnZXRfbWVtb3J5X3JlZ2lvbl9wYXNpZCBpb21tdSBvcGVyYXRpb24NCiAg
bWVtb3J5OiBBbGxvdyB0byBzdG9yZSB0aGUgUEFTSUQgaW4gSU9NTVVUTEJFbnRyeQ0KICBpbnRl
bF9pb21tdTogZmlsbCB0aGUgUEFTSUQgZmllbGQgd2hlbiBjcmVhdGluZyBhbiBpbnN0YW5jZSBv
Zg0KICAgIElPTU1VVExCRW50cnkNCiAgYXRjOiBnZW5lcmljIEFUQyB0aGF0IGNhbiBiZSB1c2Vk
IGJ5IFBDSWUgZGV2aWNlcyB0aGF0IHN1cHBvcnQgU1ZNDQogIG1lbW9yeTogYWRkIGFuIEFQSSBm
b3IgQVRTIHN1cHBvcnQNCiAgcGNpOiBhZGQgYSBwY2ktbGV2ZWwgQVBJIGZvciBBVFMNCiAgaW50
ZWxfaW9tbXU6IHNldCB0aGUgYWRkcmVzcyBtYXNrIGV2ZW4gd2hlbiBhIHRyYW5zbGF0aW9uIGZh
aWxzDQogIGludGVsX2lvbW11OiBhZGQgc3VwcG9ydCBmb3IgQVRTDQoNCiBody9pMzg2L2ludGVs
X2lvbW11LmMgICAgICAgICAgICAgICAgICAgICB8IDMyNCArKysrKysrKysrKy0tLQ0KIGh3L2kz
ODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCAgICAgICAgICAgIHwgIDIxICstDQogaHcvcGNpL3Bj
aS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMjUgKysrKystDQogaHcvcGNpL3Bj
aWUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNDIgKysNCiBpbmNsdWRlL2V4ZWMv
bWVtb3J5LmggICAgICAgICAgICAgICAgICAgICB8ICA1MCArKy0NCiBpbmNsdWRlL2h3L2kzODYv
aW50ZWxfaW9tbXUuaCAgICAgICAgICAgICB8ICAgMiArLQ0KIGluY2x1ZGUvaHcvcGNpL3BjaS5o
ICAgICAgICAgICAgICAgICAgICAgIHwgIDk5ICsrKysrDQogaW5jbHVkZS9ody9wY2kvcGNpX2Rl
dmljZS5oICAgICAgICAgICAgICAgfCAgIDEgKw0KIGluY2x1ZGUvaHcvcGNpL3BjaWUuaCAgICAg
ICAgICAgICAgICAgICAgIHwgICA5ICstDQogaW5jbHVkZS9ody9wY2kvcGNpZV9yZWdzLmggICAg
ICAgICAgICAgICAgfCAgIDMgKw0KIGluY2x1ZGUvc3RhbmRhcmQtaGVhZGVycy9saW51eC9wY2lf
cmVncy5oIHwgICAxICsNCiBzeXN0ZW0vbWVtb3J5LmMgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAyMCArDQogdGVzdHMvdW5pdC9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgfCAg
IDEgKw0KIHRlc3RzL3VuaXQvdGVzdC1hdGMuYyAgICAgICAgICAgICAgICAgICAgIHwgNTAyICsr
KysrKysrKysrKysrKysrKysrKysNCiB1dGlsL2F0Yy5jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8IDIxMSArKysrKysrKysNCiB1dGlsL2F0Yy5oICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8IDExNyArKysrKw0KIHV0aWwvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICAxICsNCiAxNyBmaWxlcyBjaGFuZ2VkLCAxNDUzIGluc2VydGlvbnMoKyks
IDc2IGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy91bml0L3Rlc3QtYXRj
LmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgdXRpbC9hdGMuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCB1
dGlsL2F0Yy5oDQoNCi0tIA0KMi40NC4wDQo=

