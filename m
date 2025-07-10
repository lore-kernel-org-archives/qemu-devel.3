Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41A5C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZn2V-00089t-QP; Thu, 10 Jul 2025 04:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn2S-000805-Fa
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:53:56 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn2Q-0003Ys-De
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:53:56 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569ME8IM010890;
 Thu, 10 Jul 2025 01:53:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=q3jsS/WCSFC7H70BMqgDzBvpReJeR5JRJpOazWCmV
 RM=; b=wx/vWVlw162xEIH3/oIYvv54J5pgC76ZcLOKN5v9LR0TE+KYfa+MmjJeM
 XDvQSJ1EYyiOmfm1YOz0Fw/oQcY0zb0zhQUxtkWfZfq0+vOX9+JDbTiRA7OpHoon
 by0sjqjE4beT4hg+BQG/Dp0AmmWNhu4CPAHp2a8F/MEek67dBfQeuaPUB3/2SSrK
 JfTZI1NiRbYHze51mJSCj87F2BDfGeTGoqhPER4IrSxJjqZkyFzt0kytqWfjpm5D
 EgB6xUytnrZfW15P9+AFUooZWK+4wG5QKixJbVnp2dyPu0F76xBbgD35R4ngcyVV
 9dpvIp1q8oHd3KLm5iOo6j7HRHEJQ==
Received: from cy4pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020102.outbound.protection.outlook.com
 [40.93.198.102])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47rkcn12jy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 01:53:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g636X+ATQOTPg5KuNvYZ9Pu+h3sLjecJK5xjvFgKBTicFXRS4cnEBS1W2gK0bK0dXNSFDfYL+qgvYQJnq8E4XXln+T2k4MLZGQfti+NGCBvXTzXwT3y3IDNSHIp5XRSB8eqvCQ1PpON9Shph+asMZRXaKXLOftrpzLXzhhgC6aWP97UoHVnU+RREh77YNStMlANo4uVI5LIaduu9YERZ/1i8wBbXrEdATrO5mgvGu55OqjOD/1OpVGzGvFNwc7qm01bPnqjVR40swjY1+U9hhl7csYqR8nE7lO6mPlh2XvaOS+Q3NyRiQYVigAVh/bLwdCF1PKFK6lpU2tvIjxC1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3jsS/WCSFC7H70BMqgDzBvpReJeR5JRJpOazWCmVRM=;
 b=Ozt6WxL+1DtT8aZK6AsPGvxbsa00NIXEjFMBAISz7mG3xQ9M6TtsRQIusghTWiOfFvH+D3CbHG7yIQHelKkzFLPICqbQ4vApP9FlC+mwZRkibhciLKhR+MhUOQD5IXmB6JdKvBzdS0ZqOO9bDkBq9203acmtHQ1m0V96KthRpT11l0x2CMHjRns2zt+J3CrgHdKpSA1kzGS+Fn8+2eiVlS2T9kFqTtfB9FP83JwZqO1TRyyBxctHiOTicCeIHfLzRlK1llNtIh670khgw+DNysGp7G8pvXELpTNEVO9EJVXjUGR58vNbwJ+YBge7qJqc146A95fnUW5pdpr08YZMxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3jsS/WCSFC7H70BMqgDzBvpReJeR5JRJpOazWCmVRM=;
 b=OJUyuxO0iAnLaDFJFxyrGsoImwf2pkT0MwWP1kgW1bQ5H64HNCHKfYJt8/P6NWeJ3uoWiz0jx/SPLFIXddEz5OSx3EwL6+0B59lUWbRZcEjAcfxvqluDYgYDFXwJwGA7OPIXkReXXbbUzxq2QFXn/FysFbAhShLrycumdSfdJy6BHsX+/cMC89hkHOp/mTQcQQZAYZcTDO2tY1jpXoSMt++8EYPIhHKWyW0LHTlswi0HZOQ7wWdlG78QqdPI2SYvpc5NuJ7aaHavXhjwHYfI4NSvJv19UpKWK6x/eaqmonXn5AavIBgBfRfQJk3Z23+tlVNGmRANNEPLgbRbczEMIQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8048.namprd02.prod.outlook.com (2603:10b6:408:16a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 08:53:48 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:53:48 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 10/18] hw/i386/pc_piix.c: remove
 pc_system_flash_cleanup_unused() from pc_init_isa()
