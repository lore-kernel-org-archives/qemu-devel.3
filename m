Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49175C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 17:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk36x-0001a3-8Q; Wed, 15 Jul 2026 13:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@us.ibm.com>)
 id 1wk36v-0001Zl-JB; Wed, 15 Jul 2026 13:09:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@us.ibm.com>)
 id 1wk36r-0007VM-N9; Wed, 15 Jul 2026 13:09:29 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FEBhqo403756; Wed, 15 Jul 2026 17:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=kYH50EfK63aestzeW/JfcdNkKk5JzB
 ZGR22CeO7hRNs=; b=NWGIgQ23FaKINcCcH6IHwODUw8jSQhnNGu5Fxg3MXdQDvW
 XZTGZzh6UgXXaxhJWTMjEnlo8smwT1ZIExJv/MI4KWinHAMNe0qI/ezBAAE0mdhw
 eFnKGFdTXU6TQ+LPSnr44fMK2fUUXhZ/7pBpdXQxRB0udl+iYpgVs3y8PC/o8q77
 NFc+uf1KzGhiZTKb+GD/yFGi+p+zYgiyOhOwUl/+/R5I1a1agSR5AB53ElkFdkK2
 bz3UZNNVU7kVJ45RSX35nGRa79qImSkFV3tEck6JWjwnHsfYCiU5c2r/YNCv6ooh
 MWb31r+Pcy3YkwAqqVX2jQkOb1oyA6TQQWunqEyg==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012030.outbound.protection.outlook.com
 [40.93.195.30])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegtcsha-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 17:09:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYzOxaI9MkQSu3UTjlBeiVodd0OyYBE/HSkbR5v14jNbO5ZlX73AgsM9Pt35gzr4+ugLZCyFX+JPEd0TRHZlHCrPkGBAAx/IWYq/7I+Lt54IKIv0RXv/wn+eXAPAm00LXiV9j6XCY9GG74lcu2DLlYKCgptwu6SLy6ha+gOlsMqOxkC82wBl11C4t6sXvseDXYEkmNWyrdsarfG7zF9Uyv0c2VQX63yoDLbacNaMuAx0B9qWt4sF425p95HkKzu836Maa3B5T+wYKqBpxbFwQ7drsAVq+PwRiP/MKXrmIHdVZGaJ4ouLD8ySQENJOPSnFzkMRIOrabmxy5ytJCYs7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYH50EfK63aestzeW/JfcdNkKk5JzBZGR22CeO7hRNs=;
 b=DGQ6hXJU6iPh8ImjXITqw4S8WAj8VeeEHM61OpZMnKzdirbJhR5fnnyEPtkkTWs3fwWY1GIZx+NR9bxuw18373Wwdrf3D60gj7Wt7HE3yJh89StI5T+mT2UjOdiDMp8ddP3uFuMqZ/5+H1d1eV5N+UVaqLfLZ6g2IITOxzhKbNxTRN1BrP+HpH6LGNhyeGL4VACB8Da+TN3g5EiXxgMM1iJs5hWQRNvv7i+5j/5QwabBzmLubX/nRrN90XSqzQMWwazBQOnuIZvup1KGMASJbRIZtyIzKFRMwQwy6FD9OBzYBykIsG/n6IgIbXWrNb1MMwwBVCOHI4NvW8u/oQB7kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from DM4PR15MB5380.namprd15.prod.outlook.com (2603:10b6:8:63::9) by
 SA1PR15MB5258.namprd15.prod.outlook.com (2603:10b6:806:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 17:08:57 +0000
Received: from DM4PR15MB5380.namprd15.prod.outlook.com
 ([fe80::a904:6080:c639:7d67]) by DM4PR15MB5380.namprd15.prod.outlook.com
 ([fe80::a904:6080:c639:7d67%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 17:08:57 +0000
From: CALEB SCHLOSSIN <calebs@us.ibm.com>
To: Glenn Miles <milesg@ibm.com>, Mikail Sadic <Mikail.Sadic@ibm.com>,
 "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, "ninad@linux.ibm.com"
 <ninad@linux.ibm.com>, "titusr@google.com" <titusr@google.com>,
 "jeuk20.kim@samsung.com" <jeuk20.kim@samsung.com>, "philmd@mailo.com"
 <philmd@mailo.com>,
 "steven_lee@aspeedtech.com" <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, "jamin_lin@aspeedtech.com"
 <jamin_lin@aspeedtech.com>, "kane_chen@aspeedtech.com"
 <kane_chen@aspeedtech.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 0/5] Add IBM Huygens BMC machine for AST2700
Thread-Topic: [PATCH v1 0/5] Add IBM Huygens BMC machine for AST2700
Thread-Index: AQHdFHGzqC6AyfQSgk2XQ4/ix1e4DrZuvY2AgAASpqI=
Date: Wed, 15 Jul 2026 17:08:57 +0000
Message-ID: <DM4PR15MB5380653523EF2D5C11DE2254E1F82@DM4PR15MB5380.namprd15.prod.outlook.com>
References: <20260715155037.2237011-1-mikail.sadic@ibm.com>
 <PH7PR15MB515180D1B6F069668AD594DFCAF82@PH7PR15MB5151.namprd15.prod.outlook.com>
In-Reply-To: <PH7PR15MB515180D1B6F069668AD594DFCAF82@PH7PR15MB5151.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR15MB5380:EE_|SA1PR15MB5258:EE_
x-ms-office365-filtering-correlation-id: 4b04a506-6265-492e-33a2-08dee293c1cf
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|10067099003|38070700021|22082099003|18002099003|4143699003|8096899003|11063799006|56012099006;
x-microsoft-antispam-message-info: DNHW3TOqoN9EnSvJH4BfSp/AEc7hlV/KySZ5Fwt9wo+3Y4nCPti/2sYG1QuGrxulK2hRtPfqGhRcOqmTn4C5VU5wZUsbHWKW+IDlvPt5kLQFYZY2QLJlaudelb26LS7B5pJ7torOsuTmIJigi4n2KgFsDehSgn37Y55QXxGApzSR9QtHG9hf2bYkRkLb06WevF/BUqnsrKrBFQn0nfAsf9Z3f2F2Q3eeGiV7xi4XbwCNcjKdEFVGnB/0NZgoFWLRuIBECW6vFQyeY78PV7JXK2PLhw94uqqK9TruHO7+0mxEaRcf+hZRJsY11WKhm5CxDHfCdqOC6fFRk9UsXMm6CEdSUKbOQAE9zqQIF5l9/RGoQLA+9SklA7Q5dYZl2qpgb/nLtiqVbcSmVXbcSLkrtyzwsabdTO8Ua5z83g7nV6k1FaLGEKarZ/z/u78vs8pJj3s31BOqrOc/kvwiiGEs8a9b/Sek4MwEvt5jqbv3pmxfBCLD/j8w8fo3K6S87FCL2AohKcmNNFEZ5ZQtocpcG3jPok8U9nHd3qZLkmjbKQc+EbVa8+E8/e4HEAbEiSu0NSaMoB+qndLt205I1SY0CDeEMD5HbDtktxGviDI4IxhmTDAirDKS6DLtRESHPY9w2QhxoZimno4XRIMhh2urgA9U3a3DdM+uu4eGiyLqhbrZjMREjYO7mgsRO2m2+SoAIrZWlDRS/sJvOsRXUAnfb2oEjnkaOpu2kEdu3SD74k0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR15MB5380.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10067099003)(38070700021)(22082099003)(18002099003)(4143699003)(8096899003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HgfHeaLBU3DTYE3JLDsz3Z3EdCUjkJS8+TvVfqkalFAz664+Pnq/Rb+vO8EL?=
 =?us-ascii?Q?/v6WNK/lh5epLNaVZaAJxAQGO6aeJVgHSFBw6OdyW4gd36g4MFWVqpOd/bk0?=
 =?us-ascii?Q?HKjrtj/iAQb4jga9NEBL7qyuKZpQ2c3VLKbinDMtcYutKqC0F+QzPM2o/W/j?=
 =?us-ascii?Q?Xz4OqW2hJNeb42UJJeAJBg3Ap1s/xDhBXw1U9Cp7iweuwKbVd+uYWsRonT8d?=
 =?us-ascii?Q?C2uERUnCBBgs39NN7evfO4IpQBhnmQocmFc/CGoDzMrx2YvgbdhTQQvlk8YV?=
 =?us-ascii?Q?lmn8AwbfdLS5vm7zrjXQ9kmbOx9ING3/mLYGIEzb+Z16w3gAPpXhlGCayK0l?=
 =?us-ascii?Q?WJbSleSzCH/az3CyIQSwSJg9GmuaNBTHYUjPR53KGcvfOvUNpXEllGsgp4TX?=
 =?us-ascii?Q?BNT4c3qTwNdY4CvPj+1K6+V5enHReRpuINpaP/yZifSifnJyxfT0mQnUmrMS?=
 =?us-ascii?Q?dgXhba/CDu2pFuUfImUN7VYk31O4u5N4GUpIwe5Y/ymmEUUdlbEqMDrgUQF1?=
 =?us-ascii?Q?dVe8n+59R3RiFozDPQVNDyw4+aX8eWXG1fKCXzkH5pEjRWY041DJaeVwX4wz?=
 =?us-ascii?Q?ypzkBf/2NDTnGkx6cXqTI0ILMYLM9UG7oX6UVUjd4hgwkRYmdPwatKrvWKyD?=
 =?us-ascii?Q?6B920LmeMnV59sFQkdJR4ksOLx9Reo0FmSYIUXjL9Ae/mB6ZlEIJWs7o7L3z?=
 =?us-ascii?Q?okxpIqLCF3vJPwdeEpZ9AkSyRdbrkmoW3G64eGRAlVzGYv6V+M5dWRIUsHf/?=
 =?us-ascii?Q?SCgeCvpQt1cJaUDoNq1cx2OuTljNI8b1A1N6qMxATA13lGa+cRk2MuASEkqo?=
 =?us-ascii?Q?hDDrTJ9jdYOvWbPV/MtEjgSsoYNR6KjJlnrnDevlxmB+Cuk48NzHBIyjieUM?=
 =?us-ascii?Q?81paM0k9NhybCW+kplY9wXYO/Dpjh5isAVJzi0LREVmAwqLhk1mkyW4hCkeq?=
 =?us-ascii?Q?zBo0gi8jIccdtvjtgvXyjQt9FsRsFyTXc1imbUFj8OihevVCk6wJXAFxddzC?=
 =?us-ascii?Q?DQxMJaYFgTASNg4X3VwwCyLj5zTY9kmYjsrLmnhhmSHWyF6BHoYDM8DijcIp?=
 =?us-ascii?Q?hXs5Kycxe9KCIRKUwyvFlxwwvFLl7+hZcG49u6x6Spue7SkkXy+rmhaaAIoI?=
 =?us-ascii?Q?xBeWCRMZkp80i/dcW934oTelGY0dGvxZ6vpeRlDWgd6SwN1jZ70oYBywJstu?=
 =?us-ascii?Q?ZTK59xqt54QSdHEtS4KdxJuBmlm5q8OCLKuC+aYfkVUKFkt8nYYXZC13WlWO?=
 =?us-ascii?Q?1z1eXNk3Vz0OKvLEcSElnKps4J8HhekqmSTCqlxd0ql7/rrI0k0xdVQQTi04?=
 =?us-ascii?Q?+d4UqNFAhZaR8A8oDboN1YOsm3wq9daKR4kM6Sb17cpgnGsTbkTfq8GWmj3U?=
 =?us-ascii?Q?EZGOh99yGiQJ+nYC8mZw4e+/pkg0iMGBjp5mB4bYEH25b81da1s9jjwbhE1o?=
 =?us-ascii?Q?JDTq4VxRWe2EUwNLt86ZKPxw+6+53eRCbtbj3rmVwmEW/6cmzqKdjj/a04FT?=
 =?us-ascii?Q?duTYHyb3VlNAMb0mGeCzQv5jNf8318HUy/a1UOwnJdFKfGPB5iC22mcr40nn?=
 =?us-ascii?Q?6TjzuhNr9AdfBT1Pk3uNy5gXOYHvFP5OVuSXdPADBmTuFA7NDqM5F7BauFKj?=
 =?us-ascii?Q?OBrwNw4T2HfgzuTjugAwxGIhsZ8udYyQyCzEurmbe4u9D1rVp7WlMM1FPPqX?=
 =?us-ascii?Q?RtVlE8Nqk6ttD/Ktdwc/KfbNcSVjzTnhleiA0gPs1baWBgBG?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR15MB5380653523EF2D5C11DE2254E1F82DM4PR15MB5380namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cq4LoKeWwYZaCcKoVbOYLnfLVtLtjbSibzHdrFKedal00clIcHfz9OcdEj95B7SHlPpAvcRipQoUM93DVVn2t9XU3BJd6MILt61fEyd2NMlh4TZLILD+RpkNkXN/YKAqx35xgc8gue8USh2Kz+5dL/CYDt4CearVUX54A09/oHKUer1B8CrSe9VWDwcmfeOhh8H9svOllOJIR2B44aQvKB9mDzEII+NjyhEnSOJTp1FW4yaH0MrhYnyYZXMoKhSv7jKf/45bRMeMew28jCyrRl7S0tTSn5ncmbc41u7Bhn5JFk/EK0tdh1glwWoZYzBcIY8IjnK6mBcQz9hpkX7kZg==
X-OriginatorOrg: us.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR15MB5380.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b04a506-6265-492e-33a2-08dee293c1cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 17:08:57.2266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nF65D56aQfYSwSWAvvu9fBdx6S+ntPP7RJ0MsEN8TXq4c4RD0MtqnI5QYhFWw3KMisVvs3fZG5gvlosZ30LfPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5258
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: P4CEqEgPt8hFM4bbLpY78D4J4oSFGsc7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE2NiBTYWx0ZWRfXxWqhstgyYzXg
 I5uVgziSFgo0HG04q4bZxGKA0YCt0nHElchxPoZoCu4S7RMhKIgPmWktT6xHxVZhsizYuKBy5u/
 YuOqmSymhA4OpUDR3zI1+mf0IQxwciM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE2NiBTYWx0ZWRfX9wFmlWBrJF3V
 K7OrKxItdCOpw/o+Xe0WoaQPRQH64Bu4RYQBbcnKKghUKCap4hFTDR09F+7dUBMNuh+hYRrkeBp
 FZFSMmoQ2m7DfyB8jmdkpONQ+riIwU/YJQAKwTiHxiTcxNGKd8cNoYDsAIYJZ68euRbpTb9/hEV
 MB/QJKJ7RrSx3EI7eNsC1W3qbUpCaGT1UOf4zG5mJzofEvcBv+5qzcPuqjQYpsQ+OJhlg0LgoS5
 +FBuEawbUucpN+IFG+gQncEBX4dxtAE/P687SngXhsvG8OWA8hyqTTb17FYa3SsibJLedE+tbMZ
 O9KoO4qcGzn9m65Ws68u1c4pHpScGLWEBc6hthsmzmjvwi6nLiTcKX/y47z9AHXxdVkHiJvjExV
 xJ0SmVbqy2KpZF5WOprdUT2Uv7tuLZbLSOhrkOEEvPT6irI94cm69wcc6NuXgpcm6mpGOGsbyBY
 1VAt0mKFdPiwz4xG+dw==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a57beb0 cx=c_pps
 a=3pdFJ6cSxbCDruMc3dgxYA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8
 a=1XWaLZrsAAAA:8 a=hD80L64hAAAA:8 a=S56xvJB5AAAA:8 a=V2NxCb60AAAA:8
 a=pGLkceISAAAA:8 a=7KBfExy5AAAA:8 a=69wJf7TsAAAA:8 a=ZyqM74AI27vIaqdW3IgA:9
 a=CjuIK1q_8ugA:10 a=XV2iG6GQJs05N3O_JE0A:9 a=WwSFPsUCu2GDwqp3:21
 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10 a=gFNbaldVC-z-bsjSTzMo:22
 a=cvBusfyB2V15izCimMoJ:22 a=MH9Ivq0PDQRhlrFuIVvX:22 a=3L6qF29SlnrayQqPM2jZ:22
 a=eL7OMsOqQ-6kYQPn45L1:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: cZ3p8OZjPS3Rur1P-ceShjJiTS-mEM7n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150166
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@us.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

--_000_DM4PR15MB5380653523EF2D5C11DE2254E1F82DM4PR15MB5380namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Mikail,

Same for me, please use calebs@linux.ibm.com.

Thanks,
Caleb Schlossin
----------------------------------------
Power Simulation Architect
IBM Rochester, MN
----------------------------------------
________________________________
From: Glenn Miles <milesg@ibm.com>
Sent: Wednesday, July 15, 2026 11:01 AM
To: Mikail Sadic <Mikail.Sadic@ibm.com>; clg@kaod.org <clg@kaod.org>; peter=
.maydell@linaro.org <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>; ninad@linux.ibm.com <ninad@linux.i=
bm.com>; titusr@google.com <titusr@google.com>; jeuk20.kim@samsung.com <jeu=
k20.kim@samsung.com>; philmd@mailo.com <philmd@mailo.com>; steven_lee@aspee=
dtech.com <steven_lee@aspeedtech.com>; leetroy@gmail.com <leetroy@gmail.com=
>; jamin_lin@aspeedtech.com <jamin_lin@aspeedtech.com>; kane_chen@aspeedtec=
h.com <kane_chen@aspeedtech.com>; andrew@codeconstruct.com.au <andrew@codec=
onstruct.com.au>; joel@jms.id.au <joel@jms.id.au>; CALEB SCHLOSSIN <calebs@=
us.ibm.com>; qemu-arm@nongnu.org <qemu-arm@nongnu.org>; qemu-devel@nongnu.o=
rg <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 0/5] Add IBM Huygens BMC machine for AST2700

Hi Mikail,

Could you use my milesg@linux.ibm.com email address for patches please?

Thanks,

Glenn
________________________________
From: Mikail Sadic <mikail.sadic@ibm.com>
Sent: Wednesday, July 15, 2026 10:50 AM
To: clg@kaod.org <clg@kaod.org>; peter.maydell@linaro.org <peter.maydell@li=
naro.org>
Cc: Mikail Sadic <Mikail.Sadic@ibm.com>; Paolo Bonzini <pbonzini@redhat.com=
>; ninad@linux.ibm.com <ninad@linux.ibm.com>; titusr@google.com <titusr@goo=
gle.com>; jeuk20.kim@samsung.com <jeuk20.kim@samsung.com>; philmd@mailo.com=
 <philmd@mailo.com>; steven_lee@aspeedtech.com <steven_lee@aspeedtech.com>;=
 leetroy@gmail.com <leetroy@gmail.com>; jamin_lin@aspeedtech.com <jamin_lin=
@aspeedtech.com>; kane_chen@aspeedtech.com <kane_chen@aspeedtech.com>; andr=
ew@codeconstruct.com.au <andrew@codeconstruct.com.au>; joel@jms.id.au <joel=
@jms.id.au>; CALEB SCHLOSSIN <calebs@us.ibm.com>; Glenn Miles <milesg@ibm.c=
om>; qemu-arm@nongnu.org <qemu-arm@nongnu.org>; qemu-devel@nongnu.org <qemu=
-devel@nongnu.org>
Subject: [PATCH v1 0/5] Add IBM Huygens BMC machine for AST2700

This series adds initial support for the IBM Huygens BMC platform based
on the ASPEED AST2700 A2 SoC.

The series introduces a new Huygens machine model, adds a dedicated
CFAM-S implementation for the AST2700 FSI responder framework, provides
a PMBus model for the TI UCD90320 power sequencer, and implements the
AST2700 UFS host controller required for booting from UFS storage.
It also includes an initial functional test covering the Huygens boot
flow.

Patch summary:

1. Add the AST2700 Huygens machine.
2. Add the CFAM-S model for AST2700.
3. Add the TI UCD90320 PMBus device model.
4. Add the AST2700 UFS host controller.
5. Add an initial Huygens functional boot test.

Testing done:

* Booted OpenBMC using UFS storage.
* Verified OpenBMC reaches the login prompt & Active/Ready state.
* Verified `make check` test cases all pass.

Note: checkpatch has some warns about MAINTAINERS for patches 1, 2,
and 5, but the new files should already be covered by existing
wildcard entries in the ASPEED BMCs and FSI sections.

Mikail Sadic (5):
  arm/aspeed: Add AST2700 Huygens machine
  fsi/cfam: Add CFAM-S model for AST2700
  hw/sensor: Add UCD90320 model
  ufs/aspeed: Add AST2700 UFS host controller
  tests/functional: Add Huygens BMC boot test

 MAINTAINERS                                   |    2 +
 docs/specs/aspeed-ufs.rst                     |   69 ++
 docs/specs/fsi.rst                            |   58 +
 docs/specs/index.rst                          |    2 +
 docs/specs/ucd90320.rst                       |   36 +
 docs/system/arm/aspeed.rst                    |   41 +-
 include/hw/arm/aspeed_soc.h                   |    3 +
 include/hw/fsi/cfam-s.h                       |   26 +
 include/hw/fsi/fsi-master.h                   |    2 +
 include/hw/ufs/aspeed_ufs.h                   |   66 +
 hw/arm/aspeed.c                               |   12 +
 hw/arm/aspeed_ast27x0.c                       |   31 +
 hw/arm/aspeed_ast27x0_huygens.c               |  242 ++++
 hw/fsi/cfam-s.c                               |  145 +++
 hw/fsi/fsi-master.c                           |   10 +-
 hw/i2c/aspeed_i2c.c                           |    7 +
 hw/sensor/ucd90320.c                          |  144 +++
 hw/ufs/aspeed_ufs.c                           | 1095 +++++++++++++++++
 hw/arm/Kconfig                                |    1 +
 hw/arm/meson.build                            |    1 +
 hw/fsi/meson.build                            |    2 +-
 hw/sensor/Kconfig                             |    4 +
 hw/sensor/meson.build                         |    1 +
 hw/ufs/meson.build                            |    1 +
 tests/functional/aarch64/meson.build          |    2 +
 .../functional/aarch64/test_aspeed_huygens.py |   49 +
 26 files changed, 2047 insertions(+), 5 deletions(-)
 create mode 100644 docs/specs/aspeed-ufs.rst
 create mode 100644 docs/specs/ucd90320.rst
 create mode 100644 include/hw/fsi/cfam-s.h
 create mode 100644 include/hw/ufs/aspeed_ufs.h
 create mode 100644 hw/arm/aspeed_ast27x0_huygens.c
 create mode 100644 hw/fsi/cfam-s.c
 create mode 100644 hw/sensor/ucd90320.c
 create mode 100644 hw/ufs/aspeed_ufs.c
 create mode 100755 tests/functional/aarch64/test_aspeed_huygens.py

--
2.53.0


--_000_DM4PR15MB5380653523EF2D5C11DE2254E1F82DM4PR15MB5380namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Arial, Helvetica, sans-=
serif; font-size: 10pt; color: rgb(0, 0, 0);">
Mikail,</div>
<div class=3D"elementToProof" style=3D"font-family: Arial, Helvetica, sans-=
serif; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Arial, Helvetica, sans-=
serif; font-size: 10pt; color: rgb(0, 0, 0);">
Same for me, please use calebs@linux.ibm.com.</div>
<div id=3D"Signature" class=3D"elementToProof">
<div class=3D"elementToProof" style=3D"font-family: Arial, Helvetica, sans-=
serif; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Arial, Helvetica, sans-=
serif; font-size: 10pt; color: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Arial, Helvetica, sans-=
serif; font-size: 10pt; color: rgb(0, 0, 0);">
Caleb Schlossin</div>
<div class=3D"elementToProof" style=3D"font-family: Arial, Helvetica, sans-=
serif; font-size: 10pt; color: rgb(0, 0, 0);">
----------------------------------------</div>
<div class=3D"elementToProof" style=3D"font-family: Arial, Helvetica, sans-=
serif; font-size: 10pt; color: rgb(0, 0, 0);">
Power Simulation Architect</div>
<div class=3D"elementToProof" style=3D"font-family: Arial, Helvetica, sans-=
serif; font-size: 10pt; color: rgb(0, 0, 0);">
IBM Rochester, MN</div>
<div class=3D"elementToProof" style=3D"font-family: Arial, Helvetica, sans-=
serif; font-size: 10pt; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);">---------------------=
-------------------</span></div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Glenn Miles &lt;miles=
g@ibm.com&gt;<br>
<b>Sent:</b> Wednesday, July 15, 2026 11:01 AM<br>
<b>To:</b> Mikail Sadic &lt;Mikail.Sadic@ibm.com&gt;; clg@kaod.org &lt;clg@=
kaod.org&gt;; peter.maydell@linaro.org &lt;peter.maydell@linaro.org&gt;<br>
<b>Cc:</b> Paolo Bonzini &lt;pbonzini@redhat.com&gt;; ninad@linux.ibm.com &=
lt;ninad@linux.ibm.com&gt;; titusr@google.com &lt;titusr@google.com&gt;; je=
uk20.kim@samsung.com &lt;jeuk20.kim@samsung.com&gt;; philmd@mailo.com &lt;p=
hilmd@mailo.com&gt;; steven_lee@aspeedtech.com &lt;steven_lee@aspeedtech.co=
m&gt;;
 leetroy@gmail.com &lt;leetroy@gmail.com&gt;; jamin_lin@aspeedtech.com &lt;=
