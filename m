Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E0AE9905C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 08:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB7g7-0004aj-Rt; Fri, 10 Apr 2026 04:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wB7g6-0004ZB-J1
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 04:57:26 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wB7g4-0003HM-Ft
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 04:57:26 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639LVEYs3946351; Fri, 10 Apr 2026 01:57:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=2VHC3P/bXaYsE
 01I3LT0ljOedB4gA6bh/mWWEzNuVbM=; b=W5HpJL0J1DxBZakk2TTaBsZz8HYZ6
 GiXTmUtGTSeOYxnJz/K9nh9NRFqsUNWFcVfcgXS7S1svbWfpcz3ESYh5iq148NOa
 EXzie2fV5zQAAJp/rzlz8KKcujMYdQZRXING0rfA5Gk+ou0QgUa7QGDitMTvm4ZW
 NImHSPjLzAGCm1+NlMbBXKrGL8wMwsWyvZHvoeiEo/PglI/MGJ68y7Mwcidscutj
 o7GT82oicr+KeHPyFfn8cqln0Zim5sLnPthf/ZNEjgaJq+qCVJ7zCxZtq1ZXkEDM
 hEMM4pr1uhL6+lC8Mp+WaWuRdYItdc5YPxyy3kQhcpCMvUXM41NkxmdJA==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021075.outbound.protection.outlook.com [52.101.62.75])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4dead42dju-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 01:57:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmz2BBQs/xjpJ8BfFpTzZ0AOUJNdGY/JIjL4+U+z2PZWpNDBCw2i5Ikj2bHFcCh99/zICNR1OaJ5oUmSloOByHW0YWY6SQ7aRLbAdJqmzTlneoo6oGLQowBPylDCKQfOli9ydyurGbHODLKRFPnEt4BVABOoebXC8CplRCzepexCOqgTrV1hNoDCpvvzzO84aimBP1IwYr27cWyJz1W0LhZjL4eq27zQOuKjYEi9LKcE6ZDurWNg6i6UoqT8tTnmVPXf3KcYE/zBNZjeF9M/gwlVZoKVlIzEg8YdrMSeeNuhSLDjZOZaN9qy6eEJ/IfbhRzLBBUpabHQlNxYByoJOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VHC3P/bXaYsE01I3LT0ljOedB4gA6bh/mWWEzNuVbM=;
 b=m5Er7+7Q21JRsEZrBD6hCv3quV7cDFpY5ycyltxeGlIRT/omQlolUgdwU7TgeOXGOR6/zHbxUUTw2RoBnhLfQ/OvUdMAn9k8BHtT4t700nasGTBcXEkUayT3Dx8Bfx51Jfkcj3MhSHrt1UxMS/fbrLk2B0Rlk/vBnVeUWo4ri9T3BhJ6cNBbhnELTXqzIgenbVOtbPE2WZq2myyheuAXgZ+RythIkJmtRh0mUoq9MUhf0+rdlwyh0vL3iZ2iS1b4wcqaxXbpCIB3nU8CfovRmO1IsgY7pk7ZuWFLA/RKPepmz21YmaR0scjYQc/G2Dj0PWL7SECnTOahLcoZU4angA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VHC3P/bXaYsE01I3LT0ljOedB4gA6bh/mWWEzNuVbM=;
 b=Gq44M7PL0WyWPKU81eHvLY7NaNA4mHQGuml959rbFjXpF1WZHtXVj2RubIP9/xsLluiB20psVMMD5TLtPBi2BGsO9eFNMwqk3R8chT49+H7ty8HXi7rkQIFB2AYRu45Yd8o5bu1Zl2yiF73CTZMNn/lsYopv9a/dngEvExsEEhkHQkyCDPqppHbcly6uCLvusCRcjLXfZMOFw4VUua5qexRB+WmODBew1JlMmqSd8I2ny6/AufXmHZApuTkNDMmWSq/svuAJNEtIZunkM7S/zIExY8tJpLlvMY3TX+uakvEAYHhYxBlfysiTo1qZkd6Kj06EpgjBvhQ5evca3tD/kw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by IA1PR02MB9256.namprd02.prod.outlook.com (2603:10b6:208:424::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 10 Apr
 2026 08:57:20 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9769.035; Fri, 10 Apr 2026
 08:57:20 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH v2 0/3] vfio-user fixes
