Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFB8D3B7ED
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 19:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSgyl-0000HP-1i; Mon, 08 Dec 2025 14:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1vSgyg-0000GH-9w
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 14:32:59 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1vSgye-00082a-7b
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 14:32:57 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B8IlpNc008914; Mon, 8 Dec 2025 19:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=jFiGyjD0YDHKyJRRbyXojVwhdexvlYdLGy8K5U3G3IU=; b=Qm
 jTVrGWiRJAQtvtjEiaNO/n4n8vsx3kG7d33TlfbS+nYnMkKYxLcyIvYbuPEM18uz
 K8qHo3HyPomCoAq8clMtMhWQ8FaheGFMZ5sy8pkm9EAs1I8TlrXUnS1MEpd9hB00
 d5eBsOn100nAHYxmzyUrEQpOJQcLEmWRMAbHwwG1Qxi4/A0dMUi3TPEwtncp7BC2
 zV7GoMLt4TQPzb9lHl2PayXQCdgR93wW88W7PBWXLMG4cUsPf2TpipX6TnPCwVCT
 B4PDTr/QJMRpkZtsSshpm3MrC+S54mF9rgkRx8oxm6Wf26JPQ4OamXHnYo+QcIo6
 YjfFoLw3cwGLPSPZQpog==
Received: from ch4pr07cu001.outbound.protection.outlook.com
 (mail-ch4pr07cu00106.outbound.protection.outlook.com [40.93.20.102])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4awvke1nyd-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 19:32:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mh4ZfthT8iuyIUp7UERCkLe34wadJoT4QJct7IuZ25Sip74hsBFBb2c0U15artGn5s5dHveZhvvqUKFJ8Uq32HYfybcoQr23EvDDW8DchNYzBcFZKgQeaHvB1B9QwKLSZwSeKKMxlELSk2t0XLgQAoNw6vFhiY1Xgdh29+T7YhkvT+Xq3gcCG20rGAOSGvbXoAMJ2KCf53iIGbK66wg/bWF5bT/3ihapBTBZK0Xrv4CbAsBkCQ3mQy0X038q5beICkN1YGxNGoHq4qzQ7ygdZVPytD1Fuz4sBOsJCUPll6OcbDslBIDikmkn0RxE86qJ0tvIJQOQ9ue+ydh0rETb0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFiGyjD0YDHKyJRRbyXojVwhdexvlYdLGy8K5U3G3IU=;
 b=SNugvumyW0FleUeU0y50b6HahKbyRK67gHA4dTjzRrMqWNNBXTSKClbp61zwhiwepH3WmqWsF8YCSOZNZC5s3+ui+P04Q57Di9sBpfAODz9gpXJS/yJ3HtMdARcP9vjBaq5unXcdBx3RfcwuKJTf+VSEcwMgczAhOEOo8ESEbwU7x7s32x3CohjEjFcxDfpOnoOTPZsWlfB3t6E2a63PBOp+7GKYvDXc4agbMM/S7Xlm7XHf6pcNil6IodpfIQNkiUFlgA2R9POtdD3ITRl08SJmwOWVEP+2NGm8Ej/OvsmWaEsrFvQOU1FRZiAk/X36GV+aNaDly7KPTrq2AubbpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from CO1PR02MB8617.namprd02.prod.outlook.com (2603:10b6:303:15c::20)
 by DM6PR02MB6697.namprd02.prod.outlook.com (2603:10b6:5:214::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 19:32:17 +0000
Received: from CO1PR02MB8617.namprd02.prod.outlook.com
 ([fe80::5a28:4da0:a734:9bcf]) by CO1PR02MB8617.namprd02.prod.outlook.com
 ([fe80::5a28:4da0:a734:9bcf%6]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 19:32:16 +0000
From: Mark Burton <mburton@qti.qualcomm.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Sid Manning
 <sidneym@quicinc.com>, Matheus Bernardino <mathbern@qti.qualcomm.com>
CC: Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>,
 Anton Johansson <anjo@rev.ng>, Markus Armbruster <armbru@redhat.com>,
 Brian Cain <bcain@quicinc.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, "cw@f00f.org" <cw@f00f.org>, "demiobenour@gmail.com"
 <demiobenour@gmail.com>, "dhedde@kalrayinc.com" <dhedde@kalrayinc.com>,
 Eric Blake <eblake@redhat.com>, "eblot@rivosinc.com" <eblot@rivosinc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Elena Ufimtseva <elena.ufimtseva@oracle.com>, Auger
 Eric <eric.auger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>, Alyssa Ross <hi@alyssa.is>,
 "iggy@theiggy.com" <iggy@theiggy.com>, Warner Losh <imp@bsdimp.com>,
 Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 "jidong.xiao@gmail.com" <jidong.xiao@gmail.com>, Jim Shu
 <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Max Chou
 <max.chou@sifive.com>, "mdean@redhat.com" <mdean@redhat.com>, "Ho, Nelson"
 <nelson.ho@windriver.com>, Paul Walmsley <paul.walmsley@sifive.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?B?UGhpbCBNYXRoaWV1LURhdWTDqQ==?= <philmd@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 "wei.w.wang@intel.com" <wei.w.wang@intel.com>, "z.huo@139.com"
 <z.huo@139.com>, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "zwu.kernel@gmail.com" <zwu.kernel@gmail.com>
Subject: Re: KVM/QEMU community call (9/12/2025) agenda items?
Thread-Topic: KVM/QEMU community call (9/12/2025) agenda items?
Thread-Index: AQHcaFQXdHm6Xu2D/k2YYrlYpKHTn7UYIgKA
Date: Mon, 8 Dec 2025 19:32:16 +0000
Message-ID: <F4C64ED8-91E9-47C6-B51C-7B6929EE478F@qti.qualcomm.com>
References: <87bjk9hv4f.fsf@draig.linaro.org>
In-Reply-To: <87bjk9hv4f.fsf@draig.linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR02MB8617:EE_|DM6PR02MB6697:EE_
x-ms-office365-filtering-correlation-id: d43bf8a6-e9f5-4d31-b127-08de36907f22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?WWdqZTdVU1lpbDhaMGdBUkc2a0I3bEVwdjk1MDIxeHBxZldXczVvUTk1UzEw?=
 =?utf-8?B?ZEgvazk4TW9jdmxlRlljRlBSbnhxeldrTC9KTHg3eE5BeTh2WmpSUWhCVGUy?=
 =?utf-8?B?czJqdStqVzNNWlBtU1JXcEdOOTgrVTBOem8yWmx4RkpzTXhkVXY0eS8yZ2tZ?=
 =?utf-8?B?bWd6Rnk3M2JodXNyalhRTmNGa29kTTlla0RydzdzV0ZKbkgvcjVnVjdUUFFq?=
 =?utf-8?B?ZWtpYThUaHdSL2t0Nk5VRlZTc2ZnVFpWRStXdjg5eG5CQTgraUNzUnVsc28y?=
 =?utf-8?B?MjFkSEF4NnV1SkJyMW1nVWtITHFIWkcyUGcwNUNTNnJYbUo1KzVxNkhndDhs?=
 =?utf-8?B?OE5DQzRMZUhqakx6R0IwWGRZdkkyWThQd05FbWVjSms4dFFTWlVneWZmSjJu?=
 =?utf-8?B?SFNkdzcrVWFxZ1gvT2VPckRKQ3JLdkU4bFNCdkpwOEpFOVoreWxVV3kvS3JP?=
 =?utf-8?B?VEViTVcwQm95RXpVLzZUNXpxSURGczlKWkFTMDUyZ254c3dCVTBFUm51VnNM?=
 =?utf-8?B?OWZhSU5tRXB0blV1QTcxdHlpQ1JaZE9laStKS3hqV0ZZUmpJMTk1UVlaSjh2?=
 =?utf-8?B?Q3pVL0RzN3IyOXFGbzJCQUIxQXFMTWtHczdsNFZ2d3NDOUZBODZUL3FONFpn?=
 =?utf-8?B?SllwNlEyaXhyUEhlMERuWDEwRVl4YkMwcXlwOWE5Q20vb0p0VlFBWkdESUtJ?=
 =?utf-8?B?R3hGR1NleFkyTXhMVWtiRnY4cTJBc1pRbTVvOXlCQkNzcklhRnhjd2xvZFds?=
 =?utf-8?B?NTJHM1QxYVdmQlF4Q3lxNC9zMDhvYnlTcG5sOHFwZlg0L1RUMUpmSnhrRnZH?=
 =?utf-8?B?YXFuV2NhMXYyc216MzVJbUZFZ2NpQzBSVUVjMUNwSFVVZVNuOExjK05vVDV5?=
 =?utf-8?B?MWw5eWVrQjQ4WGhyaS9FaFA1S1N1Z3hGRWpkSlAzdGl5TTRxenR2ZHJwRlE0?=
 =?utf-8?B?QXo4ZCtDcmUrVVhCUkFsZUJ3dHpibTlHMURqam9mV05weWJTclVXZ20xdEN4?=
 =?utf-8?B?My93SGV4RXVtVkM3YlFXNHgwWHk5YVE2VnZnRnFWZW1KOE50dXhCa1Q3S0ly?=
 =?utf-8?B?NDUvS0dpREI1K1FHMVRhb3d3UWpGSGxmcDJDMVVGM0UxaWNSZUd2QWhYTXVP?=
 =?utf-8?B?MUJlMSsyYWVmeUVrcU9EQklxZkg3U3NIc0tUdC9VZExaNWlwK2YrQ1BXSHhQ?=
 =?utf-8?B?ZjJ4YU1HY3lnYjJDam5KRVFIb3htU25WdUNuaXc1Q3oxNjU1Q1VUYm5DMi9E?=
 =?utf-8?B?a0V5bmtSbElDZWlUM1lHTEZJTjdCajFIbE5zem56WmVxQ1JMSUhlcFRNODI5?=
 =?utf-8?B?OUw4Q09LanJzbDNDaVI0QnNrZEZxQ3VaR2JvOEJrNUZscEhQZGdHZ3MwdlNM?=
 =?utf-8?B?VWQ3alpjT1BnSjJKRHBuNDkwWXRKQkRrbmk4NjVGRnJwVzNmOXlpWW9uZVF1?=
 =?utf-8?B?bzBROWNHNXpPMWM0a3BQdSswVmd2T0ZhYWhnSTdZQklCcm9nZk8rWU9HOVAx?=
 =?utf-8?B?b0VqY3BSc01tMUZ0U1FuTlVBckNMSDZOMXV1VmxpeDYrTmFuVFpDOU9tQ0t1?=
 =?utf-8?B?TDBaT3o0NVp5YWk2aVc0SUtDeXZPdlJ4U3NGR3lJMVJyVHI1VDFZSW01VVYz?=
 =?utf-8?B?eVM1VnViYWdJT3NqWkNDbk9hQ2xwNjdVTTcweWxaVElXbDhKT1hFMHJQVkZt?=
 =?utf-8?B?QUJBQlI5YThFWjRqaUR2dkp6YW5mZWZjd3RaVFpuYng5YXNmRXdTY0d4NTV5?=
 =?utf-8?B?ZElkdUVTWDBiWURDOEV5c2tYTDQ1R0Rqcm9XeXB6Ui95TXdqOWE3WUlQeU1G?=
 =?utf-8?B?WHRFaDhhcFdkejFBbW5scGhtYURaRXl3c081QzlyWlo2RXQ4clJKTy8wUnlM?=
 =?utf-8?B?bzI5RTBRaDllVlUzRkd5V0dReWRPMVV2N1JybEhMK25IcGR6ckVUWFFRVGti?=
 =?utf-8?B?QmlsSGw1dTZWMitEWXNBa216cHgzZVp2eXJvQjNaaHhhTzVMRGpkUXpEQ2Zx?=
 =?utf-8?B?S0p3Zk1WM0RXVTJmOEtTczNYaHpxMG16OFNPckZoN1FBV1NQeG9ybHY3L1Fo?=
 =?utf-8?Q?300pNL?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR02MB8617.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2ZWRjY4L3VjTk1vM2tRcVpLZHlKaDcvMUM5VGMwUTd1NU1rU2Nkc25pRTlB?=
 =?utf-8?B?SG9FeTA4V1Blcm16NURnR2ZPbzdsWjJLUjZlS2xkT3pJa1dJMEc2K2ZIODFs?=
 =?utf-8?B?L3FHenNtZXZVWlF3YVFIL2RZZ0VncWVyZEU1SXdqYThqMlB2YjVETDJ5QWhT?=
 =?utf-8?B?TkdFbTl5dTV4YWFrbVNhU1pOajZXVEV5blZCa3pyQkIwVlpjd0R1SXRBMlFT?=
 =?utf-8?B?TElJeTF4MnVudFA3WXZHS1FwbjhjaW81NEs4S05LZlZTZDVXeXBib2pzVy9o?=
 =?utf-8?B?TDF2TE9zMTBlQlU5U1ludGxnUHUvVXdod1JnN1hwbkdzanJMeDFOZkYzdW51?=
 =?utf-8?B?TDFZMkVjd1BORkdmNTFPdDJzZ1hUSWtuaXE5S0hlRHBSSGM5MXE0TEJJcVQw?=
 =?utf-8?B?Y1JleXNaR3VjanY3OE9zTUZjZnlWd3MraWw5VHlVNFI0cFJmaUs3TndMTHhR?=
 =?utf-8?B?STNVMXRoaVV6VE9ua3lxSnM0WVUxUUU2S0cwTEsrZnN3cEhvMlBkcFZVQTZN?=
 =?utf-8?B?NDV3QzRBMVpuNVluOTArRSs4OFdXaXFCZ1VneFpURXJKQWNoYTRVOHIwMlBU?=
 =?utf-8?B?S0o3RFNwRTYxeWhnMHFxSVlHMVRMdk5OTWZIeEl0WVNFelVTSGFrVXZvdGZW?=
 =?utf-8?B?VTk2K0ZpaHcyZk9jZ0VERUxEWlZtMUxXNG1ZNkxHVWgyQ1JvcnExcUdDbWlU?=
 =?utf-8?B?YVRieDJGVWkvVEEyNzVmQ3I5Tk1wN2ZKWkZodndFNG1peVBYUUNkV0p0bHlX?=
 =?utf-8?B?OHZNNzZockNHd24wSXBCNjBhNll2NUhVQVdVUTQ1VDJpREFzdXVLbVgwU0Ja?=
 =?utf-8?B?UFZkdTZORGQwdXFTQ0RueUdqQm8rQzFFMm95bFNwRDNsVGdNZytiVlNMY0d4?=
 =?utf-8?B?ZmlEUVpLSjdsSmJxNSs0NEFyQ0czUFkxYnFPdXJsaXlvU1ViV0t4VFdUczNL?=
 =?utf-8?B?ak93MUthT1o2TnQ3cU45cFRYTHpyMTZCMjlrR0ZMMDFHdSt3SWdPRU9KSlda?=
 =?utf-8?B?c0h3Rk1xMUNGd3F2N1JkNEZ5Y2QrdlAwWlhWRXN4YlVJb1N5UHE2endJbE9K?=
 =?utf-8?B?SUtpVVhEUzVkT2VsTUluYnA3ZXJNZlUzNGhCeGFnVEZBcTJCYk4xaWZnZ1ZK?=
 =?utf-8?B?NHVoQUh4T2pTY3k2SHh0NnlGamdHQmJLRzZ0SDl6R0doMy92NjVSNjdnWTBl?=
 =?utf-8?B?NFZLUTBZaERFR29PMFA3cmFKSEs0Y3Z0WDk1d2c0a0cvZlFHc0JwakU0ajNC?=
 =?utf-8?B?ZEpZWUloSDZWS3h3N1hXdDAvbTIzb0h6UjZTaHhRWnhUWHNjczlkaGdmbHFk?=
 =?utf-8?B?RGpVMzZHbnc0b0U4TUZOWHM0K3VvSmxLQUd2YWwxeHUwTjBPR0hHNnhHNkNX?=
 =?utf-8?B?NHlZaGRiYmdOS0pOUGpTTjVxK29mb0w0UHNoTjZjWFY3SHc2RWxFVGh5U0Ry?=
 =?utf-8?B?NFFBZ0w1OHhUdUtkcytSU1IvTHBqM0RjdjdpQlB5clhWZm5wWlh2RG5QU1BV?=
 =?utf-8?B?RFNBdE82aUJFYnhlOWM4N0RieWxsZ1poNXByNkgxWjNMS3lRM2VOcXhLYUd1?=
 =?utf-8?B?aXVPdlFIaTl3VnpzUnJvVy9pZm8wdTFXbUtaOE1XTERFb0J5eTBaM0QvbUd2?=
 =?utf-8?B?ZGU3VUpqTWNnN2syTWQ0dzRSQXI3a1ExdWNhYkRUcWJIVkZncFdDbjVORXFm?=
 =?utf-8?B?M0d6a3RSTWVsTG5oRW1aOGROVnRrdmZzSDI5cm1tRmhnQlhMeDFaOVZ1cHhM?=
 =?utf-8?B?OTV0Y1gya0E2L0VqcHZuSFN6c29KQTJtRDB2SEJPMEtCSnl6UWdyZGVWQWVR?=
 =?utf-8?B?MUkrU2x1QXV3dHc5YzNsZ0U2cUFhRHNza1dVNlJlR0laMGpNVDRDT0pBZFVB?=
 =?utf-8?B?NWV1TVYyc1JCSElodGhJbWdDeGxDUUs3SkdEb1lsRHM4T0NMTzM2UDBHVXMr?=
 =?utf-8?B?SXBYOXF4UVJXaDZDakcxbXZuakVielhYUWhWTjF3K3ZCOWZkVGM3YXFIbG41?=
 =?utf-8?B?UUYrWUZPWVo2cS9mZnhvb1l3bnN5Wk5QSnFXaVhCdGZxc3I4ZFJESWNyRzhR?=
 =?utf-8?B?cW9CN1FRMGlwQyttNUlWcHV3cWNua1owZ2k3QXNYTzJ6TXpWMW5SNDRKbkhG?=
 =?utf-8?B?eS9TdHhIc2NXbFYzdGFPbjErcDJjN0xRbU12OTNVN1cwQ0VJOGhXRE5uYnQ3?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06A7E559245FBF43BA874FEAE2702C02@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: S6j3s8gVpZOZXWnHK7s9IkYGVG9+gHh5UJcVENOUoxcQ3uWuVPRI/lTwXHJKnuIouJnuAuKerfQ6CtkB96vKoBhncHDzKyqPYJCdMXcbD/kHVVpN/IyBxaFZVEzoUX7tIQcimNcGbaDgp2Jw83xFAC9GA1K7y2ofQhrfe9NSIJz2ZZMhEI8g/OBqJjfXuG94dTIUPBmQOm+g1Px/KzI3J+qP8szaCRQyuPhdeA1gunF3madWyAKRoHHWRL/vrvS4PnCMpqLa7UEcWkUuIFHnYRI2syiQkoegyruBfwIpn9lNfSFUD0ZoJ9129wsH2p/ggZexZ6gcmW5Sb8mMVvfRtBaBPkSRtHEkz3jRw/wIMA/5iRUPhFsxkvJukUx+I3FofwhO2EeyOuUMBAOVhar5kPwMFquN2SnPmOOftaHIs7PgKYYVZKHZ1SY2SwU8FXyGM+/bcSgmhN8yLVnSDNhK5iYtBxrkygCIfSRH9ZwLL8YGMess17E6tkXV1m1T0pViAO8u5EzofnuCj2JtznUOkOc9GfiY0xH3hKkk7YQDsBYoegl7ynUbnw+9cq3+jC6XJoMyF996tI1Ob+tGn8dJZhqffQJ5T5cHALhwwPMGGmM+FY1oiIpQR5L7wcbeOAyQ
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR02MB8617.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43bf8a6-e9f5-4d31-b127-08de36907f22
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2025 19:32:16.8984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bAheTDKN72JgTEF21iBBMr43MnomeOnoKP7y9juG9pgrT4jb0oB+mVG65j0QCqIXen6K5WTEqW+GoIc4gSe3JDkxAHiuSZUYb0DwDEFoCmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6697
X-Proofpoint-GUID: PRkkYOQwEGKJrx7xaiPe_h7JqF9YpH23
X-Proofpoint-ORIG-GUID: PRkkYOQwEGKJrx7xaiPe_h7JqF9YpH23
X-Authority-Analysis: v=2.4 cv=UvBu9uwB c=1 sm=1 tr=0 ts=693727c7 cx=c_pps
 a=NmAR2pCDCROe7PQXUXaH1Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=nXA5WNwiAAAA:8 a=KKAkSRfTAAAA:8
 a=-aPEJqwakmsKeLF5d2wA:9 a=QEXdDO2ut3YA:10 a=fGr-7aqQv4RST94IA8XU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDE2NSBTYWx0ZWRfX2C6BV71aEMjK
 FgQRqGnpp8DCj+wism44hOioBOuiZLNgODB0osSqmrDnkuDgElwdvJn1YfaK8JjTefIaw8bGqAv
 g2PWjuH5Z+eBSc5nihobDcZt0utsZzGnT4GUFibBHkUe0rX8tSRXs3AHafAXbDDHiukQCVm8Z24
 0V5YedW2qrU+6ywf4CbJueJ9UX5dKEMWiRWkpZVlpEpMtW24S0ko2VEwU1osekhJhUUJmMWgid8
 l0VbHNEihrAkACQRded0yKTdaql4TNTfEp1e3swWvrETqWdZUg8CGT+lx+l5LkRNaa1suKHE1fD
 ztS3czV4fIQuR2d1j6MyrcMuUvqfO0BQ75x5MRnSZxYxV8NjXsUY4Cnc0oL35+I51DPqMUSbUIG
 LV5QgSafSnyWlYzPJCzimt/d2nRPQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512080165
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mburton@qti.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

SeKAmWQgbGlrZSB0byB0YWxrIGEgbGl0dGxlIGJpdCBhYm91dCBob3cgYWRkcmVzcyBzcGFjZXMs
IElPTU1V4oCZcywgTU1V4oCZcyBhbmQgc3R1ZmYgYXJlIGhhbmRsZWQgLSB3ZeKAmXJlIGhhdmlu
ZyBzb21lIGZ1biB3aXRoIHRoYXQsIGFuZCBJIGhhdmUgYSBmZWVsaW5nIG90aGVycyBhcmUgbG9v
a2luZyBhdCBzaW1pbGFyIHRoaW5ncywgc28gaXQgd291bGQgYmUgd29ydGggbWFraW5nIHN1cmUg
d2XigJlyZSBub3Qgb24gdG9wIG9mIGVhY2ggb3RoZXI/DQoNCkNoZWVycw0KTWFyay4NCg0KDQo+
IE9uIDggRGVjIDIwMjUsIGF0IDE2OjA1LCBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFy
by5vcmc+IHdyb3RlOg0KPiANCj4gV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20g
b3V0c2lkZSBvZiBRdWFsY29tbS4gUGxlYXNlIGJlIHdhcnkgb2YgYW55IGxpbmtzIG9yIGF0dGFj
aG1lbnRzLCBhbmQgZG8gbm90IGVuYWJsZSBtYWNyb3MuDQo+IA0KPiBIaSwNCj4gDQo+IFRoZSBL
Vk0vUUVNVSBjb21tdW5pdHkgY2FsbCBpcyBhdDoNCj4gDQo+IGh0dHBzOi8vbWVldC5qaXQuc2kv
a3ZtY2FsbG1lZXRpbmcNCj4gQA0KPiAwOS8xMi8yMDI1IDEzOjAwIFVUQw0KPiANCj4gQXJlIHRo
ZXJlIGFueSBhZ2VuZGEgaXRlbXMgZm9yIHRoZSBzeW5jLXVwPw0KPiANCj4gLS0NCj4gQWxleCBC
ZW5uw6llDQo+IFZpcnR1YWxpc2F0aW9uIFRlY2ggTGVhZCBAIExpbmFybw0KDQo=

