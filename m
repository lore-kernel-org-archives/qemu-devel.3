Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A425FCCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 09:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Ekw-0002fP-TL; Mon, 13 Oct 2025 05:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1v8Eku-0002eO-GE
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 05:22:12 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1v8Eki-0004SG-MZ
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 05:22:12 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59D6Cn6E2986275; Mon, 13 Oct 2025 02:21:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=h0wPEpMKMA3mr0U6Fr1lRBSaTJ/a7XqcKBntPyohJ
 lI=; b=hyR7XPpiThXvn0QwqLZQuiomIHPYQaV4JmG3DIRuDetlPkT6gVf/rF+4+
 2XLDEev+2b6+YGzHoNuI655ZfCWjN+zBICyy/FAyUVxzKLQhbIfR6jMtGEvNHR2H
 mb5vfuPmRRIzBBjzVUGCdq8+a3U7euZMXUrfJSpJvNlVQSaiM98Kpz9hVqBgCn7x
 EaPvtlAB+HgQ8/kYp+wyqcurDHfmcvs6RX2rmJ7FHLLscJk/nbrUeeDCYDdyEpJ/
 scZxdr01Q+cc6IrqZXS+NHGgMZdmOua3Hk7MrFk83B//gM9EvOzuFQSS5oYKs5in
 SzPU4p9YTzlKrBiSnIkh8DSLLuWog==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022089.outbound.protection.outlook.com [52.101.43.89])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49qnbgavv0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 02:21:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWLcr6jX0Hq/tNhsF9Ibn3ZgkJ1Heih2z929GCCHfBlvJlyXnXMJIGjCm+oNuHn9BGZWWnC4N6glfhpAFwWJCObWEDQa2dwaJYClHje3sktQ53QZwLEn97hRr4KVuSVkXqypYL386Xy/4ieY0QjIPYSHOe0AtIZuNapkAlQ2taDP0OnpF1IcEh7nJadIPziA9Rk7GrL6MCqUsqvb03nVmfbysQ9mW+WcJNLhch8HUvOPsrqPqatakWIscuvjvEOMm59ncaMbGkeeM6TYfYfdmy8jOOzLg7cR6qU1CPRvMVkPb4zvW3XtQXNzaIr7nu2OVJipNHPhNakDj0701fj6Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0wPEpMKMA3mr0U6Fr1lRBSaTJ/a7XqcKBntPyohJlI=;
 b=KDSJeEgYPOmLKsLhN8XvWQueQpeMsoeiRESGESSLqlxxKP9HDb88ref8u9iXvLEHk46MF689A+27lYJGYstWm6Wk2WtTbuLC3y9XBX7MOS1Fb0VK9/Up+FCtT8rOvFxAfyUHxO/el1dTPVYKfLegV3G12d8WXvYEDOpOcP0OWLhdzQzjp9bdxtacEt+CGGjkPnt3cdv/lqE1veHeKC2JVluNt7hEeX+66e3gmQaWq+Ny0eUZgy2pTOqqFwW9N0YCIded8zSoftVrdJ17L+ezB38haSlw3oc8IW2rNuzwyd0yh9hRSk8YtCCQ3kH+RK9abG5sCXEIp74ykjQySwHXMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0wPEpMKMA3mr0U6Fr1lRBSaTJ/a7XqcKBntPyohJlI=;
 b=PyU8V6QR9sp8M26uRo8VeXA5hCIePI+jVvO5MQuJvbmb4G4tHcfVTjeiZEMn7XJMeRm0UCOSiKc3tpvGDNUh7K0wrQMKdDWTFc3Zo006s5GwNUXtvvWT4UAr139tJ3K4xmarJwUMGGjsDe/GLW6/xawhsyenQrG8G9n5KBNSJVGUfWAFGKMOC/2JC1bjqvea+WJrkp26NCUQ1DvsQp4XXp8lvjcxIunNJ2L2s6DfyUTx1vJKh67YE9Yu6ccWKoiBXaijxzoazIbHxX0HHjFzakzc1Pw5I+p+xjte5+hDoUpnixYO2LpTF2XgXDTe3yl9R/SAWAZy/rekkYPS8KkVxA==
Received: from MW6PR02MB9817.namprd02.prod.outlook.com (2603:10b6:303:23b::15)
 by PH7PR02MB8955.namprd02.prod.outlook.com (2603:10b6:510:1f9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 09:21:54 +0000
Received: from MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c]) by MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 09:21:54 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Manish Mishra <manish.mishra@nutanix.com>, Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v6 2/2] QIOChannelSocket: flush zerocopy socket error queue on
 sendmsg failure due to ENOBUF
