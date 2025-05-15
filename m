Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29ADC54756
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFanY-0002AI-LY; Thu, 15 May 2025 11:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFamH-00089s-VI
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:46 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFamF-0006W7-3C
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:45 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FBNZKX014714;
 Thu, 15 May 2025 08:45:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=mNWFporxuSTDjSLYQBOHMt7nZPKS0zVOBkEl7cC86
 4s=; b=zbuIi6c9W4dYlQVhVhqrpLnCqzKyytCMm9rs8p8oWKxYXfEElSaCCaNUv
 dPo1yGdkFUt8eJxthrof1SS0Pb9Y3shx3oQvXBFlMmgNEmpE5Um8G2C3ZUAWcdvo
 BxOrzInEq6iB66Hgxvk/2lYqCOqm+C2Rd7DIbSTN5h4ZftzIX9LDH/bN0A0nQKhp
 UUVuq6ycR+29aUMCUj3YatxnDhmcrv9IY3xw53PmfJsaI7rSEzvL+BtUWCJV1vib
 tvSH4KvxvKs6IFID65m1dJj/9zOk0sNbAteFhZrM2fPVOOnX7OlXTsiBax64HRzX
 mifz/uqcxoy3a5aaMDE1+Kttjgm1w==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17010022.outbound.protection.outlook.com [40.93.12.22])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46mbd0we36-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:45:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ioaxLvfhc7vk4TwNGe0ZCTsvvjI1XzNQdQtDOGsyoYdaMFISLKzZveJR9QWmCdjBwmiFIC9yp9VqQRybSuKD78yx4LP9tlLmR9Jl/5bslyJSnfd8E1iqmxg3Hyfb0baxzYaaU4BPzsqPbg63XkmPRmkmOofbw4qef64x5k3VYJYrGgol7c1qnm4JbqjUymriIDlgMWjvZ5fsu2wa6MrGUi2StHYZwth0HKPQSzfh99xIXFvVn3LUck7RUItpD2Jk8/s7velK6YdnzUJ05A3Gyjmpk/Z8lN93iqMbhE9WhuuypNrqfYaQ13cJT1BvfhPMaKgHKZDs97ytUGSFDlU0Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNWFporxuSTDjSLYQBOHMt7nZPKS0zVOBkEl7cC864s=;
 b=qQNvA6Z99G41JbGs4pVN6jmQs9/v6DYWJXck21ts71xEfLOZEy1Wr6AeL/sQsTPYzmWGKypg+1AFEOY6q3pWNZ9N4MOQQMgawdDrLDA+uzjS+REAJD3rtZANPQe1b22+O8mIH9MjjNgsJaIvWCvQpPWNCRhuY8Pi/mrim5OaPtK0TeBUGxXdk0awiNML8yRwEg40oOVAzXOVZgzSVOXvytmKH/ip7mTV7DOt80HvHO/BMWGTUaAa9XTkWjgUiwxVkJLY/jwXow0+pb9IxO4bCPqPpK6Ytq5KL9iW/BSCPTEY6s9KnsaVHa9cM5QkWymUpyJfBFW1BBMUnHP+6tJMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNWFporxuSTDjSLYQBOHMt7nZPKS0zVOBkEl7cC864s=;
 b=w5z+cgC0AXAwu3zGF2dXPiRsV1cg5qxjGGtTUgLvTfDX5R2N9FASvCo8yzhVgOF1EClezngnuj6L/jXg3Szb3Q/XK2w5pzeVX/ZTKio2I3PRi9NSBfFH7eCP8jqZM6TR4W3Dhiu/op8OY+LnRXgDZ5BBh0gwsoBqpW3HLN0swTOInAg/SBbGtYLLoOH6o7PhNSYRWUTbufDQVFIvJjA0c3kFKIKiTBo9V6zwhRD2/akQreIeFGmVOaLnVlQqLJr42HDnNN1jU/pnCAL5GZCE9RjFAY9QZsj+CXgViZ22CHhfdn1DnEuwGhlFUnADR9QTZE+pHpgbBKatQQ5H+6lGIA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8470.namprd02.prod.outlook.com (2603:10b6:510:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.17; Thu, 15 May
 2025 15:45:23 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:45:22 +0000
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
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 25/27] vfio-user: support posted writes
Date: Thu, 15 May 2025 16:44:10 +0100
Message-ID: <20250515154413.210315-26-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: d6e47425-a891-4598-0244-08dd93c78084
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n+fcUaUZibvew84PivkKYSSgAtulnFjtJGkJJwrbAfY+PPY4rKVO4pB1vtuk?=
 =?us-ascii?Q?6hK8sIBD02tWidKiAalJ5Si8GuFznIeCoGNFryn2XdX/S73s4XFsNUf6BHLh?=
 =?us-ascii?Q?irZy/CYaj20WOJWksA0gtNZW1FK8/Abgufa2SDV8GhXeI6qbBL7hRNahpXEo?=
 =?us-ascii?Q?P4OHi+kfSFeWII8OuZJqGSRnUoqaRqh8P5iTheO268yzz2Rm6MEBXpY4NHUi?=
 =?us-ascii?Q?2jaSp2rasEtFB2BKSYK4QDbA58NFMDV6EWficVdurLrMzWHLIawbrwxUpiIj?=
 =?us-ascii?Q?Cy6OJ9Y+JhB1vvrR6/GeFi6NbwSdydPc6qtyOEoOB9MItz0vplgZjxDeQnvT?=
 =?us-ascii?Q?xS0Y2vZAYCiSyFRZBqF6E0CVn+U1ji6Xs9lKcIMgDQSqyYg/n8EEaeBBQeTA?=
 =?us-ascii?Q?oUKZZ2jhHsIX5hqAtwmfb2rgcpYqtqL3A0Bf11gcPDnr1vDJpwvSpIVcapRG?=
 =?us-ascii?Q?ZiHvFoakoT7CEoAIOG1tZVTpt6oKrEhRxt+jxiVu1X465ZHbsc+IZEX2zQPA?=
 =?us-ascii?Q?DMCO4Zr7dwKc8bYU+Rgc/3v3NlfUJPJCEIqlwazAWMhDNxH8pP1g2fzEM1KK?=
 =?us-ascii?Q?aR2gk0Q6/SsoDlYMPKKEpeMY+nkblJf+46pWulkazU2UrLV+HeBA4p5c6G8Z?=
 =?us-ascii?Q?zPXuH9pxC+guUUIpFBUDTWgdxkhTnSKlak8vHyBH0TuNuJctnI4O7HtsbBYY?=
 =?us-ascii?Q?wlvlwkLO28QAtqwoNTQDjiRFvFpyiA+iBYQ47sLIJVD+A7mTSXzFMQIXUTBc?=
 =?us-ascii?Q?x4CdzZR5W03iVKEugWeEjoyaJ4kYeekKHMXA2FhsygRgxFTHL9hPndEG31hM?=
 =?us-ascii?Q?df4ZZNAr8H14VnqfeVqL/8cCxkOSWL8pElWo8E+fxvHq0u2mecgA8+9MXgXW?=
 =?us-ascii?Q?zJIC4bTimx+1nrn17j0V2qbDqAQgfOaM3DDgrC0LbS7lbCdtjGSKyBVLQ49a?=
 =?us-ascii?Q?ESMrrR+6Q2dRw0hhecRjva/A2V1pjj0MQICzqSqUVTDMuJgcinYeVaFuDyFr?=
 =?us-ascii?Q?2FQdabFNXkytDrFrYMmu5YJheSuUvkvUG6OUCZU0kmT0eloNjlcmnGL6jRNa?=
 =?us-ascii?Q?F0tCWpBECjnY3Ak8Hp34tJRa/yM8E0TNJJX3gJRykzZlMzmyRIMm9/wR4p9d?=
 =?us-ascii?Q?pREvs1TWv8bpxM0OQYZG/0HaVLoAG7dj73xuzdJbQWB4AlGiUoUDFZxDo1fy?=
 =?us-ascii?Q?GUWPMM04rG9i45dFnuncE0Mi43nR79Pov9AJS1Pb7yY20wukxdCwnThimGuQ?=
 =?us-ascii?Q?kSFmMdwBvwcvZVhTys8p2JxbNl6SUuG34Ha5yhr3hLtyYmK0z7Yca7p9LyDZ?=
 =?us-ascii?Q?fM0m0QZ2Mersbc1V9caqala7VM3ObMEmrVLv4uNbuYDgVX2kDBNQ0f0S7M3E?=
 =?us-ascii?Q?TxXlqe58HN6S+SVIxBqDxiIok0f+u/TOVD9SHmzTmSa9bKlcdUqqvo9tWXnp?=
 =?us-ascii?Q?xwzGQabzkbU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r94JeAlVlvih0kRKv/dLTDA/hllpghUbf0JO/1qgo2PIlTkbTAlSiPHiHr3P?=
 =?us-ascii?Q?dP64L7adJCM6HgyTX3HsOxwEJKfCHTjZDUZ/7L0uM3HgFQkn7rRD78ohZyFr?=
 =?us-ascii?Q?H0d+qSYpZ45HGCEQMpozxEVchuDBoFJvLeNc9fhahmkybDpjdJbwlmm5eSYU?=
 =?us-ascii?Q?X77GBTsyN1jVnPRVrHeMV1iLnFa2YZygFaksA0mfJ370I77i0E4NXcd/D+Hg?=
 =?us-ascii?Q?f5wv6gk7bqWraZD2qp8o4K/77+7MJNwr/1VyZp1pGZaOXLG+U61+v80CFtuu?=
 =?us-ascii?Q?ybihRCpkdvypRhVu5jC9WIruE4r0M39DYf4s3QlKeZWkqbmt9kxnfxu6cRY4?=
 =?us-ascii?Q?WJg26JJT/nZ8bRZX/nQkdoB2/xoVBG4q453GVxEu/1jtqDuqotBLSsG6/9HH?=
 =?us-ascii?Q?ZX8RJS6QamV0fuqKb3pmKqn2HK/e/n8RhOHhAxAZMHwoD4Qe2crjlBeKbaUh?=
 =?us-ascii?Q?2pWdQ2BwEOBSCYBQJrZCOHsNz3nAayNpqOw1rXYTbfGMG6YRL6N4hbV6i0Dh?=
 =?us-ascii?Q?B1OGNIXJWJ3lF3DcZkUkWLUO5yuWPvQ3RZ1fQoSNFgzLsuDDrCsW2X2hMySj?=
 =?us-ascii?Q?Mh3+HMhkD18WDuGtV2y5hM6ISNi/HIdFBnFqaltRhNndB1ZRMW14iYMztMVO?=
 =?us-ascii?Q?PZQMM/1p4Uu8JATGjvyQNhBLbXx5+OIZQXDsvcZEr+xd5853iBJKXTa9DlG2?=
 =?us-ascii?Q?4PeCw5YqncrZk0RNiCO4NIqM3I6NQhia7DtnkGEhSsMr5M4c3y7UjUsO1t7R?=
 =?us-ascii?Q?Ga6gECC+xagxynbCuRSQQ8Y9Syn+j29ZbLnWIWwveBKEUfM8NzDeIHX4taE+?=
 =?us-ascii?Q?ICvxkkjfWIrKoetNGKuo1Qvih/Uxn8YD8cKVv5iRBmXv8vLu1YLZB02Fj92h?=
 =?us-ascii?Q?sHE1nhKygvLHEgb5yTjO0m7UQw4zWYt611Fq0Czvob2Cur9zEiagRxoEzQrg?=
 =?us-ascii?Q?mbUZ8i8Y7r15YqjpL+LrLnMX4JGZenVw5vHq6f6zEKqe3Mnpb3qlvgT6jMRs?=
 =?us-ascii?Q?xw4efZLApU6i94kMbFJCloY+G11uV+VNRD5htJA++wvZj4+4xYEYGY3VPQlw?=
 =?us-ascii?Q?Xkb5bMPh1XgO6TwfT5PJlonhip911NXqcZSxWnbvMFB6oHoullyrF3HXOdBz?=
 =?us-ascii?Q?u89tQ+c0QTx87CNJUT6Cd47zSln5QqaC7M3Ke0g3OGvJ98gesPrsq4hz5vwI?=
 =?us-ascii?Q?GrZ91DZkqcwirPgtLWenqTuNfb3m/PPHRKeFJJG6tKi4LQrBZHhzP/P4A62d?=
 =?us-ascii?Q?vZ/S1vpQPEZxiSdR2nKHr2XZwnb7kKdVFhjDiGTO6oSRNM70Dk5JphBK4EX2?=
 =?us-ascii?Q?WGxBbDXTkwP0WbLqefgkaUiOcwP87i97LEm+Okzoz8Op5eC7YOe24PioKHgi?=
 =?us-ascii?Q?v5/FNAjDuIgcc1uSTqk/iiwN221rRm1K6cKV+ZucBSTUB8kIcJd5snNWCqN4?=
 =?us-ascii?Q?7MCB+RiJavvETNzsR1Fq82f/o8/7T8f1P8iYBSg7lGt1Xkm6NQZsPWBxt7iI?=
 =?us-ascii?Q?q3QrW7WLLIbc/Va1wzc0MJWCNiFIElWNweFEZ2fXMs78JvVOUxz16EbnzXQ2?=
 =?us-ascii?Q?6NSPAQNDNOw6v2AG/IV8mGJPWcKgtjpq/4LxhnG/?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e47425-a891-4598-0244-08dd93c78084
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:45:22.1693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcpePlvmHdq3PAkmr4Dc0j8kKkuyslA74/M15OepNlcpJPG2YyejKhKW/bm617ch3eCcBHWVz7WkCYWeOlNB6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8470
X-Proofpoint-ORIG-GUID: bNFNT-W46qPlCrQrUl_9ITdAsFhhKvUS
X-Proofpoint-GUID: bNFNT-W46qPlCrQrUl_9ITdAsFhhKvUS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfX/VaPcndH2/Ml
 0mDrFUdDC28sFnJ1A17X7qwjibe5D4oWXz5VG1+INZoyz6IqQFpLEgc8xP+RHHVTwc7IYRjVMn7
 7oyqvdqlaxypUrsLAYyp2UAzCiJWaUoJpQKD78IcBuL8ZBiGRow/X6VX/h1hPr9i3mf0IFimxww
 UV0yAHDxMvkL77aGRywQWoPY7F+C9nbpQpa1zC0AcQNxFub/VqLgMQ55WzeXbZF7tpqDidE45Lb
 iSE2vcAKP9nfdvllkHyzZBXsei9Zubp7uNN9KuMs62Cvc/EOUZO7DTi0wCmJxkp0Gb1IBcP4RBR
 istdDSkRsIvMOHuwuXp+G2xCdp8xuikPskLKdSK7d8SLSCdIFoLqZq5UcFW6EcsjVTHxLEMBudV
 pUff84PB9pat6Hd6ChAyfRd/5uy7Wa6U3MgD6+oGQzPpkJhGwqouq/JjgtTRqCqfpgZ420df
