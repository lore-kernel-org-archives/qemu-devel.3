Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12672CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 14:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13UE-0007D9-Ky; Tue, 23 Sep 2025 09:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13TS-0006Mu-E7; Tue, 23 Sep 2025 09:54:31 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13TQ-0003xy-6V; Tue, 23 Sep 2025 09:54:30 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N90Uv5612415; Tue, 23 Sep 2025 06:54:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ZA+BsDFq7jh2EdiwBHBRF7XUxqZ3kb6sjZ3uqPuci
 4I=; b=R84B2v1uV3kxc5QN8NVSoZ9ozhOgbydXWPDbGP6z0Ia+fomhS05p3XnPs
 xF8Kuxx61igQ0tTn677pC4da227D1JXQ+ssASnthozvfj8hir4vuzZwB0Vmc0nmw
 vXaNLatN9MjtRzbDa7sYAqkkn9SlzypQ8Lc3NPy5w9KH+qQPQv+8MQIfnAHTECui
 AMLZrEZNcombnjKKse9T0VtyHM7tuRY8ywL4KHZrYjRhaNLVifSR9qpqbRf7cWh2
 2xuBmnickGk4KrLUoymao+fsmfzzk+0SNz0/en5gm1dRzz6q8SL7XXGs/kaWDcQj
 p6kW+VC37RU2+/IfUbsMLI5QosMHw==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020126.outbound.protection.outlook.com
 [40.93.198.126])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49bfef9q6w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjTyS/GJDTxlwq9tFrCZIuUIFtxl6x4g+SQ/LEazN8+WDwqE122xbk0gsAgWWBuizdXqStbTZo7i3z4kqFhqt2OIIa2SgTmqjCqOtu9mpMBpZ54buChXBglYQF0JDzb0JzNnHkbMFfK2l2kfOorNaZp6Ijueb3THW1y2hBlxRZPSqSs+LUZE6xyWas1ZGMlalrMacuBCb52b6l3duTWAvfUSRGWmwBIZy3/Kun/hAFKjbiuy8/bm3AxBL97xUVFthe61fbrvh6tg/1+Oi4wQPlyDciFWAFrhEAIQZEREBRHZXhuF6fBKCjY40/dAoI9c5i8kn2yyBHzMaspfsOeyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZA+BsDFq7jh2EdiwBHBRF7XUxqZ3kb6sjZ3uqPuci4I=;
 b=fMPNS3VSeh4NtvBLCKgq1nmLPackSsvEd0bqlc//vsBGjSkcW4dlrh9Xrg+OOfAr1ulq2j3lkQTRFnzDIxUV5Q/HTjISiMKo7c3obbAg5Kf0SOzs9/C4iGoaX+eJ6XzFNhOCaDkuA87FBgvhzJYs7S4Xnsz1I2oP/facYcNRA+9Igp3bOJ8GBDeuIHpSOXXA5unLmM4Pg6AV1aVI7Ck60lxb0F+zBNSgetSvC+qQEK6pk/B3rYKTp8I0EjmOxSUQJ8BmxlbjhRSTqqYG70lACS6MG1dgUbZ7lhBOflbzEEkMtY7TFxrulfj4LIg+tM/0uONCLaI5Y/1hlKeeGetl0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZA+BsDFq7jh2EdiwBHBRF7XUxqZ3kb6sjZ3uqPuci4I=;
 b=Jz8HUUBS0UaXQONPTnPYVLE2o1w1nlqvBHsZfCBsjpZCscMeeRJzIrlmrepSy2kKybi2FEhUYYHzppdjdW/4ouhyx3ZLUmT2HD2H7F9uxadIgStSSezr3XpySRQcZa/RQ1LoBRPR0h/qdPvXJXjP7qpOcQUqVnF5poFzUTaMvdKDrEh9Y47/Y4rxNhC0jHW4uPCvhLryz+9kUoM880D3jrMdTvSRyFCQSWWV9LWQvLQmBnYhPF0mknPE3jiTlht9OfMlRlXaJUoEHn6hxSr/TxDqEsnz8PsDtcDMgyTrr5U3ritqZUdxIltnMjrW6EK6F37MmTQI4OJAUawO1qsyXA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB7037.namprd02.prod.outlook.com (2603:10b6:208:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 13:54:22 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:54:22 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 07/27] vfio/iommufd.c: use QOM casts where appropriate
