Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433D3C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 19:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uADIj-00086B-0M; Wed, 30 Apr 2025 15:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADIc-0007zc-1N; Wed, 30 Apr 2025 15:40:54 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADIZ-0006EX-9k; Wed, 30 Apr 2025 15:40:53 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UJ40dP013771;
 Wed, 30 Apr 2025 12:40:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=gBDPuFVodxZSeWzqdov9AjdHIbFaNUF+RcewLL6RN
 ss=; b=ihJeowZOTaZplS8OnLWHbihYdtx/yeEZCZqm3Cip7MDlhSOT6XMMaaAm9
 jLGqc2egNHpdiylow6w9SE0oUyrUx74gLB09kzueu8ZC31Z0aDJqki7JmRzYyJxh
 QVUf+PnHtWnGc66amAVn+/ZJ+T6j+8g/54hs5XN25xB7FaRrsdp9xQPPMte5rKE8
 YnMpX+XplaYG+xqkO4pANd+oHwAtrFf50O/96CCzwSA3DXAyxdrhw/1bVkJMVBsL
 c+7A3TQuxYS0wrnRar4PGiHResHvNqNIqQmGnI2zud+AXXNoe5Ez+vw2xTyeoDcm
 e22vCu+GphWfD/m58KaDNz722rhxQ==
Received: from cy4pr02cu008.outbound.protection.outlook.com
 (mail-westcentralusazlp17011030.outbound.protection.outlook.com [40.93.6.30])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 468xjk1pbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 12:40:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeFshofFXp3xxcUUjnuLj1mbi9a6nNPV0RGsRbxI1zBn60KXh/fEyGCSI4gIdJKXbrkn8mCLSCsB4LEfHRgO1MNPP4zg+FtMN5LlMbRg99briaSNyUSspImSGJcL+n1dT6HmK2bo5mWXuAhanzD9gMmt8N/vypEsW+hngkNG7XmGDxsYu8h/pFND74CdTX0Xs58y0NHOfrgjpbrvLvJSguJkJpISTiUeHpMxaYXz/cHGpRCjINR3TVhTFCIbxR3sah9Sv2Oy2kDKJYpiau5x7FK0viVM2r+6mWouecrPanVUWGD0nQOmL2fBAKuKPQANNUg3li2l8MXP6pkvbhi2Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBDPuFVodxZSeWzqdov9AjdHIbFaNUF+RcewLL6RNss=;
 b=WhvvBdjPaHZlZOfbj8EzOpKif0vKXH+1YvsTe6JE4rHw+928RFqvxTIxn8p4nCZNdlVJW1Pyedvvspm3G7Nevz3+XgaEvPMHo1FTLGzClW1/CNDn2Bv95pFzfKp2Bfg6YFr8DdvlVyGRy+GRlaTG0PKpCcgiAXnyMy3HwvLAJLdqALDPa4qwoHhIolYsIYQozk08P8dM5+nuYtJdHJBybVCRlqTx2WUn/w/mwAKDlGnMTaw5tURxXFXRJ2wXNlKHT74fyc1WmC96Tk+3ZEpgS1bgUj4O98oEMYSfqnWO2kB/xlwfahyPEW4y303pJNT1Lt+1BMuCKgdDvomMWhf/0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBDPuFVodxZSeWzqdov9AjdHIbFaNUF+RcewLL6RNss=;
 b=WSAgYjbQikBLdR/6bd9kL5cByotH8M8evvYQHj2wgLii5EAg2H95AdjSybsLkJE6XDlxeVNIs6flUbeKfqYEUIp5fc5o4YjAuP3nBa6SIgdh/aaW/SXPpxi3HMHGCVFpPNBmCOafMyb2PfaFwuE/aS6Z4i3kqMi0FgClmi/8fVM71JqESbLx8YhJXX5fSls6X35cTTRnGV4taKD6cd8qKLOu7m4Z3R+lAhbizAbza1GZNH90/WOCMj15Jt93u1QBJVvaEZLATp9TxiCZHJPe4WplIOMzY9KYmFsQwGIwR8Qu2f3ALoXGL/eF+F7mof70bCv6NFjFLXaErJdTV1fkqw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB9931.namprd02.prod.outlook.com (2603:10b6:610:177::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.9; Wed, 30 Apr
 2025 19:40:45 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 19:40:45 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v2 11/15] vfio: add region info cache
