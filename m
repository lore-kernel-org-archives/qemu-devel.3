Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A83C3ABC3
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 15:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCgZq-0004WU-Ph; Wed, 07 May 2025 11:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgZo-0004VC-AL; Wed, 07 May 2025 11:20:52 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgZl-0005pM-S8; Wed, 07 May 2025 11:20:52 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5479Of0l003984;
 Wed, 7 May 2025 08:20:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=X/8N6UKtZ8G7tSk8jK6YSI/pCad7Z/z5AwtXOFGjA
 Vc=; b=2VNVy4WQ4Jqh/WgxQaIV8kg6FbJoCe2R8Yo0zhm/i1WpFuQWjALEnG53h
 AIdsny38E/j06Ya+PZ00DPl9g88GE1vuN9U9QxFGRWce0eSCS6R1/QzGdcgMLD97
 9r5cI77syPbR3fW93aLtG/Rn1CHygaO2SzTBgRi9MFk1SQsGR1End+Du7L6DHS9E
 eav+RbOXjy/Ll8uGqkUBysKLWEkzaygyetvHYbRW0Yj5pN0PNvOGOpARKtdX4+Sx
 O8+jopull6p9Z+rq6V0LhN9VcGQDkY3ktpHxc6wJLFRWYM3YtF2XfXrdQtya8Idk
 SIjK5pZH8wq+j7DtRlq/khkyA174w==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46djpygyx9-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 08:20:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7o4bJPV3jW/dJdajlkrUKEyKV+tmt+eIk1I5KBIlwsO92J/XZBTaz5pNhm+Eey8CXDbynlGYjAyjDkSKY6eULOQVE/rlnoRUm6N6a9qkKw19r8mjyrZrdSCu430y+QVCYgr6FcES0RdkuREky0nsMxQSWM+8BymdliGL2fOeSlse9uyffU+Nuc79dy/MCveKrSPpedWZITrBCaYptoWOhOhFHwr1SR6ymR5zF1u6lHA7vSU556Cm5isivQZbIad614rK7gVK/B6doqpQyuT76YQNMmWoSzOfogno81Q9YPSSAOAiOJ++IYHVEvYd4F3z/aQs1aaIEkYXqzmiCKiug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/8N6UKtZ8G7tSk8jK6YSI/pCad7Z/z5AwtXOFGjAVc=;
 b=ZDSDrc3eLxA5GCc1slc/YlpdCiqpZpypGhArpnruXbxUCmW6glxuzoRjN11Rhzi48phmugDdj3IHXPp3oxCZHotGRtPV+4rK8a/bUYMRfhi5Oy6yWtlJ9PqAIFdS30UXiWf9btgeYGMapTHw60LkMEic3XrD+iY92aju3S4RKO5FTjDKKWbH/6VNaB+hmAAwCXx2Py4Mne2VLDpScG8qSaEa2QlH1VWb2p7oBS1hMtrjeUkgmn/kB+JdSL4kaoTEOkWLttrCxacXX7WNRlATxu9ppEoTygzav8Jreb/XFb9LzDU9XKCyN3l7Osx/eqZsIXS4Ln9sfDo+Bi/7tlUfDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/8N6UKtZ8G7tSk8jK6YSI/pCad7Z/z5AwtXOFGjAVc=;
 b=Mucbt91h1yKi2MLVL+YDvvkjn5wWBVrPQZdtreYOvpioPfPd0IuOEceN29TFj/eRH7/LFPCq0IfMBJOvAsZjydg1JSkpPiwYeHs8Mo7PSgbT1DTj1MeriA7XY0h/uab67luw7NEgQxcqvLb18yOTTcr2saySw3K45oi1oEhjr6JG7rtA4rMXBr9Ayui/WWxYEzFmxW9W+uUVKkQ9X80hegvl1i9iOZr8LRxjwYgajAQYD03CuXNtiiNsLRsK/NO+6yF01V3fjM376awVp/P2npaLf1kfpKU9RcJcLKCpgMDtOTyaW6TfmOMRp74VD/lMw1UbF/QG70lpEL/ymiKrVQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BL3PR02MB7970.namprd02.prod.outlook.com (2603:10b6:208:355::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.12; Wed, 7 May
 2025 15:20:38 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%5]) with mapi id 15.20.8722.011; Wed, 7 May 2025
 15:20:38 +0000
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
Subject: [PATCH v3 04/15] vfio: add vfio_device_get_irq_info() helper
Date: Wed,  7 May 2025 16:20:09 +0100
Message-ID: <20250507152020.1254632-5-john.levon@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BL3PR02MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: b09134da-0c15-49c6-d4bd-08dd8d7ab8db
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0xhWjE1SnllNWZhNXVkbWljN3laQzA1SjhabkF0cEVQS3lsZTl1VGhxaFl4?=
 =?utf-8?B?ZG9FbUVUc2hvbXhHT3kwNExobThMRTAyeHI3UDVvY09tcGZTM2dYUnVFZ2Vm?=
 =?utf-8?B?VWRoU1dNWU5lZDhxR3h6WHhFSWwyU3ZPcFBjVlJ5TUVndzY1dHNZcW5IRUhs?=
 =?utf-8?B?d3doTDJ6aXArUW15MXA1WC9GUTZSVHh3aDFlQXltZSsvWTFOTWFvdnRoZEJv?=
 =?utf-8?B?QXg2UmxJd0txSy9HN3doS3RXMGlxQlFRTlQyWXIvWEVhbHA5RVpneUNMSUhK?=
 =?utf-8?B?QkZOcXBSQ0VHMTcrd2NEZ3hVbmg5dWFFd1FrRGh3QXFrcTFDTjhYdVZ6QWhX?=
 =?utf-8?B?VEx6TVQ5SitHQXhza3F2S0xZK3MzTTcvczZDNktmcnVqL2hKUVZVVlRyMmFH?=
 =?utf-8?B?TmpFdUpoNGNnWkFoYjM2WlZvejdObXpKZlo3UC9SRm1sK1pJRVV6QWluS0Nl?=
 =?utf-8?B?Y2QrMEtQUnNoMnY0UkZGS0krZW0rRVVhckxJa1V5QmhMaHl0d3MrbHlrdndm?=
 =?utf-8?B?NCtQQTlkOHQ2alIzMEQxZjdKMWY3aGI0bndnTlk2YldPWEVPcm8xWnJOKy84?=
 =?utf-8?B?czQ0OUgxS293SEtuajUvdG5kaUpyTmxsaytwSkxJdlI5Z0RsL1JvdUtYc0hi?=
 =?utf-8?B?Y0FTRmVOdncrYngzN2Y0dGJrdlc4TlNaV2xERG5sVVFNRjBMcTYvWmJaeC9h?=
 =?utf-8?B?THNLZzFuWlBrZmErbEVKeVpkNHFUT2VnRUNMNVlpZjhRU3liaS84Tzd2SzA2?=
 =?utf-8?B?UjY4bVZOZzJVVDdKaHdEYnVNWWFqV2RmODgrdDVJYkxkUjVqOER3cFRUNWRV?=
 =?utf-8?B?ZmxWZEdpTGZZbnlpT1ZsZXNKbHNseERHNHFOd0JlcTVDOVpGSDRGdXJyTXFK?=
 =?utf-8?B?SmlyY29KT3ZZZ1Y2akdxc2k1REQ3MEp5THdGWFNqdlNFbDRwMnZOL2tFYktY?=
 =?utf-8?B?SS9xcVFxUG85L3g4RHArRWdROHQ0RDFvUW00WXV5TlhjZFFlT1NrY1AyMUxQ?=
 =?utf-8?B?UjVncU8vUS9xNmx0ZW1XRmZHUGJZSU40dmQxdUpIWGVYVVpiVU9VRi9rU3d5?=
 =?utf-8?B?SUFVaXFUdi9JaWVrTUNweEpMMkVGRklPTlk1UGx5Z2ErTFQ1UmdQZjR3enZk?=
 =?utf-8?B?S2duVDMzbXVnenRTTFFreEpLV1FQSkhjcTliaVNKV0wvMG1wTXJBYStNSS8z?=
 =?utf-8?B?Tkd0S1hjMm1aOVhUWkJzWGdLMklrSi9iRC8wRHpyOWJGTUZaYk1neGdtWmw0?=
 =?utf-8?B?eDc2UitQaXA2SVdzcTRnVFF4RzRtUEtTZzRhaExOS2p2TkNrbHRra2JSWmVF?=
 =?utf-8?B?NXFSWjhtUVZzdmNVNWNWamR5Vlg1Znc0dDcyU2FINC9iUDIrNFJGVW50cENB?=
 =?utf-8?B?VGh0OFQ5WUFnM3FJM215RkZzV1RjVzl6ajhZMWdVRG5UajNoaTBpUGhtTHcx?=
 =?utf-8?B?bXllRTlRaTNMTDdWN2cyWjBxbVBGbTNtQ1FJMUdaQzJnSkxZeHh0czlvZE5r?=
 =?utf-8?B?eFk1UUkrcCtyTUc5TE5yVFdQckxhbkFpbjg2SkNVTE14d3FiRGZZcjVPOXcy?=
 =?utf-8?B?RjEyTTJPSnB6cU1CTjBQRUgzZi9OOE8xa3czVHVTWDdETmlBZ1pTeVk3VDMw?=
 =?utf-8?B?LzJUQkF5bGFFWDA4Z29aK1R2Wm10YUpmNm5GMGZWQXJhVXp4bEY5QWcvTWYx?=
 =?utf-8?B?dUw2cndUN2xZak1YLzQ2R004RnVYRFlTS2ZyUlp4RUJGMlFNUWM0UGk3R09H?=
 =?utf-8?B?Z1YyR2VPWnI0YUtsTm90d2JaR2lnWXMxYitzZnZLdU91VytuRnEvMDR3VU9j?=
 =?utf-8?B?WFJraVNId0t6SUQ4N0UzY2swNGFodE1aUUhnaGhqLzZqUmJ0L2JvUjhXU2JF?=
 =?utf-8?B?UUZzbWpOa0hmUzFNMTdobDR0OEJOVTBNeU05SDRFbHFMWng1a2hWaHlYOFBx?=
 =?utf-8?Q?qlZYRa4E6LI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWJmbVVQa3VneUpCR2pWZlJIYXd5TkV0Q25HVVNZZ1g2bGpjNzNhbEpIRTd1?=
 =?utf-8?B?TlVudFZqL2FRdlMzQVY4SkNjbldnc2t0UUxSMTI0TWtramUxbEZXYXFObEQx?=
 =?utf-8?B?dk9tejJmdldNODN1eWoxSXYyaHZreUFsY21KWEpZYWRrTS8wRytGUnpQRTNw?=
 =?utf-8?B?YUloZEFVQkpkdnAzR002NlhUUkZGSmdPeFhDK2ZIb0h5VWQ1OEpSNXVOaGNJ?=
 =?utf-8?B?akZDZDllc1c3ajBqWU40Wnd6Z3JMVVJ5SzRkSGF3dVlEQ0NwcEVkQ3RmMXhF?=
 =?utf-8?B?VDZGMmpOVEUzYk1mWGdJWXhubW9lcnZ4S1d5aUxuNGhIc2tVTm9mckQyQUJF?=
 =?utf-8?B?WVdYN1FYTDIzeEtRemNJa2oxbjBUOGk4Um42U3Q3c0lhb3lVK0gyS0NuSXRP?=
 =?utf-8?B?L1lBQXZHVUJWQUhyd0Y5Y3RNcFZ4NnkxQ2pqc1U5cFBjazJ0b0YvYlZPYVdJ?=
 =?utf-8?B?dG1GTVRNV2NPSGFuLzNpMVo1QlFzZGNodWRzdVE4VEFxbmEyWGgzVFJCZE1h?=
 =?utf-8?B?bWkyRzZvbnJnYUt1YlhnblFudlFhVW90QnZObkFiZEowQ0hmK2FOQy9FTmJK?=
 =?utf-8?B?dEdTZURqMlplOURSMmU3Z0JWN0FGMElUVXZDamk4RU91R1lLTi9JcmtmM0ZX?=
 =?utf-8?B?OEdGV2t2NVFiN3JJMW14dHpJUFV3cEhjNWlyOXB1RCtJTXUxQTVOTzRVOFRp?=
 =?utf-8?B?RHlZY1ZpTWlwV3I2R3JxSzVBYWNwUDhvcHRxYkljQUV6cE9XQkFEWStMN3kx?=
 =?utf-8?B?UHllb0x0OUkydHJFR3YvZ0VVVys0NnFDZjVVYVlRZURPMkFPOWc0RVpidEdi?=
 =?utf-8?B?K2U5M0xrV2lvclh4VmJYMVBIYlhMTmhMdi8xcmxtU2dwZkZub0p2N2ZmWVho?=
 =?utf-8?B?bHd4T1ZWSHJjVDcyaFVEY3JBYkIvTG1yQ2ZyMFJPY2hYSFR5VVR4UVB3VVl6?=
 =?utf-8?B?UjJCZ0pEMHdhRnJWZVpTL3pOSTRhUXV3anB2L094MDJaSGlDRSthWVEvQVBZ?=
 =?utf-8?B?WjVhalVFdEZuMjQxMmJHUWFiRDR5by9QL1M1d2EraS80dU85OGtYUmR4My9T?=
 =?utf-8?B?SXltaVFXZzU0OWY2clBHUGUrN1gyS3RaUmVWenhpWkhCRmhxanpzZS9aTUQ1?=
 =?utf-8?B?NzNSamhsK1QrU2UvaldDdXRFR2tsNWZsQWhZL05BQVZwYnliRXpaOGpTaFZw?=
 =?utf-8?B?MjBJZVdJNW1UREdhTzFHRzZGNUdlbXhDS2hpcHNYL2Z4STlBK0RMMFBpV001?=
 =?utf-8?B?UWJRRFlkTEQ0anNDcE11ek9LRFFCSlpmbkhoSW40eDRyNndLYUxSOW9CRzZT?=
 =?utf-8?B?aUpzMUREQ3dzRlFPb1NVNTBrSkgxZFI4K2FlWEwySldvWThpR2JGc28rRnZk?=
 =?utf-8?B?TUJzRHVWR2pzQkhQb08wTjlQek5NK1RScDdGSDBxUmFHc2xBQVN6NEdXZEdQ?=
 =?utf-8?B?bno1bEtIREhFcGcraVU0dExJL0tHQUFhcDFqUUJMVXZQcG5rcDlHUnZYL1Fk?=
 =?utf-8?B?aUUrYTBnR21qSVNaK0lWVzFBTWlNdlZjQUZodHVsemt0WUIwZ3dZbjBkRTFI?=
 =?utf-8?B?bFJMSnNXUFVhaTFoeVJwd2QvSGhGa2g0c1pSRWZVV1VpRmRWZ0wwK3BySUhr?=
 =?utf-8?B?Y2UrYkVvUXBwOCtjM0EzOEdSRFFqLzFsVExpV1gwZGQxdmVNUVFQYWJJQVlp?=
 =?utf-8?B?VXUrbitNNTRFNFZRcmlVc01xaExNd0hxRU14WFZhNUpjdllPNENHeGZNbU1D?=
 =?utf-8?B?dWZUcEl3WEQ2eFYzNW9MVnh3UzRXREY1VUpjTmVDSTdjVytiYzJpdVJha0ZS?=
 =?utf-8?B?TklEV1hGK0RwazN3d24weGhMcWVUVzAyYklXL2w2QnFFNnFmajBhZmMybHM5?=
 =?utf-8?B?bEh0a3VNSVp1MXBBcTFDQ1JwNjN4MTJWK0orY1E3eDQ5NUpDR2hJOWtFQUFL?=
 =?utf-8?B?MkV3UWg4T2VtOHlENXRpNWJZUEFIYTNad01DL1dTUjViL2tTZWVSOUlXdVV6?=
 =?utf-8?B?YmNMNFlQak5TV1AwdThZRFdvUmFROTlUQ29WcWlGNGZMdGVhRll1ZzEzRTdV?=
 =?utf-8?B?dEo1bXFLaXRtZHFINGFCK3ptaTZtMlF5aDRsTXNVM3NZcXowbm5MSkZUak1u?=
 =?utf-8?Q?2WerbbbWveFydLuP81T9l0qJ6?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09134da-0c15-49c6-d4bd-08dd8d7ab8db
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:20:38.4876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOKMKh/01wLwu7thc9zzUZsKfyNSefDli+/4PV1gq+QBMCv21/xC4BLNCAHOfqICbHXsuV/wEuEnwiaFLhvr2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7970
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE0NCBTYWx0ZWRfX0LSqeN20myQd
 gIaxnb+49v2Vwil1KJ2GE6qJYfAHYewPBUL+erZqUqaBL5BMfWBiB+A8imLd4F3HonNyosOZ2Mm
 z+Yh2uW/8Frt3bL89J6i5ljh+YjfbQFmf1EeXVgUKURLriQpVoIm/RwLXnRCJrsNVykGZst8g5G
 V2cia5hE75zDiW6UQKj7qkFGTsQQ/FbEEOHpbXRncvowJdr2RrVe8Qhk/S5F0AvRflbQ+1NrHW3
 73wa35mw4QuPHb9405Ir59Z6DCmp3ZSYGmffTADgyw0yY4v+q2FWmQecIlswYf8WZ3qNu3Kqfiw
 Vc7EzoRkMymBi2AK3yi6MA+xJZRZtP6fNQFd7KGyNMl/ugFOjzPw1+iPS1jIQLzUCQfW8NAGq0T
 mqb/1v5ZlBBMx53hL4aM1HY+6Fo3BqR9XAaE3vYpDGD7xv6YjnUr8cGJRlO/uaHIPTT2PidC
