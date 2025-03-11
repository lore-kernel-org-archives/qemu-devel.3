Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1568C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 16:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts2E7-0001sZ-42; Tue, 11 Mar 2025 12:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1ts23C-000515-Pw
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:01:56 -0400
Received: from mail-bn1nam02on2060f.outbound.protection.outlook.com
 ([2a01:111:f403:2407::60f]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1ts238-0005ut-QP
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:01:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3SOmx0jV/mCCAhaHZYAxqiAufh1lt33TYVAgM9J4c3K4ezNEfsLdcL4/SpquaSst/EcWDTTuOA/El66bc+spDKQGgJBWKtvTmXhME+Vs/Fvdnp9HrMSrN0ndMbr62a6ATO84fjGjQS6gx09e8UBV3VRUyFJ7Rq38ibSbBoKbKD1BMy0oUT5xzmbdVPLiRm2tc896+oWe87wSNF2WwuhqjicIy24oDVy0c0W165JIa59AAlLSJQMTz7bVYUAulswEn+4k5NqyURIvM+CvBPJWNDJnU2SXWTP+ymvWuLvSBjxSqo+3NqUsVYPXIER/LuSY3xJB5ZtwkEv9bnwV5EamQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1zuhzCxKCq/kOsIk84CUw50QwNFVgjB3f6x+GIWY+I=;
 b=jzk9GXbUIOGdAS+mDlgBYJ7s3eMAA1lmxZIYDQefeAIlXMWOylkmGHY9yYHZxiXk4sdG1A6SfVUCzxidnkIJCoy7/ARahEhbUO5H4g8f5wf/kL89Gw7khxUjc+bF7yrx8CnQfYPkzdlXTENJI029mm3xwQ415rJWd2bgG9uVAR59myTGHOcPz3VRamBndyL4l1sXkM0nKjUnulLzoCtopFzNICA0mWccNQRppEIS9zJjA2y8rOZ2y6dYEK/Sv0yWt6f7gPcGyNMhPik2m5SqtJ+UH89faFWlQ0UZSBtKg/v84O/lLp0kJEVi+BPHLnVSa725+aKMHhHN2IYqyh2rPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1zuhzCxKCq/kOsIk84CUw50QwNFVgjB3f6x+GIWY+I=;
 b=OJbeAjrpNSOkNmxnCth5mnDRgxyNF8xG7R/bwDXhtdiHgaz4XNwqL38wGQyOqaizd03pSFOwAEJwKZBTGj8ZCjkpcTCiXcq2ZRGN5U+6sHR4XBivtkWq2naxyrKVhAmFGOLdi7EujLsovZBTg/za4lpcNfWI3uOGmK6XXdQtw26QKt/Gfdb2DencHbgbb2sNBuJIb/GjasdrSJEVMeS5Fnrr+qoETH06TWwzvE4mT9i9h2WMpgDpX0t0+5J9ilsME4FN5khkyBPjChZysUjElrv+q2m5jnGVJEOpMsBFZXZmUhx/i5xcTwh2gOaJV/ttTY92FZMi9Kp/Pnk4tQE+lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 16:01:38 +0000
Received: from BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d]) by BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 16:01:38 +0000
Message-ID: <538afa76-7456-44b9-abac-c238dbb0e64c@nvidia.com>
Date: Tue, 11 Mar 2025 18:01:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio/migration: Add also max in-flight VFIO device
 state buffers size limit
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <2b2469939198c2f31dba33b284576d2df22697b7.1741344976.git.maciej.szmigiero@oracle.com>
 <abc049f2-3497-4557-89c8-74bcfaea221c@redhat.com>
 <3826d47f-d79b-4db2-9719-35f48f582bf0@maciej.szmigiero.name>
 <fc547687-b313-404c-a6a6-dd599b0a9dbc@redhat.com>
 <bdd69682-3d0f-4687-a8a5-43a6cb4cecc3@nvidia.com>
 <fad3dd28-d91e-4add-8258-5918127e9346@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <fad3dd28-d91e-4add-8258-5918127e9346@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::6) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:EE_|CH3PR12MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: eea0a148-7ce7-4259-837e-08dd60b5f867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzQ2YWQ5RnNNeFRFRFJYTXNoeDlFankvL1I3Z2U1cUs1clV5UTBVY3pOekd4?=
 =?utf-8?B?TjFsUGdVek91bGZ4a1JDQ09KUTJ2QVFCanB2ejV6YStmSGpoM1FnOEhRT1Jl?=
 =?utf-8?B?MDRtU01QakJJd0NTRER3Y05SdTYvUy9UbFk0V0dpQXc1ZmpSL3VyRGpveE5p?=
 =?utf-8?B?eE0ra05HNWtvU25hdldyeTJZaUdPKzJGOC8wTjl1aFRlU3AxNXVRYWJzOWhx?=
 =?utf-8?B?MzVJbnhDNHlXcWZYK21oSmdBbmJBajhTRFpmQXZHT2llZ3lURDNueDd6QVhT?=
 =?utf-8?B?ZUg4a0ZyQkJmb0lRenA5cE94SXd3akhGL3hRZUhjWXp3d0UxUlJQb0ltRHN6?=
 =?utf-8?B?blRYd3NSUVpScHZzTnphRlhLakJ5K3lCeXM5WFdPd1dGdSsvaUNuVFh6K29Z?=
 =?utf-8?B?aWxYdDRaRzFDUjY3bU1iRDJFZ05ScUdNVHc2ckRPSmJyOUZEY05RK3dNS254?=
 =?utf-8?B?TGZRSGQ3YlRHZWVKM1lwdWR6STl5STR0WXhPOGpqY2EwWmlIRXNUcXdqbEth?=
 =?utf-8?B?ZVZzcWx4eUpnNzVVcVpsOHlGWHhXWUh5VUhjUlhzQ2d6YVJCMXNTcDloMjds?=
 =?utf-8?B?MEpjYTNSbktLZ3JIRmw2ZVJRUUl2NyswdHd0dWorR2U2dmZHdlFpSFVGMnFt?=
 =?utf-8?B?V3NaODFhWlRGb1AyYVljZWRXdXE0YmxwMmZ3QjBQVnlLUGVVMklPR2NJQ2tX?=
 =?utf-8?B?R1R5UCtvZjV2TmNZc0U5Nnp2a0MzaFgrekVwSm9PVGRtM3FvTEN0YmNVK3BX?=
 =?utf-8?B?NGtkTXM3L1hXRFN2bkN1OGRIUXJ5QnYwVjJIcnUvdHdsbEthemZNUklDdDRi?=
 =?utf-8?B?L25IQndkRGVhaEVPM2FnSExKSzQwa1pjdzFUU0hwOCtZQWFMOFNYTll1d1cx?=
 =?utf-8?B?dEZ4L1R1TzFMOVZCTFNQeFpPaGxxa1Y3VUZtL1NRMWZTaGpVcFFDeTJ1ckMr?=
 =?utf-8?B?L3JPVmVkUTZuRkNaWCtoMGRVeHppbjVHRjhVazJ2NDBndG5hSjRXTjRudlc5?=
 =?utf-8?B?VTNjd2tNWTNNVkkyaWVDcHd0N2RsWGdSWjNKcys2K1ZmZk55VWtvdHIyZ2Er?=
 =?utf-8?B?bW01NXZ6QXFveTh3UWk1bjdKM1Jjd3Nvem1qZFBFcDlyRXpDV21vZ3c2M1pn?=
 =?utf-8?B?YU5IcGE2SXBrRnlSUmwrcnZ3ZTl1NktlNzBWT0RmbDlIMDR1VUJhVVBGZU55?=
 =?utf-8?B?TXF5UXNCVk13eURWUDFKbC9rbS9XdTN6c3gyQ2ErSmlTV2ZOUU9aSGROUHZ2?=
 =?utf-8?B?bEdDdlZ2ajd2c3JJaUFxUkttcVRsVzhpNGpncVVGaWdsbjE4ditqMVpaWGZK?=
 =?utf-8?B?Zk9lNlc5OWRvRnIvc0Z0cjBVVFpzS05ZZmNIeDFyUlJodm1DUlVoN1p6VUd4?=
 =?utf-8?B?bUtiWko4dzVBQlZIMFBpTjBoRDVhM1JRdW5DMHdJWHJ3bElyaFFnVnZ6ejhy?=
 =?utf-8?B?UDAvZUF0Nk51eUxwYjEyQjJGODlzVERhRmVvZmtCR1pKVTFtelVFdXJ6OGEw?=
 =?utf-8?B?bkFYMDI4ZE5iSGsySjB1Z3dCYzlVVE1RN0NLZExlampIQVVHMmx4R2VrUlZC?=
 =?utf-8?B?eWpNdHUvYXI5eFZFcXI1L1Fvc2xjTnMxcXBYaHFUWktpSXJwUW1UdGxHU0hj?=
 =?utf-8?B?Wkx2amdPRTVIVXhzdW54eWlWZnZNQVN0UHZpYXoycjJCeU5jUDJzbUZxaCtX?=
 =?utf-8?B?MlVUeWp2N1dMOTg1d1RGSUkxNWxWbURadjdjWWd5U25Zd0tOY0liM3FZaUJ5?=
 =?utf-8?B?aUNSVkdad0pUV2pSM1ZXam5YeE82eHliWEMzbzFKOXpZNkxFTWQxYTQ3djh2?=
 =?utf-8?B?WFVxYlBxRjU4bjdqV05RNHBLMmUxRytvWVE5ZTlVNjVaTy9aWG50Nk5STDRY?=
 =?utf-8?Q?K/NAFg4y5pn+9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5544.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk92aFBDVU40dTJUZ1MzR253aVQ4alJndjVhbDhVd21rQU5VOTNVWEhFMHIz?=
 =?utf-8?B?ZHlXMEpsbzB6cG10UkdiR1RnZFlGekt3NWU3c1RiWXBtYVh3QUJxaU5YeGZM?=
 =?utf-8?B?TisreTh4Q3JNM2FYU0dFd09TSURHZitha3NWUjZMUmQ3VnVUTVhmdFZQSXRP?=
 =?utf-8?B?T1A0dktEdXlxOHIwaXBwR1ZZRnZuaDRuZFpHbUNwdklYV2N0dXVUVGFmNVVQ?=
 =?utf-8?B?b1hLNXFmeXkrcHhvR1psVXlhczZDRVI2eEJoLzUrR1VSeC80V0gvaDJVWTJW?=
 =?utf-8?B?OE9xZ2tWMzJZb1ZWYkZucGJ3ZWF0dU04TGdvUmx4S0RjVWpLdUw0UWhZaGp0?=
 =?utf-8?B?MmUxZ3BXWlo0MEZnZW5QWkdtRGhlNkk0b1U2MlVDQk5NUmFoYnVmckJBSXN4?=
 =?utf-8?B?TnpzanhuN2NaRTZLS3BTeXgxeFA1Ni80WTNxamR5R05GaEorb2ZaWVpNc1pY?=
 =?utf-8?B?aTVqUGEveUdxcGlkMTdQbEZzUUUvQkYrVWhzak9HWHZUUDlqU2RCRUZSTGpD?=
 =?utf-8?B?ZUc3d0t3d2V6TUxoK3dUVzhUK3lYL2VjYnl6MEs2NlJtWXVQTSttK21mQXdF?=
 =?utf-8?B?WTcwYnZ0dkw0ZWI2VEtaRE0xeVZIMHdESGZZZldYYVdtRDBKaXJvMGFDeHhX?=
 =?utf-8?B?Y25vU3d3aWJGRzhkemtRL1l5WnVmWlp5U3hyTDUyRDJnMDJocVNSTGtxSnZS?=
 =?utf-8?B?NFQzOFJjVXNwSVRtNGJBUEdoMnp5MVhTOFFnbml3M3Y1UzA1TzVnVlkyNStY?=
 =?utf-8?B?KzdlclRJZytWK1NZMGJPd1pyb2s3bDN3M0ZYb2RwQkI5RE5pT01HZWRDYlgz?=
 =?utf-8?B?NXZVYkQ3V0ppUktXck4xUWZUVWszaEhkdC9ENjFNb1YvM1lGTXZHbkMzRk5N?=
 =?utf-8?B?a0tIQjByTlQxWityYTN5ZHNUOHJUQnhHQVUzaGI1QlhrZnNBT0xVdHlPNlJj?=
 =?utf-8?B?WmRibnNSL0xUZnh0ZnNiYytSLzExbFFiY0lHN252cmthSkp1MmE5SFJOcEZ2?=
 =?utf-8?B?K0F2UkRPYXVkQmJUQnd4UStzdC9iZFMvTUlLTncrN1AzN2dERG80ckJraXFR?=
 =?utf-8?B?YjlaZUs4RXlSelJOMGs1Y3FzWnErVzRrYkQzdkVsTnFZOFlMcVJTVzhTNThk?=
 =?utf-8?B?ZG56czByRnhBSCtKaCswREdCTktyZ1RncEk5OW1XdkhBdTA3a0FuQnhienMy?=
 =?utf-8?B?VUZPc3pMRjIwRmVZV2NOQnZJSU5ETVcrSFBTa2lUd0hsSHVQTW9wSk5UZHJB?=
 =?utf-8?B?OTZiVWdZenZXUi9JUDd4UU40akVTYWpydDVhVWF2RVQ3S0FqU2Z2K0xsdVMz?=
 =?utf-8?B?Mk1vL0o3NHFIeXFiUUY3OUkyT041Z29MU1JmWU5aMDQrNmxvMGhNNU5HV2Za?=
 =?utf-8?B?WnVST0tnWUp1UHdUSzBKbzZvR3U4TWFnWWYyNHF1WHRmQThsemZDcHJGYlY3?=
 =?utf-8?B?aDcwSDE5NXpRMkNXc1JRWktVOW1SRitQdFdaM2U1c201OGh3QmVPMGs4b2kr?=
 =?utf-8?B?elFxTGFHcDBzOEJyczQyVTcxd2Z6akxWZ2tyUWk1czVSZWwrZ0ZyZDJNN2FO?=
 =?utf-8?B?NFUvUEhuOE9EQnJFZEU0UDQwaDZFdVdsWWtsQ3hHNi9Oc1JXOWhLZ3Z6czJV?=
 =?utf-8?B?L1Y5bHlkdlpqUWQ0clluZVh4SmNxcjNxQWdqZW1PNEJmeXRFb3o0cHMyMUVU?=
 =?utf-8?B?MklVbWJ4NW1CcVlxZFRrd2hDaGJWc3FEMjJVR09qck9PMGFKWkEzMXJMcDVH?=
 =?utf-8?B?NTlLdTdmcUd4WEJNbllLYVA5a3k4b1NyYVJiUjUxbll0cTFxYXQ5MUMxUXNW?=
 =?utf-8?B?aFgzRXo2Z0lab1lnbFk2Yml1eGt6c1d6WE9FRWcrbys4SG9vYjVEZlIxRDdZ?=
 =?utf-8?B?VG8yUXN0a2tOa3JVdmdKRlhuSXZBZVMwdWpyNVJSa09WLzhMQ1EvRnFpUVhX?=
 =?utf-8?B?dklUbDJIWkUzMDJ2SnIyZTJKeFNybjQ5NkZzekk5ZGNRRDk0NDhia1NLMzVy?=
 =?utf-8?B?MS84UHhPdUx4NmFFb1JHOXRGZEIzSzBGUHhnYTFrZHpRUStPZDlXR3RWMlZz?=
 =?utf-8?B?VDRJcVZEdTJJL2hrMzRKYjkzSGk1K1VEajByRnJCMkVKb1lRMmNFeWlqc2Ux?=
 =?utf-8?Q?9TMGV5dKw2B7U5A5UYlwA/o4c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea0a148-7ce7-4259-837e-08dd60b5f867
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 16:01:37.8398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XauTkHxZT3gtUvL2UITWFuqT3BI3Oxpd1nhom1phwgb4Qo0oc0AFRq8OL+QZEk48Bh9HGy6fGRCLLhjiXe1/RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483
Received-SPF: softfail client-ip=2a01:111:f403:2407::60f;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
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


