Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10B7CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kFS-0000WI-RT; Thu, 25 Sep 2025 07:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kEN-0006v0-RB; Thu, 25 Sep 2025 07:33:48 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kED-0008Rr-OB; Thu, 25 Sep 2025 07:33:47 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58P5PiUB2261425; Thu, 25 Sep 2025 04:33:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=TzB7KsAJvAi5fcDHNTZIDJX64ZbL/gOFAIbSh4qAV
 HU=; b=euEo3Uwwyb9kadHCdl79wg+xw1c8ii5muy8j9nZYnBBxMcBLTIjSAPEv8
 HTndNNJPDp8PXWSd8fXwZZZ6+1mR/qCoack2UxR+9T5gAfRZO0NYWCSTz0yXm3iM
 p8SkZ2GMr+G1dzX1rZN2/KL+k81mPVLIVO9r8I8G9oRU/0XWkvmikQkcRGs5J8T5
 g5y4TBWZLB4ZXB+BSgXMrG2iXRY4edL1528BmWBHwGneklC8w/+8FvpDDxvLjQRj
 SInOmP9xxIkeRzfoVfuiMj0Tm2Mh0E64pUyl62C7J71JqBJfnxfLP+P6gML8kbQP
 Kjs8qUANqqzdNfRxo7ZS76W5iQbrw==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023117.outbound.protection.outlook.com
 [40.93.196.117])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49cm7ra7ws-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:33:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eg0WUm6OoLT5Gb5mD6er03InE2CgKuAv5ySAsj2thcX2qM8XZkwgFyMINxSlsrotcx+hUZ2HjXBEIBlX8XggureCkhTnGhu9YeVkHPqYgn1S9P5sqvWd9ABWDNN12hkeJpA9DUVFxgvxZoHeC8rp88KnvvSQCheOTdvCLSneGOnUVzKx42Uyi6rGkZzAy7z/OvJ45pF8bfUqKRHivMvdgX859Jq5VMQOsyiRdaYhBs7ZHstwsUcre6zYU41ZDKjtzXrzUnuEvDiYCqtj6OOIfrUyTJbgRluWLaJn4F42bDKRUVJS7Wo8Bz7WqnLKaESCPI8HHmAQaDrN0MtyZYfuaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzB7KsAJvAi5fcDHNTZIDJX64ZbL/gOFAIbSh4qAVHU=;
 b=Lcdjy8wT0NqgCxyy1hXy429ImU1Xk16cZygz0YSZycOvT81YeSE/JDuT2gYNP7ksrbi7Kea/DNixkHvsSx5P9q+TGBB3IUjvC/0AwTTpX/Jijs9subiBF1k7cMn4YkwMUjjBK5uk8fc302PzdcqSdgchxwF0AtQsa4ERawGJoHoDArdn8Ahzx549/G4rlgMecNgLJDN7ims/Ck5u/sSRlGGBC0GnD2tv6VbsUZhMzRt85jXL3zMZzSQ7wDssvZH94ObDGXiDo3LiLrGv0QwnMizwDT/FIgEDOstVygYhqCQ0wXZDpLlQQ2IXi5wJRBa0Od5+Twh9bSHbNdTDXsKuDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzB7KsAJvAi5fcDHNTZIDJX64ZbL/gOFAIbSh4qAVHU=;
 b=k18UlRXi3r778DyMIXedW35gpksor91ovOn1mARuIuaAmRu/3LgmswisSKGbxAIbugzqssH6Ab0WHxtHlkTtdb3179aw3uSGF9kuJ/qyLsPv3y/cXANltqsv6Oxc9/92j4pdHKZTmbHUKIhvmFGKLV0sDyvmMwlg7MBpI4HMKPd31Jg/QFN+wivc8R1hRH6ouySI0QsPnnn6ufCc9cUGZ8qIeAlGvlmDeg5sCNrTQ/vdxOkHbjr0Ib2pM0No0qmqddDcYVMF+7psgzvlXLLhduhZabpeXTnYPk0Demn7Uza6PFy9+eDizOdRb14dTWa4Qv/aUwowsMIY+D3GdBI5WA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO1PR02MB8380.namprd02.prod.outlook.com (2603:10b6:303:153::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 11:33:22 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:33:22 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 23/28] vfio-user/pci.c: rename
 vfio_user_pci_dev_class_init() to vfio_user_pci_class_init()
