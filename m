Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA0AC61DD3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 15:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzy7M-0002Sp-1G; Fri, 28 Aug 2026 11:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzy7K-0002SP-TI
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:03:42 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzy7J-0008L2-8F
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:03:42 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SDTQKp2742391; Fri, 28 Aug 2026 08:03:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=fDz03E9jCEAZGOjpNYvOrsCLxXp1P20v/R/3K1jMp
 BQ=; b=Vrfo96EQM74Inb1rn9E6lfsuPqWa2tR2x4E/pSkVtyjS8EfRiuW9umgtV
 nNe+Oi38gZOsTGZ/ApgBIBBJGDqe8cuoRI6J4BATRj5Bhi5mK2YnK14JmhkyFCoH
 A6xFgPlD83b4Q9/7q1meb17I2KupGm2i/4aKPve80xT8QaIPHIBKlHnIedKaST+h
 VYqAdcQSQGb0U07g7+vsSDzBg5bu2JkTmXsxb1DTorzc4Ir5ZDgFz0iO9Gj4mHG/
 lqpHbHO5/EF6jEVmEpIOCOqcD63jMAfThpest3TMgLylqm9I4i2A67ijOZB7qBy4
 xiGeyEktWYRksCoju/ZWlNXN+7SJA==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020118.outbound.protection.outlook.com
 [40.93.198.118])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gaq9uu6b6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 08:03:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHzshtk1vKMPyqThKcns9wZrfk3mcJu9ZCEGlFyJpoQkZeGTtljc4qdMa0i6oGBpUdaZ/LbL5+BT+J4UAms8YJajeJn0waSK8+qvpoQEWbLyhCFkHbIwyJtdytFNr9c6qhDwL0XsJBLhp0SK4r5duXHh39C/4FhefZCKm+rjMFnDGMGlgHYqGd4AIcxpFKqed/WbwhYxhapwBBE+ebyIj9W3VRUF1S6TRgWqV+EXvTncx+S3ux2iiBxmrsHU/DtWn1q7EXMRmOtiyZsIbN1X++Er7Cjf24QOIUNPzsyN+WY0K3YoaxRWlT7p6HdhebZwvtwjfFCyKxxIWm5Lu4tNjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDz03E9jCEAZGOjpNYvOrsCLxXp1P20v/R/3K1jMpBQ=;
 b=h4RU+p5wSTpOLZqR6yMhu/YHxWLAO5aJDRVWM4HWSrOu4+CSLjfidpljxIfjkEtBA6CuFBsMXYOSGmK7eXHDhz2fKb9RLQ+o1xbOotr+VvBf3aeCejkZ9edfyylI3QiYUTznJIXtp4VYe3WwTu8RxRXa4VLdzhWrjQdMTVE1Hxlp9gAc5bzXilNL2C3gWGFUUDblzLZj3hLbjQqVM4jx83hu3XrU8fgwV8BEPSHxnlxdXK5P1gteivsvTh50SqSMgcxnkPdds29ZDf7i7qaWhVKQyhcFRXbcMdisCxhnF/fxxca9JjBlisI1I9ylcNUjiRm6O3NvTNy2/tHobxKPTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDz03E9jCEAZGOjpNYvOrsCLxXp1P20v/R/3K1jMpBQ=;
 b=uHs8cMHvweOt/pRDDTxuCAngEqGD1vwUJgdfSAJRnotbhwVPLOLvWFVMlXIyoe46FkzUxljnOHFBQKN0iDIfBcgGyK+QC0z3ZECavMDu8AsvI6rDm5P5KfJWaGTa/p6mOkSa7hj/+DvDOK6ZABGWJczeWWcVkuV/cEmYHetIm+tJxoSYPGV6twm2s6+9qB6mV6bkFQANiUt7ybE1qzZvU5/r4V+nXlKV+o7oWPIb8lbJSAmMQgOim1KWKGHbwXwFXpojbvVoY5uTWRDBh6zRnYPT//DNmH02QrFaLVm8qCau6WOweg2fIy/tNkTnjyFf5wPWlveOY64KO+lSn1Cm7A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM4PR02MB8909.namprd02.prod.outlook.com (2603:10b6:8:b5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Fri, 28 Aug
 2026 15:03:34 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 15:03:34 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 5/8] hw/i386/pc.c: convert rtc-time object prop to a class
 prop
