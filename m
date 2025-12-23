Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518E3E6B25C
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 05:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXutN-0007Xm-Id; Tue, 23 Dec 2025 00:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vXutM-0007Wy-0n
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 00:25:04 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vXutJ-0003Nl-ST
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 00:25:03 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BN4VGPQ1608336; Mon, 22 Dec 2025 21:24:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=hVpicXb6CEbjG
 BDKSyiRtMl/06Sz1o4obO5wrJy/4/k=; b=GBdSNqVLyd8WSkgy8lpHJfk8F7TZO
 NVSfVJlmwLrUrim2qWBg7UO4rnSISdMoSXcxNDWM+vlXGQG/TtwCFGzrFhjiRS+M
 QSY7AjWYcKE5KCAN+wQjjCP7X04r1CNkFnSyiMga74GTDIr/CBVC21lRkOjKv08r
 HKtuQYPFHQ2N5nwKaxAS1KO6OcAx8W88f9GErQmvOzDAFeYBOtZ1HbOgfPB6IGKK
 yULJOfCehMYGCkGkmozBR2Nsw5KqeJNv90qiL4I+JhhhiKkgcpT68ZilPHxmAMSz
 PJz/dVWK5MXCA/3AI1UUwByTpOSqc/i+HkOKECMQp9nOMxhoq+AMUg3pw==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022110.outbound.protection.outlook.com [52.101.43.110])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4b5v7yvw60-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 22 Dec 2025 21:24:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2MrlPrL3HmUEH7OCTzJsNGVdCNr8khm8ChAhyB3r3Jr/7QxofCBGllTydAthA8ccxgVGVAwwqQi+SsC+nZmdeKRUb+GZ2OQOZH63Sh90NC7rernhPpuSaPnE0IBvu0FdC50sdxjh4szsFrE+CBbIf0Z3hzbvx36aocqxIf6kCJuUz43Wvb/30vfZGa381zHYmoC4lMk++8OrS7s8ACBSN3t/GtH0ZAm0ltVm7zXSfadV4Nq60LGNg7V90fr8dw3soMClZNkkamjBwymH5BY7/E48RxPSvFaWRNhGvKFMur7BC393BLA6v8n1j+Q/t8ZrJ51hrGSdrSjdszuyW9paQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVpicXb6CEbjGBDKSyiRtMl/06Sz1o4obO5wrJy/4/k=;
 b=CZg4lM0BspczYNvzGmb9MPQnsuHnffoLXeA+OnP/Lv2BY6MspnIpin34miBOp6xG9hoh31n7If8JWaIljVK7+Sc08OyNgxUveEF1scoHTpwAw2tEx7C5zGsvh5yoJaUD+uBALn0dnShxx6RBYy1QPbPC2eFNCs0P7nWUTBT7B0tmYAUHjBCQ0nWZwbuWGGx5qeGJLJdcN490aOkrvemxcKpJP/JGMcYynqeQ0onRVcT+PC4DwajQ5UXhsInmkG577uSIZGjJkp+Ee24OwWk1KabYCbAYISfA0OxY5HQwFa/7pMm6o+XeganVdXXpnEsLFCGuwLSXdFrNBTyOBThkOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVpicXb6CEbjGBDKSyiRtMl/06Sz1o4obO5wrJy/4/k=;
 b=FyLArEb/6JnEqRa2JTnbVzRDUCtiv79r/D63IazL0lmEfvFuxA+ae6oDRIBE1VHG4BYGcaciUwHCNKBIzTT9FN2ATnIVUWgYWMGoRG0vOvGeDk5v9fjmZlKnQRNvSe3jSkevReCfOfsLrTyHFJ97kwkl+pC6K4coW5XSV/UcD+ZNIlEy0Oklvx6EaNz43eiW8XICfpiC5AC0mVm6B3HRYeU8CGeErCvNTNz4Ui6AsrIwG5SFNTKsMkSVLJPwcfcCRTGqN6owO2bk3nN2Y7MrDoXos6T/+APL13SE0ArLVx0x+qOp0nVcxMWfi/j9+XPzcRcHmkNaVHXhJTTa/xAGaA==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by BN0PR02MB7952.namprd02.prod.outlook.com
 (2603:10b6:408:16b::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 05:24:52 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 05:24:52 +0000
From: Jon Kohler <jon@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-devel@nongnu.org
Cc: Jon Kohler <jon@nutanix.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Aditya Desai <aditya.desai@nutanix.com>
Subject: [PATCH] target/i386: Add VMX_SECONDARY_EXEC_MODE_BASED_EPT_EXEC
Date: Mon, 22 Dec 2025 23:08:34 -0700
Message-ID: <20251223060834.1618428-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR21CA0006.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::18) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|BN0PR02MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: c8b94d09-edeb-46e4-f243-08de41e39957
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oFXgUftUPD0XrEgFGZycHLXkd275HyMf4D/vseU6Xwyho16ZI+CVIWkCMmGJ?=
 =?us-ascii?Q?gn1wT4ii1qsTSSmCD1pGNEohOVWl53BFTUpTRxb/WdioUaRVEG8wRMC6CXls?=
 =?us-ascii?Q?k1KWSbtGucXFmv4ywik8RlcFO21dWVwcYDff2YYs+Bfn6s0rdBDnKU8NFZIg?=
 =?us-ascii?Q?RcKu4Pm8IpcdjHsefC4Ydg4N+2nlPw7FRm9WCwiRvu7kYPY2CZGsxigz3UYa?=
 =?us-ascii?Q?ggJbi1wZXERU5GjD53kvPoqJIO2FJpzqUsWE6VxM2kkAAUoV7UcPV7BzOZ3A?=
 =?us-ascii?Q?N7X2GXTIdhOsuJ71RYOLZlOm1gwL3GXX9VuLP7emZ2BcgEU66GLnSmNfiMqF?=
 =?us-ascii?Q?smMETKU6nd8UU3Vya93+Nk4OddJJ80d6XgDHWkoZhdERnSHP7xC/sVdAty50?=
 =?us-ascii?Q?dszvFew6PnZfkaDvkVs8bi8BuKtVCS+vqWmPC3j45S7iMjCBW60LS16sTQ2S?=
 =?us-ascii?Q?JQcJChu3LSw5w/6MwFyaRo/bXaLUniakWgNQ9hoSoAEug90O60BJ9E9Lo7Zf?=
 =?us-ascii?Q?aSpHOk/gaKPvQDrUuC2W5jMKLiEu2u6xsOu291gj+uJku5weJnp5d1DGBzYC?=
 =?us-ascii?Q?mwhBXY4ilwD4eFqZroKuVLqAHTpYqerLriXsahFTCh1UOvGDFDS1QsVI39ka?=
 =?us-ascii?Q?G3vCdOYywY1WGBlqB3Q4TIb1d/Cx0vjRDZPIueVcSPrN/gPotbPUZh3vqPn5?=
 =?us-ascii?Q?WVzCatT4x3FlCGqTGaSNJc8urSwyTn5MGfsYkzwFatGFo69yGcGB/Iy8EB0T?=
 =?us-ascii?Q?7Y0av7hL8MfjF6Zf/EDcQOH+jVDyzDUp84m1tsKcqaQ3XWoit9bmEyKY0LMt?=
 =?us-ascii?Q?OEKl63ZtKhAoqoSBFZm7kVmawt1ymRF8M2AHgOte2Oqx/pivLu3EgXxsR1G9?=
 =?us-ascii?Q?bOgGDSZusdyBtRf4hCzWGudMR/O2A8MLa9Idy0LliLxe9vOcks11Tpp9VqRI?=
 =?us-ascii?Q?+o9E7hW2FO/2e9ACTwlWbUlVaGvPGthu3NLV3A5PgBcSuAkBnkrNpS0s8z/r?=
 =?us-ascii?Q?QNhwuPRZn8oi5VDdEchDhOlAXMDSbOzu+PTqWkhoMnBw7els/19rEOiRkXEh?=
 =?us-ascii?Q?B7C8APybnrCCpQVUZF8fzGf6j5avEBeztzWrQdpDfYtaUeXYVSvd1FeexjgY?=
 =?us-ascii?Q?oKg8jl3WMK9nDtGZF/V5Vzu2FwMb7mLeIRApQaPU1kPE10jiVXKrzKIkLuqh?=
 =?us-ascii?Q?DXUrAprCrrphkydGWHIQo2WUXaeRgkKBOfAylCUo9+owlfwb/E3wrmW4mwIe?=
 =?us-ascii?Q?LSSvFy0oJppn+XNEOTS8EMHzmaiJ+AKbTXSSwR+g0AZjlXwY96pe9m4trrUR?=
 =?us-ascii?Q?E/clBsIcQgyVkz4M6Mssac5Fx+cRfObbbiK3CD8Vq3tdJI8gLdAfPhVgYqFL?=
 =?us-ascii?Q?ln76/AQTfUJ23EaKmpWGxbDV+oPF3o72wXz6mcCWHhu8WyCIGH9I5TMezyNC?=
 =?us-ascii?Q?w1tIigDjmwcV63nTztVM6sLQztkGdwETPXEpkkvytzm/zRcn4W/vYdlUTQSZ?=
 =?us-ascii?Q?87zS2uKk/WmXHcU9ihPpI4U89cv9x0vts3kBIE89WoZCp2UaZ5lUDUQ2Rg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV0PR02MB11133.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TfSvGGsLV2vhhD3AfVdAKAVpcw6aqcG6P7uxzUwnkOlisNELlM02lecoINMI?=
 =?us-ascii?Q?RyAXvTAEp+xW5P4tfGv+0gUOjHHlUAjpZm8U58x13xfcOJEqmcUtr34RZkjf?=
 =?us-ascii?Q?YM2O7HzGcSnKlF1OMC0H1R/qPGCJ6yVAAKklGvqTr/wKbn4XCGOpdLFzInvl?=
 =?us-ascii?Q?KTucrBDyhNgoSbfLXmNB3F06MIIttqwKGjhRsKk6Xkbx6JcEdupW+y2ZZK+t?=
 =?us-ascii?Q?mT97c2xxNWz4gBR2o4IVeILUiMjWiGWPWeInsHDQRyOZ+bZnF+uygydd9cx1?=
 =?us-ascii?Q?iAkRHWW0VEE7zl7PtOGh5VsK080aiqXAZL1u9SSCket1vnSaJRE+1RWdXiAO?=
 =?us-ascii?Q?Is8G2WOHU6HpT09wEHQqGcvz4zbqkHYQQp9GD4vEfddDusFClismzNJicLRc?=
 =?us-ascii?Q?1xLFVHMbw0Zl3wvTNvh/uyE1TQIiZTpVzyTEtgdrNuFwt0/0uDCC1TXC3Q+6?=
 =?us-ascii?Q?s7W4gOemE4sUbcU8cEqmwn7Wgmv+19kU6dtrZ4Okbe+JfzHhC+uuozARLcpP?=
 =?us-ascii?Q?gnpTe177VL9yqnjjjXAyEWibCghVzTA+vwuYvzQlmTXm7uPcmTA/dcKRSq/2?=
 =?us-ascii?Q?n8Iuax3ipAFliFtSZmevDCUh4QGE61SB30AsT5W3i1Z4fEeu2JxZu4tlL9rY?=
 =?us-ascii?Q?NToP0b185JxgYGKQvctfHx5WAUmJqWAHuOZkDU4W3o9IXgc7lt5EMfcB26/J?=
 =?us-ascii?Q?PMM18PXj+XgDA3lz118mbiDhViUdUR0Wcjp56HtHRLKgcGMkzsLWShLHgyZ2?=
 =?us-ascii?Q?FUPSOVavmolxSLePVuESCocYwbVbzNPPyjSbjwaFgYAxdPd85QRx/phwB02E?=
 =?us-ascii?Q?siIIpI05FmDE3G/MVa2HPCc5TRxsLOqzXQT8bVGSBfyx9RUbXzlPUi80nT2a?=
 =?us-ascii?Q?XSME81osBR2Irh/Jb3czCaGO5pReFM981Durf5XFjaVSriLCksFA7pEWiSCb?=
 =?us-ascii?Q?Do+yzYhNE/0Jni+ET907GGhUtO0SMmuPqrMTr1ymDaCIRbAP/+ncMax5tYMH?=
 =?us-ascii?Q?HjqCAMZ3gk4ERZREOaBGC+2rYdKX+uH6mU/5OeMx6v32ThwUvFiVXyPW7yxO?=
 =?us-ascii?Q?KUBMJj0rcEhIuQhNWkA2x+guNwZZ+rLiWnO9/bQrN2DE6ZsaTmQPr0EzfHdg?=
 =?us-ascii?Q?HoFlpRVchHfpc4Rr43mgU4AT1Xt2eYVZ8qyhJtQ2+7T4oyldUvCLl6Octqls?=
 =?us-ascii?Q?YyCo5zudOYCC/Vbnzy35JIl52RwPAAALWJq9bZh0e0NVlL6evrPYXzQvcVfG?=
 =?us-ascii?Q?264m/58c3458PCGgIbI6QU4zHBCyXCpWw+jF4U9l7oosfLTuexRiWFGUD4Pc?=
 =?us-ascii?Q?vUHFB4YOdek6nUQK3M7/C0pn9yyQANlK/+fSPSZQ+JTyTumVZzBfvW/xDSRc?=
 =?us-ascii?Q?yiDoDB4PXNPf24aaTPHwRu6wjhS64u4FzoAtYX4lC/dxRfPm9IRZ5yIAiXq8?=
 =?us-ascii?Q?plmQCXStbYRcJqt6RuSNM/vSg63ptF/OfcU7VDUf9pUuFpuUp0MrnLhSlKnv?=
 =?us-ascii?Q?94BMNFZOUMJkU+f11SxNZo6VtqYWox9G53M/PPGtfoix/qz24WpGvC1rj3h6?=
 =?us-ascii?Q?Gi2nJnzgAeNwsLuSnDr5CLhGYXME+VZnMt9aWULP3x+9whTNpsk4Z9AD+mED?=
 =?us-ascii?Q?xjBW2A4IArmSf5xcCSj54kUDHZLEGgDyC+4RYNrecqWh1ie+3H152AQwQ83S?=
 =?us-ascii?Q?VHfeDn+53A/LaokymlzSPilVumiRESjofxdGQxxb95nF1g5NZkymrXu3WCIZ?=
 =?us-ascii?Q?aZZg6zBbkIg2X0dxzNlUpufwWIoKyVM=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b94d09-edeb-46e4-f243-08de41e39957
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 05:24:52.0480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAdoWxN4RkrSPcKA126n5i1jD6cY+EYebYgonWk+Baer8KPTTi/yWEZK5QLyCUqw1G+8Sa8jjXJb+gOWm96YNm0/xQmzjEb1l0IUzNV3zeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7952
X-Proofpoint-ORIG-GUID: AzUlGfIg9kJNWvvMXM5tF_fCi_CWrJDL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDA0MyBTYWx0ZWRfX3HDtunOUHzEM
 vDXjt+GhZicfKDGSfgzrQPj7ZI56fbYyDEr4Dq9o7TYdGeilGZXoqBLlkp7P4DqhpVs+UnbhFRU
 WaYMfzk5UOcT7RW6WK8RJrISlAIwziILhy2Ep4U8VxaPPEFZGyXrWCS91YaQprdbsOPtHfxyC9/
 JX37akNDJQRkG7w6nI4WcN6vRlznhPTNCdx5pAMuqD7/S+AKvzSv0kYr9+Ve9DRjCVm7xFvFuhh
 1Qnn5g/eKG2G88EmaDwfH0RqyxO3A637O5llqBiFFECO9ETRP//WgfhYin4HgAEse/4Lc7v6H5o
 fz9LRAM7KqzR2PTNKmNT4qQCGr7GHUbHsjEaKYMkpfGi1qPZVjRzA0/2zqv0QosKcjWTh9Lk2Vx
 k3/V7ZKvBR0KCBWDB/OQnAF4rjOnmoe8UXkC5oXpsSHuou+PPhV345t6qvWlwta2p5p8Iuu8Wwy
 opAkzNJn8YkZkQzbhBQ==
