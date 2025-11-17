Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202A2CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1bR-0005RY-7L; Mon, 17 Nov 2025 10:57:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vL1bP-0005Qn-3L
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:57:15 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vL1bG-0000eD-MV
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:57:14 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AHA69S2313801; Mon, 17 Nov 2025 07:57:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=b6vuXBj0iftB1FSlsAvcYTTwMB25XsaCAqfvt+3WY
 W0=; b=PP6GtrioBahsW1sud1scw8XTkD4JwE6SMXYasaZx0gAu6J9N0Uusr+AlN
 CuH/0bcm3RyS13UOAZD+wNn9qcypUCQvZJphRk6Rd3RdSUKgPHtQa0UC5xSHLJzl
 BzsSh+k76jFElWlajzxhtiseCFb9Z3P7cowt4Z8t3DyMqj6azLScqjwCLLHn0R0Q
 zFixwKeFzYInPMYWrdc8FjrQuTUT+DBDqK8002XZr9AY8wIb3Aimrq6ZRQdOH3Zy
 MWO2xs4TMPH3liKrhUQXsPMTDkNt0TqpT/OruONHmdxixTjbNshBjD4aw3PnJwDQ
 935Jjk3Z/xEDIPtZ6ZelPxRU3/rCA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021093.outbound.protection.outlook.com
 [40.93.194.93])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4aesx3kfr9-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 17 Nov 2025 07:57:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WANsnNv8Y8HwfSV+jtpnLCWPGjJk2HH1dDOzGz1BdYCV0pvbH9SHmsk7mgKHcTFbP8i49sWKdHQzIywkqLOryxYuo8yf5S2GWotWxuijbjHxDkALF3cBJ80HncHfJf6rX6nuUkEKSSahA2ObFO4nLcm/W+1nYuCEIbUHv7SkHKUiOC+9wNrq7Zkyuk9mGRIb8Zr1ARnQvlTQW7/kFqgIJxJm9gpNTSuiKO8l76rPdH+r7GsFek1eR6x0UIF4ZmIBcMNiWAyh1T8M911ehEhnnRl4hti5ZNoUoijw40DU7BMWmRZqE62+vNcAOIH9XmXpH+hfoqUgeZ9vqbzV36Afzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6vuXBj0iftB1FSlsAvcYTTwMB25XsaCAqfvt+3WYW0=;
 b=jB4xkhTtX+Zs+UMHzaljugfPakc49DtpEIIj/JlfeeFDFR8YWo5ghZMbXiGnn+V8rhnvhQq1nRBiGuREJIh6ddDPW4mqIr54CJrBRoKHYxDR03UyLtWakby2yZuP1bH/egaOzm9FpJH04oHYYXrpY3n3Gkp0OHtj6U+0Fm+fMeRAxDc1BlWp9vcIEyppomFb3wZIGqU+/BhT3S+vGUrE5j92nsWhZohDFbz/Na9siWT5pcXA2fwPrNNIOa8Oc3+CT9bicLNHfkplWtIIePlbWGfD3iiC+cwUR/rt9iEXdthmObkrhPb4NDqlFC72dgB4JxnyfQrB3rUJITrrH4PeUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6vuXBj0iftB1FSlsAvcYTTwMB25XsaCAqfvt+3WYW0=;
 b=hga19c5HHmgiB4DaZZAhJayvsRElpn5k0smfUv9g0IWUsqqCMguqjQ4IqhieWYuzGr1lCxgtlTc+Hr/0iMG2K7cScBJWkgevyu+XaPdx35Rtxrd/WEMInA/RSMzM63K3QWShz6TMK9JQ4LxJujdsql4/ttGfFXBeuJsH17i2qmSMpRylIbYUXyey+8CaPfS4HYScdvtgftq4kd0pL4t5xXrnbabVkjL8g1m+XhNKAfJkKG3hBl0Ja6XYLRF8DgYxULTDOi2rU/36M4C5WS4sdrjGOH/xj4VHK+DXsh3sm6NfsUww9s1wIWjl1Opt+52GWBR50I+DAWcctPqLF2eu9A==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH7PR02MB10025.namprd02.prod.outlook.com (2603:10b6:510:2ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 15:57:01 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 15:57:01 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 1/5] vfio-user: simplify vfio_user_process()
