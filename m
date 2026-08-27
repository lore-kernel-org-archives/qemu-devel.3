Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631BEC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzbBQ-0007r2-1G; Thu, 27 Aug 2026 10:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBO-0007q9-HC
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:22 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBM-0001yd-R7
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:22 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RE8P9x4182826
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=QTmBdCFTn3nVDqLc0SK4cSXuc3zkYaa4jUcb5d1H1
 fE=; b=Ks8EwUZn7luwALxWq55lD2uvWHZ7M4Ox8UAhzC4UxvRU+LcYkYLgpgjba
 BlXhlRT3O789i0ytWPV3Sw9ppkxXpLSe6qVAIRK3hKiSWdn30aHML5IqZeJBouAp
 0rrEr8K8wjR00DbXxa3mhgTDS2PbdLFksUGzf7zypW4kuYw4r1bcAz+Z60TVRwbi
 Be9Bpduqt0VDFVcWJY/QBi89YurJaN1DNtwNWK2LTCJYPiM1CaHJu5CTtGRBU2iR
 2yEw7eDJDE78S0+wk7HtI6QLyaWjuh7o4D7eU9f3nrZF9hK8dxZKU5bW9olEqe3+
 I92A6bY6R4d71+1NTT8nYmG+8ABRA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022132.outbound.protection.outlook.com [52.101.43.132])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gafss128t-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vq8nXYs6btBDxZSymDkmWY6pTeU/fNtSCZMZvMPAggHmVt4XchGguHYNuky7ckk1v2Aocyg0mTt3OpSuQnvEl5jRy1oX+5Xiw3VYTPzQkhNBOLE86ckR99ZM89XWqUKvDmgzO1UESWmredO7ZD2oYYDGkBJcef0MEK1cfghCiUuFGop+5+68NC7Z6FuDsRy/swc44ZqSZsc+DJiPvXewPXe2c1dMShdJlaTZQc4ZrPNlHBO/LC7NzPRxYDtvENUWOHjDZ0xQiqJJVRQoPn74KY9sGIwD39nseYUUiiLHVXOotICvwb5FXZ65cryP2lttyXndg0PqqXPQUXbyGi/JmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTmBdCFTn3nVDqLc0SK4cSXuc3zkYaa4jUcb5d1H1fE=;
 b=wCjFdSrEnnnwwbhx42Apibgq0z9a5ljtQ18aBwybTkgEnDi3jKprwd+9MFzUhGY+b5zUXUpjHD44vf5rkcBn7mlEITkxp0qj9rtvhxAh2deh/Cb9yVnb+sXj+muS5e7epWBHbpTHY+HUR7CJwPjZnF8T+L/EiAq1ncpF0tqRMB/4AcTL1/ul4eGyGxhWXuY1esI5zIxp1Nkxn9+U/4/oP/Kw40Z0kM+Dvz+ttxiolV7guwKLZ0kRR/H8mI/UI7kPERSCU6K62h6cf0OsYUIJGuCg/fs28xvKiCJQEtY5MqRz1XCUJ94Mc/PdfIHZLXzGr7lp6hgTn8t7naYtpALmFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTmBdCFTn3nVDqLc0SK4cSXuc3zkYaa4jUcb5d1H1fE=;
 b=oYjT+w5JwjrpRh+3OsL4pGxAGkhqwtyAEss2FT2sN3BACX+dnbg0r1B13cEAVxqftAz5KmoYR00WaG1UEJKZzqa0KsPKucPRdXXlmZXAm0zkohrq8m3ZXhwkd56DlfIVXudv1d8I1jP1qzV6OWLvjxGSwEtXZpgXP5BC/SaQ2MdLsEscQdY9iOwfEuIZihvJQb3IMPIA6eNUGLZk9dBULGtJhAuQ+LXbK3w4NTVx4EM+6dKJ2E1JpvTkNfx6h1blQryBIMxmWmbC9c43Je7l8CosVYcaacOz2cFUfIxeJCNUif7Pi45UXruZHEkd51x4Hwli7upqdhww4ZudvGCCTQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL3PR02MB8114.namprd02.prod.outlook.com (2603:10b6:208:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:34:16 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:34:16 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/16] qom/object.c: introduce
 DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS() macro
