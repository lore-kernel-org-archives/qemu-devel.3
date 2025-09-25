Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04281CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kFq-00010M-8M; Thu, 25 Sep 2025 07:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kEi-00076M-CN; Thu, 25 Sep 2025 07:34:11 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kEY-0008Un-Df; Thu, 25 Sep 2025 07:34:06 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58PAtG8r1851329; Thu, 25 Sep 2025 04:33:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=TnjGSVciuYITkGx5n70UiVTwUziIr4H9NTQIf8KBt
 84=; b=yJhSjLIAa8WytjA3+3qlLQ9zbXhtrj8BIWb0OLAh9zMChcOJpjNp2u6IC
 hVOPCuQ+kesfJGmGxGuTf8jghi9tNmQHOHtUPVyDly1fkwZQKuS+Oeu5fTK74NRr
 rPxxIGnxrLcFnGu5TOLXcBP5vOr+t4jy/P/PQ8yqUuKnffm8eEakBwedfx/SrfEy
 zO+HpZYI8X2Etp5rTN4dPGtWVPzC09hU/eTqC6l87ApzciWbVioMHCVUkgg13e9b
 l8h0fQmWkoq2QPcIpZpyHmmpf4+j4pUEj85Qsba37n6KkYt2tcm0PgkbtFMRoRWi
 ZyrKi5HCwc86QdLOkMvfn0k1pQhaA==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023099.outbound.protection.outlook.com
 [40.93.196.99])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49cgsjavg3-4
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCqUMKoTPBLmJuG0reirwfLNawXc7Ig8WURcx7Ra04arAB9Xnvy/mnXcfxTZ/y8vxCTabh8tFVgxyqVzosyRaNeYOOYEInbdMunVn7Gw/CWvJtCHivOYBDz1g7e1fRprI8NI86QcL+67a1bjQaLcvls5o05M68OMWtVk8MtuD2vUUce5XLNyDey1ptahNQHrfjWtnqZPrm9L8gfGDcfVv4W96iy/0wmE/QA9wfzA/wviCHQbw2tkznO6oCXQnRT2BG3Lr9/sBxRq94WW4qg2eObWiKM2KdbdKOh0ErFqIoJ3SIAmb3m6krXIjRTlRBz9E9R2NSscHbVm7C6iFKYHzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnjGSVciuYITkGx5n70UiVTwUziIr4H9NTQIf8KBt84=;
 b=DGRZX3opUG4n5jE1MK7uHZajFapZeUhR2/aXmSS7t5tt6EwgOi5poSAANKApUXeW/N6hapjtetOps99/qQJD77TTx58xxqt/XP3THK1Fu/oII40q9B1q03tuaIyLWKG7mQJOBb5/PlyQm6vLp8/OsAmP7K5aObb+mjmUlNVO6yEPn4GsmPbrOyQ3aqyG3LwL2H0Wx7+S9fvs2WLBRf1Xpm3pjgSuWnhx5Dn2SldJQLXUc3etE9fW6kWc369VZJKpRGiIrR7XXvhpPyNcWrWwqy0HmVRWEofDgKNZpBvA810f+QekDgoS2l8w5geAEO7S8eTt3m8FR8FR3W+BrwkQYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnjGSVciuYITkGx5n70UiVTwUziIr4H9NTQIf8KBt84=;
 b=Kjhezeuu/bZjGQifJ8MDXd0mbHo4YSy0t2rTgqGE4NdON532SXoz8a3q0BvW0mBwT9Q56NTV473h/OPxPBeT8CIPl74LJ2GH/vRNtG2APcXhhDXoBme6Pu690RzWyYlrTGpejOHmdnxy53EHB9083/JyzbACZRYsdzcdO/cLQfHtsDBvbJNoNPJCMdU6eJNp8hKvMz9rZkXfddCCYjmowysFs8jQQDnzwUwKxJ3Rp6j0kKU0EYWuU+y15PTDLextl7u69ZcSXfmFaKMdmYJXeS6o/k22j5IvRrbIaKqVx7dleSsqtLQynkDXKDtK+49sGUDOY2FBY9ojzyigRIvSNg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO1PR02MB8380.namprd02.prod.outlook.com (2603:10b6:303:153::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 11:33:41 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:33:41 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 27/28] vfio-user/pci.c: rename vfio_user_pci_dev_info to
 vfio_user_pci_info
