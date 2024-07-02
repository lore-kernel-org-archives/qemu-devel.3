Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE402C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOWRo-00084K-7r; Tue, 02 Jul 2024 01:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRe-00080a-Mq
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:50 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRc-0006b9-Cb
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719899568; x=1751435568;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=uURpO697BJoj6AGiwIj7FDv0GD3NcoC+arT0L1cxEHg=;
 b=nnzZqchFsscFnvrRhrj80P5maoJwsvoEXuiZordrv/ZsnuuBuXz2jxML
 pgWIIvE+x4RnJxfTgq0uisdwzQiFvkDbfZB4rzovmyqrlw1NS+mc6WNQC
 BZyEgj3r7/aviVDQp+wN6i+fhg+HbnG7/i9Fos9pJgvmieZ89QlxKxqGq
 t2DL/YsIsLZptgeBBIBBWu8NIzYR5XgED/p4J1kpPngzx6QU5M8wOuypS
 An1ILutANL+BA4g4y30yN1r47shvhOGbjeZXi8fTmaRDnHmrPhr8NMX7U
 xDlBg+4cdbql5TYZ350ylJfPMZqXWqD/WoRilpoNpbyb/Fw+mY0W+nTNw w==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15721602"
X-MGA-submission: =?us-ascii?q?MDF5T5rs6JXIApWHkNP8w+Y9fcB4KmelyVPoLk?=
 =?us-ascii?q?1bLPG5Ez6TzI4ZVmkhNJK8fQyWOq7ejF/3x88FvQ4M+grQpPMYlwzQt8?=
 =?us-ascii?q?9MavadkrhtIvGvMek3poozHTRtwTtmqzxKS/balpGUmITTAsYt9Te9bp?=
 =?us-ascii?q?aecgLqo8wm/VgT/2Z5GRvMmw=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 07:52:47 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcRSPq+IQq4y0OvyPgIJHH+7PXWJSNOEEAliyPTYg2Djb389Hvy4nsBfmweDTGcGR9/XvgrX9qotx8pNp5RtQc1/VxnXpGFZvJ/+YP2dqbXj6UUjnlxXhogvYsgjZmUgOTns8pUcK2zEB8U65QVwEfzZbf3B8g76yITs0R4LsDhOd0yUKebMp0o39vdHVtV6LW4qCBlE9DX6lbCPLqU/md6LWRjPYmoME1aOoAtg0Wzzy+2IIbGQVe16Zy5s8E7nUu4C4RU4WGECYK6Kut6GS4yCk5MTOcEzLWSFXttjH8gP7bOIrmfcr/1GA5BvTiBeNd8ZIBP1R39n9Eg5v66Jqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uURpO697BJoj6AGiwIj7FDv0GD3NcoC+arT0L1cxEHg=;
 b=CxX1u6VMsZMuKhDe0P5S4iUHx8UoNsO5Kwu18Q+cPrNfW9rY1jolkrFgVa4ObIXX43DuErItVnJjGg7RcCv6uCZWDhO29O1CysgUzNec6QgKCI0ghji6vFs1QtB/XPJRjuDhJj9h8Oz0e5omgOsuSlBxw5/GvRC6psBLoJdCUcWRSlrL3d+PBBLuk5sDszH8AjsmbYBlTmk3adlczj5vl779Ryilor/rZQgBIzd8bNMl5KQtQAVzds5OEW0Uvv52dsNrh2Uux/vovUB47Ztssx4oKB+iysgUhx7tqO5RVt8rHnyqgU3Gx/lkFFFgqJwMDGhqOcRmg2CRyglHTNnGOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uURpO697BJoj6AGiwIj7FDv0GD3NcoC+arT0L1cxEHg=;
 b=gjo85wzfp07PAHmFkBYJu3Fo+UchodubMQmgn+DNy+DD3rLQFhr065ShltrM0xal+z7m00PizfkL5iWTCTkjEGnlrrJb4Jnad40NUrcVJEw54AUlhQWPmu0wwLh1ntf93SPsAAWmoHnLGLRiutzGfCLeEvU7xyAofedvqdTjcT2o2zsRL9VQMd8z/edjyQqrrlF/L2Ki1KVV7ps2Zo4B7G1HUkNXMNI7nZcYKZu33sX0YmOC04PG1B2yncVV+sQvAPXX3uRn/v2LI1cYbp79giAt5Bh76eLx/IYioTZ6a1ASTyL0urASnjIrBpDo4XKG1Gc5ZegBPrnhoDQBV5wPQw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM7PR07MB6215.eurprd07.prod.outlook.com (2603:10a6:20b:13d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.21; Tue, 2 Jul
 2024 05:52:44 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 05:52:44 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 19/22] memory: add an API for ATS support
