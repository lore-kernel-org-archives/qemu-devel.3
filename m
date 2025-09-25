Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50BDCAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kFI-0008VC-JX; Thu, 25 Sep 2025 07:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kEB-0006kJ-FR; Thu, 25 Sep 2025 07:33:37 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kE5-0008Qh-3b; Thu, 25 Sep 2025 07:33:34 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58PAZfFX1851125; Thu, 25 Sep 2025 04:33:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=6VjVKAB5WAGgBqdhGmKfJqaHHPDXarxiTD8RsqbJV
 3o=; b=xAWBQqVtO9xNzwG6Jw8IosKotM+YBoUGFrveq+zyNI7n5nKos+XTwAhZY
 6iuUb9FA0ZJqwSWzAkOUD+wthuE5tGt7pgwPmFFtpPXPdF+2tVePUW99mh8CdS2/
 qexnBid3d12+7qSBlKWOIrYR0I9osd3zaYkkTMBvgRdzk6TeEH38S2gEGweuJ1mT
 fDwm0aQHMySw9iVQrmso6Q+4a6JY7D5vxTFMNWBCRycQk6dvg2zcXIpffXRDJj6t
 HJMrqMlA1rqDVnFSwsWwL+ShOmFeZSKJMGRCWdUCa/4ooP02+p9XjX6VW5MN5UuO
 ykwJ9t6LQCI73GwXB3ltehelMTP1g==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022111.outbound.protection.outlook.com [52.101.53.111])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49cgsjavfc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:33:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCKAXfoo3TjreHIMFZ5EBbOxPLe4Kfoczsk7YKoSbXVBjDAedf8gCgxzoim4mswjCL+Q0RfvC2H84PhqvMDX7AWhjIoOmj4XCYioLg2HD9mPlxD680qdL/RU7OyHWMbmZH6QYTsm5eEQZPh7b8VEo0vswpvPCjrgEIUrvSjZA9LpxYrTT6ZOdRgkuM9tGgUvadxVc5upl99QiCnij5Ns39Z2lArScVq4EDofmW9TsgzYqtXVUMuAFLfU5PWczocf9U/jJRXD5t8INps3SQDdq4KDfw/NYHF9sNzrLusw7L0hGFVZU4fzPVP910TCHQ4JkLwoH6J+ubl5aum2XhoupQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VjVKAB5WAGgBqdhGmKfJqaHHPDXarxiTD8RsqbJV3o=;
 b=R+rM3AvRMZPgFwt8lZPujVmwQM32pE38AyaSRXFhH94jLE9245IqC38vgk05k8/c0WpuvW9G/y5EvYTQE/E0ia8YE4xcjS5uQ0GFR0tV68Kh9twD2DJGjUj0rgiQwWCZWHEID0omdlR6BgxqaAxOs3j+YRVi30qcVXYYdjfP/MAbqgZvaEM6k0JBBQ0EN0CJmKCNMS8XQjWa5+LOvBxlMVpzeFOY4tiFY1lvS0d5PH+WhyR9liQK2qJkTUlw0m3l7L7IzQdG0eZfeF81cUfd0KNvNTVvZz7B/UOZqH2qXOsUZwen0BF/wpCSIgPGlSwCXx/P8iUKlV/Pjx7K3CP1jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VjVKAB5WAGgBqdhGmKfJqaHHPDXarxiTD8RsqbJV3o=;
 b=ifOciDKVFDUdF2rZneRwM92wmpH6nZmCL+N2MV1ph6Gqj4e8jGy4PPhW0IU+Sat9d8PFTKe1KzlY5EAFfOe6OidREgIfUZYRx5Udhd34gfpH1yB9rB53hv+y3olQ7GKtEiipRGOgtzAT57JaBm5Ev8D+xldofbZyyPSpFHbg1ZUnV4/q2mxletrrwW6AEnRp2yJHPR7uyC7ja/IWgNkAy+XYNUH1hk+WgzDbtJKOkdbZlifaPLFYUycw6Sp2j9g8mtuUa4n9qUk1iefb1Gy/648fuk/GhHpIUAmERCew55KWCDHVchgTxzBBCykYLd/ncGF/ROCCViiHsvlmaE+yhg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9854.namprd02.prod.outlook.com (2603:10b6:208:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 11:33:14 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:33:14 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 21/28] vfio/pci.c: rename
 vfio_pci_nohotplug_dev_class_init() to vfio_pci_nohotplug_class_init()
