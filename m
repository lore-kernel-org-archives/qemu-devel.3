Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CADCC3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 10:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seBDs-000088-U7; Wed, 14 Aug 2024 06:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1seBDr-00006t-9l
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 06:27:19 -0400
Received: from mail-dm6nam11on2085.outbound.protection.outlook.com
 ([40.107.223.85] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1seBDo-0004mi-Hz
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 06:27:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYV0ycJgDJxkwGpIyrP+tb7QbkN/B3ThC01byXtEZmNha5oEioo5+t2QhWev8025FvJNYJlgpN9sDHeYynLOKGMmePQFcmS6djfhCSemjmlNKth3AnCI03t2rZjq6Ub7cHH025GKz++837G4/2X1F+efEnQUNdVyLFu6+jSu8ukHu4MolfDMByG9JF/ybS/PbFd3otCNMyWAhG659vyYRINZR6U3ZvlX/c8NIgbZjVtU3TjF2eOSNdTLH3omygdGTr6kGDgDACNqjIeehneGOdS/nAsORxWLDkdrVjJb26g5zmvrd2HvnVzrtOc2/of4AA0JnEup24VkjZhbaw1Cag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4f2FvU4kvfMRC/l8OTittmS75Eu5miSK79IRkmBhT8=;
 b=o6ovN4k/tMWOEIj8OY9q06uMjZk/jkX++m1L4hbGlFiDGdWZB5HUYGRMzkX/xngIKM1GSg6Yf2RtZSM4sWgx/s6sSbabhcTYIHYfbjg9CtC8t3DrCo/Dw9e7Ak0EeOvDStZ0GLrwEhIv2fxb0Z+8IEh0uTl8kBBU+mRTxJBu40qWyO0a4tbCGWapY8I9PGT/ev3UsKas37GSMOZrPYD8aeFBiR68ohkl4Rti+aXiTNeiNCs5U6CAoPZUONqQhFd39J+M+E/zqs/vWFiu2t21GgXHDai8ut9fjvHv1TIxc/rW4Azm9G/tfV/LyXRDmR9hHaa5seHcSmLWzjQ9XblIng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4f2FvU4kvfMRC/l8OTittmS75Eu5miSK79IRkmBhT8=;
 b=IAGUoeVZBnTA5bFzbxl9//LVCsgK/7m7jBkPMG6650rVzpHZyenU0qVSx0u5gI/N+2s0NglApPnFfqp9XJt3bVRNtoCa40bdq5KIoNPIdBw9RiTg/8CXz77GK72RzJYKWHS0XmO0/D0m01rOikzlTyop3EBX2LeVZH5q1M5DvWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Wed, 14 Aug
 2024 10:22:09 +0000
Received: from IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48]) by IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48%6]) with mapi id 15.20.7849.023; Wed, 14 Aug 2024
 10:22:08 +0000
Message-ID: <6252cb28-519d-8986-445d-4ec39d978069@amd.com>
Date: Wed, 14 Aug 2024 12:22:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 06/16] sev: Update launch_update_data functions to use
 Error handling
Content-Language: en-US
To: Roy Hopkins <roy.hopkins@suse.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez
 <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?J=c3=b6rg_Roedel?=
 <jroedel@suse.com>
