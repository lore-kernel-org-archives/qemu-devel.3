Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E270BC9EC79
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 11:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfG9e-0002yr-PX; Mon, 12 Jan 2026 06:32:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1vfG9V-0002v7-Du
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 06:32:06 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1vfG9T-0002JO-7V
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 06:32:05 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60CBVTRa2963395; Mon, 12 Jan 2026 03:31:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=1bHWRZ/Zdo7gr
 nVC3qa+Ofs4YvVuss4G+hD+jCH5q+M=; b=t/SsOn7XZLYGsApy9pFNKM0iEew6N
 SHhtbUb7OsiMljqDbUU8vX6qmClu3uIo+omsRfihErvvqsR2USTxIKR5YM7z+9Zo
 z9oYtEukGmcTvi3fBLC721F4iFAN3OTHD8ZYUb/RunkE7ECjIZri5joEzopuIhIv
 V1zpw6DPx6kwk1UCqBUMKq9oRsGRdfbnuMGXaTMAOkuGjU0z8IcZoJOrwhkaFv6z
 +Jqamg12kl/cVeuv1e5rkhcYVEvQp1Zvm5FmmayLgvH0gfS5x5PowjAiSJIo36MU
 RCeRPwBOJMq14nH0VRCGy0CjzcROyu8jQTyJvnzaJYTUH2/t0ph20BaOg==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021118.outbound.protection.outlook.com [52.101.62.118])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4bkq6yk485-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 03:31:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUuzEdW3gjuLmQ0NiHqhzHS0/hWsdpnohmfKTVi6dcd+D2fOvxr0o/Aiawr5avge4Wtko0DwG8Gr2HNoyYvRSbPBx4+40crw7njdVeGotBr5JaPDEO+soPCX42PdmpTBqF/DvrxAf5UZtedM2knz94+3/wWY0GKmgZ9RgpzQ+Z22tiN8IBx7t6vKNJlSwucMXyORbyYA8yGXD+L9zAJWJv+hV5ko/6E/3X68llnB2D8jVXzkn7gkqA34rXCFjGK+SymA5+mHrAeHaR4MruSMHFmLa6Qd2552Bl5cbYg0skE/9j+59ohWCbQi9iVaKyvH1lxp7NIIXnRMGwt9vIKusQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bHWRZ/Zdo7grnVC3qa+Ofs4YvVuss4G+hD+jCH5q+M=;
 b=r8JM0pKHj3NKSauWgBNdrNduIaJlbWJn3mV6Il2rJQ0A8GwBNdqzjmsAOVQbFMDk72e1m4wfOChjHKViBonP7UyBXW3masn9C/VStYDhT12R2AMXrIIRRCYlSOZ/yYCVKH2/JWPvg5RxDrXo7lnJZR0XJt68QIBZ4Uw/jbiZ/QWJmiMwWA3lO8hSgQZ+u08isNyAMEXZrTDX/cQiXuvVYmPWs06fb1RlzRQ5eJpjfa5jY3M/rEtiY+Jf0wWQWYBqgPBGcjF2u4qGZvGf4Xyt/GcH6ZeTwC9tY+CLww4D1UP58ueAF4OW9N83cUTx2QpTZ1UM6ts5/9D14u2hBahAYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bHWRZ/Zdo7grnVC3qa+Ofs4YvVuss4G+hD+jCH5q+M=;
 b=UEb6wFn88e6nfg/rr8dxVQtwzXJ/PfVQ3VzJx7MiI7ZNJiPWo5j8JOz2av4Xv3DeghfgGRTFPWPoRTDTXWIFXSJjjotQORDh4V3Rz0laEI2G26FhpZxVOPmW7xmvOLmWQ4Gqzjj6lX5pMym1FyxJhzWh+rBVlZ6km+D1XyiA6O4wTNUCp11BYlA2u/XU8cwMp/mNj1Ld2ChBXRgumuz+blyxnyaRCBlF74tLLARNqs78chLTnW0nlMQJuASVpLH9RwUpmfPj0bkbYY3+Zi8rwWzWHouYnSQ6pZCs0bBjsKOB8MiCIQP00HOdT2lGoxGGU6+/0p+FzEvDETZOrKi27g==
