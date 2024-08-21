Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143E0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 00:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgZ74-00057h-C3; Tue, 20 Aug 2024 20:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sgZ6v-000550-CH
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 20:22:02 -0400
Received: from esa13.fujitsucc.c3s2.iphmx.com ([68.232.156.96])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sgZ6r-0007D0-FK
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 20:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1724199717; x=1755735717;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dwbPLR3fq+vdUYvTgwaqSyDhnhoSP+c7zf99uGJRvs0=;
 b=FmS2e9XU4KHkxFsYhaSjCgelWGTqLKVHflS8YWCvcdYdHQklT9Kzuauf
 MWo71b1oNyiZK+LlqXqUC10Dj+ImuXwbc5XSgTaDJg4729UePSZmwkOoh
 Vc5hAaWLyS28zbceLwdYVeBgG9f2tX3l42kUG4drw/a508+9ajqm2/B1l
 E9ipIgNnwYQkjx2FW6EdW7UjDMCOhGPXWFUu/fvLx9qHgk8vXaXuKzvyJ
 lYrk07RRoUYgqmIJbL0Nu+JpF5H9Yr0IgdxF01gjBZzvLa3vr+sV6rFwD
 tq2ZevTVECdyUyT2fQaH4ogcRZv7xeLHoTDPxfz1hjwGe7wq8TE190x4c Q==;
X-CSE-ConnectionGUID: 951HiXlyTnqF40GWGCN/XA==
X-CSE-MsgGUID: 6lctRwRKQnikuNYU7NPP4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="128028851"
X-IronPort-AV: E=Sophos;i="6.10,163,1719846000"; d="scan'208";a="128028851"
Received: from mail-japaneastazlp17011024.outbound.protection.outlook.com
 (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.24])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2024 09:21:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KArP7/9pg6MYk3RtTpolcyj+NCR/vDoWcI8LdU8hNA11ihmRLwLyiikkWm8BKnrqYjlwhkGjphrtCqLAjgh5vZ9A8cu8ZweldGK/RBpxbw52d15zfn8eYG1rSMj0NBIiAtp7eKRynsYh57v9UZguwDjgWQ2Kq3LJbPgXxzRJVMWqX5lIFHrhJJIQKOGDP1jpVRRF+gwft5NWIGlFgCmq8nV8jONmXnHFwsHwxpAh5Z4YvoRlGXMLrQzETwnutloZPd5Wuz6P2Z5Pv2GdpuJCTyduWGbL7RrrHvizwZkDVHPNQ57HOZzIFjYH8fqqEnhvz2ZIyTCOi15GuYHYt0qc6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwbPLR3fq+vdUYvTgwaqSyDhnhoSP+c7zf99uGJRvs0=;
 b=fq4aMlNVjWBswNmc5O8gDPfFuo34UUwvg1HK/MHzmliqOOyCfYM8tgcnWn9r38yD7ndIQefH9qdlhmhlwPjJrHmxNQ1FwrXPtFw5MUxorHmnHAMFklckVqcRWV6NRb9O8OWb2M5P1Gw4KYEWfwOnMDZ9P7hBVCgm1BhNL6OplMKkI5zsma876eQwldb2pD7oCYNWxT/a7SwZcZr+CcSv9Er9goqNWaZTlZgI3TbRu6ZsuRZxOvHcUp24nXALdM7TzVWnvef+GvPAql98CO7aMZb/vy/rLw6Xxd7ufGmt2lIJxqDur4cPXsjXkE0EebBmFiuhJmM87VSin3+uEXotMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by OSRPR01MB11437.jpnprd01.prod.outlook.com (2603:1096:604:234::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 00:21:48 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%4]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 00:21:48 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] scripts/coccinelle: New range.cocci