Date: Tue, 23 Sep 2025 14:53:13 +0100
Message-ID: <20250923135352.1157250-8-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR08CA0015.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::28) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c4721c-2864-4046-0b75-08ddfaa8b33b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|10070799003|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Tx1PWjEqmRlwtEGhupPCYQAcCuW5bbU2RMDrW+LdQe/XkaiaXyP6DiPoEblC?=
 =?us-ascii?Q?PJwyo3L3Hmd0WSFSQGcX4/zA1e3O4jRw5AOtltNx9tBZREbEOriGjLw18I94?=
 =?us-ascii?Q?QbHzv1TRrXCusDcr/VZnzYo6kcEnDxMxo6ysZdABot2tVq3PrGhQdJK7/S1c?=
 =?us-ascii?Q?kyN8p+JDTdnt9zH9gEELNr5qnXe2IozE0xSGUR7wcyVA3Whg5OonWAmse26m?=
 =?us-ascii?Q?qBUCzzFUofsP6MdYbwofagS/SqAPmvK0ffPabVCsY3vurUOQxjHlm1vMxYhE?=
 =?us-ascii?Q?cqlSJqFgYjVgdo65nIlNl4PXQIkeACgl4TJ44O2Yzl4dC1CPBmPgn5XTKtRH?=
 =?us-ascii?Q?4NyD/SED/t6kGj8FB22AJufEO6P/V6RmegKVYQdGJJ8b2CujCwjghbEn1iGR?=
 =?us-ascii?Q?WkS6eG8uBQ1lt4pOHXRP4B3vcMikx+HLIqrLaJsLAUtKA7TpIg37x9zyJYJh?=
 =?us-ascii?Q?EQp42rGX4ry3g3andDnc+V04W+AjGuI6HEfRgo2KaGclrv53FdzJDoLybQAe?=
 =?us-ascii?Q?ulOVgZhsm4tw4TkyHqgYHibCLEIHv1I0KX3W+jlT/pnCiJIpjH8a3xjl1Dru?=
 =?us-ascii?Q?XS3MvYEInyYiwFYzej2XYSIfkvFG2/rl/CMlVSZFm+Mrs2l6wU1LUMVl6GaY?=
 =?us-ascii?Q?CJ/mEMvc+4c3u92t3Xz9MVsvjAMlx5SoWe9THcVh2l0vnxLtkwmLR5EpFKrJ?=
 =?us-ascii?Q?hbtmFX3G/B+DIW0elg2z+PbKertim2m9BAaaJp4AV6IigX4AfoGzpfSs83y5?=
 =?us-ascii?Q?YwHCK3dH/RPvnvUtpPhBbFGwJyZzJzw/eEkRxG6GoDGJn4dHZnm8cekPyfgT?=
 =?us-ascii?Q?J1cETY3HnF82PzquclyPrplvLwzb0gWEeFgEpT1/lGjicTYdzUMZoaKYYgRk?=
 =?us-ascii?Q?JYL14sLztbA+XdOaZs65BaLD+jQmx/fgtGXWC7kS51eFNBZylObTXV8VEJ06?=
 =?us-ascii?Q?weps5RDXdmfZhO2GyDDP++hcMN+HqvUnrhtbrHROoVLlA6aAMG2GKpzCZOFD?=
 =?us-ascii?Q?U51heLQEXF+FdQnmeI6hr2jUS7kQQK2+cdD+3zWTw1xRbboGaB9PG7XtUZND?=
 =?us-ascii?Q?zhBxHaiOuVa8pjvoIB4R2p5HtqJwX/pkFUyXTo8AqkITizPOF9tDp3UBtfgt?=
 =?us-ascii?Q?UWzxZI+2vC5odeAPwy0X+l3lAmCrT2eezWJmBKi+6KUj7H/PedTidJ3ktHlt?=
 =?us-ascii?Q?kbmgzoP52YItO5BfJL6BIANR6AWJtHXkEtVbl7yrRMUNJDxbiMZn+9R0AoFh?=
 =?us-ascii?Q?sxQAIwsHBVBvp/FFkrT+ZNB88udrg7O5efHeuo1FWDzYHWti2jJDEHCjd+xR?=
 =?us-ascii?Q?OiwREN4DSzN9JFJXNdEnO1+PI1Dudrq3Xiy7RxH5Gjk3Vh/eOYodlKbGFv5H?=
 =?us-ascii?Q?21HD7p5gY4H94Jjtm6kvzW3OMxzTn/24ZOP1Vw9bll/9CEysVAaAz3j5WiM1?=
 =?us-ascii?Q?Vw2ADOKXom+p7iHdtuDDpxQEfVelv1sHAAhbkn6WEC3wSohrfNqKMQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3WLaEFELFmxdB60UanvQS50GlM1p8zcJMgrGbAerqp1SsxUGIt/LXtC29U5n?=
 =?us-ascii?Q?Fn7fSF97tNjoo4gzNRWzwkBQMRA0Yf8Isr2sPYj4QB+y8cf4qP8I9JGL05D+?=
 =?us-ascii?Q?g7c4NE2QbemmS8HKecPLvF2+0atCbEgjSFyXwKDJ/5oDeyT+xOA4jsWm6C4o?=
 =?us-ascii?Q?XRbTWccdR4/p6WQbjMhjGnfzP7210HaDtzyB0PLDOYKsO5bYvBm1X10KKKS8?=
 =?us-ascii?Q?vTBzq+O7GU3EOO/CZ3JcrJJaD8vFgjprYOqJdT0Cnfyiit33sdVbJnYcZEYn?=
 =?us-ascii?Q?v1H9tqo07VqV/1tZn4ok0gufE0Qjd7yv2oCNjtL1335iYRs+kol+Pib9rbjx?=
 =?us-ascii?Q?Nm2E9af3/WpH3ogR0SQXyRDudOP02ppn4yltW1aEtjsoGYQbDMOqraP35Yot?=
 =?us-ascii?Q?Pvq+LHd7J/bhiILX9c7MdZwvVnxFRxrekXeKPW+QLTnAshaCLwY68f0ks/vc?=
 =?us-ascii?Q?AnyeYbtfVMEGnjWrRxY0W/ScTKOQahrCr3QDnwR+TsJXL01TEJkgO3/istxc?=
 =?us-ascii?Q?W3MiVxD57Wqrug/vmdlY1bKGVJr2BSzA52ZZdvFVsj67/z2v1RGluEZvG0ZL?=
 =?us-ascii?Q?Z8qhIkh+2B//BLGzDh+5xZI7zHHJdQ71HUeqIuQ3ejlE9mcqrhMgFWRBi6CU?=
 =?us-ascii?Q?XJFHutuiTGqwTaWXUUQBXuZaej1myZ4sRm/eD1vGMtCheKoJycl1/yRZVSiX?=
 =?us-ascii?Q?S+I0UjPZDMe9ZAf71FxA2OlaVplqBJR6rRAFWKujpWroROAYlN5GqD3ztpM7?=
 =?us-ascii?Q?zB0G6dFJSVbad5USpqAyYF9aSt+AM65tdSmkYyfHiGr18HTKWNZmA2erlDsE?=
 =?us-ascii?Q?dYeJ0upEvjsRSU8q23cEfbPluenCg3f1Xh/ulslgP8YP8tgev0hU3KBQJeEH?=
 =?us-ascii?Q?fKpM3ePwQue3cmp/+42B3QlOPP82MqOmHriyAvxGVrvurYPeKnfq7WIsibH0?=
 =?us-ascii?Q?H9jzNwiu51gznUWv+F/qoHCngCwRYIDkfw7zNBB2BZBZ+XyOuo8VWwhs/ARc?=
 =?us-ascii?Q?ZBcDETfT8MI8BcX2+83wy0SFMSOcSiOjvxdzHhEmfMWrGiLx6+zRhjYUxqkA?=
 =?us-ascii?Q?zT0u/TSTdj4SiMRmJxNlwAUzcowmRcFfNUHAkqyfC3zj9iunl5VPjK39j2tH?=
 =?us-ascii?Q?92Zu8q7Oxa4WOweXb2Q5bORUzJaBcrzyy44phb+3XLTKSrA0IwOPMQIpwbaa?=
 =?us-ascii?Q?B+NU/MVlAJcfW18m+0zjoDmaNJplNylKwd9ioZhLBmCEys44yjqySTjbsTKa?=
 =?us-ascii?Q?MlZb20vORa2KksLPueWMPsal2pjfS2m7Ex6jE1ZNun4SplOVnaiAEQjHMrC1?=
 =?us-ascii?Q?cGbp6WQaFfrTVTkP0N54vhhpYyJTaCHy0SNrH3p2lhmrjLcgXjoPovSyE7JK?=
 =?us-ascii?Q?W0Wusdr/59Dh7TJwBBMdjiFgWU/ufrnxXfpIrT2lTuiFR21zAH8l8IfIoy0y?=
 =?us-ascii?Q?F7ReLiRRgMQ42qAmES7lcK7LyKGQDdVtv1U9S1MaEBFKSMPWxYDZ1dAH0mOZ?=
 =?us-ascii?Q?fdrUPBfa5Q7+6aZQ790qsjEUNjIlf3fSRvsThtGAtmKQpH7dLx/RyBF9zHEp?=
 =?us-ascii?Q?fGCSN94rlaBRsA+u2jkwhqtqwf+70XhwQJ1vulweh5pCwP0eZskeS0UULKGS?=
 =?us-ascii?Q?dmROQ1fBI/blA2L4zFt7xC36+byA+tTlwWlppTqiaN9ADmnEc3sw9qxTIMB+?=
 =?us-ascii?Q?fTl3nw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c4721c-2864-4046-0b75-08ddfaa8b33b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:54:22.7283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxBqEkbmPPnk8R8DEkZS70Rw87Bq4wfeYgJJoyh+i3zGIOw73S2GA+53uNkKXzZJ4sDgvktM8Cz9tYHm2ykFj+tS7GSLFQnGVbWUPm/oDIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7037
