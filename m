Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC09410F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYSs-0004ta-Cn; Wed, 08 Apr 2026 15:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wAY3i-00062I-NG
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:55:27 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wAOjQ-0000vi-Bv
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 04:57:54 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6388Vnch2041686; Wed, 8 Apr 2026 01:57:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=j22RflstrVc2DUyuaAUKUxlt4FIPN7YytsqbI0aRu
 tA=; b=E4eoW0vdQZ8QoBzYUVbj01z5pVtIOs4iSJjfu3PjC3xNPAYkM/GiW7pi4
 4xvqFICblsSneopZIIYgWR9PfmXJBpAMP1TCKiwIkfUbVbzKtvNkV+Ls+06yUbxm
 TLb3YeklDzucs8R5T7UrN3azPj7Mq7GWvUoMtsrLFA1xVJZdPHkD4Eqb0w2w8w/F
 vCVSzsihsX1idRp87YApTjZOrO9LrEW9mzJvnrNk9eOBuRJcuicKpPa0jC1avCA/
 CNe5GjJf9iN/uICjSEoKmwveKsm/jx7OKKRrvNZuzvhHhodTIyii/V6ZpGXrNRpN
 kotbmYOYhW8x1xh/Gc8w+1ZHVQarA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022072.outbound.protection.outlook.com
 [40.93.195.72])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4dcms641w4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 08 Apr 2026 01:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vG8o6E2n9Y4r17mB6FQeQ0v+9Iz8bkqCNN+7iuQgI8F6L2Q807hCavU+YywQcYw/gEKI1QEWwDQsBWUpw2F3A47jjg9GxuGsGUiWkJZmfe4iZG3Me14sBKfTSxAkJHofVSmlq21XWoRqExDvp+xz1mxsXH7WljRX30p4upbM/cAQgKmFrGfoZWAK5FhO4H676cXlSuGcnvsCvfgT4Zcu3EI3E8S+Gm/r0RtIg9QxfnLk5FP4+wPsfsw4tUzn/1pbXUTNAL2vwMYqOR5HWRnZ35LJzNzdVAxrjd+ZdD+eHQUdMAIPTG0Kg7w1Nmuy8JLkcPBqhrdbVvETEVzXAzropw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21oVDbQPBA7pXjEeR7r1GR6gtK/AFvOc8JaAscMQdjE=;
 b=c+INUWhHMOIu27Hlu82HiaUsl9gbhcmk0KUHzImpSqhdoqkBjWirszrYpzY6Ps0Nj0LdAvQajVLOSsxzJ85LtvPTqvzMzEdbFLY6YkdAO3TQJ4tZYETgZgJsM8EOqXzXvgnxGPQlKkD9Iet9y/3NXNz8KuMMYycasH6mNUunLuIj86CzPdK9vb0btm2AzoLl5Si1pBsceJpa+O4QP3Y+k5Ef948lob323hTOAvCct47gIMHxSYRhOK5lZErGcvcEU09i9AjwM1FLpXwWUv9cLCHBUgWeW9eo9+fYerNdIMBDIk6l/thPsI7wmy/F4o0dXVwNl57O1NBc2Sigq6yaOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21oVDbQPBA7pXjEeR7r1GR6gtK/AFvOc8JaAscMQdjE=;
 b=dSpOj63ncdK1U0J468+YQRA/syazOGwi5Rj0CQIVdLxbSBSxag9m5vikSEntzLFUXypFQ7aO/SeV0UyCdyDuN0N/Ic5WJBvJMyrmf3cOE4v5uomygu2F8yl9SMg+Y2ygCbeJ3mOuwSYOA5/1EDZ3PF6CLI0dyalEtyIOYVckEcBc+u6KKIi0ASL46sk36Wc7PBzruaVzkTiQo7hCHhaxyanU8ScqftrhQyBO3gvwFHAqyBaUcQZBEjftR3OG+NQ/JF0TzoRQTpQ+2NDwoVIZqVyo1QywCPGc56DQQwXukOvrvmlRbsex5iOekN//A3wADSAjbgxHWjMsPmYIUbD5LA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by MW4PR02MB7282.namprd02.prod.outlook.com (2603:10b6:303:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 8 Apr
 2026 08:57:46 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 08:57:46 +0000
