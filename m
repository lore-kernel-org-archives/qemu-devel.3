Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA9AE77173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 09:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKa55-0008LE-H5; Mon, 09 Dec 2024 04:29:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tKa4e-0008Fc-VM
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 04:29:06 -0500
Received: from mail-mw2nam12on2060b.outbound.protection.outlook.com
 ([2a01:111:f403:200a::60b]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tKa4Z-0002BD-6F
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 04:29:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rfb6v7Vp5Edt2Esj8mK3FAq6cTjL02/0wrGrSzT8lJRf3sRCfMpOqCncaKQ5rZqp8HzrjkI/7XAwmYMjk8+1i6QPPRqg2DdsBgh5e4ZvAnYT4l7UxpCtKPiTmyf1ZGSz98cWw50ruv3ESRtRTr5j7nYDYsxxBijKKFhJCIRFfdUDyR4opkRFN68rDnLnpuDr+xM87kZVfDL6OTKxb127pRyWoXLgAeQJkwNuEQC+s3WdT9KS/Bv6MwFV261yudQ2eRnvjq2VBeTLB/FhYLo/0JkDx9jbexobU1F7XaddGdepIXHMw1Ha11h8fBxiqiyOmYD4dldC/F00nhYH2WMINA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyDdaZAt0NlIsDo7PeyCZ1Crspad+q1/gpisnRVGNjo=;
 b=G9F/d+hJSshugrPO/dInsdZDvEvmdoRgc6J6LMLg+uxbvj6aytpPu3fM5pw25jINlNBnbgum15MeXBm/q3bcOWm5FoGvEk5BsSEx5CGhRdT0EVg7kSR1m/wB6JvSCYrf/pSxenb6p+dcUvH2F9xbmZUN2/vukMoyUJARLVwcD45TJYC87mbUpSWWx6mjDb3Dz7HnLPSvRHm0nS+ZxzQNTkC/P4Xk/iT0UeAYnRARt2ilCtZZvKKhDkGQCyIZnlTGOIDYHfNQPp5UzeE1Yk6Oe+o2S+1iusm+lUUv2rz8aGkc1WJvrOa9VIl9jg5og1IP70BZOyk/rO1ebbIHCH7exA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyDdaZAt0NlIsDo7PeyCZ1Crspad+q1/gpisnRVGNjo=;
 b=cJG9GHIYP1oAmgVpViR2DrkLH65b2w/cDSr1n1jsqSk0Hxeq2sO+PltO1mQ5Likxxj//tak+A12JPU/GGtOmVAPbaAm2IObMVBce6kCEN7tu1EUFcfoE7HZk6UXVbeWoYIBj/XykhgOJPtIFWWOxEd2m6egbRepQ/9mSvAiPNH7+OzOSWvBOALE/HuVTtrVcyVmTdwoUStRXOmbRgFhaUqGpBxRXW/f7DtCBrBM13WNW1iIt+pDNN+S43UFHlJECFXVvQVYusrxizra3iNWT9/Wia1D/IXc3RuMdJPZxUdFzOfRUvKZ7M3hki9G8zNdTIxQJntKqQV2v6R4bdHj35A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 09:28:52 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 09:28:52 +0000
Message-ID: <51279885-5229-4c5f-93af-d1214dd65f90@nvidia.com>
Date: Mon, 9 Dec 2024 11:28:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/24] vfio/migration: Multifd device state transfer
 support - send side
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <4f5c33b97be09fcb4e1885073e31c5e930a39ad0.1731773021.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <4f5c33b97be09fcb4e1885073e31c5e930a39ad0.1731773021.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::6) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a0de17-edb0-4205-0998-08dd1833e526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWNCMGp6aWl1bWMvS09lZVFVRDZxQXdRQzVNeVM2YjcvMXVSQzFPaE1KdEtC?=
 =?utf-8?B?QkpKczh2L2FKaW5lYzN4UlNFTEEycXJ2NlpTRFFkSXJLdWNmaDY2UVhFR1p5?=
 =?utf-8?B?WndoMkE0VGxYNWlmZ2lNdmN1d2hJQkRpbnc3MUdVOUlwU0RBbnpyZC9JR0cr?=
 =?utf-8?B?d1Q2MnN3bGFkemhVd0IrNVljbjFFT0pwWXVJQU9qWEs1ZHZ6cm0wZ0hIbC9k?=
 =?utf-8?B?SGVsOWhtUTBJYkg2Q1BQS2oxQ2JpNTlDcVBqV2FzMGxMbGlHaVZWSHNZMDZW?=
 =?utf-8?B?Q0xGdGhQVTV0ZDUyYkN4NjRsdDhkRllONDREVVhkVFNJR21Oa01IbDU4bEMw?=
 =?utf-8?B?SlladkUzYXp6NWV4dStGb1ZSQzVVNU1NZWF5WmFSZzdwYVFZVkVGOHJTUCsv?=
 =?utf-8?B?T2Y4MGViUE9WMHl3eEFjNzJtNktUU2RpUC9MMXprSjB0YUJQbFFrbEVsTEVl?=
 =?utf-8?B?dkJXanZ2LzBncDJQS1BZcnVqNTBMRFZ5TCs5YVhla0NVU0FYQmllNWJkUmxN?=
 =?utf-8?B?SUd5MVB2N0RGcDJ1NFRhUjl2bENTVWRaeGhwS2hqS01HUVRDckVGbzB2Q1RR?=
 =?utf-8?B?bFg1dTJFSXpaRUhPYTA3Skcvb1FnUjJMSGx6MDFBOSs1bTFXRVZmQWhuSWc0?=
 =?utf-8?B?WHVpaUZsdGx4RFNjWUpQSk16U2N4eU56VitFOHhZa24weEdCVEwvSVRtRDVI?=
 =?utf-8?B?a253K2w5YkQwS2NnNzJnR0MrSFNCajVZdWlWNzlsUzJzVkFXa1IxWTErak5y?=
 =?utf-8?B?MTJ0WGtkTk9BSU12M0N6UjJBZGpHbjByeU51SjBIcWZGTmUxckNZcXErRmRD?=
 =?utf-8?B?VTk4UWp4ZXo5WnRzT3V6a2wreWordGptZ0xuUGVDUnBZdVBCZldkTFp0TEpY?=
 =?utf-8?B?TVV0OURoZThLNFROUnBpbk9IMlkzN0xiOWNWVlRGVEVXQUtueiszcEdLbWk3?=
 =?utf-8?B?akxBRWUvU2lJY1pldVBkekVWdURTVzVtckx6MEtmeU16SWZUeFZzWnVzMldF?=
 =?utf-8?B?NHlaeUI5VW13MklYMUtQRVMyaU5wS25UTzRrRTdGeFlNcjdLTHY3RE5LSWY3?=
 =?utf-8?B?cDN3d0hNeXFyKzZnR05jT0FKNkZxZlZXMU1hNHk4ZUpoa0Rsa3A1QldFbmJP?=
 =?utf-8?B?TFVIM0Q2TTl4VUZvK0FrdDBjVjlZc2diZ3lOYzAzNyswWFBqOWNnWFpxbzVm?=
 =?utf-8?B?aExKN2F0MmNKNlRWbStsNXYwckV6SGZEdjZ2WXI5bmVZZlU0L0lNN28wSytT?=
 =?utf-8?B?UVdkWkxLQ0VrUnFiTEp4WDV4WkdpOCsvNVp2NFFZOFlMeWtValBrT1JnYW1S?=
 =?utf-8?B?NkVNam43Tjk4YlowTmU0K09jL1lQMWY5NFVSM1NOVHM1YTZEMVhPc3N2UXVO?=
 =?utf-8?B?RXBYTVV2UjFIRXhlb3NJNFJoMUNlQjI3Um15U2prTkVvcUlWNUJGbWVWUkph?=
 =?utf-8?B?Nmt2WTI4dEtVc0Y1Zi9OTGx5S3RIL3VjdFRzVU5DaXlSM2tPK0hObXZPdkhz?=
 =?utf-8?B?cmJZSzEwZTBreTRhdGwyNElVRFRudHJTOUI2VVpJRXVwdS9vbGtiNmFhQTJ1?=
 =?utf-8?B?RUR2ZEwrYURVNG5iZWY1QkloQzh6ODJyNHVDZ2dMYVVvS1dla3BDM2FOcTBN?=
 =?utf-8?B?Q2RqYW81eENubW4vR1RBeFBLWDVyT3F4dkxLc2VTYXNRVjg5bEo1RlhPbnlO?=
 =?utf-8?B?R3E1V1ZTNmI4U3FBUUtpaCtXOU1STVZpQzgwUjJYbWkvYkdPZG9vY3E0UG4r?=
 =?utf-8?B?MVU2ak9zT2FxMHdDcDc5ZEZZcCtwODlqcGlWVmp4YUpkbW5CbGdjYTFrd0Y5?=
 =?utf-8?B?ZGlqYjBlMEFHMjVEbW50dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnVzeXBtUkR3VlR5Q3lkaTZ5YkFYcE40SFJNOVpqNi9Ja2NxdVJaL0FaMlYz?=
 =?utf-8?B?RCtWOW9kUFNJdDAvNEszVmhrVUxBbVhsc1pQcXZHYlhWSWdPaEJVWjZmSnZl?=
 =?utf-8?B?WGtkR2w4bG1WUlYxd0d0NzlPNElwZ1c4Z0pFN2pYcUVGUG5kbUJtVGFDaGJv?=
 =?utf-8?B?LzU2cDAyeVN2U0xTNVVNVWppNEtWTmFlSWFXTG5RaWVqK3Avcklad05xODAy?=
 =?utf-8?B?SFZGR2JUdTJmSXVFYm9uYTBZTWo0T2xqdzdFU0pKSWdwN3BMS2dMS3ZpV0Na?=
 =?utf-8?B?dzNpMlUxQjFsVFIxSzEweGUwUzNraHNHUVZvT1VOeDhIbHpXZGZNblk2dmJh?=
 =?utf-8?B?dXhLSjhCVnp0RmplUEFoUzREdzhmMzhZRFFtbk9FNVN2Y2ZsQTMwZkM1Mnpa?=
 =?utf-8?B?eDNKZkRLYzhQMGlPbUtrL0JBaFE2VnV3THFNSUJYRFZKcTcrdjVKS09mTlc3?=
 =?utf-8?B?dUJxTFphU1JKeGUxcitnNE50cXV1TkNtdVhFUW16S0E0eWpOdk9EWnhQbmdS?=
 =?utf-8?B?clU5UG5EZDNUUldpTktWbkRaMzh2cHhsNEZ6dTUrNHNNbmFpN2lXdWZpNE5M?=
 =?utf-8?B?Y0ZSbTBCL3dGZjJGOElUWWRmUzBBT3JiaUdjcUJuWC9sME84cjB2VmlDSTlV?=
 =?utf-8?B?MGFLNDl6MStmeXc0WEliS0NlRTJ3MlVxNWtqVHkxTjdHRUY0dTFjamNxTHZu?=
 =?utf-8?B?WG5DWGVaNldkQWNKR05WSUxxc0syMzVYRFAreWhydEtzbCtzdmRoc1UrNE1o?=
 =?utf-8?B?SVRoZlVZS01McVRKZG1iTXN4VURJdXB0MSt2TFh2N3RKdGZkM3dnSXNaRWxl?=
 =?utf-8?B?QlVGd2Y1MmRJS09YQys5NGFoWG5yZ2RsV2xNZmRrUkdpcEVwdmZQVm5JdmdD?=
 =?utf-8?B?MFpsaktoVldoRVE4eUllTWlVTk4zdTJ6ZE5Pd2VNN3VxeW8xRlFmN3ZkM0Nj?=
 =?utf-8?B?TFRrTG9BQzAxTGcrNUFpVDl1ZjR6S2taK25TOTl3SUVJOHgvQW4wYUJXOHpZ?=
 =?utf-8?B?OUREWXdWMkY2VXBhMGM0U0hMRWY2UU9YL0w4STNCQUVSWnRxQ3V0TVFPQVRN?=
 =?utf-8?B?dEpTMFE4eHBCdTdXUkY4ZnZPcEJzc2xkYnVEN2lNY3ZmTUVPM2lzMytrUDNl?=
 =?utf-8?B?aWdQeXUxbW0xalpqWEtpUnNUM3hHM3ZTZU5hTFhOdGNPRnhVVE5lbUxYV0tM?=
 =?utf-8?B?VFBUUE5TclNXMGdqVnlqK3o2ZnlIdkJpTjVHcG9LTCszRUNLdWFwTUhob2VG?=
 =?utf-8?B?MGRERTBKOUlZcm5zVGxmdUxrdW5hc1Q3MUlWU0g1Y24zUXZ1eGhGTGViaEhm?=
 =?utf-8?B?NGlRb0ZhR2p2ZTlpUmo1WUx6bDJBN2Z3dmJoZE41cWFhenhrNGhXelQvZHd3?=
 =?utf-8?B?b2I2QlFBZldYdDdSL3A5clk3djhodUxPeEJpYjdVcklENmFCWVorakszYjZK?=
 =?utf-8?B?cC9ZK0JSR2hieDNtcnNUSzQzbEI4TkRWcjRMYVNQeUxubi9pbzZmR0ZJKzBy?=
 =?utf-8?B?L3JyL2RDbXc3TEMvQUFCdDBPTEF3cVJTNytsZHFTYnF3cmJWWWJsTlhuL1JG?=
 =?utf-8?B?SUVLYVpwVlhmdy9XOVFWTGQwZlhQZlNRa1ZiVUpSRDJqWVJEWGtNYUFqTzd0?=
 =?utf-8?B?bEpLdXhNenBSc1lBNExpbFNHZ0NySlFNWVdkbkNzT2VXWmZhZ1AvbE02MVBK?=
 =?utf-8?B?RTNXeCtVbEd5Z25PY3lZT3U4b2N6dnNrTldKV204dFNJdzJHMVRpRHNwUlho?=
 =?utf-8?B?ZVhsSnVOZWgzT0NTb1NPSmtGdGxlRUJFcDNud2YvZjBrQUlMbFdUakluak5J?=
 =?utf-8?B?ZElMQXc5Mk9kSW5tbzFFT09wMmZBenBMRlI2MllwM3NBcFdvaXVWZHpJTGYr?=
 =?utf-8?B?ckpndTdaMjNxK1M5dHNuZ0JMQTZMcVE4dE8vUlVYTEIySEVlekdaeGpiVzRs?=
 =?utf-8?B?TkRmUXN6R2FnWWZkOHB1Z0tOWnMwK3lpNmk0cFZHdERkbGZlY3JxdnQyKzRt?=
 =?utf-8?B?ampCZTJXV3Z1b3FOWFcwUzliMEl1c0Y1cEUxOWdPRjBSQ1RQM1JxOU1hVnAr?=
 =?utf-8?B?UURJUTJjNFVsK3RBMlpqbkN5d3pSbjYrWUVUNHRnNE9HTWxnVlpLTENCZndt?=
 =?utf-8?Q?5M6HzU/pe4jFLmstCYNMSjFdU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a0de17-edb0-4205-0998-08dd1833e526
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 09:28:52.5535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OltD/XblgZHG+WYHm+4oq/VP0Nwnw9htKCy2lqL9sQa9eq8kwDMTJVDTkCrgcpSKGBPdB0hGrqdmMgC183vJxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643
Received-SPF: softfail client-ip=2a01:111:f403:200a::60b;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
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


