Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB0EC54754
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFan2-0000Ff-CI; Thu, 15 May 2025 11:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFam6-0007Gq-JS
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:35 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalz-0006Rm-8n
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:34 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F7nlpu026476;
 Thu, 15 May 2025 08:45:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=bdEMl2PV2mxwHWts3yLqrjYyqtaVK1ua+Crr5QMLZ
 ok=; b=0gqG6ykCo3DVV1W4hOS4yxr7Fg8T+39J28LjoXHF45Oj90xNNUka3xbgG
 N8gt7CdPaqSanQhYcAccsJHF/8oAKGdhYnJDNoJiOy1FAIlFXnt+Oyud0nUAepgI
 Q474HBHvHfs1o04Nt1ODsZZY3mcClnP4mLj6nqwnREWCQXRDHxOx8Yq/svAN+Rdv
 rCEmvXns1c+m6XrPN7t1LmamC379biB2Lp4b7A6/vgo8hfhURQxVKxW8WkGDyDT9
 4Ke+InxmvwgFsTclaH/KneuhVKZuhkhytAoX1yp+rlv87Y7oNIbPJULpjdKspxka
 ML4kyqgIsd+yqElImnekCxseiLpiQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazlp17010007.outbound.protection.outlook.com [40.93.11.7])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46mjmtvrfa-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:45:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XtjAn4hE/poY36he01sHsYq3HXDdEUzOdIY2dqp8dSGMf2Tdy0Avp0etcz5XYj+hQp8yyKK3shu+vgnNJ9kFLC+UWr2Xm1au23SE3aRfIUHT3JXBYEQU5ktLnJuTo0cFcX3aitQYNZr1Ak/qJs0fCO1a7HOt3vmV6FgfQclK/q8FlgBiPH0SKacZeWy5+uinjEVq8XoithxPpwXVPv7D120NcYHJ5YkfBsCzCoxeHRxCj9Z/tdAWF0hee0FNVVho4nvO++Io/R9MdAhLpqOwXgDCX6yPnD798kVm+455OqF3x1Vau+umvcx7iRxzbqP89wD6AlU8N4ordx/G4L+EDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdEMl2PV2mxwHWts3yLqrjYyqtaVK1ua+Crr5QMLZok=;
 b=KOF6iOwq/tsqBuqkNS90Sa/cXcMC9U7d3F2KNySAQjSyIGm60k8gtByT1BguInC5P5HH6VLa3tiM3xHILEf4Kzhaa1p1rwSwdnlw5MKINFbysGPgoRnjKt6Y40t+xKsTGzjEJDijbP7XvOneVkPHVk6TOA3DT0ScIxrqLgskXKIlAKGNYOZ9CT7yv6bvr0ZKOtGQjeoTx0a8eKqTKnDIsmNYEqpFlxdzQr896TA8yQEzy2mq1K9x5Rg5DUPAJz+8jEDflu81BuHyDsKcojnqvz22h63IbwCEIxLQZ00J81sx5+sMvrK40+049yPzt34LWJRTHhOXBl9e1ju9wLf5Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdEMl2PV2mxwHWts3yLqrjYyqtaVK1ua+Crr5QMLZok=;
 b=yemxW87Gp6zlBwuaTNJkmGmVBL6vaeYZgFADDk3HfR9DnFpabWf7pIGw60F+iYTVO6ZCo9f8w1ra6dzoYtk2xCjsNLsqA+XGm/JdyPdKHSohIgmpgD0j0nryA7r0na39RrxarMMCMMgG39P2nOTTltwdGkq9XEhBaQzvCZ/ujCk3LWgFhUtbN79Fra8Yt0IFHstWp7bmmyhUbn13m7Bi8UW0QcGwEhPYpTQYJS5IDp9XBB+MAqbtm7uOlkTkoF9jS8MIg8m7A5t5qETFqoSt129ciwMkC19Ur4pb0cduFAFMRiW8b3/e93Ogcn/ygIkIbXgVxy40EivELrg364rxww==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8470.namprd02.prod.outlook.com (2603:10b6:510:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.17; Thu, 15 May
 2025 15:45:13 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:45:12 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH 21/27] vfio-user: implement VFIO_USER_DEVICE_RESET
