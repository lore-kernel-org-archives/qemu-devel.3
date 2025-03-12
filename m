Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA3BC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 19:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsRTD-0003Ro-Dt; Wed, 12 Mar 2025 15:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1tsRTC-0003RI-4g
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:10:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1tsRTA-0008Qx-6G
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:10:21 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C9oB8P017697;
 Wed, 12 Mar 2025 19:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bxx3nTNRF/IaKT9Gf2fke1XxHxO2xWzrha8iGW5ZTo8=; b=BncO/7Cyo7Z8Wm7r
 m+4UtxzJuOm92wq4vrHJ/VFkKWtDMF6IRuI/bzmSpRAlALso0ZN9KpKiS4Bk5Pi0
 ai2uhyVWvx5hoE97WxgAwLyhtzScwvlB20hZtXy0Ifj1jwuuijn1l2JhBZw4mU/c
 wWOSUnJ9cnsBOdpFibYRm6rQBoj5pWGcLy67/W3W+dK16psr03Dm3ZedqQz+ThxG
 M8osxoN1gizQPdmmdgk9Oc6muxasORV7SH8sZOx9evT8+wOYQ9nlUjuyq2Rltwdy
 tfodJf/EGNuYHcT2N39SYcfaioz+Ol4YG78hOFS9HYys2Mwb+EwsNb1Q685WfVV9
 wN3pfQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazlp17010005.outbound.protection.outlook.com [40.93.13.5])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au50bdp5-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Mar 2025 19:10:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NaR6RyZ0r9WeX9eOtrwMa3KvyjJmow+yTNECE53azGyTbicwFDPgS7mUfkMyw0EOC9qVOuMHgN4zUgGy0KTs81AnB9VbQB8Hr7thr89fi5uC6VahuK5sRkRTiwqGOUh+uHCT7WL8CHoVBcTj15UPhNcPCjidOKn4ZxY2OkQcheynqkB6DhoFpT/SlJM/FiXtEISlC5jL00XqKw8L3t+x2PdlutzujWsGdfBQDAh/W6RhB2lDF6iCs/CvQ1Q0DSInjC5y7f4NNcJoPhoxCW4fVSix7aw/QxLLMVw5g9swWnZ+lXyi5o9Ys+i65kH1i0jwiZ6FbVTTyVuSSAUSY6dYrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxx3nTNRF/IaKT9Gf2fke1XxHxO2xWzrha8iGW5ZTo8=;
 b=b6WN51WVNec+fOiCDVr46BTCGpM8CsvUosnct3ZWPc+4SZplkyBoqkkx+uUYBU/oVQB374rVYdrChoQOKpx2i7NJT+mA84Fy7Xuuc8gMW0jD7ar7UIfvt+za3iYg0v25RQcsWJviD4nt1xvcrIMYvpMYN7YwiVlisKIVCiOCEawyfbdIheKggkS0fQ952V/JXHc7jHgh9UGqrcbbTAM/yho60mIzQEEc9qzTeE2hTbHsEx3wsh01HqqrW59Utrr/ddPIGGFGCQ6Duvf599K6csPTBpAl0HQGiPk3904m3e0f4YiTYi6G0uQlnRkiPz3uwCnTgEqX1nemLfGyy+j8YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DS0PR02MB9482.namprd02.prod.outlook.com (2603:10b6:8:df::12) by
 BN0PR02MB7887.namprd02.prod.outlook.com (2603:10b6:408:14b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 19:10:11 +0000
Received: from DS0PR02MB9482.namprd02.prod.outlook.com
 ([fe80::4f22:877d:522e:dfc8]) by DS0PR02MB9482.namprd02.prod.outlook.com
 ([fe80::4f22:877d:522e:dfc8%3]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 19:10:11 +0000
From: Sid Manning <sidneym@quicinc.com>
To: "ltaylorsimpson@gmail.com" <ltaylorsimpson@gmail.com>, 'Brian Cain'
 <brian.cain@oss.qualcomm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "Matheus Bernardino (QUIC)"
 <quic_mathbern@quicinc.com>, "ale@rev.ng" <ale@rev.ng>, "anjo@rev.ng"
 <anjo@rev.ng>, "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "Mark Burton (QUIC)"
 <quic_mburton@quicinc.com>, Brian Cain <bcain@quicinc.com>
Subject: RE: [PATCH 33/38] target/hexagon: Add gdb support for sys regs
Thread-Topic: [PATCH 33/38] target/hexagon: Add gdb support for sys regs
Thread-Index: AQHbimqrbpmX50Eku0uSh01oDbQEebNvwl0AgAATOCA=
Date: Wed, 12 Mar 2025 19:10:10 +0000
Message-ID: <DS0PR02MB948274C6E2B3E4F72B5DF79ABED02@DS0PR02MB9482.namprd02.prod.outlook.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-34-brian.cain@oss.qualcomm.com>
 <010a01db936b$9a862d30$cf928790$@gmail.com>
In-Reply-To: <010a01db936b$9a862d30$cf928790$@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR02MB9482:EE_|BN0PR02MB7887:EE_
x-ms-office365-filtering-correlation-id: 4aeccb59-d5f7-4fd3-62fa-08dd619982e6
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?QTkvQ3NvNlVrSmVHTUk5MTUzZU50Y2dnazFxMUFIUFNpeDlSeE9hWDZnOVBX?=
 =?utf-8?B?dEJTcFZsclNUREsrWEFXSUhTT2JlaC9ENmhzaFZkNDFQY2FMQW1qTnRMVkc3?=
 =?utf-8?B?L2gwTEEvdm5hNVQ3bk5LWm9VRnNEN0VJMFRENVhWUFpuZzJ5b0sxMWFNNEFH?=
 =?utf-8?B?ODl0L1psdklKTktHQ0hnbVNzTVNYKzNhR2R1azVoVWs0b2hudkhvbTdROStt?=
 =?utf-8?B?Z0tjck5Rd2IxbmErUS8weWpRS3lNVXdyUzdYVVgxMTNFZDhzTEZpaWxIbHhU?=
 =?utf-8?B?d2FSc0xUR1hLZXMxOTl0TVgyUU9XQjdnTEVteGd3S3Y0WUtsaUdpVzZlempI?=
 =?utf-8?B?TGZDdGJTUWU3VXFYOWFCWGFCNkgzNzE2M2M4WkFhQVVTa21JM2VLcVgwMTBK?=
 =?utf-8?B?ZG14Ym9KOG9lcmo0d0lQUkVuSWdack9EcmJqa3lldmwwOGRPMWZjR3kyRkd1?=
 =?utf-8?B?NGx0U0lzeERtZXBoNm1nS2lIeFlJeTFzKzg2aHJ2YTdma0JTaHVvM0VFYmNO?=
 =?utf-8?B?Mm1ZUGVmNExQRzFuWlFqSWY3TTZZOFNTRlpFQS9QRDVreDJITlV5akIrQnNV?=
 =?utf-8?B?Nll4N01IaElYYXkveGNJdCtTZjVJalpCenNRd0FReU5mRnhiOTlOVWdSTlFM?=
 =?utf-8?B?UDFkUE45NmtCckVWZEEvVTZpOXFCc3VtRXQyRnY3WlJOVURjbXpjdlZwdFBJ?=
 =?utf-8?B?b09EbG4va1lqQjN6KzBmNzNMSTZvMUR1OHJZSGVOekR2NVlReTMyUWpUWFlQ?=
 =?utf-8?B?cWZ0eU14eS9kQzVLOXB6ZDQzQS9JVms5M2J6d1FhclhEQVY0WTArY2FuU1Nr?=
 =?utf-8?B?eWU1YnBJWnRYT2lBWU9xN2dpemhBa2UwT0JWSnhHaGlxVFRsc0R2bWZ1SVUw?=
 =?utf-8?B?NU5vcTQxaU1KQXIwNUxyVmxJUC9id2tVVzUwU2JqT3N4cCs3ajBZTmhZZ3Nw?=
 =?utf-8?B?b0pPVk96YVhsRjl1QmJTcTdabW54L1FHS2NoNnI4MU9tMGJxTGpsazNIdi85?=
 =?utf-8?B?MFpWczU2cXhUeDBNVGJIYklBY0N6Mk1tc0FPK3o1cnNiWTRlQnlKbitEc2dr?=
 =?utf-8?B?SlNyMHVZdDhqNmJKUCs5UTJGWEdldTM4MXhuRnkrdmhrNllhS0tlUG0xYjU0?=
 =?utf-8?B?ZUVoQnRBTkhncTRGWWc0aDZYY2JNcGhPMENBRk9JRU00UXltQk9mMXdVL2sx?=
 =?utf-8?B?QXM0SkZaZytRMWFVUWpaV1prcHQ1ODhkbFRXcC91UnJZNG9VM0VvanZTeEN0?=
 =?utf-8?B?bFlzVGRBWnk5ZjBzeDFoNTIrTGNCR2ErcVdXbWppRnlzTFhSWmt4WG1lT2xR?=
 =?utf-8?B?NkpBbFBnZm94Wk1NOXVRQ3lDcWYvR3ErQzltQ0lORldvdGJvRzBIN2c4a0lY?=
 =?utf-8?B?RkFOcytUQmFRd1cwKytxVE5SdWppSm0rL0dneVlXVk9jd0tQSll0bWVrbEt0?=
 =?utf-8?B?dklFemoyajhaLzdOdG1nREx1d2NPSlYrV09ZUXFYOGJOZVZjMkpNUm9HNWV3?=
 =?utf-8?B?MktVRDNURmYreVRJY1EyR2p1d05HVXNOcWtvT1gzNzl2Z3BNQkMyaXZHczh6?=
 =?utf-8?B?RUNxaUJyZk1RVHlzYStBbitTVWh4YUlzNGtLNXRsb0RxdWRzUkRLRHNQdjZt?=
 =?utf-8?B?TFV1cW9QajBGNVNOM2cxaGplS1NtbTN0enNaS3BRZG9OSE9FYm1OclRIanMy?=
 =?utf-8?B?MG43NHQ3N3VJQXJyTmhpei8vSndIVTczZjQrZUwyaitzTW4zMEEwR3Z3NmF6?=
 =?utf-8?B?RHJQQnU0bld4MERudklSb0Z1L2tSSWRYdmRTdzZ2Z3FYcGVia2FmT2tHcG42?=
 =?utf-8?B?TU9WdG9WQllMZXJmRTQvb0V3ajNsTWlsTmF1WTVrdEs4Unc4alVQOGVEWTZY?=
 =?utf-8?B?ZkIwbzh3eWVvR0ZwZEMvUVBzWTZSMk5CeEFFKzhHbjJoSU95TFloV2QxSU5u?=
 =?utf-8?Q?3ftZhLZaVY9AvayPnezbUfV+KztCFGEi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR02MB9482.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czJCU0FxRUVCM1lHRmQvOWc0dmx1QVh1eUJxQXo5dlhSQWF6bTlveGZhaVZH?=
 =?utf-8?B?SHBOVHMwYk55RG1yZnVCL0U4cS9idnVHZy9nUmxUb0tuOU9rRXlkOUdPem0r?=
 =?utf-8?B?TTEvYW5UakVpQ0FiUGlTSFZjSVBKTnNnUjJHMk1JQXRpQjFZOVh4UmdHK2xx?=
 =?utf-8?B?cm0xbnpLYlpQMlAzeEFBRWl4djhFUGhRV0lkZ1hYd3UzVkZzc1lMZHhzZ1ph?=
 =?utf-8?B?WnlJYXRTc3I5R2xrSEk2WngzSUFxN3QrZk9Pd3Z1S3crRVhUakg2cm9FVFVu?=
 =?utf-8?B?VUlzNWRMVFRrV0JIaGtnWHdZQU0xVGdnNzNORW5JZlpkOCt2akRjOG16YU1p?=
 =?utf-8?B?cDBJYzZNUlV5d21jSjhGcnhhYzA2TEMyMkFYdkprTlRmRXkvdU5pQkphbFho?=
 =?utf-8?B?dEIrMEYyNmpKVUxKWXJxendFcUM1a2JUSDIxSmVNVmZCOTg1UVljQmZSV1Jv?=
 =?utf-8?B?eWhNV3V1YysrSVJwTHJMZGVleFFheERCUGgvbTVISWozUytuYWY1Mkg2aVRD?=
 =?utf-8?B?L3dOTm9mbjdZUFJDOWh5YnFIRjVsN0lsTlFjZXVpZGF2WjFoYitPaWgwQmdY?=
 =?utf-8?B?VDBleGZCeTlZeU5Xa294QVFNOUFaeFJZNmFTbzVCbTY3THlLQWFBL3M1Zm8x?=
 =?utf-8?B?QXg5NHB1QlVtbENLMEhNNE9PMmxtcHZyVURxVlNnM0ZDNVUrb2pLWDZzdXRr?=
 =?utf-8?B?eU9ZZ2podGN1dHd2VTRNZU44VkJ4dWNhb0NwS3J5eGVQaHhNbHdjRkhtdEVm?=
 =?utf-8?B?MHlpNCszbWFabWNlMERWaGlxRTlFUWN6TitDV3lZV0Q3N3A4UlhWSk5MVVZD?=
 =?utf-8?B?ZHpMSGVmVzRwazkrQ3JjZ3ZublhXaGJuSTl4cmJVSkV4SWJ3S1JEdUM4amtl?=
 =?utf-8?B?MVV5NVdNL3FZNFlQclhBYnF1MTdiWUFWTFN4eHRiVVc5R3NTQTBUMGo4dkFj?=
 =?utf-8?B?azhKMkZUQzNISmREcHRNMWhqeGUzU2paUStwdGlOc1JCMUQwODlSMUpRdzIw?=
 =?utf-8?B?WlpUWCtHLzUvazJnRzVmdy9iOGRkL0laMDM0R2hWVlVjQmp2K3JONG1LbGQw?=
 =?utf-8?B?T0QxNHVKOFUyTzNnV2ZMeUdxTlFWbGJSOGM3b1BUQnVxM0VOZStIeVg2dzlK?=
 =?utf-8?B?NGRGb1FzVDBBTHk0c1pYQkt0R0dQeEFXWkRGM1VJWkwvL2lMTEhNc3Y5VnlN?=
 =?utf-8?B?d3Qvd1Y4c3c4NTBFM2FWVDZ2cWZWZFM5ZEJ5MjdwMTY0a2Uvd2tYWjdyREFk?=
 =?utf-8?B?NWRRWTErRmtjSjdQWUkxcGllSGRGbVRnL1FIRW4vdERZTm9ZQjY1Nzhxeldm?=
 =?utf-8?B?c0JGdzNQejk1UU5TZVgyVi82WDBNcnJGcmh1bmlzaHVFU2NISnZRb2dDVDVz?=
 =?utf-8?B?S0dGQkpESTdNeTg3SXhEcXhPWWdaTmhLeXJYSFJJRFl2U2NCbEJkQ1FlVTI0?=
 =?utf-8?B?bzYyTk5SR2pEWlRZOHR4dkQ3cFJaRU1jV1NKZ0lZMlFVU2lYS1pIY3VudWVC?=
 =?utf-8?B?VnBpMGRCRGx2Q0wxNUZXb2gvc2pxb0hwVU9sd0tXZjVkQVVPZWVxMmVHbVlD?=
 =?utf-8?B?akpsd1ladDBzSEJrVE1USU4rRjJ6eVhwemVlOTYrZ3RESTVDdG9zclo4WHBt?=
 =?utf-8?B?UlFXMDNYdSsrRWkrUGdyV2VtUnpkL3FyWGJlTkY0SVJDbE9HekIveWg4ZHdV?=
 =?utf-8?B?a2ljM1FqYnIxODdmM0lLOGZJQTl4bm9jd254dDFBUEVTTGR4dWU0a0JmUU95?=
 =?utf-8?B?dUpMb3dtMytkeFUrVCtjdG9jS3FxWGdFZitZdk10RncxeG5WaUJSc0NIcWpY?=
 =?utf-8?B?bTl3UDEyM2d2L21nckZvMWZWNXgzVUdBMjRKTk5PREUzZk5sZ255T0d4Y2kv?=
 =?utf-8?B?bVlybjZjUnpiU2ZNdzlzK0RYQ0RGMzFvZldYdzJkdGVKV1RaaDBXNGxPTFBl?=
 =?utf-8?B?U21PTDRMMEpBV0tGUWZLTW9sUjhJWFRDMjdCK05rZ3dCYW9iMUZRMkZTamd2?=
 =?utf-8?B?RmpFb3RKZVRlZ2p4cm15UG9RYVZ6dmNjYUcvaFdDU1dBMTc4Y2ltTUVhTmRm?=
 =?utf-8?B?MFBzazFEUXdnZjlQZEZNRHIrVFNybFZBN3hpbVh6M1RpMXUzOXlZblpHYU5G?=
 =?utf-8?Q?URt5ndfKDE8WeaA3vy9CsWAvX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WryNlnhoAD1iAt6FzyAyv5LLA9UjKNyVlDezmNPfqcQHsYWWlRKcthzgNwQZdfUzO1idDYCJzTcVlblqcATQHwnoZA2S7hgDzqVZ1X96W0AjlX3mwp7K/lGurJntstWIEVF7YJHxQq7XXqulPBYneM8JIypcKvob7K3rTXKwwN3SNONc57NM+24QG4ZdpoaasxggFGSWLHk2Qx4hbUZ/Cs4e3dUHgX3HGTYbmeyr9LXGSaU233ner+mGPTghMD/sRj8mDTj2dnBrJIsGcSqjZyFlL8JOBUptuX96d4R8H5/WtmntURqMFzvy1HWMZpjULZdp4AdNVdZfDXUDgtEHK5h7E9o6PWAO2VxiMVGt6HxpLr4OWjg+uo4lxihoDL0DW5H7qCBmYL4oT17siAOju0llAnE16eqTB3SfUeOPu0LuooWi5LuXblO53NRLdHo2/FqsLPnN6hJz+zjHorxG6ZvF6cCZxR0PIa1zIDJBZqHgayLa8MQx8cgOL6Mfp49YcGi0AWto2PryUKMw0xmmdRRO2i5xmA9xEXO+mbbJrzjeuUVrpN66x33k2Eweexl/h1apHrDdKlGXLEDg9ZzL74WFK/3L/wzowd7OA0yVNKD8M7igfc/+Uiil0H0jmcOy
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR02MB9482.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aeccb59-d5f7-4fd3-62fa-08dd619982e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 19:10:11.0361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SOIcCmNjCBff/9nI9SP+4Kfr+6fT6rQuZ+YDXEPopJ3SmyPw16u2EqnB5xJjjB0SkAe4E3wgpKtLkqcIIK0KxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7887
X-Proofpoint-GUID: HSTCY8mdip2K-3uaOxlIb93NqP-RXtgL
X-Proofpoint-ORIG-GUID: HSTCY8mdip2K-3uaOxlIb93NqP-RXtgL
X-Authority-Analysis: v=2.4 cv=a4ow9VSF c=1 sm=1 tr=0 ts=67d1dc19 cx=c_pps
 a=ga136hzsjl6Lb4dqulp3IQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=_GVtNWtrMzBnZeedDpsA:9
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=536
 clxscore=1015 spamscore=0 malwarescore=0 impostorscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120133
Received-SPF: pass client-ip=205.220.180.131; envelope-from=sidneym@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbHRheWxvcnNpbXBzb25A
Z21haWwuY29tIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwg
TWFyY2ggMTIsIDIwMjUgMTE6MjcgQU0NCj4gVG86ICdCcmlhbiBDYWluJyA8YnJpYW4uY2FpbkBv
c3MucXVhbGNvbW0uY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiByaWNoYXJkLmhl
bmRlcnNvbkBsaW5hcm8ub3JnOyBwaGlsbWRAbGluYXJvLm9yZzsgTWF0aGV1cyBCZXJuYXJkaW5v
DQo+IChRVUlDKSA8cXVpY19tYXRoYmVybkBxdWljaW5jLmNvbT47IGFsZUByZXYubmc7IGFuam9A
cmV2Lm5nOyBNYXJjbw0KPiBMaWViZWwgKFFVSUMpIDxxdWljX21saWViZWxAcXVpY2luYy5jb20+
OyBhbGV4LmJlbm5lZUBsaW5hcm8ub3JnOyBNYXJrDQo+IEJ1cnRvbiAoUVVJQykgPHF1aWNfbWJ1
cnRvbkBxdWljaW5jLmNvbT47IFNpZCBNYW5uaW5nDQo+IDxzaWRuZXltQHF1aWNpbmMuY29tPjsg
QnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMzMv
MzhdIHRhcmdldC9oZXhhZ29uOiBBZGQgZ2RiIHN1cHBvcnQgZm9yIHN5cyByZWdzDQo+IA0KPiBX
QVJOSU5HOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIFF1YWxjb21tLiBQ
bGVhc2UgYmUgd2FyeQ0KPiBvZiBhbnkgbGlua3Mgb3IgYXR0YWNobWVudHMsIGFuZCBkbyBub3Qg
ZW5hYmxlIG1hY3Jvcy4NCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBG
cm9tOiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+DQo+ID4gU2VudDog
RnJpZGF5LCBGZWJydWFyeSAyOCwgMjAyNSAxMToyNiBQTQ0KPiA+IFRvOiBxZW11LWRldmVsQG5v
bmdudS5vcmcNCj4gPiBDYzogYnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tOyByaWNoYXJkLmhl
bmRlcnNvbkBsaW5hcm8ub3JnOw0KPiA+IHBoaWxtZEBsaW5hcm8ub3JnOyBxdWljX21hdGhiZXJu
QHF1aWNpbmMuY29tOyBhbGVAcmV2Lm5nOw0KPiBhbmpvQHJldi5uZzsNCj4gPiBxdWljX21saWVi
ZWxAcXVpY2luYy5jb207IGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbTsNCj4gPiBhbGV4LmJlbm5l
ZUBsaW5hcm8ub3JnOyBxdWljX21idXJ0b25AcXVpY2luYy5jb207DQo+IHNpZG5leW1AcXVpY2lu
Yy5jb207DQo+ID4gQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQo+ID4gU3ViamVjdDog
W1BBVENIIDMzLzM4XSB0YXJnZXQvaGV4YWdvbjogQWRkIGdkYiBzdXBwb3J0IGZvciBzeXMgcmVn
cw0KPiA+DQo+ID4gRnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQo+ID4NCj4g
PiBDby1hdXRob3JlZC1ieTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8NCj4gPHF1aWNfbWF0
aGJlcm5AcXVpY2luYy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4u
Y2FpbkBvc3MucXVhbGNvbW0uY29tPg0KPiANCj4gDQo+ID4gK2ludCBoZXhhZ29uX3N5c19nZGJf
d3JpdGVfcmVnaXN0ZXIoQ1BVU3RhdGUgKmNzLCB1aW50OF90ICptZW1fYnVmLA0KPiA+ICtpbnQN
Cj4gPiArbikgew0KPiA+ICsgICAgQ1BVSGV4YWdvblN0YXRlICplbnYgPSBjcHVfZW52KGNzKTsN
Cj4gPiArDQo+ID4gKyAgICBpZiAobiA8IE5VTV9TUkVHUykgew0KPiA+ICsgICAgICAgIGhleGFn
b25fZ2RiX3NyZWdfd3JpdGUoZW52LCBuLCBsZHR1bF9wKG1lbV9idWYpKTsNCj4gPiArICAgICAg
ICByZXR1cm4gc2l6ZW9mKHRhcmdldF91bG9uZyk7DQo+ID4gKyAgICB9DQo+ID4gKyAgICBuIC09
IE5VTV9TUkVHUzsNCj4gPiArDQo+ID4gKyAgICBpZiAobiA8IE5VTV9HUkVHUykgew0KPiA+ICsg
ICAgICAgIHJldHVybiBlbnYtPmdyZWdbbl0gPSBsZHR1bF9wKG1lbV9idWYpOw0KPiANCj4gQXJl
IGFsbCBvZiB0aGVzZSB3cml0YWJsZSBkaXJlY3RseSB3aXRob3V0IGFueSBjaGVja3M/DQpbU2lk
IE1hbm5pbmddIA0KSSBjaGVja2VkIHRoZSBpc2V0IGFuZCBhbGwgZ3Vlc3QgcmVnaXN0ZXJzIGhh
dmUgUkVBRC9XUklURSBwZXJtaXNzaW9ucy4NCg0KPiANCj4gPiArICAgIH0NCj4gPiArICAgIG4g
LT0gTlVNX0dSRUdTOw0KPiA+ICsNCj4gPiArICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7DQo+
ID4gK30NCj4gPiArI2VuZGlmDQo+ID4gIHN0YXRpYyBpbnQgZ2RiX2dldF92cmVnKENQVUhleGFn
b25TdGF0ZSAqZW52LCBHQnl0ZUFycmF5ICptZW1fYnVmLA0KPiA+IGludA0KPiA+IG4pICB7DQo+
ID4gICAgICBpbnQgdG90YWwgPSAwOw0KPiA+IGRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9v
cF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jDQo+ID4gaW5kZXggNzZiMjQ3
NWQ4OC4uZmQ5Y2FhZmVmYyAxMDA2NDQNCj4gPiAtLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxw
ZXIuYw0KPiA+ICsrKyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jDQo+ID4gQEAgLTE0NjUs
NiArMTQ2NSwxNyBAQCB2b2lkIEhFTFBFUihzcmVnX3dyaXRlKShDUFVIZXhhZ29uU3RhdGUNCj4g
KmVudiwNCj4gPiB1aW50MzJfdCByZWcsIHVpbnQzMl90IHZhbCkNCj4gPiAgICAgIHNyZWdfd3Jp
dGUoZW52LCByZWcsIHZhbCk7DQo+ID4gIH0NCj4gPg0KPiA+ICt2b2lkIGhleGFnb25fZ2RiX3Ny
ZWdfd3JpdGUoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZywNCj4gPiArdWludDMy
X3QgdmFsKSB7DQo+ID4gKyAgICBCUUxfTE9DS19HVUFSRCgpOw0KPiA+ICsgICAgc3JlZ193cml0
ZShlbnYsIHJlZywgdmFsKTsNCj4gPiArICAgIC8qDQo+ID4gKyAgICAgKiBUaGUgYWJvdmUgaXMg
bmVlZGVkIHRvIHJ1biBzcGVjaWFsIGxvZ2ljIGZvciByZWdzIGxpa2Ugc3lzY2ZnLCBidXQgaXQN
Cj4gPiArICAgICAqIHdvbid0IHNldCByZWFkLW9ubHkgYml0cy4gVGhpcyB3aWxsOg0KPiA+ICsg
ICAgICovDQo+ID4gKyAgICBhcmNoX3NldF9zeXN0ZW1fcmVnKGVudiwgcmVnLCB2YWwpOyB9DQo+
IA0KPiBEb2VzIHRoZSBoYXJkd2FyZSBhbGxvdyB0aGUgZGVidWdnZXIgdG8gZG8gdGhpcz8NCltT
aWQgTWFubmluZ10gDQpPbiBoYXJkd2FyZSwgaWYgd2UgYXJlIHRhbGtpbmcgYWJvdXQgVDMyLCBz
b21ldGhpbmcgbGlrZSAici5zIHN5c2NmZyAmeHh4IiBjYW4gYmUgZG9uZSwgYnV0IEkgdGhpbmsg
dGhpcyB3b3VsZCBpbnZvbHZlIGluc3RydWN0aW9uIHN0dWZmaW5nIHRvIHVwZGF0ZSB0aGUgcmVn
aXN0ZXIuDQpJZiB3ZSBhcmUgcnVubmluZyBMaW51eCwgc3lzdGVtIHJlZ2lzdGVycyB3b3VsZCBu
b3QgYmUgZXhwb3NlZCBpbiB0aGUgdGhyZWFkJ3MgY29udGV4dCBhbmQgSSB0aGluayB0aGUgZGVi
dWdnZXIncyBrbm93bGVkZ2Ugd291bGQgYmUgbGltaXRlZCB0byBqdXN0IHRob3NlIHJlZ2lzdGVy
cy4NClRoaXMgYmVoYXZpb3IgbWF0Y2hlcyB0aGUgbGVnYWN5IHNpbXVsYXRvciwgaGV4YWdvbi1z
aW0uDQoNCg0KPiANCj4gPiArDQo+ID4gIHZvaWQgSEVMUEVSKHNyZWdfd3JpdGVfcGFpcikoQ1BV
SGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZywNCj4gPiB1aW50NjRfdCB2YWwpICB7DQo+
ID4gICAgICBCUUxfTE9DS19HVUFSRCgpOw0KPiA+IEBAIC0xNTA4LDYgKzE1MTksMTEgQEAgdWlu
dDMyX3QgSEVMUEVSKHNyZWdfcmVhZCkoQ1BVSGV4YWdvblN0YXRlDQo+ID4gKmVudiwgdWludDMy
X3QgcmVnKQ0KPiA+ICAgICAgcmV0dXJuIHNyZWdfcmVhZChlbnYsIHJlZyk7DQo+ID4gIH0NCj4g
Pg0KPiA+ICt1aW50MzJfdCBoZXhhZ29uX3NyZWdfcmVhZChDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgcmVnKSB7DQo+ID4gKyAgICByZXR1cm4gc3JlZ19yZWFkKGVudiwgcmVnKTsNCj4g
PiArfQ0KPiA+ICsNCj4gDQo+IFdoeSBub3QganVzdCB1c2Ugc3JlZ19yZWFkPw0KW1NpZCBNYW5u
aW5nXSANClRoZSB1c2FnZSBvZiB0aGlzIGlzIGluIGdkYnN0dWIuYyBhbmQgSSBkb24ndCB0aGlu
ayB0aGUgZXh0cmEgbGF5ZXIgaXMgbmVlZGVkIHNvIGl0IGNhbiBiZSByZW1vdmVkIGFuZCB0aGUg
c3R1YiB1cGRhdGVkLg0KDQo+IA0KDQo=

