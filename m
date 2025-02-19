Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB97C021B1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklP0-0003V9-5u; Wed, 19 Feb 2025 09:50:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOy-0003To-9v; Wed, 19 Feb 2025 09:50:16 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOv-0007WD-6K; Wed, 19 Feb 2025 09:50:16 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J9LnWs011251;
 Wed, 19 Feb 2025 06:50:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=nLfnGtfBTmnnpgLKtSGQN6h/7mlRWzPVdJOlBx539
 eM=; b=p5cK+WhD0AKVF15IIl4PxWcxQtTkBfFkwE9k8a+Z7as6t/bDcYOQfUjh3
 cG0JevZY4rapFxe7O+s2gCwBs/4ldzioaqzBkL2fbU1ILJseoBFzlS2iGPwyeUUZ
 xotXJtlTbQpZ64oc4m+zlF/F0u8j1RGiL2NHrfZzTyZm4S0+MCHiUlwBoOYweFOG
 y3GOHCK44x2Opr5pvljNgIee9aNCRxSrYmjDERgr/Uxwrm71AClUZaDHd90dvR8r
 cST4RpedFsJBjixoqvBdXD/vS99zXTjJQyyyleS2HipdixTRl2R3FyczAbZTvig8
 1GNgVhYzZyGrmk6MKBSIMQfhFei4g==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4bdhxxr-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:50:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKzVlvp3OUABuiDxgQdzvQ5JjdTUstI7HOjCwLyZPS9xLvtLD97Zc1xVj28I+xhquExHJS7sakiVM34nUBk9tMFDeVz1qh8JpkITcI6Wb4/ZMX1m2Adfc4DQWvzoSQCW/mz7wrQVB7v1U+cLuyywE/E9q8E0QfvTu9nGBAil2aH1qUx/6Fsv5Xe5gUKM0DhpFQzF55JbngxJwYVLMfvSCGYmPM/OoCJpDfEcMcQetkNfNhyEUJ2UYogNdUcPAd+Lw99YUOfbYZF3XN7x7/O8ArVUAJ+3UIPBRcjRrZPTy3WZG7D/zvilL10SPk2xOHCqsGN8sMW4+q054be1LFnnVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLfnGtfBTmnnpgLKtSGQN6h/7mlRWzPVdJOlBx539eM=;
 b=efz4eUA1ePyaR5WyzF6xhbGrfH41TGw1syKqtr3I45Skq1RYOgyhUgNSDnNtQdZHYP25/3CP9Xq17bDSrYPemqhux0e9WeJTJhjLy0CN5b4AB03AdX5e6h0nTAY7yMDk0ewiuTH/YJLc/4AXSfU62Z9/zDecYP/T5Rpy+l+Emcd+r+NyDIEHIu82zB3I7HGbecXfrLSx+U06L1QP9EFiOp1T/z27JT5ixu1SBSDmGnNeGqPojmZr8m39s9OO9d/V8A0WGJtDMVS7AsM/qLPVR5oEIle0n6UtBTQzdj1I6hmJVqafsBOen6sF4LEyyq/UCALlBUUy2+4D4uM/U6g+3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLfnGtfBTmnnpgLKtSGQN6h/7mlRWzPVdJOlBx539eM=;
 b=v/zAgywWE8BB6quhJAjzqTIcLnzmfJI5CbOUveQOghriR7vWBBXrVX4yQ7UKd1MWcHeod2LFiviak514n00/Al2WBcd786kURwo/jR8WAcK9Q0dtd/vuLqUggoZxpwKY7dARx+rWiUX5Vv281QGSG2ZUDTFFPgzbl8uOCkED99BnQQxb4ljPTlGurplRE41UxVhTkk8HggTjDZ5yUXAY+Mbx+B/MVeRW9GQQnsS+5r/c/LpNDqFlonznUxt9ZiDrsulgbY+pcpYydSgZVvYBiij6KAbZ2IeaKzQdssWH3vohPWaSVD4kQCcGM8jOb3Np1TOnfNyY2HlO87bBWGP9wg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV8PR02MB10096.namprd02.prod.outlook.com (2603:10b6:408:181::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 14:49:58 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:49:58 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH v8 14/28] vfio-user: implement message receive infrastructure
