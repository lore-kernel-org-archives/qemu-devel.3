Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9A0CF34A9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 13:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swLyF-0007g2-Oq; Thu, 03 Oct 2024 09:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1swLyE-0007fn-G0
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:34:18 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1swLyC-0006cp-2D
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:34:18 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493CsfnR016203;
 Thu, 3 Oct 2024 06:34:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=qXZTylAB0X+DiBK
 lvE4mclZJY2saz34U4VYlyz5EMuE=; b=a8lH4qg3WKm3EDa6faVFABMsGHQa8/e
 65yCCLogyrOHt4wNSLRFP47+sypCfpVeL56AkrM0pri5MCmn9DRKBve8dSvdXDFf
 oBp1/dn0K7obm7T4w8nyj0gUReyVnR6WpIeXDvg33PiVYTqyA6w1zrB66JeCkXv8
 Nq2aCxlBRbT7x93+zzuzc76Xw+E7zxIMX8maoKnLkXnU3ENU0IwaA9CrSt+YGPNo
 XJHqadBWl5Jes1qDSkKpjG9cSlyDBxNy13HKEBgH6uPdffr7gqeap2fUb8X+3KVX
 MLki6iOH3Wu8KTFLty4bypgq2C8sT9hLMDBo8/ewD2h9iWI4nXc/xOg==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazlp17012054.outbound.protection.outlook.com
 [40.93.14.54])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 41xhc0mjpt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Oct 2024 06:34:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URbfzYVx7GoTaz+oVCp82v8ceSnhwh4OrJsZLj7WfS4VU0J6H2Z4i5NOBtF35JDr+28aQzHth5yGsxzqmaYu01KJknayXSvCXGd2jkLkLCmTQbIcjMIz17vI/ieRnUsh7MVJyvYQl2mXGVqN8QHx6OLRdTVrK13aWWqFd0iX0ULQN/kbh3rwZ9hXN0Zy2Fr4vH9J4+dltrepF0yP7SquGDf1a5MJt6QimgCOqz6wO9RzMuNM7txOaP1N26yYos0nD4gqjmkBwLyokaFOftqoeZ+pMP6/4JtuMc1UUHkor4nn7n7UKqmwYYQGSzDVxRjuNMN5Y3zrEQEkUr12+hoMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXZTylAB0X+DiBKlvE4mclZJY2saz34U4VYlyz5EMuE=;
 b=V7BfxwCm2cviHFUOA5IMpCjyhdsq6wN4m82pezJKnKqQIJMxlU5rb4G9kdPoC+2xtuRoaD3fjcJp2gsl5/Sg/wObC0oAIvc/zkeyfakeg7mDz/4jVySPMzASUC4W4AY7lfX1XGzPpNuGMbVX7vPERSA3d6KyYbxpYS4IiRvLivEx+Zvr49cayz0EgLnbti949ThR1BdaYsyymbdTGPeolAH6sn7Qayvbqa23uPgKb5Xjlu7qM1bonHPSMnXSSEVVQVQw7x9gRWcnt6Habx7vG3nC8C8tBA8ILJxSYvru9axIjdc61JK6618d4mhNHUNjUa3jnzqBF4ttO8chJ5S8Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXZTylAB0X+DiBKlvE4mclZJY2saz34U4VYlyz5EMuE=;
 b=xQOz3BBJwVHFWgj5iaO4S0oleIHCvr7IoOONHGTOtFCT/BDd98cSQ3EP5s5z4hArmw+kd0rQH07sILR/nvy/Y4surKpjA23vVuVlsf9aju+n7LrTLrPLje1ckSNjf13KuFpbKmhSt7R/GM1fbkdgBSVdQMiomF+AWav+0/PltusBVSjmkuskM/xuUy7WqyErLdTvCuD0knozyMAApKAiM96i55mlo08TrirhTkBYEEnYGOcm5aTfQYkYG2EakOk43rEzT1EdVoGnvkgR+CjLwNkA6ciqMd1aBUR81WGYS7K4MuI663K6vWQ49d1jLfQxDBTqAxDAX5xoWS1Pb4uhvQ==
Received: from DM8PR02MB8121.namprd02.prod.outlook.com (2603:10b6:8:1a::12) by
 CY5PR02MB8896.namprd02.prod.outlook.com (2603:10b6:930:3c::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.18; Thu, 3 Oct 2024 13:34:09 +0000
Received: from DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::ca00:b1fb:aa3a:f3e4]) by DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::ca00:b1fb:aa3a:f3e4%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 13:34:09 +0000
From: Simon Rowe <simon.rowe@nutanix.com>
To: =?Windows-1252?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
CC: QEMU Developers <qemu-devel@nongnu.org>, "freddy77@gmail.com"
 <freddy77@gmail.com>
