Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E9EC44501
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfZtF-0001Sr-Jb; Fri, 03 Jul 2026 05:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfZtD-0001SU-8j
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:08:51 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfZtB-00085E-Ae
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:08:50 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635uKEX1995843; Fri, 3 Jul 2026 02:08:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=BchPwFNb+ViyMLRnCT4t3nVmncoB52tWbx7Uh+bx4
 yY=; b=U+31qfDJJdJha7l/wlswSbI+g++AnCHII9D0c4Ct2QUbA/u9KKHCcDoAp
 vHXlxaGSd3TJqrZu/WvzOZp0P/czU2t956wXOEByJQyTsEvajWvkITOA3vzRSLjT
 JrawdIFnbPe8c/DTLvxw4aJ9vjGvben/agd61i+5zgwFRECX5PJ8vTl7tSnUYOAB
 0EAMxazPvQFA7u4HlgIGTRzAenM93GHragRTEJFkwiT/1sYWlqjtIR+j+Iu5eIrW
 EDgpiZR3Fe+00aEedIg6BFqMTOSVB93ID9j/whhg1uzfeliXwKHfKiBR4uHLYzzp
 0brNV0VHzdL0lRAzizN+HSSky81jA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021104.outbound.protection.outlook.com
 [40.93.194.104])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4f5d5hc3g2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:08:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRctaGnorx22cWv+3Vz0/x3E2a3H3+3KBNDqB4pKG0G6GOZCQUoXgoqyiq5GO+JfXXmPl215raVEwGWiIisU4BFp2vjZ7fpLrEBt+pOBtihvbVcrw/ek0xKWhz/FARqjMpaiM9EiLTz+C8JDbDR1YYAjmDDnUlP4thg6QgwhBJ6X43YXFZVem4vRI+tI3P/7rprqyHCy2l3VRfTHWp6Hclg6oo8Y/v8LjFk5lBJVD6Xm+Y7InrYwsI26hbL7bzuHkZXVEmBViVbcCjFoc/o2lINdn8CZx8pLiTBgR1Lel2zQr5m+RbQyCVUPZhEsyYU3rsURVTW91r0B/JXGQTiOXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BchPwFNb+ViyMLRnCT4t3nVmncoB52tWbx7Uh+bx4yY=;
 b=UqEAC9XtaMX+nFoZMM2py2Fqv1KSee4mmrxI8zFqAQlwVRCUvuodHJ9jrtRbiTu2wf0ipzjaM+RhBWPeM50FeciFD1TxleiBZs3D3zjrLapgw5uBl5rShy5P7ZlF/Rxr1y9IDgddMbDGYrEuG8pso8GdlUzafTJ1g0Wqu3Af5UKF6RUI+09aeBYR/ziWa09h6wSIUZ5cKRykyQUVIv48fjJ5cIltAFdVHHXA7kCUo670w4e39DUd5nPIB16crFaBwJ+xM28zB+scZXQZ94Tnv1ufGShAoMeHpkszwdjzxFqSXYaI5rkuq1cMt04i8E1HsZxLwHyey+rrl9vgnwE02Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BchPwFNb+ViyMLRnCT4t3nVmncoB52tWbx7Uh+bx4yY=;
 b=G8TZBuETfSWusejz+4Ya6aQTzVStv/fmwx74VwOCrCYszHYUwpxzdAoXRI29ejhnxvq5UsmGrDlLWoBFVMMKZdZP1PBpGMiWZQd1yTj0cr3q4Cdx2WDWA8a+7MMa7fUuwYTYDei4Q9dzyMxk8kZzjuZFeEZI+NoRXlJmXVjAucRYslzi16QkLiYl3zZ3URFh8kzejj+HMHAKGbS9Pa2eyyi7G725TYtI/r51npIiwverZTkGOaisnv+gGyRqLRoEAeli/rcjF1CZdy0SPDntIK3EnOMNJ4F/M30hJfbt6f6hAzQw2M2s9g0uao5+mEmcGxewis7EpiIx8/Bqh7ytNg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB9420.namprd02.prod.outlook.com (2603:10b6:208:3f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 09:08:43 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 09:08:43 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 6/9] hw/i386/pc.c: convert rtc-time object prop to a class prop
