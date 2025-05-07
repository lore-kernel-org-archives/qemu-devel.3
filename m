Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E7BC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 15:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCgZu-0004Xr-Sh; Wed, 07 May 2025 11:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgZs-0004XB-Qv; Wed, 07 May 2025 11:20:56 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgZq-0005rV-NZ; Wed, 07 May 2025 11:20:56 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547F6LPC025060;
 Wed, 7 May 2025 08:20:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=t/fIOJZgMIG6FxW81kzqI2xckBDdfFWvyWt1lYH98
 aY=; b=YJ0TQ14f3PdWAZyHgzVjL+0OwelSF+QVqbdXKp7df5cEaheYdGg+ExYp9
 sYv64YFK0Zcy4l3Hx1Ka/RH7Qf/2omwUlsKGcVFQhpivyvRzeew/Ujz18JB6y20Y
 2X4/E+M+1RbdGHy5n58+YOgjbaiqTbUMzqggJS7FohcOlYwJH8+7YWbmKymgCzRM
 /02k+E3+nED8hO3kRWIVp0A+nOLOebLCWbMWjqgmBDRAIAL7Vc4cS1BudnVLXmDh
 m2dyBrnBh/hLh64EuP5ni7tKwWgNjTaSdb8aRJ3r73qBXF5ciJ4WwBhSpx/LRp2f
 ChJKzd0Q6xTbO8yhUe22XHNxRzudw==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazlp17011028.outbound.protection.outlook.com [40.93.13.28])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46df2995n4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 08:20:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUe/AHycjnFs9I18ahjiVfmYdVnnMgoS96t25Y2zs5oIJcq3edsyg2qMyAYP2Etaq8hngjLcSmDUUq350j8WcwhJvKhDb2ebgiXku97rcPbwqekWEJjRViJmg/BxSlibbP4gywR5WfpIr9vrVjZgdN75NnVSvf5+n+7mX0MT+muuKBZi4mzRgFLixq9tcSv7vY5S9wlA+JDVFx6TUPYFLY+HnhK7aOnVSkRCYn6UaDVe3/mUA4R6x7GeA8KWRHhLhYgb1HZ0XticFg2erLp2Gh+OjiHu3i7TyzS6dS4I6e9/wj0MU9M4aE7zVETXKr8iCqLBKZ5B+y9CW5qImIadqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/fIOJZgMIG6FxW81kzqI2xckBDdfFWvyWt1lYH98aY=;
 b=pvVBkwlbtK3g6qXHMHkkIvwHn6BWxrhOmYVjmHnsJW/L15yUxXLoQMjYmP84aSwY3PxuN07T0YBWfMh7idb2sFjcpx5RRUhsXZew45Awkpu8NHgIOv/l3VrxX3sJ8lcGkFSAnJXojrmFfDDGITBSOa4NcaHtK1s6bfUpVs2ziQSQuAkZddZO7ByEtHksOqNsLR1TyEsrutmIkja3Zfjtr2FLqbNZhcUsy/wjsJFYh3a2tZIbKjbfPdYnYKm0NVIpte5Bx2jXXlYn45Viu6xa/8m+Pr2U+V98l1jQvV13lKAPH8G4ivow/rsrJ7HoSWtGhFsQfMrnQMc2JJv+z/kXzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/fIOJZgMIG6FxW81kzqI2xckBDdfFWvyWt1lYH98aY=;
 b=vakrpU5cWZovce0g7B2OIbnTK5N6A9ohjdst2KlRBftu9p/7ko42PvBp7p4837UbHA4mxM1r5YzfAfFkX6tsbMacGQx8cLBdTPzXvgw4DEpNuF9/MYg9oAjJ+W0xXREdmtJCmt/ppC/T43QeQervVFHu3zDfAZQmAn42YgXMMsKSEGA0bXvnH29qDRHtfTo9fIH15o1fRscjphqLmlZCzcyKHQEVVvaxnGAOavHnLfE62PKiZqaPAe6Mua9ckH7QYUvXKXfUomS42tmtqRiSMQyp3iKPPPS6z4Iksc87GcbVX6RCSLMN1RjM3Y3tAvgYiDoTKp8UZ1Z4MXo02Jl0Eg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BL3PR02MB8220.namprd02.prod.outlook.com (2603:10b6:208:342::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.17; Wed, 7 May
 2025 15:20:42 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%5]) with mapi id 15.20.8722.011; Wed, 7 May 2025
 15:20:41 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, John Levon <john.levon@nutanix.com>
