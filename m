Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88D1CD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 09:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSX4C-0005Pf-IC; Thu, 28 May 2026 05:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1wSX44-0005Fa-0r
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:30:12 -0400
Received: from mail-swedencentralazon11023124.outbound.protection.outlook.com
 ([52.101.83.124] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1wSX41-0007Ov-CM
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:30:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjRcyo99vX1xv2jX4rwmM7/jrQeyFFWR9pYFmfN1OCdO3KnRc/+7l+kuSSAqhcehhweST/vTP5wCz3vvRqnndzRcS1tM/SzMZl5d8xgYvE/c9FbI3HSVTyUEPcS3O0B9sTrDAe9qWHn497eijgjM6zjbdlUFrJ7qcUCvr3GZZ/lBdFzKi/ZySmPFAXIidE3/ecJmHk4ttT6rXg+D4HairoMTJeFnYmyOClewNBYPHAh6PvxfhaLB3xSN848sC+Or6ymLwcjn7Htax6ov97JvB+ewbcdFdQ1uOTCQKkYfrUEFBLJ5YoApvprP3iB9TsnZLsUmuMZ1mYSRQ8pUA3sDTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwlMjuRpOGH8Ss+2AUfHiFoo7t8qKJkF4J7UnhdJjPs=;
 b=OvqUdocnoFc9Jm10AM52YxGc2eaaM/JrrfzoZkHScNk7sTmHC0lYJtNIC402NBiwxCxgahWJNyM8tESe2uZTOHkxxnS3DEV7Z1PU8dlAgA9odeICoM4mwh0T4nR3kHYrtEiXbL9V8LfgjrAn3mjvodo9oigUWjv9pZVYizY09KmB/TVmqGahLQhF7CRPPLCfwMLjmJok4mY20lfZQF/F9ZI9NS2ETSI8LUeKBW8FP59xsS5tcHsHbrZj6OXkldRgQuwxpgXtwB+g6zHJYqsRlJWpiWZn9NcfG96AAGZDiLE45t2O0oW9C7khLvqMvWAhCnN63yvfFo+sWbtcJCCKRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwlMjuRpOGH8Ss+2AUfHiFoo7t8qKJkF4J7UnhdJjPs=;
 b=HwIyBLu0OdW4Gy9Xsa6JRPb5gS+vEHKGsYyX5a0s328JpbudajU0r587HTLpZ//3bikejDbRBp+OQOdPCIz2SfVw91M2KVQTTaeuVQZX4RjmkUDoUBH/QGvi/Q/N1BCgeVo9CQ/XKkUTyal3av8VbqlqaTCCueWH1RYV62Sb7WszURBdERJ884LqEcXR8R+JDypcQSU7/+WlcJymKK6+jebWhEU/rK7x7NFso0gT/Tuvn77Y9Rtd3bkNVVOVOycqbzFIaAWXL/Qz04fZifAiU5X4oNzjBp17OKKkiqN35rGQyluslNWdKKujrB+tnlBTO9FD7Ry/0eqX6toQIuBQNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DU5PR08MB10400.eurprd08.prod.outlook.com (2603:10a6:10:521::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 09:24:50 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 09:24:50 +0000
Message-ID: <266801b3-c127-422b-be48-d898a944deca@virtuozzo.com>
Date: Thu, 28 May 2026 11:24:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] util/envlist: fix prefix-match in name lookup
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260520212628.479772-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260520212628.479772-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0016.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::29) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DU5PR08MB10400:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a8709b-47b6-4474-ae41-08debc9af7d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 6BBHsxS3fJiJyWL6LdDV21OsU5+ZE4Rasl4mGu3KB4iiwiJWT1d29Fd7/pGh7n59EstrKB2D5kr3TSKZ4l1iA3WC5gW018IVJ4vQEGeCibVfgtpzs0adSy1mOFeJY5QCbPL7bhkOT0DbpKjumOZ9nRpCqb1gs+GS3myfEHx89zi0qYLoYE9hZepUxwgS31TDzMSZMeIKXJB8zeWSj0yyJopHB38bR7LfldhiIN6bQkmMXG0V7pDU27YUgGWxHRZZzyQQhPT8lG5jnS+MqsXCjb8nCcAGE+bCTBO2zyN8K6nRzF5PZK2VclSNBKo744VgSeZgaLP0ZLkIy3SwQAudooes/2v+t3s/1E+7HzWyW5qGBHmJ4XyIOGCiQ48N29sxq+BqD840ekj7k+b/i9JDH2qdoaYPlvGfFFOiO5cReTWJJrLUfeHhHmrDaaekT+rBkRrFiOfBODo+xF8kPlc5UVoKk2/CLOtNl5OMNuJsilH6GOTREWi3X1kbRyVbbOCt4oB8Lni/fmXjl5tDGkHv4VVsjq0MCjzYVUDN+ARUBBRsqykbwQfDAjldyBpbCoabyYrfNM8x/90UJuJ8+3JK+I8F81XyzppxFWczz4MnDtIHhYaapN9OzigL6oQ4wtYumdBs2+xlzHjhOg18tvMO6mzofR6Mietk4Gm4NxNk4rosH+5nZs2l/uR2GsY+hamx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3hxRlBaRnptajljemFncU9uMnhHU05BSEdyZzlMVW9FVFlaWnVmWEk4YVVn?=
 =?utf-8?B?UnVySmU1OGJQWStVY0UzZGdiZXEraFo4V2YyVkp2aEdPeUFEWTc3ajlPRTl1?=
 =?utf-8?B?cVhMZGN1V1FGb0x6OEN2aTBhWWVieW1DaGpBQ2kwbWh0eDZSM0s5Q0RHc3Zl?=
 =?utf-8?B?WERGNjNOTWxnamRnejFmUUtZKzR6RHNOVUxnZWRzRkhTOTY5cU5Jc1hsL2V3?=
 =?utf-8?B?UThOVEZ6azlNa2pENUE5M2puTXpkb1loNEFEN0g1T3IweEJ5cUR5dWd4V2VZ?=
 =?utf-8?B?WlhOTFI0bGdEUmFud21XaEVTeVBsc0oxdzhZa1JENnNjOG0yYXlxQWNpRkxJ?=
 =?utf-8?B?d1gvcW1PNWc1ZUliTEZkbzU5N0RyZWx0dG1JOG1UMVZaN0dyVFZLa29VWlJF?=
 =?utf-8?B?VWUvN0pKWTNPSDA4MFRnSE1UYlVXUVNNdEpSZkQrQ3FKcks5cjYvM1Zzb2lV?=
 =?utf-8?B?bFB1d3RPSDR4bU8rczdYU05YQXVUZGZjbDd2NlEvVkw3WEpxOGJ0S2t0WGEv?=
 =?utf-8?B?UnNyVE1kejFyS3JNcW8zNC9vNDNEQW9vUDRRbHpyN0l3aGpQcGcxWDZXOHJn?=
 =?utf-8?B?QWZDMVhBMTU0T1VUVnpqRXd4L3E5Z05CeUwyVHVINVU4aFV3dENWWmYzelk4?=
 =?utf-8?B?MERLQ1hDUVVOZGJTTVZpZFlwTVk5aEhxUFdOeDNmR29CSFF1ZTNmcmt5NHR5?=
 =?utf-8?B?RFBmam5xS1oxbUZBQ1B3a3B2RkxjZFRkK1dWVDdhcVM1VjExZmE1S1ZCRVEr?=
 =?utf-8?B?K3R2b0ZmUW1yaUFWbmJoYnp1bXpGaEFKbjM0NUNIT1B5YWxRamNUMVdmd0cy?=
 =?utf-8?B?VXEydXRwNkczNE5FelZsT2FwSC91RTF1YU9kMHo2a3FBM253QzlHRDNQWkNv?=
 =?utf-8?B?eFdWd3VRSk1TY3l3eGEvSFNDSk9nRFQzbFcxWnNpNHpKOUtpYkRXTGhocjAz?=
 =?utf-8?B?T3ZwakxQNUhpQ3FyYkZIbjVNTnBoREI5WHVENW8xT21mOUIrSDhhOEdXbXdZ?=
 =?utf-8?B?Y1pOKzdmNlJiRThwa1JVWDFCb1ZHRTBzMWdNc0VRNDdad1dKME4vek9QTWw1?=
 =?utf-8?B?aDY2eUFDZnJnMDE4V1dZbGgrSzFvNVhOMk9FQWtSZTFtWkxGK0plZGd1TEpG?=
 =?utf-8?B?akgzSGNZSzUwY2J6MzU2WCtVb2c3Z3pxeDVsajJldzlobFZiWWUyWGkrZmZQ?=
 =?utf-8?B?OVVOV1VJeURNSUYzR2NWOSsza05sWENIVFVQZmNwY3IyaG1OdmZzYnkyUTc0?=
 =?utf-8?B?RkF3d0xWSVdTTmRvOFhMQVVZaHA4VHlMNk5meEpmOUpIUFpIaTF2cHZPSVor?=
 =?utf-8?B?RUlCVGQ0M1N2WHlET1BsTGVpRDRhWkI5SnM1cVlKYm92WFVMeWFnRlNET1gy?=
 =?utf-8?B?R3lEeUNZQzM0Q3h0Y2ZiVTVKVi9iWlp1UWNHenJsR2xibmpmRzFneURPNVJL?=
 =?utf-8?B?a3ZRVEo3VUtuckQ2UHpqZ01HbStsNjRBaDJ0UGdpNWxEZlNheGNrVExLV09S?=
 =?utf-8?B?bDhTOWwyU2o1L3BORWtoWnZ1RHZVQXlneWx4UjdRaHFpbXdDVEJzdmthMzB2?=
 =?utf-8?B?WEVjcmQrcWRIb1VFaU4yYk9IMTUweVB3ajVaSStJUjNHSWhRY2pFUjZQUlBJ?=
 =?utf-8?B?NzUwTm93dEkyNVRFbldQeGpFeHFPbWhzSGMxQy9LVVNETWV1dkpITFdmeHRq?=
 =?utf-8?B?TjliZ0lJaWhtaWovR0I0eUpGaDc0aHdtMHBOdnNmZUtPbzFReCtTWWZEaUhs?=
 =?utf-8?B?VHhCbEhiNEErQjZOc2ltcTlzZXdVOHJFNFBmRklMajFQamF0K3o1d2lrc20w?=
 =?utf-8?B?Z3VoSmlUUlRSYVR0RjM4K3dyQjh6Slp3YWFGTmh6d0l1SWoxb0hHUGVkaWl4?=
 =?utf-8?B?bFduWE92NFpad3VIbWgrM2lNbDZZanF5L3U0RDhTRkxBVUNNdi9oMUFoOER4?=
 =?utf-8?B?SllsN09qeFF2aWVFZHpJV0ppaE13MlJOamkyWHViYWlmU09mTHdkU25VMTZk?=
 =?utf-8?B?WFhlc0ErQ3IycjhDMnAxQ2VXejUvTFZraGErRUlYeUlKT3BlNkJGMDdTTnBH?=
 =?utf-8?B?TmYreVdySnRyRkxxeUJFeWZTUmd0OEU3QmlMS01pQXgyanRGMDVVNWpZVnZY?=
 =?utf-8?B?QTAwN0tCSjlNWUt5a2VGTlg2SnV4Q1dIWXFoRzRWS0N4b0JWMTdOWU1rZzVr?=
 =?utf-8?B?M3BUTGlBdFA4eXdNYllQSk8yaFFxTlIwUDBUNzZ4cjVObkdHMWsxeGtUUGhw?=
 =?utf-8?B?QnNzK2NKcW5VdFRzcXJUdDNLVHp1b1gweG9YMjVWbG5NTDhFU0h1WlRaZTNq?=
 =?utf-8?B?T2Q5NTR4RGp0bWhKSDhQWG54emYrRTZwMUdoOVNjQUpyeVB2Ynk2eTZiRlJv?=
 =?utf-8?Q?cOpHL+1UJhqA2gFhlFZ61xtu9uVJLYBaix2jYkFhLHvJ3?=