Date: Mon, 13 Oct 2025 09:21:22 +0000
Message-ID: <20251013092126.3480671-3-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251013092126.3480671-1-tejus.gk@nutanix.com>
References: <20251013092126.3480671-1-tejus.gk@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::19) To MW6PR02MB9817.namprd02.prod.outlook.com
 (2603:10b6:303:23b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR02MB9817:EE_|PH7PR02MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb872d9-e3f4-47f8-66d8-08de0a39f363
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qrTz2TXyOSuE+WcHdb5BDP04dM4NTScSYBUg8a6ySky1mRVoYCkRkVBI7IYM?=
 =?us-ascii?Q?ybnA6sf4mvXD3eYc+UjLRZJHH9uVC4zBJXIvZ3UQwk0h07WA1l/oTtX0oxpg?=
 =?us-ascii?Q?2b7g1B5kWnJPVXmtZoyDHsUn+Z0swylYRbEmecOct9M/Yv0E0z6vTXiKVSWc?=
 =?us-ascii?Q?sgm7il9QdpNvGmve1SVPhc1YryaKK1y4pFaBXUCGtm7yDKdqqyRT0R3Em2u+?=
 =?us-ascii?Q?xvfiGD0s+w8mROId7p7S0EvKzw9CYT+6o+cJVU7to7m/kheiNw9Z3qBzvG4P?=
 =?us-ascii?Q?g1DWzdgv+gND7cxLX8b3dq/u68iG8fXiNelLXHijFwmSuewFaMx0u5f3hDYZ?=
 =?us-ascii?Q?pGyQ+UItr4wJ79onZQyy1tWXcGaQI4yKe6tmXjFC3oHSN7TfGYjBg05HpsvI?=
 =?us-ascii?Q?2mYYoUcOr2mrjIR9+qHc5E21g/RZONkxdIkYAEAeNPAPlRrhenfBZlOLzHN4?=
 =?us-ascii?Q?QaaNrXZq73b1d2zVuDww783ofinJBvlBsQG0iytwGaBvzC/gREQDl+/eUtD5?=
 =?us-ascii?Q?gFVRgA0ysAp9UfHRADMu0W5Oe4rqunRT+6NGJkXnxQHTtWQuUXP+LcpVgAgw?=
 =?us-ascii?Q?Tpv+2llrLFSlOZzlyl98NvK16wkTrc684BE/2WJUslPnK8Zaki9IEtOjaU8u?=
 =?us-ascii?Q?MRFNOjFg43CfQ749d8isj5Fn98j3x5eBb1Sn/vsyRloeVGkEnOAw6qX9xBnz?=
 =?us-ascii?Q?cPpmKBFm4owO4rYgT3yDGVo0KhS4i+e0paGSbb32wXBoOufmvooR9S/he7kR?=
 =?us-ascii?Q?jfDm7OmlI3rp3VBzCwCugB7We0NOqYuNjbl0sRpZP31t5Lwee8PY9gPeZoX+?=
 =?us-ascii?Q?XF5gXlO38of47znJIYC3rZ5GDMQXdXdpHXBUfxfMMTavfgIBE5cF22FpXmCP?=
 =?us-ascii?Q?zbURMYrWBSZ0xfCcL9bioMPULEw7Hs3knJJSDk431bO6WMuLm5jR+NSHb7Lo?=
 =?us-ascii?Q?A/cNI/bhXPu8QygFS+oSak/0b1aMT5LGUim4RnS7WMFoXrzyGE/66n5h7Oig?=
 =?us-ascii?Q?cGpUttkDObcS/iQeH8LgKCIPVnVtuClPykTZRCiqoH9bbnOJFA64Ewg6HWFT?=
 =?us-ascii?Q?YmIz/GyVg1g7J3y8OyJQ3HZqn2yuO3fBTwuXBGvOyVCeNzd/M0dhFEHPaNXR?=
 =?us-ascii?Q?8wi3ABeYhdS+B17X+IAYXCM6vodlSHJpL+nT3dfGDu/ZBKMTzYl+v1/c3vVK?=
 =?us-ascii?Q?CAuWUr+3k6mAhK02/AwAzYZYpTURIEHcabb7KHC/4J2sS/UOG+azMoWd/joY?=
 =?us-ascii?Q?nUkoI91r046AHoishuUixrLlFq6H+Pwf65VKiayY71RCGd9C9ejN9xJsRNtF?=
 =?us-ascii?Q?/l2IwzaW2O8Teji2sc3n+JrWnXYKY0tW14HLE6CUiUDo5CdZLCl9FQHHvYXz?=
 =?us-ascii?Q?9FGrKdsGB9Sk+J8WhzQ8ujGkvE2mFkIqCKqREfvRYTqrZ39rERZiHua2T09f?=
 =?us-ascii?Q?oKLO0ZZ1aEF0uuemFACARFMG70hc/jX3GNdU+svJ7An+orYEC+d84nNGeuxN?=
 =?us-ascii?Q?ew05AigT7dTiD29H4uwk9ufo3gHOLaTMi23R?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR02MB9817.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yTUooip44fXwJGdF3kusWGqWFGM5hPXURXryCtpW2lt6GzFSsWCzX0dh8lG1?=
 =?us-ascii?Q?SRJ0A+GEgn5V1pcv3kYPYJOF9G1ggzPdXaGjdlcRokKT7h36XPNOCDK6zFj3?=
 =?us-ascii?Q?/uNRY4Z4HDAnXWejUkyHEw7LlaCC+AHBWiwzQRoV4YCaDsrltAXMB3Roj3ba?=
 =?us-ascii?Q?tSe3tZixfPKSRWwZ0dMQCJcwoKr+56px62nfD0zTNCiU9LEeLDOirSULA66i?=
 =?us-ascii?Q?++bTz4UYtiPGdNIKQrnS1Snnb7i6K6HlI4xuNs2Qltezykh7vnnPBVRjyqgx?=
 =?us-ascii?Q?PjxEHaANQnGfCY+pOjZVoA1w0/ET8CnwzKcjsaI73x4hWVNTnxmB/F8rw1Nr?=
 =?us-ascii?Q?G89VvB9+8ST0+WGx/PYaX2cVZD5PII3TTzL0v0dM5PdWkmuV4vP28mRaUEZ1?=
 =?us-ascii?Q?QmORgiEKyHElFdGaU2IaYIJUye4wnwI6QfIHpBS1WNR7CK8CvWiU89bwm51y?=
 =?us-ascii?Q?DqL3pw/xavua93oPQLnKQjhQCN5vWdQS8b8Oep8jT3kH/XrYCdkkpQ6NfK6G?=
 =?us-ascii?Q?xTuGuqhJ8M0QUR1WDE7Nri1SlD96DNNcrPeSpwMQaBGjSi9XyQAiQC8YULdO?=
 =?us-ascii?Q?UjEDNkfjWoOhOtw/0q9RoAFWrVoq0ehekozPxCqm+i9PGcNS0bDdiefiK9Gm?=
 =?us-ascii?Q?nI6ISMm1hP86Ry2IxNU2fVQNLjHWKqL96Q/Ytyiv2+TZ+ok3CjWknXiwJ5M3?=
 =?us-ascii?Q?6B7kvts+j6hPtPrJulmVI+izpBTdjfJL4G1H5Kun+Mb2szmvb0ZH6KCTn2b6?=
 =?us-ascii?Q?IOf/Zg4c/MR+II9xSOpBivHY1dOv8PGz1inHVZ1QzzopdFX+7o56R9jcbE/U?=
 =?us-ascii?Q?cOSxqrnlysT+FjIXuXKCgBAM5/8vQYUaQWgrMjBnZ+IMjayweX1dC43TdKBp?=
 =?us-ascii?Q?Ollz/BnOuxvdIxQ2p+uLovuPU7XkvR63HR5qnLCV302dAMBxxTIZtzktoXTX?=
 =?us-ascii?Q?g5oXC6b9fjlZL2vtCQXyNiveAauBtP14+WjcwbdUAonYW9aeaAnQLov5YzFm?=
 =?us-ascii?Q?v08/q+GLVtGW6ZJ5YPxwI08OgV7u7sFOHp77ty5WRfFc91qi+uANLNHJ+WTK?=
 =?us-ascii?Q?duQv2N92+uCFDW1RSgxYCcTlO8Wz49vhj4We0iUE2ltZi+X8Emj/8eO/T64n?=
 =?us-ascii?Q?PHRQy/6DWlVjfuAjFX4oXrQfm9/AMnLqmB7B27obeRCUB0696gCOX1/7eHlD?=
 =?us-ascii?Q?OvhkKVXqmtXMstTFCGk+oDP5G8a0RL9QHAmiTQGrICbafl6zeIMFfFE59Xho?=
 =?us-ascii?Q?VwqpSg+jnUXKCI39QTlqS5lnqyKUldJoHHfwP8Y16HYOgLtFM57WfzOUAb/h?=
 =?us-ascii?Q?WtEqbtxBlKv6dNdRrWXYxXQ+cUXWnq1HyK/mwCqN3dLdX7LAc0v8p0OxY4MR?=
 =?us-ascii?Q?q1uCP3CLklc2BGuS69VsoNH7AS0POno4y0RhEbqXCJxLYph+fsZuX84u1XWh?=
 =?us-ascii?Q?wL6xAx/VeOEZtchuKKM1VBWWdMox5Kzx9qQ00VtfDDQbNCdwviZzKIjggGku?=
 =?us-ascii?Q?44zksr2sp4y50sdNHY0iItKKr8QVAPqtLEKbJlf8175m+K9SYJn2qipcnjty?=
 =?us-ascii?Q?ImsiT6C6b671VzK6gRwyM4wUfOE9YxCAGGFMrq+M?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb872d9-e3f4-47f8-66d8-08de0a39f363
X-MS-Exchange-CrossTenant-AuthSource: MW6PR02MB9817.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 09:21:54.6940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQTKx2FkDz7QfunsO7I6cIwKR+epX5vewqGYDc8MubxPfS7/cX21egFkA8r4gkROX9TrwaUxfbdgu5OgO7XCww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB8955
X-Proofpoint-ORIG-GUID: yc695OcdwMZU8j1uvxesbF-dyJVK6BO9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA0NSBTYWx0ZWRfX21nmjM1LtOkH
 I+yyc4srLHRH5M9QN1SWvjeElNSpSFEru2S+c4s0iwPz0XDwyY/Zq/xa+W2NHwezeaw5ZzGTHb+
 vYMMncW39JY182KcRQLGNzfF1MvAcjLteJWP8Gtxu0s7tKRKJUARP0h6zfa3kF7L+Ss3jV7lwOr
 TKmCaLpli3IoqIuiBHvXl16BN1NYDRbGdNtoUbPt5BumWdTAoY6eLyvXGkvye64s6GZub7dKOxp
 kveTQxmj8YFXd1XqC8QoD1NnTg5M6hoxTFG+r9sWTctqfIRnF/1DiZglltAiNgrny/rZHxXK5rH
 pw4X/opvi7Gx81Z5NNfruMapXDCEbqiIDjhKK4ipF9bVJi/KQcGg2FVgeYVVaOgh4EORaMizH2T
 qBagzfsJsG2BXJ2QcQp7mUJx0egHJQ==
X-Authority-Analysis: v=2.4 cv=S+jUAYsP c=1 sm=1 tr=0 ts=68ecc4b4 cx=c_pps
 a=ebY7fRpV/2+SmvP/Q3YtXw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=ZWQBLh79IfVgAdqqNwYA:9
X-Proofpoint-GUID: yc695OcdwMZU8j1uvxesbF-dyJVK6BO9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Manish Mishra <manish.mishra@nutanix.com>

The kernel allocates extra metadata SKBs in case of a zerocopy send,
eventually used for zerocopy's notification mechanism. This metadata
memory is accounted for in the OPTMEM limit. The kernel queues
completion notifications on the socket error queue and this error queue
is freed when userspace reads it.

Usually, in the case of in-order processing, the kernel will batch the
notifications and merge the metadata into a single SKB and free the
rest. As a result, it never exceeds the OPTMEM limit. However, if there
is any out-of-order processing or intermittent zerocopy failures, this
error chain can grow significantly, exhausting the OPTMEM limit. As a
result, all new sendmsg requests fail to allocate any new SKB, leading
to an ENOBUF error. Depending on the amount of data queued before the
flush (i.e., large live migration iterations), even large OPTMEM limits
are prone to failure.

To work around this, if we encounter an ENOBUF error with a zerocopy
sendmsg, flush the error queue and retry once more.

Co-authored-by: Manish Mishra <manish.mishra@nutanix.com>
Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
---
 include/io/channel-socket.h |  5 +++
 io/channel-socket.c         | 75 ++++++++++++++++++++++++++++++-------
 2 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index 26319fa98b..fcfd489c6c 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -50,6 +50,11 @@ struct QIOChannelSocket {
     ssize_t zero_copy_queued;
     ssize_t zero_copy_sent;
     bool blocking;
+    /**
+     * This flag indicates whether any new data was successfully sent with
+     * zerocopy since the last qio_channel_socket_flush() call.
+     */
+    bool new_zero_copy_sent_success;
 };
 
 
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 8b30d5b7f7..7cd9f3666d 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -37,6 +37,12 @@
 
 #define SOCKET_MAX_FDS 16
 
+#ifdef QEMU_MSG_ZEROCOPY
+static int qio_channel_socket_flush_internal(QIOChannel *ioc,
+                                             bool block,
+                                             Error **errp);
+#endif
+
 SocketAddress *
 qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
                                      Error **errp)