Date: Fri, 10 Apr 2026 09:57:13 +0100
Message-ID: <20260410085716.877185-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0404.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::32) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|IA1PR02MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a634cf-26c7-4518-98d8-08de96df2c4b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: bozXLH+3h92ynvtYo4Izl09O6NkbAvH+FyqaSUyU/IXIbsI3AVmK/TgKB8jGgYomVavMX1KplbYNug7fA1Ofq6iK7LYRWN3NNpAgs7KFlGJe5dw0qhpd6DQpvIF0jrtl/QHLoqWJaEFTg8RRwCBo79Hr8NKhYEr1+t1un/beebaYwDv1h70YKKyZp7v/qWv6WCdogKgCfmoZO7Ls8Ko8TqKwKvTHB1Lcw+R53gF3bIBbjTqTdEZdUZ8mhNUUSOAxC2rBErg3IxAqNL+a9HAxA0IK5m82QHgh4ahCNGPMH1KvNuwH8B+h+LXZdx8fxxCO7YR8ww5+/7km+gthSskC2KKi8GQufWCjUy9664f74bGFsxpPBxS42aA3ET7Y9FskqzTHix9ets0gLBwbWukGEVDJimnX7AyunGkG9GPSCB0Zv2zGkH5h3yGOmZ8jvKT6acJEwsXsDMySdzryMY7Ntb0UWC20IybPxGK6AmIGovAZiBhgk1UwiZ31r8OHUyi1NBXxvtxyczJHYkT5awmrmrrN9CNVMGOjBSN9cXG+JQsLFUvBcm756tmXMSbjkyTaQxTQ6/EwFVCvgVSf9OqRTyZXbMaf9Bt4CSLcZEDp68NDr3zaPLL8/eyt6Rc3+8fd3uze8ZaybNfRnikG5feUZhUafvK8T6wE8AtWTJZdeEiUsScDnu9rJ2aIrDp1aAB5uR9oPV4of+n+1NQovMPQGQngU4UNGrYqU6vqzV4duRU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUdrNnhuZkFtYUVIS3J1U2gvTWE4YmpiOW5CczRrbUhWRnVMY0Q2TExBMnBz?=
 =?utf-8?B?TGdXRVQ0aGxjUFI2TjErQ0xOUlhsREhZbjZ1MHV2YmVRcUdiUFNpaDVNNGtQ?=
 =?utf-8?B?SU9halVieG5kS0lQaXNWK3ZueXRUWFhqUFZVZU16WkZYK0ZHOWE5Rldud1VE?=
 =?utf-8?B?RmhaR0JwM1lUeFV1U0ZsRnFZU3VGRnY4a0tiSm1KWmM4djhsQnRxMDA1bFAw?=
 =?utf-8?B?NGZlZGFnNkZiNHBVYmM1Z2tyTXNTbXJiQzAySVdYaytCNGljQng4dzlxdUJl?=
 =?utf-8?B?NGxUUElkczFtOEtLeFhROTlCRUZZSStpNDM1bVE2Wk90UDhYKzZaVklUa2Ft?=
 =?utf-8?B?NTVySWg1U2tPd3B5MlRBZ1kzU2tmK0lSOVdqRzFXbi9XL1greFV0UHU3QzNs?=
 =?utf-8?B?MjdnQUdFMDBnQ1lETmRLb3V5RlJiRXBQOHlZYWlKK08zNWd2blhPR0JiMldl?=
 =?utf-8?B?eUlyZFdjdHdIRUY4NDZaOUdsa1RQV2dKcVhidHdyZkJkTkg2cUFwRzVhc2lv?=
 =?utf-8?B?OHJyeWVVNGtkOUl6VzFqQ3gvNzEwajJuQ2lIUGVzLzBYK3A0d1crK3MyVHFI?=
 =?utf-8?B?b25Mb0JRbk1menlzSmVQdFFlT3V6SW84dW9wbVpWNjRwSSt5RkVKTEY3YjNR?=
 =?utf-8?B?NTdjUHFaTkkrU1VIOGhWYk1rcWNOK0xGYkJsbWVucXBLeGQ1SFR5d3Z2bGZo?=
 =?utf-8?B?S1R4YjlLTnRvalBQZlpwMHlLN2s4dHdWRzY1bEJNakN6L2t4SGhzeWhIMlZT?=
 =?utf-8?B?UWNlQzlTTVVwSk9PNnlWZUxGSGltTXJPWkdRMThoZWYwZHI0WWVvQnhENTl1?=
 =?utf-8?B?ZkJmMlhyU1p3ZmcxTzZxUkxRT2RNWDJpS09LclF3czFBd1g2TE84WG9BaHU3?=
 =?utf-8?B?SnhScFVocFpYUGZWRkJFb3VnNER5V3pUNTJwOE5RZVArM2JPc1hjS3RMRkVt?=
 =?utf-8?B?b0JUSFhwdHljbDNKb0dtNnFEM3d1dkdWcDRrTzVPb2RqWFZpdmNicU8yK054?=
 =?utf-8?B?NlhyRFp5MUdiVFlaMXVyNmY5WDZZM3ExWlJJUnkrUVk2L2s3cjVQWW1NNEho?=
 =?utf-8?B?b01yMDhlNGV3cnhrWWdJbWRrbklqZ1h2d1hYSFQ2VTUzNzJ3QWJSVEhSL1RB?=
 =?utf-8?B?dXFaSG0zQVFod05OaXo3N2tuK01ZTTRmTnRycHY1ZmlTZ0c3RkZUejlsK1F6?=
 =?utf-8?B?aDBzbGNwRko0Ri8zOU8zOUFYYzRoUjAwL2w1M29mY1kralo2Rm56UGxzblNy?=
 =?utf-8?B?S1k3M0I2UTU4L0ZZY1JLQlRQaExqUm1Ia1dPNkt2MVdsazZIOHNWSExYVHZJ?=
 =?utf-8?B?WTRROU1abWhHYmdMeU9EZmpPQ3lqbUdJemtzM2w0aVNGQmxGMVpoRWlKMjZC?=
 =?utf-8?B?STdUOE96SXZrT0o3aE45NERldDNCQzJIckxZVm5UWXV1WnpQR25NUFhRS1h2?=
 =?utf-8?B?VzFhRHY0NTI4RzA0SU9jWVJtZmgvaW5vS2l0TWx3WnZrL0Q1Zk1IZ2k3aldr?=
 =?utf-8?B?dmF4NEEvenU1K2FjbUd2eGtlZSsyb1R5cUhsaDhwQVRBSnA4R2pOQUs5YUU2?=
 =?utf-8?B?cTZ0MU0zYjhqdmZyclM2d1I0ZFpPYzcvVG9YMEZVd2FMeW5FZGozUGcyOGN0?=
 =?utf-8?B?Y2Z6VVQ0UThnRnk1eUlqbUlreFdWYlZIUkI0eUx3WEF3WTh5cGNaUjZmYUdU?=
 =?utf-8?B?RGd0aXFGRFFROFBFV3d1dmZJcnRnUzZZS2p3cmVobmFXV1N2bXpJeGNWamQr?=
 =?utf-8?B?WXdEM3d6aDRuQm9hdmhGdUdqbnpaaUtCbHpVZHRYVDFiS0Q4dXJDeExUUkpj?=
 =?utf-8?B?clI0TTNha2lRQ1EyQ1VTN1A2UnRtaENMaldLMzRLSzdkMGdMRzdJaHJVV2la?=
 =?utf-8?B?eUNBVEg1TnltZUVFTXhlK2JMeUxhNEN5c05TYlk1T2JJcFlMd055MFpROXRv?=
 =?utf-8?B?MytVUkk2bTNIVUFiZXFRMHhyVkppcTltUDBhd0RUejc3S0FSV0lNcFlFY2tI?=
 =?utf-8?B?REJQOHpBdllNdFArNGxHNHA0ZDlGQ0tTOXo3TkZWTkFyU09vdGdTc3lLREdS?=
 =?utf-8?B?Q2tEaVVhb0poR1dRQVdUSE04QmlwVy9QMERaZUI4VFdTd1BZL3F6UG0xcDVo?=
 =?utf-8?B?d0Y3M1V3T3g0dnFtaUUrZ2grRFB4bmxNWHlSYWVzeGtJMEcvTFdUMkJ2aS9T?=
 =?utf-8?B?QWlkRFBwQ2JRSzB4WFJsaGdnQkc2RFMrdXBsU1FrMEt6R3M3Zm50OUF1UFZu?=
 =?utf-8?B?cEtjakFhNkpoQWpHRGIxUDVDV3o4WmFwQXlCb0JncXdCb2JGb3crWkttbisx?=
 =?utf-8?B?WDh0dXA2V3VBSDZhYmtsOHZXMTBpTlpsaHduZmNud0ZyRE1saml2QT09?=
