Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273F9E77173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 09:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKZw3-0005wH-6B; Mon, 09 Dec 2024 04:20:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tKZvM-0005sk-95
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 04:19:28 -0500
Received: from mail-mw2nam12on2052.outbound.protection.outlook.com
 ([40.107.244.52] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tKZvG-00016i-R3
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 04:19:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjtJZDEVeB4eJ2kTVdT8kwarWqpyoj8p6DITRS7yAFt9D0nZzsxee3RQR4lTmvv9i3DcMARkrsfgKV9lC5AvCiviPt7jsMx+osLjJ5RkngSrxBqNP7YfcUa2jxLu0st+Ne0A8UryOHKhc8HOXyVUdd8cTA5WfKv2kS6yKwuE3CAOlq+thhgRPqZ3iwP2yhsZUTp54mkAqot9HljYG9IvPqUT/Oqqu0m7e5Jz1RCBJSqS2PCUJOnaLNtPR78ldaNSdLWb0RDulP5WCzmFlGnhlgAPp0EZpU3CygKPOZ08ewT+ds1Jb69s0oOZypSDZfnNVeIaPPxJMYQhUE55Bde9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eS72AkCMe4/XozO+tnA9cTxobE2i8ixXkS3YO0GEw0s=;
 b=KV8fbQyT6kPPb0vMUEAcgCSyfvB0z6dROLubFxsqt6Oxd+DIOV1GF6e/+s19wrevh9KzC0fTwS/jzBdD/vJCzs+fu7nDc0tN7ijnkYL9FQVxGXdqDlorgavnTfBjfYMtkgcXR2E0KC2s0SAHneMhH+q4pJXmf5362Nj74Wj1P1QDRyUH1xk9+WQUs6LD2dYy1t8R/5OUzrCn1G16TGgaQnlyARE/+1LCmNRP6VqOVIIhZItU6hsFiR9qHbd6VknrVD1VihkGLsY8gbqEvdS6/qPCM2wFULaohCzdzRpE4okuLimOVgza/btov9M1GtMeoCsW2ysv39HGO5N/TpTjHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eS72AkCMe4/XozO+tnA9cTxobE2i8ixXkS3YO0GEw0s=;
 b=uU8dOWh9i6eZlyme8nJE0T8/n9i/PVObfzKv0uLeD5wRykXVFXykpC3XXOGic3lbovBg2yoj08AkYehbfpQMcvMKMmpmUYtOfrkA1jA8EailyWjySyKpLVT3qD9GvTECw1B1/Y/KIzJHoiBeDirKau+GILhpDF7l5cvkkoRgNIm22zpbqpqLDAd5uNJlhmO4pCB48m5e0CiLbqlalq+H3WBiQ9C7n1OaidEiE9K0XZ4CL+QkIcrCdlfzwHG0/117yZPuD18bBvxIbDBAKrH3jcbWa6yxLpc9hWwbCw3cwEZAeAzK38O8vSlq2CUBZuvG/nSWjj3jGj4Ma8FaySfz/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 09:14:11 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 09:14:11 +0000
Message-ID: <579c8131-0554-4ea4-b222-36a8a350df02@nvidia.com>
Date: Mon, 9 Dec 2024 11:13:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/24] vfio/migration: Multifd device state transfer
 support - receive side
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <0567baf58cd68716d06cbe4db360149322e0cfcc.1731773021.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <0567baf58cd68716d06cbe4db360149322e0cfcc.1731773021.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::8) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|IA0PR12MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: afa9d4ce-a8e0-4e43-1ae4-08dd1831d7cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjQvc1FKMXgrZE82Nmg3ays5ZGVVc0UvRVZEUXZYU3pwNnFIblpmRHdBTGtK?=
 =?utf-8?B?VGUremxmd2cybUJnN2RjYnpUdHk2MzR4eUpZZlVMN3pjQTJENWJQQm5RRXNz?=
 =?utf-8?B?akZuZFNaZm43bFFQUGducGJvYXIxK2lrVEpNaDlnNG00R3ZqS3JGYWVUUkNn?=
 =?utf-8?B?VFhOU25TVmZHNzZ1d3kvbEhLVGpRWjBPK1hVajROZ1dnclF1ci9lY1dCNHoy?=
 =?utf-8?B?UGhOOG8xdnVhcjAxWEJxWHlmejdmcnllTzVzd3gwWWFhdVdndzBsVVdqdHNI?=
 =?utf-8?B?ZERsTkhEUytYM2YvT3ZiSjF3ZktBNHQ5YTBtbllMTjgrVnNOZVdyaU1OOTU5?=
 =?utf-8?B?SHZ3Q00zVE8vWjFmYXVGRC9HL0tZZ3lub3UwbjEzdjl6QUZpQkwzaG9raWpy?=
 =?utf-8?B?RVdNRkFJOTc3OWEvR0xXM2E3ZWFJcjBjNFhJdXVVeGZMTUJBVWNRcFppd3Z4?=
 =?utf-8?B?RjZrWFJaT1NVMkxqSSszUERWRmpKYVQ0Ym1QL0RQeWkzZHIxRmIxemJ5Nmtw?=
 =?utf-8?B?OU9RK2syNHZLSzQwUEtkU0NYc2ZQcEhBZlUrNWFaaVQ1MENyb1poUGxwakpj?=
 =?utf-8?B?dkZiY0VIdVJNYXZkbkxGKzlPd1VWSlk4UWoyV2E1MDcydGpUKzdzalJHSXR5?=
 =?utf-8?B?L2RjNG02bkNXRG11UE5DVTc3V3FOSFBBbEZFMzV5VjI0bHZISUdLV3FPRzFI?=
 =?utf-8?B?QXZEbjVGTWI2Q25FS0w2azhZOUpNNjVsbmNiNDFRNXEvUGFzVzBCeGd2RGE4?=
 =?utf-8?B?emkySFpsem5xRUNGeW9BSG5BZ0VxdkVLUUY5dzQwd3duVDBqQ1B1aldoNTA0?=
 =?utf-8?B?OTBjeXQyeXFaSVBiN3pEQ3h5UENkNXE1aFZvZHBPQlVSU1VyVjk2UFl2OWUx?=
 =?utf-8?B?N0NWVHJYRGxUblhKRWxYSVNnWlFsU09RYnpOcUl5Q3NnN1d1VzgrMDdKL2U0?=
 =?utf-8?B?OHkrTUg2MFRmbkNzUEV5aklLOGRVNExpZTY5aGltTGJMNUl0STRIUFpXZXVT?=
 =?utf-8?B?SmhwcmlTQTVYYm1CeUt4WHlmR2tJODcxOXc2ZkhRdzBOc0txdWd6RXNBR0lh?=
 =?utf-8?B?VDVSbGFXUEYveXRNSEVCWitFdmxBS2xGWjZCQjRRMytEMUVvb3FFQjZWSWRn?=
 =?utf-8?B?QW8wcWVNVUdpME4zczRtRTBxdit0WjZMc2hxU0l2ZUVJRHAyZjNLb0t0TTJz?=
 =?utf-8?B?VGZueDN4eTlQOVd3R3NaNVJaQmxLTHZZWU04RHFIQTVHdjViYTNBOWt6UG9y?=
 =?utf-8?B?Y0E1aWREZmV2R2xYSWVyU0xxS2pZdXM3eDUwZ2xRZjRrWTdIRjk3bzIzSG1l?=
 =?utf-8?B?NFVYSCtiMGp2a1ZtUU1ldytCbEYxVWZ2NGV6anRDcTdwSU1GVHNVTU1Ecmgx?=
 =?utf-8?B?dnFYbFVpTVk0Z0ZxYzNDZW9SNGNtTFY4dVEzSjNCNjZhUUlkeG1ISmEzQk43?=
 =?utf-8?B?eFFYRGRhdFI3Z2xZd3FYMWUwWTdiUHhGSTIwZ0R1Y3FBamlUVTFSejB1M3Vm?=
 =?utf-8?B?ZkRkV3AvQjhlWVZPNTdIcnBqTU1QeEZoNU1wTWF0eHlIWEVJS3lWdnVDZk9K?=
 =?utf-8?B?WkVuVWNSL1dzdEZscU5VaXlvUkFtTWl3aGt6SFNFNGNmZGdsYllxVTRnL2Zs?=
 =?utf-8?B?SlhBRXluYWExSCtkUkVsQTBzaHExOHZrOEZlWkVZWkxlWUhaRWRLWDNNa0N6?=
 =?utf-8?B?MW8zSUNTQmlNa3BFRHFQN2NaSEZZS0Z0bk1PcFZxRzh3S0ttRTc0bGVZeFN2?=
 =?utf-8?B?cjdKUGRDTWFRV29FRmFzNVNDcGQwNVdOQ0dHTVBWSWRib3ZVbFdXS2ZxSUZq?=
 =?utf-8?B?RFczc1RYSFFLVFBtMDhyUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDNSVHlYQWhyVk1oWVFPREFqOWdjZmFPTjBybWQydjZBaldmd3FoOUhTb3FH?=
 =?utf-8?B?czJ6QnpTa283eVc5WGhFaExSQXZlNk9uMW8rSlZWVWxmWmNVOWFTUThDSW5F?=
 =?utf-8?B?Uy9hanVPTlNFNWxIdDJ5MTdUaWthcWRYNXFPdUlRUis4V3pZK2lISW5hSEIz?=
 =?utf-8?B?aW9La2o4MVB0cVJubHJvUTZ3UU9wakN3VzhhSGxtRnZUS3RWSzBKMTdlV2dm?=
 =?utf-8?B?aXhRaDZGb3RqQUt0aGI3QktxWGxUbXZkdXZtNmJOWFpGcmUyQXB4bjk4R0hs?=
 =?utf-8?B?L0MzaG8zN2k3T3dQRmZwcm9tRlhEZ09lTEZFOGsyT3JwSFBaYzVoODBNVWp4?=
 =?utf-8?B?cWE5NHNsSTByVk5BUDBsLy9vNnplRkdUSDc4YXJKOHkrdVUyYm9Mc0Vaa3pz?=
 =?utf-8?B?NXVEeVUzUUpac2ZXRXFKQUJMaE45RjNVeFdrNVRvYTY3K3QwQlRiQkdtNHlH?=
 =?utf-8?B?UUhnMHArL3h1blFrK0t5RWt3cGRzdUw0NUhOT3VjeGhqSTVYamJwUUg1Z2t6?=
 =?utf-8?B?RFlaeUpKVFN4T0pVVXJGSW5xLzROWm5UbU1rMDFtQmdWeUNwWElLeGkvMXhO?=
 =?utf-8?B?YTdxNzMrb0VoTHFKclRiTVNiQjNhWWhxNS9zNTJxaEI3eHQ5Z1E0SUFnSGJk?=
 =?utf-8?B?cWExNFdHazQ3NDFrcUFVQVgwQkRJdnJaaWpCeGcrb1NsM3RkWnVyRmZ4OU1S?=
 =?utf-8?B?UGhrMC83ckI1M1VQcW5XbDlqWjFXRDhTMXpRLzFTc0RmMzJCNXZ4TlFPRG5h?=
 =?utf-8?B?dVhoSEpvOGtraDl5UVhycDhZZmRBVzE0Tit5SVErMXpJcnJvWkZVNFg2bEVC?=
 =?utf-8?B?VUljOW03dFhKRjRKSnBCRGREbDJYQ2Q3YmV1Wm5OODlxYTA2SWhzLzZ6dHM0?=
 =?utf-8?B?UlhUdldYbzU0WWErVmUxc2NFVldmRHlHTXBVNXNJQTlKeGxCSTVOQnhSNjBu?=
 =?utf-8?B?cllBMVZscjgrWjF6RjBESlpUbnZtbklXZWczV3RWbG5DRTJNSnkyaXF1aDBt?=
 =?utf-8?B?MG0rZmhrZ1NpczJWYS9OazNZR2NtcG1rRzdSVFhPUlYvdkdCQ0J5cDZTR3J0?=
 =?utf-8?B?b0VDb0xjeGx1ZGpDeXI4MnU1TFVaYVZjYjlIdVJsUmtUTm5yNFlybUU1SzNX?=
 =?utf-8?B?ZGl1RmZQbFA3dEZUYWhvc0wvakhMdHB5SlhxbHYvZm56VEdJTTB4QmN3TXZW?=
 =?utf-8?B?NURnc2N0dWd3U3pvNEQvOWFUZEtDOHhUM1hlTnlERDVGc2VLa2FGdHpjclRT?=
 =?utf-8?B?NVVYd3hMTFdRSUlRcUdMZ0NRQjExK0xGNkdJbkxsNklOWkVTUE1sU0N2aGJs?=
 =?utf-8?B?KzdSRUxzUjMxM1Q3QzlDOFJNdkpoNmRNMCtISkJTWEtkWXQ3ZllHOGc1ODJB?=
 =?utf-8?B?WmIvQXFROGR4NDMxYXRtVzRDY3R2WWN0ZlMySWxjUVZHVVNYV0l0U1FWZEpJ?=
 =?utf-8?B?cEN1VWQwU1pvSjFDN2YrMEpva1REUlJNaGNRMTdRalV3U3FkRG81SHpQdmly?=
 =?utf-8?B?aUM4aCtvaVdJZmE5NXZ3SVFONVdvd3pNUWd2Vk5qazhESGt4YzZETEJFcU1Y?=
 =?utf-8?B?SVZhUi82VSttSHVVM1djN1h5STV2N1dXL1I4NFJEaTJROSthRG5ZdE9EZzlo?=
 =?utf-8?B?U1BxbW9jNEhtTG95OFliL0U1YkFCblg4VzVXNWhFOWpZbEtSRnpYMm5nMjRa?=
 =?utf-8?B?S0xKVWlKWHY0VnllTnhPZm52NmlRZFo1am1wWlhZZkdyWmRWcFBqYU0zMW9I?=
 =?utf-8?B?VXdGVWJsMmVPdDRlemVDL2doTmRwcmxwTEMzVURRUjVaSDJkVmR0cGxQOUpK?=
 =?utf-8?B?NHMwV3o0T3p4TWNVTktTZ05PYW1FVEI5UUk0N3pEdklKTDJDN251cnpjTVFQ?=
 =?utf-8?B?ZU0wcnJIcDVFRTQvVGl2eXNlRmlMekxUbXQyeUFGMDdqNnBxRTBWZysva2xh?=
 =?utf-8?B?WDNnWlpBcmVEOFpsVVNNa2F2eFRZRHFZTURUUFRJR05obDRYbnJrRkE3eXB4?=
 =?utf-8?B?dVIyWFdyY3FHTlhKMkNSZHF0VXRrTVNKenA1a0orSXVQbFRDaGFDRUlXQlNV?=
 =?utf-8?B?cnBmNkl6cjExOWZXbkNIU3V5cms2ckNSTzJSY3dmRnh2ZXR5SU81NERmZ0hF?=
 =?utf-8?Q?azZ+JsvBRqhO4AZdmzrs4sj45?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa9d4ce-a8e0-4e43-1ae4-08dd1831d7cd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 09:14:11.2522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oIf8os9gNrBQneW08tGV9PtKXvE+TvjY5nqCXMS8mm79e+N3p5JgMtfZOHFj50tJ+JsLbBu31okuMvvdeOgLlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652
