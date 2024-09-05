Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DB9CD5BC9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 15:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smEBb-0006qs-9a; Thu, 05 Sep 2024 11:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1smEBY-0006qL-KN
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 11:14:12 -0400
Received: from mail-dm6nam10on20614.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::614]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1smEBW-0002Fn-H4
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 11:14:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6n4XoQAlzQqnTkST7zO2Om5+nfHtKGarLqVTZ82AceZc+l0yxsuwBjMfQU0m3Nb7F2cPJe4wjy6eAyrcxzU0DlRCTPFyR7oUJKnGP1QuouCSKF2athDq8mm6LxXl431Vq2pBRHtOH6iDXYGOzu/I+j7KYdNPVUwAa1vuBj0GfRBzZW3SRG3Emf/PV0avypLFzFuOdpqGpYlg0vzSF7ZoBaJKExVFso7GJ10Jp9YbR7UHLzx/YA1pzAntbUQmnu8dJztSW+DW7VDG5V/8kXQO9cpvh5Zmwafr4Dpg26wuYabjut5Zr8GOAQlZmEnhIyIyaN6/pj07V8eL0Xk01qvCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9EEN66Ic8I6sBN1wS8DgBO8i+D/XZQP35CZwGRV1t0=;
 b=pwA5XqLuopwnESG3ScZooGfjJ1pwBZSxPols3QNObv1d2x09igBLHOK8laaU5e3eo7ZjshfQxtVmB0+27v7+JgFozPWvj3swZ0LuDc6TD3JiCFYzVhO0XnjoOdY6/H+Hn8SxqoOceMne/JKgaBddI9m5c4zjZAjLcchsRaLUuQLwvjcjtZs0NatP0aAdfqnLhFCnHaMdzxO8wypoGUUIJo02xMrThZNjJanpBweW2rP55bKK47ajhzMphvVtypY5KqLGKs9Zsvi1uiMO4+JHno/SbZoauLw4vpR2LXvsVN4zUL4DS92KLZmnnkkk0v8tmlA+bFCiCBgJLWI9UGRVrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9EEN66Ic8I6sBN1wS8DgBO8i+D/XZQP35CZwGRV1t0=;
 b=EKJWFIs1OCXPPQh8PnyVmTEZiHAzi86xxkmSWpV+vtFIngOTN0hSaKxnXt1WqbA1hfNpFK7Wjryq1DUhgqkEAq5LwwOxahabiFWVLsab4llVXIQBsqPzBndldO1HQQUVa0OGC4949a4VzjEtckiBHqZNl413sdiULIz7p8iqJtnR3EVsLP3gkj1f69hnHcLrRloI2cgWiy+k+RnFI/tODy34otjLxq0w7w6vf7sH4evpSFD6Vz/C3PL4ZjdOFVtXmgXIUarlNrvy9y4qxvwznCNfCyIsI6wqxlKzmHN7xIzTSMOhJUcQCjfSRfEYzUrSGv2Yz4CE/wiN3E+1ubk2BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 15:14:03 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 15:14:03 +0000