jamin_lin@aspeedtech.com&gt;; kane_chen@aspeedtech.com &lt;kane_chen@aspeed=
tech.com&gt;; andrew@codeconstruct.com.au &lt;andrew@codeconstruct.com.au&g=
t;; joel@jms.id.au &lt;joel@jms.id.au&gt;; CALEB SCHLOSSIN &lt;calebs@us.ib=
m.com&gt;;
 qemu-arm@nongnu.org &lt;qemu-arm@nongnu.org&gt;; qemu-devel@nongnu.org &lt=
;qemu-devel@nongnu.org&gt;<br>
<b>Subject:</b> Re: [PATCH v1 0/5] Add IBM Huygens BMC machine for AST2700<=
/font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
Hi Mikail,</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
Could you use my milesg@linux.ibm.com email address for patches please?</di=
v>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
Thanks,</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
Glenn</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Mikail Sadic &lt;mi=
kail.sadic@ibm.com&gt;<br>
<b>Sent:</b> Wednesday, July 15, 2026 10:50 AM<br>
<b>To:</b> clg@kaod.org &lt;clg@kaod.org&gt;; peter.maydell@linaro.org &lt;=
peter.maydell@linaro.org&gt;<br>
<b>Cc:</b> Mikail Sadic &lt;Mikail.Sadic@ibm.com&gt;; Paolo Bonzini &lt;pbo=
nzini@redhat.com&gt;; ninad@linux.ibm.com &lt;ninad@linux.ibm.com&gt;; titu=
sr@google.com &lt;titusr@google.com&gt;; jeuk20.kim@samsung.com &lt;jeuk20.=
kim@samsung.com&gt;; philmd@mailo.com &lt;philmd@mailo.com&gt;; steven_lee@=
aspeedtech.com
 &lt;steven_lee@aspeedtech.com&gt;; leetroy@gmail.com &lt;leetroy@gmail.com=