@@ -66,6 +72,7 @@ qio_channel_socket_new(void)
     sioc->zero_copy_queued = 0;
     sioc->zero_copy_sent = 0;
     sioc->blocking = false;
+    sioc->new_zero_copy_sent_success = FALSE;
 
     ioc = QIO_CHANNEL(sioc);
     qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
@@ -618,6 +625,8 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
     size_t fdsize = sizeof(int) * nfds;
     struct cmsghdr *cmsg;
     int sflags = 0;
+    bool blocking = sioc->blocking;
+    bool zerocopy_flushed_once = false;
 
     memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
 
@@ -664,9 +673,24 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
             goto retry;
         case ENOBUFS:
             if (flags & QIO_CHANNEL_WRITE_FLAG_ZERO_COPY) {
-                error_setg_errno(errp, errno,
-                                 "Process can't lock enough memory for using MSG_ZEROCOPY");
-                return -1;
+                /**
+                 * Socket error queueing may exhaust the OPTMEM limit. Try
+                 * flushing the error queue once.
+                 */
+                if (!zerocopy_flushed_once) {
+                    ret = qio_channel_socket_flush_internal(ioc, blocking,
+                                                            errp);
+                    if (ret < 0) {
+                        return -1;
+                    }
+                    zerocopy_flushed_once = TRUE;
+                    goto retry;
+                } else {
+                    error_setg_errno(errp, errno,
+                                     "Process can't lock enough memory for "
+                                     "using MSG_ZEROCOPY");
+                    return -1;
+                }
             }
             break;
         }
