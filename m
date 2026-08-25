Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AB9C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysqL-0000mA-H0; Tue, 25 Aug 2026 11:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wysqI-0000lg-VQ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:13:39 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wysqD-0006g2-TW
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:13:38 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PEbkNd2274616; Tue, 25 Aug 2026 08:13:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=x0aynVGiiOnwDHLicgJ2jYSH3QelhW4HhnDfV0vtC
 tI=; b=LgrnDf72pGLsEsBKjPGO5JoUv2R9D5rvw3m6zMNaFLTnkDKqypNzmtno9
 xTdox/FNFEff8K6L1tPQ1E9mAkYYLMDzHI+nPVbwPbhSaTR3zoqFbG2JHJjtbm4g
 a/6OiSUKVNqdaKkoVIxEeqnPkSqMMUQXPL/YWNEwbfAvoRQCqz27DPByxaExYfdO
 JPfO3tVOg+yVF3+47n0n4rHS6EsCBlJIud5UuHgLmrQYgdmySF6fxbqmSoLfpK8A
 RSYuCiTcg1Cs4K1soUm9IXJehUCN89kgujLaf/duH03uHrivhhbfE+M97f9wsuRx
 Xm/PDrStaCMQOJyvg6QT8XMBVi4Yg==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023132.outbound.protection.outlook.com
 [40.93.201.132])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g8sy9aqnu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 08:13:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEk7M7WYqyWklyXwTzxnTmB3RUuNXglfg2VcxBIPX+yeT/BCTBHMc9aa326em4UF+BR3rVRIWvRHt1OZHH5rrcZ5DSl1VTdxYbj9ihRoKWwOpXD/nGkcwoKnksLr2cKaBzBgQtTjMYjzgryN3H+yt/9i7359abHnm7Lnys8LT6pmAuvVh7yS3Q5Q7FxLoVOrzWHxxv5zixOQIKUOUT58tPjURAZDH3xWC/ywVF/qyx+xCjZDhUw0vbGgokGrDI1qrMUJ8MVpvygWTk6gwx6BqbWdig9/RyHt5pU1UCznKznmTj2O8hbQ355zbaKABd3ouUSprC0PLOTN3KBBSnx0jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0aynVGiiOnwDHLicgJ2jYSH3QelhW4HhnDfV0vtCtI=;
 b=kuBqPt7opoQ5vB/ihZ+8YynA0I6EQIeR2IGzVRihoouXMAEDZiCwXwLrFCrEc6a1p/O2cXMcjYYXypBOk03ONkzzLOAM20xGrD9cGpc7JR5+5Z2TgcPoYOoHW1KqEBGOZm+k+FSftQwHB6tGomA6uguUl9DhqZhynwhLxf21Io/mgB+pIJU3pjsXfoL05B+ZOgy/T90gHoA7y+npcq1OvGrAM14zmK7BvYHWdrzq9CwpACj0TBi2Qd+ksh5zrdQGqXh3hx2K8JG4Z8JnUYcdMzQdxjumrpNHSzWfU+AdsU1ysIFdUW2u7cbAgl4Pt7FG/lx8fd/xdwf3E5YFjzD99Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0aynVGiiOnwDHLicgJ2jYSH3QelhW4HhnDfV0vtCtI=;
 b=Bnm4yrvkgiM0cBf0/KD8EhefNosCG7vBhraOjirqTPf0qMJN86sn4Q5jw2u11IKTjULdV2Ep4+oQxOJqyJ4xB6f5PX2aRoYB0FRpHujFAyJ3LEg347H7XO6+r+V4AxJFyqdLo+PuGW8BoyNHn2xTvqPvehjVxHJsbdQbcWWASEieJYnv6dldXQGrQ8V7ItzXthztVTAp1I8ublo0wuHyVsOhyPEHMtyuU1Ucs5WyZFuRxKTbupM9Cp+ut6Lr3jGpqn5TRaddPPjgAbTYb4S17+SdfUzMtXSPulsUbCBt/BcW1RVrcTUCtdh+tEybNVXuMSNrKqDOXr7Wx5D6eedhrg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH0PR02MB8136.namprd02.prod.outlook.com (2603:10b6:610:10d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 15:13:23 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 15:13:23 +0000
Message-ID: <8ad6b0f2-abd7-42c6-9c42-2986ceb63474@nutanix.com>
Date: Tue, 25 Aug 2026 16:13:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 37/74] util/thread-context: fix property typenames
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
 <20260818-qom-qapi-v3-37-24b8bbbe3d86@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260818-qom-qapi-v3-37-24b8bbbe3d86@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::28) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH0PR02MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 98f8585c-0823-41da-619d-08df02bb67bd
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: simj2PmDh7ej4JnJ4Tm+USPY9BAzl6MLcbmX5ANu5wtv1MN2H10RVTW9Ahu7M5HRoFld2yaih/l4Mqiz/ln/gULZvN0cU8a5N02xst9h2pI7t8S9OjGbdxg6a06J/+VH86DMtbWas3mtpMQxvkWmbCSDys9iT9b6rUCrqoT2fz1K0rQV6PiKWs44gYicBmz0j5eS9pNXG4dsWM/sgb9k3Xp9ruB6cwHpXavk4w2rDkEtUIpd4SBiS7IPn/kJS3VlOh4O3hVsKxIYxVojKmdD3LcO/eWNaSSfP4GpP5b58agc69IaDkeYUzuUzngEcfmqXymsYr8bOsbI7qNAbJbtSOKTUQX64EhbzcNNtIIv6BYJibeXdZSX2Esleg7KPYjpWYTh19LkAVCWPBR/VemZgTw819gWJUqqw6m5tAT+WIk9SoBEqtDdzd81bsL8S0SgXE2JuNSMxdxWdaUgbVNhwQeMib/S3Lwz87jYXkc561737cQDciomwSudml4EXK7HATmuMHcg5IF1LvXWyLT5KcYNc+X7iIPJoMB6MogCz83sASOM6gS8FNd4Ivw4Hz8WiOIAJGxuPS+k0SuxzkXvDwRhK4pccz0mmj91mpC4r6iL6btBBLV4pEYjP/OkSc0psTYhlGPowYBE4JMB7vHcIAye2krcFBuD4gfrxCWb7Ng=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXdIMy9PK1VmSGJZY01XSWJWMTN5MUtSL3lMRkJUSUZUZ3RxcUpXY0Njem1l?=
 =?utf-8?B?NjVPc0lUU01oQ1pIem1ZZDd0RWZHQnN0OEtrUUhQY25ETFFVTS94bTMvcU0z?=
 =?utf-8?B?TlVJemNNUWdYaTh1bGxDbmFUdlNkY1E1amVia1dYN0Q0d1FRUEU5Z0pLSmJZ?=
 =?utf-8?B?YXdmV3Y0enFvaWNFTFc2aDV0N0NHanhRdUNWeTNtV0szNFBkcTVnZ3F4aHNu?=
 =?utf-8?B?bllwaWd2Q0VtNXJ5K3ZmSElFUmlOL24vOVZhU0toZEtCMDljUE1uQ3EvVWJG?=
 =?utf-8?B?TVViVjhEWTlUZURtZmpzSlJPSkFKV2xlbnBOMDBudWN6TEU0Z2JRZnJYWVB1?=
 =?utf-8?B?S2p5RUJSakhEQXczbXNJa3RTYkhyVW5iSFArNU5EQUNnNFF4R2NGRTl1cnpi?=
 =?utf-8?B?REQwNEJkSFhYOCtqNzI4Z3lDZEtuREtKbU9VRm5jRFhwOUpTMHB4aEJwYlhl?=
 =?utf-8?B?SzBqekpZZ3ZaRW5veUhQbFpITlRQNmd6dEZkNlZxODhpcERrR0RFTXZKQWxh?=
 =?utf-8?B?c2pwdWd4TWlRYUhVSEZjWXFHL0hmNlBOa1pMVXFPV3gwZ1NSZWRZNENacm9w?=
 =?utf-8?B?bktxL3J1ZllScCtQSUZpSzlab0c3d0tleWJreFhoZHNNTXloUFV3WWgyc2FN?=
 =?utf-8?B?RmlPOTl3by9XOXJsTWZRMHZIOEE2YXVCaER3NWs2Q0ptaUFUajBNNXVsazZD?=
 =?utf-8?B?SVJlWkJtVzJERG5QUzNlM1l5YVkzUVNwbXh3em56WXV5QWdsNjNBdlNLaVdM?=
 =?utf-8?B?NXJDR1llbkRZM2R5T05UQUVSYUM2c240TEpEdzJuM2xRNTJtazBESFYwV3hZ?=
 =?utf-8?B?WFMwalZyd3ZWRmRFbG9yVXpnMnFxQ25TU084YytGbFpzNVQzZU44VzlTKzc1?=
 =?utf-8?B?bzFybWFMdzFXWnE5ZERnQ3k1L2JsUExtOWZJTS9DYVpIZTdVL3ZEbEhjZkJv?=
 =?utf-8?B?bDZqR1Y3WmhwcHhQdXg5S3NkdjEyU1VCYk1uVjVTckhaODduREU4Sm9DNXFK?=
 =?utf-8?B?K2lyV0UraEJLbDJXUElZMnduM3FaOHh5anp6cnRKNmt4TVd4ZGFjRU9UMEVY?=
 =?utf-8?B?bWQxanFDVE1rcmhmYmo0SE5DSFBIam8rY0J6S2RlWTMwM1hnTmlWRnFIbWRO?=
 =?utf-8?B?cHhUOTlQNjNXbHN1eGNUWXFxTWNnTGZSQjc5eGhQZ0xPdzg3R1NtamdsNkRZ?=
 =?utf-8?B?OEJINTRWZjFhQ1ROVVF0OVFYdHAranRTcmh5NUJGdHZUSWt3anpocmlNY0Nh?=
 =?utf-8?B?d2J5R28wTTFUQ0ttWG95dUMxaXlrcUtFbHEwWWRLTVJuK2owWWpNWTVpdzlE?=
 =?utf-8?B?R3NJc2I4ZGpxMHRXanRlanpIQWRUZTJwL1VabVYxd3RjVUdWRXRXSFdFdTM1?=
 =?utf-8?B?SWNJM3VTOHBIb2lRa1FhOVlTSGlob2h5dTcydHJpZ0FzanpBL255dWhQd3hR?=
 =?utf-8?B?d0NFRWROb2FSQ1hNVVVPZjE1KzBOcjY1ZHlqdXdTOUFHdzdVN2JDamtncnNW?=
 =?utf-8?B?cmczMnQ0elNMQ1hFaWpSVFpUZDBSOE03UlR5N2lIV2pmcG9TTTBxK0FJbGRo?=
 =?utf-8?B?dXVyN3laenlicjBhZHYzVVVZZE1UM1dNdjNhaU11cU1KdnR0ay9sVUlvNUo3?=
 =?utf-8?B?QVJ5U095bDRTQTJuUkUycDZGZHlucE05a0FTMHNaQ1VRYW9FbmFzczBQYkll?=
 =?utf-8?B?Y0xtcFMwbUtkNk9WSWprVXlvLzg1U1VQS3pZcVVvMDB2Tjhpc2dMeHNsYXpy?=
 =?utf-8?B?VzJJdS9ic0xKZ1BKYVczenR3ZTVlWUFZMmtxQk1LMzdIYlQ0R1NjN1J4bkZF?=
 =?utf-8?B?U1E5bC9yeExHRm9TQWx3YkxNMUFoZWovK2N3Y3VlMkVvNlZTcURUL20yaHlh?=
 =?utf-8?B?SHkvS3BOSVpmSzVnWmxMZnVzRnBFaEdZajZvUC8wUmtKeS9ydjdtY2kvOVVM?=
 =?utf-8?B?V3FXamMzS2dxMmNEdzQxTm12d3NNaER2eU5XRFBvQUpoUE0rQVhHY3IzZFdC?=
 =?utf-8?B?OVEyMUdTN0YwQ0JtMUZHWmVCNm4vTU5QbGdDTXBmQUo2ZGRWNGJPWjI0Y216?=
 =?utf-8?B?K2tuSGl0ZWxtc1lsR2RKZ0ZFNUFrd2k0c1N4SVY4UU1QTmpqR1Z5TWJaZUt2?=
 =?utf-8?B?U2ZOMnNHVFh1VVBCU2d1OHlmVEtCTnZhaERTbzY0T0ZEdWZVUkpXZEhDU1hu?=
 =?utf-8?B?c1E0b3BmZXBjWXdhcFBMUmNvYUszN2ljMkJJdUp3U214ak0wYXBzczFuc3hB?=
 =?utf-8?B?TFNpM2gyY3drcy81VG5CbmNzUWx0bytsRzR3SGZuUmNXSFFlaE15OE5CZ1FJ?=
 =?utf-8?B?QVo3T2VVVDJoeGd3R1h0TGUyT2drdXJ2RnJJYkpYeWhicVVUeDNDRUZJc3BY?=
 =?utf-8?Q?7FYjs6kRJm42+YAw=3D?=
