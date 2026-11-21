Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7A9606A320
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Nov 2026 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=MFPv0bkU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUnKV-00038c-Rg; Sat, 21 Nov 2026 10:48:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pobrn@protonmail.com>)
 id 1xUnKT-00038K-Hw
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 10:48:41 -0500
Received: from mail-24417.protonmail.ch ([109.224.244.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pobrn@protonmail.com>)
 id 1xUnKR-0003LW-9l
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 10:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1795276109; x=1795535309;
 bh=Y0h6JoaFlpaC6JfScONqGm1Tq86KaBgM3YEuPZ5mLDA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=MFPv0bkU60+DEo9BtC8CZKwnzKG6lmNAPwiDhjWxbLiUH+/4CwXdoHhnWckbF328m
 alcsfxxeMTf0reMoK/rWt+HxMxTRb8E8fM1jvSkDif95smNBOrKrACegstEfqfPRa6
 UHYEEY5jH7c2HsE0/Y33zNzYXNADF5znHqDuOPfpqryy3NcKXztSRNiPgJrUjJvorA
 aYiVfn7cwsxSbDJY+pGhmmbd8IfxPCdapgyqf0kkOnlqRUmED9Fmr8rAqNldfrb6tq
 Gdqe2YkZwkgHQ9qKMKNLfjstkoSLh/8jFcXAa6e7QJwn+rBE20mwkhR6Ifk8UwfjF5
 slaa7Ld9jhiMw==
Date: Sat, 21 Nov 2026 15:48:22 +0000
To: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
From: =?utf-8?Q?P=C5=91cze_Barnab=C3=A1s?= <pobrn@protonmail.com>
Cc: qemu-stable@nongnu.org
Subject: Re: [RFC PATCH v1] linux-user: do not emulate PI futexes given
 endianness mismatch
Message-ID: <9203e54f-0381-41c6-af2a-08e5e44188d8@protonmail.com>
In-Reply-To: <d48a6e69-a07b-4dda-98d0-2bfe0194839a@gmx.de>
References: <20261119191247.391446-1-pobrn@protonmail.com>
 <d48a6e69-a07b-4dda-98d0-2bfe0194839a@gmx.de>
Feedback-ID: 20568564:user:proton
X-Pm-Message-ID: 0f3c486283c8a6c06c37531ea5994b66473d2dbe
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=109.224.244.17; envelope-from=pobrn@protonmail.com;
 helo=mail-24417.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

2026. 11. 21. 0:41 keltez=C3=A9ssel, Helge Deller =C3=ADrta:
> On 11/19/26 20:12, Barnab=C3=A1s P=C5=91cze wrote:
>> For PI futexes, the futex word is expected to contain the thread id in n=
ative
>> byte order. And failing to emulate that leads to issues as e.g. glibc do=
es
>> not expect `ESRCH` to be returned from a `FUTEX_LOCK_PI` operation.
>>
>> If the mutex is set to be "robust", then this is detected as unrecoverab=
le
>> failure and glibc aborts (since a robust mutex should've been unlocked b=
y
>> the kernel when the owner dies):
>>
>>     Fatal glibc error: pthread_mutex_lock.c:450 (__pthread_mutex_lock_fu=
ll): assertion failed: e !=3D ESRCH || !robust
>>     qemu: uncaught target signal 6 (Aborted) - core dumped
>>     Aborted (core dumped)
>>
>> Since `FUTEX_LOCK_PI{,2}` cannot be easily emulated when the host and ta=
rget
>> endianness differs, do not handle them, and return `ENOSYS`.
>=20
> Your patch seems correct, but that makes me wonder if it makes sense to
> propose a kernel patch (and additional qemu patch) for
> FUTEX_LOCK_PI3
> and
> FUTEX_CMP_REQUEUE_PI3:
> where the thread id is always stored in little endian format?
> That way emulation is possible (I think so), and little endian format
> since nowadays all major architectures run little endian. That way only
> the big endian arches suffer a little, but have the benefit to be able
> to be emulated on any arch.
>=20
> Thoughts?

I have a feeling that such an api would not be welcome by the kernel since =
it arguably
degrades the performance on big endian, and is only there to help with the =
(arguably niche)
use case of qemu user emulation.


>=20
> Helge
>=20
>> This allows
>> e.g. glibc to detect that they do not work and handle things accordingly=
.
>>
>> Link: https://gitlab.com/qemu-project/qemu/-/work_items/4911
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
>> ---
>>    linux-user/syscall.c | 8 ++++++--
>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 2fc61b3eab..c5fbd30e28 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -8243,6 +8243,7 @@ static int do_futex(CPUState *cpu, bool time64, ta=
rget_ulong uaddr,
>>        case FUTEX_WAIT_BITSET:
>>            val =3D tswap32(val);
>>            break;
>> +#if HOST_BIG_ENDIAN =3D=3D TARGET_BIG_ENDIAN
>>        case FUTEX_WAIT_REQUEUE_PI:
>>            val =3D tswap32(val);
>>            haddr2 =3D g2h(cpu, uaddr2);
>> @@ -8250,10 +8251,11 @@ static int do_futex(CPUState *cpu, bool time64, =
target_ulong uaddr,
>>        case FUTEX_LOCK_PI:
>>        case FUTEX_LOCK_PI2:
>>            break;
>> -    case FUTEX_WAKE:
>> -    case FUTEX_WAKE_BITSET:
>>        case FUTEX_TRYLOCK_PI:
>>        case FUTEX_UNLOCK_PI:
>> +#endif
>> +    case FUTEX_WAKE:
>> +    case FUTEX_WAKE_BITSET:
>>            timeout =3D 0;
>>            break;
>>        case FUTEX_FD:
>> @@ -8261,7 +8263,9 @@ static int do_futex(CPUState *cpu, bool time64, ta=
rget_ulong uaddr,
>>            timeout =3D 0;
>>            break;
>>        case FUTEX_CMP_REQUEUE:
>> +#if HOST_BIG_ENDIAN =3D=3D TARGET_BIG_ENDIAN
>>        case FUTEX_CMP_REQUEUE_PI:
>> +#endif
>>            val3 =3D tswap32(val3);
>>            /* fall through */
>>        case FUTEX_REQUEUE:
>=20



