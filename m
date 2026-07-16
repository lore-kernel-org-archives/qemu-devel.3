Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7821FC44514
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 21:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkTog-000272-1A; Thu, 16 Jul 2026 17:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1wkTod-000219-4R; Thu, 16 Jul 2026 17:40:23 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1wkToZ-0005tX-Sd; Thu, 16 Jul 2026 17:40:22 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJrZhq1763910; Thu, 16 Jul 2026 14:39:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=GHLOqjnMH8y9r5FKIpyCYoScCUpVaZacIy2XYcBlv
 pY=; b=kvyW0r3h3aNNhak+z7xNhDeshT6QBRTrv7KTB1Xs0NxLXA3GaPuByTAZ2
 jp5PqkJXUL2BRmAeJQvzt3K9wNp1OZyFPCta1CbWt7qlRKyp1Cwxkt3VJrOmfu1w
 o5T+Xsl3XKQ8FtBWP2Nze8D6OUj5CYAx/Ac1IbyO4y2Cwnidi01Z8DHUis5Qvm7M
 N5xbCKx4v082rxulvc0H6rj9vBSKZfAg3vYd7HSpiv+1/yHQ9U+6F8vmC++A9fKc
 XZjRIwMqUgOPIXRYVbDMS/KMSj91RGEHXxSI9VW8MjGR6sIOGXUQY2BmeiY6vuQk
 o8A00GS7jD39cFJKCnwR65P5FQXmg==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020094.outbound.protection.outlook.com [52.101.46.94])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fdstheva0-8
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 14:39:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geDtmpWtJ13uFthMIdMSiR7Kw2AwXOu8L0S6byJL6KZ8399S3LjpCx3muFl5bOxgHQTu2qPNkz/rItFYb7ELvKPZBTduct19RDGqXoIZJ72TFplokPK8tVPARPpym+SX6sO9KDhy+ccgB2CIR0p/v0WOO4LDcG2rgGm8/JSevKYuj5/ZWKkpblEZ9C2cUXZvPJqRB1npgVD8e4RoiTzzhrTiuKwNqkL7+xV5OTYn4lMRHb+c9HWob41ODAGKuauZyrbTDsFn/PeHNdRmmIOTpwTdVpT1Ose1MJPwaNsF/eJyCQNg+jxhJTYzD7TAaPw6Obh/sgpLbU6CrZBiQ/LP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHLOqjnMH8y9r5FKIpyCYoScCUpVaZacIy2XYcBlvpY=;
 b=ssBF3HKsrSWm6J9qOJT8Pmy8bCL4uXeJtRr0hdhL/rmI+IHSarOXs5W0AkehawDXnPh+YXyUtOmsWG3J5Su7UTxo8jVYOfEDg7RSz8Vkh6IB8C9Hzb/F5yZYg/IcG+EEeM5tGNp3RjsDiCQ7C8/J7Z4az+02EJITIq+Sf9r1sVFaYzEhkSge2+X5NtwNNzpw5xwClVPmCrm1lCCtgw200TrSqlS0HhDXJduetaoyxiNEIhDjLtwVkui6ZTO87L7YRtfleM41knYJO/WZLRw+/uFhe0pARFp+ppw8bOaRrJceCxyl5+cbiPxZeFllFcYSFFXYyqknYh/lfOj5TIDHSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHLOqjnMH8y9r5FKIpyCYoScCUpVaZacIy2XYcBlvpY=;
 b=bpt81Aas834R8ujJs8Bxzqa5pyCcZ9P6zUCYGdJv/3OhaWYh6OA29qPJL2XLkb17pK888AqzaWSSZpAgHc2IjIUU0MWs6rD/nItpXLX4Y/bNYK2GxJ8L5d1pHlG8FsZ7td/b+Rif/kxQBrILGQMGezpy8mNYPF7l+ap0EL3JsRr470P2rMOzZFdxjFV5oaQVthNkHeSTFRRoe+qRtIe/JPUiP6V1KwdaSezVlOX49tE6F6oPXnMDkY4FDAj/jyaCjhrGaN25xT6HeU4zaWDlDSZtX3kpVqwhK1Alf63RCEYdc8tG27q+eJe+aPZ5d5jKOaFNE/IRmKGJVs9i82V3TA==
