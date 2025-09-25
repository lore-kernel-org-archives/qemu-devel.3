Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B88CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kE7-0006dq-2p; Thu, 25 Sep 2025 07:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDI-0006RZ-E7; Thu, 25 Sep 2025 07:32:41 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kD7-0008Ip-B3; Thu, 25 Sep 2025 07:32:38 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58PAZsel1850379; Thu, 25 Sep 2025 04:32:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=GTwgUDBREkbofu3wCUWh9LI2+aoGCE3FkmFF8JuJS
 Mc=; b=Zfr1qB4Ma4kbE6n5iWecen7Y3TOwQBicZ0f/RO3yNEVaxuxI9X4LlZQ3Z
 Mb976XXDHLX7bS6oHDC5LegfjmAv7O7xGFD/RA6EgUnywCaDpuS+X3vylRyb6Hox
 lWmuvDgJ3W4NrFKPg1MwLlChSjWcz1MnIblAJYFYRHRtEsJQeEPC55XqHGp4Ao4H
 XpMBB4prR9wZeHSEYP+fK0BO3+Dpmh1mQYIu60jk850TA/rVSQgshKXrnJ2xcDL7
 OIlkJU2AhbEIW33QdMYzt6b1FcsFq2Rvq+EnDsW4pLFt7g8Dnb0wsUOg516wmepg
 BYwwPH/iCcgrO67NPfDyOESpE8mRg==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021076.outbound.protection.outlook.com [52.101.62.76])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49cgsjavdx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:32:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbsmK0sDAXXgSITLGvXXqS6qFv5WOm+WQOO0/3jzb/vmVX0VTol5xBTgVc9VcBqsZLdDdqzZCxim4Tu4D02XARehsC8x7iLxABAsbA0qPIm2zsw7iAYnL0Houev5JBbn/ZFCMO14TFjzlIAWKvRDCHQmpz3D9ulXgjhpLX7JfADzUK/ugCGiOKLsOaSyAVYa1ASdfLy8GDrYxE5tgDxJzkJ+VEPHc0CjSlcM3UYKn7INsTZGufEk3b/eOGryNvbAwLMemB42/bXZUSxTq1cMNmCJrVjVfENflluVfCSk0SgmK2cyT15iLeBZNpTjGmuJ0mIVu6mYoQAwAxtJsOuTHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTwgUDBREkbofu3wCUWh9LI2+aoGCE3FkmFF8JuJSMc=;
 b=YmvNZ137BkEfnBmA6amW/BSsax+zBr3tXhg7buBjvSr9isAcuHkXDQhbGzvRQsv4Dzxiy14V9FCUG3O7KyD8pcJgtk1bt7sLCNQYqkjzrYnzTQQ5cvLhFGO5kkmWb4ujskOdYSoeb9tPeNlwdwHBcDlbMWfBZrXkmz0jfC/9cSPd96UCBw/RxmtnACDOXx+RlExuw7jKzQUuJVxc8nuqBex9Zeoji1/5nYMtzNK2tZlFhuK7FitQGvQjttpQ4GgoKU88FrCchxvZmYeFNPUjHalNTzqvXl3tbbWFFsDHfHh/Axy+zYdOV2+RU3WAztedYHWI640Bummc1PBert5NBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTwgUDBREkbofu3wCUWh9LI2+aoGCE3FkmFF8JuJSMc=;
 b=PGfVqfgBzeq1hK4mw8JYzejNyq7Bqvzc4UR2HoWyeUtAQK25WnOhiakGwdJKDjrpKhtCLYm4eMbzgEyVbxfVZKFooDuACnzu+9/EpgwY/syeWE79n0jYqjrgstQTaw7glgl4J9RXdB408BA7IvI2/PPFkgy1Uo0dw8tkdILLgwV6dxBOpMepa9zy/i/SwPuiIskpmn4wNgZXGz87SlSU+kW9lGQ05tEASYB1YeN5YPCI6TVr5NU6wTo9sM9Bdrx2inRJ+26ba4WuuKSRCSpxKQqfVRYjrkTDfoA2SutNlCzWzE0SkhFpSkPjEjJv29COkSfcS9NhCaX+IBT6fNBjXQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9532.namprd02.prod.outlook.com (2603:10b6:208:40a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 11:32:17 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:32:16 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 04/28] include/hw/vfio/vfio-container-base.h: rename file
 to vfio-container.h