X-Authority-Analysis: v=2.4 cv=KKlaDEFo c=1 sm=1 tr=0 ts=68260c24 cx=c_pps
 a=tQsPtMi3p37jOgXbkrwZvw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=hLZCMK2IaNhFlHKNMJgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

Support an asynchronous send of a vfio-user socket message (no wait for
a reply) when the write is posted. This is only safe when no regions are
mappable by the VM. Add an option to explicitly disable this as well.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.h  |  5 +++++
 hw/vfio-user/device.c | 37 ++++++++++++++++++++++++++++++++++---
 hw/vfio-user/pci.c    |  6 ++++++
 hw/vfio-user/proxy.c  | 12 ++++++++++--
 4 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index da29674fdc..22ed66c54f 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -94,6 +94,7 @@ typedef struct VFIOUserProxy {
 /* VFIOProxy flags */
 #define VFIO_PROXY_CLIENT        0x1
 #define VFIO_PROXY_FORCE_QUEUED  0x4
+#define VFIO_PROXY_NO_POST       0x8
 
 typedef struct VFIODevice VFIODevice;
 
@@ -107,6 +108,8 @@ bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 VFIOUserFDs *vfio_user_getfds(int numfds);
 void vfio_user_putfds(VFIOUserMsg *msg);
 
+void vfio_user_disable_posted_writes(VFIOUserProxy *proxy);
+
 void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
                            uint32_t size, uint32_t flags);
 void vfio_user_wait_reqs(VFIOUserProxy *proxy);