Date: Fri, 28 Aug 2026 16:02:01 +0100
Message-ID: <20260828150313.1883999-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828150313.1883999-1-mark.caveayland@nutanix.com>
References: <20260828150313.1883999-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0049.namprd11.prod.outlook.com
 (2603:10b6:806:d0::24) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM4PR02MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: 59572a50-24ef-429d-50c9-08df05158807
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: o3xJF/FCzjHCTBD6ZgMGFQd8e9CzKFetaYcfldWbMSWx6YXRq7BJcgzBDv+Pcl36ier3h5nr1k3PngVbFiL9Of7xenJ9LeP5JorxV0Wjq24G8iDxRIvCnkQ+KYjnZDVuEUOE3bz3rvolh6GKA87wdDYPCEBO3fCmQhXsjF5V22Sl4tV76w09CVfon7QvxXmoMW5vILq9y1jyHTW706Gv8HZGgqNp84EZfWd6ZW2sTU2cGIZdxRGo+B7t8OAWMOGtoGPf6KYnDRzUZjnmUGPHMBaW3VY6Rzw42J3jDrFhdYNorIvTLGqsHAFkWVct0eYDHIgOcNnaPLckgM6QZxr7xUG5cw7yqPlhlTPzZji4ozzDe4HbWDopa13h3rpBKp93XuNC1V6nB2vpClkyEE+Rn4+hkrQlFJEC8vSuML7W9A26+whGYVX7e34Xbg26sKny2xNPnMgrO3R7as2GdaUZbi2lva3zMy9+Hqn5i1vYtQiwFedmoCzJoMeTVQ11ecCeElee3TJjzGUAE/QeUc2avrKOZgbvA2Or4yFdpjzQL/8ZEAjFrkbuCB/F46uLKRpAU1uRugPTT08RNgu6qu/p6FKhSw47PJr4qLi5U7txfi8UDH6NOJ5+S5rKc9UheXPnQUSga1RvZwh4oPloNAdea1t/2JP73nlO+Gz4SFXd+to=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1VxZ2c0VVo1R2dSUjVVM3NkS3BEUlIybkIrS3ZCYUFHc1FPYmxPN00yUHRU?=
 =?utf-8?B?K3Uva1RXRkJqZWxWbFdvbWZ2YWlYT051ZzZiOTNzSDB0R1BQbTFleWdFUUVo?=
 =?utf-8?B?WFJ5YjFqMlYxazY4RzAydHZYdzJVTWdpQStJNGUwL2R5dXE2RHFaek9iSnZh?=
 =?utf-8?B?dUtFRTUvZEQyQWRBUVdnbG1MQWk1R0JoUkF4NW1xYlBFNDVKd3JyN1V0eXR5?=
 =?utf-8?B?THlpVHg5bWZ6OTJEMm1CY2h6aW9VaEJ6WnVEbFJuOEUvaEttc2xxVzRpZkdN?=
 =?utf-8?B?RWwrc25aMEFYejFmenNIRWwvMDZRbVNEMDR6UWZTdlA3WFU2ME5WUHM0R1Zl?=
 =?utf-8?B?Vnl1NjNvSUhLVmNkNTdLbDRBZmQvck5lV1oyOGJZcytxWE5EYXFIbzhvM3Yw?=
 =?utf-8?B?QVhLakRxemdpMzRVdVA3MHkzWFNLaUNjRFpVNGRTZFVrYzBiWndzWkRKY0Ro?=
 =?utf-8?B?eUtLck1FV056WTVVUjcxN0tHc2VCNkFtUTVIZ0ROQ2pEdG1RNCtYSkFWUWhU?=
 =?utf-8?B?SnVQT0syMEFueW9OUkNZNEhTZTc5STdidGZMeExncVMvWTdKa2ZuTE5Fbi9V?=
 =?utf-8?B?VnhmY2lZSVZxeVY4cld4QjAzanVGbFFRUnp5dStpaWFZT3VmdUE1bjNOYVBJ?=
 =?utf-8?B?OXpacll3RE5SSk54ZVN2ODFCN0luamV1NDZZVnBseUZIVWJnUkZvUTZyNXUy?=
 =?utf-8?B?NnRjc05PdTNqYTlzUEhYandWL29hNmM5UHNNQmErU1JNL2RTZi9DT0FrUXJE?=
 =?utf-8?B?YkZvSDdhWjJxVi9kZUNra1RCeXpaQlowbzIrY2l3TloxUURmeE9RSGNjOTR3?=
 =?utf-8?B?Wk13cEhxdnJMRmROY241MWRCNlUxNDFueXRXUFQ3Q1I3RjVMOXZXTWhhY2Ex?=
 =?utf-8?B?TE82RkxudTU1ck1VcU1zUWVUUXBpV0J1dSs3Mm1SUWZtN3ZpSnBoWTlRcUFu?=
 =?utf-8?B?TXYzejFDZytoS1FDSFhMSjVOa1ZHZms1YWJzY0RtSTYwdklKcWVQQm1oL2s3?=
 =?utf-8?B?N2xEVHM3WGJqdThhV2JjZ05pckprNGFTRlgxcW5kMVNBUVNhNWRicDVCRUdM?=
 =?utf-8?B?cFhhSUlDdUJ4RFc4akNVZnhUUnhybE5NVkVJSG9vZ0lqbU5ndFZCNkcvUS9l?=
 =?utf-8?B?SXl3UWd2NmM5WkdocXN5MCtTNThacHVvMEZXNEZxNlpFNTJoZkVyTTF5SHBS?=
 =?utf-8?B?NlB2a1NaSHhNRjRzdXJ2ak1WMllpejFZc3hoZUZnRGlMYnp2N3RpNWpZdkl4?=
 =?utf-8?B?bW9jUHFSamNIQlN6Tm5QS0wvZkZ3czZNTTZ2djd1TnBXNVd6YmZxMmxRVXFP?=
 =?utf-8?B?Q3NKVzN5L0Zoblp6SzZVUzhDNE8xQ2pQeDd0WXhLc2taWjBEZWZhQkcyK3Er?=
 =?utf-8?B?bEgwZDdLV0VJSTd2cTYwRkVPZE1xRzNMNlpGTG9iWllNQXJVanJlNmNiVDNT?=
 =?utf-8?B?Q0hBTnpPYnA5UE8wM2QxRWh5aFlGanJ4K2ZZQkt3ZlFXbXZhWVNaQ2p2dFdB?=
 =?utf-8?B?Rk9OcVZPMTd1Q081Z3RpSm55STFJcEpObVpiS3JudjlsNnhCNzFDZHVyTVVn?=
 =?utf-8?B?Q1F5TFpXUTAxU1ByekRCVCtIdnBqNzM0VjQ5dVZPdTFTS2w3VWtUVTkwMXJE?=
 =?utf-8?B?N1hnMXdJRnBzNWNuR3NaRGJaZkNJOE5kUmcvaHhDWUF0VXAweUh4dm9LSWFC?=
 =?utf-8?B?RHY0UzZQanAxNkdEZXRLUlVCSWZWVlpyWk95SkhJUVpKbHZDeUtIQkZZcEZv?=
 =?utf-8?B?MG1IeGk1dStHNmRPd1hzM3FZczlLVDFqK250TktkYkJpVnU5MW82TG9LZjVW?=
 =?utf-8?B?SUhVZHJ1QkNaUTZDK0RxZ2htcmNINEo0QkRTbDBOOWVwTkQzbkFqMEF1ZmVy?=
 =?utf-8?B?Nnh6Q1RTZ1Q2aTBxNzJPN1NZN3RFYjNpT2hJRWZRcmdab0NBVm5WYlJRN0h5?=
 =?utf-8?B?TWpxcUdHMUVrcENIcVQ1QkJzRnNMdUZvUjh6TzR4SE1aL1lkT2I2RFZsSVd0?=
 =?utf-8?B?bngwYmxpcWgwbmhIczVOZUZzd0FaUnlGYkVrVit6NEVYNFZUbFJwNW1NZzl0?=
 =?utf-8?B?WWgzcHEyL3piSWJIYnJjUjV6NjBmeTVBMGtGNUNLOVBNby9abm5nekpsaG1t?=
 =?utf-8?B?a2x6VWNHVkxDYU8zQzk1MWFlM25iZ0NENis0M3NML1NyTEdvNWRXbnl2OVF4?=
 =?utf-8?B?L004ZlppbFJkTWFCc1Z3b3JJMzdEZG5PbDJTODAvSGtCMXVSc25DZUVpRTVv?=
 =?utf-8?B?dzROaU1VRWcxaDJwQkdVWnkyRk5rMGlYcGJXbUdwNEYrMDhkM1hTcloyc0hR?=
 =?utf-8?B?cmlFdDRDYklXaVJucFkvNEtEYWVzU3JnL0laVHRFN0EzQU1ZaW5nemUrcWVB?=
 =?utf-8?Q?hEqEOcs1LP+V3qr8=3D?=
