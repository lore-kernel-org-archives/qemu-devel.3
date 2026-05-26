Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD2DCD5BD1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRnln-0001RK-RS; Tue, 26 May 2026 05:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wRnll-0001RB-US
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:08:13 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wRnlj-0006xB-HE
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:08:13 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q8XOHb3156777; Tue, 26 May 2026 02:08:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=BGglTAcvp+il09KI9dlppADeOqweR1PdKH2WIQmHn
 cE=; b=QGT0qJrymZ7FC4aOLbCZmWVEp9YSpCdZ6pPZx/22+t2VKAoFBljoSDBih
 N0QdylF8ca2cR8oY25tozFdun+bgxebYVpwWlPApo3pTCYCm0rX6cyCGCL38M2hW
 c1B7asUhraDTpXE6QLJRPgT46HF5uMGBvp4/6ANC0H/2ox8v6VqVFB8M+MRLkMmp
 94NDtugUh9i97NszAlTUCCasQmUMDLSIPCQcKJ+UX2jbXDq4sdBEDLd5LkQvQgFe
 XiduZtP9Rs6PcFXeu1TRXNgRVcEun013RTBO1PnC6nA6g5+B0YDZeMzkLaaKOtHg
 PyI65eeZ7UiCSajDOq6CBRdijmWHQ==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021080.outbound.protection.outlook.com [52.101.57.80])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4eb9s869s1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 26 May 2026 02:08:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7+1JqIkr4upnQdOVSTkenazgao1lN9Wo/Cly61KudEusXOTrEGHUHC6NN3WcmP8H/r7wOW4NKhGd9hj9Bo2vrLx0e/aVgJG/amFYVBzAOu1iTpJ82fKBHwmsDhUis8dl3OajvhwcjPgKofyc3DAg4ZaY+8ie04DyH3sxl7n+sNYHI9P+FYLcauQ9xaeV1E+cHO6dqBWvBzAFvYTXfuhFyiWEI9S8NZd3Cw1D1CpVmc0+3WOjiQ9PElQk+eSXksVKAtF0NXAhy2w1Mr99JZVF0OP4SD7idAzR/EV3QJA3WWOHjron0acfgijePNwjiK9IBFLfuh9ukOcNW7HfuF22g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zKQqy60fIRzOsldKRhDRxA/BH4xQyAH7cabuHIaaS0=;
 b=K/t5stjws+Pw9SpQmvAK9/xuCcsDMHmSJAbOGg+elpYrLePpXPRjrkU7nJLTQAczytkQrwrS8tVrb4Th3MkNiboEQlSS5kJpHEhxVzIWmX6nvwaHacHL4lpHayDRHzu6x5CcHe2rneDZ5Ed4BjKFSnCLM++h5FEDTS6+At8gJDl8Hyye1j5maT9cukcVfDtX9L4TSCKvyj1uxqS70FIOZk0opq2ekSUwUFctwyV+bkwdMkntNtnepBy54tF5h2eUW4x4kLTVPlDZsHRCfZJjex5tz/w/I7T01eIvYQAI4NzPbEB6dJrJrmMTfafWlMWcthH6HHsAid45uER4QRlN6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zKQqy60fIRzOsldKRhDRxA/BH4xQyAH7cabuHIaaS0=;
 b=xlyROGkGRhcK2G62/NWkr44YqmikFyC1f+H2THXNVleljo6e022wxFEV5R42DoZ4bTFzZH5NLOk1Q0dDCR1s/uMqT72dShAF/cYtikPOBhCMAwz57zEYUU+LK3vgSb3szojWK374w1dtAFDtkW9dIbmmZ+VZL+WY4avwgUWTzuC/D6mMBX4ypvk4ymbTIlblBjWMmB1+Zbzezbm9pI98OQ6FDlAk4mJppBIEKKGF2Rxd7icYkEmTrVIYoFO8eTR2KaHBP1/L+Pcr3YShmEdr8nknyxEWIoCIOcFD+1K7XD6RcXMXHuPu51MdWUvf+XcQQOwgFO3F1ZuP5SERTIgcXA==