Received-SPF: softfail client-ip=40.107.244.52;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
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

Hi Maciej,

On 17/11/2024 21:20, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> The multifd received data needs to be reassembled since device state
> packets sent via different multifd channels can arrive out-of-order.
>
> Therefore, each VFIO device state packet carries a header indicating its
> position in the stream.
>
> The last such VFIO device state packet should have
> VFIO_DEVICE_STATE_CONFIG_STATE flag set and carry the device config state.
>
> Since it's important to finish loading device state transferred via the
> main migration channel (via save_live_iterate SaveVMHandler) before
> starting loading the data asynchronously transferred via multifd the thread
> doing the actual loading of the multifd transferred data is only started
> from switchover_start SaveVMHandler.
>
> switchover_start handler is called when MIG_CMD_SWITCHOVER_START
> sub-command of QEMU_VM_COMMAND is received via the main migration channel.
>
> This sub-command is only sent after all save_live_iterate data have already
> been posted so it is safe to commence loading of the multifd-transferred
> device state upon receiving it - loading of save_live_iterate data happens
> synchronously in the main migration thread (much like the processing of
> MIG_CMD_SWITCHOVER_START) so by the time MIG_CMD_SWITCHOVER_START is
> processed all the proceeding data must have already been loaded.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration.c           | 402 ++++++++++++++++++++++++++++++++++
>   hw/vfio/pci.c                 |   2 +
>   hw/vfio/trace-events          |   6 +
>   include/hw/vfio/vfio-common.h |  19 ++
>   4 files changed, 429 insertions(+)
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 683f2ae98d5e..b54879fe6209 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -15,6 +15,7 @@
>   #include <linux/vfio.h>
>   #include <sys/ioctl.h>
>
> +#include "io/channel-buffer.h"
>   #include "sysemu/runstate.h"
>   #include "hw/vfio/vfio-common.h"
>   #include "migration/misc.h"
> @@ -55,6 +56,15 @@
>    */
>   #define VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE (1 * MiB)
>
> +#define VFIO_DEVICE_STATE_CONFIG_STATE (1)
> +
> +typedef struct VFIODeviceStatePacket {
> +    uint32_t version;
> +    uint32_t idx;
> +    uint32_t flags;
> +    uint8_t data[0];
> +} QEMU_PACKED VFIODeviceStatePacket;
> +
>   static int64_t bytes_transferred;
>
>   static const char *mig_state_to_str(enum vfio_device_mig_state state)
> @@ -254,6 +264,292 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>       return ret;
>   }
>
> +typedef struct VFIOStateBuffer {
> +    bool is_present;
> +    char *data;
> +    size_t len;
> +} VFIOStateBuffer;
> +
> +static void vfio_state_buffer_clear(gpointer data)
> +{
> +    VFIOStateBuffer *lb = data;
> +
> +    if (!lb->is_present) {
> +        return;
> +    }
> +
> +    g_clear_pointer(&lb->data, g_free);
> +    lb->is_present = false;
> +}
> +
> +static void vfio_state_buffers_init(VFIOStateBuffers *bufs)
> +{
> +    bufs->array = g_array_new(FALSE, TRUE, sizeof(VFIOStateBuffer));
> +    g_array_set_clear_func(bufs->array, vfio_state_buffer_clear);
> +}
> +
> +static void vfio_state_buffers_destroy(VFIOStateBuffers *bufs)
> +{
> +    g_clear_pointer(&bufs->array, g_array_unref);
> +}
> +
> +static void vfio_state_buffers_assert_init(VFIOStateBuffers *bufs)
> +{
> +    assert(bufs->array);
> +}
> +
> +static guint vfio_state_buffers_size_get(VFIOStateBuffers *bufs)
> +{
> +    return bufs->array->len;
> +}
> +
> +static void vfio_state_buffers_size_set(VFIOStateBuffers *bufs, guint size)
> +{
> +    g_array_set_size(bufs->array, size);
> +}