Date: Mon, 17 Nov 2025 21:26:52 +0530
Message-ID: <20251117155656.2060336-2-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117155656.2060336-1-john.levon@nutanix.com>
References: <20251117155656.2060336-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0226.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH7PR02MB10025:EE_
X-MS-Office365-Filtering-Correlation-Id: 616382f7-c1d5-4900-c11a-08de25f1f200
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VdcaqpDMtc0UWDiy4brXPLvM1yTtPd1+qs/iMRj628cTTyCK9QOZ+kqRotxG?=
 =?us-ascii?Q?0DUWbCl4TKY/+LfyfL12I2rthSF+MLcSiUOarUYHXfuh3z0T4UZV5YJCzOj9?=
 =?us-ascii?Q?JoU6oys2PwGZ1jYuGmFnUJALOIMPDSz+uQLOnrrjKsWwX2Gr2STvzsOIblgh?=
 =?us-ascii?Q?bpMHFwZnI83LULv/GYzVn+V24h74oICs72KbnOJ8FQV1td1kMASJP0qDkp+/?=
 =?us-ascii?Q?gotGyja55vMKp8yz0hyT4zdCCg4YmmjwZILl3eZF9JuB5hqZ5odhblHucada?=
 =?us-ascii?Q?+WuoZpkdiZHVXx1UZjxwrpG0RQC5j0OmoZt69OsPl9vlAmYkc2496250KBoj?=
 =?us-ascii?Q?W0zAII9mVLYjG/BNgbTlyysBX7mzLX+BEuriOp0QFyMWc1tSKnrPM03iTt1u?=
 =?us-ascii?Q?xr5JCjS3XqPBbRptYPao5xhzRiYoXSWui3UGfuvp6UW06p1/F/sLwaJYQmka?=
 =?us-ascii?Q?PqOt5AK5+lCcQorLiKDftp4nY7jgQjcFBnMSjLIG9NihWyJS65jGA2bi2nWZ?=
 =?us-ascii?Q?eOPRpKTOAa9THhc+JrY/jJ9wfEMFag/j6BziWp/txzplUHNOJS/WTvaEmMWA?=
 =?us-ascii?Q?zU/+UnFe02SE+22krIeQiVrLShzpBzn6iGSxTvY0V0Y2VnImTnP3tJo4t/qF?=
 =?us-ascii?Q?NGBZZjPtWvmcbcE7+YbCbqlN48xjXa2tzPmD0fgjGaGepYenRvjqw0W5Pxci?=
 =?us-ascii?Q?RNvP2mqShmWLMlEirsOnlOSii2Xarj6y4p5yF5AS4vOi7XPmeShnQxG9jsfb?=
 =?us-ascii?Q?shZDDvgAph8PbRrU94q7KZE4jvpoc4hl97zo+NWJbNkl2jMdKKH5p0VZqYvm?=
 =?us-ascii?Q?mtvpvYqdU4BeMzF5wiEa8Qf0Zf8zvh/MtOSVoTlMnHjfBDMOp20F3QpEBNYq?=
 =?us-ascii?Q?4O/rP0/UgblARvc3AK1nKmk9n6eHIGiTu0f8/oNNyOJ5dGDCYCArbyKtduYo?=
 =?us-ascii?Q?lxLQRqhCulPhvyuOEHNA/bM3WErbJkP0SxI8D+zKGNhU6AyQ4PQKXEOigGsw?=
 =?us-ascii?Q?0JXoMg/f0VorZZO9TE4aApKhQiVthk+VVcQEuUTipXNRb0E9MT4zra8JGoFn?=
 =?us-ascii?Q?BO7vrbb44p2kveMDbVQajWVz9Ic1icoBd4hAPXPaqWTXKiGu+3ZvxKAx9iF6?=
 =?us-ascii?Q?IyUVzq5kULp2Sy7R8u1k0pTbeE27kwpGNPjvJojoV8iE7YRVNF93PHCQPUcP?=
 =?us-ascii?Q?tsJttw/9J0a4ABKyO55wju+ZulsrNUJkXXRzp7YZ0szbSSiwBOdtxD+fbp3b?=
 =?us-ascii?Q?kV9bQ1mdCnPRzQ+AKgjdjZmX3xN8/FKX1qG8Wz3AbxJV9vrYR782R9rGvLo+?=
 =?us-ascii?Q?QEJrKFZaptt4oZO0H0oLNY24+zelEO2SBWX2nlc+8Rm0+VBao+gt6QyfljAj?=
 =?us-ascii?Q?WrKoe4dXGYSeHchjqQIIz5fIJi+gnPd+wHujvxSmhe9CdwhdKRkVD2kASU9p?=
 =?us-ascii?Q?nSvnYnyfgHmmrJIU6aFrwy0DSiyzv7Cv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?crcWfw2Nz7V1vfiaL/gL7HwK6UgWNieXz1yhaeUzg98O6L7pVEDBF7SmqPq4?=
 =?us-ascii?Q?dFiaM5lOFdmFFzif1lf9+c9hxe5PzXLhu4WHjiAHcFAcRFJXazTrZYrO1fJ9?=
 =?us-ascii?Q?9jp+bSd4NhwVYCBneaL98tjzvs3Nxkjb4+VAVhd5W3bFJDv0D2gqCEFd1cNc?=
 =?us-ascii?Q?YSC90FqzLoKgOIslvgb9EtgIaisldQex3YG9YrKAbrSWuw1MysymCjfHoRrv?=
 =?us-ascii?Q?U/qXGyPgJyHchSc0H6IwrMJx8L+3IYVYB3Ln+G7tnrs2vorOo5T+9M4n3Q/9?=
 =?us-ascii?Q?yhFIwa+ptJ8oBUS1Av8Iu/RzRbjoMMGnrrwKAX48KMHEnFpPerVNwX2w8+yI?=
 =?us-ascii?Q?qwRQk3+WlNULF7SfWSLd9oMS9T08sQCbDQQQ1mVe0S7eEQLzvMmxtdwrgt/r?=
 =?us-ascii?Q?ilyShHvMx+vaFaJFFMgU/r4HPLs4YXsimhAobJaHtBSIHwRHgTIQ81Rtp2Qy?=
 =?us-ascii?Q?ofRRMpw56f89thKyyloOy1WW8Q4Cc3AAz76o3PTka98whEiUe0/0slQ8bF5i?=
 =?us-ascii?Q?rAyeV3GcSGSJfLtbpjUD8maOEPQlSKzxirMgPkwCM1BF1Nt2L1b/CvKtGiPZ?=
 =?us-ascii?Q?h8vGNyTzn9iLawIZXoTR+Heomfe1R639gL80fC2v0olosy9K98pDl7rygWoY?=
 =?us-ascii?Q?/4ej/vBOFmK5bb47b3W9kzdZK72mwlHIrjJQsUFDJDiDHR2Si/Tb6HeEjTAH?=
 =?us-ascii?Q?723oDbrOKM3T0hzyWJDrGf8r59tl7Yk9j/yapG3IEj86sJfQrsp/zrLDrb3w?=
 =?us-ascii?Q?7tBB3kzkpxE/XhIwXl37wZIz1MzG5f7jwYCUg3rNx2Hbso6G9kC9Fo9J3vaj?=
 =?us-ascii?Q?oXAkyaxBn38boz5NDz1ffhKB16SRK3mY0ZhmW62OpaE/p0fLfmLE7l3hZVee?=
 =?us-ascii?Q?qu2/GzYSLN8qA1CaaFZE1a1sR/LhVF8HmEzrAmQGQhllst/w7O8WnZQLR+cA?=
 =?us-ascii?Q?Zqy0kQCLzg1qfjg0HtBnSghdwDL6yfqbQwQ8HRjt6ZxnP6iQFORzbjMMQPKY?=
 =?us-ascii?Q?rjihyOQXcetA519vrH4sqZTsKLrxS3wX1pHR8Nm3XfSPqrznh4WUZ26Wx0vJ?=
 =?us-ascii?Q?f2+GNU+ZokLYq5RDYQEaMgH08ZNpACG8N8DIm6uOtrdwBa17QEmF4XAfRE7y?=
 =?us-ascii?Q?NPLK/PF+cduAuKulpnWC7gjr+eLhuS5ammkTTjl/+BUD3uSWfJ+shZJDw1LQ?=
 =?us-ascii?Q?CJ7Z9Ko0mJeEd1jim8rXogk7PfNeDPRUKi9nsRWmIJQYlCOyexMNc+34UGol?=
 =?us-ascii?Q?FgXFnxuapq0bYLb6/v7Ata4/t1Abp/Q5te00L5ShwdRB1Wjg9t43o+4LWyhn?=
 =?us-ascii?Q?c7AqXIlQoWFNi5dPRbYXgwU+IMnChYI4cvWBq5jL97c+0owFXSZx1iG263y9?=
 =?us-ascii?Q?lMuol4/z+DK4LgBfPM3xOIoc4Dsvx/Vgm+2LyY2H/GZh3nmX5khJV9UTNqru?=
 =?us-ascii?Q?W6vIX33AECvQoHqLBgBAhjfDd9CNKLCS3v+G7J8snTkGhqzru51Cx+ub32gO?=
 =?us-ascii?Q?JSbJU1MYx8eFfmUzOQlcFB4I1346SgcZ/En7t43ofvXMy1FlDknU1eitZn9s?=
 =?us-ascii?Q?dFee93L47kFAY10/i3ZVvyIV2Yos8RR/eN5SIDEZ?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 616382f7-c1d5-4900-c11a-08de25f1f200
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 15:57:01.2083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrYsolbKKTBH+XRzgtd7izzSosmCt6WWjGgzHb2sR9rnJSylU0UhrE85qIve/0DwA0LbMxNMZk0ujAlgQ5LUgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10025
X-Proofpoint-GUID: mFQOouWN0hdcJXCloL_46jKuefWnAC6f
X-Proofpoint-ORIG-GUID: mFQOouWN0hdcJXCloL_46jKuefWnAC6f
X-Authority-Analysis: v=2.4 cv=VKTQXtPX c=1 sm=1 tr=0 ts=691b45cf cx=c_pps
 a=G8VycjxW3wO8/D/xgNJDKg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=v8IRLEuh6JSOYo15BCQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDEzNSBTYWx0ZWRfXySMHTCfQ268d
 xXzxD2OXdHVno/cBUVEBjM2souL/oK2+c40wwdGTVUIqUzNaAoD7ZUD461a3aVusELXsoPzrzKS
 AkZXccnWf7YtmLKK6FQYFQiiC94McDv3bKWpzrTObA9vrG9Ss9vN6vBzLLMf8e/X8cttXJKh5pS
 2zIgqGTgvUbHXkKJzY99mI9KWAmteNgEoWAynuH75osoeixT5+nHTRGRz+AZtWu+WjtRYB4SEE3
 tjlAyDX8uhKNHSQcRFfD1eMRnpNSIi/o3eCSnjtn4bflps3RIShyUFcRqEGtn+p02mbmkQv7fGo
 1mCQQx05G4l9FUCBzkaAlEnzxYG8SwzmyVERKvmgB6hw7T/+DPy+1w2KSMfisM9urJzNYaGcS81
 H9yyvAJqiMolmVQDhUKQOcG3epw+xA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
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

