Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B32BD66B85
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 19:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVxHA-0007lX-4B; Wed, 17 Dec 2025 14:33:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vVxGj-0007fC-VQ; Wed, 17 Dec 2025 14:33:11 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vVxGh-0006CU-PJ; Wed, 17 Dec 2025 14:33:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOzvkF/ie2RJE3IMQD9s34/wEAESUaTj42ajrcOzPuNMClUdX4zBndH6163v+i5Bu55reEAXg645VzYQH3MZfxAH/+xKukqqne+jOHE4cnDEpnHWwiDJpPAONbgVN2Zz/65eUtzCXa+PPtmNq/9NOhNRMFerxpgXG10OPsuPCQXA/zERCcF5TvTXjw0pi1eQnO7YflE+D7KHNoA3ANX5+N+nceLtuix1WN2yqGiDGys1NOZwy83wnRmq8IjlMnudR7N0t5NFnQIeSbXLOCeMUWqlwIEILD5bPtT+PnQsNbF/0FobcJxZpOxUFDd32AdJWrexMy4pUMqMtsba9Q2vdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFOvsX/BAREGc/XUGjH/vgIGmDIrMRUY/2ofGI5fZDc=;
 b=Ya8qhflGnpkE/RV7a04vc/8Y579PxlfggnSuYzdSy8GwPgNXqM7p1kluR/ot1puV2OEVGPnr/PtpP9KGR7WW0gLeEtcvHpKrZr0pVkwb9kQlBqF0TCTCamVKMQ3IAkp72m1xWF0m04hO9d4VAP4k3vGGMYx880mgZHtkDRS6QXxpdvMZ0bIIuz3HfNmpDnt90va7pPSiUwZ13dcAJ+MRCVcyE44IcUS4KreQQq7hLrEH9LTNYHwNKlyuyfT0tUo90BkrxzuSRBBg5TC7F7D93nsUQ90AWPZeGQi1dNHvJol8jrldb5pKicK7qTjz+wcbjnEIwBAdje4MO14DU0JyyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFOvsX/BAREGc/XUGjH/vgIGmDIrMRUY/2ofGI5fZDc=;
 b=AwvX51FY9O+2Mnzpk97HubW7hjTWK18a4UJg4SSVZot/8PQgEzHFfv4heLsYBZtW7V5ZkVZ/SPJHsh/9EqRXCPswCMr2YU9nq0sMaam3bEmQkG14NbZbG/J88r621wgnLTcPhToORr5m3tza5dK+9vhrKhA2jACbCXUYOevv8M3bS8pvKpzBnI8oIlj52fAulWow70z5mdHNnbGqLGUwqkh5ZpVxWcLHaKL2+jaTdYCwGnUPwriGzVCTEPtPDp6ulpwQ5BYvAPz+aLdTx4qsjm8+E729ME14GAt+RcCfOKZzAfL9adqsAHjEGPlhLd9ByHPzqE+u1K0zcbPzPkX0fA==
Received: from IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 19:32:58 +0000
Received: from IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::963e:9c86:4830:2ebd]) by IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::963e:9c86:4830:2ebd%6]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 19:32:57 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [RFC PATCH 00/16] hw/arm: Introduce Tegra241 CMDQV support for
 accelerated SMMUv3
Thread-Topic: [RFC PATCH 00/16] hw/arm: Introduce Tegra241 CMDQV support for
 accelerated SMMUv3
Thread-Index: AQHcadocqMzkFAhYTU6WU1M92/lWQLUcuskAgABsA6CACRyd8A==
Date: Wed, 17 Dec 2025 19:32:57 +0000
Message-ID: <IA0PR12MB755537EDE59F9DC3B8E63021ABABA@IA0PR12MB7555.namprd12.prod.outlook.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <e58763db-6005-418a-ba18-0acefb626929@redhat.com>
 <CH3PR12MB75483AF12699B30402BAACABABAEA@CH3PR12MB7548.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB75483AF12699B30402BAACABABAEA@CH3PR12MB7548.namprd12.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7555:EE_|MW4PR12MB7285:EE_
