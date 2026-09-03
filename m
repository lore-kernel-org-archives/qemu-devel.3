Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFEEC624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x27BY-0004uT-Lg; Thu, 03 Sep 2026 09:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x27BW-0004sz-2U; Thu, 03 Sep 2026 09:08:54 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x27BU-0007b4-3Q; Thu, 03 Sep 2026 09:08:53 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683CAFiH255409; Thu, 3 Sep 2026 06:08:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=G4JvIVUy38STgkSmkD9XsYzkIhWsSinfaiNvHo0JX
 kY=; b=jsT3pnf2TskEJeO13XKsNXqfG+kwTzJdDOLOTbhnXQ9mcl6AUXaNo9hiQ
 IHC+IQ4i2R1iBWfLh4DIfb/8oIRi4iqInKMmw3EM8k4t2KfrsZOjScS2HtVInJPn
 CvKGXA3Q6SwAbJd1x4vYrGHg4CAN93BEayyIymx8meCYvc2fDtbbm4tvou6L8pQn
 7ra1QutvKh2R1I1GwI9dddR0cZNuqTdmgGqR8nUm60dZ7SPCWqIYNAxNDP9cw2oQ
 WjEWzfhvf3QJu4Kt2zwomjtf0QC0AChdoMxQQ2GPe46hZSjxDoVolyYv6uKKHWUi
 BMRRmW9bN/WHLVMxmjp+eCkeWbvxQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023132.outbound.protection.outlook.com
 [40.107.201.132])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gf8nm0473-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 06:08:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fx05eGoxZSr3gR6nTzP+v+b5wHi6bwVgPoS8sKTCSSa0vljaR7cfEBSYh3GnmACyNIwmdJum2Tuz5rXXgnGa9UBOdAo9wA5L+aQ6S0HFESTtIv9iOkodbijdaNIC3tzyN2F+FicJ3VLuE6wzrqe8f7lI+MG4MNSH5c+21J/Yciej42q90HFg56J8rIdfmwwayHH+JUF8QXVpIRIRW4fADm2U5Qd5YPuRQb1tppiIQCTHvdrzZQcW7kDnEgisHuLsS7p2L1vXUqCciTlJ1H6wdlj8Gf5eqm2UTUG/vcfNOO/FyLE4xoBOFNLcasdnBnIW0WJ5d9aVqEiJHc5Fywk2Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4JvIVUy38STgkSmkD9XsYzkIhWsSinfaiNvHo0JXkY=;
 b=fjlzAN8KTI0uHBalMWB7z6H0k6oK0gJJLk5slVwqnwCbFja4rcMJ3yWFcHeonlqVvVeQCH222FlNbtobY+K0NIOdTa1jY/nMqZTcn+zjxrDWDqiPpSeWtgv14PQBRv0IAVadHruNDEOJeTOllqzH5RKNYapvZnKF20tQylJ947QB4OX2Zrs/hI+ughosMrRCHdUnxLwwyCXH+uriWSN2qufrLbG0Etmk3vTuNCYrivIiBLRWGgSVyFe9cjyFtvCX8nwHZBcfUfxWkSlcvxfzVrw/uzflG38g4pTk3o68SQXl5dTmmuxF4T3h1Ht3+fxoEQ/6aLnWW/LtOyzm/xnasA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4JvIVUy38STgkSmkD9XsYzkIhWsSinfaiNvHo0JXkY=;
 b=oWVPZ003PMB8r+iAVRGiMAdoB4/ACR5F186weyHZ1292NXVGwuXIUAGso6H8eo8kEKyXTNzCu0MnfyxEIYWpIsBqFII1h8m7kNquK0otRTZWWRDmDjEzgY0SK+ydm56i/G/Qo7gxxKD+Cr4FMHjmhAEC5jPSeZ0cU/DE+kicq1ocrIm9lsihqOZwozeV90ucFVSDGS2t3X7mNF8KWIbDsFW5GOjiwt4V6iE0PJSPUw5dkriln7hDAnUtejZ2PIAXEtQhr9YJwdpZ3AopSoRT4HpTyn5TjKYvUMUh1p/E7I2CxkJYe7ACroYHLOqbXAIoh+B1GcdvlD2tA3hAA886Qw==
