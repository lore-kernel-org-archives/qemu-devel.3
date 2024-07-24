Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED7BC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 05:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWV1H-0005v5-SZ; Wed, 24 Jul 2024 01:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sWV1G-0005uX-UH
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 01:58:34 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sWV1E-000263-3L
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 01:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1721800712; x=1753336712;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9vqgGrG+Zbfm/d2Md2gCY4dH4InhLIcmp76aBXWvRd8=;
 b=ZjUKBiHP3J6kL0AyoTWuGnT8mejVVNqF25/9wylClleeuzkFEoYKIVMw
 ZivBg0cyR7kMgxBCrHotZR12Y7CXQRUkk2UbpuGLvbwtWyqLF8ajYqbDC
 ELxN3BrHclehgB7qvMH2+yze1cPIE/igJiZ2v1mjHVK5RovD0zP68l0mj
 K5FsUEQNrSeXWaBgSrKMe3Y6ZWS5LR136gnGecPzJ4bKcqxxPbzZXKYQl
 OPao6Ax8jkyfAF7lzzhUu/JBmp5X3t9HkDnkSK5FlFo9SNZl0aLvo4jvI
 3LHITWea0i8vWs/tNSFC+MQ2BUlUoO/Hvz53AShdtw231HlyX0kSdZWnF w==;
X-IronPort-AV: E=Sophos;i="6.09,232,1716242400"; d="scan'208";a="17221236"
X-MGA-submission: =?us-ascii?q?MDHp72KkLlVSrUkMYTRA1nOpTPxI0/qYetI1tC?=
 =?us-ascii?q?F+BaL5OyeOQ9GHSByLLFapUxV0r73gPHInbeda+J0QKfEoybU0C4+Jv/?=
 =?us-ascii?q?pyahyQvftu+wFl0VrqQ4kp2AkA3nR5coT3qLrGPgBvm1U/h81JQmruDF?=
 =?us-ascii?q?zOzOhtGQqr7u3NYCO95D4akw=3D=3D?=
