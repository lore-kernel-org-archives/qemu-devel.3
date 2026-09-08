Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE1DC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3y7i-0000jW-8j; Tue, 08 Sep 2026 11:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1x3y7g-0000iS-E7
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:52:36 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1x3y7c-0008F1-Pp
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:52:35 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688Egaqk3328601; Tue, 8 Sep 2026 08:52:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=z+PvEz5EPQiDb+/CHwvatj37cufqyPg7mig/bb5l2
 2Y=; b=w80KHVjI2MCpO9TXQ4OmIhLxS13bhX9Hou+SSX6W6wnrihwg5WHkkaqiQ
 QfH4e8+849C2vWSSwNExuALhEyTkLhdG7m2enImEFnwVUuYeG8I08WBXYf4eXFXW
 7UFG3zzwPzgW6L3rvkg9Lomg6e4VHhqmV2LaNqA9S2lX89BMB9S599M5C3OIoNSU
 OEV72aVeGc+zS3LHj8/cVbCjCrx17jQNBQ5VFytSpSTOwPeUF2MLgH24CD3uFcAt
 wAfbOTDZ+NDW2p9ODKnzK33FjKj6gHayZSVq/ei3Lz5vcxAU2Ui5/7sTS6lrDWGU
 +s+TDtmgUU6Lz5cgh5I3B3FPQLrCw==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020118.outbound.protection.outlook.com [52.101.46.118])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gjaq3hm7n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 08:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=piAlUIGmNxUvcJRzALdrtkwLsfRaqgH+ZEeW1WC7Gmshzo0R8MkP1hzV+5QnkmMyy8PDAdpScNY0BEI3TESC99fxp13P68WY9M+Bq/rSmLbdWZBd8ok9BjYi31od7ru0AAs5iBJS58yQF3PDFJ5KvL+z/kbWEaF+2sk+5FZPFfi510NwHFEGEDq80XL+NAGYiKqsSR5vxqrTRLuQshz52Q8NumNV/YMTExB8h+2q8cEJlJkU6sgcTfGe7Zjn3iIauh6KQ1kWDr4/Ug2tv0kwWQMBrnaeWRS3f9FF+apOCiyRlmt7DdFhHTcONpANNZyfaHPzsPEBRdaT9YCDFB2iuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+PvEz5EPQiDb+/CHwvatj37cufqyPg7mig/bb5l22Y=;
 b=RV8DH5q29O3ZhVjSp2WrY+DnZdzXgOLR1Am5yvWXA9wmXztnQYFKaTKGuSOuKO+XKpskMDoP62zUfPg83q5HtGVdOSZ7UFj7ZhzR0bJahKuo28f2Bk6cgUp0v6zw8eyBa13agDZC9s1+PnYai5U3yuJMM+sMRV4/hFXGiziegvvQSAsDbdRAriNQ0yMo+Y4CVqIFcfWqpONVhSXfNrSHzu4RDZ0bxkvQYcUjucMQOeZ2s8R6mIjHAhkm7XwbUqSpjNE49X9oyfyS4Y11w5fSegTr2XyOfy/S5dR0+j5OtCCiBCW5/Q6DANapqJkktYbJkxCLR+pfio0B4sNcw5sEqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+PvEz5EPQiDb+/CHwvatj37cufqyPg7mig/bb5l22Y=;
 b=RBq5ejbDMOAmbCdtFkpZbJNLglwxtpnVmXy7ymDHmyK40k6szWVuqR5NGsK4j8IUXXQpZuW2QpQh6fUW3i7nuGmx6SNeUuvuE9t+G2jh2gLvA7XJwlP1cJmskc9sDeHH6kJB0hmBQYvBrG9G7Yob+5OV0c/s7wiOtzkg8viK0aPPQX+KiI5nnMmi9ejof9FVdbnozRA1/SVMHDISDPAcopeTqK394nHinyumHz40FtqnwYoNEaAp6z8zFia9cTTSkZOqdvNHg+hF4OKRbdQg1xH57VxeVk7Iz7fi8vOthin30YOao9vh101O6K3LOoVxvtN1JLEsRAHpBvF7D/57Zw==
