Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247AFC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 19:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUVpd-00082A-7m; Wed, 25 Jun 2025 15:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpL-00080S-US
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:35 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpI-0003Uj-Vl
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:35 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PDssmc025796;
 Wed, 25 Jun 2025 12:30:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=QsoMfZATuoMJ/ARP2DHdVNTu1gZQzjF59jCorR5dI
 fA=; b=xDP0Yx3HTeURJiKzqs7vjrPx4SVhIVbeOouy7xnQM1/oFf1b0HU/961w2
 itlRNcXHabPqiuaheI/6pLXAgT17jFz+zMgaJTbrA/2gOQKn7vlUXAuYeI7ldE7G
 xKP7jYJWZsP2X/Bz71QuSMCQ46JfKYd9cNVrHryprQIUx95/KQ07sHimqEH2YX6E
 czFglvdWKCtwlucY4LaQ4ehnoNDp42FCLfUqTciYE/L5/FChsGgU9BHCGfaSfzpc
 s/yBKw2SPkgEbIjehLnK5Ip5phm1H/Z0lc88EJI1EceQHtzrUbylj9USmn8TcPx2
 wl72+3fldT/N30zkGYD7coDV2Jf1w==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2116.outbound.protection.outlook.com [40.107.102.116])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47gjdtrsa3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 12:30:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSaCeuzds2INWzdM2xV744Dt+gzhnz7yBGw20sh02Z6YTkoRxB8WWHCifA4PHC9tmqgVKwt9AIMiT2ac49USEQyj3Cn7yKADjiCcBtGqiUMB8YqSZin/9vsUgTfc26NKAT2RUq7aTP5q5qE8RKltGDX1akAXwnP28tNCbgMbnQvbr2TPr7ng0gyYjgZZtbYdmac6xCNRM3npec3BvYr52J7zhSSs/vslxKucrhOKCfl6AIktuVn2Xj1A6IdJSMEV6aNF638cMDRJySRot+jrhj3kuwPPfIqScrLONyScbrDvRy6zdaZZ3vCwdEqIBpR7zgRsi9NFG8Nx3QDp5p8pkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsoMfZATuoMJ/ARP2DHdVNTu1gZQzjF59jCorR5dIfA=;
 b=GqPN0RArikmwzb+psoE0+eE1M6VvNlU6/Egfg5hmlrXjJdMH7v6+swJVKQbHbOfjGsn9uAV1k8M8Kn82mLe9eD9G2h2kziT2RwUtxiaffaLZzlnqCa64C6pD0qIHlgXcnEJU+9wdVFEelgAAt9vZT0IxjYKx1og4eIaeWJ8BOrnjowRiH0mX2ivpz+npy1DRFmPZRXp5EbUX72l+IyZrBx5RaVU63Jz8w2GEF3iuCRPBgYXZ0kfeFd/dEMFiEjFDOzcyJp0M3Yidb161iYuFKjugnpu10PSPqleAmAHSpoy/HmOr6U/KLpvwIWyKRSr7na/nJHUe9ybLrs4O2I3MqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsoMfZATuoMJ/ARP2DHdVNTu1gZQzjF59jCorR5dIfA=;
 b=S/6lhdAJQthhfvAGR/olymCSWYOTLLLwa62v05AXIg5miFAmhPlow8gQGi5iEJB+QH+QD0+2d5gk5Yp6h3/s0C+9SS11RUx73+ZLK0tgz9JlikY1+lec5guIXeKOfLcVFdH1Z9MA0Hj94KbB98JW0HDYIBK863USoxXspWyybirVQdhmKoqMmcPdbZBv4t5dirae7x6svN0ckyQNrgRHfXyZaGmNNMRF0S2mppri9ymi705xbsuSUZy8HZTNpZ+kMgFkyoKFkRIFg4pMH9wOwEelGwsqEcWTCWcZ18wfcxE0QzuXN5t/kNGvRQzzDyjNgtctQkMqq+EdY9lCM8ZZ9Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8535.namprd02.prod.outlook.com (2603:10b6:510:dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 19:30:28 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 19:30:28 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH v5 04/19] vfio-user: implement message send infrastructure
