Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0760CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 15:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXKeU-0005bU-Go; Wed, 10 Jun 2026 11:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wXKeR-0005ab-TC; Wed, 10 Jun 2026 11:15:31 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wXKeP-0000Vc-SA; Wed, 10 Jun 2026 11:15:31 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AC77kA245058; Wed, 10 Jun 2026 08:15:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=/H6NFnneTbq3QNoEVchKm1MqZ/ItyeQum30ok0vbQ
 sE=; b=uJ17BwQvmh8nXGobOyeLr5/ZqbmVzuegbm9LRH1FctJMvb/0/meN8XKkz
 BClMCtzASYVcnjQwYJXAsCF/gjuzSro3omN1JeZeenB47wlo8UD00KSxLwQY6XXN
 md+p5RUMYKA1J2eKmuEdpOJTHJxPoO8BxqB4DE8awxyk6UgcA4k2qtWifLhMBcRY
 2cxmHwi+UpmoskjXn6nqNyNQm2yYux01TmT6jocFYgDJFFltJXsYVptQchGsDrQ8
 ec1ApW3axRLUhWPKUbeVDd4a2HrjeqaFPMp6bO0+pm5LUoPjnJbvsqHY6b+s3xiq
 U0OoFmB+PFJoBO5O9cXTtivBiTDOw==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021143.outbound.protection.outlook.com [52.101.57.143])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4eq62d8pyf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2026 08:15:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjJ5ff29diOTC3xH7unsFYd8T2hC7u52V5butlfusJKwcCj6+NKITM10BmeJeZHkWMG7PP8dQcuGrbIEGcsN+pAr9HL2EOWkFb88oBZIfINVwraepICaG0a/qeVfspteNS23YmfjifdH1nFF79FsYpxYI+EMdK1vZxD2Uw0cA9WAoBt/rVfpz0J+WKRyAUZQKQujlEfBkxe9MnwviJu78k1FRKZCij6jbbwkoAlySIfcLIFLw3wHUbeMk1qwoWsn1GDUfg70BhEg7vSdAugDB6JtHEL4+Ohvvw+vyBfvzj9MMVitP4LLDS2tiK5WESmsu905DIYWPVyXzdarvODsgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/H6NFnneTbq3QNoEVchKm1MqZ/ItyeQum30ok0vbQsE=;
 b=O6S0TnqazK1j274NR4u+pRm/W+7+kNR4uy870gKQi3hcnYJ8D+6a6Axws9iJUYA+arIcacsSp2wo1AEYHxvbSLrjHF4+xPgj+oXmWB3bE0CIwNMMsXzTTOsW7ahfo8he7sHJ5Ryad/QlXsIVgIwBeINGEa35jROPisCvFEyYwotT0lUBdOqdQrVFCrgXgti0bR+fVIn75ABH5Ro8sO+/XP6u2jpY7jl3MhRSZdglUyFzTSjeUjPm2se6Ekq32PbV56S2FHZQP6Le26OgTE7n6T+oyxhUqVcDLWfF3Pm7mhg7hiW1+dz2hvC2wysdiWoogxMMNayQZj6lt8CfhJ3ElQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/H6NFnneTbq3QNoEVchKm1MqZ/ItyeQum30ok0vbQsE=;
 b=ECtGYP3AxjxYV1KuB2namw4f9Hwd1H85ml4WNEKN50xK73MEFpJIau7U2qq2hpwAjnQ3c0rEhjRJZDhKP8ixu8Hiabx+ooRTSG6SVdZJunMhVClf9496dD7mBU2a2QH0FSJJAyr4hrYu+F7jZdIB8lzuVT+hz5F8HxqcLTZq32D8dTN4KTSkyu9xQqZMUOn5nN6zx+ocVwMDKtWUf1gWQ5Moz/NZDtfIwrtsr9GbQvPywi8A++d5d9DcRnpWoNTP4lf211E5DFzTEWxI19C4L5/JrhnPs+CKN0iKM+p+x4Wujwj6LH3LD38vmMQKTzb4b22TpHQBuSsMmBjyo5tDIg==
