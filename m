Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC5FC531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 12:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgNcv-0001L3-Ag; Tue, 20 Aug 2024 08:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sgNch-0001Jz-Eu
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 08:06:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sgNcd-0003He-Hp
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 08:06:02 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K74Buk012878;
 Tue, 20 Aug 2024 12:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lm9f38rVv15/5bgLBXlLNZW8KjzRM8Ubvdq/eZfS5dI=; b=YLjePKD9uXn70jpl
 eXR3sK1VthSeZe+ZvYeb5hbWf3bZlWsXYPydNewRKh59y953DeRyHN+/I+N5XuDn
 wgX3gM8okg90u+WE4NrSBcVAXBD13VQQIGs2OVqjEcQEBWbOYSxliocymXj5uJoB
 xjWUWqqXtbNuutm9lOVAX4nhBvaJUIkw+7V1nBbCgAcy6JXnI2GZ6rFPgwz1pskt
 LrG+IekIkq7ylabYB6z+DqjSkc8ceeKweeVkdzFnWaL/8mI0pjtVygWLLawpPkQj
 DAiwtpW76FvfhU+D2KKATbuaNKheQjkZxR9fP6rJ7Ap0GtAej3VXPWna/50YaDNN
 MSZtUQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414pe5gwdu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Aug 2024 12:05:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSXwAtyeYBhqby9cfj84r9m8CguSGfggXzdIvD29V2aKvvtkzI5m8DLpgiKKYSyf4zcPPiL2n+2LWNEIeghq2q30OiYFEuXzAJklC4ADwqqgwEIWyDwo0xDJx3DgTXPnOz315/sfXYd+S31Syk0U3KGHNP3lnLRfl75aARfOPp6PA2JmF5zJvGaQhyX6nq8IZWl2BH1Q+9PUCj8gb5NB9yfEtr6a2CgyyyCdtH3/Fsm35mqWMSHoLn7/YqejfYuWZbnP0kp3u2AHTQ5Ub2xNqODw1RHgIPpf7kaw6cctsxwrnP1VzX3EiYbtxdhjTYJx9scCVfGDZ2tkJqz1mgSugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lm9f38rVv15/5bgLBXlLNZW8KjzRM8Ubvdq/eZfS5dI=;
 b=WdNZtFvJTzJnEbug969gSazgQbfQHRr/REm9MfMSaVqLJ5DZV2kNljJISXSlCmFRs5f2PT0Q6vnIpaeSl4C6tkMf1/2vdidZK1MXTajMK2ydPu1vPv3nR8RV2Xs8ggKl5FyloUG0l1Odcm/nJHthPd2tsq9IijNicw4BIX5qzRBaK9rYrYXZi+v7Z6z+Z1fSZEced1VXAuOE9QYAbr+jJD70vgL+3s+0wEchS8wvIBa4Q5aKT1+0WOoXYuHMXXWW2ASOmA6NjAVP5xWxHYmHrqtHgWz8ygiIo9HjqZufGU4+Gdj6/XZck6Rumb9UkvG388REbHJB/yppcsr6r+E/HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by BL3PR02MB8052.namprd02.prod.outlook.com
 (2603:10b6:208:35b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 12:05:02 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::2980:17c4:6e92:2b11]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::2980:17c4:6e92:2b11%4]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 12:05:02 +0000
From: Brian Cain <bcain@quicinc.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>
CC: Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>,
 Anton Johansson <anjo@rev.ng>, Markus Armbruster <armbru@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Chao Peng
 <chao.p.peng@linux.intel.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, "cw@f00f.org"
 <cw@f00f.org>, "dhedde@kalrayinc.com" <dhedde@kalrayinc.com>, Eric Blake
 <eblake@redhat.com>, "eblot@rivosinc.com" <eblot@rivosinc.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Auger Eric
 <eric.auger@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>,
 "iggy@theiggy.com" <iggy@theiggy.com>, Warner Losh <imp@bsdimp.com>, Jan
 Kiszka <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 "jidong.xiao@gmail.com" <jidong.xiao@gmail.com>, Jim Shu
 <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>, Max Chou
 <max.chou@sifive.com>, Mark Burton <mburton@qti.qualcomm.com>,
 "mdean@redhat.com" <mdean@redhat.com>, "mimu@linux.vnet.ibm.com"
 <mimu@linux.vnet.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?B?UGhpbCBNYXRoaWV1LURhdWTDqQ==?= <philmd@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Bernhard
 Beschow <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas
 Huth <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>, "z.huo@139.com"
 <z.huo@139.com>, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "zwu.kernel@gmail.com" <zwu.kernel@gmail.com>, "mathbern_quic@quicinc.com"
 <mathbern_quic@quicinc.com>
