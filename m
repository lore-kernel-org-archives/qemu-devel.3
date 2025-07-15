Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB977C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 12:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubeKz-0004ro-Uw; Tue, 15 Jul 2025 08:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubeKX-0004hb-Fb
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:00:33 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubeKR-0005lw-Uh
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:00:15 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F7Xvtl007677;
 Tue, 15 Jul 2025 05:00:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Yj/IiUIy6dIFmU6q+GgW7fzx7B3l75BMZ4BZSsrJY
 34=; b=x0lIkOCKAULv3R9svFXNt0ITsHDHaIZC/LH2SD6484r+xYOUr998E8Clg
 8cjCmV5LvADzMpFO6XSj77sZLMz68h/UrDG/iSlrRnGbRboge8JFv+pQZx1PrvlV
 zbKzLSrQRvEAm/g/K56Z6e140VB3fPo/ASbNpdXqo0ZEL5o+3ezLuXT3k2J2Ztfe
 K15duKmGNcq2/Nnsjj5C5+NbS+D4ZavjSAPBW/vleFJs/0A92Q/Pj6sunB67c+bJ
 8R8ujhlZ9+hbO1uRpDG03JOpXOBXoWPk3VVv73e8hSIRfabwALPsKKXh0ZEKJZ0G
 +jiFNo1l7gXNaXtULQEvfFmy1WH5w==
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2102.outbound.protection.outlook.com [40.107.95.102])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47uq1de8gm-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 05:00:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNIDXRMi+nBOjHYpo8x9BjtIYUzxrhrsNSWNZX94oE9/tXvN0aGps/JFBFbNj3JepLmEbBzjq23s9+vEfAKLZHqcilUtfHOAw7ZbkYkk9yl6h5KP2RnGQEjjs5Hl4tBeRFPOCEAlINcTdRnawr+oMTnHiQXB4otg0rjYI/VjYf/pJp0leErjUJ+JCblDNdd/n0dILzWHnDX8cN0m7pYMZvmDS6Uu36Iyy5J/gItjU/E7o+nYpZxxH1l2pJzvuoNcRtQIE88lD3vrJ0E2DCxAqsDZDX+wEqNZxM2h3CM+bEG1oVrvFIan0i2O7JGo1WEODdhcBx6Rlb9zqr4fV0C3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yj/IiUIy6dIFmU6q+GgW7fzx7B3l75BMZ4BZSsrJY34=;
 b=M2kCk4i0nMDJNu8OUipnZNmzmMItKIXAOf4Ze5kUYyiXXupUwxqbNFyd2ZzNJxIM3HP2sC2opGXo/lNOdrDH4NS2jIylCk9jJWZAYWufOmOC/91C6fJ9HKljvIBYPnXpbqgHO5FwBoppEwd7gUBewsN51cbcIC2XcOlrDByi/0lz35eLurYLCAsEaBeNb9s1cTQl7TSqRS2ot0cxXz3vLH4Zn/AdpL8Jn/PhMLWcwhGRVXmxoZknODv9wzfqD/XuozOsBulFYs7/7C4bOHOaCXRbKM5/GJfPzFO+nhY3IO7WKytwTC74Yzxh79WvhGKtTdFSG+H1kSRvYtJq411cCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yj/IiUIy6dIFmU6q+GgW7fzx7B3l75BMZ4BZSsrJY34=;
 b=eFAniVBfj/TDzdwxffO343zVk5sQ6qY3zAbpYc0t7Xxc1xLocPMu5kKZuWjWDymUI9Hgezo4hdH22/oyarTCOw9YDWNbmwSb4VQPs9beBzoqe3WJ6ZeMbtu48Ydp0XdfMh1zCIpoFmc7iqO+x1XXJfpB6RhgSUL6VKDNykgar4WUI4qM2bFxP9FtW/ai3LJzTnmkestcRlVCWZWYEMFw0t4hnS84qkDMowWUkPj0C8Z/91AMNFgvUshGBGCLr6fQXNZQafaCtNiiIsT+06BR2yvG5zGuxN/rDonQ+xKws4EXkps9FBc5vZubZbY70dumNX7r+NJFENfv/dIyoHEtMA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DS0PR02MB10710.namprd02.prod.outlook.com (2603:10b6:8:1fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Tue, 15 Jul
 2025 12:00:01 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 12:00:01 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v3 2/4] hw/vfio: fix region fd initialization