Date: Thu, 25 Sep 2025 12:31:12 +0100
Message-ID: <20250925113159.1760317-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0019.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9532:EE_
X-MS-Office365-Filtering-Correlation-Id: a4271c5d-58df-46e9-3595-08ddfc272e12
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGRmb09YRUxWcGY0ZHFxS0ViZU1WY1dnYit4bzR2YmU1M3cxQjJYei9DU1JB?=
 =?utf-8?B?cjlZSU5FVmRNRlVsSVVac2V6MzNGY3k2cjhIc1ZENGlvVXJBRGtDNlRhRWw3?=
 =?utf-8?B?TTJsY3I2ek5Pa0xoVnBva1dSamgwNjcrWG5DUE00RWpaaWtvWnR6a05BYWRS?=
 =?utf-8?B?WWNKUDRDemkrSW4rRml0RUV1Y0lTdmdITnlYQlNtVGtKY2l6aEVOcUJzOGdZ?=
 =?utf-8?B?WjBhM3dLcFJ0WkdEejZEaG5PRDh1NFZqWktKcmdoSFVmNWhUaTRKb0g2NG1K?=
 =?utf-8?B?dEY1SlNlT01rUmJ1MmlvYnJyeWxkWmNuTDR2Y2JtTEthLytWdTZOQWdlZzJz?=
 =?utf-8?B?eXZ0STJZRlBqRlA3b2JvbExWcGw3VEJBMUdLaERUN0tndGJyLysrbVJieWs3?=
 =?utf-8?B?dHE3Q0R1OGpUa055ZENTaG1GYzR2WUZiWjZzWUxxeEFMTS9PaDd1ME9mQVBY?=
 =?utf-8?B?ektwQXJ3NHpzMzVpWTFQN0dUeVAzeVdaTHJPM2dxZktyQW5aVWZnOE42YzBw?=
 =?utf-8?B?VGZVUXlmRWM5cUxTTXVNdGh2dG5rNDJKejZ1d2RHeXBZQ3NpOTM3WngwN3ow?=
 =?utf-8?B?MEJrY0RMZHZubVJ3SG9maVJGcy91TjErR3IzbFU1a2tSNEYxVWYvWXkxL2pE?=
 =?utf-8?B?QmJMRUExd0ZaNnFVeHpLdlFvbi9zbXFWWDZhM0JCWWd1UGlJSnlpVGI0TFBY?=
 =?utf-8?B?TUQ2RVNyUEd2TnJLVGtOUmwvY2N1eUZ2S0FhTmRXbjhMSHg4SjhvK0E3SUNC?=
 =?utf-8?B?VDlZM0JKSkF0bDV1K2F4VXNBd0dzMUtIK21WWEF1OVdTUDRPUTE5VGx6Zk9a?=
 =?utf-8?B?QWkrc0RHODBHZEpBOEtGNndIcFplT3NjSEgwVXgzUGVncUZkazZkVC9QM2hY?=
 =?utf-8?B?eTNEKzk5RjNXSWRHQUdIZ3JRZ2hHQWxDL2tEbkxwSWZKQ3VXWUoyVkFvVW1v?=
 =?utf-8?B?YkQ4ejBpK2wxMkRkOXlmVkMrUUFtZmROYUNmd1F4cmh5QjcrYU9HTjZxR3pX?=
 =?utf-8?B?TC9kUDQ3S0QybHRXOSsyckh4R1NNRXBnbFk4T1hpRTdtS0lZTVgwOENiUXRp?=
 =?utf-8?B?bElmWnRrdEtiMTg3Y2E5WmRMZmVXQVN1a1Z1NEc1MjBrZTRiRlVUZ0ZSL1Zl?=
 =?utf-8?B?R2JSZWJMS1RGNmcwNFNtUGNUckIvazBGbDlWWVIzellhV2NYZmFkRVM5RmdU?=
 =?utf-8?B?WFZaTVg5QUtOeENlZVBHY1haRCticjRPbFJZYTVNdFY1Mzc4ZHpPVlo0SnU0?=
 =?utf-8?B?UTF3UzdTcGJpNnUzYnN3TlI0NlFXZGJYTmdKNFk1SEpjdTRhNjgwb2l2Z0pY?=
 =?utf-8?B?b0FtWXlsTTVlVlBCWjVPMFRDOXFTLzRjOHJUZmpWOU90T01xVDFHN3NTWEp1?=
 =?utf-8?B?K0wwZjJtNmRWZnlJSjZTZVBaajhneExTRFQ4RlNmSW11eEMyVXZrWnJXcVZY?=
 =?utf-8?B?QnowSUhBTHlGOVI2OU9TbGlXZllJeHVqa1BEeHpkM0c3OGhLU2w0NDBIa0hB?=
 =?utf-8?B?U1dKWmM4cUQzcGF6UVpEcWJuT1M4N0svMmxucXE5QkZXQ0k2eUp4VnBkWXFK?=
 =?utf-8?B?VXRQbG5HRzV4TTFOa2VMR1MrLzR6b0VjT1cwNTVUYnA2QkxNSDlJZkxzd3c5?=
 =?utf-8?B?YldRd2dJOTFFTTMyeXNGY1N4TU9GVitzNkV4VU5IZzh6SDd5YUxEQW1TOXhE?=
 =?utf-8?B?clRualNwTXFabmd5U1FsWWdWamZramcycHhlemV1VUlYNS95bUJQN3k1bFcw?=
 =?utf-8?B?MnV4bVMvQzhjSlcxbmZISXRVdlJ2b3A5eFJZVytXd2dHRHlValdQaGhmU2tY?=
 =?utf-8?B?SFhYVTQvUDJOMjFZWXFYcWNPY2tSc0E3dUJZNnhyS04vWm1zZUR6aXV3bUZj?=
 =?utf-8?B?UXJDa3ArTTZGLyt3eGk2QXEwU1pLaEhERnlQSlkxTlI1N1NPL0E2dVNQbEdH?=
 =?utf-8?B?a1JJNGluaG5DcnFNSEdxUEdWQU5WamdLdmpTSEZQU29BM3VHUVRMTHNFRDQ2?=
 =?utf-8?B?L3doM0pMdUh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFA4UDZUMHJOeEFxblE5RWhxdy91SEZ2RDd0anVDbG8xekZUeGZibklBL2dm?=
 =?utf-8?B?TStYYUFMOThQdytDcTdJdXRMNUVLbWdCWVhMYzFCa1JWSUR1YnpyUURIdm1C?=
 =?utf-8?B?b2JURlJLZk5mM0FyOUdqaHRhK21oMVlMRm9weU1zb3VqWGhUQ2kzZklNbHhm?=
 =?utf-8?B?Z3loTGREbkEvVzdBdWxOMS9OclFCSml0cCtnUi84Y1RzV2hybTVFV2gyK1Zl?=
 =?utf-8?B?T21vQ2FzMjZOS3U5T3doL2d1NVczWlZwVXpZTkNETVM4clppbHh0eDNuaFdL?=
 =?utf-8?B?dmZxSDU2OWNtbzBDazEyU3ZwSEgrSVdHSGpCdzV4SjVxd3hWVkdrS3QydGhz?=
 =?utf-8?B?NFRLMXFPR1IwU0FVNHhEQlM4WmZYcER0cE9zS3dEK2pvOXZXM0UyTUgvdVdT?=
 =?utf-8?B?S1JVM3hEN0dwcEdOMmg3NDYwMlBTMEh4dHo2a0ZGblFMUXZnaUtQOENacytC?=
 =?utf-8?B?MkM2YzdFWEVyMzJIOGZON0tXaDBMLzhYMXo0bFo2OTFBMm5nRUE2UEVxYnF6?=
 =?utf-8?B?UlducCtxSmRmRjdmL0lJUXFJYVdVY3B4MnBPaEY5bDl1UWZHYkVSUUlUd1RT?=
 =?utf-8?B?MzYyNTJXd3NyV2FLekJXNVNEOUZiREU5dnRSaUxHd1VCUndsWDlTRWF3N2da?=
 =?utf-8?B?Q1p4c2NST3FBclc1NW95UUtFN1RXTGtEMUsyR0p3a3dYTkZwZnBHbCtMQ3lD?=
 =?utf-8?B?YVUrZXdtWldPSld2OWZhdXFjYUM0bElHcVJISnNjMmxMczJaK3JwZVZSNklN?=
 =?utf-8?B?ZCtvdHBYZ0FUaTlYeXUxMWtsQ2RaT0tQNitQbTZ5Y3pVNmlZbWhjZ1dwSFJq?=
 =?utf-8?B?RCtBUk9jaG0rTFRXaXdaRlNjVDRjQmQrNk5KZXQ5eHozUXB3VWI0TSs4UUIz?=
 =?utf-8?B?OVNjRTBXNzJvTnZaVEJETmZFSUhCRzMrVEtZcGhEb09ueVRCU01xUk85Yk90?=
 =?utf-8?B?TG5xWkxoQ1NEam9mbHBHYWk1QWlrUnVoY0ZqUG9YbkVHR1I1NklkeTU0VEFv?=
 =?utf-8?B?czVCY0w1ZzJZbThlRjJFODMxVlpzUnFSNnVhQjVUVFlGbmtJOVBZQWsrYmFm?=
 =?utf-8?B?V2o4RmpNRUtrTkhrd3ViRTFqVGpIWnNzSlJGeFE2VlJwb0gvUXZYUTE5SURo?=
 =?utf-8?B?YXo2TjVlT1F4Zmh6dmQxVTBLZXkyOStpUWRzU3p1V3QrVU43MkFoWEZrNWNr?=
 =?utf-8?B?a3NjWmxkYXJZSWt4MkJlQlhJckhUdVdzRTdrbitxU2thV2VHenlZV0NkdThT?=
 =?utf-8?B?cTNJdjdiQ0tvMnR0WlQvQ2JlN2hNaC9ydDBVanErMkFSVnZOeXZUTFdCWEp1?=
 =?utf-8?B?NGlyMHpGaDRuTnREK1NDK2xub2x1Q3FSejB6QVIzczVtWjY4Ti9GazZucXFn?=
 =?utf-8?B?cnBUajNXVHZnLzBYWElmQjg1Rzd0TUV2aGhLdk83SXhYTjZlSHo2QkhFUHlV?=
 =?utf-8?B?WU9WS095ejR1SHdSTFdoYllWQVlPSjdlUGRmbGxSNXVpM3lhUHIzR3JKdFRs?=
 =?utf-8?B?MHo2czQ5aVR5WGJSVUpyM0kvR3h5TVRDQzBkMjFhaWFxM3BvTDNuRVQ3K0du?=
 =?utf-8?B?d08rOWlweDliQzNnb00zeDVOd2NGclJFdS9RcDRyblZ0bzZrSFJyVzFqclVL?=
 =?utf-8?B?UHZvSEJmd1Z0cE5zNHM2cC9mV2p2ZGtMMFFVbEd4S01SR2ZmY0kwSC91Y3k5?=
 =?utf-8?B?K0tXeWJxN0xxT0Z0VG9tdUVpZnhEMmJ3ZlN4eW5xbWJIR0ZPemxNS3JkT0ZV?=
 =?utf-8?B?V1lFUktSUzJ0RTI4Y05aUktCZ2pPWS9XQ0tBSW5BcTR2a2Urbzlkd2dZU3lz?=
 =?utf-8?B?NmdLUVArSXBVeTdSY1RxN2VlUmxSZElOcWxIV2JSdnZuRlhpUUx2S1MrWUkx?=
 =?utf-8?B?Yytkd3U2UWxRK2dyS1ZVSEtnZjV6L2tEKzd3cE9TdVlyTHU3WmtXcjY5bkYy?=
 =?utf-8?B?WEtrMlEvZTZhU0JXTm1QeDM3Y2JsejYvMjRZdE15UnpJOHBFdFBRSXd1QnZ5?=
 =?utf-8?B?WlZVY05LNlpUQmN3K1B6YU56S04vclRtd0J4UWxZQ2cwTXR5NGpKcnhvV3VI?=
 =?utf-8?B?TDg3N2thZ3IveFJMRGZhSDVvWmlodGFCUFppdVlLZGxndGZoQnc0Wk0rSGx0?=
 =?utf-8?B?S3BhTmU0cGMrcTFWMTZGY1ZGRWJ4a2pKMWZjTzlsQTBPaHFubDE4R2tTSGdx?=
 =?utf-8?B?UlRnQTVCZmw1UHVlTU1jallpNFBndW9DVjNHOWxmRDJtNUdEanNaTzFQRkkr?=
 =?utf-8?B?YUJEdGJhbzdmKzJ1cGQxK1BDQzdBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4271c5d-58df-46e9-3595-08ddfc272e12
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:32:16.6187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AcEJxB8GzUNVLwdZgksva5k7Cu/giu+GroN/NsrZzt8DSlxi0wAsjcbESl6CTncUgnnV1F1RWq9x4l7n4m+snkmn0y+6Y9y6SEnlwzdq7Ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9532
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfX57VbSs8QKGd/
 vwS52+V4Itg9Q0Q1BDyIVNSZwSUwMX/7mwKOchmsB4uf1/gLxtOFCDrvnops/WlRcd2nph6Zn8d
 VLFkbIYSC0b4d30FHHIupW9d5Q/PKfI1cxxSN5MJvWTC0HEFlDwvSCu8zdRi1COEX18Q5OgiXFf
 hjgMvd3a8ST1JzxnHLOrwAN6/SNPQsjNB0KzgEIkYxjtISMP7l+koMF9RQFIApHf/+ogCTI3AQH
 astWMepJa6E2FCpBCCqXCgKX+3pk7Yg9i6mdOIVsN7Nm96LZSZ3cf9EnQ7RTDV77lqavwScLjov
 D613YPlPkU1kecQd/PUvEYRGrx6CatfJ8dt5UWVx2T7HZ9pEOEYUcoJPP1EAK4=
