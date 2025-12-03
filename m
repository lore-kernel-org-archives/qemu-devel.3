Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DE1D12694
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 11:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQkyT-0007tL-0A; Wed, 03 Dec 2025 06:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vQkyO-0007s6-3Y; Wed, 03 Dec 2025 06:24:40 -0500
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vQkyM-0000oO-1I; Wed, 03 Dec 2025 06:24:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPakGHyp3IrOVM5tAUYMCotgrHq3c+cpusc5DPeFKwo8kRfwTG8KuuzaGmduKMckkvN9vIIivLWMucYXIAHZQOVl/upXvC+35GKQkY0hKwTwG2+We98kj3Lho+w9DaFzgb8qjkKp9yXfTcPrPXU62eke8xeByAd6IJ5d1zkzNXTtyqpyqpOTFWPSFofPqR70tEuOYa/hwclbL9L8FhUjbKArlzaPXeZ9874Kv377hDULfKT4rRR9+Yh3s7RHZDEJNT/aKTmvcj4IZTVEhHPx8gBk0YDBN9rFFSgNFaWqWxc5oqQ1JA7GLUVy9aE85tGjg9AnExEXGcYuneRA4Xj3dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jydBE0kyHYloNmPGjchr/WWmN7DwHWqaezADMn94GGc=;
 b=AOcHwzgO1vkkgbjpij9uBLxXYryTzqgAo9WeItQp1LaS72TQkJooMPanga/WMO/iiGUyFNNy2opVYWyp5u4+M8DhFdllooOQxH7jXpvET+qZsHnWBdFUe/1leCgok349yaZUHI8hG5S71HPIbsb2g3Dp/ckcpnSCMS/J38oUzT+es+qCOcgK6qvcdvWAkmAMnNj62y2e878Mr65829qmGQbcznWhjsj/NKe/f0GORvILFK7GGOTT2BbokjX2bDg9tqyBC8iUuhu4M5i9JYPSVm21X/QNPQJg5kDDtEprqtNoWAOB0Gu9UpXKsOIifv3dxnrT45uL0/tV9OLJ0ziu7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jydBE0kyHYloNmPGjchr/WWmN7DwHWqaezADMn94GGc=;
 b=ToYVj1I9swZmpD1aTZOQr6akyJNTeuGk7vzHyOxbbtQeDk9j1VIJlWYJkwtd82lKf8Y4va4Er/qRYcSgcerWTdZeqTOwkv/0bLCiJAD6OsrpA6JdhJ7+WYGlZ4CddrjnkQpksKtDswNMvwIG2F78SQrkSIM8fausAYsl4Tvg+m/a0ExKIwtYno6TNFrl6zSSye6oxLsoLyX865I1+Cmm4ZBkR80WpjxQ+MzzXTiLoFVc9ZV6Rf/rnzLIorFAVmDLkACfhTQJMJ2Z6xH8g7BfULLgRCEXLZ9JeVXKsEQcIP1nE2XfjL38U7SWsHjTKLwKz0wWxx6IcJ/U9dfcez6DQA==
