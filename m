Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED94C79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3x1p-0002au-Kp; Tue, 08 Sep 2026 10:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1x3x1n-0002a9-Jx; Tue, 08 Sep 2026 10:42:27 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1x3x1l-0004AQ-7j; Tue, 08 Sep 2026 10:42:27 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688EH9ho3233521; Tue, 8 Sep 2026 07:42:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=zDS8vEva64Juj76
 nbYN1d0HqlqqFmLEgsR0aPTjETz8=; b=Z8P+GyG74yXjY0gDi1VIBCMwYEFvN9Q
 8kuSszabaYwATzE+v0h+6h4dVDzlTCo377PacVMFnRodrzBpXEKeaMoRg1rhPoJ/
 smNi/hv/3P5LxvfTn2X6Qptfea+prEHha5MBO943fj+EnlBEPLpObmTm657Vo12F
 vxA+QNMeT63Kc9p5KD3qvwzbSOheFKksa01o18HtxDJOLeFZSqPvlz3Es90p1uMC
 auGWlcx5mvTeShJeQqDgfqKUgVm5dCeXBPmuMBXRRTP6hInTv30w1v7LOgGvkRu8
 +ygdulQgdL5ScvhWk/Eks2CanIMyWuL5plcFRLprlKHtU54L6JtuZCA==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020138.outbound.protection.outlook.com [52.101.201.138])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gjacysegx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 07:42:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkVQUzg5pnitRSCdAXJL+owoXnIABz1MHOZcCXtKdoL87zEKZwKv3XB8wf1aNK+eVpgpcqS2KeVN2Nv+SBuuE8mrejmt12iFyRGFKOB6no5c6fJun+4LE9bOzqEUDIwFQMsQyeHQsKnbmMRSpIp+cp+tEIj5XsfzqNTvhnBcQdQUWzia+3rRvG0VP5hFpuPl3D3qAstjLny0fHoy54yEpRe7KOZWpe5wRdvaFeZBEeM78e+27xbrV5MSJynSuTAl1rWKQKLwm4bLn+RkFBkKfU7Zndp4yrPEblY9buZjZsx/MPGEMD2UDzfNIaYHr9IIADDYCKUSC9GIN7YU5obcWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDS8vEva64Juj76nbYN1d0HqlqqFmLEgsR0aPTjETz8=;
 b=SNyPp5I6es+YLgDEwtWgL+3qiz9pRuETWJ/tIUGNwC2K/UabPqazFHUsqy4lUBBk2MuGsb8XJWpBeUUZSPQOCL5XWg2QWGfUBtKZ+3eWan2U52m+/CoLhuAx2XeYDU7J7zGa384+8iq0X9+8MatZXQ8q6NCTsry1f8tEhYdOXnlaXB3U9aZxS8Iibc8kRMMvxWGLJS8sC7cZaFaNDv/H+EvpJz7psVq/Ori593JyFu5c6seORLREexb8yJpxasyPPz3sbrK9iXLmpUvkxMkv5L/VthRyX5g9YJchJ8BC2Z+P0haTBNxdVyUd+I/Rd419fuW0kqUDdL2XmhmGhxB4xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDS8vEva64Juj76nbYN1d0HqlqqFmLEgsR0aPTjETz8=;
 b=uQ5UmsuCgnaeEBTZeVHbhKegH3RCXOCQ3e1glslWPr7yODjMrcbbrfo2eN/1BESgnNuWLryQE1ThjrGwlMw36mEP0Vz+4q1w7XWnNcWuvEA6C1u+0i/dTinYecIqGY2WMalo9utm4TLH1Aoyh+qg8CZPIFy3VGeZ7LhMFQOvLfWsJXIZgVERbD3/UyE4mct3/hOhSify4v1ifaOTtNWyrJTxP72JmNyG7ZxOlKSMEhNLuTDLXF2hUNK/9hZUVh86iWXIgxDiCy5uurT/yt7YImDuXD/gGRW3WcNyzZRL8hw4prjVh+b8jNR4uP3SHJJo1e3Tzvo+t4FGBJ7InFrDEg==
