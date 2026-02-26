Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4EBFC590F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 08:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvWlg-000167-D4; Thu, 26 Feb 2026 03:30:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vvWle-00015t-VL
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 03:30:43 -0500
Received: from
 mail-switzerlandnorthazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c213::5] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vvWlb-0003RV-2g
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 03:30:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmXlEuftac5Fl9IRb9YWln5yfPhnsE8yjAdQugoyxox89Qd1825K/84Pv9LLDtiklt0/+4ajsN8XCbh8UODOHWzaFbJKcZ8EkDZBHZR11Qwp3AJ+w24t2yYLTTgKTCsYsarYr0UWjWZxDNLA5kcydR8mm/VPZVxwGqZcA1X/MG13KmPDgA1yUQ7nnM6kNi6yUEy+pqWDZfpJI3qdYXDul83SkfPZ1zIgZNUX3GKQL+z5c/p2HItpLidbiSyCj8VkjhTJrsT0smt+XVvGlie1vLi0lTsr8xwsBWmZ0YqkJUc8uchlJyFcuzFaDM0Foe6RhnkDzNRAPOZ1dryIg0nR4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBe1W+B2fSV6gc8xcog9ObqsMMK9plGgNXzEVXwpq8c=;
 b=Ltl4E3dBdA9iLaN98D4EdskP2x/KUb77vu6cztFRml1CiVl0M26Sn/83a3Bba4zrLJI1gYdbismdjWi2fp6l1cZJhFE0o9BrdkiozZsUwRRX6c8kXRbvO6Mg6dTHr/ZyA2Q+Ejc/3qEXH/jAmiKSFS6B73itXvanmeuaC3YAqR6Wh661WMpEC4RQvTcc1cvc9kpDxgWAUq46ehDiDyWASjufob1FkJBq5v+hUeCny2oiXZUFC4Z7poiUc7tj6redT0Bbdbu9qHqOwPv0RdKZrAblOwxZCgKBRe8ivy59W2zxamwdEMoTsVQY5Z6Z1wqwECI6kmewzopcZ+Uk5jyDyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBe1W+B2fSV6gc8xcog9ObqsMMK9plGgNXzEVXwpq8c=;
 b=DJZOcR7RQ7qYD+dRuCtn1W8OEdwf5YNWlgOKN4iETxdPrduD7NiyWV2U39ABcqK5soSSYgw2EaJiykXtOWdHeLgyBa4U39rKcuRRLEsJRVkrS6a3vAlwVq09VmcMQ7qR1xDG3l9+2eRm5M7KbLLvdWmrnlRDx5V9V1kbQPdjgcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GV0P278MB1269.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:5b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.25; Thu, 26 Feb
 2026 08:30:31 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 08:30:31 +0000
Message-ID: <43045605-55a9-4840-9ff7-779328d096d3@epfl.ch>
Date: Thu, 26 Feb 2026 09:30:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] tests/tcg: add test for qemu_plugin_set_pc API
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com, qemu-devel@nongnu.org
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <2ccc79ee-48ab-4097-a9cc-4d2b79ab9a8a@epfl.ch>
 <383fc3ee-20ed-45e7-bcbb-1c188256bfad@epfl.ch>
 <e317d484-eee2-489e-8c9c-d30f7800cef9@linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
