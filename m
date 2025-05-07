Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2C1C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 15:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCgao-0005Nh-Gq; Wed, 07 May 2025 11:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgaX-00055o-CF; Wed, 07 May 2025 11:21:39 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgaM-0005wn-P7; Wed, 07 May 2025 11:21:30 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547ALmww025335;
 Wed, 7 May 2025 08:21:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=j81dytE72s8DFTSlD0SuuSOpAPIwCc5l0HJJUaIhG
 C0=; b=c+QhwWYI+OG94iaaOGIEW4uyO2/y4gzqfjPkNVd/hK+7b1NbGjqpD5pvH
 FIxzYTzlnCMKi5+Hl9dw6+vxgxu2HX0xrffmP24fLd8g2lVRTKSU7U7BDycHYZOD
 X4iGw8KT+58fOI6KR7RVcH7L96fi1wHR3uaHhxLFPxvXR3HIag5PJGuqB14oWdMf
 kkunjVPDi80yLzBNRK+PsFH7dZxVoaiy4rF/WtQupvjpz/BG0tjugq/7Srmn/o+s
 zDteYRuRDtTaZoUw2/R89hbbnUbaMLazdVsMFw92lLMnVvF2IkrIfU52RJ/JPt2l
 fXru3e4sgmiU6qSg/JIapRdlIJUQw==
Received: from cy4pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17010006.outbound.protection.outlook.com [40.93.6.6])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46dgp91ekp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 08:21:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItFD8upL3wOxCm6KQpNHzDtCnnvVunQmeFL4CujU/jE9sdTr2Une/D/FRvNuuvbb5l7S7fIXQOw9KZI9CoCr1uzwCbeZyXMpJvOG8EIKYNkiY4Yd6e+rNA2PmzdXiFhs+9GaDvT0lrP34hbiNKfQ7odkViuAxELSVkA1RPNf0iNcyHx81Sg9scIIuzQkSaS4Ltn/9+KrzVba2QBRt/EH0NY64sN3C/iVBDVFDByQOF+r3+IbHoVL2um3mD8X6fr4QhyEButW6DQyc6iZsTB5ZZiYyESYC1ZXoxY9/Wu6U+KyHAHB44SdW5CI+bs4ihTY/0ynb6FpXaiQ7uhKgVXocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j81dytE72s8DFTSlD0SuuSOpAPIwCc5l0HJJUaIhGC0=;
 b=H9v/TCagmV51MOT87pEW0l0csLbPunW3vHdONrC42Z1JUiC4rZthMdOAFreReBK//dqs7H9jRshObkOxRuMPMvnmGmJVdrNTnptq+2KqpOcYgvvGU3d1ei3LtlPkhAtMYR0jjFFcmKBRVK/fFYmJeKtRIoe8YPcF1NhkEc+fNfxXYHH2GJgrCbmC1tW6AAheJp2ottGJuG3kley+QqRLCctc7vr5iXXKLyPlsefkhbYNIxYPd0CEVLQbNMaFg4iJ9k4mu5CbuBB/+PrgF6CoCaHO65fsS0rfuljxQ7qzk9acHKvnzo10o+flvN4dhW8sYlsdO2e2Fbf0akTGDE4c5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j81dytE72s8DFTSlD0SuuSOpAPIwCc5l0HJJUaIhGC0=;
 b=gkn4Fs5nC2PJuxNcPBj28YWmXuRpr9wDmc4GHu+NKtB3Z43fZYTbc5l4Lm/EHmAYiwQcrAltR+IKHF+xNKs3pm0dkhZIz+r1eTAqvnGiZMTFvY+4BL48JOSJXpiABfia+ubDFkTeJ4m7tyOEu+3WIBk1NoPAWDSsk3TErI/jQMa5qfa31jqNv9L+Sre34ZXun2AkXMQqF4nS+2ufo2TsqeY1Jd/e6xtvX02EgmZBgcZKue3KBRdIhR7jW3d2J4bUF++4WxCX0qYOwD+Re1Sqe0rgW3qNKkl8IKipcTbCaO+NKSDB15TTNg5fqeNv1n6bSx90icr9SXa30MABuxjEfg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BL3PR02MB8220.namprd02.prod.outlook.com (2603:10b6:208:342::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.17; Wed, 7 May
 2025 15:20:59 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%5]) with mapi id 15.20.8722.011; Wed, 7 May 2025
 15:20:59 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v3 11/15] vfio: add region info cache
