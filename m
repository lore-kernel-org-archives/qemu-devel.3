Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACADC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXh80-0000rX-N7; Fri, 04 Jul 2025 10:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh7r-0000oY-SI
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:10:54 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh7q-0004iu-04
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:10:51 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564CJlkk023056;
 Fri, 4 Jul 2025 07:10:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=M1kPtUv4WI3ycXgG18t+cGHK8rha3hi9nNVxUIOxM
 Es=; b=vwdOOzUqAKwvcjN/2rRxSfPU/MNiFsrUnyt28eOXzipVnBAlT520WNmXS
 AOnfpZQ1n6hJupKo7fvYSprhMJfoDwzHD/nMSo90Lbp9aSJ+1Rh/FZC8wf9aWhNA
 dxOI9hPi936rn4EXzyk93wUXpnKvlAM1wee+vqCmdm18Gw0nCEdsIo66GXwVIToK
 +nmkLzEdD9x3fJpG6Rj2VzYSV4W+h4+9eseyhnFilHQdIl9k9nuTouWxPgvOdJaj
 PLJjbLJwYxLRU/f747IKslk6aSp4RNE39yvf6iF2uLj3kw7K8GVbqQcJSRlYRhE8
 UAJdq81bBfii4dGkIiDHxddXm1vQQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11022119.outbound.protection.outlook.com
 [40.93.200.119])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47n1x96a4h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Jul 2025 07:10:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdCLW/NU9cPqRReDvplErTSTC295mBSuMfJGhyAqmddNbLdESOvsWxlw5tvd8YBkrPopqN/MG5UP5MUq5r+iUdJHjTDhnd81BkKNHy2zredFeGOZai9aHRiG5R+PY0zxd1FjZisAnO3e1h6agB2WbzYFBT/u9Xz1+TxaI4y9v82jqe3EFcaAb4+1dAsFHiaYsK/Jf3Xf8PsyzKIe92libtVu5azA8pTzpH0mkkw12mDe1wy2DQeUuvKfBrJJag8sHwzqetPJ/6KY1DAepVOpDyRlozTFlwh8lnWiXkcb3IefaQLqpM6N68DKaNq7Y0w8t2y5o9d+t5iVHNg3Q/tC+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1kPtUv4WI3ycXgG18t+cGHK8rha3hi9nNVxUIOxMEs=;
 b=j6KWdqk9ZADMod9Z89wlFcKOw88g6CdzuY9TJyEwaLCrim01V1jBvaI2K7hkrHFaYN5tAbyHNDgQihNIxDe+E3fsoXpvumvLVIolU7jYY0krs9AVxbDj/aBFrmSUscUpKxMML75fVtK+Qe6aYGDTfv42G1IDXdB9E+9S+EAa+8KunT7O6osoeW1+0MszX0kEZaquBuxgep5jUz/XJaBv2Ts1sl2EPiTeHoHg9FUsZk0eSg1MUbnPrWQFUq8yQA3ayy/v7vouW0Ytvg26ni4XBV5CqpN22iy5pKOWhxw5VYh8Wv2VzSHjpqUvT8lUn82cjahqZfLzM43OfUd1KCuqiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1kPtUv4WI3ycXgG18t+cGHK8rha3hi9nNVxUIOxMEs=;
 b=b5Tje0sGJWH9p1m4yRSvnM5B+mx7aQFwVbWkJwvsCBgy15BF1GDYIzp3sJbz0pgaL03ouXEtZQoW7vUJ12nCNI5l52bz5W87FN54q60M11aqvIRclepEQkY70450SVx3rH0gZYBm5GYWjFYQ5zfm/720b/qaNTqH2oRuXKahKZpLhPwfbnS48NXtK0Dicctp+7EY1ffCKZAGBDoz2hYk1KvcWG+Yi8GSETmbIYoLo/R+f2aVbi4AKV0PRvx7ZeYQeKlaUyk3bCih1dKwGrq4KkMk5pRSBNK36VwaZcB+HpbbZZ1omRbpOOP9sepaXy4xlxWO+3g+I2Y2NfGyeq5YEg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB9087.namprd02.prod.outlook.com (2603:10b6:208:419::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 14:10:43 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 14:10:43 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 06/14] hw/i386/pc_piix.c: remove nvdimm initialisation from
 pc_init_isa()
