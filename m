Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D231E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 14:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNCNb-0008Ht-70; Mon, 16 Dec 2024 09:47:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNCNN-00089E-KQ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:47:17 -0500
Received: from mail-bn1nam02on20613.outbound.protection.outlook.com
 ([2a01:111:f403:2407::613]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNCNK-0004Tj-PX
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:47:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lX2ZRkVZJpbX5QigjSEEXw2R34sZHvZNrjcgWg9fh4Q2xJFOax9iK1pqQlAICJcwAWgu5HpLQPxaMJEyCrAAysFz2zKw54Vc/C8JCWageZf9MeabmA7pZmqyFW+ykl4IOeAm0RdTOdnWYNaRBLr6MEEv619SrLcw01rMxWuOQ7g3iNWPFuTFwbq9429K81qWRJCL293Iaz7u/yxFy+N/SeTolp07lchdvUHb8azhO2/F6COxigvjVdW9i095NjbxuyCqM4L9lwGgcTLNqxro3US76tTpPzmZHYkhZF0vYidTBON0HEXW0WL1KGidU1hRUi/uhY/x/0g/0PGBca3PnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuKVp+UwgYGvKkeR4Ns2kuXDkH0SAZpIZvEGwVAvuh4=;
 b=G6mEkSQ5uZ/y4u+7tmct/Xulrw2tfMNRqg1Gh765dQd/zbn/JSzdzvHFVFK27amuvACknYZCE6EXu9lRnrWDUhvbeUlblW4YdPxiInbxmWFik9DPmVKIjtHyPQGMN7yp7svjLyBnkF2PUarwkzeMe4rUWffhS6X6j0T8EKHEHdeWrMTuCiq2erpEh0SnT9OEigonK5n3BIwSR/F29+Q2dZX4gLToJK2CRUAUYT1IWoVNvAiq+GnFFi71DhPhbA+zjw0KExL4gEUBNuNN6CXB/Vr1I1ZN6nd8sNDQIX7MH1tH3qY46vzm6iFZtIWTyUYxIaGnmFoH+nOtfye14xlPsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuKVp+UwgYGvKkeR4Ns2kuXDkH0SAZpIZvEGwVAvuh4=;
 b=n8MHrz2kSx+x+CM/HuPl0a4s27ewCIy23sUqHhC4dPC2IMZcEcpKK8SuzrCM4FxDFGaNcHK5fRfoMVn+xgEsYCBgUUf2/bVu8MGfh9nyjbm89O3reBkd+Wh9Oay0zINKLKs7QWxmEZxU6sPRqe0Os1ho0qpmX6RgsyZ+ajuFtX3czb5IRRJSInkjgRP2tcQHPlkq79gU1Aiv3Vo+4igFZ2iByUT3SqYvY7+2iitfLqOg8xrVaKEduQY1uT5eK1FNZf1HeSv9Usm2hJqVkAW5WQ/tMpUuzrx+vwR/9pASit5NHc1ph9qn1OrxlNAilC9rdyo5s/jloyNu7HdWdXwwFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Mon, 16 Dec
 2024 14:47:04 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 14:47:04 +0000
Message-ID: <45da80df-1110-47cc-9a2d-91ea4d1ccdf7@nvidia.com>
Date: Mon, 16 Dec 2024 16:46:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] vfio/container: Add dirty tracking started flag
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>,
 qemu-devel@nongnu.org
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <20241216094638.26406-2-avihaih@nvidia.com>
 <6aeef4b7-728e-47e8-b51f-eb2870d6df7d@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <6aeef4b7-728e-47e8-b51f-eb2870d6df7d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0290.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::20) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|LV8PR12MB9207:EE_