Date: Wed, 25 Jun 2025 20:29:56 +0100
Message-ID: <20250625193012.2316242-5-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625193012.2316242-1-john.levon@nutanix.com>
References: <20250625193012.2316242-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: 63685f7d-b1eb-4017-d193-08ddb41ebd65
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i6CsnbJpJj8i4QVi1bZsKKobdk5s0PFVgTy4LTJQ37o+k67voYu3xrqBiuPE?=
 =?us-ascii?Q?jUfmoWhMiq4DVcNVA4Kqu6gSiTrOS0+6lWv0mWIOROt/PPZcq0txgeUgvV/a?=
 =?us-ascii?Q?nDeuMzONZRnkJBuQ4TcUwXe8Bz1zqOFmif0Viv4gPt3wfVKN9Fk6L607wIFK?=
 =?us-ascii?Q?Q9Na6HCUxQi33gmuOgKk/fb2YgAX1cEj4OXM++Y2rnUcnzi5pqsWRW3wz+BD?=
 =?us-ascii?Q?eGGQ8OC6723gO0NE9QIieRt5RMYVILjU4empH6pZJY84wlwO4uZOBXLv3Smn?=
 =?us-ascii?Q?RtpC0H2TpKZQzjrOsWM3fDE9zgCEADziCPdRAa5WXwiA9nnvmIdBB3vWvDSK?=
 =?us-ascii?Q?ahFbc/hGxuuFliH1vO4fW50B8Leyc0ZB+bi0t7H4VosHApniZzHR2UsX/zGT?=
 =?us-ascii?Q?BYl0lHdvPFoKnu20zBKCWRaVgwGXYmfTquKmXU3s3FmUI3JfeiOGXrJZAqD9?=
 =?us-ascii?Q?goIA7Ah31cCcd5FhfkOfdS2UP109AJDK1THRgc0FxGyne+lpTX57zrBB628N?=
 =?us-ascii?Q?Um+cmaJ5/4JA5zW72Y2D5dvKWidR5pn6Wt9TioPMUMuf87DXwuPDmTKbRIf9?=
 =?us-ascii?Q?0OP+TYRj/Q4ZG3sOljK+ryV5/vlr7FBXQ7DbVEo6gAIRUnDO/4b+h2YYhxtN?=
 =?us-ascii?Q?r25hhDfEZNY16IzQH2rO6S7rm87ZMthFT3eeM3MYIv2Nn4CuxXQg63B++OoP?=
 =?us-ascii?Q?zTjMk8XQxoE1sUPoUqUWadWBtILg8PTjwKXvpfy432JI0+fIw6M+5NJSWSYd?=
 =?us-ascii?Q?ZTKoiv/KekMjiLGGKIcIrsdUFT95GU1dttSGNCV/7ormPYAtF9bSGgNl1OgY?=
 =?us-ascii?Q?KxC3RXhJzPZL+Pr13HD/nUtlqwFOUkAmPsy7JjaFTm9itIKJMo5KgxOSbTOP?=
 =?us-ascii?Q?Tfsh8/R6Q4RjaCL6tdFo8uHOdc1eTkO+O/6rnIy/4EbQwYtliSzz0+8vBpHk?=
 =?us-ascii?Q?+xE+UAKqgUqgpTfTuiwD7U1jr5ltBYAfixKUcBTr/2U/3HPJeR/ivxIvY1as?=
 =?us-ascii?Q?HrGvjQi0TPI901uMXartkACYUlbp9eNUBi4fgFN/jJOxYBb8r5gF8dgk+0u9?=
 =?us-ascii?Q?SsURa+STa6uYnLmXZqx6DRrESBSknp0JQID+VZ29jezAGE0MXRJ1wl4Juchl?=
 =?us-ascii?Q?KAjOEMGQAugWUGKFwCBi+fyzpP31P6nAxL2b9BRLVKkA3V9ApSV/0/xNiUJa?=
 =?us-ascii?Q?LunC2B0BQCXGDkLplWo4lYcKwixhAev/5uxSAlOZ7LPWZI2ywUgamek8Fydv?=
 =?us-ascii?Q?hyiD37QUMS38rLTkyI/RETGCogbEAgvgTzk7HzQEoDeyTH1mMLeaJc89TLG1?=
 =?us-ascii?Q?UhMJ/1rQTWN9B5Pq2Lq/+kfzxVhIOZ7eL15Yro5WbHueRwrQJzEAhGT8WGe3?=
 =?us-ascii?Q?q1EDOsKJnvZiifJHNXlv1Jv98nZnhd1ySB0HRek+uq4oKI/9U9/lauXMKJlo?=
 =?us-ascii?Q?kFH/6bfn4Do=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nPhx6O4FjProwiv/H6FiAa0ANe4v6TYCrOp5b4FYL5OhmGCQwo6rr9IhIbhs?=
 =?us-ascii?Q?zUcyEAc8f+iGS0qMzPYVkzmiWjS+IRzCPhdaOEH6QUeo4z8BdhZjy/83mjQE?=
 =?us-ascii?Q?dbxERgFj6s/Axnl5soN99uyw1Yj+3tr0eyd4cmkMghJis2WAPfG1wMgas2t8?=
 =?us-ascii?Q?3//COYVRC6C7o4wsaHx67gS4e58s1SzaarbP+tpwwldZqldUC8u3jhcDaEDh?=
 =?us-ascii?Q?8SM8q3Rg37HBp12ivuRw+BfUEvuYy0OnWv38o6SIJL+HXe36krh1itPQLfkw?=
 =?us-ascii?Q?HYIo1omJVPUCYLz1Mj90Kqqkn3Byia4FYOE25BKAO44hls1P0DiXvCX7QAHQ?=
 =?us-ascii?Q?k/cae/k0St7qsaHR5TW6XboeM+ad4+JlfE6LLKKmt5fcug4dayWxFD3D5Jaz?=
 =?us-ascii?Q?HJRaT6tXS7xeYQDHV3t+ncHD2olmnxyzAe455ezCezM0uMyhhX2CGVtUNxiK?=
 =?us-ascii?Q?f4IlFgiHVmDkrzvSbgG4G3GalumZillPovgWBBMcnl1YO39D4ftiYOXWK15y?=
 =?us-ascii?Q?Kwcmwa8GgXdTkkaUCwzCaF1kAS/03+d3+pCe7KPTE4hDXFCg74e60ztvSfKd?=
 =?us-ascii?Q?ud1AGUbAZN6615gpRwZ1nDP7r+FxVe7xokxPquDbIoF0cQkivUydTCra24iN?=
 =?us-ascii?Q?FBBWSeciwUE4gTeux9Bj8Uqh0EcfoBGT1+qJCKqX+qHs8aN+GmSkKG6LMETV?=
 =?us-ascii?Q?y6/uS686QIYhcNAMnadtqkfX2KNhWdqmzI2YQ+YePQSbkvmys5LVo6f8odVu?=
 =?us-ascii?Q?HII/a2+MIVErX8vXRrTbDwA3y1aVcfTDliiD/0BEAM2mas4BHq1Y2Ym3w0VQ?=
 =?us-ascii?Q?jUj3zPcwZmRwf/RWFDVGlB+eAYX+/lhwFbhFCl9T6gjOSH9ktr9YzF97giBG?=
 =?us-ascii?Q?pV6CRob5COzYOBQfI7T08fvxiH302/RhF3Lt1ySG9AGE5MvZ0Y7RWtM25gix?=
 =?us-ascii?Q?ahH1JzmDtEU0aUo9lBOdf2aFF4ZNMsNQvDmVs5DRxCkk8NwWgfUzSncNJG2I?=
 =?us-ascii?Q?XNADDUk8GQ++zTdVgFf7DqjA3esz3n5d+Ri3lVLMq1R0b4R4jAmmG5UQp15Y?=
 =?us-ascii?Q?+NZoVYtkO0jQ18vD4luDKErcDzyHyF7L/kZjmQ/FamoCq6GDXIJI88TWo/ZH?=
 =?us-ascii?Q?/rhmata1qatABnzHwYuWH7sgQMw5ClAJyRSsXBeKWdFKOYALbWNfSLRimw2f?=
 =?us-ascii?Q?f7M6qi6dWF3M+D8S91ogeHDpkcjqIy+GTsrwS0RUa5KjV4r4pHR3FunHCFpL?=
 =?us-ascii?Q?KOqnqwJUb5E5Lox3xfV/g/XpL9Ve5ELZ4/RBKBb1I1UrXsruQewdfqjGKH52?=
 =?us-ascii?Q?wWzinfxIl5goiQbO8satYzrolifnss++IwYZIcEVTQ32EY8wJIjju6Gs+/YK?=
 =?us-ascii?Q?Ar2li55cNQHFwcV8MqRWTVNkZ4BjK5gYD37hxfZje+iZJbX/lV7MODV8ovnR?=
 =?us-ascii?Q?NvfAKIhvUL8cNqr5VWRsyGZK4mKpbfvVT21s9lg6gW4JFM5dT3QwsdDSMM2y?=
 =?us-ascii?Q?XK/6dvKMYJ4V130Kpk8hUsIsQlMG5KkDVsD38egzzd+vtPIJ2JMDKwNaOQKm?=
 =?us-ascii?Q?zcDGwNnBqBg7aEk56XsLaaF6QOI3mgCa/Ige3+dt?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63685f7d-b1eb-4017-d193-08ddb41ebd65
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 19:30:28.0251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pa9QoYn+7IC6Vrp7O0sge1QkuCJ613fqbcX12/AHdUWjzW3VjW1uW1Y7piOxBF+ddBn+sv0VB+1HbwwSmeRdYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8535
X-Proofpoint-ORIG-GUID: PcRkH1LjiW7OKkOGUF-NblZoHzRg7kSr
X-Authority-Analysis: v=2.4 cv=Fcs3xI+6 c=1 sm=1 tr=0 ts=685c4e57 cx=c_pps
 a=/2wCtPJy3NvKizEtkrRzQQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=UnscCpd6-9sbi9RN3AUA:9
