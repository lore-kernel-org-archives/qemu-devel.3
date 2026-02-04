Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734F1E95389
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 11:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnb9b-0004ge-Sd; Wed, 04 Feb 2026 06:34:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnb9a-0004gM-1m
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:34:38 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnb9W-00029g-SG
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:34:37 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6145fLp73084013; Wed, 4 Feb 2026 03:34:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=RzXUq1hq/Ke3lmSIw29FUR9YNRYg2KA1KTR0L2+V7
 Vg=; b=VQqbZriBak6KvTOeWxPHmQwBiBBydABBs90O4ej0veVUY+NnieEj0avnX
 GhRi2YGIauxPh3u4h2KQpjaA6s2q1ksSVCMXJ7cft3/dFpOc6C8oWv9Hwzz94D1Z
 +HTnhejgIcYrb+mBxM5R+5J0UpTQTTseIfq56iuoeO9LCsTXTjh8A60RuqkKmJgI
 Dqwwe9kni2zYDT/4Qza5a8CERhmW4+j3tq1StgG2TLY3lDaq/SsPPJ8pTFNyGxAr
 M3T5eJrftUZbIszKzj0Rez7P9VYQqY2QtMOj+Vm0cxGjPJR/m5GOlRD8oT53z7DO
 JLsHpTXSG1cDTd31sPD3cSz9Kd6hw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021123.outbound.protection.outlook.com
 [40.93.194.123])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c3b02bv0e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 03:34:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqD5Z1GXlmIpE76bOYp3xJcNJ08Xnf4AdvyTVdE++NuhvzyqIKXDOydibGg8OVMsrSO/0Wr5cNgFygI4uXmkRhE+N4EJogI8PE664jmeMiETCgMNhG4XD56fi1trD066dmfyMJ/ziNMPB+Z5KlpD16ZCAlZHrZx/Q30UjTe9xRNF68/kpEZ/fqsUOZ7ka/pfDIK96SgJaTbDgdHopDRMzktyDzHVUAv9/AybYZobmW97b/AnNv7Ka1WQzKt+DoMZG+pJsH+PkjOaGSVIXyaJOhrbk7nG4yjI50Hmc8seHergDXF6EEj8BkJRCSBjPKmdwrFqRCFCC9P6OZKvgcYY5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzXUq1hq/Ke3lmSIw29FUR9YNRYg2KA1KTR0L2+V7Vg=;
 b=TEhbRe3hQcI8JLQw4yEbNQSb2FO01jKNtLXnkkrlkNrsrDoffVHug2KRhSbqgze+KRaQtlgV3h67HuoMLrrQ7fiZUoHyCa4XhdYFJbyXqffEolqJ6Q0n6cRd4jgtaxQF1v49Tp4vZjhxvAy+c3c54Y9rydKVywWhvOkWe9W81AtoLUF2uTDT3Nl0IgeawYZHVF0Ap9Hbfn/k25Aao/NdR5BY2telzUdL1p6ICrOzqzOUjUIKUYzczxg3uvRyrNUvVwRx81p9otfhdCei36bVC7G3gG7UamgayL8syvHPnkcQI+OEDyFz6uv+ByJrpypwnNj+r69ZukAuta27eO5OLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzXUq1hq/Ke3lmSIw29FUR9YNRYg2KA1KTR0L2+V7Vg=;
 b=jcXIaI7lgLkW6/vHUVQF4lyrouJ63yFKdCVrE202IC6D7exYBVAeJz760hXgt3t/C5Zq/aFkfbl1/pYLrP5ApZWUcG9fsLpRkdtyn5B13im3YvpXoEOUwk2oe5Wc4MQJoAbGzldCTw5HF80crwNvudCu12w+utHzHmj9BlwSee4nECIrn3SVxBE3kqBPdmKk1g654s+bXfP3kC0eAH6iun9tdiBn9tqERS0PwvEED0koTgSG/6FyapHnnzR7vOiCbhc4Eu/lgelqd2MgaXzC9RLHhEYWFwSIQk6yAYfTp1Z2F6Ao5ZdQBPP18K6GUMapJ94F7tGJd0E/FlnwKE8+rg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB7007.namprd02.prod.outlook.com (2603:10b6:208:207::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 11:34:24 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 11:34:24 +0000
Message-ID: <f7be1b64-fc68-440a-80fc-59b28c4df32d@nutanix.com>
Date: Wed, 4 Feb 2026 11:34:21 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/37] audio: drop audio driver registration
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-25-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-25-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::22) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6d6626-b54a-4eed-45f9-08de63e158f3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWZaNEEzczYyWFEzSDcwc1pVQkgwZFBtREFUeG9OQ0JhK3NkcFZkTVFBV01u?=
 =?utf-8?B?emt5dzl6alo2TFBwdjB2YzVtYkV0b2pkN3I0Nmtya3kxMHd5QkpLd2paRzkx?=
 =?utf-8?B?dFVreXRnbU5pR05BeUlaQ1EyM1dHQ2RlSG95dXBxSnJ1azdBcEJxd0xqZWV1?=
 =?utf-8?B?ZnA5Zmk1cXhHYUFUU0IyMEkyclNGWEZxR1poekFnb3grMjVsSzErVVJ6enRl?=
 =?utf-8?B?OU5LOUNrRjYxaUZFRld2N1BwanR0aE5jUDRtQ2JKWjJldmlGRHZ5Y0xWNFNC?=
 =?utf-8?B?NEdmNVhLbndVWUtXTUdXOGVnemcveEFxOEYyNmNxR3BvT2NRYXlFbkhIRHdQ?=
 =?utf-8?B?QlZsWDIrakdhcjlsUk5tcVp0cTlaMFR4VUcxNEJPWVFlUmZNTmNjYTNtczJo?=
 =?utf-8?B?K1VHY2dNczFLRzVvcnlLU1ZZRFVVZW9ZNjh4OWhuNnlKSE9nQjcrM0NFOFQz?=
 =?utf-8?B?UWNSY29QRHJSMXZ6S3Z0dVBKZVdlci91bGFVbG5OZTY4WHNSa2xVaXl2cHg2?=
 =?utf-8?B?MFRJS3FqcjN2SWtha3p2WVFMTDNDYXdvTTVQa3FzL3ZYMHlEaEJoZ2VkcUs5?=
 =?utf-8?B?T2ZwTFA1RFNKRkVCcEY4UGhDUjZ6RjNDTGV2QkFKLzdURHB0Ym02SkFpbHZp?=
 =?utf-8?B?RFBFaHdta3JjaFNORk4wZW5CQlRYVHZ0VG9FTlpvSmJ0L0ZwL3lTSCt4Wjl4?=
 =?utf-8?B?eHhmcTh4M1YrWjY5cmJPZXdCd25ibWM3NXdKcFlMU0hyNHA3T2xKWFpDbWxs?=
 =?utf-8?B?MVEzNkc3UHFsOXhheHVaL3dxSVBUcno5UjBvYmNOSmloUXVRcDFnY0owUG9j?=
 =?utf-8?B?bU1ERW1RWW11TXFQVzNKV2ErZTZ5bmR4N0N0K1l1azh5eWNxYVZ1ZFl2dnpZ?=
 =?utf-8?B?aXdvb0s3Zm8xR2N4NTYyc0ZCZU9MMEZCZHVDVXNJUE03UkNydE00aWM5eHdC?=
 =?utf-8?B?bW1EODlzZHZhRFZxWUEyLzZvQXFlSk92UFNlUng5UVdmSmo3NlVZV00vNm9s?=
 =?utf-8?B?cWdmbVk3cW1HakQ3Z09uY0QzN1VJMTcrZytUWkdJenYwUitaazVrT0trYXRG?=
 =?utf-8?B?QXExNlhtNGZNSURFTkMzZlk0TWcwZ0loSXBQcTFKMzA1MVFEeDY0VTVEZVRW?=
 =?utf-8?B?Z1R3ckRGZWhzRjVJMXRZRnNXNUY2VDhLMGYxOUVZdHJjWHJaRU82aGZ1OU1O?=
 =?utf-8?B?L2lkUGxEMmNtdVJud29vYUdDR3dYYlovcktyOGtaTWJ3UTZBYkhqSDYrRERj?=
 =?utf-8?B?aDU4UVJENlA3S2ZIU1VUMmNaMll5ZGJYUzVlb1NSNjg4L2RVUkcxZU5DbjlK?=
 =?utf-8?B?bXZvZFhoMUFoTFBnWm9ud3pob2U1K25TcmNKVEo3MlRCUHAraERFS0ZPaTN3?=
 =?utf-8?B?VmxiMUdyaTlFc2E2czk0cFR1OTZHK0hsMEhEVitwS2RqUW1USkgxRmlwR0pC?=
 =?utf-8?B?dUprM0F0WGx0NFg0bkV5NFZSbENjU21Qa1dOaXlCakxEcVlPWXUvYjJ4N2NC?=
 =?utf-8?B?OXNkVDdRdHptYlkxM2xSSHhJWStaZ0xCNWFFRGg2Y3A4WVp3Q1hNQklNUGVp?=
 =?utf-8?B?cFJZL0I0b3NLOFIyTnJGUUZnd0VHRExwT3lCYkZiVTZKM3JFOXg2K1pKMjlB?=
 =?utf-8?B?ZDZwQ3BaUmZYVVk0TkJqZTI1dnVEcW1VZWJhQ1orR1g1ek95a1dnUFFYOUho?=
 =?utf-8?B?bzJEUEpQR2hFcWwvRGo4TXJIK05mZjFqSTBiUDU2S2FNTTBaZzBZRFhtV3pm?=
 =?utf-8?B?Q0VuRHZWZ24rUkxWK3pJL1VObDVEbGllUGlBeTUrbjZ0aTJ0Qk1US0lpWjE2?=
 =?utf-8?B?ZHlDQ2VkdVFYa1dJYVJRckFBNjlHRUIyK0JNSWdyUWJnV2N2S0d4WVJrbkZm?=
 =?utf-8?B?aEJzRVJIRVRNOUZnZzkwUGtoWGEzbjgvai9EQXZZa1NRREd3RXpXVWxYb254?=
 =?utf-8?B?TjdLK005ZVNtVjlsTnBLZHkwZlV1cW5BZGsyNm9jbUp5VFZPc25xeitBU015?=
 =?utf-8?B?YW54akZlbEhHb2FHUzZDb1JBaVVzejVSVE1ldE1BVTg4RVE4emJTSDN4VDUx?=
 =?utf-8?B?SzlOVkJUekM0dE0zd2REUGdZWFJsMUdMUUVjRm0wMjRxdFBYM1RxUW9Qdmhw?=
 =?utf-8?Q?wM8s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDlFY2FQVjAzSyt0WXhYcDVxSGJETmVkU3ZCVDZCTFRPWnc4VUlCYklYNnlx?=
 =?utf-8?B?ZE52QmU2enlDUWZMTi8rUGpBRVNRUUZoSTI0UzVlS0tqL3lBL1BuMCtVZmtq?=
 =?utf-8?B?bERoWlkzV2NydXh1c0dvcFBsSjA1RjdKTXNkUjdYTVVUUWhJd0ZoUDZqUnU2?=
 =?utf-8?B?MDRCZUMyK1R3M1ZjdlZMQ1E1V0c2Q3lTbUhKTXdhK25JU001aStLenlLVlBL?=
 =?utf-8?B?WEpZbkc4dDVGbm1BNGdad2JOc0lpOUJSM1BGUm0vdjFGWU9Pb205WGduSStr?=
 =?utf-8?B?YlE3bVZBS0U4aVBhVDFxbE1SVVZnUWx3WUVhU1RiRmE5VFZkdEtNVE1BZkV2?=
 =?utf-8?B?T0x5VTNwMXc3VmNyTVpsNDRNOEo0Sk9IdTlpbjRiZWRsdTRSeCtNazZieEdP?=
 =?utf-8?B?Q0JBdWJDaGRRcVJBSDFHazNoZ1BwbFNFY25keXpndTRGdzBzWFRnM1lyWXVp?=
 =?utf-8?B?NVpPWVNrZVJiWE14T3hmdjhueGVITHJGQzREQisrbXg3OVJydUF6YWpFazNi?=
 =?utf-8?B?MVljbEFTcFMwUVRmN2NxbVl3VTg5dFZoL1g4eG54OGdReEVVK0hlaDFHTVBu?=
 =?utf-8?B?VC9FQkNOR1JQVWFuMS9WcUUyejhnNWQ4OHkwK3NUVWpRUjhnSFIweURjQ3Fy?=
 =?utf-8?B?cHBYWElOTC9CcVNHcnZXUXN1L0J6b1I2OFN1TDk0dzRoL2p3Q2IvbDRsNzFn?=
 =?utf-8?B?dC9xWndxNWpqVGk0b1FtdGZHWVhQWmdhd3NDcHlySmJFY3YzYUNkbit0ck1U?=
 =?utf-8?B?ZUNSVW1wN1dtSTk0VTZtV09lMlVDZlVockg2cmlOUTFjZE9vdFNtZkpzb2RU?=
 =?utf-8?B?RFpMV2RiWFFuUnNmU1UxMVowZTZBUWlWcnM5Zy9mN3dJb1Z4MUpKWEdwSnVI?=
 =?utf-8?B?V3hrYnNiajZydjFwZHZKY2czNGIxUTNNODdHOFBBNC9ubmhCN09oNG5QTFBL?=
 =?utf-8?B?S3I5dXpwVXF1YU5pbFpBQzhzUWJDTmZoYTV3amdGaXIyd1VxbXhsc3ZGZ1Ny?=
 =?utf-8?B?NlpkRW9nNjNhREp2TStYK3BPMkx5Z0hhVzUwVDdNZ25jUno3ZTRSc05kWjZr?=
 =?utf-8?B?TURUYWh1MUxRMnlHbXJsVjJlTmx5ZWx1WUlGcmVueTYrV1ZMWXMvTWtCUE92?=
 =?utf-8?B?bzFycDUwTE5ncWs2ditRaWUvTW1sSVltellFS21yZzJqMTFqQ1BOMU9EVFo2?=
 =?utf-8?B?d1RvTzYrbTJ3YXpmWFdacm9VMGpIU0JQNWlhN3hOdFNxaXl4amZuZThsUFEx?=
 =?utf-8?B?Si9KTjBrK2FXNU5DRHdSY1NEazVzSm0rQ1NOTEhhRWpoMTFGeDVvWVZ2RDU3?=
 =?utf-8?B?aEtZdDZRQVp3aXQxc0NjRzNKbkJtRzZTSmhmazlTNTlHa0psS05zTTlsVitr?=
 =?utf-8?B?WDlpN3VCU2Rpd09DOVkvVXVlQk9Ib251UDcvdXFTdkFRek4wMG5jdGNzRi9Q?=
 =?utf-8?B?bXZnZFZqd042NmtuaEtwOGNzRFNmSWxGZWZ1YnFlUXBLTFZwcEo2VlFFSXdz?=
 =?utf-8?B?cUY4QmhpY1Q4Y21UQ2Z4M2xwWTNFK3IreGREMEw5Q0xEMHZySVdIb3ZOT3J4?=
 =?utf-8?B?eWZZN0t4RDlOZklTMmN2N1pXSjlIWldaN3JGR0lPN0xSQTVQQ3RvdnZJdzVk?=
 =?utf-8?B?WUI4WDl1UzhYaWJTbkExeHVLN2J0eWlTUW5jUTE1LzNZVzBIN1FKanRoYW5Y?=
 =?utf-8?B?VENGS0RjZTg0NDlUYVNuakV4MTlCdjY0ZGVISlRJQVFVZjdOS2kvcXI4MXlX?=
 =?utf-8?B?YmpRNWE1Z1BxTm44ZVM0K0dzREhZOHFnZVRzR1pnK1RxcUhNVGhjeW0wcHVS?=
 =?utf-8?B?T2ZOU2hCY0VqbXRSdWdhZGFGcE9IZlNXWmQrdGZKSjFXVDZqTW90Vm9QRFQy?=
 =?utf-8?B?U2FBVFRvYXF4TlAwMGRSMXdNYkNBWGp0SzFWaU5zQzNiMUxpMjRUR0k1RFM2?=
 =?utf-8?B?aDlXVHlML3A4bWxJaUxPMDFSYXJwR2RFUnZkTTc0cVJXSmdJVzhrRFlPMC9S?=
 =?utf-8?B?cGUwd3hBVVNsREVlZ1FTNDQxWGtUSjRYSUNNendHcGIxL1dSQWNJTnRaVHNW?=
 =?utf-8?B?dTVVRzMrWllFbWxSYVY0ZXZWWVNRV0tuQVJZclJwckRReHZQWVlOYzY0Vm9p?=
 =?utf-8?B?Wjg5M2VBN21pVHczSFZheVZ5Sm1SZCtDRGpjd3FGdUNnY3ZvaTlBWjB3Mmxk?=
 =?utf-8?B?ak5EaVZYdWtIUGJ1SnZpOEk3WHlCK290ZjM2aHRNODFSM2NnUmxVV013bUha?=
 =?utf-8?B?Q251Zmx1YkdGdFROVlNibkprRVRMWEF1QXpXbm9Hc0N1d0gvbWFyWGczZTFk?=
 =?utf-8?B?LzczRmRWRXM3RnAya0hIek10Ry9zRS9xS2tpL3huYVdDRjNMWDJkNXlCUmRK?=
 =?utf-8?Q?+kq79cmX+WZjsBvs=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6d6626-b54a-4eed-45f9-08de63e158f3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 11:34:24.5186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NITS/JiVyjlZOf+iiqWEI2B/3pkUTNlIk6oGxMVkE4ONbVZIQ+cQh4wDckh1hqkAIdGFxwPWmZxSJmVUew/vp/Ar75qZvYkNobvFnkisbEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7007