On 17/11/2024 21:20, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> Implement the multifd device state transfer via additional per-device
> thread inside save_live_complete_precopy_thread handler.
>
> Switch between doing the data transfer in the new handler and doing it
> in the old save_state handler depending on the
> x-migration-multifd-transfer device property value.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration.c  | 155 +++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/trace-events |   2 +
>   2 files changed, 157 insertions(+)
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index b54879fe6209..8709672ada48 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -771,6 +771,24 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>       uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
>       int ret;
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
>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
>
>       vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
> @@ -942,13 +960,32 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
>       return !migration->precopy_init_size && !migration->precopy_dirty_size;
>   }
>
> +static void vfio_save_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    assert(migration->multifd_transfer);
> +
> +    /*
> +     * Emit dummy NOP data on the main migration channel since the actual
> +     * device state transfer is done via multifd channels.
> +     */
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +}
> +
>   static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
>       ssize_t data_size;
>       int ret;
>       Error *local_err = NULL;
>
> +    if (migration->multifd_transfer) {
> +        vfio_save_multifd_emit_dummy_eos(vbasedev, f);
> +        return 0;
> +    }

I wonder whether we should add a .save_live_use_thread SaveVMHandlers 
through which a device can indicate if it wants to save its data with 
the async or sync handler.
This will allow migration layer (i.e., 
qemu_savevm_state_complete_precopy_iterable) to know which handler to 
call instead of calling both of them and letting each device implicitly 
decide.
IMHO it will make the code clearer and will allow us to drop 
vfio_save_multifd_emit_dummy_eos().

