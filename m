Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16D4C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 12:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ8ZW-0001iT-4P; Wed, 31 Jul 2024 08:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1sZ8ZU-0001b7-Br; Wed, 31 Jul 2024 08:36:48 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1sZ8ZS-0004xG-8s; Wed, 31 Jul 2024 08:36:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CACIbd38jKDMTkp1TVFFw9YyHYU42BZ+o/HhpzzAFEA9/Z2ypnHmpGCpO4+p/ELZPLPNlMi0lVduOgkK122LLIbBaHy+QpYWuEBRdKRLCTR4fBZcHUTkoInotCyvZfHWlS1dmMQJaGd4t2dJ/ZicNF7oglwCcMud41yVzG1i32znf2ZsS4Ju+HoTo519dBcrj6N+hs9NAXdShrM7ixGmUavQMI38n2peUyiC/YWDl0fdUQYvYlGxiX466YUpNaQ5AXlroEcOl+9f9Mn6mtqHZcPcSjJ7i3quwFE1Onze/EpMDRkcnxAet4N8zmEVcjvCOVzbPSUdf0ZmlwKx8/jM1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PV5oXUNWlfM5Kkbs9IVsD+KzdogH7jHGmg9fOBR0Sq4=;
 b=CrsqluU6sQssQPkrVw2Sl0d6bbVrSYmmfGT8qBsZMcJjJthR8SuX2DUoTgxZBZrMTxD7/1pYZVLFElBuuWwBQ5kncYodoo9WjMOj3VMiqp0sU/uNLxBbKQKDcM02VCmJ4wV7/R80vNoa3iFzOP4iLuyNNaNdi9u7LbSwFAkKocY6wxAoqGNNGMWWf2R/zF/TySZep3BLyaRZ8y0Ew84wn7hDi43OOfek7pD+0gOToTrz8Z9YRfsliwghpw83NeHRMAVR0uFBBpdaSUKJ2W8mJ1yGrPGs48cQ29G+q2jA+3L4PD8Rr8Q0GspG5t+d6/0kED8IKdJpI5VIK0V8wtiw8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PV5oXUNWlfM5Kkbs9IVsD+KzdogH7jHGmg9fOBR0Sq4=;
 b=CHov+I2JyjklH3Bo0f60MmUR/Z/8Lz2ude1D4mXrCQBUrn+q5PTBYA/ebe1DaBe+KJD1T5WPS4yfk8s1PZDB8fkVazSmpLzOMnuPeMGTZSym+JC1tExADahZEkJhekZT4fBYbYJngdMyvBD9yAU5Cz0v+BT8sYt3/Pv/qNO3fwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 BL3PR01MB6995.prod.exchangelabs.com (2603:10b6:208:35a::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.22; Wed, 31 Jul 2024 12:36:40 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%3]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 12:36:40 +0000
Message-ID: <ac524a4c-f025-4e8a-bfc8-e32ab85d2de4@os.amperecomputing.com>
Date: Wed, 31 Jul 2024 18:06:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm/kvm: add support for MTE
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 darren@os.amperecomputing.com
References: <20240709060448.251881-1-gankulkarni@os.amperecomputing.com>
 <CAFEAcA_7BOXSLXJ=VV0pWDvrN=2dWrM3bRTG+31ivPjeVbWGKQ@mail.gmail.com>
 <0c171de4-a8ea-4859-b78c-272244267bb3@os.amperecomputing.com>
 <8734ns1p3y.fsf@draig.linaro.org>
 <b5e18524-df95-4cc3-a792-88df69ba7c36@os.amperecomputing.com>