In-Reply-To: <e317d484-eee2-489e-8c9c-d30f7800cef9@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms010705070803000200050309"
X-ClientProxiedBy: GV0P278CA0058.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2a::9) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GV0P278MB1269:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f1ae52-657a-425b-48cb-08de75114d91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|786006|376014|19092799006|366016|1800799024; 
X-Microsoft-Antispam-Message-Info: YT8vhd7V/7omgkENfy6uAJhM2hPhCQLlMEyDs/Ng2dPrZXYIVRf8F0ZuQHC8NnEHdCy4WKuTebB3gt9C2TdCmHMyHcvVkP2rnvdD9GkXHKj8ZUY5+xZyjGWiq2WNm+92e/BrOIr9AOtf9W4vMghg1PKV4pvQVUKFW9M9KBBSyWKsp8mmzH0Yf7K0OMH9AF7pGVGuFOdznPMnFLkO0JedjwKYpoqpg/JyGif4UX7rdiT7tBtOSNQ13HHEU7IVordrDc9cyEkooxdISnyu/EfyQU22g3ApD6NfwD9dWdkEC5PwNlC91t0w8L4wLugke57JsF7bBEwojKvoNraKO8dZ1BYlGC/MnGhI7RBrATuZml1nkNtFtvdkti9+nvhQ6Exnp3OEJVBmxhECLMwVOreBaFgsOztLjltDmt9bTPlH0Gzxnju8l9cdEVtlrNdugTKkGxh7y35jaDeUY/KG5vDWSJvNXSCIMcx+n7dU+qT5WB0GudxNxPUE07nhODybwRh/wdb1vjF8DXgkZMiO1alTfBIozI9PVVYWuO7X6506ZRQiQ37SXM6Mi9eKFGKEvMhQ8/JD5Bf/PGQJsWGxzEiDndv6YkXnqViMBn6/bSDL55gD8ow8khU3MqbUZHQ3HgZYinHUtBbcfyLlOWnes4btJL7fJpYpFJ06yvleLc6NU21iBG4m14QOSoAyLwmYO6uHHZYj82peefySbgPoHTqFyANP9lU+ZB+QFTD698FbNq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(376014)(19092799006)(366016)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODA2NFQyWGVuUUROc240MGI2MDRGQWlVVnk5VlVDRzhkN1gyQ3ZPdXUzWHJa?=
 =?utf-8?B?eWJyR1pOTW5PWFJVS3cvcjdxOXNGaEk5U2xtcVJxN05ra2FXblg0UmFpLyt1?=
 =?utf-8?B?YU8yc2x3NHhXSzFqMXFkb203dzVSOEFXZWN0MWZDSk1zRkxwSkp6QkIxZHNY?=
 =?utf-8?B?aWN0RlFjWXNreGdDNWU2RDZwU1FZVCtkcENXOGdGZUZWUmhocXQyRnRHMTNs?=
 =?utf-8?B?V2xBSkpadjZZc3F0MlZmZGtLSjIwOWsxWkZ2ODFMS3JMeWtPcHlvQ0lFRzc2?=
 =?utf-8?B?QmREUGhaOUNyTllSUWpJZHRjS3pmbmZrVUtIRk1YSXhhWmdyQzREYjlPT1Rm?=
 =?utf-8?B?ZDVNT0NpNnUzOC9Wbzg3UG1XSVJwRnNsdUp3WlN3eUxlT2MrUEVpR3RSRDIv?=
 =?utf-8?B?anJXOXJIOHIzR2I0RlpnREcvMUVOeFJjaGIvclluYjEyQXhoQUhyR1FzaHRR?=
 =?utf-8?B?a3p2dDNJK0dVVEFkazJzS3dUZG9kS0Jram1mTTV0UUhCSkpqeHcwWk9NKzBS?=
 =?utf-8?B?UWg3dVBneXlQK3oxcklEVSt6KzdDak9hNW94eFpTRlRZc2s1dlg1SVp3UnQv?=
 =?utf-8?B?RGFZdkpwREFyNW95MnQ1VzVsOTlpbERsTjRnblNYaDhVOSt0ZE5HaWJVaGZ6?=
 =?utf-8?B?YkdNbzZlaFpIcnI5MzMyS2FONDFGVXBxOVorL01nV1FHVUVQRzJQWkJDYVls?=
 =?utf-8?B?MkVpVUJwMkhZWitQc0tjNHgvN2Nlakw1cG9QSDdmWUgwZ0J1MFdmK3JPc3lr?=
 =?utf-8?B?a3F0Y0F2clJWSlJPZC9JTUlZcXh1bzNCODJaaGhjM1hFZ0NySmNkaTFjdEFu?=
 =?utf-8?B?b0RnWkhrNmROZXBFeGJSTFhEbjlFcUdZRmhUSTdzVnoxcC8yTElzc2o2WDBh?=
 =?utf-8?B?ZUNhNmJzWExKZHZxVTdqOE9GalMxbWF3SE0ydHNGTXdMc3hnWjc0aGkzRWZO?=
 =?utf-8?B?K1VrUnZqWklMM0Vqd0lDajQrZEFKR0tFdStDaGVTLzZyYS9Db3d3dHNGZllE?=
 =?utf-8?B?Z0sxSjM2U1QyTi9NTTh2S0ttVi9WbjhWYTVSbWRTU1B5MVF0ZEltUVZmdHlL?=
 =?utf-8?B?K1lKdCtWU2cwNGJuSTRWZ1FzNXFxMCtnalU1YW9pQm5DR3dmYUlUQzlEY3kr?=
 =?utf-8?B?dVMrK3dHN1U0bDVPWE5BVXFURHcvVUpSdjh0Zkd2TER1WEVhWlFPWEgyS1hp?=
 =?utf-8?B?M0Vwd0JEOVljaFpaZmEvYWd6bTM2SkNGWFI5eDE1cFNjV0dNQlcvU0FtUUtv?=
 =?utf-8?B?MGJJYk1QUkhjK2hlUWtUZThzbWMyMlRLNFp3bWFGRWxMZVJSdXVNMFUyOW82?=
 =?utf-8?B?QmtCdGIwVlJpWElmL0FTU0hYdStKT1RXdjBoUGwweTBUeXVwc2FtVlNRM1N5?=
 =?utf-8?B?Y0lralNhVy8vUGEzOEljRGh0N2ZiVnVaZHlQajZrYllMcWRKUW9SbXBETm16?=
 =?utf-8?B?dzJqbXJLanpsYkhydndaL1d1M0orcjFoZWh2V1BtZFNWVkdXY0tKd2FMZGg1?=
 =?utf-8?B?RSs5S0VJREZUK2RaeWYveTExNVZuK1VVQm5PejFRaGZqdkNPZWtVNWwxWjdL?=
 =?utf-8?B?UnVHUlNPWjJ4UXI0eDVFZzV3Z1lhd3ZUdEtqanFKa0x4aUhFd2RFY01adnF0?=
 =?utf-8?B?d01DNFZDV3BBUGNuT2ZtL2tiWEZlTXZvb1JwK1I4c2pWamRUOXVUSVN1M3Q4?=
 =?utf-8?B?Rk5iblhBOXJTakhVdjQ0ekF4cjdXYVZYcWRuNkUvWDlpdVlqZFh1d0gvaU1w?=
 =?utf-8?B?cTFuOUs2OEVzWXZ1V2sxdUhRaDRJZkR4Wk0yL2xDQkNrQzBKTEFYb3pSMHdo?=
 =?utf-8?B?S0d2cjhTNzRJdVlBZlR6S0Y2bi9UaFVPQktIaVp0eVZXUThTR3FtaHpZeVh2?=
 =?utf-8?B?WFYxYitaR3gwR1ZjTk1mcURSaThacGVLaE1nNk82dHBWWGVzSnd1UHlNWTk0?=
 =?utf-8?B?UGswcGtmWXBTeS9wcyswaGJPSXpmS0x0Z0ZBRkRCVnIzRmtGdDdKWUliZU9T?=
 =?utf-8?B?bXBhSzJHM2YvVnl4dCsxem12Y1dTOWVxWTZyaCtnYnJ4TVFsYkdiYzVzTVRk?=
 =?utf-8?B?NkFGNVNIVTBFcDAzYWp4SCtJSVFacEw3b09abGU5Wmc0U0k0bmc4YkpoOGkw?=
 =?utf-8?B?ZHNMOHg5bnIreDNRQXBvZFBRNUN2VjVKN1ZXbmU3dU1nVHF0Y290RkdSOXEy?=
 =?utf-8?B?amZlbGNkTWJHZlBIbTFYMWh1YWdkcEJMTHZWQUx4WXkwQTJCU3ZIbGxqcU9S?=
 =?utf-8?B?TCtjYnQ0aVJRUHdsUVd5emlHRHNoQS9QejR1Sk9kUHE5OXRORlRTY240ZzFU?=
 =?utf-8?B?R3NBUEVRNXN2dG9TOGdvTnZMQ1J1eHpCcGdUUDJiTTdCcTJ3ZE9GZz09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f1ae52-657a-425b-48cb-08de75114d91
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:30:31.1787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYZ4xvn75kEKq8LxwOm1weNO6QfKIgxsVM9lMqdKVBXtL47CprSLd3BIoB2b0vk6YmD1TzJ2wmxCan5Ecyj4BaipVS/Vraj7sYkKGVRpNsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1269
Received-SPF: pass client-ip=2a01:111:f403:c213::5;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZR1P278CU001.outbound.protection.outlook.com
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

