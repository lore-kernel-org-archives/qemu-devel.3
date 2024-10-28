Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D248CD339A4
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 17:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5TQJ-0006el-C8; Mon, 28 Oct 2024 13:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t5TQ4-0006ao-U0
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 13:20:47 -0400
Received: from mail-bn8nam04on20607.outbound.protection.outlook.com
 ([2a01:111:f403:2408::607]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t5TQ2-0005V5-EZ
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 13:20:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvxOq4m4bIdSGScZXRT6C730Gvqa+ivS4SWMt3nQQbQQ5qyp2jnuIkcinG/YZC1r/Jual3gQrA3YXzFBFbjvqDWLIj+CYlEMBq3Yq4L196QlPrMzqJ3ZdyLis0hpWDeAX++Bccu1zydU/auXswZzJfNntjZBOr+KrAUqb1lImhoPE8fxOCWX11he/TwuB4ksdLDIjrgF5idyNHkFWP78/7VuBgNaMfZ8MpLZdRtsnxCmzmXS8COi4BFZKDaoGnjiNwcnLnz78I9ppfD5rV1Y6zDaV/5vAsXaErv/FRdM3d43Ip4uAvtr9cueMLc0//vLRm5YvcgUcXxZupqWE+ZeNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4hdDwP+bYnHqcr3fvXfn8nXBvJz3Ibcv9KkR6ew8xA=;
 b=b5VuWO1IOq8opH/CZfXYxnnB1w5ggoZPQ22jcrTv3+Z59H9nm2SjVWTSa6j1UBE9l+aHN/+L0sqMCdFWvLjpCxk/vsKwZTY+nWgwDR/5Ma0Pk7B3d8VTpkbyu1EelAr3OG5tL0JlJYjNkT0ZX2gKEAxD4fR6XeoDNCOht1dTz0vUM5+RqYsnjKZ7KnfZ5w49JGaw4564hmTv2Qq/uEg9lVlVnDiuSqHvOHprSjSnk7EVmwZJP/BSbvJeIOFvXuSH84L86fDAOlfGk11l5QQsFSE4etxh6s6u0JsJ/cibka04cknESsPD54BWzx2rSMpQcFY0zXPeuAhe/z/YNs/hXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4hdDwP+bYnHqcr3fvXfn8nXBvJz3Ibcv9KkR6ew8xA=;
 b=BA582RNyxQ6bd7uXxOtHo2T1TSGDXCOoaYAACF1vY7rP3e2cCUhraKJmMrxho6rgi8TwhE48fzwmtocjKVD7Z0K/rkF/BaaPp4K59TWxeH7CvOw0Jif0ybFZC3N9mzOz3aiJzO1cLMZ5xSubZSWbjIYQzcZNFdmmP21R6effUnqFKaPo5xlsCgfpyfbHwsM1xDd+C2fRbLm2kQdwNBSn1iLz/ZyvHFLgc0DgtXtTSXvGP4SnyqBPCx3YN2CatzsW0VxQ0/yoqCJhO+zHCJSuaPbav1sNTeRFaBKSVaIbAgWofrP5Eim9DLq8V0hjMbOAuy5ef7+Zi0G5UUOrbd6q7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.27; Mon, 28 Oct 2024 17:20:32 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 17:20:32 +0000
Message-ID: <a96a8f31-ef8d-48b5-999c-8ca8a917f3c1@nvidia.com>
Date: Mon, 28 Oct 2024 19:20:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] migration: Unexport migration_is_active()
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20241024213056.1395400-1-peterx@redhat.com>
 <20241024213056.1395400-8-peterx@redhat.com>
 <78729b4b-3747-4408-8146-12d49e70fed1@nvidia.com> <Zx-xpZzYG_1KuCQu@x1n>
 <4c6bb701-dd6d-4cca-be80-156c19f2a088@nvidia.com> <Zx_C0hrRZK34qc7I@x1n>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <Zx_C0hrRZK34qc7I@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0654.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::12) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DM4PR12MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: 959797ce-d77b-4bd1-75d9-08dcf774d390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0xmcENwMnhqV3ZsQnV1U21XelhlYU44STVhMTJWU01mTWd1V25HZmtXVWlu?=
 =?utf-8?B?blFEQmNZbkRGWjNYRHdzczNMejA3bmJOaWZxc3M1YU5PSmJVeDl0QitMc0tX?=
 =?utf-8?B?OGQ4c2FycWxISFBLMTR1NjVzYXdNT1ZFb0M3elFVYWVHOWxLczF1RXlOY2ZW?=
 =?utf-8?B?dGV6Wjd5UW1acnlHSHhaSEJNcnkxUXRWMFF6NUd3RzJndFE0Y2hNNnlXcjdE?=
 =?utf-8?B?WjJHdEdWUTJMRHNEMkxrUFdqUUhTdU9LT0g2bHNJbUlEVXdLM0VGZ1Rwd0Rq?=
 =?utf-8?B?YkxHcmVJWGhNeXlBSTkvWDIvbVpnYVVTMHV0SnNwdlRaeTVrUjkvVEVpbWt1?=
 =?utf-8?B?R3lGSnVvc3pyaFpDaGRybUgwYmtLSEh5eDN2YkdmU1pPakU1OHprb2U0VlZT?=
 =?utf-8?B?bTRVTHpXSXN1cjlQQkhWZVBvc283U2tFTWY0bkcxTlIxMUZEL3BZNHJUU291?=
 =?utf-8?B?KzZaT2RXdDRuSjY5YkNENXZLN3VvMEJFL21zVnluYk1YYkk2MlAwZUdqT0dm?=
 =?utf-8?B?bXhhTG9pbHM4Z2pNem9MakhxTWZJOWZMNmFSZWZGTjF3MU95RUE5VXF5WHht?=
 =?utf-8?B?T1h0ZFRKeEdzSVk4WnpJT2g2a0MvODBRUWNWS0MyRjFLZStkbVBtTlJmSGU3?=
 =?utf-8?B?dG5FU2M3SGRVZ0MxRVFKbDRHSmNrSG1IaVRLd1RwVjlnOTNvYktGUXh2TjJs?=
 =?utf-8?B?VGdkNXdKY3RleHJZemRENytBS1RvQlZ1ekt4QkFtT0xBR2dBMGY1OEl3YnRX?=
 =?utf-8?B?RnFEY1lkWkxTTG9kRGJuRC8xR3U3Q1MxUnB0cklOQ3R2RjBUbExNMkNNVjBw?=
 =?utf-8?B?WVQ5eExwK0JaeVVHU2VBYTkrVGRPdHVJVTQxVUt0U21Da1dPNEVFMnNsZWhF?=
 =?utf-8?B?eUdGam9Yd20vMWZFdGRmMW5BWXVqam9RaWdad2lGNzB0VXhWV0VkNEV0Z3Vp?=
 =?utf-8?B?UXlaVzVvckhoQzNIT1hZd09BeG91ck10a1hHMXkwKy83NE9tNklsZDJPTHY4?=
 =?utf-8?B?eERSeGdIeHkxcXFNV3dxdG1qWTMycnBId05vMC95bGV4N3laUUl4MTB5blZN?=
 =?utf-8?B?YlNsaUp4MUxGeGJBa0FiRnBHeS9hNW51WDVwT3dSd2h5V3k5ODZ0S2FaZXd3?=
 =?utf-8?B?elh3ZnFsaGNxVnhHYnJNZzgwVnZHQmtJcVlCUkQ5UUMzaXRML2xHREdTRjk4?=
 =?utf-8?B?ZlhkNisvRlpuVkxhMXpCaHBtSG5ybFh1WXRWVEE5cUx3YlpHMjhPRUJNUlNr?=
 =?utf-8?B?OEFhM01LY255aENFSlRIQTl6UEFSK3hISnBXT1hoZnF3YmVFcTF0QjJkekh3?=
 =?utf-8?B?VnRwRDg2cjJ0ME5SalBEanVjK0JlU2NJN0l3RTBRbGdqV0Z5Ym1Nb0g4dTNj?=
 =?utf-8?B?MitjTTlYNXdIRktGYU4ydnp6YldQNDQ5ZjlBdm9oamJRR0JxeVBSL2JIUWVt?=
 =?utf-8?B?K2NhL1lzYVVWZExMUUV5dExaZE9WVzhoaWVEdXR2YWpqQWx4RVNnWUVjL2pz?=
 =?utf-8?B?Y2FQZXJZZmZacy95cVdoWkR0WW9IWnBYVms3cEkxRkt6V2hWMHlpUkV5Tmt4?=
 =?utf-8?B?U1pPc0VJQlpGSGdmaThabExxczV5YTUyQ1NJd0VWdm4xbHhYR2VmWGFnbTJG?=
 =?utf-8?B?MHBsYU5FTHlCYWsydjB6blVMSHJydDBwZ25Ca1hhUUVUV0lKSDJoeXlKazFG?=
 =?utf-8?B?S3hUNWg2WjJjbWFBaDF5bm9xQU9yRWh3MUVobFBvMHd0U3hxM0xjRGYrSzRB?=
 =?utf-8?Q?TMGYQiAmkx9RlXTeO1WeRIo95/WYNXzzhvapiY5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzZlWFM2cVRvd09selJuaHBvYkxuSW5TTE51Y0NGYzAvdXEybFpzRGNVU1Ba?=
 =?utf-8?B?aTZRNm83TFloVHBPVEF1SFRvVlVSOUg4STY0OGkrNlR3V1dOKzA3WnUyUmRB?=
 =?utf-8?B?cDdjTm9VYldza3FOQi84NW51YlNpdXhkY1phemhsaGNHSkN6Sk5RTmZpU1V0?=
 =?utf-8?B?VDMwSlVCTy8rZWlNa1BKMGRQNnd6UjBKeDlpZjdNeHdHNWVHNXVJVzl0Z0ht?=
 =?utf-8?B?bnBTMXhJNHFkVmovaUFGRGtNR2wxdFpKWDhRaGFVc2JSOTRLNFdROXA5VXdh?=
 =?utf-8?B?Y0pHVDZKeERzQTBFWCtGK0p1bnVCZUNkQ0FUdGhtRzF2emhkc21kVGtDNmVm?=
 =?utf-8?B?UXRMRXNSWEtyTXJPS0R3amlkeERFdGpUUEFwMzRmWGxMQ3E4RWt2T2lpNkIr?=
 =?utf-8?B?SVBReWVIWUFFejBqWmsrSUhWbHQwbnExdFJnc2NPWEFRa3hqeTdMblczU01y?=
 =?utf-8?B?ZDJaR0g3S2dJeWNVcHorOVNRMFVsbm9lQ1ZHWFArSWd3bUEvR0lRWmRYV3NQ?=
 =?utf-8?B?NkVmQ1ZDdnhDRGM5NytsV0RtckgvMjQwdGVsa2l3WWUrQWVBelI4ZTY3N0pX?=
 =?utf-8?B?aVl2NWdEZWZDbjhGNkhoY3JiaUJCWTVxOW9wZ0RJaU56Y3gyMTEwSnlKTGlh?=
 =?utf-8?B?S2tsc2ZYMTJMaFZJQjVCamxHb3FldjJUZk5HYlVYZkRzcW5zUnd4VUs2YWhn?=
 =?utf-8?B?UFlHQWZtUlpxSll6OTJmR1BpTjdNTFd1bjRWWWNvTldOL2ovQjgrL1ZLa3Zs?=
 =?utf-8?B?dkV3T29EODRocHIzWnUvVXJOMWtOczg5RDhtVGZLUUhSQ2EyNkk5Z0ZYM1J0?=
 =?utf-8?B?clRmYVRReWwwWjVLZ25Gdk1nV3djbG1oaC9NNnpmdU9LUDQ3Syt0UzkrZUYr?=
 =?utf-8?B?SnNwbXB0cG5CSFkwd1gwbmVPYnk5T1l4clBoMlI3dzJidTYrM0c2ZzNmTjJD?=
 =?utf-8?B?SW1CaUJ5M3htVzNFMUZ2dzdLM3B6N0pUckNDQXJlRGRmT2h4UlBIQ21WYnNV?=
 =?utf-8?B?QlZieGM4N1dVdHBMYjVvNXRGMlROZFNHcktyNUpDZXlYOVJBK3hUeGlleElk?=
 =?utf-8?B?cWxXMUVYdy9EVUJLUjVrOFFFL0VBRnFLTUsvVjR5bnhaL3JNVldWeHBxcTJI?=
 =?utf-8?B?Umt1YUVsc3NFMnRWTEFnZW1VSDVndDJGSXNjUDIzMkZUWjNDbGNzc2xkd1Jv?=
 =?utf-8?B?OGFCRkFzdEp1VnRNaUhjT3hCcGxQa1p5MkYzSXQwbTFPbmxrV3hlQzVaTW44?=
 =?utf-8?B?a2tNVWYwMFB1L0hMZDNycGlIL0k4bzZ2cEs4a1ZaSFhIUkZCd2M5TVM3RVlO?=
 =?utf-8?B?OGg4Q0RVV3E3b2prMjhaR3ZTa05LMXBPZy9wTFhna2lJclBuaXFtaE9aNkNy?=
 =?utf-8?B?c3lrQ0RibkE4MmphT0lpblZEU2xLRUpWQTlOVUVHU1FRdUxmSkhiaENJQ2Y4?=
 =?utf-8?B?bi9HaUFEemU4VDlNbTRwNzJBT1JHNTh4SThYS1NlOG9RTW9jbzJVSU5ZbG1D?=
 =?utf-8?B?cTFlN2NrM2hmN3V1bjU3YTdPN1dNd29wV2cwb1FmMmdNMVZZeTlRbHNDS2NL?=
 =?utf-8?B?SVpkYVhOV082WTg5Y2d0eUVxWGNkbUlYdXJqNHVWU3JFRWpIYXp5UTZrRXl5?=
 =?utf-8?B?NTErb0lqMzkvaTNGQ2ExcHd2cjQ2VmloS3lwTnVUV2ljQnhqNStzQzByaEQr?=
 =?utf-8?B?VERMdCt2L2ZZc3lVc0dLTGtZNmQ5eExaTkR1UU1DVU1VMktYZGVTT0g5eTJN?=
 =?utf-8?B?ZWY2SkR6ZkRqTVZDV0I1TzF1UDNFY2NOeWZRUjREakZxYyttcEJWTlZ2MUtL?=
 =?utf-8?B?V3B6dXFnRjhHYTdxYjU4QkFIZGI0MGk2K2lURkF5TWUxVVlvdXp5SzZnb3p1?=
 =?utf-8?B?RDBsbjNZdzlkWXdSbzFmUWorWU9HTml5YzVBTGNWWUphbDI5UG5HekZTRkV0?=
 =?utf-8?B?dURaUzMvdUk0dXBwTjFzZW9lYUxKZGRqQjVmSFR3Rm1uNC9aTVRkUWcveHlE?=
 =?utf-8?B?TllpZ3R0UDlVUGZaTHdNMEpyZHdzL21HTndjWk1ZZzYzTWZ6ZE9WTTJGOUFa?=
 =?utf-8?B?QmpyYVV2Qnp4R29XeUFzL1pxTVBucTFnTFU1Nk5kMGlQRG4zOHZvL1lSajJ3?=
 =?utf-8?Q?6gc7rj82xXmLxadFoeZco92Te?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 959797ce-d77b-4bd1-75d9-08dcf774d390
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 17:20:32.0218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PB+bA1WnNsoSIFanJoB3H/dDb26SHKmaMeYIy/tloYAwNfuk3CAUlsmnoVU7j3899SRD+QkJT1HAC67aPo2a9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6351
Received-SPF: softfail client-ip=2a01:111:f403:2408::607;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
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


