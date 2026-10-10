Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FC4CA9EBE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 06:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFQy8-00086J-Aw; Sat, 10 Oct 2026 02:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1xFQy5-000869-Gk
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 02:54:06 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1xFQy2-0007u1-Oy
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 02:54:05 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69A2fG8l331088; Fri, 9 Oct 2026 23:53:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=IGDpD+PSLIrEM9B+IpM1tTCH6FhI7mMRp2TT27eFv
 ss=; b=uujkK2MOLQSVRnbmOxWM5kXc3MhnZqfcBEOW/Yq00HyBZ4OOBSy6CcblE
 q3WeqMmyNu1LH3FRY2Jnbmg06wfQIiE88rXwUL4HUjzRWvzUsGembQ2TuhkTIadB
 7AUHXElnZIk1d3AwFA9Jpa56PUoiZTDlPAdJ3678WVr6xvOej5xGuUtBGRJqrGi+
 JRaMIw1NpWUfYWQAiPt+UX9nyrlRnzk1JZlfJz1XpR0mgSNNDxun432CjlHwa/eI
 yMtHiGWA5Vd/fUENuGutEGKwqcFzoDDsw3MdMpUEsO7oWA6MJG2JmjyAZeYOgf/l
 7ncA3Xy7LE58F/YXheQzVLzYNLmwA==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020130.outbound.protection.outlook.com [52.101.201.130])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4h74tb16pd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 23:53:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PH7q4ae5nK2oDUVrxRwdXjuWx8RnvcbQaBwbFhu952Q9Z7AYK8T1ByQPFI6gfjsO6bckD76hkejbvcxlDxcQkEkvufO5aN2OLj/R1Z9DfbkNZuLWc/1QiQb2sKeT+ArGKDRAqjjH/dxR1AteVcEe5ibZczxtvGUr82y/pzdOWOOgNXDzJMnX9nxcdA6az9CN0w5+YHIRDcsHZ8NqB2Wmh5DLwqdfyTeyIFFejrw/jcBVVjw3uVU52UfOl6C/te4rIc27+jL3h9eiSRdNXJ1mEXGQHvO7mjdcnrpAP/bQCQtj2Cs+QQNeyI8VkVLFpd42q0Wqf9+snJoaOTSL5wh3hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGDpD+PSLIrEM9B+IpM1tTCH6FhI7mMRp2TT27eFvss=;
 b=d31XcLWyBLHCe0OCNIgwlPefGgo+tKK6Jbd8eEO6/QF0eG6CJSrYRGVWSb98+C/ZVu6R0nGV3JGEgX5PvKBT73hACpo0e40BFJA6VVUCYlCss7maa/AJ+CPzwXKfb2sJpFI44tIWS1csmwmmxkJui8VVZS3HFXb1tV3mGrmZUYnr3unHOf8fJsnyJy7OtydfMF+v+kObXBVpPec0RPYKyyLHSUmm3ZVSqjFXxHuh2+v/yo8nlYobdQTh3e9VW7bez/R6Qbn306ZUTEuxTyO56o1AHwNQARmJw21Hjv9KwVjrPyWhiUwMgtVMoCiffeDOmivrgHYFYN2/d76Dg/+alA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGDpD+PSLIrEM9B+IpM1tTCH6FhI7mMRp2TT27eFvss=;
 b=aEf1rTytAd9LGFYS9FliN0BmHBTrxs+z/lnJwEVR4IdPpmJh1/rp7/1Hlo7yLXy7bI7/CEEvUe1ObQ6F/HVjuje3It6vkeXF8dNKmUNR2uMN0piCKEe2l9sMxMiolVk3NX6ABComqJr6y3zMT4lln2rKaTccOrksRVAse6sgs9LnEK7Y+/pfhb//xgb6Hb8OWVvAcdYyodzXW+Tg3Xpd1l9wTRDOezdy5yi7vbw8WjJgz8JmOdBKxHoIkQyWtYGdzkTZEM3hgfNoTTho0ZE9+aHMFArzgCJHaQcpQESNpJ8s0DLZ+oxS/dmNGV2YcmJ8q1fATtZjLIGgaTI6v7+Tig==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by SA0PR02MB7132.namprd02.prod.outlook.com (2603:10b6:806:e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Sat, 10 Oct
 2026 06:53:55 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%4]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 06:53:55 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Naman Gulati <namangulati@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>, Alex Williamson <alex@shazbot.org>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Matt Evans <matt@ozlabs.org>