Date: Wed, 19 Feb 2025 15:48:44 +0100
Message-Id: <20250219144858.266455-15-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219144858.266455-1-john.levon@nutanix.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0154.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::21) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|LV8PR02MB10096:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cefdfc2-0cda-4872-f913-08dd50f4ae36
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UktNQXl0RGdWaDE4WHBycVdsd1pJdHdzaERjZGlONlRuaGZUU1cxTTB2R2V2?=
 =?utf-8?B?S3plRURRdko1UFVOSW5WbXdNejRnT0lpM0lUYjJ3a0F1QTR4WDlqV3NvS0Zn?=
 =?utf-8?B?empqeG5raThWaGIzMURWcVdwdDZGdDhqanhQUk14SXZ1bGw1MTdFRHh3bnpo?=
 =?utf-8?B?aktjQVBZZVR4Q0E1RC9hYVR6bHVqNmtFZjF4SXVBcjd3Zjl5Z1BiRWJFTjhl?=
 =?utf-8?B?eWxKVEJCWTVlVzcrKzQxUUJnUjh0UFdpd3lDRjNNTCtqak9EOVhCSXY1YS9R?=
 =?utf-8?B?SGVHczg5bmJac1h0UzJQRk5aNFJwSks5ay9LeVVuZjF4R3E1ayt2ZlFNWjF1?=
 =?utf-8?B?Z3l1YlBHWUFiMFZvOTRvVkV0WWpiSFJlNVY1WkhDVkROb0J1NzZmUnNBbVkv?=
 =?utf-8?B?VCtTOTgxMVBaMHpDaWNycDBQUk90M3ByTmZYUVV5RnJ6YXQxK0QwbTRxYnNU?=
 =?utf-8?B?ZGxpQVJ2Uy9ZN29vYWpIUHlMUzJEK2xkTGRaZHJ5M3kybnBORGZhQysxVjBp?=
 =?utf-8?B?THlrVkJyTzhkNy9RY3BWYW9lUUlNWXlLQmM3bnJ3TUNkUXgwSW1DVG5TeUly?=
 =?utf-8?B?MXNOMTFUNlNWWVc1UnV4bWg5N0dFUzdCTTdwdTRlbDZnK0sxZG83MDRzSmUx?=
 =?utf-8?B?TFVkYXAvYmoyZTV0MmNYQzQvR0lrYzlUUkk0ZFRSWHRvOGd2Nmg0UjVRaW1p?=
 =?utf-8?B?RFVRMHh5NWRqSDVxTnZRTDZ1dEJobGVEVHVFTjE3OFZaK1ExcWFpOGxhR2pZ?=
 =?utf-8?B?cExJbUhjSFA0QkxEQWZaRzBTOW1KZEZLWFhrUm5sT3F1WUVqVjN2Um4wTWdi?=
 =?utf-8?B?cXE5bEg4clR4NlR3TGJmR1gvSFAwcUw4YW5CenJ1K2lqNnpPZ2s0VC9qZnhJ?=
 =?utf-8?B?REF5V0NDYTJBVmRKWkFud2xxZ3lMaGxUbkh2YXRMTSticnZNSDRFTmFKejZF?=
 =?utf-8?B?dGRqRGhaTmc4VDRIZXNjQ3NIbHg2WHZTQktlQWpjL2VYQ05paGpZQkExSzB1?=
 =?utf-8?B?b1ZPaWcwMS96QTA4K0thM1l1ek11cEV0dElUdUE3MExvdnptbXJYOExGSXIx?=
 =?utf-8?B?aSt5YTRzNEQ5cm5PUnhFNHZrMUhRWGFlSkd3SWN0ZUlpUWNSdjBnNlpiY2tr?=
 =?utf-8?B?TGlzam1Ra0NjdGwxNGtNaitnUVZYOFBNRmRpaXBva0ZiMzY2RURnVW5WalVM?=
 =?utf-8?B?dWNiazNBRkQ0cW0vVVFwUlA0VHNQM2Z1bW85aE82OGVoRDdUR3lyZlN3dzZ6?=
 =?utf-8?B?UFhPZmZJaXpjR21MNGVPbmZSVVJhSUdFZ1RrZExlcW5XUHVubENQOWxZM3Rr?=
 =?utf-8?B?UGNocTZ1OEt6eHlIMlFNNFVpaFJ2aEJXRS93QUZqUm83S2wvY2hpbzVvVWRR?=
 =?utf-8?B?ZGd2dERoRUQrdE9KUzBNdmxvdG1XamZNa2JwakJmNGY4SWdCSnpKVGw0cmc0?=
 =?utf-8?B?T2tCS2xZYlFVWFJFU2xadUhISTZqRm1OZDc2STh2MDVNOVFGRlRhR1JQVHVH?=
 =?utf-8?B?Nk9MMS9rd3RlVnl4Z2NPYmRDQ1BaRVRLS3ZVK2Jyd1N6NU5LcUFFamk1K1Bj?=
 =?utf-8?B?QjdIeDdMUzl6dDFoOFdKSWVleW9IcU9oSmQ4NEtUWHZtcDh1YXVaNFpJZE5q?=
 =?utf-8?B?SzNRajFnUklXMXV4VHBiVEdwZHVzV000dGtGMVB5UDNocHBNYld2dWZFa3g4?=
 =?utf-8?B?azZBY2FpNG9LUWVabjNaTHlCMHFyWjRSOEJZYUhnYkw5QnltN1hIWmJhSmtx?=
 =?utf-8?B?ZHlCalRhUmRjN3lPcTNmQXloZE9VZ1dKdTRkOXlpRnpXcHJKdVQvekoyTlU2?=
 =?utf-8?B?d1pQMDFvNXZVRjZCT0hnVmFkUlhvU0R0c3FNTVFzdXhOeU1pT1ZVMlBKNU9y?=
 =?utf-8?Q?ieaNo+q7NH0bL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU5PUHh5bnNhK3RySEdlbHQ0ZUFrVnE5SG5xdEdLTWZNdFp0Z2Job1k4RlNY?=
 =?utf-8?B?d0tPRUhOeUxIUyt1OXZxVzMyNjMyNlJrSWpzUjI2d3Z4U1podS83eGRTVTRl?=
 =?utf-8?B?UDF5anlJTkxOZXZTTmhzUkY2M2tNeEtLMldrWTNCRXVhL0N4OFUvUXRzT0Nx?=
 =?utf-8?B?bTBwNmV0aC9tSSszQng5NldkRnV5TEVlVy9VWjdRSkFhditwNjVJOHIva1Mx?=
 =?utf-8?B?UDhHQ200WnJ2WlYvbitKaUdRbDl5MGlXeERuTmxYa1dpSmF3SFhsdGJKZUk3?=
 =?utf-8?B?eTdkZE11N1FEOW9PbWpQUXhjVDdPOVlaTWxyYUZnSDZNTER4OEJyOFVFaERt?=
 =?utf-8?B?dWx4anFwVmhqZjNCVGRzMFUwc1d4NGpnQmdNZDNJUVVRV3FLVUFWMHZsNHZV?=
 =?utf-8?B?MHcrZjRNdkV1YmlzYXgwdUtBUityejJYMlViNEgrQ3JQN1JDWUFxbDZGbmpO?=
 =?utf-8?B?Vy9ta2VFV1k0RlpjRDZ3RGtoUUxWS05rak1SazM1T3V5TGVVT1p2amV0dmVk?=
 =?utf-8?B?ZnpiR2haaGl2NTlMUVNsdDh5UGo3MmxCSTZyZnJVOUUwY3VHdEpOSTN2WEhT?=
 =?utf-8?B?TDFTaU42TzdNdEFwTkZLNnl5MXk2a2FoYVVKRURMUTNBUHN5TFcxcnFTb2th?=
 =?utf-8?B?WWpTLzBTUzlVZzhhMzBYMTM3T3BmMUtvTjlMU3dqbnVLNmwyNklIbXFvRi85?=
 =?utf-8?B?aHVLMGd0REhaYlBqTlNlczd4ZkxiNkFoNGtBK0JsUmJ5ZERzNnB2d0w2WE5n?=
 =?utf-8?B?aEd3QXdBV2w4WUNvcGVFZ045VEhWUjhPOUllaXNSN3hCUVlINnZ1cmFXUC9B?=
 =?utf-8?B?ZWhTYnZ5Z3pJcHFIRXlqYm5WNHcyYzJrWW5xaFdpUFJBbnhyTm94QllzZ2Jk?=
 =?utf-8?B?bjJNNDlEdjNEaFRNQ0F1T2dmREpoWHV0aWg3emVlVzBvT0lkZGpZWWtUdFkv?=
 =?utf-8?B?RE5HUWxYMGZYZE41bVl5d284N24zN3JhN0MwSENId1BCUU5URC9mR0toQmVw?=
 =?utf-8?B?dmNGdVRNYllmalNPa0ZEeWFEYk1EczZoT1RleWR2a0lET2JTTlR5emhWRnM3?=
 =?utf-8?B?ZWJtdG9sZXBJNENnamV0ZVJZQ1lhdUFzdXFQa082bEdYcXlBMVA3dFFiUjQr?=
 =?utf-8?B?Z1picTEwQ2RyRjVxSjJUTFpjeWE5S204amhFT05pWk9yeDZlSEd1cWlRaW1D?=
 =?utf-8?B?YWVNZ0t1WjdYT01CcG5oVXdjU2tFRkxzZHBDNzQxWUpsSmJKQnRwTWRTbDRD?=
 =?utf-8?B?WmJTNTBpUGkyWEJvT3lmUkljYzV4bHVZMlRhUzl6Z0NQNnNRU0NvU1dYdnpw?=
 =?utf-8?B?SEcxSll2WmJaUGJKTjJ5RllVR01KeWM2bWM5cVJ2SFZYcDVCNERUekVHbUlu?=
 =?utf-8?B?aU9ST01WS0xPd0t2MGx5b2R5clVkT1FvaUpiSHphRE1iVndYZVk0dWltZDIv?=
 =?utf-8?B?SlN1YUw3Y1pLb0R3eS83RmtNU1BRTFQvVEh1QXlaTEJKY0EydndWeXJEaWdK?=
 =?utf-8?B?REF0ZUsyVTlqRnhZVTZNblNiN21UTCs4ZFoxaVJtdWZoSU5yMXRuMVNYZFdI?=
 =?utf-8?B?SHg4ajhzNVdaUkRtU1JKRUplWkZtN2lEaUp5dHRUUGxWTXh1d2hQQXRWT25B?=
 =?utf-8?B?VjJPVnNYWjQ1NXJ1b0tTY3NKM1oyOVhpQ3JOandyY2V2bkpNbXFQWFRrbzdW?=
 =?utf-8?B?Zm83UzNrT2NFTWtZQXRMV3M3b2FFNEFxNlpQbDlRRlRtcnFBYldSVW5sSFh4?=
 =?utf-8?B?ZVoxRFoyTFZYSU9OSGhyRGc3UG9aUEFWdUd1VE9KVW1YTGEzT0srMEpwSGxz?=
 =?utf-8?B?Y25Ea1NZUU1WQjdTOGgxMUNoY3FSWVJoNjhvcjFLdWN5MnJPcDBjMWlscXRN?=
 =?utf-8?B?dXhiNEtHRmNWeit5c2FDcGNRQ2NjdXVVTVJhb2xlNFBnK21KUm5IbkRzZDVp?=
 =?utf-8?B?aUFpL2ZzbGFuYkdRNTBwK0Z3QytCblVtei8wR1V4TEsrSGV1bDBBZUlGK21t?=
 =?utf-8?B?MFdaSlYvOVMxaS9CRXNEanFJTDQ0aDQ4OUhKRDdBenMxWUJyalkvZnlPaFR0?=
 =?utf-8?B?alZpZFRueHd2WFJvVVo5YzJxM3ZiaTdONzRIRVBpdWMxOXpDNFFZNGwyYUg3?=
 =?utf-8?Q?QnZWt8j2YYC55IlZx+lLjnVPX?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cefdfc2-0cda-4872-f913-08dd50f4ae36
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:49:58.4087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8rqG1VL0eY3FvG5PRzxQupsleYOmzA188e0b/mZEAf68nFpq6ibENrMb/yx/8V5oFX9JV0mUUi2WRPc5vvrHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10096
X-Proofpoint-ORIG-GUID: YcsxcfGHZQTIAioR5P2_HApIIts87iq6
X-Proofpoint-GUID: YcsxcfGHZQTIAioR5P2_HApIIts87iq6
X-Authority-Analysis: v=2.4 cv=Fo7//3rq c=1 sm=1 tr=0 ts=67b5ef9f cx=c_pps
 a=di3315gfm3qlniCp1Rh91A==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=0034W8JfsZAA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=vXCtUE0a-urccVGwgxAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