X-Proofpoint-GUID: kC2gJadjli_cL_8_Tctiv7RptYX54bME
X-Authority-Analysis: v=2.4 cv=NMHV+16g c=1 sm=1 tr=0 ts=681b7a4c cx=c_pps
 a=WxcSnoYPg5jl6yrDmkeCeg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=vT2z2tywOHHVet3RVBQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kC2gJadjli_cL_8_Tctiv7RptYX54bME
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

Add a helper similar to vfio_device_get_region_info() and use it
everywhere.

Replace a couple of needless allocations with stack variables.

As a side-effect, this fixes a minor error reporting issue in the call
from vfio_msix_early_setup().

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 include/hw/vfio/vfio-device.h |  3 +++
 hw/vfio/ap.c                  | 19 ++++++++++---------
 hw/vfio/ccw.c                 | 20 +++++++++++---------
 hw/vfio/device.c              | 15 +++++++++++++++
 hw/vfio/pci.c                 | 23 +++++++++++------------
 hw/vfio/platform.c            |  6 +++---
 6 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 8b1437ba66..a7eaaa31e7 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -147,6 +147,9 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
 int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
                                      uint32_t subtype, struct vfio_region_info **info);
 bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type);
+
+int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
+                                struct vfio_irq_info *info);
 #endif
 
 /* Returns 0 on success, or a negative errno. */
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 1207c08d8d..785c0a0197 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -74,10 +74,10 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
                                           unsigned int irq, Error **errp)
 {
     int fd;
-    size_t argsz;
+    int ret;
     IOHandler *fd_read;
     EventNotifier *notifier;
-    g_autofree struct vfio_irq_info *irq_info = NULL;
+    struct vfio_irq_info irq_info;
     VFIODevice *vdev = &vapdev->vdev;
 
     switch (irq) {
@@ -96,14 +96,15 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
         return false;
     }
 
-    argsz = sizeof(*irq_info);
-    irq_info = g_malloc0(argsz);
-    irq_info->index = irq;
-    irq_info->argsz = argsz;
+    ret = vfio_device_get_irq_info(vdev, irq, &irq_info);
+
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "vfio: Error getting irq info");
+        return false;
+    }
 
