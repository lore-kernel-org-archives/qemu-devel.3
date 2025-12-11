Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8154ED43343
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 19:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTmfV-0006EG-2K; Thu, 11 Dec 2025 14:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1vTmfS-0006Dp-U5
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 14:49:38 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1vTmfR-0003c9-5u
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 14:49:38 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BBEPLgW1862727
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 19:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=aIl1jyLVre0DUY8qLNN38qyMC6GIozOZnQRal4uWYgs=; b=Al
 tN4nvD00Cb8oCM+ic+V8uTuX+Owvv8/gBag8o5C2ZSqboIMvmdekWZ09mKnG9cSD
 0iacPS7pf037hXUB893CMjKzbrDyqWQvICnPPRqYnnyB7Bduk3MEs1w4UyZElEdI
 5vR3cfYKYYs/pvCsqaVA8B5sz36hrCQe/xaIBSzGVZKB+blqBc7clxNBoOobgVzF
 /emVGuwQ3Lf4abvF8pXgX7LXhjbCapLDL1AFVbgARoNswwQcy9tQrHp9v+meNBur
 xj0tVDWSfjhBvXkeLKj/+IjGX3rLP69fsxEmdNp0IXfd0/32qlc/XF13UHEKaUJ3
 FmrDqPpw1BRZdTb8F6sw==
