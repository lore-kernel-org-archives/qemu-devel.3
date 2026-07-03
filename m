Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58277C43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfeMv-0002RJ-Up; Fri, 03 Jul 2026 09:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeMt-0002Q7-KI; Fri, 03 Jul 2026 09:55:47 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeMr-0006WR-Sj; Fri, 03 Jul 2026 09:55:47 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6638mBVY2339081; Fri, 3 Jul 2026 06:55:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=jWTMCx3hSu6yK3alY4Lt7oay4zhZYyNP5oJ1Y146r
 CI=; b=oII/ai/fjk/M8O3DlDtVbRq1Gj5V6hcy6NcwrqtzxBhvnAAYetf7ZNyxl
 i1T2feEUlmayI9Dcze1kY4f7h+Sdjhvcw4NVxkUx63K7mBehRpbOHF1oMT3pFDxa
 t0DEXod76FAMdxGGeDN8FlCKxh+vlzDTQsyez0Oe3ko/jgGX0vsItl5jzVjGC+hx
 egqVQfOoVnmuq2b17c01/vmpj1L8pTmN0HLaypFdN+Qj9olBDuDobyAaO/aLu6HU
 b7TwbuZNxFlcWnZd0mnoKJZuYTAQY08KUehxhUWxQqSzJ1Rc7uTaTF1aB6WmI17P
 uRTJe/XvVmgbc/pSNAV0ciVPKgSGA==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020088.outbound.protection.outlook.com
 [40.93.198.88])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4f69w1rhhu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 06:55:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWjxmfbwUXsk5BIJZLpYwVdM2lfr/hLiM7CegTXz3JIf0HQZlxBDfyBzaPE6xrdQNeqcYbOk+sgkn/35Qe7Jx5E3Ja6m+tBb2YLwy5v5ONzS+VZ44SD3V/KqSox6VSbU0X+Xt6FfnGBCuRmHK9DbUUE1AkZhoy6zNWOEAJtK13vrU9Oc+Z84wr1D/1mAioZHfLXrcsxstAsDD/Xt5KwjM1tZc26rTlJ6owB+GdIKpspW2mL5sE7ZWnw8ot/0/0f94zC6kGq40dNYjoUsMmVVkXmyc7ejIGCWmstLmDwQaN5JxkMIKZcxvDvXm11Ghu1hBqA4DYuqXQnvt11xeuhTlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWTMCx3hSu6yK3alY4Lt7oay4zhZYyNP5oJ1Y146rCI=;
 b=g40nMMC4JS6wLGmJ/W68ekmPdRHoHeypGTYKtI7YN7LLtJLv6KuXi5xO0zxmVZ65bEsrzbygUT0MUrObXey9muRq8H3YoJQtzluvmv8HNFnar7tyX1vtF5Vrpd2BYAtN/odTdhUp47+PTPE+bEZ/4Ba3K2L+7RpSAe9Q7DZ3HsLTeIj5gnqcEgcd/IfGJpOVz74cyaTVd6qbZhP29ALKiZsNTcQILxzTXFBqACQQwkGYhaob0G4nHUTaIRMRAzklsuMKH5DmCwD1sYMUmF5OpolDGRMKbQRSOd/JLq1nB+nJFgs7UkFXF7YYRquWAlMxW8+M+9JutAZYuveznqiukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWTMCx3hSu6yK3alY4Lt7oay4zhZYyNP5oJ1Y146rCI=;
 b=UL0NtoJoq4zmLvts+F/fV3yjsHKuc+Rsg9WrsY9JixHRzWnJcBBw4u/mGN2bwlscMKJmmpMWBD6UGwnsgliKFh7fhzbgc4CrD3E9CXzN3LNy+pFz7vlqE8UHV6Wv8F9J8VHNCao9BNsip/UpIZn2qvrnw/H5W5JMn5PaiHuTeUFh4Ye3fiAYe7IqdCcstm9RgUBPJrzN5jgNs/Vr3lu6kW6MhzjhoD8rPpDAV665LGa5NXgY9Cn0x5qjgz/DEDoOlURN5Fo50VDWA8nx3MgvqGMO3N8W2Wq/q5dbq+jJNYQmzFPR+CrrEYSLZc+v1Msjgjk2gXb8gWxf+rXqKRw7+A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSWPR02MB11394.namprd02.prod.outlook.com (2603:10b6:8:353::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 13:55:34 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 13:55:34 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v2 05/12] qom/object.c: add
 object_class_property_add_uint64_ptr()
