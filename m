Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70292C369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 13:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Igh-0004MH-W4; Fri, 25 Apr 2025 09:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u8IgQ-0004Fu-39; Fri, 25 Apr 2025 09:01:45 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u8IgO-0000D6-1F; Fri, 25 Apr 2025 09:01:33 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P2A5JA021816;
 Fri, 25 Apr 2025 06:01:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=O5xoUR5BIg/LTAgak6j1qMFa7+99fQz+U+HScegGu
 1A=; b=GLvUrC6FnijbABU8RQvBDLD0LB9/p/aUKJjDBxPPUYjlv8H3ru7fTZUf8
 X7xYAOXwCmAG7CWROO2a7hDUg/+SmoDF2G6tUBNHCmdUjc4xfc3cLpugoodMiFnZ
 z/Ddfz0BYH5idofRh2zxTaT2HkgmgkQMWa7SgFyDeQE528Sqrd5lucmO4vu+E6EQ
 92UO3dyJ0rdfzjhr1mQLtNOw+Z8DJjayY3r2WkOv8RHG7LzBFZfu8Ko7+Fk5264K
 wZxFL4p0LMZkbEf8H2ejqn76VzN4xkuCoNgRlE7YHPpDciHTdx0f4JvIEvEQ0ZAc
 CAHoPRFe60S8Sxoi9T5Ca7MUjOh3A==
