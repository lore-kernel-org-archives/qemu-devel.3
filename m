Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0739CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENsh-0004ak-79; Wed, 07 Oct 2026 05:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENC5-0001Dn-OB
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:23 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENC1-0006j4-Fq
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsEm9VfEqOSCBMukPASKyYIRIH1wIbNzIRqL6cfy7+QY+xIsdQSAKROHANdNqzQIC+BIBHUU33G5/S5VdPnITUY6GWfP8NOg22gls0HiJTC5IDKtC+H9/r34R1uxFTjzgfRpe1MgsVlePtOuLhN5HBST3UKMvU+HYPOt7OC7fjJ1JUhVEGF0/KDnLGxDNllzDehFmHZD5s2eWBNrM6EolHeTGr3nvtFBEToRP/OvoCcgwefurhC0pDWFVuShJ5d/o/ibGxORstMYQI1BcMFpqcxb3Qx10JRSWjuLelOc5I8nNR5fQCYovn0lediMh8GH+LvEmrrm8oE7Q/VDlnE0rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9yq8EKPS6NjEkTsAZuw4fecmzOMCLwBXNUzcIDBGI8=;
 b=QlgmyLGvxlsj9nd5G9E1ljICtbjNinio/6PL+Vdt/vCG0iwoklG/nifeHDqbMR0+L1lczZkarW8iQ6uP5KmifWaK6f7YxxXxPBGhAoJB+PU4horCKfkn8EDhnq+KqU22AJ02LC+U9DdGxmud7n+ePbxg3aumEZY3FjRkkbtub8iIzhvXqhP1qKqLJF6/EvJtDbsiuWVu7zzieGbytpGq58G7POS4yoGQ+T6i2gvTaItTjo3eI7HX98CKshNGIhqdFxOu4EZGO418WwE1EBBlyKqLft67jY1F7DeMg6BeqY5L0JMaQI+wM26DBgjlBIm5RfJwulgShIRhB6PYMq4eHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9yq8EKPS6NjEkTsAZuw4fecmzOMCLwBXNUzcIDBGI8=;
 b=GqpypQOO8dM+mzg2px4pncZSQi7cU07UZtqXIA8bV/Xx687YEBDO63+gXetStyoK7KGGroUPvoQ6v0SeZRQ8qMv5+cFKzXBmMqCGaUn/jGHaETL9wjWc0MxZa/8ktXsV4nwSDLEQE/lwew1+Z0RqjKOSYri8XQDeTlAv2GKLqi6/Ba/4SOzE0GmwKRPCVjG0KFVrS/Cqtd5iTtzchjluAIMKrsU4fXTYJ59tmHBS9U8qAgGiVOUajiDdaJ4XkTxXtj2jDVbOMNcB57P+Fqli7byPjd6i8QeNJfYu2Gdiib0jsPaA/6wSdGzZ7PxEqI1Okbhwamii29efHRqlTnlaWw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM9PR08MB6292.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:39:58 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 08:39:57 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v14 00/22] migration/cpr: support vhost-vsock devices
Date: Wed, 07 Oct 2026 11:39:53 +0300
Message-Id: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFkFxmoC/23RzW7DIAwA4FepOI/JBsJPT3uPaYdAYGXTmiqka
 GvVdx/ppglplrgYmc/YvrISlxwL2++ubIk1lzwfW4DqYcfCYTy+Rp6ndsEECA0OLD+feC1zeOf
 1MJeV14EHY9FLlzDgyNq70xJT/ryjzy8/cTn7txjWDdoyDrms8/J1r1qHLe/XR0X47QCf0CghB
 +uSsk81L+t5vlzmxzB/sK1G1b0yUIpuipokejEFPaaJUkyvUL1W0xQdk4sJpAxyoBTbKcJRim0
 KCh/azMBbNVKK6xQJlOKaEh04nbRwxgClIPwxCIAUg9AcG8Apq2R01pMO9o4gHdy6smkEN1lhJ
 DlhFL1DLgrFtilALaSDoC05HZS9o0lHNkfE0dg0oTfx339ut9s35D94LwEDAAA=