X-Proofpoint-GUID: PcRkH1LjiW7OKkOGUF-NblZoHzRg7kSr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0NyBTYWx0ZWRfX4TRZhh2fdu9+
 1VwqJ8N1MnFDwI58zkX8H1MySSyXHRTvI5emzfSYKOv41dmaApxGiN1NTFMaHGIRENJ4dLNBqaY
 pWAsvMCGZurypccrx7YuElC3rlGZXB+4AaCNF83/JAtGSYfSv+cmrlSy+JIF6UNKkrZn/DIERIO
 oyLsLYHtz0mDWlrIQLZR3YnlskafgyPiSCtuSZWyKMGzZVLu29ik7eSs3NgisUTggixmGQ1Idue
 ej8aMkN5G05rIeG3bV1zf7U3PaE1TpIJ9VJ3/p6L71CPDv4ot0MZo8bXYyd6YJLGSDb02J940nZ
 M/jrkYqGX6nyKsnXhR2i4zu9se/PyWKqKM+Mqm17hP7KZvbX5JXAgSuAN0aC49AoMqhX5wb6Cuc
 0UmTeEaktBRGW9+rxO2x73NsR9hw9mggb3tT7RnGc2WoR5XegNt1JxZNyVhUaOwsKcf5GNo3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

Add plumbing for sending vfio-user messages on the control socket.
Add initial version negotation on connection.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h   |  62 +++++
 hw/vfio-user/proxy.h      |   9 +
 hw/vfio-user/pci.c        |  20 +-
 hw/vfio-user/proxy.c      | 515 ++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events |   2 +
 5 files changed, 606 insertions(+), 2 deletions(-)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 4ddfb5f222..2d52d0fb10 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -50,4 +50,66 @@ enum vfio_user_command {
 #define VFIO_USER_NO_REPLY      0x10
 #define VFIO_USER_ERROR         0x20
 
+
+/*
+ * VFIO_USER_VERSION
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint16_t major;
+    uint16_t minor;
+    char capabilities[];
+} VFIOUserVersion;
+
+#define VFIO_USER_MAJOR_VER     0
+#define VFIO_USER_MINOR_VER     0
+
+#define VFIO_USER_CAP           "capabilities"
+
+/* "capabilities" members */
+#define VFIO_USER_CAP_MAX_FDS   "max_msg_fds"
+#define VFIO_USER_CAP_MAX_XFER  "max_data_xfer_size"
+#define VFIO_USER_CAP_PGSIZES   "pgsizes"
+#define VFIO_USER_CAP_MAP_MAX   "max_dma_maps"
+#define VFIO_USER_CAP_MIGR      "migration"
+
+/* "migration" members */
+#define VFIO_USER_CAP_PGSIZE            "pgsize"
+#define VFIO_USER_CAP_MAX_BITMAP        "max_bitmap_size"
+
+/*
+ * Max FDs mainly comes into play when a device supports multiple interrupts
+ * where each ones uses an eventfd to inject it into the guest.
+ * It is clamped by the the number of FDs the qio channel supports in a
+ * single message.
+ */
+#define VFIO_USER_DEF_MAX_FDS   8
+#define VFIO_USER_MAX_MAX_FDS   16
+
+/*
+ * Max transfer limits the amount of data in region and DMA messages.
+ * Region R/W will be very small (limited by how much a single instruction
+ * can process) so just use a reasonable limit here.
+ */
+#define VFIO_USER_DEF_MAX_XFER  (1024 * 1024)
+#define VFIO_USER_MAX_MAX_XFER  (64 * 1024 * 1024)
+
+/*
+ * Default pagesizes supported is 4k.
+ */
+#define VFIO_USER_DEF_PGSIZE    4096
+
+/*
+ * Default max number of DMA mappings is stolen from the
+ * linux kernel "dma_entry_limit"
+ */
+#define VFIO_USER_DEF_MAP_MAX   65535
+
+/*
+ * Default max bitmap size is also take from the linux kernel,
+ * where usage of signed ints limits the VA range to 2^31 bytes.
+ * Dividing that by the number of bits per byte yields 256MB
+ */
+#define VFIO_USER_DEF_MAX_BITMAP (256 * 1024 * 1024)
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index ff553cad9d..5bc890a0f5 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -37,6 +37,7 @@ typedef struct VFIOUserMsg {
     uint32_t id;
     QemuCond cv;
     bool complete;
+    bool pending;
     enum msg_type type;
 } VFIOUserMsg;
 
@@ -56,6 +57,12 @@ typedef struct VFIOUserProxy {
     struct QIOChannel *ioc;
     void (*request)(void *opaque, VFIOUserMsg *msg);
     void *req_arg;
+    uint64_t max_xfer_size;
+    uint64_t max_send_fds;
+    uint64_t max_dma;
+    uint64_t dma_pgsizes;
+    uint64_t max_bitmap;
+    uint64_t migr_pgsize;
     int flags;
     QemuCond close_cv;
     AioContext *ctx;
@@ -78,6 +85,7 @@ typedef struct VFIOUserProxy {
 
 /* VFIOProxy flags */
 #define VFIO_PROXY_CLIENT        0x1
+#define VFIO_PROXY_FORCE_QUEUED  0x4
 
 typedef struct VFIODevice VFIODevice;
 
@@ -86,5 +94,6 @@ void vfio_user_disconnect(VFIOUserProxy *proxy);
 void vfio_user_set_handler(VFIODevice *vbasedev,
                            void (*handler)(void *opaque, VFIOUserMsg *msg),
                            void *reqarg);
+bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index bad2829f5c..61f525cf4a 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -20,6 +20,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
 struct VFIOUserPCIDevice {
     VFIOPCIDevice device;
     SocketAddress *socket;
+    bool send_queued;   /* all sends are queued */
 };
 
 /*
@@ -92,6 +93,16 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     vbasedev->proxy = proxy;
     vfio_user_set_handler(vbasedev, vfio_user_pci_process_req, vdev);
 
+    vbasedev->name = g_strdup_printf("vfio-user:%s", sock_name);
+
+    if (udev->send_queued) {
+        proxy->flags |= VFIO_PROXY_FORCE_QUEUED;
+    }
+
+    if (!vfio_user_validate_version(proxy, errp)) {
+        goto error;
+    }
+
     /*
      * vfio-user devices are effectively mdevs (don't use a host iommu).
      */
@@ -101,9 +112,13 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     if (!vfio_device_attach_by_iommu_type(TYPE_VFIO_IOMMU_USER,
                                           vbasedev->name, vbasedev,
                                           as, errp)) {
-        error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
-        return;
+        goto error;
     }
+
+    return;
+
+error:
+    error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
 }
 
 static void vfio_user_instance_init(Object *obj)
@@ -153,6 +168,7 @@ static const Property vfio_user_pci_dev_properties[] = {
                        sub_vendor_id, PCI_ANY_ID),
     DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
                        sub_device_id, PCI_ANY_ID),
+    DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
 };
 
 static void vfio_user_pci_set_socket(Object *obj, Visitor *v, const char *name,
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 349ea2b27c..874142e9e5 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -13,11 +13,15 @@
 #include "hw/vfio-user/proxy.h"
 #include "hw/vfio-user/trace.h"
 #include "qapi/error.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
+#include "qobject/qnum.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
 #include "qemu/main-loop.h"
 #include "system/iothread.h"
 
+static int wait_time = 5000;   /* wait up to 5 sec for busy servers */
 static IOThread *vfio_user_iothread;
 
 static void vfio_user_shutdown(VFIOUserProxy *proxy);
@@ -27,9 +31,12 @@ static VFIOUserFDs *vfio_user_getfds(int numfds);
 static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
 static void vfio_user_recv(void *opaque);
+static void vfio_user_send(void *opaque);
 static void vfio_user_cb(void *opaque);
 
 static void vfio_user_request(void *opaque);
+static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
+                                  uint32_t size, uint32_t flags);
 
 static inline void vfio_user_set_error(VFIOUserHdr *hdr, uint32_t err)
 {
@@ -48,6 +55,41 @@ static void vfio_user_shutdown(VFIOUserProxy *proxy)
                                    proxy->ctx, NULL, NULL);
 }
 