-    if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
-              irq_info) < 0 || irq_info->count < 1) {
-        error_setg_errno(errp, errno, "vfio: Error getting irq info");
+    if (irq_info.count < 1) {
+        error_setg(errp, "vfio: Error getting irq info, count=0");
         return false;
     }
 
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index fde0c3fbef..ab3fabf991 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -376,8 +376,8 @@ static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
                                            Error **errp)
 {
     VFIODevice *vdev = &vcdev->vdev;
-    g_autofree struct vfio_irq_info *irq_info = NULL;
-    size_t argsz;
+    struct vfio_irq_info irq_info;
+    int ret;
     int fd;
     EventNotifier *notifier;
     IOHandler *fd_read;
@@ -406,13 +406,15 @@ static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
         return false;
     }
 
-    argsz = sizeof(*irq_info);
-    irq_info = g_malloc0(argsz);
-    irq_info->index = irq;
-    irq_info->argsz = argsz;
-    if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
-              irq_info) < 0 || irq_info->count < 1) {
-        error_setg_errno(errp, errno, "vfio: Error getting irq info");
+    ret = vfio_device_get_irq_info(vdev, irq, &irq_info);
+
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "vfio: Error getting irq info");
+        return false;
+    }
+
+    if (irq_info.count < 1) {
+        error_setg(errp, "vfio: Error getting irq info, count=0");
         return false;
     }
 
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 9673b0717e..5d837092cb 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -185,6 +185,21 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
     return false;
 }
 
