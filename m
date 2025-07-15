Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39619C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 14:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubh2X-0001NH-4R; Tue, 15 Jul 2025 10:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubgPO-00005I-Sb; Tue, 15 Jul 2025 10:13:26 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubgPK-0008ML-AV; Tue, 15 Jul 2025 10:13:25 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F7w5sm015997;
 Tue, 15 Jul 2025 07:13:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=4vuxO03IJjcS1v6
 ypG1kpZiMe2XL5kcgGTCsw9YXI8A=; b=L4dW4iVcLCkleYRe4+30gZg2qtRUcd8
 lRw4OhQoys2iLt2thy3k3cgCD4UH5DAK+2Ixb8tAqsmrNyROK2zEtrnpU1sp8ZQE
 6cZ4t5cB1UYE2zCsi7AceChPTT3MZHzJtyPReFjt1hYm+KdOOllLyJBh6yPmjLvo
 TOVZcrXjy1sGk75VDCP5eYMXJwwdxzvbwlr4Eo1Q7uU2s2CVHRqg9R6LoPdDpeb4
 ewWbl8HdBeMMRQp/bh8AOkmUOZjmGZYlFjbMrb0SXf6zGIkHW4zC5XRvjlZA/Rgp
 kxlzw5n+Ti9PWyH6nZEfoxp1UAPdDyGL3Qqgznpz+E3DGwrstuyUHIg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2137.outbound.protection.outlook.com [40.107.93.137])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47upsh6cgg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 07:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tU0icw4qWJP0WWKaEfWtjJvA62D/D0UZLkSa29Cb/jf4Wkf+aDS0yO1P43kz3tYcx0tZff9J2bx8ueU6Z1qleJi3wZW5HPkwcforYXE/pAtcRV8CUs9fg+k8JyPpdxJe9B1mhJrqyPuzW0w9JTCQSQqU71BZhL6QbCv1NCY5nHCpOT+CxE2EKN0gDBmAUzWF1MXbzblA2jBz5HMI+26Q+8LRAeiz1FgEkqd+bFS5qmAx2+YOwSVNJzqcoftl+9m+NOIEGnO0v6tDSISpfu+4htCn+sYJ6FHTwHiCC0vcyJSZcSwS5nMXHFHY0TXTVhMNWA8VXWMYu0ydiaRN94xgFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vuxO03IJjcS1v6ypG1kpZiMe2XL5kcgGTCsw9YXI8A=;
 b=GR8SYN/0h4iOVyc/HZzIJF0xOW9BwFHFqe8KnJLcGjjQ7Ygju9BUVjBeIDRfx3iIb3u1iCTQw3osaLXz+tOK0IOQ6x5OTmELT0sFUDy49pAK6p+D2NLxoDv1eYFaF01kdbqIwnqBCzxEC6/HXoi84sEHnsg/huqezxxaTx4ssO1p5JPmGaMjtxmVghyYbQkNsPHKCD7U13bVLWV+mNcae2+xj23sp62VG7MojxELbeYCwoKTvb1TiB2HOpmKfatoh8rvj6VJYTYccdE2/63lUjodtcgEqPU4bwWTNcrktuxpA4EvXjrR43BOUvvmSc0/5hz8wKVESh5SxVHnOt0yvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vuxO03IJjcS1v6ypG1kpZiMe2XL5kcgGTCsw9YXI8A=;
 b=oeSP3dC3UAdolSvXjna/BQDGi20C0sIBm/JC44HBkG7oT9AvoT+irdp34OXDpInMcq/Erv4hip9vCrhgfcWxpEgTQkMgiGE3naJ+7lSE02bT9Ve/9NW4aqWq7WuycrAdA7eF8PuuFgK7+wt3VfvRLsgCGAGLiFazwThQfQ1vRrrvqtcRhEs/I3y5BK7/xUS3jTXgfDiEmK2GDfOVXVj/LD+Mh4OFj53+36lVIL/O1ueWYdV+uDqRp7APH5ECcLVy7sfpylom/QzLhai7pJjlf+3Z68nWFdOoZS+EImGraJgd8xYHdmZLiGTNhnK8lBnRSVgaRlvEfCF9ZRyJASNlWw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH7PR02MB9027.namprd02.prod.outlook.com (2603:10b6:510:1f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.34; Tue, 15 Jul
 2025 14:13:05 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 14:13:05 +0000
Date: Tue, 15 Jul 2025 16:13:00 +0200
From: John Levon <john.levon@nutanix.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 thanos.makatos@nutanix.com, alex.williamson@redhat.com, clg@redhat.com,
 steven.sistare@oracle.com, tomitamoeko@gmail.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 09/22] vfio/container.c: use QOM casts where appropriate
