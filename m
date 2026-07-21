Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC126C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm9Yw-00089r-AJ; Tue, 21 Jul 2026 08:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wm9Yt-00088c-Sv
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:27:03 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wm9Ys-0004me-9S
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:27:03 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LARHFS3272672; Tue, 21 Jul 2026 05:27:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=UDdkWSOJeYJ5V1Ep4aDQfwgtNKsGAOKXMpT3tM57W
 aY=; b=TDjac7u0b0vzlXTZ/tv0Zd5UhldVoqv7RrGd5rxhMnADPgSf3q0HR7qKQ
 8Ksmm8AHadXax/Oq1dITGJvioeEJo+HZMooH7ildc+vud6chY2m2GC1Pq732AoxC
 54SLnSRf80mbUwi98s4/UvFpz+AM4SeSN6rSYuTy3OVThN4hebF1eRrBiQGK21Jb
 xrs9JaGV6ZP7xf7or4cDJQANsJIn5Y2JY4uCv4MiRTjmERDkZ235rjvyia/SlN/U
 LUkmnl5CHtRLeEZeHzuW+rf/hmz0Qe8CuDLQX2k0KsRVirerMx0leZeUUTFqz0aQ
 YlMGl1Z8OdE1/LwUsM1FJsjiN+PSQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020127.outbound.protection.outlook.com
 [40.93.198.127])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg8fspbfq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 05:27:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dhgk9GlCeVxEB0/NZQnwLYpAF7m8SLDj5uaCB6Juf9aSnJrTwE3rstVvuWIlvtOnVetvaJ1DY8NcBzDlL3OOzySxZ3D8y9xZ7G6wsQS+Use4pT9yz8ibZKTZdD8eZx7irlB5gyrmIxFQTzvXbnTBY3uVWEfygjGHcbwEt2/e5/OqJtMk+QERYD4XNQywpBj9ZlCIhB8HSv5kd10oNld3KWwContzF/sExGkyQD/X9MXUfe3Zf1ic0wRn9BTwpgJ2WzDObDVqDEP8gIWMuRNGzcSs8NPUQ8DAST4Dg3O57o2tTw0DFF4iXTnFUrO57723SloQppU3sIM3P5PTWruQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDdkWSOJeYJ5V1Ep4aDQfwgtNKsGAOKXMpT3tM57WaY=;
 b=bL5nasPa6UtAP+2vrZ8W+hTFSq1YXA1aATKxNu0TcsWScV5I47yYpCGaivNw/KWEYOM/HUha1gbqP4QYyQZa5dm5BrqjdovTZguwj7CVsRxlb1H++GTzg2nXREkJHeiTgYHBkvISMRucQHsK8Qo3bqNsyqWQzkRxO2EKzrq+CMFA+j6WkuGNaJi/+XBr7HtudgWyKKO4eWTL/hYhgWjARgIcr7/D52EpIlRO+c8iJKGuMcwKd783S+ym8ZEn8Po7S0abQP0FQ3OmWd/nqm5acoNS+b4UA5r09zY3FTIvHpmDenspXqEHJlHiuwy3LuSyMSGYtirGL7W2WxBdODU7wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDdkWSOJeYJ5V1Ep4aDQfwgtNKsGAOKXMpT3tM57WaY=;
 b=U56WJJ3GX1D376w6qvFvIpI1zpABSVR/VdL01XzXghndY4JAddP6qy7iqUlpT36AjA//HG32rvpLFFejaRuU8FUW2v+AA6zwaEsxctO4E07GTAwGGH6POwAPniTK2yNUg6VbzshI458UoGMXaa0qNPZhN8EbfoBlLkAs5xBgrXNqFXxsJgmFQMmfJSNjgKhxM2AIAlkTXlHzUoiDGtewRLZiXkDKa9KngxG1ymJyDSk+bw/VJga8NGLtgv3A5MxId+9LoDngHduImxsg0/LjxJju7sKnSYg9igTMfS8NJZHcj1IkjDjxRacqq2QEgdp/Qj9bJupiddhFfw2ONc3lNg==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by DS0PR02MB10249.namprd02.prod.outlook.com (2603:10b6:8:1a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 12:26:59 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 12:26:59 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, "clg@redhat.com" <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH v3 7/9] vfio-user: vfio_user_device_io_device_feature: prevent
 excessive malloc
