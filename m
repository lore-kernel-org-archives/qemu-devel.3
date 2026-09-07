Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAABC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 06:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3T24-0002UG-Sp; Mon, 07 Sep 2026 02:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1x3T20-0002Nb-4e; Mon, 07 Sep 2026 02:40:40 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1x3T1r-0006Se-93; Mon, 07 Sep 2026 02:40:34 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6873mCIK3025308; Sun, 6 Sep 2026 23:39:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=s4r3DLlPxtJKfwMbvE3JNtQ7btJkNB1BDWRacxnM0
 RI=; b=DIPrhelYGIHhfMqzf1mbBx+/trjKLJUzqtMXkxtcw4FYSS/kU9iIaVVdc
 oYMFTdeazNQe/mXf7b/ei38ZLs+iWR28dRs0kz+80gzHUBPmoO7l9B8GA8QomBd8
 Iyak24IScAD44zsxur+o4MaUfG4/vaS7exTQHKfTHvBA4vRkl0bqZaLwWTt4ebbO
 mn4JXEj8Gyu5gHXespFyrlMTpHqrNSzmXCe91Y2JCN+bG22phAO2xrDmdlme8s/d
 Bz14uX/0xvXKYefQ+TvB+9cLXHpnzqL9EgcCib5m/3YURrw9qDYtNYXUMmL0qNnp
 8o8xL0AB3jSJpxRsfhqjHjyXwYF6A==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021078.outbound.protection.outlook.com [40.107.208.78])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ggjkwt9ra-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 06 Sep 2026 23:39:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTs17iq3Yndnpwuzm8kzrzB6oQmp9i1vx17+YusdEHBtVwZC9y2mal7fBOxZuqSnj6ve+GUe9MIxtjiHP7R2LrclsP5VX6tH2B7TXWIph+obrT3gw/N2agS7XMbn9EyJutjLNmAa4/Dv+nILZApfejzBiAzGmhg48j2ZM3D1+BnrrsxnYztTlyYO7w2cb0QqyIKxcJvCyQ9bcv+sIuhuQ8ZxwLN/JC+ifc7jM9tu9J5rKTQqbdUbUhZrvBpaCnElQTo/Xcl5evGgwdltmm5stlFx4Ptvpc5gy/46dEDBtbcOboA0shyDq72F9ouxKg3aI7C8EEDyLIzEDwXs15l1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4r3DLlPxtJKfwMbvE3JNtQ7btJkNB1BDWRacxnM0RI=;
 b=QMNsjoDd5xdQIBF8YhQJsRnfFgtLP0YratoIFA8+Vw+1sUACSXf+i75cVtQ3ySjTRI3zf3ySMFSgUeU4PrGGV57/7qp0zrT1hljjACZIalLhVFHbEP1N4JptIyICPryasG/nbYQdCWiTTW3TFVrYrWNn9aFmgBD1PQqAPe9DZhsHOauE2K6UiI6dpeDw+4ZWianREtGiNJ+aIR9EU48uL61PSnYFq4i7SDzEl5RwWuJgdbBlSxOqRysUU5S5X4cySmQqLrN+BZmhnrvH0XuDp0QhYFfZT4ZecGzYZ+xsy+KjjomsR6934BrrRZ6C6tl0lE2j/5vexskIHwg8JnKk6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4r3DLlPxtJKfwMbvE3JNtQ7btJkNB1BDWRacxnM0RI=;
 b=vx3GjJUchRTZ0jVUvLDYiFiX9dcrRUPRYiQV8Ss+xdIV7uOjlxQzFAAiAI8/Qdzcy1XY/qbCBHNeaufk42g0SZQoD9dKWoXC2qLt5h08zKRCkL6yxXWdsJM2xx4MqvcGQdn/SgHCKO/hglQWFoKO9xIesrYnDgJAwxiD69HF7U+6G2Q5blteHMBp0UVst2L562N3JbvewE6ytT6r41RLg+ptDxKhg5OjQL5ZobLjuUNLvSr2EjmBbKE6DwZ9LQ9gC5atdjUYF7ywZlF5YwWGmu8KoneM494O8C3zxb3zinfWRcyptC3QInXh8O3Zl0oI8Dk4ZtBgAZMft0nycegoDg==