Received: from DM6PR02MB6172.namprd02.prod.outlook.com (2603:10b6:5:1fe::18)
 by PH8PR02MB11926.namprd02.prod.outlook.com (2603:10b6:510:40a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 13:08:44 +0000
Received: from DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd]) by DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd%6]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 13:08:44 +0000
From: Hugo Komatsu <hugo.komatsu@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Alex Williamson
 <alex@shazbot.org>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Rafael Castillo <rafael@trfs.me>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH 3/8] vfio: route device_feature through io_ops
Thread-Topic: [PATCH 3/8] vfio: route device_feature through io_ops
Thread-Index: AQHdO6VYcSvndu1zr0SqlsTDC8ckEg==
Date: Thu, 3 Sep 2026 13:08:43 +0000
Message-ID: <20260903130833.1437632-4-hugo.komatsu@nutanix.com>
References: <20260903130833.1437632-1-hugo.komatsu@nutanix.com>
In-Reply-To: <20260903130833.1437632-1-hugo.komatsu@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB6172:EE_|PH8PR02MB11926:EE_
x-ms-office365-filtering-correlation-id: 716ef00a-d5d0-4b42-8143-08df09bc7b7a
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|22082099003|56012099006|10067099003|18002099003|38070700021;
x-microsoft-antispam-message-info: AKiGzLe1kAG6ix8NeAaemjdIJNF9dibxPJE0+2QBqg5uoNRzsqYmTsy8Z8RXGV0sH8ULUL0twzFDwXCAv334qaOHmXb99MLUNbomwnFYBW1Watc3/qQpLj6hIaFlEwH4Kh5Zqr9nnp061G0+QD0HbMFQdFGaaLlEUDvRyg1whJIBv1KevGKgQ17kUrfuQRF1SCoF5e6Ozqy6pzcP2vIrgZfIWEmW+Q0HDNZHlryXEQ6BZ7C9sOzue4NGxE0H9negYGKeu0M/t2PHakbRfzbWOnJsvOMSUEgl2vBf22AjZzHxUy4A+10Tubuk0LtMbTue3Rwr0+zQDpF1Ux/0zuOahJXd9Bnlcz/JVQ9fi4tMMvqsi9VM4BDOFnpcs6PhtaO0CNTN8QBH2TF8ItAuPzsEiOq08j+7D1VLyiReKeMu1vuD1IZ6rnKHYwe5s09yrJqPEMJs+RA5ibJQGUT9xkbda7oE6ErXk9TDV3X51X9xGUSfNRqHuLDkSBxuO48++cP17SJ/FO08CXpfPCmGsaYreQEoJ90uMpNrw7JwmBT59evabaEmhJDpPqll8n6KtuJU7oE2YAYIr4LiVlqx95l1gDfy3ltNLWVCeWmGXdZqKXih/baLxNKyIwgwaTT4r0i79dyZENfjxMbPkMrFSs8Y+SjGgKgi898kVqVP/pFqw7rA5727q3AmAiS+u1oeisS6gD8JdTGZvzCx/BxWDvqODaGzA1BJe/sbke5Nr46seH0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR02MB6172.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(22082099003)(56012099006)(10067099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGVCT2Rxa2xFNlRKU1phL2xDM3B1NjkvNENJUW9oYUpnMWE3ZVlZMEFpYmxk?=
 =?utf-8?B?SWJFakRIYStpQnY2Yy9PRDRCR3RJQ2JHMTNkejRyZ0hIMUg4MUpWcHpWRG5K?=
 =?utf-8?B?TmJjbUhWdVdWaWcwTWZUbnVjUGc2SHowUXVQNjJ1bW9UVlNmZisrM0RZM1F1?=
 =?utf-8?B?Njc5L0t0a1haREN2Z3RLWFpVVXZEWU82RC91K1dLS1Y4MzFmWDl4TFcxTVFm?=
 =?utf-8?B?YUdKcWRWemwrWTBWTzYyeWNUb1FEcEllWkMvS1ZlcnpvRkYrcVd0L2loTTZE?=
 =?utf-8?B?OVl2ZFlUYzBKRzk0R2tDdXhhNVJtR1lKOGtEK2g0MHVDVzFLTFVSejgyQ1Ix?=
 =?utf-8?B?K3grOUZVWktiS1ZsZzFlbVAyK3pvUmhFSm9pUVlFb1kwOXV0bTdlZkRzcWc3?=
 =?utf-8?B?QUxqN1lDMTJFMWNOaFBtRXdHekhVS3cwSFVLbmh3aVBTOXZoVzhOSkxiMmQr?=
 =?utf-8?B?ZE4wcUZZSHZvUzFsNlJZNVdCWithMjBhY2Y3NndEbUVCM2NIQWFOcHBOUGNI?=
 =?utf-8?B?cmhPbG9yNWR6cDQ2YU5zMVhHNWJsUEZySk5NbEgyMkZPaGxsa242YnRwSU03?=
 =?utf-8?B?YnFEcEhuS200Yy9LTEVwZXAvVitKb2sxcmpVUVFMV01ZZTVremJ1SzJyTCtF?=
 =?utf-8?B?ajVkVldPOURoZklqODRqVXVMMTEvKzVOWVhOeDVBOVBGTFJNVFkvdk12OVdF?=
 =?utf-8?B?RXRlSkNqWDlPNWF0OXF4Tk9ySEpLZVMvdzJBVmZ2N1Ric3B3SHdmOFdna1ds?=
 =?utf-8?B?RjBUNThaL2Nta0tsUDNFeGMyUXVISkRmY05JU3pMYUZFZDlMallqQ1FqOXJV?=
 =?utf-8?B?bFo1T2xQdERJWnpXQk4vTERuSFMyVDZjSHJFSWRCUWxGdEp6c2k0a2pFREda?=
 =?utf-8?B?VU85d2w3RENGUG11WnhoREsvdkxqRDcyL1kzTVhCU2ErUGpqVS9lK21rbTJZ?=
 =?utf-8?B?emtYUXo5MTRWNm5ROGljRWR4eGdCTnJDS2RTSFZZZUhXNE5SZjJCNStMVmJZ?=
 =?utf-8?B?Zm1MSlNnT0pKVENxeS9lalIwS2N0VDNoOExlZlZ1bmpkd0daZ1hBTnNhWlEv?=
 =?utf-8?B?Ym9qekRvTW1NOU5XU0VMSHBhcGtiQnN6WnNQSEJ5VHB5QmtLRDVvUUFXcXgw?=
 =?utf-8?B?dUlTTzViKzRhWGlmWVBnMWxSd2llcERxazhvOWpQMmRFUE1vS2J0bDRHem9G?=
 =?utf-8?B?QnNtRzdGTW5LRDJBa1NKUVd4NlYwL1dwSS9JUTJXWmVpekI4WDNHTEF2bm5r?=
 =?utf-8?B?cjF4NUh0TWtYNVI0S01RTEkwVUxmRjZ5a2U0WmlIODlqd3JWajlZUGh6SnNF?=
 =?utf-8?B?SlhIelI1WjhGeGh0OEQvRFk5OTkyV00rckx3cXk5SFhORW9QSVZqUEdFbENu?=
 =?utf-8?B?dlBDZDJGYU5NR2s0dnJvZWpJS3hnK0oydmQ0cTh5QmVzY0Q2YVNZeDJwVUxE?=
 =?utf-8?B?ZmlQUEIvTFhjcFlsTmpYS1pETzAzZkRBcjlMRjNQeTFYdGE5T1RYQ2VoMVFR?=
 =?utf-8?B?bzZUNlVlblRWSVhrWldEU3MxVU05L3dDbEhKTjVob0VITkliTTRSYURWY2xp?=
 =?utf-8?B?eGQ5M24wMStpVy9iV25FYWlNajExQlJ4Z0Nyd0JyakQ3MUpXZUs1Ni93bndZ?=
 =?utf-8?B?QVlaQ0ljWmxSVkpMMVBOWlRrSmwxTVRDdEEwWFVXaGFyYVhvNHZwaFVScmxS?=
 =?utf-8?B?YXh6Ky9yVTUrRUxBeXpBM1VOajBLTmc3c0E2bjl4cWhhMUdmcEdGQWxVWUFT?=
 =?utf-8?B?b2s0MVE2QSthYk80OWgwQnJWUmRSdUxNTERPKzg0bkJFUmx4Q0pPLzdmS1hQ?=
 =?utf-8?B?TUdWTkhpL1JJOHVKblh2SCttS0dEMDZGYWt1TEo3bkNDY2JWdGFBTjhVbUd4?=
 =?utf-8?B?VkdnelYweUN0Qm1vdTFSUDNmcndXMjdJQ3hKMTRNNjg1MzQ5UHk0NW12RVZi?=
 =?utf-8?B?S2hTT1d6dXZueWVMbFdDcG9RVkwxUmdiWVBITkFNRGl2ZWpqUjdZL25NUWlQ?=
 =?utf-8?B?anNNQ1oxSFhxaU95dWF1dGswcmxWUTNlUG9ZTEFuRUhSYUNwMmRBZnZUZW1E?=
 =?utf-8?B?akZvZ1E2WUVpZGpkOWR4Mlp4alFFZEt1bW9saTRJcytJNGN0eTZ5alpGNlpk?=
 =?utf-8?B?YU1OY05veUw1WjVpVFVzN2pmN2pXQ3V4aGJtaGViVjAwVlY4V1ZaMExib3Qx?=
 =?utf-8?B?V1hZeFByelFnYlUrTWQwTVlwWXgxQmd2M0hjODRHanFLdjE2ekI3K0hLU0o2?=
 =?utf-8?B?ZFUwbm5lZSs2eVg2eEdiZ3l6RGV3dG1zUnlLVzlMWUFpNWp3R1NRMmxVVFJX?=
 =?utf-8?B?cHpoVldZWWF3bWFpeHd3cUlvUVdoSUczNkJBeTdEK2F0ZXMwM2NlUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hlo0Y2bE8rY+ryvjIq/y7LgfyAbn9i8ROhTWup7a71E1QuHsIbaWsQePHLkEuTIatltZ2xUN9A2WPuO5UPcl/AppuUYsqb74D2WSwOFbYtjDok5kZ+j8o8pqD8KLXlHEMdnZuExpmlP+A1MUVpxC4Cq4lAwKLIVtNtolx/lK3cKmQr9LEeVRkBvKpwUTlKTRo0C7EQmvTMzBlJKkEfqZkSrWqV4vOEDgbTmLOn3Tdk1geoMzRddQxVmp8c4tl6G634IV1P0HpL1y/U7x1SD1Y3fZ+ftMUuMbpNXn7kdiwhfhjf1NEToFzRLIDHegLtCHjplg4Abgi8Z0n751nXRTUQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6172.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716ef00a-d5d0-4b42-8143-08df09bc7b7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 13:08:43.9889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d43W9DSDuS0iT+a6N7Uop/3VEE8xHIqdtGjY5W36RQPxtOvGlpqwqoEGvELD+4D2R+n1SmGghIYGVKdDh+8BU2aU5584l34njXJ2RkiOkwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR02MB11926
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDExMyBTYWx0ZWRfX5dgXCUF7zIt/
 D8e0/jVgCdu2MR2CmSAdHNyLE03AlS7FRJJYBC5reqR1tvr39v1qEr8ogWQjnjtFK4ccIv9LjQN
 qmxYNlqMdFYWI/uJq+Q2npkto0h5mEg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDExMyBTYWx0ZWRfX4P2sMkESwgLv
 u/nLC2bMh/Dq+CgULI5mN3wIXj/nEfckZawjm0RsUjv5fkgHX9AOrj3pjeOaal0E/yZJj6aMeY5
 21BpDwt92g8huS0ZVOUdRxB/H+C63GOLYzF5ysC5S7Dd7uoGq2IznMR7Xh1EYZc80fWZTN38JRq
 dVHZvlDaptj9mnfMNO9piut8Ww1Ztk5Yr8eBWtC89jhlbxO4/k4ZTagro/wCLt8ip9JccQy5Yut
 hfiay24B47ZrW1YeYwjHYiEocIaHBAJAZ3zX52IFoJ+woXNONRD6J+maveTIjCvGIoo7g0hswEb
 xvJKRXa2SLYKTL0tAWiXUnCfvH1AkQ04tUw7gMWovcC+HiD5T2MeWjkp3mZP3U1hxx6VSN3U3ch
 yT6aRNbOotHdjAzP4GviAF6F8HrJ0ogtwJLVpBmk9cRKq//MMpEL8s+c/Kt7jRGCJJ8rcOurJF4
 IZzLJKtV7IzcTDWinUQ==
X-Authority-Analysis: v=2.4 cv=TK11jVla c=1 sm=1 tr=0 ts=6a99715e cx=c_pps
 a=QUIaisbnC9uoo+9AoKvuvw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22 a=64Cc0HZtAAAA:8
 a=zJUJncWPgEQX1PoTMd4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: S8-DcXpIqMjVi--z2oE5qWguxpjIINo4
X-Proofpoint-GUID: S8-DcXpIqMjVi--z2oE5qWguxpjIINo4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=hugo.komatsu@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

VGhlIGdlbmVyaWMgVkZJTyBtaWdyYXRpb24gY29kZSBpbiBody92ZmlvL21pZ3JhdGlvbi5jIGlz
c3VlIGtlcm5lbAppb2N0bHMgZGlyZWN0bHkgZm9yIFZGSU9fREVWSUNFX0ZFQVRVUkUuIFJvdXRl
IHRoZXNlIHRocm91Z2ggdGhlCmV4aXN0aW5nIFZGSU9EZXZpY2VJT09wcyB0YWJsZSBzbyBhbiBh
bHRlcm5hdGUgdHJhbnNwb3J0ICh2ZmlvLXVzZXIpCmNhbiBzdXBwbHkgaXRzIG93biBpbXBsZW1l
bnRhdGlvbi4KCkltcGxlbWVudCB0aGUga2VybmVsIHZlcnNpb24gYXMgYSB0aGluIHdyYXBwZXIg
YXJvdW5kIHRoZSBleGlzdGluZwppb2N0bCgpIGNhbGwuIFRoaXMgaXMgYSBwdXJlIHByZXBhcmF0
b3J5IHJlZmFjdG9yOiB0aGUga2VybmVsIHBhdGgKaXMgdW5jaGFuZ2VkLgoKQ28tYXV0aG9yZWQt
Ynk6IFJhZmFlbCBDYXN0aWxsbyA8cmFmYWVsQHRyZnMubWU+ClNpZ25lZC1vZmYtYnk6IEh1Z28g
S29tYXRzdSA8aHVnby5rb21hdHN1QG51dGFuaXguY29tPgotLS0KIGh3L3ZmaW8vbWlncmF0aW9u
LmMgfCAyOSArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE0
IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2h3L3ZmaW8vbWln
cmF0aW9uLmMgYi9ody92ZmlvL21pZ3JhdGlvbi5jCmluZGV4IDczYzQ5ZDhjMjQuLmVhNjczNDgy
M2IgMTAwNjQ0Ci0tLSBhL2h3L3ZmaW8vbWlncmF0aW9uLmMKKysrIGIvaHcvdmZpby9taWdyYXRp
b24uYwpAQCAtMTY4LDMzICsxNjgsMzAgQEAgaW50IHZmaW9fbWlncmF0aW9uX3NldF9zdGF0ZShW
RklPRGV2aWNlICp2YmFzZWRldiwKICAgICBmZWF0dXJlLT5mbGFncyA9CiAgICAgICAgIFZGSU9f
REVWSUNFX0ZFQVRVUkVfU0VUIHwgVkZJT19ERVZJQ0VfRkVBVFVSRV9NSUdfREVWSUNFX1NUQVRF
OwogICAgIG1pZ19zdGF0ZS0+ZGV2aWNlX3N0YXRlID0gbmV3X3N0YXRlOwotICAgIGlmIChpb2N0
bCh2YmFzZWRldi0+ZmQsIFZGSU9fREVWSUNFX0ZFQVRVUkUsIGZlYXR1cmUpKSB7CisgICAgcmV0
ID0gdmJhc2VkZXYtPmlvX29wcy0+ZGV2aWNlX2ZlYXR1cmUodmJhc2VkZXYsIGZlYXR1cmUpOwor
ICAgIGlmIChyZXQpIHsKICAgICAgICAgLyogVHJ5IHRvIHNldCB0aGUgZGV2aWNlIGluIHNvbWUg
Z29vZCBzdGF0ZSAqLwotICAgICAgICByZXQgPSAtZXJybm87Ci0KICAgICAgICAgaWYgKHJlY292
ZXJfc3RhdGUgPT0gVkZJT19ERVZJQ0VfU1RBVEVfRVJST1IpIHsKLSAgICAgICAgICAgIGVycm9y
X3NldGdfZXJybm8oZXJycCwgZXJybm8sCisgICAgICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVy
cnAsIC1yZXQsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICIlcyBSZWNvdmVyIHN0YXRl
IGlzIEVSUk9SLiBSZXNldHRpbmcgZGV2aWNlIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZXJyb3JfcHJlZml4KTsKLQogICAgICAgICAgICAgZ290byByZXNldF9kZXZpY2U7CiAgICAg
ICAgIH0KIAotICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIGVycm5vLAorICAgICAgICBl
cnJvcl9zZXRnX2Vycm5vKGVycnAsIC1yZXQsCiAgICAgICAgICAgICAgICAgICAgICAgICAgIiVz
IFNldHRpbmcgZGV2aWNlIGluIHJlY292ZXIgc3RhdGUgJXMiLAogICAgICAgICAgICAgICAgICAg
ICAgICAgIGVycm9yX3ByZWZpeCwgbWlnX3N0YXRlX3RvX3N0cihyZWNvdmVyX3N0YXRlKSk7CiAK
ICAgICAgICAgbWlnX3N0YXRlLT5kZXZpY2Vfc3RhdGUgPSByZWNvdmVyX3N0YXRlOwotICAgICAg
ICBpZiAoaW9jdGwodmJhc2VkZXYtPmZkLCBWRklPX0RFVklDRV9GRUFUVVJFLCBmZWF0dXJlKSkg
ewotICAgICAgICAgICAgcmV0ID0gLWVycm5vOworICAgICAgICBpbnQgcmVjb3Zlcl9yZXQgPSB2
YmFzZWRldi0+aW9fb3BzLT5kZXZpY2VfZmVhdHVyZSh2YmFzZWRldiwgZmVhdHVyZSk7CisgICAg
ICAgIGlmIChyZWNvdmVyX3JldCkgewogICAgICAgICAgICAgLyoKICAgICAgICAgICAgICAqIElm
IHNldHRpbmcgdGhlIGRldmljZSBpbiByZWNvdmVyIHN0YXRlIGZhaWxzLCByZXBvcnQKICAgICAg
ICAgICAgICAqIHRoZSBlcnJvciBoZXJlIGFuZCBwcm9wYWdhdGUgdGhlIGZpcnN0IGVycm9yLgog
ICAgICAgICAgICAgICovCiAgICAgICAgICAgICBlcnJvcl9yZXBvcnQoCiAgICAgICAgICAgICAg
ICAgIiVzOiBGYWlsZWQgc2V0dGluZyBkZXZpY2UgaW4gcmVjb3ZlciBzdGF0ZSwgZXJyOiAlcy4g
UmVzZXR0aW5nIGRldmljZSIsCi0gICAgICAgICAgICAgICAgICAgICAgICAgdmJhc2VkZXYtPm5h
bWUsIHN0cmVycm9yKGVycm5vKSk7Ci0KKyAgICAgICAgICAgICAgICAgICAgICAgICB2YmFzZWRl
di0+bmFtZSwgc3RyZXJyb3IoLXJlY292ZXJfcmV0KSk7CiAgICAgICAgICAgICBnb3RvIHJlc2V0
X2RldmljZTsKICAgICAgICAgfQogCkBAIC0zNDcsMTMgKzM0NCwxMyBAQCBzdGF0aWMgaW50IHZm
aW9fcXVlcnlfc3RvcF9jb3B5X3NpemUoVkZJT0RldmljZSAqdmJhc2VkZXYpCiAgICAgZmVhdHVy
ZS0+ZmxhZ3MgPQogICAgICAgICBWRklPX0RFVklDRV9GRUFUVVJFX0dFVCB8IFZGSU9fREVWSUNF
X0ZFQVRVUkVfTUlHX0RBVEFfU0laRTsKIAotICAgIGlmIChpb2N0bCh2YmFzZWRldi0+ZmQsIFZG
SU9fREVWSUNFX0ZFQVRVUkUsIGZlYXR1cmUpKSB7CisgICAgcmV0ID0gdmJhc2VkZXYtPmlvX29w
cy0+ZGV2aWNlX2ZlYXR1cmUodmJhc2VkZXYsIGZlYXR1cmUpOworICAgIGlmIChyZXQpIHsKICAg
ICAgICAgLyoKICAgICAgICAgICogSWYgZ2V0dGluZyBwZW5kaW5nIG1pZ3JhdGlvbiBzaXplIGZh
aWxzLCBWRklPX01JR19TVE9QX0NPUFlfU0laRQogICAgICAgICAgKiBpcyByZXBvcnRlZCBzbyBk
b3dudGltZSBsaW1pdCB3b24ndCBiZSB2aW9sYXRlZC4KICAgICAgICAgICovCiAgICAgICAgIG1p
Z3JhdGlvbi0+c3RvcGNvcHlfc2l6ZSA9IFZGSU9fTUlHX1NUT1BfQ09QWV9TSVpFOwotICAgICAg
ICByZXQgPSAtZXJybm87CiAgICAgICAgIHdhcm5fcmVwb3J0X29uY2UoIlZGSU8gZGV2aWNlICVz
IGlvY3RsKFZGSU9fREVWSUNFX0ZFQVRVUkUpIG9uICIKICAgICAgICAgICAgICAgICAgICAgICAg
ICAiVkZJT19ERVZJQ0VfRkVBVFVSRV9NSUdfREFUQV9TSVpFIGZhaWxlZCAoJWQpIiwKICAgICAg
ICAgICAgICAgICAgICAgICAgICB2YmFzZWRldi0+bmFtZSwgcmV0KTsKQEAgLTEwOTQsMTEgKzEw
OTEsMTMgQEAgc3RhdGljIGludCB2ZmlvX21pZ3JhdGlvbl9xdWVyeV9mbGFncyhWRklPRGV2aWNl
ICp2YmFzZWRldiwgdWludDY0X3QgKm1pZ19mbGFncykKICAgICBzdHJ1Y3QgdmZpb19kZXZpY2Vf
ZmVhdHVyZSAqZmVhdHVyZSA9IChzdHJ1Y3QgdmZpb19kZXZpY2VfZmVhdHVyZSAqKWJ1ZjsKICAg
ICBzdHJ1Y3QgdmZpb19kZXZpY2VfZmVhdHVyZV9taWdyYXRpb24gKm1pZyA9CiAgICAgICAgIChz
dHJ1Y3QgdmZpb19kZXZpY2VfZmVhdHVyZV9taWdyYXRpb24gKilmZWF0dXJlLT5kYXRhOworICAg
IGludCByZXQ7CiAKICAgICBmZWF0dXJlLT5hcmdzeiA9IHNpemVvZihidWYpOwogICAgIGZlYXR1
cmUtPmZsYWdzID0gVkZJT19ERVZJQ0VfRkVBVFVSRV9HRVQgfCBWRklPX0RFVklDRV9GRUFUVVJF
X01JR1JBVElPTjsKLSAgICBpZiAoaW9jdGwodmJhc2VkZXYtPmZkLCBWRklPX0RFVklDRV9GRUFU
VVJFLCBmZWF0dXJlKSkgewotICAgICAgICByZXR1cm4gLWVycm5vOworICAgIHJldCA9IHZiYXNl
ZGV2LT5pb19vcHMtPmRldmljZV9mZWF0dXJlKHZiYXNlZGV2LCBmZWF0dXJlKTsKKyAgICBpZiAo
cmV0KSB7CisgICAgICAgIHJldHVybiByZXQ7CiAgICAgfQogCiAgICAgKm1pZ19mbGFncyA9IG1p
Zy0+ZmxhZ3M7CkBAIC0xMTM3LDcgKzExMzYsNyBAQCBzdGF0aWMgYm9vbCB2ZmlvX2RtYV9sb2dn
aW5nX3N1cHBvcnRlZChWRklPRGV2aWNlICp2YmFzZWRldikKICAgICBmZWF0dXJlLT5mbGFncyA9
IFZGSU9fREVWSUNFX0ZFQVRVUkVfUFJPQkUgfAogICAgICAgICAgICAgICAgICAgICAgVkZJT19E
RVZJQ0VfRkVBVFVSRV9ETUFfTE9HR0lOR19TVEFSVDsKIAotICAgIHJldHVybiAhaW9jdGwodmJh
c2VkZXYtPmZkLCBWRklPX0RFVklDRV9GRUFUVVJFLCBmZWF0dXJlKTsKKyAgICByZXR1cm4gIXZi
YXNlZGV2LT5pb19vcHMtPmRldmljZV9mZWF0dXJlKHZiYXNlZGV2LCBmZWF0dXJlKTsKIH0KIAog
c3RhdGljIGJvb2wgdmZpb19taWdyYXRpb25faW5pdChWRklPRGV2aWNlICp2YmFzZWRldiwgRXJy
b3IgKiplcnJwKQotLSAKMi4zOS4zCgo=

