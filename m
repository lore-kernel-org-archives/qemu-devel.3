Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9664CC41513
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 16:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFFir-0001eS-Ss; Thu, 06 Jun 2024 12:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sFFip-0001dt-QR
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 12:12:16 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sFFin-0004W3-7Y
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 12:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717690333; x=1749226333;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=6qfSmVVLhQwrX9I/w9xSOla+3geXyuLeldFBcu4Ql9g=;
 b=LOe7l+2K6879SETjoo9lHmf7NevuZd1vcwKokw6DBkn3dpRNxHGQzrvs
 YDaztWNL41mNCEiW2c13I8EukB7Ym8oHN9yjcY28qvN52HlS79nMDRJmV
 j4cSgKp5Q5GpQcITYh8VcfDxZG5wE2Bg2Vyg6LtgFPvE03C8Pu2A/A7aD
 +RZwl5XIE1QIIjx0REZ72wAnQ6FvG56SZU8l+46vPx/nOoTz/Ea2150Gj
 tIPsR2YTyr6Oz67NUK1aFdYoB69TifqRvIAhUC12MfbQ8g6D36jzz1nff
 nXz0iQbvlfTPRg32k3rvecwfW5DG55m7Ui+HQQpi74ec4w4DcpdbRwsAc g==;
X-IronPort-AV: E=Sophos;i="6.08,219,1712613600"; d="scan'208";a="14043987"
X-MGA-submission: =?us-ascii?q?MDG/qZo4I16nV+WJKPzRiKzFYMp8ODwdJARNYG?=
 =?us-ascii?q?7sENG+ioSA53A/evwky58VlA+SNG+rPhwlSfswiMLmvnQB1wiPhinWjZ?=
 =?us-ascii?q?H3l2BKcM9+RNdk100F1LOM1Tl0nCMuf7J8kp5ozC5OygcfZQm4RgplBn?=
 =?us-ascii?q?o8jQbbTuHfgYNntfd9RTnjag=3D=3D?=
Received: from mail-ve1eur01lp2051.outbound.protection.outlook.com (HELO
 EUR01-VE1-obe.outbound.protection.outlook.com) ([104.47.1.51])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2024 18:12:08 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4fOKtjhxZSaPbFxANpzSyWMi60qAqUSbzfoAxKHt3hx2w4iEb8fNMGzf2oNJ4rOB5Hgs0+8YgzqUlLSPeqXCwyDm3BEdTf0HBy2hhbassZfWxhA5yrQARgmiT7Y9FUQYuxPehlQSN2kOeXYxHzCMtoExqFZTCInWqokjxei+xTyzV9+1FMJyaYHyM1fbEzPfXwIXH7Pwe2s/0KOS+UuBkurfx2rE7G3nEqRpMEd+s4LYnbeq8v0/mDsb0K1JpC3+ls6KIKf8BWxcdwrkfFyLBOAA0WPKNAfWal5jAwr1eRZKay+bNkpfbp+A2zMzRPXmLsIjqSWIvlBdXrE6DUS0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qfSmVVLhQwrX9I/w9xSOla+3geXyuLeldFBcu4Ql9g=;
 b=BOksNqWw0j/cDzay/YU1l6H16BfdkhTCetCzMK+A1SzxNytlsBWvnMHH9L4Vm+jRAnbgnMKVOxIMCENNhxtuM3qsWU210jMm0pWbUq1rlc+dMdq31s9Is17UNDFA39+dVJBQAiN9kTnQqHGMk5zRCRfHCfrK+FmR3/lNegZaCFS0HxrfZeDFQJCv9uNSbCwdtUrdwNxIn3ayuqagkTLd+N1PdVnHLdQnSpQ0PVeweBcui+NcQa1VZSrLPyYZ5jIPoJZZxlfE6wzVlOu1WDnAjA7CH1oQ2K5JzSA4gLz9DnZg5ST5hJHpCAyel93BYniMM10hqBVfBK3Wg6+OiBi7Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qfSmVVLhQwrX9I/w9xSOla+3geXyuLeldFBcu4Ql9g=;
 b=s4mXmg+wjkwbSwwJMmgl4INBFKnnnisAl0F3UC2YxmplIvBxjqIgR7NuPsDQJSe5LdItJreMY2BS6KPyrTQh7xbFJNPhHt0adCCMCWGTLwVSSDKZd+ogF02nvedOkZ02hgoh5ow5Q4GbPR1wd+P2jTGePNs3PHIILYX8eofpiMQBbEwJBEvIC39WvWZzGgylMAduZ1DjHAMQxyaLp/dEfSEYtfhTHapBTVaGivgHTL8LbAiOn0ZUAEISi7Kkme47dPh1Ue33zCShCBmtEETF4xOf35Xmh4I80CCdO3VYWPXRDOcfxWUQq7oDn+Ib3YM57yT4pOQktXLEWTDT2X5mPg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS2PR07MB9078.eurprd07.prod.outlook.com (2603:10a6:20b:545::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Thu, 6 Jun
 2024 16:12:06 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 16:12:06 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 0/8] PRI support for VT-d
