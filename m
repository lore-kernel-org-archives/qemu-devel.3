Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E1AC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 00:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUbgb-0004IT-W3; Thu, 18 Jul 2024 20:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sUbgY-0004HN-7X
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 20:41:22 -0400
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sUbgU-0000QA-Hx
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 20:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1721349678; x=1752885678;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ugWVQKMFR30FVfvQuEKZn8ZVXhy7OdTVV9m4AzYIIVM=;
 b=T3lxoEUoKA70FQJkeJoEfP8p72ry8k1JLzlp8sWCI0QOGk//ndc6Hr7w
 jPAshLkTH4lQf40LslzJm2gF9Nv0JgfDBjzh/tsMwUPlOowb+Y3XDrLdl
 2jBsbRUGoNnlFA58QoRkhiz/elLxdPzxlKB6ot+UP6D1tosuEq/9UKU45
 kBhR2OfauuajV/gdNWUVfumcBDXNvYYRSDGJHnKaA8fDDHKolsJBsdAoI
 N4CllusylVAqhQO1GkYK2waLHSUUH7cYTF5TNkLYcHfe9P2wjN0abz8Wq
 y/ymEIs15KxnYwii8LYi1XTVDZc7zUk30FIPQAontg5abiOtGh/bPQVSZ w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="36764163"
X-IronPort-AV: E=Sophos;i="6.09,219,1716217200"; d="scan'208";a="36764163"
Received: from mail-japanwestazlp17010003.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.3])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2024 09:41:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yW4MkcFmFZochSm0qR1Cn+oWqwRHvJmEuv/++rJzUBs5aaG2YJblxcn+BQT1rJL6pccJuC37syDIUaVp99KXIPb2TSvaNZqXveER0d3cpCfBSaJ+rSWNwM8kK67hM+uU5hFrJMYxYAW9yDrgm+s1fvgPIKPTP6By3bjS33QZuBNr4sFkb75c41gh94BfNtbUCFFTgtDu2uzZBD/D9DY0zRruwm65CVzjqBVdncjBPVtqfpddVkJGR7HassodFNollO73bUpjtJii8z6qPgLubWaN2eVMmNXtCZ/Qo0/0vAG22pDkk77HVy25I5UOohkWVRdnLutCnzZnlyQ32FeP/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugWVQKMFR30FVfvQuEKZn8ZVXhy7OdTVV9m4AzYIIVM=;
 b=czYdMyQ5XJS9GqLj5xtpdDtheJd1/HQ7a5IGanstNK5tdslAXqz1vuyfoG83VUa0bD3OIMf+21wdqxhl3v+gdU6xm9JsYdT9J2k9+cSTuCAU/v9gjkuao5CPG0WzupA0ArUr+1XVILxeC2a/ec25OvyGuhAA23szDoBRPRsWF51u+3gnlNudR0HAunVLEpaq0Ix79BKY53cnkXrYcugxrqiVyNtiz/yCuLFTHI67IHrOeDwG53bzpGWC2PaOjSsbgeWcfrE0i4CIFaVNRAft5cFFcb6lG5GDEqdVYcbTkLvtoH6X9gnHl8WItIOzZvRmfSapGtH5rmimgB/0myIbnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by OS3PR01MB5800.jpnprd01.prod.outlook.com (2603:1096:604:b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Fri, 19 Jul
 2024 00:41:10 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%4]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 00:41:09 +0000
To: Fan Ni <fan.ni@samsung.com>
CC: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] mem/cxl_type3: Fix overlapping region validation error
Thread-Topic: [PATCH] mem/cxl_type3: Fix overlapping region validation error
Thread-Index: AQHa2PH/d/XLGCPGR0Wjd/3IZU/pELH8v3cAgAB1/qA=
Date: Fri, 19 Jul 2024 00:41:09 +0000
Message-ID: <OSZPR01MB6453775C6EA23CAE6F63C6FD8DAD2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <CGME20240718090810uscas1p17441e84b4594875648bf24e07549166f@uscas1p1.samsung.com>
 <20240718090753.59163-1-yaoxt.fnst@fujitsu.com>
 <20240718173356.GA1629099@sjcvldevvm72>