Message-ID: <aHZh7JmS9iEBkFBE@lent>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-10-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715093110.107317-10-mark.caveayland@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4PR10CA0003.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::16) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH7PR02MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: dad28a6f-3313-480d-8215-08ddc3a9b791
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hH4QkAS/TQNkdCxGubQLsfs5oBU0z0D2tAZrZASTeKMxQxXkqR4SPLDvozQU?=
 =?us-ascii?Q?nF2dE+dTXHjeCjxOyhumbTkJepHABi1+oiJ6oEEeaMnddxbZPSpYq0taT/1s?=
 =?us-ascii?Q?mFPHqkPbiYMtx+DHAuu2zsYLGbrFmsVwDTOBUmMvNL08Wf9hHNEhJ3e63b80?=
 =?us-ascii?Q?1I21O9YSc7VS0MqS+IHi7x5yiZkE+krUBehk6WCZSDMtFwUnhYaj3zGtNS33?=
 =?us-ascii?Q?jx7kpFyBZm+DUEIoum3q0xwIIVWNj1yMv0s8kmt4uKVUgDZPuntSr+F9+9oC?=
 =?us-ascii?Q?65I9kHyX3bI9LKRaIXpPoWMkiSCbxo0JjPJflgUmC5fhsmcZPCar2RhUXuzJ?=
 =?us-ascii?Q?v4KCSKEYC3ptuFszgV6YjC9zV1V2LaemEZOvnVp/Pu4qN3EOyfgC7CZ/a70m?=
 =?us-ascii?Q?XxufHdTtaqLlhsVTcCBWvVy/9NNbfg7zM13LpQpSpn094W/36STQrWw6kl0z?=
 =?us-ascii?Q?yvTFRR5epzrOMDk+gWxVkCR4xDVRSwwKBF8oESWDlnrjHKU0SwHgp8bflWu+?=
 =?us-ascii?Q?p+eUFOd5R+arNLds9sUFp9gqtR5wLy3prv7+LfZgoN7XdMJBtuJpR8SuXjQg?=
 =?us-ascii?Q?NX6yfU/YpuIsVS2vkDjXxBo1AqW15QNEXqQ6N/1h6BcSRRR1fT063S6FN/tn?=
 =?us-ascii?Q?FRfYfM/1igVhjOpsKLTOzAV/CJY73OVvP0DR/HlTvcld/3wD3r6AYpfdUBF+?=
 =?us-ascii?Q?rwCUG+RLEjZEy8mwymq5GHMe/CTLEMMDSqmoP0CvocPue/c75QY6rr+/Urxw?=
 =?us-ascii?Q?Sta4A9DJSTTmvT1w2FXz/KouSjCpRDfdrmYbDAWVh75BbhBkPquT+N6I6xpk?=
 =?us-ascii?Q?9lu+59jP7O/jstIpmCN3ZnD9ydctFazN4deXO2sgHydQnW4c6wSUXtfc+PYw?=
 =?us-ascii?Q?7liJtw70DgM5rgq94IvldbvAzg6a7DUozHE884cnLg/rzcmIk6b6WhsB5no8?=
 =?us-ascii?Q?UFSFZQXSsC/Q6A3ZjeMOxakbIwGKTW8oVlpdQFEW5nOlSLDrEPNEsLQEvslg?=
 =?us-ascii?Q?zOoV44dP2h3R2BGBEM1JGmCkZFKh2XgQ25sPk1DMUb4NSRzpuZGxXNBJ4+uZ?=
 =?us-ascii?Q?MUvbuB0G60N711n8ZWK63DxR5/035VbJJmao8jtYj9KP2Pk3nvLFQjqNTWKA?=
 =?us-ascii?Q?VzKshnyeNZi/4+hOv9at8Oqs8/lXGHC58HmVwJIWUejnz/HK54ocmAYPX620?=
 =?us-ascii?Q?HtvQvGGFoLMTGurZN5RCWogrcdWkEEY9E62Dp9aFawX6AmAOExzFBl5GRPsM?=
 =?us-ascii?Q?re5mED0lgo33i81RRD5iJjRX8P4UqXAlVDfjg6C+eWa5wWCNsHtTLIRcToor?=
 =?us-ascii?Q?LJ/Poznv958sn8OFW2IW1/Z90a22VlpDHZGpnvdUNYo/GcG5mLchpRcPZb80?=
 =?us-ascii?Q?a/I8nYSGg2ifzJ4XJx+Bj4knqlzPNckBMou2ejTDvyHQ67mnLTGdI59OPCVf?=
 =?us-ascii?Q?lx5cruuADHM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Br+My46c8AgXuzF3p2wTSnu0RDoWmHm8FY9vxDypZ5Wc4pd3HBp8/N1Eqbgh?=
 =?us-ascii?Q?gxHG5+5fuGVpMdH1sBJqvkCXKaqv6z81zFsCAHQQAmqYq+Q1O3iilmIDTsMb?=
 =?us-ascii?Q?TAa9TDL8YRwPHCGDU8WbXuDvMNt1/qxlFZEbDoEnLASGkj/8rSG5xN0SkwIF?=
 =?us-ascii?Q?XhBkPrOI1VAznK7S37FimjQJ2Z3qcYgUI7cJvDb3zRE2YAujgZrNBbgQ4xxL?=
 =?us-ascii?Q?NFu0K7RjmbAekbhnHxdggQLkFZaIaua5LkaK2qlr5TdmXMvFyoU4d5V2zZ+D?=
 =?us-ascii?Q?6WoI9p1E19l6pTkXcW+ysZR17FzomjYCk395Z+vR/jhvJbtAmTxa5HSvSTcW?=
 =?us-ascii?Q?691K/VqLToBD6mS34yCIlvWo7LA8YhiYZvsVrMmJaBjcB/suowtbtOR3PVbA?=
 =?us-ascii?Q?vND2mC/KU3/tyCDg7re/hjdsmJi8WAHyrPA1nwK0Ab7KOU1XtYcM6sXC0yRm?=
 =?us-ascii?Q?pegL4ps6CgU5QzbN9Q8turfWFZl+yAp7suZef9hRVB+oGEzTUeenqIHENWJc?=
 =?us-ascii?Q?7onVZ/GSUTM1vUCXEvD4IKUwZV5PT1Lv8FcYUEKs7UvxCzrheJb6jJOJ9Nxx?=
 =?us-ascii?Q?CzFloxr0EE48n37EHQqwvhUNaJPbO4fmeqdizUpr9kW5tr3KS4QjgAtEna/Q?=
 =?us-ascii?Q?kxDHneuA0oCKNCAzjTtcMMoFYn91R6BbVuzj1Zmo5yZvM2940GTpbw8SPfvC?=
 =?us-ascii?Q?vASWDoqMOSipLGeRS5wdd82yANDbKokIFgPm06UGabghko2euQSdu/7MCxcf?=
 =?us-ascii?Q?PNlyBbYy34ErzFoX7+H5+cbWmEj3mBGFDXbM9WArjQczPxSOziu+pKbC/AvP?=
 =?us-ascii?Q?8s/uw4kkPrbVkG7vBCmcpc+/DHbm1BzkuDnO+NHVujZvv0+kqPBnvOJU3n5G?=
 =?us-ascii?Q?G5ECIqEh4DJQuQf4xn+b76Elg/ItltxOPR9TMvZ5eFNXubXBxavbZwsATpbM?=
 =?us-ascii?Q?xFcv2L9moa0gjVxNYFo5wJQqfVRk4wIUWmwiq33RmUmWNSPN5dMBT5rduCr0?=
 =?us-ascii?Q?DsXpM320+epSrh63GbxmrQNOU7B/K1ZFNl6ajhOe6tThUAU4LTj+d7npUiWh?=
 =?us-ascii?Q?nUISouVRXifup2GP1afZpgdEc3ERyzJA+U44LoJBPKinCdjY8h+wPIsPWWKf?=
 =?us-ascii?Q?D73c3o/S9DIzfuEYD/mUhLFfaJDwEZJtIr+KlioCtXRnY4Y57La9zRfUkYH8?=
 =?us-ascii?Q?PmQTke5WoRkwUyVAN/mgp/0P3YTwpf7xZuAUsWNRXMVTI6JejjFZ50NqZcvo?=
 =?us-ascii?Q?FZ1oa9buIB5zTDRh9tAS6miX5Eo9GXQOOfxGI7T5nlICb/9YQKdG0gcgI0T9?=
 =?us-ascii?Q?f9l4mbFV9pDHoLSR4TUiNY3Nr7avARg1SoOqKHtjmlEhK1DcVdf7lGMnCem9?=
 =?us-ascii?Q?vENk5vbeZwpe+QCo5dO0248Rfq9sLOs8T7Nchc7/qSm9PDSPl0yKORwIIxKM?=
 =?us-ascii?Q?/J9g5lwjUgBORaIix9aeDeEMz94vOAm2uPeXhJrlizzHtegUlhW+47W7b4LP?=
 =?us-ascii?Q?qa4fR2uSTH2Ew1RzXzSbcqPzeo5LN1wItOS9Eq0MO1MTHKP0xgFBGTbFhBLg?=
 =?us-ascii?Q?ImuyEVdf1ikL3saZ2vFCpYfP5DifOOLODihfQsqBayLc7t8z+mgPlp66leP7?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad28a6f-3313-480d-8215-08ddc3a9b791
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 14:13:05.5641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnY01cWL0BztxykxKKxH6DZM6S4nRkFTtSPLPknS8+Br8STT80snbDF0zzrMRZnQx0nPvHgsEGRq45cceVVYoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9027
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEzMCBTYWx0ZWRfX1mmSoTWOuvd5
 gArGuNHlk/wK/ntsMlEaf0LhOlnlbbd0dhEJ2RCJNorva2aIeyBNVZnhNwrR2f0rVSwicHgH6bh
 KBQ/eSg3mmxxqaQtLbNqW1CcH/NDrJrUdjTlSiG2wjmBPue2ao0r+OksfJdUQwJNYekiRxT2Ln+
 p6fVqomRp/0stw0RPpAafEieBs7I/PcgHTVjkmyKc3kTAasf6AHbmU4r2O9Ih+4a5A+UShj6vUj
 S2Cahh+Uo/WOAg2vxaIE8jDy/2ZL+e9Nk6MXKL6ASvkfANRbmNgJy1lm7W+km4IFZvYl48wotVo
 RhY+8614EhAQw0E8Rl1IMGeN1lQBvG8APv98ckTbYElg9KiqtKE1x75WxGlGtTlWkv2JVjL/9eR
 S7O9/rfc2UJ5xV28XLAPcZTBk+oISIAXoRb+b4ZD5WrDcXz5mmTsM8r7cIPSnVtCeQrT87F+
X-Proofpoint-ORIG-GUID: v2cDa_8s_fThiiv3beDV-qQSqqYF09O_
X-Proofpoint-GUID: v2cDa_8s_fThiiv3beDV-qQSqqYF09O_
X-Authority-Analysis: v=2.4 cv=AoTu3P9P c=1 sm=1 tr=0 ts=687661f7 cx=c_pps
 a=VX/sFGoG5OGT23SVPy1oZw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=CW3U6tPuvI0nifRizXAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
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

On Tue, Jul 15, 2025 at 10:25:49AM +0100, Mark Cave-Ayland wrote:

> Use QOM casts to convert between VFIOUserContainer and VFIOContainerBase instead
> of accessing bcontainer directly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Patch subject should be  "vfio-user/container.c" not vfio/container.c

regards
john

