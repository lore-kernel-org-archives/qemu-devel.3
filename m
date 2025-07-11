Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEABC83F1D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAXk-0007AV-9o; Fri, 11 Jul 2025 05:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAX6-0006Ku-97
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:59:09 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAX3-0004th-ED
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:59:07 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B7U4qm016883;
 Fri, 11 Jul 2025 02:59:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=zQVQZqRPV+FkNfTw+Ml38xv/7xc1daU6rA+m7BAV/
 Hk=; b=KjjCnOOb4fvP2uEngl+IAuBZ01aEm80vW+yfhgqrAHTI1jbLpeTEhlgWZ
 TzgRZpISit+sxwjjNQXFtlm5Hie4bkMKmqbrDnOTOwP+LQuTxgYmx6FgaipQo1qb
 sF+0QmKkWP0l+2821hmf8o3XCNKoKGw78zBrzw2a2HlX6pW5/Jqqun9Y1rR+capS
 TXodGX6Mw6O+S/KWxjTC1PQzrjGWTnT/OGiKweftizu5d2pn69Ff/OEtXaJYNa8t
 SJDd1Y3/DIAUJ4VRrmWDcX4oov1vl1b68FXe0vsxgs9SY0sYuomkPqHjGjdraGkq
 jjeajFsVHoT60S/Yih5c7FJQo1TXg==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2137.outbound.protection.outlook.com [40.107.220.137])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47ta49k6e0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 02:59:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNqBalCQuCHDPZIrf6tPom+0t9Sit3KMRMefS7AsZFur7hhTsWK7rl/wrD9PqRH8smScQqmyDiM1mkv3rZ2phd0EjqfM5WzSwvhLtvCJCSLLKqsm5qdmkYVSrLQWXMvU/Qu7aHOdQ9uRpreQaH5cssRkk3yVRar7v560Kf+IfvNJ5dJ1O41hv0SLPEzY6A04XQL1dSCc6xLKrjLFp/KpidfIdH+JcPzK+6wNN2rYkhIlUOnkGTqX4hCBuPqb8TpZgoy35tgPLTF50sunstsWqJbh8WdypIEFP23DhCOpbygdrKapVBs5Cmfhx9R198y4FlxpoaGbXyeCpEFaZXQBwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQVQZqRPV+FkNfTw+Ml38xv/7xc1daU6rA+m7BAV/Hk=;
 b=a7V3Rz+CA6tCPh5RUUBAipG4hE9ZDdF40k/2H+EFx3plrGvWjhIqni4SmW+j+YYK6TSuhalvsif2k0+X2oKmfpN19M7pjWjZy2VrCKVNCB6XGA8PzNuRKBEbgGgM6zSmowaYhJXCSMXOGuEzON/a6hgwhLq8v+oPYIdspYehZeFj98MmRfoVTtrnei3KhpvjBMtCkuf0wd2jO/pAHrQWCt8miyqkL2AtajqTfl1t0V+j9yRmEZ9OfnUfyfHW4dL98RlLVapy/d9Y9EhZf4VxlqNT2xp44OiQOtJuDrUQxDjeEpdXts1urqfwP6U3dnMUUQLiYUtf3IyRBZDnLXkB1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQVQZqRPV+FkNfTw+Ml38xv/7xc1daU6rA+m7BAV/Hk=;
 b=My/59yQiXKLbz5n/jMZxQoDbKl5/IVr7kRCKydXqQHcPPjk8B5jYhGudau6hiJrstU1kY2GfyRUfkA/TbUkzPid/zgSqtPiJvoQ8Yvm7nHk2DEjyzWyDJdf2YaWpEHVvnnhGebU3YBBATGNAVGXotj+uCIcMI0i8ASh1NbD3A9qfPH4AAkJr4dZ7POwQA18iUAc3GrXlQGtDfn3AX56cMb9nvp9nfvqDsfSYZVJz+AEApirHZhDagaTl3Q7xSlgSaaQDTZ1jqWfzsW7scnFLnoJOQJZ7Y5mpg7FFD4aEMnk/7XPJ+PV+ARQ9XhBpjDcd3o3d/81SDRrqZhR6C7VYyA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB7918.namprd02.prod.outlook.com (2603:10b6:408:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 09:59:01 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 09:59:01 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 13/19] hw/i386/pc_piix.c: assume pcmc->pci_enabled is
 always false in pc_init_isa()