+int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
+                             struct vfio_irq_info *info)
+{
+    int ret;
+
+    memset(info, 0, sizeof(*info));
+
+    info->argsz = sizeof(*info);
+    info->index = index;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, info);
+
+    return ret < 0 ? -errno : ret;
+}
+
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info)
 {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index e1fab21b47..5ccfc67aef 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1555,8 +1555,7 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     uint16_t ctrl;
     uint32_t table, pba;
     int ret, fd = vdev->vbasedev.fd;
-    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
-                                      .index = VFIO_PCI_MSIX_IRQ_INDEX };
+    struct vfio_irq_info irq_info;
     VFIOMSIXInfo *msix;
 
     pos = pci_find_capability(&vdev->pdev, PCI_CAP_ID_MSIX);
@@ -1593,7 +1592,8 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     msix->pba_offset = pba & ~PCI_MSIX_FLAGS_BIRMASK;
     msix->entries = (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
 
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
+    ret = vfio_device_get_irq_info(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
+                                   &irq_info);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "failed to get MSI-X irq info");
         g_free(msix);
@@ -2736,7 +2736,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
     g_autofree struct vfio_region_info *reg_info = NULL;
-    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
+    struct vfio_irq_info irq_info;
     int i, ret = -1;
 
     /* Sanity check device */