X-Proofpoint-ORIG-GUID: vsF2sQKfWPdmU7qdSyWl3zdfHmldU9ZV
X-Authority-Analysis: v=2.4 cv=GpRPO01C c=1 sm=1 tr=0 ts=69832ec2 cx=c_pps
 a=1pmWRJemPF16E+bttNzokw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=RPPDz1SWspHCtKJ6foEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vsF2sQKfWPdmU7qdSyWl3zdfHmldU9ZV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA4OCBTYWx0ZWRfX59+n84Fw2G3f
 Zl/jswa4pcoj7MYal7n/CHtbBnoIQ0BKeMyQuZGroSs9gkdkW5cG51aorCrqI3IIhRFC0CreXXN
 9dcaAsArRy8AT5WgKRyCKWt7QIz2g8pVOnkkr7ZIbFuN1piYdRlbefpwHmpGnV4Ux2zhuBgLZ8i
 G3WeBQMG16uCGKT7XONw4ERjMmEyv+yIyWjNbjLhyCQ4rOQhx77AQh3BIX1cF+x/7evi+AIul5Q
 VPdoRSN6Wl2PrpzxL41gHR5my2Qi0L6gZo5TS/XONsG9leefMYYpHYccSYepOMfqFs1Lna4gQyc
 c8XIclB6z4AXU5C1HcHA22T7RdHaaY6U/D3FGAFrKJ7ySxdv0PTl1um9QJzw1FwP94GgonL3SkG
 8UwGw7dG8CjPSkH4N1/cx97vd1gVEndZlpFmAkvxH/5qSvKVqguIW3ugAqjjEI8kZFBTKYPat32
 NLEsIt9uyfhFs7dv5Ng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> module_object_class_by_name() handles loading the module providing the