On 28/10/2024 18:58, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, Oct 28, 2024 at 06:41:42PM +0200, Avihai Horon wrote:
>> On 28/10/2024 17:45, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Mon, Oct 28, 2024 at 09:43:16AM +0200, Avihai Horon wrote:
>>>> On 25/10/2024 0:30, Peter Xu wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> We have two outside users of this API, so it's exported.
>>>>>
>>>>> Is it really necessary?  Does it matter whether it must be
>>>>> ACTIVE/POSTCOPY_ACTIVE/DEVICE?  I guess no.
>>>> Actually for VFIO it does matter, because we don't want VFIO to do DPT
>>>> log_sync in SETUP stage when DPT might not have been started yet.
>>>> See commit ff180c6bd7a8 ("vfio/migration: Skip log_sync during migration
>>>> SETUP state").
>>> This seems to be a known issue for migration in general, rather than VFIO
>>> specific.  Hyman has a patch for it, not yet reviewed..
>>>
>>> https://lore.kernel.org/r/cover.1729648695.git.yong.huang@smartx.com
>>>
>>> That corresponds to your comment here:
>>>
>>>       Redundant -- all RAM is marked dirty in migration SETUP state and is
>>>       transferred only after migration is set to ACTIVE state, so doing
>>>       log_sync during migration SETUP is pointless.
>>>
>>> So I wonder whether it's only VFIO that should skip it, or log_sync()
>>> simply shouldn't be called at all during SETUP, because of its redundancy.
>> Not sure why this sync was there in the first place, but if its only purpose
>> was to sync dirty pages then yes, I guess it be dropped.
>>
>>> The other thing you mentioned here:
>>>
>>>       Can fail -- there is a time window, between setting migration state to
>>>       SETUP and starting dirty tracking by RAM save_live_setup handler, during
>>>       which dirty tracking is still not started. Any VFIO log_sync call that
>>>       is issued during this time window will fail. For example, this error can
>>>       be triggered by migrating a VM when a GUI is active, which constantly
>>>       calls log_sync.
>>>
>>> This is VFIO specific.  Why this can fail even if global tracking is
>>> started already?
>> It can fail if global tracking is *not* started yet.
>> As mentioned in the commit message, there is a time window where migration
>> is in SETUP state but global tracking is not started yet.
> Hmm, I'm totally confused now..
>
> The only thing that can kickoff the sync during SETUP, AFAICT, is:
>
>              ret = memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, errp);
>              if (!ret) {
>                  goto out_unlock;
>              }
>              migration_bitmap_sync_precopy(false);   <------------- here
>
> I need to confess this may not be the right place to invoke it in ram.c (I
> think we probably should move it out at some point.. into generic migration
> code).  However I don't yet see why log_start() is not called first in your
> case before log_sync().
>
> Could you elaborate?

