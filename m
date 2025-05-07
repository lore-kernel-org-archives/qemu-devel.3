Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1260C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 15:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCgZn-0004V9-DN; Wed, 07 May 2025 11:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgZl-0004Tc-KK; Wed, 07 May 2025 11:20:49 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgZi-0005of-Kv; Wed, 07 May 2025 11:20:49 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5477OkeA027452;
 Wed, 7 May 2025 08:20:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=I7AensChvU6p3
 2/c6TLoLqqDHfEYuP2c1qeU+FbOjok=; b=SwYz04lwR7WTT1QOO6M5S3vNh9rYB
 kw0qRtIAUScmf3rPqJ8ag5gadfOUMRmGWmkeqYzAISyVaTHDrWb261UGA6JwSmXP
 pqCuNUReK4MR4lW3vx0c4ge1wQkCIiDBAIhvA31axGEUScc5Jqs/emSGhoMwDPxa
 uJaCjj3BHrCLW95UXs+LoGlATYB9umUDZc204l1WMD03ejVsYu4GhSrAxMmMUnHd
 Hi7guV9POwJCxfW7gY6nK/SUsz0eXiwKqP0U3XH7bVXLLBexsc60dEo89ebkNktc
 Ten4o5xgryNr+q45lcZnwMS223B+fkxK5IucXny5GeBlEcsdWMngCDpBg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46djfc9bum-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 08:20:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvzU6+Uw2GVrzbfZZfQvmvjtl1w1WDaMQJcQv3oheuboqSDUn3U9xR5yfmFD+UcQdB0eZUtpFKiruA0aTB/BDslvEpe0ap6HkNesam4SCTC/HpZp2VktcIuhYW6Pa7+mRcMn7Wr+gfD7sN5p9a4D7uQAeVmvkQL/lJIjjhMHar2lZNxBGa33MPW4/Q+f3oEfU2IERcOjkYeJIVs7V9MRqpOey6EGW+1AXMjQQuhBNJlaeKo8Krl9Q6EHfMWm4TTBFbRP9+faA8wmwoBZxSeXqrarv9v9KAKyTTSzxGci21yecFSNZl+2OxGEqpdAn8uJexsF7Rl6CwBMOyBRYFjlRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7AensChvU6p32/c6TLoLqqDHfEYuP2c1qeU+FbOjok=;
 b=Iw0MMV9i8HqhNzxgb7FNAne3eR8S4g6QpQqt0yGJDa5xKFU1PziNTSzUbHtfuNkJb0VFNFUtd1+nfxE0YgGuVhZrpC6z21gxxDGBzOfzl/Nv7yyIui/HpqoFpXVq+Bh5HCJ74VkaNN71km1S+bT4iQhBRKr8Whj5a5CwW6Pkj6ju+HexFH/wN9yKTTG8YCIzKvtMFa/R69mvjJyp9jB3PbBtFzTXB0NWj7FGYiqauKEkBM0kvSOpvKJwCLxmCV59huORHFaIQDx0ddu+kUBHQ2DxOk8Mk+FpNy6V9SmDeDT7pLdWTnq19vmUT1N84VOKO3nco7aV7JpcABbe2v6izQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7AensChvU6p32/c6TLoLqqDHfEYuP2c1qeU+FbOjok=;
 b=rqQ3XlmjTsuTBnQh9yGaan43JlxjmO4shxArZBhlkUtdeX5WZbgWqbyLlZWE4Z4wtQHnVYrqyDlmV7oXcZccdOduPlmtHJ5s2GmUcNHkxqCHPbHVArjurIxDK+lHOZX9T/iIJDSqKu0CXQGTelfCTZAESMRmRCaXy94y4VBCOk3uRrdpXbFCnHeZSaeWdKrapIehzaOb/zFP6FU/6oJAMFG64XagvoFVaKlwXvo0sJ6k40+Ngn+tZFhFp5Vz3pXjkjqSJtNLE+j476d6mggohtNLHVPKc/CdWRgglaCN6ces7kYuy6S97ZYgwQ7ctZl/vdL1v0xqHmUjsvUTaYF3Pw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BL3PR02MB7970.namprd02.prod.outlook.com (2603:10b6:208:355::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.12; Wed, 7 May
 2025 15:20:27 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%5]) with mapi id 15.20.8722.011; Wed, 7 May 2025
 15:20:27 +0000
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
Subject: [PATCH v3 00/15] vfio: preparation for vfio-user
Date: Wed,  7 May 2025 16:20:05 +0100
Message-ID: <20250507152020.1254632-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0055.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::22) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BL3PR02MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 147c3871-a65c-4608-4f91-08dd8d7ab21c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFZXTjFWSXhSeEtnVTBzNzNtZWJYUnhnS084Z1dEYlA5cnc4RzZMeEc3SldI?=
 =?utf-8?B?cGRLWVFaQ1FjRVYwZlVrei9JQXNOeVhXQjFHZjI0bmtwdHlyVWQ2dEVxaC9s?=
 =?utf-8?B?eGUzdEVVM1RJdEV6akNVMlk1Z3FVczl0cnhLNmVnRHFRbkdFZ0dPSHZ3VC9y?=
 =?utf-8?B?dmtBTUNSQmhZc0NBb09Nd2luRGFRaHlkMzNBL3poUjZ5ejdZeXRIOGlnZnli?=
 =?utf-8?B?NFFFcGUzcStYWXJNMW1FaUd5ZHpSbkdVRkJwWjVQdnhvUXlnTlF1N2tndWR1?=
 =?utf-8?B?MDdrVDUwZjVPcHppdjd6TElNSWxkZVhlazErQkdWc2c4Q1pabStUTnpxUkRR?=
 =?utf-8?B?K2pBK1F3QzRkWW5JVEVtQS9aRlFwVzBLOHJkSS95SmQ0dWYwMnV1NUFsanhQ?=
 =?utf-8?B?UzNLY3VzQ2pOdytQd2pQZFMwNzNreWVDdkdzUkh5UlpYdUdPZmJTTlpWTHNM?=
 =?utf-8?B?WG9kSm5BOUxrMnZ2YVdtRm9mejhHbjRDQnowcUtBaUpFYnpEQzZ0amM4V0pY?=
 =?utf-8?B?ZXVnWGVyd0Q5WmRSWTdMUTVNUHdKbHpEQ0o0OHJwZlpFY3RmWnV0ekwrRm93?=
 =?utf-8?B?dFo4a3RBRXdVK2xzZjlQZS91Qkx1WmwvSkxNYWFLVEVQNmJzbTFUZjF4Mk1z?=
 =?utf-8?B?NWV6U0NrM2FMdllvUmthNnI1c1d2YkxxR1ZkZWx2Zm0zQjlTRGM0OHpyYkhH?=
 =?utf-8?B?UURZYzV1aDNSbU9MaUhQdnNIT3JpaDE4TExmcnBxOGNFbURVUXpydkdTU0Ur?=
 =?utf-8?B?Qk5MMHBLZkN3c3ptd21HdmJkbkZGWnhyTytFR2FQcDhmZzVRang4K2RZQXpH?=
 =?utf-8?B?VXJNcFFjVWxTVysyYTFIZEREZFpaQzhUa3hBUUc5cm5lSmpoTGlEaTRSTElV?=
 =?utf-8?B?SG8rRWtvUUR6Znc4SCt1RFp0VU1QNFhHczVQL045aEhiV0tJUU9uTnRpdWZV?=
 =?utf-8?B?b1o0ZUtsbDVmNzFWRDVVZ0oySGdQSVRkZXplaW1iQTVUL0tmYkszc2I3c25n?=
 =?utf-8?B?eFNzOG5PMVdvbTh4ejN4RFJhQUE4M0VhWms2VXp4MUhNZW9kNG5qZ1ArK0VB?=
 =?utf-8?B?UHdKYjVuRmg0MytlM29FK1c1MnZTZFBiM0t2czdWaWdwYWdmNVh5cE9JRFFo?=
 =?utf-8?B?OUpNbWdxSERtN000OE5OOVBEUlF4aDFNNG41bEtlZ1gzQXhrZVhKZWpkV2tW?=
 =?utf-8?B?TGJoazJKTUdaWUVHcjl6cTVDOTlGVEY4ZkwzUVg1UmZmTzBXYytOck1ERW9u?=
 =?utf-8?B?cVJjZ0Mvc2NVdGRrd2FTNm1BWHRmOEhZT1JEWDJmVG5qVnhzVUZRKzVyV2g3?=
 =?utf-8?B?UUpJVmhkbEk5TEdNWUVNRDBFZDBnUGRSanVTUnI5NHprTVpFOWpHNE84MG0y?=
 =?utf-8?B?cjhHdzV6TUpRZ1FQMW5TdWhnOGw2MkFvSjFZNVlFbWhWVk9Rakc3bnVobkY5?=
 =?utf-8?B?QURFQ0Y4ektJUjlQcUF0NDRWd0xZLzV1RWZQSHlxL0VUeUtMRDdZQ3FQMW8z?=
 =?utf-8?B?bFVtOFBuY0ZZdXA2K3czVm5xZ04vKzJ0aG5Ld2l2N3l4ekczMEIrdE9VWTQr?=
 =?utf-8?B?U3RRbUt6RlREUHhNeHNCSWYvMGlpOUd5TjllUkplQVVTd2M4REZMaForWlk1?=
 =?utf-8?B?MlVNVVdkWlppbGtNek91dzFwbkZLc001U2UrZ1hJTS9QeW9sUkU0a053aVhE?=
 =?utf-8?B?cWlnOG45enluUm44OUFKMDhhM3RWbGxOZ24rdTQwc1RsQ3M4dkhRUHlQeXVo?=
 =?utf-8?B?SEhyQ2F5RGpmSHgrSVJqOHhEOE8yQ2p2SC9aV2ZiQ0RVbnRwRjRjVnVpVWRF?=
 =?utf-8?Q?NXTGWsNp7u3NQDFwA0VXfFQdPsk3UMulL4aQY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3VEeVBOUlN2VWhqdGpoVFVBNUNxbVZDLytzZFN4cEFNMHNEL1YvMEpFSWhB?=
 =?utf-8?B?TzBUaDBqY2JtTGJ2NDJ1STRVTU4xK3JPV0JkWWxId0FpdEpHbGFmWjlEekFh?=
 =?utf-8?B?dzdFOUlITnZiUmZjM1pYVUlsbVhSTE92NkxtbHRycHBKbTI5ZjF1bFY2cXRD?=
 =?utf-8?B?L25YMmhvRk5FdlkvMXQ3UmdOMXB5REFOOGxIYi9Vb0hhcnNoVThuNW5jaUE1?=
 =?utf-8?B?cHdOVVRHaFFqcG1FZWwwWVNxcFVoY1ZnVEJtcmpHMlluNGVJajBUMmlvSDdZ?=
 =?utf-8?B?UUpXNzZWTWg2dEx5VmZIRHBIMjBOeHdIZ2dZWWJxUmk5NWxaVk5HWUttUUFO?=
 =?utf-8?B?dzJYT1BFK3NXU0pqdFdGWnorYmt3dGJoMThKbzRFMXcxbHdER3JwelB5c29s?=
 =?utf-8?B?aVMzWDlibTB5SFpQREtJajAzdmJBWGhTZXdUb0R2cXhGMlplSlFKWFlTYlh5?=
 =?utf-8?B?a0tjOUh2aExNRzBVWUVOeU5mZktLRHphbFptZUtJTFFPZ096SDhCdWg5ZVJT?=
 =?utf-8?B?cmUxWHJUcXJkNk8zVUlXNjZNU0pSY3hpMFlQV0NwNFJaS1Z3LzdNTmRIcGw5?=
 =?utf-8?B?NDhnVlRHYnA5aEl5aGhtQk12Q3hxcDQyNk5NWjBsZ1J2b1RUZTN4aDlTUTdE?=
 =?utf-8?B?T2VycS8weWpFMTg5NG5pK2R0TEZDamlZL3VMbFpJREtTaFpiNlptd2JvcHZR?=
 =?utf-8?B?dHJtNTBCNmJianBzdkpUNGRuZXR3NDk1Z0ZxR3MrTUN6L2YzRUhNdFF6Q1J4?=
 =?utf-8?B?N1pKVU5sNXQ5VjJQeDhOYnloK3dsd29qNFJ0ZG1WUXdhZnZsVTUxSVdwY1Jm?=
 =?utf-8?B?eHNRZW5RUnBPaFJFMTFjVXFlVHRrdTdjemduZFZoMWhLbnBNaWRYeTVPWk93?=
 =?utf-8?B?akoyNTQwRFRhWlVtZHphQXFhWHF5OFA5TFZubEphRjBxaTdlNmJObjgvOVNW?=
 =?utf-8?B?d01hV0xDQmVrMmMwSE01bmlFNWllVEFoMy9ITlJuUkNsVS9CV1FnbDVyQXl3?=
 =?utf-8?B?ekhFVGlIM1VlSUpXNk84MEJkZHMrU1BHNGxSMGdWZXRWdGc4bnlyNGlrSGUr?=
 =?utf-8?B?cFU1TzBSeGNyaG1vRjdNWU5PcUZ4MFJRazVEZlZ4a1B6Qm40RThDeVVwR1Vw?=
 =?utf-8?B?OVdxQ2FoanZtcXNibTQ4MmVoZmFkL3ZJUjcrY3kxdWZTc09WMmlQaXdkWHFW?=
 =?utf-8?B?YzE5OGhxdkpvbmNiamVLZWptZ2pncGNLSzh4ZklQbjIxWUFkQlFkdHRJK1Z2?=
 =?utf-8?B?TFA0NFhYTGN5ajhoa2ZsSTkwV0VnTnFFdTBodTFvNXpSZ21IMzdqQm1CVG1Z?=
 =?utf-8?B?VzhxN0sxZXd5ZE01VjFYcUR2bGRQTFlhbnlXS2o2aGJiaGZLcnZpRnIyd09S?=
 =?utf-8?B?eE1nV2VZVHNQWHJXNUd1aXJXYWVobWpOQ3ppc05CYy9yMEhnK1g4aWlLdlR3?=
 =?utf-8?B?eWJ3cVMzMzk4amlrZ3o4STFkYkRWU1VEUHVIVHR0Skl4WEs4ZERCeVlWSVFN?=
 =?utf-8?B?Wlc1a2ZrSHJCVFBmbk9GVit3cU9ud0NjUVVHd0xXdkdaamxzcG9leDhLOCsz?=
 =?utf-8?B?d3Axb29CaXk1VFhlZXpON3pLZ1lEMGY0LzVLVm1EZXAvakNHQ1JNNHlzRkpr?=
 =?utf-8?B?TzdaTTRIcmU5dDRQdDVYYXRqRm11Y1IwNytZbjlzdzdWRzFmQzBIMXpPUFVn?=
 =?utf-8?B?MVF0dDR6RWk2MHRXdlNlb1ZjVmthWkl3OGs5NWY3QTJYY0tHOXlvVGM3ZFgz?=
 =?utf-8?B?SHgydEF4alQzMXBCYzl5S0VPOU5FdnZqK3phN1hiTXRUeXRqcHBqdUl5cGFu?=
 =?utf-8?B?VC96ZE1idDd6RnNWNFZtcm9yOU5rK3UwTTI4ekNlZVFQSmJNRTE5NlQ4ZmNW?=
 =?utf-8?B?QzNjRWNNck5TY2s3ejM3NzVNc21PM1ZtSVVrb253UkNsTUR1TWZrdzBwM21K?=
 =?utf-8?B?d1ljRTkzeDdNclZoM1BtRTNCZ1QzU0lqKzZZcjJxcW1PZHBjLzdJRDVRVWc1?=
 =?utf-8?B?OVRWeHNxZzZQQWlWNnN5QjVKOVg5bjlnbWJTV3JpUVlrdmJsck5OeDlHMXFK?=
 =?utf-8?B?eUxwWlEzTU1jY2dXSXdhL2Y0a3IvVWxMVjUra242aEwyb0lhOXNkYUVISFdw?=
 =?utf-8?Q?jcdeoIQA0hcu/KHsaAjxHAFEi?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 147c3871-a65c-4608-4f91-08dd8d7ab21c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:20:27.2212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGf4zI4wfYh4mlze/6WPoT3v9Y/0rZZx0/IokAUfJRjBH8N542W+9AgLvG2rNbBJNNTwHd99PWY193HXExFTcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7970