X-Exchange-RoutingPolicyChecked: ajnhR//4wEiCFFXpEb+h9t4Z2A33Ow0Qhnqkg93hFIJzCdlSQ2CZau5e9tFBHGhLAkfKsXW8ubAhJdvgKn8/0lZkKrFYjxVLLSL90+sGry4SMCz/cxCPzuR5nE709u37SqUOvDVC83geuyXqzJdgWJafPcO6XKoXS2MVpGsVbWX3bCVspxAV+AINnTe7yw0MDDHoliwyN8YlVY4PlZyVYmDl+7VXxHm0jvpwbGFL5tozcZFIpxIopS7UiN9uj1NdsZn9QSMyTri7rSpF11j4/xewlgAfvZ4nsMlAz5M9Kg1BxA2RvSLkaTeJD/RkTDVNl0io8Hh7rALTttlYHcnEkQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f8585c-0823-41da-619d-08df02bb67bd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 15:13:23.3781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U28GyM0+EC7f8hAucztJDbr/0+dALRjWiZvK1HzLCznYV7HFTwsUaK5ODDZKLyo8PuPMP5Y20NCCU7jhgHNaUAmT5yuWtp63pUSdyizfGNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8136
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEyOSBTYWx0ZWRfXyX20FWfd+QeR
 y1yiUV2osT6E3xBqDWn3KC9+3qMBQ0wWn/vad9FJLq5Vw+VosHeBIYne+NPi9z9+qn05tg7VslR
 qpw8rgFpcFIlViEOCO/wsQI9sBikzNMRdVocQALP6mu0HNImdL93GqknjATONAxAKiDKs+4R3KC
 KMmE1cnZena6QxoOZcypxghqmi/XKI8N1Wj4lMX0HOjUV8avOSTMpneU1eoRNd3Bvdyrq7R+TRy
 QrI/XU8Q1u6bJfTXH3SWGul3U4htfzG8Nk3V44rFPHsJSvgbgW6lkVYH5w1JpEie/RWTZfzF2av
 NzH1cOTJGha2vVKuI6YuZwUqrwMGj38av3IEwa1E+50KCWhpXqGcZHPvpNrUFV7+/OFq5OG7oAL
 kG1Uy+8rPO5sjV/DZ+R7RyYKG0GsNdEUjtU6DVsaSP25afp1D/6/m1EJZPw/BZtcJAfmjv/P/PP
 EAns2Ev/fGWlcP2GlkA==