Message-ID: <ec2b1687-5e53-4c1c-b1a5-24c38512daa0@nvidia.com>
Date: Thu, 5 Sep 2024 18:13:56 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/17] migration: Add load_finish handler and
 associated functions
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <1a7599896decdbae61cee385739dc0badc9b4364.1724701542.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <1a7599896decdbae61cee385739dc0badc9b4364.1724701542.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0653.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::23) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DS7PR12MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b034508-ae39-4bcd-33d0-08dccdbd605b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnFlQTA4THRBZzVPNDg1VjZsRTZjT0pMb1lNa0xKdHNnVjJIMmhDVW1ST3Y2?=
 =?utf-8?B?YTVwWW4zUEdVbnlBQnlMcUdwTXFJbi9meTFoVEk0NmtLZGMrTVF1MERmQ0s1?=
 =?utf-8?B?YXExZ3JQcVV3MExUNmpnaUVXbExQTGVXYTFhVCtTQWtNMGxoZi8rTlkwdXpN?=
 =?utf-8?B?a09PWHJ6L25MeGJ3Nkh3MWxzdGE0ZGRNRmlOSXZGdmxuZjhyMXp6eGVWTFh4?=
 =?utf-8?B?WFF0c0c4MVk4dFNJNWJ4WnpCUlBoeTBCWEUrVkVsMTlzK25zT2lNMlB2bDFN?=
 =?utf-8?B?TGhQOW1RSWtVTjNlUEN0aE5JRmpndHFEVk5NWU1YZGpxRG9sYlB4Sm9ZMC9a?=
 =?utf-8?B?RTE5RXl3QWVWL0tmNWExQnZiMnN0RTltbnRCL3R1Wnd1UnZpdU5xQUMzeitG?=
 =?utf-8?B?MWZ3bGYvWEhHTXNqQXZoTFB5RVlxdkxtKzJHeHQyaVJCd1NCcVlNcHF6dXlV?=
 =?utf-8?B?M2tSQVQxVk5ONW5ZN2RJQU1jUUNTUnhQUnQzcnRDUkxwVmdQN3lBcExmRjE4?=
 =?utf-8?B?a0lnZDdEYjRKN3RvbkdIK3BFbU0wN05tVE8rdFdwQndXUE1oNFM0a0FrdExR?=
 =?utf-8?B?ckgzV3c5QWNPRXpvWk5tODNlcUtwV3pINkpTUENFSHFIVzA4T3JLenNlM1pQ?=
 =?utf-8?B?OFNjSVIrelJmdG9McDEyOUpGVWlaZW8rR1ZpWUZUeDRZc3ZlR0wvM1M0RmpF?=
 =?utf-8?B?eHFteGRuWnF2U2dyVDk1MjE5clI0dVM0UEFvWkFnOXQwandvTVc3VDZrZnBQ?=
 =?utf-8?B?bjltWExvOWJTTDJML2hKWG1WT2pDU1VVby8xenhLQitYaXNpV2ZhemMzM2pS?=
 =?utf-8?B?UUEvTnl1MXJtclE0Z3JuL1ZHUlltWWwzWi95cWJLMHFMYmgwK3pGWFE2UHky?=
 =?utf-8?B?T2tlVjl4OGU1RlAwbmRyd0JHQ01kcDdQaVlzWm5EZndEazJ0V2JFejFsbE43?=
 =?utf-8?B?UUhhNElIKzEvc3hTd1JDS0ErK1Ztd1NaL0ZGaUpMMUkydUlWRy9ZMEh3MlhY?=
 =?utf-8?B?eU5Ca3BBMjY2RlBHZ0VtNUh0elF5UWlYWHRla0lQb1dnTTVYQjFIQ2ZJTUto?=
 =?utf-8?B?bmtiZE54aC9KSE5OK1ZxbW8rYUJ2V29SSFRuNmsxZ2kybXZPZkhRazRCQ0Zo?=
 =?utf-8?B?TU94bS9BZzlrRVJPRHZ2THROMisxM1pmSVd0d0hGaFFKbERYbWwyVjVPMGNZ?=
 =?utf-8?B?djBkZUhoV0p5cUNhTG9tQzIwTVUyanhQNmI5ZGZiMTJzcmdXNDFRSUJlS2NN?=
 =?utf-8?B?dnFxOWE4elFhVDcwbjZxNFZBcHJoYWVPdW4zTDBvcE4ydnBxbUg5MnhjQTdv?=
 =?utf-8?B?ejNkQVNoSUZuQjJlOHhVSUZBU2ZhZDlna1NNOXphOTVyMzRZMVFIK2RjTG9n?=
 =?utf-8?B?VjlqdUFRU3NPSmt3MDVDODBmNkNRMnJiTmxna2ZsNW5rbXBmMDkxb0VxOGx3?=
 =?utf-8?B?NVA0dnBOdWxyeXF5NnlFcXl2Rjl1OUdJdTRIR0xVZjQxeXl1Z09OWVR5VlNk?=
 =?utf-8?B?RFBhR1R3M2hONXV1Mk53ZUtGRytRME9ab2l6a1Axbm5QT1MwK1lGK3dIWnlU?=
 =?utf-8?B?Y05QNVE4QTJBcTZhUm5reUJhTmpicnJtN3BrZEU3ZDV3L0hGSzczQTgrRVhJ?=
 =?utf-8?B?SDNwTll5SFVKQ1NSeUV4cEIzVE0vZ2M0bGR2R1p5Mi80VEJJTW9yMm5wd2No?=
 =?utf-8?B?cE9lRGhRdjNHVHhCYzNlLzNuMWluaFcvZFpHMXVhcGNyeVpGbzAxYjBEU2JR?=
 =?utf-8?B?YUsvd1B3V0txa3RHNHpYSDZ2b25BMDZyYTVCR1NyeUUzd2d6cncxUEZzR3Ji?=
 =?utf-8?B?aUduaDdCSml5SHpzYW5hZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2k0eWxhT1k3T1VrSlZmRmZXTlVjMnl1TjRWYUQya2FFbU9sdWxNSGVlT0xV?=
 =?utf-8?B?d3hyaHAxV2g4M3I3aW9YM294ZHpTOFM4T2VDKyszM29kZjFpZ1c2STdGYUlM?=
 =?utf-8?B?aUgxVWpxNWViTUVCOG1FOFAzSXBkNFFaL3dMcjhRbDNiZ0p3eldHSGszcnlx?=
 =?utf-8?B?UEN1SkdEVVZXUWk5ZHpWcUxCOVhqd01BK0wwQ1hrY1l1K1VwTXIvNndMZHp3?=
 =?utf-8?B?blRqWGVyd3QySVlPTmdrOGExOFhwdHVVeDNBQlMrbm9CdEg2aEZNZlFNZk9q?=
 =?utf-8?B?LzJtcGVrZjJIZWlKRXQ4ZGM3YTV5V3JVbU5sdVBsUE9xekJCbnFWVklheFdP?=
 =?utf-8?B?QUtJTnd4M0tMZEQxam5UN0ZJYVByL09hNjdrK005ZTF5akdpREtXUFhqWGpy?=
 =?utf-8?B?Vk91dXJ5NU1NQlloLzBvcTNyc3dCVGVmTXpQOWU3YzBIcTZET1VRV3hEWkEv?=
 =?utf-8?B?c2JhL05qVFAxYjdhcEJhVzAxM2drVjk5V0RyV2dMZHRyZ0lGT3BPVTh1MEt1?=
 =?utf-8?B?dnVYWkY3dEU5RkF6eFBNSXdLMUl6K1VmRWdOcXRKUWowV1lkSEZxK3BLVWhR?=
 =?utf-8?B?MFd1QW5xVmVCdGd0OWR4dU9IbnhhRzFEd1hxUG5DMUtDUG1HbDFid2hrOWsy?=
 =?utf-8?B?dDdVZHVjK2tZR21oU2c0R1FKeWFZYS9icm1HSmQ5ZUxOM0FRbkVUakc3ZXM2?=
 =?utf-8?B?eHQ5YS9PTkk1VnU4bXBrUlREOHJEMTNhMGorNVc4VFFWalQ2YWxPOGdrL3dX?=
 =?utf-8?B?SUdXd2hyZk9qc1c2VFVOdGpqYzBiUnB2ZE1aeWI5U1ZuVkpYWG9SVmo4K0I2?=
 =?utf-8?B?T0NFRzVYSy9GTlpZdDFHOWlCejVyVXpFVU5Ub3dsWHhhSW5PcExlVXhYYVFz?=
 =?utf-8?B?a1dSOWZVSTdzWE4rUGZheEk5REZnNURHRHJIWXRiVXM3bnN1MjkrejN6b1B3?=
 =?utf-8?B?ZUdubDl2V0pTdkxZMUcxSEFiTlpzUXdER011cUd4MWdYM2p4MVNUK2hldjMx?=
 =?utf-8?B?T0xsS2o0L3NIZk50NHplamlxRE83YUl4VzJ4bDFHVWVCbjdyMDFJVzZwdkRW?=
 =?utf-8?B?eDVNM0RmOU5tak9tQ2ticXlhdE55UC9ReXZrSFFhV25ldzMzY21TcHVXWEZS?=
 =?utf-8?B?QkNHU05Jc2IzYXBDaVFobk9tZjBPRDVCUnhaVVVkUzZETEkwL1o2V1E1dnEy?=
 =?utf-8?B?N3hsSFdKaXdPZEh4NWZ6d3c0bitxZWh4NGh6dkFnMlAwU0xiTEE4UVVwNWx5?=
 =?utf-8?B?ZFJFWGdTOTBYWEg4T1ZqZFRqd1M4dEtWczF3cTRFZDZ5aEt1VHEyRDdzb2kx?=
 =?utf-8?B?aVlJaGRsWHBZa2RtUEdxMm5MaHI1K2wxNDNka3lFS3NFRDBjblJad3RVZmpu?=
 =?utf-8?B?dTllclBCQ0tYcTkwUnlHRlp2S2xhanpybUZ0VmFXT0szVFVXM3EwL1NONFdn?=
 =?utf-8?B?S3N6WkMvblZqaHlCK25FcHhHSHFEaGtmb2VJU3ZaRzMxQk5CUUN4b0lLYmky?=
 =?utf-8?B?SkpWVVhDL2Z6OHRJRktYTXIrWXQwWVhuVGNRYk5xVEplL1JjZlFkOXNHMkZF?=
 =?utf-8?B?Smp1U3hyMk5hME4xbGVQUUlXTzBrQ2ZKL2Vnby8vdjVoTXRrWk9kZ1dRSGhl?=
 =?utf-8?B?NlA0NFRQekJ6d2xWYllNb1NNb3I2RGNFVE82WUVYUjI2MnZaZjcvYVRibEln?=
 =?utf-8?B?eG5CaGhOUFVmcWFSOGlSR05oejkzMGVJRTZCQmhkbExES0xKa2lGNEllb1Bk?=
 =?utf-8?B?QmkwQTg4dzlNMkpkZHQxMEw4NnBhMTl1VFB3YUxMUk1QU3ExV1Q5Q2lubFl3?=
 =?utf-8?B?RVhvTDlCQnVpeGlHRk1JMjJoQWNLT1pzcDlBajBKRWQ5cXhidFRkeHFQZERi?=
 =?utf-8?B?ZzlYeVNvdGFweTQ0S2lMNE9FRUdnaE1kcDZHSVM3KzNUQUduMmFGY1YzUisx?=
 =?utf-8?B?NW1OaUprbzNoaVNBUjdWU21EQUVOVnEwdTBSN21mMUcvS0NBeGV5UVhvV1Fk?=
 =?utf-8?B?NnRsV1NJOE9RNmp0UDJFb1hqUmVqV2d5Nmd3NTRoOGhocllVK0ZmMXJteTNV?=
 =?utf-8?B?ZU81UWxyMGllY3ZvS3d2aFJmSG01RnhHUzd3aW05enVTdWQrZ3lCSTNHdFFM?=
 =?utf-8?Q?2LASWoLjTI3OBRNTFaI63cDxW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b034508-ae39-4bcd-33d0-08dccdbd605b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:14:03.1427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hlnf2tT9x/1z1oV7f42TX5ERGZqc2AZ+D8DM/yFJd7CnqiV+w/toLQaPJS/lnAL72S521QTEA/wLQt+86GX2uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885
