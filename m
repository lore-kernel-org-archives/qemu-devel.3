Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0D9EE0212
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 06:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soGoc-0002Mt-K7; Wed, 11 Sep 2024 02:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1soGoa-0002MK-QY
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:26:56 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1soGoY-0001YQ-9w
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1726036014; x=1757572014;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=dJ7tAYM5zUcqua4Q0H1DfoXu60s8w4zlNIDxZ4pGlF8=;
 b=rumYrfAWOYoyO6dHY3oRu9bgryzojG1dpNhhPzB0v+9a3IHVjaoDwovK
 IYRErD4K1mW2yiM6tjBf/12p/tvAHw6unN99dGazlIZuMR6/6t3e0DFHX
 amvWU/4g8nTfiyV4nomFdTVNSha0psX2OeGJUp/vDREAMaa6WfuHgY+ft
 nZXWIFyodizBuNZApUHTjA74bMctJaSwCd0h1jj4z4gW8kOqJi6Sbznk2
 bEN7YGbikvW/6MB7fr1z8VFDsCTKa+ggsLr9rT27AK/aed/bhM+5FHFl8
 R52VutHM+G7qRvtU8j9ciyysY6lXYCAtdeJie/IqLhY0KBGjzLfoNQd/a Q==;
X-IronPort-AV: E=Sophos;i="6.10,219,1719871200"; d="scan'208";a="20327517"
X-MGA-submission: =?us-ascii?q?MDF93xmUqPdWjhVeqyQ43+0phDWKilunUHKuaZ?=
 =?us-ascii?q?dzWE2472hJ49KWsHHxAWaYX82ZUOWcae27XeeQYBbsNF0zWIYmS/IvKp?=
 =?us-ascii?q?v692sJ1bq2MK/4z4H0xqp0hCULMxRCQm8ROC/C7GdT0kK7QnWf4jE0u/?=
 =?us-ascii?q?yV/oe1Y+C0HMqrxdNYIc3yKw=3D=3D?=
