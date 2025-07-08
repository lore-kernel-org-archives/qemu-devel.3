Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30020C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZEbp-0000I5-Vq; Tue, 08 Jul 2025 16:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1uZDT9-0001LE-VH; Tue, 08 Jul 2025 14:55:26 -0400
Received: from mail-bn8nam11on20605.outbound.protection.outlook.com
 ([2a01:111:f403:2414::605]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1uZDSu-0000Q0-Kf; Tue, 08 Jul 2025 14:55:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNds0EKFgMJXCjjepl6MJWVPI8v/EZmUp9ZBxNLKNwQqZQYkJjOd2NNoo0Jj3gYjjhGEiArAwuc/i9aA1mWYEajpgj+9cgYHmgcNMRkbJrXivU/0JOFrFvqwagYhsi2W9XzmboiRE1jRoLIZmpzvsRemsDLo+orDxKMQ1UJJ8PGqxB3HPHvQWkLnkPWpigr4GGzfsQXkEUWfVwPYHJyIXcJ7YFkaaiBGtfa8Npty7RihO6PBdrOiKClsJeTLNCU8h5f9F195bi49iKZOgbWk5mMij9gvB+nJQz5TvMXLzd/uaT407Ou37X/AV/99QlkDd2yW18MoImckm95hv483Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94cx6+6ryC+pqcCcOKMEBOherzRLqa9zmLSQfr3QMLI=;
 b=VaL8uRo+3srlw71EuKb9Kgi06KjJtQ5EGkVXR3hLayptpvyLJZg3slIvxGCGI6YpTvWBueBG0ezRREiLnx+ALeCEqO3hQu/E/ueCef0fJqJZP7kgqD+4E2l234ZuS+vQL2vPOSkB9bFHALWIcF6K9cLJUAWwHCtc6Yu0pzzCr3jq9tY910msXRzv1GtPz1Wdmt2Kwo9FoOpfj32IKfELJt3/+c7EUtpcT9E3KUuRQJglenf0Odr1jTTflDJsS0p3IQ6HwiZSxtn87U9MjPthz8kt7c79/yNBIASHoG8u9B21N8i0FmTrvS1rBB5VDC0xBcmHTH275vg9JQove/gGVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94cx6+6ryC+pqcCcOKMEBOherzRLqa9zmLSQfr3QMLI=;
 b=LVSnWqSUhkjqtKDYFJojuHbkC2EwtztKvIxax8yVNnp9SZC0DWBcFpv1nWeT0prmzmguG9sLqRHwPxTQHEV6+gQ0xzfXKzId4OpDhqG4XZX/JR5MuHYKlpf/8eWZS321uxaMnxapjqBvskQw/CiJ/kLM+gp+eI7tzh/E9vFbo4CXOhdb8csxSXs6at/WxYZGtoG5a2diYLF4N4kXsm6txCKbbqVZwc2lNl2mqTzn6+EBeR1NnKCeiKTkrjJbB9qexbkziiBlyq/Lz6kBb6B3AfE3YMvHwMhbOCJfrY5CEqELp/Q9OchyCmedOjDtc1rfxGYZAGNPePr/rALzI2Bvhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DM3PR12MB9285.namprd12.prod.outlook.com (2603:10b6:0:49::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.25; Tue, 8 Jul 2025 08:34:53 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 08:34:53 +0000
Message-ID: <6b85f85b-51e5-4e6e-9c78-788d9118ad9d@nvidia.com>
Date: Tue, 8 Jul 2025 11:34:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] vfio/migration: Add
 x-migration-load-config-after-iter VFIO property
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <cover.1750787338.git.maciej.szmigiero@oracle.com>
 <22e94f25448f9ff42b84c84df3960c4ecc94cbdc.1750787338.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <22e94f25448f9ff42b84c84df3960c4ecc94cbdc.1750787338.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DM3PR12MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: 74492f7d-55ce-4051-303d-08ddbdfa4f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVFsMVdlS1BicDA3azluNC85eXZLY0ZoTFRDVmZtd1ZtZ09vR0lJbzlrSDh5?=
 =?utf-8?B?YjhVVEF6QkVNSDJ4d0dyclA4NWhydG9kSzJ6SjkzRkFSTzJPZE80Z0UzbmNO?=
 =?utf-8?B?ekFURnc3WXR0a1JzZ2FsQ3ZuNHlieXBJcjVqdW9EaThYVzhhbFFhVlJwNG5C?=
 =?utf-8?B?VFQ5ZFJFdHpZVVF4R3VyK1RPNHg0SVcrY3dyMm5FcGRTMDNnR0MzbGhxUnU0?=
 =?utf-8?B?cEtoNUt1NzI0QUZ4Q0VSNEhxM1pEZ1dXdFBlcFR1ZE9JRmVveWJWeW52cUIr?=
 =?utf-8?B?SHYzdUpsemFXNTlFMzRJd0Q1MjBpckxibG5IenVBdjhycWdnNGhGdGp3VStP?=
 =?utf-8?B?RVhVV0dKclFwSFdMcHRoRnd3TW5MWjFqVlh0WllmK0QwMWJEcU1TT3lKT1hy?=
 =?utf-8?B?UUdma0JnSndDclIvYXJmdDNQQUZuTVM3b1B0T2RLV1NaNTQxVklVbHBsdVhQ?=
 =?utf-8?B?ZWpaZzVFdzFtcERiUWw4QWg0V0hCaTVrVE1DaCtFZWQ2SUtXcUx1WHdJVDh6?=
 =?utf-8?B?Vjdnd2xTNDE2T0c3Z1U1VVhnRDdSQk1BRGRuRGRMMWZEc1EvR29KbDh5ck5G?=
 =?utf-8?B?b3g3QndkdzBFNUpxeXU3S1VlV0I2YmI1WCtYb25PSGJUSkgzY2plQ1Ntbm9U?=
 =?utf-8?B?WitpQ2E1ZkRXWVJhMitkSkgveHJMVzhLUVlmOWNCUkY2UzFJUkZET2pTZHRj?=
 =?utf-8?B?R281UVJ4a3l4dVNiWUFzNW9iRCt6SFVPOEpXMmhicTROcFhjMElqQ0ltd0s0?=
 =?utf-8?B?Nm9Wek1mV3J5Z3gwTFY5TXZkRXd1YlVaUmw1N0pwVy82V3VKR2txWUhlOGJC?=
 =?utf-8?B?S2xNdThTdkRBcm9LN2dGSXRldjFyNDZlYWxzY1FadklVekZwRWUxVGwzZlVO?=
 =?utf-8?B?UWxwQVRUazBJTWtYYTErTTBCVzZSNTN6WUpQZzNQaExYTHJyN0UzNFFLV01K?=
 =?utf-8?B?L0Vtak9ZaWk3WEd3OVlXZU1wK1ZDMmdMOElRL1kvb2RPTHkvNWJNZHAvSFoz?=
 =?utf-8?B?YlliOUJzWVBQV3Y4N1hyYWp3NnNnTFBnNExmL2t5RXBkZjNpUUtxenR0L1hr?=
 =?utf-8?B?Z1YxTHJ0azhXQU51VERGOGExU1p6RGJoTUZhc3VTUTg0a1RTOWdkUTJnUkdI?=
 =?utf-8?B?QzZTOHJ2SmZHSEJTTHRRdTV5TC80M1dySXRxbmY4TFFjYkNieUk1TFNiWlZu?=
 =?utf-8?B?UFc0VHFDSGZqL05vTFFLVVVpbDVGNnAvaEwyT3pRU1NhbWMyd1JxRmlodHhr?=
 =?utf-8?B?L3daVjZMcFFPd0dyNEhzVkZ4dnFsNW5vbmZFcmh6WEM2ZktSYis3aE5QZmV6?=
 =?utf-8?B?Yk5ZUTByNDI2NHpRNVZMWGdlNnM2MjZtYjl6Y3RlWCtYbGIwYXJ5N3BMdlFC?=
 =?utf-8?B?MUZCSmVmKzNaSFl4NUtiUkFvOFRGVlRKajB0dUlaYTlUUU9PNUVoazRnVmtE?=
 =?utf-8?B?S29ZZGU1VjlPbXB4ckhpTWtwNWR0UDcxWWxQQzZuQTdMUS83bUgyWldKSmdY?=
 =?utf-8?B?bzgrcWJYNUhySG5IS2xlTUZ1MjlRYkcwSjVROGc3VGtFWUZJYU8wNm9ka3hV?=
 =?utf-8?B?RWlOWmVvc20wb2JrTlY0T2twNEhPWm1MeHVVemhVZzNobEVVaUQxSVU1eVRL?=
 =?utf-8?B?enAzNjN4ZElUUUh2SWUvcUw5VnQ0ZW9UOXlYZ2Rua0FCREZVYzdUbXVNTE85?=
 =?utf-8?B?QnIwYkE2OXhjbXgvWnFrbUp4V0hyLzdxWnprczJiUW5XOE9YTzFjOVJCUC94?=
 =?utf-8?B?cDdGUVM5SW1nNlJXd3lWTk42V2JkMmU5VDZOWW10QmZGaUg3SHJ4Rm9XVXFw?=
 =?utf-8?B?a2ZiVTRQSThtQ0RvaTNNNUZHZW9JRTVrb3RPc1JPYmNtRW9NYWN5aFRGNU9l?=
 =?utf-8?B?Um1IMFRjaVVlQzh1K0xiR3I3YThjNHphTTJIenVWSlIyc2d0ZlBDME5OdkFB?=
 =?utf-8?Q?nFidnJzqP8c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFp4cDIzeHBJSUEzMHJFZTB0anJWdllsYTIxRmxhSVpqTTc4YTNoVnI1VXZv?=
 =?utf-8?B?YWNUVHpoQldMUlNaOEhlV1llZm1NNTFjb0NCN3E5akxnRU1nZ2VBUThtWkdJ?=
 =?utf-8?B?L2VsZWhkVytRdzlycUxQdVFtNzBrTU1taks5eFc3eWl0b1ZKVUM0UzRVSEk2?=
 =?utf-8?B?M2tGSFdkUHB3ZFVpSmpwZFUvcGVUYjV3cDJ0bnllR1ZESThFb2FwM1NBcXZS?=
 =?utf-8?B?T0Q3d3ZscDR3UnhybkQ2WUpUQWpMT3dkYTB3ODB2UW51eCsvQlo4YWZPVjlr?=
 =?utf-8?B?MzF4cXBaNFdNZSttem5UQmZ6UUpYRi8wTEZOZndaM3VNdUJGTFFSZjlpcGFx?=
 =?utf-8?B?SGVWSExBKzF2Yi9ZV3pwWGtDN1FhN1hPWFhSZHByRlU2ZTA5R3pYWE1ST2Qz?=
 =?utf-8?B?QlhWVW82cHpqN2ZNQnhzOGQ2dGRTMVZxQUFzWTV3aFpVYzBoOTB6S3RabGEx?=
 =?utf-8?B?T2gvTGdVUEwwTzFhUmRxWWhJNURSTVlwNlBNTzJIUXJwbWlYRzNQRVpQUjFw?=
 =?utf-8?B?MVllaTMxQ3BHajJHQnB5cTYrSC9vc3FHNHVBOEhBeVZLK3oyV3hjYlplb3dH?=
 =?utf-8?B?b2ZSeWdkZ3ZtT1Bsa2dsQlNlY3pWMkUvcjZsYkNmQWc3ekNrOCs0SzJVbmJB?=
 =?utf-8?B?V3BSNW1adVJybHpKQ0pkT3pJcDBTSDAzME05Z0MwSkJrckwxalB3TWtUeU5M?=
 =?utf-8?B?NTg0emwzb1BGQUV6NldWbFRUbEF3eitZMGpiZmhsYVZQazNwazF0dGNBV0x0?=
 =?utf-8?B?eUVERmx6bjBPaExtSHl0UGpEdnUvdlFETlkzdENodTMrYU8wenR0ckE4QUtU?=
 =?utf-8?B?RFR3blJyNFl6cjFsbmkyOGdQeEZ5QXhNaCs5NzZzS2FrRWZyUWtVTU5tdUZW?=
 =?utf-8?B?TDl4OW9OazIwclpJdU5QSGZCcEFxU0lvYTA5alhFMVRqUlVwOWpobXAxU29C?=
 =?utf-8?B?ZUNsbDhtaGcwMGtmOGJYakFtbVVOR0FueFYxNjJweC8rMGtlcno4TCs0UkJz?=
 =?utf-8?B?ODRlUmlxZ3ozZkEwQWorNEUyVWlyaGJ3RnVNRnhqa0NmUUUyLzV6ZjExVUZ6?=
 =?utf-8?B?UUQ0aHdhYWNBSGtJRlBKeE5vRm4zenJnL0Q3YytSNXR1a05EVHA2RlhGVU5Y?=
 =?utf-8?B?ZDlMWjRncHRmS2dkZlVQNzd2VWdHSzlSbVNIc0xzSXVPbVcra3VUSGhWaWt6?=
 =?utf-8?B?dVd6cjVBR1h0QTV0UWsydDVIOTFzYmtUUmQrMk5TNmNFZWdzYm9NV29ReXNn?=
 =?utf-8?B?L2lNSTBTTGc2OFFKOHJBY01qNVB0UUc4OTFNcTBJeUIwYUE0cy9lSWpueXJs?=
 =?utf-8?B?RlVKNnQwMnRjaGl6U2QxY0w4WVdtYzdCR1IxVER5blFNQXozVm5GdGk1QmFB?=
 =?utf-8?B?bXJld1k0SnlsVEt0TTVPcFRZRTRIYS9ROUlJaXNhb1F5clpFR00velhISEFC?=
 =?utf-8?B?L1doY3dkT1lrRlgzVGZCNmN4KzZjUTMya3d1Y2FOY3FUdDlCNjZ5anVXVFJU?=
 =?utf-8?B?ZFZGSUZYVlllRndzelhSc2wzS0hPYWNESGRTcHpneVMzbzBBY2F0TlFlZDdW?=
 =?utf-8?B?c1VDRFVOV3BzVTN6VEswc3luTGJJQmp1Rm5Rd1ZpTDlyMkFBYU81YW43L0l4?=
 =?utf-8?B?MnBmS2grbFdhbTFkNGlMNHhhVDQxMTIra21UUS93b3F2WWFMNGFzeGEyd2tD?=
 =?utf-8?B?T2R0UWhSMlNCazdZdnNjSzlLVDVBY2oxOWVNZXdINFQ0L0JRdEtYc01HOUYx?=
 =?utf-8?B?SCtIUDFtR3ZqcE9HWXFTckRIcFZ3THozaEJKRzlhcG1sTnJ5MlhSWmxhMUkx?=
 =?utf-8?B?RVY2VkcwaG9scXlPQXdJUG5tRjA0Z05Ja21UQVRXMnBocytjSGFNdHJHRi92?=
 =?utf-8?B?V2JoZjdJVkwyR202YlJpMWZEUTNHNFZmMVlSRittZ0VFOFNnUk5NMDk3RzB0?=
 =?utf-8?B?cktJanhZNHFheTdBeU9uUjkzWE5wbThFZCtEejJwMlpPWjlOVkxNcEkrWC9G?=
 =?utf-8?B?ZVJ3Mm1KMWY4YWFBQ0g4R2tjc0RxemY4K2laRE43c0hSczBCRENIYnh3ZVcv?=
 =?utf-8?B?cWJXd0p0OFJ6SGNqckNRYjZhUU4wU3M5azQ4N2lGL2VscUdTZms3bDRXMjNx?=
 =?utf-8?Q?FOlRYfeZZFFnCvYz1TCs/0695?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74492f7d-55ce-4051-303d-08ddbdfa4f8e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 08:34:53.4819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SooqqYC6W46gD6tbTAo4Cf+chhSoWeEtj/r8saGeLfK06x06Gct97qKOYu0rXiI4BroFRcsnPmA2FypYQmSEtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9285
Received-SPF: permerror client-ip=2a01:111:f403:2414::605;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


On 24/06/2025 20:51, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> This property allows configuring whether to start the config load only
> after all iterables were loaded.

Nit: maybe, to be more accurate, mention that it is loaded as part of 
the non-iterables:
This property allows configuring whether to start the config load only 
after all iterables were loaded, during non-iterables loading phase.
(We can also mention this in docs/code comment)

Anyway:

Reviewed-by: Avihai Horon <avihaih@nvidia.com>

> Such interlocking is required for ARM64 due to this platform VFIO
> dependency on interrupt controller being loaded first.
>
> The property defaults to AUTO, which means ON for ARM, OFF for other
> platforms.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   docs/devel/migration/vfio.rst     |  6 +++
>   hw/core/machine.c                 |  1 +
>   hw/vfio/migration-multifd.c       | 88 +++++++++++++++++++++++++++++++
>   hw/vfio/migration-multifd.h       |  3 ++
>   hw/vfio/migration.c               | 10 +++-
>   hw/vfio/pci.c                     |  9 ++++
>   hw/vfio/vfio-migration-internal.h |  1 +
>   include/hw/vfio/vfio-device.h     |  1 +
>   8 files changed, 118 insertions(+), 1 deletion(-)
>
> diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
> index f4a6bfa4619b..7c9cb7bdbf87 100644
> --- a/docs/devel/migration/vfio.rst
> +++ b/docs/devel/migration/vfio.rst
> @@ -260,3 +260,9 @@ Because a malicious QEMU source causing OOM on the target is not expected to be
>   a realistic threat in most of VFIO live migration use cases and the right value
>   depends on the particular setup by default this queued buffers limit is
>   disabled by setting it to UINT64_MAX.
> +
> +Some host platforms (like ARM64) require that VFIO device config is loaded only
> +after all iterables were loaded.
> +Such interlocking is controlled by "x-migration-load-config-after-iter" VFIO
> +device property, which in its default setting (AUTO) does so only on platforms
> +that actually require it.
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index e869821b2246..16640b700f2e 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -39,6 +39,7 @@
>
>   GlobalProperty hw_compat_10_0[] = {
>       { "scsi-hd", "dpofua", "off" },
> +    { "vfio-pci", "x-migration-load-config-after-iter", "off" },
>   };
>   const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
>
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index f26c112090b4..a12ec1ead74a 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -17,6 +17,7 @@
>   #include "qemu/error-report.h"
>   #include "qemu/lockable.h"
>   #include "qemu/main-loop.h"
> +#include "qemu/target-info.h"
>   #include "qemu/thread.h"
>   #include "io/channel-buffer.h"
>   #include "migration/qemu-file.h"
> @@ -35,6 +36,27 @@ typedef struct VFIODeviceStatePacket {
>       uint8_t data[0];
>   } QEMU_PACKED VFIODeviceStatePacket;
>
> +bool vfio_load_config_after_iter(VFIODevice *vbasedev)
> +{
> +    if (vbasedev->migration_load_config_after_iter == ON_OFF_AUTO_ON) {
> +        return true;
> +    } else if (vbasedev->migration_load_config_after_iter == ON_OFF_AUTO_OFF) {
> +        return false;
> +    }
> +
> +    assert(vbasedev->migration_load_config_after_iter == ON_OFF_AUTO_AUTO);
> +
> +    /*
> +     * Starting the config load only after all iterables were loaded is required
> +     * for ARM64 due to this platform VFIO dependency on interrupt controller
> +     * being loaded first.
> +     *
> +     * See commit d329f5032e17 ("vfio: Move the saving of the config space to
> +     * the right place in VFIO migration").
> +     */
> +    return strcmp(target_name(), "aarch64") == 0;
> +}
> +
>   /* type safety */
>   typedef struct VFIOStateBuffers {
>       GArray *array;
> @@ -50,6 +72,9 @@ typedef struct VFIOMultifd {
>       bool load_bufs_thread_running;
>       bool load_bufs_thread_want_exit;
>
> +    bool load_bufs_iter_done;
> +    QemuCond load_bufs_iter_done_cond;
> +
>       VFIOStateBuffers load_bufs;
>       QemuCond load_bufs_buffer_ready_cond;
>       QemuCond load_bufs_thread_finished_cond;
> @@ -409,6 +434,22 @@ static bool vfio_load_bufs_thread(void *opaque, bool *should_quit, Error **errp)
>           multifd->load_buf_idx++;
>       }
>
> +    if (vfio_load_config_after_iter(vbasedev)) {
> +        while (!multifd->load_bufs_iter_done) {
> +            qemu_cond_wait(&multifd->load_bufs_iter_done_cond,
> +                           &multifd->load_bufs_mutex);
> +
> +            /*
> +             * Need to re-check cancellation immediately after wait in case
> +             * cond was signalled by vfio_load_cleanup_load_bufs_thread().
> +             */
> +            if (vfio_load_bufs_thread_want_exit(multifd, should_quit)) {
> +                error_setg(errp, "operation cancelled");
> +                goto thread_exit;
> +            }
> +        }
> +    }
> +
>       if (!vfio_load_bufs_thread_load_config(vbasedev, errp)) {
>           goto thread_exit;
>       }
> @@ -428,6 +469,48 @@ thread_exit:
>       return ret;
>   }
>
> +int vfio_load_state_config_load_ready(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIOMultifd *multifd = migration->multifd;
> +    int ret = 0;
> +
> +    if (!vfio_multifd_transfer_enabled(vbasedev)) {
> +        error_report("%s: got DEV_CONFIG_LOAD_READY outside multifd transfer",
> +                     vbasedev->name);
> +        return -EINVAL;
> +    }
> +
> +    if (!vfio_load_config_after_iter(vbasedev)) {
> +        error_report("%s: got DEV_CONFIG_LOAD_READY but was disabled",
> +                     vbasedev->name);
> +        return -EINVAL;
> +    }
> +
> +    assert(multifd);
> +
> +    /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
> +    bql_unlock();
> +    WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
> +        if (multifd->load_bufs_iter_done) {
> +            /* Can't print error here as we're outside BQL */
> +            ret = -EINVAL;
> +            break;
> +        }
> +
> +        multifd->load_bufs_iter_done = true;
> +        qemu_cond_signal(&multifd->load_bufs_iter_done_cond);
> +    }
> +    bql_lock();
> +
> +    if (ret) {
> +        error_report("%s: duplicate DEV_CONFIG_LOAD_READY",
> +                     vbasedev->name);
> +    }
> +
> +    return ret;
> +}
> +
>   static VFIOMultifd *vfio_multifd_new(void)
>   {
>       VFIOMultifd *multifd = g_new(VFIOMultifd, 1);
> @@ -441,6 +524,9 @@ static VFIOMultifd *vfio_multifd_new(void)
>       multifd->load_buf_queued_pending_buffers = 0;
>       qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
>
> +    multifd->load_bufs_iter_done = false;
> +    qemu_cond_init(&multifd->load_bufs_iter_done_cond);
> +
>       multifd->load_bufs_thread_running = false;
>       multifd->load_bufs_thread_want_exit = false;
>       qemu_cond_init(&multifd->load_bufs_thread_finished_cond);
> @@ -464,6 +550,7 @@ static void vfio_load_cleanup_load_bufs_thread(VFIOMultifd *multifd)
>               multifd->load_bufs_thread_want_exit = true;
>
>               qemu_cond_signal(&multifd->load_bufs_buffer_ready_cond);
> +            qemu_cond_signal(&multifd->load_bufs_iter_done_cond);
>               qemu_cond_wait(&multifd->load_bufs_thread_finished_cond,
>                              &multifd->load_bufs_mutex);
>           }
> @@ -476,6 +563,7 @@ static void vfio_multifd_free(VFIOMultifd *multifd)
>       vfio_load_cleanup_load_bufs_thread(multifd);
>
>       qemu_cond_destroy(&multifd->load_bufs_thread_finished_cond);
> +    qemu_cond_destroy(&multifd->load_bufs_iter_done_cond);
>       vfio_state_buffers_destroy(&multifd->load_bufs);
>       qemu_cond_destroy(&multifd->load_bufs_buffer_ready_cond);
>       qemu_mutex_destroy(&multifd->load_bufs_mutex);
> diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
> index 0bab63211d30..487f457282df 100644
> --- a/hw/vfio/migration-multifd.h
> +++ b/hw/vfio/migration-multifd.h
> @@ -20,9 +20,12 @@ void vfio_multifd_cleanup(VFIODevice *vbasedev);
>   bool vfio_multifd_transfer_supported(void);
>   bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev);
>
> +bool vfio_load_config_after_iter(VFIODevice *vbasedev);
>   bool vfio_multifd_load_state_buffer(void *opaque, char *data, size_t data_size,
>                                       Error **errp);
>
> +int vfio_load_state_config_load_ready(VFIODevice *vbasedev);
> +
>   void vfio_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f);
>
>   bool
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index b76697bd1a23..7c6436d4c344 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -675,7 +675,11 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
>       int ret;
>
>       if (vfio_multifd_transfer_enabled(vbasedev)) {
> -        vfio_multifd_emit_dummy_eos(vbasedev, f);
> +        if (vfio_load_config_after_iter(vbasedev)) {
> +            qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_LOAD_READY);
> +        } else {
> +            vfio_multifd_emit_dummy_eos(vbasedev, f);
> +        }
>           return;
>       }
>
> @@ -784,6 +788,10 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>
>               return ret;
>           }
> +        case VFIO_MIG_FLAG_DEV_CONFIG_LOAD_READY:
> +        {
> +            return vfio_load_state_config_load_ready(vbasedev);
> +        }
>           default:
>               error_report("%s: Unknown tag 0x%"PRIx64, vbasedev->name, data);
>               return -EINVAL;
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 2765a39f9df1..01e48e39de75 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3524,6 +3524,9 @@ static const Property vfio_pci_dev_properties[] = {
>                   vbasedev.migration_multifd_transfer,
>                   vfio_pci_migration_multifd_transfer_prop, OnOffAuto,
>                   .set_default = true, .defval.i = ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_ON_OFF_AUTO("x-migration-load-config-after-iter", VFIOPCIDevice,
> +                            vbasedev.migration_load_config_after_iter,
> +                            ON_OFF_AUTO_AUTO),
>       DEFINE_PROP_UINT64("x-migration-max-queued-buffers", VFIOPCIDevice,
>                          vbasedev.migration_max_queued_buffers, UINT64_MAX),
>       DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
> @@ -3700,6 +3703,12 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
>                                             "x-migration-multifd-transfer",
>                                             "Transfer this device state via "
>                                             "multifd channels when live migrating it");
> +    object_class_property_set_description(klass, /* 10.1 */
> +                                          "x-migration-load-config-after-iter",
> +                                          "Start the config load only after "
> +                                          "all iterables were loaded when doing "
> +                                          "live migration of device state via "
> +                                          "multifd channels");
>       object_class_property_set_description(klass, /* 10.1 */
>                                             "x-migration-max-queued-buffers",
>                                             "Maximum count of in-flight VFIO "
> diff --git a/hw/vfio/vfio-migration-internal.h b/hw/vfio/vfio-migration-internal.h
> index a8b456b239df..54141e27e6b2 100644
> --- a/hw/vfio/vfio-migration-internal.h
> +++ b/hw/vfio/vfio-migration-internal.h
> @@ -32,6 +32,7 @@
>   #define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
>   #define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
>   #define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
> +#define VFIO_MIG_FLAG_DEV_CONFIG_LOAD_READY (0xffffffffef100006ULL)
>
>   typedef struct VFIODevice VFIODevice;
>   typedef struct VFIOMultifd VFIOMultifd;
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 0ee34aaf668b..359d553b916a 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -66,6 +66,7 @@ typedef struct VFIODevice {
>       bool ram_block_discard_allowed;
>       OnOffAuto enable_migration;
>       OnOffAuto migration_multifd_transfer;
> +    OnOffAuto migration_load_config_after_iter;
>       uint64_t migration_max_queued_buffers;
>       bool migration_events;
>       bool use_region_fds;