X-MS-Office365-Filtering-Correlation-Id: 180ac0ec-6da3-4dc3-82ba-08dd1de081dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVJWQU5QejRxV2pQcUhUZE9vMkRmRnk1SWF1anN1TXN1Sko3ZFNVMzF0eUhx?=
 =?utf-8?B?aUZzTlVzekM3SHpadU5xUjUrck4ybjMzeXpsREFmVHhpalRzQ3B0NXpTOVRS?=
 =?utf-8?B?aVV2bmpuRHpFY09tSXE2a2pUWHRsakw1THpVaXI0WGpHdTNpeENRTnRwbkl0?=
 =?utf-8?B?cnUwSUJnZHUvWHZWMmZsMFVzTFM5endyUE5WaEh3YzlWZXFxaVh1Z0hFTk1k?=
 =?utf-8?B?RXJMK3R4TFF6ZzJ6RDVkanAvME5SdUFnYTZ0ZVdZdGdTanZaK0o5K01pWnNW?=
 =?utf-8?B?UkVuLzI0b2g5cEU5SFJsRVNjZG9PYSsyUmVsY2R5K1NEU1NuZS9yNkxGa0hn?=
 =?utf-8?B?VHlGeWxEdk9yTjQ1TStLU2JFbVZiTVhadTZNekxJWWM3Q2FySDZBWnNwVFQ4?=
 =?utf-8?B?NXdnT2VEcGt4Y1VhRGVtUDdEYUpURUxDMmZjcnBvVmFDNzQ3OVZTSXBTSkpP?=
 =?utf-8?B?TE5paFdPUTRaZlRRQ01jSG43Z1BCdEJUajhhV2lQZEpScW5uaWFaVFZaOFF3?=
 =?utf-8?B?bGN4V1dUdEhEYkM5bVFPSXJxRUZmdklHMnYxY0EvME1oRGtTMHR3YkVNajlS?=
 =?utf-8?B?dXMycWVmNEIyRnRSOVRIWnduUzlSSkRUem1IUHhNNkRGeWZETmVoczZMcmlU?=
 =?utf-8?B?a2xncytDdGJBd1VxWDJxd0pYQmNCQ1I2Z2ZrUmFXc0t0ZTBXejRJbEgvdzRx?=
 =?utf-8?B?aU1OZUJsRE0vNlZQUEJIdVN1bHlxVzlTa0JjdUxGamtOYzh4aE50WWovM3d1?=
 =?utf-8?B?Sy94RFliKzRqNG9qZm5vMWxrRDRCcHAydTRwOUVheTBZK0RYMjlTRk5JRVpr?=
 =?utf-8?B?ZGViSVVRNjJ1NmpQSTd6QjRmUnJmdGI3dUU3Q1pNVTJIRVBwOGtIcXhWQTdr?=
 =?utf-8?B?elBudnMyK3dkZzVqQXZJdU9GZ282UkwwUTBuaDJOMi9pR1ZudmpKWW1CNnNW?=
 =?utf-8?B?WEJwQUF6ZU9PQ1ZWbzBVbTNPbElyZ3VlbHRVcmM2Q1Q3UmZrV3dQYUk1VEcy?=
 =?utf-8?B?cklFUFh2bzBjNGFxQmRFR0VkbHNXeXZXWWxuaEZCcmVlcnFYQ1ZhRWZhOEN0?=
 =?utf-8?B?ckVGaUFTY29rcDg2RlBldkdwaHUvbG9iOTFFZXRKVzg0ajEzOTBvbUErS1ZX?=
 =?utf-8?B?a1NTYjdPdkJCTlpYaWxZb1A0SG5LbytWUk8vVCtNZVZML0NNMzJJdnllVkVN?=
 =?utf-8?B?clkrTzl6SFNOdHlpUUFLOVFzVGx5ZWNsOWFMSHV2dTc1N25NaGU3N1M3WDgv?=
 =?utf-8?B?Y0gvejFyUVVLR3VJNGxjbkpySGVDWVFVanJmQW8xYVlJN2NKMk1UdmRvU3Q0?=
 =?utf-8?B?a2paOEN4SVRFYmNtQ01WdTNyUmgxZU1NcmlGYXpuQTlCblJzS21SKzNBYmtU?=
 =?utf-8?B?LzdrQ1Mxbi82NkJlczAzSTUxZzltK1FUUEdOeGszb09PbEltMHZNaWIrcEl6?=
 =?utf-8?B?VzVtLy96YXorQXF6YmxRWW5SbU9ORXJPZytyZkZ6NUh1ZTROMlJtbFZCRExp?=
 =?utf-8?B?TmlxaGRhbmFOdDZDcHdqdVRieFBGdnhqOWlITUdZZEpRVW1pbmNMZjh3SDNN?=
 =?utf-8?B?NEVuSVZXQzliYjlFR1VtTUNSV2JiYjkwSkpBZDZhOXBhWnVpaHA0NkVkRHRO?=
 =?utf-8?B?aFR4c0EreU5JbmhNcjJ5MDFVQXBwVjE2TTExZmt0WHhTcit5OWVFTFFQTnc5?=
 =?utf-8?B?UXFTaW5KcHhkQWVRQVh3b2FMeVZuUHZhNjRkenc1eW1HNmFwQklPQW1DZ1Jt?=
 =?utf-8?B?bmt5VTJqOCs0UnoxcWFuODBnWjNPZGVKSTMrajk5R2NUTVVVYXBKTzI1MHV5?=
 =?utf-8?B?Vm1ubVY0eHdLR3MzMkptenRpYXdMS3ZZN3l1bWJXSXV4S3JzSWNuV1VNOGhq?=
 =?utf-8?Q?F9bf2CUptNjiE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkJ2OE9sTWtUUDNndWN2bkRDS0VmRUhFVU8yYWdGV0pxOWVyd2x5SWFUcS9G?=
 =?utf-8?B?WURsZjBtS0dhSDhxaTJudTVtOEIvMjhWSzc3d1NUMElkSTFyeFJtV0NpLzQ5?=
 =?utf-8?B?Mlhqd3F5cU1WV21iVW1MemZaOFVBeEFIdUNuUlYxQ3dGZTBvVVZMMmJVN3pL?=
 =?utf-8?B?b0NYUGdUdXlkVFRjOHE3Zzc0a2NyOWYybUh0ZnRJcVpndkJxbkFFRjRqaW1J?=
 =?utf-8?B?T3RWKzlFSXl5OWZVZkxLdktpSytZSWl3ZW5qajZycjV5VTlQWUVtdTFzVXdH?=
 =?utf-8?B?eFY2QmdTOVpUdE12T0NNd1dTQkhvaEU2R2RHZkdGNDFwVUlwcXNkU1J5ODlM?=
 =?utf-8?B?eHlyNitDd0JBTk12VVd4d1NYTEFRZzhQNmlLNzd1eDRGZDNWTXl2L2ZmRUpj?=
 =?utf-8?B?UG8zbkFhS3F6ZnRRZ0lQZzJRQ2FVdzJiMnI2eDZNbUFXMHVkVE5qTDRQU1lU?=
 =?utf-8?B?enVNMUIvRjVMZnkzVUo0YVZkMCtGdk0rSnRaVExDWTZBVmlPNTRXWTVjRFp2?=
 =?utf-8?B?MXpNR2pZRDZuNHNGTnpTYmVjc2FuWGhtNjRDRk05b2ZhL0kwZ0QvSjJ0eWxM?=
 =?utf-8?B?djBlcGRHSzlrMmtkRnBDcW03bjM0ZXE0VFNuMmsxWVdYd0tMcjRiYjhMRVl2?=
 =?utf-8?B?eHFUK0F0NlVlUjR2UTVTMXpBVk4yMUpId0xDTEFnaFVVYkNmcTV6cTlsbkIx?=
 =?utf-8?B?b3lnNk5ZOVhEQ21oK290WnNQS0R1dzFVcHZFWmt5WkFldWt1QXlrQ3hQMmNK?=
 =?utf-8?B?MEZjckk3cDVuT1Myd0Z3K0RNUzJ3SGkxSFB0Z1Mzc0NpZk5laFdGWHF2S2Fl?=
 =?utf-8?B?RzhDdFBTanpaNmZZUFdlWEhuUTFmM3NhcWZjZTNHZFFxdnNIVDYra3p4Rld4?=
 =?utf-8?B?SVNKSnh2UWdBak9hNFdxM0VYUTZDbDBBZkhBNVR6cU5JUnR4QXpKek5hRmli?=
 =?utf-8?B?SkRRMmltNzBmVlJtVDBROHlhcHRGS29xbkp1NzlMUVh1aUtyaU5kMFJaTTJy?=
 =?utf-8?B?SDVWME9hRm5wYVZVVEJ5MHNpU3JhMXU5ZHFIeVN5S1hEMnd4dDBTWFZKbXJP?=
 =?utf-8?B?M1lwcXBEQ0o3dDdqdE9PR1NLOURuTVVPNm9UNW5xV09tTFVBZ2NQT3lDU2p4?=
 =?utf-8?B?RnhGd0NRdDUwYjBWb1hrOTNJb2RkZy85SFdYcUwwUEwrZmRnREZGMERjcmsw?=
 =?utf-8?B?emQ0Mi9ZaW1ZZ01lT2FmTU9IZ2VxRmVCWTJiWUVPYWFpSS84dDVBMHF1ZjJW?=
 =?utf-8?B?RlRuU3MvSmovQW5NdHRWalpyTW1zM3VQcnlxS3JzRnRjSEgzVGVleU9lNUV3?=
 =?utf-8?B?UTgwMThMS2xvamVSTXFiQUxGVldBbVphWXA4dlR6T2gvUjRhOEE4SzRhbWJt?=
 =?utf-8?B?UUUxOUxEaHhmaTJaKzhaMFZvcU5WTEI5Qy81Q1d6VUIzMmlVMmhOZFZxWGlQ?=
 =?utf-8?B?UFA2VzMrNkp3TTkvbTZ4SFNKb1RHMGFGbXVRbTQxUzREd1pqWnhvY3ZnczBl?=
 =?utf-8?B?SXJHb0ZuUUs3TjNoa2lGaWRCWVMzd00rY21kMUNjbjBqMWFJNEhvK0hFZi9I?=
 =?utf-8?B?QVdoVzhnQmp0d0M3SUI3cUU2RUhmZ2xlaVhwMERqL05sZWJnWkFOS3o4eUxP?=
 =?utf-8?B?TmlqdVIyRG9pVkRLYk44amttQUsreDdpajJhb09QK1o4cW9nSG9uSklFNmpi?=
 =?utf-8?B?cE1CTEFDKzFJTDd5NzJ1QmNwaTB1Y3ZwckZzMkwyYStGdGdrc2IyNnhpR0pC?=
 =?utf-8?B?VzhkWnhpSGlnaVNaQ2dGR0Jpcjl6R3VPTEdRZzhacytxRHpJc3VTY0V0aUxZ?=
 =?utf-8?B?dC93NXhhL0pJTDJBTkVNTmllWHRhc084WHhJdWl1V0pERGg4UGd4Z3pRaDlp?=
 =?utf-8?B?dWZoQmdJb29ISnFGa2RoV000eTAxQ3FVSE1tZzl2MDFnaHJtUzFxbittdE8r?=
 =?utf-8?B?cng3dytpWE84aWltcHM4U3llZC9FdFpGcUNtRnN1c01QNlFmN2xITjZzLzNl?=
 =?utf-8?B?eHdOVkpPNlpsNS9BelJoNnhoMkFPdk85T1BLamdNUlRrL2Y5dGZUWWpHMStT?=
 =?utf-8?B?SjBnNHBRZ3VaVEhHcVgrUlg1cXRaZkZ5SlNwZVhiUy9Td1VqdzFyOVVWT1JV?=
 =?utf-8?Q?GeM8rDKcgvusz0GU+pfFpKN4+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180ac0ec-6da3-4dc3-82ba-08dd1de081dc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 14:47:04.7286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCIcjt3TDoIKss7hHv6MtByLP1ypLshRe/S6J2Lu3wf4tnFVFlGIu6V20a5NkNhwEJ+73kH7wRnPsEElSlShgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9207
