Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C235EA3C59
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 12:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAoa7-0007Fc-HB; Thu, 09 Apr 2026 08:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wAoa4-0007F5-2x
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 08:33:56 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wAoa2-0008Nz-5p
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 08:33:55 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6397nh4u3196929; Thu, 9 Apr 2026 05:33:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=mjRbRnOGFRkigCSsPGcOihM3u5NtUjZnaoFK1pbht
 8U=; b=bSiZd2N350Pw4M/DMTfTj9/XXmHW40FxluGQ1HlL845h0hJnlOD1EK/kv
 oA6ze5xjNdvYhPqpNOcglFqQMmlsRaYdZdNeLKqml0wwtKY7wh8l6narpW3dhbj5
 ygMDhHhlojGyY9Cv78HI3SnUZaIFyzAnV4lC+nHswGr8Sf+3sNQPJ9rKLeO31dnQ
 bkEQcM5yb/muDFVhil/3NnttToNVpFIfdKOeF7tujlDfYSHceRqiZUsrSGTAv3lh
 GjD9iJihmGcVi5P19duBbcet4eOb8BmNLKPIltB5VHmT31e4nOnH0/MB3jY0yQ7C
 628L3xwndIqhYQRwovEKe4Q4m96Vg==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022115.outbound.protection.outlook.com [52.101.53.115])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4dcms479nf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 09 Apr 2026 05:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bx62gYu65f2JhpDeCINjXZ53j/HivUbF8IY/xxUMKK2fUT+tS0sPTXa2MO5O5Z3R/Zy3uf+pxtQmrfpogw47ji3tZVHQrpzR7X8UKGnIiPHd+n5lLTaT12cxyroEp8yJxnJGuQo7gRmH6tUOEIIdZ8uXFnYbLmT37fErie6BDuWJN5ZYFUcQ6EzUobuM5RNxPrufaOwhDTFT01P4debY5EnWParR33B1MK85GpIBKSyO6oetLS9yeuNIZS5qsxIBPE2klOPqkj7gpFlEq9eVhCv4lt2VJQZg7MeNah56sC5GLaDEwjAD4PzFp3sfhzWNJuP+bSACnbmHO9eZIZm/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnWU2PELpM+XjfAaM8wADpgZdIEf0P/4FPiuUr4m+NI=;
 b=qlEKnd0ybWp+V7HZqMqZjIPXNdDFxG+IEB4/eir2kHbI9O22wbvOnxAlODQviZLVigkYuk2qm/P10J5C+oOoX1mMDBIakBRzD8J5pmVKSZvpzqhw+RhdbQ4o3RtIr0gxcO8R7V6QJtFS4vyQQchcfOZGwvad/rdXQFpeeuUG7FsRrYMIkWL0/R2FoBb91eJGisHn34SDPk2rTr06yUiP3dYBASGe5utzM0SvbuJE8jEjO/RVljKguUFE6VFSOFXqTMsINBQLDpNdaI5Qrw1DiB0O+0k7nipHJq9JeWLbxGytUIquodM9JQS0XlT4Ygk59/20mZvr0FeUagVFvlw8Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnWU2PELpM+XjfAaM8wADpgZdIEf0P/4FPiuUr4m+NI=;
 b=gYSeFed2dyEWkv7FbNsLAX/qrH2ELh+3xjZvFqR9xfzC4DDvqEwB7UNbSj8yc8fBZ/5RnZ6hstNWu5Q5DTsz0AauL+IC+nSb6bLAE6WrG3g/b1MTdJDy7mhEULQX1cQqPA3ongffl76kCA5h0e+oSVnAfWnZc5zFppQwuOyrIjlJkRQivD/ct9co+bGEVRRP9C0q3fdj83dwrTdhf4xdovvp3OpyiP/cYgy1pKdJtFizDwwEWIlYDwWbCIpW58qadfraMBwH/kP6kck5xFJltzRFTGndc/VujMnzNokzO1sPdo8oAUqb8iMhJ0VUkY3jqVsIe84ugzwEj7mfmqLyOg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CY8PR02MB10185.namprd02.prod.outlook.com (2603:10b6:930:58::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 12:33:49 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9769.035; Thu, 9 Apr 2026
 12:33:47 +0000
Date: Thu, 9 Apr 2026 13:33:44 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH] vfio: Add VFIO I/O backend capability flags for feature
 support
