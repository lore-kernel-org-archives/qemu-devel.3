Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CE0C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 14:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txnwn-0007dE-7D; Thu, 27 Mar 2025 10:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1txnwl-0007cz-U0
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:11:03 -0400
Received: from mail-mw2nam04on20628.outbound.protection.outlook.com
 ([2a01:111:f403:240a::628]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1txnwi-0002Dd-Rh
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:11:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYB8zKNz3bvRqYW62iZX4bMGC+tsON698YRLjJI5JfBNlkk82/ARSPWAG3slLmOo75G8kPm1aTT+MYjWKdzp/+h9npzPOhSbvZTBfU4wqkptya7UMo2eTuKN9v9B7RDF+eltVA3f+1Ejm6w9gg/9Ln7aSoLLNPXYtplHTlrphpumy9rYNK27tMhT1sDm0myxslzB0IGFPrPhYG+yir6oTgFhjyzMY+421IGC5PrR1axr7NHhBcwbm4i9NbHbxQZ81yru8A4hF3NEi07lBaDVZ+DXSVoMAXNO9KJn0d/ENl6pFpE6IJdyWD35ttgd2wZdw6yZhJ7aXuVufQBVACs2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=696DUKN1zXlyZPFxVl0kwW/dwYx+AKsHVIXkVhjQvj8=;
 b=motITUvY2Og7LdBS/Vpn3N+bDZy1FdlRD8eo55EzjeSCmHDXmL2jCO2nm6Pv/zlqCMvblVCeemDccx2ejeVfQyrKRHnZuGNdmNfiFXkYl7e2wcy6auXxM95svG6jzACoymBFngbTRtpv3nSbP7WVp1ODQk5kxfK3cO7fSGOv/QBnhp/PMhAbEmCOG5hMYoU8Ix6+fqtC4q2ZJsCCBsUyVn9VZTfoqln9Sr1nDXo+0VmIe+Nh73pp8Fm9QtmOQzf9QrODvoygxHYoZRiG3hjNiITOwkkk2amJPOx4+LBUWBh39K3OY1qDj6CaenJzuw0xWV/0c2jc/tTw1yldCgYyjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=696DUKN1zXlyZPFxVl0kwW/dwYx+AKsHVIXkVhjQvj8=;
 b=GLLZSVyvMt1K2OtQ7FQ4YVoR0IuB8DKhRi4Lb3T2Odp0IqX2vIwFov0rxA9EdYqiBlYu8LfpeHRYf6HwvxqHZL/jkcTfUl4zqHlJTav99rAk1/3ZbXg68XZAdq6yJ01uzhcbL+JeHE99MLpZdnGxQzKM9X1hKT/rA0ZTqzZgKi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 14:10:53 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 14:10:53 +0000
Message-ID: <cbd370de-6577-2b79-cf52-470c26c5c605@amd.com>
Date: Thu, 27 Mar 2025 09:10:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Michael Roth <michael.roth@amd.com>
References: <1743082598-428927-1-git-send-email-steven.sistare@oracle.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH V1] migration: cpr breaks SNP guest
In-Reply-To: <1743082598-428927-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0021.namprd08.prod.outlook.com
 (2603:10b6:805:66::34) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SJ1PR12MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 0259821f-abf7-4ad5-16dc-08dd6d392f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1QxSUFMdDZza1JoS3VVQ2ZXUGFaTk5jd25SQU1DNEJKVHRkckJaQlRGT2x3?=
 =?utf-8?B?dDZWdWtXSTM0MEUzNUJ3VTg5aWlGM212aUk1MTQzR3Fvb1M3UCticFFjTUpE?=
 =?utf-8?B?YUlJSzA4MmlTMjBOQjZYQnE1QU1EMC9LZHM2djdnc1V5aG9Od3hrTVBzVGtR?=
 =?utf-8?B?M081VDRITmJQd2ExcU1kQ2hxR0l6S1pzTG82ZHNyd1B2RSszUGtNWjNybWI2?=
 =?utf-8?B?VmdoSE9Ga0JsV0ZobENvTjhZR2Z5eFhWSUhCVWZkMG9aUDkvVWs0cW43Z05G?=
 =?utf-8?B?VWF0NHBueS9DM0ppZmVNNWZkNU1oazFONEhFRkhLYi81Si9VbGZlR3NObVJG?=
 =?utf-8?B?OEVsVVgzalVONDFDRmRhZlkxdnhaSkE0UzhoV1h6U0dZRmhmQnVPVGJ0ajkz?=
 =?utf-8?B?Mm1ZTWhvTDB0WFd1RDFycEFrRXVsempZR0ZBaEtJdkRKNFRFMlZleDlWang3?=
 =?utf-8?B?bXY2TzdITEEwYk1NOG9HOTlJdXkrY2NDY0pkVTkwN2I5ZkVyc1IxV1ZidGtV?=
 =?utf-8?B?VElMZHorQ1RWY2tSMDIwdXFxb2VxN0gzUndWRW9kSGRNU28wdWVJWlduUklF?=
 =?utf-8?B?cDE0QjBwdXVjTzJHSEFGQTJKUmNKT0RSam93MU5iRVBaQ25IcEZVUkFQd2Rk?=
 =?utf-8?B?NGlOMTBCSGtzbjdBUytEbEpUcnJZd0xRRE0rbllKWWVYS2VHWURKODFTQTNS?=
 =?utf-8?B?b2wwOUs0eXNST3dReUxKcnNaQWMxQks3eXlYRVdkdzh6cmhqTlI3TkRyZTJp?=
 =?utf-8?B?bG1ZdXJIWngvTDA3dDk5S2o4RXpzQlZkcnJ6L1VpSHNjK0F2Mi91Vlpqa3NY?=
 =?utf-8?B?YlJLVEdHWHZuMkI1Q3Y3K054ZWVqWTJkdkQybmdxQ254Mjc3Ukw4MXBSaklj?=
 =?utf-8?B?a2RGM3BHSi8va0F5TXJqdklzZHF6SlNMYTNJNGlLYzNvdkdnNTJ0U0phTCtD?=
 =?utf-8?B?cVVHYnAvRGpxZlMvd080QzYrbm5Gb2VVWW54TGpubmpqWFVLTFJaTldsbTJB?=
 =?utf-8?B?eXdtRW5GYm1uTFVpbUVySk9sWUp4OEVJbkRTZk8rVGlLT3NTTTFTRFhLeXcr?=
 =?utf-8?B?V3g3Rjh4MGZQdmFvMnVBejFEVkgvcVYyNUk3VzFheHhTc3VXdExlN2dubXpL?=
 =?utf-8?B?TEN2T1hsMFhyYkNralZEU1h4cUMzTjdJQ2FRaHcyR2t4M0ZxM29yZ1hOVlVq?=
 =?utf-8?B?dm9QZGdhNTE2aGY2RmVjTlM5VEZKZU5rSC8wR1hCM3o0UFlJRUZ0UzhJNnpJ?=
 =?utf-8?B?ZVBld2lrd0E1OTdWMEtGT2tzQTZSUy90RjI3YWk0d3ZDNkk5Z3VENDhaMTBF?=
 =?utf-8?B?ZlRVWE5EM0tJUzE1aWtPR2hYYWhQMS9VVERKZ0NxMGhVekI0ZktSU2tiYjJ0?=
 =?utf-8?B?Y3pxek82SERjMFBtL20vOGF3b0hrUXVyVUZNZVM1TFhwcTh3L00rOW5zaFli?=
 =?utf-8?B?ZWJkeXhNU0pTbXVETzVnTEhTMDhScjJEb2hNaEkvQ28xdHlJUVY0MkpVUWx1?=
 =?utf-8?B?WDh4UEk5a3owZzEvUVBkS25ka2NkS3RUbnY4RHVxQjJRaE9xZTVJQWlrbWts?=
 =?utf-8?B?UjJvTlZHVWJ2R25NRjNlbHlNV1FRcHlCKzVaNG5CSTlVNGdYcEFnTWZzZ0hS?=
 =?utf-8?B?b0xpaWpSaGdlSzVWR1ByUkxTRTJ4d3F3eDdRUUF1TjFBMUhSMFVRU2g2dWR0?=
 =?utf-8?B?NjNpRUl0Z1Z1SC8yS0MvbXBtZDB4MHowR3YxN2xmU0twSmhxYy83S3hmcnlK?=
 =?utf-8?B?MDJDMGRid2JtTHIzSjJZWXV2bXBYUm9wcTBWVk05MnBmaXZlV05mNXc0WmdO?=
 =?utf-8?B?QUZKYzN1d09ZUGhEWnJLbXZ1aDVSUjdydTFzbmdydmkwSFBlRHBjSEJlenlt?=
 =?utf-8?Q?XjFpMx2cDJYAz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5070.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzFVZjB3Y2FyenJzOHo3bHVaS3U4ay9DbXFIUXh1WGVFWXJyTkszM1dUQlBY?=
 =?utf-8?B?cHcyU3dDbTE4TzhZaGkyakk0N1doSGZYZE1iKzlHUVRqaVlKSTg4YjFQb0Vs?=
 =?utf-8?B?SVYrVG9yTWh6TW1oVTRqZDNJeHl4R2kydXZiVVUzK0xDM3RFUjR6VE5xYlZr?=
 =?utf-8?B?TWIvQmZxZEZLSU5mTjhtVmNpUk9VdmREbE1lS2crZzdkVk5BR3FuWHAvTGVD?=
 =?utf-8?B?TkxETFlLOXp5TjFzR1cyblN3REpiMDJmRWwwSFgwSW4xcG1hZjdyc25kZ1RJ?=
 =?utf-8?B?MjhwcDh6Um5DNU43S3oxQUNGdFBwSkFVMmRmV2M2c0F4WTkrd3pWKzZhc3Bh?=
 =?utf-8?B?UUorQ0Z2UjFvKzRnOG5iZ0wyamFVSENNajJ1Z2pLWTJYUHNXNmRRWGpHUVF5?=
 =?utf-8?B?NStzOUMyekc1eFQ4eElkcUl6c1pPMWlKRGN0Y2tpOWZiUm5zRzl6UENBR2JS?=
 =?utf-8?B?OEh5WkVFQ3k2L3FOcE9BaXFrYmR6bVBab3lNUnNINnJRYnQ3dHRsQVFmRlFh?=
 =?utf-8?B?RzRGNmdYRVB0U0o5d25EWFZYbW9FekJBcG1SY2hRaUpTR2oxOGFYNzh6RTdW?=
 =?utf-8?B?UFE5ZVU0dEp3aXdRbFFNUjFaTHdzZU5tdXFkMmNHM0x3UWVuWE5WUVhpd3kv?=
 =?utf-8?B?bVRJQng3TlNlWlZXZ1FLcmZ4UGVjV1FTdFhYNUpqK2M2MGhoMngwaHNRQnJy?=
 =?utf-8?B?S2pvZCtUYU5pVDBGSzh1dUMxK2RrZks1UHhaSmlLVUhZckZTcDFWWmFRbzR2?=
 =?utf-8?B?WjNUZW04ODRGb3BsUzZIQW41K2c4MTV4VzdwRzYxR3psd0h4VU9zMFRFWHhI?=
 =?utf-8?B?QVJKckdPU1NRWlRhblJtaUxoQVkyWEZ2cmErVmRVZmo0TUw2NXhPbC91cDFT?=
 =?utf-8?B?VHc3bXRTd3lPNUd0SlZtVEFNZEgrRE1WUlFyM3R4UXk0N2N0QUJWb2hHZGJ2?=
 =?utf-8?B?bFoxWGJlR0lSdGRFZCtuNGxrVk1SeHBmcytCQU9naXpMeFZyNTRhYlVPUDgz?=
 =?utf-8?B?cVh1N01vbk1KQTVWSVNYbnBBajNrSFJoZ1h5SHFSV0JqUWlIRlNCWWJQL1dH?=
 =?utf-8?B?YlFyeTlEaUFWRTFSR2J4S1c2VFVXMUs2M2tLaVd5RmZjSVpoUUx3SFBmMi9l?=
 =?utf-8?B?ai9vZ2pBaWtmNHZrdUVUUGFKUWNDSHNPa0lnM1pibkJBbU5DOEtGa1NFTkp5?=
 =?utf-8?B?aWtySXQrM0FVMXdzWms4RGdZeWRtUzJKTTlEcW1zU1lCc1JpK1ZNTlQ5VkdJ?=
 =?utf-8?B?bW9DeGpuVEoxblZoWTl4ZHdSZExzSXk1ZDBZa3RmK2wvZ0h4TXhQM2NqSVVk?=
 =?utf-8?B?dmRIa1R0YjBXMlEzem0zbnRlMzNjUzV6UU41c2tYVlVuYm0xL3B2QUVNdkFp?=
 =?utf-8?B?aFNvWGtDSHNwcGFkeDUvTWdROXNHRUZLbW00bGVvU2dEYXNuNzhFUFlnK3lj?=
 =?utf-8?B?b3ZHMTA2VEUvYlFXM3Q4SFNTNWRSQ09vVndaVEZwdEUyUDIrY0NwUkFaVU9x?=
 =?utf-8?B?alJ6bW5GNHVSd3k0dDRlSEFpTkVtdVVKd1RsU1Y5U2JDNFVJNS9Nc1RuUEZP?=
 =?utf-8?B?eVRkQTljWW5rNVh2SUpWeDBiNjdBMXFJRFE0cWpXUGlON1pqTVQxeE5EWFVk?=
 =?utf-8?B?N3Y3eEZLMnNDU0FFRk9BVmtUZGMvandNNUZVaXZUclpOdXNxdWhNK1JIOExk?=
 =?utf-8?B?UkF1U2sxSU9hTjhmWjZ3RUN2TTc5QmFQUjF1cDRUZ2d2d1U2MTFQZkFXTUtm?=
 =?utf-8?B?emtnOXRZalNqTVJCTk5CcEt1K1BUQ3dhMmt0TTl0bFpYWmhiOXoxd1JFRWNV?=
 =?utf-8?B?d3FnMzEyZ2xUbTVVYTk5eVZ1TElTTXovQmxXRlNsT2JVVVpkK2wzVklGQlg1?=
 =?utf-8?B?bG5UNGJ4bUJ0c3J4SHZySis0bXV1b3I2b3B3L0tyZHpRY1BJVlE2SWV5d0pI?=
 =?utf-8?B?dzZWUUF1TlIvbUpMdm4xbUJPdkVrUERyM1lSaDc4UWdLYmN1bFlWODJLWFlI?=
 =?utf-8?B?YjdjVGE4Rys0NHd2Z3lYVjZ1OFd5QUNYazlrVmhMTnRKMGlOWDlTNU5oM3VI?=
 =?utf-8?B?K1h5ZHlpdnNwb2FnT0RYakROT1dKVW10b3g3TytzZXl5dUkzSlNiVHhhby9x?=
 =?utf-8?Q?ihHnrfX/GuEJ28befm8pYY+hl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0259821f-abf7-4ad5-16dc-08dd6d392f77
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 14:10:53.5024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ilhPtukN9+mgL7kKoFMQ8FW0mP36kPYc5gXW95JwL2MfhjOHmuRcOShmgsINktSKL18b+Z8sXp0+f9wx0Fzksg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6339
Received-SPF: permerror client-ip=2a01:111:f403:240a::628;
 envelope-from=Thomas.Lendacky@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.943, SPF_HELO_PASS=-0.001,
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

