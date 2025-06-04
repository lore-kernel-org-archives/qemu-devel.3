Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2758AC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 09:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMkRS-0003XL-Js; Wed, 04 Jun 2025 05:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uMkRN-0003X9-Cp
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:29:45 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uMkRL-0007Oa-3P
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:29:45 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553NMihF027602;
 Wed, 4 Jun 2025 02:29:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=93jyiI39G80v9sLUrmIkOPYct8Y5godEmaKMlFj0n
 xA=; b=gbWeL0ObIcD/tSG/yXwl+cYM+BQ5gf7OMmZ7DxKNAL3mliIiGZR+yR/Di
 b+ADY6W+u52hONtiKh6fknBjBCEW8CxP4/SsffhZT2EmytvoYUH0Q1gkemKR6Ffk
 5fApXoLDy0Oiu7pL58zmi06UKTbxIpXCyJzfmlhWNxYa3YkeZH9Xm/Hu0FXyocp3
 lmJxizhInWRY0mSzyKg/wQrOmyM+2K5dkHHvuGfi4m807MvRPtmsjp7qkiFyXh2Y
 asnU6YGz4mWKWeocr4n0htaGXTOneunmEsljR37qsV/wWQHD1avbbIS2udRGgNSO
 b1RyhXJRJFW0QPnpYrQE9lW8wbzBg==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020089.outbound.protection.outlook.com
 [52.101.193.89])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 471g80vx9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 02:29:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njDF7XG/ypGdZxtflakyDl2aSyZX9I2700yHi2IP3Bkg8I98vYl9gRkq6l8xzkH+H9w79+fkYejd6i4N2R2qE2f3CM1LzBIowqbdO3JxD99/JhPzTE67oGVgBaM5ibpQg7uJMdCDtOXviknHNbE32pZKEsBKMnf/4ONJ2me6GfOvGw8rQMb2YuEGX2qU7zuOD0b5BroBJOGR7KfQvYm4IcB1W67RxHnPhlkIY76uhADzwzIFPDf6CfY8Fdn+rhP8dBLdt/jjYJmmogWgHn1xTZAEdHOQQa3FSPN1rYy9kSgnAdYD4sjETEl5fb8s6O+CU8bnhlmdn7DpwircOV9sjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93jyiI39G80v9sLUrmIkOPYct8Y5godEmaKMlFj0nxA=;
 b=D5cAPhndd7DS9ibTY5la5ifWxHiIdJnEmU18NGgIxHdmHNWadd38bBsBuvWeULND30IK+iK+2biXeC0rxgmMrKxuh/hhAQ5M96qG0+aW+5UM6NQ4I5aLcVGW8UEBvzn+jmeI0kgP1w/37gMQsshM+lNenhUH7yKyJip7UA3VAclaVSnQkhUoVQw0T+5phC9l8D3hSHg6dy8X1++e8PQKKgOn+z1ElyCBWW5Zg1HB+whP6y9RBjVyJn0KVlZcD7DtXo8or/fLuEEEiX/eK6q6UsIaXW/0eY2yQFYRYozgdkoPNcrWN08ZHHakRUVREt1VKeBKnufCBKRuqUbJiJ1p6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93jyiI39G80v9sLUrmIkOPYct8Y5godEmaKMlFj0nxA=;
 b=FfGa3WzRnTB07AWj45XtJqnwugpbu2v7l19Y3KUijUDqY+LdyGlwZpz7OvwW8o7seabhy1An6S97wh4I3lNNXeCHf7yb6pOEC2r54vfTgaGEIfZUBrsDJWY0lBPubewviIBZUEvUy3ziT16ISzOBRUiIktWHhFWD0/kWDGG/6/bEN+k+pBHc8WqG6QH3KcyMOsUahi+gIRPwCIBB1gTq7u/u3UJSVlQ9jjU5n+OF+fftF+0i14ECFY+5kyovEkHTFXiJ27Vht3xuc36Zep4iQa5o7H7LmEwnno5QLTAcl5BUnDx5oI6RLhP8c0kN9yosdV07ythpSTGrK/5+fjgkrg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN6PR02MB10680.namprd02.prod.outlook.com (2603:10b6:208:4f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 4 Jun
 2025 09:29:37 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8813.018; Wed, 4 Jun 2025
 09:29:37 +0000
Message-ID: <357570e9-42f1-4518-8e87-562a199e3800@nutanix.com>
Date: Wed, 4 Jun 2025 10:29:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Speed up the avr_mega2560 test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Michael Rolnik <mrolnik@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250603184710.25651-1-thuth@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250603184710.25651-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0207.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN6PR02MB10680:EE_
X-MS-Office365-Filtering-Correlation-Id: cc61b9fd-1b2a-42b2-1c83-08dda34a52c0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1Yxb0hQNlNURjlocDBBVXZuRTFSY3laUEdDMk1SNHlROURDRmZyRUsyK3RK?=
 =?utf-8?B?bnZxejR4alMvOTJhYjFjOTI1aytTZ2xJVk81b2FMSmFHUmhOemhGUktSKzMr?=
 =?utf-8?B?NFZzRW1tT2ZIUkppNkowbkhSNGZ1bENjR1ZJRTJYQVp6cmVWWDM1cHViWjZR?=
 =?utf-8?B?eFhYR1ZUMzEvQlNkdzgxOEFXalJLM1p0TTJlVWpqQUFqVjRhaDZnUU5oLzFY?=
 =?utf-8?B?TEhFMlBYYVYvQnpkL1F6L1hhUllUVFNVYzVEaFh4dFlpTEdMcFI0VEtwdmpW?=
 =?utf-8?B?YVh2aGQ4WGFXUFFtT2NOVkgvd2t1aDNmSVdoS08yUEpvY2JBUEtya3NwdXho?=
 =?utf-8?B?WTg4VzlPUFMrOVNqMFpXTHU5MitNWU45Qkd5S3czcGpmOVJvaWRacnpDTTk2?=
 =?utf-8?B?SzZmVFZXMnVMMmVZM0hCTFJkQU9qVC83L1ltZ1dSUk42S1IySDRlWnF1Z1g2?=
 =?utf-8?B?Z1V4MGp3Qklza0sraldRMWlxd0VzYW9nd1VSM2pYeG1yQTFsZEJydHAzQWhR?=
 =?utf-8?B?RUJzUksyd3NZcTliUmRCOE9EQWRjVTNNTzhjV0trQmRVNlowTVNHYk1MR3I3?=
 =?utf-8?B?bThDczZaS1dxRExENGIwVytIbXA1MldPVG9aSWRUOE0rRGNjS21BZklyVmpJ?=
 =?utf-8?B?ZnlQWHZONXVRdVlFUmZjK1lCWkdNcmNKNldEZFJOais3RkZpQXo0QUNTb2Fx?=
 =?utf-8?B?cUF5NHpMUlFRNmtCZ2FiTjVSSmlwTCsrOFVMcnpoeHp4bXlQbUlKaytFdGJW?=
 =?utf-8?B?WTJkRTNwc1FWVkxuYit3TzFWdzFlVU1JSnZ2T1lDUVIrNFkwK2x1YnhGK0F5?=
 =?utf-8?B?aHhuSnRTd3BsTTVnVzl0eGE0L1hzT1dpVFZhUDA1UWJ4bExBdXJtaHd3cnZP?=
 =?utf-8?B?cGZJY0U2NTdQOG9oK0hDUlZUaUVhRUdPRzBHZnJ4ZVVFcmw0VlFIb0FKUEYr?=
 =?utf-8?B?UXNMRTRSYlhIaExIaVdBejBWd1lJdGYvcnloRDB2MzNiV3RMRW5ueHd6SVY5?=
 =?utf-8?B?ZjJkUGpUY0U0MlAyWjlUWHR3Mjd1T01CK1NaSEVGVTNSeXZ5NjB3a0hqLzVY?=
 =?utf-8?B?SkZKc3NGSkVhb3FYWnZRQ3pXenFHa3lZcytic2ppcTc1MUg4eTF4bGlYMGln?=
 =?utf-8?B?VkEwOXZDT1o5TldyS2NuY0ZzTFd1SDl6L2dyb1NnUkx3akZ2bXpTMFJBUERD?=
 =?utf-8?B?bmpaQXNka2tDUDE1SEpaVFdxNDAvZGJkMklud1pnTnpPVjRQZXFocmVyc0tq?=
 =?utf-8?B?LzN4c0pWb1Z0V21PcjlmMTIwMy9seEFyV3pjdkdqeXd4N3o3T1p2Q2VUZDNv?=
 =?utf-8?B?QmhZZnUvdU1LK3hpTEhpU1J5a2NpRXFxa3VqNFZtZWpOVk54NWJjRUh1U0xw?=
 =?utf-8?B?VC9GMzdwVmZqMENKTlI2OGVxRnRTZDlQRVhjYzlNZ2VVYjIrZzRrY3ZaaWl3?=
 =?utf-8?B?ZVE2M21pMDUrYks3ZVczUnRudmZOM2JmSVROaUJpTXVJSWZjNjhPZHZMRytB?=
 =?utf-8?B?MGtKWVdPYzVLeWdmLzVFT3VNL2NEYzZUS3ptcnN1WEd0cVZjWlQvcFllVGRZ?=
 =?utf-8?B?TFphckZsU0c0aU9RWTM2QlJsS0JuOGxGZDErdDZXNXRiZzBTS1ZVQWlRZEJU?=
 =?utf-8?B?T2NFVVIzckRBVGovMy9UQVRYb2IrcW5sMEY1b3ZJck5mYW1UV2NJaVNjN3di?=
 =?utf-8?B?UWdDcE9DVXliU1EwbTBQNTVkWnptb3ZNQVEya2UwRG9SR2U0djcrY3p1c04x?=
 =?utf-8?B?QThiaFBLZlBUejNycVlDUEw5ZjJ3ZFgwdDB2cXBWZFpFbFNrMFIyaTNxNVlx?=
 =?utf-8?B?WGtyUkJQbFV1K0NVM2pMei91NytDaXVGQXA1YzlaL2psbXd2OWdhbW5HY0RV?=
 =?utf-8?B?cjB4SUpiQVVUZEhNVUMwQ1lNSnIzc01odEJITEhyNC9KVnR2a3NadnBNeCs1?=
 =?utf-8?Q?Il++E0MH6zM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHJRUkJ4VEtHMUxWRGZWL1BZaTVIUVhkdkM1eDVoUVNMR0p4ZmppalI3ZHZ1?=
 =?utf-8?B?ak84cWJ6ZEc4RFBNdjUwckd0WHZDcWt0SGVDaVYyMGIreThjR1g4UC81M0hq?=
 =?utf-8?B?eVdteU5nMVVCR3l2VlV1aWE0K1laMDY5WmNhWGxMVjd2ZjJlVWg5UjRCKyta?=
 =?utf-8?B?SmpDa256a3I1eEV1d3B0aUQrTXFaZSt6a1lpbHdYLzVvZEt1SHpQdi9sN3VI?=
 =?utf-8?B?eXBHMVhrbC8xYStJU3c3TU5ucHRqOHluZzR0T1oxYWlhbXZwbmZicHZLK0tE?=
 =?utf-8?B?b0ZKbkprWWpGdFc4V29WQlBlZFZyamNMQUVncHQ1c1pwUElIam9nV2dpcW41?=
 =?utf-8?B?UjFtZCtiUFlwK0lKZjh2bDlqaVE1Z0t0VU9ObnVOQ3NrbWRIRU56QldHd1A2?=
 =?utf-8?B?OGtjMEh0cHNSYWlKN1BrSTJ6eithN0QrM1BTUnluOHdXMjVmcFhpbjZvU1px?=
 =?utf-8?B?WmVKRkNKV3U4ZGxWRlRid3hMNUtKeVlzaXN0bEU5QUx1VitidDRJWDFRVktM?=
 =?utf-8?B?OXlkRWQ2dGk4RmZRWHdWSWl3cTZ4OGljWU9VTmhMNDY4MVNHR0diT0RhUzFu?=
 =?utf-8?B?WEVjb0t5VSsramxESHNESlBWd1E2c3J6NFprNk8ySDE3QTVSNDhRa2N4cThz?=
 =?utf-8?B?dUhFNG1aQzI5bjBKREhYS3lZTW9Rcmo3ZjBqT2JlNll3Um40QnZKa3h0NldI?=
 =?utf-8?B?UmlLQUovS09rSEJleXB0SGU3d3EveExsYzduS2ZScjFwYmluWEthMHVnT21p?=
 =?utf-8?B?YzJESWpFZS92eUFkbUM5b2RUQWdCRU0xWDhZenZTL3dobkZhbjRiMnBCSjQ3?=
 =?utf-8?B?RUxFb3dnczdsUDBqRkFQc3UzMytXbHlRdlZnNEkrT0ltWmM0UGdDOEJSMXJq?=
 =?utf-8?B?UTRwb3BEWXpFMjh5aWVFRTVRYjhPdlVPRWhRU2h3ZGR5ZE1XZVpqRmZScVRt?=
 =?utf-8?B?SDdrdlJCN2V2aERobkdubEQvd3BWeVJ4ckRkZ3Bxdkt4TW83a2VxUVB6MjhP?=
 =?utf-8?B?bWVITVVsMTFHQlBxQ28vY0tLSnM3RFl0b0w5SURaT01XZjE3UWFpVDVqZkY5?=
 =?utf-8?B?SkZsaFhwMkNVeXRtSEJrQzJzT0hxOHRhbmowUzZ3VGZHcTZnbFY2dCsrYUMz?=
 =?utf-8?B?dHZzV2NhVU14ZTVha3E1OWlSQ1lGZkRjQlhZTUIvWW9pR1BzZ3hGa21aUS9h?=
 =?utf-8?B?ZUNhcWd6ODZobS8ySnVsQktNY0VTSjFGeUgwWEVyeXFUTjlGRmFpcDdLRU9H?=
 =?utf-8?B?b3ZGbWdLWEtlck5XU2lOcVBFczYzQzRoUk5iMkI0YStISGlIOEwyY3RTODFi?=
 =?utf-8?B?ODJHWmpVTjl4dlV2RmhzYmE4QTFJUWxpbDQwTXh4Yk1Da0FLSll1MnhQaDdh?=
 =?utf-8?B?SmFsdkViMWVmVkUyYk5kV3hHdVZYMG9oQ2dxVnVzSVRDcmUrVzJkNWs0NEhi?=
 =?utf-8?B?WDVIUUVXOTF3VG01RmdnRm1oLzRoS0c0eVVBa1F5NGFqcE11YVpUVWQ5R2JR?=
 =?utf-8?B?MTFhM2RmYXRwekpqS0dFbHRJbUFXTVdnMmZHbS9TaGNzaXhWNVFqaTRkQnB6?=
 =?utf-8?B?cFpqUWVENmxkejFqVVhoVjVTTTd6TFRlUDl1ZVVZRFZFdS9YOTVDU0wxL1Yw?=
 =?utf-8?B?dE9CZmhmMm41WGJhVGlpZXo3RlVDR3VZNHpjT1lpMWRjUGlOV3ZrZ3F6ZGhT?=
 =?utf-8?B?SzdCaUp2QUlReTR6cGJieVRDR011cFdsTWRwTXhObzdmQkZ6N25VNjFaQ0VJ?=
 =?utf-8?B?K0J1R2hQSjBOZXQrUXR5MTdsWnpsdEN5dkM0Y00xNUpvcDA2VldXOGtUbkM1?=
 =?utf-8?B?RllocWhWWXN4OGROYTUzWlZLS3dWNlExajkxME9qYW9MNGJmTnpyU3BwcnFD?=
 =?utf-8?B?dGkwL2dFR2Q3TUVwV0RpVHpXY3JKRS84dVo1L0VxL2FuQ3MyT2dieU1WYVlE?=
 =?utf-8?B?THllUjNNTDdkbnM3YllZTkxmMEk0L3RjRmVvN0U1R1Z1VVV3MThBK2NHblly?=
 =?utf-8?B?LzJ1YUsvY21lSFNUZ2pBTkRKOUhaNEhQeGovZnNDN3JhU0NWbXR1Z2VISkt1?=
 =?utf-8?B?bERIZ0hDcFM5NEIzRE1VeUprRmI4YzJOeHJjM1ViMEs1aHllWFdDMDRET0pL?=
 =?utf-8?B?UC9ieUlaR21Ob0VtQmZ6cmxQR0Z3NWJld3B0aERyR09pTnVyTjdIR1VLVm1E?=
 =?utf-8?B?NVVqMjNzMEdqZDdrU1lSZlRYaGdzczRnU2RHd1o4NkgxSnVOMHhmbk5UTDF4?=
 =?utf-8?B?aGY4UkJsckZObTRzeDJxMTVCUWhRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc61b9fd-1b2a-42b2-1c83-08dda34a52c0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 09:29:37.0030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehIivz+Sp/XrxdIVa4DPSNxwYQgVwnzmgB0uCUFKfrtDFqfYLVL5dwKEDuiDTq41qhdMH8xwwfXEVjND5p6YZLalYXyMZprkg6I1J1rYu/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR02MB10680
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA3MCBTYWx0ZWRfX3Si3/AzwUFQC
 KDTZ6MtvthOhl/SZCRYCz1hD3++ubXHW7Q5MUqkRXxRbvOQnLe/23j5g2vM1EWywyiIzJIQP2lE
 28TJNjnt7jFTWoG+yLSZgdpiipEFtFH9M0mxnVQG1+jkjk1GLfpN0izOS1QDE6k02cm1mvrqwDT
 vH4b4Ik9BFH10gXXGbZShdqEyOVWnPibd/DOyCLvhhjk+HSLlc8sb+k00fc6ik2NIQfU68XjoXp
 uuBsAapMNLNj0b6KQxN2SH3wZe3gDpXV3IydAraRUH17+E1AmGQzagRvPP2hRCHIwHEYHdCCSy7
 I3LalQ0Fgg0oke5gV6/7T/9vwxwjDEyisVyFcsP44+s+AT9kr55UaBuheggS2FY/UkneL0iccH3
 XYreP3g6cbd8k2KODr7Bkgsu4mU5y72KNN4addb6ajMq0K9D2RVeYFGemFPws55AYoJA0Mt7
X-Authority-Analysis: v=2.4 cv=SY33duRu c=1 sm=1 tr=0 ts=68401203 cx=c_pps
 a=O6Z+/RI5KFzJW3E8GZexRA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=mDV3o1hIAAAA:8 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=H2tbPquy-nke62CfnYYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GiwXKq8viDsCcVihgAf36tIYcqeNtcUU
X-Proofpoint-GUID: GiwXKq8viDsCcVihgAf36tIYcqeNtcUU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 03/06/2025 19:47, Thomas Huth wrote:

> From: Thomas Huth <thuth@redhat.com>
> 
> We can simply check for the expected pattern on the console,
> no need to wait for two seconds here to search for the pattern
> in the log at the end.
> 
> While we're at it, also remove the obsolete "timeout" variable
> from this test.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/test_avr_mega2560.py | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/functional/test_avr_mega2560.py b/tests/functional/test_avr_mega2560.py
> index 8e47b4200b1..6359b72af39 100755
> --- a/tests/functional/test_avr_mega2560.py
> +++ b/tests/functional/test_avr_mega2560.py
> @@ -18,12 +18,10 @@
>   # along with this program.  If not, see <https://urldefense.proofpoint.com/v2/url?u=http-3A__www.gnu.org_licenses_&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=wcQJ2Ax5H667-AP7udJl3WHmdxCv36HyQXx3SArS2oY_w3J2H0bxwEXndR1Iy6og&s=01JTQZmaPX871rnZHJx7JQlhG9qCl2pjRZqbhEfUYlA&e= >.
>   #
>   
> -import time
> +from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
>   
> -from qemu_test import QemuSystemTest, Asset
>   
>   class AVR6Machine(QemuSystemTest):
> -    timeout = 5
>   
>       ASSET_ROM = Asset(('https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_seharris_qemu-2Davr-2Dtests&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=wcQJ2Ax5H667-AP7udJl3WHmdxCv36HyQXx3SArS2oY_w3J2H0bxwEXndR1Iy6og&s=87NS3AlsRs7HAlnHypt34ACHv3b34WXbF9gtk3pKOIE&e= '
>                          '/raw/36c3e67b8755dcf/free-rtos/Demo'
> @@ -40,13 +38,12 @@ def test_freertos(self):
>           self.set_machine('arduino-mega-2560-v3')
>           self.vm.add_args('-bios', rom_path)
>           self.vm.add_args('-nographic')
> +        self.vm.set_console()
>           self.vm.launch()
>   
> -        time.sleep(2)
> -        self.vm.shutdown()
> +        wait_for_console_pattern(self,
> +                        'XABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWXA')
>   
> -        self.assertIn('ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX',
> -                self.vm.get_log())
>   
>   if __name__ == '__main__':
>       QemuSystemTest.main()

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


