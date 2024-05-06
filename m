Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D1FC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 10:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3w2j-0000UL-Bs; Mon, 06 May 2024 06:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s3w2d-0000Qb-8a
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:57:55 -0400
Received: from mail-bn8nam04on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2408::600]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s3w2Y-0000g6-My
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:57:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaDJVc/El/6pwL6o6ehdW4+mKwAeqgn2DKf++JC/38Z4jxABfqdL3TJXyx3bAwu3DAlJWWftE+mQC6MwuQCTH9tCKb7ymNXUk0qPLcWPZxPrTN73SrKy/Pg/Q+wPMRNei1vIOuTHtVVLX8mAXY0o1tP1jKNEcx9ssr6L2/Hn7q3zGisKrvVkGIG8cG1X6JEYl+L+YW443DzX0+m7jOcpFMPtDro1XvGYGXM5EzvoMXCidbAHemzDqeN8sjTLVnOUnc0NTb6r8K5BlhGTlv45ajTVZc0DpkKd9yaDmo+Os0hpMoSvISy/lriHRDej13ou8+s5F+oA/Ch9Fj5AG5M4AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a881duHWB2ZtuG2k+klN5tGM5xRz1IvGS9eNZxUVhLU=;
 b=P45X1TpzChY25oEwtAVmIpXoOEXtvSMcBWZCOj5htBqpNojwyhQAX/ObpTHbIJTc3fx0vCtRblSZZpXM8TtbX4yDBNgFds4bA9G+U7zsQJQ3HIjLKHtMIWb1fNBjgV7W6OYqw6hN0xAgb0f4r0o89UK4fGBCWSuktlJw5oMwPyEU/LAStxvV4GzlGdPQteZZQl/+lISIER+7mbrBPzTXHmfhUc+k/XxrNI8mPMZ0M/1vzVj6gCdphyOyM/hM4yco52BikXhNxaSttfXy23lie3ZvKCvizIOEfIhoVxZFJWm+1nb3XROGXdT/9zwquzJgL6Eb1l1bC68fmLa7a5UBwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a881duHWB2ZtuG2k+klN5tGM5xRz1IvGS9eNZxUVhLU=;
 b=EKYhj1QiyrAXZQ6qPSLvDEOdvRvQbzEPE1vWu6ZOpokPg7ljqIWL6RO6gdUGYqgKScjc5iOGSA/WydGjDWR8+0VFn3d7NRuV/tK/CyYwPztNLGX9ezb4XBDsPuCUKTEOr7NcIaXoszKNQlp1yBqofiiltxxVG7opflOAD0GcJP1If//kNwZE3wvpzNGTBYSylqIiIJTXInq+ShnkYv5VeWkeLFFc5QK0vq9BUYprBOyeCVu/WeR7dK60f4juBar9rsdwPT9kLzLwv6IihqFcLl7efXyBsDcKbZ4gE+RlzcFzuD5wxF9zUvNJuel1HU8UhsO4ypBIKuz3KWg1XnTDNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 10:57:45 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80%5]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 10:57:45 +0000
Message-ID: <2ebc8d5a-4eea-49fa-98c2-16666b3cd2c5@nvidia.com>
Date: Mon, 6 May 2024 13:57:38 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] qapi/vfio: Add VFIO device migration state change
 QAPI event
