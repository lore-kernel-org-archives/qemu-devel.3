Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A45C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 10:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYNof-0003gx-Fx; Mon, 29 Jul 2024 06:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1sYNod-0003dr-Bv; Mon, 29 Jul 2024 06:41:19 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1sYNoa-0005gm-LN; Mon, 29 Jul 2024 06:41:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aoNjoSXRQoaC3To2tMDzXe+naVVjmtVIjK8QqG60VoUgLFzkEDggTImBcoIpwwfT2nGl/elTd9Hl+zGFwgRbh1xLMK9DqNo9bCrIxTuR6Ctjp3DyqVd4pG+6zUP0U9lEx8wBSt5YW8RBmn3ErOua3K7mswwZYOInofpVkmbc1Gv9wRjojcIZk5GPqo8KVJx33jtCPPeWlS47LXShREk90fOuz65kURe7ZIX6EKQYCWxZ79LbpRVd+FWiNm0qm9UygMu8NSbGoGmNKZ/yferpfnQJYBcjRkTuTIjotoWyODFmkqrjy3ii3Kany504vzj80uSxSyQzSnXkTLNC5yaZIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxY6lL4N7M1VsvtM0E0f+RSBzwoDf2Mz+OeHR5uX46o=;
 b=KQAvJRgZJqh57hotN6Vz3IwapMwNJhbgLo9Yaps5HKJOURGnuDAU2rogH/zFX7Q6u4/dWRITxJUuoIZj8ejVboL6H2B22z7cQUQy21B5+g9YIBewF814rLNSzGvU+fpuJyzNRC+6+4ieAmQa5/CEpF31JVyJgNuIJS3Yst/nXi8JCT3ZBUS0PZjlGMJUCDZ9yoUk/qmN+ZdHdy9l7waO7ogIORsLNvtBozn7Vd90YY/ogkS8xclEk2Q/udvsKf1QuKVSvA2Xyg1whnnqD1gDiky7gE0AtNm87MoGy/Lz+hh1+C5esCIO6ltfBZ9VVhQk0sg8/Igy6IYEnTJHmRMDIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxY6lL4N7M1VsvtM0E0f+RSBzwoDf2Mz+OeHR5uX46o=;
 b=maQqbEyo7KKvJX/g6Q64TScrevgb/7Pqh0me7R2jd7ZwOCP7GVQPuTA8LW6my7kPyVMSGOITX0tqDK1uNShsZWozkJOldd5c1jbT05nt0ppNNAJxXrHLstGoGvCxcYNbDqLCNz7P8uAIU/1jXGizKKpjZ+UcxgWtr3UT7v4PcnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 SJ0PR01MB6320.prod.exchangelabs.com (2603:10b6:a03:291::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.27; Mon, 29 Jul 2024 10:41:03 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%3]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 10:41:02 +0000
Message-ID: <b5e18524-df95-4cc3-a792-88df69ba7c36@os.amperecomputing.com>
Date: Mon, 29 Jul 2024 16:10:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm/kvm: add support for MTE
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, richard.henderson@linaro.org,
 darren@os.amperecomputing.com