Date: Fri,  3 Jul 2026 10:07:59 +0100
Message-ID: <20260703090814.2993188-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
References: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:208:335::6) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ea6096-b8cb-4de5-1d0a-08ded8e2ae67
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 6MZKaT47qoIfWHFt5cmFeSNlFSQaJH6dniuDfFfjhyToVgKPt7NhvsKoSRffqRtiBbyfXLBXVtdBYV6Jc4SAXUXmpeUkT1TJZUDyohJFH1AjIt7Ewl4G2KlzYXyz2Y8fxUeT4tUHkMKzRob4XzEcR0uUHJfPvMojgd6bL+zJ1kMjpJw49EPely4AQ7A1HRYA86WnsBu8qIRmA1WIkFeDkpx4STxUcgUc6+o4ylBQVnUsztIuvoMYlI8la3hmDwUgWvgRJO99MiM1a1c/5OOUB6dOQqk/UEB0b7UFvbbBroYSZanj0ECqXOgiePVvIVhlrGJdgeAx44WxYf8ai00yyjm05nZMkw2tBTEXWsQ3PchLoGoEchKyE8Ao4sOj17G1QuzHLk20aGOqZyKkm+/Jt9qUn9RKEWeE2FNyeVGE0qHZmEIB5Myfdsl4LUD7X2TVkf9GkeZ2TzEJfzstcqdb7tVIDJdQrsKwVxGQ1YqrVwUYvRBJGrpdUnAITJEpRqRkfm64VlWsdlmJlDS8ksAiYPC3Tnc1VbYsnsf0poveiJvVeac+06FQ6wWXUP6SFe7KddkYVNCJz9lmTSujFGuC/pYYs/orGAjq7bC7RRmDFGuNzTKP5ZpyRhO5wI65609r28wOtYejFijYJC9XslHb/KcPQt66FwDsXngmAt0oo5c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dz97FWQ0XkECKuBt2ap1C4gElM6epHHiFXMQ/HM2jEwfzFYuEAzTp5IOHl8f?=
 =?us-ascii?Q?N0KReMNj0Ux08x/1ErYaKXyvLYLCbbcFkW5kCJHOrdN6wBF6CQZEkHchVadR?=
 =?us-ascii?Q?S9F8g9KKqYPZSBH4oxPo0x9NlfKDthlfRFxBnGaKQc6IHWucryQUvEYDdtYQ?=
 =?us-ascii?Q?VglCRu9rLoFfKkBBKNZtD/P9/SFiMQuHRO4LU19AZaDCk+YX9tYIIinjzAXz?=
 =?us-ascii?Q?qMkFRpfjj0swbdZGdBeDjVeeGFjnM2KGhotwByktVogqYCrOR+wmBOV08d1g?=
 =?us-ascii?Q?CHpHST/7Tbl7xuvHPHgffH5uIlAUgyTBJdqNJd9Du6MTJ5s7jYiHeXqF2dmC?=
 =?us-ascii?Q?TCBMgXhS4lFqRjUaIZl6yA450Ipbprrq8yzsCHx+j45vSgzRfWXU6ywSHRT2?=
 =?us-ascii?Q?S2AOJEU8fyKl+8RUPjQ0aAgy/ypIxYPF5g+rzaghqD1OQpIG11TGk8a2FQIL?=
 =?us-ascii?Q?3GKieyotj1ZM4HwYpv5o/d9Y9x5nOj8B36lTXP5/ft+CkcRDa6RVUtiKvUZA?=
 =?us-ascii?Q?/BlYVznJEkS+c+pf/cq61VMbmXynzvMkXbahr9nbJKOJf9CNAnXaHhWeIcLg?=
 =?us-ascii?Q?G8k9ls5oUGyTJXB56wOZaf5E8iGTRkF0f64qU56fXQ2AMMNnnTvoWlUK4nve?=
 =?us-ascii?Q?OpMFCiDTZiv/6Ca2yNWnleA6pvJY/bZBC9mjUuoFWySB67kqERilcHNmns+D?=
 =?us-ascii?Q?JfqNB3KD3TKlFug11UBmPxCdCIG59IGPyyW3PQ4+86zVtZqKThlCNSdXFKe6?=
 =?us-ascii?Q?DiSud8ipq0/o6GEhRLyBshk4bDTkU5XJ/yV/oYABIi0Gkf6pskCIiPriJaZI?=
 =?us-ascii?Q?WePUGUoRwtKBf0UZtuhS9aUnzgn4HIbdzlB4aUKmQQ33AiVQgbGPzcADF8tY?=
 =?us-ascii?Q?M0rMzSPM/8rzWx/tLbU8QWOy/AWQIAMKmI5NybL2LUMD2TFfjPCvqjoDGEhc?=
 =?us-ascii?Q?VGCGIz3wTDEbd1CQx64HZyIxKO18tzS6dnAqlHvgdV4qtiPEt1dCbjYzCS3O?=
 =?us-ascii?Q?VGb8NvdxxkdzStF2fBwcAuNSY7dTT4Z06D29xve/E6hLZZh7txiqRvQmC2S4?=
 =?us-ascii?Q?VNGURLo/6AS9q55HanT7ZpxW62OBqBWpWF1JpE0prc9K4vgyOjjBZS1F95/G?=
 =?us-ascii?Q?89TYjp4Qa+/mk9AmkJDHlLLkTGxiy0GZo4Rzj1gDGh0AIsE9NjyPdieWbOTz?=
 =?us-ascii?Q?SHzOKPpFJKM7Zyp5/ALwxuthmqExA/hzwfwH+dNx8ihozBaPboh+THgrIbX0?=
 =?us-ascii?Q?uLfAylg69StWS0vLzlLRZdHjrAKspwK683Q/FWXBbkaBzay4RkdoiBNJmmdN?=
 =?us-ascii?Q?33c8/AjDNZeByE15E4AQVK95BpssFmSCABZkjf5N7lW2mwbSNgdaHkJIk5Vy?=
 =?us-ascii?Q?s3mYZ7xWRCS7jzoHoxyjhtoDLqZi/dU0pZLAvAsqq0XPb4rpkhmR0Bb+SpcO?=
 =?us-ascii?Q?10oOGlvhVTOWGMLNnUTtLfWYKh6wS4ZPxOJiF28y/8Atz//miGeTl86yky7+?=
 =?us-ascii?Q?/nK2Oy2cyewWKQNJPwKvyoVyqmT/eYm0fwYJOXjThtuSnn74GM4rnygyoool?=
 =?us-ascii?Q?Pl8nw0TQMGTir6o7cmto0PfFwSuopeGMA3Ke9AWJZl8lZpT8uqtKPZRx13JO?=
 =?us-ascii?Q?CApH1RvI5SZrXbQR7LhrrDKbQrgv+1vbFPPFLf0LQleMQBsk7Utogb/z/PS6?=
 =?us-ascii?Q?XTnSCuzwglM27OAfo1fS/2z5hG/jzeISdOzsjmgACTdSPwbOjh61sG6hDYFw?=
 =?us-ascii?Q?oEGG0FFoYjcDjlD2knrnCsTBZuBkLPs=3D?=
