Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF57C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 17:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u80iD-0007WN-Qz; Thu, 24 Apr 2025 13:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u80iA-0007VW-MA; Thu, 24 Apr 2025 13:50:10 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u80i7-0002bv-HB; Thu, 24 Apr 2025 13:50:10 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OHjGuj006264;
 Thu, 24 Apr 2025 10:50:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=9h2XG8GP8oR4RbUbX6Wz6v/rPt3+EMOJ55TfQy0DN
 2E=; b=t7wYrKemdF9bg0JMnMePUxvuqM+UTVS5ymRJW2ImgFAR3iMCFwzoYIqjD
 ZwVOk6dHi/4lNRvq1xvUc+EJwS6oD7g2/XfEaKkWZSDZ0adk99AU1HutDCSKbznY
 1O3bc9HhwMOekFsou6+rwxrPlDqRU49TBGRfn0KkydYju3sGsmQVGKwydzopPR0p
 Wvdutgu6GLeGQIiop3mDirrqxNV9TgO74QpWzKbJnIb6XTNdGJgnJ3h1FSq1YC/q
 vChDORmhTGdDTprHCKffa3ryADOn7RB2k1y34BxwOdhodeYe+Mi4Zsv10HadRXnn
 08V3pPXnxNpAQGnQE8LLENuRDJ5Pw==
