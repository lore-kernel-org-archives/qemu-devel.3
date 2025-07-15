Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B11BC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 05:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubYbR-0004Wd-9j; Tue, 15 Jul 2025 01:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubYbJ-0004Nr-QW
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 01:53:15 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubYbD-0005ij-85
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 01:53:10 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ELHIpC026861;
 Mon, 14 Jul 2025 22:53:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=f+3MK4asVpbLd
 dkRg3JSgZ0oEUXxWx7w9eK69eEotds=; b=na0cC5ws8i8qZRgSmjSv7r5GRVX/7
 GK9Kx+rM8QN3F8spqGOl2Vw/eBE5VHNKfTBoOLUa/P1acu5kWccoeAEZ+khcsGDd
 xgM4gxzuCLV4HSGEKZg+tCBLsAWjg6nZi/CcbMgHU4sG6t4nVpeqH7EBsrJgwIeX
 t3l8xsjf94el04sxlE5ofeWj+rJTo4WKOpKe7fR/q5PV/KAMAuMZL1XeC+D9smpf
 OWd2hcM5FSOEXAhNecNyocipDemiPDrO0oZo4poM8cEuT7hNojxccmFPvZhxLR/R
 jE7rQpKhBrKncPMEb+OqxRuxdUmgLfZfxM57c7p+sbhBjn4VdLfo/sTDA==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2096.outbound.protection.outlook.com [40.107.220.96])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47uq81d9qh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Jul 2025 22:53:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ys+WsxvrhOhQxILUiVl6xH0v9kq42dM6et1+kCyeMbYeEFxPd1c6MCRoFdFwIDDHHwuwFPBjQ7yb7WF7qUJZld2yt02dAWBItoYovtYJg16OaYTv4atBnfRUdUuI02jQ6n0WP730KEqHhj8UY0Bs1jv0B91edbIUQooBfZRBzMXwIt/6JNNBQ4zrACVPELNhOYaW2IKR+BZBh10fGLMDoXExRHYdsksRvRZXtpIyT6MLy0xXz169KOzjP3RoVrzYsvj9qnjfa2fBZUiRdjTOCSvuaOGurkeCl0LiIlq2xDfi5F6m+o6fVgrbXmTI75iNS1gcyClGJa6f+9UIi7yOgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+3MK4asVpbLddkRg3JSgZ0oEUXxWx7w9eK69eEotds=;
 b=XDAUENouYbd4wNS9gD5qouXvUTGyB2Ny+16SmsO98llcdyKhQPId+td5MhwDqwoq82AKKGc/FBGgA6rEaXGkazzm3ktkTzMkHq3HIx/I1ZZk6/jMNAdksoDXu4Xlzm4siX13iNFXLzQyRv7dbU2vU6JAG9WwN0GPQLD+JY0MUTGeHQIt9RAfL8raa2rOgTlVRh1c40eIvbddu1+LsHstj0hVdPN7WEAJwBgD8rWJ4cIuHfwpuhyhvqIsOU03PMIUcoPdzOzj5jD1Via4yDpuiVkWAXc9lFh+NNh5CE4noyCl6YxzHiL2JZ0Nx0xFCGQUl9cDHuyh0/qCNA30QBaL0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+3MK4asVpbLddkRg3JSgZ0oEUXxWx7w9eK69eEotds=;
 b=dy8Wtq+kMDmUu8gkOmNyfP3J8R9/vHRZdDqx7P0CAgC2Hh/CvaIcITMn28o/xpL5OmoMy8z1MxxHcD1uuk+AKL+ZogZUX7TOatPQE7DGs6oY4H0+slq8IGJ2nKuptTj5emDhVSYL0JKhvanp+fxeSLF6ZSPbKafgjsmPTT8oZPmJ99OjS4KeTK+ev6ks5tmtuWAYvQsmP+lxjuEt8CjhqdMvN25fNrBUKxbewRSHyfKD8wH0nhmrvMQB693YTfYtyV6QXDjXG82bGJ/AtpkdT0lrK4LMNtaRuKFAhwAyy2rSbScXOm0sPSL6bGrWle+gXQm4Die4heUqNNUr92Fn9Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8841.namprd02.prod.outlook.com (2603:10b6:510:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 15 Jul
 2025 05:52:57 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 05:52:57 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH v2 0/4] vfio-user fixes
