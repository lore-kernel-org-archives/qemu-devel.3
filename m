Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE66CAC5B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 12:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Ou4-0000UV-0Y; Wed, 24 Sep 2025 08:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1Otz-0000PW-FX
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:47:20 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1Otq-0004vG-Pn
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:47:18 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58O7Of1Z3138094; Wed, 24 Sep 2025 05:47:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=SSCgafJ4TKOGS
 fq4Lhfw5X/N7e2vLnVKUePiY1TcmPY=; b=qpuPo04tX8VaxVAxFaXKLu9mZKggB
 UeYNYh4G/FVifYVNWz5hZBmwgmdo2T3OdHF6oGz5zXzcK2YUKC5vGHLRBG7pNRzX
 hzXM1HPldP3mFjmx7/bHCmuefL/3KCvCDNwaFcx6qFyyMqt50EHk6o+up2KqkL0p
 mRwwiXQMK6HnPDcAhx7XAOm0oYccq0dXD5XXHc32GFyDg86SCo0v3n+NftNW8AIp
 OoNQ52LDybxlb3d78ksRblNMPAP5uv7SKsHuHAQSEszwtgXULEMiZozYBRod1O5Y
 Fgxo7YjWDz5NNq8Xy99fDMgXyY14wAY3rLr9BqTNixMhPapW3lOA6XlRw==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020095.outbound.protection.outlook.com [52.101.61.95])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49c10x21rb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Sep 2025 05:46:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fgT1oIaFRbkZ/gSlETNsqxekMsH8myZWzfFcGoKrUbz2KqRYfqMpFSPYmCZP/K6GXHSJtSDO381LOCTfTrVioNnfF4HrQxVHI6kL7FCie4cD+Y7OY0eCwqkEjkalNLZKJGkQ9s7lptrssjMJKU9Gc83fg7Xl7vdHBo4uBOLH4e6Wsc3owC9+SEd6fVpRn6Boo/dDlyZ/qHGzR3P3v5PltbzwWEndnqxUvBDXAoP8HqUzIdyqvRo5gBeuyGli04SbLy+vWkyZY6cP67HIn+jR1nd55+ZWIq9oUEYoBFaMYXATzA8xaQWjeXbFJ5IOi9w64CbZwME25fXEFVusCWnrAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSCgafJ4TKOGSfq4Lhfw5X/N7e2vLnVKUePiY1TcmPY=;
 b=rEPlem5lZIriJB+jsaP/phFWUYp3Rr/4gAdbTTRnmHBfOFFAK4fQ3TubyLOewK0hIBtWNWmkDJgntAxVGDV551OpjSVhG1PAeHxraERdWUMKSWm37WIIuM1SP5g5Y2X4oLCp3r3Qs2RAPsWekuJsPNharG4FgebTHBk5PQLf1UtEAuWa7sJrQw4rgJnO2UcwerlsONoxVGm6AWKbbvlQyOcoXWwt24QPBSTSzQEXi0EyLgn90vdpAYbxni1P9Z7mqrGLvyN7zB2a+EjXwuEvoKgv8EOrqS5qJbUmlAnZc3njlhUgtOUNEF/qCWSJYJLnfn/NGHg3cjApkAO9+RYfuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSCgafJ4TKOGSfq4Lhfw5X/N7e2vLnVKUePiY1TcmPY=;
 b=NB/guY5IGQ7av4QZBjz3UOVyibwWg6gMTl6SgCkRfunCM8YyrqeDprc+2YqtIqtmHD+5/VsvC+KEvDnfZJqkFqoWjl3EKR6nIZ7uUamZCen7SXhlqBqj7kpI9eXmP9yCPqLbkNz9AjFKoQ5bRvfiOQcIP21beXJtws2uoWCRJ72w+vMe8uAoX9pG6Yjxai0c8wI3VwnyUeXx3rDF4T2HfSkZS0ALrgz9Ggb0gT4k5NpwBhf7OJs5o3jpklu/HvhJsX0cLvukyjjxKjs1Ot5jONH/+VM0zsAVJQqwBzOQCrSkBVRdZfT3WOP9tq8ITtda+l7VExwXCLgHHas4fQo9nw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL3PR02MB8003.namprd02.prod.outlook.com (2603:10b6:208:35a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 12:46:57 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 12:46:57 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: imammedo@redhat.com, philmd@linaro.org, berrange@redhat.com,
 jdenemar@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com,
 qemu-devel@nongnu.org
Subject: [PATCH] hw/i386/isapc.c: remove support for -cpu host and -cpu max
Date: Wed, 24 Sep 2025 13:46:30 +0100
Message-ID: <20250924124653.1395094-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0041.eurprd04.prod.outlook.com
 (2603:10a6:208:1::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL3PR02MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: 21de688d-9730-4369-ee6c-08ddfb68723b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|1800799024|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7jnuaVs7Sca9BlkJ1Oq9hH5Q+Xqo2wE+rzgkjJ2/sVkv9g6+dc45bPefApZV?=
 =?us-ascii?Q?dOR3gUqK5i90hvpRhc/BXy4fc820FOeG5lzZ0iZodlQvLUmZ7bzJQ3A41U06?=
 =?us-ascii?Q?k1zh3GUa3o+ubcaoW3+eisxxnIIIN8QuQiBsH3zDLCyKCMY9fzrUTGxUM0KO?=
 =?us-ascii?Q?k1tVawKI1MOw6xQdFvYEOqEcAziDus4dL+usx3aB0aiYODZjJka1xU6sLrk7?=
 =?us-ascii?Q?h5HXKwLFNnc8GJhBCvtC+hOzXSZ4h+76o7oosEC3zdAcNlN9L42y6HZ0OYCw?=
 =?us-ascii?Q?ZNVGDHXoIuVUKb3ALrvY04hLwfsp2Ish+WbxBbUyVfPkgwPK/iD0tiLyOyDK?=
 =?us-ascii?Q?Qs0vt50IsilGN5G/+PSZa8CrarEUN40rOJ+z4qj1/U3zCA8iTe8P5amfQSSy?=
 =?us-ascii?Q?chBLOJGCT4LSUooyvfVxppLYDwV0EdB/WEh1SgdDOPZp7lttge9flFkXhoTS?=
 =?us-ascii?Q?iyXbRD9kzYOj3MBZtFvbvlUmO8VZCuj/yoPMudTOmOX0auVFycXLcePsr1zE?=
 =?us-ascii?Q?m/tjzfWcuNjAXfilPATXbK3f7OyOJSmg4v9/Aao1ml0ag+czDT0ubXqSWEHq?=
 =?us-ascii?Q?+u6Z1YlG8zMHLU7J4T1ml4rVNL12NV3oIiJpx44ikpET+YhenLIkyz79qXnj?=
 =?us-ascii?Q?/s4Knzj1u87pCXqZ8xCWRvwxQLdtezDEtCFxZKjPTtRYEV3x7Qb3YaLlwk+x?=
 =?us-ascii?Q?s5tdC3RP40TwIOyK/qi7I3kvPU0J+abNOc+3aYmPm+7WPhqKi4X6jxOyY2o6?=
 =?us-ascii?Q?HviEsijvnMQAMzdof87p7MStDKbOHUSydjuNEpdwH7mjl8LdOmlLtAZcQO1v?=
 =?us-ascii?Q?NdzUraqlgNkq4Wa1MrhcZqvhkLPt9CaVYhp14UmlrUSEYDypcOhz93CM43za?=
 =?us-ascii?Q?Barmn6w6/JWFOKVoPgrQS6JJIyWZS7cjvihBcPlqglw0v/sMriQ4Bm2LCj0O?=
 =?us-ascii?Q?h1kmYm5acvBDnP51IqNAgCWUjmtZQSbB1/yA6CPDPmWPn5PdPgTv2UM/tg8d?=
 =?us-ascii?Q?rraFv2ZoIectUcfVZc58Oe2GiYS8tbbrwfgmBlFJInePloLZOoG5Nka9HF5N?=
 =?us-ascii?Q?FJXHVGfzQkUI5hifr3bDwbudUIXofALwmRejSAL68IvHfymZ/GHma6qvxMgZ?=
 =?us-ascii?Q?1WdzIPEc8kdgHUWrVJZGdpcz5+C17UqPvbb2FYRYjHfN1lybQREMAuN09v94?=
 =?us-ascii?Q?E4Ip5K3nGT/gYSE7ddLqlEvkb12ubiqH+sRps4urKWuujOvbaLaJ9uywFo+J?=
 =?us-ascii?Q?S4dQv57mq3iG9yTMU9tBlEdjPOclCsTKLFUoDE/0sBmQiwv37Hcbf44eJeX8?=
 =?us-ascii?Q?eBVoH/oQN4KXFvvoa/gebNHo8uw8/lOgIWHrwmCL/DdpSBRRqsr+YQGmEy76?=
 =?us-ascii?Q?I/rMK/X9jzOADoiR8dkhaXnIy+Fh6JNugz+oeZbMI0bs1lr3gFL97g65NwZT?=
 =?us-ascii?Q?FRS2/lKYljVpcTlwoP+YlOaoBb1JBDsYF6XQPPU9yrgFTDn+axssNg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NegOVaj8wf9FEtLaQQ0jpVD4JYvnliwOBlQlPMsFqgMlHp1JG8PEPbA4cT3w?=
 =?us-ascii?Q?omHoZwv62WRwcIS/tGjqu8PYQTuXiVihEFPvEg4XG+MPmmYKngX9ak40L2Nh?=
 =?us-ascii?Q?PbsxZIHX6K59JU1asaqBtFbzOsbXaqqYcrenqLDUpZno/LEF9LQbrceuiFij?=
 =?us-ascii?Q?3TvwkasDwqRBmeDelKY5t7Vimv74rZDrta+iqwrR3Q6/cDPIyADYnCT/B6rO?=
 =?us-ascii?Q?9xJZDe87tqqWNjKK0gNZltcKoC99qB4MYQbKOkevPA2JTk0Ib7Jyn+hcZvUG?=
 =?us-ascii?Q?Dvu/5nFRQzlNp5lXomBx4ZGg/HQWCz165DgoQJAZprstf+RRt9QSxDxo8/ln?=
 =?us-ascii?Q?NBQF57JTQRU290gaYBREbCl/ShCifu806Dfl66vsgikfRa/972U2J+MTA8zU?=
 =?us-ascii?Q?/OMEURSLk0B/3PehM840txHiTdt3oUOcrzZwybMv2q9XH3RHRDzTsEz6gy2y?=
 =?us-ascii?Q?L+Cv/MPGwazXZdubSAiosyd5hOulgXI7HiwUpVfDmGpHbUUSp5r3H3wqwkG6?=
 =?us-ascii?Q?1LdEuw45E8E4j2mfvDXr8kPTIl7jwBYh7Kxt4j0hBDGdf/RveuRbz6Ck9vo8?=
 =?us-ascii?Q?6NBGp5unS5rG0wOQK726bixihi6fyZZMBiPuxlqdwb0K0Mt/G7/ITJQ4a6UO?=
 =?us-ascii?Q?LwyJipDI4ee4RnTwzcLBl+Xj7Di8znfxtjngXMx68ox2DyMkctpsxGeshgz5?=
 =?us-ascii?Q?ivtlvoBPJti3QvrbqbRkcOORclwK/sdu2Ty841AvtBzVyyaBOV+ySH+C/jis?=
 =?us-ascii?Q?g1cFboP8z2PWIlFVI2vRiqPFpBrZ2XGD3bU0HGahDRRvdd/7mxSQZo0Eqczc?=
 =?us-ascii?Q?NMZkAgWKgdjuydep8Gsw728bTIiNWj1THhxrSNEMe86/KP6Zm/eX/Wefl21i?=
 =?us-ascii?Q?4ms6/atwAHf1TWYb46adEqFOQQRcTpPJGY0XVJ+L/7/ccXXcNoXu1ldKdJKV?=
 =?us-ascii?Q?KJgl8NoBfkYLhvQflDOxV1gcRVgE6CzBCb07+aHJeugYkNNHIw5Z73vReZ+q?=
 =?us-ascii?Q?vR4sILZUsnJ5XGwHNOWkm0pAdj/rjPx2iyMgvxkGuUkAC+VKVuhQ9OPhGHcF?=
 =?us-ascii?Q?nK/aoKeQ9vE9aVlYdOcHlnyUGtQifRiFxxtY1zRQB/D/ak2uBG1fgaDtwkrQ?=
 =?us-ascii?Q?czQy+ux225n+0eOTZqetuFWGOp44XxInKu5rFe8w4lPj2TXO0j8UP1KCXc6J?=
 =?us-ascii?Q?ejfKb6FSx4slTFYUeuZHT6U5r03FitnjPW3v1BkZ2ldt38/wgp7EzIxQ2l9M?=
 =?us-ascii?Q?88pBfvVI5Es063IZShyd0seXesSEKqHAvYJO1AJZ11OLzNTLx5hpkC/tZgo+?=
 =?us-ascii?Q?af+5LAUaFmQt242ATBdupyncjNxv0v9qzLKZjPu95HPdX1VfaevQi5MWtJh+?=
 =?us-ascii?Q?kN7kN8upb8J99hKya7Lp2WLvXqbm0fmxC+Vs/mdpUjD0YY7gDdq16wtZX4wa?=
 =?us-ascii?Q?eIOmUQuzlgo+4rkRGN0l9emszwD2cfXR4DovE4gNIpCtfOIXZyRjVGVnrw29?=
 =?us-ascii?Q?g83KU5LP2hhP+8uCteB/w3gJiKcAvY/ithmfiaypQc5A+8qEUadmmTzHaKIj?=
 =?us-ascii?Q?O8AN8nbWAiwSkBI6/eW6sV7bgA4MVBf5M4A/74k5t/6nhtgGeMI4QA6iQ4xB?=
 =?us-ascii?Q?temnq55yjZ8ba2QRlxgrK9Xx5ZZ5UU28oAp7tspkWMQFJ73JL0R8rGxuFIdQ?=
 =?us-ascii?Q?acmcdg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21de688d-9730-4369-ee6c-08ddfb68723b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 12:46:56.9497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THQ5zXEqHfFQqrG+Jlfc6UqMGQV1jNLQYh/iqvnJ4EMMy8vEhMpTZdGHUbFViPL33sXi6VnXymDi8opwAWMvHkF3WBCU1ghxJJTgygjNQ7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8003
X-Proofpoint-ORIG-GUID: xXTKv6n4sHmtSMLd_y5vnPtQMZW7VKqg
X-Proofpoint-GUID: xXTKv6n4sHmtSMLd_y5vnPtQMZW7VKqg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI0MDExMCBTYWx0ZWRfX0wnKH9r83qY8
 z5cdb+dtCumOnKUOe2PaK8mxVwQ/dZIUOIJr9PwFrBfcRHABznzq8Moer4suGGUHP23G0+7eriD
 A8GlaWqNx8f5nL/nuZUn2l9ax9cG9KmeVSy07CUMmZ75V5mjeq4EqCcyA9KOUJcn+8xnyx1NTYn
 wJXF3EBB29gpbJMRyBSkYXDdWNYcmC3Lq15EdWceZPPPrlhPvnxs4P7hYYa+nRkan7jffSnoOZy
 VZpI84KG5VXk9ctZUZaa4vDUJRYZp31fiDjyoVPMXU69N2P3xrcIKZfy5oaXsZImUkWLgDpw9MY
 wxSTTlEEk7gJvL4FOzh6Lbb4XIUMOhp3xTS8KggswWaRRmvtp7yHclryz1kypk=
X-Authority-Analysis: v=2.4 cv=A9ZsP7WG c=1 sm=1 tr=0 ts=68d3e843 cx=c_pps
 a=5EyciH11kPx6gLClVK4sKg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=9B8KroAGFL14IzxpYG4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Following recent discussions on the mailing list, it has been decided
that instead of mapping -cpu host and -cpu max to a suitable 32-bit x86 CPU,
it is preferable to disallow them and use the existing valid_cpu_types
validation logic so that an error is returned to the user instead.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/isapc.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
index 44f4a44672..6c35a397df 100644
--- a/hw/i386/isapc.c
+++ b/hw/i386/isapc.c
@@ -41,31 +41,6 @@ static void pc_init_isa(MachineState *machine)
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     int i;
 
-    /*
-     * There is a small chance that someone unintentionally passes "-cpu max"
-     * for the isapc machine, which will provide a much more modern 32-bit
-     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
-     * been specified, choose the "best" 32-bit cpu possible which we consider
-     * be the pentium3 (deliberately choosing an Intel CPU given that the
-     * default 486 CPU for the isapc machine is also an Intel CPU).
-     */
-    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
-        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
-        warn_report("-cpu max is invalid for isapc machine, using pentium3");
-    }
-
-    /*
-     * Similarly if someone unintentionally passes "-cpu host" for the isapc
-     * machine then display a warning and also switch to the "best" 32-bit
-     * cpu possible which we consider to be the pentium3. This is because any
-     * host CPU will already be modern than this, but it also ensures any
-     * newer CPU flags/features are filtered out for older guests.
-     */
-    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("host"))) {
-        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
-        warn_report("-cpu host is invalid for isapc machine, using pentium3");
-    }
-
     if (machine->ram_size > 3.5 * GiB) {
         error_report("Too much memory for this machine: %" PRId64 " MiB, "
                      "maximum 3584 MiB", machine->ram_size / MiB);
@@ -162,8 +137,6 @@ static void isapc_machine_options(MachineClass *m)
         X86_CPU_TYPE_NAME("pentium2"),
         X86_CPU_TYPE_NAME("pentium3"),
         X86_CPU_TYPE_NAME("qemu32"),
-        X86_CPU_TYPE_NAME("max"),
-        X86_CPU_TYPE_NAME("host"),
         NULL
     };
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-- 
2.43.0


