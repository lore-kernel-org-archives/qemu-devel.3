Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44457C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x692H-0007cs-FZ; Mon, 14 Sep 2026 11:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1x692F-0007bU-98
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:55:59 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1x692D-0003uq-87
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:55:59 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED1NWa316371; Mon, 14 Sep 2026 08:55:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=f9WdJB+5cLrIY7JQAG4FrbOQzIHHZvoecMFRnHh1V
 80=; b=yTioaH+aotsFopiD/omS+FiSPixfDiWrEUDmCivC380sa6aJgG5Sr0JuF
 n2NVheWExD8EDKIeD5XtetEJd0lXxqZbybhtEuRYBnSlICoMSinDFgQzwwRCuYSF
 UvW7VJrCOwJriRKg18BWrnsp12na4sDSUwupE7KCwgWqN4+ZZLme/x0DS1AkD78z
 9JAzgk5wSSOtY1wnbftEfSXc8Qt7O8DYJAFwtYzYD6Yi1n7C9y+X2ms0VdA07tfO
 xdg/Rc7s+5WLFbo6pOlHDWkKHO/ALXS7pA9+FMFg3PeSF19UhYTr9HTGJl14YyWH
 eOj+piXSNAjzxGf1UD2v24zN7g74w==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021077.outbound.protection.outlook.com [52.101.57.77])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gn32pbgxu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 08:55:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9ow+KPv4nssbAgUy+aJO4BvRRh8kGgaInDc5x9JjJ3pKb5GGq/tXm+U8PFYPkYduHtW1OHZ7TdzZ4jIBmr0wztKAJwwu7+RX2PzJXpL8Kjr3ap2o7OkhMwT9L4S1XfjG/LpP681Q6U9IcUBAcwR56oSw47WIQKMqE/nUgD84vPjr4cKYZzn/z/QrZ8wxK8jysoJsVypc6Cs+p7U4O2yrBhS1yZnPaMBcxx2hphoGEBwBh9FPPrOzXXzST/l+ZGYI/Nl2KOer+i5veZ7gDYMCETAFi2pWwgK2hOWdHABu3fnjlxqCAz2cdp7VuhdCc5qpaztPuFhPtATGABkZoyWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9WdJB+5cLrIY7JQAG4FrbOQzIHHZvoecMFRnHh1V80=;
 b=LZda0PiLPOiK3vwykX70F28kYdjfuXpTm2Kpw6kaVioRzd/IUF6UyuMBdyQ5Dt36A0SvXTz/gYyzK/7ocdDaxVGyVq0W7cfOpSlYfdS9mGG9Vra2A4tq+ZfkdMeDo0VoUyBTfREYhjKkDO08AYMDJve5Q8higQR7IYfEbhvZc/Ru4yDHvOuKl5icNBCzK0cCSKqDkTN2hXs/bVCa5XCobX0QpuLNU+6Kv1fKcb91FpORZC8HqAxU8VssXj+jK1pVhIm5vwZnxW9eRuCt3zGbglq0sD3aH2PTv/mRLdlBQ4FdSmQSDK/mlyrm95UZNU9aF4d54a/XVDbtE+0NaXrgOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9WdJB+5cLrIY7JQAG4FrbOQzIHHZvoecMFRnHh1V80=;
 b=rQbgPaYNUePTNdt75ttbKi/26Gbz5bv2UsGJEXtDB4rOYErhfrdRa+YtOflpm3lGfbuTeQyAP8bmPRuqknfPkBJO48VsbpvDyAThbJB5VZx3v6HX3/CXQSfB77WX0QYkAvEsmPfGjyZi21UG4A9G2dS3r4WOk6tzDMAxH9hRKdFzJ/thkM5MT7GcDRcJzJVefrmczEy8fyPKlAtsYzDXFz75Y3VLO1CkP8rZKjcQNeh4VtxTxPXTjlLGgPuh9eMtgeMghLUn/tE34SyJjrzgOMrCGG81wahHjWhxLGMI9Lu4wJLSWTDO3/MpmSzYOzfvA6JvsyeijU8+viwm9wpCHg==
