Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757ACC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 11:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8HdW-0008Nx-G8; Fri, 25 Apr 2025 07:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8HdU-0008Nd-La
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:28 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8HdS-0000PD-Gk
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:28 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P29EKh008884;
 Fri, 25 Apr 2025 04:54:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=glcW4HkFXcqKcyAqMzImLGtwh1T387kUvZVRErgpi
 wQ=; b=a/vzbRH8zrIFVEU46ADW+m+NbgMCuwLsJStuUH3J6/ao7KaTgmbZd3T1+
 gaij1rbLt54vyCYe3egWiSlxYbkCzT+FVYJrRcEWzQuZelHsPAW0bm7tSQlftlGe
 9bC69htkAqcBXDXwLt8+nZGqGNOfy4GFl9+jMUlVhYk20gFURslBAbmeAIYbi0wS
 B0cBEKk5Dx9ljsLPRnP9XxuYdQryLJiNTFZTc6Yk+rukTo+Noj2OUnfNb+Xips+U
 qaXYewitmmRrm8ZKe3gdFmq7fNJLk9n3vyXwp15DUtYWJQ4By5nYvrNeEAUKwZBs
 GVKoqiDOuBozXHUh4lhxdamv8NloA==
Received: from cy4pr02cu008.outbound.protection.outlook.com
 (mail-westcentralusazlp17011031.outbound.protection.outlook.com [40.93.6.31])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 467ww49b1u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 04:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWh+GTMAld/k2S2BeWLaCq6ABYdYOE5tuZUxHlZXE39rM9xxxsEU5YzwUhSzpQZXrpVObGX48HPtcBMhAFlBF+PzxLHLODYyQXTkeRbk+AxiYAVTFNkEZ6v/Cp4t+tq42FCc921+MF8j64FxvK+Ibe7HppaM9qDxubnFxG8MacDc10uQzsFGdLr6FwGD2ktI90BhFtkvHm4xhSrjx3gYI0fwYY0jJwUUk2EliOnWFzneWOx3PJevfA9wEIxEYznzI/FyDJhFZi28bubseEwoKNDYb2i2++xmWTqsfOuvQQg8stVddLiGEIT5otxgPfPpqoJPritJvVAOhQKMJTK9eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glcW4HkFXcqKcyAqMzImLGtwh1T387kUvZVRErgpiwQ=;
 b=bKlRXADmCBEDYjPFgsfv7Vub+f67GKk4AKhnAMEIUgx9u2J7YZv05xzyB83js9cp97r8jpFQxRSn7W43XrYbxrj1IandMbrDnOfMf2cvL7WLB/NcDCOLH/bEB5aXxjsA3iCb9+Lut8bj6WwTAPffsYbdImsRei0kQJ5eUJffXsKC512pPZvLGqt7hqpuxe1gBVc1X4mAmn6sQeodP7uR1VwTIc8JXlSGh9LWvB+5epF8ci2nuJYV/nHdSd7p1iBMohJXUNhvaLkgWdsse3SqWHePbeqhSlct3TYueJDP8BgeS2FpqOq6axoI3Oka6+6pd73Am7mgCUJqPpCHstnpzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glcW4HkFXcqKcyAqMzImLGtwh1T387kUvZVRErgpiwQ=;
 b=Lv/MLhcmp3aFWIgETivVNe0J348/UagoNBixa08VEyJ6ciOeEX7zLZ24JRI7+7DmD6qwlkMwWa0YI47vhKlcbtD3Yr2JeSc8waQBSGF9i3YQzL5pnU/jUMu7fwmUlJdfaGY+B9H8WjKAr56iyN3qp8OWa1gC3QVpfYep3BZm1vZULBhyy5L/xJnSGuWcYLsA1iKZ6SyrJTjNYkLt8L+5ksg0kOgyxfZwfOCtIna+eR2e3hlpMh3M6zh9wbQZlyrxTVVdgt+9UE08EFArMr3cV2vGWlvgXsrohj9XS0h7portznLwcJOZJ0XSxrJJUXngrdVwC4DU18IEbOgjIzy0Gg==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 BY1PR02MB10337.namprd02.prod.outlook.com (2603:10b6:a03:5ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.10; Fri, 25 Apr
 2025 11:54:22 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8606.029; Fri, 25 Apr 2025
 11:54:22 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 06/12] hw/i386/pc_piix.c: simplify RAM size logic in
 pc_init_isa()