Date: Thu, 10 Jul 2025 09:52:25 +0100
Message-ID: <20250710085308.420774-11-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710085308.420774-1-mark.caveayland@nutanix.com>
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0029.eurprd07.prod.outlook.com
 (2603:10a6:205:1::42) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: c340f9e6-2532-4118-60bd-08ddbf8f494c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Dp2ShkTdZ9qZjXbd6u0H4ACBydN+PMheWvUXPIHFyj7o/gafKt2pCO+bzAG/?=
 =?us-ascii?Q?EnDX8v0TX2l1qsaTWQmEY7tsRNVCSaekfBfu6z0MGp7bcTAuN1F/p7HqcXgu?=
 =?us-ascii?Q?lSnMI4OcsCDMWriubUfiViVjF5a5xrHX5vEsxZvIwwM+FGx1/KRGCQ6Xg14H?=
 =?us-ascii?Q?jcJLOIdC7kpFCDguuLtX7/SlvFku5kpz1X8Zh3I6Z5uD2b2h7v2dRbA5EcsV?=
 =?us-ascii?Q?zL6egYOEM/aLXItCn8YcKC8A7GE1raVEpWcA+SkXbtyephMxWNKiUyp1rRSl?=
 =?us-ascii?Q?2PEeyqoQkoDaIHWFDadmqBTM90kXLBxrdzz0APzT1bJCJAMIF8w9mclkvSlt?=
 =?us-ascii?Q?yk5YJYOgW93q9FsR9Dotyz4Y77ron6D1sB7GYg/O/Xx27LXuS8UR9JEerQb+?=
 =?us-ascii?Q?EJ7nQKIGZuET260aTZQub3/7pqtNuoD90cX8oY/FxzGv0T/ytOg6RTt+8z4M?=
 =?us-ascii?Q?5ORNTfShcPNl5097I9lffjubxI6L7uJD62pR5IKIcx9aA8GDIfhDnjnAEDrL?=
 =?us-ascii?Q?SkMk/S7GK5fKIeDkrA5ZEAVOHHU+HVY2XrCDyhQL6VA832HYZQntM8jaNIKP?=
 =?us-ascii?Q?cjfYlmny1UHJkGN0EF+QOvvuHgMRFUl/9KBAceK63afxkmtbIhtKLMxezSL/?=
 =?us-ascii?Q?QIOTHlAx7tb2wxcyYv5germI06iYwybh1lfRgN3/V9takhhgz6W5Y8sHSFV5?=
 =?us-ascii?Q?0h0JLNWZ0UfnSxx/EqzDDjV5AOFhtXpUCXJNUkYgA/SYhaNCDjJUlif8LUvH?=
 =?us-ascii?Q?FyvKZRdlTSdtnNfTPyU422ilJK6MQnhADSMZ0GFj8KsVSjYpQtRB5AOu1jNa?=
 =?us-ascii?Q?tnepiOzD8tiF4do+6ZdbhO5D1l7Do9jn5t1mO5XBCXd23LRzsJYZpNbDddYG?=
 =?us-ascii?Q?rEKzKyceXDUxaBOUhrzL8vYJLWRrl8t7+a6+CXmWNStfANU3NKd8IjlXrB06?=
 =?us-ascii?Q?eA4VLcntV5LkPYFL5esmrxEGcLZ3b9kwYFBzlcBdX0kuAKedpa9ZUW7Wq+ze?=
 =?us-ascii?Q?cOdKKNhSSjtFd6FZKe9zyeHdM+NHMkH6Y/SYxaLLjQOVEHVo3SbgvsTQZqRW?=
 =?us-ascii?Q?JGy4C3M1tBfoMHvMAikfqF2wT1xQ0ezBnXg30aZPXqcPSZJLOkzzn7rOPeYU?=
 =?us-ascii?Q?5RyZuanjXFlw6aFSYvqO3a0q0rqxEDeY2DXJS8/jmOcj07RiIxGPQJ22PX3W?=
 =?us-ascii?Q?sFDvwGgpjyERloeeJkq0hmhfihtoboavVP9t4sCsyzH0WVUkGoZOnt+w02U/?=
 =?us-ascii?Q?jotAOMcj2JAOA8YTNjkZqC9A23ifJbFAXnm83Tl6OlWREhRiuZWlKkVNaZCB?=
 =?us-ascii?Q?U3YsVpWYasJlOKBmwalBxZqgzzRPTQoyPMfVYMwB6w8TPkwFHJrqWf+zLwqo?=
 =?us-ascii?Q?1uxyErsIG0dxWuCwjeymPc/k+3rvJLUnAT905VH01PooaSPlSDyT7WIBRC3O?=
 =?us-ascii?Q?q32W0auaijE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3t+gx0vw8E2YRto8MP1wyskimkHO3Xh1ZHgUWLCU9zMoZtQfdDxKH2/jC1W0?=
 =?us-ascii?Q?crJqgZnfve8bKlTH6Sg0q+op2IoTUv2agZQuTnjaOIBAoKWNW9Y6OyLzJfnV?=
 =?us-ascii?Q?o/OjGgKCmZ8mWLezyqeQA7eugVN+LEVXjm1+iV4mtajjsqmtJG4w393igP5+?=
 =?us-ascii?Q?G8nX2wc5NDZtRwOis9ixlB39sFjTzP68olzmLhSP0CfZlwE0GTgxaPs4jvxd?=
 =?us-ascii?Q?sQmwICkYj+NiemH9ODMe8c1YzRfvlGbpsc2ogCu3z1eVT+Rdnzcz4SAvjlxv?=
 =?us-ascii?Q?qYKh5nhjDU3kcjoSmoySIF5We7TROiGFC8GR7hHeB2pwhSO5EXgsIOqyRVoR?=
 =?us-ascii?Q?leGP1tvRN3ROuiLKN24V5ZUO/dEs8cMsgTiHwBmHyHb1qLKciNGZrSVYc2OF?=
 =?us-ascii?Q?pPB/rnysv8aUbXPPdjaI6URLNztXSEXQKpLF6B1NUySgOeWto8iTmzyThcHK?=
 =?us-ascii?Q?ACDdcxLr2fY7L/4pzY6WMBHQvPifZ46p3JfW+TJQ/d0QNMh0EO3MCrtC+P6m?=
 =?us-ascii?Q?nY3PUrVR1GSwusYClu8w6ex0q6oSSnsXvDpDYEsFI4vSkmvUEaWVO/Whr/jF?=
 =?us-ascii?Q?hAs9f6EmMVHGgM/sotq6xys1TdU9pj9w67n08QKRpW5wg3lEFHmqOZwKRWFg?=
 =?us-ascii?Q?gOTzkT9TdmctIWup1K0/dVzlcOTwG6jQqYi8wl6TxXfohQhofS8KjY99Hwh5?=
 =?us-ascii?Q?ae/2ZHSl5YiD1MHSKlQRRCmuMZSg31ZIPjjZ5WkFsYCM5O9yfUWTOba+KEyk?=
 =?us-ascii?Q?uOUQpSTsONG+m1wfP97AaegYY1RPsvk3rSF2/r/P4gyAOve4KqhKgs33DmN9?=
 =?us-ascii?Q?8UnPjJ8QzxyRFfMonSDnpkT/1fYz3+eGyB7DkV1CLvSj2FbPkgZH+9TEH3Mn?=
 =?us-ascii?Q?xPVFh64AcBQkDJm2rM4PPlxw9KatD/fnXvSRhkEBAnmQFfVP6SUNv0o3dINK?=
 =?us-ascii?Q?fxbMyRELjnoqhlkJ1mDnI/fuVGygXt1vJsZK5IydDUHCVMm+PArbkrZCjIw2?=
 =?us-ascii?Q?7IY19Uy/V4Z4NgZlSFaQTNgAUsVF3nP/45MWfixmbHLAQpSyWM9nLu2ONJt2?=
 =?us-ascii?Q?YuKlvRzxT+X9Ktc/gk04rK/YOoFFLcJQWBVoz8KRC/UujrI5xhjFpCvsTdVY?=
 =?us-ascii?Q?+N/6LNlzROmDAZ3zQj9pZbqNCYw1S27G7W/o57AxnnsmaxAoU/OdrMcR/hOu?=
 =?us-ascii?Q?lx0Z3IGMA8/UGnWnIzrCWObjOeDkoYJKliUnocQAhrJobJweueS1S60bcily?=
 =?us-ascii?Q?FX8Na72pp/NpwL+av+NyBFeTMPqArK825vl4tLR7KxzBqda5ki13bClaUGpl?=
 =?us-ascii?Q?S0zPe2npoYDKT9D4HobIpGOVeGlqjg+pvNL2NlfvNd/eI7GSNkKlGj9hXce5?=
 =?us-ascii?Q?waryZdHfVfW/UUKtGzTEoEGkr7L12WWeOgIPXqjoo9kvuKgug90c74d4ZOcR?=
 =?us-ascii?Q?zFIEMM6vUgFAxJy2lIjSwhbXjmt1LhofumtRN7Ii1QxHHfsKsbVIvDGb3WQT?=
 =?us-ascii?Q?NCcjMP6eonccegNAoYRP6ZGi/2GeGryosgmeYabpOeAAl8kDxCXyyNZuIJr7?=
 =?us-ascii?Q?otZ3eOpup54yeix5IRKuLESrlLgran4e12bwdKIW/Y7oLcHx1f8WYxMWTxFO?=
 =?us-ascii?Q?3SlMVGoNiEWACNkW7iGRhp21nfVSU4zVCEIfJlKTkGBGILnxepwCWSaZkH7c?=
 =?us-ascii?Q?V6yWQQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c340f9e6-2532-4118-60bd-08ddbf8f494c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:53:48.8332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrUqcASEQRui/zsYn3zAlTARFpa2TCer+yXv0zguth5+PtHhXSeq9t94iuR2KFlNHSB63tQXGLXAHnb6fuArKD/no8nX2WT2ABM0xYNYPKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8048
