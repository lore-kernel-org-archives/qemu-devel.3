Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12915CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHir1-0005VV-9O; Fri, 16 Oct 2026 10:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHipz-00047L-PV
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:23:12 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHipx-0006oR-2f
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:23:11 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE58vd1681992; Fri, 16 Oct 2026 07:22:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=SZiLewJ31Wd7JJfgU0jxATyKUq9AnyFgswSLPaZDy
 F0=; b=XAtNRB/9LSRLQ03Evxm/7s0T6/VsRJo6Xx3cbP+NLbFo08mklCBriInnO
 /lfqsNeYQnmHZQcve4Hs1b7Fn+d9x+/v2qoTmTUCxlQ44J4PAiJbPcCveQNXtVXA
 XAil/ZGye+7QwwhqO5LcNpTkBZBC4KhSYsVsXCGI8LSYTND2hLG80DbVIpSSZWmO
 kI3CvWG4dh+LhakNiXaRUPzhF0/Dl4K3oNq9W/JotyuktMlCn6FBD43641JJREjG
 IsX/zBbIVM/73riqjkEac+jnpm6XOW9u2A4CPEWjphwjJrdsEh9HZfWyGclgowl8
 XZB0Aq8Xzp6VDoKDt7lCMOwv8y+CA==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021130.outbound.protection.outlook.com [52.101.62.130])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hberu10kd-4
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:22:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDmQFU+jWLuGzDPNr5gN9ie3gVpdRgnyRHRuF+4UNXkN+IP5OSHmFR+5fTYafYio8JI69JEMq3FRDvXETKwRA+r8E7bN5YCVzbATbebQSW257CTmeAtW67wHm3p/kx7EJy5ol1JlVo/Fr21/DsWsKGfvvOYLk11xzejVHbHpI7MuJ7PmcYaaOED1HkBWMK+7kr45NnTRHRMsf0A3clHjXduUaRtfC4MYn9Rt78MA/UmT1S4cCPm2n0sj4LGhRHK7kcjOk37w1rxSxb8t9+zKtvugvC0GZ4JT6doF5xyfKvbF6CwQtneYM+2KAhoHFCP3jwr2619YEdn77AWaaJWzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZiLewJ31Wd7JJfgU0jxATyKUq9AnyFgswSLPaZDyF0=;
 b=o36nG7aSfMKv3U0ayxnLRCurwYs3C1OgVmZv5MUoZ04PilzzQAzxZa56/dHdRtbI2AOPUgvvGDbzbtcKDEylakQfvTONaU/tc3DkSqz10x0j1vYzzp7Fmg45lztBnbKUFaf9wg3P1760zpZ6F/AdJa+UGICnYonE18nFHPRdN+kih/6o1LS/Aw2L1TpzhkOjSC8VsL/MFiJ3QpCSDOkH404jwCiDsenGc6BPjgwEUW6REdhaOVsZvzLjwLdybmWbLh7duCwa83d5Qh2rxY8eF8xRgQaOQqrLOdoUjiPoV650OKreg+aWT13DbazxjB9jWNEuX08onmZRqKOgZNPZXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZiLewJ31Wd7JJfgU0jxATyKUq9AnyFgswSLPaZDyF0=;
 b=VoibuK915YUUpdymE5LbUi3QQtpUMzJayNz93x8fpaui2J457C8XvP3j5DDu8fc4H8s90tkhZbbPHTq2L/UE5N6mmj7zV7GIrgikuwvHG6MuJd0Y4l2dPMxfKgiu3ZgnA30IConpGLUMV2ofE4E0ZgMR87FQtyfyVTpXNYUKaxvra3M7ptTHJW5ijSA5fPvZMaXdZLKUf5vqF0eoiDha5O2kCnAyIJv6anV++LWuhJarxHc9S381etHyp3YXiD4Ec0L+YhUbbVCtATpsI0wTxGgSqV5fPGi/gbyshhOswDYVLnCN+kRjVkEt7iXzvvNuNme2JIqMCxcFw3znFfoiaw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB9592.namprd02.prod.outlook.com (2603:10b6:208:3f5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 14:22:29 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:22:29 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 27/27] i8259_common.c: add missing 0x prefixes to "info
 pic" output