X-Proofpoint-ORIG-GUID: 8iXZkUTaDpY5Og5EotEQWHGtemheKfFn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE0NCBTYWx0ZWRfX1yTufYgP3DXT
 svfc2JqfKwzIFZj2YtORjf2XU808Ru9DUcE3lpLsq0w4WaOcXctHXgX5006/50+17Hb/gpFmY2N
 JBUSp8ymIbn+5Bj+2Vsq4X7ihzsZG55x522V3mwQK/LeWmsb7nSb/EAD3JLvRvf0o5jQ39yvtGL
 XNh/3p1ddf5OjTc2zUojKp8S5p6iPFKYWZnk4LdvVtRBDCuGQihOmqF/U1VBQB3dXnMwVz18bzE
 lpYsH0JAmzFO8i8qaGqcZgqXKApJXeA152iQm9KRBik1kAE1Ag2yfeG2V0mORwCZWgdywOue+Mh
 6+4c57VKvKyIjm+FAvYEYPCdilVdQBYN0gQjccNBe032mYGRTb1IGS5/HW9TL/4bPspG4tk37B9
 6k50swAT5HQyxUqG5fScRK7Vh6Z9URmeYmnxFjBdHZnaOakBRqMr4piOgCRqIrJeMZZjg5BS
X-Authority-Analysis: v=2.4 cv=Bu6dwZX5 c=1 sm=1 tr=0 ts=681b7a48 cx=c_pps
 a=v3ez6FdVe4RSF1xj2bRqRw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=NEAV23lmAAAA:8 a=GaQpPoNlAAAA:8
 a=64Cc0HZtAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=Yu8DjbWdRu0IdcvBYgkA:9
 a=QEXdDO2ut3YA:10 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-GUID: 8iXZkUTaDpY5Og5EotEQWHGtemheKfFn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_05,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi, this series is against the vfio-next tree:
https://github.com/legoater/qemu/commits/vfio-next

The series contains patches to vfio to prepare for the vfio-user
implementation. A previous version of these patches can be found at
https://patchew.org/QEMU/20250430194003.2793823-1-john.levon@nutanix.com/

The changes have been rebased on vfio-next, and include changes from previous
series code review comments.

An old version of the full vfio-user series can be found at
https://lore.kernel.org/all/7dd34008-e0f1-4eed-a77e-55b1f68fbe69@redhat.com/T/
("[PATCH v8 00/28] vfio-user client"). Please see that series for justification
and context.

thanks
john

John Levon (15):
  vfio: add vfio_device_prepare()
  vfio: add vfio_device_unprepare()
  vfio: add vfio_attach_device_by_iommu_type()
  vfio: add vfio_device_get_irq_info() helper
  vfio: consistently handle return value for helpers
  vfio: add strread/writeerror()
  vfio: add vfio_pci_config_space_read/write()
  vfio: add unmap_all flag to DMA unmap callback
  vfio: implement unmap all for DMA unmap callbacks
  vfio: add device IO ops vector
  vfio: add region info cache
  vfio: add read/write to device IO ops vector
  vfio: add vfio-pci-base class
  vfio/container: pass listener_begin/commit callbacks
  vfio/container: pass MemoryRegion to DMA operations

 hw/vfio/pci.h                         |  10 +-
 include/hw/vfio/vfio-container-base.h |  21 ++-
 include/hw/vfio/vfio-device.h         |  82 ++++++++
 include/system/memory.h               |   4 +-
 hw/vfio/ap.c                          |  19 +-
 hw/vfio/ccw.c                         |  25 ++-
 hw/vfio/container-base.c              |  14 +-
 hw/vfio/container.c                   |  62 ++++---
 hw/vfio/device.c                      | 183 ++++++++++++++++--
 hw/vfio/igd.c                         |  10 +-
 hw/vfio/iommufd.c                     |  35 ++--
 hw/vfio/listener.c                    |  82 +++++---
 hw/vfio/pci.c                         | 257 ++++++++++++++++----------
 hw/vfio/platform.c                    |   6 +-
 hw/vfio/region.c                      |  19 +-
 hw/virtio/vhost-vdpa.c                |   2 +-
 system/memory.c                       |   7 +-
 17 files changed, 603 insertions(+), 235 deletions(-)

-- 
2.43.0