+/*
+ * Same return values as qio_channel_writev_full():
+ *
+ * QIO_CHANNEL_ERR_BLOCK: *errp not set
+ * -1: *errp will be populated
+ * otherwise: bytes written
+ */
+static ssize_t vfio_user_send_qio(VFIOUserProxy *proxy, VFIOUserMsg *msg,
+                                  Error **errp)
+{
+    VFIOUserFDs *fds =  msg->fds;
+    struct iovec iov = {
+        .iov_base = msg->hdr,
+        .iov_len = msg->hdr->size,
+    };
+    size_t numfds = 0;
+    int *fdp = NULL;
+    ssize_t ret;
+
+    if (fds != NULL && fds->send_fds != 0) {
+        numfds = fds->send_fds;
+        fdp = fds->fds;
+    }
+
+    ret = qio_channel_writev_full(proxy->ioc, &iov, 1, fdp, numfds, 0, errp);
+
+    if (ret == -1) {
+        vfio_user_set_error(msg->hdr, EIO);
+        vfio_user_shutdown(proxy);
+    }
+    trace_vfio_user_send_write(msg->hdr->id, ret);
+
+    return ret;
+}
+
 static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                                      VFIOUserFDs *fds)
 {
@@ -88,6 +130,7 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     msg->hdr = NULL;
     msg->fds = NULL;
     msg->complete = false;
+    msg->pending = false;
     QTAILQ_INSERT_HEAD(&proxy->free, msg, next);
 }
 