Received: from BY5PR02MB6753.namprd02.prod.outlook.com (2603:10b6:a03:209::17)
 by DS7PR02MB10914.namprd02.prod.outlook.com (2603:10b6:8:263::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 09:08:08 +0000
Received: from BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::a343:65a8:bffc:5a57]) by BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::a343:65a8:bffc:5a57%7]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 09:08:08 +0000
Date: Tue, 26 May 2026 10:08:02 +0100
From: John Levon <john.levon@nutanix.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org,
 pierrick.bouvier@oss.qualcomm.com,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH 36/39] MAINTAINERS: Fix F: in "VFIO-USER"
Message-ID: <ahVi8mjm4MirrOpQ@lent>
References: <20260521080511.999266-1-armbru@redhat.com>
 <20260521080511.999266-37-armbru@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521080511.999266-37-armbru@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P189CA0034.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::12) To BY5PR02MB6753.namprd02.prod.outlook.com
 (2603:10b6:a03:209::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR02MB6753:EE_|DS7PR02MB10914:EE_
X-MS-Office365-Filtering-Correlation-Id: ed97ef32-296f-422c-0b29-08debb064cca
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: 2SUjh/CfJTyXmxATqrWHU7BR2nEiV97TXP2eZh9ycXa1ghhKsaiVl8kjuZNP7zGIvIfdJNTv6lwnnrJUDvCFi+Tu0vs/1CqNs/f2bR0N78vcH8ymnvriCqX+xdkHKJGEEGDt1OnTbNIEynjvAMG3IjhQc6uKFH/YSHuVmh/j18lRYnZ4ErUPcM9/AfQ6gqoqsMmwtL1iXzfdeF1BfJ421mCUWoaqGNzro0njI8krP3p+Me/jG678SyZ1EOC9P7LnLDRMvjsYEhcuxtrBeWXUe2+xnWSBhouPclwbxeyZUcnoVhVqvjxkQbdyicd+4Zzcw+Nq5r5H5yH4sRdR7rnBV3ya9Zl55v7iOE8MsC0Dv3fZXQL05XFvai+tmgo9Pk9XHdRQh0h+tF6Xpd1bdCvbFJgP1r8Q4QTn+HJmKibuvlkUS5RG0GaAgAZYqbX3DTr/SIfH0GiV6VTpr1qy/li3qNj4wM9Mlpvc1jfbuOhlevLl6gAtPDIME3dOe4yl/2dkqqR6vpN0K2VGEpDXRyQ29olDc9A+UUqYETT4p9Ky5RxMmpH2dSnst4nYNccIXxR9Z3iGY1A2LmW2UyQq+AZAkQqthEhd6W9RcRXbJ6/4ZEV9lKLrbVb1k/BCqvuC1A6NjqovH8kRgEwneJl8iWLY8lyU7aS+gmr6e7Zjzzx99PvnDlgVUPT6x1xjBBjciz3/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6753.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1hTuzgRtBoGI6rzLu/BKrQag+2yOjTTpbFVosHidS08UnAnvCTIwzsnxq3?=
 =?iso-8859-1?Q?/a9QN0U1KYn8tLHkwloNf2uWJUMoozC3b6xfDJTqwOPBBqqWQ+9kb4ZaGV?=
 =?iso-8859-1?Q?3QM4aJzhOCHhvRdnJL0Y8aJiNYaZDDL8BGPSvBNAD496TzlY69RZpvmHhw?=
 =?iso-8859-1?Q?0wBVftRcA7YSRA7ux0wLHLwRqTeEbaax0G+0t4JXbrON/Pa6o+81MATFaY?=
 =?iso-8859-1?Q?kZj58/x744Xt7k4On6VcQDluvL35xGxoeyqJUKUxTxrzHm6wBBNU7t17LB?=
 =?iso-8859-1?Q?P4y219XFBB1t5pAAa/ICijp/AxaV2U63P+tMTQ9h5yJ39UBKwGEIODDrcJ?=
 =?iso-8859-1?Q?5Hw8xGNaAZy8fNiirs3ws5KlK0V3MeR7mJZuW/Cn1BluQgU9b56NBwAhjS?=
 =?iso-8859-1?Q?t2vk8zGjiaKlbZMWjT3ssjvRrD+WcLC1WkungERjF0it7p/VYomhEqw2Jo?=
 =?iso-8859-1?Q?sArMC0x03QNHcvx3vHKrQig+/8hGsd9xwmlRSSWKfuMFVEU7jHjAlGGwJ1?=
 =?iso-8859-1?Q?oIDTj/3MxP2EPLihBpD9mr94Aya2c+OpmbR8pyXeG3j6MGj8oqVggybVhd?=
 =?iso-8859-1?Q?8n7qGSfoNIITtq7OC+XrFO5wS6n50Vc2cVFVrANf7uL1KSbj+9xEojJUno?=
 =?iso-8859-1?Q?xl87tf0xOfcijF62kW07ApCO2B7iewt+Gd1o84VKAaLETrS0Lhrtmr60Ed?=
 =?iso-8859-1?Q?M1XyiQ7dGdoKHNjjfCK2Be6D3FFUEGZs7MO45A7KYX+29EJGAEmKDpj41Y?=
 =?iso-8859-1?Q?T5QUnx2oj0F8rAYe6A1acACfqXLjTfacICdlVufEoD9AbnYEq+VVNghJ2N?=
 =?iso-8859-1?Q?CRCFJcketTfEFuOJa0E13PYQwmDWZMYD95kAnYYHPxLGnfh5s4puGExlul?=
 =?iso-8859-1?Q?I5eZt97XbMBlR5fAxgy/iqE98xdEfhDySGVmp42DetJ3gwQEa+gSN2WNzQ?=
 =?iso-8859-1?Q?XJ/329mAv7vQyXPCNMZ1SCCxirsjc2ZkEyZ2g9e+AKYV5rsrd05s0Kx/iZ?=
 =?iso-8859-1?Q?iFpwweWx6s4KTPQNgK+SWbTzMchHx7CHydtqUzDf4tEwka47cPDpq76d0J?=
 =?iso-8859-1?Q?1ffrWpxA8o2MVubIoMVaV02wZNZ7Kt4eDHT70q0P+irZBzlLNr8v8/WGOq?=
 =?iso-8859-1?Q?6iYMPk0RFfC2u5vL9tTM/kblwMHEv4Yl28McxHJ86pKLCWhlHpB8bX2vt7?=
 =?iso-8859-1?Q?joX0pnDP/0pcG+sr5KKw2wbtR4SIWD/p/GNEKgIV08MwyeHH32kzaO7eit?=
 =?iso-8859-1?Q?RPw75g/4ZYfNavxaHW5ehAulYf/cSf+MBuQpW6md7iy+WyTb4LF+wLz/V6?=
 =?iso-8859-1?Q?5D0M+YGfTPwEC56SSTHKPQLXXcXnCeaD2q582qbZF+FN6DYAagnq3FzE3c?=
 =?iso-8859-1?Q?dUNXLAPJ7JqoIW4n1SG0FN9mUy/E9qb/ZJIVetdvx9TnQVwEl0XyFrl4OI?=
 =?iso-8859-1?Q?IlOAX83oe5B5pM5lWphT/VtgDA98UJDtsOpCoLIYfPUlWQnulZRzHWNdm6?=
 =?iso-8859-1?Q?XBirDi+jaEsuhiS/zcLo35+7RaWeDY1hITGvtSUdaJVAQsje7bStLcgk9o?=
 =?iso-8859-1?Q?V9HSB7N62epVUqVPgeYNrYjtyub82DfBWLh9ixvaCIi+nBnddxc/EHu+AB?=
 =?iso-8859-1?Q?NComEkZMb+2J1ySH5hbeKeoeBOfZ0zMEVAyaehCxI23ddgLvhqZhCAVO8W?=
 =?iso-8859-1?Q?MgVwMKArajHgT69Yqjn2uInjwTkKwZvXvIK8fDxSWbdu6tnUj+lCn6fXu2?=
 =?iso-8859-1?Q?3+nKASVrJ9VNVf0K0AwM3q62Rql8iO8pM15Wd9CO10m7MtsFYuw6IPlI/U?=
 =?iso-8859-1?Q?Gu+lGBg8mQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: BbaYTGqgag5oc62hdd++5fq6dKi/uAzwVr6I49OJgwR8Jp1v6Mip4cDdgN70EH7/TT2hCshXrJTEtaW/AwgFjRLBXUREO+KK7JcB4QFShU7cL+sv3gqRLz/lkBkn4tujqASjhN27eOcQJZQJvthDXBxL6Flg5YBvZZlAFB7V01p6T2wbf0gcuoeunN1HshXUvSkUudxRL4tlOhHixQScbDNOxs0QUKoZg3qvlbboiPLPmr6CfDv3mZAw9q+SNb0jsuXT7CGin4S6duN/3OYs2DavIGdT4GwEhIQMXMUQB1EO9wZGJy4OAQONqkHXVr5oYdTASNYR3RWHYP6IiVHaVQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed97ef32-296f-422c-0b29-08debb064cca
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6753.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 09:08:07.9468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mq8WwJRU8rrkVio+/bZW2PWlmNGfj6/r34d6xmXXcSHMq63qDym6Z2s7qG4bMHFk+kao+GlDHe3E0EOw+8/MYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB10914
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA4MCBTYWx0ZWRfX5IYS8hM1+Jvf
 rhwdp9u4C6FHjcIMDsdO+PK8G1hMPCXTNP1/aSfu5lwR5r5aZhIZSSaWJwOFA4reC5KVFNbe2dn
 ayKg0VXs5tJwWztocBuYeKQdHl4iJXY+i35+9dwVcZc14jhy4g6sANYenpryDdIzLPY6cPDbtfW
 0jgX0TbYhPAetf48Rf31zeNWcRV617xvnsHuRr4IYkINyTV4JAkniHt5T6O/yXmFEKUG3JOtgkK
 vKU9PKLw1xCweKbZepKuLHUA1piKm51KaZBZQbbFHOAh9+1Kar0a55JJYmx6CCMeIIwflqeuPWq
 FyI98MAlVuudrKzOrwlXGykhZcVQvZNdgF+UNIuXNoc0tavyMSfsErY5tK0qvQWGNu/CIg+AbVr
 HuwivILr0ttAJDrgR3odjoGTBmFpWQ6WmAZNdndm5piqT9wJBYXptgNtl6qlF9qfJbtfVTic8s2
 316Ca+Ytr+qMr6PeBCw==
X-Proofpoint-ORIG-GUID: ve4oxM0QxRqIF69k0ut0IK6pKOPNjn-y
X-Authority-Analysis: v=2.4 cv=Ov1/DS/t c=1 sm=1 tr=0 ts=6a1562f9 cx=c_pps
 a=ODHLhvGZZr/oS+ofcGj7zA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=fDDmGpoWwrzMiObUgDQA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: ve4oxM0QxRqIF69k0ut0IK6pKOPNjn-y
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

On Thu, May 21, 2026 at 10:05:08AM +0200, Markus Armbruster wrote:

> The commit adding the section added two bad F: lines:
> include/hw/vfio-user/ never existed, and subprojects/libvfio-user had
> long been replaced by subprojects/libvfio.wrap.  Drop the former, and
> correct the latter.
> 
> Fixes: 9fca2b7d70 (vfio-user: add vfio-user class and container, 2025-06-25)
> Cc: John Levon <john.levon@nutanix.com>
> Cc: Thanos Makatos <thanos.makatos@nutanix.com>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7a1b1317cf..ca86e1410b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4468,8 +4468,7 @@ S: Supported
>  F: docs/interop/vfio-user.rst
>  F: docs/system/devices/vfio-user.rst
>  F: hw/vfio-user/*
> -F: include/hw/vfio-user/*
> -F: subprojects/libvfio-user
> +F: subprojects/libvfio-user.wrap
>  F: tests/functional/x86_64/test_vfio_user_client.py
>  
>  EBPF

Reviewed-by: John Levon <john.levon@nutanix.com>

