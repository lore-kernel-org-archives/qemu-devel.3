Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53A7D3A66B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5o9n-0007Pc-Pt; Tue, 29 Oct 2024 11:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1t5o9l-0007PT-TR
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:29:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1t5o9j-0001WI-SR
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:29:17 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T9aLhs010746;
 Tue, 29 Oct 2024 15:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=qPOQPrm+mekGisSOhv7CKTvhKiG3gtP/pdTUVaEsdH4=; b=Vw
 CMfdGsq147r46pMAJEvHlAfFQI8YbDb73nh5eH3X0DZTnRFmKGfjm71oxjEHuEz1
 Qe4fT2G56+3W9rgRQVfGNJ1BCrOQrs52aDbz7nDdHzEHKypeYR9fZ2wXseMyxTNi
 MtapUhDwuLH6BkWebvd22AZswLe11X+QxQerO8Nn923Fd9HQ9Bc5g0mhF0R17Y3a
 m/UeDc6gOhbtcSpyrz86V64CwQYPF01659FqOXoennqvuOgu6MJ9eCTMuvdW2tVX
 RFTMjpWlYXVL0/fvv6kXk0mDNw5Ai08rctUeP9yqPfIIOnVnE2OQJGVZDMF0mYoM
 OLWggb8Xkis5RaXgpryQ==