From: Jagannathan Raman <jag.raman@oracle.com>

Add the basic implementation for receiving vfio-user messages from the
control socket.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/common.c     | 412 +++++++++++++++++++++++++++++++++++++-
 hw/vfio-user/common.h     |  10 +
 hw/vfio-user/pci.c        |  11 +
 hw/vfio-user/protocol.h   |  54 +++++
 hw/vfio-user/trace-events |   6 +
 hw/vfio-user/trace.h      |   1 +
 meson.build               |   1 +
 7 files changed, 493 insertions(+), 2 deletions(-)
 create mode 100644 hw/vfio-user/protocol.h
 create mode 100644 hw/vfio-user/trace-events
 create mode 100644 hw/vfio-user/trace.h

diff --git a/hw/vfio-user/common.c b/hw/vfio-user/common.c
index e829abccec..2c4ee14ede 100644
--- a/hw/vfio-user/common.c
+++ b/hw/vfio-user/common.c
@@ -14,21 +14,37 @@
 
 #include "hw/hw.h"
 #include "hw/vfio/vfio-common.h"
+#include "hw/vfio-user/common.h"
+#include "hw/vfio-user/trace.h"
 #include "io/channel.h"
 #include "io/channel-socket.h"
 #include "io/channel-util.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
+#include "qemu/main-loop.h"
 #include "qemu/sockets.h"
 #include "system/iothread.h"
 