Date: Wed, 8 Apr 2026 09:57:39 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: [PATCH 2/2] vfio: quieten dma-buf warning
Message-ID: <adYYg-OgUUavR31j@lent>
References: <20260317195323.776669-1-john.levon@nutanix.com>
 <20260317195323.776669-3-john.levon@nutanix.com>
 <2bbd13e7-5d14-48c8-90a7-231a38537180@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2bbd13e7-5d14-48c8-90a7-231a38537180@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P265CA0072.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::21) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|MW4PR02MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 37eca2eb-9420-4efb-6eba-08de954ce6ea
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: qa++e1KObPe0Fkolpx1UAIdnyWl8e7WrFN+NdF2Gb/y1xhIcAdeTiVSGx3nviUHhm9Zjrh03jO1knzJODrryZXTJ0gJ0k93RCqrAnJfNkZR2RsCRkRqZgDgV09KLkU2A7pyonJy5cgO3wEm6lMyCHHoXKr7WwdSFyylKPZFIByQuktSlsM5Gj8h6fRmDeL/Tvf9Icn3rdyO4J40wgzvEUuk/kIiwS36m/tlKeD0ykfhkkNg/YkS88PAvw123i1wNrb8ZR56CUxzqKETb0eJU3QDEAfpbS1ClYuEC6KfHIfoFm6+sfhHRjjhVUBpzc1qt0FEGlPWmgxZClgrBpTOe5r/vHBvqq+j0fwa7hIJa/+J7+MDy1A9Cs61L7BqUrt5GRH6GHIGsitiDm51rcMkQC79MMzldf2D5nr60hg0sxQfq0kb3zxSXsaUhDKN+UrIq2E0E4iiEI3OKsH75RuZVJUOQVE3cz9yiIKcAKcLs6BKZ4FDH0wTLKNLmy+j3xTdqDv0rEZYEb/hd2Dz7mkTvmWg6noH/VruO2+JAfLo8EXy9QC1AjxveBZVe/aTQQhlXuVjDL5HNmCASihvRJgACCW7ySMmUYXQkFR1GqFoXIxFCj+CyQrG+iwp0lYtjdW5/4Ii3nimx96OmqU8pb+N1yG0HTrJPr/0yyjv59jMcdilrbtkhHPB+HdX6tiKW5p+zpY5q16sgYjjWL9DFtkqwlJecFNUGhRqRth6BR7JypOc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?BHLyWqwGPvJyahia9dSU0YPB94LaEi+4sRVaksU+8bMZJT1oXlAnjKqlpc?=
 =?iso-8859-1?Q?PtAgY/6sS1KkUB7gAgVY6cKSWEgB1QIAfvCuqvPGOkx7+WbxBw7oG6B/Jd?=
 =?iso-8859-1?Q?bZ0kRppJvi0JozrAqmRYvEPtziHLrdNZAx9tWobdMChbSDSiMLFj0kvl5N?=
 =?iso-8859-1?Q?4/YaqK+QnpYPQHYMzxffYFzYwdTCyR5rngJXDCQ7389BtJv2Cm1/VmGFU7?=
 =?iso-8859-1?Q?loB8UcL28KhEPAZ9h26zPGfLmhwSYloIQjbGyDMqFXueXDCl6jnG1MYflP?=
 =?iso-8859-1?Q?+ZUyF4AaSsVO3I3g5qiBKViY9M3LayNq5ZFVO27j1DRP/QLiEyJEPUU4S0?=
 =?iso-8859-1?Q?DhQDzcVa0siqyCm7zUP8PEbYj9ua/QBKxvXpPuhKFUQ60uJV9SYwh/AWX5?=
 =?iso-8859-1?Q?rBwygWXU47SZJ9GqVMlUVESfaTz7NvGSfB+GlINP9zsgaNEY0Kvl1+rbZ5?=
 =?iso-8859-1?Q?RLVuoZlTVerkF2vrwgFiF1/b2eXLLSJ7IOg4AUDt/Qu7peJSxy7hmwlcIi?=
 =?iso-8859-1?Q?vX1xwG3Hnpxu06TKB1Ox9847h57BhxEAzRklriJGicMUOmxVsjUaBUyPHY?=
 =?iso-8859-1?Q?a1ZKxO8i/Td2LDo40YERYq6dmBOkoT+ldjiv6VqpbHRYhoivhi3U6Jxnz3?=
 =?iso-8859-1?Q?fsbWhGNP4jdfAZLk8eZxvl3OUXKe4MzHgoCt+sEmDQFLxfAkUFOXRdxYaL?=
 =?iso-8859-1?Q?ZgQRxTXtCHGdhj6eomd4Mxiu3Yld+qrDGFwDiyS8+n0RIyKg1RTXicatVn?=
 =?iso-8859-1?Q?Cy06QT5RfwYNxvhiTzSgi7PkKaZgmMazzUBUNUtWhIJNtvvlyQQkXgp1Zn?=
 =?iso-8859-1?Q?PyGhP0HPmC6msxxBqkd+Y284zw57MmmXCXD/aVc+K9BFsl37xvhncUar1p?=
 =?iso-8859-1?Q?5yE8NFCivam1XEg9t8GsAK53XLNwEiRBbbqntq0NmNPtFKHZw/sLZaZ6Q2?=
 =?iso-8859-1?Q?QxdzBsZeZGDDbRuuYVr7LGq83pWgMy4dJR9lEonqdTz1nP4aXV4FqzV5rG?=
 =?iso-8859-1?Q?2AAWrNzgjpJrXassSYlIkqkX9JFQawDLOmFrq17eOBn9ZzMpXoB1/IEcWl?=
 =?iso-8859-1?Q?1FMs8I+A+x4gWt6hepWtfPq68BprKdXhZSu7cZJN3W2xH9LcPDpaXWBokh?=
 =?iso-8859-1?Q?QAVP2G7Bq5Vvgox/ZJxcnmITFaZXSP7F8hX5VED5WjLtBmxtGqHfOT4tMQ?=
 =?iso-8859-1?Q?kJvKJaFuDc+XH+A2BmQYwK/Kl/pGzw7fySrb0vev3Jb2ZqFqWViNhIDmW0?=
 =?iso-8859-1?Q?7boSLf+oPDFdkXG5kCTxMgyy5LfRcS06zZPyhNE5mxYj9UsT9v3S34gXeK?=
 =?iso-8859-1?Q?s5xgqk+HQ86niOJtdXvZHr43pe+/ePpI1nRFX5uD0DvdNZfWjsL+ujHL3z?=
 =?iso-8859-1?Q?AceikcTYi2Oawmu6DUOFOuwVJbhDLhX6aJAM0kTDNE5X8/pywrbgCgyT/6?=
 =?iso-8859-1?Q?zY5ra11jYJJNED4px3eGdjB1XJ7N7TbCiEKTUQw+LMLSuiQ6Lt+3LLffD0?=
 =?iso-8859-1?Q?twHn3UZjYascBGjh3F7KbZz5VtodAa5mYPVuvqPhNb7BV76R2b8Gf6O0m/?=
 =?iso-8859-1?Q?7aKDKZV97Irpmbpxo+DwTak76JSovyZectTLlAfQ5vzPWxXgf8Iv8J8Kqg?=
 =?iso-8859-1?Q?GEGw0u+D8xijGMjDyVGDOiMee6noEH5SlX7VVBKKBEdXO2CuFIZ3OVxEMO?=
 =?iso-8859-1?Q?HuusFjRiB6O8tVR6f4Up6g6ipQCp2rvTnU91olAbouV1wmVLcolyJACDJu?=
 =?iso-8859-1?Q?dR/J61aymFSanUy3y7/IYw8XB/ViCJW50kbOfNAtzirPczencbnFw5G3sv?=
 =?iso-8859-1?Q?1npDt9sO4g=3D=3D?=
