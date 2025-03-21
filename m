Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BB0C36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 11:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvai2-0004mc-JX; Fri, 21 Mar 2025 07:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tvahu-0004jP-Ex
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 07:38:37 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tvahs-0001Bz-Mg
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 07:38:34 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3912c09be7dso1182300f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 04:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742557110; x=1743161910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3tw57Clz7HbaK4s7dPdpLPcWgBWFJpLDZ1uhZQXrSyo=;
 b=zl60BLg+gv8Y8+rNmORg52VMxG8MkTK+FQjs5qSOM6IImzsekPMcYECljX85E3ZOl4
 OpQvMxmqKfLIX17yPKety+cN8cAU1IK9YegxElJqOk3lch+X2Fs+R6MuNV2PEBtGs1Ex
 JdiQUthT1PpGXqd6gy5Aro/2A4hLpoR8LyrejGw9CoZePCPRmU4dI5KB9m2TbEOi1bu8
 /pk80MnojLJidZk/GlM3926AQu5oatUw7pAAnjkeQlkxLs73K24rzhDh8vsnBvscdyJ9
 gq1P+Wn/Yx0+NQQKQ/2/DCFqUt3u1/PUUznF/zUmx3WsUbiN5N9uaNrwIdjrzipaZ2Dp
 OHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742557110; x=1743161910;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3tw57Clz7HbaK4s7dPdpLPcWgBWFJpLDZ1uhZQXrSyo=;
 b=xPodgzlkCl3mpg08TdKa9MnTokgqjrSKL3T5o5Y9UuRcC2UaaRwrYIPz7jdw7sTXLN
 W7wusF/qZ5NYKqznqecN7Ku0o3d40FFrkcyPHI7B0Qzy0JfEncpdlYORRRoYnfQBxqRV
 tpZLlY9ByDM6UMca1lCORPNpWPYyv+Db13CLJhqpHMP4PpL/zt0RG8ORnqQG2wocJ58+
 /By6i6C5I9jcv+mTpvSPbCYdPX/rRNvAuDaqXfHNqu5rC55eisH89a9ZuCj3Zwq+ho/q
 mZQh2z61/ghvrSgNaRjKhXij18BzCMyGU/7VX9kZy8yvPCVGMIpf2C6INnbybwdPXhBs
 FKFg==
X-Gm-Message-State: AOJu0YxRNTOoG7SIuYJgLjY63903KSK5720r+xN2Ugawkb5mVRVUDck0
 oEN3jYCqUOFphita2VUn4aW1p6GYelYcfysNGN4WCpPFCGEEqKY4kKeppSFalD4=
X-Gm-Gg: ASbGncsBAz0n2AQdQcirwtfadflbWEtWaeRE+D7rEzY7l/UMhIj8yjjm2+QzVKqwIcZ
 q9HGuiL0bsL934kkODxw/iMJiRThYXm8eAhfCKvqywEpPv9Lbj+KJGKXUpZfCWKZOwBLpF628mp
 tNgXUfCK49wPkDXGXulyd/t6u2/sTiBkldziO5q0yJ3YrpqpqPbMQRM9WtOZucjQ9KJXT2jenSo
 yo3CBOUorRNLkG40w5P5qOfdGKMJxi1hKF9oaZpxEJfWmGpyaoNmbbJvCYbv8+p6WA3Mtpb1Byt
 2/AH10YViExp6jV3eQYmBJQprX6WjTvN+J7Xnw8jvF3UYy4=
