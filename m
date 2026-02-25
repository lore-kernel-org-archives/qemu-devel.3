Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA59AFCEE92
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 11:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvDON-0003BI-0J; Wed, 25 Feb 2026 06:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vvDOL-0003Al-QT
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:49:21 -0500
Received: from
 mail-switzerlandnorthazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c213::] helo=ZRAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vvDOJ-0001Mt-NL
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:49:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzN45CwHO0aaKPzUdKXNLZmQIBizHwtnLF21+zYfYw97k99SMaBPenKv8mfwKgcHayT9+XySQBEXcxEM2zcoGXKP0HBG6ZjctkIPclVT+HmPUF4mvkiyL/5H/4SSEnMQb0mrwRDwrBazdltvEqo2tshkIiis66z6E2pu1K4h6B26OVnFUQ3oLWt8difAre8LNzG2wdfuKwb0iSu7dnNS8HthskDefCzlCaFdYcTvPrInKu/lBpNO7W591YD8/oqXScyYywAEKop8eOlxiFOPf5gzCm1V3ZkxJZ7BNbc9RZXtkQIn6sUMDF506rjdqm/Wv9uF3UGUvV4NEbs3FC/pcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XwuFT0KrDC3nA1JYyxZvN+HS1W5t8yaonkNeE1w2h0=;
 b=v6LNSCWsQHHDxne0m4+8hrrq1PMLhp3zqqmyDZ7bbudB95/3eCwqZJUseTTx3TfL1J0QJOLKVUmO6NyevTJNubFpsc091OOBl+WdeYkKSYhgwtJ6RxgNQTBgYgrjMlUFgD9YVMfKqWFgkw4Dbey3I0tfdgKU0WQkITsq6HIr6bGx1I6SUARUP1BmNmxoX6hhCafpI0TV5QJYtedpU5DM24zrRvMcHI99oaRnGynQ3UbceQcjuwTBCWfIXc81vDg+6Awux6ChyTdpVHrqEjgRYFe+MXnVbi4N3IxUdPp5Z8Sh+u3WcXNDpIPToVV3dzeU72G4gJ/l1a0+6/s9mu8hAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XwuFT0KrDC3nA1JYyxZvN+HS1W5t8yaonkNeE1w2h0=;
 b=io4okphbK8CUkORoYbr5SANwLiDfkoMP22tbgqNDi7ECZYfJ7BnvUVRPLSIDAJtAH8oaLNuSDk09IPS3G9sak0vPK++PPHCGwX2gANNJXfcFVnGrGA7FLD/2pQaWi1jPv2T9zb6ErYmHdHTm74jwFJ9EOW09KntmJnQtWOJQal8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR1PPF79EBF2ADF.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::296) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 11:49:12 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 11:49:10 +0000
Message-ID: <5dcb0646-4558-4533-8e9d-04e73ffa4513@epfl.ch>
Date: Wed, 25 Feb 2026 12:49:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] tests/tcg: add test for qemu_plugin_set_pc API
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, laurent@vivier.eu,
 imp@bsdimp.com, berrange@redhat.com
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <2ccc79ee-48ab-4097-a9cc-4d2b79ab9a8a@epfl.ch>
 <193c4274-c79e-4b76-8502-312dd3ebeb64@linaro.org>
 <317b95ed-f4cc-44b0-afae-64fd45ac8792@epfl.ch>