Thread-Topic: [PATCH] scripts/coccinelle: New range.cocci
Thread-Index: AQHa3lc8QI384GS8n0q91FxxwsLfebIv/LeAgAEEmtA=
Date: Wed, 21 Aug 2024 00:21:48 +0000
Message-ID: <OSZPR01MB645376D56BA4BE4B5C4B9FF78D8E2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240725055447.14512-1-yaoxt.fnst@fujitsu.com>
 <CAFEAcA_MDwXrgi3xALUZcRrNq_ds6LyL2HwvCS+Syv8vwDGW-Q@mail.gmail.com>
In-Reply-To: <CAFEAcA_MDwXrgi3xALUZcRrNq_ds6LyL2HwvCS+Syv8vwDGW-Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ZGRmYjI5ZjUtMTc0Zi00MmQ5LTk2ODQtZTQyZGZkZmZl?=
 =?utf-8?B?ZDk1O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA4LTIxVDAwOjE5OjE5WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|OSRPR01MB11437:EE_
x-ms-office365-filtering-correlation-id: a44fb7c1-e03a-41eb-6aed-08dcc1773f12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?M01pUitIclZjY292S2tXU0x6NzI4SGUyLzREa1paMnJKejI0Q21FOERSQnR2?=
 =?utf-8?B?Vk85MnpISUExZEhwbmJLMEg2bUZOS0oyWkNCcjRUNEtveGxRNklyYUlHUVpW?=
 =?utf-8?B?UDgyZUFUdXpXZmZkR3R6OGlNSWhLRElKSndGdDFUNXJaNEF6RVh3ZFh2SWtC?=
 =?utf-8?B?REVsVWNmeWhhQm5ETjhSenRzcVRUUHV1aUo3OXc2SFUwQ0FHQkFHaWRGZFd6?=
 =?utf-8?B?NUgzSHUwaHc5OHI4clVCQjZkNm9PMnRra2VNSWFOdkZ5VjhTSDd5ZkhFbjJM?=
 =?utf-8?B?MEI2YTdzQ1lkbkdaZHpZYXFUWFMrMnlWL0lEZlZlNzFieGkyaUZudmJ3d0hN?=
 =?utf-8?B?Y1l1TnRkMTllYTBLSUNpQlpldVhBWE00VmhHc3R5Rnl0b1RmbDZRR3pFa3VQ?=
 =?utf-8?B?YiswdC9Ga1ZMeWNsTHBtNHBkNXZXVU5VWU5idWs5ekxlZG1seFRYSW5INlFL?=
 =?utf-8?B?QTZlMGNrNGtmYkFmSnZzUEYyM0QyZ2IxeGd4MEpoQmNEbUI4ZGFxK3lPNjEx?=
 =?utf-8?B?YytKd3VVc0xRVElCdW80SVBjUjM5RXVGY2hUT21JUVR0UG1LTkxaYndzdlhL?=
 =?utf-8?B?VVFwaHZFcW14ci9oWGVYM20vSlZXRnoyM3FNQ3kwTUg3d3RhWjVEY3YrN09N?=
 =?utf-8?B?a3dNb3Q5bk5tUmlMN1lScXgvbzVaOTEvS0J1K3hIQ1lUQ1V6aDQ3TGt0QXNV?=
 =?utf-8?B?N29TTzdMY0xSZEF6aG12MytpcnM0OVFVRWxheXpVdmhidEc3WFl3anZZMnV4?=
 =?utf-8?B?VW1hTE9XVGIvL1Y4enFNT3ZHSFZ4ZXUrZjJhZGtGME51RnlUZ2lDdktmNHdh?=
 =?utf-8?B?M3J5SDlERHJmcG12YklKV0VLR01FVDNEOVJobVJPK2RiQm41Ukt6S1Rna1Jt?=
 =?utf-8?B?SFl5dWt0TTdpRkJQMUtPWThwQUtBSnM1bUE1SW8vc2RGQnkvQktxdHFZanlZ?=
 =?utf-8?B?QjhEZkRxL2l3VzBsWkpnbURvd0pDVWJnQnJYNFZMZjJpV1V5OFB0ell5dzdR?=
 =?utf-8?B?cElvL0ZDMkt0d0N0UUFHYWdJT21uWElLUDJMdC9HSkc5amd5L2RaajVHRTYy?=
 =?utf-8?B?bjlSYUkzdFZ0cXFNd3Vwd1VOaU1CYXVBdVVzMzdXaHRxMkNhNGtvU0c2TmFa?=
 =?utf-8?B?OXBHN1M5bGwyWWYrSHQzOGhTaFJTc2pLYXF2d3hrdjRrRjIvQmRaUnpKTS9F?=
 =?utf-8?B?cFRQZVkxL0gzVHZST1ZVNWlCeWRqYmxOUk96VGdSdmdPRThLdGdSUlNGSU9D?=
 =?utf-8?B?MDg1b3Z0NG95MVdVd01kM2ROeXhRNytEY3VYRnFCdFQ0dTlQNDU5c1MzVVZq?=
 =?utf-8?B?N2svd0tiQndIRDBEZ1hlY3VrNEdSbm9VZmRsRldnQ3kzNUNDcmo0SFI5a013?=
 =?utf-8?B?TUdUTmhUa2pPTFFUdFR2WGZBK2prbE95Z3pwK2dQSEtyY2RicC90cThWYUs4?=
 =?utf-8?B?MzZhTVRoWnZqaWxzMWR5OWpGcjFWT1RXVWU3cnFFaVluMnJjY1pUZGtiYnJ5?=
 =?utf-8?B?V1FDelBnNlByZ1ltcUJPd1NnNEhnU0pZVUpUakhYY2pXeXltOFhqRXlDdDNX?=
 =?utf-8?B?ZDVMKzR3b0lXUHNIRkx6RWNBR2FRWGpIb0llM1ZHN2Q4UDRtTkJ6dVdmMTNz?=
 =?utf-8?B?Q2s2K1M0b0hNSFhvcStIdmh4ZXNzNHB6UDg4Y3Nka3plZ2xxeVRmM05VVGFR?=
 =?utf-8?B?NkpSNXNxdVQ1QVI1TWR1VGd6ZTdmM0lmUU9rSFZ5TTdGc0M4aytzY2libU9J?=
 =?utf-8?B?UFhwSW82bGFrdHAyUi8yOVM3cVFIUEZ4TklXbGZaYmhHVlBnZ1FSUUVrM1l5?=
 =?utf-8?B?SzFKY1JmdDNlUTYzVC9zS01JYzFrTXYrenNGcGNZWEYzTjUvL3FVUjhqWk5P?=
 =?utf-8?B?dUJVR2FVUUlHVEV1aUk4NVNMNi9ra3NIN25SK0dWK2RQZmV3WHErT2FETXVa?=
 =?utf-8?Q?7Yfd+yE1H5I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2hBb1F2QW9Hd2Q4djdGZ1N1Wm5Tcm1qL0FNdUR3SFVSMGw5VkZCYWg3eE9G?=
 =?utf-8?B?N1RZL2k0UWttelAvcklUdjA2QUpZdVo3UjZ5TFIwN2NGSTYwZGN0MGY4Ynly?=
 =?utf-8?B?Tm55RzRMYUtNL2VsNnNUQXZaT3JtalREYWtPZldQY0pTQjd3ejNVV1JxZDBa?=
 =?utf-8?B?SGt2T0I0bHh2N3RYUWxZdVBsbEJLekR1UjlzVURBdFlKWGdUVFkxb2RKeWJt?=
 =?utf-8?B?Z3c0Ni9seUZ4bTVlczV2QTRtcmVWZEFueHVBT01RSVFIRnp1dlJoTklQdnE2?=
 =?utf-8?B?S0plK0Vidm43V0hlMjhUOWVsOTB6d0dtT1ZGZk1HN3JQOFVDSVlPb0JWQ0lP?=
 =?utf-8?B?SWJVTzBLK2FJbklFSUNCSDZrUVVlWC91UlhjYk8xMW5pTVNjdkYxQmtkcm1P?=
 =?utf-8?B?ekhObXFxUDVuRUZxL0R2ZFVHeHlnZVRudnNEVE16a3liUjJmNHA4bDdySVZG?=
 =?utf-8?B?amZnRVdDKzU1VDIybmUyVThQZnVLRUxBUm9HODRCbjcvdzF2NEE1ZnRxbm5B?=
 =?utf-8?B?SGoxMU1IOFlFa1RzU0NUeHp0UzNraWpIQmx1ZVdvN3lWSURlbmRMTHBlbUF0?=
 =?utf-8?B?RmIxd1BiQTdRbUx0L3pzcnhzYjFZVUlkNmFRbW5qc1c0VnBSSkQ5V2o4K1hD?=
 =?utf-8?B?bUw3YzJRaDRhY04vUFBBU25MZDdxUmMyeUlkelM0U1JFVHJGaE5oV1ZCWWtl?=
 =?utf-8?B?TVZhSFRvUHRmY0tQdnFQc0RJZ3BGWFhsVnZrWG9ZQXZ3WmN6YmFjZHlaUmJF?=
 =?utf-8?B?TU5LdU1YLzErSkxLRTVZTi9GbHFoZVlDVGpaYlIyQ1p4cVFtWnBlWjltZEp5?=
 =?utf-8?B?WDNjcGd1U3U2ZkFjUXFPMjg5Vm5HUDE4UktjRkR1ci92ejJydEk4UFBLdzZj?=
 =?utf-8?B?WTVaZ09raXdWc3RnUUUycWlrbXQ0dytBYUZVUUpTUnpWZzNNNnJ1RDM4OUg1?=
 =?utf-8?B?cjZJbUVpZTkrWnhhTm1iTlhtZXVBaDdPWGpvMzB2MFF3b0xUYUQveWx0MFhm?=
 =?utf-8?B?dDQ5RlFweFdBUnJMOEJuS3BFVFpOWGl4QVhyczYwL0NzVUNyUFQ0YlJoTW9S?=
 =?utf-8?B?NFFYa0pSak1IRm9la1pBNmFWZDAwekwrNEFjM2FWRlNqQmlNT1JMcW1lb0lr?=
 =?utf-8?B?d0tGbkxoQXR1cGJ4WXpSdUVsTlZSZTNPMWF2WWt5b2VDcmJIMnkwZUo4bTJR?=
 =?utf-8?B?NDB6UzJ0L3ZzTWhyRk1wc0VsUFNVbWtocVZaR25uajFma0pzRU5zaXFhUFB1?=
 =?utf-8?B?c2dBZG1pVDVlTkNwTHdJak9NcE1mQzYvRmlSeXlkdDhxbG9Gakpkazh2dEdV?=
 =?utf-8?B?bmpNZlZRUTd4enVKZm9PTTBDVGpxdU1wbFJaVjRub0ZNQ1lEbHZNU28wazll?=
 =?utf-8?B?Mmx3RDVYbjB3RFVwWEtiem9kSEIyWXhUKzdQRnNZSHA4R2Fhc1NlTXo1a1Jt?=
 =?utf-8?B?TVRxc3pDd3IxYmU0L2NxRTZDOHoyT0lTQ1VsMmZWa1BHWjZGeFRkbnZRVGtO?=
 =?utf-8?B?TWxlaC9LSG1Wck5uZnhRSE52QmwwWXdMaXc3ODFpUE1HRWI3cm5iSkwxR2Ja?=
 =?utf-8?B?L1FwU3Q0NTVvWERhcHBjZURSNXJ0UTI2WCs5TDBoY1h2dXlCL2dVcXFHemdE?=
 =?utf-8?B?WDIxdGhYVzBSanA2NXlEclRCQlRVUWhvcXNaUFVoNVd2K1RwRVA2V3FPZnZU?=
 =?utf-8?B?QWRtNU5pQlZwUFhYZXVSdkQyKzNuYlMwM2dzVGxkWGgxRzFhQStCRkZlb0d0?=
 =?utf-8?B?R2tmaUVQUWtIa0FnL1ozNk1YWklPSlAxSW53Q3dOUnRPMG5OZXZCTXpNN1hw?=
 =?utf-8?B?YTlWSC83MXZhOTgrRDZRMXZRMjlzTm8wS05zK0Q2M282RGdNRGkyQmlLMzhF?=
 =?utf-8?B?SlNzbmFGWHIrME5ITFBuYjFpbTJvbjNZWERUbzNzWS9LVWlzWW5mMWMyRTBy?=
 =?utf-8?B?Ly9sSFRWcFFvZXVJOWhTUCtma0lSd1IyV2FsZEF2NjROL29UdHY4VWZzdGdh?=
 =?utf-8?B?Y2g4NVV4R2Z1cXVrMVliZk5yWFB5VXdPbWNPK3RNcXNQVk5UV3ZjMmRzQ3lC?=
 =?utf-8?B?OUdDT25sT3pNTWo5T1o0NGQ5NkY4WVgrK3Fya1h4b0pOQ0FYTzVwWmxzZ2VL?=
 =?utf-8?Q?EL/rdVrgSkjCnopIwUmKYIsdi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: V2ZdkgbtqZawht8MVddhhkgBF0d7NRT3NWM0QsVxdzJvUBut7c5RGV43s3a6FN6rxgBHSoOcEmHUoQoQGILimb+seXAqB0sSMgdjpuMTNL/KLl10s7jnBF0xSP/U60GO6xZW6oUYC4t+jBjp5aRccwm6kWVZvVJUZsx+NW7JKHfllnpbadbKCiiBYZ0LiP6eHPHGSuUhbaR3ph9uT5bqVBViIgI8Q+OwBrhQ9YXWaYIPiSm6fn+dhFFA16dMcvsbVmckDUVzcFH6EBZe6VjNQfRUxVpxKiYx9gd+AAvIjITwB8Pl3CGuBI+t/5l+wpZkxXVlZB5JfklXJajYXNlUg+zyULUT6gONtV3TJyKvqiwDDkceAOMRtJsa134GWUXbrpahjG9BiO2XzkEywXlDH93BgMUrLc5wI5vMRej/+tqBqTsy+7VxNTTg0XA5KVCKkUgUWhbwBV26EYzNaTqS8RIlZhPiaj4+IGaQIxSch4NTScsqJOs9MFxI0/aq9BXBUzjeejo2dypLJo0H2KM2b8oxN80Kn8yDuDvO71DGQfz9zMLOvCBE3OsD5do0BFn5ODQjg5K/+lwRp8SNpyg4qREx+7KvmPbYRW7ac/T4imPVwuq1GksX/q3Z/RfZ9tGm
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a44fb7c1-e03a-41eb-6aed-08dcc1773f12
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 00:21:48.2978 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +1Dwtiul4vG7vB3K+hL7E28AvcIr1JI/2SjM0/o2Rf4p2ObkyfUVnuN8npUwP78k8YXuO3URfPbAGZwGVmmRqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11437
Received-SPF: pass client-ip=68.232.156.96;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa13.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMjAsIDIw
MjQgNDo0MSBQTQ0KPiBUbzogWWFvLCBYaW5ndGFvL+WnmiDlubjmtpsgPHlhb3h0LmZuc3RAZnVq
aXRzdS5jb20+DQo+IENjOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gc2NyaXB0cy9jb2NjaW5lbGxlOiBOZXcgcmFuZ2UuY29jY2kNCj4gDQo+IE9uIFRodSwg
MjUgSnVsIDIwMjQgYXQgMDY6NTUsIFlhbyBYaW5ndGFvIHZpYSA8cWVtdS1kZXZlbEBub25nbnUu
b3JnPiB3cm90ZToNCj4gPg0KPiA+IFRoaXMgaXMgdGhlIHNlbWFudGljIHBhdGNoIGZyb20gY29t
bWl0IDdiM2UzNzE1MjYgImN4bC9tYWlsYm94OiBtYWtlDQo+ID4gcmFuZ2Ugb3ZlcmxhcCBjaGVj
ayBtb3JlIHJlYWRhYmxlIg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWWFvIFhpbmd0YW8gPHlh
b3h0LmZuc3RAZnVqaXRzdS5jb20+DQo+ID4gLS0tDQo+ID4gIHNjcmlwdHMvY29jY2luZWxsZS9y
YW5nZS5jb2NjaSB8IDQ5DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IHNjcmlwdHMvY29jY2luZWxsZS9yYW5nZS5jb2NjaQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L3NjcmlwdHMvY29jY2luZWxsZS9yYW5nZS5jb2NjaSBiL3NjcmlwdHMvY29jY2luZWxsZS9yYW5n
ZS5jb2NjaQ0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAw
Li4yMWIwNzk0NWNjYjINCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvc2NyaXB0cy9jb2Nj
aW5lbGxlL3JhbmdlLmNvY2NpDQo+ID4gQEAgLTAsMCArMSw0OSBAQA0KPiA+ICsvKg0KPiA+ICsg
IFVzYWdlOg0KPiA+ICsNCj4gPiArICAgIHNwYXRjaCBcDQo+ID4gKyAgICAgICAgICAgLS1tYWNy
by1maWxlIHNjcmlwdHMvY29jY2ktbWFjcm8tZmlsZS5oIFwNCj4gPiArICAgICAgICAgICAtLXNw
LWZpbGUgc2NyaXB0cy9jb2NjaW5lbGxlL3JhbmdlLmNvY2NpIFwNCj4gPiArICAgICAgICAgICAt
LWtlZXAtY29tbWVudHMgXA0KPiA+ICsgICAgICAgICAgIC0taW4tcGxhY2UgXA0KPiA+ICsgICAg
ICAgICAgIC0tZGlyIC4NCj4gPiArDQo+ID4gKyAgRGVzY3JpcHRpb246DQo+ID4gKyAgICBGaW5k
IG91dCB0aGUgcmFuZ2Ugb3ZlcmxhcCBjaGVjayBhbmQgdXNlIHJhbmdlc19vdmVybGFwKCkgaW5z
dGVhZC4NCj4gPiArDQo+ID4gKyAgTm90ZToNCj4gPiArICAgIFRoaXMgcGF0dGVybiBjYW5ub3Qg
YWNjdXJhdGVseSBtYXRjaCB0aGUgcmVnaW9uIG92ZXJsYXAgY2hlY2ssIGFuZCB5b3UNCj4gPiAr
ICAgIG5lZWQgdG8gbWFudWFsbHkgZGVsZXRlIHRoZSB1c2UgY2FzZXMgdGhhdCBkbyBub3QgbWVl
dCB0aGUgY29uZGl0aW9ucy4NCj4gPiArDQo+ID4gKyAgICBJbiBhZGRpdGlvbiwgdGhlIHBhcmFt
ZXRlcnMgb2YgcmFuZ2VzX292ZXJsYXAoKSBtYXkgYmUgZmlsbGVkIGluY29ycmVjdGx5LA0KPiA+
ICsgICAgYW5kIHNvbWUgdXNlIGNhc2VzIG1heSBiZSBiZXR0ZXIgdG8gdXNlIHJhbmdlX292ZXJs
YXBzX3JhbmdlKCkuDQo+IA0KPiBJIHRoaW5rIHRoZXNlIHJlc3RyaWN0aW9ucyBtZWFuIHRoYXQg
d2Ugc2hvdWxkIGRvIG9uZQ0KPiBvZiB0d28gdGhpbmdzOg0KPiAgKDEpIHJld3JpdGUgdGhpcyBh
cyBhIENvY2NpbmVsbGUgc2NyaXB0IHRoYXQganVzdCBwcmludHMNCj4gICAgICBvdXQgdGhlIHBs
YWNlcyB3aGVyZSBpdCBmb3VuZCBtYXRjaGVzIChpLmUuIGEgImdyZXAiDQo+ICAgICAgdHlwZSBv
cGVyYXRpb24sIG5vdCBhIHNlYXJjaC1hbmQtcmVwbGFjZSksIHNvIHRoZQ0KPiAgICAgIHVzZXIg
Y2FuIHRoZW4gZ28gYW5kIGludmVzdGlnYXRlIHRoZW0gYW5kIGRvIHRoZQ0KPiAgICAgIHJhbmdl
X292ZXJsYXAgdGhleSB3YW50IHRvIGRvDQo+ICAoMikgZml4IHRoZSBwcm9ibGVtcyBzbyB0aGF0
IHlvdSByZWFsbHkgY2FuIGFwcGx5IGl0IHRvDQo+ICAgICAgdGhlIHNvdXJjZSB0cmVlIGFuZCBn
ZXQgY29ycmVjdCBmaXhlcw0KPiANCj4gVGhlIGlkZWFsIHdvdWxkIGJlICgyKSAtLSB0aGUgaWRl
YWwgZmxvdyBmb3IgY29jY2luZWxsZQ0KPiBkcml2ZW4gcGF0Y2hlcyBpcyB0aGF0IHlvdSBjYW4g
cmV2aWV3IHRoZSBjb2NjaW5lbGxlDQo+IHNjcmlwdCB0byBjaGVjayBmb3IgdGhpbmdzIGxpa2Ug
b2ZmLWJ5LW9uZSBlcnJvcnMsIGFuZA0KPiB0aGVuIGNhbiB0cnVzdCBhbGwgdGhlIGNoYW5nZXMg
aXQgbWFrZXMuIE90aGVyd2lzZQ0KPiByZXZpZXdlcnMgbmVlZCB0byBjYXJlZnVsbHkgc2NydXRp
bml6ZSBlYWNoIHNvdXJjZQ0KPiBjaGFuZ2UgaW5kaXZpZHVhbGx5Lg0KPiANCj4gSXQncyB0aGUg
b2ZmLWJ5LW9uZSBpc3N1ZSB0aGF0IHJlYWxseSBtYWtlcyBtZSB0aGluaw0KPiB0aGF0ICgyKSB3
b3VsZCBiZSBwcmVmZXJhYmxlIC0tIGl0IHdvdWxkIG90aGVyd2lzZQ0KPiBiZSBJIHRoaW5rIHF1
aXRlIGVhc3kgdG8gYWNjaWRlbnRhbGx5IHJld3JpdGUgYSBjb3JyZWN0DQo+IHJhbmdlIGNoZWNr
IGludG8gb25lIHRoYXQncyBvZmYtYnktb25lIGFuZCBub3Qgbm90aWNlLg0KdGhhbmtzIGZvciB5
b3VyIHJlcGx5IQ0KSSB0cmllZCBteSBiZXN0IHRvIG1hdGNoIGFsbCB0aGUgcGF0dGVybnMgb2Yg
dGhlIHJlZ2lvbiBvdmVybGFwIGNoZWNrLA0KYnV0IGl0IGlzIGRpZmZpY3VsdCwgSSBhbSBub3Qg
Z29vZCBhdCBjb2NjaSwgY291bGQgeW91IGdpdmUgbWUgc29tZSBhZHZpY2U/DQo+IA0KPiB0aGFu
a3MNCj4gLS0gUE1NDQo=

