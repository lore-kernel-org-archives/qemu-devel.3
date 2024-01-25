Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D82BC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2bV-0003LA-8h; Thu, 25 Jan 2024 11:29:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rT2bT-0003HY-3t
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:29:23 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rT2bL-0000uw-6s
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:29:22 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40PGSARt014092; Thu, 25 Jan 2024 16:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 qcppdkim1; bh=L2W8yTVUsMrSn550lM0L0LRRVYbpp7LWIaflbGUTT4w=; b=DB
 fht4UBUhDcSQDeexrrIMvY0IXp0MW51Fci14Z6fjD/laNWiFdpu2TgF4DDqRuOEa
 9AP2YIFrAapfbEA2qLC3LYLd/yK1I4nn+Pv229z5+i9b2bN63uKEmMKf2chqFbjW
 9UqLqOedxzNloXjkP1Zo82I+I5a28w8Z+Pw45abPwy+0Y3PypJKFM76U5BEnbmLK
 cy8Iap3IHtfbWBLoMT81czpi4AT78EwKv1NHV+BJcLHUinIxKm3IqE7c1etfg8zK
 EwZA+E0ex50Ux88Jdg5ZB0jERpQPCoiFfZiyHB3z5Y3Q8oFvBf9CfX9YbI4H1qPk
 5WMthjytTVkMvMlcU2Pg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vumcws6na-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 16:29:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBZsr+f9jl8haVNHfYRiu66zlTQ2HrP+adBskHMDfUdf9znMCX6bG5smQW0cMcnNAoZecoVwGdJiMXXo4ASAiMo8yzKPj5/oNyroRT11Y9XVj+GMeiqVmDr1B4AzPNqlmmRU4/DCqMac5EqP4K2kZLsq5icfSr8RFG4W8kVunV6IdG3ii58cw4RkaHlwzUNGXVxzJQPGvSG13A+bS7urL633ARm/7PLtz6tVVu4VceuTpLD7VjfrETSYxFzF/Nt0op9jUf4AeEXp6cVxCpudBBd6h0Lux3F5RHCQBV42A3ZukCk9MgpNSQAlHD5EdJSaUwG9jvWXRPOdTZ9QbkeEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2W8yTVUsMrSn550lM0L0LRRVYbpp7LWIaflbGUTT4w=;
 b=Xke4Zq50Xd16QHH64DG51K3Dr8EbXfcCJPqxrCnnxLcciNBJEwgN0/pGa1dlInH3yx6YDMbwiom3DzG15RGet65oLyrMp0BMdr1GlGyM/DQxUh1bN99U9WkM+JE4Q9PN8qT1pQXyAkXD2Br3jzSKEuGkXYe5qzO5iLdDP4bwP0zkZFB5CnctJIjrHaSlsx9YRLzm6QbVagWoB7w/xvF1R+ETavGMFkWLy8ZgFhuGljHCPOBROUc80gCZmfZR1a8Rf0DzARuHytjShDNnVwNCaUYUusACzIeND8HOywV5pfu991jMaGtTHToqSvjsj65IewOE465zVlqsFadi5nMEqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by DM6PR02MB6924.namprd02.prod.outlook.com
 (2603:10b6:5:25f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 16:28:58 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1e37:59f7:9ae:2058]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1e37:59f7:9ae:2058%6]) with mapi id 15.20.7228.026; Thu, 25 Jan 2024
 16:28:58 +0000
From: Brian Cain <bcain@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Sid Manning
 <sidneym@quicinc.com>, Marco Liebel <mliebel@qti.qualcomm.com>, Matheus
 Bernardino <mathbern@qti.qualcomm.com>
Subject: RE: hexagon: modeling a shared lock state
Thread-Topic: hexagon: modeling a shared lock state
Thread-Index: AdpO1p1rtmG5ulOnQhWSP6N+8noomAATfVQAACCHctA=
Date: Thu, 25 Jan 2024 16:28:58 +0000
Message-ID: <CH3PR02MB102477AED4556B477B083ABB3B87A2@CH3PR02MB10247.namprd02.prod.outlook.com>
References: <CH3PR02MB102479550F96F09E0C9D50BA7B87B2@CH3PR02MB10247.namprd02.prod.outlook.com>
 <7fc5e75b-4968-4df8-818c-ab2c4c758531@linaro.org>