Thread-Topic: [PATCH v3 7/9] vfio-user: vfio_user_device_io_device_feature:
 prevent excessive malloc
Thread-Index: AQHdGQw5szpTdEQiuE+Zx81YVplpKw==
Date: Tue, 21 Jul 2026 12:26:59 +0000
Message-ID: <20260721122643.30985-8-thanos.makatos@nutanix.com>
References: <20260720135823.21070-1-thanos.makatos@nutanix.com>
 <20260721122643.30985-1-thanos.makatos@nutanix.com>
In-Reply-To: <20260721122643.30985-1-thanos.makatos@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|DS0PR02MB10249:EE_
x-ms-office365-filtering-correlation-id: c9e29e15-54bb-4411-5794-08dee7235c7c
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|22082099003|18002099003|56012099006|4143699003|10067099003;
x-microsoft-antispam-message-info: 76gOg2GMwK3lY9cHJ5TEaeq4ozok66cCnRMa/4KRx1XLBugnwcwdfzBizh4y4c87YaSuU4I+mGj9J8I9QL++Yow84bCXv4BZGaFaNT75bzi6D1v4923cSt7bLv7CmTsMIiyEhT1NADSimhbxCvdBT+6S3HCyjCpOiPsedU0zetHpErV3wyCMT22iVoGTStgVDbhvtKFrnFQ/ekqAr4IqN5jk76dADIG7ftrJ0YtoNaW+rGx2p5WUWRORgLhJH6VZ372U0YrFUKYTJM3RwOt6v5ts7XFxNZ7MVeftHIW350rNUSmuSbexDiX4c0lRW+3dYK/WtnrdoWozpx09RWh8HjCX9dxEE+8/3Klh2p5DysPBCzDeuwVLxEq3PK4xlxoAwaxiv050TS9EYX51S0VoiTeH8MIB5+ZyR3DyOPc5aRAKW2cKX7Ama/qU432WEZlTKOxtRnTV1Td6MVELufU+GMQOcytd5Gk/YFRLCvncBjWo/hmcyrVrMOvKtfvYq+FrX5JeYcVYd7dxbRlEQKxHjvUZJXNdqIdU9R4edmf/yhpzH6k9TqWiiMIRP06fgehKh/qHP/9xB2iDnnK+Aulvrfg3VTKxqs/1yrGOApFHib4QFfny3iofWkid9XNVoiHWVGkzKPQm24RUOahf7GINebVM2ZiracOZ/tyw4+HTdckedwn1gRrR0GL7dBNZ9YieShZi4lgW+qYrNC4lARefHERpbzB+bE/CqAdf3W4sQwk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dGJLApbkpgdsIAH6fQnCWvrdHUp+IOeZJH/N8ahmTJG8ZLcjrtXnTeZMlr?=
 =?iso-8859-1?Q?10teOtf5j8soeI6uByl1cYECT9G+CbTnHgrnJ3rPM74pEB5SRqNqc9LMsM?=
 =?iso-8859-1?Q?/xf2+Y5p++ZlUT39V3eYmvzCbkYhKo79TTW/Jc/cP/msiMo1Cuh3gzX8lI?=
 =?iso-8859-1?Q?Zrk0+rHCvDVgH46V9x9PGzAdzE1fcY01l+Fpl/+UgNeVphk5RJD/V0nS0J?=
 =?iso-8859-1?Q?pAYpsVzk7V4V/icSvt9wt/K4GE4J+WnUm3rxYWy/6/ctm2gVZggHBwYb5n?=
 =?iso-8859-1?Q?A4miZOFmqZkb/oGik7B877uDh2Ip+0evb17I6w+MfRsLMHznqvtcE8g6M/?=
 =?iso-8859-1?Q?2uGyXgcm9NnWoSCchoJCEhxnYaLOroWY+SJi0W77dywvkBXn+krKKZmQT4?=
 =?iso-8859-1?Q?SnQH2Fyyt9tzR2hpdk4xjhXmExD06YmrMqiDRRCzQXwpEIE9eaaa8VGfnl?=
 =?iso-8859-1?Q?px6mrktEHGYxYssDnVQg+afL0w6NY44/LlKLW1Dt6DZy6erZ9F30/7EJTa?=
 =?iso-8859-1?Q?8U3Rw/BJgFq+mv4xdpnepMky9LTKuxKdVhLXc05Va6Ty9dXcYJd0Zo9jHx?=
 =?iso-8859-1?Q?DSGPNM5E6gm2u3EyVfLdPPih10MJ39tzGWOFozkbhOc0XzojQRdRSefbsz?=
 =?iso-8859-1?Q?oVSUzBr7vsYc/iQt0rtOuVkfOsvpu51Vp46kODkktH0ZLxKOXeS/oLZLPB?=
 =?iso-8859-1?Q?0xJ9Jzx9zuaV9/vNeQnxsTDOrugS+xKFC+wDmWmJR2yvkFFsP40gBOPqaj?=
 =?iso-8859-1?Q?i7OEh4q7sYtaLaMU5neiQQAWFku+Q2gqP7xlfarxD2QKAda7xfmiKSrhfJ?=
 =?iso-8859-1?Q?K3qhkqrbzftbsWNeN1xkRUrllekCQvrGDYkzN1yZDosZxSmcoJUGb5pEvm?=
 =?iso-8859-1?Q?XzLN2e9lV4sEd0aNWH2W9CYOpJiTShuDUFgWxy+HjSWpHGxKiGh23Hx9ir?=
 =?iso-8859-1?Q?O7ejays2anQky5Zi514pZfPXbbvJp7SgK3COWmf1v3Qdc23IOmV32qcacW?=
 =?iso-8859-1?Q?5sm226krIOcdlgfBXojqipaH7UmpQ5JUPaTfSVrR6wqY4lUn+PByOfN0xA?=
 =?iso-8859-1?Q?oqvp8I14UJiVsreMWpT0VnG2khPLtQspOsbmGiHSlxRujSHFBbb6Z6aExJ?=
 =?iso-8859-1?Q?Jw2e1vdLQvRppnHBAWhsBwz+JVgmUNLPYGOaIiiYMwN5wG2ev9WAbFXjwk?=
 =?iso-8859-1?Q?90yr6aYkEC+XUJ9XXY1i+/KDUJ+deygjNojEpzphStsJOGeFlvyQ9AR0zI?=
 =?iso-8859-1?Q?HTgnT6VJMfmnNB+JVrGwMtSx6XTYf8G3mZDZJNoIjf14GUwEPsZvVfF2aO?=
 =?iso-8859-1?Q?ZRIxuGUrgzhv5QHeDLx0j7uIhplczvNE36FP3G+f9TKddKl+C858OMqeVl?=
 =?iso-8859-1?Q?q0fHNeLNs5N/3UF780JMffOkItHtP9eYOugUzVmGTovXpZWnSfO4cXa3R9?=
 =?iso-8859-1?Q?USo7ZdpnbR+3oS4irBD8loecLvGtIgW1FQSlWPd9TFnCdFG6JL/NQDoPZL?=
 =?iso-8859-1?Q?kDStG93YkAkEd6KPWAPTN0WEHvAeN1BsSiOrSQ/CPjsQ+IiXWTAYtkkGtT?=
 =?iso-8859-1?Q?VYvp35tMbNN5K61wbCTfm5aSB8WFTJEqPwvkvk4sCzyctR6uBL7C9IZWpD?=
 =?iso-8859-1?Q?K8osf7SV8D2hX9d70LNiXbAIPK787EsUiWV4kE+Yi9A5NymlK4ZjMSZyij?=
 =?iso-8859-1?Q?j/3ew3urN8//1NeAIC9XWKrZd/xFSyfIFNNEf1u/50wN6zhK4CbDPz45uD?=
 =?iso-8859-1?Q?ZP05y0KDi0xhRSQesM/cL3U/iM5isKwryPQY4QxNFzkG23CP1oN1lKTsDN?=
 =?iso-8859-1?Q?oFiq2kFGhDn8+LDY+ErXtyhlq7rL5d8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FFT86l1aXSd06DuwtOT+MfDIjqpmCFkD8CrkUTcXHh3Kk9BTu9p9fwbs0J0HU/7qx4uF4ZV3TUgm5YCW7UKFYa2k0UgxYqg8oWGEnk0ZDTNFxI5GU8qz+A3XIe/KwWDlnyVRpQ5rHXhKpYvEOIoKynrn/xodJ74DA+fjQj7NLuqoD0kZUC/s2TlsX818a/cNBMEqzefUOOMRLAtSih+MknxjgpWgCEHVuNd1X+oJZbmOdCUWGXL413rm7V/+JmnwkXAz4syl+BzEjZ0/Cl4D+a0SWwvZfAS1jssfbvBxNLAz/EC0dyCgDmcRUrrZiXCCT47IDsNyJ8Om2p9UCzN7SA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e29e15-54bb-4411-5794-08dee7235c7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 12:26:59.4552 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P1skPELXw55CcwI08re0CrwQzJ1LwM26eM68kcsW3t5I3DRAoJ7whw76hNxUfuFEqk91AdiTvNJOPUYQHB0jsL3aq0SqAP5aFHmo016zX+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10249
