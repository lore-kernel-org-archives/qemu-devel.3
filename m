Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3A6CA0FE8
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 03:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usuxe-0006ax-W7; Sun, 31 Aug 2025 23:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=33215a4d2=wilfred.mallawa@wdc.com>)
 id 1usuxb-0006Zz-NC; Sun, 31 Aug 2025 23:12:00 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=33215a4d2=wilfred.mallawa@wdc.com>)
 id 1usuxY-0001aS-7P; Sun, 31 Aug 2025 23:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1756696315; x=1788232315;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=JeztKgGNo4FVfiaFbGqwzeBIZ2nC9AXX+3Zc+ululH0=;
 b=Axqibxy/R0mB0Aw5y1BjiTxM8ua2RU3x2oAaI/ZRN0dwVJbPnNvVcKKC
 PXyqNSgy9FZqkIcKzyC/Wn4Qzvb+PG3k3yOH0+8Th3JDqhHGOw7t5VUms
 jUP3NBJNvPtsjUHFxx9ddntm2dMlxLY1OftvD+ifizFLEMYxDzw7Y3vxB
 omLjsM7X+FkuSGkFVpfoQi2CqqFJ/iyqi13i7KZ6XWbEh9pqOeXGZgOvN
 2WIUNHvth3ywRYcIC57b8JU2t6Ig1259VT2y+XpolIa0Whu4tbR4tWT1U
 iWVahKudpsz0HBUCudv81hGW9bRZO8ACru2z6/ZSaQTYOvfB9UikRWIJP A==;
X-CSE-ConnectionGUID: KJkv2Xz+SO2dqkM6KH2+Mg==
X-CSE-MsgGUID: 2pTtdpSLRF+TlPrCjQIFSA==
X-IronPort-AV: E=Sophos;i="6.18,225,1751212800"; d="scan'208";a="106111619"
Received: from mail-bn7nam10on2054.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([40.107.92.54])
 by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2025 11:11:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vwVMURS9e3tMfKb/rXBlIY3Ymw0OizFT1/AQHn4kD7BKBX9/yjPXS2J0oFLMueud7FkQD+/+5ylqqZsBglKIrO34ZQoukk5QMnyKTRhnQpThdHx5yBzgfMgObKmhjlUfUPU9WOvccCY4iVuYv3HlOqo/icXD8H+geXfxXN81IjKpXuEG30y+3OHYyZ8AdrdyGSBl8kBUnHtHT+5k1d6JeDo+FnI0j12BWWaQ9TJ0SYbdoCaasvqbU4xoGGpurtmQ9j9uLYg7Gxv039WCmikxjFI+IJQDhKbrORMVR8w85Ezz0dDIP6lQhubgJ8tefan7iJkM8ki/YbiGcqHDb2kMgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeztKgGNo4FVfiaFbGqwzeBIZ2nC9AXX+3Zc+ululH0=;
 b=IgXbB7/VfnPILS6/0FAC7v0vOKZBGPEAgz7E8xiFA5lN/VBrkyx1RxnWmAw5UKh7WhTP+i91ViZ7jBfjhWOLmNr+bOQgqy4uqchtVOqrfPhusqFHijVNqRaYEkRAGjjNvBmyyn8mbRcqi3gHLZPz+B48w+OnhiWJT1YqB2fn5rwD5Dv6MkshCfxbwU8kiGo7Qpfp71emd9cKdbOBcbbklYyYP2Gp1XbFgwXnfaRfLj1eomXjsMNI7MZe7FqdZiquXtMymqBKZ+Rr8lnvQzZTAQ+myVUzKwh6pqkqCiU6nivo49efbydmHyQ712NdDy7G+UDl1sStmUPYGz4KtOUVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeztKgGNo4FVfiaFbGqwzeBIZ2nC9AXX+3Zc+ululH0=;
 b=XgF2H/vcCGdCgGQoNM1atswF438GgG5OosAkllOhoCs5uCfAGVPe6rSG0hO9a++//08cvGRDZktg1c/5aAZgbg+BeOLrdYxeNDu++53lffgQuiSo9/i7h8ESUkIFnAsFD0NwEIjS88V3xL0gvjSxU0yBWfKncC5qTe4YRsmkVik=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by PH0PR04MB7623.namprd04.prod.outlook.com (2603:10b6:510:51::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Mon, 1 Sep
 2025 03:11:42 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.9031.014; Mon, 1 Sep 2025
 03:11:42 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>