Date: Fri,  3 Jul 2026 14:53:07 +0100
Message-ID: <20260703135512.3213964-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
References: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0177.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:344::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSWPR02MB11394:EE_
X-MS-Office365-Filtering-Correlation-Id: ba743892-d8b5-49fb-c0fe-08ded90ac0a8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: TcFUiubj0KlDwdolSmos0HT1p0Y6ztVWrSKpaNCHo9eo/1NiFOlkKMOAx1n6iwOIeENxSFGNRspHQ5zlbMSQ0aeCscaHg6eAiguSWWhiqGatB/XUVkTCSkdu2FaZwPG62z/ZJ5YGBMUTozQ0yXG4GjFCuhkDyDi8AtOziSup9IrhJS13sxYQc9n8tTD1mDzYVv/N27bJTdC/XWqFiEMAEynFWW513Suqf778DJ0siIPeqhBnK0hoe9hpDQLRqg652h1HmmKKm/1S8tOoY30e9sGw7RL5jBjGcEg0YD/lOYHcU1RzHW0WOT7kQsJkkEAwxlbfyGvScg5YZYQgS1sn7+JpDltU9G8ogv0njC0jKYRmOZrAVnSzxLHuZENs+WNabuiAOfWLHmuLj4cyk9vag4HUhBGLtJbx0CxW5Lt8bCudv7iLVMXhoq7qsS6VUPculZCgVw+fCc1trUSAFCwOddp4kDzBp5AeA6tToBYKOLgQinMkgfx8fuTL3pAKuFCKk2Mh/yw95QeBUztPP1A1fpwqEz9TZ03nRtQTfaNyzY2d6VHzT+h2XsQASrGQqM4H3bpYhF0OU+g/hii2lMK+SNGpLk2mtBIbRUtGQ8/CVAKwO8faw8Jl6gCDXtmfYse5nmMh9eIfOrYnoUI+WJ3t/2tJVpGJG5mtiTcE3aWDF/WD/lEbm/bLnuHxZwSEauASSANdJVcBcuIkqorBYyfoaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ykwvwqH+iNeTpI/pp5nN5KrHlmh56k3MpvM5xH/ArKPqu2dnKJKfDFRqeM3R?=
 =?us-ascii?Q?AgVp1mBY2Z2nVWU1zF2FqlCBjjt2RUo3x6L5RguEkyWlj8o4V2BlwmfTVO5K?=
 =?us-ascii?Q?ywHqaxzQQHHG0YV9qRYJ2/zhiroc5YV5WwOf9n0i4tg+Q4O/b+/fnOZONHUC?=
 =?us-ascii?Q?meaDksF5IrTlKrO5Ut3Yb8C4DcfPiysNVZTJuK+TDB9rBDWU/xfPUvKy7Ed9?=
 =?us-ascii?Q?BYSxtXyu75d9bO+lagCVsuN403b9UD91XEa/OwmljlHhhph6wYGqLoz5sOFx?=
 =?us-ascii?Q?5BDj0K1kE036TrZcJ0SWpIHaM93PCF4Os/jof27cvQXNZN8hayvyln6nTsZz?=
 =?us-ascii?Q?lYHjnVqXsBZwD/gLd+76lxX/AwZojdCAtU1ovSWgKAIar+Gg/WxqNxS3lM0d?=
 =?us-ascii?Q?SsHlW96rnmHSoBRJQnoikFXeQOxS+N7ChurTnAx+u38Cm5GRpRvCK7S0O2Hf?=
 =?us-ascii?Q?Z8odzk3zT1hCfUBL6RFVBaRMlJr2RVJiB/eEcaiHr+kodmnQ77AQYvsGHNH8?=
 =?us-ascii?Q?3ElAtzv0NhT9a7XpqKSZYWQD5wYKs9uY1UMvMSOK4kCQTrpLRL2ZqX0LJTio?=
 =?us-ascii?Q?aRFam1xAvWIDOe3KDYiaypPE+VV/DVg/jT7ZE1/WwoDQqlD+MK8464o6qy1T?=
 =?us-ascii?Q?ntXlC/zG8Pb523OSg5lsLMuMW1nylSRMoqZduVIJQqzuDxHVPydwhNQKXEon?=
 =?us-ascii?Q?O2uPYoWurmpf+gn/MxF2ffeWdKF4a7KMG2MUgVFE2CqmEY8hkFzicdhWVLxe?=
 =?us-ascii?Q?yZhqUglVdt/taUlQxSqQ8N9cOylJ4HJnT6Mu+nRUsdhJHfz8oSPVcZaiv1X2?=
 =?us-ascii?Q?cFEsYZkIHiPrgfzsBxI06A3HJmP9dwUpYDYyDLswJ4b0lM7sYnH1tc7PhSfI?=
 =?us-ascii?Q?T0p7R0KeRO+0IaJNdtJH0mX900dPouLBIG7Dqr9cALQsz2RrBvjP/g8yKmPm?=
 =?us-ascii?Q?ya5Iri5NVXMs30aQHQRy8sLeU8macwB2UolSQq4JaWbjmNpmjvxHPBWyC7f4?=
 =?us-ascii?Q?eMqzGTPS//9K943VT/yM7Mr7WUWErga+yugOyAgK56Ag0IxJaHH6NDhUrcER?=
 =?us-ascii?Q?ufdaBfcjvcCWbxM+/3p+ORs3XN1TNmMvGVH6q7ioyHkuklsyoUypb0MM/Cvc?=
 =?us-ascii?Q?URl1N6PFjFT6551F7MB9NLuNApRZDxD7qr9G4QK426sYBghrVzDASWRdD/X3?=
 =?us-ascii?Q?ncjzb/CVi1kBdtgyjNbDtEbgdHriUrysxKM5K6epPZA1XE2AV1PMu+e1Zd+f?=
 =?us-ascii?Q?78YLuplobNSZJMBrby9N2VSRRmSjKZYpxqhTfAEhvYQZFkV2BplXiET1FNrL?=
 =?us-ascii?Q?ZZfrTTp5rubp6XAU53gbeJm2VZFhtebSepimiAhbMbGRl4ldgN7P/ghfAjR9?=
 =?us-ascii?Q?SPyFjsB9x2m3ejIabtM89m3BFr5c+H/IF3Hm8mf6QsUfXpfCE6tHykQ2RXEU?=
 =?us-ascii?Q?143moYTzH9L1KX+gEukXRY2e5WMd2e1jpukGK4Dl+5zms3oLCkZtn3PSqvjv?=
 =?us-ascii?Q?2M9YVf0xfLhfSRA+7OjCWBWoyuzq6hZhGlSeN+hi5lN39OgHAmd8H9WxaA8L?=
 =?us-ascii?Q?UzCqQSwzW4e8IwEkGr7LW7KHQYQqKtFKYJIIYGFb4s5BXNbuON656oD7/LyO?=
 =?us-ascii?Q?ZFGKP7fo9zHNyBizHE7zxght3QNjFbhtQpHBkB8YhmRU4nv5Emi2wTVAywGy?=
 =?us-ascii?Q?5eWK0sw2osQixmc7COItoMKikYl4Ww654Wq0nZ4qc5kEvWOjXgyI57vE9T/O?=
 =?us-ascii?Q?qN7AK24OM07I+nlvHfKkNTP6V49w4no=3D?=
