Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E30C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzbBJ-0007m5-8c; Thu, 27 Aug 2026 10:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBH-0007l0-S1
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:15 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBF-0001xV-Fq
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:15 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RE8hZ54183099
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=3Cn6lt56nOuV8lthtMddPRwUe8nGxj/EvCOkxVNkg
 kk=; b=1tCO8UJW1xZ1pSdGlnVFIWnF5WJDKMfrHU5HE3i5kJOcB7KorgpCqoa3y
 ciLHGnThwJyTPfA2ftQAKp+NmiPH5xzHMpGgkHYF7s5YfgpLndmJHcCUvx8EsqAj
 mQuWL5b2os0JVVjVjrtS55IVU3yQIoj6AoYPWRA0VrspGrdtAfaU6ouXl1ew1zJ6
 nAYDKn3qu8jdLnldrQqILGAQdPKvGOHcJQ0eVkootJHzTXTce1iriv78n+/YMfTl
 tSq8ZCWDJygdLQIBNYFvObtmXW8rbcdG3Tkkb4GuU1sklzYx4b0auEUgqbDTXqc3
 FgqnBfzCdeYZHPsPmkMbzeyv5Nm+A==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020115.outbound.protection.outlook.com [52.101.56.115])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gafss128e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJdEazmpCgCLWoe+a3kfJ6wv0+mLtHfjvrkOjwJ8RZzC7qHzKowbK0UhHTYmfrESfUzzw/Ty6WCJFFoPlQDQKmBf7nCVJFOoJqSghxJ1+2lqlsocX6d0NgukdIJ/eLU+MeHAmp0kDPSkhsn7bdrxfnU4Brv+c6xyA91NVm557ujnrNFfua+V4/Ym8YgkKxqoi0NrClARHHOTS9Ih05z81vWxYfLl+ZUyGbwC9fKSZN+G1nOIb9boUApL5vl6kHGnRV04lPwDX5SP+1UvVefUalQl2/MyULVTd6sITR1fBDw6KMmyopran8VPPUcKIRBKaS7PW9SXmwhc03trf2AFTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Cn6lt56nOuV8lthtMddPRwUe8nGxj/EvCOkxVNkgkk=;
 b=mQcNQCM5Zm52OiRutHaIXWbctKwY2/MzeVamt3wXwupl4qfLfWLXCDOmbwXZyqn9KzIfZvxvZkUfR+2LM6/GCN2qJl5JcPztUMk9sE+ga6CFmSIF/Cl3Vu+e13Tv2SWriJ6urceY9+NBoTB6GUnxJMGMEZ5qZDXAccXjwLv9zYISAJyRIC6CWAzii/A3c6UVTisNajwibHfyI9Bkxnvf4nExfgjAwXID+SNeDiF0QeOeL1bdUuG4UMx2+83nBa4jPyC0g7LVYz25t9wG3YdeWNyJFhtSGwemq8PPKaW/8Zzmng15hvug1bOsOu8hOPgPdwxy0tsEewiuwZtvMcCZRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Cn6lt56nOuV8lthtMddPRwUe8nGxj/EvCOkxVNkgkk=;
 b=xWVbfdoJl0W1q5bCbova7O2W9A0dzNVsYKUFSIhoLwSgBrSq6BoXJNbO/kQRUwOq/ZzXsRcy6cwn7sUYl2HPiEsW4/CmW6vHo4J9PvISpSILiWq38dYQHjkZNb5QswUbqQwMwRfTmnIniOMGMs2UGgW64klfOtuWn9wKA/a+DMlwXIlNenujjsRp5fKZaOllu/u21hp6cfLEzcG3ZXLjcbBPo1J3UZjAp7EpnhyZmw2b/kYfvXTgoIBApe0lqJy3qI3pXjnXnhTeYLW179Rrqy7yxynbPhpZOG4QJKd+A27q/dxW0EDtPi7pCvlUm0iBfjhtVMVa7jelnSLsyIU3sA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA3PR02MB12061.namprd02.prod.outlook.com (2603:10b6:208:629::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:34:10 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:34:10 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/16] qom/object.c: introduce
 OBJECT_CLASS_PROPERTY_SCALAR_GETTER(type) macro