@@ -2797,12 +2797,10 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
         }
     }
 
-    irq_info.index = VFIO_PCI_ERR_IRQ_INDEX;
-
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
+    ret = vfio_device_get_irq_info(vbasedev, VFIO_PCI_ERR_IRQ_INDEX, &irq_info);
     if (ret) {
         /* This can fail for an old kernel or legacy PCI dev */
-        trace_vfio_populate_device_get_irq_info_failure(strerror(errno));
+        trace_vfio_populate_device_get_irq_info_failure(strerror(-ret));
     } else if (irq_info.count == 1) {
         vdev->pci_aer = true;
     } else {
@@ -2911,17 +2909,18 @@ static void vfio_req_notifier_handler(void *opaque)
 
 static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
 {
-    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
-                                      .index = VFIO_PCI_REQ_IRQ_INDEX };
+    struct vfio_irq_info irq_info;
     Error *err = NULL;
     int32_t fd;
+    int ret;
 
     if (!(vdev->features & VFIO_FEATURE_ENABLE_REQ)) {
         return;
     }
 
-    if (ioctl(vdev->vbasedev.fd,
-              VFIO_DEVICE_GET_IRQ_INFO, &irq_info) < 0 || irq_info.count < 1) {
+    ret = vfio_device_get_irq_info(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX,
+                                   &irq_info);
+    if (ret < 0 || irq_info.count < 1) {
         return;
     }
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index ffb3681607..9a21f2e50a 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -474,10 +474,10 @@ static bool vfio_populate_device(VFIODevice *vbasedev, Error **errp)
     QSIMPLEQ_INIT(&vdev->pending_intp_queue);
 
     for (i = 0; i < vbasedev->num_irqs; i++) {
-        struct vfio_irq_info irq = { .argsz = sizeof(irq) };
+        struct vfio_irq_info irq;
+
+        ret = vfio_device_get_irq_info(vbasedev, i, &irq);
 
-        irq.index = i;
-        ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, &irq);
         if (ret) {
             error_setg_errno(errp, -ret, "failed to get device irq info");
             goto irq_err;
-- 
2.43.0


