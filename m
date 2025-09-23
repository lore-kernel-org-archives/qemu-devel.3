Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BDECAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 13:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13TK-0006Eh-5m; Tue, 23 Sep 2025 09:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13TF-0006Dl-Hj; Tue, 23 Sep 2025 09:54:17 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13T7-0003sq-SM; Tue, 23 Sep 2025 09:54:13 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N9wZno611791; Tue, 23 Sep 2025 06:53:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=FigHxxo5F38AQ
 MGqNFaaQpwUhfMucswcoQXtvgGtVwM=; b=iNkaQDG6js4xvBy4c+kctV7wMUT2L
 ZSh0/uGc7flVDtyPksu6gigftuxYvup2b0xwnDT9quMICPghQDcL4gBEzucvUV6M
 El8F+ORwMNxjGTg+Hes4V2YTyYhu35WrpyLri0YFMBNDLBptSUZ31dzmMHSrYE5e
 ncHe6OMpkqDqmZRwr2SmfVQQ98BNcYHBOdcEG50K0uhQN70imS6nIVm83jvHXwHh
 F52b055/hf+lbXvU1I18fftzs/F4uVuwH+/NH66UdEjgBXXn23w5rJ6Uw1dGMXT8
 bwS3Uwi2Vxhg/pWKo5i5ZmtSC6DoAB2gwB7gspxCJj2O6XjfkNpx8ytFQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020072.outbound.protection.outlook.com
 [40.93.198.72])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49bfef9q5r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:53:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jckFCqOzaJ5Bet2Pq1j7LsERmTT2A8MiwAoZhri7bdRl5Kc8qAXNuqT+E2SHImmXp/4l3B+lA01AotEvMXDemV2a6b9yZNk/WJwPpdpdKMl9/YXOPmkmBwjCDvrr0Cs3fkJQsogIAsEPR6mpm2ny2jrTG4K0znimcg1ViAK+EfODF144FNvvWzds1ZFujrgLNWs9oCiE6N26eyce8IF2cdHK3FyxyfMjAHdJbKALUq7UuSfmpRpCfyI4Y9Ne9IYibm79qWCNyadCbdce/zABobDxM4kLyrxfJoPuDTTFdLiw8i+ETj227JYcmmW1ykvb27Sjcki1M+o8lCJUBH9Gew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FigHxxo5F38AQMGqNFaaQpwUhfMucswcoQXtvgGtVwM=;
 b=Gc+N1z0JRot0eUl0EnqpLc0oi3zpl1oGjFMmZJjUg+YcEg75wGN60u3+PtkjHbfbGGHQiq7hVIPjXYXzaNcM6ot7Uz3bgGFCfpyyN6n/BI9y7JxvI69cDH2aOH0aa9yVU6GARa89VkdI7UoRL5dZfNRWcT7tsrtf49YD/fxd7kyuYl53/FuolYor6jUS2AQrKaG1JW0S9VYdLiEAizGybGTg9eZs0nMEWi3gt6pvI3DrMG3vYLOqcddXZJqVwIQHA1DgjOmJ5p+lLHVA9DCmWvbbaXn3fWs2lNIYjnD66tbq1IXdlgvHDKqNiiBk9lgtSpQnypu/qmQubtBz1bKzRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FigHxxo5F38AQMGqNFaaQpwUhfMucswcoQXtvgGtVwM=;
 b=NddNdqGV7q7m4ROuPpV4uNkhPobEuXTPF7s8fZJU75Q5mfGLGbbNbtA6O/B6IghryzfkTFckwGnCeYy8cnP7+hMQOVze7UahJ06813GY8Gd4WpppIVxZByyAkBO6Vfb0dyjgAITSVkoEXaYTTxpZl3LXWlVqAkCm/cF72qWgxVvDgy69kAJfugmeKQKljH1of6OKKvLRyf0miHyPcgyPep2Q2oQVWqnZ9XjDRbMrCt1QAewirANQYle9++xbGEJ2hRGDnA28kiAeG7mkwEvbSXhNv5Lll1zJ4nsbioqOEX9XBvzIvlNCm26COhK0SZYfCkBmUvEP40ZU3ca1fsB0+g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB7037.namprd02.prod.outlook.com (2603:10b6:208:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 13:53:57 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:53:56 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 00/27] vfio: improve naming conventions