--------------ms010705070803000200050309
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 25/02/2026 18:30, Pierrick Bouvier wrote:
> On 2/25/26 8:21 AM, Florian Hofhammer wrote:
>> On 24/02/2026 16:52, Florian Hofhammer wrote:
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
>>>
>>> diff --git a/tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c b=
/tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
>>> new file mode 100644
>>> index 0000000000..1f5cbc3851
>>> --- /dev/null
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
>>
>> I'm running into an issue for all four variants of MIPS if I don't
>> hardcode the section but pass the function address as a syscall argume=
nt
>> and then use that as jump target in the plugin: according to the ABI,
>> the t9 register has to contain the address of the function being calle=
d.
>> The function prologue then calculates the gp register value (global
>> pointer / context pointer) based on t9, and derives the new values of =
t9
>> for any callees from gp again. As I'm currently just updating the pc
>> with the new API function, t9 is out of sync with the code after contr=
ol
>> flow redirection and the binary crashes.
>>> I think it is fair to expect a user of the API to be aware of such
>> pitfalls (or we can document it), but I'd of course still like to make=

>> the tests pass. The simplest solution (theoretically) is to also set t=
he
>> t9 register in the plugin callback before calling qemu_plugin_set_pc.
>> However, the MIPS targets do not actually expose any registers to
>> plugins, i.e., qemu_plugin_get_registers returns an empty GArray.
>>
>=20
> A lot of things can go wrong when jumping to a different context than t=
he current one, that's why setjmp/longjmp exist. You can always add a com=
ment for this "This function only changes pc and does not guarantee other=
 registers representing context will have a proper value when updating it=