Message-ID: <adecqP2StOtY5Rgq@lent>
References: <20260409114312.1704062-1-clg@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260409114312.1704062-1-clg@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO0P123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::19) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CY8PR02MB10185:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f58c66c-8e96-465f-30a8-08de96343f33
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: czGbIdTCGtQEkQprq0HTJxcyHHkyhayzFLYdtzChwABnDXsl2jn9itJYDqx6mB8EEagDmW31SHoGsE42QnU+9fDrbX7MvCkLcmNttBHZzC85E7ng0+/kZk1ZPeso0/pNYik+b2z4sXZ/kdRjPh15o2BQm+7OBK9q/qb4eCq1bFgSpU2FDCRuHcYRRvQV8t/fT7H+RN3nGgPcbmABDaohNUXQapMHeQCFRSnj4pxC6IRED7mQHor46mWC51HsELSLvZuATo0c74mfL5QzJ+/36kcc/m5+wKqxboKAQHxvJON4NF9z4SSZYPWYJ4P9sNZWJQdhpMjxb/LfTdkhYHq1dkexCFXKekMphffhGoDX4RtlIdh1CssghtotjjcTLBRzHI2deldNFDuTnQnhGHgl8mMUzzTABDgIw0vj7Rxr1+ny/thViF/x6uWu8tZuhVy0gDsRPAPDHwiC5pcGJnnB1gDJDAFt1An7+9F+6GYswo4TrmB2kS4x5+cD02tNiU8quz0pOZA2cx0BeRsnaRwf5j8YZuzpx0fG09qQQVjbhnn0BIFtJQDvYJKr2qSGtAJVKKzm9QpXCmS37V1imcx05PnXopeiqlhILUk2080rwHl1D+umQToVGOMFeTopIoWxIoa0yge3NqaKg+84cEvd9yuwQsZqRWX5OBwJ0npjovcR/0nGpFSl6tKFSH1wUbxBhzerh4QOZ75bzMeHax4Q1o4Hqoct0i3f6gaUXlLqnfE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?B8jJIcsZQJ3DuZqlFd2r8GbIMFC1GS1pY6Xg6nHG1s8Lf9jPD3ZsqH9NK3?=
 =?iso-8859-1?Q?9kH8ITIYxQi8mCsXaBnJmkZef5Ws4CjMSB34nVgdnyAM6JxgdmZYqrVyfV?=
 =?iso-8859-1?Q?1lyI+svf1orLZFSG7iuT9L4o3W638F0873Dj5X9cJCC/IvzEXlIqunElD+?=
 =?iso-8859-1?Q?j/N8lg07ee4HHkUezFNrvg8ofgCGNscDiFUHh7aoSJ2PHnJeTXcz6wBIv+?=
 =?iso-8859-1?Q?vxc45HQxDoWcSEa8zo5gUawwM9pVZ9H5ktue4m7MfCXPP0vO9fbjwfCs8z?=
 =?iso-8859-1?Q?Q8hr9V3x7V/MeB9Jq2QY0WrnXyncuRDq4z6Yyqf34UVVt7IvrTtExuDiwB?=
 =?iso-8859-1?Q?C22RzScjKLzm3A5ym25MjTRak/G+3wQwbKiLRyP+GZkN5CRT2mh9q5ejGw?=
 =?iso-8859-1?Q?olL/ojJscoGwgSYvJJsql66FG3ZhmDUAbkbb8EIN4yDIhvRZgEDV3TyUyn?=
 =?iso-8859-1?Q?BGC46CKBkEw4MnGKafp3xGs94tnJEBSlKbjPsk5OOU3C4/Bc3LUQdLjK9u?=
 =?iso-8859-1?Q?tYQvi9z5ObqEbV5I7rTGoFaH4PgVjPH+qSD2tv1E3Px0WC4KTcJ38eSm/P?=
 =?iso-8859-1?Q?4G0jYB0Vj6mcRVk4UJmCc4LD3C5rGGqPtu+4qyqwyd0LJ+irPDuTr2KCT2?=
 =?iso-8859-1?Q?x6lsBKdYK7z/dfNXKknTT8GGkRmn8O5cC/k3r/p8YnsJPbS+hk1Ki2MAYn?=
 =?iso-8859-1?Q?LMaVOEB8+PXcu18/8DyP8F7yK2UXovSK8KFxDeVgaM9k45xwHcZVmgm1MP?=
 =?iso-8859-1?Q?Xa1WLjWfVH4cEJkzyKCse/s26AGnOIAtG42VZfDcl9QvjZhRU0xqYr4ou3?=
 =?iso-8859-1?Q?a99fjW9ONLtl4tbt/Kem0elc4j1xkUjUpswUcO7PCL3Gp/poxV/0unjDdv?=
 =?iso-8859-1?Q?tILXANFxM66F8tKJ4JO/PFdeCO2AOxEg5zIm/YOfSR9JTK5iePEg2lpKyg?=
 =?iso-8859-1?Q?as9t73gNJonqk7wR2OqP0Xui9pCZ/mqH+rjMbYcS2uv/RcuN6R+c/tuFej?=
 =?iso-8859-1?Q?tw94ReIR1qas+cxNRDOb6BuAvjtuIFJtXSlK69lOCba8W7dnM5h+W+55Xv?=
 =?iso-8859-1?Q?oUDcSuMNHaoWh+JhGlUbL5PizNmiha/HO6ZjZHFBXJZ9mrhxRCc09biGzU?=
 =?iso-8859-1?Q?EST21ukymHkAGqnI/iZ88i4gRHSxEFgSzUa5/l9gvz7yGV7kFhTPD12sWo?=
 =?iso-8859-1?Q?SwklScIQihxVFKEElhmji4h9mcDmWFasFmRH8Z9lO6lUVc6Tf6DI2B5IUl?=
 =?iso-8859-1?Q?p1Ahtoyh1iPaa3lBz8g9aI+G8CvL/I6LFv+wvx25+mFG+Qbw4m2ODaJuLM?=
 =?iso-8859-1?Q?k0hjOTFKcqbpaMywCUa3cn1sMWECvGyLpbEQJvTk5mjcOssaYdyEnzMgF0?=
 =?iso-8859-1?Q?TspXG4xdkaC4Qxgp/2bse1ZsnD5wYGRZUpn9ZSGmG7zH0n+JzDxXF8TJDv?=
 =?iso-8859-1?Q?qzLsBe6Va0uN+EcqY+SuMkwl19l11NQ6rF+KCJ51urQh4GgbfQfKaNjlLI?=
 =?iso-8859-1?Q?LT7Pc6YUbBpFuOMULV1gM/YfTRl/1U1TqMl+ch72Isqo5ZIbzfYTIMnW3d?=
 =?iso-8859-1?Q?Ev6Gf9LNtKP/dMihYZn0sh1F6siaJMgEE6xJMLvTGSA3iJ0LoIChOBcLS+?=
 =?iso-8859-1?Q?YtIRD1YrReOvIcWq6NYtYkYnbko3gIEPiPi4UgT1/aXqSzEa2Qcc1s3Mau?=
 =?iso-8859-1?Q?7RPe1Dav5Dz8OhPnxL+/GMY2u6mXvEqpGrJ683cn3iO2O2m/t1yDWivjID?=
 =?iso-8859-1?Q?V49RsPzW2N0GQxhCT/Rv4zQOnbMjcfEzAYEIxh53lQH5bwFFlGvPUXox5d?=
 =?iso-8859-1?Q?15wUvSVZiQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: tCK7ygw47v01IgWXN8lOgQoHqtbw8fNPyL5RXtsomqZlng/5SfnyoAI5s0R33gcrMFboR2/BwbP5j7Zfs9W7E41emK6AFgpUZE3SStbKPx03ulsHmweeYsaPucq6dl+Tm7IhKlEJUIpOgin0UbETvkOJt7xXXJ4V/GHA6jSkORda3XGIJwIogHZ1378MOHNPHifhM0+A8GHztAaRAL/rzQQlVqRKuTU4vCjh/aAcNutjRuwU42dlXxNJBXzh+3xI7D9z1bPvM2NFxKZdWLRlf3MTfy4nCsQlyx9kkosb4G/W1rdzDLA6lVsm6hTBmszVqusUwSUGLrhptealtx1BtA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f58c66c-8e96-465f-30a8-08de96343f33
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 12:33:47.7196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZT8sJga0NW9Ha5AI4PooWHo1fFM2puOKeA4WmsjMmCt7apvbdOOflA8WQwXytDp8MJyvWLQCM5NDDmejdEosA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB10185
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDExMyBTYWx0ZWRfX8URJLCUtdPoC
 fSQ4e9Bi7Kgpm1i2a180A7kHRgHkSSHZSypiHgtd+V9kKcwWw+ffpOfYnE8kdr1hU2mL5YFCEyY
 fS8eRBGrLMtIXvdTYfHllby8/8pTPGfdK5IlWEC0JRIe8TG9TmaeKA9gox3U09YrSJTYyRVJuvb
 dhpmcZVxO+gf60Mg87N74qFPQuJm408c0f71n8VH90yRToWGhChQgxbWg1hpug7+DHs3dGiV9jQ
 s7yZ7LW4T+ztCD/QXXQ8KuWJ3xZd4NwugeUC3WFa/l/ZBdLJkJseSgI/2aHLvncenRFMxBrLHAM
 9uymSmA6RoRTQD7dsNFMLZUx753TIJL3/cZvS6PAT1YEqjILjEIHNpQpSWJL2TPzbJvbKNQvgja
 7egPvYh0hcNi94S8A7y+qCJtCexaI7/7W96f/JeO8M3TWvbmlP8XgQY0Plb4BORqQqBFxlsX30G
 PmUHkoGb54tSaLJw5QQ==