Subject: [PATCH v3 05/15] vfio: consistently handle return value for helpers
Date: Wed,  7 May 2025 16:20:10 +0100
Message-ID: <20250507152020.1254632-6-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507152020.1254632-1-john.levon@nutanix.com>
References: <20250507152020.1254632-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0055.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::22) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BL3PR02MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: c1fd34ee-43e8-4a80-fab2-08dd8d7aba89
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dllWNFkyUWZ3Sy9FN2RFcnhDbUFXbGxQRVBaVWdDUVdVSUhkcG1hNnpqc3h5?=
 =?utf-8?B?NHJUZlJQRmgwZkNYS3FNSmVWRVNOYmdUQ1ROS1c1K1IyT2JnNVpIc1lPeWg2?=
 =?utf-8?B?L1RlNE1uNWc1S21wMi9lZElITGxMYWVFNkc3YzZqN2lwWlVFdkpaemd4Qkpp?=
 =?utf-8?B?dGRlNnZ3UTZnYWJaQTI2QS9CQzViRE9HYVFhS2J0aTdTRGtHbHk3Qm41YXF1?=
 =?utf-8?B?QmhmOW1TRWdYbVZYMFBSUXZnbFNZZGdpbWRaZXRvcHNBWDNxSUFUczZnRXVG?=
 =?utf-8?B?S0p3dzRFTjUxR1poQXJuZHlCeVZmWFYxc1NWT2ZCcHJBaFYyZ21GaXdaYklR?=
 =?utf-8?B?emVBVm9BZXlmeU5KR3BHV1c4ZGNHc1gyaUdzc3ZOWTBXeWExdWNvNzR3Y2xL?=
 =?utf-8?B?QitSeGRYckVQOFdldzA5NndIRml2TGNBY0xNVnZsRTJrd2ZZam55c0w0K2xx?=
 =?utf-8?B?aFBLQ0lCNGVrT2YvOW1QajVQcVBXMlU1THVLTVdoMk8wck1rcGhoQlc1d3ha?=
 =?utf-8?B?eWx5bUthUk1LWTlqTDN6WDFiTnhjQURMMHBnUnJkVXVGQjVFaEo5SkFHZFow?=
 =?utf-8?B?S2U2RHU1bnhtbmVhTTZFWDVLNnk5N08zSUdaaTE2ajF3dXBHV2FzYnd1L0Iv?=
 =?utf-8?B?Z0VkMm9ETWQrMExIZUxYWjh1NHA1QUh4MVpqQ3RkSExwbm5sdEhqWUIzSzgx?=
 =?utf-8?B?a2hkT0s1UDYvR1BQcVJiZ2NwUHErNXpEdzhMNVhpSEJDWUpDR3JWWTJndjNt?=
 =?utf-8?B?S2FLWWx1V1d5d0FhejJkTmEzM0JxZ083bWwzcFlEUzNDV2dZYkg4djhWK0NL?=
 =?utf-8?B?Y1JwNTdTOE5LNm4wYWtxSFkyRVJXelV1L2IxYjZRSkg0dW4rQmJiV2pITW5v?=
 =?utf-8?B?UjlGUW4xR3BIenA0Zm1Fa3pQdnBKQUx3dGRwcVRFTHVsQUNqN3IyUTZjMWl4?=
 =?utf-8?B?eGNDa3pydUpISi83NHNtQWU4Vzc1bHoreE5PNFdjUkxRaVpzbGVsNmdFN0xx?=
 =?utf-8?B?YS9TTjhveXFTS3I3aDZzakIvdDNKRmxtdm5renJ1TDRMZWJJS0JMRy9FOFls?=
 =?utf-8?B?enBINmlFSHlDTW5FY2hrMW9aOTRLS3k5YzREWG10RHA2SzI5ZzUvQ1Q4MWhY?=
 =?utf-8?B?MU56Y3htRXF1UEsyYXpobXZndUJ3V1U1VG1RdGpJamphenFCUmxUTkZ2a0Ni?=
 =?utf-8?B?eHE4L0pBeTAyOWtCWi8vR2RxRndORG5ZaGxHU1l4T3NGaVFMaXAwZ1BWU01t?=
 =?utf-8?B?dnFyYlE4VHRwS1l2Uzc4Uzd3UEdSNjFyQzc2cVprOGJlZHN3dUFkc1F6dnpj?=
 =?utf-8?B?K1E3TDlOd1VxU2grc1M3TXpJeENhekZabzR3QU01SVo3RW1kSko0c2JmVnpT?=
 =?utf-8?B?RExUN3U4dkdjYVlDZXdiOFM5ZnRRVkh0clUvcE4xRW50VFM3T0NEa2FrNTRG?=
 =?utf-8?B?YTJ6b3R4ZWtaOGRYaFpZMHoraE5TcnQvVVdQODNZK1JQeXZaVlR3dXFNQlJN?=
 =?utf-8?B?bXJmZG14L1hkeUpIanBaVXVxTlQ0UWhBeCtIaVkyZXVRdk53SzBjTUdxc1RI?=
 =?utf-8?B?OFU0QTVJV2Q4MElJQkdOMWUydm9ocCtsSmpqUk1SVGdvU0t6NWFBL3h3SHFS?=
 =?utf-8?B?OGRaT3l4SUprRENsTHhsLzJPa0ZnVDlDcjdJOTNBamtZYUMyaDlkai9oa2tq?=
 =?utf-8?B?VS90SitpQXYwYXlNc2lKRFhnSW5XcW1ZbTdzRXo4UEx4ZmlJTlFZeFNpTUJQ?=
 =?utf-8?B?Z1dRbGlFbnM3TVdyQXJrVzhUZzRvKzFpYVk3MkY2VHhDaEZ0KzFkVWd4V0py?=
 =?utf-8?B?Q0diL0VubnA3TGZidUVxaFAwbFZ6U0VWUGJIMVhhZlJDSUhoV2w1L1RFdUc0?=
 =?utf-8?B?Uzdrakdnb3JHd3ZOSTZVeE9aSlNwRmROMFNVWmJKZHBVOVN3Q2pURXY1bkVw?=
 =?utf-8?Q?/op9qQeUqO8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTJVZnJ2eTdlbjdKSm4vQkYvb3ZPS1RXc1lnMVVVN0dMcklkbmcvWnRYbDU2?=
 =?utf-8?B?SE5rb2FaWmlXSStxSUk0cDZFVTVNMk5qN2F5RjFsTHY5Yll5bnFQeHAxUVFZ?=
 =?utf-8?B?Vm8yc3cyN0tvVkFiR2s3UzBaeUhmbEg4Q3JiM2pWMm5EL002cEFvdjVzTWxW?=
 =?utf-8?B?N2RQWnVxRWw2REZSQ004RjlVSXVaL0hYQjNWeTc3RDRRdFBnQWZVdW9ibmx5?=
 =?utf-8?B?aUgvZWF6UythREtGaUFac1liZ29wSmNRNXdzN2IySVpEN2VBRHVsNnFZb21U?=
 =?utf-8?B?MmJDNkYrNENUbG40VURsclFEMlJHMlBZSE1lWHl4TWk2TmxyNGxOU0YxeFl6?=
 =?utf-8?B?N2RocTdNb3hYSmVuaUlTUVVTNmgzTUpDUlBSeVdKTzNNcGZTU3BhZWh1c1ZF?=
 =?utf-8?B?T1REU2pPcXc2bjBGRlhhSitUM1JXb1pSeVRqNCtzVk9Kb2ZPcWVJU05LRTcx?=
 =?utf-8?B?aXp2dUVGNTJaQ1JoMGtVWE0yZDBYVmRFRDBoSkNsaitQR09heGZ5NFdVNUw3?=
 =?utf-8?B?Z3l3TXlFdXlJMFBLRFhlRjVWMEJzRFJ6bDBXSC9USjQ1a0pKc0EwSjhJdEwy?=
 =?utf-8?B?SVlnVWp2L1VYWVo4N2phRXVXdnBCR0xDSkt3bmI0QldqY0pMYk5pZ3ZsZDZC?=
 =?utf-8?B?S3dJaWtDejB4QmZtN3RHY2NQMjJDSS9sZWVJKy81NTlFS1A1Q3llUXFkNk55?=
 =?utf-8?B?ckExdVowMEJKSFZYK2RwSFNnRVRiNmxiNllUcmtLMUlWdmlqOUZ2OGdtSVFj?=
 =?utf-8?B?NnduSkFHd1MvVUhqTFNJbmM0VjcvbnJTeTRQbUNwdmhJT2xLYVJoNUFsZVpV?=
 =?utf-8?B?bU5wNGpwSkJKaUlVMkR1QktIbndTaXN6bFJnbTlqeFhYRHlLdmhHRTdBZVR1?=
 =?utf-8?B?ZEdDWllKOXRMQ0lmbEl6QU11SjhxN3VjNm42ZEo3eUp2NHBjdHNCVVBscXNV?=
 =?utf-8?B?UHE3bGNXNlhVbm9Tem1UeEpOVmo3YzIvUS9CbXhKYlpta1RDWFFpSTRiT2RV?=
 =?utf-8?B?dTdnaVlBYW04RVJOZmNnRWloeW8xL3Rjc3haclFVVzNVNG9sWlliYWpqNnFr?=
 =?utf-8?B?U2J2TXJuK2E0VDcyWDZWaFEzOTE1RE9aWmp4UDhoZlZOME9Qc3pyZ3FXQ1dl?=
 =?utf-8?B?TWdncXhXTE00eDZ2MzluZmxuWWNJNUtTdkVpMTdCMmMyM0FlY2RjUStJd3Fz?=
 =?utf-8?B?UnBLNWQrbm90OHVUVTVwam9VQjdJZjV1dWlSTUh2N0N5MDBRN0drQ25zcXhQ?=
 =?utf-8?B?N0tsbi9nTXlwRGVZS0MvVWZJVUROUys4RkN2c2Rlb095TUhZUUt1YTdYRHRo?=
 =?utf-8?B?b0dVY0VYTXJNZjF0MnJ6UWVLdjNFYmVBTjJvL1FPb0lDbmZxeUhidkhXWkU3?=
 =?utf-8?B?RXJKTzU3UVV2bEM5Q0kvWkZ4U0lSdnJ2djhGSHRnMEluMFowbVBwUXBycUMr?=
 =?utf-8?B?SlJyOENXOE82b0JnYWpMTi9OZlVNbU1PdTdwclpsV1k0THE1NUV4elVCQ2Zt?=
 =?utf-8?B?Qjd6RHp5bmlyRFB5NkhoeDFBSzFmcmhKNXVrUU1sWGNGQkIwNUpYeE5nL1FI?=
 =?utf-8?B?Rzc0Y1NJODIrTG92V3BJUDJCZkQxRFJHcjlxREc5SStSaGlLQVNpZ2Zna3hx?=
 =?utf-8?B?bnFNTHZUQVFKajJSUGVHeCttOXlFbEphU3J1aXY1VUU2NEdkeWtMdUFrMGVZ?=
 =?utf-8?B?UEFQaktWS2RlajZKOUl4YnJFZ2JsRkxtNXZ6L0s2V2R6R3BUdGppd05Kc2xo?=
 =?utf-8?B?WTBhaVJVOXgrMUs4T1VLNG5tV2hFYXBMd2EwTStSd0YrOUdRWXRtWE5rOWY3?=
 =?utf-8?B?WjFPZ3I4SjkvOXdXNVE1K0MxWXNIQTdvZGdQVU5lWCtTK2lkSEhibHRCei9E?=
 =?utf-8?B?QUVoQVBaaDBLR1NKaGJhMjNnVWcrREpOK29jK2ZkM2NIZkJNOGt6d3lEK2hR?=
 =?utf-8?B?dVZaVXNYOFh0ZzVKNE4yRDUvUnJkOHlRY21qNW05TCtZeWRYZ3VnVTFtNkth?=
 =?utf-8?B?UkpyNm5JenFyWkJXV2dBWGJ0UzFoZTlGYXRLbEU2Qy9yR3lIYWllSDR5enZw?=
 =?utf-8?B?Z0JEbEwxc3FZYU1DMFNCVW5KYzZCNWFZNDdIcGlEOTNPQnRncXRMb3Bzc3kw?=
 =?utf-8?Q?6/x7CfwghxGWvAr0L2aER3Llq?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fd34ee-43e8-4a80-fab2-08dd8d7aba89
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:20:41.2999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMd+68cvLBUM9h8YhQ90i2Vh/kO8tRkC1xcdG5bMuqQLMejV+CCz2o1g+NapNnF5oraGU20vqpkbducSrMAqSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8220
X-Authority-Analysis: v=2.4 cv=WtErMcfv c=1 sm=1 tr=0 ts=681b7a51 cx=c_pps
 a=P5WujBTXSBe8sApKbu0jwg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=khE_JiE8E1OrqPP4vgkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: b5uOcY_FNwvfxUaeHfV-sfP3G9nhQzQa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE0NCBTYWx0ZWRfX3fH9pBIuhV1u
 Ovnrr89d1xYLZ/lZf93HdhQIm077R3G1qweVMZOgdJzGuzVD/vn1DblQAcOwPwa5XJYCeWaV0vu
 04IH5iHz7vKGdjvb/3zfHmG3HTkP9W5tcI512YgEofBQdWy12vdS/zfoluT8N+ArXtO3hTVm2Gr
 oxUCE1ZVoUXVaFYuVfLbXI4KLMNoDIdZL+fSu69QU7ar5GsSdxukN+Zjp6xTj7Wcmly/eiAD+Sf
 hVmR34kJGzPXRes1kSHEf3tQiCmjlYqDSCDpjAgozmAM8P4ESPH8agimU9NdFvoNmKyUWNmGiWE
 UMduLD321gjiQCdf2bVDfYQaR6c0kiTDM87FTYeGBf2Vg3B8+79/lMmN8pyVmf/7JamiB7weEbN
 YxQwvA2CUt2sDIBBq3G2VlG8yK2wWijX/sN2az1fqf9izeQAL7wEbafsUm98LGrQKbJpWBrM