Subject: Re: Corrupt VNC display for 1366x768
Thread-Topic: Corrupt VNC display for 1366x768
Thread-Index: AQHbFLkdixseYmY/b0qksh89icazUbJzXCMAgAAOaueAAZMVfoAAAsEAgAAGkoc=
Date: Thu, 3 Oct 2024 13:34:09 +0000
Message-ID: <DM8PR02MB8121501483C00871CB927C4D93712@DM8PR02MB8121.namprd02.prod.outlook.com>
References: <DM8PR02MB81217D61C42562572F8AFFB093702@DM8PR02MB8121.namprd02.prod.outlook.com>
 <Zv02EDIKgmq2L0fg@redhat.com>
 <DM8PR02MB81211BB23F192988ECCF4BE193702@DM8PR02MB8121.namprd02.prod.outlook.com>
 <DM8PR02MB81211F01833922F781C21E5893712@DM8PR02MB8121.namprd02.prod.outlook.com>
 <Zv6WmOeg7lcHLxs0@redhat.com>
In-Reply-To: <Zv6WmOeg7lcHLxs0@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8121:EE_|CY5PR02MB8896:EE_
x-ms-office365-filtering-correlation-id: e8df3a20-acbf-443b-0cf7-08dce3b00f80
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?Windows-1252?Q?bwF7smnMUqMNYTscI0KnXqmepjCbMUwPGI+hdPztzlMzsgryE/l/y5pa?=
 =?Windows-1252?Q?F51LLMaEgZeu8b7JzRatdY9IPmYeC/prOvqiZG0f45yWHPT5bI2sAJGU?=
 =?Windows-1252?Q?dXR1CQgbYWz8AC0mQ1Q65RD0eEbVzhg+hgpdwnfAse+Zw767H2KhPmnU?=
 =?Windows-1252?Q?D3GFgfJEGAVe/1odfokdMW3OaWx0r19RDn3wsvCDADBIYs/5CB0XoDhr?=
 =?Windows-1252?Q?tPcSbBlSfCjVJ1mUiqfFfH65IzR6bHI/SM5zT5ETU/b/h5LfVaDfMJGe?=
 =?Windows-1252?Q?L6YI1bzDcReQo8CyGb/zp8FtjfLg1ZEv0n0WrbZ25OnQQc+2Rb+1//to?=
 =?Windows-1252?Q?nXXte0uI33w0i1wY+HCMgI2NFksGI/pFZqCHmllrq1m4UA3Wm4qlUpsy?=
 =?Windows-1252?Q?CRngL3NUfhK3LkhOUWm/COzsdozo+p2U2ab8GVwxJL3MbgTGJ4adebYN?=
 =?Windows-1252?Q?AMwjw+N5DLVqacta1JiH84QnNK+yPquZwChvr90qAieHezE1l3t7FvnA?=
 =?Windows-1252?Q?4pqnlL6nnSo3aR2x2LAvhqUCveCVR2Ix1BxKQQi2zUhZKxaMkb3A5Tgb?=
 =?Windows-1252?Q?mgHJxIEn0vk5zBYwn6DdFoF/luK1fOuPT4QUIrhRpRi3Tqqw8Fo4ibS3?=
 =?Windows-1252?Q?ysI/+Nhh6Odzw6DFcOyG9NplDBlcL0+h0yr9EXLOkGLf2reu0vyrU2Fw?=
 =?Windows-1252?Q?0iPjjBBcdJl1EW9PLMp0IdI2fiMYjPqPuG2LGC+wjKSdaClEuJYpcUzS?=
 =?Windows-1252?Q?7P1MHsBbo4WsMR7bjQEiNghjkLWDeNaLOiX8In97KnwD0N31U+ndFU1j?=
 =?Windows-1252?Q?H8kg8E0+14pSO4lYSkS7VN4+2jI06Ulfaxq6kX5PD6GabxGe/8wIXuP9?=
 =?Windows-1252?Q?ayg1QcJYmDmd9gls3TT0kE8/YIFNuEzXWNMjbRSTImcBUOiY6zCBE5pB?=
 =?Windows-1252?Q?0Q49uJkP76YN0b0cmQ6HsBiplZ7weN+OIXnGYIURnGXNBLEDwvPhCoTi?=
 =?Windows-1252?Q?dJ9AwbgpoTELld2EHwANTwgvTZrzvrDdyf3QUZCWxHWSX4LWFqgS2N1S?=
 =?Windows-1252?Q?DV9at7odn5PGK9QyfT2y6JH0MJl3I+0umposi1onQtssDl2W/Ydt3ydX?=
 =?Windows-1252?Q?AaFo7zxhMeWyyakjWEs4I4cwRTxSEJpXPCCxpK3T79auIFBrQmnXNn93?=
 =?Windows-1252?Q?RlmzCGeaa6orjaexN6p7uyW1xKUO/x2lQA8sqWJIvHu+CcvZsp5b5dZm?=
 =?Windows-1252?Q?BHlJ+dKJJowSYLIJT1CUlg4hICeqqmfPub0whzbf6Ure43f3yOrsR8No?=
 =?Windows-1252?Q?H2mmwNlVBffcgmwkovJJSc36DSF6qdVTZ+pC+Syu1H6Zwmo0zO9QX2Ha?=
 =?Windows-1252?Q?wG7mL4O6OGdJVDOzeh/wyzB9g0uhHcEq/45luMABzary8+9Qvxo/5f1T?=
 =?Windows-1252?Q?uEfnYZTj7lHK3sOG7JYLXg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR02MB8121.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?tV8LgKGOk4Px+1aLUjTD4T4mUYrJMEJH9QwiEFbuZWqrLriA07qNe0pd?=
 =?Windows-1252?Q?1DipFfD37ENdMDFbFXpwVheGA6//yx5qmdutnAiGeHWxc6e3wJ59a1jG?=
 =?Windows-1252?Q?7tx37poRu2jES+k9NUcVgk+uMgTMLokea4W4RroeQEq4+uRznxHWO8VO?=
 =?Windows-1252?Q?p8Zo5XlKTSpPAPYzBuE2WVBlQ8KwcigQrtdwtv5lKxMekNjWRGm6PBlu?=
 =?Windows-1252?Q?vEqe03BfhB5daOnfSEO3QwfLULQVJyg+EUPEGiry0Pnj5X4aBRXE6Wm7?=
 =?Windows-1252?Q?NwmjFPWM4uIXEUrgi8uTos8+f1jHofBZ6QflEVdnhaDBi0elZD97Z4Lf?=
 =?Windows-1252?Q?6lZ5f+UpcRCRQ90cQsyZKbfs6/YtbHhUj/zZ7Gd7N7wAS1Ej4+hom62W?=
 =?Windows-1252?Q?xryUA95r2aE+F1ONH93JFAoBXUu9wSfwfFfM2582Ui/LL63VrEoZMwEb?=
 =?Windows-1252?Q?MKq3NLM5gHMNndqqvB1fXW8yHDoDtXgphhjFTqnjUw4wmNy9XvFBbRQG?=
 =?Windows-1252?Q?z8fOGbcwt70bdZwsCt1tvMxY3Kjy/ivfNJCdtdu5yuwifK+JiFJtc9qH?=
 =?Windows-1252?Q?2oLIM6qyEx4VZTKUMb3j/yguJxwjYeJSx9lAdgYjFt/68IwExz82WY0o?=
 =?Windows-1252?Q?0Y3KFPOm3fCPwuPeGIcWEvxze6ZrT4ZjAFoDlBt58QozGbgJLDUgxnLR?=
 =?Windows-1252?Q?nNg+iiJ0vK/bjeWFazFlABjwHAqq9Wm3p0/g4vBZBwSi6DXOqloBpexp?=
 =?Windows-1252?Q?gn7Hfg9NhTY+lFp97S6fTac46XEpm+2LSkKPd3467mVSQ2YDGtcfvkU1?=
 =?Windows-1252?Q?IZuOsYScCFKLfBPu2cQeXYYe/C+ARnsZouzs4xOs0G6ogcokDLb7mnT7?=
 =?Windows-1252?Q?aDQ+2A9c422kepyeuobf6DwBxSW2jIB6XTWu6K2qP02wtIgLeAcxuEQX?=
 =?Windows-1252?Q?fRKqt+Qn1moO5N74dCH6wmz9IVTTbJOi4uXg5futV6lke9X4JdS1wCIm?=
 =?Windows-1252?Q?jJQi7UomFbeKU4pJXcbNhru7xhIBu54vLlQ+SHDsxoU7AnaqDMK5OjWZ?=
 =?Windows-1252?Q?RvsIU5DYSGmnQ3TkzkCC/rVLjW3JDPh4+TOXBiQCWD/Ic3gDCLruHRaN?=
 =?Windows-1252?Q?/Eao+uZA845zpNS+t6KZ6drh9FulAAecAQPrdBqasXh4clE/laYgQtCz?=
 =?Windows-1252?Q?tbeMIpX6Vq4qHLv8J3n5pCWznLGdprWDjwYUVIetTAy9wCZhyHzi+HJK?=
 =?Windows-1252?Q?985Fgbd2Ux0bpfwI5tzsinjuU5gGcGLm7uYyk2VfKqxgtNMZ/zcNy+P8?=
 =?Windows-1252?Q?ie7celrLC5u5nT5plGkJpstd/rE3lU/ZNoBE74vhQxenYryTvk+/CRFZ?=
 =?Windows-1252?Q?MX8v/aXtjXPkdENb0UYggXuSOESTLnUw/HToDYW0pe+9LLqBZ2bZh0AU?=
 =?Windows-1252?Q?31eme1S3mOZVXBTYQibefR7KAeG+ZVGl2n1xZ3P7nr6ARTJYojVfkbil?=
 =?Windows-1252?Q?lzGzasf3u9Ba0b3GeCZOja+RCh6xMW4Q4+x0aK/lgoxXOqyRCwmevI8p?=
 =?Windows-1252?Q?z/ThfWA3a8Sf4GuVZ6JejUP/JQiik7DtPaluRMIl2v92nf5ps7khuRQ9?=
 =?Windows-1252?Q?LGUlPcWK1Sm/X/5cA9nNo3AIkNv5Irap/gTD8F3Q/AE1L6JZHQVg98v0?=
 =?Windows-1252?Q?1/rYPZw3MUQ+FF4pgZWhF+WoJWdGthMvs0v/9kph2FQXLyR1w2yc+A?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM8PR02MB8121501483C00871CB927C4D93712DM8PR02MB8121namp_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8121.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8df3a20-acbf-443b-0cf7-08dce3b00f80
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 13:34:09.3357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mF12VKUGbqq/p2+RffzGBAXz1A+HArAIBhJKR14oaOeY7VQDsfN4CnMyaUK9k3Bq09sA4whUXncpY6WLF5A2Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8896
X-Proofpoint-GUID: 1qEP5R4sP4W6KfGjpt0VFjlf2iTUbRls
X-Authority-Analysis: v=2.4 cv=c4P5Qg9l c=1 sm=1 tr=0 ts=66fe9d53 cx=c_pps
 a=gG0DghikVijJ7AhSPEVdoQ==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=20KFwNOVAAAA:8 a=ufcXl1-Q7icorsUqSL4A:9
 a=pILNOxqGKmIA:10 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8 a=xRuOQi62iESJQ6r94r0A:9
 a=vrceNMz27zi3eHoV:21 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10
 a=frz4AuCg-hUA:10
