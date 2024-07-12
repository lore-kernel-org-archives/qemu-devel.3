Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44959C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 14:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSHcu-00027b-Sj; Fri, 12 Jul 2024 10:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sSHcs-00026L-K0
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:51:58 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sSHcq-0005vm-EO
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:51:58 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a797c62565aso236162466b.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 07:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720795914; x=1721400714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8QTkIIdS2nN+gUDX+QLNAham2cTEd2/yZlWuPxIsVKQ=;
 b=zG35t1C1RQfJ5qQJM5dV9GhSlmAQnoEI9SbBNdDZxGQLEBM+UCeKnNdqNtV+t1fpMz
 nPcELk6Hw8L2Fhe9jZsnt9ADiqI32uF4bM+HTnNtJaYc/e+JE++TAzhgihXWEyhA1kk9
 R5e9hTxw0H3o/itCMkxl0ly0lCKaelSpBjHeB978vb0Vhq9abO4KqOL3c6YL8NHpXEO6
 yOQONeqpIO7ILX+OJVbLBJaALu+9QUMcVOu+efYP5EpAYv8336hH3R1yj3v9f75yLq9e
 5qO+au4J0Y7OQjZiITAealaZUt2HaXnTvK0LKZ7twDnH+94lDD4yk5o1DX5osh4MqgyI
 lf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720795914; x=1721400714;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8QTkIIdS2nN+gUDX+QLNAham2cTEd2/yZlWuPxIsVKQ=;
 b=NoAEOv8XjqcAiSVEctBGV7PA3FsdbcBshPLfB8fDesOxTexRzs7RyGlaBQDfXumojv
 8utshjaJoEIBO+5Fe2wm+zgKN+qd7o04PkgZVK0kGQnEYYRfCpjYXg+wtAViQ32m32oi
 IxA0stBL7e5zXCn2msZJE5bSAFX+skAkaHCtAvKmV97NAWOqOoFR9uV51JG1N6viF9ZV
 aXebhLdGSmnt/bp+xRd0TN2ZH68LY6Y5JLL+ghVta10l8ajSeRyho6z/IOLzNaUy93Al
 afzXOOw9XlDrhHhOQ0sjeMtqcucecboZfSI9tkYK4WDAoBq/ch7xQPA+h/Ml/LS+M6p7
 u2zQ==
X-Gm-Message-State: AOJu0YwKeMxrVKGT66/ysmcUVDyXDLgQmT+tLsmSJ3ebYCZGry6ZJOGS
 dV54Q3+mQ/yDUKyjAnLxyPWnC1x1hmoO0xyAAt25/MDwuXteHdwq9Sdi70NyNlg=
X-Google-Smtp-Source: AGHT+IEIeDFbOzkxi7MZW19rih35plOgoLuLVpocLTzJQoFAXlAarU49mdddKgK1mTLNguJoJnuzkQ==
X-Received: by 2002:a17:906:f146:b0:a72:81f5:85b6 with SMTP id
 a640c23a62f3a-a780b6b1e19mr722451266b.18.1720795914060; 
 Fri, 12 Jul 2024 07:51:54 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a797f300b05sm234971066b.134.2024.07.12.07.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 07:51:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8287E5F713;
 Fri, 12 Jul 2024 15:51:52 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Eduardo Habkost
 <eduardo@habkost.net>,  Yanan Wang <wangyanan55@huawei.com>,  Xingtao Yao
 <yaoxt.fnst@fujitsu.com>
