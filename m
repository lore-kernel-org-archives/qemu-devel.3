Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0CFC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZn2T-00081j-0U; Thu, 10 Jul 2025 04:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn2L-0007nw-65
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:53:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn2J-0003Xy-4i
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:53:48 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569MVr7d029396;
 Thu, 10 Jul 2025 01:53:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Dyd/rqTp1IzCDlik89rDGfjueIDhCQW2dHUL1PqkP
 pc=; b=lG9nIR5pYvmMwET77IxX42DxKplMVGA3bu7MIMKgHeK4AquokOr5j9CQj
 SI5ZMS8H0q1uXaOKiX33a3VIfyA3asj/FwiTNnrXR074PqJ/2zx5YfyiRRPsJVz4
 44neiMpvJ9wApMQv4K2hGd79KwZz2c+x1M+lrU2hP25mxIkKOfl1FWBwkYJjG7zx
 DvgxaKGog/P9jA0/3Ad+dMu7cH9a0DStE9kcKFRDET7bhASODFteljy4SdAEuBL8
 RmmOtlniDx1nzdV69JcanAMTBaZp/x8GF16NpwY9UKrVjkdZHZH3PHvaNMiI7qEl
 qYlsic1KNlkRiDU1x7gOHUfbWOI9A==
Received: from cy4pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020112.outbound.protection.outlook.com
 [40.93.198.112])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47q0cvn28f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 01:53:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZR2cGbS/B70Ft8Yn1gnvyfTriXdEPkn4GelaaRF/vnvDRDVdCdLAbDtY70M+9WWuE+z2kVMNqlvOYiONj3t/YyWQ3LNfOtC0nUp6tY1yy6j/brEHEg/xwYwZbKkwxs9alWec6Z9JCXY/tO8VAeLEB26X0gzF2unyWDwnrpivh7R1wKP0pIHv7TBwwr26wtl9eUBu4gtHD2JOJTrpmL7A4IWC9h3vfGKHtrQpKohdpRg/iA6bFbi1pWqZ+ZHE5ZNImXSiNQZYW4qgkeg7Wn2oWV6oRfv9Btz5nXQgRdO9xEi62A5XMsXN2wWNo4UefUMWsWUQtICTi+HFc9Tbt1gWAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dyd/rqTp1IzCDlik89rDGfjueIDhCQW2dHUL1PqkPpc=;
 b=wereE7px3YNU29lSsA7u6KtS/4Qt6IBrEnQWsEY3JMhmJYuXaW9LmYRCDiD3CqbEdcWAqk2YCsg+IfT6yXvDAe/pZfubwEKbBc76km1b/MoIyHFdsvSH7NRz9LXFYVEs1Bl+k6OeES91F84td2IzizBZrk32bbKcc/9Eo4u2qvX9npPolljZbFbuKBUyEDks/kZz1vTlj6cJuKYwhsm4SX1z1gA+bTCL7mtNFXmQiRtMZF21HwlfLL/vkV1FMhlX29/FZhbguioCWVpdEhqeoUNyXUEgRoE0EVoUHWR2xxTTQkRPCPmeK1+ZleJYEcPEQoG+naYk9ZJxp/Uhb0+VBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dyd/rqTp1IzCDlik89rDGfjueIDhCQW2dHUL1PqkPpc=;
 b=aQnWMq1iSBeOPR7ALhXLdaQ8gIgS/poFItUYFTxRn98AuOt555lU6wpUyoTXZHcOA7VG8bIG+B6UTZuoVTOfXTIwIA6vNOu7nez0aEc2FeUphfXnJE0M0JukVc9IH0DG2tlnPb8IytIlGLr5z5NJExv9iPmL7qUH3INAYfGwD7U+DLlqc4lZnZ0R8rwSSyWrDHJq/Q0qdwiAJApVLQgl2SzGGklk4Jn+LdITCloUiL2KKgM4B8PEenXUvXQBOyvGL7ZwRi26vx0cvff80Vypts7XwHuidxabKsdpfj3Mxn06WtM8GkKvll4ZSiZgHrRubn6d0kKNkYtpu2RJ55Ya9A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8048.namprd02.prod.outlook.com (2603:10b6:408:16a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 08:53:42 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:53:41 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 08/18] hw/i386/pc_piix.c: simplify RAM size logic in
 pc_init_isa()