X-MS-Exchange-AntiSpam-MessageData-1: VlJYltKgURjkpQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a8709b-47b6-4474-ae41-08debc9af7d1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 09:24:50.3714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WW3XpDwTDRE5K8FiqP1BUmTB8hV8LQPOsCn0HaLz2LCD2eytJZ+Fvpf91ZUH+8wPfxXrGByJOtks1q7wA82Flg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10400
Received-SPF: pass client-ip=52.101.83.124; envelope-from=den@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 5/20/26 23:26, Denis V. Lunev wrote:
> A bug report against our downstream tree turned out to have its root
> cause in plain mainstream code: envlist_unsetenv() does a prefix-match
> lookup that drops the wrong entry when one stored name happens to be a
> prefix of another. The downstream symptom is specific to our setup and
> isn't interesting here -- the underlying lookup mistake is the part
> worth fixing, and it is reachable from a normal qemu-user invocation
> through the -U command-line option, so the fix belongs upstream.
>
> Patch 1 fixes the lookup: each entry now stores its name length at
> insertion time, and a tiny helper compares with explicit length
> equality plus memcmp. envlist_setenv()'s self-search was accidentally
> safe (it included the '=' byte in its strncmp window and that '='
> served as a boundary) but is converted to the same helper so the name
> boundary becomes a structural property of the entry rather than a
> property of its byte layout. Without that, the two sites can easily
> drift apart again.
>
> Patch 2 backfils test coverage for util/envlist -- there was none --
> in tests/unit/test-envlist. I verified that the regression case
> (envlist_unsetenv("FOO") vs. a stored "FOOBAR=...") fails against the
> pre-fix code and passes after the fix.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
>
> Denis V. Lunev (2):
>   util/envlist: fix prefix-match in envlist_unsetenv() name lookup
>   tests/unit: add test-envlist covering setenv/unsetenv name matching
>
>  tests/unit/meson.build    |   1 +
>  tests/unit/test-envlist.c | 196 ++++++++++++++++++++++++++++++++++++++
>  util/envlist.c            |  19 +++-
>  3 files changed, 212 insertions(+), 4 deletions(-)
>  create mode 100644 tests/unit/test-envlist.c
>
ping