The above three functions seem a bit too specific.

How about:
Instead of size_set and assert_init, introduce a 
vfio_state_buffers_insert() function that handles buffer insertion to 
the array from the validated packet.

Instead of size_get, introduce vfio_state_buffers_get() that handles the 
array length and is_present checks.
We can also add a vfio_state_buffer_write() function that handles 
writing the buffer to the device.

IMHO this will also make vfio_load_state_buffer() and 
vfio_load_bufs_thread(), which are rather long, clearer.

> +
> +static VFIOStateBuffer *vfio_state_buffers_at(VFIOStateBuffers *bufs, guint idx)
> +{
> +    return &g_array_index(bufs->array, VFIOStateBuffer, idx);
> +}
> +
> +static int vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
> +                                  Error **errp)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIODeviceStatePacket *packet = (VFIODeviceStatePacket *)data;
> +    VFIOStateBuffer *lb;
> +
> +    /*
> +     * Holding BQL here would violate the lock order and can cause
> +     * a deadlock once we attempt to lock load_bufs_mutex below.
> +     */
> +    assert(!bql_locked());
> +
> +    if (!migration->multifd_transfer) {
> +        error_setg(errp,
> +                   "got device state packet but not doing multifd transfer");
> +        return -1;
> +    }
> +
> +    if (data_size < sizeof(*packet)) {
> +        error_setg(errp, "packet too short at %zu (min is %zu)",
> +                   data_size, sizeof(*packet));
> +        return -1;
> +    }
> +
> +    if (packet->version != 0) {
> +        error_setg(errp, "packet has unknown version %" PRIu32,
> +                   packet->version);
> +        return -1;
> +    }
> +
> +    if (packet->idx == UINT32_MAX) {
> +        error_setg(errp, "packet has too high idx %" PRIu32,
> +                   packet->idx);
> +        return -1;
> +    }
> +
> +    trace_vfio_load_state_device_buffer_incoming(vbasedev->name, packet->idx);
> +
> +    QEMU_LOCK_GUARD(&migration->load_bufs_mutex);
> +
> +    /* config state packet should be the last one in the stream */
> +    if (packet->flags & VFIO_DEVICE_STATE_CONFIG_STATE) {
> +        migration->load_buf_idx_last = packet->idx;
> +    }
> +
> +    vfio_state_buffers_assert_init(&migration->load_bufs);
> +    if (packet->idx >= vfio_state_buffers_size_get(&migration->load_bufs)) {
> +        vfio_state_buffers_size_set(&migration->load_bufs, packet->idx + 1);
> +    }
> +
> +    lb = vfio_state_buffers_at(&migration->load_bufs, packet->idx);
> +    if (lb->is_present) {
> +        error_setg(errp, "state buffer %" PRIu32 " already filled",
> +                   packet->idx);
> +        return -1;
> +    }
> +
> +    assert(packet->idx >= migration->load_buf_idx);
> +
> +    migration->load_buf_queued_pending_buffers++;
> +    if (migration->load_buf_queued_pending_buffers >
> +        vbasedev->migration_max_queued_buffers) {
> +        error_setg(errp,
> +                   "queuing state buffer %" PRIu32 " would exceed the max of %" PRIu64,
> +                   packet->idx, vbasedev->migration_max_queued_buffers);
> +        return -1;
> +    }