Date: Thu, 27 Aug 2026 15:33:22 +0100
Message-ID: <20260827143404.1393166-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
References: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA3PR02MB12061:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b39cde-b95e-44a4-3b5f-08df044841e8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: Btvuu3iNh4lEaWA/vkMQLfrtrDk5fycZnaypIA4R+LpyStOTEACWXpXY/P8UP8lFyTyNEkZBp4qCuRPwbUppwDgWxLMN9YSCaYpnx2ZkhnSKiCY7fJoJZy7C8gI43EOHuN0Tx/LS+vedyoFcsRrSFqN/rdnrEj57jUwfiK7iWbaSnZQBv9+tG0qDvmA7aEVZcm4NefiTLjCdep2AHrDRIPAN8Oyk8FXE4KVVjkSldy9EY82HbDiXgcOz9ZswmMk+uhPZ5rR/R8L42idUQF1t4I5kPr/bY7ASrFbcWNhbB5I6iuYv/OzFhpSm/HiAQBEx9iIqyeB7k7jrEY85urZjlD18auHPN0SwzIZo3iT8BbuUUh7u0DKXJE7O14ZX8JAzp3f0MSUzA3uVVW/ijuOb4SnjERnVf9lO6DqlY75U/3Aaiv8TUXoCNF9aILybPKDjYLwKbeKyhso4NrJuUGTLTu1l4eHsb97jaJrtu0Mlso7FwFmn7hptAq0/ojmeiqbHvG3fuWPtyPlbFQtUP2TCPfDShzjylC9Yfd+EgZfO/M2cgNYcA+sHPBvM+iVkdaQfXEE7llYuVOslWnHaTz0ySc810v3CmXpD5Opu4vrLDJ9V5Z20RXg/2ZG6KDKUVPp9ZMHvN/8IwUpoZja3YRMCt/9pRRe26C/xY/sD4flhPlc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnUwbmZZWHVpejE0MlAwRW5aa0J4T0Y4aHRJOTBmbHh0Y2ZlRHVSTWhwNmtJ?=
 =?utf-8?B?Z2Juc20yc3F0VlIzTDNBa1M5Y0tudEc1MFQ1V3Mxb2ZBb2xCcy9ZN2tJNWNh?=
 =?utf-8?B?cW5LdFJkWDI5V3o1SHNFL0t6NGxZZVFGTWw1ZW9WUXI0MVMwOWloNXErSnk4?=
 =?utf-8?B?eVE5UVlwbFEybitNRnFHSzJyZ3BuOVJHOGRHZ3hPSk1vRDlja2t3ZytYZjdu?=
 =?utf-8?B?Mk0rTS91azZ0cThaL3l3SThJczVHblUzZmlhb05rR3N6b2duWFgvYWh3RVVl?=
 =?utf-8?B?ZjBaVUQ0angrOFJYUHdja2xET0grN1VaSGliZkZqVjZRZGM4RFV2bmsxTGw2?=
 =?utf-8?B?d09Uakp0dER5UUpBSk1pV2dSV2R1OFhaSWMrV0U5S3JPSm82RU55cHFtQXBj?=
 =?utf-8?B?Z0NwZ0hPYXROaUprbWR4VDYvRXhiVDFoZHhnVXVXZGIzR29hdjBRMWFrR3V3?=
 =?utf-8?B?TUt2MXhTaDNrUkVSN1BLdVdKNVZKWkYxdDBqUHRlL01QWFc0YUpkMkxuNzg1?=
 =?utf-8?B?SExidG9KNVFQSlFyVnZ0NUhTU1FwWk81eGpOSkpjSk9WNitQZDRZdjdIM0c4?=
 =?utf-8?B?VmZHYUJ2OXpsaFdTclNtL3RqU3QvZXA4cm1JWDRjMHZRbXM3OHV1R1NKQTdZ?=
 =?utf-8?B?Vld2OWhzbmdON1Z6UnpyVmVWQWs5VUJOTmM1c09NbGE3RXlFZWtoY0YrTWto?=
 =?utf-8?B?c0w1d1lrSDRmckdZK00yMHVjVjYvRVJjTmlnZE0rLzRoSmhkQTBQd040WEI1?=
 =?utf-8?B?VHFRbExxVHA0VjRCVmRDU0RPUlgydmdMSnFYUXBweHh4czNUbDdTbWRsYUZ3?=
 =?utf-8?B?NXJNcVlnakhKTkVzYjIxTGgxcVFodENPUm5WU1RMdDlsdmtSN2wzWjNJWFBa?=
 =?utf-8?B?MVBHbmU5VEZuTE1TbmUzVm9XVk56Z0dOOUE5MHVxbkVVRnAzREVoTHVld0Rl?=
 =?utf-8?B?bkJsZ2hGSGx4NjVPVks0eUF3VUkyL3NuM0JFV2gwSGNXLzRSanZhc3FTTS8v?=
 =?utf-8?B?OFFpWjVTTk15ZHkwWERiTjBxNmdpQ2ZZV3h2akMvYWF6SzNNK0xjdVZFMGZ1?=
 =?utf-8?B?S2k4NERsVU5WYlFDVlF5RytkYXR3NFpUT0dXUTVXMWc4bzQvcFdXTDN4RDdK?=
 =?utf-8?B?Z2gyREEzL2FFaWdldEp3cGFoZHBNdGtOZDdwcTM2YUNaL3NlWDh2WTZmWjkw?=
 =?utf-8?B?c1EwK1l3b1dCZkhteS9Ga0NmNmhQTmhTMTNIRk1zeXFJSy9UTTUvSmdYOHJz?=
 =?utf-8?B?VEtLN2lyYkFhNSttRVRRSnlXMm0xVXlGWkRadG5JbGNqSDlqcTRPLzgrV0dC?=
 =?utf-8?B?KzNqMHNYS2xOSFBneFZmY0FpTWlWWXRXR2ZyV2pUazNNZ3BIL3czSWdhRVJ4?=
 =?utf-8?B?eVhRSmt4MjdyRDFTZk5oeEVnUGRabWoreURsREpkdzhkd25VRllJN3hLUERK?=
 =?utf-8?B?amdQTmk1TDl5L2k0Y2lWWFhkaWNXTWFESFFTYUR2NFpWcS9YVDE5T3U5b1R0?=
 =?utf-8?B?Y0swUzhueWNSdTFIQUNNTzN2aHpnd1BqM0M2SEhyK0lmcHdCYXUwZlBYUFl4?=
 =?utf-8?B?c1RCM2MycWV5MGIvVUkyR2gwSXQ1ZzFjTm82cXovY0NwRFZheFVESEVBdEVE?=
 =?utf-8?B?eS9mZlJ4dllvMUwxVmRaaTV5VGp4ZWg5eHhkVmp3K2JxSFhIMUYzcVBuMW83?=
 =?utf-8?B?c20wcjU3SkFGcG9hSzBZNzRVU0tuUWJHRTF5dGNvZXpPcDJaTXFQV09Vb3oy?=
 =?utf-8?B?VU5nQlRoWkpZNWkxSzNlcTVlT05ySjF3VDJzOTVoRjQ5d1d4bmhhdWVIbSt0?=
 =?utf-8?B?S1drQlU0MUJqcXNaaEo1a2x3SkJVU0RUN2dGY0VPUTE2NERoMVp4R0dWL3pY?=
 =?utf-8?B?ZjlwU0dCNkdtMmU0bDZ5RG9tNXg5QU82ZWMyNU44WHczekpHTUVJZXVQc1ZL?=
 =?utf-8?B?RUlvUDNmL0RGTzYzVmxTdFdmbURPWGFlcTdxT1hkVWlHT05Da1RYNzY3L0hT?=
 =?utf-8?B?QktMdEFTTDJ2K0w1WFh4TnN3QWJ6angrd0dnVHozdWMzc3I1TmsyNzRxOXBI?=
 =?utf-8?B?bU8zd0RDWUw3enNWOHA2akdIVWlySXdyNkFqS0ZGWGR3dm1HaUR6TnVIaWRs?=
 =?utf-8?B?TCs2MHVPamQ1aXJMWlpYRCtqSUlWelRSVnMzdDZWRGRLOHJpUXBPYzltcldx?=
 =?utf-8?B?MVZwSVJLWVFVVFdkMHJPVDBkZ3FRd1dqMEhzb1RlVjJVU0tVMkQwN2hhWXNj?=
 =?utf-8?B?N1paQzk0ZnJBdkFyRUFRbGQ1UlhjSWhNT1hOM28yckE2SkFxWmVJQTNVaDVB?=
 =?utf-8?B?d0F4VHdjbU5XZ3piZmVXNTQ3Z0pVSHJ3K0Y5Z1h4ZGRzRzZtL2t3T0NKWHNS?=
 =?utf-8?Q?CD9msa8bmVIDYLSY=3D?=