X-Authority-Analysis: v=2.4 cv=S8TUAYsP c=1 sm=1 tr=0 ts=694a27a8 cx=c_pps
 a=R5lJJwLUw69E8voCr07FQA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=64Cc0HZtAAAA:8 a=QyXUC8HyAAAA:8 a=n6sb3K27hoFZTVlov-gA:9
X-Proofpoint-GUID: AzUlGfIg9kJNWvvMXM5tF_fCi_CWrJDL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_01,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=jon@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_TRY_3LD=1.997 autolearn=no autolearn_force=no
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

Enumerate ability to enable Intel Mode-Based Execute Control (MBEC)
on secondary execution control bit 22.

Intel MBEC is a hardware feature, introduced in the Kabylake
generation, that allows for more granular control over execution
permissions. MBEC enables the separation and tracking of execution
permissions for supervisor (kernel) and user-mode code. It is used as
an accelerator for Microsoft's Memory Integrity [1] (also known as
hypervisor-protected code integrity or HVCI).

[1] https://learn.microsoft.com/en-us/windows/security/hardware-security/enable-virtualization-based-protection-of-code-integrity

Code is mirrored here:
https://github.com/JonKohler/linux/tree/mbec-v1-6.18
https://github.com/JonKohler/kvm-unit-tests/tree/mbec-v1