Received: from SA1PR02MB8368.namprd02.prod.outlook.com (2603:10b6:806:1f3::18)
 by IA5PR02MB11930.namprd02.prod.outlook.com (2603:10b6:208:605::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 15:52:27 +0000
Received: from SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2]) by SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2%3]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 15:52:27 +0000
From: David Vrabel <david.vrabel@nutanix.com>
To: David Vrabel <david.vrabel@nutanix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: [PATCH v2 4/4] hw/pci: Ensure PCIe link speed/width is consistent
 between both ends
Thread-Topic: [PATCH v2 4/4] hw/pci: Ensure PCIe link speed/width is
 consistent between both ends
Thread-Index: AQHdP6oMbYXDBfDPrUOXG+73fbrQEA==
Date: Tue, 8 Sep 2026 15:52:27 +0000
Message-ID: <20260908155223.164787-5-david.vrabel@nutanix.com>
References: <20260908155223.164787-1-david.vrabel@nutanix.com>
In-Reply-To: <20260908155223.164787-1-david.vrabel@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR02MB8368:EE_|IA5PR02MB11930:EE_
x-ms-office365-filtering-correlation-id: 5da101d5-9e60-4e5e-2887-08df0dc12ed7
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|18002099003|22082099003|38070700021|56012099006|5023799004|10067099003;
x-microsoft-antispam-message-info: QmniqyebOia/b8VL0+Q3RxcHe7JRfJTdgtFnZhUjmyVC/T7G4bQqqRUxHIzNSQxwcBud0zVAAWvfOzjInmzjvzuF9e9Fvu4sZNyaqfs+3kLcSGpCinNEmN7rLOOI2xcNsxZhAqWSca8QaRBTcyyupnSlFg4pmLrJ3omLSpEGoelmoHGOkqfHxwAkMONOd3lyQegKsHIBvXKTRdL0BU+AXd9ifY6a01UBpYYi/AJRKsuE+3SxXJ3ScDiYXfgYvFmeHLg6GMd4y1iOriCSrr5HrYEOMJw7n+pCCxKqvhey37Ty45xhmzKjdhxELVYFZpZPnDZIIBeshrQhZyHT1F0dEc5Eh9G3TgOvKyeyLak2iJdMOUKsWK9+AwCtb2vSiRyLCWB99GlcXlMYX87gZHfuTSfOrXHIyYo0xYjuEevF02R7alIdZKZY/s5Zv9IwpbPPonDdDuLAV4pB6PvZlt2GhyZUXLtZYN4VAVHWKDStEmxM4q15vsGV+NbS5GoI3SJScGzDHxL0MZcKEScy2NzUasJBet1xgkHg3QfTG3lZBQlBO0diDACsmZQAwLqpj2Bjoy4385loPDz4lCrD2G3llaJVZ1U6jP4v0Jtoz+2XBEx0/sQeNxHTaHW4WseJaloMPFOORI5GsPAY5Nfap95mgoS3eIy6RetGcNzeLYtPfahloWWLeOZhSoZFEkemeN6ziYfPOndJnio1CGr7nmeOx77vFIUuHNlEyMl6WEzGFT0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR02MB8368.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(38070700021)(56012099006)(5023799004)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cV0YRwleeutkQuWQmsQnxoe+ZrSngMUt3KtNKrxHQHVk3Dkvosmq9p9NNJ?=
 =?iso-8859-1?Q?BPHjIrnGgzN61PWyLHb6wV67V+ibyw2pHRsAfjVSUEaeZ5bZffpshLLgtQ?=
 =?iso-8859-1?Q?4nIhl51QxdaI/45WEjlYjgSn37iyhrWFjRlbn9vxR2owPFVWOB1l6tUYxH?=
 =?iso-8859-1?Q?XmG4l0BGlsqB5nW3G7GeHUirlnGeeVeKqImtzl/jBAxfHavDtxaVAjlSnL?=
 =?iso-8859-1?Q?XT+wtMfpOCIFtukkqpjS1igLsYgXPD5aM4NU3o1paXzucSM4eg0JgINwrE?=
 =?iso-8859-1?Q?e+IQZ9ufTQX9U4hRBqmwz1BWjo6fENWXP9rpsVy5WmmrhdxxAfIN0yX2P7?=
 =?iso-8859-1?Q?qMK6cr2S+i2qHoFeqa6+v4hhmisTRpy7sXaf621uQiuJbcKvPeNiwreAy7?=
 =?iso-8859-1?Q?MJJfIhqWawvvjIvJst4EhRaPUDT/M/S+9wRZ0rDMFNGPCLh7hX2DNY7UaE?=
 =?iso-8859-1?Q?n/F/ns63lPWzPEkNiOLufJ8uLgDV7phtMBv4+1vlSgpqICi4ft7ViTv/nR?=
 =?iso-8859-1?Q?DnQU4xQotTB2TTM87gpygFu7PSjdPfw68mv75VHqyQW41cW9bPmL6HAiFn?=
 =?iso-8859-1?Q?5t+GQtDryr67Z6yUBkzNv6jMzyC1SjpKtKW6Z7WwAjNAx96I9kfIenHAhT?=
 =?iso-8859-1?Q?5qXs6JicWx+73cH5PdebTzBD9llVUSvVLNE2GFRNMp88tV/uafz8YncFmg?=
 =?iso-8859-1?Q?5LCCmv4Q99exoBn276TwUy2ymz3Wy5gCdIvHEIxNQ1MVzkaLDKFbGav39Y?=
 =?iso-8859-1?Q?hFpDh2/8hZQHVqdptUh71T/r2dDrDT+PgHAMlFJoOY9RGkoeqvy0En6zv/?=
 =?iso-8859-1?Q?izK1qVBEyeSZCkFjEtSfKlQDBmI6GEHVfZ4JAR+idl5pltvs8jNigUlGvc?=
 =?iso-8859-1?Q?n0hx2IrjcDN/lXGuCxVE3Nx0lquG/xFu40TAKNQNxCSdo8n5G/hDS4dprB?=
 =?iso-8859-1?Q?KsJXN/msV/I/b8haQLr5qktjtnxPwIcww7z+mIYZZ8ej8qq5AUTcouihqG?=
 =?iso-8859-1?Q?+FlnSdGAVGIKqtRDrZJteIyNGzmEN09vbosPx7S3Cu10mmp5GJQIrcZBk4?=
 =?iso-8859-1?Q?v4VV8ySnGWZoLZ2CMw3a7cbiCpx5I4RBl/bazznj9E0hvhGvQ9UI1AhKKM?=
 =?iso-8859-1?Q?De5D0Pd8gk69k9WnNS42Mb1Zb9dy2ze3siWOLEQ+dhYdYMFa8rviCq16AI?=
 =?iso-8859-1?Q?RKLH/dEq76RSqjHlMoX40gW/jE9FrWlY8Ak9L0tgFwsAbfpXlpmKexvs8g?=
 =?iso-8859-1?Q?OrMzRfb/FazBg9WggzoFPVbxbI8dgmUxr+6KhTunviQf0mhZVThXEURpNk?=
 =?iso-8859-1?Q?zLLhFCBz8m7O0FhUMc1Lr6ENtXCKO20SeZlJ/bG7+PLM1VNor4B5jtqJea?=
 =?iso-8859-1?Q?Kfn/kNcrjoiYor/2nLeC46mXC2tuE3R1E7Gtz+O9Cpc9XW6LE+6YDhh1/d?=
 =?iso-8859-1?Q?X85G0H/E5dzOr/X8M8WWNH8yDigD8jk5Zmhh0IRjjc3XEmSq+XxtW9lqtJ?=
 =?iso-8859-1?Q?U8a60VQzLHQjgwf5MKNCCkjfOm1bY0p3BK3iL9pjLPBxBohmUWSKi4UT9D?=
 =?iso-8859-1?Q?DtShr6RSLVRO2roAzAohzCtteEbCke09Pa9YrEZTGtb8Qz/IJQRgvFNd+O?=
 =?iso-8859-1?Q?oR+MAWFVD23Ok9IyzwDexASJqjy96nYY3C4On2+0h+jgAMufq6XTw1wTZZ?=
 =?iso-8859-1?Q?tt3dDkZ1oVNYPx6BF7YPjzRRZjflb+2Q+5rPesODMmk6BK8/eEMCT8CvFW?=
 =?iso-8859-1?Q?HGTHytp/VZIkFvohH8NMra4wh4VB5erDmzZ5hW8PaHtm9ON4oUqh5Lk9g0?=
 =?iso-8859-1?Q?PGQ0BYLnUw3qbNCUMf6qRaBVr9g7u3E=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TeaerTXGRaf0JjGKLrtBtx+LZLmz/BSiiUg0zlbo4MsWQgeD0zL+uylB1X00XiglIZt2bVeQg32m26SRql5geQMYM+Nmjb9OEDsxptmDoWIlMgyJSY2Sp9ojgC2tVgU/3iUe82QkXYeCyIvDMgeIiJqYcZ51XJrOur66I1lc8AGhocGnQJTnn73Y5PlvJl58ZV9IpTh4X2ap4NXNXukdYpZg6WZ1YaX5s/WHD8IKXCZ61uCXWiUD5BUmes/JaM8TJuvUqSBapz2VnrjYt1mv40d5sJeC+V1H3MiXl2HAbS6VR5mHpMQ5ys8mH7UX7iUD4d/TWUT1oH7gd9h5VOMElA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da101d5-9e60-4e5e-2887-08df0dc12ed7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 15:52:27.4983 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cn8YhZoWFca6htpNvNC38TE1MkrLbJiPXZNrueXgl830GjF9Dh1B8u4VZv8F7mmEFcghdHyYROKS4QW2proimQBXMbb8FOC5bi8k77nFmCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR02MB11930