x-ms-office365-filtering-correlation-id: e6f9e1d9-189e-4688-104b-08de3da3153f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?SXZtZUhOVHovQnF3QjlTRDBObHZRbVZsY3NqS2x6WTFjM0tLQXcvNXpIR0VO?=
 =?utf-8?B?M01GUk5wUDlob1VKNTJmTEJEU2NWRHhxMS9NNHBNT0I1RkR6YVhrakxYcjlp?=
 =?utf-8?B?VWNXWTQ0bFdOaWNWU1IxcFJJaXp4LzhNTkJkRTVsZ3pSdE5KK2lGbmFWWWNO?=
 =?utf-8?B?blJ3UlVoRHgwZ2JtdTMvQ3phYkQ3ZjB0U2t6aVAvWThiZDRoSWJIc0xiMUk5?=
 =?utf-8?B?UnZWWEJiREZOQmJ3Vld4cG1yZXlVKzdoUVhHSEJnWTV6WXpxV0hZcWZIZFlj?=
 =?utf-8?B?dms5cUhDNXVkUEk5bEVBbVhlUHpDa1U5RGNtaWI2azIvK1dKTWNtRzVSeVdV?=
 =?utf-8?B?VFB5ZWNoY0N1UTNGUFpPZXFjUk5NdXpOWUw0UERUM3J0ZVVOTVNnNmhiWEFH?=
 =?utf-8?B?ekpjWXUyTUlGb3AvU0s2RVhsWGVONEZLN3JqcFR4c2F3S1FURnJOVGNQWlMx?=
 =?utf-8?B?ZDVpd2RvdTFndE9RVG9NRHBEbDRlOFZOY3l3dDVGeEhlTDIzUTIvUGxnTHBx?=
 =?utf-8?B?Zy8ySmRDd3g2bVFzRW1CT3lnWEpRZGs4eGJrYzV6ejE1VFNURmJnT2lWcFhy?=
 =?utf-8?B?cHFIeVB4NHprZHY0Z2dUQ0FtZ3ptajlTVFlQbTlPK2p5ZjFKSVkxeGgxNEFj?=
 =?utf-8?B?bWhBTEFFRk1nZzdDbHhXL3VqeUdFWnJTYkhwank3T2gwdHcrT25ENFBwakNX?=
 =?utf-8?B?Nk41YkFLWEl3Z01FQk5oVGdjcUg5cDlmTjBsZlZmK2FSMXg3QlUxb1ZLLzEz?=
 =?utf-8?B?V3RTa3MwNjg2cGw3cGJQQUQ1TTczam14VmNNc2xxcVBpQXZTZ2wwMHZYTUxi?=
 =?utf-8?B?ck1VaWpjWDBsNFFDM3hTa01LeXBQelJFYXVZSEJYdkYxOTk4T3RSRDYwc1RL?=
 =?utf-8?B?eUFUNDJjU0VXVjlOMXZxUno3NTlpT0YyZTBuVHBPc3FTY1Z1U1hOSWlaZmF0?=
 =?utf-8?B?eGRidlJ6TjBLU2wzMEZmTTgwbFBua05XdS9heDhnamVOenA5NzBXOGR3dVV5?=
 =?utf-8?B?enhhNXVtUFpMS29BenhRRXhrMVdSVTBmSzJVT1dLWDNMMGZ3QllDcE9mS3RJ?=
 =?utf-8?B?bG5qZEhLRGZIZ25sWXNScW5kZTAzQWw4M0FtZUpJL1FYeTRWZVhYVEowWjRi?=
 =?utf-8?B?MklZeGlmQ054ZEF6VjR0V3FJQzhpZXVoZzZVOXBhRmt6cGpYeWszMWxRM0t1?=
 =?utf-8?B?ZlpSVEVsLzJQaHlJL0FXZE9qd2NHbUJCZjVaMmhxVGk3Z1lIUWdtajZTVnZ1?=
 =?utf-8?B?QlZHK0xnMGFvN1pXRGpIM3lLTlp1cE1DR29DUGRQbStSYlg3RElQYVM4ejdL?=
 =?utf-8?B?anFaamJsZENHZUdHWDVTUy93Q2Q0QWpTRlh2L3o5ZlBMYjlOVUNmZEZ2cjc5?=
 =?utf-8?B?VXluOFhRTlR6WVgvYytTbnR6OGFJSTcwVlFZOGo1YlB0ZmVibTZYNlpmS1ha?=
 =?utf-8?B?cmJFQUhOb1lEc1FuT3UvN2tNOFgyUmI0ZVVNalhGbHpjRUlHWHdIQjRlcDNS?=
 =?utf-8?B?TkJSZXgyU0piSWRnRk0yR2lYcDc3OWJ1akpmaWRzZ3c1eTF3bW5OZ1A5emt6?=
 =?utf-8?B?aitsblozK0ZkclJCMCtrYURST2V1Kzc0dFA5c0lpZ2ZzNjVnTHJQVzQ5ZUFi?=
 =?utf-8?B?WFlBVXJrTnlVNmxnU0RKNjBVUXdrRUVRenA1SzFBSXlYZkpIUlk4VUtwb1h6?=
 =?utf-8?B?M2tPSTY4TmQyUXNmaUhFb1F3djNMbjZNRzRkejFLSnltanRwZ1lJUFgzN09l?=
 =?utf-8?B?YllETGN5Nnc1Q2pZNHk1Vm5qeVkvazEzZDBqV0x1eDlUZWZ6VWZxMElhWW5i?=
 =?utf-8?B?THlybG1BZlJ4c3FWSmd4SDZUd2JYZlVYNmFQV0FLQWVycHpmQXFLU1BJc0sy?=
 =?utf-8?B?Nlk4UVdhbkZnZGlSUDhXa2ErblZMNTJDOHdFZzZ4OU9aMmRQOEgremkrNS95?=
 =?utf-8?B?MVk4VVZRVmdsYlBhVlFGWlJrY3JQczYzczUyN09id3YyVUxadE00TnBxUlRY?=
 =?utf-8?B?L29aaE5BZndOeXVaYlJybVlDbTJEcTU3eHdRWGVUL2JYTHFQSU1xY0ZGK3Vi?=
 =?utf-8?B?bFpzMnE0ak55VjVLVXdTMGQxOUlKdTVnbUZuQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVhZUy9ldTRXSXRQeXRKQk1ZckppMytrMDB3UkQrUUtDY3VRUG16UWRJOWRF?=
 =?utf-8?B?RGsvbjRxYS83dS9pd2c3dnlZTGw5NUtlWU1uUWU1NVFJREtqTW95MlpaNDR2?=
 =?utf-8?B?bjExaUhINGY2MHpwbjBPV2NsZE5DYUJ1bys5Z3JIVW5FL2N6OGdvSXVJVlVx?=
 =?utf-8?B?Y2RHdCsxNUZnazYwbnBhSVA4Z0lvbW43VnFlVDdrVUMzNHlTUFBNSjkyaUg4?=
 =?utf-8?B?OUk4c2RHSlZpMXZ5VVQ0T3BtdVpRNHliY3piVFZGVG5uZWRJVEt0NlUyQzFL?=
 =?utf-8?B?UkUza0h1bTFwdWR2czdQM3VxZFBqcFVyZitONGg1SS9HOGcxMjhxNFNIdWNM?=
 =?utf-8?B?WDdXRHZGNGNHbVN6bHQ2YktaZDFNZEtEQksraTg2V2UySWpUeXJLMTFqNXVU?=
 =?utf-8?B?eVFJSFVTdjh4VGt1bVdJN3lnRW5kSmV4cno1NHhmT0lnM3Q0Z3dJVyt5Ylc2?=
 =?utf-8?B?Rml3eTg0WElPNStWSkNSMEx6V2NqTHhQWDd1QThiTjhKUHJELzY2Q1hPSHJR?=
 =?utf-8?B?VWU4bGZ3MC9CYTVNcW1lK0xEampHRFpiOFkvZDhWUTY2Y1dlRFJTUkJsSzMx?=
 =?utf-8?B?cFc0SytuSW53VGNMTzRGeFR3M2dpR3hIZjE5T3pyK3djOVFhSlpkSmlYOGhh?=
 =?utf-8?B?MUgzSWU1cFFaL0oyRXUrMGlhRFVOVTlRNmVXZEZTbnkwL1pRK0NOTEthQkp2?=
 =?utf-8?B?bDk2a0RVNWIxV2tRMHVWYTJKWFVIQyswSmNHMnVySUJuakJQeVZyWkM2dVh5?=
 =?utf-8?B?SkdrdmhpVVF1cldCcjVoTzNwQVRNcndJM1VtRU9Ec2k5QXU1eXA1U1RXVGJC?=
 =?utf-8?B?YnZzVlZBZDkzazV1UGJtV25Wa2hqcUpja05tUEtzK3pGajhlMTBKWEFDSmtS?=
 =?utf-8?B?RnAzMDFURExSQmVZeThSN2ZjN1FQR0ZrdGw2NlhoVVMwZGE3VHp0TEFYWFlr?=
 =?utf-8?B?OWZUbkVVb2J4UWhmc0xJL2QvYzVYNVhGelF0dSswT1M1OTIyaFMvL1hwR1NP?=
 =?utf-8?B?RW1UOTgxRUJjN1orajNMbDhudEVWSmFtWTVubHY0U1BBOUE2c0tpMjJrbWp4?=
 =?utf-8?B?UXkvUkorc3RQMEF6NHordlhOaVp6QTRabHYwVGYzZ3pLSXZzanBHaVZuakJD?=
 =?utf-8?B?UnZjcjJvL0l0ZXJKdmFZRFZBYVRwMzhrNG5ta2VxN0Z0aGtCRDh3Skgxd2FR?=
 =?utf-8?B?SFNPZ2xxU0RRdDlucXptL2JWSSs1TjVMZkxzUk5lUjc4WWd1TGRaUjlLTUFK?=
 =?utf-8?B?Q1MxekxRYkhZZWc3MVpQcm45eTRMYm5SdjBrY0hSR2FlVGxBZGJWMjN1N1o2?=
 =?utf-8?B?QlZGK1ZmdFY0U0M1MU5BZXU5aFFRUjZiSWM0UjV6RjFOUW91SE14dG1aYU91?=
 =?utf-8?B?ZmsrTU1CbE4zUHJWM2RndjdRZkpCbUZnOWtlaENSNVRWSWJ2ckdZaXdlRjdD?=
 =?utf-8?B?R3RRN09Fc2JyMEhESmtMaVlHQUgwU3NCWGt3L2NzbXlXOTM1MUsxZGlJK1RC?=
 =?utf-8?B?QTRxRlJDMkpzMzNGNEJwOVBEUGkvNitkTWxINCs3WjlITWRDaHo4K21RanF2?=
 =?utf-8?B?OEtaTDR2WWFyN2NWWnNuRUxnSjFNTmRlUUVERVNGMEgvSVJpbFUzZjAvaG1Y?=
 =?utf-8?B?NEpKbzdudy91T2xsWFd0NTlTQjZncFc3R0RWYUJ6elVScXNSZm1VeFdFZG1y?=
 =?utf-8?B?NHppcUZMdExsOGlKc1hETE8rWDBwOGJVbVBjVUsrZ2xGZS9aY3FnYmtQWHRp?=
 =?utf-8?B?akxEK09najNlUUZhaHd0YW9UQmlYem4ybHlpU2ZRdU5ZR2YrUTl1SGpueDhj?=
 =?utf-8?B?dk1Qa01VS296T3hQaTdTT1FMYVFLR2dWOWVJU2cvVWpZbm1pUGIvS0w0ejll?=
 =?utf-8?B?a1pVMC96ZnJzcjk5eTQ3VVRtYktSYW1nRlJoSjJ0SVcwVDRQcGhTU3NMSVhV?=
 =?utf-8?B?QkJLbFBwbXNKckMrZjVSclp4QWQ5cGUzV0hDZ29NcnRPYi9UeHRiNlE0VjRH?=
 =?utf-8?B?ZVlLRFFycVBYZ1BJOUdzMkJnS3BOdG4wWFZkWE40MTY3TjVBRDNkdFBpODFv?=
 =?utf-8?B?Ny9FVnVRak5lZEE5a0JtSVdHRmVNajUya05OT0pnWnp3NUVkWDFQWUtxMSsr?=
 =?utf-8?Q?gDjLrXmyjrkBuliqV4ti1tmbe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f9e1d9-189e-4688-104b-08de3da3153f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 19:32:57.8016 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MMt4zMHnH+R/zGwGwCIKXpExl6zNUjCSLLXlr+vyhY/7CI+2GjgV+bfp/ZmHmdpLLyHnR2faFEwLmYRRKaHhtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285
