Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E63FC44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 14:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmBuG-0005ic-UE; Tue, 21 Jul 2026 10:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1wmBuA-0005i2-Qm
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 10:57:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1wmBu8-00032Y-RK
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 10:57:10 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDfxtX1707330; Tue, 21 Jul 2026 14:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=AkDAxq+v80VbU2QSigEGzExqxWcpYsbQnWQTWdC1dwI=; b=jD
 HPUry/Vm+I5Sif3mgRg8Pt6c7fG+QwNzooccdBsAn/jdjxoNgQYQGQJserU7TjBa
 Mcr28oVs8vTUe06P3i//9tqCwmrr9/aDhDK4VYEKec8+gHVSOQnwsm9AFn7Z3dBe
 nd+hTf6cqFCabdz7hm4ZjVjKb1wZhrQg14dbgG0VI+Tjht6uPgzIRaiu6GAgOnTQ
 mYRC4vQpFiM8KK2sFzEomCtM9lqw/aOOFTeBfx5JLi4cBpuwnPUCIBUF/TsjKINw
 sbRTKllHn99eqA9IbNqnvFMOLxCwJYe6E2dqPI9NONoys7Kd4YN7NWUc9VgfGpFL
 SlBM558Sz4lnP2BQtD/Q==
Received: from ds2pr08cu001.outbound.protection.outlook.com
 (mail-ds2pr08cu00102.outbound.protection.outlook.com [40.93.13.74])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9ae8j91-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 14:56:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onEB0Ys54v8CjX2r5kpi4uctiDi7VhLrBBKhnP+LB3BzRbfUOg06UJJCfDxRJtt3pAs1CqxOYK+DAUJjfB32kfhb8adoiyUJlHsReSz8JN8oAk+HYE0DAWXyzKJabldefSelx7+KS9RQy45S92uL6NLJeKon9Os/QqiNCgo//3CRvEzZdEe/TGl7X68M9jER1nNppXTCEaHj9ZoArjlZzLI9PxmKWRpwsUSpkTovgKP9H9HlpxKzI57sMtAXZAtYp7QQpR3UppAKxtthyiD09Q9l4jhBtkpXYyJIQK8xY9mtL7SDRseQILHyfhvZNlG5iw1/pbV2COEAWkkLRbz2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkDAxq+v80VbU2QSigEGzExqxWcpYsbQnWQTWdC1dwI=;
 b=ndAWFqoSgyvv9dulsY3Zf/ixuCN1qrqvt1mZ/FYXyBf8fCBLukLx/qJpIsG91kydCVm7x5bgNkp/5q7Q55FwlfiUaRzh7O8eI30+wg5B4+9JZUlpRr0ay2IMgfWbM2uNx1W2fLLnrHfcU3rzNnkHjH7gdI8MgBnYn5aOnBLyDpa3xxMj8oK34BvscDPgle8B3/AelVhRl50IUSA+Vd9eKcLjrpCGdN55qBzY+cvo2LBMj+2sWpQwJDs5TT7Yzxb5YeyysrvmNjmg2VH4PiZwLzEcY8STU2A74qmaaKm1ALaadG9mGSyvTM9gljR7cFyXjDLWH23JOh5JNFRHxfHQlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from DS0PR02MB10990.namprd02.prod.outlook.com (2603:10b6:8:293::18)
 by MN2PR02MB7056.namprd02.prod.outlook.com (2603:10b6:208:20c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 14:56:40 +0000
Received: from DS0PR02MB10990.namprd02.prod.outlook.com
 ([fe80::f1e6:68f1:dc9:fc43]) by DS0PR02MB10990.namprd02.prod.outlook.com
 ([fe80::f1e6:68f1:dc9:fc43%3]) with mapi id 15.21.0181.011; Tue, 21 Jul 2026
 14:56:40 +0000
From: Mark Burton <mburton@qti.qualcomm.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>
CC: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Albert Esteve
 <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>, Alessandro Di
 Federico <ale@rev.ng>, Alistair Francis <alistair.francis@wdc.com>, Anton
 Johansson <anjo@rev.ng>, Markus Armbruster <armbru@redhat.com>, Brian Cain
 <bcain@quicinc.com>, "Daniel P. Berrange" <berrange@redhat.com>, Chao Peng
 <chao.p.peng@linux.intel.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, "cw@f00f.org"
 <cw@f00f.org>, Daniel Barboza <dbarboza@qti.qualcomm.com>,
 Demi Marie Obenour <demiobenour@gmail.com>,
 "dhedde@kalrayinc.com" <dhedde@kalrayinc.com>, Eric
 Blake <eblake@redhat.com>, "eblot@rivosinc.com" <eblot@rivosinc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Elena Ufimtseva <elena.ufimtseva@oracle.com>, Auger
 Eric <eric.auger@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>,
 "helge.deller@googlemail.com" <helge.deller@googlemail.com>, Alyssa Ross
 <hi@alyssa.is>, "iggy@theiggy.com" <iggy@theiggy.com>, Warner Losh
 <imp@bsdimp.com>, "jacob.oursland@gmail.com" <jacob.oursland@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 "jidong.xiao@gmail.com" <jidong.xiao@gmail.com>, Jim Shu
 <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 "matthieu@minio.io" <matthieu@minio.io>, Max Chou <max.chou@sifive.com>,
 "Ho, Nelson" <nelson.ho@windriver.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Bernhard
 Beschow <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas
 Huth <thuth@redhat.com>, "utsingh@redhat.com" <utsingh@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, "z.huo@139.com" <z.huo@139.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "zwu.kernel@gmail.com" <zwu.kernel@gmail.com>
Subject: Re: KVM/QEMU community call agenda items and host request
Thread-Topic: KVM/QEMU community call agenda items and host request
Thread-Index: AQHdF62YDJ8M9W+eHE6CLX7CYw76N7Z4BbUAgAAM2YCAAABOAA==
Date: Tue, 21 Jul 2026 14:56:40 +0000
Message-ID: <0037BE09-1496-4A5E-98FE-08462B2C73DA@qti.qualcomm.com>
References: <87v7aag722.fsf@draig.linaro.org>
 <E81AEF88-70FD-4800-A51D-2274D5BC78F0@qti.qualcomm.com>
 <0b216681-c56f-474c-834f-2a035a728e6f@oss.qualcomm.com>
In-Reply-To: <0b216681-c56f-474c-834f-2a035a728e6f@oss.qualcomm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR02MB10990:EE_|MN2PR02MB7056:EE_
x-ms-office365-filtering-correlation-id: 107741c8-c8df-40e0-0eeb-08dee73845ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|366016|22082099003|18002099003|38070700021|56012099006|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: O3Qi0AErOKw7kzPGH3DdVrmA7yMPqbwbvninyYg9YNerRB6Cc/OOyfj3OdABfutK9F9qE1sbEvUg8430Yigm7LjHhowlKeG56EU06LKDirFhaibtdgFenIirznMumqQm8U3Dd0BDZ7cVmx79nQGghL3WyecDv4H2mQo85vlcHhNwGaSG7KipZWaWPZ6nUiYJzQj5jq9jkCLHoMqnljw2akXlYUudk6Hn3JnrIlQWTSznd6fF/h1csTQpe1BlhgDeU63y6cP9bvs1KA1aIFwbSx88HI+qMf09bik69x9GYo29xez0ELMQXmmqO2jZJwGhvVqnCV+KMUZK4/i0h59P8WllvLLoo82SuMmvA9PcjarGZso/KNBCKujJwSZDtxONgX1zvmMEDW2toxeDbXy3duSb2aKeAROpxmBK19RErV8+ZXd974nE2XSld5aVDxJJVXbwGRtb9WEjehLApKVCJs6d4YTUHFRF66HaGLDU+/30K/6oTqonMhwir5enRn7hKOVPsVTjqdBzj8zLW31MHPD7t7yV5YsOvc/J3m1ldf9WWY0AKblTuUnpB+v82KhoriGQCy2/qmFnwx3I/+0CgWN86rvBRZAzfwoNJEj9aA9xNCezf60kEix84ag6d8mjgavb0SfMrIEgjPGhfcoizqauS9L+0QMzXif0HNiI9wwb5TE4/cQwde0UP/xr3G1rRoJtRIQVDu2BGYHbjUBPuNzfxbU3OjtbRnHt4Sl7shk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR02MB10990.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nmx3TzBOSzVVOFV2VExkM293RHdxNE92RjFRc3dXRnc5NjNQK3NhblVCMkQv?=
 =?utf-8?B?cVh2dXZNTGNhbUovbDRJOVBib3Y1N1hBcExZNktCVFdjV0l2SUltQU5vMFpF?=
 =?utf-8?B?bUl1SnN4eEFTUEN4VGZ3TkczWjlvejZ2c09QWjNXZlJkWUc0QVNLSmQvZFJz?=
 =?utf-8?B?allvdkFUb1JBTmpURU5aWHNkV3JWVVV2ckdhTkNPYUx0OTJya2t1elF0ekJx?=
 =?utf-8?B?VmF3d0dCVkJxOUFnNG5Mc2xtTVZkNjRMWUt0U0QrSHBBZjR0L0w3UEZ5TjU0?=
 =?utf-8?B?bldlemRjSEhtVnljOWRqR2VGaG1tdEIrK3VFVEZyOHVBZU1PWDIxMVBaNE42?=
 =?utf-8?B?aEFGN0NoNzltZ0xNQzNzZFpWazh6eVExUTBZUExOS0RlUFFsSkNYWndpUlBV?=
 =?utf-8?B?V1o4dFZ1NmRiWVFKYm5OMHpYVnI2cXFFWjQyWnF2UnRuN0NSSEZWdDZqdFpD?=
 =?utf-8?B?bEI4bG9sQmkzb2syeWdpaWV6OVB2K2lueDJLZm8xUHorUU9WNlFOM2hHOTlp?=
 =?utf-8?B?TFdLSU9MRXNieGhWdVZBNWRhaDFma1NkNmcyMElldE1KY3EyYjNiS0IxdnJ5?=
 =?utf-8?B?d25VeFFIMnROQmRuRFJxWGRoNUliNW5ZanZFdnBuL2d6TkFQOVY1Z0NhaHdQ?=
 =?utf-8?B?Q3grMjcxY2dHSlM0WSt4b3Q1QStTNzJVM2NwdWZWZFJIRFBqWllTYng0eE5q?=
 =?utf-8?B?dTVveUpyYnJnUjU5eDJHRHFjSUlNcnlCVTRoT1U5RG1vcWZrVC9rckplZ01U?=
 =?utf-8?B?dzBPUFNWYkVMY3ZLSTRDTGszMVgrTG5uZmwyaEdOR1VJSDM0aHo3SDFiTk5B?=
 =?utf-8?B?aEIzemxZeE41YXBObFFkVDRjOVQxZGRnajMxNUFvYXp2ckY3TU5NZmZtcHBF?=
 =?utf-8?B?dWFnRkR2bFNjWU04d3loVGhycjVMSjcwYXlwaE5QVGZ3c1c5VGFsSXBTT2pX?=
 =?utf-8?B?MWxRc3pKV25xYnB6L1FQSnlUKy9XZUh0eWNQbWVBemtnRGRjaG9abUd1M0FU?=
 =?utf-8?B?emE0WTJFUHlDcjhFL0FpNVVnN1RubUZGdHFTSWs1MmN1cUk3WnRudGFRV3Bx?=
 =?utf-8?B?M05kTkd2YnQ4WDhDUzllVi84SHQxZkpxTkhVZVA1UUg0dWVlNlRkNjBRbGF2?=
 =?utf-8?B?RzFtWUp5U1dGNlR1UVRMUm1IYmU2TEVmenpPZkNmSzZYQ2prdDRmbXpSVjgw?=
 =?utf-8?B?VVEvZzBHTHk2aVl3SnMwL0ZQdXNGb3VhZ2c5cHZ5RnduaVdBc3lPWUpvajk4?=
 =?utf-8?B?SndwY3pucWtCUE5DemZhdURveFc0S1g5MXJPUTJZQTdyOTZwVWJSUmxnZ3dl?=
 =?utf-8?B?YWdKdTJUaEZSRk0yTCsxd09XL0l1MHJZL0V2QU82OG9nQm1yMldzMGFMTHE2?=
 =?utf-8?B?RGc4ejM2ajRBWjc2eHhKeWJHVnl0V1VSNHhwcG44dng3RFV1ekpQK3RrTjk4?=
 =?utf-8?B?aWFWeGI2ZFM4M3hGTzMrcDU5MzVYUW8xSzNJV2xmS0xSZTVhZzBNME5PcWhH?=
 =?utf-8?B?Z3dRMWxueVd4RjlXNmRqZWIrS3BIdUFtNm0wWWR1NE9tUEJ4aE9uTGtEUmNk?=
 =?utf-8?B?d1VZS2JTb3k0dmpYYkgrUGg3akM1Q1ZmVWNpNzROQVlaSDZEN0c0aHlGZHBT?=
 =?utf-8?B?UzV2eEljbzdXUkxvTnk3SEptK1cwTEZVcm83S3Erd2NhMFVVdmFxTFdZczUz?=
 =?utf-8?B?UmJUdGxvYUhiSFhibHZybG9SdVhlQmRIU09LQlJ4UzAwWEJxUXNad1U0NHJL?=
 =?utf-8?B?MC8rMFlaZWlyVUVqT25EQXN1U3g1YmZ6L01HNTkvM2hJY1ZhU3NlNEs5aGhw?=
 =?utf-8?B?Q1p2ajc2REJNWGt2ME9yYUhNVnFlYjQ3ZlJlSTduc2I3VUFseXRRWWdPTDZp?=
 =?utf-8?B?eW1jK1hMdHI5NlMrOU9pVjhYREE0RThqbEF3YmlQVllKUS85WEN5Y0tvMXpE?=
 =?utf-8?B?ZmhEZEJXMEhQQWs1L3htT2k5RGRhaHZOaG9COGluYTRhQUt3RlRDZTVUN21H?=
 =?utf-8?B?eVc1UWxLRzl6dXFPQ0NOYUl1WGxrdUZKcnRHcDRXNVUrNTJ6VTcwYWVJVGRV?=
 =?utf-8?B?bldtMHhsOUErdnF0UXBIQ2w4QjRCV2E2UWk4dDAyMnR6RUdROS9KbGlQSFdJ?=
 =?utf-8?B?Wm02YktuR3czQ210WmMwSXlRVFlRdVU2MUp4c1hTbjEvbnord1pEUUdMajV6?=
 =?utf-8?B?a0NSN1lLdVBxM0VSajVRWEFCK0ppMllhSXl3Wm1ERUxkWGg3cTZMZWZnb2Jw?=
 =?utf-8?B?Nm1FVDNEZytsVm1ZTGlnSDJ1TmxCTVJyQUNLNmNhL294Zzd4VjZlbzJvam1p?=
 =?utf-8?B?ZHRrT2c3RllFZU1Nbk9CMThSZjFwTDBCczNXZGVHL0txTENuQ3plK0hGSmlJ?=
 =?utf-8?Q?xpQ07TuLOm/sFU/M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4A51FC7C477F947A8AD83CA6D529CCB@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pXWsgery/qoZ2qNaYs5uvbMYyH/xkMlYtG503A111JSSOFSvZwnbsVG/hkrqIx0eBMwD3XcoTHnJAAe3DHSUuLBID3CbIetMS8/cAcHmiehcGErP+WQLUxCpOgiGkczrZO3OLP4kON3GEazVaUBXkyCTj8pOKF8ldcXFj+84uCfpwLO7cowctcWPDyoj7W0BqS9zV9dziQjzqOYVSIKVPalCRfzSFev2uuPeimYkBqp4sngHzrX0kSw8INoo0mOc9oijoxuMdIuSQfAY3lgCVi2daRHG0wzDZvejjLiqv2g5IJ2/1cq57V4yOLBDg/HfHczvnnVh/vJKLBojvjaEQA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vZTpEL+rzwKhp/5CqUPzcaXvLDRk0Kv8hOq1D2RBLKRGQtDp9aIV5xeL/vV56I3q8Fc43kdWY30BmkCoIxQnnuG/eCx5qClwzMnplgv7bZ+z5FaHKQE4WPTDAa9Zw1P3x2rN9wG0b/xmB9nC9d27SSDSxOozYP/cbDXD2/f+kEf7mxzIcBHqmvJJtZXaVdsypIz9B09VsD6koGF3dH9wJZNgBbVcK434h+M5j+nKD4njEsrntCeN6okcjQceNniTqW/Dn6NiWQEiyPCk1oZuMA8Nw6SBbnR1GBk5weskEO951ImZSJuuP32xkkVfyzrk+lYgwOakYSoUm9qUReDpoL9qv32vAt+/eYVnjCCKYnFaWgt79fVKJLrGoFl97IGb26bzC1om0QVUCFVt9vWxNhJT/dZ9xLYnphp9OYL4xAEHGxMcJfRnOO6vyEGj8yeaPNf6DrF0ne4cKUYdldEjAYeTjgBuM07fnEtjafRsBCTGpswUSbtQU/NHX4gIKIlEop0RBAsHxuW6PDLNAu85gT9cl19JZKrHgKVF6UfT558l+Z1IRlPwuwQWCOGI1avjnKjwdWhPKBwE7re4CPqNSd8AoKhVHvhdIDAnZNmfJ53ytqcMD/Y/Ocr34S2pKcY0
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR02MB10990.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107741c8-c8df-40e0-0eeb-08dee73845ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 14:56:40.6086 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: crHFEpFAiA3dpYeURAQSIMzsEW61c8AAsaH1PXrhGMIqWYefWrBay4vclncOjtKbjyLk2PLoqSdbsSAlcEXnruqALssREjNEBNnLi8nI+Yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7056
X-Proofpoint-ORIG-GUID: n3eTMDBFwpgnpv-Qr2ZUDrQOXiXnlciL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE1OCBTYWx0ZWRfXx/5u38PpzoBf
 J+7Jx2K5de+5ma+ZhxU2cVn2g2s+duD18dRcyfP5CihZwKiPqgklPIHf6MlhqWxWr+f3e1AK1r2
 ffpZLnsj4ufnt1ynZCvn8dJGKFWkm+8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE1OCBTYWx0ZWRfXxixGSiwnC9Mb
 5Y7WIzZ/MAF3cZAXWhi3OuQT86HbAsq2u972D0x9Tq6olbP/dJGvO25ZCug3mwnsH0ZmuVuJh2W
 8IL/r9MV0nVBqOyMqrcyImaIaNvvC9l1v6sl6ljP/hsYTQCRAKBk7XoWdeJvNHPK+vC0VKjDZuC
 Uzb4IQAJxLdRTWpvYhiwlHxK8T6NFNEUF9lAfiqci+ye1um64VitbgZGjaaeqQiVo/1/dKYYdJA
 TP4gXIv3NqAWBr6+brSA2z8xOiT1vZSRx3C5DHxA/7b/bD0YuMCqgNAaCTPN8Z0qhdGrqp4otJu
 O3gS/e55FdMuEkFKcbSReGZISIIT7A9pR2faE5YjlUiUADevfQy38AaDB7Za5JCJo4qEbD1u3Or
 K49FCoFH3vAu6tgaRkl8fRQcptEyFZm/p/X1pY4S1319nQvQ2KM9+0Xvr1Z25/QfvNEf0vkf8vL
 7ojvSzOisTBNy94T5WQ==
X-Proofpoint-GUID: n3eTMDBFwpgnpv-Qr2ZUDrQOXiXnlciL
X-Authority-Analysis: v=2.4 cv=Cr6PtH4D c=1 sm=1 tr=0 ts=6a5f88ae cx=c_pps
 a=1w3Rox83O5gulhrCDwffwQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=nXA5WNwiAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=V6WFrv2sJYRMvMEUh3kA:9 a=QEXdDO2ut3YA:10 a=fGr-7aqQv4RST94IA8XU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210158
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mburton@qti.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

UG9zc2libHksIGl0IGRpZCB0YWtlIG1lIGEgZmV3IG1pbnV0ZXMgdG8gd29yayBvdXQgaG93IHRv
IG9wZW4gdGhlIG1lZXRpbmcgLSBzb3JyeSBhYm91dCB0aGF0ICENCg0KQ2hlZXJzDQpNYXJrLg0K
DQoNCj4gT24gMjEgSnVsIDIwMjYsIGF0IDE2OjU1LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8
cGhpbG1kQG9zcy5xdWFsY29tbS5jb20+IHdyb3RlOg0KPiANCj4gT24gMjEvNy8yNiAxNjowOSwg
TWFyayBCdXJ0b24gd3JvdGU6DQo+PiBOb3QgZW5vdWdoIHBlb3BsZSB3ZXJlIGF2YWlsYWJsZSBm
b3IgdGhlIGNhbGwsIHNvIHdlIGNhbmNlbGVkIGZvciB0b2RheSwgbGV0cyBzdGFydCBhZ2FpbiB3
aGVuIHBlb3BsZSBhcmUgYmFjayBmcm9tIHZhY2F0aW9ucywNCj4gDQo+IFBlcnNvbmFsbHkgSSB3
YXMgc3R1Y2sgYXQgIndhaXRpbmcgZm9yIHRoZSBob3N0IHRvIHN0YXJ0IHRoZSBtZWV0aW5nIiwg
bWF5YmUgSSBkaWRuJ3Qgd2FpdCBlbm91Z2ggOikNCj4gDQo+PiBDaGVlcnMNCj4+IE1hcmsuDQo+
Pj4gT24gMTkgSnVsIDIwMjYsIGF0IDIwOjM2LCBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxp
bmFyby5vcmc+IHdyb3RlOg0KPj4+IA0KPj4+IFdBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRl
ZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5IG9mIGFueSBsaW5rcyBv
ciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KPj4+IA0KPj4+IEhpLA0K
Pj4+IA0KPj4+IFRoZSBLVk0vUUVNVSBjb21tdW5pdHkgY2FsbCBpcyBhdDoNCj4+PiANCj4+PiBo
dHRwczovL21lZXQuaml0LnNpL2t2bWNhbGxtZWV0aW5nDQo+Pj4gQA0KPj4+IDIxLzA3LzIwMjYg
MTQ6MDAgVVRDDQo+Pj4gDQo+Pj4gSG93ZXZlciBJIHdpbGwgYmUgdW5hdmFpbGFibGUgc28gbXkg
Zmlyc3QgcmVxdWVzdCBpcyBmb3IgYSB2b2x1bnRlZXIgdG8NCj4+PiBydW4gdGhlIGNhbGwgKGFu
ZCByZWNvcmQgaXQpLiBJZiB3ZSBoYXZlIGEgdm9sdW50ZWVyIHRoZW4gYXJlIHRoZXJlIGFueQ0K
Pj4+IGFnZW5kYSBpdGVtcyBmb3IgdGhlIHN5bmMtdXA/DQo+Pj4gDQo+Pj4gLS0NCj4+PiBBbGV4
IEJlbm7DqWUNCj4+PiBWaXJ0dWFsaXNhdGlvbiBUZWNoIExlYWQgQCBMaW5hcm8NCj4gDQoNCg==