Date: Wed,  7 May 2025 16:20:16 +0100
Message-ID: <20250507152020.1254632-12-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507152020.1254632-1-john.levon@nutanix.com>
References: <20250507152020.1254632-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0055.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::22) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BL3PR02MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: a34d30fe-b9e8-4766-1758-08dd8d7ac562
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mC58om9gJ6AM791uYx/GgErj9i6zVQNXccKOWX6hfneCyctezPrOMlXQ7j2c?=
 =?us-ascii?Q?50sZ0heiPz3zKnM6mdN+6UapeI8p48gr6KeEig8CzwSTpd3hH1XmrQzCzFdC?=
 =?us-ascii?Q?++XEttQovvKnVb313q/JpwSgmOVPgZYZ6XMQNWUbLjY8z461KcpOm067osgp?=
 =?us-ascii?Q?RfmoW92wIB5AZrt6fct+sQDVVbnqXh0oN/g3xOHSMynUdSr7tbXWKVblNZiR?=
 =?us-ascii?Q?uRoAxszEzWFQtX3E3v/YOx9SFMAfQR3xZ7gyz4AF+rGqY7vLnXb61NDyrQD/?=
 =?us-ascii?Q?wTZcp3JoqVGAlzsnausdd0KswWxIrh3heEBRL8t2+ec9XSMV/DAcJY8/w6Ke?=
 =?us-ascii?Q?eY4AbsSu5zqmdgMR9ghuyGbp1nr3Art6uPOAxu2f2J8rr0L3Qxge7b1TRFXp?=
 =?us-ascii?Q?QXLgad6qYpeYm0llL1phaXoAIlgAcIXMguT2YlDwAmHxfJU2LjLZdwtPRi+i?=
 =?us-ascii?Q?jJC/ERNMV13pELR1ocuKVfo7vPi1dHEZNpp2COS+T/cigU1Jp290Ytt643Xo?=
 =?us-ascii?Q?73W28VlNQQAnZokPVICOc7k+SYDfkmj8yAIIoRIfJRI5KRdS+ZT0+V8R3tpN?=
 =?us-ascii?Q?iPxXoKVlnsZRre0PdPR0kgM9RJ5peEPIP4CWJ/JOet56fq675MAAe0Wd5lXt?=
 =?us-ascii?Q?Fy2vqfraF2k0oER2bc2EPhPXc3JGmM0sruXJ837s14S8Ey7YuqCmAmYPE4lT?=
 =?us-ascii?Q?L/BlhiNLiF0Rxmn1NaxAL7yB/PeHoTw+v89YAF1TpTExbvbv2qkJu2JolGLO?=
 =?us-ascii?Q?ixgOlIO161vTisIkhI1qXE1XgEm2aH5MAAktE35gZHelkzo6Dfww4NkoZtq0?=
 =?us-ascii?Q?R+6zPg4UYI9ROrCF9DisxDa9KGND1sruq9wG49+myT59eXjcbGbXZ4dzxnOE?=
 =?us-ascii?Q?CUeKpxIM9Z0s20XQGzWsHxxh78rZzULh5r3OrpP6rKGdXfBHj8p7lQAfIQX6?=
 =?us-ascii?Q?SDm4h/82Wx8+8ul20s9gfSyHyRPbz53skbbTb6Uu5hfkHUEj3GpavR+RrKVY?=
 =?us-ascii?Q?Y17VBhYa54nkFFckivjk5UTM20yMzYWoIR6JGifvRzBiQbRGEMa9JlYhoyRZ?=
 =?us-ascii?Q?fNUQ5/kpnDpgE6qpI2Cz6jkr+9BRHNZYQB1tv7xPMsa4FrBkKMu8MilNf5ud?=
 =?us-ascii?Q?lSB5OJirKLKFwxtQFyW6+8NfeyRZopbqBgShUHLP2WJKoOv4rT0+IcDl+odq?=
 =?us-ascii?Q?8fEHYScLOl9HWBWjVAVNk9wOhifHKrRquSF1VEJECCCveci9b4ZNjFTJWAia?=
 =?us-ascii?Q?eZEp7W3OvaSf2X7dkjKireHlAs03iPVP8UzdhnvTa5fG5IDhu6fbZUl8oVtq?=
 =?us-ascii?Q?nyVKaILoG+//xromP2a/oqzjBPLqQbmGOpAR6RYLDIGizgCIlJqJMPL2OREw?=
 =?us-ascii?Q?z8JFrevT0QRIz8VJAA08Gqvhk53RWxraEcl9+aZCIzN1vIfC5g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5yDlfvsmGqjuBL3GromHCzY+gziN4TCIBWN1PuY31fUOf/lK6hijsihxRg4n?=
 =?us-ascii?Q?HdHRbSLX0iZvRGGzcgZ818g5Iu5u7+akLN3mgBCnuj93Q6BS9BbEjBCZfgwZ?=
 =?us-ascii?Q?UBlXDmtSDRqvf58NalahOw0ArWPJALjaeInMtzvonScNmOINqlHMt0PKVUSM?=
 =?us-ascii?Q?gbIc2+ogs1+BCbRksfDKMBa7Zj4t4BEJXUK8cYO7rXvl3ZFKVmJRbQzbJwwA?=
 =?us-ascii?Q?nVBaGrrVyks08Wj0SjQnUiRLCWgYoAKYzWKgzMdiPojus5DPOPgT12SYw4xm?=
 =?us-ascii?Q?EoIYqwnif7S0IM+mY05YXw6JpBWdr7ezr9uWqolvueQFuRJuZx+mYmBHC0E/?=
 =?us-ascii?Q?/7Zcjih4WL1Pgul8aAc8v7DBGp3GdhcyGiSjodOFmtRe1v4p6JmTYBO8+oj1?=
 =?us-ascii?Q?s6Zpy8iJEg5Dh6ixTX78Xl7eFlNMc2NuoXaKoQQNmqAuJDAGBq6oXnGJYzNV?=
 =?us-ascii?Q?9Sh8FIZmGw8zhQS5QpqCodyYJfNB2WNUL60Hw589bVighDBuIRZtKz690iDI?=
 =?us-ascii?Q?2JSs1PTTWv9wn+7U7XV4pToXXs1KDCp5sBAcQsRTe3/V9QvZK02kwugA647r?=
 =?us-ascii?Q?nGrVRmBE9zzzi/a6TOgGfTl2m1jZmEfamr4KLiS1icT6oQa260rOOALo/YXI?=
 =?us-ascii?Q?dmkPkaPQCtwUSzfnPAh9isrggbrwDs3EVS10WRmcVY+aVPd++VRRKmFHNyLx?=
 =?us-ascii?Q?uZjYtl7fMFotwgtI+ekVwQJK6n82IOcNhG7FK5OmL+TM24gZf1QR0UgcpvTH?=
 =?us-ascii?Q?oJu0Z4mXpFRudzv0j0SfrapFDdOXhpamMauuizGrs9GV0CHCwI7qVAz0Z/ux?=
 =?us-ascii?Q?EjrpzTuidPNlCuhr5pJRh3+xMkDtBoIYcW8dBQp6QPE8GmuKHq9Qd2A1mjrl?=
 =?us-ascii?Q?qGuXvrsR/7PMwAT76HEZ06KtHNq16LNSEDjqTnrhPjH2ZrtyUJ3RY6cje3xI?=
 =?us-ascii?Q?6rFMxiKEoh4/852BI+0YJQe8SWgZb+Ulrs0z6z/hA1aYeB+ipI1waAbf7Elc?=
 =?us-ascii?Q?vAMvOaf12JtK6+//Vl2maknA5myN4lWQklRpsY6VwLJWeCw4XRcX2Ihd2ZCf?=
 =?us-ascii?Q?O633vhaOES5HqnjlfwYBF4gQQDGH0v/Yf6pAgNhHD/tCE/dtkFAEOZeL73Jr?=
 =?us-ascii?Q?1QOY0whWMRr5i7dDPIFmkyuG6t6TP2kG1Xgv9Vjx0cl7ABGrPgBmJ1RxDXxc?=
 =?us-ascii?Q?fA064OdsI5nb8Y91w0QfogzqLoq5k2ZifcfG5ZvN2mbQ5teEvYXBdur587vd?=
 =?us-ascii?Q?xvMYAaXhxfEbc0yKHo2DZk0ALg2RG63EhLeh/CmIcMHKm5CsyUQvO0laNxOi?=
 =?us-ascii?Q?ETom6rFEE5l/vWaHyx8Ei/QAImm5BORZ/pi7FoHRRM7QBPG9dEP5+xXxmIqV?=
 =?us-ascii?Q?0p9tZJemx13HBOGm5jC0n/kU+HIOvsKBsRzmN6V0XPU9s7DdDaGVPnBtV6NK?=
 =?us-ascii?Q?uwolA6mIAldQKtEwQux6KDJk8kPNK5sqgrVxP3b6NteXQ+aSiPsbfUbT6pKe?=
 =?us-ascii?Q?z1rHPdvzQ8PZXJfKboF9YO67vR7QPmwtkWsbvmzCv0BBxV5sF8a6n88z7G+A?=
 =?us-ascii?Q?eeMYWAsyF/RsOxLKFvzglCvFBxn6mN6MUVmZRMhe?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34d30fe-b9e8-4766-1758-08dd8d7ac562
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:20:59.4880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SX4hItH2SgCQ23Xk3bo0yEG397mXR9lpzxIw++aRdX9+qUvgqM0BK15Nby3cEoAPBHPW3I03IgqZPfw1SPnS9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8220
X-Authority-Analysis: v=2.4 cv=R6cDGcRX c=1 sm=1 tr=0 ts=681b7a68 cx=c_pps
 a=ox8Ej8V6LcPVg4qe/Ko28Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=yLJTwCVF-aHqTr61_xIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE0NCBTYWx0ZWRfX1qARZiYRgExK
 djG/ZVm64RNRGz02KcnJAOXCHtGE8HMPDgkBbMvJWV/3cxi69yiwSepUf2JUftk9gp+6lvLnoRX
 DQPcHIXjtpSKruBpCErYyfDCvyTeL6WtXhmQ10w68x1rZkuxyIjhH4ZuEQXWAM/hrJY+LRfzEr8
 /cEqZsxstdztiyLiZkpHC1fxKHISKezw0IbAWlCUZ9ltf/24x4krjFFGrwjUGJmF+cMCbnddCvE
 5eLaA5jgn5rd2Mx0EijDcStloFxXLG0ftkcUYMk9izorcmsCss7EqZCI7xkYNw3ZX0khO4kkqaV
 HITK7vEQI/ISUTPbYnp4B20uoQcU16JaQHaJNnLWCIYxQ9zQzL4T40308J9xu/x1yqnfQc6FsK6
 NIJ15xytVT+fzK/kMM8q92F+6XsvuSsYp4caOVrZe1WR91WxSZgD0+D/blGhcx1BYgCOTAOU
