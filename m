Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C525CF34AB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 13:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLiVI-0005EW-Ip; Wed, 19 Nov 2025 08:45:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vLiUs-00054t-U0
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 08:45:28 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vLiUq-0003EX-PR
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 08:45:22 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AJ7Kh4c3466374; Wed, 19 Nov 2025 05:45:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=WLAkmEooo6GgA2VSMtI5hS3et8sKOHBLNimG39lAw
 Q0=; b=VO78v8svh2LpteIz5DdVIaUTgXJDg286vH+idWiDcitMarZ4VS2H6Hozz
 yP7dn5+AcXko7xRG52KtP65bfxM07x0FbpSfqyWODd/dAm2Wri79SzrScfRalz7y
 +YZ1BTwNQLoK2t2rHD8NtSla/Z28RFbEb+A1cczRTkG4k462v1Bi1LFZZmRrBS6U
 WGQVaMXDXhiEcjOVQqf9RPH0rfA1Gjzh4I5LWHFoo3E1C8X8YPFvVR4TqtplgsVS
 uYok+E+FYKSgVyiR8TesLOsj7UqXeooq6wlhQV5WbqPipThn2ZmmR6BDVlkz4FiB
 618psSt3Rfht0INaQILrFQDFtqb+A==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020094.outbound.protection.outlook.com [52.101.56.94])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4agb8mcr2e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Nov 2025 05:45:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXZOhWs+ktdh8HnPpRwGPdtcjkYFjqG62S1LhlK8pQvKEd+U98rT097Z6VpcoWvNK2/3klT2WESxXYZ+y5hSBpHia8pnNQOg06LLriF57Q8EvSlPLCNB4UwiD2xM1mNHP3tZzOMBC3jRl3SlReldcJKM01UzRHyfzEZwqDRv3U28AcmAbQEq13UkKKMZiovXMKYzL29wLZs6LpKW+iOPMKU9TZkaRCBSi0CNbS1WJXGzztjysiYr2WWMDBk1UVvMdT998kjBwIfq/mlSQY8o27B18lbK+gTy5IevJczM5/VuOerb2U5+yOX2Iwc3PS75hknZjZNRhxbOwzIhWUfoxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZ+K7v48+UMYpY0lQ7I7XLnI4aXLd0D4OvIi5Jtu6mE=;
 b=MxV1z6rY0Xe3lyCbN7VWSxABALTTVkjV0cn5D+sBkmVJmp24GArzHCkFkT2trytxkfh5MtGFQmwm3SBPn0TrUfakmlF/B62OULiJIZDJ7mz/w0kJOZmPoznMTo8EIKlUTjDvhzEpa0P1zY/CgCJwMei6XRLFCs02lPKDLdfpkQiSXesvF2L68cPskp8B4BWcWktd0eZPbUzOiX/hPUSnNi/fg2H7z2QbqMk2uTkosHNvp7aNeAlXXy7ssJWRqzZA+p4gOqtiNRSeK6sNU9SIgszUQJs/7YJkLF+Q1TQRWD0/Wp/1hNtjporqwgva8n3FHqKXMcOfIZ5hwcwyebvD9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZ+K7v48+UMYpY0lQ7I7XLnI4aXLd0D4OvIi5Jtu6mE=;
 b=qV/Fwmlchrlni/oh+POvGbhfJFhpdDbA7CkcHR6viRv4MySIUTiRl46aeEM9jQV4jmkD2Yw5jPl7cImOQgLG+gbaR7FTc++deSexw1gz9IGd8r+r2KcAvFoVoVREGqn99CjYEQ1B8yUXbXDAM8/eDjKKe/6wW2odUJTuFPkDiTzG5tuNqFsAZiI5EthyS7ckyLKjLVzH52XyF8Bx2YnK6iiliQe1Zq0ArjVbpLWqN7Qf+AMuSqfcIh+AH0KlqsbyhsYWC10wKqEqywam1J8DX2PtY68laZJ4O4R4UBVwPU8R9PUJaBnxHylOp/yMbiDJL6CLbg2JRkulnqTy0CYsnA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by IA1PR02MB9111.namprd02.prod.outlook.com (2603:10b6:208:42d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 13:45:12 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 13:45:12 +0000
Date: Wed, 19 Nov 2025 19:15:08 +0530
From: John Levon <john.levon@nutanix.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 5/5] vfio-user: recycle msg on failure
Message-ID: <aR3J5EuIOiXzIUIF@lent>
References: <20251117155656.2060336-1-john.levon@nutanix.com>
 <20251117155656.2060336-6-john.levon@nutanix.com>
 <aRtGN_Ji-HJDcXAC@lent>
 <4c7c7be5-b1d1-49a8-9a46-89084adefbc2@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c7c7be5-b1d1-49a8-9a46-89084adefbc2@linaro.org>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO6P123CA0060.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::20) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|IA1PR02MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: c60650f6-1d65-4680-8774-08de2771dc94
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?G6fD9cl/mIvCPrzv/wj8BlXq+0fCMd2tIbfPRu4zoFXYPtHGmfHZI8HGLu?=
 =?iso-8859-1?Q?6tCzrG+0MDhxRBYIqk6ON+KLKNvH27gWPESHQcXaSQbqCQiGk1Qay6rRQy?=
 =?iso-8859-1?Q?tsv8hXoBlGu28bCE3axgOPzuZ10hHxIj34U2obo1L2khFOGXPq3V9bMMcm?=
 =?iso-8859-1?Q?5mqmsgGbHerno2WZ/odfGOYQp+rofa1Xsrr8++NxujR93lu/a2Sgn2C/Fs?=
 =?iso-8859-1?Q?Biz8cMltsCUtorlQVOdCHkx/x12oyDHMOCfAB3mycq/cv18xnEnntP0Uig?=
 =?iso-8859-1?Q?aCUX+IHjyUgcIA74lZ0/Y/dZaTCKE4bOeOArpTXm5GYWJcPjVfWu1ANir8?=
 =?iso-8859-1?Q?OGtH5eokDmSKdXdzX1dyOfAa/Yz7c309EboOCKML2eXLn9OfPyCh1HuccS?=
 =?iso-8859-1?Q?1kRu5fQAVNbFA1jrGp5p8Xja7Di1RVwJmloRmqE+SHj9jptqdf+tasNsnl?=
 =?iso-8859-1?Q?S78fWK76sJ0f/zzCPw5yAsvc8Qb/3RqjDND6NrR9WTlFY41Txi0Ndv2l4y?=
 =?iso-8859-1?Q?vwvmWnd8BinhvoXrNNm6fs/PMNjFvEv/HiZqz5hnYZI5RW/4R5iIsm8Xfa?=
 =?iso-8859-1?Q?qK0F4+XxyZWtpv//eZdcZb9hScmFmlvVU6TxvhYtjJPw/Zce2wR01rURsl?=
 =?iso-8859-1?Q?Ed3WY70cg2j4NgU+OFBy5qEZ9vsV09AYV7lx6E4cmgZgNb4pkoXoiwvPaw?=
 =?iso-8859-1?Q?kGNCT5Cd4GtyKMyASEam/f68ltTI8IrpPLEV1g7in7c26kBODWINbE3Ftb?=
 =?iso-8859-1?Q?UPZ1VT9fh+d1qdqy3pgFEa42/vwdL8a/ketHU+v5r6jndecYYWajFZpooT?=
 =?iso-8859-1?Q?9w79xGCyKZq7JUKyCShm488WY8JX8jovefvONeB9Y8Phpqn22TyJR5fnnP?=
 =?iso-8859-1?Q?cMgN+Fcp3+N2lr8askVGznv58SMSOsBVKpe3+ppnhKNrUQiBKULZPS8ufp?=
 =?iso-8859-1?Q?MzmB4YpvszgQu1AtXXYFxc9YeThhMWUNMZCGIivlbL4LdvT27+fjh7n2ne?=
 =?iso-8859-1?Q?HLJB02MIJsPCCPvGxAqVsQRgAFTTV+YtqVxE77qEqm0j+lg33LqtHOgjal?=
 =?iso-8859-1?Q?9z5UGggfJcFZqVSRIV5SZ+xtOY8AVhJnAMrtnvpxj0whkBP74pvGzOg0s0?=
 =?iso-8859-1?Q?gzuPIrKZFiJ7TUKohu09v4vB7mBseeTIesFk/hMbpQxBcf0/fhXH1+Rek1?=
 =?iso-8859-1?Q?CTY/HL2hp2lDidOuqP9hxpTJNHV5G4ZffMBFL3xnsUGdex+0+yP371I/GQ?=
 =?iso-8859-1?Q?oLerelGWYmhiH+IqjiTR/LSKrMTuXaPD4qvr9Eo7mAx8k5Bh2KHUj3/T6T?=
 =?iso-8859-1?Q?u2XlkcCN1aI1y3jby2ra3BgXOZT2RxLmeYGdECIZu0B+0blmM1S1vGu6wQ?=
 =?iso-8859-1?Q?G15D1Kmu3uJ1A1JWbo3NutJQeIkJzI87YPntdGvRQHdZOPOpF3aP3hhPLR?=
 =?iso-8859-1?Q?NZxkXJcrGL0abhxfYUGTdfIOzpBOeuSeLPzB7A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?O3oOYlN7afoEF3ui9xmOtegNliWQVQ7k9pEEg0GgXLakBVwDoCJaX1/hPU?=
 =?iso-8859-1?Q?GlsSQfpD+ILfAgIkKQyLsRKmbGmdYqY1o2WXeOJuMdJGisrLNCF6110dR6?=
 =?iso-8859-1?Q?HIUHd4xJKoje6PakZ08aSnaJvb5RuRILKHkp47159Sv1ecPKZKl6c7Zzxi?=
 =?iso-8859-1?Q?PEv/WwFTPYJ7ho1HA8Uox+whD9bd5GDJfIXAaJpkA7l1OaBsk/i69QAb7K?=
 =?iso-8859-1?Q?1GFr95d76MWYc//+Hhyb9IhaVmvf4gT4EdBoidZFQUUT6UT7N1lZ+XWNa2?=
 =?iso-8859-1?Q?t9KuGkT9wYjumldHtPRPArmlnt5IWeVEqMM2fVrRhGYVFbnsvGGh4+s7RB?=
 =?iso-8859-1?Q?eEotft+NjC+sO5Q0BEdnmieav1A5zCZT3an6FEfzhFlKfXn/5fAevxZBjg?=
 =?iso-8859-1?Q?q+mD5GvS0yslufcq5qj/mUXDRKaAC19garnEGjWDBXeYsh5QzxwQvYiUeZ?=
 =?iso-8859-1?Q?AGDc42tBsJTc80pWRd5IZSdvcrN+RNEVQBXfiDk7jHQ22drS6hkg5zssfn?=
 =?iso-8859-1?Q?0hx/7kUn8qokqfRz8f6iOsE1jQCeN9UCz1KQDAKaE8mz2AkffczY2YwPIP?=
 =?iso-8859-1?Q?fZXNBUiyiNxRL/z6duy3gfvJ62fnSHjz5prBocUzNf9+n0V3TNk6gUPMWc?=
 =?iso-8859-1?Q?b2y9j2qqZvJTomSdoWq4Qq63pVW33jn/oJ7P6DbMeXFNExM2u3SDWKgjUH?=
 =?iso-8859-1?Q?uzBh0cNsrXZ3jxqtSil3ut8IhcGZzxTaE8wDwjHD2wNexP+V7CVjAVvbeP?=
 =?iso-8859-1?Q?ol21V6n7Aib4SEg/Ev1KdFAxqVh0zDrX730vxuPu+ei5DlStxkTZKVH9V3?=
 =?iso-8859-1?Q?43VCXMh9jERF9KlY+esAvbtBWik1R5wbLBTdGfaL/55aviLFsaEt5sZG+U?=
 =?iso-8859-1?Q?C/SddrNnYAQBh8mA8K+k+MSvbkyGVsmoW61KHWKSo3o7njW+c08g9gAuY0?=
 =?iso-8859-1?Q?rP6IsuxnlH11gcTeIQWSAD/3Y7nHIOUIxwba4lyBfrmxqflYncIb6KV5NB?=
 =?iso-8859-1?Q?oDks6CVvyLoEASc0LgYTiGa+50i+aOBm/zAhFqv5XBqw+PIBLiMqXom5F+?=
 =?iso-8859-1?Q?fnVisSmGzk9d93dCb7oSt4I775HNvyGVfwiV2dm3F+W6so7T8jy0p9w6wJ?=
 =?iso-8859-1?Q?/UfbabMsMcAFLLME+27ypLjeHHfFJhHHG96nxjZh74ABjVqlsW+U/swuS/?=
 =?iso-8859-1?Q?CUSp78014SLRB0QKAlZxk2wIoYWmTAaSdtHaNJHBZ7cVDCaGiXOf2eDUQk?=
 =?iso-8859-1?Q?ZbrBiDbaNBS/9nkiK/mtQymnMPGpTPWh6N2rKW9OR1pNr+ehXsv72QhOYi?=
 =?iso-8859-1?Q?GpqGu/BuGKcH+UqO8AbzSIDCRkfWnYLXTZkmUkmwjHjZ6t5mS4ieGRO212?=
 =?iso-8859-1?Q?O8vyI2pzcne0Xmkn5jZFsMo+o7mgzhKvI6o+iOHt4ly78WNEFGqC20JvZ3?=
 =?iso-8859-1?Q?h4AnoMJ9mTrGyIrttlHrbrCh7YEoEGR6ucngND4dz6hCpBmwg9/8oBQ1TM?=
 =?iso-8859-1?Q?WSfsb3fijLt8RfoSwxHM2kUQXRgoMdwngE/mngnu5KnIXvaquUOnLRkjbx?=
 =?iso-8859-1?Q?mv+q7YcgMcHAzBb7/xBflAFzavRZiXAW5FnwU/V/A9uAOBfxcm1BLKXgGq?=
 =?iso-8859-1?Q?Y6ee2xa6+HTDZajbOwN1/qrA4PFbhaTA39?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60650f6-1d65-4680-8774-08de2771dc94
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 13:45:12.2726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjpEoCQL+tjOtDl20l1B+C/G8txGIfmjSt7jyi25AIbwvJJhbH+7+a/6z6ebbXe/JgBM5+3lRwzdZowkSlItSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9111
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDExMCBTYWx0ZWRfX/lScivaUuXff
 FslrlQTerrln5D81ubyiw2Lbd81pumtkUxQFpQnTt+DZrp3VMTqpYFgvZ7I4ZVUey/RfpVkKinY
 4wK7pkIDKLSq9KSO+Dwe+ebGWEX6lq6pHCjcSCBnvYVbMpBlTkkdQTus+D4QD70o6sOyA+e4Qnh
 7nCXdCkfQHOTjtM2H7hlt0AXIyUoRkGfi6jAQOoPN2az6zo5CFUVXd/2hKcLc7mLr7KXcd7ZheF
 LW1PevwAQ/Bu3nPfvW77GjUiAtp0UhNTRi+bqV7Zjcmf1EMhJdzbfFAb2y1Jt5LWozpKZDBDJny
 QGbD8fIn1juJbQWFMq+xp4wfi8VoVHA6pvO+JWy4D2UD3LxgvkJHnxf9OTWvSjv6/LQx/+1e7rw
 vmDmcwjyP0t7rsK4bL17uufae0YcsQ==
X-Proofpoint-GUID: LyYAZQXGgLsibsWNn6ed20522fZWrBDY
X-Proofpoint-ORIG-GUID: LyYAZQXGgLsibsWNn6ed20522fZWrBDY
X-Authority-Analysis: v=2.4 cv=cdXfb3DM c=1 sm=1 tr=0 ts=691dc9eb cx=c_pps
 a=VRpCj/H3b9lxb5zSmaw64g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RQZ_2NmkAAAA:8 a=paFBIIBcpTE99XfgYtoA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=zgiPjhLxNE0A:10
 a=46pEW5UW3zrkaSsnLxuo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On Tue, Nov 18, 2025 at 04:18:00PM +0100, Philippe Mathieu-Daudé wrote:

> > Peter, I did not hear back about a coverity account so was unable to directly
> > test this; could you please help out?

I think I do not have permissions to submit a build.

I placed my coverity build output here:
http://movementarian.org/~movement/cov-int.tar.xz

regards
john

