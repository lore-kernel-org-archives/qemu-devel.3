Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205BEC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 10:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1kWr-0006wD-W5; Tue, 30 Apr 2024 06:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkale@nvidia.com>) id 1s1kWc-0006tp-2c
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 06:15:58 -0400
Received: from mail-bn8nam12on2042.outbound.protection.outlook.com
 ([40.107.237.42] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkale@nvidia.com>) id 1s1kWO-00038r-Cs
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 06:15:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aziSqbJ5u5VIscPF6zleokg10t3qn5QKjyOmsTZaN9V5nkTbkmpM5GuzsNzVVHhMtm4+6MkZujg6aGF03Dlwno1OZ7MAoEtg7m0SjCS8QZrPjcbsRzUF/2ZzChMxnvTyJc0P/WZj8ujCyjWwmb94MK6wu8pR6WronyOyWDp+VP0Nf8u9Cb4z8u8eVUvCVUZmw4SpJew5Dqt/UJUoyW/tFfMNFYax5TE52QMiQkib2NxHCXlFDeTcQGO23DesVsYoVCefHbGeH3X7CyYQmRojlVt/rxl4dZX79eGob5yG9pAgWkgh+XKQC9b0bt3vKBA7ZnNadmVCR1f3/v3YIjrA+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsK51tdkXzqBt09IuWGRRxODCc+PL6ZTbcrDIJHlWZA=;
 b=KABbSNIAdGXn8WRcAVVlggPJG5gyt2aZLcbTWNOcEY6q8x0StCfXxWz6ijsUCOwGeLsmPd/CqEgFGx6e90qvaeQtrT22VMuqiiGYTg30UtlUeVR36vES3huuOWg1jAQBFKAcwKhc4eJ6oziThLA7wY8xAN03BPlraP34qVW7sJK7FPBvKsirqye22tyUYPztWRoR0SV8aVUZQ9dKAvwvG3RArLRdeKKd/GWc2W1AvQGKyAZqiEBjdDRa+UGET9fT+YkT98u1zoBlN3qwNCVYtXiXA4Cb6b0MxP9cr+nnWBJYVG/uYYblGzWvLfeJnZ+olhN9upigy8z30ZQM3q0bYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsK51tdkXzqBt09IuWGRRxODCc+PL6ZTbcrDIJHlWZA=;
 b=XZUO5+Z80j2jM0xHkpI0MwhOuhJJ2CP948MmaR0ppOEDlx078HQxIhcauqtsG34IbF8Sm064WWhQPOOdxPKVb6jFSCjvbXiIM73DVNPz+It55lC43l0I/XNFjAGgXgNman1oesLP/WKrmXE2ZzGtlkhfM0pgsHy2tg5X/VypToMuD1QPgleUUWyJp1jaVql9tzaNuBOHxRQGn8urE8gSB9GxVCSFTjpQR2vcK0FV4HFpfXX9uxhKrplaBLGeHtCNMijRWKUHuJMbHVaXVJnWHzg0OdGME8EnPL9Bno38N4weyGOBl9e9n6I1xjCjcYYXxmARSxyApGnZWfxZMd/+Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SJ0PR12MB8090.namprd12.prod.outlook.com (2603:10b6:a03:4ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 10:10:31 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::74b2:8571:4594:c34a]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::74b2:8571:4594:c34a%5]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 10:10:31 +0000
Message-ID: <b5acc7fc-4f17-4017-bee0-d1651767eea2@nvidia.com>
Date: Tue, 30 Apr 2024 15:40:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vfio/pci: migration: Skip config space check for
 Vendor Specific Information in VSC during restore/load
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, marcel.apfelbaum@gmail.com, avihaih@nvidia.com,
 acurrid@nvidia.com, cjia@nvidia.com, zhiw@nvidia.com, targupta@nvidia.com,
 kvm@vger.kernel.org
