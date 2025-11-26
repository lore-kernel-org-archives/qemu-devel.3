Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D789FD1118E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 18:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOK2m-0002lm-3O; Wed, 26 Nov 2025 13:15:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vOK2Z-0002iQ-9i
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 13:14:55 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vOK2W-0005jB-JU
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 13:14:54 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AQErHPV1609275; Wed, 26 Nov 2025 10:14:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=hk2XAj55kT8FqklgHM6N2ajmaK1siwUMGHkqo8Zon
 TE=; b=lwnQ59htQEGyvjFc7OkSOiwl/EliCrH8hYeJrDK1BqtlO/AsJF2Dz3nD/
 Ru4Wa1u9Sm0V7tOcDTIio60DvMcupsnrmfsFXWBiwUpmpGTeq7UOlBdu9XpCCI1U
 CpEw0l1K8D0ewdmUXr5+/wkXfDz5/OHQ9bivJTo4fUqLvH5GyA8Tld5C5jBFdyX1
 fWrYM7ieHYXwb2nWup/XkJwG4iMHyMOK2ALT6rfhWaJiRH+1AvXev9LFjSt1LlpT
 pMC80JRjzn8babGxteAos90XO7JKcybuqXfypBlYb8dsEi5LbMEGBnyi0RXZe3HL
 OtU+3unt4nROxNjSbusHHVIxrYIAw==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020102.outbound.protection.outlook.com
 [52.101.193.102])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ap3q2gdhy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 26 Nov 2025 10:14:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIKoLkvn8gpewP5rad2PTwFCUpEECI+WXjXG+icR4+ACQrFa91G8HCtFSzASqZory647T5wmgjGP4GJZBqb7KNX+riwC0ZtnWC3GPYyh2qOfz15zzcWW1PKceYqEDkdkv/EkqkpqLuNeGOEqiwPxE+NB1/fCbMal5Pi3oiHrTnL4crWPyyIEkxrEmLZdJiixRv483wOJ9zAofe1OWFgLu7r2pN9iw4WiFYOwNF2Lt6WJNZTNs9x2Z36HThAN+zlGYPwGKS5vwuz5/WN4oreZoRJcXvN/T0x8zdyInw42LlQiFsen6QVFLTcKKezw0IX7V6QktQ5s99QTKfwfvZki4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hk2XAj55kT8FqklgHM6N2ajmaK1siwUMGHkqo8ZonTE=;
 b=dtshQwD7ua7MKcf492HeYt43laJ7NzWTR1JRaYZd1qpeR8Gnbe/TWZnLK0sDMuIFGNJEOg4dMkrxNyoAFfEMZ610egEBDyZelnQp0FWv2JqHPKtGXyATpHVXlzlI77jYZtoW6qGNclknW0cBn2RvCQqUs/ZFdBPov08u1rRYneHNKRDUgYal6SykNmvOhAHPIMjY0eEHile/sKTAhWI7K9zaGbRSzFUzMztVaPjEkCZEpgkqUu3O5DqpeLoIt92ldldS41zTkoLkIUJkFGBEt/gtphqGg5izqhuprL5BbC2uHnkfNYqs0WfEms1Wj4nTHeWJ698N2h7qYtE74vFjCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hk2XAj55kT8FqklgHM6N2ajmaK1siwUMGHkqo8ZonTE=;
 b=kZbyPFr5BH7Y28+l7sti3kL1ZRbndpaCYOZl428cPUhrNTaBnz59iMTyOILCzrsPqmAKsU8yyRzXoffWN01Tn5xrOxTa2weVm70GYzQUqjYbtmwKeV3ZrUjvS3V70CEr2hciXHESnkdYDH6lyS+7HnIb9IKXcCMafB6wIlP/X/ZHIZfr2BFzXOPw6HO7aFv7yynRfVaRQ5ZfIyjUjXTHN3EjKzOe1C6/48R3sAkAhYVy9wzMYbd7HuJcbkF1jt2L55ejqJHn3FRTKBP8A/MvNKS+yEBu7sv4PjLM+Em02ihV2XL2eD4yvGn3IbmdkJZMHy8squ5umb+4Z5V80Pw+1Q==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by MW4PR02MB7361.namprd02.prod.outlook.com
 (2603:10b6:303:7f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Wed, 26 Nov
 2025 18:14:43 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 18:14:43 +0000
From: Jon Kohler <jon@nutanix.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] util/oslib-posix: increase memprealloc thread count to
 32
