Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8C7C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 15:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSer0-0001cT-Up; Wed, 24 Jan 2024 10:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rSeqy-0001Yw-27
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 10:07:48 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rSeqv-0002mi-Gm
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 10:07:47 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40OEOM7w023432; Wed, 24 Jan 2024 15:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:content-type:mime-version; s=
 qcppdkim1; bh=rX6YjX5a4TuYGRbxg0RIGgWnRhLiq1pvSWCDz1TswrI=; b=Cb
 Snhe/jHxMbJsXl7mw3KG7yN0WdOgeUx6cKRxKRq92MW6QPKJNEeji6PvkoEO3iqF
 Rxz5V5qkat4vUnWu5+REDEVi5d6SM0uMAs3VTYdfYxFDaPqLdxTzWSos1OmztidT
 pjX8oEe/juc/gi7Ox1o9jrQ6SzJBQMnP/zis7CcxhKSPifUuwsn8W/GFvWiDSrRh
 7ws8dVLhhQxjqmH4DASsQgOLyv3EuLxa3wtjeuV8xcdJL2YdXwsCwH5PCQHbjOG+
 biUpsRRmvIcHNVyqI0C/FsgrWtBamM11m1E/q80ysJgo0xdWH9LWj/IbsS+Yxl3n
 YRji81PNRgeIPpQ/iGbQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vu4998363-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jan 2024 15:07:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmsUdQDd2NAls4XsRZ0f7swQNKTD2eWVttLxqpVkgqyibIR9XUs7/Arbz+0V8TXxTBWrS332G/7pgXZD4SrJ/wjdCJsg31LFfN3UMIx5pRT5Vnn0H8BusmHmInM1ciC/h7LU7dCYeMyYKR1kVoiDTIyq2w1Yk5JaLs92KKz4Lzm4TD2FDGJt+QdYBEsyZV539O4loUWj6GMYPayI9RkfcjUKurqmCHfslxsEhx3GnPweF+wXpvSUPlpM+YnXdY0mt39FP3NSUFgdq+FbOIlVtHCowPw6n+JwOc1ZxencT6xtp+7RCNFe8A3Q1jADYC+nBIDlRJuCSWbA5B0sAKEzcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rX6YjX5a4TuYGRbxg0RIGgWnRhLiq1pvSWCDz1TswrI=;
 b=khUOEP8BaWEbGOvkKVJUEOIMrMI2UaG27l6b3k8TKL0syaFn9dy3e+cils9//VLp3v8F7Lm8mEDmrI/nkSnzSx5AYDA3c/Io4dDO41wAupwnRLT/EmAq3pWzde1u1eCusaGD9NneJ7tHoB1PhTy1gAm74NSDgC3imctfyOqzodAN5F9VgiXd/GHd6EBq91hyUt9m6RGed+MVGu6zeno0tOA7iBi/O6jQ3GbbsHb4FYeL3SHKRl2As1S5ByoSzYgvzZPglWZxTgsd/1ayLEUSM/M7NMaAaleBizkotdV2QYXGKR9E9+Kt/RB1J1zAioonfY82/DNTWLSpUuLUdGleSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by PH7PR02MB9002.namprd02.prod.outlook.com
 (2603:10b6:510:1fa::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Wed, 24 Jan
 2024 15:07:29 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1e37:59f7:9ae:2058]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1e37:59f7:9ae:2058%6]) with mapi id 15.20.7202.034; Wed, 24 Jan 2024
 15:07:29 +0000
From: Brian Cain <bcain@quicinc.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Sid Manning
 <sidneym@quicinc.com>, Marco Liebel <mliebel@qti.qualcomm.com>, Matheus
 Bernardino <mathbern@qti.qualcomm.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>
