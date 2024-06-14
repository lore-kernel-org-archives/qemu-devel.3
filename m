Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D813BC27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 10:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI3lM-000651-71; Fri, 14 Jun 2024 06:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sI3lK-00064J-3j
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 06:02:26 -0400
Received: from mail-dm6nam10on20623.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::623]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sI3lG-0005Rp-Qu
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 06:02:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXsWF41q+FdiZ7S3oDC4JKxNhB/poCdyaDM41TbaWU7wjZK+H2IomMRRny9n0woQTvlDNxAuqMwTKc9TgybsNGKQgziiP3/f2KILeNyIQsZTTl43RNEpByGN+wsg1sOjjOoVuTJw81dYTynw28x0Mk5Zeop4l6BjIQGGOLQMHOoFQGd39dnyacKigvYDMXEWowni+t2BFfv9u1UOUuUsx1k1KbwIckP3htUHTgaU2Lq8ZcALhudS9Pc22k9Ybfze+FBJSWy3N/WpkvEd50VzBA8XVzSOPz8EJzv2GLEVAV3PEKxiwlrK23llww5Dsozau+t0HgkcSIszZ1pJObpzBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dt5xoodiLX8v4MoLTJaqTbpMSAwMJlmnOg32i5wAYWc=;
 b=lpHsmSqo0DpUxRqP8uPT/JoAPOKr3JpNcqZmfKzEBosRYNhURQu3y934v8LPRfE5bj5silqLsE4Xsl8GQzm5/cxNwHvwh9eWgk+U6VKFJoD+vu+dgSKBNrWy6Lffex6oMMaX5IQwGQx6DZN+JB79xKD/Xh9yuEDcC2YOdLAHMhBG5+1FjLuaTbzY6Vy2bViYYHV+XHnO4M7UZmVDzgqGdXqEwrUasL3mG3F96nxHzDVtbaug+wFefwspFARM3rzQvsaL6LbbWbUm4wH9/q/NfEAN68iqOkgMAQunA86dtgFC7P/5wLR4kcglTFYfc3FqzGRZs801ee22Q6+2YZ5yow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dt5xoodiLX8v4MoLTJaqTbpMSAwMJlmnOg32i5wAYWc=;
 b=uWXC9ygWJlX7LxPf3/w8WYSEaKJnxqZqW51wubWykYjku+YVpv856Ec4dQdd/pQvIR3kmw+5pmHfAung+mNCGOrRH7MiaEoMtXNCA6n/7ktTKYpHUAsM532WHi576XZ1U3Tub7dHfCW38YYlb7skF7ajEiX9VSOkyGXN0rKyoAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 by PH7PR12MB8827.namprd12.prod.outlook.com (2603:10b6:510:26b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Fri, 14 Jun
 2024 10:02:14 +0000
Received: from IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48]) by IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48%5]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 10:02:14 +0000
Message-ID: <88d905bf-908a-5c36-6a98-cc22c1db0f52@amd.com>
Date: Fri, 14 Jun 2024 12:02:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 27/31] hw/i386/sev: Use guest_memfd for legacy ROMs
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org
Cc: brijesh.singh@amd.com, dovmurik@linux.ibm.com, armbru@redhat.com,
 michael.roth@amd.com, pbonzini@redhat.com, thomas.lendacky@amd.com,
 isaku.yamahata@intel.com, berrange@redhat.com, kvm@vger.kernel.org,
 anisinha@redhat.com
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-28-pankaj.gupta@amd.com>
 <ce895ad3-7a84-4af1-8927-6e85f60ef4f6@intel.com>
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <ce895ad3-7a84-4af1-8927-6e85f60ef4f6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::13) To IA1PR12MB8189.namprd12.prod.outlook.com
 (2603:10b6:208:3f0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8189:EE_|PH7PR12MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a476c4e-0d70-436a-fec8-08dc8c5910e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230036|366012|376010|1800799020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWNTOTZRVFJZZXZNMkthY0dJSHRLZlJEdG9EbjZ1ZVBQTS8wVk1wcDg4UmFM?=
 =?utf-8?B?amFQVXRrWC8reng4aFpLbEdsUFhaN3RBdFl4YlVxRzlOSXp5NkxzR1QwbU5n?=
 =?utf-8?B?Ynd3V0hMN0JVbWxXNlVtTU9wSEFoakdWbWVYNnRTa1o5RmcvbWRTTlkyeFIy?=
 =?utf-8?B?RFZjcGwzc2lUNXhwM0FnUHU0THBaZytvaGV3LzZYUDdCNXJxTHNuR1R0ZS8v?=
 =?utf-8?B?MXdVSWFtckxCdDVhRTdxOXJCbnpwRVRaRXV0U3RvK0xuMUFGZFA0ek9YakMr?=
 =?utf-8?B?clZRcEwzeGJsclAxbW1OazJyTk5PcFdYREFVOTQ5YTkySTVYQjk4Wnh6TnNF?=
 =?utf-8?B?ZHlwUE9SNyttRnVsRnRhN0RIei91R1Q4cHVoNjJhNjRUV3Fwa1Zydms3ekFR?=
 =?utf-8?B?bXhEOUVrVzZid2NqQXpzR09MME0vZThJTW82T1QrUmpyRmhiMkhrSGlHMWFH?=
 =?utf-8?B?R0RHWVExZWhDcGI2KzJYdkJ3d2NnelpjcDUwT3NIbjBvd1g3TUdvVEtRdlhZ?=
 =?utf-8?B?M0k0T3h0Y2xTZHNmanNqZElyb2FvZjVvdmpjV0lCLytXWjVjVFJaMDI2ZlZS?=
 =?utf-8?B?bWVuVnRZZ3RjU0RabzRuNTFTN1ArQkwyUVZ0NTVTUVg2ZXp3TTYyTm5ZK2tz?=
 =?utf-8?B?cEcvckhYV2xNT2RFSXdPemRnYjdEelRTOFJoM01ZbEJzcmxBVk1ORTRqR3V6?=
 =?utf-8?B?TEtNc3RsYlk4T09CdHFOWk9hYklTdUo3d29Db0hIanhXc3hHOElNdGV4Ui9O?=
 =?utf-8?B?ZnFidks3TEVXVUphSGlTSnNYcC9QclF3bE9LZjNnaVZSS3Nhb0w4cXJTSzUr?=
 =?utf-8?B?OFF5cnhTMWJBTDFweTZVNEltdmJwUVl5VTBUUVRLTC9ZM0MrRWxFRUhxWjRy?=
 =?utf-8?B?WHFXMkhCcXpDMERRd3cvYmE4UnJQdGhNdkZXemFycVlOempPZmJOUm1RZm93?=
 =?utf-8?B?RWJkNHFlZGlyclB2WlJUci9QcmZKazhMQit2QVRFS0EzMUtRYVVkL0RML3or?=
 =?utf-8?B?OXhkbTVMK0VVVmh3UkxrbHcva3dSK25jZDJ3TXUxWEFkKzZPWEtRdm5vYjR6?=
 =?utf-8?B?OEpWdk5wY2k5b3F6UTZJeDdveHAycGx1RDg5ZXRHTk00bkFYOGlWNUVHMzhB?=
 =?utf-8?B?Y0c1cTJja05DWEZZSmJCM3VpSEQxL01oakp3MTI2dlN3VTJUN09rYm5hRDlK?=
 =?utf-8?B?bW9KalJxZnJUVmtZR0F0UTdnVVhnUUNXZXMwTjQwRXorMTVDcnRuVEFzcDlO?=
 =?utf-8?B?VlBsV29lNE4waEFkVy9yMXhUbnpMRUJqa3psNnpBc3FBUXc2MWVkRmszdm5p?=
 =?utf-8?B?TUFmVkcrbUNldk5CNGkrUVNWNGNTUi9pa2tsd1E2ZDVMa1FnOWIyVkJaamZ2?=
 =?utf-8?B?YkorbktIejRkNmlITEtUZ2pabXBSMFNETXZkR1djRFVLY2ExUU9zSEVwR284?=
 =?utf-8?B?U045bjlDa250bXljSnNlMHgyUkRrMC9mMVJVSFA1L0oyYmhOVkNBUXFod3lH?=
 =?utf-8?B?elVQVm04QnVXTCtVcXBRaVRZNVJQc21pcm1aUzV3UUJLNExZWFZCRWw2YXV6?=
 =?utf-8?B?UjJLQktlWjdpSjlNbUNDdXdyMDh0ank3M2l6YzR0U3JyNzZKNmJhcWJ1SWFZ?=
 =?utf-8?B?YjhCeDdXS2JNMjE3OVFpTU9ZOVVOUUI0V2FsUWdINEpXc2RiY1pzM1Qreld3?=
 =?utf-8?B?K2NaUDFUSm8zbmZzUXdEMU0rQ0hIZWwrbFBnUmRkVzVtYm4wM1RraC9lSFdN?=
 =?utf-8?Q?YZqapZt6KlUoHoPvZNYskezBenxVW/MNfpzQ1Ng?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230036)(366012)(376010)(1800799020); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVJRYis4a2J6emdVYmJnUU8yY1pBK0g5Zjg0aDU2OEJBMDZ2TUd3TjNVakcv?=
 =?utf-8?B?VW1nYlJPNzY2TmtJVW5CTmJKT0ptTnVyeDQ0RWxuQjVsOUVxbnJzSE51OWNF?=
 =?utf-8?B?RGpMalU2UVRmN213VnNrMG9YTjRKNUdLL3VRSms2aldNa3VKdnNEdnN5NWNy?=
 =?utf-8?B?ZDhxWWUvUFFPTUwyR2ZXYlh1WG9wdkN6SFo1bUhQU0VsNGZ2NXJjNENpTm9q?=
 =?utf-8?B?dnB4NGJ6d0lMZ1ZNakMzRW5VaDcwY291Sk9lUC9iRTJaTmw4L0RrTS9pd09l?=
 =?utf-8?B?bUZ0ZlBlWUJ4UkRDa3ZKeWlzMlYwdE52OEpCcHNmbHFCK2ZkR3EzUzBGTEVy?=
 =?utf-8?B?M2JrTUxPeExRMGlaTzlyckRJRXl5Z09EZlgreWtISzNsZnI4Yyt4WTFuSm1N?=
 =?utf-8?B?aXVLNzQwNzR2OFc2aUlzUStKQTlCUmZ2aTdwQXV1bkdHN3BaYk9TYTliSXBS?=
 =?utf-8?B?WWZlMyt1QjhFZUxCd1lSbmZKK2FoL1BPdkhMblNnZXMvV25JYUdITTQwSXpN?=
 =?utf-8?B?cFI4enJxOXp5UHR6R3YrblB1djRuQ1NlUXNBYmtaNEhWRVZySkdFc2YzZ3Nh?=
 =?utf-8?B?ZGVKWmdoNTNGTTJTUThpSml5YVord2FFZHZ6VEIvcDF5eGI3aFM1dFIxRit2?=
 =?utf-8?B?aE1JYTA0RUVwSi9Nd1lZWDFnaFpZc1F5clg2K3ZkQmc5T2tpT3J5MEhWUnRF?=
 =?utf-8?B?QUNhdFk4RGkwNzM5enAzQ3dSNjVCNzdVQlV6RzFCU1JrYjZyUmdDNURSbk05?=
 =?utf-8?B?N1E3NWViTzUrRGVrbGFTWlY1RGpxeW1mTGlUSyt6QVRKMEVveHU2c0c3eTE0?=
 =?utf-8?B?RGtzZzlaMTBLTTRCTko0WEpjUDIvY09KYnNHNU5lQlFWN3BmL1VReXNRVnRk?=
 =?utf-8?B?RW9yVWFiTjFuV0VGNy9uQ2didVpINkZqdDdWSDd0dDNaVkU5Nm9oUSt6UHJF?=
 =?utf-8?B?ZnkzNGNBYkdneEZOUE1UVWErUzErQXFHdWlITEpZWlVwWDROYWtpdE9rRG16?=
 =?utf-8?B?MHVGSGJWVy9xOHAweFZ6WnVTTitjZmxtZDcwcGVWbkRvcWRkRHowdGFEeWNs?=
 =?utf-8?B?a2VTRndCVFZlcHNCYUNlWXZzaHN3MTdTNHBUVzVOR090OWg2U2ZYRXQxRGpl?=
 =?utf-8?B?a2F4a0loanBBcGwwL0k5dTUvZTdXVjJKblFpcmRlVGZWQTZBQXlMb3RvQ3R3?=
 =?utf-8?B?TnU4bkppRnpFK3QxQWZ2Q1lmeWN5N051WnU3eWZHamxRNkg0QmRXbXlFcmJk?=
 =?utf-8?B?b3RZekY2eC9zQklxenJHRWxROTZWaS9lN2oxeURReXdJSUwxS2N6Vk1jZFJL?=
 =?utf-8?B?alkyL2o1bHY0NHNhQUNPaDRoQTh0RXpST2NhWjFqZ0RlWkU0cEtKK2hsMGtT?=
 =?utf-8?B?YWVKdTZWeUVMbjRzOEE2Z2p4LzBnMHhacUIxbHhHUDRkVllsT25CbHRZV1VC?=
 =?utf-8?B?bmwwS1hxTUN6R0JnOVRDb0VpeFlZOTZ4RU56bTM5Vkh2Q21TN1FOK01CUEl6?=
 =?utf-8?B?ZDRDWHdobXdSVXZMSXMzRE5SYkhkaXN1c1h2VzJrcHZCMk1WZTN5L1BDUFVO?=
 =?utf-8?B?T3ZsdEhhajZxVWhEOXRuRitMWGVKS1NjUjFud29SZjJPZ3R1MTVOV0p6V3RG?=
 =?utf-8?B?SnpjM1lTbWhTL2JySzNhTVlKZ0gySCs2SzQ0bDBiSzgzcDZkQVFwMTBLS2c3?=
 =?utf-8?B?bTBPdTdmQzZDM1lVMUIvdWcyckVKQzNBMHUxc3BBZnBUc2pXY0N2N1BWR0w1?=
 =?utf-8?B?ejBjc1hJNVdHdk5uYnNBRjNkQzlQSTh2Y0ZkTlVtRk02UlN2N3I5V25EU01j?=
 =?utf-8?B?OFpmT2cyeHdHaHVXdExhb25qYzZ6K3JMMmZDWG5KUVpXR1RzU0QzcllpeEdS?=
 =?utf-8?B?VFlPbDFES05tdm9uTm9nQndFN2FURW1MNWRuNk5tWmtQNDAzVlVISGY4WDV2?=
 =?utf-8?B?c3hQdkNZKzR4bFZjZEl3ZVdNSW9UU2Y0VE5QaDFsYUMrV3lzZU1nMUFUZnNi?=
 =?utf-8?B?QUFWM1RhSTZCckl5SnI0WHlKblJUcnRWQ3dZbkNUSXoyZFRMTk5QcXQrbGFO?=
 =?utf-8?B?U2EzZG8wWWN4UjVZQm9yeURTK0JwYkJBMXUrMXRyMkJ0UkdhTUFoQVJRcWcw?=
 =?utf-8?Q?gqZyoZ4y7PyZyo5nhaK0JBZq3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a476c4e-0d70-436a-fec8-08dc8c5910e7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 10:02:14.7736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sc7qp+l9/U/kTptOE9GDxQFz5A7qAgC+73U9c79Ey+m40emty7MHgKfjLIUrtrxZ4+747TuxuCFCL3ILpbfRiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8827