Indeed, in the above code log_start is called before log_sync.

I was referring to the case where some other code path triggers log_sync.
E.g., if you open a VNC to the guest then it constantly calls log_sync 
to refresh the graphics. In that case, one of these log_syncs can happen 
between "migration status is set to SETUP" and "global tracking is started".

Thanks.

>> Thanks.
>>
>>> I didn't yet get why a GUI being active in guest could
>>> affect log_sync() from working.. after vfio_listener_log_global_start()
>>> properly setup everything.
>>>
>>> Thanks,
>>>
>>>> Thanks.
>>>>
>>>>> The external user is trying to detect whether migration is running or not,
>>>>> as simple as that.
>>>>>
>>>>> To make the migration_is*() APIs even shorter, let's use
>>>>> migration_is_running() for outside worlds.
>>>>>
>>>>> Internally there're actually three places that literally needs
>>>>> migration_is_active() rather than running().  Keep that an internal helper.
>>>>>
>>>>> After this patch, we finally only export one helper that allows external
>>>>> world to try detect migration status, which is migration_is_running().
>>>>>
>>>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>>>> ---
>>>>>     include/migration/misc.h | 1 -
>>>>>     migration/migration.h    | 1 +
>>>>>     hw/vfio/common.c         | 4 ++--
>>>>>     system/dirtylimit.c      | 3 +--
>>>>>     4 files changed, 4 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>>>>> index ad1e25826a..c0e23fdac9 100644
>>>>> --- a/include/migration/misc.h
>>>>> +++ b/include/migration/misc.h
>>>>> @@ -53,7 +53,6 @@ void dump_vmstate_json_to_file(FILE *out_fp);
>>>>>     void migration_object_init(void);
>>>>>     void migration_shutdown(void);
>>>>>
>>>>> -bool migration_is_active(void);
>>>>>     bool migration_is_running(void);
>>>>>     bool migration_thread_is_self(void);
>>>>>
>>>>> diff --git a/migration/migration.h b/migration/migration.h
>>>>> index 0956e9274b..9fa26ab06a 100644
>>>>> --- a/migration/migration.h
>>>>> +++ b/migration/migration.h
>>>>> @@ -492,6 +492,7 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
>>>>>
>>>>>     int migrate_init(MigrationState *s, Error **errp);
>>>>>     bool migration_is_blocked(Error **errp);
>>>>> +bool migration_is_active(void);
>>>>>     /* True if outgoing migration has entered postcopy phase */
>>>>>     bool migration_in_postcopy(void);
>>>>>     bool migration_postcopy_is_alive(MigrationStatus state);
>>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>>>> index cc72282c71..7eb99ebd4d 100644
>>>>> --- a/hw/vfio/common.c
>>>>> +++ b/hw/vfio/common.c
>>>>> @@ -174,7 +174,7 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
>>>>>     {
>>>>>         VFIODevice *vbasedev;
>>>>>
>>>>> -    if (!migration_is_active()) {
>>>>> +    if (!migration_is_running()) {
>>>>>             return false;
>>>>>         }
>>>>>
>>>>> @@ -219,7 +219,7 @@ vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer)
>>>>>     {
>>>>>         VFIODevice *vbasedev;
>>>>>
>>>>> -    if (!migration_is_active()) {
>>>>> +    if (!migration_is_running()) {
>>>>>             return false;
>>>>>         }
>>>>>
>>>>> diff --git a/system/dirtylimit.c b/system/dirtylimit.c
>>>>> index ab20da34bb..d7a855c603 100644
>>>>> --- a/system/dirtylimit.c
>>>>> +++ b/system/dirtylimit.c
>>>>> @@ -80,8 +80,7 @@ static void vcpu_dirty_rate_stat_collect(void)
>>>>>         int i = 0;
>>>>>         int64_t period = DIRTYLIMIT_CALC_TIME_MS;
>>>>>
>>>>> -    if (migrate_dirty_limit() &&
>>>>> -        migration_is_active()) {
>>>>> +    if (migrate_dirty_limit() && migration_is_running()) {
>>>>>             period = migrate_vcpu_dirty_limit_period();
>>>>>         }
>>>>>
>>>>> --
>>>>> 2.45.0
>>>>>
>>> --
>>> Peter Xu
>>>
> --
> Peter Xu
>