&gt;; jamin_lin@aspeedtech.com &lt;jamin_lin@aspeedtech.com&gt;; kane_chen@=
aspeedtech.com &lt;kane_chen@aspeedtech.com&gt;; andrew@codeconstruct.com.a=
u &lt;andrew@codeconstruct.com.au&gt;; joel@jms.id.au &lt;joel@jms.id.au&gt=
;;
 CALEB SCHLOSSIN &lt;calebs@us.ibm.com&gt;; Glenn Miles &lt;milesg@ibm.com&=
gt;; qemu-arm@nongnu.org &lt;qemu-arm@nongnu.org&gt;; qemu-devel@nongnu.org=
 &lt;qemu-devel@nongnu.org&gt;<br>
<b>Subject:</b> [PATCH v1 0/5] Add IBM Huygens BMC machine for AST2700</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">This series adds initial support for the IBM Huy=
gens BMC platform based<br>
on the ASPEED AST2700 A2 SoC.<br>
<br>
The series introduces a new Huygens machine model, adds a dedicated<br>
CFAM-S implementation for the AST2700 FSI responder framework, provides<br>
a PMBus model for the TI UCD90320 power sequencer, and implements the<br>
AST2700 UFS host controller required for booting from UFS storage.<br>
It also includes an initial functional test covering the Huygens boot <br>
flow.<br>
<br>
Patch summary:<br>
<br>
1. Add the AST2700 Huygens machine.<br>
2. Add the CFAM-S model for AST2700.<br>
3. Add the TI UCD90320 PMBus device model.<br>
4. Add the AST2700 UFS host controller.<br>
5. Add an initial Huygens functional boot test.<br>
<br>
Testing done:<br>
<br>
* Booted OpenBMC using UFS storage.<br>
* Verified OpenBMC reaches the login prompt &amp; Active/Ready state.<br>
* Verified `make check` test cases all pass.<br>
<br>
Note: checkpatch has some warns about MAINTAINERS for patches 1, 2, <br>
and 5, but the new files should already be covered by existing <br>
wildcard entries in the ASPEED BMCs and FSI sections.<br>
<br>
Mikail Sadic (5):<br>
&nbsp; arm/aspeed: Add AST2700 Huygens machine<br>
&nbsp; fsi/cfam: Add CFAM-S model for AST2700<br>
&nbsp; hw/sensor: Add UCD90320 model<br>
&nbsp; ufs/aspeed: Add AST2700 UFS host controller<br>
&nbsp; tests/functional: Add Huygens BMC boot test<br>
<br>
&nbsp;MAINTAINERS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp;&nbsp;&nbsp; 2 +<br>
&nbsp;docs/specs/aspeed-ufs.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp;&nbsp; 69 ++<br>
&nbsp;docs/specs/fsi.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 58 +<br>
&nbsp;docs/specs/index.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 2 +<br>
&nbsp;docs/specs/ucd90320.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 36 +<br>
&nbsp;docs/system/arm/aspeed.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp;&nbsp; 41 +-<br>
&nbsp;include/hw/arm/aspeed_soc.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp;&nbsp; 3 +<br>
&nbsp;include/hw/fsi/cfam-s.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 26 +<br>
&nbsp;include/hw/fsi/fsi-master.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp;&nbsp; 2 +<br>
&nbsp;include/hw/ufs/aspeed_ufs.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp; 66 +<br>
&nbsp;hw/arm/aspeed.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 12 +<br>
&nbsp;hw/arm/aspeed_ast27x0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 31 +<br>
&nbsp;hw/arm/aspeed_ast27x0_huygens.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 242 ++++<br>
&nbsp;hw/fsi/cfam-s.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 145 +++<br>
&nbsp;hw/fsi/fsi-master.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 10 +-<br>
&nbsp;hw/i2c/aspeed_i2c.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 7 +<br>
&nbsp;hw/sensor/ucd90320.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 144 +++<br>
&nbsp;hw/ufs/aspeed_ufs.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1095 +++++++++++++++++<br>
&nbsp;hw/arm/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp=
; 1 +<br>
&nbsp;hw/arm/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 1 +<br>
&nbsp;hw/fsi/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 2 +-<br>
&nbsp;hw/sensor/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 4 +<br>
&nbsp;hw/sensor/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 1 +<br>
&nbsp;hw/ufs/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 1 +<br>
&nbsp;tests/functional/aarch64/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 2 +<br>
&nbsp;.../functional/aarch64/test_aspeed_huygens.py |&nbsp;&nbsp; 49 +<br>
&nbsp;26 files changed, 2047 insertions(+), 5 deletions(-)<br>
&nbsp;create mode 100644 docs/specs/aspeed-ufs.rst<br>
&nbsp;create mode 100644 docs/specs/ucd90320.rst<br>
&nbsp;create mode 100644 include/hw/fsi/cfam-s.h<br>
&nbsp;create mode 100644 include/hw/ufs/aspeed_ufs.h<br>
&nbsp;create mode 100644 hw/arm/aspeed_ast27x0_huygens.c<br>
&nbsp;create mode 100644 hw/fsi/cfam-s.c<br>
&nbsp;create mode 100644 hw/sensor/ucd90320.c<br>
&nbsp;create mode 100644 hw/ufs/aspeed_ufs.c<br>
&nbsp;create mode 100755 tests/functional/aarch64/test_aspeed_huygens.py<br=
>
<br>
-- <br>
2.53.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM4PR15MB5380653523EF2D5C11DE2254E1F82DM4PR15MB5380namp_--

