Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C8EC38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 05:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRPiC-0008Qm-Gp; Wed, 10 Jul 2024 01:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sRPiB-0008QA-Em
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 01:17:52 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sRPi9-0005pC-1h
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 01:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720588669; x=1752124669;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=1FZ7LAhqAqgrXTd4Kdp9tLeWkCuEXXd4X1+MhXmtKgE=;
 b=LE3IvEU0IRZ6++O1Tjry8EBNNN6l8ivv5g7rfY8V7zJ5u9J3tTtZdOcC
 zTyV65qf4makTW+zRrlBk4dDTk2lboHluB+oBvq/2lxff3ykbpq3HKSOw
 Y2LLDCW9f7RGmPTk8lJL+tri30sBqoqYYZJTNsYv4S+RbBgWJeqr+CujZ
 AoBFIW4NllQ237R+S0vWYjq5pqewVpRPaoAHx9RssuhB+/hCqvvYXLa3c
 A95ARcp0tjXTEwsqX/b5l1fje9r6hfNn3FX4qRfSf6mnyX5Lg+T2nvDnE
 WbUrjL69p+LqVOjTd947s19sYaiisZF4OicbF+fgCr6wOc+PFp03zav2A w==;
X-IronPort-AV: E=Sophos;i="6.09,197,1716242400"; d="scan'208";a="16201043"
X-MGA-submission: =?us-ascii?q?MDG3qL4xEK8y289eBBW6RmKl1JC6UYtnF0BCSz?=
 =?us-ascii?q?A7Hgc5sEmlfZq8Plfl2W7sNEoV+vbn9iEaOEuwnrwHqRVg7+VpVkwx22?=
 =?us-ascii?q?d69wUDBi5hyQcpq24Jy91uiaWCuwNELblFgQNRvH/cB/tjiGKDC+tHXb?=
 =?us-ascii?q?2XOtIWu6KFbkvTb2wNkOzqpQ=3D=3D?=
