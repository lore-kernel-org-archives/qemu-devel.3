Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00176C25B7C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 19:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD7zI-0002Ms-LY; Fri, 31 May 2024 15:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sD7zG-0002Mi-V0
 for qemu-devel@nongnu.org; Fri, 31 May 2024 15:32:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sD7zA-0008Ql-DR
 for qemu-devel@nongnu.org; Fri, 31 May 2024 15:32:26 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44VIA2VS025400; Fri, 31 May 2024 19:32:17 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Doracle.com; _h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DyzVF+uIVJf0aco1npUR3uTgFeTJ1aVXBwqII/Kh9uFg=3D;_b?=
 =?UTF-8?Q?=3DKe5/L5Uk4VhOH+MhbCqJXpPHjyA28VWJeqmQsIHEgXvSSe3UPSP4sLTLUTnX?=
 =?UTF-8?Q?5o5Vu8rc_KJlZoIPzUaKIee6klrs+yB+mJF0/fd+qhKrB2m3dxajbfStJY37DQt?=
 =?UTF-8?Q?tfctf3LGAYvU75_kFcjqdJm66HQ7OSxlG8KFCRpLHx/pVJxBpkgdGx08y8GD9BP?=
 =?UTF-8?Q?GcGMJXzPHF68oE1lL9lA_VYP7z8e08iUdmYIcOOz45t408V/NhgKGtpVGf4/h93?=
 =?UTF-8?Q?eiU+LbkJElyXymg/SPMvPF7Dna_j7ELc2IdnedO0hlewhPAMAUfnL5vRPWz/hlj?=
 =?UTF-8?Q?xdcfWuNVjK/YeJ5JJwVzsy+TttwIh8X9_hQ=3D=3D_?=
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8j8brpy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 May 2024 19:32:17 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44VIdKQR010749; Fri, 31 May 2024 19:32:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3yc512bsu7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 May 2024 19:32:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ey+E9DxxsfDG/BNOLI9rWWmvhQ9lWHtCD5+ouk900c05V1sE+/+2STZ5/Ns5B/OBWyh/N2FzohHsU1ZD9b52YUkkuuBGph4MYB7nfgoXcjw/azba0ho4PFcu/5wllrllthSzrRCwS5KoI8zW1DSs0ON7NZLorKXsMzTqXpzIfWOzC4nSabE3TpZX45VVyAyef9ajkqgdqVhITNXSnRG3k8ryL0tdbchnaL2/tU7VZ6PkkXJfShHdEWn9XuWaYBeuiz+I179e4bbr4cgp/Mid5oBFjv/zFkolzF5bZRyY1JzOg5k5Q4wpwLOxzoYTMe7QWGm2BJ12rMtoRUw8jR6kKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzVF+uIVJf0aco1npUR3uTgFeTJ1aVXBwqII/Kh9uFg=;
 b=T/LGzU/jFT1vBK8Yvd4O7EO5N3hEQoU5qfYuocxMsNxDOnE0ZIPNFE+Q22DzFDddTd22zouscfu+Sqh6/GzEMZUmScoPpSdmi/V2e0aL34/nsZTEIK9ni7N3YIOErxl0bcKv8BCPO/iJdelcAr5CHtPDRdasjrynzuemKfMgR5bECHYqkJ+b4j/rJ8+meBfVgOYXbfr6GyH8GccTb76lStiZm2wbX5OV5tEuSfW+2hjquUqqRcFp9+5TEddkd+svZcSIvV0t9APTeV3haPCKg3u1Dx8bxjtcy55Tu2rCpxtn5NLbTuE8K2HRPfaHaiS2BZkFi4fQzvSrZMkhQirvDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzVF+uIVJf0aco1npUR3uTgFeTJ1aVXBwqII/Kh9uFg=;
 b=Y2DRHStBOM4zHtRyVlLkb5izhW6sj0quZcF2wDuEzyhlg8UOiZoSacpl0KDGmRDPDQExqG0NbGi6er/ODH53mTF02CCU45BSYbGINqp1JRm9JdjeF5iJwHLIvh+Af+LKj4UV5lED/5gBm9ciTutK4gkOif7ZuJlvEyezt5dy+Dc=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ0PR10MB5836.namprd10.prod.outlook.com (2603:10b6:a03:3ed::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Fri, 31 May
 2024 19:32:14 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%5]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 19:32:14 +0000