Received: from sj2pr03cu002.outbound.protection.outlook.com
 (mail-westusazlp17013078.outbound.protection.outlook.com [40.93.1.78])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 467ww21ffc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 06:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTa1rZ2z5do4wOaJrEXRL61KpawuEtPBwEQ0wKuZgy+v6MU0BEhOUvF2dleBYNaLMAnkHLZ+rh2+DRSFExiKndFsQqf+U1BDwXwc9exvOl2F5LmV0Y0yb7y2jWRdDy2sV9WUBkG7740F1TbG55wv1WWIgX/gGlz+A2M4QZWVfZ2N3W0wNoUcCyhY4Xpal/fpebcQ/1HuwjAyjObMAef0y1cu24RHZePpa0ByY3oO9FEPS82TRCFz1F3oSoh+Vg5KspWKvVlH8QFlk9yTFoN984iY6nRjyEJZO+MVdkJo18gkcn/U8JH2sZR0666vrdm73IyXtjdzY2TpvDkjVJxF3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ffmt5ZpscZgPGgk4spq474p1LpVPR9kvZJwtgRXeY7M=;
 b=fzZUOTQOwsfxmzTxqRPvvosdqm96vsA3Xv4zmn+3U8cCQebe7U2k1R0r4SY5J4w6fxxMxsMQYn4aJ4IFqeveGkH8uujdNu20U7D/JgUOzsXVOGpwh9Ky1FTgqgqd1ewrZTU/WJPGooqJw18zkMXD6cGEpve4RZQnBhHXC+p2vGvYe5Jc6aqhPPAsSgd1ZvX91wGvZuMzfSLODShEfye5r4Cbck0HsIoM3rdf0zqYiOMm1OYUb1mvsA51HG/N7A9OR85U7R2aSnJADn3nicjkF7WyiBGmruX4ea6nPoU0x0egyAZyPMu9G58AUrwEcj7NzsPlPqQrlut37nV6MJriIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ffmt5ZpscZgPGgk4spq474p1LpVPR9kvZJwtgRXeY7M=;
 b=oCZElB2vv8PlUgA6k1lnMCI3XvcxIV4qW77hQD1TDv2jxVNFNXH20LIzF/gc/EGlNIZ14u5j7SSDDT3TZrnnKKptYpy+GjCt10lJ+Df9frKAb+uT11Ha8Nnt6Ih7I+pQvS2wUbu2vBGZZ3UvRBsPBvZXWBK2F/rP75kTGWQdp6dNgfnTzQ3eFuSiLHviQTau9jcIFFy1kSh2ovbn2LcMepZIcAWVev1VwyCf8wCrIwVrdaWMDIwWWTpYpt4T8+0VHjEqee4rBxgY6b+yoW0N06H6vX/7+VyOu9LL63Z9FYS3lVziH/oPv9EVUsJnU37E+x9Kt29YJ8+LDGPo41iXag==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB8642.namprd02.prod.outlook.com (2603:10b6:a03:3fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.9; Fri, 25 Apr
 2025 13:01:12 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8699.005; Fri, 25 Apr 2025
 13:01:12 +0000
Date: Fri, 25 Apr 2025 14:01:07 +0100
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
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH 08/14] vfio: add vfio-pci-base class
Message-ID: <aAuHk0WEUbS_inCn@lent>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-9-john.levon@nutanix.com>
 <3f53b147-2517-4650-8e87-0b6bc7f36794@redhat.com>
 <aAqyga6DrXMBU2S-@lent>
 <08d7eb98-4d0c-419a-b143-88b7852a62a5@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08d7eb98-4d0c-419a-b143-88b7852a62a5@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM0P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::12) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB8642:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e81774c-77b8-44a4-baec-08dd83f9417e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?PkP/BL9XoxS4ejnqR22TGPv1Lo5a9Ilwn12U6DxDuF+t5AOz6/0hWjXlj6?=
 =?iso-8859-1?Q?Sr6esctBtQ0IH6H+BUsfuWgx3BTMBdU4JngL8RRkdOX+oqswLYBkDMeGlw?=
 =?iso-8859-1?Q?pu1vBoMdzuexO7c8i1LkvzyddF0hm5lHeyKIxwfhzKPpAR+Co7Pl/FRdDK?=
 =?iso-8859-1?Q?ElzUD/d5G2/+l+aiu0zvfUR9JBgOXbZHZmBSWsGTVdwv5R3p+mrZk6nUKC?=
 =?iso-8859-1?Q?zG6GqOuSuvsgyrWowahmj4ROHI1U+OZXvNo1UawILHcqZJPd/AbRibdyxE?=
 =?iso-8859-1?Q?IRwcdfWn9MkLjHus+VNbgntiUc7za28u4kBxsh/KWcp8gIOvNKbDIwrpfM?=
 =?iso-8859-1?Q?nFRKUOz7Kmk1kaKnNuMGLAu4Tn1pVY+Ti+ehG0Gv3Nw5pzPEkEPJga5BPp?=
 =?iso-8859-1?Q?beG56ECFB/8P+i6fatvXKFkvEkMhQVGWf62UVMLaHOlo2kH4nfRSWlg3dB?=
 =?iso-8859-1?Q?3gbqQ6WLWjAAIYNhUtsw2DZ8mO01yS9n2qwnbwx4jt75MAYL+r078rK7im?=
 =?iso-8859-1?Q?+k96IunQCbdkrnWIcFmuMTOb1+ylzXbi8w561tdCPJEZYANw5nV+gxO4P8?=
 =?iso-8859-1?Q?eT9JGWajGCjTKNIktqK0gZv2QdJ2Xn7Jjd1QtW/DQeWJ5ZtKuKuhwXFB5/?=
 =?iso-8859-1?Q?zusirJfkXCOQGfOsn2N+I6sI7jYWUuoRc5GTD6GRfewXixVAyX3EWSlf89?=
 =?iso-8859-1?Q?FlYEUe4XiC6DutooYGs45h2yfnGQmfcbcbZRo2wj+LlbQOcy5s7QqCBE9P?=
 =?iso-8859-1?Q?uE9k/LUlL7oLeSj0voTsMUMYrAo5mzIGrU1JZkVrKaOM8HUSdPPfV0bONh?=
 =?iso-8859-1?Q?PXVOUSyrCmldI/tdbSTSLLbyC1gPBP2DgQaavd5uNpqQ015DV8dnfY6oxr?=
 =?iso-8859-1?Q?CwDoClY5AgDQU7fwan95XiKZ4TgtfwbfQudE0gXcbhDSoTwjtZ259+WUML?=
 =?iso-8859-1?Q?47i7kJGvipzMekBnIySfdg/NRK4L7s86vb+kJEfwZSwDlKPiE+ai8kmxP9?=
 =?iso-8859-1?Q?5MxKsv6W48x4+Q80NSIzzD4BnPvNa7pC7Bc6CtV/9l4R0Qn2GON7DjmkDC?=
 =?iso-8859-1?Q?tHyoAWlAU6feBT8uUF9FmaK8x4Qpw4W3GH23oTNJNV6DD+L9rQZwR+m6fo?=
 =?iso-8859-1?Q?yJ2pnilpk/dO4x9J29Q/H2Yt6k0XQaCQCVqXpIb6MbQ4Bf0EFKImjGFjvl?=
 =?iso-8859-1?Q?ACu51X0xPhJ4bTLnwFxGDYPqZ2gmGrCnITsPkxQEBPJz47gfmh0zxMSCHr?=
 =?iso-8859-1?Q?ZFQjKPO4Ogds/CaxH1s/QFlGUgqTuIMJl3Ez5I5gTrulOcny8Jcg1pVsX5?=
 =?iso-8859-1?Q?/Kmv6i3WFfEWBZNm09BM8XTjmSoVEGbQt0Ppl01w2kL8ot0qpAeAHLRII5?=
 =?iso-8859-1?Q?2VAWnLoVjxeFxtUpDVhzAKO3zG4FflvixsD0fmngwAgi4VR07RVpdLdJvs?=
 =?iso-8859-1?Q?/IdeOwtsk9VoDsh1I9Ap9zbWi5qiM4ouNEb3i/KXjw3WFQi8iOhKu0GQ4B?=
 =?iso-8859-1?Q?I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?qQhVO+12GFqIxgodeVBIEhdh6HiPjBK1pAxJ8DfCZl3a9gj0p8fqqn/JKu?=
 =?iso-8859-1?Q?YJ3VZ3KUCHhZu1UB4fd77YcoIQmfuCt6vQcQCLLj1wlgEp4QUTnARa7wRM?=
 =?iso-8859-1?Q?jivtdxfelO605zWKiIthV98YqG0ppSGkzHbHEpOvkdxzTaXeNEHNG7/vOD?=
 =?iso-8859-1?Q?HN+rHVGrsq9YVvypkLiaQtw8JgrdJDnXRDoFscpTtnpCnRuDLAr4q+si3Z?=
 =?iso-8859-1?Q?dF2PAiiTt1EVVC/rvNQ3clPCcOYzvz+BW+Zcj4FYwMNaaM+VM/lZtpMAlf?=
 =?iso-8859-1?Q?ShJtBT1Py1eXRtDRDgJmBv5cj2pVQ2Weo7M5nx1smGUmILnV1pVBoT9+rv?=
 =?iso-8859-1?Q?0u4GwQkUQCteRUmCqcYFTUv9gaKdvT5WfZ7S7zi9J4uYWWMnrxhhYp/CEu?=
 =?iso-8859-1?Q?RKbsqGAT70WXGTIUKP1gVorFsqe3u/NIgXYoXzgN9cX/gRGv5huXpVp35G?=
 =?iso-8859-1?Q?PtOWc+2pJrHiPMuD2skP2vZJyCbUXvWa/5UncVR+BiUWkQOKuIWVu0Cw5z?=
 =?iso-8859-1?Q?QhNpF4iFwuJvR0dDYZQ9fI9Yf8KVFx14oGQn+iredIsIrKBFBipyGVewbO?=
 =?iso-8859-1?Q?RHWv8R9XHOQq+mdN9VOmi7hbwHjeVwAdLoQIoSv0lDPZ9qJC4d+5qdncNe?=
 =?iso-8859-1?Q?YKuB2KmY4eWTePqfIUq1y7eOK1lwWZxglr/jmZiH8AIdGd8Blo1YkHD/iu?=
 =?iso-8859-1?Q?bOnOmnM+2KrTUZoB070edjHNcksJP90u12jbCtgRWuOj0DbuY6oId4NMtk?=
 =?iso-8859-1?Q?jT4r0WrzLAUx1PyJcH1h6dPeyGry4eBupjf1mtdh0FvrWG155bse2G7GBF?=
 =?iso-8859-1?Q?Cx5Nlkd2m2CLx9wVj4+TWhmKMMxd6UIqoUd0ij5EUCu5CBMhxcYUMlu0JD?=
 =?iso-8859-1?Q?oECdbQp+8F/B8DMKrx3qDY7A1ayxGuKeYcgTTFuuhPX57nBjh0v9VDgJQt?=
 =?iso-8859-1?Q?SFPzKNDW9KdIv0Bu/+R75uVxfxOa3BT+hQtzivje5/7ClhUZMO5uHo89WQ?=
 =?iso-8859-1?Q?/rTBvfqc2R/fud4xUWwBzRvGsp2nBr6SJMJIQ0v4Hc6EM8EBbkfHkPLQ9+?=
 =?iso-8859-1?Q?6kuwvJc8WN1YJA1eMZw5ADW3zfb4nGc4gLa0c9sw0z5iq35LI5L/aWHruy?=
 =?iso-8859-1?Q?CcEUKykzZXkojnjPfI0eIgGSbsHoclN/V1BJ4QhIrdB/CZkbp+zk4sOWeT?=
 =?iso-8859-1?Q?f+5EuDrfWVfSxX+fnzCZx0K0fotYogtmPd41Ar5P9O/5+gkhdCg3aiKxGf?=
 =?iso-8859-1?Q?+qZnsSLXLiAg/qiovsbcNZtB2p8XnJcXQ+4J6RUvEA+zn2yAoxB0JMjmzx?=
 =?iso-8859-1?Q?8QlVmo8Ytz8G5TXm9zDZt7STAxvhZm1J9d1uzI2hVVewEiA6TAdjqd4+XR?=
 =?iso-8859-1?Q?5AjlFnPs8eOEVyB4pWs0ePieekPjbMtNhcaDndjO2M2JaGEzzrdD7USgrr?=
 =?iso-8859-1?Q?b7gq+qiU5CMisvQMZu1StJV/jztXTTOrIPAIOrZNr2DHUPYqi4E1kFf4lE?=
 =?iso-8859-1?Q?nCmcuTf07nOGzYt463v/fVLpZOXmfbYkP6Q0k/4JcHlZjuYtIB7ja4OlPP?=
 =?iso-8859-1?Q?M7SfRrTY/A536lxReiUZvGKCTXSdahd7vdQOojFVypfVdh9mpDfchu3EZR?=
 =?iso-8859-1?Q?in38UWHkLcBW8PVr8EEq3hjm5S8EbzPiBV?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e81774c-77b8-44a4-baec-08dd83f9417e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 13:01:12.7407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CqAOcus7ptOfecbSITBzqSORfWvCnCXzUKy5G6A75j6DnecjPrn1sJUm6O1DyLiGDJp9dpOBUc/xmc8DO+G8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8642