Date: Thu, 25 Sep 2025 12:31:35 +0100
Message-ID: <20250925113159.1760317-28-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO1PR02MB8380:EE_
X-MS-Office365-Filtering-Correlation-Id: 3713bced-9818-43b6-fe56-08ddfc275fe7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFl4bFVDOVV0akVQemNINkFseEJTb1JaWTJVeWg4SmE3amdSRmNhMmhHZm1i?=
 =?utf-8?B?WUs2ZkpJM0ljZHVqMlk4MGZsbVF6T2M0YkJVUkFPblJTd2hNRGI3aG5JTEpD?=
 =?utf-8?B?Vk04ZlVEcWFRWGkrMHZwTytqazEweXpKZXI0blhXQVNOMjgyR1BWeTZWbVZI?=
 =?utf-8?B?T0UvaHNrellwK0ZMOFh2VkZ2ai9LMGlseU5GTjdXemZHOFlKSlpIRDcya0VN?=
 =?utf-8?B?ZUgvYXBPR3ZzdXVwZkJLSHJwMWJsRTBScmZQZ0p1RnlzTk1LcHgvc1MvbzU1?=
 =?utf-8?B?VEJkSk03ODMvTGdvNjhmU3lMdFlQZHRwV3dQUlduT2pobHhYYVJSVUFRZlJF?=
 =?utf-8?B?ZUsrVkdLN1BYMlJua3lhVzVzWHNvNWJ4REE4eVgzTjFCcWhZVGpQY0hrTjlD?=
 =?utf-8?B?dkJsMmh3d0cyQjJxayttWkJ2Q1UrT1FRMDhwZEdNbHFpWkZ6UHM0cXg2Vm14?=
 =?utf-8?B?akh6NEduYnRHd09WbStXRnA3V1lnaUd2Y3BLNFZZY1A5Y09DaDJ1VWZGM004?=
 =?utf-8?B?ZUUxU2pDQU1FKzlXcXFDcDVSZ2NKcjJnMTR2aUZLUHBJL21wVkxqYVJHMXJL?=
 =?utf-8?B?QllwcnB0anZQb2ptZHJ0YjZVS09FUGtwWldhbHpxT2czUVRYZnR2OGZuMnhs?=
 =?utf-8?B?WkVRZDBQYnBvakxLZXphMm9oYnlGOU54TlpQUTZtTlVRWGV0ZUJjekdPMmZ2?=
 =?utf-8?B?L0F1SWw1NzY1dSs1SytnbEU4UHE3dnBScEt3T3NoeVJlV3p3d0pzdE9PSG9q?=
 =?utf-8?B?a2RPMW1vSXlOQlNhek9zaTBYOGVUakdLbXNCKytSN0VGQUVhY2lFb2Z0NDRl?=
 =?utf-8?B?YTdVTkpGL2Q4WjlTZVlVSUFTaXZSbi9STjBobVgxaW1OUUNKZTVCVmx3bmVD?=
 =?utf-8?B?V2V2b2FwQUpHVzhFWHBBSlNmTEg5NU9NSUU4b1lOZ0EyZE8yV3N4VFJVUVRQ?=
 =?utf-8?B?amdyM0pVTWllWDB6SFByWjZvTHNCSEZVN1BPckVRS3V2NGpObkYvTHVSU2NP?=
 =?utf-8?B?aUhhempFWHhyd2Z6akxJSTFIdWd5NXlTY3J5cXE3RWpub21wWFIvQ1BTb2pI?=
 =?utf-8?B?Zm5Wc0hFM0t5dUhRUHFoSjRib1FPTlpUc2M2a21pdFNRYUFKV3h1cTI3OFVy?=
 =?utf-8?B?Q3VHRjdIdmJRRkNyUVVLeURycXd3TEova1hCOFYwdjhZSmtoa01RQkhQemcw?=
 =?utf-8?B?aURkbmVIR2pmbXlIK1ZKRUJnZlIvaFVWblFTbmlYZTQ5dm9ZTGMrYlBLZFZT?=
 =?utf-8?B?dVc0RUJiUk01SlFuK3BLcW1YMWhacEhSK1lSRzd0V3VEZEY2bFdkWXQ5MDhE?=
 =?utf-8?B?eUZrOWpmQUZna0dJQWMwcDJMUm9neUZxRWZLL1ZYOHlsaTFqUWphblFKVUUx?=
 =?utf-8?B?T2FvUllLR3hTTllGRExUb0ZZR2J1VUQ0L0pwTUZiai9JWUFKdHl4eWhybGhC?=
 =?utf-8?B?SmMwMVlMSnhPWjgyK0dicXpWSnpSTE54WlBHeGRTOWdpeDJGQW5PRUQ0UElx?=
 =?utf-8?B?WFp1NFdGVllLSzNKUHNQSTdKMDI3ZXhwM09EM3pHZDhyejkzWE1CUVJCdjZy?=
 =?utf-8?B?L3BLYTNnOWpaR015ekVidVZZSTNQL1AxRGREbWlqMW1sOWRSTVE1VDBsODVG?=
 =?utf-8?B?T3RiSm03d1lXNXg4aERhbnFsanB0QnpZWGxBNHRoOHQ2V0o2Ym9GOEVXV1k0?=
 =?utf-8?B?N1U3K0pSVEI1ckJIVG5pS2R1bzVOMUNkUDIzaGwvNVpRdVkxaG1TaTBXRDc2?=
 =?utf-8?B?WTMxMnVINTl6L25BL3BBWHJoV29RdUpnVmpDZk9hOHUwTjJXazJJN2hFTkJO?=
 =?utf-8?B?TUEva2ZCMkFtbmR2aWppQkZtdTQ2QW90cld3T3BxU3FIdElLQ2Z6cVBRdG56?=
 =?utf-8?B?ZHhrR1d1dHUvUmlqYU85NFd1c1pZbXpCK3FWSkFGOTRYdkxDYkFrQXdqaStU?=
 =?utf-8?B?VVNoNTlRcjBYcFdpRkh4QkNKYnR6K1M5R2FaYmMvUmZTa0hnRkZnamNvVEJs?=
 =?utf-8?B?NGQrRlJQVnRRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUdNNnRsNnFybjAvVHlRNDlWbzVPSVNPaWlJeExPTUJ6WjV4dnZqby9TYk9x?=
 =?utf-8?B?QitPWXhvV3ZFTThFVURyNjR5U2hVaHhFQ2JxM3lZSUdkY1pkMVpGZGpibWdv?=
 =?utf-8?B?YjBJeXBLcEVObVc1aHRaNjY3TjJwdkdWYVBYV1Z1ZWtuQndOYkY2SUwrRnpT?=
 =?utf-8?B?Q3F4ZFIwc2QyQlloSXNCcjVUK0V1b3VyQ2d1M0VMZnRxb1crWjZlT3IxNXZQ?=
 =?utf-8?B?WDh3bVNSTWw5N2prc09IWC9oMTdYWjgzcVBYVzNuTmJSSTBDUkhwNmJkTVR4?=
 =?utf-8?B?VjM2TmtSeURFdHVUK0s2blB0dWtlSVV5WkpoOXVhRnZMMXF6OTdHRXRWMFBL?=
 =?utf-8?B?TDhoWFNXMlc0Qm5yUkwzY0FnMUsxMk9Wc3puZlc0Q04rWjVPaTB5cVRmbVdl?=
 =?utf-8?B?M1I4WVhnNnNnS2JKUk9jcVpXY1dwVEZjRE9nUWZFVXR4aHEzRHBQZDVXczhm?=
 =?utf-8?B?YVhRQU1zOVRESkxuamVodUI5a2taRVA3empETWhQeVd5RXNqZjhUUGJWRzhi?=
 =?utf-8?B?UnNBZFF3NmlSRHJweUFGYzd4TmNyZVIvTlJJNE9uWm9EdXBuenB6VGVIMlY5?=
 =?utf-8?B?Yzd0ZUtwSDRrdkUrYk0xSWVXQ0NzSzZMSEEyNUZnWWdQOVhsMDFScWs1THZJ?=
 =?utf-8?B?V3k3cG9kMVNlb3NrZHBpT210Nkg4cXZEV2pPcklwdW5TME5ucWs0OElQUldk?=
 =?utf-8?B?QjRXdGFiZDEvQjU0M0hhc1greGRrSDVyWk51UHl5dTNocW91cFR4SDI5bFFQ?=
 =?utf-8?B?WStuN1BYNGRSTWVZbkxqYWRHTThDNEIwMlpMRzRPUTNIRjhqTnJ1SStlK1pl?=
 =?utf-8?B?b29tY01pS2hzQTJ2MWVndFlRK2lCNHU5Q0pxbEFkUFZRY29zUko2QkJhRGhV?=
 =?utf-8?B?RHc5UjRUajFHS2czQjN1ZWxMTEJuNXJaYnYrSTZONklJNjdHcDlhYnhPbWJu?=
 =?utf-8?B?dzhzYjREWHpQQ0V5NmcySzdyc2NZeHVockxNRzZzYU5QbkZHNGUyanVNbEtw?=
 =?utf-8?B?L3lvaDJ0RUtwTU0vdS9VNDhsUG9EUjVwekhjcVNqSzY2VG93NjBGejlJRVRp?=
 =?utf-8?B?VVVrWHRzSnFiSmVkSHB5VVNpZWVhUkZEdHE4N25QZzIzOEFPZGJxQ1lSMEVD?=
 =?utf-8?B?TW0rQmdvSEwzOFdBeVA1WnEvbEIvelhtTFpNanpqem1OOXZHK0RtTnQvbi91?=
 =?utf-8?B?ajBIUlRRZkxsemIrNXZickdmbUZnekdRb0REUWFRN0gxM2JUb2NCRUJlQU92?=
 =?utf-8?B?SnEyWThtTWpualJsTjlSQ2pxUzdaT1ZRdFdDOEx3QmFkYnVXUktLZGw1cU9t?=
 =?utf-8?B?WHZ4V0pZbjk1a0dPNG1zZnBLSlNZRzE0YVJkNDJxZmFVaU90azFnd2ZBNnRU?=
 =?utf-8?B?QWE0dldvZnFjREVrTlhUNzNJb1IwVE5RbXl0YVVzR3dpWXhudUNDQ3RwTFNk?=
 =?utf-8?B?V2hWOFlaUWtoMmt3VjQrdEhVYVFRMjN0dGVYeTEwdG1raE5YZUZiY1lJdWds?=
 =?utf-8?B?VEZ0YWdjOWdnSExJUmxjQ1FTMXU3ZC8wTG9TSHFmYmRHaWg4UnRqR2lLNkRQ?=
 =?utf-8?B?cFFGQmY4Tlk0OTRCYUlZdUU4YXI3S201OWZwaDBqajYvZUdNeWwxQzlWRkVX?=
 =?utf-8?B?M3V2TW1oNHMxYWZGdzlreVgxSThRYzYxRjgxN3JEYnhlRGMvMWt4Y2Vvck8z?=
 =?utf-8?B?eEJxaFFXcVdzUENhSkx4U1hJVm1icGVBemhYVVRLVVVwbW5JQlFkTUZnTTdr?=
 =?utf-8?B?WXdKc3dkbmZyWnJqSzJSU3lvSHVmeUxLSWJlb3pGbk1zcDFybnQxUE5Fd0xs?=
 =?utf-8?B?d1dod1YrNnBSUmM1SHJ0ZWxSSU9YZXBZZjI2QXFNbThadFlUZVBUV2oyQUFu?=
 =?utf-8?B?RU5VeWdRbis0OUlwZFVvZSt1OWpPbG5FY0NxNzEzTUNhL1VXN0cvOWxGQVRy?=
 =?utf-8?B?SHNHN1ZOT2xtWncrOFZDd01MZHgvSnFhZEtKcXVNdHFzcDFVcFdNZlRWOHht?=
 =?utf-8?B?ck5NaVU5UFoyT2FJdHBpWmZqNzdXYmdqVXExVW5VK1IwZWprL2tFYURHQ1BZ?=
 =?utf-8?B?bVg1SVRWLzhPRHJGaVRLQVN5bllOWkI2dlRDTzhod3diSTdWYS9CcHMyalU3?=
 =?utf-8?B?aXYzZ3VZNythSkZtNUZNSmVLQ2F1U3F6YzJ1L29XNUNTMnRxbHRnVm5FQjFD?=
 =?utf-8?B?UWlDU3FSaXpXcjRqL3NYL1c0eWdNNWZURjhKdzd2RnNuU1JMTXVCV3drOGZZ?=
 =?utf-8?B?MThzUlhQb3FXYlRWNkZTajFXazVRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3713bced-9818-43b6-fe56-08ddfc275fe7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:33:40.0253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4MWKb9CAJ8HcV8Nx/COl7yXQsZUeoQRbKpMe1/UjDA7mzPWrilM4epstjXeD/EDKZUkCnl1oiV06+azq3NdxDa56bfc5eM3PF/qQ30bdQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8380
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfXzzRq9cp1rZ9h
 srugX9o2GQVC4P4Qzsz3Y6nFk9L8ad+bWdC5+XPqh1mxn+sub4o7rulW0SQf4Yq0k/9idS1E/4C
 CcGMNZTTWVEmWliM0xsvzy03FiokiKFL3vbPUMELoJ0giGplfWiYeAcWiSzbpl2MNPbLPuCGIg6
 I3IZdo6wZw+joMRx+JWoCFRuLGuxzADy7wZGXsFI+v4JQIx6T1OYluSInjcd9n+yNA4T/1tUrtQ
 ohBCN1fs10AVgFgLpsJrQwLZXm8iQmYj+lRVMJaV+UBwojV6KXIB3wQVvRxqJh3TsJfw880c1N9
 gs3+SQNN5BrXH+WTxhRWHhFBapJfvohWCEk2AGsRa8acWszbiTCL+7ZABe1ihk=
