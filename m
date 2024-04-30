Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F48CC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 18:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1sHG-0007uZ-58; Tue, 30 Apr 2024 14:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s1sH6-0007qd-KD
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 14:32:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s1sGt-000307-Lk
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 14:32:20 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UFktn0025888;
 Tue, 30 Apr 2024 18:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 qcppdkim1; bh=/rXBClK2jKs4zVQ85swoa1erFoD7m3mvrb1ipXAd/d4=; b=b8
 MYu6zRp+yCrLYWoRw3w+OvskiGEhh0IFPdgvw2br8PUZCuhND7GHiySGenfbGUg3
 toEGfft2UcjoqVz+rreLkbEi6m59+gS+vvFcimAuvd2ZHfHi4PArEr4ScknthwP0
 pktzOe1ypncHpxH8Xt4AiPLbPSSc3VFU2pj4lRC6lbPFUhotbU9MemkLiGIOiInU
 FvgSA5B/7MnunW8Ye6qagKEpL5opYBP2eiplTrZ1xYX+haiwerLyfOcIOi5ORUMb
 saoBxmOWnWGqz0K8r3ui0zcfgdovwGVXbe38u3Vasw3sZwvZVRI6VjoJVEGtyeLl
 PTbDp8O/YZjWcGOWLPrg==
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtw1hhmvm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Apr 2024 18:32:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCD/SNTIlZ/NqdlOxDu2ExiUX0yyYBANLqyRyLnM1UhT49n5WVe8bohGXNnOkzZoY+tz3aLwizaJvl8lAgXUYg+lwUEcwudx4NfnrIajRasITzefJ4A8B+guUhLQTurJA47SFj41lers0Nhc9NUjHQpp5QtOnd1oRVzJ55eplIN0+SIMLMyDqN4W+Ow2ECOyEtAPK+/jwoWI2Nb+XWKN23U5m1dQ1Tla7gwlWDFCy5KBe4078aCZCxZ6aIoskHF3rFBiOIxxlkS1lzSpV4KuUI85ua/k2YriQKZnKHMcOQhlZYUW0F40Scu7RzJLmC73vco97bjlKb8pyWmq757fFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rXBClK2jKs4zVQ85swoa1erFoD7m3mvrb1ipXAd/d4=;
 b=ZaHR3gdN4thqGbOcSYRfyDoPgbU4HZ+gDLWBdTSWzYx3/AsRxDkRRL53kI2191oHAh3EUL9K0Elhfj0nmJ+STYmi0MR3R/SrYf5u9OsW6L4kbLGFiAUGzN08nc6AQWUwv79YTZq12s9CaooxawmEEXrpSO3T0WMQfGraRiq1k5bYBs8cJ66717SP1kJtz6qh3XZbqh1vdEB2zlmHsIgH9P50c0ZUlUJuiZ8C1yy2PVHzC0exVxUu7SCIKR7VXMGhzbngTwXc+NHSXmBqX0WFPeP9cFG8TtQZVKkOzh6HwkVhUBrJwCb7UaWxSNOsppWSM0XZkjag6XNNLD5EIgZoEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by CO6PR02MB7681.namprd02.prod.outlook.com
 (2603:10b6:303:a4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 18:31:58 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1aac:6291:50e5:4242]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1aac:6291:50e5:4242%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 18:31:58 +0000
From: Brian Cain <bcain@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "Matheus Bernardino
 (QUIC)" <quic_mathbern@quicinc.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Sid Manning <sidneym@quicinc.com>, "ale@rev.ng" <ale@rev.ng>,
 "anjo@rev.ng" <anjo@rev.ng>, "ltaylorsimpson@gmail.com"
 <ltaylorsimpson@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Subject: RE: [PATCH v3] Hexagon: add PC alignment check and exception
Thread-Topic: [PATCH v3] Hexagon: add PC alignment check and exception
Thread-Index: AQHamwpEEu0KOETVMUCR6mqJDcKI37GA9sIAgAAsVvA=
Date: Tue, 30 Apr 2024 18:31:58 +0000
Message-ID: <CH3PR02MB1024783425F3A840D83F1AEE8B81A2@CH3PR02MB10247.namprd02.prod.outlook.com>
References: <5c90567ec28723865e144f386b36f5b676b7a5d3.1714486874.git.quic_mathbern@quicinc.com>
 <29135846-744f-471b-9e21-ec5a6309bacc@linaro.org>