Date: Wed, 30 Apr 2025 20:39:59 +0100
Message-ID: <20250430194003.2793823-12-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430194003.2793823-1-john.levon@nutanix.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::34) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH3PR02MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: 497d9d85-4dca-4772-aa7f-08dd881ee640
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A4a/1g/wtlyzZm1uID8ATEHxJsp7is9uu3tlc0bvRZ+p78vtAHZV2UlKqkAR?=
 =?us-ascii?Q?T09OukfxNTQRWPDjkdArYH4hTpghWZxlrnHPso13spqKp/tx7+zK6xfiiZKB?=
 =?us-ascii?Q?g+MgsMXv2LxbHg7Z4uf5dBTz9DXcS8nPbR0d8rKpTmt/YVHywBes8YwgB2A8?=
 =?us-ascii?Q?qKRIQkuGV8El7CrEB/tuSoaPybfv3yo0SbacHIKH1h6GRkjAJV7BakOdTaBH?=
 =?us-ascii?Q?aGhYAMegJpItxBA+1ahpH0MrpmbT/2jx/lyHAOaqYLES/CdqWViTZLNLPheB?=
 =?us-ascii?Q?/yG+G+6BL/QsQ9O0gvc9lHbjqOhER6nmXwuZUNXijQKqaUD6Y2JkIxXCspMO?=
 =?us-ascii?Q?/haRhWdKUx8L71vVkx4jPs6ks7pxJF0OWuxt7Izvpw2URGKC9EL9syz0QRiL?=
 =?us-ascii?Q?M8Lo/PaGx+rFRpHOoIt679Lc+GCWECeeXZ2E0T+gO5cPJldWjs+/M8GNtszC?=
 =?us-ascii?Q?cJPVn3UZmLehd07n0DJ7Fc4pCrNABgqzj6zeNFAcKOH1Qw1Zv3B8jNlKxzdB?=
 =?us-ascii?Q?eO/Dl1ZOW6s2gdjjWT8At1co87DXpEXhKmxw1ugVccI6qr1IyCq7jeIX77If?=
 =?us-ascii?Q?W4uzp0cjA1gj5uD1e+qeTATqxNK0PwjuQuycpbRn6scxu9nOZ1bR45A1OcD/?=
 =?us-ascii?Q?teerR8M7BaqfJyVlhqK9QUPaC5N2ZkrzoCpWNNbqY9ZPlaBRmGXj4a6lKvxI?=
 =?us-ascii?Q?9BUovBo084XSVSzpIZfR3lxIrP4ncLGnwx6Oqn+Mt8J+itIleecKAFaB1+b6?=
 =?us-ascii?Q?Z44c/3adquQhP2a/qitl/g3Zxv4T7ytaYAXxfcPVDKRtYIb3A1NJXOYEq9lM?=
 =?us-ascii?Q?3Cfxjd03Y4qUx50zSEfW3YbIO6HTR4zPcFuKuZpYx0mqh0lySadq0JRFohQ9?=
 =?us-ascii?Q?OhWnR0u3qIns40AojJ99EbPpFXHkxPn6plglUtjytyVeMDldoIUmIdx3bHiw?=
 =?us-ascii?Q?tu+kuxyKZ2fAX5CNs6xv0N+SyHSkoXyOX+BriX+7E7Zqwy/9dApIU6UdpNok?=
 =?us-ascii?Q?iCzaNHPs0wAs/VfsdfaYAW0sRLPBCIZt2vtJbqm2STzgfy4G2a9TbEBXuboN?=
 =?us-ascii?Q?heUZryPwPt0osHXvACOPmpXIMwq3L2tvt/2OduN6YIRNJhOf8AaoSg+r17zm?=
 =?us-ascii?Q?7zUUC/uiTwktdgl0SPbvrvDsHNcvEI/t0nrIhjQp9yh+lbzhyyIQOKhm6WG7?=
 =?us-ascii?Q?3Qz2UOUUx1/L0pBrYUgDGGRJaOUGktr6jYvF93jc0X7Mtdjtl8NzD16Mbyha?=
 =?us-ascii?Q?ZyoVyLsyGKcDd1RVvTICpvEqz8IEY4eHHCXnvpbofmMhlY3bl8ikRe52aWAH?=
 =?us-ascii?Q?E3tlA+kjqpLKQGCqmY+Vjzjb4C3MNwAIcamkdi56MBLzk7hs63w9N6QhI1tI?=
 =?us-ascii?Q?9zFUyBJRXaSQ86RnWrgv+bHcrNvDmOOGXMxzl+aHh3/2ERCJgQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e19EHRVKb8YwNByGbfNHfJfyKX0rJVr2oOV/qvZFxiCKivf4CN6DbMsJCPGQ?=
 =?us-ascii?Q?w7Cp/q1nTuBxPhWBFimGv67f6RAUhv60hSb6p+NBubiquIEUl+PJRcWE2hBK?=
 =?us-ascii?Q?lUDmleV0ouBAJXK7PD6+cTcx+QGuRdINXNFfEwrBSEQwPIQqo9vrb1gXDf8f?=
 =?us-ascii?Q?5c9w1VCOKr/6+VcHccbriKSp9mWQNXs+ES0iQijudVckBtd46s3/8fVNtt9Q?=
 =?us-ascii?Q?ZgBc5Lgm7Qx2Hkr/VIhrVlntWecMvat4IPygOtzEak3i5+vY013hTpKItQ+S?=
 =?us-ascii?Q?Ot6cEAgiEqvxEehyzmBHazvO6no3XzlJviA4LRqrBawnB3TfRV2uYaAGhkLb?=
 =?us-ascii?Q?OIbKsAxM84XFuY3C0YOz99fgumI+sH60mU6+o1PwWXyigUinZ0b5u6onM2MC?=
 =?us-ascii?Q?+ARwfbTsFX6YCtMpcS5e1mR1yHzslDAlCkRShKa9IVPz7espd78jGHZtCbYL?=
 =?us-ascii?Q?yUrXrrRMnxvPF6uKmzxNI4lfKF6IpxDnjG7NS/WXSxJEEgfGWkO+iGl1YOtE?=
 =?us-ascii?Q?Ds/STS24ezwZVwKOytOVlFR8QGrANXTHU6KqujcCAeLixWIRsOEghGzISWSO?=
 =?us-ascii?Q?xZEnk/1+7mNPvO1DPd+Qb8cna3/sWDN6meCURZwjQnas0+ARXIpqM7syL2/D?=
 =?us-ascii?Q?D68xmoLE8tlwAiEKBgi66RjHSenJbl8mh4bwUOeuyy8MQFV8C9foTYjEJfVi?=
 =?us-ascii?Q?ZF39na3c9+umsJH76c32yUFbvUH4NHCZusWyqdUrczTnM96J+jaWJyDiKFjn?=
 =?us-ascii?Q?Gbmz0fhp0JD6XkcHQkso91sovZJTnPed6VzaOcl6x8Pe+pgfqV97JwYNijGa?=
 =?us-ascii?Q?He6ssxGPELDY5UaWq9/Xwwx4z9Jzh/7iP/TMsDtWeu1N3ljO7xjucSHe/9Iv?=
 =?us-ascii?Q?ku+SOwCL485yI1j2Yhj2mkkMWM6W1wUcvh+Y0BWzCY17mryPw2MHSCAPGDUq?=
 =?us-ascii?Q?h6OIQPg+9IB//iwqDtKdUyE6yh9hclUgAE0JpfxIvCvbIm6Y75ZDJemFJ8R8?=
 =?us-ascii?Q?+fnYGZwQS/4iaNjZqZzO1G8V7Kd7zp14UXXKYpnoT2TYD0bEGhm9GFESFOOd?=
 =?us-ascii?Q?9zGs3HEWexXzkWQmi07ZIbBudukGTEgjR1EN6OYbqpws4JTz1tpP+XFcurzj?=
 =?us-ascii?Q?SFdMreClqtf7BWRdYyE6QDmE48nn0FsWkymJeWONsT7BQ6415fDPkKLbANj2?=
 =?us-ascii?Q?hkee86y7NPmzbW1Ico9UKfvfmHVglL8NpONvt2ju6oEOC5mYjIGGDHTy8MiX?=
 =?us-ascii?Q?Jrw1pEVeytMs+YvB2SnB7tlbUbGoYQ7u5kT+IEdEE6pboRvWztz4fvd8QFvc?=
 =?us-ascii?Q?BC/wtA2F+an0EErsSugok1c+2rU2QfqQMvJaa8KITVFBNKNLuD0ii/yvKfdq?=
 =?us-ascii?Q?BMyv8kQI6Uq5ND4dUrlnfTQXGEpESH3HCn1zo2TiSNBZDnOxg5zTiY4wG7dN?=
 =?us-ascii?Q?+461039ma9BZMZTOtqjBF743aNeXMMknjyLIRiJFsLY3muPmzi7Q/I4CZwZO?=
 =?us-ascii?Q?CJIXLqXT5z4bEFBs0eeKkbHxYoXgry+ZJn6YvMaq2iY68FVL7dX3iT502Ht+?=
 =?us-ascii?Q?nJZo3Tv0ACxMJScRNiaya0MqST2WzFajx7guhir4?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 497d9d85-4dca-4772-aa7f-08dd881ee640
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:40:45.1907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APSVqZVwYdF+QGNgtLMSnG9GhxdnYjzgAGOD7/G/vGx2nYePB0F+Bm7W0ml6to5NXPtWk8VTfHLKGUWSV7yThw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9931
X-Proofpoint-GUID: y4dn0ho1CDKWENFCCVbpbL5jHg6ZRE5u
X-Proofpoint-ORIG-GUID: y4dn0ho1CDKWENFCCVbpbL5jHg6ZRE5u
X-Authority-Analysis: v=2.4 cv=RcyQC0tv c=1 sm=1 tr=0 ts=68127cbf cx=c_pps
 a=yZcDG7BW7OBBh6O1hU8nvQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=l_MCg1Kh9GJPLq-LlQoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NCBTYWx0ZWRfXwnq6P3UURvYZ
 I2MusJ44ucl378mHJ2k5tnzh6rnLLsLHJj2ARnUqK1l63iD8fsVVXhyCBOYOe+L5hNZpTS6jfMl
 H9QrDBH0TwLbRNwAf7XAeHPGHU+colXuRoej/0SubwCq9HXJMmA1mgWB7UrQZkt7Vitx4L91H3I
 r5qZW45oP6OLl6scKcD5dTHGekSLyRIxiGUkrNOI4BXhf8ozu92PX/yRIt4N1/zGtHU/GhhVYH2
 SIy7oa93eexCseVzHRaMIfRVhqI0UppnMwBhx5E6mu1hHkClXRB2xAkjwFlwKFswPybufXsT/se
 4pKQbNgFm6jU7hMF3roE/2Q++GHCQVh2j0jEhJHYVcqQpUoNO7muQesI1kdHXxrMHkXD+OXFa2y
 BcRFyjp8h7PeOXkamS0kvk4X799AuAZGBacmBGk3djpPneZMQ+DrQ/0FIcYosv8q8laQO38k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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
 hw/vfio/ccw.c                 |  5 -----
 hw/vfio/device.c              | 27 +++++++++++++++++++++++----
 hw/vfio/igd.c                 |  8 ++++----
 hw/vfio/pci.c                 |  6 +++---
 hw/vfio/region.c              |  2 +-
 include/hw/vfio/vfio-device.h |  1 +
 6 files changed, 32 insertions(+), 17 deletions(-)

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
index 468fb50eac..d08c0ab536 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -205,6 +205,12 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
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
@@ -225,6 +231,9 @@ retry:
         goto retry;
     }
 
