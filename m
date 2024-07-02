Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF17BC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 13:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOdRW-0006fh-NA; Tue, 02 Jul 2024 09:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sandesh.patel@nutanix.com>)
 id 1sOVte-0007Uk-4f
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:17:42 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sandesh.patel@nutanix.com>)
 id 1sOVtb-0003Su-6q
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:17:41 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461KRMvX017837;
 Mon, 1 Jul 2024 22:17:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :message-id:mime-version:subject:to; s=proofpoint20171006; bh=ZT
 t2xpegsUYD19qNfxUB6/ss+HaGcpgcoQK8wUai1Bo=; b=vue84W0tV2dQBx8RQk
 1vToNMQIFJE5m5joeztswmZAjeKPPckmSgKQSYudnws6aRRdgdVFZoGVALFu5/ft
 10zojcOAmxXJU/6LpRQy+BQu88bCwzt/4fQNdt3WAmDhxq8GOU8g8ePTuDVFjc+r
 q/hD7FfQ52L4acLB8l/jfzBZ/D2UWoPbc90sWhYJy247d+8qxeWtparDbN087kii
 C38SKQgHYXHX2wLr2R4cxxJ/870GMmX7c9tVjdUaBH2jzcM8hQm/nu/7SZv4BINK
 g8JzKtkKKqLKeqNsxkU3nSxmKnAX2Wi0byju1+sRLS0/kBXj4yz49sYWqFFKBnLS
 PLVQ==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17011026.outbound.protection.outlook.com [40.93.12.26])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 402hkcd0wp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jul 2024 22:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsQ+QU97QymLSPgZksgbs2QFG6cWez5nDtyvOKKdM2EpNS8vnv9fhms2EPsDoIm2kQQQ/UzHeA2IN/gXD9fW254dAkn8rz0pNUkt7a+t2ykoyGHR5LKcRFV/jihfyHFiKBjSttNLgpXR9jtGRGzLdIW2Yp+aw8GvHNzW3wIc514wCY/gCr9Ssm4f4zPsFyCdo0pEvW/DzegMMg1+P3p+vm/eaT1NdXuHuOyId89MXB8Ji+l+XpLzv8cQg7Yd/vmWzOzma1wUC+xpBSB5z+W0WmjNlV/hT1vx+ASVqNTOTlv33pWfaSQuUWzukakv/wx8BLfdrV/ckBSequrRPFyLAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTt2xpegsUYD19qNfxUB6/ss+HaGcpgcoQK8wUai1Bo=;
 b=alqL93aiuB60VRzv3NxpuVN5dn0Y7u+tL/Skh9ERkIIIlUXW/HIT9rHGqMEG+Dy7axSWkN/PvN4kUjpxtC1gY78IKPyUzipL2LyqS5tIb6EXEyY8ApSB0xDZ+IyJHx+Jx4IXGO9c15S1PJ2zfYhP6EYOO4bChttdjUA+pUrLXSpoRfH4/RFPHpIdEz1PTzUxkuN5qHrEnWIlVg3CsUKzR1kOLck6CcgCkE/YovH+I6QwLR4bH9OWS6YxmfQmEQG8Dmyz9HicoCqYpfHqvKj73FNgfM4sd/epFzhfe+Yqbn55kxlKofEcjCdwzbzZZLuiB6y2j3XOvmiOuMynpAccYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTt2xpegsUYD19qNfxUB6/ss+HaGcpgcoQK8wUai1Bo=;
 b=LA7ruceulJgPUcJgoElaR5M5F66dZhETcDaED/oKHjmEg6fbaJ5vt+AfRKVc4ydSGsBWK8nR/fBgNqzVRV9ivCs7n5qkoGWg211KN8tsYSTcU+HTITkvCsT4wszscll+mMXaUKxbxanezyPEEJt6pRo4hXBVrqPVRxrSkdF4ew6bnqyvP3qLe5xE7mF7+X1EteBgnwdmlyDTOsEBGEFExIRswENIhLvS7OXsevYgF5EV3H/Z61UckfjJhwiMrWdeyIBQDxeqvEm0Ain39RHBgcN0Wn4Q37uBa4+CuFJedM8jU/uyd9DE/B6KF32aohhTQDUaJqjUUHNHLjSluxeoXQ==