Subject: RE: [PATCH v4 3/4] vfio: add setup_sparse_mmaps hook to
 VFIODeviceIOOps
Thread-Topic: [PATCH v4 3/4] vfio: add setup_sparse_mmaps hook to
 VFIODeviceIOOps
Thread-Index: AQHdWBcpvacoaQYniEGGAnDBAVKjh7b2STCA
Date: Sat, 10 Oct 2026 06:53:55 +0000
Message-ID: <IA0PR02MB946298300A3A844A06F3B9908B912@IA0PR02MB9462.namprd02.prod.outlook.com>
References: <20261009175314.1823347-1-namangulati@google.com>
 <20261009175314.1823347-4-namangulati@google.com>
In-Reply-To: <20261009175314.1823347-4-namangulati@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|SA0PR02MB7132:EE_
x-ms-office365-filtering-correlation-id: f3b4c1c4-83a7-40f2-13da-08df269b4050
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|18002099003|261009223027099003|10067099003|22082099003|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info: WvJDVqDb5/TWPdsmqEu3UAbY83XsBgcRzNx1BM5BjeDYFKbyRCNV9hv3BNp40zHj6YaNqypMC9PGC8XdVO7jLSLWC/YeYLUVsq12cHMkzJ9z4F22KeuBiECrA+lmf9TCbNkVfPlu4oG2qGvREh5j6DlUEPVMnyrvvLeo2ko5KcCSvL6RQa9B7Q8j6SlAGS3i9wXCm0PhKcdz1qeASu+r+nlGD3mcEyPULCZY/wdiBjHRWpnYOarxBzFcwFXHrNWZqNnOu6KXzUVEDtzVNlnO+9g41Y/a1E43qkWDGAoCG4jxHN7YE9RJWZf3SasqZsPCGB0zn0eIPoSojHQ/WYKb8pbVv3On//KHNDmTVUSRKH8sK1/ZKrNSPyUp6AZ9eYsZSD5DrNkuT86yefW9QtzIngNvmdpnpYEbvL5Yegk2/LUKRe3WRf6yHgNT1g6FQ15JrYXjbzi6U0JjzmOjoMWEKtgtjMUkmLfmVx+54KVOsw6w5DSNPfcOMVzTFIVcA4+0w5t8VhtMVQolLESM0uSWzG8YklySVCUwyh4y7WzJ6EYj555dQwcGUkD1C1BoN8hkmHr4WUfxOWodnhRJYDk2kG0S93L56W3Ow8fqW6qeSzRfHxw13RhnD18+dKjeE1A8f6xim8lCeD1FuT26I17AWOKaGoahhwPejRN3Su0XsSE8Z5m7cZUFhUFvnQRse4W2DnaHxgxhRdBhLUPKdzzaQQj9pzj7BraGaiH30k711nY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(18002099003)(261009223027099003)(10067099003)(22082099003)(4143699003)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FJDSgZiO1enjF29kGVwsPvEe62vQHlo4NyWLM2+cmuOGG5hY3EGNgeE+hQ?=
 =?iso-8859-1?Q?6kicKg8lFyXhZlim81SGwvnZLDtYkdmufslJdl6bAPrkRWsueBCrG761kh?=
 =?iso-8859-1?Q?uEdd/w/2jcBATa2wL7tiPn+mkaSyhO2LTwD57kcHny55yCPQAUSbHeHxS4?=
 =?iso-8859-1?Q?iRYUavRcSfNE86swIsAby9g5L+Sda+fz558O4TVniWnwf37f6tFoYCy36l?=
 =?iso-8859-1?Q?/rGumpzH8KsJ56RGgfJwCc3sroM07QIWnMylYEBHmOG/Q+g8EdLqYcrUH0?=
 =?iso-8859-1?Q?PjyHWGTM0h8Da+odnIU9pg3zHNo+Dc7DhAQ7WYW0fn1Bg8aGCprxyjorAn?=
 =?iso-8859-1?Q?6Xi4n35dJBzr0v5Z0SZVPjyMW1ryjawyXsck2IX37zYgV5Ayr4zXbraOKw?=
 =?iso-8859-1?Q?vVye5qUaw2K8YfR4HgkoPtPoDuQCOeAr2+LZVHDx4UlTkXkqeIkM1wPq/f?=
 =?iso-8859-1?Q?6udrohVflgbnHo/JCoFiYKVX1YuSGCJ35I65vVOmtv8pqJ+HIk/RwfIcQH?=
 =?iso-8859-1?Q?6ltNot08jsbmEJthYuZbgsMgxhbpFPowX8KTEIe54LPUOY14RmDDCNmaiQ?=
 =?iso-8859-1?Q?mc3j24Qez+FPcWTV8GtT87/gFB8VaRtDUufUCghDGgKYGqbyE3S5FBpWfL?=
 =?iso-8859-1?Q?diqAgGE3I92VctpEsYRB9sJchGb/L5swKNfHrRBIIvAs7vZrnYtzssWa9w?=
 =?iso-8859-1?Q?+cU9mh6U10cWa6PI4k/Y3qP9tgZgteM728BT182FU6naxwcqeUbcW7WJhw?=
 =?iso-8859-1?Q?kmw97QJLcLB57JtpvPMNpTY0XUmU7gM9t9VafIbw1ulXd3hfORs5QfkSgu?=
 =?iso-8859-1?Q?/5FoZb/W83KH1s8ho2sfItMvasI8lFdKnjcZiaOZwAfb9qypXyAS+Gp2u6?=
 =?iso-8859-1?Q?RKJjCRYfTv/vM6U4gojYJmbWdoFKBUOgEaFnkiZ8MzWwJYl1I1OjhvlCLA?=
 =?iso-8859-1?Q?cvf+NDz2/CLaQb3H/nrcti37Izwm6syMi2bZ4Src0bEfbsrBBOLlcwEWfh?=
 =?iso-8859-1?Q?87EAdqLRWmPVYjxRAs3f3TTbOweeAAS+cQihWBKWH6XmeJAzU5ENILHzMt?=
 =?iso-8859-1?Q?C6sEN+FY3bgeLtBINAPNMLIxDHPWrn4bbtBNUI7Tw75/lrNkCq8zb9VpmX?=
 =?iso-8859-1?Q?oqGlJyT6LkszifORVeYxmhlXIn2Gd3qVs/UAtzzep8bKMZaby3K/FHm9RZ?=
 =?iso-8859-1?Q?t1pmFq9Ze/SN7/RFtChKw0rK9usV/FM0pBXrvKVLJLMqJRAS2AwJpYvZpt?=
 =?iso-8859-1?Q?UHqvMXjljXVurvFHXprqHUE2GZBCXYwkl55TQ+jAnzxH0vcqP1pmlk6JNZ?=
 =?iso-8859-1?Q?hDV3FMvf9WlFQcQQMUl4CcTJNT5JzsAkptiGQUkHhrKNKEbunOzWg8Ifx/?=
 =?iso-8859-1?Q?B8IyTOOs73hNF0kNAh+WuFsX6CkNnMvmea30QxEPL3Ls/M2pXXAft/899f?=
 =?iso-8859-1?Q?Ap8/MTQg2diL3KYWEHvqSi4S8KaNsfL9wKGikB78JFtUKxgNl454RrMlsu?=
 =?iso-8859-1?Q?A+aIwcp3CCN5vfWpLOUYq/qiXi1ixkewl0d9lrUdtGlHS0MSufTxQ50bZZ?=
 =?iso-8859-1?Q?0a9kzEjDOv3P+m8mexWe9cvMIVvny3eeI8LyTL0AJ2utMkr7FHK50WPK1a?=
 =?iso-8859-1?Q?0UyhiYxDjQAr/9fuYsu+/t5yS9EqWu87BeNsEejvrlRdFwa97oFPtL2R8A?=
 =?iso-8859-1?Q?nGcRkJg7BpDEe2K16xRUrfVE2zfU8oVF6Wo0b5/1Gu8HZB6a6L0JDASzJy?=
 =?iso-8859-1?Q?B90c8i7trUgpMpQdrwpzPFHSXHBxFU91S8zsu/0Uk5euJ9GkC/YBo9hwl7?=
 =?iso-8859-1?Q?WO5P6cpD8Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ucu1vtWQ3ICxLK7/snskL6gOa6ElneiKtFSCtNEs2zNHvMuoQSvEsW/VUnzZiZ1ScirgRZhKZBVnslod6zhrLatgRxG/flHkVjLumYa5SsIc+uPbfpi33EDtXVJT/QEalUkERNzrwJcxgs8sSGwm23LmZQdkfrv8DdkAVhUkfUWDWGCLqCelP/5sS9Fi2QYxNrZaDCuMRfaad1YBobf+q7xN5YeWaPDQbQg0KfMlls1fwNZZeIQeKdHEj1NmRwmZP4ie5I7wzYOm20ku4GenfWoAuJjOvvpiUd6G2cCyDTvjpdEkwlLEjBMwE2LHCK73dSRDFOp3o+FepZMygD9ngA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b4c1c4-83a7-40f2-13da-08df269b4050
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2026 06:53:55.0259 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hcpa0yaoFizhu8IfOSdfzfDIYXI2HUC4XVyOjU5wTmPmGLYGwMo+kEtO+NDZg+s66i+4cXTwOBs2HL6oKT4Nr/DjQByq9noVP5rSF8qS5RQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7132
X-Authority-Analysis: v=2.4 cv=G+6JgNk5 c=1 sm=1 tr=0 ts=6ac9e105 cx=c_pps
 a=pt2/1SnMKDLj9q/aNz1zKA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22 a=1XWaLZrsAAAA:8
 a=69wJf7TsAAAA:8 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=r1p2_3pzAAAA:8
 a=EUspDBNiAAAA:8 a=voM4FWlXAAAA:8 a=a9XjDytYl5xNUU65TjsA:9 a=wPNLvfGTeEIA:10
 a=Fg1AiH1G6rFz08G2ETeA:22 a=r_pkcD-q9-ctt7trBg_g:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDAyNyBTYWx0ZWRfXwXgcLUoNZQwi
 +Aouh3KU/lb+lG5XmAiciyTybgM8Z+2sLAynCHQsY23ytN705I9vKLPsrs7FrU/prWCRWpxoRMM
 XELCMBqGM2mxFiYKTHMH1WJT5T/pTFjv1MfIPzv3AImkDnDBuU4nMnLqwWn1z/5s8l4NBX+1mNE
 DtfExPE8Kydb6c4AI4rDOzT+GzyazHJ4+94ye07VtMVWAb5LhdOnM3vsbfTLnUucfQ888ASQTJ2
 7WKXBa0ejvMfj25f+W3uqQzD4mLTXoLn6KQGl4Ba8k8LF/7hXLch6TF4/JGURFtCHVz06OKTBVV
 9JngA+TLJ263rnD7/1kpS8h93kWBVy01faqY6Qt2j3cXl2e9Cgc4uDSGvdgTwpxMflo4n983yij
 a4FAymd3MehdSj6VeJh9qGonsAhBVKcZAf7AnG9RPQmiPFCb9m32sKIt/r4DjO6p14FmlGqVppR
 OsXVQh9/SIu+Llkp1SA==