Received: from mail-am0eur02lp2233.outbound.protection.outlook.com (HELO
 EUR02-AM0-obe.outbound.protection.outlook.com) ([104.47.11.233])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2024 07:17:43 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zO/okt0j3c6TfYbuj5kytUzbtcLmMQAxFouGlgegxqghFOBlwpBPJ5ZQDaocpbOArZNcqg2cvisqw4/QQ+367I59lVkIJxzFoZWRDUgsi0pp5f3DBET54Vku2fN1CoBO0PrJrWPUywOP3S+GGfD+wQ++hNJorFs6cTmXCw/3zvdNTwc+VkUcxDb1OM1r28HlckpGJM9BEms7LaBvgOB3hzsldxbhkLZHwIuyAsaYky3w0AWHlGHptrPzRpMjGgBCPxVsU1E1yuj/khrlKn1M4uVES2Xotvusvq8GimRIA9ip3jYJap6rhpSqYZkrzyPG6NYun2DmB8SERSxKHqJQVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FZ7LAhqAqgrXTd4Kdp9tLeWkCuEXXd4X1+MhXmtKgE=;
 b=vjjhLQWzcJcUxQm1Q48+UKLzbSIR4j59YSL2HFSOZtNQEzkhlIdblbceTpWKgVlkXqrqybD6AHbLCw+Ktms4K1JqcS667LwzY9NF3LS+36RpEIFiB1EoubNdBdaLNOPW3tJmkzcn1sFziJEz/nsSqNpw98OkcyjbVuZOHDwuxgREr0Q4Dzl6ztCI2f7pn/KP9T67Vio8fuehx4ZGXy++RovYNlaL+gDVaeo3Vjh1/iVzIdOZ8/qgrrp4ROwL0/SCVv7QFYO03Pq9P8fRTM0fx7Upy/tuDIn3I4nBPHci70bZHw3WFilrvcTGyLDG3+RSFrT4hVjd0nE0mkks0+99Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FZ7LAhqAqgrXTd4Kdp9tLeWkCuEXXd4X1+MhXmtKgE=;
 b=RyY4P6/fpO/FHOhtkLPuCFSx5S2HbZJ1Yxbd0oiAsbtTxOt45ulSNXlPyKoBkDf1/6IUrPZJ87CNf0CJAfdMvL/RnY1COpELC1mI/xYnbTeUUUg0OUiABhXufArKO/2QL9ZOuVejXiNkerUmz7E0UrbouJ9Ucz6Q9enzpUAtK/fgjxmt8jXxsgEjbQlMtFayjFH0DpRTKAG9DYCH0nqG7qOBV3A+U34jx58hcNvWaMRjfpKHoSbWONlwzd/XkmB7B9onHyHTC0uFRTUy3oUCqhZJnMVSdxACORbchJ72fFdNzvCeswMlJcbLwFsXZcOB5HBCHT0tHGgFum+31xBG6A==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBBPR07MB7452.eurprd07.prod.outlook.com (2603:10a6:10:1e6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Wed, 10 Jul
 2024 05:17:42 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 05:17:42 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Minwoo Im <minwoo.im@samsung.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, 
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH ats_vtd v5 20/22] pci: add a pci-level API for ATS
Thread-Topic: [PATCH ats_vtd v5 20/22] pci: add a pci-level API for ATS
Thread-Index: AQHazEQPZma3+RPBzE6mhYIQQIOAh7HuOTAAgAAdBICAAJwTAIAAhiqA
Date: Wed, 10 Jul 2024 05:17:42 +0000
Message-ID: <156af18e-255d-4149-be7b-bb93dc360da3@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
 <CGME20240702055502epcas2p2f54e3234f35d28e73513a5634a7cb03a@epcas2p2.samsung.com>
 <20240702055221.1337035-21-clement.mathieu--drif@eviden.com>
 <Zo0NpttNP8OkrOG8@localhost>
 <929fc1df-0a19-4da0-8399-5d792dd25684@eviden.com>
 <Zo2o6kkqpSgmj4yN@localhost>
