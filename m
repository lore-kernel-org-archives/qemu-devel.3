Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932C7C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXh7r-0000nf-On; Fri, 04 Jul 2025 10:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh7f-0000hs-Da
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:10:41 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh7d-0004e2-3E
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:10:39 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564BAZ9i006360;
 Fri, 4 Jul 2025 07:10:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=PKJZ3Npw86uIMi7wY52rzbu7QHtwkd178YWL/FcVo
 uI=; b=MxUxIc3+1QLKauPcmBpxMnGFlwsav8WwM9Yl1N8ffdAfAe+ZrcJ10iZC0
 9NNbOnU1lXY3PRDCMz59GyWgb+jBjErJSBsp1ajP6l3y76LWE9efvFdkbql/IfT1
 xcjFYni3DtNlixlWsjAz1STql5C7rjbx9naTY6Tm3632XXfWZecEPT+OnBRGHetr
 Fs/nh989Yb2oBhtjdAol/o4NcaSjmrgo3w+5sXerd3lpw9ZC7prKpq2aX9TWO5Fi
 1QQIzwgkVLRxSye5s27yMfqO0qdD9g7BLd/Mta4fzqsdugAWFMoSzV8xYlTPZiPH
 Eikj3mDE8ycBn2LSUaXLt3VIppkSg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2117.outbound.protection.outlook.com [40.107.244.117])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47jdxb8t2t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Jul 2025 07:10:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjCXGqPCI777sFeZEcKl0pZv3RA1ysn9udvF5cph2hbz1JvbImGvA1HzdsHBfotaZ6l7U/5nQjy7LRLzQZ60/m9Hjc4MEq0Fvdp2D6zgJkqGMiH1EaqSzgiAzlwkGOxFX6A52i5GKJtxpQO+GmyBWk8OA/i/6C72bAUlJ1jkX03DvartfI6ms+q+0WN663ulkET5PEVxLcCw0tIxppBI8ZLx5jxaJRMpww2xHTgS7/ZI8voAT71/NolYjMR0Bkfnttzz4yw2YMjeDBrceMjIRS+p9GKNkQ7NzSH5k60RJHneiUxOPYbSd76lcpZvXUMBBeezhhpc6489GTa+1SEs7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKJZ3Npw86uIMi7wY52rzbu7QHtwkd178YWL/FcVouI=;
 b=sdni+bxSgwQ37vNY0ZUKt9hL9CDRcgccbiCcJUJDb8BbwbdtUPHN3UH9vS+136astdXOho25E8iaezdRuYdYwQxlp/A5Qfp0NwFxiY4vAxOJlcGX+k3qDAr6OLL8w7fmrke9yVwLABcFYnKpPy9UrUddOg/WWb8iNNCn5fjb3QsjBWMATLBAn20vpznqgQtBX+hOuD+FI6XdYAmu/nwPyJmdeexKQWp2yieTyb2RBvxECXwhcR9mv2fVSx1+Y2nkUL3F3mIbDyEahiyiD7kt9q2JtLj8RbiiGWWSPo42Xg1UgG5tAeQUF52KAp0tcvWdYpaOy/vtLo59lanXC1qA5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKJZ3Npw86uIMi7wY52rzbu7QHtwkd178YWL/FcVouI=;
 b=Ihj6101H0SmoKqvbuMFoMZVmOZg/bis5kNyeBUhd7vGaoQ2vm5Y+FeSZ4Goshx0qCEL0btW09zXPor4iEezPW42umSL2QGR7KryAba2fIvVSItpJRHK3fxbQVYmfbfhs73JEw7o7AaYLp6LavqMwFrSEppWedPCs0mtD8amC/R1xRGsu45hVs3VyG+Ez8DP5gIQlRLYEfxZ/bAY08A3X9X7BViD+1Z0ZxUuyJk98xbtDY0tREMJv4JL0Y52LUfNiQgNmUv7ussJ4HH/Uebw1petvl0IZ4hhOz5snIAywB7/pd5d3JjBYpHl6x5inydOskrs+62TCdCdJlrqOrWT05Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8045.namprd02.prod.outlook.com (2603:10b6:408:16d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 14:10:32 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 14:10:32 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 03/14] hw/i386/pc_piix.c: remove pcmc->pci_enabled
 dependent initialisation from pc_init_isa()
