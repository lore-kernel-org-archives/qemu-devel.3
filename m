Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD865CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMzY-0007bj-BV; Fri, 08 May 2026 11:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wLMzW-0007b7-7V
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:19:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wLMzU-0003vi-8E
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:19:49 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648EQaas2835077; Fri, 8 May 2026 08:19:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=aKv/y/RWwRKkb6khSO0fRVD6tNBRaeGAWGXPIGFOq
 dQ=; b=zYsjfVia6sbUF/KQUsTjCR6C3J6jjK/Ko4NOtld4f77utuq/yXyTJh4A/
 0Sn3Ne51KiJd3M4JpagGyZFvviKGuznegIcYYN1BlWl6YwHSOHJcn+js3x6M9tuX
 QSwRq31+kRvyV9ohTWJf4DBoBjcvlvMj7UGWZXCbI0VKSJNNamS7K0Ar2+kmyxMV
 7H/leX+PNulh6f6qVJ0oHMDo5E/3ZMDiVqmWrdJ/DNGeF6e7HKtZtz317BWxp2OQ
 h0UgUZHDtr0oh3rcBcgZuWkv5kgK8Ql/XTayurcyu9D7wxci0pw6mVkoV4UUUZsw
 OsSUtrePjiR9WHL4CAzb1w2ItfvOw==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023078.outbound.protection.outlook.com
 [40.93.196.78])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4e074p6hn3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 08:19:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6L1n2qb+GIx1xeb/2nmThms2OGMuXY6IJsbwIwiAyUnFTUESkOSbbJYBZVZxLsrNaTgxFHFl4shnCFjwbGaOMgikt26h4GeuWS+u6IEUCkOkAfGJuZy8nL4nLUV09x6njAAYuabGq7oxfbFEwQKyrfSBrX4kAmbaVS+JxpLlWUDLTcqicqQ8c6CWwl+dwi4yQrMB+n36RJiLfGIbUlDMLKlcxXjjTrkqrLYijtLGYy1fDTTXhkODVX2srKLOAakqLsuKjkIyjtajo8ugbgfFTY1rsKmZR73Da8C3PuwH8Ic/64olGtTBet3iYrtojHyJNSWTkBkx1EQZV+4aJw2ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKv/y/RWwRKkb6khSO0fRVD6tNBRaeGAWGXPIGFOqdQ=;
 b=BsOkrFku4TJo2CR/criPLV8Jd4zADQayJjXDd1XEfiUM/ctmT9205JjY6W9t0FD1y2kR9j1en9v0WCDh6WTr2Ui5a3AyTsc+ANCoBXAlo3ZROsA40TIguHRjS6uLCYgOMV1eHVv1dOZxzRkEEJGIHyZnG4zgd+5BEvN0/H4ZKcIrWgZCRpzAjkCKOx3BLsy1Vzm4wYvHyUfm6LCDxuPEt+AplhtGOO/Zdua1K4urG7FDiK/r3eyQx7E4rGRyCeFaB7IRT0SOGy9hvko907pmoVy7KiSpfaMlN3dL6icdbuuG11AoNA1zGuZ9Njd2T/1ncTPAGMvcqUg4uT4XwzTx4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKv/y/RWwRKkb6khSO0fRVD6tNBRaeGAWGXPIGFOqdQ=;
 b=HinNaTea23Ka7cD0z2WRZxfMziCbSAPK7h4RvoPjQpMkwdE4VnmEZEgeth3995w9I4bayYQkcHPTmhVeFFsKyWiFGo/bsuW2qKGpeM1QkAY7Mxaovtacrg2mj3dM+yKC+FuVCclIpdQimYz36pfOUPcKqdcrcqEQtFturn+UXETxwEDTFpfWyqEmFJoOFdj4L2Bq19q5PGFYxW/JvJ5uppY2BZRXdtbidDaniURS0sPI94kntyAPuiTAPlB6euxsGBp2C0iMljLBVcOgZ5o3pkh7LQPOTplgzVZFBjt8RDmsaw+xF2bF+91AJn9s8Jpim2mzvWBwuqqOaLUFn5sJeA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DS1PR02MB10385.namprd02.prod.outlook.com (2603:10b6:8:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 15:19:42 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 15:19:42 +0000
Date: Fri, 8 May 2026 16:19:38 +0100
From: John Levon <john.levon@nutanix.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "clg@redhat.com" <clg@redhat.com>
Subject: Re: [PATCH] Mark Multi-Process QEMU as Orphaned
Message-ID: <af3_CqQf1wSSWYYY@lent>
References: <20260508102657.644247-1-john.levon@nutanix.com>
 <IA4PR10MB8301FE3A10AA391212B387EE903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af3zEgHy7UMYN4Ow@lent>
 <IA4PR10MB83013C640DBB740BE8872FE4903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af31Oo6gXE69c7eb@lent>
 <d7c29d61-9146-4cf8-83f7-e650572b338b@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7c29d61-9146-4cf8-83f7-e650572b338b@oracle.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4PR09CA0026.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::9) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DS1PR02MB10385:EE_