Thread-Topic: [PATCH v2] util/oslib-posix: increase memprealloc thread count
 to 32
Thread-Index: AQHcTzUXkYZstMSMGU+AFq1nGDZ0kLTlzKwAgB+V8AA=
Date: Wed, 26 Nov 2025 18:14:43 +0000
Message-ID: <FA4A9CAA-F033-4F1A-8197-799913A65DDA@nutanix.com>
References: <20251106163143.4185468-1-jon@nutanix.com>
 <aQzEjov7dGPQeR3f@redhat.com>
In-Reply-To: <aQzEjov7dGPQeR3f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|MW4PR02MB7361:EE_
x-ms-office365-filtering-correlation-id: d1605f2e-5f07-41c1-9973-08de2d17ac76
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?bis1aU1vYXN5aTlaYldIWHZJQWRjUmtZRE1sVjlEb3kzK1p0aDRhbDNNMUN2?=
 =?utf-8?B?NWFxSW8wTTRRcEtlcVl5aWNCOERkamdiS1VmUjhsMjc5QmZTYlZzWlZ0RHJR?=
 =?utf-8?B?QWZmSGtYL2g5KzRXSzY0RVRvZ3lBSzh6amFGcnZtSWpyZy85SXliQ0dTNnFM?=
 =?utf-8?B?SUZaenZDZmNhV0tHcWs2aE9LRmkraWdGRGNlcGJMVGpqaU1wVVJYOG9RTDk3?=
 =?utf-8?B?eTE4NDZ1MTZWQUNIcThmcTFoVHlzT1BwcjNDNmF6UXdUVHhHSldSYkRxTTl2?=
 =?utf-8?B?TGIycXNrUUJ1a2xieThUUmo0K3dKdXVzbU1NUlA4SFVEQnlrbTUxWUtDamhN?=
 =?utf-8?B?WWNadmpmZ001VHNuS0djWDVEaUFkK0lNUFJoU1BaVkpVcWpJVUU5Wk9PQ2hW?=
 =?utf-8?B?djJKZkpHS0Z5MUJYNnlNVzJrK3hsVUYwL0wwWTZoV2kyUkl5Z2F5OEQ4V3Rh?=
 =?utf-8?B?cG5tb2ExcVlDeGYxSGJBSlBzdThsdzN0Qmw2NEFGaU5uZThxSnpSY3E0Tlp4?=
 =?utf-8?B?Zi82Z0JadjlyaEVFalBYMW5Bd1NwaHo5Mis0Y2xkcTBMWVRZSFRNbCtrUEEw?=
 =?utf-8?B?T3FSQWVsNlk3MjZYSXdWOXFZdFlvT2xSTjd1ZVk2VFY0azErRkM4VHlDeWt1?=
 =?utf-8?B?bkNRdWxlV2pibFlJcEFrNDh1dCt5VzNGSFIwdDMyRU9BQW5ZajhzTVVMbmZx?=
 =?utf-8?B?S09xMkRNK3BQeFBwRlJKZUF1TXZSR2JSYlhlMjZxbE1WeDlFSzVSU3Y4d0d1?=
 =?utf-8?B?Y3QzM05oT015SjhrQ2o1Wi9KY3BSaC9Hd2oycVpYRkdrc3hIb0luS1VVOVU0?=
 =?utf-8?B?QzBIT1djY3VFYzJnM3NabVlvcTVRMXBFenllNDNiQWpMREQ1dXlHTWJzUTA5?=
 =?utf-8?B?T0ZTYkR3MTVMU3l5SGJuV1JxeDBIc3BxajFKU0VVa0N6a2FzQU1YSjBwa2Vn?=
 =?utf-8?B?VjVkRTZnL1ZYK3QvMEpvNVRMeE9ER1l1WlkrRHJMQ25GVHYyaUxaT1JNQmNE?=
 =?utf-8?B?WWo1MGx4Skw5VlM1VWpTVXh0WjFjMVFMMHVTUm01WUhFVzFFN0loUXZuV0c5?=
 =?utf-8?B?Y2VjUDdKTTFIamRmdjBTL0tzcFNTc04xcGluRmdja0E5RnQrVGhvTXpIZ3Yy?=
 =?utf-8?B?MzBVblc4SnFlUkYvdmc5UmpzVE91QnUvOTVwT1UxbmNFRTlJWW9UYTJyNFg1?=
 =?utf-8?B?djh1UnAvQWRPSExCa1RBaFlhRDZBOC82UXZJSktzN1VaUDRqZzZQQ0hCKzRF?=
 =?utf-8?B?NTUrL3Q5aTJIQXlFTnpsUWZnSkhiY0ZEMDdlbDJ3RmNzNU1qdHR0ZXE1VHFF?=
 =?utf-8?B?ZDZxZVUyUENIVFAvSVc1bTlOM2tDd3VOSVNQUkpTQ3FuNnNaVmc2T3hTMDJC?=
 =?utf-8?B?MHA2SGt1MDVKUHdxYVNIV044ZzEvbmZoNzZPTjlwTHpoaXIrMVV6TXJ1clBE?=
 =?utf-8?B?RERMc3BweExCSDM0b0pGQnh5RjgvK2hiV2s2L25sbjlCaHZIZmd5ZDk3UkNL?=
 =?utf-8?B?N0NTWlpLM3FlcVZ0dDFTd2VjUi9RQmNaaTg4alRnb1FNQVVjMVlrYjFrdXZZ?=
 =?utf-8?B?dFhBOW9NdnZJWU5BVmZoVHI4RVFkdS9lNkx4ZVlEMlprMTZVbDE2dEVDTlZy?=
 =?utf-8?B?aGg1cGpBTjFhbXpXZW1nZGtTNUVjNVh6cUxZMVRjeTN2ODd2U3djUXdRVWF5?=
 =?utf-8?B?MzBaZXB3bTMwZnMrQ3NROHZZajJxS1dFdHJ0N1FhN2VRN0p1TDhZTlYwWWg5?=
 =?utf-8?B?Z094VTRuTVViWElnSDlQcy85ZUFUUDd4Q3U0U21KU3FML09pK09UMmp2YVJX?=
 =?utf-8?B?MlI0RmQwSnFDYXdZcG8zMFRNdFVJVHZJelh2dEc0TjFtWGlCSTJDZlVxZTRV?=
 =?utf-8?B?aExaeXRNdWx3RjBhNDA4Rkl1cTVCMW9Da3ZsaHdWaG9oZUpxVW4wZVJkZ2Na?=
 =?utf-8?B?MDlIQW9pL1poSWlvVTRBVWYwa05GcFdsZkZmRFMvdW9rSzRqdnBFS0hoTHRG?=
 =?utf-8?B?RFYwWjRZYWF0aEdPK3JFL1I1U255ODFxY2srZ2VOeGFxYTBTdU1KWVZJTUhH?=
 =?utf-8?Q?g08URf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV0PR02MB11133.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmpGNjlHMmVYU01iUk04VkRXQ1l2SjNzeTQwYTFBYjZ0R29XSXR1eTVHODU4?=
 =?utf-8?B?UnpOWGNrZlArNmVVQUhnV3QzU2hqaEkvbldxSkpsaVFvdWcrRGNuUzVtaWVT?=
 =?utf-8?B?alFDV0ZiMUhKTzhUcFFmSmRKNS9Pa3NHeWRROVVtbGc0cmJTN0JTKzJ0akN4?=
 =?utf-8?B?Qmk2ckp0Yy9jTTl4SXQ5YTBwUzd1SWk2OGVGVisyTlRHMmJrbFl6RWFqSG5m?=
 =?utf-8?B?Ly84K3diekU5Ym1kYTJ5Y2IrTGcxdXQ1ZERYakFnVWI4N2NYWkV0NzB0bVRN?=
 =?utf-8?B?TFlpNlZSL2pSSnd6MHhYM1U3NUtJeHNiUW5TT3ZZcGRqcHY3ZkxPbWViODNh?=
 =?utf-8?B?V3RUL3dPNWpWdGVONUU4UTdnYmJRRnhTQ2ZoSG9GM2taanprb2JKeVRaLytn?=
 =?utf-8?B?bTJmOE82bStrL29pSW9sM2V2NC9UWnhBM1MyT05KNGM2QnJ2VURQM1ZDOWsv?=
 =?utf-8?B?a20rNHJ6b1VLcDZCU3ltZG5TUk56NlVTdUxVdG9ueXo5NFlxVDN1MXJIdnQw?=
 =?utf-8?B?eGJ6TWI5RWtrV2pmdEx3VW1CYU1FYnlTWjVlZzh6ZVJ4SmZDeHloYnkxN0hE?=
 =?utf-8?B?WlY3ZEZYUGljME5EOWR5OFRYVXlqM21tbUlTZ21sai9lTXVtenpLNGwvY0Z2?=
 =?utf-8?B?TXQwOFFQemtML1ZYWDJKRlRqMzBOYVV6TmJmWUVpZmF3Tzl6UFpwTlZXSFRi?=
 =?utf-8?B?WHFENS9UT2Q0cndlSms2VkxhMSttb1pYN0NleDkwYXhBZTRhY3E4ZG1QaDB0?=
 =?utf-8?B?ay9HSDBZSWk3YUo4TXVya00yYjhjQVpmNDJya0hwb0ZiSk9CTTJsRHIwNTlR?=
 =?utf-8?B?eTJjSGdzUWtBNjNYV3NoOXJFamlNTmxSU1lrMzIzUGZRNTI0WGFVWDhoeno1?=
 =?utf-8?B?L0t6N2hUdzRYeE5iNW53dzFkNk5kdFVhdGhUZWx1QkdJWksyNjBIUUxMNjFj?=
 =?utf-8?B?eGF0L2xkNXhMcllWMDhMb2ZNcXlkL1JqZktHVy8vRW1odGszUU10WXkwTGI1?=
 =?utf-8?B?ZWxHQ3c1THlIcHpEaGxVUDNiOFJHMDd1bDFFclJ1TWViSVpTRHhCKzBScHcy?=
 =?utf-8?B?eUk0anJndXJ5RWZVYVA5dWJrSmZsQUtYcFhhMkd5eTJoWlJOTVd5TnlMRVFk?=
 =?utf-8?B?QmlkN0c0Q1dUS1FjRWlJUHBRTkFoVTd6U2NiZDV4ZmZzKzZ1Rzh1ZjRkZ0lZ?=
 =?utf-8?B?UlZWZUw2L1F1QytHRFhjSm44eldTelcyaXhNZ0MrN3JwUkVDMW9aZU5DRG9W?=
 =?utf-8?B?UW5veGN5LzZFUEZlWFV3RGhDOU11UGpYRTNCZGJYTHljdmVpdE4rNHNnaVFu?=
 =?utf-8?B?d1o1UkNXQlpBN1V0allTaXZXeHJiUkJLNXFrcDJIZ0FEZnhrVkpSTDE5SmNI?=
 =?utf-8?B?cTdocTljR2huTUVsRmtXVlVHcHErU0NvMnNIeXlGbHFwVkU3VDVUeDVHcW9V?=
 =?utf-8?B?TzF0bUtsb2NPNXltQUFRUElVdFluYjRWakFzY1liV1NVaHhGVTNMeGNpV09w?=
 =?utf-8?B?ZnhidFNHeUNpWHJwR3lMQ3FWaVczNkF2WC9nR1prRUlPUUFwcTgxT1pLbzE1?=
 =?utf-8?B?REs5a0lmaHJNRWs4end0eUZSTi8xbXl5L2x0U2JKZlNTcnpIZG82NHI4QW55?=
 =?utf-8?B?aTVMMk9rMUpYZ0NMR3hmNFhtT3dTSFBienp6ZDMrd2JpSGRpVmk4YWZlNGo1?=
 =?utf-8?B?cWwvbXJHakN6d0FPc1EydDFqNUxnT240MFhJcERhdFdiNHBjWW5ldHhKZDRy?=
 =?utf-8?B?V3pTSzVWRXJuZ2lMVGQyMktEQlhqaWF5TTcvVmNtNTdQV0JMazJidi9pY0Zu?=
 =?utf-8?B?SlFnNWw5Z2JEc1RQc01nOXFWU3I4Wjd4UVNtRjBXd1hHK1Y1bWd4SU8zVE5j?=
 =?utf-8?B?S2tyNVg5MmZ4d2ZFRFExSGc4YVMrNXNQMDQ3a0ZPakp1UUNPUnJKVmxMcVhx?=
 =?utf-8?B?YVJVTVR0T3FNQnF1dlR4L1dESmVqdzdlRXNtclNjanZZWWN2a1Vhd0NBVWQv?=
 =?utf-8?B?RElLZkFvb0kxUlF1S2lKOWd6M2Q3U0toWW1MOHZ3ZUEyRWkwRzQzZkcxRElQ?=
 =?utf-8?B?MWZkQTI0SWJwSUpmc1MwMlY2SWFBRUN6T2MvZ3J1cWdaaXRCK2JmRHNWWU81?=
 =?utf-8?B?cEkyNVFiY2wxVXl6U0ZYUmtkakNuUHEzd0NFOXpxT1JUQXMxUHFRTk9pZkpx?=
 =?utf-8?B?UmZ1M2hNS1l1UE9xRGgybEsvQzlsSzNPdmJ1clhOMFA2bFdBQWxvQnFVV01W?=
 =?utf-8?B?dnVEQVJPUWFMRmRkMHpaendkZ2V3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EC52C4FE7C05949ABD013C4232ADCB9@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1605f2e-5f07-41c1-9973-08de2d17ac76
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 18:14:43.3882 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zR0KXmHRpTaBPtSvBXwTLCeQ0YwLI9XgVMxEXbIA8AX8KPJeICoQaEzbzBtO3cFO9+5P3vw5E+mDnPf5REbY2KgFIPA+fUF0Fn0MvBMYcoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7361
X-Proofpoint-ORIG-GUID: zJwavzqPxCfTbfLFmlC7K8sx_GETlDPn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDE0OSBTYWx0ZWRfXx1WfdZb8gMx4
 GT38HQSoZGsxHvp+IvNPdNXvjAg6/d9C+vmaQFq2+hr021GFJnINUNmH6Pc5Ggc8d1QOSbYbK1D
 5nuKgsCxMVAIrggZRhhFxqkh2oAgjvw5JMftyEiOFA26/RQyOOqdgd2wdYrjkn5z4K3ucpDioWw
 MzutAi8oX7Z9/7D0u9cpUvX4x2a6p8+9uorv2PunNErloWBzGHabHoLNnKmK8VLDnWGXZEcifOS
 fLc/fwOZj/sKa/Kisiuy7zen656A9OFWIdYeAfoUL6nJKBPsAW5yYqUYoHuN3weBDucZSmSSm0f
 IWKfdmHGuofGaa2/rZNRJPPOBrAfraKqsJlfTdSe6+pQBOUQ9G03fiPlrIdH6mxEr640hMY3Ne6
 XuEL71PNDkdapTDt2/vvxF0FQZDGog==