@@ -385,6 +428,62 @@ static void vfio_user_recv(void *opaque)
     }
 }
 
+/*
+ * Send a single message, same return semantics as vfio_user_send_qio().
+ *
+ * Sent async messages are freed, others are moved to pending queue.
+ */
+static ssize_t vfio_user_send_one(VFIOUserProxy *proxy, Error **errp)
+{
+    VFIOUserMsg *msg;
+    ssize_t ret;
+
+    msg = QTAILQ_FIRST(&proxy->outgoing);
+    ret = vfio_user_send_qio(proxy, msg, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    QTAILQ_REMOVE(&proxy->outgoing, msg, next);
+    if (msg->type == VFIO_MSG_ASYNC) {
+        vfio_user_recycle(proxy, msg);
+    } else {
+        QTAILQ_INSERT_TAIL(&proxy->pending, msg, next);
+        msg->pending = true;
+    }
+
+    return ret;
+}
+
+/*
+ * Send messages from outgoing queue when the socket buffer has space.
+ * If we deplete 'outgoing', remove ourselves from the poll list.
+ */
+static void vfio_user_send(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    if (proxy->state == VFIO_PROXY_CONNECTED) {
+        while (!QTAILQ_EMPTY(&proxy->outgoing)) {
+            Error *local_err = NULL;
+            int ret;
+
+            ret = vfio_user_send_one(proxy, &local_err);
+
+            if (ret == QIO_CHANNEL_ERR_BLOCK) {
+                return;
+            } else if (ret == -1) {
+                error_report_err(local_err);
+                return;
+            }
+        }
+        qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
+                                       vfio_user_recv, NULL, NULL, proxy);
+    }
+}
+
 static void vfio_user_cb(void *opaque)
 {
     VFIOUserProxy *proxy = opaque;
@@ -446,6 +545,128 @@ static void vfio_user_request(void *opaque)
     }
 }
 
