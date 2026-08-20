Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67334C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2Ww-0001sv-5z; Thu, 20 Aug 2026 09:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wx2Wu-0001rw-Mx; Thu, 20 Aug 2026 09:10:00 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wx2Wq-0008EK-G2; Thu, 20 Aug 2026 09:10:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLSzoMgGpaGWqz5vD9BeYnDousq1z4kE/C8+jTLx0Rd0v7wMg+HG9CC05c97bRepr2GDJ8c09CixO156OAldQmXWxgnzxgMG0ZqpoaSdk8hXxUhF00GH1qWKZYtWfMZAAoe/GO+5zSLn3fNwX8oUAcOuuRfdqx6g9uX80nTm5msLY2vP9VWON62idaED+YFdM766SQIE/Q8YLzC/3kYYJp6xqMEqqUENC5ueS0HKLP74qY6vxdRXheZXWbbigxEOhu51PEarLf9QOqgJXB6dpp5GMd2JDO9uII8tD+yS/bb3UjylMxvLi822QRKu5aaVmHJ210xStmvdqXfDsOVB5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wnq9QT37aTc6p2sQyq2OZEbXAjBwpq/rdJu5CokRVM=;
 b=CUbXbc4C8xNr9Ju4XXyrliPG+lQ/+knYfAtuG177kWt0L81ICRQ6P39sdX7WYvyCNa4zBrY/tLUiU0rL8spyklzom8LjXcwJTza2ddUtEuz8DD6xW1N3WZ+JFdY80BMIziJyMqzYqyUULevexBGUc2r9ReulNksm54Zr9Vyfm3wgLSXcnhrwIzGxweMdEdyddWxGEgtiUYiN9Q21NnMDYvdkSDx9Pwisucuf5+iHhX8MimoIibCy9IhnaJiM1Hn8SeLiFpFc2c4WG+HCs77KPe3GJR0k0MfksESD3V39Qr265UHOusf8lzohc+hnC7ys3RteuwLC+UabW6BNtxhlFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wnq9QT37aTc6p2sQyq2OZEbXAjBwpq/rdJu5CokRVM=;
 b=F8TYaLH/Bqa9XlcHd1QaOzVpVD44JpIrF5OPljc8QiQhJDQExPl/ippM8rXukR5fc7J4yq0WjK7EfJ+n1r0FH7QeCNdpoOvBl06dBMvJqHhp7Q2BxSZwYho5lqnvbuy9RmjhP1TY+6lSLojlQKMq13DtjaO0ab3rJczeWA4b2uXWwhytU57oM3fT2YlGx9KUFAyEa2rqWME/xGD8+NVlwuGNWKnROJh0AaP8BFHJ78loQEbJPj0qIfmwgKVl6HdAgy0VQpov+QHQj5S5Ab1gUo/LCdZV9rFsCn8ABjO10b0lOJgJSGmgSFvuOF/b+BJmhYvPJZ+VDHDtaXIS/9zy/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PA4PR08MB5918.eurprd08.prod.outlook.com (2603:10a6:102:e7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 13:09:50 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 13:09:50 +0000
Message-ID: <4f0c665c-b835-48cf-bd14-78c843e90be7@virtuozzo.com>
Date: Thu, 20 Aug 2026 15:09:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] hw/ide: fix the logical CHS translation a guest
 selects
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260820100844.411717-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260820100844.411717-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0077.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:349::6) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PA4PR08MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 47cd52ef-266e-4cf4-026d-08defebc5145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|23010399003|1800799024|366016|3023799007|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: T0kAKx/AnHClbIUlbwBBY/qXcZFctKBewYrkUb5DzN+nkMUBoADOuq4A60qnr/oBeFeLjOH6oHotWhRHqKwuoV6wZdWc2GCTdJqZCy17j3BUZ3ewgk3go2KuyxrK3v5sYQPtj48S3oWl3D/bkDEJGJz493IPJyPkVniFGBYJcWlZguXGTMnpya3GkiNjZuaePtzbQIvYOOnDd0boZgGpOEjsa8f9GT0aR51Jw5+yMDznQwRqiFjbfhQ2OoOXRvJ0B9d9uAQDAq6HdDxTBdnKzK5v0A7YZ/fVjCybYdli0pZYenJTvipoVlP4JOWpzMIv3zonLNqjEYyBkKqyFcrxNRcKZ/gxEJnyTXf4Q81tTmFF+dEXXy1HT9rhWaOUM/Qm8r6fBjoVm5KEch3U1LimM6PsRlgNZiypnRbTNb2xtCOw3eflMEFfw+LxbTj1xIYccWKAWfWkbIDnsn6Rph7bZPg2bgkcu4wqKkAnR/dg4kwvewqDunotj18BkNnH29trZX26T5MG3v46ukmJ9PPMdn934V/85ZoQDxLPJiURVGdNGK9Gx1esu+SNaACRrhbpk2wazI04zfzLhOzEFNwRxyqZVA8VPGCfRx+QNo8sbvL+gfELBRFfxxtDgS5pq1EpFup+BOcQVv935aoVjpizNuNoRIWDnp5ARAKyoafz+DI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(23010399003)(1800799024)(366016)(3023799007)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekliZ1FXdVAySnNvY2NjMnYrd1ZvNHU2c1d4N25MVFdCZzM3ZGRseU5zdElP?=
 =?utf-8?B?UmI2cHkzK3k5UC9xYm9YeWVTT2Y2clM5UlRCZXc3SnVHSFU5VEpXNGZGanJx?=
 =?utf-8?B?ZngwVEtFMUF0N0RuSXpnMk9wZzZtUnUzSG5HMU03QjNsUkRDVENRQzZwM1VE?=
 =?utf-8?B?K3luSVA5NHQveXA2YnUyb0RVVVIzSUlsZHYxVkNvSkZnWWZlOWJXK3pTRi9u?=
 =?utf-8?B?d0FFclRXZXJ0RlZJOVNmVWFlbFAzZXFpZG11ZnZSUkd1aFNEYVEyUmd6ekp6?=
 =?utf-8?B?TXBvazR1Tkx4VWJFWWpoU013cVNaakRyc24wVWkwaEVNRm5YSFFrWEMxUXRY?=
 =?utf-8?B?dnhGaVpaV0xWaW9XakdJcHQrRnp4UW5EVVRKL2lFaW5oZURYd0tiRlRLaFg3?=
 =?utf-8?B?QlFrVnpQM29hK0pkZkFLcURZSFR6ZmJ1d1dzeHJUZEthUFQ5aGQ4eEk2MlBN?=
 =?utf-8?B?SVZjYTJveC8yRnYrc2tsT05EajBmS0d1bUlrYmVBS2ZSd002LzNkLzFnNEpH?=
 =?utf-8?B?b2gvUFVVdXdMNGZjZzNOZTljZ3g3T0lIZ3ptdmw1WlZGcFRYL3dJRDMwTnl2?=
 =?utf-8?B?Yml6bVZET01GOW9nN3RUbUNwRGN6U3VXYVJpazVyMmVDQzNxNkhQZHhmdzZm?=
 =?utf-8?B?Wnhkbmhlbm1KVWVnZWhhWnZtVEdJNEkvb1RmamkvdVhDeEFSTlJ2Y2VIdnpW?=
 =?utf-8?B?T21sc05OQmM1QStHN253VCtQZlU5aUtIaktGV1A2T3BFZHA1SVQzeWY1MThX?=
 =?utf-8?B?NkFzQU0ycXpOZjhZTXYzY25xcXU2Vm5iNkRUNUtNZ1ZpZTI1U21mUmJVN1di?=
 =?utf-8?B?SEE3U1VSdXgwR2xHdG15OE9JdUdoOXliQis2OVUrcVVDT2s4WlI5TnBrNjk2?=
 =?utf-8?B?cjMwa0ZyRjBzMDF3QXNkeXMwRy8rZy80NmJVckFRMnpqdjFhNHlTeDFkUDQ5?=
 =?utf-8?B?NVJ3VW1JakQvSko1OHJRcVFmaFdGQ2VoWnNaQUVYRmwrc1BhbUNrdUdqWGJH?=
 =?utf-8?B?eFpQNDJjTTIyaDNTMDBOcTh2Vml4ckRlYmdVZExHOFZ3VWZPcXRIMXpWQWtv?=
 =?utf-8?B?Y1h6Um9vQkdTQ1hScnlpZG92SE1aU3lNWk1VTU1UMXg4YU1rYVlGTjIzUGph?=
 =?utf-8?B?aWhCNk9wZkFDOGRTQVhEbktLOTZGcjF5bmpROHd4Y0p5dCtad0p6bmR2QmlG?=
 =?utf-8?B?cmg5ck14R3JzeGVvM3R3eHRnTElOUEd6OERwa1Yxblh6YUFUenE0T21iTTI3?=
 =?utf-8?B?cGg3N0pjeVRvdHBNS3pPa3QySjZ5bTFyeTBqNkFaUnRTKzNsekZoUTU4R0dy?=
 =?utf-8?B?dkJLWnFJUXl2elBYSHAwclZLbXFrOHFzSXNxd3BObytZVWpyck1ZRXRPMHYx?=
 =?utf-8?B?NE5RQnFLZi9KUDNWVyszQ21MRTV2ZER5SUIwY1ZoRENBa2FyZW5vdDBxRjFG?=
 =?utf-8?B?Qy9VTEwzTXUxVVMvS3B2a3FSaVJOQXB6QUFJOFc5ckV0dVMrZU5ONHFid2dL?=
 =?utf-8?B?U2JodXJBVWVQQ1NHbnFGWWRlY0hDbkhUS21EZ0NsUEJuV0VtZWN4aHQ2ZFVO?=
 =?utf-8?B?eDNBQmlzK1pxZDl5TTZUaWp4bkdWUzBwcUVkYW5tYnZGeEdqekErdHBNOTJq?=
 =?utf-8?B?YnFoSlpCZDFhMUtYUnZZQUZiT1FEUEw3Q3ZOK2F4QXcrdzZvZ0hwVmtvdHRh?=
 =?utf-8?B?UEVSeitNMG5nd0ptVlJCaEhQZ011WnJ2Q0pBT1o3TG9LWFRSTWxicjJ4WGZV?=
 =?utf-8?B?R0lrNlVXWEVlNElBaWFSQkJtS3J6Q1dDSUo1a3djTyt2cFN5cGFCeEo3YTZ4?=
 =?utf-8?B?WURkaTl1ZXlSNHhkMXl1Nld3NmtNQXJtTWRwSEZVM3AwOWhleVBDMlY1dU1p?=
 =?utf-8?B?YmJIcmlaRytwVE5QR0gvN0tIajhSWnBnZWNqaVMweXhrb3FvMzRBalF6aG03?=
 =?utf-8?B?MWhQU2dEaWwyblZ4NmZBdm8vTUxiQUloUkhmNExwWHNFcDV2cXY4UmlXbVQr?=
 =?utf-8?B?b2FjYXRvVERiZnB0TE8xZ25lR2FhNXJROUFRM2pqT3UyUzVaYVY3cjNWOGlW?=
 =?utf-8?B?QTNiOXBaQnBoZG90MFJMUmg5WjVtNjFMdzFqeFM3dE15d205T1dlZ0llVWRt?=
 =?utf-8?B?SFM4MGpUeGVwYjlYczVaQ3A3bzJOZTlabnBoY0d6VVF1ZDJYYmRXS0x6VkJC?=
 =?utf-8?B?U2JWOXR1NVBGL0xvSU1WTzBwdzlFQm5NTXpvdnBHeGtiM3poMDFFSzlqUnJh?=
 =?utf-8?B?T3NIZ1NZOEtqUWRGRlNIWE5qcmFEaVJFNnR6eWNzQWJOQVRHYnU1WmN1K2pZ?=
 =?utf-8?B?akthTE80b1Iva1ZwVWw5eUdSNGNMbWZPOC9ycjRGWHhMaU04ZlQyRUV6VFVU?=
 =?utf-8?Q?I6n29gu4doWAKvR/QxPHguzDloSoPL954l/PRGkgpznc8?=