X-Exchange-RoutingPolicyChecked: ceIcZg75RWKaquecxWrf6O+1tURbqJY5JvioHnqnmgor1NzCL+BCzdrBVIRS0MiZZ/2mfC1n+qYH7shgB+9DlT2SD5/6ZEB/LpPv0fhzTtlGalHp3UuZleNnYKtBRWZ2FrbJplFysYzaxmO9uSLXDka2zsuc77U9k6KYy1t4U6TCU4rKmddwFKsWG9h9CAFEt2jusuJQ2DJtmaHxY4l1lj2jW6RjQUWgd84F+JSTj0ZBIe6MJRFZVV/KZLedNZ/C9sNFT9H62GVbitUVtTXFPuNQPj6Tqtzl4pab+PYi51VRejjlsBRbKvVKyoX9OvuH80q789ueCxd7OVvQRJbR3Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59572a50-24ef-429d-50c9-08df05158807
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:03:34.5871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2L6PrG3xNl1ckrs8GlJF7/HvLsm7StwuVChF0fs3Aa2aj8Gwo1Qulv8y41yWUfrSRea41WvMdZJhaZs3m59wb4bZt3UXoTVGTgRXLue9Wtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB8909
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzMSBTYWx0ZWRfX4iLMQfBctwQG
 0ZVkotFm+2yjbXztlYMFDynFPrt3sWjk+wfrkQ6ZhwYf3sPa0bqxtOK7aW6QhMlDtMu9lbLf1GE
 uv8U2BNBzEY4pftWDQNuG1DfeBGNv5Jmc3UDDcEG5f5gKkBsXYvqgltm5KqMGFOCaPur/FJBh3G
 RBPihGtu/+TNUsWWotDmG0aZmsM5//qKYWzdAgcXTsbe6hLenBFu+6zTsbDa1DpNyVBhA2QcOIA
 lJIxyOlB6pBF9hO61pJddj8soIkFnqkQyqh9468k+Oqt6GABkzmpxrP3kcBLIbNLzMRdyEEREBv
 ut3lUa90j8aBK9j4xo59ULNX9bAfvcznJwkV6KHa4g4qt58/yXYfgBiLQEqZrtKRCsOKOqbwMgJ
 g8TNfs2wlsW2ML5pmS45UmKrlc7rcEAyk/xvFq/1lw4ICVKdtZbEBDX72Z0WeoW9WNN0StIMydT
 ZGIjsv+gGALRLWIeLxg==
