Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F821049515
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 10:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0GhU-00011R-2F; Wed, 11 Mar 2026 06:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1w0GhK-000117-B3; Wed, 11 Mar 2026 06:21:50 -0400
Received: from
 mail-switzerlandnorthazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c213::5] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1w0GhH-0000zQ-86; Wed, 11 Mar 2026 06:21:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGlLqbT4wOgZTkXG3zKRfBtY8YhjARyRTgdKleNLPfw2fzHEn72sj012oVUqZIi94tp7ohgJ/x9Who8Ox/0/uMKk5JKKazB2QxsJfBToHyLSPh6g61dxJh3IFriuT4RnQXVvrUj0zY/VdXrp8pP9hG6ISB0GM5tH6sms7X1lLx7UGSOGvD7X5MxtrZR+nrqMlckY8gpt9iBEpLRSyuoV9JMob9CCf1LJwErDO2jZU074GMVf97XSnrQrvUIp82hfHnDopjQinw3H8i1+Qo1+A57mhP9yPVW6YvUgxXw7etAspI+HU2F8QB1D38FOriayREAJpI2YsUCBElwI7+U1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/MnK/7pgoULgqBF8a/+Zy/gCMA0ASegf84fmmttLN4=;
 b=r5NaW93QNN27ATvbXue7/tcvV7Z1Q/t03oxMWPzzAHKxctrZvy0en2JZlNr/sh9WM9e/J5ddLN7dmWUxWEpkviob0CkS2ea5h/hLrjAJgCU/7fk9OZTvXxtz8lS+OWwRoQ2lRu2k6xU3rgwjm6rn1RenmEIBRqdSr+43KUyj7upFKolEvvXnujsf1YopXI5HWUEIMEDiZbE/RAlIgWYZO6YuJiXfw4INLOdDC/CbpdzerL47zYEL4UzUP9sxYaRsjPekIaqNoadgAfWVlgHCxqyqt1Cwt83hfiYlkCF7SYH/VfqSCYsjOzRNJPVKMNJ48N/iUiGmzXzClEvcrSUjXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/MnK/7pgoULgqBF8a/+Zy/gCMA0ASegf84fmmttLN4=;
 b=JYIYHX+vAhW6qsQG/+CQy6nWiN88mHSYgNfCu0GnO+C3Vwo5SLM6kQdrTCs3tnFEq5DFb0GN2pcS0T0zr6mjCccyHxsgyeNRKeCAcnN1OoNr0IqIcAA+UhIHvCzMz5UZmLNprCPrbYtp0mb5cqvWRMiObnAvsNgIjpUCN2damJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR5P278MB1811.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 10:21:41 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%8]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 10:21:41 +0000
Message-ID: <d35457b2-0f1e-432e-8e81-af78679e9886@epfl.ch>
Date: Wed, 11 Mar 2026 11:21:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial v2] plugins: add missing docstrings to
 qemu-plugin.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org, peter.maydell@linaro.org
