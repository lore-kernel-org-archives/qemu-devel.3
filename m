Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD42FD3399E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 16:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Sof-0003I9-1Y; Mon, 28 Oct 2024 12:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t5Soa-0003Hv-2z
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:42:00 -0400
Received: from mail-dm6nam04on20614.outbound.protection.outlook.com
 ([2a01:111:f403:2409::614]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t5SoX-0001UL-O2
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:41:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awrUhyFMy/Fjy3VNzWzrhzvSsbHiczYuVNYlBNmHo23xCTitBuCXgZkcrq5juST65OXUYyGS3ezdgAt4Zy5rN5BBgkE/ZhAKA1SslzJ+/Ww5qGhif+4hHZJ9s8Xw77o2Xx8reCtJT0SYEB+t22VGO3SJzgdLkG/LfCZ56JYSAfEPfPYEMgsB5XN3RnPXoo3U0CdH1enIFLWWH3d7zKf2r1KqTXT9Cm+DH0mBF3q7In4dK6sFbp/pvIWaOmGUg4HRdJxvjayIAaKj60wjWrJyy7lc+FK9Z0jJN+EIVg9lHuALKw59EhLBNOMoYUxSKMykY9gTdACuqpiMPeX3GwnMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADyi2VLuBu15sJZt+ldZDdm21HdZ6/0R6sojBpCgtdo=;
 b=IPmeGe/vcu6RFN9BXqnmUo3oAiwaNMcz1A/ln3Nnsh42fYhY4+zsrhx5P7U8naBKMxpW3UhRiputiPVgk617rKOp92mkRHvFuDg8Z1d97lECDIFHakF1AOh2R3a9sySeRJtOV58GQGk1w5Grk+nKNP8XEoqc6sVbnpY/k1exUkZKbEsZu1iIuCtLCGlKBXgWSzVIv+WHQUaQl/vnEeyJRvO2K38WfTMt/zSn8/D9b69q7+L/qaXDVR/KzxO+HWg96tkQi+4FCGz0YyCgtvP+19T38qg/apJQnsYArMCp0wKefGlEWvTf1tPImLDZJx/zRr0+HHyu5Mg0tYOUxUOevw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADyi2VLuBu15sJZt+ldZDdm21HdZ6/0R6sojBpCgtdo=;
 b=WxrTyB7IH7L10abvhjCYqKXdSnYFkYra1AD5abZ6Lyh00IcpL9HxIX4t9kXeclmQsgFInlMat3VUgVcnpQQOW1/xJDooMvF1f0OfsIwwX47eBmmNeirdwvYaMRQIfXA8LtYXn/E/RfZneK9Rd9Yzn8eEHoJ6rWBv2/yvfuEDPIggJL4/RSqUGU6jati2LS0cFjK/ZkYMqfc78Ew8sLOF/Q5Zly8j4WaSp/UP7hDT/nHX/0SRpy91JbSvybWcDcxonyL9eNxvLIsypW5GaqxBMeq7T/dIbVjhrt3SKtlVIQLwK4jpVTyPCvjGJ5CK19oSplWLEkbukzjEXgCSuMyyYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 16:41:48 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 16:41:47 +0000
Message-ID: <4c6bb701-dd6d-4cca-be80-156c19f2a088@nvidia.com>
Date: Mon, 28 Oct 2024 18:41:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] migration: Unexport migration_is_active()
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20241024213056.1395400-1-peterx@redhat.com>
 <20241024213056.1395400-8-peterx@redhat.com>
 <78729b4b-3747-4408-8146-12d49e70fed1@nvidia.com> <Zx-xpZzYG_1KuCQu@x1n>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <Zx-xpZzYG_1KuCQu@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::22) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|IA1PR12MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b6b61b-4da0-46bd-e934-08dcf76f6a3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHpFNnZqRzNFMWVDOUNoM2dJdVdrL1FHWkNCcWZEOFNNRm93SkJlelFkNFNr?=
 =?utf-8?B?dEUvWHI3TnFGQ3UzMDlUaGRvYTVBRUIwTVRmdnlWY3BXemUwdDRwc0RYUFRQ?=
 =?utf-8?B?dythSXRINU9Kekw3UVVQL1BaM1BnRHRhN0YwWTlINGF3OG9jRzJtS0tJVnRZ?=
 =?utf-8?B?dWsyeXFsaWtyV0EydHdLR29iOUVVSVJmdldVdThRbGxWMmk0czhpNnBXb1Rl?=
 =?utf-8?B?dE5rc3U3YU9iTDlHZUt2SDVXQTNhQ2FVbHA1RitvRFBzQ0lvK212bXdXQTh1?=
 =?utf-8?B?cW5rV05CWTJ4RjYxSDdYMFo4SkdJekhLZkx4bVRYTGEyS2s1NEpUeVZKSG1N?=
 =?utf-8?B?ZHNPcFJuMGhkSldCOUhGenlvSmg1SENHdE9TRmIrOE1VVkk1cGtlcWpNMXJz?=
 =?utf-8?B?VE1OMGR1ckFqL1hIWEJkdW4vLzIvMmNIVU9tSUR5WDFwbzYxQlZyMW9NWjN5?=
 =?utf-8?B?dGEra2lmekVaT1JBeEFwWXltOTVLWWxIM1o1R0MyU2RqT2lxUnVydll2TkpV?=
 =?utf-8?B?WjRwSzhwRzVhU1lUWThLYnZMaC91dGxVMkZzQWdsK2Nua0ZZMzBJelRxaDV2?=
 =?utf-8?B?N3VManpQbXJzbkhYbW9TWTd2Y1pnTHFqQU1leU5pdkQ1UXcwZmVOUlhoL3ZO?=
 =?utf-8?B?QmdoOWF2aW1BTmJhZ292d1FZa2w2ckF5NklES0hHWW5TeUY3QlBHU3Q4Mk5Z?=
 =?utf-8?B?bEhtKzRVb1NJdkhKREh2enJieCtSMUYyVm5oWVg3WXQycXNJd2ZyR3Q5ZlJ1?=
 =?utf-8?B?WXk1QlhCMVNXREFRdlVlNjBNZ2RITlZVWDlGRHBUUnNETm5lSWw4bk03b0Qr?=
 =?utf-8?B?dkVXVFhjTVFoR1lnbWdaTjJPaDdEVFl2TDhVdlRHcnpWL1FKV2svRzBMMnAz?=
 =?utf-8?B?SFdQaE5KaGlMckdRcjVaWDFCY3h5UGZCaDY1MnhhaEZvVkxNSzlDQTJ1cVVM?=
 =?utf-8?B?U2h3Wk5xMWJydnVpVzdmQ05vMy95V0VJdFFwRFB5RW4wWEg1MmdUajhrM2ph?=
 =?utf-8?B?a3pCUnlWV3pVVjVFTlNCWjIzYnNXWEVhSVZnUUlwWmdUbG5McnArTjhma3Jr?=
 =?utf-8?B?NXpTTGovdk9jNEZ3QVZSYUMxTnFaTHZ2Q0Jmck5pTmxDQ0kwRW02RzJHS3B6?=
 =?utf-8?B?Qno5NmxtTEFEeTBvNWtsb0hPR1NqN1JZSlNzSVA5dm85YjE1VVJ4Q3VkVllX?=
 =?utf-8?B?V29HUFBwczEwcHdxdVBHM1VLbGlYdU9RMWNHZ1pnL1NNZE9DakxkTk05K0pX?=
 =?utf-8?B?QngyOUxzbVlzcDk4QU96VExtTTNmYStkTmtRQjNsb0hqamxUcCtDbDZzVGh6?=
 =?utf-8?B?cFg0MEpLOS9zcHpQdUpxV3FxeTVEbWJubWJ6N3oxcEh6UTl3QjFLRDVYYTN4?=
 =?utf-8?B?OHQ4QUo5eUN1cmh4WEthV2llVmNEUHlXMEgrUzZZanAvRkMvR1BWUkZVVU1o?=
 =?utf-8?B?ZExxYnFQY3EvWW5MbXZ3M29ua2pEbkpjai85WW96ZjA0bFVQWVdPMFIxRHlB?=
 =?utf-8?B?VTlKNmNiRWF3NExneHlXeitabkt0SjIvKytHWkVMOUk5Skp5UVNxaERsUFlK?=
 =?utf-8?B?MmRkVXozSFdNSzNody9mdG5RWlhHc29SYTcrVVl5Yk0rQkk4cE5nRHFIT0Fw?=
 =?utf-8?B?dFl1ei9BT2doUkdubXhJclZ3bnVwQlFiTjJ2cnJiQ2pyVDdTUjVtTnZjbm5D?=
 =?utf-8?B?Zi83TXJac1cvODdNdENOMFlPeC9vZXNhWW1VY0pDQnd3eitZM0N3SXlabGM3?=
 =?utf-8?Q?cwO6Av62bHm0Pj2MesEeTgTaYSRITSmyMVIKO14?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckZRWWFuc0U1ekk3alNSWjdVaWxyWkhieVdzTDBHaVR4d3dCQSs3aVoxU3pP?=
 =?utf-8?B?a1RXR3VyZGdrYm0rR3FQTEJJMmFZQnB0OXVaMy9WbjlXQ2FrbWtZaGtLYmtF?=
 =?utf-8?B?b3BWbW84S2lQWFcvZHdtSVNRRlIrc0lUcm9yaGtVQVZKa2ZFWTNRNXhweU5X?=
 =?utf-8?B?VVI4SllOMHdGTjJ0MXpvSjFBMU4wbXhVbkZjNGdTNlozeTRtNWgzKzV6Wm53?=
 =?utf-8?B?V3J6Rjh3YTdsaHZkYzRJQkgyUEkvdmc0ODdXc1paM2c1anZrQUJiTGJQTUFj?=
 =?utf-8?B?K0ZBUXIyMzhhUW1YUTlmYWxOUkgwNGFKQTFaQ1o4dkdiR3hiZUNDcjNpUGEz?=
 =?utf-8?B?UUNUZkNERzMweTVybk9lZC84MXZHbW9HbzZVcUdLR3NaZHRXQ1o0Y3pKNFZ2?=
 =?utf-8?B?a1pVdjhPZEtGWjFLWnVrdTREMGdYaDVpTXdPZkRrTEJWa1JSZmhvWWIyeVhx?=
 =?utf-8?B?NjhwUTZNMmZUYUJnYXV4eWlUNkxLWFZPVTl1VDYzOUdCM0Z3SGNFdjl0RW5G?=
 =?utf-8?B?REFNWjNGcEgvUHNHMDZHSGlrdDliS2N0MFdCdXpHdjY4N0ZmYXVoeXI2SmdW?=
 =?utf-8?B?YnFaa0UrS3hCWURPZm9MMGNsVHFjUzEyWDlieSs2T1JjRERRSVRGdnM4eEVk?=
 =?utf-8?B?cytqWU52WE4zOFkrQW14VTAxWXNZNVgxMzRQd3JXeVdMV1Q0ZG5UTUJEYkhu?=
 =?utf-8?B?Y2YrUHBJUUFEVk9lNlNYZk9qR1AzNFQ0ZGFnalRRcjZya24yUDBNekpjNDg2?=
 =?utf-8?B?WGl4M3ljMTR0b3ByOVB2SENwV3RFZSsxbWFteksvTjByTzIxRVVpZkQ2TVc4?=
 =?utf-8?B?TFRUZngrNUNyaTJBVlFncWxtNWI1aTVtekNNR2Y4K2VtNEF1amYyMUdjbzlj?=
 =?utf-8?B?NVV3RnhlTERjZUZqR1NodUtEbTJNT2dkK001NDkwbC94SGVKZ0hNTm1Xcnhx?=
 =?utf-8?B?c2RKZm9TK1BrY2xYdHllajhhVEoxQ0sxc3VRRWh4NGJTVWdTR1phMTk1TDZK?=
 =?utf-8?B?TGZnaWFyK2JNS3NYSGE5eThhbmdwUnR1UG1jT1c4dGlENVZ1QzlnQ2JwbEE5?=
 =?utf-8?B?QitCQUVLeVpQbGhsVTQwaXRhUUEvTDNiSFY0S0dMSStZRnprQnJhdVUwVC9z?=
 =?utf-8?B?NjVkUmE5OUp0OVh6ajBxYWs3citPOGMrOGx0MXpyTjVpK1hEbGJNQ29EbGV3?=
 =?utf-8?B?a1paMlBJRDRNTVo4RUdSTm5XTlY2dCtGdnkzakgwQ1czK0FXbTNIanRIVkY0?=
 =?utf-8?B?SXFZTmIwU1Y4Rytka0Z1eklsaGpmdmF1UWtwYVBkaXVIKzhCbUxZTEkwb2xP?=
 =?utf-8?B?MVVKWDFZWm1qdHFpQ29zbEpuYWdhQnFSRERMT2xmcTBGUFZjaFJmcGlIbFlR?=
 =?utf-8?B?bG03NHBJZUI0Rm5kNVZyaXRzVlpKUjJNdzhoWWFXM051eWRlcXZYMjNWYnN1?=
 =?utf-8?B?RDh6dWdUdTR1WWxBNUg1cU5GWWpwS3FkS2krVmhMOWhycituNjlqUCtPYU9B?=
 =?utf-8?B?UWgzQU1hRFBWakdaRTRVRmd4OS9ZaTZYMWNycVBqZ3drUjJxaXB4SjEvWUdI?=
 =?utf-8?B?SVBwcTlqS2EyVWRweHp5Q3JQbFN1cHNCMWNnUFhJSDEzOWVHTmxJQjlCVE90?=
 =?utf-8?B?TFI1UzIvbng3NmgrM054R25mU0YrSW1Mb2lkWUthRG1UUjlyQ2V5S3ZtU21E?=
 =?utf-8?B?UGNoUStxNzJ1T2J2aEhrTGNsSloxRmNNNnVLNGxLZjVQeFEyMkh2VlpyZDht?=
 =?utf-8?B?VGMyNEJ2ZEpiQkRRRjN0aFVoUkNkYnhXTmNIaUY1UCtlZWlOeVF3WGtweHRx?=
 =?utf-8?B?ekhVWU5qeDJJbjlpQnhMTk50OE9lOUF0cjFGVXExaDA5QXZueEZHZk1oeUsv?=
 =?utf-8?B?VzVLdHFqTU1yQ2dqdk1QTFpndmg0RU5IdE4xVE5PZlcyT1daMGczT29vaUZk?=
 =?utf-8?B?N2JvY1g3YjY5dDdNMnh5aHU4L2hYYmhGNjFBRXpuWmtJV3Z2T0dkWWV5aVR5?=
 =?utf-8?B?MUlHRzkwZTBtQkF2NGZIbE9aZlZhN3YvcGdzd1NOZkNvcWJkQU51WVE1UFVR?=
 =?utf-8?B?SlhIMkJZWTVEa1FobHFpNXN3VklmQ2h4SE5mcVhGWmcxajZ0S2t4disyV1pF?=
 =?utf-8?Q?DvR5Sjn13i3GPggbkcWIVcgdD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b6b61b-4da0-46bd-e934-08dcf76f6a3d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 16:41:47.8187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pAWIu0xfoHO7kSa1IzD72gENQFvq9Rhdwakl+ooRl9wCrlF298vYFAW+wFy0AQrJp8UzTk9TTBLIaUlNDn7+CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9062