X-Proofpoint-GUID: ld11lPUFfgDa1IjLl9Na3xAwoZtiSZrw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEzMiBTYWx0ZWRfXydfLRx5pyBmy
 quWEsYkRaAVAKx7OeH5k7BqtqKPXEgrtmCW1v3RKgg6/jfgXf8FLAnZbbTyU2Y0SFp9zohfAOnF
 NzUXu4XnJpPdYdwP7/CUfM0enosAsx4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEzMiBTYWx0ZWRfX+0Wghx6i5QXt
 3NVWfF028noTb/ZXD3F2OWIQMsa8HGzvLQJc5KhVaGqHyZGTrTKEadCXnpMiuoUyCHyS0FZf7d/
 5+DwZyRQatG9vHv57PMUBjwUmf1V2kQifaKCJmrR/JPB8W9TUQimD+rGqcr5AtOHVAmMYbIBM1v
 x0trtgw4GsbvNAsBk0Vz4MEhODbP8NRBN8N4M+yJHPgZbWt3Zb1MfskHKrTx4n1jLfx8wVQ6N3o
 VK9kDrfiy9hzDAyqnfMsGG5wHkyEytTq6RExbFl2UygaL53AJGbTWW/X9sqS7pnUoR2x43srohV
 11lNwtRohu7u7NdEfoYApKlmvtIeU2eI0v59JELKLbLYYThcgxsY5y6IuXVPmy8pjG75WcaNfQG
 V76RcEzq1u4r+eLSZYO98ICHsjBu3UATzNtG97uvgHA6cmd2AlOeIZ7znvQBY7RbgFcjkpfnNXZ
 3jHK6HAOgWO196g8+YQ==
