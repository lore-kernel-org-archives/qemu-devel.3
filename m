Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B2CC71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 12:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSx6S-0003ee-Pb; Sat, 21 Jun 2025 08:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSx6P-0003eQ-Vy
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 08:13:46 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSx6M-00083s-KU
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 08:13:45 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55LBe25x006554;
 Sat, 21 Jun 2025 04:45:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=f7v53R2+D+V3SINLC3exjbD7c7etQ7WggZsb+RRDS
 /Q=; b=beFfCby42opPrZrxsV5Y9RP3iicmVgCiv4/gQxiNRg3fpTLTyEG6c2YQs
 m2xY4bp2Fie83SH3lVhCiVrvY79jyYvvpO8Hfx+R5XR7MndspVXpakTgAsOCHj/i
 +H8l+pp3KryA4BhfA1kncv2s/BaISVcSyUo4pTBP6IGq2MFH+oh57Sx3H0Y7sy75
 tvWHGZb8Sthi0lhnOz77Cjg0ixo1vY/rocAqst8OQSUMu7gip6zeDNwJmOFyU7Oq
 j7vMdGLw+9+5ipIAPVa/FvRH9DF5Vh4MtMHGskiFOwRLrZbQVlOGDEd99iuTy6t/
 naqcC1cRVYr5O69ZbiMTGWpSWJZlQ==
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2139.outbound.protection.outlook.com [40.107.95.139])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47dv2br04t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Jun 2025 04:45:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xWOfThoION7dobZXOqQirI/ngKghDfahrozIe2xtR7r2+ez8DhSSgHEQ82UwI/fKd5ilK7BjMmCVYG6iIja+qT7962Rm1j6plFtXDuTUMrIkbMX/qKvC8iqyz/4hg1gVkdVBRyS76XQJYcJ8GAWjah84PywfZ8hT836/UoCaMnKEFhYQvtXAdWARF2qhcOuhgLbjtufz5EOi1IMyYGgZvTZe3Dw7e72+9QBoL2N17Xl3wQd9s3e0IK4ZpeTVdHpadPziR2NGy/ZcL83I237kn1iuXMzon5okI6liy8Mebje2IgEjyEZ/XPK+fQrXwJ1GY01PBpjKeaDG6Yp4bys6mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltTNWj/RmjV95T3+h570Pl4CULd8Xfkm5PI710FROtc=;
 b=OiFBEfnLs1sEQcdFviroPLk+dGrfNoMro5AVVmv6DmyejPdsDZti5syYr2mqmkHGdBA/Yeg4G8EUnwor40o4LGQUIGVIC1fFZIpi2uoHV7vf+zuY5/xDKtnQ0TtWutDDaojc7Bkjy7uGb+YoV7LcddERgcbSqtRM6azO9p2bUpIUbZyYfZEGGBD+aKaR9whaGlboMcLPU/r74JsqdxmArpYBHlnPbVTqv059oAIDS/MpGFYp1knvcS9SqR5bdsvorL0dyuaYlM/Bj9BJhd4ZW5R0RWELDQnDJbfHuE4NRBcPxp2f6b/JRezZ6DYSbZuN2OHGMHUAK/oZVYSLnRVuzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltTNWj/RmjV95T3+h570Pl4CULd8Xfkm5PI710FROtc=;
 b=JFYiChFBcduaEli0DgZRtap5KjQU2JjB3tgdrw0Dnx2HQz8IWWJy1H+BPX8ySrH8dxJxpqTHA+qgEQOfAUbzqzS9FKKm03zhSyiEDzI7uRQiuegMuO9qdfYf06NNvDe485WEh53B/QI+5HuDogHHxV79s+C+K8IX2q7fz4+TveaoWqoL4850x8pj6y7YxCrtSqw+jD6w8RhQpfOYV2M9KpoZWcWe0vhNsRi0QH/5hnex7nVVpCWyandcswJrKFpEYKyhneb2fkpx5qMO82Ot/KqB4c4OZw4fnUSg0HmkXIKRmtFCep6njilD5sgEmK/h1l+MgcRM5RLupHNARtYc3w==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8614.namprd02.prod.outlook.com (2603:10b6:510:102::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Sat, 21 Jun
 2025 11:45:42 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8857.016; Sat, 21 Jun 2025
 11:45:41 +0000
Date: Sat, 21 Jun 2025 04:45:37 -0700
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v4 00/19] vfio-user client
Message-ID: <aFabYdacLpv3RHu8@lent>
References: <20250619133154.264786-1-john.levon@nutanix.com>
 <3757d761-db62-4d22-b16e-c634f504bcb3@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3757d761-db62-4d22-b16e-c634f504bcb3@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P302CA0045.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::20) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: f05bf5db-62be-4b51-6517-08ddb0b9260b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?cQzuDbanpvnrYjTZ6dbS9OXrdhVNf9/UG3wqXsMZPH8rZdceMey0h+2/Ws?=
 =?iso-8859-1?Q?7ox8wvTPYX+A6Z4U30BThCQ8Jrh4OZLRyZfUimJ3RoosoNB2pXePL9CrJK?=
 =?iso-8859-1?Q?nIy9aNAtwXe1Mptu68Emx2hg3aHniaW0zX4j0+jfkn3Qdz+FPPpQsAAdb7?=
 =?iso-8859-1?Q?cumcS0zi78KeAqnuaXd3miZJVeovxxiTyp7t4QmdxornEqy7NEo9kmaUFs?=
 =?iso-8859-1?Q?0mY9h2Bc90tacjDjQsTS2tLL0QPbysoUh6D4quhQlpwknLAOBbNx2gfe2z?=
 =?iso-8859-1?Q?Xauygfzrrxq+G+mCJuRJYAF3/G6yR4tgAPRlvrRMRhhnej/H+jg169OVt/?=
 =?iso-8859-1?Q?RyqNTwjOebObkPdoD2nDtEz523Rdj2i/vD2KSo3Ll/FWkddt04H9AhbvSU?=
 =?iso-8859-1?Q?QGMamWoMUc9HTP8VdV0FJJoPAvjsLBPVgJVA6IU1g1Gpj0PbrRjfFC3VOR?=
 =?iso-8859-1?Q?cB4Oe0mAf+t4sXpusDdObrDq7NyvWXRdhHuZ9/20ghRBHETwMTOIYuWE2I?=
 =?iso-8859-1?Q?VO/UHdV4NvYo7gjM/Fsi93U9SqnV5+BuoEUcrVA8HPq9l1gMluzjpGBfZr?=
 =?iso-8859-1?Q?OUKP5TKjrtqi6rEr4c2PlgW9sEW5gTP1khA2ZFVjti04mxRB8dlOQM1rck?=
 =?iso-8859-1?Q?XvoCFYVuXXYnIsgsZ8baPeu5Lu1uu0TFuZXH7vPSaCSDbpkxfWsWLZ8MNg?=
 =?iso-8859-1?Q?PIMq6Ee47Gc4z7q25YJl3N0I9nUfq4J3VOZzncD/tWKSdL7eu/xLIsmdYZ?=
 =?iso-8859-1?Q?rTLfl2M/uh8bNd7diJHuVYypHhlVDCbtxbw4cRBcyzROP59qTGRH/xXAEO?=
 =?iso-8859-1?Q?grTqIyISDBR4+eT/ZiMEhVfghgMI6ccQMzxGi0jCzZwuNELFQkP2FmPuhB?=
 =?iso-8859-1?Q?vt74CvoDCiZ3ACRSImsiECqdOqqlZhuUbBDtyvzX/2zGV5CcrPs6sPCsoi?=
 =?iso-8859-1?Q?M5raArePavOXE9nZ6aZ86Z6PA38w2Bhceqxg5WDc7Ey5riRY3Dl7fHGVcD?=
 =?iso-8859-1?Q?iMfipCKG2DgN59L42GD/nYUkJPFZBSYq/tbXw4D7MUcDiAbG9l+fC3EX0d?=
 =?iso-8859-1?Q?UVnPOqwoykpUfUySPW5NBixynzUZQeqF4V0FrIU06xZ7C15KDmPCLmZjaM?=
 =?iso-8859-1?Q?JbTXIYiSiHxXY7hO6Mbd9ADRrDWY8YeZBC7FdNqnBhAmI++p2uIvQIwu6x?=
 =?iso-8859-1?Q?kjLXZxN8JVu/Xq6bm2R8UuC5CACmb7L4gaXGZd3bwd7fblyBhcQlexpFYa?=
 =?iso-8859-1?Q?CmItuFVHRxd8TKrc5ilQubt6+6ycoH6mu16jhV9MhQf7Ea6HkySYkbaqEX?=
 =?iso-8859-1?Q?swvqgwmJ4W+HAXq1yjxTwcKtdB/OdromZad70Y/IEgCTSGdG3qS5XHR19p?=
 =?iso-8859-1?Q?E5jVLUwnbVfMgQ7m0uNrh2fSgWbdD+5eko02oQ3M023xKzqx50LOTip8hp?=
 =?iso-8859-1?Q?JV8HkwOxxc0cpDlNCNNoc0Z7yBF6hhRiNRwSSmFPHe/vTIIf+qyBDAu4nC?=
 =?iso-8859-1?Q?Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Z/9RoYRu7pbIGLDlAvQk/u6agqAGebG+/jleTjIkwxC8ODnUSo82MNpayb?=
 =?iso-8859-1?Q?8UJo3inV6WZMnKDA3LngoXjgdoGC4fN/m7RLwPHyJ7M2aj85A+6msY0h3w?=
 =?iso-8859-1?Q?jWMw7PS6+gN2F8326fw5HJDM2jLkyCE2QljVXC02RqR1WoGkr+EiFYqiRm?=
 =?iso-8859-1?Q?atHYp1Q/a4saHbwm5enA46BYjY1GJh+gJUXyEr32tIk9qAZZjr2B73icJc?=
 =?iso-8859-1?Q?9ibukMWeu44CGGEV4hEV6+xGqzMTzGKnTDArNxn0ZNropfqDbXO5Zt+so0?=
 =?iso-8859-1?Q?04VZKY01BB8rqZMPnoE9jf93HPGGPAyvt0btotKB5D8lWcM7NavKPyGXkX?=
 =?iso-8859-1?Q?rmcoMdN3zoOH80OeXEvU43LTEXe/yimzwtWj8oLLH0Rwodw8NTmRDR3MB2?=
 =?iso-8859-1?Q?IOrOpve4qzvPiiklm2XpQEkx6RIYiyRkRBG6ki46HQ3qhIcFjbACYV+JR4?=
 =?iso-8859-1?Q?0J3pypvC6Bslumpvy9MI3FFgD3Nag+ZflQQo9RiwRr8Z0yDioESTh/muTt?=
 =?iso-8859-1?Q?gk2bRLn/L8PtCmzjO0LdndliabIYt7Z3HRAn4K3Xv4mMpSeqNhe+iNG/+Q?=
 =?iso-8859-1?Q?f9RN8K14k2EDFnvrarMzxXfcbkX7kIoWrAtzG33K0+xzyZH3KuRpi9jEsb?=
 =?iso-8859-1?Q?Kav81Oumh6n+m272zKeMgm5zJm9SbDYO/H+LglAssH7qGtXGK1bgT+i493?=
 =?iso-8859-1?Q?U2hEhqQ0AQryLMhm2iejYn//7Ep9BeGqu6GN6McGl5qw2Emv5H5GCGJl4h?=
 =?iso-8859-1?Q?yUTVRUoJ6dhDcXHvO4HQHMCleMETjc0h8xtTlYLQHw9vo07n/IwZyls0iG?=
 =?iso-8859-1?Q?oqSWrMMUo+FrkpN0y0Mww6gzxa0O1h0DMoDeAvvqWcJgtgdjjModrxgy/X?=
 =?iso-8859-1?Q?O48U8VpXEE6RIDC4UfAZL3aHk/HMVuvbAynjAam7pM9a5Lzp5utFvpjV5i?=
 =?iso-8859-1?Q?Vij+837hTRrwFUwf6rQwgOpA/neQq8Ek6krCow7GGLbAdxVpG2IBxD3FUT?=
 =?iso-8859-1?Q?zEoNUpNCZFtWWRoU6Vtp62wBuQfIKm5Q6o4tFY4DglxH5kIDsNuG/ttRcp?=
 =?iso-8859-1?Q?ZYMLtn8ERKUQHS8FhUOQF5BHIWYLm0bHdBDPuHYdhZTGGr+xc/CThhmRPt?=
 =?iso-8859-1?Q?N5535j0INs479e4KBIDjr2skvU5JPDyaAo/tnaewXgMR8RenIMPxkyzN2r?=
 =?iso-8859-1?Q?pOdB3NUKeyYD/27OqIBQdjML1rFika19qyIWOwxAdGfT4ZACwFhZ1m2+Fb?=
 =?iso-8859-1?Q?HsDyu+jlvxaCX7ZPwIO7GyWlLcMwGGbgBDdyhJQEZwXbvELDy8pnM4dYhJ?=
 =?iso-8859-1?Q?gvPdzrfD2Hvo92y+S3FUdYLbAYQYKdD7bzP+ZQKd8ogFNc6KK/yOwX2CMg?=
 =?iso-8859-1?Q?2EKjWK5Yil3nyDELlOvW/G2qX8y8GESYzPYKQ8QyqOGNNgMJfyEE83gobP?=
 =?iso-8859-1?Q?H6lj7Poej9xKBNCCJwF6spN7urU3EDxsjimOfjK0qTgN/dXRSzew9fsAZ2?=
 =?iso-8859-1?Q?4EP3PQL+fpiOGmcTBPcBeN/cjqAs2TUSwydzuazGUzgPDNgvY8zfL42ea3?=
 =?iso-8859-1?Q?t1TwYmLALA5OnyqMg8bM6QKu9Lt0iphWs92Z85qXl/undnM+ecuFFGcwAZ?=
 =?iso-8859-1?Q?UhKvx3b/Xe6WzlJFCl0Ye+0PY+T6hvCg9R?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f05bf5db-62be-4b51-6517-08ddb0b9260b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 11:45:41.7226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBYie5CWgyvfFDJAMYxYxNdUpE6oU+1n2eb2Z0Wt2vuKyPAmjcVNcfKtGDWz41NJOLMVFecJ0UR2m1V741ko1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8614