It can figure out if it's a reply by itself, rather than passing that
information in.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index bbd7ec243d..75845d7c89 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -147,8 +147,7 @@ VFIOUserFDs *vfio_user_getfds(int numfds)
 /*
  * Process a received message.
  */
-static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg,
-                              bool isreply)
+static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg)
 {
 
     /*
@@ -157,7 +156,7 @@ static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg,
      *
      * Requests get queued for the BH.
      */
-    if (isreply) {
+    if ((msg->hdr->flags & VFIO_USER_TYPE) == VFIO_USER_REPLY) {
         msg->complete = true;
         if (msg->type == VFIO_MSG_WAIT) {
             qemu_cond_signal(&msg->cv);
@@ -187,7 +186,6 @@ static int vfio_user_complete(VFIOUserProxy *proxy, Error **errp)
 {
     VFIOUserMsg *msg = proxy->part_recv;
     size_t msgleft = proxy->recv_left;
-    bool isreply;
     char *data;
     int ret;
 
@@ -214,8 +212,7 @@ static int vfio_user_complete(VFIOUserProxy *proxy, Error **errp)
      */
     proxy->part_recv = NULL;
     proxy->recv_left = 0;
-    isreply = (msg->hdr->flags & VFIO_USER_TYPE) == VFIO_USER_REPLY;
-    vfio_user_process(proxy, msg, isreply);
+    vfio_user_process(proxy, msg);
 
     /* return positive value */
     return 1;
@@ -381,7 +378,7 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
         data += ret;
     }
 
-    vfio_user_process(proxy, msg, isreply);
+    vfio_user_process(proxy, msg);
     return 0;
 
     /*
-- 
2.43.0