+/*
+ * Messages are queued onto the proxy's outgoing list.
+ *
+ * It handles 3 types of messages:
+ *
+ * async messages - replies and posted writes
+ *
+ * There will be no reply from the server, so message
+ * buffers are freed after they're sent.
+ *
+ * nowait messages - map/unmap during address space transactions
+ *
+ * These are also sent async, but a reply is expected so that
+ * vfio_wait_reqs() can wait for the youngest nowait request.
+ * They transition from the outgoing list to the pending list
+ * when sent, and are freed when the reply is received.
+ *
+ * wait messages - all other requests
+ *
+ * The reply to these messages is waited for by their caller.
+ * They also transition from outgoing to pending when sent, but
+ * the message buffer is returned to the caller with the reply
+ * contents.  The caller is responsible for freeing these messages.
+ *
+ * As an optimization, if the outgoing list and the socket send
+ * buffer are empty, the message is sent inline instead of being
+ * added to the outgoing list.  The rest of the transitions are
+ * unchanged.
+ */
+static bool vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg,
+                                  Error **errp)
+{
+    int ret;
+
+    /*
+     * Unsent outgoing msgs - add to tail
+     */
+    if (!QTAILQ_EMPTY(&proxy->outgoing)) {
+        QTAILQ_INSERT_TAIL(&proxy->outgoing, msg, next);
+        return true;
+    }
+
+    /*
+     * Try inline - if blocked, queue it and kick send poller
+     */
+    if (proxy->flags & VFIO_PROXY_FORCE_QUEUED) {
+        ret = QIO_CHANNEL_ERR_BLOCK;
+    } else {
+        ret = vfio_user_send_qio(proxy, msg, errp);
+    }
+
+    if (ret == QIO_CHANNEL_ERR_BLOCK) {
+        QTAILQ_INSERT_HEAD(&proxy->outgoing, msg, next);
+        qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
+                                       vfio_user_recv, proxy->ctx,
+                                       vfio_user_send, proxy);
+        return true;
+    }
+    if (ret == -1) {
+        return false;
+    }
+
+    /*
+     * Sent - free async, add others to pending
+     */
+    if (msg->type == VFIO_MSG_ASYNC) {
+        vfio_user_recycle(proxy, msg);
+    } else {
+        QTAILQ_INSERT_TAIL(&proxy->pending, msg, next);
+        msg->pending = true;
+    }
+
+    return true;
+}
+
+/*
+ * Returns false if we did not successfully receive a reply message, in which
+ * case @errp will be populated.
+ *
+ * In either case, the caller must free @hdr and @fds if needed.
+ */
+static bool vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                VFIOUserFDs *fds, int rsize, Error **errp)
+{
+    VFIOUserMsg *msg;
+    bool ok = false;
+
+    if (hdr->flags & VFIO_USER_NO_REPLY) {
+        error_setg_errno(errp, EINVAL, "%s on NO_REPLY message", __func__);
+        return false;
+    }
+
+    qemu_mutex_lock(&proxy->lock);
+
+    msg = vfio_user_getmsg(proxy, hdr, fds);
+    msg->id = hdr->id;
+    msg->rsize = rsize ? rsize : hdr->size;
+    msg->type = VFIO_MSG_WAIT;
+
+    ok = vfio_user_send_queued(proxy, msg, errp);
+
+    if (ok) {
+        while (!msg->complete) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+                VFIOUserMsgQ *list;
+
+                list = msg->pending ? &proxy->pending : &proxy->outgoing;
+                QTAILQ_REMOVE(list, msg, next);
+                error_setg_errno(errp, ETIMEDOUT,
+                                 "timed out waiting for reply");
+                ok = false;
+                break;
+            }
+        }
+    }
+
+    vfio_user_recycle(proxy, msg);
+
+    qemu_mutex_unlock(&proxy->lock);
+
+    return ok;
+}
 
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
@@ -474,6 +695,15 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     proxy = g_malloc0(sizeof(VFIOUserProxy));
     proxy->sockname = g_strdup_printf("unix:%s", sockname);
     proxy->ioc = ioc;