X-Google-Smtp-Source: AGHT+IFKD+l0fijs95nzWjyFE/rc2wV13+lM9HcG3vinnisyty7adsK4HMYTKDMDc7gB1eYyQ5w6Nw==
X-Received: by 2002:a05:6000:188f:b0:391:304f:34e7 with SMTP id
 ffacd0b85a97d-3997f932ea8mr3252110f8f.44.1742557109787; 
 Fri, 21 Mar 2025 04:38:29 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fdbcfaasm24067905e9.35.2025.03.21.04.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 04:38:29 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 83EFD5F7A5;
 Fri, 21 Mar 2025 11:38:28 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,  Juan
 Quintela <quintela@redhat.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,  Akihiko Odaki
 <akihiko.odaki@daynix.com>,  qemu-ppc@nongnu.org,  David Gibson
 <david@gibson.dropbear.id.au>,  qemu-s390x@nongnu.org,  Wainer dos Santos
 Moschetta <wainersm@redhat.com>,  Peter Xu <peterx@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,  Daniel Henrique Barboza
 <danielhb413@gmail.com>,  David Hildenbrand <david@redhat.com>,  Yonggang
 Luo <luoyonggang@gmail.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Beraldo Leal <bleal@redhat.com>,
 qemu-arm@nongnu.org,  Greg Kurz <groug@kaod.org>,  Philippe =?utf-8?Q?Ma?=
 =?utf-8?Q?thieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Nicholas Piggin <npiggin@gmail.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 04/10] target/arm: convert 64 bit gdbstub to new helper
In-Reply-To: <e03abbd9-cb20-4a98-a112-66d13a76d244@linaro.org> (Pierrick
 Bouvier's message of "Thu, 20 Mar 2025 12:42:15 -0700")
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
 <20250319182255.3096731-5-alex.bennee@linaro.org>
 <e03abbd9-cb20-4a98-a112-66d13a76d244@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Fri, 21 Mar 2025 11:38:28 +0000
Message-ID: <87frj6likr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

> On 3/19/25 11:22, Alex Benn=C3=A9e wrote:
>> For some of the helpers we need a temporary variable to copy from
>> although we could add some helpers to return pointers into env in
>> those cases if we wanted to.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   target/arm/gdbstub64.c | 53 ++++++++++++++++++++++++++----------------
>>   1 file changed, 33 insertions(+), 20 deletions(-)
>> diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
>> index 1a4dbec567..793332af31 100644
>> --- a/target/arm/gdbstub64.c
>> +++ b/target/arm/gdbstub64.c
>> @@ -20,7 +20,7 @@
>>   #include "qemu/log.h"
>>   #include "cpu.h"
>>   #include "internals.h"
>> -#include "gdbstub/helpers.h"
>> +#include "gdbstub/registers.h"
>>   #include "gdbstub/commands.h"
>>   #include "tcg/mte_helper.h"
>>   #if defined(CONFIG_USER_ONLY) && defined(CONFIG_LINUX)
>> @@ -35,15 +35,16 @@ int aarch64_cpu_gdb_read_register(CPUState *cs, GByt=
eArray *mem_buf, int n)
>>         if (n < 31) {
>>           /* Core integer register.  */
>> -        return gdb_get_reg64(mem_buf, env->xregs[n]);
>> +        return gdb_get_register_value(MO_TEUO, mem_buf, (uint8_t *) &en=
v->xregs[n]);
>>       }
>>       switch (n) {
>>       case 31:
>> -        return gdb_get_reg64(mem_buf, env->xregs[31]);
>> +        return gdb_get_register_value(MO_TEUO, mem_buf, (uint8_t *) &en=
v->xregs[31]);
>>       case 32:
>> -        return gdb_get_reg64(mem_buf, env->pc);
>> +        return gdb_get_register_value(MO_TEUO, mem_buf, (uint8_t *) &en=
v->pc);
>
> For the 3 occurrences, should it be MO_TEUQ instead?

>> -        int vq =3D sve_vqm1_for_el(env, arm_current_el(env)) + 1;
>> -        return gdb_get_reg64(buf, vq * 2);
>> +        uint64_t vq =3D (sve_vqm1_for_el(env, arm_current_el(env)) + 1)=
 * 2;
>> +        return gdb_get_register_value(MO_TEUL, buf, (uint8_t *) &vq);
>>       }
>
> Should it be MO_TEUQ instead?

I've taken Philippe's suggestion and used explicit MO_32/64 which is
easier to follow.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