Message-ID: <22df3040-bc08-46d4-bbbf-378a278476ff@oracle.com>
Date: Fri, 31 May 2024 15:32:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 19/26] physmem: preserve ram blocks for cpr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-20-git-send-email-steven.sistare@oracle.com>
 <ZlZQVijf2weEmzYK@x1n> <c3f23e83-81d7-469a-aa04-29785fa6f8d7@oracle.com>
 <ZleBOx6pN6KCn0a2@x1n> <e0cb49da-9799-4a26-8844-f5055b6ae45b@oracle.com>
 <ZljH1zbqisK6VowI@x1n>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <ZljH1zbqisK6VowI@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0168.namprd03.prod.outlook.com
 (2603:10b6:208:32f::6) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ0PR10MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d9a1ff-ace7-43d4-213a-08dc81a85fca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTQ5OWE0NkhScXhtV0dJNDFYdEU4djRSM2F0VDkrK2ZlT0tVK0F4WWlaa044?=
 =?utf-8?B?OERTNDdnZUJ0RngrcnB6ZTFSTmtnWWQwakxWMm96cU9EdmVlSVZuVjgrVUpa?=
 =?utf-8?B?dTgzeERLVFVqYXBGK3EzdW1TdTd2NXdVUVZOaENHUGVBb1FCOGVaK2Q4UjJm?=
 =?utf-8?B?ZUpGbnM0em9zMG11QWQrNGFUa0ZzMlkzMFRMMkxYRHZkNEpkOWVTWExhMk50?=
 =?utf-8?B?ekwxZERYV2owMnU3MzI3VUhZck1vWHRpcE5EMjVyZDZmWGtqT3o2OThiVksx?=
 =?utf-8?B?M1RqL3F1UzV1MXQzNnU4RzFza1psZlh4WS8xVWNEbWZrOXloeXphMXdBRm54?=
 =?utf-8?B?ZjBodUh5Nm5pbWJKMFJKaTZoZUwxWDdTbVErem95aEFoNHp4R3FkU0dTZG1h?=
 =?utf-8?B?TjN6c2RXMTBRcjlkSjc3cHlrK1pUUngwa2dzaitjRW5zWW02VlNkb29hMkNw?=
 =?utf-8?B?Y3BLZStjMFlzbFBVOFZrNkFFS01IMExrcWpHeEpkL0RDUjIwTXl1NzExUHdl?=
 =?utf-8?B?TE5yY1UxQTFNb1EzdG1odEdnYkg5TkhLczV1TXpEZ2o0eWtlblFTbUtaM0VC?=
 =?utf-8?B?VUIzVHQ2QVkwZnpXZHlWRm5WMno2RkpqVVk0bDlGM3VMdUVOUzUvV3dlRE4w?=
 =?utf-8?B?TUwzZmNoSVhycHk2VkpaY0hzcnpLcFYrODBvRVFJdjltbVNpVmNYeHJ0K2U5?=
 =?utf-8?B?a1VXc2F4V2ZYeG9kT2xYTEg2TURxblgwa1IxeHZJakYySml4aFBHWVVDbDds?=
 =?utf-8?B?WGJXNDVvNVlrcGsyczhNbmhmWk9SN0drWmp3ODQrYUs0TCtRbUdYNEtvdUxC?=
 =?utf-8?B?K0ZjcW5OWXJ1UUhic2J4MExGWmpDc0dYL2VTcDc1MnFxdEdvcTBzbWJwZDd0?=
 =?utf-8?B?VnZuaDh6WEZxMVI5M2Z4dlZjdzd2eCthR0l1UW4zdDdHZzlTVjNqWlNaN0p3?=
 =?utf-8?B?RkJDYU1EWENFZTJhS1Zid3VRRTFCdmkvZGZOOVJ6T1BFM280WTNMT0lYc0hS?=
 =?utf-8?B?ZHNsekpKVDBJY3lIcnZNUVdnTnI5R2grRFlneHg5YzdhOVlLakF5RnBtWmth?=
 =?utf-8?B?RTRMZFdmR21ERU5CQzQzSmFwTlpwZE5FQkdhMU5hRFpobkdWYkdwbTdtUjlm?=
 =?utf-8?B?Z04wME5tNkVVWXJsRFE3WmV3K0pucjJ0TnQxdWRCcy9XcW1VRGprT2ZnR05S?=
 =?utf-8?B?eDEyQjN0cWZpbFBKdUpybkwxWmpzWUFWcFkyZFA1S0FIbGRqNHFkUHhqK0VD?=
 =?utf-8?B?ZlVIbmtQNFdVTWlSNDE0MWtPVE9DZ2xYM0RoY01TeGxyOU1DSTNsQXFXY2Zw?=
 =?utf-8?B?OEZJMEVrU1lFdmJKZ1lnQ3JPTWk0bnhER0ZWUEtBQ3lJcUFUbzRjRGlodi9W?=
 =?utf-8?B?MDFic0hySmQ4aklBN1RLUkpvci9HejcwNE56MnRVeVo1QTYzaFZrRi9zQTBr?=
 =?utf-8?B?QStqTjZwaFhOaXJpWE15bHpOdlNIQ0hPYjA5ejVodlZwVDhXd1hVWGhwSHNR?=
 =?utf-8?B?bUJmZzl6eE5kVkZ1eDZwSW5ZellQQUczNUV3eDZkZHdsbDZneUNkV2hDaFE3?=
 =?utf-8?B?Y1IzcEUxRXBObTl0RTNOZGNLZ3had2hOZWlRR0VURUdXWmwrS2hINjF4Lzc4?=
 =?utf-8?B?a3kwZjNhZTBzK1hLNWdwbVg0WlhKaHpkS2xkWnZYVGwwMVlPR3JPWHM4Mnk4?=
 =?utf-8?B?ZkVIMVpNYVR2Y2pNcnpTcFVwRmJ4VXpJeC80c0xiNHN3QndMN2pEQlhnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkRCZUVsK25oZHpXaUI1Z3c0TWpzbCtVTkhnOWlOdndCdFhOcEJ5SnBhbThS?=
 =?utf-8?B?dTgzVlBQRVFwaTJJZTZlcWorblQ5cnFMTFF6WWp1WmY0VjBoWE1wcC9Lc0hD?=
 =?utf-8?B?VTFZV2E4VUhEZm5qbTJkbDdWSjQ0YjM4dEtldkRLYkUvYzRkQkNnY2k3UVVu?=
 =?utf-8?B?eE5wZ1R2TFNQaTNBK3k3T2tJREk4UFdXM3JqOG5vaTlOaHNSaHZ0cFpJaHVB?=
 =?utf-8?B?WmNEQmRNbkFpV29EM2V3TUZOTGJ4VnlUakZSWm1SazhOWGtWWHFnTDBORm0z?=
 =?utf-8?B?WkRnQ0p6VTQwbmErZ2xOWXJmdTJWSkpkbFA4NmtETzNlbGFSYVExYjlTRUtJ?=
 =?utf-8?B?dEpOaFphWEhORHZvSjcyckRxeTZ2VFIzRGJzcnFXdlZGaFozNzBxS3I2R0ZJ?=
 =?utf-8?B?aURzdDc1dVU3K0l1dE9ETnlvZHNUek1xalJvb05ETTRLbEFvUkZ0c0w2SWlQ?=
 =?utf-8?B?RmN6OU5IRXJVZjlkWDZ2cUhSTFlUVUVjaG43VEdOeXpHRktWbjZFTDJnQXFG?=
 =?utf-8?B?Y1ZzMmE5czh0Nk1vaWR3dkJYTzY5eXhFYjhLRHdtak1NQWRwamQ3WGQ5bkNj?=
 =?utf-8?B?blJMQTlmOCtRVVc4ZUdMb2FObENDcjI5M2c1U3VVaXNFS08yQXhPenBmMklG?=
 =?utf-8?B?QkFrbEFPM3pHUDFXNXloT3E3UFpsakJnMC9MOHIvZzhNczJXTWJBK3VrMlFu?=
 =?utf-8?B?YlpIczdpVVlWZm13Y1g4aFVydzVaSWdvYWtjVjNkU2F4bms2V0h5SDJiNThl?=
 =?utf-8?B?VE1ReTFoQXRPb3JKRW9vYTRWSm5CT3AyWjBRaVRETmQ2K1IvUGtERWd1OE9a?=
 =?utf-8?B?d3ZFWFBCbUZEZVErOUZVVk5zUWRjZHJYOTdlMFdFQ2dVZ05yY09idUV5QmJn?=
 =?utf-8?B?dVhrZmxRRUg3R3VsUWU4RnhDbjgyQjhYL1JId3NTL0JNcW5PNFUzQ2N3d0RQ?=
 =?utf-8?B?ZEJ4Y0VZVjZTNUc1bG5OSDVIaVJnWHZyanV1Vm9KNXJwSUp5MEcvVnBKbFM1?=
 =?utf-8?B?UFRGNkVTUTVQektXcFBYek9CQmhyTG9vNUMvdHp4Rnh2QWVXdVI2b2pESExw?=
 =?utf-8?B?R3luU2JsOUc4SGRhdGt6aDEvUWhoUkp4UHpUdkFUbzNLTjViK1h2RUQwYjlH?=
 =?utf-8?B?bDlWZnJoVDA4dUxrdmpoM1gwTm1zV3NKL1YvZUFRSnNRVkZScG40T3Y4VTNR?=
 =?utf-8?B?a0dqaHp4Zm50eWNNclcwWWNMNWlJOGxKK2J3bjZJeTljVDdWY2V0VFp3Z2FI?=
 =?utf-8?B?L09tRzEyQjMzazhBVDBEN1VlaVdmQkxUcVM4WWZ6WEkzMWx2VmJEVEp1MkF2?=
 =?utf-8?B?M21LU3FTTVpwS1V3VnphMFNXbFJIZE1pTDJkeVRvZlNkWFNNY3F6UVlqVzJv?=
 =?utf-8?B?SnVlazJNMTJYTlFFTUQ3ZDA0LzdFMXZoZkFBN1VDak9xRFM2eks4QmZsWkVN?=
 =?utf-8?B?MW5ZQWlITzdTMDF3Tk9QS0k1dVp4eFFjQ2tVUGNkRHVPNkMrQlloYjVXQmNU?=
 =?utf-8?B?M09JQ0FKOVI0dmZQOXNYS3hDMjVVWjY1bHgwWmp4S3JWU3FHZWhoY1d2cUhV?=
 =?utf-8?B?d1VqWjhpYmFMV3R1UXluTzlMRldrQkh2c2VMZkZaY25zUlZpb1lHNUMvSWpz?=
 =?utf-8?B?N3BVbWdYSXZMaFJsQ0RCWW1qR1pvWTcxVXZXU2h2V1RFWkdhNXpLZG1hRXZy?=
 =?utf-8?B?Zy9iUGx6KytmVG0wdEg2V0p5TjhGeFN6Tkc0L0E1QWw0SlE2UU90blFVV1ln?=
 =?utf-8?B?dGVBOEUrdml6STFpS0xPTGl4aE9mOEZVejNFTTB4K3lJenU2QStBM05rZ2pP?=
 =?utf-8?B?eWx0NFRVMDQ5SmZ4dFRUMlo0REQ1cytxT1NNWUxsb2dXQ2dxdEswbmo5WHFR?=
 =?utf-8?B?WTFuQXN1cHJ1UWNxWnhWcjRTWFAydGRuU01RTGZ2YmlFTDlyQVh2UHRoTGo3?=
 =?utf-8?B?dkNjNHFKaEE3dm04ZkNwL1hYYnpQMmVnS2l2L25Oc1YvSGI4TnJuZ050THNa?=
 =?utf-8?B?Tk5QTTBJcFV0cHA1M1F1b05VOWpyaG1PNEh4ZWlpTm5BcFVQNi9VQWJ5dUJF?=
 =?utf-8?B?ampqcmZxOGxXVTkvVCtnLy9YZVRvTzg5dURnYlZWTEFWdC9JNVZMck9uNFBM?=
 =?utf-8?B?UlJhcUR6a3lVaEJGUUdDd1lNa1duOGRpdFpqdDN3Z005ajA5K1hBWkYya01z?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: N7JSwLitFldQpPdu/N710o24HL5z332Z2oqbGCgKoBgv18hWbSvC6EEhyzGLg7zJGUBXqpxmhCm17/CivWJYjX7KhPJ4A6vSdmBPW2qODfxec/yZ9TE9+qYUP55wjrAjQw277dxst0k70qFXj8k6ZiXF/BlOzGvzCQusVu1QpExoXZEj0Ra7PZN1iOZFI1dKSUNqpdCCX0M1XJWVtlAn6VRdxNUBuro5zB/1NRoJUp9YomNXGiZt/uUxD+WW20a+wtIDxDk68hLZIxIexNKoRElrGf28644rC3hkcSAHM1pW5TGzxFpxnJ3Jb1v/gF+lHGTns9zD537alxjOIxh6bqHkcR5O0oADOKh1nFnli+rSQEQuil1rc1R+uHZCmwOVsiuJGeItUSnw3/qjtgfo8tg93PFZhbMpUBgxPruAbuYYtOz7uRa4RSV+OSsgxbQa8HXXNGeAMblMSEdfYHfhCY+86fLZ1CFV4V7p38DUHEXFzAVkzpFJcN0CayG64Wnn2MQ1p8gRseJlOxTCpUUmbDYHQCmMg1vcXXgtPiFef98kzIW2m907AqOV3P6i7R0qIE7/buDtUzwmXBLqtyyQC4J2WvNg7t0KnfoiXH3h7wE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d9a1ff-ace7-43d4-213a-08dc81a85fca
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 19:32:14.2775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hj9JcpWZoROeWHN6HxYdGGzEHiGi+lGcJrf4EplJpU+VHHcpm8CJbErwFhOuJsjG/gP4USYxtSGdSjRt8EBSC87k6MYuslroPraXyY4SmN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5836
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405310148
X-Proofpoint-ORIG-GUID: jp16w9A3uP-CBpDV90GIMuEjDS4qcTw5
X-Proofpoint-GUID: jp16w9A3uP-CBpDV90GIMuEjDS4qcTw5
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Steven Sistare <steven.sistare@oracle.com>
From:  Steven Sistare via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/30/2024 2:39 PM, Peter Xu wrote:
> On Thu, May 30, 2024 at 01:12:40PM -0400, Steven Sistare wrote:
>> On 5/29/2024 3:25 PM, Peter Xu wrote:
>>> On Wed, May 29, 2024 at 01:31:53PM -0400, Steven Sistare wrote:
>>>> On 5/28/2024 5:44 PM, Peter Xu wrote:
>>>>> On Mon, Apr 29, 2024 at 08:55:28AM -0700, Steve Sistare wrote:
>>>>>> Preserve fields of RAMBlocks that allocate their host memory during CPR so
>>>>>> the RAM allocation can be recovered.
>>>>>
>>>>> This sentence itself did not explain much, IMHO.  QEMU can share memory
>>>>> using fd based memory already of all kinds, as long as the memory backend
>>>>> is path-based it can be shared by sharing the same paths to dst.
>>>>>
>>>>> This reads very confusing as a generic concept.  I mean, QEMU migration
>>>>> relies on so many things to work right.  We mostly asks the users to "use
>>>>> exactly the same cmdline for src/dst QEMU unless you know what you're
>>>>> doing", otherwise many things can break.  That should also include ramblock
>>>>> being matched between src/dst due to the same cmdlines provided on both
>>>>> sides.  It'll be confusing to mention this when we thought the ramblocks
>>>>> also rely on that fact.
>>>>>
>>>>> So IIUC this sentence should be dropped in the real patch, and I'll try to
>>>>> guess the real reason with below..
>>>>
>>>> The properties of the implicitly created ramblocks must be preserved.
>>>> The defaults can and do change between qemu releases, even when the command-line
>>>> parameters do not change for the explicit objects that cause these implicit
>>>> ramblocks to be created.
>>>
>>> AFAIU, QEMU relies on ramblocks to be the same before this series.  Do you
>>> have an example?  Would that already cause issue when migrate?
>>
>> Alignment has changed, and used_length vs max_length changed when
>> resizeable ramblocks were introduced.  I have dealt with these issues
>> while supporting cpr for our internal use, and the learned lesson is to
>> explicitly communicate the creation-time parameters to new qemu.
> 
> Why used_length can change?  I'm looking at ram_mig_ram_block_resized():
> 
>      if (!migration_is_idle()) {
>          /*
>           * Precopy code on the source cannot deal with the size of RAM blocks
>           * changing at random points in time - especially after sending the
>           * RAM block sizes in the migration stream, they must no longer change.
>           * Abort and indicate a proper reason.
>           */
>          error_setg(&err, "RAM block '%s' resized during precopy.", rb->idstr);
>          migration_cancel(err);
>          error_free(err);
>      }
> 
> We sent used_length upfront of a migration during SETUP phase.  Looks like
> what you're describing can be something different, though?

