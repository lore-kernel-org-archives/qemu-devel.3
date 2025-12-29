Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F7CE92733
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 16:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaFzO-0004Ui-Sd; Mon, 29 Dec 2025 11:20:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1vaFzG-0004Tl-M2; Mon, 29 Dec 2025 11:20:50 -0500
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1vaFzD-0005xO-E2; Mon, 29 Dec 2025 11:20:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRLKMTSnghV/ZUDrLp3GB+4LJFecLZ+UReB8mtojeGSNgFCYIww3SflVgMb0r3Y+AJKqs4HeyeViL0SnX3sJUOAQb7bjAocSV2CMsJ3LoCGH8OK7FNh5L0emA8B7cSeADuz9vxOnGrIh4/FYVD2N+ZVaCcn6bzHkh1by842orF8l2Jq1+Z6+zofOA0iTpbf6+XsiqHmQz4Hn9IpEyYqbHjM320nVzQIDRk+VPilQi87oYnTnotphzUZfyevJtUVIK9sdYE0k+X/I5JtrGTagqd9XsL9wgIOjTbfeCq6KrwgiZMsqIClGGyEAjD/1ExyIoj4QlnOu0QIG2txGUrZg/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83039AKx79x76lsygZsPODJ+3ut8Fy6NcBg8W8h4EyE=;
 b=JzClBW6l7ZhUf6eSLWGO13jM0G6sPqDUKt16v+ta71lqVHy2iVG7k5KeO5dZFJWbL8sIebksvn4BASbWAIKuyRJ7jy9/EMcOwGmY///G7NS0LQLOq5OD3sybllctOYiEe1bj/U2+MAAzkSwGFtgn0xrVMtQcsXCmEHlO/92Hp/jTB0tJGy0mBGo0IQ6k5Tud3fi5qzyvZqIcLkH6ySdDXskDfd0me2cVEYgllYEwFmOXbVkrt78s0xWDV+z8hXIw4gzt9JbMpvzMbV+jMuAe4o3AN8qi9cC7dP8Gx/1dYvAvyHV+eT84L20lWxLQRBn2XgLfteBIL7xU7w9L+8Xrlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83039AKx79x76lsygZsPODJ+3ut8Fy6NcBg8W8h4EyE=;
 b=AW29HJc6nmGDsSrxaB2JIIixLD7+6xlGaw3oDuq3EqVxjE23trKnZnOX//AerH0loWqiB2b49QIBLhu7HVnwx54HyPgpORIFd22cKRb8sYB/jxKWB6BFHzjONbMzpObWLqaNM2eXpz9qxd8JRdnysCSGS0I7iy+DeSrjvdwhly2Aei8DOaP26cywtCnvKOW/0i1tyyG1ejVMjSSIEHY58MnuxWx4ixejFL1jmW0ECHLO7qP/h3iYozt7+0FeRgywe3rIlnc4NZGn03jtyEbpcBCeXlWAelYT2gSbmSybMaZDoLDCjOgW6LJ7isLBynME6X0UJzE17IMY34MeYIyj6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DU5PR08MB10850.eurprd08.prod.outlook.com (2603:10a6:10:522::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 16:20:42 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%7]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 16:20:42 +0000
Message-ID: <b01db5f7-38fb-4732-84aa-ca7317660e59@virtuozzo.com>
Date: Mon, 29 Dec 2025 17:20:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] qcow2: add very final sync on QCOW2 image closing -
 BDRV_REQ_FUA processing is broken