Date: Fri, 16 Oct 2026 15:19:33 +0100
Message-ID: <20261016142031.1204281-28-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da20008-61b1-4057-26ab-08df2b90e8ec
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|56012099006|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: FIXPZHn6f3jc0f0EDgqQ5Fx9lhzvlYuJavuykZrk/DJJt8fOUwijRpXVrvd3p/y4TGT7s84MGF7wJrN699RoTzipG8ZQvFSeelkqixINSnK9Oby+i0LRKWFXo8TJ4fm6UtJ86B2kPj0flW7c+LyvyUoUOaABh9Od1MkcZiXIFNIehJAixdyDxG2JEIWAUGluVweXMgO9akHOZpCiyS7uyRCNoGg6f3APWUKfJfLCKJsIlioDEjq6XtXH60YQBmgmU4q02xm7g1EMlstwpN7EgOJDBvPon6bUNELeCKTzlodxxKntxyIC6pFNOw/LCo9eTijHhg5kq0+IzpOVF9L8rD7GEvrpJj7w4woJi24TiC6i+fb+bPIWFfdf9//1ukXEhOPFBY6xHnnlQlQ3CYAjiMM10Iqtbx66HCujLjwxu6G9wLvJ5vqjXc1gbS4pNf9bKGwN7RHq0cJVBsFyq1DCSmejqo5QfDaTX24av+GrbfnEMKdtGp+bURLvCKlZPNdi0eJTErvamRLFZZeqeFIMB6pydlX4Q86ik0BE+9H6qWU2oW1MUEVmI6Z9P65morTY4iSVVHF5oey3RSZ7w8dOxBaf3MMvFOC9yAifGktbL4rlO96zJ2k/4GzuC9kuXERa5vGo+e287UgACyFhuwaerlVxn1k27kuxmr9jK33e4RY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i0kBk5vysg6PjFV+f7Gey2WQubxq9Op0SvUN+j8rEVFGcgf7NHUCjuEA1Sh5?=
 =?us-ascii?Q?ONwepzBCBC5GpfXPPytTRXCuBBxIaEoEeOzdHK+D30xhbVwQbyC0PRyD7rMi?=
 =?us-ascii?Q?/6KPsqY+7MpQ8a//fi8gnLE6CGQp7h4Im4HdzYaZh5j4xySuaFYE1Z4IMtj+?=
 =?us-ascii?Q?1pzXseygcEnyOfT/YJARVhvmqHZ9F+O4/gQb1KDIsNx+fmgICd8Izia/WQo3?=
 =?us-ascii?Q?qxbUG6VTsxJ74t5skfXIoExfJ7ETOkjmS72LgMXcKKmBH/8/2Y96hyrK4pW7?=
 =?us-ascii?Q?nIP1TFVShk0fJekzyusomnVNG6YhuCJUOkqdl9GoCqU8Y/LY8qWLjo24Z7gt?=
 =?us-ascii?Q?cZzDs3XGbUWCwq1JUD8J8KEcaYP5snuDTonzaQKA1qAWmif51L+k/1CKuYhx?=
 =?us-ascii?Q?zZqCBKyZTmpLWTmIl4cgNEO0VwmHv/5SypubkiYNVKm3512m0bBsRnxsDeB4?=
 =?us-ascii?Q?ohGJsUwO7LIIvbWFRvNBVLIUxkBcIf7Hfpe80xkwY/enSNI9myRm3GzAv/4N?=
 =?us-ascii?Q?/eTsiZVqj4CceFmMAEmPVRC32IQ9xBRpKq7pYPrS+VVdHkeOJ6jAq1z5jUA6?=
 =?us-ascii?Q?ACAowWX9TnIakwpquvGWZa/QpahjsD8ou2pu4gwpS1N0WJ2Sfyd3FhFSQZE8?=
 =?us-ascii?Q?tHkHa9LDHfmTvOsRFMd4lWJ9Yps9plQy2S/Uk8ZeeegtlzA1pNHz/muqJCwj?=
 =?us-ascii?Q?R/2iyS0gPe1+KKxu/tVDh7FLO886rdB7ZAwm21Qjf2+aC2z4cFzMuFFbFsJ1?=
 =?us-ascii?Q?g+kJNhTIWWkAMBltkhlVvPJRtHbRaQXx06ZWXVdtvhbIRhWyDjlpU25Jcsu4?=
 =?us-ascii?Q?Ab7oDXXH1jqony/gBMMaIQ1gIYuZrZYSYuI9Q2ajQk0cSdIxx8TD6oYzemfD?=
 =?us-ascii?Q?qmS4ZTv+uhad0eoCoUnfu0xX6tgO/+inq0WDQMRs/azg3bekl8nPoyvd6CBN?=
 =?us-ascii?Q?bCV3FixCLlJ5JBsTLCBgJGRqZChjbhOV+RMMflKbqdkayrzbXms/ri5TbJVN?=
 =?us-ascii?Q?no5JAylAwhJu7kxAFIHTb3mPRWp7ApsX9GUecx+Lah217mfLHeTHiejzE/so?=
 =?us-ascii?Q?tIH2JPuFO4Fz+eWYKXe1f2unRYxSRihqZ0/MGifPIvryDvZTfVERryjJhr6U?=
 =?us-ascii?Q?OuBQzW8l6FTmOlLki6NZd0AUv5ma+G+UVGfbi19wLKRZxvJYAQhdODSEIKCY?=
 =?us-ascii?Q?a2Pzksb9yBPwuPN4O2C7kpE5DK86Zxy0fjvNLOpnpwdg4fWkcMzkx1+ZA3+T?=
 =?us-ascii?Q?02WCFj1fJ5RDqUzDH0Vd3nva7SHbbfUAOnTK7H5BKDueU+7Jy+tE9i35h/gR?=
 =?us-ascii?Q?mZtpoAMvePchY86FXIiVDgM45BTYQmVKBfrbTS7leYdLXMkG3oqA00Pa1xLw?=
 =?us-ascii?Q?5+vvfMeeIjWSN+XDnNXgG8a6KU+tdfnRGeR5B62T1/X3XU6TaDTDI2UHwD8t?=
 =?us-ascii?Q?q3apAU0ShpsYIRZEf/dUjNTM1Hnz+nJ3JE05KMvJ5NJKRIUMOEMAyZrKGwhO?=
 =?us-ascii?Q?rlmFxegnmlBdXBFsb6pGz682+droXz+Ln7X0lVNHxIMUwdHf0H3UIwKsmNnZ?=
 =?us-ascii?Q?VQ/Wu9ZEHHYKH1I/t3m333bHQTf9GJCm7CX1uNxEAFnqZwBGIWoupfMwprxv?=
 =?us-ascii?Q?fgG8VfHPOC52DgDh/JiFTdECJUXR7cceCPcxzlM0dAXomAPgVWzzr88FnGNH?=
 =?us-ascii?Q?VJGHlR1ilgYWlDxmmfAqhw9QrHFOZcIBHdmJ8AWcv6J7ZtwYVEjuX0YxE53Y?=
 =?us-ascii?Q?Vlb4/2KYg3zm4Es+PP/LhpKy0GOzUm4=3D?=
