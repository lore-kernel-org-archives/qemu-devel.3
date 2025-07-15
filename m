Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E17C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc17-0000fU-EJ; Tue, 15 Jul 2025 05:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc0j-0000Iw-RL; Tue, 15 Jul 2025 05:31:45 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc0d-0005iK-2x; Tue, 15 Jul 2025 05:31:40 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F6dBWZ031489;
 Tue, 15 Jul 2025 02:31:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=qK4XywUlot8lgfdzTbGincgJyuQzNdyxmUHSbXFy5
 gI=; b=CL7e1cI3qVkUFgbjaS5MiCZuvdSCrQN5Fkyv79qP2EM3vGVN9WnFaF/uo
 HmoKZ4sBPssWwnYYRRhgX/w672KY+CX1bAYVs1gRyf0uXq+4UjYesLSuAD5rx1sM
 ps1PusEaB2aV6n1jAhL6jNyMDZRC5sBc0+GTKKyUXHSw0S9L/qcHtMPWhFp+7L10
 cpMQI46Vi5NBOmrHWMt2cMAwzOo46d6nVC4zLMmPaa0WJkQE/Jig6SFZezWTtyGj
 Hq/KF4IsY8BpxuhBN3yhJfIz/b8ZGdbr6Q898r/Sk0yms4ypJ+2H6nZ84pWnCfI6
 5BBriMwFCRaS6Ypkheb6fzx8pdGJA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2098.outbound.protection.outlook.com [40.107.92.98])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47uq1ddw6w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 02:31:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K31MQZi36ADbzjv7jp0TlCFTRAdjdwioy/nQf/50qSglTSItwer801YZZgE05Q0MvjulKv8HzlQOKIQmluLJA72jEp9+Bl74nTm1cqfJYfT5VtEHhKMeun/vId0otHMJiSGKrUw1nYW+JqBWL14VHWz2hpFdbe4UD1kZCpSuPlHr2YpbREgfJ/nE2Om4UqNC2Y9vPgvn2odtg7Om8+vn/1nN9UkpWtba570U09G3SynKeh8rpF0IVr/V1lhmUtL4Bn433KwT4HHV74egHrDflaeZmCoKH7TldQ0M9OENGupP0jnb12xySSEtjQaKTEUpS7WI3ms3UVaO4vyv435Ppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qK4XywUlot8lgfdzTbGincgJyuQzNdyxmUHSbXFy5gI=;
 b=kixz3dlDWKu4eBg7tcINs5zUTa2Tfd30kL0AY7yfvTroe+zVwJVgDcZKcl4TPRpyjYoqc0U7eeXvqPFujrxURXPChyrFBcdedW4DadgBHQkA/BoRbQ29gW9tP4b2cgCWrY9D3NH/QHs/0Gm/+wxOQ13w5j/mfOqi5CEC/oUorulO+abhAgQh4QeDoY/hFXBWkCX+H5zwAmj0AtBqSkr9KTSjPOw2u+yrinBHpD/mHceOoVT+D9IswRi2xw/MulVwcZYw7zQpAwobMO28h+NuxxamClJuzRNKk/iKi4wE/QLFF8ukHUu+VLTjVRmgqAEqvK2wIIN9SxAReXhDW1uXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qK4XywUlot8lgfdzTbGincgJyuQzNdyxmUHSbXFy5gI=;
 b=O39DulI1dDnE2sdj9LxfkcdHB7LWpeM9g2NOLOqTknujkB5LvGq8+Bu+eTmtPgsUQ4xjwgsi/0qyIf4ysgFi3NsAfpk5SNGdmuCy+XCWGOF8+nrfzkBZZtmvGvr+I6aHMMJYHpY4Wdf0LgTqDVdr2AtfHk2cS2UpNlQlFQRtg8JieRIRJVtj1mZMVXuj0wRbfGLvwcjc9/CmfwAOQxo1UDaWGw3mEcWiNZrC6FPk9tjstq/3LFC6KppIfLDLnqn9yj3a4yONgF6CZqNCC1obaMmzM3ETlKY8vFwRr/O4IObfnrz8S52U8mdzfQX5cRKYkg2LiLYscsmLrRUU/qtrtQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH7PR02MB9386.namprd02.prod.outlook.com (2603:10b6:510:27c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 09:31:25 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:31:25 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 03/22] hw/vfio/cpr-legacy.c: use QOM casts where appropriate
