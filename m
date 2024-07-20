Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E657C3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 20:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVGFn-0002I8-L7; Sat, 20 Jul 2024 16:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVGFk-0002H6-PI
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 16:00:25 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVGFi-00015D-SV
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 16:00:24 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KJtdLX026468;
 Sat, 20 Jul 2024 20:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=n7AX+wiNx2T88kty9VOeN4df03iLR8GfurWksr5LyK4=; b=
 lTeuLEgqg0UIBf2nJFq0fNU7wV3T4EZk3e/HNBH1kapKorFypnv25Yg6AZ6qhngM
 w7GjtqcGoAdOeT/FX5SCScJ2iRSXvUIiRsTc11FZEgVa20QytQy06fAh1zoAURoE
 V85XtPdmzEuS9f/IxC27H3/pHuNY9qYaf/UTMD1xvuZ7bWwrv+5UVd5Oa2WciQ3e
 ud6DhJ8+/9ZRj2xsmKp7C+N/cjOb7OU1SvOjtkgFgaqj4nfAg/jHlhCM97w+opqj
 JroDCuBr13Iny1GrW7Q2vnusc2NYvGfL8d3VzX5T7PLe92DjhxF3yDKNHd7GFSXP
 FJyGkhX79IkES0NNJtEjLQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gktmg030-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 20:00:17 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46KIFV2c024447; Sat, 20 Jul 2024 20:00:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40g3p5y91v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 20:00:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiQAFdUQNzHBiTQ51fkduudwoczjNLG0RnzVH2DZCC0nEaNyALMfOomWbsqe15oBtEaXeMkdNM+QyVOGtVtlHodkPh8XfKe91AvLVEpK0gzzH4bJrSWL/7zrPi/ewqnbhUqwmY6uaPRu/1qKrBJ7SDE7jGzhGH8yvOrg41B2T/4aG3tkxOkUKCcCdnnUxRALPkdYv4l3dkbbtrVFtHnEc8vZCiKC9jTMwasJQ3YSIQGos4OU+VE1Z9x0wl7qJJ7UIIQSxoF0cgWy3s2v7WGnfH4ZTRbtNN6vj1St4akQ0q5akD8xETzFebihL205QoaQmFJtCgpSuxCb++Y95w2XZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7AX+wiNx2T88kty9VOeN4df03iLR8GfurWksr5LyK4=;
 b=obq91KqJ0JeubGW/z6SWTQPqyXpUXc29Ug3q6Fsd7crPHnox/i0hr+xgBjjwZwLknO4dpEwsh9zWg24qj9xofAVohYtwKRyymyD0x+HUzI2fGRV5nrZGV5Km08coEP9HKIkYqJ1fI6tMQi0w0Vp4b53sHf8JIWZfiQ/AONRZOCjv7iztz+Lhm9UiNIJgbaj8g7mgdDa6Tpvdp0NGw9NXf3W6Oxp5tn9UTqfN2E0GfmGGWXZ1cl4amrNYe+KCShm7QnconwYO5LKWgaALXZr0AECC40aW7YaJi+G+mID3Nda6vcBJ59nHdp37fefkorKt+JY/Y8cK5Woq1zSn34isFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7AX+wiNx2T88kty9VOeN4df03iLR8GfurWksr5LyK4=;
 b=gClUQJZoTWPw5ngvoFXOXNqkWvCOAwygzwStV+b0E1JKG9+HMrxVuZvy2tbfQZL1kDqsBhhgVgK/xUBnr3Pp1ZKqwqWBtZ5cbFknupheoR+FWdwCOdPT2JEYUac7dvYw/3zxCuz9csNSZs353rebCXJX4rQbJB6LbRgM/IJyhAs=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH0PR10MB4789.namprd10.prod.outlook.com (2603:10b6:510:3c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Sat, 20 Jul
 2024 20:00:13 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.7784.016; Sat, 20 Jul 2024
 20:00:13 +0000
Message-ID: <0d1e8314-cc14-4bd2-8d80-93f6291ada1f@oracle.com>
Date: Sat, 20 Jul 2024 16:00:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 04/11] migration: stop vm earlier for cpr
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-5-git-send-email-steven.sistare@oracle.com>
 <87sew726b9.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87sew726b9.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::25) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH0PR10MB4789:EE_
