Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3646FCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uraXx-0000CG-Ji; Thu, 28 Aug 2025 07:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXv-00009f-0b
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:59 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXs-0005Uw-Ut
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:58 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57S77Yji2726376; Thu, 28 Aug 2025 04:11:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=QHcAeR+EpXqVB9y8TieDU+ngh8CXRMNMEc7Met7IU
 Yg=; b=DD64/y9aCnvl18BcnL3dgbuDA7WjaxXHz1r/+EOkrwXB12GqRZyxQKQmU
 VXgqchmn9VPbKIm5ZplKOeP0simVuNfwMo5fZJ7Mt38OEqFdABuCn6b6GcbvGx+X
 mNm6FU4Xt4TFvzammlCb177f28IpsiyFUExJEW5YRqd/XFE8YfGpTR31yy0Mw8Ri
 V+xWqRSQJ9rq6fUBnX1a2Y4UdyM0M+25YP8I43cmiYU0yCXAadvaCD0OK/tv6J9l
 tDBpi19U3LtJpIj3DxXqNMcDm/OmisugdCwOtPxIho/9k7GN40oqaEup0bDMIGf7
 jNXpTKepy3gVu+ALrrQxcEicPnkiA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022082.outbound.protection.outlook.com [52.101.43.82])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48t6kjswgq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 04:11:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBJ090qN8rPzNql8pOT/lb6bu7NlfbGiqLTq8Dpa6zfMHybfxA+o/2RfdWuOzbjU1GBXCMj9/6WiY0JKPPz/nPWibMnd2YQjLawDE2kEat1BljC+LmQOsTLKTIDF+Th/ufHdnvpyh/2XQzuEzOBQnEUBoOPtd8ViPMuppylra/WVrXyAN64EX+IpoC/rlgxXlzNnpycI5SCtjw8H4YnmZRazYmVfixCE681ulxAPQTyN4bR/nseH4Btmndy4zCh+lWnBZZwyYtVs4F0wDmv/WuDf2Uatah96MqgO9trjvg03sDNVhs9pXNZxBufJ++nYelOfIPYZBjgEoso6LDqe0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHcAeR+EpXqVB9y8TieDU+ngh8CXRMNMEc7Met7IUYg=;
 b=r+G3e6oh6KHyCqzzHDQAMPhSekbx1C+xkeHxI+CitWtc/ZUcDN+Bd66FpA05bntcRlKKGxLVp18kkwrNu3Hes7Y/xbKBcpMHF2qTfQE95rqad9YKXb5z/7gnc6TCFmy4Y3sm5Sotr4imH0nPCEHG6K84sAPoVIfvI16ckvOh7YRlUiW0MUl7RaMXCJhyi2rmFge5stw30blSlSjdrMf6dVeuQCiMZMb5mZQ7388Jyh0Mkv/Ia2f8dLKwKCI8WotFCXF4ojIWO/o6dOBO/QF0cGadg0AOdR57RXucFdMJ3XrQjDdkGurYgoKwRIjyv0t8965cfaa7tE/7ZXT4Y0MmBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHcAeR+EpXqVB9y8TieDU+ngh8CXRMNMEc7Met7IUYg=;
 b=K9FGOHQMMJxfd2Z2l8MauloWyxU0ZFbV7iJwL27DGzFUiXFDLETDg6tX9ypGBzfI3x/Sc4U2N4JrdlIFV0fHWVS9gxHGO40CxAOJRnW3T+OZogByYwYlS1CLaim/AYLL+oyzQwMIj7qB0zti1vDyvCE+ZgQQj4pJpAktvaI3Vi357M1uHSH0odLU7Qyoay+6wriJBqIY2mzCco7NtTZ1W9stUt6BfVEYcjWlyW5NiYqxV2Wg8dgYBIDCCfnIv+CSUNE+OvrVhojiVZ/eDJzko5//xOrf6Vv9kzKt9u1pMWkzdusCIk4yjYPvgLqIKpq+wHZ8QtueATiOG74yxCkErg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8077.namprd02.prod.outlook.com (2603:10b6:408:149::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.23; Thu, 28 Aug
 2025 11:11:49 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 11:11:49 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v7 15/19] hw/i386/pc_piix.c: assume pcmc->pci_enabled is
 always true in pc_init1()