Date: Tue, 15 Jul 2025 10:25:43 +0100
Message-ID: <20250715093110.107317-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715093110.107317-1-mark.caveayland@nutanix.com>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH7PR02MB9386:EE_
X-MS-Office365-Filtering-Correlation-Id: fd4a4a38-08bf-4af9-6ea3-08ddc3825e36
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6Yvv1qXHGhDP+tu712c/XVBT94gso3rjoeFm5FDQqLuDZBmsJfmFT3tYJLTt?=
 =?us-ascii?Q?AZlQYoNtBolVgrAdHkmqCT5nsPxyhpFyQsTKG2h13kPEcqEMDjM2ZOX8rIoC?=
 =?us-ascii?Q?WYOjPp3DSA9bR0wfKRv2xvjMqOtc91jlsRj04167yhWKo9dzLm8rsrQjAFUr?=
 =?us-ascii?Q?Ek/EmYxTFxK7AU4/5WFc00kEmjflCC+82NNlyKPLE/Wr8XtUqvCtkavN2Cw1?=
 =?us-ascii?Q?D9gHhUtQz2EDVmNmRb52U5kCS5kNZN9pGjLf+WzIAimu1GwOSAFEi+YIhCkc?=
 =?us-ascii?Q?L5qxqd61opAK8LAf4tCNZUUvAe325YuVX/MDFXiks5wRGTrcHV54kRA89/VI?=
 =?us-ascii?Q?jj+dKXmt5H6nHE7xfpeNa3g8KqmjUUuenCBHIcrlnWPik0tOGWgeoJVBBsqa?=
 =?us-ascii?Q?iGE7ouV7X4d8xA4ofkWv4Dyxm31A1Qsuw2GE9jnd0eDj+NY1EsEZ4uvNfruG?=
 =?us-ascii?Q?Y111xxR26/04FWroqlXjtU3ee3ZaBUDRjRdOj+jZI5ULI4UP/oQscVjjuW7A?=
 =?us-ascii?Q?q3S6XfLWJ+RH1JjTzWIy68CT/n4cHqNWgshtbdHUogoBT6lp0XuJOVJidxvr?=
 =?us-ascii?Q?SHVpf+Ti6yBehhmNsXjn+sc9iwpoqn1UzvmWCMzQSYgmT2mpjKxZOJxyr0d3?=
 =?us-ascii?Q?KhCmCbDyH9l5XmG3rd4O1B+3pjIAriHQoyLhQcjMXwvKWQHnyBF1Zb0APONp?=
 =?us-ascii?Q?KF5c6z0XC8CdPUkpX7Bw7IGvuyJ41q+EWhuxcSdScDne7mRAPLV1ZB0FFBe1?=
 =?us-ascii?Q?b06303fXTQTeRKtmn7oXmn7TUFtedlDwBLiIDVQsIhmN4EzrTOcEv/aTXcrc?=
 =?us-ascii?Q?b1+BZfnM2XttPd6fMOLs0wjI7mDoQ3azw3oSwIMu5agJKVT82UMEHjfufoVW?=
 =?us-ascii?Q?SvzVW22EaxlFOo20Hc0Cd8bQwoTVYjkK/A6eIKvS56XoIGqE2TkW3CAlK1Eo?=
 =?us-ascii?Q?/UKBCDbsuRliNnhYihlcbZFQRPADAShKdbWoS5I2tIcC35AKyD9+9DazoPtJ?=
 =?us-ascii?Q?N0ZO9/CLqjqI8Xcf3SUui5ZIycF8zrHn1JVap8wzbeOjt1Ot4S92bEDafXOT?=
 =?us-ascii?Q?AqKzdLMiTangZGGzoTQXhq+WyUKyh7tYyCKVLYOKBooeIEEULQuHIvw/FfJA?=
 =?us-ascii?Q?SvUlytnhCGHp+Q3dcEG/CQ0psAIeG36DXesYNKtuLriTxz9LrxgwtcAb6sX+?=
 =?us-ascii?Q?XlQxPtkKNc/s+vQpYO0DcWnEUKFFLFxKfWnLXIvuHpptELtyt4P6Lr5BTQDe?=
 =?us-ascii?Q?JEv1thowGHcxxOOMbIEF5WUmV7pcUZeZG0n8V7lg7D3CwfL9h703xiUHfEXg?=
 =?us-ascii?Q?V6vOgxgL3I0W1goeffQU7tSqFj4FP71UDfzwATqDGg37E2CPQWFiZkIjy4xZ?=
 =?us-ascii?Q?97JnGqBSfGmWUF+crYLb2q21o+SFMc61LZxnrJns8KlaXGD2NR93ZSwebLaW?=
 =?us-ascii?Q?B4MIp3TGac0OW5QnDGca09uqypwe6cJjzO+qVqLSbSiG5JPx9drawQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BwSR6SvakUAGqBsyrvX8U/m3xbjUIEqY9a0g4hBO0ThOxp5fu4RmlJlclo39?=
 =?us-ascii?Q?9ZY3qP9TCC/1UFzPbcjEdpw6hOIBsYrqIvS7wLG/WIXZ9h3Rfxcb2HgaV8bQ?=
 =?us-ascii?Q?V8DusUgIJEc9SWCc0EHRvJXmvUiOmISihjcsFrDTemR2qqjtE/sT9IdCXpO+?=
 =?us-ascii?Q?bg/RxLF+Fqb2VLCOLOCMSJOOz/DEmODVIR838FRtf+g5w+/rzpZ4AjiNmIQB?=
 =?us-ascii?Q?xYav+IC4hbxOYNO4J8kmUHzWHAhsIDz0BaVqD2tfemFubyE/pLMAQvbr9mbK?=
 =?us-ascii?Q?KB2xpzm6dPFC9jn+/YM1kHmpY+jyPANq9TjmsZkVi+OMuno/j6/44ASZ+O6g?=
 =?us-ascii?Q?NzNWAYXmerDyT3SYw4+z/q7X2e7AzKMFue+Bktn7LRpSuWHb+yWzv5mWsWUO?=
 =?us-ascii?Q?/MuW1MXTcqW04Qdu1G1f8QiIV4JF4/9Pa7E2NUefHn7gRQAFO5U03oipMVRH?=
 =?us-ascii?Q?ELFkudJpk+xknjLMJlBhz//gsZsx3ZMzn8IiPGnx/vbMuli0e3S+5jPVa7IQ?=
 =?us-ascii?Q?4mO18y269UGzRrTykZtel0WR9mIBqb/je+l8YEffQAMoDpopzQrQuockm7UC?=
 =?us-ascii?Q?ux38paTTfbFP6re8LU5PETf7IfyFUKIhG1PKB70Inb2IV0lOPGt7rSlnEWvO?=
 =?us-ascii?Q?jSq99GgTHCY8+dvQ4pLUhNYutvPUpk59PBFoYw18SKENXY3m4R5KKlUD65yO?=
 =?us-ascii?Q?PgXK5vmgyFH6HNE7MivHUKsEfwubCSluWHmwIqTO52xEk/GEbwR6atd0xdE3?=
 =?us-ascii?Q?3OIdeQpQW2I1Bo9ZGMIh4qsNeNpHRno/MbbhijVnGorZZDEqq5LCf4ZMsLfb?=
 =?us-ascii?Q?/CbQAIAuFuxsZ1t/CLg288SGgJ3tgw8dJd8LCCoisgBqoAdf4odUiNli3ZNR?=
 =?us-ascii?Q?jTxMMIW18bmaat/UqRYomvX56CV7ax6Ob5w8iZ43iQPwQEfFcxDUmO1XXjR6?=
 =?us-ascii?Q?kc60cFbEEJuEr5A09GtZYL9ogh6qVxXBDALbX7pciluh+yacZB0H8CigcQxF?=
 =?us-ascii?Q?hH28b2A+bFpilxGmVe80VDJTXyjNwuyk8bePK6duhz+wtRhUmQ7hVyonoxA+?=
 =?us-ascii?Q?mFHlkPqwimyB24Y+wbg5k8renX180UY4DqXVeH2XsKIdH2tIblKWE7Z27o4o?=
 =?us-ascii?Q?FqhyUkRKWFyHOwhWvqMqSDjxt2gyVdoWUSdjXl5ihMiie5qpXXH3Ys6i1eW9?=
 =?us-ascii?Q?WPHRdBo64POA8si8UtraGP0yOz4EzcztC6cONmgiG8A6PchMLr0oz0NIbyfv?=
 =?us-ascii?Q?DdQQ3azmR7KRdaMwLWX5Kj4okvuMRmMRTIMNUSqyaoS98f5qBZDUWyQMW5ER?=
 =?us-ascii?Q?D/0QOPganTRSi9+uRHRw6YFgdQgMpNZDe10iGdi2eCQW7a89xG/t3yR/C+o2?=
 =?us-ascii?Q?jEYkplkqiqyF2HlU48JC3sbiH0AAfSQxuZQPsk6bgjRRBA23+SZ/+YxKeebJ?=
 =?us-ascii?Q?ufhBxx3FJs1HR330OJsbdC3oF0RBxIVkiUL7sqpsV5LwlwNYJRKDHfO3Cd/d?=
 =?us-ascii?Q?INxH0XzQ/WGnf+t+9vvDWxb/L5JDqEeCSGl9z/XFAuihTqZhfUB6j4erSlk6?=
 =?us-ascii?Q?BJIsVpaYfTeMUufGZp7J4j4cV7wFcWPjSISPxDuqyM7MPfmJ8ghAN7hGESZd?=
 =?us-ascii?Q?32+uetQIooDXsVZzNzB2+xGwaOjGg1XOMvlhk2UWVSgIAgJ0xM+jb+MYWx96?=
 =?us-ascii?Q?vxAZaQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4a4a38-08bf-4af9-6ea3-08ddc3825e36
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:31:25.3004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kiZov7m7m4LVdiA7qaVi94gjto60ianToFJC5tHzpwt8eB+qMp36JEl7W0sliZ4maoZOJogNLfaHjp/T8LiO+eYUsBOvn6YSfcN54mlH04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9386
X-Proofpoint-GUID: cl95LO0UbmkqWnFvVmzPX1CI9FHW8iMu
X-Authority-Analysis: v=2.4 cv=GewXnRXL c=1 sm=1 tr=0 ts=68761fef cx=c_pps
 a=a/2e+pa09opGXIySEwLRJw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=rcHeGGD4oZby0fXJDXcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NSBTYWx0ZWRfXxTdgzf2X6zr4
 r1pfzMbHwg96Iw3C7Zbq+RET643Bzxq5s3KpAjIcYMMnRe5l48XokH+EGDK+xWWPourGPE0kT9G
 9iWSy+H25oVIWh+r7nytsE0Aphcr1brIGUSBFC2qyebKO66vvItP/syKOLSXmg2fEbba+FTwqM2
 IVzT3gto9YgMAjSltrsKvElCHPC4zACPYAZYS7Fz37s90OIwwu9D0gDWcbGEpQbiBwfWXqku2ES
 A22EHsdOtPA1JYBKZKt2x9khUnAHHzdiHOo1bUyIvJVc7dj34tEXydA+OT5gTjsK+qSFmAD42F6
 2VrMnKlD968le3GN51AVCC0vs3fwtP65XTJa/t5D1tSofInIBEta8R/Pvw6hyqgk1KhmxWI4pD5
 t/paiotfW7UBsjMOzRYbhhdu/jlNhPFNLp/+VkAVN8rp6SeePFwbKZuV4IkL8Is3IX0Vhk5t
