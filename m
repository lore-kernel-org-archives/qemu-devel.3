Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF74E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkaO-0006jT-Ar; Thu, 12 Dec 2024 09:54:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tLkaL-0006iP-BL
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:54:37 -0500
Received: from mail-bn8nam12on20617.outbound.protection.outlook.com
 ([2a01:111:f403:2418::617]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tLkaI-0007Rp-H2
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:54:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6371HW9b+FxwOsKmB+43iZfPmG6XdI7+kj/1VmFaBgvNTxyrryNredm0e8mOjLAzdpafM/3nvB+m97Svt/9gBJ/Idx1GgRlPc9oY52a4SG0DMOBrgmTA4fvCX/HXxDmBnKIRqQO5kZ/IEvskx90uylQG70A9mEtR+UQnmTtf1gnvvFKcOXGVQ1rU9N6YeDcWk3SQxI8utmK2v++6FHc7wlc6VQW/iEql6Kurqy9z8wGIEMamLUcnjWySCg1FPnweHgoul8Uv9DYTB7V/IRIWC40gDFlTEEndhNQofEyymwcQf09vVjmqnPLeIVEl3ALipYhbs/v2e2tO0u1WcuqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFSX/atgaqh3liay70yuM/1h84pzTD6nGRh9iwu1otU=;
 b=RpZHKZuUkgXkUTbt9wo1r+DsGXLY160z+khqnbwzinco0qNAALAb3sUx/+3IbhvgZD8Y/tlj1t1xYXHXwjSgi2UFQPnzyAswdEN8KDyq9ZOEDlhFyZJbTFIZ8jAZiq5XX3DXmLzDz1dt1ftLJoBd0QXTYPeUoYvpNRuzm37zuDRduql6uFhg6GzYlU+MTUTHTif+ykxOZgX+uzApQMdxsaMevpaknSx1k5IIlz1sTKM/XQoBUZQ20yBimo68Ge5uqINwdZrOpQgDvGcMX+U4SVixQVX2nDzF0fnknQ/lTAAdjlRhW1ggZt8FgxHAXVU2+o3Q32R56x2JZonrlsAZnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFSX/atgaqh3liay70yuM/1h84pzTD6nGRh9iwu1otU=;
 b=PCder7xFC0bOf2yIQxli6PszHwCgjkm5zXuKYuSuVjK1QGgkY9bHr93nC5ufH/pP7QxKXmqKfW4kOmqaZxRXckzN4/MaGFbcADeQdf8ip0gj8TQgbd45gvPONzEy1uo8YWvMgKsMoWcV/NBNgoC1IVTqMf0O2qZ2xfcQz80R6m9caQKws+rBV48b3Zpj/FZf6mFkGcpmZKCy4nLwflHBItWbe+yJspJiUTEq9AmncfRb4vcX+IEDGpUKhxwb3QcW1iB/BlsKgh6O5cJ8UB8LjB0RkxHmz+m4mKqsF4m2Xhee6laQ2lLdVMn+jV2U+zQ7V9XVUgKOM6hxtb3cObvZ+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 by CY8PR12MB8214.namprd12.prod.outlook.com (2603:10b6:930:76::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 14:54:23 +0000
Received: from BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d]) by BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d%4]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 14:54:23 +0000
Message-ID: <1ea676b5-c52a-4745-b5ce-f0376b1e6473@nvidia.com>
Date: Thu, 12 Dec 2024 16:54:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/24] vfio/migration: Multifd device state transfer
 support - send side
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <4f5c33b97be09fcb4e1885073e31c5e930a39ad0.1731773021.git.maciej.szmigiero@oracle.com>
 <51279885-5229-4c5f-93af-d1214dd65f90@nvidia.com>
 <06360868-95e3-46e2-8960-51348025a1b7@maciej.szmigiero.name>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <06360868-95e3-46e2-8960-51348025a1b7@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::13) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:EE_|CY8PR12MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: 49fc02ac-1f33-4fdc-f112-08dd1abcdd45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2pncUVqZVdaS09jL21hSG9OU1ROWmlqVzdzRXJZQVdzaWpSRk9tZDNRWG5v?=
 =?utf-8?B?S1JQSjM2dFg4bjFoWGtaeFlyUHRZaml3WFZleGhaUytLRFo3TStNZXVsb3J5?=
 =?utf-8?B?SHdTUjBYNVJCZ0xmWDF1SEUraVNGcWRpQlArWGw4MUp2bG1Zbnp4Q0gyOG9S?=
 =?utf-8?B?cXRwNDQ4cGNvdnppeWRCdUgyT2I0alhBaHZCa2ZESENFNFB3cXFMRHlVcWlY?=
 =?utf-8?B?Z3Fsa044YXF1R1cvUERxUUFCZjUzQXlTeVVLdDZoQ1JkT1ZXRm5hc2FjMXBQ?=
 =?utf-8?B?REJJS0RKWEI0ZTNtekxMQ3dTb0Fmang3SmVQZVNtak1SZlBZdXZrU1UreWJC?=
 =?utf-8?B?WnhxVXVBRE1Uc1FWSHNwTUdxK3lsZUNBczd4UHQ2a3kyeXpKSldYblJNRmlM?=
 =?utf-8?B?czNYZW81RDBqRysxV1B1a1YycVRLZjZhcEIyR0FtYjVBKysvTFY1NWtTYjRE?=
 =?utf-8?B?blliR1dDQzFJcFVWcE1yVFNoTnNja1BpUGtqYmxOeEVodDdGZ3pjcGpFZE51?=
 =?utf-8?B?cHV3NVZqZVJvYzNIaXJLQ2tidG54OHZnbm5mRjZqVmlFZEZGaUtuTk9PQU1m?=
 =?utf-8?B?b3NlRGxEeCtWUzZBZUZWOHNBbjkzQXdPaXBVeExmL2YzRFI2Nm5HMU5KYzFu?=
 =?utf-8?B?R2Z3RVRRaFJnbEFXV1dvbDhuK1haZTBCWkdTdm9KRFZkL1FrNG93MGVMZm9t?=
 =?utf-8?B?cXh0NDY4SFd3MHpqSDFIZFV2STJ6anRLa2Q5VUhQRWtSZmY2MGZmOXg3UlZv?=
 =?utf-8?B?elk5elFBZVVDeW9IV1BtNDY4MFhvc2c5eFdZSHQ4Z1lRYk50ekFJcGxxbFoz?=
 =?utf-8?B?RGJGKzdaV1VxRWlBOW85VHVoMy9uUjZqUzZub3htcURoTFdLZGl5ZXJHMXg3?=
 =?utf-8?B?WktvTHc5cnUxY0hLb3hOWHVkdzh4SU1LeE03bVdpa1c4aXNmVmtqdDJQQUFm?=
 =?utf-8?B?TTNYMjRCYUlUYmI0MGFPd0VESTB5N0E2dkxsTXl6Y3BjZzJFaXkzS3pSVWJu?=
 =?utf-8?B?TkpqSkhZbWRqcVZ5YWh4elRTWkVRZ2x5bkdaMUwwSmJTSjQweFExWS9Cbjg4?=
 =?utf-8?B?MTkvZTlIK05EUkpaaHpjeXFkUjBhUGhaNnRDLzVpc2k4dEhiam5TblRNM2Fp?=
 =?utf-8?B?Zk96cGZ3dml0disycTBtcFF3Wkk5aGJhUENIQmU4ZjRBcHNPN094bHpOU0ho?=
 =?utf-8?B?UGVUTld3b1FpYkZJVE5VdXB2YW5rZjJjM20yNkl6MGhXeUhJZ0hoM1pQVXNU?=
 =?utf-8?B?U2UzY2dGVm5zeGpXT1BCaXc3MEFjTWlaM2xZTkt5UlRrOXZWNFIzWE5TSUpN?=
 =?utf-8?B?a2paSEZYMGg2emVhNUJwNEFLZnp2U1huSGF5SFd5RHdmOElJWUI3UWhFRFkv?=
 =?utf-8?B?dTFNQWZGZGtSQWs4SVQwS1lZbFE3dHpLMDVlLzJKMElPZGd0eGJ6UW0rdVBI?=
 =?utf-8?B?T2JlYmJOV2wxTkwxK0lkRWpOcHNZbUF2aVRmc0U2dXlGWnErMmF4NkJnbFl4?=
 =?utf-8?B?MlZ2V21sQ0xVcnNLK0hUU08vTUl4NFJZN3NqTDVkYzFtb0lmdm51a3lzbldL?=
 =?utf-8?B?cXB6VHdXMDBUZGJGUE83WXN5dldKRE1YWFFJVklvL20rcXkrZG9WYTRsRUxC?=
 =?utf-8?B?ZWZibGZaMDRubWJ0ajhYOGZaaDRSUnJRM0xwbDVEbTcveGdsMW1MVC81OFda?=
 =?utf-8?B?K0E5a3FHV2FPaFg3ZlRJZ1VhVm9WMmx1bmN0eTB2V2tLcm1oRGFaNGViQ2JL?=
 =?utf-8?B?cmxEMmpjT0pKRXpFUDVVWUhVeHZmOVMzeXVHbnpnMW83aWNPcFZzN1JDZjF4?=
 =?utf-8?B?Y3lrTnB1Z29PRGhDRWlmQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5544.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHhCK3NNbXlRQ05VclF4VWw4VXFZdVkxVm5vWUxBNHBjelhSUUFFb0FhbHB0?=
 =?utf-8?B?WDExL0tHN24yemNGVGdpNzNyTUwvdkxlcTVsN0x2dmdvS0JaT25KN0wwTFJ4?=
 =?utf-8?B?RVoxdmJyOENtam9QVlRNbFJoa0habWlzTkRiVHFlTDdJeXBjWWovZTd0S2dk?=
 =?utf-8?B?VnlJTFBnb0svRTRNNXZONnB4alJRSkRpaGZEb2Y0QUZtaStRSU5USjFKZGoy?=
 =?utf-8?B?UFFsK1FoMnBTT3FwOUlxcFJSYVh3bFIwbVFEa1RUK09kNmM4b2o0YXI4SHdQ?=
 =?utf-8?B?Y1J1ZysrSEJtdHBHZklISnV0Y1lBVzhlOHgrZzVLb2NuZmFwZmtLUitPeDgr?=
 =?utf-8?B?ak5XUlRSU1lHMTFnSjI3RmVWYjdUL29IRkpwRkZCQ2s2OUVLVWJsRjlucHhw?=
 =?utf-8?B?U25kSUJtZmR1Vit3SUI3ajlRUGx4RUQxRU16NU8wRjBrOEp6RlRHaUtSR3hv?=
 =?utf-8?B?YXBjTmRneE0wRXAyVzZ4QXRxQlRrdWZkcHdxa3VJMDJ0Ym5kYmtrZjhTN0JD?=
 =?utf-8?B?Y2NTTkhnNUFnMEU3bjlwcEVCWVBhbEZLakNZWXl5Z0NhVE9nd0tCU3FZR2ZP?=
 =?utf-8?B?aGsxOUFBNkg4WjJtUzk2SEM4OUVhUWpLMUhBUFJmZ3dwQ0RHTVJFeFVDcHZO?=
 =?utf-8?B?L2NHZzZpcmpOU1cvc2xITXFjZlJ3S1dQZTA1Qi9iN1lQb2Jpc1p0M1ZoZUdZ?=
 =?utf-8?B?WTVqMVFmMU1EU1ozcFFtYkxQdHRSbTJEV00vUElGVWl1YWtCY21XMkNjYmNj?=
 =?utf-8?B?T1QvUk8wdVFZTkRuODNTU3daUWlVbTZIWFcxOXBhU2xaVDY2aWRqNGp2MXI2?=
 =?utf-8?B?L3ZucGlTYWlhVUd4aFppYllvK3B2K05JcVA2S2ZWdGFTaWlyVnpBUkg2SVlI?=
 =?utf-8?B?b0F4T0VyWUdYZ2phNnlrVkYyWUtwUTBTblN5bzhOMHlscjI4STR1MERSblhz?=
 =?utf-8?B?ZS9oakhESllCM3Zaell3YjNCQU5DZUhMZ2lmTmZkVkRmcjdmZHR6eGIvV2lh?=
 =?utf-8?B?MVk0WmI4MXBCaVhoMEppU3diMGZUbFlVZlFmWEhBbVNrdGVTcVZRWno4b1da?=
 =?utf-8?B?OUxUZ2hpWHhDak1Cd2cyQjlpVkx5VG9YVW56eXg1eGdqSUppTm8rQUJYVlZY?=
 =?utf-8?B?RzRBNUp4a0xWSHgrRndLb1lRODBCMXNXcWFrTDlTVlJJOTBPMTRqTXJGZmVk?=
 =?utf-8?B?WGR0Zm9WZDZzUHl1NkRsMHloaG41aVFHUnhtenJRMThnTWlITWp3TDVIcXVu?=
 =?utf-8?B?cTlrNkFWbXcrL1lQZzhkcDdxN3dsT2JpTmdZeTFVRlZNZXJZTTFUVnJZNnNn?=
 =?utf-8?B?N1orY3JlazlhS0ppWUpTOGEzb3ZCZEZSU1dvcHNjVjBhRDl2c0ZXUUFXMC82?=
 =?utf-8?B?K3d5eGhKaDVlOGtyQnRtTG9FbzB4Q3dQcURLS2xBcGhabkpoOUFwMFRaODJK?=
 =?utf-8?B?blNZOEUyVGlQcmZGR3pMcmNYeTJTM21sTEFVZ1JDZG8zSXNnWGdtL05lbTdH?=
 =?utf-8?B?M09GOXQ3Lzk4TlFsTHJMYTJnWDBDQkk0MHNjZDkyS3NNZ1VVUzV1NkFZd2R5?=
 =?utf-8?B?TkNhQm1QY3h1N2FrcnlBOWRFSGgrZHlQSU9Ha3RDYUE4YjI3c0xzaXUyMG1v?=
 =?utf-8?B?VnNybk94bGd3WHpQMUZPcC9Qb1NEQk45dUw0NHBOdFcxcHVJbDdseFMyMjUx?=
 =?utf-8?B?ZzFXZ0xwR1krYmRyWnI1b3A2bENlNUxZMmVZWFl5QW5IQkVGa0FyaE13RGxr?=
 =?utf-8?B?OGlvZ2Z5dU94b2h1eXhYMURQWjJSNmhDN2tjRld5WitBdjdzd2FvUW80alQv?=
 =?utf-8?B?K3diQThUT1pSemN6RUtWVUt5ejFla3pCL1g3OXlGK2Jvd1ZkSlJZYWsyOVZT?=
 =?utf-8?B?VlE4RzM4U2VWekNLTUp5d2xHRjBPaE9BTytmQmgrcGZSQ0tjTzRlYjBudUJU?=
 =?utf-8?B?RDBUbTdKblBzK05jRjdSUlp0MnZCb1AxZThLRkwxSXRRVGpSZmxCb1RZMXRU?=
 =?utf-8?B?NGhJeVFXSHJkazR6VE16M2I3eXp0dGQzak5HRkZyamMzNWwwMzcwZ3RJOEl6?=
 =?utf-8?B?VXNKTUZnT3Yyc2lTZ1RuY1k2d0w4SGhSNjZRdnk0NkQ1R2V1OFlhdHozanlp?=
 =?utf-8?Q?X9tissZPWs1POx+yDaWZht3f8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fc02ac-1f33-4fdc-f112-08dd1abcdd45
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 14:54:23.3966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29VOKjQ2G+xOFG1DxO7cYXCt8NNG8ZaWbFTll4TUkIWkWRWN9LSBVhiUcMAJBsCmsrEp0DjcD1ZgH4Df6bORSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8214
Received-SPF: softfail client-ip=2a01:111:f403:2418::617;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 11/12/2024 1:06, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> On 9.12.2024 10:28, Avihai Horon wrote:
>>
>> On 17/11/2024 21:20, Maciej S. Szmigiero wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> Implement the multifd device state transfer via additional per-device
>>> thread inside save_live_complete_precopy_thread handler.
>>>
>>> Switch between doing the data transfer in the new handler and doing it
>>> in the old save_state handler depending on the
>>> x-migration-multifd-transfer device property value.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   hw/vfio/migration.c  | 155 
>>> +++++++++++++++++++++++++++++++++++++++++++
>>>   hw/vfio/trace-events |   2 +
>>>   2 files changed, 157 insertions(+)
>>>
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index b54879fe6209..8709672ada48 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -771,6 +771,24 @@ static int vfio_save_setup(QEMUFile *f, void 
>>> *opaque, Error **errp)
>>>       uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
>>>       int ret;
>>>
>>> +    /*
>>> +     * Make a copy of this setting at the start in case it is changed
>>> +     * mid-migration.
>>> +     */
>>> +    if (vbasedev->migration_multifd_transfer == ON_OFF_AUTO_AUTO) {
>>> +        migration->multifd_transfer = 
>>> vfio_multifd_transfer_supported();
>>> +    } else {
>>> +        migration->multifd_transfer =
>>> +            vbasedev->migration_multifd_transfer == ON_OFF_AUTO_ON;
>>> +    }
>>> +
>>> +    if (migration->multifd_transfer && 
>>> !vfio_multifd_transfer_supported()) {
>>> +        error_setg(errp,
>>> +                   "%s: Multifd device transfer requested but 
>>> unsupported in the current config",
>>> +                   vbasedev->name);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
>>>
>>>       vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
>>> @@ -942,13 +960,32 @@ static int vfio_save_iterate(QEMUFile *f, void 
>>> *opaque)
>>>       return !migration->precopy_init_size && 
>>> !migration->precopy_dirty_size;
>>>   }
>>>
>>> +static void vfio_save_multifd_emit_dummy_eos(VFIODevice *vbasedev, 
>>> QEMUFile *f)
>>> +{
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +
>>> +    assert(migration->multifd_transfer);
>>> +
>>> +    /*
>>> +     * Emit dummy NOP data on the main migration channel since the 
>>> actual
>>> +     * device state transfer is done via multifd channels.
>>> +     */
>>> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>>> +}
>>> +
>>>   static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>>>   {
>>>       VFIODevice *vbasedev = opaque;
>>> +    VFIOMigration *migration = vbasedev->migration;
>>>       ssize_t data_size;
>>>       int ret;
>>>       Error *local_err = NULL;
>>>
>>> +    if (migration->multifd_transfer) {
>>> +        vfio_save_multifd_emit_dummy_eos(vbasedev, f);
>>> +        return 0;
>>> +    }
>>
>> I wonder whether we should add a .save_live_use_thread SaveVMHandlers 
>> through which a device can indicate if it wants to save its data with 
>> the async or sync handler.
>> This will allow migration layer (i.e., 
>> qemu_savevm_state_complete_precopy_iterable) to know which handler to 
>> call instead of calling both of them and letting each device 
>> implicitly decide.
>> IMHO it will make the code clearer and will allow us to drop 
>> vfio_save_multifd_emit_dummy_eos().
>
> I think that it's not worth adding a new SaveVMHandler just for this 
> specific
> use case, considering that it's easy to handle it inside driver by 
> emitting that
> FLAG_END_OF_STATE.
>
> Especially considering that for compatibility with other drivers that 
> do not
> define that hypothetical new SaveVMHandler not having it defined would 
> need to
> have the same effect as it always returning "false".

We already have such handlers like .is_active, .has_postcopy and 
.is_active_iterate.
Since VFIO migration with multifd involves a lot of threads and 
convoluted code paths, I thought this could put some order (even if 
small) into things, especially if it allows us to avoid the 
vfio_save_multifd_emit_dummy_eos() which feels a bit hackish.

But anyway, that's only my opinion, and I can understand why this could 
be seen as an overkill.

Thanks.

>
>>> +
>>> trace_vfio_save_complete_precopy_start(vbasedev->name);
>>>
>>>       /* We reach here with device state STOP or STOP_COPY only */
>>> @@ -974,12 +1011,129 @@ static int 
>>> vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>>>       return ret;
>>>   }
>>>
>>> +static int
>>> +vfio_save_complete_precopy_async_thread_config_state(VFIODevice 
>>> *vbasedev,
>>> +                                                     char *idstr,
>>> +                                                     uint32_t 
>>> instance_id,
>>> +                                                     uint32_t idx)
>>> +{
>>> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
>>> +    g_autoptr(QEMUFile) f = NULL;
>>> +    int ret;
>>> +    g_autofree VFIODeviceStatePacket *packet = NULL;
>>> +    size_t packet_len;
>>> +
>>> +    bioc = qio_channel_buffer_new(0);
>>> +    qio_channel_set_name(QIO_CHANNEL(bioc), 
>>> "vfio-device-config-save");
>>> +
>>> +    f = qemu_file_new_output(QIO_CHANNEL(bioc));
>>> +
>>> +    ret = vfio_save_device_config_state(f, vbasedev, NULL);
>>> +    if (ret) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    ret = qemu_fflush(f);
>>> +    if (ret) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    packet_len = sizeof(*packet) + bioc->usage;
>>> +    packet = g_malloc0(packet_len);
>>> +    packet->idx = idx;
>>> +    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
>>> +    memcpy(&packet->data, bioc->data, bioc->usage);
>>> +
>>> +    if (!multifd_queue_device_state(idstr, instance_id,
>>> +                                    (char *)packet, packet_len)) {
>>> +        return -1;
>>> +    }
>>> +
>>> +    qatomic_add(&bytes_transferred, packet_len);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int vfio_save_complete_precopy_thread(char *idstr,
>>> +                                             uint32_t instance_id,
>>> +                                             bool *abort_flag,
>>> +                                             void *opaque)
>>> +{
>>> +    VFIODevice *vbasedev = opaque;
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +    int ret;
>>> +    g_autofree VFIODeviceStatePacket *packet = NULL;
>>> +    uint32_t idx;
>>> +
>>> +    if (!migration->multifd_transfer) {
>>> +        /* Nothing to do, vfio_save_complete_precopy() does the 
>>> transfer. */
>>> +        return 0;
>>> +    }
>>> +
>>> + trace_vfio_save_complete_precopy_thread_start(vbasedev->name,
>>> +                                                  idstr, instance_id);
>>> +
>>> +    /* We reach here with device state STOP or STOP_COPY only */
>>> +    ret = vfio_migration_set_state(vbasedev, 
>>> VFIO_DEVICE_STATE_STOP_COPY,
>>> +                                   VFIO_DEVICE_STATE_STOP, NULL);
>>> +    if (ret) {
>>> +        goto ret_finish;
>>> +    }
>>> +
>>> +    packet = g_malloc0(sizeof(*packet) + migration->data_buffer_size);
>>> +
>>> +    for (idx = 0; ; idx++) {
>>> +        ssize_t data_size;
>>> +        size_t packet_size;
>>> +
>>> +        if (qatomic_read(abort_flag)) {
>>> +            ret = -ECANCELED;
>>> +            goto ret_finish;
>>> +        }
>>> +
>>> +        data_size = read(migration->data_fd, &packet->data,
>>> +                         migration->data_buffer_size);
>>> +        if (data_size < 0) {
>>> +            ret = -errno;
>>> +            goto ret_finish;
>>> +        } else if (data_size == 0) {
>>> +            break;
>>> +        }
>>> +
>>> +        packet->idx = idx;
>>> +        packet_size = sizeof(*packet) + data_size;
>>> +
>>> +        if (!multifd_queue_device_state(idstr, instance_id,
>>> +                                        (char *)packet, 
>>> packet_size)) {
>>> +            ret = -1;
>>> +            goto ret_finish;
>>> +        }
>>> +
>>> +        qatomic_add(&bytes_transferred, packet_size);
>>> +    }
>>> +
>>> +    ret = 
>>> vfio_save_complete_precopy_async_thread_config_state(vbasedev, idstr,
>>> + instance_id,
>>> +                                                               idx);
>>
>> I am not sure it's safe to save the config space asyncly in the 
>> thread, as it might be dependent on other device's non-iterable state 
>> being loaded first.
>> See commit d329f5032e17 ("vfio: Move the saving of the config space 
>> to the right place in VFIO migration") which moved config space 
>> saving to the non-iterable state saving.
>
> That's an important information - thanks for pointing this out.
>
> Since we don't want to lose this config state saving parallelism
> (and the future config state saving parallelism) on unaffected platform
> we'll probably need to disable this functionality for ARM64.
>
> By the way, this kind of an implicit dependency in VMState between 
> devices
> is really hard to manage, there should be a way to specify it in code 
> somehow...
>
>> Thanks.
>
> Thanks,
> Maciej
>

