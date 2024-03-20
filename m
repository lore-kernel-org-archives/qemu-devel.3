Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BE8C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 11:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmuNy-0001Tf-Eh; Wed, 20 Mar 2024 07:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1rmuNv-0001TL-I4; Wed, 20 Mar 2024 07:45:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1rmuNm-0000N3-DQ; Wed, 20 Mar 2024 07:45:31 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42KBUHBY007878; Wed, 20 Mar 2024 11:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=qcppdkim1; bh=RS0wveTTHq3jp/pSIIvpp9p73S2iPrDVS0DQOsN9axI=; b=
 V2I7X0z5hklMNTEcmfSkvLWpp4NS4CnSGvuHwZ1GAXzGGF5Sd32gFt9qYt3AL9mK
 UPGVPBOq8CQtks8GESc/hkOOz4bV83czYRv0q49X8OrQ471VlJP+b1sxjjbh6DLJ
 PzLt6Q+XWzw0pxdaXPIlMz3Cu487cAfLS7+Ar1nSB3f0A8MICZ3gp+Jgvx0N/lZ0
 btL1p9akMX83jGCAziRwSzgktrEyrGs2/zaqMJJU9x7ScMWEflvNBg4rnlkuJiAf
 1mnjYj4wY4UCWFwRp54KR+vWpCpNUH9ofzeTSDD3SMwBAxtp2QqFOeBmkTy3Mctr
 LLWgVpKXxyfnmsiMyXxgtg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wypxq11kj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 11:45:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gExNFFdDn1NfwCIzwjaNsjC7E/f8uvx1EXGubr8i7onE2iSpX/Xw6J+rRzIUqSxSyfW0HDSbm7QnyDr/aBy7Hc7xnzLuVeLW0Fkii8CfNzym9aFnnATUz3eSEq9LTZlsN1LHJv9Mqq0JfzEQICw3H3ME4gwGKzolhgEpRzrUFvoX9bkDEDp/CbSc0xiPXXJrpKJKGXvfMGm+a/dsC/t+Pgu113v2kSbnKH4BAGOlV/ieC3JKMJSFw/fandrf7e1FhSd7ZU5fSzrcRbh5aA3kgjxsw8KSjsxXH84LxlNfwoOmmtEV7o2LbX0REJcFyukqr2HarrufvwWbMYAAIbgScg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RS0wveTTHq3jp/pSIIvpp9p73S2iPrDVS0DQOsN9axI=;
 b=cb+Bh3qBfEXcFl2+8Njyc9R34hjish79oUMl6QH4Y+WnqaXscYZVBmzQ8uzRg2XVMXjYTBeRc9ouNXZxFl0bxYWK5KZCvYHNwjttcQLb0DqDU22Ry7qti5tmbarNryiGRUR88c3sqE5W+W/HgrDSV5PquuqytBfxd/shF0DKNZjb7FbiBPwWSVr6lKrJLO9zOeCEMkxp62825wFNqUhH/01ouKkl0VJI+MO0voyrFIGOGanBg0sqkYfx0t5J7RmAhwgZZKchkTejqjqsNvOLnY5noJwsdViG/nCGMA6VDIjNttSNds07kH2jBPk4cZgrwPeL0GvTWLjQfJqGw2qGOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SJ2PR02MB9884.namprd02.prod.outlook.com (2603:10b6:a03:53a::21)
 by CH2PR02MB6918.namprd02.prod.outlook.com (2603:10b6:610:89::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Wed, 20 Mar
 2024 11:44:56 +0000
Received: from SJ2PR02MB9884.namprd02.prod.outlook.com
 ([fe80::f655:6bb8:2692:cb0f]) by SJ2PR02MB9884.namprd02.prod.outlook.com
 ([fe80::f655:6bb8:2692:cb0f%3]) with mapi id 15.20.7386.030; Wed, 20 Mar 2024
 11:44:56 +0000
From: Mark Burton <mburton@qti.qualcomm.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
CC: Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, "qemu-ppc@nongnu.org"
 <qemu-ppc@nongnu.org>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 0/4] hw/nmi: Remove @cpu_index argument