Date: Fri,  4 Jul 2025 15:09:30 +0100
Message-ID: <20250704141018.674268-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704141018.674268-1-mark.caveayland@nutanix.com>
References: <20250704141018.674268-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0001.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 572f3e07-8777-4e51-1038-08ddbb0489d0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c20xRUZQd1k2ZnNZa2cwZFNYWXZ3aUhZc1FXUDhGSm0vY0piRmU3U29rOWwv?=
 =?utf-8?B?ejZTM0NueXZ4OEtNWjBnNHo1NDZmelBvYkhjdnI0NnBQTDJ1SFNoem13MDVi?=
 =?utf-8?B?akpReG5IN2xtaFBrcHFieHNPMHBUTkhlVmhnSllzRzl3elJ3N2xZRTdGTy9Z?=
 =?utf-8?B?aHdtRlhRbE5QMmdVeHRLdERGWXlSSFZtYkpQTDN2WGd1RUVYaUdEZnZCenNr?=
 =?utf-8?B?SWl4cjhwMS9DVkhqR2V5SFdxcW1USmMydDlkemU3blExTGxJOXV3TTYxanc5?=
 =?utf-8?B?ZWdDeFAwWWsxa0VXMm53ZEhQaFdFK2s0TFNqY1FpR0hzOURVY2FMMWtiNHcx?=
 =?utf-8?B?c09OZkNQOER5QXBqYURVVjFBckd6RmY4cVBOUVVNOWc4VXhweUs4NHlKSUJE?=
 =?utf-8?B?dTdmODliNEpiWTZBUmhpUkFZcVVmbDlnNFhONG5BUUlWTUxrdVZib040d09X?=
 =?utf-8?B?S3hHY1Z4MFZEMndnZ04xNk55Vm1VV2pJQkFFZU9DWG1xbjJ3bnJkNzZtcmsr?=
 =?utf-8?B?M1R2MTN2OE16Uk93VCt5bng0bU93dm1jMjZ4L2FNb1hCcEkzTzJMK215S01S?=
 =?utf-8?B?S3o5UjVkdWxnUm01OWFqTzNCdVNaelp0RHVFWnlIdmRLcDVVZ2NKWWxrM1lZ?=
 =?utf-8?B?QXhEMUlLbzJJWFUzeGNtK3k0ZkluSHZSd3QwdTZ4T2k0V3hFZXJuTU40dnB2?=
 =?utf-8?B?RU1mR1RMb2E3TUhHUHgvaEVvZDNrWkRUOTBoMjY1Q0kvTWNlQjRPazlFOCtZ?=
 =?utf-8?B?OVV0bFNidEdnbzNybmh0a0dhYnNFM1ZCWDZpa05GZFowZ1BQeU9uaGcvV1dP?=
 =?utf-8?B?VTdDSEJuRmhMUlR0U1VlR1ZobVFBZFEyVUJlQ0RJbnl6WGN2bi9yUmRDT05q?=
 =?utf-8?B?aUhCcGI0eE92S1kzaUtyaDh6blc5TjNNa2UzZzdVTllxOS9ZaGYxZVl0S3Av?=
 =?utf-8?B?SkhxRjhiQTBXc0RxKzhPRFBuSnJSVUZWTHBvK0lMd3NlODlDZnJDYjJGNnVa?=
 =?utf-8?B?eGpPSE82V3RIYkt0L1dKYmdjNFVqVHJwd1czMlczUHh2eVRHcXZkeCtIWmtH?=
 =?utf-8?B?MkRadGlBUG9jQWxTejFUc21Fc0tYVitmaTdtci9peXp2M3gyU2U4WmNWVFVr?=
 =?utf-8?B?NHcvQmpTZGI0NnA4WjVHSDRVdlFmYks1NmdjODl3NlVaRzJKcTNmeXMxajZl?=
 =?utf-8?B?Ry8yV1Radlp4enQ0bkhGVXZjaXlCVlIrUHcwVEZqakNtWnFWRjFXdm1IUStX?=
 =?utf-8?B?SDA0dlM2czlKcFVhL3JaYkd3b2tUNXNEQXJYQkpIVXJVckljY29yWjdtcXdQ?=
 =?utf-8?B?OE1iZk13TWdaZGFORDNTRG1xYy9ycDQ2RFVLcDVrRlhMMDBhdlhZZmh3M3Zu?=
 =?utf-8?B?VWZ1Y1FId0gvdWphR3hzbW9nQVdQTFEyRSsyVldYTWptOGQ1dTB0aGRlZFNH?=
 =?utf-8?B?aDIyRy9EWTc2SThCa0hOWThIY1g2V2lnYXZkSXlhNVcwTmw2MjNTTEtsQWxx?=
 =?utf-8?B?aFBXRUZJMHdjT0o5MUx3WGIvcnVWNko3MVpnMlBWdDJnMzVBclZGWko2M2xK?=
 =?utf-8?B?eGpNWndIZjRjZGZWZFFJdXgwcTM4dXRqczQ5Y3pKQkVUakZZbG56K29VclpO?=
 =?utf-8?B?bHBFVmlyeXB5U3VuUW80WkZkeC9Gam5FZy9EK25SL2ZIS2huY0x1aVozOUpk?=
 =?utf-8?B?T0dadGJ4Y0hzQVZBUlJGSTJIV01uZzFrVDJVZE9nYTZnS01WNHVNT1RLdHA1?=
 =?utf-8?B?MkQ1NTUrYkswdy94anV1UzFMNXJKVHBuWVVyMkVKN1pPOE1GUXJGTVlEN0RF?=
 =?utf-8?B?amRoZDNVSDJHUDZobUpxdmJLbWVtUkQxM0ZtMmRMeERUMWNraTU3SklGc3ha?=
 =?utf-8?B?RUlCdDI1MFgvV2ZVN1R2Ny9KbTRIbHJNS0psdVZDaVlZSjM4aEFqVE91d3pS?=
 =?utf-8?Q?lQKsvcXrsPQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3JxaEJnVFIyNzQvRU5IelhEdkdwTk5nUllMdjBpWXJKU0M5bXdlc1Jqd3I0?=
 =?utf-8?B?OUVDTjNRaWFLWHYrazdhVUhsVXIrYlRSbHB6Q2FZQk13aHlQWWJTUnlidEpZ?=
 =?utf-8?B?M21kWC9VNC8vbXY4RDVJa042QnUvemZ4OWswMU9QL2pxM2dIRXdPNkJvcldB?=
 =?utf-8?B?eVorZHVKd3kwM1BRcExwZmUza2t5eFhwb0g4S0g1K2hCTmY0SWFac2xHazho?=
 =?utf-8?B?MU5hNXJqVUJnV1l2SGMyNnpVNTZYQWNESzh4R3IvYmptcVU1bTZrRzJ2K0ht?=
 =?utf-8?B?RjdVOUluTFRYdkZqZm91dkg5bHNaQ3BOSVc3VEJjVjNqUlo3L3VuWXlFU0Rl?=
 =?utf-8?B?NndteHFBK0NhUGhWVnNoc3FoRXBSUnFWcGRwdTgvL3l0cEZGVC9HQWVscmdB?=
 =?utf-8?B?d2ZuVWRLQU1WbUg2OEQvQ0VUYzVoMVVIY3J3ZEpqbnVXYlpOL1h2ZEsxcVUx?=
 =?utf-8?B?MTBYM1ZMeWFxMDRDeDFoK2NMbFE2SUVubkhPcEdZNHF0TEhYOGVVVGM2MG1D?=
 =?utf-8?B?aUZXNTZGY3AvTDFib21tZDN4NmlJTjB1UkpvaWQ3RlBobXhINHU0em1PR056?=
 =?utf-8?B?YVFkR00zSURSNS9xSkFSTlpWQ3Rpd1daaC9QUVc5QmxLeEdMVWR3WXdid3Iv?=
 =?utf-8?B?OHZUd2xNZ0J2Nmx3SkZNVnVBV21IVGhpMnZ6QUtGeFVHWER0UzFPWm9sNjlI?=
 =?utf-8?B?bzU4K01CUzlIbU1qVWhjRjBNbEhGN3U5MnpvMlBIc1RNLy91UmNtS3FOVW1X?=
 =?utf-8?B?bjRMQUJ6WkExZGZPd0pnZWp3TmYrMjhEVkljUkNGZU96N2IzKzdpQUhpbXJ2?=
 =?utf-8?B?dm9nYUQ0NjVDd3FJUzk5Vm1xZkd2amV4VEh6UDU0K0FIZVVDcnZldk5zNVFQ?=
 =?utf-8?B?ZW5tQkdoZkdUSzZ6ZDU2THVmRG1iRzhST2owaUR3Y3NuZ0c4RDZhZnhIOXZX?=
 =?utf-8?B?K1ZSNXBjMnh4L2YxS1ZwNmYrSVlCNjNGOTFOT2lCVDdOd3VzY0l2WFlDNFk5?=
 =?utf-8?B?MHErSjQxaDlWWDNoOGIySzR3S0RJRjlKVTJGZllYeG41Rm5PdGFDd09Dc2pL?=
 =?utf-8?B?V3B4K1pZZ2lNb0lMbVQ1bE1RNEhiMUwwMmdNUVJRaGlqeTFWVjh6OXdHUHZn?=
 =?utf-8?B?RFBnSlUyY21CMUYvY1llaXJKVHBKY1NPQmExWW91UEl0RGRTYXlSbkhSRzVX?=
 =?utf-8?B?cUtxRSthSzBUOG1RMEJFWlozUTlOeWF6MU04ampGWjhhNWZhQzE0SHI5WUl1?=
 =?utf-8?B?UU0zbEJLRzV0NzRvR0Z3dnV6VUpBNjZiMU8wc1N0QkttUkVQa3hBQ3MvMDdx?=
 =?utf-8?B?WXg5R3B6T0xXWkFVSFdiUjh1Ti9iSG5raC9pODZxUXJFQkhyVm5FNWpybU5L?=
 =?utf-8?B?TWovNEJGcWhGREY5RzlXb0FMakpNb29OYlNXamVVTGgyQlBBVkZKMGtCc3Zs?=
 =?utf-8?B?WHN3NUVQZXhkRFNVdkJGcEoxN0Z4N1U4V2lCa2lDS2RWYnl1bkZIeGczZTlJ?=
 =?utf-8?B?QUF6ZUREUkh3WStOMVhHdWs4VHVPb1U4QUxneUJJMndxMkx5QlAxN1VFZ1NL?=
 =?utf-8?B?eFNkUEV4bjhPb2Jad09ZOGQ4ZVZWN3BRbllzV2VqOHlxRzh5dW13MTZxVE0r?=
 =?utf-8?B?ZzVEYU9yVjdKUUc0MGJsVE1nRVNwTHJoT2ZMbk9yR1pXejhQSkU1OFc2cUtu?=
 =?utf-8?B?eG5aNU45czh6THNHMGJUZ0RmbTVJaDczWGtwTm0wRmJOc1ZocG1udWIzcDRR?=
 =?utf-8?B?R3QrNG00aXVTR3RSbHZYSkVlOWpDVi9BSnd3RTYvUWpIb2owMHhrOFpSOFkv?=
 =?utf-8?B?QVoyenFtT0xHSW04a25zanZPcGxOTW5SdjI1UEM2TGRnaEdaUHZENzgxREZD?=
 =?utf-8?B?R0N0YmNsTFNlbTJOcGhOcVJTai9vNTkvT1AwVXhOOVB0TUJ1aUxzLzlCVWpJ?=
 =?utf-8?B?MTVob3JNYkhieExYOElNMGFEaTE0ZTJ2TmlUUTEramtIN3hvdXZHMjc3USs5?=
 =?utf-8?B?R09GQktRaWd0UUlqaWtPQ2h3cys5ZHdnM21FSnJQbVNwQkZSZlZsZy9yTm9m?=
 =?utf-8?B?V2w3azZjc0RnNktJTy9Eb2tkekllblpPZDVocjRDQXdTMy92OXFRdWJpR3p0?=
 =?utf-8?B?M1d3eUFjQitqdnBoVjdDdHllSXFndXA1Q012TXV2RHk3UHlnc0tuR1g5Q2lv?=
 =?utf-8?B?WGJTaTJKUHViMkYyekhvZDZNenpDbDRTZ1ZxaHY2NnN4WlZycHAzZUVzelZY?=
 =?utf-8?B?QXNnZEY5a0NEV21uQkk5YzhMREFRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 572f3e07-8777-4e51-1038-08ddbb0489d0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 14:10:32.4927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5TAtFHQo78XKg+uIHB2pmix+lLe6pL1bESHjBtbJD8AqBsnJehZwf1hvbaU+uEypRaJKgXvu1erV5dLTnnv12SIwBctLHBC6tLaZ5vzi1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8045
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwNyBTYWx0ZWRfX2miH8GciFF5n
 Wlv8k+2s8JRQPlXxlPv1L/rcmWnWHLIUXnpzw1OxedIBg3rkWuP7Bj6hH2Zvh7aYikfWkfAx/n2
 3VPUPlC/yWRd8UVUcmiuGJxc3rlzlPQKLpRtWOcLzZkYNGlwnr4MA2J5uAmIFuLZyBZohuR32ih
 39qfYB0YiyIKi//ymr3O88qNcqOCBvi37UrqT/A+mvcptnvdSFvZPx+bdlenCv8nYd7dg2+tCxb
 z5BmApP7LaWppM4CT12L6LpGxFcLUxgmm/twh5llrh7f8bEmNJAeeEw1JPemJwwn1ZwnvZWvBTh
 XUHRkO9knRrxzhWXPycJFl0eN1xKC+QWkwwjj3Jvz0iKh8y18dInX+OGW5jqA/qggvLhaSEEPpW
 /ty5Grh9RRJIsOd9n5/qTX2lDkfNOTfV2iN/fCs7CZJaC1aV4hd+6Yq2V4rg7eq2m5vHowX7