Date: Tue, 23 Sep 2025 14:53:06 +0100
Message-ID: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0026.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::20) To SJ0PR02MB7168.namprd02.prod.outlook.com
 (2603:10b6:a03:290::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e19310-8552-44a2-6c77-08ddfaa8a3b3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|10070799003|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CLVYGUK9mTlG5nClaFdHFxYsjjQZzdnb6vhJyiXsyMGbz3sxMV1x50Jh13fa?=
 =?us-ascii?Q?SB4OFVH5K9ZK3qapK1/MtkNXtwBOv4/SPxxE4OV2TyhvHAVL3kKnD2C5yqHV?=
 =?us-ascii?Q?EonDJlT1fZ6/QZQOU9Q94iQslAlKtIc9TShR4eelkTEcurIB+PC8mOrfIzPh?=
 =?us-ascii?Q?grB8XGW9VzqJAFBLEClthdeyzlhTQ4kG4QXA+dJw6u/RHaR+AYqDm4mRH1zl?=
 =?us-ascii?Q?fGtP01a4FCi2qLh3oe9aETJeRuTNVI72g3AvtEq2nZaIdVMuOkeKevBo7TSo?=
 =?us-ascii?Q?kJNPJydxdykON1TudKcKUuoidjvVmQ4/QU+0qNznFNoDXn9MG6lVmuhvMUm7?=
 =?us-ascii?Q?+L+EryE5nKf4pYnDmxlx2deQNsa1mhrbhkApQRM0eUMVjBIhGkry73Lz55aa?=
 =?us-ascii?Q?BNUHPHDFcwiwwojnhybSCYrTjzQkDMxBzs74otDGozSZR07SkcTM4yRcrS3E?=
 =?us-ascii?Q?s5/7KVvcJ9Vn/3j71WC6s9XtIPa7075XqvcHFONU3wD01JPoVCW9wCvYyTMf?=
 =?us-ascii?Q?f0q8M6+6x5fRDw3bfvGdAlmul+28GiSHt7g4kkJH69CILtFBIg2Ei2uiji9m?=
 =?us-ascii?Q?6+bRHGuMhpvwj2jVBDzbvtAc7Ddu9GTNMHQ4WJejlFmQOrJhiBfLR06HxcDQ?=
 =?us-ascii?Q?neVxE+qmMQGNWP8ttPmUFKw2XqQ+G1DK1tNs89eOoPBTHnzBOJI8rq8ttJQL?=
 =?us-ascii?Q?pXmTH4uRTjAFkFOhE47y9ahvT5HUz62HR4Ciyb37ZmjOSsrtfkc0u/pgA9t0?=
 =?us-ascii?Q?mk2mpU68oH3hdCJNdEzC29+q705oMBGHbF9uuCr4ho+qzfVizywp0h1AeLuY?=
 =?us-ascii?Q?0oK1MiFHAal0ZrfOIUxGXczDKRAfkt5gVDB/zzL2APHu+TuZKDmWySBlj+aQ?=
 =?us-ascii?Q?yJn4bbwAvqU+DeAKSwmLEr1t2iUluVF2M4j4UCxzg3zx2w49JbYH1CqmoJPn?=
 =?us-ascii?Q?DxfYBt10fbPBpnkmB5t/S1TMueSMWG8xKhedNFOx6nnRPp/OpCw35ulTskxS?=
 =?us-ascii?Q?HdqVGui0vsatKbhWqknccEBjch10wfe8baoIOwuD7ph2YGMFkumOifRGSbaS?=
 =?us-ascii?Q?mlAuGIHlbDsePlzjVTBVz1IJSboJsBu2Gdnao1pzjzs9j0qAVjiVLC2J9/jg?=
 =?us-ascii?Q?uy9LSy33VvB+NRr2V8UoEnCc/w/lTvr2/igriwCh4AzbxRDE6hYoYn0jwblg?=
 =?us-ascii?Q?ErJl1j4xNteneL5pYUP3WD76ZtimMaNX/uKcFQK32NiIy8s/n7ub1qsTYhyt?=
 =?us-ascii?Q?A/+i9uA4qAFEKKpIYiiI1LNCNZjfLdbGQkTW13qO6xlgLgzlX2CYPtySrQoL?=
 =?us-ascii?Q?mxfdj3qD1xN8ufTZlyZl6tYxkLBduLIdwtcHRurtd6k/qFE3Yr6OQ2uE9rfH?=
 =?us-ascii?Q?RgQFHRYc84PcfNv/QGmePVBoTyee/Kxfc8KDj24oHxisIOmxiWtAgy7u4eeo?=
 =?us-ascii?Q?mj8xJqofyxOjFXVC22MxuL8871j5/kIv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?csH27iedeCa5fngIHsnyOC/SWXuKxHr76VP/iuey81WEVWIRJgysPntYTElQ?=
 =?us-ascii?Q?g2gakZtXahmw8gYBOtbT+3HocQUiB5Vv6bs2WOY5Qjyg+XnreATKLFl4Rtpx?=
 =?us-ascii?Q?G+Fb17ie9TVZOi6NTIi2uPcpBmOYVGintWEDYU5NheoXOa/lprwYpN61wrmz?=
 =?us-ascii?Q?VyF6vFNUM61rFUFoO84JLu7kjXmitgWT5cU00aVoqoBhl2js5hRWL4AW1rfS?=
 =?us-ascii?Q?S29CytJ2EMgvFMzPrADg1VpBcnvWbxiDG9UyO7zzpu/ddyhnP1mJv9Ev8iUd?=
 =?us-ascii?Q?UieCtyVUcpG87Gv0ylGrpj/nfoqbVceQhwymKBIS8WsWzylPItZGdTaZwJQY?=
 =?us-ascii?Q?8DlO0dIS9O/XNOQBBSqdhKR39g6EH3lHh78QVAMDMEL+bzSo2kbFKIDXTwxX?=
 =?us-ascii?Q?FQJU5p4xfALmofBmTj3uDCoOEtvTUSkSSIw88cotyd6a4/Aa3rFIpNIDaM1B?=
 =?us-ascii?Q?/PxxJkQMfrr6aqJVfXX4AUCeqcEr7R2Co90VpTZU+g53uJVdIYWmv6RgUAkZ?=
 =?us-ascii?Q?xK91fxNOX1HJ+1Xy8B8f85T1u+/j69CUMVUhwc/53732bgcejHQa+/OyBHrw?=
 =?us-ascii?Q?hXYw1x7+LGDPPkYgaANwtD9SdqgixJqlrMZ1vG9FSqjBwZh6/UqEj/ZXgV05?=
 =?us-ascii?Q?eHv0NAymwvI8DYFQyWRZ8SlI7p4L3+Q1TPPidI+R0G6AheDqrE8gSsVFNKfO?=
 =?us-ascii?Q?JkWkVyytA++IcE8WEMgx6mjIchvaw6SPJgXUK9ZnBYC7EEEd4VFvTwjeD6yi?=
 =?us-ascii?Q?ckowbDeeImHvpaGA+zXOxWSGmRa/UUX8iuqUsRFjq2D4iyY27NCjsZ1ZssoB?=
 =?us-ascii?Q?O0GN9ALOvtL6xueEGaodorLTQc+vvczku2fzETskZ3fVJ6Szqato8wSB7PSQ?=
 =?us-ascii?Q?TulJvKJJuxzbuHcXfPPXUWEl4hGu4IpWlFwrEWfdiB1healcJ37tvEitbZDb?=
 =?us-ascii?Q?+nB/e2MdWL8efVznHdz+9YimmTkvygYhJwe0+kj2DPJvYtINUmojzKSyaFwT?=
 =?us-ascii?Q?oPg3t2Xx57XYWkPnNJoiO62VlUigNbVxCiv/0p1KTOl+df/Wd9hx75rir5Hl?=
 =?us-ascii?Q?8+kTRVkJuoi3/8Rae7W4MyRwFmWkGGjyp6/vETmVdAy39epWAKFei0sN+Zw7?=
 =?us-ascii?Q?SEujV6KSYvKhQjS+SNF0VdygdRcwP5vxwSZr1kHYixG1sLWe9/6epsKmf4i/?=
 =?us-ascii?Q?eiRAnun1oqYNhTTRkiabqD9qJ1Wf3ZnMHF1CBWZ8meYrKIGzivKTxuUjHOE4?=
 =?us-ascii?Q?MC/Z8kFEKS5+eaEC0TgHu+LNY2UhvhrdfUZZEWGMj7bgSEJf4wh9y5112ap3?=
 =?us-ascii?Q?yVZJ03W7PpY7p7cH2DpIbxmTQNtGRCISZZ9Q+dnlh90eIZP6SN1i4pmEqu1P?=
 =?us-ascii?Q?2xEtYi2DMXuuR3siRBwxIuLqRRWs9l37b/60l9hJISEh76ia2mZB/RpYVhI6?=
 =?us-ascii?Q?xz4bAAoBR+Oips+GO6/GD3SwvH9e65UEiFSL+u2MoVzCr6IL3srKh8SgXy6H?=
 =?us-ascii?Q?oUY6JTd4YNifEdtdD7uQORWBj5spoJmhg+W8OfusUQO8SHwCL7UxvBmtEKXv?=
 =?us-ascii?Q?R1roj+MKbvKWJWgChKCqFXnnzHtpMWPfCnf0h1+46VMB/8db8aeDbSUaNdbt?=
 =?us-ascii?Q?SlqsWNhwBHt3wSQ0x1RYgu8vzZNHhJ5cqH68xaqls7NbkjCANrvWoT+tCUWY?=
 =?us-ascii?Q?mw80gw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e19310-8552-44a2-6c77-08ddfaa8a3b3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB7168.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:53:56.8773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKqA8+3ljzMuJmHmVxWHnkjTNfcLByN/eMVrKfPsMVmN/HpeLMrHygxE1TULlQLxGxl7f/NrmwV4X2HJd7hAg1d7ffSwEHOPjwpUzTkgLEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7037
X-Proofpoint-GUID: eJrhkYHoAuoePsFOz3lw1jjqNer8uC-K
X-Proofpoint-ORIG-GUID: eJrhkYHoAuoePsFOz3lw1jjqNer8uC-K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfX1Srjk+9dPxj2
 AmRoyVs+9ARF+8OPdZVWZkebIDHgW4P4DQwgTT1Xkqvh7YfOglaUpjmFG6RoYgvHHUDBtI0tmc9
 wAYvOgS2K1iWOvpQ2nEkaMe1BMYSFgoxq5uTFDQtY4YIp5x3Uyrxzs+oTZXE4WIpIGqyU/xs3wi
 E5i+0J8rNYvwFj3VVKbYu9JXgi3HPGNzfTEpYrmRa92HDf1iZyKmE4PVxjziS0nontWeB24RQkU
 EoIUh/oIHvOEqIhcuP9oBZuiZ67slmjC4nzdDmHnOPu3Iu4MQYZnKAVq+gJlWaaJlDDeM1Xs4Zf
 aPcz/JHB6DNXgDo/AOJtmT5+I6tFmOxjaQYeaD2EbVjcu5upBHGJVk6wz0usvc=
X-Authority-Analysis: v=2.4 cv=eI0TjGp1 c=1 sm=1 tr=0 ts=68d2a677 cx=c_pps
 a=0/0ATQE1JRcUx1QjezCFVg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=2pCAeJtZ1a8ZLVzE6IQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

This series aims to further improve the naming conventions for some
QOM-related parts of VFIO so that it is easier to understand the
object model.

The first part of the series renames VFIOContainer to VFIOLegacyContainer
as the existing name is misleading, particularly in the context of classes
that are derived from it. Following on from this the VFIOContainerBase
struct is now renamed to VFIOContainer as it represents the parent of
other VFIOFOOContainer types.

The next part of the series adds some extra QOM casts that were missed
from my last patchset, which then allows us to rename the QOM parent
object to parent_obj as per our current coding guidelines.

After this there are some more renames for various QOM/qdev declarations
so that the function names correspond with the underlying QOM type
name: this makes it easier to locate them within the source tree.

Finally there is also a rename of TYPE_VFIO_PCI_BASE to
TYPE_VFIO_PCI_DEVICE since that allows the QOM type (and cast) to match
the name of the underlying VFIOPCIDevice struct.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


Mark Cave-Ayland (27):
  include/hw/vfio/vfio-container.h: rename VFIOContainer to
    VFIOLegacyContainer
  include/hw/vfio/vfio-container-base.h: rename VFIOContainerBase to
    VFIOContainer
  include/hw/vfio/vfio-container.h: rename file to
    vfio-container-legacy.h
  include/hw/vfio/vfio-container-base.h: rename file to vfio-container.h
  hw/vfio/container.c: rename file to container-legacy.c
  hw/vfio/container-base.c: rename file to container.c
  vfio/iommufd.c: use QOM casts where appropriate
  vfio/cpr-iommufd.c: use QOM casts where appropriate
  vfio/vfio-iommufd.h: rename VFIOContainer bcontainer field to
    parent_obj
  vfio/spapr.c: use QOM casts where appropriate
  vfio/spapr.c: rename VFIOContainer bcontainer field to parent_obj
  vfio/pci.c: rename vfio_instance_init() to vfio_pci_init()
  vfio/pci.c: rename vfio_instance_finalize() to vfio_pci_finalize()
  vfio/pci.c: rename vfio_pci_dev_class_init() to vfio_pci_class_init()
  vfio/pci.c: rename vfio_pci_dev_info to vfio_pci_info
  hw/vfio/types.h: rename TYPE_VFIO_PCI_BASE to TYPE_VFIO_PCI_DEVICE
  vfio/pci.c: rename vfio_pci_base_dev_class_init() to
    vfio_pci_device_class_init()
  vfio/pci.c: rename vfio_pci_base_dev_info to vfio_pci_device_info
  vfio/pci.c: rename vfio_pci_dev_properties[] to vfio_pci_properties[]
  vfio/pci.c: rename vfio_pci_dev_nohotplug_properties[] to
    vfio_pci_nohotplug_properties[]
  vfio/pci.c: rename vfio_pci_nohotplug_dev_class_init() to
    vfio_pci_nohotplug_class_init()
  vfio/pci.c: rename vfio_pci_nohotplug_dev_info to
    vfio_pci_nohotplug_info
  vfio-user/pci.c: rename vfio_user_pci_dev_class_init() to
    vfio_user_pci_class_init()
  vfio-user/pci.c: rename vfio_user_pci_dev_properties[] to
    vfio_user_pci_properties[]
  vfio-user/pci.c: rename vfio_user_instance_init() to
    vfio_user_pci_init()
  vfio-user/pci.c: rename vfio_user_instance_finalize() to
    vfio_user_pci_finalize()
  vfio-user/pci.c: rename vfio_user_pci_dev_info to vfio_user_pci_info

 hw/ppc/spapr_pci_vfio.c                 |   14 +-
 hw/s390x/s390-pci-vfio.c                |   16 +-
 hw/vfio-user/container.c                |   18 +-
 hw/vfio-user/container.h                |    4 +-
 hw/vfio-user/pci.c                      |   35 +-
 hw/vfio/container-base.c                |  347 ------
 hw/vfio/container-legacy.c              | 1277 ++++++++++++++++++++++
 hw/vfio/container.c                     | 1325 ++++-------------------
 hw/vfio/cpr-iommufd.c                   |    4 +-
 hw/vfio/cpr-legacy.c                    |   43 +-
 hw/vfio/device.c                        |    4 +-
 hw/vfio/iommufd.c                       |   48 +-
 hw/vfio/listener.c                      |   74 +-
 hw/vfio/meson.build                     |    2 +-
 hw/vfio/pci.c                           |   68 +-
 hw/vfio/pci.h                           |    2 +-
 hw/vfio/spapr.c                         |   52 +-
 hw/vfio/types.h                         |    4 +-
 hw/vfio/vfio-iommufd.h                  |    9 +-
 hw/vfio/vfio-listener.h                 |    4 +-
 include/hw/vfio/vfio-container-base.h   |  279 -----
 include/hw/vfio/vfio-container-legacy.h |   39 +
 include/hw/vfio/vfio-container.h        |  286 ++++-
 include/hw/vfio/vfio-cpr.h              |   15 +-
 include/hw/vfio/vfio-device.h           |    6 +-
 25 files changed, 1988 insertions(+), 1987 deletions(-)
 delete mode 100644 hw/vfio/container-base.c
 create mode 100644 hw/vfio/container-legacy.c
 delete mode 100644 include/hw/vfio/vfio-container-base.h
 create mode 100644 include/hw/vfio/vfio-container-legacy.h

-- 
2.43.0