References: <20260310-add-missing-plugin-docs-v2-1-e9a91cb6974a@epfl.ch>
 <2cffe423-e2f7-4198-b871-5721949be32f@linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 xsFNBFw7TEkBEADaJzHcW02rDYHgS2X2kjyXLs99tnNpww/r3MlWEkrKxgfgIRbtVQTJ2vNw
 mxIhJnAo/Ltu2VoEXU1WGwoMGv8wxquIuE1RBnYghnYPFd4SOMX8fXz5JylHpl+vPCWiP8U0
 fFWfVL1vyldQG4aVtufaJ1VEOU8zsw6YeXzxWJJ7ppUag4teMKuFya69tEEN74KLkDMJRxGk
 pj7rHW8Y+xBdNW9hQ2vAXhWAtm64NtCtJcJYP8RNl/jqlqYTP1Voj7byXym9HUM7NGEbGtrw
 4KKi9ws1yZv9BkW3ECBg5Q1w3WYmHfwqSa+8vrD2ahNieDYNu7veYP0oMaohumRgVhiaMscD
 IY8wqyt6K93RiwXDQjDAqwE44xrZDr4jjCUAm1D/7WYZWtzhsiDq80JasMbXd8SLKGr96zX5
 6vJGxa6OvyavRO7Y7DGK/dNPWdZqAC4QlluibdRsbkFLtBg8d60sVxYW8A9o46rrQB8qzglc
 joPhDebr8/NsI0gnzjgpgmNbresqne4/JIylUuJEwYcOWZqKqDw9U03uTFk/Vp6AxmRquWpy
 XZJVBsMNbunclgSelZIt2nzCa2nXR5MYyV2Y8ays+gSAPeHFOc6a8JWNLhgVKUed12XVrMUQ
 bmMmTFWWqfrx89Up4a+jW7uGIzexOeXUXKeE1j0uGsRLk6CF7QARAQABzTRGbG9yaWFuIEhv
 ZmhhbW1lciAoRVBGTCkgPGZsb3JpYW4uaG9maGFtbWVyQGVwZmwuY2g+wsGUBBMBCAA+AhsD
 BQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEqCB8P0q+u+2bTfhJlusnujFfx3wFAmmTEqoF
 CQ84+dgACgkQlusnujFfx3ziEg//aQ6KDcx7iN4OxEoIoklfsant8TyvtVOliJXT1hdmk+6U
 4L4odFGWmgpYiFjz1syCloXhHrxFPdEYZF0ZYqddwy1flPRbI3IbOkjznB3O0uEQ/miYCVpB
 3PbPQd9h0ZblFXHTZVmGZPFjA0EIgzsZ06quS2a99lj3SgsdsWzbsfn29Lx4Q4TPP6lNTYbc
 745AC7MrqQhjZ+dyF55nv9e5DZNk5K46mGw9lgQMGDM0z/eEkjYHeqrsFzYb069+SrIFblU6
 e7kR+z1TKWooEcf4umYnQoqI4hYQ70nSb/S5jGXDIDwf2lT2Q0bPPhVMj58IVHcWf/b4xXwh
 Q4SjjgG8LXnb+hfb/9p9jlE2Ez3ZuUfmnpH2roFZQ4dcHirRfnQ27+YmmEvM9DG3qxlFJP03
 ZrH19a6NCdrkh3ufeYRFfV1Gp3/wFDk7agP0uJ8taqlJyE8GPrYj9rJc7sv5cUDV8autNyPF
 zmT/c4e4YlZ6TQnTir9+rtWKzOqOq9spYGtfFhgEUjCNI2LBLuTI6cKbNGlktfwuzVfrx5OR
 SXPzTnhZam2X7WYYKnz2stLy1UhdUCnSfURpXxZYDew5YMt4KUoQaO4pgUuvFX4cHd56ry0Y
 Af3XIrKhtIylZjoyjZmhEt9sXS4Fowd795i+1JhYjWm/yIEiRfJzsDYm9KX+x9fOwU0EXgiz
 6wEQAM8iX+Y1mi1l3h876YmnuP8JSO1s6k0lABDO42pZaSp6Q9mFOabB7To80q1qEXCznlcR
 nExrN29WwXkfL2tcV4t/JFb0o4+6J9MmMUR3kdvRu55b/AGncNj0oggZDP8e5cLikv8v1ReV
 c//RPKSHVKnlmC9gtM0UHWpwHyyoplHi4sMJ8WyzGKfnN1eg7HlSx0xJAE7wKQP59mIMMj7n
 IXnk7bnGO7oaqy+i2vAxcdJPN6jvFgFCsKECL4NJCw6ifrY05paYRXza8JVwAcCzw0Sx4gZi
 JXC+gE4p80qNRrwR5AQuyLQNO9EfKLdnKg/85ag7xjB3ZWYMZNbj7HwCB+T16jOS+6lgGONf
 vctIp+hTFxXoCEnMx96FydDkqaBBjAU0JkbxhpMWFhzKzEILa60fxDxOSYHSs6h3bLk3D+gO
 i8j1SUPC4Olj9od7VIZDKGLd/nLw5qSt2c0H69cW1M/KS5zVARZQPb8Cqa9SAWdjmGw6MHvc
 WoYK4mT1arhwUlmrqUMcNqA+foGjDGPsxCQxqqIU2rB590n2wafu65UuyPUmzxOGdcb31I4E
 kkoBnM6G5nN4uZUCQPXl/DFlq/cfFI7LmIL2aZt6idehfvd+iOND4HDjRzrYDhz1FQn2Ihoi
 qHNMO4zSpWv35fl5kHfo1iYojwcd/aiyu4V8wo7TABEBAAHCwXwEGAEIACYCGwwWIQSoIHw/
 Sr677ZtN+EmW6ye6MV/HfAUCaZMS5gUJDWuSewAKCRCW6ye6MV/HfGTnD/4/+yc+RaA7mEHj
 DxS/9jWWxl2/OsRlhin8RZfKHODvJ+cm2DEQnBS8BZ1L2MIDYgGMSMG6J3yX250BTxsg82iR
 7iCzK8x4I6+nvCKmbb+7EFuHc+YGf4ytNbzbVAV990IZ4QTioRPjjc1Xr2xuvG9ZdhPsa+Qk
 suJqGfw+eLoG4inOK1i/kVJXXtXqF69VIebDijzEOjzmbkCfwIRdIRNNoWoJi8wir4TqwC11
 3L3b+FecY/5KR5i8EJsfuG3wlFISkGC7mdsjpBgC+pp7FIK6z/5YEYLFvUI+/8uzmm2dqTlu
 sy0Wzyo7RGRtfR+X29iooz7/Nm/KO2bBSqHUV+RmnRilF70YCgL84A8LK3yMD5he6p14jtfx
 ibjVIAesC2E0sLhhedHPedi3stwRk6F9q8xQgJ9Bq8+PwPkp/iUxB6IcA+lAKbjW8jzmhrAg
 OYMfkq6wvXX9d4zurpDIkuks/6OFDLFaaIl+inNeoSgCKMDWSPUlGeU2On5rLvsQisYiWwjM
 mEOGG/uuJiDykFSgUV+eb7WS4dwZ2HaaOZUoD5RrzJwfBFqlxGRfeOq2j4IrsVV3/J5QSDUD
 +9oKR08jjBNpGHLgS/Vw37u90cFFbof9t0vTVZ2lVHieaodFFp+4sA5SGSPHM7/92IKcfrxK
 OMuu0/KHXnb3nUgd9+qz1Q==
