Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9B4E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkIA-0004fO-F7; Thu, 12 Dec 2024 09:35:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tLkI8-0004fF-AF
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:35:48 -0500
Received: from mail-bn8nam04on2059.outbound.protection.outlook.com
 ([40.107.100.59] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tLkI6-0001Ah-Gx
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:35:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcOXIfJoWklzNXaj45N+9fu48mqmjHnZepDNdFiMTGVwCnTe2sn850Hxt3GRJVO8eH2uw3y5BGm5VIRBoIaa9VZ7AaJGjDIwO5uK4RuOxW+y6B6op5UmU3elWC2vj+ZV+8VRirColg4JtgWp07m6KgaVFI5pSzBBQTjeqUKfnofEGL+nwy383CAUi9cINhHrKG64D9m01gMIhw4vj3HTgbRYI9BSbfaoifoc/XVB0aoNL8yAoescMWTKQgSIPVv1x2LfjUvibT6ejk2NJRs3ZFN3+1AezQcc3EIKwM27O7PNU114LPLCjSTRT/xUrlKRsmg/r0im7I2vQGN0SW8pAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YllmC5CdmLACVtzngR1uZfgOOt1v5EmhOuVPjoMTgZk=;
 b=iHuF/N9LAFPRrDRwQLuIxv70zjDuDzCbUr0x/OZ1Fqn882oqytyVsI5/gDXH3v1FV04RCWXwe05kgMzD14sMa7Ll8sKI/PtvBZ/vjV2pYYGTRQ8Uw88fEHK/hrUWPZfhwGD23/L3X0HV4+4WrCESnrDDEiA59khOC50klKeyBoctgcH5uU6Id8Qr7xbD5fZdA9K0VVayjr0LjHb4+bbV92i27yVxcWDuyMYQSplw3k38JP5ajueUozOizT1RqW3OmZOunEXSY0+4F/3nJv+Uuq2e9ftmbWAxHKMu2t5ZNUNXlmjtX/Tzs8BQ2RKx71DCAVoNC5OzUTXWBmjfuwbKlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YllmC5CdmLACVtzngR1uZfgOOt1v5EmhOuVPjoMTgZk=;
 b=P86cBfHufFY+lkIHuX64MKtEAv9oiS7sjt3XpMSvT91feEHnCb275h84+eI2B2jV811rElt3/OFH4zW77+MC9v9h3hGyn3wr0Ynww7TT2WBrNN+CQ8tsBG8F8OYz5y5N8xXQ7uWZyAanjvpO5455c3yg7OhKBLWEoOWqwSKkxB51/F/bvKj60DTuLKTc+4yc8DRItkfZaGIfYJfuB3x3iYurPtpSo0qf34LPqwiEeS84gKTJhCI+KY+7vAjX6AtjuYs1oLQo03MLeKKo5XmIkgaqU1B6a61mzctd+k2BhfKH7HcHwkZa8C3uGFoT9mfRFRpAp7fESlbT+dNibuuk0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 by IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 14:30:32 +0000
Received: from BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d]) by BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d%4]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 14:30:32 +0000
Message-ID: <5601b5a2-1f4b-49b6-93fb-7242a2db71a6@nvidia.com>
Date: Thu, 12 Dec 2024 16:30:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/24] vfio/migration: Don't run load cleanup if load
 setup didn't run
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Eric Blake
 <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <72424ece45968b1ae6b39750917a041867c415ab.1731773021.git.maciej.szmigiero@oracle.com>
 <9f27f058-59f0-4056-b19a-f613418e0760@redhat.com>
 <fd69d0ef-67de-4ac8-b00e-a68c4e2ae62f@maciej.szmigiero.name>
 <1fbd277d-c3e0-48f6-81b1-2a5ae97ed9a0@nvidia.com>
 <2e0ea3b7-2f63-41ff-a316-52681d6f0eb8@maciej.szmigiero.name>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <2e0ea3b7-2f63-41ff-a316-52681d6f0eb8@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::17) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:EE_|IA0PR12MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: e80cd610-0764-4b89-c688-08dd1ab9884d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZjcrdWxwdWpBdFMwVFBjSkE4QjZlVDhNVHQydytRcFZvcXR5cTg0WHl4VWhK?=
 =?utf-8?B?amtXTWxyU083M0tCempNSStKczYvWWpCdHgzemx4TFIweExBTkpycDVXVGdZ?=
 =?utf-8?B?N3lJVVdEWjJIbmRUM3JyVGhTMmlqdUdkbFg5VzRFMTErRmF5R1hudnplbmE4?=
 =?utf-8?B?OVNMcVZmZGdNK1hxcUNKdVd0RmZJWUNuZVdXMVVuUHdxZWhHUTJkU1ozVFZw?=
 =?utf-8?B?MUF3S20yeWRWVUY1blFkaUJKckRsVG9TMzBkcTdvOG9uVlc4ZXdxUEM2ZWJq?=
 =?utf-8?B?alJJUTFmZXoxUjMxQ2Uwc2ZhYnlEUG9ONWwzMEppMlRwVDdnQjVEOVhMdVBq?=
 =?utf-8?B?SUM5bTdvWGFacDJ4czN6UnAySU9xTE5KbFNDeXVDQnZFTUEycVVQaFgrUytU?=
 =?utf-8?B?dkFNRU1sMXIyTVVaRmNVU09lUTJJQUpDdDlaSFJjaEM3ZmFiT09mTm8waGZ6?=
 =?utf-8?B?cFQvdWFmQTVJZVdYOUIzUUZPZUMyUFJGaVJPemZ3aFh0WmZNUTR2UExzcDY1?=
 =?utf-8?B?cHFKRWFRVUx2T0swajNzWDFScTBMSFpRVjV5WlFFVjFuZDU1UlRGQ09Semo4?=
 =?utf-8?B?U0MxNWY0S0Y4VTRYNlVvV2FERGN5NjVnM1k2dnNZb1JheDNTN3dUZkJsVVJC?=
 =?utf-8?B?aWZ6aU1GWHRicnRwV1loQ2xzck84c1RWcmpseGNZVFZLclpNVDhuNEJGdGd3?=
 =?utf-8?B?bmF3WVp3S083MGhsclFvQjA4bUE1ZGpoaWQ2cHd6VHdlOXRBRkFOWm9pNlE3?=
 =?utf-8?B?NkxueTBUNVdGVkZvWHMzYWRRSkR2N3IwVlpIRERzK3IrM01EaDl2TzE0aGZv?=
 =?utf-8?B?Q2pBRDNzTHR5K29zTUdGYlhXMk5kRk5CUjRXK0liY1ViUGVmUWkveVJXeXdY?=
 =?utf-8?B?NmlpRFBzRHE5MGxtOXI5NytyR3BndnBWWkE1ekNrdFowSEwwNExhaWZSR1hQ?=
 =?utf-8?B?WHVWSnhDWmdMZFpBSjJ2b3Q2V1lnU29VNE1aUGV1SGdKVGMvQkxMZjJBZ0kv?=
 =?utf-8?B?UnhZc3FML0Z4NUUxZjlyNHJBUnc1TitCdnRyc05pUitDc25LeDFlTGhoejgz?=
 =?utf-8?B?eEhEb0U2VHZvUFoxU2I3N2hxb1lhUVc4dDZUenllMlN6ZFlNL3MxQVRVdW5o?=
 =?utf-8?B?ZkFpQ01OcjdES3pTY1BpcCtQYjB5YUEvY1RZMGlDUGFFeVhySTVlMkxEUHJ1?=
 =?utf-8?B?c1JKNGt1STR2eHIvemVrclRlMFhQU0lBemlmR2FxcnFlK2g0WHZmOGhlcjJR?=
 =?utf-8?B?aXZHRHF6QXRZanR1dUVDMnVrVEUwTDZRd0JZYi9EVVQ0VDAwN3c4cC9SaUtN?=
 =?utf-8?B?WUFNaVRRSEtaMGljd2JaRFJrTG5wQjQrWWtqRStObS9BL21JRlByRGp6LzZ2?=
 =?utf-8?B?aktWRTMxZUViaGZ3WEhuMFZrR1MrYzZ6UElSREY3VkErbnVpV1ZuN2UybDdS?=
 =?utf-8?B?akxVeXNnZXJGdkM3V2NteTVUaTRYempYRVpKbEpyNkFxYW1QY0NBUUNvMGxs?=
 =?utf-8?B?OFJyZkNxL0VpcURLalpMckJkVDNHeW5YbWZCZVdNOEVONHJCb1JwOWtybEYr?=
 =?utf-8?B?dmNKZjNsc2U3TGVYc2hNS1pqU0xvWXhIcVZSN2I0Y3pYM2ZMc0JXRE1OTUM5?=
 =?utf-8?B?WlNIMTE1cjZEbTJERm14WUExZFpOaDJCa2ErMUVpUlduOS9PNWEyRHdIZTh5?=
 =?utf-8?B?YkhlbUp5Z2FHV1o4dW1zbW5vRmMzTDlpZnhzbDN4dHQ4OHpQY0RHNDJEaHM5?=
 =?utf-8?B?V0M2N3NFb0h2TENxdERINmVnZ1JJUU5EeE9pVlZhbEwrd3JmdmVVcU4yNVNL?=
 =?utf-8?B?MFMwcm5zNFV6cTlVVEdOQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5544.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0x3QUlSUHNkSis0L2hWVHllU3NkT21Kam1XWjJBekdjZWZoaTBrbnBtV3Aw?=
 =?utf-8?B?UTc0L1FjeFkvUXU1M1oyY2V3ZHluMTdDeHVaYjZSbmE3Zlc1cjN5cXZxK3ZD?=
 =?utf-8?B?WmltTVFjWnpCc21obUhWaG1LdmpXbmVVZ1UwUW5xR1BOYVNxNUt5TER5aFFQ?=
 =?utf-8?B?R0g0RnNXYVQvcUVxRXRHZEJuNHNzcUd2ZGVCR3lKUE5DNUhPR1VTdlY0YU9Q?=
 =?utf-8?B?MnJGN2NpejBKK3BEUi9kZ1FNT0F1UDNIWGNyY1hQYVlHdFp2TC9DV3NEL3M1?=
 =?utf-8?B?b3hqNGc4QmJpc3J4OVZOcnFoZzBxM2RmdHV6YXp1V0NwTkYxMmN5OHVaaXVK?=
 =?utf-8?B?N3pOenRMSys4SVpyTUNPT2JTbVplWkR3RmgzdEZna0RsMC9Cb25VcENXd015?=
 =?utf-8?B?WVdkOWhnMjlwZ1RUOFo0eCs1M3N2UmRUa0pmeWxsb0xiQTdyQzF5Ly8xQk1P?=
 =?utf-8?B?MThIZFJob05iazRmVHFwR0RCcnplQ3VWeUk1NW1VVzNnM3pNWEV3dStQQ3VD?=
 =?utf-8?B?RnRReGZaTytxeE0yNnc2emdtUEl6dWY2UnpSR2FyR09iMVZqYWRmY2pyQ3hJ?=
 =?utf-8?B?eXVmSFVCOVB4SGNyRnlzb0NudlZjRERvY1Q0dUFqSVBBSnlHWW1wZ21tYmVU?=
 =?utf-8?B?Q2haSDQveFZoRU5tSk95RmVDM0p2cVp3QzlyMUFxQU5mSXNhMnBNeklFNWRE?=
 =?utf-8?B?ZmRpYmpLSUVUdFRzbHhWZTREeWd5c3JZSFovTkFOclM1WGlSY2JSTnh3N2JN?=
 =?utf-8?B?WUs4NjErRTk0TjIxYXMvOFlrN3I1RW42YUJGQy9yeVVGY1NXSGFJWE55SkV1?=
 =?utf-8?B?OXZnVkZGOXRja0p5K29hMDdmZzRiZHRZZEY1S0ZuYzY3LzJlUjhLTWVxSEl0?=
 =?utf-8?B?ZFRVSDB2SWVVRGtoRjRCWjQ3M1p0OGJQanh0bEdUL0NQYkRhV2ZqRFRCR3Bz?=
 =?utf-8?B?TFAzd2hBR0loUUNyeml5bTRFTDJMbTdaeUNCNTJUeGFNangzUEQ0bG9MemVT?=
 =?utf-8?B?Q3U4dDFtYW56K01aUTFjd25RSjBENU0xTDNyT0ppbGEzdS9uVHBHd2tobld0?=
 =?utf-8?B?SnRPTVd4U3NtZ2ZaSFNEYTVjUll3UjR1c2laWlB1YUk0U1JERCtMNnpReU1z?=
 =?utf-8?B?MVoyaVd3ekw4empmQVdDZFQ1dlBiNlNxWEd3Z3llRFBXdG9ESlN1Z2srZEcz?=
 =?utf-8?B?WmlNQjU5SU1sckE1bFAxWVhNMVphSkZUaFlBemc3K09lQzl5cGRQSXVUbitu?=
 =?utf-8?B?NnBBYkgvVG55ZFI4ajdjbjlaeGRjY0RFYThPa0tpWGNQaFh1cW54K0VZYnB5?=
 =?utf-8?B?T2JVWmF6SjBXRTRJL01NeTdVTjBmZi9WVndkOWNtczB3UlpEU29QdDVJUEFB?=
 =?utf-8?B?eTdrYUxCMG1COXdobzk1YVBzZEZUS25xc3F0NGdCUGljL1k2RW0yb2grVEdM?=
 =?utf-8?B?NEFzMmdaV0tYN1ZRRGxMOFVWTnM4Wi9QTk9QVXFOU21tdkYyRlBBaGZlSlFh?=
 =?utf-8?B?RE5aN1NhV3plSXMwUHd3TjRRVmd3R0dpcjRwWFpMWmJnRW45TE1VQ3dpcThP?=
 =?utf-8?B?M2hJdWNwb05aVEhwUlJ1Qkp2eU9GaXc0UmtVeUdzR00ycVJsMytFSmkrK1h4?=
 =?utf-8?B?TFlrWmJFc1BVcXg0dTNQZWhZZ2Z5dk1DeCtQRHVzTnF5RHFrQW0vRVQyZmVJ?=
 =?utf-8?B?UWxLV2tRZUhRTHpHM20yVEQrUDVWSktXQWxqUHF5R2F0ejRBMmhPc3NtSE1D?=
 =?utf-8?B?ZjYxYWtxczh4Y2tYMWxJM2RwczE1NWhpenJjSThUMWh1WEEzTVozTmM2NDU0?=
 =?utf-8?B?dFdrclZKaDQ2Z28vclVLRXkxUllHTElKcFhxK215UFBON095RXc5MXRWNEFT?=
 =?utf-8?B?eHE1bGc4RUh3QXNzZW1NOE02OGRkMUdIa0xYb0cwK09wYTVWUUFYRnkwbkxz?=
 =?utf-8?B?WmRtVVdvM2FQVFBYWjlvdUxNamxoRFBCWUlpbm9rc2ZzMHlTYkxXM3VyeFpX?=
 =?utf-8?B?czBPbis5bGZxeUZteG1Db1Q3cThka01JajJvNWl2eitTZzZobkxGNmlxUm5U?=
 =?utf-8?B?VFBsVFZmc0JFd0VRQVVVTFpZNnhxSkJaWDZTSmUwc1M5OHdqRUdIS0ZhTWVM?=
 =?utf-8?Q?5uBvglWTvKCyuuPhbPo7qJwRo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80cd610-0764-4b89-c688-08dd1ab9884d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 14:30:32.4416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCHimQZjqKFKey4KaW3ticPdUSHO2Yqi/Il+c/nuYOXSYue4ZGpAXeBY2tIgL5annkZZzuNCmJNKRguWLuVLgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601
