Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFD1CD1284
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 01:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq0gm-0004Zi-PD; Thu, 28 Mar 2024 21:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rq0gf-0004S8-Ut
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 21:05:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rq0ge-0003vX-4P
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 21:05:41 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42T015sU024940; Fri, 29 Mar 2024 01:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 qcppdkim1; bh=e5JleqgF8wORL051ZjHSNF9peTbbDEwWXART7n7qWhY=; b=Jp
 UzYIw6qkOjhA/ENEwD1+PKPzIDGrDOWgzRh2ELPG6AvMbU+W3PvJ3EnTaohwaLC8
 wglT1vsZYqAt+uCiMfRT6rjRa8gJ/JIEO3n6EwfVxhYBx6QffYqwgqVqvS/VZcDs
 YnhJAB6rGwEWEKnoP9oPQTmZRiriBUSnBNxmgmVPVRNzN8FXdqdqGSb+D7Mupa5B
 2Sor3H9816pHUjOjBK+makifc2n4RRQO2ZIfP9Ojt5e9ixhzjErTmutef89GJN+w
 H3BcpjtpFeQJ9pFIiSwES7XTGvcDAimS4/CGQ+8cZTazSIDPz7q0D4UqWCfJB3Dd
 s9+tlmn5+JZQEZAEmOvA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5h2gg8tg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Mar 2024 01:05:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n46GRq8G4mGWDGy4Ec3xaHi0DihTHYQtOfLb3NnGEka22b3zj6z4JfCtc3WIGILc4+Z7B53wMMb3LBKkOV3utioX5bA0G4/VD04ZfH5CwvfyYqMXfQUfm5AohaGzD/ghFsQ4CjCmWldSxM2A1Xh3i7Jd4VWW9vhSoupkLTDV4UoNeGQYYoaiBX2PlMYg6jPWUuAUGxpC/SDhQMCBpAPzCWNLge8hvy/fgwY9gIa60pfdRk7UsvmAPvn9Q6p0TVkbYauNuU9AkM3KJIc2K3SPRTfKacKRhrD0tKA2+DagYxmGnycm4o5hKNc4ENQVqFBqx4vWQ3flI2sdKzsxWRBivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5JleqgF8wORL051ZjHSNF9peTbbDEwWXART7n7qWhY=;
 b=dm47mlwmtROtJfrhTe+R/VJ+v/8vnrlAzcbob37OBJ3wl/mLR8W95UUaBV1xCVgYlUpeP6KflBsJqoGsk5/Ur+ShHMROMJ67Nl9sLNziKNNmWn2F+1s5kwUBcOJnowaVx5i5Us7ubiuEY9S7WqgB56Yo/iTWfUmHpyJvWybEskE98ftomhIhwGZg55JWL+vGkR6fRHVK3T45fcgvwXWbK7V9KYfPTsJShlXbCPRQNAt6F+ASJ2eexoKsiJgrDOQLpaEPnknMBzBeQcNDgW8K/iQef9bKIS8uaLUUjB/tFxaV+DMXf1uAZWcupmFZuDhpQt6gwT96ST0Z6ordLz/uYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by CO1PR02MB8490.namprd02.prod.outlook.com
 (2603:10b6:303:159::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 01:05:33 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1aac:6291:50e5:4242]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1aac:6291:50e5:4242%4]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 01:05:33 +0000
From: Brian Cain <bcain@quicinc.com>
To: Taylor Simpson <ltaylorsimpson@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>, Sid Manning
 <sidneym@quicinc.com>, "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "ale@rev.ng" <ale@rev.ng>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: RE: [PATCH v2 3/9] Hexagon (target/hexagon) Mark dest_idx in trans
 functions
Thread-Topic: [PATCH v2 3/9] Hexagon (target/hexagon) Mark dest_idx in trans
 functions