X-Proofpoint-ORIG-GUID: lBhEi8xQ1p9c6YFwTRxyM20pJLieLph6
X-Authority-Analysis: v=2.4 cv=Vfb3PEp9 c=1 sm=1 tr=0 ts=68569b68 cx=c_pps
 a=JmP0gOEn9Vz95E9ETgaMqA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=f3yafkf9Tt79zE-W0NUA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDA2OSBTYWx0ZWRfX9t3dHrtQ0nNp
 csFZeNZGUSgmcdWiqZrDWjBtGkPb/rCLciwcrNdfZFbnuxcMATozQIjlfW/JUIrs5TK0+3Bc+LN
 +KXapSdT+/Nyk1uN2OyMzJFMlwA5dJ+8z3ZliPnW/0NCA2XK+7T0pFaKsQRs7rbefUVpQWi1Ruf
 O6SpcKeUwM2CPbdYhq3bAUH4bW8+OIDTs+z6HwmrvsZdlCRmGNSjb9KNZf+AWE7gBTB2S7HAav3
 dCGogBoymk56iSIu/cicUit2RzZMHsH+lT8b1Qw8JEHCCDZlwm/IdQ8U95x8gxZjXDkLvj816wo
 KmRA+cpPUrq6FXFZx6dXNzKNl866EVE2O5UZwJ6nVo6oVrmu30C9KeDlq5czAjWstiGV9R/Ml0R
 6kxIThi8IZk9doMFtFgQyqywJv1H19VNBPfJ1D1W06x5vInv81oe2aRmS5pRq1r3Wa1ccbJx