Subject: hexagon: modeling a shared lock state
Thread-Topic: hexagon: modeling a shared lock state
Thread-Index: AdpO1p1rtmG5ulOnQhWSP6N+8noomA==
Date: Wed, 24 Jan 2024 15:07:29 +0000
Message-ID: <CH3PR02MB102479550F96F09E0C9D50BA7B87B2@CH3PR02MB10247.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB10247:EE_|PH7PR02MB9002:EE_
x-ms-office365-filtering-correlation-id: 51408020-8e88-4172-7d32-08dc1cee2f18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dvzww/jM3OjTh3noaG+U4WlH48wRHHGCfr3ytgIOIzMZE339kabzqT4CGDfyHUxtJzT7wr7JX9hnfH1SIGKCNP0uKdGCl8YJMAx84LzIEFNt42QBX4F/t26ysndUXA2qu73xQMXTQ2c72SbvlfGqtIgQTMw8OILhXlWTPPr+Xl9X4KpfTVV2f2cDzskEAs0qjZfBUlth9Id91AiwyYP3fYmAZEQVt3Mh3XxzuL3LewG1iBbwYxCCepib0j9JCqGg2Z4/ODNaYU7RvwuRbIhKIRIcWqcQMkf6iE6DShNr+komLpDnRdK1jcKWujDfh3cAlLpQZpIYoep3Q2vX9MSjphWcCKOkWVpdWOl3Ga2ZEjl+ury1M4/eej/Ff0gpsTVbatdEGnUon/iPRPdL3Vs+Y9VkqsT8Tb5mTQvHEuwNaYVWCX4NT7ZxTouzlRhwRMtjNfqtAh5fKtH74/DHD7J/klS2MW5+vqCZFf3ntsn6UeLN0Oc8ekgUjGny50UJlXrKwZaeLSD3afM44YgjOpG/mvKYY3ub22SjQOgQRtQtQoNLntUBLn8MdyRPyGnAHl2rgrRzxObQGNbPUbmOvlwF9VZdM6ELq9oZ638NPNQw9HA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR02MB10247.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(8676002)(8936002)(5660300002)(64756008)(316002)(2906002)(66556008)(55016003)(66446008)(54906003)(4326008)(66946007)(76116006)(52536014)(6916009)(66476007)(966005)(6506007)(71200400001)(38070700009)(26005)(478600001)(33656002)(7696005)(166002)(83380400001)(122000001)(38100700002)(41300700001)(9686003)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?x8E0Tb0mhZhSdw7f7dvEy26C0fXiNOe1uy/ENrTuM7JraUb5xGZS+nYRSb?=
 =?iso-8859-1?Q?B+KmneCoYE+TAg2TwcE4PZ3jCv5tSLniIdCxvDwrSficYejSRK2wXnAQFL?=
 =?iso-8859-1?Q?Vr/iKQWxbLHG2RdznGuGGwGwamIOfg83CH8QkiQBmrktARj1HbyK8I7UrY?=
 =?iso-8859-1?Q?ocwoRUyEweFFXXL96/az6FCYOeM6Dk4EnkACprzBoGjEja5lvUvjX75rs9?=
 =?iso-8859-1?Q?8XvGq53TLBRdDlypVv6OWDR6Nppbdpxi1CkZPEn0GmCEeWQ+nkFyU7Vh8Z?=
 =?iso-8859-1?Q?Rt3IhNbgE1eEcPQI8XY8IPwggSz24TjiGns33xEEUTOvhYnOSuf/Yw/kIS?=
 =?iso-8859-1?Q?niEUHtJAaDO5UELmzXo5hmPVTTORzK67B1KoEjiDcj/pthUYAofbIx3jhw?=
 =?iso-8859-1?Q?d8P+RkTid+mD5c+MoEKumRgZc+RapAoXeczvcJtRSk+jk1l5WpPu7yaVC9?=
 =?iso-8859-1?Q?f7r+/ACrpTabINjJiPxggR87O84Cs9a2T3HxS6I+0gHerT8sikYHF+HPXb?=
 =?iso-8859-1?Q?haSTIpxQ0hS1JWPNBdtzv+XX0dVELmSMxEJsrVWX8he6PR+fBI2WVUaSOG?=
 =?iso-8859-1?Q?SQWxhK4iAqKACHcj2oGzwcQnZRXEYPV4n+gnjiYaB1ZBvAzfLmxbGQrbU/?=
 =?iso-8859-1?Q?X82htICJNpMmAySJA+ZWzylFPIRg1T3tL6ZwHEiXJhO3apmUx9fDboZl7t?=
 =?iso-8859-1?Q?J7d8GwmAi4IcH/bhRDMiwsQa4LfNFEB1lGoKKJOFygi/8avn6oZC7lONWk?=
 =?iso-8859-1?Q?eJ6HQXTkb3c44dg/zNADNNXJX2D+QXlXUnNSgQRn/Dsg6E5mUue3kSFKMD?=
 =?iso-8859-1?Q?WtElE3+1v5GqO8KfDgIfXRKtcjHwZ/NvE7Hcu1WtkFozbHdeJ7lsqvS+qg?=
 =?iso-8859-1?Q?fLueFljarr7Fbqo0i6hlQI2plGMkqYBxbP0gagWMeDouagMFC8HVTHIThM?=
 =?iso-8859-1?Q?Fm3naM2vKjLgNbpd+9YxvVZRJxC48j4UcRGEYKmBInT4V5oqr6y2feOLK1?=
 =?iso-8859-1?Q?1RMMIUZXCwTtdXNqm+MZ3Sy4s/ujkVBq2odwQSSSxO7UVVK48dcPmsZYuC?=
 =?iso-8859-1?Q?jAW2baOgj4ylSBwFCSTkBuTAFtZBTWA56Nbnu461D7BJ5F4lZIAjl7err3?=
 =?iso-8859-1?Q?ZK7wvL8Qv7KdGeR67HFqLU2IQ002g8SgvUztZGf483uguYF1YHU/raFCL6?=
 =?iso-8859-1?Q?gfrwwKylgYXHqWomQX1FCTgIovUZcqJvebrmAYCv62Fhf9FZ0iaWVMruq5?=
 =?iso-8859-1?Q?NBG/n2bAOFERsFl5Zi/L3u4BpE9ouQ7lQggQJc7KZePbLSfaXm+Y09E2k5?=
 =?iso-8859-1?Q?Rp6u+93VVtaAGq0XYYOdwIGeRX2u2oai2Vg2PPIRG8vuygY9VGSDBL2q3i?=
 =?iso-8859-1?Q?TpU1mL+A1B26rYpMyycJNWxfQv/BtmZeIGR235bx5bzVoW9tkfln6ynGqZ?=
 =?iso-8859-1?Q?yussbbZ9dUbNpTgAbTq6gy5jPatRgUJyI21tu7haVzTx6yVeqPIGpDCm3j?=
 =?iso-8859-1?Q?rP51YJ+5bD8kWvtL2pQhUBcT9GOWOEGba5GGUXS8N+xj4iHEEuhT6k0VQ2?=
 =?iso-8859-1?Q?YNj4l60mRfZnobXyoiHmjFe8Drh8gZ2fA2Uu19JqgKQBedsE9mPTffyddJ?=
 =?iso-8859-1?Q?7uZ846BiRJ9To=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH3PR02MB102479550F96F09E0C9D50BA7B87B2CH3PR02MB10247na_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: evErLsZZEwGsdWv5ecfiYjXT44itf01+6dWXHjxij7bYUTO/gjMoysei98NXQ1L+tG9apqDPICFtds0UTNw/afV4HtBnNGlmM8HJgWWf+HIPwbf5scuQvyT3Zz/00ImjcuMKdR/gp3gtzhBzCvf+OCkEw2Ky4tGaV54b00kDnVsMFohn2yoNxJLgb3Sy1QoTAVhPuXRu/0c3+aJ2ZgJgSOxEWonqOWL7TWvJlwqFlPJxQ5dXf/f9ytFmfOuwg/1VXCdcbLRET5JonHXiu+padTDogz+IrN753UqagFFom8FCmcODa6px2TQBpXj/YBpqeUcx/H3ku3poLG/NY07bhhpnUS45K0Il41QZ9f3zq2wO14kA8Rc7oQS7MiKIH8VmdUGUO0WpZdz+iFbv1gskbe/94QqVC/b8RF3YT/O+mfYc4kt8/+05yQ2sF5Aax6aW3AjsAxK2wED96i8OkdGQbeSU+sHjLByQtH3xW521WqxIsfzLqLVl03nuO3TIe7Ay9oaOa9rVjiflSOvwX/Vd4UUhJuUzRAeZeAhxyHQWS5SEM3DuatJ18l4SBY7gYgMrzLtvjJM0D3NPYtT5NkQIZY+9oF7YgMjbHfn5+VUSSd+680Q49RXrYDzECWepIGMj
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51408020-8e88-4172-7d32-08dc1cee2f18
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 15:07:29.7421 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pb8Iq7Bae4hrPA7vBokLRsaHTysqEz3U/1xctx+cNaX1bdEZq0hOEXxRiDNuM1vyg5QEAtFnnaM+TUnw4darCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9002
X-Proofpoint-ORIG-GUID: KXVuNegQ_f6--qbnA3tjZEhKHqIkKLA0
X-Proofpoint-GUID: KXVuNegQ_f6--qbnA3tjZEhKHqIkKLA0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=876 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240110
Received-SPF: pass client-ip=205.220.168.131; envelope-from=bcain@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--_000_CH3PR02MB102479550F96F09E0C9D50BA7B87B2CH3PR02MB10247na_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Philippe,

