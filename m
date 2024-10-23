Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E4AD2E029
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 08:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3X91-0006BA-LE; Wed, 23 Oct 2024 04:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3X8z-0006Ae-PO
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:55:05 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3X8x-0008Ev-Hi
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:55:05 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9a6acac4c3so787028666b.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 01:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729673702; x=1730278502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4nV+gFBdOxqmJZLzNg4LSvDE9AZxO4UfO8dN4L5Zwg8=;
 b=UnRRNZm8X00T6a1YzRS3bLT8EAE4QriYPtK97S5wYu57PvuO4LoTfLQBpupbvgy+hR
 1ThYUwEnZVkEMUrZShAtG3uq+El2fQR35lYuyr03vKKGltnw4C50XWnT4KUDyHmBM5/F
 1RztZizAWfXV6o5GB9MRZnYWqgLdnVrKrEJIZv4g4zem1ehEDuRlC8+1ubqSdn933KKz
 ajSZL3SKIYQUfXCXVGdWaLakcUpxU/1zIhsaUzgscZsTE5RINoNtKxvpFagZM4bWr+x1
 zsT2ZXLNdAfOu6qd489m2QkBn5auglno/jHT5wCEToOA4zW26mpLqmiiqw0i3vtBT1zM
 hSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729673702; x=1730278502;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4nV+gFBdOxqmJZLzNg4LSvDE9AZxO4UfO8dN4L5Zwg8=;
 b=j7YYFNKcHJDUaXO5xQ3ZGbjl/W6OSb/2mpY0DagAfJ9qoy6TuBjbxRtXt3KEdsvAjb
 /tMZAEazfUKiyeXk0xkWxVzVGLxFlEqXcf/vKoe0iBd3/9qBeHtJvz1HamZWrebpfgkE
 a09qt3RD5yVBNUmyj4Y3kxS3JCb4d+WCawhpjmU0UoVHtU6QKG/L1egFYwBbwjeGt1fi
 sabZlvK/Ez+EducHessapNRgrvSphBoelGnzAYO/FQVLEp0GfuJzq3ynZqIRba+q2TO0
 SLefce4BqvSX/Ab1Wc+fwSgPo6ymaZflkUwySzIsYxXxaQKqzgTM30pHEWP4hQPU1Ys6
 dnIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5nGZsys6/xDKRBsves99V8bYJCXO6FBeq0OCQO4hNRIHwTXqdDEav3oDxGtoQ+4y0qkyCWbDPp8Hi@nongnu.org
X-Gm-Message-State: AOJu0YyE3eTMyBqDp51GKRdiAZcRhUXjhV/R/WSw58ttr5XYG3qZJEGh
 SIQ3XZaVnRW4tA9l6Dbh18u9GHqIDstPpmr3m4jK2GEgANR/FrZJdLFEa4spbUk=
X-Google-Smtp-Source: AGHT+IH5mgOf6nBi3FexnUloTPhurMRvjZcBfsAfb+txFGnfsd/xbEK3VgHAOJKBZRN/XgBmwtSTaw==
X-Received: by 2002:a17:906:c151:b0:a99:e505:2089 with SMTP id
 a640c23a62f3a-a9abf9219c3mr146622966b.45.1729673701922; 
 Wed, 23 Oct 2024 01:55:01 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912d6328sm445752966b.40.2024.10.23.01.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 01:55:01 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 293D55F89C;
 Wed, 23 Oct 2024 09:55:00 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,  qemu-devel@nongnu.org,  Beraldo
 Leal <bleal@redhat.com>,  Laurent Vivier <laurent@vivier.eu>,  Wainer dos
 Santos Moschetta <wainersm@redhat.com>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,  Yanan
 Wang <wangyanan55@huawei.com>,  Thomas Huth <thuth@redhat.com>,  John Snow
 <jsnow@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  devel@lists.libvirt.org,  Cleber Rosa
 <crosa@redhat.com>,  kvm@vger.kernel.org,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?=
 <philmd@linaro.org>,  Alexandre Iooss <erdnaxe@crans.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Riku Voipio <riku.voipio@iki.fi>,  Zhao
 Liu <zhao1.liu@intel.com>,  Marcelo Tosatti <mtosatti@redhat.com>,  "Edgar
 E. Iglesias" <edgar.iglesias@gmail.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 07/20] tests/tcg/x86_64: Add cross-modifying code test