> +
>       trace_vfio_save_complete_precopy_start(vbasedev->name);
>
>       /* We reach here with device state STOP or STOP_COPY only */
> @@ -974,12 +1011,129 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>       return ret;
>   }
>
> +static int
> +vfio_save_complete_precopy_async_thread_config_state(VFIODevice *vbasedev,
> +                                                     char *idstr,
> +                                                     uint32_t instance_id,
> +                                                     uint32_t idx)
> +{
> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
> +    g_autoptr(QEMUFile) f = NULL;
> +    int ret;
> +    g_autofree VFIODeviceStatePacket *packet = NULL;
> +    size_t packet_len;
> +
> +    bioc = qio_channel_buffer_new(0);
> +    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-save");
> +
> +    f = qemu_file_new_output(QIO_CHANNEL(bioc));
> +
> +    ret = vfio_save_device_config_state(f, vbasedev, NULL);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    ret = qemu_fflush(f);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    packet_len = sizeof(*packet) + bioc->usage;
> +    packet = g_malloc0(packet_len);
> +    packet->idx = idx;
> +    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
> +    memcpy(&packet->data, bioc->data, bioc->usage);
> +
> +    if (!multifd_queue_device_state(idstr, instance_id,
> +                                    (char *)packet, packet_len)) {
> +        return -1;
> +    }
> +
> +    qatomic_add(&bytes_transferred, packet_len);
> +
> +    return 0;
> +}
> +
> +static int vfio_save_complete_precopy_thread(char *idstr,
> +                                             uint32_t instance_id,
> +                                             bool *abort_flag,
> +                                             void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    int ret;
> +    g_autofree VFIODeviceStatePacket *packet = NULL;
> +    uint32_t idx;
> +
> +    if (!migration->multifd_transfer) {
> +        /* Nothing to do, vfio_save_complete_precopy() does the transfer. */
> +        return 0;
> +    }
> +
> +    trace_vfio_save_complete_precopy_thread_start(vbasedev->name,
> +                                                  idstr, instance_id);
> +
> +    /* We reach here with device state STOP or STOP_COPY only */
> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
> +                                   VFIO_DEVICE_STATE_STOP, NULL);
> +    if (ret) {
> +        goto ret_finish;
> +    }
> +
> +    packet = g_malloc0(sizeof(*packet) + migration->data_buffer_size);
> +
> +    for (idx = 0; ; idx++) {
> +        ssize_t data_size;
> +        size_t packet_size;
> +
> +        if (qatomic_read(abort_flag)) {
> +            ret = -ECANCELED;
> +            goto ret_finish;
> +        }
> +
> +        data_size = read(migration->data_fd, &packet->data,
> +                         migration->data_buffer_size);
> +        if (data_size < 0) {
> +            ret = -errno;
> +            goto ret_finish;
> +        } else if (data_size == 0) {
> +            break;
> +        }
> +
> +        packet->idx = idx;
> +        packet_size = sizeof(*packet) + data_size;
> +
> +        if (!multifd_queue_device_state(idstr, instance_id,
> +                                        (char *)packet, packet_size)) {
> +            ret = -1;
> +            goto ret_finish;
> +        }
> +
> +        qatomic_add(&bytes_transferred, packet_size);
> +    }
> +
> +    ret = vfio_save_complete_precopy_async_thread_config_state(vbasedev, idstr,
> +                                                               instance_id,
> +                                                               idx);