X-Authority-Analysis: v=2.4 cv=BevY0qt2 c=1 sm=1 tr=0 ts=680b879b cx=c_pps
 a=l9cCpZ6fIogKje1+qubiRw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=OKH_HMe1z3fJ52GCDpcA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: LVyO3iJvspMZFEjGcG7nXVlNFpMuhB2J
X-Proofpoint-ORIG-GUID: LVyO3iJvspMZFEjGcG7nXVlNFpMuhB2J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA5MyBTYWx0ZWRfX35KlGF88P3K+
 y2Et4tB+x967SrrbC686Db07VUCkATU21Vl8obieOol9dtHhE66TgFn9l3VpJJAPiC09PVRwzVi
 03YB6xvaFSBxQO8d/8Icd0LBXnJRGuEQDUQ9rjIvNr+MNE8SLLxWENvkh9LTQNMzRNjV8p0znr7
 ITUETAtuhRgwmNNIj8gd4u2a080jfqZT98TMWBslkGT3AcOGxc4oA1r3QOB3+eoyx1bzuwtS0zI
 PgTFND5rzQ2nNYrklzmIzVIiyMEqL/7sV4//51g5dcthybLnuk9TMba6XZ5GKkVb3srsiIU5Qn3
 Cy+BE1dzdd1I/ybzfHQOdIxJNfQoZWDpipz5vho/6gR3Y51fuvUSeNAlP1YRkBBolKj02wk2hlG
 s2HjFUl7UEKdT+NAbxt4AWKnoc1LK7Kh4zDrWjspqB0aY4fxNRAj+upIEYH0LGREcyemux4J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
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