-#include "common.h"
-
 static IOThread *vfio_user_iothread;
 
 static void vfio_user_shutdown(VFIOUserProxy *proxy);
+static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                     VFIOUserFDs *fds);
+static VFIOUserFDs *vfio_user_getfds(int numfds);
+static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
+
+static void vfio_user_recv(void *opaque);
+static int vfio_user_recv_one(VFIOUserProxy *proxy);
+static void vfio_user_cb(void *opaque);
+
+static void vfio_user_request(void *opaque);
 
+static inline void vfio_user_set_error(VFIOUserHdr *hdr, uint32_t err)
+{
+    hdr->flags |= VFIO_USER_ERROR;
+    hdr->error_reply = err;
+}
 
 /*
  * Functions called by main, CPU, or iothread threads
@@ -41,10 +57,340 @@ static void vfio_user_shutdown(VFIOUserProxy *proxy)
                                    proxy->ctx, NULL, NULL);
 }
 
+static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                     VFIOUserFDs *fds)
+{
+    VFIOUserMsg *msg;
+
+    msg = QTAILQ_FIRST(&proxy->free);
+    if (msg != NULL) {
+        QTAILQ_REMOVE(&proxy->free, msg, next);
+    } else {
+        msg = g_malloc0(sizeof(*msg));
+        qemu_cond_init(&msg->cv);
+    }
+
+    msg->hdr = hdr;
+    msg->fds = fds;
+    return msg;
+}
+
+/*
+ * Recycle a message list entry to the free list.
+ */
+static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg)
+{
+    if (msg->type == VFIO_MSG_NONE) {
+        error_printf("vfio_user_recycle - freeing free msg\n");
+        return;
+    }
+
+    /* free msg buffer if no one is waiting to consume the reply */
+    if (msg->type == VFIO_MSG_NOWAIT || msg->type == VFIO_MSG_ASYNC) {
+        g_free(msg->hdr);
+        if (msg->fds != NULL) {
+            g_free(msg->fds);
+        }
+    }
+
+    msg->type = VFIO_MSG_NONE;
+    msg->hdr = NULL;
+    msg->fds = NULL;
+    msg->complete = false;
+    QTAILQ_INSERT_HEAD(&proxy->free, msg, next);
+}
+
+static VFIOUserFDs *vfio_user_getfds(int numfds)
+{
+    VFIOUserFDs *fds = g_malloc0(sizeof(*fds) + (numfds * sizeof(int)));
+
+    fds->fds = (int *)((char *)fds + sizeof(*fds));
+
+    return fds;
+}
+
 /*
  * Functions only called by iothread
  */
 
