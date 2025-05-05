Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E82CC3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 13:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBvqZ-0001No-IL; Mon, 05 May 2025 09:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uBvqT-0001NP-2h; Mon, 05 May 2025 09:26:57 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uBvqP-00074s-OQ; Mon, 05 May 2025 09:26:56 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545B91fT009131;
 Mon, 5 May 2025 06:26:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=wbJ+rLikF5RAMwLwOBjaQWDD9p8lTwwoJ4+ebpBF5
 Pg=; b=CBI7cy1xy3Dybq74npCt3933ph6G+6lruvMQG9MobtsG/G/UpNth/CwG0
 NF+Kxy1IfkzoKubf1zhXJAkc9ufJa1Ed4gtT1wwzN4NMoViQDDRT/Bx0yfZXcHNL
 6ICLIa5aCXk8t+1iNZ/tSTz39y3Ys+RqFWA5zJrBEtMmX++ay2EFo3Q9QItgt8U+
 6P8fy9adUzZJNrmjRQWAo0IUkN3BOn5pXR0iwrpEODv1Wvn00rz05V9C4AxmWOV5
 AOwYX5+YWATarSQFQtHuEbYj/xvDnrBpfjAxI/XGg0I9WAIz2IhGGXMLflJAzBQH
 b0O1ds9+oA+Xv+UR/yPWjqCK8/+5g==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46dffukan0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 May 2025 06:26:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mu8wWA1PgOewmYHr/pIC2CIp/is/TQBIpRX/FaSDIi/26F1ruuuom03O+pWpLnsjsPlqKzgxq3M9HnXphcJKfYc50ETg6SKstB6s1s5bshjGlqF0K37DPWNsaxlB3miulQ0gjMcgpFF6bhGdE9abzk6RXx6d7M3QASYyBt4yVsvFOpEGH+k0ajkiOLo1J0/E+3FZSqBtr9oDzdtmHif5zUy9DsoXzlSr/OfZ4j+kcUKLNnZJzniA+FlB9MH8/0FnIprWx7gphc7+ZO8otbT57NU24+4ljLuoZsno0N6J6FvBxGuTAqGgclo7JQ0+xElU6dHyb8RpilE5Tt/j5WZcDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=217fQLRC06nyhEphD8AeA8K8xyKVzmQeP0D+sjFhfXA=;
 b=hDgN90nhLPaW3KUJh40SKJ+oYaQaEaEFGzKj8s87iu34uefftE/VoRWvWksq9lIGcGiHKAfmnQvKnsq2Txo84l8+QcFl+H7IqmPJds7mMeasMP7QrAeNd7x6XIOxx2gOM5MBxah+/GhrVe259xfhFIsn4mzsq0KgREbI4S5b6uLyrIQ4BliBY+K+3dQlJllXoNq4gPH/US/moBRc59e7vrePpmIJfTxaW92GtyE7UC0L3YgqCWAkIHlG6LLVGbS9X/nuSBxRhIW6xxj6FDEZX5ClPFKDmEj6yxQUu6fP/9dxxyj6gckO1qe8TdcFwAcmOJ3iZi0aNtZaZwF7cGzplg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=217fQLRC06nyhEphD8AeA8K8xyKVzmQeP0D+sjFhfXA=;
 b=JnM/z1XKQqeeBg8T3cYcsEiKFSbL82g5xHmdJ3XaSZGzZ0Usn4C7u3rTqjIiVwiw6cxHb5SgoLs7BW17oHYwzsucaRpS9K/D3Icx2OeXR+qRSE/7348P+lT4OVy6KwL5F8LAav4KOMP1AswrIm2frCHCfBTf0rt6YdNO8P4DjU3mUrdxhXcMpyUsEJkVNEzX5AzSzXjpDF3Rz3lI5jMPbDHteaCT8hsaG5YA9iifAvTM+7Gp13NvR0rWfhPvcrtXbadEUghTE/OT0Ce0r9GrTOn7vioTjnRzCf/YckrjGwwto08Hb+laVY+UOWBg0F4gsGzmnR2TY3Y898SXPkikUw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8614.namprd02.prod.outlook.com (2603:10b6:510:102::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.18; Mon, 5 May
 2025 13:26:44 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%5]) with mapi id 15.20.8722.011; Mon, 5 May 2025
 13:26:43 +0000