Date: Thu, 10 Jul 2025 09:52:23 +0100
Message-ID: <20250710085308.420774-9-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710085308.420774-1-mark.caveayland@nutanix.com>
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0082.eurprd05.prod.outlook.com
 (2603:10a6:208:136::22) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f659bc-6289-4e78-7ae6-08ddbf8f44ed
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QplKjiHf5dL1bsTjIAL1r5yCdFVBwKlGXpZ5/VXjCpKmCYByyaXg/11DFwd3?=
 =?us-ascii?Q?MXrrGnrjVfdaqicxJT56OFd2itQkdak9dSLp6y1+ncoCkxeS3ZW4W08ZCMGJ?=
 =?us-ascii?Q?EzCB4PXLKfL3yKYye/AWQeqbJCqi4pylhopYVADZix/Wv3wXqgiKHef17zs7?=
 =?us-ascii?Q?5eNQVr7EUi8yU74mYFHyj7/CtO/ZAMfPzNa/mSFr4ENnONefrBBCIxMpOBLU?=
 =?us-ascii?Q?kzps4unMW5sX7gGuVB8GJsNkYqlt7Gsx2V2iBJAnGzXYJYiah3vz4n0nrFty?=
 =?us-ascii?Q?GaRJgAVzbQpgYhPrz3Vpz+N+8CCTfSUZVp6S5MDQZfPRkDfT0Co7j5OlQN6u?=
 =?us-ascii?Q?u34i8JHafCof+hfzrWq1m/xNluyjTubns3oRE5+5KhECH76nxO4OaQ5cHS9A?=
 =?us-ascii?Q?VKCZnXXssGgZiZO1h2GjR8SFUzo0zvbUePc50BVhe1teca8dpiXOjdI+gv1s?=
 =?us-ascii?Q?RPNw2chLJ2tluMLzEn9fl/o/92t6niT/J1IBe2Qt42MJiuFFExy8ElzupxUV?=
 =?us-ascii?Q?EE0iXMftveFSUC8BweP2G3q0wOB9MjSevABqFS1kG8TUqwFPafnq/tijvSii?=
 =?us-ascii?Q?QI3ba39TYKatDokzFnodxYn8KHxIxT0vRgW7eaSt7/o+gXLQhii0FZr01PsZ?=
 =?us-ascii?Q?eQzhOMCLxMkDY0OvofkpWsik+12GAFZiXlW5WXRWifm9tqfx2oUoSqZXEkHx?=
 =?us-ascii?Q?e+uC5cAl7AupqoDxV1zPrTWJTtfnAU0Z6a2tncg2MWLUsz6/ZZCQcJn5bzq4?=
 =?us-ascii?Q?I7GlGiOAIthcSPOKDpganbkcOcRH17FYOF0lrr6fc83qzV16WJp+N0f8jpXj?=
 =?us-ascii?Q?D7HCZxi/jVy2TKQf1ZYfjyIgkZLmtDUJPJmrN7QVQdlZI+i/BZgmSXYU+gL3?=
 =?us-ascii?Q?jjNeTYcEtJ3W/DuBnItbk/ycSt+TN/3LP/JdcpW41pyfsakTJxsstg+a6Y5S?=
 =?us-ascii?Q?FZ/5sZGucXkTJ6YbtuXgRXGeSaXzLXMUqdwNbr/G/MTRk62CnxSlyBplNHvI?=
 =?us-ascii?Q?4H4DPDIgwhX01NeTK9ICk51xU8MWIs+dj2MDzLPLUtsUJobSsb6amoE7c829?=
 =?us-ascii?Q?stIRPVrHaVgNPf5LKZoPpmGeT7kxkHHrolP5YWdOjLMz1mk8vzumJoupltOi?=
 =?us-ascii?Q?//zFINMQ+ycjnwPPfOy4C/Wcu8/+5or70A0sZg8TYEMRObXl7umU9bzyY5qs?=
 =?us-ascii?Q?SvGbnZld5bD00h5jOKQWNOSQm94g3QLAVlAj0nxNPvRnYkaRHUUsVK34nkpC?=
 =?us-ascii?Q?UK4JJSYKkUJJyJp5QNozmSEVJaAgP8lj3ug73I4V99Ssdl+8rqetW8U/MhtC?=
 =?us-ascii?Q?l7nZNbmyRPnF9+o6BuS5hcwIOHg30o3dyZmH9XYS94aoMwwQPOGCoPXOKn2A?=
 =?us-ascii?Q?Uhv5B53GmdxVb+B+GQc2FVxjfo5N/F0uW4M7wvCCljLYvXSTr1wmHPQ6l/6w?=
 =?us-ascii?Q?KBogyaOrx6A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B9XxhnSfNqbT2Ka/ozP1KoFWBumgNGE8y/5jXnNZeNrWZrdSDJf6PO2NeCKV?=
 =?us-ascii?Q?YL6rEiLRDQ9LbonVvZTdoeMAvR3gdbKdnbgNWb+VNV7tJKel7MDWhY1G1uxj?=
 =?us-ascii?Q?k2QQi9dOgmjrmePPMeE0WuEB/jYGOdAqyp6JPlBrk+eChkQeoMD6e9UGGF7M?=
 =?us-ascii?Q?bYZbDtwPioTe9vXX5cVpGsFnjK2HonzV6w95YNt1HnzyV9CPbZJ+xH5QUkiH?=
 =?us-ascii?Q?CUYu7k5eLJR69RmoFUg3wKYRrfYVCZL6nk3PaN4YkNldhIBXwHN8xxa1Af83?=
 =?us-ascii?Q?1XwourVoiS+/cUJ9S0jN6X4iE3YZQEjDVmEq3GrP49X3u73CWphhHOPqj0Su?=
 =?us-ascii?Q?fL1btoDs+XSj2PlSPEkJ/Eqq0c6iZ9PvEIg0xrtMhVkky8a1u/aThem2QkoG?=
 =?us-ascii?Q?cWkaMO+FtSGE2OUBbcFUkM8swQuAi1c+jX0BU0hynA4VDg5DFbRg/GrDvlWV?=
 =?us-ascii?Q?JegoWIo9fRYDAO1j7yCAo6tmWpg3z3KomxmR/XRdweAkzfv1AJr2ma7xh52Z?=
 =?us-ascii?Q?JfZ5SWdaELaLZT4aBmXEXb4zqgf9xCXDzN3xm78RLafg7tYLTxHI7YWeRRKe?=
 =?us-ascii?Q?2SmbRhm3trf/w6gsBgn8vWywsHD15tZcn1CHhH02H47kFN2ZuKpAurtagaXR?=
 =?us-ascii?Q?Qal9x6gG/TRVdb+jI9vNBCreP/pHTBuk/oQUsRmnN0G268nU0ATQ5nS8AUSW?=
 =?us-ascii?Q?l8A6uVLiXalfI+ef0VxEL13xezOrx7Or4sCR/mQpB61zSPlH1Om70fhxl3E6?=
 =?us-ascii?Q?yb0/TvWPVNARCFLFhTDLydkf9WrphALzB5E6IbfgQOxHqw/ulVU5BJlKZ9VC?=
 =?us-ascii?Q?NHLKesCDLP8P5yM9MWaVupu9EElQluj+zq5KX9fbU7KxHTNIKafII5XAyr2e?=
 =?us-ascii?Q?6p3iBn7TR/h+PJacdO2HN8aX9x9CC/Meakk07bFdHTXxoAf3ixWFVXX29wL0?=
 =?us-ascii?Q?8ceLvkMi5xUBuTN01ln9emlb8GanwW1OZXRL4gq+ySm2qNBSg5yMRuMJLWgo?=
 =?us-ascii?Q?W6nU3HgO7y9W4+R3Aij0rb+D+R9sqCEPr27tIoZkiAJqq6w97G0FcJ1S3nag?=
 =?us-ascii?Q?rWMOKeUP8P3+yNCXkAJYLD4+dgbsmbGotd+gEDn6LCjCw3H3V4svIgDnz8Ow?=
 =?us-ascii?Q?gTJ5exjCP2aEigo1Jqd/zz9HsRCmB22DdguCueuiM2CMweXrJv3DLuAwX5RV?=
 =?us-ascii?Q?oSkH4M+b5GIuAD0J+TnyasBfoX80GrlGWBKLyZzn3B2B6OMdh9UmaHEvjPQ8?=
 =?us-ascii?Q?LdQr4enYH9hzuIB2KquWIJHII5IXeYeItvJ/eKkUr5TsC7WbCYlK6nXEI64o?=
 =?us-ascii?Q?DDEwrd+fCfCK8oEabwLkBk4Dzb8RHKidoH+Q+5jCQbtxTHoblSnoS0Y0UAlh?=
 =?us-ascii?Q?2r1YbcCSy5CGdIWXBUla5MgsrtDKJqR94CjiywoJ4Np55jLM39EkFYy1aRdY?=
 =?us-ascii?Q?JqVVK8M5ev/6kY5P0davMkD2R8M46YfqB3L2R7oqj7PXtmWemOjO22hgZvde?=
 =?us-ascii?Q?U/tH88brkeTP9TRPtKCL0EeKIjN85UTyp/CJ/xp27MGufT5IgMIjqimwZD7p?=
 =?us-ascii?Q?Wx1BjU21dvx8bRVMHM+QK68eS9CbxCarqU50Du5mfj7+d7o00TUNZrtY+uld?=
 =?us-ascii?Q?je64fQgP13Qx2zuP975nIOg7Gn4hgZ94kCMSzUbZoVvCrVzp/iJVYx10/4je?=
 =?us-ascii?Q?8axwyQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f659bc-6289-4e78-7ae6-08ddbf8f44ed
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:53:41.6468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gwg+rRnPBYeu7ThsT1mQoLjk6OojZ3aR43pYxRDF0cyCictn7RlkPQWLtcSSlzDWvmDosviPeuu3M2ZOT/ojBQ8JeJtdvbO5tJi+vVJxx2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8048
X-Proofpoint-ORIG-GUID: ZtSOeCIqZ4KJcoAED6fZO15ELIEu3rl6
X-Authority-Analysis: v=2.4 cv=ccXSrmDM c=1 sm=1 tr=0 ts=686f7f97 cx=c_pps
 a=waeEY1lgPsvMgfEg+IY2ww==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=puX-rZ3iWx3qy-NnaecA:9
