Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37ABC282D1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 02:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqNmO-0001vT-Da; Thu, 06 Mar 2025 21:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1tqNmK-0001vD-AJ
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 21:49:37 -0500
Received: from mail-bn8nam04on2048.outbound.protection.outlook.com
 ([40.107.100.48] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1tqNmI-0001Bm-8Q
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 21:49:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJr4s1/ihyPsJhvhkS8xWRqqK90r1tPgygReFZlF6auGDoRlKjUeskwAXzEZqs0U886zMNMBHxwoutqdObPhSWrDF1/vRCErChpTKuGx5kKCWuWcJFpFjN6dPxieau90g7BMJzkFTORfbLEPjtcketiQZMmpLcV+b8rVngEyQIAPYlOlEJ5KRQIJRSFFwbRq6vyKeTuw5UqbOyc6ESzPmSTGowNlhTFLebismaV3stVzYLUA5/jV7vaSAtdFb28GdiiceCZcO9gzwl0KZV/58d8f+QjQK6BHqlygNbJnorGaES443zY1OBr0g26E6fkRgnmoXUR0klAOh0YW2JxuuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TKn6z8IIQeWfFSPf17238W46+N2atlr8oaonnmzHW0=;
 b=uvQMH/shXBb1TiZ5EO06vy8yOTyjQ/TJomV02enyNY4Rv9iBdhDCL9DItLGkw9oroHzRWbjZAEQYncgFf8j4yYNmVk1GOubHw04+cWOHV3PmoF29nIwzUy4mmAb78bDhCJK+aMHh1/gZ6kN+L0b24X7W5coXnodlEjscO8GEdY+/HPH0alm9dlropb7aostZFL7yKbck4FeLjVbns5LRoI0DBIZZypU5PVbY1JyxoMbx/8knPAP+KdwSZkeZvwMTLYkMJ7SF1P/VXpQGuMPEjxRSxRRIhIoXP1ew4IRglOuiIz/M0InUxTI7QzxpIK3BFkTMikKXet3r/JkpQc1/0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TKn6z8IIQeWfFSPf17238W46+N2atlr8oaonnmzHW0=;
 b=G9fpqqk3r1fuaRfpw6ADNWXv7AN3wWWhWkdsY3njJPoFW2On5OEuMzn9XR/dHeyuPGmE05iiNSSc432NspzdluYrSDL5PJNo//X8LVtO4Oicb+IG2wuSvpg0WWs2zYGPjdJ4+Rj1gOphHel8J8e0aQX+IQgArvjes6SY408Iqvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 IA0PR12MB8931.namprd12.prod.outlook.com (2603:10b6:208:48a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 02:44:26 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%6]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 02:44:25 +0000
Message-ID: <57652cc7-41ac-45a9-b209-3b7446185310@amd.com>
Date: Fri, 7 Mar 2025 09:44:17 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci-ids.rst: Add Red Hat pci-id for AMD IOMMU device
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Yan Vugenfirer <yvugenfi@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, mtosatti@redhat.com, marcel.apfelbaum@gmail.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, vasant.hegde@amd.com,
 Wei.Huang2@amd.com, kraxel@redhat.com, bsd@redhat.com, ddutile@redhat.com
References: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
 <20250305015122-mutt-send-email-mst@kernel.org>
 <CAGoVJZzWqJt-XCOq0GSCg68HYp1DYEEhEUgE-c6a+rd0m-d+cA@mail.gmail.com>
 <Z8ljpeR9qcW5fhKC@redhat.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <Z8ljpeR9qcW5fhKC@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|IA0PR12MB8931:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c8bcca-595b-453b-e735-08dd5d21f95e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXlaek9oS3FtaVN5eHN0L28wYTI1RVVKZmFaWisyamFsOURIRnhiTW9IWGN2?=
 =?utf-8?B?ZkJlWDdZWjM0bTFMVU9lRG1mdXV3MFNHclpLMmVuRTgyaDRZSXZzdDl1RmhD?=
 =?utf-8?B?OWo4UU5iemxvclNDNGlHK1BWSXJxajdZcXJJbFlyVGdjMnMyQjVHRmlrRlFa?=
 =?utf-8?B?QWRMTFBzcVZINUZVbEdTbTNIYWhlR3BwSE9hR3d0NnVLNVVlMlZhaW82bjd4?=
 =?utf-8?B?QTFpN054RXdWT3g3cnRXd3A5aXNIWHIrVllaUGtub3F3dnBkZVF0aGFIdDQ3?=
 =?utf-8?B?V2JZM3VhTk0yYjVjcnBQQU9tTUlYWTZWeE5wTDJrL3NEK1p5bGNpQ2NJQk5J?=
 =?utf-8?B?R1BJMlB1SUVwdE15eUtmU2w0azBOZDVTRm93bUNLMmxDK0VDUi9MMEJXRGRo?=
 =?utf-8?B?a3AvcmlROU1wbjB5NHZPQWZXQVlmQ0VsOHdYaHpWNUp1NnRNRDJFZGtXcWp2?=
 =?utf-8?B?ZEZuWW5Ua05TSXFwWm5kVGFXUUVjZDlYOGVGTjFNQ0FCQmdGMnd0REJaOUJr?=
 =?utf-8?B?OHYvS1hMTzVOUSswTGMzTnByVnpiZVZqbVFNYklzaFlHb2c1MjUyWDJ0MVdy?=
 =?utf-8?B?bXZvUnc4MkJoSXJWMFdHMm1uU2R4S0RzNmw0RXFIanhRWGRiV0ZtVGpPaVJw?=
 =?utf-8?B?KzBrRVoweWVWempHK0FheWhhM1h3T2dMS1phNDVyWnJiS3NuWTlrelNYQWFF?=
 =?utf-8?B?OUhqWWxpaGNqeFh2eWF5Q2RvUTFpR1N1bWRKdUZxNjJNTEtxcXNnNjV3cGd5?=
 =?utf-8?B?V3FtWm5hazUxZmNkMkRNZUkxMk9vSG1zMy9TL1FZVlNxR0Z0K0ZlMXZLcWtr?=
 =?utf-8?B?cUMyNFFyTi9hOW9pTkJPNlBPTlhhdk92QXFiL2o5MlpXWUY0WkMza0Mvamw0?=
 =?utf-8?B?dHB1WnNtZmFGTW54dGJoK05QdU56cnFKSUcxV0RPbWh1SGpnRVZ1REhQVWY5?=
 =?utf-8?B?dXExV2ZjV05rSHlVcVpJRjlMd2t2TlVwbVdsYzV6eDNiS0t2bkVIVWozSkda?=
 =?utf-8?B?Q2tkTTNLK0o1UTF4cHRrMUQ1RG1rL3V3WUk3YmI4OVJTd1c2WjFWNWxwdGdo?=
 =?utf-8?B?OVA0RnFZQkUxaVJWUyt5cDJBSmp4ejc5a1pPbjI1bndScnRDMmFiTmo3K0w1?=
 =?utf-8?B?MGVxdkZFRzVPNGExWHZ1cTNSTnM0SmVhSUxZRzR6U2xpcURkTzcvcnVlNzBR?=
 =?utf-8?B?YWxnN2VWdE9lTkx6Z3B0Z0RNQ05reWFNamppdkdyWlFxWWxZNW5SY1U1WXN2?=
 =?utf-8?B?ZnM2N3pzY1JKNytlNmRTbHJSeVl6djhyNHUvMk9hZzdQYmplWkRtMUFRYnNN?=
 =?utf-8?B?MVZvb3pjQXo3ajR1cWVSOXNyM2pHVlVVaTk2TnVUWjh5dmtBdmhrY2F0NEhq?=
 =?utf-8?B?V2lkdTgydmIwWUxkMnFxZzRwZ25HbHZxRXVCOW9pbTFSVm1UMDFGQTY5alJM?=
 =?utf-8?B?NnAzNGg2ald3Y0Z3dVdRbzJsUDJTWklOMVE5NG5FcTlzK0V2aXNqK0pyUUZx?=
 =?utf-8?B?Wi8rOTJEUm92UGFvYlQwOE1VRDE3TVdxUkE4L0ZIb0hUTXRaY1R3emFORHVt?=
 =?utf-8?B?UmJEZHZRWnY5NDlSS2RkcTNYYy85TDJSd1FxYXlvS0FiaDVpVG5QbkNzY3Uv?=
 =?utf-8?B?QitROW9FSVRDeis5NUlsZmpLQXgvWERiYldNNWFNSzhEQWR1N1hRVDhaUHFX?=
 =?utf-8?B?UnRRZ3ZNbS9vN2JEQWhWODkrcVlEaUxsNDJwTmMrM1FQMWt6aW1lTnIvQUJ5?=
 =?utf-8?B?NzJvQmdsbEJmTUthbzk3SUdPZ2IxY3lOM0FiT1hpaU5tVGw5RW5FbG5ZNTdP?=
 =?utf-8?B?UHltaTRaYURpazI2TDBSU0xKN3NuOFBKZ1hGalRoMDAxTExlQjIxRVpCQi91?=
 =?utf-8?Q?H3Stlwkk0i2db?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVA2QjFlQkQxNE9oWVVRelQ5S3VlMCsweGYyb0NxVjNtc2Z4VEJJQ3NtVnQ2?=
 =?utf-8?B?Mk5BbWJqenhoaGhJQUk3aWRCZ2dwVWplcllNS3pjUnNONmhrazVVS09obDRm?=
 =?utf-8?B?Vmd1cm9uZ1AzU2ZhSzdXTSthWUltZFcwYXltOHNVMnp3T3RiNWxmU0JtTisw?=
 =?utf-8?B?ZEwwZ2RWWEErR0V1TmgzQWlMYWVLM0tyOUdoOW4yRnlUSi94dlFaZ2hFQVAw?=
 =?utf-8?B?VFJzRE13d093dEpubXFQUThmT2s1S3NlWmNKaDdqVE1zMkoyYmZZL01tN2Nj?=
 =?utf-8?B?Zm4rSkhFN1IyTHpFTW5kN1VTVHVHQ09nOEV3UmxTdW9NekVCdTY5YlpMQXl0?=
 =?utf-8?B?N3pTVVM0QnZmc1J1d29CcFc4WDd6cEp3UjhjdWgwZTkwVVJaSE1JWm5KRERC?=
 =?utf-8?B?VzRTRVBHSnVUL3FUTTB2TFpiSlgvUnBBL1hEcWZmQi95RlhwSVlReFlFSWFP?=
 =?utf-8?B?elNwOHZYOWJsZ2JiaDRuaGVVUnd1SUUzcnY3ZlVGaTB5L3lhSDRoUFhlSksz?=
 =?utf-8?B?MjhveEc5T0tlRHpDRGllRnJIanY1bFIxZDJUeml4YWNDVk5oRnFjdjRtdnpV?=
 =?utf-8?B?NmFiYUxNMXVCMzhrVEdoWXI5Qjd4eWJ0bFlnNytpdTluakpxVktyOE95VE91?=
 =?utf-8?B?Kzltd0E2czZ0UGJVUDRINjNQS1g3K2hrSElnMHRrWkgrWUxvWmFBcjhuT1Zo?=
 =?utf-8?B?a2tLTFB3c1g2bTh4aHBKeGYyc2t2aGVhUzZ4ZFI5M3c1enVLUElQNWl5eVg0?=
 =?utf-8?B?Uzc1SlhPL3dKWTZCbnh5cTVxK2p2RTFpRWllV211Y25iYU5lOG5Xb0FxTFN3?=
 =?utf-8?B?MStWZzFkRENOV2xrNVhaMk5Cd0xKWlNuMWQwZi9TM1BIa2xHcGZjSG5JR1F6?=
 =?utf-8?B?WDVpVXRSZk9HMTNBZ1RRZVpwRkJkWDh1UHJMK1ZSR1Z6ODlRK2hsRndwb2Ex?=
 =?utf-8?B?YjQ1Tzg2Y3ZoQlg3TTBJYUpzYmxuZ2lwM2RtZHM4TlJKZVZqYWdJa05rZ29s?=
 =?utf-8?B?bGdoNXhZR05ZU0FCS2VLdUJtRnQ3U2h3SldkeFJ4ZE5sYVBzZTJmM2l3NmdZ?=
 =?utf-8?B?eWV4MnJneWdKRG5MVzJzQXg2NkFhZitWT2QwdExVd1hKeG5TaTRmdU92S09s?=
 =?utf-8?B?UkRjWGMzeGZoZXFIUHZBOEpicFcrZTczZTZLZFBKbGZNVjB5SEM1aHpGaVRI?=
 =?utf-8?B?L2FmR3diOXBweUxMRTMxbWpYZG9mbER4V0Fmb1hDd21nUC9ickZLc3ZZbHBQ?=
 =?utf-8?B?dHlZbDJ5RG9lUVlFUEJuU0MzalA3Q3BmUXJxU0c4RlBpRkZxcWtzdklxNm41?=
 =?utf-8?B?OTNiZzhQY3g3V1g4dTdKYWE3S1ZNYlAwTkU4TnRaOVp2b0dUMC95dzBGTURY?=
 =?utf-8?B?eE92dzZmZ2lKakJKR2tYYVE4TlB2OFFnNjJIRHd2SlJTclRWUHVrRjIyN3hL?=
 =?utf-8?B?Q3pUWWxROU02dTZ6NURvMFhCN2Jqa3FMQTFLQStSNklLaW5lSXN1YU8zZXJL?=
 =?utf-8?B?UFVKa3ZNZFdZNWoxTWJRWUcxUmdEazRmd2lueEx6Tkt6YXZYWU5UMHZ5bVJt?=
 =?utf-8?B?STVxT0NicFpXK0NTUEZBV0tlVHdnQlRPNDlaU09WWVBiS2h2RDZ5RGY4SUdx?=
 =?utf-8?B?L0lSbXh0dzZSaFV5aTdoNE96T2RzWEFwbERKZ3BoT2QvSFFDVHJ3d213RXd0?=
 =?utf-8?B?T1FrYmtlcUFLeVYwZDBRaTE1SXNaQWtaZXUvWTVsTXZvT05BTXpGYjFmcEFN?=
 =?utf-8?B?clFadzBvb0xGMzhyZVFManhYSlFVSDZ5eGVOOU5sWjdlWnhpd0lENTVtSW9i?=
 =?utf-8?B?R04vN0pLdTBVd2pFT3hGSitKTVJzUURLa3k5Qk9GTFFrcEI5aUxvejlIeWxP?=
 =?utf-8?B?WTFaMVFSVWFCNDFWMGZhV0JBekx2MFBFaEZSYWg5K1UzaWxxenlqOTR5SS9O?=
 =?utf-8?B?aWtYQkJ3aE9oT0JxUmpibUJSNm1sNGRqay9HVkFpKzFIQkc1MjJyT240M3BI?=
 =?utf-8?B?YjlvVnBYMHBVT2FBaHNQNkpZUUtXcDZ3QjBMd1JZNkhKWTFyUkRXNEVJcFpl?=
 =?utf-8?B?MzJ2c2pPeDk0QjdPVllkUVlCZ3pUclBuVTRCSDJ4emVNZmNadFVsU1dyRUg3?=
 =?utf-8?Q?GGjk5zrJAtlQgFoXewdZdeKCF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c8bcca-595b-453b-e735-08dd5d21f95e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 02:44:25.6840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5uzSI8HMyDx4opeEFb3uCZjJQ7alKNyQEz2E343ei6Cq2XD51hLFJkNeMtsJurH+dZZ+ki8CZlTwLC24NlK5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8931
Received-SPF: permerror client-ip=40.107.100.48;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 3/6/2025 3:58 PM, Daniel P. Berrangé wrote:
> On Thu, Mar 06, 2025 at 09:11:53AM +0200, Yan Vugenfirer wrote:
>> On Wed, Mar 5, 2025 at 8:54 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>>> On Tue, Mar 04, 2025 at 06:37:47PM +0000, Suravee Suthikulpanit wrote:
>>>> The QEMU-emulated AMD IOMMU PCI device is implemented based on the AMD
>>> I/O
>>>> Virtualization Technology (IOMMU) Specification [1]. The PCI id for this
>>>> device is platform-specific.
>>>>
>>>> Currently, the QEMU-emulated AMD IOMMU device is using AMD vendor id and
>>>> undefined device id.
>>>
>>> undefined?

Currently, QEMU is using vendor ID "1022" and device ID "0".

>>>
>>>> Therefore, change the vendor id to Red Hat and request a new
>>> QEMU-specific
>>>> device id.
>>>
>>> Won't the drivers fail to load then?
>>>
>>
>> Windows will not identify the device (it is a dummy device, without driver)
>> and SVVP certifications will fail as a result.
>> I suggest using ID that is already present in Windows machine.inf:
>> VEN_1002&DEV_5A23
> 
>   Ven:  Advanced Micro Devices, Inc. [AMD/ATI]
>   Dev: RD890S/RD990 I/O Memory Management Unit (IOMMU)
> 
>> VEN_1022&DEV_1419
> 
>   Vendor:  Advanced Micro Devices, Inc. [AMD]
>   Dev: Family 15h (Models 10h-1fh) I/O Memory Management Unit
> 
> Is our implementation semantically a match for the functionality
> in either of those real hardware devices ?
> 
> We shouldn't use an existing hardware dev ID unless we intend to
> emulate its functionality as a precise match.

I agree. We should not use the "fake" ID unless we know for sure that 
the QEMU device is a match from the list of supported features and 
behavior (which might be implementation-specific on different 
platforms). Currently, this is not an exact match.

Linux does not care much about the PCI vendor/device ids since it uses 
the information in the IVRS table to probe for the device. Features are 
determined using the information in:
   * MMIO Offset 0030h IOMMU Extended Feature Register
   * MMIO Offset 01A0h IOMMU Extended Feature 2 Register

However, we can't guarantee how other OSes might be using these 
information for probing / loading drivers.

Thanks,
Suravee