X-Exchange-RoutingPolicyChecked: idoV1lCf1vVxoc8ls09COabw+ZrPsWlQxcwWqEGQrVhMEg4mhLdtThcUzQKBn3mHdgiSQpoX/APpoab5Nen0ZRGBrV9UZ0Mt+a3WcbPvd1C/ltYqzERa2ZFJs0Sw/jYqzr1/FvvNThByzb+tgbQgFUN1UNKjt/70pTSsO0Fqv9ZnJNqZql+636sxXghOTxNAnDPebaLfoE3ewdXdDummvN3yJ5LXwbvFLK+v1u9zNpCbW0t2FVQmz68zeSTjb5BkUt3HEE7WNwSi4a04VOdVs9/a5XUvinXHr1dN3DW8drnGfsMkjPg5/IIVhp28dEFCINauvdiUY4AmSM0wPX308g==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ea6096-b8cb-4de5-1d0a-08ded8e2ae67
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 09:08:43.4168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tp6q71ml6S31bOYvWznNxIU1Z1RylqeLUOJzu43iWM3P/1VhL+6DcowsU6wLTRqXDf4I0omyTYvooyc6OATBzYvJ36OJdTcVZsEDtR6NPQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9420
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4NiBTYWx0ZWRfX8fCv7luJmzzU
 c7bvZ7auBJTGb4cv3DVBh4jLIdu0W7Hyb9xLlS0nncCywCUOdFWMGFrhozIp/tA3nAs4bKMtWYs
 EUU8o8TtTUnNGN2L+pf1P/xYLmIB9aFQVf1muGjNHxefVsJkJKxpGQRw6rL+IrX8GOvrb3nn8/x
 HlmVdt/UIkK4b4LeBzRbwPaHO/LT5biMdXtEspEFGDUc4LH2qvitmHjPci5VJiWnGO9cN2ddo1o
 fcqxtHd061Vop+IUdPxQoEKzl4gEBMNSaN/i8zsqOdLKMjM1h7wmz0BOkfp3wLuffJGXG5BdZ+A
 ZGWs7teAHTaLBHVC0RVuPFzNsUk8VhDIjIOWP25l9PKXmyItOwRDC6mOWbjxi/KU0jZcHVlKnVA
 lhpA8cdUzhzmsXZ9dYvZLXLdWOxmv9mCeCNvO3Cdzwcw6pygbGp2sDBdkObYhR6xolyVOnIL/Ds
 Lzs3jEyfY7gb4TNyDJA==