References: <20240709060448.251881-1-gankulkarni@os.amperecomputing.com>
 <CAFEAcA_7BOXSLXJ=VV0pWDvrN=2dWrM3bRTG+31ivPjeVbWGKQ@mail.gmail.com>
 <0c171de4-a8ea-4859-b78c-272244267bb3@os.amperecomputing.com>
 <8734ns1p3y.fsf@draig.linaro.org>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <8734ns1p3y.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::31) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|SJ0PR01MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 339060e4-5f84-4673-454a-08dcafbaf154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bU14eUxFcGh5Zys3bytOU3hLSzRnaDdqNlo3Q2VlaHZDdUwvQXFoSHBWQVE5?=
 =?utf-8?B?RnBTNTNOY3lmMGR0TUwzOUhVYitvRGE0QlIyRVE2SDJLYkZ5LzV3RVA2bUh3?=
 =?utf-8?B?ZmFHN3hJMnFjSy9USGhRRjhIMzMvMzg3SGw0elo3RWpyb1c0Qlk4N2FOSDFN?=
 =?utf-8?B?TWc1ZWIxVzdJTCtabEx4eUN5U05rZmt4bjdJdXVad2w1SEtpY21lSEF4V2pY?=
 =?utf-8?B?cll5UEFKMkY0dEl6L3hDMFZyandJbVJyc00xcWhpcXBTSUdzcUI2U3Y0T1BI?=
 =?utf-8?B?Qk9DUTBlaE9nY25YQXRybVJtT0JFcmpsRlVkWHhKQUFjSld1ZllDTTdXYTJy?=
 =?utf-8?B?ZklZcmNIZzlRR3NwUTJCTngvZkVXRDgvL081T2RzZkx4Y1I2UkdZL2IwMW0z?=
 =?utf-8?B?OTZRY1pjQXNCbkpxeHQ5NU5qQ0JjTU1Qd0E4Y2Jhbm13TmJ2WG5CWnBTWFFl?=
 =?utf-8?B?blg0bWwyL296ZVVhUDYzR0hHOWI4MGd2Q0p6Sk1KT1pQVGlvSGEwdXA0Mi9k?=
 =?utf-8?B?dnR1WTFvdE8wZkJmMENUdWZGWkpwL0dPTThUMkFkZlVESDJYN2ROK1M2eEo2?=
 =?utf-8?B?K2xhRHd1aHJ3UTMwUVBsbmVDbDc2NXVvR3RnQkZOSVdhdGU4TkQ3THJ6N0U4?=
 =?utf-8?B?QWJyd2NmTEpnNldjWTFxbnc5NWNDeE9KWXZEL2tEWTlKMVg2SmdKek94RkNw?=
 =?utf-8?B?eEtCaHRTem8wTWZUU2lqWDJlVTk2OWRyZlE0Z2cyT2Q3QTlUVUJQSU1Wa3hS?=
 =?utf-8?B?UXhvb1RsTjlxRVA0YkR2TEdvSnBtNnFPR1l1b3VMSUhDQzExUk1pcmRMNDJz?=
 =?utf-8?B?OHRUUXNxL1dDUXlFaHFrUXdxR3ZtbzRzMDBaVGFRb3hITVRiRVBDOHcyaWh2?=
 =?utf-8?B?OFBSYVZoa2Fqc28zMkFMZkpNSHlwL1ZFbmdva2p5OXMwT1BFWWtZTlpsaEli?=
 =?utf-8?B?YW9HM2FVdFZZNXFOa2R0eHJOdjFxSWYvZUQ2eWo2TXFseVFDRGtUby9URmZB?=
 =?utf-8?B?eWlkQXpvZjgzeXE5WUlGeFptdnZMYktWTnczcC81d1NMbStkdTVkcUZ6RTY5?=
 =?utf-8?B?aVlWNWRtNHRhWW41MDRIYVp0Z3h3cVFTVUtTYVJIWkt4RXhVTTR3Um9HNzEx?=
 =?utf-8?B?bnhDSjlYbi9nNHpXQlpqenFZTC9SWmVZVE9LdUpVdE82dnRSWGpVTmF0T3Iv?=
 =?utf-8?B?ZDAzQWN6V2RaT3lJVmlFb1prZE9YSmdUc2FQUTNmcFJDSC9yOGt5bWkxdVdB?=
 =?utf-8?B?VDI0M0dGdHFHejdlck4wT0NTelJORktWTTk3Vk96NTQ5KzR0WVNQK3l4c1M1?=
 =?utf-8?B?Y1lTZTJrUCtzaStFejZWZ0cxQ1hLbXFTSXplL3UvcWtYYmlkb3FjcitjUFgx?=
 =?utf-8?B?NWJWbUpZbXpsWi91Tmx1NWxEWDZQOVF2a2ZtQ0dQTC9oTEF6QzFJb2M3amlx?=
 =?utf-8?B?M1hOcUVpRWk5TjhDZzZFZGlmL2tKTW9XbXd2U0JVMkdOMWUyOFZjejhHYlEw?=
 =?utf-8?B?TmNGSkltNFVrN0lUUC9vMEFETEJDZ1gxSmhHMG53ajFTQmRnU0tNdjF5a1g0?=
 =?utf-8?B?NjRlbU81dmtOSlczN09icGZmSjJncTlmaDg5ZnpIRitRTE9OdWdBVEtNSCtH?=
 =?utf-8?B?T0FWTFBDQjVRWWh6RzZzdzFQdm85NDIvQk5NT2ViTytpM2RrSDhHSWtrcUdJ?=
 =?utf-8?B?NEhlb1FsYzlSY1VtcW9tSWNPd1hGTlUrT0dkWG5DeGQ3aDRReFJITWU1ZGZ2?=
 =?utf-8?B?MlBwVDdXNUNQU3BCVlJ2U2kwL1FTMVRQOUdLUTEvVWs0TWlndmcwN04rTlFy?=
 =?utf-8?B?cURFQ2Y3aDAza3Y4eUxIZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR01MB8101.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlMrcXozVXFUS3RjVDhsTFdSb3VLRUNDOHJRWnAraGNmRG1aVnBoNWduYitE?=
 =?utf-8?B?SnlQTzdMR2VaRHNHTnhOblc0YlNGbWdsR1VZRVR6OWxCTFNtMTNteGYxMzRR?=
 =?utf-8?B?TzVyaHdSeXRQckpualhFZk1PdUNGSllWQisvbWxmTjQ5Uk1UMys4WXc5VVpr?=
 =?utf-8?B?VzFvcnFsaGowTVBUbHg5d0QxSUY0TytvcXVzdURVM004WkhYOFA3ZEY5bFVQ?=
 =?utf-8?B?UUpTTHdQTldjaElLN204SkxBM3JMb20yN2l0Yno2a0hlZUFqM2E3bStNUHFF?=
 =?utf-8?B?RFNpd2t1Sk1nRXVta3hjOVIybHdQbG4rRStuL2V4SGhZTGZTMCtSclRsMWFo?=
 =?utf-8?B?TDlicXJZOHFvMG9aNWhyUzcrTlRBbTI0eWxERFFZN3h5enJET2lieFJwMjBj?=
 =?utf-8?B?R3YyTjZqOVduUnY0MEpsVXc3UkZjTHB1RWdsT3gzd041bUZDaklaVDZuenZS?=
 =?utf-8?B?b3ZiZ056Z0FHdTFqS00xSWl0ZnhMWFpEWDd4QThzUmJhUFNHM2VwUUMreDRH?=
 =?utf-8?B?ZE9jQ3hDSERrV1QzKzdEdElNdEE0dmN6bVpMS0VVbGlpOWZ2WDg4d2ZRazNt?=
 =?utf-8?B?UFpHWkdyM29qQjFydzlqWEppcXo3K1JJd042N043eEhJelJFdjN0NWQ5K0dX?=
 =?utf-8?B?N3k1U0pHL3RUWUdtNlY5YTd6M1gzbWl4eEwzSU9rand2aU1nWnVVMkdGTDJO?=
 =?utf-8?B?Nlhrcis4NklhcmkyS2pCL2xsSGQ0K2NCVzMvVHlEZWgvLy9zUFFkL25zeURJ?=
 =?utf-8?B?SEdESUFhTnJub1J3Z2pla252ZUJSeWFvMXB4Z0xTWUFBQjZEZ2x5dkU1Y2Vk?=
 =?utf-8?B?cXg4cGFTT0FiQXFLVkw3UVRXamlPNS9MNlBkM3Fla2Ridm5CRUhGb0ZkTkJL?=
 =?utf-8?B?ajJiMkFyNVRvT0g5WXU3Q0NmUWtXV2RUd2wxYnJTTjkwOFFUVjNpUlRDeTlk?=
 =?utf-8?B?WUcyRnVJRGJzZk5GMVBWZVVpZkl1cC9tT3pSTmhFNkxncUptZEVQU2VMTUg1?=
 =?utf-8?B?MUZjWGNmZElNekFhVjVab1ZGbnJWazFkcXI5TnZsZnkxQzNaK2xSMVMvaUhI?=
 =?utf-8?B?N0JGVmhTTmltQTRoYkYvWU1MUzZuNzBpQS81ZWhWZTljREtUN1ZPbzJGdWRh?=
 =?utf-8?B?VkJhdzY4NTkweHVCN1dmb3NtWG1pSUg2R21nSlNTT0k2bk1MTUw4WEl3M1ZM?=
 =?utf-8?B?QlY3dm10MjQ4c1cxTUsweVZYdFFLTmh0TzN6VldMbTlMOENjZFFNOHRCblBp?=
 =?utf-8?B?Z2lKNDNRMWVjSkFMQ05JeVlJR0tZTXErSFRaUUdvUGt5WFdIUW1adFJORXRS?=
 =?utf-8?B?WXREb0IrWE9EVG1WWjVVRmt5aHFJZVNNdytsQjhDUTljalNSOFBqWkI5bW5L?=
 =?utf-8?B?MGRyMEFRUmRIZjZienBPWkRKb01iY3EyNi83TEpUT0xaVXpjc09NeFZiTlY2?=
 =?utf-8?B?R3dDZEFJdUdPOXBMbTY1Q1V0VnpLVUZad3o2bjZYelF2NGtuYnZySzhFRnhQ?=
 =?utf-8?B?R3pBdXBsZHNXcklzdUtHVjUxVERsR1dib3NZVVZacmtremgwNWVXeXR4U09a?=
 =?utf-8?B?VXRMYm9QOHpNQm5oMEUwTUFrMjRyZkcrbHd2YWxkWTZZR21KbzduM0pOd2dY?=
 =?utf-8?B?MTJDVW1QVllsOENLUzdYMGJyN0JaS2pjL2x3bE10TkI0V2wrbUNCOCtObytK?=
 =?utf-8?B?TVhzSTRqM0ZrT2tBc2kwQXNsOXZQeTZyalpUWmN2TTdmOFNvamprTytSNXhN?=
 =?utf-8?B?ck80Q2RicnR6eXBkbVNTb1AwSGdUOW53Tis4T3JOSWVQKzd6Qi9oOFZ3azlr?=
 =?utf-8?B?MXBRVlBKNTNOQ1JwVXVDNXRMVGh0OHV2TkNBNWE1RVZlS05pZEJXUFY5ekx2?=
 =?utf-8?B?OEJJNDZ6WkVlYnlsdXZBMDVyRk4xZzl5OW5NMjJBOWlMOUxINW5uRjEyS3N5?=
 =?utf-8?B?ckVLWFNhaWk2ODFIZ3Mrd0JoMlFPOTVnMVZSREpXM2JrVzh1UlJrSE8wdnB5?=
 =?utf-8?B?S0FGRU05VzNYNTZGbGpYd1dKc21jcG9NWXZZWFJQcUY0WlRkOVA2L1pEc2lt?=
 =?utf-8?B?NWdqdWxMWmZtdkM2YjFUTXhwV3FOWHRPV1czZnJGWUY3dTFpMFRKdEFQc0dp?=
 =?utf-8?B?ci9OY3gwZTZ2TDBhU0VOUi94K24xaDdnQUVyV0VhSVRMeW4xd1NadDJpY1ZH?=
 =?utf-8?Q?rJ6tzvFeQdbLTyQIVP7P4ng=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339060e4-5f84-4673-454a-08dcafbaf154
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 10:41:02.8330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhdHY2Aec9zvI34hdiJpPSn4aDQVlKUqXxgHoUGXrFeG2joWJNcu5Z1USS7CG51N1esk8muDxWvPLlX/Uz5u9gSKX/AylMuwiYZPBpwF/WWBBsn0lIkMHWdtoriIBfve
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6320
Received-SPF: pass client-ip=2a01:111:f403:c001::2;
 envelope-from=gankulkarni@os.amperecomputing.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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



