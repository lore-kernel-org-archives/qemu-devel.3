Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818D2C79FA7
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 16:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcmxI-0003D9-4l; Mon, 05 Jan 2026 10:57:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1vcmxF-0003CJ-W5
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 10:57:14 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1vcmxD-0000IE-2y
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 10:57:13 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 605FRFmn4120236; Mon, 5 Jan 2026 07:56:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :message-id:mime-version:subject:to; s=proofpoint20171006; bh=Nf
 jaJuf4wQ0B4g6ZKgGi0tshGPH/Zkq+goPJKOfWXmU=; b=gVztWIlTHSxHL8UnGk
 g/eufN/m7XaJ9LiUgs6of+ovdtQnG3QmGazBr+qe/107T8rBHufBXHOyN3aDHtQ/
 9y047LTpe+3wewz1f9THOitqD519FcbhTjwgDIK/ZShVomNMRiQ2ArqaLz2Qf4bv
 L+A5O8b/ksS90VUHeJYhZdhzMv+sghV+X1HVyZzuSpBwy+HbwOPQxrhNdWT1ua7F
 8ZQv9Xn+QBlCcdIPN0LQBJ10ji0U9ExtBeugWwmt6fc6dSRRvH4wWEiwClcwku1O
 zIJYPd2Sz/NTFHR8VrEgcItQ1QMV5oDhlPROl3pHQqufGDFCIg0z4+Hdhrg4DrXv
 BbOg==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023115.outbound.protection.outlook.com
 [40.107.201.115])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4bf3afbd18-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 07:56:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EvtZQ3tnFoJjTJDv/SeJ/GGPCBESYlXyUOoxYdlaOcigsv8k2wamr8nRjH9f8T+3EnALT9P1YCghP38vshey4RglSDKjfo0X4nyIPVHlxe/wgSx7Wo7oOZjuqEegPXwyX281p8p7P4a/ey/Hb8JUI66EweI1emNwCQOp2tVUUwZJiTKPaQM22Adt33VqzKh5L5HFHcPG5gihwk5EY/KyQh6RRnuU7cI0lJ2bEDw7ikaG4AxFqlNS91D/LCkuzKw68F1CM19aYKCaXNEJ4jJbXxOaactMd8UCsY2nE3Az8DJDvRJXtyfsZg4v26jmHiMFWe1TlqLPzArTHepk15EaeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfjaJuf4wQ0B4g6ZKgGi0tshGPH/Zkq+goPJKOfWXmU=;
 b=IWnlF28ac9fBio99FIOqkAp+YbqWyQgrg33VWg2eTi5cFeY9wJpvMj7S1+v/mtaeA2vUDIvj3VEbkzCY3BtrgVkZ5YKX3iEvhWqrPHM7QyNKX6lKQxGReFSORIL1EIY/jfhjNASWn5cDArguKzv8csrWGa7Y0g7Bwc+KZEJs934NLV65zeiBjQACes8EOBiyDBhx3z7LTLTaRuf85eOPcjgjd1WQ9mbsr0Y+8EiYwVpH9pDZk96V/cr7zvWbNYDHokd11gwngkMs3/x0g78lw+zyAEmtWT6zqfY/4zg6eLjT2JKUQO4+sQ2ZwvBD3yXb0+EQy09d8iILe2BY8sitfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfjaJuf4wQ0B4g6ZKgGi0tshGPH/Zkq+goPJKOfWXmU=;
 b=MbGTLiOgNvTC9VMO2Ha8K+VZqc/3GaLSFEiM192dAdLDy0DpDuSq+/wwwbLDTrvDND8QfTRjRZ6UPetfGQypyeKeO8mt5LIuSl7yygoc/bZlw8sNU8AvKWrBICMMWn+DeNHqN38Rv9UyfcaqjZz9iBHY5q1O+DUHTa0M0xzTUgLsnbnI7CDYgtvprEPhh7zSV06IL54/p0BOLHjnqZBFqZDk8GaQ+vTSWvxcw09Dp2rIxPL9lKWmCix60GV4d88e1h+VGXONxBupOXlxI+sPqTJ9Kl5nA0O/zTxnUfnm294cEklecwm5Kb/5be+5XMm3O9fe8B802BhfaZuFnDYIBw==