X-Proofpoint-ORIG-GUID: RVpCqBtBpaT2Y35vAg4F4zvp8u9D1tVd
X-Proofpoint-GUID: RVpCqBtBpaT2Y35vAg4F4zvp8u9D1tVd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_05,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

Instead of requesting region information on demand with
VFIO_DEVICE_GET_REGION_INFO, maintain a cache: this will become
necessary for performance for vfio-user, where this call becomes a
message over the control socket, so is of higher overhead than the
traditional path.

We will also need it to generalize region accesses, as that means we
can't use ->config_offset for configuration space accesses, but must
look up the region offset (if relevant) each time.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 include/hw/vfio/vfio-device.h |  1 +
 hw/vfio/ccw.c                 |  5 -----
 hw/vfio/device.c              | 25 +++++++++++++++++++++----
 hw/vfio/igd.c                 | 10 +++++-----
 hw/vfio/pci.c                 |  6 +++---
 hw/vfio/region.c              |  2 +-
 6 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 7e1e81e76b..4fff3dcee3 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -83,6 +83,7 @@ typedef struct VFIODevice {
     IOMMUFDBackend *iommufd;
     VFIOIOASHwpt *hwpt;
     QLIST_ENTRY(VFIODevice) hwpt_next;
+    struct vfio_region_info **reginfo;
 } VFIODevice;
 
 struct VFIODeviceOps {
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index ab3fabf991..cea9d6e005 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -504,7 +504,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
 
     vcdev->io_region_offset = info->offset;
     vcdev->io_region = g_malloc0(info->size);
-    g_free(info);
 
     /* check for the optional async command region */
     ret = vfio_device_get_region_info_type(vdev, VFIO_REGION_TYPE_CCW,
@@ -517,7 +516,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         }
         vcdev->async_cmd_region_offset = info->offset;
         vcdev->async_cmd_region = g_malloc0(info->size);
-        g_free(info);
     }
 
     ret = vfio_device_get_region_info_type(vdev, VFIO_REGION_TYPE_CCW,
@@ -530,7 +528,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         }
         vcdev->schib_region_offset = info->offset;
         vcdev->schib_region = g_malloc(info->size);