Date: Thu, 28 Aug 2025 12:09:58 +0100
Message-ID: <20250828111057.468712-16-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828111057.468712-1-mark.caveayland@nutanix.com>
References: <20250828111057.468712-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0207.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: bb47a90d-6b00-48d6-e382-08dde623af3e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDZSRXRTeU5CbkRoL21RV0ZtUXgyQzdRbTRpaXgxUStXUkNPYmJrZW15aEYy?=
 =?utf-8?B?VTRybFJPeWZ4R0VyVzBNZ0lrQSsyZ2tTTEg5cFZDd2tybGZ3M2dtTFJZem1O?=
 =?utf-8?B?eVpvQnpxWTBmZVZSdHU1ajlhcUNMRlgrUmxkKzBJU0lqSWlTa05aN3RGM3Ns?=
 =?utf-8?B?RlgxV3lzVEtwUFBHSXRXalVYU3RLS2VyMGZvRnZLOEg3SElxMVhXeHdrUXYw?=
 =?utf-8?B?cHZFQTN3RXVVM0FzRUlsOUlIdjYwUEg3TStPMnlNN0luN1BXdHdQYmZia2JE?=
 =?utf-8?B?V2s3NHA5c1lxK2NyRHBIRGY3Q29ldTZaeGdZbEJMOGNMNXhkTlpBZ0U3Ny81?=
 =?utf-8?B?VFdzTFUrczNPRmhuT1pObEJpRklSM0R6eWFVWUJJdlo0QVZiaTN4aUhaY2dY?=
 =?utf-8?B?b0xoWS9kNlo5SVZxbEU2dW8wVTd0Vm00T1BJT3UrcUZwcWJNdXNPRllmeVd3?=
 =?utf-8?B?aUFBVUFrdDFHMnlNREJMRkV1dEppQll5bDBXVXlTdHlJS0p6VVZhMklxLzM5?=
 =?utf-8?B?NGNUb0lTOHdReWsvNVVON3lrdkFLUXc5SVkzcUVtVTVFK1gvQ0hjR0tmb05n?=
 =?utf-8?B?VGNlbW5NZXA2VVB2SndVYk1vTVR4S2VDK3NBV1R0MGN5d2ZHcWR3U1B3aXVo?=
 =?utf-8?B?VzRsTDd0ZHZYUGt1UkRQN1hEbjdHbWd3anJiUUN6M2VwVlIrcit6cHl4ejg1?=
 =?utf-8?B?S3h3NlR0RTBVME1Qb1NXbm5La2ZrL0U2b3IrQXdrdmZkWTNxaFBoUG9zaEhz?=
 =?utf-8?B?bzJLY3RWNUo4Z01rN2htcDh5cTY2RGVibVROVEl1NytwZDRUR25Od2k3a0tZ?=
 =?utf-8?B?SUg2NWkybVU0V2tzRnpzRFV1c1V4aFJLbkF0WEdONVY1OVN1Zi9wTWtOSmpN?=
 =?utf-8?B?U2sxb3ZmZU5vU1NIQlBQcDVISWhvRHhqOE5jZytZZXgvN3NLa3FOUFd2VGVG?=
 =?utf-8?B?T3cwTVVaRWRkbjJxMFdta0N4TUc5ZkxxQ3dxcVQvdmhrbDdCcUYwNVJ2R2tU?=
 =?utf-8?B?ODNuWnRLVHJQanNBckJCd1V0RW1MS1dTWHh1SFpiVS9jZUliMC9hMDFlRXlh?=
 =?utf-8?B?dm1OV2t5SWM4Qml6YzRRZTVTZk1tcTJvbUVvUXovY2ZvNnFoa1E2ZmxKVTRy?=
 =?utf-8?B?SXNydjlQUUFwanR2Z3YwT0dsQ0N0QTRnQjVYcGN2NU5XMG9MZXR0RElXS3ND?=
 =?utf-8?B?QisvOEhRaVJMTk1SWkVPYmlFRWdXVlk1Y04vYVprU0RuUnFHVjdwUmgrWHVR?=
 =?utf-8?B?WExmWk9ZYnNlQmVoMHhpSjcxcmxZZXA1WE9pYmVmMVUxbzBId0NSYlh3VnYz?=
 =?utf-8?B?SlFSWG5wby9SbjdqZTBDM1Z3QVBjRi9jeVFESkhWYnVUb29VUTNTRjNSUnhT?=
 =?utf-8?B?K0dTRStXUDRCVzBneXpZcVZ1di96N29RM1VINUlCU3V1bmFyNGhTeGdhNVBU?=
 =?utf-8?B?N2tNYnNRZk5pSlFYUGJoVi9wUVo5MjF4Z0lDK0gyRDF3MzFkR25rUk1ZSkpj?=
 =?utf-8?B?WHF6ZGpZNHBUNjFzN2NLMjJFYzdhVkM0RnFGYVRUcStXYmt0cUxBOUNwQy9B?=
 =?utf-8?B?ZzY2ZjNoOUViRGQycnFGWjRqSnVXS29hRXoreUxYbU9mRGdQKzQ4UW8xWmpl?=
 =?utf-8?B?bEN2b1BoOW9YQnlLRlJlT01HQXdpTVdoYUlDVXR2Z2h1L1haMm4vY0huWmNV?=
 =?utf-8?B?cldwaXYyaHRPTDFZVWNPOTduMVNSV1dVem9IeW9NWjZGeEtMdkN6Vk84RVRZ?=
 =?utf-8?B?bzVlTllSYU5oL3VFK0RvSnpudlJsdWZKbXFkOVk1VkRHdG0xc21RZ1hTOXRv?=
 =?utf-8?B?T212cVk2U01WV2tLdUdjcjJrWkYyOXp1Um5aT0prMkp2ZnR4NncybEdiZXBp?=
 =?utf-8?B?bldaRTFzRFJiNzFlRUQyN1lOTEJUeTQ0NDVhN0M0aWRvN2RBdG9vWjVyRHJr?=
 =?utf-8?Q?8q6Ozgz4L3I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0hOTjNxVmZtRkdxcGFJSXFkaDJINXpZbEEvdjJ2TzVBWmFoNjRld1dkZTVk?=
 =?utf-8?B?bTByYWhJUjBBODJnejJaVjZBU28wUlZCcmZhZTM2TW5VWmxiRDdwc3FPVll3?=
 =?utf-8?B?b2gyYnZuVXJSVHNPVGFKYVpJRHA4Y1pLbFMyOUY0Tkd1Rm9TRDJaSWNhakFH?=
 =?utf-8?B?dTJvZE1IekFWa2dzUkl2ZHdLRUlmZmwrbEF0UGNsaTA2andSdkUybEx3M1Bk?=
 =?utf-8?B?T2JTV3IrWEJDK2kyZjhaSStFMXZkb3MwRkZKbFhiSnlwRVJBb0JEZ1JXTFFV?=
 =?utf-8?B?RGdodmJIR0NuSEwyV0Y1Z2VmbjMyS2hOM0xRQ25lNmQwTkpkR2dZYncyeVpV?=
 =?utf-8?B?YnZua0lNZTE1N256YzFOMHR0R3J0eHp2L0xJUFQ4Qm1leDlQdklZTWFZRDdn?=
 =?utf-8?B?SXAzSDJVUHpGL3ZCVFhNTW94SVBOTWZveXZrT1JSTEhlNHhybHJ2eTBJOWtx?=
 =?utf-8?B?QkNaSWVTYklwRS8zajRMdWYwNmVNMThxbExTNldUSHVicXlINzRQakFoa1Qw?=
 =?utf-8?B?K0wzWXhVUVRxNTVvelhsSGYyci92Q2ZiMDA2V3ZWeGcvcmZFeTF3ZytKWkRl?=
 =?utf-8?B?MExhZ1kycE4wVnVHT3V3L1lZcW1RWWFNUjhKS0Jaei9KeCtUY21ka0pQRUU3?=
 =?utf-8?B?YmhvclFFVHpqTFB0dWRoYWZxUWxnYlBKMlE2Z0hTZDhSME5CM1lZTGhQTkk1?=
 =?utf-8?B?bmN4VTN6eWFLZm1xU08vUHlQcm5vMG54Ry82MmJHenVHL0pzQVNXS1hzeUQ0?=
 =?utf-8?B?YzBTa3RWV2czSUVHM1Z1WThiS3lzUUh0NDk4aGxCZjJpVndwQmRUOVI0NEsx?=
 =?utf-8?B?S0thS0VjQ3VXY0dxcTJFTFI2S2g5aFVpR0hNYkpFc1dzNkZtcW1tai9NZndG?=
 =?utf-8?B?Y2ErV3BXa2d0K002SURoOUdkb25JTm5zdVBuUWlvc2JyeVFSdGpsZ0o5dmlI?=
 =?utf-8?B?bkNyeEpBZHR3ZjR3NFB3V09heHFFNkYwc28xb3MwU242ZmZjMFBsdENKMCsv?=
 =?utf-8?B?WDlNOHp1OFJINGx4WUZoZ1JhdHNnV0tlRkxOaGE2NnRpVlVRd2xYRzRGZGdl?=
 =?utf-8?B?SmFFTnlJMFhNbkxWZWl2bEcwclJnZFFqWXBVSVZXcFFKWXFsQlM1a3dxeGRV?=
 =?utf-8?B?RTJpN1pUNjZwQ3pzV0lSeTBvbjNHa0s3aXpBVEd1eGppWWc5YnIyNHgrenNC?=
 =?utf-8?B?dGV3czRXUlNaWmVqeVY2Y1VIQkhtQWFpN0ZDSldwTnRlcXlId2tkT2J2ZFl3?=
 =?utf-8?B?L2ROQnlQV1FyM045S0tQNlhWejRLM3hKdGpURnlFMzk2a2p0TFh6RDVMVXl4?=
 =?utf-8?B?aTYwZ2piaFhHYklTWXRMbGE0OVF1VGZLbm1XTnR1MS80clVXVnM3OG80djdL?=
 =?utf-8?B?T1p4WkFmek5obDVETlI1WGVJWnVCNlNwTnpVekc5b1NqQ1FUTG5ZUTV1Z0g0?=
 =?utf-8?B?aG4vUmZRb1dHdmFLMHFxWUxHQUVhOHNtanZOSGtrSTRaZUppcVBQTlBLOG9u?=
 =?utf-8?B?UTFNNTVaTmdid2ZjUmpLcVRyeEtNK09HSWZONGZxQlpXYnpqTUprZWJYTzQw?=
 =?utf-8?B?aHNkcjRzc0xtMGE5WWRLOWNQOHo3REtqZGFnaDZaV3pudktyaWM2MVlEcnQ2?=
 =?utf-8?B?em1KV1ZVS0ZXU09pVUJZaEp3UTlLc1hMdDZlWnF3dDNsc2dMZUhDenUrcjZO?=
 =?utf-8?B?VkFEMDg2U0E4Y0MyU2lDMGFvRGs2Z0h4NlJHMS9ReEg4bk50TEg2UGxKK3Q2?=
 =?utf-8?B?cFQzN0czR2dTWmhuV2lsVEpUdm9xdjdvOTBDb3VEYWlPeFZKRkVzVTAzZVJu?=
 =?utf-8?B?VTlKc1ZBT2VMYVBFR3J4bERNdThQRjNud2pnUVFjRERVZm5hZFFxWk0zcjVB?=
 =?utf-8?B?UXRJd3JJTTNSZUROTFVXbVpUdjBralFRSUpIRGpzTUsrbUFnekpQSjA0UzBY?=
 =?utf-8?B?NG1qWXQzWTQvMkNLQVE5L3ZNY3NnSmhQc2t5ZjhVOXF2U2YyV25rajdaZld3?=
 =?utf-8?B?ZThKVDlHZE5QdU1rSE5TL3d1TmpXeTU0S3Vlamo3aWp2VlFUcyt5NERoM3Rx?=
 =?utf-8?B?WXZQcjZlYUxjOStmc2JWU3dGRG5qNWFPUEtLbnlNK1p5ODRlOVdLcHJEc2No?=
 =?utf-8?B?ejkzTlZSZ01uVUdwMGdSUVV1Uy9RNG1mbXVGckRWMlk5a1ZMeU5zdlAvNFJR?=
 =?utf-8?B?YUdXNmhRaG94TSthaG82Z2VBSWU1VHJGcmZDU25vZDF1bTNPWDliMXhGalVO?=
 =?utf-8?B?eHF5SmR0U3M0eitOMTNuUUNmSGRBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb47a90d-6b00-48d6-e382-08dde623af3e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:11:49.5654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QhSbBXONV4jRWTLhJxYmFKHg8YhS82A5Q6rqw3ck0XSAaOldhZbVkmAfmy1kXRcYV/UMkD+bt0yF+GpkILeVhtSyn1M8HFhnHKNoDfISug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8077