X-Proofpoint-ORIG-GUID: 0DfIAIlDyyb2V8mX0nQm3O5qR4UmkMQz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4NiBTYWx0ZWRfXy+GOWbalvhE4
 C9lNay3tIv8Q0iyqLqn4Qsl5gMpRBnJTaV65eJQYmJb8hvbXoja1uQyjzEy3g4vyWX8SzQpzNCH
 mP4+ro1okpYnlyCjt1ezxJxkXlnRRzo=
X-Authority-Analysis: v=2.4 cv=EMM2FVZC c=1 sm=1 tr=0 ts=6a477c1e cx=c_pps
 a=zDPZN7IXkwPire9PJGhe3A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=DDMMZ6NTPqBClWpVUZEA:9
X-Proofpoint-GUID: 0DfIAIlDyyb2V8mX0nQm3O5qR4UmkMQz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/i386/pc.h | 1 +
 hw/i386/pc.c         | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 843a5a9e1f..309de2eda1 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -39,6 +39,7 @@ typedef struct PCMachineState {
     BusState *idebus[MAX_IDE_BUS];
 
     Object *alias_pcspk;
+    Object *alias_rtc_time;
 
     /* Configuration options: */
     uint64_t max_ram_below_4g;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b049c9f880..b3d4a26c94 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1094,8 +1094,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
         qdev_connect_gpio_out(DEVICE(rtc_state), 0, rtc_irq);
     }
 
-    object_property_add_alias(OBJECT(pcms), "rtc-time", OBJECT(rtc_state),
-                              "date");
+    object_property_set_alias(OBJECT(pcms), "rtc-time", OBJECT(rtc_state));
 
 #ifdef CONFIG_XEN_EMU
     if (xen_mode == XEN_EMULATE) {
@@ -1754,6 +1753,10 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
                                     offsetof(PCMachineState, alias_pcspk),
                                     TYPE_PC_SPEAKER,
                                     "audiodev");
+    object_class_property_add_alias(oc, "rtc-time",
+                                    offsetof(PCMachineState, alias_rtc_time),
+                                    TYPE_MC146818_RTC,
+                                    "date");
 }
 
 static const TypeInfo pc_machine_info = {
-- 
2.43.0