For hexagon sysemu, while internally reviewing patches to be upstreamed we =
noticed that our design for a lock instruction is not quite suitable.  The =
k0lock instruction will halt if some other hexagon hardware CPU has already=
 claimed the kernel lock, only to continue executing once some CPU executes=
 the unlock instruction.  We modeled this using a lock state enumeration me=
mber { OWNER, WAITING, UNLOCKED } in *each* vCPU and atomically transitioni=
ng the lock required us to have vCPU[n] write the updated lock state to vCP=
U[m] when unlocking.

In context: https://github.com/quic/qemu/blob/hexagon_sysemu_20_dec_2023/ta=
rget/hexagon/op_helper.c#L1790-L1821

So instead, maybe it makes more sense to have a system device hold a single=
 representation of the lock's state and each vCPU can do some kind of acces=
s via load/store and/or interrupts to/from the device?  I was thinking of r=
aising an interrupt on the lock device at the vCPU's k0lock instruction to =
indicate demand for the lock, and then the device could raise an interrupt =
to one of the vCPUs when it's granted the lock.  One drawback for this is t=
hat this might add significant latency to the uncontested lock case.  So I =
also considered doing a load of some part of the lock device's memory that =
could indicate whether the lock was available, and if available it would cl=
aim it with a store (both ld/st while holding BQL).  Only if unavailable it=
 would halt and raise the interrupt.  Is it possible to create an address s=