X-Proofpoint-GUID: zJwavzqPxCfTbfLFmlC7K8sx_GETlDPn
X-Authority-Analysis: v=2.4 cv=aoW/yCZV c=1 sm=1 tr=0 ts=69274398 cx=c_pps
 a=QPz/VTDDR5gZk8CLCCaaQA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=ECR9eKQDrwT5StKk0V8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=jon@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

DQoNCj4gT24gTm92IDYsIDIwMjUsIGF0IDEwOjUz4oCvQU0sIERhbmllbCBQLiBCZXJyYW5nw6kg
PGJlcnJhbmdlQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBOb3YgMDYsIDIwMjUg
YXQgMDk6MzE6NDNBTSAtMDcwMCwgSm9uIEtvaGxlciB3cm90ZToNCj4+IEluY3JlYXNlIE1BWF9N
RU1fUFJFQUxMT0NfVEhSRUFEX0NPVU5UIGZyb20gMTYgdG8gMzIuIFRoaXMgd2FzIGxhc3QNCj4+
IHRvdWNoZWQgaW4gMjAxNyBbMV0gYW5kLCBzaW5jZSB0aGVuLCBwaHlzaWNhbCBtYWNoaW5lIHNp
emVzIGFuZCBWTXMNCj4+IHRoZXJlaW4gaGF2ZSBjb250aW51ZSB0byBnZXQgZXZlbiBiaWdnZXIs
IGJvdGggb24gYXZlcmFnZSBhbmQgb24gdGhlDQo+PiBleHRyZW1lcy4NCj4+IA0KPj4gRm9yIHZl
cnkgbGFyZ2UgVk1zLCB1c2luZyAxNiB0aHJlYWRzIHRvIHByZWFsbG9jYXRlIG1lbW9yeSBjYW4g
YmUgYQ0KPj4gbm9uLXRyaXZpYWwgYm90dGxlbmVjayBkdXJpbmcgVk0gc3RhcnQtdXAgYW5kIG1p
Z3JhdGlvbi4gSW5jcmVhc2luZw0KPj4gdGhpcyBsaW1pdCB0byAzMiB0aHJlYWRzIHJlZHVjZXMg
dGhlIHRpbWUgdGFrZW4gZm9yIHRoZXNlIG9wZXJhdGlvbnMuDQo+PiANCj4+IFRlc3QgcmVzdWx0
cyBmcm9tIHF1YWQgc29ja2V0IEludGVsIDg0OTBIICg0eCA2MCBjb3Jlcykgc2hvdyBhIGZhaXJs
eQ0KPj4gbGluZWFyIGdhaW4gb2YgNTAlIHdpdGggdGhlIDJ4IHRocmVhZCBjb3VudCBpbmNyZWFz
ZS4NCj4+IA0KPj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+PiBJZGxlIEd1ZXN0IHcvIDJNIEh1Z2VQYWdlcyAgIHwgU3RhcnQtdXAgdGltZQ0KPj4gLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAyNDAgdkNQVSwg
Ny41VEIgKDE2IHRocmVhZHMpIHwgMm00MS45NTVzDQo+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+IDI0MCB2Q1BVLCA3LjVUQiAoMzIgdGhyZWFkcykg
fCAxbTE5LjQwNHMNCj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPj4gDQo+PiBOb3RlOiBHb2luZyBhYm92ZSAzMiB0aHJlYWRzIGFwcGVhcnMgdG8gaGF2
ZSBkaW1pbmlzaGluZyByZXR1cm5zIGF0DQo+PiB0aGUgcG9pbnQgd2hlcmUgdGhlIG1lbW9yeSBi
YW5kd2lkdGggYW5kIGNvbnRleHQgc3dpdGNoaW5nIGNvc3RzDQo+PiBhcHBlYXIgdG8gYmUgYSBs
aW1pdGluZyBmYWN0b3IgdG8gbGluZWFyIHNjYWxpbmcuIEZvciBwb3N0ZXJpdHksIG9uDQo+PiB0
aGUgc2FtZSBzeXN0ZW0gYXMgYWJvdmU6DQo+PiAtIDMyIHRocmVhZHM6IDFtMTlzDQo+PiAtIDQ4
IHRocmVhZHM6IDFtNHMNCj4+IC0gNjQgdGhyZWFkczogNTlzDQo+PiAtIDI0MCB0aHJlYWRzOiA1
MHMNCj4+IA0KPj4gQWRkaXRpb25hbCB0aHJlYWQgY291bnRzIGFsc28gZ2V0IGxlc3MgaW50ZXJl
c3RpbmcgYXMgdGhlIGFtb3VudCBvZg0KPj4gbWVtb3J5IGlzIHRvIGJlIHByZWFsbG9jYXRlZCBp
cyBzbWFsbGVyLiBQdXR0aW5nIHRoYXQgYWxsIHRvZ2V0aGVyLA0KPj4gMzIgdGhyZWFkcyBhcHBl
YXJzIHRvIGJlIGEgc2FuZSBudW1iZXIgd2l0aCBhIHNvbGlkIHNwZWVkdXAgb24gZmFpcmx5DQo+
PiBtb2Rlcm4gaGFyZHdhcmUuIFRvIGdvIGZhc3Rlciwgd2UnZCBlaXRoZXIgbmVlZCB0byBpbXBy
b3ZlIHRoZSBoYXJkd2FyZQ0KPj4gKENQVS9tZW1vcnkpIGl0c2VsZiBvciBpbXByb3ZlIGNsZWFy
X3BhZ2VzXyooKSBvbiB0aGUga2VybmVsIHNpZGUgdG8NCj4+IGJlIG1vcmUgZWZmaWNpZW50Lg0K
Pj4gDQo+PiBbMV0gMWUzNTZmYzE0YmVhICgibWVtLXByZWFsbG9jOiByZWR1Y2UgbGFyZ2UgZ3Vl
c3Qgc3RhcnQtdXAgYW5kIG1pZ3JhdGlvbiB0aW1lLiIpDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6
IEpvbiBLb2hsZXIgPGpvbkBudXRhbml4LmNvbT4NCj4+IC0tLQ0KPj4gdXRpbC9vc2xpYi1wb3Np
eC5jIHwgMiArLQ0KPj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQo+IA0KPiBSZXZpZXdlZC1ieTogRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVk
aGF0LmNvbT4NCg0KVGhhbmtzLCBEYW5pZWwgIQ0KDQpJcyB0aGVyZSBhbnl0aGluZyBlbHNlIHdl
IG5lZWQgb24gdGhpcyBvbmU/IFdhbnQgdG8NCm1ha2Ugc3VyZSBpdCBkb2VzbuKAmXQgZ2V0IGxv
c3QuDQoNCj4gDQo+PiANCj4+IGRpZmYgLS1naXQgYS91dGlsL29zbGliLXBvc2l4LmMgYi91dGls
L29zbGliLXBvc2l4LmMNCj4+IGluZGV4IDNjMTRiNzI2NjUuLmRjMDAxZGE2NmQgMTAwNjQ0DQo+
PiAtLS0gYS91dGlsL29zbGliLXBvc2l4LmMNCj4+ICsrKyBiL3V0aWwvb3NsaWItcG9zaXguYw0K
Pj4gQEAgLTYxLDcgKzYxLDcgQEANCj4+ICNpbmNsdWRlICJxZW11L21lbWFsaWduLmgiDQo+PiAj
aW5jbHVkZSAicWVtdS9tbWFwLWFsbG9jLmgiDQo+PiANCj4+IC0jZGVmaW5lIE1BWF9NRU1fUFJF
QUxMT0NfVEhSRUFEX0NPVU5UIDE2DQo+PiArI2RlZmluZSBNQVhfTUVNX1BSRUFMTE9DX1RIUkVB
RF9DT1VOVCAzMg0KPj4gDQo+PiBzdHJ1Y3QgTWVtc2V0VGhyZWFkOw0KPj4gDQo+PiAtLSANCj4+
IDIuNDMuMA0KDQo=

