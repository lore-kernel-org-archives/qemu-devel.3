Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE242E7719B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUdW-0006U4-9N; Wed, 08 Jan 2025 06:54:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUd5-0006PI-QT
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:46 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUd1-0002Cj-1J
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:41 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50885pFB021537;
 Wed, 8 Jan 2025 03:53:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=XI5c1gvNTO4ui
 dI0TLpffB+TOiUtrjMpiX6aELL/aqY=; b=v8toePHdYcTnDEPyyFIC7v4WK6KcN
 HJqpMHMufM2t8p5JWF9Yyiz53rUmJRBqtLbL35k1IMurObpxn4wrdo3md5bcH3sl
 Qc33oYDcApthAyZ4+ZUBNSTsa5z3MJk6A0cgQbjICBsB3RrmuQG5LuiNawMU/DvU
 7seX+aGLgRiT7fDluP+bAZ2TJE7BzJB3+A7SfGl9z6qLfoVOHnuQbyHBiGv70onV
 zaeN8+pry7ogNfAf/wvs5af6On7DJAb3IMkMwW/jC3QDxxQwbIwBnlowsMebsWyx
 6i5+eMNNDZuMDXpk8h8xeM51iLfdS3U9I+K2Eufrk6uoiJAYVCMv7fK2Q==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 43y5d3rs7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 03:53:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuKLDex8888q6zRbYLRgQfc3GMDNMBe50i7PcJNNpQrvaxA0L1GnWkBJ3+1ij4hnH+HG0aZFGon98zGWlnYkvs6/e8+aQva/r7La9pLuu0Hmy8gVGoSQRPBMvFa1pLjqk7+vfXVft9eyDGdMwgNLGYCn3yBD3N9UWkC6EjQ4fvhtObRLBq4u6s/iCRGxsp8zzmAdZjf9j4bY/50KTwqPUZG/vdIXnXKpcpg3uXfNtFY6ceucseXx/l/CWlk5PVc4L20r5khkAQIGYwDHm2qNh2ERvk6KNXjI0PrmGsy8G6Fl4uGyisNek1TyVSk/6Kmky6Ii/K28HPrYTxlHeuvfbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XI5c1gvNTO4uidI0TLpffB+TOiUtrjMpiX6aELL/aqY=;
 b=Ba9yWffbqVD0yH1Qwky7IzPwEiCVh5dnVYBhSoj2bWFLMrycBNUygSdNg33YzIy9SKZVBHCNAy+F7lKUc7rYcqNv1F5ADzG0isHNOl4vMBiMg4Yvxn2RdkE3BIHtyCzzXs0p8WnaAEH6dKX0IOJ4RRCp3uPbYqXXCHGHwIl9rJLvt5oaHBkST1PjgBebpGdsOx6Ss+9iLql7jEnwMJtajqHOXMHks1KTIu4A8Fh0qTBBAHNNmnPX6kcjcl8FIyM/0ANC3lAKzviwXUSwHYmh/Y8qvvTLfCSMhHQtEB+tRbieK+KtYQIXrD02JAX2sIY13QEGoDhGgI6Zs+7o1O5iag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XI5c1gvNTO4uidI0TLpffB+TOiUtrjMpiX6aELL/aqY=;
 b=UFuEHh3AXwlrirj9MUXb1jJzIaVKE9WMCCqmSCRdRcf2viPrlFR0kUTnarfJbdg6oKILYMQlSllmhSPGfpgSz0ChjXJ/A3pyeB9IIfRrm0bopP0YZvzLkN+MWE4sJuekuI8ESfmieDMk5rtAkfT+dYo8BQsg8jqtcXsOQ33NJfNo265qqcSw8ozOfHpZ9vGhM+PFHN8fbxR6Taza8pEUmqZQiF6IWDBT6qoCE3/oho9btY7msrAX/eNkSS5EBCq0NvlI4oEWHQSCK+edAjBTAQEoD3b1/RNQxrCe+Aiad/C++yvbLTIplBZqbrPDiMgTDOU66iEWEqmlnZkEq5f+jA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7502.namprd02.prod.outlook.com (2603:10b6:a03:2a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 11:53:29 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:53:29 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
Subject: [v7 00/26] vfio-user client
Date: Wed,  8 Jan 2025 11:50:06 +0000
Message-Id: <20250108115032.1677686-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0066.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::14) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: e73b4d82-c277-41a0-e6f8-08dd2fdb1182
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uvonOKALa8GpohNIKyjpD+0tfT2SrTc1496elzXT6LCdPOGatrXQkdanEXmV?=
 =?us-ascii?Q?By1NNY5b00jHcRHUa0dTJxbDiJlWmjGp0BMzyt7vkQMu9BJrmOquy/azWIN0?=
 =?us-ascii?Q?hYwl1TRgpYr5Oo97d1h6McWbUr2NfJFBsU+FGMnWTAxfMQwFaO1cNmFsoMM1?=
 =?us-ascii?Q?kcJwMghbT9w/6hr4BStnASPkDz/4An61AnjDkpIk/7m9QNCylmJ/mtSlZXFP?=
 =?us-ascii?Q?q7i3NkTVea6tuKwJPymD30kY4GBRlx/BBdfJSoM6mHUjPU0VNqijycK8lfxX?=
 =?us-ascii?Q?8jQINevpjH/P8FF3iESa+b/XyvHLH2VJ/vMkuhsgbMP1iyWH8V80Am62wbyU?=
 =?us-ascii?Q?HrSvZanjrOvOuzceVM2TsnSrIy3r+ZpkmzzBucqSwFjKjQL3KO0tOmPCAUR9?=
 =?us-ascii?Q?gw2yg9kN1FwXbmHWUpkXUaccU0WY+HSVt0exAjfV8Z/62gv/zB/QPkxvwLwI?=
 =?us-ascii?Q?GIN01YKd9FZhKKz0EeaZBypEXsSCU21852WCLr4HqH/Qv9+08cZimil+3NR9?=
 =?us-ascii?Q?b/qQbTfQyJpenlF3Lwt8Hjq+sEa0/z75Iz1pL6wIPacrd5RvEYghS5FdGRqv?=
 =?us-ascii?Q?/49hNLjvnFHNntMpeygmDQy7eekp7Yjp6M5RI1vtO6w7sbvDXYBLH8iJDGHF?=
 =?us-ascii?Q?N3UmjivjLNpGSsW/dbNluwQi5nOTG7bH2vrCMN1C5GG8QCeI8fZlD8lxwv/V?=
 =?us-ascii?Q?5YPz8zUxt/qGipVIlj3Mqi4EPXpsaC9mlRYSc4y4lx5qRso3yZopoIswIhyF?=
 =?us-ascii?Q?mtwpsCmi0XdfqLjGrtmn421lRyIHCehp+nw2uQiCGVKoQhWxsA/8Kh24uHDT?=
 =?us-ascii?Q?Ak5RI8DKYRhBARHYLfikji7oC8/2PkHsasampJ7lkAs1jycw+mM4fl/Q5j7E?=
 =?us-ascii?Q?DyFSc4twDe4tlzmCIxpX48te9LmgMFbvRUbNi4g+mS6u0nmPXc406ddHaPDl?=
 =?us-ascii?Q?mFD/9L0UYlAoF4Lk6pNrWF8r0YcaKA5Ve5AZmqMxL/3W8QXnChHd58+ePsIL?=
 =?us-ascii?Q?xwXtoFkhRDXWGGwSC3MkpC10JibLOA3PMZehUi8U7pA6H7+eCN5UzosPXu+o?=
 =?us-ascii?Q?4ZVPFnste20c7BdftStHilbZsYbMoAXg2zCKS/+G25G+Hjk4zh9W0D9Sk+u6?=
 =?us-ascii?Q?LFcEbpKz3V3X3ljM0RyO9/ceh30wfCl5k0Ns9OpUAVk7oFOT9u/kWV/o8TnA?=
 =?us-ascii?Q?S8WF1BkKQAwoNqAq0gFOFOniBaKGHCVdClscFvNFVRvwj/nwEvFlBvN45iOh?=
 =?us-ascii?Q?2c7ZNqZVTCTgmCb+XAl0lE+CZbTuCzP4l9umx7D3noJabFdguecFXSK4yV2w?=
 =?us-ascii?Q?M6jxKCC5JVFiMCZwlcRLX6leQqYDlIaat7EB26ulgh1aL7yY5B+qnm9nlYMC?=
 =?us-ascii?Q?NWhJrHJdlze6wCLT8qafdJUXQgDi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8o1m6/7kO7G5ncYLW7dODJ15CpdrYrm4XHKOfcT0fhM7ISiJoHTXtcLTYpJl?=
 =?us-ascii?Q?XJIwn8UfOaDovdPACmnB4kGvhB+wU5EGIGy5XGfCApcewzQREnpym2NgFD4H?=
 =?us-ascii?Q?VD5jklx14JJ1T0sMEH6F8cxJL5MgFI3Iu8MhTcTVfsiEaMaO2bK3ix+5v2K1?=
 =?us-ascii?Q?UwifvIItuDNsVeZRW4bK0uFtHdTRCR3LUM29ZkxugPzeCwVfuxYb3UWIbp6+?=
 =?us-ascii?Q?/0FOQO5TVxRAIHweflHfFbQ2GwZgVbWIE5rY8OzDmMiCTBBIgEK3qnLCUN93?=
 =?us-ascii?Q?NZsprkbiboI9u4syFBj01Qb7AsDg3b0summ//gDDQz5FTsMIW4mOOBiIjs1N?=
 =?us-ascii?Q?FkKd3W2DBc9EEkNQGzVJ7dF/s37eTf1+6Akxd4iVWhWRUxFP28Ciear7WNzQ?=
 =?us-ascii?Q?tBqN86ncPstZkRoi6i3tYuZP5Fw0OBHyae67t7r6NtpJIETjWj7kMTt1yJ1l?=
 =?us-ascii?Q?PIxbVeKi1Knpr6txXOSh6v/TYEzpyLIdrhoLatwEyqT1VI+/bnocGG0Sl7T9?=
 =?us-ascii?Q?CS2P/673tvot4eU8gDnPZchwdzDUHOR2A/W7vMh1O8aCcqycOfvylSJatV2m?=
 =?us-ascii?Q?V/kpN/JYa3DIjRS0bXd6nQJn/vx9M7cZAtKjPl+AwazBgqgNxM7v1Cl2U47S?=
 =?us-ascii?Q?K1LjPgxyzLfmbKvdNfFF+mgB+nfbD5zm/lwXoM9dKa8ClQB02J11o1OLxBIK?=
 =?us-ascii?Q?R+6v6AcGSAra/cp/d0IGVkviLE3FOQOpEDCEbzfp+d10I7Fx2K1/GIRkOoBh?=
 =?us-ascii?Q?rnHV0z5X578s/R5eN7aTYPiihwyj0tc9ZT+ThwGFycEluNByO6j35ompyLkT?=
 =?us-ascii?Q?91g8Aq2twXrhWFhRpl/PCdWO7/a35TzuYJ+jZYuPTOhAh5e8DhCydx/39UJ2?=
 =?us-ascii?Q?MdJx87F/xWlMrqp+tVJpk2iJA1JYIjYzz7cl34liz8l7LExdo2KhKnkU16OL?=
 =?us-ascii?Q?BCW0y40LHqoI7H+aKz/4xl7ny3NOk8wnmZAZU9EJ00PEAo512uO10EyXWWX/?=
 =?us-ascii?Q?SD5bMWVKh4iDqixgdh0qzq7srPyMoMPdkfx2jqpsG3ctGlEeM5me0IFKwKXj?=
 =?us-ascii?Q?W4u8HGrFRG5elSpTYpICINqKJ+86MgtUvHxI25XEvVOzmJc37J+KseNDXcZ4?=
 =?us-ascii?Q?tL8BN6N9C/bWay2E56wpcn5GxZwFB4N+9TGGgfF9KK0h2z7z6hZm3HHxuJm6?=
 =?us-ascii?Q?xFdKrTmvuWe9mvzWtoaYe1011SciZztz/VYGZq32ufHEwvm71+RcgDvzKO1x?=
 =?us-ascii?Q?mkLs/QaKZykDsazJ7AX+DtdUOoZIASwGuU5lENAt8XAE25irZltB72zRu04m?=
 =?us-ascii?Q?Ma+w0mpt6Q0b/5DMId7IW0QiMazsB6rDyYh0C3aiVLPwvBV6dgKfBPytb+fC?=
 =?us-ascii?Q?groSlTauBCyUDl7XbFzRW0/pz35bfeWMdF1tn6pr2zzJlN9n3DMqK6U6Bk1e?=
 =?us-ascii?Q?2raN4b+F//MIy2Hl1DrqVMk9v8G+JptVLiikChgpE/7ZEZQsMypcVmL/YCwN?=
 =?us-ascii?Q?rWL1Lrw5pVtiVlzv06wdz7nrDN3LZwi+Bqaca/WKV4qC9CgId2VZAnWOGbLw?=
 =?us-ascii?Q?n8XqSGd05vRvK5PF553vMFTRjIWoCbJqJeAlkL3B?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e73b4d82-c277-41a0-e6f8-08dd2fdb1182
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:53:29.7132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arI1bRhJF795bv+a/BS1lZCF5ivbTVFc4ORs7rpe5YlOanFkKYEuprSHmf/FqzhZ0RB2HQmii6bvaXePR3cMiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7502
X-Proofpoint-ORIG-GUID: g4t_A_xzsHeAEFTjVvW6D83vnSqpsM-x
X-Proofpoint-GUID: g4t_A_xzsHeAEFTjVvW6D83vnSqpsM-x
X-Authority-Analysis: v=2.4 cv=YLtlyQGx c=1 sm=1 tr=0 ts=677e673d cx=c_pps
 a=ZeveGGZnxkNpWlA7A6AaFA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=DsmJ0Kfg8CFGwcBQzYsA:9
 a=zY0JdQc1-4EAyPf5TuXT:22 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_02,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi, this is the 7th revision of the vfio-user client implementation.

First of all, thank you for your time reviewing the previous versions.

The vfio-user framework consists of 3 parts:
 1) The VFIO user protocol specification.
 2) A client - the VFIO device in QEMU that encapsulates VFIO messages
    and sends them to the server.
 3) A server - a remote process that emulates a device.

This patchset implements parts 1 and 2.

It has been tested against libvfio-user test servers as well as SPDK.

Contributors:

John G Johnson <john.g.johnson@oracle.com>
John Levon <john.levon@nutanix.com>
Thanos Makatos <thanos.makatos@nutanix.com>
Elena Ufimtseva <elena.ufimtseva@oracle.com>
Jagannathan Raman <jag.raman@oracle.com>

Changes from v6->v7:

 - removed BQL dropping - caused various different correctness issues
 - fixed incorrect list iteration in vfio_user_disconnect()
 - fixed short header read check
 - marked vbasedev->mdev as true to skip host iommu device setup


