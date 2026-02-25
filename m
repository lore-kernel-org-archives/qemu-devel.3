Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28464EFD214
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 09:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvBCr-0000jB-MQ; Wed, 25 Feb 2026 04:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vvBCp-0000iy-8E
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:29:19 -0500
Received: from
 mail-switzerlandnorthazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c213::5] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vvBCl-0004MB-Pf
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:29:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvIf71r8PEhFOsiYiiifpSF2FCwIxO29+TpzpjYvJigoBJBaDUF0znYT9Woh2fnwJERbLqfGtDQyvkzdt8oFlado5iWazTkL0CdzyZCHLVylS2+cfVNk50/aOrriHNyidTs1t2Y6kPgFrAP/S48mSi6lf2+eVPej5yTkEfW1DZEiOmyvQqBr35RvUJH4+pqQPyDMmePvWYTyPGo+tlTHEklhZTUVN6e4wH9/0gmrfT05B7g1BCMs/8LcVbgJVOloVmo3NTTV1w7Q9tFAr9Fhx4JlCPbVT9K80Po0d+T15CYhluEY+9f9mmR2DlYSA/jwRpQ21wYE46bLhKDbXf7sSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqIzzy2S46+FbrFl4StyxjfFZ4tVg4wZ2vk7uOed+LE=;
 b=LHmwVtgkv8U9TFs4AuZPOpvwWagLYQkpgVx/86IHicxzDtC0zA7dnHDxWc5gy7XjJf0QrCf17UcsdjlOGqDpv3wQgykpRYj0QgRG9BVR46PqZDQghltxAHcBbnbNtQkLGjo6PsTVzc0B3Ik4og5/u1seACB2aHJgYdJBK/HnxWu7pOMzVZtGFUn+M++BarUzsl/W1UXIXfBj9N7iHDaN+B8wBLmWbQ/6tjnh/xVvViltRE5E+KYsEaXnEFFjLFLEIfKyuR1ith9xrkK/BnTlzCCgNCpH/4iYgFSJbl7U5JB8LabIWBcAgHgsDDBk32XpZlBDdAoKWSbgN9PBze++hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqIzzy2S46+FbrFl4StyxjfFZ4tVg4wZ2vk7uOed+LE=;
 b=JA7rR+yRodPcDkuoBNnGC1Q5JB1lYkhv0nrzhxbdL0BBknT+5NGEfbdL3GyWI53njaJ+2LvpYlkcYZf9m/jdgWpL9+K8u68xSC6dqlR4VnEnvHbf9fwMlxoXOD3ujBwj8hu098yXK1Clj2cSN6Umrqxy4toatufQ7lYgbzT5+HU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR3P278MB1273.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 09:29:08 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 09:29:08 +0000
Message-ID: <ef465a2b-d790-406e-a1fa-a7a5f95c18eb@epfl.ch>
Date: Wed, 25 Feb 2026 10:29:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] linux-user: make syscall emulation interruptible
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, laurent@vivier.eu,
 imp@bsdimp.com, berrange@redhat.com
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <8096590c-bf13-4e5e-8167-ab38a37180bc@epfl.ch>
 <538ada16-07b8-403c-b1fa-f42db7cfc195@linaro.org>
 <874in52mzy.fsf@draig.linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
