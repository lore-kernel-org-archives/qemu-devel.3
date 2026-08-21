Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C9EC5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxNEw-0006ow-E9; Fri, 21 Aug 2026 07:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNEs-0006nZ-2f; Fri, 21 Aug 2026 07:16:46 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNEp-0002H9-VW; Fri, 21 Aug 2026 07:16:45 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9MaK81940235; Fri, 21 Aug 2026 04:16:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=otYUrplJyU1KopakKqNAlNR40aLlIkC+0PXOOfEb/
 /s=; b=Glu2Ir9DU86cdPSbIT7+Npb4pns5eFcCC6XPsPW6lqOZzUPVkgJcsij4v
 +z2WsMiTZc0iDqRJE9wVPi1dlMVRN8GMc8wdXB+hUcf3na2CHjo67l1JKuakF3sO
 L8M565+S7n7ie3+a8ZibtBzxxPz/vUxm5DqOYVFksrWdKoXdC1SKpqtym0r4ZDVb
 srFW2zXBDNwGY7jCs3kxLARD4SAKgYl0rEuu6TsDwW9QIGFDZF0Pn/g16wBq1fUt
 3KXyaJEFsOBOaBnhGqjox3WQZ+Q2K7HI9Y1OwxH9Un58O8gErdFe2pzZYBdpxvwN
 0WStVVr484a1waAbw5FsIoNdpLjqQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021088.outbound.protection.outlook.com [40.107.208.88])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g6jfhrcfn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 04:16:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPZfZoB1vikpDpuD+mp2L+gUAjqbtf38PWOhM7zBYMEfEBHzX37cYjT1zf9ss2sWJCTf0FjBiKroNGe7EmJL9SLVKNgBo/cZpBUlJTMrX1zK7O4nbihGbS/hS49Nx0HPqM5cLf9MHG4ekBn8JzZa0HEY7OPXZzIvytxkeSPWiWh0FaaH7H7YUJFzlALPfslVv4A9Vz3fKFOKSnJGgafBoRgLuyKXubsk632cAZMASuSNWcbKh4M1iKvNzURlPggPG1YupkSX+U9RSNdunteM0IlVCofTkje7jo8FrxM7qKHHqe9JN1+BeJ6PRweWDNXQD31FteKD6xn6fPfc6bB6IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otYUrplJyU1KopakKqNAlNR40aLlIkC+0PXOOfEb//s=;
 b=I3gU5+keHdcC1ZzO3lRXvZ/kIjVVuTzYqQFN85SiZXbz26LATdq1adfaOA3XN59kSZS1+yQ4U8hY6YN1cjeZfIQB80t8JZvXIixuWhdYeSVpLxNhfGMVHL98MUDssqJcUqKoF+D/paNgqZa6J75Ecn3n28/dnOe2RhyNR/dPPwEkIeLvNNCe35N8mXyaTDjSyLOA9YZfrZD5nlhcIA+3UAcKXHXA24Y277JV/XeAF8o3Kz8w5p6hYHzg8kS6OGrSgPkmxYG1Vtn/xD207BRdcywgAJJs0FNHOTncm0VJaS45XnoAYsd9mUv/sM4Un7tk1mXAwIORk8a4R8okBSme4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otYUrplJyU1KopakKqNAlNR40aLlIkC+0PXOOfEb//s=;
 b=WCAZhTJf5xolnZvwJxHCK0j40C/4YGzUge2JiD7dLT1PqIh0/9ATYmTHvSY3lv9NGj8VcPaqCesWgpMB+u4S7h0Ds9tMcXFTFn1QsgGHgzjc6boFyzwH+sILWcryDcX7+G1GBOglM311TqYKM/UGeAAHwxDKOFqk25GN67HEEnSL2FrlqCIWH8wbdUzs7/8UQfRfXLLDjlj+bgM9WsJHT2stPT9eZ6+6dnSrK2wyY12rnyjXSuZpFeqCyaFRh6KjGsytG4cfu1sE/MBOhOxiktxg0Do+ylfWDM4EJDHj9e6yUDJKy0zxX5kdKcM7GoC03VavaEHdPJGY+mgVqjcJNw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY8PR02MB9524.namprd02.prod.outlook.com (2603:10b6:930:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:16:29 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 11:16:29 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v4 11/16] hw/acpi/ich9.c: convert object props in
 ICH9_LPC_DEVICE to class props