Date: Tue, 15 Jul 2025 13:59:52 +0200
Message-ID: <20250715115954.515819-3-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715115954.515819-1-john.levon@nutanix.com>
References: <20250715115954.515819-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::29) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DS0PR02MB10710:EE_
X-MS-Office365-Filtering-Correlation-Id: 475e4550-47ba-4130-facd-08ddc39720bc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UW9yMndXd1BxNENxNFJ2eng3Z2QwZzkwYjEyTmVVZ3dZZ05ZWDJHZWlOQXA3?=
 =?utf-8?B?TWRaZzFYYUtKMnNueWZpT2QzTG1YZDAwMCswc3ZSb1lVMnVNKzN5NnRnU2t0?=
 =?utf-8?B?bDRkK1FZcWZ4SFovanhiYThZN1V4WVRSL1NvOTZ6ZTJaRFUzSDBMTzdiQURW?=
 =?utf-8?B?a1pLSSt0V28wUlhVZFN2UG5ORmM2T0ZVWW44R2hZeS9GbEN1ZEdXSWdHaGw3?=
 =?utf-8?B?RDN1Q2xucTlocTlPY2NWL3NjVUVOQW1OM3U5Tlk3L01nTW5EVGdUVG9IOEFO?=
 =?utf-8?B?UTVwT1VuVDd1b0JheUFkVUErSEIxeDRqY2drK2UwdEZabzFMWVNJdnNIa080?=
 =?utf-8?B?dVc1aDVtWDhWcmJwMG03M2VrWGk0UlcxYTBFVlJKTk5nNDV0dEFZREtIMlF1?=
 =?utf-8?B?TXZSaEdRZG9nT1VrUmoyUHdWNSs0WVBoL3FOc3dLcm5DSlI2dnF0azhhbXBv?=
 =?utf-8?B?anBISFpsR3ltV2RoVWI0V2FKK3N5R1lrRnk4TnhNQTVaSDlyQ0hONjFEME1x?=
 =?utf-8?B?ODlYNnBoYVNxNVBvdDV1cDBEamxseS9LTnRDODFhdU1MWklzNDJjZC9oY1Vs?=
 =?utf-8?B?YXdDdWEvbUY1eEJ0WTEwVldxWXpuQVNFK0FHUzNhS1RoVWV6TEx3SThLMis1?=
 =?utf-8?B?ekFiNmxnRGp6TFZqZG9QaVd6OXhnRXQ3SEN2cmdDK0prc1NzNStpQnZwU1Fl?=
 =?utf-8?B?cTlGeStIOERpTmNvQXprTlVBL280Y3A3NHQ1TzVObE9wTUI5RXJnY2p3anNH?=
 =?utf-8?B?SnpvYy9KY3RFTXhMMzEyazB4eFEyNm1VR29JVzhnakVGWmNZK1dBZFZzYk1W?=
 =?utf-8?B?VU9MTCszYWZjQWtrSDdsUHBOUm9SQ0ZSVFJoUUFVWG1qZTJhQ1IxSE93T0lK?=
 =?utf-8?B?cUo1Q1JFZTVmRjFWdUlya1NtZ3FLQU5jWmYyYk4vRlBtZnpNR3Y5VHhwKzY4?=
 =?utf-8?B?YjNTVmJqQ3J2U2NCdHZsWHRLY2FwWWk1MnJXL0VhKzlRRUpIV2NpR2RoQXJ5?=
 =?utf-8?B?bVlqNjZ4SHFhWGo3RmRDL2xVWHdYRXRhclhaOHNLY1J1eHlVaGhmc3cwREZL?=
 =?utf-8?B?T0lIc05NTVlqTkQ5MDRLOWprUTRYNFMycUVXb2F4bHc3Y1V0VzBTYW1KUzhu?=
 =?utf-8?B?TmZWeXlMQ3BvVlZQMzk2RkhBUlVJQWFRdTVDTHVNSG1ZUmRDc1FCS3dRTmQy?=
 =?utf-8?B?bzZpdVB4dFBCcGNITUM4aXlLbVBEM0Q2RDNBZWdnWG11ZGF5STZIK1lsV0Nr?=
 =?utf-8?B?VEd1ams2UEphY0NPbVBzSmNhR2FPVHpSUERqYjk4dFFSNDUwUWZYZjFEN0Vq?=
 =?utf-8?B?WlY5NTFpS2M4TkU3SDBnVlFYdFNGR00yQjVYeVhvSFRNeUljOUNuTS9HVmMw?=
 =?utf-8?B?NlMybExPeUFQUGtSWityTzdXR3drVUtEN0NpM2R5OFhEbWRobExYME5vRlF5?=
 =?utf-8?B?RDgyN0tSSVlHTjdQODljQ2JGY05RK0ZGRnZRTUdGY0xyUERWOTVQUXpia0Y3?=
 =?utf-8?B?NWdUdUVZME9jaDVUUjdnOXJyamxEZVg3M09TSEVqQkt3dlo3NVQvejRyM04z?=
 =?utf-8?B?TGVGd0tabWJjQVhjVFZ1ZUlHQTd2SU9YQndwVGtlYmo2NGY3dWllRnMyc3hF?=
 =?utf-8?B?dUVSVGZVKzd4VnVidENZcmRaMU1lTWJIVG9VZUVMSTczdGFlY1Q0RytSMHlT?=
 =?utf-8?B?L2xmMnQrWjhCM28xLzVKZ0JnWDE0ampBd2tYd3pwM0JwMllVQi9oS01Wd2pW?=
 =?utf-8?B?ZnIxSUVFMTVKejUra2tNcGEya0xaNitvcWQyUHhiN28zN3JjdW1POXFvRnNC?=
 =?utf-8?B?Z1dmbjBudkpZb1hlaG5NS3pPd2cwUjAxSk1KcDgveW4zSkphT0djVW1SUGxW?=
 =?utf-8?B?QnJ1N0V1bytOMHVjemk5c1FjM2xCQWdaOGxwVEVJTDQrbE9hc3h3VWNEcXBE?=
 =?utf-8?Q?riB33B6+wjs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2FPYXZZeXEvbzFra0NVSExJbkl1bFJZSGJhMlVKbUIyQnpPTDZUVFZSNUdm?=
 =?utf-8?B?ZHVYRjVaMDdTYnlqTFRFZWEvSG1CU25HZnI2a1Bobmc4L01zR24zSU8ySTFw?=
 =?utf-8?B?ZENRRDN5cE9wSi84UHAzcDNZaDUzSU5LcEw4bnRINDRaRFU0aTA5SGFVbWVY?=
 =?utf-8?B?ZFpWL2JpUnVQTmE2elE0aGRQZEo4STNORDBsdWYwZHB0bGZJdGhQdmdwZ0RB?=
 =?utf-8?B?S0VDRXpLWWhScGlVS2Jyc3k2WDFTT08wZW1QQ1hxemQ3ZGwzSkRKL2JFQmlu?=
 =?utf-8?B?Q3kxYnhYbmZ6RXZOSzRsamtmL3FVYy9vQklTcjhycThPdk5MVUNHYjJBU3JY?=
 =?utf-8?B?cTdIYXd5MjNPUzhoNEx3R016YUk4VmlzNVc2bkhXQ1ZtNjFaekR6UDVIRzhw?=
 =?utf-8?B?dTFFNElQK2VPU0xGQ3dHbUUrc3lyeDBiS2JuRk1vc1ZBMEtsYVp2Mm5ycEdJ?=
 =?utf-8?B?ZjlmdXhpajZNUmZndGdEd0ViK29tUzlzZjR6eXJ0RmgwUkJSVXJuMnNjdFhR?=
 =?utf-8?B?dHRVNlVGK3ovMUdQK2JhNE0xMkxqNHorejB6N3IxQ042WW5ySXc4cTlzTG1i?=
 =?utf-8?B?VmpydUI4QVRyeDFiaU5WWmNoeURLdjBOQnk1bk1ROUcxMm5IY3FVY0Zua0VL?=
 =?utf-8?B?MnNoTWE4N3NnVUptOVhIOU1vcjJLREUraDkydjNDV2pXbnc3MmpuQWlkWWV0?=
 =?utf-8?B?aUFZV2hMRkt4cFlEUGdGM1BhQXBrZldJekhGcndQcyt4RXdCVk8yaFFDNTQ5?=
 =?utf-8?B?Rm1Td3Z5eVMyMVUvQ3VLdjk1RWIzcVBENTVFUHhEaDVNTCs3b2NPanJqcW5o?=
 =?utf-8?B?QnFMQ1FOVE1xYW1DdjQ1WHU1NUdOYlF0MUczNjNESG92eUI4OTZIQTQwVFlm?=
 =?utf-8?B?WFVLL1ppSE9tZlg0TkxzQktrd21WWkxTMkw2YjNXdS8rc0krTWtxVklucTls?=
 =?utf-8?B?c3pRV0puTXdGb3M2YVVWRml4djRvd1d4WmU3V0ZxVzBrcUJPeGVnYXl6ckZG?=
 =?utf-8?B?U2FGY3FxUjNkWE5RRzBMNmRCUEdnU2I5dzNUdjBRV0lIU0xvbm9JRnoxU1c4?=
 =?utf-8?B?QTVuMkxtOGtrU3ZZd29SaEU1RGlneUFrZkhaWjVCeGo0aFZmVFlEbkpEZXBt?=
 =?utf-8?B?c1kzUVNTZ0M1V2pzY0xrcGwyT0tITnViOGR5a1daa0Z3RHpPZ0xrVzRYL3JH?=
 =?utf-8?B?aFRqUkhRZk4zNnZJUmZUYjFoWG9mV20zMktZbXZ6eGIwYW1wWEJYMVVZS2lh?=
 =?utf-8?B?T21UYkdmVloxbFkvaVhncWI3c1FCNFR1R2JUT3hhdHNWSjM1M1FrTnBWd2tw?=
 =?utf-8?B?ZHBwajRrWUVOdGY0ekU4TXBHdjRyUHNXcE0vUkNkS1B1YXdXRUZ4cWdrdUhN?=
 =?utf-8?B?MmQyKzN2T0dicGhlanZwOTljbWN1S2xtQi95TlJUN0FjTFl0aGxjTnF4L3JF?=
 =?utf-8?B?OWZvVk1KVWN5QVFyeTdTYzdmMC9FL3FPbE5KSU83Y3k4RHFGMHlCaGVIKzZM?=
 =?utf-8?B?UGhhaUsrV2RWVk5DdWt6YTE4KzE3QmV5UXRucGFLTytZczFrRkprMUpjWmdJ?=
 =?utf-8?B?SThOMFN4TnliVVpyWVlFaXZ6MUNEZ0QzT29NaFIzZUp4bHhYM1BTcjIrZnFt?=
 =?utf-8?B?L1d4L1ptNW0xSE9Wb2tUMG5EcFNFNm5ZVmRTMnZlYkNsc1hVQVQraTl3NjBr?=
 =?utf-8?B?elZNSlpmTUIwcm5KemppUW1xUlM3N3JXVGwrMFh4bVZuQnJRWUdaVkZ6TUNs?=
 =?utf-8?B?dWljaCtDR1VqUy9YQzhTbnUycUtqQXV2SXVGcWdDZHljbFMyRFpmRkM5WWNx?=
 =?utf-8?B?RDhZMERNbjN5Y0RiN2o3YjJhQUhhRkNWTlRHdVRSRGtYQ2VudnViNWlCSmxp?=
 =?utf-8?B?aXVzRi9HWjNNbTVxMnFvbWtwK2tCZDFGQmw2S3plSGhNL2VLZ1ZhcUFHQjc5?=
 =?utf-8?B?ZktWaFp3MDRXWGNTNmZVdjNmbzhobVJvSXE3OUJXWmZoWDNKQ3FIb2dqWGlp?=
 =?utf-8?B?cnl1T3IzTExwWHBDc1JsZTljckw0U2lleDhyTFJYSFNQNjcwV0FScUMrKzhU?=
 =?utf-8?B?R2dTRm5OT1FoejloT0lkME1TcnJpVld3YXdsVkxnTVE4WkxtQkpaM1p4Mm00?=
 =?utf-8?B?bzNiQ2lvdVZ1MlNqT094WkFMYWt0b3hIeC9LN2RWbU9FalFwQnhhUDdNV0E5?=
 =?utf-8?B?M1E9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475e4550-47ba-4130-facd-08ddc39720bc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:00:01.4942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUicRODcsNDXW5m5E4woCLo+1538nw0G5kcZWfIk4NeTK3QzZzvNRTE+AsL1euZ9jAI6QDVMGVzgcpPJF4Qwmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10710