I was imprecise.  used_length did not change; it was introduced as being
different than max_length when resizeable ramblocks were introduced.

The max_length is not sent.  It is an implicit property of the implementation,
and can change.  It is the size of the memfd mapping, so we need to know it
and preserve it.

used_length is indeed sent during SETUP.  We could also send max_length
at that time, and store both in the struct ramblock, and *maybe* that would
be safe, but that is more fragile and less future proof than setting both
properties to the correct value when the ramblock struct is created.

And BTW, the ramblock properties are sent using ad-hoc code in setup.
I send them using nice clean vmstate.

> Regarding to rb->align: isn't that mostly a constant, reflecting the MR's
> alignment?  It's set when ramblock is created IIUC:
> 
>      rb->align = mr->align;
> 
> When will the alignment change?

The alignment specified by the mr to allocate a new block is an implicit property
of the implementation, and has changed before, from one qemu release to another.
Not often, but it did, and could again in the future.  Communicating the alignment
from old qemu to new qemu is future proof.

>> These are not an issue for migration because the ramblock is re-created
>> and the data copied into the new memory.
>>
>>>>>> Mirror the mr->align field in the RAMBlock to simplify the vmstate.
>>>>>> Preserve the old host address, even though it is immediately discarded,
>>>>>> as it will be needed in the future for CPR with iommufd.  Preserve
>>>>>> guest_memfd, even though CPR does not yet support it, to maintain vmstate
>>>>>> compatibility when it becomes supported.
>>>>>
>>>>> .. It could be about the vfio vaddr update feature that you mentioned and
>>>>> only for iommufd (as IIUC vfio still relies on iova ranges, then it won't
>>>>> help here)?
>>>>>
>>>>> If so, IMHO we should have this patch (or any variance form) to be there
>>>>> for your upcoming vfio support.  Keeping this around like this will make
>>>>> the series harder to review.  Or is it needed even before VFIO?
>>>>
>>>> This patch is needed independently of vfio or iommufd.
>>>>
>>>> guest_memfd is independent of vfio or iommufd.  It is a recent addition
>>>> which I have not tried to support, but I added this placeholder field
>>>> to it can be supported in the future without adding a new field later
>>>> and maintaining backwards compatibility.
>>>
>>> Is guest_memfd the only user so far, then?  If so, would it be possible we
>>> split it as a separate effort on top of the base cpr-exec support?
>>
>> I don't understand the question.  I am indeed deferring support for guest_memfd
>> to a future time.  For now, I am adding a blocker, and reserving a field for
>> it in the preserved ramblock attributes, to avoid adding a subsection later.
> 
> I meant I'm thinking whether the new ramblock vmsd may not be required for
> the initial implementation.
> 
> E.g., IIUC vaddr is required by iommufd, and so far that's not part of the
> initial support.
> 
> Then I think a major thing is about the fds to be managed that will need to
> be shared.  If we put guest_memfd aside, it can be really, mostly, about
> VFIO fds.  