X-Proofpoint-GUID: ZtSOeCIqZ4KJcoAED6fZO15ELIEu3rl6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3NSBTYWx0ZWRfXxrRcsz9ToOSV
 K0AesmGB8BU7lZZcSeQkj3rcrofQ3lvFOsJmA8QQWEFuG/+TCY2IPo5wd37n+BlcETSQCcGnPDi
 wwXPVafprE7WNSHlRj5+l4qgLNYrNX0nBdeVGwkvSRGOsX2J6u+k2Yec2qD5rDotUdSo48S0a/7
 Q3QhzavLQ0tUUJLTucJl7esTkeoKkKWdCEi9Psx3wec3WkmBGTAY/7QA1r22o+SIXdWRY0+M0XV
 EOTOdTxdipVIRlLlIhtMgKI813+Uzcl6XkF3Hd8/lBsutvr+Tl8a7PncW7ZwUkjFHEazdl8hUMS
 sFf3h1PIi6i0MhWA7dZUmKs54yfBGtRDI2cBvvsMshzXVXhhp7m++90OjUHN1Oe6/YZu5OyytDU
 YeoXxtFbOZxzhnERCTWKbWM6+0oWX/n1SRv3xubNbemcMw2rvcHx8Yj3a4ldV27CuyOl3NPT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