In-Reply-To: <Zo2o6kkqpSgmj4yN@localhost>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DBBPR07MB7452:EE_
x-ms-office365-filtering-correlation-id: 9dd9fe77-7cd5-4cdf-bc87-08dca09f9fe9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Z2swWGVwUllOdXVlRXhRVStVNzBhb2t5ZkZyRWFBV1g3cFNpTldXeE9mMk9w?=
 =?utf-8?B?VmQzcHF5TXh2QnNQY29ZZzAxNzN4VlZ2VWFkbXYwU2Q5TlVKNHB2cGtMWUg4?=
 =?utf-8?B?MUdrYWtpdXFsL2RHQU9FZzIzbUFWWkwyQkFyRnkzYmdaWS9qTk4xOExxQm9P?=
 =?utf-8?B?NFcvYmRTazNGTmkvZVdmamhEZWU2NVdnak4vZU8vY1NEUDdyODBsdEcydUVN?=
 =?utf-8?B?STgxTWE2NkRTTG9aMVZ4ZGw4RnRIZ0t2cHBCZHRSd29BNUc3dEdXVVI2K1Zy?=
 =?utf-8?B?UWtianBYM2NTSkVzc1Z1MVpDWUtxODl0YTdqRm55YlFhcXA3WWdSSGdkV0lz?=
 =?utf-8?B?VGhqRFhJOFl5SExrWkRsTitVZmNzbVp1WGduZU1SalgvQU9xRk81MzN4M0Mv?=
 =?utf-8?B?UmZZRklZSUdGSTVHbVdDckt5eTVYU2tWdFFZamFJUlZaVm9uTXVSeGQrZEpn?=
 =?utf-8?B?bDVnT3FkYTZkWC9qMXgzeHhKNVUyL241bEE3STBwN2lBODhUbTVXaXdQbGFE?=
 =?utf-8?B?b2ZBOWtUYlhDQmRlMzZMWmpNRHVTWEZTNHdJcUJxSlNqN1JtOXJvK3hwT0ps?=
 =?utf-8?B?L3I2NjJKL2pOR2FGUklYcjJoU2syMElycjFWMlZ4RFRYUkRaSU9ZSGdzSXVJ?=
 =?utf-8?B?L0xNSkpjQU91UVlBRnNNeS82WHBuM01aZXhOcVNXRjVOMnhLdkR4V0g1TzBG?=
 =?utf-8?B?TlhTbjRrUkZuUmRJbS9jUHRYMElZeHFqUlRpbThPRGtHU2cwam5IcFlmUHlH?=
 =?utf-8?B?V1dUdWhpOVMxbkQ5RTczdmtvS0Ird2FQZ2JWdWFLRFFCbDBrNkszV2cvcmY0?=
 =?utf-8?B?UzVEYzZQenVYaDErYWI1Tlk5NXNrRmpPU2JWaThkWjJoN2EwV2Y3Vk5GRGRG?=
 =?utf-8?B?dnR4d3NYeE5LRk1HU2tLcTVYMU1aZlVpUWdnTGZOR1dwV0Z0ZlBMd25VNUlz?=
 =?utf-8?B?Q2JIZk1LaWlEeDc5YmV1NkwxeEVGSGxLWlhIMTFhaUdZTytscVFSQ3ZLTmZ6?=
 =?utf-8?B?SFk1OFpiNGRiR3dFM1h3ZlluT0tCSTRBM1E0RnJvZVdQOXk4OHMzYTBsTUZT?=
 =?utf-8?B?VjA1UU9yTUtzTnFKMDA0ZTd4QTZheTBoaXFKR3Q1a2llRlFQc0F0cHA2b3Jt?=
 =?utf-8?B?dXJHdjN2N1c3MjNDNUpuVGpRNWZ4KzY3WmMwckZQQUNyRGFoWUZlSHU0amR0?=
 =?utf-8?B?blYrK0hvMUpGdWpSVmRybXhWZTVJVzJ5Q2FsV3BhdmFUREkzL3VJb2Zsb3M5?=
 =?utf-8?B?TUJuNzl4ckkxZTcvNkY2b0J6dEZEcGhXTTlGemtnNFBXNTNzTVFJeHpNZ1NS?=
 =?utf-8?B?Vm03K0lvL1VkOEdWVEpFNS9mbkc2bGJkendMK0xpNUhxcFQ4MmRvcVp3R3VV?=
 =?utf-8?B?QWRvM2ViWDlzdjk5TEVZZXhkaEVHY2ZiOENoQTcvNzgybC8xWEdkVkMyQzI0?=
 =?utf-8?B?SWF2bG1lbFRKbklSYndSQTgvRkc1bitmVzVVM3lZVmNCTDlnWlZqUnJ2YXZN?=
 =?utf-8?B?cnlzcGtWWDYzK0drR085STYvS1Vad2MwaE5vTUR2dHRDK2tLQlVpdk1xRzJj?=
 =?utf-8?B?b1Q0bDdyems5TE93TDJtRzdZb2lIL1JVcmhoVGhBWWxWdndkZmhrNklaMEsv?=
 =?utf-8?B?VkN1aWxaeFZ0cVZ2K09wa0tybDJQY002c1hVbjZBUHl2VEtzSjluN2I5Y0NO?=
 =?utf-8?B?SlZ2RTY4dHVoNElLdkpkM0E5ZURhTFVvMmxqTzkrRDZjU3RlSjN6b2RITEE0?=
 =?utf-8?B?aVRRYlgycmZOM1hsU29DMXFUcWdFNTRhalRnU0Z1c09kRUhWb1dndXQrNlhU?=
 =?utf-8?B?NnZpancwTkZLRkxTU2pDQWs1bTZ5M0VFN1pMTVZaV1dRQmFjZDJBbnFUR2pJ?=
 =?utf-8?B?VE5ya2l0RzljTHJ2clkydDhVV0l3T3ViTzByUnlvdVlYREE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rml2OGZVUHFlZWY1dDNIbGo1T1l4UGw3VlVMNGVSK2Zjd0dUeFJhcTFsM3Z4?=
 =?utf-8?B?WmI1ckZiN3haeXhOZkdlQmhtU0tQVENKenMvTFB0bERrTGdyeGErakdSSS9x?=
 =?utf-8?B?Q0M1WG0wbDJJZkVHMWk5SnlDNGhVWTFGcVYrcHFxT3hPcklQRjBwVmZ5bVFJ?=
 =?utf-8?B?eEtGZ1ptUUEzM0RQdjBwV0xvWWw0SmNPWkp4M0lvN0toaFFhd0RoNThNbUhU?=
 =?utf-8?B?OVltejZDNDRPejhzTzFTZmVTNXlIRFF4Z253MkgzQS9ic3NYY09zWis3Undp?=
 =?utf-8?B?bzRiOXdOd01aZHY2Vk5rb2ZnbjExT3pQeUM2dlN5RndqdnZRWitBbStiQmgx?=
 =?utf-8?B?WWlzMTZxeEZTa2ZhZjJuNlV1VE8zNzZRMWQ3WHlDK0N0VjZlalo3SmtrSUFJ?=
 =?utf-8?B?cW1KZ2xEME9sTHdaZkVqOVJDWENySUI1VUtQcDZ5OHBzSjVqTGxrd0V4ZS8z?=
 =?utf-8?B?ejAwYkVsN3Q2RHc4LzNzWXl3TVM2OWJsRS9XTXNrYXhjdnB4dXFsdGtGRzNz?=
 =?utf-8?B?TzVtM1lzREJOa3BNM0RYTnNnSnk0MlB4Yks3cEo3OXdIZnp0NDBjcC9XRnhU?=
 =?utf-8?B?UXZxaU1oTS9BbFk3VXpnQVRuc1NnNWVvb1BrK0VHMi9nUXozZ3BhQW1COEJN?=
 =?utf-8?B?STNnR3lqeGtjVHlqZlAwSEhhdDVSNFlwYm9LVlN0d3BrM1B1UUhBckczZnVj?=
 =?utf-8?B?bFFuN1ppUFUxWEZ4V3IvcmJqdjRtYWFxMCswMjVpUWQ1NUtPUXdYTlpmaDBM?=
 =?utf-8?B?R0p2UzlRMEZGUWFxL1N6T3lPN0lSZ3JRNDJHVzNnTGNXRFBMU0U1a3dsZi9v?=
 =?utf-8?B?THMxd1RVUkJlSmRmdTRkMWs0UEpDOXJ0d01acXF5enNOTWZoYlN4OHJyUStW?=
 =?utf-8?B?cG41K0RTaTJiMFhwRzR6SHk0Z3dWNko0UGJuZHlncmc1OTVzQlROR3lwNW9p?=
 =?utf-8?B?UUZ4R2dxa1NVbHRxVkN4UmY5T1NXUCtrZTFkRThXTXFCeVN1YlowSW85ZTJu?=
 =?utf-8?B?eS9GQktSUzEzRzZoQzVvVTl3dmR4blZrSys2MGRlNmtUcmZFTnE2QkZvdlIy?=
 =?utf-8?B?dFo5aFhiV290RjVtWlp0d25CTWdCVHZkT3NjUHh5RUxmTEYvdTg1Sjg5VC93?=
 =?utf-8?B?cEpPaFAvek95bGY5YjhLd240RWFiamgxOFprS0lXTFY5NS9CVXREUHpMNFNp?=
 =?utf-8?B?cU9PbXB2TGtqa1lPbjdINjBoTk15Uk9rQ2NtS1RuOUNscDA1WGIxU3gyem93?=
 =?utf-8?B?MkxtN3N5OGZZcUdwY3JSKytVamZHc01ibUJEeEkrZ2MwdjdyL2ltK29VdC91?=
 =?utf-8?B?R3Y4dG5yckd5ZVlyaG1TL0x6MzhHaUxJbkpKZGY1eWdoSS8yZjFZd1hSY3di?=
 =?utf-8?B?bjh5QURDWDVHRng2TmNkRWQrdEFNS1RkQWkyQmlyWExOT3ljdGdtbFRmRWRl?=
 =?utf-8?B?TGNLbmtqQ1hOdFlZZzdUYW5ic0FDMUJxREZwSndHZDY3bmlBNGxNbWFsK0lx?=
 =?utf-8?B?YzVDbS9qUUk1eEVEUG5wdng5bUhsNFpydnJYM0xSMnA3SzV1QjBsbXk2MEYv?=
 =?utf-8?B?MFFSdjNuQk1Lc0F6VEhRbnNlVkY5Qm1hTHVkak1JdVhBaDluczZ5QitvU1Jy?=
 =?utf-8?B?OXk2Qkt5RXhOTHoyZFYyOG1nVk8xQmZJK2U4MHhDczFkczVOV2tDMGpzMUUy?=
 =?utf-8?B?NWtDRGlBcmRsdWI0a3Y4dHI4N3BTZVd5cVFCc3JrTHorOC83N3RndlowdFM2?=
 =?utf-8?B?eDg5TVpMV0hWQ0orR1dZZHRqZG5KYlk0cmhMM1czRjllQWs5eTNSQW9NU0dy?=
 =?utf-8?B?TFkrRG0vV0xnYlFNck15TTg3bU9MbHdJZWZURC9pK085RDR6YnVUU0FZTktQ?=
 =?utf-8?B?RUIwNDFXQ2F2UnJjbCs4WHdKL0lJTjBTcUVKSXREdHhLLzNZYlF6dFpzR2kv?=
 =?utf-8?B?dEVZcDhqMWc3NnpUUnlaZTllcVpRNnVmUURWN0p3MkZLWFlGMUpQMC9iMW1y?=
 =?utf-8?B?QmVjT1VaRFR6WTdvaDZacW96OHRnZ1FqK0djYjNBNVk4VjFWbjA5K05MazBV?=
 =?utf-8?B?elcxUDNwWmg1MXVDS0liT1ZyT0cvcC9CbkptNXlCQlhIMkV1Q0tobEpFdE9q?=
 =?utf-8?B?UmtMSklHdHd1QmNSdlpNZUQrSnZqd2ZOOENId21WR01PTnJHWlhjV29kb09h?=
 =?utf-8?Q?utEyxem/in37gvOg+CAdokg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5E913649E4F1F4EB847006503C72F5E@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd9fe77-7cd5-4cdf-bc87-08dca09f9fe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 05:17:42.2466 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m5QOe/mNEAZTQJuPwGgwV/bQeFLIhzNf1M9hkOumDbzH69tUQ6dITH2c/rTxAfUXxyVKHaWbjdiTnNiju+DXz6bFzj52QAfrgI8xHpijnLtlTgt51dpzAm2TMPT5VaSL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7452
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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

