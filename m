Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F036EC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7bG-0006YE-SE; Tue, 21 Jul 2026 06:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wm7bE-0006X4-I5
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:21:20 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wm7bB-0000h0-Hq
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:21:20 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KNFmBv1825473; Tue, 21 Jul 2026 03:21:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=QQsFyoisI9yp2KFpWcGFrAQ5PmfMC2VDO1uc9xRii
 XM=; b=RyJeMmGC9u5ddyn0OGpbxJ6/XpHI8it9DNkPpr0pV5Ut4rkxr8vJftwqB
 FSWP/MnPR/39U2KFM8Gkzsz5AgYxSe6Lc+vRVOe0vmxcU4BzVSy5cXHopZM8CCmO
 MCyES2RGkKONyb71Wn3JF8C9EW4SlsyZTYwr4S8immqpoeXl7I8F6wgKFzFJo/jM
 1qSPkWP/wStu0SHkhRl/Gyo4t3T4vCQ/3uIvhRVi9eiiCF4RM4xA+9rc6PoOZMiN
 ipEaLBWuqA9gIXq8UXHoqAx4qFMEygrAgDiPQ8cyAywnckA3gPb+aYVYAxMxd13/
 zD28idf/9N52GvSDSO9YFmYsEyUYw==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022136.outbound.protection.outlook.com [52.101.43.136])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg8b5x39w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 03:21:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzn2GiiKwKQZv2AslKNHtyVaB1KsybmdOGrNvOVlcWhsj0KnuDsx7ulYOIBVJHKTUkK4AAbVrbPPm8olo73+e+3W/BLPydo6w7pRuegCyaVhGpLhjRu982buDNSxAL3uJMS5sCbzz/lyBM5C30/I8Jdi/eErYwZyJb72DRYkhR1kv0e2Cylr0JhZTFF8Z9epGKJyzuEEioJYY3cnXR4xW5gaDXpEKEvW62guVCM4M5LAF4YtzimRGb8TjwSyKNCB6HvKs/qUbucltwu4fc3XtH7gk9zv1Y/UNvBZluejgLkRrFYh2PtqIZ6UEMgtthWiO+DVmD+bzyBZpDOwOEWuJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQsFyoisI9yp2KFpWcGFrAQ5PmfMC2VDO1uc9xRiiXM=;
 b=tYbkw0Gu7+FDlzoyZgv8LYzIZ+vNx/V9RWv07OKmGuerXIo8AhGV8gCkdN/c0Ulkhy7+xeCPjXb5ebAvgEmZcggYtsYa/jac3fDdZePMV0srxogajpVkxugG9JWftse1MyBaDtvjNctFuUVKnAZ/VKTp3MzatlAVp2re943DO2g1iOG3mpU/2qLhjFlZ8z0Izk8p8JwHpqeXZszrpoZtEU7XuGGfuq1Y5z49yu+f2D1bN74EHf3SoREUVwrc0sOaJ3wHByI8Wr+deXaJxzivisnY6jBcvjab4VIsIPdmlCI9x/KgraZPtwCJuRVm4Z/j8r+qAJoPIDNHlT5YYtmScA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQsFyoisI9yp2KFpWcGFrAQ5PmfMC2VDO1uc9xRiiXM=;
 b=wiWTR5GMVvNAyOh4b28OPnj+dXJAYn7P1oHy6XqdAJvsIWmTvWANeKi4GKfEvVwyBGcM+phEt3qANDf3J3tpPmWLap/2M8+J6e5w8kWJAbfNMizfnwaSa5Uj+TcounNt9zGtMeMUXi2yOGomunNDU0+8pnQe4m9m+e3fTQXygAtfsUt2uOxor7QeQvHeMgi1LcaA1UdEjYXyolX4tlcY/EDwiT3iJCNkJ7osCUd62CnVF5xInIMo2Wvdwe91LFNU5rxRuLXCtg4dm8vVRbknpgWbfBjIS4ihLt7GVwbbsnPuCuliCYfCNQ8QWdusOSJj9ls1vJ8LZmgdHNCvAnoEZw==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by LVUPR02MB11513.namprd02.prod.outlook.com (2603:10b6:408:39c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 10:21:12 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 10:21:11 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>
Subject: RE: [PATCH 5/5] vfio-user: vfio_user_device_io_get_region_info: fix
 capability check
Thread-Topic: [PATCH 5/5] vfio-user: vfio_user_device_io_get_region_info: fix
 capability check
Thread-Index: AQHdGCiYBdWW1VvgzU+hrmmEztneGbZ2h0uAgAE0zEA=
Date: Tue, 21 Jul 2026 10:21:11 +0000
Message-ID: <IA0PR02MB94625FE207BAD697456DADD68BC22@IA0PR02MB9462.namprd02.prod.outlook.com>
References: <20260720091718.2642-1-thanos.makatos@nutanix.com>
 <20260720091718.2642-6-thanos.makatos@nutanix.com>
 <24c5b800-9c79-4d8e-87d1-3dcbb197be8b@redhat.com>
In-Reply-To: <24c5b800-9c79-4d8e-87d1-3dcbb197be8b@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|LVUPR02MB11513:EE_
x-ms-office365-filtering-correlation-id: 14b8c20d-7cb0-4cc7-3f82-08dee711c9c9
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|4133799003|6133799003|10067099003|4143699003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: oSrpOrJW25SA2to1YV6R+8FkxRiM9mhe1qD2RsKM+L7/X1wskEVQ4Lc0Sx+Uj4HFeuti71u8vrfnh2i39ZWPdBlCcWof796HMb9qrqrPZUnN1qYGsEAtIjlm53Cz52lrP55rCjlh1QRtqfpzmUhoAIdsMw7W2552/QKzkM3mD4/wC++Qn1AIPH0So8jZHGDH2SJO/x1NxJTZOVFH5SoMh0/kvl/rwyQqPz6adRRCRkd8ToU+o9LIHy3Jb1bbMLyp8u4q05x8pGQWrHwlui4EKqDJfn++6PLGv2jVmodKo5sFGA7AY+623Q9gEQ/sX/kkRkseqIjii0vLKMN6jZT74L3nB5nN5XKEfrBvN+EWQuJOfg5QExECvfedw8QABJA3446mVjIjN65+g4Ct4BVgiSU0N3D/+FHWvmUh/3LvZ9tyPFvhSWnZflBRPm0Q/sgJoG1uE9sOlowW0/URqWyrdQHP8gF60UdF8Zh1RpehyUL+ut6wc3YyLvK+YTHRYCVNL1dlqHKjW6PIt+O2V1E+es4UPmpGBAvUIv/ZqRS0uyiMPAmwByY2WJu4eM88HQyJBHcAdLoRH4CSQyCJF94Lj2DF8IAhcdQgR9IEuA38vKuU4/YcoyB1lCFw4XX5r/Imma3B7pn00vV5JkJfd1+j1OjSIXfKIAkv4wMZCjmlgob3JwtDKs+VCzV+Rz5WyTWnL6NQDI6zm0rp8FUpYYJXcZgHgnD0a4j0GdZFfsNbYdA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(4133799003)(6133799003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0MwbUsyVzJNdEdNVm1QQ3R6VjNrbHpqQVczS0xPc2NNaG5kTXZRT3prdGtv?=
 =?utf-8?B?TUZPQzBrRUVhUnpNTDNZby9jQUFCRHJ2R3dUQThHWGI2d05TalVRR1pLYzhC?=
 =?utf-8?B?Z2VQdm5RczlDUmR6aFI3YzBCc2UyNy9oMTN5clF0NWtDTVYwVVhZZEFlTXdW?=
 =?utf-8?B?N0NDSm1HbENLb1pKRXhiNDRCOWc1NlIyZHQ0ZHc0OENXYnRXNGs2KzF6Um5a?=
 =?utf-8?B?NHlhdHphcWpIKzhCWktLVXRoMG9hMFRLWFYvSFN1U3pURC9BeEtLUllQZkhh?=
 =?utf-8?B?bFQ2WjFrZkkrYVdveS84dkMrdG41QjcwSTVtWXpubzQwQnhEa21YUGgxUDRN?=
 =?utf-8?B?TjBMaVRYdFpFVFZNQytGZHlxbk02SkFWeHlaa3JqL3FpSlpZRjloeTJ3K3BU?=
 =?utf-8?B?N0RTZVRxOXZhSmNQeHJJdktrcEltbTdQWHRmL2EyWUJzWjJ2Y211cmEyNEgr?=
 =?utf-8?B?emxEMDVobEVPZ1lXWm9SQnl2VUd3WW90K3RaM1ArVlBHbVJQMFExSzdsWFNj?=
 =?utf-8?B?ZVZWY3NxQ0JIdmxzMFBoSS9HRjU1a3ZMTm1UemRCNUpMRGJqVko0MXo3VDNJ?=
 =?utf-8?B?aXBBRXhlTmpxNHVRVFFGZXVyVDBSbUhqaFMzdEZlUzlSTFROQ2k2WFZBTXM2?=
 =?utf-8?B?YmF5dTVEb3BEN0s4Zi9HSytiSVlzTEZjMGsrcU1IT2RiUXVINHZmNy8wN1JQ?=
 =?utf-8?B?M2hkNmE5dm1INmtoWDd4ZmlGOWpXNkRzOFlPdkdjMkd6NzhCRUpJdmp0NTJk?=
 =?utf-8?B?Ukt3NWJITnArYmV2LzdLb0tIRUE2V3BRYTJuVDVDZU9VMktod0Vhbmt5RDFh?=
 =?utf-8?B?Y3Z6cFp6Q2cyNkR2TUtVcHF6N084K3YvZVJQVzA0dlViNXZ2a1Y3Sk9YU2ZB?=
 =?utf-8?B?TkZDeHY0THdKNkZrMXY3NEJLWTVlOUpDYWo5OW82SkFkNzFQcTdTYmhLMTBl?=
 =?utf-8?B?S1NqSldQa2I0STNBbnRLNmZEQ1RzWjY1Q3dTQmlVV1lGdlhuaDFRVzkzbkUx?=
 =?utf-8?B?NmhOSGRjYlJ5QllvMkVZVTBvTi9Kam96SEdzVWxnUVNJbW1WQnlpWW9sTE96?=
 =?utf-8?B?OWwzZ25rSTN6MitBNTFvdm1zaitWR0JjWnpaakhYczhzbU1vb3lQZ1l3SFVo?=
 =?utf-8?B?Q2lYVjVna3N2Q3lOdTY1ZWRpOTRudE1tZ3Z4Qm5vdy84VStzZlNPc2xsWmFh?=
 =?utf-8?B?c0UwRktvU1JralZYYUVoeWNPcjlTRmtZbTBIeTFoWWo5NFlMYTV3UDBTVU41?=
 =?utf-8?B?Q09oWFA4VFFqOHRJdk5NUTRxaFI5VURhK1ArWlBTR2ExUnB6NGNVd1ZjUjI4?=
 =?utf-8?B?TUFzc0p5TENMM1EvUzRGMUxmbnIxYk1iRWZEcmdHM2YzZEtnWEtINnEvRWor?=
 =?utf-8?B?bC9JbkEvdkNDQXc4Q0xjR1M5S3dsZ3lwWEJaRExUSHAxRTZoYnNuYk9PR05E?=
 =?utf-8?B?eENVdXM1SXMzbmk2MlBvelhkTHJpa1NRNkR2REMxa0hNWGJiaWxrZFVrL2o2?=
 =?utf-8?B?MXJWNlR6ZENCVGJzWnE5NmNsMGRkaFpTY0ZsSjlBSG1EckcvUzYrZWZjOUwx?=
 =?utf-8?B?YWxkSE5GZmJUR2JsTkl0dnYwTTR1b0dNTVFDajFqbzJ0WGpsekdOQVZEQjBz?=
 =?utf-8?B?QkVkMTVEN1ByS3V1TGU4R0lZNCtHVkp5UzBUNlYxSTZ3ZElhSnRYRUF6RHF5?=
 =?utf-8?B?Y2MzdnlvaXN6VnVUWk1VVGVYKzRGajJaWWx2L29xOWVDaTR5dHlWY21pb3lT?=
 =?utf-8?B?TTBoV2s3U1dqQU93V01RWGxaOUg1Z21XeXVibVFPNWQzR2ROT1JNWUdoeloy?=
 =?utf-8?B?STVYdnBBVm81RHZOVlMzK2xPbWpyelRuaGQ2Tmk3MklZZFJ6azJpTUNNbSs0?=
 =?utf-8?B?MHc3QitLYUdjNC9yNG10UTViRGxTdHNtZXprRG9EL29qWFgvVVpQZlNYR3pF?=
 =?utf-8?B?K3dGcTU4dXd1cEZnbjltVnVBNE9pZ21iSlVwMVNBTmZ0aEJiby95allCYUNU?=
 =?utf-8?B?SnhmK2hYaDVwNVNiNVR5YUR3WXlQVlJlM0Y0ZSsvMjgvcUo5aXhwTXA0MnYy?=
 =?utf-8?B?YzJwWWs5SVhMYk0zVFozcjhXUTBOMGZ4OUlkN1I4MitQN2xsRVN5UzFBTVBp?=
 =?utf-8?B?MDY1SXpOZXZ0eFBuSThSQzBFUUlMcTNacjRyU2pubDJZRzBmazlrb2FqbDJJ?=
 =?utf-8?B?RGFlNzZWZUtveWpDc0dNUzMyNlhNblZ5QTVIOFRxWlMvdzhKTmNyanY2dVpj?=
 =?utf-8?B?RHVyWDlscGFFM0RUYjh0bEJuTkFOclFTL2MyTW8vbTlYRkVydDAyNTdlSk5T?=
 =?utf-8?B?K1FYTlp4RVR0QlpWSmdTVytEMEp3YkR2Y21ZdFhvRFJUK2lDN3luZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pyrSivSPjQgmPhfuBFGe0KYmf1YeEfQbNNMc/1ZSqTmI/Z2R82bz9GFSwa4x6odiU7RtlprV2mzywpcQsNyCy3jCdKmASyg/IiT3+GYHp2M+9p8SC8C8uAfrVPJr47Jq2QLxAZwT1+G2Ipay++vT5DUaQVuo+Bygy1qmix36LKVzjdqbUOwKGq6574W/gERsJeJtCBrf+94l0CWzSJH5sCVlIqAYZF/ooFc30ihTZ8947i33UzS363xOdCae558+50cxgGq6BraInPHkoh5caQa5sQsRNz+A+4MbiyTSVA3V/sWpS3+HDq+X+smJMMwnddfck6oN0eS7dPxwd507Ig==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b8c20d-7cb0-4cc7-3f82-08dee711c9c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 10:21:11.8258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YkZDOIC9yf7hVdy2IRW/K0ZA1LqkL8xIfts9SPABplqZRhF6Q+CbmYWEBKkJy/VsyJJOd7/vVUHEGTTOE3LarisRNOdPW2VmHwj4ok+P80Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR02MB11513
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEwOSBTYWx0ZWRfX9nqlqmcX/DeX
 gXXqEUivN+pW7UGP+LF3XqkK2fnbKKHBbtLWv8mSvoJumdRWo8FW5g2CDwuS2r3Tt2l1pz4s3vk
 uEPLEnq4Hbnppzp3XIOr95lA6M+cYwk8GjOlTQeqeWfbh6HS0KcnibUzb7IsNWTRyIiwElSpmhA
 kP/0EY5EKKsQhguBVRdJzrMXLXWotInNDt68Lj/RVqaZmdJEEZ1YzmbSwJq8xMLTNKKfwqfRIKk
 SxZiv6p8MptEuz5rHbqbaF6nkV7Knpd8BKuWeeBkzd5MB75Dur8dvwjsKPuoQgWLa7fbex1NVX2
 0V5SpDXQwyzH98gPC0gSedt+Xn+eq140h8OLVwqvCK2J3n1pukY/XnQAvUnJkHi4Bf+QJf79ZGX
 MGw6li3xl0+oYlzh9eSrwnUGbGtToa+jF+5T+1vDzeIk8Sr06yR9V5DjNg+NhqmJfo6j65Q0o4h
 yDAdSsTRKyPTtgXz9yA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEwOSBTYWx0ZWRfXzaAppUFftUo2
 BlqAUBjOrwhOnIMujJuFu7Nv37aAiafgMd67cxOl7tnLyJtC5lc8x28CIiO+KpjUNdkdUdW1b52
 lNrpYFBAEokfpTTyeJEs8MPIArhhq0M=
X-Proofpoint-ORIG-GUID: 6l-TsFuQdNB1Dj08-DRmpttNWe4KpZ9o
X-Authority-Analysis: v=2.4 cv=P6UKQCAu c=1 sm=1 tr=0 ts=6a5f4819 cx=c_pps
 a=/d/dYiFJ9j2vSnh1phFeww==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22 a=RpNjiQI2AAAA:8
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=69wJf7TsAAAA:8 a=5joOT_HBOxh6B_RkQy0A:9
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: 6l-TsFuQdNB1Dj08-DRmpttNWe4KpZ9o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDIwIEp1bHkgMjAyNiAxNjoyNA0KPiBUbzogVGhhbm9z
IE1ha2F0b3MgPHRoYW5vcy5tYWthdG9zQG51dGFuaXguY29tPjsgcWVtdS0NCj4gZGV2ZWxAbm9u
Z251Lm9yZw0KPiBDYzogSm9obiBMZXZvbiA8am9obi5sZXZvbkBudXRhbml4LmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCA1LzVdIHZmaW8tdXNlcjogdmZpb191c2VyX2RldmljZV9pb19nZXRf
cmVnaW9uX2luZm86IGZpeA0KPiBjYXBhYmlsaXR5IGNoZWNrDQo+IA0KPiAhLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwN
Cj4gICBDQVVUSU9OOiBFeHRlcm5hbCBFbWFpbA0KPiANCj4gfC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0hDQo+IA0KPiBP
biA3LzIwLzI2IDExOjE3LCBUaGFub3MgTWFrYXRvcyB3cm90ZToNCj4gPiBUaGUgZXhpc3Rpbmcg
Y2hlY2sgZm9yIFBDSSBjYXBhYmlsaXRpZXMgbWlzc2VzIHRoZSBjYXNlIHdoZXJlDQo+ID4gaW5m
by0+Y2FwX29mZnNldCA9PSBpbmZvLT5hcmdzeiwgd2hpY2ggcmVzdWx0cyBpbiBhY2Nlc3Npbmcg
dW5hbGxvY2F0ZWQNCj4gPiBtZW1vcnkuIEZpeCB0aGUgY29tcGFyaXNvbi4NCj4gDQo+IFJlc29s
dmVzOiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtDQo+
IDNBX19naXRsYWIuY29tX3FlbXUtMkRwcm9qZWN0X3FlbXVfLTJEX3dvcmstDQo+IDVGaXRlbXNf
Mzg2NSZkPUR3SUNhUSZjPXM4ODNHcFVDT0NoS09IaW9jWXRHY2cmcj1YVHBZc2g1UHMyekp2dA0K
PiB3Nm9ndHRpNDZhdGs3MzZTSTR2Z3NKaVVLSXlERSZtPXltZmU5bFRjMHZHWVcySEVyX0RqbVJt
V1FHVWRybTENCj4gaTBOMDNBdlRFOEZodGpVRWxBTVdJWUl2ZENoZ3BIUW5vJnM9X1NxSEVreTN0
R09DU3FrV1Jma3FfLQ0KPiBWQ1E2NGt3Yy1XUzZMYmx5dC12dG8mZT0NCj4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogVGhhbm9zIE1ha2F0b3MgPHRoYW5vcy5tYWthdG9zQG51dGFuaXguY29tPg0KPiA+
IC0tLQ0KPiA+ICAgaHcvdmZpby11c2VyL2RldmljZS5jIHwgMiArLQ0KPiA+ICAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvaHcvdmZpby11c2VyL2RldmljZS5jIGIvaHcvdmZpby11c2VyL2RldmljZS5jDQo+ID4gaW5k
ZXggZDdjZjM5ZGRhNy4uY2U0MzdiMjQ2NCAxMDA2NDQNCj4gPiAtLS0gYS9ody92ZmlvLXVzZXIv
ZGV2aWNlLmMNCj4gPiArKysgYi9ody92ZmlvLXVzZXIvZGV2aWNlLmMNCj4gPiBAQCAtMjE1LDcg
KzIxNSw3IEBAIHN0YXRpYyBpbnQNCj4gdmZpb191c2VyX2RldmljZV9pb19nZXRfcmVnaW9uX2lu
Zm8oVkZJT0RldmljZSAqdmJhc2VkZXYsDQo+ID4NCj4gPiAgICAgICAvKiBjYXBfb2Zmc2V0IGlu
IHZhbGlkIGFyZWEgKi8NCj4gPiAgICAgICBpZiAoKGluZm8tPmZsYWdzICYgVkZJT19SRUdJT05f
SU5GT19GTEFHX0NBUFMpICYmDQo+ID4gLSAgICAgICAgKGluZm8tPmNhcF9vZmZzZXQgPCBzaXpl
b2YoKmluZm8pIHx8IGluZm8tPmNhcF9vZmZzZXQgPiBpbmZvLT5hcmdzeikpIHsNCj4gPiArICAg
ICAgICAoaW5mby0+Y2FwX29mZnNldCA8IHNpemVvZigqaW5mbykgfHwgaW5mby0+Y2FwX29mZnNl
dCA+PSBpbmZvLT5hcmdzeikpIHsNCj4gDQo+IE1heSBiZSA6DQo+IA0KPiAgICAgICAgIGluZm8t
PmNhcF9vZmZzZXQgKyBzaXplb2Yoc3RydWN0IHZmaW9faW5mb19jYXBfaGVhZGVyKSA+IGluZm8t
PmFyZ3N6DQo+IA0KPiBUaGlzZW5zdXJlcyBhdCBsZWFzdCBhIGZ1bGwgY2FwYWJpbGl0eSBoZWFk
ZXIgZml0cy4NCg0KU3VyZS4NCg0KPiANCj4gQXMgeW91IHdpc2gsDQo+IA0KPiBUaGFua3MsDQo+
IA0KPiBDLg0KPiANCg0K