X-Authority-Analysis: v=2.4 cv=M4197Sws c=1 sm=1 tr=0 ts=69d79cb0 cx=c_pps
 a=eiJXeYcBrKiqJN7PW0oR8A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=_bQLPuXNoKh4h8MH-wAA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-ORIG-GUID: -ClktJ-tTAXrZUBLCQm-ZMzr5LEEIgYq
X-Proofpoint-GUID: -ClktJ-tTAXrZUBLCQm-ZMzr5LEEIgYq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_03,2026-04-09_02,2025-10-01_01
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

On Thu, Apr 09, 2026 at 01:43:12PM +0200, Cédric Le Goater wrote:

> !-------------------------------------------------------------------|
>   CAUTION: External Email
> 
> |-------------------------------------------------------------------!
> 
> Different VFIO I/O backends support different features. For example,
> the kernel VFIO backend supports DMA-BUF creation, while vfio-user
> does not. Currently, this is handled by attempting the operation and
> checking for -ENOTTY, which can lead to misleading warnings when a
> feature is simply not supported by a particular backend.
> 
> Introduce a capability flags mechanism in VFIODeviceIOOps that allows
> backends to explicitly advertise which features they support. Callers
> can check these capabilities before attempting operations, avoiding
> spurious errors and warnings.
> 
> Cc: John Levon <john.levon@nutanix.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Thanks!

Reviewed-by: John Levon <john.levon@nutanix.com>

regards
john