-        g_free(info);
     }
 
     ret = vfio_device_get_region_info_type(vdev, VFIO_REGION_TYPE_CCW,
@@ -544,7 +541,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         }
         vcdev->crw_region_offset = info->offset;
         vcdev->crw_region = g_malloc(info->size);
-        g_free(info);
     }
 
     return true;
@@ -554,7 +550,6 @@ out_err:
     g_free(vcdev->schib_region);
     g_free(vcdev->async_cmd_region);
     g_free(vcdev->io_region);
-    g_free(info);
     return false;
 }
 
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 40a196bfb9..77b0675abe 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -202,6 +202,12 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
     size_t argsz = sizeof(struct vfio_region_info);
     int ret;
 
+    /* check cache */
+    if (vbasedev->reginfo[index] != NULL) {
+        *info = vbasedev->reginfo[index];
+        return 0;
+    }
+
     *info = g_malloc0(argsz);
 
     (*info)->index = index;
@@ -222,6 +228,9 @@ retry:
         goto retry;
     }
 
+    /* fill cache */
+    vbasedev->reginfo[index] = *info;
+
     return 0;
 }
 
@@ -240,7 +249,6 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
 
         hdr = vfio_get_region_info_cap(*info, VFIO_REGION_INFO_CAP_TYPE);
         if (!hdr) {
-            g_free(*info);
             continue;
         }
 
