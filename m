Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F347C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 09:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKabU-0007py-Uv; Fri, 21 Jun 2024 05:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1sKabS-0007nP-Ls; Fri, 21 Jun 2024 05:30:42 -0400
Received: from mail-co1nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2416::601]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1sKabP-00077M-5t; Fri, 21 Jun 2024 05:30:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4ryjYTUtFwK0Qo/psi8cjw6rAU3zMWPoTYVMERIMp+musoWkWv2csUpZyhZYXeFvTSIQqbz4pb4J37XMom5/YylIlHVXW0cJ52LOPjrBaJaHH2kktTzdt3LqfvVo/7+HjzdhhMRcX6s/1sfTNTJ9sMuYsnXTT94kQIgQH+1B5eBaWvpM9W/kZI+GoA67lDYgWAzglskV3sEdu2zYNL9ce91S+pd3RH+Lx3vWO+MSvUg6BsJTT5PV3cuRPCjCN4wkV989EzEnJ+mjSVPJNiy3BSqdJUYvy+zE0Ow8aV53r5hr10kU3bTKimp+jRLyZV3xcYzUD/JcAl/LYt36R9NaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9py8LPtVUBJyzvJrqQ4NP/lxAdyK8sVMIQpTgRKGVg=;
 b=HjrTpvAgk1KlOBNe9D8do+WmL353HLH9LmwaRM8u4zrVB5ZoiXwDAfhu1TANRt55SOyNolQWevr/GQfsxalH9Pmo7i9RtfBS+5EKqliKe/IaR3dF8AEa9HiWHbGYw17Dj84xnVljyPbfxVuq9Tkv+uW86vfIx0YOrtVgzPktyu1TYzLNVe0DbEIn874TG2ob+1m8aFDjke6qrQmgRpKnHZHJXlHhQlOltdZ0R2H2YiBtadrNkc749kEI3D82QuOR/HmGykanyRmKn7ReRF7Nanl2S2mDR1vS6Ew/fgWyg2EiePLLITy/iN/StbQEFT6EsYQ1PSGwVeTCcHI8bqv19w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9py8LPtVUBJyzvJrqQ4NP/lxAdyK8sVMIQpTgRKGVg=;
 b=TmfffTwy3ucZFX5/QvEiIpoOqk52q5+nTLlOBu7KlMpdxNuEVH0RsflPNqa14/f5xWn75X7Nypl3e7e7YvvZZSiA8Ty6RXZzGgjvxnqbO/D0dkjgrg/PdyvRIjxTq/0kB+ylEJYJZVQpjI05gDuOZdb+WySXHAi1yotkALtqxfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by BL1PR12MB5780.namprd12.prod.outlook.com (2603:10b6:208:393::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 09:30:34 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%4]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 09:30:33 +0000
Date: Fri, 21 Jun 2024 11:30:25 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 "'Edgar E . Iglesias'" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: Re: [PATCH v3 3/3] docs/system/arm: Add a doc for zynq board
Message-ID: <ZnVIMUBsKf+Zg4iJ@xse-figlesia-l2.amd.com>
References: <20240620104139.217908-1-sai.pavan.boddu@amd.com>
 <20240620104139.217908-4-sai.pavan.boddu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240620104139.217908-4-sai.pavan.boddu@amd.com>
