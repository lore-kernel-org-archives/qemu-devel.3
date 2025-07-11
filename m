Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D37CC83F1D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAX0-0006FV-FB; Fri, 11 Jul 2025 05:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAWx-0006CH-7d
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:58:59 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAWu-0004rQ-TO
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:58:58 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B88p8k000310;
 Fri, 11 Jul 2025 02:58:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=wXiY4HEGd2b4u+bVNb3QbdJVU9t/2vJpec61JjaFb
 Ds=; b=24KikO1ENc5Ch64fQjQSs4+n4/oOgSq+0GAkhNmKohCICbceea4t0y8tj
 BsbHTtLFFVWzO/ATAmCMC1lPtMwoIw5WRPezmVmeB3NWHHAbu9M8CAWAITedyy80
 Y1ZQymWIXmn58QXFV8+Z3y+X4I6N1bh6zzzWUuiIOOM7GKrBfPORJ0HwdIGeBcWA
 /sVcX5GCiKEhDJDx221I9HOeDuDjpwAZ8pWVMNNb8MHw3B815iGf2xzH2JwPv2en
 CWbIfaYkkavK/sNSPRCR6dtrSrsQWV8nLI6z8wX6RFSHvFFpaxb+7ekPpJdqNAT6
 cMXHMIY9Y2SaE/3wIqZfjrIv95ipQ==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2106.outbound.protection.outlook.com [40.107.101.106])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47q3k38m32-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 02:58:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npluoK/Jffxq5V72UHGEpmzIAJT4N74H1GgeJVFk/ACYKZTMiqT8uyLOu+WPbJXDQtkVGJRSxfJ3ZDARla3RZXdKq33k/khaPwSdu35OEkPwpak+lXvMcVfLCiwmMbm9ubEqrgUdD7hJGfR98lir425WXhk94vSxyw3LDn6Vf8UWB1VZMrrVzeAuj5pnKe7avlPOEncHJFhzYl+FrP6YdFY4Z8Y/fISb72UOtDJObqiSipTlJZ65ZLj6Yr+dQInjv+ZuzeVKli7hfhA6OYVZszlaT5lTcsEgFS6+lHTT443Q2rL+MZDdBh9fmDYYEvMK5WibBcd0N8dZgdTsmlbdaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXiY4HEGd2b4u+bVNb3QbdJVU9t/2vJpec61JjaFbDs=;
 b=b3Qk9HUpunvyz8XEUDsY5DTsZJ5eHzKfD6y64A2mUmHJWh0oGMyXOls1uNZFUKBN0vA4FvyoJ3ROK4XfpCZIuF0BHFaZsCrXqrSZpDj+5w8IjCWl6K3CrHCcTkOqB8hL9GI0FpUoz86d8ky3SkS/SQSOaIOLCEqdY8ujtafv/TFh2DCcJd6bRgK1vkf6ya4Gv9YbMl2P7sN1m66L6YvvXQWq0tGAIpowp37MvsRnv6RHGgWy8rdv/6YxnzO5ZetY/r9pMdlshUa9VeF/pgk9fvSqKjtyMx96D3Ax6xsHua1IFGN6pWW8vBXWixDTRXvZjOGzTAV05S5v23CWU33ECg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXiY4HEGd2b4u+bVNb3QbdJVU9t/2vJpec61JjaFbDs=;
 b=WftRVFCqQzkt1omKyDSjaohsnWteF8t5A7XTM3DwZJMHnACzaSvGu5NTUocTTUpFfI648upALWRtJ75ZX66lzjkI8+ZKoXW5Q/FX4sjyii0bOknXQPihW5XyKYYcEH+j/bSaTpwjnc09UgOWHRkkfedvRLXw8j25pGDwB8TVK2WdqPANGgOwBlWHzZ3YsJrAjoovXFAYA1/qI8MhNIFEXUtP32yALpsdiqpsw5yPa+dWbNjKozVvgamUAfIpKaT5bOkVgbc5YqyC+R3QC64LEXnTpZjNhG3GOHq5fR8iQeS/0TURLFawIR/ca9T58fd79KpH9mPyzF+8q/ex7O7Tqg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB7918.namprd02.prod.outlook.com (2603:10b6:408:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 09:58:52 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 09:58:52 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 10/19] hw/i386/pc_piix.c: hardcode hole64_size to 0 in
 pc_init_isa()