Content-Language: en-US
In-Reply-To: <317b95ed-f4cc-44b0-afae-64fd45ac8792@epfl.ch>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms020004010401060409090002"
X-ClientProxiedBy: GVAP278CA0012.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::22) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR1PPF79EBF2ADF:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dda6ccf-2c57-4d7f-73da-08de7463e3b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|19092799006|786006; 
X-Microsoft-Antispam-Message-Info: nJJ/h5WGjIEx+TeBtftaXwQ231le7AX+aleROjRby5RUYmdA0zA71oUo3jiceWNB6c+T3u0LWU65LVMPs6lsOB7PAXHVgkuy7izCt1za4vkPdPhSzQAR8pR9FosoZ4EAm2JcnSKAslobfnXVuLTgXGkhr9JiTxjueJijaFp6N2B5q1Kn5NEXbU/Qu4oOsiF7MpxGRFHJD4Ha3CN5XmKHHG8YziI5ZJgPwvH0UWLeyZ61MiCZd1wKOjUiq55AoRvni8PehifxcUWb2DYZZWS1fcF7mZuFeOAMDFqLVpz+MDi8qMonIg9KW5BRdl+o66epBndvooAuJAzZdwjJplrV5zWtA20CMIFk230Gc01ej00KRR9B5Ya7e4H81NibhgVr1Xg+uegEypQiw45HciEyPAFXZJUl5WPoz6ZsoKBb0lM69jWuCtP1A2kPVA6qqjW9USk23tbbzRyGpBchaEU4DCFQvJR3U58OZTzEwHW30jk7EaL8r8s3n3sALl2oR6b5R7que/ave/+e/f4MjGEgs68uO7ExVE3VBI3slxF7yCPIBikwP1TAO9pwVxydR5ztPzaD+cgLxXZA3Qdk6vqoTmlMypeNjIb+BVj/UCal96y4xJI/jZUziCE7hfEUL6aGP+jlKOk6kLwp4LxlxJrSJDxAUKFPHZMqwayG45LvSgqGSzLBZ00aKpmrcr9WcQu7o3tLORzh87cCL7br5QJ/gW75oyAoiOQ6oxFvS7BwgQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(786006); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YytqeXBEZUV0ZVJKTDdyVmNBMjZka0NqSnBpdWlWa3lmMlR6QmRETS9iQlJ5?=
 =?utf-8?B?TUluM2NaWlpoVmJwLzUvQitCQlM3cEFGUklTUDNsOVptbkxyY0I5SDFpU3k1?=
 =?utf-8?B?SUFsbE42UHBld3AvNE5DVjZLVnBwYi9Xcm40RnE3MzJvY1N0aVBYT1djV3Bh?=
 =?utf-8?B?bUhDdzZjMUtHeUlOWHNTNkFRb1JXRWx3QWhhbnV6NlVUQU5GZFB3ZTlVc3JS?=
 =?utf-8?B?WGJJRnBYYjVkN2RpRkZlS0R6blVjM0d6cU1uSitJTTZvS05qRnB2cTNuNnVB?=
 =?utf-8?B?YnZGclJQejVEODkyQnhmMVEzNEtqNU9TRGE0dmY4YmNBYXp5MXNKTHM4aHBM?=
 =?utf-8?B?dWxaczV4UWpqUFdYWGtsT1FoZklHRGVkQ2ZyTDlKeHhMbXdxQVJqdW9IV3lN?=
 =?utf-8?B?ZEJ2SmZVVXNRZ29uNU41b0VEZEtDeXdKTFk0QldiVFdWM1VoWCt1Y0VTNVlU?=
 =?utf-8?B?cHVYTThvVHpTUVJtbzZNTUdBek5mL1hnUzgycUl4cUhzSUFkTDNkdmYyd0tZ?=
 =?utf-8?B?Wm94R2xNK2tjTUJvZEMxak5tS3VQY2RlaHQrOXpUSGE3RlZJQXNTTE1OYVFz?=
 =?utf-8?B?UGhKUkZoU3NhRkZpRmJjRUdBUmtaRlF5eHR6M1g3K3ozV2RjaERqRnU2b3pK?=
 =?utf-8?B?aFpUdjdWVWovZlducHY5SmhNZDRqdTUyUFBveEFxTGtKbVhsMjNsSmJUVFor?=
 =?utf-8?B?YmNHdWl1N1djdDFOcEwwUnBueUh6bzdNRWpVMlNDY1E3VEpKOGdxTk5ZUHVn?=
 =?utf-8?B?UVFYNUZsQTZQNEVCU1hDTVl2dERCMzdCazZQVFlvazJCM3hmcWtubjJXcUFD?=
 =?utf-8?B?VXdJWkxOY1AvM0tDT1FFY3Z6UXFyYU9PTE5vajFIR0s3Q2x3VDFaTTNncWpq?=
 =?utf-8?B?UnZTRytqcGhxblNCa2V3Wi81NG5PNnNzK0NNZXVoekF6Q0tpZGZFUC9ZTTBI?=
 =?utf-8?B?OWExZWJzTW9lV0tEZEVJTmdjbmpCN0R0ejhFeGdoTEUxcWFaMG13SVpONHcr?=
 =?utf-8?B?bE5UWEp1TXdHWDYyVkF2QTBqMmFXN2wrUGZINnhLS2IzWjJmMFVPenhRWCtL?=
 =?utf-8?B?K1hXRGExNkd3YXNzc0ZLenhod0NIaStxeDljQkdQVmZ6c3JyejFpejBpQVM4?=
 =?utf-8?B?QWhURXlOVlQrMUYxYi9NcjEybWdBUTdvZWdjS0loY2I1MGw5cFNnQmhtNU1x?=
 =?utf-8?B?N3h4cXhzRkFBOWd5TTFyMVhUeFdiLzN5RjA5Nk5YYzZNZ1hRN3hQZTYzWTJq?=
 =?utf-8?B?aERKMGE2YWdvLzNsZ0IxU3ZDaTFHUXFhRGNFaGRudlNZRS9zeXZxS2ZYTG9v?=
 =?utf-8?B?UkF4djRGcWMyR0N5aUFhejk4MlVDaHZkZFRqK0psam1kaHhSeGVXNlNTYmU4?=
 =?utf-8?B?K2FkVTZxRk43amFrbW0wUXM1dGFWL05sYTZxdmlBcUlZbkxDVjZBbkQ4RVRD?=
 =?utf-8?B?MzlWNVRFRlhIY09CbW9yWHI4MHV3WXQrSHVTZmFacnZGZGVFaHpTdHRMR3hu?=
 =?utf-8?B?RGFHOWFlbXB4M3Z1MWIzRGFmeFBBSmhkak9RZ2hrNFpkM3pnSzRnWTZWOVkr?=
 =?utf-8?B?M1FUT04yMnlJSncrZ053ZjVBa2xRa3dQVS9GdVBKMElEcFlHS08zamwrTm4w?=
 =?utf-8?B?VlIrYWRsREg5Z3BwM0JNMmNGZklkenlLdGhUdTV3NU96a1JZVnlOazZUcFpl?=
 =?utf-8?B?RzBwODJ2SmlJTDFhOEJnNVcraGt1eTdyZ1NXNjZEejl4SjF3Y2VLNlI5aEsx?=
 =?utf-8?B?N2RrTDVpZkRsaldMdUlUR21Zb1NVNWYwU3JKYTNPbkNIdW01ekpEMFYvbUgz?=
 =?utf-8?B?RGwxTVVBUUtTa2xHcjVETWNOVTZnVFpCTVg4SXBQeHBNVEZlY0hoSXlCSWE1?=
 =?utf-8?B?Z2FHTjRhRE1rR0twWDVQZ3pkakNnazJJbEh6czhGdXUwVGViZjNlYkNtSXRn?=
 =?utf-8?B?TjNuMVRPQWhpcTloSVJKZmZpdDR2aFIvTE8vcFJyQ0R5SjZVNXlpei94N1pX?=
 =?utf-8?B?V2pBeTFva29XNXFnUUllYUVGL3JydDZXUDJod1cvUHl2RktmN3VwYVJwZzB5?=
 =?utf-8?B?OGVtelZsMEV0N0tWc1FQVmV3dkpNbHhEOXdnQTd2Wm4reWREWW0yVjJ1Y1dU?=
 =?utf-8?B?Rnd3bnl0eFFqZ1I1eklkNEdpVlpBNGhJR3lack1nR1VmakQ2WHE3R3N6UlRZ?=
 =?utf-8?B?NXM4Y1J6SVp0QVRsd0NWN1ZKQXhzd3NDTGROVTN4aVRINEd0Y2UwNTBNMm5x?=
 =?utf-8?B?ZFFNRHZ5SFlNREo1NkxRSHVlTDRZaVgwQzYyL2pLVmZ5d0kyQ1JkUGwwck9r?=
 =?utf-8?B?cHVmMTJNUEQ4a2tXKzdXK2w0MnpxdkY0ME9UODZQUGQ3aWRFUzAyUT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dda6ccf-2c57-4d7f-73da-08de7463e3b0
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 11:49:10.5370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNKhinu7twuvp7+9zgtxAnySfVg/Sff5DJAki/A1cDQilzJc2Rec4XoalPgYYSIWcdvGSbTFKZKWjNi5ggKJWomWwntGNYRIeVBkA41pYqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1PPF79EBF2ADF
Received-SPF: pass client-ip=2a01:111:f403:c213::;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRAP278CU002.outbound.protection.outlook.com
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