Received: from SA2PR02MB7564.namprd02.prod.outlook.com (2603:10b6:806:146::23)
 by DS7PR02MB10962.namprd02.prod.outlook.com (2603:10b6:8:262::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 06:39:39 +0000
Received: from SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4]) by SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4%5]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 06:39:39 +0000
From: Khushit Shah <khushit.shah@nutanix.com>
To: Shameer Kolothum <shameerkolothum@gmail.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "cohuck@redhat.com"
 <cohuck@redhat.com>, "sebott@redhat.com" <sebott@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "maz@kernel.org"
 <maz@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "armbru@redhat.com" <armbru@redhat.com>, "linuxarm@huawei.com"
 <linuxarm@huawei.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "salil.mehta@huawei.com" <salil.mehta@huawei.com>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, Shaju Abraham
 <shaju.abraham@nutanix.com>, Sandesh Patel <sandesh.patel@nutanix.com>
Subject: Re: [RFC PATCH RESEND 0/4] hw/arm/virt: Add support for Target
 Implementation CPUs
Thread-Topic: [RFC PATCH RESEND 0/4] hw/arm/virt: Add support for Target
 Implementation CPUs
Thread-Index: AQHdPpOoiNyWNqUXZ069kRXcGmJmxA==
Date: Mon, 7 Sep 2026 06:39:39 +0000
Message-ID: <B789DAF5-F8F9-444C-B0FF-4CA0081AFDED@nutanix.com>
References: <20250801074730.28329-1-shameerkolothum@gmail.com>
In-Reply-To: <20250801074730.28329-1-shameerkolothum@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR02MB7564:EE_|DS7PR02MB10962:EE_
x-ms-office365-filtering-correlation-id: 3482ef69-8396-4b6e-51cb-08df0caacaa5
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|38070700021|6133799003|3023799007|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: BOUDzZXbY9Qz3O7xrfM6rEXV09n+kDC1aM9uC9aC/whM+vo/TLbQo9N6Dx+8byLT3w9V293JFKwGg+Er69eFC+pSd0c0WSSK5Hg3BF8N3IPwrBYGcVFtZ0vI3S0ftyDdIn3RntlJqvnB3a21FR04LPNJuEn6TNLni8viBkVz8arH7mszt5wvuKmWgfrUqTj9ulqzL2QitSbW8eaBdtVYVaoaz/8InH8M1rwitIddMmJx6E8xDiEfjWTNU3fn6SZlcDDXXybuRO0KxiljS+JmEgOOzOU5+Pii6on1VuloSkwMMN77wrjziQv+If8/EFe5+R1TZa3hQqTRC1M49KtT8wFVSlko8SGnfa8LDQtuOLkHJxaK4YHbjEl+bBsAF4UCGcp2ly34xbwCJFhVrYCi8hEsXfgxa9x73RUfIhIGT9acrmUFU4hM5NjjZNEOy6lWbM0jGczNxb/gzRG/pXILIq/jZ24WVMlKDWRLZhH2kH+FtiJKSVTSxq91WKszKm4+mcvIJcgzl1o/MSnf2cBRpW+G5hZkKur2ZRJ2pq8IO5AHX7w5NwP5nsCBXFg+jOIEUjjAnoK3C7bEEpsDRQxyEc4Vp5GOdEtRiAidDr9pBkOVYUu8gk1UiwP0Pg7dr19O9dzL9/8EvdpqcvEN5n5Piybsjd3pFpl1Kl4XfXBjROMJ9RQ1RuV5yqKs7QU27zyTAJP61w5lJCmNEctPVaVT6IhG4fPHD8Q0NJpNyLbgkFQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR02MB7564.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(38070700021)(6133799003)(3023799007)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDN5YklOVHZIS3o2QXNuL1NVMXBiVWtvTUhLWGxRZGlpTXhSek8xQ1QwUkVM?=
 =?utf-8?B?azdBSmJQZDI2ZHlBRlU4UVlsS1hYemN5c0ZGaVRtQlg1QlpadW1VM1JFeTlO?=
 =?utf-8?B?cUphV3ZWRWpreWljc0l2TGpKbnZ6dmtvTmxIeStPd3pUK1g3QmVMaEhLSG03?=
 =?utf-8?B?VmtnWURWVXhqZFJGNHdzQ09WSDY2R0YxdTVZbndqK0QyaWtMVlBkRGFmZ1Bh?=
 =?utf-8?B?cThBdTVlUG9KRHNGeStKL1dHSTdMY1JESjVPUUNIUjdRbGMwZFV2Tmc4NEZE?=
 =?utf-8?B?aCs1SmxOSEZ0N1RNa3VYNUNSMFY5ZlNWeW5DcDFEeUxEcEJvSFRBdWtWelpt?=
 =?utf-8?B?ck1xdmhGTzJJOFVpUC84YVRsOFR0R2FXVHZjM29NQW96OTNtbFdSV3gxQ0FT?=
 =?utf-8?B?aCtpYU1IK24xTVpLZmVISTk0OE5VVm5ZOTA2MGhnM21CU1REcjJHeGIzZHV2?=
 =?utf-8?B?Uy8yZ25OZDFQcG1KdWdFS3Z2QkFrbzM5ZmlFN1YwZnZ0Wmczb01wSlRtSXZK?=
 =?utf-8?B?R3hWYUVmVm1ka1B5UlRlTUdVRVY4eWdaY1NFT0FGTjJUMGJiVnpQK1FscWlH?=
 =?utf-8?B?OW1YV1FGUjZLaThwbU1xeXAwSUVzdzlwM3FsU3NNSEdKMkozS2kzV2dmSFpV?=
 =?utf-8?B?V1ZrWTZabVZVdmd2cU55ZHl5MTdpZkxnOXRaeitNd1ZFL0tYWVU2bDkxUzl3?=
 =?utf-8?B?TTJiR3hBVWNMVlRTMkRuc3V5bUtVRmtoVHN3aFlsMkJlL2o0bm5FeExIekVs?=
 =?utf-8?B?eHVkZWJXNWNUclU5QXVCdjlOZlF4YWhmbjlLMHBSVkl3ZjZkSHdjUUc1QytE?=
 =?utf-8?B?Um93dHdwK2JLV0R1L3dWWnJ2KzUxYzlRVDhsMWtxekFyTFBZRFJmQ2daVGJj?=
 =?utf-8?B?NEovWENmOFlHSS83TFJYSzJmRHhXbTZBZnlEVHBnMVJYS2N1eWt3b0ZIa0JO?=
 =?utf-8?B?SlM5ZWFGTFF6SHBaa3lTcnBFdlBWMkF5di95cEFSOFVvNzFPNTFxNVJFN1dG?=
 =?utf-8?B?My9DRm92ZnhkSmpoMWpZUTJyTkNXSysydU1yZlliNmtDK3lKWFhrRGZGVmVP?=
 =?utf-8?B?R2lmLzNqMWM5R2IzcUxFbDlab0VEbkhma0s3aTY2d3VnMXo2Q1d6OFdjZWV3?=
 =?utf-8?B?K0pUTW5BelVnVWtLa01TSU1CaElLWVl1TDBzVEJaZ055dGFGSS91dU04Qm85?=
 =?utf-8?B?V0VDS0RZSEpUWFhKSnNuSWtIbVM5M1NLaCtvQVdhTlhRZkZtckpzQ3M3UkE2?=
 =?utf-8?B?R2ZEc0dJNEFUTXBtQVdBUU9aUE1QM3g4NWlrN3ZUVi9wcktJM0N6MFJaWlor?=
 =?utf-8?B?OUlWM1ZFVlM3djZBUDd6VklOQlVTT0d3RUx1ekZRRzhmRDEvMWJsWlN2NG1w?=
 =?utf-8?B?OE9PZUVOamx0SlRsU3NyMVFraTZPb1g0QlBqdmtuS0tVVllyelNqRWFzZCtw?=
 =?utf-8?B?ZFZGTk5HeVlNdnYwR2dua1Y2bEtrcExJL2ZXQXBQb3paK2RzcmpRMzlTWjI3?=
 =?utf-8?B?UEFaMnBNQTcwUkFQTUVaMjBVVWFuaEV0SnJsTGU5MENOVnNVR3dPcHJqT05v?=
 =?utf-8?B?dkRNb0l2bjYxdG03eWxNaC9hNkpDdFJWYklydXM2VGtveURaYnMxcUpPQnZT?=
 =?utf-8?B?ckt0SnhKU1UybExPYkkxVzExR2p0aEtYTVJ0Q3plaUtCQkVOV1pGRi9zTUYw?=
 =?utf-8?B?U2hITmNpdXpjNEtaK0o3WDdtaHlOT01lb2xDVmNFV1lWTDJQZmhPM2hWZXBG?=
 =?utf-8?B?S2RoVDgwYmppTGpBQk1KQ1dxdlpFWXh4T1d0a1B5UDZHcXk2UU1weStmZnlW?=
 =?utf-8?B?TXh1L1Y0VVNSaG9VUXV6dkp4RE1wdmFJZ09MZ3JFbjZVRzh4SGtod1ZQRG9F?=
 =?utf-8?B?ZG5wcW8zYmVwRTArRmlwY1Q3bXFiMWdDTCtSRzdNWEcxd2N5TzgyQlBDQnVl?=
 =?utf-8?B?NTV3a2RMN09RZHl1aExMUk92SmtKUCszUUFlV0dwMHNuc1NjdTNEajBmbEox?=
 =?utf-8?B?cjVCbHEzY0xmWGlqSWw1ZTIzZmZaMitPa0hsK1U4UzBKRUxGeVNjM0tmM3kr?=
 =?utf-8?B?TW9yOEJnYWozalZBZzZGdXRrTml3eSt4blhMeHRuZ0MyYXNON0VUcnVvajU0?=
 =?utf-8?B?eTQvZzJVbWFCcmtia3ZZZy9ZNkZVN1UrVTg4VmtsNTdtRU9FRExBOTJ6STFh?=
 =?utf-8?B?N3BWWFJpdGd3RlQvNGkrYW9FaUhvMEdPbmRNMlJxOXdQc3FhYmt2eWRQZFdt?=
 =?utf-8?B?by8wYmdBTHRmS1pSZWU4L2wyREZ0cFpKeEgyaGt2TnpzK0JCZHZkdThqdHFW?=
 =?utf-8?B?Y1RCOVRtOVJMbXlxYkprK0w4MFIzRjl3eHB0bFl1Nkxjck1mSjdkSm45YUZH?=
 =?utf-8?Q?GK6O6DBrdEO1UiV8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2FD73ED47A5954C8DFF19CBEBF85190@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: U/hvlpcBtyxZ4I6VhQ2Ke4fuHh6toFdf0UJrY5wkN85HTpu14+ZbYaXZ6f4UQJWw6JNaeaIoNSCVkIf53/eVISpPZZyppDX0HLMoMIdfaPUM9pazFF5GLmap0wcti9ol6ihh078sXvTxFKnFhX487Mb1kZ2F6Wiq2LAmsMjoByvfB/L/FpsPuc+FSZhf3RHHxmwsh0bM+VJgxcrlJLLVIQjvROVv47Kd4IxA1rBHmPl/baRu42pkPV7qk8yvl0QWCtWJhUIfUKGsJtUURMGjO7AhDpWNRbaOiPyHSzQC7VgIVqzsu/YrggsyW62b3ieAHprqIbiqvsmeFXaMKrPuqw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR02MB7564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3482ef69-8396-4b6e-51cb-08df0caacaa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 06:39:39.3203 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: koJnoxLQpKa4epM0EnsdFxpgS2xn/+A9SN0C8WbFzd5Ws21JFKK3TzkG0XPsANXZmOmdWGYhS/akgZtg2o8okXQdyy8F+COsLfBS1HkiTWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB10962