X-Proofpoint-ORIG-GUID: ioyD4hNedNmvmEzoGiWlqOQHcqfvgXSH
X-Proofpoint-GUID: ioyD4hNedNmvmEzoGiWlqOQHcqfvgXSH
X-Authority-Analysis: v=2.4 cv=aYdhnQot c=1 sm=1 tr=0 ts=68d52843 cx=c_pps
 a=HbRg4qzSv2wm5CHrpKeBBw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=-KjGwgwoGPQumVjQa40A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

With the rename of VFIOContainerBase to VFIOContainer, the vfio-container-base.h
header file containing the struct definition is misleading. Rename it from
vfio-container-base.h to vfio-container.h accordingly, fixing up the name
of the include guard at the same time.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/container.h                                    | 2 +-
 hw/vfio/vfio-iommufd.h                                      | 2 +-
 include/hw/vfio/vfio-container-legacy.h                     | 2 +-
 include/hw/vfio/{vfio-container-base.h => vfio-container.h} | 6 +++---
 include/hw/vfio/vfio-device.h                               | 2 +-
 hw/vfio/container-base.c                                    | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)
 rename include/hw/vfio/{vfio-container-base.h => vfio-container.h} (98%)

diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
index 241863ef97..a2b42e3169 100644
--- a/hw/vfio-user/container.h
+++ b/hw/vfio-user/container.h
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 
-#include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio/vfio-container.h"
 #include "hw/vfio-user/proxy.h"
 
 /* MMU container sub-class for vfio-user. */
diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
index 6c049d9257..13f412aad7 100644
--- a/hw/vfio/vfio-iommufd.h
+++ b/hw/vfio/vfio-iommufd.h
@@ -9,7 +9,7 @@
 #ifndef HW_VFIO_VFIO_IOMMUFD_H
 #define HW_VFIO_VFIO_IOMMUFD_H
 
-#include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio/vfio-container.h"
 
 typedef struct VFIODevice VFIODevice;
 
diff --git a/include/hw/vfio/vfio-container-legacy.h b/include/hw/vfio/vfio-container-legacy.h
index ab5130d26e..74a72df018 100644
--- a/include/hw/vfio/vfio-container-legacy.h
+++ b/include/hw/vfio/vfio-container-legacy.h
@@ -9,7 +9,7 @@
 #ifndef HW_VFIO_CONTAINER_LEGACY_H
 #define HW_VFIO_CONTAINER_LEGACY_H
 
-#include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio/vfio-container.h"
 #include "hw/vfio/vfio-cpr.h"
 
 typedef struct VFIOLegacyContainer VFIOLegacyContainer;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container.h
similarity index 98%
rename from include/hw/vfio/vfio-container-base.h
rename to include/hw/vfio/vfio-container.h
index b580f4a02d..b8fb2b8b5d 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container.h
@@ -10,8 +10,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef HW_VFIO_VFIO_CONTAINER_BASE_H
-#define HW_VFIO_VFIO_CONTAINER_BASE_H
+#ifndef HW_VFIO_VFIO_CONTAINER_H
+#define HW_VFIO_VFIO_CONTAINER_H
 
 #include "system/memory.h"
 
@@ -276,4 +276,4 @@ VFIORamDiscardListener *vfio_find_ram_discard_listener(
 void vfio_container_region_add(VFIOContainer *bcontainer,
                                MemoryRegionSection *section, bool cpr_remap);
 
-#endif /* HW_VFIO_VFIO_CONTAINER_BASE_H */
+#endif /* HW_VFIO_VFIO_CONTAINER_H */
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 67b9fcdd2c..ed19e2e1e5 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -27,7 +27,7 @@
 #include <linux/vfio.h>
 #endif
 #include "system/system.h"
-#include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio/vfio-container.h"
 #include "hw/vfio/vfio-cpr.h"
 #include "system/host_iommu_device.h"
 #include "system/iommufd.h"
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 98c5198e50..250b20f424 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -18,7 +18,7 @@
 #include "system/ram_addr.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio/vfio-container.h"
 #include "hw/vfio/vfio-device.h" /* vfio_device_reset_handler */
 #include "system/reset.h"
 #include "vfio-helpers.h"
-- 
2.43.0


