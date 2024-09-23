Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCE5CF9C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 12:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sshsN-0005gh-Qe; Mon, 23 Sep 2024 08:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1sshsH-0005ey-2M
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 08:09:05 -0400
Received: from mail-dm6nam12on2084.outbound.protection.outlook.com
 ([40.107.243.84] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1sshs1-0001wI-9x
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 08:09:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=es4NI/GsxaZhZVG9FeC0CRJcdQBnAd8XJl1OazwttPHgLBr2g0Z2AECgWScNgchhmDtA7FVIu4Jl1k1V8Vffz2F+GVZ6SmMHEQ4jNDNn8ywfFcULAi2Ai0pd3kQKvTsK+rmoEBxaNOkADJsFcEAXQHVsmcZfSmzMfW0r0NA66cM/blRJOooAjKGZs41tKSAmZ8wh1Wwc9UIgRJ1qZlSAfSoxmBXK5q+Rrt+fN9kW9Xyo6v3V+nBt/gBT80On9WgQ2nHfGg2Z3Ceklu6u/5Ofy5v/4mOGyhiCgopF670wOf+FJP0AsGi63zfeqk8W92JZAIpYbo7Ubli8/D2YuraKnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUygg+VT+196HRytNrZDrnq2LSt2JAflFoLpmeDxqNI=;
 b=okm6yklg4N3qXF6W7y/VwoWesaUZW8Ef0BS9IgvfuOfyMieAA86w6OBKSAWBSCdEdtFXUNWx8B2HEq/4euGoxoCpZPqUSUaTQXfvC7jOxH2nrgu1GMo2Juck+QFzc8huAHDyuMPpnxl/i11IsXav26OA2cXZW+Y0Pp3p0ICpQWvhVwYjrKQn0BOGGg0vz46xKPDTiEssLoyj1sVz8eenRPdiZxIOn+OAWr2sR6wmUznBHlkUlBuZth8BLMcULOfL26bwGXrcCM9ou/wi4/d1pU0LYWnTR6dah5BgzFFtQqy+Ni6lvcyazmMx33KxR8grT2OtK5ThWaXbCduLFTblSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUygg+VT+196HRytNrZDrnq2LSt2JAflFoLpmeDxqNI=;
 b=UqaL/0Axc0FJwE7Ym+3Gifq8qrozr8HPWUMOIytjrz1nJvNZeWjcXbVgvFWsUitIsLBcAvHKTVBQIpo2FDQROWypL1IYc5gcQRCUiTkM3u8KMzhHB2a9cv/G/7VNlstA8eS5X485xS81tVQCXkQpEfWUUQCo+qULBkft504oTZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11)
 by SA1PR12MB9247.namprd12.prod.outlook.com (2603:10b6:806:3af::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 12:03:42 +0000
Received: from CY5PR12MB6323.namprd12.prod.outlook.com
 ([fe80::2300:2257:1877:4750]) by CY5PR12MB6323.namprd12.prod.outlook.com
 ([fe80::2300:2257:1877:4750%7]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 12:03:42 +0000
Message-ID: <bbac658e-e041-00b4-fa66-3ff4fc93af62@amd.com>
Date: Mon, 23 Sep 2024 17:33:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 4/5] amd_iommu: Send notification when invaldate
 interrupt entry cache
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, joao.m.martins@oracle.com,
 Suravee.Suthikulpanit@amd.com, vasant.hegde@amd.com, mtosatti@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20240916143116.169693-1-santosh.shukla@amd.com>
 <20240916143116.169693-5-santosh.shukla@amd.com>
 <511e4312-2dc5-45b0-ae54-1712b2e599d2@oracle.com>
From: "Shukla, Santosh" <santosh.shukla@amd.com>
In-Reply-To: <511e4312-2dc5-45b0-ae54-1712b2e599d2@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0191.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::18) To CY5PR12MB6323.namprd12.prod.outlook.com
 (2603:10b6:930:20::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6323:EE_|SA1PR12MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: dd8bb79e-bb4b-4267-3a6f-08dcdbc7c445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlF2dHd6d0tYVlZGMHIyOWlBM2tDSS81ZENIei8rSVJraFVQMmYyVEluSzB4?=
 =?utf-8?B?bnFaR0RGejFiYTJGT21yQTBpdTUvUUhVWEVucWQ3TnZvaXc5ekZVNzhnbWJ0?=
 =?utf-8?B?WkVwT2ZSWUZHQzRkMysvOUpQOEtVR2pLTDhtNjJZRDNGNXpaV1ZqUklJMWVx?=
 =?utf-8?B?SXQwWlBQK1kvN3o2UXl2cDNtTHkxMmU4aStrczczQVc1djlWZXVPODByekVi?=
 =?utf-8?B?Z2NycXovMWZYZGFHaE9hdW9PRGpsSitUMXh6ZHh1SkE1NDFoWjBHQjE1eDQ3?=
 =?utf-8?B?Ry9ackN2d0MxUURsaU9LVEVBMUdUbUdKYm0rWnl2bmxFNXFSVXhNMk92MXlC?=
 =?utf-8?B?VDFsRStTN2h1dHBlYmNuQ1N1TmtrZFFpNjhadU1vUzZpZThkbHdSeUYxZGJr?=
 =?utf-8?B?T3A5d2JZOU1RT3dWbnlORVVTVi95MXo4ZnR4VnVtaVplaHpHTDJqdk1tc3Bt?=
 =?utf-8?B?UDh1VEwrOEJzaEp6NGZDWlRnK204Nmo2Y2NkMm5rMjYrNFNCa3dDd0hnN3Vr?=
 =?utf-8?B?bzg0NEpSSWNwWHFKRHlZMmp6bVZZK0JYdXlobWM4WUo5SGxGRGhJZkFQbjVT?=
 =?utf-8?B?d1FMVi90a0RRU3lwNEEzUEF5QXBMYWNzSS9iNWR6L01Sa2I0eERKV0drYms1?=
 =?utf-8?B?MWkyZnN3RUdKYmF4dXB0bkRyUW1rSnNDcGx0K25Od2xvUC91ek5OSm5BekNZ?=
 =?utf-8?B?WE5WYW82MlYrNzM1andQQ2dhUmRINjVUaFVHcVlJYUptdUtUNFc5K0dUNWpU?=
 =?utf-8?B?di9NaFJSSHZFWnVTRkpuZUlSaFo1bEhZUkVXTzJPR3NOZkZMQkVpRUVYWFBr?=
 =?utf-8?B?ZXd3dThlMmpBa2tKZ0VkN0pZY1daVmI1QXpFeXowL3ZQZ3ZSVCtRVFAyWDVK?=
 =?utf-8?B?NGpEMU5zUm42cTRZSUl0Qy9xRWpzUkdMY29ZQjB6ZVBCWEtJN2tLUU1vWVFv?=
 =?utf-8?B?Um1wUEFTU0lGdUZDWTNHUWc2SWdPVGZHN0pqaGdPdG13ZE8wc3FMZjNYYng0?=
 =?utf-8?B?R2J2ZkJBTWxUQTRYTW1JUnBaL3VIdjJKeERuL3NZVGs3WlNVYWZGSGhmdUF5?=
 =?utf-8?B?Vnc4SDZEK2h1aGxRL2FnWjBVVWtGTE1TL0pTUjdMM0FZb2VyTFZiMk9WLy9I?=
 =?utf-8?B?ZzIzMUtSYzkvQ2VmMEZHTnRBSkZzWW8zb1Z5cDdoY0ZVb0tQcVJTVWpJK2tN?=
 =?utf-8?B?ekZNRGdUcDU5MGZqQnVVOFVrbUhIcmJwZjZ2Z2pVZUFrNjVGRnp2NWNKMVNn?=
 =?utf-8?B?RnMrT1hSRmxwWS85YjJXQ2JhSFRVZlZVWTdoZzg3VUNlMkZBVTF3aEFOd2Jo?=
 =?utf-8?B?dVo5cDJNc2NPbk1JV2k2T2NMZ1NwU0RMeVhqWWxucmpULzVSYjBSVlRtZ3A5?=
 =?utf-8?B?bGEvWVU3WDFTd0R0ZHcvL1ZsTWVURitIaUtWeTVFUWxBQkxtUy96NUx0VmhR?=
 =?utf-8?B?Rndhb2h2S2J2bXJ1aXgrVFk5eWowcFZKSHdZY3VlakJJR0Y0QVBsTUJhMmIr?=
 =?utf-8?B?SlVyaFdCQWljemg5aHhWbzZ1QlM2SHZ6R1ZaeWtnUWNWcWRYNkVBSFpjaUJK?=
 =?utf-8?B?RzRSdEhOdCs2WSs4dElHMEJaUmY5dUh5enZmY1dkZ0w3T0NUbFhOcGVncUVV?=
 =?utf-8?B?Tk9yQmdOU2JDSW9sS1g3NVIvUGNCa0s4WFJNcHIxemZQd3FFR0lOcGEzZHY0?=
 =?utf-8?B?UFAzK0tldFJ3ZXJramx1dFdDcHFiQVYxaVpJZVhCUGlGMlB4UVFoNUg0REJZ?=
 =?utf-8?B?UjJ2SmYvVVB0ZWdXakdtZHJyYVJiTFV5dks4cnJiK2JOOGFQTy9SeHZZRzM2?=
 =?utf-8?B?Slc4SFNia1EzYyt5WHdXZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6323.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjNGTG9wZ3Jaci95M3VUNG51dUY3L3l5ZW1MckVBN0IzWXJwY1ZYZ3V0dW1O?=
 =?utf-8?B?TkJ3M1g5UkZ6ZDlQQnhJRVU3ak1VbEpvWFVnclQwdXUvS0Z1OXYvQlJaeHl5?=
 =?utf-8?B?UTIySkh4OERvYVVHVXFZWWtISjJVZkJNandOMVYwV2hRUTdoOVU2TlhNVnFa?=
 =?utf-8?B?cVh6czZ0YVpMWDA0TFNUZGFlcFFZMlRqRjRKOVI3UkpWZVJNczVORW9vMjlB?=
 =?utf-8?B?emhwcWhKbVBoUjhWc1oyYTlER1lrUmJJRGhlN1Z4NVAycW5pZlc3LzhvOU1t?=
 =?utf-8?B?TmJFSUhydWM4dW1PS3REWHJVSEJKY1FHZWRVQmw3dSsxMkp1bE5RVDdHVVRK?=
 =?utf-8?B?aVBITi9teUZQengxZlV1TnBmQ1U0dkhweTVFWDdNM0k0aUt5VExDa1g5dHJk?=
 =?utf-8?B?ZzRNQkU2VzAzV2dMVk52bVBDTmt0S1VEUGJKTGVzajA4V2lpSjhoaTlscVBL?=
 =?utf-8?B?NXhVOE05T1h3dmN0TmNSUGtrNzNDbjR3VlZmQ3F6OW9UdkVnUjBOVlVEQk4v?=
 =?utf-8?B?aXZqWWtkZUQ2WnBiYnBQR2IzZStPU3BXOEllcDQvZ0Rkd2I0VGRJcm5EOG15?=
 =?utf-8?B?UlRWb2JJc0pYTEtyZmRZTGcvekNuQUpTL240MjlsTDBaNGhGVmthY2c5Mjcy?=
 =?utf-8?B?WDFNWTVIYnVoN0ZXeDBIbm9HcXBzdFZRSWd2c0F3Smc4L1IrYWRBeWVzSTFy?=
 =?utf-8?B?V0Erc0lKdWsrVE53bUIwZEQwQWEyVVBHUWE3cFhicllKUWNYOXVVdkN5VmUz?=
 =?utf-8?B?YnpqdkhrWTdSZVhPbU1YRCtaRTZiN01jOTMwWW9FZWRZWmlhcmgvYTEwUUdT?=
 =?utf-8?B?RWRyWi90WVc4UUVMRStPNXYrMG93djNhVU1NbngzQjI2Nm5VUVFWMlRqN1JM?=
 =?utf-8?B?MHNCVnFJdHBYSkdSZ0xrbWdsbEV0NzFrc21GcGFXKzBqZmpDd3d2dTk4aUxS?=
 =?utf-8?B?WkthajEvZzNmMlo4THNFVzFpaEFNQWsweGZJR09LSlBVUk84alkxS25ZSmk0?=
 =?utf-8?B?ZjVFbnpDWC84SnVGdDhLWi9Fb3FiK0JFZDc1UlFwYlJFK1B1Y1dxbDR4ckNX?=
 =?utf-8?B?bE1ad0VwLzRwdmNhSmlESlZEUDh4cXFoVUJVYTQ0YnljYTQ4dmxiV1prRG9D?=
 =?utf-8?B?TURrUzhGUjhSSTJUMGN4TzZ6dDQrN05FYzNmMm9mNlBidlFPY0tLZkNydC80?=
 =?utf-8?B?dVlXUXVyTWF1eXRLS0tXTFAxblp2NE80NGFXQlJOcWloVjR5dEZzTTJPMnJm?=
 =?utf-8?B?UmlxZDBZVjFFOFEwaGxzK2Rkd3ZxejlMbURQeGNucGEwK2QzV3p6RlB4dXFr?=
 =?utf-8?B?MFZGcTVTd1FTalRBbUZEWlkzNUoxa0NCMk9KZS8rT3RvMGJYWUlwajQrMFZz?=
 =?utf-8?B?ODBIMnUxa2xpaDIvS21ZcTVPL3JvcGozWWdtcHM5VkRTdk5HYWU3OEQ1dHFn?=
 =?utf-8?B?ajRzZ2J0aFZLci9EbXNaUFpYcEpScjBXTTc3bll6Z1ZPOGljd0NDeGd4bDVm?=
 =?utf-8?B?Vkgyd25SNnozb0FSTHZ5YlRkMjNmbENDb1F6VUtoalRWZjBteHpqdnBzYU9K?=
 =?utf-8?B?N3BLWFdVU3hsbkZRTFM3UjFnVmZQVjEzQ2hZOEs1YUcyV1hBdUpjdm8xZWtR?=
 =?utf-8?B?eEZxS3lPMlA5SXByTzBzcWh3ZElmcXB3SG9za2ZKR2M0TWZNQlBqbkM5MTg4?=
 =?utf-8?B?LzkxWGxvbWhaemJ0anNCcWJlVDFsSUFLb3FqZnVBYnllaVpIZHVIc1hJUlZP?=
 =?utf-8?B?eWIzSHRKRFNSVUdkNlFJSGI0blJkSE41ZEtZeVR0aTV6YU95QXRDU1lYSzVJ?=
 =?utf-8?B?di80VlM5Y3BrbGJLU1pIdGhGVENjckVuL2JKWXlhbkJWUUx5TURqUUV6cnJS?=
 =?utf-8?B?UUlYa1F2dy82YURCQkhsWFp5QXNrM0Zudk5QWmxoblVKazdNVVFZaFEveU1h?=
 =?utf-8?B?MlBIZXlDWUNuTTNDY01BK2ZxbStnaXZ0OWhqMG53VXJPd0pXZXZqb0phT2d1?=
 =?utf-8?B?a2xONDdQRXVVQUQxSHVqZC9kdTlnaFNNWlkrRHIxN25ZYU5PSWhDaWdBT0ZD?=
 =?utf-8?B?blV1WlZtM3BLamphSXlkckJka1NRMFdBM0ZBdE5zTkNhcDJCMDJURjNmQW9k?=
 =?utf-8?Q?Ds5dax3LMK5JzI7r5zO9r9VsJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8bb79e-bb4b-4267-3a6f-08dcdbc7c445
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6323.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 12:03:42.1249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3t8fOdqM59w/xD+8Ko163Jp8h4mxGJOVc3N3neXYV2GLHxzrHlPeypcyQMxw/YpjMna/u0OBIXPFgEJKfq/r3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9247
Received-SPF: permerror client-ip=40.107.243.84;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, NICE_REPLY_A=-1.417, SPF_HELO_PASS=-0.001,
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



On 9/21/2024 1:56 AM, Alejandro Jimenez wrote:
> In subject:
> s/invaldate/invalidate/
> 
> On 9/16/24 10:31, Santosh Shukla wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> In order to support AMD IOMMU interrupt remapping emulation with PCI
>> pass-through devices, QEMU needs to notify VFIO when guest IOMMU driver
>> updates and invalidate the guest interrupt remapping table (IRT), and
>> communicate information so that the host IOMMU driver can update
>> the shadowed interrupt remapping table in the host IOMMU.
>>
>> Therefore, send notification when guet
> 
> s/guet/guest
> 
> Alejandro

V3. Thanks

> 
>  IOMMU emulates the IRT invalidation
>> commands.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
>> ---
>>   hw/i386/amd_iommu.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 24fcd561345c..9095146525e6 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -431,6 +431,12 @@ static void amdvi_complete_ppr(AMDVIState *s, uint64_t *cmd)
>>       trace_amdvi_ppr_exec();
>>   }
>>   +static void amdvi_intremap_inval_notify_all(AMDVIState *s, bool global,
>> +                               uint32_t index, uint32_t mask)
>> +{
>> +    x86_iommu_iec_notify_all(X86_IOMMU_DEVICE(s), global, index, mask);
>> +}
>> +
>>   static void amdvi_inval_all(AMDVIState *s, uint64_t *cmd)
>>   {
>>       if (extract64(cmd[0], 0, 60) || cmd[1]) {
>> @@ -438,6 +444,9 @@ static void amdvi_inval_all(AMDVIState *s, uint64_t *cmd)
>>                                      s->cmdbuf + s->cmdbuf_head);
>>       }
>>   +    /* Notify global invalidation */
>> +    amdvi_intremap_inval_notify_all(s, true, 0, 0);
>> +
>>       amdvi_iotlb_reset(s);
>>       trace_amdvi_all_inval();
>>   }
>> @@ -486,6 +495,9 @@ static void amdvi_inval_inttable(AMDVIState *s, uint64_t *cmd)
>>           return;
>>       }
>>   +    /* Notify global invalidation */
>> +    amdvi_intremap_inval_notify_all(s, true, 0, 0);
>> +
>>       trace_amdvi_intr_inval();
>>   }
>>   