Date: Thu, 15 May 2025 16:44:06 +0100
Message-ID: <20250515154413.210315-22-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515154413.210315-1-john.levon@nutanix.com>
References: <20250515154413.210315-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 25a7c810-dabd-42b3-1ee2-08dd93c77a96
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GAUi6h1r+naPujyTkiKvDkRdm62v1ERfTD/zd/SkqNPjkyxZCOJKe7JsFFbI?=
 =?us-ascii?Q?b+WbE7QiNIuhSdcCURD0NjUoC/1X/WYBfy4cyRdz/k08NGxB7TTVwgxA61d1?=
 =?us-ascii?Q?rfWvio7IQbS3XD2X4NsgTkn3LMUv864Igr21J3GV2B09GWPBRz1FfvtYGgIr?=
 =?us-ascii?Q?me1g6SsllH1QGGGcqJT3++vim4bPUWz+5/Gjh/UpVxIWdQk47geMVoOvxOmj?=
 =?us-ascii?Q?ISH3wCV8zmvm0LRvYZASVo7PE6ztbySObTjFcuH91LlqWOmtlvzMRmGyPhyo?=
 =?us-ascii?Q?3G03Q/h8Ln+Ny1qAAzz73pk/ikCHS0KwR3uoxtPYsZK7yl/Z8D1XyPsQQXWk?=
 =?us-ascii?Q?sWgYY63Ylw7IEG8ph770fuAVdw45RLtEgmszTcZAZiSCMVOwOysNjbALorle?=
 =?us-ascii?Q?wC+PaePwm4I23K4iVQwhH28Her7ihfkgaUBMCMDXLL/yqHZjLadscq1N93AV?=
 =?us-ascii?Q?SHlxVndx/bPsEn1sfsKtpEU59fYGyABWdKWUkbm4Zhvw3l/1WGp1bSj65/M1?=
 =?us-ascii?Q?fG2nF5G8nKpUZwKDg7SkyTZVgBL1aD75RG0GxBHS2X4PJB1L7q+tIuBRHLp2?=
 =?us-ascii?Q?8h8vTBkZ7k3ZPp3v8q4R4jwT8iFLcHZ1j408iEZtgEGMpio1d7ifNwhXruar?=
 =?us-ascii?Q?IVBvkG9Np6XAMA6FmnkpCQa+13/7L18tT2mFUABswpCYGm9qi0Wz2tXsqvBY?=
 =?us-ascii?Q?nQh04zdV55gBWqG6Gp+tEtJqPbZE3zG39FWerqmQPSrlxM+iKg820NsuItsq?=
 =?us-ascii?Q?KkkNjvzv8v185avmGU2zrEtTJlJqPNwykb227N8lxcf+yl08kvXfHfhrnJDm?=
 =?us-ascii?Q?ljlSDL/8vwVLEDWtfz/7SmI6B9qUA84PYMAZeL0oNahhslxWCWQBhOFk4K7p?=
 =?us-ascii?Q?u1i/BOYZSjXb6LNkK0fqQHCrYg/pksfxr12SM14TPfhugMNd7fvX5Pme6jaY?=
 =?us-ascii?Q?iyt+2TcUZ8w1lrKUPcPHN7fyrxmp5jhnZrK3/XkwD4muNurFvP886hm0h9R3?=
 =?us-ascii?Q?h6TVVREdhqYOO0H+GrKQ0cXDq5OjXhjdq7XuqHDZuw2MRJdpEG9AnkBt4f9w?=
 =?us-ascii?Q?dDqvupncBCxMGwe9YxK8p8xVEdfW5K1dOEgIMBqYU28WfKcG7sBW5QQ/Au9z?=
 =?us-ascii?Q?pW/nHI3murKbmrep+icm2tSwtQQW7Xen6ZosIfNYIMVXJJj1nUrA54XqbpM2?=
 =?us-ascii?Q?8Sv8GOk66NJtA4tDhJ1bIsR9waJfpCwhQrIOW6NxucFa3s/lOqjXwjESD+Sm?=
 =?us-ascii?Q?jKVbIRVE8A0rYPbJGRcInUE3nvz7zwA5j6iTjG5n3k3hG+jhyzbofDSd6urP?=
 =?us-ascii?Q?WfcoRQDh8KVltegI63umB6Z7NxGqdVNIlRJhTZ60vIv5HGXdS+YdWNmVL+NS?=
 =?us-ascii?Q?GIIziTrh72xbkUdpSBue12wUdIU8iMW30TKz2+3kK2XPMFL6F0A86hoJnEG1?=
 =?us-ascii?Q?5CDHivzcfzw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u+Yqt0XqbDT9k7HEBkVG45Pc09egz/qa0UYOixJq8NawiO2znYWl4oAnf35p?=
 =?us-ascii?Q?U/oaCOs99hCCf2gFi0rFWavXN7hYrDwMTFsgXQwi1iPCDL33x7rvkWsZFelq?=
 =?us-ascii?Q?Wr67ehrBH+0iQqsACMkiqurhWkj3fdcW3vP9tOmqpSlMZKcXn2qGHM6dkcV0?=
 =?us-ascii?Q?1p4TgX5GH6MQxnIkP8KR0skuWokf3oH2cYifCoavkqK1DLd8MO0p+eV06CTW?=
 =?us-ascii?Q?UXQwii4HxMGh3+n82H2W4yHxpA0x2u5aFrNi9LSarMu/aIwLgEqlqrTdyNtt?=
 =?us-ascii?Q?Cy3bXZqDeA6ubmU3V8GDEqTnM20tgk3oB21FI620gcHqLSXL1vpHg8SQdfIj?=
 =?us-ascii?Q?RUKtSbDIOJkzrIDyKSBAFVXBQ018Tk9u6yMPikIVpB5dE0xm668TlhDuIJb3?=
 =?us-ascii?Q?IBckropVWsoSe2KI2Eazny8kU3h9a8AeUM9ia5eMhjrSnmqeNZh+Z5Qe4Enf?=
 =?us-ascii?Q?3NX0dVrq+8d6h/uEz4wl3QJJuSZiPlL2YSN7P1Usz5EJKaHQMV3OVEL5xUL+?=
 =?us-ascii?Q?nG2rqjSjpD1QVKJAs6DzqaUzRLXz27nMf58jsWlltMtGvz+xJz+Ejvy0lnxW?=
 =?us-ascii?Q?pK0SbuXWz4cFShRPcARL8QUWzxKl7p4qYn0Dxywo7PSjjPk395gX9SbAhKxe?=
 =?us-ascii?Q?XNGfJ+mxNRsR3x+7h2y7Q4d3McD6WhhZfkT6JYtWu2CIEKhgRLrC203EQESQ?=
 =?us-ascii?Q?86eBtdymCEkQrFSGYAGhZAseAIFyTVGxnKWyPSpLJ2tLlFBwdheKuLqpkWku?=
 =?us-ascii?Q?a1SjYD5RXwFPhI0DM+uu0tkzTdaSOgNiDi+HqsDbLuO9xjR+ZVUlklhoeWNz?=
 =?us-ascii?Q?AYzQRilExnVr1opB53T9oDqy1jZlZMkPycT8NJ04EWnKXNxSSrEg+HhuYtJq?=
 =?us-ascii?Q?ju6RQnZvJRyfPQ4i+LF2D25ol+SXdUqxTImDhu5BRZMVljlc6MOrZ4Chf4vX?=
 =?us-ascii?Q?zd6I3zNY/2JEUo/QN77mynfzAui5KOIi5V0dOY3aNw2jsCpSSTFsuMDtDTYI?=
 =?us-ascii?Q?hhG/bPt4v62ffLqX7PN8UH+OU4PWKHmEZPxJq3beH/I9/DWg7lJYMAjBF2BP?=
 =?us-ascii?Q?DouTKyXiUzvbNrkZ2DBTWYnwxxXTe1kJ4LVyQ0DNB/FHEBfy2LDh7O+uGdo2?=
 =?us-ascii?Q?D0KcvNlEMtz7sF3bTA0YPdaKhrFZ3acmyxuO7ZLqowvoNzpsJ6cAd5QL9vRg?=
 =?us-ascii?Q?UrJTJOePvT5Af7wYVC8rpR2ZO6sKaOdvxDsuuPBKqabvFMa7s3IUkjS3wk5a?=
 =?us-ascii?Q?QUVNYn9thxk6K18cs45e29Hu23XkHCZ5XDVepRoBuNNV/2Jf9q4CceWZQOM1?=
 =?us-ascii?Q?cV0m+V2dsB/k3Lnh0oUq1QSJv8Up/e+RZ92r7ilY8tK6Ytb4vRpnyRTRrDB5?=
 =?us-ascii?Q?w4QcsRmUvD6yCoXUH6txT+NQfpm+gQTjVQUb7nbqlv0i9Tg9vMTMSRrSN4pY?=
 =?us-ascii?Q?A76khVsM5TQNdS6R8s9BofRyf3vxVupsBD7wCqUvYLPdlb+fl8FhxX1ucKPX?=
 =?us-ascii?Q?hlnijXZqiVHcqjjwG5rrqYVSwzXimZ8DIC4m3KkHbPKLcPxyZg9xlO3CPgPF?=
 =?us-ascii?Q?3jj4IhMb22qMgSVlK3kt3scoi0pzhmd0LLKNrEIp?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a7c810-dabd-42b3-1ee2-08dd93c77a96
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:45:12.2233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUsMWRnHsws1eldnY9ZnKS8gZTDkldH924Sf+AplByzCfnf50rbxUe/hkxUaqh8btYXPl5w1CXGOvI/9astpHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8470
X-Authority-Analysis: v=2.4 cv=TauWtQQh c=1 sm=1 tr=0 ts=68260c0b cx=c_pps
 a=kylQlKNaLH8A8Uw3zR316Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=70NfNXkHNs9el5T2m-kA:9
