Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6D6FEE4F2
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 18:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwP5S-0008Ms-O4; Sat, 28 Feb 2026 13:30:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vwP5L-0008M6-61
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 13:30:40 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vwP5I-0004Xn-5i
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 13:30:38 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61SCs8tt2370024; Sat, 28 Feb 2026 10:30:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Wa9JpYLFmygCPF8Dzm9ejuPcYalPuc7Io0nkJYee8
 80=; b=OfJ74F6YUTv2c69R21Yqhzbyi+yMRpyyVNqbX/UsU7LSwumdVPzCxY+Us
 aPToW7Hf6j2J+3Yox1EoOQxIcVVdJanoyzZOaoKfRfBH/TLL1AuqPe7jmWAyWgyO
 ahTw9IYWIPVfmvIOL5uac3Fqg33X2z/C41jJ6pvy8pP24P89XkFvv7di7nqKia1w
 dZ5AUCKYFT8vsbDR92+F8k6vDofHCPbmKkEFN9+UpkFrBAS6uHGLGkKrv1beFtgz
 iSoN2jzvPDZGZjpf7VwjOvX5XLPpNfBEPmuVtDmBuHSno6LI0N7FiRBaKyy3lQtZ
 /LIE3YItCisiJHGsszQE3RLlzcnzA==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020082.outbound.protection.outlook.com
 [40.93.198.82])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4cm0s2gb2r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 28 Feb 2026 10:30:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKYO6ggzn6o/O/8tCWTyHa4F+IrJY4Lnw6eoOfBD1XHxiUWizRe5uH1kz4Br+/V42deGY2CZ0mIQC1DySNOEHWXEPyiTO1/UXqpWQLUBFgSq81gxH//5oIz3wDjaX1xDoLdCN4V/HW0uy9c9HTFS5PCvfEcwIW4DUBHnuDS86zuZpkvthBcGZYcxUdM5uzYiDtHub/Ko3XqgARKuSXMYrpXT0JqyKwyl0xvjCpmeouFw4qV399QTNq/iwYp/jU+p3Vks9UtRfZ6cCds+qQM/E/sbpUkVCL8LbGeyGeovDyTCrd6qAudYdJHuhQBN/f7bR6zo80OnWM0hxEh155l6GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wa9JpYLFmygCPF8Dzm9ejuPcYalPuc7Io0nkJYee880=;
 b=opWk4ZJhRwMiOFC3SNj61yA+PYMq8UD9ILflbGSJlWeSMalEJazBhlLV0xcFEXJ7YtJKpfl12HCZJdb8mcZ1XVGBpDjZd2wsGLdJDaXdMT93QrGQDNJZb0ZHt3r6Ik/xSzLoJgGxfYSAxQOX5WKcszESD0yLPOj2hLX79JbRWDlred52ovJIX0HVe7K2olf3OuHDbaii0SjDH95gPWVMKlJqEd3GXkYZkZ5Vciqqn+Q8FdCcybLHTpv55CnP08SuYzJANBahM5FCD9mC+uQlwawWId5zcj20WpYsioDVecbrp0vZqUmn9QVPMfAneV0UmEgNmOLldrSfuJSdPP9jPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wa9JpYLFmygCPF8Dzm9ejuPcYalPuc7Io0nkJYee880=;
 b=uqr0iT7OZFxcC/1K5XwUlGU0P6TXJNBvh7LP8uzfgcLlQzDYpd3z0M2ypuOfh/LoNiQ7eDnmbhsFeDFIk+mohXnjJumK/8lcHrwTN5extc7kAyqP/nILZuS4u2/0MeZesRNdez9rt/0EeWJXiI7Vj6isLfCAjTvkgipgUkTH3R6asvOT9M1qyNyDDsQt/mSepDzcWljtp4YQWFrOQGvgwaO8/NBXhPOZGwGgSOWtvsnJmshIiWcidQTGyCbNZI+BZHj+UMNlZLHFq0qQdeD1OYF98RXurnWCXfzR27tBy5nf4h4vC8YeqPHKvSWUNMEJij+XmbFEbQbg5lmb/foW9w==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by DS4PR02MB10867.namprd02.prod.outlook.com
 (2603:10b6:8:29d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Sat, 28 Feb
 2026 18:30:30 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%3]) with mapi id 15.20.9654.015; Sat, 28 Feb 2026
 18:30:29 +0000