X-Proofpoint-ORIG-GUID: WekrUyyOOVYjG_GqJXPSfXA-EEj-a8VU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA3MCBTYWx0ZWRfX0oFiOzinLNpk
 s76bbPWjmUTpjTHwxm9qAYxik6mZ6cYgGsLTnqbNp47TAi/vINOaeo4vdUvRv9qiGeof5PCMIiX
 6HDEdfk0k40zUZ6iBEbqzXU2iYsu0mk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA3MCBTYWx0ZWRfX0Xl8ctBD8U6B
 9WCb8zwh8gtgFLYTmdD6az6rOLSzKC9m1Ivs4glbPilJh+8XPpiRT+1fQoFdal5q0CItSwUGjMQ
 5zXfZ70JW58F1eHSIQ9AOJxUdt+dpsQxm8l5UyejfdizP8oBKgOC2y/ojjp4O/0o64cddjPM2D4
 jiSUQO84ogwGasrJykWJpS14mJowSDrPcyOv84xXY13UATV0Rz481jxLdL0Vwlckmca9n2NKuqF
 LFoCVVLC8+IlLp7h2Frczv5v92Mp9p9Uz+lHY6SDOfmHtM6e9NWuSipMgmSGPkUUUQ5I7rw3TBT
 pNT8CW993/nIdDBqfLlZNbIqY7KfJb4mPnl5dHBOEz07fWZH5GGet+cwY1dsnwZ86gEB4IHVcsl
 jd3TWrQM/gr2f1B9uTN8E/9ciZ3rojVN+rm0P8f35rrk7x7QdckEAa4hZ0jggrL6LA70FrVot0s
 3dZ/4/wsn5Ycvut5BqA==
