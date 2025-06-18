Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B692C7115B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 11:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRqyL-0001CW-1c; Wed, 18 Jun 2025 07:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqyG-0001BS-HM
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:28:48 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqyC-0002Tw-Co
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:28:48 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I0AaZ5024895;
 Wed, 18 Jun 2025 04:28:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=OZK75Lu2dz8MvdvkFTLvGRLkdhabYrtLItj6pbfvi
 44=; b=BWMv49FvKNB1pPfn1H0ozkMUmngnPIQNWUMen4zCeigTmvB1c/8fEXPhW
 sKFqEYRVcfHw0SAWDyvBo/pLdD2Y3YhvQyTTh9YRktvySenScQT1xLwbZ701OgcN
 s9/8aznjZsQg0LBBZK7jfBvHCf7h8NQ6NZ6ecHGuCVq+/EY/UhdKnaRmZCTXPi5O
 AbVUGmgRLwR94RidaqyQiKHoNg4aVJyxlN3tITC9c0HYCF9fpUFBHZIjUOgMgj9k
 2R9y+0lkCpgvyp3hldHZdm45h85geNZ6LMHew/W/nwXsZPLwhCnWlRBK+Wg5Onb3
 eKhYyFeX5jVoPTSZCX72230Y0d64w==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2128.outbound.protection.outlook.com [40.107.92.128])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4798dd8m01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 04:28:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcxsV/tfofMIyRwfMMaofUNRaLc6JPRUfr1lMj1Ojxi9DQRo783AFQ+XWbbM/H5rJLQimKCaHXmhOml0NYoYpBQi649M7O2uftf1oCYpZLEL3+U7Q+p6RNJvzYa1rJNzwj7A+DjLZC3SdpjWyoGDm17yvY1KYrdQZzP2cBjWV9dAe53bitIqxP31reCrFxTlYeawBy7bDUtkv0A/qNCPv4/AJM9s6cdOcqWIv2+KuK9JJyxAen5urs3tm4IMUur5lZER3FWJ770jnYh06sf4lR9peWUS1W7BQqvz0VJoEqhvIoT1ZgfPRu/xpZMfbKeSG33oSSCqhFxrK/LOlYU3Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZK75Lu2dz8MvdvkFTLvGRLkdhabYrtLItj6pbfvi44=;
 b=DZ6dcJKyFxHvlWU6q+oEehKddwIPEG8VeefEZd0zJSAml1GXppVrsyiDMmh58nS977fAxuu4kC1D7MTvS//Ed5GLojVNtKesueIE9tsDdueki9L9z+U0wAIZF08YRfSlteuSWS1K692Mz0njS6253wNngdXNVFruyNO5hiZCSrRVs2CMc8y+MHobhcTHTMjPSAERfNBbIK4a69RuxQHtVhq2c6FYu4xSmQYCNPVtB2/m4Nv+tHfmjHWo1UQRl4h1wxtMssG9DWp4VMo60ncyzit3GZm14e0Brxw8LKgFbFhMGODrPxZwU8Jy8WkZGFFwWG3M8C0EbujBi+IqFIS7Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZK75Lu2dz8MvdvkFTLvGRLkdhabYrtLItj6pbfvi44=;
 b=mZVwWYw6XvSgmQzSBJ/SeZPr2bkPMlF49YV8+F5C07Y7Je7PhAoxE0kIuwPRuA3bQKuvTNewZpC+Ucm9q6s/qLbRoZlncxx/ribpLb3aqT8HpWPHAZgCNCswChOPGVRPNENcnlw6mulxHVU//djVB60Xz7K1DrAhDwLw6k+fswpiq7enAcUyR8jxhIiEYOYhCslVwSzxV5NxsfV0av8TSUzfYGx9wSKe86lvfDRyOqsaVZUOg/Micgk03o3iEh2zO+TJbM7nhRdD5RtKyiEr5IZpnJe73hf2slpyZF4fgxYuj9ea9berl2qZzabEMQHG/+R5F/D6T6jiooI5zLQh+g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9632.namprd02.prod.outlook.com (2603:10b6:208:3de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 11:28:39 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 11:28:39 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 02/12] hw/i386/pc_piix.c: remove pcmc->pci_enabled
 dependent initialisation from pc_init_isa()