+/*
+ * Process a received message.
+ */
+static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg,
+                              bool isreply)
+{
+
+    /*
+     * Replies signal a waiter, if none just check for errors
+     * and free the message buffer.
+     *
+     * Requests get queued for the BH.
+     */
+    if (isreply) {
+        msg->complete = true;
+        if (msg->type == VFIO_MSG_WAIT) {
+            qemu_cond_signal(&msg->cv);
+        } else {
+            if (msg->hdr->flags & VFIO_USER_ERROR) {
+                error_printf("vfio_user_process: error reply on async ");
+                error_printf("request command %x error %s\n",
+                             msg->hdr->command,
+                             strerror(msg->hdr->error_reply));
+            }
+            /* youngest nowait msg has been ack'd */
+            if (proxy->last_nowait == msg) {
+                proxy->last_nowait = NULL;
+            }
+            vfio_user_recycle(proxy, msg);
+        }
+    } else {
+        QTAILQ_INSERT_TAIL(&proxy->incoming, msg, next);
+        qemu_bh_schedule(proxy->req_bh);
+    }
+}
+
+/*
+ * Complete a partial message read
+ */
+static int vfio_user_complete(VFIOUserProxy *proxy, Error **errp)
+{
+    VFIOUserMsg *msg = proxy->part_recv;
+    size_t msgleft = proxy->recv_left;
+    bool isreply;
+    char *data;
+    int ret;
+
+    data = (char *)msg->hdr + (msg->hdr->size - msgleft);
+    while (msgleft > 0) {
+        ret = qio_channel_read(proxy->ioc, data, msgleft, errp);
+
+        /* error or would block */
+        if (ret <= 0) {
+            /* try for rest on next iternation */
+            if (ret == QIO_CHANNEL_ERR_BLOCK) {
+                proxy->recv_left = msgleft;
+            }
+            return ret;
+        }
+        trace_vfio_user_recv_read(msg->hdr->id, ret);
+
+        msgleft -= ret;
+        data += ret;
+    }
+
+    /*
+     * Read complete message, process it.
+     */
+    proxy->part_recv = NULL;
+    proxy->recv_left = 0;
+    isreply = (msg->hdr->flags & VFIO_USER_TYPE) == VFIO_USER_REPLY;
+    vfio_user_process(proxy, msg, isreply);
+
+    /* return positive value */
+    return 1;
+}
+
+static void vfio_user_recv(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    if (proxy->state == VFIO_PROXY_CONNECTED) {
+        while (vfio_user_recv_one(proxy) == 0) {
+            ;
+        }
+    }
+}
+
+/*
+ * Receive and process one incoming message.
+ *
+ * For replies, find matching outgoing request and wake any waiters.
+ * For requests, queue in incoming list and run request BH.
+ */
+static int vfio_user_recv_one(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *msg = NULL;
+    g_autofree int *fdp = NULL;
+    VFIOUserFDs *reqfds;
+    VFIOUserHdr hdr;
+    struct iovec iov = {
+        .iov_base = &hdr,
+        .iov_len = sizeof(hdr),
+    };
+    bool isreply = false;
+    int i, ret;
+    size_t msgleft, numfds = 0;
+    char *data = NULL;
+    char *buf = NULL;
+    Error *local_err = NULL;
+
+    /*
+     * Complete any partial reads
+     */
+    if (proxy->part_recv != NULL) {
+        ret = vfio_user_complete(proxy, &local_err);
+
+        /* still not complete, try later */
+        if (ret == QIO_CHANNEL_ERR_BLOCK) {
+            return ret;
+        }
+
+        if (ret <= 0) {
+            goto fatal;
+        }
+        /* else fall into reading another msg */
+    }
+
+    /*
+     * Read header
+     */
+    ret = qio_channel_readv_full(proxy->ioc, &iov, 1, &fdp, &numfds, 0,
+                                 &local_err);
+    if (ret == QIO_CHANNEL_ERR_BLOCK) {
+        return ret;
+    }
+
+    /* read error or other side closed connection */
+    if (ret <= 0) {
+        goto fatal;
+    }
+
+    if (ret < sizeof(hdr)) {
+        error_setg(&local_err, "short read of header");
+        goto fatal;
+    }
+
+    /*
+     * Validate header
+     */
+    if (hdr.size < sizeof(VFIOUserHdr)) {
+        error_setg(&local_err, "bad header size");
+        goto fatal;
+    }
+    switch (hdr.flags & VFIO_USER_TYPE) {
+    case VFIO_USER_REQUEST:
+        isreply = false;
+        break;
+    case VFIO_USER_REPLY:
+        isreply = true;
+        break;
+    default:
+        error_setg(&local_err, "unknown message type");
+        goto fatal;
+    }
+    trace_vfio_user_recv_hdr(proxy->sockname, hdr.id, hdr.command, hdr.size,
+                             hdr.flags);
+
+    /*
+     * For replies, find the matching pending request.
+     * For requests, reap incoming FDs.
+     */
+    if (isreply) {
+        QTAILQ_FOREACH(msg, &proxy->pending, next) {
+            if (hdr.id == msg->id) {
+                break;
+            }
+        }
+        if (msg == NULL) {
+            error_setg(&local_err, "unexpected reply");
+            goto err;
+        }
+        QTAILQ_REMOVE(&proxy->pending, msg, next);
+
+        /*
+         * Process any received FDs
+         */
+        if (numfds != 0) {
+            if (msg->fds == NULL || msg->fds->recv_fds < numfds) {
+                error_setg(&local_err, "unexpected FDs");
+                goto err;
+            }
+            msg->fds->recv_fds = numfds;
+            memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
+        }
+    } else {
+        if (numfds != 0) {
+            reqfds = vfio_user_getfds(numfds);
+            memcpy(reqfds->fds, fdp, numfds * sizeof(int));
+        } else {
+            reqfds = NULL;
+        }
+    }
+
+    /*
+     * Put the whole message into a single buffer.
+     */
+    if (isreply) {
+        if (hdr.size > msg->rsize) {
+            error_setg(&local_err, "reply larger than recv buffer");
+            goto err;
+        }
+        *msg->hdr = hdr;
+        data = (char *)msg->hdr + sizeof(hdr);
+    } else {
+        buf = g_malloc0(hdr.size);
+        memcpy(buf, &hdr, sizeof(hdr));
+        data = buf + sizeof(hdr);
+        msg = vfio_user_getmsg(proxy, (VFIOUserHdr *)buf, reqfds);
+        msg->type = VFIO_MSG_REQ;
+    }
+
+    /*
+     * Read rest of message.
+     */
+    msgleft = hdr.size - sizeof(hdr);
+    while (msgleft > 0) {
+        ret = qio_channel_read(proxy->ioc, data, msgleft, &local_err);
+
+        /* prepare to complete read on next iternation */
+        if (ret == QIO_CHANNEL_ERR_BLOCK) {
+            proxy->part_recv = msg;
+            proxy->recv_left = msgleft;
+            return ret;
+        }
+
+        if (ret <= 0) {
+            goto fatal;
+        }
+        trace_vfio_user_recv_read(hdr.id, ret);
+
+        msgleft -= ret;
+        data += ret;
+    }
+
+    vfio_user_process(proxy, msg, isreply);
+    return 0;
+
+    /*
+     * fatal means the other side closed or we don't trust the stream
+     * err means this message is corrupt
+     */
+fatal:
+    vfio_user_shutdown(proxy);
+    proxy->state = VFIO_PROXY_ERROR;
+
+    /* set error if server side closed */
+    if (ret == 0) {
+        error_setg(&local_err, "server closed socket");
+    }
+
+err:
+    for (i = 0; i < numfds; i++) {
+        close(fdp[i]);
+    }
+    if (isreply && msg != NULL) {
+        /* force an error to keep sending thread from hanging */
+        vfio_user_set_error(msg->hdr, EINVAL);
+        msg->complete = true;
+        qemu_cond_signal(&msg->cv);
+    }
+    error_prepend(&local_err, "vfio_user_recv_one: ");
+    error_report_err(local_err);
+    return -1;
+}
+
 static void vfio_user_cb(void *opaque)
 {
     VFIOUserProxy *proxy = opaque;
@@ -60,6 +406,53 @@ static void vfio_user_cb(void *opaque)
  * Functions called by main or CPU threads
  */
 
+/*
+ * Process incoming requests.
+ *
+ * The bus-specific callback has the form:
+ *    request(opaque, msg)
+ * where 'opaque' was specified in vfio_user_set_handler
+ * and 'msg' is the inbound message.
+ *
+ * The callback is responsible for disposing of the message buffer,
+ * usually by re-using it when calling vfio_send_reply or vfio_send_error,
+ * both of which free their message buffer when the reply is sent.
+ *
+ * If the callback uses a new buffer, it needs to free the old one.
+ */
+static void vfio_user_request(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+    VFIOUserMsgQ new, free;
+    VFIOUserMsg *msg, *m1;
+
+    /* reap all incoming */
+    QTAILQ_INIT(&new);
+    WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+        QTAILQ_FOREACH_SAFE(msg, &proxy->incoming, next, m1) {
+            QTAILQ_REMOVE(&proxy->incoming, msg, next);
+            QTAILQ_INSERT_TAIL(&new, msg, next);
+        }
+    }
+
+    /* process list */
+    QTAILQ_INIT(&free);
+    QTAILQ_FOREACH_SAFE(msg, &new, next, m1) {
+        QTAILQ_REMOVE(&new, msg, next);
+        trace_vfio_user_recv_request(msg->hdr->command);
+        proxy->request(proxy->req_arg, msg);
+        QTAILQ_INSERT_HEAD(&free, msg, next);
+    }
+
+    /* free list */
+    WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+        QTAILQ_FOREACH_SAFE(msg, &free, next, m1) {
+            vfio_user_recycle(proxy, msg);
+        }
+    }
+}
+
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
@@ -98,6 +491,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     }
 
     proxy->ctx = iothread_get_aio_context(vfio_user_iothread);
