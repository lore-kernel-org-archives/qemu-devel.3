Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587A6CD13CF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 12:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slSGo-0001uh-5d; Tue, 03 Sep 2024 08:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <euan.turner@nutanix.com>)
 id 1slSGn-0001qC-0S
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 08:04:25 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <euan.turner@nutanix.com>)
 id 1slSGj-0001t9-ND
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 08:04:24 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 482KZSa5030184;
 Tue, 3 Sep 2024 03:45:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ArbypFHFiUAnQnswcJN+vW8wZq2ETN5NgEwCqbyZD
 dA=; b=EWEfo4bHtPhsFcBsmba6keWbgyYQvK279Ig9eZIYC6PAZJ/J/wTDsGQfE
 NMfjXS1z5hJxKLp6gWCcWwBGvPivLZPcHTxlLfmDkSD6o4+Kx8r25L+AQtZWgE2T
 qh+OgoV1xJZSsB2Es8QRdp0f/2Fv1246MaKy8fM6n25lC3gddil0V8Ue3gDjmY0o
 uv/qT6K9h3nFEyKxYhqjDos/2JVUTzCiV3/VyzI2Wz+8em2tGOztoEa86nKUydk7
 yQZBmdMI7tcW2i4lsH252lfGrboQumcSDrBF+C2K+9TwYVu0hOGKGFaagP87+LYP
 GDSRO/qOR7IpQDSJcZvrh0eHlvS8Q==
Received: from cy4pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17010004.outbound.protection.outlook.com [40.93.6.4])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 41c28g562b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Sep 2024 03:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItCU4Hkz4wku+NeWQe5Os0011UGbMFnhZLGYPJsEdHAm2YvbOT/uv00OWP9tPpu1cIKXgvF2fJ/EiIE7Xt3srkckPlXEgxswFDFoptL2oR3E1lvwYNNz4Gv1ztWuJyXsORoexZ0xC5g5sYWSYaqsLE+dX8mv4UdNy27o57oTyAAgjUT3k31I8O1RyH8wVlSxEtLns2nCZ+LFhgMuig00htMUIuWowAqhQuSGdJ0HyNwwOEzxg7Wu9OuLkgmL2f69SqvLCVFzIPUEaAjKYn1tDNy/HjFgYAhX6Wbt+EHoLWYuX562slPL/35h3LWpRI11vmM7QO3R1J6vccZXB8/VZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArbypFHFiUAnQnswcJN+vW8wZq2ETN5NgEwCqbyZDdA=;
 b=gjaw3G11eXHOpy3SdxrSDPhiVyIRCIjy0D8Kv7B7B58oyoe81A79w/uY3ikyjQONdEFeSPAk2Ox79SRqwoTx4uBhqWPnepXBTaRE/eGckGx2FAPdD7ysRpBYxp2tKGtqsIVzcivWgpJ9f5WarApshzJ9ZUj6PrCWbWxmXOG7O5oq8m81FwIdoDF4oZlc6c14E3cIP5lmbJ8thYBs9asZQYDiqFknDRFob09Dvs85YWABV/XlYLHUJ/oM7KbXGUy2xtmRVf68/AeLotZ9am/u92Tn4F6tdUkltnRyVwACdMvkmht77hzRgNJh1rUabt5FsOjLLSSqWMwhtbQBayjQjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArbypFHFiUAnQnswcJN+vW8wZq2ETN5NgEwCqbyZDdA=;
 b=q0o4HeSAdsIGEiE9scSXiYE6vhMcY9cvBfXTtkt1V1zfVZUBq5y0YP7IAs9BU8qPXvqPEot/kfCAtAvA9GYXMmbXCHH2S9f/K0KnhWIpRpDSAVHDg7V/3nOUVIOAN0DhXinnnyChFBVEAJIb/21ekYpZEs8Fq+2LwRZMESMj2fNd9MzCXd93HEoMdGzeJARgT8+YvLhJ/pObEqg+cD37lv2kUYAeT89SrfGuZ6DbsmtfOmrWNGRJ/ElWPrh77FIjYUh8ft+bYBjff951YBuja7LKQOR97bJNE+CY+FgXSi8UOw7xVal8ezArPg+doyP6ob19ip42lx0A8R/1CUXkhA==