X-Exchange-RoutingPolicyChecked: upbk43FOKl9RXBZgd4sSBFX76SvGasDL59kvThl3M/iLw+g7/yc9RNNqYx6Il+Pw4KK5SEbvrUs9kqit8NDMVEUIbBlcGVlOahzw96RnYIF6FeVWXam/2k9PkIj6a5QP5HDTBrXOvtfArguBdr4lsz4ladOajOMplty6zS0LKJR04HhXTvgizdRFF71IPnneSN6bzR0hervRPG/3IAqiRrhPaKiAf4hRZC3Tsjb90zHfHUOCKKbbq2iqh7aAhCkMIQXaTJalL6xKhDwp4SQdGlX13NTOmHnwhSg2NqlwuJ833eOE8b3y7kVaP83wSdhljMrYxP2KOZMkC4rSs53Cag==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da20008-61b1-4057-26ab-08df2b90e8ec
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:22:29.5906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYPBHOgi9gnMQp/jgWB0Jpb4tf2n7WISnoQoCBgMkfHzHvNB0OOBcyiYIaV6ImUzraoDtXhRIfAlKadBhGlGLNM7PgPywB4lMmB6Pblxf3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9592
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX7qrY6gitTAs9
 VapZWxXlZuelrHbwqkUK90x0MZDii/S7wzpBob6W1cru26x+LVIg/+17vXOGE43K1sQiKT7UPO5
 1HTdnWKAWXBefeb0yb8cMa2NOVmx4YhFJjTnhbxCBcKxeLszw1DQPttVbx1tKvoqjx/8FC2fB9C
 KsZ2Z/uIv5ubnc34nijf/3LHDtM4icE9i7IRDM3fXgBZKMYrDLW1wR82Crsvzjmwg2qnNQ0HX3+
 9Mq0G1Yf9+I3kGznrC+ie71mQVQ2I7btiXaeqlLDyZb5T/qR6dKvE6RfsLiyBx7pGfvrgLFV4tc
 2WQ+hDlJ0/VWJIyNhC6h/KJrGN9ECtP5ln4GIdjpDtSb9yp5AARdKGhpltJXykFUp09WCLJLpuv
 WQudX24+6+LXiexAUKFlgXPGEcLDNWQ1a7QCD+HK8Om+7mWAP58K0gPhn2UktcRfWMfi+87wd4w
 aUHHS6xZw1M08lXhwQA==