X-Proofpoint-GUID: lBhEi8xQ1p9c6YFwTRxyM20pJLieLph6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-21_03,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
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

On Fri, Jun 20, 2025 at 11:11:10AM +0200, Cédric Le Goater wrote:

> > The series contains an implement of a vfio-user client in QEMU, along with a few
> > more preparatory patches.
> 
> Please run ./scripts/checkpatch.pl and resend later on, as we might get
> reviews.

Output is below, MAINTAINERS looks correct to me, and the other complaints are
for files that are the same as in hw/vfio/

So please let me know what if anything needs to be fixed (and if I should make
the same retrospective fix to hw/vfio/ equivalent).

regards
john


1/19 Checking commit cfffef23476c (vfio-user: add vfio-user class and container)
WARNING: Does new file 'hw/vfio-user/Kconfig' need 'SPDX-License-Identifier'?
WARNING: Does new file 'hw/vfio-user/meson.build' need 'SPDX-License-Identifier'?
total: 0 errors, 2 warnings, 461 lines checked

Patch 1/19 has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
2/19 Checking commit 132ba4d3a176 (vfio-user: connect vfio proxy to remote server)
WARNING: added, moved or deleted file(s):

  hw/vfio-user/proxy.h
  hw/vfio-user/proxy.c

Does MAINTAINERS need updating?