References: <20240322064210.1520394-1-vkale@nvidia.com>
 <20240327113915.19f6256c.alex.williamson@redhat.com>
 <20240327161108-mutt-send-email-mst@kernel.org>
 <20240327145235.47338c2b.alex.williamson@redhat.com>
 <10a42156-067e-4dc1-8467-b840595b38fa@redhat.com>
 <d8cc4405-fe9c-4b47-be76-708a72d4b1a1@redhat.com>
Content-Language: en-US
X-Nvconfidentiality: public
From: Vinayak Kale <vkale@nvidia.com>
In-Reply-To: <d8cc4405-fe9c-4b47-be76-708a72d4b1a1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::15) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SJ0PR12MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d9c10c7-df1f-42e6-a855-08dc68fdc419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDRvTGhvWDIwT3hXbmoydlpXbTVXakxBZmJtdkpyL2poQWdCa2hiOVV0OXE5?=
 =?utf-8?B?VVZ5eUtnQzlkQlZsMjVQVTlESUhBeFArd3o0UWp3Q20vWVdPWmRKVlF6STIv?=
 =?utf-8?B?OWlUdDg5Q2hpdzBLNGI2cEd0RVJZU3hMY1ljTnRRZWhHZTNlNm5XWTRVakkw?=
 =?utf-8?B?aDc2cjc5bHFoYUttL1VacFh3Y3J3M0t0MkRhSlQ3eUU0THg0OWtRcm9NNFFX?=
 =?utf-8?B?b25WRnhtS3dJUHRoVUhGTDBPRG9rMitmeXJHbDlMRDNKRkVMOE0xbmtpeU9t?=
 =?utf-8?B?TjhqR1pWQmNTSnJ2bGozOGk0NHlIZ3JUaW5CblRzMXRKdmRHcCtiS1FqTVZN?=
 =?utf-8?B?SlhqaDMxUDgzcjhiM1FiWkxyaFZLaHR0YVVSdU10eGRZZEx4ejJtTUtIdUVo?=
 =?utf-8?B?bmNuejUyKzYvOFRaSlRRb1k0eHZNaHNYRHlmeFNpMUw4VGRwZm8zejZEVGdG?=
 =?utf-8?B?QldVSnYvbFFNVlJlR1FxUk9VUEhaOGpKaHFiZkc3SzMwVFJJK3dwZnhIZVlS?=
 =?utf-8?B?Z2RvNU11VlFKRTE1OWNoMTJyQTIvOW9CVm5tYXd0RDVwVm1NTkM4SHRyKzV4?=
 =?utf-8?B?b0ZTb1JIM0h1K2hsUC9vM3FZNEJrZXFSTXl4aDRLdjgzV0x2WEFnNXoycDVq?=
 =?utf-8?B?TlMyRnhudkRPR1phZU5md21tZW9uNFk0WCtpMmFkcTh6Qjlnbysreis4MzB2?=
 =?utf-8?B?SjRwYjhZYjdJS2RWRk5xaDg2RS9xaEpRbmwxK1VRZU91LzdZcTR0dlZjaTl4?=
 =?utf-8?B?bWY2eU96OGNvUlc4SEdpQXg0dk9RN0xDY1VtRCt4M1k2K2o1SWl2cDFLcFhm?=
 =?utf-8?B?d1pGNU5iR2FXMUxyUDBSWVltem40Uk1KYkpvWVJreXRrNmV3NGpHMFpoWjJt?=
 =?utf-8?B?M1MxU01TQ3ZwMTdFaXRNRC81M2szam1SdmN4emZoTXVFcnR6WFJZeTZxWkdW?=
 =?utf-8?B?SzZqZ0g1VDlYdHp4endGU3ZqOUtqSlFjWFRTWmI2V0JvMEREWXJzeVczbXl1?=
 =?utf-8?B?aCtTc3N6bUwvV0w4NTUwWVFzcmdjWm9OQjF2VFdmbldKbUN6bDFCamE0UWVU?=
 =?utf-8?B?Z0ZSRXY3NXQ4bXhOR2w2S0FTcHdYTCtYSlpnTlFUZk1JSS9SVHRQWStkeHVq?=
 =?utf-8?B?V2dKMmF4TnJyQXlXVkZmUk00K1laQjFURGI3Q0xnUk5qMHUvMHBVRkdxQ0Fi?=
 =?utf-8?B?TE1aRUluU1FKbHZDT1IvTzgvRWJDYTlLVjZjWG5xR0s5bmZWZDM1N3VQWThM?=
 =?utf-8?B?K1BVTEFNL2toRmk1TEcwSHpGQkQ5MHNFU1lKMXVXS2w5WEw1cFBwWTV2TWRN?=
 =?utf-8?B?aXdGZHIxNDY2SldkTjdJZWUrcUVXTUc5c3N3a0dEdEZkbUdOLzZrVTJ6eGFS?=
 =?utf-8?B?d2djOXkzQkRIUkNXSncvT05TS09DREdnNU0renkxeFpVa3dhQUYvZytXbUVZ?=
 =?utf-8?B?OGlPNHcxMVpWWlczSzd5bUtBY05jeUhKNFNpbW9YMGdoYVFES2daMFR5QklG?=
 =?utf-8?B?UGp1YVJXR3lJM1BWdDdycm9XMGJzcHl1Y1pNc1U1eWRNSkdMd0JoZjVvZXAv?=
 =?utf-8?B?c1NtOTM4U0R6emdIVVdpOE9WYzVQdUNXbXV3dW9vMEhmazZVSXg0cnU4U3Bx?=
 =?utf-8?B?Nlo4RjBBVlVmcXFPOWVwTVRLaDg4cXpEK3A2MVk4SDR5bUc1d3R2T3AzaU5M?=
 =?utf-8?B?cmF4Y2pOWkNJR0dnZ1RSTnEwZ25lUUJTd0NldHdUUUdya3I3ZnJ5KzNnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5070.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzVsMDdrbkFCTkhsVDZqZFZYMEVCeHF1aWxiVll3dmF5WnBSamRLcDVvUWUx?=
 =?utf-8?B?K01qVE82VDg3dzVKWlRDNU9HeXM2UlNVVU9GamVvOE9GU1N3aG9DWnZybFFy?=
 =?utf-8?B?WFNWNHAxcjlWLzcxOXFNeUp2R2VRVitrS1lQL20vMzVWUFJSM0xCbGpQNEI1?=
 =?utf-8?B?VWFYd2tQTTIrdHMzVGdiSGpsa3A3aVFhVXZCVHBvL3ArTFZKWmpEdTJxL1Nr?=
 =?utf-8?B?OWlzZllnNVczTHpJOWkyNXNnRG03R2dOZ1cyVXpJK2pmay9ubTVqU2JkS3BU?=
 =?utf-8?B?ZExIWEtzY0JOS0M4NGFXVFNlem1zNXJnRysyTFFUUS9vYlR3SE1sUXZib2hp?=
 =?utf-8?B?K1VWa0ZSeWV6dWFBVXVEaVBqNTVzcE1wbEFCeWdmR3BkQ3NwWm1xaVIraHlo?=
 =?utf-8?B?Y2RwUHV6aCsyTWZRSDFDdDBwaVZrYzRTRXorY2RjSGIyRnpkaEFPakw5dk1O?=
 =?utf-8?B?UEZqbklSMlhGTjRFR3RUVW53UjlUbUlZbEN4UlNyTGRvT3V3d0YvQmZpWGhP?=
 =?utf-8?B?Z2tzT25jR3ZsY0ZvM1NvWllNa3hScE1PekhHMnlQTmJVZ0FKY2RVbTlBYjJW?=
 =?utf-8?B?eHBXbjRkSHU4K1VOMkFEeGZTdXJUeUZXc3ZOV1FZRzdpMVpWMldCejNWTFhQ?=
 =?utf-8?B?VllHK2VTL3p0czltY2R6ZTlFRGt1ZGlvOGlFd0VPeE9NQ1VGRDNwTzFBNTRM?=
 =?utf-8?B?aWRIemVsbHk4eUdXTGZYWWFwcEY0WXBZQ1FFQm83TWFyNlVoVEJ5bGxpczBz?=
 =?utf-8?B?SlBrOEpGT1IzWFJFM2lTU05pNHpLYUlrOVh2M29pTlV5QWVsOEh1V0RRVyt0?=
 =?utf-8?B?OERBVEZLT2c4L1NOaFdjYjZEZ1NvRE5lSTZCTkVmLzBGRVVRS3dBMHY0V1Vh?=
 =?utf-8?B?RjIxc2x1azgwUE5yY0xVdmkxbSt3d2NMc0VCZllmLzZnY09OamZCeWlOanIv?=
 =?utf-8?B?QTVJYklUdUhBUHNZKzRLcWlUM1BHOEtncWtIbEhwOUF6S1RWMWFJVlRpUjZa?=
 =?utf-8?B?YXlJOUFBL0tmZHBZbmc3OUU1YnR6U2FSSUl2WEZwbGxqQTdBQlArR2ZKM1Iw?=
 =?utf-8?B?cTlKQ3d0NXg0QVg2YzIwVWZ2dTZpZ3dDUTFVRWJuOGtwTFYyR3N0eUhLVXg1?=
 =?utf-8?B?eVg1NzF3UCtKQUdWb2lRQUJZcFlsOHdoZXlqN2Z1L2dFbm1qVWZLYXZMb1JD?=
 =?utf-8?B?UnAwbkIvZ05TSXFZUlp0UHRDRjNrUjVrYSt1V21vakRTVVN4ZUFINkZ5bjN0?=
 =?utf-8?B?VDhpTUFXTUFlNUVqNkJwL1ZUYndWcGFScjQ5Wm9rblQyNlNZT255cXRUTElI?=
 =?utf-8?B?V0xUZHE5UTNDcTA0QWZoZ21PMXJ6bC91L25Wdzl6Q3BnNE9EUWRPTk5LWUZl?=
 =?utf-8?B?VGp6WmdhRkpPL1RTT0Nxalc0NmhCMGhuS3BxdUZ3YWlkd3hpeG9aekpoRUZo?=
 =?utf-8?B?QU4vcFM1bDNVMENIRlZza2RQK1BXcndZWjJ1OEZvUnB2QkxCTjRHby9pK2dz?=
 =?utf-8?B?RVVVZGV4S3lmYllHLzUzTURRaXZjOTFTQlpIM3QwcFVmT3JZN3pvYzJJRmh3?=
 =?utf-8?B?OW9Na2dPVHV0d0tTSVJHS0I1SW4yWExYbFRvWWlzeWdwL3FQT0xIdEFnN0hD?=
 =?utf-8?B?N0Yxd3grOGpaUTJ6SkZ2NWNnaU5wWUxFTTd0NTJDR2V2K24xcGJaTVlOVlRi?=
 =?utf-8?B?bm5SazVZVTdhUHA5SFppaVJuSHl3c2Rtd09zWkttUVlDR0xNQkRlY2FRUHZG?=
 =?utf-8?B?SUQ5dy9lOEQ1emd6Vjg4aGxIY0I1S2c1NG5TQ1ZUTGJiNThrNHpCLzBTY0Ex?=
 =?utf-8?B?eXRrdDY3RFM5MlVXQi9sU3pCNnZrblkzUGpFc2o0elA5eDJFYzZzRlN1eWxp?=
 =?utf-8?B?NEFxeEY5MFNqcW9Kbm1tZ2Y3cFJuUVRDSEFqUk0ydFZYTTh2OVhLWmJWalpE?=
 =?utf-8?B?bGM1dXljZ2F4REFZa0ZTMG5ndUJXUXhsTWdnSWN3VzgyczNVRExjS1NTSFM0?=
 =?utf-8?B?WHBwdzI5UXdteUNRdGtPV2VlakpDN0lDMEJzRGx2VzdybW5ZTjlpZkZWdjhS?=
 =?utf-8?B?eWtkVnh3WWpJV2VGbFgzWmRONlBEdUl3REp0YUdxQUFOSitLVDRvRnNZell0?=
 =?utf-8?Q?2LJdaR5oAhpFgZNz6JEnhQvBZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9c10c7-df1f-42e6-a855-08dc68fdc419
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 10:10:30.9614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBC8LKgLcDDAGu/Ow7WGGJUaVTC32nFUtd3z51HsHl0p1BdJjCUprn5aRXWDW5ezu67iCqAO/oyh4U0RniZJ1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8090
Received-SPF: softfail client-ip=40.107.237.42; envelope-from=vkale@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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