X-MS-Exchange-AntiSpam-MessageData-1: YJ0GcZvn+6gkVg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47cd52ef-266e-4cf4-026d-08defebc5145
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 13:09:50.5405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rs9OUek9VAYk8i/v0hmTbhYx+m0wqnQ5m2wpww0oWBb+D9lAGsSUzlxHfYgR5es/UT/kOf/8PM79lWkoy7Ip7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5918
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=den@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

On 8/20/26 12:08, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> INITIALIZE DEVICE PARAMETERS lets a guest replace the logical CHS
> translation that turns the CHS registers into an LBA. cmd_specify() has
> implemented it since 176e4961bb33, released in v7.2, and the geometry it
> stores is mishandled four ways.
>
> It is not validated: zero sectors per logical track kills QEMU with SIGFPE
> in ide_set_sector(), which is issue 2399, and since handle_cmd() takes the
> count from a 16 bit field of the register FIS, an AHCI guest can drive
> ide_get_sector() into an int overflow as well. It is not reported:
> IDENTIFY DEVICE is built once and cached, so both the words describing the
> default geometry and the words describing the current one go wrong. It
> does not travel, leaving a migrated guest addressing the disk in a
> translation the destination does not have. And it does not revert on a
> hardware reset, which ATA-5 9.1 requires, so it outlives the reset of the
> machine it was selected on.
>
> The two subsections patches 10 and 11 add are the only change to the
> migration stream, and both are sent only when the guest replaced the
> default geometry. An unaffected guest migrates to an older QEMU as before;
> an affected one now fails the load on the unknown subsection instead of
> silently addressing the wrong sectors.
>
> Tested with ide-test (25 cases), ahci-test (74), a full make check, a
> clang build, and real guests on both controllers: FreeDOS reading a FAT16
> disk through INT 13h CHS, Red Hat Linux 9 whose 2.4 IDE driver prints the
> geometry it read, and Ubuntu 26.04 over libata, each with a CD and a disk,
> plus a machine reset in the middle.
>
> v1:
> https://lore.kernel.org/qemu-devel/20260817205242.1199851-1-den@openvz.org/
>
> Changes in v2
> -------------
>
>  - patch 1, patch 5: Cc qemu-stable. (Philippe)
>  - patch 6: new, the "XXX: retired, remove ?" on IDENTIFY DEVICE words 4,
>    5 and 20 is answered rather than carried. ATA-5 3.2.3.6 keeps the
>    ATA-1 meaning of a retired word that a device still fills in, so the
>    comments name that meaning; word 21 is a buffer size, not a cache
>    size. (Philippe)
>  - patch 7: new, splits the extraction of ide_identify_chs() out of what
>    is now patch 8, leaving that one with the two call sites that keep the
>    words in sync. (Philippe)
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: John Snow <jsnow@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>
> Denis V. Lunev (17):
>   hw/ide: reject an unsupported CHS translation
>   tests/qtest/ide-test: cover a CHS translation with zero sectors
>   tests/qtest/libqos/ahci: allow a count and an expected error
>   tests/qtest/ahci: cover the sector count of INITIALIZE DEVICE
>     PARAMETERS
>   hw/ide: report the default CHS translation in IDENTIFY DEVICE
>   hw/ide: name the retired IDENTIFY DEVICE words the device fills in
>   hw/ide: factor out the IDENTIFY DEVICE current geometry words
>   hw/ide: keep the IDENTIFY DEVICE current geometry in sync
>   hw/ide: restore the power-on device state before loading
>   hw/ide: migrate the logical CHS translation
>   hw/ide: migrate the power-on defaults revert flag
>   tests/qtest/ide-test: cover the CHS translation across migration
>   tests/qtest/ide-test: cover a rejected CHS translation in the stream
>   tests/qtest/ide-test: cover the IDENTIFY DEVICE geometry words
>   hw/ide: revert the CHS translation on a hardware reset
>   tests/qtest/ide-test: cover the CHS translation across resets
>   hw/ide: drop a redundant interrupt from INITIALIZE DEVICE PARAMETERS
>
>  hw/ide/ahci.c             |  12 +-
>  hw/ide/cmd646.c           |   2 +-
>  hw/ide/core.c             | 147 ++++++++---
>  hw/ide/ide-internal.h     |   7 +-
>  hw/ide/isa.c              |   2 +-
>  hw/ide/macio.c            |   2 +-
>  hw/ide/mmio.c             |   2 +-
>  hw/ide/piix.c             |   2 +-
>  hw/ide/sii3112.c          |   6 +-
>  hw/ide/via.c              |   2 +-
>  tests/qtest/ahci-test.c   |  40 +++
>  tests/qtest/ide-test.c    | 499 ++++++++++++++++++++++++++++++++++++++
>  tests/qtest/libqos/ahci.c |  14 ++
>  tests/qtest/libqos/ahci.h |   6 +
>  14 files changed, 690 insertions(+), 53 deletions(-)
>
>
> base-commit: ae4f3443209ab154b48b706a146e5f557ab147cb
queued

