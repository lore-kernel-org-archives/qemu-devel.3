Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8533C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 16:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3yKE-0006nS-NH; Tue, 08 Sep 2026 12:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1x3yKC-0006mf-DF
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 12:05:32 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1x3yK6-0002IZ-Ej
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 12:05:32 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688EgdgE3445371; Tue, 8 Sep 2026 09:05:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=TLXyXZdR8Ge6Wu7/BE/ZxpIOApj2NxQcy2Rb8uPtW
 AU=; b=1EqPWScwHP2eetDhoCyM27cdwQMRmBBRpTSiwiCc8KZLaF1WoMmNa2UCL
 sc/xWrSy5iZrV34uRQMmnroS6KCmWp/QzCtyaU6rGOjYtQyKF3uqKlIHb1RLFwRi
 ziqVJ79DMMUpE6Uju2O7jHC8AqAlQXT19am9ioF/PRtU+XsKGDm3sxvJ181yh4F/
 qisMiV7/JCMYEFV1VCLVNVSBQxNDO+FK694WPBGXwAJk7xtRz3oMvhOOURqiYUQS
 eoK2o/PR4EkyiBjItxTDGiRAjE8wSrnc/IIaPTQF4BGEc+7QL6p8YrVSW24za5M8
 VCtj+CZ9Fwl+9cMCo9Gylzvuz3bdg==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020127.outbound.protection.outlook.com [52.101.85.127])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ggf05e6tv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 09:05:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+nXN4D2Difo9YOuzW/NsTe6KjSksibT4EJPNxqhyIzd/S4fk124CN/0dk/uqEbBY9OwJIsBra5T8Ad48pCVUlASfADjANYKlso+mR9onEhzKKakhaKsnDzvgJHlU/Sq+dbJ8x+bECQ4B8ZjcPF4buUI5thNhRXNpihvsFzRcmgBZ42+QHHEq+JUiCYK9gC3kvSFnw+DFVunPX914UYfGAw8NqcvmJu02OhCGDGXWl/NjyelCS/Pcv78LczYxakjnu8ezcjt5xaE7mcnwxySOt3dYQ+eQ9gnIqPqqgH498hPdefnlZLnP2X+/8FNBPO28YO3QHlI8iQPnsYXqbms6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLXyXZdR8Ge6Wu7/BE/ZxpIOApj2NxQcy2Rb8uPtWAU=;
 b=a5mUYRY6YAE48cUT7MMZbHkVV5weFHx4eJE0jgMLr4DFs/IiHaHOJXZXrsQX3Wd6Uy9eQkAXR34QqPQxvcABxf27u6ffwnD/rqRaTcPKlZCvLmLBYcS6ufFi7bYV9YmrsZk5sQgYYsHo/XTnpLEflx3MIqIGy5ee95/Nu6o5MSamtpL+cuY47wAycPNP7MvbMk3bjIp9RO9h/jBRgzhdjcT8NhiS0yn9H8latff0knLW1AWu1ZhM1vJ7WO3ctJv8puQVRa2eOaLTBkJSips8YWG9Tf5Yu7HGN6e0v6GTSYGH0drJX7em2GXcYD2PbbpdxK+LrRCBUFcx8UI2bVhhrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLXyXZdR8Ge6Wu7/BE/ZxpIOApj2NxQcy2Rb8uPtWAU=;
 b=TUohf+16fnhSPgEbEmYKFIADSNzKEkkm8my5LASx25HJBRfYsBhX3xIID8freiOqvW0LTZexpBS946gvNdgOkGljUFtyLh/WyJZ2UupXs+fUCX9YD8TyFli3vCfHfaADipcSLx1BledTMt67wNdRlQR9kh7ovDQPwaaJCW07UX6IrN4FlXvr9smQ7DAXQsLadwt/0zxTk1aurDXI601V/5UzKx+yGGU8JfP7+Iz2Pz3B9GbUQ5eyeN3FaCBYW0xQL0lOKN22Hex7yv7X7CLXuO/nV66BvmMwQ4brwMFIbrNs2hPJyyFNVunxjv3CymDkkEJ8LoC9qSr29qSzx6rNtg==
Received: from SA1PR02MB8368.namprd02.prod.outlook.com (2603:10b6:806:1f3::18)
 by DS7PR02MB9474.namprd02.prod.outlook.com (2603:10b6:8:e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 16:05:17 +0000
Received: from SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2]) by SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2%3]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 16:05:17 +0000
Message-ID: <b20a4d64-1bae-4f11-8e18-1a8dbadda625@nutanix.com>
Date: Tue, 8 Sep 2026 17:05:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] hw/pci-bridge: Add generic PCIe switch upstream
 and downstream ports
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260908155223.164787-1-david.vrabel@nutanix.com>
 <20260908155223.164787-2-david.vrabel@nutanix.com>