Received-SPF: softfail client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhbWVlciBLb2xvdGh1
bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+DQo+IFNlbnQ6IDEyIERlY2VtYmVyIDIwMjUgMDA6
MjMNCj4gVG86IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgcWVtdS1hcm1Abm9uZ251Lm9yZzsgcWVt
dS0NCj4gZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBO
aWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4NCj4gQ2hlbiA8bmF0aGFu
Y0BudmlkaWEuY29tPjsgTWF0dCBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsgSmFzb24NCj4gR3Vu
dGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47IGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbTsNCj4g
emhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56aG9uZy5kdWFuQGludGVsLmNvbTsgS3Jpc2hu
YWthbnQgSmFqdQ0KPiA8a2phanVAbnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUkU6IFtSRkMgUEFU
Q0ggMDAvMTZdIGh3L2FybTogSW50cm9kdWNlIFRlZ3JhMjQxIENNRFFWIHN1cHBvcnQNCj4gZm9y
IGFjY2VsZXJhdGVkIFNNTVV2Mw0KPiANCj4gSGkgRXJpYywNCj4gDQo+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5j
b20+DQo+ID4gU2VudDogMTEgRGVjZW1iZXIgMjAyNSAxNzo1NQ0KPiA+IFRvOiBTaGFtZWVyIEtv
bG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUtDQo+IGFybUBub25nbnUub3Jn
Ow0KPiA+IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiA+IENjOiBwZXRlci5tYXlkZWxsQGxpbmFy
by5vcmc7IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47DQo+ID4gTmF0aGFuIENo
ZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQgT2NocyA8bW9jaHNAbnZpZGlhLmNvbT47DQo+
IEphc29uDQo+ID4gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47IGpvbmF0aGFuLmNhbWVyb25A
aHVhd2VpLmNvbTsNCj4gPiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsgemhlbnpob25nLmR1YW5A
aW50ZWwuY29tOyBLcmlzaG5ha2FudCBKYWp1DQo+ID4gPGtqYWp1QG52aWRpYS5jb20+DQo+ID4g
U3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMDAvMTZdIGh3L2FybTogSW50cm9kdWNlIFRlZ3JhMjQx
IENNRFFWDQo+ID4gc3VwcG9ydCBmb3IgYWNjZWxlcmF0ZWQgU01NVXYzDQo+ID4NCj4gPiBFeHRl
cm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiAN
Cj4gWy4uLl0NCj4gDQo+ID4NCj4gPiA+IFswXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11
LWRldmVsLzIwMjUxMTIwMTMyMjEzLjU2NTgxLTEtDQo+ID4gc2tvbG90aHVtdGhvQG52aWRpYS5j
b20vDQo+ID4gPiBbMV0NCj4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9jb3Zlci4x
NzUyMTI2NzQ4LmdpdC5uaWNvbGluY0BudmlkaWEuY29tDQo+ID4gPiAvDQo+ID4NCj4gPiBkbyB5
b3UgaGF2ZSBhIGJyYW5jaCB0byBzaGFyZSB3aXRoIGFsbCB0aGUgYml0cz8NCj4gDQo+IEhlcmU6
DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9zaGFtaWFsaTIwMDgvcWVtdS1tYXN0ZXIuZ2l0ICBtYXN0
ZXItc21tdXYzLWFjY2VsLQ0KPiB2Ni12ZXZlbnRxLXYyLXZjbWRxLXJmY3YxDQoNCkkganVzdCBy
ZWFsaXNlZCB0aGlzIG5lZWRzIGEgZml4IGluIHBhdGNoICMxNiwNCg0KZGlmZiAtLWdpdCBhL2h3
L2FybS9zbW11djMuYyBiL2h3L2FybS9zbW11djMuYw0KaW5kZXggNThjMzVjMmFmMy4uYzMyYjM1
YTlhNyAxMDA2NDQNCi0tLSBhL2h3L2FybS9zbW11djMuYw0KKysrIGIvaHcvYXJtL3NtbXV2My5j
DQpAQCAtMTk1NCw3ICsxOTU0LDcgQEAgc3RhdGljIGJvb2wgc21tdV92YWxpZGF0ZV9wcm9wZXJ0
eShTTU1VdjNTdGF0ZSAqcywgRXJyb3IgKiplcnJwKQ0KICAgICAgICAgcmV0dXJuIGZhbHNlOw0K
ICAgICB9DQogI2VuZGlmDQotI2lmbmRlZiBDT05GSUdfVEVHUkEyNDFfQ01EUQ0KKyNpZm5kZWYg
Q09ORklHX1RFR1JBMjQxX0NNRFFWDQogICAgIGlmIChzLT50ZWdyYTI0MV9jbWRxdikgew0KICAg
ICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAidGVncmEyNDFfY21kcXY9b24gc3VwcG9ydCBub3QgY29t
cGlsZWQgaW4iKTsNCiAgICAgICAgIHJldHVybiBmYWxzZTsNCi0tDQoNClB1c2hlZCB0byBhYm92
ZSBicmFuY2guDQoNClRoYW5rcywNClNoYW1lZXINCg0KDQo=

