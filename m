Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30EEC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSFNf-0004GH-N7; Thu, 19 Jun 2025 09:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNc-0004E7-Cj
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:36 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNZ-0008EP-0K
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:35 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J8A061013187;
 Thu, 19 Jun 2025 06:32:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=YxMHKKbdXd8YZJD0Iy1oIU3OITBXEu/+2TxCD9ow/
 fM=; b=nqQwToU8SM9qgVJgKyHwpPXqf4Qv6iSpLiJyJiZ1f1NNnT2emTsQhdFC8
 Xe4ozsAHiFN00sHOvY7q3W73gkTjMkRAigAbz9jo86nsPCgZ0LqML0unpe5mhWZd
 uKhM/oik+YrUxNbSjMASaoQWB5CqeGjXAjez6X6MVL142D7Ta3x3C4ENlzU/fIdd
 RKvl/nogS1Q8quvjBCU04QZ10jC2S9oB/QHVBzkacY0p16zPcNNaUeltOgsK0LjW
 vpm6jMq3ERYsRRYVScUPjkIR1bNUZQDcTAkujWXj7HTWROD1naoeSuP+O9lJeh4J
 RKVLFSga1zWFHV2KlCebi8C4Omh8g==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020121.outbound.protection.outlook.com [52.101.85.121])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4798mykwq7-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 06:32:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZAZ32P4CSumJLUtxmosSm36VAB6RuV/RvJkWzRZCdhcASCc4Jv2U0fzfkHD2XtOhMv/8gzQiM8jDEzNaqP7QcGlL8gKZEBswFSNWULxJHwwWDAw6sExKyFbCRw4YNJFEtGCGEkboN9Jls8IF7cRt7uzqFMVTThqJ38LQm0gUQx6cXrY8sZE+d9/najCqUt4oQYh3QVTGdU27XnYaUJ0l97yQkRjxlx3qVQxn/qlYO/c7J/j1vWo5WCUEllK3WXDB1KugXYN76kRo9XPnrbv62utrOoNTIlPMm35R6GV+ThWuL7p7pc6TdHErPaYHjUBGFvoHc3IS6nkRb90+4qJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxMHKKbdXd8YZJD0Iy1oIU3OITBXEu/+2TxCD9ow/fM=;
 b=VxojwAHMuh0pMMqbtG7x8TFTBsCF0Xt4x1K7ZPQ4Mx5Ldl9Ybce7VAb6KPMZaBW4RcVCzHpSz/jHNT/A9o/7EMkTgNBnMqNc1agowcOuO1RGV8OwXU4HnTocjoXQIbHidhyfWyW2a2hbHzGX2/qR9uGgYrZaJO86iIr3njm3X15nq4/WrPeRo2h6P/7/PZLImx4Cm62CPYYzS0yyMDf9H8dDQQhyyVlrz2pJFNhI8Kr2lxi2KgcfDJnrvW31npA3V2H0sYEkqctSzFBxJg1efXxMqXuGsPuuF1eml3mQHD+4Mk8gkdjslAO36136k7UJDL3AZqjWRPu1ad/2mCb8Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxMHKKbdXd8YZJD0Iy1oIU3OITBXEu/+2TxCD9ow/fM=;
 b=qCkBNK/XB2nGfZlcOrp4qsHaH3GnrJQ0Dx9nV858gEzkvNGmfcp/D2HOzyIL7YpEa1QAiEodIKd+KdF8WdLnBvcOb8R5sEd2anOEyOFuG1UvWvVDfW62IqRt96/ZBVctWYgoM0zFcsRuyuXBMIIT01llGM2yOzSebWidcf7ty6oBX5E/jkv6rHo+yPPY2WfBukr4gTD9pdQAJUM8ArBHzDek3AW5vFVZ56AhqeOroDoapGsGiPtbhzh08SkQ/6eW3NTABz7ALzgafazyJD5+ZEm9aowyB1SZs2ZuanT/EW8l9UtcRD2kqXWO4pp9affA1NKOoY5Q1R1I6X9FqnSqmw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB9383.namprd02.prod.outlook.com (2603:10b6:510:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 19 Jun
 2025 13:32:24 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 13:32:24 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v4 10/19] vfio-user: forward MSI-X PBA BAR accesses to server
