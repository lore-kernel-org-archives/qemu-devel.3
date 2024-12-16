Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24124E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 09:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN7jF-00053h-5u; Mon, 16 Dec 2024 04:49:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Frederic.Konrad@amd.com>)
 id 1tN7jC-0004rj-Kk; Mon, 16 Dec 2024 04:49:26 -0500
Received: from mail-bn1nam02on20625.outbound.protection.outlook.com
 ([2a01:111:f403:2407::625]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Frederic.Konrad@amd.com>)
 id 1tN7jA-0004S5-AJ; Mon, 16 Dec 2024 04:49:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OT738Xo6vmV8ixppOeK0HmyK0rSby+WhpC/DBdawfuVumxKj9Jhnp4CLcYQsg4F1zJKidStnA0YrtPfy4GGU2GaVuPiNqZr4UE7wys1kw6XSAfmm1t8UYuDUHYk1UqM2eMCvw9icK2WyXILkEKh+PjLCX3a8xpPgn25nCf5nGzivap1rSytSG3slJGNO/zkmiAuFPtxW1w8n0CpflmJc/51st6lKnKtwFJBsovjTlfoBsCrAmRrRYeK6gDP+SICfWrjZlJV+3KLpxmufnqZxCnFcywOX4+iJ4qyr5Pk17+eIRfAQex0P/bbx3yu4v9OiyvgiSvLi8hiKEERvXgwV1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcFcbcxrpveMGK+aDW4dqjVDGlCUt0hQA6dK7pombDU=;
 b=u9YnTOnlKlCZUBBYb6FjyuxuP3+l5UuVKm6J3rnD9nq24pPY5E5nb84wWnz2aAquOcJgy0p0xPV+5oTrKZthJdBgkEHVFva3QoneGBce1/BTzyDkIX6i9jCXT2MuHnLMgOPvmoNBVhC/TnuRH/CqMNjdVlSfbWVKRnHm/kDd3kif11MNVMXV9ibEbp+GgRQ8kWJ+o0/gFWdjZKkJfpoYgNTVsNmhqPZcT190jYEDpYLPt8AcCKkhbuCNrBAZgheej51y34og3nsxc2Gbo5eTViwcSEuVSTRosLZbYTtAOsKafVkNY5fRdumL4kqKRKoH9dmf+QCJjZDVpnzswZXhoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcFcbcxrpveMGK+aDW4dqjVDGlCUt0hQA6dK7pombDU=;
 b=017JR8xxpj4F5h5ANLbYsZCF3KxhnE8iImLywybsTqbbQdsZb6bvLa2zQfbunZh9m4udhJXLAqEglI8Sq/bvGy/W9HDbK60+LP5IG77XTP1cJRV1UgeGT1k4fRWr2FS6uftPofhzd0z7lUe3Qlti099JHAO1Z0tai+6K1+TBFJI=