Thread-Index: AQHacD7abGnM7cVCGkqM8+w0DdXNWrFOCdvw
Date: Fri, 29 Mar 2024 01:05:33 +0000
Message-ID: <CH3PR02MB1024768CFF838E363516CF31AB83A2@CH3PR02MB10247.namprd02.prod.outlook.com>
References: <20240307032327.4799-1-ltaylorsimpson@gmail.com>
 <20240307032327.4799-4-ltaylorsimpson@gmail.com>
In-Reply-To: <20240307032327.4799-4-ltaylorsimpson@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB10247:EE_|CO1PR02MB8490:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FMF6hIK4Vg+ApCmmtlrOt3RFq0ohy9k66hGVWcyaqwdXmlXfBnGLn2EfZLEY/q/KxpPNdMM9qbxY7q0TTTFEQQIhYN8jx2kNA2XZdGfxYfmuH5H4V9NiSQibfs1ZZ9PxgfS/jxloEr9AeRjDirNVaPA8vobo/Amu5p7lZsVeR1ZA5MdQPsNCEpmoo0f3e9wl3botJ3U/VYojFTPzvsxYaVbZE12OiiVKP76ThJsTFKUOrbZ5etAlE/BrCl8BxwVr8QAS1E3uTdAMYyBbljTMJDz6ihjhs0teJIhhwrp17Zc4Mi3lo/eva+IfbmnyuiMO7+luPuxgnxgFfDsZNx07U1zHIpeH/1q+DZQnTxuF0aVX0CLFV6nZwbvUNofsJSixXj7rGUN9iTkde0kOYo7Rqwe+ZC7mjEaScg3b3kWd89gu0EsbceWDAIovcbNrLD0oCsXsIlk7AKO9xLjeAVY1vq72y6BDBwFqexR7aApyH3/OBiX0vtbMSEX1qQHdjJTTyYSqXGQBbSnaN7Tvv0+bVJXujYcU2JwzirmmXqntM6SzZCC1EQebQzjPxRnxuT5pagsbh69Cr0NnjJxuG/PDo6m1K7M5P+hpHfOr/H4EUVXDQ0HhWrvZuNzbJF8LawGyOUeRBQ4+OmO8DJiTrQhZLvZkzX52C9l/ODe5MYb4aAI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR02MB10247.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWlBZEhGd09zdGtLYm5tM1hoTVNjTm9vK2FFb2M3RHE0OWhUTVNGaGVJVUc1?=
 =?utf-8?B?aDgvU2J3SE5DNlRodVhRSnhQWVlqdWVnUCtKbndhcGRHZ25sL1hQWHN3OFF6?=
 =?utf-8?B?dzdOdzFLdHJtRGIyMjJNcVpDUjBmOUc0Q3grRVAvcnNsMjlaNXFSaUpWUlBH?=
 =?utf-8?B?ejBkV0hLdjRXeHdvQ09ybjJ2RS9Qa25TZzdwSmxZOGUvTTBxQ01sN0k0Q3hI?=
 =?utf-8?B?YlRtTS9ZejlZNEhCZnRnYTBnQ0lOZmQ4aGFDREhySUFtZXNHVExCdW90YnBJ?=
 =?utf-8?B?dU55NDV1Y0FIUnl0QkN2bFQzS3g3UnJGckdybzQxM2g0UWtMV0lBN3hJMTNI?=
 =?utf-8?B?dFR4Yk9XRzFRY3YyNFFOV2xQNXN3clg3R3JMc0N4R3FRbzk5Ym1WMDBMTGJY?=
 =?utf-8?B?eXdMSGZjM2NmdVNUM25EWFdzMDMzMGxhSFArN1l6SkVGZ2U5RTltSHpEL0JH?=
 =?utf-8?B?NmVIQlAyU0xmZlFlVlUyYVhxTWU1OHBrbGVwZHRIS3N4RXFhcW9VdmtTVU1i?=
 =?utf-8?B?Y1pFZVBuT0xZeUZXeldjRjVudnliOWNOMUJKU3N1QzlyaEEzeVN5UVQ1Tkdo?=
 =?utf-8?B?M0t1ZXJJN1YvazQ0bGp6OWgzRit2TDl5d2ZXZHpqS2lBc3FsRWN0cUk2OFVj?=
 =?utf-8?B?OUt2bTJDcnkvMWtYQ0lvejNwT2RmOGpKQzVQK0kwYVY0RzBPWHlOZEoyYkpj?=
 =?utf-8?B?RGhRZDVSWFZGK1JyMHpIaWNha2s2UFNtd3hxN3Nzam9aMWJQYnYxVURzaThs?=
 =?utf-8?B?SlBTSkd6MDRvQUQ2WDVhWW15TGswcGNZTHpGVmhheTJUN085RXlJYnBRSjk5?=
 =?utf-8?B?RlBSQTRaWWNJU1JOWHhLV1BGVllzaHpuSnVwbXU1ZnZvNHZZV1BsR2FTUVB6?=
 =?utf-8?B?NjhMdUZWd1dTSnJ5MmFPU0xvSUVJQmlKVDZ6aEgvenlWeVMzZGNBR3IwRjRL?=
 =?utf-8?B?bkFMQTdBcVkvMVdtb2xnMlJGbURtYUgrY1hBaWhuallIMzRJVzRJT2grQmN3?=
 =?utf-8?B?bTRnZytqYXV2R1RONk03Wm9vS0dCZE4rWHhad3BWSFVkUUJkQnZ2UlJjVHNC?=
 =?utf-8?B?K3lSZDM0WGl1OFhnc0FQUk1nZWtCblMxclVsOCsrVEl1Y1BtTFpHeUhJT1pD?=
 =?utf-8?B?MGxQaGIvSWZQQ3hRNk5lZ3VzNlRTbVQ1OElwNWxacUp0QjRrV2txZlVPZktr?=
 =?utf-8?B?T3hzRVJYaEJENXdTZ0NxbUpKb0ZGRHFzdmljeHlkNkNFd3BoUUNmZFBqSHQ5?=
 =?utf-8?B?WkZMbUtQNSs1WlVPVHl4aHg1MVpSUG13K2xQektKT0hOK0NxTTFYRVhaT1FJ?=
 =?utf-8?B?dDJMRFFydTNVQ1BVbTdQSFdEYklLaWdRZ1I2azN4WktLVGd3bFdPTWphOW40?=
 =?utf-8?B?YVlCRlNLWWY0YlVydjJsYlBic2EwV3BYbEc5SFUzT1AxNFJvSkZNQ3dZSUJF?=
 =?utf-8?B?Yy8zNFhVYWpBSHl5ZVdjVnFTbVlzWFhvSUNnWXdLb29lUkgxZ0RDZjNmT05M?=
 =?utf-8?B?MERYeE05REFQWndXcnhjTjlZVFFDUXFFRDUzcE9NT2c3SklBYVFFOUk5TWpC?=
 =?utf-8?B?OU1Bclh5cTN2ZVk0dXEzdXRhaWFaSHRlTUJjbmJaOHVTbW5NY2dTVy90S0Ry?=
 =?utf-8?B?bnhMUnRZcVdKSEVKM1RzZnI0ZTljcGtnSlp5ZnFkN1A3NWZRMnJDbjFieUhI?=
 =?utf-8?B?Rm1mQmVqbFMxNHowZUd0RmRJb0thSWRFWEk5b3l3U2hvVFo2QzBFL1NGSGI1?=
 =?utf-8?B?MU0zcU9ST09mSmwzNnhNSXFIektzTDRHaUl1dTR4T0RLYnZIaTdGZkRoeUc5?=
 =?utf-8?B?MU9QNGk0NFlTWTh6Q0NFVGsyNEFrdW90QjJnZmFQcVhmR3UvdEtGaS9ZWURO?=
 =?utf-8?B?dFJtN3N2OVg1RFlxd3AwU3BLOC9kSy9PcDAxa0txZ2xHTnd0R25WVkYxb1Vp?=
 =?utf-8?B?T05vdWQ5WU9mN0hHczJxMnQ0UmxzdUY2UjJZQndzRUZBR0lVbVU2RFB6NUhn?=
 =?utf-8?B?SzZDTjdQOGFFbUxtUDdFM0pxbndYblpmVjNXRzI0UWc4Y3FlWmZ5U1ZsS08y?=
 =?utf-8?B?Y0FwSTJFSVE1dWFaREl5cUtiYlR5VGRadDRJd0FMb3lQM2dsZ3dtYmxlNzRR?=
 =?utf-8?B?TldCRWVxNTlkSFd0bzlXa1lLSUNvUzQ0N1Q1cG50NS9yT2hSaHpsWVhjaFZB?=
 =?utf-8?Q?E1nifZQ2vF4a8hRBQarN5fxlNvr2BAA5x/x/QDFY6H4E?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: O6WcpJBfuBSpyW0oS8fJYzM3o6vH6iz070MutAd+SqX7w3Mi85cQed4pjDciTBWnTBr3BxkMlylDTMTKwd8hcqIOJqU12/k3V2amWHOE4/cvEIkrz+nFGPs1OuQ+ZedvtoPsal3FJyMlbwR6XHCdfHlWQ16FSi5/GtnviKfOscDjMorM4eCLgitfZfadlUprUCSNborq8e9FwUrnI3SihgGCNtJDvuUwUn7Hfyi1nZQ6zY4ny2Fb+QrQKJMPQYmNv6ueFp37ro2pPmNir66BGq5/Gbdin+eJuFqDf9QK6n9Hd4FTFAZzTZKvXz2e4QU3ZsJTFWyIVvCohMVLsJbpIb1kZ7z9ik/NV9oFd0DZD7nWcCFdnaKIo1cBT9dlsrPFvZfTnb/1EYG9QI3xthsbE/39z9AwvLWkuUvSRa6PDVehAqwudteo8P8lyh1ZAaG9UOypTCxrZc2li0Iz39+J2VZttZiezLo3w8xa30JAomUxkjDGfH5KZzrnT+yz3sTZN0FlQRY6tgL0WH1v5ahNBeVl6aecQWPOas6XAlTf1gj6H8TWLL0zveojnVkGUphdcjMaEYDQdvfWSQN+oINB5tujS/ttwDvbAKbit9cqFzCS9a0W3le+O1E0AVqlmfwU
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30c5388-83dc-46cb-332a-08dc4f8c55bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 01:05:33.2022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tDvuuwc5N/aKU+Llipm8ezFyZ+Gf0HYK6YJLoMiGhHkFRQ7aemva/Y/isEaORsp1Ku+6j1g41lOH8r2UMEmTmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8490
X-Proofpoint-ORIG-GUID: 05Q_tMumtWMi5NkambJkudBnGc-EvqrF
X-Proofpoint-GUID: 05Q_tMumtWMi5NkambJkudBnGc-EvqrF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_19,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=763 spamscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290007
Received-SPF: pass client-ip=205.220.168.131; envelope-from=bcain@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGF5bG9yIFNpbXBzb24g
PGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCA2LCAy
MDI0IDk6MjMgUE0NCj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogQnJpYW4gQ2Fp
biA8YmNhaW5AcXVpY2luYy5jb20+OyBNYXRoZXVzIEJlcm5hcmRpbm8gKFFVSUMpDQo+IDxxdWlj
X21hdGhiZXJuQHF1aWNpbmMuY29tPjsgU2lkIE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+
Ow0KPiBNYXJjbyBMaWViZWwgKFFVSUMpIDxxdWljX21saWViZWxAcXVpY2luYy5jb20+Ow0KPiBy
aWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnOyBwaGlsbWRAbGluYXJvLm9yZzsgYWxlQHJldi5u
ZzsgYW5qb0ByZXYubmc7DQo+IGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBb
UEFUQ0ggdjIgMy85XSBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgTWFyayBkZXN0X2lkeCBpbiB0
cmFucw0KPiBmdW5jdGlvbnMNCj4gDQo+IFdBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBm
cm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5DQo+IG9mIGFueSBsaW5rcyBv
ciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KPiANCj4gQ2hlY2sgdGhh
dCB0aGUgdmFsdWUgbWF0Y2hlcyBvcGNvZGVfcmVnaW5mby9vcGNvZGVfd3JlZ3MNCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+DQo+
IC0tLQ0KDQpSZXZpZXdlZC1ieTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQoNCj4g
IHRhcmdldC9oZXhhZ29uL2luc24uaCAgICAgICAgICAgICAgICAgICB8IDEgKw0KPiAgdGFyZ2V0
L2hleGFnb24vZGVjb2RlLmMgICAgICAgICAgICAgICAgIHwgMiArKw0KPiAgdGFyZ2V0L2hleGFn
b24vbW12ZWMvZGVjb2RlX2V4dF9tbXZlYy5jIHwgMiArKw0KPiAgdGFyZ2V0L2hleGFnb24vZ2Vu
X3RyYW5zX2Z1bmNzLnB5ICAgICAgIHwgNiArKysrKysNCj4gIDQgZmlsZXMgY2hhbmdlZCwgMTEg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2luc24uaCBi
L3RhcmdldC9oZXhhZ29uL2luc24uaA0KPiBpbmRleCAzNjUwMmJmMDU2Li5hNzcwMzc5OTU4IDEw
MDY0NA0KPiAtLS0gYS90YXJnZXQvaGV4YWdvbi9pbnNuLmgNCj4gKysrIGIvdGFyZ2V0L2hleGFn
b24vaW5zbi5oDQo+IEBAIC00MCw2ICs0MCw3IEBAIHN0cnVjdCBJbnN0cnVjdGlvbiB7DQo+ICAg
ICAgdWludDMyX3Qgd2hpY2hfZXh0ZW5kZWQ6MTsgICAgLyogSWYgaGFzIGFuIGV4dGVuZGVyLCB3
aGljaCBpbW1lZGlhdGUgKi8NCj4gICAgICB1aW50MzJfdCBuZXdfdmFsdWVfcHJvZHVjZXJfc2xv
dDo0Ow0KPiAgICAgIGludDMyX3QgbmV3X3JlYWRfaWR4Ow0KPiArICAgIGludDMyX3QgZGVzdF9p
ZHg7DQo+IA0KPiAgICAgIGJvb2wgcGFydDE7ICAgICAgICAgICAgICAvKg0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKiBjbXAtanVtcHMgYXJlIHNwbGl0IGludG8gdHdvIGluc25z
Lg0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMgYi90YXJnZXQvaGV4YWdv
bi9kZWNvZGUuYw0KPiBpbmRleCA0NTk1ZTMwMzg0Li5hNGQ4NTAwZmVhIDEwMDY0NA0KPiAtLS0g
YS90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYw0KPiArKysgYi90YXJnZXQvaGV4YWdvbi9kZWNvZGUu
Yw0KPiBAQCAtMTg0LDYgKzE4NCw4IEBAIGRlY29kZV9maWxsX25ld3ZhbHVlX3JlZ25vKFBhY2tl
dCAqcGFja2V0KQ0KPiANCj4gICAgICAgICAgICAgIC8qIE5vdyBwYXRjaCB1cCB0aGUgY29uc3Vt
ZXIgd2l0aCB0aGUgcmVnaXN0ZXIgbnVtYmVyICovDQo+ICAgICAgICAgICAgICBkc3RfaWR4ID0g
ZHN0c3RyIC0gb3Bjb2RlX3JlZ2luZm9bZGVmX29wY29kZV07DQo+ICsgICAgICAgICAgICBnX2Fz
c2VydChwYWNrZXQtPmluc25bZGVmX2lkeF0uZGVzdF9pZHggIT0gLTEgJiYNCj4gKyAgICAgICAg
ICAgICAgICAgICAgIHBhY2tldC0+aW5zbltkZWZfaWR4XS5kZXN0X2lkeCA9PSBkc3RfaWR4KTsN
Cj4gICAgICAgICAgICAgIHBhY2tldC0+aW5zbltpXS5yZWdub1t1c2VfcmVnaWR4XSA9DQo+ICAg
ICAgICAgICAgICAgICAgcGFja2V0LT5pbnNuW2RlZl9pZHhdLnJlZ25vW2RzdF9pZHhdOw0KPiAg
ICAgICAgICAgICAgLyoNCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL21tdmVjL2RlY29k
ZV9leHRfbW12ZWMuYw0KPiBiL3RhcmdldC9oZXhhZ29uL21tdmVjL2RlY29kZV9leHRfbW12ZWMu
Yw0KPiBpbmRleCBlOTAwN2Y1ZDcxLi5jMTMyMDQwNmRmIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQv
aGV4YWdvbi9tbXZlYy9kZWNvZGVfZXh0X21tdmVjLmMNCj4gKysrIGIvdGFyZ2V0L2hleGFnb24v
bW12ZWMvZGVjb2RlX2V4dF9tbXZlYy5jDQo+IEBAIC04Niw2ICs4Niw4IEBAIGNoZWNrX25ld192
YWx1ZShQYWNrZXQgKnBrdCkNCj4gICAgICAgICAgICAgICAgICAgICAgLyogc3RpbGwgbm90IHRo
ZXJlLCB3ZSBoYXZlIGEgYmFkIHBhY2tldCAqLw0KPiAgICAgICAgICAgICAgICAgICAgICBnX2Fz
c2VydF9ub3RfcmVhY2hlZCgpOw0KPiAgICAgICAgICAgICAgICAgIH0NCj4gKyAgICAgICAgICAg
ICAgICBnX2Fzc2VydChwa3QtPmluc25bZGVmX2lkeF0uZGVzdF9pZHggIT0gLTEgJiYNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICBwa3QtPmluc25bZGVmX2lkeF0uZGVzdF9pZHggPT0gZHN0
c3RyIC0gcmVnaW5mbyk7DQo+ICAgICAgICAgICAgICAgICAgaW50IGRlZl9yZWdudW0gPSBwa3Qt
Pmluc25bZGVmX2lkeF0ucmVnbm9bZHN0c3RyIC0gcmVnaW5mb107DQo+ICAgICAgICAgICAgICAg
ICAgLyogTm93IHBhdGNoIHVwIHRoZSBjb25zdW1lciB3aXRoIHRoZSByZWdpc3RlciBudW1iZXIg
Ki8NCj4gICAgICAgICAgICAgICAgICBwa3QtPmluc25baV0ucmVnbm9bdXNlX3JlZ2lkeF0gPSBk
ZWZfcmVnbnVtIF4gZGVmX29yZWc7DQo+IGRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5f
dHJhbnNfZnVuY3MucHkNCj4gYi90YXJnZXQvaGV4YWdvbi9nZW5fdHJhbnNfZnVuY3MucHkNCj4g
aW5kZXggOGFjZWNkYjk5My4uMTIwMTE3MmRkYSAxMDA3NTUNCj4gLS0tIGEvdGFyZ2V0L2hleGFn
b24vZ2VuX3RyYW5zX2Z1bmNzLnB5DQo+ICsrKyBiL3RhcmdldC9oZXhhZ29uL2dlbl90cmFuc19m
dW5jcy5weQ0KPiBAQCAtNjksNiArNjksNyBAQCBkZWYgbWFya193aGljaF9pbW1fZXh0ZW5kZWQo
ZiwgdGFnKToNCj4gICMjICAgICAgICAgaW5zbi0+cmVnbm9bMV0gPSBhcmdzLT5SczsNCj4gICMj
ICAgICAgICAgaW5zbi0+cmVnbm9bMl0gPSBhcmdzLT5SdDsNCj4gICMjICAgICAgICAgaW5zbi0+
bmV3X3JlYWRfaWR4ID0gLTE7DQo+ICsjIyAgICAgICAgIGluc24tPmRlc3RfaWR4ID0gMDsNCj4g
ICMjICAgICAgICAgcmV0dXJuIHRydWU7DQo+ICAjIyAgICAgfQ0KPiAgIyMNCj4gQEAgLTg2LDYg
Kzg3LDcgQEAgZGVmIGdlbl90cmFuc19mdW5jcyhmKToNCj4gICAgICAgICAgIiIiKSkNCj4gDQo+
ICAgICAgICAgIG5ld19yZWFkX2lkeCA9IC0xDQo+ICsgICAgICAgIGRlc3RfaWR4ID0gLTENCj4g
ICAgICAgICAgZm9yIHJlZ25vLCAocmVnX3R5cGUsIHJlZ19pZCwgKl8pIGluIGVudW1lcmF0ZShy
ZWdzKToNCj4gICAgICAgICAgICAgIHJlZyA9IGhleF9jb21tb24uZ2V0X3JlZ2lzdGVyKHRhZywg
cmVnX3R5cGUsIHJlZ19pZCkNCj4gICAgICAgICAgICAgIGYud3JpdGUoY29kZV9mbXQoZiIiIlwN
Cj4gQEAgLTkzLDYgKzk1LDkgQEAgZGVmIGdlbl90cmFuc19mdW5jcyhmKToNCj4gICAgICAgICAg
ICAgICIiIikpDQo+ICAgICAgICAgICAgICBpZiByZWcuaXNfcmVhZCgpIGFuZCByZWcuaXNfbmV3
KCk6DQo+ICAgICAgICAgICAgICAgICAgbmV3X3JlYWRfaWR4ID0gcmVnbm8NCj4gKyAgICAgICAg
ICAgICMgZGVzdF9pZHggc2hvdWxkIGJlIHRoZSBmaXJzdCBkZXN0aW5hdGlvbiwgc28gY2hlY2sg
Zm9yIC0xDQo+ICsgICAgICAgICAgICBpZiByZWcuaXNfd3JpdHRlbigpIGFuZCBkZXN0X2lkeCA9
PSAtMToNCj4gKyAgICAgICAgICAgICAgICBkZXN0X2lkeCA9IHJlZ25vDQo+IA0KPiAgICAgICAg
ICBpZiBsZW4oaW1tcykgIT0gMDoNCj4gICAgICAgICAgICAgIG1hcmtfd2hpY2hfaW1tX2V4dGVu
ZGVkKGYsIHRhZykNCj4gQEAgLTExNSw2ICsxMjAsNyBAQCBkZWYgZ2VuX3RyYW5zX2Z1bmNzKGYp
Og0KPiANCj4gICAgICAgICAgZi53cml0ZShjb2RlX2ZtdChmIiIiXA0KPiAgICAgICAgICAgICAg
aW5zbi0+bmV3X3JlYWRfaWR4ID0ge25ld19yZWFkX2lkeH07DQo+ICsgICAgICAgICAgICBpbnNu
LT5kZXN0X2lkeCA9IHtkZXN0X2lkeH07DQo+ICAgICAgICAgICIiIikpDQo+ICAgICAgICAgIGYu
d3JpdGUodGV4dHdyYXAuZGVkZW50KGYiIiJcDQo+ICAgICAgICAgICAgICAgICAgcmV0dXJuIHRy
dWU7DQo+IC0tDQo+IDIuMzQuMQ0KDQo=