Date: Thu, 19 Jun 2025 06:31:44 -0700
Message-ID: <20250619133154.264786-11-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619133154.264786-1-john.levon@nutanix.com>
References: <20250619133154.264786-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: 539f24a0-847c-4407-d446-08ddaf35b97a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A8vyjQE6adoyOTchixbTEmGa3d4E2jKXsKyHLATkarb0MzixaowAAEQOJi6o?=
 =?us-ascii?Q?/DRnIWjO3D5lcSjq9/yUH75KuBbH6bp9zM+MJhsCohK7tiBZ8UisqCuRMc9E?=
 =?us-ascii?Q?8obb7/aGGMvZxgXbNKlJx0hmJWDdmobay2F4HTARiivo+BRGmpwzvz4KT8rx?=
 =?us-ascii?Q?wOjsPc+cpMoGe2xDhVza0BwdmRRR9aNhknpFMOrVzGMywalxbsh3G9CEhA7n?=
 =?us-ascii?Q?D+nDFYDmtU8XEJhPHzaOglZUBq/S/RgqfTutlHKw6pFNYQCtwhbTUXfr+Dqt?=
 =?us-ascii?Q?GdDy3RVtWzJezWDjJkBpNltvFwwANu/afYy8VrTyjZWDfaXXDupPiZ0DZw5D?=
 =?us-ascii?Q?iyC3d+p+AuFkUjG9Lz2twHdhKD1DJ5uwUY7UClyeuUK+Flmc0xJeiUAyrZnP?=
 =?us-ascii?Q?HwbKFFX9RPIEZgWe464nmefsLAZVZuxd3k62vKQsl90PQj9kJf+dQMdcpNsk?=
 =?us-ascii?Q?xWMwpWoKO+vfnvEXjhnmNb9kZjl17mv77noLwuPMPShDQJ746DSabvt15fpd?=
 =?us-ascii?Q?B2NWilfl5CJaBm6tfE6fxOdRcZ47rNdd3elF/+gwPHJwWDOXOkB164/UVYKI?=
 =?us-ascii?Q?yrL286NIKsISct5TsZAfScF5u3Gvebp4rQ0RvOSqW5M7rq2zQNK34V1OYzKt?=
 =?us-ascii?Q?zitLKOdh0ejlFoGTMpPd8RZig1iAxUXF37Stl0L6H5sAqrjKF2InKIIQlnMn?=
 =?us-ascii?Q?ghe/Zmz69G/m3e0Ik421v3QfTVv8RF6ciIYm7qQUpcEbfCTmOe2GJEAXw7nl?=
 =?us-ascii?Q?PFx37HoHjgE4WneN47d/cTf5v0ZvOQitKJyfnqRcjO1/M6A4fcKDKKlMNksf?=
 =?us-ascii?Q?JnxMxHvaEtIKThrdGJM1chCv2ykOR2dL67zeUugk4Ml2Z4PToJAl3BLcwTjq?=
 =?us-ascii?Q?bs02EC2h2YnErpA0IMjhZeM4Q8ezD+6xbJ4omDXTd1YpXsQ+st+o6svLXmY4?=
 =?us-ascii?Q?G1sT0EAzKRl2POVamEq4uMYVIpCMtAUHv/IaU2G3zLU1o+B+oW+vqkV9+c7l?=
 =?us-ascii?Q?CM4TSoab3SVOZD9upNSOnNg9m3R1JqUkQM78MgqcngeXfp7EgLVrixa/MCmm?=
 =?us-ascii?Q?00xb2UT5gwmy1b63lOiLUYmBO4eWmDe2SdDJ8/0VdmPGS0n1+DAOPvYdH1be?=
 =?us-ascii?Q?Sa3OfcMPqWrJ/zjBfHz/AzhNXb6q/DRzFsmaJGvR88p39t+PuoCDyzLzOq3f?=
 =?us-ascii?Q?O8sVGhFnXQJlbYG7fDKHHCJSlDnvcOQZtzVm/DCtimWPAwvQn/+OX0iKNJoX?=
 =?us-ascii?Q?NC84MFRwDt9Bbwx60H17d5mbnlsF4UP9wudTEdoDdCepkB7dhVX5N2bCU+pr?=
 =?us-ascii?Q?dY9KliSn9MvA+J9+enpqZL4kVsuGDjfEZCGWJ/kAPNjaFziyNBtoFxwi54hc?=
 =?us-ascii?Q?BczkwnCwaGC4/T4tYDW9UREda0/ljRxPPuGgzAkiltkLtM3wQ/JvX/uexjOa?=
 =?us-ascii?Q?T1kLX8vxJaM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VkBTAZBAP4c9TGLSaD/PyhsAmuiDK5rTSOIFzwWRg+k02QajzeBUx+38VcnR?=
 =?us-ascii?Q?jhH31QUhY8QDok+xwpeMZsf9gXF0rN+g13UXYxayxdhYxzHmDbRuJdGRZb4m?=
 =?us-ascii?Q?gr0FGZmRDol3cSkuJDTJebYjfb2VjolIW/aV+PJffOrA5Dqk7+HgzrfJOx9t?=
 =?us-ascii?Q?766KQqWe4z8/nAAsyS5u4wNdlWGQsf/4JlB6f30rngF5gMpsDMB+oJr5Ky4s?=
 =?us-ascii?Q?wyAyrLxNQrcrNN39hTaxhFh7mVaJa4kZbUf+1J755N1n9ayA9/Lgoorrh9Qk?=
 =?us-ascii?Q?tUd9vmSLNuszhvi9S8DLrQuCYBmmaziWHpjWHz7wmbb3Weq3A96BZYqYINy8?=
 =?us-ascii?Q?0cp+07K4tycrJR08G9R5BAvQKRiwrsiei6eaUmCbdiL6q6OAhdFEGIfpC4mD?=
 =?us-ascii?Q?U0Vosa7/XVEczsi9DjE5g1D+1124OIqk3uqvADRLzdmCL8UExOF3AQIQ3bBb?=
 =?us-ascii?Q?FJdTXbDICxiAamWlWmpzAmAX+6IOUKS07cLDOR815oRJ0Kj8v8gmc/jjpmC6?=
 =?us-ascii?Q?YquRTIfg9k3OZHi2mEfjKvJ05aO6MeKZ+YR60KEtXkIR0G0hAonZt4e1fUep?=
 =?us-ascii?Q?fauJQiis1bx27oKUwdgMQh1XUy7XqLipc0zJTwrwTRM3ikNncDiktjo0TmrU?=
 =?us-ascii?Q?kIRQnjOTaZXB4u3pTK8rqjWcC+9pBRot9ov03BxgNdEHQNceaCUWqZMa2FK/?=
 =?us-ascii?Q?IJp07Fe9y9ucnVYQ8B1Du4flFjOd4FXPWtvGBZAz3T0L6U57BAz9UXeNgaOq?=
 =?us-ascii?Q?luKKT/k8r5QEp/VHfr3h8bfO5aQCjmS9Xve+CB7vy82ONRDiA082OZySFkCB?=
 =?us-ascii?Q?oGbq6qOHt5DQ86+mdb4If7ultqVCQzg6Piy1k/ByjB9rg+PA/80MIjwH7pkO?=
 =?us-ascii?Q?KaeCMma2TNP9b+iABu7aThyYTaYZq3LxlgBvaTo7PcQrkuI9qZ+SvMovp8vY?=
 =?us-ascii?Q?eD+Te26zUIlY7o7vcJCHLCv3Qyjsrs8baqUIghFkSa2br4uxGCpHBcLrVXfo?=
 =?us-ascii?Q?rY7nQczawkHM49obY26P6UXlEyuVsZ8jwTTKKkGTZXYR5ZtBV8HYSbMWekqj?=
 =?us-ascii?Q?fx7zwrCrADjm4ZnY5lgdt64sTk5fZmMu3sIzfRmlhg3THc1RD+AypenQ3NZF?=
 =?us-ascii?Q?X9r/JN4PII5d/rNDXp1U2GAFqsyRo9I+4wOL7GwTIfIKc8McLsqowTa7fY5u?=
 =?us-ascii?Q?IzeWTuPOJMbWzKTSh0xO8W08ie3xfZcXa7qOpaQLHuUT58plmyvuFwYvsl0a?=
 =?us-ascii?Q?MsUb9QrgZUOW6S9DVH/wXshaQrs+O5v7lDGYxYf6Kv9k5pG11T2UNaZZPtRf?=
 =?us-ascii?Q?W8dOoRpy16+7LgD0WsEnMzE4SrBM/wcpLjvKJGDMs7f82qbhYIOLCnneae9L?=
 =?us-ascii?Q?ZDFpms0IR6rg9fkw1DLqLP8KDEKV3uhLzLXCEV98+oblsLdv7lIylhQ2HANv?=
 =?us-ascii?Q?tZpopICt6M8ljx7+hZ9ZDGKiTnOJr/4mqThoxvi421FLM2cFsl+4UFM+2M2U?=
 =?us-ascii?Q?Zlf2Je4+ZJZ8vEpS0a1uuzSL9V2Z/QPDzVbHvdiJePSBtA/SXcgtCGGsFG5j?=
 =?us-ascii?Q?iEFd6WVpuQ1YCAocvG3Oh0+StBKaoO7JS/BKQK31?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 539f24a0-847c-4407-d446-08ddaf35b97a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 13:32:23.9339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NV2bDDJ5X8Ez515DV283rzrPWVmwELFe7dTPVNzEmmsCZB/D9MMYT4Uxh1mwxrOltVzD3+e0HSEnRltLAtnNyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9383
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDExMiBTYWx0ZWRfX/8xcAzC06sm4
 62KYQqO3oazz52ybxJJPW4GYSfjKrt8kMt1ZZtZM1Eo4jnZY2q7FDD8Xd6ScyQ4yy32xoC2Txee
 S09HB3nc1+178qhzzMlxWT/3t7kLjO2YJSfVHP8ELy+zEXsSgoNb6rMzhR/6I43r9EkFLsb4rHL
 qiEfePFv5NFYFrZ8KocC4E49c4pNQqXbWQ76ugyDv9cg+iGUt6BPWbZhNJ1rFVQND4Clbep0CRK
 8wHATJIbWCX2of8MwyH7ORZ0l8bPWI7pa3meZPbEDvy10KfIjKGbRYFPq/38o10TJ9gdugzyphf
 /2x7NgY39IgdrL7dTZdbIHAHSFGyuIufJTRpKuxLISeIO2tZuIP9zSg6T+dKA1iH9e2waewYQHA
 IrInYBGkWTHjs9YIShH9XiYry/Pns6uk6l4vIa3S82wLXE3gJ30/HqHgP7xDupnJcsfT4qjn