+
+    /* init defaults */
+    proxy->max_xfer_size = VFIO_USER_DEF_MAX_XFER;
+    proxy->max_send_fds = VFIO_USER_DEF_MAX_FDS;
+    proxy->max_dma = VFIO_USER_DEF_MAP_MAX;
+    proxy->dma_pgsizes = VFIO_USER_DEF_PGSIZE;
+    proxy->max_bitmap = VFIO_USER_DEF_MAX_BITMAP;
+    proxy->migr_pgsize = VFIO_USER_DEF_PGSIZE;
+
     proxy->flags = VFIO_PROXY_CLIENT;
     proxy->state = VFIO_PROXY_CONNECTED;
 
@@ -571,3 +801,288 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     g_free(proxy->sockname);
     g_free(proxy);
 }
+
+static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
+                                  uint32_t size, uint32_t flags)
+{
+    static uint16_t next_id;
+
+    hdr->id = qatomic_fetch_inc(&next_id);
+    hdr->command = cmd;
+    hdr->size = size;
+    hdr->flags = (flags & ~VFIO_USER_TYPE) | VFIO_USER_REQUEST;
+    hdr->error_reply = 0;
+}
+
+struct cap_entry {
+    const char *name;
+    bool (*check)(VFIOUserProxy *proxy, QObject *qobj, Error **errp);
+};
+
+static bool caps_parse(VFIOUserProxy *proxy, QDict *qdict,
+                       struct cap_entry caps[], Error **errp)
+{
+    QObject *qobj;
+    struct cap_entry *p;
+
+    for (p = caps; p->name != NULL; p++) {
+        qobj = qdict_get(qdict, p->name);
+        if (qobj != NULL) {
+            if (!p->check(proxy, qobj, errp)) {
+                return false;
+            }
+            qdict_del(qdict, p->name);
+        }
+    }
+
+    /* warning, for now */
+    if (qdict_size(qdict) != 0) {
+        warn_report("spurious capabilities");
+    }
+    return true;
+}
+
+static bool check_migr_pgsize(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t pgsize;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &pgsize)) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_PGSIZE);
+        return false;
+    }
+
+    /* must be larger than default */
+    if (pgsize & (VFIO_USER_DEF_PGSIZE - 1)) {
+        error_setg(errp, "pgsize 0x%"PRIx64" too small", pgsize);
+        return false;
+    }
+
+    proxy->migr_pgsize = pgsize;
+    return true;
+}
+
+static bool check_bitmap(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t bitmap_size;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &bitmap_size)) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_BITMAP);
+        return false;
+    }
+
+    /* can only lower it */
+    if (bitmap_size > VFIO_USER_DEF_MAX_BITMAP) {
+        error_setg(errp, "%s too large", VFIO_USER_CAP_MAX_BITMAP);
+        return false;
+    }
+
+    proxy->max_bitmap = bitmap_size;
+    return true;
+}
+
+static struct cap_entry caps_migr[] = {
+    { VFIO_USER_CAP_PGSIZE, check_migr_pgsize },
+    { VFIO_USER_CAP_MAX_BITMAP, check_bitmap },
+    { NULL }
+};
+
+static bool check_max_fds(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t max_send_fds;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &max_send_fds) ||
+        max_send_fds > VFIO_USER_MAX_MAX_FDS) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_FDS);
+        return false;
+    }
+    proxy->max_send_fds = max_send_fds;
+    return true;
+}
+
+static bool check_max_xfer(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t max_xfer_size;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &max_xfer_size) ||
+        max_xfer_size > VFIO_USER_MAX_MAX_XFER) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_XFER);
+        return false;
+    }
+    proxy->max_xfer_size = max_xfer_size;
+    return true;
+}
+
+static bool check_pgsizes(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t pgsizes;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &pgsizes)) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_PGSIZES);
+        return false;
+    }
+
+    /* must be larger than default */
+    if (pgsizes & (VFIO_USER_DEF_PGSIZE - 1)) {
+        error_setg(errp, "pgsize 0x%"PRIx64" too small", pgsizes);
+        return false;
+    }
+
+    proxy->dma_pgsizes = pgsizes;
+    return true;
+}
+
+static bool check_max_dma(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t max_dma;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &max_dma)) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAP_MAX);
+        return false;
+    }
+
+    /* can only lower it */
+    if (max_dma > VFIO_USER_DEF_MAP_MAX) {
+        error_setg(errp, "%s too large", VFIO_USER_CAP_MAP_MAX);
+        return false;
+    }
+
+    proxy->max_dma = max_dma;
+    return true;
+}
+
+static bool check_migr(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QDict *qdict = qobject_to(QDict, qobj);
+
+    if (qdict == NULL) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_FDS);
+        return true;
+    }
+    return caps_parse(proxy, qdict, caps_migr, errp);
+}
+
+static struct cap_entry caps_cap[] = {
+    { VFIO_USER_CAP_MAX_FDS, check_max_fds },
+    { VFIO_USER_CAP_MAX_XFER, check_max_xfer },
+    { VFIO_USER_CAP_PGSIZES, check_pgsizes },
+    { VFIO_USER_CAP_MAP_MAX, check_max_dma },
+    { VFIO_USER_CAP_MIGR, check_migr },
+    { NULL }
+};
+
+static bool check_cap(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+   QDict *qdict = qobject_to(QDict, qobj);
+
+    if (qdict == NULL) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP);
+        return false;
+    }
+    return caps_parse(proxy, qdict, caps_cap, errp);
+}
+
+static struct cap_entry ver_0_0[] = {
+    { VFIO_USER_CAP, check_cap },
+    { NULL }
+};
+
+static bool caps_check(VFIOUserProxy *proxy, int minor, const char *caps,
+                       Error **errp)
+{
+    QObject *qobj;
+    QDict *qdict;
+    bool ret;
+
+    qobj = qobject_from_json(caps, NULL);
+    if (qobj == NULL) {
+        error_setg(errp, "malformed capabilities %s", caps);
+        return false;
+    }
+    qdict = qobject_to(QDict, qobj);
+    if (qdict == NULL) {
+        error_setg(errp, "capabilities %s not an object", caps);
+        qobject_unref(qobj);
+        return false;
+    }
+    ret = caps_parse(proxy, qdict, ver_0_0, errp);
+
+    qobject_unref(qobj);
+    return ret;
+}
+
+static GString *caps_json(void)
+{
+    QDict *dict = qdict_new();
+    QDict *capdict = qdict_new();
+    QDict *migdict = qdict_new();
+    GString *str;
+
+    qdict_put_int(migdict, VFIO_USER_CAP_PGSIZE, VFIO_USER_DEF_PGSIZE);
+    qdict_put_int(migdict, VFIO_USER_CAP_MAX_BITMAP, VFIO_USER_DEF_MAX_BITMAP);
+    qdict_put_obj(capdict, VFIO_USER_CAP_MIGR, QOBJECT(migdict));
+
+    qdict_put_int(capdict, VFIO_USER_CAP_MAX_FDS, VFIO_USER_MAX_MAX_FDS);
+    qdict_put_int(capdict, VFIO_USER_CAP_MAX_XFER, VFIO_USER_DEF_MAX_XFER);
+    qdict_put_int(capdict, VFIO_USER_CAP_PGSIZES, VFIO_USER_DEF_PGSIZE);
+    qdict_put_int(capdict, VFIO_USER_CAP_MAP_MAX, VFIO_USER_DEF_MAP_MAX);
+
+    qdict_put_obj(dict, VFIO_USER_CAP, QOBJECT(capdict));
+
+    str = qobject_to_json(QOBJECT(dict));
+    qobject_unref(dict);
+    return str;
+}
+
+bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp)
+{
+    g_autofree VFIOUserVersion *msgp = NULL;
+    GString *caps;
+    char *reply;
+    int size, caplen;
+
+    caps = caps_json();
+    caplen = caps->len + 1;
+    size = sizeof(*msgp) + caplen;
+    msgp = g_malloc0(size);
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_VERSION, size, 0);
+    msgp->major = VFIO_USER_MAJOR_VER;
+    msgp->minor = VFIO_USER_MINOR_VER;
+    memcpy(&msgp->capabilities, caps->str, caplen);
+    g_string_free(caps, true);
+    trace_vfio_user_version(msgp->major, msgp->minor, msgp->capabilities);
+
+    if (!vfio_user_send_wait(proxy, &msgp->hdr, NULL, 0, errp)) {
+        return false;
+    }
+
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        error_setg_errno(errp, msgp->hdr.error_reply, "version reply");
+        return false;
+    }
+
+    if (msgp->major != VFIO_USER_MAJOR_VER ||
+        msgp->minor > VFIO_USER_MINOR_VER) {
+        error_setg(errp, "incompatible server version");
+        return false;
+    }
+
+    reply = msgp->capabilities;
+    if (reply[msgp->hdr.size - sizeof(*msgp) - 1] != '\0') {
+        error_setg(errp, "corrupt version reply");
+        return false;
+    }
+
+    if (!caps_check(proxy, msgp->minor, reply, errp)) {
+        return false;
+    }
+
+    trace_vfio_user_version(msgp->major, msgp->minor, msgp->capabilities);
+    return true;
+}
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index ddeb9f4b2f..a965c7b1f2 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -6,3 +6,5 @@
 vfio_user_recv_hdr(const char *name, uint16_t id, uint16_t cmd, uint32_t size, uint32_t flags) " (%s) id 0x%x cmd 0x%x size 0x%x flags 0x%x"
 vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
 vfio_user_recv_request(uint16_t cmd) " command 0x%x"
+vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
+vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
-- 
2.43.0