Received: from CY8PR12MB8411.namprd12.prod.outlook.com (2603:10b6:930:6e::6)
 by IA0PR12MB7700.namprd12.prod.outlook.com (2603:10b6:208:430::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 09:49:19 +0000
Received: from CY8PR12MB8411.namprd12.prod.outlook.com
 ([fe80::b636:ea75:6169:bcef]) by CY8PR12MB8411.namprd12.prod.outlook.com
 ([fe80::b636:ea75:6169:bcef%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 09:49:19 +0000
From: "Konrad, Frederic" <Frederic.Konrad@amd.com>
To: Alistair Francis <alistair23@gmail.com>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "dbarboza@ventanamicro.com"
 <dbarboza@ventanamicro.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Iglesias, Francisco" <francisco.iglesias@amd.com>,
 "Michel, Luc" <Luc.Michel@amd.com>
Subject: RE: [PATCH 1/3] target/riscv: add a trap-misaligned-access property
Thread-Topic: [PATCH 1/3] target/riscv: add a trap-misaligned-access property
Thread-Index: AQHbTBKApjPOpLyYukiyXqrxlELlE7LoVUAAgABR9GA=
Date: Mon, 16 Dec 2024 09:49:19 +0000
Message-ID: <CY8PR12MB8411A576D6E0FEB0FF3218C4E63B2@CY8PR12MB8411.namprd12.prod.outlook.com>
References: <20241211211933.198792-1-fkonrad@amd.com>
 <20241211211933.198792-2-fkonrad@amd.com>
 <CAKmqyKNeqRNfB3p_U4Q3kmV43rdD+b3P0t7qq7FZtGv46imQnQ@mail.gmail.com>
In-Reply-To: <CAKmqyKNeqRNfB3p_U4Q3kmV43rdD+b3P0t7qq7FZtGv46imQnQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8411:EE_|IA0PR12MB7700:EE_
x-ms-office365-filtering-correlation-id: 2b1e422a-4396-427d-a5f2-08dd1db6e945
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?a2V0dmM4OUlBQWdCTXJ5V1ZjMWNhR05NUjJjand3cUwzcUZtN01FNlVXcFd2?=
 =?utf-8?B?MnpiRFRuYUU4VDRGS2RucXdMTlhWOFFSNnZldml1cDhLQlA1d3NJTTFSOWNT?=
 =?utf-8?B?d0haL1pxMUozY0hGclgzL09pMDFGMG13TCtWby9LaE40ZU9sOTFWZTN5SUhI?=
 =?utf-8?B?dUJuT0FoVU9xRnRDbnBsQklhamd5TGcvT3NONlAwMDFZaVZ1dGoyVm5ZM0d3?=
 =?utf-8?B?OFgrYXpqdUs4VHBBVnNrcWIza2daT2pXWHA2aklyRWMvcTJQM3l6c28vTkZy?=
 =?utf-8?B?ajcwcVN2Sm1DaHNhNGRXSGhockZJOGM4OUE1QU5SN0dBMGhVTjhGMWRha2Yy?=
 =?utf-8?B?YThNdldEYXUxRnlLVmxadkk2dGNsZ0NMbVhhNVFhQndFeUJXanN6MmI5Wlps?=
 =?utf-8?B?K1pZWGgzcHNOblYrMHdlN2hzblBWcDkvWUdSUlhSejNIRDU5aytMckY1WXQw?=
 =?utf-8?B?SE8vdGQ5UjdXdmNvY1BmcDBxUElJdXpjWlBLMkN5UCt6V3ZydG5IdlB4Zk0z?=
 =?utf-8?B?VGNZZmtPQ1ZjazVqVnlMWGdZdVdQM0ZQbTlJUTFueVNBWTV4UGpaS2dmUTYx?=
 =?utf-8?B?WGNKRS9Sa1dncXF0Q2lLalJiNG91U05GRi9KNi9xYmFuclBEK1NTa3kxUDY2?=
 =?utf-8?B?VXRnOW82WnY4S2xGaFB1aHpZd3pKVlg2VGRNMHpZZmwrRlJ6T1IzZHlJVTdu?=
 =?utf-8?B?c0d2VmNNZFcvYmQxU1J6eTVuVXBCSFpnOVRXcFJ5bk9TU2dLekl2ekVGTzNY?=
 =?utf-8?B?T1R4dkp1cU1rU1lsM3hDY3Z6R01pcjBhTkVwSllsa0w5Z1hVbVMvSnlNak01?=
 =?utf-8?B?SjZMTnZBT0VpUWZlSDgvTzVZWkptTlJkMm1Nb3VQZzhnMzBpRHhqQXNoOWp5?=
 =?utf-8?B?SGpRYkhOd29QS1VEbzlXUCtiL2I0MUlmZ2R5YmIvbUN0WVpSRUFtRGIwWnl0?=
 =?utf-8?B?b3BROG4velM1eGxmZjlSM0JCYWtaak1BcDNUMEZscDVIWjdYKzJLRE9YYjhG?=
 =?utf-8?B?cW5LdXUzZGx1ZlBhbmcrOUFFS214RjMxQnF0dFRuTldUOXQ5em9zNHhSdGY1?=
 =?utf-8?B?aWtoWXpNL3JuTFR1TWFibzg4dGJ6TThYOGE3bDVGd2dJeEE5dlFHY0doaG1T?=
 =?utf-8?B?M0RmK0dzT3lzMlkvWTZtdDFISjk5L0tGRDJpNnlYbGRCYVFLOSt1aVRRelYy?=
 =?utf-8?B?ZTZCVEp5TVIzYStId2JsMENTSTBTc3ZTS1RiR0swNndUT2FvTVB1U3VUZUJi?=
 =?utf-8?B?S1VHQjdBUm1TNDVaV1VuVHVoSi9wOEhDNU5DTnc1U1lOQU1NdFJacmE2NDN5?=
 =?utf-8?B?c3BCTThWSjhxaks3ejJIVVQvN2VOYnJoRDdzUDl6Zk9QZTV6L2drNklGWjl0?=
 =?utf-8?B?MHdnbjNwNTg1Nm9UYjdDWndURFNIUEh6aFNtVGFBbDI1YmpYZUNuV0RDSXZl?=
 =?utf-8?B?M0NvQ1ZLS2tYcUhxVndVUG9WZWVQamlIRmRNajVKczBGdHVKbmMyTUJsem5Y?=
 =?utf-8?B?WUYrNlMyMFJGd0tlK1FPZFV4bVBqd0hYVzlJdDBCRXNacVc1SEwya2xUUGlQ?=
 =?utf-8?B?a1ZpWWtESUlKSkJXak9qL1BkSURYU0NkaFo5bEptelRHVnZSQnY0by8xNzlr?=
 =?utf-8?B?WGxIMU14Y1pXemRwT0tWVVMwY1FWaDFWNnJJdGJZVHUxa2J6R3JCdnJEQXJV?=
 =?utf-8?B?d2tmSnE3ejNXYVpNbTd3TnU2OUtvRGc2SWlXQW5nMm5tZGN1N0pBZ29Eb2xS?=
 =?utf-8?B?bE5FOXg4bWpSelUyQ0ZseUV3QkI1TU41bzdkc2dKQnhvRS92VTdJNUxZbGdF?=
 =?utf-8?B?TEkvUDZBbGkvMzNJSFNROFZWQmoweGNONVJhdENPZ3VWMDBuSUM4d1BhWFc5?=
 =?utf-8?B?ZkxTN0FVRGNRbFREUUNrc3RkazUwSWY1bkNSeEFkendjUmpzSi9MdUkyS0tv?=
 =?utf-8?Q?MmRh6K7SdD2pe3E07FO0Y63JAQanCfUc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8411.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWhDNjF6UnlrcWExeXFQNUZrTVI5eUl0WnM0K2dsTDNYSk1DNWdtdWJ6a09N?=
 =?utf-8?B?YWkyNG1DQ29LMDhpZDk5dkRoWHpQcW0yN2xDczU4SGxtYWJSa3JETjE5aGhN?=
 =?utf-8?B?ZFR5bUcrdEhmbUtjZXRpWGVqWWxrcG5UNEVndjM5ME9PTUNkcUQzZyswTEMw?=
 =?utf-8?B?M0orK0tQSDdZNUVqbldpVEl4Vm9rN2V1enRZalhWZVV3L3hIZlVMUWlMQWxR?=
 =?utf-8?B?SmtEZk9oM2pZbXRkMkZFK2hoVnp0UEVFQUR4a1o5T2JOTEQvb1RzNzBFV0Zt?=
 =?utf-8?B?MVlkNjRqTWlLMzIyMmZ6aDVKYVVSNzkzendaMXpsaWxGQW9RMTkxOTY3dzdr?=
 =?utf-8?B?ZkxLRXl4U1dGZlRqR2kxRHhsRGNwZ3lJZTF3dmIrbGs3QUdyQTZsVXc3cTRs?=
 =?utf-8?B?VDZGMWttaForekNmUlRIUVdnUjIzNlRvSzIzWWhvWkJBVit3YUF0SHR0ODNt?=
 =?utf-8?B?b2F2THdoUEJib1RVc2lVaHJKczBONzhLejJnRlB0NHdzcGdlMS9FQStVaks5?=
 =?utf-8?B?dGxZZGhzVzBiU3E1V0xLTmxrUlBtaUowQ3Z5RXBRaEZyc0R6cGl4WFdQQzRK?=
 =?utf-8?B?Wk41NjZ4QUpzSC9aWWFyUmppTUMreGtIajF4c3Iwc0Y2cVZ2NC9kd0pEdlpl?=
 =?utf-8?B?Q1dRY2FwUjdEbGFPY1BFZ1FUSkhMM0N5bmFWZWYreFJVdEIyUnhHYWxtdjdj?=
 =?utf-8?B?RjBBVVZFbDd6c1JwRVhTSVhEc1hVb3IwK00weDZHNFZiSEVQQUUxeEZRRU5J?=
 =?utf-8?B?Ry9VUGQxb3B3NWg3MEczQVVBaGdhVnBNd3NldU5BSWJJaHFJODZ4a1c5bXhy?=
 =?utf-8?B?L3h1VnlKMTBqUDh1UHpVQkU1ZUhRQ2JaYTVIb2J2TFV0SEUzTnJzUUNCOWZU?=
 =?utf-8?B?NkpmRGpUc0VqWVEycXNHeXYwQzVHMkZ5ZXZ3TG04cHlEYzBDQ0ZvUjI0ZUFh?=
 =?utf-8?B?a2hadUVSSjlPT0l1clcyL1NMb1FmU1NNY0FrTTFnbUo3QlFEVGEvK1dJKzZM?=
 =?utf-8?B?NXk2SldUN1FnRHE1WFVGOEI0WnBjTHM5elowLy8yQlhoL1dlWnlVVEtFT0lz?=
 =?utf-8?B?WU9jRXlFeDBQZG9lSmkzTFM4Mmp4S2xGYk9jTlhlMmwrbWZ4Q1FXZFVFUTIy?=
 =?utf-8?B?dVpkbHBrbTJ5b29HcnhSRTdzVUZEQmtSeE8vZTg1eWN2aGFPQTd4YmF3L001?=
 =?utf-8?B?eFNYUU44V3ZkYjNUdTVaM3dJakRWNWN6ZWNVUk53bjdiS3ZkYnlzc0g4SzRO?=
 =?utf-8?B?dlY4S24vWlNncEQ4YW1BY1RubmYzZ2ZqU3Y5QWd6YkNybTVNbHJqQ3JjV3Zn?=
 =?utf-8?B?SStlN0JEc25uQjJIcEhkaHdlSHRxNVJhVWFSWC96SEVOTnJvbjZ3WWFzWk5K?=
 =?utf-8?B?QXhRUWF6NmJUeVBvQno1YkdiUWFRc3RIcW1yNmxsRTJSVXR2dnhBeU8zeklN?=
 =?utf-8?B?QXRkbk5lYkIxcE5PaWVRR0M4M29td09KY0FSN0ExdHRVUWdVbVR6YXRWL0dY?=
 =?utf-8?B?WWJGOHVSQTRHdDVMb0RTNHBQNWRnR2NLSDcyWGtzYTdELzZwRDVzUHlQQjZ6?=
 =?utf-8?B?T1FvbG5rck5rTng1cVM5WStna3U5K0pWTHR4MXh2MUJibVpkaDkyK0M2djky?=
 =?utf-8?B?VHBoUWh6SWdidjdYckVjSjRaM0hZcVhpL3hxMGhQYVIyWEhHQS91cC9MMks0?=
 =?utf-8?B?Q0R0YlFaQVEyNzhXL1llRWFpQk8zWTJqdlZBR1ZWaXRJS3dIa2k1WEwrU3lS?=
 =?utf-8?B?SjRsMnRuY2o3WGVjNGxGdncvd1lubGZHaDliSnk3aVZwTytGbUMrU3lhZjFH?=
 =?utf-8?B?L0NsM0lYZDFueEppUFk3Wm9kSk1VTVN2Z1V3amFvVHF0WVFzNDFVckVIYkkw?=
 =?utf-8?B?OVZETlViVnpVRkcrdk82ZGw5VklrcitVZ0pSVDZ3TXREZGFNaGRiZUZ0TmN1?=
 =?utf-8?B?Q2E5MndIZmczRlpaWGtnZmt2aUtnSE44bnRoUk91RmtiRDVRYjlZNEo4TERU?=
 =?utf-8?B?bTRNeUQzdGpISndJUEdsQVdNNDZPZXF6eWFndTVGd29va1pJTDc1L2N3T2Jh?=
 =?utf-8?B?T05YYk1WcjRQNVVVOTdrZ1RYZ1VabzFKM3V2bXRCbEtSWTVoN3pjbTdWTUJX?=
 =?utf-8?Q?mYBo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1e422a-4396-427d-a5f2-08dd1db6e945
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 09:49:19.1071 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tGoStuyyL+SnlBbLQDt2qrFhy0l66ACD/NpEY4XfcUzF/cHt2C5Q/ihSEd3fD8CW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7700
Received-SPF: permerror client-ip=2a01:111:f403:2407::625;
 envelope-from=Frederic.Konrad@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxpc3RhaXIgRnJhbmNp
cyA8YWxpc3RhaXIyM0BnbWFpbC5jb20+DQo+IFNlbnQ6IDE2IERlY2VtYmVyIDIwMjQgMDU6NTUN
Cj4gVG86IEtvbnJhZCwgRnJlZGVyaWMgPEZyZWRlcmljLktvbnJhZEBhbWQuY29tPg0KPiBDYzog
cWVtdS1yaXNjdkBub25nbnUub3JnOyBwYWxtZXJAZGFiYmVsdC5jb207IGFsaXN0YWlyLmZyYW5j
aXNAd2RjLmNvbTsgYm1lbmcuY25AZ21haWwuY29tOyBsaXdlaTE1MThAZ21haWwuY29tOw0KPiBk
YmFyYm96YUB2ZW50YW5hbWljcm8uY29tOyB6aGl3ZWlfbGl1QGxpbnV4LmFsaWJhYmEuY29tOyBx
ZW11LWRldmVsQG5vbmdudS5vcmc7IElnbGVzaWFzLCBGcmFuY2lzY28NCj4gPGZyYW5jaXNjby5p
Z2xlc2lhc0BhbWQuY29tPjsgTWljaGVsLCBMdWMgPEx1Yy5NaWNoZWxAYW1kLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAxLzNdIHRhcmdldC9yaXNjdjogYWRkIGEgdHJhcC1taXNhbGlnbmVk
LWFjY2VzcyBwcm9wZXJ0eQ0KPiANCj4gT24gVGh1LCBEZWMgMTIsIDIwMjQgYXQgNzoyMeKAr0FN
IEZyZWRlcmljIEtvbnJhZCA8ZmtvbnJhZEBhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIHJp
c2N2IHRhcmdldCwgbWlzYWxpZ25lZCBhY2Nlc3NlcyBhcmUgZWl0aGVyIGF1dGhvcml6ZWQgYW5k
IGltcGxlbWVudGVkIGluDQo+ID4gaGFyZHdhcmUsIG9yIHVuaW1wbGVtZW50ZWQgYW5kIGdlbmVy
YXRlIGEgdHJhcCB0byBiZSBpbXBsZW1lbnRlZCBpbiBzb2Z0d2FyZS4NCj4gPg0KPiA+IEF0IHRo
ZSBtb21lbnQgbWlzYWxpZ25lZCBhY2Nlc3NlcyBmb3IgcnZpIGp1c3Qgc3VjY2VlZCwgdGhlIGlu
dGVudGlvbiBvZiB0aGlzDQo+ID4gbmV3IHByb3BlcnR5IGlzIHRvIGxldCB0aGUgdXNlciBjaG9v
c2UgdG8gaGF2ZSBhIHRyYXAgd2hlbiBhIG1pc2FsaWduZWQgYWNjZXNzDQo+ID4gaGFwcGVucy4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEZyZWRlcmljIEtvbnJhZCA8ZmtvbnJhZEBhbWQuY29t
Pg0KPiA+IC0tLQ0KPiA+ICB0YXJnZXQvcmlzY3YvY3B1LmMgICAgIHwgNSArKysrKw0KPiA+ICB0
YXJnZXQvcmlzY3YvY3B1X2NmZy5oIHwgMSArDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2NwdS5jIGIvdGFy
Z2V0L3Jpc2N2L2NwdS5jDQo+ID4gaW5kZXggZjIxOWYwYzNiNS4uMTY5NmQzZGIyYSAxMDA2NDQN
Cj4gPiAtLS0gYS90YXJnZXQvcmlzY3YvY3B1LmMNCj4gPiArKysgYi90YXJnZXQvcmlzY3YvY3B1
LmMNCj4gPiBAQCAtMjY5Nyw2ICsyNjk3LDExIEBAIHN0YXRpYyBQcm9wZXJ0eSByaXNjdl9jcHVf
cHJvcGVydGllc1tdID0gew0KPiA+ICAgICAgICogaXQgd2l0aCAteCBhbmQgZGVmYXVsdCB0byAn
ZmFsc2UnLg0KPiA+ICAgICAgICovDQo+ID4gICAgICBERUZJTkVfUFJPUF9CT09MKCJ4LW1pc2Et
dyIsIFJJU0NWQ1BVLCBjZmcubWlzYV93LCBmYWxzZSksDQo+ID4gKyAgICAvKg0KPiA+ICsgICAg
ICogd2hlbiBzZXQsIG1pc2FsaWduZWQgYWNjZXNzZXMgd2lsbCBnZW5lcmF0ZSBhIHRyYXAuDQo+
ID4gKyAgICAgKi8NCj4gPiArICAgIERFRklORV9QUk9QX0JPT0woInRyYXAtbWlzYWxpZ25lZC1h
Y2Nlc3MiLCBSSVNDVkNQVSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgY2ZnLnRyYXBfbWlz
YWxpZ25lZF9hY2Nlc3MsIGZhbHNlKSwNCj4gDQo+IFRoaXMgc2hvdWxkIGJlIHRoZSBsYXN0IHBh
dGNoLCB3ZSB3YW50IHRvIGltcGxlbWVudCB0aGUgZmVhdHVyZSBiZWZvcmUNCj4gd2UgZXhwb3Nl
IGl0Lg0KDQpHb3QgaXQgdGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMsDQpGcmVkDQoNCj4gDQo+IEFs
aXN0YWlyDQo=