From: Jon Kohler <jon@nutanix.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "zhao1.liu@intel.com"
 <zhao1.liu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH 0/5] target/i386: introduce ITS_NO to several models
Thread-Topic: [PATCH 0/5] target/i386: introduce ITS_NO to several models
Thread-Index: AQHcTz+GX1Yo9DtugU+G4RvxICHMKbWZIhWA
Date: Sat, 28 Feb 2026 18:30:29 +0000
Message-ID: <11D1B196-54E4-41C1-9E07-7E4926B8CC44@nutanix.com>
References: <20251106174626.49930-1-jon@nutanix.com>
In-Reply-To: <20251106174626.49930-1-jon@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|DS4PR02MB10867:EE_
x-ms-office365-filtering-correlation-id: 720334b4-80fe-43e3-d11e-08de76f77375
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|38070700021; 
x-microsoft-antispam-message-info: 2zHkZqraJ8Q8TrAC68+IHHU3oyp9FhIO/EEH0e3F3CbuTic43f2lDErTHIVlCWe0qj5nyAJK6FQmApBQRqHX8a+ciAIeEWcAipPt54dcIVHngj5dL8y7JAT7kYmTGBrBNal7eGzC3kAnV05W0+FxkrjiQY6i/ab5Fozg1j+QR9KWh7OboI8PLIf/qiQYR3gjhbRb7W711cwW0ZQhyZMFULGRnplQsmdBX72ds3+hm6FeqRCjN4zboilqr9Cj/Y5XHzzBNbNQ3GDumEq384rOqWl5abn6N9I4tF8FqwCve3G63jocq6HuK1kCGkIBdFvm5W4XX0fiJz3zyIIF+PCRtyuGe0JdlUdctHHEcMULHyT/Xgr0LqldOw/g1zjCFw5cdlmzLOV7lK++L2rKwSvgJMnvMhwXE9jmg8zyl3vMV+2kOhkdvaE5702CMrP8i0tTR9J9HhgzitmFQx4LAJWgHIlSxDMJFGF+RMncl8OJaTwKyzi23/fTZ+NOSmmuczldWxXgi1AKtPVjC8JQFrrztoAkbVTaHXmT4CbS5F5rpup/Z8MiZubBy+ES87fPR3rFNGQMoKtl3wxpXIBlZOgTVkaBK8YL3JtRukn8ou8fxEb7snRxIThr4asqhM0K08wHFaL23EQmap5KAFgIqB1x9pFJTAa66dQ4/8dgy2EoBYKMREkkt8/fxl3bnEMPYvgiBYnP93rZoEj6s8hpIdWeGxcgzPAYp5UEEKmZXMGYPmBnf9U0r/vSH9Yh9hsNLKQjGyxLJZdRgu+8SP6d7kOr7caO07kGd+ybDQJ5j00D/E0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV0PR02MB11133.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFdRKzRjai9maEhjT0pIeEpYMjd4ZDR2dGxFMmo2QXF1VTZWbXZnaXc3YUl2?=
 =?utf-8?B?T0JYUjF4clZ1YmR4TCtkTUNyK3ZkMmtWNm95ZWVvRE4zM3FENXZBeURSY2M1?=
 =?utf-8?B?eWRBME5jSkc0UGlNdE04THQ5L2FDU1VBUmtnODBGUTRDaWhqdlVoSFhCdVFM?=
 =?utf-8?B?K1BTZHVzeVVRbDlhUFAxZ2JmNTVDYlNNZTdyN0NoNjArM1ljNVpGcHh1V2dK?=
 =?utf-8?B?eERRd1Y3cCtlVmNrWlFuZHplSzQ3QlBscWxycldUZHZ3SFh1NUR3OXUvYnAy?=
 =?utf-8?B?OXhzSjdKa3lDaTJQVFBaYW5iTjUwNU1SdXBReTluMXNkTnFaYU5uYm96YTRL?=
 =?utf-8?B?TmhPcWY1VUxNVEFyeVhOTnRxd1lYaE5Sd3hYQlkrQmp1cVAwRnZFOUQ1Sngr?=
 =?utf-8?B?TjNUN2NMRCtXbjlzRWVhUnlzMi9nc3Bxa3ZPVHlJMHUyU3VOczlFRFpkVGp1?=
 =?utf-8?B?bVBxakVzaDVVODR3c3FlYkg2VDdMV2g0QzBGTGlGUTNPcS9jUDVLZDg5aWRn?=
 =?utf-8?B?K25Vc1c0VnhLbSs1ekN0TjQvaTY3ekNmN2FKU054SFI2RlYxd1JQOWRlcmJN?=
 =?utf-8?B?QTBhUHAxUWY0QzBNVmdEMGFQYjJ5bWljUzhWN2REcWVMNm9Uc3hCUWNzazQ5?=
 =?utf-8?B?QUtNbVcvNDVXZkJkaU9NQkN4Y3cvU0NtNGhPdC92cGNMREpZeU53UXorakxu?=
 =?utf-8?B?UTVxaExBb2lZY0g2T2NCWEdaWnlib3ZzL09PemQrUmhJUHhybWt1UFdxTU05?=
 =?utf-8?B?Y0VmUUNFeGVlYXIwUmcvNlNTNTc4OXV3TVFpcmpIdVFYbUJQcS9MejdiT0wv?=
 =?utf-8?B?UWk5cityRE5GaTNTN200OVprOE1rcElEdmhOOUVNWGtmVTZTOEpETTREWm1J?=
 =?utf-8?B?QkFMNHJTZUMwa0NkNS9JVU1BeThZODVkT2ZneFZzSG9EYWREMDkyeUt5bVdD?=
 =?utf-8?B?RW41eUtDbE5xVzhIL1VrZ2Z0NmF0RGszU1dYeU0xUmVGZTNDNkJ5ZmhST0Fj?=
 =?utf-8?B?YTUvU28rbVRIdE1rdC9PaXRZWlhxSTdLZTlGS3hQc0RkZFRiVERvSDROVWQ4?=
 =?utf-8?B?aGt0cVpjbWdoUUNVTjRKN1BBYWtrd3RDZlVWQkhFUWhOaGN1WUo2UmZBa3V3?=
 =?utf-8?B?TmFuSy80RkhiSVArWDZyVG9ZbTNET2lZMDJ6OW1VemQweGRSV2YyQ1JpM0Ni?=
 =?utf-8?B?dHg1RDErVFNiRDBRMGtBM3BBcUFPTTZ3VTFvUWdyTUFIaFhtbjBCWThFVVZw?=
 =?utf-8?B?T1U0YW54cG1EMUtrT1VHMWNWcWp1akl1SnZtN3JWTGdNZmYvKythUy9wUVdZ?=
 =?utf-8?B?bERqU2R2UWo2cmdhUHZMSDZMSkF0WkxUeXJHU2lhSlMycjQwRzJnbzZsMElk?=
 =?utf-8?B?TldyLzhOeTRabERLOWdqM3plUFJTS3pCNUl2NjlsV1lDbzAwOTBLVHV1bEtP?=
 =?utf-8?B?RVJBaHRoVDFWWERCamJzU0dhRWZzODloNFZBUFkvblNOR2FWT2VsUWpiTlhS?=
 =?utf-8?B?aTBNMkZubzlGWFNmSFZyVTM0ZHd5Y015WjlNM1MxdmRzS1loeWJhM1VBRGhz?=
 =?utf-8?B?U2ZEckd6bmpjSWt6dUZqWVdZaklWaE1PN0xORzA4bXZ1WGNmZ1cvN3A4RTRl?=
 =?utf-8?B?cW10cS9aak8zSndPVUhySkZNQnNjd3JMcDhmc25mQWpMTGRNVXJuaUNVa0Rq?=
 =?utf-8?B?K0NIUW9Ob2J0Nno2eGhBN2hsTm5CcENpbCt5bUVIK3MxcnlFaWxlVmxIaHFE?=
 =?utf-8?B?ZHBtazlqRXJyNUdBcVVYUGFoUjJPREJIUTczS0t1SmxNSmZMdC90NlEzV1FK?=
 =?utf-8?B?bi8xb0lzZVd2VjVDd0hIUGRSUEpjVnBOUnlCRllaYkJpYlRtQndWN3djbXFp?=
 =?utf-8?B?YS80MFN6b2xsN0NFYXhpMm5RS1JHakZVbGJRZ1lLSXJ6c1VsNDNoTHNRNmlU?=
 =?utf-8?B?cWtLek9yc29zNlh3VmNWckFrSDMra01WcE5yRDArNCtsRXgrV2cwZmNVZzEr?=
 =?utf-8?B?YU5xQ2hzVW9LcUZtbUVaQlNtaHZDNUtWenVZdngvUnBWZ204QlRkSDhGZTVp?=
 =?utf-8?B?SWRnaVJXWlZMOC9GaVB3SjJUdFFBSVZFN2FuVkdoUDdlZVR3ZEd6Nm5JUGhJ?=
 =?utf-8?B?K3hoaWFVcDhrT2MwajllcVlmUUNzVDNlOXZxRUpkOUhwQzl6RGhnc0Fxc2I3?=
 =?utf-8?B?VHprdzhZc2E2KzRpUFRxeXZJV3FaSnZzV1RpOENMb1g2Z3NnS0NRZDRJQ2NR?=
 =?utf-8?B?aVNtU2trNVZ6R0NIbVdqRzdFd0RNd0l3YmI4dWNWaHFTK0tuV2NQc0lwbHhK?=
 =?utf-8?B?MHMrM1FFV3lyYkNvc0NBZzY2S21ZeXpxT3IrdkxMdkJRUkY1bENLUHpzRFIy?=
 =?utf-8?Q?B2lWMeToxc/XOv43e9HovXpRFWS527mFajc0Rjbp/BJ4f?=
