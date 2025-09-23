Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5963ACAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 13:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13TL-0006H3-Hs; Tue, 23 Sep 2025 09:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13TF-0006Dm-IL; Tue, 23 Sep 2025 09:54:17 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13T8-0003u0-Jj; Tue, 23 Sep 2025 09:54:14 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N5O4KW3995710; Tue, 23 Sep 2025 06:54:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ZssjI+HG1ush2bjjXhVqimYJdA/UQSpuLjdwHtPgT
 o4=; b=PL90FLn0+GKDm6w/y/rv9zgVbYdKbTceC+7BIguuoVR1BczWYu+7SazHd
 aIo1I9NubdT9bQolxwEHzMkEC8SJsagG49WemLDmwwAH39ipXvk7nIgqSDrB071f
 7nvHn9Li9JndWPNl8YGSTNWnNNREO5sBvdtgH91M9LHXnFhbKwBAsedqZlxg7MjS
 C4xOUf5hb22C9eObRPdkUdSF8VrV/zn3leThd0TBNm5BSDT8rmBVhEWmcY5NquW2
 wn8z89r9NAl8LOGgSYt5zcQnaMe1ndD7hew/6l77n8MGc/dLaq/urR7lIE7VgmFH
 h6r3K43F5gktBDRurV3Kduj9ZOUCQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023098.outbound.protection.outlook.com
 [40.93.196.98])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49b9pjjf9r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:54:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5rqL0qdu02ca9TmCkE6f2LdtWDTxs6+JG9cGomwjJYTV6I2fEbf/85aU+qPiPAeP5L1M4O/bm1glVV6iIYRrDbvtprF6RvDI4x5a9+W3VyWYSfq4Eg5cksZJNmAt/bkkd6zI6TNIhkyLZEl9g6chbzoLPGxk8n1VV4hwlMSquTH5qiH/8Dx3fXtNRNwRWsVxQ5exajm2NE3Ch4f3+VE4aMAoisSSLQYydz9oTz1ZDDiDQXfjELQLyTaapjbx2yRxWrmdpDeyDzmOIdQXKAxg6BhP0qQqkORdaUy4EdGCC0Djqcw1A7MGFb6TUaIVvQaOvmZ657ryycrMSIALtYlJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZssjI+HG1ush2bjjXhVqimYJdA/UQSpuLjdwHtPgTo4=;
 b=mHf3jVgDxjJK7DtQqviNrWFBet5aUxcX2w0xMZmQhWlBLOQzhG+OYPMkdKoMa2mPyg9jbTAXeq9KQbJM6+g+7dip0gRdCOlRRAqXgCWxbbDpXhrW64YP4GJHCAQsIdVcaEjxp8zI/sJpEcU6tPMN17WUxhQKpBKdRejp6MEwDwUZ8/pJPE4gF61jHdb3heQRGXq3u3dJiD4QDYmw1rjxHhAfVlpR3lc7PlMnCIsUKsiOHUwtDg5qb874UdLwYDuZgyUHkTqXP7daZWf3QDGPCFSJ+yjFSdQfXGq9tHn/NbzPzklApVLTO0V0ob3fwUt7c+fWtHEwSo0bVwWUhcHHSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZssjI+HG1ush2bjjXhVqimYJdA/UQSpuLjdwHtPgTo4=;
 b=AyKXXAtj3sLj++OpBgDJqMLHwJQtyqtY8UWf3eQVM1nF8B5H/EJ4hb6W1ukgjUj+rYM7xYndxHIjTnkhlmFdsT/NgjEshZmqRmM1HzTY/fRjjFO9VqOg5TziHfDxRX1ZC3kEK9A1S8svSB23gkRg87sKKV3jPwAHlSIvBsGUe7aPlig8AMLwA+kWmKX5t0OFkgdwvp1OrtIsA7ftb0FThXGCDj/YuRDNNfH3lHOcrKkEkv6xBkE4yb+3Y3pt/P05BKtd3qku9doUJqjXs7tmIq+5SUN0YmeZVWFNE7Tk1euUGAAW50rtWClJajzi8SE0IbhjWAmlUhTunhfFojxeXA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB7037.namprd02.prod.outlook.com (2603:10b6:208:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 13:54:00 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:54:00 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 01/27] include/hw/vfio/vfio-container.h: rename VFIOContainer
 to VFIOLegacyContainer