Received: from mail-db5eur02lp2104.outbound.protection.outlook.com (HELO
 EUR02-DB5-obe.outbound.protection.outlook.com) ([104.47.11.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2024 07:58:28 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOjFJ/OtoCfN+gt9zt2r//EU5bCwRcQRN9yjh0FJra+Q5+kzN3IF7wU/bfchaupAJSkyaRKcSt0sGj1XyJJYC683FiI34GTN4C3AH3+49HOp2QuodFxvVbCoLeNCbiNKznQmmjKpNRXAxq88MNwKfG9VTN2BcfRN5Ej1lyBdlYu32HAhMHgPgVIuKktah/EDyj6FqzlnPmLZ+WxrV6ZPmPImuf+/qqVIz/RYn4C6aOv/hDv2URqMHNfdfeX6SephxZ6mWXTONqNRZtXf4RuREG4M/nfvneXShAkrLd7qWAjQ89jdE/jtt33gLLGcwEu7GkBVrHmfoeobst4f5ssAQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vqgGrG+Zbfm/d2Md2gCY4dH4InhLIcmp76aBXWvRd8=;
 b=reKmOH7u+lKR0QYhicUAp7gHInX4q3entTIHg1cYtSYmzay63d6uO/1Lz2jEa9sM6+zhIqB2LuUt5nTBepzOSuFto/r1vizUANRge7JlBH0d4Yv1YYN4QBWCFsGJEhAGVGIg0ULxDd3m9o7dKXg1WzcqIvxhX8eAXrQ7fQJ7nlLzlbteByjsMcVFc6PQf0ZhbZQfhuRP5lOXyxY5nI/78mu/5llQVXURdJKDu96jhSID3pIFvFz2AKFO6yo8euS/bQedtxrdwhYPs6fKWWIqQ2aRn/cEfXDSYcvQI6Z2KfHpuYw4Qy6CnC8SaL7p9hBxa0Q79uglez8+MMbT1bHetA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vqgGrG+Zbfm/d2Md2gCY4dH4InhLIcmp76aBXWvRd8=;
 b=YaxIkKpLw4VAZBeXs9eY4vcI+8tRsIC8tVXhTEME9C4yfzlzyWBOOq/K6v/kIYTNro+aFPMX3uCb8NIaOMke1n/n8p454MdGYm84xPPpGCjBTXbJw7b0e0+NNsASeluJtRa8jna+uGTHRvYE7TstZdWYye0xk+TMUmHL81kewB2GG6S3xeWXJH8s+gPSUWkzrGuG+Z0HRWPjuRyTFwXXIxIxXk6D44cRinS0C8+Vu2PmerZyp6qO8EGdkYcwTuX665wagqjHO/wDrUA+b+KDoEpsbJP/tsy8OGJ4cq/8Q2gu4I5EkPMKidS0B7mXQMUaLs0GPrkuqJow81sZRyD21Q==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS1PR07MB8759.eurprd07.prod.outlook.com (2603:10a6:20b:47b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 24 Jul
 2024 05:58:26 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7807.006; Wed, 24 Jul 2024
 05:58:26 +0000
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
 <chao.p.peng@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 17/17] tests/qtest: Add intel-iommu test
Thread-Topic: [PATCH v1 17/17] tests/qtest: Add intel-iommu test
Thread-Index: AQHa2OtfHg5v6psjXk6dkU1Xm7qH5rIFax6A
Date: Wed, 24 Jul 2024 05:58:26 +0000
Message-ID: <6635ba0b-9e58-4dd2-be0a-3b749eb9e9cf@eviden.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-18-zhenzhong.duan@intel.com>
In-Reply-To: <20240718081636.879544-18-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS1PR07MB8759:EE_
x-ms-office365-filtering-correlation-id: 900b8d35-5990-4105-223b-08dcaba5a24c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?YTB4TC9heENqQnRwK3g1bDlrL3pHd05oT3NNUFU3cmZDK29SOGg5aHJTTDJp?=
 =?utf-8?B?Y0FBRUhxeDFEZnRtS2IxeUFlV0txQk1PRngvNENETXl1N1NrUVVsdWZwU0FI?=
 =?utf-8?B?azRXUE41MDdTWUN1bWpRdkpsRHNsZ0VoU0oxTUw5b0JoRHE2WllRUkNUcWVr?=
 =?utf-8?B?b0hzRU52ZU5VYm9kazdHV2FqQVUvc0pPL3ZmZ0IzVDJac1d2aVdQbDZaZC9N?=
 =?utf-8?B?NnJkU2UydFNaNmFmb1lkbFFJQVl3V3ozUUx0eXFpSGZsNnE2ZUFidkk2bUJF?=
 =?utf-8?B?SFB3ckRoY3BvUnMzOE9xZG9HVEVlbGxQemk4cEF0M1hnVEp6ZG42M3FqSTVz?=
 =?utf-8?B?SGFuc0pSRUVjMFRiNThUTDRoSlFjNGdHVVNtckNabzUyd21sVG1OSC9WaStG?=
 =?utf-8?B?cWFQRDcxSGhRc2ZqZ2U2MzVpSWhJRjNXck9Id2FZNkNBZHdlUlJpNStBNGJ6?=
 =?utf-8?B?akhxSzNWb0tLS29DU3pnVmNjTHB4cHh4MDZVaVJpSmtvRTByd21oRG5ncW5o?=
 =?utf-8?B?R3hxUGQ2ckxTZVZmbDBpNmRXa0dyQlBhMGlPWU4yZXB0N1IvRzZ1YUJpZ3I0?=
 =?utf-8?B?Q21zUDhocjFKRUNPcUR6MTRSNWNxR1poaWFybUpHTjV4c2ZFM3Mwdjk1d2xP?=
 =?utf-8?B?MWFyYW9VdGpqempkdmdkYSt3ZlF5RVBHdTFXSmQxWWhtcCtOTHMyYjdsdUdY?=
 =?utf-8?B?YnYvZFNEcS9LM3YzWFpiSktHM1A3NWRabVVJaG42bDMvNmNVckdsdUIveFNG?=
 =?utf-8?B?VWVoZCs3TEdhR0xmUDlvSGF5NkdzOW14U1VNQjFnRzZqQWNUbjBtUW1MRjJ5?=
 =?utf-8?B?d0ZuT2FSTUNnNVBVam4xZzZjR21QYkxCaGc1cmJ4cndidmFvdGtNaWpadFJR?=
 =?utf-8?B?YTBjUjgyazltQk83YzdQUkdRNE5zbVJnSDBQWU1vRmU1NThkQVppK0Nod2Nq?=
 =?utf-8?B?UGgzM0k1MjdMMHI1ek9MdTFWRlJGNHFkb2RTcEFvMXBXZ0U5a2k1d1RwRXZn?=
 =?utf-8?B?NWlHOHl3VmVPeUlEYmxpRjF5TWVJczcyNk00Z280b282SGVSY3VvMHNmKzJu?=
 =?utf-8?B?Q2RLbHBCdS9UWDJNKzhySU1KMTMzTFpiWE9QZUdUTDlDVWdoVFRPUjlGR3hu?=
 =?utf-8?B?QkR6RUJhUDlEZWZSejBBZCtRcjArWDJtZ3BvR2djK3Rac0xhU1hTanA1c3B1?=
 =?utf-8?B?Y1F3UnJsRE1tVkFqaHJEZEVMZFNQM0JnVlFkSjl2Z2lIZzdES2hORzg0bm9J?=
 =?utf-8?B?Y2JlU2l1UXZxQitCTmdtOGxhbzg0NEVKdUdDUCs2cDJCaFk5d2dUZ0RvS0pt?=
 =?utf-8?B?UmdLSjdmOGhNV2pqQUJOUkN2dTdmekVOS2ZBTG5YR2VnVW03UWFsT21WV2t3?=
 =?utf-8?B?Nmp0N1hqcXNodjBYTHdOQTJFMlBSVmZuZ3FQQWlyejd6RlZqcVphL3NJVjFC?=
 =?utf-8?B?Z2N0T1B4UXpyeGtralZ3Q3N3ZjVHOWtzcXVHcFFhMzBVVEg2V0Y0V2tKT04y?=
 =?utf-8?B?K1VWVkczdUpoYVdhb0VpWlYrbmZVOTlKWUkzeWxUaUxEV3NJMjlqMWd6Uk1Y?=
 =?utf-8?B?aVdaKzErREVSc1M4YWdWQldKdnIyZVJia3FhZkF0V3hvM2dyVVVNSVZFV2lm?=
 =?utf-8?B?Z0UvS2FlYk1kVUxwdnBtVUFZWnBSYXFYWkNTeTBNNjNIR0liMllNYjRORFZv?=
 =?utf-8?B?SG5SSnJKSG5OcTQ0alE1UmZQdytKemRxd3hZMGhCbmUwY3Bsa0p6NDVPMzlv?=
 =?utf-8?B?M1JzQU0wZFR2T2s5TTdKdGl2Q2RSOEV1RU1uUTlJTzU3MUV2QzdxYVRiKytw?=
 =?utf-8?B?WGJDT0tuOXBFemtPcERQNGY5MSsrWlRRc3AvRmZ4SWtMb2lrei96d3Vsb0Zi?=
 =?utf-8?B?Z05GV1BmbFR3ZFJ4dFZrRVdaeWpKN2NGT0x2SUp2bjNDalE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHZVcUljQ0M2TTRjU0tSQkhPeUkwTmRNbXlqS1RPVjF3N2Z0RmhxNytGODZa?=
 =?utf-8?B?TXFHUW9XeE1wQ3M2WFduMHNFUyswem5MSVJybXNZMGUwNXR2OU9ZUml4UjZ4?=
 =?utf-8?B?a0pXam5YTlRJWHVHWWg4R2xVYXZSTVVwUEtxenZmbUFTTERGWlN6S2lxNk5l?=
 =?utf-8?B?V2VuNXJWUys0OWU0MldKS1RvNExRK1I3T01sRWZZdjlhV2taTlhyckNZOXd5?=
 =?utf-8?B?SFNIWnZsQjUrQkJtSk0yWE9WSE5MUlh4NVJiSWNYQWh2ZWw3MXo5NGZUSkwr?=
 =?utf-8?B?ci9yWDlHbHMzLzFGdmU3L2ZxZzNodW55ZGVzMmYzUGJlRUQyYXZ0d0tEQ2Nh?=
 =?utf-8?B?Zk1XeUZRbk4yVTNoYmpnMGc3SkdPaGVxeWNkUERwbXQ0NXNLbmpzelBpdzBO?=
 =?utf-8?B?N0RJQThCY1RUakh5TE5BTnNtK3JkRFNyNGpaSTY0T1JmQ0p1YzZXZ2VkQUFW?=
 =?utf-8?B?RDgyUjA4YklUa3J4M3BDT0VIUk5pTXdHZUxIbUwvdjFBUjNsSmZnN2RQbUVZ?=
 =?utf-8?B?N1VkRE03eWwwRVRSTEM5ZkIycHE2RWI0bTJkVHNNR1BKcnM1eDNYZ2tQVFVR?=
 =?utf-8?B?R0VzYTBValJoR0tZMVNqcVdXRjhkSk1uaDBCL1JNNXQ5czlabkVVVVFwMWtC?=
 =?utf-8?B?dXJFMFNEM1kvSnVtem9odDlJK0pZUk5NWGRaTzJLMFgyM2lBWkVxbXZXUTEw?=
 =?utf-8?B?K1VWSUtLQlhvV3NLYU05TGtyU0ZWRHA2cnFrbldEYWhibUFEbHRWMG0wMUFF?=
 =?utf-8?B?aklSRlpQYjdRbkQ4dEpVclJVQ2VUMnBEQjNRRkM5K0p3YWJleUVTN0pnQm9J?=
 =?utf-8?B?RkllejYvTEVuaUZQaGY0aS9iWU9PVTVWTGFUd25hUWNvYWdQNGY4bzZhcmJB?=
 =?utf-8?B?dmduMWFYWk40TWNYYXlKUkE4UnVvTmRPbEtBNnNGRE1pckUzb24vQlUzQjhD?=
 =?utf-8?B?UytocGgrTU1ETTNUOGFPNmE4VUdOK3dKWFQ1QXcrcG94bGJxSWI3Z1JTd1Vm?=
 =?utf-8?B?N1FDSXVDWFJEeXptZDZYdXh5T09pK3NmZERWQm8xZXRpbnNoQStseUZZN3Ez?=
 =?utf-8?B?eFBvTHVoeER6OVpjdUY3Rm5pREFqL0JJbTJiU1lNMUkrdWk1VmErUlhjbnJS?=
 =?utf-8?B?R2dCenVtaTlzRno5UkJyaXo3RXpBY3FRZVJaNzYzNWZwL1hXM1V6a1ZzKzVx?=
 =?utf-8?B?SDQvcHRGTXBLS2xRdGJNaTRQdnRMQUx0VGdORVR3NFVWQjFNNVZFYkNldUZk?=
 =?utf-8?B?VGUrVHBnTzlON1E1eVdhMFRoUUcvSmNGdXpxWVNqZ3BCQStNVzJxcEV5a2FE?=
 =?utf-8?B?d0JqVTlQWWJCNG5yVk5wblVzUWtLN0ZXd0J6cFJIaFM1Z0FqWmhVaHdlbjI2?=
 =?utf-8?B?VzNTYmk3cldmYWxndW9IcVdMWFVuc0FTcGtDS3AxMW9XbTQ4ZHJNVWhhV3Y0?=
 =?utf-8?B?Ly9kUHZyV1JyV24wTmxkelI0bGIzWWk3WUZZbzJQSmRZV2owaEJ5ajN2RU5E?=
 =?utf-8?B?T29SM2RoRjhwWFd2bmhIbzhuQzcvTEVVL0RaTTRLOGdwZXNkY1NxNVJtMUJ1?=
 =?utf-8?B?M0RRVVJRdkQ4L0RYejlPRlVBWXcrRWpSaHgrelpOWHlTUlhNRG9DdXl6QjZO?=
 =?utf-8?B?ZWVWY25GY0tqU2V0NjVuckFjSk9sR0gwaTFVUzZuQnQ3Tkl4RVRHV2RYcmZr?=
 =?utf-8?B?bDk3SjV0L2ZQUDEwd201bjFacDgzQUNBc2VuWnQyS0NkemtyODVXSTN6ekNY?=
 =?utf-8?B?YXVkcTdFUWx3WWlmOXdqRDJxckdsV1JocjIvTFR3NWRFSitLYjFsTXk0a1Nk?=
 =?utf-8?B?S2U3clkyWm9ZclZTSUJVWU9FdFRrYWYxMG43NXQxU0ZTczM2L3h2UGZUVEFH?=
 =?utf-8?B?TjlmVUlnM1k4bzM1QWd2YURnN0hrVDVBTFhXSVpmLzlxeU5mWkJ6V04wSEh3?=
 =?utf-8?B?NTVqQ2puYnpqakM0Vkl5MDNlQ21PZFV0MTBIS0xIdFhsZVFGbEl5Y205MXpm?=
 =?utf-8?B?TXZXMUFtMnY0aHF0QThDbjNYY21PZjY1ZGtySVM1VW5LTjd5Q2doY3UrOXVn?=
 =?utf-8?B?eFQvb3BzZTl4LzJnSEUrRmRCNXNNQWNpNmZHVDFVWDBsZS9jQzlQckxkQklk?=
 =?utf-8?B?VE9sWnhlT2Jpc1BhZElOT2ZSNTVEK0lMVnYrK1ovSHhVd1FrNzVkUTY0NUZr?=
 =?utf-8?Q?iUa2pvynW2jGgBUHlZQpBm4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <256B3EC6C77F5144AE578C1CE36DE007@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900b8d35-5990-4105-223b-08dcaba5a24c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 05:58:26.0288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RquvRbwh0pmycWH6K6YVhTxyZQptjNuUczumkOAO99yICmFo+Aym9OumjxuXawzfdpVloFwfNyzYf5jj8ogDEoLiox6N6vU68U+3uECmhm60vfgbX2TNjlUw12dIsTOj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR07MB8759
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

DQoNCk9uIDE4LzA3LzIwMjQgMTA6MTYsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPiBDYXV0aW9u
OiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3Ms
IHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+IEFkZCB0aGUgZnJhbWV3b3JrIHRvIHRlc3Qg
dGhlIGludGVsLWlvbW11IGRldmljZS4NCj4NCj4gQ3VycmVudGx5IG9ubHkgdGVzdGVkIGNhcC9l
Y2FwIGJpdHMgY29ycmVjdG5lc3MgaW4gc2NhbGFibGUNCj4gbW9kZXJuIG1vZGUuIEFsc28gdGVz
dGVkIGNhcC9lY2FwIGJpdHMgY29uc2lzdGVuY3kgYmVmb3JlDQo+IGFuZCBhZnRlciBzeXN0ZW0g
cmVzZXQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVh
bkBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICB8
ICAxICsNCj4gICBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCAgfCAgMSArDQo+ICAgdGVz
dHMvcXRlc3QvaW50ZWwtaW9tbXUtdGVzdC5jIHwgNzEgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiAgIHRlc3RzL3F0ZXN0L21lc29uLmJ1aWxkICAgICAgICB8ICAxICsNCj4g
ICA0IGZpbGVzIGNoYW5nZWQsIDc0IGluc2VydGlvbnMoKykNCj4gICBjcmVhdGUgbW9kZSAxMDA2
NDQgdGVzdHMvcXRlc3QvaW50ZWwtaW9tbXUtdGVzdC5jDQo+DQo+IGRpZmYgLS1naXQgYS9NQUlO
VEFJTkVSUyBiL01BSU5UQUlORVJTDQo+IGluZGV4IDdkOTgxMTQ1OGMuLmVjNzY1YmYzZDMgMTAw
NjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+IEBAIC0zNjYy
LDYgKzM2NjIsNyBAQCBTOiBTdXBwb3J0ZWQNCj4gICBGOiBody9pMzg2L2ludGVsX2lvbW11LmMN
Cj4gICBGOiBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4gICBGOiBpbmNsdWRlL2h3
L2kzODYvaW50ZWxfaW9tbXUuaA0KPiArRjogdGVzdHMvcXRlc3QvaW50ZWwtaW9tbXUtdGVzdC5j
DQo+DQo+ICAgQU1ELVZpIEVtdWxhdGlvbg0KPiAgIFM6IE9ycGhhbg0KPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmggYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9t
bXUuaA0KPiBpbmRleCA2NTA2NDE1NDRjLi5iMTg0OGRiZWM2IDEwMDY0NA0KPiAtLS0gYS9pbmNs
dWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPiArKysgYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxf
aW9tbXUuaA0KPiBAQCAtNDcsNiArNDcsNyBAQCBPQkpFQ1RfREVDTEFSRV9TSU1QTEVfVFlQRShJ
bnRlbElPTU1VU3RhdGUsIElOVEVMX0lPTU1VX0RFVklDRSkNCj4gICAjZGVmaW5lIFZURF9IT1NU
X0FXXzQ4QklUICAgICAgICAgICA0OA0KPiAgICNkZWZpbmUgVlREX0hPU1RfQVdfQVVUTyAgICAg
ICAgICAgIDB4ZmYNCj4gICAjZGVmaW5lIFZURF9IQVdfTUFTSyhhdykgICAgICAgICAgICAoKDFV
TEwgPDwgKGF3KSkgLSAxKQ0KPiArI2RlZmluZSBWVERfTUdBV19GUk9NX0NBUChjYXApICAgICAg
KChjYXAgPj4gMTYpICYgMHgzZlVMTCkNCj4NCj4gICAjZGVmaW5lIERNQVJfUkVQT1JUX0ZfSU5U
UiAgICAgICAgICAoMSkNCj4NCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3F0ZXN0L2ludGVsLWlvbW11
LXRlc3QuYyBiL3Rlc3RzL3F0ZXN0L2ludGVsLWlvbW11LXRlc3QuYw0KPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwLi44ZTA3MDM0ZjZmDQo+IC0tLSAvZGV2L251bGwN
Cj4gKysrIGIvdGVzdHMvcXRlc3QvaW50ZWwtaW9tbXUtdGVzdC5jDQo+IEBAIC0wLDAgKzEsNzEg
QEANCj4gKy8qDQo+ICsgKiBRVGVzdCB0ZXN0Y2FzZSBmb3IgaW50ZWwtaW9tbXUNCj4gKyAqDQo+
ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjQgSW50ZWwsIEluYy4NCj4gKyAqDQo+ICsgKiBBdXRob3I6
IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+ICsgKg0KPiArICog
VGhpcyB3b3JrIGlzIGxpY2Vuc2VkIHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdQTCwgdmVy
c2lvbiAyIG9yIGxhdGVyLg0KPiArICogU2VlIHRoZSBDT1BZSU5HIGZpbGUgaW4gdGhlIHRvcC1s
ZXZlbCBkaXJlY3RvcnkuDQo+ICsgKi8NCj4gKw0KPiArI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIN
Cj4gKyNpbmNsdWRlICJsaWJxdGVzdC5oIg0KPiArI2luY2x1ZGUgImh3L2kzODYvaW50ZWxfaW9t
bXVfaW50ZXJuYWwuaCINCj4gKw0KPiArI2RlZmluZSBDQVBfTU9ERVJOX0ZJWEVEMSAgICAoVlRE
X0NBUF9GUk8gfCBWVERfQ0FQX05GUiB8IFZURF9DQVBfTkQgfCBcDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBWVERfQ0FQX01BTVYgfCBWVERfQ0FQX1BTSSB8IFZURF9DQVBfU0xM
UFMpDQo+ICsjZGVmaW5lIEVDQVBfTU9ERVJOX0ZJWEVEMSAgIChWVERfRUNBUF9RSSB8ICBWVERf
RUNBUF9JUk8gfCBWVERfRUNBUF9NSE1WIHwgXA0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgVlREX0VDQVBfU01UUyB8IFZURF9FQ0FQX0ZMVFMpDQo+ICsNCj4gK3N0YXRpYyBpbmxp
bmUgdWludDMyX3QgdnRkX3JlZ19yZWFkbChRVGVzdFN0YXRlICpzLCB1aW50NjRfdCBvZmZzZXQp
DQo+ICt7DQo+ICsgICAgcmV0dXJuIHF0ZXN0X3JlYWRsKHMsIFEzNV9IT1NUX0JSSURHRV9JT01N
VV9BRERSICsgb2Zmc2V0KTsNCj4gK30NCj4gKw0KPiArc3RhdGljIGlubGluZSB1aW50NjRfdCB2
dGRfcmVnX3JlYWRxKFFUZXN0U3RhdGUgKnMsIHVpbnQ2NF90IG9mZnNldCkNCj4gK3sNCj4gKyAg
ICByZXR1cm4gcXRlc3RfcmVhZHEocywgUTM1X0hPU1RfQlJJREdFX0lPTU1VX0FERFIgKyBvZmZz
ZXQpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCB0ZXN0X2ludGVsX2lvbW11X21vZGVybih2
b2lkKQ0KPiArew0KPiArICAgIHVpbnQ4X3QgaW5pdF9jc3JbRE1BUl9SRUdfU0laRV07ICAgICAv
KiByZWdpc3RlciB2YWx1ZXMgKi8NCj4gKyAgICB1aW50OF90IHBvc3RfcmVzZXRfY3NyW0RNQVJf
UkVHX1NJWkVdOyAgICAgLyogcmVnaXN0ZXIgdmFsdWVzICovDQo+ICsgICAgdWludDY0X3QgY2Fw
LCBlY2FwLCB0bXA7DQo+ICsgICAgUVRlc3RTdGF0ZSAqczsNCj4gKw0KPiArICAgIHMgPSBxdGVz
dF9pbml0KCItTSBxMzUgLWRldmljZSBpbnRlbC1pb21tdSx4LXNjYWxhYmxlLW1vZGU9bW9kZXJu
Iik7DQo+ICsNCj4gKyAgICBjYXAgPSB2dGRfcmVnX3JlYWRxKHMsIERNQVJfQ0FQX1JFRyk7DQo+
ICsgICAgZ19hc3NlcnQoKGNhcCAmIENBUF9NT0RFUk5fRklYRUQxKSA9PSBDQVBfTU9ERVJOX0ZJ
WEVEMSk7DQo+ICsNCj4gKyAgICB0bXAgPSBjYXAgJiBWVERfQ0FQX1NBR0FXX01BU0s7DQo+ICsg
ICAgZ19hc3NlcnQodG1wID09IChWVERfQ0FQX1NBR0FXXzM5Yml0IHwgVlREX0NBUF9TQUdBV180
OGJpdCkpOw0KPiArDQo+ICsgICAgdG1wID0gVlREX01HQVdfRlJPTV9DQVAoY2FwKTsNCj4gKyAg
ICBnX2Fzc2VydCh0bXAgPT0gVlREX0hPU1RfQVdfNDhCSVQgLSAxKTsNCj4gKw0KPiArICAgIGVj
YXAgPSB2dGRfcmVnX3JlYWRxKHMsIERNQVJfRUNBUF9SRUcpOw0KPiArICAgIGdfYXNzZXJ0KChl
Y2FwICYgRUNBUF9NT0RFUk5fRklYRUQxKSA9PSBFQ0FQX01PREVSTl9GSVhFRDEpOw0KPiArICAg
IGdfYXNzZXJ0KGVjYXAgJiBWVERfRUNBUF9JUik7DQpDYW4gd2UgYWRkIFZURF9FQ0FQX0lSIHRv
IEVDQVBfTU9ERVJOX0ZJWEVEMT8NCj4gKw0KPiArICAgIHF0ZXN0X21lbXJlYWQocywgUTM1X0hP
U1RfQlJJREdFX0lPTU1VX0FERFIsIGluaXRfY3NyLCBETUFSX1JFR19TSVpFKTsNCj4gKw0KPiAr
ICAgIHFvYmplY3RfdW5yZWYocXRlc3RfcW1wKHMsICJ7ICdleGVjdXRlJzogJ3N5c3RlbV9yZXNl
dCcgfSIpKTsNCj4gKyAgICBxdGVzdF9xbXBfZXZlbnR3YWl0KHMsICJSRVNFVCIpOw0KPiArDQo+
ICsgICAgcXRlc3RfbWVtcmVhZChzLCBRMzVfSE9TVF9CUklER0VfSU9NTVVfQUREUiwgcG9zdF9y
ZXNldF9jc3IsIERNQVJfUkVHX1NJWkUpOw0KPiArICAgIC8qIEVuc3VyZSByZWdpc3RlcnMgYXJl
IGNvbnNpc3RlbnQgYWZ0ZXIgaGFyZCByZXNldCAqLw0KPiArICAgIGdfYXNzZXJ0KCFtZW1jbXAo
aW5pdF9jc3IsIHBvc3RfcmVzZXRfY3NyLCBETUFSX1JFR19TSVpFKSk7DQo+ICsNCj4gKyAgICBx
dGVzdF9xdWl0KHMpOw0KPiArfQ0KPiArDQo+ICtpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFy
Z3YpDQo+ICt7DQo+ICsgICAgZ190ZXN0X2luaXQoJmFyZ2MsICZhcmd2LCBOVUxMKTsNCj4gKyAg
ICBxdGVzdF9hZGRfZnVuYygiL3EzNS9pbnRlbC1pb21tdS9tb2Rlcm4iLCB0ZXN0X2ludGVsX2lv
bW11X21vZGVybik7DQo+ICsNCj4gKyAgICByZXR1cm4gZ190ZXN0X3J1bigpOw0KPiArfQ0KPiBk
aWZmIC0tZ2l0IGEvdGVzdHMvcXRlc3QvbWVzb24uYnVpbGQgYi90ZXN0cy9xdGVzdC9tZXNvbi5i
dWlsZA0KPiBpbmRleCA2NTA4YmZiMWEyLi4yMGQwNWQ0NzFiIDEwMDY0NA0KPiAtLS0gYS90ZXN0
cy9xdGVzdC9tZXNvbi5idWlsZA0KPiArKysgYi90ZXN0cy9xdGVzdC9tZXNvbi5idWlsZA0KPiBA
QCAtNzksNiArNzksNyBAQCBxdGVzdHNfaTM4NiA9IFwNCj4gICAgIChjb25maWdfYWxsX2Rldmlj
ZXMuaGFzX2tleSgnQ09ORklHX1NCMTYnKSA/IFsnZnV6ei1zYjE2LXRlc3QnXSA6IFtdKSArICAg
ICAgICAgICAgICAgICAgIFwNCj4gICAgIChjb25maWdfYWxsX2RldmljZXMuaGFzX2tleSgnQ09O
RklHX1NESENJX1BDSScpID8gWydmdXp6LXNkY2FyZC10ZXN0J10gOiBbXSkgKyAgICAgICAgICAg
IFwNCj4gICAgIChjb25maWdfYWxsX2RldmljZXMuaGFzX2tleSgnQ09ORklHX0VTUF9QQ0knKSA/
IFsnYW01M2M5NzQtdGVzdCddIDogW10pICsgICAgICAgICAgICAgICAgIFwNCj4gKyAgKGNvbmZp
Z19hbGxfZGV2aWNlcy5oYXNfa2V5KCdDT05GSUdfVlREJykgPyBbJ2ludGVsLWlvbW11LXRlc3Qn
XSA6IFtdKSArICAgICAgICAgICAgICAgICBcDQo+ICAgICAoaG9zdF9vcyAhPSAnd2luZG93cycg
YW5kICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFwNCj4gICAgICBjb25maWdfYWxsX2RldmljZXMuaGFzX2tleSgnQ09ORklHX0FD
UElfRVJTVCcpID8gWydlcnN0LXRlc3QnXSA6IFtdKSArICAgICAgICAgICAgICAgICAgIFwNCj4g
ICAgIChjb25maWdfYWxsX2RldmljZXMuaGFzX2tleSgnQ09ORklHX1BDSUVfUE9SVCcpIGFuZCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gLS0NCj4gMi4zNC4xDQo+
DQoNClJldmlld2VkLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmPGNsZW1lbnQubWF0aGlldS0t
ZHJpZkBldmlkZW4uY29tPg==

