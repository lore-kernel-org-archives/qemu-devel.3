Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7661FCA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 20:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uttxW-0003WL-Lf; Wed, 03 Sep 2025 16:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uttxT-0003VB-Pp
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 16:19:55 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uttxK-0005FB-M6
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 16:19:51 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 583HHU7c3677101; Wed, 3 Sep 2025 13:19:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=uE7Bshe3Mn4Z3emcfE29xaUQyWYuWb5NF10akxGAo
 Gk=; b=mdxZIRc61IRu4jgLRrevaOTGp/37oM3VKCno6ttfamqHrMqdEGatqks3L
 I5V1lTEVojC/34EuVi2lJq/XW18IEFYNQCaXamF69Lce/6WS5jgY8Lqdjmxk//oP
 Ir+g9t8R/2SYTUFSyhrVdSufZEGgRnos0Gz4jwQixlcCg6VTVXfT35o+AdH9hPJj
 DOzpN9uxpNr4ZL8PZKCFAtXQm6+nH+hLRr3a+W7H/tOiym0jSXB3UFRe2RMuj5U6
 3XP+nMd3yH+T6mI2hLpKJQul4P9fFIB+FfmvY6rZ2B6LR0ULqZ/xhuwWS//xCokm
 +w9PZcQnwsjl/2X2izGSTfMOhTvhA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2139.outbound.protection.outlook.com [40.107.237.139])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48xrqqrm1b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 03 Sep 2025 13:19:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxafD3MHhebYZE9kSQ9Ug2YPXr8h3wylr/NeBHy3Zq198IHO7hf2+CaaN8jjtAx2VI2rb3+C4xQ7LsoO+SqGKazFmZXGj4AKICgDV19dGXuno5a7tBM5IXcUs32VcMTbGwUaYMTALgxZHS5cMto+KoEH56dOnxGGezxBlZNODSzNqtA9k8z+6q1KrPcpTADKzBsIcXOMGYvZv3+bY/98YCV1aAkv4OxT+9EQ4q0ZISbd8q/aeAquDsvm75EYK+LUYOyzlXSmq+Lhm29u61x+YBls894Vrz9NeYnB/SX2OkrOBetDJlSW2/BqRdoI/TOARlzb93vcfxcbRI2obs5aVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uE7Bshe3Mn4Z3emcfE29xaUQyWYuWb5NF10akxGAoGk=;
 b=rwdY/Sl+lyP9K1I9WGtGaI4jXFYFU/PbSgz768V7Q13F8jSxgG+T/GplNzlqPqYg5O/+ULbf/zB5FEJoy6aVylworL8l9SyuV2Ok8kotszQ1Fs5dAx7ND1oaLORwrkItlIO6B1fzWvu2odfYgp+H8GDJeZFp4HYqvss7HZhIrfFQLh5OuvhGC8lh9a3YcC/Oxy3ma8fuwQgrwJjuHUm75uw/jTbDKz9Un+HHPCFehhk0rt9K3FCc3FjFt9LjOsJIfbdRHVS0YAzxMfSpRJXmXKayeRG7lTdVIAHI3Us0+4JiRrUdu/chuEgB5YcBWb8bYG5IVM/pbbPZ5qGyw+eRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uE7Bshe3Mn4Z3emcfE29xaUQyWYuWb5NF10akxGAoGk=;
 b=l3HwRe3j/Q8vzzkAU3DfT13m+Gi7xKjRBn5d/xqZCR7Wi/lPxpFsk3zjwFAta0lnwlbqshe2fMfXggvdz01dBbzA6E5tOA6X2TFhy61p3DwGmMwGsSl86KznZB7Jj0pWl5jGKbosBfdNLB3g5tHIzF2COFzNCPfDShWxYuKc31ELrwFdOU9owrsoC87IfdHTElkQFhNDs2lNDyo9UCZ5U43nvA6lsvIm7Ow9R4MuCNzYGV1bngX3lCEvXDW7yKk988blW+xawQKxOU3CoeTSjIKck4MgudgaxHuVmgx57E188IzRYoBfbwBie87zk5fPWiPOnH0nrR7tKl/kGDbn6w==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH0PR02MB8133.namprd02.prod.outlook.com (2603:10b6:610:10a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 20:19:38 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 20:19:38 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 1/3] tests/functional: return output from cmd.py helpers