Content-Language: en-US
In-Reply-To: <b5e18524-df95-4cc3-a792-88df69ba7c36@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXP287CA0024.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::32) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|BL3PR01MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 8089514e-a6aa-4cf5-d4b1-08dcb15d6d3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVAxak12R2xINWhpaWNUOHpJcHd1aDBrUkVjWE9QeXNnRGhRR1lFVFNlYjhL?=
 =?utf-8?B?c01RMTV4L1lWZVRSUkpNVmV4TzVKVHEyMGpYN2JvL2FPRlF0VitON2VOT2p1?=
 =?utf-8?B?TmROdXYzQmhuTnpDbVBvaUFlcXlvZlZaUmRZRVZocUxoVXloME1QQ0lyOC84?=
 =?utf-8?B?aXhYSU0xeG1IcHBVTWdVdEpESVJNeEs5aHJHdE1mc1lhUk45RFRPZDFUcnlu?=
 =?utf-8?B?T1BFQ1JQdzQvaVlUUWdWYm1TR1JyZ0MrTU43WjQrUExhaU1JTFJ5K25tQ0ZL?=
 =?utf-8?B?TDdOTWNmc09uem56cVB2YUx3R2JoVlpIUy91cWROMUdNbFpjNmk5ZXpHNHNZ?=
 =?utf-8?B?ZzRjZDJUSU5xRVZiUEJTWHZQT0RvZUlhRmhMNTJZa1VjVnhkRHZ6elppWHpS?=
 =?utf-8?B?My9yVEhpdTZJaE9aWlZDa3VKcDdpK1ltd0wrUzMxQUh4UmhuYkU1WXlYOEJx?=
 =?utf-8?B?Z0JlYzQyeW11VndoR3hJVGRKRDZmSk5pTytwT2ZkcSt6OWpNUmtMZjdTbHhU?=
 =?utf-8?B?eTBrUk1ydENZRHhEWWEreG5pS2VVWmtBNjdnamM4c0l1YVpqUHlYVXl5cy9R?=
 =?utf-8?B?NHJUeXlHTVNiUzJiVCs0azd6SS9ad3p4R1BzYnVQU0FkczdMcExBcDhqRUl2?=
 =?utf-8?B?enZneEhVMEMrNmlEUnJ1ZjljcDlQbUJaK3Q2eGxVbWp5Tmc5TitZRGR6Q2hR?=
 =?utf-8?B?ZWphczJCNkcxYzhXbkJCeURqWDdpRmZDbEFXTTZPRU5uK3JHM08xTGduTUlY?=
 =?utf-8?B?WmE1azdkd24xc0hYamg3aVlqSnZLNmRPNWF6aVkwWGR0cTZod1UyUjB5eXI0?=
 =?utf-8?B?M2VxSHhueHhyMEtQY0JlV0Qrek5GRzZGcDVQM3BqQXBhanlkYnZ4TjFUaytj?=
 =?utf-8?B?QjFhbnZDdXEyMlZOaWF6N3MxS3BlRlRidE1xNUNONExvbFM5L1RLYjZUNkRY?=
 =?utf-8?B?Nm9kUFJwd3hVT3MxSlVIRUtnTGZac0lIa0FFdlQyc1BabTVYV3JtWXVvMnBF?=
 =?utf-8?B?NVZNWnhGUUdCeHlmT2xaZTE0YnFrUUk2VEU5bEV1UlQ1cU5WTXlBc2hGbFY0?=
 =?utf-8?B?TnpJYnZybjhvcmpLSVkwcS9CbFRQVlpqeDNZVEQ5Q1d3M0FEbVpKTm9kWU1D?=
 =?utf-8?B?VnVCcUk3K0ZxRWI2bHdPemE1ejJRTjlmSjRxYkJTLzlhK2VKL3VHOGpjU2Zo?=
 =?utf-8?B?bmlMZWlRbGt3UlRHUE0ra25KV2llZVpZK3ZPeU9vODdXZEZBVHk1ME5YYkw1?=
 =?utf-8?B?UHRaWGRiRk9TY0t1NUh0MnZMVW1ZajdUakhHNzB1OWgwSklpSWJieWcwaWNh?=
 =?utf-8?B?V2NJT3RnNk1CbkF4eStoblFUTFNSVEszeXhGVEJZVGFtSkJHUENhRC9XbFU1?=
 =?utf-8?B?d1JSNVUzTkVPbHRCQ3YvMGNzSnVTYkxaMnR6OHJqNFlBRmlPTUdtYzFzZjlY?=
 =?utf-8?B?OFBiZzdHdmw2cXJOMFhjWHNBM0xSYTROMEdnWHpMZGRtNG53T3ZHaUpzLzNj?=
 =?utf-8?B?MllHMGtrbDJpbnY3Mlc2NlB5Wk13RnFrZEN4Q0gwR0hhcXVBbDFnYXZlQ01V?=
 =?utf-8?B?NVhEUDBhSWJjZ2kwS0JUckVMMkJZTjNLdFVyY3VLcHJkN1dYVkk2WCs1L3Rl?=
 =?utf-8?B?aTNpWS9DYUV0eHkyUWJhMCtOWU1KeGFTSXhOUkkzTXI0OUE3a2lwM2N1WkFw?=
 =?utf-8?B?RElTSlZ5RFRMN3dJSy8vUnRqNFYwRVBNZS90V0txbXpZNTRRbHVkYTZRdFM5?=
 =?utf-8?Q?j6YrobIOBNAxrr55ug=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR01MB8101.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWt5cTRYMDVBSm5ySG8wRjFJUkNEUFk5RXVwMkVHaDMrcnBjQmxxdXBtTHZR?=
 =?utf-8?B?RjVIV0NnT29oKzhqVE9nVFVGN1pSak1WMVNWYjRYM2N1R3p0b00rUmVHNXE1?=
 =?utf-8?B?c0VTWU04SUZFWHo4dTBsNU5XWTdYSGwwaGtLUW1GRkQ5am52YVZacUdVZ0dQ?=
 =?utf-8?B?Ukc2N2Fxd1JWWk9lQ1JxVU5sNUtkSS82MUd3SjROS1hDbjRvVkN3c3dyOHMz?=
 =?utf-8?B?d0tuYWdlV0VYRXFtN1hkT0JBeWdwMHZXT09KU0FKa2huRUVIMzgvYnV4dnpP?=
 =?utf-8?B?M2Rka3dEcEVSMlF3RXF0SmFaRkY0aWVVODIzSEtYU1plMkIzeEVEWm80b1Bv?=
 =?utf-8?B?Vnc3bXpTcmxZeDdKVGZIMTdDdnBhRy93aG1QY2xaNFcvOENQWjdOQVZxdm5G?=
 =?utf-8?B?ekd4TkQ3THoxVnpKMXhmZW1IandrL3ZkUWMzK28xd0tLQVdMU0cxS3JTK2cy?=
 =?utf-8?B?YldxQUxpMmUvaFAxdG1NN2tmanNjcnYvK05naWMvb2xGKy8xdzk3bWpsclVC?=
 =?utf-8?B?dFdjdUpNNGlBMVJGNU9FNDNlckJ6SmEzSm1zVklBdEJVUzNLZGlONUg1T25V?=
 =?utf-8?B?RGpsdzZVRENxaWJIU29FRjdKeTFmZlExWUJPRHpWaDdvYTZvV0ZIRTd3SnJL?=
 =?utf-8?B?ZzRZQ1V5WXhydzFXY2JmRVlvbkoyZ2pzOFI2aTJhU1UxYy91dGxpRXM2NkxY?=
 =?utf-8?B?c3JtY1pPcms1R0pLRmlGU013d29OTzNHa0NHaDBtM0o5d0xOWVRFbWlhQktW?=
 =?utf-8?B?Q2NnRVc0ZDRQTGw3Rm1ycE51UjE5amVPOGpwM05oWGxEc0F1S3dwbjYxblYv?=
 =?utf-8?B?bmNXMDlHWUJTdWNHbUVnT2N2dW9jODF6cVZWT1NzVU80anFVQXBQbjhwYUdM?=
 =?utf-8?B?V3lvK0VJNVU4STMzSGExWm5ZblhFNVVoVTdrOTV4MGJ2cjRZRlE2K1NhR2Fs?=
 =?utf-8?B?aGdRbk4vNDJJOHJSZ1ozSjdPUDlqaExlelVVWUFsUFFHZi9vRnBHQlN5VW9H?=
 =?utf-8?B?eWNIcmVXU3hPMmloZnB3Ukl5QzREM2JrMEM2S1pjbkpqSllEZ3Nod0ltYm15?=
 =?utf-8?B?NCs2MklhK0Y4SDdJUXdraEV1SUgreVJ1UkZNL3g0MGV0WDVreGpSRlQ0SzZs?=
 =?utf-8?B?L3d3Tm9IbFpBcFRNT0FXV0J2cVdKNlJNWGZyVTdEU0xTY0lCWWlRQXhFRzho?=
 =?utf-8?B?aHY2NmRQMEZ2WnluemxwbXM2a2FNRVFiZGhGczQrQWg3bVIvcFQ5ZXN2dU9R?=
 =?utf-8?B?L25KYWpJZ1FZSmtaZ3VwNS9aZHJNWHpkU2M3UDU0cXFuWEcyVTdwZ1pjajNw?=
 =?utf-8?B?TXB1dVFnM3NJVHp2VFJ0OGRGM3l3TTFQem43dmt3ajBQWUFxeUNPL3Z0Q1R1?=
 =?utf-8?B?Snc0TEdUcVlwMHphajlkRDRldUJoTGpZVDJ0dGdzcmZZVDBRZGtMS21zUEdD?=
 =?utf-8?B?YVFHVmh0NktsTzZqejIzSGphZDloZFMrRjJIYnRvcENwTFB5Vk1uZ3Q3SWY5?=
 =?utf-8?B?RzZNV0FvaHFLYllNMXJEMU1YQWs5MDg1d2o5NWhobitqVE1EY0JNcGJtaDdv?=
 =?utf-8?B?c3poZGt4S3FWREc2bElObGFFT0pWZEhuOUFjTDdYdUdYZldpV1R3YWFiVjQ5?=
 =?utf-8?B?LzUzVGRUd2srYkFnRG9kOEJzbm5UOW8yaHZETDBlc2hNU0NsL0pZSG9RWU5D?=
 =?utf-8?B?Rm9HTHZ0R3NCVEF2ckwvYWxRNGx2RHNFQ2lwRHlVUTJVNGNVK2xtNDBBNnds?=
 =?utf-8?B?OUd1anhDdFB5M1F1WDYrUjRJTkdsbjdpMWZqQ2dVdDBSc0hZR1R0aDNXOFpJ?=
 =?utf-8?B?ZTR3aEdoaWF3SWlQbFhEbVo5VElnQUZmZnViZGFBSCsxcDNHTlhyQVlnZkMr?=
 =?utf-8?B?bm1xa1VxWGdIQlhKM215aFY4bEFhUno4elFvZ1JUYzBReVI3RkJMNUFlaGI3?=
 =?utf-8?B?TDNwSVgvekJlVkZkODJSQ3dLczBRcU50NHNxc2p3bU9rTmxMRk1IN2RmcW5F?=
 =?utf-8?B?RlZpcVNkSE5YbHRxa3ZGL2hpVHRVWm9XRjB6SG5XY1hHUDRKeTY2ZFZ2aFdD?=
 =?utf-8?B?TWlQWWx3SFVKL3kxc2x3UnpZZDJxNzdNU0dqZEVvRkhvV0Y4dVh5am83cjV5?=
 =?utf-8?B?aEpnM1pKTm1Pd3BSTHhkbVJsbk9NRU9kam1jZjc2S2VkTjhIMXhzM3psc2RB?=
 =?utf-8?Q?i5IHN1VcEasItpL1CIhuSGI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8089514e-a6aa-4cf5-d4b1-08dcb15d6d3f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 12:36:40.3940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4F9DtP0WlL6a4h7zcejWQcoJ26w6zVV1/CWYzz4aInkbJoFzOG9H7/KUR3A35Avne47AME3VLE86TXXkX1sza06iQO6boDRe5alhefpBGgOBVXVNIoo4pHwYrzumeTY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6995