X-MS-Office365-Filtering-Correlation-Id: d63d6e4f-6bf6-4187-7e14-08dca8f69128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckt2NXpYS1BsS0Nac1h1ZEZ1Mm9QbU9jUnhWNzlLdTU0YTI0aUVoNmV3aFcw?=
 =?utf-8?B?eE1SbGRWUjR4bzBWWngweEhVNGxXTTV1MXEvZTZVS0Z5dlQ1V3UrVVZ4K1Qw?=
 =?utf-8?B?eW5PTzBCeXVvU1ZmcmY3UlE2TWtyakZieEkrVVlsTEFvMW90bFE2eHJ5SHNw?=
 =?utf-8?B?WUZ4WUNmTE9XczdQT1FQcW01REpuODJUTkh0T1B4T250UzJOTmY4dDJMTTRn?=
 =?utf-8?B?elp5YWN5eTVyWGtqQjNRaEtoZUN2VTFkTmhBUWdkVjNLaXY0eXN1UmNYell1?=
 =?utf-8?B?MGNyenhTaTJpVG9Ma1R3WDJBdHZwci9tSFZqeDA4aUtUdlNyQTlpYnU2SjRs?=
 =?utf-8?B?RXdMT3c2R2hzcnJhZ3g3RGZZaEgwZjk3NXd4M3JrS1FnYTNNTzN5NnM5OE04?=
 =?utf-8?B?WEhTcXZVUCthSjllK2ZKMjRqblFkckZGZCs3MzBMaXJLRWVNZnVTNTFyT1FT?=
 =?utf-8?B?WkYvWnhSNnZJelByQmZ5TSthb2JkeDcxeFV6eE1lR0U5MmRzYjVrZURiZzE5?=
 =?utf-8?B?czFGdCszUnZjRDc0ak1hR2l6b2dmbDU3SjhSRC9QWTRHZDhnRG5LNS9STHc5?=
 =?utf-8?B?WTk0alRQTEVna0ZnN05RdVd3dUIvZkJmMG1SemVabFJJRHFJTnBQRjROOXYz?=
 =?utf-8?B?WmliNjBPQUFKNWxWMjRHbzBCRDhsSGJWVUtieFFQVk5rVEpkeVNKSXdOL0hp?=
 =?utf-8?B?R1BsbHhTelY1blIrTkxqYXlyUDFHS1FlVE9RZ3Y5UFFZQ1hTUjlOQzU4ZVlo?=
 =?utf-8?B?VkFSRDViWThEVTZUQUxMaUhTQnEwMHdkTXhLOCtvSGRRM0VWSDlrWUZPSDBw?=
 =?utf-8?B?MW1uN29LeWhXSkVVRWdoZk5zVFFxcGtJbmR0d3hzb1lPTFZOZEFYUVpRSFd2?=
 =?utf-8?B?bDdpUDB1UXpVZnNnK3UwVit5R2NqMmg5UXk5cW11ODdXZjNhaXJaYno1bVFU?=
 =?utf-8?B?RGZ1TUR5aW94bWplbTVWdXdpcUlLQWxBOXc2K0E5QUVsSkU3WFo2V2UyY21p?=
 =?utf-8?B?T3ZPcXZjdXVUbjlxQzBVeU9yeEhITTRxamxOd2JWMzFnQ05lNnhIVWRaKzBE?=
 =?utf-8?B?ODUrajViRU5sT3M2VXhaSVoxbzNKdVNwc2hYWHIxdE5BS3JkNlRBUHlXR0Fk?=
 =?utf-8?B?NmR5akZVTDVsZE5XL1drN2JndWU1WXczVmtSTG5PelNBeWxGa2J1VE9PRXlw?=
 =?utf-8?B?T2RzUG5XQmpzdEF0Sm1yc1ZrNTlhaDNjQWx5NG1Ed3BHRzJzTkJlWkNheTlq?=
 =?utf-8?B?Ylkzak53V2RrTWtqZll4OHJPUmZkaEY2YWVSMGVlbFJUOVhnU095WmVkL1pY?=
 =?utf-8?B?RVZndlFMMUdYSWpMTE9PSGZuNzNaY0twR0pHM0xxakUyRFRSQ3hvaTJ1amZI?=
 =?utf-8?B?K3BXVEVDK1JhVjROUHRpRThUWlpwSnJxWG9may90UVhIMHRzbFdZNlFsU1F0?=
 =?utf-8?B?N0JzNUg2eG0xTjRhaXNPYlhWM3I1MG1RQkJhMVdmWFFIblM4N2dGWWdjbWFU?=
 =?utf-8?B?cUczU2NkRkJQc0tWUkkxUWNaWTNaWiszdDJQemhSZ1R6MHRiUFcrUm5wQ2VP?=
 =?utf-8?B?MHhOSHZIZ1F0STVwTFhzbDkzSURwZzgrRGhERjlnZzlzNUkzZ29MNktMSlk4?=
 =?utf-8?B?NnVZSzVDcU1Fa2NkN1J4MDJOMUUxNzdiOFA1T2FOK3J4OTlCcWJVeE5JTUJN?=
 =?utf-8?B?QXBiVGszeU4vV1NNbWVERFFtRE8xVUJ0bzBLTUNhRCtBSnJVazVvdy90Mkdo?=
 =?utf-8?B?TTZuWkYrdyttaWRjdWVoUnhuc2VQbW9hTlJwSmMreDBiOFE4b0duS0NvWmIv?=
 =?utf-8?B?YnZLd3VKd0dQUEZsQTMwZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXhGbmNvNDhJa3diaEZ0aFRtUHk5TzdqN3lsNUNwYWRtRUVMZ2ZTbTlncit5?=
 =?utf-8?B?TVRBclREMUVwZXE1UWgxSjJWd0hZQWIrNFBPMTlQcUlHejBaTUtDQVJBMFdD?=
 =?utf-8?B?T2ltOE1WV0E3TCtZYTR3UTY0VVBVZmVqdlBKOW4yS042eEl0bHNWYzlVNUtj?=
 =?utf-8?B?S3hIdElsQTFrdTNBeElNVjVZcmZZR09SajJ5OE9kU1BYQmsxQzJtTURocWhL?=
 =?utf-8?B?T2ptc0V4Wkc5cWtnK042S0Z0VDNvZzRBbDAvOE9JYlpmNXZnRWJVa3l4Uy9M?=
 =?utf-8?B?bWRJRWNzT1dvSC9JZ3IxR3cxb0gwckVqNCtwL1pySUdzaVd5MGxTc2xUdXZn?=
 =?utf-8?B?Z0V3OUo0SlBMalB6OFZBZDRxUDFlYW1yaUZEL0dORFNaSnZhbmxOTnVzZDIw?=
 =?utf-8?B?VW80T3FBMTFTeUQvcjdLYTBtWjhqNFEzTVFPRUtVREMrMHMzYXZMcGhCM2sw?=
 =?utf-8?B?UU10ZzJzRzVxTHFIOEdPYUgxMXBIVjBaVld1T2N0OFZjVnBBUEZvaU9yTXdN?=
 =?utf-8?B?VmNyRHVGamliNjV5TXZtTnh5NkRMaHkxUmwrMWRrT1lpVDNBK2MxcVNHaWRN?=
 =?utf-8?B?ZUFNYTRHOW1MQWxEeE0zVUNBc0tWTnBGYmRLWjhZTDllcmVJK1dVeDEzTFdr?=
 =?utf-8?B?TWpYaFY2T3dtaDZzZWtYWnhMVUpmdVVQSTFJcitOUDBOVTc5akhYc1ViUzRZ?=
 =?utf-8?B?TDFBQ2NKdytrcDR0K0JieU1IeHoxUFBSM082R2tESW4vRXB1UzRIbmlsYXRm?=
 =?utf-8?B?Z2tZU0o4dFMyVWMwbUtrRFdicW1JTkxjSy9IakpiekdzY2RuRDNOMzgxQ1hU?=
 =?utf-8?B?VFVpbGFjOHh6RVc1OHJnb254bm9LMDE4TEhkb1FoVjljOGhPTzAxQ05ySTJ4?=
 =?utf-8?B?NklPejUyQU5TREV4bG5oTTFKNEFNWFZGQUEyYWxUUitRSWJFMEZTdkpFaFhl?=
 =?utf-8?B?bGNEb0oyZFRHVGhFRmNFaW5sUDVISGJCK1N5Z2tWUWpNRjZad2dNMnVNUFdo?=
 =?utf-8?B?bkxveWVXMS9JSGxkZDBzb3lkQXE1NE54Q21SSVcyOUZXOUYwRW5vYy9rQ0Nz?=
 =?utf-8?B?RWl5ejBMTjRYbk1vNGtOSVhBVnFlVFhmTHRTeEU1alNrS1I2MGc2c2E5MW5G?=
 =?utf-8?B?d0lMcVgyZjBtamZLRTgwVHNiaXJHaXNxNjIrd3JYazljcEJZSTZ2Nm9pWnFF?=
 =?utf-8?B?MERxdWFsZENmbjRlZnhtOEg5REtNdkhDK2I4MXRaS21rSlZzL2wweGhmWUcx?=
 =?utf-8?B?d1p1QWJUd1ZEdjBvR0JNSkdlS29UMTUxZ1M0YVlTMjAzUzNIaUJMSCt6RThJ?=
 =?utf-8?B?QzBqakhsbzAzK0lxTVR3YkRDMHVDYTJsempLekQ3b2pvb2x0OWoxN09GMVpB?=
 =?utf-8?B?R0hvaVJzOWlqYVVhV05uME5tREx1N1hvM1YwbDRic3BKeklFV0N1MjRCTklW?=
 =?utf-8?B?YW81eWhOUE5oUU5rb0I2WUc5TzYrL1NOUHJxNUZDV08xRzlZcGJMUmpJZHF6?=
 =?utf-8?B?S0dNVEhhVHhZV1Bmejh4ajczSkVSN3MwNVo3YkJNQk9mRSsxa2EreW1MNCsy?=
 =?utf-8?B?cUhqU01PQlN3VlkrOWZBYnM3UFAvQXBHc0ZnRWlNRkxzalBOQTdKVG41ZmxE?=
 =?utf-8?B?QUVKMmVBaFBNM2MwQUhxVmd1Uk1qWngzaDBCUTIyUzFjcTQ0akszdGtZeFdF?=
 =?utf-8?B?QzkzeGFoeUFkdjIwZi8vcE11V2ZQakRFdWhZa0tpS2Rjc3ozdjNJL3ZVK3Vr?=
 =?utf-8?B?YUNSQSs0MGxrclEzNnhjSkY5TDVxZDNYK1lyWmhaVHpNaU5UMnhNQml6L2Rm?=
 =?utf-8?B?K2xHVEYvVVpsT05ZbjFtdkRYNWhVNVhYZThZSkt5Tkt4Y0RDL2s2bXJReDQz?=
 =?utf-8?B?V3hkWHdDZzYxblk2d3p1SXBBQ1RQTnVJc1Y2Vnk0NFBYL0Z1T0J1QnptbUhT?=
 =?utf-8?B?ejg5WkpnVVdhNnQzcHlybWRORkU5RHhXbDc3aGo1UnFVTnd0aCsrM0NwemVN?=
 =?utf-8?B?UW1ET1BFT0k3ZC9YTjREY3VMV2FPK1NVcWN1aUF3T0luL2dZQzZxYlBZSzJ1?=
 =?utf-8?B?RnQvOS9kb0c3NjY0VkcrTGF4ZGlZSU52VmNjZWZFQ2hKamhhL1VWcWxLb0Iv?=
 =?utf-8?B?RWxLYzU0VWZxOG9TNmp4RTdXVlllREFrbUoxUXhIaWs1Nkd0QlV2bmtnREFx?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: v7MEWhWPt6svronhRC2rHsB8PhpkpfR2wYKp9bExw8HF6yB590iziKXu+xtoT7zuJ2/T4oGRw4gGEUIOO3X0TnFSrUD6901wAKflxJZKJkH3Wbj7AT2IqJy4txLRYJ9T7e6CEnMStzAj0HdeLVj20XdcnAawhcVWGu5y2sJ3ZJATB972YR6TX+X3qdtfpUAsRjA+7WXZ/PJz+BrCyJ9XJVAZIzgpvIqJoOC79JyDm5Xr0y7giQ874tA0F90pJurEC1bYX46fIX5wO2y5+bgLub8xD1VSxuDxJerFMrrKHGxjNO9ZU7MPHiN2rTJXjZU09L+iChlTBMnh2Ve9HuM6mZ0fk9Hgwjkicori3fQBqgAh7JMTa2HNbg+muELcFbpnYQZtFchPR6RqN1FrICtytvOHNEw0F8NwJNbgHJ2+/bD9OYbKyBaiK1fUihuxhu9X/0kk8Y/cW02Xe3490PlWFFa2whOv3k3N8J8YfIgNuXROuIMddzhMfndWRH51QvfsxLAfyb5VkxK6+hAwbGGD9cep/ldWM5HUrB82EX0AyuY6TUmNhdwIhoBxDysSSki5EIB4j4iiCQ9SQ3+P7JTimSLU97sfh3fTMHdLPyIKlC8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d63d6e4f-6bf6-4187-7e14-08dca8f69128
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2024 20:00:13.1909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDYlueXU77J5Tk/LDO5sIhYeizWkONwCmjjQQ9YZ5S2schy4zkoUjS6f7UiGQTvAgNZZTbe0IXqzVmogio18w4DJACHfrpiXOmBzoJ+ChXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4789
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_17,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407200146
X-Proofpoint-GUID: AOB1xseEvfZj6se1CwsJXGUrqJtiQuA-
X-Proofpoint-ORIG-GUID: AOB1xseEvfZj6se1CwsJXGUrqJtiQuA-
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/17/2024 2:59 PM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Stop the vm earlier for cpr, to guarantee consistent device state when
>> CPR state is saved.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   migration/migration.c | 22 +++++++++++++---------
>>   1 file changed, 13 insertions(+), 9 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 0f47765..8a8e927 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -2077,6 +2077,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>>       MigrationState *s = migrate_get_current();
>>       g_autoptr(MigrationChannel) channel = NULL;
>>       MigrationAddress *addr = NULL;
>> +    bool stopped = false;
>>   
>>       /*
>>        * Having preliminary checks for uri and channel
>> @@ -2120,6 +2121,15 @@ void qmp_migrate(const char *uri, bool has_channels,
>>           }
>>       }
>>   
>> +    if (migrate_mode_is_cpr(s)) {
>> +        int ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
>> +        if (ret < 0) {
>> +            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
>> +            goto out;
>> +        }
>> +        stopped = true;
>> +    }
>> +
>>       if (cpr_state_save(&local_err)) {
>>           goto out;
>>       }
>> @@ -2155,6 +2165,9 @@ out:
>>           }
>>           migrate_fd_error(s, local_err);
>>           error_propagate(errp, local_err);
>> +        if (stopped && runstate_is_live(s->vm_old_state)) {
>> +            vm_start();
>> +        }
> 
> What about non-live states? Shouldn't this be:
> 
> if (stopped) {
>     vm_resume();
> }

Not quite.  vm_old_state may be a stopped state, so we don't want to resume.
However, I should probably restore the old stopped state here.  I'll try some more
error recovery scenarios.

- Steve

> 
>>           return;
>>       }
>>   }
>> @@ -3738,7 +3751,6 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>       Error *local_err = NULL;
>>       uint64_t rate_limit;
>>       bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
>> -    int ret;
>>   
>>       /*
>>        * If there's a previous error, free it and prepare for another one.
>> @@ -3810,14 +3822,6 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>           return;
>>       }
>>   
>> -    if (migrate_mode_is_cpr(s)) {
>> -        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
>> -        if (ret < 0) {
>> -            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
>> -            goto fail;
>> -        }
>> -    }
>> -
>>       if (migrate_background_snapshot()) {
>>           qemu_thread_create(&s->thread, "mig/snapshot",
>>                   bg_migration_thread, s, QEMU_THREAD_JOINABLE);