References: <cover.1723560001.git.roy.hopkins@suse.com>
 <afc57824b0ea3b8f83e1c850ba976e37989ae9d0.1723560001.git.roy.hopkins@suse.com>
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <afc57824b0ea3b8f83e1c850ba976e37989ae9d0.1723560001.git.roy.hopkins@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::8) To IA1PR12MB8189.namprd12.prod.outlook.com
 (2603:10b6:208:3f0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8189:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2e99da-d8dc-4c6a-77ca-08dcbc4af3fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVBpQ1dEN2Evb3pzazl2V2dZbTRpRjVuamRrYkI2RHU1T3gvb1F4SUVJMGY4?=
 =?utf-8?B?RWI4VjNMODVSTVBESkN3akhmWlRCdFN3eDJyOEFCYm5xZERCYWJzeU4wajlR?=
 =?utf-8?B?WXcvSUphdXBubm1wVVNZaklaOEg0WUtXM0MyQ1dZMWpEWFVIWUs5NG5aR2hO?=
 =?utf-8?B?R2IrSlA2eFZEbU4vdmdRVlJSVGNZY3JDQ3BjNTJqR2NNNzY3dlE2Rnp3RVJP?=
 =?utf-8?B?ZTVYWXhQcmxmQ2wrTjdJTk9EKzlkKzFyQnVYNG82Q2F6WVJ3UmFQNWZVUFU5?=
 =?utf-8?B?ajZHWnFzM3BDODA4RFkyL2ZJM2J2M2x4VWhEWExGeko4VzM0VXc3YjhqZU5L?=
 =?utf-8?B?aDdyRUlaRzM3K0dScG1oSWJYUEg0WWVDNXlSRkJabUt1VzRKbHMzRHp2YnU1?=
 =?utf-8?B?ZHJ5akh5c2hDQ3FRSFZpRHR1YzRUWk1YeS9ndHJGMTh0S1BzSDI5WWh4Y0px?=
 =?utf-8?B?MnU5cFpBOGR5TnV0QTd1Zk83R1Q4aUdBeCtYUURxU2o4d0lXd2ZJNEpRS2p3?=
 =?utf-8?B?cTc2WXBBWjR6dzBsVXdTS0NJUXg2QnprYWJHUlhRNG54a3ErTTQxY3dEQmhv?=
 =?utf-8?B?VEdNNy9tWTRlTkNKdVlKTjA5RlY0SEVsSmpvenJ4YUJyM2FsVHJrc1k4RXhU?=
 =?utf-8?B?ZVFXb2Z4TmI5TGx3M0gvSkVIYkdRNHQzSzUwQjBGQWM2ZEZoWUdRL25ZcDVK?=
 =?utf-8?B?SWc4cVo0aTNHOE9xN05lSXlabVQxdGxPTVZGaE5FbmNlQ1dua2tkNVJsRWNW?=
 =?utf-8?B?OHhDQVhmV3F4Z3FNeXJjYW9yRS9QYXh2U0hSWUpSM214VklRcEgwblZyNitr?=
 =?utf-8?B?akFEZjd4cWxrWHovWFArMTJudUVBSHhZS255K3FjQ3RtZEZRdWZZL1RNTDFT?=
 =?utf-8?B?KzAyYVJCNnFhd0RXaHIxaWIrZzdnQUs5NnNWVFhBVUVUbVQ3U1lScDRNMmY2?=
 =?utf-8?B?Vm9HeklPeTA5WnM1aURFSFUyVjQ4b295VzhHNG81M3A4dGVUekxDN2hGK0s0?=
 =?utf-8?B?UVN2T2ZvVE13NXdIQ253VkRVeFY1NHJkd3NNclo2cXVUSytWVmREU2QyMGI5?=
 =?utf-8?B?eklZWVNLR0xJYlhWSm1qWHphZnIwc3lraXNpcy9ObkNQOWtnUTZnZVpzd0Z3?=
 =?utf-8?B?d1ZYTUhRU3dnQVJLOXA4S1ZadWQwTXVTRm1rZy9ha3UvVFhSaURzdTV0dGJx?=
 =?utf-8?B?bjZwM21hT1Uzckp1M3NvNmxOU2pXeGNZd3cvVExhbEdSM09KalRVdnVrbkg0?=
 =?utf-8?B?UlkzcElMTThvYlRVbW9YdFFHNHVkN083bUFTdkZjdEV6Yks5TEZnUnFxQStF?=
 =?utf-8?B?QnJtaFUvV1d4R1dXQUZvSFgyTG5EbTBHeUsrVDBFRlRIdEFvdGZ1a3ZGQUtz?=
 =?utf-8?B?TjByN09hZ3dGcXpzR2dqN0hJTjdMOGt4SWQ2NVdnckdTL2lZS21xZlhKSzIv?=
 =?utf-8?B?SkZ2MG9oaGtMVUJNNXNzU3AwVWcyeFRObkt3eHRvZzBGb1FTSlFyckYzR1lX?=
 =?utf-8?B?ZHFPc0I5WHN3dmQ4NThkcTVTMFladVZKS3RxQU9OVEU1cEs3aXFpVlhiOGtr?=
 =?utf-8?B?WWhOVnpWbEwrVmcwaXlTRjVGaVREVGttR0JLaGJsK1FLajJSUU9nZU5aU01p?=
 =?utf-8?B?blVrZXpzd3dzbHNBY3drVVkyczc1MnJjNUVmYWxicXhmOEd4SVBoN0lKaHdx?=
 =?utf-8?B?ekpaWGMwOFpreFpnZTNoOVRWWDJWRGNLQVc5QzNEdENRV25lbnUzeGo3Z2Z5?=
 =?utf-8?B?SVFyc2l1RWphVmxrOWxuUFVEcytQeVNPK0tnZGFERU52NUxidllEb3B3c3Vw?=
 =?utf-8?B?ajRkLzQrV2xEdFFFYmg1UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alI3U0t6V0E0a2Vlam5yQzhZZzJQZ0NCNjFTSlhLVEY1dDRER0Jrc21kbTdP?=
 =?utf-8?B?SzZ2M2RrakI2eXNxcnAyS0dEMjB3N0FYRHpCWWpjZ0pLWHd0NzFNclNwejUz?=
 =?utf-8?B?aGxWSXZ5eEI0aFN1TWJjb2hGRUE1ZWU0aHFoY3hyeUZJaElkZElUakJUUVoz?=
 =?utf-8?B?L3RGSDVRTXloVkdGWDFPSUsyS1VOYWZ3TWhURDFuTHlHN1BGNWVXU2ExQmpT?=
 =?utf-8?B?R0EwSUJsMVFQWG8zZEJBZUVvVEl5cTJSSGV2NzhqN2VINzQxZ3NMSEI3dUtr?=
 =?utf-8?B?SmFPMUNudk9BbUpaRnRxUzd1bkRra2cwalo0dVRUazl0UU93V2Uxc3pzejI2?=
 =?utf-8?B?dEtTR05zaWc2UVI4ZDVjemoyUHZML2U5Zzg1Y2M3cmxZTFdEYUtOajI3d3hy?=
 =?utf-8?B?QU9VTEZ4ZXhiTFEzSkU4clQ5RURFejhuR1p2UjVZak1PMzdQblB3amdidlJr?=
 =?utf-8?B?dnpjMmpNcDdVWTc1Q0R0V1JFdk1mVkVsSG44WnpPS2FJbktJTmVqUlFTQVp2?=
 =?utf-8?B?MFZmUDJxZEExZ1duQU9QTUFoeTJDeHpCdDBCeW1EQXZ6TVRDTjFhTFBCWEhi?=
 =?utf-8?B?SFNOZVRjZjFzcHlaUVNSdkdDUkRGWkpoWFE1SXBYZEtPcHVtWG8weUdnQ0NB?=
 =?utf-8?B?SVdRRjQ2ZElNUVZxRU9scjRQcXJPQmpvb3BiR2RGV0N3dHFiK1hBenBiLzZW?=
 =?utf-8?B?Z1RES2graGdVR3RjUVdvMkV0Z3Q2VlVYYWUwamQ4OWtLd1o5RzNSbEtXSUtR?=
 =?utf-8?B?cHEwaEs2MVZJWXB0RngxbTZVcW11cUR6ZzJwSElnM2JyU3l5WnZGNFYzam1O?=
 =?utf-8?B?Z3pDaHIrS0F6b2dHMWI4Ykl4cS9LNzZXbEx4aXBFQVhRaDhRK0xoQlFBS3dS?=
 =?utf-8?B?cGU4QWZBdy9SNWJ3b29ueUxEenQ1LzNqSkl2UTNhSGFmb1ZPTUplZUVOK3lJ?=
 =?utf-8?B?NGFrVVVlMDZxV2x3Ly9lWkJ6Ukd2RGJmdjQweVBDdUgzRHBqVGZDSkZ0QVlk?=
 =?utf-8?B?OWU3ZGRVZTNITC9ObG4zNk9QTU9XdkR0b1dUMWhzRDVWMDJmbG4wUUYzUVBz?=
 =?utf-8?B?UEoyVW84c2JTekx0OWZ0Y0tuVmt2em1mTG5ubDZBbTBEWjhleEhrdFZKUzRv?=
 =?utf-8?B?REhmVzZIZDIzMW93bENxUlJXTk5ObTZrVVBia3FYWlMxZUpyUnZkdW9XQ2dH?=
 =?utf-8?B?TEJ2d1d4bVFkVUdsMlhuTkszQU0zUFdJM1R1MDNROWZ1RXAwSUlnT0lUWjlK?=
 =?utf-8?B?K1FRZ3hmZHdsUi9BZVNoV1RTY1p6OTZRNGVpMlN5TENPbDFnRVpOVU10MFBP?=
 =?utf-8?B?M1RFZTVXODRhQ0ZQelllbUZMY3VzM01LSGNVU2tyQ1VSbXhqYWJ1bDFFN082?=
 =?utf-8?B?S0dydnkxVFpqZWRiK1NOTGlSZ3ZXSjRjQXBCOGd5OFNiNm9wejdoOTAzeUpT?=
 =?utf-8?B?Q1p2U1ZmMDVkaFZrV1B6WFdNdnBqQ1lGYy85YlBSaU5lWDcwcjBpOW81M3lr?=
 =?utf-8?B?SC9KTnJjOTVyZ3Q1TVFnZXRxUytkVzRVMzZiUWpDbU9XVjJoM2s4anJPV3JX?=
 =?utf-8?B?NmFRZlNyTW1kejU2QTNvbTBCbEp4VVkxVjdlSHMzdlNyWGVMVU80ZENPdWNQ?=
 =?utf-8?B?a0Y4Z29ZZWw0OUNtd2NaVzNrUmMrbnBlOG00VEkxVWpraGZCYTNRK21uOFF2?=
 =?utf-8?B?cG5CaWFKc05xWm5HZlRQL09pTHZGdVUrbVE4SUsvY2JseWtORDJ2ZXFGZk82?=
 =?utf-8?B?M255eUFVbUMzU0VycEo2MDduRUUwNUg0WnpzWFd5c2lkTmxwN01YVTNrVTdt?=
 =?utf-8?B?MFNvdTc3TkhEbmJXZFVCRUtaTUFVN2hZTVEvWjU5MFNZcm5uL3NpU3JIWTRE?=
 =?utf-8?B?T2hoNlpqL3ZiQUx1VmJUblVSRHVaenZJMkNUZjBOU3FnWU9pVkEyV3NiZlpr?=
 =?utf-8?B?VEorVzJscEhUUFBQVnZRYUtpWmtUQktkQzA5U2JrSU1PMW5Nd2FEbzRtSWNv?=
 =?utf-8?B?N085RCtBVU13eDJzQW5LRHcvM095MHBWK3l0bHF0YUZ5RTZIY25DbUV4YW9O?=
 =?utf-8?B?ZFlHTHprdVg3cnF2TXZJZEE2TDRVUG5WT2Q3RTZxTUJuODNQWG1OWFRYbTcx?=
 =?utf-8?Q?yTfCyT73jTj7gcR3R6W2ozGPz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2e99da-d8dc-4c6a-77ca-08dcbc4af3fc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:22:08.8636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNlS9fL0wIWtkOy/DNBmn69hRTJDTzS78Z2XxYbbRTQQ++lyr354WqB9RLN89zjJOqd70SFl9GP8EhqjzVWgaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202
Received-SPF: permerror client-ip=40.107.223.85;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.251, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> The class function and implementations for updating launch data return
> a code in case of error. In some cases an error message is generated and
> in other cases, just the error return value is used.
> 
> This small refactor adds an 'Error **errp' parameter to all functions
> which consistently set an error condition if a non-zero value is
> returned.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

> ---
>   target/i386/sev.c | 68 +++++++++++++++++++++++------------------------
>   1 file changed, 33 insertions(+), 35 deletions(-)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index a0d271f898..fab6d1bfb4 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -121,7 +121,8 @@ struct SevCommonStateClass {
>                                          Error **errp);
>       int (*launch_start)(SevCommonState *sev_common);
>       void (*launch_finish)(SevCommonState *sev_common);
> -    int (*launch_update_data)(SevCommonState *sev_common, hwaddr gpa, uint8_t *ptr, size_t len);
> +    int (*launch_update_data)(SevCommonState *sev_common, hwaddr gpa,
> +                              uint8_t *ptr, size_t len, Error **errp);
>       int (*kvm_init)(ConfidentialGuestSupport *cgs, Error **errp);
>   };
>   
> @@ -977,9 +978,8 @@ sev_snp_mask_cpuid_features(X86ConfidentialGuest *cg, uint32_t feature, uint32_t
>       return value;
>   }
>   
> -static int
> -sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
> -                       uint8_t *addr, size_t len)
> +static int sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
> +                                  uint8_t *addr, size_t len, Error **errp)
>   {
>       int ret, fw_error;
>       struct kvm_sev_launch_update_data update;
> @@ -994,8 +994,8 @@ sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
>       ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_LAUNCH_UPDATE_DATA,
>                       &update, &fw_error);
>       if (ret) {
> -        error_report("%s: LAUNCH_UPDATE ret=%d fw_error=%d '%s'",
> -                __func__, ret, fw_error, fw_error_to_str(fw_error));
> +        error_setg(errp, "%s: LAUNCH_UPDATE ret=%d fw_error=%d '%s'", __func__,
> +                   ret, fw_error, fw_error_to_str(fw_error));
>       }
>   
>       return ret;
> @@ -1123,8 +1123,8 @@ sev_launch_finish(SevCommonState *sev_common)
>       migrate_add_blocker(&sev_mig_blocker, &error_fatal);
>   }
>   
> -static int
> -snp_launch_update_data(uint64_t gpa, void *hva, size_t len, int type)
> +static int snp_launch_update_data(uint64_t gpa, void *hva, size_t len,
> +                                  int type, Error **errp)
>   {
>       SevLaunchUpdateData *data;
>   
> @@ -1139,23 +1139,21 @@ snp_launch_update_data(uint64_t gpa, void *hva, size_t len, int type)
>       return 0;
>   }
>   
> -static int
> -sev_snp_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
> -                           uint8_t *ptr, size_t len)
> +static int sev_snp_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
> +                                      uint8_t *ptr, size_t len, Error **errp)
>   {
> -       int ret = snp_launch_update_data(gpa, ptr, len,
> -                                         KVM_SEV_SNP_PAGE_TYPE_NORMAL);
> -       return ret;
> +    return snp_launch_update_data(gpa, ptr, len,
> +                                     KVM_SEV_SNP_PAGE_TYPE_NORMAL, errp);
>   }
>   
>   static int
>   sev_snp_cpuid_info_fill(SnpCpuidInfo *snp_cpuid_info,
> -                        const KvmCpuidInfo *kvm_cpuid_info)
> +                        const KvmCpuidInfo *kvm_cpuid_info, Error **errp)
>   {
>       size_t i;
>   
>       if (kvm_cpuid_info->cpuid.nent > SNP_CPUID_FUNCTION_MAXCOUNT) {
> -        error_report("SEV-SNP: CPUID entry count (%d) exceeds max (%d)",
> +        error_setg(errp, "SEV-SNP: CPUID entry count (%d) exceeds max (%d)",
>                        kvm_cpuid_info->cpuid.nent, SNP_CPUID_FUNCTION_MAXCOUNT);
>           return -1;
>       }
> @@ -1197,8 +1195,8 @@ sev_snp_cpuid_info_fill(SnpCpuidInfo *snp_cpuid_info,
>       return 0;
>   }
>   
> -static int
> -snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva, size_t cpuid_len)
> +static int snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva,
> +                                   size_t cpuid_len, Error **errp)
>   {
>       KvmCpuidInfo kvm_cpuid_info = {0};
>       SnpCpuidInfo snp_cpuid_info;
> @@ -1215,26 +1213,25 @@ snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva, size_t cpuid_len)
>       } while (ret == -E2BIG);
>   
>       if (ret) {
> -        error_report("SEV-SNP: unable to query CPUID values for CPU: '%s'",
> -                     strerror(-ret));
> -        return 1;
> +        error_setg(errp, "SEV-SNP: unable to query CPUID values for CPU: '%s'",
> +                   strerror(-ret));
> +        return -1;
>       }
>   
> -    ret = sev_snp_cpuid_info_fill(&snp_cpuid_info, &kvm_cpuid_info);
> -    if (ret) {
> -        error_report("SEV-SNP: failed to generate CPUID table information");
> -        return 1;
> +    ret = sev_snp_cpuid_info_fill(&snp_cpuid_info, &kvm_cpuid_info, errp);
> +    if (ret < 0) {
> +        return -1;
>       }
>   
>       memcpy(hva, &snp_cpuid_info, sizeof(snp_cpuid_info));
>   
>       return snp_launch_update_data(cpuid_addr, hva, cpuid_len,
> -                                  KVM_SEV_SNP_PAGE_TYPE_CPUID);
> +                                  KVM_SEV_SNP_PAGE_TYPE_CPUID, errp);
>   }
>   
> -static int
> -snp_launch_update_kernel_hashes(SevSnpGuestState *sev_snp, uint32_t addr,
> -                                void *hva, uint32_t len)
> +static int snp_launch_update_kernel_hashes(SevSnpGuestState *sev_snp,
> +                                           uint32_t addr, void *hva,
> +                                           uint32_t len, Error **errp)
>   {
>       int type = KVM_SEV_SNP_PAGE_TYPE_ZERO;
>       if (sev_snp->parent_obj.kernel_hashes) {
> @@ -1246,7 +1243,7 @@ snp_launch_update_kernel_hashes(SevSnpGuestState *sev_snp, uint32_t addr,
>                  sizeof(*sev_snp->kernel_hashes_data));
>           type = KVM_SEV_SNP_PAGE_TYPE_NORMAL;
>       }
> -    return snp_launch_update_data(addr, hva, len, type);
> +    return snp_launch_update_data(addr, hva, len, type, errp);
>   }
>   
>   static int
> @@ -1284,12 +1281,14 @@ snp_populate_metadata_pages(SevSnpGuestState *sev_snp,
>           }
>   
>           if (type == KVM_SEV_SNP_PAGE_TYPE_CPUID) {
> -            ret = snp_launch_update_cpuid(desc->base, hva, desc->len);
> +            ret = snp_launch_update_cpuid(desc->base, hva, desc->len,
> +                                          &error_fatal);
>           } else if (desc->type == SEV_DESC_TYPE_SNP_KERNEL_HASHES) {
>               ret = snp_launch_update_kernel_hashes(sev_snp, desc->base, hva,
> -                                                  desc->len);
> +                                                  desc->len, &error_fatal);
>           } else {
> -            ret = snp_launch_update_data(desc->base, hva, desc->len, type);
> +            ret = snp_launch_update_data(desc->base, hva, desc->len, type,
> +                                         &error_fatal);
>           }
>   
>           if (ret) {
> @@ -1622,9 +1621,8 @@ sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp)
>       if (sev_check_state(sev_common, SEV_STATE_LAUNCH_UPDATE)) {
>           int ret;
>   
> -        ret = klass->launch_update_data(sev_common, gpa, ptr, len);
> +        ret = klass->launch_update_data(sev_common, gpa, ptr, len, errp);
>           if (ret < 0) {
> -            error_setg(errp, "SEV: Failed to encrypt pflash rom");
>               return ret;
>           }
>       }