X-Proofpoint-ORIG-GUID: CgWOhvZY_RSK4jBWbRXpWa5xkj7qeMFB
X-Proofpoint-GUID: CgWOhvZY_RSK4jBWbRXpWa5xkj7qeMFB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfXzkhEiXchOw/2
 adDmJPLtJS1mvMZGySJhyiTysBCL7qrAuS5Bh9HZnxD87DogJTL4yhBc5NPqVh/lxK3sFmtQLfv
 ANFN3u0caXcs50xPhNJLOJ/MHRv7nZ5wHWN3wW734EtBRhaHMyRBekczviV+oR5ouAMqzvAS5wL
 eNJtvB7dAxmfiMFqqmvxq6AMyxw4VcIWCAzdylzLgRGxtYkO1QG8URZtdmtbNpfOZi2rDgv7pjs
 K7/5KnWY3WW6Sfh+CNMleOCi+GyGwzgbPCamB1Krh8EXwdRgh/8vm+Y3bIGwKOjdFyO6z09u5Qf
 ygG/dd+z5iihOAUu4uu6AMF6yv6LNrXznN+UULXI6j06WcmA15suOcHKKLSTLvxOwD7l+qct244
 k+vwsgZqGsR1zfVgH8nTeg0N8k3nDH2vyc1n23PlAA9J8Kt3IhTQkzp9ZzGxgdCnSaoOGgU7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

