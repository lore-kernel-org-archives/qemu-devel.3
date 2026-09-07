Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D12C79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 21:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3hMC-00079t-P2; Mon, 07 Sep 2026 17:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x3hM6-0006uf-Km; Mon, 07 Sep 2026 17:58:22 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x3hM5-0004KY-4t; Mon, 07 Sep 2026 17:58:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwkoxAPhgUrhf5ccZqxeGXMO/Q+lYFQJYplSVh1hcWwxWdvl/d4O7YgwKhci+3x4IxnWeFFUGn80+d6HeG4Ph1FaZ7ekewyCw8IBgUnyfJ+yt0+RenrQAhTuT/r3WXweGA60IdNF2XON0tGRD32aDtgZa0AkHYulEeMRyA/A3xDamR+HtvySZwlmTA9rKKBs2lRMGuIsvdXQZ5AGVGzlxcpZz0MSOsNa3x5xDR7nYvXG7d14InQcHkKclAq9A5WfcOKWsVew7Ja1ZxHeHEZTuLc8tghIDVk5vIgFFizgygcRVQU5bv7VfVdSUdPZMV3UQvfUL4R6MsFYXt7zZNYnLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvTpRP5viJ80BhgNEMm3gHf0q+P/M0mhvXfWaiRRhQc=;
 b=Xa3YahBZmWikAHtEUuiOOVBqKAwM4F4xfvUVgdnPjiYQA0NrALXeUz53ilFN7cBEMK0qb5jlT8fL96Gs6Bmb1w5Ohs1zMvkdHGuo7NFI6cbWg84eiWFm60UMMdEOv4xqAR4Gah0ZBQ3yIbeauPd86IAR3CsQ+UJu8YAvEdIREnSFbIlTqru4B9VZDhE0289zzLuGrW2qAqzXj2nkG4WmwnMZc3GsL1izCMyCrbffNle4SJ3UZzUjZE+IEpbHkgCEK4gacvpjEW0RfP3x/jbJ1s4eqjDMs2lgOKq6CcNeJfybfvKoytgpsfE7pLO4XsJVKPVYaVyu8U4ZAPb0g57u6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvTpRP5viJ80BhgNEMm3gHf0q+P/M0mhvXfWaiRRhQc=;
 b=0dq/ww7FLEzva0lPgSNjeTTmOcIvUwSUdlBrfZkdXmzE61SfL7PzmGi8/+p8C/VQVurKB+IbU0b28UBsnqp/3prYSBSuPph4GFMfKtkuORLuQy3lbY5ZAN6oTjh5TM2Dm+XqS+gFUxIST2s3hYznEuJLtWZWPCGxYXH/Nd9lQ1KJ7pjV0UdMF+YAROLusidFMKLQIbNe0Er8rkf1ffSdEDr2BGB+b/nQXs2lCYNpBnuDFQC15GaMlINu0skw1pzsHjtOvIceejj8v6Zxho34NhHwZOXNu3EEdbpAk4/WL+KMdfkozevbcQLgpyFpwJltIeN7piY/PIkv05D/OJ7peA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DBAPR08MB5733.eurprd08.prod.outlook.com (2603:10a6:10:1b3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 7 Sep 2026
 21:58:17 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0406.005; Mon, 7 Sep 2026
 21:58:16 +0000
Message-ID: <c2af6161-2763-413f-b06d-4ca35af8a34d@virtuozzo.com>
Date: Mon, 7 Sep 2026 23:58:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] tests/ide-test: convert to QMP
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20260907-nohmp-v3-0-c11e7d0d3d7d@redhat.com>
 <20260907-nohmp-v3-7-c11e7d0d3d7d@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260907-nohmp-v3-7-c11e7d0d3d7d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI6PEPF00000234.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f0) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DBAPR08MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: d9d578d6-f5db-4f48-acb2-08df0d2b1f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|10070799003|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 74ZfGgorp7KGgUrYZZUeIRpv+l1i+Z4fHlZwHM4JjTZhw2CoSjgwBmFt4zSZ3mDDwHYa1C0lhoPBiJqj6Fk79DCclEWuDSq+/WFJ02MPW/weZcYokhIirqCkKuvsziDVn8IJdN1LTgc+b5hx0d9vL53N4C6GbSo5jQRnHPxYA2ERdsajQsgRvwcQVnh4eJiegqXiRZcaVV260RswqpPuWPcbS+tSrxHTuuvCSRBLthJESzNc6AITYprFz7QzFdQbmEO5fc21FMy+V1Xw6kgxZszIIw6GdFfPBtoqrOAu27lktZ005TcJOepjwdPBF2+mq0Bmkh+xvTALlmtb6GVxYpBiEbhh3t1SLYzP7BK4/277wdlTxNfz8fOqsdPBYsWX6zenRYrH3VxV9Lw1ESgYO05tPOp1hZUJIqY2i9cF/RlJVZ6Ja5S3Y8UaGTIu0l/MUb9qQ//a1l6+ZPLCnH/UY/BlUqJLpAqkz2wsow0wJ/nC2YhNEHwhb8Dp2xyS7ediDxt9I8EW4oy1rcLWXT5VKezKEWFxD1uwxnJmGjRJGNUrCnkS4ORxXTgf6eSdAc+Cg80hn8Zi2i9vVWFJ2flXDvMBinXw7X81X4IQj4LsqNW6ZG2YSoOS8PA3EXz5+jwASaALTCWHgXZLNz6Dy0K9hTnZzs/LGkS9zRTHqMZ/GoI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10070799003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REJ1VVVBNUkxQk1uWWFzRTM4cVhOR05RMVNNblZPV2puSmU3UE9Kck14b0dh?=
 =?utf-8?B?UHoxYXEva1lkQnNMalVod21IaG5FVHhuUkVhdklvU1FCU1hya21jdDNyalBk?=
 =?utf-8?B?SWxWWGFyT1Vxck1qRlpRcGR4bEpFOWhFbFhPWXNJWEpwTlUyTG9lOFhva1JV?=
 =?utf-8?B?RXp1MEcreVUrYlRiMUFVYURHREdBK1lVMFVFMVIwZnYyL0RDSWhCVVdrRnd3?=
 =?utf-8?B?ZkwzTjc3dlh4ZllISk04YzEydEcxZ0hzdm5yZUpYaGczY3o2ajZqRUlNb0RE?=
 =?utf-8?B?RE91a0p4VDFpWXgvajRRNTFhVGxsSExoaE5acFh4WmxxcExxczVPa0dCNEZu?=
 =?utf-8?B?a2l5eVA3cTVQSmxQdWRkQlp6cmZCS3lqMkJmV1dXWjJldWRtUGFnd0M0N1JM?=
 =?utf-8?B?a0pqOXpHREQ0SHNGb2gvYlpHdDBjelU5S1IyUlZNbjgvM2VzWEFibjhHRnly?=
 =?utf-8?B?Y1Z1WFNBVEdBd1pWOXpTWk41ZE4zWWVRRXYreHVIRzhSbUFqenI5YS9oRVNZ?=
 =?utf-8?B?YkNPditDMS9HUlg5UGpMdWE3ZlBNR1RKVVpzZFgvUE1DQ0ZBWUFxNC9MdkRM?=
 =?utf-8?B?anArVlk0OXR4WThRMEU3ZXA3Q2JXQ0ZOdmczUnBKdFFITjNkeWVVVXM2bGJ2?=
 =?utf-8?B?YTdhV1htK3JPY1FkV0pESU5kZXYrQ052TUtLMWczNHZ2OEJwQTBBb0MyMlIy?=
 =?utf-8?B?T2pjUGxTdkI2RGNqNmFjaHdsdk1ia0RidndGOGxsbS9LSUVTeFl1YTdEa1Bj?=
 =?utf-8?B?bWlQb09jbTdkRktwejh1Yit3aEQrc0l5aTRVWGRsVjRYUWw1b3M0eWxqUnpM?=
 =?utf-8?B?NngxSDhBQkxwa2Z5SU8yU2x3ZG4yUWNpZTFBYUh3MUN2bmE0VDVTamVwQlNV?=
 =?utf-8?B?WEltVXV3THJjT0JURDdMTk5Xa29nZDh2VHNucTgwam9EVkRhczB6TlFTeVA4?=
 =?utf-8?B?KytpNGpYUEJLYlFnNUM1aVdZWDFiT2NUNHN0dkl0eHhSRkFvUW9ScWJaNDRC?=
 =?utf-8?B?M0drcHlCRVAxa21VT1lMNkZYTHVZenQwTmM5WXQzclZqUTA0MmZpOFhKZUpF?=
 =?utf-8?B?OHhYajNVcWM4ZGlRdDBRVFFEZDNSZjhDVmI5ZDFuZTFkZHVZcmpPKzNDV3F2?=
 =?utf-8?B?c3pIcU9BSkFlQ1hrZTFFUEhaTjA1VW5SUW5kV0NndFBPYlUzTXVZUlQ0VmU0?=
 =?utf-8?B?cnpSYm9lN1E1MWMzMEYwMGtESzNaSHBUMzk3Q05SMnZEY3JheE4vcmd5MTBr?=
 =?utf-8?B?c2hqQklRS0NTS084Y3ZyMERUcjF2S2wvaWZNMis2bjliYmRHVXhnanZwT1Mv?=
 =?utf-8?B?cWJhVmY3M05IMExvODNNbndMRXZjWWlLejBSTzRCS3BQSElkS282RjIvRWw2?=
 =?utf-8?B?WTlreldVZWpDWC8zb2tyOFNBRVpzWDM4bTBQQ2hpWFcyUWc0KzdleHNMb1p4?=
 =?utf-8?B?elNKNm8vcmxLRXE0dTV5QkZyQ09qZlduZkJTZVlsZkM0S3lWQWF4TjRINjBQ?=
 =?utf-8?B?bmNtYi9VTG42THM1cWNJdjNsZzlHalVQYzUwaXZBaWRvWkZqVzdwY2N6THhq?=
 =?utf-8?B?K0RpbjQ3VVl1S0tmaUcvbnM5dG9Rek41SDI1NXF1bDVoQXlReWFWU0JZNWk5?=
 =?utf-8?B?UEN4WlZ4bCtsc1dWY0Y4cUN3TTREVVdTYWI0UFhGWExia3ZMaUtFckhwOUNH?=
 =?utf-8?B?MG9nZzYycjBibWx6MDh6V0U2cU03Sm1QUGRJTlZHTDdZQnMycGJqc1B3T2J5?=
 =?utf-8?B?aXZBajMyc2FjcDI0Z2hSQWhRV09JN2hsaW03UnJ1VGFjNDd1ZGhXRTNhRlA1?=
 =?utf-8?B?MStCL3FhMURyNEI0VnFCZ3ZyYVBDZFdTWUlYQVNIWTdCRTBFUThtSU1tT21P?=
 =?utf-8?B?ZzNqcnV6WUFvcGpTaTVoZVpQWlhlYk9RVW81c2xpazl5Vk55UjhySDJORlo0?=
 =?utf-8?B?a1dxY21qVDJKS2R2emxvdHNVaFV6WnJMajVCMSsrZW5veU4wZExzVUh3L3ZC?=
 =?utf-8?B?cjNtOFhVV3ljOS9Uakp3TjdkeTBzN0ZDa0k1TFpMZXpjK2FaMjEyWW9uTURa?=
 =?utf-8?B?RXVURnM0TzJNQWZpZTBpZDF3TnMrRXNVTFpRQVNDU2FxcnlPbVE0UVZ5a0VY?=
 =?utf-8?B?WW5UYjZtUWIzemlHa1FVVFhCZXJpaXEyMzZyd2pqT0g4VXZwclA5eDIvaXph?=
 =?utf-8?B?Q3FnLzdkRHNsWWJNNm95MlpQRUQwdXJDc29UTnR4UEhBT2YwUjllMmV2enky?=
 =?utf-8?B?RU56aTBJTjhsSkE0VDZMemcrUU45QzJvNUI0bWV2TEszVmw2RENMZ0NPYzll?=
 =?utf-8?B?SWV1aktvSDVBb29IdC93aVBCeVpZcjdzazhWVG9SaVk4bzEvM2RJbmN3Ymw2?=
 =?utf-8?Q?nKhdBL3SrWKouOmos5NRt8HdO7tNMo7wxLYzkKG31Iu2g?=
X-MS-Exchange-AntiSpam-MessageData-1: TmJJZN3YPykJxQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d578d6-f5db-4f48-acb2-08df0d2b1f09
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 21:58:16.6134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhIxCuTKJFiVufkqDFHjnzkgWbiPEEeRdFlz+uDkEHLN4Y9cB7T4DBN/gP+djgRKf5KxBMv0E5RO3KVIGRbI+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5733
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=den@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 9/7/26 15:14, Marc-André Lureau wrote:
> The QMP command is explicit, specify both the vmstate and devices.
> We use the helper introduced previously to wait for job completion.
>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>