X-ClientProxiedBy: FR4P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::11) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|BL1PR12MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f64db1-f0f8-417c-f6b0-08dc91d4ccb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlNlaXhOZDBNdk5hdm1YRzVEb1FIc0pkTytuV2N4cFZ5RXJkQW5GTkRYdXZB?=
 =?utf-8?B?Z01pUHV3WDJyWHFaY0FZbE12TG8vRUluN0FoN2psRUE2ZVVDaUprNGZnbWVB?=
 =?utf-8?B?T0xmRHJxYWQ3ME9TUSsyMWNFZS9rQk5ac0hpUGw5WGdNTjRjN01oWWQ2VnBR?=
 =?utf-8?B?cUt0d3JzNmw4QjIzY3hyR2xhVDJOUVRKbWMzTGFCT09ORFpBSnR2Vk85YU5U?=
 =?utf-8?B?eDZoUklSVTRDbmZHajN6WmJEZ0JhdndOWmFwYUNjRy9ScjRaSUs3Z0xKVFBm?=
 =?utf-8?B?VW9BUlJ4UkdOMU9DcGNrTFhwMm1qUHdOcGVUUVVTTHh0ZGlLcmNQRnZ1aTJl?=
 =?utf-8?B?VVc4akFHL3orWjJDaG9RYzNVQmc0d2ZDWnhyMjRJV2cvY295RjFVdzBYUjUx?=
 =?utf-8?B?Qm5WSzROYjJPNGgvbVBrRURld1Z2cExrNk9lNytqVTdiQWhlYTU1WlE1UFhC?=
 =?utf-8?B?R0VYbjBTc2d0SzdjTStucmRTUFRwbmZsS3lOK204a1pGelcvRGFXNnIxM01q?=
 =?utf-8?B?RzNBb0VJL0JFanhhcklEMDY3TU9qaDIwWjdVUXpqTlgrTldTT0VvVUJHT2FW?=
 =?utf-8?B?QS81THd4N2dqeWZCVmYwVlMrWGxYcExIWWdKcUZkK1E3Sk5FdXBwNTFSaG94?=
 =?utf-8?B?d0p0clBsMmMzbGJCeFdzamh5MXVHOE5VS0h4WlZXU2tvWFdrN2pucjZ5Nmsr?=
 =?utf-8?B?UmN1ZEpBSEE5OFVsVlhLQy96SXVtVXNoRExOOHA1ZmwwTFNYU1M4b1dpMW8x?=
 =?utf-8?B?bVREeGU1bGJTSThpMlM4NFZkSk40VWNtMXRUNnY2Uzk0QlRVeGQwNWI0bmFi?=
 =?utf-8?B?NU5CVmU3NVgwZ2R2UlUrZXBHZmM5Wjl1YmZCUVkweW0wYjY5YVVaN0ZScVdj?=
 =?utf-8?B?M2x5amU0WU9lN01mbGpwbjVQeklZcWFZN1lwM0V5S2lhOWRhY20yQmxQTEdW?=
 =?utf-8?B?TWJqUzZRTDE1eGNlSnJEd2VrWWx4bTIxcTVBQWNjVkN0Qyt4NzdyQVBCYjkw?=
 =?utf-8?B?MXVLdHI5QVBRK1huQi9RN21BSEVJYUNBSnRLS01LZ3JRTWdnelo5blRRNDRI?=
 =?utf-8?B?Uy8yMUlBRy9wRzhKU0Jub1hLOXh6emhBOVNRS0x1c1dMSnNYcWVLQVNIQnR2?=
 =?utf-8?B?WCs5aVdZMzZ5ckZJOWpHdzJKSy93MU02N2xSN0QraGFhVzdtaHVXZnI2cnFB?=
 =?utf-8?B?WlFtTHgzRTQ4b1JCMTRJZHFSN0VGVFlmUTlHNFpieGlLR3pSaldMalYzZDZt?=
 =?utf-8?B?c1pZRmVQL0FiUG1uK3I1NS9JNklHd21IOFN5S0w0Y0lSZGVMNHJGZk54eHdC?=
 =?utf-8?B?TE0rL25XNEl2YlA4RVdkT3lTMWZ2RXF2TkJTcGZQeFlBV2YzbHBuZktsRm5i?=
 =?utf-8?B?VmhxeVBXSWJER3NrK0kyR0RDS2hZYVRQUzVMamI4UVVwK2RvMEFDWDA4SkJL?=
 =?utf-8?B?TzNUM1RRa2FkM1k1Q0t4WmV5Y1lYYzRLQUgzT0JpQTFOMWhuZ2R5UklVS0N0?=
 =?utf-8?B?cHlrSzBEV0h2NmxDL3llZlROOVVMaEM4U3cwUUFkbE9NUmlNb3JPd3ppdnRP?=
 =?utf-8?B?K3Ird1hxOFhqNDFiZkE0RG0rTWpEZlBLaXdiVnVodWFOdlpzREhQdVFsRmFw?=
 =?utf-8?B?bGxwNzRWU1pCVFNCMUV3OW9YVTQyWmJZSmRkUVpybVgwMmwyZTByaVVLNDRF?=
 =?utf-8?Q?ZPcFSYV+EhervhXAIn53?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blVuVE5HOGdGS3ZCVTV3bFY5ZWlFMUpCZlZWRDk4enNhMHBzTkE1RjMvZ21C?=
 =?utf-8?B?RU4rWTZGTi9jaUhwRDUrUFljSW5EQkZzQnI2MU44NWFCZitEbUQ5WnROYXha?=
 =?utf-8?B?Qy9NOW8wd3BwRGcyUnB2cFdjaDBTQ3oxZkg5a2xLbGJhRFV2RXlxbkxRVC9h?=
 =?utf-8?B?bmIwb2VBY0dCNUZORUZYZDJCSkUwU1UvVnJKNHlNMkNrWXY0N3JQck1tNGQw?=
 =?utf-8?B?MUMxT2dJRE5VVHUvOGJsb0U2cm82cHFRVkl5dG5WRmJnQ3dERS8zRG5YWFE1?=
 =?utf-8?B?b0dya2Z2KzBqaFh1YjhaOXY0d0Urb0h3WE91d2RRNTN2Ri9HNVRQUEl2Tlla?=
 =?utf-8?B?UG90Q09Va3FrWnU5VXhhQ3gzWi9EMUMrMldreHpEb2dEKzFDb21MZ1BEYnRY?=
 =?utf-8?B?T1JwK2hiUTdwWW9Nb3FqeTVtWSt1UHlOSVpRak5Zb3hwbU1VRnJCSHBadjN3?=
 =?utf-8?B?MjhPVGJENUZzSkpBZ0s1VVFlU3lRLzhiR3owM3hYaVVHOVYxQ3pIeStPRXAr?=
 =?utf-8?B?RUNMampQanRwYVVrUGtXUzF6TTZqTldoQ29hK1g3cUVxN1JMTkdmVlVDQ05k?=
 =?utf-8?B?VmlvLzNYWklQTE9LakdzdmRqZWZRTGxpclVmL3JEMkxwUzhLTC9VT0ZLaDh1?=
 =?utf-8?B?c3krbHZUUGN1Ly8yOG5yWGNDQmMxV1pqNmVNeWpOYmxXbjRjb24vaFJ4UVN0?=
 =?utf-8?B?Z1p4VDE1ZXhwTVNHZkY0cnE5QU9uNlJ0Q2grVzR2YS96TnRXK1o0SmZiakcr?=
 =?utf-8?B?c0VRNE5FK1pGa0Z6VEc5b0RMajhxZTc4Z01lVXErOHFHckRoY1lwbzhJR1RX?=
 =?utf-8?B?dzdpUGltbDcxRTB2ckFxdTRuVXZwT05FQi9wV2VrdHJOUHZ2bDYranRUdGpx?=
 =?utf-8?B?d1RoZjE2QXdIVEcwNzhQcGJ2N2ZHWEN4MjQ3eDJDY3BqOVNOQUcvcnRmZHUr?=
 =?utf-8?B?Y1NQSTBEUUxKdDJUUUZ5bnBqOVczd3ZRejNhUVBpU0RlZ1Z0WUlrcDdheUpw?=
 =?utf-8?B?Vm4vbnI5ZUVJR29acjY4NEh1WDR2MXVrOU84N0phYjcxQXpVRlArckloS0pG?=
 =?utf-8?B?QThiNWp6THRlM09wSWRlUHl2SXZvb3V3T0ZBZGFnNVVqalh1Y3VuQ3JianND?=
 =?utf-8?B?emtwaXo1TEF1M1ZJWE8rWEd3OVlyRVUxNFdwZHZqR1NoblJsWG5BeVZGUElM?=
 =?utf-8?B?SXF6RmJoNzJEVkR5NUhWWDF1QjUxVENiNG1FcFhsb05nVkVaQWZPci9aZTZ6?=
 =?utf-8?B?VXhXVTRoTHoyV3UvRFAwNTZXUU9ueHNqbUJadll2c2pnOEtZWmdOelhuU29y?=
 =?utf-8?B?Mi9iYXM1eGI3blg2RHBQbW42c0hsR3Mvcm9STjVyQ3VFZTAwck1jc25BcXRN?=
 =?utf-8?B?SFpRSW5CMm5PdkpCeGV1WEFVVkpaV0YwaXo2WXlCcVFXY3pNT1grOTluZUl0?=
 =?utf-8?B?Y1hFN2U1UWdJOFdSS3Z2ZDNENlIvRi9rVzBNZ3lSSGdpRm9ROTJtNEl3K0tP?=
 =?utf-8?B?dFNsc1hCOHMvK0dsTlN2a0Q5MWUzaVI3Z2FCVVVOQ1NYYWcydXhxZUdldk55?=
 =?utf-8?B?MWMzRHRabjBMT05tb3Z5aXp4dmxpOW5IQXlIVHNPTFRTb1RRek0wRm5yQng1?=
 =?utf-8?B?U1ZkNGoxMHY4MXJpOWxmLzNGYVNBMGdTOU1RMHloVkYxL2kyTHhPNGh4RVR5?=
 =?utf-8?B?MVJzUlltb1pFTU5XVzRNbk9PZFloUFhXVlAybUhrZEVtUmFCWWQzSzR1Y0Y5?=
 =?utf-8?B?NFVEeTFzN2V5aVJZZms3OU9NYittaEtCb0tZVThWeVg1QVBxc1N3UUtRSTBz?=
 =?utf-8?B?cVRpOTl0U1R4SnlQbmx5a2lJNXQ3YUlyMVFpUmdOTmNGOXBXV0prMVhFaFlZ?=
 =?utf-8?B?dGxhYk8rd2x4cXF4Wm9nV28vVGdGdGpDTnNqSnJIVi9QVjh1UmJZL0pEUHJW?=
 =?utf-8?B?S2ExaEFNbStuRnQ0WmEvcDlBVkhRbmloWUxjTzRzUXJMbHVhTmtPbTAxazFi?=
 =?utf-8?B?dERFczU0MFJtRnNqdEJVMWlCbVBLSFpCTzZHazlvZGNEd1pVUmx0cU5FRG9E?=
 =?utf-8?B?bGUzZ0d1RERKUFIrYmp1OVVkWVk5SzFBNVczaE1Yb0hWTXpkQ25PWWNIS0xn?=
 =?utf-8?Q?wjFWrZ2NAkc/wTF3ZS2+v4SS3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f64db1-f0f8-417c-f6b0-08dc91d4ccb3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 09:30:33.5724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZi42XZiMUpjjncfTssef2CFdrc47vs1NohSgzVD4GVakczr+jGYn9ft5LWHd55LxkgBjt2I9HWaZqdDgBKr1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5780