pace that's independent of the true system memory map for this use case or =
would we need to carve out some memory from the existing memory map for thi=
s synthetic device?  Or - do you have a suggestion for a better approach ov=
erall?

-Brian

--_000_CH3PR02MB102479550F96F09E0C9D50BA7B87B2CH3PR02MB10247na_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Philippe,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">For hexagon sysemu, while internally reviewing patch=
es to be upstreamed we noticed that our design for a lock instruction is no=
t quite suitable.&nbsp; The k0lock instruction will halt if some other hexa=
gon hardware CPU has already claimed the
 kernel lock, only to continue executing once some CPU executes the unlock =
instruction.&nbsp; We modeled this using a lock state enumeration member { =
OWNER, WAITING, UNLOCKED } in *<b>each</b>* vCPU and atomically transitioni=
ng the lock required us to have vCPU[n]
 write the updated lock state to vCPU[m] when unlocking.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">In context: <a href=3D"https://github.com/quic/qemu/=
blob/hexagon_sysemu_20_dec_2023/target/hexagon/op_helper.c#L1790-L1821">
https://github.com/quic/qemu/blob/hexagon_sysemu_20_dec_2023/target/hexagon=
/op_helper.c#L1790-L1821</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">So instead, maybe it makes more sense to have a syst=
em device hold a single representation of the lock&#8217;s state and each v=
CPU can do some kind of access via load/store and/or interrupts to/from the=
 device?&nbsp; I was thinking of raising an interrupt
 on the lock device at the vCPU&#8217;s k0lock instruction to indicate dema=
nd for the lock, and then the device could raise an interrupt to one of the=
 vCPUs when it&#8217;s granted the lock.&nbsp; One drawback for this is tha=
t this might add significant latency to the uncontested
 lock case.&nbsp; So I also considered doing a load of some part of the loc=
k device&#8217;s memory that could indicate whether the lock was available,=
 and if available it would claim it with a store (both ld/st while holding =
BQL). &nbsp;Only if unavailable it would halt and
 raise the interrupt.&nbsp; Is it possible to create an address space that&=
#8217;s independent of the true system memory map for this use case or woul=
d we need to carve out some memory from the existing memory map for this sy=
nthetic device?&nbsp; Or &#8211; do you have a suggestion
 for a better approach overall?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-Brian<o:p></o:p></p>
</div>
</body>
</html>

--_000_CH3PR02MB102479550F96F09E0C9D50BA7B87B2CH3PR02MB10247na_--