total: 0 errors, 1 warnings, 316 lines checked

Patch 2/19 has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
3/19 Checking commit 459bf245dbde (vfio-user: implement message receive infrastructure)
ERROR: New file 'hw/vfio-user/trace.h' requires 'SPDX-License-Identifier'
WARNING: Does new file 'hw/vfio-user/trace-events' need 'SPDX-License-Identifier'?
WARNING: added, moved or deleted file(s):

  hw/vfio-user/protocol.h
  hw/vfio-user/trace.h
  hw/vfio-user/trace-events

Does MAINTAINERS need updating?

total: 1 errors, 2 warnings, 584 lines checked

Patch 3/19 has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

4/19 Checking commit 8bc73aa81e1a (vfio-user: implement message send infrastructure)
total: 0 errors, 0 warnings, 698 lines checked

Patch 4/19 has no obvious style problems and is ready for submission.
5/19 Checking commit 0197d0323b7d (vfio-user: implement VFIO_USER_DEVICE_GET_INFO)
WARNING: added, moved or deleted file(s):

  hw/vfio-user/device.h
  hw/vfio-user/device.c

Does MAINTAINERS need updating?

total: 0 errors, 1 warnings, 165 lines checked

Patch 5/19 has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
6/19 Checking commit 0d4bf7c4847d (vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO)
total: 0 errors, 0 warnings, 134 lines checked