@@ -114,6 +117,8 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                          VFIOUserFDs *fds, int rsize);
 void vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                            VFIOUserFDs *fds, int rsize);
+void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                          VFIOUserFDs *fds);
 void vfio_user_send_reply(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int size);
 void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error);
 
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index b37f7329a1..eb2194c0eb 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -93,10 +93,21 @@ static int vfio_user_get_region_info(VFIOUserProxy *proxy,
     trace_vfio_user_get_region_info(msgp->index, msgp->flags, msgp->size);
 
     memcpy(info, &msgp->argsz, info->argsz);
+
+    /*
+     * If at least one region is directly mapped into the VM, then we can no
+     * longer rely on the sequential nature of vfio-user request handling to
+     * ensure that posted writes are completed before a subsequent read. In this
+     * case, disable posted write support. This is a per-device property, not
+     * per-region.
+     */
+    if (info->flags & VFIO_REGION_INFO_FLAG_MMAP) {
+        vfio_user_disable_posted_writes(proxy);
+    }
+
     return 0;
 }
 
-
 static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
                                                struct vfio_region_info *info,
                                                int *fd)
@@ -272,6 +283,12 @@ static int vfio_user_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
     return msgp->count;
 }
 
+/*
+ * If this is a posted write, and VFIO_PROXY_NO_POST is not set, then we are OK
+ * to send the write to the socket without waiting for the server's reply:
+ * a subsequent read (of any region) will not pass the posted write, as all
+ * messages are handled sequentially.
+ */
 static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
                                             off_t off, unsigned count,
                                             void *data, bool post)