X-Proofpoint-ORIG-GUID: RuysJ5I2sQR1CCP1lZeeYNizeXkgXgF9
X-Proofpoint-GUID: RuysJ5I2sQR1CCP1lZeeYNizeXkgXgF9
X-Authority-Analysis: v=2.4 cv=aYdhnQot c=1 sm=1 tr=0 ts=68d52897 cx=c_pps
 a=iMozJJ0ZMpdRlXWW5uynUA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=sLdYhChum70qGmeBGo4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This changes the prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index d4f5c7b9d7..b53ed3b456 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -463,7 +463,7 @@ static void vfio_user_pci_class_init(ObjectClass *klass, const void *data)
     pdc->realize = vfio_user_pci_realize;
 }
 
-static const TypeInfo vfio_user_pci_dev_info = {
+static const TypeInfo vfio_user_pci_info = {
     .name = TYPE_VFIO_USER_PCI,
     .parent = TYPE_VFIO_PCI_DEVICE,
     .instance_size = sizeof(VFIOUserPCIDevice),
@@ -474,7 +474,7 @@ static const TypeInfo vfio_user_pci_dev_info = {
 
 static void register_vfio_user_dev_type(void)
 {
-    type_register_static(&vfio_user_pci_dev_info);
+    type_register_static(&vfio_user_pci_info);
 }
 
- type_init(register_vfio_user_dev_type)
+type_init(register_vfio_user_dev_type)
-- 
2.43.0