X-Proofpoint-GUID: c4cO0IJln0iSfEt-9PIS1XbTdf7q0wKL
X-Proofpoint-ORIG-GUID: c4cO0IJln0iSfEt-9PIS1XbTdf7q0wKL
X-Authority-Analysis: v=2.4 cv=c+2rQQ9l c=1 sm=1 tr=0 ts=6867e0da cx=c_pps
 a=4yuKefASJ8Wsn776+NlVBg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=pDVciPHeplB8fhom_mUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218,
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

PCI code will never be used for an isapc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 105 ++++------------------------------------------
 1 file changed, 8 insertions(+), 97 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index fe53beb39b..5d59cbde09 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -418,19 +418,16 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
-    const char *pci_type = NULL;
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
-    Object *phb = NULL;
     ISABus *isa_bus;
     Object *piix4_pm = NULL;
     qemu_irq smi_irq;
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
-    MemoryRegion *pci_memory = NULL;
     MemoryRegion *rom_memory = system_memory;
     ram_addr_t lowmem;
     uint64_t hole64_size = 0;
@@ -517,39 +514,6 @@ static void pc_init_isa(MachineState *machine)
         kvmclock_create(pcmc->kvmclock_create_always);
     }
 
-    if (pcmc->pci_enabled) {
-        pci_memory = g_new(MemoryRegion, 1);
-        memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
-        rom_memory = pci_memory;
-
-        phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
-        object_property_add_child(OBJECT(machine), "i440fx", phb);
-        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
-                                 OBJECT(ram_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
-                                 OBJECT(pci_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
-                                 OBJECT(system_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
-                                 OBJECT(system_io), &error_fatal);
-        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
-                                 x86ms->below_4g_mem_size, &error_fatal);
-        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
-                                 x86ms->above_4g_mem_size, &error_fatal);
-        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
-                                &error_fatal);
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
-
-        pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
-        pci_bus_map_irqs(pcms->pcibus,
-                         xen_enabled() ? xen_pci_slot_get_pirq
-                                       : pc_pci_slot_get_pirq);
-
-        hole64_size = object_property_get_uint(phb,
-                                               PCI_HOST_PROP_PCI_HOLE64_SIZE,
-                                               &error_abort);
-    }
-
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
         pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
