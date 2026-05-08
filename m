Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CBCCD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 16:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLNjZ-0007ZK-Kt; Fri, 08 May 2026 12:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wLNjX-0007Yr-FY
 for qemu-devel@nongnu.org; Fri, 08 May 2026 12:07:23 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wLNjV-0004SF-Ov
 for qemu-devel@nongnu.org; Fri, 08 May 2026 12:07:23 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648G6MU83458468; Fri, 8 May 2026 09:07:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=OX/GCj3jj0gJwoe
 e/U1ZFsBTU8BzItZiUKMsw5xqXlM=; b=BiYY6RHFxAX4cP+v6cRHDYxBxbNn3Vb
 YSi/85i/55nGm7IQK7QpG0yI+HMBvhb16NR+uDu37ztW/T5GCIzDdSU7a32iCYfO
 AfbLACNG1MKuvcyn/1sGBomtTZiF0QqhPUZgD2cXheDWzH+W2KnWqrqMg3jfUGhL
 hDkDen9YFnpKpazzefvZqSIy12TcEdk7NhyGBGBUr05AdnJrlyxyLAQVWTAGzemF
 aYhNCcQx8Yt/FDy6SDNj0gk2XJJ7xWLPHKoRjkhenm0FfTy8xJi/VwJTXV1UYKg1
 9R+lWgFz3EBughvELTAU7V6RX+WR8mZCbqaq8CFpvM9s9cHERau6ubw==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021119.outbound.protection.outlook.com [52.101.57.119])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4e1fqj8m21-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 09:07:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgN+S9f8Mo9BuO+iqCgot8CyQkbpHI7GJzanocMY3QKU5eQwEfDy5kt0kEdp7buD05y14a1ekMXBtwPZGYNCy3ovuh4EopdOnx+xDCNicj5ws7U0g8+ODjdljkQ/gucvnGVpo3CmXJ0ff6pHQMjS+bkd/VaeODnXAtuRVi1TKFu8tRx4YoVCy6iq1vvlsM7WxVLCtBuPXGgxLHawcJSERqaKg/YZqBT4vxRhuXZ+uRLk++WiRUDMHgoUuQXPSX4CN0J2fLL1fJr1Nz6jVvie6TIK4PvHNfR82VcsXE6l/kUqp/UlAQ7B8AcvB5qs9AvKAPQ2BmvjcFMcULkoid+3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OX/GCj3jj0gJwoee/U1ZFsBTU8BzItZiUKMsw5xqXlM=;
 b=yn4CCA03ejIb28/0k52hTlK1YQDBPrLjE6hsQyjRDwEnJGV87gFzgS9Xs0PYrTr7zHtjLiHYVwhucy0dek7I+7eNxz76It38D0PS9JmdLKFXtayoKk2A6rs5BS2QYpQnxW6ykzHowOemjCLTZRHXtzE9pWLzh/kD1hmpcHjXuKVMAIcJMyI6Z4EaNnK4JjrvRq/6c1fLKYh2JN1Poavuhp9cMvPQ3MJ3vS7jrbL0bruJgZYjIJgI5Lkse7TllbzkG6yJDA7qn7ghse/tyWQ7Bo9NEuRcWloC4rhFwzJkjQFuRiIzNo+Q4Pthf2WlVr/pAWeD0alX3qJ1sdZh1qCfTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OX/GCj3jj0gJwoee/U1ZFsBTU8BzItZiUKMsw5xqXlM=;
 b=X+lde5HaCTzu7OtQYYVkb/F7vLaSkxOG/kcH6WmnqMCv8tTmqrVolljWjgKiwPTSycpZZ8QE/gxCNhf0zI2De8mOgEKxKkJ1JxynLtZY9YXrDjzFM4au4GjOuql/OMXPm3AFnJfdj0t3P8uvBPNxvxB4K7/yYeG+SIqQPUgMuXq1bkfOWidlInibDIObyvs+tEa7b6ZHI5Xf3hdWZ22LfhJSu6azHZg/03m2ZDWF5WcKwOlR9lEdiS9wFIgHx3vDOhRi3Hjz9COD+M0MipxB5zr+jvy625P4u8r8lPKtymZts7JGerQmf7nH2X6B+6juMxrEJP1k7nrL29I0detCVg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH2PR02MB6869.namprd02.prod.outlook.com (2603:10b6:610:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 16:07:18 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 16:07:18 +0000
Date: Fri, 8 May 2026 17:07:13 +0100
From: John Levon <john.levon@nutanix.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "clg@redhat.com" <clg@redhat.com>
Subject: Re: [PATCH] Mark Multi-Process QEMU as Orphaned
Message-ID: <af4KMZqmxtvzOmDB@lent>
References: <20260508102657.644247-1-john.levon@nutanix.com>
 <IA4PR10MB8301FE3A10AA391212B387EE903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af3zEgHy7UMYN4Ow@lent>
 <IA4PR10MB83013C640DBB740BE8872FE4903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af31Oo6gXE69c7eb@lent>
 <d7c29d61-9146-4cf8-83f7-e650572b338b@oracle.com>
 <af3_CqQf1wSSWYYY@lent>
 <f91cc783-0284-44c5-bfb5-a95b4abba380@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f91cc783-0284-44c5-bfb5-a95b4abba380@oracle.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO2P265CA0255.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::27) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH2PR02MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: aa24e246-039d-4c6e-f5e2-08dead1be08a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|3023799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5xJA4VTMdATT+UGov2VBE08zHxeMBmYOhrJeEFKejMqiHpcyRPSSpIgIrPoj9atTh41rzLZAlavopjknC2wprIjzmBm6E58N0jQUjjB2jKj4hXKzAUfeg1WQ31gyIJBb7T/sIj1vQU8oxILXMedW6peL6dOqlwpYZKOA6GzjY3m2sPJ8YZl6W5O8nGU61t3TqIJ7tOi7Fez84PPaBurt778XiPLrvynP+2T+3OAPIS+T8MFUyzH81qscfY+twqnc2eCJ8MPVo3eteYqookfdoNWkB+BRpBK1ojC8qtjUPNgZ+sfNhomZWcSyymZLIWCnOoF8NfwuZm36zMpOId3RsW0EN5Qc71uHM+LUTk7LoAi0O7+tnb1pN4w5dE4F28NieUpCXL91qcdeVn1cYCsccSqgZ8lqCPeli9nb6s5LD8wLXnItDQHeOW0u8bf+Zq9KXxIy9EuxH/myWfjjMCa/THBJWdkmVsJX/w9KwbermLkVP7HxewPEoDhL2fJB5x8S8z6yD8ZCItv8NgMEXTsDExMJnrvKOi7+GnvKnFpRriHeau+Iq7ZEIOXWsORTITTC2r4blWvydFZdKJeW6MsVzWqfVpAZrFMFayKfWDY5SC7VF69AqSKc+qC5/bCdjQ74DsWmCHGniRZBLcPcQnHDyHBY1g8llcIbMVgHAMn1kgcKVn3HxxA+g4dNnFbma7JC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(3023799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4QBRhu56b04H5p+LT2UZMlAuxGmDXHO3Sck5EpF571XhU7OQKLJe8jSwkY2w?=
 =?us-ascii?Q?NbQLGr8pznfAOeH2YM/1OJOUe6dmRmzw1QkGc/vOnx/cTlSjtu+esFk/l7wO?=
 =?us-ascii?Q?vVi0bWq669qJETTyA6BaSbncr5CQee7RwiBqGGzcCU1F5R9gLJBGsP6y0xm0?=
 =?us-ascii?Q?EVa8CaDM37V5ACo+8CnfhB34edPO/VjwAXnBqBSqjQxrpvRcTR2t8Jz5UXGZ?=
 =?us-ascii?Q?82qhAEuosKZ0Fey1iMW85uZjVGbuUuWKdh60LIcLPB2lYDw9/mA7bAiFtDeK?=
 =?us-ascii?Q?OnMEnc2JnKOt1QbDCWUqhGBG0Noa1A58abddCnL5hlyAw1tctLwSZ2J4It0v?=
 =?us-ascii?Q?tJ0eu+C0lxb3NylQoSA08dUgd0eqXtbpIQx3I/pUJ4T/ew25M5l0CzXv5j2Y?=
 =?us-ascii?Q?HkVyQ2kC7IhI1dgE/F2bceh2RZYTKxERPanP9hhYTBOEO/Kj/NqtDiEqVAsw?=
 =?us-ascii?Q?IckzQoUYHJZqYAhcOjgtK1pICc8LnqkwPE8HOzdPgRqrC/Ew4lH+6jYdVyjk?=
 =?us-ascii?Q?HnQPWyniaURv+2u8yFffqYUddGdju+NEmnYVHNDK2awlWhish5g4QevgsfMf?=
 =?us-ascii?Q?c+gB1vAIQHJDxsoEUBEIbNP/8QWpQskEL6kcLL7DvXQ9o5JnJQxvjqxgDgY0?=
 =?us-ascii?Q?i9x14oDco51WWx+OI3RptRreDlrtqGQyTLLZGQqfVaD7OZCVFlonVuLa8W98?=
 =?us-ascii?Q?hAISfvln0Vb2fgDLIX4aubgyRuaz0GaGheWEwBdusuxVliFppr289NvW1xBb?=
 =?us-ascii?Q?2NElSsizc8EJ/XFYHR5WZjG08yLR+YTcKzMnHMPX9mF/UFX+swjFFOIdgU1f?=
 =?us-ascii?Q?5A5V+GfZESQjjMPTzimLwDzKCzd2UePQ+bkQlitDjog0ylMyh7umqHDHcCjQ?=
 =?us-ascii?Q?mqm+V/BL40iaTM60w442aMWDRODxkY0Aspyk8rSSaaiRHrUXIzSEO/BMnBAY?=
 =?us-ascii?Q?NS8o1AznqQInbgJqDizGBcpnHKh+qssdBD63PTdzsORQDP0YSOCHI4NjH+cu?=
 =?us-ascii?Q?+jb7KC4urz5dv+pLfc79+7fTaqBEPRAIc8Ufik7v2LkNLVnfvJt4jeQ3y54r?=
 =?us-ascii?Q?KjjuorHJ6UjqG8sI1qXPZUvKxEgvdQ2QqCiKLDwsSxZbqxKjlsT9fjSqDC7g?=
 =?us-ascii?Q?SxjuhFegqIA/0a6FNPEJUN1wnYrPEzuVlHqvTiGUaLAmVcpS49uxf4Kl5+QL?=
 =?us-ascii?Q?HWfNmaflifz9ni0jmdhGI/pWvv/KjNAkakl7674xdWpvaBk2MoQEZgRMWa+j?=
 =?us-ascii?Q?MpMcwqSYgvl9N1cin3fIwHrcJQCfty5k0ivJpQALodc1kbgWXQvIJk7qyvWk?=
 =?us-ascii?Q?MZo3K3B/wxGWstD1Ow/3gfoBAE+YrCO6ZGGAT1VIDsuTgIMBLTxTBggVM5rn?=
 =?us-ascii?Q?rqaFzVetsO1LrZGEHOpz33Oc0koD6j0TzvGSMtQsWDfRyo9sccSZht3jMWaj?=
 =?us-ascii?Q?lPwVGy7tAoP3l8uYZcO9NL7lV3MvC72nQEZI+HhUdm6gkCp7Ffi3sffg0n6c?=
 =?us-ascii?Q?KcB8il4wXBYYzEdeK7dpEpgIB3C5SHlGx5wT/Qqbyv+/uu8O2KmF74CqQ4dW?=
 =?us-ascii?Q?tL09+zkJkSZD1WZmCzAWY7oX+BSHnk6gxQtH1XIhl03YCaQTlhcwBoSXVEJq?=
 =?us-ascii?Q?itsacwifAyVq0uiS2vrat6J3D28E/a6iD7y3eAlIyZVGyuUF3jjOWCVxWdUA?=
 =?us-ascii?Q?+2tWH3fL1W7UJGjGaZafwvaX9uhLti4r5jC5EeWvtUI2pYEv7KsT1HJt7I2f?=
 =?us-ascii?Q?K2Ze0YTm0Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: uaxyrzcvtsmbHPpSPKpzC4pqeMoOyM1wee8cLfy40Uv2gHndtPAMvZ4zlL3wdQRy8JmmLt3MLA7nytr/QvmiAIhVQiMpSeM01L3BcWsnbfRLwHVqJDnGmlw36zRmEkVQJM5BhPI+vpP0RoxvByvr+C9uquwSnLC3pEVe+2c4QUmrhZFzNm8xl96cD4Ug421Ma1NXy1qxJE0DbDEI+TTzTBn3X7nq9U+LMcsyfYiSk2XsAbmQb6QK/tnDm6NhzK7XUAe7CiSB5eFargOGFTwhdAPyyCH/PCUe8DCwRqPnrf5m0mJX4r/zJHy0VcCE1WcGijK/z9aAOP/OliCnn5ljKQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa24e246-039d-4c6e-f5e2-08dead1be08a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 16:07:17.7949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5WKcxHm0dTNnEDafi17l4vBzdLeYMMaNn3msUtEV3k1Wzq345ojQuTGZBXyv5qSED6QO3293YdHXnPYAvUqGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6869
X-Proofpoint-GUID: HZdo6JN9_VlGoedHcTpA-MREdl9_fpnW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE2MSBTYWx0ZWRfXxsDOrMlxbkC7
 1nZeDLvOfP9d4Xbe2PKAPGLf7/9gxnis7yBcR//8FmbD0Y+dAN2YfqLIvmyChwgQV2afYafftH7
 U/nbrAtuN54dpUoZEP/1RKqVpFInoyAKdQyHFqXBXeWv7kpo3IM+ZNc6PvzwCS1CLJf3HCW1WAz
 ES3TOQ2vCOeIuSJuztrG1bL2FXJ1nCJFYTesgwznfhxCxAOPbvNZwMFXbWkjLcGIMODNySwsrCn
 1G97uhYoSCNf/4iqb3Y2J3Bxc5XSB+XngC4PI/KXr9VM2YGAcFwilgY6xhzOijENk+WpLGjCRX7
 NTRIRSln2+UY//VbmGRPvDKMZhplcm9ZPM8SQr2m7Nus5iOSlaKuRDDkacuUA0sQvDgJZFp9qyV
 kozQpR4TqJXIki23AsYU8eTPvP/W3GKbII6+1eFAE9gUWZng+nqPdf0C8YPkO++d4+yYNZ2BEyS
 qLqgKz6v4fpk0rGzQPg==
X-Proofpoint-ORIG-GUID: HZdo6JN9_VlGoedHcTpA-MREdl9_fpnW
X-Authority-Analysis: v=2.4 cv=H+7rBeYi c=1 sm=1 tr=0 ts=69fe0a37 cx=c_pps
 a=iRxRSAF+HohKiaZghI2QEQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=39ecexaQ9deFQpNdZxYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

On Fri, May 08, 2026 at 11:35:25AM -0400, Jagannathan Raman wrote:

> > > There's no active development on it due to a lack of inbound feature requests.
> > > Are you looking for any specific features?
> > Confused by this comment, as we've discussed before several times that you were
> > going to migrate the testing across to vfio-user instead of the legacy protocol,
> > then remove the legacy protocol altogether.
> > 
> > Then no patches arrived, so I presume that's not going to happen.
> 
> My employer's resource allocation has de-prioritized this. So, I'll do this
> during my personal time.

Sounds good, thanks!

regards
john

