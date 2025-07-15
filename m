Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBE7C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc1u-0001v9-TH; Tue, 15 Jul 2025 05:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc0t-0000W5-6v; Tue, 15 Jul 2025 05:31:57 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc0l-0005jQ-SE; Tue, 15 Jul 2025 05:31:49 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F2Oif7029269;
 Tue, 15 Jul 2025 02:31:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=vC5KbtvziMwu0FUBQc8qXcUyYxEbrfOJVwgfn5sn5
 CY=; b=DEZBRu8F16vYxYh8iYIqAWx10bajPU+2mKphKdQkuF8WxX61F88u9/npw
 UgUqeU6fJ/lw8S23cgHaP2IwxRhWNzL3ZHy+2rCGaGWhbRqhjHOGt3BUB1Rs6e9/
 tkOWLohD2OdMBU4XYIUXKaQX4kZPf9Y2fSigRxj6Bv2bDLpvLxnWsAvc2lX7wJ7m
 U/joySDwwr9vE3wQnRAiSqTqu6cnnNstLxU2SOHnN50OrKhuRkGbXbSzCdWPwFCO
 X8CCKiplpvxo706eLas/YpHdYZCL3rKdQ/1otW+3KTJANfBnY1R22OCPgJp9C6BE
 D+YZmO/sT/OHLiZEtzp3+QgjKSJmg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2107.outbound.protection.outlook.com [40.107.237.107])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47untj5x9u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 02:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEdwZECrZzUlIossrA3pRLc28HKywLgz+I9DTYp+TFrSVZdDQ9XVatRfCi9TU/MLmeQDgTIlDHgr/LSlT7hqmrZv+Zb7LUajkaYMpZNiTinQ7bnThiwFpoRcRa+9+9gOcWwQjCC+IMCklxo6dk/udaPAXg9oJts0i0eOAHt6nXbW4G3EkUCJOYUORDNKuCCi1gTfSwhvtmaeQUbu/R6c5+MSZZFbu9osxVgBTd9X+/mJ8OXTdCltLS2ePDNr6na6FPK+QENQy3tbKXS8psxUuX7QYDnfv4of9wsA99QVJbdQrgvPsHEqA1qMHFI4bQgITkGGwgq3+d21nu40eEO0Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vC5KbtvziMwu0FUBQc8qXcUyYxEbrfOJVwgfn5sn5CY=;
 b=uz8730PaaOPOKfmxJTyRlZP/GGrJYssdu2tISYxZj6+8Ub+/s36l2Mjsw3R3h+hFY1Ag1vIcV47MIZXcD6oF9YSQ17zuLAMdHgKcnFV1EfsM/DFZzz99ZdkjzLi1KgLW6gv9fXQgMouv/Cn6nN0mJGK1hbSAi2/5YQhcevKdwVWCug6BL71ZM4ey5s/S9zvhO8yugOu4yNkAJzm2iNUNZeFLqlBmu5PPXcmhlaEcylo5rTlb3yPCxWAdDAwELDcab2GbCE0/i8v3OTctXvBGA8SYv+l9aSnWCZyn+MzzspUapR82RmcPg3ywiZdNKuuxolvF8pS8Jwh9OWJ8vvSD6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC5KbtvziMwu0FUBQc8qXcUyYxEbrfOJVwgfn5sn5CY=;
 b=iybbSj8TpIl8F7sS7TVCzm+OX+keOBgo9wbtZQwTGy/L8AkO5yk8YjOldceuvXx5ZtSAzK4NY5kDeZUtrvI/qP9SDnwd0tEEbw0xAiNhEmyuN+Pg/MCmQE1bp7wYg59iCeSfz2F/+R2ttA46vsHqe9FSalY/tk+by5HfRBfm05JeAcoMeKfNzYrIWzD+M0NbQvt/DGfHAOISJphvZ2dLyOAS2Mex8bCiRsErM1jG9mKQ8Tu7nIchlOD1oJbVDENYu6kZMsLGtDmi0lQfcN5u1Zma6eBhc8kchDuMhR7zy9vGdVwAEtf0FP88sp8F7DYNL9DpgmjLXEGoSsLi7l4bpg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9770.namprd02.prod.outlook.com (2603:10b6:a03:548::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 09:31:35 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:31:35 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 06/22] vfio/spapr.c: use QOM casts where appropriate