--------------ms020004010401060409090002
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 25/02/2026 08:59, Florian Hofhammer wrote:
> On 24/02/2026 21:35, Pierrick Bouvier wrote:
>> On 2/24/26 7:52 AM, Florian Hofhammer wrote:
>>> The test executes a non-existent syscall, which the syscall plugin
>>> intercepts and redirects to a clean exit.
>>> Due to architecture-specific quirks, the architecture-specific Makefi=
les
>>> require setting specific compiler and linker flags in some cases.
>>>
>>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>>> ---
>>>   tests/tcg/arm/Makefile.target                 |  6 +++++
>>>   tests/tcg/hexagon/Makefile.target             |  7 +++++
>>>   tests/tcg/mips/Makefile.target                |  6 ++++-
>>>   tests/tcg/mips64/Makefile.target              | 15 +++++++++++
>>>   tests/tcg/mips64el/Makefile.target            | 15 +++++++++++
>>>   tests/tcg/mipsel/Makefile.target              | 15 +++++++++++
>>>   tests/tcg/multiarch/Makefile.target           | 22 ++++++++++++++--=

>>>   .../{ =3D> plugin}/check-plugin-output.sh       |  0
>>>   .../{ =3D> plugin}/test-plugin-mem-access.c     |  0
>>>   .../plugin/test-plugin-skip-syscalls.c        | 26 ++++++++++++++++=
+++
>>>   tests/tcg/plugins/syscall.c                   |  6 +++++
>>>   tests/tcg/sparc64/Makefile.target             | 16 ++++++++++++
>>>   12 files changed, 131 insertions(+), 3 deletions(-)
>>>   create mode 100644 tests/tcg/mips64/Makefile.target
>>>   create mode 100644 tests/tcg/mips64el/Makefile.target
>>>   create mode 100644 tests/tcg/mipsel/Makefile.target
>>>   rename tests/tcg/multiarch/{ =3D> plugin}/check-plugin-output.sh (1=
00%)
>>>   rename tests/tcg/multiarch/{ =3D> plugin}/test-plugin-mem-access.c =
(100%)
>>>   create mode 100644 tests/tcg/multiarch/plugin/test-plugin-skip-sysc=
alls.c
>>>   create mode 100644 tests/tcg/sparc64/Makefile.target
>>> +++ b/tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
>>> @@ -0,0 +1,26 @@
>>> +/*
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + *
>>> + * This test attempts to execute an invalid syscall. The syscall tes=
t plugin
>>> + * should intercept this.
>>> + */
>>> +#include <stdint.h>
>>> +#include <stdio.h>
>>> +#include <stdlib.h>
>>> +#include <unistd.h>
>>> +
>>> +void exit_success(void) __attribute__((section(".redirect"), noinlin=
e,
>>> +                                       noreturn, used));
>>> +
>>> +void exit_success(void) {
>>> +    _exit(EXIT_SUCCESS);
>>> +}
>>> +
>>> +int main(int argc, char *argv[]) {
>>> +    long ret =3D syscall(0xc0deUL);
>>> +    if (ret !=3D 0L) {
>>> +        perror("");
>>> +    }
>>> +    /* We should never get here */
>>> +    return EXIT_FAILURE;
>>> +}
>>> diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.=
c
>>> index 5658f83087..b68e3cadf4 100644
>>> --- a/tests/tcg/plugins/syscall.c
>>> +++ b/tests/tcg/plugins/syscall.c
>>> @@ -148,6 +148,12 @@ static void vcpu_syscall(qemu_plugin_id_t id, un=
signed int vcpu_index,
>>>               fprintf(stderr, "Error reading memory from vaddr %"PRIu=
64"\n", a2);
>>>           }
>>>       }
>>> +
>>> +    if (num =3D=3D 0xc0deUL) {
>>> +        /* Special syscall to test the control flow redirection func=
tionality. */
>>> +        qemu_plugin_outs("Marker syscall detected, jump to clean exi=
t\n");
>>> +        qemu_plugin_set_pc(0x20000);
>>
>> An even better alternative is to use a value label, which is a gcc ext=
ension, and you would not even need another function. Just pass it as fir=
st parameter of syscall, and jump to this address directly from syscall f=
ilter.
>>
>> int main(int argc, char *argv[]) {
>>     long ret =3D syscall(0xc0deUL, &&set_pc_dest);
>>     /* We should never get here */
>>     return EXIT_FAILURE;
>> set_pc_dest:
>>     return EXIT_SUCCESS;
>> }
>>
>> More details:
>> https://www.amulettechnologies.com/boosting-bytecode-efficiency-the-po=
wer-of-gccs-label-as-value/
>> https://gcc.gnu.org/onlinedocs/gcc/Labels-as-Values.html
>>
>> Regards,
>> Pierrick
>=20
> Thanks for the idea, I didn't think about this. I'll check it out!
>=20
> Best regards,
> Florian

Fun finding: GCC optimizes the label and the second return away and
there's no way to turn this behavior off, so the test doesn't work with
value labels. I'm nevertheless changing to just passing the function
address as a paremeter, which is cleaner than using a hardcoded address.

Best regards,
Florian

--------------ms020004010401060409090002
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DD0wggWvMIIEl6ADAgECAhANkOKMSmGXhF5eMl0rsRhvMA0GCSqGSIb3DQEBDAUAMGUxCzAJ
BgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2Vy
dC5jb20xJDAiBgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBHMjAeFw0yNDAzMTMw
MDAwMDBaFw0zNDAzMTIyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2Vy
dCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNI
QTM4NCAyMDI0IENBMTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOfSIeC0vv1x
PQ+dgSxbIIrkaru6skAWJYaGFzmvq4Kq+2wU2jxhcWlJg/JeP5jEkq/LM3pn5aaLao79j+XR
mS7J1ZpJKUODJVoM4s9MQJhTMvo4qS5ZS64g6QR7Obkz3I1Lr3aWeSBmDDEyzue+NKtuWZ1C
xy3RdXo/w5HgRc3l2AercOM3Gt1XonTzEtTbZ/Hwc0Sn9Gz8RmGRK6Ka4hVDl8q/2l110KaV
233Kh5etP0csXS8MIMdVRfRu3sc5hp13DG7lCKzK72a2GEpI8Wpl26G6I1/LMzz/98T+FqjT
qxsdquk7Cj7m2vKGLW1BorpQH7WFGPdJQXJe1hfbfiZACcVdCtl4nAacFacmsiArZBfX7AQG
L7isvHUwwYFEtcApyGW4p2Lt+t8nvU0CANA6BHOpOz1xOP8WmAESbUriIjyuTUf3fJ9oDNCu
rVqhASMJCDaWI3lYX/QAoiAzt6akqbbZxo2ujW7mGGqc0KxqE2csh2T79v7pC8aUtHBfwNrT
R19GnZVxE0eQ7ViIQhR6mpSaUQFA9sG+cmD2G8TnCgYsLa0q8De6F61aCBevQGHNzrbZ3JAM
neveYg/Jy1XxQHDRcvrMfWKe0jjcWbdKYlaGVPm5V1ILwYz7Yv5ewo3NUrxIGJiywe9qPhuJ
SDZs7VehTuI0FxGIsgKzVjgbAgMBAAGjggFcMIIBWDASBgNVHRMBAf8ECDAGAQH/AgEAMB0G
A1UdDgQWBBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAfBgNVHSMEGDAWgBTOw0q5mVXyuNtgv6l+
vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEMGCCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1
cmVkSURSb290RzIuY3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0
LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RHMi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0G
CSqGSIb3DQEBDAUAA4IBAQA+b8Uw53sDspdZgukU+qzLyyHkcjlxGGhHlP+zrmDLKm1wEFvC
RS2pili3Hy67i8N4N5NUvw5Rg6kv3lxb9S9Rktxk43k+tvm68pl7OxQE55ZjVY87P0lUPGwE
qOOwLLyH02ZQcsfq5p5LrOH90JvmvZ1yy73HS+VpDAqOlytE0NSvTIRqFFkKQGQwfjvtql9Y
flujuNNvJztjBaHKYZsnNSg+J38ojYq4TP3pSg3UdVH0PncVjPQyqxC9xef5Xae92Kbkzol3
x7Nel3A1bwAkalrDMspvTHvey6LfiBksFIqviTnoy7fgjaRAJgHS+RXx/cmuRd3rUAclSVVr
Yu8RMIIGhjCCBG6gAwIBAgIQAggtinx6OJLKM4FVztNyWTANBgkqhkiG9w0BAQsFADBiMQsw
CQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0
IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQgMjAyNCBDQTEwHhcNMjUwNTI4MDAw
MDAwWhcNMjgwNTMwMjM1OTU5WjCBrDEOMAwGA1UEYRMFR09WQ0gxCzAJBgNVBAYTAkNIMREw
DwYDVQQHEwhMYXVzYW5uZTE0MDIGA1UECgwrw4ljb2xlIHBvbHl0ZWNobmlxdWUgZsOpZMOp
cmFsZSBkZSBMYXVzYW5uZTEaMBgGA1UEAxMRRmxvcmlhbiBIb2ZoYW1tZXIxKDAmBgkqhkiG
9w0BCQEWGWZsb3JpYW4uaG9maGFtbWVyQGVwZmwuY2gwggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQDZkbG07NgfFKDNM3VI4qQdU1fVIGUQnN6BO2zeqoUdytNIzxOX6n7HxM+o
CLa01AnxaL59DXwFTXIg0OVq5ETAoLshUwnkYeWhKZH4Ysoq74QGVFihjrrs41d+8o+ymG2F
cZBMzQ/RO4KzFhmlaZ/E+1d2F7/O3x8LohaFxxBsN0+qonMreRQGx+ialMmbARFJkVuinuB4
3hZ8eRVmXy8A4R8ywakunaCNm15+eIQtptCs3IH5UqPEEOn16ANekWr7z5mZJh3ApxreflA/
iwJKWd/Ljga90TJXjTFc7sNA0RgA78Edqw7BE+D2VUcPMshdhKYNB1BVHZS81anGL7RFAgMB
AAGjggHrMIIB5zAfBgNVHSMEGDAWgBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAdBgNVHQ4EFgQU
ogXJJmzPazWg0eBlf1DbolocD3gwJAYDVR0RBB0wG4EZZmxvcmlhbi5ob2ZoYW1tZXJAZXBm
bC5jaDAUBgNVHSAEDTALMAkGB2eBDAEFAwEwDgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQG
CCsGAQUFBwMCBggrBgEFBQcDBDCBqQYDVR0fBIGhMIGeME2gS6BJhkdodHRwOi8vY3JsMy5k
aWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZTSEEzODQyMDI0Q0Ex
LmNybDBNoEugSYZHaHR0cDovL2NybDQuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcy
U01JTUVSU0E0MDk2U0hBMzg0MjAyNENBMS5jcmwwgY0GCCsGAQUFBwEBBIGAMH4wJAYIKwYB
BQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBWBggrBgEFBQcwAoZKaHR0cDovL2Nh
Y2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcyU01JTUVSU0E0MDk2U0hBMzg0
MjAyNENBMS5jcnQwDQYJKoZIhvcNAQELBQADggIBAD3Ne2mHg2ctxRIflrx/T2yBDnQunFhe
SRwBnFIaOvCG05KE9iit2I2sazC5xqdp292spCoP9Qa4MOJg22BFmTnN9XnOjcEv9KFPSMaA
ITLu8CXyewPb0xLET8WqdEe5AravlneZ9/H0ve9Ufhk3wbJPKK5yijcKYmEYH21JBtZ1pnjs
fVEXAETdKkp9LC5sVeYeFk67BbUTPrFl37pha3TynPwJAiXDJFR2uI2JVGESQFyWkeO/bY5T
DCf6VIp3d1p++XoOTVseFE8OqaHZYGN+DgSK4ejT19c/GgjQqoWVK+xSvHEEsoLfOADKcYFN
M0ptGrFYpdRWJO0CKukBUAk8fpriJ/OjhSVQltCpN3pK1DPXnPrXTROXGacb3PNSUyeDlP2/
y0FqpEY7GjwMZMdu+U/rHhMGbDmv/ZBLGwiGzQVmld5je+d8nvZTamE1iBA8Nhmuz6wg6yN1
qx9b7Jn/9yQebxvHddnvz6jw6FDnw2bhq7z88eH3mYZYZ48Fhr8J87horGotEDKTDNHkF1Oe
FSxhIx0a7yoe1I66R5tapkRlNgI5EX53e/npP4ruND5bQFWDI7JGkKrLlAjQR/dNahXXX/Ry
rCfngiHZcAQakPkQrlrZCxMhlIKvDMunATaICyjnHizEC+1qzJsdvJgSC8sOzLxiEjlx3MRe
CswFMYIEezCCBHcCAQEwdjBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIElu
Yy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQg
MjAyNCBDQTECEAIILYp8ejiSyjOBVc7TclkwDQYJYIZIAWUDBAIBBQCgggLWMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDIyNTExNDkwNVowLwYJKoZI
hvcNAQkEMSIEIHQRC2oc/EqtZSr8Oog/7IpYGOGwhvr/k0Z7VGEoS0aGMIGFBgkrBgEEAYI3
EAQxeDB2MGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UE
AxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMQIQ
Aggtinx6OJLKM4FVztNyWTCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlVTMRcw
FQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBT
TUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMQIQAggtinx6OJLKM4FVztNyWTCCAVcGCSqG
SIb3DQEJDzGCAUgwggFEMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcw
DQYIKoZIhvcNAwICAQUwDQYIKoZIhvcNAwICAQUwBwYFKw4DAgcwDQYIKoZIhvcNAwICAQUw
BwYFKw4DAhowCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgMwCwYJYIZI
AWUDBAIEMAsGCWCGSAFlAwQCBzALBglghkgBZQMEAggwCwYJYIZIAWUDBAIJMAsGCWCGSAFl
AwQCCjALBgkqhkiG9w0BAQEwCwYJK4EFEIZIPwACMAgGBiuBBAELADAIBgYrgQQBCwEwCAYG
K4EEAQsCMAgGBiuBBAELAzALBgkrgQUQhkg/AAMwCAYGK4EEAQ4AMAgGBiuBBAEOATAIBgYr
gQQBDgIwCAYGK4EEAQ4DMA0GCSqGSIb3DQEBAQUABIIBALIqV5c86XX43kqwn85SsAXZXcwh
xJB38gemmeDbNN09YIFWF9MTnHuF4bHoTIQW1JZol1A7dtl8aFyNkXEcgRj9QQoye9mJf/Qu
mjPrEkoRW4FOOaF1K4V2VnUR8sMsaHpJz354/KoTPgo5V1CFUrcBzVimyj86GBrU38xtjFf0
ZM6iprq6r7s6Fr5TYcKsggtAkTi+ZcuH9Ix+4dMUdbVRw56dEdVSet1KiY7PEkzEuIGScRed
4FB2gdDhZQIdR3SSnCCJ3ARPSBApPNglT4OzmuAAfsJovkCXnKlJ1QouiMpFeFZahe2r8/4u
qOqPPaPdDDdenpduyVg9FCoYSM4AAAAAAAA=

--------------ms020004010401060409090002--