The block->fd must be preserved.  That is the fd of the memfd_create used
by cpr.

> For that, I'm wondering whether you looked into something like
> this:
> 
> commit da3e04b26fd8d15b344944504d5ffa9c5f20b54b
> Author: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Date:   Tue Nov 21 16:44:10 2023 +0800
> 
>      vfio/pci: Make vfio cdev pre-openable by passing a file handle
> 
> I just notice this when I was thinking of a way where it might be possible
> to avoid QEMU vfio-pci open the device at all, then I found we have
> something like that already..
> 
> Then if the mgmt wants, IIUC that fd can be passed down from Libvirt
> cleanly to dest qemu in a no-exec context.  Would this work too, and
> cleaner / reusing existing infrastructures?

That capability as currently defined would not work for cpr.  The fd is
pre-created, but qemu still calls the kernel to configure it.  cpr skips
all kernel configuration calls.

> I think it's nice to always have libvirt managing most, or possible, all
> fds that qemu uses, then we don't even need scm_rights.  But I didn't look
> deeper into this, just a thought.

One could imagine a solution where the manager extracts internal properties
of vfio, ramblock, etc and passes them as creation time parameters on the
new qemu command line.  And, the manager pre-creates all fd's so they
can be passed to old and new qemu. Lots of code required in qemu and in the
manager, and all implicitly created objects would need to me made explicit.
Yuck. The precreate vmstate approach is much simpler for all.

> When thinking about this, I also wonder how cpr-exec handles the limited
> environments like cgroups and especially seccomps.  I'm not sure what's the
> status of that in most cloud environments, but I think exec() / fork() is
> definitely not always on the seccomp whitelist, and I think that's also
> another reason why we can think about avoid using them.

Exec must be allowed to use cpr-exec mode.  Fork can remain blocked.   Currently
the qemu sandbox option can block 'spawn', which blocks both exec and fork. I have
a patch in my next series that makes this more fine grained, so one or the other
can be blocked. Those unwilling to allow exec can wait for cpr-scm mode :)

- Steve