Received: from SA2PR02MB7564.namprd02.prod.outlook.com (2603:10b6:806:146::23)
 by SA2PR02MB7756.namprd02.prod.outlook.com (2603:10b6:806:14f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 21:39:32 +0000
Received: from SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4]) by SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4%5]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 21:39:32 +0000
From: Khushit Shah <khushit.shah@nutanix.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 eric.auger@redhat.com
Cc: cohuck@redhat.com, peter.maydell@linaro.org, richard.henderson@linaro.org, 
 maz@kernel.org, oliver.upton@linux.dev, berrange@redhat.com,
 abologna@redhat.com, jdenemar@redhat.com, gshan@redhat.com,
 skolothumtho@nvidia.com, sebott@redhat.com, armbru@redhat.com,
 philmd@linaro.org, yangjinqian1@huawei.com, shaju.abraham@nutanix.com,
 mark.caveayland@nutanix.com, khushit.shah@nutanix.com,
 prerna.saxena@nutanix.com
Subject: [RFC PATCH v3 07/19] target/arm/kvm: handle special ID registers
 cases when reading from KVM
Date: Thu, 16 Jul 2026 21:38:46 +0000
Message-ID: <20260716213858.609699-8-khushit.shah@nutanix.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260716213858.609699-1-khushit.shah@nutanix.com>
References: <20260716213858.609699-1-khushit.shah@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0071.namprd17.prod.outlook.com
 (2603:10b6:510:325::28) To SA2PR02MB7564.namprd02.prod.outlook.com
 (2603:10b6:806:146::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR02MB7564:EE_|SA2PR02MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: e0225a05-bb92-45f7-52be-08dee382b922
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|6133799003|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: vv2bZF5hqsG9QsKukOY8L3tasYeHtBmPNvL9E3eBydG47BGGH/6/539kRvwC0Rrmpr5lRIunHi6AKdltNo66WBTiXyQCiY82Mk60Vy7jtSCIxoIOwIEoQFJKuua+NoZr6RvR4AU2oo0DrUjZoCJlDD4xWEtW8AY6q4OZ6/MuoA9JsOl6eyNBJ6YXfm+aI0HRBfT5ewTo67L3nvK4HxsWE9pnYGLynkkcb+Ur+5wkqv/ZiSPZ1LrEqrDjw1BNSFQw2mOKideeR8KrmehHoRc+ckKM4TwFPjcO6NMYU2E9g2g0KZvpaq9oSHbk10eGQl1jiRs05n4WdLjfd4vZEfJlgBG7W56QPMHU+RJXjyZe3ih/m4SvMK5eXzS8Kq8PqZ7IMxI9oyunfJ57zp9JXCZWOdoy86xnI6t/+b3cIRye2uIFw5XfDzvPISYv/ljISSypkUYRtUhVKtaOvdS1H4Y2gbb55RWcbxD7ysUnXrcNW4H2uBXH4ACvfbDppmEZlUpKAZgJQLaaxnRH0NXNUtF0FLqiksJdZP9vfT1iBCXPbhIwQuGqU1Kgmk5qZl+i6wJOG+KS9lUt/oIhJeHDuiLryQdN2UvbCW6V+CvoVF2ce2sz0ykikuosdSawrOeqNaDyzVdPhiayHwBqeDqxNZHY5y8+oK9TTKVqKTyu6vBagOA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR02MB7564.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TtkDLjQJ6kPM6bIu1WWwsi5moFgebuKmtvFTh2P7LfRmVfYR2JDtMkwj8yGK?=
 =?us-ascii?Q?k9MS5dC+B+UaZ6EaIpBCLxltc6nEnjyvHjA3ACopPo5Xl9cLXDASh6I59Gzt?=
 =?us-ascii?Q?YwU64+GP3JK1wiGsHT276fc8GNLMyL2ueH3MfaBaXL+pDxyt+w8SxGidtkKw?=
 =?us-ascii?Q?kKyQP2EEXiQLgnMAUKL2Y6cVWZasLUN5+Oo4fR1FCvCZdg6YC8IHWk5QElU/?=
 =?us-ascii?Q?gujonCIafOWuHDzjHbtkpSaKb69/9y+nL1ctwRoU4RiqVVrp2Po+FSIuRCj9?=
 =?us-ascii?Q?evQr3bqYvdQ13i2pgSFd4IED6HT9jTgnjQy0Rs5NIV9Jk/O99YwGBMjJojZ0?=
 =?us-ascii?Q?TWMvQPgGju9LLKFBAtEtUJm0iGdTuJieyD5co7Bwxw0J/LQ/4FTeCB2/Bo0y?=
 =?us-ascii?Q?NKEEWskPhiGXVv+/LNtZT5jJ5yg2pITtCVwQncErbtQ89XNJRnC48S4oAiiz?=
 =?us-ascii?Q?XF54QB1ykpQuqol4+0KlBoGgXpoTVpky4qb/0M7UNt4R8jCcq0cRuG89SwLI?=
 =?us-ascii?Q?/lCLAymScaWhsSPv85MTLH2DIFsxn+MHoM4kr+UaaGRdkjIjAQ6neIclC8YP?=
 =?us-ascii?Q?FqJXYjNtC9rZpJQXe77f3dkl56fseREGvgddB5M3V8oSEgxmg64oIVTnNHWW?=
 =?us-ascii?Q?AGPJqGj6uW+wRPGP7+1xxBXnLmUub1/iP20zwgW/8fEi/ErmlvK5huRtR697?=
 =?us-ascii?Q?zmEm3xGZmRscxNBc7DwrGyQB623lkR9IGI1+A8RaBDLKB/VsinHgvCs66H0G?=
 =?us-ascii?Q?EzaYFt/6ktBwQU8kGgIMsCvid1FrWwmlJhtENXE/f0PM6gwNne2NADsjG9D0?=
 =?us-ascii?Q?UaY2YoffbAINrvmmizIBtap8YOZcphq4RW9NZ9m2a32tsFyj+S7uNcpL4814?=
 =?us-ascii?Q?hPxhZ2+WQdutWyXatqQx57Jgs4XzSItwUdePA/f7+Vgx8qsifDcW4rvh0t8o?=
 =?us-ascii?Q?g5T9A9TqCrnhtkmT21rSOVqWKV+RSHLJOFyWUI8Qk6jZwfye2pdM381A1svO?=
 =?us-ascii?Q?YBVusE1EkWRzwu77BXxEFpUyVJe2jdOjA0WlnBiIOH2LiXFl9+9lNUP9UNPr?=
 =?us-ascii?Q?RDsulzwGgZMg6P207jKF6I1dbyLJfWYJvaG0Ewy1gW796VXjsYUZoQsPTB9+?=
 =?us-ascii?Q?yyUc+GJGwOiwZX5voQTeFd/EsKqXsd0Trz/8XL/7wDIfi8copKuPRYER8Du6?=
 =?us-ascii?Q?QkywqPshTI34mOIuLMgKLWMi9P0whxqs+hX2PM7YMPKu5kJ5Uh/fIa+0pOQc?=
 =?us-ascii?Q?zL7awRr9JlAwIBV2RM/VigeceOCck7TSkvPMP1Q9COzk0oJVQmLKtREP/hJV?=
 =?us-ascii?Q?XtNvJ1KpQK+dDuB62W10pVnzok4Stn3IubDxqgJ33wFrdXU/sgyJvUPBjPDb?=
 =?us-ascii?Q?/RY/JqnB4iHs6J6nFAJsngIBAklN6y8zJB2lK6L4ZVkv2CYXryZ7rcirZyld?=
 =?us-ascii?Q?wJxFiLc+hfDGjGuPYSWxtOohEpd806KCoFaxQAoc/BtmY/uo8att2sYNEcj2?=
 =?us-ascii?Q?ndis0jEJRcU3NvTAIiZ6dI4dvBpS+nJu12QTQDl+fBdwEBtiPBFXdnnrwYPy?=
 =?us-ascii?Q?HbFyJQvqM4rLQR/ShR4m9/lpOpky8C5VFUhMopeAlpzBsUYsHoJEabf7TN77?=
 =?us-ascii?Q?wd8BAGKI+DiEZNIBVdMMiRbaFARoZCHawP5u21wEKDCQQrsjSOucNmSyE6yT?=
 =?us-ascii?Q?QapMER9v/PlxR+Jo7Y1qPrknxlCCPYxHVUynfVjVmuVXW8BVlCI7kEGchqMn?=
 =?us-ascii?Q?jZxFF29BFWt6KQJ3bWl/djw4I44Z6wU=3D?=
X-Exchange-RoutingPolicyChecked: SUdbEH6EmMpwdWhp+fHub7/mLjusU8uZDDyhLvtyx/YRFahpOEh1oU/O/8WV4NKZIZroS1Ll/4iJoWc9m4G3wtXtG4SPMWDULR+JA1Fnj1TyqC9+WCkdqiQgEJD9d40PtMTQ5qRLWBXktk0YCIwzi4FPP9IVSDejjiCYvhscQrCIV9CJtQQhUEMUhu8JgTJ67RorspIU+35DppVOgVX6aCzPQszqBBHx4L/wnb4hD1OJpOc8mQ8eFaHkKSKXfq5/7hDWWft8WARWIcp3g17WNZlZ7fL565EdzjAzsNjiyDDLLxr4OiX5o0UTOpv80HlFzewl6cV1jarbyVBilsfpww==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0225a05-bb92-45f7-52be-08dee382b922
X-MS-Exchange-CrossTenant-AuthSource: SA2PR02MB7564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 21:39:32.5821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKTl/uGeGzfjwih+gpNkZSyT0h4+yD7sMF4mAE8UAc2UcP9SV6IftLYerV+MWzXsPjap4EW09LssQZ0mpsZN30argTivAhRe3I37MVrll8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7756
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIyMCBTYWx0ZWRfX0lNzpAbZ3qTV
 +8WC/uvOBq0NHh/j/er3N/c152AMmZHgYHuEbgCPlhNTfU2Qt8F5199IL20aB+M3sO3oFHJZI8D
 0ZwyPNPNgmzsM0Z0KfvIuovukZOmj6rqt0UFS+z64W2VoT6Gv85g/VzddrgVE13kpxpWd65Od5+
 EGhk8kIqhg6zGFItpVvAo7ie/jm4oKYu2av8WIc9a6Vu0k5uMZpeZn1NGh/O9P5cJWHpr1+odfc
 tpXxnDIaKY+I/qm/lKoMNMRwDITlMURFg+x082hBh2GCQr6rPP0FqDfE7SMF/oBlD4Xm9Q3K7EY
 5N42s5Dzxvpb4/mO2npA4yMj3jVNIrY1QLeNfgM3WWlzltwOTm3Xym/QoWMJTRJwwZgXEPcGDKn
 QysCN/sAoqixuI8/5L4yFK4CAuf7tXznKdgKkPFlCL//iA7WfHuLrHe9PkI/cnzohP9ifaqgRXP
 fSkeNrlakXAcKXQ9/xw==
X-Proofpoint-GUID: 43tyZmr6XNfbz9Z2-eV70N-Ctja7U-w_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIyMCBTYWx0ZWRfXwNV2QMqmCyJR
 7lDnUU2rw9HQjJSTI38qWSxwNzsrjkubxSyKtYfz4auy4FPMpzHYKlN5QGk90zjQE650Uq1pkk0
 nAV5Jd7CZqaXJDIcYjlJmcq8IyOSmVM=
X-Proofpoint-ORIG-GUID: 43tyZmr6XNfbz9Z2-eV70N-Ctja7U-w_
X-Authority-Analysis: v=2.4 cv=J8uaKgnS c=1 sm=1 tr=0 ts=6a594f98 cx=c_pps
 a=aWGlcXfvBePkFyJsMZzBEg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=wu_xgKG8_DHQqpJy2kwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=khushit.shah@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

The generic KVM_GET_ONE_REG loop cannot correctly read a handful of
ID registers, so specially handle those:

- DCZID_EL0: No fine grain trap exists, hence not tracked by KVM.
  It is EL0-readable and untrapped, so read it directly with MRS.

- CCSIDR_EL1/CCSIDR2_EL1: not plain ID registers, their value is
  selected by CSSELR_EL1. KVM only exposes them via the DEMUX API
  (KVM_REG_ARM_DEMUX_ID_CCSIDR), so there is no single value to read
  here. Skip them.

- SMIDR_EL1: KVM does not support SME, so there is no meaningful host
  value. Skip it.

- GMID_EL1: not in KVM's sys_reg_descs[] and, being an EL1 register,
  cannot be read from userspace via MRS either. The guest reads the
  raw host value; this is a genuine miss when MTE is enabled.

Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
---
 target/arm/kvm.c | 53 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 42ff731f6e..6974e5c551 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -311,15 +311,50 @@ static int get_host_cpu_idregs(int fd, ARMHostCPUFeatures *ahcf)
         int ret;
 
         reg = &ahcf->isar.idregs[i];
-        ret = read_sys_reg64(fd, reg, idregs_sysreg_to_kvm_reg(sysreg));
-        if (ret) {
-            if (errno == ENOENT) {
-                warn_report("%s error reading value of host %s register "
-                                "(ENOENT)", __func__, sysregdesc->name);
-            } else {
-                error_report("%s error reading value of host %s register"
-                            " (%m)", __func__, sysregdesc->name);
-                err = ret;
+        switch (i) {
+        case DCZID_EL0_IDX:
+            /*
+             * DCZID_EL0 is not in KVM's sys_reg_descs[], so
+             * KVM_GET_ONE_REG will fail. Read it directly from
+             * hardware since KVM doesn't trap guest reads of it.
+             */
+            asm volatile("mrs %0, DCZID_EL0" : "=r" (*reg));
+            break;
+        case CCSIDR_EL1_IDX:
+        case CCSIDR2_EL1_IDX:
+            /*
+             * CCSIDR_EL1 is not a plain ID register: the value it
+             * returns is selected by CSSELR_EL1, so there is no single
+             * value to capture here. It is exposed to userspace only via
+             * the DEMUX API (KVM_REG_ARM_DEMUX_ID_CCSIDR), indexed by
+             * CSSELR. Skip reading it here as there is no meaningful host
+             * value to read.
+             */
+            break;
+        case SMIDR_EL1_IDX:
+            /*
+             * As SME is not yet supported by KVM, ignore reading SMIDR_EL1
+             */
+             break;
+        case GMID_EL1_IDX:
+            /*
+             * GMID_EL1 is not in KVM's sys_reg_descs[] and guest reads
+             * the raw host value. But as it is an EL1 register, we cannot
+             * read it directly. This is a genuine miss when MTE is
+             * enabled for the guest.
+             */
+            break;
+        default:
+            ret = read_sys_reg64(fd, reg, idregs_sysreg_to_kvm_reg(sysreg));
+            if (ret) {
+                if (errno == ENOENT) {
+                    warn_report("%s error reading value of host %s register "
+                                    "(ENOENT)", __func__, sysregdesc->name);
+                } else {
+                    error_report("%s error reading value of host %s register"
+                                " (%m)", __func__, sysregdesc->name);
+                    err = ret;
+                }
             }
         }
         trace_get_host_cpu_idregs(sysregdesc->name, *reg);
-- 
2.52.0