X-Proofpoint-GUID: bsTvExJTwySrb2iz_1Znvd1x-Rq_OC74
X-Authority-Analysis: v=2.4 cv=c+WrQQ9l c=1 sm=1 tr=0 ts=68b0397b cx=c_pps
 a=MPeZxNXPLKxVoTdC8D++DA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=siTUgUNpisOazrLkBMQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: bsTvExJTwySrb2iz_1Znvd1x-Rq_OC74
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5MyBTYWx0ZWRfX3S+P0SvevhOK
 yRRwRhCQugEjXdGFi1iL++IqG0VjNd0AB83pAkGiAL5xzcoeK4HNvuU7Y/p26QrzOV9LWtsnPBB
 LggYNjIJXF+YNP5NrugMb7x8LLag1A5ahctz3UMudvpCdDN++rzXYQAISVp7bZ5M2M4u4wJmdLZ
 Zyy8eiCo/Dw2vx9RQnBrxF5t34q/cKRiiY+bJsUGg+7bNry4DJswuu147WdPU7a+Qot9QBzdPMf
 1zXzOocQ2CLI8ESwitGmR6G6i3LSronB2fVpf+Zm5+jyGbdbBcnzhtMTERTU4keZpGVtDiIzY6V
 cBqOe5/ZuC2sQJ6YasQQunlP1crZrA3TP5exrH+xalW05BTp2vKvaDO/7jPHRw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