Date: Mon, 5 May 2025 14:26:39 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 08/15] vfio: add unmap_all flag to DMA unmap callback
Message-ID: <aBi8j0sM_VA0StmY@lent>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
 <20250430194003.2793823-9-john.levon@nutanix.com>
 <bfeb9363-a33a-4a2f-b0e9-115beebb1fbf@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bfeb9363-a33a-4a2f-b0e9-115beebb1fbf@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO2P265CA0294.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: df75ecb7-0b12-4494-6f8d-08dd8bd87a15
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?sKI+92lw616WDtr/MOe1TVux0lwioEn98y9/M9OVolyK9LbJBAylpUOXin?=
 =?iso-8859-1?Q?bwKZX4mE0Dwbhlx/1VSgJos/9T4/ubXuwyqzS02jJ+W7+TS2aq6j+BF54M?=
 =?iso-8859-1?Q?a3bak5CxIC+Bn5QwMGj/jRsjbZyyrP6r5rEe3rfuEl8dU5l3nWvHeTrXrc?=
 =?iso-8859-1?Q?nCXQhc6M5E9qqN892qYMKCv/mBpHZ28XeBSeK4KmCqXDL5ak/mQ5Ft3PRa?=
 =?iso-8859-1?Q?f/Up//c0kZv7SxQ810YL5J2W5iQ5DH4yrPKDxodzFKbJlpGWchIlINgL5h?=
 =?iso-8859-1?Q?1b0m+TajmHopBpR5n4slWst6wG5RRdejeN8+2tZYJ91qTynOJ0Lu0eN28K?=
 =?iso-8859-1?Q?93syVVF/OmywcKHXmT4d1WJrMvVXjHPvlbhD4oKS9Opw6jpHMCeoFPsir3?=
 =?iso-8859-1?Q?r/ZZ0YaRnXYpq4hYlFlAVlnGW0+HmopQLO593VvVjY2r0sQyS6q/eOwYV8?=
 =?iso-8859-1?Q?n0wJzVURG4thYKuaZvyKe519npn6udTC1Fczp9cjMZlCgKFY5KTPr8cpQQ?=
 =?iso-8859-1?Q?9UkUbOTCD2mXg9k99dajFhZfcyUtEj2gNoc/L2uFcWOdwFlEsqSs+jEOO1?=
 =?iso-8859-1?Q?kny/xTcxgTlXPTMvHrmIAcgkOKUriBSk3PhCk3Wpj45KgRqgvZs+qHGLWq?=
 =?iso-8859-1?Q?ce5bpbYiApDxU9o7OnVnjfjCzrPRnkRa5l0vksLcnWdCeYDmi5RhdMxBmJ?=
 =?iso-8859-1?Q?xcH84hKy8yCU1yfNyj3bmxCBlh6Vdbo0LrZkdc0Lz1e2+3l0LyJWPTxFjF?=
 =?iso-8859-1?Q?1RdhWC15+H1xGNW0KaDT9mWM/1tu9EjwzYLhEA+LA4dNEDOJJDA3j5OqLV?=
 =?iso-8859-1?Q?TY3l9RsT55SGQiCW1hrEGv5DsyA/l93G4NBfuPmdv+DFUTNUnSOlOauWIg?=
 =?iso-8859-1?Q?1N084TXUodV6Y7mfLB9fSMpjVc1gDRbMenL2iTOjDQtbzJQtF3CfDcxsYW?=
 =?iso-8859-1?Q?erNxy6eOLvr7k+QZmXOmaiWRpcDBLj/ZeFYEl0+x7ZWwtpmcywaEjsFQKI?=
 =?iso-8859-1?Q?4gcKiBdrcbXGGLiVwvC8X97nKaBvdTwvC8NuUPl0tGpog+SMEfIvxLo4pe?=
 =?iso-8859-1?Q?28q1o2977VYJX8CT+rU2Ea7QDhBoMHZ4hx0ktiM9OKOayDozdlkpZyA62A?=
 =?iso-8859-1?Q?BHus8kofbreBESCos4K0eS4/Qxj2IcJeo3Eu7YUMYb7EOZfCVTV7pzeGTh?=
 =?iso-8859-1?Q?8T3l402q39FRhHFRQ8QNthjT48fzTVvNcWiBGt4TK9Ga9HDPEgyfW/uHi/?=
 =?iso-8859-1?Q?oggaMoK1kwvv9FDQShNuQVGvR3i2KDBGTcytpb7MiYgmbY5SALtbxTiUCn?=
 =?iso-8859-1?Q?lVW4Axtlw3/OOpyfKW2kBPAm8IgBK22Te3Zkq7zjvrdPDpisSrNbRivIQ0?=
 =?iso-8859-1?Q?DvynEAsVYa1lCf3xWIqsfcQZgctrvESE5F3i4LBCdvT2WoJ4VKqzzqvtHY?=
 =?iso-8859-1?Q?vmUOSTaDBLJNLOakQ7Zg1FASCuoT/8mRLBOPEbWw8Ib2SrnBUyJHLsrlIO?=
 =?iso-8859-1?Q?o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?x+CL/eaUaqBHdmBHXXizVxLjM/dHGbc2D50tgJ73Ctu0jUJaykBsl9yR0o?=
 =?iso-8859-1?Q?7J3AmtHgFzTSyrWUs6W9htYZXIt9ELGe6sLxATSaLDADvZMDfKVaiMZ6bB?=
 =?iso-8859-1?Q?sYfEuqsL4hajrUT3/F+4mL0krJbs0NqBlS19o83h+vcF/Dia6i551eCRuO?=
 =?iso-8859-1?Q?U5C57Yn4bDHh2GwvKlAASkJPS+Om9F1SETjp0BeskB2Gx/+CcmKmyCv4tU?=
 =?iso-8859-1?Q?m5R/Hb4Uq4YMTpDKpmaTfm295SCIpmN7xl4uVMZCpeeawbGy4Ov1YnZzal?=
 =?iso-8859-1?Q?aAZ5GkSuGvwZTvhcUG48D9q7y6A1C8PAnxyWGctIbj68ap68bXvC8ea/L7?=
 =?iso-8859-1?Q?z+u00RYlfa31qy4zTL2OfwwMmAkLXrurjWMK9je3PovawixvLRMbwOQIQI?=
 =?iso-8859-1?Q?REgdONRsqHvgkYWtDPkno+jJydICAruxk+6BwjPyXFOUN3yOYZIS4n2fie?=
 =?iso-8859-1?Q?3Q/1zXBYlgZGohmgk3UzQT6j0BCmmv57ffQu/8AmnHbaRWXKIBNTYNzXKw?=
 =?iso-8859-1?Q?cXVnPolW9J4apWtu9nLq/YTZ1G1h6CTV2dDth+RRtXS7x6oZ+f6m54jYbh?=
 =?iso-8859-1?Q?srT8t/8LVseDvPbt02BObt6anDNzV44CWVYXIBNRo6GVM1dvcdjvh7v/Lz?=
 =?iso-8859-1?Q?NNtAc3yNwMyCpJbBetWXT70dmavBcdZYtG6k9Tl3fA0jSh5kaxMil8EhSQ?=
 =?iso-8859-1?Q?gMvzBevaEvuT90mzqLxwxfaHwYsIZ1e+z4nK+lGrlT8jBm25/+vZYIipQH?=
 =?iso-8859-1?Q?Yi2EVG2X0gG03S6+DnfRiUpbja22KZXmHY4hcvP9apQ/JfAFpuGRRyB250?=
 =?iso-8859-1?Q?zCvsqjoOwp6aA6BMg/wCa25TjLNp1oFuwXe6kQNCnTXngzE9rm6kLiCDdG?=
 =?iso-8859-1?Q?xIGZCUZe2fJIGjCe616ovk4575Gk8V94WT2X9rgBaS8fuGpGor9U1egF8F?=
 =?iso-8859-1?Q?teGa8f770mYWU9Mk14r28NRLWRcNV01hg2ARbl78OKHvMFcNJ9AlF0ZbC4?=
 =?iso-8859-1?Q?TBaH+lAi83gax4uBM2r1jnKZ/fGOTUXOqx0G/aDBCatWens+ZIyvHjOy8W?=
 =?iso-8859-1?Q?hYQdOj6Vroe1Eh1QC37NlNFtZ+zWnaz5JFCx6gqvPL1+PSFY46NA4Je328?=
 =?iso-8859-1?Q?OHdGXYgUd8se0eavzoAHMwFSgqUTjqtVAHZ9YZbuVPzY35j+8RWX3q4P0G?=
 =?iso-8859-1?Q?yV1nyXkEB41TMTwVA0yyU5+lRpLW5FsFtN/c9fPWyFotMuDITL/gbAU5TJ?=
 =?iso-8859-1?Q?vwLDU75gyArN9PGG5EYz9rUONOD9MqRtcME5nq2TPYtIpCpoM0qyqRxFNV?=
 =?iso-8859-1?Q?1soxBFg70+rnSMva1bAsrkdD2eHlzFaek03RWOhTWrOVIVBqQP7L4wlide?=
 =?iso-8859-1?Q?52ZXFzZwhd82M/4ylSdqg8nNHYfoEm7TFdpBZGESVJnE40m4Mkv3nSWf8i?=
 =?iso-8859-1?Q?dP6hiMKXDKcsylrhLzcST+nm5S8+iKOrQt4qKC4attAtfoPiEMX2b9r12J?=
 =?iso-8859-1?Q?b8DDQuI/1KyhfsMn0YSwFf/eRWM/1fJFE9Lm3ixBfIVThqYh+lMoAioOT/?=
 =?iso-8859-1?Q?r4yhaVMuvEgqdAJvY3b6oHi2K4vFhoNfANI/2xTbBNHjvabB+BNgRQ0PtR?=
 =?iso-8859-1?Q?OOeGxMIAMD4krW6LXj+6yMOhaeo0mwB0ID?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df75ecb7-0b12-4494-6f8d-08dd8bd87a15
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 13:26:43.8155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SA82FBPEoD4ZLgCkC1uZp/75hbbeyuTM9I+2NE1YawcuguzghzhkqVgwD3kQqM88N8NgXSq7pjtFb6AfQ0Iy2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8614
X-Authority-Analysis: v=2.4 cv=WfYMa1hX c=1 sm=1 tr=0 ts=6818bc97 cx=c_pps
 a=1OKfMEbEQU8cdntNuaz5dg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=TuS_aRFGRke3ED1qvqoA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: LxrNqZvB7BKQogHXfG2woBsaU-Lm1tWi