To: Markus Armbruster <armbru@redhat.com>
Cc: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20240430051621.19597-1-avihaih@nvidia.com>
 <20240430051621.19597-2-avihaih@nvidia.com>
 <fd972eee-068e-489e-ab45-e1985115a128@oracle.com>
 <703aab34-1704-4ede-8398-17c0137f6e17@nvidia.com>
 <87ttjbsfrs.fsf@pond.sub.org>
 <d3eca5c6-f156-41e4-a160-1fc26e7c0e21@nvidia.com>
 <87y18np6q1.fsf@pond.sub.org>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <87y18np6q1.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0300.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::24) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|IA1PR12MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 815bb730-cc7d-4c9d-ef1a-08dc6dbb5bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aThxYXI4WXZKR2JmZlhXVnVCTXRSYTNwaG9FdDgyRlB5bDlnODhKS0pKYzY5?=
 =?utf-8?B?WmUzT2owclYrekFOaVRFRktSVjR2SHhFM3BKb3FiK0Zlb0dYTkVobkJUK2lz?=
 =?utf-8?B?VjRBYmhaMnluSk13ZHAweWVLTXhsWGVTdGlzdlRKQ1ZZZWkxUER1VXNhVUl0?=
 =?utf-8?B?R0x3T01FM1d6eTJUQVNlK2wycW5vYkF1bmpQUkpTQkFuM3J3UVlMUjJrTUJD?=
 =?utf-8?B?TnVFNloveXRNa3dTY1FKZVh0WFlJY2k3dGhhWlY2N3cydVBPRzE5dUd2UkUw?=
 =?utf-8?B?aTNmSWtWL1EzSmVyaU9jVG1sY1FwQXRoeVlJdzhlbXNVNjdzMXZacENvTndZ?=
 =?utf-8?B?NlExYk91UXBNVXFYMUwwam13MFp0ZUFLRUJxSTlwNU9DbjBhd2tGb0UzclB6?=
 =?utf-8?B?NGg3VEkxak9yQ3d0VDhxMWl1VTVWdGNlMnVuOXJFdDEzOGpOTlVoRW5BU2F6?=
 =?utf-8?B?L25XWnhZbWU5Z1ZkSGYza1dIakU5TDJCUFMrWjBvaUVzMjFaaTlvQ3RwZjdn?=
 =?utf-8?B?NzlwSjdoTTlrRGhVZ3A2Wm5OVS9vazJTZ3hwTUFGOWwvVUcwRkdGOHZVeXVT?=
 =?utf-8?B?c3dMQjE3aHViNFhOSHNXMlZwcWZEL2pYQU0zVDBxcWthSDMxV2hRYkpvbzFV?=
 =?utf-8?B?TjNueGQ3aFNxdHNVbUM5aFhLQmVxaElrYktFc0xEeHRvZ0xZaFgydnFnalUx?=
 =?utf-8?B?QnFYU2d3TlBlMnljWG5QRVcydlFXQWloKzRWR2hmbnMxY2FzK3BqY3RRNkYz?=
 =?utf-8?B?RTlLWmZoY3RzYko1dWw4RFc3bVR5YUFaQmRtWS91TU1mdlJBL08ySkZMNURQ?=
 =?utf-8?B?ajFDT2ZVbEJDTnpuUGpQYlhSTFg5cDcvUVRKTGN0UERtaGtIa3ZvbkRyNGt6?=
 =?utf-8?B?Tk5qS1dMTUdKcW1UcS91K2ZvdnhOMFFtMHkzTWlOU0F2Yk1MWnd6REdKUGp2?=
 =?utf-8?B?Rm5UMk9iTlQyWit3djdxZHozaFd3cmtuVmpCZys0RkhXODNheXJpVGllWW5S?=
 =?utf-8?B?R29CeXlhcWlvRUlDVHNNMklQSDFxR2l6VnlpcG9xSmhvOHdVUGh2OWJ3WlFl?=
 =?utf-8?B?RGRtNVNVMXZRdkJvbVhMZjlPanh5aXp4Q08xWk1Bd3RhMEpOVXNubyt2LzR3?=
 =?utf-8?B?b3cyeUx5YU9iUGZ0UVVSVmg2NkdKUzdUT2pEdDhlWEhtcHc0cE9qcmc3QVox?=
 =?utf-8?B?eWNnOXNabGY4MWJXNk5BSXV2K0xCMzNiM0g1VGhiRXhIeDJabkhXR2lJWWgz?=
 =?utf-8?B?NlpvOUs3VDF5RkU4VnIwMlNlSkJNd2tjL0xVYkZvV2hDWk5tQnhLb0tXQjc1?=
 =?utf-8?B?TFRkVGtwOUgvc1VTaEp3eTBpaU9JcmNzL0c1QThSaXJtakFNRk5sZWo5ZEM2?=
 =?utf-8?B?bXpQSWk2V1QwMXJZVXZJRU56ajBRd3FCTWdqOHVBbVFlT3lVMVdYSHFXVm1h?=
 =?utf-8?B?VWVZRjVlanpyWHdmenoyZG9XaGZ6TFhUQVozcGRrblRoRkoyTjZLRm15MzZy?=
 =?utf-8?B?OXhkMVc0N3VOU0FmTHVKUmhXSVo4dTZZdjBzc2J3UkRYZ0pOZ0dES1RFVENP?=
 =?utf-8?B?S2x0bEhldWpSdmdUK1ZHalZjNEtlZkR6cVk1aEt2NGJMTzh3eHd4c3F3OFBL?=
 =?utf-8?B?Ui95Nm1rRzBNOEd3UWtDUlVMbkpGWE9aa040L0EvZEFkQ1pZMEIrK3BiVTVP?=
 =?utf-8?B?RjJYVUlKWmU2L0prRlhEb0kwd256b09BSmZyekpWSTR3RlZjZFpud3Z3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUJLeGtDcmdVK0RNMy8xeG5CUURGTmlWZkNSWm00N0dJOXNBRzBwNldLbXFo?=
 =?utf-8?B?NjFGYzVQN0YwM2NtaVFIbjZwM3oweFVmSG1ST3hlcWJOYlVHVUVXZ1lHYzJO?=
 =?utf-8?B?SVFBUUJ4SHZJc1Z3NU5UdEdQUVpUaHNtcFJ1S0pvWk5RTEZObHZGOHdqSVFx?=
 =?utf-8?B?YXRyZ1hZelRyM3pyYmtWMk5qZ3lYcVBVeHlaRFVyN1gybjRoaGIySzUwNjU3?=
 =?utf-8?B?aVp5Zk1qZXVOanJoM1lteldHREtKZ2QvY2JtY01SRmgxMVNDRFBQL0pma2VY?=
 =?utf-8?B?MnlmTk1PNHJ1YmIwTit4Nm9rSnBqZFVGNTZnWGk4RXVwZUlWK05rdFNsMnM5?=
 =?utf-8?B?ak1yMzdLNFlPWDBzc0FsYk52a0xzZHQ2Z3A2THhIeHc0dzRKT0FPdjVLWGF5?=
 =?utf-8?B?a2RmZ1dMNmR1eTkvWElxSDZCK1V5S0wzVEl2WmdKbVlOVlJ0dnZxSmFUV2xG?=
 =?utf-8?B?RUhhUU9oZFJzZlEweGNpNjdPY0JaRTZHQjBtQUZqSmc4aXNkejdrZUttb1h2?=
 =?utf-8?B?ODJabWNCWUlWTTF5bllEZjBwVnlNdHhKL1grTzVwRGxENTJjTHRZWTlOdFFj?=
 =?utf-8?B?REdzWGhJcVJqdXdnejZSNzczQTRaV3EzUW1idThFemtpUXFvZWgrZURoMWJl?=
 =?utf-8?B?YkFwaHA1RG42TjEzV1lvWGIxeFJYN2xWR2x3U3ppY1FqK2k3dXhFLzJpcXRv?=
 =?utf-8?B?aDNmU0ZBZHM2TjhrOHZGNnhuRHE4U2tCQzVHOGdub0pDTGxRZnBQQXhreXFU?=
 =?utf-8?B?SnpnMjQ4S1JQbHFoT0gwL3dOQkRLZzEyNFFuVDkvOTdrcWJBQVJqSnhqVGVT?=
 =?utf-8?B?RlRFODJxZHg1MEpKT21uYkFORHZ4THBUSnl6S3VuejNlQUEzUnNnZGlpTjg2?=
 =?utf-8?B?dHBuZnI4aWswN2IzOENaRWZDT0cxN1Evck1oNitMR0FuQkNaTGN5VEJOd0hr?=
 =?utf-8?B?VUJOMVMxMlFMdzZ3MW9oNnJBMmpncXVoUnQ4a00zNGJMTTZLaTZ4Q1dheE5k?=
 =?utf-8?B?QmJCS0R5MlVlT2RQYm02Sk9NWnNpQTYvNkMzWTROcjB0bGNRMmRPbWhVSVBX?=
 =?utf-8?B?bEZTNHh5MVBXeVdTNHZ4eHlMSzB1QnBZeEtPZ3p0MVpSUDl6dC9jdGNReWVL?=
 =?utf-8?B?cGlEWWZCQ2FrYzJ3VlBZakFEa2ozVDFLVkVsZ2luM1JHYnQwbmtOVWZ3TE5V?=
 =?utf-8?B?Wkp6bndVVjg1TDZQOGhJWDdteFJrS0xwYzI0dzFrd1ZQTnFPSEtkRlo1TkhX?=
 =?utf-8?B?eU1EZ21uTWpkemxiZElLcVZtU0d2T2JMaEJUZ0JpSHpNNnBZOXJKRUZNQnU0?=
 =?utf-8?B?bUNkbDJZZUhtb1c4QWVkeFpNM3g0S1huMnZxZTkvUHZKWUoreWhWLzZ5RXd4?=
 =?utf-8?B?MGhSbC9tcWlQWk54QlVsN2QwWUs2UmpPRTdRSE5rdkZnYWZHWTdta2tTTTgx?=
 =?utf-8?B?UEtTTUNod2tId3VEY1htenAyTGhGWjBxTTUwZ2NuQmVMTCtVUUlUbWllSHhU?=
 =?utf-8?B?TkdqSGNtcnNxaDRxQWVQMjIrcFhtRkZRS2VMaE1lZEtYMHVZZlh1bkFHVnhN?=
 =?utf-8?B?dTQyRlRJOE9JVm5leU5LUm5aMUY5bWxJV1Joa2VlTzA3SFZnY0lkeGhPcEVy?=
 =?utf-8?B?VnBSTkg3UWdLVm5sc3hKVk4zSUoxWTRUYUhJZXQ3cmo2b1lPUWM4RGRxRG00?=
 =?utf-8?B?ZnRvSTVQVXJOaHYrL2VlMWkrUXVWazFhd0tBK2JrMjN2RU5YVkhsSWw5L015?=
 =?utf-8?B?dXpicERnQ0VDUFRMc1lPU01iU3B0bExqWXBJWDZSQnpsWGJlam9NaHBzcVZU?=
 =?utf-8?B?VkpsN0h6a09YMm9zNXU5clpZN2MxT3pTcEx6UU5WL3QxYks1TWxwaWVyM09v?=
 =?utf-8?B?d0ZwUHFzaUE0YzdpSVdTK1d1ekZMUzF3RHJDQ0JQOXdRYjA4bkJibUllWVV0?=
 =?utf-8?B?NHlxb2lXQjk5bDNZcWkwMWYrRzE0YkhES2hDVk9PYWIzektaS25FTmxzODM1?=
 =?utf-8?B?a05yN1d2UFhYVlF1dHVWbWlYWktYYU5UcmE4K204RmpWSytCTjN1ODQzV3RE?=
 =?utf-8?B?WWcySDdXNTVMajRjOVRLRHlIL2VlQkN2cnZMSC9haFBqMENaTTcwMTJZa2Zu?=
 =?utf-8?Q?E79eyjCBqUYS6y7I2UFfZHgSw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 815bb730-cc7d-4c9d-ef1a-08dc6dbb5bf9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 10:57:45.3176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMZQEP3b6Flq5aRMZj7+M6TkezJZVh2OdpVlZZTqXP2seeX+1vwJClVSloZ704mW5KyIkjZUK27Mntj1TZ2i8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307