Date: Thu, 27 Aug 2026 15:33:24 +0100
Message-ID: <20260827143404.1393166-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
References: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:806:21::27) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL3PR02MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 7982119c-5a74-41a9-4e18-08df04484590
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4uQzgLjwd/vx7X8WnEN28Ag16zaLsTWn9TnLXhfgtd/E0bhxxwbsq5jVc9lKGAdscsWhMfj5DiRokZTFmaDONCWV9K4nJbeW5C5jJABDUjELo4lk3yp4m0FQnOr7QtK1d8hpdBEV/eLqFHXvONbyjw5yjUbgT+4FtdVw+qSuREQNBwiBOHsfM6yPy4VJgDvK2FnmPHAknW6ItudBJCJoO46HSp97RttGoaw97G9YbfSLxWlBMltD/JTlMiDFuu2uSe+ew9edUTBtOAZxtv6za05ntkxhUzHEUnpBlTfgcMZTfIHkxktljKYlElxCxUoUSFA7LVILTmSgPYwqojGzJCIK3xodtQp1J/dq07KS4T+rGHkfORIgHcLtYWthNojO9jLjia0fcw97XTx/xHkWraLTNttznTQqq8CASP4os/8wb9iqPucVfKVr5f+1fdtTy2SVf6VZ2X+VY3N66cS+Hgpto0BO4c4wD+qbB443g/lMEjQIs4ytJiZbxB9Q0Ei0yX/VEisFv7ZR5RCaxhhfwTVbvt1kcQs081tuqk/UmChTDTdvfW0VFwX/ktOvp/4XE8iDBDVEN3yUqf6EP6H4CXGlq/t8+Pu9iWeHqY2/M88xi0Y1rNNBcfbvSYSv9wL9eI/X3X4lXZONGTUr1WiUrEeoOQHDBxHLfLHIn6G+xpk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkhvS1d2eFArUG1tYk43Yys2OWV6bVVmbDYrdHBFTGN3VGVYQ3BnanFSbTgv?=
 =?utf-8?B?NXRTMVhoajk5YjI3ZWdVdjhZcDk2RmVIKy90bnpBbUxIaERNREQxVTNrY2VP?=
 =?utf-8?B?bm5DMWdvSEpiZ3dQUFY1Sk9haFBrczlSY0dJc1pxVnUrV0NsU2h2L0ltT0o3?=
 =?utf-8?B?UE91QUtpSEY3ZlBzYXRzOFkxZVZ0VElTUUx0WnRrNWVvYUNyaW1zT1hWbytY?=
 =?utf-8?B?NlhXYmRabG5OU3ZOTUJQOWF6M2FHcktCV3pGaHlTVEF2NlNvVTJWcUQvb054?=
 =?utf-8?B?RjZteUtscStNYXVWdkF4QlJWN2YramdnVXdiWjNSd0pCMHU0eW44cEZ4UStE?=
 =?utf-8?B?T2hvT2MvbWphSXB5TTJSNy8vUnZ5b1R4ZFpyWi9QaDJrSk5kQjNtdG5yVmF1?=
 =?utf-8?B?UUg1aUJITnVxWG1iVlIwcGtBQzdiTXlHeHJDOVJIcWtoYlYwcUhPb0o1WXk3?=
 =?utf-8?B?YkxCRFJid2UzYitQMW5FeWF0SHRNZVgxaVRSQjNjTStBd1crV0x6NWVCTkxs?=
 =?utf-8?B?aDFxb2FkSVJvbjBxN245SWhIZVZyOGhqamVpRHE3RnpqQitxbFlJM1IrNUN6?=
 =?utf-8?B?TXBmM0dRVzVQS0xpNUc5SUFESW1VTVNVeEx3bDNOb1dJNGZhSmR3UzlWc0NW?=
 =?utf-8?B?LzlrZy9hYlM1NUF1SWd2dnYvV0NDNHBpRGRqdTNoN0RHK09lTFpUK1lsSkRl?=
 =?utf-8?B?bGpYNjBSdCtGdE5NWXhLbUhVVnRRQU5RQ2NRbW1iSDhFYk9EZk1YT2ZOM2t0?=
 =?utf-8?B?eS9pZ04vbnJuQUV6Zm5Bb21EdzZlYTRUeXVrcnMvQVF4ejF2eFpYTm1kYXFD?=
 =?utf-8?B?YXVVRGk4MW82RTF6b0pSbFpHQzllMFNhcllkUklMc2tFUkdYUDAvNG4rQXlj?=
 =?utf-8?B?aTZ1aHhlK1dzTlQyM2lrM2pzOGhxTXE2RS9nUG1vekxiaE1hSmcrZCsvU3ky?=
 =?utf-8?B?VGpFK3VycVRsVmdsbERtYXdVZXJRZjU2ZGVwR2EwWjc3QzdVeFR0TFZwMVpP?=
 =?utf-8?B?dlhJVVhqenJrcE9xWU10cDlySHU3WEFweHlUKzhTQ2JPYU1HSEJuLzlOemdk?=
 =?utf-8?B?d2o1Y1ZEd29sakU4aUFCaDJtSGlGR0RTV2U0a2hmMEkvVSt3UU5MOFZkN29v?=
 =?utf-8?B?TUZ2UE9GaEdERElQL2o5TldDeWo2WUVodkcyQklTU05VUURLd3JYQk1rc3g3?=
 =?utf-8?B?YlUzN0lTNDV5UktocTNzaE1IQjdQUzl2U0s4YlVnbjZrRnU5Mi9PdnZjck9z?=
 =?utf-8?B?MWZBUFF1dERUTnpzb3ZlQmVSS2paTFAzWEE3WUlxQzFkWWt6cGNGRkdUZ01s?=
 =?utf-8?B?eEY1d0dVYTI3ME5vQzYxRXRLaGh3R2pxeS9IQit5RUlFZEI5VGx6SE5zeCtX?=
 =?utf-8?B?VU9vRzR2MFZyL29lQmFZOWt3d3RFaWJRV0ZUaEdnWUxsVWZsSUNKazNYYXhm?=
 =?utf-8?B?MTFuVTJzL3hUdVZTZlhwbWNscmdJQ0w0UWJGU09jREVLaG83YXhDcFY4cDhm?=
 =?utf-8?B?d3NPc05GUFlMOXhNYm84Nno2RkZ1OEpHbE9ZYXNlcTVMenRmOHRwMkswY3Bs?=
 =?utf-8?B?MWtaVkpjbWt1TEZxaFgrNHNrUlRpcWNFSjhlN05UVktUMHRrbFcyWHBaZFJm?=
 =?utf-8?B?RlIrbGZKNkEyZ1BtVUxKTVkyWWNnY204LzlZT2pXeUgrMkoxSUt3dWtjemhL?=
 =?utf-8?B?dG5ienV3Nng3dkhPT3NNdCtmR2lLek1hNHRRUHF6STFkMzdEd1lCWFJHRWlI?=
 =?utf-8?B?OVBWWlN6NTVBejlBVDM4MGtuWmVKUlRPNlE2UjFtUlJHY09SL2ZvcGRYcVpY?=
 =?utf-8?B?ZlJDczgvRHZ4a2VMTVdyZUdidk1abUprK2NWbFdlc3VBVFJadzZxWFZDZnNL?=
 =?utf-8?B?T1JUZjZ3MVA4TjBoOW5BNi8xTlRoZkJWL0JMZlNSTVF4R0ZJcWRWY1RKaGQ2?=
 =?utf-8?B?cnErZUZXdWx2UFFFUnlqVnFHNHFPczhoVE1CS3ZhL2RaRHRYL3ZwQ2pZM3ZT?=
 =?utf-8?B?N21hRnZlcnRrWnpsZFpGQkxzMTFWNXRGMzhwMnFxU0Zad1NpR2EyRnhhek9J?=
 =?utf-8?B?UXpZOHRXTGlTeWx4RE15K3JadUxwYXN3cVNUNEJYVjN2TkxaYk02YzlwVGUv?=
 =?utf-8?B?WnZ4ZCtVQ0ZPVmZxY0ZVbkJMWjlITTN3b1RNbWZLVlI0V3M2NTBRMmkwTURB?=
 =?utf-8?B?YjhMc05kUmk1eFR3WUx5WlM4dzVjb2xqZ2haRkJqak83Y2kyZTJEVGVGWUhR?=
 =?utf-8?B?TjM3NnR1YVRjY1FNSHRnZ0MvM1lwemhUeVRmNlZXZXVpMHhIemo2MDdQdnlS?=
 =?utf-8?B?N2dMNGNsNWF6SE9yZWxLbk1MbUk0dWFlYmtFWFRrc2FaMWVNU2tabHh0bTBS?=
 =?utf-8?Q?fzJWABbxE6v6StVQ=3D?=