Received-SPF: permerror client-ip=2a01:111:f400:7e88::623;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.395, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/14/2024 10:58 AM, Xiaoyao Li wrote:
> On 5/30/2024 7:16 PM, Pankaj Gupta wrote:
>> From: Michael Roth <michael.roth@amd.com>
>>
>> Current SNP guest kernels will attempt to access these regions with
>> with C-bit set, so guest_memfd is needed to handle that. Otherwise,
>> kvm_convert_memory() will fail when the guest kernel tries to access it
>> and QEMU attempts to call KVM_SET_MEMORY_ATTRIBUTES to set these ranges
>> to private.
>>
>> Whether guests should actually try to access ROM regions in this way (or
>> need to deal with legacy ROM regions at all), is a separate issue to be
>> addressed on kernel side, but current SNP guest kernels will exhibit
>> this behavior and so this handling is needed to allow QEMU to continue
>> running existing SNP guest kernels.
>>
>> Signed-off-by: Michael Roth <michael.roth@amd.com>
>> [pankaj: Added sev_snp_enabled() check]
>> Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
>> ---
>>   hw/i386/pc.c       | 14 ++++++++++----
>>   hw/i386/pc_sysfw.c | 13 ++++++++++---
>>   2 files changed, 20 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 7b638da7aa..62c25ea1e9 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -62,6 +62,7 @@
>>   #include "hw/mem/memory-device.h"
>>   #include "e820_memory_layout.h"
>>   #include "trace.h"
>> +#include "sev.h"
>>   #include CONFIG_DEVICES
>>   #ifdef CONFIG_XEN_EMU
>> @@ -1022,10 +1023,15 @@ void pc_memory_init(PCMachineState *pcms,
>>       pc_system_firmware_init(pcms, rom_memory);
>>       option_rom_mr = g_malloc(sizeof(*option_rom_mr));
>> -    memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
>> -                           &error_fatal);
>> -    if (pcmc->pci_enabled) {
>> -        memory_region_set_readonly(option_rom_mr, true);
>> +    if (sev_snp_enabled()) {
>> +        memory_region_init_ram_guest_memfd(option_rom_mr, NULL, 
>> "pc.rom",
>> +                                           PC_ROM_SIZE, &error_fatal);
>> +    } else {
>> +        memory_region_init_ram(option_rom_mr, NULL, "pc.rom", 
>> PC_ROM_SIZE,
>> +                               &error_fatal);
>> +        if (pcmc->pci_enabled) {
>> +            memory_region_set_readonly(option_rom_mr, true);
>> +        }
>>       }
>>       memory_region_add_subregion_overlap(rom_memory,
>>                                           PC_ROM_MIN_VGA,
>> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
>> index 00464afcb4..def77a442d 100644
>> --- a/hw/i386/pc_sysfw.c
>> +++ b/hw/i386/pc_sysfw.c
>> @@ -51,8 +51,13 @@ static void pc_isa_bios_init(MemoryRegion 
>> *isa_bios, MemoryRegion *rom_memory,
>>       /* map the last 128KB of the BIOS in ISA space */
>>       isa_bios_size = MIN(flash_size, 128 * KiB);
>> -    memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
>> -                           &error_fatal);
>> +    if (sev_snp_enabled()) {
>> +        memory_region_init_ram_guest_memfd(isa_bios, NULL, "isa-bios",
>> +                                           isa_bios_size, &error_fatal);
>> +    } else {
>> +        memory_region_init_ram(isa_bios, NULL, "isa-bios", 
>> isa_bios_size,
>> +                               &error_fatal);
>> +    }
>>       memory_region_add_subregion_overlap(rom_memory,
>>                                           0x100000 - isa_bios_size,
>>                                           isa_bios,
>> @@ -65,7 +70,9 @@ static void pc_isa_bios_init(MemoryRegion *isa_bios, 
>> MemoryRegion *rom_memory,
>>              ((uint8_t*)flash_ptr) + (flash_size - isa_bios_size),
>>              isa_bios_size);
>> -    memory_region_set_readonly(isa_bios, true);
>> +    if (!machine_require_guest_memfd(current_machine)) {
>> +        memory_region_set_readonly(isa_bios, true);
>> +    }
> 
> This patch takes different approach than next patch that this patch 
> chooses to not set readonly when require guest memfd while next patch 
> skips the whole isa_bios setup for -bios case. Why make different 
> handling for the two cases?
> 
> More importantly, with commit a44ea3fa7f2a,
> pcmc->isa_bios_alias is default true for all new machine after 9.0, then 
> pc_isa_bios_init() would be hit even on plash case. It will call 
> x86_isa_bios_init() in pc_system_flash_map().
> 
> So with -bios case, the call site is
> 
>    pc_system_firmware_init()
>       -> x86_bios_rom_init()
>      -> x86_isa_bios_init()
> 
>    because require_guest_memfd is true for snp, x86_isa_bios_init() is 
> not called.
> 
> However, with pflash case, the call site is

btw, right now we don't support 'pflash' case with SNP. Please see the 
discussion [1]. So, this seems to be pre-enablement for 'bios' with 
'pflash' case, which we proposed in PATCH 29 and could not make it to
Upstream (reasons mentioned in the thread). But this does not impact the 
other functionality.

Thanks,
Pankaj

[1] 
https://lore.kernel.org/all/20240530111643.1091816-30-pankaj.gupta@amd.com/

> 
>    pc_system_firmware_init()
>       -> pc_system_flash_map()
>       -> if (pcmc->isa_bios_alias) {
>                  x86_isa_bios_init();
>              } else {
>                  pc_isa_bios_init();
>              }
> 
> As I said above, pcmc->isa_bios_alias is true for machine after 9.0, so 
> it will goes x86_isa_bios_init().
> 
> So please anyone explain to me why x86_isa_bios_init() is ok for pflash 
> case but not for -bios case?
> 
>>   }
>>   static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
> 