Date: Thu, 25 Sep 2025 12:31:29 +0100
Message-ID: <20250925113159.1760317-22-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0114.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::30) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9854:EE_
X-MS-Office365-Filtering-Correlation-Id: ad5bdf85-deab-44b5-00c0-08ddfc27507e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHJjVEZKaHp3bktsc2NLdGZ6djJaR3NiSS84RGNjK2NKdDdneFlGUXZpbzha?=
 =?utf-8?B?NE8vd21jdWZUb0c5VlZTYUNJZUZkVERGTVJEelBsMk9EVVZQNWlPRDM4S0pv?=
 =?utf-8?B?aVZRSmdheTEvRVpsRWphTUVjWk1RcU1ldGU1aDl5SDVEZ090UFdMSDhYS2ph?=
 =?utf-8?B?RnpnVkVORGtzZmxkRm9CQTU2WkJZU1lXZ0xHc0pKYU9qOWVtUTI3TzRxc2tL?=
 =?utf-8?B?Q2RJRE9YQzliekQ0WFpVU3M0ZFM1UVdxQVpBMm1icVhFa2hrSUtjb1RzV1Bv?=
 =?utf-8?B?d0RTK2hLUUlremZFcE8rMUdUY2c2VFpHdXN2MXJWMTl5MDB3dFlJR0txdlNO?=
 =?utf-8?B?Wnlia1R5TnR1bkFxSEFhTW1FQ3NuaDNqVGhUaWwvRGpmeUpadVdZWk55NFYw?=
 =?utf-8?B?d3d2VUR2TlRibGxWY2xCN0RjWUtDMDNoY0dXQkFQaXR4OWFtK1FndVRRL3k4?=
 =?utf-8?B?aUFhTTRUTElCYXVEdzNPdXg5Z0h3c0orS2JIbUpsK090OGt0bWI0UXFCRW5B?=
 =?utf-8?B?dWxRUTVoRW9vamNZRGVOUWNtN0hDRndWTGZDQ2hsTjZ4N0RoajZWNVRxa2Jt?=
 =?utf-8?B?aDUvTlVsQi9OWXJ0MEdaVDc3MTVIOHNKY0U3aGorNVB1NzVBM29xb2Z3Snlx?=
 =?utf-8?B?OS9OK21LMThENTVBaTR4QnF2aldyVTI5N2VabG9mZFEydnVuN2g5dHZ6R2Z6?=
 =?utf-8?B?ZmJVNWp0VFlYWlludjBzZTJjMHRzQk9nMzVQeks4WmFKOGp4OHl3bFR4M0pM?=
 =?utf-8?B?YmlIbUhydXpSZStxbk5jTDArWEIrbTdmZVR2S08xRnVPeDl1TVRKcStHYkZN?=
 =?utf-8?B?am1TZ2JPYlQ3MXhuUjBkUXU3K2RHR0hQNTlJRGZkWk9Wc0NqRlZYaVRGd0kw?=
 =?utf-8?B?b21uczRwVG12b2FNWHZCRCtLRlJjUUhKQTMzWDU5c05kVmNtUEFhU2Q4UHNZ?=
 =?utf-8?B?Y1pGRGpqRnBVM0xWSDlLaDd0Wm9rTnVqQTFNWG9GQ1k5MjNrcTdIaStqdkJi?=
 =?utf-8?B?K3FENlpKNHNyTUkyTmVodDUvRzZzcmp0bEN4cHRuaGl1KzZwdW5nbm15V0xJ?=
 =?utf-8?B?Zld3VEo0Sm4wU1hRRldlSTYyZFhMYkp1ayttazhyWVhaWkR0MWYrREtrLzBN?=
 =?utf-8?B?Z2NhQnM3bVREeWRDZWY1bCt3ZS9hTThyNkc5MU5YbFlkbkJZdXRZeUJQUXpF?=
 =?utf-8?B?VEVnbGllMUlRUEk5RzdlN1lwU3k2RU9KaUJUSkhxemFDcDJITEl5UmU1VHNh?=
 =?utf-8?B?M0pnbDlkR1VNUGZodmxOQ2Q3VnNJUUNLQWNONHR2TUgyWGc4ZDlSTWQwMFVT?=
 =?utf-8?B?MHBnOXFRNGtuMjFmV3BJQmU1cllIQ3RBRDBEWmdtTmVGQkZDQmpFZVlYc3F3?=
 =?utf-8?B?R2dXOHhMcHN4ZFk0ajVhVDdoNVRoV05yUTE4c3JDdFZ5ZzdJNWduYjNrUmto?=
 =?utf-8?B?aDBqYXZtVFJvK1JoVnJSNXg2RGNGUUlza1NlWG9qQnVTNXZ2UHYxQnp1MDZV?=
 =?utf-8?B?dXg3SklGR2RkQVJoeWdzbEFaTGNnYy83UXBSU1JXUndwSCt5cS9RVXRCcVRm?=
 =?utf-8?B?SVdQTVpDMmxIMDluWnA5U29QRWtKR3lPYjdvakFFYzJIOVBjcTFCQnBldmlj?=
 =?utf-8?B?OUFtU2MraW95dHZZTkxVVVptS0xuamIxRGxIVE0rRkRiWEpZM0VTbVV5Zjdu?=
 =?utf-8?B?a25UdVlZRUx0RklSQjZlUXp2QTJiNjNNT2gzTlhRcldIVDZWVS9aMTViaWFD?=
 =?utf-8?B?MmtaYmUvc0hKNkhIZ0VCYnJqNUszR1lNK1gxT2lxMC9QcXp3Uk9JVTYxWk1D?=
 =?utf-8?B?WWlraWo5cmJPcEpLS1JvanZQNFBETlBKZTZYUmI5NlVBQndkVmtpOE1vaGRn?=
 =?utf-8?B?TEtTV3ZTQUpuVDF1eUdsYWp4ZkVnMjhWeXZaU01TL2grR0g1eS9TaTZHbW94?=
 =?utf-8?B?eGNucUpTTXFIQldpekFEa01Pd0Y1MUxDOENEc0JzLzh6UnF2NjczaEI4Zm5l?=
 =?utf-8?Q?IgdbC+9ToyaZ2oJN74+EZWsggznM4U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1Q4WVRnWFRpQmF2N2ZKQnZ5UkZ1endlRkFLTk92YUZLMkp5bHpoODZ4NkE0?=
 =?utf-8?B?VUh0ZXRXeERLbms5aVBvVkJZMXZxSGpReWgxdlM2VnJ4azE5RkNvNDRiR01p?=
 =?utf-8?B?SjZOVFNzOE1OeGxKN2lDcStaajJMcTZ3TmExS1JueVNsb2txdmJEeWk1b0N0?=
 =?utf-8?B?YmkrKy9BeXlQMkpNdWZBY1BHdHlaMEk2djdpakt6Q3BRR2pGUEw3WUgxY280?=
 =?utf-8?B?Rm0vclpsWi9RdmlZRDNjT0R0ckVybFo4M1B3eXJsQVdpaStROUVqZWUxczBr?=
 =?utf-8?B?Yi95akE0Y3hvZzJ6WEl3a3IrdW8yaFBBdUE5SFRrdUZtRUFMdTNnUW5jZmpN?=
 =?utf-8?B?d0ZQSE4zWGdEWkZzSDBvdXNrcnZhanVHWG9nMTNadnV2OXRONXNQT1lIM2ky?=
 =?utf-8?B?dEFtM2s0T2NQcWpRWHlwNmpzWUV2SUlsOXk4bit2UDZWVmtld20zWTY5QllO?=
 =?utf-8?B?bFhQZFdqQnEvd1dFQUJ2aWc1QmRZZ0xKNlZ3T3BNOGgvTUk0ZldaaFVLSTUx?=
 =?utf-8?B?TWdQdXAyK1BQQTdlNUJPV01pQUp5Z0JRL0xHSVZVUXZKSXpWcm9HU0tWZ3BC?=
 =?utf-8?B?WVFleHBIMW5zaURBNE53MzRxM0RKRHNJbm5FVENMRlVUL0V5YUpmaUlVZ0ZE?=
 =?utf-8?B?WmRCa250N0RjRmpWUHdzZ2IvRlFmeTlwN2VjTlRJSVNhZ3VXWVZpcTVMRXli?=
 =?utf-8?B?Z0k0R2NZOFFud05YdDQ5MjN5Q3BQd2k1NTVjWWc2V2Fjc0lYZU5hcUtiWGh2?=
 =?utf-8?B?TTE0RmQ0NWNUaHlCTlFPbng2dU81bmJxNWFGTEVCRTFXS1J6YXh5NS9TMU1K?=
 =?utf-8?B?ay9OS0g4cDhjQ2cwUXVTeFFUYUh1ZEh4blQzOG5jV3NmOGpGMXIzbU8vanFX?=
 =?utf-8?B?bncxeTRZa2x2VS9pSEhjVUZTMitKakJrbFk4OFByVmt5TzlsVHNUcjZtL0JG?=
 =?utf-8?B?UzNycWVZdGMvNXpuZWlheVRaRmgrWVRyamRDZ0VrZXJ2UjNJL3BLbjVOUFF6?=
 =?utf-8?B?UE5SNUdYa3RxeHcvVnQweWt2cHl4d2lWUUpDV2wxQ2Y1Q0xEdTdHRklmekpM?=
 =?utf-8?B?bEo0WXY1VUVFWW9ONjJOQ0tVMkFnaElYeTFPQy82cEdpSHFCaUF4QTNRdzRJ?=
 =?utf-8?B?WnhVbFVNTzB0MWpza1lla0hxSytwbGNwMytXMXZ5SThNRXNZaW1SNEphRW1k?=
 =?utf-8?B?MnVqOGgzYzlvN3BWQ0JJV3RFbjV1WmkrUDFMUmo0Z1FTNEtZTHdSZTdENmZM?=
 =?utf-8?B?ZzdNR1QrY1VxUFc5clMxcHJsSEVWRVNvNHcyaVZqL2lGSXphUFRUWHVkRUVs?=
 =?utf-8?B?d3NmZTJnT09VMkpKWElhUmY4emZqT05XaVpXdHZDTVg3bzRMcFNEMnRkN090?=
 =?utf-8?B?QzA5elZyODRHZXFzOWRKNjEyN09ldDB3NG9TNjBJYUFscFZLSG1tbXd2WXh2?=
 =?utf-8?B?NHgrWFZ4UUxRMXlMMmJmSDVyN2t1Uk5mV1AveTAxNWNqS1kzYkYxZnZmeC85?=
 =?utf-8?B?TjJ2ak40bU9TOUNCNDBJc2xHa01DcWc0cklZMXFUR0FHWFo1M0Q4Qk4wZCtu?=
 =?utf-8?B?SFRZdnE4UmtDRlNISUJWWndlekNYNW9DTmwyV1hMQ3RWNXptNlI2Q3ArOU9z?=
 =?utf-8?B?bm1iWkR4UVdub05wYWpZUzlwQnQzMFNlNU5PcVpnTW9WUlh0eHBNSytFSHNZ?=
 =?utf-8?B?N2lNa1VKQi94K0ZzOE15b3N4YW5LYjRUMS9Rd3MvYUxUcEVaWSs1bE9WdkRt?=
 =?utf-8?B?aTdtaFRmOUFJc25raXVkMU04N24zZDUrd29DaEYrd0tycVRncU5RdC95akNV?=
 =?utf-8?B?US9RQ2IxY3Jpb1BYOFhmc3hKN3Zva0tiV3ZuSjJqaWhQL0txL3lHZ2h1SENa?=
 =?utf-8?B?QmhIU2xpaTBObUh1N013MFAyQ2RLYVFkRUxsZzBiQ0FLb3hIRnNpUDdpaDVP?=
 =?utf-8?B?bWlQRmRWeHVlYzBHamJlNEVBZzJPT0I4cEhLTldUd2dZVnI5eDNNMXpLR2FV?=
 =?utf-8?B?d3dFM3doT1U1VHgwMmJwYzRrZ21POHZmUk9WaXRURm1WeFp0cDJvdWhJdEVW?=
 =?utf-8?B?TW80R3l1REFxVFBtMENQamt1SmVmZTF0anR0eHMwaFh6NHk3S0tnc3g4dSs4?=
 =?utf-8?B?NE5OZ0JWak1Md3JVT2NuZ2JmRi9vTDYwNDRjWFZ5ZWJyRnJDQXJTZFJvdVNB?=
 =?utf-8?B?Q043UDJPNWswL1RSMVZpTW9JcFU0VWJ0a0lQL0g0WjNkOUNlcCtrSUx0OVBl?=
 =?utf-8?B?dlNyTmk2RjdwYllUTEFaSU8xQlJBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5bdf85-deab-44b5-00c0-08ddfc27507e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:33:14.1725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOSzzcQkfKoG1rpQqEJVL/wBl1wRyurWOXecv5ZpfY+A1uek16hKqE2TYY9NhvtiMusAe+NX7g5Vn/JIhO4fr0DJm1XE4UvMHKLlHurV73o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9854
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfXx8/8Tnh2LilZ
 rCWI7r8L89jWzflidkm/cdR6x2qT0+CQ73P46G6NAvcvyR4YWv35kmOZDc/zkYVs7lDVnQpQvrF
 fDE8srglOSIpa+cjO0f73ui5MEUqTQnAUSjvfsc4hCLjhA+uPGfvYb+76fERzKF62gSS42iCFhY
 +EmhPr43Z5qb0WLqTegMa0kMpjLeZJt9C9fJVkA/pI4/YC2HoR41Za2iGvAZ1l6PE/z7eCWQitJ
 tk6Jo9ckpwxJIO843FJkKrvhKXfgiWXls0OJdAH2b/NVcA5ylhd3u8l/I+8hHw9A5S6Po2ut5Ba
 fl15XgAmnRGGNQpkhLZUzGXAx8MkO6sJDp9dXLU1lSL8QOzVUZMIyf0kMItQE8=