Date: Tue, 15 Jul 2025 07:52:42 +0200
Message-ID: <20250715055246.422834-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f7b941-c0c6-47c5-351c-08ddc363d8fe
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGdHS3dncUJMTHpkUDZWSFh0Rk9SZ0x2OFR1RU9PTWNFYjA2Q0J5L2tIaGV1?=
 =?utf-8?B?OWhBdm1WR1BENXdWOEE4QjNMd3hDekFZTzRiLzNxczM5TFRoMmxYM3RNT1R1?=
 =?utf-8?B?YWdDbHdRc2E4aEdyQ3lwMGd5bmdUVjkzRVhOVGh6dGRVeGFpdXVvVmJpR1V3?=
 =?utf-8?B?UFlRRnpSWnVoWHlOYzVyc0xITlZnRGNjWTJidE5Qb1hMbFNXUnlhUytSbjJX?=
 =?utf-8?B?NFRSVktuaEpXdm1sQzFaNUVoNFhLSGRlSU5xRjVDWGkyaVRxTmg2azk2aHRt?=
 =?utf-8?B?TlVOQXhaQjJ6OGRIa0lRVVVjVEZYQ1M2QVVQWm1VNzJEeVE1VC9vTVIvNjJC?=
 =?utf-8?B?bHl4c1hMUzhncnZET1Z6YjlxbVBFbEM0VUxZNVp1ZmRCSXkzMTJ3ZC9BMFky?=
 =?utf-8?B?N3dHbkkzeVZ6NFZWaXkxM1Z1T0VOblpYZGpJT1B2L1JySk9qclpJWSt4VVBy?=
 =?utf-8?B?WGlucWJGMlN6KzJzU01TaVlrQUhhYURKamRwdXBTaUN0UGtvZ0V5Lyt4eWxO?=
 =?utf-8?B?eTFQdnZIdVVETnVVUC9McGZDY3hQclhmUVpyZnl2aU8wUUhieittMmtnWFFw?=
 =?utf-8?B?d1AyWno4ck5ocmtIRkdGbjJFQ1gzRncrTDd3dEdrNGNmcXF3Zk9LNW5yNnVE?=
 =?utf-8?B?dHIxY1BsaHppYktEZ1VsYVAxU0ZZVlkycWtBeUg5bjVYYW9uS3VsaTZYOWNw?=
 =?utf-8?B?Tytwd2NOZ2RIbEg0a3ZTekpIVFFOL3ErTmhNMzRTVjhvZy9jS21VMS9MbUVu?=
 =?utf-8?B?clYvd3ZtWnFQcVlGUjFRYmJCZU1iRGI4Tk9BdjV4TEk4WmkvNXRDcGF6RzEx?=
 =?utf-8?B?WVdianlqY1ljWkJWR1FjbGIyZTlGT2JJQzlBVStZek53UUtDVWt2SDloVVVM?=
 =?utf-8?B?NTV2T0Q5bjhZdXl5VXVQMEFBOFhHdVhBWVFMWWFyTzVnb3JQWjBIazRSMzgz?=
 =?utf-8?B?NlFDcHg2TThEUWh0K1Nib1BLbTR2R0E1Y3JsV0pFZ1llYmRVRUVOZnRudFZs?=
 =?utf-8?B?ei9OeTUvbHZENnduaGFIb0pQOVVoL1ZnQUU5ZUw2ank1cFBTTkhEMWVTN1Z5?=
 =?utf-8?B?SlF0WTZkTEZIMVdmelJmRmJYbStGdWpQZFFlVC9HcXdnK0VlVTd0WGN6VzBB?=
 =?utf-8?B?aE9ZS1pEcDFIRGNHYk9YbFR5Ly9wam9pY3Boc0JGZUNQU2RMZVpRUDN1eERR?=
 =?utf-8?B?UmJ4TTNyc2dlRk1FZlNqS1BSbm10UUhNNk56SmR1ZlE4WG1ZYVJrRGNLVWR4?=
 =?utf-8?B?N3ViRHB3S3dNQnRabUZDY2hkYk9kZnZFbm9Sc1F2NW5FclQ2QnAvM1VKOHR6?=
 =?utf-8?B?T2Q0WU93MmQ5b0lVUDVoZDBxTkg4SXVueDZ4eUMwYXNva0ZEOWJXeCs2dkpt?=
 =?utf-8?B?d0dKRFArUkNrUmdiNWptYURNc2VMZ3NhbVpzQ0NBOXQ3aVdWQ1hIS0ZIZXdQ?=
 =?utf-8?B?K3liM0pqbGVHY2Mwd1pCZ1ErSzNvMU9za2o4aU9WbDgxcG4zVVdHNXNDL2ZW?=
 =?utf-8?B?a3IycSt5NHlEcWdlaWUxOFZUOEhRODFKWkhac25aczgxZFZybnNORVdodm9R?=
 =?utf-8?B?OFkvNzBMQUFJWUxLSDdoN29td3VJVjBKcTBwZjZvSmFkdHd2cVBiK0VNL09o?=
 =?utf-8?B?Vm9Yc2lHTVM4TXhVWS9SSUlSYXFCeTlad3NmM25RZm95TVZqK1FnMUhUcVdo?=
 =?utf-8?B?bjU1UHQvdWZEcCtjbTVETUJUZ3FNTjF2UWZsVVg4OUpPTzJYaURIc2lVK3VO?=
 =?utf-8?B?QU1XM0VqVUVMOExZQWVVUVh4L1dDenQ2aitkT0U0Ri9YRnloUjhiMUhqS2RM?=
 =?utf-8?B?dVdVZGJRVU1aeXVDemxFdUhSQlNuNkNodE0vcTZwWXB4Qnk0bWZFaGRUZ3l5?=
 =?utf-8?B?QUF0R3VNNUpjdE9tUEJQVG9GR2g3elpnQTlxdVF1ZVpWSURyNWdJQVNpU1Y1?=
 =?utf-8?Q?L87IA2jqbxI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXRTMDV1UkJMV3JkM2hGWndzUDRJOVNEZU4wNUhJNGpHU3I0dWZGM3NzdWFZ?=
 =?utf-8?B?a2pTb05EMUtrTEEzZFZLZ0NJVS9zbU82MVlsZklkSWUwbWQzMlZ0QzU1cDRq?=
 =?utf-8?B?Y0U1RVdWRm5nWlluUWRUaFNCTjBDeStuT2JSZ3dyQlkwMVZIdUMxRTdkZnRu?=
 =?utf-8?B?R1ZQN1NSUmNqcDRXbVZUQ2U2Mk1IOTBOOHY1SUtEeUx1RGtla2V0NlJ4M1Qy?=
 =?utf-8?B?YVZXRDVQN3BMZllQR1M2Tm5Lakp1RTlXTUxEVkIwdXRRU3c0WnV6cGZja3hP?=
 =?utf-8?B?MnY2bUF4eUhJS3hZdjBIZWEzMm4rWWlIMjd1TDF6U2dDdWFUdzlCSTBnNEtX?=
 =?utf-8?B?aXFMbXZoRzJqVk03b1ptSCtuZ1VDRU1MOGZob01ZMnF4Qk9UZUdvaSsrUEp0?=
 =?utf-8?B?MDhqRkxna0lBZHE4SytBcFdoVUFDQlQzZ0N4d0FCT2pSOE04aFpWOUdpTGNN?=
 =?utf-8?B?eVNlR1VZc09VUWhCSkthQkxyNmphdlVaNm8zazV0QVZodkpCVkF5NGZ6VGNC?=
 =?utf-8?B?WmlYTjNwRVV4MHFQWmUzelZIUUtyK3BDQlRPR1VwTy9YVkRUc1p4ZkNZNUMz?=
 =?utf-8?B?aUN2ZEsvVjVNNUs5K0N4UzVZQkxyRFN3R1BSTlhYU2JqZjNCQ2RQTDBxVjh1?=
 =?utf-8?B?Ty9MM1BBZG5QVzZvN2RYU3JJdFZia1k4WEtiUDB1aksrUURHUHA3YUcvcHNW?=
 =?utf-8?B?SmlmZjRyVG5oMUlCdGhJaEJpSitBa0JWYW5jRjh1QTdsQ2Q0aEwyTHNiOU5J?=
 =?utf-8?B?SnBUa3dNVDE4R0l0M2VqZTFIT3JJR3dHdmdDU09vL2tHTW1QUmNuRDMvYUkx?=
 =?utf-8?B?aGpOUGM1SURaQUNlS0xpMC9ib3hlbjFWQ2o3YVZEOW9YMmMrakE0Q1g4dXg1?=
 =?utf-8?B?S3B3cWwvdXEzbE1zcGpzQUtPUnA3SVkyK243Y0RtQWpKRlk1U05zdENhYUFI?=
 =?utf-8?B?NkJNQldXNU5IdTNFS3hEVjJiQzZRRHl2RGd0dmJjRGZUbk1FeTFrM3VLQW94?=
 =?utf-8?B?YVdzT0NwQ0trWEtiS05ZYlN1YWwrLzNKNVJoMVdkSy9HSXpiRVBKVVFYK0VI?=
 =?utf-8?B?S3B3ZHRCbFU5YjhEczE5QWhTN2dUdkhUdWNaeHkyQnVoZVQxSitVdWptNFZL?=
 =?utf-8?B?UEhUai9qT2xYZEh0N3RXd01kTWdBYVh4OTNxaTVxNldFSEtYcytmUEhTbTRX?=
 =?utf-8?B?VWNhemxVQVIzU09qSkNUdTF5aWZNRHBrbnd5TmJmZkFSWk9WOGlydTZGYkQw?=
 =?utf-8?B?MG9Dckc0eXUrMmlzaTAvNS8zQ3I1OThpZGlieW5hKzJIanJZM1lWSXR0VWtB?=
 =?utf-8?B?OEdaVzhxaGVzdTdGZk1yUlE1MnU1Y3FDRytFM2YzS0pkeDFaa0xEajlIV2R4?=
 =?utf-8?B?cnFaZ3I4NzNjYnlab0xteWJZTjlSSUVPalFYdEVIRHJHZDRibmRMY3RubXJx?=
 =?utf-8?B?Ny93UkNQOGN2YXhxV3FhZDY4NmF2VkU4ckxnR21MWVNNSkJDdCtEcTZQeTly?=
 =?utf-8?B?c24xU0N0VFd4TjJyN2dhQ3ZIK0Zrd3lpNm56eEk3Y05CUzdoOTZTYkNQMmhr?=
 =?utf-8?B?b24yYWVzRzErMXR5NVlES3BaSVJqamowNzVyRVdqcE9IQlVqQzEvVUhSRitv?=
 =?utf-8?B?aUdCR05hK1A4dmF2M0lnbFRBZUVTRXlzbjRvWVBJN3JERWZ1SVlDOWwrWUQw?=
 =?utf-8?B?SE9HMmx1L1BZSlo2Q0dwanAvNVQzZENkcXluV25Ld2pYTFVHSi9LNGlWemVN?=
 =?utf-8?B?ZXYyM285MXk3Qi9ISUpJaFVMUTdnaFVIS3A5SmpKVTF6UVhiY2I1czFuRGJ1?=
 =?utf-8?B?MDd2UVBNdk1BQ2R6Q0tQRzM5UnBiZ2h3S0tSWFBOODJQK1lhY0NncGVLblo3?=
 =?utf-8?B?dDZSNGRndlpwaFdzQUtKYmZLTmhKR0hxcUc2eDZIS3FwMklKREFHREtRY0I1?=
 =?utf-8?B?eHptZzBRZ3hmMS8zczd0Ukp2MWh5YzdySzFRUE5oalNRUUtIRWtoZEQ3SSty?=
 =?utf-8?B?bGRneFJOQ3pNQXNqZVI1U2h4RW5PcUV0L3hsVHllNURWb1ZjNmRoZXZKR1dG?=
 =?utf-8?B?V2s2UGJ1cWFGTlh0R2pQTm9hTWlaVStEenh4YkRMbjJXdjRYREJsQ3FIU2cv?=
 =?utf-8?B?Q2lZYTBwbjVpa0UwUk1QYnN6STBnakFzMlJCeWZlQ2NQc2NueThDRzRGYlhP?=
 =?utf-8?B?MkE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f7b941-c0c6-47c5-351c-08ddc363d8fe
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 05:52:56.9699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCdwBux5vN5Svg5GYCmSvbuAA4TOQ3SZIsRRUBSd177nkzh9fFDKzqLF7c+Lgz7o6b0B5CRMUkg9RyNFbZ+Nsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8841
X-Authority-Analysis: v=2.4 cv=bL0WIO+Z c=1 sm=1 tr=0 ts=6875ecbd cx=c_pps
 a=+jfnsvNtYUVjUhI0lc2tVQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=ahWBuGF6cRnHq8EVzWgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BHK0HDF4ksEv7w76qAB-lUKqEPvmQ3Fh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA1MiBTYWx0ZWRfX2HKNpIaFdbEU
 IRXAeE5ybnc7C5ALo0DipgtoiEmwzSK3kBqwuNEaZk3nIDzJvkdmQTxCM1e9eMT36bsjdSuF5jm
 wvQVXQtTNbVC/tIFjsBOFswmDrlrtKBNjjjOEIZDloKq4FMo/+2QFtb5x5TTVDJsjYYZRv1yyLl
 +BI4mI/dBcpPogm2NtjhJLAhFBnl8cdiTClbyzrghbAy+hTSy4oZ01pYsLGV2CVUAH4D5WbquR6
 +s32NiBlgtGDIsmDb5iV33O2jyLQYd25GzM44QtihgpBBu3ZdAOCU6vzlShMMgyMvAZ5Eph/TtF
 LqBRSwc6z40wM9cE3lPC0UsW6SCUzrBZ6640BtEGR3IyIQN+VQeveUrjfdoTSA91pD682x1mSJw
 ygGnJTLPHccGq7B7dJZ7HwrZRd3ot2hXEbSMQ+yZDIt55PcFklYdFmTiA9hAO2LPVFZwm54o
X-Proofpoint-GUID: BHK0HDF4ksEv7w76qAB-lUKqEPvmQ3Fh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Some small Coverity and related fixes for the recently merged vfio-user series.

thanks
john

John Levon (4):
  hw/vfio-user: add Cédric Le Goater as a maintainer
  hw/vfio: fix region fd initialization
  hw/vfio-user: wait for proxy close correctly
  hw/vfio-user: fix use of uninitialized variable

 MAINTAINERS              |  1 +
 hw/vfio-user/container.c |  6 +-----
 hw/vfio-user/proxy.c     | 10 ++++++----
 hw/vfio/device.c         |  6 +++++-
 4 files changed, 13 insertions(+), 10 deletions(-)

-- 
2.43.0