X-Proofpoint-GUID: WekrUyyOOVYjG_GqJXPSfXA-EEj-a8VU
X-Authority-Analysis: v=2.4 cv=M4V97Sws c=1 sm=1 tr=0 ts=6a9e5c2e cx=c_pps
 a=EX0Xkmt19mXnrP5bPG/VDQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8
 a=69wJf7TsAAAA:8 a=mDV3o1hIAAAA:8 a=I880L6_lkoXOpyDk4_8A:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=khushit.shah@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

DQoNCj4gT24gMSBBdWcgMjAyNSwgYXQgMToxN+KAr1BNLCBTaGFtZWVyIEtvbG90aHVtIDxzaGFt
ZWVya29sb3RodW1AZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IEZyb206IFNoYW1lZXIgS29sb3Ro
dW0gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT4NCj4gDQo+IChUaGlzIGlz
IG15IHRoaXJkIGF0dGVtcHQgdG8gc2VuZCB0aGlzIHNlcmllcyB0byBxZW11LWRldmVsIC8gcWVt
dS1hcm0uDQo+IFByZXZpb3VzIGF0dGVtcHRzIGZhaWxlZCB3aXRoIHRoZSBmb2xsb3dpbmcgZXJy
b3JzOg0KPiANCj4gcWVtdS1hcm1Abm9uZ251Lm9yZzogY29ubmVjdCB0byBlZ2dzLmdudS5vcmdb
MjA5LjUxLjE4OC45Ml06MjU6IENvbm5lY3Rpb24gdGltZWQgb3V0ICANCj4gcWVtdS1kZXZlbEBu
b25nbnUub3JnOiBjb25uZWN0IHRvIGVnZ3MuZ251Lm9yZ1syMDkuNTEuMTg4LjkyXToyNTogQ29u
bmVjdGlvbiB0aW1lZCBvdXQgIA0KPiANCj4gSSdtIG5vdCBzdXJlIGlmIHRoZSBpc3N1ZSBpcyBy
ZWxhdGVkIHRvIG15IHNldHVwLCBzbyBJJ20gbm93IHRyeWluZyB0byBzZW5kIHRoZQ0KPiBwYXRj
aGVzIHZpYSBteSBHbWFpbCBhY2NvdW50Lg0KPiANCj4gQXBvbG9naWVzIGlmIHlvdeKAmXZlIGFs
cmVhZHkgcmVjZWl2ZWQgdGhpcyBzZXJpZXMgaW5kaXZpZHVhbGx5LCBhbmQgdGhhbmsgeW91DQo+
IGZvciB5b3VyIHBhdGllbmNlLikNCj4gDQo+IEhpLA0KPiANCj4gT24gQVJNNjQgcGxhdGZvcm1z
LCBtYW55IGVycmF0YSB3b3JrYXJvdW5kcyBhcmUgYmFzZWQgb24gQ1BVIGlkZW50aWZpY2F0aW9u
DQo+IHJlZ2lzdGVycywgcGFydGljdWxhcmx5IE1JRFJfRUwxIGFuZCBSRVZJRFJfRUwxLiBTb21l
IG9mIHRoZXNlIGVycmF0YQ0KPiByZXF1aXJlIGNvcnJlc3BvbmRpbmcgZml4ZXMgaW4gdGhlIGd1
ZXN0IGtlcm5lbCBhcyB3ZWxsLiBUaGlzIGJlY29tZXMgYQ0KPiBjaGFsbGVuZ2UgZHVyaW5nIGd1
ZXN0IG1pZ3JhdGlvbiBiZXR3ZWVuIGhvc3RzIHdpdGggZGlmZmVyZW50IE1JRFIvUkVWSURSDQo+
IHZhbHVlcywgZXZlbiB3aGVuIHRoZSBWTU0gcHJvdmlkZXMgYSBjb21tb24gYmFzZWxpbmUgZmVh
dHVyZSBzZXQgdXNpbmcNCj4gdGhlIHJlY2VudGx5IGludHJvZHVjZWQgd3JpdGFibGUgSUQgcmVn
aXN0ZXIgc3VwcG9ydC4NCj4gDQo+IFRvIGFkZHJlc3MgdGhpcywgdGhlIExpbnV4IGtlcm5lbCBu
b3cgcHJvdmlkZXM6DQo+IA0KPiAtQSBtZWNoYW5pc20gdG8gZXhwb3NlIGltcGxlbWVudGF0aW9u
IENQVSBkYXRhIHRvIGd1ZXN0cyB2aWEgS1ZNDQo+ICBoeXBlcmNhbGxzIFswXToNCj4gDQo+ICBB
Uk1fU01DQ0NfVkVORE9SX0hZUF9LVk1fRElTQ09WRVJfSU1QTF9WRVJfRlVOQ19JRA0KPiAgQVJN
X1NNQ0NDX1ZFTkRPUl9IWVBfS1ZNX0RJU0NPVkVSX0lNUExfQ1BVU19GVU5DX0lEDQo+IA0KPiAt
QSB3YXkgdG8gb3ZlcnJpZGUgaW1wbGVtZW50YXRpb24gSUQgcmVnaXN0ZXJzIChNSURSLCBSRVZJ
RFIsIEFJRFIpLA0KPiAgd2hpY2ggd2VyZSBwcmV2aW91c2x5IHRyZWF0ZWQgYXMgaW52YXJpYW50
IFsxXS4NCj4gDQo+IFdoYXQgdGhpcyBSRkMgZG9lczoNCj4gDQo+IFRoaXMgUkZDIGVuYWJsZXMg
dGhlIHZpcnQgbWFjaGluZSB0byBzcGVjaWZ5IFRhcmdldCBJbXBsZW1lbnRhdGlvbiBDUFVzDQo+
IHZpYSBRRU1VIGNvbW1hbmQtbGluZSwgZXhwb3NpbmcgdGhlbSB0byB0aGUgZ3Vlc3QgdmlhIEtW
TSBoeXBlcmNhbGxzLg0KPiANCj4gRXhhbXBsZSB1c2UgY2FzZSAoaG9zdHMgd2l0aCBkaWZmZXJp
bmcgTUlEUnMpOg0KPiANCj4gLi9xZW11LXN5c3RlbS1hYXJjaDY0IC1tYWNoaW5lIHZpcnQsZ2lj
LXZlcnNpb249MyBcDQo+ICAtZW5hYmxlLWt2bSBcDQo+ICAtYmlvcyBRRU1VX0VGSS5mZCBcDQo+
ICAtbSAxRyAtc21wIGNwdXM9NCxtYXhjcHVzPTQgXA0KPiAgLWNwdSBob3N0IFwNCj4gIC1NIGlt
cGwtY3B1LjAubWlkcj0weDQ4MWZkMDEwLGltcGwtY3B1LjAucmV2aWRyPTAsaW1wbC1jcHUuMC5h
aWRyPTB4NTUxLFwNCj4gICBpbXBsLWNwdS4xLm1pZHI9MHg0ODFmZDAxMSxpbXBsLWNwdS4xLnJl
dmlkcj0wLGltcGwtY3B1LjEuYWlkcj0weDU1MSBcDQo+ICAta2VybmVsIEltYWdlLTYuMTYtcmMy
IFwNCj4gIC1pbml0cmQgcm9vdGZzLWlwZXJmLmNwaW8gXA0KPiAgLWFwcGVuZCAicmRpbml0PWlu
aXQgY29uc29sZT10dHlBTUEwIHJvb3Q9L2Rldi92ZGEgcncgZWFybHljb249cGwwMTEsMHg5MDAw
MDAwIGtwdGk9b2ZmIiBcDQo+ICAtbmV0IG5vbmUgXA0KPiAgLW5vZ3JhcGhpYw0KPiANCj4gSGln
aGxpZ2h0cyBhbmQgTm90ZXM6DQo+IA0KPiAtVGhpcyBpcyBiYXNlZCBvbiBDb25uaWXigJlzIHNl
cmllc1syXSDigJxrdm0vYXJtOiBJbnRyb2R1Y2UgYSBjdXN0b21pemFibGUNCj4gIGFhcmNoNjQg
S1ZNIGhvc3QgbW9kZWzigJ0uDQo+IA0KPiAtQ3VycmVudGx5LCBubyB2YWxpZGF0aW9uIGlzIHBl
cmZvcm1lZCBvbiB1c2VyLXNwZWNpZmllZCBpbXBsZW1lbnRhdGlvbiBDUFUNCj4gIGRhdGEuIEl0
4oCZcyBhc3N1bWVkIHRoYXQgb25lIG9mIHRoZSBlbnRyaWVzIHJlZmxlY3RzIHRoZSBhY3R1YWwg
aG9zdCBDUFUuDQo+ICBJZiBuZWVkZWQsIGEgY2hlY2sgY2FuIGJlIGFkZGVkIHRvIGVuZm9yY2Ug
dGhpcy4gQWxsIG90aGVyIHRhcmdldCBDUFUNCj4gIGRlZmluaXRpb25zIGFyZSB0cmVhdGVkIGFz
IHVzZXItZHJpdmVuIHdpdGggbm8gaW50ZXJuYWwgdmVyaWZpY2F0aW9uLg0KPiANCj4gLUZvciBu
b3csIG9ubHkgdGhlIERJU0NPVkVSX0lNUExfKiBoeXBlcmNhbGxzIGFyZSBzdXBwb3J0ZWQgb24g
dGhlIFFFTVUgc2lkZS4NCj4gIFNlZSBwYXRjaGVzIDEgYW5kIDMgZm9yIGltcGxlbWVudGF0aW9u
IGRldGFpbHMuIFRoZXNlIGFyZSBsb29zZWx5IGluc3BpcmVkDQo+ICBieSBTYWxpbCdzIHZDUFUg
aG90cGx1ZyBzZXJpZXMgcGF0Y2ggaGVyZSBbM10uIFRoaXMgbWF5IHJlcXVpcmUgYSBtb3JlDQo+
ICBnZW5lcmljIGFwcHJvYWNoIGlmIHdlIGhhdmUgdG8gc3VwcG9ydCBvdGhlciBTTUNDQyBoeXBl
ciBjYWxscy4NCj4gDQo+IC1UaGlzIHNlcmllcyB1c2VzIG1hY3JvcyBhbmQgZGVmaW5pdGlvbnMg
ZnJvbSB0aGUga2VybmVsJ3MNCj4gIGluY2x1ZGUvbGludXgvYXJtLXNtY2NjLmguIEkgYW0gbm90
IHN1cmUgd2hldGhlciB0aGVzZSBzaG91bGQgYmUgZHVwbGljYXRlZCANCj4gIGluIFFFTVUgb3Ig
bW92ZWQgdG8gYSBVQVBJIGhlYWRlciBpbiB0aGUga2VybmVsLiBGb3Igbm93IEkgYW0gY2Fycnlp
bmcNCj4gIGl0IGluIHRoZSB0ZXN0IGJyYW5jaCBoZXJlLA0KPiAgaHR0cHM6Ly9naXRodWIuY29t
L2hpc2lsaWNvbi9xZW11L2NvbW1pdC84ZjU4M2M3NmEyYTVmNjBjZjBmOTYxNmQ2MWQwODYzZTUy
NGVmMzg4DQo+IA0KPiBUaGlzIGlzIGxpZ2h0bHkgdGVzdGVkIG9uIEhpU2lsaWNvbiBBUk0gcGxh
dGZvcm1zLiBBIGNvbXBsZXRlIHRlc3QgYnJhbmNoDQo+IGNhbiBiZSBmb3VuZCBoZXJlLA0KPiBo
dHRwczovL2dpdGh1Yi5jb20vaGlzaWxpY29uL3FlbXUvdHJlZS9hcm0tY3B1LW1vZGVsLXJmY3Yz
LXRndC1pbXBsLWNwdS1yZmN2MQ0KPiANCj4gUGxlYXNlIHRha2UgYSBsb29rIGFuZCBsZXQgbWUg
a25vdy4NCj4gDQoNCkhpIFNoYW1lZXIsDQoNClRoYW5rcyBmb3IgcHV0dGluZyB0aGlzIHNlcmll
cyB0b2dldGhlci4gSSBnYXZlIGEgcXVpY2sgbG9vayB0byB0aGUgcGF0Y2hlcyBhbmQgdGhlIG92
ZXJhbGwgYXBwcm9hY2ggbG9va3Mgc29saWQgdG8gbWUuIFdoaWxlIHRoaXMgd29yayBpcyBvcnRo
b2dvbmFsIHRvIHRoZSAibmFtZWQgQ1BVIG1vZGVscyBvbiBBUk02NCIgc2VyaWVzLCBpdCBpcyBh
YnNvbHV0ZWx5IGVzc2VudGlhbCBmb3IgcHJvcGVyIGd1ZXN0IGVycmF0YSBoYW5kbGluZyBkdXJp
bmcgbWlncmF0aW9uLg0KDQpJIGRpZCBub3RpY2UgdGhhdCB0aGUgcGF0Y2hlcyBubyBsb25nZXIg
YXBwbHkgY2xlYW5seSBvbiB0b3Agb2YgRXJpY+KAmXMgdjguIFNpbmNlIEknbSB2ZXJ5IGludGVy
ZXN0ZWQgaW4gc2VlaW5nIHRoaXMgbW92ZSBmb3J3YXJkLCBJIHdvdWxkIGJlIGhhcHB5IHRvIHJl
YmFzZSB0aGlzIG9uIHRvcCBvZiB2OCBmb3IgeW91IGlmIHlvdSdyZSBjdXJyZW50bHkgdGllZCB1
cC4NCg0KTGV0IG1lIGtub3cgaWYgeW91J2QgbGlrZSBtZSB0byBzZW5kIG91dCBhIHJlYmFzZWQg
dmVyc2lvbiENCg0KV2FybSByZWdhcmRzLA0KS2h1c2hpdA0KDQo+IFRoYW5rcywNCj4gU2hhbWVl
cg0KPiANCj4gWzBdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDIyMTE0MDIyOS4x
MjU4OC0xLXNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbS8NCj4gWzFdIGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDIyNTAwNTQwMS42Nzk1MzYtMS1vbGl2ZXIudXB0
b25AbGludXguZGV2Lw0KPiBbMl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8y
MDI1MDQxNDE2Mzg0OS4zMjE4NTctMS1jb2h1Y2tAcmVkaGF0LmNvbS8NCj4gWzNdIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNDA2MTQwMDE1MTAuMjAyOTkxLTEtc2FsaWwu
bWVodGFAaHVhd2VpLmNvbS8NCj4gDQo+IFNoYW1lZXIgS29sb3RodW0gKDQpOg0KPiAgdGFyZ2V0
L2FybS9rdm06IEludHJvZHVjZSBoZWxwZXIgdG8gY2hlY2sgdGFyZ2V0IGltcGwgQ1BVIHN1cHBv
cnQNCj4gIHRhcmdldC9hcm0va3ZtOiBBZGQgUUFQSSBzdHJ1Y3QgQXJtVGFyZ2V0SW1wbENQVQ0K
PiAgdGFyZ2V0L2FybS9rdm06IEhhbmRsZSBLVk0gVGFyZ2V0IEltcCBDUFUgaHlwZXJjYWxscw0K
PiAgaHcvYXJtL3ZpcnQ6IEFkZCBUYXJnZXQgSW1wbGVtZW50YXRpb24gQ1BVIHN1cHBvcnQNCj4g
DQo+IGh3L2FybS92aXJ0LmMgICAgICAgICB8ICA2NiArKysrKysrKysrKysrKysNCj4gaW5jbHVk
ZS9ody9hcm0vdmlydC5oIHwgICAzICsNCj4gcWFwaS9tYWNoaW5lLmpzb24gICAgIHwgIDM0ICsr
KysrKysrDQo+IHRhcmdldC9hcm0va3ZtLmMgICAgICB8IDE4NyArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gdGFyZ2V0L2FybS9rdm1fYXJtLmggIHwgIDIwICsr
KysrDQo+IDUgZmlsZXMgY2hhbmdlZCwgMzEwIGluc2VydGlvbnMoKykNCj4gDQo+IC0tIA0KPiAy
LjM0LjENCj4gDQo+IA0KPiANCg0K