Content-Language: en-GB
From: David Vrabel <david.vrabel@nutanix.com>
In-Reply-To: <20260908155223.164787-2-david.vrabel@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR05CA0311.eurprd05.prod.outlook.com
 (2603:10a6:20b:491::28) To SA1PR02MB8368.namprd02.prod.outlook.com
 (2603:10b6:806:1f3::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR02MB8368:EE_|DS7PR02MB9474:EE_
X-MS-Office365-Filtering-Correlation-Id: adb5e581-85dc-4985-b712-08df0dc2f9ba
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|4143699003|56012099006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: wzs29ngbvELyzVYQ2I4gVK+1HPYJj1W6l8EN9LroEubXfw3j5XCrumhjhJR0zI/49XWqyfYfehqgaQs4iSBFJCKChSzyFxdp7ZmUvHiQpt5ds1kWn+CisKDo56gyTsX5QC89vxJank/dOFg4eLGXnU4GXcbx1qHqLZHRLDKHzFJ4LsP29+5y1H34Dc7Y4LoWsGtIV1YhcEBWuYFgvtJBcsARbZdHYeJ4HBPV2H9qAtpSzFC0VvR7fgtcj/mFcevgfK6ACeUJPZ5o2H0izToS/A4gYr6J5WzP14Jya/EA9NRoUF+qnGgWJxoNKJMiRiqx7e8mzbkMRMHj631sgedvjKCeFlNP17aPkYLezeqqoGXrAcu2/FNK6Vo8hOXT1FYynZb9I4ZzRRQx4mM3rP859aohMxzxaPWb/LOnzgKLM6J2yQfxXo/ajFYNP2C2wT55ewXuCqplc5CHYcs8P004VwAU5jPga2YQ+VnKuMzZhQGTh/PiXwa4B/aH+Idn8nwh8rFvNqzjTHeru6QseB9dNdJzEhp1U36aBX6PhIfYxiEcU7qmiF1xbaFrLGpxwUNVW/YyCXJs7sLMNY+p+DMI7ZML5PT0m7rRD9LZ+qdYZUnJzyECo4Gts8/CeKGJhc0yBVyYK9CuUgMdgsu3nizOfb0MH+gOncH/5CmS/hjrdik=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR02MB8368.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(56012099006)(5023799004)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QndIU1F1TzhvTDBNdjFzd3VsVmU2MUJYZyt1YnA5UHhZcCtaSCtoZzZJNTE4?=
 =?utf-8?B?djBNWU53NWxkNDh5Y1NZZ2FlcTJsYldwbUxlNWh3SE9HY0tEVVhtV2hpc01S?=
 =?utf-8?B?cnFuMzFQN2tSR2MrbjhKY2VZMndwVncvQ0c0WHR6c1NocnBpeTNaVStEVTNS?=
 =?utf-8?B?OXptYmpjSTF4MjVuc3l3aUZYUFRVVFlrSzNzUU9KMEdPRlFUU0gyTjN1VnRz?=
 =?utf-8?B?WjBtd05ISEV1NStFY2NzaDMycEtCZzlFVUsyMFFYZHk4Y092YngzVi9LTHhk?=
 =?utf-8?B?NEN5Wjdyc3FWbWd1TkFFMXRuL2R6b1BhK014ZHRxUXlmOWczanlUT1AyNkpq?=
 =?utf-8?B?MWtvWEdmN0REdjR0TVlMMnU1RTJKMzJKV0xRNUpzZnV1MFlod3JTdlF2dHgv?=
 =?utf-8?B?TUwrUjlxbEJSTlhVa0t2Y3hBalFPZnRBK3JJeVFrTGRmV251cjI0cUVZZW5Z?=
 =?utf-8?B?dG5lanU0Q1B0bDMxa1lwNkUwUGNtVXBNQTNBV3RVc3RxdGR1Y3d5MTRLdFM0?=
 =?utf-8?B?QUxkN1Q0N2V2dGExY1NiT3p3ZktRY29lQ25BNTdqeStWVFl6dlNIdWRxSExZ?=
 =?utf-8?B?U2RTTFdZNmVhTDRLVmVYNHdxOVNtTnY4bGs1OG5CK2dJazVqZjgwZE83cWFD?=
 =?utf-8?B?ZDZaMHdUU0tkQXdwK3I3bmJpSnIzYzZqN1NtVHd0Q0ZjZEdZSmJ6RUFxYzEy?=
 =?utf-8?B?dGNMNzU5SW9qMzRNUW1TSzdQelpZcmN2VFYyRDFSRzdrSEQzYW1lbkg2bmVq?=
 =?utf-8?B?MDhuL2FucXdpcjFGWVFTQ2ozM2pqc21TaFpKREpJU0Y0d1dGdXB4L0dGRnRG?=
 =?utf-8?B?YVhwQk5OZHVyVHVNMXptb3JMWXVadTFlTUQ2ekhGSjVVbnV3cVZ3KzFaRnN4?=
 =?utf-8?B?anRKM0Vhcmk5d3NseEtQcFA1NlpBeVpnMlFYN0N3WXl4Qnd0Y0JZeWM2bmox?=
 =?utf-8?B?bGNuRVhHVFhoaTZTWmtDVDlhNnUrWHVwbFlTRSsxeG1DSWNyRzkwQ3BkeFFW?=
 =?utf-8?B?dVpkcXFMK2ROcUlWTDI0STZsbTJmUUxzOU9CMzRVM2dnSXBxcmkzQ3V4OVhC?=
 =?utf-8?B?NDN4S1ovYm9sOGRyTStYdkNoR3VnZ3JESWRLV2FPdnNJN200Zlg2a1IvdXY2?=
 =?utf-8?B?WUZ3SnZGRTBhZVlqeFdIajNzQ3BabnB4R2k0STRqOWw3MDMyR0VmYU56d09H?=
 =?utf-8?B?U0trR0ZoSEZtVlZxbFpOWGVUaW9idk1ORVhUcTVacktFR2ZZZzZ5TUd6cDUz?=
 =?utf-8?B?d2VNSlBSYStRdStCcFlITVRKdzgvZkwzT1BQbjFQYlV2WmIwYTNFVWFwUGE3?=
 =?utf-8?B?Y3FtbDZ4V0hJU0theGlXZTFHVTQvMkRJcG4wend1M2lGdGVMNmdycE5aajNX?=
 =?utf-8?B?YVM0MDZkdW8zb1R2eWZYTEJ2NVJtSjBUQXpUa3pLcDk5RklIN3pXWjFMQkha?=
 =?utf-8?B?R1d6MVlXUmdYNnUwaGQwdUNlUnJBeGFSQ3grdDg0WXVGemdLanhDZXdKajd1?=
 =?utf-8?B?dWJjdkMza3lQNjBHdEpSbEdGZi92WWJwbExFOUV4bklESGIrVHk1L09NcU5K?=
 =?utf-8?B?YnhxLzR4YWdZZ3lBUW1sRVdEVTM3WkdUekFVOGJjVTU3Q3B2Q1I2UCswTHps?=
 =?utf-8?B?VVllV1VpUFFkU0czZzV6YnFWb1FnWXUvZ1ZRNFgvUkdxNEtGcG1PVUY2d05t?=
 =?utf-8?B?akE2dFN5YkpycGpkalFQbFg5ZmtuNXF3ck4vd2hrY3dvMzBWWTRYNWF0Vktq?=
 =?utf-8?B?ODE4aGh6S1lUVWFmK2EyR0Nwa1hsa0FFcFJKY0I0c0w0VmJaZWptN3FlSktr?=
 =?utf-8?B?NkNhZG1aY2ZyWjUzVWFYdU9hK0s4ckxKTW5zNGxzMGt5a2dPR0kxb1E0bG5S?=
 =?utf-8?B?WEVYQWJ2ajZJYktBajlqakI3cXFvY3pMMy81NWFtekd3Q1ZYSTJIdmVpTWZy?=
 =?utf-8?B?UzVnSmtXcjI2M2xhQUhBMjJjc2lINTJEdGl6dUNoOVB1OTBoNytNRFVocEJU?=
 =?utf-8?B?SmZXanJ5eVVvY0lDd0dHRjQ1WDNZdnp0bHZETlRac3drWTMxTHNxanYxdk10?=
 =?utf-8?B?aVZXalB0RUE2OWJKREtyZ2VRVzE2dnVHcTRzalNKS3BwUWdNcjc3ODFveUxs?=
 =?utf-8?B?ODB3K1E5U3NLRE5LazZtQmQyRzV3Sk9SU3F4OTRsM0RqdDR5YUdnZW1FM2Mz?=
 =?utf-8?B?NEZITTlpNkpkOUVhN2xacmxXcTZMSEowYUlpVkNuZkxjRHBPdU1IZW1OL1J3?=
 =?utf-8?B?a1Y2UVJxYXdrSk1PMk56SWlnMEwrQjEzMGZCNDU4ZzlObktNdzdwV0k5Smhq?=
 =?utf-8?B?VVlOUFhVei8xWDRsbXNuaG1xNWI0aTgxRnRYNlpoMXNYODN2NzBSeVJOY25n?=
 =?utf-8?Q?bQ7K0PLVN2OSX4X4=3D?=
X-Exchange-RoutingPolicyChecked: 0XpIAY5u8VmwqNiNoeEnfjr7YuoAeX1GFW9s8Akr/YetbRQJJEKo/iLd+zcjnG2gIsdzmQhWzvnx2HfK6RjhBTIgngTueZOrZfxDjbR73/sj+3HYg0l9RK88W88plegV2kX+rwxOlhkAZXmk/ca+PFt/QV5fcxwGz/bm58x7M+hGe4IoV9OCs/TN/zwCEg90Qh300DefzmLhjT7GF6LneD9QWD4fxr2szRL3LuHTKOggG9cNZ8oxHSQ9a6wU3rmBbTWjkKXBunY0ctBcvPogQO4EUMi91CYh7rBWu9/OB0XuQTH+5TnLz9v408JjqvVqU/xAsUtb0+kljApUl8t2DQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adb5e581-85dc-4985-b712-08df0dc2f9ba
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 16:05:17.8003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoEyD6VmqvPWB2tuziXxaoCtaZVIEvjWnC4wQkUaYGG+FbF+qic6T81VIE84MhxvZpYl4fVvtt8scYq4YQ6q+hIf3ordK3z+E8JcrUn5RyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB9474
X-Proofpoint-GUID: q9s5BSf4ejkFrB8MOrx2Dy_pgoRErElI
X-Proofpoint-ORIG-GUID: q9s5BSf4ejkFrB8MOrx2Dy_pgoRErElI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3MyBTYWx0ZWRfX4Y58wxff3I/B
 ime54fwEUtzogNjTs9jHe8z0NRD8UILPNYJRsVtwBzSD8dNtXW8miywHlhowiJMXDD9Edw5Jo+2
 kYj7kxew6elf6pgOtItcsvvBQNeenuKmMHpdo8wHl9c4/+xwWoIS/rLgalS4+j0o7ViCYCydOk7
 krl+goJWcmS7ga9SuOGTmwaa89cWOggFS+d5dFeV3maM87yQXH2ZaPfPso3ysstewnhn+xHuCnX
 +bTW3EVjo92akU9Ts8HyJeJ4gs9FmA069ABzHJJ6CVBEI8pnZMhZx+CFtSdhh548SY5prT48h95
 8T9bX+WA+N/xA0imdYb4QEVKYJx066WzrCxFG+LpCKT90rsnwgByZPiarzlIKNmqxZkfkgiJNys
 +yVEiLzfECDuJBpHXxrhpOREEBnKpDedJ6ag6KyokNyv2daGYUlBfYUWDt+xhAlvdJ/EbuLqsEs
 5FE1EqH2X2ygzn6LL5Q==
X-Authority-Analysis: v=2.4 cv=PoKjqQM3 c=1 sm=1 tr=0 ts=6aa03241 cx=c_pps
 a=PGzkYtW+Y2OQBedXY5L5Qw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=yBMP5viCMjhwhAQe1dgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3MyBTYWx0ZWRfX5SUc2oPxRREk
 JG6kj+k0K4q0B1Qu2XfilXfNATNoXBUKl+l8RNcl+diQZdsdjN4xPQAe1kH+kAF/PJOeyYy8y5V
 T1BG3l5QT1IaDWlP6VvL3Zn4YyN1IyU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=david.vrabel@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On 08/09/2026 16:52, David Vrabel wrote:
> The TI XIO3130 PCIe switch is a vintage Gen1 device, so we add generic
> PCIe upstream and downstream port devices that are Gen6.
> 
> [...]
> 
> Instead of enhancing the existing switch and claiming it is more
> capable than the real hardware we add additional generic PCIe upstream
> and downstream port devices, which matches the existing generic PCIe
> root port device.

Hi Gerd,

These two new devices will require PCI Device IDs to be allocated. I 
have suggested (and used in this patch):

1b36:0015 QEMU PCIe Upstream Switch Port
1b36:0016 QEMU PCIe Downstream Switch Port

Matching the vendor ID and name with the existing QEMU PCIe Root Port 
(1b36:000c) device.

David