In-Reply-To: <874in52mzy.fsf@draig.linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms060804090802070807060004"
X-ClientProxiedBy: GV0P278CA0023.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::10) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR3P278MB1273:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eeca218-0047-4fa5-abc8-08de745053a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|786006|1800799024; 
X-Microsoft-Antispam-Message-Info: JvnOjOh1Spnlk1lROmrwHzrDHozwYnqQg2nNDR2jojSYmUAHMg8zE52yiM9I2INXJmGRbpXvk7j/K5lum1UjjOkoGsU5GW3ENa4WQcG+Fy+dVDlz+S4kbk+P0eVtHH22LkIE6KtKpnJl4aXv6UrovBn+QkRBXgKBQArnQgWEOBYmovaHaTT+Tiq3rJOrZ5BJOS1P+zLgyIwN87FbSHWei2Z5IKVttzmkKvxjY20pWc5moP/TpNQyo5pgfUuDmtVfHwLyee8DdgS04BvvJHjCv8sojo+uFxImHObDcU0MLk5IWp5N+5+kXkmYOM9YeAd4Am4/1y/Q632pc26u7bbT0PdPLGIJdNqbzRY+A8THpTtg2sDgPvX6iH485Am1nxxTh/OWP6rWCKNOg4ck/tMaYycHzG6cItgczyR/LJDG+cf3kU7hEYIDYS0byT8nNyWeh1dV7+zBfFAC/4HrIWi0fgZzAawOyH2NTR8yRII5YhmUAe24vqmwEybXW3WhS3N2FSet8xmzzzNG/T1pdjy786QqToljGEdFzC3Q6WXrtOxFFVDSwJcMZY8pvG68rpzsSuiWP7HDlJ8H9k1ygKJBTj4pYr6ajpCAaQ9qpAvREB5RV3xSEn4zp+L/AjJ3Q7dOE158fLLRNmfZRTnq5e6+Fa+9n/ZJIEmQza/fU4z24nrZVVKAYn31WSpVRlZOKKZ168YsSNHT65DodKwfDTwIEDuIW9WggBOuEcVz+tkS3Cc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(786006)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blJQak5mVkFURU5NSWYwYXVTWE9JRzQ4MUZyZi9NM1pDZFNKSS9xNlJwdEVM?=
 =?utf-8?B?VVhLd0tJVUhWRXlmbjFlRnBndEhSQTZBL2F2dElyVVJuMTQ3U0pVMmhWTXFS?=
 =?utf-8?B?QzUwM3JVWVg0VWFSWmJ3Ukh4Smo3b0l3RVFHd3JmbHZHekpWK2RiVTRyVVhr?=
 =?utf-8?B?Q3pKMld6OHlGZVdEOCt4TTAzdndYbXg2Z1RFRStSdkNRQ2NSdG5CWE1OenZG?=
 =?utf-8?B?QjBBSzhIK1JHQ3owcE9KUlRmckV5UFpFR0laWEd6NUVuYWdOUnY2Z2tGWk5X?=
 =?utf-8?B?cTQ4SXJFa1Y5enBNUW9qWTQ1NFJBTnRoZ1ppYWV1eGVGUlVZcXRwYjRYOUlT?=
 =?utf-8?B?TFVYdnBtSG8rRXVvc2RmTWRENG9hK3lNSHhhd1FZOW1xM0ZudElwWkZJemNh?=
 =?utf-8?B?N3RiNkZlTk10eG83VmdObGtvSUZWSGpRWEFNZ2pwVWJZT2QzY3FoSkdHQUJW?=
 =?utf-8?B?U2EwWUZCNkVTTDV6eHF3T0dYQkJJOW5lckIvdU5XdlRDUDJUZkZMZW0wNno3?=
 =?utf-8?B?aFFYWk95Mjd4MVNRY3FDeGRnRzZySUZla2toOTZYck9WTit6YUxuL1NPMmd3?=
 =?utf-8?B?a091MEtCcW9LM0VnaVQzdUVvRzZQSm16WDVZODNDMC8yUmdVQXlLeGhxY0V4?=
 =?utf-8?B?emZOR05xcnNpRnZFcmMxV3Vzd3NNSjBscmFFRVZIa1FqdUFQNmVHeVdkWW9s?=
 =?utf-8?B?OFJVR1dIR3JXMWdRMldONFpPS21TMFByN3RpQ3VNUDllK0lyRzJ2VVlsRGtK?=
 =?utf-8?B?UkZ5K24zdzVXajJzSTVVbDNFcGpudHhVQ0VDSk5mc3RSb09DNlA1ZWoyQUh1?=
 =?utf-8?B?Z3FVTFk4UVZXVStGdzdoS0paZHdtc3UwNFQ2MlJ6NVFPMXhXQUNMRlhNQmlD?=
 =?utf-8?B?ZXA1Wkw4Rk5IQ2JxejZ0ZVVTQWlZVzhQaFJGeUwyWDAwNStEc0hrYUtYaUEv?=
 =?utf-8?B?YnBxR1JIamNpZnlWZmRRNSs4Sjh5d0RaZnQvREZvd3pWZjdWU1F3K2RjVkJN?=
 =?utf-8?B?Y1BPNXFhRU1JeGxId3ZyVTE5MWU3RlZwNm96U01LV2MwUE8wOGFyUXlxZXhn?=
 =?utf-8?B?cjFVWHkydXRDMzhhVVFaS0VYelZ6Y3hWYUU1TUNLL2oyUTJBdGpob1ArV1JS?=
 =?utf-8?B?cFZHbFlCWHZCQnJFUGJCV2VaSU5YYTRDMVBrdE1DcDh1WnZQbGVtQUs5Ui94?=
 =?utf-8?B?VTNVSk1qaVVFWnQ4U0sxWXpCbjN4U3I0ak9QYmpHZStvOVNua3lPTXd5RHpU?=
 =?utf-8?B?aU1DUENoU2dmV096Z2UxVWRSYXBzdkVid09nbW40NDdmT3gwSW1ya1hBOVR6?=
 =?utf-8?B?dkRtMEpudEpxaG5HVnl0OG5BV3kzT08xaUxoNGJQOGZaWllMa0wyS2NoSHBF?=
 =?utf-8?B?R0VjTUNCb2ZZU1dnRC9waTA0NkQ5czN2eXViSTMvMHRlVVRycmpuM0NzN1h3?=
 =?utf-8?B?c2xMRWIwRWtEMU1ILzBRRXpmeXRnMkdENHIvanVvTGY3RERIWlg0Z0VnMVp5?=
 =?utf-8?B?U3Npa1F4SCtzVWJmY0k5TGxwcWtJK2Voa1IxSSt6OEhZeHIvcXJsMEppejJJ?=
 =?utf-8?B?dlZGV0J5Z1BmN3BWZmZjRFhsRVNIaDVXUHJZWjU2cGY4YngvUC90VTVCeWNx?=
 =?utf-8?B?eHdRaHVodmhqWUlQVkhPYXVUQXk2RG9kVEZnVERVQVZ6N1p1amhIY0JQTk1t?=
 =?utf-8?B?OE1kcFd5cHQrN3dXanorQTNEK0dwcXVES0YvQkRQcXhRRWlGVVltd3NXSTdV?=
 =?utf-8?B?cVJqZ0k2UHVFSFhyMFpRbXQyRVBFeUs1TlhOYVRUVHY1UytNbGpweXhOKzVs?=
 =?utf-8?B?d1B2NWUwMFZpVnljcnJjWmkzNGJraU1lNnloaHlhVjkvZEF6QWxJL3VCY3Jk?=
 =?utf-8?B?bjY2b29sMzZxbGtoaVBJSjRIK0s2VXE5ZXJjN2gvaXFQQUVwREVDazU1WlpW?=
 =?utf-8?B?RUVsY012UkJkak14Q0kzR2tjSUQvZ1l6dmZCMk0yblZMRXV1Z2xlYVRvejlK?=
 =?utf-8?B?OUMxQUFkUWhJbDlEcEhBbDNzWU5CUnAwVG9YSVU0cWlVeVA2b3NpbjV0OXJ5?=
 =?utf-8?B?SkxzN2R3ZlVvdWltVVAxckk0U01JSXdOUVdFdzUvNjZ1eTF2aTVKb1pkczhh?=
 =?utf-8?B?ODYxa1paWXpjS1VuY0JqVUFmTVcrV2Y5Skp3UFIvdVpjc3NNUlJGaSs1L2pi?=
 =?utf-8?B?V3l4NlJ4ckVMNTFySytMK0wyV3FJQm9GMlZWQ2lFZnVwY1ZLMUJHS0kyVU41?=
 =?utf-8?B?N0xBYjhHcTlOTUFLOWorMk9VN05BVUZleWZyK0pDWkpxNmtENXpYdFc2UWhx?=
 =?utf-8?B?T1hIdW9acklRN1kxZTNqTkVQV3F6T1RhaC9UemlhMnJtY2JNcFF3dz09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eeca218-0047-4fa5-abc8-08de745053a0
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 09:29:08.5068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1DnIzdkq7bjjXREeH2p7LWtqWzry3FIvPR+Sotqj1zcNcPLt4jVkUsNaS6nJg2lkQnxkHdg06boI3oMzat3TsENNL2wqVJEHZZTqcBkoAMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1273
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