X-Exchange-RoutingPolicyChecked: UYesG5hQbyL/7DvQUcaII703IeR1mqP4CA8M+mgItHpsp0vPdvD+p2jNID7I7+fiPSPSpJ+M6ZeAF65eSjWuvY46YMLj5KtNGE8ewrXhLEg/xCH2WNEZauwEm+mTAxwzdaPU5PjAFSxDFVBbwc1ugtoycov4Hd0yRzkruB+QjPmfwr6VwCO41/UtdrdHvzMzLMW3AMr2CvOwNm1hhFJBzmAeK/pRH6qjAi8YrpqqSo7VxGIUScmrUdDbsN5w+u9GvOt3ZrRa8A9GPuX7clIOdhNBZUYb0LfHXx3AcuSDqA+3XiNNLuujnE65ZOJ0jj94HeAJf25MdQvijQtgrPu7Ew==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7982119c-5a74-41a9-4e18-08df04484590
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:34:16.2869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFjqs/pGJClRPGCcenxDAu0SlBaxNNR1g2BNIpBrIkPA3VNSMWfDCmLy1rVFtHVZdWqng7g8mYLCmU6fjatFCROvbACOaelwnySiEe06FOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8114
X-Authority-Analysis: v=2.4 cv=YOWvDxGx c=1 sm=1 tr=0 ts=6a904aeb cx=c_pps
 a=T6DPE/DVwP9kL+SBve89ug==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=UWV-rqafSl4XcmA-RNwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0n0E6XEdJZqpje6r9EOHtsZbRoT51gXi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX3AbYwexQo958
 YSA5NUEqUURWca/kolKCv6ANfgv/w9ET2G5yonIFVLUfFFbeeu68VVuT/ASGfEL0PtTmWRtQqNW
 UDXw0AsId2sMn6BxHISxZsxvZEtElNg=
