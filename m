Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF31CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kEH-0006oo-Is; Thu, 25 Sep 2025 07:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDO-0006Sn-8J; Thu, 25 Sep 2025 07:32:46 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDC-0008Ix-In; Thu, 25 Sep 2025 07:32:43 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58P0DExr2033680; Thu, 25 Sep 2025 04:32:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=6HzhOnnMGzF82ynxzZQe6kXqrKeV2cOSj9fhjTl7e
 aY=; b=2lNPZgwQLI27BAKNPJBy8y/YDPdddGk8Xr8+OAhGWPx4vUWLhMsoR2Hvw
 /Qlr0puTeqJRB627CxRw+/OISf9UadgkVS3e66O4xa17EnDNTWOY+nBwVRqnY3Wl
 hu7RrF8dDuz4IBUT1ywELcJQ970cV5iZLvEut5xNYkxxjTszoDrcjlQFOvPxohOb
 i6Ul/HfMTqhdGtZeT4O8DNU1Pm+x6E3ghNqzU8aTx4cLe9mawZ4dXLULeDvoItVA
 WKfLfxYFQ2I3cQI65WS29Zrmi2jLPUz44DsEJNcgiMIwyALUobvrCJP2eCsTGtNA
 iq0X55t8T7rrgA3xig8l4ngNTaCbw==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021084.outbound.protection.outlook.com [52.101.62.84])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49cj95tkmr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:32:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyxMyaadHTBmqpDzO9/5Ybl4J6uGAPWoFgR/5KA1ld0DN8n333BOqTjgjCzFdtozvChnmAUEbpSxfTaUSuEPU2CpIJ8s/QVZyUsM88eAYEh0yXSld0qsZgkK4xh9B6n7lqHxOHbD9wyqMJyH6jw4rMyjDRt8vBYtNAGDx2Ow0134VRWBuJhmV9jQIVzvHWT5CUpFqDXFn4vP8Vq45776SeMKz+2xmd5cCTEzbFMren5hhWIW/UwFKU+25/UvJuhiVjcckDW7SiV/+v6jh36b5VceK9xDcQmJLND8LNFzDjoJowsrv45VPGli8MkAY7Tm5OFL97wQ/UGR5frhM7jNPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HzhOnnMGzF82ynxzZQe6kXqrKeV2cOSj9fhjTl7eaY=;
 b=ElGKD6VZOwdXPn5Wd0u1ibPkRJjiuObkfT/9DAWYyuGkGtS+w+9Wa7Gn96yWUr4/Vqa6FurNN7QX7JhYCvmYX33ccEqFKriae8Qbzh82J3UPuBzCkEJ8Io9V+nQW6rsIGXm/ZGeo+Ab122gbyczwzVNjd1XoBwS9a/hzjAiDwHqUEEOE2MGYESpfUBUY8g8lbvTFm5UG5ORQv7ho29ivqZKIvLo0hxjWpfHFcLhFwr0eXV6K7WTSNJRTW5Vi1opjAejp1AgGdsudbV1C694+T8d7ElpJKzqQWKaYMDnk5XMpGYZkrcrC9F0t1PzRVfRqjlSGahX0qWjS5cC3k3iXOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HzhOnnMGzF82ynxzZQe6kXqrKeV2cOSj9fhjTl7eaY=;
 b=VPGrN/mXJPe9p37HM9ErAMGGQnDpnRO1R1x/69oNK5m8oq94ZjIpc1/73PgzFVbcXWpAvanau3Zl6WDCwFGLOkxxPHp0hEZP89BaD7wmJJAdp/8wyE8fbf4mEDrjUHWdM2ESwsgLq7LpoMlaEajBnPBxHsjheCH7I6htfWZzHB7D4g3mSHmuW+AQsYXQipfKSOzDesEXLuFc4iXvlZzWxwcTHq/oPGGVJQiKuj+Las0z4lVyPa20SeDdyXSqY1v2nUVAr+AhX1+Gy+YhxVJn4xNtLylcwvNsxPe4ZgKT41MmwHhQWDMKxM8IWvfEcsjj3ZuRItPDEJLic3MIV2pC1w==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9532.namprd02.prod.outlook.com (2603:10b6:208:40a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 11:32:19 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:32:19 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 05/28] hw/vfio/container.c: rename file to
 container-legacy.c