PCI is always enabled on the pc-i440fx machine so hardcode the relevant logic
in pc_init1(). Add an assert() to ensure that this is always the case at
runtime as already done in pc_q35_init().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/i386/pc_piix.c | 194 ++++++++++++++++++----------------------------
 1 file changed, 77 insertions(+), 117 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 72ddd9b149..3ea77b2c44 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -125,6 +125,11 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     MemoryRegion *rom_memory = system_memory;
     ram_addr_t lowmem;
     uint64_t hole64_size = 0;
+    PCIDevice *pci_dev;
+    DeviceState *dev;
+    size_t i;
+
+    assert(pcmc->pci_enabled);
 
     /*
      * Calculate ram split, for memory below and above 4G.  It's a bit
@@ -195,38 +200,36 @@ static void pc_init1(MachineState *machine, const char *pci_type)
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
+    pci_memory = g_new(MemoryRegion, 1);
+    memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
+    rom_memory = pci_memory;
+
+    phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
+    object_property_add_child(OBJECT(machine), "i440fx", phb);
+    object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
+                             OBJECT(ram_memory), &error_fatal);
+    object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
+                             OBJECT(pci_memory), &error_fatal);
+    object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
+                             OBJECT(system_memory), &error_fatal);
+    object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
+                             OBJECT(system_io), &error_fatal);
+    object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
+                             x86ms->below_4g_mem_size, &error_fatal);
+    object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
+                             x86ms->above_4g_mem_size, &error_fatal);
+    object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
+                            &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
+
+    pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
+    pci_bus_map_irqs(pcms->pcibus,
+                     xen_enabled() ? xen_pci_slot_get_pirq
+                                   : pc_pci_slot_get_pirq);
+
+    hole64_size = object_property_get_uint(phb,
+                                           PCI_HOST_PROP_PCI_HOLE64_SIZE,
+                                           &error_abort);
 
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
@@ -242,72 +245,51 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         }
     }
 
-    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
-
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
+    gsi_state = pc_gsi_create(&x86ms->gsi, true);
+
+    pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
+    object_property_set_bool(OBJECT(pci_dev), "has-usb",
+                             machine_usb(machine), &error_abort);
+    object_property_set_bool(OBJECT(pci_dev), "has-acpi",
+                             x86_machine_is_acpi_enabled(x86ms),
+                             &error_abort);
+    object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
+                             &error_abort);
+    object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
+                             &error_abort);
+    qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
+    object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
+                             x86_machine_is_smm_enabled(x86ms),
+                             &error_abort);
+    dev = DEVICE(pci_dev);
+    for (i = 0; i < ISA_NUM_IRQS; i++) {
+        qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
+    }
+    pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
 
-        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
-        x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
-                                                              "rtc"));
-        piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
-        dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
-        pci_ide_create_devs(PCI_DEVICE(dev));
-        pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
-        pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
-    } else {
-        uint32_t irq;
+    if (xen_enabled()) {
+        pci_device_set_intx_routing_notifier(
+                    pci_dev, piix_intx_routing_notifier_xen);
 
-        isa_bus = isa_bus_new(NULL, system_memory, system_io,
-                              &error_abort);
-        isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+        /*
+         * Xen supports additional interrupt routes from the PCI devices to
+         * the IOAPIC: the four pins of each PCI device on the bus are also
+         * connected to the IOAPIC directly.
+         * These additional routes can be discovered through ACPI.
+         */
+        pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
+                     XEN_IOAPIC_NUM_PIRQS);
+    }
 