> requested object.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_int.h   |  2 --
>   audio/alsaaudio.c   |  1 -
>   audio/audio.c       | 43 +++++++++++++------------------------------
>   audio/dbusaudio.c   |  1 -
>   audio/dsoundaudio.c |  1 -
>   audio/jackaudio.c   |  1 -
>   audio/noaudio.c     |  1 -
>   audio/ossaudio.c    |  1 -
>   audio/paaudio.c     |  1 -
>   audio/pwaudio.c     |  1 -
>   audio/sdlaudio.c    |  1 -
>   audio/sndioaudio.c  |  1 -
>   audio/spiceaudio.c  |  1 -
>   audio/wavaudio.c    |  1 -
>   audio/coreaudio.m   |  1 -
>   15 files changed, 13 insertions(+), 45 deletions(-)
> 
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 0b97c8edee3..446ba1d52c6 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -259,8 +259,6 @@ extern const struct mixeng_volume nominal_volume;
>   
>   extern const char *audio_prio_list[];
>   
> -void audio_driver_register(audio_driver *drv);
> -
>   void audio_pcm_init_info (struct audio_pcm_info *info, const struct audsettings *as);
>   void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len);
>   
> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> index 881f3d0349d..e8541e1a2a3 100644
> --- a/audio/alsaaudio.c
> +++ b/audio/alsaaudio.c
> @@ -972,7 +972,6 @@ static const TypeInfo audio_alsa_info = {
>   
>   static void register_audio_alsa(void)
>   {
> -    audio_driver_register(&alsa_audio_driver);
>       type_register_static(&audio_alsa_info);
>   }
>   type_init(register_audio_alsa);
> diff --git a/audio/audio.c b/audio/audio.c
> index f6896229cfb..53b3ad09bf9 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -67,40 +67,21 @@ const char *audio_prio_list[] = {
>       NULL
>   };
>   
> -static QLIST_HEAD(, audio_driver) audio_drivers;
>   static AudiodevListHead audiodevs =
>       QSIMPLEQ_HEAD_INITIALIZER(audiodevs);
>   static AudiodevListHead default_audiodevs =
>       QSIMPLEQ_HEAD_INITIALIZER(default_audiodevs);
>   
> -
> -void audio_driver_register(audio_driver *drv)
> -{
> -    QLIST_INSERT_HEAD(&audio_drivers, drv, next);
> -}
> -
> -static audio_driver *audio_driver_lookup(const char *name)
> +static AudioBackendClass *audio_be_class_by_name(const char *name)
>   {
> -    struct audio_driver *d;
> -    Error *local_err = NULL;
> -    int rv;
> +    g_autofree char *tname = g_strconcat("audio-", name, NULL);
> +    ObjectClass *oc = module_object_class_by_name(tname);
>   
> -    QLIST_FOREACH(d, &audio_drivers, next) {
> -        if (strcmp(name, d->name) == 0) {
> -            return d;
> -        }
> -    }
> -    rv = audio_module_load(name, &local_err);
> -    if (rv > 0) {
> -        QLIST_FOREACH(d, &audio_drivers, next) {
> -            if (strcmp(name, d->name) == 0) {
> -                return d;
> -            }
> -        }
> -    } else if (rv < 0) {
> -        error_report_err(local_err);
> +    if (!oc || !object_class_dynamic_cast(oc, TYPE_AUDIO_BACKEND)) {
> +        return NULL;
>       }
> -    return NULL;
> +
> +    return AUDIO_BACKEND_CLASS(oc);
>   }
>   
>   static AudioBackend *default_audio_be;
> @@ -1763,7 +1744,7 @@ static const VMStateDescription vmstate_audio = {
>   void audio_create_default_audiodevs(void)
>   {
>       for (int i = 0; audio_prio_list[i]; i++) {
> -        if (audio_driver_lookup(audio_prio_list[i])) {
> +        if (audio_be_class_by_name(audio_prio_list[i]) != NULL) {
>               QDict *dict = qdict_new();
>               Audiodev *dev = NULL;
>               Visitor *v;
> @@ -2128,9 +2109,11 @@ void audio_help(void)
>       printf("Available audio drivers:\n");
>   
>       for (i = 0; i < AUDIODEV_DRIVER__MAX; i++) {
> -        audio_driver *driver = audio_driver_lookup(AudiodevDriver_str(i));
> -        if (driver) {
> -            printf("%s\n", driver->name);
> +        const char *name = AudiodevDriver_str(i);
> +        AudioBackendClass *be = audio_be_class_by_name(name);
> +
> +        if (be) {
> +            printf("%s\n", name);
>           }
>       }
>   }
> diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> index 9b25269a2d9..2e76d650df1 100644
> --- a/audio/dbusaudio.c
> +++ b/audio/dbusaudio.c
> @@ -738,7 +738,6 @@ static const TypeInfo audio_dbus_info = {
>   
>   static void register_audio_dbus(void)
>   {
> -    audio_driver_register(&dbus_audio_driver);
>       type_register_static(&audio_dbus_info);
>   }
>   type_init(register_audio_dbus);
> diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
> index f1902e55262..3de6a3dee9c 100644
> --- a/audio/dsoundaudio.c
> +++ b/audio/dsoundaudio.c
> @@ -720,7 +720,6 @@ static const TypeInfo audio_dsound_info = {
>   
>   static void register_audio_dsound(void)
>   {
> -    audio_driver_register(&dsound_audio_driver);
>       type_register_static(&audio_dsound_info);
>   }
>   type_init(register_audio_dsound);
> diff --git a/audio/jackaudio.c b/audio/jackaudio.c
> index 48a466ed532..dc86724d28f 100644
> --- a/audio/jackaudio.c
> +++ b/audio/jackaudio.c
> @@ -718,7 +718,6 @@ static const TypeInfo audio_jack_info = {
>   static void register_audio_jack(void)
>   {
>       qemu_mutex_init(&qjack_shutdown_lock);
> -    audio_driver_register(&jack_driver);
>       type_register_static(&audio_jack_info);
>   #if !defined(WIN32) && defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
>       jack_set_thread_creator(qjack_thread_creator);
> diff --git a/audio/noaudio.c b/audio/noaudio.c
> index e6e8bfd3323..fe649523e88 100644
> --- a/audio/noaudio.c
> +++ b/audio/noaudio.c
> @@ -164,7 +164,6 @@ static const TypeInfo audio_none_info = {
>   
>   static void register_audio_none(void)
>   {
> -    audio_driver_register(&no_audio_driver);
>       type_register_static(&audio_none_info);
>   }
>   type_init(register_audio_none);
> diff --git a/audio/ossaudio.c b/audio/ossaudio.c
> index eb98cc62e9c..013958e1344 100644
> --- a/audio/ossaudio.c
> +++ b/audio/ossaudio.c
> @@ -798,7 +798,6 @@ static const TypeInfo audio_oss_info = {
>   
>   static void register_audio_oss(void)
>   {
> -    audio_driver_register(&oss_audio_driver);
>       type_register_static(&audio_oss_info);
>   }
>   type_init(register_audio_oss);
> diff --git a/audio/paaudio.c b/audio/paaudio.c
> index cf67a9f7593..941f75f25e8 100644
> --- a/audio/paaudio.c
> +++ b/audio/paaudio.c
> @@ -957,7 +957,6 @@ static const TypeInfo audio_pa_info = {
>   
>   static void register_audio_pa(void)
>   {
> -    audio_driver_register(&pa_audio_driver);
>       type_register_static(&audio_pa_info);
>   }
>   type_init(register_audio_pa);
> diff --git a/audio/pwaudio.c b/audio/pwaudio.c
> index 3c2fbccaea4..ed48a9754fe 100644
> --- a/audio/pwaudio.c
> +++ b/audio/pwaudio.c
> @@ -874,7 +874,6 @@ static const TypeInfo audio_pw_info = {
>   static void
>   register_audio_pw(void)
>   {
> -    audio_driver_register(&pw_audio_driver);
>       type_register_static(&audio_pw_info);
>   }
>   
> diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
> index cc05c1d4531..1a5e3f8a969 100644
> --- a/audio/sdlaudio.c
> +++ b/audio/sdlaudio.c
> @@ -517,7 +517,6 @@ static const TypeInfo audio_sdl_info = {
>   
>   static void register_audio_sdl(void)
>   {
> -    audio_driver_register(&sdl_audio_driver);
>       type_register_static(&audio_sdl_info);
>   }
>   type_init(register_audio_sdl);
> diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
> index 6a3d93efd51..2fa519e3eab 100644
> --- a/audio/sndioaudio.c
> +++ b/audio/sndioaudio.c
> @@ -581,7 +581,6 @@ static const TypeInfo audio_sndio_info = {
>   
>   static void register_audio_sndio(void)
>   {
> -    audio_driver_register(&sndio_audio_driver);
>       type_register_static(&audio_sndio_info);
>   }
>   
> diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
> index bfa249b18c4..db9158284ce 100644
> --- a/audio/spiceaudio.c
> +++ b/audio/spiceaudio.c
> @@ -351,7 +351,6 @@ static const TypeInfo audio_spice_info = {
>   
>   static void register_audio_spice(void)
>   {
> -    audio_driver_register(&spice_audio_driver);
>       type_register_static(&audio_spice_info);
>   }
>   type_init(register_audio_spice);
> diff --git a/audio/wavaudio.c b/audio/wavaudio.c
> index 480da5048fa..50b0fb93936 100644
> --- a/audio/wavaudio.c
> +++ b/audio/wavaudio.c
> @@ -240,7 +240,6 @@ static const TypeInfo audio_wav_info = {
>   
>   static void register_audio_wav(void)
>   {
> -    audio_driver_register(&wav_audio_driver);
>       type_register_static(&audio_wav_info);
>   }
>   type_init(register_audio_wav);
> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> index 882e47f8c25..710ef0fe6ba 100644
> --- a/audio/coreaudio.m
> +++ b/audio/coreaudio.m
> @@ -699,7 +699,6 @@ static void coreaudio_audio_fini (void *opaque)
>   
>   static void register_audio_coreaudio(void)
>   {
> -    audio_driver_register(&coreaudio_audio_driver);
>       type_register_static(&audio_coreaudio_info);
>   }
>   type_init(register_audio_coreaudio);

Nice!

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