x-ms-exchange-antispam-messagedata-1: sdrCN6YYiAGc2h1fF+XisCSYMSHwo8MLOcc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D29ED8EBA604E5479070A22114398D5B@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 720334b4-80fe-43e3-d11e-08de76f77375
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2026 18:30:29.8074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HclY1rv1u9qJjfLNXyUaLw4uQ7S8cc5C8/rxeyQrmsOlis8uKd++Y6f0G24+yTW10y5pxi02Sih054wbeh/onH3Q3jE3maGgkqgL6X6uIvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR02MB10867
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDE3MSBTYWx0ZWRfX+2s6YUDVilhG
 1hQ23M1i7QQ1/KRJdJ4NgI7MXyXMIYX7J7XPRnjMweshrPUV9c94nfbRXBVP480sv+YuHyohpaM
 Y6VFBQEZGOtxSDYXrDlHnkCIIw3X7JSp7SVrkN4pOibyW/6vXR0k9kipg4aVB5SmAXHhYCnTRRS
 78QHXevIp6jTzGUJSAS1JHkmM3MasBjBmLwsHR9ejl+/ts1P2jmWSpBT+fQQYHCQfgt7V3oWElU
 CTGPGY8JVT55uY6zbeEphXIfiC2eVs9YH4mc9T2ZUQEy6/7kk4WmItwS5aYBQkLhTeBfIFjYIh9
 J681yKcKREoQgBBE4qNIOp42Da0FM/zRIPv/42hKuXewt7MPtDw9AiAXszebikcpmCd2wvhVYd2
 gi6Ku5m0w+lUxnG08q7mhmTUccj+NOuuK6Wfc+mJoct+krcfdmSHJ1ulLsmLLXqBxn11UQRiAnZ
 qRQqY5fk0Ek77sceYdg==
