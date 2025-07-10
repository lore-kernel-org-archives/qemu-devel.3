Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7F4C83F18
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZn2i-0000QM-PA; Thu, 10 Jul 2025 04:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn2f-0000EQ-2a
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:54:09 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn2c-0003a7-Fp
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:54:08 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A8Xk9F005901;
 Thu, 10 Jul 2025 01:54:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=srwo/MTicQQFXhI1NLoXSJCzuRP7LozOadrVDq6Tl
 CE=; b=I0XwOqRZLQat4fAkqvxj0/5GVa/DdTsPP/f7VLk2lo5eP21kqKYcgUxEn
 kUCe5lrX6gy0yGgWDhtVdyxbE2GX985lJXo7L+jlpU4oLyIwLiAtDPp75si3IOJv
 XIainsfwilEys6sPhPeyeexjzV15P/rCgCDIHSdtR+MPCPpHwpdjit4MsK4fGB0d
 gjfJ2lTiImivfNWpp2eM/cKXp4IsThrbgTl5SEmzNk6shs0cVD+CpopeVIywSGOs
 EzP27PHpVmTbBJYvPpQV67XPj8CuUT4K0ns6fZ4g7PMei0KDgmh5b4AxE2I1YAe4
 VxdiefkHxySWPeENtcDOHN+ba36AA==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020140.outbound.protection.outlook.com [52.101.61.140])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47ta49g1h6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 01:54:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7QbpxO97HMRGIuPCSOeTYWcPJy23AyOTn3VqPavNKBhIB+UZBfh3T5wntDvrEaj0GdX6nq79qY/SUnoBZJRQpsnEEpG7xKWYlEcatzj+8TnfpBZxMHMB+nbWNWGxYohaPbddymB1y2+BX27/+cDV/yX83rB/uaUzPo7W4sUA/vVqTzlZJJOXo5EHFSzGTAUIDVMBeHjy+dNeSrF1MQcpPhMjYy6mtBbSKkNqE6tfPOMMVPOsHYgEPrNdU1C5KqLOvvHt2X+DQD4jupQ02dVhTO+aLmTmQ9DtfIFsKnrQUe85h+TFBVLD2Mlnysd3A429NjzCmmldTkYl7fRZKCS2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srwo/MTicQQFXhI1NLoXSJCzuRP7LozOadrVDq6TlCE=;
 b=opLEwHEQz8z5mnAMre/3pnpv3bmNiP2sJW93hkQ0mL+QyrLwELNu++0RqfOKzoQrJnvpByvih1ja1rhvXoEQ7Aq6qpB4r9a5kr4UsIvPalyRFpxsezJyOdQ6Hvavv02wnqgvShRzBKGu+mpslP0VJErjBRVyL320NayMnIgIN7hyKOU9idh+8AoEiaXLelwwrUhpLB9jMsxy1BARgNWjl1fDMbpuLZxmJjFiR4SJ/kW8DQ6olIz1GdDr63txRzHInBGyrqUbX17Eq7y3n8W5tooDL9Oue/9IQdd+Roj0RF0HJ/U5ThRk+G85ZqOyAC/DEWMnxpdicKjKBctMYacLcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srwo/MTicQQFXhI1NLoXSJCzuRP7LozOadrVDq6TlCE=;
 b=eZuuT+h2Ko17JQwMbbFLd9g4BoJ0lGIOeBbQ+eEViu2B4PydHtOyi0BXQ46/sisg1tXZsE5w3wHikEAzr8sS2Gq8dgRqcDw/I5oAxaLWMslmrsc6BTz+9MD8BDS8FFL60kNZa8OKpXS22f6isKiaeWpmyPlx/IahzpKgIpyZWCbDrR1+8PA/jJHLcmzqHEmePo8Ht9iuabNVN9UZup/y9tto8nXxyr3rlfe++yPWch6x9SIRHIV6/eGY9fUdspFcCpA/Hq5r1wkfiM4SZmSmDJVZT0X8JuHvR51b5fbGvGBrX5FPNg3S6j98XO2s5E6lOui7y3cnnadnyJSEYNweaw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8048.namprd02.prod.outlook.com (2603:10b6:408:16a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 08:54:02 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:54:02 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 14/18] hw/i386/pc_piix.c: assume pcmc->pci_enabled is
 always true in pc_init1()
