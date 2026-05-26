Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0296FCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRnW4-00048g-6d; Tue, 26 May 2026 04:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wRnVx-00048L-Dd
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:51:53 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wRnVu-0002X7-94
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:51:52 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q8XIIi3288176; Tue, 26 May 2026 01:51:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=lRKSwu1llYOu+zI
 hkuirgMqUj1QmpmsDyNhpC+FKNqE=; b=IRbH405oz7j/pXuylN9MqCV9hpX7meN
 UnUr+ggtcWXRYm0mMY016jE/bEhtwjzfBWyPappWf3rlKOt7HME+zKTjxFBbnz5W
 CxFB/+iQ0X9bY+rlRYOAbOqM/bFwq3Cr6ETYeADKx9Enr7S/8ZpRrExyqLkZOSNe
 ava2FCkDdLNSomrLW1HeTFxBaUiGQz44Rdaco9uCGYkFt6jsjQq/huRS2rqx6wkh
 f6TJXHRoIEMCa0iv/vsH3Qj8D/iSr16m1JtZGcQzT+pzj6l1PAmiEuMFawjJTdY4
 r7InZrF/hrLwz47cDoI12RjJijLsvesdReArILg+n8gFA16NRmVnD8A==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022091.outbound.protection.outlook.com
 [40.107.200.91])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ebbjce4xg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 26 May 2026 01:51:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qjhg/fBlAOhWG7J/ZhAt4XksC+t0CMnRWI/Bk/uA4UYjQ+BFt3LAKg9j+rz5WaDABVH0EB7AIMtDMZsNc8mWZIzD7k3zfb7jcs93HDe5E2r4fgkgC7gaO5QFtMxzMDpV7p4cMe6H3+f96SuG/vpMuARtKhJy+Py2xVvVoyB8QSplT6ABktAeYLah0wkX8wthx4jsbZ57ys4tzM2ClLZPwf/6mB2xRCRwSObusy8YEQYlS4qmzBr2nc5Lm7uKHYJE5/gk2DodAG+OiHbMd8YA0GF/oYYPOOj0nBGnj+VTLaoBOOayHeNlhaMPSEPIEfUWZynRvAUtWJckgJALERw7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRKSwu1llYOu+zIhkuirgMqUj1QmpmsDyNhpC+FKNqE=;
 b=NBsm/sqIgcHPQkwIAexQP+kknBN1VB12tDyD5IKldP8Lcbk2WqOq6WC+jUPCxxcup1oqiI0mWhYzAPG4Ki1wac0eaaOTm5X7JlvLohCPkwnsgwu1GQXPprj72GQs22gUysWYcu19M2ytjeXH1WOauWJAl/7VC5mz9HT0v3O8jl/LyyuZ8vFqiylBuGlsuyWgQZ3/8FvtXFSQE4hYzdLj+TFFA5YFQuVqjNeeJhe4zr2vZRVj/F8+MHRtlSwwby1ejTy0vUctjqElMIPkt6zqOwTRLIjWayF9UYLxZSDe5Ue/46PWYUezhA+NW7tFv17IAlt3KABoOTQHXP+5DMhuXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRKSwu1llYOu+zIhkuirgMqUj1QmpmsDyNhpC+FKNqE=;
 b=czItZF/vHvT4GnExLu/zjbna2LjYhYw0rRQ6DdWI8VBqlZse0/+btpvjmc9WaWPcQA0ulXJ6UCBmP3c+/r3R249e8Q7POHBsyXgGWZQfOKC34qkU0FctNPuYJfXN5vLlxYy31KWm49Uc+o3fAPMAbvXDVzZWF8LKzJrIJ/F8PgvpxiZxu5ztZBgO4AsULJnKGKpPjRWR/a5rFvS2idjXY8n6a0u3Znnx2J/4XDaaeHIbmkQfcYe7pyfxPH7NDm7+SfVR7RA16J1Z9gi1698Yxe21oGApxdI5MDhePUYN+gnA5Sw4bgN1AhOMFG0HuKE8wRSZMmLoc6Q45bdlunVQhg==