@@ -279,21 +296,35 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
     VFIOUserRegionRW *msgp = NULL;
     VFIOUserProxy *proxy = vbasedev->proxy;
     int size = sizeof(*msgp) + count;
+    int flags = 0;
     int ret;
 
     if (count > proxy->max_xfer_size) {
         return -EINVAL;
     }
 
+    if (proxy->flags & VFIO_PROXY_NO_POST) {
+        post = false;
+    }
+
+    if (post) {
+        flags |= VFIO_USER_NO_REPLY;
+    }
+
     msgp = g_malloc0(size);
-    vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_WRITE, size, 0);
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_WRITE, size, flags);
     msgp->offset = off;
     msgp->region = index;
     msgp->count = count;
     memcpy(&msgp->data, data, count);
     trace_vfio_user_region_rw(msgp->region, msgp->offset, msgp->count);
 
-    /* Ignore post: all writes are synchronous/non-posted. */
+    /* async send will free msg after it's sent */
+    if (post) {
+        vfio_user_send_async(proxy, &msgp->hdr, NULL);
+        return count;
+    }
+
     vfio_user_send_wait(proxy, &msgp->hdr, NULL, 0);
     if (msgp->hdr.flags & VFIO_USER_ERROR) {
         ret = -msgp->hdr.error_reply;
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 3df92acb82..3d6a1aeb4d 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -26,6 +26,7 @@ struct VFIOUserPCIDevice {
     char *sock_name;
     bool send_queued;   /* all sends are queued */
     uint32_t wait_time; /* timeout for message replies */
+    bool no_post;       /* all region writes are sync */
 };
 
 /*
@@ -255,6 +256,10 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         proxy->flags |= VFIO_PROXY_FORCE_QUEUED;
     }
 
+    if (udev->no_post) {
+        proxy->flags |= VFIO_PROXY_NO_POST;
+    }
+
     /* user specified or 5 sec default */
     proxy->wait_time = udev->wait_time;
 
@@ -392,6 +397,7 @@ static const Property vfio_user_pci_dev_properties[] = {
     DEFINE_PROP_STRING("socket", VFIOUserPCIDevice, sock_name),
     DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
     DEFINE_PROP_UINT32("x-msg-timeout", VFIOUserPCIDevice, wait_time, 5000),
+    DEFINE_PROP_BOOL("x-no-posted-writes", VFIOUserPCIDevice, no_post, false),
 };
 
 static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 74cfaff6fa..13f2407845 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -683,8 +683,8 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
 /*
  * async send - msg can be queued, but will be freed when sent
  */
-static void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
-                                 VFIOUserFDs *fds)
+void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                          VFIOUserFDs *fds)
 {
     VFIOUserMsg *msg;
     int ret;
@@ -805,6 +805,14 @@ void vfio_user_putfds(VFIOUserMsg *msg)
     msg->fds = NULL;
 }
 
+void
+vfio_user_disable_posted_writes(VFIOUserProxy *proxy)
+{
+    WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+         proxy->flags |= VFIO_PROXY_NO_POST;
+    }
+}
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
-- 
2.43.0