Thread-Topic: [PATCH ats_vtd v5 19/22] memory: add an API for ATS support
Thread-Index: AQHazEQPuEYX/3NIkkWJkupwBDAHeg==
Date: Tue, 2 Jul 2024 05:52:44 +0000
Message-ID: <20240702055221.1337035-20-clement.mathieu--drif@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM7PR07MB6215:EE_
x-ms-office365-filtering-correlation-id: e16c1f1f-f0ea-4c17-d229-08dc9a5b31b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?THFwNUJEb0hmSjB1Z0l2R2s5RWtkY0N5ZmNhYmlXVGJySzh0VUtNdXhkR2o2?=
 =?utf-8?B?aXkvNVYzT3RxY2lDQ2lWb0xiaVpFbWFORFVRTTlkWnJUSEUrWUs1QzFtRTJM?=
 =?utf-8?B?cWJ4U3NrUzdrMzFiQVRvNG5ob1lnUDQzQnNWSDFZbWF0c1FheW9lbm1zWnFk?=
 =?utf-8?B?TVN6eVJoY0pGMlJPZkFsT05UcmJUT1F4TmhneHE3eGRuSWlXNXhSMmlDYTBJ?=
 =?utf-8?B?RkpTYmt4RWRwM1V5V2JRYXdLYmpLS0ZzU3JHS0xCZ0I3RFBTQkFwMU1DYXY0?=
 =?utf-8?B?ZTBJdzdsT1RjSTMxSUZ4RlNELzVHdzVCN1RHZnd5NytzcEMxZUJNUEdTbWNa?=
 =?utf-8?B?Vk43KzNmSWhpdU9IS2NpVldZQ0pYMlJNYm5rRzkvaUQ2MFhCNzNGd3M0K3RM?=
 =?utf-8?B?UEIyS1Y3dVI0TlREajdMaElJS3U5QkpuNEhuM2F1bUFlQ0hvU2E2TUlMNUFt?=
 =?utf-8?B?QjZoSkdJaVBZbEcyZEN6dXVORmRmWXhxTXk1S2p5QVZJL1E0ZDNQWkYxR1gv?=
 =?utf-8?B?bWVEVk5ZdnVLOWpoeG9qOWRJc25WckpWdGRGbDg5MEJENG4yQzdTQjZabnlh?=
 =?utf-8?B?VVBpNHlWMVl0Z0lmY1ExaUV6RnB5cEVJY1lqWFNyL3A0eThuM09KS2d0dGJ4?=
 =?utf-8?B?dHNEdHRqRWYybDNXUDZhYmJCaTdhZTVUallTbmcrdm95SUhsRnhoM3U1eDRX?=
 =?utf-8?B?ZUZRUHFsQ2Jhc1pWMTVJY2RLTW0rSUtRMUl5ZFJrandkb3dpei9WTnF3YXM3?=
 =?utf-8?B?R1FjWjc4eVBDN29nZzJ5NWMrcnlDclNoc2lBZDd6UkU3ejc2L0ZGZmVHblhN?=
 =?utf-8?B?aTlnYnk5dmh4V0ZGY0JjUld4UjVSdzRWbjkrQVM2Sm5UQWowQ3AvbXBmQmFt?=
 =?utf-8?B?UHlIMG9GMjJnSkg5ZXNGa2cwaXloME82aDhNZGVHOFJJWDlzUVVZcG9mMEN1?=
 =?utf-8?B?NHJwUHVkMlBYTWgwc1V1a01xcDZTSkpOUEZVWTUyMHZEeWt0N3p4SFRObTcx?=
 =?utf-8?B?NExaZ1p5aXdXUGN0UUhvalRHWERQUzRLVWtuc1g1eXk0SWIrMmI5cExmYUV5?=
 =?utf-8?B?NWFBMU9pNUdJVnZ3T3JTcTNVSmVSRkp6K0w0WEg4UEJmUnFHK09Id2MxMWpO?=
 =?utf-8?B?TllGd0paU1BFUFZsdTRPS015bmI1dzd6d3pvWTNZVFZqelkyMGpjMTJ5c28y?=
 =?utf-8?B?N1lDRTFmclpBbGJTejRDY1UxL3F0UU5jT0JyQkt4UzVyclhNYzFmeVhQbDho?=
 =?utf-8?B?ZFBPMWl4YnpTZUdrUXBZdmVTdTh0S2hBYkJnaHR6STFYd015RmtEUDZMZ2Zj?=
 =?utf-8?B?UG5qdEhHeU1MRXpiL3ZqbTAzZjNBU05xUUEzdnFIL2huY1NNN2MwSUlpYkpl?=
 =?utf-8?B?Z0d2YnNPRUNCUzJtb0grakZ2NmhEb21kY3VDN1ZDdnJvcW14REhlc09ZSDUx?=
 =?utf-8?B?YUFRMEs2ZXhTamNmSHBuak5LQXF1dXBYQktuczh3RVJXL0h1RW9GaEVNTTE3?=
 =?utf-8?B?eTBUSTZBSlNFdlFOTWJWYitWTTVxYUdQNk5lajhuZGpIVXRMK0xWMWI1WlZu?=
 =?utf-8?B?Q0JiWGhSc1cvWE9Kdzk3SnFGdU4xeUVFMFBBTDBxM2djWXR4R3JHRHlCSlhZ?=
 =?utf-8?B?NGl5Z2NhK3g1SW5JYnlpaFNyS0ptRUp0OUEvSEF4ZnY3WWpxK1ZFemJmcmsr?=
 =?utf-8?B?R1pCVVVGYlJuVEIrNVA1T05rc1F4QWFydnBDSWowRGNzYkJKcWVFUXJJZzZE?=
 =?utf-8?B?endoUG9UNUNKcjYxYjUvTjcyZHQ4Tlk2ZnMwMmlRUGYwbFFtbjdwbWZxZFQ0?=
 =?utf-8?B?aWJqeGlXdkFJRXB4ZHlVQWRTUGxtSmZYZGsvbXBoN2ZCZzlQK01YRXFjMDBq?=
 =?utf-8?B?U0VrbzdOQ2czMGptWC8zbENGYUhTUUlHRHdFTmJxbFJkVEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WThnNFRvK0szbitTTHVBSUZKV01sMDJBbjhJY3NhWmZ1T1QvZm1TdXRMaDBC?=
 =?utf-8?B?NnI4VlhEdlBMamZZeEhYS2JqN3BHUEZNanlUM2huVythc1E1bWZqbCtML2pQ?=
 =?utf-8?B?VDVnQlE2WUo5R1E5VG9mSGZQaTVJK2JPWlN6b2l4ZXEyTTVjSUNvMm94S3Nr?=
 =?utf-8?B?Rm96eGtFWndrMUFlckE5bCtaUmF3ZFJ5R09hZ0xUajhDSnd4WTRXT1hYRUdD?=
 =?utf-8?B?a2FHK2xQSmxIZTdjNEI5UnoxZlhCa1FOYkJhdlQ4ckkxMzl5OGJ4NnNjUExM?=
 =?utf-8?B?UGRjNmJDZ0ZTdVJtRnp6RHlVbzBSUUt6aklqUExqTnhtNkEwdlRscGd1eldV?=
 =?utf-8?B?dzFjYWNrVkJJR21Od2dNUGhya0VPT0Qvck5rVUgyWitxL3dIWnR4K2hTMStY?=
 =?utf-8?B?dFRHd1JMZXZLVm5ZR3gvaXJkL2lHV0N0R29Mb2VLdmI4aGZ2em1tcENFRUho?=
 =?utf-8?B?L09INmQvQ0N4NzJtQzZ2enYxNGxrOXZyaUN0OWxMdmF2TXluMk1pOWQyMXNs?=
 =?utf-8?B?TVVTVGxLNmd2eENCL0RYOEg1TnlDNEZHZEVQclJJekdQM245YWY2SklVR3N3?=
 =?utf-8?B?STBTREdTZkJWdGxWN0hESVhwVXNZRC9aQlY3SkRETG5nRUxnOUh6YkplUW1i?=
 =?utf-8?B?dzFOSVBIdXd2QXpldktxOG5XVlRpUDdOWkE2MEVrQlMwK3FPVmlpd3pFTVhj?=
 =?utf-8?B?NFZqem91UFNrQUNnS0VaMUV0dmN0MmFUS2lLWVA0TE9ZOHJwanFBMzZoZ20x?=
 =?utf-8?B?cXBqaDF5SlhFOVhLQlVQdklvdGlkQkZubUZIQnBVSVlhUU5hRDl6emRydk9U?=
 =?utf-8?B?ZjVBci9vNlFnUkgrdGo1bFVFVWFOdjJHdWp3Q1c4allVcHdxSlpaZk0xQUxp?=
 =?utf-8?B?NldWZStXQmdFaXZCWE9NNGE1ZTVzbnJtemdNK1JqVEVESTFjdzF5cXE3MWQ3?=
 =?utf-8?B?TmxlK29XMGJaTEZzREQxZ1lZRjkwQytYMTNaQkswVWVFb3Q2WU9MczdYbnp0?=
 =?utf-8?B?amtlQm1NY0VaM0xZNko3Wm8xSDB6ZUNzMmRTZ3o4UHBYdWgzUStnSTFUR3lr?=
 =?utf-8?B?NzVqOG85M3dJb3lPWFEzeUxiVVJCV2t6UzJSQUxkLzJRNC9veGlSNlNLYlBz?=
 =?utf-8?B?dG02ejQ0aXR3dTNIL05zTUtTRURLQXdTSkRuelZtZGJBOFZ6cnZ2VHc3ZWFr?=
 =?utf-8?B?ZUZiMzZZNG41QjVaSitDSkdPWFpKTmZTY2NRZEFRQWRQa1VYMlg2SGVRZzNm?=
 =?utf-8?B?MDk4ZC8zN3VMMUZTbk4wNTFMTnlUNks1RzY0NU54Rkg1SzZFL1kvbGh4NGFT?=
 =?utf-8?B?QXNwamFCRUo3NnBNNmxveExlOXorQ2x0am5uVFUzNzVrMC9WQ3dMcEN5NHNi?=
 =?utf-8?B?MitrWlY2Q05hOVpTNTgrcktkK0tneDZHWDd1bVlhdnU4U3BxN0I5anNnUGNq?=
 =?utf-8?B?SzBiUm96TUxDaTFQWHp5MnVva1M1ditNWmdtNFRDUDB5dnh5MHZYRlNTSkI1?=
 =?utf-8?B?cDJWYkVkY2w1azhPRkFLRnZYbWZXeDhxVWZEV1U5T1dzS1JSYndQN1VNYkkw?=
 =?utf-8?B?emxFNnZ3TFQ4M2UwYVk2dWZVZGRpSmUvbnNYME8xYTNIL0VseUNCN1dFdHRE?=
 =?utf-8?B?MkdZOW8vU2p2Unl3RTA5TkRrRjR5SmxzR1pURjhFdUdGOW5ESWpRNlpEdGVs?=
 =?utf-8?B?NU9NK08vbmRQeHJtNXh0S3FsRERTRmdwdTNJVkVzVnM4ODV3S1NSQmNRVTNr?=
 =?utf-8?B?TnBtbVRiYi9Bc2cvQXRJRDZ1MFYxWjZoN0ZkY0UwOFh5SnE3Z0FQL3pQMHdH?=
 =?utf-8?B?bit4ZHFncHNkQTVTNnhKSUVmMFhmN0dlVXpsUi9OUllwVVhoNFhNdi81NVlD?=
 =?utf-8?B?TVBEbVVrdFlpOHBiRXp1a0FVeGZwd2lsN3ZkT04xMHA1ZjNuTENhWW11ZlBx?=
 =?utf-8?B?dGdYSGtsQkhzVzNKTVV0SWdMckVDVHh0YS96Z1lXVGdMRXlaMzhTZHdBMlNL?=
 =?utf-8?B?c3g3dWJPZFJHWUtVbEpMcVBoVTFqZnNxTDhrUjBxM0M3VENyZ0lHNHBXdlB5?=
 =?utf-8?B?RzdrS3kxekcrTjl4Y3hEQ3B2WkRSM2Z3c2t1eFB5L05vNHlhZEFwZ2hYenN6?=
 =?utf-8?B?V1JiOUhJL3FQQkUzRWowdWFDemtVOFJFakZCcVl1ZnExODdUWUxpRnlwT0N6?=
 =?utf-8?Q?oGP0QHtjb+m63R1mzqcN35c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CAD16FE784C0D49A88AF199A8B04E69@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16c1f1f-f0ea-4c17-d229-08dc9a5b31b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 05:52:44.6561 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8NvTJddmTW8qDPpYJeji3f8bh/OMUw/35tEZ8RZV3SSEfshYbi8fJuGrUJDdElnGA7iYTtgE3W3wQNXLz9i5hMPe9vDH0vK+WlztoZO6IkGfOyNx/MG64eS1hEnpLIP/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6215
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNCklPTU1VIGhhdmUgdG8gaW1wbGVtZW50IGlvbW11X2F0c19yZXF1ZXN0X3RyYW5z
bGF0aW9uIHRvIHN1cHBvcnQgQVRTLg0KDQpEZXZpY2VzIGNhbiB1c2UgSU9NTVVfVExCX0VOVFJZ
X1RSQU5TTEFUSU9OX0VSUk9SIHRvIGNoZWNrIHRoZSB0bGINCmVudHJpZXMgcmV0dXJuZWQgYnkg
YSB0cmFuc2xhdGlvbiByZXF1ZXN0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1
LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCi0tLQ0KIGluY2x1ZGUv
ZXhlYy9tZW1vcnkuaCB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKysrDQogc3lzdGVtL21l
bW9yeS5jICAgICAgIHwgMjAgKysrKysrKysrKysrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQs
IDQ2IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXhlYy9tZW1vcnkuaCBi
L2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0KaW5kZXggMDAzZWUwNjYxMC4uNDg1NTVjODdjNiAxMDA2
NDQNCi0tLSBhL2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0KKysrIGIvaW5jbHVkZS9leGVjL21lbW9y
eS5oDQpAQCAtMTQ4LDYgKzE0OCwxMCBAQCBzdHJ1Y3QgSU9NTVVUTEJFbnRyeSB7DQogICAgIHVp
bnQzMl90ICAgICAgICAgcGFzaWQ7DQogfTsNCiANCisvKiBDaGVjayBpZiBhbiBJT01NVSBUTEIg
ZW50cnkgaW5kaWNhdGVzIGEgdHJhbnNsYXRpb24gZXJyb3IgKi8NCisjZGVmaW5lIElPTU1VX1RM
Ql9FTlRSWV9UUkFOU0xBVElPTl9FUlJPUihlbnRyeSkgKCgoKGVudHJ5KS0+cGVybSkgJiBJT01N
VV9SVykgXA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICA9PSBJT01NVV9OT05FKQ0KKw0KIC8qDQogICogQml0bWFwIGZvciBkaWZmZXJlbnQgSU9N
TVVOb3RpZmllciBjYXBhYmlsaXRpZXMuIEVhY2ggbm90aWZpZXIgY2FuDQogICogcmVnaXN0ZXIg
d2l0aCBvbmUgb3IgbXVsdGlwbGUgSU9NTVUgTm90aWZpZXIgY2FwYWJpbGl0eSBiaXQocykuDQpA
QCAtNTcxLDYgKzU3NSwyMCBAQCBzdHJ1Y3QgSU9NTVVNZW1vcnlSZWdpb25DbGFzcyB7DQogICAg
ICBpbnQgKCppb21tdV9zZXRfaW92YV9yYW5nZXMpKElPTU1VTWVtb3J5UmVnaW9uICppb21tdSwN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgR0xpc3QgKmlvdmFfcmFuZ2VzLA0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0KKw0KKyAg
ICAvKioNCisgICAgICogQGlvbW11X2F0c19yZXF1ZXN0X3RyYW5zbGF0aW9uOg0KKyAgICAgKiBU
aGlzIG1ldGhvZCBtdXN0IGJlIGltcGxlbWVudGVkIGlmIHRoZSBJT01NVSBoYXMgQVRTIGVuYWJs
ZWQNCisgICAgICoNCisgICAgICogQHNlZSBwY2lfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb25fcGFz
aWQNCisgICAgICovDQorICAgIHNzaXplX3QgKCppb21tdV9hdHNfcmVxdWVzdF90cmFuc2xhdGlv
bikoSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGJvb2wgcHJpdl9yZXEsIGJvb2wgZXhlY19yZXEsDQorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHdhZGRyIGFkZHIsIHNpemVf
dCBsZW5ndGgsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Ym9vbCBub193cml0ZSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBJT01NVVRMQkVudHJ5ICpyZXN1bHQsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc2l6ZV90IHJlc3VsdF9sZW5ndGgsDQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgKmVycl9jb3VudCk7DQogfTsN
CiANCiB0eXBlZGVmIHN0cnVjdCBSYW1EaXNjYXJkTGlzdGVuZXIgUmFtRGlzY2FyZExpc3RlbmVy
Ow0KQEAgLTE5MjYsNiArMTk0NCwxNCBAQCB2b2lkIG1lbW9yeV9yZWdpb25faW9tbXVfcmVwbGF5
KElPTU1VTWVtb3J5UmVnaW9uICppb21tdV9tciwgSU9NTVVOb3RpZmllciAqbik7DQogdm9pZCBt
ZW1vcnlfcmVnaW9uX3VucmVnaXN0ZXJfaW9tbXVfbm90aWZpZXIoTWVtb3J5UmVnaW9uICptciwN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVU5vdGlm
aWVyICpuKTsNCiANCitzc2l6ZV90IG1lbW9yeV9yZWdpb25faW9tbXVfYXRzX3JlcXVlc3RfdHJh
bnNsYXRpb24oSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11X21yLA0KKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgcHJpdl9yZXEsIGJvb2wgZXhlY19y
ZXEsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHdh
ZGRyIGFkZHIsIHNpemVfdCBsZW5ndGgsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgYm9vbCBub193cml0ZSwNCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVVRMQkVudHJ5ICpyZXN1bHQsDQorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IHJlc3VsdF9s
ZW5ndGgsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dWludDMyX3QgKmVycl9jb3VudCk7DQorDQogLyoqDQogICogbWVtb3J5X3JlZ2lvbl9pb21tdV9n
ZXRfYXR0cjogcmV0dXJuIGFuIElPTU1VIGF0dHIgaWYgZ2V0X2F0dHIoKSBpcw0KICAqIGRlZmlu
ZWQgb24gdGhlIElPTU1VLg0KZGlmZiAtLWdpdCBhL3N5c3RlbS9tZW1vcnkuYyBiL3N5c3RlbS9t
ZW1vcnkuYw0KaW5kZXggNzRjZDczZWJjNy4uODI2OGRmN2JmNSAxMDA2NDQNCi0tLSBhL3N5c3Rl
bS9tZW1vcnkuYw0KKysrIGIvc3lzdGVtL21lbW9yeS5jDQpAQCAtMjAwNSw2ICsyMDA1LDI2IEBA
IHZvaWQgbWVtb3J5X3JlZ2lvbl91bnJlZ2lzdGVyX2lvbW11X25vdGlmaWVyKE1lbW9yeVJlZ2lv
biAqbXIsDQogICAgIG1lbW9yeV9yZWdpb25fdXBkYXRlX2lvbW11X25vdGlmeV9mbGFncyhpb21t
dV9tciwgTlVMTCk7DQogfQ0KIA0KK3NzaXplX3QgbWVtb3J5X3JlZ2lvbl9pb21tdV9hdHNfcmVx
dWVzdF90cmFuc2xhdGlvbihJT01NVU1lbW9yeVJlZ2lvbiAqaW9tbXVfbXIsDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgcHJpdl9yZXEs
DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJv
b2wgZXhlY19yZXEsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGh3YWRkciBhZGRyLCBzaXplX3QgbGVuZ3RoLA0KKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIG5vX3dyaXRlLA0KKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVVRMQkVu
dHJ5ICpyZXN1bHQsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHNpemVfdCByZXN1bHRfbGVuZ3RoLA0KKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCAqZXJyX2NvdW50KQ0KK3sNCisg
ICAgSU9NTVVNZW1vcnlSZWdpb25DbGFzcyAqaW1yYyA9IG1lbW9yeV9yZWdpb25fZ2V0X2lvbW11
X2NsYXNzX25vY2hlY2soaW9tbXVfbXIpOw0KKw0KKyAgICBpZiAoIWltcmMtPmlvbW11X2F0c19y
ZXF1ZXN0X3RyYW5zbGF0aW9uKSB7DQorICAgICAgICByZXR1cm4gLUVOT0RFVjsNCisgICAgfQ0K
Kw0KKyAgICByZXR1cm4gaW1yYy0+aW9tbXVfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb24oaW9tbXVf
bXIsIHByaXZfcmVxLCBleGVjX3JlcSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGFkZHIsIGxlbmd0aCwgbm9fd3JpdGUsIHJlc3VsdCwNCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlc3VsdF9sZW5ndGgsIGVy
cl9jb3VudCk7DQorfQ0KKw0KIHZvaWQgbWVtb3J5X3JlZ2lvbl9ub3RpZnlfaW9tbXVfb25lKElP
TU1VTm90aWZpZXIgKm5vdGlmaWVyLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIElPTU1VVExCRXZlbnQgKmV2ZW50KQ0KIHsNCi0tIA0KMi40NS4y