X-Change-ID: 20260908-up-vsock-vhost-v5-c781b39f1c1a
To: qemu-devel@nongnu.org
Cc: dwmw2@infradead.org, mst@redhat.com, vsementsov@yandex-team.ru, 
 farosas@suse.de, peterx@redhat.com, dongli.zhang@oracle.com, den@openvz.org, 
 andrey.drobyshev@virtuozzo.com, mark.kanda@oracle.com, sgarzare@redhat.com, 
 maciej.szmigiero@oracle.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000236.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8ee) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM9PR08MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: c37241e4-4503-4b7a-be7e-08df244e9131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|1800799024|23010399003|38350700014|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: TN8v+08S9E9nS8mS4HnYdw8RZpZnFgMy7QeKg2l8FEBskf6XlGAYnFJv58Z1FF5W4c781MaMZnFAtWxqqG0+6fO/MtKIZvSeA86n9njNawTAgD76eq9YielcJx73i2cyYX8a+jqMfncNoqljNkCYs+C91AWkhtry4awh3Er9lt9zMcuMMUbSmn+R42Mt17yaEwz2of8fWV844M8+uOs3FJ7dwDNqc1zbxjwaMF20GNM61RrtmNMRdZjfRzaVPn7UVyfi24FeSc0+4QGgPgXHEgpvbw1e4ht86yzSMZEUjEWZoUDVemYduu2J66TKfZsJzB1o6WzSB5oP4vr0Kz5McvbDGopOH2IPNkWO4PqdtYEYcMir8reVbQv8NMq7rFw4ug6mZi3tBC1hUlhziCDI5fRDEJX5HZLz6e/8ZMhbBWhLgYajx6GI8ro60+J+Z0kWpIIeFsUbRsp8gEvmQ8wSodR+8yttUPwMGSJX5F/8917czNNW4mXw5iBR5+CURJHtxvrgMWRG0v1to5kDMvIzc6rLa1/9jRuS06hlzMT/cj8It677pyc5mHdQk6MOlupfhbUNqX/vB+gd8KkxzYACi3LRiiNhoBUYiQ6Qd7oI+JzhqdNVNnrdhvxR1XuvMSAn14qVPC0mct1zd6sVjGH/TeP9k3gKGMxp0fGIy2XchOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(23010399003)(38350700014)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXhSZWxJRkdBNXIxTnEzSkliY0ZGbk1nZUN1QzVLaytZOGxYWDRabmt3MWFW?=
 =?utf-8?B?enQ3ZGg1QXMvTU5Md1VpaVd2RTJKc3lxMnhVRGxld05ZNWRRSTRRZ2JtdWFX?=
 =?utf-8?B?eXlLOENJMzAwVmVSbGJOSm14cTg0bCtqbFVTWGtkMVdRKzVLRE9VSndKdVl3?=
 =?utf-8?B?aS9ncDloN1Q5MTBhU0IrQ2JZUmlMSkxaYXNtZVV1MUw2elMxSGlFVzNROUhL?=
 =?utf-8?B?L0VRLzJYRjdmSmgxeUhDSWNoaGJSc0ltQmtFMTg2L1R4UjFqdVRabGNETkxB?=
 =?utf-8?B?QUZ4dUNLTzgvT2gyR05nT29iN05ZcEVRRlFKZ2FJTHg1VVFseTlQTDNJM3lz?=
 =?utf-8?B?eU96d0xCSGFDZHVwbHpWaUJhbWJGbENtV3c1UU84RnJEYkxVR1QySWw4cWll?=
 =?utf-8?B?R1Q1dHJDRGxXL0NOWUdycUNHb2NqYWR4NjE5cnV1UURicmVKN2M4WUhZSHJ2?=
 =?utf-8?B?cXhlZzNkMWd4c0hVbS85clVKQitIQjVpaW5lN2pmd0o3YndFSkk4S3JCOW5m?=
 =?utf-8?B?cWhJNXJTYWl1ZFBUU0FqR1V2YmcySjJjV3NuWjBPWUFqZjlzdEFtMWJDTWgz?=
 =?utf-8?B?b3dGcVhqVU5EcnJDcmZjT1h5RG1sZ3JJREhpcndVSEh4M3FKdTRrblUzTElU?=
 =?utf-8?B?SWozMHFqY0hERzdTcHBwY0xKVHRGdXVmNTlVbWgxN1J2aGREWmtqaExlOFpP?=
 =?utf-8?B?UUdkektIYjVIWGc0SWsyN0o3U1pBejdIQk4zOHZtTnNrajE4T3NCc213VkFD?=
 =?utf-8?B?SjU1d1doZExQQnRCZElrMlRjVFNPeWl1NmovRmxXaHR5ay9aNWNFc0l4WGR1?=
 =?utf-8?B?MVlyM0VJbkZwSE12QUswN1RaUlloNXNEY1dXTmxrSlQ5bUpuMUUyMk1xQlFB?=
 =?utf-8?B?bkVjN3dwQlpsYW5UN0dwUnJXaFlCS1dmQVVrOVRDWXJCUWlMVnl1b1VzQ0Vl?=
 =?utf-8?B?YVg0b0FzTHJiV2tNeVFhQW55c29NcXN1UVUrT1F1L3ZvWFJUZ3lrNWxxRlVn?=
 =?utf-8?B?d2c4RytLUG5NWk92dE9LSUVzQmozUnpJWUlETzRHWml5N2VsL1pJQkd2SXpD?=
 =?utf-8?B?d2ZGYXloQzBhWTJsZTRNQm5GQUN5ai95UmZNMG1FLzYyRkdjZzNEY0VnamMv?=
 =?utf-8?B?cm56WlRaM0VhbFZVVXg4eENsNkg4Rkc3T3Jha3R1ZTZYYXlBQlpUYkt1ZTM5?=
 =?utf-8?B?akpFMlpGTUN0S1VzRTBRQi9sd3ZjMktUNkVndGtRaENJUis4VHpxS3Y2Z0NS?=
 =?utf-8?B?Z0VRVWVSaHdneUo5SnhtOTFXdlZXYVE5bmV0UkZGL3NaRWd1UXBCekllL05T?=
 =?utf-8?B?azl6WHFJY0hNUVU1V3NKSHRzVjZKSmpkYThXOHVHaTFaby9DcW1jQU44bFUy?=
 =?utf-8?B?SHJISFdLS2NGcDVhQ2ZHT2N2WkduKzk0VGxtbGFQT2xqSkdXTHIzbk1ucURK?=
 =?utf-8?B?V1pvQ1Mrb0VvSk8yaEFIUHpzTW5VM2dLNVJZMlorRFg4UFgxYW1LQkFybWR0?=
 =?utf-8?B?Qk9XdCt3ektBQlBueXZ1NmJUNksvTU5lOTZZYTBFK3g0RG93SVJ3eUpvZmN2?=
 =?utf-8?B?R3ZuVmR4anRmYk1GOWpNOVk0UTZJTGNpUUlqdzBIMWFFalUwOWNnOUVpOEJZ?=
 =?utf-8?B?THBjemlpRW5aYndaTnc3QXJPZXEzUjdnV0Y2MVlBSStBUCtBL2VqUURZQ3pq?=
 =?utf-8?B?OGloQndZVGdzU0IvK21xeHRoYVpHVHdCcHlTSmtselpaK1NMWU44MDdVem1N?=
 =?utf-8?B?Rmp6WVowNFFnMGNRcHZ1UzNyNlRXQk1jM2dFbC95WHJSV1Rrcm5tbmxMeDll?=
 =?utf-8?B?ZFM5RjdPcGo5VDlOL0x2eDAwV1dVNmdsRjVqSEVreXNIcHRVS0R1Q3plOUdR?=
 =?utf-8?B?dGJGZDM0NWdKUW9mV1FqNHkxajNYa0V4blRHRzZUZ1d1SmxJOFlSdG5wVlNZ?=
 =?utf-8?B?OVFEb0Y4RjhEbkNyUE5xcmVXdnVaYmMyK0Q1dVFHeVBkN25aVU0rSGdyODNM?=
 =?utf-8?B?Z3lLcHFUd0ZjVU5lcXVwaDlBVWN3ZFYxWXhKMkdGbUx3R3B0RWs2emZFV25j?=
 =?utf-8?B?QkRCRWVTVlpOL3loMzlKWnUzU0NXWTA1UStDdlI1ZWs4V1VCQy94UWM5ZGwy?=
 =?utf-8?B?Mmc4MXdzZjR4TVVNTW4yY0tYcFplbXg3RXV5U0ZhbmRlOXVOemtoM1JvUmFR?=
 =?utf-8?B?UGl0QXc0VGczSzYvOFFkSFhXR3JRbEJJdnJ4OFNvaUl5dzlaMVRRMnd6TTdp?=
 =?utf-8?B?UDFwTDlWaUYvanJja2R6aFBmZzV5S1BWMmRaR1FzMzVnNTlZNXQ3UXdBMlZ1?=
 =?utf-8?B?dVZ0RitsSkR2WlZqUi9heGxnNWhacllFYkN6dlJVTGJ3QWFxR3Z2Y1prRk1U?=
 =?utf-8?Q?UVnHoyYBGy2/ANsA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c37241e4-4503-4b7a-be7e-08df244e9131
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:39:57.3203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTTuOOFLDYCNiaRaUrWV/aKedNjPIcJlH0Zk95hYszVG1bqJMC5w1TaOr7ee45wpPHf4D+C8utCRgzloQvBowgxUUmmPasi7qxck/afDot8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6292
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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