".
>=20
> A reason why I pushed for using value labels, was to stay in the same c=
ontext, and avoid the kind of issues you ran into.
>=20
>> Given this behavior, I see two solutions:
>> 1) skipping the test on MIPS, or
>> 2) making the test code a bit more contrived to use labels within the
>>     same function while preventing the compiler from optimizing the
>>     labels away (which it does even with -O0). I've got a prototype fo=
r
>>     this, but the test code looks a bit contrived then:
>>
>>     int main(int argc, char *argv[]) {
>>         int retvals[] =3D {EXIT_SUCCESS, EXIT_FAILURE};
>>         int retval_idx =3D 1;
>>
>>         long ret =3D syscall(0xc0deUL, &&good);
>>         if (ret < 0) {
>>             perror("");
>>             goto bad;
>>         } else if (ret =3D=3D 0xdeadbeefUL) {
>>             /*
>>              * Should never arrive here but we need this nevertheless =
to prevent
>>              * the compiler from optimizing away the label. Otherwise,=
 the compiler
>>              * silently rewrites the label value used in the syscall t=
o another
>>              * address (typically pointing to right after the function=
 prologue).
>>              */
>>             printf("Check what's wrong, we should never arrive here!")=
;
>>             assert(((uintptr_t)&&good =3D=3D (uintptr_t)ret));
>>             /* We should absolutely never arrive here, the assert shou=
ld trigger */
>>             goto good;
>>         }
>>
>>     bad:
>>         retval_idx =3D 1;
>>         goto exit;
>>     good:
>>         retval_idx =3D 0;
>>     exit:
>>         return retvals[retval_idx];
>>     }
>>
>> Maybe I'm just missing something obvious, I'd be happy to get some
>> feedback on this. Thanks in advance!
>>
>=20
> Can you post the exact code you had where labels are optimized away?
> On which arch was it?