On 3/27/25 08:36, Steve Sistare wrote:
> With aux-ram-share=off, booting an SNP guest fails with:
> 
>   ../util/error.c:68: error_setv: Assertion `*errp == NULL' failed.
> 
> This is because a CPR blocker for the guest_memfd ramblock is added
> twice, once in ram_block_add_cpr_blocker because aux-ram-share=off so
> rb->fd < 0, and once in ram_block_add for a specific guest_memfd blocker.
> 
> To fix, add the guest_memfd blocker iff a generic one would not be
> added by ram_block_add_cpr_blocker.
> 
> Fixes: 094a3dbc55df ("migration: ram block cpr blockers")
> Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
> Reported-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

SNP guest launch works for me with this fix. Thanks, Steve!

Tested-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  system/physmem.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index e97de3e..cfafb06 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -1908,13 +1908,18 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>              goto out_free;
>          }
>  
> -        error_setg(&new_block->cpr_blocker,
> -                   "Memory region %s uses guest_memfd, "
> -                   "which is not supported with CPR.",
> -                   memory_region_name(new_block->mr));
> -        migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
> -                                  MIG_MODE_CPR_TRANSFER,
> -                                  -1);
> +        /*
> +         * Add a specific guest_memfd blocker if a generic one would not be
> +         * added by ram_block_add_cpr_blocker.
> +         */
> +        if (new_block->fd >= 0 && qemu_ram_is_shared(new_block)) {
> +            error_setg(&new_block->cpr_blocker,
> +                       "Memory region %s uses guest_memfd, "
> +                       "which is not supported with CPR.",
> +                       memory_region_name(new_block->mr));
> +            migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
> +                                      MIG_MODE_CPR_TRANSFER, -1);
> +        }
>      }
>  
>      ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;