On Fri, Apr 25, 2025 at 02:46:48PM +0200, Cédric Le Goater wrote:

> After this patch, here is what we have for the base class :
>     static const Property vfio_pci_base_dev_properties[] = {
>         DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking", VFIOPCIDevice,
>                                 vbasedev.pre_copy_dirty_page_tracking,
>                                 ON_OFF_AUTO_ON),
>         DEFINE_PROP_ON_OFF_AUTO("x-device-dirty-page-tracking", VFIOPCIDevice,
>                                 vbasedev.device_dirty_page_tracking,
>                                 ON_OFF_AUTO_ON),
>         DEFINE_PROP_UINT32("x-intx-mmap-timeout-ms", VFIOPCIDevice,
>                            intx.mmap_timeout, 1100),
>         DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>                                 vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
>         DEFINE_PROP("x-migration-multifd-transfer", VFIOPCIDevice,
>                     vbasedev.migration_multifd_transfer,
>                     vfio_pci_migration_multifd_transfer_prop, OnOffAuto,
>                     .set_default = true, .defval.i = ON_OFF_AUTO_AUTO),
>         DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>                          vbasedev.migration_events, false),
>         DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
>         DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
>                          vbasedev.ram_block_discard_allowed, false),
>         DEFINE_PROP_BOOL("x-no-kvm-intx", VFIOPCIDevice, no_kvm_intx, false),
>         DEFINE_PROP_BOOL("x-no-kvm-msi", VFIOPCIDevice, no_kvm_msi, false),
>         DEFINE_PROP_BOOL("x-no-kvm-msix", VFIOPCIDevice, no_kvm_msix, false),
>         DEFINE_PROP_BOOL("x-no-kvm-ioeventfd", VFIOPCIDevice, no_kvm_ioeventfd,
>                          false),
>         DEFINE_PROP_BOOL("x-no-vfio-ioeventfd", VFIOPCIDevice, no_vfio_ioeventfd,
>                          false),
>         DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice, vendor_id, PCI_ANY_ID),
>         DEFINE_PROP_UINT32("x-pci-device-id", VFIOPCIDevice, device_id, PCI_ANY_ID),
>         DEFINE_PROP_UINT32("x-pci-sub-vendor-id", VFIOPCIDevice,
>                            sub_vendor_id, PCI_ANY_ID),
>         DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
>                            sub_device_id, PCI_ANY_ID),
>         DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
>                                     OFF_AUTO_PCIBAR_OFF),
>     };
> and for vfio-pci :
>     static const Property vfio_pci_dev_properties[] = {
>         DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
>         DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
>         DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
>         DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
>                                 display, ON_OFF_AUTO_OFF),
>         DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
>         DEFINE_PROP_UINT32("yres", VFIOPCIDevice, display_yres, 0),
>         DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
>                         VFIO_FEATURE_ENABLE_VGA_BIT, false),
>         DEFINE_PROP_BIT("x-req", VFIOPCIDevice, features,
>                         VFIO_FEATURE_ENABLE_REQ_BIT, true),
>         DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
>                         VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>         DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
>         DEFINE_PROP_BIT("x-igd-lpc", VFIOPCIDevice, features,
>                         VFIO_FEATURE_ENABLE_IGD_LPC_BIT, false),
>         DEFINE_PROP_ON_OFF_AUTO("x-igd-legacy-mode", VFIOPCIDevice,
>                                 igd_legacy_mode, ON_OFF_AUTO_AUTO),
>         DEFINE_PROP_BOOL("x-no-geforce-quirks", VFIOPCIDevice,
>                          no_geforce_quirks, false),
>         DEFINE_PROP_UNSIGNED_NODEFAULT("x-nv-gpudirect-clique", VFIOPCIDevice,
>                                        nv_gpudirect_clique,
>                                        qdev_prop_nv_gpudirect_clique, uint8_t),
>     #ifdef CONFIG_IOMMUFD
>         DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
>                          TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
>     #endif
>         DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
>     };
> Graphic property and host device definitions are excluded from the
> base class it seems. This might fit vfio-user needs but it looks
> like a quick hack from the vfio-pci side. It needs more work.

Can you suggest a preferred approach? I'm definitely not wedded to the current
way (after all, I didn't write it !), but I'm not sure how else we could do it.

Perhaps if there's some way to deregister properties when vfio-user
instantiates?

> > > Can you remind me why the vfio-pci class for vfio-user can not
> > > inherit directly from vfio-pci ?
> > 
> > For the above reason: we'd inherit many properties that don't work for
> > vfio-user.
> 
> What do you mean by "don't work" ? functionally irrelevant ?

I don't know the answer to that in general. Certainly some are just irrelevant
(like sysfsdev), but it's entirely possible the other stuff actively breaks.
Presumably you agree it's not good to introduce potential footguns for users
here?

regards
john