Date: Thu, 25 Sep 2025 12:31:31 +0100
Message-ID: <20250925113159.1760317-24-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0464.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::20) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO1PR02MB8380:EE_
X-MS-Office365-Filtering-Correlation-Id: dee39835-94ef-462d-d2d1-08ddfc275494
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWExZmpxcnYxZEdZR3RZUFRZUEkvWkEyQWpLTFA0NGtIYm1wSDc2T1daT0Fr?=
 =?utf-8?B?TjkvTG8ycXdvaU13T0NhL1IwdlRFSEl0NjVLWDZtQVpGVlBVRWx0bXFMZGVS?=
 =?utf-8?B?bGxGMFh5SzlJTE1YaW4zdnprc21pZGRjYTgra3hHay9jWTQvRS9JOVRUME13?=
 =?utf-8?B?RWlTMFMwbDhxMFdxSlFtWkJVVEtZQzM2SzRNVFFOVTRlVU96UXFuM09QbUNx?=
 =?utf-8?B?N1QreWIyYmJzMldWSERmd2FWd0ptZU9hRTdnYUx0bUEyS2w5anRPU2lJUDBq?=
 =?utf-8?B?MElJZjlmVDlYbmFTcnJPVkFicDQveGxGMkEraWNYVnB1czQzZjh0Ky9IeUVh?=
 =?utf-8?B?VExFRWxEZHJnNkh0a2xWQlNqRGRUSmxlc2VGTW5oYzczYnRyRlhXbXZQMFdn?=
 =?utf-8?B?L24yaXExbmI3ZGJBcFB1aUUyVjVwK2F3Z0p6TGgwT0Z3TVRqTlVCVlFVc3do?=
 =?utf-8?B?Mm4wZm1iY0NiblhLT3ZhVlBSMk5oaWxMSjdSN3FWaGhlNlJPS2FaZVdzUTAw?=
 =?utf-8?B?dzNmaUh1STcyZnQ1Rkc3NjMyWnVUL3RwR1o0WnRXWFRMZnZITi9kRTlkS0lL?=
 =?utf-8?B?V3JIdUlhRmNlRlJJdHZSanR6YkZrU28xZDJBS2o4OGhqQnBqcjUvT3ZYTDdt?=
 =?utf-8?B?QUdRM2xDTGc4QVhrTWg5OCt6czF5Vzk5aysyU24wRGY1WG9xUCsxWmIvZy9m?=
 =?utf-8?B?ZGFQK3pGS0NRSlVGbWY0MkhBT2dydFZwMkphNm1mYXM2amF5L201dVdDOGsx?=
 =?utf-8?B?YVdRODdTRlFpZHpqaTFzQjY3OC90Smt5b0NyZTYvQUhQQTg2OHdWQUdTZkQx?=
 =?utf-8?B?aTcvOEhXRHBoeHJKNURlTExpbktxSS9ncm9FOEh2Q2c5QzdESjF6Q043U0hw?=
 =?utf-8?B?VmVSZUhIWXg2VU83RHQxN0dsQmRId1h6UVhZVW5yaDFqV1BDdHBjS0lYS0V6?=
 =?utf-8?B?R0pOMU1JRlNieGlWMTVOZFlTdHNzUVZCclBxU0pubHdoVXJtbFd2ZDZ4cUNu?=
 =?utf-8?B?Y0Nra0lZMlRoUDgvMHZBWU16KzNWejRtN2FoMW5lM2pmcDAzZVNRKzVsblI0?=
 =?utf-8?B?MlluRDZPanZETVlsaVZXSGs2VTB4TGd0YWRTZEJwUXhsN0FXb1Q5WWJSQUV3?=
 =?utf-8?B?elJjSUFWbGswMmZpd3VQUTRxTUo5MXBZVjJMZkJuV0FESVB5THJwZ2kxK0kz?=
 =?utf-8?B?N3RUY244TXFOdjZxek9VSkNWQUFKZ2lSeC9pL3ZrT0t5bGIwajNJYU5ZVCt6?=
 =?utf-8?B?Z1dGRmIyV3RsRjJ4cHVUeXNuL01WRnF2RFZJeDdIZzdHanJoM2lkVDdwajJa?=
 =?utf-8?B?R1hvZEFNK0RKSFRIRDdoNzhOZmtHQlZ1TnprK2JjTWpSVXdoNU9iWmJkaHVT?=
 =?utf-8?B?Y1lldnRmLzZKQzN0M3E5VVBSajFtakVQTUpTNnVJUFNaVURTRzNDYk5udHVR?=
 =?utf-8?B?RXhxMmFhWFFQQ0VsK0JKVGVoMENOVVpZbWZRak9ERE55Z2RMWVRxYkN1TURl?=
 =?utf-8?B?L0pwQVoxVzRsTWlMcUVPcFFIQU5MZjl0cHRxbXk0RXpyMGxKdFJyQlpaNlZz?=
 =?utf-8?B?S1R5TWpHWXNUMjZVT2Y5ODFPa2g4Zit6S0ExUklhcXlOTWF6Z0FnZTlNamM5?=
 =?utf-8?B?R2pKdE5xS3EvWEcyZGxxRFZ5WUZDOTBhRVBQUXFscGttbTlKSW5hMlU5WVJq?=
 =?utf-8?B?YXQrM3NIV3lQYk5MZ08vaVlLVUtqRWZNeTJtTVA0SlFMVHpvRzVpQUxPY1JZ?=
 =?utf-8?B?NFJ3cnpTblJ5N29sUVBpL1YyRGZTZ24yaS9MY0ZwS1d6em8wVFV2aERuK0E2?=
 =?utf-8?B?TXB4ZzJBSHVSQ0VIK05XdFdLZ0VwTmx4Q2R5QVByZ3p4aFZQNy9aTVdGZHZZ?=
 =?utf-8?B?aURzZVAzakJSS1NIankva0R3SnJxSUtITm5RZkxwSm12NnJWakJiN0I1bFMz?=
 =?utf-8?B?R1BNOEEwUzRLWW1tQk9jNTZjaHFwdlFkd2FZeFdFTk5oQjc2dkovbHhUWUJz?=
 =?utf-8?B?V1h3dFFocVh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjZxSU1tOWZqTTd2RGl2RUp2aklYWlRqZ3hmWlV5bXlKRHREQzQ3ZjRxT2Jy?=
 =?utf-8?B?aU9NV1d6bWpMdll4dWdocHNjZk0xYURpM1JjQS9VVU9VRnlQYzZKYVhvaFlP?=
 =?utf-8?B?MEhrOFNqVDN3K3QzRUxOVkFYenRTbGVyeWNBYlhtLzVGRGgvWWFtLzBxK3F2?=
 =?utf-8?B?eEh4b1d4Rm5iV3FaR1krcTdCTnhmSk42QVBpNXA5blh2emU0L2tJb3RhK0Ns?=
 =?utf-8?B?cTRRTmRDTUJaZ08xdit5b3NSOTlWRmNJTkZMZjdaaUZDbTErblNGV1pIRkRZ?=
 =?utf-8?B?eURmbzlkZXFGVmE1VFpNajhvWEtZeUJzNkMvYjlTQk5GWHZ3dkNubVliU3hU?=
 =?utf-8?B?eTNiUUdEMUdjdUtiSVFGd1JPVlRKK2ljRmNRSlloV3NibnVtR0lSdGcvY2Ft?=
 =?utf-8?B?ZklYSkN1akVIU1cvbzltT3Mzc0RqTUVLeHZQcHIxcE1CMm9Ld1lycHhTQ0xq?=
 =?utf-8?B?Y0lWNUpmdzRVUVVkL0V0V3JIRnI1R05GRmtqN0JoUlhKQ3IvN1pHdDdhblhD?=
 =?utf-8?B?YjBLclk5bW1kb25tdGw5dlRZZGN4TFVzUWRhN0czWWJaZXpvQmZ5Y3FYYVcr?=
 =?utf-8?B?cXg1bE5ycXRmc2locTRKY01VTzBnNGNmMy9sRU1DTGlscm95RjUxVHR2YnJQ?=
 =?utf-8?B?c2hJcEpzdHZOamIxbFo0aG9KU1IxOTFSNTM3aWhVS3F2WjQ3ZXFTYWovNFUv?=
 =?utf-8?B?SlpVcDgvUGFJa1ZjaFRRTW0wMVVhOFhxL0Z5ekN3SHF5eFAzakFrelJxL25D?=
 =?utf-8?B?dHY2clNsMWt3bFZnbEJtUHJwdWxPRGxFQzNNQkt6VDJ6ci9ITDhXMmVTN0Ri?=
 =?utf-8?B?TVlwUzNxaVRHbGFxa0dSN3R2RWZNMkhtL095cnh4WWM2QWd2TnpmMVZ5ZVp1?=
 =?utf-8?B?RFpkd09IWFoxcWlNMWdvd3gyaFd0d1pzeWR3RDJ1WWRobzJGQ2huNXROdEd3?=
 =?utf-8?B?dTd3T0pTbEF6QldMS2ZBaGdkT2ZNOHhQYTdKN2lNMFdaR1hmby9SRjNUUmZp?=
 =?utf-8?B?YjU0RXVMVHpnOHZoM2Ewb2JkUGttRnIzaE02TDZWYXllZ1U0ZHpHT0FEaHE5?=
 =?utf-8?B?MlUvQS95bXZjT2k5NzlpYXcrTXY5S3NScEl6c2k4NjA3UDVzS2NuWUhVdWJP?=
 =?utf-8?B?MTBFOU0rNEhrTW5RditzbDd4SlpSWDNIdUdON0wrZkhXQzFLa1U0NGsycXhH?=
 =?utf-8?B?aGU3Y3BmMW51SlphL29wUDZvbmcvSVhVcCtDbVdBYWgxUkdZWVR0Qlp5bTY5?=
 =?utf-8?B?Rmk0dHhOMnhENXRzWVJiSVlaZ2Y3QlB4N1RDejdVTGlIYlUwUnk1S1c0N0JE?=
 =?utf-8?B?OGdlZ2JSSlZ1WWNycW5KcWdLSlBYTWtMaUVoZlpRUnY5SUJRcXE3NUs3SE1l?=
 =?utf-8?B?ZVdVYUlvR0IwaUp0empCQmRsTG53S1d2Wkc4NVhiOWZMdXFVdVpXQ3hXOVMr?=
 =?utf-8?B?NG0xaVc3ZVJMd1NpR29DU1ExQUxDNFV1UFpJSWJEV1BZNU42UmZVbVFDN2Ev?=
 =?utf-8?B?NTMzU0hBOTJPcENPSkp0eHAxZVJLMmZ3L2ZyWkdETEd5aEJUaHF0RXczTkVt?=
 =?utf-8?B?dFZ1N0w3eDJ1eW85Z1l3NWQycUMrR3JrODhnS25tRzRuR3BZbnFTa3pRbThI?=
 =?utf-8?B?YWNFTVdrQTVMQzdPZHBldXVuaXJRb2dwcWY5bWpRRjJQUkdIbHQ2b28rQXhs?=
 =?utf-8?B?SXhXYW5WaUJtUWtweTdVMERSdHZiWDc2U0NEOTJqNXQ5ZGxQY3NLVlVROW02?=
 =?utf-8?B?WHI4NkIzOTUvZGRPbXEzMTNmdUh0OU5nR0h0aW9FOHZDemw3ZVRUc3FZUDNa?=
 =?utf-8?B?M0pueE94KzRhQnU4TVg5UWsvdXlvYTZkN0I2V0FvVnBCdWVTY0JzaDFUNHda?=
 =?utf-8?B?eGpOSm1SZFFSZXY0NnRpejNVVnBUTHF1S1kyaXIyTURqc1RGYm9xY0IvS0lV?=
 =?utf-8?B?NjNkb1A3SUQ0a3AwQjBpM3FEdmFVZk5yNlA2OTQ4TWlRaFdEdzVucHdPa2tx?=
 =?utf-8?B?YzRFTFYvUXpUTUNTdXpsS2xucXYzY29UODh5Q3ZkWGEzNHNOLy9WOFU3ZG9X?=
 =?utf-8?B?R01FZHFuanduMk5SUDZQV29ucFQ1bE5FWlV0TjhmbjBHZWtYdGpFRmwzKzJy?=
 =?utf-8?B?WEhIR2xQR1VGSysxai9GSDJneURIQjYvSXJUU3dRdG9PWTE3RHBCRW5oaDVX?=
 =?utf-8?B?OFhwZDRMNENKQlZUM1F3cDRvYmRTMEk2OGVJUVphNUlPc2FzN1VKOXVHbytQ?=
 =?utf-8?B?M1lybkZtTVJhL1Yza3QzR3RnWnJ3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee39835-94ef-462d-d2d1-08ddfc275494
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:33:22.1355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acbt55vjKJ+TnI+P6E/08kMC3RdhUYHvNTgTkHoCS2YddpC0CYNsCtO3lDHsCJtvP/qW3nE6m/MSMtac7AXGivu4sUl/qtgQLRYKpHYXdaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8380
X-Authority-Analysis: v=2.4 cv=NeXm13D4 c=1 sm=1 tr=0 ts=68d52883 cx=c_pps
 a=CzkyNOvCWoDxGiQpYFD5uw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=udP_5BOVWkZL6ct6w7QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -U_loFI0hdnbW2e5mibB7rr6YOXjbPeF