Received: from BY5PR02MB6471.namprd02.prod.outlook.com (2603:10b6:a03:1c5::9)
 by SJ0PR02MB8814.namprd02.prod.outlook.com (2603:10b6:a03:3d0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 10:45:00 +0000
Received: from BY5PR02MB6471.namprd02.prod.outlook.com
 ([fe80::946:8127:2e60:518]) by BY5PR02MB6471.namprd02.prod.outlook.com
 ([fe80::946:8127:2e60:518%3]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 10:44:59 +0000
Message-ID: <c7eaca75-1824-4f46-af97-9905c2a214ba@nutanix.com>
Date: Tue, 3 Sep 2024 11:44:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 1/6] Revert "vhost-backend: remove
 vhost_kernel_reset_device()"
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1725018997-363706-1-git-send-email-steven.sistare@oracle.com>
 <1725018997-363706-2-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Euan Turner <euan.turner@nutanix.com>
In-Reply-To: <1725018997-363706-2-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0084.eurprd03.prod.outlook.com
 (2603:10a6:208:69::25) To BY5PR02MB6471.namprd02.prod.outlook.com
 (2603:10b6:a03:1c5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR02MB6471:EE_|SJ0PR02MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ef3972-4dff-4176-5e0b-08dccc057538
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVg2RWFvY0JGVkltYXJWWkJXaXoyWHU2SFlFcnVqUnFzbWc4NkZaaTNBMzlV?=
 =?utf-8?B?bzFsY0tMWlB0OW01N1VMRHB4VWl4SlJxd2szNDFjKzMvcjV5YXpvUFBWWTV3?=
 =?utf-8?B?ZzhOMjRaU1JpYUJnQnN5cWFiY283ZVk5TWhnemhaNzNKV3BjR1RtaGJldlMv?=
 =?utf-8?B?UnIxSmdET0pLcDE3QXhxT3ZlVkNwS2hxYnoyYXI0UkpBL1N1UW1qazhqN1FH?=
 =?utf-8?B?RHZZK1U1Nnplblk0R1lZS2hDOHVFTkcwVFhuM1pXUjh4dkNubnlJcFRjblhs?=
 =?utf-8?B?czNROCthU1BxdkFodFlVeXFkN3J1a081UDFnQ1hOczM2QjJBT2tMV3dwOU1s?=
 =?utf-8?B?dHNUd0l3RHpCVjBlZVJXZURtVzBRQkZtNWRLdGVLWWxPUlR1ZldzRW96UGl2?=
 =?utf-8?B?SU1NdmNPazQrMkNUSUtkU2ZONXRmdzVqVmNETzN0ZFVrQ09Fc0RnbGhOLzhW?=
 =?utf-8?B?MFZ1MFNhQjFjeWhWSkZkS2xJRFFPcURORHFONUFPbkc4RTNwdUNWSEZPRXk0?=
 =?utf-8?B?Y2VISTJRTXRRYUhQTG9JMXdESDBDNnJDaVRhdGNuKzNYSHJ0TW1pNVg4cEpr?=
 =?utf-8?B?bjJRa0FPMXFDZGZ0QzlnUWJsT1JNQTQyVEQyemx0bTNtVTlncy9oTHU5RDEz?=
 =?utf-8?B?d2wxK2pkN1ppRzlyeFNJQ2hZK0N1MnIvUTNVQ1E1QzRicFBSRWEvNTRmblc0?=
 =?utf-8?B?eU13a2EwdFByQjVmbjVTZHpmRWhHdkNucnpLRnpIdjdvK2xOSUhYSHBiV0Y2?=
 =?utf-8?B?dWYvaVRBeTBGSXQ5ekdrc0dqMUp0VitKNzRTSXJMTWJDR2xwbU5xSE03ZmRJ?=
 =?utf-8?B?clFvZW93b0ErMWlCWVpNdGRJOGlSVWMyT0cvZE5WQWxCcEJxTDBWM1NqWFVl?=
 =?utf-8?B?WTZwSVBzVmlwdDYrOTZrMDJjMGFueVBGT2NhWGVZVzE3QTNZT3d2d3d2c00v?=
 =?utf-8?B?WDJaUk1WcjV6VUlhamhkV2hyYk5BbkZDeXdGVS80bTJOZDdMVi83MGYzUGRT?=
 =?utf-8?B?RnVCdXNnK0gwYTFnOTFUN0g1Qi9lTEQwckFjRVgxWU41UHE5S0RXS3VyWk9x?=
 =?utf-8?B?MG8zSlQrQWhmOGhqMGtwczU4dERTUWZzelRJOVJTTGVZWWlBMTNTQ1g4MTdC?=
 =?utf-8?B?WEU3SFFpSzVrQkVQQzkzbmJhWnBzL09RU0pOMmsxeEs0cWpyUE1US0ZGRGJu?=
 =?utf-8?B?UmwvbE03NWZUWDlGSkUydnVsUDZNWldWY0xIako3TFl1aEVEMWloQWtuMlhX?=
 =?utf-8?B?UFdJbytrTzNYN0FjMlAwLytFNmhoQkFqb0hxbEtzb05pMDlUU0NCbHplSnpK?=
 =?utf-8?B?aTdXdTB4WmtPSXI2YnZDMWxlRTVmTE1tSHQ4NmxZSmFnTUZld21CQ21PVlBv?=
 =?utf-8?B?VjlNbUlEcnJFcjhwYXZqRENRRTBzZVNUeS85SmNZSDFZVnJBanZncU1Cdm9D?=
 =?utf-8?B?c2Nwa3FhOXNnT0VFZ0krUkNNSEdCYS91Q1ViL1ZBNWlSdmxFUHZSUW83b3ho?=
 =?utf-8?B?bE5FRGEwVElwVVF3MGdFMHhIRi9WVmk3VUpnSkJDVDR4aThTU1ZOeHEwcG9I?=
 =?utf-8?B?endHYklJRDVOZjl0a1ZPWnFSOE5wclQvQVp2Z1p5dVJJdnlBTFp5ZG51VDZ3?=
 =?utf-8?B?YkJMcVdxZGhnTlNidTBoRlhXTDA3aXJENUJCR21nZElyUVJtWG9IcWR4TklF?=
 =?utf-8?B?UkpnYW1jd2JWY0xVL0tUSDFpUThjYVBMNXJhVWtjSVpqWGpqS3F2N29tc3BY?=
 =?utf-8?B?OUxqamx4OVBnaWpXT2c1SVdnRUJvLzF4L1NDR1Q4dHc0dU5qaWoyWkNiaDJz?=
 =?utf-8?B?M05uZk5GMktXZWJheVNNQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6471.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmhMMWZJcDQxZlFsZzBqSmVqUmVyZHQza2lTcFVOd2RQUGNyY1lIdGxZU0xV?=
 =?utf-8?B?YmlHZ2ZhUW0xUmkyTGJENE1qbTlmaGRBRGN5OTV6eUxqV3hsTWdZTHorSzZp?=
 =?utf-8?B?aHpLRTdzOWtXRVlhbFFiNjdMakxrVldRbkp5WjdITnN0TlhIOHkyT0FKa3Bs?=
 =?utf-8?B?bUIxTFdtR25EZVdkV0NmWHVLUTdTdE43SUozQUpLVkxCZ2dMdDBnTG5yOFZt?=
 =?utf-8?B?a1BxakZRV1NlVExCZll2SmJwTEJiSTlMMnhRcWZpOWxBOGQ5ZFRoMDhZWENv?=
 =?utf-8?B?MUgwZzFOM3F6WTF3a2dEMGdKZXZ2L0RVTkt5a2RuTjNFcmhtRkQ2eVkzaFQx?=
 =?utf-8?B?Sk9tTkY5c3FXQVJmRUxmSGt3czZMVHl0bDBvVC9HZTcramhVWkp3U0VaT25N?=
 =?utf-8?B?SndBVWdmUm9wT1VFTEIrTWpwOHpZN2RnMWV2WC9FMU15cDY4eFl3MFE3VGkw?=
 =?utf-8?B?MFIxVEdHdUFVT3BDd2sra3p3MVZ5QkJzL2FGS0tPb2ZqazRsQ1RZMnNhMXl1?=
 =?utf-8?B?Z2F4TDNjMTNJNFEwS1NvT3lOWHFwd0FOejJUT3VQZEdxUVJwZUhNQUZPY3ZU?=
 =?utf-8?B?RTcyclFjanUvWDlaaFExMWl5OVdCd3FydEM5bGQ3bHBRNDdLWk1JSXpvQnBI?=
 =?utf-8?B?YmZjS0lGbHNQSnFDUkdKK3VRNTFjNHNxNzNTQjZveE1sTGRJdU1yd1RhUi9I?=
 =?utf-8?B?MzQrSHcydm1PY2RWbFhVaTQ0MkQxOGg3OFUzTkd0OUtGTXdpQzNqL21HQWwy?=
 =?utf-8?B?cWduVVoxOVBtc2hoRFJjUHVGZS8waGtld3c4clhza0wrZ3ZVeWNQVjBxd25L?=
 =?utf-8?B?emVMaWxQVUVEM3M5Ny93THk4YjBSYlBqbU9GZzhERG9FcjFZWTAzRkdKNHZ5?=
 =?utf-8?B?aE8vKzAyaVYzRmcvY29YRUx0K0RYZ3B4c2hyL3gyRkRBVWh0NHFEeUdFbUlu?=
 =?utf-8?B?bnN0SDFvWVFiSmZnWDRzMkltK2FSQnIwb2lHQXIwN1gvaXJrTFdiaTEvUm5E?=
 =?utf-8?B?QWhiamxyNk1WQ3pKNjhKaE5tVVk0WG1lOXBmamlkOXFjTld0Y1VSeUxzaDB3?=
 =?utf-8?B?WmNWcWZpQ0RWb0s1cEpjRmZSdjFPUUtTNll6eFlDODNiQlBPNWpXZjJtMGN4?=
 =?utf-8?B?WlMyVEM1VjNqSWVxR0RlRGVudFdrUVRIUTdSRy9xV2xGcEorTTJaSzd2K0ZS?=
 =?utf-8?B?Ujg0Z0NDWFNLZEpYMTYyMDVVc093Y05wQkdBSHRZRk52T0d4aDJYY1l2Q1Fl?=
 =?utf-8?B?N0l0azlDRXZTSEFGaVdLbEkwSDFTUkxTMERleFVJNXpLYmJ4anJ3aDhqQ1NX?=
 =?utf-8?B?RGVQT3Fhc1NYYkM0ODF1dmhZKzhSb3R4YUtIRWNDM1hCZXI0WHJMQldGVit5?=
 =?utf-8?B?MHRlYUdBRGg1V1QycE41OTdSMDgwRHdCakQyVUMyWmpWdUVjSzN4eXpyREg4?=
 =?utf-8?B?N0w4S21IUmt1V29vNXJVdmtHbUwzOWdwLy9XVVBFcmJxM0NwZnZRSGpxUE9G?=
 =?utf-8?B?Q3k3NlZ1bGFMdXE4NC9qQkRwT3BlcXl5eWszOWkyVDVKaWFMSHc5dWx0R3ZK?=
 =?utf-8?B?Q3lJYUZiWU5aQmwzZnhQQVBUYXc2MW9rbXFpTGMwTENYUE5tbnB6cGtGQU5S?=
 =?utf-8?B?SWRsSVB6cHN1RnFkSHZ6YkljQWg4bmdyWFhSWHRCMXQvM2cvMWtZWmZBNGtn?=
 =?utf-8?B?T0tra2tPTU9CcmtEaXEwU1pzczRxaWkrWGF0S0wyNnRkUHkxckw4c1BXaFBa?=
 =?utf-8?B?N2tTS0svR2dzTUkvNm91VWMzMUR1YU5vMFlOZHk3Y2dHQU1nNVg2eFVyQzQz?=
 =?utf-8?B?aEdVQUZWa3ZUVUJqQlJMVlJTUUVxZTBvU01zb0xlYW1LMG1VcHRDTmVyY0di?=
 =?utf-8?B?Si85NDBhVWhSNko3SEYzVjZ5VlJKZUErdUh6SWN2NEhsYUZEUVdCT3l6eW1q?=
 =?utf-8?B?VjFMOGV4L1QxVjl6MWdVcExIVHAzM0dSRUpWWUhNcExWVFQ3bXhSdjF2TmlF?=
 =?utf-8?B?TkFTNWdLUjdLVFp1QjNHT0YvZXFRS0VYMnp0Y0xWYjQrcWoyaVNlalBkWGdT?=
 =?utf-8?B?b0ZPUng1eFovb0NvaTFac3B1T0Y1Zk0yekE1K3JoclVLZUsxQ1ZPN081OVdV?=
 =?utf-8?B?ait5bEJsM05YTXZEK2twY0ZjZ2ZlRlA0d2tZeVBxcE1wTWxoR1UvVXN6MWpy?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ef3972-4dff-4176-5e0b-08dccc057538
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6471.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 10:44:59.5604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCye4XA0oHDIssSi2tIr91mDz1dHfq+OCgpLHfRSKE/xqBU15D6OYkWpG3kXwR430LYe66y6X2nG+AYusEsKhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8814
X-Proofpoint-GUID: GP06Fr-uSFYZanTyfHvVwc_sAdK9nDUo
X-Authority-Analysis: v=2.4 cv=AarjHGXG c=1 sm=1 tr=0 ts=66d6e8ad cx=c_pps
 a=YCJezUkNvC3bKg1Ra8oh3A==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=0034W8JfsZAA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=OyfZveX1o0dVdJGNYKkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GP06Fr-uSFYZanTyfHvVwc_sAdK9nDUo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=euan.turner@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Steve,

On 30/08/2024 12:56, Steve Sistare wrote:
> This reverts commit e6383293eb01928692047e617665a742cca87e23.
> The reset function is needed for CPR.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/virtio/vhost-backend.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> index 833804d..9b75141 100644
> --- a/hw/virtio/vhost-backend.c
> +++ b/hw/virtio/vhost-backend.c
> @@ -221,6 +221,11 @@ static int vhost_kernel_set_owner(struct vhost_dev *dev)
>       return vhost_kernel_call(dev, VHOST_SET_OWNER, NULL);
>   }
>   
> +static int vhost_kernel_reset_device(struct vhost_dev *dev)
> +{
> +    return vhost_kernel_call(dev, VHOST_RESET_OWNER, NULL);
> +}
> +
How does this series avoid falling foul of 
c0c4f147291f37765a5275aa24c3e1195468903b (which follows the commit 
reverted here)?

I've been playing around with this patch series a bit, in the context of 
cpr-transfer, and am seeing the issues highlighted in that c0c4... 
commit message:
Since vhost-kernel now has a reset_device, this is called in 
virtio_reset as part of qemu_machine_creation_done. (I have the full 
backtrace if it's helpful). Subsequent ioctls then fail (with ownership 
errors) due to the RESET_OWNER:

2024-09-02T15:40:56.860541Z qemu-kvm: vhost_set_vring_call failed 1
2024-09-02T15:40:56.860908Z qemu-kvm: vhost_set_vring_call failed 1
2024-09-02T15:40:56.861253Z qemu-kvm: vhost_set_mem_table failed: 
Operation not permitted (1)
2024-09-02T15:40:56.861586Z qemu-kvm: vhost_set_vring_call failed 1
2024-09-02T15:40:56.861831Z qemu-kvm: vhost_set_vring_call failed 1
2024-09-02T15:40:56.862199Z qemu-kvm: unable to start vhost net: 1: 
falling back on userspace virtio

For me the NIC then fails during the migration, although the migration 
as a whole appears to succeed. (At least, prior the the migration, I 
could ssh into the VM and ping out to 8.8.8.8, but then I lose the ssh 
connection during the migration, and cannot ssh back in again afterwards 
on the new QEMU).

Do you think this could be because of QEMU falling back from the vhost 
backend to use virtio?

It may be down to some misconfiguration on my part, here's the netdev 
command line I had for reference:
On the source QEMU:

-netdev 
'{"type":"tap","fd":"39","vhost":true,"vhostfd":"40","id":"hostua-43bc0eaf-ff55-44e6-87ec-a4798f592db1"}' 
\
-device 
'{"driver":"virtio-net-pci","rx_queue_size":256,"netdev":"hostua-43bc0eaf-ff55-44e6-87ec-a4798f592db1","id":"ua-43bc0eaf-ff55-44e6-87ec-a4798f592db1","mac":"50:6b:8d:0c:03:e0","bus":"pci.1","addr":"0x0"}' 
\

On the destination QEMU:
-netdev 
'{"type":"tap","fd":"-1","vhostfd":"-1","id":"hostua-43bc0eaf-ff55-44e6-87ec-a4798f592db1"}' 
\
-device 
'{"driver":"virtio-net-pci","rx_queue_size":256,"netdev":"hostua-43bc0eaf-ff55-44e6-87ec-a4798f592db1","id":"ua-43bc0eaf-ff55-44e6-87ec-a4798f592db1","mac":"50:6b:8d:0c:03:e0","bus":"pci.1","addr":"0x0"}' 
\

>   static int vhost_kernel_get_vq_index(struct vhost_dev *dev, int idx)
>   {
>       assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
> @@ -345,6 +350,7 @@ const VhostOps kernel_ops = {
>           .vhost_get_features = vhost_kernel_get_features,
>           .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
>           .vhost_set_owner = vhost_kernel_set_owner,
> +        .vhost_reset_device = vhost_kernel_reset_device,
>           .vhost_get_vq_index = vhost_kernel_get_vq_index,
>           .vhost_vsock_set_guest_cid = vhost_kernel_vsock_set_guest_cid,
>           .vhost_vsock_set_running = vhost_kernel_vsock_set_running,

Thanks,
Euan