Date: Fri, 11 Jul 2025 10:57:12 +0100
Message-ID: <20250711095812.543857-11-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711095812.543857-1-mark.caveayland@nutanix.com>
References: <20250711095812.543857-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0265.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: 730288af-acc8-4607-9b40-08ddc0618a30
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1ByQWNtckdFS2lPMXplZHB4NnR3L2ExQjJ4b0hvb1ZsWVQxekI3MjZ0My9J?=
 =?utf-8?B?Ylg3UzVMUnozTW5SbUp6TzEzMFdNWVdoOWpReks0VEtXb1RzS1hxYnVvNkkr?=
 =?utf-8?B?SHF4dE9XejNYUXo1OTcxMDVmRk16ZVlBUDJWNjBreXVNaGdaR1BJWlZPaStR?=
 =?utf-8?B?S2t5dmFSSElmY3pxUmZ0QnpybWY3azd1ckI0ZkxaQ3RRUVlqbWxLdnF3MXVV?=
 =?utf-8?B?NnE2cTl1SldCZlZvWFMxelV5N0lpaVVyNkk0c1kxK0pPN1Jmdm43QUJyMnNZ?=
 =?utf-8?B?ZnFYYVBxbVRnNm9IZHN4RitXRGcrdXI2b2JvWElKV2cwTUpzOTRiYkszbGVj?=
 =?utf-8?B?a2RYbHI4by91SjJvUUZFcHNXdzUrVjc5NU5rU1p0c1Brd0lQc1ZJSTcrVHdJ?=
 =?utf-8?B?UXNlRzJXYVlGeXJqclc0cmd5bSs3d09mSDM5SDZtTjlhUzkrd0RKc242RTUr?=
 =?utf-8?B?TUQyWkV4TWUxRGszQVcrcXh6TnJ1NHlOYlRCcE15MUpGMi9OOEZDbTcwZmgz?=
 =?utf-8?B?WnJaS0h5RkxVU3V5U09xMlZsa0xucm53V1JpdXdWZjkzaU5ncEdtWjJHVmZ1?=
 =?utf-8?B?Y2xXRHlXRlNhdHFOYVhvRmQyUDdhTGpTa2tXTUc4bDZHTTZPUEI4aWxjYTNZ?=
 =?utf-8?B?TnZVSVFqUDBSUGJvUEZqUVlQYzMvcHpObUpOeUxqbHBmcy9ucUJlVExWL1VO?=
 =?utf-8?B?STZPNXhQVVEzdHI5K0wwMWkxcFJ4b1p5Q2YwMFMrVU5md1BVaGU2YUxoZFVH?=
 =?utf-8?B?UktvbXkybFdWb3ZVY1lqZHJyWjhsaFZucGx1K1pKbjBVQnZoVGRJcXVyRHY4?=
 =?utf-8?B?Rzl4WlcvZityZ1lHQTd2Vzc2dm1BZ0JvSWFFVzkvQ0NmcDVmL0FGczQ4bDEv?=
 =?utf-8?B?Unl6UnBQbVQvT3hjdGxOOXFEOVYrTUtDY2E3VjUvTFJmRWloYjRNaHhITHBE?=
 =?utf-8?B?cWR6OWs1NkpJRGZodCtZWk9EMXg3a0s2eXllSDFnc24wNVh2c0dWWGRjOXFh?=
 =?utf-8?B?REZzOHR2cnRXSHJjQkhxendkVkVHZzN1ZkRDVnU1andYRnExeW1ib0VQZUNW?=
 =?utf-8?B?a2hKRy92V2RMZXFCTmluMXBwYjNEejZEQVVTOE95RmRHRm14TFJjbndocmt0?=
 =?utf-8?B?RFNDcm9KbEV3YjdqVEFHcWlNUjdsaEpoQjNiQi9KNzdCNytZRHNBK1VjcTlu?=
 =?utf-8?B?dGg1YVpzNHhUR1JiVWdaMjgyTEljRSt2WkdsNjJNeWFoNjhRam8xME91eUZi?=
 =?utf-8?B?dU1IeitDbWF3RURpS0g0WWhvUzlFNFpub01RdEZCT3c1TDhFUUpGZW9SWnNE?=
 =?utf-8?B?ZTE0SVJQU1lGN2FERkt2djZhWFNEdUhFYWtIY0hpUm10cHBRYldvSWlzVk5q?=
 =?utf-8?B?VC94aC9YY01OZzBEWXNIZ1owS2xWTHZhRC9ObTluYkYvSGpOK3lIbjAyVTJE?=
 =?utf-8?B?dnh0QW9obHJSQVB5cndCVEMxeHh6blFzOVRmUEpjbGhtTjdKbWdFckpBdXBv?=
 =?utf-8?B?ODZOQk5nRnhmczJKY0owY2ZiU05VekN6aVlPN1NvNHNvOTl5ZkdzMmFHV29C?=
 =?utf-8?B?V3FtYXZUTDhNVk5sbG1USlZPbytYQmVHT3FsT2dvN2FTajBVclk4bm1Qa29B?=
 =?utf-8?B?YWtGMzFrd1pad2wwS21Jcmw0YmNILy9NdFV0MEFXNFVVVFd3bUdnUHR5M1NW?=
 =?utf-8?B?Y041cXNxWVBKU2JjT24rcHpxRG5nSjEyam93M0duTTdMbGs5NUlBL3g0aU1z?=
 =?utf-8?B?aFlUU0k0NFhMS2szbzlNNW9PL3BiMXAyd3YvVlFVVTVzZy9wT0ExL2JRZXVO?=
 =?utf-8?B?T1lJMThiaGlGbUNIaUphVTh2ZG9GV0hibWRuMVVtSkhtZ3pmZWNVTFZIbXhM?=
 =?utf-8?B?b0ZrOTIybHg0V1hJcUFaNTlhWGZDRTRuWWhCZEpPTzNBTW5hREVBWE1jZ0Ux?=
 =?utf-8?Q?RJOcXZy/YiM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU1LTkJrWWN6Tm5wZHhIMURpeDY3S0gwZnFoTzY0Yzk3a0xaLzlLcVFRcWU5?=
 =?utf-8?B?ek9nSWt0b1RPdXVvZU10MXVFYUxNcmk2OThZeW5uMHp1WnlPSjZ2VFNuU1pp?=
 =?utf-8?B?WTVFS2pKTU9KNi9odmFYVTl5QzZaVTNHOTk4YUdYMDF2Z3g4ZjhGdUliZ0xU?=
 =?utf-8?B?OGJIMHlya3JzbnpaZ0dvOFh4ZkduYUxSdjBQZitjMjVsNnlSWEVGNDJpbDlt?=
 =?utf-8?B?ajFrR2EwUFZlVzUxRlNzbndWdllIcm1IbDdGM0dHaGsyQzYzcXR4ZzBMWE8x?=
 =?utf-8?B?TU95UXZySW9SRFl0elBPUGNmb2dHSEtTY0lnc3Izek80WGVpb0ovWEJpMDFi?=
 =?utf-8?B?emZyWHMyTHNNZ25CckRVU1ZRbFg2ZUFNQzFWakxtN3FDRFUvejNOTzllVWJD?=
 =?utf-8?B?Z25TL2MwVGNJaW9IRkJ0MW9RSXk4SCtzTWtlSkYrTzRHVUxmcmlTQ0JhU21X?=
 =?utf-8?B?SENxZ1M0Ti9vdlB3QkZ4SWpaUFJnYmZ2THd3ZmN6UDI1dlpRcHdnSEIyV3oz?=
 =?utf-8?B?TWE3RmUwbFN5T05KbnNnclRLRWtnR00zRFdZUXJ1SmFYOXRsVVU2SzQ3bkE3?=
 =?utf-8?B?ZUlQQVJDZjF2VXVGbVBzMVZsTW9TRHBWa3c0WjhCcEhSdkFVNVVISVFEUEpl?=
 =?utf-8?B?d2R3UVYxaGRuZkNob2dLNU9RZWkyK2xIN2tUczY1bmsrOXc4d1YyTWFoay9T?=
 =?utf-8?B?aGIvV2FHdlJxTjhJN1prejN2RzRZNHZNVkNHeXdGUVowRXM4TlJ1VEdrdXgr?=
 =?utf-8?B?cXc1OThSVEo1SUJTT3k5OUZXRFM1OFI5Rk51Y1B3NUI2NDRUTkRrYjFNMW56?=
 =?utf-8?B?UElOVmI5MUZ1Y3VWN3Bqd0I0Q2VmZW1OVExQTHBLUUxjNDZSdTZOdEhGWGxj?=
 =?utf-8?B?YjRUR0I5L2lUZHBPMVliNlpTamZhdDlrMlpENUw2ZWo5RFZNdFo5TEgzWC90?=
 =?utf-8?B?cElGL1VvUjFpMVBCUnlpcURPK3A1WXhpWHpsSHN0QWhqQ0hJc3NwZm1uY2cz?=
 =?utf-8?B?Vy9DZ1I2WlFtZXV4SmVqVHF5TTFMRGw0NnJ3b2gzOC9oZDJuWXo5bVhzSFlG?=
 =?utf-8?B?NEJmU2RIeExYQ0lvelh0S0lqakpjVDBDT3JKby9QaGI1L2JuaFA0dU94L0M1?=
 =?utf-8?B?YlNMUkpjMXN2Q3ZLZlMyVzdXd1V3QlIva0F3bXNlaHp0M2JPeVlkN3dLSERr?=
 =?utf-8?B?QzZRWGR0NzZ3QVJkYUpzZFMrbUlmbEkzanBXVHVYMkpUS1JmdVlDeGtiek9i?=
 =?utf-8?B?R0lwa0RtdktoSnVaYkNiNVdnbVRENUpFWlM4ZUt6RzJjTmo4dWMreXkySXla?=
 =?utf-8?B?dldNREZtT0JWNmYvU200UDFEaEMwSFhOdENDT1FEei8zTGdzVXJNYWl0b3JP?=
 =?utf-8?B?MVN4MVRTdVRnazNsc2oyUXUybzFURFVJUnNZT05Kc1o3VDdXcUlWdjdSY0l5?=
 =?utf-8?B?bzlFMDJGUFMxYXgxa0Z1OWpUSUs2NGc3SEoxeEhsVDQ4NFdSWXJQY2Zvdjgw?=
 =?utf-8?B?WmdHSFc1OEVXdDhpNE4rb1lpVlBVYmg3cFprTktBT2lmK1FEOXl3N004Q1Vq?=
 =?utf-8?B?OEc1b0NDV2UvTmhyc0RHZXR5bFJzd2Q4eGNpS09nWFFhTUkvTng1ZVJRZ2Fr?=
 =?utf-8?B?NVZwZnloNDlhbklMaTMxMWFkR3hZOEMvOWZERlZBUi9XT3UrdHowcU91dmZZ?=
 =?utf-8?B?RDJmdUtKS1NDUDN0ZXlVdUdTN01MNnZ4eHBxaThJcjI5OUcwVmpJUTZ5eEtT?=
 =?utf-8?B?UFQxaEJLVjh6dlRnN1JiU2hmeElOTkU3TmkrQW1PamZtbHovdlVsUHY4eThU?=
 =?utf-8?B?ckRGbmNsU1B3VFk0aVljNXFzTmRPN3hGcTZ4WXNRdkp3UGI4U01xNGowQWQv?=
 =?utf-8?B?bjhnTitXOWNMbnRJTkNUQVNicUFrZ3piWDJ1dFVJeFV5UG0wZHhvV0s2U3lv?=
 =?utf-8?B?UXlVTkl1RjBSNnlCYit1dy8zaVhKSEduYzVFT2dpVFRScVJZS042NnY2Mnhz?=
 =?utf-8?B?ZktCTWs3bXRhMVlId3llTWUrZHQ3bmJLVDZpNUdOUFVNdXhaNUIvUktrS1NJ?=
 =?utf-8?B?c0UwRHovRlJKMTVveUQydS9lUlpwWnFJVDJWNTJDTHVtdkdMSkEyYkh2VW03?=
 =?utf-8?B?ZGRqeTRuYmFUWnpDclEvUnJWd3Y0eHFRVG1HSnJJTzZPcjFkZTlPak9aSHMz?=
 =?utf-8?B?MEdUNnFHd3NhekFUUVBhdmVTVHdCWXZpaEFCNXhHTlFORjJqYlJnNTUwalV2?=
 =?utf-8?B?QnI4Ujlidm1VYXlTSGFCRDhZQ1V3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730288af-acc8-4607-9b40-08ddc0618a30
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:58:52.0063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ku5nKWf4DHrAVUe0JVnYODHFmO6qpy9QTt6V6YiOVLlr52eb++tUQH9ImQxMC4TKmTkGICzlo7/mRMsmufLKR6Bfb4qhukyjOwTCG0Imy3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7918
X-Authority-Analysis: v=2.4 cv=UNDdHDfy c=1 sm=1 tr=0 ts=6870e05f cx=c_pps
 a=zW83crQ9oS5yqOJib3wKzA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=aqeCdxMHYQgX1PSeTiMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 1bUVydqslX1T-DP_pus0h6bQ-sVNyXFd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MCBTYWx0ZWRfXwPMHoNaBQlGx
 Z9J0JNYPfBmy+UcYAVWD14bCV1dYGhMubdFRX74Yd8tuDHJVaFs9QbrWf411S0NfIN/vHJat+V3
 UcePPKV/u4iodTSSOa/Dllfo+KNSJaie55FFv8D/z4pidC4lnrHFbvpQdsPnzwwMrj8T7LoMn/p
 sAY0rsKJQ32vwzi2i5vLi7oj0GuptdNKsYX2Xw4WKih02KUtRPIaFD9GLHMGQ/3LE3uqoMKzyiG
 YTHHXaRjrysxo1huFd+rMdDVwLyzoSJ0yjT55H+TwWxJbO0/KLab7lfSioh9mzQ3fdWeWllsx9H
 WxAtrbb/3SnW7NwgxFk/8KA+1r/8P0Sd4VealvSTFg1g6LDa/77l2F9vUJ/rA1Yvfd/MAwbHcOu
 bzKbzWyt9+RlzRH7PlKE2kgbmoLC6AyoRgXOMZBNxXYiQNbnU9Js1GZRkBwj6vQdb/L7TJ11
X-Proofpoint-GUID: 1bUVydqslX1T-DP_pus0h6bQ-sVNyXFd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

All isapc machines must have 32-bit CPUs and have no PCI 64-bit hole so it can be
hardcoded to 0.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index fbd9500061..f64588f01c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -426,7 +426,6 @@ static void pc_init_isa(MachineState *machine)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
-    uint64_t hole64_size = 0;
 
     /*
      * There is no RAM split for the isapc machine
@@ -462,7 +461,7 @@ static void pc_init_isa(MachineState *machine)
 
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
+        pc_memory_init(pcms, system_memory, rom_memory, 0);
     } else {
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
-- 
2.43.0