X-Proofpoint-GUID: f3B404yhwy4xJss8foaah40aQvLPI6Bp
X-Proofpoint-ORIG-GUID: f3B404yhwy4xJss8foaah40aQvLPI6Bp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfX/crPKGo9CuaQ
 E2U9nN9W+F0lVjpMuX0ILeyg8/eiQo11SNwRGyMxAHfep5ZjuG/5cZESEDOjGrDIGk/W4Q+i4tn
 nZRcdZrd7y6WqziNYiyxy+TmpGf887CApnGcnWe6KXF9g/nea5PYOKqFuq61jpIHBrpzZw60oNm
 o9S9goGwGZyrvrjys2YCMNJ0MNOw4K00kCgzSWol+MKeoLr65KI0Jkhi3GM2nx7XhKbk2FVGkDg
 n4GrU57SXry7tY91J81kw1UvWMrhQeqoRTr7/HcQ2O7hhPHg2DJgSL4lWYpzmyg1z+3nlkiHE5v
 FSuMQBhquD70TcqwnzgS6y6RJ286vnjWaqrf7E7HLV9V9ravZ9zQq8m4fGNWU8=
X-Authority-Analysis: v=2.4 cv=eI0TjGp1 c=1 sm=1 tr=0 ts=68d2a690 cx=c_pps
 a=zTPsRPtK75HwG7WtZKDGLg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=_4X0v5D6KZ3sM8ZCYpYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