Date: Thu, 10 Jul 2025 09:52:29 +0100
Message-ID: <20250710085308.420774-15-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710085308.420774-1-mark.caveayland@nutanix.com>
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0023.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::28) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: ff85ec56-bd4a-4389-8135-08ddbf8f5186
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YOanoCffa6+d+9AByA0ttN0WiD2qjavdcjJCYQBT3UZJVboBSAblU/opXahe?=
 =?us-ascii?Q?PXiwq0+pU6txSznyeH5uTwOluMNeOjFj3pUSGn+kyW1gMAaotCbrN8Yh978D?=
 =?us-ascii?Q?rWqq5IyPLkR7ZCx6fbAbYYNK+3sL1hMMvhWNjJBEkQE5tJlTVEnWe/LUJCqM?=
 =?us-ascii?Q?8NWEIFdwXHreqqX2a18kjdlDdTlR1K9G3H9ycS978VzAN/zGN3jJOopQHl3R?=
 =?us-ascii?Q?7w17avsyCGLy3aLqkQHEEecUtYWUBkpPIhsoO/l8NaPPFZ5cMC9076whP1vf?=
 =?us-ascii?Q?6EIVSx16UHuUKX6i1npHOB7KLKteNLXzfmxxaOPvxqZ3jCRv/rtdFk/Eq4v7?=
 =?us-ascii?Q?wYZhu6lxUq34LZ5/bV008vAc37q1XexQzzwY5n/FK3nulxZUJ/+Ayr7ksYco?=
 =?us-ascii?Q?xZFotJ980FO7astOYfGOrHKGk9UaVBc/lKf8WTka4TUFZkmb3TVOfCab+tqR?=
 =?us-ascii?Q?7xNLoQaUUrxZkUq7fXs26SJ9tue4lTSm22PoXu7AUMwxrOU0rYZKAutAHeCj?=
 =?us-ascii?Q?VtwHUOYp1IJrn476uR0C4zWQtLyWDpZ/00HuVr6wwghiBNBA5CvoAKpp2oyr?=
 =?us-ascii?Q?Hg4Arj0MSFDFIprRmC/5skGHNQQLwC/WYd4cl5WiiRV7qBlKcPkYxKYpxwGe?=
 =?us-ascii?Q?HDU0YnNTfpQsbCwx7NUK+tuXh8KGWOD8CcposNq//hQDHZFkp3LIkPFmCJwE?=
 =?us-ascii?Q?Z6qTqsex2Lu+XZ9urhncKlSJEiI7vYPUWNVeBK2k/BhfgDH/RYlAOJ0rwATt?=
 =?us-ascii?Q?vaakJ978nKUJwiook5hQa4lelCQGBbIlP8sLnC3HNXBLZs/RtLiyWtpreedj?=
 =?us-ascii?Q?T/uNn3OvfmwD4+2N5a2AZrEIUFHEOGVxA6v+7tdWG5rdlx8xWOhOPzubESI3?=
 =?us-ascii?Q?GOOoiavUEAAsdEyieUJlGPwhiuXREI9l1ogJRRiV1lpmQiJlS8ve2MksW3L4?=
 =?us-ascii?Q?yi/G/VovHzHu6GFWuf9xnmVPBuFFRx0/W+fw9n3huflxpsfxBEp9hVvMPNud?=
 =?us-ascii?Q?hYIAdnebxOwAOlbez2Ew3V0kGOCguai+lkA5innyydx/h7LhHRi9Hs0jx/2q?=
 =?us-ascii?Q?jRBUvzNbDT5UAJadszUwlTr9c7iqFKpfagonJxVLUYaOG9uCvTV1Aa4R4D+j?=
 =?us-ascii?Q?CEqdr8BP3kS+x3jZVxE4/PS35/+NyrXrUVinQN2V80+z1RTW22sEyuGa/foN?=
 =?us-ascii?Q?eOtSNIwgpDhnwPZsxm0pqHDBN39VDdrC2OlgHWpl/iI2ZeY8nrKVjNSIehvu?=
 =?us-ascii?Q?HbHm3NG3StrTgEA6HqlI1ecUiKzSyvZ10E+ipLki6P+xMFft9Dh7uDD8aADB?=
 =?us-ascii?Q?O6fW9ASlK7ubm2AQd1oADLodtN2VJCLzLpH32DCidCGlv0YGBWY4groKAGmh?=
 =?us-ascii?Q?x/C6Kbrmz9m9QRznA/+oUiFxSrlOgog289FHJSH8tn0+Yqy5rND3Nc1V/C5p?=
 =?us-ascii?Q?fHa2gUTzhuM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FOgVqFk4Fm/HFPsA3ooQoOjjcZYGG2IJOPKYcb/zhoy9Qb+86wVv70i4DNS6?=
 =?us-ascii?Q?1aAX11Zl62YclRr7ATUpeUvml2g86GVkC+s5vuLeItoACTermahv9C5hjfAN?=
 =?us-ascii?Q?ysPtXaQkqdsSy8GhToCBLqr2o4s9f7EN9x+pbTiO0tJMYjYSxHqUC6muaCEO?=
 =?us-ascii?Q?mYv8XCzdv0q1RIrAVvLshkeeOfBBrNzhnCs7VXjvjjUs1OnSHlF9w/bSOvwb?=
 =?us-ascii?Q?mq26sEPu6Quxs6PbA8aM4zHyMTTjoLNE+SaZ7fg7smM+Wl+bh+W4BDztICbi?=
 =?us-ascii?Q?pfZZ1PjlWqVgTQVPFI9PGrw+FfMAD26rUby5gGBUpsHOZfmFzNpzAXOrmTrQ?=
 =?us-ascii?Q?r59V6NwTNN1KBZ9SFmHcFK6PiZYFLhy7MvZXGirmdLh3NI/WY88acRkmjTh1?=
 =?us-ascii?Q?UsvP5xd+mMQr1e3Of0kJvza00Styp4XQFfEQj6bCultm3gnzQnSyeIySY39A?=
 =?us-ascii?Q?EK31zdHcQ8ri1OZsiV8sNmpQ12vZsYIOi6/zwE/DGzfyTl0daLrzimP9u1SY?=
 =?us-ascii?Q?g6s2Ovhbjk97CT2o3UXs9eBqWTSupe3T27l6gy6kXCIe4RwU2yUlzSRH3qDO?=
 =?us-ascii?Q?eBhWlNMjW/iUT0XX01lzXgMwdngh7wB6DnC4PncV0VJmLHrbFjtwV5M5Lnni?=
 =?us-ascii?Q?LNcccaNQviB1c0gdX9TRcgVwgI/+Ws+qxogbcfz8oKJnE0M9hJMwWmIzvnr5?=
 =?us-ascii?Q?8vKv0DOUtHk+E9c01cdqfecBYeh3tepvuYRqU7+pat4CFOVY+E2303TUVaBT?=
 =?us-ascii?Q?cbYI7dA3ULrlsplIKJ4bwtS5Dp8aMSjcDYyv+FfkqE41KvLvksBt3EdOTxdY?=
 =?us-ascii?Q?s4ublmJa9FURMyWzpatv0be6KeqRtl0t9tfO54qErYyGYGZEuldF+gn7dx6/?=
 =?us-ascii?Q?GeXiI+GS4YWKFIFBMQO+ihIUNymopidVDSO8X2oZJJhtzsYqNwl8dawgRD4a?=
 =?us-ascii?Q?CV87DDs6mcrdbAXVijHlD0D+WsTX9GwyDkP86RyVnINC4s6UO54Pu753oao5?=
 =?us-ascii?Q?xfavRGT4wNrKBDiN6wdoyoJVSS4mLyNGzPpAq4Zmi9Fh7sQu8Owwa9V4ksiD?=
 =?us-ascii?Q?bBGgCNGzZHuUiZ/L800N+jtc92AA2Filjtd42T0obZbPA4V16C+ZXBuW9QPZ?=
 =?us-ascii?Q?koTt4ldmlG8cu/I5bfrS2Fuc6x0eZGY4k1l1aSgcAarVZX/d1YKeSpdU9aa1?=
 =?us-ascii?Q?dHOrFv2pmcEJBRyDPJMzJt6JdMsKsexKzfRSFanyW6+k+fsRm36m9uY3y4Dj?=
 =?us-ascii?Q?lLEewiHQXe8Wtscoi4GmLW6N/nUUTRWtQf7WesonwnIx7KTaJ8nWlMlrhlJP?=
 =?us-ascii?Q?HTt/2o/DWpsgpjT4zmLJzkbo9KSsgNRDJsDHr3QkAzks6F5a6zl+dd3PuGb8?=
 =?us-ascii?Q?vA2EdK3z6iQxmmpJgqQckNvY5SzlJF7QtKDGatbytK9BtM9Ii14Bwd4hvlT6?=
 =?us-ascii?Q?KHAvSuHbfD/egvHB6/eTueUsmo3Nk2pq4SOABUakI67twIWaEasF4H/kt4FL?=
 =?us-ascii?Q?WLyE9qlfICT3EsxdfSMHNptoHTu04r2exNSepcoDqBVcZiewdi78+si2axuc?=
 =?us-ascii?Q?rmYgEed2LGH3NoopZSVHWewYIPbBWwynmELuhbbhwIeSUhzJUC5B2c54VyiK?=
 =?us-ascii?Q?qWdMZj5W4q+usggjh4GdX6ENrd20nZJkDQ6jswbLzhabelnO4GOBJC55n9eI?=
 =?us-ascii?Q?CNrtsg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff85ec56-bd4a-4389-8135-08ddbf8f5186
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:54:02.6428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKhuq5GXh8A5OioZjQebwCKlrdDLMR4Hb6snfMWdkdecSEZz471044uzJEedeXKMsWxQ9hcBFKXzr+Zzymn/KAnxxcsReWx2rgrXc03UuF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8048
X-Proofpoint-ORIG-GUID: 2NmgLb-S3G4aQs6NIFV3dA2yS0v8Xm8M
X-Proofpoint-GUID: 2NmgLb-S3G4aQs6NIFV3dA2yS0v8Xm8M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3NSBTYWx0ZWRfX5uSAIqXuzQZm
 sSVv3DA2MW0zyWgZvgsKWHuUvDO0yBhBCXTRZ+cKGe3WH/3sMHsC1HdLJ1ylROJWYMXsYL1dnbU
 /N/9Wk8Lva1RtmRl9rWpDmfH/hY4bt4yB35CYEcnQMeBHBH7Sv/X1dA6yGUWNWdgf22ua6cYVj/
 4xM78VU07E8jQjTWkDSAXMDWamA25Dv6BNKqC1xvGMmMupak2o43oSZ3ZaEA5oiKDP0PM65fNGi
 yrPdOdyk8iRpmsxww1er90bKqeF4o/ymj/jgODAyzFTP1fy+XHy1nmRT7Bcg/THlpduVQxElI+y
 OospVw19hx1i5DD2PFkWZNvtlaSY1d3DPgNbLwOddzrGD6qG55RAvqpoNSiInLuYhAzvDQ42ecT
 TpZOG8E0mOD4y+k24AzH7r+otYHlSJX1T9v8zRxoMyc4/bHG1qIJfhvjYKWIfKSH49bOcvtC