On 11/03/2025 17:45, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 3/11/25 15:57, Avihai Horon wrote:
>>
>> On 11/03/2025 15:04, Cédric Le Goater wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 3/7/25 14:45, Maciej S. Szmigiero wrote:
>>>> On 7.03.2025 13:03, Cédric Le Goater wrote:
>>>>> On 3/7/25 11:57, Maciej S. Szmigiero wrote:
>>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>>
>>>>>> There's already a max in-flight VFIO device state buffers *count* 
>>>>>> limit,
>>>>>
>>>>> no. there isn't. Do we need both ?
>>>>
>>>> This is on a top of the remaining patches 
>>>> (x-migration-load-config-after-iter
>>>> and x-migration-max-queued-buffers) - I thought we were supposed to 
>>>> work
>>>> on these after the main series was merged as they are relatively 
>>>> non-critical.
>>>
>>> yes. we don't need both count and size limits though, a size limit 
>>> is enough.
>>>
>>>> I would also give x-migration-load-config-after-iter priority over
>>>> x-migration-max-queued-buffers{,-size} as the former is correctness 
>>>> fix
>>>> while the later are just additional functionalities.
>>>
>>> ok. I have kept both patches in my tree with the doc updates.
>>>
>>>> Also, if some setup is truly worried about these buffers consuming 
>>>> too much
>>>> memory then roughly the same thing could be achieved by 
>>>> (temporarily) putting
>>>> the target QEMU process in a memory-limited cgroup.
>>>
>>> yes.
>>>
>>> That said,
>>>
>>> since QEMU exchanges 1MB VFIODeviceStatePackets when using multifd 
>>> and that
>>> the overall device state is in the order of 100MB :
>>>
>>>   /*
>>>    * This is an arbitrary size based on migration of mlx5 devices, 
>>> where typically
>>>    * total device migration size is on the order of 100s of MB. 
>>> Testing with
>>>    * larger values, e.g. 128MB and 1GB, did not show a performance 
>>> improvement.
>>>    */
>>>   #define VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE (1 * MiB)
>>>
>>>
>>> Could we define the limit to 1GB ?
>>>
>>> Avihai, would that make sense  ?
>>>
>> There can be many use cases, each one with its own requirements and 
>> constraints, so it's hard for me to think of a "good" default value.
>>
>> IIUC this limit is mostly relevant for the extreme cases where 
>> devices have big state + writing the buffers to the device is slow.
>> So IMHO let's set it to unlimited by default and let the users decide 
>> if they want to set such limit and to what value. (Note also that 
>> even when unlimited, it is really limited to 2 * device_state_size).
>>
>> Unless you have other reasons why 1GB or other value is preferable?
>
> none but UINT_MAX is not good value either. 

You mean UINT_MAX is not a good value to represent "unlimited" or that 
unlimited is not a good default value?

> Let's wait before introducing
> a new limiting property.
>
> I will send the last PR for QEMU 10.0 at the end of the day.
>
>
> Thanks,
>
> C.
>