+    /* fill cache */
+    vbasedev->reginfo[index] = *info;
+
     return 0;
 }
 
@@ -243,7 +252,6 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
 
         hdr = vfio_get_region_info_cap(*info, VFIO_REGION_INFO_CAP_TYPE);
         if (!hdr) {
-            g_free(*info);
             continue;
         }
 
@@ -255,8 +263,6 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
         if (cap_type->type == type && cap_type->subtype == subtype) {
             return 0;
         }
-
-        g_free(*info);
     }
 
     *info = NULL;
@@ -265,7 +271,7 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
 
 bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
 {
-    g_autofree struct vfio_region_info *info = NULL;
+    struct vfio_region_info *info = NULL;
     bool ret = false;
 
     if (!vfio_device_get_region_info(vbasedev, region, &info)) {
@@ -438,10 +444,23 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
     QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
 
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+
+    if (vbasedev->reginfo == NULL) {
+        vbasedev->reginfo = g_new0(struct vfio_region_info *,
+                                   vbasedev->num_regions);
+    }
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
index d7e4728fdc..c7db74cde4 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -191,7 +191,7 @@ static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
 
 static bool vfio_pci_igd_setup_opregion(VFIOPCIDevice *vdev, Error **errp)
 {
-    g_autofree struct vfio_region_info *opregion = NULL;
+    struct vfio_region_info *opregion = NULL;
     int ret;
 
     /* Hotplugging is not supported for opregion access */
@@ -355,8 +355,8 @@ static int vfio_pci_igd_lpc_init(VFIOPCIDevice *vdev,
 
 static bool vfio_pci_igd_setup_lpc_bridge(VFIOPCIDevice *vdev, Error **errp)
 {
-    g_autofree struct vfio_region_info *host = NULL;
-    g_autofree struct vfio_region_info *lpc = NULL;
+    struct vfio_region_info *host = NULL;
+    struct vfio_region_info *lpc = NULL;
     PCIDevice *lpc_bridge;
     int ret;
 
@@ -532,7 +532,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
          * - OpRegion
          * - Same LPC bridge and Host bridge VID/DID/SVID/SSID as host
          */
-        g_autofree struct vfio_region_info *rom = NULL;
+        struct vfio_region_info *rom = NULL;
 
         legacy_mode_enabled = true;
         info_report("IGD legacy mode enabled, "
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index bbf95215cc..1aeb4d91d2 100644
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
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index e89ed02c0e..b4a28c2a54 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -83,6 +83,7 @@ typedef struct VFIODevice {
     IOMMUFDBackend *iommufd;
     VFIOIOASHwpt *hwpt;
     QLIST_ENTRY(VFIODevice) hwpt_next;
+    struct vfio_region_info **reginfo;
 } VFIODevice;
 
 struct VFIODeviceOps {
-- 
2.43.0