X-Proofpoint-ORIG-GUID: ld11lPUFfgDa1IjLl9Na3xAwoZtiSZrw
X-Authority-Analysis: v=2.4 cv=Ifm3n2qa c=1 sm=1 tr=0 ts=6a5f6595 cx=c_pps
 a=eXjbGYYLs/cxvPp3erIRkw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22 a=64Cc0HZtAAAA:8
 a=aueCIXYKo1H43F9MYFQA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

This isn't in practise a problem since feature->argsz is not externally=0A=
provided, it's a good hardening step nonetheless.=0A=
=0A=
Fixes: e2358af5838d ("vfio-user: support VFIO_USER_DEVICE_FEATURE")=0A=
=0A=
Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>=0A=
---=0A=
 hw/vfio-user/device.c | 4 ++++=0A=
 1 file changed, 4 insertions(+)=0A=
=0A=
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c=0A=
index 353fa5ee21..8feaa56875 100644=0A=
--- a/hw/vfio-user/device.c=0A=
+++ b/hw/vfio-user/device.c=0A=
@@ -87,6 +87,10 @@ vfio_user_device_io_device_feature(VFIODevice *vbasedev,=
=0A=
         error_printf("vfio_user_device_io_device_feature argsz too large\n=
");=0A=
         return -E2BIG;=0A=
     }=0A=
+    if (size > proxy->max_xfer_size) {=0A=
+        error_printf("vfio_user_device_io_device_feature argsz too large\n=
");=0A=
+        return -E2BIG;=0A=
+    }=0A=
 =0A=
     msgp =3D g_malloc0(size);=0A=
 =0A=
-- =0A=
2.34.1=0A=
=0A=