LKML thread(s) are here:
Original RFC: https://lore.kernel.org/all/20250313203702.575156-1-jon@nutanix.com/
V1 code: https://lore.kernel.org/all/20251223054806.1611168-1-jon@nutanix.com/
KVM unit test changes: https://lore.kernel.org/all/20251223054850.1611618-1-jon@nutanix.com/

Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Co-authored-by: Jon Kohler <jon@nutanix.com>
Co-authored-by: Aditya Desai <aditya.desai@nutanix.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 target/i386/cpu.c | 6 +++++-
 target/i386/cpu.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6417775786..cc81880f28 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1623,7 +1623,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "vmx-apicv-register", "vmx-apicv-vid", "vmx-ple", "vmx-rdrand-exit",
             "vmx-invpcid-exit", "vmx-vmfunc", "vmx-shadow-vmcs", "vmx-encls-exit",
             "vmx-rdseed-exit", "vmx-pml", NULL, NULL,
-            "vmx-xsaves", NULL, NULL, NULL,
+            "vmx-xsaves", NULL, "vmx-mbec", NULL,
             NULL, "vmx-tsc-scaling", "vmx-enable-user-wait-pause", NULL,
             NULL, NULL, NULL, NULL,
         },
@@ -1938,6 +1938,10 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_EPT },
         .to = { FEAT_VMX_SECONDARY_CTLS,    VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST },
     },
+    {
+        .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_EPT },
+        .to = { FEAT_VMX_SECONDARY_CTLS,    VMX_SECONDARY_EXEC_MODE_BASED_EPT_EXEC },
+    },
     {
         .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_VPID },
         .to = { FEAT_VMX_EPT_VPID_CAPS,     0xffffffffull << 32 },
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cee1f692a1..0869e03208 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1330,6 +1330,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define VMX_SECONDARY_EXEC_RDSEED_EXITING           0x00010000
 #define VMX_SECONDARY_EXEC_ENABLE_PML               0x00020000
 #define VMX_SECONDARY_EXEC_XSAVES                   0x00100000
+#define VMX_SECONDARY_EXEC_MODE_BASED_EPT_EXEC      0x00400000
 #define VMX_SECONDARY_EXEC_TSC_SCALING              0x02000000
 #define VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE   0x04000000
 
-- 
2.43.0