Date: Fri,  4 Jul 2025 15:09:33 +0100
Message-ID: <20250704141018.674268-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704141018.674268-1-mark.caveayland@nutanix.com>
References: <20250704141018.674268-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0015.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::28) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: ea9ed5f6-8902-48dc-d012-08ddbb049064
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUtSbzFqUDhSSUlpZlVCMkg0SzNnUHZSL2dNUEtNekZFeDhnbUJ6dkZsVTEv?=
 =?utf-8?B?UThhNWVFeVdQUGRuMExQRGpweEJranA0NFdNdUJ1SllPY2E5Q3NaMFdMaU1o?=
 =?utf-8?B?Y1EwRUlpYnlob1VaZ0lYazlnRWNnY3RoKzB4b0R5b0NVZWFYaXRzR25pd1FP?=
 =?utf-8?B?cFJSYTRUNFY4RFIvWnQ4OUtSNUxrU0g1eStRMEVEdDBtQmNkWGpuOUs3ajJB?=
 =?utf-8?B?WU10MTN3RlNGVFMvREtlTXhqdG01dmVscTdjZ1pCMjlSNExFQ1BITm4rdnVZ?=
 =?utf-8?B?QWNUaE1LU2hJYW9KRHBlY0ltTFJJVmJXQ3o2ZWVhVklzWTZyTFkyV0ZSQmZQ?=
 =?utf-8?B?TTdacjkzelZUMGJSSWhXSE9aUmw1N25RQnNtSWtLN2lzYzUxc1BFci95YVlx?=
 =?utf-8?B?WGZCajZNazlZNVZyZS9zb204dnhNYkQwU1hQdUxSSTdBcWwyaFpNZG45b0NS?=
 =?utf-8?B?Q3owc1p4VUgxeldKdHp3cFlWUTJFUHRPRTdMZTlETTdZbUR3MkwvQnBhRmpB?=
 =?utf-8?B?dEZCbFBvb0l5enZTQkZrYmU2YXR6OVBSTHdhNERpSnJ1aTNMMEFkdC91TGNk?=
 =?utf-8?B?UnNkeDdUODB4dC9vdi96VWNKSEVkWWFJdXQvbXlicHRjUEQvVWY2UEh2UlJB?=
 =?utf-8?B?cDB5TkdhdTAwUnJkQndIcTVtTU1GYjAxRGRaZjZWak82VlMyMDlWWnF2Q3lR?=
 =?utf-8?B?NENEcWFVVE9nQ2ROZDdqemdON0NiL2JKN1dKSUJyMFpWTlQzcllVTUZFaWtX?=
 =?utf-8?B?dm1GVG51aDR3eXpHT20yL3hNV0QrOU11VGVMU2d3YUZiUTFBcXpBeHgyNmoz?=
 =?utf-8?B?UWhQOVFDREdXb2JYR3FNRjhHRHJ5V3RzOTd4SGM3RTdXNW03bVgyMllFdFRX?=
 =?utf-8?B?RkdMVmZjYitvMXJYc1ZRU2Z2Z3h1SzJwRXJCR0Y2WDExOTlEamtJdThHczRU?=
 =?utf-8?B?anVmSWIzcy9VQ3p1RkZhVXdISEkzaEpBNnNlc0FaS0pMMTZXbysyMzFYNGNX?=
 =?utf-8?B?U3pGVjNtQlVBeFR1RklyU1F0a0dFQ0dsU0RxeUlSTTY2bStQTU54Q0dUQUhI?=
 =?utf-8?B?bXpIcXNQMit1dVdxMXNWVEwyUTR6YU5rYjB6Nll6c1N5Q3JRb0NVNGp3eGgr?=
 =?utf-8?B?aVNIeGswUzB4Rld5eGEzZzNVL2V3a1kvZU9NSjVYcVBqUzhPOXNLRmFBbVo3?=
 =?utf-8?B?T0REUmkxaGloMTJRRzViKzIrK2lKZVFyUkduS2grSE9ETHNxWTdjYVU0Syt0?=
 =?utf-8?B?MGxKVnVidENwbnZOa0NqeU82dnB2U2czSVhHTy9EQjhLSWpHQVJONFJHSzZK?=
 =?utf-8?B?aElQSE8wenE4dCtuUHpyZkdoUnBzT2liVjJFNmlVOG9jSXZ0VW1oMlY5Nm5a?=
 =?utf-8?B?TG56elk5SGdtb3ZycHN2QitKcjFOYmhMcUNPZUJ0RFJEQThEemJKRWFKZXN6?=
 =?utf-8?B?K0Q4ZGdJblFid1dhNHY4SmJOS21wL1VtRk9taXEydkNlNXlYVjVJYkRlTzFr?=
 =?utf-8?B?VHNvQ3J5ZHhSR2dTNHlCQ2hUaDNJY0R0RU5FbEdpWWJRWkF6cnBScndYLzRW?=
 =?utf-8?B?M3ZMU2dCSXhEaUN5a0c2V0RmS3ZYK1Erbm8rS3RZSktiT3V1S3crQ3R5aDln?=
 =?utf-8?B?SE9LSDYzb2NNZkI1VUJuRG9ERkFZZmw1U1FNcE9DcDNBWDVUaVgzZnBGendZ?=
 =?utf-8?B?L0pLbTBmbmVMTWNNL3IvaUFYWEE0OXUvOVNpSk0vWHdpRzNzUXRmamZSQ00w?=
 =?utf-8?B?bU5xdkY4QmRKSU51UEFZT2RjNlpXdUNnWFBZQ0oxdWJnbFhKWHdEZE5DQjQr?=
 =?utf-8?B?Z25YTmtqU2hSM0ZWQ2JkcFFscW93Tm83ckJ2VHpZU1IrS3BYTnZQZ2xUNEds?=
 =?utf-8?B?cHNTQTZTRVJrRmg5bGdzQW9rbXJCSHMzY1YwVklMV3dBRUhWRUxaMmlNdTRS?=
 =?utf-8?Q?8nSgiDFsSxA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTIxQTlBWlpMMVFRazFodzludkVCWHRmdW1PZ0VlSW9BdVVTR3lVcnU5M1Rn?=
 =?utf-8?B?bjBMNDZLVzVHVzJXaE03dGo0eWdSMVdQRU1ITVZ6em5oZEpudUVCVmZBQ05X?=
 =?utf-8?B?ams5VEFOMXFPRHBQZjZNdmdmL1pLVGU2OW9qaXpVQnozalBLb0VEK2QybzJG?=
 =?utf-8?B?S2x0ZGg0d0RuM2MvaDBjOGt1Qy9DNWdDR2d6TUFtWTQ4RTZldjd4V3duOVdE?=
 =?utf-8?B?L1Azc2R6aktmQXlpZUhodWZXR2RKNXJCa1lzVkp0b0YyOEo2WXRzanh5M3Rj?=
 =?utf-8?B?WXpLa3BkTVRXM1dtd0NzQTQ1SDN2a0FjUzNLdjdhQUdhOTd2UGlYWFN2b3Y1?=
 =?utf-8?B?Nk4ybXY1ODNlZkpVVHQwUytTTjNsZGVSU2pCTlFpZ1Y0aGEvTldjUGZicFVY?=
 =?utf-8?B?SnJ6bXNFbWUySkRwTnE4K29zZHhzUDFQWSt4N0NuK1M5b1Q1Z2s1d2xXWmR0?=
 =?utf-8?B?OFA4QTQ4TTRuVmc4MFBMM2J1UVBBaTh2NHo3ZVNJaTJMZ2ovTkVWK1I4cHBO?=
 =?utf-8?B?Tk01V2tQdjJhenlkSERmaGdBbzA3bXBKY3laK2p1NmMvZkRaUXFNaGd1UUVw?=
 =?utf-8?B?dnQ4N1Z4WkNlMXVCVHVFaTZ4S2ZFNDh1S21HM0Z6ZDV1ZElqS2x3WWtCZWRs?=
 =?utf-8?B?ZC8wZTVDRWEvVGxrT295dWIxNVlJUnBJeElkMkxjVHZ6Q21jQmtRZkZHanp1?=
 =?utf-8?B?UHZkUjExQll2RlBoZndGL3YrUDNwck9yQjZRYzkyYWJPdENJUUhHTW9lUnc0?=
 =?utf-8?B?cm54dXlmU1AwdkFjWVVFd2oxZ3Ntb2Q3YVJCbGNvT2p1Wk50Vlg0YW1ROHhT?=
 =?utf-8?B?dGlzSnB0aVN3TWFseGF2dWVTZTR6L1IvRk5uYzg0Y0l2a0ppMEJMRUs1T0dJ?=
 =?utf-8?B?YWR5bjlRTTNuREQ0VTZ4MTBTNjdpSW5LajNRTFNxUkdaNXpHbGxrd0VKcFRD?=
 =?utf-8?B?dC9SU2R5TXB3UVNJR1JlSUZFV2NzaU9YcTkvOXRrYmUvMGJZekVRMU5zemJ2?=
 =?utf-8?B?TzNvYStlZi94NTBnalBlVC96VEU1SFdsZGNCdW00NjJLcFgzcEgvWU0wY0Zr?=
 =?utf-8?B?UHlWUzhUdmVrZHd3dERYSmZ6UjMxU2ZPU2hpTHl1NzFQdm9xYzRHRTBsc2la?=
 =?utf-8?B?YkFxUzFmN3RTbGVUcE5RbzM4OGk4ZHFCSXFKbkptdjIreDBtbXN1YkVWNEYv?=
 =?utf-8?B?Mzg1d3c4UzBlSjNESlpEa1J1d1BzcGcvRXpmcmlSaVF4dVdiYzBFWmNSY1J2?=
 =?utf-8?B?dHhtdUFraUd6SFphWGxLc2RORnNuMTBGY0htZktpQnNIb25pQ2JxSmhaazMz?=
 =?utf-8?B?VU9zQnJ0QlRyUUlJdlQzQTJWNUp6SW1OZ3llRUNRUDlxcnI2MmE1UTNRMEp4?=
 =?utf-8?B?UDNrc2YrVXV3cHZWSHhLeW5Kc2pRQ2dRSG41RU9sclQ3VU9Rb2RzUTNiY3N1?=
 =?utf-8?B?a1BVSzFHbkNjbTFIcDFPcEdEZFJ6TUdKT1VwUjQ5K29pbUNROGpwNWFrUDRw?=
 =?utf-8?B?LzJFa1k5MGRSVlVLT2FCTGQ2RjdVTUNoSDhwRmQ4OUt5blBzcytRZzVXeVNx?=
 =?utf-8?B?U2o4bVIwK2pBWnRSbys5T0R1NlhxNnJUVUlWRFI2YjhheFl2N3RqZEM0eXV6?=
 =?utf-8?B?U0JDd2dSQ1MrN09PUXJvSVNqYmdmVEh0ZnJmclU5SFNmdDFhbkg4Y1pCLzVo?=
 =?utf-8?B?TWtpajNFTkpSTkozYnIzS20rQ3J2SWpmNnhsTm9GVXY5MkMzRjlFY0ZOYjhv?=
 =?utf-8?B?NmtOakFEL0QxWkl4Z0VXcU1KZERFZSsybW80WWF3SFVKRVJNbU8rV1BGN0FW?=
 =?utf-8?B?S0xQK2dHemtUM1VtaFRMaFlhT3F6T2dibEtTTTNWT1RHVEhPdG5qUHJEZFdS?=
 =?utf-8?B?MTRGL0sxMExKN2lpRUJUaXJ0dFU5aDdSVXNDYUpHQnBQSStXU0FwNENkNzZo?=
 =?utf-8?B?MEttenJCRWZnNWZlb05mSlN6Y1VIL2U3dHpKZURQZldjcHRDU2JsNHQ2Nmcr?=
 =?utf-8?B?Vm56OEdxczBuWlZMd1o4ZHlraEl3TEc3dCs2UWxIWnRRZitjMHhKa2NkaDFo?=
 =?utf-8?B?d2tGZWpLYzM2NnZMN1hzWHNiRlk4VWF3R2RNMnlzV1FuOTNjUnlndGczL3JQ?=
 =?utf-8?B?TUxFV0RzTHp0c3RueXc4Qi9xbUFFN0dkemw4c3UvSTU3ajdjSHp3WjJ1eURv?=
 =?utf-8?B?aXJBdFRyYUlTeGo1YXlmRVAxZHNCTmtFZ0pramgzVXlueGlSRk9Da2FXOGxG?=
 =?utf-8?B?a1AwZmFBUTM4QUJMcUtmS0ZNRG13PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9ed5f6-8902-48dc-d012-08ddbb049064
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 14:10:43.4093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvcTYHxgBiokWchkUaZWTCQuOOnW8qG6F+B7qe3ZEyqiCpYrg67EnQHJqbbMEAOJqX4haMCMnRqGpyr3hfP3YjEAbz30EBdZkYLrC/Mg8uE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9087
X-Proofpoint-GUID: E50_GS9_IBDhagqGkUFeH-900eYJrOmG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwNyBTYWx0ZWRfXxYnKFPHvRsfi
 RqZxqMKkyh16WKKRwyxWVRynbP8xghrjMijwxo4NJAlskkYLc3Q6b0YdDmEOF36yKfy1h07KQyk
 nOEGnZ2G2wYMw2WI5jR2mDuPxvMsEdQCNTkj5NIbfFIKDoJ+1LRXnJvXGOxyOwQvvMH6kojOrtQ
 n4ObAS7uRIxi2wsnB7LAWlXw0LL1IQUq00gwf7xGqK91F7zlLcYhi1RTwgOD/d5Fr4D8tLQj7fK
 eH2TOylyWaGC+hHOfNCHD1nRkyQz0DtTeEO9MY+6UF1wlVm8hTwBE/PA6RM0Pp1CueHs61yQZ03
 Xl242bQfbk7DZRIQzDj95qec5G5Su2AgCPrXEpymBINO12LW488yxj2eiSNig/C0I9dN33blvvz
 HwjUfFzAKU1mYSiQNoVZn3dXlk0kG623UByF3PXIus+3ru/LVW0pb1Gj716dSepvxRGRbYqo
X-Proofpoint-ORIG-GUID: E50_GS9_IBDhagqGkUFeH-900eYJrOmG
X-Authority-Analysis: v=2.4 cv=V7190fni c=1 sm=1 tr=0 ts=6867e0e6 cx=c_pps
 a=GA26isaq87aKbCxmYTjF1A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=XL6wrB0Zc_gxRR1ig4QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

NVDIMMs cannot be used by PCs from a pre-PCI era.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 75226aa775..a6a35405ba 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -574,12 +574,6 @@ static void pc_init_isa(MachineState *machine)
         }
     }
 #endif
-
-    if (machine->nvdimms_state->is_enabled) {
-        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
-                               x86_nvdimm_acpi_dsmio,
-                               x86ms->fw_cfg, OBJECT(pcms));
-    }
 }
 #endif
 
-- 
2.43.0