+    proxy->req_bh = qemu_bh_new(vfio_user_request, proxy);
 
     QTAILQ_INIT(&proxy->outgoing);
     QTAILQ_INIT(&proxy->incoming);
@@ -108,6 +502,18 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     return proxy;
 }
 
+void vfio_user_set_handler(VFIODevice *vbasedev,
+                           void (*handler)(void *opaque, VFIOUserMsg *msg),
+                           void *req_arg)
+{
+    VFIOUserProxy *proxy = vbasedev->proxy;
+
+    proxy->request = handler;
+    proxy->req_arg = req_arg;
+    qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
+                                   vfio_user_recv, NULL, NULL, proxy);
+}
+
 void vfio_user_disconnect(VFIOUserProxy *proxy)
 {
     VFIOUserMsg *r1, *r2;
@@ -123,6 +529,8 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     }
     object_unref(OBJECT(proxy->ioc));
     proxy->ioc = NULL;
+    qemu_bh_delete(proxy->req_bh);
+    proxy->req_bh = NULL;
 
     proxy->state = VFIO_PROXY_CLOSING;
     QTAILQ_FOREACH_SAFE(r1, &proxy->outgoing, next, r2) {
diff --git a/hw/vfio-user/common.h b/hw/vfio-user/common.h
index 3529f03df9..71c0dea82d 100644
--- a/hw/vfio-user/common.h
+++ b/hw/vfio-user/common.h
@@ -11,6 +11,8 @@
  *
  */
 
+#include "hw/vfio-user/protocol.h"
+
 typedef struct {
     int send_fds;
     int recv_fds;
@@ -27,6 +29,7 @@ enum msg_type {
 
 typedef struct VFIOUserMsg {
     QTAILQ_ENTRY(VFIOUserMsg) next;
+    VFIOUserHdr *hdr;
     VFIOUserFDs *fds;
     uint32_t rsize;
     uint32_t id;
@@ -66,13 +69,20 @@ typedef struct VFIOUserProxy {
     VFIOUserMsgQ incoming;
     VFIOUserMsgQ outgoing;
     VFIOUserMsg *last_nowait;
+    VFIOUserMsg *part_recv;
+    size_t recv_left;
     enum proxy_state state;
 } VFIOUserProxy;
 
 /* VFIOProxy flags */
 #define VFIO_PROXY_CLIENT        0x1
 
+typedef struct VFIODevice VFIODevice;
+
 VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp);
 void vfio_user_disconnect(VFIOUserProxy *proxy);
+void vfio_user_set_handler(VFIODevice *vbasedev,
+                           void (*handler)(void *opaque, VFIOUserMsg *msg),
+                           void *reqarg);
 
 #endif /* VFIO_USER_COMMON_H */
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index bfd9051524..fb6c872768 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -38,6 +38,16 @@ struct VFIOUserPCIDevice {
     char *sock_name;
 };
 
+/*
+ * Incoming request message callback.
+ *
+ * Runs off main loop, so BQL held.
+ */
+static void vfio_user_pci_process_req(void *opaque, VFIOUserMsg *msg)
+{
+
+}
+
 /*
  * Emulated devices don't use host hot reset
  */
@@ -83,6 +93,7 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         return;
     }
     vbasedev->proxy = proxy;
+    vfio_user_set_handler(vbasedev, vfio_user_pci_process_req, vdev);
 
     vbasedev->name = g_strdup_printf("VFIO user <%s>", udev->sock_name);
     vbasedev->ops = &vfio_user_pci_ops;
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
new file mode 100644
index 0000000000..d23877c958
--- /dev/null
+++ b/hw/vfio-user/protocol.h
@@ -0,0 +1,54 @@
+#ifndef VFIO_USER_PROTOCOL_H
+#define VFIO_USER_PROTOCOL_H
+
+/*
+ * vfio protocol over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * Each message has a standard header that describes the command
+ * being sent, which is almost always a VFIO ioctl().
+ *
+ * The header may be followed by command-specific data, such as the
+ * region and offset info for read and write commands.
+ */
+
+typedef struct {
+    uint16_t id;
+    uint16_t command;
+    uint32_t size;
+    uint32_t flags;
+    uint32_t error_reply;
+} VFIOUserHdr;
+
+/* VFIOUserHdr commands */
+enum vfio_user_command {
+    VFIO_USER_VERSION                   = 1,
+    VFIO_USER_DMA_MAP                   = 2,
+    VFIO_USER_DMA_UNMAP                 = 3,
+    VFIO_USER_DEVICE_GET_INFO           = 4,
+    VFIO_USER_DEVICE_GET_REGION_INFO    = 5,
+    VFIO_USER_DEVICE_GET_REGION_IO_FDS  = 6,
+    VFIO_USER_DEVICE_GET_IRQ_INFO       = 7,
+    VFIO_USER_DEVICE_SET_IRQS           = 8,
+    VFIO_USER_REGION_READ               = 9,
+    VFIO_USER_REGION_WRITE              = 10,
+    VFIO_USER_DMA_READ                  = 11,
+    VFIO_USER_DMA_WRITE                 = 12,
+    VFIO_USER_DEVICE_RESET              = 13,
+    VFIO_USER_DIRTY_PAGES               = 14,
+    VFIO_USER_MAX,
+};
+
+/* VFIOUserHdr flags */
+#define VFIO_USER_REQUEST       0x0
+#define VFIO_USER_REPLY         0x1
+#define VFIO_USER_TYPE          0xF
+
+#define VFIO_USER_NO_REPLY      0x10
+#define VFIO_USER_ERROR         0x20
+
+#endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
new file mode 100644
index 0000000000..89d6c11c4c
--- /dev/null
+++ b/hw/vfio-user/trace-events
@@ -0,0 +1,6 @@
+# See docs/devel/tracing.rst for syntax documentation.
+
+# common.c
+vfio_user_recv_hdr(const char *name, uint16_t id, uint16_t cmd, uint32_t size, uint32_t flags) " (%s) id 0x%x cmd 0x%x size 0x%x flags 0x%x"
+vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
+vfio_user_recv_request(uint16_t cmd) " command 0x%x"
diff --git a/hw/vfio-user/trace.h b/hw/vfio-user/trace.h
new file mode 100644
index 0000000000..574b59aa89
--- /dev/null
+++ b/hw/vfio-user/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_vfio_user.h"
diff --git a/meson.build b/meson.build
index 8ed10b6624..0651d0710b 100644
--- a/meson.build
+++ b/meson.build
@@ -3593,6 +3593,7 @@ if have_system
     'hw/ufs',
     'hw/usb',
     'hw/vfio',
+    'hw/vfio-user',
     'hw/virtio',
     'hw/watchdog',
     'hw/xen',
-- 
2.34.1


