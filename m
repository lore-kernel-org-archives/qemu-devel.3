Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C856C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 11:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQmj8-0003xq-4B; Mon, 08 Jul 2024 07:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sQmiy-0003o4-Py
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:40:04 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sQmit-0007s0-L3
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720438800; x=1751974800;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=la8b6EsER2myyyqfK0mnc02PBu9H7RQtt1F+MmsewQc=;
 b=T6KvGj3TxAFbywoEmYhS0j7j853W4cShUvu39047MthFVx+/jyl84yN0
 FbpywVZK54SM3+z/YAqf6m8L5J/oBiV1XzEvU/RCJNXEmaB4r8bNPLOte
 Uwtvtv2PMrKXeyY5fauvcnCQxvjDm6MxVKSPHZDZmuE2dJPKVnqu4icaL
 x2Ck3fv9aLQfGlLiV9GQGcSAGsciikFoe0HW9aOF7K8LzuMtGjEP6gb9d
 8hEPNTfXh0qmL1+q9z4Z0nsxiY2tik68vkQ2smGGnZZKqB4x7w+j2hWfs
 oEKpTvTiq+hSyj2fTG0NjVRZAY+zMJMbl3WVRlAnZbNuBGnp1uLILLfoM A==;
X-IronPort-AV: E=Sophos;i="6.09,191,1716242400"; d="scan'208";a="16192496"
X-MGA-submission: =?us-ascii?q?MDE9xd9uTUWmHiN7aWnKyofv+/EfU5l1GT2n1y?=
 =?us-ascii?q?RzwB/e/6YnwfwGVB+yWSORsoa+c0U62h0prL0amYIaaJHaOS2nLwq84t?=
 =?us-ascii?q?Rgpx5rwlDqw6nY6RQ2WJ/uW3gn9xNW+dy67NTivPN2WNuVXJaOet2FEm?=
 =?us-ascii?q?sF1yekdewnIuxAg9bb63tz/w=3D=3D?=
Received: from mail-vi1eur03lp2109.outbound.protection.outlook.com (HELO
 EUR03-VI1-obe.outbound.protection.outlook.com) ([104.47.30.109])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2024 13:39:57 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7Kla+nNF/f46vNEiFUQDvOm68hTMGOo+5/AEtTo9faqofYlbyI+P8+wq+FAt+UBQH9BKPt5d5eFUpcRL3iYfIzWY1bvRXrLaUaUWOTHdyTrryuKMlRGYA6AAlLfe0aMbH9/yAbucZF1JNGP8AthPeR/u4BNlBCUq2XhlMIpsTIlAjqGjZ56RnzgeOhmsHCJoBg6Sq2jefS2eyIlAYTVNqkfSUgHMnd15eBga0yhdMp1JdW8RwzyNGv0vwqNgX0gpB4UadLkHsXQ3m2wHR4tt5MVXw+Z9XGZL95zq5lAMPx4bZUYZjhw2/+Cjz1oY2MHnLJdVxW9bGXnrCMkv+BInw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=la8b6EsER2myyyqfK0mnc02PBu9H7RQtt1F+MmsewQc=;
 b=UScYjwVMItxfY+L79p8u7YUaDHb4PYXbXNxtMeiOmcoWvWVzdLyMzBZPGmhF7D9noZXuvLJ5eHqQ2LC7jLq9TrMpuG90fZoNHHc2TsV3GIlf/WmJ+gKuWD7qJzWer4CVW4GHhw8V2GfSCFULJ+aXJ+sOTuWK5RSnD1KGt0Wb9LpCGdaoiSIogt26RfqKwCNDCdGnP5/Y/X9qyKREF48WjYT+0T0R4xXaoaXi6kc9jcGu33Ux2VP50HCJhOMUqIZbCYLA0UAJscCyxzVgxqGlWW7JegW14pEE1B+NPmUEyf0jzAJuQ48Yn4wUkUzJ1y3pvU8oGmfvZnUgroa02b3kBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=la8b6EsER2myyyqfK0mnc02PBu9H7RQtt1F+MmsewQc=;
 b=bv5WYFmFDfrDsx3mtcXq+iJgM5ywqlsHegyI0ytxXLgWtsW4nZEbq675LQKLZ7YUKa+o2KTLb9oL2wF0Mp7YxTWOnuVYNILC5FvbkPVEG8amYbyjLRsTAHbBYlEDZ6f3td5E0qFAYZDjYau16lT9dEMWsODkokdUThakqO3kE5bh2Q10CUR6YDJGlOREuoTcTeuoRU7KuKp23gBiRI03IIzG5QPjx4g5/S16savCBK7XWGSJbjNGBA0gKOIJHoRMNRIXvdfDMyjPAlcuQoc9mJxM5KitJcq6AAUajQAc1Eco4GwXibkAgh+ZstvgIXVb+/R7A+6kGEatFbHxjAbaEQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7400.eurprd07.prod.outlook.com (2603:10a6:20b:2a4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.18; Mon, 8 Jul
 2024 11:39:55 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7762.016; Mon, 8 Jul 2024
 11:39:55 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH  v5 4/4] intel_iommu: make type match
