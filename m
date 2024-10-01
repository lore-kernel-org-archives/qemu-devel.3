Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4D3CEACD5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 15:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfBY-0003rZ-2S; Tue, 01 Oct 2024 11:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=0004f12e58=thrimurthi.manju@windriver.com>)
 id 1svdkU-00040g-16
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:21:12 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=0004f12e58=thrimurthi.manju@windriver.com>)
 id 1svdkI-00055O-8x
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:21:06 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4915iSfR015641
 for <qemu-devel@nongnu.org>; Tue, 1 Oct 2024 11:09:27 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41x8s8ba9y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 11:09:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIqYMeEa9W9SKqkpxjSASmBiKXXp/f8u986s7VBmEqZCTH4yDaiK3DJocFX7CUfWPWaXsMNq1YWqipmdDlQ9+TNls1uAy8EWEsEaEKliDdp1c5gyqk4qOQ/z1gCoKfpLET09pvjOHbBgM6Tti1CQOIhAs3hwZf9PPMELN18wRDsDBrMoQSdrpTKqbPyalIOszlFPVKy7UNUnkYk78a3r7KxSu8KCZwsXTTSrDyuXz3zzwWodZ1kf0vRfDCGreqOWFITAVaLChP+Fz+pzDM082KQqZ5NZQbegfJwqJo1rasW8PSXUz1rB1DF6+TC09suTeR0Hf4y9jbU9IJRzqMDOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dui53AQG593KTQapfIPAJPEUqypN9/vX30pGrpJv+CA=;
 b=PnFnXgP+WVqWduN6fFGn+VtR/9eIT1S/aQ23Eoub2On4Qk93g5usopCEwtYoTnkwSIPTal4loW4x1cSuXtOh5vSwWQqmCF9XlO2LJyAKpjGmLYGVpSJ9e9xfnf7NyVybiBafc0Wv9grOcAOgg+zdl+Nogogp+qPFWKZ34aA0AbIEZu0traCjVivR03IcFygoCqtnEcht2PxlhpiWDlsLkebU3Q9i4KeaUjP+4Eh+j/cYF0r0vVaA3b5P9qp9HcAl59dOJAXGMgVR4n/pDRA3skwlvJu9SlomenJEKCkZzLwUNTdpTfQjGroAqWoqZjMTCJjc0zWnrbi/RUPwssDEcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA0PR11MB4528.namprd11.prod.outlook.com (2603:10b6:806:99::12)
 by IA0PR11MB7956.namprd11.prod.outlook.com (2603:10b6:208:40b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 11:09:20 +0000
Received: from SA0PR11MB4528.namprd11.prod.outlook.com
 ([fe80::8c33:1996:10fc:d8fd]) by SA0PR11MB4528.namprd11.prod.outlook.com
 ([fe80::8c33:1996:10fc:d8fd%6]) with mapi id 15.20.8026.016; Tue, 1 Oct 2024
 11:09:19 +0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Request support for Intel Cyclone V board
Thread-Topic: Request support for Intel Cyclone V board
Thread-Index: AQHbE/ACU2/hZ5SUwE+IIDhWvBsrdg==
Date: Tue, 1 Oct 2024 11:09:18 +0000
Message-ID: <SA0PR11MB45282661A3B017FCB86D98CC90772@SA0PR11MB4528.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4528:EE_|IA0PR11MB7956:EE_
x-ms-office365-filtering-correlation-id: a696fa31-61e5-461b-7bbc-08dce2097ecb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?Windows-1252?Q?H/3cM6Mdi1HHFkWsHGfBt0rdrWnxYnfhrlNCLjB1pX5oQKuToqYc9G5I?=
 =?Windows-1252?Q?Hr3ZJeSOrm0TaNyhl/fLXRyNVPd4pJ8KS/8NHY9ku+mLVvyUledxH3ck?=
 =?Windows-1252?Q?JrO5dehRzPUneL/dWjSk73pyItk19Ho6TwGrj1w7+dt5hAy4OlvM/1Sy?=
 =?Windows-1252?Q?84KfBYqKMl2yRtV9SE66Hmw1wK956C4HaB4+OyCAU81DbKEKOh6Jvw0f?=
 =?Windows-1252?Q?qdUrHsUD5hRStTy7CQVafW43d6MVOAzin6te0q3OHFkexJDwulMXDFus?=
 =?Windows-1252?Q?jlCLUHeoC6HXM9XpSOaAIQjIAIFobeqLShs6oSU748164OsNA1n7CC7/?=
 =?Windows-1252?Q?GyHkHdNMI6OAyfqn7zZdjZYDIt52OclW0E+jrFSVkp1AaW6nPQlP7zph?=
 =?Windows-1252?Q?/GAnLgIgZ0OPATQ0k0Fu9QItb5iM3UZmt+vsoDm5j66LUySrFxhnkzT4?=
 =?Windows-1252?Q?O1iMyli1hRTrl8B1qT/jKSWBMQEBH2/1ry/MpphPsxiiiCuxgoD+SNuO?=
 =?Windows-1252?Q?Ly0UvFzPzkGRKiC/2WxptUUj8LIzXYMmijrvqAduJKZvnUwFV7SP7Hc/?=
 =?Windows-1252?Q?OpKg4HbSQroFXb6Vk5Juxa4w1rW61jtdjk7DMy4aGoEJVz1xXo7hLEKY?=
 =?Windows-1252?Q?AJan9LJaTmckBhrzQqBycYKfnCrIgTvEFD3AlYRZbmagvnGTm/a0H097?=
 =?Windows-1252?Q?dsDc8PNqjCRJYXxE3dDeITfcSpi73ag99jiPt5AIgwf/3KS4Y/OzYc6e?=
 =?Windows-1252?Q?Z/UA6zz7YDJ66b+hlC9jc+uM2UUqg9HeM7wTEkd7NQvGG+A4/LBREQLI?=
 =?Windows-1252?Q?bsG76FH43kLonn3dT1MtBVcu3PQ31scBBGtfWQqJXSN7iobQqWGsW6e5?=
 =?Windows-1252?Q?BxyRJ+NxcCRSHnOnUxuK6JGNpWI6OrxnHGg5HMVdU6lRLELMcihvkDn8?=
 =?Windows-1252?Q?ZnKk8NJrkaT1gk/zoBUQHoCSQIP2jAxwyrf3c1PNnY4Va6JIR8TtTr4n?=
 =?Windows-1252?Q?qKSq+B6q5/+f0olnTVNk4WyNIBGCUDvB/9vhYGRJxKQIQJNeDyKIm/OX?=
 =?Windows-1252?Q?02eGY/cFnVDjL882LmCuvmsGn1WFd6UQXdmVCCcjkDXImFFI5x7jMifw?=
 =?Windows-1252?Q?I+eM9Fj2k2eYV/6sBQ/1m+rZMq6nmd3+TS39nlUBTWEUp+jC73QPC7Fx?=
 =?Windows-1252?Q?23HxKVTcPZl0WD6cmiG3ia9dqRG0DboxtSwDWFC7DfhQS0dI/oBNRvg1?=
 =?Windows-1252?Q?lB7lAYFGUN72j3xOgdAu2QFUR3Xq8KLdCbIiVDJkgRjXjqgB78+QC0nq?=
 =?Windows-1252?Q?rG0HGJrv4AJEWbVdTc2VkWYArxzCdZ94PyYHzYalLOFOu2DNGMUZ3d1K?=
 =?Windows-1252?Q?IFsf/DCek/b7IQY7W6hxP++CpDHEd348YA+WZQOzO/zw6XZt8Ul2hvjO?=
 =?Windows-1252?Q?cJ1l2HwUFhEH1bJYST5DEMGgVMUjU+44qP/Vbht0k0A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR11MB4528.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?0e+W9JbwbH1stPaYQ1jKzpbPlU6cOqX2Fevaf6pikwvQZWE4opzDSiHQ?=
 =?Windows-1252?Q?ACCM2HWWkZmJVdVUBdnGbYJ8s1h5OT1iZJ76ubMiqY9nOwcv8xq/50Gc?=
 =?Windows-1252?Q?PLLvrfQ0GPmdrA3HaM2MI6+OjEF8wGNXYOcgyrowLMILkqViRmUehb2d?=
 =?Windows-1252?Q?gFiW4iQ4C4HcC9zy+liiCHVQSiE6Ihs4CwRTFhbRlwjFe6M6RVS6UmSp?=
 =?Windows-1252?Q?grYTGFigzN2CRd7LzY1IZyhJBhWJsHjaLLs19WGoCswbRIw6ObSBF1DH?=
 =?Windows-1252?Q?qzeOwPX2oSxPj58LcshtI14jRlxNYc5V6/09be01dTa7mTe/gHqnfBmK?=
 =?Windows-1252?Q?yOReykc6sxnrmXehIS3H2+768H/g6jV3J/9+UhSZUmOd2/PAJiDbCVwd?=
 =?Windows-1252?Q?ceIWkYk6KZKmqamcCWXJ+qUuNGJIhi2Lu9uSoD5njGRyObYrwAWidsHD?=
 =?Windows-1252?Q?yGvOtUrBe1V+URUgUoZcYQkgRKLPpEVOJNRneBNuikF/pYibYwh26TvF?=
 =?Windows-1252?Q?LMeAyinXWQoi7RN4pvtguQslWcxwK56784o1y5Y/B1W5uHzghpxP3CRh?=
 =?Windows-1252?Q?sj4UoBQMPeT4fSUk3zj7kNJdQZVLLzqQUj09vnrWveHo8z1jjee80UuX?=
 =?Windows-1252?Q?hvTz+FBY9w+/ieZGgu5zYHgiDqVxvdihozzTDCa1jQqRQbCCE7SmvYu/?=
 =?Windows-1252?Q?mKtmWVdS5/fDBeTOWpvAulGA2WqvDQ/+3ZYz3oJ1AL7F08frGn9382KC?=
 =?Windows-1252?Q?dGa3imXpIil4CxN9YscBWG002T05mGlERsEI/PjcfutbBXUKYwq3LXE6?=
 =?Windows-1252?Q?l2jyhjXN7ZZVMESEA3D85WO/auAF3CpQi13Gli604JqrAlrpufoOYMtt?=
 =?Windows-1252?Q?1bI8vYuJJ+wKjUNWbLKVm/rXBdcQyggPtj6mO9HbEpVEzEP8NeJfm1SX?=
 =?Windows-1252?Q?2whIIyT/6qjReOxd+0oe9RAGiobqX06SrGXeR1mJF2BWlPx5DPBgtTgb?=
 =?Windows-1252?Q?xHXVt3AXSlrE3ht4m8yHJB7d48kCLOzz3Xk3+Ur7MjDg4G/EGAfKpZEU?=
 =?Windows-1252?Q?obdclFWT22fGxHzWdZpOUNf0F3MQrN2TExhk1OyBrIujZ856B6LXPq4+?=
 =?Windows-1252?Q?p2KU3cAZY+oM1+AwtMgIvzMzNQyKHKEko+KUJQ+jMTnCRcYtHvw/7JE2?=
 =?Windows-1252?Q?k/lmBoOJIbFSheubwB4LG8r2xUwsHZlKSoJRM3PfMZVtVDiquUWeP/A0?=
 =?Windows-1252?Q?xoYSw9vSWtwSuKvD5hLsfYcCF44tb+3YmfGy/RU2JQUkzOozDEqW3phk?=
 =?Windows-1252?Q?8vr23Vujo1NoLNEfJ3miTNYYwkIUNQ2rnI21t5lDUW496N1U4bLyPSVp?=
 =?Windows-1252?Q?L0nTePnlE+jfEhY64B7NATqZmCFAkStDNoFPAPMuJuOm3IpcOrd12bYu?=
 =?Windows-1252?Q?KooE6TrXrf8Li4GOhG5myRpfGoa9I/njhntEkYaOSFK9kp3OCfLkqWtn?=
 =?Windows-1252?Q?sShb6hNSE/E1ToOA1LD+mXO/wJRdsSHWWyeRYpIA8+O+wgP6a/cdukSZ?=
 =?Windows-1252?Q?oEbQKY5qZbt2WtrZ6a+xYUNuARCmbDCmmP32DcHJm5ndh/RPHnS/CdXa?=
 =?Windows-1252?Q?hMVfzyu9u6M2AcRrPPh1hweaK6JVFy8yZouvrlENyeIcsEhU/2TcDtGp?=
 =?Windows-1252?Q?C1Ya6i485rVkzzz0J7A1dGNJeNQMSE9LY/jqUM5krUnmPfGoG64zgw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SA0PR11MB45282661A3B017FCB86D98CC90772SA0PR11MB4528namp_"
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4528.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a696fa31-61e5-461b-7bbc-08dce2097ecb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 11:09:18.9338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5BxfREp5rpCP0h54wbCvwIA5YW8iGca3Oj2ZoGt06prNztAuBjxdq/hHJiy3uQ+JnWKyF/um3/ihXP4WGcTmzoNfmgskgKH8Zzaw0QgzhOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7956
X-Authority-Analysis: v=2.4 cv=VaulP0p9 c=1 sm=1 tr=0 ts=66fbd867 cx=c_pps
 a=uuboLt+qr3MZZMeqEnD08g==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=bRTqI5nwn0kA:10 a=ID6ng7r3AAAA:8
 a=qQUGGpDxJbs64lVHEfYA:9 a=pILNOxqGKmIA:10
 a=g88EVPPLcap20AIObJEA:9 a=9q4q3uLWFD2r_5yF:21 a=frz4AuCg-hUA:10
 a=_W_S_7VecoQA:10 a=AkheI1RvQwOzcTXhi5f4:22
X-Proofpoint-GUID: A79bWWwXnZP53TVPZF7qYlgMzSTcIXlp
X-Proofpoint-ORIG-GUID: A79bWWwXnZP53TVPZF7qYlgMzSTcIXlp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_07,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=538 suspectscore=0 clxscore=1011 mlxscore=0 impostorscore=0
 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2408220000 definitions=main-2410010073
Received-SPF: pass client-ip=205.220.178.238;
 envelope-from=prvs=0004f12e58=thrimurthi.manju@windriver.com;
 helo=mx0b-0064b401.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 01 Oct 2024 11:53:01 -0400
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
Reply-to:  "Manju, Thrimurthi" <Thrimurthi.Manju@windriver.com>
From:  "Manju, Thrimurthi" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--_000_SA0PR11MB45282661A3B017FCB86D98CC90772SA0PR11MB4528namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Team,

I want to test my VxWorks image in to Intel Cyclone V board, Currently we d=
on't have Cyclone V board. So I need to test this image into QEMU simulator=
.

I have built and installed master branch QEMU from https://git.qemu.org/git=
/qemu.git

Steps As below:
git clone https://git.qemu.org/git/qemu.git
cd qemu
./configure --target-list=3Darm-softmmu
make -j$(nproc)
sudo apt install qemu

Qemu-system-arm =97version
QEMU emulator version 9.1.50 (v9.1.0-561-g3b14a767ea)
Copyright (c) 2003-2024 Fabrice Bellard and the QEMU Project developers

qemu-system-arm -machine help
Supported machines are:
akita                Sharp SL-C1000 (Akita) PDA (PXA270) (deprecated)
ast1030-evb          Aspeed AST1030 MiniBMC (Cortex-M4)
ast2500-evb          Aspeed AST2500 EVB (ARM1176)
ast2600-evb          Aspeed AST2600 EVB (Cortex-A7)
b-l475e-iot01a       B-L475E-IOT01A Discovery Kit (Cortex-M4)
bletchley-bmc        Facebook Bletchley BMC (Cortex-A7)
borzoi               Sharp SL-C3100 (Borzoi) PDA (PXA270) (deprecated)
bpim2u               Bananapi M2U (Cortex-A7)
canon-a1100          Canon PowerShot A1100 IS (ARM946)
cheetah              Palm Tungsten|E aka. Cheetah PDA (OMAP310) (deprecated=
)
collie               Sharp SL-5500 (Collie) PDA (SA-1110)
connex               Gumstix Connex (PXA255) (deprecated)
cubieboard           cubietech cubieboard (Cortex-A8)
emcraft-sf2          SmartFusion2 SOM kit from Emcraft (M2S010)
fby35-bmc            Facebook fby35 BMC (Cortex-A7)
fby35                Meta Platforms fby35
fp5280g2-bmc         Inspur FP5280G2 BMC (ARM1176)
fuji-bmc             Facebook Fuji BMC (Cortex-A7)
g220a-bmc            Bytedance G220A BMC (ARM1176)
highbank             Calxeda Highbank (ECX-1000)
imx25-pdk            ARM i.MX25 PDK board (ARM926)
integratorcp         ARM Integrator/CP (ARM926EJ-S)
kudo-bmc             Kudo BMC (Cortex-A9)
kzm                  ARM KZM Emulation Baseboard (ARM1136)
lm3s6965evb          Stellaris LM3S6965EVB (Cortex-M3)
lm3s811evb           Stellaris LM3S811EVB (Cortex-M3)
mainstone            Mainstone II (PXA27x) (deprecated)
mcimx6ul-evk         Freescale i.MX6UL Evaluation Kit (Cortex-A7)
mcimx7d-sabre        Freescale i.MX7 DUAL SABRE (Cortex-A7)
microbit             BBC micro:bit (Cortex-M0)
midway               Calxeda Midway (ECX-2000)
mori-bmc             Mori BMC (Cortex-A9)
mps2-an385           ARM MPS2 with AN385 FPGA image for Cortex-M3
mps2-an386           ARM MPS2 with AN386 FPGA image for Cortex-M4
mps2-an500           ARM MPS2 with AN500 FPGA image for Cortex-M7
mps2-an505           ARM MPS2 with AN505 FPGA image for Cortex-M33
mps2-an511           ARM MPS2 with AN511 DesignStart FPGA image for Cortex-=
M3
mps2-an521           ARM MPS2 with AN521 FPGA image for dual Cortex-M33
mps3-an524           ARM MPS3 with AN524 FPGA image for dual Cortex-M33
mps3-an536           ARM MPS3 with AN536 FPGA image for Cortex-R52
mps3-an547           ARM MPS3 with AN547 FPGA image for Cortex-M55
musca-a              ARM Musca-A board (dual Cortex-M33)
musca-b1             ARM Musca-B1 board (dual Cortex-M33)
musicpal             Marvell 88w8618 / MusicPal (ARM926EJ-S)
n800                 Nokia N800 tablet aka. RX-34 (OMAP2420) (deprecated)
n810                 Nokia N810 tablet aka. RX-44 (OMAP2420) (deprecated)
netduino2            Netduino 2 Machine (Cortex-M3)
netduinoplus2        Netduino Plus 2 Machine (Cortex-M4)
none                 empty machine
npcm750-evb          Nuvoton NPCM750 Evaluation Board (Cortex-A9)
nuri                 Samsung NURI board (Exynos4210)
olimex-stm32-h405    Olimex STM32-H405 (Cortex-M4)
orangepi-pc          Orange Pi PC (Cortex-A7)
palmetto-bmc         OpenPOWER Palmetto BMC (ARM926EJ-S)
qcom-dc-scm-v1-bmc   Qualcomm DC-SCM V1 BMC (Cortex A7)
qcom-firework-bmc    Qualcomm DC-SCM V1/Firework BMC (Cortex A7)
quanta-gbs-bmc       Quanta GBS (Cortex-A9)
quanta-gsj           Quanta GSJ (Cortex-A9)
quanta-q71l-bmc      Quanta-Q71l BMC (ARM926EJ-S)
rainier-bmc          IBM Rainier BMC (Cortex-A7)
raspi0               Raspberry Pi Zero (revision 1.2)
raspi1ap             Raspberry Pi A+ (revision 1.1)
raspi2b              Raspberry Pi 2B (revision 1.1)
realview-eb          ARM RealView Emulation Baseboard (ARM926EJ-S)
realview-eb-mpcore   ARM RealView Emulation Baseboard (ARM11MPCore)
realview-pb-a8       ARM RealView Platform Baseboard for Cortex-A8
realview-pbx-a9      ARM RealView Platform Baseboard Explore for Cortex-A9
romulus-bmc          OpenPOWER Romulus BMC (ARM1176)
sabrelite            Freescale i.MX6 Quad SABRE Lite Board (Cortex-A9)
smdkc210             Samsung SMDKC210 board (Exynos4210)
sonorapass-bmc       OCP SonoraPass BMC (ARM1176)
spitz                Sharp SL-C3000 (Spitz) PDA (PXA270) (deprecated)
stm32vldiscovery     ST STM32VLDISCOVERY (Cortex-M3)
supermicro-x11spi-bmc Supermicro X11 SPI BMC (ARM1176)
supermicrox11-bmc    Supermicro X11 BMC (ARM926EJ-S)
sx1                  Siemens SX1 (OMAP310) V2
sx1-v1               Siemens SX1 (OMAP310) V1
tacoma-bmc           OpenPOWER Tacoma BMC (Cortex-A7) (deprecated)
terrier              Sharp SL-C3200 (Terrier) PDA (PXA270) (deprecated)
tiogapass-bmc        Facebook Tiogapass BMC (ARM1176)
tosa                 Sharp SL-6000 (Tosa) PDA (PXA255) (deprecated)
verdex               Gumstix Verdex Pro XL6P COMs (PXA270) (deprecated)
versatileab          ARM Versatile/AB (ARM926EJ-S)
versatilepb          ARM Versatile/PB (ARM926EJ-S)
vexpress-a15         ARM Versatile Express for Cortex-A15
vexpress-a9          ARM Versatile Express for Cortex-A9
virt-2.10            QEMU 2.10 ARM Virtual Machine (deprecated)
virt-2.11            QEMU 2.11 ARM Virtual Machine (deprecated)
virt-2.12            QEMU 2.12 ARM Virtual Machine (deprecated)
virt-2.6             QEMU 2.6 ARM Virtual Machine (deprecated)
virt-2.7             QEMU 2.7 ARM Virtual Machine (deprecated)
virt-2.8             QEMU 2.8 ARM Virtual Machine (deprecated)
virt-2.9             QEMU 2.9 ARM Virtual Machine (deprecated)
virt-3.0             QEMU 3.0 ARM Virtual Machine (deprecated)
virt-3.1             QEMU 3.1 ARM Virtual Machine (deprecated)
virt-4.0             QEMU 4.0 ARM Virtual Machine (deprecated)
virt-4.1             QEMU 4.1 ARM Virtual Machine (deprecated)
virt-4.2             QEMU 4.2 ARM Virtual Machine (deprecated)
virt-5.0             QEMU 5.0 ARM Virtual Machine (deprecated)
virt-5.1             QEMU 5.1 ARM Virtual Machine (deprecated)
virt-5.2             QEMU 5.2 ARM Virtual Machine (deprecated)
virt-6.0             QEMU 6.0 ARM Virtual Machine (deprecated)
virt-6.1             QEMU 6.1 ARM Virtual Machine (deprecated)
virt-6.2             QEMU 6.2 ARM Virtual Machine
virt-7.0             QEMU 7.0 ARM Virtual Machine
virt-7.1             QEMU 7.1 ARM Virtual Machine
virt-7.2             QEMU 7.2 ARM Virtual Machine
virt-8.0             QEMU 8.0 ARM Virtual Machine
virt-8.1             QEMU 8.1 ARM Virtual Machine
virt-8.2             QEMU 8.2 ARM Virtual Machine
virt-9.0             QEMU 9.0 ARM Virtual Machine
virt-9.1             QEMU 9.1 ARM Virtual Machine
virt                 QEMU 9.2 ARM Virtual Machine (alias of virt-9.2)
virt-9.2             QEMU 9.2 ARM Virtual Machine
witherspoon-bmc      OpenPOWER Witherspoon BMC (ARM1176)
xilinx-zynq-a9       Xilinx Zynq Platform Baseboard for Cortex-A9
yosemitev2-bmc       Facebook YosemiteV2 BMC (ARM1176)
z2                   Zipit Z2 (PXA27x) (deprecated)


I did not find intel cyclone V Soc here. How add and simulate intel cyclone=
 V Soc with QEMU?

Please do the needful.

Thank You
Regards,
Thrimurthi M


--_000_SA0PR11MB45282661A3B017FCB86D98CC90772SA0PR11MB4528namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Team,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I want to test my VxWorks image in to Intel Cyclone V board, Currently we d=
on't have Cyclone V board. So I need to test this image into QEMU simulator=
.&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I have built and installed master branch QEMU from <a href=3D"https://git.q=
emu.org/git/qemu.git" id=3D"OWA7cdb2193-eb0a-0524-0bcb-b44a7750868f" class=
=3D"OWAAutoLink">
https://git.qemu.org/git/qemu.git</a></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Steps As below:</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
<i>git clone <a href=3D"https://git.qemu.org/git/qemu.git" id=3D"OWA0953307=
2-605a-48d8-13bb-8365a55875e3" class=3D"OWAAutoLink">
https://git.qemu.org/git/qemu.git</a></i></div>
<div style=3D"margin: 0in; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MS=
FontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
<i>cd qemu</i></div>
<div style=3D"margin: 0in; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MS=
FontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
<i>./configure --target-list=3Darm-softmmu</i></div>
<div style=3D"margin: 0in; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MS=
FontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
<i>make -j$(nproc)</i></div>
<div style=3D"margin: 0in; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MS=
FontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
<i>sudo apt install qemu</i></div>
<div style=3D"margin: 0in; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MS=
FontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
<b><i>Qemu-system-arm =97version&nbsp;</i></b></div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
QEMU emulator version 9.1.50 (v9.1.0-561-g3b14a767ea)<br>
Copyright (c) 2003-2024 Fabrice Bellard and the QEMU Project developers</di=
v>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
<b><i>qemu-system-arm -machine help</i></b></div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
Supported machines are:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
akita &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Sharp SL-C1000=
 (Akita) PDA (PXA270) (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
ast1030-evb &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Aspeed AST1030 MiniBMC (Corte=
x-M4)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
ast2500-evb &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Aspeed AST2500 EVB (ARM1176)<=
/div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
ast2600-evb &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Aspeed AST2600 EVB (Cortex-A7=
)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
b-l475e-iot01a &nbsp; &nbsp; &nbsp; B-L475E-IOT01A Discovery Kit (Cortex-M4=
)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
bletchley-bmc &nbsp; &nbsp; &nbsp; &nbsp;Facebook Bletchley BMC (Cortex-A7)=
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
borzoi &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Sharp SL-C3100 (Bor=
zoi) PDA (PXA270) (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
bpim2u &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Bananapi M2U (Corte=
x-A7)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
canon-a1100 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Canon PowerShot A1100 IS (ARM=
946)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
cheetah &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Palm Tungsten|E aka=
. Cheetah PDA (OMAP310) (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
collie &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Sharp SL-5500 (Coll=
ie) PDA (SA-1110)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
connex &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Gumstix Connex (PXA=
255) (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
cubieboard &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; cubietech cubieboard (Cortex-=
A8)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
emcraft-sf2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;SmartFusion2 SOM kit from Emc=
raft (M2S010)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
fby35-bmc &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Facebook fby35 BMC (Cort=
ex-A7)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
fby35 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Meta Platforms=
 fby35</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
fp5280g2-bmc &nbsp; &nbsp; &nbsp; &nbsp; Inspur FP5280G2 BMC (ARM1176)</div=
>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
fuji-bmc &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Facebook Fuji BMC (Corte=
x-A7)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
g220a-bmc &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Bytedance G220A BMC (ARM=
1176)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
highbank &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Calxeda Highbank (ECX-10=
00)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
imx25-pdk &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ARM i.MX25 PDK board (AR=
M926)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
integratorcp &nbsp; &nbsp; &nbsp; &nbsp; ARM Integrator/CP (ARM926EJ-S)</di=
v>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
kudo-bmc &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Kudo BMC (Cortex-A9)</di=
v>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
kzm &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ARM KZM E=
mulation Baseboard (ARM1136)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
lm3s6965evb &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Stellaris LM3S6965EVB (Cortex=
-M3)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
lm3s811evb &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Stellaris LM3S811EVB (Cortex-=
M3)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
mainstone &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Mainstone II (PXA27x) (d=
eprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
mcimx6ul-evk &nbsp; &nbsp; &nbsp; &nbsp; Freescale i.MX6UL Evaluation Kit (=
Cortex-A7)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
mcimx7d-sabre &nbsp; &nbsp; &nbsp; &nbsp;Freescale i.MX7 DUAL SABRE (Cortex=
-A7)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
microbit &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; BBC micro:bit (Cortex-M0=
)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
midway &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Calxeda Midway (ECX=
-2000)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
mori-bmc &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Mori BMC (Cortex-A9)</di=
v>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
mps2-an385 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ARM MPS2 with AN385 FPGA imag=
e for Cortex-M3</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
mps2-an386 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ARM MPS2 with AN386 FPGA imag=
e for Cortex-M4</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
mps2-an500 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ARM MPS2 with AN500 FPGA imag=
e for Cortex-M7</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
mps2-an505 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ARM MPS2 with AN505 FPGA imag=
e for Cortex-M33</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
mps2-an511 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ARM MPS2 with AN511 DesignSta=
rt FPGA image for Cortex-M3</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
mps2-an521 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ARM MPS2 with AN521 FPGA imag=
e for dual Cortex-M33</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
mps3-an524 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ARM MPS3 with AN524 FPGA imag=
e for dual Cortex-M33</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
mps3-an536 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ARM MPS3 with AN536 FPGA imag=
e for Cortex-R52</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
mps3-an547 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ARM MPS3 with AN547 FPGA imag=
e for Cortex-M55</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
musca-a &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ARM Musca-A board (=
dual Cortex-M33)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
musca-b1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ARM Musca-B1 board (dual=
 Cortex-M33)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
musicpal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Marvell 88w8618 / MusicP=
al (ARM926EJ-S)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
n800 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Nokia N800 tab=
let aka. RX-34 (OMAP2420) (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
n810 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Nokia N810 tab=
let aka. RX-44 (OMAP2420) (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
netduino2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Netduino 2 Machine (Cort=
ex-M3)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
netduinoplus2 &nbsp; &nbsp; &nbsp; &nbsp;Netduino Plus 2 Machine (Cortex-M4=
)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
none &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; empty machine<=
/div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
npcm750-evb &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Nuvoton NPCM750 Evaluation Bo=
ard (Cortex-A9)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
nuri &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Samsung NURI b=
oard (Exynos4210)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
olimex-stm32-h405 &nbsp; &nbsp;Olimex STM32-H405 (Cortex-M4)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
orangepi-pc &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Orange Pi PC (Cortex-A7)</div=
>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
palmetto-bmc &nbsp; &nbsp; &nbsp; &nbsp; OpenPOWER Palmetto BMC (ARM926EJ-S=
)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
qcom-dc-scm-v1-bmc &nbsp; Qualcomm DC-SCM V1 BMC (Cortex A7)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
qcom-firework-bmc &nbsp; &nbsp;Qualcomm DC-SCM V1/Firework BMC (Cortex A7)<=
/div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
quanta-gbs-bmc &nbsp; &nbsp; &nbsp; Quanta GBS (Cortex-A9)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
quanta-gsj &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Quanta GSJ (Cortex-A9)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
quanta-q71l-bmc &nbsp; &nbsp; &nbsp;Quanta-Q71l BMC (ARM926EJ-S)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
rainier-bmc &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;IBM Rainier BMC (Cortex-A7)</=
div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
raspi0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Raspberry Pi Zero (=
revision 1.2)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
raspi1ap &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Raspberry Pi A+ (revisio=
n 1.1)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
raspi2b &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Raspberry Pi 2B (re=
vision 1.1)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
realview-eb &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ARM RealView Emulation Basebo=
ard (ARM926EJ-S)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
realview-eb-mpcore &nbsp; ARM RealView Emulation Baseboard (ARM11MPCore)</d=
iv>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
realview-pb-a8 &nbsp; &nbsp; &nbsp; ARM RealView Platform Baseboard for Cor=
tex-A8</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
realview-pbx-a9 &nbsp; &nbsp; &nbsp;ARM RealView Platform Baseboard Explore=
 for Cortex-A9</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
romulus-bmc &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;OpenPOWER Romulus BMC (ARM117=
6)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
sabrelite &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Freescale i.MX6 Quad SAB=
RE Lite Board (Cortex-A9)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
smdkc210 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Samsung SMDKC210 board (=
Exynos4210)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
sonorapass-bmc &nbsp; &nbsp; &nbsp; OCP SonoraPass BMC (ARM1176)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
spitz &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Sharp SL-C3000=
 (Spitz) PDA (PXA270) (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
stm32vldiscovery &nbsp; &nbsp; ST STM32VLDISCOVERY (Cortex-M3)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
supermicro-x11spi-bmc Supermicro X11 SPI BMC (ARM1176)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
supermicrox11-bmc &nbsp; &nbsp;Supermicro X11 BMC (ARM926EJ-S)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
sx1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Siemens S=
X1 (OMAP310) V2</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
sx1-v1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Siemens SX1 (OMAP31=
0) V1</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
tacoma-bmc &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; OpenPOWER Tacoma BMC (Cortex-=
A7) (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
terrier &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Sharp SL-C3200 (Ter=
rier) PDA (PXA270) (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
tiogapass-bmc &nbsp; &nbsp; &nbsp; &nbsp;Facebook Tiogapass BMC (ARM1176)</=
div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
tosa &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Sharp SL-6000 =
(Tosa) PDA (PXA255) (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
verdex &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Gumstix Verdex Pro =
XL6P COMs (PXA270) (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
versatileab &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ARM Versatile/AB (ARM926EJ-S)=
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
versatilepb &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ARM Versatile/PB (ARM926EJ-S)=
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
vexpress-a15 &nbsp; &nbsp; &nbsp; &nbsp; ARM Versatile Express for Cortex-A=
15</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
vexpress-a9 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ARM Versatile Express for Cor=
tex-A9</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-2.10 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;QEMU 2.10 ARM Virtual Ma=
chine (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-2.11 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;QEMU 2.11 ARM Virtual Ma=
chine (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-2.12 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;QEMU 2.12 ARM Virtual Ma=
chine (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-2.6 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; QEMU 2.6 ARM Virtual Mac=
hine (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-2.7 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; QEMU 2.7 ARM Virtual Mac=
hine (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-2.8 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; QEMU 2.8 ARM Virtual Mac=
hine (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-2.9 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; QEMU 2.9 ARM Virtual Mac=
hine (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-3.0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; QEMU 3.0 ARM Virtual Mac=
hine (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-3.1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; QEMU 3.1 ARM Virtual Mac=
hine (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-4.0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; QEMU 4.0 ARM Virtual Mac=
hine (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-4.1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; QEMU 4.1 ARM Virtual Mac=
hine (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-4.2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; QEMU 4.2 ARM Virtual Mac=
hine (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-5.0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; QEMU 5.0 ARM Virtual Mac=
hine (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-5.1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; QEMU 5.1 ARM Virtual Mac=
hine (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-5.2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; QEMU 5.2 ARM Virtual Mac=
hine (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-6.0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; QEMU 6.0 ARM Virtual Mac=
hine (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-6.1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; QEMU 6.1 ARM Virtual Mac=
hine (deprecated)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-6.2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; QEMU 6.2 ARM Virtual Mac=
hine</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-7.0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; QEMU 7.0 ARM Virtual Mac=
hine</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-7.1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; QEMU 7.1 ARM Virtual Mac=
hine</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-7.2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; QEMU 7.2 ARM Virtual Mac=
hine</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-8.0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; QEMU 8.0 ARM Virtual Mac=
hine</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-8.1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; QEMU 8.1 ARM Virtual Mac=
hine</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-8.2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; QEMU 8.2 ARM Virtual Mac=
hine</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-9.0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; QEMU 9.0 ARM Virtual Mac=
hine</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-9.1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; QEMU 9.1 ARM Virtual Mac=
hine</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; QEMU 9.2 ARM V=
irtual Machine (alias of virt-9.2)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
virt-9.2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; QEMU 9.2 ARM Virtual Mac=
hine</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
witherspoon-bmc &nbsp; &nbsp; &nbsp;OpenPOWER Witherspoon BMC (ARM1176)</di=
v>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
xilinx-zynq-a9 &nbsp; &nbsp; &nbsp; Xilinx Zynq Platform Baseboard for Cort=
ex-A9</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
yosemitev2-bmc &nbsp; &nbsp; &nbsp; Facebook YosemiteV2 BMC (ARM1176)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
z2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Zipit Z2 =
(PXA27x) (deprecated)</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
I did not find intel cyclone V Soc here. How add and simulate intel cyclone=
 V Soc with QEMU?&nbsp;</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
Please do the needful.</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
Thank You</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"margin: 0in; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">
Thrimurthi M</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;</div>
</body>
</html>

--_000_SA0PR11MB45282661A3B017FCB86D98CC90772SA0PR11MB4528namp_--