v13 -> v14:

  * Patches 16, 17:
    - reworked per Peter's suggestion: instead of a dedicated notifier
      list for the incoming migration failure, add MIG_EVENT_INCOMING_FAILED
      to the existing migration notifiers and let vhost register for it;

  * Patches 15, 17, 18:
    - report a failure to release the ownership instead of ignoring it.

v13: https://lore.kernel.org/qemu-devel/20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
Andrey Drobyshev (22):
      migration/cpr: forbid saving duplicate CprFds into hash table
      tests/unit: add test for duplicate keys in CPR FD table
      migration: forbid snapshots in CPR migration modes
      migration: forbid snapshots under Xen
      tests/qtest/migration: add test for snapshot rejection in CPR modes
      vhost-vsock: block CPR migration modes
      vhost: add vhost_reset_owner op
      vhost-vsock: don't reset connections during CPR
      vhost-vsock: fix FD leak in realize()
      vhost-vsock: preserve vhost FD during CPR
      vhost: factor out vhost_dev_init_backend()
      vhost: make vhost_dev_cleanup() safe on a partially initialized device
      vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
      vhost: add vhost_dev_is_initialized() helper
      vhost: release ownership in vhost_dev_cleanup()
      migration: add MIG_EVENT_INCOMING_FAILED
      vhost: release ownership when the incoming migration fails
      vhost: release ownership on exit
      vhost-vsock: hand off device ownership across CPR
      tests/qtest/migration: add vhost-vsock tests for cpr-transfer and cpr-exec
      tests/functional: add vhost-vsock CPR test with a live guest
      tests/functional: cover a cpr-transfer target going away with vhost-vsock

 backends/hostmem-memfd.c                        |   5 +-
 backends/hostmem-shm.c                          |   5 +-
 backends/iommufd.c                              |   4 +-
 hw/vfio/container-legacy.c                      |   7 +-
 hw/vfio/cpr-legacy.c                            |  29 +-
 hw/vfio/cpr.c                                   |   6 +-
 hw/vfio/pci.c                                   |   5 +-
 hw/virtio/vhost-kernel.c                        |   6 +
 hw/virtio/vhost-vsock.c                         | 193 ++++++++++++-
 hw/virtio/vhost.c                               | 124 ++++++++-
 include/hw/vfio/vfio-cpr.h                      |   7 +-
 include/hw/virtio/vhost-backend.h               |   2 +
 include/hw/virtio/vhost-vsock.h                 |   1 +
 include/hw/virtio/vhost.h                       |  74 +++++
 include/migration/cpr.h                         |   2 +-
 include/migration/misc.h                        |   5 +
 migration/cpr.c                                 |  64 +++--
 migration/migration.c                           |  10 +
 migration/options.c                             |  13 +
 system/physmem.c                                |   5 +-
 tests/functional/x86_64/meson.build             |   2 +
 tests/functional/x86_64/test_vhost_vsock_cpr.py | 347 ++++++++++++++++++++++++
 tests/qtest/migration/cpr-tests.c               | 133 ++++++++-
 tests/unit/meson.build                          |   1 +
 tests/unit/test-cpr.c                           |  98 +++++++
 25 files changed, 1067 insertions(+), 81 deletions(-)
---
base-commit: f7ada39edacaa5c26b30e98b94017b0b2ccbcf94
change-id: 20260908-up-vsock-vhost-v5-c781b39f1c1a

Best regards,
--  
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>