Received-SPF: permerror client-ip=2a01:111:f403:2416::601;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

On Thu, Jun 20, 2024 at 04:11:39PM +0530, Sai Pavan Boddu wrote:
> Added the supported device list and an example command.
> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>  MAINTAINERS                   |  1 +
>  docs/system/arm/xlnx-zynq.rst | 47 +++++++++++++++++++++++++++++++++++
>  docs/system/target-arm.rst    |  1 +
>  3 files changed, 49 insertions(+)
>  create mode 100644 docs/system/arm/xlnx-zynq.rst
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 951556224a1..2f06febc676 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1033,6 +1033,7 @@ F: hw/adc/zynq-xadc.c
>  F: include/hw/misc/zynq_slcr.h
>  F: include/hw/adc/zynq-xadc.h
>  X: hw/ssi/xilinx_*
> +F: docs/system/arm/xlnx-zynq.rst
>  
>  Xilinx ZynqMP and Versal
>  M: Alistair Francis <alistair@alistair23.me>
> diff --git a/docs/system/arm/xlnx-zynq.rst b/docs/system/arm/xlnx-zynq.rst
> new file mode 100644
> index 00000000000..ade18a3fe13
> --- /dev/null
> +++ b/docs/system/arm/xlnx-zynq.rst
> @@ -0,0 +1,47 @@
> +Xilinx Zynq board (``xilinx-zynq-a9``)
> +======================================
> +The Zynq 7000 family is based on the AMD SoC architecture. These products
> +integrate a feature-rich dual or single-core Arm Cortex-A9 MPCore based
> +processing system (PS) and AMD programmable logic (PL) in a single device.
> +
> +More details here:
> +https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/Zynq-7000-SoC-Technical-Reference-Manual
> +
> +QEMU xilinx-zynq-a9 board supports following devices:
> +    - A9 MPCORE
> +        - cortex-a9
> +        - GIC v1
> +        - Generic timer
> +        - wdt
> +    - OCM 256KB
> +    - SMC SRAM@0xe2000000 64MB
> +    - Zynq SLCR
> +    - SPI x2
> +    - QSPI
> +    - UART
> +    - TTC x2
> +    - Gigabit Ethernet Controller x2
> +    - SD Controller x2
> +    - XADC
> +    - Arm PrimeCell DMA Controller
> +    - DDR Memory
> +    - USB 2.0 x2
> +
> +Running
> +"""""""
> +Direct Linux boot of a generic ARM upstream Linux kernel:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-aarch64 -M xilinx-zynq-a9 \
> +        -dtb zynq-zc702.dtb  -serial null -serial mon:stdio \
> +        -display none  -m 1024 \
> +        -initrd rootfs.cpio.gz -kernel zImage
> +
> +For configuring the boot-mode provide the following on the command line:
> +
> +.. code-block:: bash
> +
> +   -machine boot-mode=qspi
> +
> +Supported values are jtag, sd, qspi, nor.
> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index 870d30e3502..7b992722846 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -109,6 +109,7 @@ undocumented; you can get a complete list by running
>     arm/virt
>     arm/xenpvh
>     arm/xlnx-versal-virt
> +   arm/xlnx-zynq
>  
>  Emulated CPU architecture support
>  =================================
> -- 
> 2.34.1
> 