Received-SPF: pass client-ip=2a01:111:f403:c111::9;
 envelope-from=gankulkarni@os.amperecomputing.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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



On 29-07-2024 04:10 pm, Ganapatrao Kulkarni wrote:
> 
> 
> On 29-07-2024 03:44 pm, Alex Bennée wrote:
>> Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> writes:
>>
>>> Hi Peter,
>>>
>>>
>>> [Apologies for the delayed response]
>>>
>>> On 16-07-2024 09:15 pm, Peter Maydell wrote:
>>>> On Tue, 9 Jul 2024 at 07:05, Ganapatrao Kulkarni
>>>> <gankulkarni@os.amperecomputing.com> wrote:
>>>>>
>>>>> Extend the 'mte' property for the virt machine to cover KVM as
>>>>> well. For KVM, we don't allocate tag memory, but instead enable
>>>>> the capability.
>>>>>
>>>>> If MTE has been enabled, we need to disable migration, as we do not
>>>>> yet have a way to migrate the tags as well. Therefore, MTE will stay
>>>>> off with KVM unless requested explicitly.
>>>>>
>>>>> This patch is rework of commit 
>>>>> b320e21c48ce64853904bea6631c0158cc2ef227
>>>>> which broke TCG since it made the TCG -cpu max
>>>>> report the presence of MTE to the guest even if the board hadn't
>>>>> enabled MTE by wiring up the tag RAM. This meant that if the guest
>>>>> then tried to use MTE QEMU would segfault accessing the
>>>>> non-existent tag RAM.
>>>>>
>>>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>>>> Signed-off-by: Ganapatrao Kulkarni 
>>>>> <gankulkarni@os.amperecomputing.com>
>>>>> ---
>>>> In target/arm/cpu.c:arm_cpu_realizefn() there is this code:
>>>>       if (cpu_isar_feature(aa64_mte, cpu)) {
>>>>           /*
>>>>            * The architectural range of GM blocksize is 2-6, however 
>>>> qemu
>>>>            * doesn't support blocksize of 2 (see HELPER(ldgm)).
>>>>            */
>>>>           if (tcg_enabled()) {
>>>>               assert(cpu->gm_blocksize >= 3 && cpu->gm_blocksize <= 6);
>>>>           }
>>>> #ifndef CONFIG_USER_ONLY
>>>>           /*
>>>>            * If we do not have tag-memory provided by the machine,
>>>>            * reduce MTE support to instructions enabled at EL0.
>>>>            * This matches Cortex-A710 BROADCASTMTE input being LOW.
>>>>            */
>>>>           if (cpu->tag_memory == NULL) {
>>>>               cpu->isar.id_aa64pfr1 =
>>>>                   FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, 
>>>> MTE, 1);
>>>>           }
>>>> #endif
>>>>       }
>>>> With this patch, for KVM we will end up going through the
>>>> "squash ID_AA64PFR1_EL1.MTE to 1" codepath, because KVM doesn't
>>>> set cpu->tag_memory and this is still using that as its check.
>>>>
>>>
>>> I looked at this function and it seems we are not entering this
>>> function for KVM boot. I do see -DCONFIG_USER_ONLY added to make
>>> files.
>>>