Date: Wed,  3 Sep 2025 22:19:29 +0200
Message-ID: <20250903201931.168317-2-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903201931.168317-1-john.levon@nutanix.com>
References: <20250903201931.168317-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0025.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::20) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH0PR02MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f9304f-41cb-420d-1aad-08ddeb2734fc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fxjjlx4Xu/SZB6qOnZQQptIkRx33+mHYgg8ALIEulsGRFZUtTOsHGsWbWSBX?=
 =?us-ascii?Q?I4xnXIYStJwPA50xa2nmA59w4vE89eRvykzLLPazRqHGs5BI6naTudWC7VG2?=
 =?us-ascii?Q?xHqHeRP/9KEVe+tK0jQXp6cKT8ZfPC29YZou4HbGYCTS5LocldqpaRXvdyjl?=
 =?us-ascii?Q?Q7TlHJyMQP27C+dBZc6hFu+zCMj7NrZL76ISqRSp555oRd+rJyN7g5TSjqhE?=
 =?us-ascii?Q?jCQ/vvWI59eNUSG+UoEPXviP17GUxUpKrWRvkhA5M/jgyFQu6AdLtKhxbZGi?=
 =?us-ascii?Q?0Y+4AjPVwls/ddviiv+g3p1SLJbzxtuka0VT2eWOeDZ0B1h/5iFwWSqS6fOU?=
 =?us-ascii?Q?7u32EvqmlRMwhAkdy/ticEFxCQI2VQkKYQZTV+jJMVuEZWKcXnwwbzgFN1UX?=
 =?us-ascii?Q?7fpmE9L2ADVXQ2ODrG2orTAkBuAgwm7TvLO7OsthKuqMBrYx4iCptd6A57KH?=
 =?us-ascii?Q?kGMSWFYlaz0bab2VI2BF63N2jcvIeXKwiUSXx7MZ488fTpmeLnmKuA04UMl4?=
 =?us-ascii?Q?6Jod8LNRqIHF/DGEdEPTwjj6DwNlFTsbY92tP7/6rHrpBtfiwCk/E5MmThIs?=
 =?us-ascii?Q?n9jGEcZgiMtTvkvAyWPQo4LGPkEGQHPaNxNnwXaJlcgg60WCoz2Tt+ChH8oO?=
 =?us-ascii?Q?AnFdH7L7WkER6tDHXqs32ZO9Hlneh352mip6UqeWRPgjGZJ8d/IIg7H4J6B0?=
 =?us-ascii?Q?cIHhpNbKpjophYJV1A039o9+AvwNgrZyjgrM23+W45/JDpUzprLmmLSn/QI5?=
 =?us-ascii?Q?1wtDW+mVQyU5/zAMhVAm+2SmwAHXV+JEOKC5jlcfsWsmt1Cx4A9LsOQZMSqD?=
 =?us-ascii?Q?ovG0F9Xz++8ynHR135Glml4ArPM9rG7cyMvdRsHT5DWTiWiTqTRlmaaFFjUb?=
 =?us-ascii?Q?kwVWMWzPPJg6jly0ebIstNcqjktxqJyrPEneCak4O/TbbIEEmC223fvGpa8t?=
 =?us-ascii?Q?+ZTLaXgQrXKF8trvCYkEnzGmdrEGZ7oWzEAKvc/GZHJEPijvBRw8tf69qT3g?=
 =?us-ascii?Q?7Lif1ATy1o5iYKIv4MPDftD5thyhT0951/i0tx6wmJrCcs414PcrWyJc02GN?=
 =?us-ascii?Q?PmXTCOzgYPuBxYhHQOrq2joXcSykUyad+pe1He34JbB8Kw2VrW0um4c8DD63?=
 =?us-ascii?Q?jRJbwx1/CArk9YsLS0ynhqVh/Db/kKN9AtuIZBr/upzHNRYD/OJHlGZuw5a2?=
 =?us-ascii?Q?nFaZmgO62zhzCDSjVlpsOOX4jYZenwWGLw2leK+jqfd8kO4544UQ+XbX6n0p?=
 =?us-ascii?Q?pM7whY1hskgwtZDG4vsvdXO1IlewASHN/pcixcBW3YkdQvb0UuUn7AslVztK?=
 =?us-ascii?Q?VQeLXhKvNNdr3Oqjdeg+v22ZyqhpqpENvezBLCqmviv3U/s+6fKYYZLLz7G9?=
 =?us-ascii?Q?NG89LdHV+i9VkANPuusRfDKODmA8hRlFYK0z3RVsaZPnYzsNypgkQL5iMgdE?=
 =?us-ascii?Q?QmFRPBVgecw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rol5rlOftzJHVFkVCpIQEu2NNLpfWb3piKmuULG4NR4+yQ6VdJtfGSdy2Nqa?=
 =?us-ascii?Q?xioQiIljEeHXpAfYLL8jconB2rjXI8oN2bEKANInqYcMcufkWzjo4OqtRfs0?=
 =?us-ascii?Q?og69rjJMqo60SUyRUiWctcM9ethVM9sa50050ZtkU80AOs1Dt36e57OtFLhV?=
 =?us-ascii?Q?wbq5Nqy/qYy20esu/RmU2i/I1jhzTg0XNsn9kD1kEF8HBSxT81v3pGqneydN?=
 =?us-ascii?Q?hWwH8IYCo/X1dw3SmZHq5tJ82Q15vm87U6/f4kR3Rea+g4v6Bh4RaAMSRhR0?=
 =?us-ascii?Q?0yEMTIiCD+YigPUpXp8kZRI5jp18L80BngVGhvDfDJt/e6SBZR305F1ZXOhr?=
 =?us-ascii?Q?cTzI55myPorqHwfc+fGl/OEBKRlJEteDzHXe6CY+BLoeSOelU0N/0YTmYMxe?=
 =?us-ascii?Q?v3rLBWYyqGhGJD2VCwxwRUpuP468HGuS4kVFk1cs6ABmxS7W+tSC6q+aeRrI?=
 =?us-ascii?Q?EJm+gZyWEgH2/gawGFNvusPJHSYApj2221eMwOQfoUj75/BVVw3dJoiZ9MBK?=
 =?us-ascii?Q?Om90dX64VMar65sCinxFgveC82wLnfyUXvuJVaoIsuUMvkueGpQnoMLEbk8l?=
 =?us-ascii?Q?549zLvkxVJTlnDJJDdsiYlCKsxSIiWVun/eEae8tCbk7W9h4ZYxP4vGIgkpp?=
 =?us-ascii?Q?r34+YB8+x43Zl41U4Prv7Ol5GTV7OoiT76CQN1rUsFR0eapcw2AmkP35+zWa?=
 =?us-ascii?Q?mcGIZNCoQd7E8hkv1uteV9YutxcM9yJORx1NNcFz3WuQ+H9tikJuIgZFoM6W?=
 =?us-ascii?Q?2CHjFQhs8XTz7pslK6QUTdmK7406IJCxGcj/+H6PZySK5YmKJlixquXkpnfb?=
 =?us-ascii?Q?7DiLznHcj7JkjhFy/3fx863EgAahFJtZc1np66PdOVLW8J2Gy7aXLb3DWbhx?=
 =?us-ascii?Q?i3MCshVk6E9Rcj9dcwCWFyibH2TX6ygW/2JXerldiA2hrrFj1QbMiqPDtSsk?=
 =?us-ascii?Q?632PFrXHkMWRaSPT7shwB7aIl47PQvyIpILtFnlOsIGX25wQLpVkF+6c3bVS?=
 =?us-ascii?Q?XeIZvX+jItRRHChxwXbriBOs+evIT4sWCsjwMe0s5XMAHq/G8HSimT2Ue9QS?=
 =?us-ascii?Q?vzE5geJUCMIqEy1YqHyef6aHny4eSmQ+8TO5Enq3guruBSBY6m4ZBVhFybXH?=
 =?us-ascii?Q?PQ+H31V5ZyrLP3TCVmhnq8LkOJN5jczLhTXKPecjx/9kmHLeNehe8sL7BtgL?=
 =?us-ascii?Q?3xtFBPRkrZFBy+jXlrEGXAfFBSFjG4tW++jQm1iCCArNGfFU77q2MQ/Dhzlw?=
 =?us-ascii?Q?mnRoW6xyacTUUIKMmteR9/2qHVBSkn2MfFB+9xfI3VLzesvlX44B1bu2XM+Y?=
 =?us-ascii?Q?B98GzDJCMnHMqkpVEfvPB2CWtqy06zG/ggXUwyxDfHJrGmZ0ooYr+2jVcj4a?=
 =?us-ascii?Q?0kkYwVe4djQm+fVhWY/gTIcNkQ3JiY140F4nCGquPK0qjN6fCVdZDdMx3tN6?=
 =?us-ascii?Q?eISpMufaSdGgC1lGsBV4/Rz1Sz+I2B3kW6s1OqUW381+7NEf1QNGqvMFsV/0?=
 =?us-ascii?Q?4GSlwu7pthx8VVX1sRTapSuKk+II7LY+eHLykybdJGkXYUtsedyvUQ+MHV5a?=
 =?us-ascii?Q?3hOm4/GsXXG0CVsLiHWR/Mbzw9MkarF23EWW3EgA?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f9304f-41cb-420d-1aad-08ddeb2734fc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:19:38.4447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdWDQMykSuZVkU5n8BmooKeCJs3U+R1WcgeX8ABRezwcyJ283EjsNbkzOZ4x7Vrdp66CUE4vQ4EXua+1AKdLhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8133