Date: Wed, 18 Jun 2025 12:27:07 +0100
Message-ID: <20250618112828.235087-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618112828.235087-1-mark.caveayland@nutanix.com>
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::22) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fec00fd-769e-41b5-f4a7-08ddae5b4594
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EsS/38fhESNegTG2p9sNgAFrPYLNK5f+1+gdQIz8fODDX8Bu6yE+N/6uWpa8?=
 =?us-ascii?Q?8I01NeduxXPR2EcfBM7EvxHkg113W7xoaxlOYTft38loAPvw7gFAjGZYOifV?=
 =?us-ascii?Q?OSLXFNGrp0R6BW6UC7MaYE06bmQiptGe9nhdQLaNu4EiM75Ur/4FDPhab+PQ?=
 =?us-ascii?Q?YXmCwh6T7S3xC4/58M0FUgvscebIbk8P208JyKqviVRk1Qe3+D/hIGvpLL4z?=
 =?us-ascii?Q?wQA0p5q8GISTK1jvLUw5hdD1MtYRwOEfvLKNt4HdAPg5og7fSOx67UbRRBYx?=
 =?us-ascii?Q?Ay81y6wbRgCzcxLkXUSjp618Dg7WuuoMdFv7sJW4rhcMS6uyXWmmI80WJfXH?=
 =?us-ascii?Q?pHvUOplo1q0FI1MQ13mK9jZWkxYN9VpYqcEscBi0c5CfOxncQ0xR9OLJ+vxm?=
 =?us-ascii?Q?Mh2NzmsoF32Wj73yCMH4mq0DMvBwuah7P7q4SzrDkufJLoaopznk/6Pq6UyY?=
 =?us-ascii?Q?Xb1fpSATRR6y/x1yJww6ozVPLul3a62i0y2qyJT9TlwpTMCPsnWJSn6z3sLn?=
 =?us-ascii?Q?KcABCcEzmq5SesX3h4p6GEngOsjiVVLM/WqbYmpgSFBFDit5dg0uibnuIV/S?=
 =?us-ascii?Q?O22g+dsVIpFtbqIC5x2jUMTCdfotg7MVpZeXmMYcbFpnmzQ/yJBG/mLLpFIY?=
 =?us-ascii?Q?07kNTLeZjD/3nFmBdQqGD2JrBscnzVe+SF51G6UXZfBondvi1E9IeWN/MA17?=
 =?us-ascii?Q?1jgri1Bg0AXk73RWQpxujhBIufU7PrWQQ6QSKu6EoI7rrhaWSAjDe+ZN3snG?=
 =?us-ascii?Q?p7J3xuRZrS7eUE5gfdO+E3tTOUkQmJWaTwKDyQ40tiT3x77vX0cgebo5eJWQ?=
 =?us-ascii?Q?gDV1LXR2F+j+Z4FRo2LmBMAjvpYVuKEW2+/Pw336wrKVtvtDyU6YJ7jE0g8w?=
 =?us-ascii?Q?RNvmJjjM+wvT4LJ0EFRui1AWz/vM1zAa6ZupCunVOqSxn9BgyLT+AVbvPhtS?=
 =?us-ascii?Q?NK5sv8G4YAHnuxndhs5KtoHnO3SfHzP4PH13zzXLZUzqboDNYipV+D+tr6tA?=
 =?us-ascii?Q?isQdERfn7Lwrj9AxTZLifLoUE1tvbA71G9zqPEmnkMk4v19WpNH1Qux8uvVc?=
 =?us-ascii?Q?wjyc4e25FTTMLX6O7JQ25HirO8RKjVvtDlVPyCHlVk5HLDKu4eQdf5q/nH/q?=
 =?us-ascii?Q?B9c54ndEHmuhIfHrEfX4/gMPuJSEr+YhMbyPRtAHH4h/VJkmZPtMnIi6qAma?=
 =?us-ascii?Q?e3ZyDv+JgfwNu7ur39CiX4WY2v6v7mEJwf9Gn+g7/hCJpnNcqUzTFIAublE2?=
 =?us-ascii?Q?t7IKOGnTohec60rimU9fihuLROlb8azOTQs5ycaKgh7Sc6dZ6e91PGOSg/yr?=
 =?us-ascii?Q?ZmG8PWt0u3OXQmcbVJsKuS7zKzpnx4hD8IXQLXNC9aCjJbCbLHnOcNqP3FAz?=
 =?us-ascii?Q?e7a6cAYubz4U1CyKtM6dDio0w0vIQRvzmXt9s/aQQ7eOS8To+RFYn9m+Xjm5?=
 =?us-ascii?Q?Ef/Ph2UmONs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bcd5JrwcJVWK8vlUaIBZSfurOe3PPAfcgV76YWBYZh/h9OKkn4czl0A5obag?=
 =?us-ascii?Q?yBL5EN0Wc37AHK0UMlqedqrrNI58tn6FNwDe68nRMDoJhzCo6psDyNQl6wjj?=
 =?us-ascii?Q?igQvTFVpwoBST7mcEG+r5rAvyVZogNEAcTig6DWXh2DD+kYnwwvgmcHtUQu2?=
 =?us-ascii?Q?utAxroe11pmZ+KKmxXkyu4GR5shUOewczSl1Hr63VTvik4MR+pd/Wbq9JpiQ?=
 =?us-ascii?Q?b3YP3JY5BocBrEKt2gYrkSYmnNUHAFCmp5o0cJMrmnGUm6xTR/0X/71Jnkzd?=
 =?us-ascii?Q?GZvfW/oJzF8/LoE+3oH4ROEBZSFCThHGkbkYLftvOzlThvia6Dbl1Q8432Vp?=
 =?us-ascii?Q?vZA2MhdISzJdgYZCvIZ6jSPYvekiUxCwkrznS5Sa43c/nyOpChGU1IhN1FSs?=
 =?us-ascii?Q?IELXGEFOc3Uw7IEiPW1cLRq3miIr6X6RpgmKMmo0DAQkbK3ubXSZEcQr48/5?=
 =?us-ascii?Q?3hDcPdv68GGv+y0IeiZ5QARFfsfPolVKFgQwCdG8t7FX8gtfugmB9l4yziid?=
 =?us-ascii?Q?veCDvnmzX24CLF694KNrTYXAlUpiW8Dduin+R0MbxRtbToyUB/6efUB/f9XQ?=
 =?us-ascii?Q?ej9FZdCar/A8iGBkNakQy/MfngRAsUAknTR4W0APOYlgUKAu67ICloXFXcnt?=
 =?us-ascii?Q?Tf9RJYiKKn4M1rAdtqkZHwY9xYNYHyi3RTr+MNKDdOKeJQXz0RAebR8yBIzJ?=
 =?us-ascii?Q?g/y/G4RaGvsjP9Tm3Ewlcz0/KKuW2R0YyuUqpjuxd3aS/DQhtF2ZGS9YW94g?=
 =?us-ascii?Q?kZdBBAW0cuS85ABxblpfZnxBJc4tZ8FX+Uk+YnGTUMRY/27mAt9taW69DdIU?=
 =?us-ascii?Q?MJbluc2vCijAkrFfljXb3a9SX2+xcuz/a9LdKnss+v7XLo7ll9Y3IC6Nxw5t?=
 =?us-ascii?Q?+fZ6tAe0qWHby63lLIvAHXiPn4MqvKLRwO5HocKgZJAALagb9v2CtqiL7Nfh?=
 =?us-ascii?Q?SAYiTVn/Vp7TBd8iUz4FbIKnADIDtYaE5xgUkH/rOhYsIV1wDGkxDYopxCZQ?=
 =?us-ascii?Q?R1I8Nu8tHUpdWV0liRIF7C4AFfinutwh7GBT9wY82phI/zN7juKGoV+cKun5?=
 =?us-ascii?Q?AxvNFMBpaqcS6ka5FQf5eacuNMtU/B0gNry74W2VPKphAUaKM3lpyG8jn3jo?=
 =?us-ascii?Q?HmGJH+WvduAcUg+AYJrL1LZzrpwaMnPnjYlokDwZ//yfuueD017lbZYITzCR?=
 =?us-ascii?Q?jWkH6g1L3dt7yePQcUHKOZeS+QRu1EDxsSNdIs9FVM0s/Rk9TQO3t+ceGBdT?=
 =?us-ascii?Q?Lr7G8h+y5mN80Cb/knCYM+SESG5Ro2tDe9MvN3kN7A2qkqQeLCkaPAovGQ9c?=
 =?us-ascii?Q?1QSC7RmlBKXuRk8ALVzG0678ya011LITSBtXN7mEVoYlRp+jtKjkdUvnGNdD?=
 =?us-ascii?Q?fxe35mfhc9efhVE/5IPYi/f3RXH+sRF69C1Afp/5b7sGTs9puf+VBQCl1whO?=
 =?us-ascii?Q?XZEYCZtHXPhrWtq99PUd7mWQbPZGQdxOEMXw2I/6eIXt3X6Pa923bsLnB7XW?=
 =?us-ascii?Q?IJYfv+NgVEV6Qn74+b0TLtpds9WwE4ZmhaYqKBZxpGyCQA0IEGbBWx6PHjnw?=
 =?us-ascii?Q?bhcSO2ltZ/nMUzJO+FDHqbr+0Sx/6A6QOYFa07JgTyfcPvMCLMbeAnyHFx7P?=
 =?us-ascii?Q?7GhPUb20QW+YZ4QS7d2PwCTo10q4/OtE0o868be91S3XJcvCmeDJr8Jhrp2G?=
 =?us-ascii?Q?06BUDg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fec00fd-769e-41b5-f4a7-08ddae5b4594
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:28:39.1260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XnTI7qKOtsNp4PEMQ+ECnri++KHPfpaBaI7BgzSWqiJu7fekMG3cguFOy0Bco5HWL2RlI6FyLByVPUr19HMyVsPoBFXQVkb7DyU5+F/bKys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9632
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA5NyBTYWx0ZWRfXzugjL31d+tEF
 MjQ0Baofyh9e3YbdYkGMMA8SYuEfMSa10FnXoTsaU8OC20S7yynVLKilgjGCDXQGuM03lcZiarN
 rsbHwx/oKYPyEr08OgukQLwlF66+pijFslz9jRfXtUY8PPVbM73oF9JZC3uQAeqasE8tlab0Q1x
 O034DBivtz0j1uo5kT3cWompbvGsO1JrFItuCXJGVaXdvuu8atoQNcRmb7HEULsfJDuDYjmHnY4
 F+w5nn/fJCKV376Z7gt/laB4gVqqtAlrGN8on+3ATSxS4dY0lev0GhoIoBp+NWEz5fPEZhQsaFg
 RPVPDkjAIENwrWA7n1owx5TiKz6+1WnaYH+iNq4iwlWhpt7P/aAYeCcN0GETmD1E48bmH2RKnuQ
 e8t7kt0Aybh10y+fYb8fGyjKt01xNpJOS//8ur01qHsyptwZGpUD0M285oou7sTn6QAbyr6j