X-Proofpoint-ORIG-GUID: 1qEP5R4sP4W6KfGjpt0VFjlf2iTUbRls
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=simon.rowe@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

--_000_DM8PR02MB8121501483C00871CB927C4D93712DM8PR02MB8121namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

On 03/10/2024, 14:05, "Daniel P. Berrang=E9" <berrange@redhat.com> wrote:

> The QEMU VNC code has logic which rounds up display sizes to a multiple
> of 16:
>
>  static int vnc_width(VncDisplay *vd)
>  {
>      return MIN(VNC_MAX_WIDTH, ROUND_UP(surface_width(vd->ds),
>                                         VNC_DIRTY_PIXELS_PER_BIT));
>  }
>
> Separately, it also tracks the "true" width, but untangling which it
> uses where & the implications is hard to do. ie i'm not going to try
> to explain it further, as I don't know what's going on without spending
> some hours to trace through it all :-)

On a hunch I revisited Frediano's patch (mentioned in the original post). I=
 had focused on the change to the VNC functions but he also had a small cha=
nge to the masking of the display width in the VGA code. I've applied a sim=
ilar change and =85 I now get a proper display!

Patch is simply

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 892fedc8dc..ea659e2812 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -581,14 +581,14 @@ static void vbe_fixup_regs(VGACommonState *s)
     }

     /* check width */