Date: Fri, 11 Jul 2025 10:57:15 +0100
Message-ID: <20250711095812.543857-14-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711095812.543857-1-mark.caveayland@nutanix.com>
References: <20250711095812.543857-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0266.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4f9380-6299-4588-2424-08ddc0618ff5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckR6NHROQTRsK3hmSFlIVUtleHdDaXdrVHNNb0xtL2xTRXFxSmxhV0dQR2lD?=
 =?utf-8?B?b0g1cDhDcE44YjZleEJnaTV3V2xlNnkvVmw1M2dMc1lRWXoyZTdCSUw5UXBz?=
 =?utf-8?B?RzV3bWlyTEFnMUxNS25CWUJXbWpKSkpLWEZaa3Qva2xwQ1JvUEVRUjF5c3pQ?=
 =?utf-8?B?eGNQQU9HcHFNMU5xRFhXTDVpdGNESGt6eDYzZ0JZUlBmSkpycWM1ZHI2YWZ1?=
 =?utf-8?B?Q2RBTHBVTXQxcTlVTGJ3aW95RFZFM01EblV5QUVGc1JOemsvMjZCWXBRUC9o?=
 =?utf-8?B?cjQySFJoWE1rN0NhWTZUY1gwVDIxbXVxdVlXRTVSWE8wK0FNMDRYcTF5YlJZ?=
 =?utf-8?B?RzRoZW9NSVJMcU5seDhJdXZ2ZlZkNS8yK0owenE5a2pqT0YxQWEvOEFJUG92?=
 =?utf-8?B?Q3ZjNDcxdHFTbWNTbWxQaFRMcEZISmJSV2lMTk1rNEI3Q2ZDTkh5a2Zxb09P?=
 =?utf-8?B?M3NIaFkvR2lJQllwb213WXoxRC9EUFpoQXRoazJONlU2ZEhrYmFyWlJwcnMr?=
 =?utf-8?B?R3ZnaVVHbGduaWRtZ2prQWVTZ0pxV2hvSUU1N0R1Qm9vOURVQVU4M0ZHWmp3?=
 =?utf-8?B?Qk5CQVVsQ05rNHJ0ZU1Eb0tKTVB2Q2NwM1FyV01nRmZvdVZUWFh4cjVPV3FJ?=
 =?utf-8?B?Vy9SVjVnRjVVemJnUHFQcWdPTjMrT0pXck1jd0VHa3JTTzM3SzJ4VTZIMldQ?=
 =?utf-8?B?TDFXZWtpK3ZWbGQxRXhLam8wWFBmOCtHSE9raW50c25LOVc5QnpjcXIyTm9H?=
 =?utf-8?B?SExYSVJVYUtnenI3a0ZLb1I3N3hNYWdBL0ZtZ2pUWkpwbHJkUTNjMUxKY3BI?=
 =?utf-8?B?aGVzcENvOFMvWWRISDlxL2V4a2xIR2pZbWtScVYwbXJldWY5T2I1eHFOVFdm?=
 =?utf-8?B?RkdzMEFySEZwVFd1TDhvYktzeGtSeURzUTJtZkRsRWpVMXBaTUZ3MUZrbjdX?=
 =?utf-8?B?eTg4akR3SUg0REIrODV3dTNRR0Exb3VpWHdxNlVSRHIyOS9TVDlmSkI1Ty9X?=
 =?utf-8?B?MlgwWlNKYStNV3dkNm5hdGZkcW5QWGJ1ZlUyOXRCWk0vaEtRNlRSN0JBQ3dm?=
 =?utf-8?B?T3phZURTMkpXeERtaWo3dUlVSUcxK2dWV3ZuYjA1ZEdQZHVqQTdFdXA3Q3JB?=
 =?utf-8?B?L3JsaFFEdis5L29PbGtudXFOWGp5WnVCYk1iWjljRVVQT21aczVYZjFOSTBV?=
 =?utf-8?B?aDMyNElNMEczZGNZeCtkV0pCYUlFdEpTdzdWUjEvTE45WStOTzlvRVhaTkY4?=
 =?utf-8?B?QUdVRmN4cEpzOEh1U1VyQ0dJUnBLZ1RzV3hxNlg3YWhNajcvaHFBWERPa1hv?=
 =?utf-8?B?dXZtYUxSTXY0Slo1VDBJcFA1ZkdoSXVaN1JPVCtWMnQwV3c0eFozOTRqQ1h6?=
 =?utf-8?B?UHZoS3ZtVDVxYW10QmxVbTEvWk1BbWowWU9NWlRCRTV2VzBGVUIwR1hiWHdZ?=
 =?utf-8?B?WWpMYWxodTlpRzYwejRjbHZOTU9NQlhYLzBVVWZGNnJJWFI2NitaM3JsNUFl?=
 =?utf-8?B?NURmOEV4KzB2RnpjT0FqUGtRdURMVktpZlJETzEybzBpZnhyVGFkYUtxQ3Fz?=
 =?utf-8?B?RTlUdVVsYzVQb0xrTGZhdVJFTzFqUnA2MUFFTEYrTFBjekNVVUdGZWpPaGVv?=
 =?utf-8?B?UGZ5cjcrRDgrZlJ2ZTc0dUpQYnhxUUxOVU9lb1ZuaG5MNHFwSFJyMlNTakZG?=
 =?utf-8?B?NytGcUtiVmIweExSc1duSHgybFdOcExlcWFKWlhWZGUxcjZ5SkdyRUJJSVli?=
 =?utf-8?B?dCtzQThmTitHdnpvblBNdnFDV3BTcnZBL21xM2tmYU5ITzczdmpjaE9FQ0NM?=
 =?utf-8?B?eTVUQjR5TElEV2l4REpBcFBDQkkrVDRuVEFhNjZ0VXRmdzdmUDF2bi9DNGsv?=
 =?utf-8?B?RFgrT1ZMRzJxc25SaFNLYkZVNUQ4bFpBOGpOelJLWEY2SDcyUWdHUXdWWjAz?=
 =?utf-8?Q?uy7CfBbr2XY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkRDRk96ZHpmbkdUSWRaYmVIQklQNElFMjFhVk9Xd1hPL28wNGdrdXR0VWQ1?=
 =?utf-8?B?SGZ3Tk1DUFZNemFPM1ZQT3FMUzFUY212Q0FmQzV6ckNrSldOa0E2NVlpVlVR?=
 =?utf-8?B?VmF5bmhCTHNUMkxYMlpMV3VSNUNFOC92elp0eXNCWVE5VFNHVitYS2ZLOUJm?=
 =?utf-8?B?NUlLUWp5V0E4dDRrbXk1MG5WSDYvVTVTbU5NWjVhQUowNnkxNzVJVnlYaTBF?=
 =?utf-8?B?aURTQ2FZek52U28ySC9vRWJHOXJ6cXdiN2hpWXlMOTBqU2Q5bmp2b29rWCtY?=
 =?utf-8?B?ZHpHb3Qrb1c1WVpPSHhwemNTZkpGR2dDUGc3Z2lxVTNOdXJsV0pqaGpzazF6?=
 =?utf-8?B?ZjBtNVFKOU43c3NYeUZwRGFabVkyanMrSktPQkhZZmV2VzlYZ0RQY2hzVEtN?=
 =?utf-8?B?d05wSktoWFh3cUZYZUdJVVlzSWltUC9Zc1FJT3V6OHc3NGRubjlJT1hCdFlY?=
 =?utf-8?B?RmthK0ZxaXZJRElnaG05ZVdJMDZ5UjFiMkJXdXgyOFozenBFeWluK2ZVWVAy?=
 =?utf-8?B?K1dWTVRUTUlXejRMd21XMXhXZkIwemR6Vy84L3BmaWFZb2RObXM4cVFDS3JT?=
 =?utf-8?B?NGhLUXg3cjB2VXBRRU9xWG5WU3pDMWRkMmlaVnpURHZOVllidk9vRjE2Qzhw?=
 =?utf-8?B?R2tTajNmOENFcXJHVGd6TWlMOFhxVjhRdzlpTmtrcUF3d1RjTHQ3cUs4UXA4?=
 =?utf-8?B?RldNYXg5NGZEU3dwYUhuOWdFTjVWelFjU2Q1cDhIQWhQR1duVnJxSkxWZHhC?=
 =?utf-8?B?cStib1ZicElHWVdRNjZZY0ZscHh6cTN4ZW1yc0FFSUJJRElyZDllMi9VTDBU?=
 =?utf-8?B?eGRsVHVWWENTUXBEOHQweGNHczk5eURneHl1L2RKTnpkYmtGY29NYnljRllS?=
 =?utf-8?B?Vk81MnRMOHoyZlQ4RXUxK2tISFpKTU9qZWx2dXlwblRRaVlSbXN5Y2N5YkVC?=
 =?utf-8?B?eFFDTDg2VnRaTVl3U09ZMW5iZzN2V05lQ3p0cUpwcUZUTkQ4dGFDNEhEZlR5?=
 =?utf-8?B?SFhXR01NazZZL2VUdkU5S1E2eHZPUUxVcXk2N0UyRGlyZkJZbmY5NDhtc3Z5?=
 =?utf-8?B?dE5ERGQ4dkNvQXkwVFh4SlRRN2RFMHR6NjAxc0szaDg4OG16TUd1SkdPVit5?=
 =?utf-8?B?Uk8zSk9OSnpoaHhYSkZwemxXSHJCNWh2eVFqZDZRVzVCUlRSM1ZjWVJ2RjNv?=
 =?utf-8?B?eHZSYzN4bnhjbU5CaE5KTVJQMlR1cnh6WU85d1dGczNYcHhBWUcraE5QMmxG?=
 =?utf-8?B?UUtJWlUrSXM3RFJoNDJCL0pkNS9CaWxjMUhTMHJGY3p1U3FUcmd0VkppTEpm?=
 =?utf-8?B?Zk82OG8wNlN4N3F2K2JJNlNVd3pqbUdhYm4vZC9QWGhnV3IxeWdOcFRwQy91?=
 =?utf-8?B?RW5VR2V5Wit2WTRFK29VVGNFdGd4WHhUdHpralVEUGRWbUpUejROemw4alF1?=
 =?utf-8?B?TGJqdmpYN2d0aCtMZDdaM1VsR21BNWo3V0dXYm9YSWtIeHk1cnFwTENIckY2?=
 =?utf-8?B?WWpHNmVvbWVMSWdsTFBZdzJPeVB0OENHS1BxR245ckZWSnRuc1JhOFNIQWo3?=
 =?utf-8?B?dW5Ha3ZhVjRnUkpBS1VXZ2EvdnJlUlRjV2V1MDQzVkxldWJsaytyYUxjSDZa?=
 =?utf-8?B?MjNjSko2UFpaNVJSRzR0V1VOWHRHeExZeUkxRkhDQTRlOW9kT2d4Nm92ZDlj?=
 =?utf-8?B?YW1IWVJmNGhYTHRjdjFuVC9IN0VlamZHcnJxZHdyeXlnSjViTW1nWnNDbngr?=
 =?utf-8?B?ZkNnL0J0QzJ3MkorY3NUVnA5WDFPZW1LSks1SnJYWHN5WWNPaS9VZ0dCQVA4?=
 =?utf-8?B?dW1FSEJsU1FnS3Z2dGxCVmpLRmVicEpJdXgvaVdwanE1cUdsNzQ3dFhOaUpC?=
 =?utf-8?B?M3NZMEFQVEx6Q1FmTGhqVm9Fa2g2TFh1NHIvSjJkbkxiaVd3SWlrWlhIc2hz?=
 =?utf-8?B?MVMyaDA2QkJNZW54S3RQUHVjdXg5cDRzSkw2cjBwL3cwdTNvNzkxSllrNnlH?=
 =?utf-8?B?SUpPdTVMZnpnY1hadm5TdzNzcG8yU0Y2MlRWSWh1US8vcVIrM2ZGZDBrRVhN?=
 =?utf-8?B?ZHVmZW40TWhWcFFZZk9qYm9TNTVYSlZ4N29ES01tdWdYVVk5QmsxeU1qbW1G?=
 =?utf-8?B?ZFhrNVdRZmxBSjA4SUxybTF5WjhQVnVaejRteXc1SEJhVGpkVTEvUTBpNktt?=
 =?utf-8?B?TEhJdFIzZXJNQkxxMThkdTVoVktiZkZZekcwN3pCblM3TFRRNkdzbDJaSDhB?=
 =?utf-8?B?bzd2WnVkTGgvbHMwWklEWEF6ZzJBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4f9380-6299-4588-2424-08ddc0618ff5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:59:01.6714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Er2sOMKihYQjcjOk7/m1qjFP56qE0uJrs6SwlB1VdAmmUVI+nvPenwbCvW/n8Z6qdO9EE9ebliOG8p1sNVhQqeLC9EjhWLNyGfq4fKmzygk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7918