Received: from BYAPR02MB5029.namprd02.prod.outlook.com (2603:10b6:a03:61::24)
 by CH8PR02MB11020.namprd02.prod.outlook.com (2603:10b6:610:2bf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 15:56:50 +0000
Received: from BYAPR02MB5029.namprd02.prod.outlook.com
 ([fe80::3eff:7198:f537:d1e8]) by BYAPR02MB5029.namprd02.prod.outlook.com
 ([fe80::3eff:7198:f537:d1e8%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 15:56:50 +0000
From: Yunpeng Yang <yunpeng.yang@nutanix.com>
To: "philmd@linaro.org" <philmd@linaro.org>
CC: "minyard@acm.org" <minyard@acm.org>, "farosas@suse.de" <farosas@suse.de>, 
 "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, "corey@minyard.net"
 <corey@minyard.net>, Jonathan Davies <jond@nutanix.com>
Subject: [PATCH v2 0/2] hw/ipmi/ipmi_bmc_sim: Get/set fake LAN config
Thread-Topic: [PATCH v2 0/2] hw/ipmi/ipmi_bmc_sim: Get/set fake LAN config
Thread-Index: AQHcflvnhI83B+K27EGlWAg0SVR8lw==
Date: Mon, 5 Jan 2026 15:56:49 +0000
Message-ID: <20260105155648.1037077-1-yunpeng.yang@nutanix.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB5029:EE_|CH8PR02MB11020:EE_
x-ms-office365-filtering-correlation-id: 8227bfd6-9fc7-4828-7a71-08de4c7309a6
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Ym4zd0FEaEZxMStWY1FxdTExNzVqT2pZbzQ5emZKUzNiNHZzUjNwVDhzY21v?=
 =?utf-8?B?SWszOW0vNXMvSkRPbzdLLzVzNjFDRWJCcXRCOTdYZ1AzYm1LL1kyUFF1Rkt2?=
 =?utf-8?B?SWtBaHVuQk9YUVo3L0ZOUWkzY3hBQjR3SjRXUjhDT1JCVDgvUG81NmVZd2VF?=
 =?utf-8?B?aU9pcm5nVW5xTHh5U3lPM3VjZTNodG16V21sQmR4dVozSnNZb0FMQldCdU04?=
 =?utf-8?B?ekNjYmxBMFNwUEltZC83Z1FPU2UxWDZpZUZOUnRkdHpRSTVCZFp3RXVRLzg4?=
 =?utf-8?B?RUFONGNOL2JaNElNV0puYmx4WDAwNVZjQk0wYUMwQTRwQksrYnFRMFQzTWVF?=
 =?utf-8?B?ZnhXUXU3M294TGw1V3hxTVkvelRaS21VemlSbkVlRTZKVGI2OWlDZWN0cDFH?=
 =?utf-8?B?c3lpVmlIeC92NTI1ams1RlVMdFVFckg1ZEFYN1A3cHROSjhGbjIvQzIranpn?=
 =?utf-8?B?SXZaajdPS0ZLSlhjU1AxTnRsVzZOMXFoOUI2M1piQVNEamd3QUQ0SytZR0xW?=
 =?utf-8?B?dU0yVTkvQlpsSkFIWFB2ayt3SHlrUW8wREx3RTNSTUthL2pLelRuYnllcXd6?=
 =?utf-8?B?UmdYRTFHcEl1V0FvU09SMDlmMEFlR1NIbXloUCtYN3FKSFN3UU9vSG9xUnFk?=
 =?utf-8?B?NmFMc09vZGgzL09abmZsdGFDOGM0ZWZoTXhFS3d6enJlQVl1OEI5L2NOV2ZM?=
 =?utf-8?B?U1BVSXdjeEpsS01OaHhpMlBMQzZnRCtHZU5lZklpR1lvSXA5dUxyOXB0WWtM?=
 =?utf-8?B?cmpOckxOV2pNK08yUXVzTWRBQTZFb1IrWWhlZkpMdU93dzcyNFcxbE5lS1Rq?=
 =?utf-8?B?QUp6UkV3VGRMeSt1dER4ZE5BQ3dDUE5tMG95SGUwSnJYekIxNGNpQjlYMlNo?=
 =?utf-8?B?VldCcSs1UG9iUnBVeHJCSVVvd2tGdk9qV2s4dlFPQWdON2g2UmF0V1FOOTBG?=
 =?utf-8?B?OEFXVXBtYkdRcXcvOXJGZlNTNi83ekdQV3NVeEJoc25oMEx0b0hmTXZ5UERq?=
 =?utf-8?B?enV1TGNhTm5yTmJRb21zY1AxNWkzSWJrNFZXWlNxM0x4TEwvYmRqT1luVG5t?=
 =?utf-8?B?dVVEenFXa05zUmpEcXdYTFc5bGdVK3VQMktnQmN1SmtPcmh6eUV4T1ZWZzdV?=
 =?utf-8?B?N3RMM1RwbTNQWGFWL0k4ckdnejkvSXF1NDcra2FEcm11cFp0NXUyKzNOamhI?=
 =?utf-8?B?U3RTWk9aMXU1WHZVUmd6a3N2OEcvMDV3NkttNXFHZzRoRDFnbGpyNG1KeWc5?=
 =?utf-8?B?ZjY2ZGdOSkVhSTFJRG56NmxrZHVZU1dxUVJOL3F4Z2Y5b0hqU3JSa25uYlVL?=
 =?utf-8?B?emozcEVVS1VtcDNMMGl4a2syaURTOHlBVGF6U1hGZ3FJd1RyY3ZYMnNlcWJF?=
 =?utf-8?B?Z3ZLN0ppUUZyOHJ2aHdKaXlyK0Z5NWhIR0E0MHRjN09HTHJZc21qRURybUoy?=
 =?utf-8?B?NTU1N1YwaXRJWUhpRWZIeFFSVk5XK3VubGloZTk5dStOcXBabmtMUFZtV0pH?=
 =?utf-8?B?eFhHMFI5T3FkR0JabWo4V3QwMmVZLzFRalNPWmp5Tm1CWEtmdkg2NkVCLyty?=
 =?utf-8?B?ZXM3a0JZU1RGSytRbXZaTk1STUNNcTR1VG5heXhvL3IxeWVaa1kxTllYdUZG?=
 =?utf-8?B?c1BmMjQrbHdFd25EZ0Q5QnV2ZXVhRGRXMUNsK1Q5VjFsdVE3cGZEWGplMmNB?=
 =?utf-8?B?R012aG56WEtBUER1NklCTkI5Tis3Z0VRRjYzdU5jTmF3ZlA2Uk1CZFdyWW55?=
 =?utf-8?B?M1NzVmZaTUxaZk9NeUI0VVZHZWJhQmRPcGtmd0M3eEx5aHpiRU9TT1RaSGR3?=
 =?utf-8?B?OWd3NHBPSitxQ3BXdllwRWsyZ2gyMFR0SFZOM3N6UGYzTWYvQm12ZExKRlZp?=
 =?utf-8?B?azRCSGthbjhZaWo1TnFUSU5MS0plYkwrK1BzZUVFYXZjWHE2dlczS1BtQTB5?=
 =?utf-8?B?S21acTFqNEd5aHFxZjhMUVJyb2hxSCs1NlRoSHRaRmFJUDlVZ2V6ZWxlYWRi?=
 =?utf-8?B?cnliTE93M1ZBbFBUcjRhckF2dXQ4UFpLaHlzVkVBQ3VWTW9vbFhEWVh3Mm1B?=
 =?utf-8?Q?TzA2g8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB5029.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2toVjUyZmJSSjBUcEpzY2FDVkhmQTJ2dGh3N3YxaXhiT1BEM3pzekRaYy9l?=
 =?utf-8?B?bVo0bWE5MEJ1bWk2VERZcTJ5TjJkSDM1aEVLZjArdDFHOTZQODhGNHV4S0Fj?=
 =?utf-8?B?UTgySmxyQzZ1SWwyRkt5TkdUSnFRd0xXMFI4UFFsSklBTnRQamZ1eTBqTUdI?=
 =?utf-8?B?QXc5cWdJK0R6bDd5K3ZoN3VRUVVSSDlQN05VVUN1YXhGWEtMcjBrblJzTnRN?=
 =?utf-8?B?Ykxmd3FOQlpES0doZndUbUo3anV5M1ZjVU43TlFZQjAvSVdieEc1SUx2VlZv?=
 =?utf-8?B?ZEFCMHYvTmVjSHIvMWJBUjhPb1BiUUZRMDRPTlRDQW5aOGxqaXp5aHRvNFdQ?=
 =?utf-8?B?eXZsUjYyWC80ZkVqSThURmpKTXlXakIvZ3VqK2tXdld0cFo4NmZ2b1ZFdGMv?=
 =?utf-8?B?Y1kwYXFaa2VYazk4MXB4MEkrcG1iRWE3T2ZuKzRaU2VlcitXQmlPaTNXWUNU?=
 =?utf-8?B?RWFrcVQ5TVM2TlN3d0dCVlJBekMxNzlmbGtKV2Ntdmk2Uk9ZazZpd3djMDhI?=
 =?utf-8?B?ZllyODIweFpwazdjNVpmRHhMd2JjT2hjbk13WTZrRVpiWWk1VDUydWJxTWtk?=
 =?utf-8?B?OTRJeGZnb1g0MEZHN3dYRUdOUE5leVFxS3BZNmlQeUx4LzBUbjAxUHVOcW1V?=
 =?utf-8?B?Vk9wejU2SEgzUUtzdnRKQlJLRmxQVjB5dDZRLzhDSTJBaGViMW1IcjFqNjVi?=
 =?utf-8?B?VkdIV1VSMzIvYkpERVFFZ0VINUt4N2h5S0IyUEpRc0N4R1prcWJLckJBdVVF?=
 =?utf-8?B?aHZGdFRDUGNvTlJvMjNOZDFUYXRhNDIxaHFIZzFqMFcvNWFjWExxM2oreFZp?=
 =?utf-8?B?QUthekNkU0RaQXA2S0VTd0dndk0zZFNVNSs3VVpsOVY2VG4wTkN0ZmNzaEx3?=
 =?utf-8?B?VHgxanZzVnNaVEQvNU1EQjZTY0dsWG5YMEJJWTRQbUkyMFAwd0c2RWJuUTV4?=
 =?utf-8?B?SjhYSFI5Z2hoZmlVNnhJc3ZXZEhmYU1ubzhnNDlRdWk2M01qd0pvQ09LNEdG?=
 =?utf-8?B?Uk5IUnJ0cnJsSFNXd2srK1ZjVkUxbFM3NnN2enFNc2lvYWZFZWxtRUpwSWJR?=
 =?utf-8?B?ek1SSFVINzNPRi9rM0ttZmRrZjh4ZkpMR2d0R21QdWIrQzVCNWxSR2xVS2F3?=
 =?utf-8?B?anZsK2U3bTFTMmRFQ0o0L1c1M0I5TFVabkF2TEdPNDlZQmo2Ty9yL0FJa2NE?=
 =?utf-8?B?bW1xZm10S1BHU1N1dnB4WU9xLzdweDdxc3Bsakw5NHpLcytJZndtdWFDeS9q?=
 =?utf-8?B?a3BLbVdzMUN6OXZrWGFFMWU1ZkVKRkMwQlVoeGtMNHViRVJ5ZUI3d09RU0lk?=
 =?utf-8?B?T0hwaks1L3ZLclROeVlqUkdHNXFMcnpRbTZya2c4dktpb1hPU2ZaUlJDTExK?=
 =?utf-8?B?bTlxNlM3TkVvUk1Ibi9XR0hNeW9vdFMvVG9MS0dkWFhCNzJlRHJZTWNFeVRU?=
 =?utf-8?B?VmFFQ0JjTGkzNXl0STZlVnl0UEFRR2czdTMzQ21tSzBZTEtzeHJ3LzJITHM5?=
 =?utf-8?B?aWNjbDloQTliYmRGdGdFbzhCU3YvL3prS3FVTXB3Z25TdTJxSVRlNHJMQ1VV?=
 =?utf-8?B?UUpidnZ6Um02YjJWU1cyald4aEtQdWxNaFNDV2R4ZFRheHdGb2tORERCMjhG?=
 =?utf-8?B?VjJTSkYzZmtSQ3dBZDBucXNWcmlwTjJaakVvUmE1d0pCQTM3N0o3ZVVWdUhy?=
 =?utf-8?B?ME1OMEdOTnBlU0lIR3dFaXpQN2NHL0N5cFhpZ2ttd3FpR28zNlByYlE0Zm1K?=
 =?utf-8?B?RUxzM0tvWUxHRVRyQjhMcGwzRkVkY1dPM3Z4VUZVOENzeXZuNjJXdUsvMnd1?=
 =?utf-8?B?VGR4KzhoTmF3azlDRi9Ka0FnUVlaeWx1cEZrZVRWZ3loU1ZPZnVuRHF2Y3ZI?=
 =?utf-8?B?cjVwd3dPa05qZ2dtc0E1M3dBTlVKUjU1VGJPeFhuY1daTjZYZEZ1VjdJeWY0?=
 =?utf-8?B?Vi9mdEU3Z3BRUGZHZjBJWTI4ZjhlZkViVlUyL0xNSnRrMzFKUTh5WGhScnEx?=
 =?utf-8?B?VThHT3R2NnFYYXhXY25ycWpmUzlQb0tIRTRrUi8xTFZ4WGsrTWp4ZnFNMjlp?=
 =?utf-8?B?KzVrRlcrNHlibTEzeFVHVUVqNWU5czg4WWxSa2tYRFAyUFRNZEI4Vm5NRk0v?=
 =?utf-8?B?M1FlWVk4dnU2dkNSNENEdXNOeld0Tk93bnJyWHVlaFN1L1FVaStBRDNGWENH?=
 =?utf-8?B?S0ZaQzFSS2Q5RXdIbFZjY0FwQSt3NWhtSlN6NHk4djd1UmRxanJ6Y3RrWmxN?=
 =?utf-8?B?SnVKN1lBN2VpVjhvMXdmVlVKamx5eGJHdEhNWEEvN2pFSXloOXVxWUJvS1Jq?=
 =?utf-8?B?MXhGQ0JPZnZjSjNoOVBTV1UzMHdSZEhZYXZjQUFBL3VuYk9LdGRoSFJJSGZN?=
 =?utf-8?Q?7MFt/4E+4+/z3WJE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99E42602713A4946950193BA8FFA4C03@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5029.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8227bfd6-9fc7-4828-7a71-08de4c7309a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 15:56:49.9090 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arMXNe9BQ0O062sbIJ+ZZeHX/Ne3UV/FnjkaqJRPQ21KxEvuKv3KsUAnCbd7nP+ti7/fJzEC9nXUw+CABssHPIGBFQzNsOjT1krMuwc0jzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR02MB11020
X-Authority-Analysis: v=2.4 cv=Wq4m8Nfv c=1 sm=1 tr=0 ts=695bdf43 cx=c_pps
 a=8YD3JtO18OBpAIphJ6JiAg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mDV3o1hIAAAA:8 a=KKAkSRfTAAAA:8 a=ymr5sMF8uohPVgZ4m1IA:9 a=QEXdDO2ut3YA:10
 a=GtYHaO1xT9IA:10 a=VxR06f_1COkA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 7khlPIPCpi2u1qMyWE7NWjIV0f7yilHA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDEzOSBTYWx0ZWRfX/q1Yoz5Vo/To
 gHPrMx4+0xLIA6Zrw3wGoaN3z8IDyo0BfmMih3cg3vEisEq0eT55OxcEhXcVl5pU5A70JcFZYCg
 icYLA8yWhuT3d61hdhmLBLmomYXzLALf2hEd1okB+OrXDU4XUxGNvEIISx5Jn9DSwSZI5Pn4fTs
 hs1mg/xNUlxIsOblLiyxacFswDVzixWWXySTX+mJDef458q6yj2l14nfVSz1zTxbWmVy+eK4XFs
 ZBu+PXII1XcbxO8wP1hnBTtmtsgc8+MB2YlpZheAyAQizKEhPGdjWCL7vzmGb2BpTyDyJBTxBeX
 lAgDY65kdUYntWG9zxz62iWwTzV6r29+r3HD7MnEp0WqRGS4G1GRtvA1m3AUsRqjZmYlcS4gAM/
 z3wq/vf0SwqvaKCQ+joMAgdAY//nXbdyJawZFkkO41yI0uJq9dl6c7ZHjctuXQl3OtLpR2e1JOk
 N65w1iPat9Re4UsvItA==
X-Proofpoint-ORIG-GUID: 7khlPIPCpi2u1qMyWE7NWjIV0f7yilHA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=yunpeng.yang@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

SGkgUGhpbGlwcGUsCgpUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudHMuCkkndmUgbW9kaWZpZWQg
bXkgcGF0Y2hlcyBhY2NvcmRpbmcgdG8geW91ciBhZHZpY2UuCgpLaW5kIHJlZ2FyZHMsCll1bnBl
bmcKCgp2MS4uLnYyOgotLS0KMS4gYGlzX3ZhbGlkX25ldG1hc2tgIGlzIHJlbmFtZWQgdG8gYGlz
X2lwdjRfbmV0bWFza192YWxpZGAsIGFuZCBpcyBub3cKICAgaW1wbGVtZW50ZWQgdXNpbmcgYGxk
bF9iZV9wYCwgYGNsbzMyYCwgYW5kIGBjdHozMmAuIEl0IHN0aWxsIGVuc3VyZXMKICAgdGhlIG5l
dG1hc2sgaXMgbm90IGAwLjAuMC4wYC4KICAgSSBkaWRuJ3QgZmluZCBhbnkgcmVsYXRlZCBoZWxw
ZXIgZnVuY3Rpb25zIGluIGBpbmNsdWRlL2AuCjIuIE5vdyB0aGUgYElQTUlMYW5gIHN0cnVjdHVy
ZSBoYXMgaXRzIG93biBgVk1TdGF0ZURlc2NyaXB0aW9uYC4gSXQncwogICBsaW5rZWQgdG8gdGhl
IHBhcmVudCBgVk1TdGF0ZURlc2NyaXB0aW9uYCB1c2luZyBgVk1TVEFURV9TVFJVQ1RgLgotLS0K
CgpMaW5rczoKKiB2ZXJzaW9uIDEgcGF0Y2hlczoKICBodHRwczovL2xpc3RzLmdudS5vcmcvYXJj
aGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAyNS0xMC9tc2cwNzUwNS5odG1sCiogY29tbWVudHMgZnJv
bSBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+OgogIGh0dHBzOi8v
bGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDI1LTEyL21zZzAwMTE3Lmh0
bWwKCgpZdW5wZW5nIFlhbmcgKDIpOgogIGh3L2lwbWkvaXBtaV9ibWNfc2ltOiBTdXBwb3J0IGdl
dHRpbmcgZmFrZSBMQU4gY2hhbm5lbCBjb25maWcKICBody9pcG1pL2lwbWlfYm1jX3NpbTogU3Vw
cG9ydCBzZXR0aW5nIGZha2UgTEFOIGNoYW5uZWwgY29uZmlnCgogaHcvaXBtaS9pcG1pX2JtY19z
aW0uYyAgICAgIHwgNDEyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQogaW5j
bHVkZS9ody9pcG1pL2lwbWkuaCAgICAgIHwgICAxICsKIHFlbXUtb3B0aW9ucy5oeCAgICAgICAg
ICAgICB8ICAyNiArKysKIHRlc3RzL3F0ZXN0L2lwbWkta2NzLXRlc3QuYyB8IDE0MyArKysrKysr
KysrKysrCiA0IGZpbGVzIGNoYW5nZWQsIDU3MiBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMo
LSkKCi0tIAoyLjQzLjcKCg==