Date: Fri, 21 Aug 2026 12:14:23 +0100
Message-ID: <20260821111550.276011-12-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821111550.276011-1-mark.caveayland@nutanix.com>
References: <20260821111550.276011-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:806:f2::29) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY8PR02MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c8488b-8aff-487e-835d-08deff75a61d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|18002099003|10067099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: 9gHSrgua3Q4YBQQmxCQ3M1xvcQmFgb5+BRwC/+cqab0fV6HFptzZ77OD3i7SaRkvZtN1AAMEKqK0YyNbBGH15rS7t+BT+vqtl5HbcBOcz2PN+1OAHg18kK7UBc9Gbn0V/YSpWOoDtmqJealK2yxP/gaZAoziWsjr7ydURmtRyb3YyXis1zihh/F7+QiK0grZ99jnNOUe3xcknje/bGTbEoMy9ZaljOgLJ/yJxfHhHPllAJTOh/dKc90TEf0HFo7zGtdD5oxfJBZmNT2Vui51C+YInYSmovR3UkumcOLNkdfEANFlkFcgnG8V864nKHdeRwYTMIofWhRHsl+/ZKe1yr9oLUf8G8dnLGtHj5S1xHFjLsH33560geFsteXt6iI2F19IOafBSBMmiqIfGeuPqGK8Vd0xy/W1bA1PL/jVIgQ4nwZHu6BdZFhhYw5DGVlducL16/fMPfVzku+NXA3/nH64Tc02SpQwWPsj3Y0uo/R9EwC0LzDklnZzb0ZG5qk7efvWD5jaE9gqjvB+CEpIXYWfuVSebGbRYeVT8zSZk+g4tw/sYTRfl6wVpMiSfr90IVZiABxhEkwS4qK03Nka3bz57JVA5AuSmXHFt4RBPwO6jXF967ojvCd0szMjqqqiqVRAmE1ZE6/WIveCKktDOEYpZ1HOXzDYiNx7COmhD/iW7/EKmvDRVqOqPqJjnrw050IjLPzJIiD10sqHPVJNTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(18002099003)(10067099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1dXUEY4YU1wOXRqaDRZdFViaTFPYXhPUkhHM1g2UytPVys5SWRzd3pTdHNr?=
 =?utf-8?B?YWtuM1JCKzRGZ3lqZnhDbjI3UlFCK3hkS0w2cTgxSFdHZTZMaHdpU0hrOTJV?=
 =?utf-8?B?L08wVFNqb0ZxSnV1aTVUS1NQbndieFQrSDdSMDI3MzdSTHU3MmZNNUZpSFV0?=
 =?utf-8?B?YzgvbklSNmYxUUNqbVM2dHpFN1NzVnRnV2c1cUU4Yi9WODIyYS8rMFJnQWVv?=
 =?utf-8?B?U2pVNyt5UW1RdHBmb3BFTTdwbVI2RFY5aVZBeFBPY1d5N2I1cU5xWlJTZnBC?=
 =?utf-8?B?RGFLc0ZDQmE1YmZCUkRrMWNvV1lvV0paczJmalVHcitEQVVEU243SmpPams5?=
 =?utf-8?B?MFE2elFPUTFFTmVtMGJKUTVBRkRkcHlQd1h1Uy9adWt3cXRIYnUvQm9vNmhw?=
 =?utf-8?B?SlVjaVc3enlMRW5nemVhTG1oU216UXJJc0txd2srUmlTUFRjaXN5aUNBSnJQ?=
 =?utf-8?B?LzEwSXpLeURXenRnUDNQekRrUU5IL21BckNjbzR6eEllTEtDL2RwNTVrN01W?=
 =?utf-8?B?Uk5lUTA2UFgzZGFYY2R4c3NmVGlQZnNGUGc5aFBnRXEraDJsTXhEWDZha0FM?=
 =?utf-8?B?Q25pSHdiUXpjL1NLNHMrUlVySGlKRStobjE2a2JLOEg0RlZ5Vlg2V3E3NXJU?=
 =?utf-8?B?RlZ3M0psRGlsTFM1TnA2TFBIdW5qcklseUJSWjAxZmNUTHNnbVRodkg3eUN3?=
 =?utf-8?B?VTZOU0lGVWRQS3ZsK2ZvZUI5ZnJyVUxiUzlmaUNLWnE3SGFnUFBYZithZytt?=
 =?utf-8?B?bDFha3UxVDl0Nlhmb0NCZ05WTnNxRDc1MjA4YkdENkd5UDRIRFlaQ3N1ak9N?=
 =?utf-8?B?SFczbDV2UGhDczg5Y043cFpHWXZLZHFNOXAveWM4SmNVYU5iL0t4ck42b0dW?=
 =?utf-8?B?eS8rTFpRYm1BQXF1eXZyWDVsdmNmdmtnSjZ3MFVUaWtxQTJPdFRGYmlmTVdV?=
 =?utf-8?B?ZFNacGtiamlHVlliNG1obzByTUcvWkFvN3V0R05jZ0FCMUdnWkRqY2NMWnpB?=
 =?utf-8?B?NkZMVm9rd2t2a2dGeEVmcTFoR2IxaFVzSGFtVHM1b29hM0EyMHNiejZ1aThz?=
 =?utf-8?B?MDQ3SXN6KzJmOGJ5WFN0RjNRTmJjOTJtSm8wVDlXQmpHZmVUVWoreFMzWDd2?=
 =?utf-8?B?RGRRcHI1ZW45UllCZ2YveHRPL09Ic2VsVlArcW9LRDBCRk4xcENWM3dpeXM3?=
 =?utf-8?B?RWJLT2JrSkk2bG52VVE2UGx1R21aZmk3ckVub0YyY1pWMnc4dUJJa1ErQ2VU?=
 =?utf-8?B?UVFKWTM3emJrTDhlcTRmdFZnU3RmaXpITURSanNsYi9tMnQyMFRGZjJMQ09n?=
 =?utf-8?B?TjYyay9mNU1lMTRaSEtrS2EzUDQwQ0svYmx3MGo1UzZLMEJtbkl6ZDlOU2VJ?=
 =?utf-8?B?b0dnUFIzUTVKYnRicWZXNENOSFZVWm8wQXcrSmtKWlg0SXRla1EwaXg0YTh4?=
 =?utf-8?B?Rk12RUpSeUt6TnhVaTJMTTJMSE9veDRvSzNNdkZpSG9QT3ZKdEdMMEVySGdZ?=
 =?utf-8?B?UFJqR1NaaStvamFYRlcySlQ1VitXKzhZN2U4bEJNWTZ3VXl2VG9STWk4TUt3?=
 =?utf-8?B?UEM2UnZENmVza0dpbUV5SkFrSzZGNVcwaXd3Y1ZTU1U1czVhakVsL3paM1hS?=
 =?utf-8?B?eXlBaHVLNDdiVmhSWHlNV0lKNWZIemZrazIwTzROL0gzcXlzaHU1NVhFUFpt?=
 =?utf-8?B?RUUrRFF2NytYNWU5MVhPU0VkSVpqNi9TdENUaGlTY3pGV01ucndRRGs5eGh1?=
 =?utf-8?B?UlVNOVRPQVE5RW52QkNMdVNDRnp6VHBwQkVkSWFCa1hTOFpXU3U2TjJDL3Fl?=
 =?utf-8?B?bFFPYWJLUHJiUm5BZ0FpMGVnaGlBQUVDd2NHdWRtZzhvRzV5a0ZzZlpyMGNL?=
 =?utf-8?B?SDB3SCtqMklHMXV6YTZnYkw4aCtKTXVxNFZ0cVd2aVNuNjl0NGlqOHdWRVBy?=
 =?utf-8?B?Z3o5SldVTW92ZjdmbkR6NVpSRTZ1K2U5eUJONTFnaU9zU2F3eGl3cS9oZFVz?=
 =?utf-8?B?Tk4wUHdhVWdyVmMwUzVRMTQyYlZzbmVKbzdFSXJEZTFBdGIreEpZang5Tmx3?=
 =?utf-8?B?ZUZmaW1yTzRtS3M1REs5MHU1MjBpVXMveVdsY0QzS0twTHIybjg4NXZlNHdJ?=
 =?utf-8?B?anZvaXRmczM3ajQ2dExUV0doblNmM3NKa3pGeFNaaHYrR3JxWHZsTWxLQXhl?=
 =?utf-8?B?NTNHYnJRSjQvQmhNMXpvQm9KZTl5WEd5SFgwTlZ3MWVFWkRMS0Nzc0hhRXpX?=
 =?utf-8?B?THo5QzZZNjQrRXhHanV0NlI2SmhrUEZBb004dGU5N0E0bCtySzI2M1A2c1Bt?=
 =?utf-8?B?OWpjS2tBNDF2WDhqRC9DK3o0c212MVZuTlNncSthVWlCYWd6cnhibWw3RXBr?=
 =?utf-8?Q?ZLBO8K+TRtFD5T+E=3D?=
X-Exchange-RoutingPolicyChecked: cTr2IMM0ieutBihyTnbH7HoxLrfZ2qnf1yLcx3oTvs0Qcm/JYOUBu5oEqU2hLRvBC4QqfVcWJwuwhYqXlQIQUHvtrws//v+udley29BQMJiNukdM4VvSfOx/q/D31bMjYybVXu7D9H7Q3lixUAolyceXdWVqm89CmsfLu+rls/ySfrfpoU3COKMQWmWCUm4MHW+45PCg3v7ILi+2hxfVGjoAhRnEe9pRHQy/yrqy4gCemGf2NsOKkB2Ngu8SV5VjASX3FBiZ0nsWMvVmkkyieJeVXLjWUX4CoXVSNmAUqUjQKc2rHlVQsoE0/4wdA9Icj1UA1+cwI5Fe7kF167k8Mw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c8488b-8aff-487e-835d-08deff75a61d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:16:29.8200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkByk6a3HWA3kg3uESqyJdaRr5nKm3dibW7v6exLJwHGxmXCU7Z19OSdMKzfA5OKT/uJNHBsYczxdzFOPN0NX5UAhXk4eEkyeZWUiLoAMAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9524
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a883391 cx=c_pps
 a=bSkFQXo9YJPfdG4GsN7qoA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=HwAbVaYSD3iTdclZ3UcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wEtAyIQqTfWvU19D2-LdKQlp_h_1uHqh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX/bmFa0TNry1n
 mjgD8WrydsmWCNYTydM1BRU9LTBIpiPA2WTle1zIyCn+nYHcuHwowpcMpqeaZpndhZl0oxleq2u
 SXsJYFpvWY6KsTmIe/P7+jYHDPe+A2Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX2tEbY++rI8cD
 fps13a63BP9MQjXylz9ylzMXzkgfjxIqk2U0GsmdnOlEhhR2qYwh8HR/c6dNghBFt4BTDfsbON/
 cRoZHYju6Jy0h5VDBCbtn16rFIYADizvQGUV0WVWODuBticpdAk+84Sot9BYDrNLpIXN5goWYCM
 N/E4sbW4mbNsy4zxr7L4Z2+24/iGOzZYuncqAa/WhlRGewwBZoj8Pzm1CU8ez+Is10cMZ6C/ext
 LuVoOKHLsNW1bzkx0tkpHBAe0GUyCst/pwcUIS497+Wzi33NdcuFP9tKCVzxZeRS/nswP5zdADm
 /7DvTdb8rxLD8TFHcVQsJhCDhOCDIsw3owFuuHxakw3qghBr++t3Wc925WUBVjIo7KhNYM1prDr
 Io8e/7Wm+zqIpW4QRSOoatddXlpPLAVSFooOL23+WkJNcdI8W1LYdbi/7D5Vh0Zj2f+nbRskqwW
 CSUcHTufP80svgKTQGQ==
X-Proofpoint-ORIG-GUID: wEtAyIQqTfWvU19D2-LdKQlp_h_1uHqh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

ACPI_PM_PROP_TCO_ENABLED, ACPI_PM_PROP_ACPI_PCIHP_BRIDGE and x-keep-pci-slot-hpc
properties can be converted to use object_class_property_add_bool_ptr(). Remove
the now unused ich9_pm_add_properties() function.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/acpi/ich9.h |   3 +-
 hw/acpi/ich9.c         | 111 ++++++++++++++++-------------------------
 hw/isa/lpc_ich9.c      |   3 +-
 3 files changed, 44 insertions(+), 73 deletions(-)

diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 3fb993bb9e..6d14544751 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -83,8 +83,7 @@ extern const VMStateDescription vmstate_ich9_pm;
 
 void ich9_pm_reset_properties(ICH9LPCPMRegs *pm);
 
-void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm);
-void ich9_pm_add_class_properties(ObjectClass *oc);
+void ich9_pm_add_class_properties(ObjectClass *oc, ptrdiff_t pm_offset);
 
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp);
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 774b34195f..4aa8d36f54 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -349,46 +349,6 @@ static void ich9_pm_get_gpe0_blk(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, &value, errp);
 }
 
