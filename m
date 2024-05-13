Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63995C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 14:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Wyi-0006N6-5J; Mon, 13 May 2024 10:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6Wyf-0006Mn-1S
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:48:33 -0400
Received: from mail-dm6nam04on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2409::601]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6WyQ-0006Fp-M1
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:48:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQsiiTp8uap2LcIxkm7svntqcu8FAIN8X+k9/m1vQpBGLN4ULCeou+FNu4yhGhrviuE/kQSecdsFs8GkYyZr/6dnJO692YY3Ho5Gg22f4qNgdmg2elX8hRieyimxTsI/4BBd5iHfB0CiSazP6XPUcWgxUiO7cHxdrAjhuHlR3I1PndRCZ3ZtqoujHSq/jErg5Ge4sjc6HApGUJoo6G4yhJvR8qosIrcRdlpJ4njVG4ZSmPcG7eqsHRxJPmpw88Kh51dLWS4lYy2dgKyWsb4iD16MmCFnqNu0IUEJgKC0bzvDDzBUOdkDuYDGv5nxeE+247pZv62rnQa1q6JSvfQIxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtI6WYkYlPx+6+bz4u5UAYmnLnAo2WfNKCi27+M0roY=;
 b=eIFfnQYGO87F1yco33saubjY8A/zw/AJjjM6MDi7Mx8bpw+/iD2W5kTWf6j+Zk0I1WdzsthzVrnlDzPrKeDCNeMBaEoi3LQP/aylHvENW36QYS7uhc4Z4eUwB2p0Gt+4xdk4gy7cTgRtxFzSqW9lETy0MJzzC2nBMrcjHklHQs9xC4wNX/n2RnpwTQWHI8xlLaqVLwaGkRz+0UR9rTx7XaJY0Gx32g/oeUVMFxA4aRp/LKGzd8TXXM4j01gId2LslnboU8KH/LA6KHqH9oiF1jV3dYNhBQOOWPEWV40rCSGD4096SQMiW2ahG6dNHVqT47OXbJk/tOt57ClPc6LgSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtI6WYkYlPx+6+bz4u5UAYmnLnAo2WfNKCi27+M0roY=;
 b=gNDUp+WT8CTyL0kfpoT/qRQSqnEt0vX81++VviOK/DlhpATrvC9TDWAxqb84MpgYG+TM7P7XgBlPTIJWJAPmnxfk2PPorRSkR8Z2qXCf7Cu69c58kM9uuvfOYsU0wvO1EfdG12dzH7m5mP5q0g6zVbyMDpa5B9lYGvkgiW85Ch7N3vortHNPz6cPKHT2XC+BoNg7FAImzCizi9XmmbgQzeGzW6CKUor6OJXivvfqeMnrq99kTqtKlAvxb1gSidF3M/UtvKhO4tlf8lUWzp5JSTvUhnigaBCiHWL/IoiOFHVrKpIc1gtO05n6LTjOM45IirAXHr8gcMtWRfykIVj5jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 14:48:13 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 14:48:13 +0000