Received: from mail-vi1eur02lp2048.outbound.protection.outlook.com (HELO
 EUR02-VI1-obe.outbound.protection.outlook.com) ([104.47.11.48])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2024 08:26:49 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqZ8veKpUASVQGUlhA3K+4DSeRCM7ah0gv5ntm3fn7oWvjOF4ChBLaXbC5pAiuF0eunv7EWkkCaKOFU1kQTJQfmY/Qu6Mt4CiOm1B55kHFNVeQkf3dsNcZK7xA2tyj6TU94dXdYS1myEg4fQOfQhK9YkJDYqJLj/j9RzmFjpIl4sAlMEw4q0Bks+IVJl3S7exL3c5cDPY/RFpWxSZ7QRpktMVvFuJ9sb5eG7ADylSKxhd6K39HeTkip+4L98ddvsJDAzReyRfMZGA4GzuYsP/DX//WLxmYJ3N6W/roTgaj141MzalIGL7HR5QmSUeXq6P9f+axY6GnO31IC2TzrljQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJ7tAYM5zUcqua4Q0H1DfoXu60s8w4zlNIDxZ4pGlF8=;
 b=KdCPMMLziVorWijcs/93zba6KAJzH0JmzxY1AjB8Tf3F9qy8XKXD0hgJlcQByzBkahqbJKQgyrC/KDT1UvZno49SFaUgvWD5u40sIxxt2YcGaYwVtjDd1QRZ0RTKaaSNn94nu5C+O5w5Kp7xi2P9rBiRIB/zHSKAqHHbNA6ZkX+ARAuo0AxhmF4VrAZ6WpoMEaGuacS032qwRHbbAqfkcrOaSntnlStNza/ZPwKk+X4X5Ce0o54qv+pCkgtHtxnHTniVCEsvJXIjFhROTYfati8P1OFeL3PKpr8CfeEkWRU8NrfrwwbJAAvJFLkEgx6j5/qw1gBHK5CaGwfN8qimaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJ7tAYM5zUcqua4Q0H1DfoXu60s8w4zlNIDxZ4pGlF8=;
 b=ODFbLs95rnnOMY7MN//IbllHeu5VvNy/2a7PjBT3csUZKqJjovZnGZVd1Ec/QZWBEvfT2DgPtwQTlUzmS7XkpEL/rY4TZJuG89XzyrzJKaIrJTIlI8dURNY4yxaaMl5gs4PNhp4JGO+tVpJigyIZUvT8lNdJIB3drPbCoXxiGMehP8Xl5P/K13fZubZC5vjRFApXuRtXTbBcg0O6dg8NRsYNPWddLoVYY/pFd7ikXbAuRe6PmqbD8fTgYcEB+GtIPVUq5AD2EFxCsY/nSiETCw83UbudK6p3rrQS17rwHg6ARVDgxKGGV0pAw1y2wYq+Dsjd1nyG4AnRAu4vXY16Iw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB9PR07MB8653.eurprd07.prod.outlook.com (2603:10a6:10:309::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Wed, 11 Sep
 2024 06:26:47 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 06:26:47 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Topic: [PATCH v3 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Index: AQHbBAscmv6jZ0i+xEKdqePfCrW3KLJSHvYA
Date: Wed, 11 Sep 2024 06:26:47 +0000
Message-ID: <6aa82e5b-1795-4995-a561-0a27bac681c6@eviden.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-4-zhenzhong.duan@intel.com>
In-Reply-To: <20240911052255.1294071-4-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB9PR07MB8653:EE_
x-ms-office365-filtering-correlation-id: 131dca2e-f1d7-42a4-d2b8-08dcd22ab6a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dWhEQzJqNzRGZ1lRYnBDMWtmMVFiNHFIZmpPb3BxdHdmM00wRzg1U2lIbGlK?=
 =?utf-8?B?RzAwV2pSQUFNZkpJS1VjNEtoMFc1YnhlcTNWT3FsK1pYVnd0bUVVeDFnckRn?=
 =?utf-8?B?UU11YjdXbU5yaTd4Nm5qeCt0c3NnTnI3Ung2RUo3UmFWTkJFY1FoM24vbXk5?=
 =?utf-8?B?NGRaTVNhc1IyZm15OG9UeVMrUFcyN3Fya2lMSUYvYVV3ZzNDTWtQcjdncnht?=
 =?utf-8?B?ZnlqVzdySWVxNmVnbU9Fc3JkbzJqamIwQmJJS3pLR1habDdGUHV6U3NyWnFP?=
 =?utf-8?B?T0QyK2V2enZpNDl6dzF5MXZQZW92SENyTzNoTEtZczRYOG8xVU5pTDRPZmg4?=
 =?utf-8?B?bHZBZkZ6UjVja0h5UldmN2hMNWVodjE5cHpUNi9MdHJBRmNXUUtSY3N6b1ZQ?=
 =?utf-8?B?NEdQelZCMThtM0VaTTJ0TWNtSHlvSkg2SXNITTUvTXFTTnZSUk9BUWRld3ZZ?=
 =?utf-8?B?NkJrRGsvOEZMMjNXb0pTRG4xZWxSN2VnQmhKVERXUjFZU0YzQ2JoRTVlZnBZ?=
 =?utf-8?B?ZU0xRWYyYitrYU1wQnlOeTlwOUJ1SFNpOW1NMno1T3RYelNkTmJ2YlBKRG1W?=
 =?utf-8?B?ZWFHRGVkVjdMZGwzbmFBckZZSzk5WnB1NnU3NEFsWGRUZGlKNnRzSUFzOXI5?=
 =?utf-8?B?RGlQcXU2WitLbEo1bWNsVk5BUnk0cXlVSW96NUtjZ2JCTmpmNHR0LzBURWt5?=
 =?utf-8?B?TldjN01oWnJUVW9GKzdKTjJ4ZDJzVnIwQ1k1cWFwL2NlNUxOOWxYYlM3aEU5?=
 =?utf-8?B?eERRWHFkSEoyM3JBTTVBUjVoQ09sMVRnY25hMmFVMjRDY3BmeEdheTVQOWl6?=
 =?utf-8?B?dVloRjYyRmRjVURpLzU1cDVtaEZ0MVVsN1IwWEo2ekZOQk14YUtQSUtwZi9D?=
 =?utf-8?B?WngxbUhodWpoTGU2WUNUQTlNQmNIa1VZd1FyMmxzUHUydVN6OWtjcy9Dc3NN?=
 =?utf-8?B?aU8vZTFvcE00WmFsNUg1TW92azhTZHBhaGs3Y0RXbTJTdVp6ekF5YzEzYW9J?=
 =?utf-8?B?QitDY250YnFST2taUWZ1WWdBcjRGdGl3ZzFKU2w5S29OeFNNaFBzOW0vakRv?=
 =?utf-8?B?anpqaGR0RzBta0Z5QXhkR1JmZWZEd0pLdE1GeER2eWx0MG1YWDIvY0MzNVEr?=
 =?utf-8?B?WkoyQmhrU3ZtRHd3Nk9lRmkvRktRckVpekt5WFc2empVcmY2SDQ5SlM0OW9F?=
 =?utf-8?B?M0plYnlyK09Jbi9pRVJPVEhJbjlvck5zbmcvTlNGSHJtS1dKQlNCRFM3VmpN?=
 =?utf-8?B?NDhuR2oxZ2JVVm1NN3ppT1IxNWwvelNlMlA1Wk9CdUVOVVFSdHF1M3Vub1NV?=
 =?utf-8?B?Skk5U3Rqdk0rSHhRT2hoaUVzSVlRbUdNQ1JQc3VlMklUQmtsZWNyekFXQm44?=
 =?utf-8?B?bU94RlI1UTRPZnlRdjM5UjZnR3FpM1V3TW9XSHVSdXhrZ2l0VjFVTGpSRjBw?=
 =?utf-8?B?d0hBcjNBYThDTFQzekRGdGpQQUQ2UU9ndTFuQWFzK0JWM2ZHSXdEZ1lhWjN3?=
 =?utf-8?B?ajRYa1dhWk9pYVM0NDkrbjR6aEIvYVdMNUNBVUVBMk44ZUdNUUh0eXRqdTh0?=
 =?utf-8?B?bGpnelZFVlRsb2hkMWhoSDFQRWxtU2ZSOHVtZlNVdEJlR1g1b3BmcWtLZEkw?=
 =?utf-8?B?VTJxRlJLY3ArbUVjaUUrZXQvWlh4aDJPeGg4eGZnTFZaM3dvaEE5WkU2dEJF?=
 =?utf-8?B?VGxrZDN1NkJvOTZoR2U5SkxLMmlRZFU2YWxWVGFSOWlhL2lWTHQwanFQbUEw?=
 =?utf-8?B?SE15bnVBa3RNbGhFcWVoR1d1K3MwNDB2aUNvbFJCNnhzcVJlWFFINmFkclJn?=
 =?utf-8?B?TzAwOGF5aW8yT0ZwTHRhaDJ1UWpaakYvd1BvUlBtYzg3VG10QUw0cUlOazV1?=
 =?utf-8?B?dXM5U2NBRi9qZG9tWm5OdzcwaXJDT0tacjlFQW4vRGxMK0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTUxdDlpci9CQ21rSzlEdHlWQXdQOGVyQm5MeGxuK2d3Sk40RldkUXMxck1h?=
 =?utf-8?B?TXpxanRsaGw4TXFTdllyZXhWd0I0QXFhRm44RUpQQlovOHFUMXltQnVsQVJZ?=
 =?utf-8?B?Z0JwTDRmK3JRbFBPNHVwTjFtbU1sMkYza2ROOE5QeUNoNTFjWTh6VzV6WWdm?=
 =?utf-8?B?dUkwTjc5RjBPcGpnZVNlcno0VnYxbS90L2E5SWZNWldYSHhyNER2UGR6SU5J?=
 =?utf-8?B?T1BsK20wYi9iTXlaRFp4c0h5Ung3Y2prZm1wT2FORC8vM1BTT0FXK2xlZXdF?=
 =?utf-8?B?aXZLZTRKcXhDRmd0UWE1L1dnN1dxMUJ5eVI4bXhaNGtBak0xSndadjJ2SUZp?=
 =?utf-8?B?bllKRUpjSzBEbkhSbnBhQW9vZHQ5NjJiUGwrWTdwMUUvOTQvTzMxN0FxOWor?=
 =?utf-8?B?eTFRaUVFTnBlbkt0Q1lyNWlST2xta2FLK3F0R01GZ0orbmcrVXZnOThxUkNW?=
 =?utf-8?B?SzNDTGR2MnU3T2Q4VmtMNk9rbTF0MEMrazhyU1RaS3dwajJ6TWd1RXFveHFt?=
 =?utf-8?B?cVlEVjNHMHpkYTJvWElNZlpveUZ5VDJ3Z01xSFE3c2hncVc1WGdEK0cxYmhC?=
 =?utf-8?B?NDlydDhheGZsNXRjeFhaS3VBR3RKNkJrV2lPbUZOVVgyZnJ0d003WmwwR1Rm?=
 =?utf-8?B?d2dGQ2I4OHNoRDJTU0c0TUd4K2NZL2VHbkt1WUxWdXdMTU5uRkQ4czBORTZs?=
 =?utf-8?B?Q2ZaWUliYkxzQUMxVnJvYjQ2S3UyK0ZoeEdHWGsxVUp2dk9TTEJ0UDN3a09B?=
 =?utf-8?B?UmhWK3hlM0JSSXJTbEdOWCszVFpFb1R0UjhJRTdtYVM5cmxEbkF0RDEvaG44?=
 =?utf-8?B?a3o2ME41Y1ZUY3VJb1p1OUR3QThwQkxVYTdzTnUyUmNlZG8wNzE2aEc0ZklI?=
 =?utf-8?B?ejFJeWNxOVVXa3dmZGFGNnBaMnAvaDBGWjNPZVJYYS9EdUFlUCt0S2czZ3FK?=
 =?utf-8?B?blBUbHdMTHBLS2l4bnVIRzV6bjlXQVd0MTFVRXlhMDBob0kzMWhHbUNqbk1v?=
 =?utf-8?B?QWpjV3dzVEZlQWxYaElIcklveDFrS0JOVlpQdXlxNmV3bmJCTkRWQjVGNUs0?=
 =?utf-8?B?R0hvSElXaGhzcHREQWloRGJOL2Y1ZWJVZS95UVhSQjlRUGNtbzR6dVJ2UDAy?=
 =?utf-8?B?M0p0YWZnQkVWYUMwYUZSVk1iL2lWbWdTbVFJblNIZlUvU3NzcWZiZXFqZGx5?=
 =?utf-8?B?ajBiMGU1UG51ZVpVWEpGbXFVSUVZQ0c5bHA4UE1qQU53S2ZjYlB5eDVwd2sr?=
 =?utf-8?B?OFVNdUxWbzhuK0Mydkp6K0ZaZ1NQdCt0ZCs4VHhrZnpXYVpTb09saVlZbk5R?=
 =?utf-8?B?QXBTdDFPaFNZM2hxMGJmLzBYeFBEL0tWeUhuREtZd0I1bk5ucFI2WE15STVP?=
 =?utf-8?B?YmRyMlFDM0hxWXNNcDhSZHJ6ZVR1RkNORFY4WlJYczRZaUtqWU4yd3g0RkZN?=
 =?utf-8?B?TGgra2FhTU8zUER1UXJKOGxiYU5zWEt6OXhjdG1naG56YVY3WlRHcHEyNG8r?=
 =?utf-8?B?OWJhdjFlMlhKWGhlOUR4ang0YUFjZmdFTkx4T1RsUTM5Mzc3QkVqTkVWT1V2?=
 =?utf-8?B?ZUk0K1prdG1xbk1vN04wbUZIWDZBQVpCRHYwaHkxTHZwRHBTZHFEcE45WGk4?=
 =?utf-8?B?dVJPNHRldlVxdnErRy9hNnpzTzNOMWZwUDd6cW9vNVp4QkluUCtIK3pobTYx?=
 =?utf-8?B?ZzRUT2dGbEJ6ZXJjdGloWjA0cnhTSWtrY1l5aDl4ZFY3M05MM2x4SnlscllH?=
 =?utf-8?B?bU1nMHovdDFSdS9VVkgzbXllbVM2UXRWRXFjb05ISVZnNlc4UzJVYU54WlBG?=
 =?utf-8?B?RGdpTXJXczlNQVpQWEU2dXpSWUozbkdEWUN1c240R05EK3ZlV0l4TEptaXlB?=
 =?utf-8?B?YTQyWk9UZUthNzM2bUhPNnZ6ak9YaTZ5bFhoYlg3RHBZSFpUWEw2eHcvWjJr?=
 =?utf-8?B?MWpMTHJnMFltcjhjaTBEQUtsaDdJeEpYSkhsVU1uNDhRMDM0WG9nY28zamh2?=
 =?utf-8?B?RUppc1lFTGpEcWtSVUFrUlR6QzBndnVOdy9PRTFNa0JEK3YyRm4xY0JqVjdF?=
 =?utf-8?B?K2JIRUJQdk5JcWQzbVRhM2RIWklLNUQ1Q09nUXRHTlhlQit6U0t5dHEwNDcy?=
 =?utf-8?B?TnhUUkZ1ZlhnWVlGKzQ4L2t6TWlaZzZTMmRkTCtqNDlrOXh6KzU0end3cVNY?=
 =?utf-8?Q?I3g8DBsYWV0dbhjCbrR4PgM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F297EA720518344AEA21A968EF93379@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131dca2e-f1d7-42a4-d2b8-08dcd22ab6a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 06:26:47.4415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: skbwacszWL/xb8vA5lnaIlxVPNgLAKbruTa9AQwx5LjKHk4Fr/6TKgouq6f1qz4zvLbPiwBI026Ufb6WQuIZa4aRierAv+mMiSmz52b3DT/gpYOXvzuXXJFJLaEeknfK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8653
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

DQoNCk9uIDExLzA5LzIwMjQgMDc6MjIsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPiBDYXV0aW9u
OiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3Ms
IHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+IEFkZCBhbiBuZXcgZWxlbWVudCBzY2FsYWJs
ZV9tb2RlIGluIEludGVsSU9NTVVTdGF0ZSB0byBtYXJrIHNjYWxhYmxlDQo+IG1vZGVybiBtb2Rl
LCB0aGlzIGVsZW1lbnQgd2lsbCBiZSBleHBvc2VkIGFzIGFuIGludGVsX2lvbW11IHByb3BlcnR5
DQo+IGZpbmFsbHkuDQo+DQo+IEZvciBub3csIGl0J3Mgb25seSBhIHBsYWNlaGhvbGRlciBhbmQg
dXNlZCBmb3IgYWRkcmVzcyB3aWR0aA0KPiBjb21wYXRpYmlsaXR5IGNoZWNrIGFuZCBibG9jayBo
b3N0IGRldmljZSBwYXNzdGhyb3VnaCB1bnRpbCBuZXN0aW5nDQo+IGlzIHN1cHBvcnRlZC4NCj4N
Cj4gU2lnbmVkLW9mZi1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+IC0tLQ0K
PiAgIGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oIHwgIDEgKw0KPiAgIGh3L2kzODYvaW50
ZWxfaW9tbXUuYyAgICAgICAgIHwgMjIgKysrKysrKysrKysrKysrKysrLS0tLQ0KPiAgIDIgZmls
ZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oIGIvaW5jbHVkZS9ody9pMzg2L2lu
dGVsX2lvbW11LmgNCj4gaW5kZXggMWViMDVjMjlmYy4uNzg4ZWQ0MjQ3NyAxMDA2NDQNCj4gLS0t
IGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4gKysrIGIvaW5jbHVkZS9ody9pMzg2
L2ludGVsX2lvbW11LmgNCj4gQEAgLTI2Miw2ICsyNjIsNyBAQCBzdHJ1Y3QgSW50ZWxJT01NVVN0
YXRlIHsNCj4NCj4gICAgICAgYm9vbCBjYWNoaW5nX21vZGU7ICAgICAgICAgICAgICAvKiBSTyAt
IGlzIGNhcCBDTSBlbmFibGVkPyAqLw0KPiAgICAgICBib29sIHNjYWxhYmxlX21vZGU7ICAgICAg
ICAgICAgIC8qIFJPIC0gaXMgU2NhbGFibGUgTW9kZSBzdXBwb3J0ZWQ/ICovDQo+ICsgICAgYm9v
bCBzY2FsYWJsZV9tb2Rlcm47ICAgICAgICAgICAvKiBSTyAtIGlzIG1vZGVybiBTTSBzdXBwb3J0
ZWQ/ICovDQo+ICAgICAgIGJvb2wgc25vb3BfY29udHJvbDsgICAgICAgICAgICAgLyogUk8gLSBp
cyBTTlAgZmlsZWQgc3VwcG9ydGVkPyAqLw0KPg0KPiAgICAgICBkbWFfYWRkcl90IHJvb3Q7ICAg
ICAgICAgICAgICAgIC8qIEN1cnJlbnQgcm9vdCB0YWJsZSBwb2ludGVyICovDQo+IGRpZmYgLS1n
aXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gaW5k
ZXggZTM0NjVmYzI3ZC4uNTdjMjRmNjdiNCAxMDA2NDQNCj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jDQo+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiBAQCAtMzg3Miw3ICszODcy
LDEzIEBAIHN0YXRpYyBib29sIHZ0ZF9jaGVja19oaW9kKEludGVsSU9NTVVTdGF0ZSAqcywgSG9z
dElPTU1VRGV2aWNlICpoaW9kLA0KPiAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAgICAgICB9
DQo+DQo+IC0gICAgcmV0dXJuIHRydWU7DQo+ICsgICAgaWYgKCFzLT5zY2FsYWJsZV9tb2Rlcm4p
IHsNCj4gKyAgICAgICAgLyogQWxsIGNoZWNrcyByZXF1ZXN0ZWQgYnkgVlREIG5vbi1tb2Rlcm4g
bW9kZSBwYXNzICovDQo+ICsgICAgICAgIHJldHVybiB0cnVlOw0KPiArICAgIH0NCj4gKw0KPiAr
ICAgIGVycm9yX3NldGcoZXJycCwgImhvc3QgZGV2aWNlIGlzIHVuc3VwcG9ydGVkIGluIHNjYWxh
YmxlIG1vZGVybiBtb2RlIHlldCIpOw0KPiArICAgIHJldHVybiBmYWxzZTsNCj4gICB9DQo+DQo+
ICAgc3RhdGljIGJvb2wgdnRkX2Rldl9zZXRfaW9tbXVfZGV2aWNlKFBDSUJ1cyAqYnVzLCB2b2lk
ICpvcGFxdWUsIGludCBkZXZmbiwNCj4gQEAgLTQyNjIsMTQgKzQyNjgsMjIgQEAgc3RhdGljIGJv
b2wgdnRkX2RlY2lkZV9jb25maWcoSW50ZWxJT01NVVN0YXRlICpzLCBFcnJvciAqKmVycnApDQo+
ICAgICAgICAgICB9DQo+ICAgICAgIH0NCj4NCj4gLSAgICAvKiBDdXJyZW50bHkgb25seSBhZGRy
ZXNzIHdpZHRocyBzdXBwb3J0ZWQgYXJlIDM5IGFuZCA0OCBiaXRzICovDQo+ICAgICAgIGlmICgo
cy0+YXdfYml0cyAhPSBWVERfSE9TVF9BV18zOUJJVCkgJiYNCj4gLSAgICAgICAgKHMtPmF3X2Jp
dHMgIT0gVlREX0hPU1RfQVdfNDhCSVQpKSB7DQo+IC0gICAgICAgIGVycm9yX3NldGcoZXJycCwg
IlN1cHBvcnRlZCB2YWx1ZXMgZm9yIGF3LWJpdHMgYXJlOiAlZCwgJWQiLA0KPiArICAgICAgICAo
cy0+YXdfYml0cyAhPSBWVERfSE9TVF9BV180OEJJVCkgJiYNCj4gKyAgICAgICAgIXMtPnNjYWxh
YmxlX21vZGVybikgew0KPiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICIlcyBtb2RlOiBzdXBw
b3J0ZWQgdmFsdWVzIGZvciBhdy1iaXRzIGFyZTogJWQsICVkIiwNCj4gKyAgICAgICAgICAgICAg
ICAgICBzLT5zY2FsYWJsZV9tb2RlID8gIlNjYWxhYmxlIGxlZ2FjeSIgOiAiTGVnYWN5IiwNCkkg
dGhpbmsgd2Ugc2hvdWxkIGJlIGNvbnNpc3RlbnQgaW4gdGhlIHdheSB3ZSBuYW1lIHRoaW5ncy4N
CnMvU2NhbGFibGUgbGVnYWN5L1NjYWxhYmxlDQo+ICAgICAgICAgICAgICAgICAgICAgIFZURF9I
T1NUX0FXXzM5QklULCBWVERfSE9TVF9BV180OEJJVCk7DQo+ICAgICAgICAgICByZXR1cm4gZmFs
c2U7DQo+ICAgICAgIH0NCj4NCj4gKyAgICBpZiAoKHMtPmF3X2JpdHMgIT0gVlREX0hPU1RfQVdf
NDhCSVQpICYmIHMtPnNjYWxhYmxlX21vZGVybikgew0KPiArICAgICAgICBlcnJvcl9zZXRnKGVy
cnAsDQo+ICsgICAgICAgICAgICAgICAgICAgIlNjYWxhYmxlIG1vZGVybiBtb2RlOiBzdXBwb3J0
ZWQgdmFsdWVzIGZvciBhdy1iaXRzIGlzOiAlZCIsDQo+ICsgICAgICAgICAgICAgICAgICAgVlRE
X0hPU1RfQVdfNDhCSVQpOw0KPiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+ICsgICAgfQ0KPiAr
DQpJbiBib3RoIGNvbmRpdGlvbnMsIEkgd291bGQgcmF0aGVyIHRlc3QgdGhlIG1vZGUgZmlyc3Qg
dG8gbWFrZSB0aGUgDQppbnRlbnRpb24gY2xlYXJlci4NCkZvciBpbnN0YW5jZSwNCg0KKHMtPmF3
X2JpdHMgIT0gVlREX0hPU1RfQVdfNDhCSVQpICYmIHMtPnNjYWxhYmxlX21vZGVybg0KDQp3b3Vs
ZCBiZWNvbWUNCg0Kcy0+c2NhbGFibGVfbW9kZXJuICYmIChzLT5hd19iaXRzICE9IFZURF9IT1NU
X0FXXzQ4QklUKQ0KDQpBcGFydCBmcm9tIHRoZXNlIG1pbm9yIGNvbW1lbnRzLCB0aGUgcGF0Y2gg
bG9va3MgZ29vZCB0byBtZQ0KDQo+ICAgICAgIGlmIChzLT5zY2FsYWJsZV9tb2RlICYmICFzLT5k
bWFfZHJhaW4pIHsNCj4gICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgIk5lZWQgdG8gc2V0IGRt
YV9kcmFpbiBmb3Igc2NhbGFibGUgbW9kZSIpOw0KPiAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0K
PiAtLQ0KPiAyLjM0LjENCj4NCg==

