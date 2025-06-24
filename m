Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0641C77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 09:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU09q-0003YH-Kd; Tue, 24 Jun 2025 05:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uU09g-0003XS-BA
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 05:41:30 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uU09d-0002A6-6r
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 05:41:28 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O4ZP3r008135;
 Tue, 24 Jun 2025 02:41:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=a7+ZVsPbv/WXs5DQh569z/hv6GO5UrlfncOrg3C27
 pc=; b=IwV9mn8W5aTyeKUgCzAb3vad8Mk4156wP1sib1bMR/u14Qt/i5z/p0X+H
 4//0Qja9KI9j2LB789eK6sFP1MCgMXenMVcUPI6EWPYgs84+nqo1GtTqOrBeZEdO
 px+ux3S61JNENXYfkMcLhI5+HwMrvn0CYVi/vT/wcOYuJdvQTdpFXHctBhn5BeQk
 SJmYUf2Mi0aBgCj1pdCwZfOBfYmARcf9B+L1c7XRS7SHylNtWW20lbkPDiwxMzps
 X1J1iD+ZmqG0KhvQ7eFARopOo0IfhkCbF/VhaZl0ElbwG7BvPeZpdFwluXW1m6j6
 M7yWVsOo+rKN6CBAyjJNfK98Ql5cQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2132.outbound.protection.outlook.com [40.107.94.132])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47ds2twkpe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 02:41:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObBkK+Ez+FJurRDdGtt3GdPW8RAbN4WGYG2A3csFB/cq5M85FjtNp2RreQyNkmRe3HK1Qj9q6ZzZjVvgwJM/4gCAq7aGWDcm+/JBIjibo/t7f3H1aIC0FuNbJT9PgV89OHHQRXkjcAh9P6DmiSyEqLHwJ2IWWlQ1QFm3ld0XKohVqyT5OuB5IdL3OH1BAxG+HbLyOjdZ3wbPG0CuN9vB05Xs1ROaVy7zGzzNwS0XO+tl9Do7N1mi9CZK3czckqQ7E3OrCkFb/LmiyY64BQl+y+d5RkWwWFFT7Pw2+7ZZrbxxGFySbor0TAVuhu9cB3hg1WQ4l6yssjX+d3506xX8Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8c9Vu2ylZUA8mFpKsWlTKRnl+H/jd6eFSMQU0iL7SaM=;
 b=RtqhrXRxOKX/3ZBzL+yEhry7Bj+s2va4IqmJy65gY5MF5E1RJ3EwqYFaXDYNw/brBlai8cwW2Pvy56bWy/gH3Z7UMa7xp4qlOUbjoO5BmgxETKZ8YcXFjtS76KHOlzmwj9vQJe9DPeLU7m4/+uPHi7SWgzS21g1wIIPVzozEc523zaFo7DMuqUoGbppSEhaU6ph3ZgUshRCnnEqR98DteJmSYPyS6pfS6gyrI4rT5umRMNVFwa8l2aTbjPh6uOC8URNpgGAZeo1g8PwXJnBqeC3CENavZ8lNGF4O2tIsYM9vI73E4kxcnz6VJ36HciAjHvO67H/1W/EpVhgN0Yh8qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8c9Vu2ylZUA8mFpKsWlTKRnl+H/jd6eFSMQU0iL7SaM=;
 b=Yd2JmsxoOlK5LCBVQDDo0zh/xkOSJORJA1Xr2QAgCxNp3qoYR0gWmiTHCD49TfOXV5tbnmeSYDJjkvqPqdK6FqunUUwam8+kdemjvaVUeVfhyPVa9uLKDn+hDMGAISQ9flDRav2BYmZ68G0jKOoJMqK/0bMiKsbD52+WpR+oMJb2hCaKb6kcjtsBaB0q3n4A/w/JnyoVMZgpZOxBccQQf1vdhd1Usn/lW1AdeHlVSG0PHoTiE2retlGWXgbUMQn8kVhC/2kQaLYx3Vcy5ZDeApYQNzP3XuRpFebLM7CFmtC/g+SjvTpa39AdTyYedoPK4YNJIhUdXiYr6CqVm9sBxg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA6PR02MB10672.namprd02.prod.outlook.com (2603:10b6:806:43d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 09:41:19 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 09:41:19 +0000
Date: Tue, 24 Jun 2025 10:41:14 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] vfio: add license tag to some files
Message-ID: <aFpyuj4481ycabfO@lent>
References: <20250623093053.1495509-1-john.levon@nutanix.com>
 <78fc7bed-75cb-4d9a-b6e2-86b95319bcfa@redhat.com>
 <aFpqaC8HGEK5A7dV@redhat.com> <aFptjwzxKjvwYUgP@lent>
 <00590277-eb13-48b2-afeb-f99134fb3265@redhat.com>
 <aFpwrqX0idMrL34I@lent>
 <b7daa3c2-a9ad-419b-a84f-16054543ba76@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7daa3c2-a9ad-419b-a84f-16054543ba76@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P195CA0009.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::17) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA6PR02MB10672:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4cab70-5b50-4fea-503b-08ddb3034548
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?oD35YHTbvoZzCYjsuQjJIzMk5JZ2kMNvYVRyl1ZEP0BGlXLk+eJDK0EROE?=
 =?iso-8859-1?Q?OkYHmh2yzWV41UZ73rV9BnSHMslbaEx10d6d+L7e1LxiTL1ukGu6CVGuPv?=
 =?iso-8859-1?Q?ujUbqK46cTTe3MvE1VX8WSruf957ffljc+LaTnQA+dtcORzPdqkZ9sSLrj?=
 =?iso-8859-1?Q?xSINHknaYLEe3TYE0NgDxIyrm21zhdZCg+JzKEfRFNI6t/GzijD+yOVZvm?=
 =?iso-8859-1?Q?G3bUV+9BFf9PKIEj0CcjKFmVhZccCweReO4moBHwrgnqkOpXmuEAz/HAm1?=
 =?iso-8859-1?Q?CH+By4hcRZE6ZrrWXd7bSREiDYSr5bk1FTZn8SfdyXRsSYpuAe7k1n20KG?=
 =?iso-8859-1?Q?J0HWAzSWbDfMFujcmIvDmB2ok2E7QWEdEYvrbuJcUNK1m4220+vn8i0MuZ?=
 =?iso-8859-1?Q?Hj1RN+N8HjddkuxhFNNYqtCJHBtbedDt3hv1KHx0nEDKR5F1bqOSworv0T?=
 =?iso-8859-1?Q?wclG/Z6g1Qthgn3wloJ0SCX7N/QJoV9bb4oMx3c6WojNETE5cOq1tD54eM?=
 =?iso-8859-1?Q?v9ev8hMygNN7dc134RX4z8hi8LBgT51URx0c5O+9xoNiq6HuyJOZyCwXq1?=
 =?iso-8859-1?Q?dHP4FxK0BwJljTXSuLoRjKtCGpqK/41j14twDZQtz+iaqdxyEtJBaQwQtE?=
 =?iso-8859-1?Q?PvAw/ZPSCGtPWMl8ZA/ewDfgWkgUX/4GnXWFfqlzB9Kadmx3zZ6nbjmyV1?=
 =?iso-8859-1?Q?DyxDc1uXc0JDJd+tEtc3ItzLybfZoHgXpwMPTzxHl6TA9G0jKSX1hpsDIf?=
 =?iso-8859-1?Q?H9+7idf2NOMiZCoRCE3SFW3QwC4/Ha4NgtHHTqaLM+MRe+dAqODSYEYnfa?=
 =?iso-8859-1?Q?EDe7UUE2W68Vg6amgtPngwFZVyItcCgrTFg2+pUU93irphfMHFRDesKg/Y?=
 =?iso-8859-1?Q?zBot04rFlIdAbbJCfip+s7sxQnTemO/r5/2biRFbUap9dYD8i3IQREAtre?=
 =?iso-8859-1?Q?IXZuhbneh3LPlMxHPrKaSBJhocQUKydpixBf0ppTEf3KbG9rqTYmINpGlB?=
 =?iso-8859-1?Q?GBqDtrplfK0U9exEH3JjaPrm9doMRq2+Nm0qrWLag8IsQuLDuyrllsJKUB?=
 =?iso-8859-1?Q?wJuEp+8AQAZHAMy3TwQPhCXeSchv8dHLyXv5hJG5gdViVMaSZSssbxKuul?=
 =?iso-8859-1?Q?8vzWVR6vA2aalDoR0PON6b0OWDHmip++eN1weEP4xkT6D7V0kSgV/+qrjc?=
 =?iso-8859-1?Q?SKaga2Gxwriag3iiBRHbJlF3sl2PqFY6LQGPZGxixMcSuhhGfFd2xGYbyW?=
 =?iso-8859-1?Q?Qvslp9RqC9ogByQJzZzJY6dMjbrlP9g7MhUcghGMrfPq7oUFEnBp9Xmmvt?=
 =?iso-8859-1?Q?QJV+WissK+VPlMQAzOkwX4GNALs6xXNmxGLMlz6WJnyAD6AY5rh3CSZk1A?=
 =?iso-8859-1?Q?lPMgmk61OyaFEB5iy772/BN9Q3Y+EUA8vg2a9eafuDiv2cbhsYL5oA4lhJ?=
 =?iso-8859-1?Q?0IV2L0LrOmQMNZcgubTmTiBwcgDpZt2bTZvjVqqh3v+vUeQ7n/zn+w/Da4?=
 =?iso-8859-1?Q?k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bNw+pWvMQ7olNrN3rlGkzrTOyAwNwyqtg68fvqySC8RwhIKN+WFKOOkRIV?=
 =?iso-8859-1?Q?sTflTHIa5Dttcr2aM7FfzJIP+AQI9wHOzlTPa3Gk3o5d+lGkfDf2mhmlna?=
 =?iso-8859-1?Q?Ove/kR3Z4eV6oS+LHSKnFFpGhpuuowu2vCU/6kPgVGWgC6hRa+7MhWykPg?=
 =?iso-8859-1?Q?oxcS0jKCsSyoRhI8rKjITzKawrU8CK/bL8FemLtMtKu2VPPFyt0AdgIEjm?=
 =?iso-8859-1?Q?ZdS72P5nnBj/w+yp7tvCpxCarv1G9fnBii0vp9ewI9oKLfljud0npBJ2tr?=
 =?iso-8859-1?Q?zyngWnBIUocvqEsLtTk+iViy8GoXI8o3o8YVztoX0VNK+fXCMfq9vjKnY3?=
 =?iso-8859-1?Q?CihJeBmFOB6md0Yd0zXwIHG4FjJcGTRcJ1CjZjcClzJ0Cb6SZGeeXs94mW?=
 =?iso-8859-1?Q?VM/HIhu7hegrLOYlEJCvGdRwPnrGxreN2cPbcg7zU9mrbRDCT74MRXfJ0E?=
 =?iso-8859-1?Q?TnuSO1qBvnWMY6iHVEvo4elB2HnembN9zIQt4Vx3vwpMFHR0Q1ubIPmPn0?=
 =?iso-8859-1?Q?p8KKpFe/8lCxjZ2wtQ5D0ybtkdU2Y1idx1Ga8j2TzgmTGNKT935lc1c8fF?=
 =?iso-8859-1?Q?sA5P5SWsHbgUricHDg7H0HSBIuJityxHK6fmn5IgxLlegSYOrkP382Ldhc?=
 =?iso-8859-1?Q?3fzG5yx0EWN1SO/NKWVTQNm9PBzQKFDJx7bozGK9TFBybEERwTPOSCmx1Y?=
 =?iso-8859-1?Q?CPTxUQEifANiIc3CsP8/ancvL5tFl+jd9gigJcnMc1DWTxRJmaSBvqBiVL?=
 =?iso-8859-1?Q?RjTfdFDXMWuiQmbzwbGbtYaeK4piwj2gXUkjea3dO3hZJjnQRm/GgBx9Gw?=
 =?iso-8859-1?Q?FRBwxUMqOcwQcIVmcbzjap1GBMKqJSniQ9NOxdFQoL8+BEKyneDVZ4hRDT?=
 =?iso-8859-1?Q?LRBD1WnD8+2wclkqk44IZbsVzOB3wX0IcUkLA1TLX7ARm3YpY8PasMTym/?=
 =?iso-8859-1?Q?G4YnsHF/v4rYvXLzbppmlwSy9bEOeIpYBSbel2Sl8OCdrO0MDTOTPrPQLC?=
 =?iso-8859-1?Q?BPTWgbmH2aSUhf000HBabt4bCob4E6Lxv2YvdTVlrgjk50eSOjk6m7HSai?=
 =?iso-8859-1?Q?UM0l1+1u+7orQVEWR1SAhkqQA9A0KCYlPAuG77LMl0qBfrakg1Vawfc0Iq?=
 =?iso-8859-1?Q?Gv55tlOK9P3QzZAX+xgy8d8At6ZGlwE3TYdLz4gSNah3HI2BNh3Paw4dJl?=
 =?iso-8859-1?Q?C2DjCr1IxNtNtyEmhU7vzUybjFdJH0tJYzGJSi2IqjM1i7u3mhwGU4L1dr?=
 =?iso-8859-1?Q?DH/Q6c0oCb7BZ1NoUr7J+xWlLL+Cn8p45WhY24dQL1oFxenKGuWJZFOGwe?=
 =?iso-8859-1?Q?uBZB+8k+v8gJqK1k/rZ6Sba47rxYC6gfeF0dcA5jebxIYK5IigK2Uwgbmq?=
 =?iso-8859-1?Q?tSKQ4YhtadIS7l8OY54Tiwue/t9PjYZfKYhLfHV8yg80eD/gn41yrS6ndM?=
 =?iso-8859-1?Q?raooZGb0GsMbSRqTEiycsMleplJ5M0numAE+RI9gPZcENTDwaOJKdeWC32?=
 =?iso-8859-1?Q?5Pn2Z7STCheTEVxzBfGh4RQlP/Hlmp1m/VlIbpxzDwUqJUfgHYWDX8Fk/v?=
 =?iso-8859-1?Q?b1z2LVw/U+Tlvq5rnmhcXy1L4mEi2qc3pjnx88J8y0XVY/laiMZjgL3qfu?=
 =?iso-8859-1?Q?EoRoIlCCcjoQ71JSeH7qsvMpIVLPzwj4IC?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4cab70-5b50-4fea-503b-08ddb3034548
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 09:41:18.9257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eivLbjCunC5f/FYixCoXJDCZ8Nro39nkknNNp29yXxp1kTane5pSWHQLHppG+Qfqw+46fb1exF8HDZWaZ/spIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10672
X-Proofpoint-GUID: Ql1_55cYvl0ISNVNzd6m1fX2-vYoPp8M
X-Proofpoint-ORIG-GUID: Ql1_55cYvl0ISNVNzd6m1fX2-vYoPp8M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA4MiBTYWx0ZWRfX3QPxENeJT7eu
 Vb4Mz4G6h8zVeACTSJiFBE1sboro/BErl0Mj1K64LrUik6KYMEu3lJrXoyF2HcFUBbfncoYJhY+
 AOEt0BCRXfdXDlaCivHhnUEswTytN1uSYKZ3FKCYO1kpOBZU1zgckHuF8CkPe+/8ZPw4kKIEp7D
 w5wyTjHv/Ogx9qj2r9MHXao07+P8g861EuE3dCkYzrIKvUFxUAXVgu29Fc/czfAYUG3ywe+VhiQ
 o1QHvgIR5yG30hNk2+zysPhvJwURvS05YBHtmmKU/81DO1MXmqaEMnlpcsgKm0dhvGfe79jfw4v
 owQXEdKfJKzadz8uuxVzx31aC+WdcR0y5/S564xYWV/j6xo8S+/rQKiBMBgpe8/edAgd2Tx/NKq
 irQM7NopX0T+ehqWCFbyBauCstvM4YzbFg8FeK1d3iBwwrYiA07Lbc6ACEUMQQ6WR6SZYbT2
X-Authority-Analysis: v=2.4 cv=RKezH5i+ c=1 sm=1 tr=0 ts=685a72c1 cx=c_pps
 a=74iFmKrLo1AlckCWLuqWvA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=GiQHtWOYYNwZLoRRrIYA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_03,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Jun 24, 2025 at 11:35:52AM +0200, Cédric Le Goater wrote:

> > These files came from hw/vfio/ and were then modified so would carry the same
> > license. Please let me know what you'd like me to do.
> 
> Ah. Please consider them as new. These are infrastructure files which are
> all similar across the QEMU project.

OK thanks, happy to drop this patch then

regards
john