Received: from VE1PR09MB3471.eurprd09.prod.outlook.com (2603:10a6:802:b1::23)
 by PAVPR09MB6330.eurprd09.prod.outlook.com (2603:10a6:102:30c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 11:24:31 +0000
Received: from VE1PR09MB3471.eurprd09.prod.outlook.com
 ([fe80::ec5d:d9c5:f6b6:1f19]) by VE1PR09MB3471.eurprd09.prod.outlook.com
 ([fe80::ec5d:d9c5:f6b6:1f19%3]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 11:24:31 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
Subject: Re: [PATCH v14 00/14] riscv: Add support for MIPS P8700 CPU
Thread-Topic: [PATCH v14 00/14] riscv: Add support for MIPS P8700 CPU
Thread-Index: AQHcWGlzXWwAZOkBrEyyKNzERrDbDLUP3fUA
Date: Wed, 3 Dec 2025 11:24:31 +0000
Message-ID: <d11d7f92-d992-4d4d-8456-707cf42f93b6@htecgroup.com>
References: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR09MB3471:EE_|PAVPR09MB6330:EE_
x-ms-office365-filtering-correlation-id: ff7796a3-029d-4c46-ef99-08de325e8740
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UG9iZm5seUZJZTY4Z1laY3ZySFc5REpWWi9vOUNVbXJ6Zmc5eGRKam9sUXcz?=
 =?utf-8?B?NklkVisxRit4NkFxeHY3N29scnkwSkY2eVdBcHU2RHVObWhrOXJSeHMxdWpj?=
 =?utf-8?B?NnRWeEtkMUFsWGpkVVc3cllobk1lSWhoQ1pYYU1EQ25QaVpRczB4eWdvSUxa?=
 =?utf-8?B?bm9UMUVKOThaTDVUYlU0ZWZGL2VIMCtpaE1ybWc1dnE0MWdMRjRYYnp0QVpv?=
 =?utf-8?B?TUVFWUllZEp4T2RBQ2lMMUp3d1hiekpiQUMvcEQvMnRpSXNZajAvZk1xVFBV?=
 =?utf-8?B?bnl2VUtHa0JqWk0zKzFBZzI1NG5RZXFwTjU3N0FLaFBEN1ZxellBUVBtUlNs?=
 =?utf-8?B?bUU3SjQ1SDhoekFtQjdMTld3QWhxRG9PVG1Sd3g3dmJSODBLSkV5OEhPbTdS?=
 =?utf-8?B?N1VyNitGSkRVM2JwcDRMWlpaNTJxMjM2SGJKdFo5K0ozNk1RZVVOMm1rYTZa?=
 =?utf-8?B?MCtwV2cwTy95T1VFNVZ3MGt2elphWEtHVFZpNzlMV2s3T1F4bDE2SGIrK2o2?=
 =?utf-8?B?MWhjOVhVY0tHV2RkM3N5THpTdjNSTHBFbC9YY0gxdzE1VlBDVW5hVWl1dVFl?=
 =?utf-8?B?VHAzYkROTVNyeS9pL240MURzRGNjcXhXWVFxZFA2U3ZHSEJsc0FSc0k2Smtr?=
 =?utf-8?B?Qno5Y3VjQ1ZmOUlibUh4QXhtRm1jUkpsNkZKZjdOcTREd1VORlZmL1lOeEdo?=
 =?utf-8?B?VjdZbm9jUm9XQlFxd0kwK3VsVko2NW4vcTRrbEVFb2NEOE41NmpIcjlqVVlI?=
 =?utf-8?B?aTVuUUdkQmlYclRTZGtQVFBkaUpwMVcwMGF5SmdlOExjRk9tbEprL1R0dEM0?=
 =?utf-8?B?TnZXcGhRM2VraXMwSThIdnkyV3YyRHltWExudFMzMFlwTmJMcEpIK3RnZXN6?=
 =?utf-8?B?ZjRWMkI2dVlzdm9wdXcyeStSa1IyRTEvODVJbU9TL0p4dC8xWnBJQ1FuRTV1?=
 =?utf-8?B?MDVzVGdDdTRYZ1BaQ1ZDZThRMDg0UENOd3BNQThRdUZUc1MxY2RENjNJaXZx?=
 =?utf-8?B?VjZnODM1alRJdW5NcFYzV1ZWaktrTDJrcDFMVTh5bFNPUDlRaEw4ZXJSSXY4?=
 =?utf-8?B?Ykg0WjZGZ3hxQmR6Smp6dDg0UlJBRWp1UjhNbjRsNWlGUEdKekozUXFKQ1pE?=
 =?utf-8?B?V1p5ek44RWRtYUQzWFhTaXVDaG03djJBNUY4b0s5NHhKbFhTM3dxWHlZVGJx?=
 =?utf-8?B?TVBvNnRrWURrc0xrUW9xK2V2dUN5OWhLQ0JwOEZEaVlNS1R0Snd6eU9BT0lm?=
 =?utf-8?B?K0pvT1pscVRDNkJ4Y0NVdzZMeW1GMFlDT1BqcEY1M3lsV0Nnb2p4QnJDSzhX?=
 =?utf-8?B?R0N5UHg5enJNY21Wb1dubnhGRmp4UHoyOGhjSFpzRkpnQ3pzSkg3dzhMbGlw?=
 =?utf-8?B?TW44dnNRMDF3OFBVeklITnQ4M1hubHZLbVNQYkxRTSthRm8xMkhTYk1Tcnlu?=
 =?utf-8?B?MEZtK2pQOWdkUE5WamNWaUVRSWxnLytKUmx5c0FKMjRhdjVTVlEzMm9qSjYz?=
 =?utf-8?B?YThNQmdla0o3WWppK3pZVURVa1k3ZGJWSkJWNS8xc1dKN1F4a2k4ZDlmVmlR?=
 =?utf-8?B?NWhGZUdJMlpsUk9QelJvNDZndy9mOHd6QjEzS2JTQlo5WUprRVVYcDUzL3Vl?=
 =?utf-8?B?K1hTNTMxVHlRR1YycWllK2pSTGhodU9FRXRxS1ovUWNJTnFwbGtGbG1jcita?=
 =?utf-8?B?S1grWGorU1FoSEhuSmhYNWNveWM1T3FvSm9UVFc5NUNJNUcwZ3hPbzV1NWJU?=
 =?utf-8?B?QzhQK0ROVytwWjRmOGhVZmxlOU92S3F3TFZQenpna0lqUTA4NlBQdnN3NUdr?=
 =?utf-8?B?L2pxOXJDdExNYWh0UlA1NzJKcy9oaElQeENCdE1lRWhENDNRWWpzY1JncFRC?=
 =?utf-8?B?eWQrQ0ZhQmFCTElBclZCVXRXVzc2REhkcERIOXpXZjE4bm5jd0VqVWlGT1NO?=
 =?utf-8?B?dENTYkhUVWNFc0I5Q1ZYOGI5b2tFSU8yT2x4NkZ6bW5FRlhlRmNHcFIyMHFG?=
 =?utf-8?B?TTk4VDRxSlRpRGZTSEFweHhEdyttRGtxalREaTRaNGpHODUzaGtGZGMvSGly?=
 =?utf-8?Q?WxJJ/W?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR09MB3471.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1lnOEFtQUNnaWJ3VnlGUG1qT3dUQ2FFMzIwMEZsdzBVZnI4aW0xUFhRcW1l?=
 =?utf-8?B?b24wYTdmT2lqZms1Y2huZTUvb0dzMElOU1JJTW5ycXNVWnQxc2RwQ1lNM2Fz?=
 =?utf-8?B?a0RSdGtuTTFRcU9zdmVtTHdmNmQwejg0a3E4bFdkZG5OL2VWSlVDMmdRZGZF?=
 =?utf-8?B?NFY0eVRqc2xRM2lKaEhSVjh1UWo5RGpxaTk0NjI5TW1nVWh2S3NEeWdQTk5z?=
 =?utf-8?B?azVnMDcwTjc4eU9SNWt1Y1dSalpuZHBERXJpQjZSMUtnNEV2dHJOQjE0dmZG?=
 =?utf-8?B?TTYwbGlKYlFQN3llTm5UTXgxR1ZjSmFFeE0wSko2TGFyWEhVeUV5c2V2Z3Bv?=
 =?utf-8?B?UTFpQ3FmL3YvMG5qN01qNFJ2dHdnZ1ZMR1hUZDdNTWtuWkNxMW1zTVJhaENw?=
 =?utf-8?B?UDF3Z3lac0dvbDFlcnpqOE5ySjFidXUySlZIUU5zUVcvQ3NXYjNkOUQ3MHAy?=
 =?utf-8?B?d09ISzZWVnM1N0RZT1dBdFl3KzZIeUhlT2plQzZ5THRtTFhWZjhlZEczWHpP?=
 =?utf-8?B?TGEzSHpJNzJqUTAvQ2ltVUR4V1QwMENRbUtSNU1YZlVDZFhDMUk1SlJMY01F?=
 =?utf-8?B?S3JFdy9SbWhteFdjNlpKVFF5NzdQVnQ5Q0trekdsbVkxaUlhOVYxR0lpOXJI?=
 =?utf-8?B?YlFtNTJ4SFR1YU5GL3JNeHRxQjhyQnhvaXY2VmJPQU1nRWl5RkNMNXFDeXZ5?=
 =?utf-8?B?R21xOUVrOTYxN2tmdUYrOWdmdmdLNWFzRWFrSWVKNTBjMDFFYUxwdGNqaXJj?=
 =?utf-8?B?dEtMdzNFcGJ3RWx4amNMSmdIbXVNNEUwZTN3cWgvdFZ6VnhhcThSVEVMVXFk?=
 =?utf-8?B?TXBTaE9Cbms1VVZDNEJCRS9pMGtNeTNINytNUVArNk9EcmtwYmZtVlhKNms5?=
 =?utf-8?B?ck5LUE9JRmU0ZTI3VHpzMU5XclFnU2dqMkpMaWVFaUZ4QmFIZUtCMlRxTnhy?=
 =?utf-8?B?OE5WMDRBWXRNZW55Y2Z3eGsxQWZwU0JXNXA0amNNTDJVWDJLVUQ0ZmN5aXpo?=
 =?utf-8?B?YVFtSUZ5WnZOQmFibk5mYWtSTHllbzNCa3huVGw4WjFDSmdWMWJKM3V1N0c4?=
 =?utf-8?B?WmJ5cEx4MTNDck5icnczODRTQldwL2E1WnUxMkRPWGRPOExxRXRMYmx0Y2dx?=
 =?utf-8?B?NlR6d3ZnaGFzeHdwR0toSExlS0NTaUlsc3p6dDV1YWtCcEsrV093aCs5aXhV?=
 =?utf-8?B?WmQyVW13dXpQbjByaTIyTzJPenBWQzhwSjlPdWo5SFYveWxXYUdHN2pIYUhu?=
 =?utf-8?B?K0JzYnNVK0EwWk9NN0k2QjlxWVFNNzhsT3lKOVg1b0Z3WVlNeHhDR1MyaVRr?=
 =?utf-8?B?QmdrTmtoeUcxUzc2SjFsT3BIZXZtWGVjZTVIaHhQSGJNNEtqUjR6ZkdPS045?=
 =?utf-8?B?T01XTVAzeitER0VWMUw4VWZNNktLRnhWeWwwNUJJYjVoak5mQnpXbC9ycEdK?=
 =?utf-8?B?VHhvTVVIM0ZjSlVvQTBPVTh1NDlkcGpBKytZSjFEUW4rN092eEdCQ1ZtYzVW?=
 =?utf-8?B?dVpsVi9OclFNbG9OYTU4OXRSektGam9HWDJtbnM1WVZMRTVwV29BNE1HUlNu?=
 =?utf-8?B?cythbGxOdWwwK3ErZjREV1pyTzdINlI5T1JPRmswalFpT0dEWi94YytHOWdI?=
 =?utf-8?B?bUhoTVMya2xTOERTSnFMSERpVGRjV2poTlhkSXhISThqbW56eDNnVlRqaGhv?=
 =?utf-8?B?eWNzSnp6MHBTQW5qV1ZDT3NQelN6alZxUUVGVEJGZlkxUkJ2T2drV2hQMThY?=
 =?utf-8?B?dWJNeEhPSmZpYWlVTWlEbS9YSFZ5TkJYQ2hVY3VEOGNIVWhpcHV6c3poa2Ex?=
 =?utf-8?B?cU1hMm42Szd5WlhBYzZaeDhmbjVlU1V6cWlIZkdReUhrSitQa3Zna0pSUzNH?=
 =?utf-8?B?aEovUEVyR3JHdEdKWkIwSmFVbFMrYThMNE9nYmwyK2FzSFIzQWk2M0orSGlS?=
 =?utf-8?B?UWFyYWJ4ZzlOaVR4REk0VEgzY09URitpZ2wyeGFqVDJtVktURzZseUJndFM0?=
 =?utf-8?B?Tk1LeEoyTjN5Y045b3N6TWxaU2dSQmFmdGQ0bjNXSnVDRFI5elFOMktiTWtw?=
 =?utf-8?B?ZmJlNmYrcEYyK1BtTUx1STdIMmlyTnFoTlYrTUFObUdCVjVWV0R0VXp1S1Rp?=
 =?utf-8?B?K1A1Q0FZS21raUJHZDBtV1JOdzlTeEEyMSt2S3hNbWp6M0FseXdIdC9lelhC?=
 =?utf-8?Q?UTjy1whPgDHZpG4eoZkt8Ks=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA8EF69F60851C4EB4AD7A6BD5845E7B@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR09MB3471.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7796a3-029d-4c46-ef99-08de325e8740
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 11:24:31.0505 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tyGSTpbELt5cLBLqO2b5QWOL9ZTn9ik7UJY8wz4koFtdlja/aOK6djrk2Ib67EsgofpV4aQq0Km3T7JBdUv3xbJ1+ehE1+bRQYdlGjOEbuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR09MB6330
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

SGkgYWxsLA0KDQpXaGF0IGlzIHRoZSBzdGF0dXMgZm9yIHRoaXM/IDopDQoNCkJlc3QgcmVnYXJk
cywNCg0KRGpvcmRqZQ0KDQoNCk9uIDE4LiAxMS4gMjUuIDA5OjU4LCBEam9yZGplIFRvZG9yb3Zp
YyB3cm90ZToNCj4gQWRkcmVzcyBzZXZlcmFsIHRoaW5nczoNCj4NCj4gLSBNb3ZlIGJvc3RvbiB0
ZXN0IHRvIHRob3JvdWdoIGdyb3VwDQo+IC0gQWRkIGNoZWNrIGZvciBERVZJQ0VfTkFUSVZFX0VO
RElBTiBpbiBjaGVja3BhdGNoLnBsDQo+IC0gQXZvaWQgREVWSUNFX05BVElWRV9FTkRJQU4gaW4g
Q01HQ1INCj4NCj4gRGpvcmRqZSBUb2Rvcm92aWMgKDE0KToNCj4gICAgaHcvaW50YzogQWxsb3cg
Z2FwcyBpbiBoYXJ0aWRzIGZvciBhY2xpbnQgYW5kIGFwbGljDQo+ICAgIHRhcmdldC9yaXNjdjog
QWRkIGNwdV9zZXRfZXhjZXB0aW9uX2Jhc2UNCj4gICAgdGFyZ2V0L3Jpc2N2OiBBZGQgTUlQUyBQ
ODcwMCBDUFUNCj4gICAgdGFyZ2V0L3Jpc2N2OiBBZGQgTUlQUyBQODcwMCBDU1JzDQo+ICAgIHRh
cmdldC9yaXNjdjogQWRkIG1pcHMuY2Ntb3YgaW5zdHJ1Y3Rpb24NCj4gICAgdGFyZ2V0L3Jpc2N2
OiBBZGQgbWlwcy5wcmVmIGluc3RydWN0aW9uDQo+ICAgIHRhcmdldC9yaXNjdjogQWRkIFhtaXBz
bHNwIGluc3RydWN0aW9ucw0KPiAgICBody9taXNjOiBBZGQgUklTQy1WIENNR0NSIGRldmljZSBp
bXBsZW1lbnRhdGlvbg0KPiAgICBody9taXNjOiBBZGQgUklTQy1WIENQQyBkZXZpY2UgaW1wbGVt
ZW50YXRpb24NCj4gICAgaHcvcmlzY3Y6IEFkZCBzdXBwb3J0IGZvciBSSVNDViBDUFMNCj4gICAg
aHcvcmlzY3Y6IEFkZCBzdXBwb3J0IGZvciBNSVBTIEJvc3Rvbi1haWEgYm9hcmQgbW9kZQ0KPiAg
ICByaXNjdi9ib3N0b24tYWlhOiBBZGQgYW4gZTEwMDBlIE5JQyBpbiBzbG90IDAgZnVuYyAxDQo+
ICAgIHRlc3QvZnVuY3Rpb25hbDogQWRkIHRlc3QgZm9yIGJvc3Rvbi1haWEgYm9hcmQNCj4gICAg
c2NyaXB0cy9jaGVja3BhdGNoOiBDaGVjayBERVZJQ0VfTkFUSVZFX0VORElBTg0KPg0KPiAgIGNv
bmZpZ3MvZGV2aWNlcy9yaXNjdjY0LXNvZnRtbXUvZGVmYXVsdC5tYWsgfCAgIDEgKw0KPiAgIGRv
Y3Mvc3lzdGVtL3Jpc2N2L21pcHMucnN0ICAgICAgICAgICAgICAgICAgfCAgMjAgKw0KPiAgIGRv
Y3Mvc3lzdGVtL3RhcmdldC1yaXNjdi5yc3QgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgIGh3
L2ludGMvcmlzY3ZfYWNsaW50LmMgICAgICAgICAgICAgICAgICAgICAgfCAgMTggKy0NCj4gICBo
dy9pbnRjL3Jpc2N2X2FwbGljLmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDEzICstDQo+ICAg
aHcvbWlzYy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxNyArDQo+ICAg
aHcvbWlzYy9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMyArDQo+ICAg
aHcvbWlzYy9yaXNjdl9jbWdjci5jICAgICAgICAgICAgICAgICAgICAgICB8IDI0MyArKysrKysr
KysrDQo+ICAgaHcvbWlzYy9yaXNjdl9jcGMuYyAgICAgICAgICAgICAgICAgICAgICAgICB8IDI2
NSArKysrKysrKysrKw0KPiAgIGh3L3Jpc2N2L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgIDYgKw0KPiAgIGh3L3Jpc2N2L2Jvc3Rvbi1haWEuYyAgICAgICAgICAgICAgICAg
ICAgICAgfCA0NzYgKysrKysrKysrKysrKysrKysrKysNCj4gICBody9yaXNjdi9jcHMuYyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTk2ICsrKysrKysrDQo+ICAgaHcvcmlzY3YvbWVz
b24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMyArDQo+ICAgaW5jbHVkZS9ody9t
aXNjL3Jpc2N2X2NtZ2NyLmggICAgICAgICAgICAgICB8ICA0OCArKw0KPiAgIGluY2x1ZGUvaHcv
bWlzYy9yaXNjdl9jcGMuaCAgICAgICAgICAgICAgICAgfCAgNjQgKysrDQo+ICAgaW5jbHVkZS9o
dy9yaXNjdi9jcHMuaCAgICAgICAgICAgICAgICAgICAgICB8ICA2NiArKysNCj4gICBzY3JpcHRz
L2NoZWNrcGF0Y2gucGwgICAgICAgICAgICAgICAgICAgICAgIHwgICA0ICsNCj4gICB0YXJnZXQv
cmlzY3YvY3B1LXFvbS5oICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gICB0YXJnZXQv
cmlzY3YvY3B1LmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDQ0ICsrDQo+ICAgdGFyZ2V0
L3Jpc2N2L2NwdS5oICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNyArDQo+ICAgdGFyZ2V0
L3Jpc2N2L2NwdV9jZmcuaCAgICAgICAgICAgICAgICAgICAgICB8ICAgNSArDQo+ICAgdGFyZ2V0
L3Jpc2N2L2NwdV9jZmdfZmllbGRzLmguaW5jICAgICAgICAgICB8ICAgMyArDQo+ICAgdGFyZ2V0
L3Jpc2N2L2NwdV92ZW5kb3JpZC5oICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICAgdGFyZ2V0
L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNfeG1pcHMuYy5pbmMgICB8IDEzNiArKysrKysNCj4gICB0
YXJnZXQvcmlzY3YvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgIHwgICAyICsNCj4gICB0
YXJnZXQvcmlzY3YvbWlwc19jc3IuYyAgICAgICAgICAgICAgICAgICAgIHwgMjE3ICsrKysrKysr
Kw0KPiAgIHRhcmdldC9yaXNjdi90cmFuc2xhdGUuYyAgICAgICAgICAgICAgICAgICAgfCAgIDMg
Kw0KPiAgIHRhcmdldC9yaXNjdi94bWlwcy5kZWNvZGUgICAgICAgICAgICAgICAgICAgfCAgMzUg
KysNCj4gICB0ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvbWVzb24uYnVpbGQgICAgICAgIHwgICAy
ICsNCj4gICB0ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9ib3N0b24ucHkgICAgIHwgMTIz
ICsrKysrDQo+ICAgMzAgZmlsZXMgY2hhbmdlZCwgMjAxOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0
aW9ucygtKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkb2NzL3N5c3RlbS9yaXNjdi9taXBzLnJz
dA0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9taXNjL3Jpc2N2X2NtZ2NyLmMNCj4gICBjcmVh
dGUgbW9kZSAxMDA2NDQgaHcvbWlzYy9yaXNjdl9jcGMuYw0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCBody9yaXNjdi9ib3N0b24tYWlhLmMNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvcmlzY3Yv
Y3BzLmMNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9taXNjL3Jpc2N2X2NtZ2Ny
LmgNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9taXNjL3Jpc2N2X2NwYy5oDQo+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvcmlzY3YvY3BzLmgNCj4gICBjcmVhdGUg
bW9kZSAxMDA2NDQgdGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNfeG1pcHMuYy5pbmMNCj4g
ICBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0L3Jpc2N2L21pcHNfY3NyLmMNCj4gICBjcmVhdGUg
bW9kZSAxMDA2NDQgdGFyZ2V0L3Jpc2N2L3htaXBzLmRlY29kZQ0KPiAgIGNyZWF0ZSBtb2RlIDEw
MDc1NSB0ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9ib3N0b24ucHkNCj4=