@@ -566,74 +530,21 @@ static void pc_init_isa(MachineState *machine)
 
     gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
 
-    if (pcmc->pci_enabled) {
-        PCIDevice *pci_dev;
-        DeviceState *dev;
-        size_t i;
-
-        pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
-        object_property_set_bool(OBJECT(pci_dev), "has-usb",
-                                 machine_usb(machine), &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-acpi",
-                                 x86_machine_is_acpi_enabled(x86ms),
-                                 &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
-                                 &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
-                                 &error_abort);
-        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
-        object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
-                                 x86_machine_is_smm_enabled(x86ms),
-                                 &error_abort);
-        dev = DEVICE(pci_dev);
-        for (i = 0; i < ISA_NUM_IRQS; i++) {
-            qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
-        }
-        pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
-
-        if (xen_enabled()) {
-            pci_device_set_intx_routing_notifier(
-                        pci_dev, piix_intx_routing_notifier_xen);
-
-            /*
-             * Xen supports additional interrupt routes from the PCI devices to
-             * the IOAPIC: the four pins of each PCI device on the bus are also
-             * connected to the IOAPIC directly.
-             * These additional routes can be discovered through ACPI.
-             */
-            pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
-                         XEN_IOAPIC_NUM_PIRQS);
-        }
-
-        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
-        x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
-                                                              "rtc"));
-        piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
-        dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
-        pci_ide_create_devs(PCI_DEVICE(dev));
-        pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
-        pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
-    } else {
-        isa_bus = isa_bus_new(NULL, system_memory, system_io,
-                              &error_abort);
-        isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+    isa_bus = isa_bus_new(NULL, system_memory, system_io,
+                            &error_abort);
+    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
 
-        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
-        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
-        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
+    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
+    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
 
-        i8257_dma_init(OBJECT(machine), isa_bus, 0);
-        pcms->hpet_enabled = false;
-    }
+    i8257_dma_init(OBJECT(machine), isa_bus, 0);
+    pcms->hpet_enabled = false;
 
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
     }
 
-    if (phb) {
-        ioapic_init_gsi(gsi_state, phb);
-    }
-
     if (tcg_enabled()) {
         x86_register_ferr_irq(x86ms->gsi[13]);
     }
-- 
2.43.0