Received: from DM4SPRMB0047.namprd02.prod.outlook.com (2603:10b6:8:6f::16) by
 PH0PR02MB9383.namprd02.prod.outlook.com (2603:10b6:510:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 14:42:06 +0000
Received: from DM4SPRMB0047.namprd02.prod.outlook.com
 ([fe80::8790:d3e7:341d:9a73]) by DM4SPRMB0047.namprd02.prod.outlook.com
 ([fe80::8790:d3e7:341d:9a73%3]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 14:42:06 +0000
Date: Tue, 8 Sep 2026 15:41:58 +0100
From: John Levon <john.levon@nutanix.com>
To: Hugo Komatsu <hugo.komatsu@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Rafael Castillo <rafael@trfs.me>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH 1/8] vfio-user: add live migration to vfio-user protocol
 specification
Message-ID: <aqAetjhiTlHglX-c@lent>
References: <20260903130833.1437632-1-hugo.komatsu@nutanix.com>
 <20260903130833.1437632-2-hugo.komatsu@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903130833.1437632-2-hugo.komatsu@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM9P193CA0015.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::20) To DM4SPRMB0047.namprd02.prod.outlook.com
 (2603:10b6:8:6f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0047:EE_|PH0PR02MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: ad82ed71-69ab-4003-72ac-08df0db75af3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|7416014|1800799024|18002099003|22082099003|3023799007|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: EXgWkYqLI5v7jBistOKIa5vMjmEHoQhmCWIxBKv/HP6ZA8dMkLN/MYt4P0jMEbE7o/G04SYBwdqbxXFAZU/OOd6/kFKv6YOLtwJAf6HS6xdxir/uLSlIj6BHN3Mlm36CK2RRt0NnOSCBM6J3qOqN6Ajg8AYtU2Ul4PrqWiuYxqqygtEMts6HL9sByx6vG38DNCUE7XJ/w4p5Hxx6n8kFlmITqThAVKp/7ZTV4PD3iBkafUXC7LVQqI+XWIiU6MZtOzB9w3BpjSDgVJ5J5vx7+BWcRz/TQw5gHUgQ83ePULPJfFk6+8ucm4sw5KACGqU5tDJukk2IsTaNwvQ8Tw3dr067niK8+50aLnsMpGzn0FwXVyG/dhifeAPfm8QnRymApuAJz8AyPTIf5Yk7MsKMFL/ps/B1yPoSXR5KHcVrxHdvEVN/lEoAsSpBiQv7gQAs8dsVq9JxwFQ/LcP7wsTXRkvyqj/47W2rySscM6d5hXWN+V7LNqLPpBNC42gpofajNb8+rou+g69a6VuSdYSYe3+tjE+eZXF02+e1FINVr4RIYEUQl9A/Cyx+IJHx4gbaZ1wuB6wkOluW21mW3k2OpCKC+OwEexuyGKEfDcCwDQxmvsEQyinvrx5nkuXFMJUNkZjqiXoFCeGJkYuWvx+eo7c8KD+xaSTbspI2o8O8x5s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4SPRMB0047.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(18002099003)(22082099003)(3023799007)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gRuU403iL5koTacfsysDWCmy1F0ms9TKlzjZ/pfgiawbDoX5PM7UBrXWtiN2?=
 =?us-ascii?Q?NUzh4cTaYNx2O2vhAvLtnUCrWRavdh3CIw2N2mmRIlBhDq5NONQwXJQjxYgH?=
 =?us-ascii?Q?2TZQfhOEzyzDoqxfA9EFIj12/6qwk08z9e7X4t41uX0q7HQ/uUgwxQvj7dFG?=
 =?us-ascii?Q?61aY6ubHaqnGDS5CViOZluhvTPLybdst3SYiUMIYD9OY0iLnEN6ZtpG0Oza5?=
 =?us-ascii?Q?TOHvIC7nsj6g8VqbQQdbMjixACxTFBkv2zz/owE2CTyoiJJ4ZhNY0gujs4W+?=
 =?us-ascii?Q?MwNtg5qMUuzKYGIucc0OAxZP9pZs9yZprwm1ZSRUs7zvK+K7KfQ0Hfmqq0HI?=
 =?us-ascii?Q?O9sPkF9/F61BBqWIh9vbWcNYC7Er5YnPj1/6NRkkKgMa73T0SFs+BDkCWs3f?=
 =?us-ascii?Q?P/IHqvy+/J6iZtYrYDwvXJNycBNPZKjmXh2trAxHKABiNYM296uQG0NNVB3S?=
 =?us-ascii?Q?4T+x1aRGo8bIcZzpBOjVSaWZE1bXOwQ12nz5M+GP2YfPsnC0KF4GbKqxIbbL?=
 =?us-ascii?Q?+3JFkNJ1/uFXFyCRlFIPE1+u3H1TSLhW1Q9wNQJY/2rhKl2MHpixd46Wa/36?=
 =?us-ascii?Q?ww5QvdapmQWJRREzz4iFe+ncz7/jOZZZNnxDk+Z31cR9DZmM7e61QpIP7aFZ?=
 =?us-ascii?Q?LJBb3oLlaf81SRn7quKz6YVilKDaw5S1oSmdiMAyYEnq+pFtJgdtV5VofdR+?=
 =?us-ascii?Q?p+28uhGnO0eOmZ3Vuo0uF//hsicSsCJm0rLBEVJULVr2g/tB8Ek6iRKPxruM?=
 =?us-ascii?Q?N6yzskxdzBUBWVpS6DZ8ixNgqSYS/1yKN+G6q97xIwH925VNJfZuC1Sal0k7?=
 =?us-ascii?Q?nwdnYOnR6AtjU612997rHW02krB16SOuNvG4IOeZ7bXc2DZNZvDBQIuHX0xw?=
 =?us-ascii?Q?+Nu0vUmYq/kAuOOS23ezzsX+sGtKrakcz94R0VJeD0sz8tKJhbMNlG0KATAD?=
 =?us-ascii?Q?ecbkHq97XEKfejuNOvFmcmDOn0eyYwfNz26I0LPCA8Lr5IplxjrdRYvNvd8F?=
 =?us-ascii?Q?HI6tKncpiYgCVpz5Y5z0WvlVKrlEw21rvTENBfa3EcoO+KnqmlwxBZurgsJF?=
 =?us-ascii?Q?jTK3BtWJpU6XrvoxU19WwJpn+zvS4goywdVHWxyefnGcVj0XpbjIPIifoD5p?=
 =?us-ascii?Q?CuYV6/dmyp3Vc7FHT75y67ZqHufZkhwKSO//mLoAkesLxaOE3uFCBFq9zYFd?=
 =?us-ascii?Q?5yDQX3vT5JeIEUhnyD+R6dXjFvgByk4nzY/p+Qtpt1+jVmOtU63AAdQCiiW7?=
 =?us-ascii?Q?mud97/tKBb21StYbno+1tFM4yRvyz879poSQgJnUEJfGOk/imyLGoCzEd51T?=
 =?us-ascii?Q?MmDO8Qk63sL6Huoy+xN4gHaq1qg4yBxLB6AUUVYar5SUZc/5e3DKmtGB5qwc?=
 =?us-ascii?Q?aszvU9t4V2ESsNYJPtGfzoeIlphHMYT5G+0VBB6IMO3rYpaus/N4IqPxXjdE?=
 =?us-ascii?Q?tBfim8VOLHKINXK/xsjysCGX54oyupeIadj7niapAyo7WKPNySui+jkx2T3a?=
 =?us-ascii?Q?KVmK1QRrv33ycs3mufRbI3vCv4cmI1KnI2djCjwReFz8HFVvoswYTeAaTaxu?=
 =?us-ascii?Q?XiJSXoSDQ1XT4zV9oCEE4C2x4MuUx8BlG3zFSUd+XtkfA5Cbp+nlxSgvxg+D?=
 =?us-ascii?Q?pHo1amt88HOObeb/1llBolzzOWKpEHMi4nNqtoDBLdMiW1u4YTxv22VIt6z8?=
 =?us-ascii?Q?VWzR2JzMuqx3f5S16/YBlG5FVkqHQfiMBGb5XmdWkBarWiA8Pf3G5x/Y6xs3?=
 =?us-ascii?Q?p+mi7Cx3GQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: aA0OF3yy1Dys9uMyQeJ8TKG6mrKUj0szrZ0fJaX+gfaH4dkPv0y5xGtPjPy+xCyFYa+kaBaIXGoUA0Kx3D2cW8yuSNK9QShaeQaoJqGaAxfuS55Ql0/tvhwPe6LMmg6POc8N0xGIP0++8wQnw0EWG8dSsYM/bbwgii0yCbQ2D9u8M25uFcuJBfGhApgMOs8bbjhfTBlzflHWW0C2Ki2mtsobI8+asYIFb+AvV3Y3UNqiWNCgvbOimfJ8vSo7+Gf6EycooFF+uPxP0X6qJ7c8CuFZfQT5NwgMS2cfgmv6aPqk/OhEHYLKPN9ySl2BPUoeNMtwwpDy4mySQ7dQNSt1lg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad82ed71-69ab-4003-72ac-08df0db75af3
X-MS-Exchange-CrossTenant-AuthSource: DM4SPRMB0047.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 14:42:06.7554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zg2YuCJLFlrSV1jrFkCFOFqioLKiTBTrOpC95gn6HEaUGJeOQc9/aRJ4/ezM+JuAc9NAjBdKvCGLMZy5v+AjSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9383
X-Proofpoint-ORIG-GUID: mYOmjCwe_BkmyrWbkeSYZtmrkIX2Hojw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE1OCBTYWx0ZWRfX9ZoNuXBkYfm3
 EZ3pMFTagDRQHXhSpEKRSmj9OBmbe52PvztFsHOqY0RwSk6N/xxOniJLOdAe2vGtiZ1wQjOn/H9
 QIJX82/Wm2QtBh2TmK/VmS1fzGIRcz+z8HOpfptmC6/hzSsPFXMqtB9l6rXzPhQK+UKtSZIT2pR
 V1IsItBNoGRUXzlayDjr/5dcjaIH9cWodOhLuSHXocQukCDA5PsQKuNhD1KTTRT5LR+EGxJgb1K
 rPP5oD67Ddr4Er5Ji7FTQ8qwYRHrk/fuV24w1DRlPELQCKO9y3q5CIyyfckdRPDavMi/5Mi/uXf
 v3Xyd0SAZIC4LNdV6nhcI+L+nuTp2HVL7VB/XIyA7o9V6zMDAIcopEDdRa0NuJT40vKt6RJQ1eZ
 3vMG/X85/FBJmvGXgV/CyMgIMfgS/M3WhmT/f1GmA5j34W3J7AMIbhvL+RJGUkdAafuc8U4aohb
 ZxAYyqQch5/VUANt40w==
X-Authority-Analysis: v=2.4 cv=Iee3n2qa c=1 sm=1 tr=0 ts=6aa01ec2 cx=c_pps
 a=jcumTT0saVzx4HVuorHqQw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=64Cc0HZtAAAA:8 a=O8Jr-ni5Zz2Bzfc7weoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE1OCBTYWx0ZWRfX/5k4Ntahe0Rx
 Bn99Hbu++KXCa76oOPgCdF2QF+Fmq+uRfYOiOKeUW6ncDQAA1dzqe5MT7j5Z6Vxl9hgv01wNPqM
 QG0fz+mCPqAENNv0OxprpjG1BG05FJU=
X-Proofpoint-GUID: mYOmjCwe_BkmyrWbkeSYZtmrkIX2Hojw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Sep 03, 2026 at 02:08:40PM +0100, Hugo Komatsu wrote:

> From: William Henderson <william.henderson@nutanix.com>
> 
> This patch adds live migration to the vfio-user specification, based
> on the new VFIO migration interface introduced in the kernel here:
> https://lore.kernel.org/all/20220224142024.147653-10-yishaih@nvidia.com/
> 
> We differ from the VFIO protocol in that, while VFIO transfers
> migration data using a file descriptor, we simply use the already
> established vfio-user socket with three additional commands:
> VFIO_USER_MIG_DATA_READ, VFIO_USER_MIG_DATA_WRITE, and
> VFIO_USER_GET_PRECOPY_INFO, which have stream semantics. We also
> don't use P2P states as we don't yet have a use-case for them,
> although this may change in the future.
> 
> Signed-off-by: William Henderson <william.henderson@nutanix.com>

Reviewed-by: John Levon <john.levon@nutanix.com>