In-Reply-To: <7fc5e75b-4968-4df8-818c-ab2c4c758531@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB10247:EE_|DM6PR02MB6924:EE_
x-ms-office365-filtering-correlation-id: 684b6196-4740-4f6a-428d-08dc1dc2bb5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MFF6YFPfbtmdtWXArUYQ1wA9a7uNCvaQxLnZATAW+srHXEHjDriQUTQos7qBJThY9LiEsIMyXyPMawC072fuhh4S9Rjg4LCmGHyeJiNkkH6tu4xMTBKuDIoDau+pdCZ5hm385lxvtxNtgyVtxBderbzBRSFWlu4woI0OZR2uwCWmekd6nX3Ps/cfUbRnWN/CsOje6EShPuOVn5bU4krnUViYK167dLmUw+L0C7zJXIwDgWJoDCUKmhVEon2AkmBa4iFaxz6gtlzEh6OFQet1gfqZFIbHtXsv7crOA6FlaBVC0BlUNKCs5chGwsrL2GzhMbWl8u216yi+vAjO1wz8pMsNhyWg21KVcYNdqgTnDB72DEdc8/m6+N/rf5U48n3GJNmv6bJMn5bUftUe2GZMQ4hGwa65mH/D79Qx/P/I9kGRICbFLTaajNsrjwdjFYvzanKpt7homdi5nMa5pnLo43fwE6q3Tp+yMrfEg58YNWzVCW7y+2ZrQETLssR/XLMbwkQ2yLBLFVp8e++OU8pecym1xGjEZMf9ZKTxHoI7ITefOBQWEafj4/Z5i1JmAGCkrn9QDUilI0uCm5SMReFqlR0i3GDTYA5N41CoMBm3c5VI4HSqHJOjeIHYXmAgtfCUY9ZfnVoyjtRkOAoJRm3b/hDXTYj9TVjCWRDztKHElSN79/QRxIOADjnoiasnESPP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR02MB10247.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(366004)(346002)(376002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(64100799003)(451199024)(186009)(55016003)(41300700001)(107886003)(26005)(9686003)(38070700009)(71200400001)(83380400001)(478600001)(7696005)(6506007)(122000001)(38100700002)(53546011)(5660300002)(966005)(66476007)(66446008)(110136005)(76116006)(2906002)(64756008)(66556008)(66946007)(54906003)(316002)(86362001)(52536014)(8676002)(8936002)(4326008)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1dUWWI2WjdpUUZGQU5WQW9OcUNYVzlxSVYyYlJ2emtjbnRLajFhdVRxQ3lS?=
 =?utf-8?B?WUFsNmptWExpQXEwZTJ4eGZ5cU9TZzhmdWxvRS9wRnFoVDE1Y0g0c0syZ1RS?=
 =?utf-8?B?L3NML05oRFdpRnNIeGp3cy9xOEIwYUtIYS91cWJjQ3RTTmpWSk9DRWloVXpQ?=
 =?utf-8?B?QmZkWHhvODlIL3JueENKME16VzdBL3lOQ0NnTkwxYkhRU3M1T2FTTEF0QXZY?=
 =?utf-8?B?UG1oYWljRVdUVldJK1Jnc1ZqVUNkRW5zVFNGbTFtQkx2QXVnWHZnQmhYbHNs?=
 =?utf-8?B?N2lyc0J0T2UzK1pra3FKMlcwdjBnTzhrNko3NFpkRllTS1RIZkFTb3FSV3dj?=
 =?utf-8?B?Y0hMdUVOU2VabGV2M2ZzNHNBSDZaOW4wZDFvR3M5Mm1STTJuN0ROMjlBWEhn?=
 =?utf-8?B?aUo1RE5DS3g0a3BUdTdSUEE2MFYwMytFR3pHRGxDZjFPWXJVaVhsaysyQWRS?=
 =?utf-8?B?dGFYT0VibklXa0RtNTZmdmtTM3orOWVoMzhldng3TlEyaUpFam9jbWtMclZz?=
 =?utf-8?B?RVFMWU1BWHpRaUtjZG5DbWV5VlQwWXBlV3hJdDFsRFRQdm9DNEFiYktqMWlu?=
 =?utf-8?B?TE5VTDYycmEzNVU2VExsOVhyMnpsUWRiS1J2dWdsZmlZaWlnK1JWRVlQMzlY?=
 =?utf-8?B?MHFSN2ptMGxlamkrSytleHFQNk9rdlBEQ25lc3pKODZsSjE1WlMvL3BBY3VC?=
 =?utf-8?B?VjRCaUJmMEpqSTlMeHZadll5WmJKLzFvUlo1bW5ubHIyc2JGR1JUWjhDdm42?=
 =?utf-8?B?enYyaUZvK1d2VTE4bm1mZkx0UG9BMGU4NXUyZCtmeS9hSWtLSFJ6S3UvV3Yv?=
 =?utf-8?B?Wm1RbllCcWFMcW1sVFdqUnZKMEJXNHF4eG10Z1FnemY4SjUvOFUyZTNSVW04?=
 =?utf-8?B?cGo4aVNmVmlGWTRQU1ZmZGlZZDlqY3ZZY1dhZitDK3ExcTBpZ3dlYjBKdi9z?=
 =?utf-8?B?N0R1bFNLdzNWMHBCNUJxcStkT3NpcWhCZW56S2hmTnQrc3JxUzZ0L2owSmlm?=
 =?utf-8?B?M2dnQ0o1VjRuKzltOW4vVXBBNDgyTHRqNklKT2xzcFkyck5RaHIybkdLQWVN?=
 =?utf-8?B?SURweExuMC93ZG9GK0QwcmxsVk1LVlVLdnFSWFJxL2YyZ0dTdWxDTFU0bnhy?=
 =?utf-8?B?SGNXdkhsd3pQK0dsaGp0dFVGZ3ZNTFdrK0J3RnVFU1M5bkN0TE5HR1ZhczNj?=
 =?utf-8?B?WmdNUVhhbWpQdEpXcFY4K01WSVNoSzloZ3AyS1ZaUzlPUGlRNWx2N281VDBK?=
 =?utf-8?B?RmxBQ2ZvRFhGVTdjWWFNRHVyTWxLeFFGUVhWSlhOQlQ2a3grLzV3akhTWWxL?=
 =?utf-8?B?MUh0eUZ6emVISUduWHlNcjJ3Q3V1eXY4NXRkNTNta3pqVzZDK0R3QVhzNDV6?=
 =?utf-8?B?RDJvakVGclZqcjZOMHVTUlRSUGdBUnh1bUpEdTJMUmtzOVVPN2NsQkFZU0FY?=
 =?utf-8?B?L0hkOGdPRnFNV2pzeW9qdk16MXRacSsrWVBocTllV2RtZHNSa0hWcTVsMm91?=
 =?utf-8?B?YU1iMXZLTU5xa2dZdXFnL3V4Y3NiMllpZVJLSVpvNXB3aHZuSytFTWtyTloy?=
 =?utf-8?B?d0hFVk9iaTQ0dWtkU2hWUnN3VG9sRFZ0OEtZTFRVbnJQdVczVW4rZ2JZK3Fs?=
 =?utf-8?B?cmFHQUVqMnJKbjgxSGZPT3N0MzRHQkQ0a1plak1NcmxxRitTc2NpSHg0Ym1X?=
 =?utf-8?B?RU4yRDI1a0RMR0FmVVBDNXcvNWxGV280a0w2RDhmSUpSOGVNK2UzbTRvS1dK?=
 =?utf-8?B?TnZUMWRmOUNrUDlUQlFkQk9sNlN1S21KMENISVZjVXZGTmcrOXdYT2lzajZE?=
 =?utf-8?B?aWhXUVpUOHhRM1FMWVhIV0tBZ0s3aDMrajRDdGNRdW5uWVh5YjM4cXUyQ1ZJ?=
 =?utf-8?B?T2VFTnROYVN0eXFjVFRicWJMUTlWd1lYQ2k4VlY0Y2p5T013Y0xRZHlBd0l2?=
 =?utf-8?B?UU5UdkNGNHJ0S1VnQnJvbE5QcGRaWGo3K3NjR2lEVllRYXI0RkY1K2twRlJM?=
 =?utf-8?B?b3BzMngxZVBPclFQWmtPVExWcmp4MUY1MnVpVTNaZ0YrdVBSSFRCZnJ4T3Ar?=
 =?utf-8?B?dzVTeFpQT2hJY0xYK3g5cy9ESUc0M1pDeUV6ZEtNamtWaHd1dWlkWDdKVTBl?=
 =?utf-8?Q?xGlk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LXvztpGWnmxyIhM6LOfH8pGz7WPBavhYgNFAlZfVBVAhFiu3n1WfMWeIPfFjg2dJgUPM8GQpCAbvGWhh71GxfTIF8pBVco1Zu3Bj1DmcvKLBUSaZYEECGLIfavnY0LVz2PwTPs52riJA5QbVduYxhBiiw25xZh13Ljxd5wlN7Btp4xsu3YErnaWoIo4CJlHQGUCsgQPzWWv/tYW5Uh34ForeHGsTEr82FUtI4VU4Arxl1FWxqTWvtvOoNnxAdJFMmhlhppS736e6Lm/USdrcsLeOjwtwh2Ewf1697HSCElln5QdVtjZPdpKf/1KOYWKieZejcpAtxXQrMdHUrBB8zPellhpWCl7z6rVo5OWQ4W1ceJbNqojbIrlT9nQvRAqD7nJt9ntMn0Ne7oatMc8a+WAr5WmHdl502wFNNy17yo9SLumlaxKQQ+vddWECuYG/KGgwuGxpXtycANvWNSaQ0wPdZIh8ImiIrYKxPq4TxVTOSvbrrGgBsQwwSfNxeU9WEjZZcJi1yowfgcSjkJdfy3fyhbSITGXeTyPIqAmKH85E+kVGHryScXUh9VffPm6EkL9AIzcVrerX0obrWxBBW0FOUUwr4iDLJZiEzWxEHUwMOWxv390PUVP3YN+ERisM
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684b6196-4740-4f6a-428d-08dc1dc2bb5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 16:28:58.3962 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UvKNlgxRk70xr8vSTDbhuAgmKvYB5H1TJQgktwLuKLkKR07MV6N+BLB2509HOMD/a5c3XZzivP0WGIQDlFvvpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6924
X-Proofpoint-ORIG-GUID: OrQzlyoYZtDcjqXNaE5hBuoGQ6anHiZG
X-Proofpoint-GUID: OrQzlyoYZtDcjqXNaE5hBuoGQ6anHiZG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_10,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401250116
Received-SPF: pass client-ip=205.220.168.131; envelope-from=bcain@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmljaGFyZCBIZW5kZXJz
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFu
dWFyeSAyNCwgMjAyNCA2OjIyIFBNDQo+IFRvOiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNv
bT47IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpDQo+IDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gQ2M6
IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgU2lkIE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+
OyBNYXJjbw0KPiBMaWViZWwgPG1saWViZWxAcXRpLnF1YWxjb21tLmNvbT47IE1hdGhldXMgQmVy
bmFyZGlubw0KPiA8bWF0aGJlcm5AcXRpLnF1YWxjb21tLmNvbT4NCj4gU3ViamVjdDogUmU6IGhl
eGFnb246IG1vZGVsaW5nIGEgc2hhcmVkIGxvY2sgc3RhdGUNCj4gDQo+IFdBUk5JTkc6IFRoaXMg
ZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5
IG9mDQo+IGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUgbWFjcm9z
Lg0KPiANCj4gT24gMS8yNS8yNCAwMTowNywgQnJpYW4gQ2FpbiB3cm90ZToNCj4gPiBQaGlsaXBw
ZSwNCj4gPg0KPiA+IEZvciBoZXhhZ29uIHN5c2VtdSwgd2hpbGUgaW50ZXJuYWxseSByZXZpZXdp
bmcgcGF0Y2hlcyB0byBiZSB1cHN0cmVhbWVkIHdlDQo+IG5vdGljZWQgdGhhdA0KPiA+IG91ciBk
ZXNpZ24gZm9yIGEgbG9jayBpbnN0cnVjdGlvbiBpcyBub3QgcXVpdGUgc3VpdGFibGUuICBUaGUg
azBsb2NrIGluc3RydWN0aW9uDQo+IHdpbGwgaGFsdA0KPiA+IGlmIHNvbWUgb3RoZXIgaGV4YWdv
biBoYXJkd2FyZSBDUFUgaGFzIGFscmVhZHkgY2xhaW1lZCB0aGUga2VybmVsIGxvY2ssDQo+IG9u
bHkgdG8gY29udGludWUNCj4gPiBleGVjdXRpbmcgb25jZSBzb21lIENQVSBleGVjdXRlcyB0aGUg
dW5sb2NrIGluc3RydWN0aW9uLiAgV2UgbW9kZWxlZCB0aGlzDQo+IHVzaW5nIGEgbG9jaw0KPiA+
IHN0YXRlIGVudW1lcmF0aW9uIG1lbWJlciB7IE9XTkVSLCBXQUlUSU5HLCBVTkxPQ0tFRCB9IGlu
ICoqZWFjaCoqDQo+IHZDUFUgYW5kIGF0b21pY2FsbHkNCj4gPiB0cmFuc2l0aW9uaW5nIHRoZSBs
b2NrIHJlcXVpcmVkIHVzIHRvIGhhdmUgdkNQVVtuXSB3cml0ZSB0aGUgdXBkYXRlZCBsb2NrDQo+
IHN0YXRlIHRvIHZDUFVbbV0NCj4gPiB3aGVuIHVubG9ja2luZy4NCj4gPg0KPiA+IEluIGNvbnRl
eHQ6DQo+ID4NCj4gaHR0cHM6Ly9naXRodWIuY29tL3F1aWMvcWVtdS9ibG9iL2hleGFnb25fc3lz
ZW11XzIwX2RlY18yMDIzL3RhcmdldC9oZQ0KPiB4YWdvbi9vcF9oZWxwZXIuYyNMMTc5MC1MMTgy
MQ0KPiA8aHR0cHM6Ly9naXRodWIuY29tL3F1aWMvcWVtdS9ibG9iL2hleGFnb25fc3lzZW11XzIw
X2RlY18yMDIzL3RhcmdldC9oDQo+IGV4YWdvbi9vcF9oZWxwZXIuYyNMMTc5MC1MMTgyMT4NCj4g
Pg0KPiA+IFNvIGluc3RlYWQsIG1heWJlIGl0IG1ha2VzIG1vcmUgc2Vuc2UgdG8gaGF2ZSBhIHN5
c3RlbSBkZXZpY2UgaG9sZCBhIHNpbmdsZQ0KPiByZXByZXNlbnRhdGlvbg0KPiA+IG9mIHRoZSBs
b2Nr4oCZcyBzdGF0ZSBhbmQgZWFjaCB2Q1BVIGNhbiBkbyBzb21lIGtpbmQgb2YgYWNjZXNzIHZp
YSBsb2FkL3N0b3JlDQo+IGFuZC9vcg0KPiA+IGludGVycnVwdHMgdG8vZnJvbSB0aGUgZGV2aWNl
PyAgSSB3YXMgdGhpbmtpbmcgb2YgcmFpc2luZyBhbiBpbnRlcnJ1cHQgb24gdGhlDQo+IGxvY2sg
ZGV2aWNlDQo+ID4gYXQgdGhlIHZDUFXigJlzIGswbG9jayBpbnN0cnVjdGlvbiB0byBpbmRpY2F0
ZSBkZW1hbmQgZm9yIHRoZSBsb2NrLCBhbmQgdGhlbiB0aGUNCj4gZGV2aWNlDQo+ID4gY291bGQg
cmFpc2UgYW4gaW50ZXJydXB0IHRvIG9uZSBvZiB0aGUgdkNQVXMgd2hlbiBpdOKAmXMgZ3JhbnRl
ZCB0aGUgbG9jay4gIE9uZQ0KPiBkcmF3YmFjayBmb3INCj4gPiB0aGlzIGlzIHRoYXQgdGhpcyBt
aWdodCBhZGQgc2lnbmlmaWNhbnQgbGF0ZW5jeSB0byB0aGUgdW5jb250ZXN0ZWQgbG9jayBjYXNl
LiAgU28NCj4gSSBhbHNvDQo+ID4gY29uc2lkZXJlZCBkb2luZyBhIGxvYWQgb2Ygc29tZSBwYXJ0
IG9mIHRoZSBsb2NrIGRldmljZeKAmXMgbWVtb3J5IHRoYXQgY291bGQNCj4gaW5kaWNhdGUNCj4g
PiB3aGV0aGVyIHRoZSBsb2NrIHdhcyBhdmFpbGFibGUsIGFuZCBpZiBhdmFpbGFibGUgaXQgd291
bGQgY2xhaW0gaXQgd2l0aCBhIHN0b3JlDQo+IChib3RoDQo+ID4gbGQvc3Qgd2hpbGUgaG9sZGlu
ZyBCUUwpLiAgT25seSBpZiB1bmF2YWlsYWJsZSBpdCB3b3VsZCBoYWx0IGFuZCByYWlzZSB0aGUN
Cj4gaW50ZXJydXB0LiAgSXMNCj4gPiBpdCBwb3NzaWJsZSB0byBjcmVhdGUgYW4gYWRkcmVzcyBz
cGFjZSB0aGF04oCZcyBpbmRlcGVuZGVudCBvZiB0aGUgdHJ1ZSBzeXN0ZW0NCj4gbWVtb3J5IG1h
cA0KPiA+IGZvciB0aGlzIHVzZSBjYXNlIG9yIHdvdWxkIHdlIG5lZWQgdG8gY2FydmUgb3V0IHNv
bWUgbWVtb3J5IGZyb20gdGhlDQo+IGV4aXN0aW5nIG1lbW9yeSBtYXANCj4gPiBmb3IgdGhpcyBz
eW50aGV0aWMgZGV2aWNlPyAgT3Ig4oCTIGRvIHlvdSBoYXZlIGEgc3VnZ2VzdGlvbiBmb3IgYSBi
ZXR0ZXINCj4gYXBwcm9hY2ggb3ZlcmFsbD8NCj4gDQo+IEkgdGhpbmsgeW91IGFyZSBvdmVyLXRo
aW5raW5nIHRoaXMuICBBIHN5c3RlbSBkZXZpY2Ugd291bGQganVzdCBnZXQgaW4gdGhlIHdheS4g
IEkNCg0KT2ssIGdyZWF0IC0gb3VyIGV4aXN0aW5nIGRlc2lnbiBpcyB+cm91Z2hseSBsaWtlIHRo
aXMuICBCdXQgd2UgY2FuIGV4cGxvcmUgdGhpcyAtLSB0aGFua3MgZm9yIHdyaXRpbmcgdGhpcyBl
eGFtcGxlIQ0KDQo+IHRoaW5rDQo+IHlvdSB3YW50IHNvbWV0aGluZyBsaWtlDQo+IA0KPiAgICBz
dHJ1Y3QgQ1BVSGV4YWdvblN0YXRlIHsNCj4gICAgICAuLi4NCj4gICAgICBib29sIGh3bG9ja19w
ZW5kaW5nOw0KPiAgICB9DQo+IA0KPiAgICBoZXhhZ29uX2NwdV9oYXNfd29yaygpIHsNCj4gICAg
ICBpZiAoY3B1LT5od2xvY2tfcGVuZGluZykgew0KPiAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAg
ICAgIH0NCj4gICAgfQ0KPiANCj4gICAgc3RhdGljIHZvaWQgZG9faHdsb2NrKENQVUhleGFnb25T
dGF0ZSAqZW52LCBib29sICpsb2NrKQ0KPiAgICB7DQo+ICAgICAgYnFsX2xvY2soKTsNCj4gDQo+
ICAgICAgaWYgKCpsb2NrKSB7DQo+ICAgICAgICBlbnYtPmh3bG9ja19wZW5kaW5nID0gdHJ1ZTsN
Cj4gICAgICAgIGNzLT5oYWx0ZWQgPSB0cnVlOw0KPiAgICAgICAgY3MtPmV4Y2VwdGlvbl9pbmRl
eCA9IEVYQ1BfSEFMVEVEOw0KPiAgICAgICAgYnFsX3VubG9jaygpOw0KPiAgICAgICAgY3B1X2xv
b3BfZXhpdChjcyk7DQoNCkluIHBsYWNlIG9mIHRoZSBhYm92ZSAtIHdlIGhhdmUgY3B1X2ludGVy
cnVwdChjcywgQ1BVX0lOVEVSUlVQVF9IQUxUKSAtLSBidXQgaXMgdGhhdCBlcXVpdmFsZW50PyAg
SXMgdGhlcmUgb25lIGlkaW9tIHRoYXQncyBwcmVmZXJyZWQgb3ZlciBhbm90aGVyPyAgU29tZWhv
dyBpdCBzZWVtcyBzaW1wbGVyIGlmIHdlIGRvbid0IG5lZWQgdG8gbG9uZ2ptcCBhbmQgSUlSQyBz
b21lIG9mIHRoZXNlIHBhdHRlcm5zIGRvLg0KDQo+ICAgICAgfSBlbHNlIHsNCj4gICAgICAgICps
b2NrID0gdHJ1ZTsNCj4gICAgICAgIGJxbF91bmxvY2soKTsNCj4gICAgICB9DQo+ICAgIH0NCj4g
DQo+ICAgIHN0YXRpYyB2b2lkIGRvX2h3dW5sb2NrKENQVUhleGFnb25TdGF0ZSAqZW52LCBib29s
ICpsb2NrKQ0KPiAgICB7DQo+ICAgICAgQ1BVU3RhdGUgKmNzOw0KPiAgICAgIEJRTF9MT0NLX0dV
QVJEKCk7DQo+IA0KPiAgICAgICpsb2NrID0gZmFsc2U7DQo+IA0KPiAgICAgIENQVV9GT1JFQUNI
KGNzKSB7DQo+ICAgICAgICBpZiAoY3MtPmh3bG9ja19wZW5kaW5nKSB7DQo+ICAgICAgICAgIGNz
LT5od2xvY2tfcGVuZGluZyA9IGZhbHNlOw0KPiAgICAgICAgICBxZW11X2NwdV9raWNrKGNzKTsN
Cj4gICAgICAgIH0NCj4gICAgICB9DQo+ICAgIH0NCj4gDQo+ICAgIHN0YXRpYyBib29sIGswbG9j
aywgdGxibG9jazsNCj4gDQo+ICAgIHZvaWQgSEVMUEVSKGswbG9jaykoQ1BVSGV4YWdvblN0YXRl
ICplbnYpDQo+ICAgIHZvaWQgSEVMUEVSKHRsYmxvY2spKENQVUhleGFnb25TdGF0ZSAqZW52KQ0K
PiAgICB2b2lkIEhFTFBFUihrMHVubG9jaykoQ1BVSGV4YWdvblN0YXRlICplbnYpDQo+ICAgIHZv
aWQgSEVMUEVSKHRsYnVubG9jaykoQ1BVSGV4YWdvblN0YXRlICplbnYpDQo+IA0KPiBPcGVuIHF1
ZXN0aW9ucyBhcmU6DQo+IA0KPiAoMSkgRG8gaW50ZXJydXB0cyBjYW5jZWwgbG9jayB3YWl0PyAg
RWl0aGVyIHdheSwgcGxhY2VtZW50IGluDQo+IGhleGFnb25fY3B1X2hhc193b3JrIGlzIGtleS4N
Cg0KWWVhaCAtIHRoZXkgZG8sIHdlIHdpbGwgZG91YmxlIGNoZWNrIHRoZSBpbnRlcmFjdGlvbiB3
IGhhc193b3JrLg0KDQo+ICgyKSBJIGFzc3VtZSB0aGF0IHRoZSBwYyB3aWxsIG5vdCBiZSBhZHZh
bmNlZCwgc28gdGhhdCBhZnRlciB0aGUga2ljayB3ZSB3aWxsIHJlLQ0KPiBleGVjdXRlDQo+IHRo
ZSBod2xvY2sgaW5zdHJ1Y3Rpb24uICBUaGVyZSB3aWxsIGJlIGEgdGh1bmRlcmluZyBoZXJkIHJh
Y2luZyB0byBncmFiIHRoZSBsb2NrDQo+IGFnYWluLA0KPiBidXQgaXQgc2F2ZXMgcXVldWluZyBs
b2dpYywgd2hpY2ggbWlnaHQgYmUgY29tcGxpY2F0ZWQgaWYgaW50ZXJydXB0cyBhcmUNCj4gaW52
b2x2ZWQuDQoNClllcyB0aGF0J3MgcmlnaHQsIHRvby4gIFRoYW5rcyENCg==