X-MS-Office365-Filtering-Correlation-Id: 16454f3e-17ba-4b2f-ae6a-08dead153a4f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|3023799003|56012099003;
X-Microsoft-Antispam-Message-Info: ukeEiuLj+t183APay2+VH7YcRtBeUOd2EbR91j6W96I/uvyu1yHBkQywYz5oKHrd3dBTZUTumcnsd1k/zDwBqHpgpkHs/DMBFWWw4X/9wnH7smz4w7Px8tKoT2O4YptKL/net1deoyeLWNB19EF6cDL9HwTm1OAavkBeu5IM06B4GlXuROXpcUSFXS97jUJjqk+TL7GNQWtCNIXWZk6OtHf0mgseggsL7qWSYpGEf2TeFsLJsIzhiCq0KWq4y/i7Vy/NypckPDNe5w/++y4xgjFG9i4DWB/2lMB5djkDcRvhLltcKC9lKOYxhkFAlpibuxPipzHnrCMSU5xwAblxkT0Q/U3K1PshNoanZscXC2ymIfLjGsS5EpPnc5SaIMVZiq6h5oTbXoLImoxKe4yMprd8Akb5WTZ+RxEnniWHCq3u54tRGa5Qar2aq2KJoF9bgi0qpHUAhs7p1ECheKbPRLFHG8DYN7ZHD9hsajq2dFG5pKdsH+jJQJSjCj+wMlfv0vs/OKBI0beiSQ0qcql8+WqvEba/2bN/KEDO6vZGmZEYSBTv4Luh9O+hIKOnkcteXHIJaFCnb+gwffgVEWA51xw+HZLK26yy/zlM1u8H2Oa8Z6RxNE3c3QOwTeR6Ku8hhWwF38NY00Sva5vAWF9XrjZREs3PVzXDpoBMHsAOmPWvCLo4rJZYt0NbOQ4hteer
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(3023799003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFZmcjAwYzlkNVhoRloxandUUUVWbWNWRWN2cFRGcnpOTkdsQU1xdkxKQjY2?=
 =?utf-8?B?RWpMVFd3dFFQZjRSQUFzUGp2UDFBSk9VVWgyQmhOcXlMU0ZWcmIvWTgrZTYx?=
 =?utf-8?B?TERQcTNveHZGYW5Sb01seFBSaC94aGI0ZlRESXdCSWM4c01tbEhkYXRCT2lZ?=
 =?utf-8?B?WW42ajZ2TWhpdXVpSGxMV1Vrc2RQVnArS3UwS0J0OU0vZFVFVjdxZ3dVbkw1?=
 =?utf-8?B?Z1R2SEpwK1RWZ2tPcFdKVlpmMWVwcHhMZndsQWl6UXBRODhTeGE2ODlobkRT?=
 =?utf-8?B?SThHRisvS0ZXMkpYVjhoQ2xGMjhjZTRxUE0wbGFrUjY3bmtXTHFHaWppaFFj?=
 =?utf-8?B?NnhDeUxiTGZuMkp2WGp2NzNFQ1JkSFpoZGthc3YrWVd0WFF2emJRaUJXSUhR?=
 =?utf-8?B?RTErN2ZpclFkaHZTYXlnTlMrTXlXUGlQTEE0SU0rU1ZRTytuSzVucllLYjVZ?=
 =?utf-8?B?SVNhNSs3cXk1Q0IwV05sYmFFRjhFNGNNRGlFTEJ1SUZqeVM5ZjhvbkM0YnFY?=
 =?utf-8?B?TTlIN2s5M0MrdHU5NG5HS2w2OXlKQjkrQ0Fkb2FERFczeDlaTmJoWThnc0w4?=
 =?utf-8?B?dVE4RHB6R3lUbTFyOVhCcjQ1MW5rc1k2MmprWCtEMUdndTFIYms0NjExZjdJ?=
 =?utf-8?B?d1laVDZoVWF0Z1VXRWJxRzdSdmZkM2NTYjl3Zy9GWHFNVXh2NW8vaDVJTkxN?=
 =?utf-8?B?bUNNUDdMSmhGV2JMWjBMOXE5N0N0S25UQ242STFtSmp3VmZoREZDaEJ0MDVp?=
 =?utf-8?B?U0tXMTkrdkcwanhvU1hDT2Q5OUtiQkJrSWl4RDNMZkM4TVhldnhpOUFjY25O?=
 =?utf-8?B?d2MySWlwK0pBZFFKdXYzR3Vjbmh3QmI4NWNqaGhZa3NtM0pPaG5jQmpuWHNa?=
 =?utf-8?B?RFBRT0lOdEt6RzA4S3BkdUFURlZCd2Qyb3RGTlpzVzZ4ejdWZHVkQ0ZwRU5m?=
 =?utf-8?B?K1FLNDJXV2hEaGtiSHo2YVU1TTdhQXMwQWMrYStUWHBRRTFOeFVzUDhxaEhD?=
 =?utf-8?B?LzAyMkxiUG9jcmd1TUs2a3FCcTBsREZxaS9TaGEwTlVTSURMcUtMRTBPdVV6?=
 =?utf-8?B?ZnFKa09qZWZURGdXVjV4V3dhd3VucXpxbnM5R0dXbHpvZW8vRTFMZDhvWEVS?=
 =?utf-8?B?Tk5BSVVHWmQzcWFRdXoyUXVGSk92elZWR3Y1ZCttUW43UDBqMWdyR1FZRFl5?=
 =?utf-8?B?VzVOakFXbUZ2NGtxME4za3VYdXFDRnB3WUovcW4zY2NjMjNzV3I4V2FBTHlW?=
 =?utf-8?B?dE1WVXU4UjEzbFhrS1ZTL0dIbnB2UWJjVEt5NVNsRHpHZGkxUW1rYTB6RUtq?=
 =?utf-8?B?QnY2eGJlbm9oV3FMay9obktiMUF0RHRubWhJOGJhSUJVNTJaVHpJcGNyTHJx?=
 =?utf-8?B?cnpSMU1WS3VSY2pvZEs2RjlJRG13MGRWMnZyN1Z1SlY5SjBrSjJNVEVjZDlW?=
 =?utf-8?B?RjFGMlc2MHNKNkNaeEdpUWRQSnVVdEFkRS9TMWlNOGlkSThDdjZmc3prYXJk?=
 =?utf-8?B?dnlZeTljdFVueHFrYjVUajRwVlZCS3lQNGErK25kMXN0Q1V1QmVENFNmZEhD?=
 =?utf-8?B?c25yRHFBOUZJSm93dHVtVXZsZVR2a3o3dW03bVdTWGNmMlA1Rlp4QW5IVVdj?=
 =?utf-8?B?STlDS0F3bHJJQ1RvRXJuS3VuMUtPOU5UeXR6ejlZSW9mVFg3NTFINEhkdXdv?=
 =?utf-8?B?YjYzQmJEUUtGaEpMcFI1R0s3UXVSdG9PbE1WditvWGxxT1VwNEpwQkwzU0w4?=
 =?utf-8?B?U2wycFgzMEduZnVMeENkN2V1LzJrRXkyVjVjdXNZVHV2MU5lcEc0M1JIdnJV?=
 =?utf-8?B?ZHBHN01kVTlUc0VqWjJWSG1jTGptU3ZHTUEwK01XRkJXbzhIeWNYUENEVmk2?=
 =?utf-8?B?SG0yejJEV28xR2NRcUtJK0ZUOU5OWkw1cWNWUzc3aXdtOVIyNUNzZmRldGRT?=
 =?utf-8?B?VHlTb1M5V3ViZis5TmR6NGNzcUJrYndWc3k2MUsyN2xoWjdJYXdnV3dCMy9l?=
 =?utf-8?B?MDNMR2FpbVZUNkpOL0xaTnFVTVRvcjJzR0dFb0tMWU56eS9QbHFSellZMWZS?=
 =?utf-8?B?a0doeTdJeXh5emdUNVVBTDBTOUkvWkZWbWI5YW9VVUcrTngwNVRYZWx4M2o3?=
 =?utf-8?B?NWRGKzZKeDJ1eDU5VUV0amU1RWJlVktXWmZuWVUyS3k4K3RpRVdELzRmdWtD?=
 =?utf-8?B?ODhhWWF6eGNZSGpmTXZ4YytzVEltS2FDNDhhNmpDdlJpYTVtb0ZaVitiTmJO?=
 =?utf-8?B?cnlHZ0lhSlhDWXhtbGllOWJHTENDdkRQOWxIMTRaYWNEOWFrc090OUg4aTgx?=
 =?utf-8?B?a2NvVGR2NzRORWxXR3Jpano2Vzk3cTZFQzZqV2c2OG5XRHcxV0lHdz09?=
X-Exchange-RoutingPolicyChecked: VMLCspG/U6Zag/9IdiWPjDi+oMC2ws6h5w6DEtDBz8OgCKhSwL86tBN1lRekevm1rHy+/4KucLQqXEcSb0ZHwEd9OJ4BiAD7RnyVvGC2LSUl1JhOwgek2y+qMYBWTsRgzPJDwBrALfVreKVf1V14WKCM0gvzoYw9KualDdNSf6fIO+6dBwIDIL0yEIkIs4ix/rcuSaH5P7Cdxm0lDt2KfguyqTfpp2wjQy/y1UkAKGSO6KpviTkvDziWldH+5SNYcfNYixoCWEwdZYpkALw/P9xASf4xaPOSXId7qcbrmihL6NGtnnA7Abg/7eDBHUFC18beT4AQxp0YO6rv6dECiQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16454f3e-17ba-4b2f-ae6a-08dead153a4f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 15:19:42.2359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7T5lswyZfXg1mjYB77I4LiNop20Pu84OVofshcwML0ThSqRBAe0+iW9ESzlZnhcGVJnylbNbDpzZMJqmOysNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR02MB10385
X-Proofpoint-GUID: KWLAE8_0F6z7VzYY2iGIjspKcoCC6GBR
X-Authority-Analysis: v=2.4 cv=C6fZDwP+ c=1 sm=1 tr=0 ts=69fdff11 cx=c_pps
 a=qh32Q7XyPXPg99od4CZmAQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=2TG-jgtIZqmf1nTv1Q0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE1MyBTYWx0ZWRfX3R7EBL9oiBfS
 injx6lkqgp8hPw4pcpVUb5+ZZXYHYlwFTU1uxyVUqOaxr6QQrBqDOK0PZs6VMO1CIXCY/lDBeBj
 ToVsVYqDLHJLfD5SqPDFbf3CdC2EmQvdOlTwvivHizqFrEnX8R4Cb2nCAbFeUePfblyoLNbKQL5
 dYsBC1jOpp5t3rRhGiJfGJz+MxqB33uvO1eEWTySDNevBXYsIX9YKk+Q2SUiU1+dD5/XSQxY8H9
 5xa+Ui4sGRMXktsq398w1GuhmU4FSeHRGfGP++I2Kk6vvO6/e7w4HwSRh6lrDJPwHyzHtXETNnc
 OaSRpj1Xk8s9EvIsMimk0TB/dt4vXBE4wIfnOdvrY3J+IT4XMDZdM+na2t0PgMV5GFPmlW/x7uP
 Ciacm5cRPPOEI6mjAzSNHHO0qJgSJzuoTUaSzOeQOxfP33VmqevnM+G6znM1GhznQ9wlYQcLt6j
 1AZg4ZIMaWltdyCyrbQ==
X-Proofpoint-ORIG-GUID: KWLAE8_0F6z7VzYY2iGIjspKcoCC6GBR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

On Fri, May 08, 2026 at 11:07:28AM -0400, Jagannathan Raman wrote:

> On 5/8/26 10:37 AM, John Levon wrote:
> > On Fri, May 08, 2026 at 02:33:59PM +0000, Jag Raman wrote:
> > 
> > > > QEMU maintainers can correct me, but I'd think it has to go through a
> > > > deprecation cycle first?
> > > If the code has to soak in a deprecated state, I think an “Obsolete” status
> > > better fits it as it’s replaced by vfio-user.
> > Are you saying you and/or Elena are still maintaining the vfio-user
> > implementation in hw/remote ? As I don't think there's anything happening there
> > either.
> 
> The vfio-user implementation is the server part of the vfio-user client and it
> utilizes the x-remote machine object. I do maintain it - I proposed a fix to
> bug last week and reviewed an alternative proposal from Marc-Andre.

When I was asking you about mpqemu, I was talking about all of hw/remote, not
just the legacy backend. Apologies if I misunderstood you.

I think "S: Odd Fixes" is more appropriate (see below).

> There's no active development on it due to a lack of inbound feature requests.
> Are you looking for any specific features?

Confused by this comment, as we've discussed before several times that you were
going to migrate the testing across to vfio-user instead of the legacy protocol,
then remove the legacy protocol altogether.

Then no patches arrived, so I presume that's not going to happen.

> If you want to bring the maintenance of this under your purview, I'm OK with

I don't have cycles/interest for this unfortunately.


How about the following:

1) mark the whole subsystem as Odd Fixes

2) mark the legacy backend as Obsolete

3) if we don't see any further work on converting mpqemu over to vfio-user
properly over, say, the next calendar year, then remove the whole feature.

regards
john