Date: Tue, 23 Sep 2025 14:53:07 +0100
Message-ID: <20250923135352.1157250-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0194.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::31) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a98399-a158-490e-01f5-08ddfaa8a617
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|10070799003|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aFkDafnPkSn487anWV2x9GVExUzSNJmZ5kGBb2q0swuAl8m0Fz9ZNJOCxwda?=
 =?us-ascii?Q?ldQCcT93lL+4hjlvINKX6RSG+qie7tJmsKCKBIERDzcr9Uu0GT6ghXWjlxmm?=
 =?us-ascii?Q?JA15H0WkZB5LJjY3UZGKFr+w0FOZAavOz/osFK+yzEo7uBq3bkz6GZuTGD7E?=
 =?us-ascii?Q?xW2EenWY79ZxaqbEWKstGsM6vefYcNxxqeb4WrYOZraT5v9lT8i5/gikvwU+?=
 =?us-ascii?Q?X2y3NbxZ23hchXnuOJiSdM9nSfGiBwp5j6yMY6xj+QhupsQ2yWP/gVj6gJ3d?=
 =?us-ascii?Q?zsvYMCHppb5gAC9Dgo/Xwd+SYNtckn+pZ5UufSxVKAKjlgfwbUERh0WTqVh4?=
 =?us-ascii?Q?lvk7cb/VdfJVmQA+9pIVPBB1aeFoHDioAbeMaMqAeeUO95Hip7zBrA6NvgOs?=
 =?us-ascii?Q?eb8UdfN4ik8X6Tvl4DGEi8+fj7CaQ6DPq3xVT1OP1KhbYX2YptGWK1fJw/wJ?=
 =?us-ascii?Q?tcgdSqE6ghhVwkdeCZKPy4ruH6eIV34cHAm7OdO3lWRvZnH+ImxAS2LLSAJQ?=
 =?us-ascii?Q?DckbII5lXLaUOvlgEzXLiAPYa0L97z8smmEdhegvpiq3Kg9vMgWmbtr+oSRY?=
 =?us-ascii?Q?NxzSJyWSnzCPmOOcnKRRHlGPtZVaFOhywFNfJkJV3ofH/xN8deBIea620BWq?=
 =?us-ascii?Q?x3BF+tejahVn2Swvz0v4UTqSEJcGMWEVBR0DqG1g/WaHzFxW9TmtOnHPYzNn?=
 =?us-ascii?Q?5Abuu3Bs0uvvwfeMfoD8B9VuCBJPvwMROTtbiSIVMOpowHwuWnAtf4CduzYW?=
 =?us-ascii?Q?8p6bc8oc13rx+tqSY8+iYDs2nCzt3OqqtJEWbHgrEt8aNa3CNcRDUQzHo8Gf?=
 =?us-ascii?Q?qJCVM30a8lYT8vDcaNFNvmj/30ff40jWFey/iIyFpR5bDAsXUS0uWMsRH4Zv?=
 =?us-ascii?Q?HTCgaZz4L2e/oh+e4/ruqjiIMA2CjCQYS8tG6w1/AjePpGfYB2oX2jnRznJC?=
 =?us-ascii?Q?JcLZXJ0jd8v+8muFzmZQ5h6hGxqxJRFbQz8HgAKy2a6aT3ep1RvB0S5B2BOF?=
 =?us-ascii?Q?o4G0kgEJNHBB6eKtVSX+yVCLQNF3F4QYKs9yzNJWug/ZYx4eJsYea5guu6aZ?=
 =?us-ascii?Q?xRMhYPg2avVfYPSKKijatCZnbwYCttw8+IalMssUc6B3Kv6iw7Y4L2Je7iKb?=
 =?us-ascii?Q?Vks6bcY6mJiHpz8Bxd9aZF4UaCMYEJuVzMAWztg6H6+W4SttbsUQWQyDFz8h?=
 =?us-ascii?Q?IW08LVjmdSw/H7AS9VFPyP0r8YuqxsN7fJFnZ0VvtO6cGsyy5ndVcY4VYwoz?=
 =?us-ascii?Q?OCoLWn+tnBIhkJP/elDXKZxYWdNSAu3yXOLpJpMTxofB9ZwlzKMco8CKLq8/?=
 =?us-ascii?Q?HmgoFtB8fvGwb8t32gM7uZrRQra9z+sFRmxeWviZOGo6hApXy333qCRe+HXz?=
 =?us-ascii?Q?ZVuBYXEmNAkUjkkxRQvy0HSH+W4EJ2Koc+HCv/h1SZQuzCm6SB5HFnyUWccj?=
 =?us-ascii?Q?Blb0CwgJjMhGgOl/Fg7ecYl5COKKE8Hy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LPK5txLXsz4LQRC4erNjnKnG3iDs0f7OArADNCmeZzfFbbrfkkltsgmTW8Ch?=
 =?us-ascii?Q?f8EBM/DEIMJAmUxyQfSbbWz0IP7RLb7ILevHdsswzrGn7TTqXYCPmi78lC+3?=
 =?us-ascii?Q?yBE0EAM3eb8O8jfA4V4xpyl7XGuAdtpFXd1OS5OdiBVGF5G86BnBG8bYx1GD?=
 =?us-ascii?Q?S5aa7KnlaRe8i5GldCWl5iR4f5W7nguBLA8mIk4oCXAi6XUzZV1rtCQLClGr?=
 =?us-ascii?Q?/FLD+essPRtc/s5WUhqmBrZqrr/Zc7DVBHo0uyfEqGKwpAPoUGIX3ChbfLtJ?=
 =?us-ascii?Q?5hBxPJCtNO+klqUsjba6MYZq33VOpVvWjep65PI1O5twkBcjvPHSw8NQvd++?=
 =?us-ascii?Q?+Y0/nGKz386PF/6XXs50qTa4I8TBe22F4PigyrBPSheqdYKDTbFOWmKd4ZHk?=
 =?us-ascii?Q?a8oCzWXcr/8z1cDlRnCr1uTitI0OUE1yber/WhTTHPv12oQckb4AYM/lak5R?=
 =?us-ascii?Q?l/cyRjNoyiwUPGmlCBL8CaCIHP30IiOXnrGy3ZIHUeCAsV27Qa1HaK57sF+H?=
 =?us-ascii?Q?K4HZsBPcZwuiWL4G5idpbLAhjEE0pkVwFgAwxOuiSRUUsRyBro3ckqqK1TyE?=
 =?us-ascii?Q?gkys+ob77z/XK/IYP1BRZGNaVxexol8J9l+YOLpBRzA8uGEc1l/FSX6tp3B4?=
 =?us-ascii?Q?smb8lgUED+A4Dq0ykkyYgrNrZ2byIUgrmixtK0PRbGRWd+oZ//l3NoZQrYRb?=
 =?us-ascii?Q?km2Kq453Vr7fK7cAw4EvcfJtweYREmwRIzojojudRJddCWDR+UjXrghYxd0N?=
 =?us-ascii?Q?aGUTFaQ7/UThOS/jnbBrFMk0hAa8R8SP99EfBfXZPEOQ315IuU5F7DOM5AC4?=
 =?us-ascii?Q?VbpTds8jHpj6ymgVaxQvxWiY96iDhvaAid7aE0X95Ot6kzBSbDZ+SLBSKGaI?=
 =?us-ascii?Q?I12/sw7Gjn3kp0Eb5+vEPbBqKE8iF6y29cR3iW12ql5PmBZqTWs0pIBXzI7t?=
 =?us-ascii?Q?XzBcnSNhIp6ikxO+vdxqA/kBZUf4qc8eQN/U0OlF5+gYAJEa0kIe7uPh4F7o?=
 =?us-ascii?Q?qLLroNMzQfGjeTRx9rOfgUo3cTPTg5tfAsP6fs60+3Co+JH6n8MfkanGXusA?=
 =?us-ascii?Q?HhBfemDSQ8UralogwVjOUwepivI1ybJJHpqbx61qcQn+k9vpyfZL6Cd6VC93?=
 =?us-ascii?Q?VtdmBVmqqoJSHWH7KPHJdcxVoBhRKaCYlqxbJ/0iwzlYexwPYiv8M1sNRuwi?=
 =?us-ascii?Q?KQt/oNkyHwLBPKZiaAoyc0bEeu88A2o5MqDzw3diZvEIukNWIyHhYZfkJYf6?=
 =?us-ascii?Q?erMFmjxbzNiJsKvZSFOgaIszPj8PUyRtHVIc0g7ijIgdsO6ydMuDC2zLKLcL?=
 =?us-ascii?Q?ifeAPcEk4q5Uq0xAU6jUUQiW997OVWNSCKjaJocm1eIqQw5hevBLsobO8R+j?=
 =?us-ascii?Q?Nq56HHqWa2DR+70N2RWkFuvCxYLqhVSwOWd5uzWXyctqksIZtoBPrbLSVcV9?=
 =?us-ascii?Q?2cX2+bgBPM359+ThQfqfm1okaP8ZvsTrfZXae8PRuPSZYLyU1qJZhb92IUlq?=
 =?us-ascii?Q?hxEHn6TDmF+nTpXcEkVmAgvpocNceBunyIq3jZD55QzDVdkuOQ3eSvx+7pYZ?=
 =?us-ascii?Q?m1sGoye66df/fknStvdEpF5Hist09S5ESrOLfxBp6mtEHjnpPVq1PWQvNgas?=
 =?us-ascii?Q?SuQpQWIx92RK2NIOjX/6mXI1ZWWqjArdS59OQY/ZxjOrwjoK/Q29LPhmCuNX?=
 =?us-ascii?Q?eFdFqQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a98399-a158-490e-01f5-08ddfaa8a617
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:54:00.6479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2HzAns2sR2eu2/doTqcnsB6U8PN1SGIfVTZt02aWHGn5d0FiMXcI0GkKBe8QDmvygYDHMzuWIMpBvxiBVI008rbwW+bo9NQvWwoD0by2hQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7037
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfX2/+KsV8CLMh2
 Oh5ln5FerV53NNVC7gaHLJKhDNAjGeCMB3ebo9RlAHqwOBXqoAjRElStRHnP5NosrSh7d5EF2fK
 vFfhI3RQVSLq9HaZspeWaR/NyAe1IRRauGoFuYOJdFaME3DCLQomK6fBt+auxatEFk5j8jfG3Vo
 8h90NdrfQbY8/65qGvK8ZJM/vCNZEyA1vhqUH7kQRbgouZun0tSorIEOCRD0WEgMZ77T3nbwY6I
 BNvW9xQ/oGEE7lGMFBAtYYkT5bMS0aKdW/CCjZzISEkxutGLEdH0Q6yyr/NcSsb0rjag3BzINOF
 HmlgCCeGtYCnvG3THLCb8e15cJa18LrJ0aaSq6nK/YXCA61BnHOm+Mnm8qr85w=