CC: "its@irrelevant.dk" <its@irrelevant.dk>, "hreitz@redhat.com"
 <hreitz@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "stefanha@redhat.com"
 <stefanha@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "foss@defmacro.it"
 <foss@defmacro.it>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "Jonathan.Cameron@huawei.com"
 <Jonathan.Cameron@huawei.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 3/5] hw/nvme: add NVMe Admin Security SPDM support
Thread-Topic: [PATCH v2 3/5] hw/nvme: add NVMe Admin Security SPDM support
Thread-Index: AQHcF+0OLv5IHZFnf0aKsePpHSSuqbR6mkUAgAMSJgA=
Date: Mon, 1 Sep 2025 03:11:41 +0000
Message-ID: <9b606dc9fbc403766eb7a925143e8c6b00a9bd3b.camel@wdc.com>
References: <20250828072532.425592-2-wilfred.opensource@gmail.com>
 <20250828072532.425592-5-wilfred.opensource@gmail.com>
 <aLJ7dKOgu-tJvk28@kbusch-mbp>
In-Reply-To: <aLJ7dKOgu-tJvk28@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|PH0PR04MB7623:EE_
x-ms-office365-filtering-correlation-id: 7a310f2a-17fe-4a16-4857-08dde905465c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|19092799006|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?M2RDRnJMbTA4TjlYWU11dHF6L3RWS2l6dnRjOUZYSWtrYWNvM1BDMk5ZU09S?=
 =?utf-8?B?eVBJbEVGdUdTbHVSdm5qdWw2aGlTQis2ZG4vWTRXOGV0YWZPUTBhNEkrODVW?=
 =?utf-8?B?b2twOUU4NUVtZGRPWmpGSTQyejhzeXNDcXlPRWthWmhzaUtGa3R6a01BZ1VH?=
 =?utf-8?B?ME12bWpTaTJsRVU4R3ZGSFVLcmNybnVjMFJjNFMvS1gzZlNNVWNVc2lRdVhJ?=
 =?utf-8?B?dmdxcGVuTk5lSWpIeGRoKy9DYWduV2k1cXFpNVJ5VHlsZFdDL2h0dSt0eVlH?=
 =?utf-8?B?UmZtNWhmRWhEdmJLb3ZSWmdTMTVFb3VRRHZrVW4zVHFsMUVmYWljbHV1UFps?=
 =?utf-8?B?RkM4UjlpcVl6SzF4R1cxOGtGaTVLcEFMc2U0NlE1bkh6NXFtRUpNOG1Sd0Uv?=
 =?utf-8?B?OHhQM2IxWm1XaVNDUWR1bVBVT0lrWWJ2VHdXbVRBRWlGRmxaZ0JPSCtVTjNY?=
 =?utf-8?B?MnlsM2dTbjdhcGV2SHJRMnBPeFcwTnRwTTJ1NFFzT05GQm45Y1FIbldrV2pk?=
 =?utf-8?B?cGdubTVDVEdBUDJFUW5PK3RJcnVmRnhIUHhHbmVGczRIQ3VyM0lJanIzNmF2?=
 =?utf-8?B?ZXJzMDN0bHdVSmEyUW02OVgycmU4em9laFJvZEt5dXZ2Y2Jia1g0WHhNY1JL?=
 =?utf-8?B?cmNiNzYvQUthMHZqQlJDVVFabjlHRUtGOFpiNGFDTDNOeGc2Q1l5OFBFQkl0?=
 =?utf-8?B?WHd6cUZPVkV4OW9TVk5NTFlVU0JhWXFUb0NoYk9KbGZyWjRoekVJUENzc2do?=
 =?utf-8?B?RGNHZS9QWit0c3RsNFIxUnhTWVVROVVCaWt6VThuT1dGZHNNMHdTRnQwZ0lu?=
 =?utf-8?B?MmY4U1VzYWJ4Z1NpQU5tZUJ5elBIN1FIcUE1ZGp1Q1JXeDA4bVhuUHM4bzFL?=
 =?utf-8?B?SkxNalhqeXF4cm1ueGtWQ3ZSMklKdzE4ZFhtZTU5clFkKzBPQVdWRUtaN3ZV?=
 =?utf-8?B?SHppdWxJMjlrcTJpQm9VRDE5YXM1YnhycFIvc2tEcmlXUUl5YTcyVVNJQTlu?=
 =?utf-8?B?QkRQN0ZadWx2Zm5QY09tTEdsNDRsUkdLMEFrM1pyd3VzMFlhZFNFejA3cWNL?=
 =?utf-8?B?Q2ZOWEhEbHo3Q3FHeGF4VENZTmdQeFJYcE9kQXNrbmFNSFQ4YnkyNm5vZk1w?=
 =?utf-8?B?QVRkbDhqa2g4RVl1OEFKVWs5RGNGQjhaRytRNi9KTjdRckdJY1FrMlQyc1k4?=
 =?utf-8?B?MnRaZ2ZiTnU3UWo0ekttNEtZR1dRN3JPRFRrS1I2aCs2M21UVFk0QXlvWldk?=
 =?utf-8?B?UkFHOWNFei83Ui9KaWJFNnN6amxZS09vcW1McExHS2srOFBKQmlhOEhJa283?=
 =?utf-8?B?bjdVVEVySHpBY3V5Qm40d2ltRlBJUmJkaUZ0WVZKTzV0aTRYNnRUNytOM3d2?=
 =?utf-8?B?Q1Nmd3lqL1U1alI2RkExcFRQVldMT2liU3psUHIycUhRdmc5SmIxOXlkYU1j?=
 =?utf-8?B?QWNiRU1WK3E0bitpQmFCMjU1K1plUGJOdmlhdi9tay84R3BBQ3JNWUt3YThn?=
 =?utf-8?B?VmdvRmxBOU1BZW1tNUhKdmM5a2R3MzRGV05zSm5oSHc4MzZ2TlhuV1dqRGR0?=
 =?utf-8?B?TWVaWlV2S1VmY0RWcjlRcldQMzlhazZ3cTd5eVRrMmgzcGxKTVVWUXBlSTRx?=
 =?utf-8?B?SXo5R0g5aGxHOVc4U3Z1NUx0VjJjbUJCMnI1VDVDdStNektxUVJVRzZoM09l?=
 =?utf-8?B?WWpzZWl3OFlrTkJnbnJFcFZVK09MVUpaMFdROXYwYlBMZHQ0Zlk5Um45TUwr?=
 =?utf-8?B?RHdNV2hlZkkrNkpORnBickgvYVlLZ0lUcjNsY1JMWHVsV05SenhlcVp6b2RK?=
 =?utf-8?B?YlhyUDB3YngvVXhIRUU0cGZNQ0pZQ0VBb3MrelB6R2x5N0VjQXVtd3o4V3ZX?=
 =?utf-8?B?WDVmQWxvRGxXU1NJTS9XcCs1MFNRMGw1K0JLQnlwcFVDeDhrOHU1TEZzRTRz?=
 =?utf-8?B?aEJGU3M3RkVSVmFXUzFOaHEzVHRIbkxXVU9JSWhvUEloZ3Q0a1ZTNzBTOE4z?=
 =?utf-8?B?ajBON2N2bTBRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB8549.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFBaWWhCd3gzWVlGZk4yQXo5L1FIVG5qd0dTQjVIb1drelVZVFlGcnBLTG1x?=
 =?utf-8?B?RTNuQmxGRkFjYUpWbDMwNVlzL3hiTEN2OHpPaDBsUExKK3N5K2k4Q0h5eXhp?=
 =?utf-8?B?UlpkeWh4WHBVKzJkSGdlc3NFYXhpcmRQaFBPNTRhWGFJVmU3N3JZYysxbHlM?=
 =?utf-8?B?QXFLdmNzbjNSWWVuVUpTdDFaamZBdzNSZkdzTm9kL3ZwZXVLZFBicG05bHRU?=
 =?utf-8?B?TzRBOTdaUE9XQ2paaHpQNFVtL3ZNN2tBbVY5WlhPSWhjMk14eWVNakxCYnNM?=
 =?utf-8?B?VXJSQjVRT3NkRlZvSThNbU03ZG9vMHV3Z2h2NllFakM2M1VWcE1TVUhORlJY?=
 =?utf-8?B?d2JTakRXZkYvWTViejJ4eHkrVVVKTFJHY2cxWVpkL3VnNkQ1OFlUVWw3QjVz?=
 =?utf-8?B?dDBxMHoyc3J3UmpBRzNzZFE3SmpkVmVReG9CK3draFBDRndrNHVsLytZdEtE?=
 =?utf-8?B?V2pSVnErWUJxRGNZWUM5VFM5SVZFT1BHQWlPemJBWG05cVJvZEg4UHI1V1hr?=
 =?utf-8?B?dkhUNXNoQ0tXOVZGK3c0WnpJclpjWldqdXBLSXpBMUtWOGlnenlyQVFyL2V5?=
 =?utf-8?B?NFkySXBET0tvNkthRVhQNjRQK2RJSkhLUWNGZDhXV29JTWNsalhLVjI4YXA5?=
 =?utf-8?B?c3JUaFg0Qi9xL0piNnlDNkNjQVZRemlwQ3NZb3FRTWtQeWVXQUMyZnJnc0xi?=
 =?utf-8?B?UStnYzFJd0l3eEhvb1Boa2l5TVdyV1RzUHRRZ3k2Z1N5RThFY2xRc0QzODhU?=
 =?utf-8?B?bFYyZkdGS01nUzZ3ZG11TUhEUW1Ud2Mra3RvbFBXZW9ZV2ZqeXRrZG5uOG96?=
 =?utf-8?B?SGRoNmtmSjJyUXlsQjAvSTlqMDBPa3l6dy9qSWdJZTBiajlhWDhqOUF5MlNU?=
 =?utf-8?B?VEJlRHl1azBqaHlNV0dXL2VuZmFGZkkwaklsTTZnQmpUN3hxSVpDOSs0OUpW?=
 =?utf-8?B?OUppdjBRMnVsVnV2WjRvNVZvR2tubHJ5MFhaeEJiNXRqQUFkMGRjN283UStU?=
 =?utf-8?B?VUw0SkZJQldZNmhTVnlOSU82RDJTb0tnNEw3ZmNGZW1UWVUyZjJFNXgwQVhh?=
 =?utf-8?B?UktkWWg1NWtiQklGakRNVVJhK2twdmpFSDhQaENTZWtxd29DT2h5Y3VCOWNj?=
 =?utf-8?B?SmQxS2RDc1V3ZmRBRVFHOWdYWVNkNCtiRWM0eGIvUXZDdWxWMnJXWjdlaWVa?=
 =?utf-8?B?VFFNLzFyaVBQR0MxR0ZkNnBJRnlDcmZ5UmxUZHpEa05XRjFnOFhwMmNTZXNP?=
 =?utf-8?B?RENTNXFBeXcyYTNCWXNYTHdHUXBsSlFVU0tyNHpDZ0xuaWV4ZWFYVUU2dWhF?=
 =?utf-8?B?emZmLzJvKy9uTDNOWnJoemlBc0Y0YWJUSkQxM0U4ZEpURFk1emlwVXZwQXNP?=
 =?utf-8?B?ZE5kemp6eVNlbS93SW84Mk44SGNMRSt0UWN4R05VZXM4dU1hS2tYazJlWVFr?=
 =?utf-8?B?U2NLcE44czFkWm1yWk1QejkvMTNnVnJsVWtPYjh2U0lERGxIT0lzVlVidnZR?=
 =?utf-8?B?WDZKeEJXMjhSdGdJTVI2MHNaUGxjSmpGeldiVVhIRHd4ajgzMkpYL3FMWEdJ?=
 =?utf-8?B?blNmaGhHRTFYV2h1ZFlnVllDRGsrVzJucVV3ejRNSzRWRDlFSUtRRnlYYnRE?=
 =?utf-8?B?WmpXOGZCdEtidEdLVmVVaGk3Y3l5RWlNdDBGbE90QVVGcjY5akJpVmFrbWxS?=
 =?utf-8?B?eFNUNWgvWUhzTHY0YThOQkFFaWdIb05qWWxwckd2QXpXSHNKVXhHOWdNUHJj?=
 =?utf-8?B?QVdtMnhZaEVLeWRsR0VNdG5rSy9aUElZZGhhWWFGWnpKUmpvcnB4WW9GREM1?=
 =?utf-8?B?bm5ndU5PVFZCaDZlNkpXd2JtV2p2eUJ2ckRRMnNZaFB0NE4yZzRYa0p2ejNm?=
 =?utf-8?B?OGRBR0xJdEFNWnN5em5Rb0dyaDJrOUZsR1AzNkNQMWVKZkM5MGQ2RUp2cjNs?=
 =?utf-8?B?Mkc5QlVpMzFadElvTUtPWGxXTDg1RjVId2lrQUNMUGlaK0xHOExXckFwQkpt?=
 =?utf-8?B?UHFQN0VJTXFvcHNDQkpkT2NuRmRvdHRJOHpaOVVZMTQveXFQejNYNU9rN3RP?=
 =?utf-8?B?NWJlNWplMEd1OWhVaHlKTEgzVHVPRGNtVW1JS1dMSFdaWWFGb2MyUVpkOGx6?=
 =?utf-8?B?WVRWSy9QTHpycTA4Vi9OaHNFTElQcktiU1JXMW1QV0VVd1FiWit1YUV4MFpq?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF41015EBA550D4E85FF04BB49B326ED@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 310U+vXVjafIzbpZJU/KlqJJODDGEw9FENEe6O1y+45uoBbBQNDAC8uV4ROH/D9db4qCHcBLB2O3fSPZ4oQO4svBaE8FJO0raLGGluFxF6sAVO0F3Ebl7Appe37v2bh6LOr/cpt0NH9tATBkRM9m6DQt7XORK92JeNr+J8mdLzF/A8/gqD3n+PpfcsQgeI5Yv2Foo/SV9wCln4PE7vBptXsgI5Sv7+wa3npQHlQMOD3vrdQekIz6HVVyzmxyM79g2QYMuanSox9Ap9eutmNtTNKB7DJDctb3qB+Qz2/BApu+vU1tBxAYvgUraUZgIA2avkIfSkrtDvpy5BKUAt9pZ+l51mRHKiDZXPopLr5JD8+CZO4Qh92glT4PyksXAJ1xDSsAk91GXfU4BCjXyEbaET8T6CgPzCZwnqMFis+DFhNVpijRgnvslIELeJ6rZuwSpmX8Bc3IsvTR9/lub54mlP08XWdFVVnCToxKoKvPy3Auje+wfyVa3/VjXlN2goK2ylgN1nWAskBgnHPWOfDSNseDMR2S5Q7TqRqi/w3Yor/hb+JcifyLPE2oM4/ceiEQlvRJ0oPkrsjtRnn6HlKe2VznJGRsKFUdTu19L/n57ruapWVQsDn+UMtCp6IJ+wWs
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a310f2a-17fe-4a16-4857-08dde905465c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 03:11:42.0649 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eBL8sQoV4RfvBiMhcbLxxmrgWzjlJafFa8tQ8YuFI5FOJB3FLLgzZaczZ0kY4IDbCGy7/mk+E5OAnjd7fqcsWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7623
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=33215a4d2=wilfred.mallawa@wdc.com; helo=esa1.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