X-Exchange-RoutingPolicyChecked: bJQUD6rjM2qxtuN+dKaW6KMVXtnGr7Sg4+1dxPl11FpSpw5mqKyOLgYIeTpVsBH8Cp86HXiA4A0Rt1y77vas/oesxDLO877b4++1n6PrFxgou0Rgf3ioYToi3boC5Kdi5OUIB/WpWnYYfv3nJ1mhlTinX27v4M3KVBkPqEyasyBe1NRbXgBcKlNRQqVJthpinavs7UsCcjqTU5XaIX7iyY+3qRa8b7vu7YA7P9gphi8EFLVGeboTTOZAqQbiECPYBqRr8tSuGhQqnfp3VJQIlPcsIsYFvgDy1NSCz2Vfg8v2YZ3nquogZYcyR20ZkRDlvP1fO55/tXpYi9bs/VWT0w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba743892-d8b5-49fb-c0fe-08ded90ac0a8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 13:55:33.9654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzteGpHvbgGxKpf+/5OAUTT/IbQaBvLvxqqNajm9ucLsM0192GRf4G0HshV5ga9mkdgDdSOMgnX4/e2M9HKHMZeKjI3Px+eFUxWrZlDrGFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR02MB11394
X-Proofpoint-GUID: cqIQBiJd8tp2gcOnrN3hdbIWo-TT3oOk
X-Authority-Analysis: v=2.4 cv=dbWwG3Xe c=1 sm=1 tr=0 ts=6a47bf57 cx=c_pps
 a=B4HvfKsIdAoZ9ZdT5gFWvw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=4QfE8SPBBHYfMhEiUa4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfX99hrOE5nWbWf
 pGbxueJLNTGbTQ57AsQoic5iiSPkaYM6c/goasYwf8jyiad8iwlhxmu1v7YLOwDlFq9gfleqQ2z
 MK9gIgcjdPzW4/82pEH3x8Miq3pSMBD9CJ3kcLt7ADo+9N5mhWqLJY0FxJ8w7FbdaJfdMHR0Nrb
 oE+Bfq/oGtW3ojYnK6yuOPOJEWc1HrQHsb8sbB858RCD8vYvQlNmD8NkXkglHQMsVOufu31CMdk
 0eDZMXSDdjlj8bFvTeK8t0NF5mbVUv0tPtmlbKw9otMonDqEuFUggeM4Xx280pNa6DR83ba9xIs
 47jPpYop56NUvPlp9peJzJzR9w7Y+6HBvT0tpUwwlcy8s2Q3n1Eli4BnffFbnxrb+3u1xcKH2M+
 nJ1c9ngFDwBBhV8hBQaiHPaArjbtWsUfM2hkYCo93PjkLpNtYMq+ZOmUn8W/k6b2acC5qM1oIpD
 NN7NqTDSBxv9M0YDZdA==