X-Proofpoint-GUID: I-RwfBOGEqXMbL-VfK8yVZj1OoVcTCjg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX9yaRnql/fJq3
 ESvlONZoYb2Z9Z7tifo6PRlUtdLMEKtoGfQ/7AuJXnpA7sob9c5TNRoQOfihGhlkHf1rVBjb2X2
 OLjX3xtOO77fBC+ZzJRUzlh2d2MQYTQ=
X-Proofpoint-ORIG-GUID: I-RwfBOGEqXMbL-VfK8yVZj1OoVcTCjg
X-Authority-Analysis: v=2.4 cv=KMLPn1Fo c=1 sm=1 tr=0 ts=6ad23341 cx=c_pps
 a=7kgNGXaSmB15KJ6u7rEBag==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=4lKoNvaWMPz1F08twPcA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

This indicates that the specified register values are being output in hex.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/i8259_common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 3bafd81ea7..ee325a659a 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -119,8 +119,9 @@ static void i8259_common_print_info(InterruptStatsProvider *obj, GString *buf)
     I8259CommonState *cs = I8259_COMMON(obj);
 
     i8259_common_dispatch_pre_save(cs);
-    g_string_append_printf(buf, "pic%d: irr=%02x imr=%02x isr=%02x hprio=%d "
-                           "irq_base=%02x rr_sel=%d elcr=%02x fnm=%d\n",
+    g_string_append_printf(buf,
+                           "pic%d: irr=0x%02x imr=0x%02x isr=0x%02x hprio=%d "
+                           "irq_base=0x%02x rr_sel=%d elcr=0x%02x fnm=%d\n",
                            cs->master ? 0 : 1, cs->irr, cs->imr, cs->isr,
                            cs->priority_add,
                            cs->irq_base, cs->read_reg_select, cs->elcr,
-- 
2.43.0