X-Authority-Analysis: v=2.4 cv=ONQXGyaB c=1 sm=1 tr=0 ts=6a91a34a cx=c_pps
 a=LryC7IEqKcSdoWktnkYnkA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=DDMMZ6NTPqBClWpVUZEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: oSdsA5V8YUD81qmtAxYyRJ6FX8_d9Y8N
X-Proofpoint-ORIG-GUID: oSdsA5V8YUD81qmtAxYyRJ6FX8_d9Y8N
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzMSBTYWx0ZWRfXxCW3jgaNnY6D
 rwjcHfYF76dpqEQjpuz02dHXt51KSNHVN16YpHdzx4SWRJ4S7bauFWrmSh2go5KRYbznwI9+y97
 zKMyr3n9BLLL5gNGjl7h53+3thBts4U=
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/hw/i386/pc.h | 1 +
 hw/i386/pc.c         | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index bd800e7ff0..0b925ccd8f 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -39,6 +39,7 @@ typedef struct PCMachineState {
     BusState *idebus[MAX_IDE_BUS];
 
     Object *alias_pcspk;
+    Object *alias_rtc_time;
 
     /* Configuration options: */
     uint64_t max_ram_below_4g;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5293c59d66..f8969ddebc 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1097,8 +1097,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
         qdev_connect_gpio_out(DEVICE(rtc_state), 0, rtc_irq);
     }
 
-    object_property_add_alias(OBJECT(pcms), "rtc-time", OBJECT(rtc_state),
-                              "date");
+    object_property_set_alias(OBJECT(pcms), "rtc-time", OBJECT(rtc_state));
 
 #ifdef CONFIG_XEN_EMU
     if (xen_mode == XEN_EMULATE) {
@@ -1792,6 +1791,10 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
                                     offsetof(PCMachineState, alias_pcspk),
                                     TYPE_PC_SPEAKER,
                                     "audiodev");
+    object_class_property_add_alias(oc, "rtc-time",
+                                    offsetof(PCMachineState, alias_rtc_time),
+                                    TYPE_MC146818_RTC,
+                                    "date");
 }
 
 static const TypeInfo pc_machine_info = {
-- 
2.43.0