X-Proofpoint-ORIG-GUID: DUV1IPUWAKKoOZeYmr4crVCfyFyhjRTB
X-Proofpoint-GUID: DUV1IPUWAKKoOZeYmr4crVCfyFyhjRTB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MCBTYWx0ZWRfXxT1pNbOri/yL
 QTxKkf76nur9zkbLh4h7/3op9cHYraIX2zOfKN7Rq/mo2F5dX1iPRxNCk8TCucn56Nrag9hyQGq
 YfzRgG9A1GfLxmMPyQS91XeMzh5VgvGTPzJCqMc9Dn3amOFC+gUalM+6pyfvIo/hikH3y5GAuyy
 JolVCrPD9saQ1C/w/v8BNd0R9L9IwITnKDB/oqqtWOuhYDO0XJtoD+N7b2eqsCFNlUB9+D9uibb
 +WKboeu+/uLiWZcFLOK4zX2U2Da7vjnkzDP1nHMI3I6R8QrhFaJSCGBdWXJ1Gs+B1jAegFrqecV
 ChDtVCX72Oe9o4fYLSrDkJhdrHEY9sR543I5UMCPmMSkpyZKYW5vPN8Ah1taPI/KOsED7iquHoS
 qnPzcNSk8RYlAM1oK0T6XKH3q1uQQQRaZdKjzKQbiJQ6tLuv90uHq0xYV+H8X0yfGEMzq4hx
X-Authority-Analysis: v=2.4 cv=fNg53Yae c=1 sm=1 tr=0 ts=6870e067 cx=c_pps
 a=uhh9Xr6CjD6FiqEknFfS7A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=XqeNvJXGgvzUN9CD1PIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
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

By definition PCI can never be enabled on an isapc machine so hardcode the relevant values
set via pcmc->pci_enabled.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 59c2949379..8277aaef1c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -474,7 +474,7 @@ static void pc_init_isa(MachineState *machine)
         }
     }
 
-    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
+    gsi_state = pc_gsi_create(&x86ms->gsi, false);
 
     isa_bus = isa_bus_new(NULL, system_memory, system_io,
                             &error_abort);
@@ -495,7 +495,7 @@ static void pc_init_isa(MachineState *machine)
         x86_register_ferr_irq(x86ms->gsi[13]);
     }
 
-    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
+    pc_vga_init(isa_bus, NULL);
 
     /* init basic PC hardware */
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
-- 
2.43.0