Date: Tue, 15 Jul 2025 10:25:46 +0100
Message-ID: <20250715093110.107317-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715093110.107317-1-mark.caveayland@nutanix.com>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0032.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::21) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e9777d-0b57-4a65-32c4-08ddc3826470
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i6PL83PPCWtIrxf/uAqyj/2rXuxJK6kaDojnNLJ4iJ+JyowHkRVgDCzitvwI?=
 =?us-ascii?Q?CW+T7YIJ0/2b/zujv2aalqeYlxp3LtpyIgGPqxdO6vlKXjvj/O74q3I5eA3G?=
 =?us-ascii?Q?WKew8JiDtf1almFiYJ8AChVKdc+Ok2+A/5dtPZ7BpDdJM+7kPXaiBEvYihbQ?=
 =?us-ascii?Q?piMko6maWsfIuGFZHhZmtxQ8TgTfwDKAdOiVJo96OkhiqvW36/2F11vKEkdZ?=
 =?us-ascii?Q?WCu5Zua4XhrQ/jnxKxOHXIUX0WuOr+W1+dy2i5N6pHXEj/3FhmCfPjOPBn62?=
 =?us-ascii?Q?uwSrn2Oj6Sti59G/ZQe9otaaPQMWFYh7AZFH0e1x6AIVtEFM+pCeLm4XyR4K?=
 =?us-ascii?Q?LYfL+2+zaAUctzQ9pMnh83HA2k49tJt3ZodG/oV6FhJgl4stVBrH6E5KGwKv?=
 =?us-ascii?Q?AE5PAczoojSTjHLdmmmcmaOcQagm614xAYNecG5blqW0i5OWIc1sSLMiKNV4?=
 =?us-ascii?Q?apoqAZpwYcsjr7aoJhmPvknDSLIW4qZZZeqxPrEEVXmawG5AmpcpnblQjH5O?=
 =?us-ascii?Q?HslcpGbQsiL5nhO7FP7lvtSf2I8ZTSOTOOlqTz9SuuIaimH6k8AC9ByhZaPt?=
 =?us-ascii?Q?w5vs407eKguJuWg+u62sOZvwmbf3K5UKQ9ZOUv4PNLNLfaM+GUt7WtiaUYjC?=
 =?us-ascii?Q?mVh0kqfYGwXrAFxNxxLCVhRT6TESe/XSs2mLWGmWeZAKTZNyGFto6AeB64GD?=
 =?us-ascii?Q?/7FXnZ6J7VeP0GXQSEpXylj9gvOTtIUSodZSzonh9NaaimBsMkEzmbn0Q2Bp?=
 =?us-ascii?Q?JIc45tdENC4j1lW322G74SwqrYzHbysLVt5AxRQDq+qIPJr0gk8WDDOUQzZr?=
 =?us-ascii?Q?++KRJzdeu/NgKFLIvnTHDdZW6L8J9k5C+dZuhxquh0bA3mbORGNUdw3Qaj3V?=
 =?us-ascii?Q?753RZCGscFvvt1WmL/+X0fsSHZPTCjKW4WtGozA2QL0T4TZAsvmtxSqQZzKe?=
 =?us-ascii?Q?h/0/JZMbrmMy4mHsJm+TTWAK3ksyCr1j9f4pCY7Tg2rqapbF3Xq9XY2IMxfp?=
 =?us-ascii?Q?SMuHK/Txv0kc2+sEzdEh6z4BuZhgVk8O/Y1ZEXscTvqeO2wujn3k6EbFujxD?=
 =?us-ascii?Q?Y4tD1jzY35BurxS4f55APFBZbK0RO+q8rzmt0PILZavHKfNnJB6ndH/AS75V?=
 =?us-ascii?Q?wguNHalLLCh9VL/J1ne3tk4QYwHttxXaoZMod0o1LG2uSk3ikIu7vyAAYFwo?=
 =?us-ascii?Q?bmrhz3uT6yOYmisJl0u22x5fpQ5NSs9B+Fyd4pW8MMwR3E90pNIQ08GUbN6e?=
 =?us-ascii?Q?yab2TblDB0YKXsxpPFMXB/HkrgTmjbgtlj/I0LgKUm3/Pa8t836wqZu5L5+J?=
 =?us-ascii?Q?4VGJFfjVgvyFYQmeWpNASA/OsPjqCnE6+UnvHt8sGwpF97NpNNnBbEnxjt56?=
 =?us-ascii?Q?MCkyxGvJYFkTNZpPZxIVJ5mk6jmLc1k/7b7zCgcyyoHJDKllKaRlMppsvMat?=
 =?us-ascii?Q?FL6m4AVjwm0w9fw1M0ABvIqSdI0iwhQQRQge4vl0WC4GhC7RxBjGTA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bKuOBlRQk+Le9pFADt6+jwdeO/ANGHkJuJuIhW2QXyY0GGvmbhibHJ0XWk6d?=
 =?us-ascii?Q?v4T1j2pHltZQR+kJObRWK8K64mSqTM9Stroahju8KjK2X3LFyE2HvZ5UM+1g?=
 =?us-ascii?Q?BDfJYmhBskghkxCQXXbc3l99+scqDZLviNmuJAlLhptO3Ct2jZVbkeL4gTjN?=
 =?us-ascii?Q?/J6fFUmoiM1XiHgxWOis/IM0vLNC73G56tTm8kFFa61ucQrQnOY9HUfn7fDc?=
 =?us-ascii?Q?62sT2UQD0iGqUKw8VDE30Xss1YyXX/QGfF5isxNfiZvrfhQm9npSS6btAvaX?=
 =?us-ascii?Q?212op1h+1Q/195ajNdMArB+94u1kZ64EX+o+pL6tHuPnaTA42S7mA3CZcgy4?=
 =?us-ascii?Q?H2WcyXWw3DtHS136Eoqw2gkxDDnK1VZ0xUkxs07mfSV2pI3YtJgdmXznbh+d?=
 =?us-ascii?Q?xSOfVbpjN54W7zL25sB1FhjOHsC31vS6TxOkG32VNBqBNl7KtA1sidanMdAQ?=
 =?us-ascii?Q?UL9WFMI/GVilbdAq8/GleTZ8EHoeCQz07hyJh4/x7wZiuKJ/AW5PojnuNuT7?=
 =?us-ascii?Q?unGIFw7mF0wqQhJoAHTRWTPO25Q6jYlbfCD08PiU4NkA6DEZ0OQGnuBPm2z1?=
 =?us-ascii?Q?ekDpjpgKjWgJ8/+Q6CScrVutPDclM3xgRq0vvut2M/FzXFQDP7rTt5KoNiUd?=
 =?us-ascii?Q?Ep3ceWgljNbkj81VosQdE2Ri3jVTAp6NhzVvuQCWmH0SMYAHMPgnzsGgnapN?=
 =?us-ascii?Q?8I4EfoiTsXi0myePd+DOFKv7+sVOapcr9OvBOtmyOJsC+fsdICLP5DlYXSfd?=
 =?us-ascii?Q?X3sVECclxReIkW3priUBpDoV89583p7JvqBycr0rUcFftVZS1rz00cWh2oyF?=
 =?us-ascii?Q?QaJkXfJz7DsnGwczBauhhxSWfRQrHVmswUs3ukkKh0paRnxi0fG3rwR/HTyQ?=
 =?us-ascii?Q?S/yji7uRgKn7imnPPy8lzSiTOk16EU17zE4wpVaWORoYtI+BsNQ3m1Sgo6/B?=
 =?us-ascii?Q?5+PHiKaLRamjrGw5Ehoc7N1dqKH7jtPeWntF63sM+Lp0Ns7Dl928IJXWW/oA?=
 =?us-ascii?Q?PubCVKk02almC8QStt23sBq72n1KVDz1IoKvXWvaLKbEXaKjkMcZfGq0FzK5?=
 =?us-ascii?Q?kWuJ3YlxqiYGJuvsxlTNvADC8yvsTtvQE1H9mQAjS6I3fcTvh3MJU/7g179M?=
 =?us-ascii?Q?XM+PaqqtESYXu3yujv24Ma1Q4p5PkUeELm6HCjMyII5/n+iEEIg9W/SK5Udl?=
 =?us-ascii?Q?3GbPIjUoCqHD4rLj5sih0roSD+8PedLM819qHEbmzkD+LKRjf9emHy3l2Yuy?=
 =?us-ascii?Q?8raLcAhOM1DTXnbJBx2mjurc3V87mWLEzUSPB3m2iz/oEHN53q8TtEoaqtT3?=
 =?us-ascii?Q?QaacSgxsQ4fB+0R+HMe0L3jth4m2NtH2TMLIVXAsHR0cOVqMFUipBsO/oo2V?=
 =?us-ascii?Q?So8s5qeXsA28uqerpRaTsZ/URlgm0ouZ8sXZsZOnCGL06ZFkCOXHoK4bZ4CS?=
 =?us-ascii?Q?pcm+89maDjV4DwBZW7NG/Nj4WocSUx3qNkHZIOQ6K+qasKicSICa9PZrQkvY?=
 =?us-ascii?Q?8NkYNuj0qCFFnXIpJ1itqAGhyTu+D+RG1KPh8OoKck60IRIHv7iW2PRH2APV?=
 =?us-ascii?Q?yoZc8KUrmD05qOHfM/lfJX3tQlQxIF7vvamMTGRgE6ZRUjMc7I4uBT7Bl9UL?=
 =?us-ascii?Q?D01+4mgnOjVscIyd4wdVTKBWaQL2olTZmvu7lgceeWQ+hOr1aZ8KawNiGhy/?=
 =?us-ascii?Q?OpZ76A=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e9777d-0b57-4a65-32c4-08ddc3826470
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:31:35.6785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cftAr5UHN/ADZDSyimStizUwfxyMruYvgCyiAPulWXJ/iYXELGHRHdxdNbhC3cqBxDn56g4VPeW6DAoOwspzp7Y7tW+Exr4S5J39Li94YD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9770
X-Proofpoint-GUID: ZhIAnOlcpVVyC5zp4jKsG1MfvaQq7jBR
X-Proofpoint-ORIG-GUID: ZhIAnOlcpVVyC5zp4jKsG1MfvaQq7jBR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NSBTYWx0ZWRfX15HYzJeiy6rv
 DFnLW6FvxTU90EyTtxwUN3U0iaAQmlWX1wM9BLvib6qhwin7Pdw7HPze8bicQsMLTQSUrqlCOsM
 Wy3mkoonCXtIXhll/jxOwIadsA+C0JLp5tsVeoU+5+Dy2U2b9kstnvm21xBByu3sXwY+4AoaFob
 j8MaVhRvPYNy0AyBxz1773mu8uPA1axc/RjMUyPM8Q7ii4gC+Vmed1YsoCiZmGy5PJxizURD9/r
 kLnHAFy1yeeWwg2P67B/vEqIFrQ2874RuR9RUDUtqoYD9REIxusGNvATSbwZnKqawvLOufZpVF9
 SQfodRziq0yufs83Xp6g/SiM0v4Hp1SxZMnbh9nIwOZnOB6U1fgigU93K3kGZzoPB9jFvLgkRdS
 dCfSqkq2EHLkHGf3McUEsCXiJhOuY2myqEkDdHZefAR83g0tPrU60VtyDGrXo/cifEoS7JQF