X-Proofpoint-ORIG-GUID: ILKLvzBBB5I41GGYC6YOC2w-q-jukkxL
X-Proofpoint-GUID: ILKLvzBBB5I41GGYC6YOC2w-q-jukkxL
X-Authority-Analysis: v=2.4 cv=aYdhnQot c=1 sm=1 tr=0 ts=68d5287c cx=c_pps
 a=EF3+7zrlrsiSedIMbKc+Bw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=udP_5BOVWkZL6ct6w7QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6b3c97c56c..10313edc7e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3928,7 +3928,7 @@ static const Property vfio_pci_nohotplug_properties[] = {
                             ON_OFF_AUTO_AUTO),
 };
 
-static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass,
+static void vfio_pci_nohotplug_class_init(ObjectClass *klass,
                                               const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -3953,7 +3953,7 @@ static const TypeInfo vfio_pci_nohotplug_dev_info = {
     .name = TYPE_VFIO_PCI_NOHOTPLUG,
     .parent = TYPE_VFIO_PCI,
     .instance_size = sizeof(VFIOPCIDevice),
-    .class_init = vfio_pci_nohotplug_dev_class_init,
+    .class_init = vfio_pci_nohotplug_class_init,
 };
 
 static void register_vfio_pci_dev_type(void)
-- 
2.43.0