DQoNCk9uIDA5LzA3LzIwMjQgMjM6MTcsIE1pbndvbyBJbSB3cm90ZToNCj4gQ2F1dGlvbjogRXh0
ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxl
c3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlLg0KPg0KPg0KPiBPbiAyNC0wNy0wOSAxMTo1ODo1MywgQ0xFTUVOVCBN
QVRISUVVLS1EUklGIHdyb3RlOg0KPj4NCj4+IE9uIDA5LzA3LzIwMjQgMTI6MTUsIE1pbndvbyBJ
bSB3cm90ZToNCj4+PiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNo
bWVudHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93
biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+Pj4NCj4+Pg0KPj4+
IE9uIDI0LTA3LTAyIDA1OjUyOjQ1LCBDTEVNRU5UIE1BVEhJRVUtLURSSUYgd3JvdGU6DQo+Pj4+
IEZyb206IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlk
ZW4uY29tPg0KPj4+Pg0KPj4+PiBEZXZpY2VzIGltcGxlbWVudGluZyBBVFMgY2FuIHNlbmQgdHJh
bnNsYXRpb24gcmVxdWVzdHMgdXNpbmcNCj4+Pj4gcGNpX2F0c19yZXF1ZXN0X3RyYW5zbGF0aW9u
X3Bhc2lkLg0KPj4+Pg0KPj4+PiBUaGUgaW52YWxpZGF0aW9uIGV2ZW50cyBhcmUgc2VudCBiYWNr
IHRvIHRoZSBkZXZpY2UgdXNpbmcgdGhlIGlvbW11DQo+Pj4+IG5vdGlmaWVyIG1hbmFnZWQgd2l0
aCBwY2lfcmVnaXN0ZXJfaW9tbXVfdGxiX2V2ZW50X25vdGlmaWVyIGFuZA0KPj4+PiBwY2lfdW5y
ZWdpc3Rlcl9pb21tdV90bGJfZXZlbnRfbm90aWZpZXINCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1i
eTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5j
b20+DQo+Pj4+IC0tLQ0KPj4+PiAgICBody9wY2kvcGNpLmMgICAgICAgICB8IDQ0ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+Pj4gICAgaW5jbHVkZS9ody9wY2kvcGNp
LmggfCA1MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+
PiAgICAyIGZpbGVzIGNoYW5nZWQsIDk2IGluc2VydGlvbnMoKykNCj4+Pj4NCj4+Pj4gZGlmZiAt
LWdpdCBhL2h3L3BjaS9wY2kuYyBiL2h3L3BjaS9wY2kuYw0KPj4+PiBpbmRleCA3YTQ4M2RkMDVk
Li45M2I4MTZhZmYyIDEwMDY0NA0KPj4+PiAtLS0gYS9ody9wY2kvcGNpLmMNCj4+Pj4gKysrIGIv
aHcvcGNpL3BjaS5jDQo+Pj4+IEBAIC0yODMzLDYgKzI4MzMsNTAgQEAgdm9pZCBwY2lfZGV2aWNl
X3Vuc2V0X2lvbW11X2RldmljZShQQ0lEZXZpY2UgKmRldikNCj4+Pj4gICAgICAgIH0NCj4+Pj4g
ICAgfQ0KPj4+Pg0KPj4+PiArc3NpemVfdCBwY2lfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb25fcGFz
aWQoUENJRGV2aWNlICpkZXYsIHVpbnQzMl90IHBhc2lkLA0KPj4+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBwcml2X3JlcSwgYm9vbCBleGVjX3JlcSwN
Cj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGh3YWRkciBh
ZGRyLCBzaXplX3QgbGVuZ3RoLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgYm9vbCBub193cml0ZSwgSU9NTVVUTEJFbnRyeSAqcmVzdWx0LA0KPj4+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IHJlc3VsdF9s
ZW5ndGgsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
aW50MzJfdCAqZXJyX2NvdW50KQ0KPj4+PiArew0KPj4+PiArICAgIGFzc2VydChyZXN1bHRfbGVu
Z3RoKTsNCj4+Pj4gKyAgICBJT01NVU1lbW9yeVJlZ2lvbiAqaW9tbXVfbXIgPSBwY2lfZGV2aWNl
X2lvbW11X21lbW9yeV9yZWdpb25fcGFzaWQoZGV2LA0KPj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGFz
aWQpOw0KPj4+PiArICAgIGlmICghaW9tbXVfbXIgfHwgIXBjaWVfYXRzX2VuYWJsZWQoZGV2KSkg
ew0KPj4+PiArICAgICAgICByZXR1cm4gLUVQRVJNOw0KPj4+PiArICAgIH0NCj4+Pj4gKyAgICBy
ZXR1cm4gbWVtb3J5X3JlZ2lvbl9pb21tdV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbihpb21tdV9t
ciwgcHJpdl9yZXEsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZXhlY19yZXEsIGFkZHIsIGxlbmd0aCwNCj4+Pj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBub193cml0ZSwg
cmVzdWx0LA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHJlc3VsdF9sZW5ndGgsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXJyX2NvdW50KTsNCj4+Pj4gK30NCj4+
PiBDYW4gd2UgdXNlIHRoaXMgZnVuY3Rpb24gbm90IGZyb20gdGhlIGVuZHBvaW50IFBDSSBkZXZp
Y2UsIGJ1dCBpbnNpZGUgb2YgdGhlIHBjaQ0KPj4+IHN1YnN5c3RlbSAoaHcvcGNpL3BjaS5jKSB0
byBtYWtlIHRyYW5zcGFyZW50IGFic3RyYWN0aW9uIGZvciBBVFMgcmVxdWVzdCBmcm9tDQo+Pj4g
UENJIGVuZHBvaW50IGRldmljZSBQT1Y/ICBJIGd1ZXNzIGl0IHdvdWxkIGJlIGJldHRlciB0byBo
YXZlIFBDSSBzdWJzeXN0ZW0gdG8NCj4+PiBpc3N1ZSBBVFMgcmVxdWVzdCBpZiBwY2llX2F0c19l
bmFibGVkKGRldikgcmF0aGVyIHRoYW4gY2FsbGluZyBmcm9tIHRoZSBlbmRwb2ludA0KPj4+IHNp
ZGUuDQo+PiBIaSwNCj4+DQo+PiBUaGlzIHNlcmllcyBhaW1zIHRvIGJyaW5nIHN1cHBvcnQgZm9y
IFNWTSAod2UgYXJlIHRyeWluZyB0byBpbnRlZ3JhdGUNCj4+IHRoZSBwYXRjaGVzIGJpdCBieSBi
aXQpLg0KPj4gICBGcm9tIGEgc3BlYyBwb2ludCBvZiB2aWV3LCBJIGRvbid0IGtub3cgaWYgaXQg
d291bGQgbWFrZSBzZW5zZSB0bw0KPj4gaW1wbGVtZW50IHRoZSBTVk0gbG9naWMgYXQgdGhlIFBD
SSBsZXZlbA0KPj4gYXMgaXQncyBzdXBwb3NlZCB0byBiZSBpbXBsZW1lbnRlZCBieSBlbmRwb2lu
dCBkZXZpY2VzLg0KPiBVbmRlcnN0b29kIHRoYXQgdGhpcyBzZXJpZXMgaXMgdGFyZ2V0aW5nIHRo
ZSBTVk0gdXNhZ2UuICBCdXQgQVRTIGZlYXR1cmUgaXMNCj4gc29tZXRoaW5nIGdlbmVyYWwgdG8g
UENJIGRldmljZXMsIG5vdCBvbmx5IGp1c3QgZm9yIFNWTSwgc28gSSBndWVzcyBpdCB3b3VsZCBi
ZQ0KPiBiZXR0ZXIgdG8gaGF2ZSBjYWxsZXIgdG8gYHBjaV9hdHNfcmVxdWVzdF90cmFuc2xhdGlv
bl9wYXNpZCgpYCBpbiBwY2kgc3Vic3lzdGVtDQo+IGxpa2UgcGNpX2RtYV9ydygpIHRvIGF2b2lk
IGR1cGxpY2F0ZWQgaW1wbGVtZW50YXRpb24gaW4gdGhlIGZ1dHVyZSBmb3IgdGhlDQo+IG90aGVy
IFBDSSBlbnBvaW50IGRldmljZXMuDQoNCldvdWxkIHdlIHN0b3JlIHRoZSBBVEMgZGlyZWN0bHkg
aW4gdGhlIFBDSSBzdWJzeXRlbT8NCj4NCj4+IEhvd2V2ZXIsIHdlIGNvdWxkIGNvbnNpZGVyIHBy
b3ZpZGluZyBhIHJlZmVyZW5jZS9yZXVzYWJsZS9lbmNhcHN1bGF0ZWQNCj4+IGltcGxlbWVudGF0
aW9uIG9mIFNWTSB3aXRoIGEgc2ltcGxpZmllZCBBUEkNCj4+IHRoYXQgd291bGQgY2FsbCB0aGUg
cGNpXyogZnVuY3Rpb25zIHVuZGVyIHRoZSBob29kLg0KPiBJIHdvdWxkIHByZWZlciB0aGF0IFBD
SSBkZXZpY2VzIHdoaWNoIHdhbnQgdG8gcmVxdWVzdCBBVFMgdHJhbnNsYXRpb24gaGFzIG5vDQo+
IGFkZGl0aW9uYWwgaW1wbGVtZW50YXRpb24gZm9yIEFUUywgYnV0IG9ubHkgcGNpZV9hdHNfaW5p
dCgpLg0KSGksDQoNCkkgdGhpbmsgYm90aCBzdHJhdGVnaWVzIGNhbiBjb2V4aXN0Lg0KS2VlcGlu
ZyBjb250cm9sIGNhbiBiZSBpbnRlcmVzdGluZyBmb3IgcGVvcGxlIHdobyB1c2UgUWVtdSBmb3Ig
aGFyZHdhcmUgDQpwcm90b3R5cGluZyBhbmQgd2hvIGdlbmVyYWxseSB3YW50IHRvIGV4cGVyaW1l
bnQuDQpXZSBjYW4ga2VlcCB0aGUgY3VycmVudCBQQ0ktbGV2ZWwgQVBJIGZvciBkZXZpY2VzIHRo
YXQgd2FudCB0byANCnJlaW1wbGVtZW50IHRoZSBsb2dpYyB0aGVtc2VsdmVzDQphbmQgYWRkIGEg
a2luZCBvZiAiRE1BIG1vZHVsZSIvIkFUUytQUkkgbW9kdWxlIiB0aGF0IHdvcmtzIG91dCBvZiB0
aGUgYm94Lg0KVGhhdCBtb2R1bGUgY291bGQgYmUgY2FsbGVkICJzdHJ1Y3QgUGNpRG1hTW9kdWxl
IiBhbmQgZXhwb3NlIGEgc2ltcGxlIA0Kc2V0IG9mIGZ1bmN0aW9ucyBsaWtlIHBjaV9kbWFfbW9k
dWxlX2luaXQsIHBjaV9kbWFfbW9kdWxlX3JlYWQsIA0KcGNpX2RtYV9tb2R1bGVfd3JpdGUuDQpJ
IHRoaW5rIGl0J3MgaW1wb3J0YW50IHRvIGtlZXAgZXhpc3RpbmcgRE1BIEFQSSBhcyBpcyB0byBh
bGxvdyBkZXZpY2VzIA0KdG8gZG8gYm90aCAid2l0aCBBVFMiIGFuZCAid2l0aG91dCBBVFMiIG9w
ZXJhdGlvbnMuDQoNCkRvIHlvdSBhZ3JlZSB3aXRoIHRoYXQ/DQo+DQo+PiBEbyB5b3UgaGF2ZSBh
IHNwZWNpZmljIHVzZSBjYXNlIGluIG1pbmQ/DQo+IEFUUy9QUkkgaXMgdGhlIGFjdHVhbCB1c2Ug
Y2FzZSwgYW5kIGl0J3Mgbm90IHRoYXQgZGlmZmVyZW50IHdoYXQgeW91IGFyZQ0KPiB0YXJnZXRp
bmcgZm9yIDopDQo+DQo+PiAgID5jbWQNCj4+DQo+Pj4NCg==