On 29-07-2024 03:44 pm, Alex Bennée wrote:
> Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> writes:
> 
>> Hi Peter,
>>
>>
>> [Apologies for the delayed response]
>>
>> On 16-07-2024 09:15 pm, Peter Maydell wrote:
>>> On Tue, 9 Jul 2024 at 07:05, Ganapatrao Kulkarni
>>> <gankulkarni@os.amperecomputing.com> wrote:
>>>>
>>>> Extend the 'mte' property for the virt machine to cover KVM as
>>>> well. For KVM, we don't allocate tag memory, but instead enable
>>>> the capability.
>>>>
>>>> If MTE has been enabled, we need to disable migration, as we do not
>>>> yet have a way to migrate the tags as well. Therefore, MTE will stay
>>>> off with KVM unless requested explicitly.
>>>>
>>>> This patch is rework of commit b320e21c48ce64853904bea6631c0158cc2ef227
>>>> which broke TCG since it made the TCG -cpu max
>>>> report the presence of MTE to the guest even if the board hadn't
>>>> enabled MTE by wiring up the tag RAM. This meant that if the guest
>>>> then tried to use MTE QEMU would segfault accessing the
>>>> non-existent tag RAM.
>>>>
>>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>>>> ---
>>> In target/arm/cpu.c:arm_cpu_realizefn() there is this code:
>>>       if (cpu_isar_feature(aa64_mte, cpu)) {
>>>           /*
>>>            * The architectural range of GM blocksize is 2-6, however qemu
>>>            * doesn't support blocksize of 2 (see HELPER(ldgm)).
>>>            */
>>>           if (tcg_enabled()) {
>>>               assert(cpu->gm_blocksize >= 3 && cpu->gm_blocksize <= 6);
>>>           }
>>> #ifndef CONFIG_USER_ONLY
>>>           /*
>>>            * If we do not have tag-memory provided by the machine,
>>>            * reduce MTE support to instructions enabled at EL0.
>>>            * This matches Cortex-A710 BROADCASTMTE input being LOW.
>>>            */
>>>           if (cpu->tag_memory == NULL) {
>>>               cpu->isar.id_aa64pfr1 =
>>>                   FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 1);
>>>           }
>>> #endif
>>>       }
>>> With this patch, for KVM we will end up going through the
>>> "squash ID_AA64PFR1_EL1.MTE to 1" codepath, because KVM doesn't
>>> set cpu->tag_memory and this is still using that as its check.
>>>
>>
>> I looked at this function and it seems we are not entering this
>> function for KVM boot. I do see -DCONFIG_USER_ONLY added to make
>> files.
>>
>> Also Linux kernel wont detect/enable MTE until unless the
>> ID_AA64PFR1_EL1.MTE value is 2(b0010) and above.
>>
>>> More generally, how does the enabling of the MTE KVM cap
>>> interact with the ID_AA64PFR1_EL1 value that we read from
>>> the host in kvm_arm_get_host_cpu_features() ? We care that we
>>> have the right ID register values because we use ID field
>>> checks to determine whether the vcpu has a feature or not,
>>> even in the KVM case.
>>> Since Cornelia first wrote the patch this is based on, we've
>>> landed gdbstub support for MTE (so gdb can find out which
>>> addresses in the memory map have tags and read and write
>>> those tags). So I think the KVM MTE support now also needs to
>>> handle that. (See aarch64_cpu_register_gdb_commands() in
>>> target/arm/gdbstub64.c.)
>>
>> Ok sure, I will go through this file to add/update MTE part
> 
> So to be clear the current MTE gdbstub support is linux-user only.
> Gustavo has a series on the list that adds the system emulation part:
> 
>    Message-Id: <20240722160709.1677430-1-gustavo.romero@linaro.org>
>    Date: Mon, 22 Jul 2024 16:07:05 +0000
>    Subject: [PATCH 0/4] gdbstub: Add support for MTE in system mode
>    From: Gustavo Romero <gustavo.romero@linaro.org>
> 
> which of course is focused on TCG. But if the KVM guests sync to the same
> registers to cpregs I think most stuff should just work. However the
> current code uses the TCG only:
> 
>    allocation_tag_mem_probe
> 
> which I guess needs a KVM equivalent to query the tag memory?

Ok, thanks for the heads-up!.

Thanks,
Ganapat