Received: from MW4PR02MB7153.namprd02.prod.outlook.com (2603:10b6:303:65::11)
 by SA0PR02MB7243.namprd02.prod.outlook.com (2603:10b6:806:e8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 15:15:18 +0000
Received: from MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd]) by MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd%5]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 15:15:18 +0000
Message-ID: <d657702c-b9be-4dc6-8be3-5f43bb716b85@nutanix.com>
Date: Wed, 10 Jun 2026 16:15:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] migration: Use OBJECT_DECLARE_SIMPLE_TYPE
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, Eric Blake
 <eblake@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Sana Sharma <sansshar@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
 <20260609172514.2037645-2-peterx@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260609172514.2037645-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR17CA0046.namprd17.prod.outlook.com
 (2603:10b6:930:12::11) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR02MB7153:EE_|SA0PR02MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a45369-711a-4dd1-d484-08dec703149a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|1800799024|376014|366016|56012099006|5023799004|4143699003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: LZLrTeZC1wu4OdsbpIauu8+L4bFajmULTeJ1m4fOl9BQPPFiXjQgEaNsadT9czljivf6d9KduAo81Nt4PWJoJs0Zfsoqn3owi7JjBRbN3a4B2raNJZaJSj1lC9vH9BOnQ0bL7fhQPIkTbQMJgPpW9r0fshOZ2nQtczH2Wq4RQl44YIPnUnM2T6meEqSSll53Mf4mVhz5zL8bY0Fp0obv2gKaXlUSp1s/LVdJNNRE9+g5g7ctSi5O/aK7v+Ohe1IVT1BlDksgTwdTvMGc2TsrJjTkrXo8X94KSun/9BSW48HBmZJG7NUK0RmWZa0jG8AJJSrDY5DIiin8F4NRa7pY11+H3aDxDKSbsRioLDytmNkwFJQJYPRxpUB+Oio/Ne73yXRoo3LmWszXhpA8EVQXjlPpVIyREJCoeOi4CH53Z+up6Qf1l64FtoRA7AHu5bansKwtGu5LXsj0vUm75j6kb/oh7eOUERR80qz3nzA8K49M+iQUXqZBJAEA8Bu3kBjNrmlnrxhmJGc5bzb7caEoxMZe/Nd2naNXN0wzslmNU6Fz8kcLtge1TJ6vuElVpS4hH4pZf7pdF1zcVucMDftvJ93+cQgBByB/ig8Rma3hYH4vs12pIUpFWWsPVV67tDXEhhMXeKg5E5aFtfOCB61OEm+arLB72vlqNTk3orEhf9LmdtTEFqXu5e3CtdHQpmXh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR02MB7153.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(1800799024)(376014)(366016)(56012099006)(5023799004)(4143699003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3pPNzh2SUJYUHNWYldQQ1U4c1BNNnVxTmgxU2hUejgvVGlHMmYwcWowb0Fl?=
 =?utf-8?B?ZkMzYUNHb2hERnZNS0hvRjJJY1o0ZzRWNGdnNk9WMisxdzQrM2FSdlkxb3Qw?=
 =?utf-8?B?MDY4WURHcUphMkRxdURlQjB5VTZiNW80REM3a1RrSGRKSWZ0SmI1T2RaVzdh?=
 =?utf-8?B?aS9hNjU0NW5xTXptY0h0R29vMUI1ak9UcmJGTHYvdHZHbG94NzZ0WlF3ZUdF?=
 =?utf-8?B?cllDYjFBOXNSZ0F4dEptK1Z6bHJ4RE8wdDVwMW10QWQ4M09XU0F5dXBKNXFn?=
 =?utf-8?B?c0k5VTdjQmJ3eFl2amJhZWdiTGYyVzdrbTZNSEFGM0xOVzQyTWowSDlpSmZh?=
 =?utf-8?B?LzZPOHJWVWpCa1JjUy9CYkRjYlFQVC9YOVJNU2Q4QjVrNitJc2QxMmxSNnZj?=
 =?utf-8?B?UW5SWXVxQ1VVUHFDY2RrZkxWQ2ZXY1NpYVNaankraDkyUkprdzJra25yQ1VB?=
 =?utf-8?B?dWJOb3U5ZC80bWNVVnl2cGRxVTFDWVNIVWNGdWxRWGs1ZXcrTGVsMEpmUVJp?=
 =?utf-8?B?NVEzSlVPdFJ1dk1jWXpaRmQyelJRVDRnSmtPM1pGWU5xY2FXcnFIM3N5NFht?=
 =?utf-8?B?Q2ZkbHRMVWNEUkZaellyMEZ6TFJFY256OFVVR3JNTUdBRlpWRWtqemJvQURJ?=
 =?utf-8?B?ZkJkZjA1M09OUjZSYklzMmQrUE53ejZnd0pUc09Oc0dhVURzL3AxVXN5QWw1?=
 =?utf-8?B?UGV3SGh4UFA4N2JwVlM1eURXZnYrVFEvc3hvTThSRzkvc1U0SHJIa1k5VGRD?=
 =?utf-8?B?c3UyRWw0VmFuSmQ4c1NoSU50blBrNEFqKyszZmlQczRmZXRDNG5PNEM2Q3g0?=
 =?utf-8?B?ZEFUUms4ZGFHRm1wRzczYklSZXRnalc3VkFRbUlpckRxREhQL0lxajZnSmtP?=
 =?utf-8?B?MjJOSmpQNVN4RlJ5ZGRBalY5dFpNSFo2K3p5aUlyZGhCOXVTaGprcmRtQWNh?=
 =?utf-8?B?enhUVEpRbThTbHZWQ2pWdjErU3JDR0hEOW41MGJEd2lxVktXOUF4WVZtSFg4?=
 =?utf-8?B?UHk5K1NzYWJVcEZJZFl5bW1rbmgrNW1ZcERIY3hCTDR4VExnS3BFWVBQQzRj?=
 =?utf-8?B?NEVuNXJ1TDdzbnhpeUI5S1BKRENia3ljR29BM2h2Y1NDRkt3TnBiVmxIYjd3?=
 =?utf-8?B?bU1URmpuU0dtcS9VbXdteHZicGUvMW5MbDltR2ZTNUYxeXpDL0dzUEJ3OTNT?=
 =?utf-8?B?eThKSVlDbkpTNmt4d1BmVVMybGZ5bVBVWHl1bTIrRXl0bWpxa1FGdG5ER0t5?=
 =?utf-8?B?ZzhIcS8vN2N5VEdrSjVLQjZlQkRMOXdqUHZJYmRrQngrMFMxek1WZGhhQjRl?=
 =?utf-8?B?L0IvT2w2K0ZOTFY3THVkZEczSXkwdW05RW1ydzJyeS9DWkJSaGlRcTZURHdI?=
 =?utf-8?B?UlRDL3FPaWdOOXZxaU5pdFY1bVlLNVk0Y1FsZXMvSmtSUzAxbDFyVi9hbGpm?=
 =?utf-8?B?R3AvZ1M4c0NZcnRpMW5LNjJEcmdBOENCSHBUcXhzcHhmR2dqR2ZZUkdRY2VD?=
 =?utf-8?B?LzlGb2V1T2toTmRVcVpKc01CZC8xOWRuYTROcUVkZkZpQkVzMnR3cnNCMkxH?=
 =?utf-8?B?a3ExUzhIUkZCMHZZaXM2R2ZzTld2NzM4dnFwM0YrYlhTSFBLNlZsQzdKVUpx?=
 =?utf-8?B?UHNRUjgxV0o5czQyQVgxN01Hci9DeldWZzViQTNsRE5YY3lsMHdLWjlVR0dB?=
 =?utf-8?B?WkZvTWtJNXdpTmRWWFV3Z2lZNnFDZ3YxcitWRE14UDdYbjVSanoyRXBwTE9H?=
 =?utf-8?B?WkhJT3RZUkUyKzJrQWoyM3NlVDBEMGJxYXJtQUFrK2RTTVk5cmEyR0sva2JD?=
 =?utf-8?B?cGtXbGU5S3lVTGtnT2dTMFBOYit1L3pVdzdGTzBsa0VwTXZYenM3V3JOSndl?=
 =?utf-8?B?MFA2MThGa2dOelNtUnBPcnBWYldKeVROay9hTU8xYjVVaEFpcUh2enpUTXpo?=
 =?utf-8?B?UENHRk9IVCswanZBcTJETFQweXRsMnZiT1VWeGRybEtBaGZTbGZDcjA3VThv?=
 =?utf-8?B?U29wdm10NWl3N1k2cDRab2IwaC9yVlZFVU1TOUlDYVM3OExIRG5jcno0amho?=
 =?utf-8?B?ejdWZm1rbHRXY3NEWFNHLzlkckxnNnlvd0RwcWJYMXR3Y3VRUThqNCtBblZD?=
 =?utf-8?B?YWROVDZQVnV0SGIwR25wdmdCMVVZR0NFQmVSVEV2SUVweC9JY0NWamhMZyt1?=
 =?utf-8?B?MUdISk5FcER5NWxmVjgzak5XOStoZURJTzdBNlNMMDhHRjBsU2NsL2pVWDFr?=
 =?utf-8?B?a1BFYkVzdktyQVdpa0JHZlB6VVllU1dVeEVxMnF5UDIyT2d6VUREbVpwQTZI?=
 =?utf-8?B?U1hpNkd3TEk5ZFcyL2F4TzNXQzJqemZrS1RUQldjY3BhdHYyY1h1SEpCQ1Ru?=
 =?utf-8?Q?iyh+f9H9tDBY5D6c=3D?=
X-Exchange-RoutingPolicyChecked: jyhff2X6jXih9HJ42/ifZVE176h8kkev2NvqMjKeR6VDt/seDkaCB5Jcl3K7aJLW2ZL7gNT1VdykSdXsLbaXt7oqgHzvLC/dfpRCDRWjYs+/K30ahrLZcs7sLOm5sXCvKS9UzmM2CVMo5n2HcEZBDTC7bvRrzKPggT6UOTgM6qyDmCZfY6r9uVnHwohB1PyVyBEmuFoMGETrV0PSVk1X9R9DlRk4/vayHj8k2yw0gPbySPmayF5Y47aJ/CTrfjJBN2Rs3X/+CBm83RTF8bDzUoRpL78std6+U6FqoY03t6qWOILFpaUz+5zHelYj2LLkN4oOaAIVoL1/ByntjS1u9Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a45369-711a-4dd1-d484-08dec703149a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 15:15:18.4385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsRLphnFUHvA2E4CZ4RdSKe2whtFDjBd48fxzX1VScG6K8OP9WCMV96S32wYdL5YKhPcOPcuVRfpyWlSZkbAMBaBdvhjAznfUb+sZ1wT54U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7243
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE0NiBTYWx0ZWRfX8AvskkmVZ3B2
 avQbm8N5UPxjnD0nu9NGNheQV4ft5gyyrPGodcSKzIhG1sqmdGc6bU9NUUyJvYuDP7lfxRHaB4J
 xA9ipuo7aMISxOYH5SrtMbtdNFzzYuSzWlRTmoh/NpwipVbgIentBrJKwCffHNIWD7s6cUKpEno
 w8pNCai6t/FcNUHYw7/ImraoXHQJ6zloOInrdunKt49nQ+XTi64h8G6uttSFip2zIWVseSPZzy/
 1ha65vahC49+4jZTtfUFX7l4C/qtY+bBd6ko7QjTu/G4Ee1JIb5ehxNygsiZGEBzPwjywwJj3Ht
 dXs6ZI+HxCv8pTk2FiX5MkGF01Lu5uwb5DviCDRy0f8PmrC7jbaEsIwy005yha+7K3g9Wu3845f
 Dlaow+CajSfS7xfzyTKCxM/jQHNdOuNBtjTuinxgQQEQvuIuKcAbnMg7eah+MRHxVp2+7YEgYwU
 kxfBjCYfHmJo7IW9Qxw==
X-Authority-Analysis: v=2.4 cv=EpTiaycA c=1 sm=1 tr=0 ts=6a297f88 cx=c_pps
 a=pCScd9Md5F2Oib7HHR5gBQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=QsIGqu06lyntEXvFqt8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hY6e-ci9IHul1pRW7kUqpp4jiU0A7ekf
X-Proofpoint-ORIG-GUID: hY6e-ci9IHul1pRW7kUqpp4jiU0A7ekf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On 09/06/2026 18:25, Peter Xu wrote:

> Migration object's class has nothing special, switch to the newly
> introduced macro.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   migration/migration.h | 9 +--------
>   migration/migration.c | 7 +++----
>   2 files changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/migration/migration.h b/migration/migration.h
> index 841f49b215..293ad60e07 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -263,14 +263,7 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info);
>   
>   #define TYPE_MIGRATION "migration"
>   
> -typedef struct MigrationClass MigrationClass;
> -DECLARE_OBJ_CHECKERS(MigrationState, MigrationClass,
> -                     MIGRATION_OBJ, TYPE_MIGRATION)
> -
> -struct MigrationClass {
> -    /*< private >*/
> -    DeviceClass parent_class;
> -};
> +OBJECT_DECLARE_SIMPLE_TYPE(MigrationState, MIGRATION);
>   
>   struct MigrationState {
>       /*< private >*/
> diff --git a/migration/migration.c b/migration/migration.c
> index 074d3f2c69..278cad502a 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -297,7 +297,7 @@ void migration_object_init(void)
>   {
>       /* This can only be called once. */
>       assert(!current_migration);
> -    current_migration = MIGRATION_OBJ(object_new(TYPE_MIGRATION));
> +    current_migration = MIGRATION(object_new(TYPE_MIGRATION));
>   
>       /*
>        * Init the migrate incoming object as well no matter whether
> @@ -3975,7 +3975,7 @@ static void migration_class_init(ObjectClass *klass, const void *data)
>   
>   static void migration_instance_finalize(Object *obj)
>   {
> -    MigrationState *ms = MIGRATION_OBJ(obj);
> +    MigrationState *ms = MIGRATION(obj);
>   
>       qapi_free_BitmapMigrationNodeAliasList(ms->parameters.block_bitmap_mapping);
>       qapi_free_strList(ms->parameters.cpr_exec_command);
> @@ -3993,7 +3993,7 @@ static void migration_instance_finalize(Object *obj)
>   
>   static void migration_instance_init(Object *obj)
>   {
> -    MigrationState *ms = MIGRATION_OBJ(obj);
> +    MigrationState *ms = MIGRATION(obj);
>   
>       ms->state = MIGRATION_STATUS_NONE;
>       ms->mbps = -1;
> @@ -4040,7 +4040,6 @@ static const TypeInfo migration_type = {
>        */
>       .parent = TYPE_DEVICE,
>       .class_init = migration_class_init,
> -    .class_size = sizeof(MigrationClass),
>       .instance_size = sizeof(MigrationState),
>       .instance_init = migration_instance_init,
>       .instance_finalize = migration_instance_finalize,

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