X-Proofpoint-GUID: 0pwEBEa9BmzU1DA4wA1Jfs-ufUV9kn4x
X-Authority-Analysis: v=2.4 cv=WdoMa1hX c=1 sm=1 tr=0 ts=6852a2ea cx=c_pps
 a=jzLUcr/A6iKde+6uBY7ZJg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=mbAAzmQ2ag6Hd_HGWNEA:9
X-Proofpoint-ORIG-GUID: 0pwEBEa9BmzU1DA4wA1Jfs-ufUV9kn4x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_04,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
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

This code will never be used for an isapc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 105 ++++------------------------------------------
 1 file changed, 8 insertions(+), 97 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9842d2152b..102e785d27 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -418,19 +418,16 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
-    const char *pci_type = NULL;
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
-    Object *phb = NULL;
     ISABus *isa_bus;
     Object *piix4_pm = NULL;
     qemu_irq smi_irq;
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
-    MemoryRegion *pci_memory = NULL;
     MemoryRegion *rom_memory = system_memory;
     ram_addr_t lowmem;
     uint64_t hole64_size = 0;
@@ -504,39 +501,6 @@ static void pc_init_isa(MachineState *machine)
         kvmclock_create(pcmc->kvmclock_create_always);
     }
 
-    if (pcmc->pci_enabled) {
-        pci_memory = g_new(MemoryRegion, 1);
-        memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
-        rom_memory = pci_memory;
-
-        phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
-        object_property_add_child(OBJECT(machine), "i440fx", phb);
-        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
-                                 OBJECT(ram_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
-                                 OBJECT(pci_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
-                                 OBJECT(system_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
-                                 OBJECT(system_io), &error_fatal);
-        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
-                                 x86ms->below_4g_mem_size, &error_fatal);
-        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
-                                 x86ms->above_4g_mem_size, &error_fatal);
-        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
-                                &error_fatal);
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
-
-        pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
-        pci_bus_map_irqs(pcms->pcibus,
-                         xen_enabled() ? xen_pci_slot_get_pirq
-                                       : pc_pci_slot_get_pirq);
-
-        hole64_size = object_property_get_uint(phb,
-                                               PCI_HOST_PROP_PCI_HOLE64_SIZE,
-                                               &error_abort);
-    }
-
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
         pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