Message-ID: <8de0474f-6ca5-4a15-821e-7f905f82ef87@nvidia.com>
Date: Mon, 13 May 2024 17:48:07 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] vfio/migration: Emit VFIO migration QAPI event
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20240509090954.16447-1-avihaih@nvidia.com>
 <20240509090954.16447-3-avihaih@nvidia.com>
 <8fe65dfe-dd9c-47c0-8769-3479484b3e5e@redhat.com>
 <d4252893-905f-46ec-8113-a39ef5623d34@nvidia.com>
 <81662c99-96c7-431d-b2a4-4ae9f2cae6a9@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <81662c99-96c7-431d-b2a4-4ae9f2cae6a9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0038.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::26) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a2cc21-4911-4cd2-fe80-08dc735bb6dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnpKcDRHVy9USU5VdWhvZjNuOVlkQXJVc0hjOXkzV1lyZVYva05zWnF2QzZ0?=
 =?utf-8?B?bHh2MTh3QS81ZktNdmpqc01mcmg4TDVHclh0VlJHakZzTG5FS2ppeVhBZkFW?=
 =?utf-8?B?bkhVcFN5MTRPcW4zTEtJUHIzVnZoNS9iVnRHdTJRRncxcXVUWWNCYXM0NW1j?=
 =?utf-8?B?VDZLY0RPcUZOUGR3Wnl6Mmt3YnRFY3ZmTGtkbzhrSUhLaGNpbml0VHcvZWZZ?=
 =?utf-8?B?eDdYOWpjQTFkOHIyQkoxMXZ3Y3hqVHlOb20rMURUZExOVFpmNXQ0dVlJeDNF?=
 =?utf-8?B?UCtYbW95Um41dnNjM2xmU0o3VjczaEVXbHlWK1E3K0lpTzhzakRtSDB4dHp5?=
 =?utf-8?B?dVFjbm9zclIwVzVoTU40VnlOZW01YndQVzVCRGlUQXJvV0pWc3hPSFdVMmxJ?=
 =?utf-8?B?NGJkZVdNOWkva0l5ZmRtcHQ2dHRkaWN5cExhZDFPcW1FcVE2SThTK01uZ29K?=
 =?utf-8?B?cm9uRnl0K0s3T2pWOXZtOGNKSDJkMjRsZE5FU1ptQWhDL3poOFNGMWtBYWlN?=
 =?utf-8?B?bHQwVjZkZkdieXdwL3JIN3E3MUlNMnpEQnZtQTFnVERxeWt4SDQzSFhiOE5l?=
 =?utf-8?B?Z2lIMkxVU3RTVC9namFVVVpvTnlYaGtYV2VIWjlreVFQL2w2dmxWZ0pyREpM?=
 =?utf-8?B?QS9zMDBKVjdCQXgwbUxKaVA0a09NV0l5bVQzemUzR3A5VXZPMzM4OGJPQXd4?=
 =?utf-8?B?SUhvYmVnQy9QMDd3ZjFMcjN5VnhtcWZ0ZVZGdlp6R2xwQ0RGVGJNUmNpaFZX?=
 =?utf-8?B?U2xNcENIeUltdUNCYk1ZVzdtYnFyOHhlTStIM2dCMnNlTUVIWmc5NFgwcUcx?=
 =?utf-8?B?ZjNVVUtTOFJCWFhqUXVXZEZUTlJVRUFTSm00eEJjcHplSDgya0dYaVo5VlRo?=
 =?utf-8?B?VjMyRjVkTGk4ZXpTcmJVSUlaKzFIbU5IUVRtcVM0VmpoWVpKbHdpbmVhbUxr?=
 =?utf-8?B?aXdqK2Mrb09NWHhnQ1FySUMzTkVMakpWOE43b1pZcUFjcTdIM2Q5ZU50cWhS?=
 =?utf-8?B?RnUzajNMbWlpY3VrSEltV25wMEd1Z2tSRDcrZU5lSWZXQUdKczlidmN6bGNq?=
 =?utf-8?B?RHdyM3JRNVF4Sjh4OGJXWFBHQktUY3V3c1c3N3RWWUFIV0pPZjAzWEdZMVR5?=
 =?utf-8?B?S0NTT044ZHdJbmdKZW5VcERWOHlES3BRWFV5V3JvSFcvSUx2d3dsS3pMRnJE?=
 =?utf-8?B?NmV3d1Q2d2lucWp3ZHpGaStTM1JBOFIzRGQ1N3V0ME1SRjJVUDFEOWpYdW1P?=
 =?utf-8?B?UzRSYzlzekJicUY1Ymp3NkRhTDhyR1NjNzVuWW5wV2taOENGNk5sUlNON3lU?=
 =?utf-8?B?cXpyNlRZM1U0QVVwMVhXRlVidExCSEgybURFU2gwNE5VUnlmLzNUZ1FCdi81?=
 =?utf-8?B?WDYxN0JCUkIyMG0zZWk3Q2YzRVEzdm92a3MrUCtsN3RUQVhRYTdUV2Qybmtn?=
 =?utf-8?B?UDQyWldRSG5ZQXhveVNJL2U5aFl2bG14SXV3WUZoZHdCeVBlMW4yNlNZc3Aw?=
 =?utf-8?B?RXhqUElwL0FCcHA4NkxPckVRMjhBQWU0N3I5d1J6RG5sNWRaeFc1UVlXSlpi?=
 =?utf-8?B?SUJWeEFvT3d0VytFRWVVeWMvZnNGdlJHeHp5cm8rbWZFRlFQeFJnUS9CUlBP?=
 =?utf-8?B?VDlrSzhkUE1hbFI3QUNaQi85aUdtYlczcWtZWWdLZUJ6UXNLc3VyL0Z3aG9s?=
 =?utf-8?B?U0JUV0habHkxTHVLUURNRDhZYjVLd1VReUdkVzgrQkhKNzhUdndBRTRRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akZHdGFoQjhsdXQ1bUZET2tuck5DUkFBWmFYWExaSXp3Q1U5dFk3UVd5dlpD?=
 =?utf-8?B?S09zS2dsVHNHelk5SGpvL0pmZUwzaE9yUFpUU2MvWEtLbTFrRWhwcG5BMGFt?=
 =?utf-8?B?eURJNEw3djJjUVRNMFJGbjlQVE5oWi9ZUVVKcUxZVTFTUkIvM2x2TStNdnZU?=
 =?utf-8?B?ZkVYVDNRcnAzQnl5WnRGeXEzU0dQMWxLY1FnYjhXbTJObmprMEwvTmxrTU5a?=
 =?utf-8?B?S09mb2tlcXlGMGFLK0dSK2JMWGZtVzRkNFRnVjVBaTJWVWxtVGFoMTFXcURi?=
 =?utf-8?B?WlVqZjJLVTRlZkhLNHk0WWJjczRjV21CcVZjVW5JZFd6d1U4M1BOVnl4bWJT?=
 =?utf-8?B?eCswYjNKUDNPNkJaTTh1MFhUTVlpTTRNdjhHK3hJeHNTLy8yYU1MOG8yQUxU?=
 =?utf-8?B?ckJRdTdrYzdRR0ZmT3p0SzNiTk4xN0txTjhkMy84YlB0b3YvTklWZktpSjZZ?=
 =?utf-8?B?VHZZWmR2VHN2dWdxWUNtUUtibjBTMFFkNFFtZTZzV2I0Wjd4YmRCS0FNT0tx?=
 =?utf-8?B?djlTTDMrb1NvT3Z0cEsvSFFmYVRDazRsT243VW41OXRKd0UrOG9DUTVTU2pW?=
 =?utf-8?B?cjNEaDAySi95TisxNFpwVHdHc0ZsUExBbEJWMUtBbCsvSjhSekZmR25IRkdo?=
 =?utf-8?B?ZnZZanNNc1dSaVpVR2dJcmVrRldtcmR3MzdCU1A3QkJhRzIwdFd5THBnRmFx?=
 =?utf-8?B?ZmpiTGNvSXhPQndJd0lRRnQ0cWJPWDQ1OHQ0RjhyakdKUUt6OEFhQlJRbGJN?=
 =?utf-8?B?dmg4TkprV0RCaXNuLzJSbTVqT0gwdkNaVVlnVGFObkliMGhnc0U1ZlpEQ1dt?=
 =?utf-8?B?MWZyNDNiWjZTSmtTdG9qRW5rbXRKNW1PWkFoVzdCYTZ5MHJ3WUY0TjVmamRX?=
 =?utf-8?B?SElZZGJWK1dibVkyNjhBWllOUjhoaXl6UHd5SkVRUWFiTzU2M2xReVFIZ1Bu?=
 =?utf-8?B?aU8rQ1BjWHI3UktFekp6MmxhVVR3Q3pGVEZIMStPNFBiVlhpeG9abitXSERN?=
 =?utf-8?B?NXRib1RyQ2xERVhKa05FdHpaYWlsMW50VFV0bkRtRE92b0V5c1JQZmhtU2Fl?=
 =?utf-8?B?QzNIRXV0OFZpVDR3U3RPZVZVcjZ1VU5QWFFpaG1nMXhIcTlXZkFzZXJVa0lu?=
 =?utf-8?B?dUZtNDRZeGoyMW5wdmdYZ0JuanJEbEFGOXZUdUxDR0JwLzJSd0FDdGtnUUxs?=
 =?utf-8?B?VjZOT1huQ1lJeDJ4ckVtMUQwRGlHNVRUWThHSjF0T0NhRjZva2x1WHprMzVV?=
 =?utf-8?B?ZndnSmY4Q1ZTZEpZVFF2ZG1MaENRelUyZDBBVGVid1JoSkZHa0ZsUzRQTDFN?=
 =?utf-8?B?VnMxaUFDUytiKzZRMVQ3SDlRUTlLT0Y5YWtxeW1MS0lPQ1p4NUJrMGN1bnRB?=
 =?utf-8?B?WU5ZK1h3aStzRStBWjA0TUhaV1RBOXNxUWpPb0NPekRnUWxVd2RScE05VUM4?=
 =?utf-8?B?dXhwL3lKVFpia0xIclFmSzJuZ081T3ZjUUFna3cxNm5VV1BFd1hwWGZrYnIw?=
 =?utf-8?B?U0hkY3RWaGREaHdhU3hmbEQwcXIvZytESyt6S0h1cEJERmRLbStvSzE4ZG4x?=
 =?utf-8?B?d0hnL2I0Zisyc1ZlUXNKWk1MK0dzbk1sSmo5ZVFIY01DTVZxWUdIOXpKTlZi?=
 =?utf-8?B?UEhQeForaDVXbFAvanRaK0NwN2htT2JNZEtPbXh2SHN1Z2RyVmVZeEdlWGUx?=
 =?utf-8?B?TFN5dW1aMzVzSmdDeE04WHhDZ3lEWHhwaVV1TUk0WmxDRnUwSGEyM0RWaVY3?=
 =?utf-8?B?UU5UcG40WmlYT1FBRFhCcVltZWJXTG11ZjlLYkcrbmNlU09IaG5Fc2RlZDZp?=
 =?utf-8?B?M1dLUjdoVHovTHRHRUdMdlQ5U3ZLQUd5eU01cUo2dGRoMWJ1aHp2QTN1T0tS?=
 =?utf-8?B?ZWhvRGtFQW1iMU5HSXp2Y1F4a3FQUFhtVm82NDFsYVhuSEVzQmw1ZkNJZWI3?=
 =?utf-8?B?eU9CVGlycmlFR2hwMmpoQ2FvbVNVY2NrdkdTMjh0dWhjd3R3VkVVTTUvQ0x6?=
 =?utf-8?B?R1pERktQWThkbVk2SUV3VkdUZXJDdmxzTmFpZlpvWk45YzVQcFZqZjhua2NV?=
 =?utf-8?B?QWI3N2FmTHk3eTNxZWYzR0FjL1NtVGJLZnE4bjRRS3hUeUpjVXdMV044WENR?=
 =?utf-8?Q?yIgxIfU/T837juYHTn7ZJbYS5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a2cc21-4911-4cd2-fe80-08dc735bb6dc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 14:48:12.9916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RU1fjy2GEjTe9f0GllBBq7MX+aJoN3cBW1aKx30n8/8OFu9SVGmUSdKvNW2y2gnR0HIYtnSLEjfDI/+vdq85gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542