-static bool ich9_pm_get_enable_tco(Object *obj, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-    return s->pm.enable_tco;
-}
-
-static void ich9_pm_set_enable_tco(Object *obj, bool value, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-    s->pm.enable_tco = value;
-}
-
-static bool ich9_pm_get_acpi_pci_hotplug(Object *obj, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    return s->pm.acpi_pci_hotplug.use_acpi_hotplug_bridge;
-}
-
-static void ich9_pm_set_acpi_pci_hotplug(Object *obj, bool value, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    s->pm.acpi_pci_hotplug.use_acpi_hotplug_bridge = value;
-}
-
-static bool ich9_pm_get_keep_pci_slot_hpc(Object *obj, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    return s->pm.keep_pci_slot_hpc;
-}
-
-static void ich9_pm_set_keep_pci_slot_hpc(Object *obj, bool value, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    s->pm.keep_pci_slot_hpc = value;
-}
-
 void ich9_pm_reset_properties(ICH9LPCPMRegs *pm)
 {
     pm->acpi_memory_hotplug.is_enabled = true;
@@ -400,35 +360,7 @@ void ich9_pm_reset_properties(ICH9LPCPMRegs *pm)
     pm->enable_tco = true;
 }
 
-void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
-{
-    object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
-                                   &pm->pm_io_base, OBJ_PROP_FLAG_READ);
-    object_property_add_link(obj, "bus", TYPE_PCI_BUS,
-                             (Object **)&pm->acpi_pci_hotplug.root,
-                             object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG);
-    object_property_add(obj, ACPI_PM_PROP_GPE0_BLK, "uint32",
-                        ich9_pm_get_gpe0_blk,
-                        NULL, NULL, NULL);
-    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
-                                  &pm->disable_s3, OBJ_PROP_FLAG_READWRITE);
-    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_DISABLED,
-                                  &pm->disable_s4, OBJ_PROP_FLAG_READWRITE);
-    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_VAL,
-                                  &pm->s4_val, OBJ_PROP_FLAG_READWRITE);
-    object_property_add_bool(obj, ACPI_PM_PROP_TCO_ENABLED,
-                             ich9_pm_get_enable_tco,
-                             ich9_pm_set_enable_tco);
-    object_property_add_bool(obj, ACPI_PM_PROP_ACPI_PCIHP_BRIDGE,
-                             ich9_pm_get_acpi_pci_hotplug,
-                             ich9_pm_set_acpi_pci_hotplug);
-    object_property_add_bool(obj, "x-keep-pci-slot-hpc",
-                             ich9_pm_get_keep_pci_slot_hpc,
-                             ich9_pm_set_keep_pci_slot_hpc);
-}
-
-void ich9_pm_add_class_properties(ObjectClass *oc)
+void ich9_pm_add_class_properties(ObjectClass *oc, ptrdiff_t pm_offset)
 {
     static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
 
@@ -436,6 +368,47 @@ void ich9_pm_add_class_properties(ObjectClass *oc)
                                                 ACPI_PM_PROP_GPE0_BLK_LEN,
                                                 &gpe0_len,
                                                 OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint32_ptr(oc, ACPI_PM_PROP_PM_IO_BASE,
+                                         pm_offset +
+                                         offsetof(ICH9LPCPMRegs,
+                                                  pm_io_base),
+                                         OBJ_PROP_FLAG_READ);
+    object_class_property_add_link(oc, "bus",
+                                   TYPE_PCI_BUS,
+                                   pm_offset +
+                                   offsetof(ICH9LPCPMRegs,
+                                            acpi_pci_hotplug.root),
+                                   object_property_allow_set_link,
+                                   OBJ_PROP_LINK_STRONG);
+    object_class_property_add(oc, ACPI_PM_PROP_GPE0_BLK, "uint32",
+                              ich9_pm_get_gpe0_blk,
+                              NULL, NULL, NULL);
+    object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_S3_DISABLED,
+                                        pm_offset +
+                                        offsetof(ICH9LPCPMRegs, disable_s3),
+                                        OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_S4_DISABLED,
+                                        pm_offset +
+                                        offsetof(ICH9LPCPMRegs, disable_s4),
+                                        OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_S4_VAL,
+                                        pm_offset +
+                                        offsetof(ICH9LPCPMRegs, s4_val),
+                                        OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_bool_ptr(oc, ACPI_PM_PROP_TCO_ENABLED,
+                                       pm_offset +
+                                       offsetof(ICH9LPCPMRegs, enable_tco),
+                                       OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_bool_ptr(oc, ACPI_PM_PROP_ACPI_PCIHP_BRIDGE,
+                               pm_offset +
+                               offsetof(ICH9LPCPMRegs,
+                                   acpi_pci_hotplug.use_acpi_hotplug_bridge),
+                               OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_bool_ptr(oc, "x-keep-pci-slot-hpc",
+                                       pm_offset +
+                                       offsetof(ICH9LPCPMRegs,
+                                                keep_pci_slot_hpc),
+                                       OBJ_PROP_FLAG_READWRITE);
 }
 
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index d3f1358887..b55b5136a3 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -689,7 +689,6 @@ static void ich9_lpc_initfn(Object *obj)
                              IOAPIC_NUM_PINS);
 
     ich9_pm_reset_properties(&lpc->pm);
-    ich9_pm_add_properties(obj, &lpc->pm);
 }
 
 static void ich9_lpc_realize(PCIDevice *d, Error **errp)
@@ -920,7 +919,7 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
                                                &acpi_disable_cmd,
                                                OBJ_PROP_FLAG_READ);
 
-    ich9_pm_add_class_properties(klass);
+    ich9_pm_add_class_properties(klass, offsetof(ICH9LPCState, pm));
 }
 
 static const TypeInfo ich9_lpc_info = {
-- 
2.43.0