Received: from cy4pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17010001.outbound.protection.outlook.com [40.93.6.1])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gqcqrx0g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Oct 2024 15:12:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuYGgSG479GqC0jTOXlcP2qenn50VKxi3t9pyV610ypJizaFTWRV73MH0l4Q1lPgRImWsAvEw4kxLRa+PQSZIMuVVNZdBVt80RfSlahhb3vWJMpmMVhZ9haIXxdf9sMaLF0PBJko8dfjUuSzEbXFqc1WIzxcnbl9DS4X6YRsklirvX4F9o4CuSedxttq9Z9QpQ93BiUGEzGFxoKYaFV9t3PXZ7M6g1yJFAEWCnIdA3XttMdJL6k5M/4ER1IZofHSC8lwOXb6P4X2ZP0Jpvq1ke5KKcrRG5u7k5mWjpG5b1y35zegzWp/FUmroC85Mf7u2m+PPVBuJs70qBOmLClZ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPOQPrm+mekGisSOhv7CKTvhKiG3gtP/pdTUVaEsdH4=;
 b=xZjLvjwHUFhv5/uJUuJGz27EF1TmRo55Bx8MMqZ9z/MdPVjDu5HH2hmpsZvqrDvGSMO7x67REX09yaEIZiWmfWT4FzmZcNT4xBHkj78b04BIzsJNUlYsVbS9qqvpl/VH4KYXRVRsW3tulCNveNIa7A20TmTmjbq5TU3Mp2yp4/4hEnC1o87VJPTaZpRRXyiExnNxBiSAAXJirXREVRt3pvDjhy/qBFEJ3HBmJceHObLrLf/ULRrT85Bhl07H3UbLIwCB7IYvFENAomyHTP6GMyzfR4NhHCU30bjoIEI6G6R4SDtO0ottgSPHH2OfxJKK0UZk/jYDCe6UT93kq5tgZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SA3PR02MB10044.namprd02.prod.outlook.com (2603:10b6:806:399::8)
 by SJ2PR02MB9924.namprd02.prod.outlook.com (2603:10b6:a03:53a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Tue, 29 Oct
 2024 15:09:40 +0000
Received: from SA3PR02MB10044.namprd02.prod.outlook.com
 ([fe80::4115:8705:5f71:fda4]) by SA3PR02MB10044.namprd02.prod.outlook.com
 ([fe80::4115:8705:5f71:fda4%3]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 15:09:40 +0000
From: Mark Burton <mburton@qti.qualcomm.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>,
 Anton Johansson <anjo@rev.ng>, Markus Armbruster <armbru@redhat.com>,
 Brian Cain <bcain@quicinc.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, "cw@f00f.org" <cw@f00f.org>, "dhedde@kalrayinc.com"
 <dhedde@kalrayinc.com>, Eric Blake <eblake@redhat.com>,
 "eblot@rivosinc.com" <eblot@rivosinc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo
 Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, "felipe@nutanix.com"
 <felipe@nutanix.com>, "iggy@theiggy.com" <iggy@theiggy.com>, Warner Losh
 <imp@bsdimp.com>, Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe
 <jgg@nvidia.com>, "jidong.xiao@gmail.com" <jidong.xiao@gmail.com>, Jim Shu
 <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>, Max Chou
 <max.chou@sifive.com>, "mdean@redhat.com" <mdean@redhat.com>,
 "mimu@linux.vnet.ibm.com" <mimu@linux.vnet.ibm.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?B?UGhpbCBNYXRoaWV1LURhdWTDqQ==?= <philmd@linaro.org>, Richard
 Henderson <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>, Wei
 Wang <wei.w.wang@intel.com>, "z.huo@139.com" <z.huo@139.com>, LIU Zhiwei
 <zhiwei_liu@linux.alibaba.com>,
 "zwu.kernel@gmail.com" <zwu.kernel@gmail.com>
Subject: Re: QEMU/KVM Community Call (29/10/24) agenda items?
Thread-Topic: QEMU/KVM Community Call (29/10/24) agenda items?
Thread-Index: AQHbKdOWqZUrs/Pa502Oi+n0dqRIwrKdst8AgAAKzqeAABfFgA==
Date: Tue, 29 Oct 2024 15:09:40 +0000
Message-ID: <70D0574B-9FE5-49FE-95F1-CFD0E4446190@qti.qualcomm.com>
References: <87bjz38j8p.fsf@draig.linaro.org>
 <3a6a8109-196e-49ac-8416-49f69b688e5e@redhat.com>
 <87o7336n2s.fsf@draig.linaro.org>
In-Reply-To: <87o7336n2s.fsf@draig.linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR02MB10044:EE_|SJ2PR02MB9924:EE_
x-ms-office365-filtering-correlation-id: 6dbd9928-53fe-49ea-d860-08dcf82bb654
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SGk4bkNsMnZDd3YxZk9PN0xLaFJZT1doUHdqaFZtejdLeEtmL2RtTFA3RzZL?=
 =?utf-8?B?QWNoYkhsa29Xd2IrWXBMMWEyRmQ5Zm5jbURqeGpKM0J2cloxZ3Q4bTdVcTQ3?=
 =?utf-8?B?UEozNTJXcDBCMkVRWThOdW9QMWVGNktwYWZHSTdZMEZ3MUo1V0U1ZVJjYWRK?=
 =?utf-8?B?MkVlQUF0QW9CRFlDWksvbkJzalhHdkRIcUpQZGtmUmtaWEhRVzdyU2RUNTI1?=
 =?utf-8?B?Z0NDRlorK0dNaFljTFFGQnI3UmJhZ1FNeHFtamRUNFQ0VzkvYlR1VHdxVW80?=
 =?utf-8?B?dGN4SXY3aEtZY282U2l2bkRlYk9jUFNwVCtFVUg3MkhaTWU2djBwalVZT0tY?=
 =?utf-8?B?MmpIWjlBcDl2TnBFUHh4aEFQSFlsaXZxcWpiY0M5ZG1VUmUzblVWSVV2OW50?=
 =?utf-8?B?YmlOZHl6NGhTRmtQQ0h5aDg2ci9TcFkxNEplUitydXNuRzJWS2o1QTYwOVAv?=
 =?utf-8?B?OGlrb0ZsMzY1ems2cHBydzRPVlR6QVRhVlZNTE9DSFJIWm9EcEgySGhpSEd1?=
 =?utf-8?B?eUlTZ0ZTY1RjZ0NnaXRHenluVUZqRmdTbDdsZEtEa0E5MGpEZEtBUmJoV2ZO?=
 =?utf-8?B?RlFYWmh0cW8vUkhUbHVzS1RkZXdLaDJXS05SbVFubHRFbm9vOE11YjMxL3Z4?=
 =?utf-8?B?Ky85NWV4VlVVK01pMlFNSEZtVHg2bXBUaE5pUUxPYklSbzNHZC90a2pNc3Bl?=
 =?utf-8?B?dVNkeFVOZzNxb3dibEVLK25wK3F5bVRrejVFYUdWZ3BTY3BRRC93QlJ2TS9H?=
 =?utf-8?B?K2RKOVE4Q2FKWmxqWUwwMlBjdVVUQkNLWTltQ1ZBWHJPTVVvZldSLzROSURY?=
 =?utf-8?B?K2NjQzFkTlJYZS9NbHZNUGZKaFpQU0VXakVTM1krUWN6bXhOVFg2RlUvcjE4?=
 =?utf-8?B?eFZDRnRkeXAvVEFmSTV5ZTNoWVBxMFJreVZ2N2FUQlk2UDJtY1VmaUNqMVRt?=
 =?utf-8?B?NVhHVGZaaEtjQWJ6aWxnc0NtTVFzUnluSVVLSGh0cklGUFRkbEFUMm9WMU5k?=
 =?utf-8?B?YXBRZEtBdmIvMDdReUN1WDNaUnlQVWo2blBJYTZZYnc5STQ3M2dGS2x6a1N6?=
 =?utf-8?B?Q2xLdE5XN2Q4MVV6ZWlxTlZiU01iV0VsTE5mQ1hFYzkvVEpUL2NJUGQ4Qkd3?=
 =?utf-8?B?UzFrTHhFVUpiSUZUMWVuSW9IU2YxYTNrR1R5WEtpamNaWmpXdHhpVStQd2dU?=
 =?utf-8?B?Zml6WXY1Sy9nVmxUcmIzMll0TXQ0YUt1RWhwb1pYVzJCWS9DbXVvR2dVVnhT?=
 =?utf-8?B?MWVRcjg4SFJNMXFPakdTdEYxV0toWTZTSUJWN0NHckhBS25GS25tZGN4SlZp?=
 =?utf-8?B?RUx5NG5JS1RjYUR3Mkw3N1dkR3lyQkFuZmxFNVo3S2RJTlZXalM4aU5JRmJv?=
 =?utf-8?B?YktodGdxdHN3U216LzNJV3gveFFOZ1VSbzNYOUh0NHdTNWNkQkJ6emVMWVAw?=
 =?utf-8?B?MlU1a3gvVjFXeFR4ckNzRWMzWk05cUNXWEZ3Q1ZZOUQwa1VBeVlhVi92RUUy?=
 =?utf-8?B?ZW5lVUdIWDh2bW5mSFlRSWlzSm04Y2IvZkJuV1RvM2lMZ1dmVkpIZ2ZqaXVw?=
 =?utf-8?B?QkdMOS9tdXNVQ0pIckZXTVBqajEvVmlyWjJWWHh0R0J2anRWRytXclFUK1hD?=
 =?utf-8?B?VUc5T1ZlcjVseGxCNmhFK05pRXNyVllCT01sYitxUjlKSUJ6dVFKSmU4QnNL?=
 =?utf-8?B?dzRqeHVFQ2R2QTdOcmRqQlVWQlhJYXRnSDlybmtXQ0pMOVdHaC9KYWZCbEJY?=
 =?utf-8?B?MlZtOWdydklPaDJVcVZoZ1I3cEJQbnp2VjBEdGROSmlkMUQ2bFFDRTZRa2Mw?=
 =?utf-8?B?MXJjaThxRkNndkVYTUtDWTJZL2JHckFTcWJ4NVYwQnREZ3puRytkQm91L1Yv?=
 =?utf-8?Q?arVt8C2fp55IC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR02MB10044.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTJMUE52eUdRNEVKamxodjFSaDB6MXNOYlpjbUYrYWJrWWV0dEx1WVp4T3RN?=
 =?utf-8?B?UUprL2dNSUZWNS9hS09ENk1WYk9WOXQzNUF2U0FYWHNGSnluNHg0UXRjZzJi?=
 =?utf-8?B?WExXdkwySE1LRXFCY0JJdVdwcUp6UCtSZE40bjlEeHFjL0xGZGVKa1RJUXpV?=
 =?utf-8?B?NFp6ZCtlU2daRE9XYlVXbmpjMVJ6R0ZJRGdXSUMxZWtleXBBYWNZUUhLV3lK?=
 =?utf-8?B?T3RWQmU4YlA0ZWZhd0Q4RnQ5MDUzcWx3Q1lQL1drMFI2SFZSNlMyZGVFWUtk?=
 =?utf-8?B?UHBLRkdzcU13d2p5d2E5Y05OUUFmdHI2S042NEg5SG1iWVVwL1VCZ2IvQzlC?=
 =?utf-8?B?UGEyL3oyTDRIREJOSDVSUzZyWmx2aHg1ekFGTXFrelVhb3JmRnNoaGk2bEts?=
 =?utf-8?B?MHpxU2grSmgrbTRKY0ZOSlhla0xYYUN4L3VCcGxXZk1NQmRhb1N1a3BuOGpL?=
 =?utf-8?B?UUgxeURVS25UVktkT0poRmxSTmwxS2pabXVCRG1ISWJXVzgrVTIvZE1UWnp1?=
 =?utf-8?B?eGpaWW5BaTIvbmFOS3hjalo4SVo0eENLUzFsVDNVNnBVWXdLejJPWEJqVmZp?=
 =?utf-8?B?aThnY1YwSFNVWDFXVXFURXVrNk9xY3hNYklrWXZmeGxBdHk0WVNrWndqZzVF?=
 =?utf-8?B?MnBsZ1pFdWZkRk5OQ05nSjM5SVBTVWtCUWNyYmdTb2xnTUxNU1BFV1VGNUVN?=
 =?utf-8?B?NjEwYVZWMnNiM1JkTkdRYmRjTEdoWWVWYzQ5dWs4dGZYUFNkdjRoNzA1NTVu?=
 =?utf-8?B?Y3h6aWtreFVHMWRFdzh1aDdGU0pUZEpPYmZ6K1AyczNaVE9pNmxmdmdGNEsv?=
 =?utf-8?B?ZCtkdEwxMEhRQ0RQVjdISUMydUE4OHkyeURKcVRXR2h6anhjeWxJRjRYcG9x?=
 =?utf-8?B?L2VIam9NdlR3RTdNSGV5VlNBejFva3pjVldtNkpyNHgrcG1IVjVvMVh2OTgz?=
 =?utf-8?B?VGYyblFaQ0w1YS82VXM5bHVIRXhSVEFOYWU5alpJWXdMSDVBVld0OGZSTVF0?=
 =?utf-8?B?ejRwWHRJN0dyRFJlV3dEZVpGYVhOcWpXTSt4c3YvaFpkT3ZWZ0NhVEpXeVZ0?=
 =?utf-8?B?MlVaOUJydlhQeXFZVmlHRFJTeEIxY3hXdGlUVUF0VDZFWktDS1B2MFZMb1Vn?=
 =?utf-8?B?ZmtBem10ZFA1dnZNR2dhcjlhUExiWjRjeWJ2eW82TUdMckMzbVFLYitVQ01y?=
 =?utf-8?B?cUlkbEc4U2pTMXZjSXJjdXJ4SlBEMUhYRjdXRGF4c0Y3VHBIWGprblUrSWVF?=
 =?utf-8?B?Y09CVDFRZXpvVzdVc0pQOEllMUlGTkhURmRzSGdFdGtXMW1oWExuZW4xS0RB?=
 =?utf-8?B?MDcrRitXeU16YU1UR2ZucG9HdWEvZ1YvZjNLME9qejdqbnlndENhM2VPazEz?=
 =?utf-8?B?dkFKdmpBRCtXZGRld3VXTitHaDZVN1Q0YjFLRzlJUUhRdUVucWdOb0U3Z3dG?=
 =?utf-8?B?ZjJ2dUZNYnJCSnp1VlJBQkNDRk5jMVBWdDJpSzA0SHNoRXg1WDBEUnJTUHIr?=
 =?utf-8?B?djRwYis2VDNZQm5PRVFuV0ZGVU8rOFVJbCtHVjRpcExjMkxQakN5akFDTTZD?=
 =?utf-8?B?Z2M1RndlYjhKOUF5b3kySVFGTUFJR05HVkV4UysrNTFkT2RmZlpuWGN0ejJI?=
 =?utf-8?B?dkpQVlByUEFVY0ZSZmF3SHRLSXlJVmxSZkEzYkdHbmlnbm9ES2ZnQ0g2K0Vh?=
 =?utf-8?B?RG1JNHltbVZLODlJeEppNDhjU2kzVjhabTRKdE9MaEsyamt4YzloUEhNbllI?=
 =?utf-8?B?OGsvUVFSR0FHS3ZobzNUanRGU2RCajBaNGdJc0tKVHR5TXFoSjh1V0loWXF0?=
 =?utf-8?B?VmZjNzJUR3RhZXh0M1EvT2VnbVhEL1BtSGdjdVdmUmJKd1RNd1NkSzJ5UGFs?=
 =?utf-8?B?VUJ0ekFZcnZQR2RrZHV3OXlFNGF3M2hGQ3U4VTNndmRwZUprenA0WnBLOEVh?=
 =?utf-8?B?STlXQ0VDY3FLcTY1Ujd6ZUJSQ3c4ZWhPMjNHMGJPdmNFTTRKYnVNNEhzbmdX?=
 =?utf-8?B?Z1RUc2FOS3dIcGpiN2pxL3JPQXptV1FPUmEvWkZCVlBVK3JGNFF1UXAvUGlu?=
 =?utf-8?B?OUh2cHhNUDBBdkJ0c3U1WmJSRjdib3hqSGZJOTR4eGtneEswTGFQcmxxQWxi?=
 =?utf-8?B?VjJxVndzTXFub0l3Q1I3KzE2eWdsRWZtU0d0cDd6WWFuYnYrdFF6U1YzeFdS?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE898B27AF25B7459A4F4A5F3F266F9F@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: l8IloYZJoZbr99ZcHrtTn6dpJtuY98OKy/3QO9i0t9Gv11hwFNq+OdL4/mWRc9kSMcqEVlc0+1UwzbKn1aMgzyH4YWSuReUQSw9etTRagjEjPDa+Dbi9ubRmHssH32L+QGRkuJjEh0REeCmFF0ytyVnzjyejClqU8NO8xGPiBuiDnOfYLBA/Vv3Zf3r5DuG22qYhhbTp76omty58o8nAZFqcI5iCmdB321ZMZQ/UWh8sQfcC/0iUq4bUAgawz1KG2kVss3RjRLjoygvtAQfry7hmBIkICH+/bmcEOMPjNhLrUCRTEUlnGxs90ah4rDdzi88So8ZNzQ/JWHeDOOwUoWmr29RVZtpm8tIUu0McEDY1GVX0Lr73fji2dGdj70Azt2yDLQSR0eTnm+gGBNPyn4j8vLL+wPtXWZUpBIPf+mE2mZ/tYoj5rBzkGrW68nG/MUToUdY3tCeaGFYWha0dtkXtdaPZ8FTk3WdN6+LeAQtVWYteR+WYhIJJGw8p1CxuHt3+8M/a+S4fc3vAXSDA90+vUH4Bx0TNMMrWram3mSFGxfLOZBih42C6XWPZSHlv++T0b5siFixTXc7xs+bK/Jtb1uX85FgloDsVNrmlFzQBgLNZxHmJFuHyuoJQrRqG
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR02MB10044.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbd9928-53fe-49ea-d860-08dcf82bb654
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 15:09:40.6029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ynmHYwr0Wv+Be6aEMZlXIC3yizSWk73IBEp5g2g+z+1CA1TkftYW87GyfPrO+jIyIFaHTuu09GDFJASocGC8LdLXSV7XOL+FAm7iksc65ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9924
X-Proofpoint-ORIG-GUID: 5lIgIrjG9QH51poOxtLZ-kZsg34x47hk
X-Proofpoint-GUID: 5lIgIrjG9QH51poOxtLZ-kZsg34x47hk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 clxscore=1011 priorityscore=1501 mlxscore=0
 mlxlogscore=973 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290116
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mburton@qti.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

VGhpcyBpcyB0b3Agb2YgbXkgbGlzdCB0byBkaXNjdXNzIHRvb+KApi4NCg0KQ2hlZXJzDQpNYXJr
Lg0KDQoNCj4gT24gMjkgT2N0IDIwMjQsIGF0IDE0OjQ0LCBBbGV4IEJlbm7DqWUgPGFsZXguYmVu
bmVlQGxpbmFyby5vcmc+IHdyb3RlOg0KPiANCj4gV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5h
dGVkIGZyb20gb3V0c2lkZSBvZiBRdWFsY29tbS4gUGxlYXNlIGJlIHdhcnkgb2YgYW55IGxpbmtz
IG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90IGVuYWJsZSBtYWNyb3MuDQo+IA0KPiBQYW9sbyBC
b256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPiB3cml0ZXM6DQo+IA0KPj4gT24gMTAvMjkvMjQg
MDg6MjQsIEFsZXggQmVubsOpZSB3cm90ZToNCj4+PiBIaSwNCj4+PiBBZnRlciBhIG1pc3Npbmcg
YSBmZXcgd2Vla3MgZHVlIHRvIHRyYXZlbCBhbmQgY29uZmVyZW5jZXMgdGhlDQo+Pj4gS1ZNL1FF
TVUNCj4+PiBjb21tdW5pdHkgY2FsbCBpcyBhdDoNCj4+PiBodHRwczovL21lZXQuaml0LnNpL2t2
bWNhbGxtZWV0aW5nDQo+Pj4gQA0KPj4+IDI5LzEwLzIwMjQgMTQ6MDAgVVRDDQo+Pj4gQXJlIHRo
ZXJlIGFueSBhZ2VuZGEgaXRlbXMgZm9yIHRoZSBzeW5jLXVwPw0KPj4gDQo+PiBJIHdvdWxkIGxp
a2UgdG8gZGlzY3VzcyB0aGUgbmV4dCBzdGVwcyBmb3IgUnVzdCBiaW5kaW5ncywgYnV0IHByb2Jh
Ymx5DQo+PiBpdCdzIGFscmVhZHkgdG9vIGxhdGUgdG8gaGF2ZSBhIGNhbGwgdG9kYXk7IHdlIGNh
biBoYXZlIHRoZSBkaXNjdXNzaW9uDQo+PiBvbiB0aGUgbWFpbGluZyBsaXN0IGFzIHdlbGwuDQo+
IA0KPiBJIHdhcyB3b25kZXJpbmcgaWYgeW91J2QgYmVlbiBoaXQgYnkgdGhlIGRheWxpZ2h0IHNh
dmluZyBzaGlmdCA7LSkNCj4gDQo+PiANCj4+IEluIHBhcnRpY3VsYXIgSSB3b3VsZCBsaWtlIHRv
IHVuZGVyc3RhbmQ6DQo+PiANCj4+IC0gaWYgaXQncyBkZXNpcmFibGUgdG8gaGF2ZQ0KPj4gIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMWQ2MDM0ZWYtOWU0MS00ZWY0LTlhOTUt
ZDAzODg1YjA5YjJiQHJlZGhhdC5jb20vDQo+PiAgaW4gUUVNVSA5LjIuDQo+IA0KPiBJIHNoYWxs
IGhhdmUgYSBsb29rLg0KPiANCj4+IA0KPj4gLSBpZiB3ZSBhZ3JlZSBvbiAodGhlIHBsYW4gb2Yp
IGJyaW5naW5nIHRoZSBSdXN0IFBMMDExIHRvIGZlYXR1cmUNCj4+ICBjb21wbGV0aW9uIGluIDEw
LjAgYW5kIGF0IHRoZSBzYW1lIHRpbWUgdG9nZ2xpbmcgdGhlIC0tZW5hYmxlLXJ1c3QNCj4+ICBk
ZWZhdWx0IGZyb20gImRpc2FibGVkIiB0byAiYXV0byINCj4+IA0KPj4gSSB3b3VsZCBhbHNvIGxp
a2UgdG8gcmVhY2ggYW4gYWdyZWVtZW50IG9uIGhvdyBSdXN0IHBhdGNoZXMgZW50ZXINCj4+IHFl
bXUuZ2l0ICh0aGF0IGlzLCB3aGV0aGVyIHZpYSBteSB0cmVlIG9yIGEgbmV3IG9uZSkuDQo+IA0K
PiBHb29kIGlkZWEuIFdlIGNhbiBkaXNjdXNzIG9uIGxpc3QgYW5kIHRoZW4gcmV2aWV3IGluIDIg
d2Vla3MgYXQgdGhlIG5leHQNCj4gc3luYyBtZWV0aW5nPw0KPiANCj4+IA0KPj4gUGFvbG8NCj4g
DQo+IC0tDQo+IEFsZXggQmVubsOpZQ0KPiBWaXJ0dWFsaXNhdGlvbiBUZWNoIExlYWQgQCBMaW5h
cm8NCg0K