X-Authority-Analysis: v=2.4 cv=PYb/hjhd c=1 sm=1 tr=0 ts=68761ff9 cx=c_pps
 a=uh+8t3r8MFU2BVWJWTlZiQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=gZw2tK95kLXG2NF65vAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Use QOM casts to convert between VFIOContainer and VFIOContainerBase instead
of accessing bcontainer directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/spapr.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 564b70ef97..c41e4588d6 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -62,7 +62,7 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
     VFIOSpaprContainer *scontainer = container_of(listener, VFIOSpaprContainer,
                                                   prereg_listener);
     VFIOContainer *container = &scontainer->container;
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     const hwaddr gpa = section->offset_within_address_space;
     hwaddr end;
     int ret;
@@ -244,7 +244,7 @@ static bool vfio_spapr_create_window(VFIOContainer *container,
                                     hwaddr *pgsize, Error **errp)
 {
     int ret = 0;
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
                                                   container);
     IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
@@ -352,8 +352,7 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
                                         MemoryRegionSection *section,
                                         Error **errp)
 {
-    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                            bcontainer);
+    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
                                                   container);
     VFIOHostDMAWindow *hostwin;
@@ -443,8 +442,7 @@ static void
 vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
                                         MemoryRegionSection *section)
 {
-    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                            bcontainer);
+    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
                                                   container);
 
@@ -465,8 +463,7 @@ vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
 
 static void vfio_spapr_container_release(VFIOContainerBase *bcontainer)
 {
-    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                            bcontainer);
+    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
                                                   container);
     VFIOHostDMAWindow *hostwin, *next;
@@ -484,8 +481,7 @@ static void vfio_spapr_container_release(VFIOContainerBase *bcontainer)
 static bool vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
                                        Error **errp)
 {
-    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                            bcontainer);
+    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
                                                   container);
     struct vfio_iommu_spapr_tce_info info;
-- 
2.43.0