X-Proofpoint-GUID: HNJRUAMhnQ-6gmnAL0k0iKyEPy4EXGoL
X-Authority-Analysis: v=2.4 cv=GewXnRXL c=1 sm=1 tr=0 ts=687642c3 cx=c_pps
 a=/q+MpTbIxiH/H22goC6+3w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=sV9AKFzeoAo0iIp09WIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEwOSBTYWx0ZWRfX66VaHKyyBxGn
 Sdfh+ZxRxqe1qVUKmnwvodwa6GY6uOtdLNMHg9SRW/UX2eaBDSAPnwUWYNGuGPecNhvfPmtcW7N
 hGhCf4GsJsGp1HL6dWzFgkxxbENl3RJ5FrscHG/VeKxWYeNGwy36pFnjA0jOJGtYoy7+bcNG6Xx
 FH4zqMtKinOJzUiu8XleI9xwtK4LpVi/dkEs8ZEaSEvJoku6DWICTYAYWYyyivvUbZr9bR+zkku
 DDlWiurKVAApD5TfRv1T4wmxKWgAqdPedDMOiG1U8N0dOqqmUuA3NMXoc1NsuXpsi04GXIGyYX5
 VN7y6lmgV/bR6YrR570vbtvf2MPFXYiIm6XBxzX/8Tp511EywUlVUzeBaCegSOEmcZ/4ob4hEG6
 zP76DiXNJb4FYvB5RMpLuNEFmLkzahHCHwRJ0trokPIMWZZWTVVdzwMxr6Q+QHVY6uFs8FJI