X-Proofpoint-ORIG-GUID: hpxXI-XCKn4WJUg1keXc-lYpg9xv7bBq
X-Authority-Analysis: v=2.4 cv=e/cGSbp/ c=1 sm=1 tr=0 ts=68b8a2db cx=c_pps
 a=96FhCRI2SFwVpwxLm/ws/Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=AsuM2kbEzKHZIBb9HfkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDIwNCBTYWx0ZWRfX4iQAqOAOEJ63
 iVWZn4jkr5dFvEiwKLHJKpjhrYfG9AgNddy5QsYyqo+ZT78C6gwuE2LD4ZWSQcN2pv6RjzJZqpk
 Hn3y71XrIrApASchVYwviPh34EiYhadbTHHB9aams7OF5GXccDZlFfud6yWMnlhjnsewWvQzVpq
 J9ZoJCJgRT35GyApO7BDoF8TfT3s2/mUVdmMgA08wYznjYjy3Dkz/z35GCGkk2UA1YtE2Sj3k1l
 hZr+MTfL5+wQDLX1OIZuyRRh4HyObwGfBivT1wwx9cGLuFYlqG8bHhh6b6xJJrXeyVYJuf2/tqZ
 d9JIQDH0I+jEnUEz+tuLWZc/NFvyb8JBBFjlrdD63ekxdQawMGmwe6lbFVHJBc=