X-Proofpoint-GUID: 4QX4PP80l7pAI2QBs2ibfhYzd4ENZpgk
X-Proofpoint-ORIG-GUID: 4QX4PP80l7pAI2QBs2ibfhYzd4ENZpgk
X-Authority-Analysis: v=2.4 cv=LOBmQIW9 c=1 sm=1 tr=0 ts=68d2a67a cx=c_pps
 a=RF33hWjtojM2TPqP3ubyaQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=BhsJi16HVY8kLVvTjTYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The VFIOContainer struct represents the legacy VFIO container even though the
name suggests it may be the common superclass of all VFIO containers. Rename it
to VFIOLegacyContainer to make this clearer, which is also a better match for
its VFIO_IOMMU_LEGACY QOM type name.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/ppc/spapr_pci_vfio.c          | 10 ++++----
 hw/vfio/container.c              | 42 +++++++++++++++++---------------
 hw/vfio/cpr-legacy.c             | 27 +++++++++++---------
 hw/vfio/spapr.c                  | 18 +++++++-------
 include/hw/vfio/vfio-container.h |  8 +++---
 include/hw/vfio/vfio-cpr.h       |  9 ++++---
 6 files changed, 60 insertions(+), 54 deletions(-)

diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index 7e1c71ef59..faa3ab3fe1 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -32,7 +32,7 @@
  * Interfaces for IBM EEH (Enhanced Error Handling)
  */
 #ifdef CONFIG_VFIO_PCI