X-Proofpoint-ORIG-GUID: HNJRUAMhnQ-6gmnAL0k0iKyEPy4EXGoL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

We were not initializing the region fd array to -1, so we would
accidentally try to close(0) on cleanup for any region that is not
referenced.

Fixes: 95cdb024 ("vfio: add region info cache")
Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 96cf21462c..52a1996dc4 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -463,6 +463,8 @@ void vfio_device_detach(VFIODevice *vbasedev)
 void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
                          struct vfio_device_info *info)
 {
+    int i;
+
     vbasedev->num_irqs = info->num_irqs;
     vbasedev->num_regions = info->num_regions;
     vbasedev->flags = info->flags;
@@ -477,6 +479,9 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
                                vbasedev->num_regions);
     if (vbasedev->use_region_fds) {
         vbasedev->region_fds = g_new0(int, vbasedev->num_regions);
+        for (i = 0; i < vbasedev->num_regions; i++) {
+            vbasedev->region_fds[i] = -1;
+        }
     }
 }
 
@@ -489,7 +494,6 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
         if (vbasedev->region_fds != NULL && vbasedev->region_fds[i] != -1) {
             close(vbasedev->region_fds[i]);
         }
-
     }
 
     g_clear_pointer(&vbasedev->reginfo, g_free);
-- 
2.43.0