X-Proofpoint-GUID: hpxXI-XCKn4WJUg1keXc-lYpg9xv7bBq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_10,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Tests might want to look at the whole output from a command execution,
as well as just logging it. Add support for this.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 tests/functional/qemu_test/cmd.py | 53 +++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
index dc5f422b77..c19dfc577f 100644
--- a/tests/functional/qemu_test/cmd.py
+++ b/tests/functional/qemu_test/cmd.py
@@ -45,6 +45,9 @@ def is_readable_executable_file(path):
 # If end of line is seen, with neither @success or @failure
 # return False
 #
+# In both cases, also return the contents of the line (in bytes)
+# up to that point.
+#
 # If @failure is seen, then mark @test as failed
 def _console_read_line_until_match(test, vm, success, failure):
     msg = bytes([])
@@ -76,10 +79,23 @@ def _console_read_line_until_match(test, vm, success, failure):
     except:
         console_logger.debug(msg)
 
-    return done
+    return done, msg
 
 def _console_interaction(test, success_message, failure_message,
                          send_string, keep_sending=False, vm=None):
+    """
+    Interact with the console until either message is seen.
+
+    :param success_message: if this message appears, finish interaction
+    :param failure_message: if this message appears, test fails
+    :param send_string: a string to send to the console before trying
+                        to read a new line
+    :param keep_sending: keep sending the send string each time
+    :param vm: the VM to interact with
+
+    :return: The collected output (in bytes form).
+    """
+
     assert not keep_sending or send_string
     assert success_message or send_string
 