X-Proofpoint-GUID: nXNxs1qJDZYbfRdQJ-Pj4AeaBegi0utP
X-Authority-Analysis: v=2.4 cv=HdckiCE8 c=1 sm=1 tr=0 ts=6aa02f3d cx=c_pps
 a=Pshx6wbRF4nJNM9KARsp/Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22 a=64Cc0HZtAAAA:8
 a=dcECTNVlaVxwar02G84A:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3MCBTYWx0ZWRfXyB5wNqd04AYc
 YeP3GTyy8FWICSDlZ8FeTXz8eynhmq3plVQAToW/hv41D808PVH3I6en4tdfBAe4bZMe0ds6YSW
 IjjXc98CEnFD7L9H6x/7pdSRm1yHBjug+qvp7bTAMxzph3vl16TcnblcnZYvykZFdF1WPFDlfT/
 Dt45N7bvvb9qinzvxyNwJ6KxxAXVoIUKZnmSf56puAzbZ/BV5SZYLNHnHSNo0c8uQWUkxqLbneg
 v4Bnw1NIUcjnd5pS6lHlDIUsEoQyfy9w76pfs6gNuVeWtklp+C/iyC+3SAt68x6sMiMLaGWjWqw
 1vrjyjhCmGwit+Z9TRTjRqRr/gcDJcgTAzUlNQx54/yeDr7Zoos3x+7hW2E61X1S7Ry59HMI4Ex
 +/ljzliZ+tzL/8GAqFoIXb0HCJBjhOfB9wspdSv9uoH20mt4zuNlRuqpgS9NLj/ztWucAq0r4JQ
 JTW3uyMhw5HeRKovUWw==
