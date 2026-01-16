Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B639D4A607
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 06:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgddV-0001wx-RX; Fri, 16 Jan 2026 01:48:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vgddU-0001wZ-JF
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 01:48:44 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vgddQ-0003g9-Uo
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 01:48:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kb/cq3R3Ogyjaw1YfwV5E2bVjDFD3SaE2+90J5SFv1wAICErDuHhtEIRxmvbyIb0mHR9jShsjfke25OPdpKic2oZqF9lBF3lXfVXJcQoFop1gdru5FmciuSvvbw4o7Foidb1Gilwb8+LTZERurl2V1XhICNt0/z2gHc0ogn1CHHnmLSD/V3CdoT2v3zdPhRRK6HH5VdjYDkSB7vcocm/Z8df7iHeQzEISh1x/Dcj31Z+NKQFYiAtGA8mMKyZImokGZI+OhdbKLK16a1yIJM8t1ACBcm2D8QmqNgGdVmUIiNuDunSumgrmlL7xE7iyNtDZYT2e1QBo6Q2pKp2scdWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7IyA83MNEOwqJFtKBS24VXVt91r5q7ngwxur+78iUk=;
 b=Ci+eLqfjB70kkoUY8nFQx5JTFQ/a5s9S/oE4GF7JSWL7ZMOmhr9fKvhFn6GrnHH+R1AhPlBv/uQ88ZM+CLdHR4dvGAvAGPC158QoCyienKd13T9HGLcTd8chPBhc4GNIe9IBjLpvNytyZbujFAP1/WMgmOqlthbBBa9Q6oBEKHf87pjw1PjDilSE7mzqorSm4cW0MbfIZfRUr6N2nqtOVanpxhswnEtSkYH5U29Uplw7zuDI3uvGGtD8TGHUuLp6h0CdFd37mu5DOFWlv9CJyS3jysV0WB9FQ5pQ2GX7kVXKnuZXQ+TTyVLDsoYaN7J0LsfK+7jgvvaohmC7bfackA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7IyA83MNEOwqJFtKBS24VXVt91r5q7ngwxur+78iUk=;
 b=qCChWT/pXpA7xISpcixUSeSoyg9EjNFp8ioPmxVjAzAY6UMfw1KqKtYsA3Jwu6FrlCmpa0vImmbabZQsO45G/jI5Jb0+RkA14owsKpmN89PEI3PaLI5xvIhs6FveGaCBBC4ViWoucnl97KpWc1eb9tOKj91kZ2fUNiX97ZFws5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by CY5PR12MB6297.namprd12.prod.outlook.com (2603:10b6:930:22::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 06:48:34 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 06:48:34 +0000
Message-ID: <e3106e87-dcd0-47cc-8ffa-fd5cd4a7dd12@amd.com>
Date: Fri, 16 Jan 2026 14:48:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] virtio-gpu: Add userptr support and ROCm
 capability enhancements
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 alex.bennee@linaro.org, dmitry.osipenko@collabora.com, Ray.Huang@amd.com,
 qemu-devel@nongnu.org
References: <20260115082739.174224-1-honghuan@amd.com>
 <71358c60-7048-4bf1-8b4d-81c1a958780a@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Honglei Huang <honghuan@amd.com>
