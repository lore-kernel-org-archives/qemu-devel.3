Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D589D132D0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 14:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7xnY-0007vh-Ta; Mon, 04 Nov 2024 09:11:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t7xnW-0007v8-Oy
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:11:14 -0500
Received: from mail-bn1nam02on20608.outbound.protection.outlook.com
 ([2a01:111:f403:2407::608]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t7xnS-0006Us-4U
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:11:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGcdklrG31rOMFg2p7fx0rfC61vcpQAxLMW4PuBL6TXDESysNAjRdbkGxG7/vA1obZpZkwQvCA5wMUbCBwkiNgkKJxgewqfwOAzo/QD7/dH4ejhzZGfQufUa4/2AOxbrz8HzjhvBausmYBsikS2eUZ242YREw+WuFgw8nQZMYlETB09FC1UxzxJH0x6V3Uw+eN4QmImeXW0pQ/xOGPokwkfYlv7XB1/6w95nVip0Dizz2nnNxa0t7vbe42MjZzsw9+CWjC4cTQoPSl5bAkRUj+52Vf9rNmV6UV0kVZdPOCPsotZXmVK7hROWJ5g5aNz5knRQ7YpO8PxOj+HEc7qgFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5AYh+Tq6fg0jkB7KluorcMvoTlquf+djTYjWYgQN1Q=;
 b=BwO9k95xDSek/xT+5EQbHnxjWHXXH6De6cRUp/Pca0/7UkKJ1XJqylozbHiEPOxJxqqlwUQFfvCqQOdjkddHIY8cZZ3s3ld7QYdJjtzyxbSN+Cm7M2rUGrCpOd8a1if/KlNJW4OTWPOZAJBn6KB11tcvbgvJHtCHd/XIQxk7/T5Rl1D/aoxp1xp6SS1n5YqytIt+JArqqenaTybw4rN9HPKWuwuKyd73Q/yg0ziGhpLm65p5dleecR1NDgNJyLImBYESGq/TRKqO0cmc6bGOZlcfpTNtSJ0UQ+yXQH9cOHA+9JAN0Q1pCPqaGOu0LTULPaLxpft4n2Gc0yQTTrB9gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5AYh+Tq6fg0jkB7KluorcMvoTlquf+djTYjWYgQN1Q=;
 b=YozFfWj0VZ3pR3DoPwv0jPtlLitx5hMuVmYPmeD4rWLpQ017krzrSIbubAE1wLLIQv3roQMHW3Ymh1IZ5R3n6KIzR2Yt2QHF3jwtn7F92wGilQ4Wi4djFkaEcCN80dwI/e7A1DCX4PHfFuVLLNIVko+29e8wBOugOddcYkuujGsmsQbYypRyOEBOOKtmXcKkiRliBnbqulhsCOCrpTdedOtEnhGitTHKwZtnzV+qsYdLNdhAPWXL1eSc7bpd0MtzsSxEaw/vkySmXeuVdZQhjSv9vvKj+IsMrcbpdsRrdHp4yyzm0An7QR7vuh+nx1fHzWlWe76DFCanlS1a9dvlUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.30; Mon, 4 Nov 2024 14:11:01 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 14:11:01 +0000
Message-ID: <e79c550d-8663-442a-85e3-800a501b8c67@nvidia.com>
Date: Mon, 4 Nov 2024 16:10:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] vfio/migration: Add
 save_{iterate,complete_precopy}_started trace events
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1730203967.git.maciej.szmigiero@oracle.com>
 <68f51cf0eb3daf448ae80219dded4b10984e32db.1730203967.git.maciej.szmigiero@oracle.com>
 <1eac2eb5-c154-438c-91a3-fb7ac7e3baef@nvidia.com>
 <c78686f9-d8a8-4fc1-bd2b-5268aa1aaf4c@maciej.szmigiero.name>
 <cceed8b5-6d56-4da9-8321-7f361f0f74c9@nvidia.com>
 <977126cd-b0ad-4a34-980f-5ed88d858075@maciej.szmigiero.name>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <977126cd-b0ad-4a34-980f-5ed88d858075@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0283.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::31) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DS7PR12MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: 34076d76-0ac9-49bc-8535-08dcfcda82cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0Q5Q2lsWFYvZ2lESXZRT2hqVjQyTWZxZHJUcDk5ZS8yTHNjS2lMSmJKMzA3?=
 =?utf-8?B?STBnMDE5STZ2Y3hnQXBlOUIvYzMyRGYwZ1k1UWgyTTBhSWpTNkxCY0ZuSXp3?=
 =?utf-8?B?cjh6Wm1sYUhkWUlKYWtIWEZ1ODZPZEpmdW1CR2pNK3JvajNzQSsyN3JBL0NO?=
 =?utf-8?B?RFV5QkIwNjBzL1VvNXEzR1Bua2N1ODNqSEs4WU1JQWtqQzdreFM0YjM4Rkh4?=
 =?utf-8?B?R21CQ25kTjlIOUZ2VTR6TjRSTUp5MEovL1R2ODRzNFJLNUpXTnZlZmRrVDVv?=
 =?utf-8?B?eHRudlVuK0dYMVh3b3pQdXdFQmtvdzd6RHlGNlF0aUdoUSt6NkxsbWN6d3Na?=
 =?utf-8?B?NGZMT2lMVlpzbUswcHl1a2RDcTVEMTlEWXhoZGVZUUlkemZ3ZFJ5RWlUN2FU?=
 =?utf-8?B?blRyZXJGOXdOWk9RT2RZUDIvRHlETmZ0NzdvNy9uZVdwanlYMUhZQjFvOElu?=
 =?utf-8?B?T29FN1BEZWJnbm9CdnZ2K2VLN2tlckRuNTVRVEhwV2YrVlRGcWRKZHhOU2Jq?=
 =?utf-8?B?aHRrb2NTR0Z0Nm9JWTdMTTM4TFFoMDNTTmNzYkIvTU5kMEZCYWJwZFROK0dT?=
 =?utf-8?B?cU93VXZoNmJTZ1dGc0tEYUxTeXhmZSt4T1FiaHI0QkNiODlSdC8rM1Z5bGxM?=
 =?utf-8?B?QjNnck5xKytPWk8wRTN4OE9UdFBHdlpLUUsycFhFSVRNVVQ0SXcrb2l1OE8x?=
 =?utf-8?B?c2NsUWRlcEFrOFNzdGl6WXNvNFJOYzhXQStLbXdkRnpxYXRaelZoVlVLUGdx?=
 =?utf-8?B?QlNYY3NBWnBRbW1SUWZyNU1qdDdpQWsySkoxY1FwOVRoYUdkZDBLTXlxTGJx?=
 =?utf-8?B?TXIvWDBIa051TVZ5L1hJQkpFR1lqRjJ0ZlFhQlpIQlMzSkFKSVhINTQ5UmVj?=
 =?utf-8?B?RTFxcytlNDJyYmtmdVd5T3duMUc0bXBpc3dWOTRDSlRubGNRcjBiTkxlOHhX?=
 =?utf-8?B?aTNwMjVmaHJZcExPWENOOGlndkdMNjJGSTZSSkw1eGRpbWtCWk4vMFdvMVpC?=
 =?utf-8?B?UjJycWdDcXo1a0dYck05d2praVpUT2V4TmJxbWlIbGxjSGdmcDRCTHlqMm5i?=
 =?utf-8?B?NCtEMkVqdlJsOURtR2FuYnR0WWk5ZkIyK0pHL0w3bDVQcE13Q1dhM2tadEdZ?=
 =?utf-8?B?NHV3eVNxVFNNK3d0WlRoVE85RkdraFJLdExJS2hrZ1cvaCtySkxlS0Y5QWVW?=
 =?utf-8?B?T0xLOUx2T3QwNnhGeTRoZmcyMGRVY3c3S2RRU2krUDBsQ0dnUVFtbWRzdXNZ?=
 =?utf-8?B?U205QitjOWZYWGJrc0xiTkp1NkFqUDhveSs1YWdhbytvREdVODJZejJDVTh1?=
 =?utf-8?B?TzIyd2VRVE1MZ3BuWEtRNElwb3A4QkwyS2grbU5aSzRyWnJBNHQyZWJmb0ZM?=
 =?utf-8?B?S3AwbGY4N1pseitZU0NLeVU0RVlhRUlWNWFUOU9WNEEwWTkwc0VoUGlPK0ZP?=
 =?utf-8?B?dWFuSTN6SVpEbHIwUy9BVCtzZlQ1UG8yTElMaFVObW5Kc0QraTJrdHdUbldH?=
 =?utf-8?B?Q3NSU0svSmloWFoyakZmNWh0ZUwzOU1YMDdUckVZNnRJOVRrd0FrK0FoSHpl?=
 =?utf-8?B?MGllM1JubWFyRUZZbDk3T1dRMnBrajB2QWFhT2ppQ2huazNRWFZ1MWtEZjlF?=
 =?utf-8?B?YUdrQytTdXhYcWt6VzlnbHZQeXNVL1AwUW1oZXZpdlFxZGNxMkhpQWNjNWVw?=
 =?utf-8?B?SVhCRnlQOS81cjExdGk5bGlMVjdmUnRmaEJBSUdzSU5Id3dRaStwT2RxYmJB?=
 =?utf-8?Q?2QDN+UxtFtlyQy/EN+hhDucNaMdVZsZrcvKhmgw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVJjQm81elFod0pVZVpRYkc5MU82MTFFTWdiMVJiN0tvMEdEVGNBamRtamoz?=
 =?utf-8?B?aEZvVFF0RDZtM0hta2JuZVgwbU5uTWxIRFNxYUNpVVFnUUQyOVFGQ0VUQjlt?=
 =?utf-8?B?alNwYlRHM2FHY1NtT1B0cEJiR1NmR2trYWVTOEFCb0NhcmY0UDlXUE1yYkc4?=
 =?utf-8?B?TXVQSTBtbGhhbW9Hb2xqS0NGeVdjUmN6RlNyUHNJVUQrUGJCS0NqTzk1OHo4?=
 =?utf-8?B?N3RrdElTbEZlRk5UVnUva0RyNFkvcWdqRkdVb2t0NVd1ZVJEeFFxODZZb0NJ?=
 =?utf-8?B?VWZGekVIVzJKOGZnY1hFRm1wZ1daRnhKcTVRV0pQL1cvL0ZIUWhzUkt0V0NS?=
 =?utf-8?B?WkVRdDI2VjJ2VFF3S0hIbERSLzRXaXdwaFRNeTFpdGxkK2RYbUpyTXlCVXg3?=
 =?utf-8?B?NWpaMG5reTAvbzFSYXdTRUh2QzJHL1VuWGRZbDM3Z0RSS2M3N1dscGFpVzAw?=
 =?utf-8?B?RXFSMmtZNjUvb0J1b2NadGZnUGxlYW15QlJsN1FZQUgxZlBCcS9YU3dDTVFF?=
 =?utf-8?B?c2JDUllKbVBUSG9NeUxpeHVvZnlLaHdkUHU3bWpxUTB3TGh0Rm9UdWFEZVZo?=
 =?utf-8?B?MmtWNjVtL04wU2JnN3h6YUJmV2hueFJLZk1IeExNVHhCT052dXpSRzJINWtB?=
 =?utf-8?B?QUQ5ZmtUQ3IzV0NNVzRVSmxra0o5WEdvRFo4bTgwS0JhWlRIUHFhSGFJckdk?=
 =?utf-8?B?bVQ1TnhOTzNNMjJ6M21tSFlqNXpJTXRLQjdrMXJxaEFPMndFNFdiQk9FMlVC?=
 =?utf-8?B?UGVnYTVMcFRTM0FxOWtJTGM1cGhZU0twUFBIZTFKZFo5aXV2S08xblZ3TDhm?=
 =?utf-8?B?RlVWV0crekVFaTYzbi9FZUpvRisrS1Q2VFR1UFRPY1FSaFdqc295OFAzOGl1?=
 =?utf-8?B?dTVOOUpTK3JQOXdHbnB6QTFlMEJpTFRjTkxCTVQwRDFmRFhicWlRYzh2UmFu?=
 =?utf-8?B?SUNHenB4ZnhGZi8zZmFDV0NxSjMvcEJiM3JEODZmZlpXbDdOSjYzaDBCNUR1?=
 =?utf-8?B?QVpmYVh6RVh3d2lzNVFyVElUTTEyZFh2RnhFSGNUOHBWY1NSdW9IQ3BUSkxs?=
 =?utf-8?B?QWE0TkV3OVZtWWJ5YnhLWUMwckQyL3VPNCt2SVcxbDB4US9sSXFwd2ZQalNj?=
 =?utf-8?B?Q042Y3JrZ2JpdE5iQzl1My9oeXJPeTlyVUlldDNlWFFCZEQrWWhUZ052c0Nl?=
 =?utf-8?B?NUt5Y3NsdWhSRmlvQlJwK2VBb3M1cExJdzBaSTRnSDZaR3l4Z0Z0NkV6MXlG?=
 =?utf-8?B?VGRzUUZTU1N4dWFPTmtNVnZGLzFZb3Z4WjByZE9TYzVzZFFtaGxqdGhqMURH?=
 =?utf-8?B?Zk50OVMyNzRiT1d5UENTUFVzTFFneGlyaFZFb0QwTEViUXgzV3BOaTZhYUZ6?=
 =?utf-8?B?ZmhmWjF2LzBUUmE5SUFxSkV0SkpGZzY5aCtSRkkxT0FOLzlsSlQvMHhVb2Mr?=
 =?utf-8?B?eFQ2ZnFKem5adXZNR0FEODhmR0lqbU10eWlMWXYzRkN0NVRtaTRYcDZ5dzBq?=
 =?utf-8?B?STFtdTY4UHMrQUYzV21Kc1MwQmhxZ1grL054SWtFV3dReEdaSXNjUlFsRE1p?=
 =?utf-8?B?ZWs0dUdDTXVNMFI3SlQyd05IOUJMUkNlMngvRmdFakVjRGtQbExoV3kvbHk3?=
 =?utf-8?B?dER5UWlXOHhCbC96ajFiUlRldzNiazBmYWJUNWFIRDNtdG5WS3JudjhPcERQ?=
 =?utf-8?B?eVI5d1l6SEk0anZTYUNMbDhtdVRMa0szOGRtVG9qY3Fzc2pxd1hmaXVRODZR?=
 =?utf-8?B?U1QvOEZLSVFKOFBPNFhUb3dVTEtHNmxRQkdJTUtjbVNCVkN5VDl6bFoyRWdj?=
 =?utf-8?B?QWcydnJ2d1VTY2p0SDZkdDVyMmFEU3p1SmxuMUx4aEd3c3Fzb2Y5RUh3M2d6?=
 =?utf-8?B?d1E1SmhlSzdqT21uUXdjMUJ1WVozUHNUcjYvQlE1TzlJaWtiOHdiQkhrTXV0?=
 =?utf-8?B?SnBXczVEaUpTMWYydDdOWVljc1lkN1c3bWJrZ0hRSG1iNkpBS1pwMGNwNnoz?=
 =?utf-8?B?dlpvNVozU1FrTW4zaEo4MzEwVjUvbXQ2L0ZCS0ZxTTV5RUNseWFpZk94WVdn?=
 =?utf-8?B?V0FGbEE5S1dGTXlObHp5V200Qlo2Wm1GQStUMCt5TnFkMlJHMnl4NnFQeml3?=
 =?utf-8?Q?x226Bu9wWnPC7oNiuXYOHwk21?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34076d76-0ac9-49bc-8535-08dcfcda82cd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 14:11:01.1097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ag38gkTOZfvtEnjee1847RBnityHlnjIXRj+bBt4IACnjctqie6ryU9/bhxE2n/1Iom6IdzXQx4BgnoRvR8KhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204