Thread-Topic: [PATCH  v5 4/4] intel_iommu: make type match
Thread-Index: AQHa0SuOE0rt69ReTEOYvhH3NMq2QQ==
Date: Mon, 8 Jul 2024 11:39:55 +0000
Message-ID: <20240708113908.19535-5-clement.mathieu--drif@eviden.com>
References: <20240708113908.19535-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240708113908.19535-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7400:EE_
x-ms-office365-filtering-correlation-id: 87fce5cb-fd61-46b8-300c-08dc9f42b092
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RGs0SVFERTk1OG5tZkhOc1lMVm1nZVdscVdWSm5Dd2kwQ2VMd3pSL1ZOTGFK?=
 =?utf-8?B?cnlMSWw1OVFsYzEvUmdmaXdSWnN6cmZvZ0xuMndkUWlIbXhReXB2SlhZSVVN?=
 =?utf-8?B?bHhGeGtvSU1LbEltS3ptOEVydTNFRXh4VHJBSllKN0JlTm5DVngwWEZYRXEz?=
 =?utf-8?B?YW1QbFdkRkVPVC9rN1B5QklHOVNjY1J1Z2UrNm5nazlXeUFUdnpBVFQ4REQ4?=
 =?utf-8?B?N0NmS0ZLWXpHYmlwdE4xTUZVelhvcnc0d2trdFVBc1lQUnVaZGZJNjVsSTlx?=
 =?utf-8?B?SGNqWU1HejBwTWhBQi9IR2t5eGd1YVZ4WktRQ3dOTS9qTnFQdzVobDVxS2tt?=
 =?utf-8?B?MFkrTjEzcDU2WmZ1ZGVyRnhtSHhxK0lsaXR2UWtmd25oUmpweGlTLzdYUzhn?=
 =?utf-8?B?MHRiWkpZc1Z1WWlYZDhLMUZIVjg2SnB6bDlCUmpHVy9hWFdrZit4V3BlSTda?=
 =?utf-8?B?OFo1aDlFR0VncmJ2cGs2U1RyZGhaN3l6QWFFUjJyVUlPWkRnNTdPamN4NzFG?=
 =?utf-8?B?OGYybUo4NGRudFBOWlR0Z2tWTHZTVlFXOC9ERW5reUlRaUN5SFZVRDZZVGJs?=
 =?utf-8?B?U24wNGtIMVhjalA5WHBMbTl6UDIwOTN1TDkrVDRta2xUZ0wzN050YzR0bjRm?=
 =?utf-8?B?Ujl0czlYUXY4Mlp3c2QySXV0MU03RE11a2E2eDNOQmJTNVJHR1ZhSFpOdFNG?=
 =?utf-8?B?SitXdGIvckxEYmRUWHQrLzVvRUVON3FZekM3STJ6bFJsWUEwSkMrRUNlQ1Nm?=
 =?utf-8?B?bzhWdHF0Njg4YzRaem4yUWNyZDZacU5YNWY1b1lWQ3pjUFRhRkQ2V3E1L3Bt?=
 =?utf-8?B?dndjU3hCcys0V2FnSEpJWTduL0dCVFlrcnBUMENRdEVSWFZ4YkR4WHdqRUJU?=
 =?utf-8?B?dU85VVdpU09zdUhRSXJLdnR2UGdSNlErS2tyeC92MmpPUnAvMnY5dFljNS9C?=
 =?utf-8?B?MGc4d3B1cVRMY3AzVmU4TDNRU3RWb0k0RGpGZE1XQmwzK2syTGRFZWpQMFJU?=
 =?utf-8?B?RUxVUi9OZlNvNEZNVFRWRTM4cjZsek9USVhDTXZGUlYyYS80U24xZHpoanMz?=
 =?utf-8?B?aGxtT1FCaHVIZE9MSDU2M1Y5MUdJUzNreVh5akEyVUFnVXJGZmMxTHVsZ1Nv?=
 =?utf-8?B?Z3A0bzVCRWJ5L0NodWRKSUJRaEpKcnQzMjVKbE1tWUQvMGFvckFaM3FpcXI2?=
 =?utf-8?B?WnA2TWh3WDY4WGJXdDFFYzFRVW5SYklqZVZURDRZRms3SENCZ1l5eEVEeXBZ?=
 =?utf-8?B?cDVWenVoNm5EWXdsOExaRW1HeDJYdUFZd0IyZFd5VjZ1NGNtelVoT3VNU3Rj?=
 =?utf-8?B?dWNuakVCK05aZXZJaC8xMG9FVitubjQ3aUVrSkpWR00vdFNXc2xxV2l3S056?=
 =?utf-8?B?V1lsRnZZUG9IcjBuTnd4d1JwdmZ4L09LVDI2bXVGK2JUVUg5MVViV203L21a?=
 =?utf-8?B?d1puQ2h3UWJSYjc5OWVoa25PcFdJYTkybG4xNm8xV1pYM2hQQUt5TW9IZ3NV?=
 =?utf-8?B?UXlFendHa053ZjJnVG0rbVgxV2ZZNFd1d3A2SHZybVI0czY2QVRLZXRSa0Ew?=
 =?utf-8?B?NEtlOEJ5eEo4VGdhSko2MExGWEYzSzdRWHdRUmMxZ1ZJYVd3SjlxMkhnZ0Uy?=
 =?utf-8?B?Z1RrYWV0dVJ1ZXZaN2JsWVE0TEN0ekdaNHhpYnp2dTkvMXNOOEkwMUVoelVh?=
 =?utf-8?B?Qm1wR0UxZ0ZlOUV5QWVxdWdnTHd2cXNSZEdCQ2JFRHp2ZDJzYitYUW5hQmw4?=
 =?utf-8?B?ejJoN1Jvbm9sZERSbjhhVWVaU2Y5UXpmMDdrcko3eDVybnJwZENZU0xVSGJk?=
 =?utf-8?B?WFR2d3hpR0lNQkNUQ2NrUmRDUHBhVEpMUzJCczMzYldNSTJwTFNvc0FIdlNV?=
 =?utf-8?B?NFhNWUp1K2hxckFNWUZvME1KaUU0ZC9UcVRxV1QvMTZJN1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGJZbDJVWXRUaXMrajdlcURtTXlJOXp3K21NRWVlN2k0QzVLSEFTV01CbldJ?=
 =?utf-8?B?RTUwOU82OUh4MnRGejRlZEFhRFB5ZU95TStHeG5UMVRmVFZXV01FcVpGdG5B?=
 =?utf-8?B?Y0YzQVRwM2pOcTF0TktjRHEvcW9UN25KaE9oRFFpSU1JMTN4NHM5S2NmYnpX?=
 =?utf-8?B?a2VWYVZHUmlxOXlsY0Z3NXJUSWtKOHRaamkrY0dXb3hIejJ0ODFRUzhWV0hQ?=
 =?utf-8?B?VGZZOGtzbU9LVXB4VGlLcmpPWVc1QzhhMDBES3g5d3FjeUJ2NExTYk5QeldL?=
 =?utf-8?B?SHEwT0dVcW5DVkFkZjVVcWJJNHJKMGhpc3RXdFFGLzhwSlovMVZrUVk5RlVX?=
 =?utf-8?B?VGhhcTNMRU9Lbmtyb0tkK1Y4SzU1VHZnbHl5VHZDQXFOcGJJMk8zdVRmZTJS?=
 =?utf-8?B?STZtT0czSlA1V0dnaFo1ZERuRktLaDRhSVIwQVVGTUJwSGx4VHQyODhZQ283?=
 =?utf-8?B?Ykd6RmhkRjAyeml5YTIyNEF6S2lURHFQdldNZXZnUkhCZ2lVdGhFOVlZa0Yr?=
 =?utf-8?B?bVlBWG9wN0xGS1c2YzU1TGYxcXZkeEFUbThKQU9EVkZTeXloOTNXcXI4SUIw?=
 =?utf-8?B?aVFkOXpXeEVML0tWWEMzSWxLblRXQ3Mzd0dQaTY3eWh5NnBLQ2FjT1hvOUlN?=
 =?utf-8?B?NndTSFRuaUEwMHoySHZCVWdGTy9ZTE15bzZTOWdtZE1RblIzNEVUT01IRnA0?=
 =?utf-8?B?a0lNcjRmZHJkelNzVDJjR3E4eDU0OXNFTnRqa2tEcklZNk8rTjUveWFkR2hh?=
 =?utf-8?B?dlJMeHFRWU1WQ2xBckxkYjByNm5ndGZCOHJZNEV3V0p5U295bW9LYzByL2s2?=
 =?utf-8?B?QlMrQm5JQmw2L1JrQ0ZOdFNjRmhPUnROenFubUFhR09yNCttN1oxekt2RU44?=
 =?utf-8?B?SHN2bC8waUJTQ0VQVER0ZlpEcmwvQjdjQ2JpbkIxNGY2SjJsMHdodWdLamMv?=
 =?utf-8?B?UE9yRzVrVzJINDRFNVkzY1JIaVVhMHhvd2R4RFEvNVduNmZ1d3NESGthLzQ0?=
 =?utf-8?B?cE9tMVM0TURiZVN1S0N4ejQ4Z29oOVFXTnM5T01FajhnWVFrOFFsMmlLK01W?=
 =?utf-8?B?VEJYb2toTk93ditrRW0yTWFUeDlZWnlEaXlGOUJpSExDY1JyQXBYR2dId3ky?=
 =?utf-8?B?blVkVTRCWlJBbnB6RVhLMzlGR1JuSGJSRklESkZBK25XWHRzWFBQejJNNWQ1?=
 =?utf-8?B?RTBOMkVDZHJmckVvdG40WTl1MWVKc1VYMnlrdXBiMmdRcUhQY1FzbkFpbTlT?=
 =?utf-8?B?anF6R05DdFRucjBMd0hjeEd2MmlBeE1LZUx3a05SdkNlTXFDL01RNjRyenE0?=
 =?utf-8?B?OHhscUVtc0ExUmJIdG1MSHBSWEt5V09QNkt6YzBjaEFmdzl2a3FWZWtSWVJP?=
 =?utf-8?B?Zjc5VStsL1BueTZUd1FDbFU0ZVhid0l5Rktsa1ljUWx1azNoekpJYmwyMjZu?=
 =?utf-8?B?QUluRnVQVllDSk1WTUZUd2FXS3lqcVZrdlFaZEdEVjhmTFIwVkZPZXd6amRp?=
 =?utf-8?B?ay8zNGFXNXBUVUNtUlV2WHk4bEZhMXphK1RjTGtWaEJMYVdZcFNFM2xmbkxD?=
 =?utf-8?B?TmlqNEwxbnBVeW5sODJ5UHIyT1N0VGhCdEZ3UDVjelpiRkZzM1B5WlRjS0dR?=
 =?utf-8?B?K0tJUFhqQXJFeEg1Qkp3NXV1TmRpSTZLMGlka0NvVTN2UlZuZmdnd1BKc09j?=
 =?utf-8?B?RXpJQnZKVFg3d29XSzRNV2U3YUptUjRiUHZWazF5NWUvbW1CcHpwMXV2VTY2?=
 =?utf-8?B?MFdmYzBld0srQ0JRUllBWmE1VzV3ZDJWTFhXc1o5czY5ZVZOM0pDbk9aLzh1?=
 =?utf-8?B?N0FsV2d0eGdhVlN2RWppYVd6aGtyVmhmbVpGakNTTnZRb2tXMWlIZVBrMGhP?=
 =?utf-8?B?Y3NaWHVhZXVndkhaREg2WFpneDJCR3Zob1JQdzFCUEtjaWY5WUFMbnphd0Vn?=
 =?utf-8?B?cWd3U2s0UnNMWTk3MEZvMEFOd01qd0g1ZmtWRmdlcHhFd0NRQm9wb1haZWQv?=
 =?utf-8?B?WDZGTnZkSk9tVm5USVB5eUxlOVhlMkdFODBzMGdSNVpRbGZWTUlqR3Y4Yzdq?=
 =?utf-8?B?Y3pHV0VFNzllVWRzV1FlbEM2bkVGQm5SdElzM2ZIN3NCVGNXa3hGcm9GeHhp?=
 =?utf-8?B?b1RHZjJMR3FTZVp6WmFhYy95WGFmMGFlRW1UZGRQMjgwRVRBejMyUklob29C?=
 =?utf-8?Q?9HllXAUk55ZVnewpxIZL7pY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <996E3B806C931749B7E7ED207FC690B2@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87fce5cb-fd61-46b8-300c-08dc9f42b092
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 11:39:55.8248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: am5unmpkSXmuVdbUvfFApVxu0w+DMXyDrcN047idqMfuqpTw46P3FCyJ/RBJa63V76LPHRrv1nxVEpJgrqKiV3+pT4fZmQuh/txMUoOfFLflkdTOyqM3ijQr26g3+8l4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7400
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClRoZSAnbGV2ZWwnIGZpZWxkIGluIHZ0ZF9pb3RsYl9rZXkgaXMgYW4gdW5zaWdu
ZWQgaW50ZWdlci4NCldlIGRvbid0IG5lZWQgdG8gc3RvcmUgbGV2ZWwgYXMgYW4gaW50IGluIHZ0
ZF9sb29rdXBfaW90bGIuDQoNClRoaXMgaXMgbm90IGFuIGlzc3VlIGJ5IGl0c2VsZiwgYnV0IHVz
aW5nIHVuc2lnbmVkIGhlcmUgc2VlbXMgY2xlYW5lci4NCg0KU2lnbmVkLW9mZi1ieTogQ2zDqW1l
bnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQotLS0N
CiBody9pMzg2L2ludGVsX2lvbW11LmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11
LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCmluZGV4IDM3YzIxYTBhZWMuLmJlMGNiMzliNWMg
MTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCisrKyBiL2h3L2kzODYvaW50ZWxf
aW9tbXUuYw0KQEAgLTM1OCw3ICszNTgsNyBAQCBzdGF0aWMgVlRESU9UTEJFbnRyeSAqdnRkX2xv
b2t1cF9pb3RsYihJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQxNl90IHNvdXJjZV9pZCwNCiB7DQog
ICAgIHN0cnVjdCB2dGRfaW90bGJfa2V5IGtleTsNCiAgICAgVlRESU9UTEJFbnRyeSAqZW50cnk7
DQotICAgIGludCBsZXZlbDsNCisgICAgdW5zaWduZWQgbGV2ZWw7DQogDQogICAgIGZvciAobGV2
ZWwgPSBWVERfU0xfUFRfTEVWRUw7IGxldmVsIDwgVlREX1NMX1BNTDRfTEVWRUw7IGxldmVsKysp
IHsNCiAgICAgICAgIGtleS5nZm4gPSB2dGRfZ2V0X2lvdGxiX2dmbihhZGRyLCBsZXZlbCk7DQot
LSANCjIuNDUuMg0K

