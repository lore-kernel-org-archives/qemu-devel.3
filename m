Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2996EC27C44
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 17:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCjJX-0006Jr-Df; Thu, 30 May 2024 13:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sCjJW-0006JH-Hr
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:11:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sCjJU-0003yZ-JY
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:11:42 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44UEf0Ml001870; Thu, 30 May 2024 17:11:34 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Doracle.com; _h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DUKSzgmTsJjmhCYJiSP+wgVhVe5xk+YQDnoqHoMWsMlo=3D;_b?=
 =?UTF-8?Q?=3Dnkzcf4rb/p5T6Q9ppqVSSubSPHDhUtRqfY/ErD5iECHd9fxRobkdMdqkZTj7?=
 =?UTF-8?Q?2eaU4cOj_P1PQw7GBovLZDHAODxfMG4l2Ab3fUIzCX/Pj1+IzjiLMD95NhD4l6H?=
 =?UTF-8?Q?ilS3xsyvM0f1uM_/hHQw2L0KjT8jcE+L/DbzwXFFPy3fFSXz8MbX6zGmIX/pSAi?=
 =?UTF-8?Q?2n0OmYbfjuSUQWVhOpKj_vSNkdjZKkBKHO6gXgipwf0BXtAIB8I4md04i+D9ODa?=
 =?UTF-8?Q?Kl5md0S8XylfsgWKKRiJ0pjU2Q_Oq6xLJPb9ehhHtdCmo+Wv6vQiQ3GllbR58xv?=
 =?UTF-8?Q?PcJAjyognQDSs4vZAUZenJJePbvZtwtY_9Q=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8fchj43-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 May 2024 17:11:33 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44UGfYaV024012; Thu, 30 May 2024 17:11:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3yc52e5bvd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 May 2024 17:11:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxxGT4ByZaYRC7k5jXlKCXm8jXVMVQQXzsxqYEbl5WSqBsbUdmCaEwRgKOyVVogNC43+DKZ3XMa1FTmGclnFJlZ1peHcOiMnJsSTACt2umfIBNqwDFXitvXqUL7GEr8FBhoUlTUtosMvuMqaJKh5ddJC5L0DKUvjxcZ2ihBVQ1PkPcBUf0TXp12tYYc/xOkly6SS3ZVkX13ojY8mob7zuuuQRj5gw9WjaN6+mvWCDvip2cLhCIO/mYV1D0Cu/oRU5cDwBQj3HftAMrusAZQzGhrubLAlsIuVnJhAytyU/x/BAiJuKDEHSMPj7PXVWRDDWOu3wuZDufiDJUNp3mgihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKSzgmTsJjmhCYJiSP+wgVhVe5xk+YQDnoqHoMWsMlo=;
 b=VJXBbV1yIDoGPOiuFO21uZAabrp/b9IOp9XIj2XsLGHdCidpf+RN0dBr9JHC6mgQdr29J904yVH/veBbCdEx0cEcJaSoLe31LOsU2tjaU8de8r68u3e5yAF5wr068iBL39uq4G2RjVEf5HOmJhswBhNHufRKdK9smq/cUNVNAttzHDGWrf2Mq8iYEL2277PrfnnXm3qm+27ZkFer/qQfbv5YNrlyIDswsePRmyvqaCjeqan/UAkAKtABuerRnQsEX9XNRkCEUwZYLa6EDPrL3QRLvRRB2POYQQWU+2x0AdzfS1oXLsMzEE3FQUJY3JNHc3cHo2Usx3MHFnGw/uzDpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKSzgmTsJjmhCYJiSP+wgVhVe5xk+YQDnoqHoMWsMlo=;
 b=iJno0MOqnSDHwbNuR+EtvnjQzM/YOdd1l0bsWhDKaywsQJxLb0f9E+HUMkYQmVXeCNu9fdt03yc1/yshinZu9o3ACdoaUZNqyrx4pXMOcaWflkGRCdwtSDH3f7jHam6cqYR/ULbhA4oLd+tXSXaPCpHge3imVNEtWJLG1GmmY7E=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CH0PR10MB5195.namprd10.prod.outlook.com (2603:10b6:610:c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 17:11:31 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 17:11:31 +0000
Message-ID: <01170fdb-5c1a-4058-8d4b-dae07dbb52b5@oracle.com>
Date: Thu, 30 May 2024 13:11:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 07/26] migration: VMStateId
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-8-git-send-email-steven.sistare@oracle.com>
 <ZlTO9fVYG50r3XL9@x1n> <7119f070-57ea-4495-bd8a-1337555fac22@oracle.com>
 <ZlYX4BWLU19f1vaI@x1n> <18f8bba1-b687-43ba-9f2c-4cfafe005ac1@oracle.com>
 <Zld5kdnOB9CqyRYq@x1n>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <Zld5kdnOB9CqyRYq@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0015.prod.exchangelabs.com
 (2603:10b6:207:18::28) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CH0PR10MB5195:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b3f9a5-6709-48a4-f2b1-08dc80cb8ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d01EaUN1dnhXRGh5NnpTemRJU1Z4NnQ5Q2c5dWhSYVVGd3dVOWNEeXFCU0tp?=
 =?utf-8?B?ZXZBRmkyYXEyenVOUy9wbnhKVGx0UzFoNHlmU2hTell3ZStaRUFza3RQbjkv?=
 =?utf-8?B?NU1nN2h6KzVPaEVPcUtNc0pKWkJCbjl0WjlGMXNBcHgxeUVtdUZiSmx3S3lQ?=
 =?utf-8?B?N3I2Z2JvaXNGcWlZeFJoN2JNVXVrcHJ4SDNTVHZBVkJwNXhDR3crcE1yYnFW?=
 =?utf-8?B?bytoUHpLSzJtOGZFM0RlUkFzTFJ2Z2FCSWhCeU9pUFM5WlM5aVd1aXVickMz?=
 =?utf-8?B?dUk3VXJmWFN2RWQxNTN1dFp3QlZpVVpXNjZXUVJ4bU5kN0dIRmdsa29ZMDZP?=
 =?utf-8?B?YldRbjAwM1htTGxRVTJDNWJXK2FoN3dyTTZzdWtRTStCQWdIUUYxL1g2czcx?=
 =?utf-8?B?aTZjdXZ0Y1JDbzVKemI5Q1dsWmNhNjhjSVhUeUpZWm1HN3hKa0dVa1FuVFlP?=
 =?utf-8?B?bXY0ZXdqTGFDOGNKSlA1VFVJUmpzMGMrR3BnVE5NTzN0UHBEM2lOcENDdGdQ?=
 =?utf-8?B?QVZGQ3NZK0NMZlFRU3d0MkFPMG9oNk5zN1dRa3pUVzRYTDd4dXlpOEN2V3NH?=
 =?utf-8?B?Q2pLWXBkRjF6djlZd3k2eFB1RGVuUFVoV3U4bU5YNVRpMUZ3R05nSE1UU1Qr?=
 =?utf-8?B?V3VjaFYzVzF3YmwrM1YvZWFGclVTZXBySkQ1a1h3S2xiSE1rbUJJVUlNOFRR?=
 =?utf-8?B?Qkp5anYxWGgxampYaFVHTk40Sythc2ZXZHh3STVyRHMzb1llSW1RbG5YcHla?=
 =?utf-8?B?UFdVOVlaVFFDeEsxNWR5dVQ1ak8wcUM2NHpJNk84TGJUV2p1T1JxQWl3YTBk?=
 =?utf-8?B?NmVhOEl6bTlVM2dXdUhBbUZ1YUVmbTlKUGk5RFZsMU10Y2pUNGNhNVlvdnJq?=
 =?utf-8?B?UkNqL0lnVERic0l4eFNKMi8wM0Z5SVhkL1JDTExZMHdnQXdYOXNmMDA3UFBK?=
 =?utf-8?B?cFA5RW5mOU9qci85ZjBQa0NXQW5wcXVmcTVLTFBUVmVXMUdxa1d5NUM4djhm?=
 =?utf-8?B?alo4NnM0anozVXNsaUMzQUtwOCtzSjZIUmRZTmlqNE1nczBHN2RqOVV2M3p3?=
 =?utf-8?B?WDVoUWkwOEJVSjZ2MUZHM3ZTdWdDTHlWMDVuc3NIWDhuVnltcXVnT252UGRK?=
 =?utf-8?B?eGM1N1hubkk5UURZc0YxSVVaUnZsOE1ZeFJwZURsRHpBa29FT1BtczBkK2t0?=
 =?utf-8?B?MHl0dlhRbnJmZmhnazZ3b0RQYmYzQ3ZKbGtKcjVSeDcxUThwQWVoUk9MSmNa?=
 =?utf-8?B?aUxod2U5UEM2djNDVHVxcU5EU1J4SjRWWlc2aTQ2eDBzeUJCblhnb3U2a0I4?=
 =?utf-8?B?MHlGKzdTMERaMGlZQ2NmcTBSSkk5WWJGRThOa2Mzd0puSStxdHFyaWxMSXoz?=
 =?utf-8?B?bUxjOTh0bFpxWVBrLzFTWlpqN1owd01CdFkvLzdrTktsbG5idGFHS0hxZEx5?=
 =?utf-8?B?dStVb2czelhmYVlsZXNpZ3FhTXNZV01DcmJ4SmpiSXhBZ1JyaUhMY3ZVbHVn?=
 =?utf-8?B?MVQrMkpyUXZIMU0ycm84UUdualN4WlhSbjNMVnF6bHlvd0NyYnlObGZYc3U3?=
 =?utf-8?B?WG5xVE13d1graGtlOVJiVnFTZUNKTTFUNHFvUGIwRm1UUlNYUXAxdmhrOUF6?=
 =?utf-8?B?UjJXZ1h1S0VQMzhhdjBNcktRM3QxM29hcjMySXR2emtQcE16bklJYVErK3Nu?=
 =?utf-8?B?dkoyK0phazVIZElsTTdZUUlGdnV0Q2lkSittSndyZXRGbXNGVkEvVWhnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(7416005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFVzRnQwYUdDdnFKQnBpekgvRlI2NmQxR0hzbEZzeDQrWkVpblFYeDB4ckZT?=
 =?utf-8?B?WDg3NzI4eDNhYmYrRkVheHQ4OEx3aHRMdnJXckFzekxqMnZCbGFsWmphL0VN?=
 =?utf-8?B?N05Sd1laVWxIaUFwZFdiRThNZEU5S1FjVWtKTVYxazdJWUF4aXFDNW1QZDkv?=
 =?utf-8?B?Mm5DWDh1WmFGMnF4ZnFNN25ucGk3YkVCaHNEbEY4NGd6cGlJOHQ3VEk4VTRl?=
 =?utf-8?B?WHkrd3J1eVUza0JPWFNNWnZBeUUwRDUwU2U0WHk4aEpFY0kwaFo2QUs0SDg1?=
 =?utf-8?B?eE9kemYyNlhuTU1MUnBtQnV3ajkyQnBndVg1WnpSeldQWlNPRyttcC82OEhl?=
 =?utf-8?B?VzAwSHYvL3hYR25FcEhRMldQd01VQm5EMXFheklxWTdIdCtEdU53Zm9iNTgz?=
 =?utf-8?B?K2lJc1l6bHF3RlJtYnNwT0c1dGlaY1Z3WFRIYXpIOFkrWG9NSnN2elduQ3Jl?=
 =?utf-8?B?Ky9EM0ExN2pwK050Nzg0cmZGOUtSUWtpK1g1N3prTm5ldEsvN0E0ZWI5dGZ2?=
 =?utf-8?B?QTE5aitQSS9ta3NrSVRBSEtndnREOEFoM3puMFRzSmIrVmZuL1hOVUNvMmE4?=
 =?utf-8?B?bGlMUjUwbTN5eG5paDJZQkRreHErb01GZElOUDNvZE9JYWZHalpVWDg3cXJv?=
 =?utf-8?B?cnVoL3pCTDZtQWxzUFVqTjk2SzR5eGdDNmh1WVJ3N3FHaGhPWmo4bHFDOU81?=
 =?utf-8?B?R1lFRHNLVVVpMnlGbzg5ZXhtY0VSMlB2SnBKWXlzQlREWUF6K0s2cjV6V3Ew?=
 =?utf-8?B?dVF3YmxOd2paYTNvdTNvWFlkeDd6YUhiRnhHS2h1VFhTb0JGUmdoOUFEYlpy?=
 =?utf-8?B?SnovRjMyTmhtSUFySjdZRUtWTmVDek1CbmpaT0JuSnpaTmxpc3p2Vys5My90?=
 =?utf-8?B?R3lQenJ5cGI2aGc2OEI3c016MzQ0OVhySGs4WWI2MktVcjdoallVRlAyaTBQ?=
 =?utf-8?B?UWdpbGRoVHN1R2htbFhETVRyWXBaQmxqWnpWSDVNV0lHMUhHb3FDRzRpUUtZ?=
 =?utf-8?B?bmk5dHBYTkpRc0JhMHhuK3lzQ1M1WGQ0dXExNFh2OXBPV3JlOFQ0K0cwa3NN?=
 =?utf-8?B?VWV4MHpFWFRRQWRNNE5rVDlWM2svMzJsZUhOME9QM3VEbFR5SUFqYlpzbkx2?=
 =?utf-8?B?dXBFdmJoZXFmaVBJUUw4WkFmMnZuMnRnTkFHN1M5ZUdqVkZydWJJeXJUT0pp?=
 =?utf-8?B?Vm14WmxSOTZSTnk3UVd5QXBXa0pSUXN1RVJTTDNneTRaYnIxWjlhR3pjRytJ?=
 =?utf-8?B?MjJDK09DeGxNYXZ2emFndDA2UUhTaFM4NVozRXp6RExuZjNJaktWUTQyTFM5?=
 =?utf-8?B?Nm5kZDBDT0ZMVExKSk10QmNPb0g2SElxaTlVMkQ5bitXMWNaMmtiZWVWbnN0?=
 =?utf-8?B?MEhTT1JKKzY0ZkRGVGhSNnhlc3Fob3lRREVlYm5wYVhWVGp0TFEydDcrckNa?=
 =?utf-8?B?RFBydjhCMVo5elVnekczbWNYZHl3Mk1YQlRSYmhCcFVDanpPM3U5UXJUWmo3?=
 =?utf-8?B?L2lsVWZZU1Nhd0FReUNJQXdrb1ZsOXc5eUppWW0zV0psQkFjSy9vczZRUndW?=
 =?utf-8?B?T0xtVXRucExmcE4vNjZOWFQ1ckJJRHJaWDV0SlQrUnVWUk8rQTVHbnlQSEdG?=
 =?utf-8?B?MUpIMXNReFFYZURpejRIYmx0WjdCdEZHN1J1czBVeEdLYzZERlc1V2JhWWlV?=
 =?utf-8?B?aFZ5by8xV0Q2c1JPbisvc0llYTcySWN6Nm1COEczRVdNbnlUeUh0SGpBSFhV?=
 =?utf-8?B?U0pVM2IrWEJNZjN1WU9kQTdVWENYQ0dyUFFOeUdJWTFaZVhQWXNWV2I3K3Ey?=
 =?utf-8?B?OTNBTlJpZkpsNHJETUxIb0hhbVZnN2JtcWUraHFwRk9BczlFMGF1MzVmT2VB?=
 =?utf-8?B?ak1CcGpLOEJXNzMvUzRITFYxSUo2NUJkUVJiZk54elh1eS9jUmp4UGgyZysw?=
 =?utf-8?B?Z0txdjA5dC9pSnlwZU5HeDRvcUxaczA3QnNDMnkxVmcrYmthQTRBMEVhWmNP?=
 =?utf-8?B?UkRnd1kzTzBNdXNrNUJDdkRiRXk2MDdWVHF0K0ZScXh2Z0JBT1k2cjhRU0hS?=
 =?utf-8?B?Zll6RWh4cm13LzV1UmhFMEZyN1Arbmo3TlZvZ3dVR040dmN2K0RqZ0g2d2xa?=
 =?utf-8?B?cjNuVlNic296dEZNVWxzdzJvUFhYaTRKaWVHMWRyYmlHTWZtZzA4a3FCeUpn?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TtjkTR2FGBK5VopaGiFN4sf3x+hx4ivAeAWYRKl9L8hEeAdgIdrvScjXIMza32cw3806GM8Xj6YuQ98bW0IaB7xD23OikveJmNLty+PPrXLHpfmi8PUZDw3LLMqOudv6I70cg0Kq9N+830lJhvX8Nb7BR/iQ1n6hoYWFjgnzddjI6Mn2aVdSZjbJiTnXR550zmzGkZhpjWJYJhEM+fKrZ+m+mKw68hXXtn8YrpIqHtQ2rnECmvSAtr4iIl9T/u7ZXnPA7MM5JehqgPDMr/gVrXSpSfAXJwl3GWfCC3Cdk6Q7VEd6/QXttF8JkIsjy6BAioG8b+kuralwPOfGLYX/w0t/T+y/JIGsQiFBtV6d2nlpFhfQQ54HHdZ6lW7oMHSgmb7Bn8lQxJFnLnOHX0JAYtswgXSmrsx7S1V1j6i4sxwtMWYlnctE5NqYbRQtt8nPKBuF4iF3tP5xvgJmTEyzxISUICsO4/9RiZLx3rRXUT+VAp4Uvc08AEFYYbwHZ7sUcv5dVbbxsTQc5evcy/U81CdKlOF2W4lqUTDmiC72lBkWWRzk/ddGRP/n9ZPpXQyH+jivynLM6r1XgzGtRy3noRLHJonPhf6fCl4IQyWZUPs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b3f9a5-6709-48a4-f2b1-08dc80cb8ced
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 17:11:31.1863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOALN5X0ttzQ+u/TdBu5oSNsEuG7xfRAadPmiIbSB2M2Am9vNLBDB2BpXT4icwkwzcafYMHzHSqdXHoJlGb7iLKisKaW3/vZzW+obzV1KJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5195
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_13,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405300127
X-Proofpoint-GUID: xB769JUpYt19EUN4649Qt8wOXto7QOmW
X-Proofpoint-ORIG-GUID: xB769JUpYt19EUN4649Qt8wOXto7QOmW
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
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

On 5/29/2024 2:53 PM, Peter Xu wrote:
> On Wed, May 29, 2024 at 01:30:18PM -0400, Steven Sistare wrote:
>> How about a more general name for the type:
>>
>> migration/misc.h
>>      typedef char (MigrationId)[256];
> 
> How about qemu/typedefs.h?  Not sure whether it's applicable. Markus (in
> the loop) may have a better idea.
> 
> Meanwhile, s/MigrationID/IDString/?

typedefs.h has a different purpose; giving short names to types
defined in internal include files.

This id is specific to migration, so I still think its name should reflect
migration and it belongs in some include/migration/*.h file.

ramblocks and migration are already closely related.  There is nothing wrong
with including a migration header in ramblock.h so it can use a migration type.
We already have:
   include/hw/acpi/ich9_tco.h:#include "migration/vmstate.h"
   include/hw/display/ramfb.h:#include "migration/vmstate.h"
   include/hw/input/pl050.h:#include "migration/vmstate.h"
   include/hw/pci/shpc.h:#include "migration/vmstate.h"
   include/hw/virtio/virtio.h:#include "migration/vmstate.h"
   include/hw/hyperv/vmbus.h:#include "migration/vmstate.h"

The 256 byte magic length already appears in too many places, and my code
would add more occurrences, so I really think that abstracting this type
would be cleaner.

- Steve

>> exec/ramblock.h
>>      struct RAMBlock {
>>          MigrationId idstr;
>>
>> migration/savevm.c
>>      typedef struct CompatEntry {
>>          MigrationId idstr;
>>
>>      typedef struct SaveStateEntry {
>>          MigrationId idstr;
>>
>>
>> - Steve
>>
> 