Thread-Topic: [PATCH v1 0/8] PRI support for VT-d
Thread-Index: AQHasoxiO6+dgN7t50iro7G2HPLUFrG682SA
Date: Thu, 6 Jun 2024 16:12:06 +0000
Message-ID: <713ece39-bc1e-4189-a1d9-f81f9cdbd03b@eviden.com>
References: <20240530122439.42888-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240530122439.42888-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS2PR07MB9078:EE_
x-ms-office365-filtering-correlation-id: 3c7a8d89-7b24-4820-9b07-08dc86436900
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?a25xTmNGZldVSDVYbElDclY5dHJjdmxsV2M5V2NuT1FmSmY2cTJrTVF0cVJz?=
 =?utf-8?B?Ujg0eDN6VE1FSW5QUHMrKzRVby8xZWNKNEJOOGtJRUhId1pHL0JsQndaMHE3?=
 =?utf-8?B?RncwUVVVZkhHOWs5b1RjMnFGMWc2dHNzRkdIU1c5N3RidDJZeUpEYThyYmwy?=
 =?utf-8?B?TEJvTWxpK0RrcXJaZno2MVJYQm5CWUE5clZTZXJTRFB0OHVxZjRjUk14bEgy?=
 =?utf-8?B?TlRHVEN6SE9EKzVkR0Q5V1lrUmw5TWpnRVh2bkgzeUxHL3ZvYWphb2ZHR0pE?=
 =?utf-8?B?L1dFMGZGTm4veSsycUIxVjZEL0tpaHZtS0xRWUtRY1hueTJkek01c0FQODQ3?=
 =?utf-8?B?OEtheGVFSHVXS0dpYTZ4ZjhYa2FKMVdQZkJRMVVibEx5YkdmVmg0SHRNQ2pl?=
 =?utf-8?B?bDljMjYxc3cva1ByMkcyWUtXdDZXbjg4ajZMVVhKRHZ0NDNXd1p6bDl2ZUJY?=
 =?utf-8?B?YjlKVEJabHlQOEdMeTYrQ3NvVC9SUTRTMXFrSkNoRk5XR3lGZ1pFbCtNY09i?=
 =?utf-8?B?MW9IczZseTllcllxMml1bTZlN2syeWlWY2drZmdoMGo5dENYbUEwa1kxeWps?=
 =?utf-8?B?ZWRjYjMyWk05eDArbldlNXZEaElwTXRFR2hKYVk3cTFXZEo1N3JVckF5OGFN?=
 =?utf-8?B?TkpFd3BTcTYwVzkvL0NJZTEyYTVBbXkrdW9nNkNXbnZTbkZzcVgyTUJnL3g2?=
 =?utf-8?B?dGhQWk5TQ1VDWFVlbVcyMEdueHM4dlNVQ05EaW5zYnNha2NodWt3UTF4eldz?=
 =?utf-8?B?N2ROWUR4NE9jb1RkcWUzU295THNqZTU3SUozaE1Ganc4ZU5iQjZMVHAvS2hI?=
 =?utf-8?B?RG13V24yUCtFMHpLcE5IWEdJb2k5bVBHL21LZWI3Y3NXWTJOdk5menBLaFBs?=
 =?utf-8?B?d05SeGVpUDY3MThTZ2tQcFFDMkVxcG1kcHA5NmFMdnZFRFJpa01DbjZidkdR?=
 =?utf-8?B?RGNsK0NQdlBDTjNNUkdObDhIL3NQRlRBdjdwVWdJeGpERFpSck9ZbXFQWVVN?=
 =?utf-8?B?WHhmNmVnOUJNeTlRNUsweUZRQUxydTlXOHNzU2pIajZXKzNtU0V6Z3ArRkFj?=
 =?utf-8?B?dTJSaTZrdlk5YnF3T1VwZHRlZ2Jrd0tYZTI4Uld3UldGdnpubnF5cE5FWEpi?=
 =?utf-8?B?T1VLSWVaV1o3Z2doVnhKVml5clZQZTBKU1dRWGd6bWpYQmRrNWNGdnViejJQ?=
 =?utf-8?B?c1M3M3BVOTJyUm9MZVhiWWRORmJKOFFLcUh6aHNFa0VqWENuL2RMbnU4aXcr?=
 =?utf-8?B?WTNGQ3dITyszYWdEMURXbkYxWHBlUmpGWVg2c0lSOFRiY0NFT1lpWTV5OEJH?=
 =?utf-8?B?TWp0Z1I0OUpHZ0lJdlJYU0JCSlRsTHRFOFhYa3dkdUtKcno1WWhieXdwdTZX?=
 =?utf-8?B?VUNpRW5NcFJESXhyYWdlVkQyVUVuZ3JicmFUUTJYaURQNVovL05EbDRmeG05?=
 =?utf-8?B?QWI1dzhLSVZqVmh1enNlN3c5SFlyWHB1Z09wS0I1ME4wVVZhV2p3ai81Wm5G?=
 =?utf-8?B?blAwdXZqdWVMbFhHcWVKeWFaTDdUZTVXOEJnY1ZwK3h6N1l5QTVVdXF6S1Nl?=
 =?utf-8?B?d09uellhNmV4NThlUXFncUFYZVVUTDFLS3h0UE5lQXNINTgxNUZuaUMzcU5Y?=
 =?utf-8?B?Z0lhWnZ2QW9HT0ljcnk1bzFXYW9kUjBrdnhHbWlZOUNjTEFIZ1diM2Qzb3Vw?=
 =?utf-8?B?c0hwTHMvUG5Nb2F0SVpsWStUL1N0TVl5Rm1MWDMzeDZxQ1JsMk1rQTMwem41?=
 =?utf-8?B?RVVOU2JKWTB2c1NwMVM1U2I4K0diRTNsblpsOVppWVZVTVkwNU5zcG1YdEhr?=
 =?utf-8?Q?2SSVCMOggM/o/4BfCb1R0HD3smpr5HW3nV8fs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dS85K1pvZnFUMkZZK0xFSFBBbElxNVhmUDEyVlVnSHpxdzdwWjVKSThmdFFO?=
 =?utf-8?B?OXExSXRMcTdnbVN0VU0zTnZNa3hyMUV2V0l6d25TMFFBbHZVS01sMEFmOHVq?=
 =?utf-8?B?NVVnOTlmbnBlUVJFeksxYWJHVnQyTTFaeXNvbEx3a25saTliQS9CaTd2aHVz?=
 =?utf-8?B?Vk9iaEZwRWV5UnQwb003U2h1V2p2ZFJLMmd4MEEzalhhVlVuL3FsRS83azZG?=
 =?utf-8?B?Z01MZDNFQ0dBSXF2ZFQ3VndJUVRUR3NBV0RmVzQvUzZ4QVRSUGhaTlBUWURq?=
 =?utf-8?B?RnNmTjVMZ1dXd3J1enoyZ1ZRejRJbWIyQmVJQW5MbkovSkN1ZlFROXArR1lJ?=
 =?utf-8?B?WDlHUGRUemtvYzlWNTVHZ01mbjNBbzNGNy9adlcvR1p1N2lScUhZQ21OWGtG?=
 =?utf-8?B?cFQ0Y0dZN3VLdGJNWHlvdlNiWUF5RThrc05RWXp4Q3RRRnFHanFIWEZ6YjJH?=
 =?utf-8?B?UlFzRlZLWm9BZXAyR1I5U0Jaa2pBVHRiSUJnVFRxWEVMS09jbVZVNjZTVisv?=
 =?utf-8?B?ZERqZEY4cDhZa3IrNjY1NzZOMkpJSGlCV3k4NzY4UkFDc3hNR01qNHZzU2Zo?=
 =?utf-8?B?U1diSDhsYW5sdHFoK1JGcnBhSXlsNmFmRGw3WTU2YlV1VzhYU3MrOUZ4aXVJ?=
 =?utf-8?B?TDNva2tUeEtkRHNqNnhTbWlBRXVGUnRxc3g3ai9yRFc0NVkrV0p4bUZ3ZzVM?=
 =?utf-8?B?UWhCMTJqbHd5UW95TFNoSXV5VGRZM1hwbXN2QVdCTUpYOWVVVXM2WTFoemxU?=
 =?utf-8?B?M1BPZE9hL0RaWmF1Vkg3bTVBUFQwYnhvakl0R2hpemFxT05RUnUyUEZTTmVS?=
 =?utf-8?B?aEZvT2dRNlc0UEF6ZkhHY3JxQmtmSVVuc203V1BQMU9YMWJXeE02T3lnTmZQ?=
 =?utf-8?B?bzVUUlBWamZvanltMTlwN1NlODBZemw3b0x0eVlyR3VSbVd3d1Q0UXVTZ2tm?=
 =?utf-8?B?UXh5RVBPY05XTjhZRFlGdmN2YVhIMkIydEpoY0RkWCtXbFlOVjBGYnpUTGk0?=
 =?utf-8?B?NktRSmVJeUFWZEh0Yy93SmVLUnovOXlxeEhxREFsc0xFVEhlYkh0bDdFcmYz?=
 =?utf-8?B?aHJVRnZydnlCRnJxeXFYUjVzcllPb2ozOFRMSzRCWXRWVkFLdlFKSzAzR3lX?=
 =?utf-8?B?UFB4Sjc2dytDTjRvRk5mV2RVRWtlQUJrNTVmMjY5cTRZZE1ZdTRjS0s3R0M5?=
 =?utf-8?B?THQ4L3plWTU4Nk5ITlYwU2dDWG5qalpMYnd3SWdqUFAvRDVjb0hGUmN2SEM5?=
 =?utf-8?B?aU1XNHJTRmgwcTQ3Y0FYTkJxODlLMStXWWJYK2RxeVZnZ2xSQnFlUUt3ZlNz?=
 =?utf-8?B?OWVnTXVORURCckZWZ2FYeEpENHJ3cUNmUWdyZHVMWFkzOVF0TWNwOWtyYTVZ?=
 =?utf-8?B?dkNPQk45dnBqb3VPaHhlS05pOUhleWJ5bE9HVVI3ZWpkSUNDK1FnVU5qNGdv?=
 =?utf-8?B?VVZ6MHJhL2UrL2pKdTFVWEtCUVpON2xUU0d6cEJnQnMwTStYeDhtQUd0MXdQ?=
 =?utf-8?B?YzVBNnZtQkdjd0pFc3hzSXFhMWllZEtWUUpuV2ZxU0k2aXl3OGwyNUxhTjUy?=
 =?utf-8?B?aDVwV25xU3MvRVhkY2llWXpDOE9FOU5kd2RGaUNjaGlab05PMHV3L0JKNGNt?=
 =?utf-8?B?bnJrSkNJUXlDTXJ6bHFKeE1xTVRVTDhySTdDcTU2M25nMG0vMEVBUnpMN3p0?=
 =?utf-8?B?SUhMTXlOcUhJdHpHMlQyTlRFQ25jaXJVV1dUYjczL0JYMWJXV3dvNWptV0pU?=
 =?utf-8?B?ZHhISWxHNlFmakU3dFBDMnpZZ1h0QWZWazJtRTlHVEthamJXU1owWk5ST0dC?=
 =?utf-8?B?aHkyM3dUMThtSzMzaU50S2JnQVlOSlNWK3VXZXFlRjREVkNyY0tBOUsrRUwy?=
 =?utf-8?B?d1B4TlhZWGdwS3ZUendqa1BmcFhrY1RzcGhqNWhlb2IwM0hJdW91UGhHcUp5?=
 =?utf-8?B?OFEwUDRDVXFpNCtYR3ZIZVdRZ1lHV1lzd1hETEh4b3pVSWtHdnhncTh1NDFX?=
 =?utf-8?B?U1pKMEVPdi8vOXBNV3FyVFAzZi8vTmw2ajVPaTVpbXpybFpOYzBNSGEzWU04?=
 =?utf-8?B?cVpYeDc5aHA2SmxESlBUSVFpaFBtTXYzYVhCdStGYWQyZENlVERZUzVWVWhy?=
 =?utf-8?B?bVZMZHNEOGFOQjhSVVgwb1U1MW1LSHh3QVg5UkNteis2cWpsdE1pZHNCNXp6?=
 =?utf-8?Q?WPP7egsW0OiA8sGF5V5Dmg8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C46CED78C06D740A1B11D282BEE4AA0@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7a8d89-7b24-4820-9b07-08dc86436900
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 16:12:06.2045 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XTNQXIBwe/2Sf7k0eFTeMrDQC7Z06Q+2opVYczUy2fEO64Tz2+2GsgavYEJtjpmNKfqRXP7sqZUEb0weHuFTkxhEDhsfBCcMbOh6J4qsiKjB1UP6K/YNKxLjKx6XNZGd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9078
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGksDQoNCkp1c3QgYWRkaW5nIE1pY2hhZWwgaW4gQ2M6DQoNClRoYW5rcw0KID5jbWQNCg0KDQpP
biAzMC8wNS8yMDI0IDE0OjI0LCBDTEVNRU5UIE1BVEhJRVUtLURSSUYgd3JvdGU6DQo+IFRoaXMg
c2VyaWVzIGJlbG9uZ3MgdG8gYSBsaXN0IG9mIHNlcmllcyB0aGF0IGFkZCBTVk0gc3VwcG9ydCBm
b3IgVlQtZC4NCj4NCj4gSGVyZSB3ZSBmb2N1cyBvbiB0aGUgaW1wbGVtZW50YXRpb24gb2YgUFJJ
IHN1cHBvcnQgaW4gdGhlIElPTU1VIGFuZCBvbiBhIFBDSS1sZXZlbA0KPiBBUEkgZm9yIFBSSSB0
byBiZSB1c2VkIGJ5IHZpcnR1YWwgZGV2aWNlcy4NCj4NCj4gVGhpcyB3b3JrIGlzIGJhc2VkIG9u
IHRoZSBWVC1kIHNwZWNpZmljYXRpb24gdmVyc2lvbiA0LjEgKE1hcmNoIDIwMjMpLg0KPiBIZXJl
IGlzIGEgbGluayB0byBhIEdpdEh1YiByZXBvc2l0b3J5IHdoZXJlIHlvdSBjYW4gZmluZCB0aGUg
Zm9sbG93aW5nIGVsZW1lbnRzIDoNCj4gICAgICAtIFFlbXUgd2l0aCBhbGwgdGhlIHBhdGNoZXMg
Zm9yIFNWTQ0KPiAgICAgICAgICAtIEFUUw0KPiAgICAgICAgICAtIFBSSQ0KPiAgICAgICAgICAt
IERldmljZSBJT1RMQiBpbnZhbGlkYXRpb25zDQo+ICAgICAgICAgIC0gUmVxdWVzdHMgd2l0aCBh
bHJlYWR5IHRyYW5zbGF0ZWQgYWRkcmVzc2VzDQo+ICAgICAgLSBBIGRlbW8gZGV2aWNlDQo+ICAg
ICAgLSBBIHNpbXBsZSBkcml2ZXIgZm9yIHRoZSBkZW1vIGRldmljZQ0KPiAgICAgIC0gQSB1c2Vy
c3BhY2UgcHJvZ3JhbSAoZm9yIHRlc3RpbmcgYW5kIGRlbW9uc3RyYXRpb24gcHVycG9zZXMpDQo+
DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9CdWxsU2VxdWFuYS9RZW11LWluLWd1ZXN0LVNWTS1kZW1v
DQo+DQo+IENsw6ltZW50IE1hdGhpZXUtLURyaWYgKDgpOg0KPiAgICBwY2llOiBhZGQgYSBoZWxw
ZXIgdG8gZGVjbGFyZSB0aGUgUFJJIGNhcGFiaWxpdHkgZm9yIGEgcGNpZSBkZXZpY2UNCj4gICAg
cGNpZTogaGVscGVyIGZ1bmN0aW9ucyB0byBjaGVjayB0byBjaGVjayBpZiBQUkkgaXMgZW5hYmxl
ZA0KPiAgICBwY2llOiBhZGQgYSB3YXkgdG8gZ2V0IHRoZSBvdXRzdGFuZGluZyBwYWdlIHJlcXVl
c3QgYWxsb2NhdGlvbiAocHJpKQ0KPiAgICAgIGZyb20gdGhlIGNvbmZpZyBzcGFjZS4NCj4gICAg
cGNpOiBkZWNsYXJlIHN0cnVjdHVyZXMgYW5kIElPTU1VIG9wZXJhdGlvbiBmb3IgUFJJDQo+ICAg
IHBjaTogYWRkIGEgUENJLWxldmVsIEFQSSBmb3IgUFJJDQo+ICAgIGludGVsX2lvbW11OiBkZWNs
YXJlIFBSSSBjb25zdGFudHMgYW5kIHN0cnVjdHVyZXMNCj4gICAgaW50ZWxfaW9tbXU6IGRlY2xh
cmUgcmVnaXN0ZXJzIGZvciBQUkkNCj4gICAgaW50ZWxfaW9tbXU6IGFkZCBQUkkgb3BlcmF0aW9u
cyBzdXBwb3J0DQo+DQo+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgIHwgMzAyICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIGh3L2kzODYvaW50ZWxfaW9tbXVf
aW50ZXJuYWwuaCB8ICA1NCArKysrKy0NCj4gICBody9wY2kvcGNpLmMgICAgICAgICAgICAgICAg
ICAgfCAgMzcgKysrKw0KPiAgIGh3L3BjaS9wY2llLmMgICAgICAgICAgICAgICAgICB8ICA0MiAr
KysrKw0KPiAgIGluY2x1ZGUvZXhlYy9tZW1vcnkuaCAgICAgICAgICB8ICA2NSArKysrKysrDQo+
ICAgaW5jbHVkZS9ody9wY2kvcGNpLmggICAgICAgICAgIHwgIDQ1ICsrKysrDQo+ICAgaW5jbHVk
ZS9ody9wY2kvcGNpX2J1cy5oICAgICAgIHwgICAxICsNCj4gICBpbmNsdWRlL2h3L3BjaS9wY2ll
LmggICAgICAgICAgfCAgIDcgKy0NCj4gICBpbmNsdWRlL2h3L3BjaS9wY2llX3JlZ3MuaCAgICAg
fCAgIDQgKw0KPiAgIHN5c3RlbS9tZW1vcnkuYyAgICAgICAgICAgICAgICB8ICA0OSArKysrKysN
Cj4gICAxMCBmaWxlcyBjaGFuZ2VkLCA2MDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4NCg==