X-Proofpoint-ORIG-GUID: cl95LO0UbmkqWnFvVmzPX1CI9FHW8iMu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Use QOM casts to convert between VFIOContainer and VFIOContainerBase instead
of accessing bcontainer directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/cpr-legacy.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 553b203e9b..8f437194fa 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -41,8 +41,8 @@ static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
                                    hwaddr iova, ram_addr_t size, void *vaddr,
                                    bool readonly, MemoryRegion *mr)
 {
-    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                                  bcontainer);
+    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+
     struct vfio_iommu_type1_dma_map map = {
         .argsz = sizeof(map),
         .flags = VFIO_DMA_MAP_FLAG_VADDR,
@@ -65,7 +65,7 @@ static void vfio_region_remap(MemoryListener *listener,
 {
     VFIOContainer *container = container_of(listener, VFIOContainer,
                                             cpr.remap_listener);
-    vfio_container_region_add(&container->bcontainer, section, true);
+    vfio_container_region_add(VFIO_IOMMU(container), section, true);
 }
 
 static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
@@ -98,7 +98,7 @@ static int vfio_container_pre_save(void *opaque)
 static int vfio_container_post_load(void *opaque, int version_id)
 {
     VFIOContainer *container = opaque;
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
     dma_map_fn saved_dma_map = vioc->dma_map;
     Error *local_err = NULL;
@@ -135,7 +135,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
 {
     VFIOContainer *container =
         container_of(notifier, VFIOContainer, cpr.transfer_notifier);
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
 
     if (e->type != MIG_EVENT_PRECOPY_FAILED) {
         return 0;
@@ -167,7 +167,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
 
 bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
 {
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     Error **cpr_blocker = &container->cpr.blocker;
 
     migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
@@ -191,7 +191,7 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
 
 void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
 {
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
 
     migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
     migrate_del_blocker(&container->cpr.blocker);
-- 
2.43.0


