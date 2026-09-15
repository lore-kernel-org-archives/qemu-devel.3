Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C59C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6RAg-00066K-HE; Tue, 15 Sep 2026 07:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1x6RAV-00065x-09
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:17:43 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1x6RAT-0000k0-1d
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:17:42 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68F9fJ2E3329119; Tue, 15 Sep 2026 04:17:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=RkvNFDips/3IUDWrUGIShaVeeHrmWVnyI9N8jrOmr
 ww=; b=GCEqlQYtyRKTHp1rjQ5mvoRE6T9JDooxlLBtDyNXe/JEnv0Qm4/uHjjBL
 1zWm1ai+dIt5ZzdP2usDrJC6G2GpQvxvUWTfnV1lJ5B4m7xoWEiCRZsNQrSYPYRA
 lMZsmACegT8FvJQLCoNaPLPIhYF9z5gCi0BiOAT/ohkzuslVkUIlaFoExucb/lKP
 RJVj+O/utooYFQY/w51YxHlvEHQPRFZ/S0on14fW1tIvuGPFF+674I4G7ITyFmNd
 7qGFqQWa52i0vVjQmrhFQ7AHkrEbpWh1UI4D5VXuTVOtzUTBnpN5MHU8/Xl/Lgdu
 xg+LeRNFRrTUT8DfubacwH0/X/GcA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022099.outbound.protection.outlook.com
 [40.93.195.99])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gn2n3e09v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2026 04:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQcGgkxXfFXwvq490U0OO90GyRaHz1CpWm427MMWYrUKh0HZ55NhjF0i8Fqf5b5cIttQpmnTDgtdrLrBGWSw5djj1Z8C5FJQf8hi/k6ir23cpjzpt3xdyQ/6Teo9wLjZ2GrIcTLK1qdBwSNnM63fjlUoN74BBuc3c9QUREznaJoi8pLqu3F7HX7omCq2Zbi95rjDcI5M9cYabNhp+5seKOymwMcyb4uD3eK3yYpnLtvfEGp19WMyI2EeyfFWLMIWx4JX2v54Svn7ePreVj+md1r9VZitbtuaxK0bu0f1a3T/k+JoTL54nC3GQ8qZ4WPBSDGbFK6tGpGoGZYNwaXksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkvNFDips/3IUDWrUGIShaVeeHrmWVnyI9N8jrOmrww=;
 b=qRk45IoJJa9F1LvlqVJtwCHTMPlLv4UGZdOCj27kP10yXVx3Cdj64JQmEOdQXM1PzwnPSmOFaD4tfFB6uZV9dgmWiSHaFub7a4UD/HpjLO4gdJC3FcgvHbjVSgDMnaKhYVdBzvQec5DDWLkgrnVDJW8Xvr8DY0L7lTn0B35OT8jG3/SyHXjuhNJIjD3m1T0mWj8TkgbFmNfGGs7kfn/+gocu9U6+HunMmWuHbAb8ON1NlXbFYE9Hfu6smqw49JtVs28a12LB2NuvXAqHTAv8CDKpB8mJmYa2PbsDbvbW0SzIyjH3wcGPEJaKW3MTgdnQG4G19lzJK3GpWa+8gLp0Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkvNFDips/3IUDWrUGIShaVeeHrmWVnyI9N8jrOmrww=;
 b=yXAVeqJNl6VFysoD8NE66PQg6VKN56X0NET1JXCau3rFZ1ZTT04TrFKna/02XQZjTiJtxRlMwooybmdFZqpu5/woENQe/QhlEYizOf9t9rWpaEWhFDAF5O0Ou2zzYOa/cagzWxAlOy/zMAk1gnzioiqD9cmq5NQXsSwU/+moZS7AqYg0v+PfAFu6Cl42YeV0P0sXWGP+bx0C0XyqMBXA2X39NsbgTlXBfdL5FqPusnyFfS/V+0F6o6oi1Qm+Lg8FWnz2zqaw4/Vz5+R02xaBILcOwBRj3ks9C3Hf2JfxXMSgokKU+dvdzScM4XFBrePqva5vunAaZOnIVsgHkvyF/w==
Received: from SA1PR02MB8368.namprd02.prod.outlook.com (2603:10b6:806:1f3::18)
 by BL1PR02MB793570.namprd02.prod.outlook.com (2603:10b6:208:242::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 11:17:34 +0000
Received: from SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2]) by SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 11:17:34 +0000
Message-ID: <81c899d9-a9fb-4eb2-ad85-7dde2f626646@nutanix.com>
Date: Tue, 15 Sep 2026 12:17:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/pci-bridge: Add x-speed and x-width properties to
 xio3130 ports
