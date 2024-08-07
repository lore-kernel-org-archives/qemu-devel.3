Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21039C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 21:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbnq8-0003bC-KF; Wed, 07 Aug 2024 17:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sbnpz-0003ZP-DR
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 17:04:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sbnpx-0003XD-21
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 17:04:51 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477L3W3M021471;
 Wed, 7 Aug 2024 21:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=oozn1w+FJaaXpcomAqe5jLrUYOoNhOlbTl4AkvBrk7Y=; b=
 dozNQGoz2cumhx+J0Z8xBkj99KleUa1CET4/2F1GiFeclYGFv78TRwAWJ81TvodI
 DcCxKSvOWGCnd3hj+Hc/qFGh+4kYXaNwy6KTBJujb1uMknku79cdzz5ALNobCSAx
 FHGaUVCcQ7cdF9dwOMP/ZnSv+ACmhQniJELCvrnuJwp8pwoetMwmlZaGKV4li3cc
 rfGq1vbKsneKIN/TYa6cczEK3uVcKUUSoUxwLovqPMoIjqpeU65N75hG3F1cnI/C
 2o4AuU9zomjbSvDaa6b+sfA4KyE936woy8p51S3YqsJiKbgv5c3j+gcNdzpyEG9X
 TCGQzU8gtN3ffDauJYKbbQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sckcghx0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Aug 2024 21:04:36 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 477K2kQ0019380; Wed, 7 Aug 2024 21:04:36 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40sb0ag3qb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Aug 2024 21:04:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5WoRgYfKttvvgoY2gjTaTPfmzpjf3uUKDtUY3DpxrgXFZLyRL8J2eN5Ymh3ELZ4eLtSuIuGVeYcg1gnTmNIfJvlcB5DUrvtorFpOJUrJsf5HqHgOCsfeqIYPlFRa3RPDUrimuJ9WtxPuNysg4taDlAu5WFS0G7e3QteHZDzugF+kv4KuHWM9vBxlWRp716X18UqVABXaTnGdoakvt99+uERccKWe5YqamyGt6+RuGEUWU6FZ//QkVfIYMV3ACON6w6C4UWssc9AqC/2AQg46dlDOjlqNeJgTDntoD50Hoe479xEZapTG5XN0r+2fBoQ4AcVyM4K5xZg9LJv42AKrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oozn1w+FJaaXpcomAqe5jLrUYOoNhOlbTl4AkvBrk7Y=;
 b=O0yQjMad8gMndbUawtvmh5ybGgVtz4dARSHAlL5t3198UALYgyT3CH9wR8xv4Sogqw6QCzL8USSAJJh3mfYVX+xeAJnr7yxBy9g9fhqQ9tbDCc3r+WOFpmOcoFLU3r1uwR8MvA4Ygk4cE89r0H23KTYQn4N0EE816vkUdOWb6Y6aiiejlhKIli/KSX80EEX168wQfQgs186VZaT6JkhaKJrqs8dW86qg98JjR749UYRoI9bbQygN152RHQlyrfOkJLJ37/YVx87Sdo3Bo7ZPp0yOBnXU5Qff+ctANA2HkvFjUu88RqcVfgWoh7hhUR9jDm3VYsYSMYnGPAYz7ViVxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oozn1w+FJaaXpcomAqe5jLrUYOoNhOlbTl4AkvBrk7Y=;
 b=br56CFpakKR6sxvyd7gE8zZjNm7DmJ7xkC/UWACXPQtyyEEqsNDZsQJ0pgn0Ic/4e3cIdkJcOq09M6i62ANrIqZR8/51fAjrOcBprxG46+qVG50JlHkpNn9T3tjU1mNe+6SrGBE8xn6/5SS7tQ1dcq9oi+fPgmkt63L1e9727UM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MN2PR10MB4142.namprd10.prod.outlook.com (2603:10b6:208:1d2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Wed, 7 Aug
 2024 21:04:33 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 21:04:33 +0000
Message-ID: <571a4f84-693c-43d4-a43a-52a53a1091e1@oracle.com>
Date: Wed, 7 Aug 2024 17:04:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 06/11] migration: fix mismatched GPAs during cpr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-7-git-send-email-steven.sistare@oracle.com>
 <ZpqUGYclrONQEuc7@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZpqUGYclrONQEuc7@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:a03:505::10) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MN2PR10MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: b81a18da-db7d-44b5-7571-08dcb7248911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUhlWlh6YnJuVzJENng5SUdaUXgrTzdzY0MwVXRvMGlVd2VDa3htcE9idzF5?=
 =?utf-8?B?NEJpOU82dUgwNFNLanlDaW81RmNsVjhYOElobVRBQW1NSWFQblZkamxjTTlY?=
 =?utf-8?B?RU9Mbm1NM3drTjkyR3hIRWVFUEQrUDFaUGtkRU9vVVFIV25GZnVZT1U2am5n?=
 =?utf-8?B?ZElvcEU4czVPY2FXdWxGNG11L3UxbmI5TnhxYlNDZXhJNkhBUy91OGIxNVE0?=
 =?utf-8?B?d0pxeFlOY0VydFlwSnhVUGR1TlZNNDEvKzBOQWZ5K0plZytpcmsyaDB1RE5S?=
 =?utf-8?B?NlA3ZDNVWlNnTjRHa1lQNnJva1VpL3dLWFJuWXJhYnQ5U0FWSTBDaWhJRFRn?=
 =?utf-8?B?RVFKeG52ZUlmVXdTcldoN1hDcTZoTjhudG5HRFhCRG55T2V5VUx2aDlYRUlP?=
 =?utf-8?B?bnUyL2I4NjM1aFZxZytoL3IxZC9qWXZGYzZKSk9jeFNPbTcvUU9qenpUODZE?=
 =?utf-8?B?YW00YzZBa09Ld0k5cFZwQ2Jkbmw3OHhUZE01d2puVXA0RGg5WWFaeldsRVVu?=
 =?utf-8?B?ZVI2UU1STmEzMllkYTBJbUxQN2ZOOFJLcTRQdzR3NWo0d09SdzlvRlE1SGpr?=
 =?utf-8?B?UjdTdlRLR1NhMGRhTi8zZExNdHNyM09vTnFJUHlMVmErNmlDdjc0VUpWdDZS?=
 =?utf-8?B?d21yM08yRDQ4cmJCcllhWlFnWHEycCtUdzBmRW5BSGxEZWk5bkhUTzViVE1h?=
 =?utf-8?B?bS9lNzR3cXR1YUJEVkllenhvWXpyaUFYcXpoZUQ4a2VyUXdVTkN3NnVEbkd0?=
 =?utf-8?B?NDY0azFnZGRXWk5xK2NLVitjd3h6KzdIQ2RRT1MzRE82c0xjMExnMjlZcVdP?=
 =?utf-8?B?TC9pcXpJU2Z3b2hUcjhNWVZPOEg3Z3ZmY2IwS0NqdkJQK0tKeDQybTlET1Qw?=
 =?utf-8?B?aGJpWGdJTmtDUzF5YzY3Z3dGSklHL1BPclVZQXJUY0RxMHdlUG1kdXVZa2J4?=
 =?utf-8?B?bEJKRE9oaFcwaDJsd3pHS1Y2bStxS2lMQUJWbFRlRXRZOXVDQXB2Z3JSRWhO?=
 =?utf-8?B?Umd3QlBPUTRzZGpiZ28xRVZ4M256emJuMkFBT1hEY1FrbGFsK3h0TXl6b2c5?=
 =?utf-8?B?akcyaTZncTVpbHppSmZXVU4xOUUrSmRyRmh0a0o1NnIrOHpud21JeWQvd0Vv?=
 =?utf-8?B?U2NoSjhUcndrNXdncmovejlqNHZNT01wRGJkZTBFN1NDRURKQjVsYUR4d3hV?=
 =?utf-8?B?SnY4N1dHYnhhV3h2ZGVRZEJFbE9KTVNPSS9lWkNLQ2dvUnY0NkZaRHdrQjJG?=
 =?utf-8?B?c3luV1ZVaTZYRG94QjgvOGRmZVIvY0NGQk9lekxkYUNUK3laRkxlZjNudjll?=
 =?utf-8?B?N0tUQjNKemxYUUVhdmZ1SzZWcVMzWkMxVlJIRTFBUG4vZXp0RFcxSnBkWUdT?=
 =?utf-8?B?bW13K2pNQmczTjNLOVF4c2lOM1VyMFpudG8vMVZremRFRmh6MlRLR0ROMjlw?=
 =?utf-8?B?eU1ZbHJrNnMxdmVxd0RjY2JJMDNNY09MQzUrS3YvVG1aVU5UcmtsUWxZQWxz?=
 =?utf-8?B?N3RGTVFwU1JOQnY0eGp5d0xsR3hNRnRhb3M3enUwWTl3bEhBUkdCL1BPKzI1?=
 =?utf-8?B?dTBVRGpFdWs0U1J4bVZiRU1YVlR1SnBYMCs4RlNsbXNJdXVVUUtCaUd3OFhR?=
 =?utf-8?B?ZTUvWklCMmJoTFVtYnpDSUw0VGt1UXo1WWNKUnVoOWg3Z043a1lVb2xaQVZx?=
 =?utf-8?B?dVp5UEJOelE4REhJNk50MEg3U3ZLUTliSXhkbUg4ekpGVVZZQmpSOHlpcWg3?=
 =?utf-8?B?TGRKaGpFWXAxQ3lkeis0eGtJL1A4TU1RQnFkcEk4MGtkaG8vL2dKK2ZJZFYy?=
 =?utf-8?B?UlgxbWtzNjVPSkZKVmppUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3l2VUhUSDRTRTFoeG9MNXE4ZGlYZE9qV1hZYkMwS2FaYjJ6cG9HZ3k4ZDUx?=
 =?utf-8?B?Mnl3L1hCZEc5UWtEeXVTOGpvS3NBSWhBWkk1S0F0YmNsd25jSUlaV0tJcE9P?=
 =?utf-8?B?NWdqQy85SnJwdURLQm5HWFo2djJ5bnloK09FdEhlTnhPcFFYZkx0WURXUHdV?=
 =?utf-8?B?RVdhUU04VDhJdXVsWi9HbmdPSGRRcmdubVcwU0FNbDErOThENGJFbEoxaThp?=
 =?utf-8?B?OUtLUHpFaGkwODV6dStCbTduVDlLREcxRllGMTROSXkyQy9uSUdLdVZIZUhP?=
 =?utf-8?B?WTBFVGRRa2pEUWZGWVlZU3VGZW1DODQ1QzVodWc4STFjYzJMUnVkOFZmanZi?=
 =?utf-8?B?NDJUY2V6S0F6SE9aT1pZdVRNRDdYTGVveDFUTzRneTQxNVh6aVBCSitObEZC?=
 =?utf-8?B?S2EvZmpNN01BMHE0b2lSRWdDaGQ1U1pVM3BUSWRCd0x4ckF4QU1QKy91cVlS?=
 =?utf-8?B?VlFvNGxaWU5UOFFZT0tUUFZGZkRJeEtMenZDWUY3aFZ2Q0hjTlU1TXRMeDNU?=
 =?utf-8?B?TXh2a0t1MHhmWExqZHY0Yzhxci8vRndPdGV1ZlAwVURNYmxwdHMxVldyL3h6?=
 =?utf-8?B?K25Md3FuVTNoSkZjYTk4T0J2MjlmUWR4ZTcrWVlNR0swem1xc3BNVElkTHoy?=
 =?utf-8?B?TUd5dTZGdGdkcThleE1HbndnVllWNXVaNzh2OUZ4Z0s3TkkyNk9kL2dBTVFR?=
 =?utf-8?B?R1c2eTNucnZycTdXbjBaQUVTVWpNZUdhZS9sRTBnRjJpYmJodGNqTXZUTHZm?=
 =?utf-8?B?V1JVSkJiMG1CdTRINmxnMXFSakZKVnc1dDBNWnZ6UmF1WmYzeGVTY1U3d2VL?=
 =?utf-8?B?bEdQUVhDdFVPdTh6cEZORTV4T1FGR0VMNDdrcHFQTUg3WjRCYTVMM0hLNVBQ?=
 =?utf-8?B?VHovNmFNNG5KMllleUhFT1JwSnJ5ZFdLT0J2ZmlidTRzdWtxK2k1SVFJZXVL?=
 =?utf-8?B?OHpPaW5iYncxaEhieDh1MnV2STJtdW9oVjhjOWh4Q2piQjhxdG9zRmx5Q1BG?=
 =?utf-8?B?OEhSaU13NVZTZm9KN3VScDYvZFFXbjFJRUFFSW52RDFGQk1xdVpadXNuRU5M?=
 =?utf-8?B?TThHMmVzVXJjSmlnaitjSmNwZFhlSTFUT2pyTis3WHhkdkp4bUkwME1DT053?=
 =?utf-8?B?VURDazJiZTdCTlQ1TU90MWMzNnljbEF1ak9JakF2aU9ROHRrU1JPWU9CWVNB?=
 =?utf-8?B?OUlLTUlGNzQ2a0NvU3dmQ2QzUEs4UjUxZWVndW0rcEl5ZXNCQkRWUG5sc1Fh?=
 =?utf-8?B?YkwxYmc4cVdnVzF3TU5mTk1NbXJ1ZmFTYkFJeUpzb21YNVZCSytnSjNZVVBP?=
 =?utf-8?B?WHpVZ1pWQndaZTJSZlNxLytMdm5ZcjNCbisxNDUrS1NSY1VmSFR1ekdtdXc1?=
 =?utf-8?B?MlphMUh4RmJXWDQ1RnBkSXlaQ3Rpc254ZFNyUGtRNFVrd054LzIzaWVRcDdt?=
 =?utf-8?B?QlVBTjR0VVU5THJUSEtTNUdZeHNlRkJyWTlrQnliaDlyTkN6dGEvTUhhV0l5?=
 =?utf-8?B?eW9VMURrSS9rZWVCcEtJMGRjZ0EzdTJzbTBrM2VmeUxiVlJtZk1xWWJlK1hH?=
 =?utf-8?B?amxlbUQ5ZmVPKzk4QzRGTDByYUIzck83TGRUUEkyQ1d1UWFhY28zKzhiM2Jl?=
 =?utf-8?B?anV2UjEramcwbnVXeUx0VFFLRDJpSHlJVE5QNkpvMTg3SnpydGo0S1ltWGk0?=
 =?utf-8?B?TkJWM1JXOTh6WFFtdkJJdm04WG03MDFrUWcxbENiUUdEaWYrbmYzQUFnWjY0?=
 =?utf-8?B?YWd2NVluN042N0NaYkZ1clR3djdjRjF1MUVOaTcvTnNDdDVxZ3V4Rkg5MUpO?=
 =?utf-8?B?NWlvUWpCS0grNzJOZzAvVjVVOXNicDIycXZyMUY5bnQzRTdodXJuT2M4eW9N?=
 =?utf-8?B?N3I0WnlxT21xY1lOMTFCTTlQUzVqdkx5UDB1RlhnK2phUFdxdVFiT3hsVWdT?=
 =?utf-8?B?eThDa3dJbmFrNHJROEJGYUxjNTRHUnVrZ0dvMk5Sd01rK0NuaWswSDhZenNj?=
 =?utf-8?B?N2Q0RGY5K2dXR3g0Y1BHZVhUWmJ4ZTRyR3JkdVpCMUo5VkNUSGdpQU5xZkda?=
 =?utf-8?B?alB2VTJvcTd1MTBnTVJGMFZYMG9sVndnbGl2b1k3V0VSQS96bWh6b0RDLzB1?=
 =?utf-8?B?Q0VWa2VzaVgwK0ZKMUJtSmlCOWtiRzVlZkYzTGJOR2FsRlZuRG93UkdHRFcr?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SlnEOgdfj2bM8ry+su25jaRmtJ12ytTVKfF1cD2sJxTe2GNbs9ynVckjnyphT871G86jjTlXJ+W7AJcLHiIJYdzfsq7TXe9LXyCCjnLf42ZEdNlM5N1NUjyPiMO30O6NKVaxdqVZbs8n/MbzTFMujUJHJP5AEJMjG5POOZLtXLHk+y9XS6i/IkiBDjjbCrgBn8ES5Gw81/4ryxBpcix/pDbtW5ZgKQkEw8FJGWkTn90X06NYQzWB0qGEcwNEnM/b+FyoZN301TspN+PJ4DLgYsW+hYam/D0ynC06h1DD6XU4bQRGPxGcjouat6KooXAU4k+kBRA8hoaPTb5oLkh9wgRn8sZwGd1xAOf3QKvYHO/54shX1h3E7KxjLKUZrOTdf5ViK+YVsWKX99dGK/7hZudffUsJtsR28HxebaFYtdi2UKOgRmRJvO/kX8E9y3am7AocRpvOXfwOGSf14vK6vvWtKquB1UXLITtKka1F/ErDYEj2gCgWoiyv3v5+itWk9E/g1UXgPZwo/4mZ91FEv/fWd+whGBlswX86giW+SISLCp2oUx5oQUoytNr9h46yZbQ2AU2JZrbc316btWtz6tz2ZeFd6bQqFVyZklPcOWE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b81a18da-db7d-44b5-7571-08dcb7248911
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 21:04:33.0433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9eaBtfkh8gZzMqRwrb8LG5Kz+UubMg5oW3PBeWLJ3b1hE35MUzDn6hJrh3AXcbNgwbi5A6JNz8uySTrtIJCzhDcOHHHn09oE7M5qL3k61pQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4142
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_11,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408070146
X-Proofpoint-GUID: 8YwRQKBRQN0d9-4BvbHOqDDFRFCNQWuo
X-Proofpoint-ORIG-GUID: 8YwRQKBRQN0d9-4BvbHOqDDFRFCNQWuo
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/19/2024 12:28 PM, Peter Xu wrote:
> On Sun, Jun 30, 2024 at 12:40:29PM -0700, Steve Sistare wrote:
>> For new cpr modes, ramblock_is_ignored will always be true, because the
>> memory is preserved in place rather than copied.  However, for an ignored
>> block, parse_ramblock currently requires that the received address of the
>> block must match the address of the statically initialized region on the
>> target.  This fails for a PCI rom block, because the memory region address
>> is set when the guest writes to a BAR on the source, which does not occur
>> on the target, causing a "Mismatched GPAs" error during cpr migration.
> 
> Is this a common fix with/without cpr mode?
> 
> It looks to me mr->addr (for these ROMs) should only be set in PCI config
> region updates as you mentioned.  But then I didn't figure out when they're
> updated on dest in live migration: the ramblock info was sent at the
> beginning of migration, so it doesn't even have PCI config space migrated;
> I thought the real mr->addr should be in there.
> 
> I also failed to understand yet on why the mr->addr check needs to be done
> by ignore-shared only.  Some explanation would be greatly helpful around
> this area..

The error_report does not bite for normal migration because migrate_ram_is_ignored()
is false for the problematic blocks, so the block->mr->addr check is not
performed.  However, mr->addr is never fixed up in this case, which is a
quiet potential bug, and this patch fixes that with the "has_addr" check.

For cpr-exec, migrate_ram_is_ignored() is true for all blocks,
because we do not copy the contents over the migration stream, we preserve the
memory in place.  So we fall into the block->mr->addr sanity check and fail
with the original code.

I will add this to the commit message.

- Steve