X-Proofpoint-ORIG-GUID: -U_loFI0hdnbW2e5mibB7rr6YOXjbPeF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfX0cdODAylk2d6
 SNjYGX9/AVJIeBaRUGUGsnxCXQNfynUEi1pa2Q+y6g5PWrO3JYond2JMsVhDXe1gdWh9BMtif4v
 AQ9BLWr/zPlHK6Xvo28lA+NeS+YZtzOazfabeUDe4FbDGbzYla0CGGSKqggTnItE85MeYd9fNM8
 hmw8aAwSOdDiRIbaBVU1Qxcm4rrhu3UfKihCA62SgSRlvj3vXr5VnIU5Q3GTx8vP8YWIj7ydNhm
 dUWEYMG80vQNIuXiRFtlSVNM0rUjG2PaTSoT7nmcZkbXEeiLzbLUm3SQv5VuZzCfzoJcOD5n86q
 jHpw8Hx5TqWKmc/68+23uFvDORZRucWYdud/G3qke3dCRe7Nrqhed0WhVMDl5g=
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

This changes the function prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index efceae69de..e2c5b5744c 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -446,7 +446,7 @@ static void vfio_user_pci_set_socket(Object *obj, Visitor *v, const char *name,
     }
 }
 
-static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
+static void vfio_user_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
@@ -467,7 +467,7 @@ static const TypeInfo vfio_user_pci_dev_info = {
     .name = TYPE_VFIO_USER_PCI,
     .parent = TYPE_VFIO_PCI_DEVICE,
     .instance_size = sizeof(VFIOUserPCIDevice),
-    .class_init = vfio_user_pci_dev_class_init,
+    .class_init = vfio_user_pci_class_init,
     .instance_init = vfio_user_instance_init,
     .instance_finalize = vfio_user_instance_finalize,
 };
-- 
2.43.0