Received-SPF: softfail client-ip=40.107.100.59;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


On 11/12/2024 1:04, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> On 3.12.2024 16:09, Avihai Horon wrote:
>>
>> On 29/11/2024 19:15, Maciej S. Szmigiero wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 29.11.2024 15:08, Cédric Le Goater wrote:
>>>> On 11/17/24 20:20, Maciej S. Szmigiero wrote:
>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>
>>>>> It's possible for load_cleanup SaveVMHandler to get called without
>>>>> load_setup handler being called first.
>>>>>
>>>>> Since we'll be soon running cleanup operations there that access 
>>>>> objects
>>>>> that need earlier initialization in load_setup let's make sure these
>>>>> cleanups only run when load_setup handler had indeed been called
>>>>> earlier.
>>>>>
>>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>>
>>>> tbh, that's a bit ugly. I agree it's similar to those 'bool 
>>>> initialized'
>>>> attributes we have in some structs, so nothing new or really wrong.
>>>> But it does look like a workaound for a problem or cleanups missing
>>>> that would need time to untangle.
>>>>
>>>> I would prefer to avoid this change and address the issue from the
>>>> migration subsystem if possible.
>>>
>>> While it would be pretty simple to only call {load,save}_cleanup
>>> SaveVMHandlers when the relevant {load,save}_setup handler was
>>> successfully called first this would amount to a change of these
>>> handler semantics.
>>>
>>> This would risk introducing regressions - for example vfio_save_setup()
>>> doesn't clean up (free) newly allocated migration->data_buffer
>>> if vfio_migration_set_state() were to fail later in this handler
>>> and relies on an unconstitutional call to vfio_save_cleanup() in
>>> order to clean it up.
>>>
>>> There might be similar issues in other drivers too.
>>
>> We can put all objects related to multifd load in their own struct 
>> (as suggested by Cedric in patch #22) and allocate the struct only if 
>> multifd device state transfer is used.
>> Then in the cleanup flow we clean the struct only if it was allocated.
>>
>> This way we don't need to add the load_setup flag and we can keep the 
>> SaveVMHandlers semantics as is.
>>
>> Do you think this will be OK?
>
> I think here the discussion is more of whether we refactor the
> {load,save}_cleanup handler semantics to "cleaner" design where
> these handlers are only called if the relevant {load,save}_setup
> handler was successfully called first (but at the same time risk
> introducing regressions).

Yes, and I agree with you that changing the semantics of SaveVMHandlers 
can be risky and may deserve a series of its own.
But Cedric didn't like the flag option, so I suggested to do what we 
usually do, AFAIU, which is to check if the structs are allocated and 
need cleanup.

>
>
> If we keep the existing semantics of these handlers (like this
> patch set did) then it is just an implementation detail whether
> we keep an explicit flag like "migration->load_setup" or have
> a struct pointer that serves as an implicit equivalent flag
> (when not NULL) - I don't have a strong opinion on this particular
> detail.
>
I prefer the struct pointer way, it seems less cumbersome to me.
But it's Cedric's call at the end.

Thanks.