Hook this call up to the legacy reset handler for vfio-user-pci.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/device.h |  2 ++
 hw/vfio-user/device.c | 12 ++++++++++++
 hw/vfio-user/pci.c    | 15 +++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/hw/vfio-user/device.h b/hw/vfio-user/device.h
index a5a2aa9ba6..25cd4c8a00 100644
--- a/hw/vfio-user/device.h
+++ b/hw/vfio-user/device.h
@@ -20,6 +20,8 @@
 int vfio_user_get_device_info(VFIOUserProxy *proxy,
                               struct vfio_device_info *info);
 
+void vfio_user_device_reset(VFIOUserProxy *proxy);
+
 extern VFIODeviceIOOps vfio_user_device_io_ops_sock;
 
 #endif /* VFIO_USER_DEVICE_H */
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 45b91d22f0..b37f7329a1 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -49,6 +49,18 @@ int vfio_user_get_device_info(VFIOUserProxy *proxy,
     return 0;
 }
 
+void vfio_user_device_reset(VFIOUserProxy *proxy)
+{
+    VFIOUserHdr msg;
+
+    vfio_user_request_msg(&msg, VFIO_USER_DEVICE_RESET, sizeof(msg), 0);
+
+    vfio_user_send_wait(proxy, &msg, NULL, 0);
+    if (msg.flags & VFIO_USER_ERROR) {
+        error_printf("reset reply error %d\n", msg.error_reply);
+    }
+}
+
 static int vfio_user_get_region_info(VFIOUserProxy *proxy,
                                      struct vfio_region_info *info,
                                      VFIOUserFDs *fds)
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index a6921a8f2e..55cc811d3c 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -251,6 +251,20 @@ static void vfio_user_instance_finalize(Object *obj)
     }
 }
 
+static void vfio_user_pci_reset(DeviceState *dev)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+
+    vfio_pci_pre_reset(vdev);
+
+    if (vbasedev->reset_works) {
+        vfio_user_device_reset(vbasedev->proxy);
+    }
+
+    vfio_pci_post_reset(vdev);
+}
+
 static const Property vfio_user_pci_dev_properties[] = {
     DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice,
                        vendor_id, PCI_ANY_ID),
@@ -269,6 +283,7 @@ static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
 
+    device_class_set_legacy_reset(dc, vfio_user_pci_reset);
     device_class_set_props(dc, vfio_user_pci_dev_properties);
     dc->desc = "VFIO over socket PCI device assignment";
     pdc->realize = vfio_user_pci_realize;
-- 
2.43.0