X-Authority-Analysis: v=2.4 cv=ba9mkePB c=1 sm=1 tr=0 ts=69a33447 cx=c_pps
 a=lntwMuBcOMWYP1oWCx7eiA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22 a=64Cc0HZtAAAA:8
 a=-5NOEemT65ZlYzVX24sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: bU9PX0DoGzDHN5rRWsR7My6Kuw4-8tDC
X-Proofpoint-GUID: bU9PX0DoGzDHN5rRWsR7My6Kuw4-8tDC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_06,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=jon@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

DQoNCj4gT24gTm92IDYsIDIwMjUsIGF0IDEyOjQ24oCvUE0sIEpvbiBLb2hsZXIgPGpvbkBudXRh
bml4LmNvbT4gd3JvdGU6DQo+IA0KPiBJVFNfTk8gaXMgYSBzeW50aGV0aWMgYml0IHRoYXQgaW5k
aWNhdGVzIHRvIGEgZ3Vlc3QgVk0gdGhhdCBpdCBpcw0KPiBydW5uaW5nIG9uIGhhcmR3YXJlIHRo
YXQgQSkgaXMgbm90IHZ1bG5lcmFibGUgdG8gSVRTIHZ1bG5lcmFiaWxpdHkgYW5kDQo+IEIpIHdp
bGwgbm90IGJlIG1pZ3JhdGVkIHRvIGEgaG9zdCB0aGF0IGlzIHZ1bG5lcmFibGUgdG8gSVRTLg0K
PiANCj4gR3Vlc3RzIHdpbGwgdXNlIElUU19OTyB0byBvcHQgb3V0IG9mIG1pdGlnYXRpbmcgYWdh
aW5zdCBJVFMuDQo+IA0KPiBJbnRlbCBTYXBwaGlyZSBSYXBpZHMgYW5kIGhpZ2hlciBhcmUgYWxs
IGludnVsbmVyYWJsZSB0byBJVFMuDQo+IA0KPiBOb3RlOiBmb3IgcG9zdGVyaXR5LCBhZGQgTVNS
X0FSQ0hfQ0FQX0lUU19OTyBiaXQgZGVmaW5pdGlvbiwgc3VjaCB0aGF0DQo+IGZ1dHVyZSBDUFUg
bW9kZWxzIGNhbiBhZGQgSVRTX05PIHdpdGhvdXQgbmVlZGluZyBhIHN1YiB2ZXJzaW9uIGZvcg0K
PiBpdHMtbm8uDQo+IA0KPiBKb24gS29obGVyICg1KToNCj4gIHRhcmdldC9pMzg2OiBBZGQgTVNS
X0lBMzJfQVJDSF9DQVBBQklMSVRJRVMgSVRTX05PDQo+ICB0YXJnZXQvaTM4NjogaW50cm9kdWNl
IFNhcHBoaXJlUmFwaWRzLXY1IHRvIGV4cG9zZSBJVFNfTk8NCj4gIHRhcmdldC9pMzg2OiBpbnRy
b2R1Y2UgR3Jhbml0ZVJhcGlkcy12NCB0byBleHBvc2UgSVRTX05PDQo+ICB0YXJnZXQvaTM4Njog
aW50cm9kdWNlIFNpZXJyYUZvcmVzdC12NCB0byBleHBvc2UgSVRTX05PDQo+ICB0YXJnZXQvaTM4
NjogaW50cm9kdWNlIENsZWFyd2F0ZXJGb3Jlc3QtdjIgdG8gZXhwb3NlIElUU19OTw0KPiANCj4g
dGFyZ2V0L2kzODYvY3B1LmMgfCAzNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiB0YXJnZXQvaTM4Ni9jcHUuaCB8ICAxICsNCj4gMiBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNl
cnRpb25zKCspDQo+IA0KPiAtLSANCj4gMi40My4wDQoNCkdlbnRsZSBwaW5nIG9uIHRoaXMgc2Vy
aWVzLCBhbnkgZmVlZGJhY2s/