Received-SPF: softfail client-ip=2a01:111:f403:2408::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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


On 06/05/2024 13:36, Markus Armbruster wrote:
> External email: Use caution opening links or attachments
>
>
> Avihai Horon <avihaih@nvidia.com> writes:
>
>> On 06/05/2024 7:52, Markus Armbruster wrote:
>>> Avihai Horon <avihaih@nvidia.com> writes:
>>>
>>>> On 01/05/2024 14:50, Joao Martins wrote:
>>>>> On 30/04/2024 06:16, Avihai Horon wrote:
>>>>>> Add a new QAPI event for VFIO device migration state change. This event
>>>>>> will be emitted when a VFIO device changes its migration state, for
>>>>>> example, during migration or when stopping/starting the guest.
>>>>>>
>>>>>> This event can be used by management applications to get updates on the
>>>>>> current state of the VFIO device for their own purposes.
>>>>>>
>>>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> [...]
>
>>>>>> diff --git a/qapi/vfio.json b/qapi/vfio.json
>>>>>> new file mode 100644
>>>>>> index 0000000000..a38f26bccd
>>>>>> --- /dev/null
>>>>>> +++ b/qapi/vfio.json
>>>>>> @@ -0,0 +1,61 @@
>>>>>> +# -*- Mode: Python -*-
>>>>>> +# vim: filetype=python
>>>>>> +#
>>>>>> +
>>>>>> +##
>>>>>> +# = VFIO devices
>>>>>> +##
>>>>>> +
>>>>>> +##
>>>>>> +# @VFIODeviceMigState:
>>>>>> +#
>>>>>> +# An enumeration of the VFIO device migration states.
>>>>>> +#
>>>>>> +# @stop: The device is stopped.
>>>>>> +#
>>>>>> +# @running: The device is running.
>>>>>> +#
>>>>>> +# @stop-copy: The device is stopped and its internal state is available
>>>>>> +#     for reading.
>>>>>> +#
>>>>>> +# @resuming: The device is stopped and its internal state is available
>>>>>> +#     for writing.
>>>>>> +#
>>>>>> +# @running-p2p: The device is running in the P2P quiescent state.
>>>>>> +#
>>>>>> +# @pre-copy: The device is running, tracking its internal state and its
>>>>>> +#     internal state is available for reading.
>>>>>> +#
>>>>>> +# @pre-copy-p2p: The device is running in the P2P quiescent state,
>>>>>> +#     tracking its internal state and its internal state is available
>>>>>> +#     for reading.
>>>>>> +#
>>>>>> +# Since: 9.1
>>>>>> +##
>>>>>> +{ 'enum': 'VFIODeviceMigState',
>>>>>> +  'data': [ 'stop', 'running', 'stop-copy', 'resuming', 'running-p2p',
>>>>>> +            'pre-copy', 'pre-copy-p2p' ],
>>>>>> +  'prefix': 'QAPI_VFIO_DEVICE_MIG_STATE' }
>>> Without 'prefix', you get VFIO_DEVICE_MIG_STATE_STOP and so forth.  Why
>>> do you need a QAPI_ prefix?
>> VFIO uAPI already defines enum vfio_device_mig_state and its values
>> VFIO_DEVICE_STATE_STOP, VFIO_DEVICE_STATE_RUNNING, etc.
>>
>> I wanted to emphasize these are QAPI entities.
> I see.
>
>>>>>> +
>>>>> Considering MIG can also be interpreted as Multi Instance GPU elsewhere
>>>>> unrelated to this shouldn't we be explicit here? i.e.
>>>>>
>>>>>            VFIO_DEVICE_MIGRATION_STATE
>>>>>
>>>>> ... to avoid ambiguiosity.
>>>> I used mig to avoid long names, but I don't mind changing it to migration if that's clearer.
>>>>
>>>> Thanks.
>>> We generally avoid abbreviations in QAPI/QMP.
>>>
>>> The event that reports general migration state change is called
>>> MIGRATION, and its data type MigrationStatus.
>>>
>>> We could call this one VFIO_MIGRATION, and its data type
>>> VfioMigrationStatus.
>> Sounds good, but how about VFIOMigrationState (I'd like it to relate to
>> the VFIO state)?
> No objection to "State" instead of "Status" then.
>
> On VFIO vs. Vfio: several existing type names start with Vfio.

Ah, yes, I see: BlockdevOptionsVirtioBlkVfioPci, VfioStats, 
VfioUserServerProperties.

I will go with the flow then, VfioMigrationState it is.

Thanks.


