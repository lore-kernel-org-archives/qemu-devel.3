Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52121F9EDF9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 15:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFZaG-0007MQ-MW; Wed, 22 Apr 2026 11:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wFZa2-0007Ho-8n
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 11:33:35 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wFZa0-0006eH-7e
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 11:33:34 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63M7eNIt3404408; Wed, 22 Apr 2026 08:33:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=IDY3ztRJJl9bSj0BMUJCSGxKsyx0TAyi/DGTUFsx4
 Ng=; b=U6ZVIEF5VCAdvnV/ZuN3/2qfj+v8YnzPKUGcm7cydrMthafqIwZPheuXZ
 koZsHNUA2Y9q6oOerLa6BGAH+ue9wvCFjtXKxwnjozby8+VU7XHfYZsBEPtHIno/
 LEWs59IRY4kplWDmEemyDiPQQaeht3tIbd3ciVL72HoDxyTPfp86MO7AXpS2gtNz
 ETVoUpuBwAwMeq8IUUi1yYPOx0hQ9qCDBMIIUzbbm/gWKd5ghrKwzrOVSVPVbwFP
 5flNMNPguCkzy5hXLsl5JlydeAN6m4Hyt69YE7YYqNUF2vRRpih5m4MTUQG38GsR
 UJmQRhuDAKyNiln6Fs3zJro4lMzmw==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022097.outbound.protection.outlook.com [52.101.48.97])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4dpepa2bpg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 22 Apr 2026 08:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObsxiwQRKgqvBCqyYOVRU95qdSnBjKb65WbQJqJXI+m9cO0Pec56EHERF/JrAPcXWfiSp/gJTMXcfe0TQo51HmWIXhado138h24iE+HB9Oah/jApFpzeOAFXq1x04k13wk7+MbEvRWAVRy58OdosSTffk9suKzWBKQ+tr84GbPpbWJ1YE506YG/tycrldxjKeUWv3gnH1CwcAObQJe/us2bnUn2xXBkOaib10ub1I6GSuYSqmVps9VG2HGyTCz5G+cQkAN2v0009zwQCi3tc9WHizy1dEqF5Ar/hbUaGtQ8XSpZXNJoUmq/BzDTZkoWKQnG6ZNPTIyhgqtcsKV7/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDY3ztRJJl9bSj0BMUJCSGxKsyx0TAyi/DGTUFsx4Ng=;
 b=MpenG5+urBQdG4e6kjRLSEk98r8WhWgcnd2Z37M68fnU8RCvGubABh9Kaj5vJmPIg2pYovbWILTOKtgLF182oiIbKGb+mYjhnhyVQ+Cb4yT3gfvns/7aqMR1tEvg6R3bItEjF9NqSWCdE/7mZk86W/j9LaBI/d+sXI6R6jQXpId2CT+mlTr5stghUSYzCpWX7Y8Q3ASSZDxERWoejC0jtupfazZ7x3x9K8ES2r/phU0PX7Ntybn1B0Hqe/BEPpLc+eZTrKndPjXpDFQIR/he+UB+VUViMcPvKCTY8eKVGRfo8dwvHMtBFnG+ZO7HRfGffMJ7rh1UGS1Oqm99yeWvLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDY3ztRJJl9bSj0BMUJCSGxKsyx0TAyi/DGTUFsx4Ng=;
 b=ApGMKRgcQV/j6kkvE0SRG2HeVZxCnAM69W952x3fydQt1lGqkipIbgDFB6i8ZigsTdWIiGm884SNsBXfxPYXxWDKDLYagc2k7rx7+UXhr7SksmDTfdOqUvQuVkOBgEirkfCfRkTl0N8yEj8oKvXKyIegSjr4jWwG3M9DuxoCmG5/sh6usEnNBnGz7uuSJaHRN6IXjAwF1Vlf3Lwa2jC/c0gWWvUnEiInfVad3dxnQVW8h5knYJFQ3aBY4GTYH7q2Jyr/0aCIlqun/WFIil+Z4pEccKsWPaJyKYGpQzFLQRceqe/ee+l7x2tWz6NgdrOnEd4fmko2tkzycc7NtnMwaQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BY5PR02MB6533.namprd02.prod.outlook.com (2603:10b6:a03:1d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 15:33:24 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 15:33:24 +0000
Message-ID: <21abf43c-1efb-41fe-8bb7-66b83fe15fae@nutanix.com>
Date: Wed, 22 Apr 2026 16:33:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/remote: update libvfio-user subproject
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Jagannathan Raman <jag.raman@oracle.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Elena Ufimtseva <elena.ufimtseva@oracle.com>
References: <20260422140244.2147400-1-john.levon@nutanix.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260422140244.2147400-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5P221CA0117.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:1f::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BY5PR02MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa6c517-89d2-4bc4-2ff3-08dea0847e01
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: MA7YqfnNQcRIvjoRtH46v9VZDrAbT89p3OIZQ5ahFN8FbwHeiq+L3pcqcqMSYPpYrZq0ddNX1XmTvmnNTKXhSbOFJilK0pWKfuVsmBKaravz4Nwx7/vvcgQKFgrOEPffl07zYx3Qtp1YB4qT037VaumLeTYygrQ0IIRgMcsaPqCHriqjvgZGyC4E8BAsLyBURZ6s4nCRic6txrDP54a7zVJ1CaU8ay5FuTG4hp8G/sxcvV7z+rosoEi41JfTd8+ulFMkqNyzd7JXCNEvHYTOSFKRhBhI4WtUlD41Xn2cjB+IgS6PoPncsei/6qntLMkInNc8FsNyx9m88q8qrkgGngmuTQZpZP4J4KF3LlnqyE2oncufnFkDunS6At49TCST2bEitOt8y3xz8mq4L5DVI9spb8WwAvHTGA4cWAlJgSC4tUZ0FL4Vbp89RAtFfl0Fdq7ZgOCRdjz9yiYrnWlxSTgkWD0qFvs6SllFO8/O8/Ucg/XU0YS7UplePOKoa6CFeBCAxkqWOz1OFVBos0akoBu0hHlMP32DiyQbAwCOBvr4a4sRgZjzw2lByfZNQPJDsD3Y2Cdf8ImVa2IPVZttjOpzfcCxgZEZ+y/BS0QaqkVI98/JkTMS8i51HvvShqVkAM+2Cv0lkCGPMmnlIADqBi6znEKLXk+JjjR93adPWzuHTCbM3k6L/IXHG/tfWGWJ/IRAm+/oI/4Ef1qFgsjLOTD7XYob7YiHIDmYfG/VR+boiNUAOOGbqZNfDUOQ1jzi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFR4TEpVck1YMTVTb3poajNFYk41Kzhtajk1MjFuY1R0eE9taFVkYXRhcTds?=
 =?utf-8?B?NExTS25pRDh5MmxubThWSGROaWw2SDNoR1F3UnF0dXVxaVJrMjAwUkxuY0tU?=
 =?utf-8?B?aEZZN1JOQWprL1lYYWE4QWRNLzc0QjFjRHYwUHliUVBIdWVJNGo3ajlmanM4?=
 =?utf-8?B?Njh5SDRyclZzODZ4ZzRLWEoxTmhBZ2hubkQ0YlZBeVFJR0puN0liTzFaeU9P?=
 =?utf-8?B?S25SZ1VHUWZ4dThFWXZHVUFoVm93UnQ2MnJUc1lGUDB2dVRVK1BmNm5ycVdI?=
 =?utf-8?B?NS9wMHlFRFArek9hQzBEcitOdlV0OFJDellITHA1M05Cd0poYk1VY01pUTVj?=
 =?utf-8?B?dEFYeFBOc1BiZ0I3aXg4MUNaRkNqOTZCTjdQMFA1enB1WCtld2VXSUJJY1pE?=
 =?utf-8?B?Qlp1cVdUck5SNHVHV1JHalhtczhFSkZhRlRQWHd6S3U2VmRwQXdOUmFMNWhh?=
 =?utf-8?B?VGFTNHFtMXVsZjVGOTFXTzlCS0VTQ3g4TExBTmlIS2xrMTNQbmJzc1RubVpm?=
 =?utf-8?B?ZVpjQzZUSk13R3ZFSW9mUDB6czZWcTgrUERXTnQvRVFzY0ZwQ1NxcDhmdnVx?=
 =?utf-8?B?aW01d1U4VmZQaTdjN3czQUkxVjd2c1JHM281bEszVkRrTmhpNWlaS1dGVlFG?=
 =?utf-8?B?dFlKYnVTdG1kRzMwTlZ1Skh4SlJmQnlzN2dvd3BPTXhpNHExekdONnNycFpZ?=
 =?utf-8?B?aFh6OXcvcWh4TFZ3L1pTRFA5M2lWelF6bzNZUHNmL3lnVGI3cGtXdVk2bUhs?=
 =?utf-8?B?UFluQlRkSDlPcGR2bzVsVFVrQlVQRFJPN1FlWmp3L0J5WUJiT0JSTG5YZ3dw?=
 =?utf-8?B?SHRBTGszVmZ3MmgvTHRkaHphdnplV2hRU2ZLZ3hieXlORGNwZ0txUGZIUzRN?=
 =?utf-8?B?Z291QnA4Z2lTVERhZnZjOGQ2cTNxc1hHSmlSc3hMVmFmbmtDZnVlNjdnc1VI?=
 =?utf-8?B?UlcrRFQ4eWd1ZE9zK3IreUlzUWM4Tm5qK2JDVkxnbCtCdFFwNXN2VkRyMDVn?=
 =?utf-8?B?Z3RSQ0Y2T08vMzA1YkZRTTM1dW0xQVJPRklKZ1NjZ2xzei9qeXpPWVRVZGhl?=
 =?utf-8?B?QWZEekxLYmVCN0Y0c2dtcnZxZ0svM3NvMkFNQlVYSnk2OFp3K2lpUVNRdFBV?=
 =?utf-8?B?T3kxZzAyTzlHdEtNV0lkT3YzbTJ2aEpnUlpDLzUzSWlOSEdhMklwWFNBb3Vy?=
 =?utf-8?B?cS9Oam9EYk9Qb09uTGwvRkVYeCtwYVl4QjNJaE1WTzVtaVpGU0N1cU8rcTNR?=
 =?utf-8?B?Q01pZWhGaVNWY3p5RHc5N2pKU0wwQlYzRUNGNnZDVUViQkg4bG0zVjRMbTcw?=
 =?utf-8?B?UW5YbTcwZU5YWHROUk1GSXVFR0N3bnhPVURyVS9VbHg1Z0FnQWdOVmY3L09G?=
 =?utf-8?B?eStUSXF2b3pYRnpTWnFMUWUxZzJQb3RURUlvRkh5SHltWVNSQytrZU5BbXdj?=
 =?utf-8?B?dmZlbDNha0RiYyt2d0V1YmEvSHp1ZVZzZnd5aWR3QnNiTU1vT1FxemRyZjlm?=
 =?utf-8?B?dEp4bXVvVnE4R1I1aVBUYlloUWVTd2p2cWUxTlFqdGNTV3V1MnBwY0svbkFj?=
 =?utf-8?B?VHVBY2Jua3ppNVU2ZkQ0REZzNWVPV0JFWDFKL2RrdVcwK012WTRHa2ZtR1Ew?=
 =?utf-8?B?bmRnQUh0akVCeUFxZ29vYnl5d0RLS1o4VnE2UTZrVWRERkQvWUNnbVltN3J2?=
 =?utf-8?B?LzUwcVJEZ1RwMEo5RWx5akw0WlU0dkhUajZlR1dnL0FYWmRFeTR3ZlplSmR5?=
 =?utf-8?B?YWhFL0NrNUxZQ3hENXlUVmQxOFV5dE1sTmF2bUNCSUh5bnRVMFZnUUo1ZDJV?=
 =?utf-8?B?M1hWbC9wNzkvQTlEK1pOek9yTjdJczdId3d3cjZiUnVEQUp2TGVWQkVDY0Fv?=
 =?utf-8?B?R0V4Ty9WaFFqMTQvQXlZTmtENkNjWS9IQjZPVElRZW9UaHFtRzFFWWd0UnBY?=
 =?utf-8?B?RkVVdnpZQmppN1M0MkU2WmRGQmVMK0ExdGNJeUR0TGRLMnI4TkREdUpWb1V0?=
 =?utf-8?B?a0FLOHp6eS9VSEdlZHZvT1JSNzZydHdKbitVQzAxcHQydW53NTM3R1liMkNS?=
 =?utf-8?B?bFFVSk1uTEJtY0dtMlRRU3pCRE9pdHpMUnQwTDBEY0Qvd1lna2JsMk1tSUpD?=
 =?utf-8?B?QXM4R2RVYVhqYSt0YldwdFdWa1hYUFV4eTVScExCRHluYkNJdE5uQm1DUHlI?=
 =?utf-8?B?WTQwQ0YwMUFJWWt2TERTVnMyY3pMVVh1ZTUrWjJFUkZ5Z0RENk5hb1lUY2ty?=
 =?utf-8?B?RmF1N20wWlYxRGt3UU0rOUtsampMWERadWYxc2lVZk9BT0VxY1NhL0pvUGxw?=
 =?utf-8?B?czh0aHVRZkxRcUFpZjNKdDJYcVA3NEhxNmNCamtIaDRnODc2UjdPOUFIUW55?=
 =?utf-8?Q?tYvhaAA2JdMIWE1s=3D?=
X-Exchange-RoutingPolicyChecked: Tkim+58vt3Wj9YQR5JJSfzCx1EvKj9Kxs77I+eeBAnyMuJWNQNLAa0g09mML2HPrZn3LIcg/8zd4kl/In/of/P3TiGwiMaO6KHzyB9uRCZuQ1badQQ5GjzdzrSgA2v16Ql1QF7C7/phLajZZwrVvaqMv6/+HKms6en3ozQ6q0zbAVqOM6NB5H31zRXfPLeB8w0O8dlzgE7ISo8AwgjmCu6u0ujzT6+GQTzuaOj3uZyHsTEB6rrEWZ8qMHVh00Ev4EE+/iZvgaYBaXZ0NpKv6W981rUDXKfwtOOxKryEYMGE+2GiYyS6DldSO5noWf22PM31YwKam/STulquony8Mng==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa6c517-89d2-4bc4-2ff3-08dea0847e01
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 15:33:24.5657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Hn6eKgyT0N/BWp5VtY1K4biGw7sG26sWr8bxCSD+BJR1/Ju0D0k9MGsLlFLTDRxb0wEptbm5YeYQkWZsy8LubEaqVr6SAWr3okd90q34f8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6533
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE1MSBTYWx0ZWRfX3Di4tkwUc4Ya
 +/7oDHF2pyj2oL6SUC1rQdTtCu6f4rVDpnhwL4Sm+JGFSAtOZe+fBO1NEKo1xCGQFL5hvbc1kCb
 HKCeU+BSOug65GYdyAEv1d2A+smcC5Fp/QbU22sigBLYMjSbp9vzRJCmNPwFKxU3AKaXPhXfmfV
 69OQsilaL/+nkuJCYgLrTxExKVOL/McRoA+feCoyO1p4iWCAAyskE5GZtQwyGanwdOgWnjm55L5
 kGx/t6K8do/Cka7eh9R1XtXs25W5V54rZabXYbt7jowJ059fqqUeteub1kF+IDlEzoK75TlKwOf
 vggI/u3J4VPnAAkdX59UGs15elomHVqwoqndp7RP1lMbA7rmslDiViXKKhf2RGXCes/D/5H4Wbc
 ePqlrJrsgOn2yTJaLCa3PL+Ww2QWJ4q3Ma8xt1BRnuSJxtqloh7H7uUEuFnaSlqCi2p21aEpd+i
 5Xgr4qc0Wg+uOoZV3vQ==
X-Proofpoint-ORIG-GUID: 8q_chgIvyRBF5vzkNP05r19LDv4fexYC
X-Authority-Analysis: v=2.4 cv=CMsamxrD c=1 sm=1 tr=0 ts=69e8ea47 cx=c_pps
 a=kzsVodbpLl5/Zj7uDz6sWQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=p0WdMEafAAAA:8 a=64Cc0HZtAAAA:8 a=NI5Qw2LwVA_8nx9GKpAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8q_chgIvyRBF5vzkNP05r19LDv4fexYC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

On 22/04/2026 15:02, John Levon wrote:

> The currently wrapped version of libvfio-user has compilation issues on
> newer compilers; bump the library version.

I'd expect the subject to be "subprojects: update libvfio-user 
subproject" since that's really what the patch is doing. The 
hw/remote/vfio-user-obj.c update seems to be due to an API change in the 
updated library, so I'd add a sentence mentioning this in the commit 
message.

Otherwise the patch itself seems okay to me, so:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/remote/vfio-user-obj.c     | 3 ++-
>   subprojects/libvfio-user.wrap | 2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> index 12ecdab6de..3c89e7a741 100644
> --- a/hw/remote/vfio-user-obj.c
> +++ b/hw/remote/vfio-user-obj.c
> @@ -798,7 +798,8 @@ static void vfu_object_init_ctx(VfuObject *o, Error **errp)
>           goto fail;
>       }
>   
> -    ret = vfu_setup_device_dma(o->vfu_ctx, &dma_register, &dma_unregister);
> +    ret = vfu_setup_device_dma(o->vfu_ctx, LIBVFIO_USER_MAX_DMA_REGIONS,
> +                               &dma_register, &dma_unregister);
>       if (ret < 0) {
>           error_setg(errp, "vfu: Failed to setup DMA handlers for %s",
>                      o->device);
> diff --git a/subprojects/libvfio-user.wrap b/subprojects/libvfio-user.wrap
> index 416955ca45..11db795f8a 100644
> --- a/subprojects/libvfio-user.wrap
> +++ b/subprojects/libvfio-user.wrap
> @@ -1,4 +1,4 @@
>   [wrap-git]
>   url = https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.com_qemu-2Dproject_libvfio-2Duser.git&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=ISwI5jNoODKCfAhvIggfxoM8rCBQTgD-TrxSMkw8aq533QGLfHtgCaNaf41km6lt&s=CPF5JE7hn0XRJAOBEvH_Eajaj4chiPVUN6hCJS9bEpw&e=
> -revision = 0b28d205572c80b568a1003db2c8f37ca333e4d7
> +revision = 4d9f663450fa80ff375612dbbafe073700e3d3d8
>   depth = 1