From: "Denis V. Lunev" <den@virtuozzo.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
References: <20251219180813.1000884-1-den@openvz.org>
 <62286d8a-eb8b-4753-984e-1e294d96529b@virtuozzo.com>
 <e3003fb4-e18f-4181-a00f-b8901a8c0f76@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <e3003fb4-e18f-4181-a00f-b8901a8c0f76@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0162.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::19) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DU5PR08MB10850:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e59c47-b7c6-4f1a-26f5-08de46f63689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkRwQWRzYmZ6dVk3bnh6QmlYazNteUJRUDd4bSs0aW9TZDloSmc2R0JzMUU1?=
 =?utf-8?B?bDNXWTMxNnUxcHNoa09Hb0FKaFJ3UmUwVExFUUU0MWM0L0h0THoydGhJamRz?=
 =?utf-8?B?UzVOeU94WE5nMzNtREREbVQzcWFUdmVnYmx0ZTdpaVNNVVJnWlJmWVVyVFFu?=
 =?utf-8?B?dUxKazBPRjI4bnN1Z0hSMlNQWmxTc1l3QmlLMnNXOXpWbFp5WElOMmRFMllm?=
 =?utf-8?B?OFRoaDlINHhKaGsyWk5iL0JsSWNrQTVvQ0ZPcjEwWm5qWmZUa1dGeWsvSjdv?=
 =?utf-8?B?MUljOVRkYUIzN0lqdTd0YTlSY04wYTB0N3M0d2JoUExqVTU4NTlWNjVIb0dr?=
 =?utf-8?B?WlJYU1Z3SDFNN3ZDNXFXc0dkak1aNk5OY2JPemdKYlRBa01DMlkwcDVXVlli?=
 =?utf-8?B?SExLdGtqM0tkQWVNQzR0YVdjamtybVVwTmd5RE82YVVDSkh6QUZoZ0hpVTR0?=
 =?utf-8?B?Y0pNcGpUWkc2bWdNUTBHaUIyOVhKZTFXdjRRVVNuakRnWVB4K2NPOXVlU2FJ?=
 =?utf-8?B?UXR3VFNtdkprYlZGNHc3QnQ5V3NlMmJza0VvU081bGVaZkFmTWhHL0pwMzUz?=
 =?utf-8?B?bTV5OXFBdERqNVh0dHZoSFFDSnlsc05nNVp5MzJYeDdEbFE1VnZyd09CYTB6?=
 =?utf-8?B?WHBXN1NUT2ZNckdsUHZ3enB0WEZWVkJXUFIwWVJuL2N3cWhjN05WYTBaS3pZ?=
 =?utf-8?B?N1NLTkRSWCswRGFTRmZsSnhYU2xQZ3dXdGxXNlB5TlJGaVZHMlV0TWFrcWxv?=
 =?utf-8?B?TmdUZ2ZzYzc3YU5Dck8yZnNTK0VpSEpGT0Y0b3J2U044OG1Jdm5PS2h1MHpB?=
 =?utf-8?B?NnN1cEp6RmYzeEtaOXNCSVd4enBhanU2K3dxRU1aQzVyeVpXa1JRNkZXV0tk?=
 =?utf-8?B?TlhqWVZJZm1oWW15b2liU01nNmovZWNmU0h4K2k1VThIRVBDdjVTMk15UEZR?=
 =?utf-8?B?OElKWGlmUGozaC9jSmRueG9UdkwrakJiRnVQSzlGQkljaUZ2b1hyL284MDlk?=
 =?utf-8?B?U2RKcWUzSHI2V1lQUVcxWi9CUzR6cm5kRDAyR3Zyc0FNTmFXazg2c0hudWIz?=
 =?utf-8?B?UWNnZEVtWFRTN2VqeWRDNnMvaWcwejliNXl1SFRSZ3hKOThGQWZmMlhtRjV0?=
 =?utf-8?B?bEtRRFlrYXAreFVQQXBMeStwSUJabUU5NlZzMEtVNjZMUnFQTk01RUttcGtm?=
 =?utf-8?B?Z0FnR0UxcjRudTJXK0Z1RnBXRlVscTZEb1dBdDZKM1BzVnJkV3lBQTErdTV6?=
 =?utf-8?B?bEoxbEI4WmtuV1YxWks4MmxKY0tabC8ybUdoRHhERDR3anA4dXZEbjdvZGEx?=
 =?utf-8?B?ZysrQ0txRm5yd3BwM01YdHBWTUpCTGIwdjZmVGdOeVJVcG00QnlMQndrUFRE?=
 =?utf-8?B?enNwTk15WEtFajNhQ0cyS2prSlpYSkpkOVJlWWVHWW0vOENrWHpaQ3hyNGhq?=
 =?utf-8?B?SnJJQWdTZ3VvVmFLN045QWRkVzRhMWZKcjJqREZQRjZIemlWbnlxMkp4cVQz?=
 =?utf-8?B?UzVKdEM5OVpoU3pSZkJWbWMyZUQwd2NCTVdFc3oyckF0NW5xN1krdGNocWxr?=
 =?utf-8?B?UlZuMEpHQlgyVkdKa3d2NHM4eTZyc3AyckRHc3IrT3hXZGI5aG1jK0pHM2JB?=
 =?utf-8?B?MXJ1Z1AxN25XTTZGVHhSN0dwN3drY1J3VWVsVEhEZXNKNk16RzR4NzBKTnor?=
 =?utf-8?B?RmJVSlZtdXF1RjVUNTJ1eWY4N2lOS29IWTU4V2l1YXcrS0tybGFJY082ZTN3?=
 =?utf-8?B?V3N3bGRZNzlpU1RjMkVMNSswMmNnM2YvOUZ0blJ3THBwSGlFWC85M3NtUjNp?=
 =?utf-8?B?TTI5TFNUSnphZWpzYUxXQ1ZvWUtrUkUxamJIZmt4Z1luMHZiTGxZNXdQaXVT?=
 =?utf-8?B?dFY1S0FMelFTb3ptdHhvemVtNDk0REJwOVJvOW80dTV2WEZ1RHpSUU9qQjNH?=
 =?utf-8?Q?/uDGpc0rVWEwOkyDJrVcM+TJky2S+hf3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0lDdC9rc0Z4OU1RWE1oYngwVGpJOFFNbHoyazhJSjE0b05BQm5CbDgxRFVh?=
 =?utf-8?B?MG43RmM5NnE2c3JBVXp0UUdJM2RzcmkxNGZ0dGFaNHNMNGhkUk1ueEpOeU9H?=
 =?utf-8?B?eXJLdE9NN0dNNTVmWUFHOWJxTVk2RXVUeWhKT3NnblZRa2VSL0NFV3RIMU00?=
 =?utf-8?B?RlE0UlloVG1SUWwvcmdnNVV4SXlPZUNmVmQ0U0NnUWdoZ3VLcjVKYnhyUWRD?=
 =?utf-8?B?YlByQW43NGIzeSt0N3FCOHRVdVZ3UUdyY3pOcXFLdE1FcXZxdU5OMm5EZjN4?=
 =?utf-8?B?d1c2RGpyZ3RhL2JBRWpDL0lqQmNxcW5EdjV0RlVjUVFkOGZvWGtxODV0ZGpY?=
 =?utf-8?B?dERydVAyY0tvSTZheW9RUlRUV0dHN0VNbkpYbXY5VXB5SEU4UG5xZTZvSmNy?=
 =?utf-8?B?blIxeDg4L2UrNDFadFJnclMyVkl4SUQweFpLK0I5Y0ZkMWorM2sxa29HcmxS?=
 =?utf-8?B?QTJjeitMSitLK090UGlJbEpwZG96VnJJbjlnZU53YkJQN2xCSFN0UURZTWZm?=
 =?utf-8?B?WEpqaHJtQk9nbUp4UFBPZjZCYXJtY0w1RnpKa1JJTTY5NSt5U1V2Wko5ekwz?=
 =?utf-8?B?N1Q1b24rQTBtWTcxSmdSV2NBL2QvSFc2RTBSaU9SazVPZEhCVE9KT2M3aGpu?=
 =?utf-8?B?L01pdkxjMnQ4TTYxSnA5NWpXMVhLU0hNcGo5Sjd0cUkyc0ZZNXhDZzM2Ynk5?=
 =?utf-8?B?STJrbjdhSkhrdzYxd0NxOWh2UGRuZ0lVZS9TekZ0QmNnb0RBRVF1cnBHQWJl?=
 =?utf-8?B?M0ZDVGdPWWMwY2ExRzhuMnhNeENvY2xKRFN4ZmEzTTVUUzBYYnNkSUVKQnNE?=
 =?utf-8?B?eWtETUVacE5XM1kxY29SdWZoVEtyR0JIZ2lOSDJIS0taUDJMUVUzTS9MZElO?=
 =?utf-8?B?S21qYWRBM3NmYys5NUh0dk5WSzR3TlE4YWRaazJha0NkNVpiZldmK215eGVl?=
 =?utf-8?B?VnhEeGhmMVNqWDhFNUFjOWdCKys0SEh4OVdERWNOYTMzZ0lBWlRUSnkrWTcx?=
 =?utf-8?B?NCtPU0g3Y1psOVkzVHZXeVdKRUJTSnZ2VmRHa09abHNaUDZkalpWUUtZSDFM?=
 =?utf-8?B?ajFod0dLdDA2aEhQcHU4OFAwVGYwak4wYmFuRVdGemVMUVBWZUNVSjBaVHRS?=
 =?utf-8?B?Mmk1RzRDV1Zwc09TRGxpSE5BQ0RlRGlJTzZJV2NIRkF3RkN0UkRuYVllTlE3?=
 =?utf-8?B?NXJnWXNXdGkweDIzTjRmeU41ekphN1ZWd0syRTZlaEYwMm8xMU4xckVOWE5M?=
 =?utf-8?B?R2YrdkdtV1RaWWlnQmNmdml6UUMxaDNsMGRla1draHoycVlJUW15WGNxNnRy?=
 =?utf-8?B?enNkbkJLVjlGdVRnU3ptelFaQXhSZno5SnBLazNXK0pFZ3gzM3VoVHZ2L3RW?=
 =?utf-8?B?L1g5U1duamU3WEFzS2lLWEJJTEZ0ZUtZK0NMRW8yY2xzRkZFdkgxQzM2QmUv?=
 =?utf-8?B?djE5em9GZ3ltNnpGSzVHaSsxOW9jT0kwRDc0bGpUc3hranlZdGRiZFQzZHVX?=
 =?utf-8?B?N2g0dFl4Y2JQSGttVzZYNVZuQmk5L1ZBOEpURGFUaVE4eHZSUWZPMU9ENVRw?=
 =?utf-8?B?SitxdVlyUHRCQUtFOHB2c0pSUmFFUnNOdjlsMXppRGNzMDlsU3kwQWgxdTVD?=
 =?utf-8?B?QnFFcitvNmliWnFwZ010djgxOUZOMlVyck1rYVNzdVNaUHZQZjR4dzNLRFBW?=
 =?utf-8?B?L281Wk0vR1BjbnVCNm9BOVB3SzBiZEhkZUxWNlJTeWtSRys1TWd0eFh4RzF1?=
 =?utf-8?B?d2tDV0k0dDFSZzZEUnNyUFB2a1pDYUV0aWU1NFVTcXUyU3hLWVE2aVBtNWFo?=
 =?utf-8?B?bk16Y3Q4Mm1ncVM3RE90ZHU0ZTN5cGFhaWtHTmtzc29pTFhxNG40c3lNMmlI?=
 =?utf-8?B?UWl5UmhSNGd2U2JlZmNjOUlVMTdIdnhXazNlQ3pkcklNL29QRHpOSENwUzFF?=
 =?utf-8?B?akc0REphM2RXYy9VYk4xcE1iSXdPLzgvSityWmJPVDVYRG56Qk8ybC9MdWts?=
 =?utf-8?B?YjRSV0pYT085NitOUTJld3ZsZ1RrVGxVcTcwc2JROE42UVJxY3I1d2psR3ls?=
 =?utf-8?B?Q0xWS09zNVQ1dnpBdVFZYWFvSjRneFY4UzNkb0trakJkdG92b2FJZDh3aVdD?=
 =?utf-8?B?bndYOUhtZGluQ3VoblJMbE5ONXhzVzh6MnFXYlJTdzVFeWRlSytza0l6REpq?=
 =?utf-8?B?a2ZoUURMMXEwSERNUEh3WFZ6MFo1NFBmcG1SLzg1eFFCdStyQUdqMUxFeEZM?=
 =?utf-8?B?Uzl6MklOT3pTZTFPamFtRnM5ZXZlbS9yUXFqZU9UMzhDc1NDZk9UdDRUZGNM?=
 =?utf-8?B?ZmF0N3k2eVcveTFLbGZpMGk0bzdRWFE0ZVJGeFJVQkxIM2tWWjBRQT09?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e59c47-b7c6-4f1a-26f5-08de46f63689
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 16:20:42.5502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAbVO+WmFeR9eADiioiJfrRSGg7WDe8/bnWGDBaCIm7GIskRYgoF+43M2HXvAKhzFHMTe0t8BC+iOLfyhy1rGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10850
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=den@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