In-Reply-To: <71358c60-7048-4bf1-8b4d-81c1a958780a@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|CY5PR12MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: adec693b-bbe3-495a-931d-08de54cb4487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnR2QlhqZWQ4WEVrQ3JlMDZUSjVKbFRPYmk3cUxUQmNSUGVTaEM4NDN5Z0hB?=
 =?utf-8?B?eld5ZEdmcTBSUWFiRFovcWt6ZHE4bVZtQjF6dG5lWVQ2TTVnQnZsVzZudFZV?=
 =?utf-8?B?WnhobEhGdTdrUmlLc0g5UGgrTGZ5NHZvOU9Fa1FKdU9lbEVQL1luNUk4eWtK?=
 =?utf-8?B?dzhUaHh4eUlCYlpQb1BOYUZoWitwNDBiZnp5VWdXRUtaWFFFTXZxcjQxOEJa?=
 =?utf-8?B?UERpNmRESHNBNURjYVBCUkRwUStTemZkdDF3TzY5MnFyR0JheTZKMy9wWW1i?=
 =?utf-8?B?TW9LTm1zYWNERnlLeGpheTVxSU5FdERUSGwzY2xkeGVDc0tKVW93MHJ5eStV?=
 =?utf-8?B?V1phZGhTcU90TGNxTDh3dDJzalpCTGp4T25sTUJpdEM2WS80M3dzNENaVUNs?=
 =?utf-8?B?TjBVVVEvcjdLRmI0bDRxbkI5S3NUUlV2aE03UEpHOXIrbElYSFozemJKMTFz?=
 =?utf-8?B?RVZHQ2tqcEFQWUU5WDFZbjI0cXpaRStIWW42NnZuelV2cm1mRXpnQm8rVTk3?=
 =?utf-8?B?dTNyZTBJblYveWVhZlhLRVhlVU1lZ2tJeWhqRUNpV0Q2czE4RHd1Ni9MenJU?=
 =?utf-8?B?UXpSTzViZTlCQ0xxUkNLeFNONndxZ1JaRWdjQ0hvM0tOdXQ5TGkzbG16SnFE?=
 =?utf-8?B?SzYrVW5CNXd5NWM5bkw3b2hNVzBzbWlKcU1EWTk5Q29LYjJHU0w2b1Rabm04?=
 =?utf-8?B?R2VueWtOV2cxcjI1NUZyNHZwcVpDd3RQMk11akN3dVNCWm9mcFhPMUpLbXhh?=
 =?utf-8?B?eDBMbHh5YmJWUTBwUnlBMXV6SWF2N1oxUTBlMnV3THo5ZVU1dVg5a3pTQUFS?=
 =?utf-8?B?dzV6T1hUL2NldW03MU5tVmtmRThVVVNKZmxqZzlGUWRDY1pMdEUxSngvNE9H?=
 =?utf-8?B?U2xOZXhMb082SHlURzAwVXc4ajNBR0dtVXZxUXJkQUo1ODhxSlpCSU92VXhM?=
 =?utf-8?B?NDV6akM5NFl0cVBTRHFrVGJuNTlDU1JqQnBVRkhpdXlmN2NLN1hqWUx5aTJW?=
 =?utf-8?B?b1NCd0V3MGM2ZU1wK1JldTlDTkZsMTNOdVBaM2dqbzRmcWloREZ0MEg3Q21z?=
 =?utf-8?B?N0JwY0I1UmpGdXEzRGVURXoxUVhGc3N0bVl0S3RrVlJBaWRaM3AwUGhqbmdk?=
 =?utf-8?B?eUNNNG45aTBJZFVaSFBXcVVuKzBCTTZSdmZtYUh1cHlaU0RyRDlSNTNxZTZ5?=
 =?utf-8?B?a1dQSjdpamhLTFJpcEtEY2VXQVkybU5Nd2FTa09zN0JTRXJDYVduNURkS0pG?=
 =?utf-8?B?Snhwb2xNVG0xUUlpS2xhS2hrdFNzWXRlc1NWeHJmbHlsekVrUk9XMzQ0eUpa?=
 =?utf-8?B?SnBTQ1hXZ1VWWDBBdjJmSXBuMTYwUThmZm9RQnE1OVg2YXJiK3lOeG9kc1FC?=
 =?utf-8?B?QW5GZmtoVmUwcEYrZ0hML0tpdUtyOWtTK1FkQVN2ckdQUzdNVEtVbE93V0Zx?=
 =?utf-8?B?L1d3L2ZiWTdFbzFIRGdTVjZNL1MrTFp6Z0ZTeTJGNEF0UVlhYmNhOUo1WUpt?=
 =?utf-8?B?d2NpM0ZLWFU3MGdLblpXZ1Q4UUY5MVFQdDNWWnNiZG5EcmdjRVZ6NFVYZkht?=
 =?utf-8?B?NzFLVzN2YnRQWFUrMmtwWW1wZnQzdWhHOWJYSW56WUEvdVJNV2FiVjVGc1RJ?=
 =?utf-8?B?RFZveUZrandScnFCVnVmS1UwZTJmT2M1eGpiMnBnaGs5cWQxaTJjSTdwWVo4?=
 =?utf-8?B?M1o5Mm1ydEVRNmdqalgwa3Y5YTlVcmRTM2FRYjNKaWw2eVRmUGxKK2JqcnBl?=
 =?utf-8?B?b3I5ckVEVDlKNzhScE5uZTJLT25qQlQxQ2VBaWV5RTVPdW5kZXNJUFZnMW1p?=
 =?utf-8?B?Z3YzMEtGYVVGUk02RW44QVk4cGx6bWg1cWM2UlcrUUN4bHpkdG40VXpmL05u?=
 =?utf-8?B?UE9aRW9hZEM2VVUxWUJucnAybDd3NndtSVgyUFkzaTE1eGdJaFlEQWtjVlRI?=
 =?utf-8?B?Zno5b3lub1lnaFRSdWZUdGR5YUgyMmdXRUdUUzMvYnJPZHFISmV6UVROL0hL?=
 =?utf-8?B?djl3aExHcHVQemlXK0p6Q2RZSzNVZVlwT1F6aG9FcFlVOURERTdBWGlrVmpk?=
 =?utf-8?B?cVVwbzgwTkN2c3E2bGx3WkNLK1B1WjgzTHB2WU82dUlRdE1nWkRHK2dZcFo3?=
 =?utf-8?Q?zXjn6O0t0Ui326iDVu+LsvXBv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDhvOFVTYi82Z3poOG9lVjl3RXF2Q1lxWUhUOWtDdnRVenNTTmd0dkJJU1M2?=
 =?utf-8?B?Z1c3NFc1LzZmcVlIM2ZqLzdCb0QxQXg2cUtVOXo0SGRjdmZEaEVibnp1M3h1?=
 =?utf-8?B?SDdXM2lkWWprTE95cEVOS1B2Ym5LZENhSU9pZlFxaXc2clNkNkR4NGRXQy84?=
 =?utf-8?B?cVJucGJkSGozT1M0Ynk0dDJuZExtb040QXpuemVQblJXN2hmOUFjcFNYWW1x?=
 =?utf-8?B?SDFhdUtXRUQ5UmMySzIzMHNpU1pMTER0cC9KVXZtQm53aFRySG5BTHBtMUFk?=
 =?utf-8?B?VVJMYzNoZXVZWklrQ1ArMEE3dmJXVWpLOFQ5SHFVMG1OOVJONlFGVVBiRzJJ?=
 =?utf-8?B?M1g1Q2JIV0RNNVRZYzRSU09kaUxoenlPNlBFOG53TGo3c3lJQWJmMTZibVN5?=
 =?utf-8?B?Yk5yVFFjN3M2VXhOeUkrbHlUYnpnQk1kMGExSG1xbUprdGt5NWt1anhrcVJV?=
 =?utf-8?B?TmV1WnQwaitCWU8ycEhLZm9HRWNvQ3VHMDExaUJYTkJnMnFJa0NodUZxWC9H?=
 =?utf-8?B?clZ6VlBMTWRhZDZWNnQyQzB1WHVpRWV6ZFdiVExRdVg5S2xjK1hCTWd2S000?=
 =?utf-8?B?WjdFZWRMaUdaUjR0c0l3ZXhwNThyL0xOZkxCRG9YRFd0aWQ0enhjT3hMOGNp?=
 =?utf-8?B?MkYxWVowTTdyTkkwVFdLZFlIaUtaRHNwNGVlRUxqRUtRWGJZNzN4bDN3a29B?=
 =?utf-8?B?b1BYWkpJaFVHSU5BNnN0R1hLSDcwcklORVNaVTFGNllCcHNTZnhWOGwyNjkw?=
 =?utf-8?B?RUNXelRPNGxZeWhMUmFBa2xJMVZGSXpEY09nZ0wwMVdHbWhjSGFWMUhxUXBO?=
 =?utf-8?B?SVFKSDc4ODNrVGFNQnRiV2psWldBaER0eGl1MXNlcDNOK1ZiaEk4bzJQQmgx?=
 =?utf-8?B?TTkzYXV6amk2Y3lreEh3blR3WExJVmNCVlp6UlVXMWtpa3BZTy8waWlxUlY1?=
 =?utf-8?B?VURLblhLWm9XVU1YMnRCeHh6VEpaVUY5TkIzcVgxTTJzR0RWMDFFWitMYXk1?=
 =?utf-8?B?SWsrU1FhanU4Q3VDSk1iRmgwcVNZVmJINzNTdmhwMExpc0RFeS9mbHZ5NG1n?=
 =?utf-8?B?bU56RzFMY0xpaHFPQitZNytqZDJNSVlZY285SENzSEJOLytxMTVsZmlCZitF?=
 =?utf-8?B?N2ZCQ0RwQU5mWDJXM1JIWGFuZFZXRzJYY1ZWeFZEWG9kRFpvV1JCZ2FPSW9L?=
 =?utf-8?B?TlU5WUJCTDFPMGFtTm9EU3cyN2xUTDYydnhLQlVhMEExK3piSGM3U2g3Njl6?=
 =?utf-8?B?cGtYbzlWVTF2NjVBYWtFaDV2YThsV2hVdWtTRjdOMnpJVzMvR3RpbEFFRVJl?=
 =?utf-8?B?a1hNUFllQnNnQ2lmdlFRc0RoMFN2WlBHdUs0cHNvTXZjejNadXFCTWRuZmpD?=
 =?utf-8?B?OTg3SWVYKzE0ZmZJM2dMTERsUlQybDJPeUM2disrUHJabS90UDVJRVFWc0t5?=
 =?utf-8?B?d2Z0Q2pLUG1NUHJreTVxWGhFS0VoZFJYMW0wY1U3YmozLzIza2VqRkRDTkx6?=
 =?utf-8?B?NkpQelBFYm84VXdlV1lnbU9wcGQxcDhqOUZ2azlpVldtYlc3djFRY2YvbnRr?=
 =?utf-8?B?dGd2N3BvdEY4Y0JheGVjbVplU1NmdkNicmpvRnRhWTRqSU1XcGhZd3VidU1Q?=
 =?utf-8?B?OXZkK1dNQU12aFNYZTJXU096RVBOdzBaMzRSY2U2OGJoUE5yaE9QQUI3ZUww?=
 =?utf-8?B?bktLbzdnK3Fhb2NKT2VvbVhXVHpicmc0dFlQLzFRTE9sVVdyV3NDcFRzSzlz?=
 =?utf-8?B?S1VlNUlBbFJqTGNQQXVmYkt5SVpzSFgxVDdVMGxTb09EaDB3Y2RaMHZXODlZ?=
 =?utf-8?B?VkhFeTVUTFNoS1IvM2lsSEQyQ2hreTEvSEF4dDEzc3l6UGNMd2xvVUpHU2V1?=
 =?utf-8?B?ZFBYdXdQTmdUWktVZUtiSmcrY1gzZ2puVnV1WWhpRTZlV0RpMmN1YTlabHlK?=
 =?utf-8?B?Y1p6NWhkQ2xXeENyaE9aS0RqMVB6aUZta0FmQSt6eS9KK2NEaWZselB1dXRv?=
 =?utf-8?B?OXFpN0EvNEZTN3MxQVZFbkhHaVp0NXRDTXladjZBYTJNUXB4WFZxeDVaV1NJ?=
 =?utf-8?B?cFlGYS8xZVllNFcvTHp5RXRrV3FmbVZoZHdrbXVOVWNOR3Q1U0V0QzlGUjhC?=
 =?utf-8?B?OENieXFUZ2crMjdZaW9mMWtwN2VNbk1XUkJEeERUdTh5aVBGeThVR1F1UEhh?=
 =?utf-8?B?VVZObU1SWjlxUUU1THg4L1oyMzNzS01lTlVoYUp6ZUNpRUxCTUUwb0dkNFFp?=
 =?utf-8?B?bTl2aXhVY2JhQ0hLdFp2V2pjaW9OZS8vVVJvaklVR09IUm55dS9rZUxQdUc0?=
 =?utf-8?B?VXVGbmxxWFV6N21kb2l4aXVPMnpCSGoyRHpoTGlyT1hrTDVQbmJzdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adec693b-bbe3-495a-931d-08de54cb4487
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 06:48:34.2161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9a9mdk54jRgY7CgT4Eynxx7gCXQKZTGD50zNUuQhi2KsEWXCX7FHnJEfUBbWMEIAZ15qGbp7+a62rD0/uli+1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6297
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=Honglei1.Huang@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2026/1/15 17:34, Akihiko Odaki wrote:
> On 2026/01/15 17:27, Honglei Huang wrote:
>> This patch series introduces enhancements to virtio-gpu to improve
>> memory management and GPU virtualization capabilities for ROCm (Radeon 
>> Open Compute)
>> workloads.
>>
>> Usage example:
>>    -device virtio-gpu-gl,rocm=on
>>
>> The series includes:
>>
>> 1. Linux header updates for userptr support: Synchronizes virtio-gpu 
>> headers
>>     with upstream kernel changes, adding VIRTIO_GPU_F_RESOURCE_USERPTR 
>> feature
>>     flag and VIRTIO_GPU_BLOB_FLAG_USE_USERPTR blob flag support. This 
>> enables
>>     user pointer mapping for blob resources, allowing guest 
>> applications to use
>>     user-allocated memory for GPU resources more efficiently.
>>
>> 2. Removal of nr_entries limit: Removes the artificial 16384 entry 
>> limit in
>>     virtio_gpu_create_mapping_iov() to align with kernel driver 
>> behavior and
>>     support legitimate large scatter-gather operations.
>>
>> 3. Linux header updates for ROCm capability: Synchronizes headers to add
>>     VIRTIO_GPU_CAPSET_ROCM capability set definition.
>>
>> 4. ROCm capability support: Adds native support for AMD's ROCm (Radeon 
>> Open
>>     Compute) platform through a new "rocm=on" device property and 
>> capability.
>>     This enables GPU compute workloads using the ROCm stack through 
>> virtio-gpu.
>>
>> Changes in v5:
>> - Split userptr header updates into dedicated patch (patch 1/4)
>> - Extracted nr_entries limit removal into standalone commit (patch 2/4)
>> - Split ROCm header updates into dedicated patch (patch 3/4)
>> - Removed VIRTIO_GPU_F_RESOURCE_USERPTR feature decectiontion
>> - Keep ROCm capability support with "rocm=on" device property (patch 4/4)
>> - Change corresponding commit messages, change corresponding cover 
>> letter content
>> - Remove RFC label
> 
> It is too early to drop the RFC labell. The following should happen 
> before dropping the RFC label:
> - The Linux header change land in some maintainer's tree.
> - The Linux headers with scripts/update-linux-headers.sh is updated
>    using the tree.
> - The virglrenderer change lands the upstream.
> - A proper virglrenderer feature detection with a version number that is
>    expected to have the change.
> 
> So the QEMU change will land the last. The patches can still be reviewed 
> in the RFC state to ensure that the series will be quickly pulled when 
> ready.
> 
> Regards,
> Akihiko Odaki