-    r[VBE_DISPI_INDEX_XRES] &=3D ~7u;
+    r[VBE_DISPI_INDEX_XRES] &=3D ~1u;
     if (r[VBE_DISPI_INDEX_XRES] =3D=3D 0) {
         r[VBE_DISPI_INDEX_XRES] =3D 8;
     }
     if (r[VBE_DISPI_INDEX_XRES] > VBE_DISPI_MAX_XRES) {
         r[VBE_DISPI_INDEX_XRES] =3D VBE_DISPI_MAX_XRES;
     }
-    r[VBE_DISPI_INDEX_VIRT_WIDTH] &=3D ~7u;
+    r[VBE_DISPI_INDEX_VIRT_WIDTH] &=3D ~1u;
     if (r[VBE_DISPI_INDEX_VIRT_WIDTH] > VBE_DISPI_MAX_XRES) {
         r[VBE_DISPI_INDEX_VIRT_WIDTH] =3D VBE_DISPI_MAX_XRES;
     }

I don't know how functional correct this is.
Regards
Simon

--_000_DM8PR02MB8121501483C00871CB927C4D93712DM8PR02MB8121namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
@font-face
	{font-family:"Andale Mono";
	panose-1:2 11 5 9 0 0 0 0 0 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
span.s1
	{mso-style-name:s1;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-GB" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<div id=3D"mail-editor-reference-message-container">
<div>
<div>
<p class=3D"MsoNormal">On 03/10/2024, 14:05, &quot;Daniel P. Berrang=E9&quo=
t; &lt;berrange@redhat.com&gt; wrote:<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; The QEMU VNC c=
ode has logic which rounds up display sizes to a multiple<br>
&gt; of 16:<br>
&gt;<br>
&gt;&nbsp; static int vnc_width(VncDisplay *vd)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return MIN(VNC_MAX_WIDTH, ROUND_UP(surfa=
ce_width(vd-&gt;ds),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; VNC_DIRTY_PIXELS_PER_BIT));<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; Separately, it also tracks the &quot;true&quot; width, but untangling =
which it<br>
&gt; uses where &amp; the implications is hard to do. ie i'm not going to t=
ry<br>
&gt; to explain it further, as I don't know what's going on without spendin=
g<br>
&gt; some hours to trace through it all :-)<br>
<br>
</span><span style=3D"font-size:11.0pt"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">On a hunch I revisi=
ted Frediano's patch (mentioned in the original post). I had focused on the=
 change to the VNC functions but he also had a small change to the masking =
of the display width in the VGA code.
 I've applied a similar change and =85 I now get a proper display!<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Patch is simply<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span class=3D"s1"><span style=3D"font-family:&quot;=
Andale Mono&quot;;color:lime"><o:p>&nbsp;</o:p></span></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">diff --git a/hw/dis=
play/vga.c b/hw/display/vga.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">index 892fedc8dc..e=
a659e2812 100644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">--- a/hw/display/vg=
a.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+++ b/hw/display/vg=
a.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -581,14 +581,14 =
@@ static void vbe_fixup_regs(VGACommonState *s)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp; &nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp; &nbsp;=
 /* check width */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">-&nbsp; &nbsp; r[VB=
E_DISPI_INDEX_XRES] &amp;=3D ~7u;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp; &nbsp; r[VB=
E_DISPI_INDEX_XRES] &amp;=3D ~1u;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp; &nbsp;=
 if (r[VBE_DISPI_INDEX_XRES] =3D=3D 0) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp; &nbsp;=
 &nbsp; &nbsp; r[VBE_DISPI_INDEX_XRES] =3D 8;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp; &nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp; &nbsp;=
 if (r[VBE_DISPI_INDEX_XRES] &gt; VBE_DISPI_MAX_XRES) {<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp; &nbsp;=
 &nbsp; &nbsp; r[VBE_DISPI_INDEX_XRES] =3D VBE_DISPI_MAX_XRES;<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp; &nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">-&nbsp; &nbsp; r[VB=
E_DISPI_INDEX_VIRT_WIDTH] &amp;=3D ~7u;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp; &nbsp; r[VB=
E_DISPI_INDEX_VIRT_WIDTH] &amp;=3D ~1u;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp; &nbsp;=
 if (r[VBE_DISPI_INDEX_VIRT_WIDTH] &gt; VBE_DISPI_MAX_XRES) {<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp; &nbsp;=
 &nbsp; &nbsp; r[VBE_DISPI_INDEX_VIRT_WIDTH] =3D VBE_DISPI_MAX_XRES;<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp; &nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">I don't know how functional correct this is.<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">Regards<br>
Simon<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM8PR02MB8121501483C00871CB927C4D93712DM8PR02MB8121namp_--