Copying my question from v2:

Should we count bytes instead of buffers? Current buffer size is 1MB but 
this could change, and the normal user should not care or know what is 
the buffer size.
So maybe rename to migration_max_pending_bytes or such?

And Maciej replied:

Since it's Peter that asked for this limit to be introduced in the first 
place
I would like to ask him what his preference here.
@Peter: max queued buffers or bytes?

So Peter, what's your opinion here?

> +
> +    lb->data = g_memdup2(&packet->data, data_size - sizeof(*packet));
> +    lb->len = data_size - sizeof(*packet);
> +    lb->is_present = true;
> +
> +    qemu_cond_signal(&migration->load_bufs_buffer_ready_cond);
> +
> +    return 0;
> +}
> +
> +static int vfio_load_device_config_state(QEMUFile *f, void *opaque);
> +
> +static int vfio_load_bufs_thread_load_config(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIOStateBuffer *lb;
> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
> +    QEMUFile *f_out = NULL, *f_in = NULL;
> +    uint64_t mig_header;
> +    int ret;
> +
> +    assert(migration->load_buf_idx == migration->load_buf_idx_last);
> +    lb = vfio_state_buffers_at(&migration->load_bufs, migration->load_buf_idx);
> +    assert(lb->is_present);
> +
> +    bioc = qio_channel_buffer_new(lb->len);
> +    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-load");
> +
> +    f_out = qemu_file_new_output(QIO_CHANNEL(bioc));
> +    qemu_put_buffer(f_out, (uint8_t *)lb->data, lb->len);
> +
> +    ret = qemu_fflush(f_out);
> +    if (ret) {
> +        g_clear_pointer(&f_out, qemu_fclose);
> +        return ret;
> +    }
> +
> +    qio_channel_io_seek(QIO_CHANNEL(bioc), 0, 0, NULL);
> +    f_in = qemu_file_new_input(QIO_CHANNEL(bioc));
> +
> +    mig_header = qemu_get_be64(f_in);
> +    if (mig_header != VFIO_MIG_FLAG_DEV_CONFIG_STATE) {
> +        g_clear_pointer(&f_out, qemu_fclose);
> +        g_clear_pointer(&f_in, qemu_fclose);
> +        return -EINVAL;
> +    }
> +
> +    bql_lock();
> +    ret = vfio_load_device_config_state(f_in, vbasedev);
> +    bql_unlock();
> +
> +    g_clear_pointer(&f_out, qemu_fclose);
> +    g_clear_pointer(&f_in, qemu_fclose);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> +static bool vfio_load_bufs_thread_want_abort(VFIODevice *vbasedev,
> +                                             bool *abort_flag)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    return migration->load_bufs_thread_want_exit || qatomic_read(abort_flag);
> +}
> +
> +static int vfio_load_bufs_thread(bool *abort_flag, void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    QEMU_LOCK_GUARD(&migration->load_bufs_mutex);

Move QEMU_LOCK_GUARD() below the local var declaration?
I usually don't expect to see mutex lockings as part of local var 
declaration block, which makes it easy to miss when reading the code.
(Although QEMU_LOCK_GUARD declares a local variable under the hood, it's 
implicit and not visible to the user).

> +    int ret;
> +
> +    assert(migration->load_bufs_thread_running);
> +
> +    while (!vfio_load_bufs_thread_want_abort(vbasedev, abort_flag)) {
> +        VFIOStateBuffer *lb;
> +        guint bufs_len;
> +        bool starved;
> +
> +        assert(migration->load_buf_idx <= migration->load_buf_idx_last);
> +
> +        bufs_len = vfio_state_buffers_size_get(&migration->load_bufs);
> +        if (migration->load_buf_idx >= bufs_len) {
> +            assert(migration->load_buf_idx == bufs_len);
> +            starved = true;
> +        } else {
> +            lb = vfio_state_buffers_at(&migration->load_bufs,
> +                                       migration->load_buf_idx);
> +            starved = !lb->is_present;
> +        }
> +
> +        if (starved) {
> +            trace_vfio_load_state_device_buffer_starved(vbasedev->name,
> +                                                        migration->load_buf_idx);
> +            qemu_cond_wait(&migration->load_bufs_buffer_ready_cond,
> +                           &migration->load_bufs_mutex);
> +            continue;
> +        }
> +
> +        if (migration->load_buf_idx == migration->load_buf_idx_last) {
> +            break;
> +        }
> +
> +        if (migration->load_buf_idx == 0) {
> +            trace_vfio_load_state_device_buffer_start(vbasedev->name);
> +        }
> +
> +        if (lb->len) {
> +            g_autofree char *buf = NULL;
> +            size_t buf_len;
> +            ssize_t wr_ret;
> +            int errno_save;
> +
> +            trace_vfio_load_state_device_buffer_load_start(vbasedev->name,
> +                                                           migration->load_buf_idx);
> +
> +            /* lb might become re-allocated when we drop the lock */
> +            buf = g_steal_pointer(&lb->data);
> +            buf_len = lb->len;
> +
> +            /*
> +             * Loading data to the device takes a while,
> +             * drop the lock during this process.
> +             */
> +            qemu_mutex_unlock(&migration->load_bufs_mutex);
> +            wr_ret = write(migration->data_fd, buf, buf_len);
> +            errno_save = errno;
> +            qemu_mutex_lock(&migration->load_bufs_mutex);
> +
> +            if (wr_ret < 0) {
> +                ret = -errno_save;
> +                goto ret_signal;
> +            } else if (wr_ret < buf_len) {
> +                ret = -EINVAL;
> +                goto ret_signal;
> +            }

Should we loop the write until reaching buf_len bytes?
Partial write is not considered error according to write(2) manpage.

Thanks.

> +
> +            trace_vfio_load_state_device_buffer_load_end(vbasedev->name,
> +                                                         migration->load_buf_idx);
> +        }
> +
> +        assert(migration->load_buf_queued_pending_buffers > 0);
> +        migration->load_buf_queued_pending_buffers--;
> +
> +        if (migration->load_buf_idx == migration->load_buf_idx_last - 1) {
> +            trace_vfio_load_state_device_buffer_end(vbasedev->name);
> +        }
> +
> +        migration->load_buf_idx++;
> +    }
> +
> +    if (vfio_load_bufs_thread_want_abort(vbasedev, abort_flag)) {
> +        ret = -ECANCELED;
> +        goto ret_signal;
> +    }
> +
> +    ret = vfio_load_bufs_thread_load_config(vbasedev);
> +
> +ret_signal:
> +    migration->load_bufs_thread_running = false;
> +    qemu_cond_signal(&migration->load_bufs_thread_finished_cond);
> +
> +    return ret;
> +}
> +
>   static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
>                                            Error **errp)
>   {
> @@ -430,6 +726,12 @@ static bool vfio_precopy_supported(VFIODevice *vbasedev)
>       return migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
>   }
>
> +static bool vfio_multifd_transfer_supported(void)
> +{
> +    return migration_has_device_state_support() &&
> +        migrate_send_switchover_start();
> +}
> +
>   /* ---------------------------------------------------------------------- */
>
>   static int vfio_save_prepare(void *opaque, Error **errp)
> @@ -695,17 +997,73 @@ static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
>
>       assert(!migration->load_setup);
>
> +    /*
> +     * Make a copy of this setting at the start in case it is changed
> +     * mid-migration.
> +     */
> +    if (vbasedev->migration_multifd_transfer == ON_OFF_AUTO_AUTO) {
> +        migration->multifd_transfer = vfio_multifd_transfer_supported();
> +    } else {
> +        migration->multifd_transfer =
> +            vbasedev->migration_multifd_transfer == ON_OFF_AUTO_ON;
> +    }
> +
> +    if (migration->multifd_transfer && !vfio_multifd_transfer_supported()) {
> +        error_setg(errp,
> +                   "%s: Multifd device transfer requested but unsupported in the current config",
> +                   vbasedev->name);
> +        return -EINVAL;
> +    }
> +
>       ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
>                                      migration->device_state, errp);
>       if (ret) {
>           return ret;
>       }
>
> +    if (migration->multifd_transfer) {
> +        assert(!migration->load_bufs.array);
> +        vfio_state_buffers_init(&migration->load_bufs);
> +
> +        qemu_mutex_init(&migration->load_bufs_mutex);
> +
> +        migration->load_buf_idx = 0;
> +        migration->load_buf_idx_last = UINT32_MAX;
> +        migration->load_buf_queued_pending_buffers = 0;
> +        qemu_cond_init(&migration->load_bufs_buffer_ready_cond);
> +
> +        migration->load_bufs_thread_running = false;
> +        migration->load_bufs_thread_want_exit = false;
> +        qemu_cond_init(&migration->load_bufs_thread_finished_cond);
> +    }
> +
>       migration->load_setup = true;
>
>       return 0;
>   }
>
> +static void vfio_load_cleanup_load_bufs_thread(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
> +    bql_unlock();
> +    WITH_QEMU_LOCK_GUARD(&migration->load_bufs_mutex) {
> +        if (!migration->load_bufs_thread_running) {
> +            break;
> +        }
> +
> +        migration->load_bufs_thread_want_exit = true;
> +
> +        qemu_cond_signal(&migration->load_bufs_buffer_ready_cond);
> +        qemu_cond_wait(&migration->load_bufs_thread_finished_cond,
> +                       &migration->load_bufs_mutex);
> +
> +        assert(!migration->load_bufs_thread_running);
> +    }
> +    bql_lock();
> +}
> +
>   static int vfio_load_cleanup(void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
> @@ -715,7 +1073,19 @@ static int vfio_load_cleanup(void *opaque)
>           return 0;
>       }
>
> +    if (migration->multifd_transfer) {
> +        vfio_load_cleanup_load_bufs_thread(vbasedev);
> +    }
> +
>       vfio_migration_cleanup(vbasedev);
> +
> +    if (migration->multifd_transfer) {
> +        qemu_cond_destroy(&migration->load_bufs_thread_finished_cond);
> +        vfio_state_buffers_destroy(&migration->load_bufs);
> +        qemu_cond_destroy(&migration->load_bufs_buffer_ready_cond);
> +        qemu_mutex_destroy(&migration->load_bufs_mutex);
> +    }
> +
>       migration->load_setup = false;
>       trace_vfio_load_cleanup(vbasedev->name);
>
> @@ -725,6 +1095,7 @@ static int vfio_load_cleanup(void *opaque)
>   static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>   {
>       VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
>       int ret = 0;
>       uint64_t data;
>
> @@ -736,6 +1107,12 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>           switch (data) {
>           case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
>           {
> +            if (migration->multifd_transfer) {
> +                error_report("%s: got DEV_CONFIG_STATE but doing multifd transfer",
> +                             vbasedev->name);
> +                return -EINVAL;
> +            }
> +
>               return vfio_load_device_config_state(f, opaque);
>           }
>           case VFIO_MIG_FLAG_DEV_SETUP_STATE:
> @@ -801,6 +1178,29 @@ static bool vfio_switchover_ack_needed(void *opaque)
>       return vfio_precopy_supported(vbasedev);
>   }
>
> +static int vfio_switchover_start(void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    if (!migration->multifd_transfer) {
> +        /* Load thread is only used for multifd transfer */
> +        return 0;
> +    }
> +
> +    /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
> +    bql_unlock();
> +    WITH_QEMU_LOCK_GUARD(&migration->load_bufs_mutex) {
> +        assert(!migration->load_bufs_thread_running);
> +        migration->load_bufs_thread_running = true;
> +    }
> +    bql_lock();
> +
> +    qemu_loadvm_start_load_thread(vfio_load_bufs_thread, vbasedev);
> +
> +    return 0;
> +}
> +
>   static const SaveVMHandlers savevm_vfio_handlers = {
>       .save_prepare = vfio_save_prepare,
>       .save_setup = vfio_save_setup,
> @@ -814,7 +1214,9 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>       .load_setup = vfio_load_setup,
>       .load_cleanup = vfio_load_cleanup,
>       .load_state = vfio_load_state,
> +    .load_state_buffer = vfio_load_state_buffer,
>       .switchover_ack_needed = vfio_switchover_ack_needed,
> +    .switchover_start = vfio_switchover_start,
>   };
>
>   /* ---------------------------------------------------------------------- */
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 9d547cb5cdff..72d62ada8a39 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3384,6 +3384,8 @@ static Property vfio_pci_dev_properties[] = {
>                   vbasedev.migration_multifd_transfer,
>                   qdev_prop_on_off_auto_mutable, OnOffAuto,
>                   .set_default = true, .defval.i = ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_UINT64("x-migration-max-queued-buffers", VFIOPCIDevice,
> +                       vbasedev.migration_max_queued_buffers, UINT64_MAX),
>       DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>                        vbasedev.migration_events, false),
>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 1bebe9877d88..418b378ebd29 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -153,6 +153,12 @@ vfio_load_device_config_state_start(const char *name) " (%s)"
>   vfio_load_device_config_state_end(const char *name) " (%s)"
>   vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
>   vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size %"PRIu64" ret %d"
> +vfio_load_state_device_buffer_incoming(const char *name, uint32_t idx) " (%s) idx %"PRIu32
> +vfio_load_state_device_buffer_start(const char *name) " (%s)"
> +vfio_load_state_device_buffer_starved(const char *name, uint32_t idx) " (%s) idx %"PRIu32
> +vfio_load_state_device_buffer_load_start(const char *name, uint32_t idx) " (%s) idx %"PRIu32
> +vfio_load_state_device_buffer_load_end(const char *name, uint32_t idx) " (%s) idx %"PRIu32
> +vfio_load_state_device_buffer_end(const char *name) " (%s)"
>   vfio_migration_realize(const char *name) " (%s)"
>   vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
>   vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b1c03a82eec8..0954d6981a22 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -61,6 +61,11 @@ typedef struct VFIORegion {
>       uint8_t nr; /* cache the region number for debug */
>   } VFIORegion;
>
> +/* type safety */
> +typedef struct VFIOStateBuffers {
> +    GArray *array;
> +} VFIOStateBuffers;
> +
>   typedef struct VFIOMigration {
>       struct VFIODevice *vbasedev;
>       VMChangeStateEntry *vm_state;
> @@ -73,10 +78,23 @@ typedef struct VFIOMigration {
>       uint64_t mig_flags;
>       uint64_t precopy_init_size;
>       uint64_t precopy_dirty_size;
> +    bool multifd_transfer;
>       bool initial_data_sent;
>
>       bool event_save_iterate_started;
>       bool event_precopy_empty_hit;
> +
> +    QemuThread load_bufs_thread;
> +    bool load_bufs_thread_running;
> +    bool load_bufs_thread_want_exit;
> +
> +    VFIOStateBuffers load_bufs;
> +    QemuCond load_bufs_buffer_ready_cond;
> +    QemuCond load_bufs_thread_finished_cond;
> +    QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
> +    uint32_t load_buf_idx;
> +    uint32_t load_buf_idx_last;
> +    uint32_t load_buf_queued_pending_buffers;
>   } VFIOMigration;
>
>   struct VFIOGroup;
> @@ -136,6 +154,7 @@ typedef struct VFIODevice {
>       OnOffAuto enable_migration;
>       OnOffAuto migration_multifd_transfer;
>       bool migration_events;
> +    uint64_t migration_max_queued_buffers;
>       VFIODeviceOps *ops;
>       unsigned int num_irqs;
>       unsigned int num_regions;

