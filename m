Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3000CAC5BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Vo4-00066E-PS; Tue, 30 Sep 2025 04:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1v3Vo1-000666-Qq
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:33:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1v3Vnv-0004Cn-GP
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:33:51 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4I9gE015470;
 Tue, 30 Sep 2025 08:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=3bkG8oPj4AnAUua5ySAtPc3LYVNz2U95+1Rh22LzjPU=; b=k7
 Zha02/EDrJrBaVshLmyLSoNho4VpGreTPWsRxxf9+Qxnf++nCm3OqhJNpEUmO1KO
 cgEziE1zfNLEobPBDFgPNHsyeHSFIgKG1l8ZIdStkAVacRMrHvCBLzaQdzILGCDn
 XKRJyuXJjURgb6CRGsC4Vk65Lr8fwcX/45Nog3y3Zhm+sjRstTPgUzZCtLSjkW8k
 U8EdIewdAMfsiUYJuZxPe9sol3H87gh/uM5BKvuLuWbw2o32s+FIjHoF/xbx/Igr
 xV+F3BdYa2ZtcXcsc42k1ro/mzB9baTghloXu8m+k10C3hwRQuslDQI/UDbFLgFI
 pEWDeaDqrqUDBt3dQU2Q==
Received: from bn1pr07cu003.outbound.protection.outlook.com
 (mail-bn1pr07cu00305.outbound.protection.outlook.com [40.93.12.5])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6vr09wr-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Sep 2025 08:33:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aS/Qk3VxiDBMDkDaRBmTnwQhztSqhBORlnU81gqRM0yzOg8+ffra5HBdMXdjyH8O3vqAXLZQ013xVFhtXY9LKTyvO+1RhvccMZB9+rvc8aSx6/nA/1nBAJp3m2zvnZebn/B2IHey6dhSwcsTk57Rq0SyIYWRSHmmUpmb+swCw+o1q9jNJzo32B5o3+1Dvv/0SA3sJGSMYwk4WuqjfJSeoLKEnBRpvAJjfJJH2NvQoJeujTMHuuPuxA06T8LfD621zjpr6QTI2eqTmZ+8xxydsnmFnMBtjlHFlLcAqyQ3xjviNDn48q1h0JYlj0I7lyAkj8uoSS7dcXv3AUn8dQr01g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bkG8oPj4AnAUua5ySAtPc3LYVNz2U95+1Rh22LzjPU=;
 b=CDPc+0El60h8xZclZbnLYzTbaNSEjc97irhmTSVyNghdvQYRzcGu0qtW5JkBMd96KLuEMfldp9iQ59g4x9AytLIaoCofo8ZxPHh9VWmcAhrwdRjihT79sZmwsm0U7B096fmpSb7JcXVRx0ayGYu5Fefz5DjnpTZLy59zT8I2exeAu89iBT0dRkTWZh6seZUYHJxcz9OubdYEWH6tSuvGuHOEtIhJdYt6+gMkcQPhezDSZ5SngfFigfXsNdBnjRQqJo/Q2IV2nh4WTFhc6YGvNDtiMabXSWAomdmK5YtMoF1OBgPsyH7rrhvkapeT5I3TzaW0cMmc2L3ecLAcPIfZow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from CO1PR02MB8617.namprd02.prod.outlook.com (2603:10b6:303:15c::20)
 by BN0PR02MB8173.namprd02.prod.outlook.com (2603:10b6:408:166::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 08:33:08 +0000
Received: from CO1PR02MB8617.namprd02.prod.outlook.com
 ([fe80::5a28:4da0:a734:9bcf]) by CO1PR02MB8617.namprd02.prod.outlook.com
 ([fe80::5a28:4da0:a734:9bcf%6]) with mapi id 15.20.9137.021; Tue, 30 Sep 2025
 08:33:07 +0000
From: Mark Burton <mburton@qti.qualcomm.com>
To: Felipe Franciosi <felipe@nutanix.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>, Alessandro Di Federico <ale@rev.ng>, Alistair
 Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, Markus
 Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, "cw@f00f.org" <cw@f00f.org>, "demiobenour@gmail.com"
 <demiobenour@gmail.com>, "dhedde@kalrayinc.com" <dhedde@kalrayinc.com>,
 Eric Blake <eblake@redhat.com>, "eblot@rivosinc.com" <eblot@rivosinc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Elena Ufimtseva <elena.ufimtseva@oracle.com>, Auger
 Eric <eric.auger@redhat.com>, Alyssa Ross <hi@alyssa.is>,
 "iggy@theiggy.com" <iggy@theiggy.com>, Warner Losh <imp@bsdimp.com>,
 Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 "jidong.xiao@gmail.com" <jidong.xiao@gmail.com>, Jim Shu
 <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>, Max Chou
 <max.chou@sifive.com>, "mdean@redhat.com" <mdean@redhat.com>, "Ho, Nelson"
 <nelson.ho@windriver.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter
 Maydell <peter.maydell@linaro.org>,
 =?utf-8?B?UGhpbCBNYXRoaWV1LURhdWTDqQ==?= <philmd@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Bernhard
 Beschow <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas
 Huth <thuth@redhat.com>, "wei.w.wang@intel.com" <wei.w.wang@intel.com>,
 "z.huo@139.com" <z.huo@139.com>, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "zwu.kernel@gmail.com" <zwu.kernel@gmail.com>
Subject: Re: KVM/QEMU community call 30/09/2025 agenda items?
Thread-Topic: KVM/QEMU community call 30/09/2025 agenda items?
Thread-Index: AQHcMUJAXYUnLO8GtU2nYtvz+EXxQLSqYFiAgAEGHYCAAACqAA==
Date: Tue, 30 Sep 2025 08:33:07 +0000
Message-ID: <3CD93242-7EFA-4B17-900E-6973BE1D0B3F@qti.qualcomm.com>
References: <87y0pxl826.fsf@draig.linaro.org>
 <7cd53af2-b443-4c42-99cf-07dbaaa97f3b@redhat.com>
 <8C16C7BF-800B-4BB6-A6D1-4C9DA644E306@nutanix.com>
In-Reply-To: <8C16C7BF-800B-4BB6-A6D1-4C9DA644E306@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR02MB8617:EE_|BN0PR02MB8173:EE_
x-ms-office365-filtering-correlation-id: eb560156-1169-4358-b28e-08ddfffbfb83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?QlJGamdsWm1xZVlXcEgvUVA2ZG1vakc3djRJd29tbENLOFpsQk1hVUN0YU9T?=
 =?utf-8?B?cG5GQnprN3NnTVNZSlV1bTRCcEI4TWIrY2htRFZ6YmMwajc3L1d1d29YazN1?=
 =?utf-8?B?SWxtNHBubWpiNVZLcmJxL3NzNHd1RHYrUERqZXAxWG94MEczUEZEeHBLTkFG?=
 =?utf-8?B?V3ZUVlBYN3I1aUMwdFNDaFpiRzJkSE1DNk9scEhFNmhBQ0NRRFREM0pMTTBW?=
 =?utf-8?B?bldGdmxOUGU1ZVRTSXdPZ0lkN044S2dHL1NZbEVmeUt3VFB2VHdaeHdtaWlV?=
 =?utf-8?B?bEFMQVNHMGY0RnNTY2ZyTHlpc2ZGUFkxeU4wdmdhT01RaUFtMHQ4QTZpeXlD?=
 =?utf-8?B?bVNMblNrSDlXVWZHNTk2U2tiWmpSam9hMythSlpZUm9GcDV1dVFxZ0NKSVNJ?=
 =?utf-8?B?a0p6RjFVNUVWOUwxc2lDZXcxc1NDSHo1Q01kL3NSREhvMDg0UkUzVUpFWGhk?=
 =?utf-8?B?ZTF3dUNzdDFRSWhXSXVwbVg1N3g5Q05GQng4Y296bCtxMHJOd2pqR25OcHAv?=
 =?utf-8?B?VkgrRVlHYmhaVGUxTEpOZnprQUU3a2prc2I0dFMzcVRLbnFwTmtLQld5ckdy?=
 =?utf-8?B?MjJSVXBZaFV0U25TQWVVemwrZnBWRVFidms5Z1dHeGR5NWV4SitNRFUrZ3dl?=
 =?utf-8?B?L0NxRFUyay9CRi9sdVdQdXdWbVFRZmFGN0ZzVkVGemRNREo1Rno5b0gzRkZ2?=
 =?utf-8?B?MUFCb3JYKzlteGxJVHJ4aHBUUERLWFFPVitFcHl1by8ydFpnY1I3QjloWFl4?=
 =?utf-8?B?YTFBUDBmME5JZXlEc3ZSOEpzd04zb1VsdnZsMCtWS2R1dFArY25ZTmw4QU0z?=
 =?utf-8?B?RDlqMEwveWU3bkkxVU5UM1g0R2V0OXhCRW5kREt2MGNCVnE0OGlOWjIvQk9V?=
 =?utf-8?B?b1A2dHowd0p6K1B0T2N1SEpiQThLbE9HOTR3dlBvdktubkpqWitKN2QwRGxL?=
 =?utf-8?B?RDdOdStGUzRCblFyejJHNEpEeFJzR0FSSmFzRys4ZElkZGdGUk9mOHZ5RGZm?=
 =?utf-8?B?SFM1YUZ2SFIveVYxb2E2VVMwcHEvdHhvU1NUTUVHZ3NTSDRmeXI2UGJvVmVx?=
 =?utf-8?B?SHRlWDNvVDdnRmRIWnVJa2JzajlnRjh6VXA3aUU2cURlZGJNaEpWSENOQWd0?=
 =?utf-8?B?dlo1bnRTQ3BwWmJWajIwNDNLMEtrNWRlalQ0Q1doTzdWMzYzbGFiYUNUK1ZZ?=
 =?utf-8?B?MndCT00yOW9qNUZWMTUzYzJ2enFSYUpoTTQzMGhhMHU2ZEdiUUJ5U0paT3JX?=
 =?utf-8?B?cUF6K0lIVnA1ZjlIVUw3dXJ3ZG5HY3dkSElWR2ppSERpQm8xd2gzQjBVWXc1?=
 =?utf-8?B?L2lpQ3pBSTlqVkdnTE51Z0h6VFRYSWtUSWtYUG15NnVkZ1RhL3NQaWFxb2lw?=
 =?utf-8?B?S29SY1djZ0Zqd3RGNE5xd09hNnAwY1cxZlhpamdVeWxvQ0ZtaXVlRlBUTStj?=
 =?utf-8?B?QjN6RkJCZ0RHUjgvV1ZzNFRacklUcC9NSE1zaEZ6RzdTKy81TmN4UlI4dGp1?=
 =?utf-8?B?aEtnSldRNVdWZU1SL2kzellEd2tNREc5QUhHR25xRStLL2RlYXJCaUxYZ0la?=
 =?utf-8?B?SGNRbzJWK0dZTFBqR1NLVjRjaEt0L3dQU0sreXB0aXJhVFZEeG9BdHZMV2V4?=
 =?utf-8?B?eEpQZXgvZkRrallDUkYvYkNoUFU4SlFBRDVnMVZKeFV0SmV6VVBIbHQ3TWRK?=
 =?utf-8?B?M05wZXlSYVdJemlzZ3ZNbE1aWlVjOVlidk9LOU1XNWljZzBnZ2V5N1Z4WnNp?=
 =?utf-8?B?RWdQN092Ykw4RUpnMnY5SHRWOG9HbytmSUh4OEVCNkNkL0xLRVRjL0VUMVVy?=
 =?utf-8?B?d2ViR0hmSHcvQXBmbWJvQkxtNFRwN2s5OFdyd3YxeUNmdkp6eVVYN1B0ZjJG?=
 =?utf-8?B?bCs0RFdEVkkreWN4djEyTlJtRW9GcGdtOHUrU29OajV5bUlwVms2L2xOeVhB?=
 =?utf-8?B?aWFkeUtERU5DS1U4c0M0ckVqdUFsU0JLa0E0SkFGYXJETjRkSURncENmdDNj?=
 =?utf-8?B?OHRCcWUwMzJRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR02MB8617.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGpzYVRMRGJ2YUgzcHB1VkR6RVFmckxaUE8vbHJYUUpFVjEwc3VlVEw4cGRZ?=
 =?utf-8?B?T3YrMnpISnhFamNLaG1FSzBQWDE1U211TWo4Ui9yVTRrZ1dwczd5N2ZVM3dh?=
 =?utf-8?B?bHk5Ti9yUEJESVZ0eDRtOTJQdjFTamUxSzlqMFQxOWR0eHZsU1pCNXl1cHlE?=
 =?utf-8?B?S0dnVWhhY2NQU0h0bXlZbjJDU3NtbE04Nm9XRHdTbGpjK2E2SkdkRFdDVW1H?=
 =?utf-8?B?cGtaMzhnS25iSzFydU1mdXhHYTh0dmhDSUpNYXUxdnp6VE5GU09ZRGQ4U2Y3?=
 =?utf-8?B?b2sxTTg3U1RFaThxcHEwQkRyTUprbSt5WFZUVzV1ZFZpV3FMTEJVZzVkeUV1?=
 =?utf-8?B?bG1ZeWZjNnk0MktpNm5UTlYyMTZtdnQ5OUxUTmNWUmU5MDdoQk00RE9kZGVF?=
 =?utf-8?B?akR5RnlaTXlSNE42U2J2MEFjT3UvTE1BdXo3T1JVTCtqMjBWei9ldGsrU21M?=
 =?utf-8?B?SnMzdUxiNXBsNkkwR2k5dDd3TXNLVFhkV1VjQWhCM3I3R1k5OUllYXhmM3hu?=
 =?utf-8?B?OW84N21Ob3lUdi9mY3JoZVYrc1N4TGVObzBsb3ZIR1R3S25BZTdrQ0VXTmEy?=
 =?utf-8?B?NDhiRlg1VG5UZEJrRFVlME9iaStBOWFJUDgyc1VLcWc4dmtuazU3VExGRnhV?=
 =?utf-8?B?TUZRTGduZUxndWhGWitSR3V4czAzaGZvQnhValBSWmhLaXFnazlXT3YxSmt6?=
 =?utf-8?B?b3NVZEU5dUVKR0psSFVuaU54UllvWXd4SXpKUXpaRjRDaWNjR2c0S3lrdFJi?=
 =?utf-8?B?bnlSN3dDL3Y3Y280YmE2NWE2d0V0SG9hWEhjMUdyMGFpVlVwVFpWNDBZTUE5?=
 =?utf-8?B?K014c0F2R3laSWdJNjdzRlcvRlN5eFZKVDlaQnpISTB0eitXMm1UTUQzQ29y?=
 =?utf-8?B?aVcxdkUvaXQ4YkhrdUkwWGtsVFJFQ0N1eVhDWGU0dkIyTDRFalVxVHRYVWd3?=
 =?utf-8?B?eDEwM1F0RXI1cURHalIwaUNUSVhTQng3U3dvMXp5UFdxQkUzN2w4RVFGVmw2?=
 =?utf-8?B?K3A3b0U5azV5cDRzc3ArZGdLL0piNUlyR203RnkvODBrd0tjbmpNZjdDSG0w?=
 =?utf-8?B?RG1LYUlBQ1RMMnJKMFo3ZmVXTXFuSFFoTVZQb2hIOGVpRFFTelVNWDZDVHRa?=
 =?utf-8?B?QUtKUjVTTnp4ZFF4eTQzYnA0L3dhVms4SHhXUXovWS9VQWMvTXg4aG9KRE1L?=
 =?utf-8?B?MzZra2oyUDdWNnY3SzJjYWNwQ3NMWlB2aW96bjlTSWFsaXliZE5rWWNqWGxu?=
 =?utf-8?B?UTdUSklvaitqWENxeXlNM2ZzaUtpZk1zNk5EelFDNUlCTS9rdXgwRFE2QVlH?=
 =?utf-8?B?YldvdmVsM0ZvdTczUU1Hdm9TUTExNG5WWkprTktNYmk4Wk1RakdLN2JnY0dQ?=
 =?utf-8?B?aUN0eUFPTFlLNmlOQmJnM09JZUZDVFFZYXB1akkzYTlyeVNDaTFCTVE1NkM3?=
 =?utf-8?B?S2pYQzVvY2V0N3pQLzRLaVJpZzh2dHkzRzJ5LzJjcTZqYktVbHJGbEhENkE2?=
 =?utf-8?B?MEJEK2cvNkJKeFpxRC91Q2dQK08zUmhCbDVvWTVxMjFKWkZlN1hYTlNDZzlz?=
 =?utf-8?B?UWxvM2dUeXI5ZmlqcEswRVdqWlRKamp1Zk9zKzJkeWx1YnFEOTdrZEJXU2F3?=
 =?utf-8?B?QTVxZHhxbGZwT3VzMUs2K1R4cEJzWDc1eTZFWXRleXU3MzRyMWNWK3NoTytK?=
 =?utf-8?B?UjdkSlJUYnJXNzlXN1pnSE9VMm9tN1plWHpDMUZkYnBvMi82UG16eE5WZ0FG?=
 =?utf-8?B?Q3NGRk0xelFka2xPdmYxS1RNRCtON2ZlYk1XVU5maVhPRlNQVGFKWHBVQ3ZQ?=
 =?utf-8?B?eVZ1ZTl0b3NGZ2JiSG5qS3Z2anRkNzZpeFJsVy9rUzNqMFBLcGFMMXhKZ1J1?=
 =?utf-8?B?RUliOUlzNURvYUQ1ZHZJLzI4NFo0K3pwS1lQMzFNNmplSmlrOEdidUpXQ3h2?=
 =?utf-8?B?VWhmckxvRjVHcVhTbXh5WWNwYzZoWmNnVWs2LzdOQTcxbmJqT1MvYjZ4elI4?=
 =?utf-8?B?Nnd1N0puY1h6WTFCSFl5UDZxdU40RC9tZldDMXRHOGtkZ1JMNzVSUjZwVkQ1?=
 =?utf-8?B?MHhidDRJa2dDQ1JDSE5QK091UmVjR2dQUkNsZmRuRHhxNkUrdnZXK3JFYTJY?=
 =?utf-8?B?bDhTNXhBRWZWUHNyVW5OUytadjhWVnprOVdaamdsYzJvYnYzVnhZSm5ZckVX?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF0C611E5F767D44A97496019AEAE4F6@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: I3xDPN9SLAPXKMpY90wCJlfi3Vp2rOZMWLQo8a+ACEE91LVBbLzcnO+YJjDmwz6W5Ezud3HbYtmlB/w6z/bnp6JgmIwxf00vaCjvS7pfgZCfoB8s0eSvxp2rE1EYfyN4qb3xnTjVp1090TLyAN2SuoSSz3pmjxI/KVSx9Biu+0wLn4hNPDXdZSpppk43Vgsz7/N+E0pyyMSasdVBRhuwywAHAtR2wJ4MugBvQUl2MsSRgm3fyn/TQ82ccHIutGHB1/48r6666Yw2pykGVVovxTiHSKGVpvt+eYCjEYkC5nqAQ6CkxgDgI9KCthardtRwSvSY4XBMpDPLxd6DLlMvO/pCJvvKbb1isbvEVRiTUn2QtZaz5Z0hz/TECnSPc58L6nk63Z+sefUv+p99NmiJ7Kn8dzgziR8X+Yv/Uj84t2kv7jMZHTcOSZkT6T8K+esUEMXEku2aeDH6wSioEF87FfWLxMEd99hvEQxvERty5UXcL9NCmq75ogI/TzM6YuR2VeKHYx7Cv2634iYy9AjJoKNhc8jY9Lvrv+FbI5O+V85rz05vaEtStSqwy64zLnzIycx/fSBrhktnI0QA9FiA184HauOY84MqXUr5bs3pTm51fud6ObLZNeA82fWizpsL
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR02MB8617.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb560156-1169-4358-b28e-08ddfffbfb83
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 08:33:07.7547 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fRtVnhDXgOTf4Qu01r7AasFOm2VlkxOQf/oVJq4MO/WkhFpsg4ZXGWRQNHeXPoqVfpOSZ6cjvCNWrCu3hMi3lduH+7i4QnbfZONLT1aQpC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8173
X-Proofpoint-GUID: uwGPAuF7AMOMHg_7io5eBqVervpaUVi9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfXz/jd4FPSvHyS
 3alFT4GZZrIQUQiJj3xJ8ej5wFCV7HfcRsBlFz0ief4zSl34PEnf0AP1/+RWMYs3hx9Ryvi3AD9
 8BADj1VDneAw5Wa6SLB1cbFAtEGgPxfar8e99HpbQ/2nn6vVlCYKH+dDFSFM6ohJWJsIj+F2Rs5
 2GKthxrFMYNR5yE0aRkGtlYuVdH4SRoD5jb6/i7UbQwAWvCyvQ9+WWrMfxYWeooZqb9gO56aM1O
 oR9ibbMzBkUeZ3Bji5TjDpQvaeZMI3k8DuQRJ0wWtduy0PE1LB/yRho7BcXefjgTaM9jgcYr7c+
 34/tKZX9LCFuyQkPP3N+JGns96UBF2APbTHnwU1EMUz0xWhcY3u3RbIaDDvXsIE8xqQB7kqXkNt
 VTbfIZdYeHydv3N1pzmIsRYl0il6Ag==
X-Authority-Analysis: v=2.4 cv=IeiKmGqa c=1 sm=1 tr=0 ts=68db95c8 cx=c_pps
 a=xHYxGUywFvkkdmbedG1HCQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=nXA5WNwiAAAA:8 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8
 a=-TtOstshZYDOvr1cRWAA:9 a=QEXdDO2ut3YA:10 a=fGr-7aqQv4RST94IA8XU:22
 a=DXsff8QfwkrTrK3sU8N1:22 a=HhbK4dLum7pmb74im6QT:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: uwGPAuF7AMOMHg_7io5eBqVervpaUVi9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mburton@qti.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

VGhlIGxhdHRlciwgdGhlIGZvcm1lciByZXF1aXJlcyBhbiBhd2Z1bCBsb3Qgb2YgY29mZmVlICh0
aG91Z2ggaXQgaXMgcG9zc2libGUpLg0KDQpDaGVlcnMNCk1hcmsuDQoNCg0KPiBPbiAzMCBTZXAg
MjAyNSwgYXQgMTA6MzAsIEZlbGlwZSBGcmFuY2lvc2kgPGZlbGlwZUBudXRhbml4LmNvbT4gd3Jv
dGU6DQo+IA0KPiBXQVJOSU5HOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9m
IFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeSBvZiBhbnkgbGlua3Mgb3IgYXR0YWNobWVudHMsIGFu
ZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCj4gDQo+PiBPbiAyOSBTZXAgMjAyNSwgYXQgMTc6NTIs
IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4gDQo+PiBPbiA5
LzI5LzI1IDE1OjA5LCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+Pj4gSGksDQo+Pj4gVGhlIEtWTS9R
RU1VIGNvbW11bml0eSBjYWxsIGlzIGF0Og0KPj4+IGh0dHBzOi8vbWVldC5qaXQuc2kva3ZtY2Fs
bG1lZXRpbmcNCj4+PiBADQo+Pj4gMzAvMDkvMjAyNSAxMzowMCBVVEMNCj4+PiBBcmUgdGhlcmUg
YW55IGFnZW5kYSBpdGVtcyBmb3IgdGhlIHN5bmMtdXA/DQo+PiANCj4+IElmIGFueWJvZHkgd2Fu
dHMgdG8gdGFsayBBSSAob3IgcmF0aGVyLCB0aGlua3Mgd2Ugc2hvdWxkLS0tSSBjYW5ub3QgaW1h
Z2luZSBhbnlvbmUgKndhbnRpbmcqIHRoYXQpLCB3ZSBjYW4gZG8gdGhhdC4NCj4+IA0KPj4gUGFv
bG8NCj4gDQo+IERvIHlvdSBtZWFuIEFJIGFzIGluICJRRU1VIHJ1bm5pbmcgQUkgd29ya2xvYWRz
IiBvciBBSSBhcyBpbiAiZGV2ZWxvcGluZyBRRU1VDQo+IGNvZGUgd2l0aCBBSSI/DQo+IA0KPiBG
Lg0KDQo=