Received: from byapr08cu003.outbound.protection.outlook.com
 (mail-byapr08cu00301.outbound.protection.outlook.com [40.93.1.105])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ays4qjc5j-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 19:49:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmc+plX8qAhlkb+xkF7G1n99mtfVNAsW3vq8JEJTnkzHao0Twg/n5gZ0LhrgYPuOJkjOKGhzKM0O5eE+IRoMRKIlCS6bpuSJYfd+rWo32UAuLDoRYQL/biTFTwQn1hzXXF0Mild8S42wn9jxxaj8Qx/fgxJlZ7fqAOsN9pTsUx1107dlnjSO3yAJKLIGXrmaZuCbgOCvKLs1J4KfiHP9WrjjPL0x9iT4p1LJveUeUZftdP071X0TlU+oATuXmMtpFsraSFtz+WnjE6N/5ukr4hhvP+dqrv5TSSJm1CjwK8pRWLdYdtCBUsA+bDoRggovMU1krhkZ/Hpuo/Lii+h9Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIl1jyLVre0DUY8qLNN38qyMC6GIozOZnQRal4uWYgs=;
 b=vqoK9tGDSUFqrNmLypbBFiLLCZxwZI9FALBw5C42PPLfBiu1q0KCbIpec27iBmRDXKdG0hyiEcqK5jdCm2e40posCy4tKKaleaKu6MEG2/XftN143n7PEoIOWD46RjUYvGH62vT/ysb/UGo2hv4BpS9uM1kv1QlXYFud/H4eY4zOrkHsTpaBZPgRXrE/apSAZcTzN1l7Gpro02fzn7LUWxmGcC5eW7upbwp/jAvFnG2NnV4mHUh5gBvLyuZ7tBeAf/0CgjOplLfTqeAc49YINuK5GnrSfp9dc6NyaFGHy3BRJg2g1+OVtBY9x9cBm2WYDgE5aFmCFUZOk5NClymarQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from CO1PR02MB8617.namprd02.prod.outlook.com (2603:10b6:303:15c::20)
 by CO6PR02MB7585.namprd02.prod.outlook.com (2603:10b6:303:ac::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Thu, 11 Dec
 2025 19:49:30 +0000
Received: from CO1PR02MB8617.namprd02.prod.outlook.com
 ([fe80::5a28:4da0:a734:9bcf]) by CO1PR02MB8617.namprd02.prod.outlook.com
 ([fe80::5a28:4da0:a734:9bcf%6]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 19:49:30 +0000
From: Mark Burton <mburton@qti.qualcomm.com>
To: Richard Henderson <richard.henderson@linaro.org>
CC: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>, Matheus Bernardino <mathbern@qti.qualcomm.com>,
 Sid Manning <sidneym@quicinc.com>, Brian Cain <bcain@quicinc.com>, QEMU
 Developers <qemu-devel@nongnu.org>
Subject: Re: Record AS in full tlb
Thread-Topic: Record AS in full tlb
Thread-Index: AQHcaPk/84BXpnny1U2sGuplCRM7l7UcjP8AgAA+u4CAAAntAIAABuCA
Date: Thu, 11 Dec 2025 19:49:30 +0000
Message-ID: <1400AC45-E6F1-4031-A95E-3F51B79D71DA@qti.qualcomm.com>
References: <A5D46F85-9B92-477C-B964-1DCE2A1CCF19@qti.qualcomm.com>
 <0d3b4338-2c31-4e42-8a8e-319f3ad4029f@linaro.org>
 <2A86D9C4-7EA7-4275-943F-D75801B5539C@qti.qualcomm.com>
 <081b44f3-48aa-4af3-a0d1-c8e5915d95e3@linaro.org>
In-Reply-To: <081b44f3-48aa-4af3-a0d1-c8e5915d95e3@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR02MB8617:EE_|CO6PR02MB7585:EE_
x-ms-office365-filtering-correlation-id: e40e06ed-6c7a-4da2-216e-08de38ee662f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WFJKbUtoS2wxYkhYL3phMmdUUFdYS0RNclJLUHBGd3ArZVA0cFZJQ1NPbUlq?=
 =?utf-8?B?RG1rckJLUVQySm5ZbmRIcGlzY294WmVEVi9vOWdDNHgxcjVwUGRqRFhXUGlP?=
 =?utf-8?B?MDlyUFdOei9CWkxURkFBaGMvczhwM0QvT2JOeW04T2tvR0ZFT3FvMzRsbUpP?=
 =?utf-8?B?ekMvbzhHcW1sckI1QW9nWXU5SDV1WEdkaGRXUHNUd3JkM1JhLzBoZVZobE4y?=
 =?utf-8?B?dkhGNFJXL2VGODltMDl2R3U0bVIwRDJ3bmdMdUtnV3VDcDJpeENJSDIxSTF1?=
 =?utf-8?B?N1hHWUFkV1R2MTY5U3NhbmE4VHpkVVVOcGdKdWxJNi96eVM5SktrQXpSUUVp?=
 =?utf-8?B?elZ3Y2Izc2xWWFAwL09tSmt5akVqN01Nd3BucnhXbWM0MUVIZDZ1WE9qUDBl?=
 =?utf-8?B?WVdnMkJEUnBQV1d4OFV4MnB5NmMrcWowYlhrcmpTaGZSZWtpTTEybXFGaitT?=
 =?utf-8?B?KzR5eU5uTW8rd2s0UktWaitYelV5OE1WM2lpdGl3eHFmR21KQXlyT3NuMnph?=
 =?utf-8?B?UjE1eE02eHQvNWpBMXpFOWRGdmlqN09ObVdzSlYvMnpEV0NMOFVZeEduUUtY?=
 =?utf-8?B?Mmo3SnUxMXUydXNjeGNHaFU4b0t4ZlVzZ3YxTFRrZ3l3dUZHOUU2TytYUkhK?=
 =?utf-8?B?eEppTmUzL3d5dU95NEFxTnlzR0hMRDNGaGE4NEVCcDhpK0Q0M0JId1FISGp6?=
 =?utf-8?B?ZzVROU11V2VxQmd0NXdCTnp6RW9OcTdiclIyQkR2VktGTGNEWEpIQldnWWxp?=
 =?utf-8?B?RjNBWEpqa1ZHUzdjT0FudjQ1RmZlL29FcEJycjZDb0NFNTFGRnlnUUM4Rlox?=
 =?utf-8?B?T0dNRFg5bmFLRjZjbURMb2pYUVpXYTh3NEJXS3FLeUVBTW9wOW5BczNlcEt5?=
 =?utf-8?B?cm1uM2t3NXlLMWVhZGp2K1dMekQwOWNJQ3JBTGsrM2JBV2RtaGtvUFhhZEN4?=
 =?utf-8?B?cE1leVc0TFVKNldmeGh5cm1kTzFSZUNHWWFJWFhwMUJNeUIrYUZzR3gxdlp5?=
 =?utf-8?B?ellsRE5OdFBvRUFmcTJQNFlnZnZPZWQ4NlN5aW1pekVUWkJJakpGZHdjSzMv?=
 =?utf-8?B?S1VvaUJGSkFwYmlUeXRHaVpLUWI3R29CVnEyUWgydmwrbTc0MkNzdjJvUng0?=
 =?utf-8?B?dDZQNmpyZm1ONUpmdno0MEN3RWlaWDh2NVFnR0pKUWNlTHJTMlpNUjRVM1lK?=
 =?utf-8?B?UzdKTjRZL0hQVmpzaUtyTmV1RzZLajFtdExLRjJWME9kb0V5M1V0VTZvNDJN?=
 =?utf-8?B?WjY4ekU3eWR1NzdWT3RldHJybEYrbmtQeG9WSVZKWDVJK3RnY0pwMzRCY0JP?=
 =?utf-8?B?cTFFb2FoSmIxY05CaWlBcW01ekpCTGsrWFFNNnI4SGpWc2k5TjI1Rnd4M3lY?=
 =?utf-8?B?ZjNLb2tYeCtUVUZiaHZMd2RwZnJsWjN1TGUxaFROQm5QOVRPa0QxbXV0QzVZ?=
 =?utf-8?B?NFNGeVhKd0xGbE5HRm5ENU5Ub29pckVvVG9nZEowZDVoa1NHWkt4dkRwMzBp?=
 =?utf-8?B?d1RZV3VWRGlTZE1ZZHpTWjZ2Ukx5ZEptc1JmajVCcmI0WEVURnlmdXFzZkd4?=
 =?utf-8?B?MDh0Qk9lZXlHSENUN1FucHVrS3NTelllVEVHZnVsN0FUWldNUzc3UXM1dFo1?=
 =?utf-8?B?dVJmcmJrM2w0R2dNQzdSbGNTdlF1Rmx2R2V1UUM2eEhvMHBaUk8wN0p5WmJL?=
 =?utf-8?B?NFVvQkhDd0tuK0dmeFlMYUZwd0lyNVlsQnpzUzMxU0szZFA2SnpqbnQ1N2pn?=
 =?utf-8?B?RnVaWXE5b3ZXcUZNV1ZIWTJZWEhiTnkyeE1Jb2VyaWtrQy9LQ0QwdnhqanhT?=
 =?utf-8?B?Mk02NVBocmdHTHgzblNBT0hWUlFaL1VWS2FEZGVoNG9kWW9XUWpVYmNBbWND?=
 =?utf-8?B?cVBwM1drT01Icm1UOE5xVFVWQTE2Nko1cVQ2OUVHOVJDaHlpQkNBRk9uTXdp?=
 =?utf-8?B?WWU0TS9ZVDF4UUtvanduS2JQUlBKbzNMY25zNlhWWnBrc2ZXTXBhZWxTZy9i?=
 =?utf-8?B?YzJFOXlseFVUWWxDUWJuVFlmeEdDWTNXTU1IUGZGRmM3bFloWWZTTDhWSFpi?=
 =?utf-8?Q?vi9U/Q?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR02MB8617.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXQ5RnBFREc4Y052QTRqcmtVT2VKK1paY1VlRUQrdkpXbisvWlpCbjNWQ0pU?=
 =?utf-8?B?aVhkZElyR2VqWUJKbzBPeS9iek9qODZQVFRsQmRBRTVIT2E0Yi9haUVQZHhU?=
 =?utf-8?B?V1BiM0JDcmE3OGpGcndPc0djdlNOSkcybUt5RHowRklNSUFFRjdoMlZuVngr?=
 =?utf-8?B?Z1ViSkdXTnloQllZOHlBdmE5bWVtcmw4ZGhGaStVZFROQ0FtYWNmUTZhd0pm?=
 =?utf-8?B?dFFGUmlkOER4dW16ak8xV1VLRk95eURKMi8vVldtS2RpakJsWUNaOTMvZ0Ey?=
 =?utf-8?B?MnMvdzR3Y0NzbGJ5WWMvMUpGaERXc2JKYVdlOVFOTlpNem9yUUI0enQwMVY5?=
 =?utf-8?B?RHZQVmRKU1ViT2l2Vy81QVhZUW44L3lUWlhxcU9sbWQxUFdYL08yT3FQb1FQ?=
 =?utf-8?B?ZnV5bVkxTDV0NnpiS3ZGczdpK09QK0l3MkVaT1FlQUJVR09RaDBUZ2hMbUxG?=
 =?utf-8?B?NzR4UituVEdYOGpDNXdIMEsyZnExaksvMDh0WjFwcjJlUmpVZXc5cDNnOEQ2?=
 =?utf-8?B?SFZjYTBMUC9SWlAyTVNFV2NuNFVhVU1FVTRLRG5IM3VZcEhNR0tNRzNzckdu?=
 =?utf-8?B?ckFzUnNGODVLdmpjaVZqb1huUFBwSUdPem1hdGlIU0RMZkhxNWcveWdVS2Y3?=
 =?utf-8?B?Q2lUOUNKcmVlemlhNkc0ZEJoUmhBSDRQR3QrZWYwZ3paMHJGbDlKd1NHMm92?=
 =?utf-8?B?L1YyWldINkloVS9sV1hhREthMmlVelp1cy96SFFzdFVxV0NnL2ViMXNDZlJQ?=
 =?utf-8?B?ZGVZbmlJeFRTeDRqSkhJODh4NUlLVVBVVWZaYXdYT2E0WGlkQ2ZZTGJKOHB2?=
 =?utf-8?B?SFlwN3pyNmhwN1E1VTBJKzZuNDBBb2t1NlVrSEE5YWxqaGVTT3pQRFUyeFA2?=
 =?utf-8?B?WVpBcUtoSXYzWHRzN0R6UDR6STlYaWkrb3pCbWdCN1U2Q201SzV1YlAyMXRO?=
 =?utf-8?B?ZG4wSE9FdEI2VEZXTFU2My8vWTlnclRvTnZGZndHWEFFRGRuamlWWlhFQ3VC?=
 =?utf-8?B?KzVuNmFLT2c0bzZXdm9ja20wcUhSWE9qeGRxcVVQQ3VQZzc5QXFEU3pVY1lo?=
 =?utf-8?B?S0RuSE5FZnVYY2t2YVp5TnVFM1ZCYUU4ZVNKVExoZ25MZmQyYmF0c2E3QW4w?=
 =?utf-8?B?VXVpNnBRTVF5QVBsVXZUaUJVbGJzMWwyWkg2UXBoQzNJbDhHQldYbFBkV2cw?=
 =?utf-8?B?cGk3OUpKMStteFlGTGQ3SjQ3WTEyRjNCWXZlQ2NzQzRDRUpCSXp3aXIrc0ZO?=
 =?utf-8?B?UGdSOFQ1K3dVTEtXUjkvK3M5QzZmd244UEMvd29jUEpCclhyNjVLR2RUUS9M?=
 =?utf-8?B?dXBheVBrcjlhUTdnaEhhOE1kd2RGbEdxeFJPOUlXWUR2YTlBeUlERUthUk9h?=
 =?utf-8?B?WFpYeDZ0TzVURStxNjJNbXgrOUk2QjBwVDdHQThHYXdYSDhLUjVXTVdiNDYx?=
 =?utf-8?B?QnZhS1JUVTlMNm96ZVdmbkUrSExhRThaMXRrOHY0Q0t4TnJrQTdUQlRuVC80?=
 =?utf-8?B?dHBOWElUTVVqWW5SdVlrMkYvZndjRThmZkVpYnJ3dXhQelF2aVQxU2c4Nmta?=
 =?utf-8?B?YStPbkR0N2tsMXBOdEhPY0YvZGlOWW1RSnp2aUV0ejRyY1FEdnE5RHRqd3NK?=
 =?utf-8?B?aU5zOVdiMzNjQXMyVW1LTDRhQkxFaUxuSzdGOEZ3TzBMUUVGYmRKdHNrbXFZ?=
 =?utf-8?B?YkxuTko0WEo0MjBHc1BpR0FvbFFyTHgrTFlWdmVqaXlJd01nVEJzOHdJZHZu?=
 =?utf-8?B?T0RlS0ZmZVo2djBzNzUwU1dYVDFTQzlEU1RBRVlqQjNkdEtCUXNjVXpVUFNN?=
 =?utf-8?B?WUxHcWN3R1lyRVdpVS9SSGloNGpyeVdzckRudnJ2QkNkZ3dobWFFY3ZwcVhE?=
 =?utf-8?B?N3UwSU1OSVlKR200YWRyTVNDY21mRkZPQWQ4MmM3c2pVYlI5enJRTmc4ZE5K?=
 =?utf-8?B?YVVxNHJIdE9ET3lENE5lM3p6RTl4TCthOW1GajVRMm4raXVnNldwQ0JtcU9l?=
 =?utf-8?B?SXlRalZlbDFSVlBlRWFxNHhseFJtc0cvNUE2VlBCS04wUUF2R09hNHVqR1Fm?=
 =?utf-8?B?dzN4YUJOV3lkMHNDNHNjM2s4L3lscXY2WElGUnVNVm5jVDNxaTBUTHA3cWRW?=
 =?utf-8?B?QnlBT2thRTVOZzlFVUJCSkt0YmNIVzM5dGpKbDdmaG1Za2VzSHh6ZnRlSGt4?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A8EB0CE797F134A81A3F1FCC31EF731@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Fsq+0wwE6VIUncBJ4SgEDgm1QnfyelMYX9qdmbKpTMyArwhIFPWkjwMdQ3CcOmB2cp88OwoTEc9gLEhWahvMA6k0SYgE7qDV2M3yr+c8yybJ3nYhuJdTvE9U2AgzsntDWOyCydwgOm7uTVFoqkAvHOeKf916/AsQh28ET/Xks681nEfhEoSjLW9mh+/9xjpYkW3iHQvBIcEXO5DOJgVB+R6yIateQ0Fnk1TvY1nDflL8qrfGR2WKzLo8ToZE0ddsKm9cIjnfCDtSRox7Iq3A4qo9o69DJDF2f5BT6AjlXUYa1H2WtCpaUPPE5bKPA6Vg0HGGfLOjCtDuLlhOBTs39KQcO10MhDC3rGlEdDjru+P6DahYWqEq591f2X2VMg96hTJdJvm21P4rEFvYJ6g2wdnnsG7Pvr0vdbmNivC80iE6b2OZjcRroy5BDpW0CFyM5pMU1PzQ6S0yu2ZsjSW38ycBFgfZZNq6Kf0w/JNSHf3ZVozNZufUqLjGwJL+gRDhDf3jFgieJnAdEoyBSm2Wttg4wb0NnC14y8G2+IIyb0rvcYvABlhw9e5o2kBkzAc1SddXQg9Qr71yiW1YlYjn6rtthv35nj1WDCdTH4rVq9Gd3eo262fXQnFpb65dM7yz
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR02MB8617.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40e06ed-6c7a-4da2-216e-08de38ee662f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 19:49:30.0533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i1ufpkNMw9DHOzWw32sRovwTqfIq9w+OqE5jd/RGe2r7oHb8MPKS5w0cTiDy1v0qyQM7J/zAhH5vwIJ2k7wFtjcc8dI9oJLv6RlU0inbqQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7585
X-Proofpoint-GUID: Z0tY60HCt7mRLJ9pCPnlYJ2bQHuNOv89
X-Proofpoint-ORIG-GUID: Z0tY60HCt7mRLJ9pCPnlYJ2bQHuNOv89
X-Authority-Analysis: v=2.4 cv=B/S0EetM c=1 sm=1 tr=0 ts=693b204e cx=c_pps
 a=kvx6ZQzDH6Ei332aIKkncA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=hjKf3HEaoyvSzCfI5vcA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDE1OCBTYWx0ZWRfX/9wEGepsiROd
 8EdwyrRwPyV/OgOk3kT0KKC4SvoL6lTQbiwbs49b9R9TjKztD0rkWKpTu5QluCa2DzaWDC3sZEc
 LPhELW/C0of9gbOMgExiC328e+lkh6tvUGuHQs5hPx+qfI8nlIHQv/3HWU+ACzVk2FzPW11CCSz
 G1WGPPpZXbDNpwNYXPj4qgkor0Pk5eX12wMSA/GzFBaBSR4dn5i5jvhFaE8cR8E8H1Sr5E6Ku1l
 NXw5hRWcg6VvUAY88M76EJDAgrjFiWUtINbuC9Xd1I82ZRxeJ5tPYT7RxAvB1RhjhmgAGvdzqZS
 FLOgbagBd11O4nHxXuEsFJdE4Nw+GoJoFLS74N9Mcm8T31oC4PZJGkbXioL1ydPlPuVv7VT7ZnD
 bAFglxTcqxO2haCh+J4KhwQOyquWkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_03,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110158
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mburton@qti.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

DQoNCj4gT24gMTEgRGVjIDIwMjUsIGF0IDIwOjI0LCBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFy
ZC5oZW5kZXJzb25AbGluYXJvLm9yZz4gd3JvdGU6DQo+IA0KPiBXQVJOSU5HOiBUaGlzIGVtYWls
IG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeSBvZiBh
bnkgbGlua3Mgb3IgYXR0YWNobWVudHMsIGFuZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCj4gDQo+
IE9uIDEyLzExLzI1IDEyOjQ5LCBNYXJrIEJ1cnRvbiB3cm90ZToNCj4+PiBBZGRpbmcgdGhlIGFz
IHRvIENQVVRMQkVudHJ5RnVsbCBpcyB1bm5lY2Vzc2FyeSBiZWNhdXNlDQo+Pj4gDQo+Pj4gKDEp
IEVhY2ggQ1BVVExCLCBhbmQgdGh1cyBlYWNoIENQVVRMQkVudHJ5RnVsbCwgaXMgcHJpdmF0ZSB0
byB0aGUgY3B1Lg0KPj4+ICgyKSBFYWNoIENQVVRMQkVudHJ5RnVsbCBjb250YWlucyB0aGUgTWVt
VHhBdHRycyBmb3IgdGhlIGFjY2Vzcy4NCj4+PiANCj4+PiBUaHVzIHRoZSBBZGRyZXNzU3BhY2Ug
aXMgcHVyZWx5IGEgZnVuY3Rpb24gb2YgKGNwdSwgYXR0cnMpLg0KPj4gDQo+PiBUaGUgaXNzdWUg
aXMsIGl0IHdvdWxkIHNlZW0sIGl0IGlzIGFsc28gYSBmdW5jdGlvbiBvZiB0aGUgbG9va3VwIHBy
b3ZpZGVkIGJ5IGFuIElPTU1VIGFjY2VzcyAtIHRoYXQga2luZGx5IHByb3ZpZGVzIGFuIGFkZHJl
c3Mgc3BhY2UgaW5kZXBlbmRlbnQgb2YgYW55IENQVS4NCj4gDQo+IE5vLCBpdCByZWFsbHkgaXNu
J3QuDQo+IA0KPiBCZWNhdXNlIHlvdSB0aGluayB0aGF0LCBpdCBzZWVtcyBsaWtlIHlvdSdyZSBk
b2luZyBzb21ldGhpbmcgd3Jvbmcgd2l0aCBJT01NVSBhY2Nlc3Nlcy4NCj4gU2luY2UgSSBkb24n
dCBrbm93IHRoZSB3aWRlciBjb250ZXh0IG9mIHRoZSBxdWVyeSBtZWFucyBJIGRvbid0IGtub3cg
aG93IHRvIGhlbHAgeW91IGZ1cnRoZXIuDQo+IA0KPiBNeSBzaG90IGluIHRoZSBkYXJrOiB0aGVy
ZSBpcyBhIGZsdXNoIHRoYXQncyBzdXBwb3NlZCB0byBoYXBwZW4gZm9yIGNoYW5nZXMgdG8gYSBj
cHUncw0KPiBhZGRyZXNzIHNwYWNlLiAgVGhlcmUgYXJlIHBsZW50eSBvZiB3YXlzIGluIHdoaWNo
IHRoaXMgaGFwcGVucywgZS5nLiB4ODYgYTIwIHRyYW5zbGF0aW9uDQo+IGxpbmUgYW5kIHBjaSBi
YXIgY2hhbmdlcy4gIEkgZm9yZ2V0IHRoZSBleGFjdCBkZXRhaWxzIHdoZW4gaXQgY29tZXMgdG8g
SU9NTVUsIGJ1dCB0aGVyZQ0KPiBtdXN0IGJlIHNvbWV0aGluZyByZWxhdGVkIHdoZW4gdHJhbnNs
YXRpb25zIGNoYW5nZS4gIFRoZSBhY3R1YWwgdGNnIGZsdXNoIHdpbGwgaGFwcGVuIHZpYQ0KPiB0
aGUgTWVtb3J5TGlzdGVuZXIgaW50ZXJmYWNlLg0KDQpJIGFtIGFic29sdXRlbHkgcHJlcGFyZWQg
dG8gYmVsaWV2ZSBJ4oCZbSBoYW5kbGluZyB0aGUgSU9NTVUgaW5jb3JyZWN0bHkNCg0KVGhlIHNl
dHVwIEnigJltIHVzaW5nIGlzIENQVS0+U01NVShUQlUpLT5BZGRyZXNzU3BhY2UgKHRvdGFsbHkg
dW5jb25uZWN0ZWQgZnJvbSB0aGUgQ1BVKS4NCg0KV2hhdCBJIHNlZSBpbiB0aGUgY29kZSBpcyB0
aGF0IHRoZSBJT01NVSBpcyBwZXJtaXR0ZWQgdG8gcmV0dXJuIGFuIGFkZHJlc3Mgc3BhY2UgLSB0
aGF0IGFkZHJlc3Mgc3BhY2UsIGluIHRoZSBjYXNlcyBJIGhhdmUsIGlzIHRvdGFsbHkgdW5yZWxh
dGVkIHRvIHRoZSBDUFUgY29uY2VybmVkLiBUaGUgQ1BVIGtub3dzICh0aWxsIG5vdyksIG5vdGhp
bmcgYWJvdXQgdGhhdCBhZGRyZXNzIHNwYWNlLiBUaGUgYWRkcmVzcyBzcGFjZSBiZWluZyByZXR1
cm5lZCBmcm9tIHRoZSBJT01NVSB0cmFuc2xhdGUgZG9lc27igJl0IHNlZW0gdG8gYmUgdXNlZCAt
IHNvIEnigJltIG5vdCBvdmVybHkgc3VycHJpc2VkIHRoYXQgd2UgZW5kIHVwIGluIHRoZSB3cm9u
ZyBwbGFjZS4gUGVyaGFwcyB3aGF0IHlvdeKAmXJlIHNheWluZyBpcyB0aGF0IHNvbWVob3cgd2Ug
c2hvdWxkIGJlIOKAmHJlZ2lzdGVyaW5n4oCZIHRoaXMgYWRkcmVzcyBzcGFjZSB3aXRoIChhbnk/
KSBDUFUgdGhhdCBjb3VsZCBwb3RlbnRpYWxseSBnZXQgdG8gaXQuLi4NCg0KV2hhdCBJIHNlZSBp
cyB0aGF0IGlvX3ByZXBhcmUgY2FsbHMgZG93biBhbmQgZ2V0cyB0aGUgdGFyZ2V0X2FzIGZyb20g
dGhlIElPTU1VIHRyYW5zbGF0ZSBjYiwgYnV0IGl0IG9ubHkgcmV0dXJucyBNZW1yb3lSZWdpb25T
ZWN0aW9uLCBub3QgdGhlIHRhcmdldF9hcywgYW5kIHRoZW4gZS5nLiBpbnRfc3RfbW1pb19sZU4g
c2VlbXMgdG8gdXNlIGNwdS0+YXMgYW5kIGluZGV44oCZcyBmcm9tIHRoYXQg4oCmLi4gIEkgZG9u
4oCZdCBzZWUgd2hhdCBJIGNhbiBiZSBtaXNzaW5nPw0KDQpDaGVlcnMNCk1hcmsuDQoNCg0KDQo+
IA0KPiANCj4gcn4NCg0K

