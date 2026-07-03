Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9220DC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfeMq-0002Ny-Ao; Fri, 03 Jul 2026 09:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeMn-0002MF-LD; Fri, 03 Jul 2026 09:55:41 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeMl-0006Tk-Ju; Fri, 03 Jul 2026 09:55:41 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6636s8pI2116633; Fri, 3 Jul 2026 06:55:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=iJShgEgCyiUOJ
 oJzESgE9LFwEvVluiEosLvW/cYK32U=; b=m5dTPXcklqvVcJ+xuXJrlN/fC89MT
 lo/KdkMWY2HoQ9wyT3/gxfhJVFOPI400p0FndT8pv4Qha6d9zg/57w8YBU39cLHx
 RbmqYcDbc70hcHrd11F8BK7JMJrGccOPCTh4rQVTg2MqGzXptSpdMSB5YHXya1Ie
 mrnx2GHzajNiEmdXF1w/rSvbwr5fJjpLPIzcNKWt814kVd94sJ8H9amkMjgMhmmR
 F0+m8SVBcOyRQNdjE7HF/MK5pxLcG7JgSy+/nry4RS11kuGozlRRycPnr31MSENX
 yslY38WwdiWEf/2BlVLfVL4J+MffOUutrOFz0Mfrozyv7+ZDq7QCcL9LA==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020081.outbound.protection.outlook.com
 [40.93.198.81])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4f687kgs7g-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 06:55:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZraqFYNrWp/nw9fFvW3BzFETnQyH4OHhuQu/amEIdGgc0xQ+S5EaUj9Vl2J8dZVFwttPZKTILFhZwZaS0ELz49OAjFCKm/PswNiSoFSTWsaOIN482mNWg9nE+rivGWhW25+JfnRRV9hVqvNv5zjhLJ4dmaDqU5IhYHkVuHX9iB8Zs/Tr67xHCTihU4Op7VnawrTna0WrVn48J+BzlOmLDfnUVFPaaI23fPfxTlESScVn5JO9tJK2r2ZtLSNJ9pmQtgPWqjI4BOtjO9z8HsD+E5pGP2QPjUnEpxpkQ8HYqJ9wD+opl1o4Al/IaFWkTJsm9TZHidIwM4kLqrSAByVejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJShgEgCyiUOJoJzESgE9LFwEvVluiEosLvW/cYK32U=;
 b=r9Rqf3Jlzcf9RVYEx5SkZIWBJRMTNKeQKxeHFn/QMf2b+taZKAtLpF2VBwjQZhTLXij2LX0/YbHIdD+ZJRxF8UucggVTms1DPHyvwxIkWjU18AgXv9HqOj755uaoNnk8nEXUCvRhs98S/+KhtB7GcFcNLAe0HY6t3n8+tHmG1OOD7ORO+jq+52Kjk0vajsuYApKNaebzPovqiBIeRKyLhZ07ypHixzmYngEZkRanep6jH00LlO8FQ9GV1/a9TPvB+hm3tM3mCAxJcltXdgxsojYX2pHK8eYkpkELA/V1GbCBTR1k+IRF3DepDsaH7UI9o2hk638Kf1KQ6TtW7wzAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJShgEgCyiUOJoJzESgE9LFwEvVluiEosLvW/cYK32U=;
 b=czSZttRrLjltUwtEoj/OjCIQ0DVE4tj+nvVYvRzZ0yVhh9WcGyO9z4p020Nvgvj+qjahE3Z6R/3fzrEbVLcPzHxk9o6UbL9AhFrwNOueUgPx/htc/KNeHVDFXN3nZy/63U/LqpFkNuUIP5zugiApneeHwFLw13mXIybxsh7alYGY1rbNRsn68ziLQPnzN/atyfR+WcpX6dhOleMXJC06Kw0wxD0Dtr9t+ij7ViH0bb+Yy1G9T5weHnWRtW/E0RR34scOi4yvGK5+FlntojOOt3UrHj9J1sfzz2zwLIRVif6JdOcqoRxx1vuAti6tsdMow8BhQn/409RS23VyRAh0sQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSWPR02MB11394.namprd02.prod.outlook.com (2603:10b6:8:353::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 13:55:16 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 13:55:16 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v2 00/12] hw/acpi: convert object props to class props