In-Reply-To: <2cffe423-e2f7-4198-b871-5721949be32f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: GV0P278CA0070.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2a::21) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR5P278MB1811:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5aa6dd-2642-4343-4b33-08de7f57fc86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|786006|19092799006|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: /jn6MV1UWGf+2o/gdlsIbBXBUxu5RLb7QihcSzOBzY93UQ6CUrYYiM4Apanrt/exOmRjtqpEpcu8TIKLzpYG1DKzlLVH2veHYBSdsP6auu2zwF9dh+dsjNG1Mu9B6nYCb1inYLsZBdBjBsxr+mTTHsCPQrbwFBLKOd/RPoD8tEOTvqQRfl2bdn2FSK7g9bg4KTTzp0xSyCcaXXu2MvdyaXaMJI/me1BFIPiTORr2cP7W8cEuMwOq9b6dCIaCdlo2vUC8eJFEYXUNsAu5UoIGlNtX5lgFsVjaJUPz1gertJWEJmsTxom8z76+7LW5M1GIJ/o5EQEzSUtd45+bBU98bY+pyS4zJdNTxt3YsKb5HhWU86zQXgza0HH+YjcCR4t00EKXf+xzA4WOnif8edf+3XYkZdB2eOB7d5Q3VEYtTc2utJq9vuurRIJMQTTBQXXaj1F7mW3J1JOnwNqku7uTOcT02VUvpU+cFSlrL1XyUULjbe7lSFWmGtkq/rxOI5768PA+lc5AMt+3L4jClVssMtIG+ZKUDkoZG7TR1atExt9OjRjESPmiUGZ24Zauj/Dn+l/hSc0jM+kQ+3+avE6PJ/XCcW/gfld0iHV1Nr0NBjZjza+nncbTXolS872K6Z6BmIJ4ck8UyWBmqikBAmE7CnmhY/dRK42tHMqN/fh3j28emnhwPJ3d2/bfRYCpUKxE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(786006)(19092799006)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEQ4bWdXVjNrd0FmcjVwditnbzJPRTNpN0h2T1V4N1JZRytnUmtFcWpSc0sy?=
 =?utf-8?B?Z2plSWYyMm94Q1pSVzlPc2wxNHIxelR4N3I4TDJsWWJhWWNRUDRjNHliOFEz?=
 =?utf-8?B?eXdUcEdVRURENkpDR00zVFVPSlJBbEVObTlmNkp0b0UzVjAvdFF3Z2llQjFD?=
 =?utf-8?B?c29MWG95aFJkb2lnOXVibGh0N2FSOVRtc1NPTzNnc3FTY0U3enNyQVlEQTlr?=
 =?utf-8?B?Yy96amJVUzRVa1BEMkU1ajNCZjZEZWJFcXR6UlpnZ3BJVXBTSDd6dzRsaFQv?=
 =?utf-8?B?WUZHeG13emxaMzQ3WndJYmp0WkRuTXpzcnhiUVoxYS9meWF4UUhwdnpBMWZT?=
 =?utf-8?B?b0VPSUE5dGJhNVUzRHAxNkQ2MGtoNXBLZDVTTGhFeit2NklkNTJvVitNdDBQ?=
 =?utf-8?B?SmsvU2NjLzllWDJZL08xMFluaWV0UllWWmZMZ0NNQUNJZXB2ZVVCNW5PVGUz?=
 =?utf-8?B?UTFCY0pPUWNZemYvNnZlZmR4SFRSc0pwdmNXV0JjRDBJS0lVaFE5SE9SYkJZ?=
 =?utf-8?B?emRZVUZjcXExODNVQTVIT0NSNmFhL1JpbzlMMnhKcm10b2UyeWt0YVZIZFM0?=
 =?utf-8?B?R3VmTTFiSyszaXI4NjQwNkR2am1aRHBBbGkrQ1AvMmFuZEwxVGRzU2xzdi91?=
 =?utf-8?B?WnZKYUZ0aEY4QlNRRW9rR2Zxa2lublFBdFgwUlU4azNTclRYRVJKZ05PZVhT?=
 =?utf-8?B?SEU3UWdPRGp6eW1VUkJOZHduU3dSOS9qbDBib1JWY1VSUkloc3ZpaVh1ZUlO?=
 =?utf-8?B?WFZpekRVaFdVbzNTRTFrTGl6dGpyUjFKRVJrekxwbEs2bzhIb21ML3BWcFg2?=
 =?utf-8?B?ZDFmb1dQckh1MkxTNkE0RGZ3TzdtUTQvY3VwTmFxMHNGZVdKTmFnWTZveld5?=
 =?utf-8?B?by9xTktvb043RzUvSS9KSUZMODBqb3VKY1hBVGxVaUI2YWZRVUxaUmdmLzA2?=
 =?utf-8?B?ZHdLVHUwYTBSU0xaYWM4dDF6bUdxdDd3dmtKblRLcGRSYjVJSUFHZk02eE1Y?=
 =?utf-8?B?cDlVTk40ZDhTNFBmQ3BkRHoxazZ0aWw4WkFESXF4enJNNU53dm9mODMzeU9y?=
 =?utf-8?B?bE1EZXpDVUZtYkpIcGp4dVhET2VnRTMzSlE2cFRja1BZZTVyN2k4alc0YUdK?=
 =?utf-8?B?M2Z3WEZmcDUyaklzejBpUGdIbTVUMURJZDd5VDh3TWRsMWFOVTI5NDJrcEhC?=
 =?utf-8?B?cmpnYTdrRXhNOUp3WkRIdk52a09QNEFHK0xTdkdWZGhnT3VVaHhUeDJBU3ZF?=
 =?utf-8?B?L1g3QmFWV2RqOXRZZmgwazVWbnY0YzdnTzE1RjBLM3M5Y2Z6bnZlVDFDUjg1?=
 =?utf-8?B?V0o3bHBwZCt2aVFvNDlRK1JVUk9qekVZSWZZdEdBcUFFbXhrTlIxa0I1bWF2?=
 =?utf-8?B?U05pY0YxemlkdnpnN2ZDeXhSMjdUZmRYakxScHhJMkhYc3lTVG8zMFl2VXJV?=
 =?utf-8?B?UkJTcCtMbU1jRUxsNUJKOWJBbXd2aGI1TDNYQ1FXNitVOTRydytaSXlJM1Jp?=
 =?utf-8?B?Q2VEUWlZeHZ1Y1VGbytqNE1kbUU2WXdHbjMxR3ZWUS9UdW45OE9SZU05RkxR?=
 =?utf-8?B?ZHQzTW9YaXhTYW8wbVJpc2JpakQyQVlrZDNTaGN1T2pjdGVmdks0bnJ5b0Iz?=
 =?utf-8?B?Y0x4emFaZW9OMThYYmRiMUdjbzJFeUZxbUV1Q0pjdlRSNG1tTlU2V3FiZ0dq?=
 =?utf-8?B?c0hUVnREVXExRXJOeVZoclZXTHpTV0d6S0VUV1VLSENZRGJmdlpYY1hWaXFx?=
 =?utf-8?B?N3ZjM3RTTlhleUpyQVE1bVVqY2dRRDc0NVE4VFpCUEZkSUIwKy9MWUcyZXdr?=
 =?utf-8?B?bTR4VTR4MXJyeG8zeVNzcCtvSjdVWkV0ZUZhSUo3bXh2TjF0SWpwbWJPT3BW?=
 =?utf-8?B?R0ZMMU9mRDhIT3k4UFROelFKT01VTHVTOTFEM1ZicWM0UVBFVzRySUJkNmVP?=
 =?utf-8?B?VUlaVmpLZGtWUkN2dktQeFdhZnRsRzRsTG1jbmFVQnEreWlPTXo0aURPZmxo?=
 =?utf-8?B?alJFYW5Id0s5WGYyRVl1bmcyTUlNVVg1ZkJwKzJjYmFnMlNQMEFmQ2JTcjk3?=
 =?utf-8?B?SEFHZjVUd3F6N1FjWnN2WnAyT3pMaE9TWjlrQmt3SERvRlpmWmdvTGhsZThm?=
 =?utf-8?B?N2IwYzlOSklzQVU5VHcyREhDR3Axa2xzREhwbng4cElORmN1S3czNm5ldm14?=
 =?utf-8?B?cTZRdjY3QmlkZE9jL1l1TTl2VGRmeFBDb3MvV3RJb0lYeWlLSzBteEh1R2Y2?=
 =?utf-8?B?Y0EzUzZCcTBGdzQyeE42VFFoeDI3T0JmUmFzUjQzRUpseXpnNjByeEpENDdw?=
 =?utf-8?B?dkdtNGR2eURMMGRhSVl3S0VqcEZveC9QMDlOdjlwUmJSMTNVa2pMQT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5aa6dd-2642-4343-4b33-08de7f57fc86
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 10:21:41.0815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGUN4HnqXhaHE1hHiarL5EeoaOnqdzezUpabv4UeAEFCpDj/Bl/g6o4V9GrCL3TTPPllrE/3/gafZY4YqhvybGJGKRfewf0a9NcqWUulIo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR5P278MB1811
Received-SPF: pass client-ip=2a01:111:f403:c213::5;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZR1P278CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 10/03/2026 20:36, Pierrick Bouvier wrote:
> On 3/10/26 12:49 AM, Florian Hofhammer wrote:
>> This patch adds docstrings for typedefs and function declarations in
>> include/plugins/qemu-plugin.h that were previously missing. This
>> resolves inconsistencies in the docs, e.g., the description for
>> qemu_plugin_read_register() referring to qemu_plugin_register_flush_cb()
>> but code cache flush callbacks not being documented themselves.
>>
>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>> ---
>> Hi,
>>
>> While working on a QEMU plugin and browsing the online docs at
>> https://www.qemu.org/docs/master/devel/tcg-plugins.html, I noticed that
>> some of the API functions were not actually documented.
>>
>> I went through the include/plugins/qemu-plugin.h header file and added
>> docstrings where they were missing, hoping of course that I documented
>> the correct functionality based on my understanding of the plugin
>> internals.
>>
>> I hope that's useful and I didn't miss anything!
>>
>> Best regards,
>> Florian
>>
>> Changes in v2:
>> - Added semantics clarification to the qemu_plugin_register_flush_cb()
>>    docstring (suggested by Pierrick)
>> - Link to v1: https://lore.kernel.org/qemu-devel/20260309-add-missing-pl=
ugin-docs-v1-1-41dddcd177c8@epfl.ch
>> ---
>>   include/plugins/qemu-plugin.h | 101 ++++++++++++++++++++++++++++++++++=
+++-----
>>   1 file changed, 91 insertions(+), 10 deletions(-)
>>
>=20
> Thanks, looks good.
> It seems there are warnings (and thus errors) about missing parameters.
> Warning: /home/runner/work/qemu-ci/qemu-ci/docs/../include/plugins/qemu-p=
lugin.h:883 function parameter 'vcpu_idx' not described in 'qemu_plugin_vcp=
u_syscall_ret_cb_t'
> Warning: /home/runner/work/qemu-ci/qemu-ci/docs/../include/plugins/qemu-p=
lugin.h:883 function parameter 'vcpu_idx' not described in 'qemu_plugin_vcp=
u_syscall_ret_cb_t'
> WARNING: kernel-doc '/home/runner/work/qemu-ci/qemu-ci/build/pyvenv/bin/p=
ython3 /home/runner/work/qemu-ci/qemu-ci/docs/../scripts/kernel-doc.py -rst=
 -enable-lineno -Werror /home/runner/work/qemu-ci/qemu-ci/docs/../include/p=
lugins/qemu-plugin.h'

Hmmm, I should have caught that locally. My apologies! Seems I made a
mistake when copying docstring snippets: other functions use vcpu_index
as a parameter name, but qemu_plugin_vcpu_syscall_ret_cb_t uses
vcpu_idx. I adjusted the parameter name in the v3 series so that it
matches the docstring and the other functions' naming scheme.

>=20
> Could you add those and check doc builds with warnings for v3?
>=20
> Thanks,
> Pierrick

Best regards,
Florian