Received: from DM6PR02MB4106.namprd02.prod.outlook.com (2603:10b6:5:9f::28) by
 SJ0PR02MB7664.namprd02.prod.outlook.com (2603:10b6:a03:323::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 15:55:08 +0000
Received: from DM6PR02MB4106.namprd02.prod.outlook.com
 ([fe80::ca0d:a5af:3111:1221]) by DM6PR02MB4106.namprd02.prod.outlook.com
 ([fe80::ca0d:a5af:3111:1221%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 15:55:08 +0000
Message-ID: <e11271d1-fcc5-4d7a-bc88-c703ed052b26@nutanix.com>
Date: Mon, 14 Sep 2026 16:54:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU community call tomorrow - call for agenda items
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>,
 Anton Johansson <anjo@rev.ng>, Markus Armbruster <armbru@redhat.com>,
 Brian Cain <bcain@quicinc.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, cw@f00f.org,
 dbarboza@qti.qualcomm.com, Demi Marie Obenour <demiobenour@gmail.com>,
 dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>,
 eblot@rivosinc.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, felipe@nutanix.com,
 helge.deller@googlemail.com, Alyssa Ross <hi@alyssa.is>,
 iggy@theiggy.com, Warner Losh <imp@bsdimp.com>,
 jacob.oursland@gmail.com, Jan Kiszka <jan.kiszka@web.de>,
 Jason Gunthorpe <jgg@nvidia.com>, jidong.xiao@gmail.com,
 Jim Shu <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 matthieu@minio.io, Max Chou <max.chou@sifive.com>,
 Mark Burton <mburton@qti.qualcomm.com>, "Ho, Nelson"
 <nelson.ho@windriver.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 utsingh@redhat.com, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
References: <87ik47dfpe.fsf@draig.linaro.org>
Content-Language: en-GB
From: Florian Schmidt <flosch@nutanix.com>
In-Reply-To: <87ik47dfpe.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0040.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::16) To DM6PR02MB4106.namprd02.prod.outlook.com
 (2603:10b6:5:9f::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR02MB4106:EE_|SJ0PR02MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: dcdcc9dc-8061-42cc-4ff7-08df12788cfa
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|921020|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NhOw44fU7ZY3TNYpKeoraxk7X5amJW2dZw6CJZqlnC7mQe+09/W2gMBQeoiuIRbtVvw7wQpC7amVUu64/K9Nf7JbfFu4xmh8TcT3Qt/io1crTNbjPPhUWBu6vCLxOiY+lYCi86ejLUD9UPlUSo5vJGI55BczgPII728kheQD8Rk+bm9CYzIdUaIN2oDlvJwFNFbmxSxKBeoIzfufZH22/X+tGm1WjTFI8EIZblr/jsljaafriW9ceMsV200w104qPV1pteUqw/cJN7aPXYlRf59ig0eIfmCj4lDXKbaVTMsnzHU6czbSv4UsIbrKXPmMHrRY4rGKZOMfidLhSIlUkGg6ZD7cGKvWN0dhjObajTRKxbJaErq2YQzxFe10mKedwp+o6LtTVqLGEztHaVYYMNHs8jT8v91sl48CGVTnfnt49VThk5MzxzMNFyBeFFZYAgQUpd1vQOm+/FtokBIXPxNDFEd36ykzAnHsJ45WL2XYSV5tUIc+XZ3uoNAHCBoLBryTWl7ht2EYv3ZDshidU6/3aHzddF44YPhi7E1EprOEfYq9ORq+jCSzbwXseG/xJr0qCsxiBO80jtqJvDCFIg7m1gE7/2PmzDEsq+zbEaoI90oNYtxHsA6aFUc14poVdgqgiHrSCo7ElfsJsFGqMTg+iXBPfzYGVNXM9cQmc9Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR02MB4106.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(921020)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDE3RnpnU0JoUzJiSjhKWVRzUXI2cVZKbFA0Z0Z4WmI1b0dPTC9uSERBSG5O?=
 =?utf-8?B?Z05RUEwrMEo3S2IvWXVFYTdsUlozTXVYdENjdkFUU2NUY0owSmY0UE94VXJV?=
 =?utf-8?B?T0orNWh4MmxRSTkrcVdLdUVqUDVjOEdWV0FDUlJLblYwOXAwUGRGNmxkeFdV?=
 =?utf-8?B?bE51R1dLd2ZpSmVGUFBKOG9SSTFKcTVMNFMydmNBRzRGZndjQXZBenE2dmI3?=
 =?utf-8?B?YTI1V0szRU5GVlJRdW1JR1p2d1FKQXZhUzV5RXZNY0RtYTVsVWdmenIyTTRk?=
 =?utf-8?B?VzU1RjUyWTJVY09pYSt5TmcvbWEybXRBUXFicWhHS2F2cDBaeUk1K0o0c2xG?=
 =?utf-8?B?SjNVeHNwUjN6dFBXcmJEak13VCtlK2NQZHFzbW0zVDRhS1IvL2JjaTRLbDZy?=
 =?utf-8?B?OTEwZXhHb3VSR2svTGV2OUp1WDY1NFZzSDBydjRsSnVOQWJnMjZZZ1JRRSs2?=
 =?utf-8?B?bkdaWitGS3dWckRTaEFTY0JpVEYzQ2Q2V3VPNDdYNGJPdDM1ZWRLU2k0bVM1?=
 =?utf-8?B?a1cwVW4yNUNrOFR5WEF5b3A0MGs5VTNNSWNkdS9CdktGd250TDNoUnpFVVU2?=
 =?utf-8?B?WTJOc0h6UEIvQ2hYK1Fzb29GMXNxWVJtYkMzV1BIZmI3cUUxdDdjbGIwc05z?=
 =?utf-8?B?eis3bEgwWmNhNTZveWNVZ1luQVUvMUZ4bC9ZU2FiWldtUCtQdkplOFBmVFdG?=
 =?utf-8?B?Zk9uanFJTWx4ODRDSEhYOVIvaHBSR1NFeHRDWEN3RzZ3RGttUG13MVEwNmIw?=
 =?utf-8?B?Q1ZKWkRya24wUmNJMHoyMXFGZHRCR1lKQlk2Nmw1NDJLVEx6WVN2cEFQZzY0?=
 =?utf-8?B?M0l2TnlMUnhUSnhTL3RIdjROV0ZMazQwOEk3Y1pCSmJxMnZjU25mMHpiR0c5?=
 =?utf-8?B?MldsQWpoQUhNQXdVZzFZdTFzb2ljaEJpV1pBVk50UU5wTlp6U2kwemtqTmM2?=
 =?utf-8?B?alZISzVoSW9NVHNnUWhGalBjQnFSU2ZXdGV2WnFsMVpIcGRlZ0pCNUIydVov?=
 =?utf-8?B?cTl6MU4rbnFYR1loaUE2Y1NUSHE3YlBtWWpwSm1zTGZWQ1lFWXJzTGxMbDF2?=
 =?utf-8?B?NGxIRHRxais1cjJKQmI5WFFwMXFVNk5UbUlCM1kxdCs3OGxxdFNVbGxZbEto?=
 =?utf-8?B?RTRrcHU0NStOUDdDOXdUUEI0NnZWbFNwT3JDZnZMNlNJRE1FMW8wNk13OFNl?=
 =?utf-8?B?cDNIdWlkbWlFSkt4TjJieGszNmxRZ3Q5cDM2VGlqc3ZzTjFneHdnWkRCRWJj?=
 =?utf-8?B?blZDaU96VzNoNUdlV3FvYjJYUU1xL25oU1Q4KzJMV3dTZ2x2QXZrYVlHS0Zn?=
 =?utf-8?B?Z2xYRkRnVUNQencxSURGazhrb1R5U1hHWW96OWpvYndSSXNwSUN4djJ2Vmtk?=
 =?utf-8?B?TjRFL1k1L24wazc1a0dQaGQrUzFBWlUycEVJb09ZWnhwbUZERE8vNmpHVVpC?=
 =?utf-8?B?S3AraHgwMFR2YnZ5VlpyNG5KSEZFM2gxYm9pZWNpUG52eVJwd3NPVWYrOXRj?=
 =?utf-8?B?WUJ0L3FhYjR0eEh3SEJsYks1MmF4S2FDcCtwTFkzU3p6RDBoemRvZ0cvMHpi?=
 =?utf-8?B?T0ZGVHBUWFFLanFIbzVXdGVIR01Rc1hqYVlZbUR3UTIySnlRYm94elpXZTkv?=
 =?utf-8?B?YzBWMGdQYzJiVXRtYURGajRIZHZuYmpDV0dSQU50Z2hYb2tLV3lsMzZvS2NT?=
 =?utf-8?B?S29TaFJNZUZNWlNaM3o5eHlyWDNBOVpIOFRMQnArZ2ZaSkVaRHBMYmJiVlE4?=
 =?utf-8?B?NEhGM2Z1YXhscnF2MHEvUUxSYnhiS0IrVG5yK1dhUmRtWHFDWnRXd3YwNVR5?=
 =?utf-8?B?T2lndmloRnlZSUJIcnVxeEU1TTN5dW4xMXZNYW10SERPU0lZcEZVTlhRNUZo?=
 =?utf-8?B?TjBROENCaVdyeHR3bHpOcWJuTE1UL1h5ZGZ4RWhKZWplRG4vaHJDdFF0Z0Uv?=
 =?utf-8?B?L2dsVHpVeGVNZ3NqZ0QxSUtLNm9TMGlzZmxWOEQzYnZHQjhoeGN4WFFIcWlk?=
 =?utf-8?B?eW5mbnoyZmJGakpNR0VrcDZMVVkwNm9KQVBKeFo3ODVGUnlPcVZhUDV5QVky?=
 =?utf-8?B?RHZmTzk4SlBUYWdIRWtyUlhuY3lCN3JTTmlKZFVub3dRejhsSzFoUHVoTUJx?=
 =?utf-8?B?T251VzdWcmZzU2tkMVBBY0MrVmJta2dDcDBGQU5MclNBL2xxL01LQ3dpSFhV?=
 =?utf-8?B?aVJON1gyTzRLMkNsVytkdER0emhFRDBpb2paMVMrTVpobjBZTE5aeFNQQlRw?=
 =?utf-8?B?T3VyS2p6K3Vka2lmWHFoMzJCLyticWFOMEF1K2J3ZjV3Z2VJamZQTGk4WFdX?=
 =?utf-8?B?NVNlUDFMU0krWVNUSTcxV3p6cE5qY3RnR3NVN0t2RTRTZjR2cGQza0lSKzdn?=
 =?utf-8?Q?bDZax9ZA/07I9lls=3D?=
X-Exchange-RoutingPolicyChecked: dYbjnPGAAxPazbxbOMzHpvF1RPTLHKubkZv4iPSuU9hrSyvvwW6Gv0FXQAxB7yMMm7/Q4T60l65GoYvdF6+2VANUl6Vx9r+HyBHOe83sl5zyjfuzj42n5W8z0WI4GTEzwFMdieZU4ISuhvhDksWF8nvVg8B84zy0eUgMPsyfOubO3IG6G3u/QQf9Zi4J7kd9S7PMWt19g11HIVPdlm2xC5EgTi+sx5/jNT/CZ/S2f4Qjq70TS9LfEDN9MY/Arzx6RCFsW4BzNBBui6NTMXsFh1pAajSgYQvdbLb73+1x1qhSpx9oA+pugqKsUfl7XC+V9G5mHZz5aTYhowZJ+NQCSA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcdcc9dc-8061-42cc-4ff7-08df12788cfa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB4106.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 15:55:08.3879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzAkvNmcYFM/YhtuOvEmnr5RnoG+TZImLzVQJb+qug3RB4KolM1cH/duRT7GNOUSyiQ/nBiBiJW/CDc39Qp0OiIgKFTXVt4hrT+iAOUwEHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7664
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIyNyBTYWx0ZWRfX9DieXyu74Fy/
 Uz2vMlXTOpQiVlTw2GwpHadKpzoCSIzluhbFYPWv8tl9NrPeAheStVF+Y9X0UfAI1wAePiJ5/mH
 csn6VrYb+ajxT6kfXWBmCHtmDe1pIkLZya56u+MfYJAHqapWJuLhdHaDm3ecXjhUxC87+OpYR20
 YWUnNLlGisdpMS5NnRSH+bP2aOqFJDzPVYoC2RJYKrwk6j7yacGUkXIkPqo688TB81ZdjJ5UniE
 u/9QT/Y/S8b0HwDukNZ4kOt1LNr3oy2WI0KTCWQXlXOveqJS2PJojpRaOF1hjV6z5RP5It4HTXC
 7zLXrWbXlU78LEKXCUa4s3x88eYENjQ1iJDf/v1OULWuuQ+qqxfV+uCF3I3toB1Uz3yNbHBjMw1
 H4H+0gJpepyIxeZyJlkVRJMdEvljABVvKeJDWFCILb+NdMAtKBcM0pWXPixCmpMNWa44Zv7+53C
 5eBzoUDCHWNx3vzIC8Q==
X-Proofpoint-ORIG-GUID: x0eBAWUEVaB6b4PDMG29uo4v3k1eRmgB
X-Authority-Analysis: v=2.4 cv=ResFmFtv c=1 sm=1 tr=0 ts=6aa818e0 cx=c_pps
 a=BLvYkjn5u0YClySNKAgoiw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=GaQpPoNlAAAA:8 a=64Cc0HZtAAAA:8 a=VwQbUJbxAAAA:8 a=VwS6gW2FNIUKta_rx2UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-GUID: x0eBAWUEVaB6b4PDMG29uo4v3k1eRmgB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIyNyBTYWx0ZWRfX/JigMigfinMs
 g12NOVuYoHiH2odQKb5bvh5AiXudwCBampu/mMow59rBS1Ux3vB/3ywMLXMAgaxhJCN/a5oxUpY
 o1IBIk2JsTIbvoTwRhos7XOhjL40Gr4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=flosch@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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

Hi,

On 2026-09-14 16:18, Alex Bennée wrote:
> Are there any agenda items for the sync-up?


I'd love to discuss this patch series on BootZeroedMemory: 
https://patchew.org/QEMU/20260731095112.2975175-1-flosch@nutanix.com/

Given that this also requires a KVM-side change 
(https://lore.kernel.org/all/20260731091708.2963414-1-flosch@nutanix.com/) 
that got a lukewarm reception, I'd like to discuss what the best way 
forward would be here.
Cheers,
Florian