I am not sure it's safe to save the config space asyncly in the thread, 
as it might be dependent on other device's non-iterable state being 
loaded first.
See commit d329f5032e17 ("vfio: Move the saving of the config space to 
the right place in VFIO migration") which moved config space saving to 
the non-iterable state saving.

Thanks.

> +
> +ret_finish:
> +    trace_vfio_save_complete_precopy_thread_end(vbasedev->name, ret);
> +
> +    return ret;
> +}
> +
>   static void vfio_save_state(QEMUFile *f, void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
>       Error *local_err = NULL;
>       int ret;
>
> +    if (migration->multifd_transfer) {
> +        vfio_save_multifd_emit_dummy_eos(vbasedev, f);
> +        return;
> +    }
> +
>       ret = vfio_save_device_config_state(f, opaque, &local_err);
>       if (ret) {
>           error_prepend(&local_err,
> @@ -1210,6 +1364,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>       .is_active_iterate = vfio_is_active_iterate,
>       .save_live_iterate = vfio_save_iterate,
>       .save_live_complete_precopy = vfio_save_complete_precopy,
> +    .save_live_complete_precopy_thread = vfio_save_complete_precopy_thread,
>       .save_state = vfio_save_state,
>       .load_setup = vfio_load_setup,
>       .load_cleanup = vfio_load_cleanup,
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 418b378ebd29..039979bdd98f 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -168,6 +168,8 @@ vfio_save_block_precopy_empty_hit(const char *name) " (%s)"
>   vfio_save_cleanup(const char *name) " (%s)"
>   vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
>   vfio_save_complete_precopy_start(const char *name) " (%s)"
> +vfio_save_complete_precopy_thread_start(const char *name, const char *idstr, uint32_t instance_id) " (%s) idstr %s instance %"PRIu32
> +vfio_save_complete_precopy_thread_end(const char *name, int ret) " (%s) ret %d"
>   vfio_save_device_config_state(const char *name) " (%s)"
>   vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size %"PRIu64" precopy dirty size %"PRIu64
>   vfio_save_iterate_start(const char *name) " (%s)"