Received-SPF: softfail client-ip=2a01:111:f403:2407::608;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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


On 04/11/2024 16:00, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> On 4.11.2024 09:08, Avihai Horon wrote:
>>
>> On 01/11/2024 0:17, Maciej S. Szmigiero wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Hi Avihai,
>>>
>>> On 31.10.2024 15:21, Avihai Horon wrote:
>>>> Hi Maciej,
>>>>
>>>> On 29/10/2024 16:58, Maciej S. Szmigiero wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>
>>>>> This way both the start and end points of migrating a particular VFIO
>>>>> device are known.
>>>>>
>>>>> Add also a vfio_save_iterate_empty_hit trace event so it is known 
>>>>> when
>>>>> there's no more data to send for that device.
>>>>>
>>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>>> ---
>>>>>   hw/vfio/migration.c           | 13 +++++++++++++
>>>>>   hw/vfio/trace-events          |  3 +++
>>>>>   include/hw/vfio/vfio-common.h |  3 +++
>>>>>   3 files changed, 19 insertions(+)
>>>>>
>>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>>> index 992dc3b10257..1b1ddf527d69 100644
>>>>> --- a/hw/vfio/migration.c
>>>>> +++ b/hw/vfio/migration.c
>>>>> @@ -472,6 +472,9 @@ static int vfio_save_setup(QEMUFile *f, void 
>>>>> *opaque, Error **errp)
>>>>>           return -ENOMEM;
>>>>>       }
>>>>>
>>>>> +    migration->save_iterate_started = false;
>>>>> +    migration->save_iterate_empty_hit = false;
>>>>> +
>>>>>       if (vfio_precopy_supported(vbasedev)) {
>>>>>           switch (migration->device_state) {
>>>>>           case VFIO_DEVICE_STATE_RUNNING:
>>>>> @@ -602,9 +605,17 @@ static int vfio_save_iterate(QEMUFile *f, 
>>>>> void *opaque)
>>>>>       VFIOMigration *migration = vbasedev->migration;
>>>>>       ssize_t data_size;
>>>>>
>>>>> +    if (!migration->save_iterate_started) {
>>>>> + trace_vfio_save_iterate_started(vbasedev->name);
>>>>> +        migration->save_iterate_started = true;
>>>>> +    }
>>>>> +
>>>>>       data_size = vfio_save_block(f, migration);
>>>>>       if (data_size < 0) {
>>>>>           return data_size;
>>>>> +    } else if (data_size == 0 && 
>>>>> !migration->save_iterate_empty_hit) {
>>>>> + trace_vfio_save_iterate_empty_hit(vbasedev->name);
>>>>> +        migration->save_iterate_empty_hit = true;
>>>>>       }
>>>>
>>>> Can we instead use trace_vfio_save_iterate to understand if the 
>>>> device reached 0?
>>>
>>> AFAIK there's not way to filter trace events by their parameters,
>>> like only logging vfio_save_iterate trace event if both parameters
>>> are zero.
>>>
>>> It means that vfio_save_iterate has to be enabled unconditionally to
>>> serve as a replacement for vfio_save_iterate_empty_hit, which could
>>> result in it being logged/emitted many extra times (with non-zero
>>> parameters).
>>>
>>> Because of that I think having a dedicated trace event for such
>>> occasion makes sense (it is also easily grep-able).
>>
>> Ahh, I understand.
>>
>>>
>>>> In any case, I think the above could fit better in 
>>>> vfio_save_block(), where ENOMSG indicates that the device has no 
>>>> more data to send during pre-copy phase:
>>>>
>>>> ...
>>>> if (data_size < 0) {
>>>>      /*
>>>>       * Pre-copy emptied all the device state for now. For more 
>>>> information,
>>>>       * please refer to the Linux kernel VFIO uAPI.
>>>>       */
>>>>      if (errno == ENOMSG) {
>>>> trace_vfio_save_iterate_empty_hit(vbasedev->name) <--------------- 
>>>> move it here
>>>>          return 0;
>>>>      }
>>>>
>>>>      return -errno;
>>>> }
>>>> ...
>>>>
>>>> If you move the trace there, maybe renaming it to 
>>>> trace_vfio_precopy_empty_hit() will be more accurate?
>>>
>>> This move and rename seems sensible to me.
>>>
>>>> And trying to avoid adding the extra 
>>>> VFIOMigration->save_iterate_empty_hit flag, can we simply trace it 
>>>> every time?
>>>
>>> Will have to do some tests to be sure but if there's possibility that
>>> we get ENOMSG many times then obviously we don't want to flood logs 
>>> with
>>> this trace event in this case - we want to only log the
>>> "data present" -> "data not present" edge/change.
>>
>> OK, so I guess a flag is really needed.
>> BTW, there is also trace_vfio_state_pending_exact, maybe it could do 
>> the job? It might get called multiple times but not as many as 
>> vfio_save_iterate.
>
> In a quick test run it was still called/logged 5 times for each VFIO 
> device
> so quite more often than the empty_hit one (which was logged just once 
> per dev).

Yes, that is expected.

If that's too noisy for you then the empty_hit trace seems fine, IMHO.

Thanks.


