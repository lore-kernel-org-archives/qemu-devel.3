Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC00E73158
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmtk0-00077Z-Is; Mon, 02 Feb 2026 08:13:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1vmtjy-000719-Bf
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:13:18 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1vmtjw-0005tH-M8
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:13:18 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 612B5Yco3459176; Mon, 2 Feb 2026 13:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=yiyDxnAew2hRz6edgMC/N/ougldFlQEBa7HaqaX8JPE=; b=Eu
 YRTzwwjE+e4mx5y9sCSa8jhBBoQZapB6YBTsCtOLofXJdkL/759OE6SMAz84nou0
 2ZBNJclbIIuq42K1UEkLIe6BSAEYw48LhoGgiJUyygTChj6qDuRFIRLJzfVvfaG/
 H/dN8MwyvclbFUcv8/vKGTxq2rzAy/biaY85bHS04Tp4LQ/HVnaXutP04bZkGY9m
 n5hSqZ/UyeudVZJl5m7BSfRlP6PJR3woSRd2sm1t8WvBQ9GH1wJd1FKkzVCOTZy2
 Yn2HwtHc0RCh+LBb3xaXnmqF4INToLV1+SXit3Q6zQZIJcIzF9FpTW6GLVMX2p29
 4s/RDmct+6ZkfMqtwT/w==