Received: from BY5PR02MB6753.namprd02.prod.outlook.com (2603:10b6:a03:209::17)
 by IA0PR02MB9146.namprd02.prod.outlook.com (2603:10b6:208:43e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 08:51:39 +0000
Received: from BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::a343:65a8:bffc:5a57]) by BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::a343:65a8:bffc:5a57%7]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 08:51:38 +0000
Date: Tue, 26 May 2026 09:51:35 +0100
From: John Levon <john.levon@nutanix.com>
To: zhaoguohan@kylinos.cn
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] vfio-user: disconnect container when device info query
 fails
Message-ID: <ahVfF6LF9kHk05Z_@lent>
References: <20260522065637.4109499-1-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522065637.4109499-1-zhaoguohan@kylinos.cn>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P123CA0591.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::13) To BY5PR02MB6753.namprd02.prod.outlook.com
 (2603:10b6:a03:209::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR02MB6753:EE_|IA0PR02MB9146:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6d0444-53d4-4fdc-c00f-08debb03fffc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: yZUU4xK1eU9Rtu2vm+1+hTR85i9ETx0Mmv6zwmN2lv2bwJHYnDKZ8WcCwhrGwjXMYGNgMeZMM1zeJlrcJEXKVQDciLj6DFFDV2avRRw/cy3t1EMyE3JpYX/qM9qplry7IP1phkXh3PbDxlBsuOnaGFKNIX0565ivGsprjv1QlHgBSZiZCHgeft7Yb/3pJ0CR7OJQEccEQC20J8lgBMBI9nkrgHxDMnWQk5MYh5T0pkk/EytZDUOfxLK/fzVjLf8mxOpwnro0NUYdNBYsVHalmLGE4x3buoOMUqILvNp/uaYeWIvV9F8CrBpHAIGeKHjRCjD3JdMkTaOMIm/s9/TsQ82/wsGdKBkYvQjsWv9WWEuJvK3Yb9sir9w23i6H/YZrHpmAkCZLDPMMTHkefSewrkmiBUXibUsHHF1+GaLvV0/BEyFJHCYahQLV4j16yf2Wb8Sj4cVN2NaRjPNFLtZT52VvglBFLeB4LIZHoDnK9Q2SylJjmBxKaUUOWSYuAvhJJcGSTJynx7wp6iBMEjG7CwA8M7rz+ZYw6mgci2+uOqVyzrW7PrSGUvQmAZI5Hw+XBGHperqx9cfz6/1J6Z6kQi7jct+W85WbPpfDwT6WWikgKrlZe16Tx8UaIgoaUzBZagdVvb21vyZu008rn7u9EtXARvqBRgeDynfMUcIUoWKoQgBQpFKgVKKdEJqYT6cb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6753.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?an4vPYlwYXLWcYY6hbIlOZjtzkYlAO6lFBESEr8bz8Zq12mkZXyEQOdHjMyM?=
 =?us-ascii?Q?nJCnoo70pW/J2DOcII1HfJsE0hBu27RkjUiuB1WNfjjRi3kmhASy9dNL+RJu?=
 =?us-ascii?Q?3yO7cFhGXw2H9nkGRsglsl3/Z3R7jRPOsGbu4xWODsGUa44yhQ+p74D3X6ZL?=
 =?us-ascii?Q?Y02mMAyYyWNElKAIawbOsZZ1bc4K/7Y1sAcaVfbjiQ6h2tHCvOcAFqfeHdLK?=
 =?us-ascii?Q?NmhIxF62jDx8M2f+KIBLAOzVt4VddoMXbXB5SsoseGLw6OSWsmjQmNnJPP27?=
 =?us-ascii?Q?Jyfp1P+hUbPq7owKEL3a7RBzlsMhn6rQ6Odpma+qPmnSfnK2ZLErXCrcX0Vg?=
 =?us-ascii?Q?Y4Ijvjp2eh/UpJ10zOfegRxephtPzv3YeHjN8aK44tehTGWVjRMIj4Y9Hm0u?=
 =?us-ascii?Q?h7bpZOjk3UXPqMAukIVWHiKxKWpxtx4LEw5RAaooVE+fOueNVpWTbzWUcVTz?=
 =?us-ascii?Q?xz0gtFKmsmhJEsfE51Z7tELuRWjBRD/r5HCqTTfsJSDSdWJINzKCTchUK0/K?=
 =?us-ascii?Q?LjtcfPX771GVeORrhMhHZj8t5mxyyEdvfzdpzWI8FrUe/sUwF6ILbbMH8dzj?=
 =?us-ascii?Q?hYnEIGH6qCHcHvYlydueIL0u37WSccwRZPZPfK9Gb5+RPg8DqYtz5B9gP/gn?=
 =?us-ascii?Q?6SzubBQiOL30ghrVoylvcB16MIcX/BI6N3pLAzX0QkklRL9Xq7EtTuh3hiU5?=
 =?us-ascii?Q?hN55VGH9yj4oaY5xTlvCx/0eGL9p4VO9saXPBIgPKPicZfX7WkE3HM3L7lBF?=
 =?us-ascii?Q?7WF9wOqc7PAzwDddhjYfNb0YlGRfm0O2Ncvypx/zn/ANsT6nmhF/ECXWqB/B?=
 =?us-ascii?Q?mVKEOmtmTguspOVp0tEA6lfftGXALj9l8bYLf7n8Ne0xlytk4KqlZjt0iqME?=
 =?us-ascii?Q?dUvhFV7s6plXEQXdW8qdoURYmnEwuLN378nC2D/S9/fbHtnXcY5LI+Vf4kQA?=
 =?us-ascii?Q?x5McvwXuaSSiAORZqJ08qGjFf/UrYHHCmbldkPyoXu7QtP4jUXxybw3UEfow?=
 =?us-ascii?Q?FrCr7NIbU0pC4c+sLx8Cti1qB2nqqE69rb94Qh45ffitHc2v7b51dcPpf7ul?=
 =?us-ascii?Q?mAsyv/yV3zA58KJz/C8pnvqKxEf+BmeTxSFijuylNtDUFnM/Dfsrw9QFGJ5q?=
 =?us-ascii?Q?2bqIcXTcaGM/0Srch2HF6rzJxqfoNPLlnQNKI7e0JsWO3WLTgMK2qfUcvFur?=
 =?us-ascii?Q?prnYak+Cqz/jhTO9m+R4jA9UpmE1MhKF2aSoVTvncWFL5jFBgABjF5lEjdci?=
 =?us-ascii?Q?4Lmr9fbMDz2rAuX8bGkgXhMDhWvxiV+CU516p7axoHLnI3teOTGqjf4VgqF4?=
 =?us-ascii?Q?K0Hwe+M2qVKgLsa/rYB3s+Kp/RGL5YemApXz1K+coEKPPkRL0PQleVt0lCYo?=
 =?us-ascii?Q?c2munxPi5xaoSXPEVcfsYWnMrEUCZUbQEqKodJd2MGU8R/wRQd8UDbeKKcWP?=
 =?us-ascii?Q?29WorDtPnq2VfaxvHIG5eKIcDl2PNFDkIkS3lkHiFhZV8DYajXrlrmyIUErC?=
 =?us-ascii?Q?9ZeQnr67csiHPsuixWl/O9z6keHF+eWjmhGhTwgOH9O1CNkRfSEmKhpGsti8?=
 =?us-ascii?Q?S8zVFcq1tkEbTxeas7KrYMyrNPKhFm/qBC7Xt7zqqdiGeXBHqvuxgtmd9w9x?=
 =?us-ascii?Q?4I1sl29kNyTtKyj8TY1h7KlTAai2bmeJl0uMx9Mr0j1qWKbi1IVXHYLKTnve?=
 =?us-ascii?Q?uSKTQrn6vuM/WrvO/bJ/teMJ3GMcaHqmHMy+5UIp/RuBbuF6Br9M6hAxEj/8?=
 =?us-ascii?Q?5MjhjEy4yA=3D=3D?=
X-Exchange-RoutingPolicyChecked: ZbQqRZktSVLfMm4NjPCjaT548jyG7Jh2euy4cqW7HgHQ4r2oKVSbdNzvsj0PJL725swf+BHJ36hqY84bgP4iVxhiifL9Agto48bfbB+YDB4POTevm3GhRa7AY4/m5bNhtW1SiOtka7kEF+WNLo1qqzywjU39pwlwzsja8zN3ig2LtQakVi4HzXeoJBm6xauwX+0l1AHMcrA0MC/Y0TTzNzwnGx0orbUm9eRC3w6IBsfTPfcS6IDch+n2MTt8TJ4DkyUzDXTnFfE6ajVm3EkzhSvUtYK1fMI7b6G/3ZT3f6+k3cXQg9ohzqCBtGhT3POp557EKyDQLbQSEm8dZA3R9w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6d0444-53d4-4fdc-c00f-08debb03fffc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6753.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 08:51:38.8755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pF2OtV5O8VM0E+Hn0DmMKQ/sF2eidYA+TjHI0zhVfn0aejf4O/Bo3FVFtJwrRLcogXKfSN9ygwAEO2EUHzLvzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9146
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA3NyBTYWx0ZWRfXw+6cuiQ1lB0C
 dx38pLy2l6/+2DIvOuEuRopiC7UbPG4Psc4tIj/k6iUQUALgGwIwcNcxrncQy5w4UnC3vH64loT
 yvMri+SCsmKdL+FmOnsUrDvhvMS+0m+zXUZCRiKz9fBFsoVSuG+Ub58gXlPdbR9XmB7w8vRwC61
 0oQUDECr6tA6TVGBezEzBZNa0EbHVuhCoklYcecI+9nbSf7C0XOZN8j2qQ/6M24nT2jnq0y5r5K
 5nRFmGksqPsTH7ya3jBaUqeqlX/xQahXw7MwCaSrdfShlLxYRxGfXr/FYGipJSSX9vtn0fNeB9Q
 gZhVn1NHMpjlEUZMngACIG0JfB6VWKaF/GatUN3AytRyc0H9qF4ud7ei9MHz1ndF4g2jNILHc1G
 2BLSwJibmxGel659eDlx+C5MXJtL0VZRs9jcsOgLUIC7NI/oxSZLl6pO4M6mxPrPVgaMBfqDc2v
 w5+aWhtb42f1wIRs6pg==
X-Proofpoint-ORIG-GUID: Q2ytRZbI-ukotP6UKNbIUNt1Z3G9F9m_
X-Proofpoint-GUID: Q2ytRZbI-ukotP6UKNbIUNt1Z3G9F9m_
X-Authority-Analysis: v=2.4 cv=PazPQChd c=1 sm=1 tr=0 ts=6a155f1d cx=c_pps
 a=70jXYUHAk1O2tkEs2HJmJw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=cu8l31LVBkjbNhhADN8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Fri, May 22, 2026 at 02:56:37PM +0800, zhaoguohan@kylinos.cn wrote:

> vfio_user_device_attach() connects the vfio-user container before querying
> VFIO_USER_DEVICE_GET_INFO.  If the device info query fails,
> vfio_device_prepare() has not run yet, so vbasedev->bcontainer is still
> NULL and the later vfio_device_detach() cleanup path cannot reach the new
> container.
> 
> Disconnect the container before returning the attach failure so the listener,
> RAM discard state, object reference and address space reference are released
> on this error path.
> 
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
>  hw/vfio-user/container.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
> index 796289a46903..dc23b06eebf1 100644
> --- a/hw/vfio-user/container.c
> +++ b/hw/vfio-user/container.c
> @@ -309,7 +309,12 @@ static bool vfio_user_device_attach(const char *name, VFIODevice *vbasedev,
>          return false;
>      }
>  
> -    return vfio_user_device_get(container, vbasedev, errp);
> +    if (!vfio_user_device_get(container, vbasedev, errp)) {
> +        vfio_user_container_disconnect(container);
> +        return false;
> +    }
> +
> +    return true;
>  }
>  
>  static void vfio_user_device_detach(VFIODevice *vbasedev)

Reviewed-by: John Levon <john.levon@nutanix.com>