X-Exchange-RoutingPolicyChecked: mBmKfsyR5XTV4BBy6Wfn991hkv0te6QwxJeVWiXQsAafUBvTc3bd6KxLx5G2CZlmstxEuZcnHr84oIha1KP4QY6+tWCiwJ1NF7dDXJX/wDHghE2x51cUkhqjnxzUCbTHfRvAF1pxj8AFLHGGPPc5XJ/WFqA8tIAEp6LHcm16A2RvDs4MM2dEiB6ECKktQ8g7Z7fpsaAtZ9zCBBed278ueT0+b48Tu2XaERBTaZ2GUegxMSUffM8sYGTXkdA5ngl4embocCI6TA96EutJTpGcBwLUtW7ELUn1sVvhbbVjCcGCDoydvX2wiLWJBKWdNUbN85APiWLe2z0AHZqSfIbNiA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b39cde-b95e-44a4-3b5f-08df044841e8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:34:10.0532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UnYtHiOKvoS8cgXzWFGI08O5S/8b6jMQdAgwvsiiYDdy9u15SlErRRQK0tAfvAG+CqSWCJbjeJr+DICYI9FSqRrW6vmQG6XPp12sik43/zA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB12061
X-Authority-Analysis: v=2.4 cv=YOWvDxGx c=1 sm=1 tr=0 ts=6a904ae3 cx=c_pps
 a=Oahh2kgEN5ymB8sO0SiNEQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=sXIxgEWn3KJhRak5j5kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: em03bODFPct_vXfz2F74EVdK-fgErRIL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX2EKer0Bp7hjg
 8Ed0mQwzJLtnGrqzA+Frp0uCH8bMyHIFEpF81MR3YOetLCnDkET7kbQSG67S5isJuw4GU5XAGET
 /f9QjIa1rfwqC8hq587xdbFamgfUddY=