Date: Fri, 25 Apr 2025 12:37:53 +0100
Message-ID: <20250425115401.59417-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425115401.59417-1-mark.caveayland@nutanix.com>
References: <20250425115401.59417-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0022.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::10) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|BY1PR02MB10337:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c629714-fbf6-4f66-0d46-08dd83efeb27
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wrppmUhrgy2ps8UGEF9kvgj9U+QIF9iWYQimmSuwkFpTn/ZfRSVMinoaazIz?=
 =?us-ascii?Q?tEjrSdX7M04/FA8rhaN7f3pulVSluMZVFM8cke5AHH/US4em2VpdYvXLHHk9?=
 =?us-ascii?Q?bDlWQ8U9Q/8Q2sV3C1Y5M8iCDdmAV/iwA5PDYzIoCyetRmYKWXmfe3eQZVkV?=
 =?us-ascii?Q?3rK1jm/2IzQkwZApVrKvRyfvlTvXtbHQVHQv5fWkhTU2b0W/f75sE86bFq6r?=
 =?us-ascii?Q?l3Rtk1HMjxUXKhGKbuik/POxD6Nu+Fh0xJFoaQfnccPSB4cj3oCxrYSV7GQ1?=
 =?us-ascii?Q?+3NbbXOFaQXX+geQESPGGLi9GmvR5IYkM2GiSJiQsF+ZfBXLaoabiILcIWRu?=
 =?us-ascii?Q?71DZvcYV/LMSRjMz/fX6+yBJHK5c8v59iWj1/0w2OL+ZcsNJVYmp7dTGEvP7?=
 =?us-ascii?Q?UGuBOSP5Aho5bjFCZtPgrdSiP59H5b6LOab1gYnBzu4eVQndR1IITjN1jsFY?=
 =?us-ascii?Q?NBUNN2OVqJ1YQFtgLvQvY43tibi4+UvN+89nBxJ9+Npum0rztCOHhw2kSOf6?=
 =?us-ascii?Q?UQVhDHxZNRRRwioPoEj22nqLG0c4qyvGclMCeK9y6AzebJwskQ0T4btNAIwD?=
 =?us-ascii?Q?dBZsLBihTPtIytYR4eG+0IQBVoQkNA/08Drefl7HjgEAhMa7f7hM9F64gXxR?=
 =?us-ascii?Q?1V7E5Tlcb+xyUaO2uWbwrt3C4L47Cdwq88cwoqwXObaMYxqhTCnSehLOarQZ?=
 =?us-ascii?Q?tYBmGORBeV6FzyRp0Ddvrv2e8sGe+LliOl7ejplz20hDsVuqfqOlX9HkHN6s?=
 =?us-ascii?Q?BzKn/nmX63qcTZUF2aP5tt9aewHIT8JqMEIFIbASCuXB1Z2MpdzshUoZ+CuI?=
 =?us-ascii?Q?yvLiQ7dEXsUsBczKbnh1XWu32g3MWJoIJNNWBLQdZM/kznCWoU7stdpCL0JQ?=
 =?us-ascii?Q?vY9gDUN//6R/aSMTTcPDGEeGeeQR0FZrf8vCAz7TF/EvrBDEWYMWrzd9lh1x?=
 =?us-ascii?Q?UFiumyoZWt9qc6AToo77Y4n6p/t3tL4QB9UMJU9SUnBXkmAflhDQu+QJvhQM?=
 =?us-ascii?Q?ABTZnram8JrUQ/nEIetmEkYOeqinP6fzNzMshSZp3UC0zGnZLfP4MJldlVi6?=
 =?us-ascii?Q?KM63HTl9GH1tdLTJPuMosu3ByBsGjitgBoBTWRKjCex7afcB5UVMsAuMPi3/?=
 =?us-ascii?Q?9QUghltjVww6U88GWoMgErEMyf8MzkdcipHOMQDLVdh28gIQ62P6GF2mQyRs?=
 =?us-ascii?Q?AcqO7A1qHwM95B4pIhY//jTKWsyQWl7yOSpT/vn3G2Hd8RaZf6pn48TXGu+e?=
 =?us-ascii?Q?/JHbm9zrmmVRK9ZGLEOhpESTGQ7KA01QG6AtM2OqX6ymB5238vDhVIULXzPb?=
 =?us-ascii?Q?+ZCotT+Gtm+OVmOwUTTsHaCgexNL4QFlJf7u01D/6Xgm2uB0tVy+7idptYpX?=
 =?us-ascii?Q?UHKwA0UPgD8RG06grQBCnVRb9kz3a6YFMsNosyH03Z6K4M4wQO0U4rhPdXHy?=
 =?us-ascii?Q?Ze9u/rsO8yc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5kqfLDJuELFHTnYTasrojxaSPeY/oIQpw6R68QD2MR3c3ROH3VIyYws1UrxA?=
 =?us-ascii?Q?d7GahyxNpaRyJjqtGcX/5xTi6niB4thq29/r3bht/OKjQfWN1ZlxyCyJRxYN?=
 =?us-ascii?Q?OhOWBRZO6tRDODeDaFD2zJNQ/judkRwGKrUbq0lqjnnmC/RRRcJqTbdZ1FUU?=
 =?us-ascii?Q?5PaaRnkizTH/+12Dt68WQ4SU3wEupVSZN7hIW/w/VIBHyzThLGU5pXzkWg63?=
 =?us-ascii?Q?1xcj43dDNwJOLV6xMt+TLQrnmfXcrcUnXdeNi3S6QAhxyB2NIPbY09HS0e68?=
 =?us-ascii?Q?1SoNHmh5F84jO3et8L230HuI2qnJwyTUnayx0+Qhd+QTfVSazEXxlAgJSveX?=
 =?us-ascii?Q?krSJWfFovwgKHwc1n1m+uT21l1/c3LpwTZAm10P+IhRhaDXAEc5LwyRX/N4R?=
 =?us-ascii?Q?ShUn1tCDUQ3KlDrrlAxm/RvbMNTUFcxAy/EiuY2xrKOzwqZZKhi0+o0u8rmZ?=
 =?us-ascii?Q?CL3okcu6nKiWhsD3RQoY+g1MNW4kJ5udOi+G7aDxQaMSVdyf9q05dnmkZl9t?=
 =?us-ascii?Q?mGDV3NkkuJYT4IrBn1xjUj6FVon8I9yPHSnbWhsWiXjovcEynIcLmBXL/0CS?=
 =?us-ascii?Q?2wyx0sF1u99rj8XfVSga+4zl0Yvi9OS6JphSuh+LyS37GQ9l+32duFijoUaV?=
 =?us-ascii?Q?oqyNKfsPN5/sMadvGbSHxidINXtDHXeBDzUmyGTo28oF+aQJl/88uGlA6BgP?=
 =?us-ascii?Q?j9DILOxVz7iocCp2XsG4VcgANF1l8izEpuRthlZCB63YSPVaZrXsQ1a2w7+H?=
 =?us-ascii?Q?ZFyegsqdBhpW2QHiB0O5lcL5le+r91rpeBijscArCa1eTyELwrGMnt9OXm7c?=
 =?us-ascii?Q?LfkcdpbAh113S2wJV0u5T56tQr5y616ERsqBsvwuQxRqPKCn1J8EAsB/ksH5?=
 =?us-ascii?Q?qSxoBWKKoWoOoCr+NZ1g19hxsYVj8+/7mdV6mywe1ua6Vj2ozPEwS+56x19H?=
 =?us-ascii?Q?TPvb2dfHFfvFAbBaFA3WmMz/y2+tzGQlQLMhWc7MM3avX7GWKovB7d3Fye38?=
 =?us-ascii?Q?4tD7Ww6+II3+VSmCmkriDMAI0VoTIbf9fKuC0vGS2SiS3nCzIYtRLtMJGilE?=
 =?us-ascii?Q?GwZuDGuDT9rYrd4tFe8a9FkQHBqJkW2Jx3SY062/GLxJ4xa+/8BOVQIn4Bjy?=
 =?us-ascii?Q?ZDB9HAz4dqh7eDUh8dy+qPl4JD+YfqNF90rGJfQ4zJkWqvTdWRX75sP67Pk1?=
 =?us-ascii?Q?jGKcBQwsHGpZOn/80qJ2w6h9pwrREiIpY28eT4M2AIIHXPC0H+VlC/rg/RnY?=
 =?us-ascii?Q?nb5HldT/IP6cGewncaXJJgyHH9RlnPelIOhimLAkAwB7+pt79Zsa3OZbupND?=
 =?us-ascii?Q?ZoiEQV1lCfpITVgAQG0SnlYfvT4X109YcGcL4rd1W3MJktrB3LSSyziLv9nh?=
 =?us-ascii?Q?iIHOk05kRMOjEQtDV7h5EftHbmKPV3YNHckxZTeyq/n//SjjEv5EqXjrvNAe?=
 =?us-ascii?Q?TgScQ3qKHtNU07OJVw0nCRr/M0FP9eS40EPjfh8lEGim22zHEREZOpFnaRwj?=
 =?us-ascii?Q?7f4+0C/2fDCtOqQUYG/pXoDxB0TDwmCsutn/b//RpzbcTaYkIU11OrLCUS5W?=
 =?us-ascii?Q?BHOj6Zk9+MDGiNPMyZdPWd/P3MyhYnwVu4lmGB82UxV27RaChhN8GskVfHkW?=
 =?us-ascii?Q?N6tZaQUpi7qtQShAjqG8QGOBoZKdcVc2mOBrNF1wd3G18EWk2LJsi3CyMoix?=
 =?us-ascii?Q?Nlhr6w=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c629714-fbf6-4f66-0d46-08dd83efeb27
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 11:54:22.4490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFymRnnlDcM/Mgqu/szWj7zZaA/AaKTqn+FksDPxUn9BeK5EY12Tv6oZbj+HSwiFvb5/aeMeVwUSLygMg+LGlmfeuDNM20e2r+/jPe2R4xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10337
X-Proofpoint-GUID: B6fcUck5UDllKjt9zmOI4eI3mJz4Sy1o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4NiBTYWx0ZWRfX90nHVinWKZSW
 BQnyrtV38FdyvjhG/trfNWyS8r/vuno7g6luyN2xSvL3/DH3bBjR4frJydFXULkyKlElnsZ/XJn
 BldH8xM5BVU3U4VKOwgYhdMhH1t2NQiaM7t1PNdnKsan7xQaYMZnuykfZBC9zJRO4Sd30K3ZpS7
 lNlDHr+aiGMxLN1Hm+BAtC9x3IyWzhmUisES3X0OfSn4AGq6hU1KQN22Mg4wcToE9u3Q21yT5jL
 7/Q86RsBiHdWAv7Dundiam/AVp/0E6Ih1NPhpfbFaMhiET1wMgIS0gUQgPuFfmtBgc6DzE28uaZ
 rUzrrmza9Ua/J5TpZPX2xGpibZeVdJdgKsswoxQHaZHKn054trntFt3UGj/hwzU0woNAfeRrpAi
 M9jJCXXmXAKJmO2F+UoffkeQFe2JG4Evm9429GkNu8OK7/dQJiknDyVrqgP2tquLdc4J1g3T
