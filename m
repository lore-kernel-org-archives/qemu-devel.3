Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7FCC61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 15:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzy8K-000352-3s; Fri, 28 Aug 2026 11:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzy7T-0002Ti-QF
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:03:52 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzy7S-0008Ny-3e
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:03:51 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SDTNDR2742378; Fri, 28 Aug 2026 08:03:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ttdcexMC44C4E/iPMZF4ffCMEZHtLkmBjRba6BS0a
 hI=; b=zP+H8rr0c8iV9QnsT6l+389r2tEzDrlwGJlj2HI5pQu+bRq/T+0Ckj+pM
 5esZjDw2cm8h991R1LzHJZz+A8MSUj9a3CEKsTm9e7b1LbRVvmCLh5fNRQoPJhRk
 pOqVtKuq7XVJTs1gOhOlseKui9G4ZOaloSECz/F6Qd1Jf05UMBIlgrAJBFDRzjxQ
 tCl79BsgsAErB0ElxYNww5RFIc3WMBGib+GDgkYCc23x4k755mf0oYLOQR4D29oX
 NjKbNrgfMSENo4EhUCBdojMHzaX4QNmHLl/BkAcDCuUIdd7S6M5eERTTn8msmYA+
 h8uJ2f2gJO2AIVSZHZ3bWw6Hs40dg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021107.outbound.protection.outlook.com
 [40.93.194.107])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gaq9uu6bk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 08:03:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEHObKkUsPXomL3OG/wvrELSUk2tUsy9r/ljmPk6hmdIGycOuItNoztTlq/FHCtsJ/h+D0MyUl+FBdndSk7N6Y/8gdwNXI0eJgccXM5tp/CiHOL6smn/IMgC1h43Cm3syL3DvbKTQFfVnsekk/wm3V5RCZJO/mk0xu7BaGgsMimCfBoPPMHgFqNIl1+t5BrCHxzaQbOeR0tFqyD7qFfhSpfV2Li5aB+SUdrIrLcMPieXWro6sH6ILwhMc7BTgFwxmohkGnu/q9lwnXR86F/f9LHGS1r24HGXvF6O7MqOpeakWmew2PY7GWac49Vz3lkTO2mZDjKm6iJBbFnxhGsk4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttdcexMC44C4E/iPMZF4ffCMEZHtLkmBjRba6BS0ahI=;
 b=wfL96ngekA5O5QGQuIaBNe5Nykc3MjoK3JR1qoMy7jyEPEEldIfyfLohPmWXZDgI++FZqfRSAxTxdnrmCDcRCaygh2XC7fHwcU7gg21a+Ywzw9Hx2uu1Dw7NhYCHWVFK9ig+ZEON5U7T7wunVTVC9PUkzibPKgc3TlVYrD/XEaZOBw9yrqSsPoMEYDVV3YuvoKMJVy4Mb3DcJzE43VjXylU2UPaF1xpVc/0XFt1MsLMzNchOzv6AfqNQxq8z9O4YJt+UdgKi519EIGckODVNVTXsER58lXQY+unh6bWuBTaneIYnQME6Ufk9ikQt3380uKx+WhZGOz/Ty5cBTt4BhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttdcexMC44C4E/iPMZF4ffCMEZHtLkmBjRba6BS0ahI=;
 b=V/cadi7DKcGoBmoU8CJa9zAbTm8PYqJD7maeFX9TLCwF+I6vv9LLTBUC7BjfQY8ZHS5fWcG0L3tgaAuWbIWRum7SAkc7xQJLzotu342kErq+SuXhchrMJPKScmyQeNLRFpudTnW3LfZv/aCviZn86n32zV/T3GNa/BCvhKolMuK3ZCDQfKFElzNyRYEm7NCKEDsQmftYfHPMzZbxpHCcGid85qacKLlvcT2LZ+nRBE/XKo2NewQCWUciWCiCedSr6VsNLqHFVc8/XxpNdYYCT9xURg9kK+xkDhO/uZcJYrmZF+oMEnS+WgcGFzC/k5f7pk7oTbT+59eJJwrIUVk4rA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM4PR02MB8909.namprd02.prod.outlook.com (2603:10b6:8:b5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Fri, 28 Aug
 2026 15:03:44 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 15:03:44 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 8/8] hw/i386/sgx-epc.c: convert SGX_EPC_SIZE_PROP object
 prop to class prop