In-Reply-To: <17ab6a26-bfd2-4ee6-8fc4-c371d266dcb1@linaro.org> (Pierrick
 Bouvier's message of "Tue, 22 Oct 2024 17:33:21 -0700")
References: <20241022105614.839199-1-alex.bennee@linaro.org>
 <20241022105614.839199-8-alex.bennee@linaro.org>
 <6b18238b-f9c3-4046-964f-de16dc30d26e@linaro.org>
 <4c383f09bd6bd9b488ad301e5f050b8c9971f3a2.camel@linux.ibm.com>
 <17ab6a26-bfd2-4ee6-8fc4-c371d266dcb1@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Wed, 23 Oct 2024 09:55:00 +0100
Message-ID: <87y12fkxln.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 10/22/24 17:16, Ilya Leoshkevich wrote:
>> On Tue, 2024-10-22 at 13:36 -0700, Pierrick Bouvier wrote:
>>> On 10/22/24 03:56, Alex Benn=C3=A9e wrote:
>>>> From: Ilya Leoshkevich <iii@linux.ibm.com>
>>>>
>>>> commit f025692c992c ("accel/tcg: Clear PAGE_WRITE before
>>>> translation")
>>>> fixed cross-modifying code handling, but did not add a test. The
>>>> changed code was further improved recently [1], and I was not sure
>>>> whether these modifications were safe (spoiler: they were fine).
>>>>
>>>> Add a test to make sure there are no regressions.
>>>>
>>>> [1]
>>>> https://lists.gnu.org/archive/html/qemu-devel/2022-09/msg00034.html
>>>>
>>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>>> Message-Id: <20241001150617.9977-1-iii@linux.ibm.com>
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> ---
>>>>  =C2=A0 tests/tcg/x86_64/cross-modifying-code.c | 80
>>>> +++++++++++++++++++++++++
>>>>  =C2=A0 tests/tcg/x86_64/Makefile.target=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 4 ++
>>>>  =C2=A0 2 files changed, 84 insertions(+)
>>>>  =C2=A0 create mode 100644 tests/tcg/x86_64/cross-modifying-code.c
>>>>
>>>> diff --git a/tests/tcg/x86_64/cross-modifying-code.c
>>>> b/tests/tcg/x86_64/cross-modifying-code.c
>>>> new file mode 100644
>>>> index 0000000000..2704df6061
>>>> --- /dev/null
>>>> +++ b/tests/tcg/x86_64/cross-modifying-code.c
>>>> @@ -0,0 +1,80 @@
>>>> +/*
>>>> + * Test patching code, running in one thread, from another thread.
>>>> + *
>>>> + * Intel SDM calls this "cross-modifying code" and recommends a
>>>> special
>>>> + * sequence, which requires both threads to cooperate.
>>>> + *
>>>> + * Linux kernel uses a different sequence that does not require
>>>> cooperation and
>>>> + * involves patching the first byte with int3.
>>>> + *
>>>> + * Finally, there is user-mode software out there that simply uses
>>>> atomics, and
>>>> + * that seems to be good enough in practice. Test that QEMU has no
>>>> problems
>>>> + * with this as well.
>>>> + */
>>>> +
>>>> +#include <assert.h>
>>>> +#include <pthread.h>
>>>> +#include <stdbool.h>
>>>> +#include <stdlib.h>
>>>> +
>>>> +void add1_or_nop(long *x);
>>>> +asm(".pushsection .rwx,\"awx\",@progbits\n"
>>>> +=C2=A0=C2=A0=C2=A0 ".globl add1_or_nop\n"
>>>> +=C2=A0=C2=A0=C2=A0 /* addq $0x1,(%rdi) */
>>>> +=C2=A0=C2=A0=C2=A0 "add1_or_nop: .byte 0x48, 0x83, 0x07, 0x01\n"
>>>> +=C2=A0=C2=A0=C2=A0 "ret\n"
>>>> +=C2=A0=C2=A0=C2=A0 ".popsection\n");
>>>> +
>>>> +#define THREAD_WAIT 0
>>>> +#define THREAD_PATCH 1
>>>> +#define THREAD_STOP 2
>>>> +
>>>> +static void *thread_func(void *arg)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 int val =3D 0x0026748d; /* nop */
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 while (true) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (__atomic_load_n((i=
nt *)arg, __ATOMIC_SEQ_CST)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case THREAD_WAIT:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case THREAD_PATCH:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 va=
l =3D __atomic_exchange_n((int *)&add1_or_nop, val,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 __ATOMIC_SEQ_CST);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case THREAD_STOP:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn NULL;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as=
sert(false);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __=
builtin_unreachable();
>>>
>>> Use g_assert_not_reached() instead.
>>> checkpatch emits an error for it now.
>> Is there an easy way to include glib from testcases?
>> It's located using meson, and I can't immediately see how to push the
>> respective compiler flags to the test Makefiles - this seems to be
>> currently handled by configure writing to $config_target_mak.
>> [...]
>>=20
>
> Sorry you're right, I missed the fact tests don't have the deps we
> have in QEMU itself.
> I don't think any test case include any extra dependency for now (and
> would make it hard to cross compile them too), so it's not worth
> trying to get the right glib header for this.

No we only have glibc for test cases.

>
> I don't now if it will be a problem when merging the series regarding
> checkpatch, but if it is, we can always replace this by abort, or
> exit.

Its a false positive in this case. We could tech checkpatch not to care
about glib-isms in tests/tcg but that would probaly make keeping it in
sync with the kernel version harder.

>
>>=20
>
> As it is,
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