X-Proofpoint-ORIG-GUID: nXNxs1qJDZYbfRdQJ-Pj4AeaBegi0utP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3MCBTYWx0ZWRfX7H4lMMDLIxO0
 1Bgtmn+CE3aU5WpUXQ//QpOkU7ke+P1s7VFDeHBswWSzAy1bzOLDcmFflGG+LS99ClnTPwrEFZu
 fYw0cmIBqvT97FGtGmYBY6gGPiwcyJ0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=david.vrabel@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

If an emulated PCIe endpoint has higher link speed or width=0A=
capabilities than the upstream port it is connected to, ensure that=0A=
the link status on both ends is consistent by using the link status=0A=
computed for the upstream port.=0A=
=0A=
If the PCIe endpoint is a passthrough device, the link status=0A=
continues to match the real status and consistent values requires the=0A=
emulated upstream port to be at least as capable as the endpoint.=0A=
=0A=
Signed-off-by: David Vrabel <david.vrabel@nutanix.com>=0A=
---=0A=
 hw/pci/pcie.c | 26 ++++++++++++++++++++++----=0A=
 1 file changed, 22 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c=0A=
index 4622c75e48..66d778413d 100644=0A=
--- a/hw/pci/pcie.c=0A=
+++ b/hw/pci/pcie.c=0A=
@@ -169,18 +169,36 @@ void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExp=
LinkWidth width,=0A=
                                PCIExpLinkSpeed speed, bool flitmode)=0A=
 {=0A=
     uint8_t *exp_cap =3D dev->config + dev->exp.exp_cap;=0A=
+    PCIDevice *upstream;=0A=
 =0A=
     /*=0A=
-     * For an end point or USP need to set the current status as well=0A=
-     * as the capabilities.=0A=
+     * For an endpoint or USP, set Link Status as well as capabilities.=0A=
+     * Provisionally use this device's width/speed, then adopt the upstrea=
m=0A=
+     * port's values so both ends of an emulated link agree.  The upstream=
=0A=
+     * LNKSTA is already clamped to the negotiated link capabilities via=
=0A=
+     * pcie_sync_bridge_lnk().=0A=
      */=0A=
-    pci_long_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,=0A=
+    pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,=0A=
                                  PCI_EXP_LNKSTA_CLS | PCI_EXP_LNKSTA_NLW);=
