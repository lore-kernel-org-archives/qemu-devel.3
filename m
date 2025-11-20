Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0C2CF58D1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 01:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLtbE-0004D2-Ew; Wed, 19 Nov 2025 20:36:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vLtbB-0004Cd-8U
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 20:36:37 -0500
Received: from mail-westus2azon11012036.outbound.protection.outlook.com
 ([52.101.48.36] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vLtb9-00030N-4q
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 20:36:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stuX13pM3C9ahqQ3QXQWAdA7T48je+J3vmJoPABq6/VvOW/WqmkFjo6UHdaJpGN+oJrdXPhKVZAdzm8q/EkJDwxYPGiofrQJiN1VFqSRFo1tYhAumMMks9bOJJlOXZISoARvVipIdavIOqh1qN1NezqVYu6sGnIA9/a4WDOe4d+ZvKNwoY0BuGUSFRTIuDirSlVSF3fHaRPdRgeMdn3UpXcT/+8UMOg1d7K3chAURV3AV2CMIzEBI57ASyPhIXu0eIkmTxqHbzN1EN5S7yX8vNXPqTVUIH7QV/2UqEdtYPvkiuxR+33LEwS1RG8D+nXXgo751j8F4jSYnb5qxkvpqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTGhXzf95FgUxXHWbwbVjmo6MgGEHCMHCshyOEnbzkM=;
 b=qGY8uwZETct7Uryz/K1Cw2r5JtMxUQt4LSnNzDazd6qIopOZ1Rlsvn7Y4QjAkZW1SrRd/V12hGL+jQycYfLtn2jG2kz9sZMtby28N2kxdO15oKavUifmMz5O601/U5OIeqjCY6HvF/F69k09qvfAFBqSdEfKtbycvNcuHyDTvTvxqdi/9IdxnXo/U5gC/H7L+kJQ9+yhvciWs0pLodtB7XS+YqyMlZIKhRroJ4RqHMPNxrUmyqftSyj9ygtZSUIGZCUtOe/TVdA7YbqrMdabszBnj+x0Hzi4lbTxuJlrdPYUQ1VJcMwU3B/+m2vLR9Eye8hX7x8dTsM+Pgmhg/9Tzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTGhXzf95FgUxXHWbwbVjmo6MgGEHCMHCshyOEnbzkM=;
 b=T3XjoceqsmIYDnVAuIR/TJ0OiAFkF0QK0cVba9vZi+mmHZOYJKKOFd1MWdGElwV/u97hGZcV/ADBBqzkysYBKsnQJaaJ3z3lUqUqgQUiznk6G2MQcozG9prYmxuEixONsDEA1mWZydkYut80y02MmTRlRqC52G35SMfVyeZ4RfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by MW4PR12MB6825.namprd12.prod.outlook.com (2603:10b6:303:20d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Thu, 20 Nov
 2025 01:31:29 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941%3]) with mapi id 15.20.9275.015; Thu, 20 Nov 2025
 01:31:29 +0000
Message-ID: <65952331-d018-43d9-b81a-40a2ce477977@amd.com>
Date: Thu, 20 Nov 2025 09:31:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v4] virtio-gpu: use consistent error checking style for
 virtio_gpu_create_mapping_iov
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: alex.bennee@linaro.org, odaki@rsg.ci.i.u-tokyo.ac.jp, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 Ray.Huang@amd.com
References: <20251117105104.258513-1-honghuan@amd.com>
 <9f547fbe-ea57-4784-9e37-f79b52b551a9@collabora.com>
 <87bjl0pzeq.fsf@pond.sub.org>
 <ed8fd731-8e47-4282-9439-00e6c367b672@collabora.com>
 <e04a19fb-73bb-471f-94d9-df9b1d08d6d4@amd.com>
 <cc80a97c-ca8c-4da6-bbd9-77f1c90a299d@collabora.com>