Received-SPF: softfail client-ip=2a01:111:f403:2409::614;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
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


On 28/10/2024 17:45, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, Oct 28, 2024 at 09:43:16AM +0200, Avihai Horon wrote:
>> On 25/10/2024 0:30, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> We have two outside users of this API, so it's exported.
>>>
>>> Is it really necessary?  Does it matter whether it must be
>>> ACTIVE/POSTCOPY_ACTIVE/DEVICE?  I guess no.
>> Actually for VFIO it does matter, because we don't want VFIO to do DPT
>> log_sync in SETUP stage when DPT might not have been started yet.
>> See commit ff180c6bd7a8 ("vfio/migration: Skip log_sync during migration
>> SETUP state").
> This seems to be a known issue for migration in general, rather than VFIO
> specific.  Hyman has a patch for it, not yet reviewed..
>
> https://lore.kernel.org/r/cover.1729648695.git.yong.huang@smartx.com
>
> That corresponds to your comment here:
>
>      Redundant -- all RAM is marked dirty in migration SETUP state and is
>      transferred only after migration is set to ACTIVE state, so doing
>      log_sync during migration SETUP is pointless.
>
> So I wonder whether it's only VFIO that should skip it, or log_sync()
> simply shouldn't be called at all during SETUP, because of its redundancy.

Not sure why this sync was there in the first place, but if its only 
purpose was to sync dirty pages then yes, I guess it be dropped.

>
> The other thing you mentioned here:
>
>      Can fail -- there is a time window, between setting migration state to
>      SETUP and starting dirty tracking by RAM save_live_setup handler, during
>      which dirty tracking is still not started. Any VFIO log_sync call that
>      is issued during this time window will fail. For example, this error can
>      be triggered by migrating a VM when a GUI is active, which constantly
>      calls log_sync.
>
> This is VFIO specific.  Why this can fail even if global tracking is
> started already?

It can fail if global tracking is *not* started yet.
As mentioned in the commit message, there is a time window where 
migration is in SETUP state but global tracking is not started yet.

Thanks.

> I didn't yet get why a GUI being active in guest could
> affect log_sync() from working.. after vfio_listener_log_global_start()
> properly setup everything.
>
> Thanks,
>
>> Thanks.
>>
>>> The external user is trying to detect whether migration is running or not,
>>> as simple as that.
>>>
>>> To make the migration_is*() APIs even shorter, let's use
>>> migration_is_running() for outside worlds.
>>>
>>> Internally there're actually three places that literally needs
>>> migration_is_active() rather than running().  Keep that an internal helper.
>>>
>>> After this patch, we finally only export one helper that allows external
>>> world to try detect migration status, which is migration_is_running().
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>    include/migration/misc.h | 1 -
>>>    migration/migration.h    | 1 +
>>>    hw/vfio/common.c         | 4 ++--
>>>    system/dirtylimit.c      | 3 +--
>>>    4 files changed, 4 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>>> index ad1e25826a..c0e23fdac9 100644
>>> --- a/include/migration/misc.h
>>> +++ b/include/migration/misc.h
>>> @@ -53,7 +53,6 @@ void dump_vmstate_json_to_file(FILE *out_fp);
>>>    void migration_object_init(void);
>>>    void migration_shutdown(void);
>>>
>>> -bool migration_is_active(void);
>>>    bool migration_is_running(void);
>>>    bool migration_thread_is_self(void);
>>>
>>> diff --git a/migration/migration.h b/migration/migration.h
>>> index 0956e9274b..9fa26ab06a 100644
>>> --- a/migration/migration.h
>>> +++ b/migration/migration.h
>>> @@ -492,6 +492,7 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
>>>
>>>    int migrate_init(MigrationState *s, Error **errp);
>>>    bool migration_is_blocked(Error **errp);
>>> +bool migration_is_active(void);
>>>    /* True if outgoing migration has entered postcopy phase */
>>>    bool migration_in_postcopy(void);
>>>    bool migration_postcopy_is_alive(MigrationStatus state);
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index cc72282c71..7eb99ebd4d 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -174,7 +174,7 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
>>>    {
>>>        VFIODevice *vbasedev;
>>>
>>> -    if (!migration_is_active()) {
>>> +    if (!migration_is_running()) {
>>>            return false;
>>>        }
>>>
>>> @@ -219,7 +219,7 @@ vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer)
>>>    {
>>>        VFIODevice *vbasedev;
>>>
>>> -    if (!migration_is_active()) {
>>> +    if (!migration_is_running()) {
>>>            return false;
>>>        }
>>>
>>> diff --git a/system/dirtylimit.c b/system/dirtylimit.c
>>> index ab20da34bb..d7a855c603 100644
>>> --- a/system/dirtylimit.c
>>> +++ b/system/dirtylimit.c
>>> @@ -80,8 +80,7 @@ static void vcpu_dirty_rate_stat_collect(void)
>>>        int i = 0;
>>>        int64_t period = DIRTYLIMIT_CALC_TIME_MS;
>>>
>>> -    if (migrate_dirty_limit() &&
>>> -        migration_is_active()) {
>>> +    if (migrate_dirty_limit() && migration_is_running()) {
>>>            period = migrate_vcpu_dirty_limit_period();
>>>        }
>>>
>>> --
>>> 2.45.0
>>>
> --
> Peter Xu
>