Received-SPF: softfail client-ip=2a01:111:f403:2409::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


On 13/05/2024 17:43, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 5/13/24 16:34, Avihai Horon wrote:
>>
>> On 13/05/2024 17:01, Cédric Le Goater wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 5/9/24 11:09, Avihai Horon wrote:
>>>> Emit VFIO migration QAPI event when a VFIO device changes its 
>>>> migration
>>>> state. This can be used by management applications to get updates 
>>>> on the
>>>> current state of the VFIO device for their own purposes.
>>>>
>>>> A new per VFIO device capability, "migration-events", is added so 
>>>> events
>>>> can be enabled only for the required devices. It is disabled by 
>>>> default.
>>>>
>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>> ---
>>>>   include/hw/vfio/vfio-common.h |  1 +
>>>>   hw/vfio/migration.c           | 56 
>>>> +++++++++++++++++++++++++++++++++--
>>>>   hw/vfio/pci.c                 |  2 ++
>>>>   3 files changed, 56 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/include/hw/vfio/vfio-common.h 
>>>> b/include/hw/vfio/vfio-common.h
>>>> index b9da6c08ef..3ec5f2425e 100644
>>>> --- a/include/hw/vfio/vfio-common.h
>>>> +++ b/include/hw/vfio/vfio-common.h
>>>> @@ -115,6 +115,7 @@ typedef struct VFIODevice {
>>>>       bool no_mmap;
>>>>       bool ram_block_discard_allowed;
>>>>       OnOffAuto enable_migration;
>>>> +    bool migration_events;
>>>>       VFIODeviceOps *ops;
>>>>       unsigned int num_irqs;
>>>>       unsigned int num_regions;
>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>> index 06ae40969b..5a359c4c78 100644
>>>> --- a/hw/vfio/migration.c
>>>> +++ b/hw/vfio/migration.c
>>>> @@ -24,6 +24,7 @@
>>>>   #include "migration/register.h"
>>>>   #include "migration/blocker.h"
>>>>   #include "qapi/error.h"
>>>> +#include "qapi/qapi-events-vfio.h"
>>>>   #include "exec/ramlist.h"
>>>>   #include "exec/ram_addr.h"
>>>>   #include "pci.h"
>>>> @@ -80,6 +81,55 @@ static const char *mig_state_to_str(enum 
>>>> vfio_device_mig_state state)
>>>>       }
>>>>   }
>>>>
>>>> +static VfioMigrationState
>>>> +mig_state_to_qapi_state(enum vfio_device_mig_state state)
>>>> +{
>>>> +    switch (state) {
>>>> +    case VFIO_DEVICE_STATE_STOP:
>>>> +        return QAPI_VFIO_MIGRATION_STATE_STOP;
>>>> +    case VFIO_DEVICE_STATE_RUNNING:
>>>> +        return QAPI_VFIO_MIGRATION_STATE_RUNNING;
>>>> +    case VFIO_DEVICE_STATE_STOP_COPY:
>>>> +        return QAPI_VFIO_MIGRATION_STATE_STOP_COPY;
>>>> +    case VFIO_DEVICE_STATE_RESUMING:
>>>> +        return QAPI_VFIO_MIGRATION_STATE_RESUMING;
>>>> +    case VFIO_DEVICE_STATE_RUNNING_P2P:
>>>> +        return QAPI_VFIO_MIGRATION_STATE_RUNNING_P2P;
>>>> +    case VFIO_DEVICE_STATE_PRE_COPY:
>>>> +        return QAPI_VFIO_MIGRATION_STATE_PRE_COPY;
>>>> +    case VFIO_DEVICE_STATE_PRE_COPY_P2P:
>>>> +        return QAPI_VFIO_MIGRATION_STATE_PRE_COPY_P2P;
>>>> +    default:
>>>> +        g_assert_not_reached();
>>>> +    }
>>>> +}
>>>> +
>>>> +static void vfio_migration_send_event(VFIODevice *vbasedev)
>>>> +{
>>>> +    VFIOMigration *migration = vbasedev->migration;
>>>> +    DeviceState *dev = vbasedev->dev;
>>>> +    g_autofree char *qom_path = NULL;
>>>> +    Object *obj;
>>>> +
>>>> +    if (!vbasedev->migration_events) {
>>>> +        return;
>>>> +    }
>>>
>>> I would add an assert on vbasedev->ops->vfio_get_object
>>>
>>>> +    obj = vbasedev->ops->vfio_get_object(vbasedev);
>>>
>>> and another assert on obj.
>>
>> vfio_migration_init() already checks these:
>>
>>      if (!vbasedev->ops->vfio_get_object) {
>>          return -EINVAL;
>>      }
>>
>>      obj = vbasedev->ops->vfio_get_object(vbasedev);
>>      if (!obj) {
>>          return -EINVAL;
>>      }
>>
>> Do you think these checks in migration init are enough?
>
> I am sure they are today. These extra asserts are to avoid issues if
> the code is moved around or if anyone finds inspiration by reading
> vfio_migration_send_event().
>
Ah, I see your point.

I will add the asserts then.

Thanks.

> Thanks,
>
> C.
>
>
>
>>
>>>
>>>> +    qom_path = object_get_canonical_path(obj);
>>>> +
>>>> +    qapi_event_send_vfio_migration(
>>>> +        dev->id, qom_path, 
>>>> mig_state_to_qapi_state(migration->device_state));
>>>> +}
>>>> +
>>>> +static void set_state(VFIODevice *vbasedev, enum 
>>>> vfio_device_mig_state state)
>>>
>>> to avoid the conflict with vfio_migration_set_state(), let's call it :
>>> vfio_migration_set_device_state() ? We want a 'vfio_migration_' prefix.
>>
>> Sure, I will rename to that.
>>
>> Thanks.
>>
>>>
>>>
>>> Thanks,
>>>
>>> C.
>>>
>>>
>>>
>>>
>>>> +{
>>>> +    VFIOMigration *migration = vbasedev->migration;
>>>> +
>>>> +    migration->device_state = state;
>>>> +    vfio_migration_send_event(vbasedev);
>>>> +}
>>>> +
>>>>   static int vfio_migration_set_state(VFIODevice *vbasedev,
>>>>                                       enum vfio_device_mig_state 
>>>> new_state,
>>>>                                       enum vfio_device_mig_state 
>>>> recover_state)
>>>> @@ -125,12 +175,12 @@ static int 
>>>> vfio_migration_set_state(VFIODevice *vbasedev,
>>>>               goto reset_device;
>>>>           }
>>>>
>>>> -        migration->device_state = recover_state;
>>>> +        set_state(vbasedev, recover_state);
>>>>
>>>>           return ret;
>>>>       }
>>>>
>>>> -    migration->device_state = new_state;
>>>> +    set_state(vbasedev, new_state);
>>>>       if (mig_state->data_fd != -1) {
>>>>           if (migration->data_fd != -1) {
>>>>               /*
>>>> @@ -156,7 +206,7 @@ reset_device:
>>>>                    strerror(errno));
>>>>       }
>>>>
>>>> -    migration->device_state = VFIO_DEVICE_STATE_RUNNING;
>>>> +    set_state(vbasedev, VFIO_DEVICE_STATE_RUNNING);
>>>>
>>>>       return ret;
>>>>   }
>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>> index 64780d1b79..8840602c50 100644
>>>> --- a/hw/vfio/pci.c
>>>> +++ b/hw/vfio/pci.c
>>>> @@ -3362,6 +3362,8 @@ static Property vfio_pci_dev_properties[] = {
>>>>                       VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>>>>       DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>>>>                               vbasedev.enable_migration, 
>>>> ON_OFF_AUTO_AUTO),
>>>> +    DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>>>> +                     vbasedev.migration_events, false),
>>>>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, 
>>>> vbasedev.no_mmap, false),
>>>>       DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
>>>>                        vbasedev.ram_block_discard_allowed, false),
>>>
>>
>