X-Authority-Analysis: v=2.4 cv=fNg53Yae c=1 sm=1 tr=0 ts=686f7fac cx=c_pps
 a=I4ZpZOlEiWfCXB4Cv/CMvA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=lP01sPVOnlGqiXarDuQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

PCI is always enabled on the pc-i440fx machine so hardcode the relevant logic
in pc_init1().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 194 ++++++++++++++++++----------------------------
 1 file changed, 76 insertions(+), 118 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 70eaf5ed48..cac016df22 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -70,7 +70,7 @@
 
 #define XEN_IOAPIC_NUM_PIRQS 128ULL
 
-#ifdef CONFIG_IDE_ISA
+#ifdef CONFIG_ISAPC
 static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
 static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
 static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
@@ -117,6 +117,9 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     MemoryRegion *rom_memory = system_memory;
     ram_addr_t lowmem;
     uint64_t hole64_size = 0;
+    PCIDevice *pci_dev;
+    DeviceState *dev;
+    size_t i;
 
     /*
      * Calculate ram split, for memory below and above 4G.  It's a bit
@@ -187,38 +190,36 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         kvmclock_create(pcmc->kvmclock_create_always);
     }
 
-    if (pcmc->pci_enabled) {
-        pci_memory = g_new(MemoryRegion, 1);
-        memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
-        rom_memory = pci_memory;
-
-        phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
-        object_property_add_child(OBJECT(machine), "i440fx", phb);
-        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
-                                 OBJECT(ram_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
-                                 OBJECT(pci_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
-                                 OBJECT(system_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
-                                 OBJECT(system_io), &error_fatal);
-        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
-                                 x86ms->below_4g_mem_size, &error_fatal);
-        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
-                                 x86ms->above_4g_mem_size, &error_fatal);
-        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
-                                &error_fatal);
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
-
-        pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
-        pci_bus_map_irqs(pcms->pcibus,
-                         xen_enabled() ? xen_pci_slot_get_pirq
-                                       : pc_pci_slot_get_pirq);
-
-        hole64_size = object_property_get_uint(phb,
-                                               PCI_HOST_PROP_PCI_HOLE64_SIZE,
-                                               &error_abort);
-    }
+    pci_memory = g_new(MemoryRegion, 1);
+    memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
+    rom_memory = pci_memory;
+
+    phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
+    object_property_add_child(OBJECT(machine), "i440fx", phb);
+    object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
+                                OBJECT(ram_memory), &error_fatal);
+    object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
+                                OBJECT(pci_memory), &error_fatal);
+    object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
+                                OBJECT(system_memory), &error_fatal);
+    object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
+                                OBJECT(system_io), &error_fatal);
+    object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
+                                x86ms->below_4g_mem_size, &error_fatal);
+    object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
+                                x86ms->above_4g_mem_size, &error_fatal);
+    object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
+                            &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
+
+    pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
+    pci_bus_map_irqs(pcms->pcibus,
+                        xen_enabled() ? xen_pci_slot_get_pirq
+                                    : pc_pci_slot_get_pirq);
+
+    hole64_size = object_property_get_uint(phb,
+                                            PCI_HOST_PROP_PCI_HOLE64_SIZE,
+                                            &error_abort);
 
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
@@ -234,72 +235,51 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         }
     }
 
-    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
-
-    if (pcmc->pci_enabled) {
-        PCIDevice *pci_dev;
-        DeviceState *dev;
-        size_t i;
-
-        pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
-        object_property_set_bool(OBJECT(pci_dev), "has-usb",
-                                 machine_usb(machine), &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-acpi",
-                                 x86_machine_is_acpi_enabled(x86ms),
-                                 &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
-                                 &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
-                                 &error_abort);
-        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
-        object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
-                                 x86_machine_is_smm_enabled(x86ms),
-                                 &error_abort);
-        dev = DEVICE(pci_dev);
-        for (i = 0; i < ISA_NUM_IRQS; i++) {
-            qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
-        }
-        pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
-
-        if (xen_enabled()) {
-            pci_device_set_intx_routing_notifier(
-                        pci_dev, piix_intx_routing_notifier_xen);
-
-            /*
-             * Xen supports additional interrupt routes from the PCI devices to
-             * the IOAPIC: the four pins of each PCI device on the bus are also
-             * connected to the IOAPIC directly.
-             * These additional routes can be discovered through ACPI.
-             */
-            pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
-                         XEN_IOAPIC_NUM_PIRQS);
-        }
+    gsi_state = pc_gsi_create(&x86ms->gsi, true);
+
+    pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
+    object_property_set_bool(OBJECT(pci_dev), "has-usb",
+                                machine_usb(machine), &error_abort);
+    object_property_set_bool(OBJECT(pci_dev), "has-acpi",
+                                x86_machine_is_acpi_enabled(x86ms),
+                                &error_abort);
+    object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
+                                &error_abort);
+    object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
+                                &error_abort);
+    qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
+    object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
+                                x86_machine_is_smm_enabled(x86ms),
+                                &error_abort);
+    dev = DEVICE(pci_dev);
+    for (i = 0; i < ISA_NUM_IRQS; i++) {
+        qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
+    }
+    pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
 