@@ -553,74 +517,21 @@ static void pc_init_isa(MachineState *machine)
 
     gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
 
-    if (pcmc->pci_enabled) {
-        PCIDevice *pci_dev;
-        DeviceState *dev;
-        size_t i;
-
-        pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
-        object_property_set_bool(OBJECT(pci_dev), "has-usb",
-                                 machine_usb(machine), &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-acpi",
-                                 x86_machine_is_acpi_enabled(x86ms),
-                                 &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
-                                 &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
-                                 &error_abort);
-        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
-        object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
-                                 x86_machine_is_smm_enabled(x86ms),
-                                 &error_abort);
-        dev = DEVICE(pci_dev);
-        for (i = 0; i < ISA_NUM_IRQS; i++) {
-            qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
-        }
-        pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
-
-        if (xen_enabled()) {
-            pci_device_set_intx_routing_notifier(
-                        pci_dev, piix_intx_routing_notifier_xen);
-
-            /*
-             * Xen supports additional interrupt routes from the PCI devices to
-             * the IOAPIC: the four pins of each PCI device on the bus are also
-             * connected to the IOAPIC directly.
-             * These additional routes can be discovered through ACPI.
-             */
-            pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
-                         XEN_IOAPIC_NUM_PIRQS);
-        }
-
-        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
-        x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
-                                                              "rtc"));
-        piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
-        dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
-        pci_ide_create_devs(PCI_DEVICE(dev));
-        pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
-        pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
-    } else {
-        isa_bus = isa_bus_new(NULL, system_memory, system_io,
-                              &error_abort);
-        isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+    isa_bus = isa_bus_new(NULL, system_memory, system_io,
+                            &error_abort);
+    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
 
-        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
-        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
-        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
+    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
+    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
 
-        i8257_dma_init(OBJECT(machine), isa_bus, 0);
-        pcms->hpet_enabled = false;
-    }
+    i8257_dma_init(OBJECT(machine), isa_bus, 0);
+    pcms->hpet_enabled = false;
 
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
     }
 
-    if (phb) {
-        ioapic_init_gsi(gsi_state, phb);
-    }
-
     if (tcg_enabled()) {
         x86_register_ferr_irq(x86ms->gsi[13]);
     }
-- 
2.43.0