This happens across architectures but I've verified with x86, aarch64,
and riscv64. Below the C code and generated assembly, compiled with gcc
-O0 -o test.s -S test.c (adding -fno-dce and -fno-tree-dce does not
change anything and they should be included in -O0 anyway):

test.c:
    #include <stdlib.h>
    #include <unistd.h>

    int main(int argc, char *argv[]) {

        syscall(4096, &&good);
        return EXIT_FAILURE;
    good:
        return EXIT_SUCCESS;

    }

test.s:
        .file	"test.c"
        .text
        .globl	main
        .type	main, @function
    main:
    .LFB6:
        .cfi_startproc
        pushq	%rbp
        .cfi_def_cfa_offset 16
        .cfi_offset 6, -16
        movq	%rsp, %rbp
        .cfi_def_cfa_register 6
        subq	$16, %rsp
        movl	%edi, -4(%rbp)
        movq	%rsi, -16(%rbp)
    .L2:
        leaq	.L2(%rip), %rax
        movq	%rax, %rsi
        movl	$4096, %edi
        movl	$0, %eax
        call	syscall@PLT
        movl	$1, %eax
        leave
        .cfi_def_cfa 7, 8
        ret
        .cfi_endproc
    .LFE6:
        .size	main, .-main
        .ident	"GCC: (GNU) 15.2.1 20260209"
        .section	.note.GNU-stack,"",@progbits

As you can see, the "good" label and correspondingly the second return
are optimized away, and the compiler replaces the syscall argument
&&good with the address of the .L2 assembly label. This effectively then
causes an infinite loop of the syscall being called over and over again
and redirecting the PC to right after the function prologue.
The assembly output for aarch64 and riscv64 is analogous.

> I tried something similar but didn't see the second one disappear.
>=20
> I wonder if it's related to compiler detecting g_assert_not_reached() i=
s a "noreturn" function, thus it doesn't expect to go past it, and elimin=
ates dead code. You can try with assert(0) or moving g_assert_not_reached=
() to another function "crash()" instead, that is not marked as noreturn.=


As I mentioned above, even turning off dead code elimination didn't
resolve the issue. But this was actually a good pointer nevertheless:
just wrapping the exit in a separate function like below solves the
issue. It's just that the compiler detected that the label is after a
return and deemed it unreachable (obviously not knowing about the
semantics of the syscall).  Below is the modified code that works across
architectures and that I'll use in the end:

    void exit_failure(void) {
        _exit(EXIT_FAILURE);
    }

    void exit_success(void) {
        _exit(EXIT_SUCCESS);
    }

    int main(int argc, char *argv[]) {
        syscall(4096, &&good);
        exit_failure();
    good:
        exit_success();
    }

>=20
>> Best regards,
>> Florian
>=20
> Regards,
> Pierrick

--------------ms010705070803000200050309
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
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDIyNjA4MzAyOFowLwYJKoZI
hvcNAQkEMSIEIIjQ8RGBn6oMUQZrt+WJSQZkVNLSmKcJs4ivBS0s4A/kMIGFBgkrBgEEAYI3
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
gQQBDgIwCAYGK4EEAQ4DMA0GCSqGSIb3DQEBAQUABIIBAJNkR+zNg9fytMpmnyOI70AUTozo
J5pkZ1RrQgCvjjgeoTVcHi5EeG1OJRTU5Te3mmQ9Jncle2JLC4ZWEOSK867byVvwyhfWDyHs
vhaQP/mdryUF73/5j1heiAUYaxtA7+cbntgISpI1yy1QzZ3aYRbzQ5xBRc6MuleiEuDCzmJp
vXp3xLGN8aSaHKX/RsR4uHYD1PbhQeFzwm1coI0zFX4PwvACgqUiSkx6E0rlyQoTCjDHamxP
ZXa1C78wr0HY/w6hMK/cw9proWegIOQOIiA1KxSR9nv68wHToMiE/+LwnSZpjxArEVPTszgS
saPmPzMx5YdtBTru1xCobc87xdAAAAAAAAA=

--------------ms010705070803000200050309--