Received-SPF: softfail client-ip=2a01:111:f400:7e88::614;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 27/08/2024 20:54, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> load_finish SaveVMHandler allows migration code to poll whether
> a device-specific asynchronous device state loading operation had finished.
>
> In order to avoid calling this handler needlessly the device is supposed
> to notify the migration code of its possible readiness via a call to
> qemu_loadvm_load_finish_ready_broadcast() while holding
> qemu_loadvm_load_finish_ready_lock.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   include/migration/register.h | 21 +++++++++++++++
>   migration/migration.c        |  6 +++++
>   migration/migration.h        |  3 +++
>   migration/savevm.c           | 52 ++++++++++++++++++++++++++++++++++++
>   migration/savevm.h           |  4 +++
>   5 files changed, 86 insertions(+)
>
> diff --git a/include/migration/register.h b/include/migration/register.h
> index 4a578f140713..44d8cf5192ae 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -278,6 +278,27 @@ typedef struct SaveVMHandlers {
>       int (*load_state_buffer)(void *opaque, char *data, size_t data_size,
>                                Error **errp);
>
> +    /**
> +     * @load_finish
> +     *
> +     * Poll whether all asynchronous device state loading had finished.
> +     * Not called on the load failure path.
> +     *
> +     * Called while holding the qemu_loadvm_load_finish_ready_lock.
> +     *
> +     * If this method signals "not ready" then it might not be called
> +     * again until qemu_loadvm_load_finish_ready_broadcast() is invoked
> +     * while holding qemu_loadvm_load_finish_ready_lock.
> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     * @is_finished: whether the loading had finished (output parameter)
> +     * @errp: pointer to Error*, to store an error if it happens.
> +     *
> +     * Returns zero to indicate success and negative for error
> +     * It's not an error that the loading still hasn't finished.
> +     */
> +    int (*load_finish)(void *opaque, bool *is_finished, Error **errp);
> +
>       /**
>        * @load_setup
>        *
> diff --git a/migration/migration.c b/migration/migration.c
> index 3dea06d57732..d61e7b055e07 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -259,6 +259,9 @@ void migration_object_init(void)
>
>       current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
>
> +    qemu_mutex_init(&current_incoming->load_finish_ready_mutex);
> +    qemu_cond_init(&current_incoming->load_finish_ready_cond);
> +
>       migration_object_check(current_migration, &error_fatal);
>
>       ram_mig_init();
> @@ -410,6 +413,9 @@ void migration_incoming_state_destroy(void)
>           mis->postcopy_qemufile_dst = NULL;
>       }
>
> +    qemu_mutex_destroy(&mis->load_finish_ready_mutex);
> +    qemu_cond_destroy(&mis->load_finish_ready_cond);
> +
>       yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>   }
>
> diff --git a/migration/migration.h b/migration/migration.h
> index 38aa1402d516..4e2443e6c8ec 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -230,6 +230,9 @@ struct MigrationIncomingState {
>
>       /* Do exit on incoming migration failure */
>       bool exit_on_error;
> +
> +    QemuCond load_finish_ready_cond;
> +    QemuMutex load_finish_ready_mutex;
>   };
>
>   MigrationIncomingState *migration_incoming_get_current(void);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 3fde5ca8c26b..33c9200d1e78 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -3022,6 +3022,37 @@ int qemu_loadvm_state(QEMUFile *f)
>           return ret;
>       }
>
> +    qemu_loadvm_load_finish_ready_lock();
> +    while (!ret) { /* Don't call load_finish() handlers on the load failure path */
> +        bool all_ready = true;

Nit: Maybe rename all_ready to all_finished to be consistent with 
load_finish() terminology? Same for this_ready.

> +        SaveStateEntry *se = NULL;
> +
> +        QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +            bool this_ready;
> +
> +            if (!se->ops || !se->ops->load_finish) {
> +                continue;
> +            }
> +
> +            ret = se->ops->load_finish(se->opaque, &this_ready, &local_err);
> +            if (ret) {
> +                error_report_err(local_err);
> +
> +                qemu_loadvm_load_finish_ready_unlock();
> +                return -EINVAL;
> +            } else if (!this_ready) {
> +                all_ready = false;
> +            }
> +        }
> +
> +        if (all_ready) {
> +            break;
> +        }
> +
> +        qemu_cond_wait(&mis->load_finish_ready_cond, &mis->load_finish_ready_mutex);
> +    }
> +    qemu_loadvm_load_finish_ready_unlock();
> +
>       if (ret == 0) {
>           ret = qemu_file_get_error(f);
>       }
> @@ -3126,6 +3157,27 @@ int qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
>       return 0;
>   }
>
> +void qemu_loadvm_load_finish_ready_lock(void)
> +{
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +
> +    qemu_mutex_lock(&mis->load_finish_ready_mutex);
> +}
> +
> +void qemu_loadvm_load_finish_ready_unlock(void)
> +{
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +
> +    qemu_mutex_unlock(&mis->load_finish_ready_mutex);
> +}
> +
> +void qemu_loadvm_load_finish_ready_broadcast(void)
> +{
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +
> +    qemu_cond_broadcast(&mis->load_finish_ready_cond);

Do we need a broadcast? isn't signal enough as we only have one waiter 
thread?

Thanks.

> +}
> +
>   bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
>                     bool has_devices, strList *devices, Error **errp)
>   {
> diff --git a/migration/savevm.h b/migration/savevm.h
> index d388f1bfca98..69ae22cded7a 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -73,4 +73,8 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>   int qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
>                                     char *buf, size_t len, Error **errp);
>
> +void qemu_loadvm_load_finish_ready_lock(void);
> +void qemu_loadvm_load_finish_ready_unlock(void);
> +void qemu_loadvm_load_finish_ready_broadcast(void);
> +
>   #endif