Content-Language: en-US
From: Honglei Huang <honghuan@amd.com>
In-Reply-To: <cc80a97c-ca8c-4da6-bbd9-77f1c90a299d@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|MW4PR12MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f12ec3-f3ab-45c7-2115-08de27d486ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEFtSDlsRjJnSmRxYkR0Unp4M05Xd2ZvVnBUV2tqYm1HSVcxOGlCTUZabHl2?=
 =?utf-8?B?cHBUV3FpNTVReUFXMVVwRHJmVERSVUlRNUxWWnV2V215dGtjQTUxSEFlNllk?=
 =?utf-8?B?WDlNSGRmOEhxKzkxQmNJczlya0Qyb284WnBqZGtiSEtLYnI4TE81UURBdldY?=
 =?utf-8?B?UU9RdzJBTUxNTEdUbnNNUjhFeDJVbm9UU3pPRE01R3dsSDFxRFpBMVR2M2g1?=
 =?utf-8?B?QnBGRW5uQldQUXNFTmFhZlNrdllQRDU1QkRpOTU0TGVLS2RiVXE3WWRhcnNY?=
 =?utf-8?B?dWlGUWRSeW5oQzZOeUxCOXVyRlRVWnhicWlXSDJXWUtaT01lOGxibVNoWE9w?=
 =?utf-8?B?dkdFSUpDVFZISkFheUNrVFhjbkJiQWZNYmlETTVNWmVUNFZoQXdka3pOSnh0?=
 =?utf-8?B?MDI4VVNLRDA3RUF5SnpjbEJHcEt6VzJ1dENSMUxsbDBnYWxNUnlRK1d4d05F?=
 =?utf-8?B?dXdtRzRZc2MzSjk2VlV3SXFjc1RCU1lRSlgxRW9aTjg2VEpUNUdoaVYrWEo4?=
 =?utf-8?B?T2RCYVA5eVk0eFdYdHZ4VHBNb3VHSUZKVU9kaFJQMHVESldJY2MxbFF3MTRP?=
 =?utf-8?B?eEpEczNlZzBqd1dwT0tpR29ia1JWN2loeXhYSWV0NFA3MDNyOTJTbDhNTU53?=
 =?utf-8?B?NGlpSnVvWnJKaUxBdUl6NG5jKytieG93dHpMdDdBR3VGdDRkUS9MMyszMUc5?=
 =?utf-8?B?dlRMOGxLUTdIczJRU0E3ZGJtNksvUFAwVlkrczZJMXJEWlZPSnUxaU8zWHNT?=
 =?utf-8?B?S2x6UVZJWHlkVWFJWk5hNmgrdytPTkFxNG5jbGpYZ2V4R2owZXpESktiLzlO?=
 =?utf-8?B?V1BaaWNUQ3ZKaVJFakd6OU1ya3VRUjdwa0pxOFVwZGJuWldBdnloTlk5czhB?=
 =?utf-8?B?b3B1NlRnMGRWNUJ1aVFhUnNldFBOQXlPSUhIeG03WVh5S0oyWnpjRGVuaGhJ?=
 =?utf-8?B?SVRJNm43dkNOT00xcjZCelB2NDBGb0J4MFJ1L1U2eVh1eUlWdnduNVlXYXcv?=
 =?utf-8?B?MmF2Y3ovSWllM1h4YWFTOWNnSzZjVWlSYi92LzBZVlF6cjJycUVGSEIzeVpI?=
 =?utf-8?B?a2MrcFhJSDhaQmNRTG40THltanhSWTB4NVVNNldLVHFQMlFKTVh4M1BpUER2?=
 =?utf-8?B?Zk0rQ0Z1SkswMWQ5NlRlMC82ZmJxV2s2dEhmek5LcnpTY052U2YyeS9KU09W?=
 =?utf-8?B?dktROVNtcHhWNy9MbWQ0TTdYa0ZNQXk4QmFxS2NTZkc3bU9NMXNYbmJTSTVQ?=
 =?utf-8?B?STk4bEhiN1BWUmNWZmRlcHJnOU80ZytIYlhiVGNnTW9BbXlEUUY4dm9LSDNG?=
 =?utf-8?B?OXRhWjVaY0JTYldGbjNpYkFEWEpOL0JRdGFnYjRTS1Vpdzc4Q3Vla0tDdTJQ?=
 =?utf-8?B?ZDBWODkwWllWY3VVblpPMDUySUwvM1FITld2MUxadlNmSHB4SjE5cEp1ZGl1?=
 =?utf-8?B?M3RpRXQ1U1ZKdFMyZ3FRek5TY29tQnlWdHhrYzFXNEtjN0p6QVRRbFdLdUJT?=
 =?utf-8?B?Y0ZZaytFVXRCUHJqbWc1UWtIcDVaOHZjZ3lUK05reG94RTNGRG9KZWJoZnJN?=
 =?utf-8?B?YWdJWW05WVlURklNc3dMbWMxaEtNZStKdllTdm5PRlJPd3R4NVVOWGdnWmJx?=
 =?utf-8?B?SVJrOEw1MEJNYk5wclMyTTJjVEdEc1hlMjFjTzFiOU1JcjR1K2pqeXkybXVv?=
 =?utf-8?B?ZW8wSUxYUFJMbHR1VER3MFNla3ZPQ1EzUWIyc3ZQbTh0YStMRTAvbGJqSmFF?=
 =?utf-8?B?RGRpSkhmRFljbzJsV2dnUTdZUmdjNTU4ZXFpWVpsYlU5Wktsd2NyNFNTV2tC?=
 =?utf-8?B?U2x3ODVuS0lLYnRkTkhzZm9GRlZ1d2NKazJZdWtUbDRqejBHZytOSTNrL0dl?=
 =?utf-8?B?b3VTYTRHdlBnYXJwbVhnTHh2VDFxVGw3bGlCWDBSVGtwRFlJMnFiQ0FROExz?=
 =?utf-8?B?bDdqaDlqVUxJRDlIZkRtd2pBc3lONkNkR1c5bGtEdld6WjFtYjkrVUhVWnhG?=
 =?utf-8?B?TW14NnI5LytRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1VUU3ljV2QwYko5OXMyeStzSXVaa3ZCZTJLU0VFVGVlWE1GTXp0bHBnaU5p?=
 =?utf-8?B?eWxVWWZPeGpFREZFL2c3cFM5L3FWVnRPZnRyWGNDVjZLUVJJUlZkcUZnYUZu?=
 =?utf-8?B?K0U3aER4ekZqYzVvQ0dCckNhRjBZZ3MxUlRlQW1DSURKeWN6ZkpaeEVEenlF?=
 =?utf-8?B?Zm55UlcremxSbnBTcGNIS0JEcHMzSW0xdFllSUxxdHlHZndFTHg3WU5Jd2sz?=
 =?utf-8?B?UEtWRzhteldXYldFbmRqUmlNMy9BWHZWYXN0a0pxcmZxVXlnNno1N1F3cFph?=
 =?utf-8?B?ZGlwSHIySE15SUFFVVNsUGRqWmtYVkxhUXJmZE1tUURKcUU3akNSdXdRSzdJ?=
 =?utf-8?B?QkhaY2JZK1YxOEFQTzRNVGZLcktURWkzcWdPZytMcVRSNEVhbjVBLzkzbmxZ?=
 =?utf-8?B?ckJ1VTlub0ZlbVVTVGtCRGNXUGdWY3lIZFZUR1lJak0yNVc4aDJhbHNsdEsw?=
 =?utf-8?B?dDhhTkwwZjRjQ2ROZ0pyL1d1RXV2UjVCNVRBSkc5alRzZ0ltSHZUUUFzeDYr?=
 =?utf-8?B?d250blB1ckZLams0cjRNYnFrYzJJbVZsNW1pUVo2L2kyQ24rcXRpcVJSMUU4?=
 =?utf-8?B?dUV5dU8xNDZ0cG1aOEtYYUx6K3FKRWYvS1JHalQyaFJJQXhtSW81S1lSdnB0?=
 =?utf-8?B?SGdNblRsRFFTN1hGZU9UNCsyVFdXempaWlYxY2ZLT2tMNzcwc2U2N1FTNEY2?=
 =?utf-8?B?dVJyYWxnRlhDUkU1VUhSb0lPcXNtbFZIam1IczlIb094VWJLcTF0SElsMGRK?=
 =?utf-8?B?RytaNWhmSStralFrZm12aFpJZXhNWXRTVmxaMTJxNElqU1k4M2RZRDNHTnBW?=
 =?utf-8?B?R0phWVZWUTFDYTBYT01taXpOb3FFeGVjWmpKOC9NU0UrN3poUWRYUDZ0YnNi?=
 =?utf-8?B?TzE3a3JubnpwOTVXMTVEN1NEcjZ0MER4b1JKZVVXd1gvTnRSeUpObkYzZ1kz?=
 =?utf-8?B?Y25TdENnNG0xMS9NNHJjdnZUVVgzQldFeUNTS0ZvY1B1WkxQbkN5Wi9OMllh?=
 =?utf-8?B?QWZ1VHZuZ0FzVjFnMzlTMll1eHF1LzNxUC9zdWpGblVxWEExZ2VlbmZBTXJJ?=
 =?utf-8?B?YlNEUFFkYjdsZmxJeFREcS9GUzJZNmxpd0x6bnNsOURZWEJmZkZmQUtyWE1S?=
 =?utf-8?B?LzBydk1TV0hQWERtVy9Dcm15dTV3RTBRTlNEK3Bod0RvOVNtMmVPZ0NXWUlw?=
 =?utf-8?B?Vmp3cHhCMVBBd0lVRzNCUnRQM1NQdkxYaG42dVpSbUZhWVl5aXJsb0szSEdW?=
 =?utf-8?B?VnpTbXM1bUNlbkZETlhsUHBBc2RyM1ByeXl3YmhZZkJqY1hqeTVLYm9vQ0ds?=
 =?utf-8?B?OGJkRkdKZjhGRUlDanUvMDEybzBuSHdjVnZFRHRNdzI5dlJGNDJrYTZvRVJ2?=
 =?utf-8?B?OFlkL0lDNHFOZG5yZCt1MXV5bVBwMHgvZndHQWEycEhLcWpwdElxSFdCdlNL?=
 =?utf-8?B?VVQ1TzZLUXpvMGg5NXAyb040bjBYLzVMSldVdWUvQzhnQTZQYnhzQU5zU1ly?=
 =?utf-8?B?eUs0L09Lb0V6dEE3VitlVkIzMWhHZVJMQXRxcmo4Z01MbTRoOTdxS2gxZ2FF?=
 =?utf-8?B?R3luNUZ2TTFmczZSL1dzT1dWVlhYRWhnQlhEOGl1WVZMdHBaTWxHNVQ1Rm1x?=
 =?utf-8?B?TUJBNU0raGZQK1JqWlpwWklXa2VUYWlqZE00czdtelc4ckZqVG14ckV3NzFx?=
 =?utf-8?B?ZVUyWGVQQU9INVhnL2ZvMEtXdTNnMFZseUUwSW03VS9yd0lFWFhScTRBazI0?=
 =?utf-8?B?UFczcG5QTFJJREhIVDB2eUYzUzVCNTI4U2NNWUw1Y21NL0M2RlN0d1RrMXln?=
 =?utf-8?B?Qm42blVFZmtVVmJnblBtei9kbTlmZEw0TzdpckFHNWxEU29zLzZmOUY5Rkpm?=
 =?utf-8?B?ZlZDZElKNjhXa0VXY083dk8wU0RBQWVhYWhSYVVYTGU0TDBGaS9JTDBIR0tM?=
 =?utf-8?B?c0VBOGNrcUZyUEhuQytsTDYrUWc3ZkQ2SFc1Sys4TjBlZTdwd2RtdUhhclBW?=
 =?utf-8?B?UGhUMVBuL09hTkFQNVVxcmVsSW9EcjIzOEdvY1dZeU5KSTFJWDlMRmRkc0tC?=
 =?utf-8?B?eU03Ums4L04ybm9vVmlEOGtrK2lJck9Zb3pxNTJTbWMzYytrUFFsYkp5bisy?=
 =?utf-8?Q?5bBPxIWtuC8aUTVThCwL1dKZ2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f12ec3-f3ab-45c7-2115-08de27d486ec
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 01:31:28.8954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/CoPcw0gCP6+sVY4zmKNbE/Yewq2yrN8nKgd25kb+crz0RG5rTC0ouWaxAQVKdZ2+qsdc+hQqK/Zm4DH1pwHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6825
Received-SPF: permerror client-ip=52.101.48.36;
 envelope-from=Honglei1.Huang@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2025/11/20 03:16, Dmitry Osipenko wrote:
> On 11/18/25 15:32, Honglei Huang wrote:
>>
>>
>> On 2025/11/18 09:48, Dmitry Osipenko wrote:
>>> On 11/17/25 16:22, Markus Armbruster wrote:
>>>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>>>
>>>>> On 11/17/25 13:51, Honglei Huang wrote:
>>>>>> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-
>>>>>> gpu-rutabaga.c
>>>>>> index ed5ae52acb..ea2928b706 100644
>>>>>> --- a/hw/display/virtio-gpu-rutabaga.c
>>>>>> +++ b/hw/display/virtio-gpu-rutabaga.c
>>>>>> @@ -466,7 +466,7 @@ rutabaga_cmd_attach_backing(VirtIOGPU *g,
>>>>>> struct virtio_gpu_ctrl_command *cmd)
>>>>>>          ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries,
>>>>>> sizeof(att_rb),
>>>>>>                                            cmd, NULL, &res->iov,
>>>>>> &res->iov_cnt);
>>>>>> -    CHECK(!ret, cmd);
>>>>>> +    CHECK(ret >= 0, cmd);
>>>>>
>>>>> virtio_gpu_create_mapping_iov() doesn't return positive values, don't
>>>>> see how this change improves anything. You now saying that ret > 0 is
>>>>> okay, while it shall never happen.
>>>>
>>>> Please see
>>>>
>>>>       Subject: Re: [PATCH] virtio-gpu-virgl: fix error handling in
>>>> virgl_cmd_resource_create_blob
>>>>       Date: Mon, 17 Nov 2025 08:49:42 +0100
>>>>       Message-ID: <87ms4lrtd5.fsf@pond.sub.org>
>>>>       https://lore.kernel.org/qemu-devel/87ms4lrtd5.fsf@pond.sub.org/
>>>
>>> It's a rather common bug when errno isn't negated by mistake and a
>>> positive error code is returned. Ignoring positive values when they
>>> aren't expected opens door to unnecessary problems, IMO.
>>>
>>
>> How about apply the v2 or v3 firstly to fix the
>> virtio_gpu_create_mapping_iov() block issue in virtio-gpu?
>>
>> I will create another thread for the `CHECK(!ret, cmd);` thing in rutabaga.
> 
> There was a precedent of virtio-gpu not handling positive error codes
> properly [1]. To me there is no problem that needs to be fixed when
> virtio_gpu_create_mapping_iov() is never expected to return positive
> values and doesn't return them.
> 
> [1]
> https://lore.kernel.org/qemu-devel/20240129073921.446869-1-dmitry.osipenko@collabora.com/
> 
> It's a common expectation that errors are negative. But in practice it's
> not always true, especially when interacting with external code.
> 
> Functionally this patch doesn't change anything. Will leave to Alex and
> Akihiko to decide on it.
> 

Hi Dmitry,

	Totally agreed with you.
	And actually the origin purpose of this patch is to fix virtio-gpu not 
handling error codes properly. Please see the V2: [1].
	The error handling logic was incorrect. virtio_gpu_create_mapping_iov()
returns 0 on success and non-zero on failure, but the code was checking
whether to set the error response.

The fix changes the condition from 'if (!ret)' to 'if (ret != 0)' to
properly handle the return value, consistent with other usage patterns
in the same codebase (see virtio-gpu.c:932 and virtio-gpu.c:354).

	So I am suggesting to apply the V2.

[1]: 
https://lore.kernel.org/qemu-devel/20251117073827.114891-1-honghuan@amd.com/

v1: 
https://lore.kernel.org/qemu-devel/27e24af2-683a-48f2-9b10-e6f4061d49d4@amd.com/
	
Regards,
Honglei




