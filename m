Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F6010F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYc8-0004qq-CE; Wed, 08 Apr 2026 15:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wAYA3-0000jm-7a
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:01:59 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wAOlh-0002pe-0C
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 05:00:14 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6387KFx02163310; Wed, 8 Apr 2026 02:00:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=aa7gEaQ0hVUlYZiie1fIKv8EH7hp+JIbr1G/WcsVa
 aU=; b=CSDUlyWb/Jqaqfy/ZMdm6WeF9MK7YTu8crhrf8HqK1blXzjIPx8LjJ75N
 k4Y1X73b9ws3t86Nmz0P+gE4OmtQJrukUbETFYfd7Vw5lqqs4DsECa1e4QVNbK3w
 zNIiOG5HrHQl4aIH3RMC1ysofRWPV3THGkR0SyXs45NnY5PtYnj2+0QjEV2HrrIW
 +KCTjTQ0wWxZcsi0yvRs4Fl+XXVHipPQ1NvjEwsWiibfnUbXfbAR13tKVIzuiOdt
 olCCqsMdpwNtjqRTMUoQCLfoc/FaKmZIFEmpKJiw47rlafHtrUaBGvIahchK1rwl
 fFdTeKlbNxy5z6gW923g/VX0Bqevw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022103.outbound.protection.outlook.com
 [40.93.195.103])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4dcmt9m252-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 08 Apr 2026 02:00:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEUi2WB+SBj5sVbvXWx2KbSFwWcCn9zW2F/Nmmk7jxpf4WdG5hQlCRWqmdU0HvGJOuxfeX7wB+rGCyoyXjrCXhULZJRGTILJjNmn/5B+U2xn+xgjhZhuiwoWQoXvqFzlN5NTvCbeHzaXWnLTr9k4Fdxne5intFSKCyoyHFN9auJizKi+L5RdR5/J6Sc3xpD1i0yKkZbdmCLvAVI7M0tJE58l+ovxrJT4z+ADHngXhkIlWWnvIm+3+RUMpfWK35OmVXUaMoxR1Y/slhQ8DTo2mOnaEsgHE9CKOWBz/64Wj6eHTkNE9DasGG586TrlyV8AP/xQodxpbyHfbQCUvCtOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbwIhqOes1xkaK7VdGawKvtPJWfeLnbRPqI+tJtWTqM=;
 b=k5GVHxwZ+wroqJvHaRkA1u5LvW24C4JB4XEupTNohfsMkx1fHwCOxTgVA6ilv/ChsqY8pcRHws5NM2fz9wj+ti9Yh9/WhaN1XIwTBvAvSrD99sQ+TQqXa0mEP3k/aD1fbfHkXeM3tub6CEgDLWhOUiDn/ye9cVLdPY4klfzvyyMCKkBlTM1WGz8J+qaQqte6eqTp9tIsj8a7EDmV1TVSHAt14WncAJuXddoth4NCV01GlYTBOoTlEs7GXCKFhMHDr/3mMAKvs6ULYa+Lz7J8VCv76wmkCotS+Bqa+TjtRsGFPoHsso/MUWRQ3/RhNfyxTEsuu0qLzmGFcGPQu9ajAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbwIhqOes1xkaK7VdGawKvtPJWfeLnbRPqI+tJtWTqM=;
 b=s6g3l9vnzs7rpScTtqk3w8451XilIzmbKNjWZtmAiJjngEJhbrIkySUoWdjVXotHZydjQLMi2Ydy5HJjxjgtNLrkHfn0u8rEg1opmOE1QjDK57zzKR/e7QtyrQ/wlrEDrQr265PjdG7qT8kMqk7Yd/m09YI1Edki2/XTFhqSSCwrtUk56jq0f05GtTfF2DcTsNdZcLD1TibsDWzyFYxFVxaItorO5RwUq/iQz62GjEG3Vr992wJC1HJVTeki8L6UIcyCjNGFMpMjfn4ae7vNNQsCbZSxgINvnbSL9qsth2stKIA2WkXB+Y/EOG+ugmwHH2vDup6AXJA4wlMX7J6D+w==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by MW4PR02MB7282.namprd02.prod.outlook.com (2603:10b6:303:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 8 Apr
 2026 09:00:09 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 09:00:09 +0000
Date: Wed, 8 Apr 2026 10:00:06 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: [PATCH 1/2] vfio-user: support VFIO_USER_DEVICE_FEATURE
Message-ID: <adYZFs0ef-KiRgOE@lent>
References: <20260317195323.776669-1-john.levon@nutanix.com>
 <20260317195323.776669-2-john.levon@nutanix.com>
 <7493bf1e-7e85-454c-9a17-55febee66e58@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7493bf1e-7e85-454c-9a17-55febee66e58@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P265CA0185.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::14) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|MW4PR02MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: f63b9bc9-d1d3-4350-c96e-08de954d3c92
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: z7Rp6s7wbC0Of77Y5jHpFtTaKdtznmp6M79drZY2UQcvw+IhJr7b9XzGGP6y/Nrq/E7tdliBjJMQrM6loa2LrxjnuWw8SKujvxju7CLCx+5/ouAtUNIKc5mobpGK/mBC789posWbFT8AlXscBUzrvCsQdyAhtjWRfNh+ATzQK9ImUR/2Wjo7CE6TktxC5NsygKJPuWr6BYHc0IJHIrI6oKb9LnNfzJIAHYPqXLveXB9zWOlOPO3vv3fQqrYyf4o7SGRv+gkEHpALj4I6djeDZnjcb8XJBTLil+DFrA1mgPCQuQrsmzWLalcQsMVN0IN7L8t/pQgNK68KYRO90cgxYaJEmFtZDycCVo95jPO0Jdi+bzwNFxvFsMemwFy7J7na0pBSmfToDxo8BHHR3TRjHwx380zVee5CSXrQPrqIfS4LbZEi4hppoNZFE4sevTfkwmgJLCoD64JKe20z3+VfIEi+1IXZ0X9Prc4NpD6OVBOE+jac3o5Hjxlu7yWCrwo3yy5BJ4ftGG01YrB++dFAczJnwEXJ1s8OmHP5zXn3XemYAU1aDWKnP0QrHlNBE2vIQAYYmUA6OiSv7eTt8j1A+drFulCUtvAhDyeUvWAbqt7l1VrrmkpT35LJjcYKa7Z1aug1Fi4jWmeRNQ3iGorjM+Cug+B0ANAWAVtIU2U4XuqYLbQrw+McnNfuwWaI4tdZzfYZ/rX8+MfpoGGDgCmmztZJ/lKz1D/eLhk27mNwCb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?C9uFeyIaff4TC91YF70wY/hAsR4D01IsT8U6totXSzLzI3tsQHb7C+U4hE?=
 =?iso-8859-1?Q?MEIlOZDba+qr4OfYGRN1LXLSV6v8q3NYEdlOvM+cuNo042GvHrMEvUqL5c?=
 =?iso-8859-1?Q?oa/38vYPUTVqk2XmA8tDAQw39C/fK97AecxzwRWh7AoYyKQXh5QnoWWDDN?=
 =?iso-8859-1?Q?iqZFGAYnHnOLQQHvT9oaV+o9NIi60zLWKQe496xSoXp4EwHfpPkJjy96LN?=
 =?iso-8859-1?Q?R1HMPcGhiOGs1GFAKjmN+mLLeIE5TDiYVc73F7YJEdiCcwpJnMk+mWRhVv?=
 =?iso-8859-1?Q?nf4BJcd+kuArggo9Fch21D6u4e80Fv/xDBOKhj0gsqpObQnLegg4dGG5f2?=
 =?iso-8859-1?Q?I+6djJ9boQJnQSIx04Fdr0FmYpDDK3bJSh5zRKwp6NkFANZHPWs3b2sJjK?=
 =?iso-8859-1?Q?MqifEKQfahp11r+jF4/rHbT7yvbc3pj9fiHHBINSiP8pIINxu+fHM4T3Fr?=
 =?iso-8859-1?Q?r46OykK5tQlYoA/YHb3i/qLqh1u+JT1Qr9NlKAHcqdbr2kf9eHFjoWHH6I?=
 =?iso-8859-1?Q?dlbG/n5hZk+GUzegNa8myFg6IdBn7aWU/Ug19So9Q86e/JVlU8sWvHR1rm?=
 =?iso-8859-1?Q?aYHfCOylXEjulmGe2xFEnjfUV37u//Ft254VlkVgydWgK+F2YMeZpfWEoQ?=
 =?iso-8859-1?Q?pNSIRCn5wn/SEPQ1crRDQFH7/R16rYqaQjlxl30oynsVA4+BLbHnXH83Ws?=
 =?iso-8859-1?Q?7+7CjQ4pLcw29YvOb48fBCnbNCUsmyw6tNogmtb7i+PYhdeqnJlt6TQWof?=
 =?iso-8859-1?Q?YJvnmSFLtv20kWNqZbpLNB6eeY25RSmgc5/toria6kDWXxAqbUHT2qOy8q?=
 =?iso-8859-1?Q?o4QAssZH8ZwUpiFD1ayB3p3fGIHsfI1Dj3oRjOO8OLGl71BHyOiihmjI4s?=
 =?iso-8859-1?Q?C+hsYNIdyFZNKcMR26CNAlAYIwspON1NL3rAtWD2pF5z28oBCZy16swaH3?=
 =?iso-8859-1?Q?TAjd9kNY+HhRetpaeMtfaCHZKZztBmv2gwe0vjryVUpkU1+BFJVug+DI/g?=
 =?iso-8859-1?Q?eaOwLx4LYy9N1q5kzT8Gqtq9xaNUTkbO6p1Ok0Imk56Hkzb8UJZPVbNYUd?=
 =?iso-8859-1?Q?nQ/WB0/M7LIOwpsJNZR8ttdUN60Dr/L1sNeLoV2mxgas5cPV1EORVSHEcN?=
 =?iso-8859-1?Q?gcYHVDchjNvZbfhLu1DpsvIrhJGNqLNPRuDe2DZToshIuARlImmpLBQG4d?=
 =?iso-8859-1?Q?Wa1EqLmjadNta3LggnAGn+mTNM9Wpr+GTchhvvaV4TnemiVNEmCBNSeLNX?=
 =?iso-8859-1?Q?hdbuDRxLItg4fpzCjp9Cpz6J9+Z1Hls2WyxB4hWaIYCE30LQ/U2O5hkmIc?=
 =?iso-8859-1?Q?E4pIo/9+T3qY5ZdsKqk6uehWa+GDTSIkKas++o5YfpRBzBGQFpg8miADRf?=
 =?iso-8859-1?Q?aJTFBPt/WqF//YSIs7I1iloJdke4JqOAl1dsbzP2Co8rlpMJjRyYEmm8ah?=
 =?iso-8859-1?Q?UDQmEPWXA7rv/1XLP7wy4DrRnnDLapB0udpB4jxPgLvWen8beO8hYd41u6?=
 =?iso-8859-1?Q?HzuEtqGk6jugJulsNjQIhQW1qA151ZL4GPZRTLTF6diUVt18u3C98IOTKJ?=
 =?iso-8859-1?Q?kFu6GTuiLCdrk7Z4FSWh7+/dkFvWEh96AD1B2+60WjO0N6MLowUQ/5VaXC?=
 =?iso-8859-1?Q?9nvP0c8W1jKsaIqivtEYq8owScZEFeqk1iOj4rASAUkJiFGY0XWVlcOIuH?=
 =?iso-8859-1?Q?4TpLvWhSWbhcKyrS2a/VxDgIKW1CAr2yqsiqJIDOWLrKVXK4DT8zWMumU+?=
 =?iso-8859-1?Q?MqnH7HK5T3tayE6sRbqp3pcFi8ijRiacYCw5kFPplz7pT6tBO3hiR32y4l?=
 =?iso-8859-1?Q?rm/irn4JKQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: cVh1KLnTDh8KljISIyd6PU/2RetlepC3Q8sYh8tqN8/g6HY2gL7E7Jtz8SYTS/chtrunA+oBW35zDg0uTkJVlHjk1d80uNYMgxm8iVF7qDK0rUbeFaoB0dPhMrILzFP9UBrxousuXbeZ3m5ymYJF5VWhAoonq52mdvASeq/vThfw4/dFGCK83nNWlY2Yeo3fk6uZ15M3pcE7WWCKMZdbj5aYXtZMNM7FpWf4hBUu0r+4KYCo3D3WHDEpPp+Zp7YtjlDry3ODTdQfqhBd7MwEEWhmM7CsqDVEMfZIx4QrnbWVk1uury96RQBGVJpplHyKP45FZrmCKD7dqaeiMNhanA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63b9bc9-d1d3-4350-c96e-08de954d3c92
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 09:00:09.5829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LW9N/CrTlY6f0t/RFz/Bmt4r7s0agjCL+8XJtNselhX5GyvBd28uDKsRzU+x5wlDqZDde8TIPrylXoMedXfDVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7282
X-Proofpoint-ORIG-GUID: rH2Lhwr2bjeJSSy1QdpAWP5D-t5bYjLh
X-Authority-Analysis: v=2.4 cv=DoNmPm/+ c=1 sm=1 tr=0 ts=69d6191b cx=c_pps
 a=dTL/NSpv458ZJk1fBD1pSQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=v-0PHXJV_T0_0a0kCZYA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA4MSBTYWx0ZWRfXzIC0XM0tFACJ
 1AoLgNDHaCi32ECHLvSsLBYlGuK1G7/ej3p+WI735VJx7MFXSYxraOnz0DNwIxbEtJy5qgCFDu8
 SDAzhZH2N1/2Z0WpEjzaV8kCY8Gk7ix9qAtRr5RS2bs6365jhXb5TPOWW+Gsy70GO6Xy2VF+87O
 jdx/jfPFF3d/IZbhjFMAwAYWutzoiLFfnbMVqW5O7etZseH3NwhQXY4sllzVqDq8kNJ05VT+c4+
 jwvdc+NgEZTsE/w6PBaFQBF0U1z1P7L1zkMkxgFHO3rAkRTwCAethcTN3INvf39erdiO5AyUJao
 hwMU0rrzwp7j5K/lg6Zy8wB6qCyPrY0w1iCx6/qpai72a2f1vLND6BOP/V9J+6jOJPIXooa0EPa
 NCOOBp0Id1JNXeUOOzR5xlvqKhrLKiprBjsa6+SGByqFJ3DWwXofflzlK2sgTxcjSyIaJZPhYUo
 SV3k2LFx99b1LdDIIeQ==
X-Proofpoint-GUID: rH2Lhwr2bjeJSSy1QdpAWP5D-t5bYjLh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 08, 2026 at 09:42:30AM +0200, Cédric Le Goater wrote:

> > +    if (msgp->hdr.flags & VFIO_USER_ERROR) {
> > +        /*
> > +         * Client expects ENOTTY for "not supported", but the protocol may
> > +         * return EINVAL.
> > +         */
> 
> Is this errno tanslation due to the call in vfio_region_create_dma_buf() ?

Yes.

> EINVAL could indicate other issues. Is is safe to mask it ?

Yes - this should only occur otherwise in the case of incorrect protocol
messages (i.e. qemu bugs).

regards
john