Received: from PH7PR02MB9992.namprd02.prod.outlook.com (2603:10b6:510:2f5::16)
 by DM8PR02MB8071.namprd02.prod.outlook.com (2603:10b6:8:18::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Mon, 12 Jan 2026 11:31:55 +0000
Received: from PH7PR02MB9992.namprd02.prod.outlook.com
 ([fe80::e2e9:fa4e:10d7:f7c1]) by PH7PR02MB9992.namprd02.prod.outlook.com
 ([fe80::e2e9:fa4e:10d7:f7c1%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 11:31:55 +0000
From: Florian Schmidt <flosch@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, Florian Schmidt <flosch@nutanix.com>
Subject: [RFC PATCH 0/2] Support for Hyper-V's HvExtCallGetBootZeroedMemory()
Date: Mon, 12 Jan 2026 11:31:36 +0000
Message-ID: <20260112113139.3762156-1-flosch@nutanix.com>
X-Mailer: git-send-email 2.52.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::14) To PH7PR02MB9992.namprd02.prod.outlook.com
 (2603:10b6:510:2f5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR02MB9992:EE_|DM8PR02MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: 38844c70-d75e-4af8-eee8-08de51ce3081
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHI4TktGVXhsYnpDbk9tcEJFdHlXbklKaGl0VjZpQjZpS2ptZFZpRmxDVjhy?=
 =?utf-8?B?a3h3MVpYajdiU3kwZE9WUEhDUy8yRUFoelFzRlIrL0FuWC9qMktUbHZtWitt?=
 =?utf-8?B?Y2VKa29WS1VjMjU2dFhWbUFNcUdCVldEbTg3QW95N0xScG0ydjFUWXdTalRN?=
 =?utf-8?B?Z25hWmtrM1hXYzlkZXYrUXFJK0pzMjk2QlE4N3FLeGJLbWlaNjNRRTRGTXpR?=
 =?utf-8?B?LzNyaXJSaGlBa0tvUzRWUnpZTVhEdXM0RmZVSjNsMkhLRSs1cnhkcFNyOFd3?=
 =?utf-8?B?MUpJakg3eWF0clkzQzBrSkRlMzdEOEJiWFhzTm0rYjdXYnhyQ0I0TjIzb04x?=
 =?utf-8?B?aXNiSVdpYVp6Y05RY09WOWFZRHFUNk1wU2Q2WFhwNE5ERm0wOUs3cTBmcHVU?=
 =?utf-8?B?dlFiZnJwQXRSZXZWM3doTllrc2t3M0d3a21HbDNpVU1hRnR4a2FWQWtNRUVY?=
 =?utf-8?B?WEE4MHFLK2RZbEZVa2hFclNwaTZGankxNVUxS0tuM3NXeEgyWTJUSm1scmdQ?=
 =?utf-8?B?eUJod21kSjdod0xrR20weUtOWStuN2Q4YVRDSjV3dnBROXN1VzF0V3dKVFV0?=
 =?utf-8?B?eW90SU0wNFdDdE4wQzMxcGlYVlhJbDVmYlVrMlhJeDczaWxHSXA5MGdMM1M5?=
 =?utf-8?B?aEpkWjdobVVUNFRmUFNNQlNQYUhsaE1oR0pKZXhweHppcjRXdmNEU3N6eFBK?=
 =?utf-8?B?NnNLdzJIK0IvLzFJNHNmMkJtcGtuemFXeW8vdzVuTG5rZlZjZ0UzVlZ4RzBZ?=
 =?utf-8?B?bXZiNFNBa2JvdkFINzdUano0cTFsNE5EWWxzd3VpSXpoYWxvZ3lDcHhsV3lQ?=
 =?utf-8?B?YlRPMmozNi9GemM4NHV6V0JvSUJlV1YvaXR3WDFpclBBYk93bGNjdmE3NXBI?=
 =?utf-8?B?T1FVUzVYZzY3OXB3MTM1TFBUbTErYlZUR1NCODZjemNNY3Y0RmZCNmxpNm5m?=
 =?utf-8?B?Tkh5NFkzY3JkNjZ5S3BWWm5jR0ZvY2NDckpYaUZYSWttd21FSGJ6dlNWc3BU?=
 =?utf-8?B?YXUvUUo1QmRObC9wN0tLWlhURXlNT2pMTVVSaVlLTHd0aXlBbXU5TUJNVXhN?=
 =?utf-8?B?cldFcHdlZVJISHM0a09ISjB1Njc0Y0pvVEYvclNaUGtDa1hRZTV2NlNhRFhS?=
 =?utf-8?B?Y3hBWGxrd3p3c2pyblZrbzg3Si84YXd0RFp2QWJBVXRsYUFoSkpvU0REekJm?=
 =?utf-8?B?eUZ0ZDU3eWtyQ2VmVG5rOTJsMTV4T291MXhTVUNwNjhmYlRRb0VCeWZCVEph?=
 =?utf-8?B?MThqTkRXL0tQUitocFM3NFRMREJpREJ6TG5lSU9nVE5UaXd5UkRoRS9IY25o?=
 =?utf-8?B?WVVRL2UyTC9jODZXRmlOdzlmSnVMbnp4dXppQlFnM1k4Wk13SGZTZ2pEclRK?=
 =?utf-8?B?YkxJOFpUcDJJZk1CZjlEQ0R4R3J2TmlVMzk2WjFmbFdPWlRUVmo1ZXF3T2FT?=
 =?utf-8?B?dUtKMW9YcmZHVUJFSjhaL3F1cWFIVmZvVlB5SVZ2OFZkMEJib1gyaUVhZVcy?=
 =?utf-8?B?YWlQZ2ZoaFlrNnZ3d3dPd3JKTHhOcWtJZ1ZvZXRZaDFPNTV0Rkl2eWM0RE5K?=
 =?utf-8?B?RkhFTTJ2bEdzcThDQlpYRGJMUll0clY5azBGcCtVdDN2MVNlOUxNNjRVcGtR?=
 =?utf-8?B?K0ZJNUw1U1pDTWtIU2xhM1BlaEFQQTBKT0Fwem00WTFJMGNRK1JyOTNtakVV?=
 =?utf-8?B?SStlOWxyMEF5dzR3dmxGU2NVbEw2cXVHRHF0RnlieGg1RmhVakJab0pGMGl1?=
 =?utf-8?B?SThRaHJ2Qy93aytmTittcmdJKzhoTWJQY0FKRHVJV0tMOSswNUVmcXVDdzlJ?=
 =?utf-8?B?c2xFRWlQRG9iYytHZ21ESmMrYjVyU041dGV6YlpPZitsT3hKQy9zRndLangx?=
 =?utf-8?B?RlpackNyMzdXQzR6eGY1MDJxb25STTlzMnU1blgycTkyM0ROQlFKVHpUeUp2?=
 =?utf-8?B?N2NKeFFsR0hSZkRUMEhkL0lXemdiQlNlRVFVb05jZzN6dHZxUkhJb0J2Y0pw?=
 =?utf-8?B?MGN1Z2dVSmFkcm5EK0tVdFd2cVhxUEtIL0N4VVpKR1VtTDJKZ1c3NVF5RmN2?=
 =?utf-8?Q?e0r96k?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR02MB9992.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVRad2NNT3BjWHpOR29PTUlHbmNyTGd6Mzk3b3JzbzNxNlliVlRjcEcxV3cr?=
 =?utf-8?B?Y1lQWjRMQkdwSGZyT0RQcHdza1ZUdUJtai8xRGZKR3lwRkJWSFJSUmFFVGR1?=
 =?utf-8?B?RHRMTmJEd2QzTEtPMUlyQk52V3dYWUlVTXZZTW5OZ3plSkcwaHk1d1dORUcx?=
 =?utf-8?B?a2doRGlQY0cvdDZRTzFhTENRdXE2YlJEMm1qMWhwcnRPODRTMHppQS9YK1NO?=
 =?utf-8?B?YjU3eG1qMTcwRlBWTE5DLzh5azVYZDBnbmZ4MHlSbWI1cENYRzJYV1l0cFdn?=
 =?utf-8?B?TWI1eEZjZjBPSEhtbjR5WnVMWXN1V3k3c0d2YzBuK0lvYy93a1NXTWRwcE9R?=
 =?utf-8?B?SktwajlEUnlSc0hMeWhQVHBNdTA5RWlOK0xaelZJbi8zRkRZSk5yYWVvRnJj?=
 =?utf-8?B?VUFLSFpCek55K0s1c2NodkFvUTZQNWlqRVdjNHVxSDEyd0c1RVBSeDllY0w0?=
 =?utf-8?B?R25uQnhneHpFczh4MzhpUWdFQW1kZXNaZFZyU1l5WE9EOFhPZDRydXFlT0pH?=
 =?utf-8?B?Z1pVNzRpYmZHQWJ5Q1NEM21hRjdlV294KzRXTk93Mm9yRzBiTS9IZDl1YXZR?=
 =?utf-8?B?MnU5MEh3VkdMYVBKWGlUWmxxcGN4aGhVbk1Yc1pMQzVBK0pxQk1YaHcxK2pw?=
 =?utf-8?B?dkpNV1VJVTN2YnRxcnh6S015MVhkc243dWlxYXNYa2k4ejhOOXkrVzNIT3hJ?=
 =?utf-8?B?UCtuOHR5NERJUFdMWGcwaFlqUmhmODJ6dm1BUkluTjREZmV5M0JtRkZReVQr?=
 =?utf-8?B?ZjFiMVVoVkpSaFpmK3kvV0ZFUm8waU5rU0hWWkFUOUp6NUszTFgxbmhDMHVY?=
 =?utf-8?B?Y2lMeVVOb2c3YnV4eFVOa2wxMmgvS2pOekVNNmhONzliNHF6a0tPbUVjZjJD?=
 =?utf-8?B?aFZkTG82bS9zU01oaHMzNjhwV0FEQjU2WDVzazN6L0g1VHMwaUVlemFBWDN4?=
 =?utf-8?B?WU9PaG5NcnZ3MWdiNFVlZjNKTDd1VWx0NmNMMXIvRnZYWkJFTDRiWVZVY0xU?=
 =?utf-8?B?VzRmbDhTc3ZFVm9RL2hoWm42aUdMelJnd29oaTkrZXRTak9ERmxxRkwwMkJH?=
 =?utf-8?B?azdaVHFYdEpGTS9ldk9CVzA1cEpjOTBwZjVmRzhRVXVGaGxzQWRvVmgwSFJi?=
 =?utf-8?B?REdSWGsvQ1duYkF1enFMT1NjeTg5Ulp0M2h1dGhHNmdXREUzanAwY3AvbmNU?=
 =?utf-8?B?bW5GQmFaY0dZbGlZRmhCRjU4ck5GR3NYc0pYTWNXeCtVbjh4UWt6K3l2ZktI?=
 =?utf-8?B?eGhZRW1EZmpPMnl2WldKb2JWNGUrYU9id05qZk9MMmltUFlaZ3NiRWc5VHpG?=
 =?utf-8?B?ZE00NTdZTzNnVUx0MG9JMURrVnRpSHZaK1JRckFhNzZLRGNqcHYyOU9DZlFi?=
 =?utf-8?B?TzVPcHRpc1NNa250Z0JIdURxbklKS0MvWlRNOWJaaWpYK05HZUlkMkRIMmJD?=
 =?utf-8?B?emlaMGJ6WFR0OHk3b2NGcGtHWStTMDJTYUhXS2poZkRadWVQT1JxN2FoMVJt?=
 =?utf-8?B?MzNNZVY2c3dZM0ErOHdYL2JZenAvTlM5RmpIMHFHTnRyc2tDay9URGROQ3dD?=
 =?utf-8?B?QUE3clNSTG93Q0V1TDlzRFdwbUNJYko0SXBZUXBKV1RiK1paSFBmM1ZHK0xv?=
 =?utf-8?B?ckp0dUVORlZrTDMrWXdnWlpBQ3ltWHBjb2JtZ29DVEhsTlNQdGxoWk55ZFQ1?=
 =?utf-8?B?KzI3Yy9uRkYyRy84Wi9RcVZTTkRsSWNBQ1drMVNWN0E3d0hKaWZsYmcxOXdx?=
 =?utf-8?B?Y01yWEVSYTFJUHFYbUR4a2pBb2xQUzcvaUo3Ymc3UWYvUFRjZ2p2V1p6Tjc4?=
 =?utf-8?B?aWxEdXBwaDlDSDJrN1dlYjBxbVMzZWExWU84dTV2eTZ6ekVyVGo4OTZWemp1?=
 =?utf-8?B?K2FCZnIwMklHWVUvTkJNcnJNUzIzcEQzWitScU1PekROT1p6djBoSTkwbzV6?=
 =?utf-8?B?REw3RnVUUjF0dkRPNDZFUWJCSStrQ2RjdFAyT0VFUGxDRnpGb29tWmVMVVA5?=
 =?utf-8?B?elNGemdvUlRhMEhCSXRVS1NoL3lxaU9ZRDB0MHRwT09tMlFqdGxWWmsrM2NS?=
 =?utf-8?B?cVEwMzZySDdJcTBKUENvMGt4RTNhK0I1ak9uSEZoZ0MyeUpoMWNjT0JHSTdV?=
 =?utf-8?B?Wk9VZU5vRURXR2FwUXJ6NW4ydEdiQkJJK2F6Y1lSOW9mYi9rcW9tVUJYSnoy?=
 =?utf-8?B?UWptT3UydEZZZ2x0OERqbUVIK1BTbFdiUUJSQ1dGWUNFSENTd2Nkb2d6enI3?=
 =?utf-8?B?bEdTcTQ5T2lxem80SFhJbGZCNFErMytVVG1MRXdtamVpb1JjMXBFUWZ3cDNh?=
 =?utf-8?B?aXFybTlLTkREcTVuc1RwVW9uNzdxMFJlSUNlSzVFSW96eEg3QUttS0NqbHB5?=
 =?utf-8?Q?roHnK0xH3reRLe7s=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38844c70-d75e-4af8-eee8-08de51ce3081
X-MS-Exchange-CrossTenant-AuthSource: PH7PR02MB9992.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 11:31:55.3367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GciF3NnyJ5J12TOsjvc31AkLuxgnD4CNKupbS87NAO0eiRTagsU9O9+sEn25hEls7IndTnK5+RIKZk/Pz2lNH/ftPNSJ1+GrXxK/99HmTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8071
X-Proofpoint-GUID: 8MMj5mmuNwWFL4lr8hIHkcjqYkGdBwW0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA5MSBTYWx0ZWRfX3CXYz9gFFsmw
 Ap+B7YsWhAihQ/lNZpRYN2UGkXUGCrMrXu11d6rqMqsZuugu60WkxlK/ebe3Gj/grvgmbtqeteO
 AXH5hrSbCheuAJt6dVHrmNDFE7CQI90gavYZIuSXPLjl1qRrX/qWvj/XhFLV8Zum4elO4xqv9NB
 23fY+9bSIb9wly9KdaG0EVPngjJp3rmrsY+bEIasLn5i8ex0tm+w3r8Ki0nqf68eMy3vDL3L+2m
 OJ3WWC6ir3vORX9s80qeuEF+219qMuL14Pjcz2p+JirgzwAzEVhraWrbH4sRFw2kvE2bL/0AmpW
 Wh3wbVPIJ9wKbLWc94FtVACMcAQFMkAEfB3HBC7U4LOusmrB/dpMQkYLzOMrCBJSSF8RNGwkTa/
 0xKdPXd7hE7NGouvcssX1I7sKDSy0hhSD7Lz3ezfbaa4ni4QblIv2PHeL59IUPzJIsolkPqi0SH
 w3rxVFthNkCXhVAabng==
X-Authority-Analysis: v=2.4 cv=HN7O14tv c=1 sm=1 tr=0 ts=6964dbad cx=c_pps
 a=faNChB6ooTmYohDsr5IHEw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=cWRNjhkoAAAA:8
 a=Ac01Q28Z7wcfNu5pfZIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=VOMcPh5fO3MA:10 a=sVa6W5Aao32NNC1mekxh:22
X-Proofpoint-ORIG-GUID: 8MMj5mmuNwWFL4lr8hIHkcjqYkGdBwW0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=flosch@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_TRY_3LD=1.997 autolearn=no autolearn_force=no
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

This patch series implements two new Hyper-V hypercalls. The primary goal is
to support "zeroed memory" enlightenment via HvExtCallGetBootZeroedMemory().
To do so, we also need to implement HvExtCallQueryCapabilities(). While
HvExtCallQueryCapabilities() uses another bit in EBX on CPUID leaf
0x40000003, it then allows the guest to query for further "extended"
hypercalls via the return value of that call.

HvExtCallGetBootZeroedMemory() allows a Windows guest to inquire which areas
of memory that were provided by the hypervisor are already zeroed out,
meaning that there's no need for the guest to do so again. This has obvious
performance benefits.

To get a rough idea of the performance benefit, looking at a 4-core, 64GB
Windows 11 guest, we can see that an otherwise idle guest takes a bit less
than 90 seconds to finish zeroing and settle down from the time the qemu
process is started. If we look at CPU usage for each vCPU task 90 seconds
after starting, we get:
1559 498
1294 343
1451 314
4015 2729
Conversely, after enabling HvExtCallGetBootZeroedMemory(), CPU usage is
reduced:
1583 458
1441 361
1279 312
1337 264
These are taken from the respective /proc/<pid>/task/<tid>/stat entries,
denoting user and system time per "CPU X/KVM" task, in ticks.
We can clearly see which to which vCPU fell the tasks of zeroing.

It also has the side benefit of not touching all pages at boot. This can be
useful if, for example, the VM is started with a balloon target already set.
In this case, we don't risk memory usage spikes on the host if the VM touches
all memory before the balloon can catch up.



Note that this is still an RFC series. There are a number of open questions,
most importantly, which memory areas to send back to the guest as
pre-zeroed. The Microsoft documentation is a bit sparse, but points out:

> Ranges can include memory that don’t exist and can overlap.
https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercalls/hvextcallgetbootzeroedmemory

So for testing purposes, I just set all memory from 0 to the end of the
64-bit address space as pre-zeroed. Anecdotally, this worked fine in my
preliminary testing so far, though it feels a bit cheeky. I'd appreciate
some suggestions here on how to handle this in the most robust way. For
example, I was worried about mapped memory, legacy craziness in the first MB of
address space, etc.
As a side note, I could not get this to work for hotplugging memory via adding
a memdimm0 at runtime; that memory would be zeroed out by the guest. It may
indeed just be about _BOOT_ZeroedMemory...

I also wonder whether HvExtCallQueryCapabilities() should have a prop bit,
like HvExtCallGetBootZeroedMemory(). Right now, HvExtCallQueryCapabilities()
is always enabled after this patch, and simply returns "no ext capabilities"
if HvExtCallGetBootZeroedMemory() is not enabled. This does technically
change guest-visible behaviour. [1] But then we'll have to implement a
dependency between the props, because you can't have
HvExtCallGetBootZeroedMemory() without HvExtCallQueryCapabilities(), because
the guest won't have a way to figure out it's available.


[1] There's a little quirk here, in case someone else gets stung by this:
Windows seems to have a long-standing bug/"feature", where it _always_
issues a HvExtCallQueryCapabilities() hypercall, even if it's not signalled
in the CPUID leaf. Except in those cases, it seems to ignore the return
value. See here for someone else who noticed that years ago:
https://lists.xenproject.org/archives/html/xen-devel/2017-03/msg02809.html
And it's still happening to this day.

Florian Schmidt (2):
  Add HvExtCallQueryCapabilities
  Add HvExtCallGetBootZeroedMemory

 docs/system/i386/hyperv.rst      |  5 +++
 hw/hyperv/hyperv.c               | 62 ++++++++++++++++++++++++++++++++
 include/hw/hyperv/hyperv-proto.h | 12 +++++++
 include/hw/hyperv/hyperv.h       | 10 ++++++
 target/i386/cpu.c                |  2 ++
 target/i386/cpu.h                |  1 +
 target/i386/kvm/hyperv-proto.h   |  6 ++++
 target/i386/kvm/hyperv.c         | 24 +++++++++++++
 target/i386/kvm/kvm.c            |  3 ++
 9 files changed, 125 insertions(+)

-- 
2.39.5