X-Exchange-RoutingPolicyChecked: bWAxbfzyO5D+31lhf6y3QsOheZ13lrm2h/Mb2C9iXK2dePez2+R5Oo8+jKssqK5Z2yi9q0nOW0GcuYpeCAD4Sx3/E/1JKVVKOlqQr4NyNkmJfg7GL9uIWJf8WZWzHkXod0gHqun/yQijxP55GnbbduZTCIKFo09R/CdRHozOKpNLuBQlqQTcOvXY2iiPgU4QM7f7HFPx0jWHqUVG3htnxUuZYO0AHApF827BJwQ4EBwgcbu99i8LPhN12SQJBx8wY5yUwCWuNy3nB49YUbyRXWJ/Ze211gth37ETIj5RfQg6tjpM3GEd9IqBbqMV7ilTpSFecFOtmZuToIzalj2nbw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37eca2eb-9420-4efb-6eba-08de954ce6ea
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 08:57:45.9263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6aYvVXO5LSr2PlPYzlRPSLy97jv6xHJYhL87QuJpwm18iNl7d7csnMX5+wammBiq8FpvUjC9TdWUMHo+jo5wKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7282
X-Authority-Analysis: v=2.4 cv=Su2gLvO0 c=1 sm=1 tr=0 ts=69d6188c cx=c_pps
 a=oU/Ts+293Snq71mcenrglA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=BFdryi-f5bHqsU2bZWwA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA4MSBTYWx0ZWRfXyJIXJw5BWbhm
 KbiCTIIhE3TCZTQJPEoN6EdnklfaiWPtJmcZGU4/DmaKwvi5JZOS834wn2XjKY65dxd44JufLSG
 COlvrll27Y5UKJ3rPwI/2mYi9J7VmiDHdEEJzaJ5IyeQNujZRlDNidE7F1T0i2mvVo+LxmMQVq0
 d9jJpUyWnyVfMAc2lZwb2A1siwnxZ8MSW0hYxGGDm1Md/CBby7G5Fw85p+NmQ2y1bOzfQY8vOA9
 ioz7FxLe6sD07gcGpld8yG4q+pPuLjGNwmrBDkgDCe+zzKPS7lkYWbldwKVQocpKnRM9RcGSiYt
 dHVTyQBFo5xXChx+ORisa4A/edUNcNPcVlpc6HXsvSTDV8HBI7B6QD8m1PRsdOyWyDBIkn/CFcj
 zskMA5+Xf9446ZKYSiOU9AXCwLMRCtEQSL5uXsMfQJ48HCBkLKd4QsJvQDeR2rvMY6eStpxhMWI
 FzG9dQM+vrBcC9X3bMQ==
X-Proofpoint-GUID: 45cfg-UbHmjIXsM0YjS37oNSFFDZhcUK
X-Proofpoint-ORIG-GUID: 45cfg-UbHmjIXsM0YjS37oNSFFDZhcUK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On Wed, Apr 08, 2026 at 09:52:53AM +0200, Cédric Le Goater wrote:

> On 3/17/26 20:53, John Levon wrote:
> > Don't report this error every time,
> 
> warn_report_once() is not every time.

It's every time the VM boots for an obscure feature that is totally irrelevant
to non-kernel-vfio backends.

> > as it is specific to the kernel vfio
> > implementation; we shouldn't warn about things that always happen, such
> > as when this is backed by vfio-user.
> 
> What bothers you is the "... kernel: " message ?

The existence of an incorrect and meaningless warning is my complaint.

> We could use (!vbasedev->proxy) to change the "kernel" string to
> an another one related to the device implementation. What do you
> think ?

If I'm "allowed" to check for this to suppress the message entirely, then works
for me.

regards
john