X-Proofpoint-ORIG-GUID: 0n0E6XEdJZqpje6r9EOHtsZbRoT51gXi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX4a3/yb7LqmRs
 989nZmkYnwPbC6EAZkh5GM/QbeulEorF6aDjHhm8biixzmnCv1rwxgDEVN+/kAvCumvpuLWwg4L
 TIKIs4S2bKspIElGXuAF/upwotHzPX9YuUvVhmT2pFNjM12+rUuhcOG2WAU40QmXCx2KTcjgZQj
 kv5ffmbRiMJktUBXBo2MNiK5SwzWi1DyvKmdKEo+KG2ucKIF6h67c6L/oD7fu81xPiCIb4b9425
 bYTPLbZRtBV+riwDxR5C5GSpzMC2iTm7/dBMBUB6cYmIufoRp+zq02ey65dViedEgCYEVZU/c0K
 K4qqtVqS8xyd/cfoOjXYWeWUktL/5s1Zi1gc2bGB+1rnY0WlPfuUJq2QcSnHg983a+FS5jDcJ+g
 kCj/DyivO294WwUSbLtL6EnoSAtf8GL9TFHNCV6mTVD55iAoQ2T8uog4cB7dxkCjiPIYQsp8JTs
 A8XMPW/aEisfb5EeFkw==
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

This macro defines both the QOM get and set functions for the given scaler
type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20260825134320.1039012-4-mark.caveayland@nutanix.com>
---
 qom/object.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index fe4e552928..9cb2cae4a7 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2738,8 +2738,13 @@ static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
         *field = value; \
     }
 
+#define DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(type) \
+    OBJECT_CLASS_PROPERTY_SCALAR_GETTER(type) \
+    OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type)
+
 #undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
 #undef OBJECT_CLASS_PROPERTY_SCALAR_SETTER
+#undef DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS
 
 
 ObjectProperty *
-- 
2.43.0