In-Reply-To: <20240718173356.GA1629099@sjcvldevvm72>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9MjE4MzdlYzctMGViMi00NDExLTlkNDAtZDk3MTg5NmE4?=
 =?utf-8?B?MjFjO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA3LTE5VDAwOjM2OjI3WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|OS3PR01MB5800:EE_
x-ms-office365-filtering-correlation-id: 2d4d2295-3527-44be-853a-08dca78b7bac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?dWpKN2pFb05JcWlBQkx5em5DS2lkVzFQVFNnNE5zVUpFKzVKaDQrOGI1TlhG?=
 =?utf-8?B?YkpGdFZGTnNjWFBIc2JZRktXNEFoVS8xbnMyV0svc2dIM2JhWnpuTExZcUFV?=
 =?utf-8?B?QnpVV2krU3N6SXMvTXV1UjlJV1JqOC9mVGxuMXZzVUpxZFl2dEFEV05vTC81?=
 =?utf-8?B?RUE4cmdtbUpUcmVsSXBJWWJQbjM4RW9GV1dleXZtS0hPcnlCdk1VcjRVRE5B?=
 =?utf-8?B?eS9IbkJFSGRRQ0FZT1lCOVVCdDdmNnlja0syYjRNQW1KemRqdW5ZQlNuQlJH?=
 =?utf-8?B?d24yZmV1RWRhck12TEx2dmRsdUx6Vy92b09Pc2w1N0dFOG91NkpRRzVXWWFW?=
 =?utf-8?B?M0U3VUZwMlBGV3FDT0FsQXZHNmlpMFd1TUtkcjF5SUdTdUx3S1d6Y2EyQ2Ji?=
 =?utf-8?B?enZaNGFBc3JsY1UxaWNid1Ezb2FuZHA1a0ZtKy9xL0ZudDBvUTZ6bmxqQ0l1?=
 =?utf-8?B?QU1YRXQzalFNaW5QdGFkMUpHVGhMcW12ZFJIMjZOaGd0SnlHNVdMYXphang5?=
 =?utf-8?B?TGdkbVp6SitWVlJ6MVlIQnc4M21OUXY5WHdiT3JBZElSNmF1OTN3YXNPSjlk?=
 =?utf-8?B?MmlRLzMvcGZ0RWROMEZJU3hTV2tNOHRiaDl5QURXTmo0THN6OXY3am9TQjZ1?=
 =?utf-8?B?MUpHMkltM3RwellCM1lkMm1vc2RZd2JtRjU3VDE4cXNzb2JRd29lVVVwc2pK?=
 =?utf-8?B?bC85WjR5ZFZHZGxOOG8ycEx1TjBobU1hTElTZjUyaE5JWUFXdjEzUlI2cUUw?=
 =?utf-8?B?SW4vS2VrdlJvZDkvM055OWJQTVlMVXF5dzdmenRyUzZISW5kRm1zaGZPZXlF?=
 =?utf-8?B?VWw2dkdIQlkzcmpOV2E4Ym92KzNMSm15T2o2bkFObzljbXI5UnU5QjBUUFVH?=
 =?utf-8?B?R1JXQWloallJc0ltakw1Ry9hUWg5QlM1Ylpib3hBTmdRTDJOckpCZXIwN0Qr?=
 =?utf-8?B?RHpaMEkveHdTTitPTDFub0lJUzgxQnQ1OHBjcjNJNUdsUjZ3QnV2QmVMaGRh?=
 =?utf-8?B?OU5xdDBEaUtGMW1maTR2TUxTN3YwTDZMeVFUSnNtVDFwWEc3aHJhT0RtNHJv?=
 =?utf-8?B?RmtFTEVHZFFUWG4rMG1CL0pLWGtuMFhMeHR0VlRJd3J1UmhZdnpwUHF4VkZx?=
 =?utf-8?B?ZmlxTGs0bkx2NkVEUzVTUGtibjYzb3RKS1hxeXVmZ0FRS0tTSHU2WmtYRjVI?=
 =?utf-8?B?WU1jZDQrQytZL0FjcXpuOWZ3K3VFVUd0ejF4ZExMRys0akEyWUR1YVhhZU1Q?=
 =?utf-8?B?MWxSZUZzZDdzSDBGV0pRSlFNcHczdjJhY0Q0NGFlbXNqVzNOUk9DY1N2R1Rk?=
 =?utf-8?B?dUs0d2xpOTF5OUd2NGpGQWdvbkdrZjJMNG1SWGQ2dFZla2ttK2RHL2F2Uklv?=
 =?utf-8?B?aHNsUDFQQTlTWXFRSEcvK1ZReXlPZ1d5aVVsVkNUL1AzWjg1VmFIUk43NG8w?=
 =?utf-8?B?Q2lzUGRUOHhEdFhCa3dCMjlzZjFPTHZPUTAwK242bTNPZit1QUUwTVc1WUYv?=
 =?utf-8?B?OWZGdDl3MGpTbmZNZ01mVDI3MFF1bkpHZ0QrS2Z1QUVWYVB0OE10YndjcGJk?=
 =?utf-8?B?ZUlsQUpTTE8rSGduemZwaDRoV1J3OUJiaTgrLzMwd2E5Z05FdU92ekFHejk2?=
 =?utf-8?B?cGtIWWpQUU94Y0toMGdxSnhlZVNpM1FBZkJHQnE2cmo2WS8xT0toaG10TWtQ?=
 =?utf-8?B?YkdoSERCODJ0Z0srbDVIdnEwa1A5eW1EZU9IMkM4YmEvb0FCQjRJRUFWUzln?=
 =?utf-8?B?aC9iNlpGWFV0dG9ueW82dU1XclpDaFlvOTZYbXlJR05DQlZTdU16dGxWbjVF?=
 =?utf-8?B?cE1VRHV2ekwrSzh6UHVkTlE1RkU2ZERxMDNjYmFwODJTUDZaeGp1Ykowa3R5?=
 =?utf-8?B?M0dYVHd1STJISGRsY05aamd4a2ZZVTdsSzNHSkJqSCsvQWoveU1PT3N5ZjJS?=
 =?utf-8?Q?O/lt9jRrx5U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0JlZ3QxNjQ3anpPY2FXWGV3UWFWeGl6VkxXNm5vS0FDZmNhZWZBVFo4dWto?=
 =?utf-8?B?U3p5N0tHa0JyNHBrc1NHbUhBOWY5NGdoeUx3eEU2MGdXczJCWjJHQUZOaThP?=
 =?utf-8?B?RjlBZHZ0Q0ZKYzlWVVRUQndjbHZwa2ZXQkZ1elM1KzRCbjl2Q0p4Wm5zUEMz?=
 =?utf-8?B?VlZQY3hvY3JBTHdlTlpLVGZZczM1QlFaV2tGNFgxODErYkFyMXcydEVFZUE3?=
 =?utf-8?B?MG40N3E0NER1ckR0c21uUmQxVTE2b1hyYjk5OElvUkR1alpMVmhleWR0UjFJ?=
 =?utf-8?B?R1QvOWJmQ3JjUGU5YnREYVY1WVE4bzNnck5ZSlhjaEFKakk1R3lIUk81WFhx?=
 =?utf-8?B?YXpVd0ZpWVQ0aW5HY0NROGtZMXo0MUUyMnpxT1NrNkZmdWdyMW1HS284cHhP?=
 =?utf-8?B?ZXpZNk52UXNIMFpXWnhRWWFEeWNoVTJYQ3pjRWVTcXJPVjh5YVBlNmpFUG5T?=
 =?utf-8?B?SGVZSUw0NVhRY29JdzdaanBNdzFJNnVDMDhZN0VkTzhLNmdTM0ZvcXl5SWRn?=
 =?utf-8?B?R3dLK0R4dlVhQ3hWSG11b2FFb0JLN3VUbDAyajRNdnd6M1BQLzh3Znpuazd1?=
 =?utf-8?B?N1I1bjF4cnAxUHZ5MlpuRUppM1hjcVExcW9qSmJGUnRqRnRVU2JGaGpUMFBT?=
 =?utf-8?B?RENCbTNPa1VBSWlTS3RJOGIvcTJPRVBYVGx2N3VKZXpPUFU3UXZHZTdDMCt6?=
 =?utf-8?B?VmN4emZGdlVJZFJIZFJtZUUvbDZEMnlVSmVqZ1RyZlVBaVpIWnpFUzZISUhp?=
 =?utf-8?B?clptMUpoSUZENGpPWXczWStrK2cweGkrQjR1ODBnTDNqa0FNSHN6a25GYXVV?=
 =?utf-8?B?aHUvM0FjMlJDSVVRS3gvWTFmVDg1bkJxQXJSTnRqT1JQSzRzTjRLb3gvc0Nu?=
 =?utf-8?B?SzNhbTdFRVJkOUNmZ2pxQXlDNTZMbDFBakRmWHJUczdXRXZWUTMxZ1Q2MHdI?=
 =?utf-8?B?VTNjK3crMHJ4Q2JUdjlDeFBFWGRrYkRNYmFQR3VwZm00Q3NqQWovL0dGdjEr?=
 =?utf-8?B?aVBFdWlFUE1pd1NuMEhaZ2JxaS8zT0JkZ3VGbCtHMUxkYW01bHVpTjJUWFhC?=
 =?utf-8?B?a3JHZEJ4NERXNm9idEppVUZVVDRRRkkzeXhrNnpJU0FuenJmRXlud0pacEZi?=
 =?utf-8?B?TzR1VDlmRndzVkwvbGlQeEtseVEvSVdadFRYVWw5OEVzU0Z3Q281NXgwdmZv?=
 =?utf-8?B?aGF3WHZjbzRQRlpVVTdLRGlUM0N3SWJIMzZQM0dKS1lCbDV1VHJmK3l2QlMy?=
 =?utf-8?B?MkwzWmQ5QjArdnREY1cvQ2dqQ2lzdURub3VyRUo1MTdDSi9hVE5nYUxDKzFB?=
 =?utf-8?B?YjVDSmcvQXR4cDMyK3BXTTNEZTg2YXQyalVIQUVFdmhicjBEbWpVYlRtSG5i?=
 =?utf-8?B?UFJaWUVUdTc5aW5WSzhsRDdreFFiTUx0Tzl6VUlnbkNoSlZpRDFOZ1lSSWZx?=
 =?utf-8?B?VGk3VGwycWZFY0Z0eEhiQzdIMWNIM0pubFc5RndDbFBYUk1NZ3dCanZyQWxL?=
 =?utf-8?B?RXFnWWtGMlRGRUl3aFJ2OGdoK0ZjSW9RS3dqZFZvZ2RZUFlCUkJNa2hSaVJL?=
 =?utf-8?B?UzBadGthSUhSRnQ5Tm1GZWYxZ3U5S3luSE9NL2xPeUhTVnFlRm5QZUZiaHdL?=
 =?utf-8?B?Z3ZXVVFWb1kwZ0J1aVA0bmtqbHlMV2o2ZXBndzRES0lVOFVOU2RYbUNhVVFp?=
 =?utf-8?B?Ym5QTDdiN2h6UlhSMm5VejR1VjFqcjlZMDRBekNBWC9BOGxBWDBuWjNzT2lI?=
 =?utf-8?B?enQ2UU1KQzEycFZSZURDMnhvc2VRY3hnc00wcElHRytKTWRUQnc2cDBlSTNF?=
 =?utf-8?B?dnZKVW9GVTFaQ3hFTWk3ekk4UDN4cmttZ25Nc29GSTBQSjMyd0FDbmZJQ05r?=
 =?utf-8?B?M25QWS9XK2lYYkZ4U0RVZEZXSXRJRmpqMjlMS0U2UjlYWmN3MUZZeE9tWnM4?=
 =?utf-8?B?Ym1tMWp5bU9OaVkxOEVHOFI2YXA0Z0l4bTdhNXc1QU9NazBONHQ0UVpraENB?=
 =?utf-8?B?NDhiUDl6Z0VrSjBGZlhnbThBMEl2WGdVbnJLSldJcXNYUXROd3VacGNPdmps?=
 =?utf-8?B?RmN0NExzOVo4OEVncWxOWDZyWis0VWNzUU42aHJweGNxK0t2MklHYksrMUM5?=
 =?utf-8?Q?kW4o9+NuHovumjDXhl1mUMDHs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AGk7Am2U4q1l4uVz7JttcojjWPOmV+U8TL/7gw79s+A11D3ZzhlgOPKah76TW+1JmQTb4g1pX9SOU89r2gvyPNABDzAaKWc+teTpKgBpoD+nHEfsgkKdiZMIvs3txjdtX3cliUhVdcIQSdMtpNgcGbHql46YqfSojhTw3wj6XBcKQeKYqoQH4sRc1kNk9uHL1M90wz9xaSoR46ShHdT6j/TnJuxm+cb3mw+YJiCimF6t3Jk1K144fdAsuRPKNaRsy58ie/YHn6YM+9tSiPpEHONaj136Uww8wg+HEGlAHir6IPouCpPc3SJIWDGESqbn6Y8K/mpqD4+SvX1rYjF3VSGOTVgh9LCq1zz8aisysYJPeYAlfiX5+n45zQvzmWOLoJ8F6tVN7jwt8PRQ11mSF/UMmFw5kQV5G+szINIVy2BfFjdHA5MMECGYkywvZr5oh0nNuQjh4uksuAFWvq0B3iSd5qMonkG/TqOZ8yIZR6i6irqe4mX36eMVs/rAFjzO1L2atLhGWT5km52H68ZtlQUKasGO+jHDHRfa3wN+ezW+YOsaaRt77d9NkbuD3dKVwKSHxvaAF4vnovmHjwB3B5c6hlX/jqulXHDh0RacgpzEw+M5EyvI4ctHrWve9gQf
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4d2295-3527-44be-853a-08dca78b7bac
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 00:41:09.6333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +wN/i6h5G67oJfSbaZJdDgEoknB7TKazowSUQ+46h/3jRLSjq1n9Cds1tpNx6Cch92wvzBsdbP+fOnaeq42z5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5800
Received-SPF: pass client-ip=68.232.151.212;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa3.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

PiANCj4gDQo+IEFzIG1lbnRpb25lZCBieSBQZXRlciwgd2UgY2FuIHVzZSByYW5nZXNfb3Zlcmxh
cCgpIHRvIGltcHJvdmUgdGhlDQo+IGNvZGUgcmVhZGFiaWxpdHkuIE90aGVyIHRoYW4gdGhhdCwg
bG9va3MgZ29vZCB0IG1lLg0KPiANCj4gYnR3LCBub3Qgc3VyZSBvbmx5IG1lIG9yIG5vdCwgYnV0
IHRoZSBtZXNzYWdlIGRvZXMgbm90IGRpc3BsYXkNCj4gY29ycmVjdGx5IGluIG11dHQsIHNlZW1z
IG5vdCBhIHBsYWluIHRleHQgbWVzc2FnZSwgYnV0IGxvb2tzIGZpbmUgaW4NCj4gb3V0bG9vay4N
CkkgYW0gbm90IHN1cmUgYXMgd2VsbCwgYnV0IGl0IHNob3dzIHByb3Blcmx5IG9uIHRoZSBtYWls
aW5nIGxpc3QuIA0KPiANCj4gRmFuDQo=