Patch 6/19 has no obvious style problems and is ready for submission.
7/19 Checking commit ab4156d34c6a (vfio-user: implement VFIO_USER_REGION_READ/WRITE)
total: 0 errors, 0 warnings, 96 lines checked

Patch 7/19 has no obvious style problems and is ready for submission.
8/19 Checking commit 880367f1b72c (vfio-user: set up PCI in vfio_user_pci_realize())
total: 0 errors, 0 warnings, 39 lines checked

Patch 8/19 has no obvious style problems and is ready for submission.
9/19 Checking commit 98aeea76f227 (vfio-user: implement VFIO_USER_DEVICE_GET/SET_IRQ*)
total: 0 errors, 0 warnings, 169 lines checked

Patch 9/19 has no obvious style problems and is ready for submission.
10/19 Checking commit 98dcb17f4a2f (vfio-user: forward MSI-X PBA BAR accesses to server)
total: 0 errors, 0 warnings, 89 lines checked

Patch 10/19 has no obvious style problems and is ready for submission.
11/19 Checking commit 90f17d9f77bc (vfio-user: set up container access to the proxy)
total: 0 errors, 0 warnings, 115 lines checked

Patch 11/19 has no obvious style problems and is ready for submission.
12/19 Checking commit 1cc6c7a2318a (vfio-user: implement VFIO_USER_DEVICE_RESET)
total: 0 errors, 0 warnings, 53 lines checked

Patch 12/19 has no obvious style problems and is ready for submission.
13/19 Checking commit 44a2750529ec (vfio-user: implement VFIO_USER_DMA_MAP/UNMAP)
total: 0 errors, 0 warnings, 306 lines checked

Patch 13/19 has no obvious style problems and is ready for submission.
14/19 Checking commit bd778e2c6e65 (vfio-user: implement VFIO_USER_DMA_READ/WRITE)
total: 0 errors, 0 warnings, 265 lines checked

Patch 14/19 has no obvious style problems and is ready for submission.
15/19 Checking commit 55b7d98a7919 (vfio-user: add 'x-msg-timeout' option)
total: 0 errors, 0 warnings, 55 lines checked

Patch 15/19 has no obvious style problems and is ready for submission.
16/19 Checking commit 39ed25427ff9 (vfio-user: support posted writes)
total: 0 errors, 0 warnings, 142 lines checked

Patch 16/19 has no obvious style problems and is ready for submission.
17/19 Checking commit 7d146a1fc463 (vfio-user: add coalesced posted writes)
total: 0 errors, 0 warnings, 276 lines checked

Patch 17/19 has no obvious style problems and is ready for submission.
18/19 Checking commit 1df337f26b29 (docs: add vfio-user documentation)
WARNING: Does new file 'docs/system/devices/vfio-user.rst' need 'SPDX-License-Identifier'?
WARNING: added, moved or deleted file(s):

  docs/system/devices/vfio-user.rst

Does MAINTAINERS need updating?

total: 0 errors, 2 warnings, 31 lines checked

Patch 18/19 has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
19/19 Checking commit 472c86cd1066 (vfio-user: introduce vfio-user protocol specification)
WARNING: Does new file 'docs/interop/vfio-user.rst' need 'SPDX-License-Identifier'?
total: 0 errors, 1 warnings, 1540 lines checked

Patch 19/19 has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