X-Exchange-RoutingPolicyChecked: RyS0w2zWTGTaL4Zl10ZoYVmIQ3GaEymK6kmRi2uTZEgWkgA5ZjR2UHQHiZQlKLB3OIHjR76jc6Lv7WN6WmZcQIE+Wlktl1oynTCaKn9GJRsxStwI6ro81/OWaSxAF1JHlHsBlOxsMryK1Vp3sKxs1gQ1WnfADajnOZLlkIXlPgzZTwNOIqXQJcqtt18Olqa7Wk2QZbosJJcHgdJbgztZs7tVJ4/9SURIdSdWwHGkUemYgAW3tpZ0L4U5VhJtia0ubAB2C/JrUQ5XDDon89QNYXQOo7OZKEjBw6nWjp6oWCD1cdBeg2Zj7Y/C+3TM0mfbb8y8/DrVGXSssRsdsyf/rg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a634cf-26c7-4518-98d8-08de96df2c4b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 08:57:20.2956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5UlUP104FsXtZLN1gMDRXtc1XNtPmeYrdARllSs8QRTe8U3duTiD/pvAPnQHx9ugw2WuwfOpzIKZ4ukDfqGbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9256
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4MiBTYWx0ZWRfX+jr9+xzxmcJj
 cB3eIRIg8hLkIolwQ80PvpHW//wqCne5yGclbN6yQTPHd0hSNrM4vT7KUgfJAyDRt8TB7qyL/0y
 ZQ0dnzoJM2amKhBJi13EkA0Ui/j9X8vbYjWzVEAe1Y3L6CA3iNUYqpFQySqNNbBhxxjAQw0AMis
 4TsyQeGi6YKY/AQq2PgHFwjwF5rjNFaq5N6A31llIZwlgZsiX6I0I24qx0YSaQzTBjKeezWvxXZ
 pH8ZKqj6HLro1oaNnbpGJh80L9HQCBOJ6l1INMZrntWygwkFCsCf4ERLrdD2WHnL2YOn27L5Ur3
 ygdQwq3R3muRn5FvbuOqZPca9KNGHielVaHu/uqXsjlEP6uDcH5K9tG75txT4RffSLs0Msk8BMy
 shvkC6+CSaKWS8BXVNKzrCgJrr6Q8mPaQZdbw9eb9AEf6quJwJEWfR6vuj/eouItYp43aLpqppj
 5+BCyItAv+TJodR9Hcg==
X-Authority-Analysis: v=2.4 cv=FuU1OWrq c=1 sm=1 tr=0 ts=69d8bb71 cx=c_pps
 a=APgIdIbuBBIe7PXa++EYhg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=yKlUySf5qK-JiufbxiwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Q_vcXQf5f-BBu5KGKEd2pQKNEjYTJwsX
X-Proofpoint-GUID: Q_vcXQf5f-BBu5KGKEd2pQKNEjYTJwsX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



John Levon (3):
  vfio-user: support VFIO_USER_DEVICE_FEATURE
  vfio-user: correct protocol for DMA reads/writes
  vfio-user: fix DMA write reply

 docs/interop/vfio-user.rst |  8 +++++++-
 hw/vfio-user/protocol.h    | 14 ++++++++++++-
 hw/vfio-user/device.c      | 42 ++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/pci.c         | 30 +++++++++++++++++++--------
 hw/vfio-user/trace-events  | 23 ++++++++++++---------
 5 files changed, 97 insertions(+), 20 deletions(-)

-- 
2.43.0