X-Proofpoint-ORIG-GUID: B6fcUck5UDllKjt9zmOI4eI3mJz4Sy1o
X-Authority-Analysis: v=2.4 cv=C7npyRP+ c=1 sm=1 tr=0 ts=680b77f0 cx=c_pps
 a=BzboTkwgGU/iU5aMRKiaVQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=puX-rZ3iWx3qy-NnaecA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
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

All isapc machines must have 32-bit CPUs and so the RAM split logic can be hardcoded
accordingly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 58 ++++-------------------------------------------
 1 file changed, 4 insertions(+), 54 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 1e364ddf26..61097c1e15 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -422,69 +422,19 @@ static void pc_init_isa(MachineState *machine)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
-    ram_addr_t lowmem;
     uint64_t hole64_size = 0;
 
     /*
-     * Calculate ram split, for memory below and above 4G.  It's a bit
-     * complicated for backward compatibility reasons ...
-     *
-     *  - Traditional split is 3.5G (lowmem = 0xe0000000).  This is the
-     *    default value for max_ram_below_4g now.
-     *
-     *  - Then, to gigabyte align the memory, we move the split to 3G
-     *    (lowmem = 0xc0000000).  But only in case we have to split in
-     *    the first place, i.e. ram_size is larger than (traditional)
-     *    lowmem.  And for new machine types (gigabyte_align = true)
-     *    only, for live migration compatibility reasons.
-     *
-     *  - Next the max-ram-below-4g option was added, which allowed to
-     *    reduce lowmem to a smaller value, to allow a larger PCI I/O
-     *    window below 4G.  qemu doesn't enforce gigabyte alignment here,
-     *    but prints a warning.
-     *
-     *  - Finally max-ram-below-4g got updated to also allow raising lowmem,
-     *    so legacy non-PAE guests can get as much memory as possible in
-     *    the 32bit address space below 4G.
-     *
-     *  - Note that Xen has its own ram setup code in xen_ram_init(),
-     *    called via xen_hvm_init_pc().
-     *
-     * Examples:
-     *    qemu -M pc-1.7 -m 4G    (old default)    -> 3584M low,  512M high
-     *    qemu -M pc -m 4G        (new default)    -> 3072M low, 1024M high
-     *    qemu -M pc,max-ram-below-4g=2G -m 4G     -> 2048M low, 2048M high
-     *    qemu -M pc,max-ram-below-4g=4G -m 3968M  -> 3968M low (=4G-128M)
+     * There is no RAM split for the isapc machine
      */
     if (xen_enabled()) {
         xen_hvm_init_pc(pcms, &ram_memory);
     } else {
         ram_memory = machine->ram;
-        if (!pcms->max_ram_below_4g) {
-            pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
-        }
-        lowmem = pcms->max_ram_below_4g;
-        if (machine->ram_size >= pcms->max_ram_below_4g) {
-            if (pcmc->gigabyte_align) {
-                if (lowmem > 0xc0000000) {
-                    lowmem = 0xc0000000;
-                }
-                if (lowmem & (1 * GiB - 1)) {
-                    warn_report("Large machine and max_ram_below_4g "
-                                "(%" PRIu64 ") not a multiple of 1G; "
-                                "possible bad performance.",
-                                pcms->max_ram_below_4g);
-                }
-            }
-        }
 
-        if (machine->ram_size >= lowmem) {
-            x86ms->above_4g_mem_size = machine->ram_size - lowmem;
-            x86ms->below_4g_mem_size = lowmem;
-        } else {
-            x86ms->above_4g_mem_size = 0;
-            x86ms->below_4g_mem_size = machine->ram_size;
-        }
+        pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
+        x86ms->above_4g_mem_size = 0;
+        x86ms->below_4g_mem_size = machine->ram_size;
     }
 
     x86_cpus_init(x86ms, pcmc->default_cpu_version);
-- 
2.43.0


