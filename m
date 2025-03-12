Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADE1C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 19:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsRjl-0002Fk-SF; Wed, 12 Mar 2025 15:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1tsRjk-0002FW-0L
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:27:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1tsRjf-0003VI-U4
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:27:26 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C9kaRb017688;
 Wed, 12 Mar 2025 19:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mmarB//4OA5zxLkMZXxyo/vF43km/XBziuJGa2dRNZ0=; b=CF7iRmxccU9W2Ddr
 ETAaI1nyas35OELLxy/g7KT0tTiussC84s2qUewX15rZQyvl9CfwZ9qGFbCWUVai
 /shURiEIIZGN4qKuh1JQiDxKFqzBmzEjBJA4JVv6jH+AeYKrP5GnGPQ+CYmtrCe7
 hOjDMQhkeyLYCxWxZhaxTokuEOJDZYmf6t0z9jjohxCDhlW4FkuKbpsPMkqhZFx3
 7kpzfRj89DR1SFVLOJ0riWT9DFxKRtpkjp1l8SqODR/B0z85U+5iMs2zWld2GU32
 S9K/xvisPFGD1TEDA89In7O3OJ+7bZZ7q+3xtAvIkh/UfnpbRtxLKIaY8HYk0ZuV
 Qx1qjw==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazlp17011030.outbound.protection.outlook.com
 [40.93.14.30])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au50besv-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Mar 2025 19:27:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAn0myx2OFyTk5D+zQHX7ovS+icoFbWPHITHOmGTtLCpO35PvhO5Pr6EvmDbT1YOQKa5BWpCQ7hfS/XKrToK+Dm8XQtUQvLc2NJQod6r+F3fAqYd3gHc6qedE9+NIsfG1pOxV/tVr23L1dixMSdN05/z/nLKCe15P3C2+7b9JVrXs1A+6QMrqdU/0hJbj/Ljt2zq6xBmX1yShE2T+OVdgDw6vooiI1Y9UBR0w/kXo2ybwNZ/jcMMmWwhOzDL0j4uIJYjIyFFmY1bPWJe4QD62qqltZw8RdAr9d9prBv6F6BgyC8K75+RJk5lbWELePijF4iQ4p8ceTu4/U5COsw2SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmarB//4OA5zxLkMZXxyo/vF43km/XBziuJGa2dRNZ0=;
 b=PsN8MJT2Mnw4f9sttn3mhgD5xyj2rF1V5UFEmCmHTKWdN3OKKvpSCTt0DAt8TOLUotEByMnrgAJWWdO+qm5Krkdc+WOZuvib2B3aO9nMt5NwEIMdedg0Aj7yJaJP2LEoqJD1BCo51wEDUxS/votq4Ocf5Qr9Wlqxneqn9Kkq4M1DlPFRuJTSRK0ANw3eGBsjp3HKwNdn3YN8FpuKJAiTp9b/nCn+Xk07ZcUpyA49Onv0U/e9LbIfqpIylE1y2se/WtM40AxXvuN67sSA0lNjFQNhdXUo7tb5UCcUMr0ypCf8BLjcoh1qLbdmWgdBdrFTxRQ2bi1+uWUHgzXlnP6nTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DS0PR02MB9482.namprd02.prod.outlook.com (2603:10b6:8:df::12) by
 BL0PR02MB6500.namprd02.prod.outlook.com (2603:10b6:208:1cf::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 19:27:14 +0000
Received: from DS0PR02MB9482.namprd02.prod.outlook.com
 ([fe80::4f22:877d:522e:dfc8]) by DS0PR02MB9482.namprd02.prod.outlook.com
 ([fe80::4f22:877d:522e:dfc8%3]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 19:27:14 +0000
From: Sid Manning <sidneym@quicinc.com>
To: "ltaylorsimpson@gmail.com" <ltaylorsimpson@gmail.com>, 'Brian Cain'
 <brian.cain@oss.qualcomm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "Matheus Bernardino (QUIC)"
 <quic_mathbern@quicinc.com>, "ale@rev.ng" <ale@rev.ng>, "anjo@rev.ng"
 <anjo@rev.ng>, "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "Mark Burton (QUIC)"
 <quic_mburton@quicinc.com>, Brian Cain <bcain@quicinc.com>
Subject: RE: [PATCH 33/38] target/hexagon: Add gdb support for sys regs
Thread-Topic: [PATCH 33/38] target/hexagon: Add gdb support for sys regs
Thread-Index: AQHbimqrbpmX50Eku0uSh01oDbQEebNvwl0AgAATOCCAAB1T0A==
Date: Wed, 12 Mar 2025 19:27:14 +0000
Message-ID: <DS0PR02MB948229C8C6268809898EFA5FBED02@DS0PR02MB9482.namprd02.prod.outlook.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-34-brian.cain@oss.qualcomm.com>
 <010a01db936b$9a862d30$cf928790$@gmail.com>
 <DS0PR02MB948274C6E2B3E4F72B5DF79ABED02@DS0PR02MB9482.namprd02.prod.outlook.com>
In-Reply-To: <DS0PR02MB948274C6E2B3E4F72B5DF79ABED02@DS0PR02MB9482.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR02MB9482:EE_|BL0PR02MB6500:EE_
x-ms-office365-filtering-correlation-id: 6d484c0d-41a8-4d6c-6fe1-08dd619be50b
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dHJlcDBtNXVDc0lTQldlem4xTFBNbXZucFBjOVFOY1Bra1Qya2ZuTG1TWVZK?=
 =?utf-8?B?bjVEQ2VMbnpyWDFyNUhWd3ZvL0dob0pZQ1J0cG5TNThobmNzcXlJUUFocm1s?=
 =?utf-8?B?ampEeFI4VG9wMUFwQXRaZDh2VjFKc1lSZ0tjM1U2c3MvTUtpRUZPTG0zYy9h?=
 =?utf-8?B?UWlVZzdGSVl4OUhSWFROcTdnUjNWRS9hVUJOb0QyRjdkYUxiVGNydFBIM0Ur?=
 =?utf-8?B?cG93UVVXUEZ3dnh3WEZzRXVEZGd1MTd6NFFXQU05YnNwNWRKN2dTNHNYS0Vn?=
 =?utf-8?B?dEdxRFRBb2pMRExvaFhhSnJadTd6MVhYZXJRKzlUV0pIdDFrTkFZckM0UmF0?=
 =?utf-8?B?aUlJRThDSXNZZERBZUdHTzZ5T0p4OTZwOEdOV3lNbUU0RWxUZXE0a1FFcmE5?=
 =?utf-8?B?cTZWejUyRjI3SW81VTVyOFZXdlQ2THFRK1VqajlsRzZNZXJNNXZHSElxNVd4?=
 =?utf-8?B?ZWdWcHFyNEU1MnBiaUVibndGenc4N2pjaU1hUHQ1Y1hVK3hOeTdBaThLbHlH?=
 =?utf-8?B?RU56aE9nUzQ3UktFOThKUkxkNVZIeCtQNnpIbVkweWV0S2NBY04rYzdadE9k?=
 =?utf-8?B?Q1RpaCtzcHR1L29aeW44MWNnSkhkK0EyRzZpWWV6d1RROHhFNjZzaFRqQnVw?=
 =?utf-8?B?MHNTeTZtREIvWk5KLzdheGlzcWlpQm5nck9ESVB5WWtPbzZoRlpmc3p6cEtI?=
 =?utf-8?B?am9SOTliZWNJUno1N01TaFFHR2lOQnZsUm8zelVHdHBvV2ZuaWlnZEdUcTN1?=
 =?utf-8?B?VkpGRU9rWFExc09ZOEpHYWJPVjhMU0NGRkNWUnJsTTNNWVlvd3ZnVjdMZktY?=
 =?utf-8?B?djByOTVQY3hpVDVSL013ZUU2R1VBdE5hQklrclNucW92UHZGRFZlZ1oxaEUv?=
 =?utf-8?B?MUkrb2Jkam43VmRrZFNuWDIzRU9kT2s4ZXNQUitlNXdIYlNkSkp3amp5QXk0?=
 =?utf-8?B?SFpYQ0NhVlRNdEVWcVlSVjB6SW1WOG5RNzF3SFQyV0dTUlREaGN6MnF3NHdv?=
 =?utf-8?B?ckhUUlFqNkQwM0x0STNwbVMxcGJMTkZUaVFBeHRBM3RKV2JaWjhLMkU0elZN?=
 =?utf-8?B?bmUrTXJwRExPajhCOWNpb1ZtNDE1dzVQQ2JTYkJCNzVJTjJ6aGY2ZWJ6VUN3?=
 =?utf-8?B?QmQvRFZtNVM0VG5qYkRISURsbFZnd2E3bGc2ZWg2TVJYTXhUalNHV2czWUll?=
 =?utf-8?B?OTJ3STE2UTNXR2dvN1VBV1ZhK0hxNVd6SDhjV0Rad1ZrQm5rTlhpVmVOZVBu?=
 =?utf-8?B?TFdDbnhOMjhzWWhONFRvVjZXbVhlVE0vbFBML3BaZ1NwYk5YLzZtM3Zib2Qr?=
 =?utf-8?B?NHBXNHBMUHAraVFNeUEwc3RUNThlTU1LZ1A2clJrVXhuV2w4dk9nY2VpNy8x?=
 =?utf-8?B?MXBYc3pNR0xnVE5BNGpxR1VwdlF3NXNSZGdHUXFKKzE5TlB4UnRpcHczb0J6?=
 =?utf-8?B?eXkxem1iVnJhTVREWlRXaFIzUGdiajE0OFZoZmNvTzZkdk8zTWlwL0NGTDlJ?=
 =?utf-8?B?ekRCSFNBc3N1VnlDUnR5SzV6dFIzYkJxMW03QmUwemYxdEdyeEF3Y1hBT1o5?=
 =?utf-8?B?c2ZvUjVlcmYrd3Q1S3ZMY1Z4cFhmMXFyeDJ0aklHSTJSaWM3WEFmZGpnZ2dY?=
 =?utf-8?B?RjlQSzdYU3VxUjRwSGc5d1pWYVg4YW0rYklnTjVSQjR0aEdTVzk3K0RpcHpj?=
 =?utf-8?B?Y0t3MjRPdTFpYk51SjhnMVhtZzVabHpGZkpudlRlbE5tbEVpWnpBd005dXZk?=
 =?utf-8?B?U3BIelcxeldLa2t5bVpHK1NQTlU3YnhJdTRVRkhvMnJKUGVFdzB0K1docXln?=
 =?utf-8?B?QmVJbk1pVkNTamorNENGV1B1QmYwWlMzdjkxb1QwWlRQSGxYYVlyWUl2bjhv?=
 =?utf-8?B?K1Z5WDl6UitKaFZyTkZuSWVXOEJ6VHdUbUtOWi91czVlYStrbFh6L0pTZytS?=
 =?utf-8?Q?17fVKk6fjliAdqKNZZVK2CfvOPOwZ9iE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR02MB9482.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWw1dDJoTURtSFhoYUZ4dStuUEtTVllCMStaNWN1YitIWWt3d3hSUURpc1Z4?=
 =?utf-8?B?L25ITTFTQmxDa3F5NWdZQUZQSWp2NkxZc2o1RFB6bk1HUkdoajRoc2w1a0V2?=
 =?utf-8?B?UkFkSEYreEp3SlpUZ1YvRDlVd1kvbVRUNUkzeHJqZjR1VDR2eFBpSWQzWVFR?=
 =?utf-8?B?VDhIaE44R1p4dGNsVitwOStzMSsvbU8xc3VvaktxNXQzWW8zV2JENmVmdlJD?=
 =?utf-8?B?K1FTMnc5MzByLzJZQXlaR2ttNnpoRUUrbE80dnh4Z1EvZFlEVVc1eE9iVklE?=
 =?utf-8?B?QkRNOTI3dnozVVRLQkxFK0cvSFdJTGJJejZMQ2xabnlSaHNNUGp5T0d0dlJx?=
 =?utf-8?B?TEF1dEFudk5Idk5nQS81U1pqTklpdTJENms3aTRiOHk5UTJJNUxZejFISG9n?=
 =?utf-8?B?bW5JVmxlaDBvL3NzcEJ2cy9Jb1J5NXBmdVM4MDFkYTY2aDBZaDlsbTdiMkZQ?=
 =?utf-8?B?akVhYis0K3QyUzlycitJbERpd1kxRHF0YUdscWl5VzhQS3BaNys2dnFMaGFl?=
 =?utf-8?B?aGZvOWZ6Z0ZBTkRqYXU1SXJ0SVNsNHRka1I4Vnk3U0c1Z0xHY2RodWhnaHN0?=
 =?utf-8?B?dy9wckxQekRWVVJQWkNsTGpFQkNyYlJsOTZRM2d3TitmeHhYM3hzSzhRUnBk?=
 =?utf-8?B?M0cyQ0daQlJ3cUl5c0ZnYVFJWEdnZ3FRRkR2SDhYdmtCMWJPeTRQNlluQ0xX?=
 =?utf-8?B?YzlaaGlMdFRRMlJaaU1TeXZwa2pvaDUzZzVNZVNjSkY1aVY2dmZBdFBQSzVY?=
 =?utf-8?B?UHIvZnZYTEhqVTZVYmdGZEJtcUJNQkNIUmx4K3EwQStyVTJlWURLTmlUQ1Vt?=
 =?utf-8?B?U0VtcG9yUG1xM3piVFZMWVY5NWJMcG5IQzFxSlV2ejNsTnNQSUpTS3NPeDlV?=
 =?utf-8?B?THJjaXdiNWhBUWd4RW9IejZSRjZqaWxhV2V6cDVad0cwQWo0c3Q5YTFOSDV4?=
 =?utf-8?B?ZzBZblVlekRqeE9ZYk0yWHRjeWQ0ejhhcVN2Y0hvTEI5WHdOcjhSekRNNnpq?=
 =?utf-8?B?RHVab1VZTG5NNkMwQ1hWUy9ST3A4Z3FFMTFIamxoUzlKZUtJRWEveFBuellO?=
 =?utf-8?B?N0grRVF4d3l0ekVVYjByZzRaYThCd21WS1hYRTdWdnJEVUROd1BUdXBVa1NT?=
 =?utf-8?B?SnRNTCt0N2I4OXZnUzA4SmpjQXNSQ3BjaWlPamY1Z2V6VXN2T25EYkhKZm0z?=
 =?utf-8?B?MlBUYmplc091bVN6UDBmS2kvMHRaMWRuTGFGU2RKcG1uSXUyYVJuZjB3L0FJ?=
 =?utf-8?B?dmJzM0R1MEsyWW92SWJHNTd1UDJSMUNrK0tmeEVCeFJnQTFGOGNqWkdlS3NW?=
 =?utf-8?B?S25ILzM5SlFLR05jVjVXR0ZkSlh4Y0FlQlhMUk44V3R5c3p4aGxUdG1OM0ty?=
 =?utf-8?B?YmttK2Y2Qko3cExaRHhIa1RqQjBrRU1qMTF1dG1HVGd5M2hnME5hRzlyWnVn?=
 =?utf-8?B?L0poblJhUUpLRXlCNnlpM1JUdG5VZnRwYU5ia3hobWV2V3ZtRWNpWW44eXNq?=
 =?utf-8?B?VURGUzh4enVmR2NxNk55dHFqTVYrbWg5QjhyUHBBRGllaFRrYldGajRxRDhS?=
 =?utf-8?B?QThUa0ZKMGxJeElZaEpoWUFIVUQ5NDh6TG5ZV0NHbnp1cW9lSHVhMFRaWG5w?=
 =?utf-8?B?eTRQT1pjc25YY0luYjBMZnRxSWp6dVQ0UGFaUmRHMndLZzBHZjhiZjc3czVk?=
 =?utf-8?B?ZnlBYTZBOGNYUmFGTFYzTTJrNVNTYU1OWjhWTzZqTlBBUDdIZUVnK2hQYXBL?=
 =?utf-8?B?Uk9ZWDQrYzhHTjdFQk5sSjlHbFRBb1FtM2ZtSGhybjZpclZWT2JMdjhXRWF1?=
 =?utf-8?B?UzZ2aUdJV0s4NHFJWnhaRjdGeEtUVE1vb3pPdkJWMHZsYm5BM0dKTXFlQloz?=
 =?utf-8?B?MDR3VHdaWGIvQjU4YjBKSnBHMEhVU1hnYTJ6UTZmc0t1NGVQbG9IaUhjVGI4?=
 =?utf-8?B?WVFBVXpHMU1saDZMOVdvNzNCQlRiSVNXMlNuTnc3aWR2Y2RjUjVHTGI4Sk5F?=
 =?utf-8?B?UERYSWxSRkFDYkhFT2NXb1c0N2lZZDg5Lzg3UVE2ejg5a1JCVXVraTB2VUFl?=
 =?utf-8?B?Z1ZEaVNURjBnMS9vdmtIaFF4b3FRVHBaWHV1ellWMTZ2bzFZRUsvcGJ5c3VC?=
 =?utf-8?Q?NClIV+4UA+Hio6mWgp9nA2ZWl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: f9nYS2LgjsqcK2bj7pSDu864Z76FQtRzyHOEAysF58ddzSZRRpiMp71xwqSnAz8zCcRV+PLEmxlyo8oZW/68v94+PnmbxYVcJ5dKLDZTnyWoRIZBQweV8iaUca7hPm9wda5hBkIq135EPtHuMzM26gRpu4atsK7yNEJ6+vF/dlkDryGBP1Hm6n3PgJyWiNrqFZSDcDtiSYGAfMfpU1IUYHR5S/hmnW4SlSjam8VrFWf+wstILd300FQkaYdX3VigAhuYrfKfPe9DnXg9NFaBHeYENysVrxYgca81P1FHshsKVZ0IodkXAahorx+wt/cbxj1dLRFIVAvTRs2m9Ngf5Mp+CXJmixgx4UUrQSA1MQ6Bqnh7FUwZPTUpH93zTdmuWC/G+bhkrt0WNZSftb/G9Kd86aIq7Q0nfa3tzcVKeTAWF+mSkP2h0ZEiInd88ZUhiq7b9pdbaswrTWu652kAWWfh+zTTcTefUMAP+QjUbLw8whvpuuMgf7l0VJO2JEPdvDqKCQEMRW0KxAxlI41UkkeKj0aYDSaIOjoY3I+JjtyTYGJ0/ODV4X2mPOXbE9AeDugWUxtO8Ee1NRaqIe6oaooKHelnUH89O3sArb2Ba2H9gLCZ9ZCClx7R+9PvFcK4
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR02MB9482.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d484c0d-41a8-4d6c-6fe1-08dd619be50b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 19:27:14.6823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JNKNEPHsn6HtGRCqkt6a7FLOIB00RcrP64utZKleCUAAnThgaHKf+JHtizOojzbZfDHAozMvBSIc/nwmvyq5iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6500
X-Proofpoint-GUID: wbRik6eXkWPAezpfz1SGSV7mZ_j_9J4B
X-Proofpoint-ORIG-GUID: wbRik6eXkWPAezpfz1SGSV7mZ_j_9J4B
X-Authority-Analysis: v=2.4 cv=a4ow9VSF c=1 sm=1 tr=0 ts=67d1e018 cx=c_pps
 a=uiDhKFZJcG2N7b6OoV3sKg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=avpcyE4LIbcwja4WBw0A:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=614
 clxscore=1015 spamscore=0 malwarescore=0 impostorscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120136
Received-SPF: pass client-ip=205.220.180.131; envelope-from=sidneym@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2lkIE1hbm5pbmcgPHNp
ZG5leW1AcXVpY2luYy5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMTIsIDIwMjUgMjox
MCBQTQ0KPiBUbzogbHRheWxvcnNpbXBzb25AZ21haWwuY29tOyAnQnJpYW4gQ2FpbicNCj4gPGJy
aWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzog
cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZzsgcGhpbG1kQGxpbmFyby5vcmc7IE1hdGhldXMg
QmVybmFyZGlubw0KPiAoUVVJQykgPHF1aWNfbWF0aGJlcm5AcXVpY2luYy5jb20+OyBhbGVAcmV2
Lm5nOyBhbmpvQHJldi5uZzsgTWFyY28NCj4gTGllYmVsIChRVUlDKSA8cXVpY19tbGllYmVsQHF1
aWNpbmMuY29tPjsgYWxleC5iZW5uZWVAbGluYXJvLm9yZzsgTWFyaw0KPiBCdXJ0b24gKFFVSUMp
IDxxdWljX21idXJ0b25AcXVpY2luYy5jb20+OyBCcmlhbiBDYWluDQo+IDxiY2FpbkBxdWljaW5j
LmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCAzMy8zOF0gdGFyZ2V0L2hleGFnb246IEFkZCBn
ZGIgc3VwcG9ydCBmb3Igc3lzIHJlZ3MNCj4gDQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+IEZyb206IGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbSA8bHRheWxvcnNp
bXBzb25AZ21haWwuY29tPg0KPiA+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMTIsIDIwMjUgMTE6
MjcgQU0NCj4gPiBUbzogJ0JyaWFuIENhaW4nIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+
OyBxZW11LQ0KPiBkZXZlbEBub25nbnUub3JnDQo+ID4gQ2M6IHJpY2hhcmQuaGVuZGVyc29uQGxp
bmFyby5vcmc7IHBoaWxtZEBsaW5hcm8ub3JnOyBNYXRoZXVzDQo+ID4gQmVybmFyZGlubw0KPiA+
IChRVUlDKSA8cXVpY19tYXRoYmVybkBxdWljaW5jLmNvbT47IGFsZUByZXYubmc7IGFuam9AcmV2
Lm5nOyBNYXJjbw0KPiA+IExpZWJlbCAoUVVJQykgPHF1aWNfbWxpZWJlbEBxdWljaW5jLmNvbT47
IGFsZXguYmVubmVlQGxpbmFyby5vcmc7IE1hcmsNCj4gPiBCdXJ0b24gKFFVSUMpIDxxdWljX21i
dXJ0b25AcXVpY2luYy5jb20+OyBTaWQgTWFubmluZw0KPiA+IDxzaWRuZXltQHF1aWNpbmMuY29t
PjsgQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQo+ID4gU3ViamVjdDogUkU6IFtQQVRD
SCAzMy8zOF0gdGFyZ2V0L2hleGFnb246IEFkZCBnZGIgc3VwcG9ydCBmb3Igc3lzDQo+ID4gcmVn
cw0KPiA+DQo+ID4gV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBv
ZiBRdWFsY29tbS4gUGxlYXNlIGJlDQo+ID4gd2FyeSBvZiBhbnkgbGlua3Mgb3IgYXR0YWNobWVu
dHMsIGFuZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbT4NCj4gPiA+IFNlbnQ6IEZyaWRheSwgRmVicnVhcnkgMjgsIDIwMjUgMTE6MjYgUE0N
Cj4gPiA+IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gPiA+IENjOiBicmlhbi5jYWluQG9z
cy5xdWFsY29tbS5jb207IHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc7DQo+ID4gPiBwaGls
bWRAbGluYXJvLm9yZzsgcXVpY19tYXRoYmVybkBxdWljaW5jLmNvbTsgYWxlQHJldi5uZzsNCj4g
PiBhbmpvQHJldi5uZzsNCj4gPiA+IHF1aWNfbWxpZWJlbEBxdWljaW5jLmNvbTsgbHRheWxvcnNp
bXBzb25AZ21haWwuY29tOw0KPiA+ID4gYWxleC5iZW5uZWVAbGluYXJvLm9yZzsgcXVpY19tYnVy
dG9uQHF1aWNpbmMuY29tOw0KPiA+IHNpZG5leW1AcXVpY2luYy5jb207DQo+ID4gPiBCcmlhbiBD
YWluIDxiY2FpbkBxdWljaW5jLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFtQQVRDSCAzMy8zOF0gdGFy
Z2V0L2hleGFnb246IEFkZCBnZGIgc3VwcG9ydCBmb3Igc3lzIHJlZ3MNCj4gPiA+DQo+ID4gPiBG
cm9tOiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4NCj4gPiA+DQo+ID4gPiBDby1hdXRo
b3JlZC1ieTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8NCj4gPiA8cXVpY19tYXRoYmVybkBx
dWljaW5jLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5A
b3NzLnF1YWxjb21tLmNvbT4NCj4gPg0KPiA+DQo+ID4gPiAraW50IGhleGFnb25fc3lzX2dkYl93
cml0ZV9yZWdpc3RlcihDUFVTdGF0ZSAqY3MsIHVpbnQ4X3QgKm1lbV9idWYsDQo+ID4gPiAraW50
DQo+ID4gPiArbikgew0KPiA+ID4gKyAgICBDUFVIZXhhZ29uU3RhdGUgKmVudiA9IGNwdV9lbnYo
Y3MpOw0KPiA+ID4gKw0KPiA+ID4gKyAgICBpZiAobiA8IE5VTV9TUkVHUykgew0KPiA+ID4gKyAg
ICAgICAgaGV4YWdvbl9nZGJfc3JlZ193cml0ZShlbnYsIG4sIGxkdHVsX3AobWVtX2J1ZikpOw0K
PiA+ID4gKyAgICAgICAgcmV0dXJuIHNpemVvZih0YXJnZXRfdWxvbmcpOw0KPiA+ID4gKyAgICB9
DQo+ID4gPiArICAgIG4gLT0gTlVNX1NSRUdTOw0KPiA+ID4gKw0KPiA+ID4gKyAgICBpZiAobiA8
IE5VTV9HUkVHUykgew0KPiA+ID4gKyAgICAgICAgcmV0dXJuIGVudi0+Z3JlZ1tuXSA9IGxkdHVs
X3AobWVtX2J1Zik7DQo+ID4NCj4gPiBBcmUgYWxsIG9mIHRoZXNlIHdyaXRhYmxlIGRpcmVjdGx5
IHdpdGhvdXQgYW55IGNoZWNrcz8NCj4gW1NpZCBNYW5uaW5nXQ0KPiBJIGNoZWNrZWQgdGhlIGlz
ZXQgYW5kIGFsbCBndWVzdCByZWdpc3RlcnMgaGF2ZSBSRUFEL1dSSVRFIHBlcm1pc3Npb25zLg0K
PiANCj4gPg0KPiA+ID4gKyAgICB9DQo+ID4gPiArICAgIG4gLT0gTlVNX0dSRUdTOw0KPiA+ID4g
Kw0KPiA+ID4gKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOw0KPiA+ID4gK30NCj4gPiA+ICsj
ZW5kaWYNCj4gPiA+ICBzdGF0aWMgaW50IGdkYl9nZXRfdnJlZyhDUFVIZXhhZ29uU3RhdGUgKmVu
diwgR0J5dGVBcnJheSAqbWVtX2J1ZiwNCj4gPiA+IGludA0KPiA+ID4gbikgIHsNCj4gPiA+ICAg
ICAgaW50IHRvdGFsID0gMDsNCj4gPiA+IGRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9o
ZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jDQo+ID4gPiBpbmRleCA3NmIyNDc1
ZDg4Li5mZDljYWFmZWZjIDEwMDY0NA0KPiA+ID4gLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVs
cGVyLmMNCj4gPiA+ICsrKyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jDQo+ID4gPiBAQCAt
MTQ2NSw2ICsxNDY1LDE3IEBAIHZvaWQgSEVMUEVSKHNyZWdfd3JpdGUpKENQVUhleGFnb25TdGF0
ZQ0KPiA+ICplbnYsDQo+ID4gPiB1aW50MzJfdCByZWcsIHVpbnQzMl90IHZhbCkNCj4gPiA+ICAg
ICAgc3JlZ193cml0ZShlbnYsIHJlZywgdmFsKTsNCj4gPiA+ICB9DQo+ID4gPg0KPiA+ID4gK3Zv
aWQgaGV4YWdvbl9nZGJfc3JlZ193cml0ZShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qg
cmVnLA0KPiA+ID4gK3VpbnQzMl90IHZhbCkgew0KPiA+ID4gKyAgICBCUUxfTE9DS19HVUFSRCgp
Ow0KPiA+ID4gKyAgICBzcmVnX3dyaXRlKGVudiwgcmVnLCB2YWwpOw0KPiA+ID4gKyAgICAvKg0K
PiA+ID4gKyAgICAgKiBUaGUgYWJvdmUgaXMgbmVlZGVkIHRvIHJ1biBzcGVjaWFsIGxvZ2ljIGZv
ciByZWdzIGxpa2Ugc3lzY2ZnLCBidXQgaXQNCj4gPiA+ICsgICAgICogd29uJ3Qgc2V0IHJlYWQt
b25seSBiaXRzLiBUaGlzIHdpbGw6DQo+ID4gPiArICAgICAqLw0KPiA+ID4gKyAgICBhcmNoX3Nl
dF9zeXN0ZW1fcmVnKGVudiwgcmVnLCB2YWwpOyB9DQo+ID4NCj4gPiBEb2VzIHRoZSBoYXJkd2Fy
ZSBhbGxvdyB0aGUgZGVidWdnZXIgdG8gZG8gdGhpcz8NCj4gW1NpZCBNYW5uaW5nXQ0KPiBPbiBo
YXJkd2FyZSwgaWYgd2UgYXJlIHRhbGtpbmcgYWJvdXQgVDMyLCBzb21ldGhpbmcgbGlrZSAici5z
IHN5c2NmZyAmeHh4IiBjYW4NCj4gYmUgZG9uZSwgYnV0IEkgdGhpbmsgdGhpcyB3b3VsZCBpbnZv
bHZlIGluc3RydWN0aW9uIHN0dWZmaW5nIHRvIHVwZGF0ZSB0aGUNCj4gcmVnaXN0ZXIuDQo+IElm
IHdlIGFyZSBydW5uaW5nIExpbnV4LCBzeXN0ZW0gcmVnaXN0ZXJzIHdvdWxkIG5vdCBiZSBleHBv
c2VkIGluIHRoZQ0KPiB0aHJlYWQncyBjb250ZXh0IGFuZCBJIHRoaW5rIHRoZSBkZWJ1Z2dlcidz
IGtub3dsZWRnZSB3b3VsZCBiZSBsaW1pdGVkIHRvDQo+IGp1c3QgdGhvc2UgcmVnaXN0ZXJzLg0K
PiBUaGlzIGJlaGF2aW9yIG1hdGNoZXMgdGhlIGxlZ2FjeSBzaW11bGF0b3IsIGhleGFnb24tc2lt
Lg0KPiANCj4gDQo+ID4NCj4gPiA+ICsNCj4gPiA+ICB2b2lkIEhFTFBFUihzcmVnX3dyaXRlX3Bh
aXIpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcsDQo+ID4gPiB1aW50NjRfdCB2
YWwpICB7DQo+ID4gPiAgICAgIEJRTF9MT0NLX0dVQVJEKCk7DQo+ID4gPiBAQCAtMTUwOCw2ICsx
NTE5LDExIEBAIHVpbnQzMl90DQo+IEhFTFBFUihzcmVnX3JlYWQpKENQVUhleGFnb25TdGF0ZQ0K
PiA+ID4gKmVudiwgdWludDMyX3QgcmVnKQ0KPiA+ID4gICAgICByZXR1cm4gc3JlZ19yZWFkKGVu
diwgcmVnKTsNCj4gPiA+ICB9DQo+ID4gPg0KPiA+ID4gK3VpbnQzMl90IGhleGFnb25fc3JlZ19y
ZWFkKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpIHsNCj4gPiA+ICsgICAgcmV0
dXJuIHNyZWdfcmVhZChlbnYsIHJlZyk7DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+DQo+ID4gV2h5
IG5vdCBqdXN0IHVzZSBzcmVnX3JlYWQ/DQo+IFtTaWQgTWFubmluZ10NCj4gVGhlIHVzYWdlIG9m
IHRoaXMgaXMgaW4gZ2Ric3R1Yi5jIGFuZCBJIGRvbid0IHRoaW5rIHRoZSBleHRyYSBsYXllciBp
cyBuZWVkZWQgc28NCj4gaXQgY2FuIGJlIHJlbW92ZWQgYW5kIHRoZSBzdHViIHVwZGF0ZWQuDQpb
U2lkIE1hbm5pbmddIA0KT0sgdGhlcmUgaXMgYSByZWFzb24gdGhpcyBpcyBsaWtlIHRoaXMsIHNy
ZWdfcmVhZCBpcyBkZWNsYXJlZCBzdGF0aWNhbGx5IGFib3ZlIGFuZCBpcyBub3QgYXZhaWxhYmxl
IHRvIHRoZSBkZWJ1ZyBzdHViLg0KDQo+IA0KPiA+DQoNCg==