--------------ms060804090802070807060004
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 25/02/2026 10:25, Alex Benn=C3=A9e wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>=20
>> On 2/24/26 7:50 AM, Florian Hofhammer wrote:
>>> The syscall emulation code previously wasn't interruptible via
>>> cpu_loop_exit(), as this construct relies on a longjmp target that is=
 not
>>> live anymore in the syscall handling code. Consequently, longjmp() wo=
uld
>>> operate on a (potentially overwritten) stale jump buffer. This patch =
adds an additional
>>> setjmp and the necessary handling around it to make longjmp() (and by=

>>> proxy cpu_loop_exit() safe to call even within a syscall context.
>>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>>> ---
>>>   linux-user/aarch64/cpu_loop.c      |  2 +-
>>>   linux-user/alpha/cpu_loop.c        |  2 +-
>>>   linux-user/arm/cpu_loop.c          |  2 +-
>>>   linux-user/hexagon/cpu_loop.c      |  2 +-
>>>   linux-user/hppa/cpu_loop.c         |  4 ++++
>>>   linux-user/i386/cpu_loop.c         |  8 +++++---
>>>   linux-user/include/special-errno.h |  8 ++++++++
>>>   linux-user/loongarch64/cpu_loop.c  |  5 +++--
>>>   linux-user/m68k/cpu_loop.c         |  2 +-
>>>   linux-user/microblaze/cpu_loop.c   |  2 +-
>>>   linux-user/mips/cpu_loop.c         |  5 +++--
>>>   linux-user/or1k/cpu_loop.c         |  2 +-
>>>   linux-user/ppc/cpu_loop.c          |  6 ++++--
>>>   linux-user/riscv/cpu_loop.c        |  2 +-
>>>   linux-user/s390x/cpu_loop.c        |  2 +-
>>>   linux-user/sh4/cpu_loop.c          |  2 +-
>>>   linux-user/sparc/cpu_loop.c        |  4 +++-
>>>   linux-user/syscall.c               | 16 ++++++++++++++++
>>>   linux-user/xtensa/cpu_loop.c       |  3 +++
>>>   19 files changed, 59 insertions(+), 20 deletions(-)
>>> diff --git a/linux-user/sparc/cpu_loop.c
>>> b/linux-user/sparc/cpu_loop.c
>>> index 7391e2add8..f054316dce 100644
>>> --- a/linux-user/sparc/cpu_loop.c
>>> +++ b/linux-user/sparc/cpu_loop.c
>>> @@ -229,7 +229,9 @@ void cpu_loop (CPUSPARCState *env)
>>>                                 env->regwptr[2], env->regwptr[3],
>>>                                 env->regwptr[4], env->regwptr[5],
>>>                                 0, 0);
>>> -            if (ret =3D=3D -QEMU_ERESTARTSYS || ret =3D=3D -QEMU_ESI=
GRETURN) {
>>> +            if (ret =3D=3D -QEMU_ERESTARTSYS
>>> +                    || ret =3D=3D -QEMU_ESIGRETURN
>>> +                    || ret =3D=3D -QEMU_ESETPC) {
>>>                   break;
>>>               }
>>
>> Just a style nit:
>> if (ret =3D=3D -QEMU_ERESTARTSYS ||
>>     ret =3D=3D -QEMU_ESIGRETURN ||
>>     ret =3D=3D -QEMU_ESETPC) {
>=20
> I was hopping the ret test could be wrapped up into a helper but it
> seems sparc and x86 have enough variation in handled ret codes to make
> that difficult.

It's not just x86 and sparc, there generally seems to not be consensus
on whether return codes are checked via a single conditional check (as
is the case with sparc), dedicated conditional checks for each possible
error value, or via switch statements. I think moving that into a helper
would require a bit of refactoring across architectures.
I could check that out for a follow-up patch set if you think this makes
sense.

Best regards,
Florian

--------------ms060804090802070807060004
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
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDIyNTA5MjkwM1owLwYJKoZI
hvcNAQkEMSIEIIib8PWy0hIYABK84FEiHK22SkUZjcDwLDoEykibodZrMIGFBgkrBgEEAYI3
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
gQQBDgIwCAYGK4EEAQ4DMA0GCSqGSIb3DQEBAQUABIIBABPcZdddW0QZXJfIBTiYd8HSqZ2W
s3Pn5NLHobITzehHCvtiCIRJXRmFLox6w0FIk1F5fvMDZvENjaSolaSYW9RIHc1xEZIUozq1
fN1d2Zabwyc8Tcsj3GDgbmhfYqcgLT34s8NGFJb1l2jkGA9c1iX3ADdCUDcuJII4rmbI+H2L
pbUJbP5rbxup3xYVpzOrV3tgwg5N1+IZGofY9Tzql7ZhcNnWXQ274xvu5EH66Rr8R2MFl6PY
gljeGEILHioHfiqs3PO8Fc8it4zAMZiyIjq/U7I+dzqKnUH8qmlN58Y07TzB2VSa5JpRJBqS
FGa4AkHI6Y77qkS0i4JGyzSI3ewAAAAAAAA=

--------------ms060804090802070807060004--