Use QOM casts to convert between VFIOIOMMUFDContainer and VFIOContainer instead
of accessing bcontainer directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/iommufd.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 7f2243d9d1..f0ffe23591 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -38,8 +38,7 @@ static int iommufd_cdev_map(const VFIOContainer *bcontainer, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly,
                             MemoryRegion *mr)
 {
-    const VFIOIOMMUFDContainer *container =
-        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+    const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
 
     return iommufd_backend_map_dma(container->be,
                                    container->ioas_id,
@@ -50,8 +49,7 @@ static int iommufd_cdev_map_file(const VFIOContainer *bcontainer,
                                  hwaddr iova, ram_addr_t size,
                                  int fd, unsigned long start, bool readonly)
 {
-    const VFIOIOMMUFDContainer *container =
-        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+    const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
 
     return iommufd_backend_map_file_dma(container->be,
                                         container->ioas_id,
@@ -62,8 +60,7 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
                               hwaddr iova, ram_addr_t size,
                               IOMMUTLBEntry *iotlb, bool unmap_all)
 {
-    const VFIOIOMMUFDContainer *container =
-        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+    const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
 
     /* unmap in halves */
     if (unmap_all) {
@@ -162,8 +159,7 @@ static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
 static int iommufd_set_dirty_page_tracking(const VFIOContainer *bcontainer,
                                            bool start, Error **errp)
 {
-    const VFIOIOMMUFDContainer *container =
-        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+    const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
     VFIOIOASHwpt *hwpt;
 
     QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
@@ -194,9 +190,7 @@ static int iommufd_query_dirty_bitmap(const VFIOContainer *bcontainer,
                                       VFIOBitmap *vbmap, hwaddr iova,
                                       hwaddr size, Error **errp)
 {
-    VFIOIOMMUFDContainer *container = container_of(bcontainer,
-                                                   VFIOIOMMUFDContainer,
-                                                   bcontainer);
+    VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
     unsigned long page_size = qemu_real_host_page_size();
     VFIOIOASHwpt *hwpt;
 
@@ -324,6 +318,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
 {
     ERRP_GUARD();
     IOMMUFDBackend *iommufd = vbasedev->iommufd;
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
     uint32_t type, flags = 0;
     uint64_t hw_caps;
     VFIOIOASHwpt *hwpt;
@@ -408,9 +403,9 @@ skip_alloc:
     vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
     QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
     QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
-    container->bcontainer.dirty_pages_supported |=
+    bcontainer->dirty_pages_supported |=
                                 vbasedev->iommu_dirty_tracking;
-    if (container->bcontainer.dirty_pages_supported &&
+    if (bcontainer->dirty_pages_supported &&
         !vbasedev->iommu_dirty_tracking) {
         warn_report("IOMMU instance for device %s doesn't support dirty tracking",
                     vbasedev->name);
@@ -464,7 +459,7 @@ static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
 
 static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
 {
-    VFIOContainer *bcontainer = &container->bcontainer;
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
 
     if (!QLIST_EMPTY(&bcontainer->device_list)) {
         return;
@@ -486,7 +481,7 @@ static int iommufd_cdev_ram_block_discard_disable(bool state)
 static bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
                                              uint32_t ioas_id, Error **errp)
 {
-    VFIOContainer *bcontainer = &container->bcontainer;
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
     g_autofree struct iommu_ioas_iova_ranges *info = NULL;
     struct iommu_iova_range *iova_ranges;
     int sz, fd = container->be->fd;
@@ -559,7 +554,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
 
     /* try to attach to an existing container in this space */
     QLIST_FOREACH(bcontainer, &space->containers, next) {
-        container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+        container = VFIO_IOMMU_IOMMUFD(bcontainer);
         if (VFIO_IOMMU_GET_CLASS(bcontainer) != iommufd_vioc ||
             vbasedev->iommufd != container->be) {
             continue;
@@ -609,7 +604,7 @@ skip_ioas_alloc:
     QLIST_INIT(&container->hwpt_list);
     vbasedev->cpr.ioas_id = ioas_id;
 
-    bcontainer = &container->bcontainer;
+    bcontainer = VFIO_IOMMU(container);
     vfio_address_space_insert(space, bcontainer);
 
     if (!iommufd_cdev_attach_container(vbasedev, container, errp)) {
@@ -689,9 +684,8 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
 {
     VFIOContainer *bcontainer = vbasedev->bcontainer;
     VFIOAddressSpace *space = bcontainer->space;
-    VFIOIOMMUFDContainer *container = container_of(bcontainer,
-                                                   VFIOIOMMUFDContainer,
-                                                   bcontainer);
+    VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
+
     vfio_device_unprepare(vbasedev);
 
     if (!vbasedev->ram_block_discard_allowed) {
-- 
2.43.0