@@ -252,8 +260,6 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
         if (cap_type->type == type && cap_type->subtype == subtype) {
             return 0;
         }
-
-        g_free(*info);
     }
 
     *info = NULL;
@@ -262,7 +268,7 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
 
 bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
 {
-    g_autofree struct vfio_region_info *info = NULL;
+    struct vfio_region_info *info = NULL;
     bool ret = false;
 
     if (!vfio_device_get_region_info(vbasedev, region, &info)) {
@@ -435,10 +441,21 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
     QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
 
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+
+    vbasedev->reginfo = g_new0(struct vfio_region_info *,
+                               vbasedev->num_regions);
 }
 
 void vfio_device_unprepare(VFIODevice *vbasedev)
 {
+    int i;
+
+    for (i = 0; i < vbasedev->num_regions; i++) {
+        g_free(vbasedev->reginfo[i]);
+    }
+    g_free(vbasedev->reginfo);
+    vbasedev->reginfo = NULL;
+
     QLIST_REMOVE(vbasedev, container_next);
     QLIST_REMOVE(vbasedev, global_next);
     vbasedev->bcontainer = NULL;
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 3ee1a73b57..e7952d15a0 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -349,8 +349,8 @@ static int vfio_pci_igd_lpc_init(VFIOPCIDevice *vdev,
 
 static bool vfio_pci_igd_setup_lpc_bridge(VFIOPCIDevice *vdev, Error **errp)
 {
-    g_autofree struct vfio_region_info *host = NULL;
-    g_autofree struct vfio_region_info *lpc = NULL;
+    struct vfio_region_info *host = NULL;
+    struct vfio_region_info *lpc = NULL;
     PCIDevice *lpc_bridge;
     int ret;
 
@@ -510,7 +510,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 
 static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
-    g_autofree struct vfio_region_info *opregion = NULL;
+    struct vfio_region_info *opregion = NULL;
     int ret, gen;
     uint64_t gms_size = 0;
     uint64_t *bdsm_size;
@@ -551,7 +551,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
          * - OpRegion
          * - Same LPC bridge and Host bridge VID/DID/SVID/SSID as host
          */
-        g_autofree struct vfio_region_info *rom = NULL;
+        struct vfio_region_info *rom = NULL;
 
         legacy_mode_enabled = true;
         info_report("IGD legacy mode enabled, "
@@ -681,7 +681,7 @@ error:
  */
 static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
-    g_autofree struct vfio_region_info *opregion = NULL;
+    struct vfio_region_info *opregion = NULL;
     int gen;
 
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index da2ffc9bf3..9136cf52c8 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -883,8 +883,8 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
 
 static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
 {
-    g_autofree struct vfio_region_info *reg_info = NULL;
     VFIODevice *vbasedev = &vdev->vbasedev;
+    struct vfio_region_info *reg_info = NULL;
     uint64_t size;
     off_t off = 0;
     ssize_t bytes;
@@ -2710,7 +2710,7 @@ static VFIODeviceOps vfio_pci_ops = {
 bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
-    g_autofree struct vfio_region_info *reg_info = NULL;
+    struct vfio_region_info *reg_info = NULL;
     int ret;
 
     ret = vfio_device_get_region_info(vbasedev, VFIO_PCI_VGA_REGION_INDEX, &reg_info);
@@ -2775,7 +2775,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
 static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
-    g_autofree struct vfio_region_info *reg_info = NULL;
+    struct vfio_region_info *reg_info = NULL;
     struct vfio_irq_info irq_info;
     int i, ret = -1;
 
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 04bf9eb098..ef2630cac3 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -182,7 +182,7 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
 int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
                       int index, const char *name)
 {
-    g_autofree struct vfio_region_info *info = NULL;
+    struct vfio_region_info *info = NULL;
     int ret;
 
     ret = vfio_device_get_region_info(vbasedev, index, &info);
-- 
2.43.0