On 12/29/25 15:36, Denis V. Lunev wrote:
> On 12/29/25 15:29, Denis V. Lunev wrote:
>> On 12/19/25 19:08, Denis V. Lunev wrote:
>>> qcow2_header_updated() is the final call during image close. This means
>>> after this point we will have no IO operations on this file descriptor.
>>> This assumption has been validated via 'strace' which clearly confirms
>>> that this is very final write and there is no sync after this point.
>>>
>>> There is almost no problem when the image is residing in local
>>> filesystem except that we will have image check if the chage will
>>> not reach disk before powerloss, but with a network or distributed
>>> filesystem we come to trouble. The change could be in flight and we
>>> can miss this data on other node like during migration.
>>>
>>> The patch adds BDRV_REQ_FUA to the write request to do the trick.
>>>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> CC: Kevin Wolf <kwolf@redhat.com>
>>> CC: Hanna Reitz <hreitz@redhat.com>
>>> ---
>>>   block/qcow2.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index e29810d86a..abbc4e82ba 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>>> @@ -3252,7 +3252,7 @@ int qcow2_update_header(BlockDriverState *bs)
>>>       }
>>>   
>>>       /* Write the new header */
>>> -    ret = bdrv_pwrite(bs->file, 0, s->cluster_size, header, 0);
>>> +    ret = bdrv_pwrite(bs->file, 0, s->cluster_size, header, BDRV_REQ_FUA);
>>>       if (ret < 0) {
>>>           goto fail;
>>>       }
>> (attempt #2, mailer has rotten the mail. sorry).
>>
>> Thanks a lot for Andrey Drobyshev who has attempted to review and
>> test this patch.
>>
>> The patch is non-working due to broken BDRV_REQ_FUA processing in QEMU 
>> code and this looks more severe than the original problem. bdrv_pwrite() 
>> endups in bdrv_aligned_pwritev() which internally calls 
>> bdrv_driver_pwritev() -> bdrv_co_flush() bdrv_co_write_req_finish() 
>> Please note, that bdrv_co_flush() is in reality noop until bs->write_gen 
>> is incremented, which happened only late inside 
>> bdrv_co_write_req_finish(). This means that BDRV_REQ_FUA request will be 
>> flushed only on the NEXT flush operation, which is definitely wrong. Den
> (attempt #3, mailer has rotten the mail. sorry. Finally get it working)
>
> Thanks a lot for Andrey Drobyshev who has attempted to review and
> test this patch.
>
> The patch is non-working due to broken BDRV_REQ_FUA processing in QEMU 
> code and this looks more severe than the original problem.
>
> bdrv_pwrite()  endups in bdrv_aligned_pwritev() which internally calls 
> 	bdrv_driver_pwritev() -> bdrv_co_flush()
> 	bdrv_co_write_req_finish() 
> Please note, that bdrv_co_flush() is in reality noop until bs->write_gen 
> is incremented, which happened only late inside bdrv_co_write_req_finish().
>
> This means that BDRV_REQ_FUA request will be flushed only on the NEXT
> flush operation, which is definitely wrong.
>
> Den
>
please disregard this patch. Fixes have been sent.

Den