Subject: Re: [PATCH v6 7/7] tests/tcg/x86_64: add test for plugin memory access
In-Reply-To: <764d6e43-c18f-4683-ac03-eea8a9b2690b@linaro.org> (Pierrick
 Bouvier's message of "Thu, 11 Jul 2024 17:48:42 -0700")
References: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
 <20240706191335.878142-8-pierrick.bouvier@linaro.org>
 <87zfqrsnjr.fsf@draig.linaro.org>
 <764d6e43-c18f-4683-ac03-eea8a9b2690b@linaro.org>
Date: Fri, 12 Jul 2024 15:51:52 +0100
Message-ID: <87ttgupss7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

> On 7/8/24 12:15, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>=20
>>> Add an explicit test to check expected memory values are read/written.
>>> For sizes 8, 16, 32, 64 and 128, we generate a load/store operation.
>>> For size 8 -> 64, we generate an atomic __sync_val_compare_and_swap too.
>>> For 128bits memory access, we rely on SSE2 instructions.
>>>
>>> By default, atomic accesses are non atomic if a single cpu is running,
>>> so we force creation of a second one by creating a new thread first.
>>>
>>> load/store helpers code path can't be triggered easily in user mode (no
>>> softmmu), so we can't test it here.
>>>
>>> Can be run with:
>>> make -C build/tests/tcg/x86_64-linux-user run-plugin-test-plugin-mem-ac=
cess-with-libmem.so
>>>
>>> Tested-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>   tests/tcg/x86_64/test-plugin-mem-access.c   | 89 +++++++++++++++++++++
>>>   tests/tcg/x86_64/Makefile.target            |  7 ++
>>>   tests/tcg/x86_64/check-plugin-mem-access.sh | 48 +++++++++++
>>>   3 files changed, 144 insertions(+)
>>>   create mode 100644 tests/tcg/x86_64/test-plugin-mem-access.c
>>>   create mode 100755 tests/tcg/x86_64/check-plugin-mem-access.sh
>>>
>>> diff --git a/tests/tcg/x86_64/test-plugin-mem-access.c b/tests/tcg/x86_=
64/test-plugin-mem-access.c
>>> new file mode 100644
>>> index 00000000000..7fdd6a55829
>>> --- /dev/null
>>> +++ b/tests/tcg/x86_64/test-plugin-mem-access.c
>>> @@ -0,0 +1,89 @@
>>> +#include <emmintrin.h>
>>> +#include <pthread.h>
>>> +#include <stdint.h>
>>> +#include <stdlib.h>
>>> +
>>> +static void *data;
>>> +
>>> +#define DEFINE_STORE(name, type, value) \
>>> +static void store_##name(void)          \
>>> +{                                       \
>>> +    *((type *)data) =3D value;            \
>>> +}
>>> +
>>> +#define DEFINE_ATOMIC_OP(name, type, value)                 \
>>> +static void atomic_op_##name(void)                          \
>>> +{                                                           \
>>> +    *((type *)data) =3D 0x42;                                 \
>>> +    __sync_val_compare_and_swap((type *)data, 0x42, value); \
>> Should we exercise the other compare and swap ops? Do they all come
>> through the same rwm path?
>>=20
>
> There are definitely several paths depending on the generated atomic op.
> However, the code is pretty straightforward (and implemented in a
> single function), so my thought was that one way to trigger this was
> enough.

If they all come through the same path I guess that's OK.

>>> +}
>>> +
>>> +#define DEFINE_LOAD(name, type)                         \
>>> +static void load_##name(void)                           \
>>> +{                                                       \
>>> +    register type var asm("eax") =3D *((type *) data);    \
>>> +    (void)var;                                          \
>> This is a bit weird. It's the only inline asm needed that makes this
>> a
>> non-multiarch test. Why?
>>=20
>
> I'll answer here about why this test is arch specific, and not a multi ar=
ch.
>
> The problem I met is that all target architecture do not have native
> 64/128 bits types, and depending how code is compiled with gcc, you
> may or not generated expected vector instructions for 128bits
> operation. Same for atomic operations.

So we do handle this with the sha512 test, building variants of it with
various compiler flags to trigger the use of vectors. So the code is
multiarch but we have arch specific variants as dictated by the
Makefiles, i.e.:

  sha512-sve: CFLAGS=3D-O3 -march=3Darmv8.1-a+sve
  sha512-sve: sha512.c
          $(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)

  TESTS +=3D sha512-sve


> Thus, I chose to specialize this test for x86_64, and use sse2
> directly for 128 bits integers.
>
> You might say "How about adding ifdef for this". Yes sure, but the
> check script would become complicated too, and I just wanted to keep
> it simple.

We can keep the check-script per arch if we have to.

> Our interest here is not to check that memory accesses are
> correctly implemented in QEMU, but to check that a specific behavior
> on one arch is the one expected.

So the problem with not being multiarch is we don't build all targets in
all combinations. To limit CI time we often build a subset and now this
particular subset won't test the plugin paths.

>
> Does it make more sense for you?
>
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