-        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
-        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
-        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
-        irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
-                                       &error_fatal);
-        isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
+    isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
+    x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
+                                                          "rtc"));
+    piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
+    dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
+    pci_ide_create_devs(PCI_DEVICE(dev));
+    pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
+    pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
 
-        i8257_dma_init(OBJECT(machine), isa_bus, 0);
-        pcms->hpet_enabled = false;
-    }
 
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
@@ -321,7 +303,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         x86_register_ferr_irq(x86ms->gsi[13]);
     }
 
-    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
+    pc_vga_init(isa_bus, pcms->pcibus);
 
     /* init basic PC hardware */
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
@@ -329,28 +311,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
 
     pc_nic_init(pcmc, isa_bus, pcms->pcibus);
 
-#ifdef CONFIG_IDE_ISA
-    if (!pcmc->pci_enabled) {
-        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-        int i;
-
-        ide_drive_get(hd, ARRAY_SIZE(hd));
-        for (i = 0; i < MAX_IDE_BUS; i++) {
-            ISADevice *dev;
-            char busname[] = "ide.0";
-            dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
-                               ide_irq[i],
-                               hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
-            /*
-             * The ide bus name is ide.0 for the first bus and ide.1 for the
-             * second one.
-             */
-            busname[4] = '0' + i;
-            pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
-        }
-    }
-#endif
-
     if (piix4_pm) {
         smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
 
-- 
2.43.0