X-Proofpoint-ORIG-GUID: em03bODFPct_vXfz2F74EVdK-fgErRIL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfXy2QS7Q9CAO05
 v7YIOPuzIty8kYbw+45c66Rlu+Inypty9jnT03BhladAwuHik/qxtVtFnzjc0+/2h+2/kYuKzOE
 Eizo0BHjDo1gQXeXKgUPenq/PP/xiWFrqFCaz+F3a8TnLYnd0pawnS8Gu3G4RILibSGvtpACbwR
 foNeQgCwGutCF6VHLm4obVuz1ZaWJcO8xfL+QEcqHO2/XZx51oOSlZi3l9rPsWS82fm7hLsWDi8
 m5scOIyVQXKGgB6N2ayXWOOqPB2O5CXcZbWF1KFScOUdf647Jp/BVlFH/5k1cv8tPJMWBt0oFfD
 UMKOTgXxn46os3Fls0lP801LkxAS6V4/Z6kQPgE9BFN7bk0AvHrk28Dx7aVWc+XzVR3ODDDpPOF
 a7+kYN9P1fxvnn5mlLQPdpVpXwNi5RiRV1N7V6ZTcfXMhPPnQLXjacDZ1FOAZNusylWYuuEtsQk
 o2SsXs0nywwJbPLWfqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This macro will be used to generate the boilerplate property_class_get_type_ptr()
QOM get function for the specified scalar type.

Note that since the macro is currently unused, the object_class_prop_ptr() helper
function is temporarily marked as __attribute__((unused)) to allow compilation to
succeed.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20260825134320.1039012-2-mark.caveayland@nutanix.com>
---
 qom/object.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index 47977b1f44..e32ae30bd5 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2703,6 +2703,28 @@ DEFINE_OBJECT_PROPERTY_SCALAR_METHODS(uint64)
 #undef DEFINE_OBJECT_PROPERTY_SCALAR_METHODS
 
 
+__attribute__((unused))
+static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
+{
+    void *ptr = obj;
+    ptr += offset;
+
+    return ptr;
+}
+
+#define OBJECT_CLASS_PROPERTY_SCALAR_GETTER(type) \
+    static void property_class_get_##type##_ptr(Object *obj, Visitor *v, \
+                                                const char *name, \
+                                                void *opaque, Error **errp) \
+    { \
+        type##_t value = *(type##_t *)object_class_prop_ptr(obj, \
+                                                        (ptrdiff_t)opaque); \
+        visit_type_##type(v, name, &value, errp); \
+    }
+
+#undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
+
+
 ObjectProperty *
 object_property_add_uint8_ptr(Object *obj, const char *name,
                               const uint8_t *v,
-- 
2.43.0