@@ -101,6 +117,8 @@ def _console_interaction(test, success_message, failure_message,
     if failure_message is not None:
         failure_message_b = failure_message.encode()
 
+    out = bytes([])
+
     while True:
         if send_string:
             vm.console_socket.sendall(send_string.encode())
@@ -113,11 +131,17 @@ def _console_interaction(test, success_message, failure_message,
                 break
             continue
 
-        if _console_read_line_until_match(test, vm,
-                                          success_message_b,
-                                          failure_message_b):
+        done, line = _console_read_line_until_match(test, vm,
+                                                    success_message_b,
+                                                    failure_message_b)
+
+        out += line
+
+        if done:
             break
 
+    return out
+
 def interrupt_interactive_console_until_pattern(test, success_message,
                                                 failure_message=None,
                                                 interrupt_string='\r'):
@@ -140,10 +164,12 @@ def interrupt_interactive_console_until_pattern(test, success_message,
     :param failure_message: if this message appears, test fails
     :param interrupt_string: a string to send to the console before trying
                              to read a new line
+
+    :return: The collected output (in bytes form).
     """
     assert success_message
-    _console_interaction(test, success_message, failure_message,
-                         interrupt_string, True)
+    return _console_interaction(test, success_message, failure_message,
+                                interrupt_string, True)
 
 def wait_for_console_pattern(test, success_message, failure_message=None,
                              vm=None):
@@ -155,9 +181,12 @@ def wait_for_console_pattern(test, success_message, failure_message=None,
     :type test: :class:`qemu_test.QemuSystemTest`
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
+
+    :return: The collected output (in bytes form).
     """
     assert success_message
-    _console_interaction(test, success_message, failure_message, None, vm=vm)
+    return _console_interaction(test, success_message, failure_message,
+                                None, vm=vm)
 
 def exec_command(test, command):
     """
@@ -168,8 +197,10 @@ def exec_command(test, command):
     :type test: :class:`qemu_test.QemuSystemTest`
     :param command: the command to send
     :type command: str
+
+    :return: The collected output (in bytes form).
     """
-    _console_interaction(test, None, None, command + '\r')
+    return _console_interaction(test, None, None, command + '\r')
 
 def exec_command_and_wait_for_pattern(test, command,
                                       success_message, failure_message=None):
@@ -184,9 +215,13 @@ def exec_command_and_wait_for_pattern(test, command,
     :param command: the command to send
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
+
+    :return: The collected output (in bytes form).
     """
     assert success_message
-    _console_interaction(test, success_message, failure_message, command + '\r')
+
+    return _console_interaction(test, success_message, failure_message,
+                                command + '\r')
 
 def get_qemu_img(test):
     test.log.debug('Looking for and selecting a qemu-img binary')
-- 
2.43.0