Received: from sj2pr03cu002.outbound.protection.outlook.com
 (mail-westusazlp17013074.outbound.protection.outlook.com [40.93.1.74])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 466jhq5dgp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 10:50:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWyuTIE0jDaokM4Pke0ilW5gXjxifEAW6xVXDsEIA/6axmc0K/ddolMAT1+V31vcv3dYMnCseZvMwv3/MysAU4p5c3Ev2rfAcrMfGSQ6caHF9/XMGLMsaDUEax/A+N3fHAkrwFEXbRqfO6wKRgAIN2pViTKj23/jGPnjKCzAyO0RTIPp50aQ4MYq5HDN7N3wTx/4iI6Uox65PPbgyhcnSRKKDHTUHibjyXuxADSQmS5PNnipEVijp3Y4T14LPB1aMkPXJKbMruyklO7piSGVduaC/0yP12MXLx7CQCxFAVlW+/JuXjsawWFDN+3G2zXEQK5iwjgRRpvwB8wspEtTUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5U7VV52aHVqIwb3v7shlyXIYGeh0HXiHVR/4boiYLWk=;
 b=rfXHwNjaBr0m0JbxdxPAXpE0wMSfh4PGwH7jogfnbJhf4Z3X1jYrHrC5tAc2gHj2rg9SIr7X1kY170kHabeNqhXrRkCZeXlc9rWnST2/ZALCeWizgi5batfz/zw+O8ghXAWvc9w4VtsYNIpz3YxUhYibcsbT4F98NGS8ZCGpyHbuKrIwaG4X8YCSf8DsRLfA2bZicQHLyzXEkwMv7JbvL4kW1pOYb2UO685bwV0/i4Sumcu5zLtOV19bqIC/15UJsqqkZ69iz3SlRI37oiC+uqvtQXlAkbOc0+fPciLdx6xrEvyuBoweU8YER6TB8D9NMcZrMIFhR45ckvGS0U82kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5U7VV52aHVqIwb3v7shlyXIYGeh0HXiHVR/4boiYLWk=;
 b=SaoE9s/udTPNtNS7RYmQ+c6l7kdSSVIN6wWWrCynZpU6jrzY6OZqwMtwFU3Dc5WmFLy83eDGzYsju8gNxDlXruaqiolM5MxxebL4mWrj1ew/GOJzpUrVdNzYPj32jitj2i1vJ8strdzHPxUp3ktmBUQdoqO82QoR4EFGbC9kZHxNq6OszyGmhF6XD4lI8jlvunkbKoHTzEHS9duk8WpTgcRg/Rl+Esyt9dmDgRlTCKlgJ0wpF4WJLJHhrCOmNhITLp12QFQ5NAPUHkAYM/SEoWfDUcK1RJYNyz4Pumi0mq1himPPTSG7RDHNdAs4bpq3fU1JJyvfa22Cn/CznAdeNA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DM6PR02MB6559.namprd02.prod.outlook.com (2603:10b6:5:1bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.9; Thu, 24 Apr
 2025 17:49:59 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8699.005; Thu, 24 Apr 2025
 17:49:59 +0000
Date: Thu, 24 Apr 2025 18:49:53 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [PATCH 14/14] vfio/container: pass MemoryRegion to DMA operations
Message-ID: <aAp5wRFPVHZa8qpn@lent>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-15-john.levon@nutanix.com>
 <ee8e7759-52c6-4681-8369-3c47050d574b@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee8e7759-52c6-4681-8369-3c47050d574b@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM0PR04CA0066.eurprd04.prod.outlook.com
 (2603:10a6:208:1::43) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DM6PR02MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 05aafb29-a11a-4010-8195-08dd83586e5c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Pz7JEQyegwzKTWA9VMBeqeNWFo2tX/qgbIXptX5M7W2iBgj83YJdwdfzJA?=
 =?iso-8859-1?Q?IfLV+NfZXxspjG71yB4Om4rs9NbJaSMjI8vWqHynqwVdCXC0tKwoCR7Nv8?=
 =?iso-8859-1?Q?viYIOaYz0KkUSqsxm982flG6ldUUmro6n0bGUslJ6H2IFCvMAUizw4iSl2?=
 =?iso-8859-1?Q?BREyBvwRLhR2RVEHpmnEAN1K7camhpgMv+l4m5gcRT4z4qZZ+cEpKzPhmB?=
 =?iso-8859-1?Q?52oQdUFxiRtmidgLufc1OulYLyzVjknyaSvd6w99ij+xeL8cKDSKcd0jtD?=
 =?iso-8859-1?Q?L/SqJ7i6CZm+SGU7vYlBf9l67nObAO8E0YH3StkwEUklghBV0NtMhGSzOF?=
 =?iso-8859-1?Q?DDUQ2tTEyZq5uPZgL/XMVqbfIEv/Z8lQfEGZ+ah7H0Zn3jr4AOa8H9qx6a?=
 =?iso-8859-1?Q?REbzz6LsukJEx4tNkAtnJy11TzjPJeBLAo/SLFAAAKa+SnIpwgAFZgmEbN?=
 =?iso-8859-1?Q?wcyqxP685R2EJOccvaUB/NFqIWadx1dMh4SK9hJI9eofySZbovJwql/osP?=
 =?iso-8859-1?Q?5YrIdNxlqY9IaeyuY/sJUGxU7qozQLdKdi2Le/5bYGB7UYroim6RdWKwXX?=
 =?iso-8859-1?Q?5MZniwRRvSI6Xogeb55CrdSSN3yn4Fdx92y/g0si7uHfLeopeVNiDTRDAa?=
 =?iso-8859-1?Q?omTmAWXnKsaCNI/dyddB13S0xH+VSU96TBHdZVleFFSdOf6G74bCjkyAwX?=
 =?iso-8859-1?Q?ddRsh57xQJqB+OpzyiuZ0zq0AgePQOwdFYBdknWiNhefInQC/lZEBwODr8?=
 =?iso-8859-1?Q?QC4z1S96q1aNBNq+KTT7LTQgyB1vmnTEdPGt1WzOa2UFmV0L9kh568xXMb?=
 =?iso-8859-1?Q?PteCuLYlKjzyU+QLdsvRokF2UcgZM0WHLmaEu5uEFYtThRTzU+QzqBrut4?=
 =?iso-8859-1?Q?nqKm6gtOeeTBM1k2hTlqjrO0+WpPT6GGdLDeR8Le9zImlzlT9UCEtqSPjB?=
 =?iso-8859-1?Q?NmTt9mqLN/OsEYxJAQIYi9OqYB10145Tuyy+7pcS6eywIZXoW27gf+o6fI?=
 =?iso-8859-1?Q?VSZ2xkBxI9qS48VjvcJ7XTN4LSdydOL/nEabN0UWYotcTBjHR8JGi+Fcw1?=
 =?iso-8859-1?Q?kOvTBsHEc5fg2CJbq4N5YFy1PstZe0IZWn9IXFConoPg0uP7SRIvmhWACU?=
 =?iso-8859-1?Q?i20/hZOHoAy6oMLn84Ylaz9pMFDyNmzFAhFfq4l0RjX9gdIX2dtzRUykmt?=
 =?iso-8859-1?Q?O/q3JR/SEaAT98K4i9Cnt6BAjCuhpY0MSiV0PZbM6osSlNufuMF22yPpE/?=
 =?iso-8859-1?Q?Q77wlyoBgu6qHWXQYIfojQLGC+FJ/ZNn+F6pF7rsAWjdFFHvYdz2wdkbTH?=
 =?iso-8859-1?Q?IwlKIt2kBbprG1lwxGrxXVgYXS+WGHF+n/fbJz010LAy1TEIVl0r5JJYLb?=
 =?iso-8859-1?Q?nqnSnH0yxY90dAicaU2lvD2Q3xhg+lF3zwWArnIf5t//D5T5hyLhdsvpLq?=
 =?iso-8859-1?Q?mM6rGPC+ckBHaaMiv0F2aI5KvSWHCd7sPlth6TolLPvpgSbKiDZQ74KhzV?=
 =?iso-8859-1?Q?Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?vzI3fIC+bweAuytU16E77JkdulBMETRtRLKPO7dXkRp7VmTTKf1D+VSHE/?=
 =?iso-8859-1?Q?86W2uytknA5lh2CVxV++3/V+pooK1nek3zo3X/vn0WZKYd3anYojhyyzhM?=
 =?iso-8859-1?Q?qY9o8EW1MzQDQYKDBYprSqaokV0ds1e9o5dgFUjVkNP5YQheWvrQ0tHAOl?=
 =?iso-8859-1?Q?XgnWT/EkrFwrdKgLGpv4B70N4N7r7CBEbqbPmo1S8aj0JOHSlUdlEIMqf7?=
 =?iso-8859-1?Q?P+i2NoT30B7JmInAlW2Lohf7QWPVHmOBP1h4+8m80iNKhMMZKWLkShJ9F7?=
 =?iso-8859-1?Q?cQXjmj8GUTCT6mZiEq120MASqtMBgszdhzoxzJDrqoLB5mqZavUnDHqmjo?=
 =?iso-8859-1?Q?WFra1Rpc1DXg8cu4lhYFRqCBV9Pn8dMFsqBJv2al8+p4SqqFByVvRHgL/0?=
 =?iso-8859-1?Q?9/cz0DsoDZlsH68pZgP6jXwR2JbJ+S1drEaEUeT4EfX2kIeDaZ35wu5Dts?=
 =?iso-8859-1?Q?Eu+eCjwuGL4KxJQJnriCB3/PVv3DPZ+ZO3lPXqAUDfMiexs6lc6QisSUzc?=
 =?iso-8859-1?Q?PrQmQl7WzU8CbgEybiU1wGwxtvdEeFOSJdxp68/MIkzsB/cFTQrmrqzcMb?=
 =?iso-8859-1?Q?B3AbW98wc6+MOcI1+e2Tr+/cXDWJ/c1Lr2Pn8dpUfpS4r3CyeyAKL+/HuZ?=
 =?iso-8859-1?Q?cZcioXczhi407fkvEvtue7d3kcdNsMUyAknHHO86QBUwgKpqkMCTNdF4Sn?=
 =?iso-8859-1?Q?0t4g91IzKXy4GHdmnSxTNlGVjpHMkH7Tv33OYkoDfspC/828G3TBEPSTEF?=
 =?iso-8859-1?Q?MnR9D7mAvK4cWGhHmPwrmmSpz21kYLVgGQ+CPz4w6eZtBJNHOAKa7ykwlj?=
 =?iso-8859-1?Q?qjCWDJHQPiOm3+U39eQU8bD88HVd6LvQ0ePOOsz3ak5MzDyfIkSqlWLA/K?=
 =?iso-8859-1?Q?qgED0cN3P9EY/uCJ/FVDh9sD5NbJwlYXfAacEOJJS7L3yCVlzAQzKDr67o?=
 =?iso-8859-1?Q?jg2lD3eYU1QGwVwSxYOq8QioIBaqdBAXDdA1KqmnTCw1NaaF2badj+0fjS?=
 =?iso-8859-1?Q?MqIIImq1mo9d/Ijztk8sCOkNZF0c33twReAbFgwwi+ONN4DmxiDzGo3IOu?=
 =?iso-8859-1?Q?SN1BVO4TGg7bszffH1L6LZBBlcnl7AtnfmKWKHxH0F1VZxAuJNX9d+xAzu?=
 =?iso-8859-1?Q?KBFW8XxLQ8km+QWMxRMaExUoElSI2x6HCwICbH5WmUpddlOCnhzYEIV4Xg?=
 =?iso-8859-1?Q?3FevT4nPaRbwXOGXi9xY3bVFbCPlAq848Sawk6Q692xGzWdKGSJTbwggv8?=
 =?iso-8859-1?Q?QJc6YI6KrtnKRuJj1c+kaGqzC9++2cem/Uh96RTzPPGm8a/Xt9O2XMN33d?=
 =?iso-8859-1?Q?MkhdUJwEaffcg9I8rEcu+50XrSX6EQArzxXdcxwM3XTH8FDRGzdUYRF6tv?=
 =?iso-8859-1?Q?pbMWVkl5M8sI+0VMP8JYNJcRn8dqW4CmhTK7qhUOFQVcgMn5UW87+Evw58?=
 =?iso-8859-1?Q?j+QmwuRtPIRYv1O+SUuO6fukBEm31ffXjAnSGUV1KTrdHvVAovi2a6EKh8?=
 =?iso-8859-1?Q?PHlVZdiXSiVTYSpsG6mbUCPDqJMNQedAyW8jqFCFM+lQQbkQGgASWoqNU1?=
 =?iso-8859-1?Q?ELAzchh7Tv9rdV3/0wN8+ZkofWeRW4s7sPe3n4yX5zm6aO0GbCJrzaqzgu?=
 =?iso-8859-1?Q?QZtJs3lUPxZwP6EQ5FShj81BXhuTQLcm/G?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05aafb29-a11a-4010-8195-08dd83586e5c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 17:49:59.0074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yeO/ryXvFe4crup+QdEMLz3acb0NpaEBKLkOk9OaX86SkzBC71eQTh4aPlKEXUgzEb/2qYqKoQDWGVq7WLMdBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6559
X-Proofpoint-GUID: nSbknJBJSOop-PWDGp3YkXuV4lpYzkGy
X-Authority-Analysis: v=2.4 cv=fNo53Yae c=1 sm=1 tr=0 ts=680a79c9 cx=c_pps
 a=i5O+0KHWwz6AHTILDS7dZA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=uOCftd8tdl7IMOJsxtAA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: nSbknJBJSOop-PWDGp3YkXuV4lpYzkGy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDEyMyBTYWx0ZWRfX6I39ayJLZeip
 9xYZgODBSTfG5uCwTuOxE7kB4KjFT5CEv1MWE18VaXV1oxo6fsHIQWxKkZJ+DP5ankS/9lZIa6A
 UxdyYPrz+S4xvMErxWIaLIdxOJKaFO1pH8U9HxAUVDeX7y6YPReXUKQ7cAy8SvSvTLkgcQ0Nm98
 AvRB/hvePCkhblpAXWU8zbop5sIjKR/2oX9y9FN94htP5GVNQsHwahPoHCI5WkSFMzTvE/6CJ16
 flrU9TyQK3XFIzCo1RL0X1zm4vxmKOAdCGpaQVd9nZhIhzyhp/sQ3Zjeie6K3t1GgV2PQly3FYn
 PftB9lqBN4tyAN82aSPLo5P4vuL3isYIL9NnBvak4TwypOxfoTO1DmPQz/+1xhNyCic4zmCs+bM
 tKu849T4FFoL/O3qMvYvuU9Ra+Gp/qa6GgBEUwZGJ72J8a/aHDu0ThmOVP1fvgrejy6sbEWx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

On Thu, Apr 24, 2025 at 06:32:13PM +0200, Cédric Le Goater wrote:

> > @@ -2250,6 +2251,10 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> >           *read_only = !writable || mr->readonly;
> >       }
> > +    if (mrp != NULL) {
> > +        *mrp = mr;
> > +    }
> > +
> >       return true;
> >   }
> 
> Is everyone OK with adding an extra in/out parameter to memory_get_xlat_addr() ?
> Should we take a ref on the region ?
> 
> I think this change should be proposed in its own patch as done in the previous
> series and by Steve for live update.

Yep, I left this one last as I think it's best picked up by someone who
understands this a lot better than me!

regards
john