-        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
-        x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
-                                                              "rtc"));
-        piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
-        dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
-        pci_ide_create_devs(PCI_DEVICE(dev));
-        pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
-        pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
-    } else {
-        uint32_t irq;
+    if (xen_enabled()) {
+        pci_device_set_intx_routing_notifier(
+                    pci_dev, piix_intx_routing_notifier_xen);
 
-        isa_bus = isa_bus_new(NULL, system_memory, system_io,
-                              &error_abort);
-        isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+        /*
+         * Xen supports additional interrupt routes from the PCI devices to
+         * the IOAPIC: the four pins of each PCI device on the bus are also
+         * connected to the IOAPIC directly.
+         * These additional routes can be discovered through ACPI.
+         */
+        pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
+                        XEN_IOAPIC_NUM_PIRQS);
+    }
 
-        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
-        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
-        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
-        irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
-                                       &error_fatal);
-        isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
+    isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
+    x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
+                                                            "rtc"));
+    piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
+    dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
+    pci_ide_create_devs(PCI_DEVICE(dev));
+    pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
+    pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
 
-        i8257_dma_init(OBJECT(machine), isa_bus, 0);
-        pcms->hpet_enabled = false;
-    }
 
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
@@ -313,7 +293,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         x86_register_ferr_irq(x86ms->gsi[13]);
     }
 
-    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
+    pc_vga_init(isa_bus, pcms->pcibus);
 
     /* init basic PC hardware */
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
@@ -321,28 +301,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
 
     pc_nic_init(pcmc, isa_bus, pcms->pcibus);
 
-#ifdef CONFIG_IDE_ISA
-    if (!pcmc->pci_enabled) {
-        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-        int i;
-
-        ide_drive_get(hd, ARRAY_SIZE(hd));
-        for (i = 0; i < MAX_IDE_BUS; i++) {
-            ISADevice *dev;
-            char busname[] = "ide.0";
-            dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
-                               ide_irq[i],
-                               hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
-            /*
-             * The ide bus name is ide.0 for the first bus and ide.1 for the
-             * second one.
-             */
-            busname[4] = '0' + i;
-            pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
-        }
-    }
-#endif
-
     if (piix4_pm) {
         smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
 
-- 
2.43.0