=0A=
-    pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,=0A=
+    pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,=0A=
                                QEMU_PCI_EXP_LNKSTA_NLW(width) |=0A=
                                QEMU_PCI_EXP_LNKSTA_CLS(speed));=0A=
 =0A=
     pcie_cap_fill_lnk(exp_cap, width, speed, flitmode);=0A=
+=0A=
+    upstream =3D pci_bridge_get_device(pci_get_bus(dev));=0A=
+    if (upstream && pci_is_express_downstream_port(upstream)) {=0A=
+        uint8_t *up_exp =3D upstream->config + upstream->exp.exp_cap;=0A=
+        uint16_t lnksta;=0A=
+=0A=
+        pcie_sync_bridge_lnk(upstream);=0A=
+        lnksta =3D pci_get_word(up_exp + PCI_EXP_LNKSTA);=0A=
+        pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,=0A=
+                                     PCI_EXP_LNKSTA_CLS | PCI_EXP_LNKSTA_N=
LW);=0A=
+        pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,=0A=
+                                   lnksta & (PCI_EXP_LNKSTA_CLS |=0A=
+                                             PCI_EXP_LNKSTA_NLW));=0A=
+    }=0A=
 }=0A=
 =0A=
 static void pcie_cap_fill_slot_lnk(PCIDevice *dev)=0A=
-- =0A=
2.43.0=0A=
=0A=