All isapc machines must have 32-bit CPUs and so the RAM split logic can be hardcoded
accordingly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 58 ++++-------------------------------------------
 1 file changed, 4 insertions(+), 54 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 2c508f9db6..80e4ed8c87 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -426,69 +426,19 @@ static void pc_init_isa(MachineState *machine)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
-    ram_addr_t lowmem;
     uint64_t hole64_size = 0;
 
     /*
-     * Calculate ram split, for memory below and above 4G.  It's a bit
-     * complicated for backward compatibility reasons ...
-     *
-     *  - Traditional split is 3.5G (lowmem = 0xe0000000).  This is the
-     *    default value for max_ram_below_4g now.
-     *
-     *  - Then, to gigabyte align the memory, we move the split to 3G
-     *    (lowmem = 0xc0000000).  But only in case we have to split in
-     *    the first place, i.e. ram_size is larger than (traditional)
-     *    lowmem.  And for new machine types (gigabyte_align = true)
-     *    only, for live migration compatibility reasons.
-     *
-     *  - Next the max-ram-below-4g option was added, which allowed to
-     *    reduce lowmem to a smaller value, to allow a larger PCI I/O
-     *    window below 4G.  qemu doesn't enforce gigabyte alignment here,
-     *    but prints a warning.
-     *
-     *  - Finally max-ram-below-4g got updated to also allow raising lowmem,
-     *    so legacy non-PAE guests can get as much memory as possible in
-     *    the 32bit address space below 4G.
-     *
-     *  - Note that Xen has its own ram setup code in xen_ram_init(),
-     *    called via xen_hvm_init_pc().
-     *
-     * Examples:
-     *    qemu -M pc-1.7 -m 4G    (old default)    -> 3584M low,  512M high
-     *    qemu -M pc -m 4G        (new default)    -> 3072M low, 1024M high
-     *    qemu -M pc,max-ram-below-4g=2G -m 4G     -> 2048M low, 2048M high
-     *    qemu -M pc,max-ram-below-4g=4G -m 3968M  -> 3968M low (=4G-128M)
+     * There is no RAM split for the isapc machine
      */
     if (xen_enabled()) {
         xen_hvm_init_pc(pcms, &ram_memory);
     } else {
         ram_memory = machine->ram;
-        if (!pcms->max_ram_below_4g) {
-            pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
-        }
-        lowmem = pcms->max_ram_below_4g;
-        if (machine->ram_size >= pcms->max_ram_below_4g) {
-            if (pcmc->gigabyte_align) {
-                if (lowmem > 0xc0000000) {
-                    lowmem = 0xc0000000;
-                }
-                if (lowmem & (1 * GiB - 1)) {
-                    warn_report("Large machine and max_ram_below_4g "
-                                "(%" PRIu64 ") not a multiple of 1G; "
-                                "possible bad performance.",
-                                pcms->max_ram_below_4g);
-                }
-            }
-        }
 
-        if (machine->ram_size >= lowmem) {
-            x86ms->above_4g_mem_size = machine->ram_size - lowmem;
-            x86ms->below_4g_mem_size = lowmem;
-        } else {
-            x86ms->above_4g_mem_size = 0;
-            x86ms->below_4g_mem_size = machine->ram_size;
-        }
+        pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
+        x86ms->above_4g_mem_size = 0;
+        x86ms->below_4g_mem_size = machine->ram_size;
     }
 
     /*
-- 
2.43.0