Subject: RE: KVM Community Call (20/8/24) agenda items?
Thread-Topic: KVM Community Call (20/8/24) agenda items?
Thread-Index: AQHa8u/7GvltHWCZ6kGxebiSOGOPsbIwC6GA
Date: Tue, 20 Aug 2024 12:05:02 +0000
Message-ID: <CH3PR02MB10247DBEB14E15ABB0614C2C9B88D2@CH3PR02MB10247.namprd02.prod.outlook.com>
References: <87jzgbmpe9.fsf@draig.linaro.org>
In-Reply-To: <87jzgbmpe9.fsf@draig.linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB10247:EE_|BL3PR02MB8052:EE_
x-ms-office365-filtering-correlation-id: e4153d5f-a3a3-4f6a-3858-08dcc1105275
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Q1dzYXBmMnMzMFBWNmdWNGNpcUN4N2VHSEJpUU1TUnRZWVV0SmNvQlg2Y3k0?=
 =?utf-8?B?U3BRU016K0F4L1dPalo0b01naVBCbGd2K3RGcWdrZnlrLzdBVWF3VkNYcUM1?=
 =?utf-8?B?RGVmQnhMcmhmN242Qko2bnFtRk9ERVlmbHo3L08zTHgvc1JCazIxc2ZCcU5r?=
 =?utf-8?B?VFdVNWRYcm9UOHljbStxNGhKTlZyV1M0S2xWc3FBbit2VWo1bGNUcFM1ckNm?=
 =?utf-8?B?Yzl6N3lNQXJKbzBhVTVBQXlmUEN5SlBWaWhOcU8rdjZHc3lCcGVEMXlXSzV1?=
 =?utf-8?B?UmtXclZtazYyTG90dHhVY3RVblZoMlJqdEN3SW91eUNlVzE4RHE4MEV1RGds?=
 =?utf-8?B?NXk1VEtxR3FYMUsyMTRFWndQUXZPWjhsQ0FQRnNRbzM3NmVURWQyTGRkaWpQ?=
 =?utf-8?B?V0krTk5kdHc2ZGJudWxqUXY3SWNudEJ5TnZVZERZblZYS01XSG5mNzJoYml2?=
 =?utf-8?B?Yys1cnNjNUpHakREbTNCYllkdDJQY0c1bXNnYnBkeFVxSkM4djVZNU01ZnB6?=
 =?utf-8?B?M0Z5QUxSOGExd1BSSldBdldSRWJ6d1pHNEQzS1BqSXFUT1FaTUgyR1pIUzlS?=
 =?utf-8?B?Vjc5bU9RdEE1SDBhdm9CSFg2RkZneXRXZG5ldW82QlNHdjBYMFJEblVTWmVZ?=
 =?utf-8?B?WTArMUoyWWFablh5T2h6WThIVmtUQXluejBhZ25DMlBJSlZSMnBjZ1lxUXQw?=
 =?utf-8?B?Q09Jb2JldlpMdjl3UStyYTA1UnovQzlOSUhmamtzVUd5aVorajZPaDhlYjFG?=
 =?utf-8?B?SGN2SlJDTmRIcGpLdFlsaFBiUnB3aml3VGE0blAvYTJqN3pQb3ZmMGIwTGgw?=
 =?utf-8?B?STZoUGVSeUE1dVpvRURkWmx0YnRteUNCdGNjNGcyeXJNcVIyeko1MDRUdE5s?=
 =?utf-8?B?N2VpalltK2J4WlR2TU1RM0d3aUdTK3Bmcks1NElydnFVVHI3UEV5WktqSW9K?=
 =?utf-8?B?bjJWNjk0N3BMN0dqYjdSckVEOGdaKzlxbVdNUThQcUxqWCtXeG0xdllOQXRF?=
 =?utf-8?B?OVVYSmhlbmIwRnFmamFFSm00SDcrRGxFWFAxb2xXcWxpVFBMQ3BSSThEUXFQ?=
 =?utf-8?B?SmFuQWo2czFYWU16TWN1SnNMbDdrbXVZY3g5S0dlNURZUW0rajRjcThVRWlx?=
 =?utf-8?B?TU1pZWpQT3VvMkxwbzNoKzd5RUZSVlFXT0VZNzgrMEhkMUg2SjVJYktqK3B3?=
 =?utf-8?B?UmNodHFkZkpqT0Zvb3k3c28vMFlMenlHSzVkaXpsNCtIVmpOR0x1NzVOWVBO?=
 =?utf-8?B?UllYMjZBQnpWc3FRMjR6ZHg0amdwTlRMYS96NVRycWJOb0R5ZS9tVE5QbVZp?=
 =?utf-8?B?MDJWWDF5aFBzYjk4OGY2RFhDU1AxOFM5dC8zT1k2UmNSVTZST1dwRm5IcTEr?=
 =?utf-8?B?Nk1jL2s2SWFlS09GNlYxYk9EcHNvb0FLb3VNVEZaUlpBTnlGTS95amQ1ckQz?=
 =?utf-8?B?L0Jkam5JOU1yRGd0MkVCWnF1MGpFemZDeEVTTW8vY1Racm0yOFNoSG5DZWlO?=
 =?utf-8?B?VnhEYkhJZHdrVStJWWdaTzMyR24vTDdhWEk4bmhEaW9BWEVnUTFhL1ZsRkxt?=
 =?utf-8?B?aUxZaVlLdkhUbjNlaWorTEFwek5kbXg4aGlsZmxETkpFbUxERHJRckJLYzNp?=
 =?utf-8?B?Snl4R1BUM0gxOVpobURZUElDazhqei8vaEhFMFZQTGNkSUUvc1ZiUVZnUDJK?=
 =?utf-8?B?WDE4L09lQnZrTGwzSFJ3c3NVMlFJSFhvRjhyWXJlNUlvd3JqUGJrQ1pGMDVB?=
 =?utf-8?B?S2wyUEpDTWRnRVVJKzNlQzBPQVdhN3NLaHluZnhXUVk4SldYemhKTkE3THhR?=
 =?utf-8?Q?3yz7KPm1pDNae/ohV2lT5SIQbjeGO95U+fvU8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR02MB10247.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWFxZFNBOUJQQ3lVa0RhM2dkcTI4L2ZNcm45OTdrQmpFM3V2TW9EL3IrUmNj?=
 =?utf-8?B?dXpFRmV2dlZ3M2xjbkxRREFORzdjN2NGL1hVZlpRVEJKUkxkeDVRMXEwNU9q?=
 =?utf-8?B?eEFRRjVVY0JxNU1QRTBLeFBWWnlKRk9uTkFqRmc4R1V1TXFwZ0gzcFFEanF0?=
 =?utf-8?B?N3k3b3dwV24zSmRUOHhicXpJZUJjZVZyQUVpZkxyWVJOS2lXajBQNENCQTFW?=
 =?utf-8?B?SU1Sek43L2liYTN3eVRCNEF0K3ptWDlBdURXNjBKWFdYdFZJdHorRDJLWWFz?=
 =?utf-8?B?dG00Q1Zhc2ZwRzlBdDhhT2g2NUQ4VzNzTGpaUHhHSnRER3JYNW1ZaUhXc1hm?=
 =?utf-8?B?ekM4a2VtZWxPaHEyMVFnNGpYWWZwaU41elBoRW1VY0cwNmptcWlaamFQVnNF?=
 =?utf-8?B?UlptMnBOckx0Q0VEcTdSNERjTjBOVWpzRkRpMWtHR2VQNnZRMlVzS2ZtOXA4?=
 =?utf-8?B?czBoKytrNDdDZ1FoQksvQXk0OU80TlRGdFdHK1VtNUdlOHpaRE94SnIySnA2?=
 =?utf-8?B?ZkVMSzQ3VHRrNDgzY1lYZ0h3NmpuazhHaDVycUxuUmhVbzRveWNCTDRkY3lC?=
 =?utf-8?B?OUk1QUpqSVVaOExWVjhwbGRWTFFhNTRrSGx6NnpubjZLSldBR1pFMk01bytv?=
 =?utf-8?B?bzNtTFgvTThidXlscDBpdS83YnFjdXM3ZWdPKzlOWGNxTUJWV2hSZjhxakpw?=
 =?utf-8?B?VWJVWEZnaDdTZzFKVXJCQjRsSmFKZFhJU0xhd0xFN1YrMDNRdlJmVUhHZmNo?=
 =?utf-8?B?b1ZHTG9mMHltdVRNcnhlNVFqY1JLcm4rdzNuOFlqRkdldk8zV0ZFNEVPNVhY?=
 =?utf-8?B?dUFqOE42dWRHRkF3UjArK2E4VmVDNWUxZGF1OFdqMEI4N003cEx6RUR4VnRp?=
 =?utf-8?B?aUpieFBUc0FicDZYZjlOd3hoYk0rclViNmZjQ1BLR0dKYWJSQ0pSUGdyYkJW?=
 =?utf-8?B?LzBVdzJBRXo0QlpBaFpzZmQ4VDJ4OWNWREJ3L1UxY3VFQ1IwTDdCZnJMNy9L?=
 =?utf-8?B?Q2hrWFZUczErV293THp0N1RWUVpWVE51TFEzTGFrNDVJL3l3MlVXcE44V0No?=
 =?utf-8?B?N0FWVWV0cEZDbjFRY2U2ZXJPRThPcTVabWNETTZEeU53QUtEcVF5QndOZEIx?=
 =?utf-8?B?dVUwbjgvWFJuelI4ZVpGNi9zZHRxallWVElaaWwwOXhCWUk2MVZtMWtPUGVk?=
 =?utf-8?B?Mk9MbEkxOGVJN2ljUFZTOVc1djk4RklhMEZFeXZwdlNkb0lITnVDNjA2ejh5?=
 =?utf-8?B?SUVwYXdwSEtxeEh3WXFsVnYxY3dQNXZ1a2piV0o1VVIvWUdVU1VhbEpvV1V5?=
 =?utf-8?B?S2tTVmNrNFBTNndoak51UkZyWGw3ckF3Tm1qNHZ5cGIyTlBPQkp4NmN2c1Zr?=
 =?utf-8?B?MXJxVmczb1cwc1pPWUxWMXRmK0hRWjJCWDBtbTJxU3o0U3pkNjJXWWg4ZXY5?=
 =?utf-8?B?cmo0dWZRTElnWUp5eEpkQUMzWDZkbDBhaWxDYXAvWTViQTJmcjFVUTU2emZ2?=
 =?utf-8?B?SUE5U1FWVTcxTFFJR0MzbHo3YnpNLzNLalcwdXhPZTRQTWsrSm13d1RvRnpo?=
 =?utf-8?B?bE1vT1JtYjA1Mkw5SkplUkJNK0pZMXUyRFg1UjZ4VEQ1OVFNZ3ROTjhCanBS?=
 =?utf-8?B?SUxGUHlHVjZOdk04anJRU054NUZ0LzRvVjkyeWkxZGR4L3dNMVRZSmtFZFB4?=
 =?utf-8?B?bG5nS1RtNGovZEVyNk9tT1B4L1cxakRmVkVMckZvcXhyYjlHOGRKMGo0SVBp?=
 =?utf-8?B?Q1pndEN0RTUwamVTdHRKZTBGeUVzeTVXQ09TMmp2TmZleklub1l3dVlaTUR5?=
 =?utf-8?B?US9qelNCUXpPSmJVUDhOZE1aQlVkK3NnS09zbDBJS0lPRDlDSlphWDNmd3My?=
 =?utf-8?B?UGZJL2V6VWhJNkhYVzNqQjBFRVlFeTFwZ04vSjdFcndoTG9NVW9pY0MrZWdH?=
 =?utf-8?B?Vjk2WTZ5c3p0S1RuWU9qTGwvdThsZ1hMUWwzWndUN2VweWV0c20rWDBjUGg1?=
 =?utf-8?B?NXFGUkxoWngxYkltblppbGpBNjJQZTJwdU16ZjQxUjlrVVFaK0FIcjdTM25o?=
 =?utf-8?B?OXJEbUt4UUVJbXBxZHBrOEcvanZaRWhhYi9CUmVveXgvVG8zY0lUV2FBOHho?=
 =?utf-8?Q?g89I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vaF6PItP0a/sjqlGW6fX2wGDrmfp24wQLvrCRhWFdEeiqk7KS4eYfYLFmN5h6DKs+27HIMWW+YNK5N/XW367s7kLY5jx5NeIIb75ap/zTdMklTrdQd2iblSMndmjH6iwblkBrdV7MceD1wSNVTRKWwOBdN+NUQTc0u7hr10/9sAUWdjQZTW79JWzxn5aYi+Mw7vMIbR9tk3bl74k/qwpMIm38uAl8el/bmi6+pgJzGv/F9nF/A4/QfXPA+XctAM1aKr34p4PHFmQoctz2FNdOntK8HrBBbWUmB9Ee2Cj5gP4txKNGFWskq/47OGCcD2IuFiJNVkXpsDXzB+dlbbGU3nzCf9WhV5AKfx4MaWHibbZzGJ2F9Us4RnGq5Ioy0/HXnXjT94Qz7ltjsPR0f2m1MTrrGo/G8+oRyWnVW+Ht13Yv44+cU7cHPsbgD7IBYwvw/YSZqSIceEVlnKZtS4ZXNxfXIKgKaTmckm3pa8FJMjXVthyI2gewlXGGinogtEJO0aqpY9zEmMb35u1QIp54x/JHkXj3YoqMuCsFok1qDmMrFEIWl79kE+Jn18KTXKS1ap3vnREDuyq96dehL3VyzyD3El7T2SBXzZO8GvBKtMQutAL6z93JSTdfK/9vi73
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4153d5f-a3a3-4f6a-3858-08dcc1105275
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 12:05:02.6694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e4HkTSjOAY5umAoEg8c6Gjyx3O+ebrHzK4+1gkoVKsKyjJyt+KtIoetj5d1fFDHrf6BVGtyWxYkWOA4xIGP0qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8052
X-Proofpoint-ORIG-GUID: QJInTizMOYro7Qb-eQE1YsDfksneAVJc
X-Proofpoint-GUID: QJInTizMOYro7Qb-eQE1YsDfksneAVJc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 clxscore=1011 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408200089
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleCBCZW5uw6llIDxh
bGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMjAsIDIwMjQg
NTo1OSBBTQ0KPiBUbzogUUVNVSBEZXZlbG9wZXJzIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+
IENjOiBBbGVzc2FuZHJvIERpIEZlZGVyaWNvIDxhbGVAcmV2Lm5nPjsgQWxpc3RhaXIgRnJhbmNp
cw0KPiA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPjsgQW50b24gSm9oYW5zc29uIDxhbmpvQHJl
di5uZz47IE1hcmt1cw0KPiBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT47IEJyaWFuIENh
aW4gPGJjYWluQHF1aWNpbmMuY29tPjsgRGFuaWVsIFAuDQo+IEJlcnJhbmdlIDxiZXJyYW5nZUBy
ZWRoYXQuY29tPjsgQ2hhbyBQZW5nIDxjaGFvLnAucGVuZ0BsaW51eC5pbnRlbC5jb20+Ow0KPiBj
amlhQG52aWRpYS5jb207IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+OyBjd0BmMDBm
Lm9yZzsNCj4gZGhlZGRlQGthbHJheWluYy5jb207IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQu
Y29tPjsgZWJsb3RAcml2b3NpbmMuY29tOw0KPiBFZGdhciBFLiBJZ2xlc2lhcyA8ZWRnYXIuaWds
ZXNpYXNAZ21haWwuY29tPjsgRWR1YXJkbyBIYWJrb3N0DQo+IDxlZHVhcmRvQGhhYmtvc3QubmV0
PjsgRWxlbmEgVWZpbXRzZXZhIDxlbGVuYS51ZmltdHNldmFAb3JhY2xlLmNvbT47DQo+IEF1Z2Vy
IEVyaWMgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT47IGZlbGlwZUBudXRhbml4LmNvbTsgaWdneUB0
aGVpZ2d5LmNvbTsNCj4gV2FybmVyIExvc2ggPGltcEBic2RpbXAuY29tPjsgSmFuIEtpc3prYSA8
amFuLmtpc3prYUB3ZWIuZGU+OyBKYXNvbg0KPiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsg
amlkb25nLnhpYW9AZ21haWwuY29tOyBKaW0gU2h1DQo+IDxqaW0uc2h1QHNpZml2ZS5jb20+OyBK
b2FvIE1hcnRpbnMgPGpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb20+OyBLb25yYWQNCj4gUnplc3p1
dGVrIFdpbGsgPGtvbnJhZC53aWxrQG9yYWNsZS5jb20+OyBMdWMgTWljaGVsIDxsdWNAbG1pY2hl
bC5mcj47DQo+IE1hbm9zIFBpdHNpZGlhbmFraXMgPG1hbm9zLnBpdHNpZGlhbmFraXNAbGluYXJv
Lm9yZz47IE1heCBDaG91DQo+IDxtYXguY2hvdUBzaWZpdmUuY29tPjsgTWFyayBCdXJ0b24gPG1i
dXJ0b25AcXRpLnF1YWxjb21tLmNvbT47DQo+IG1kZWFuQHJlZGhhdC5jb207IG1pbXVAbGludXgu
dm5ldC5pYm0uY29tOyBQYXVsIFdhbG1zbGV5DQo+IDxwYXVsLndhbG1zbGV5QHNpZml2ZS5jb20+
OyBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPjsgUGV0ZXINCj4gTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgUGhpbCBNYXRoaWV1LURhdWTDqQ0KPiA8cGhpbG1k
QGxpbmFyby5vcmc+OyBRRU1VIERldmVsb3BlcnMgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47IFJp
Y2hhcmQNCj4gSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPjsgU2hhbWVl
cmFsaSBLb2xvdGh1bSBUaG9kaQ0KPiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWku
Y29tPjsgQmVybmhhcmQgQmVzY2hvdw0KPiA8c2hlbnRleUBnbWFpbC5jb20+OyBTdGVmYW4gSGFq
bm9jemkgPHN0ZWZhbmhhQGdtYWlsLmNvbT47IFRob21hcyBIdXRoDQo+IDx0aHV0aEByZWRoYXQu
Y29tPjsgV2VpIFdhbmcgPHdlaS53LndhbmdAaW50ZWwuY29tPjsgei5odW9AMTM5LmNvbTsNCj4g
TElVIFpoaXdlaSA8emhpd2VpX2xpdUBsaW51eC5hbGliYWJhLmNvbT47IHp3dS5rZXJuZWxAZ21h
aWwuY29tDQo+IFN1YmplY3Q6IEtWTSBDb21tdW5pdHkgQ2FsbCAoMjAvOC8yNCkgYWdlbmRhIGl0
ZW1zPw0KPiANCj4gV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBv
ZiBRdWFsY29tbS4gUGxlYXNlIGJlIHdhcnkgb2YNCj4gYW55IGxpbmtzIG9yIGF0dGFjaG1lbnRz
LCBhbmQgZG8gbm90IGVuYWJsZSBtYWNyb3MuDQo+IA0KPiBIaSwNCj4gDQo+IFRoZSBLVk0vUUVN
VSBjb21tdW5pdHkgY2FsbCBpcyBhdDoNCj4gDQo+IGh0dHBzOi8vbWVldC5qaXQuc2kva3ZtY2Fs
bG1lZXRpbmcNCj4gQA0KPiAyMC8wOC8yMDI0IDE0OjAwIFVUQw0KPiANCj4gQXJlIHRoZXJlIGFu
eSBhZ2VuZGEgaXRlbXMgZm9yIHRoZSBzeW5jLXVwPw0KDQpNYXRoZXVzIGFuZCBJIHdhbnRlZCB0
byB0YWxrIGFib3V0IGFuIHVwZGF0ZSB0byBoZXhhZ29uLg0K