In-Reply-To: <29135846-744f-471b-9e21-ec5a6309bacc@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB10247:EE_|CO6PR02MB7681:EE_
x-ms-office365-filtering-correlation-id: f148883f-88c0-4e9a-8cd3-08dc6943d1cf
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?S0p3V0E5a0RPcmpRcTlGMDJyRjRvTHhqWFU0S0FxSHg1ekkwazJIM3dpdHBv?=
 =?utf-8?B?K25ibFN5S3JOUUYzeTRTSmcrbnpwVk5zcnNvR242cTdkMSt0ZGkrOGFiaWpu?=
 =?utf-8?B?d1FXeHRwcjFvcUJKQVRsdEo1a1NUY3ZHaVpQTUZuTEhiVkRDQnlvWW9KNEN6?=
 =?utf-8?B?STZzeVlpdTJlVXBtVGFYZHhSTkRhNXFxYmRpcVY4ejk3d0VqeVpNKzhXWFVR?=
 =?utf-8?B?bzYwVzFEM1pNUnVib05veDMrNHRFSUpFbXlLTmpTUzRrTkhmMUZhcUxKQlRr?=
 =?utf-8?B?eXRPRDYrajNTaDZyL3RTcXdJNndocVhCUW5wcThTdXZ0R2p6cWcvRk1LaHhK?=
 =?utf-8?B?NER0NHFxbG9XMjBWRTFlalF3Zlg0bW9Tc3JIMlpkVjNvemdDdU9zKzR3MmI1?=
 =?utf-8?B?SXpUSi9MU0RLY2xDR2ZDVUNmUjZVNEFCR1J5UEV4Rmh6cVpBRldKT3BqT3dK?=
 =?utf-8?B?N0hRTkFqdjE3VlluSGVpTGVORVc3K0VtVkFFTzBXT2I5T3RHbmRFVURnNElZ?=
 =?utf-8?B?REI1UklaVk9hRUIwRkhNZWJqNTIwaVE2MlJZblMwMHRiT3ZUQUlxZS9haWxO?=
 =?utf-8?B?N1JXTkJKZ1p0RzZjOStuS0orSlpBZ2JNL0ViN2svSEdDOHBVdExyQjY0NzJR?=
 =?utf-8?B?ZGdKQUREVGVkd2dscmM0NlhHcVJWdVBocklpUS9MOTZmK3VzMk5IK08yazNr?=
 =?utf-8?B?S1YrMHFuTlhwSDZNOTU4RTFWZHZSWXM0c08yNW16N1I1WGxVNUxJTzYxMC8z?=
 =?utf-8?B?Z05BYXJkVUZqTnI4SmFodWJWWVRTR1VRRFRnendLSW5jQ3NmWE1KMEozb3lP?=
 =?utf-8?B?WXVneXBIZlE4dENTT3p6VExYUTJHb2xPYjlXWXVxMWlIbXdEK29uU21XMlgv?=
 =?utf-8?B?NE5LdkE2MlNUZXJsZ3ZjazcxVVU2b3g3SjV5cHNGZVZpMEE3aTBiUzJpWk5I?=
 =?utf-8?B?cmZCM1d2eE1ZSm8xOE5XMWg3d0RDSmliT1M2dVV6U05BWlpGWjZpaEJaeFJX?=
 =?utf-8?B?OG11MzFiMFk5U0JBQXZsZlR6THE3S2wvWm0yTWd3UFEya2M1d3lWNVgrSWpj?=
 =?utf-8?B?ZGxSMmdxSkJOMHpiVVJMZklIR2lYejB3eFhPa2w2Y2doSXpNWVdGbWFoUFND?=
 =?utf-8?B?QVplSUpORGRPZTRCWjlkNlpNWjJ2R3dhaVVVOXQxNURuODlsYWg3cFczVTRN?=
 =?utf-8?B?VldHdzhzdEkxOVFQbzBCSk5LZTFNWXllbEU0SFdCR1E0YkgxV0pPRWQyWm5F?=
 =?utf-8?B?UldRWFJCOWt3RXRaVE9sSXBDQU9ra1FyY3daaENoTG1GbWtsM3pVRVg0VE0v?=
 =?utf-8?B?RWdKTmlsSTd2YnhLQjY1MVR5emVFWDZFSGREak0vV2VIenJKQ29YQ2JPNlkv?=
 =?utf-8?B?ZlZtaDJYQkY4UDBmaUc0d0VyM1NpWVFrbGV2eGNqT3VWZ1VSVHVXWkRHZGJX?=
 =?utf-8?B?VzhYdXgvSG1HQ2VMclE4cWVadGZSYXVleE01SE1FNnZWRERNK2ltelNxNGpG?=
 =?utf-8?B?TGhDbVNmQXJ3MVAzZFlNZHlUcHVEbGpzeFZZUWI0WFRLdVZrcVpXMS9qUGhT?=
 =?utf-8?B?ZWlndHJoUXNjcklaamZEazFla1BPbXV0eEhZU1poUllOOSs1QndyaW81cjZE?=
 =?utf-8?B?aCtxMUhqVmwvSzZrSnNJcVFNSkZ2elovTGkvUi9UZnhQL05va294eTdiUzAz?=
 =?utf-8?B?cXQwanNqRU0vZUszUkoyWmw5VkdIb1ZYU1psVHN6RitTemtnNXJ0bkc5U3dF?=
 =?utf-8?B?SEhWbXNrMHI1S1lSaVpIUnFneHg3RlFQWUViTWx6SzVuMDhqWFFwYUpxbkRy?=
 =?utf-8?B?YnRTM1FBclp3R2h0OWp0UT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR02MB10247.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGowczBBUWVjRGVIU0lVM0UzQ2UrVVBtclhBajdwY0o3YWxmcWg5YmpmL2xu?=
 =?utf-8?B?bXhpcTRrUGZ4aTN0NWZ5S1JyNkhCdk90SHpuMlZGMVVWa3d6ZGswWGI0dHJ4?=
 =?utf-8?B?eElMZ3ZRdE5YWjVtSE8rWmxCYkUxTTNwbkVBb05pVmNuelcyK0FPdFMycSt6?=
 =?utf-8?B?NUxMTGlMaGZuUUtWZTlReEREN3BXUFB3Z0cvdVdWd3hjTE5SSGFPaHovc3dj?=
 =?utf-8?B?bVVabUNnVFZUYW43QUdOK2VucUVUU0J3blRmVEJxaG9QR0t4a1oyaTRnQlVV?=
 =?utf-8?B?OTdTeUYrV0JzakNPaWF1Y2RWcmtvZXVtR0JkOHBLd0lSRVZScXVBUjJrWGRp?=
 =?utf-8?B?Vmp0VVRCN3M5eHBzejlkc3ZrSktMenJWTkdiZ1IvcHYxcUEzMlBxUitjalhu?=
 =?utf-8?B?SWRRbEtGVllyQkJjdTRCRTV2bnhaaUFhK1UwMFVaT1NBVVIwZi9uQTljcjli?=
 =?utf-8?B?d2gvZm94K0docTIxT1RrOTNUSys1bm0xd1JNd0xvZmEzK2syWVphdTF6VDU1?=
 =?utf-8?B?ZHRmeldhVm0rb2UxNWVtRWljMllEZ1ExelpZakZpSUVqblp5ZXpuOUtsakRs?=
 =?utf-8?B?THMrRmlWdkFQL2JRVTlFM2F0cGpQWkhzWWRXbnFwaGVnSXN5Z0VqTEE3Mm10?=
 =?utf-8?B?WHVLYzh2b2crcFBtVWJNa0F3ZlR4a0VRSmdHeldwZXBMaE1uellaMVlsQjNO?=
 =?utf-8?B?LzlRYU9yVmt2REZrRmtFcTkyd2xSWTE1dWZOZEUxMXc4aTFzTkpYNTB2Tzdx?=
 =?utf-8?B?U3poM3dBSWIyRThXcmRzcGJPTnBUeVlyaUs4RkhZSjlHMFdXd2IzL2IwYXJ3?=
 =?utf-8?B?dXZTODFhUXlpK1dJL2xSa2dBSEpKWVYxZ0N3Qzd4cmw0NUtXTUh6VDZYK1M4?=
 =?utf-8?B?Sk4wbmIvWVpkZWNKUUxwQXIyOVBweW1lWHo2WVdSRFp3WHYrd09Bc3lYbS9i?=
 =?utf-8?B?ckIyWXhyT3k4N01zOEdycTZiOXgwR21jQWF6SHN3RDNiaW1UbTdTaW1tR2xY?=
 =?utf-8?B?QndDT1JRMzhtaEUxdDJwRkRRczRrc1NEejU5c1ZMU3lDdEFnNUpQM3EwNUFs?=
 =?utf-8?B?R2lKNmhBRU9idmFOQmgxU0FNVE0yWXBKQU1HUDFMdFNQVy95VTVxemc1Nkoz?=
 =?utf-8?B?VDJGRURlZkNlY2RJVDEwY3pocmdwSzBWWmRiUEJ3U2gzVDAzS01iTlNkc25M?=
 =?utf-8?B?R0FNUVNmNEo4WHhROVkyUlJXUldrUWFweTdaUmFZTzZCcVpUTDNuenR3MHEr?=
 =?utf-8?B?a0l2M3kweUN2RVVVc01KUjd2cUhlVFpCN1VpSGFSeE5zYndoTStyeWxNVUho?=
 =?utf-8?B?TktGS1A1b2E5VlNJRVVadG9CeXhwUTF6VUtHTk12dTQyWHFaQW8zeWhIZXhW?=
 =?utf-8?B?a3J5MEM3b0xuK2pCRzhWejVzcnhGbS9mZUF4SGQrckh3Zm9jcHM0QmdualJH?=
 =?utf-8?B?bWR3WnhUR0dMdDNBRS9oM001UnBTcXZGdFhPZ011N1NJSGZGSEV6N3hWUFVW?=
 =?utf-8?B?T1RTTWQyYkxnWFVWS25MVjRvT1g3aTZ4YURWTnJmYXNmTU1JeUliWHdPbUhY?=
 =?utf-8?B?NXc1VXlwK0lvMnhYbUEwNG55VHcwcStpUFJ3THRWb3RGNlJwQUp3SndvYWlJ?=
 =?utf-8?B?bEVnK1Z3bmZycVNFWXZoUWpYSjN6RXJiRnQycTR6THBVWUJiZC9PZllCa25Q?=
 =?utf-8?B?SlJSMjFaczRETXJ3Wk1Yb1p1dHBGblREQXgvVkJiZ1E4TTRoTmNGWmNzeEFu?=
 =?utf-8?B?T0RXVnIwTVY0WkF3VWZuY1N1UGdxYU5SbVBZbE5PSm5jUjdGbVAvemlDd01n?=
 =?utf-8?B?aVBwME9XS1BUL3Y4Q0lqS0toTE9GUjFIcVpWK2FjQlFtV05IN09VcnVXdFpV?=
 =?utf-8?B?N3Zud2VVemJGZ1UySVhMTzhyaklnZU53R0JYTWJieS9vUy9nb1padkF6ZzI2?=
 =?utf-8?B?WGppa1lMejBWTXJqcWJZVlZxV3JQZmRwY1VSMk5KT210NFpUKzdxMTRDa1hX?=
 =?utf-8?B?QkE5WUVpSk9pS1dxZGN3WkhjbHMyRUZ6YXl6anRpdFZkSnUvVzBmM2g3U3lm?=
 =?utf-8?B?OUtJbWNTZTdCUEJuOW5iWXJUazBLSXBMZHJFblhhQ0lSQjhIT1hpS3ZPeUxL?=
 =?utf-8?Q?mdVI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ev4z2vKwY5TXzvJFi3odYky5fpRvjIbzMP4CzW9tpv9DtguCU4a6gyBYYSmPLgdjrhgw13LGHdx0JmJ6ONbmOlYc8MFH1oW46KGWbDKOHWG8CmERFdKWosJ2nfsgLDo9hvBc5cyYuBX9xsc4nNJOPZMqG3pGe9Bq747fIb0sgCSZzVQu8DJpIlT1VpvGl8hwqhMANIULiddzexqgcK7azLLJKAzGx7fZ0vr0jYLH4viX6j2mUZzBeDaEjnXhdFL+wgYquKKQvEkBilbAIAqtMVCzuZ3n9vdxQeixrUpJA2K4LrioSdfqmY7IKW/oXJfusqSQd0DwM6C9cov+dsEXT1sJVEEUGTHS6FmWqGSFAAuwbv0l4Bxs604plNBo1HJryQPTpv0L/cSTpDO9OOZQP5fM6X08WjykfL1VlreEGKiubYCPG3XcDzLX5HCN9PKWtta2yQUGJuX4CeTeRQgzfcM55FA61WVX3Go03ON590jL3C2YvaB1ZBZy45cxDA+9S95lp0Y1DPQ+ZFH5Gocg7dGJTpJrROQnc2N6hL36jWNhmGnXOST60pdhfyxdpsgtti8KLECoRLlaF+UlaDRmkE2cvvXoSXuQor2ozFs9FdX1Y3wrslJaGQIJX84i7e31
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f148883f-88c0-4e9a-8cd3-08dc6943d1cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 18:31:58.3246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ztD+T7kts6Nia0YQIYE4TefA1YgGPFG7+O5NAbc4clx/ITSgKSyTA4hjoj62dxPwKzLTR0V1N6miQIkemYpkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7681
X-Proofpoint-GUID: Rb18qlKAuuc7aqCxkouaqA5kun1FSgQm
X-Proofpoint-ORIG-GUID: Rb18qlKAuuc7aqCxkouaqA5kun1FSgQm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_11,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 mlxlogscore=899 clxscore=1011 bulkscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300133
Received-SPF: pass client-ip=205.220.168.131; envelope-from=bcain@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmljaGFyZCBIZW5kZXJz
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEFwcmls
IDMwLCAyMDI0IDEwOjUzIEFNDQo+IFRvOiBNYXRoZXVzIEJlcm5hcmRpbm8gKFFVSUMpIDxxdWlj
X21hdGhiZXJuQHF1aWNpbmMuY29tPjsgcWVtdS0NCj4gZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzog
QnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+OyBTaWQgTWFubmluZyA8c2lkbmV5bUBxdWlj
aW5jLmNvbT47DQo+IGFsZUByZXYubmc7IGFuam9AcmV2Lm5nOyBsdGF5bG9yc2ltcHNvbkBnbWFp
bC5jb207IExhdXJlbnQgVml2aWVyDQo+IDxsYXVyZW50QHZpdmllci5ldT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2M10gSGV4YWdvbjogYWRkIFBDIGFsaWdubWVudCBjaGVjayBhbmQgZXhjZXB0
aW9uDQo+IA0KPiBXQVJOSU5HOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9m
IFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeSBvZg0KPiBhbnkgbGlua3Mgb3IgYXR0YWNobWVudHMs
IGFuZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCj4gDQo+IE9uIDQvMzAvMjQgMDc6MjUsIE1hdGhl
dXMgVGF2YXJlcyBCZXJuYXJkaW5vIHdyb3RlOg0KPiA+ICt2b2lkIHRlc3RfbXVsdGlfY29mKHZv
aWQpDQo+ID4gK3sNCj4gPiArICAgIGFzbSB2b2xhdGlsZSgNCj4gPiArICAgICAgICAicDAgPSBj
bXAuZXEocjAsIHIwKVxuIg0KPiA+ICsgICAgICAgICJ7XG4iDQo+ID4gKyAgICAgICAgIiAgICBp
ZiAocDApIGp1bXAgdGVzdF9tdWx0aV9jb2ZfdW5hbGlnbmVkXG4iDQo+ID4gKyAgICAgICAgIiAg
ICBqdW1wIDFmXG4iDQo+ID4gKyAgICAgICAgIn1cbiINCj4gPiArICAgICAgICAiMTogbm9wXG4i
DQo+ID4gKyAgICAgICAgOiA6IDogInAwIik7DQo+ID4gK30NCj4gDQo+IEkgd2lsbCBzYXkgeW91
IGNvdWxkIGp1c3QgYWRkIHRoZSBsYWJlbCB0byB0aGUgZW5kIG9mIHRoZSBhc20gaGVyZSwgbGlr
ZQ0KPiANCj4gICAgICAgICAuYnl0ZSAwDQo+IHRlc3RfbXVsdGlfY29mX3VuYWxpZ25lZDoNCj4g
DQo+IHJhdGhlciB0aGFuIHVzZSBhIHNlcGFyYXRlIHNvdXJjZSBmaWxlLg0KDQpBZ3JlZWQ6IHRo
YXQgd291bGQgc2ltcGxpZnkgdGhpcyB0ZXN0IGNhc2UgZGVmaW5pdGlvbiBhbmQgdGhlIHBhdGNo
IGEgYml0Lg0KDQotQnJpYW4NCg==