X-Proofpoint-ORIG-GUID: LxrNqZvB7BKQogHXfG2woBsaU-Lm1tWi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDEyOSBTYWx0ZWRfX3UXVTy1YOSSR
 N8U9IpMOXq990THC+XARlll5sI3fsGxdIDNs8aGj8BGCVv5Z8iobhHNeU3BeOFWCx9/PSsiD8Dp
 HYY1xxUp87vMcjq5svc+SlJbaZprPZWxyYeIKxoT/jWOXdSxtrsCfMxaQqDYgR7jRcICGSjjxnV
 XJJtj+OjJo+sVUEti9ScX6yKXLvwxknyd9DNL+qhny0s7LLXPFQSYOo6KjGQErh84OGl7+WYCDi
 089wbZL5/h2l8FV9exRdcrSCmHaAi2AYEzrEVksUlMz2gzm7Qn98MjZMZcTKP8uDR8E0AIj6yfd
 e12Bq46NqgUUhuqEY+XpcGtHtabGwZVwumLtknBVwxObZJPrYzwc4I3FEwUv5k0PeVWOtyuLjFt
 9/JZZuqfYKYsp/h1rr4WaUnD7Q3t3ML5k+Kgyw+cUQsuEQN1Wutwn71pmyCySyM9HpHLp+gD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_06,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Mon, May 05, 2025 at 02:06:03PM +0200, Cédric Le Goater wrote:

> !-------------------------------------------------------------------|
>  CAUTION: External Email
> 
> |-------------------------------------------------------------------!
> 
> On 4/30/25 21:39, John Levon wrote:
> > We'll use this parameter shortly; this just adds the plumbing.
> 
> I am not sure the 'unmap_all' name reflects what the dma_unmap()
> handler does.

FWIW the vfio API flag that reflects this is already called
VFIO_DMA_UNMAP_FLAG_ALL so there's precedent for the name.

It unmaps the entire address space, right? Do you have a suggestion for a better
name?

regards
john