X-Proofpoint-ORIG-GUID: Tq3WBmIERHVDGvO-qPIae-xajlp-8sxT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3NSBTYWx0ZWRfX7TpbQTtYAx1G
 6VTWBXX2/NDBi5NJFmJWCM9xxVdX8+GtCRrAVu0TvL2Q3q3CA1Y1xhDY784VeAJSB3MYTAezCHc
 /RKLMxTje6avv6FJ2iGdDmUyWHsL9ETksRqmEujl652xwxdALVJFnowF6q89aG2L/jFQw0r37k6
 jGDmMt/VaClmpLrz7JnKxUjhT/5OTD1nKZGUgIf69uy9JeSL62X9bMx10uT+Bu2UGdCjFEd2Xe8
 AfrEUD0mqkCgA58u4ryivu8JKO/4da6Tqoi6fnReHRyudDDfz/lrodZtn6yDW21+nUj5wbzwHu0
 zMRzQO+WfvhXMj7fu8/7lkNu3+CG4BMWGK5rz6f3P1ST0NPJLoM0OFN9SKPQk5sFmUHCpnXJ9V2
 qIDqE7Ewch5Vxf4YfE8BRJjlulmLGyPcISPJzbyu9aGhYONM8su1F6MbcG8SdGENT3X4cjPW
X-Authority-Analysis: v=2.4 cv=KKZaDEFo c=1 sm=1 tr=0 ts=686f7f9e cx=c_pps
 a=cPJgcE//urRiG05FhKkhAw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=mnHwG4yJ6Weg6gPWIr4A:9
X-Proofpoint-GUID: Tq3WBmIERHVDGvO-qPIae-xajlp-8sxT
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

This function contains 'assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled)' and so we can
safely assume that it should never be used for the isapc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 48d0b2f5b5..f09ec48c0c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -465,7 +465,6 @@ static void pc_init_isa(MachineState *machine)
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
 
-        pc_system_flash_cleanup_unused(pcms);
         if (machine->kernel_filename != NULL) {
             /* For xen HVM direct kernel boot, load linux here */
             xen_load_linux(pcms);
-- 
2.43.0