On 29/04/24 6:10 pm, Cédric Le Goater wrote:
> 
> Hello Vinayak,
> 
> On 3/28/24 10:30, Cédric Le Goater wrote:
>> On 3/27/24 21:52, Alex Williamson wrote:
>>> On Wed, 27 Mar 2024 16:11:37 -0400
>>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>>
>>>> On Wed, Mar 27, 2024 at 11:39:15AM -0600, Alex Williamson wrote:
>>>>> On Fri, 22 Mar 2024 12:12:10 +0530
>>>>> Vinayak Kale <vkale@nvidia.com> wrote:
>>>>>> In case of migration, during restore operation, qemu checks config 
>>>>>> space of the
>>>>>> pci device with the config space in the migration stream captured 
>>>>>> during save
>>>>>> operation. In case of config space data mismatch, restore 
>>>>>> operation is failed.
>>>>>>
>>>>>> config space check is done in function get_pci_config_device(). By 
>>>>>> default VSC
>>>>>> (vendor-specific-capability) in config space is checked.
>>>>>>
>>>>>> Due to qemu's config space check for VSC, live migration is broken 
>>>>>> across NVIDIA
>>>>>> vGPU devices in situation where source and destination host driver 
>>>>>> is different.
>>>>>> In this situation, Vendor Specific Information in VSC varies on 
>>>>>> the destination
>>>>>> to ensure vGPU feature capabilities exposed to the guest driver 
>>>>>> are compatible
>>>>>> with destination host.
>>>>>>
>>>>>> If a vfio-pci device is migration capable and vfio-pci vendor 
>>>>>> driver is OK with
>>>>>> volatile Vendor Specific Info in VSC then qemu should exempt 
>>>>>> config space check
>>>>>> for Vendor Specific Info. It is vendor driver's responsibility to 
>>>>>> ensure that
>>>>>> VSC is consistent across migration. Here consistency could mean 
>>>>>> that VSC format
>>>>>> should be same on source and destination, however actual Vendor 
>>>>>> Specific Info
>>>>>> may not be byte-to-byte identical.
>>>>>>
>>>>>> This patch skips the check for Vendor Specific Information in VSC 
>>>>>> for VFIO-PCI
>>>>>> device by clearing pdev->cmask[] offsets. Config space check is 
>>>>>> still enforced
>>>>>> for 3 byte VSC header. If cmask[] is not set for an offset, then 
>>>>>> qemu skips
>>>>>> config space check for that offset.
>>>>>>
>>>>>> Signed-off-by: Vinayak Kale <vkale@nvidia.com>
>>>>>> ---
>>>>>> Version History
>>>>>> v2->v3:
>>>>>>      - Config space check skipped only for Vendor Specific Info in 
>>>>>> VSC, check is
>>>>>>        still enforced for 3 byte VSC header.
>>>>>>      - Updated commit description with live migration failure 
>>>>>> scenario.
>>>>>> v1->v2:
>>>>>>      - Limited scope of change to vfio-pci devices instead of all 
>>>>>> pci devices.
>>>>>>
>>>>>>   hw/vfio/pci.c | 24 ++++++++++++++++++++++++
>>>>>>   1 file changed, 24 insertions(+)
>>>>>
>>>>>
>>>>> Acked-by: Alex Williamson <alex.williamson@redhat.com>
>>>>
>>>>
>>>> A very reasonable way to do it.
>>>>
>>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>>>
>>>> Merge through the VFIO tree I presume?
>>>
>>> Yep, Cédric said he´d grab it for 9.1.  Thanks,
> 
> Could you please resend an update of this change adding a machine
> compatibility property for migration ?

Sure, I'll address this in V4.