@@ -777,8 +801,9 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
 
 
 #ifdef QEMU_MSG_ZEROCOPY
-static int qio_channel_socket_flush(QIOChannel *ioc,
-                                    Error **errp)
+static int qio_channel_socket_flush_internal(QIOChannel *ioc,
+                                             bool block,
+                                             Error **errp)
 {
     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
     struct msghdr msg = {};
@@ -786,7 +811,6 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
     struct cmsghdr *cm;
     char control[CMSG_SPACE(sizeof(*serr))];
     int received;
-    int ret;
 
     if (sioc->zero_copy_queued == sioc->zero_copy_sent) {
         return 0;
@@ -796,16 +820,20 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
     msg.msg_controllen = sizeof(control);
     memset(control, 0, sizeof(control));
 
-    ret = 1;
-
     while (sioc->zero_copy_sent < sioc->zero_copy_queued) {
         received = recvmsg(sioc->fd, &msg, MSG_ERRQUEUE);
         if (received < 0) {
             switch (errno) {
             case EAGAIN:
-                /* Nothing on errqueue, wait until something is available */
-                qio_channel_wait(ioc, G_IO_ERR);
-                continue;
+                if (block) {
+                    /*
+                     * Nothing on errqueue, wait until something is
+                     * available.
+                     */
+                    qio_channel_wait(ioc, G_IO_ERR);
+                    continue;
+                }
+                return 0;
             case EINTR:
                 continue;
             default:
@@ -843,13 +871,32 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
         /* No errors, count successfully finished sendmsg()*/
         sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
 
-        /* If any sendmsg() succeeded using zero copy, return 0 at the end */
+        /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
         if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
-            ret = 0;
+            sioc->new_zero_copy_sent_success = TRUE;
         }
     }
 
-    return ret;
+    return 0;
+}
+
+static int qio_channel_socket_flush(QIOChannel *ioc,
+                                    Error **errp)
+{
+    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
+    int ret;
+
+    ret = qio_channel_socket_flush_internal(ioc, true, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (sioc->new_zero_copy_sent_success) {
+        sioc->new_zero_copy_sent_success = FALSE;
+        return 0;
+    }
+
+    return 1;
 }
 
 #endif /* QEMU_MSG_ZEROCOPY */
-- 
2.43.7