X-Proofpoint-GUID: PuylkYb7FsKug3Mc_6ZggjGxrndURn0f
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEyOSBTYWx0ZWRfX2oDrSCOTnl7s
 j1WnaQ45rlQozT3wZ76TbNMSAkORE5kmARzPywatqmfbjBboEuD6z9/BDA53LgC/ibG1LYcjQ4s
 sag2CLp0DZvX06yr4NXoe5jYAnrDKOM=
X-Authority-Analysis: v=2.4 cv=W9AIkxWk c=1 sm=1 tr=0 ts=6a8db115 cx=c_pps
 a=xHq7MdwY2pS/T2WNu/1Gug==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=M7pyEXlYwTQQnTfN5igA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PuylkYb7FsKug3Mc_6ZggjGxrndURn0f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On 18/08/2026 12:11, Marc-André Lureau wrote:

> "thread-id" uses visit_type_uint64, "cpu-affinity" and
> "node-affinity" use visit_type_uint16List, not visit_type_int.
> 
> Fixes: e2de2c497e57 ("util: Introduce ThreadContext user-creatable object")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   util/thread-context.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/util/thread-context.c b/util/thread-context.c
> index 0146154fa56b..88d8f0a55a4e 100644
> --- a/util/thread-context.c
> +++ b/util/thread-context.c
> @@ -278,13 +278,13 @@ static void thread_context_class_init(ObjectClass *oc, const void *data)
>       UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
>   
>       ucc->complete = thread_context_instance_complete;
> -    object_class_property_add(oc, "thread-id", "int",
> +    object_class_property_add(oc, "thread-id", "uint64",
>                                 thread_context_get_thread_id, NULL, NULL,
>                                 NULL);
> -    object_class_property_add(oc, "cpu-affinity", "int",
> +    object_class_property_add(oc, "cpu-affinity", "[uint16]",
>                                 thread_context_get_cpu_affinity,
>                                 thread_context_set_cpu_affinity, NULL, NULL);
> -    object_class_property_add(oc, "node-affinity", "int", NULL,
> +    object_class_property_add(oc, "node-affinity", "[uint16]", NULL,
>                                 thread_context_set_node_affinity, NULL, NULL);
>   }
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