Date: Fri,  3 Jul 2026 14:53:02 +0100
Message-ID: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0001.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2d3::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSWPR02MB11394:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a043947-736c-44d4-5f7d-08ded90ab60a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|6133799003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: ygjTPAgPSBEDzgNdFrzzMWgMZXAkyxGprQQE4bg20m+t8s2JbiXlyCquJ2Ki/YoBCT4Re7coQKvoclyzV694ur3i2Jn5n9jN7w6k2bJH36SSAt4Wwgi4p9o0Qazq5dg++vmBzeY2dvsfhfEyc9JZyrM1egbCl13Udt3DHi7aEu+7E1v3VgomJnjtI1t9wvly1JqutVjcApoWoxtxLUtkdq06UOcB+FYnSwxHqPmk8VfYvV+PvE/RxCwuhSon0fVItN7lHWGitUO8KwkM1v7SYp4+vs6shnTO9uSyWQY+SyW1aytjSEpnlpY8pLUidAj0GqVIptapJFd17GPK1Iyehff0cYHdjceXMg5YHVs5PeSjSHEZ6+8XRsKX5ZvOSCQ6oJ3fXMWxDPCMof7cYcCV9Un6PqeoNtIV3vawajg3M7vPXWyxIVrZa6eidO14l4lxCkuzaFcA4ROOKqW2gPu8BohepLVJ4Al/US88FTHo3NGDOZgpqRHcL8Q60i4LqSeK6z+69mJy9zTyEaQ3s4mSvV5E1tI86RqVEX3zmN0X4InWACx3w3xwGps1gPsRJ/KmxudJ/N7ghOEHZttvVQPzeCAJdQtfdc4rtAp48cVz6DJgMRG43jle4ZUjg6CTNb0nIQLye/j97xFUK1gzL/ojAmytgtIkpdRUe91AtT3ZsWbTcWyW2LdWW10XBncCc3eeSnmz2I9aI8GwLoBmWvcAsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(6133799003)(18002099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nk8YqBqqtkmlmixrJDjTCIEBzhC9546Dg/ZmM+deAn0+AuwuFyJ1XHXAv6sG?=
 =?us-ascii?Q?niwpgKyjNiD6Bd2z7G9YnMm9Gs/EoGSbDQ3vFdwER7McEO/oOR8PXg77oJ5z?=
 =?us-ascii?Q?VdkQXY92PkGaY9w2GZ3rR3bsQ/fd44UGlk6zDQ1bjzlP57rQ9bfZbmGB5v4/?=
 =?us-ascii?Q?8cZ0lwd1Uk8DwbruVP2JowRIx+unku6JFrk6r1FgiWVIQP9flFpX2l8en7hQ?=
 =?us-ascii?Q?Lk98xjaGOeEJ/0ULQpE4vwcwsHVw9EK1N1LnxybCZQDKprBQ3S3LFbp7acpN?=
 =?us-ascii?Q?0RCHtgq4Ox1deah3JQYw7egZnN+lRXrT9MkNphU+A5eUn4fTu+RRi5sEQ3yg?=
 =?us-ascii?Q?FMXyAwR1056yDzXCcI/psk1ifLHin6JiKU45RE7xV+1/z55CVQwLCahmcKSI?=
 =?us-ascii?Q?yBrCz/af3fzYHF8b/8kWgGQamnV9L31Hj9L7HjOBm0xuH8qa4p8X6xn0BJYT?=
 =?us-ascii?Q?oarCltzHWcBxHwZ12nqS1qkRc1iF7vbxiuE6Bgan0b0mqwO9pn1ckP78KXJj?=
 =?us-ascii?Q?rJPZkS5AlSwWpwPKSION6tyJINO/0pWg8v6yN42ho2P+ycA/20LHfqNcmjKT?=
 =?us-ascii?Q?YkxlEsDDbm5xaTsm4p3LwK3vZdCUh9mNLpkaDKYdaGgxfzaXJJlSaKcM+/l6?=
 =?us-ascii?Q?gpIX5mcIPCfPOGclQKGAojbaDWE/nfT7Jq4kZGzrLU0DTqmVI5ZyffEsEYP9?=
 =?us-ascii?Q?gPc2KCDlAw4qaD/N0tsg4bSbIKNG9smK8o64tcVa3C9xtsnieU+OZcQKhVzK?=
 =?us-ascii?Q?R3/Y4X6QUGeyiVp0koE4OGMxq9Vjh6qaRwRWJ2O6a4puv6jg+UPPHpUOgM+8?=
 =?us-ascii?Q?HVo9KpOmx/xd5GT0SjP4UtdAMKDvXxL844FsDlxAEa8m/aLgardfVsmANfrT?=
 =?us-ascii?Q?ydHH8bsZArix2rK3eEAuXYVNaHVvOYKcXW5Si9VynoD50smdo/Rt1DMK7NVv?=
 =?us-ascii?Q?g1PWcQcE9BQBaCYgpLM8rHp1lyisZ8+LTuuJ0VEAQYplOAWk/tu9UpYAxyKG?=
 =?us-ascii?Q?fUatE+Yl7blwl8k8hkne4crW1kjv32bcAhHYU14fQ5MXcHi9Z29107NwkxCm?=
 =?us-ascii?Q?2yFU1wixZbII4TXlYrw3KtQe0ERqHKZqo8zJqla2fmHqa2E2pqtUe9d5fShE?=
 =?us-ascii?Q?NCoXApFLqyERu4HwwS1hM5vRSYkaGaaf74dF7nnYVmnvrnVGe3VtJs9Ihu5z?=
 =?us-ascii?Q?Xjatu+R31GwdIKtuZZj9tbapWDImsGXexcHUZRKHxPU1+pyy6WHMzwsaX96m?=
 =?us-ascii?Q?7ASiXAbjLN6AWKwKOO4CjjrfUiqDUUCHDf32m+vwctPAWrTfWuhFwg9tF0um?=
 =?us-ascii?Q?xdKO9/yAAFPJGL2qBGysdOy/08RiFZfTAA4MD413fAubL36dyaPzBmCpnVV5?=
 =?us-ascii?Q?a41dOB+OuK2ZqedjlIvTWfeco7Zkgva+1NF06XPrnnHXtGHX7azOrG4OjwxX?=
 =?us-ascii?Q?nN4r1OgTLlBpJYFWKbi4FUldnKnNGep3mpnGALsSXWlRQEbKb7FiwfarUxt6?=
 =?us-ascii?Q?28jsl1ZkJCvNHw3O4YT0ZpHWDxXCEldfW2S5H6dW+w7FylfRGbCSVVw9Xkc7?=
 =?us-ascii?Q?o9kYEFJmm3PF4Zv0vIkm6pZJvUKseBmd0bstvHwtnhe03ifithj66fL36P1S?=
 =?us-ascii?Q?rltJ3JyTscq953ABqTjE4mAzd765lq9UhUEFI3eTPbz/Dp7NkWy/0vIMT/FZ?=
 =?us-ascii?Q?C74k/wNSqbnK59oXlgYcVBb1gqKraITkmCDG75KrrwnYRSVGa7oitTZqwThF?=
 =?us-ascii?Q?/tVaZ0vPZ4y7VSiNABIscUxSGC+68hc=3D?=
X-Exchange-RoutingPolicyChecked: hXzqUciilOn1rFRPfu+bFE9vdOt73hjIgk5GHk8r/aGGr9/BL+3VfMNBKvWVCPAXYtCov1/9oc0O4fW3PRacW/MzOo8MTEpirDSf5h78gXn+wqhj9agon6Xc+HUJVihMpYyeuQLAPQi7JZ8dhc8Dmuu7f47qF5y5YiIb1nddJW35UpfefPr5GSzmO6GgPcA9cgMHjFNgbpAH0vUhPWL2pnT+xCVIFFoeLsZiyALlJV+wuzT4sGz3BxvbuaZNo6QJzHoVbiNqyNS8bObKaiHIi8V6lRxk9oVRXslfYCCZ3E9wT4sWh45m+OTUa5PW+VTQUI847JSK13C8YJzMd/LOcQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a043947-736c-44d4-5f7d-08ded90ab60a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 13:55:16.2423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8k51Fi7ZRehkmP3Md/UnLllke5J0DJPXBLVbYQNJ0rSlapQp2vM0z7uNyKklz35cuA3IzZeAf6/+QYFYk7txm2royKK4PCqLpkgwxRNjFhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR02MB11394
X-Proofpoint-GUID: J-7421HFLlIUPq9BGOdYqP4o5tXxC6cD
X-Proofpoint-ORIG-GUID: J-7421HFLlIUPq9BGOdYqP4o5tXxC6cD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfX8hEnHyVxP4fM
 65zDb0hccGgA2rV7o4mQscX8I3Si3V9OnL/G4ieKg+dR3ZsD/YaFm5S1MP0LWL2SHoZlh8ND2ST
 fhd0q9DB09d4Nge+I5MHh3Ah4i5zR7q+O9WaXtM5M46C7nltX7Pbp8yzfrIS8nEHuwq+7U5UtgI
 umSdkgO4N5Ggl27dBbvusaYHg0FpURL+aRA+ic5HkedmWs8fqIJlOefW8TXmQ+eUulrQY/bti7P
 /m/rAU3MU/Gm6pVto9CNPmY0wfEeUp+vsR69WYUVFnAxclBSXlLm5xFxfEjK9bzexpTSRSL6UF+
 psAFpWVKKOWtjAMxRE9QcSoo7IDqaUK5QbK3fteveotjJ3EUPmQkiO01e6nB2F3JsZlVFrG2Er9
 nKWI87IEwJkFyazIeO0J4jlQxeRNmr4HHAz08FxCBWHgReSQh9/I2cVITltsc6PzyEsa9CB1SiC
 Z98oZr6JgBxar8c5v6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfX3SSdEdIAswyH
 WlwQtuYij8iSMg4QttcvXFEo501mM7G3gKwAJeNk3mgUET5CvxiyujgweMg8x35bimpe0gO218m
 ZtTs/Hbzs2DLFW5KfkhsdiHpyE90560=
X-Authority-Analysis: v=2.4 cv=CYQ4Irrl c=1 sm=1 tr=0 ts=6a47bf46 cx=c_pps
 a=vcV0SyA3r3yo/t37AMr7eA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=mDV3o1hIAAAA:8 a=64Cc0HZtAAAA:8 a=vKcFq8QUBYrKBSkNEBgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

[Background: based upon Peter's feedback at
 https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg07717.html I realised
 that what we really need are object_class_property_add_*_ptr() equivalents to
 the existing object_property_add_*_ptr() functions to make it easier to
 convert existing properties.

 There are actually existing functions with these names that are already in use
 but after observation these are really static properties, so these are renamed
 to aid porting object props to class props, as well as making the difference
 clearer.]

Since the use of object props is effectively deprecated, here is an attempt
to convert all use of object props in hw/acpi to class props. The eventual
aim is to continue working through the codebase, removing all remaining uses
of object props.

The series is lightly tested: it passes "make check", GitLab CI and some
simple local tests. I'm mostly interested for feedback on the conversion
strategy, and to get a feel for the best way to merge this series since once
the basic conversion patterns are in place, the same patterns can be applied
elsewhere and it would be good to minimise the merge window for such changes.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

v2:
- Add object_class_property_add_*_ptr() functions matching the existing
  object_property_add_*_ptr() functions for class functions

- Rework patch to use new functions instead of manually adding get/set
  functions as part of the conversion

- Ignore existing R-Bs since this approach is quite different to v1

- Rebase onto master


Mark Cave-Ayland (12):
  qom/object.c: rename object_class_property_uint*_ptr() to
    object_class_static_property_uint*_ptr()
  qom/object.c: add object_class_property_add_uint8_ptr()
  qom/object.c: add object_class_property_add_uint16_ptr()
  qom/object.c: add object_class_property_add_uint32_ptr()
  qom/object.c: add object_class_property_add_uint64_ptr()
  hw/acpi/ich9.c: move initial property values into
    ich9_reset_properties()
  hw/isa/lpc_ich9.c: convert ich9_lpc_initfn() object props to class
    props
  hw/acpi/ich9.c: don't pass ICH9LPCPMRegs via opaque for
    ACPI_PM_PROP_GPE0_BLK prop
  hw/acpi/ich9.c: convert object props in ICH9_LPC_DEVICE to class props
  hw/acpi/pcihp.c: convert ACPI_PCIHP_IO_BASE_PROP and
    ACPI_PCIHP_IO_BASE_PROP to class props
  hw/acpi/pcihp.c: convert ACPI_PCIHP_PROP_BSEL from object prop to
    class prop
  hw/acpi/piix4.c: convert object props in PIIX4_PM to class props

 include/hw/acpi/ich9.h         |   4 +-
 include/hw/pci/pci_bus.h       |   2 +
 include/qom/object.h           |  20 ++++
 hw/acpi/generic_event_device.c |  10 ++
 hw/acpi/ich9.c                 |  79 ++++++++-----
 hw/acpi/pci-bridge.c           |   9 +-
 hw/acpi/pcihp.c                |  37 +++----
 hw/acpi/piix4.c                |  51 ++++++---
 hw/arm/virt-acpi-build.c       |   7 +-
 hw/i386/acpi-build.c           |   7 +-
 hw/isa/lpc_ich9.c              |  71 +++++++++---
 hw/pci/pci.c                   |  32 ++++++
 hw/riscv/spike.c               |   5 +-
 qom/object.c                   | 196 ++++++++++++++++++++++++++++++++-
 14 files changed, 440 insertions(+), 90 deletions(-)

-- 
2.43.0