Date: Fri, 28 Aug 2026 16:02:04 +0100
Message-ID: <20260828150313.1883999-9-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828150313.1883999-1-mark.caveayland@nutanix.com>
References: <20260828150313.1883999-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0159.namprd04.prod.outlook.com
 (2603:10b6:806:125::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM4PR02MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: 7044f4d9-9d09-4924-26ce-08df05158dbd
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vUkkPDQzMPBjF0A7r4zbj+RJscgF+uXrNnVVMWXxlLVYNKsG1N0rM6pD34r2gc5tlbUelnG2ptlg737FsDwYj4nQGaw5An7cyPsOkg9bl5cNa+ARXeH2VZzIJ7tJjKkEHRl9BTOGHO4Hw2Xb317nzWSWNo89k/449kvcwcLxzMbSyoS/kyqq/pghfg2vM5hZIrQj3cRulyonPZTwIoYvYFpy+uNfSOM7F2bxGhEkwSdscNtccxPm2vMBb21SuaTuT1RTsicUwFcXtI7LDb2er4LHJTLwTgDSc+RJVmMeQYVJM8YG5Fh/+stxVEwq3ez5pYY7I00Uut1IzvcG5qveNHMzuJE/8rNmH4jrdhC6G0vmmkEyHQL6q++7nmAF/Ko7insKJmCefWUqjgJCw8GS52VJHC9x15jehhbfJiECPF9nRRdYBAh2qfceCvc31xdewr/jinTK9rpuXk3mW6TYYIjwp0W8nYuRaY/E/vWOVYVeJK27xwiSWj1nyixshcgkj9ER6Cb9cqizy+brMmVpKChKQCBlLH0UV0r/Cl8Il2ZM6MtsukR7U7ix4AWy8s5OYsJfYAXpEbAArWpcGa2k/Q/qPQDGSZr11t9YrFS3lHzAPEpXfK6z99VT59KUN54cagu4E2Le0DV+PFBUsoOTGa7Fxhg4Eabg6guD09cPvVg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TENPMCtjSmVRajRkbUtrWk9mQWNHeEU0aHdCR3JDaWljZWNTdWtzWjhxTWlQ?=
 =?utf-8?B?N3V1NmFwS0Y3K0hnV3pFTThiSkZ6M3dsaTU0N0VhRlVlMFZEd3JJM05heEdu?=
 =?utf-8?B?NEpad1prSFNBNVhkLzcxd1JhcmdXU2RkV09nYlB3REs2a1A5ajJrSi9hS2kv?=
 =?utf-8?B?TDU5RWpSMU1sMVN2ZTJBcElIV3NQeDFseHdTTlVWNjRaRlRaODBUdWIycVJt?=
 =?utf-8?B?dnVDV2Y4djJ2VXVLaXVVa0dtdE13V2IrSU1xSWpUSjN5MEtLdnZjcXgxbmRV?=
 =?utf-8?B?RVJQSkVVNU9JbW04eG50WGhxZlkrUHBvMDRkTXFUdWNGYW04dnZ5Vzl5dU9v?=
 =?utf-8?B?MDR2NXdIL3Z1KzFuUHdhU2Z1aXEzMzZWNjVLSjlueXRkaVhoajkwNzhpZkkx?=
 =?utf-8?B?ckVIVWpBcC9Ecy9pZFl3S29aUkFWbjlkVG1MYko0UE9kZml3cU9xc3VEUms0?=
 =?utf-8?B?TTEvQmUrZER4MVpkNEEvM3NjNTZCVzFSM0dPdjhkTlZ5T3hINjdROExPL0NI?=
 =?utf-8?B?d3JEZzJzYXh0WUVTRUpKNllkZW9ESVJVTEtIS2ZnU3lzdGVkSHBoeUJVQUt2?=
 =?utf-8?B?c2VoN1UxT080M1ZCN1psYlZiTDdXaEtxQVYvVE0zdm5uVnIyUXMwdktqTUZj?=
 =?utf-8?B?M2c2SWlaSy9GeGRLY3JpRlZ5YjBDQ29tZVNJWnRDc3UvRGoyTGxEZnY0ejEw?=
 =?utf-8?B?d1h3TFlEc29lZ1ZkbVJvN2QxRXlwTVIrU1lNZmhjNVNDQ1Bya0wrUXNJSHc4?=
 =?utf-8?B?UjNOSzJLOVM5V2cwSThkY0RiQjZ2OEN1TmhVQ3J0OENuSzBScXV3MzcwcTI5?=
 =?utf-8?B?ZCtCRDNjbDdia1UxZTVtVE9aT1VxRDZ6Q0dGcy9pWitXelpTL2NwWmNJZ1k5?=
 =?utf-8?B?OExCdlZaZEdKNUwvVXlsM0RkYVBPRTdHTkhLNjBkK2ZsbERTeUp5YitCTjF4?=
 =?utf-8?B?dFRraUxEN1NyVDNBZ2hkS2k5RjREcDNwci9zaU96TGNOeUd5WlZFZ3plaWh0?=
 =?utf-8?B?ekJFcmdyN2VtN2dFWWJUS0ZNUGE3alNsUUdZMFpCYnRUcUFiZndnN2pWNXov?=
 =?utf-8?B?SGMySTkzQjhxa2VjYmptRmZBTUJDUFlvL2Q5ZDhVelB3MzdRNnBCcjUwMTFq?=
 =?utf-8?B?VnV1Uk5rZzI1Z3I1NEFySUlpQmptRnhPQ3hVYmpPLzU4RkJDSTZpOFo0NFFR?=
 =?utf-8?B?bkF6aXd3VzJiRTF3OWxtYW10bHdMT3VQVGNHcGZZY1pUdjlxd0VWMCtEVzk1?=
 =?utf-8?B?L0szMnc5ZE1MSjI4MjgrdW1idVEyeDQ5R0R1T2NFVW51SGMrcE9teGlLaXhS?=
 =?utf-8?B?SG1ucVEybGxKM0pQSWk3Q0w4MDVoRC9ITUw0b3ZjelZteXcwc3VhOFVpdGRa?=
 =?utf-8?B?WGVNdjhOczBzeWJBaFlJbXU2VDByVi9td0d5MXZHYm4vVElCR1BSKzdxRHNm?=
 =?utf-8?B?aVFva2xucVBRRlR5ZDNscmE2VXh3R2tOUlBMZTVJVndUVlU4dmJCNCtoNllC?=
 =?utf-8?B?OFo5bTNrdHYxeEVZVHhHYVBuSVdnYXpmd0dhUnVqcnhYRmF4OFd6Z0FvK2ZG?=
 =?utf-8?B?cXN6N20yU2Nwa3J4QnJTeitVWnhEWDkrbnkwbExaeWtaVVNPZ05taFdPVjI3?=
 =?utf-8?B?YlQ5clgzNG5icDR2RjJrcUNBWHlEZTBZWmo0eVZUTHdxbnZFa0dVNDZpTVlT?=
 =?utf-8?B?amR3TXNUOFF6RlJ4VXJjeVNHZGxSMDNrVTQwUlcwS2NZMExhZ205RGtCenhh?=
 =?utf-8?B?aW1DSWI1cnFLVTZJQXpNM0hHOXQrUlBRbi9vdGVRZkdtVnp5RVE2K3FLbGJ1?=
 =?utf-8?B?Y3E1aDdReGJHS1h2ME1wVWdML3JQTTJvQ0xkcGR3STlHY3dkU29WUGhkWWFp?=
 =?utf-8?B?d3ZFSmRKN2IyLzV6Q0dpa1FuaUduZm5QaGI0VkR6ZEZFSDdrSFVDMUxIL2lq?=
 =?utf-8?B?VG1xUzJMaU16SWVxaVZOTld2UXFIYTJlbStPWWMzazkweHB2cittR2ZWLzZT?=
 =?utf-8?B?cDQ4a29kc1VkTTVkZlNhTVRmbktCUFF5ZHNZTmV5MFpkaUlqMXV4VmhkeUZY?=
 =?utf-8?B?VDkrdm51bUQ3ckRrK2RUZk1ZSHJLaFBPWHlWOFVUV1pzNi9wanFFbHZMWE9a?=
 =?utf-8?B?YUE5Mi9QV1A0UlZMSWZuOWtaRFpXczcxTytHZ1ZmNTlvdDFoQndpMzIvNjhZ?=
 =?utf-8?B?V1J6QXhzU3hqaEtnRzNPdzNkU2NqaGJTQlFBcVd0SnFNbnBiWXZLaVVSUkJl?=
 =?utf-8?B?OUVKUXhjbVJMWWFheVNPWUlBdlV4NWlvV1JDT1hBYzRpcFZvbWJSbm5FYzNt?=
 =?utf-8?B?MlBHbFlQYUwvRk9DNW81Y09vb0NNMlQ1THhBRDh4MXFoUW5VNWJoTkttdkNS?=
 =?utf-8?Q?LRfgmHGaExgdqa84=3D?=
X-Exchange-RoutingPolicyChecked: CG9yTzUM+REioja3+w4qDtcITILmR/JTnBvw0bPeHd1PTbYPFlgAAFa3H9wXRRrNG5PscY+aLng2ltiy2vSlS4gl17+f9JsImYAZ7Zj9FEamc5HPhNvZCBSYxSMQkrA9V1bKhKGjfKy/Se6TTy3Th0uCaqmoO5/LKF6g7d1FQKjRfk32yL0poUPKP30arRr2eJ4QoahRW/Yd5Yiaa4CMwVsk175vViFZdjHLX/mb8MNyUEUEintAXgLMxB8JlPPZAM0cpWr+MmCHOVJfJNkr4/C602Yd8iZBhXL9k6Pono4uAXcBSH+7m8cmVFcfiBG6+CErRk4n5vt145Z51zpT+A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7044f4d9-9d09-4924-26ce-08df05158dbd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:03:44.1188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RR4cqm3gndwzfkufPo69Ex34yH49jWXlpFG6A7Z5gJ9Ok4Mgj1GAqqC/jG9FvSHCL9G95VydSObHQDenL18acZjbE81wuaUHEQKG+l9ZvaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB8909
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzMSBTYWx0ZWRfX4Q57FUC5T9r+
 GK4XnybaXNO5KA/WLJ16TovWXMK9wTi91gHsfIQ2J2EE0OVGShjBOw5hM+atnPAdIPyECB8PnE+
 0t+2iDj7i3R5b/nx4AlmeO4LgmWPRxwT7M3HGVgv4D1RB1D/pIpcICQihPY95ckUonM7U8nf2E8
 TyRg86bGJ2MjPkKNzwoMXeqPMYu3sd5LoC+s56o5QnCYqL1IJnNVbgusEgxFrfYsgaJBMkCC0NR
 /xcm/I64m1IxCBB0PnFsnrxwQk1UwZgZOsFWMk33j4xFF9mDjNMZ+ojRrNhAvmSaZRsnh+bHWG3
 O8HxOPyJPIXovSwJqkYe9J9Lz2NIUj/NlJjiJZb+edpxLcc5hC/5lce3UZLveKeZ2MrYkhskPpO
 oaxf799vcVxcq/MTXsLHKu3/TqSz4ChL3cNPcwdF5rsJY0JcP6x0HN0g7rHL21YyJsuXpF5BKV4
 J171kFjPBGc+pD/Zm0w==
X-Authority-Analysis: v=2.4 cv=ONQXGyaB c=1 sm=1 tr=0 ts=6a91a353 cx=c_pps
 a=xmT5btM1tXsMPZo7WXzprQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=tlSEsSRgIMY7PNDPInsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mxMLb-gJh3ipBtJhO0FLijG8rfg-ski4
X-Proofpoint-ORIG-GUID: mxMLb-gJh3ipBtJhO0FLijG8rfg-ski4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzMSBTYWx0ZWRfX47RYUxPGUf/H
 QK5I7czDTmFL7rQ77y/rKPdIFg6iI/ugtvYUIr4tHu3BYz2HOZvm21MPiyU0/26RjT0F2P7dSoY
 l6jXizefzfLSwI0oz4MBdRFIQX308LQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Remove sgx_epc_init() since it is no longer required.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/i386/sgx-epc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/i386/sgx-epc.c b/hw/i386/sgx-epc.c
index d3fe10028c..29cda843c9 100644
--- a/hw/i386/sgx-epc.c
+++ b/hw/i386/sgx-epc.c
@@ -41,12 +41,6 @@ static void sgx_epc_get_size(Object *obj, Visitor *v, const char *name,
     visit_type_uint64(v, name, &value, errp);
 }
 
-static void sgx_epc_init(Object *obj)
-{
-    object_property_add(obj, SGX_EPC_SIZE_PROP, "uint64", sgx_epc_get_size,
-                        NULL, NULL, NULL);
-}
-
 static void sgx_epc_realize(DeviceState *dev, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
@@ -164,13 +158,17 @@ static void sgx_epc_class_init(ObjectClass *oc, const void *data)
     mdc->get_plugged_size = sgx_epc_md_get_plugged_size;
     mdc->get_memory_region = sgx_epc_md_get_memory_region;
     mdc->fill_device_info = sgx_epc_md_fill_device_info;
+
+    object_class_property_add(oc, SGX_EPC_SIZE_PROP, "uint64",
+                              sgx_epc_get_size,
+                              NULL,
+                              NULL, NULL);
 }
 
 static const TypeInfo sgx_epc_info = {
     .name          = TYPE_SGX_EPC,
     .parent        = TYPE_DEVICE,
     .instance_size = sizeof(SGXEPCDevice),
-    .instance_init = sgx_epc_init,
     .class_init    = sgx_epc_class_init,
     .class_size    = sizeof(DeviceClass),
     .interfaces = (const InterfaceInfo[]) {
-- 
2.43.0