Date: Thu, 25 Sep 2025 12:31:13 +0100
Message-ID: <20250925113159.1760317-6-mark.caveayland@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: c6405fe2-6729-4886-1993-08ddfc272fda
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjRIaWxxakFCbU5hUEdKZ1o3TG41SjNsZzVDQjI2SEk4RGdGOEp1RzZBQmYz?=
 =?utf-8?B?cTJnMFdLdlRJNnpRWjZqTXdibTZmdG41TGdqbDlFNVg0aGlEK1VEb3FHN2Nz?=
 =?utf-8?B?c0gxMTBsWlFtZHBGMEQydnZzVUx1NVFrN1Y1WEl5U1lyY3ZBanRFVHd5VDBE?=
 =?utf-8?B?OWgyeERiQU15K3lreGFBVmNyeDJEVTVKVkhSb0tOU1hpTDZ1bk40bEFUdllw?=
 =?utf-8?B?cG1VN2owVFliRU84Yi9LendmaW9kMGtaSGlMZXgzcmVvTUpoVEJ3aE1DUEd5?=
 =?utf-8?B?Z295Z3p1MHdMbkk3dzg5K0piMUI4WEJjcUc2SXJvcEplak1zZ0J1MTU5Y0tr?=
 =?utf-8?B?dlRjWTBRc0xnWXUxcm9EZHNuM1MvclVUNFdQVGRsUEtPNTlDT0tVYWNNUUpi?=
 =?utf-8?B?WlYzdkI1dHdXcHBsZnloT25aQVBrdWdTY1I0TzlzaGlxS2x1WTA5NVhwTXU0?=
 =?utf-8?B?aFMxNHdJMTg2TmxqRlc3QkcvbWpUblFYOW9qaUE0T2lObU9NekMyR0t5Q0hK?=
 =?utf-8?B?WnR2bHJsckNxbXZ3V0RKYlc4eXFhZ1Q1TzZtMXgwYVlPT2sxWk5PUEVqWm03?=
 =?utf-8?B?dEp0Yyt2ZFRIRnozRGhhYkJKcGRXOGI5T0FGejM4MktoSml2VC9xNHlLMXQy?=
 =?utf-8?B?QU9HS3lPZDh1MzlpZENjeVdrNEtSaWQzWDlRS0t6S2YwaTYwcS9sNWdYVGoy?=
 =?utf-8?B?QjhEdmlKdkk1eVcxU3hoWmw5VVJtUThjK0txMS9RVUFHTmx2VHZLaU9BU0NH?=
 =?utf-8?B?bFBVTjlJVFRrRkkyZ01vbUFJbXdrSFh0aG4rS0ZUVytWOXI2NU1YTTB0ODh0?=
 =?utf-8?B?Q0E1WHFZMWdyVlpxU0N1QW13czlxYzdnODRWbVdEVVN3K1kyNUVidE82MmE4?=
 =?utf-8?B?aDNkd3BNUHlNZGVwbE01bXFUSmxLWEcxTUhlc0tBSTN2SmkwL0NPMFdxWmVk?=
 =?utf-8?B?aENaSERPRkd3ZXRTTXEwSGxRMTJxWE5MVWhvY3hWOXlIWlh6cUZCdWdjRTVC?=
 =?utf-8?B?cmJoak1qZnFsUU9lM3V0Y0luakE5TE5hbFdCMy9ublViSzJUaVUvS0w0Z0o0?=
 =?utf-8?B?RGNJMjZvNWdZTGgrb1N1Q1RZV1hzUWVlZThCNVQxUEt1NlBLUklLdUt5aElo?=
 =?utf-8?B?TUY0emVUbU9OOEQ3R0diYkdaeHF6Mkdnc3RpMEpkNmJoZ1lXd0lXbWYyTU0x?=
 =?utf-8?B?U2VGNDcwL3NET3hNTVErVUxoZ3R3M1lLZmpFNVg2WFZwLzhwd01STlJaSEcy?=
 =?utf-8?B?QURNaWlwZFFjQUdyeHMzTmpFaE4xcXhRSm5pVW42SWpCTW40WFlYK3JHc3Yv?=
 =?utf-8?B?T2IvNHBqallrTVA4UWZITWpzcVhkOVBiVTg0T0lBejRzR2xGWUp2MFRpQjFI?=
 =?utf-8?B?L21lSy9UV3ZGV2NWQVY5c3UrR21BNjF0VUFMUXErM3pSWkVuVlREK0s5ZzlJ?=
 =?utf-8?B?QUw1aTF3VmhsSG1qM3JzV0RKMGV1NjFrN1JsbERZaHlhaUJWRnU3bm51UzNO?=
 =?utf-8?B?OTg5RXBmZWMxd0wrNCs0a2p5MHM4RnVRRlNONTFYeDBnNTFDMG5wY2JyUnpx?=
 =?utf-8?B?NkVGdThiY0lFcmxFamZmK0tYWE9MOTVPUGxqL2lEYnBETnkvRjIzL3BIRXRY?=
 =?utf-8?B?ZHVOUDRQcU1SV2VlaENZc3NhbndYUi9VSVBaZjMrZDV5V0gxODN5ZGl0d25i?=
 =?utf-8?B?ay9uWUtIcWVmdU5wSWthV2NFSHBSTXFZeFZSSnRWNHRtKzRCYUoyNmhwS2ow?=
 =?utf-8?B?SEJubUJ0RzJBV0Y5ekI5QWZoa0w4MjNOMG5TRUYwcXIvdklmWVNOTk9tZ0NH?=
 =?utf-8?B?VWpoOURNK3A5Rks0VlVySEVKZGpublBGSEx0RXJYQ3pXV2cwS05DVzhRUDNO?=
 =?utf-8?B?eHU2cjE5SUJQUlN5WVR6U2trL0lhdU5kZU5uS2hxQWJueXUxK0FaSFJTSHZk?=
 =?utf-8?B?cDRyMTkrQWRYcmczOHo2TVl3M3FDa1FnV2l5Sk40TUtRNzNpUFMzL2IxZXg5?=
 =?utf-8?B?dDNwTnkyS0NBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWw4UUczT0VxaFdZODlqd1Flb1VHZDdQWFFjUjIxT1RiZ0JLWEpSbDlzRVhh?=
 =?utf-8?B?V3BtRDFaeVdINXE0ZG5pbW96Z09Tc1JzeUo0SUhTb1EvVkJvVzgxdGR2YTEr?=
 =?utf-8?B?K3MvVWdUM1dtMUxHL2pDUjlMcjBWRW81SHFHVHNRVWpUcGV5UFZCWlJiMmp4?=
 =?utf-8?B?L25rYUxZVnV1ZERDRjZaWDZ3OVMzdzEvVFJFOEV1VWpDcjhIblpldE5QUkEz?=
 =?utf-8?B?MjVCMHNGRDVsQjJRNDFpVmJCVXNHbW5md3JjY2ZyZmZYakJlQjl4RmorckVD?=
 =?utf-8?B?bWM5eFpjRE4yNFpXNUNLdVdKOXNUV1daS2Q1TndWQWd3QXNWSE1wSmQzeDJW?=
 =?utf-8?B?N21BQktSRlE5MjhWYzVZOEtybmpocW1tTk4wWHdGYnJqZHFaWjRIRXgzSWth?=
 =?utf-8?B?czg2Mmc1MjNrZXJrdTRmcUNiRU5oU0RCS09FY3JMWmluRmg1WGkxMVJZYVp1?=
 =?utf-8?B?eXpUTDlGdGdWM3JxM1piRDl3UzNSU3M2dlZlK3k0bXRLZmtnNGFpRnVFRDJX?=
 =?utf-8?B?UU1RZEtyOEJWSUwrZWl5aVM3cUJXWm5YNVlWcFlaNGgxdVc0MG8rMGFOc0lB?=
 =?utf-8?B?QjJaY1h4Zm8rSVp3cUdtTjMyUk04cmQ0RVZDeVk1Y0JIb01VVUNFZDBDRmlj?=
 =?utf-8?B?aVpKek1xcHhMTWIwQkFHNmEwTFNRbHEvb21HdS9TV1ZndVFSbEJwa3BkSTBy?=
 =?utf-8?B?alFqNzhnVXF3WGJCMVZDSmZEQ2NNa0tCc093RlozYzVqYVBraGxwRDA2R3Y2?=
 =?utf-8?B?b1NDZ2xidG1tZnVyTFBwNUVIeVV5aDFrMktUdXpEei9KaHJYdno0YngxSSt3?=
 =?utf-8?B?QjhYaDFFYVM3blIzM2FXUjQ0NDBHb1lGK0xRdGdpZ0h4SWVpL2FaUWRhcW9w?=
 =?utf-8?B?VkdiWFRpNWhseXVaTGs1bGVaYkZHMW5NR3ZTNDJ0UElDcEhmWEhaZmtidGNQ?=
 =?utf-8?B?aXE1Q245d3R6aTZGdHB2UGJ5dVdYRXhNRGtPZTlXYkM2R281VC81TVprbXQv?=
 =?utf-8?B?bmxIZ0pFcmRaQ3g3aC9ZUnYzWVJNalNBcUQ4cDh2THQybDZGNktjdkw2QVJ2?=
 =?utf-8?B?cnZsMmNzaVN6RmZuaEhESjVkcFduV01QcDI0TFZVSWlJRUlrT04vcS85ZjZ1?=
 =?utf-8?B?ZUhjdkVmZVlQNFRBU3BVWmNEaEFqUHRPbmo5OTV4b2FDYnM5TjFWUFRoN2E0?=
 =?utf-8?B?QTJibzRXUkNqZ3FvOGd4dDI5RW9zazJ0MDlJSTMxeCtLOVRPV0cycUc3cndT?=
 =?utf-8?B?ZkVSUVRrNW94NTNhT1Y3YzlvN2QyUnVrajFXem1rbTNveDNXbkpqcTBCR0E1?=
 =?utf-8?B?R3NTRW9ZcHJYQjhnODl2TUJ2QUx0VURUOC9MSUkrSXNEMngxaWpsWi84ZmpX?=
 =?utf-8?B?c1l4U3dZUGNQZFc4d0tCOUE4bVhhaE5VMlBOL3gzNXFjeXpGajVBTXFKK2RH?=
 =?utf-8?B?c3hZK0VxV2NRclFiUVgwVitkWU1ZUHErcUFMb1ZlMnpFUjZiVkZ6UkVyaG5v?=
 =?utf-8?B?NTh1REc4YzRCY1lQRmlkYXEweG52M29DM0N4UEF1TXlwd0tKbnhwd2p4NGN1?=
 =?utf-8?B?cFpyRGl6dzM0ZU1STkt3TSt2TGdNZmZ4MGVDU1pQK0d4TUdZcUVkU3BIZXMz?=
 =?utf-8?B?d2pwYW1xU2o2Yy9FeS9YR2tndzBOcWo3WjNtUDEvdnAvbUlEeFkrT2Rzc0FT?=
 =?utf-8?B?L3ViVThEWE1lOGFHaG8wWjZQcXBmV2NKUWt1YXJDeXJ2cmN3UlR5YWJUd1NM?=
 =?utf-8?B?SHJ0enhBdUIyT0VYeGRFaFppdkZzRlRON055Q1ZsNGZxZkt0L2VObnpJYmw5?=
 =?utf-8?B?UWhWK2QrRnpqbmdFQzBlZjZmcStVRzlXeFNkRy94OEZjaVE0TC96UFlpZ1Bj?=
 =?utf-8?B?bjZxb09OQ3BjTCtGaXQxZm5nenJOYTlrNldpclU2UEVTckxzcmpVZm5kYlI1?=
 =?utf-8?B?WWRDOUo4LzFFbDA3S3J4ZnczSHVNL3hLaFh2eXpucFM2WlJaLzVoNkhCZmhG?=
 =?utf-8?B?THpxMVdrT0JVdnlVeXgzZTRHZ3RVeG9MUUdzbXpUSXgxRlE1a3Z1b0h5Ukcy?=
 =?utf-8?B?a2s4MnhRZjZaaVBPbk14RDRwd3pOK09nemdVMWxlMFN2emcrV1pLa3dPaWNQ?=
 =?utf-8?B?cGgvVHdOR2ErT3Z1MTU2emtBU29GOHVXRHlld3NmdUYxUEVwOGhoZmRMNmNk?=
 =?utf-8?B?b2pkdzJlTXZEL0xCWjlLM2RQLzMrNG9XT0c0eWk5VnpBOERDNHNuOStjSDVw?=
 =?utf-8?B?RU1qai9mdGFVUGpiWVhZaDBvQlZRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6405fe2-6729-4886-1993-08ddfc272fda
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:32:19.4483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HaE2PNzNEQs7/zJWEgcr/Jq31bmt0axtj4EcGAidcbu+W+/8BogtgQYVykVVqdK4Fq/rrw+P1MnQszpvrE3w/iAp7PyB+iUJPNzba1k2jJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9532
X-Authority-Analysis: v=2.4 cv=fPk53Yae c=1 sm=1 tr=0 ts=68d52845 cx=c_pps
 a=0yFM1XxYkakKyygSKIuBYA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=5Mn6Vqc91_YrKnLs_V4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: y2yjy-zLI3KxfcbpDCDKtTaV6i3I1zVh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfX59+mgj8SgUuH
 dVl/MV0olpx4HiOxvmAIepPBm2aIsUVwJCxsKoNUcdWqGFH0HJ1iKjlFIoYgdXh0B1nKNWrLz8S
 HnbROBBtGWblXcxuPuIqftAZKdZWAusyDCxq//Yhqgw1TUq6l6shJg7ZLx2Fv+mGnrZNjIihT5J
 yIIcE+QJf1sv+Heb2tFi7dIT9+VjLOtJNOdeG1vOMAvT4wPHcRA0MQod0391Dy38GdR/+Pp9G9J
 Or8GpEQ0ARRi8XGmCaKvwtW6zZVDVD9uzb49K5BAQBE8DuLr0WVnRiDalhyExUxvOSOlz7PNmsH
 HiJtl/t8tsxQGHk1WfetGouIwSa3T4DirGOhKf7UKCQV5YgDTUzvOUsMNz/nSE=
X-Proofpoint-ORIG-GUID: y2yjy-zLI3KxfcbpDCDKtTaV6i3I1zVh
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

This file is mostly concerned with the VFIOLegacyContainer implementation so
rename it to reflect the previous rename of VFIOContainer to
VFIOLegacyContainer.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/{container.c => container-legacy.c} | 0
 hw/vfio/meson.build                         | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename hw/vfio/{container.c => container-legacy.c} (100%)

diff --git a/hw/vfio/container.c b/hw/vfio/container-legacy.c
similarity index 100%
rename from hw/vfio/container.c
rename to hw/vfio/container-legacy.c
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index d3ed3cb7ac..62b7a7eaac 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -4,7 +4,7 @@ vfio_ss = ss.source_set()
 vfio_ss.add(files(
   'listener.c',
   'container-base.c',
-  'container.c',
+  'container-legacy.c',
   'helpers.c',
 ))
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
-- 
2.43.0