Received-SPF: softfail client-ip=2a01:111:f403:2407::613;
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


On 16/12/2024 14:15, Joao Martins wrote:
> External email: Use caution opening links or attachments
>
>
> On 16/12/2024 09:46, Avihai Horon wrote:
>> Add a flag to VFIOContainerBase that indicates whether dirty tracking
>> has been started for the container or not.
>>
>> This will be used in the following patches to allow dirty page syncs
>> only if dirty tracking has been started.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
>
> Just a nit below, but it's optional.
>
>> ---
>>   include/hw/vfio/vfio-container-base.h | 1 +
>>   hw/vfio/container-base.c              | 8 +++++++-
>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
>> index 62a8b60d87..4cff9943ab 100644
>> --- a/include/hw/vfio/vfio-container-base.h
>> +++ b/include/hw/vfio/vfio-container-base.h
>> @@ -44,6 +44,7 @@ typedef struct VFIOContainerBase {
>>       unsigned long pgsizes;
>>       unsigned int dma_max_mappings;
>>       bool dirty_pages_supported;
>> +    bool dirty_pages_started; /* Protected by BQL */
>>       QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
>>       QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
>>       QLIST_ENTRY(VFIOContainerBase) next;
>> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>> index 6f86c37d97..48fc75cd62 100644
>> --- a/hw/vfio/container-base.c
>> +++ b/hw/vfio/container-base.c
>> @@ -64,13 +64,19 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>>                                              bool start, Error **errp)
>>   {
>>       VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>> +    int ret;
>>
>>       if (!bcontainer->dirty_pages_supported) {
>>           return 0;
>>       }
>>
> It's a nop when no state is changed; don't know if you wanna capture that here.
> Something like this below now that you track container dirty tracking status:
>
> if (!(bcontainer->dirty_pages_started == start)) {
>          return 0;
> }

I guess you mean:

if (bcontainer->dirty_pages_started == start) {
     return 0;
}

Yes, I can add it.

Thanks!

>
>>       g_assert(vioc->set_dirty_page_tracking);
>> -    return vioc->set_dirty_page_tracking(bcontainer, start, errp);
>> +    ret = vioc->set_dirty_page_tracking(bcontainer, start, errp);
>> +    if (!ret) {
>> +        bcontainer->dirty_pages_started = start;
>> +    }
>> +
>> +    return ret;
>>   }
>
>>   int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,