My bad, please ignore my previous/above comment.
I did not hit this issue since cpu_isar_feature(aa64_mte, cpu) is 
returning zero/false on my ARM64 platform. Then I dumped the register 
id_aa64pfr1 at QEMU(qemu-system-aarch64) as well in Linux(vanilla 6.10) 
kernel(for ioctl KVM_GET_ONE_REG) and to my surprise, in qemu the value 
is 0x21 however the value at kernel is 0x321(expected value).

Root-caused and it is due to, kernel is hiding[1] the MTE bits of 
ID_AA64PFR1_EL1 register from user/qemu. Need to send the kernel patch 
upstream to revert it, otherwise this check in qemu is dummy.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.11-rc1&id=2ac638fc5724f011f8ba1b425667c5592e1571ce

>>> Also Linux kernel wont detect/enable MTE until unless the
>>> ID_AA64PFR1_EL1.MTE value is 2(b0010) and above.
>>>
>>>> More generally, how does the enabling of the MTE KVM cap
>>>> interact with the ID_AA64PFR1_EL1 value that we read from
>>>> the host in kvm_arm_get_host_cpu_features() ? We care that we
>>>> have the right ID register values because we use ID field
>>>> checks to determine whether the vcpu has a feature or not,
>>>> even in the KVM case.
>>>> Since Cornelia first wrote the patch this is based on, we've
>>>> landed gdbstub support for MTE (so gdb can find out which
>>>> addresses in the memory map have tags and read and write
>>>> those tags). So I think the KVM MTE support now also needs to
>>>> handle that. (See aarch64_cpu_register_gdb_commands() in
>>>> target/arm/gdbstub64.c.)
>>>
>>> Ok sure, I will go through this file to add/update MTE part
>>
>> So to be clear the current MTE gdbstub support is linux-user only.
>> Gustavo has a series on the list that adds the system emulation part:
>>
>>    Message-Id: <20240722160709.1677430-1-gustavo.romero@linaro.org>
>>    Date: Mon, 22 Jul 2024 16:07:05 +0000
>>    Subject: [PATCH 0/4] gdbstub: Add support for MTE in system mode
>>    From: Gustavo Romero <gustavo.romero@linaro.org>
>>
>> which of course is focused on TCG. But if the KVM guests sync to the same
>> registers to cpregs I think most stuff should just work. However the
>> current code uses the TCG only:
>>
>>    allocation_tag_mem_probe
>>
>> which I guess needs a KVM equivalent to query the tag memory?
> 
> Ok, thanks for the heads-up!.
> 

Thanks,
Ganapat