X-Proofpoint-ORIG-GUID: cqIQBiJd8tp2gcOnrN3hdbIWo-TT3oOk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfX8Zm0NkAtHWQ1
 dYRLeldMixb5ASxhv6m6tZtUkU5Kp7XsWUTem2MFn2OK21LIlbWVbA2ZLloHBnaViKurKKTAQDM
 /Tn9OirprMDUAc/ZLZXj1R1EIVIotKA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

This adds a class property that references a uint8_t within the object instance
and is intended to be a replacement for object_property_add_uint8_ptr().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/qom/object.h |  5 +++++
 qom/object.c         | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 9071d49a29..d5c32844a0 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2034,6 +2034,11 @@ ObjectProperty *object_property_add_uint64_ptr(Object *obj, const char *name,
                                     const uint64_t *v,
                                     ObjectPropertyFlags flags);
 
+ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
+                                    const char *name,
+                                    ptrdiff_t v,
+                                    ObjectPropertyFlags flags);
+
 ObjectProperty *object_class_static_property_add_uint64_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint64_t *v,
diff --git a/qom/object.c b/qom/object.c
index 3089eba273..3048131435 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2821,6 +2821,30 @@ static void property_class_set_uint32_ptr(Object *obj, Visitor *v,
     *field = value;
 }
 
+static void property_class_get_uint64_ptr(Object *obj, Visitor *v,
+                                          const char *name,
+                                          void *opaque, Error **errp)
+{
+    uint64_t value = *(uint64_t *)object_class_prop_ptr(obj,
+                                                        (ptrdiff_t)opaque);
+    visit_type_uint64(v, name, &value, errp);
+}
+
+static void property_class_set_uint64_ptr(Object *obj, Visitor *v,
+                                          const char *name,
+                                          void *opaque, Error **errp)
+{
+    uint64_t *field = (uint64_t *)object_class_prop_ptr(obj,
+                                                        (ptrdiff_t)opaque);
+    uint64_t value;
+
+    if (!visit_type_uint64(v, name, &value, errp)) {
+        return;
+    }
+
+    *field = value;
+}
+
 ObjectProperty *
 object_property_add_uint8_ptr(Object *obj, const char *name,
                               const uint8_t *v,
@@ -3024,6 +3048,26 @@ object_property_add_uint64_ptr(Object *obj, const char *name,
                                getter, setter, NULL, (void *)v);
 }
 
+ObjectProperty *
+object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
+                                     ptrdiff_t v,
+                                     ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_class_get_uint64_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_class_set_uint64_ptr;
+    }
+
+    return object_class_property_add(klass, name, "uint64",
+                                     getter, setter, NULL, (void *)v);
+}
+
 ObjectProperty *
 object_class_static_property_add_uint64_ptr(ObjectClass *klass,
                                             const char *name,
-- 
2.43.0