X-Proofpoint-ORIG-GUID: b5uOcY_FNwvfxUaeHfV-sfP3G9nhQzQa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_05,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Various bits of code that call vfio device APIs should consistently use
the "return -errno" approach for passing errors back, rather than
presuming errno is (still) set correctly.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5ccfc67aef..866cf58d04 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -398,7 +398,7 @@ static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
 
     ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
 
-    return ret;
+    return ret < 0 ? -errno : ret;
 }
 
 static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
@@ -459,7 +459,7 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
 
     g_free(irq_set);
 
-    return ret;
+    return ret < 0 ? -errno : ret;
 }
 
 static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
@@ -581,7 +581,8 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
             vfio_device_irq_disable(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
             ret = vfio_enable_vectors(vdev, true);
             if (ret) {
-                error_report("vfio: failed to enable vectors, %d", ret);
+                error_report("vfio: failed to enable vectors, %s",
+                             strerror(-ret));
             }
         } else {
             Error *err = NULL;
@@ -695,7 +696,8 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
     if (vdev->nr_vectors) {
         ret = vfio_enable_vectors(vdev, true);
         if (ret) {
-            error_report("vfio: failed to enable vectors, %d", ret);
+            error_report("vfio: failed to enable vectors, %s",
+                         strerror(-ret));
         }
     } else {
         /*
@@ -712,7 +714,8 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
          */
         ret = vfio_enable_msix_no_vec(vdev);
         if (ret) {
-            error_report("vfio: failed to enable MSI-X, %d", ret);
+            error_report("vfio: failed to enable MSI-X, %s",
+                         strerror(-ret));
         }
     }
 
@@ -765,7 +768,8 @@ retry:
     ret = vfio_enable_vectors(vdev, false);
     if (ret) {
         if (ret < 0) {
-            error_report("vfio: Error: Failed to setup MSI fds: %m");
+            error_report("vfio: Error: Failed to setup MSI fds: %s",
+                         strerror(-ret));
         } else {
             error_report("vfio: Error: Failed to enable %d "
                          "MSI vectors, retry with %d", vdev->nr_vectors, ret);
@@ -882,17 +886,21 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
 static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
 {
     g_autofree struct vfio_region_info *reg_info = NULL;
+    VFIODevice *vbasedev = &vdev->vbasedev;
     uint64_t size;
     off_t off = 0;
     ssize_t bytes;
+    int ret;
+
+    ret = vfio_device_get_region_info(vbasedev, VFIO_PCI_ROM_REGION_INDEX,
+                                      &reg_info);
 
-    if (vfio_device_get_region_info(&vdev->vbasedev,
-                                    VFIO_PCI_ROM_REGION_INDEX, &reg_info)) {
-        error_report("vfio: Error getting ROM info: %m");
+    if (ret != 0) {
+        error_report("vfio: Error getting ROM info: %s", strerror(-ret));
         return;
     }
 
-    trace_vfio_pci_load_rom(vdev->vbasedev.name, (unsigned long)reg_info->size,
+    trace_vfio_pci_load_rom(vbasedev->name, (unsigned long)reg_info->size,
                             (unsigned long)reg_info->offset,
                             (unsigned long)reg_info->flags);
 
@@ -901,8 +909,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
 
     if (!vdev->rom_size) {
         vdev->rom_read_failed = true;
-        error_report("vfio-pci: Cannot read device rom at "
-                    "%s", vdev->vbasedev.name);
+        error_report("vfio-pci: Cannot read device rom at %s", vbasedev->name);
         error_printf("Device option ROM contents are probably invalid "
                     "(check dmesg).\nSkip option ROM probe with rombar=0, "
                     "or load from file with romfile=\n");
@@ -913,7 +920,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
     memset(vdev->rom, 0xff, size);
 
     while (size) {
-        bytes = pread(vdev->vbasedev.fd, vdev->rom + off,
+        bytes = pread(vbasedev->fd, vdev->rom + off,
                       size, vdev->rom_offset + off);
         if (bytes == 0) {
             break;
-- 
2.43.0