-static bool vfio_eeh_container_ok(VFIOContainer *container)
+static bool vfio_eeh_container_ok(VFIOLegacyContainer *container)
 {
     /*
      * As of 2016-03-04 (linux-4.5) the host kernel EEH/VFIO
@@ -60,7 +60,7 @@ static bool vfio_eeh_container_ok(VFIOContainer *container)
     return true;
 }
 
-static int vfio_eeh_container_op(VFIOContainer *container, uint32_t op)
+static int vfio_eeh_container_op(VFIOLegacyContainer *container, uint32_t op)
 {
     struct vfio_eeh_pe_op pe_op = {
         .argsz = sizeof(pe_op),
@@ -83,7 +83,7 @@ static int vfio_eeh_container_op(VFIOContainer *container, uint32_t op)
     return ret;
 }
 
-static VFIOContainer *vfio_eeh_as_container(AddressSpace *as)
+static VFIOLegacyContainer *vfio_eeh_as_container(AddressSpace *as)
 {
     VFIOAddressSpace *space = vfio_address_space_get(as);
     VFIOContainerBase *bcontainer = NULL;
@@ -111,14 +111,14 @@ out:
 
 static bool vfio_eeh_as_ok(AddressSpace *as)
 {
-    VFIOContainer *container = vfio_eeh_as_container(as);
+    VFIOLegacyContainer *container = vfio_eeh_as_container(as);
 
     return (container != NULL) && vfio_eeh_container_ok(container);
 }
 
 static int vfio_eeh_as_op(AddressSpace *as, uint32_t op)
 {
-    VFIOContainer *container = vfio_eeh_as_container(as);
+    VFIOLegacyContainer *container = vfio_eeh_as_container(as);
 
     if (!container) {
         return -ENODEV;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 030c6d3f89..bdf415b3d6 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -44,7 +44,8 @@ typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
 static VFIOGroupList vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
 
-static int vfio_ram_block_discard_disable(VFIOContainer *container, bool state)
+static int vfio_ram_block_discard_disable(VFIOLegacyContainer *container,
+                                          bool state)
 {
     switch (container->iommu_type) {
     case VFIO_TYPE1v2_IOMMU:
@@ -67,7 +68,7 @@ static int vfio_ram_block_discard_disable(VFIOContainer *container, bool state)
     }
 }
 
-static int vfio_dma_unmap_bitmap(const VFIOContainer *container,
+static int vfio_dma_unmap_bitmap(const VFIOLegacyContainer *container,
                                  hwaddr iova, ram_addr_t size,
                                  IOMMUTLBEntry *iotlb)
 {
@@ -124,7 +125,7 @@ static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
                                      hwaddr iova, ram_addr_t size,
                                      IOMMUTLBEntry *iotlb)
 {
-    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     struct vfio_iommu_type1_dma_unmap unmap = {
         .argsz = sizeof(unmap),
         .flags = 0,
@@ -212,7 +213,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                                ram_addr_t size, void *vaddr, bool readonly,
                                MemoryRegion *mr)
 {
-    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     struct vfio_iommu_type1_dma_map map = {
         .argsz = sizeof(map),
         .flags = VFIO_DMA_MAP_FLAG_READ,
@@ -244,7 +245,7 @@ static int
 vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
                                     bool start, Error **errp)
 {
-    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     int ret;
     struct vfio_iommu_type1_dirty_bitmap dirty = {
         .argsz = sizeof(dirty),
@@ -269,7 +270,7 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
 static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                       VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
 {
-    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     struct vfio_iommu_type1_dirty_bitmap *dbitmap;
     struct vfio_iommu_type1_dirty_bitmap_get *range;
     int ret;
@@ -413,12 +414,12 @@ static bool vfio_set_iommu(int container_fd, int group_fd,
     return true;
 }
 
-static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
+static VFIOLegacyContainer *vfio_create_container(int fd, VFIOGroup *group,
                                             Error **errp)
 {
     int iommu_type;
     const char *vioc_name;
-    VFIOContainer *container;
+    VFIOLegacyContainer *container;
 
     iommu_type = vfio_get_iommu_type(fd, errp);
     if (iommu_type < 0) {
@@ -442,7 +443,7 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
     return container;
 }
 
-static int vfio_get_iommu_info(VFIOContainer *container,
+static int vfio_get_iommu_info(VFIOLegacyContainer *container,
                                struct vfio_iommu_type1_info **info)
 {
 
@@ -486,7 +487,7 @@ vfio_get_iommu_info_cap(struct vfio_iommu_type1_info *info, uint16_t id)
     return NULL;
 }
 
-static void vfio_get_iommu_info_migration(VFIOContainer *container,
+static void vfio_get_iommu_info_migration(VFIOLegacyContainer *container,
                                           struct vfio_iommu_type1_info *info)
 {
     struct vfio_info_cap_header *hdr;
@@ -514,7 +515,7 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
 
 static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
 {
-    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     g_autofree struct vfio_iommu_type1_info *info = NULL;
     int ret;
 
@@ -540,8 +541,8 @@ static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
     return true;
 }
 
-static bool vfio_container_attach_discard_disable(VFIOContainer *container,
-                                            VFIOGroup *group, Error **errp)
+static bool vfio_container_attach_discard_disable(
+    VFIOLegacyContainer *container, VFIOGroup *group, Error **errp)
 {
     int ret;
 
@@ -587,8 +588,8 @@ static bool vfio_container_attach_discard_disable(VFIOContainer *container,
     return !ret;
 }
 
-static bool vfio_container_group_add(VFIOContainer *container, VFIOGroup *group,
-                                     Error **errp)
+static bool vfio_container_group_add(VFIOLegacyContainer *container,
+                                     VFIOGroup *group, Error **errp)
 {
     if (!vfio_container_attach_discard_disable(container, group, errp)) {
         return false;
@@ -604,7 +605,8 @@ static bool vfio_container_group_add(VFIOContainer *container, VFIOGroup *group,
     return true;
 }
 
-static void vfio_container_group_del(VFIOContainer *container, VFIOGroup *group)
+static void vfio_container_group_del(VFIOLegacyContainer *container,
+                                     VFIOGroup *group)
 {
     QLIST_REMOVE(group, container_next);
     group->container = NULL;
@@ -616,7 +618,7 @@ static void vfio_container_group_del(VFIOContainer *container, VFIOGroup *group)
 static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
                                    Error **errp)
 {
-    VFIOContainer *container;
+    VFIOLegacyContainer *container;
     VFIOContainerBase *bcontainer;
     int ret, fd = -1;
     VFIOAddressSpace *space;
@@ -729,7 +731,7 @@ fail:
 
 static void vfio_container_disconnect(VFIOGroup *group)
 {
-    VFIOContainer *container = group->container;
+    VFIOLegacyContainer *container = group->container;
     VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
@@ -1243,7 +1245,7 @@ hiod_legacy_vfio_get_page_size_mask(HostIOMMUDevice *hiod)
 
 static void vfio_iommu_legacy_instance_init(Object *obj)
 {
-    VFIOContainer *container = VFIO_IOMMU_LEGACY(obj);
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(obj);
 
     QLIST_INIT(&container->group_list);
 }
@@ -1263,7 +1265,7 @@ static const TypeInfo types[] = {
         .name = TYPE_VFIO_IOMMU_LEGACY,
         .parent = TYPE_VFIO_IOMMU,
         .instance_init = vfio_iommu_legacy_instance_init,
-        .instance_size = sizeof(VFIOContainer),
+        .instance_size = sizeof(VFIOLegacyContainer),
         .class_init = vfio_iommu_legacy_class_init,
     }, {
         .name = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO,
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 8f437194fa..12bf920a7d 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -17,7 +17,8 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 
-static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
+static bool vfio_dma_unmap_vaddr_all(VFIOLegacyContainer *container,
+                                     Error **errp)
 {
     struct vfio_iommu_type1_dma_unmap unmap = {
         .argsz = sizeof(unmap),
@@ -41,7 +42,7 @@ static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
                                    hwaddr iova, ram_addr_t size, void *vaddr,
                                    bool readonly, MemoryRegion *mr)
 {
-    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
 
     struct vfio_iommu_type1_dma_map map = {
         .argsz = sizeof(map),
@@ -63,12 +64,13 @@ static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
 static void vfio_region_remap(MemoryListener *listener,
                               MemoryRegionSection *section)
 {
-    VFIOContainer *container = container_of(listener, VFIOContainer,
-                                            cpr.remap_listener);
+    VFIOLegacyContainer *container = container_of(listener,
+                                                  VFIOLegacyContainer,
+                                                  cpr.remap_listener);
     vfio_container_region_add(VFIO_IOMMU(container), section, true);
 }
 
-static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
+static bool vfio_cpr_supported(VFIOLegacyContainer *container, Error **errp)
 {
     if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
         error_setg(errp, "VFIO container does not support VFIO_UPDATE_VADDR");
@@ -85,7 +87,7 @@ static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
 
 static int vfio_container_pre_save(void *opaque)
 {
-    VFIOContainer *container = opaque;
+    VFIOLegacyContainer *container = opaque;
     Error *local_err = NULL;
 
     if (!vfio_dma_unmap_vaddr_all(container, &local_err)) {
@@ -97,7 +99,7 @@ static int vfio_container_pre_save(void *opaque)
 
 static int vfio_container_post_load(void *opaque, int version_id)
 {
-    VFIOContainer *container = opaque;
+    VFIOLegacyContainer *container = opaque;
     VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
     dma_map_fn saved_dma_map = vioc->dma_map;
@@ -133,8 +135,8 @@ static const VMStateDescription vfio_container_vmstate = {
 static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
                                   MigrationEvent *e, Error **errp)
 {
-    VFIOContainer *container =
-        container_of(notifier, VFIOContainer, cpr.transfer_notifier);
+    VFIOLegacyContainer *container =
+        container_of(notifier, VFIOLegacyContainer, cpr.transfer_notifier);
     VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
 
     if (e->type != MIG_EVENT_PRECOPY_FAILED) {
@@ -165,7 +167,8 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
     return 0;
 }
 
-bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
+bool vfio_legacy_cpr_register_container(VFIOLegacyContainer *container,
+                                        Error **errp)
 {
     VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     Error **cpr_blocker = &container->cpr.blocker;
@@ -189,7 +192,7 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
     return true;
 }
 
-void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
+void vfio_legacy_cpr_unregister_container(VFIOLegacyContainer *container)
 {
     VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
 
@@ -263,7 +266,7 @@ static bool same_device(int fd1, int fd2)
     return !fstat(fd1, &st1) && !fstat(fd2, &st2) && st1.st_dev == st2.st_dev;
 }
 
-bool vfio_cpr_container_match(VFIOContainer *container, VFIOGroup *group,
+bool vfio_cpr_container_match(VFIOLegacyContainer *container, VFIOGroup *group,
                               int fd)
 {
     if (container->fd == fd) {
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index c41e4588d6..b8bade90d7 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -31,7 +31,7 @@ typedef struct VFIOHostDMAWindow {
 } VFIOHostDMAWindow;
 
 typedef struct VFIOSpaprContainer {
-    VFIOContainer container;
+    VFIOLegacyContainer container;
     MemoryListener prereg_listener;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     unsigned int levels;
@@ -61,7 +61,7 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
 {
     VFIOSpaprContainer *scontainer = container_of(listener, VFIOSpaprContainer,
                                                   prereg_listener);
-    VFIOContainer *container = &scontainer->container;
+    VFIOLegacyContainer *container = &scontainer->container;
     VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     const hwaddr gpa = section->offset_within_address_space;
     hwaddr end;
@@ -121,7 +121,7 @@ static void vfio_prereg_listener_region_del(MemoryListener *listener,
 {
     VFIOSpaprContainer *scontainer = container_of(listener, VFIOSpaprContainer,
                                                   prereg_listener);
-    VFIOContainer *container = &scontainer->container;
+    VFIOLegacyContainer *container = &scontainer->container;
     const hwaddr gpa = section->offset_within_address_space;
     hwaddr end;
     int ret;
@@ -218,7 +218,7 @@ static VFIOHostDMAWindow *vfio_find_hostwin(VFIOSpaprContainer *container,
     return hostwin_found ? hostwin : NULL;
 }
 
-static int vfio_spapr_remove_window(VFIOContainer *container,
+static int vfio_spapr_remove_window(VFIOLegacyContainer *container,
                                     hwaddr offset_within_address_space)
 {
     struct vfio_iommu_spapr_tce_remove remove = {
@@ -239,7 +239,7 @@ static int vfio_spapr_remove_window(VFIOContainer *container,
     return 0;
 }
 
-static bool vfio_spapr_create_window(VFIOContainer *container,
+static bool vfio_spapr_create_window(VFIOLegacyContainer *container,
                                     MemoryRegionSection *section,
                                     hwaddr *pgsize, Error **errp)
 {
@@ -352,7 +352,7 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
                                         MemoryRegionSection *section,
                                         Error **errp)
 {
-    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
                                                   container);
     VFIOHostDMAWindow *hostwin;
@@ -442,7 +442,7 @@ static void
 vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
                                         MemoryRegionSection *section)
 {
-    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
                                                   container);
 
@@ -463,7 +463,7 @@ vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
 
 static void vfio_spapr_container_release(VFIOContainerBase *bcontainer)
 {
-    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
                                                   container);
     VFIOHostDMAWindow *hostwin, *next;
@@ -481,7 +481,7 @@ static void vfio_spapr_container_release(VFIOContainerBase *bcontainer)
 static bool vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
                                        Error **errp)
 {
-    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
                                                   container);
     struct vfio_iommu_spapr_tce_info info;
diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
index 240f566993..712a691400 100644
--- a/include/hw/vfio/vfio-container.h
+++ b/include/hw/vfio/vfio-container.h
@@ -12,20 +12,20 @@
 #include "hw/vfio/vfio-container-base.h"
 #include "hw/vfio/vfio-cpr.h"
 
-typedef struct VFIOContainer VFIOContainer;
+typedef struct VFIOLegacyContainer VFIOLegacyContainer;
 typedef struct VFIODevice VFIODevice;
 
 typedef struct VFIOGroup {
     int fd;
     int groupid;
-    VFIOContainer *container;
+    VFIOLegacyContainer *container;
     QLIST_HEAD(, VFIODevice) device_list;
     QLIST_ENTRY(VFIOGroup) next;
     QLIST_ENTRY(VFIOGroup) container_next;
     bool ram_block_discard_allowed;
 } VFIOGroup;
 
-struct VFIOContainer {
+struct VFIOLegacyContainer {
     VFIOContainerBase parent_obj;
 
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
@@ -34,6 +34,6 @@ struct VFIOContainer {
     VFIOContainerCPR cpr;
 };
 
-OBJECT_DECLARE_SIMPLE_TYPE(VFIOContainer, VFIO_IOMMU_LEGACY);
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOLegacyContainer, VFIO_IOMMU_LEGACY);
 
 #endif /* HW_VFIO_CONTAINER_H */
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index d37daffbc5..04e9872587 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -12,7 +12,7 @@
 #include "migration/misc.h"
 #include "system/memory.h"
 
-struct VFIOContainer;
+struct VFIOLegacyContainer;
 struct VFIOContainerBase;
 struct VFIOGroup;
 struct VFIODevice;
@@ -42,9 +42,10 @@ typedef struct VFIOPCICPR {
     NotifierWithReturn transfer_notifier;
 } VFIOPCICPR;
 
-bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
+bool vfio_legacy_cpr_register_container(struct VFIOLegacyContainer *container,
                                         Error **errp);
-void vfio_legacy_cpr_unregister_container(struct VFIOContainer *container);
+void vfio_legacy_cpr_unregister_container(
+    struct VFIOLegacyContainer *container);
 
 int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
                              Error **errp);
@@ -61,7 +62,7 @@ void vfio_cpr_load_device(struct VFIODevice *vbasedev);
 
 int vfio_cpr_group_get_device_fd(int d, const char *name);
 
-bool vfio_cpr_container_match(struct VFIOContainer *container,
+bool vfio_cpr_container_match(struct VFIOLegacyContainer *container,
                               struct VFIOGroup *group, int fd);
 
 void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
-- 
2.43.0