Received: from IA1PR02MB9017.namprd02.prod.outlook.com (2603:10b6:208:3ab::12)
 by PH0PR02MB7704.namprd02.prod.outlook.com (2603:10b6:510:53::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 05:17:27 +0000
Received: from IA1PR02MB9017.namprd02.prod.outlook.com
 ([fe80::d569:fbdf:590c:d616]) by IA1PR02MB9017.namprd02.prod.outlook.com
 ([fe80::d569:fbdf:590c:d616%3]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 05:17:27 +0000
From: Sandesh Patel <sandesh.patel@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, Rob Scheepens
 <rob.scheepens@nutanix.com>, Prerna Saxena <confluence@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: More than 255 vcpus Windows VM setup without viommu ?
Thread-Topic: More than 255 vcpus Windows VM setup without viommu ?
Thread-Index: AQHazD8hBhb9843nBUiZBrsoE1kM7w==
Date: Tue, 2 Jul 2024 05:17:27 +0000
Message-ID: <B75A5788-630B-4898-8758-52B57D3D5895@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR02MB9017:EE_|PH0PR02MB7704:EE_
x-ms-office365-filtering-correlation-id: 9743f7b8-9f2b-42de-3d42-08dc9a5643cc
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T2M2ZFFFZ0Y4K2MxUzhwQ2p0VWFlbytHbmRVcldXeWVMLzVaTFVXeVUzUE55?=
 =?utf-8?B?WFdGN3p3cFhaR3VOZWNwTnVMSUF4bjl6WERia2JSNTVqaFVUTmJGV2ptb0U4?=
 =?utf-8?B?TmErQkovelJRYldENm11ZnNWT2dvWDFYZGt5Mmt1RHRGYVV5YXh6dWw5NDkw?=
 =?utf-8?B?Q2s5MzhZOFBPblErSjYxR05TNG1QeGlXZzByNFdPTE5jUnFPdkVFWExlV3VT?=
 =?utf-8?B?V1cyT3dHeVUyOGEweDFhWHpGZFQvdzVHeVhmYmw2ZTNZVkt3ZHdtRytCVnh0?=
 =?utf-8?B?WlAySXBqRjdYcmJmRThRd1NSdFhnTUN1YmE3MnZ0VFdEcEdSdjlkVjBrY0l3?=
 =?utf-8?B?WG9Ec0FMMFBaOTVyS3BUT3RhejRzbVVKRUlrcXNBRmI5Mjg4NWxSOW9kcjVi?=
 =?utf-8?B?QURyZlg3dERuZnFCRmd5TVQ1SE9wSHlmOFVtRGZQMTR6Ym94QjIzbXM2SnRw?=
 =?utf-8?B?ZU5nRmZLOVp6TngrUTN1My96Z3puL0VTZ1FvUHRxbkpoVE9GRzJwV0RNeUlU?=
 =?utf-8?B?R2U2MG1rYjVGbzZLcTRleDhJTDEwa3AyeVcxTGs2Vy91TzcwaWNsRnhNRTRt?=
 =?utf-8?B?K3RGN1dTQ3AvbHJDM3I3NUU4c2lJMzhIamk0Mmh2ekRMeXRTUnc5V21PREs2?=
 =?utf-8?B?TmQ1cEdKYTRzbk9nbnNhemZzcjlhcE5jVG5GazdONERnYlJKU2xEYlJHWVpk?=
 =?utf-8?B?ZTBFOWhneURKcVh6L3oxbVIyb0pHa1NTZVJFUzJQcERrOGRvRU1xQitGNGZn?=
 =?utf-8?B?VmxWSERpL1RUdmlsNitoS3pHcURTalM3TVN6eVhXcmtndFdCUFgvQndOcVk1?=
 =?utf-8?B?UktJREtCcUQ5V0pPY2ZmQkJ0a05QUG9oYlVFd3dnRmlOQmV4V1N6MXVWeHBK?=
 =?utf-8?B?dCtNTlMrb3FSakcvSDMvK2dhOFZmM3J2akZKTmR5YndibW00UVNkQkhGTy9o?=
 =?utf-8?B?VlNicUJDMFI1UHgxZVE2OHJqTFpyQjhJUzZoVGNzTUJxRFlENXkwYXdTNzlD?=
 =?utf-8?B?bnRsZFVzajhGU0xBNXlRRUtDOG4yZWZ3NWRWK2Z4ZjhUOWsxUEtoa2tjUWNN?=
 =?utf-8?B?Vk84bVVnZC9Nc3ltZ001U2JHUjN3R2NsejNSY0dGdHlTenJrYzRQNU5PSWdN?=
 =?utf-8?B?VGhKc2xoT1FsbnpPM0t2UDhETVRCRGJGa1ZuOHVOSkVFaTF1NXB4cHJzL0hH?=
 =?utf-8?B?Vnc3anp4SU9kdTYwc2c0YUdVTFo1U1dOMHNBNHVJOWNHVzNGUnR1NTE0L0xy?=
 =?utf-8?B?ajh1MEx0WDNWK2hISi9EMWRwZVVTRVM3MHdDWVRZbEhEbzBYemtpRUUxYnk5?=
 =?utf-8?B?dVNCRis3ZEJoS28rNTY1MldZK3J0QmJLcXhzY2JsSTlOaHdmSTJsbC9UenNF?=
 =?utf-8?B?NXhjSTl3ajgrY1JZTm90UU5xVGpTUXc2OS9pNVRQRU9ldkFQMXhPQWU5R3Bq?=
 =?utf-8?B?aHY4RWE1d1hHbFJCOWlYRnhqQzErbFBQa2Uxa1poSmg2bC9zaWRaYTRnanJw?=
 =?utf-8?B?TjVuVktkVTBNNHE1Wm5CV3lqYm1mQ0g1RzBNbWpGdVhRUWN1enBKTmt2NndR?=
 =?utf-8?B?WmUxajVMbFQ5TlQ3enR3bllxek50UTg3dXJGa1FXM2gvQnJvVllTaTZ4NFZN?=
 =?utf-8?B?a0x1dWxxTGxpVkhkWmJxTTRRV08rMlIrWDNDTGJLOUR2NlVsT1ZxUlJCTnhN?=
 =?utf-8?B?bnQ0Rmg2TWVHa3lVZFNMUnpVdnB4SDF5OEVFZTZ3Qml3dnprbGFBekwwMjVs?=
 =?utf-8?B?YWhtK1dMNUs0alBpRUJiOE9JTEZiVWJmcHN4blJvcVRFbHlNSjhISEJ2aFVm?=
 =?utf-8?Q?zhqJagJuBvMc0tMkM1HnvukZxPTJn6bKH65NQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR02MB9017.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TThCUm01OUlCUW1PVlBxczZqRm96SEdiYUJ0S0J4aXpCVDQrb2V0N3BqZ1JE?=
 =?utf-8?B?MzhOMlN0cW1qYkQrZUY4OG9haGNEbmxhN1NlazFpWHFpQXI1NnBBRlhpd3Vq?=
 =?utf-8?B?c1FPUWRSd1RsanhMbU1IL2djSHI2b3hNb2ZubkYyNGdpZ0RQcUFWcFFYVHN0?=
 =?utf-8?B?Qnc0dUwyWXJkbkU0TGNzZ25UNm9CRVhtRC9zYnVEMWhUeVdVa09DZndINzcx?=
 =?utf-8?B?bTFQV0Urb2J0dzZhVW9HTmYvSk5paG1MaWRCTy9TTXpBREdWMlEvT1JWd2J0?=
 =?utf-8?B?WlF0cDZyVUFlS2tJeEIwYnVNdjd3QTkweUlTZWRZcEJ1TEVzQVR6YzdUUlc5?=
 =?utf-8?B?SmRUT3JJM2dpcC9PMEJQMmxCU1F3bkhROWJpY3Z4RHRwNmt6empzZllXcVZ2?=
 =?utf-8?B?OFZSaU9Jd1pwQWhXeEtvUkNvaDJCT2ZTMmJLckNQaFBudmhmZGh2Z2UrQk1j?=
 =?utf-8?B?OHh1MVpKUDdOQU1WZTdrcTZLUzkwalBPTlVsM3locnBFYlJrNG1aZGRLbWpD?=
 =?utf-8?B?RU5pcWsrQnNyd1poOXVteC8vYmswdzlYUjZTVDQzVkFuempNemhvQldTRkxX?=
 =?utf-8?B?eDg5eFUzcUpxWkgrWlRkWkRVckhxTm9BZmdZcWNWQmFnR3RjMndYcldsSDNJ?=
 =?utf-8?B?TmZuK1c0emNKdGRSQkVQOG9VM2QrUUwwVG1FQUZWaXgrOUlkWTVoSjNEaFJE?=
 =?utf-8?B?d1RTcHZSbXZqL0VqYWFja0Q5UWZZN00rZ1FoRzJqTm8wejBBM2ppN0E4dEVB?=
 =?utf-8?B?bS83dnZyQk4xWE93YllJb003clh2TjBGKzUzMTBCRm9wWXRYMkJ4d28vbzgr?=
 =?utf-8?B?ZWpYMytKdWwyVEFXbzVkL3VYcFpDWVVmcldIeW00ak4xekpzd3l0OEYwSjJX?=
 =?utf-8?B?aGR1S09WaHh4aXZCTXRWbmc4LzNLNVluR2RPQkJHaGJrOXJSK1BoOG1WMXMy?=
 =?utf-8?B?UWpSWVQwSTBiNEp3MzQxd0UraEx5b1BzMUMxT1lYMnA1dURGWGNBTk5wQUp5?=
 =?utf-8?B?QjFuWlJuaVVVWUgrNzF1UE9MVExLeTBFMEhVT2Z0dWV3cmkxMTk0THg4MHd0?=
 =?utf-8?B?NWcwTGpyWDF4RDgwS2s3Y2RQTk9iN0tQTXhtb0FOazlIaURTcXVaSTRBSHpZ?=
 =?utf-8?B?WWpJRUVvcWM1TTFBSWwreE90L2RudUVBTVhWZFdnckgvaEU1UmFRWnVoUWlR?=
 =?utf-8?B?RXpIa0xUS1NvN3BjbVZXenFwVmI0N2tBQnI3S1Arc01Ec2JiNEpwSmcvN0tL?=
 =?utf-8?B?dnlzdzBzRGVXbnM2L1U1K0pNYUVlYVBpQXJuUzBjM1FKQ0hrN2FSMTkzNHFy?=
 =?utf-8?B?YkRPYTBZZG9rQ3E5MHdTTFpleVNTcGR0UFE4dkNXWG8vR1Q0bDZ1R1k0dWRz?=
 =?utf-8?B?OGhmTS8zc3RYZW91V0NzOTcyTmVQRUtCcWJ0Tk5hS0NGRWI2dmkxNjdNTFNm?=
 =?utf-8?B?RjVoQk1iSUV2TUNXQ2EyM3F6by9tTHRoRTdpZzA0QlBsemZvTmNsazNpUGJQ?=
 =?utf-8?B?blpmalVwTlF4TSt0RXIvNVVGaE0xTVJ1NWNKa1N3U1NRUksvZzRNU25GVFNl?=
 =?utf-8?B?akRiNjk4Q1JMWU5oaDVaT0N2M0U1alJYNGMzN3E0YWRGRTA5bmVjNUlTZGZ5?=
 =?utf-8?B?ZTRHNEZxVHAxL1gzS25veFVWSEd5NFVuZzd6TTRJa3R1dno5ZmdENGcvVHBD?=
 =?utf-8?B?MmVTZ0FNSXV3dXZvMEcxenQyanRKTHNsdGpuckZGMU1WM2J5L0NjZTVGS1ov?=
 =?utf-8?B?ZjgrVEMrYmFObmZNSlAzeXl4eE1SeWdic3piWld6Qm1uTzJVOTJmclQwSEV1?=
 =?utf-8?B?ckk3eTFXR2xLUkpXVDdEVXgwWWM3d3I1VFFNc3ppeWdwdFc5VEptcU0zbjVR?=
 =?utf-8?B?VjFCWWVSTXJsU3B0YjJPTmZJR1p2YktVS2I4QzdyN00rMk12S2ZWWDNTaFFa?=
 =?utf-8?B?a3BuaWI1NWIwRHNQMVYwaEUvYXhXNDAvaVNIUXQxN0hSSXl4UWZoOUErMXll?=
 =?utf-8?B?ckRuRmtlUGI1aUFXWnNCNWMzMzdsVmF3YTBVK05FcmR2YzlnajhWOGpTZmt5?=
 =?utf-8?B?UzVxQmx1MHNLendJbStKL0hZbjNlV2xaMjJrV212MUU0SDV2dk5hL0o0cnpB?=
 =?utf-8?B?d2MvNVdmYVZJZnpxOTFKKzg2dUJTNjRENGtVQ0JBeEZ1ZWg5SmFsU0p3cXhP?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6BB878FB6CC0E45A1D20A99B10AFB03@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR02MB9017.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9743f7b8-9f2b-42de-3d42-08dc9a5643cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 05:17:27.4739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 418oYXpRq7E51lm38LRChf7/Y2aJIJf8sOyQVzC/0BSYAjE5EF9VGYtGpybtKjQW0Rvis4Sl6nuC5uYj0uhy8bkBWCrWDeLhNlwlvZnoC8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7704
X-Proofpoint-ORIG-GUID: 01JG_PEPMcJHAl9rlyiVUgeRjF7ZXR3c
X-Proofpoint-GUID: 01JG_PEPMcJHAl9rlyiVUgeRjF7ZXR3c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_01,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=sandesh.patel@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 02 Jul 2024 09:21:08 -0400
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

SGkgQWxsLA0KSXMgaXQgcG9zc2libGUgdG8gc2V0dXAgYSBsYXJnZSBXaW5kb3dzIFZNIChzYXkg
NTEyIHZjcHVzKSB3aXRob3V0IGFkZGluZyB2aW9tbXUgKEVJTT1vbiwgSVI9b24pPw0KV2hlbiBJ
IHRyeSB0byBwb3dlciBzdWNoIFZNLCB0aGUgcWVtdSBwcm9jZXNzIGNyYXNoZXMgd2l0aCBlcnJv
ci0NCmBgYA0KcWVtdS1rdm06IC4uL2FjY2VsL2t2bS9rdm0tYWxsLmM6MTgzNzoga3ZtX2lycWNo
aXBfY29tbWl0X3JvdXRlczogQXNzZXJ0aW9uIGByZXQgPT0gMOKAmSBmYWlsZWQNCg0KYGBgDQpT
dGFjayB0cmFjZS0NCg0KYGBgDQojMSAgMHgwMDAwN2Y0ODRiYzIxZWE1IGFib3J0IChsaWJjLnNv
LjYpDQojMiAgMHgwMDAwN2Y0ODRiYzIxZDc5IF9fYXNzZXJ0X2ZhaWxfYmFzZS5jb2xkLjAgKGxp
YmMuc28uNikNCiMzICAweDAwMDA3ZjQ4NGJjNDc0MjYgX19hc3NlcnRfZmFpbCAobGliYy5zby42
KQ0KIzQgIDB4MDAwMDU1YjcyMTU2MzRkMyBrdm1faXJxY2hpcF9jb21taXRfcm91dGVzIChxZW11
LWt2bSkNCiM1ICAweDAwMDA1NWI3MjEzYmZjN2Uga3ZtX3ZpcnRpb19wY2lfdmVjdG9yX3VzZV9v
bmUgKHFlbXUta3ZtKQ0KIzYgIDB4MDAwMDU1YjcyMTNjMDJjZiB2aXJ0aW9fcGNpX3NldF9ndWVz
dF9ub3RpZmllcnMgKHFlbXUta3ZtKQ0KIzcgIDB4MDAwMDU1YjcyMTRkZDg0OCB2aG9zdF9zY3Np
X2NvbW1vbl9zdGFydCAocWVtdS1rdm0pDQojOCAgMHgwMDAwNTViNzIxMzliOTM2IHZob3N0X3Vz
ZXJfc2NzaV9zdGFydCAocWVtdS1rdm0pDQojOSAgMHgwMDAwNTViNzIxMzliYTY0IHZob3N0X3Vz
ZXJfc2NzaV9zZXRfc3RhdHVzIChxZW11LWt2bSkNCiMxMCAweDAwMDA1NWI3MjE0Zjg2NWEgdmly
dGlvX3NldF9zdGF0dXMgKHFlbXUta3ZtKQ0KIzExIDB4MDAwMDU1YjcyMTNiZGMzZiB2aXJ0aW9f
cGNpX2NvbW1vbl93cml0ZSAocWVtdS1rdm0pDQojMTIgMHgwMDAwNTViNzIxNTE0ZTY4IG1lbW9y
eV9yZWdpb25fd3JpdGVfYWNjZXNzb3IgKHFlbXUta3ZtKQ0KIzEzIDB4MDAwMDU1YjcyMTUxNDg5
ZSBhY2Nlc3Nfd2l0aF9hZGp1c3RlZF9zaXplIChxZW11LWt2bSkNCiMxNCAweDAwMDA1NWI3MjE1
MTRiODkgbWVtb3J5X3JlZ2lvbl9kaXNwYXRjaF93cml0ZSAocWVtdS1rdm0pDQojMTUgMHgwMDAw
NTViNzIxNTFlM2ZjIGZsYXR2aWV3X3dyaXRlX2NvbnRpbnVlIChxZW11LWt2bSkNCiMxNiAweDAw
MDA1NWI3MjE1MWU1NTMgZmxhdHZpZXdfd3JpdGUgKHFlbXUta3ZtKQ0KIzE3IDB4MDAwMDU1Yjcy
MTUxZWU3NiBhZGRyZXNzX3NwYWNlX3dyaXRlIChxZW11LWt2bSkNCiMxOCAweDAwMDA1NWI3MjE1
NjU1MjYga3ZtX2NwdV9leGVjIChxZW11LWt2bSkNCiMxOSAweDAwMDA1NWI3MjE1NjYzNGQga3Zt
X3ZjcHVfdGhyZWFkX2ZuIChxZW11LWt2bSkNCiMyMCAweDAwMDA1NWI3MjE3NTAyMjQgcWVtdV90
aHJlYWRfc3RhcnQgKHFlbXUta3ZtKQ0KIzIxIDB4MDAwMDdmNDg0YzAwODFjYSBzdGFydF90aHJl
YWQgKGxpYnB0aHJlYWQuc28uMCkNCiMyMiAweDAwMDA3ZjQ4NGJjMzllNzMgDQpgYGANCg0KVGhl
IGVycm9yIGlzIGR1ZSB0byBpbnZhbGlkIE1TSVggcm91dGluZyBlbnRyeSBwYXNzZWQgdG8gS1ZN
Lg0KDQpUaGUgVk0gYm9vdHMgZmluZSBpZiB3ZSBhdHRhY2ggYSB2SU9NTVUgYnV0IGFkZGluZyBh
IHZJT01NVSBjYW4gcG90ZW50aWFsbHkgcmVzdWx0IGluIElPIHBlcmZvcm1hbmNlIGxvc3MgaW4g
Z3Vlc3QuDQpJIHdhcyBpbnRlcmVzdGVkIHRvIGtub3cgaWYgc29tZW9uZSBjb3VsZCBib290IGEg
bGFyZ2UgV2luZG93cyBWTSBieSBzb21lIG90aGVyIG1lYW5zIGxpa2Uga3ZtLW1zaS1leHQtZGVz
dC1pZC4NCg0KT3ZlcmhlYWRzIG9mIHZpb21tdSBoYXZlIGJlZW4gc2hvd24gZm9yIGV4YW1wbGUg
aW4gLSBodHRwczovL3N0YXRpYy5zY2hlZC5jb20vaG9zdGVkX2ZpbGVzL2t2bWZvcnVtMjAyMS9k
YS92SU9NTVUlMjBLVk0lMjBGb3J1bSUyMDIwMjElMjAtJTIwdjQucGRmDQoNClRoYW5rcyBhbmQg
cmVnYXJkcywNClNhbmRlc2g=