Received: from co1pr07cu001.outbound.protection.outlook.com
 (mail-co1pr07cu00102.outbound.protection.outlook.com [40.93.10.90])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2trbgaqb-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Feb 2026 13:12:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lP1mCLRDBmYNVjWvSLGW+vdaFg8/1hjicY8zLw2RQFVc+RRfILC0hby7PAJo52k4YlZf7w74HgqqTNlRSwRjOXIaGEX1DLqG5MQLtGp/Y9F8812X+C3glV+lfbBwdEeiSxXGrOUaPvMxlfj4l08q36AZn+itmK5jsnveDwe/d15+fxmh+z/pH2jlQbhOypJ4XLWVzrwDg4lU8s+g/l1Sf/DBWOLLvacsD+SgiS2FEFwR/8g4JvUwScfCF3zTxApFKWmAq1Jy110cXaGJzg6QTZ7Wq23GSv/G4pCIK33qH1jWR6WvWKyBzywy3w2mH/g3CuDipZILnIMqVsagMVXQOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiyDxnAew2hRz6edgMC/N/ougldFlQEBa7HaqaX8JPE=;
 b=anPN5NTISVGdmvh5JLIcAeL9+AMcTUaXlNHUi03CNggGLDzHlCVh2n5g3hd1JfWHlE94F/0iZPde8JYoWo6Pqn7cLQeL45KpjEc5DUmxeWwc4DE1+s1Ho0dzhP3xrolEmgCXhGebnQANyXd63Ix3WSFSKiP3zSqF6rTEnnSj/lXluN3trO3ILxGBeD+LrJgnCgvYJgnfNpjtny9SJrYwNs1UbzYFU+51c0Ik1M1pocRSEEM00K43h3AXruhS4hXfdZoxRw+am+IFofzedp0W2sjDWU8zAcTvayVfFUO3vRJgydlBs53S9Qd+YBvichtbuwJxsaiEA3mc/llyiT5EYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from BY5PR02MB7075.namprd02.prod.outlook.com (2603:10b6:a03:231::9)
 by SA0PR02MB7129.namprd02.prod.outlook.com (2603:10b6:806:eb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Mon, 2 Feb
 2026 13:12:38 +0000
Received: from BY5PR02MB7075.namprd02.prod.outlook.com
 ([fe80::9796:c2ce:df6f:6674]) by BY5PR02MB7075.namprd02.prod.outlook.com
 ([fe80::9796:c2ce:df6f:6674%3]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 13:12:38 +0000
From: Mark Burton <mburton@qti.qualcomm.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
CC: Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>,
 Anton Johansson <anjo@rev.ng>, Markus Armbruster <armbru@redhat.com>,
 Brian Cain <bcain@quicinc.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, "cw@f00f.org" <cw@f00f.org>, "demiobenour@gmail.com"
 <demiobenour@gmail.com>, "dhedde@kalrayinc.com" <dhedde@kalrayinc.com>,
 Eric Blake <eblake@redhat.com>, "eblot@rivosinc.com" <eblot@rivosinc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Elena Ufimtseva <elena.ufimtseva@oracle.com>, Auger
 Eric <eric.auger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>, Alyssa Ross <hi@alyssa.is>,
 "iggy@theiggy.com" <iggy@theiggy.com>, Warner Losh <imp@bsdimp.com>,
 Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 "jidong.xiao@gmail.com" <jidong.xiao@gmail.com>, Jim Shu
 <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Max Chou
 <max.chou@sifive.com>, "mdean@redhat.com" <mdean@redhat.com>, "Ho, Nelson"
 <nelson.ho@windriver.com>, Paul Walmsley <paul.walmsley@sifive.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?B?UGhpbCBNYXRoaWV1LURhdWTDqQ==?= <philmd@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 "wei.w.wang@intel.com" <wei.w.wang@intel.com>, "z.huo@139.com"
 <z.huo@139.com>, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "zwu.kernel@gmail.com" <zwu.kernel@gmail.com>
Subject: Re: KVM/QEMU Community call (3/2/26) agenda items?
Thread-Topic: KVM/QEMU Community call (3/2/26) agenda items?
Thread-Index: AQHclEUrPd9+YpdeKUGudF8vHiaYfLVvYpwA
Date: Mon, 2 Feb 2026 13:12:38 +0000
Message-ID: <CC3A2487-B79D-401F-B5A5-EDC8CE3F6C1A@qti.qualcomm.com>
References: <875x8fpa0x.fsf@draig.linaro.org>
In-Reply-To: <875x8fpa0x.fsf@draig.linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR02MB7075:EE_|SA0PR02MB7129:EE_
x-ms-office365-filtering-correlation-id: 707a6a1d-7070-4a0f-1144-08de625cbd1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?ZTRqd3Nocm9sc2ZBQjZueWFxenlpeXh1NzhJbzlrc0RZNWNDaTlTT01YTFBB?=
 =?utf-8?B?OTQ4d01hMUJrTXZ1amlGMC9lVXdMNUhIMDlUVE9OTFg3L1VzQk03Q0kxY2lx?=
 =?utf-8?B?SVhuYW8vSk1tQktYWGI2MUw1L3huRzk3ZE5tWVMwSHkya1JUaUdPQUxXMG5v?=
 =?utf-8?B?SStMVVZiTGpVWGVmOEVFdUs5VjV2SmdSS3RVUmM2aGFxT3l4NXhCUkt0WDd3?=
 =?utf-8?B?USsxSWk2YmFPYmdZaUQrbW1nZWcvampCUnlBSmkrbkpiUnZyaCsxMmhjRTB6?=
 =?utf-8?B?UEMrNmZZK1ZaSGhITWZGTy9FWGNzVmp3S05ZYzVHb2p3SW95dVpPVlI0OE9Z?=
 =?utf-8?B?WHhIZExXQk1TNS9PdHJ0VzRQcFlZbThFY3ZpNHpUbkRHZCtQdHdhdHNBTTRw?=
 =?utf-8?B?UnJtZzZXeGwzNjJhSTlQTDJUNEdVVTFVNDlXeTRyQ1N4aU5Ha1FkaDdEWS8x?=
 =?utf-8?B?WkNVSFdUTDdLQmV6ZE5ybDdzaGRsNVluOHBkbEJvNEZpcWQzUnJEdnlhVXZ6?=
 =?utf-8?B?MXBvb1FiTjZwd1p0Y0o0dnNtMTg4YXlLYmU4SkJud2xIUTJLdnJFbU1jd09Z?=
 =?utf-8?B?cE9mMkVFSEdhNnlkaU9xQWVmdzljaFJJdzBKS1hpYzVCVkljQlF1czZwM0pT?=
 =?utf-8?B?ci8vVWt0SWVoRERuZHlDVlVvN0pZeTRMc0c5NndEeDZ6M1A0QjFRMUpHQ0V4?=
 =?utf-8?B?eTlvZU1XMHRWWkFsaDI0WkdwMHFsUlJSelY0YVhnMkpMd003OWR6c1NqSlM2?=
 =?utf-8?B?MlpidGpHZEsrRzAwRkdQUGZTNXJuYkdQS1hiY2RSeEszQTVQNTZLRmJUNk56?=
 =?utf-8?B?L1lCK2ZpVTlmaUFLUnhMeGJkS1FRSW9uaXlhcDhPQ2lxR1c4cTZIdDR3SUtq?=
 =?utf-8?B?U0IzYXAzL1VDdGNjY2xOcCsrMk12ajBIcVRWdXN2b3lKb2ZRd0tCaGl0eGV2?=
 =?utf-8?B?NU15OVozdHp3ellod0U1WmovbjBzNkVnTjFqUXAzQkYrV3QrMC9GSitXRXFm?=
 =?utf-8?B?TGVidE9kR0dYKzc0bWJWRS9Yb1cvYVkzeExvOG5xREMxU2dNUlU2N0pZR1BO?=
 =?utf-8?B?WDAxYlZZRjBQL0VMeDJxYXB4WmprS1RUdzBxZEtLelNCVDk3NVdmSHFoeFgx?=
 =?utf-8?B?Ump6WXRVSit1YjFZaXFXcVByeSt2Q0dOMlV0eUVNdU4rUU1pZW5wRlNzK3dN?=
 =?utf-8?B?MWFlZSsrejcrejJVWENKNVlLNjI2akZoSGR2OVN4QVlzNW92YUNjRWdvY3Bz?=
 =?utf-8?B?Q1lyQ0QwNnVaYWVuZDUzVFhBaVVPT2ROc2ZkTnNabWw0Q1BDL3FBQnE5MnNR?=
 =?utf-8?B?SUszWVNFZ3ZIblM2NGJjeGhrMk16b2dHUWl6SnVhdEg0Z0xGbHlWczJuYWpr?=
 =?utf-8?B?dGdpamhtY2w1YzhwVy9mWmhlbXowbFlDRkRtM054UXN5a2FiM0U2dzd4b3Ez?=
 =?utf-8?B?OGl5R3hBNE1aZXBSZkdib01jelozNlFETmNUeExCVlJyN1pHTEVoRGNQMlBU?=
 =?utf-8?B?eitXS3paamtxY3hHcXhJUkd0YksyUFladXkxRng1am5BS0xKUnZmMThIV2lO?=
 =?utf-8?B?OFk1UklOaFNYb0drZFBuZE5VLzJvTTY2UHcrUmxRbTVsVkpYbm9Jb3hYbjBU?=
 =?utf-8?B?VVBLYlBuSFNmV2xUdVBrbmFEdG1ocEdqd0E5SnNHdHZMVVJGNGpCVmFmSEZu?=
 =?utf-8?B?YkRkOElQSTZPQU1iQTMvcVVmNkIrVzQ0b09ra2NyZ21JYmg3SnpsYkhpTjFI?=
 =?utf-8?B?WjhTa2xRTkRDSko3cUNrZ3pUWWN3K0lSeHdIbUJYVkRmNE1odmtnZG1EN2xX?=
 =?utf-8?B?ZG9XQUQ1WXl1QXRZdjMxSGRNQmZ1Mmh3K1JWdHh5dHhvZzZxb3BESVNPVGRJ?=
 =?utf-8?B?VkhtaDRodHhpQUJpaDFuUXJGS3NPTVJHbElYUFliMEN3T3NCZG5rQzNWbUdl?=
 =?utf-8?B?SDdRMi9LbHhlbkwzUEoxYnNEODRSOTdMWTlIeGN1c0lJZ3RmZStNYWtmZERH?=
 =?utf-8?B?NEx5Mzk0U2ZYbStSMXJSMHhQRUlCR3hVL2JROFZHcGs3a0dWclR0enI1ckN4?=
 =?utf-8?B?aS8xZEUyQ29Jc1ZXUjlpamh4K2FXeUVTSWx3Y1R6UGFZN29OcVprUVVwWmU3?=
 =?utf-8?B?NnQrZFZnQkc4K2l0UEFEbkNadkw2dC9zdWJRWXM5aEF0ejF1SlF0TFRZbXBh?=
 =?utf-8?Q?zaMKQzZv/pdE4ciqpTNJXH4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB7075.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TC9henI2dk5RNUZXb21XTTFQQmk4VVBhM3JYeDlta25UTFIzeG5XWDgyZVhZ?=
 =?utf-8?B?VzhCU0ZLYVdyeWpuWUsxbEVJWm1iMHkrRVUxVWFHYXBtVWM4bUJwa25UTUl6?=
 =?utf-8?B?VkcvOVJ3UlJNcEoydWtNMEc2TlZJSHorSEluYi92L0ZZZFByUnd2Tnc5S1Ni?=
 =?utf-8?B?dksvQnFydW9KSHlkbFZDc1NtYWJKbDQvb3RObE4rZWZVcm5yd0RZNEJxVmhi?=
 =?utf-8?B?cCtDdmJRQWhXMnhEckRNSHhIYWRPdUtTWjdhME1TMzZVMFFacHJYS0RmOEJo?=
 =?utf-8?B?VDN3M3RmbVM4TkRZZDdJZlNDbU5aRmxmSVo0Z2QxditnblNWSGt4SU5sc3pI?=
 =?utf-8?B?bWVrdXRoYzVFZnp1MXd2VjgwOUpKbFBad25OeE5xMHJick5MN3FkRS9NbGI5?=
 =?utf-8?B?YmtPRnZvd0V2VURFTW5tWXZkZFZTWS9TWEtnSUkwbTJiMGxyRE15LzVyQWtR?=
 =?utf-8?B?NlBuRVVObU1ROGNLR3IvQ3hSaE5ldDZGeWdFSjFKYlpTdVpuWjFxQzFqVDZx?=
 =?utf-8?B?UDlPQkNUM0w3UndTVmg4MkwvVTBVUGdFM1dmZ2l0S3dodW1vU21OeWZiRFB3?=
 =?utf-8?B?bVM0aS9BekR6OS9mdTdqNEtCQjBJZ3ltN1gxeEFjZWNvTmErMXZTYzd6OE1B?=
 =?utf-8?B?a0d1NFo3ZUFNdEx1bFVlTlNaRlhXSnF4MXFFVjJJN3g3L0gzNXFjVVoyWFZL?=
 =?utf-8?B?U3VwSENtMG9SaW1PSHFvRlUwVHVpYjZOT2JGQm5pMXoyZS84L2F0bjRjSlB2?=
 =?utf-8?B?cUEyYzRlaXNhek00WG4vY2lnNmlWTUZUNVB5MkVCYWlrcCthZmFydUlBczN6?=
 =?utf-8?B?WENZZ1V2Yno1Zy85WWV3SFpNZnNKaE1oeVlvNmVWVnRsQ2ZWdkNQVzFmUmdO?=
 =?utf-8?B?bmk4Yk1FZUVHc1BIWVJBUmIwVGp1OWkzZUQ1OW9pbjdSZDErU05hTUh4aVpT?=
 =?utf-8?B?ZXpuY1l6dzlJbGFWdG1HVEEvcmNPczZNLy94bElaRGRDSzRyRjM2b0gzd2Zy?=
 =?utf-8?B?NXZML09USWtLZVR6WWZqRS9vdndBR1hpaWovUU1MdkZrVzRlVlBPcjRKQmFJ?=
 =?utf-8?B?UThYTGdGWmJTd2gwUysyR0xFa3pvSkdCeDJiMWtWSjRtci9hY3hQRU9weTRC?=
 =?utf-8?B?NCtOWDAyamx4eUlROCtjL0VPVStJM0FKdFlqOWVBQ3MxK0dnMTdZMWtNZTd0?=
 =?utf-8?B?d2Rwak8vWEJSamtFNzYwWGxWUEpNamNYVHp1MERZUVVlR1Z6aVBLK2VpQU8x?=
 =?utf-8?B?VHZxbmRUS0R3UDBWanphSHFxbU56cXppc256SlQ4UC9vdlBFSk1id3U5Unp4?=
 =?utf-8?B?aGlGNHRZMFhaSHZkQUllWWJGT0hvQXhtZWRMWHVWKzlrQ3N2WnZub0wwc1FK?=
 =?utf-8?B?dUx0emtRKzB5M0dTTlJVMXRCa2NHMURPSnpSR1NUdnIvRWxIL1JKT3c2MUdv?=
 =?utf-8?B?S1d1b1ZwQk4xQmwzU29YQ1dWNHdzNHdPL3Z6ZmNPczA3Q3pwVGJ1b1RqaG9T?=
 =?utf-8?B?VmZjeXVXVExXVnRwMVpTOHo2NEFHVUtVU0lEZkRTZHNXZHlBeG1zNTZhbUdv?=
 =?utf-8?B?ZlRRbUtUcnRLZnJGK3FRcU9zU1prZnQ3d1dGT25vN0pSTVlQQWI4Q004bFho?=
 =?utf-8?B?NEJGY3ZIeWJYaS9yVEUxVTR5WU1vZkpkbElZMXhjR0Zzc01lWjRZNGZKdVJu?=
 =?utf-8?B?UWNuM3ZZS0p5OFJQMmxWbmNhTWQ1R3lUdTZxMjhqZWlHSmNBWi9mUGtVWkFh?=
 =?utf-8?B?T3RleksrY0xnTW14ODU5bjdpRjI0amRrcUl6UXhNZGFiNjY0ZDMydjY3R2dI?=
 =?utf-8?B?SFVQLzlmK291L09XR3pYR2ZkUVRXaHZmYVRkL0VSMEs0YzRyVHJ1MXI0ck0x?=
 =?utf-8?B?ZjV2SkVaRFZqeE93SDhZYndVaTFrOUxIb2RGaUlLTUMyQzVxQUhMbnZ4ZGdE?=
 =?utf-8?B?UHRyQmpOWjF4Zm9ERENRd0xLYWREc2dGNjE3TjVoZ0tka3lnWHFEYkRDQUNR?=
 =?utf-8?B?TmQvUG5SeW1vS20xY0FrdXUyU0pVelR3YW12ZXVydElQVHRYd1FGSnNod1ox?=
 =?utf-8?B?ZkFiYjBhVmJzUlduU3dvT2MwOEVMLzlQZFh5cE5FMmtneEFCTkIxQmpQc0dj?=
 =?utf-8?B?b1BVUGF5Um9ITXgva3R4N1JIZ3dscXpxbEY3UHF2UFhoWlh5UWdUWmlXdmNq?=
 =?utf-8?B?bnNlc0JGQmVxemlMQUcvOEwrWXRpQzNzQjh5WFE0VW96OGNtb0JBbFlFQ0V0?=
 =?utf-8?B?NWVxSHd1bTVsZHlOWG9MWEYvQU5scFFsVHpyd0NTVGRjQTdybGVvZkZrRVZp?=
 =?utf-8?B?SVYwOFpIaHZ2b25mZVQvRmx5WlBNcVQ1OEdwcjIybFpjNmRmSS9NREoxcVEv?=
 =?utf-8?Q?8/biMUC7VlnnBEjc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C6BC7B24CED36408361655378F4FF3E@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Vm5B2x5zYwdS63gc/Eu5H5uTGJAboV/9BMPyN3bYUhawnV46RLSJ6rmJ0owaQnz+AsEdtwkOdRjDeOIHnD6F92HNTmo4aBzFvi480QhI/79+06keSRkn+kDdQdaG3CpbH5GpU1WZieKyEO0Uv1qT/rA0j8sDWyF2CMJie6TLx+Q4UCBrP2kWlp0dVFBMu3CkmUbIrUSZQo/HBdUsm/hLg0OnpvkNoTwFZ7BIK7RAY7yUYwVogE/VQD4IPtYsWTB+EFhha8kNtpFfy354C6vtPAzYrSUzuKI8ekIW8/PEHpm0ASti1aLrBZw8rGeVbQJUmK6RNgDUKheJXKeB8BeTWBGBCxrFgWH2+ch9VUzhgzo88X6pBdk0NRaVcuDxJpxSxitLPsjj2bVbs+MxpPzQaIrma6M2kSx1A6laoO80jjOP8ZJgKj1rYk/dNkbVUN15PgCtfUDKfyGnqhyp4rHGRKNPlXZSqaojBG072sh4zmyyb2spDWpMV/fEpOhMe+orc8wpB9PsT/fxAyPGhxpdXjKNB6D8wSMqqoXRBjGpuXNi1Ztyoc085Am3c14Cyxsu+TZq2vRfrGe8h+yy2QCk7A0k9yXMAeOm6KVkRJH2I6PGBItl0ia+L5OP9duovpvB
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB7075.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707a6a1d-7070-4a0f-1144-08de625cbd1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 13:12:38.2009 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xS3bl3N5fOpnqcADjVDzsAQVQkQpWbZ++00DQLhR4K+LlOsyB+7/rBLXS9akKbu63vZO2Hq8MARphsHoTEsZJFH1h2VR7RljcnwVlC0EOs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7129
X-Proofpoint-ORIG-GUID: gzJU_v-ERG8JTXsYK9ZkgV4S0A9LEVju
X-Authority-Analysis: v=2.4 cv=dcmNHHXe c=1 sm=1 tr=0 ts=6980a2cb cx=c_pps
 a=s1B6KbOLKPxgfRSf6UFSLw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=nXA5WNwiAAAA:8 a=KKAkSRfTAAAA:8
 a=-aPEJqwakmsKeLF5d2wA:9 a=QEXdDO2ut3YA:10 a=fGr-7aqQv4RST94IA8XU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: gzJU_v-ERG8JTXsYK9ZkgV4S0A9LEVju
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEwMyBTYWx0ZWRfXyCet81a91v1g
 OGqPXR7AcuCra/FK4lJc1lR2O+G/YrfG4m+o/JIxMUW7ExHFHuBfjrb2l+F0pQm6QxRfDTF8TEt
 cZMIfeqmUllWbTrcud7/Sw3SL4K1OcmJAN6x407ykkCp5bIwRIJtwO+jIk4hw0LdFuI0nMUCJiP
 IJVPdz2ZyAK3ZhWrOlybdOqATfoDFfpWMR1/gZ6Uk65ZNKEJCrT/7PUtrxpBkNPl3fAwI0Au0Ib
 CRkp4hChoO32IONZqSXKGetZaCKVG/hCvrB9t0rxnrhgXU7hjbrKx1Lc4z9S0txWA0gB/IuRhS8
 9bcvNzRji22VrjOO0AXkHscIqIDMvhLhusgn4WPYUliOp2AFs9l/ddEwJljpjl+N2l2EvJi+Equ
 TfwqtJRqtXNDSGSJqI/mf5OIPrzViN1hzfsKwU8pIKr1sEusYArFmA44BkKqFXKQXcLQIBFyaxy
 dyaDEZK9e74kKxBoWYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020103
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mburton@qti.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

SeKAmWRlIGxpa2UgdG8gcmV2aWV3IHRoZSBUQ0cgQVBJIGEgbGl0dGxlDQpBbHNvIG9uIHRoZSBw
cm9wb3NlZCBwYXRjaCBmb3IgSU9NTVUgZnJvbSBKaW0gPw0KDQpDaGVlcnMNCk1hcmsuDQoNCg0K
PiBPbiAyIEZlYiAyMDI2LCBhdCAxNDowOSwgQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5h
cm8ub3JnPiB3cm90ZToNCj4gDQo+IFdBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9t
IG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5IG9mIGFueSBsaW5rcyBvciBhdHRh
Y2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KPiANCj4gSGksDQo+IA0KPiBUaGUg
S1ZNL1FFTVUgY29tbXVuaXR5IGNhbGwgaXMgYXQ6DQo+IA0KPiBodHRwczovL21lZXQuaml0LnNp
L2t2bWNhbGxtZWV0aW5nDQo+IEANCj4gMDMvMDIvMjAyNiAxNDowMCBVVEMNCj4gDQo+IEFyZSB0
aGVyZSBhbnkgYWdlbmRhIGl0ZW1zIGZvciB0aGUgc3luYy11cD8NCj4gDQo+IC0tDQo+IEFsZXgg
QmVubsOpZQ0KPiBWaXJ0dWFsaXNhdGlvbiBUZWNoIExlYWQgQCBMaW5hcm8NCg0K