Thanks for the feedback. Totally agreed, will add RFC label in next version.

Regards,
Honglei


> 
>>
>> Changes in v4:
>> - Change this series to RFC
>> - Renamed HSAKMT-related functionality to ROCm for better clarity and
>>    alignment with the ROCm ecosystem terminology
>> - Changed device property from "hsakmt=on" to "rocm=on"
>> - Changed flag from VIRTIO_GPU_FLAG_HSAKMT_ENABLED to
>>    VIRTIO_GPU_FLAG_ROCM_ENABLED
>> - Changed renderer flag from VIRGL_RENDER_USE_HSAKMT to
>>    VIRGL_RENDERER_USE_ROCM
>> - Updated capset handling to use VIRTIO_GPU_CAPSET_ROCM (8) instead of
>>    VIRTIO_GPU_CAPSET_HSAKMT (8)
>> - Removed the error handling fix from patch 1 (virtio-gpu-virgl.c) into
>>    another thread
>>
>> Changes in v3:
>> - Renamed HSAKMT-related functionality to ROCm for better clarity and
>>    alignment with the ROCm ecosystem terminology
>> - Changed device property from "hsakmt=on" to "rocm=on"
>> - Changed flag from VIRTIO_GPU_FLAG_HSAKMT_ENABLED to
>>    VIRTIO_GPU_FLAG_ROCM_ENABLED
>> - Changed renderer flag from VIRGL_RENDER_USE_HSAKMT to
>>    VIRGL_RENDERER_USE_ROCM
>> - Updated capset handling to use VIRTIO_GPU_CAPSET_ROCM (8) instead of
>>    VIRTIO_GPU_CAPSET_HSAKMT (8)
>> - Removed the error handling fix from patch 1 (virtio-gpu-virgl.c) into
>>    another thread
>>
>> Changes in v2:
>> - Fixed error handling bug in virtio-gpu-virgl.c where the return
>>    value check was inverted (changed from "if (!ret)" to "if (ret != 0)")
>> - Added VIRGL_RENDER_USE_HSAKMT flag initialization in 
>> virtio_gpu_virgl_init()
>>    when HSAKMT support is enabled
>> - Simplified blob resource creation logic by removing complex conditional
>>    branching for userptr vs regular blob handling
>> - Updated commit messages to reflect bug fixes and improvements
>> - Added references to related patches in Linux kernel, virglrenderer, and
>>    ROCm Runtime components for complete feature implementation tracking
>>
>> Related patches in other components:
>> - Linux kernel virtio-gpu support:
>>    https://lore.kernel.org/lkml/20251112072910.3716944-1- 
>> honglei1.huang@amd.com/
>> - Virglrenderer support:
>>    https://gitlab.freedesktop.org/virgl/virglrenderer/-/ 
>> merge_requests/1568
>> - ROCm Runtime support (merged):
>>    https://github.com/ROCm/ROCR-Runtime/ 
>> commit/48d3719dba6ca91f597a8179d8b341387ce155e8
>>
>> Honglei Huang (4):
>>    virtio-gpu: Update Linux headers to add virtio-gpu userptr support
>>    virtio-gpu: Remove nr_entries limit check in create_mapping_iov
>>    virtio-gpu: Update Linux headers to add ROCM capability set
>>    virtio-gpu: Add ROCm capability support
>>
>>   hw/display/virtio-gpu-gl.c                  |  2 ++
>>   hw/display/virtio-gpu-virgl.c               | 12 ++++++++++++
>>   hw/display/virtio-gpu.c                     |  7 -------
>>   include/hw/virtio/virtio-gpu.h              |  3 +++
>>   include/standard-headers/linux/virtio_gpu.h |  6 ++++++
>>   5 files changed, 23 insertions(+), 7 deletions(-)
>>
> 