Thread-Topic: [PATCH 0/4] hw/nmi: Remove @cpu_index argument
Thread-Index: AQHaerh97y9neLDZOEe71DBZx3RqVrFAgpGA
Date: Wed, 20 Mar 2024 11:44:56 +0000
Message-ID: <328B70A2-6B3A-4AE2-ABB7-F6EE4363F8C2@qti.qualcomm.com>
References: <20240220150833.13674-1-philmd@linaro.org>
 <f4a6492b-cff4-439d-8f34-cdf04cb747ee@redhat.com>
 <cc132404-dcd5-4aed-a481-b46d6e3115b0@linaro.org>
In-Reply-To: <cc132404-dcd5-4aed-a481-b46d6e3115b0@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR02MB9884:EE_|CH2PR02MB6918:EE_
x-ms-office365-filtering-correlation-id: 79c61aef-d391-43c5-0cfe-08dc48d32a22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p1Vy64twf9D8XDwbzVUe2yILTN8NgXc0ryJfKwxGWF2ThqkI+Y96rm7nAACL6wrN6h+bu/QFmlrmmm+oqsdEc+OJX9rlAMP0i7blG6h9OemIbAXA1iFbKXdfPtJlKsFNjUxXZHxkFd0urB0moDlgQpvukylb4F4WreWsk0pswwBxR8qRONBQNKDln7yRDS1jduT4RWlkTntqjhSCVufg6T6uvRyvcENl53iOT9//h1KVWs/scgN96s15JUef8nbk9HN3GKkf4dz84iQF2IqOyvmJPVEKZurzCiCFMyxP2KIxvkl2AKL9xR3sYnshOuHj+KDXD6fGs2bwzCEe4l/xZtsi53X8Z7e8GGrnYzEnh9MttE0598yZ9Wo1NbeBssvg6OpT3I4SHUn7dbmaC9BXaPp+jciOSff2pE/MVu7XgunF6Eu7RcFcmzAyGS4t06WzlxZa3SsyV2howrl4s3eK28utlP1aVD8zLKqgI/Nndy9FyKF49JcxtmstugZ3ZbD7EI006fKHbop6+UwNkzyebf9ctnRx2gDuZ7RBA2MD9EmDIShKd3SFHwaxJZWtKhyKvAM9ZGGP03AsXw3KAZhp1oRGFRLhfZZaBdDZb0p8szpBHgvRvVu99/pMCl70x/yWc0lnkJZnw6RyhmgJeQ665droHezIZWLmvhUgIfzyH/CjqPuyITNv30kMPPjPwGXnItPoawlDC7Mc2kJ2xH4MZZANRAmB/Ye/GQ5snxVelhI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9884.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnZWb3lNRTlYbTd2OHl6ODlKcy9JNy9CcEpsYUxiYzdBbWNBeXpBZ3Y1SHBj?=
 =?utf-8?B?QXBDZjR5cTUvL0kxTVU5ZEZEQ2lKb3JDK3A4SHptTkIzanlWc2hhZ1pDSkVp?=
 =?utf-8?B?ZWNIR0hPSGVKUEhsOVVWa2thZEZQR0s3M2dEQkxqMnpkcmFubUxDa1Q3b2ln?=
 =?utf-8?B?b05JcWdibE9TTUVoTWhLby9MRUVrVnpZUHVBU09vZXp3TUluSVdZVDZYV0Fz?=
 =?utf-8?B?SCtjSXdDaHJSSllKRzJHaFRUVHdjQWg4VFRCWk9ZamNPRnlzQnpTTURrWGFr?=
 =?utf-8?B?ckxoT0xPOTU3TXNmY0dEY3ppT2tVSnprRi9CZzJ0aTJvSWVSUDVQc3ZZQ3NK?=
 =?utf-8?B?b2VuVFN6TVNwdUNYMUxnVEt6czVJYnhYUUFhUHNBQjVzeWVsMitSZktMWDRw?=
 =?utf-8?B?NEhLUExMRUcza3EwVlJ3VTAyQXFEakp0V0RmS2M5b0drLysvQmk4ZjB6WlFy?=
 =?utf-8?B?Vk5STm0rTFlYTjN2MGNYYVFtT0pxSDFwQmhmd1FQTmVZdXR4SWN2WEJTY3Vh?=
 =?utf-8?B?UlQwb091Q05NYUFOR0UxV0JISlYxa21qNmZBM3BCYXdUc2IrREFqdXpNRzBv?=
 =?utf-8?B?SnVJVTFnR21vNW8vazNGbHZQSk1lVXBGbEpaTE5FOXoxSFZEQUdQU3U1Qkhz?=
 =?utf-8?B?WW9JVFBLZmFLdTVFYUg3ckZBamxPajB0eTZhSlI5aWY2Sk5hcnhMVy92QVdw?=
 =?utf-8?B?V1VIY3FkUTBEaUlDSmNhSTBjcEtHQkZWcENsY3JqSDdrMmgxaUZLdjF5VndG?=
 =?utf-8?B?QVExbWVJcE9CamRkeDZDYnBrS0lLQ3llUkgxZVY5RW5kckU0L1FncFR0Tnh6?=
 =?utf-8?B?ajdEVzV5RVVMNUxKZURtSzZ6elNFS1l6dlAxT21RaXRISnlWVG1Sb3FSMlZq?=
 =?utf-8?B?c2F2M1VDMUxjZHFic3ZmcnUzdnBRbHNyRzJ2bEl2NUhXY1kyK2lySStvUTZ5?=
 =?utf-8?B?TEVkSEFqOFp6QThCTU5qYmUyQWsxSUN0eVlEK0hLbjhYZXRueStvb1gvdFM1?=
 =?utf-8?B?aUhUL2NGcnljbEUweTgxUE1LVnppY08rYmVPeXlhQnZwUXlTU25tYllyTjVM?=
 =?utf-8?B?aXlyMjNXZ2FGT1hEdlBxT056aW55a0lMa3Bnb0RCRXhOQnNibnd4emJ2eEsr?=
 =?utf-8?B?ZXZhdnNqdXNqOU9uVjdHVUsyZXlhNms5WitlQmZOSjYxMytpOXJNN0JDOFBi?=
 =?utf-8?B?a3U5UWgrNXN0SlB4d0VnNTNtTklLb3IxcTVUSStMUURtcjg5Mlh3K3lTTFNZ?=
 =?utf-8?B?dmRaaGROZXhIZWhyeXREZ1pjVjBqclY0aXUwK3VEbW9Dd2VvVGk0ZVpPOENU?=
 =?utf-8?B?Q2NkeTN5Uk1uK0lqSXVlNnF3eXVPa3A0MCsyM2YydzVaZ1FTM015OG4zNUta?=
 =?utf-8?B?TC83cmJlWDlsUzBGWHNpWFNqZnRQa3ZWYmJ0emVvVGJNaVlTbE0vbjE0L000?=
 =?utf-8?B?MjNIZFFRUWZUaTkveGsxMk50WVpaTk4rZDhSWTREZExLazIxd204U3Y4UUxm?=
 =?utf-8?B?eWkwWFFPVzJZKzZhYmljRVdvSzZoRmxxVDRiRXE1Szk2R1I1TjFxSDlGVDZh?=
 =?utf-8?B?NnEvc3lUb3ZNNW1QbjFOeVp6MVN6TUIyOTI4cmhRUGtGQ2ZFT0JZcDZiVk1L?=
 =?utf-8?B?ekhGaThBSlZFMmNhZk0yVmEwQVFTRFBCSDRid0tYSllQeVUybWtxMDBXR2l4?=
 =?utf-8?B?ajBnTG4ydm1SUDl0VFpFZ0txSHU4RWhYL1d0cnlZNXl3TlhSQlMwSjN5MWk0?=
 =?utf-8?B?cmNJNzg0VzNnSkJEaElCNnZVdkNZdVhDQ1FUZjB5Q2ppM1d1L1BEM3JRaEcw?=
 =?utf-8?B?NFBNTTRJd0JQck40VHprOHdhVFFUdnZiWVlZWExPdHhpa3paVVA3TitPR3RM?=
 =?utf-8?B?TW1JQiswSnNKYUFsYUFxUWRCdXZObklqcE1XdWpXSW11VkQydlpJbmxjSXA1?=
 =?utf-8?B?NGJCRWw4SHMzMFhiR3Zmc3MxbE41V1pScHN6V3U1MEJ4Ri94eFVZNE11STgr?=
 =?utf-8?B?TlpnK1dVNlFuYnB3dEJhb1M2WmlBMllEWGFpVk5VeHdCSkl0azM0aTZaWXVh?=
 =?utf-8?B?YndVODh4amhEM1pjbllqS1Qzb3VrRC9CV1lNQ05MeDZ0NnR1OXpDTU1TenRi?=
 =?utf-8?B?TVNVRTlRSzh3K0dXTUoyUy90LzEzMmFFZ0MveVFCemtObEZDNkhWUlBaQjdq?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2615A1875F018C4B8FFE6F955D107AE3@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BrsHXgJgOIYgorD9Uguz7sphtnQtkRrLiYnlhJqUAnEx252vx0epenrxa7e7V35Mapk2e8nfust6WgQoSsuzmB0PKD+ZsL/lsuiTPrWF3t8ED2I+jI6HXeEdeRv2tgN3bXYIzFQ87YRszpaP1a7EveL34gON9g5XckN12wJVAd4D+4N8ZiL8B+kKGC2g5UbuOz69e0J13lr1xGjP3uyipRDek+zupuWbGO02Xkb2EMp6Nf0513lgiIRT3AGdm1BmsDkPMFHfYwzomwXhE9e5IaIcf6UPmQh3M3SGvbKo7nuG2uTD6+YKdXzVYI3d9H9CqjcLTRYo7r5ZmYD+/JMGjN69yxFsNJ9TiXz4jvpV5WiXzx5mPZX+jZg/8RtTz0l1L2DcKCV4ZdxYO2n/XBteodDOMnOYc8UK03PohTWc2ptEusSkWXJgGpC5b5OCr8aTISCyAt93/x7TpNvYshpgk8z88OGh+w9Pmf6M6xpOQpJS30HIfMIqJl5xfwoqoW/5woVKL/GE5OviHm/KI/CyakiGFPHnZy3wh1UAQhVrbD3JeXWrcN2tkzZoZD46nz15Wh7h98aVraDpMVUnBjQZytAJ1WSGFUE2UFKAQvaUt+6w8SBRwwsgVQ53s/8tHMw2
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9884.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c61aef-d391-43c5-0cfe-08dc48d32a22
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 11:44:56.1446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qpXu13Um9Qwbqb09lmdMaIqwwaX1iziVf3iz8hW7UUVSIpiEQy2Naqt2d8dgTYAXsYLPFRsOw7zAVe7DBu9PHCRHPj2jJO6pZqg9R8UaPm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6918
X-Proofpoint-ORIG-GUID: xS0CCxWoP7IvBrGfp8Mc0HViF_gCr7E4
X-Proofpoint-GUID: xS0CCxWoP7IvBrGfp8Mc0HViF_gCr7E4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403200093
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mburton@qti.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