X-Proofpoint-ORIG-GUID: jvwc54tvSjP1BzAQLBgJ3Mu16WTePz-v
X-Proofpoint-GUID: jvwc54tvSjP1BzAQLBgJ3Mu16WTePz-v
X-Authority-Analysis: v=2.4 cv=LIxmQIW9 c=1 sm=1 tr=0 ts=6854116e cx=c_pps
 a=Yi5XoY1Pvk1/bV4Hj+lk7Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=P96-NN1LHiVJMZ2xip4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

For vfio-user, the server holds the pending IRQ state; set up an I/O
region for the MSI-X PBA so we can ask the server for this state on a
PBA read.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.h      |  1 +
 hw/vfio-user/pci.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index d3dc2274a9..5ba7330b27 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -116,6 +116,7 @@ typedef struct VFIOMSIXInfo {
     uint32_t pba_offset;
     unsigned long *pending;
     bool noresize;
+    MemoryRegion *pba_region;
 } VFIOMSIXInfo;
 
 /*
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index b49f42b980..c0f00f15b1 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -24,6 +24,62 @@ struct VFIOUserPCIDevice {
     bool send_queued;   /* all sends are queued */
 };
 
+/*
+ * The server maintains the device's pending interrupts,
+ * via its MSIX table and PBA, so we treat these accesses
+ * like PCI config space and forward them.
+ */
+static uint64_t vfio_user_pba_read(void *opaque, hwaddr addr,
+                                   unsigned size)
+{
+    VFIOPCIDevice *vdev = opaque;
+    VFIORegion *region = &vdev->bars[vdev->msix->pba_bar].region;
+    uint64_t data;
+
+    /* server copy is what matters */
+    data = vfio_region_read(region, addr + vdev->msix->pba_offset, size);
+    return data;
+}
+
+static void vfio_user_pba_write(void *opaque, hwaddr addr,
+                                  uint64_t data, unsigned size)
+{
+    /* dropped */
+}
+
+static const MemoryRegionOps vfio_user_pba_ops = {
+    .read = vfio_user_pba_read,
+    .write = vfio_user_pba_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void vfio_user_msix_setup(VFIOPCIDevice *vdev)
+{
+    MemoryRegion *vfio_reg, *msix_reg, *pba_reg;
+
+    pba_reg = g_new0(MemoryRegion, 1);
+    vdev->msix->pba_region = pba_reg;
+
+    vfio_reg = vdev->bars[vdev->msix->pba_bar].mr;
+    msix_reg = &vdev->pdev.msix_pba_mmio;
+    memory_region_init_io(pba_reg, OBJECT(vdev), &vfio_user_pba_ops, vdev,
+                          "VFIO MSIX PBA", int128_get64(msix_reg->size));
+    memory_region_add_subregion_overlap(vfio_reg, vdev->msix->pba_offset,
+                                        pba_reg, 1);
+}
+
+static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
+{
+    MemoryRegion *mr, *sub;
+
+    mr = vdev->bars[vdev->msix->pba_bar].mr;
+    sub = vdev->msix->pba_region;
+    memory_region_del_subregion(mr, sub);
+
+    g_free(vdev->msix->pba_region);
+    vdev->msix->pba_region = NULL;
+}
+
 /*
  * Incoming request message callback.
  *
@@ -144,6 +200,10 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         goto out_teardown;
     }
 
+    if (vdev->msix != NULL) {
+        vfio_user_msix_setup(vdev);
+    }
+
     if (!vfio_pci_interrupt_setup(vdev, errp)) {
         goto out_teardown;
     }
@@ -192,6 +252,10 @@ static void vfio_user_instance_finalize(Object *obj)
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
+    if (vdev->msix != NULL) {
+        vfio_user_msix_teardown(vdev);
+    }
+
     vfio_pci_put_device(vdev);
 
     if (vbasedev->proxy != NULL) {
-- 
2.43.0