X-Proofpoint-ORIG-GUID: GhFUW76XMdUS79Tq1kmX2RzPT3oZsGxT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDAyNyBTYWx0ZWRfX/jxugNWymfjc
 t7eVkpU87vP47VBofGm2mWbzedztc4sQwIj2pGWPyvBW5qD6kgIX+34h1nb0GPoU21lO4HX9KNw
 jlJPDy/0uXX0bSiiXSxmPCsXYjyo2ic=
X-Proofpoint-GUID: GhFUW76XMdUS79Tq1kmX2RzPT3oZsGxT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-10_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

> -----Original Message-----
> From: Naman Gulati <namangulati@google.com>
> Sent: 09 October 2026 18:53
> To: qemu-devel@nongnu.org
> Cc: John Levon <john.levon@nutanix.com>; Thanos Makatos
> <thanos.makatos@nutanix.com>; C=E9dric Le Goater <clg@redhat.com>; Alex
> Williamson <alex@shazbot.org>; Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com>; Matt Evans <matt@ozlabs.org>;
> Naman Gulati <namangulati@google.com>
> Subject: [PATCH v4 3/4] vfio: add setup_sparse_mmaps hook to
> VFIODeviceIOOps
>=20
> !-------------------------------------------------------------------|
>   CAUTION: External Email
>=20
> |-------------------------------------------------------------------!
>=20
> Add a setup_sparse_mmaps callback to VFIODeviceIOOps so transport
> backends (such as vfio-user) can parse custom sparse mmap
> capabilities,
> falling back to vfio_default_setup_sparse_mmaps() to process shared
> VFIO mmap capabilities.
>=20
> Signed-off-by: Naman Gulati <namangulati@google.com>
> ---
>  hw/vfio/vfio-region.h         |  5 +++++
>  include/hw/vfio/vfio-device.h | 16 ++++++++++++++++
>  hw/vfio/region.c              | 25 ++++++++++++++++++++++---
>  3 files changed, 43 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
> index 9f6a5cf7d5..a0c9533f9f 100644
> --- a/hw/vfio/vfio-region.h
> +++ b/hw/vfio/vfio-region.h
> @@ -46,4 +46,9 @@ void vfio_region_mmaps_set_enabled(VFIORegion
> *region, bool enabled);
>  void vfio_region_exit(VFIORegion *region);
>  void vfio_region_finalize(VFIORegion *region);
>=20
> +struct vfio_region_info;
> +int vfio_default_setup_sparse_mmaps(VFIORegion *region,
> +                                    struct vfio_region_info *info,
> +                                    Error **errp);
> +
>  #endif /* HW_VFIO_REGION_H */
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-
> device.h
> index 8472420d3f..3136e152f2 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -43,6 +43,7 @@ enum {
>=20
>  typedef struct VFIODeviceOps VFIODeviceOps;
>  typedef struct VFIODeviceIOOps VFIODeviceIOOps;
> +typedef struct VFIORegion VFIORegion;
>  typedef struct VFIOMigration VFIOMigration;
>=20
>  typedef struct IOMMUFDBackend IOMMUFDBackend;
> @@ -218,6 +219,21 @@ struct VFIODeviceIOOps {
>      int (*get_region_info)(VFIODevice *vdev,
>                             struct vfio_region_info *info, int *fd);
>=20
> +    /**
> +     * @setup_sparse_mmaps
> +     *
> +     * Parse sparse mmap capabilities for a region and initialize
> region->mmaps.
> +     *
> +     * @region: #VFIORegion to set up
> +     * @info: region info struct containing capabilities
> +     * @errp: pointer to Error*, to store an error if it happens
> +     *
> +     * Returns 0 on success, -ENODEV if not sparse, or negative error
> code.
> +     */
> +    int (*setup_sparse_mmaps)(VFIORegion *region,
> +                              struct vfio_region_info *info,
> +                              Error **errp);
> +
>      /**
>       * @get_irq_info
>       *
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index 16efed2fce..d6cd5d4743 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -162,9 +162,9 @@ static int vfio_mmap_compare_offset(const void *a,
> const void *b)
>      return 0;
>  }
>=20
> -static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
> -                                          struct vfio_region_info
> *info,
> -                                          Error **errp)
> +int vfio_default_setup_sparse_mmaps(VFIORegion *region,
> +                                    struct vfio_region_info *info,
> +                                    Error **errp)
>  {
>      struct vfio_info_cap_header *hdr;
>      struct vfio_region_info_cap_sparse_mmap *sparse;
> @@ -198,6 +198,25 @@ static int
> vfio_setup_region_sparse_mmaps(VFIORegion *region,
>=20
>      region->nr_mmaps =3D j;
>      region->mmaps =3D g_realloc(region->mmaps, j * sizeof(VFIOMmap));
> +    return 0;
> +}
> +
> +static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
> +                                          struct vfio_region_info
> *info,
> +                                          Error **errp)
> +{
> +    int ret, i;
> +
> +    if (region->vbasedev->io_ops &&
> +        region->vbasedev->io_ops->setup_sparse_mmaps) {
> +        ret =3D region->vbasedev->io_ops->setup_sparse_mmaps(region,
> info, errp);
> +    } else {
> +        ret =3D vfio_default_setup_sparse_mmaps(region, info, errp);
> +    }
> +
> +    if (ret) {
> +        return ret;
> +    }
>=20
>      /*
>       * Sort sparse mmaps by offset to ensure proper handling of gaps
> --
> 2.56.0.385.gd3acb90ef8-goog

Reviewed-by: Thanos Makatos <thanos.makatos@nutanix.com>