T24gRnJpLCAyMDI1LTA4LTI5IGF0IDIyOjE3IC0wNjAwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4g
T24gVGh1LCBBdWcgMjgsIDIwMjUgYXQgMDU6MjU6MzFQTSArMTAwMCwgV2lsZnJlZCBNYWxsYXdh
IHdyb3RlOg0KPiA+ICtzdGF0aWMgdWludDE2X3QgbnZtZV9zZWNfcHJvdF9zcGRtX3NlbmQoTnZt
ZUN0cmwgKm4sIE52bWVSZXF1ZXN0DQo+ID4gKnJlcSkNCj4gPiArew0KPiA+ICvCoMKgwqAgU3Rv
cmFnZVNwZG1UcmFuc3BvcnRIZWFkZXIgaGRyID0gezB9Ow0KPiA+ICvCoMKgwqAgZ19hdXRvZnJl
ZSB1aW50OF90ICpzZWNfYnVmID0gTlVMTDsNCj4gPiArwqDCoMKgIHVpbnQzMl90IHRyYW5zZmVy
X2xlbiA9IGxlMzJfdG9fY3B1KHJlcS0+Y21kLmNkdzExKTsNCj4gPiArwqDCoMKgIHVpbnQzMl90
IHRyYW5zcG9ydF90cmFuc2Zlcl9sZW4gPSB0cmFuc2Zlcl9sZW47DQo+ID4gK8KgwqDCoCB1aW50
MzJfdCBkdzEwID0gbGUzMl90b19jcHUocmVxLT5jbWQuY2R3MTApOw0KPiA+ICvCoMKgwqAgdWlu
dDMyX3QgcmVjdmQ7DQo+ID4gK8KgwqDCoCB1aW50MTZfdCBudm1lX2NtZF9zdGF0dXMsIHJldDsN
Cj4gPiArwqDCoMKgIHVpbnQ4X3Qgc2VjcCA9IGV4dHJhY3QzMihkdzEwLCAyNCwgOCk7DQo+ID4g
K8KgwqDCoCB1aW50OF90IHNwc3AxID0gZXh0cmFjdDMyKGR3MTAsIDE2LCA4KTsNCj4gPiArwqDC
oMKgIHVpbnQ4X3Qgc3BzcDAgPSBleHRyYWN0MzIoZHcxMCwgOCwgOCk7DQo+ID4gK8KgwqDCoCBi
b29sIHNwZG1fcmVzOw0KPiA+ICsNCj4gPiArwqDCoMKgIHRyYW5zcG9ydF90cmFuc2Zlcl9sZW4g
Kz0gc2l6ZW9mKGhkcik7DQo+ID4gK8KgwqDCoCBpZiAodHJhbnNwb3J0X3RyYW5zZmVyX2xlbiA+
DQo+ID4gU1BETV9TT0NLRVRfTUFYX01FU1NBR0VfQlVGRkVSX1NJWkUpIHsNCj4gPiArwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIE5WTUVfTk9fQ09NUExFVEUgfCBOVk1FX0ROUjsNCj4gPiArwqDCoMKg
IH0NCj4gPiArDQo+ID4gK8KgwqDCoCAvKiBHZW5lcmF0ZSB0aGUgTlZNZSB0cmFuc3BvcnQgaGVh
ZGVyICovDQo+ID4gK8KgwqDCoCBoZHIuc2VjdXJpdHlfcHJvdG9jb2wgPSBzZWNwOw0KPiA+ICvC
oMKgwqAgaGRyLnNlY3VyaXR5X3Byb3RvY29sX3NwZWNpZmljID0gY3B1X3RvX2xlMTYoKHNwc3Ax
IDw8IDgpIHwNCj4gPiBzcHNwMCk7DQo+ID4gK8KgwqDCoCBoZHIubGVuZ3RoID0gY3B1X3RvX2xl
MzIodHJhbnNmZXJfbGVuKTsNCj4gPiArDQo+ID4gK8KgwqDCoCBzZWNfYnVmID0gZ19tYWxsb2Mw
KHRyYW5zcG9ydF90cmFuc2Zlcl9sZW4pOw0KPiA+ICvCoMKgwqAgaWYgKCFzZWNfYnVmKSB7DQo+
ID4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBOVk1FX05PX0NPTVBMRVRFIHwgTlZNRV9ETlI7DQo+
ID4gK8KgwqDCoCB9DQo+ID4gKw0KPiA+ICvCoMKgwqAgLyogQXR0YWNoIHRoZSB0cmFuc3BvcnQg
aGVhZGVyICovDQo+ID4gK8KgwqDCoCBtZW1jcHkoc2VjX2J1ZiwgJmhkciwgc2l6ZW9mKGhkcikp
Ow0KPiA+ICvCoMKgwqAgcmV0ID0gbnZtZV9oMmMobiwgc2VjX2J1ZiArIHNpemVvZihoZHIpLCB0
cmFuc2Zlcl9sZW4sIHJlcSk7DQo+ID4gK8KgwqDCoCBpZiAocmV0KSB7DQo+ID4gK8KgwqDCoMKg
wqDCoMKgIHJldHVybiBOVk1FX05PX0NPTVBMRVRFIHwgTlZNRV9ETlI7DQo+IA0KPiBUaGUgIk5P
X0NPTVBMRVRFIiBpcyBhIHNwZWNpYWwgLTEgdmFsdWUgc28gb3InaW5nIGl0IHdpdGggYW55dGhp
bmcNCj4gZG9lc24ndCBtYWtlIHNlbnNlLg0KPiANCj4gQnV0IG1vcmUgaW1wb3J0YW50bHksIHdo
YXQncyBzdXBwb3NlZCB0byBjb21wbGV0ZSBpdD8gVGhpcyBpcw0KPiBzdXBwb3NlZA0KPiB0byBi
ZSB1c2VkIGFzIGEgcmV0dXJuIGNvZGUgd2hlbiB5b3UgaGF2ZSBhbiBhc3luYyBjb250ZXh0IHRv
DQo+IGNvbXBsZXRlDQo+IGl0IGxhdGVyLCBhbmQgdGhlcmUgZG9lc24ndCBhcHBlYXIgdG8gYmUg
b25lIGhlcmUuDQpPa2F5IEkgdG90YWxseSBtaXNpbnRlcnByZXRlZCBpdCdzIHVzZS1jYXNlLCBh
bmQgeWVhaCB0aGVyZSdzIG5vIGFzeW5jDQpjb250ZXh0IGhlcmUuIEkgd2lsbCB1cGRhdGUgdGhl
IGVycm9yIHJldHVybiB2YWx1ZXMgZm9yIFYzLiBUaGFua3MgZm9yDQp0aGUgZmVlZGJhY2shDQoN
ClJlZ2FyZHMsDQpXaWxmcmVkDQo=