DQoNCj4gT24gMjAgTWFyIDIwMjQsIGF0IDEyOjE5LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8
cGhpbG1kQGxpbmFyby5vcmc+IHdyb3RlOg0KPiANCj4gV0FSTklORzogVGhpcyBlbWFpbCBvcmln
aW5hdGVkIGZyb20gb3V0c2lkZSBvZiBRdWFsY29tbS4gUGxlYXNlIGJlIHdhcnkgb2YgYW55IGxp
bmtzIG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90IGVuYWJsZSBtYWNyb3MuDQo+IA0KPiBPbiAy
MC8yLzI0IDE2OjE5LCBUaG9tYXMgSHV0aCB3cm90ZToNCj4+IE9uIDIwLzAyLzIwMjQgMTYuMDgs
IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4+IEhhdmUgczM5MHggYWx3YXlzIGRl
bGl2ZXIgTk1JIHRvIHRoZSBmaXJzdCBDUFUsDQo+Pj4gcmVtb3ZlIHRoZSBAY3B1X2luZGV4IGFy
Z3VtZW50IGZyb20gaGFuZGxlciwNCj4+PiByZW5hbWUgQVBJIGFzIG5taV90cmlnZ2VyKCkgKG5v
dCBtb25pdG9yIHNwZWNpZmljKS4NCj4+IA0KPj4gQ291bGQgeW91IHBsZWFzZSBhZGQgc29tZSBy
YXRpb25hbGUgaGVyZSB3aHkgdGhpcyBpcyBuZWVkZWQgLyBkZXNpcmVkPw0KPiANCj4gSSdtIG5v
dCBzdXJlIGl0IGlzIGRlc2lyZWQuLi4gSSdtIHRyeWluZyB0byBnZXQgdGhlIE5NSSBkZWxpdmVy
eQ0KPiB3b3JraW5nIGluIGhldGVyb2dlbmVvdXMgbWFjaGluZSwgYnV0IG5vdyBJJ20gd29uZGVy
aW5nIHdoZXRoZXINCj4gaHcvY29yZS9ubWkuYyB3YXMgZGVzaWduZWQgd2l0aCB0aGF0IGluIG1p
bmQgb3IgbGlrZWx5IG5vdC4NCj4gDQo+IEkgc3VwcG9zZSBpbiBhIGNvbXBsZXggbWFjaGluZSB5
b3UgZXhwbGljaXRseSB3aXJlIElSUSBsaW5lcyBzdWNoDQo+IE5NSSwgc28gdGhleSBhcmUgZGVs
aXZlcmVkIHRvIGEgcGFydGljdWxhciBJTlRDIG9yIENQVSBjb3JlLCBhbmQNCj4gdGhlcmUgaXMg
bm8gImJyb2FkY2FzdCB0aGlzIHNpZ25hbCB0byBhbGwgbGlzdGVuZXJzIHJlZ2lzdGVyZWQNCj4g
Zm9yIE5NSSBldmVudHMiLg0KPiANCg0KSSB0aGluayB0aG9zZSB0d28gdGhpbmdzIGFyZSBzb3J0
IG9mIHNpbWlsYXIuIGUuZy4gd2UgY291bGQgaGF2ZSBhIG1hY2hpbmUgaW4gd2hpY2ggbWFueSBv
ZiB0aGUgY29tcG9uZW50cyBhbGwgcmVjZWl2ZSBhIOKAmHJlc2V04oCZIHNpZ25hbCwgYnV0IHRo
YXQgd291bGQgaW5kZWVkIGJlIHdpcmVkIHVwIGV4cGxpY2l0bHkgZnJvbSB0aGUgdGhpbmcgZ2Vu
ZXJhdGluZyB0aGF0IHJlc2V0IHNpZ25hbCBhbmQgYWxsIHRoZSBjb21wb25lbnRzIHdhbnRpbmcg
dG8gcmVjZWl2ZSBpdC4gQW5kLCB5ZXMsIHRoZXJlIG1heSBiZSBjb21wb25lbnRzIHRoYXQgYXJl
IG5vdCByZXNldCBieSB0aGF0IHNpZ25hbOKApi4NCg0KQ2hlZXJzDQpNYXJrLg0KDQoNCj4+IA0K
Pj4gVGhhbmtzLA0KPj4gIFRob21hcw0KPj4gDQo+PiANCj4+PiBQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqSAoNCk6DQo+Pj4gICBody9ubWk6IFVzZSBvYmplY3RfY2hpbGRfZm9yZWFjaF9yZWN1cnNp
dmUoKSBpbiBubWlfY2hpbGRyZW4oKQ0KPj4+ICAgaHcvczM5MHgvdmlydGlvLWNjdzogQWx3YXlz
IGRlbGl2ZXIgTk1JIHRvIGZpcnN0IENQVQ0KPj4+ICAgaHcvbm1pOiBSZW1vdmUgQGNwdV9pbmRl
eCBhcmd1bWVudCBmcm9tIE5NSUNsYXNzOjpubWlfaGFuZGxlcigpDQo+Pj4gICBody9ubWk6IFJl
bW92ZSBAY3B1X2luZGV4IGFyZ3VtZW50IGZyb20gbm1pX3RyaWdnZXIoKQ0KPiANCg0K