To: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260915072507.1230187-1-clg@redhat.com>
 <20260915060015-mutt-send-email-mst@kernel.org>
Content-Language: en-GB
From: David Vrabel <david.vrabel@nutanix.com>
In-Reply-To: <20260915060015-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO0P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::9) To SA1PR02MB8368.namprd02.prod.outlook.com
 (2603:10b6:806:1f3::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR02MB8368:EE_|BL1PR02MB793570:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d36c6d5-a215-4574-8e0b-08df131af111
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|5023799004|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uJZaq6Xyxi7CAreXC/t9MvdICgQba3z7U1yUvlWmSyU5qkFaau3icCCHD8pAQQ+L4zJaty4HQoDUh/Va3EOshqnME+q2CAP16fES1rQxGM++rzksGCH+pSLu8oYyK+dvWqN4DWN7yE7q7qIBnC8vjzgf8KOqdvdMMMfcLF/sgUB/Kt8VyfMOPAmO90nVBMbY20cOc62ugTdu+1iei11oOGlFck+ys2x8lZFv2Lu5XcAAxqOCs48FZzSr2GN9B1BR6kQTdr2aCDl7hhgxps+FwnHlW1er4kgiF/GOZ4syjK5hCPA6WNdafUuhVS7CM2GPeVAJjAAYDLaYls2WTT+imBnNKVILG8Z5SBxgNHge1ZDPCIxfZSY/b7e7+COn/0Ip1XmaQv5XPEY4C9rU4zOjPZbyViKv2isRmAH1lW1ufkccZxDMf3gp3Iy9KhsTQHTshf8UTjAHu7nc8Li0AxIjnL/yt8CxsmCljLqV/L4zLrT2rjEQj6HU3fG4e0eHgOWnHhAxPs3Toiu2CgQ7IvRqnMekhfDib/W7t0IPQUbXfjZ7sW+1O3S8MswBgcxEm6mYJtSLj2Hw7vld62eeKe9Qq7uyis1SqwGb+9viwmEdY5z9dVZlQKP9ZRbPButtOWwz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR02MB8368.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(5023799004)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEdaMjdEbjB1ZEN5NXlLU2ZrcWh1cFc4WGxjYi9KRDFacEdETGVGcmgzWW9s?=
 =?utf-8?B?SGRMM0Z3U0VzSkhnMjlUNUZzNlVnZk9zS0hSYnRaVGJhVlI2TnYwaWRhVTd2?=
 =?utf-8?B?ekl3YTZHVk1ydUYyQzBTNFpPMG5YVTdKcGdWajVHcTFnaW4zZ2hSRnBOT21F?=
 =?utf-8?B?YWVnTHkwK0owNURaZFpJRDl4bjYwU1cvSmpMS2JqSTlMUzlsNHFKenI4WkNa?=
 =?utf-8?B?VlVUZFUzeWRpamtDNGVZbmZmZVpubFMyLzV2TU5uWm1JRlY5ZDJzVVdhaGFI?=
 =?utf-8?B?ZWtlQlJZL3NSQTllTHBxVk8vbFIrOTgvZEk0b3JqV21VUmJNZDd3OXhMYmFx?=
 =?utf-8?B?SzFzQ1RHYWZ4WkM3Um1aTEo0aC8vZWIzVW00L0txYlRmUEY4QmRBdUJLcHlp?=
 =?utf-8?B?VG9KV2hEczJ3MTRZMUpvNXd1U3BhTnEwTzl1WG9UY3JqTEUxR0tJUmtHbzBn?=
 =?utf-8?B?cWg5b3NjTGZHK1RrNmhpRHhlK1FhVnB2K1RoVHVVZnRXM3Nxc2Y2WHY3Rm5u?=
 =?utf-8?B?eXJiSngybHhuVGtjZERUcSt4ckJMb3pabStaYzRnT0ZBOVp5VEgrS3l5VGtj?=
 =?utf-8?B?YmtUNjRaMEFsaXhtdVFySnFONDlTM2VlQjE1Wk5GMWk1bDJIRUhqVng5NTJO?=
 =?utf-8?B?d2Z4MXcxOWo0RFNKYlVIdFJsbEI1VjZNU3VxZHQ2S0xNeC83aDdEek8vWnZZ?=
 =?utf-8?B?KzhoblpGLzBHQkY3c0Vpc0FWRmRDQ0hpbk1meGNhcmEvdVZZaXVnUzExSm1x?=
 =?utf-8?B?c2tBeDBHRThTUjNtbWVtWTJCWjVPT2gyTWllb2lJekNzejZ5c0RFemZyYm84?=
 =?utf-8?B?R3p0aGNLcUd5YkhLRm5GOFFwR1puNGZuOW5iZGRwYXRVaU9PL1orMWFlbjJH?=
 =?utf-8?B?Q1VRblVmV2VlQ1N0UVIwcGdFT0trcThZTCtZYVF2bWJKSCtTaWRCb1V1WnlF?=
 =?utf-8?B?dDREQ2ZmdmRMVGVsVVIxR081RE5pU1Q2eVorNE8wVTZrOS95V2VjYU9vUnBs?=
 =?utf-8?B?Z3ljbUdqZUczV3BGK1VtK3ZBWTUxWUxTenlLcExaNWJjNzhJTG5iUk5DOVFI?=
 =?utf-8?B?K0VzUTJXWEZNL2pNdHJ3Q2p2Mk81bko2bjd2MkZwcDZ3Z2VYNmxEWG1PTTlI?=
 =?utf-8?B?MjhvZzU1RDN6eGpYRk5vK3BqZm9STG95MFpuemJ0MG5HOElQb2M5bXF4Wmkw?=
 =?utf-8?B?UzVqZnlkYzFud3ZuUGt5bVhxOWJ3Sllvdk1SMExvU2c2cWtmZ3dEYjZ1dHdO?=
 =?utf-8?B?OWMrTHZpVlJHNG1YeUpleDNwUnZydFNGS0ZMMVRSdlQ5ZGxacStjQUw5SXMy?=
 =?utf-8?B?bU5TYTB1cDVxa0Vab1R0N1dNL1hiNUJtUW5Pd2R6Vld1ZWNwSUk3UWxNODMv?=
 =?utf-8?B?enlhWWdOeXJSeld1VVFUakMybkhCR3U4QkhpM3RsbEo2dFhqTTdqOGUrTWls?=
 =?utf-8?B?M1MxdFQ1VklpQ2pkQTdQYWdLSWs2SFNHOUFET0loaElZVnEzeFJMc0dVWGVW?=
 =?utf-8?B?dC9LN1lxZ3MyWXNyUW5oRkhNUXBDcDBRU3U2VWRNc2pMUi9WZk9BbWtndTNt?=
 =?utf-8?B?b0xvNnhXZk16WmtzTGtQOEg4QStkK1FyTTh0ZTU1TWN3NmhaalF4OUlQK0NN?=
 =?utf-8?B?cFVyVExFVmN1czBYVG1RbVJSejA5Tnd4UU9WK0c1cEI1d3FmTk1rTVVuc3ZI?=
 =?utf-8?B?RDh1eXhtaDBnRURlQXFHVlNYanhpTHk2NTJ4clZ1dWRjSFQzODBFTk5DVzJr?=
 =?utf-8?B?VHVrTFdMbHByd2VKQ3ZoQTVxMC9YYm1JOXQxOXVjWWQ1bFNPM1RIQnFUME1O?=
 =?utf-8?B?TXNNRmdvS0lKQVQ5Rzl2OEF4WUJZV3dhTm03M2RRcTRVVUl4VWRHY0ZLQWJq?=
 =?utf-8?B?bmF0bmNKcDhDamNTWDdWbUlZaTM5UitoNHlsWkRjdSs3RTdiS3dUeEhUcENw?=
 =?utf-8?B?NFJ5L3JLajE4VDMvMGJKKzg4d3I1SU43enZxMGo4RW5KSkdVR2d4REpyekRN?=
 =?utf-8?B?SUhFL1crZHZwNHkvMUU5dDhaMGZKcHpPak5WR05IVWxETTZsZ0d0UlZtWWMr?=
 =?utf-8?B?b3hacTNIMXZhalZtSFVBZVJXWlhVWW5meVdxOWVVVVUyNjdpSjQ0VHEyUjdG?=
 =?utf-8?B?eDgyV1pOemROR0N3RkRWNUpiMGwveDhvTkhyUFo0QjhrNjNTV2V5NkdOQ05k?=
 =?utf-8?B?Z0I3T0lTUzh4NG8xbm9xejJZUjlxYS9CdjBLWVZ3NzBRRyt3eGtiNitRWDRP?=
 =?utf-8?B?b2R2b2MwRXlSZEFWOHJuVnFSUndHVUV0NldKZFpVYjlWYy9qM0ppRHh1cFhq?=
 =?utf-8?B?UlFIWll2ZHJsN3o5L1U2K0dlOU9yUVRnTUhEWmdRVG5NdnlRYlBzQT09?=
X-Exchange-RoutingPolicyChecked: 5yvHIvBbYqOUMyVNFvobXhrMy+lkYGdIlwXkDzKNj5/5Qvp5RbcQLYpN/obJGR5aU5DYN+6g/8u0cEzwKqaFNW9wEt76pBHk3/NTPFGnm6VXGi2LJyHk5EKpgAvtWLzl6+62Ec4TDq1G+bXlUB9sS1CDCVaw/4s5RTXfW0GAmlvreoA10vhWYPDB50QOoMUDIsTK+JASClLIB7M2MPpSgxcT5cH6AAyc7Z/GekH1sza3aQ4jgD7ll4ea77xScr5lLorkkcJeQuwJLKGWb9qsjwr6BdOZYc6QQabDH2J6M0hIGZJMbYK+GpuLa2VuOzYptQg2EVj4dR5PjyBBHC8JnQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d36c6d5-a215-4574-8e0b-08df131af111
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 11:17:34.6448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gx2Os3l/x/hoBcjLTJ2OOTtwVR6cilmBQ9RpSy2gRwDNpMICVKCaWRUidlAotbLQa0RcoAdkFevgUbbTOfk97mH7O/g/5aMoj/8rtkpkUuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR02MB793570
X-Proofpoint-GUID: iPtlkWJswnXSdg0KDeNngXzX6TTpMP6M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE2MiBTYWx0ZWRfX1rpbjDItOfua
 r4TvXx2VAvC+nnzuRSSnoCFMCihvvYceKWIvm9ZB5J5M32QhPJqYg86kth+0a0NqBGiTYSJBxLJ
 PiiB4CS7rxAozKQSZnYSZ++HNwlBnm/QMuuqefysXP+nRsZRXkfsbbQJmSQMfAY4Zdk86ueHzGz
 ycBAdKFhhXiNN5DbHOYnJH+sOvMUZcqA/AQ6Jdj/LwC+kw9sO+mo82qbF3qKG2CghC56fBL3DW1
 F+22taXDhd6hTJ1vOMM55op5CFXopKdykb3ku1Dr5eZwJ5wvx4VHaLIGS3cwpcUvES8EOE0Edva
 6sEO9vDXa9uKSNvWh4zrrcGThINCoaD1mEOSKbzxckEMBG+Ix2tXRHdchKc79nS6lSPMFlgVFp3
 N0712xcmIotb4T6vG62NePOR1tAYWwlgFgTkw9kwq3aCckL52lNQ5wsC5A5aFjyAv/P9Rl//BAF
 BE0JCnURHoEnlB7VPEQ==
X-Proofpoint-ORIG-GUID: iPtlkWJswnXSdg0KDeNngXzX6TTpMP6M
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE2MiBTYWx0ZWRfX3KZLPwCtbaC5
 3ZgCjN1UiziKIwesshDTh/mr0S8Y1YFDQeiSpOkPijUxeitLUiDRg+h1EYd54Yzpc25bJ+8X95j
 JyB/iLmOLmCiSPqEf3GVW5Z/ZINrKyA=
X-Authority-Analysis: v=2.4 cv=Y4RtIReN c=1 sm=1 tr=0 ts=6aa92950 cx=c_pps
 a=QfAu5cRUQmedtNjS8psswA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=GaQpPoNlAAAA:8 a=64Cc0HZtAAAA:8 a=8ZzfiaRkb0kPkydfaOQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=david.vrabel@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On 15/09/2026 11:01, Michael S. Tsirkin wrote:
> 
> On Tue, Sep 15, 2026 at 09:25:05AM +0200, Cédric Le Goater wrote:
>> Hello,
>>
>> The xio3130-downstream and x3130-upstream devices lacks x-speed and
>> x-width device properties, making it impossible to configure PCIe link
>> speed/width when building PIX switch topologies for GPU/NIC passthrough.
>>
>> Fix that and preserve migration compatibility with a 2.5GT/s x1 default.
>>
>> Thanks,
>>
>> C.
> 
> Given they are clearly intended for users, time to rename to width/speed
> everywhere?

A more comprehensive series (hw/pci-bridge: Configurable apparent 
bandwidth for the PCIe topology) is here:

https://patchew.org/QEMU/20260908155223.164787-1-david.vrabel@nutanix.com/

This adds new upstream and switch port devices with configurable 
speed/width and renames the options so they are non-experimental (but do 
not the open question about the usability of the speed option with the 
need to set 2.5 GT/s as the string "2_5").

I did consider adding options to the XIO3130 device but since the real 
hardware is Gen 1 only and does not support speeds/widths other 
2.5GT/s/1x I didn't consider it appropriate to claim these emulated 
ports are more capable than the real hardware.

David

