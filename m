Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8466C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 14:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZ2V-0001G1-6W; Fri, 07 Mar 2025 09:51:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tqZ2S-0001Fi-5A
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 09:51:00 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tqZ2Q-0005v6-4c
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 09:50:59 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e033c2f106so1921781a12.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 06:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741359056; x=1741963856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dNZtIZJytF/Zt61U4OrGGE9iALPc/9QtNmwJUb2ZA74=;
 b=IX8E2e64P/VQwE4sM3O6nG555AkZ+qAdJEYuYyWDHf8GfI91z+axJ2CEIOS9zTmS7O
 yVxqpg1vjd8CgIE7Tj7I+7zJetoHezXsypy2QUtel+7Ry31Q+P2XiO+9KZYulYXsSOrI
 VpISACTtEapc6xFeq6L78oA+4Yke9vDoxwxck4krkdaHQpxIvSVdYfdaY8zLVkZq2MpP
 koObz8HWPVPod/CwS1iPs7v20uC2AP+ZmpPp2yUbyEzQKiC5KTivan806VEQiUGNrPTo
 ucibw3RHnXl/8wQ9OKfuXLTOLs2jot4BRpQG8p3OvR1lU8P9eVa6awFiUp/f9JZCH1Ji
 vqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741359056; x=1741963856;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dNZtIZJytF/Zt61U4OrGGE9iALPc/9QtNmwJUb2ZA74=;
 b=luaFPoxvvSWQRlihCujJ59GoleLmQszhWJ8RPjUHOUVgYrUWARi8PBcUJmy4TTpFzB
 qBcZP5GJzlL/XTnsBKQYagOD95rDZC2nrqdEfIiim5av/DjpuxZ6ppfxSuqb3cCKkE1j
 8/PwJ2Kk3VWrDwpOJq0W4Ti6GO9XbUYVPC/fGfYjiJcWW+PuUfloXfOeRP74qK0VDUUB
 7R0khrGITRGnwq9/XVCqV1BeXPSju1CnGZtNqaN7Rx1xr9haRdHopUHzk9fznltXwldC
 q2x+klpshKjvOUhr8iwDaSKmaHQOm8/TFtQ5d8S3kVkwNTYb+qVSoCAhfaYjODvxrQ5A
 HgTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc6m0dVFJ2DYZAk0Qgoy3uzdzC90dIPHIRBdJ10B1KoyNumkS4jFVTkYzUNF1asDaBNr5FRQt0RpaS@nongnu.org
X-Gm-Message-State: AOJu0YwMvR380NbvXfaBTI5Xh4J0Z/1ZvAASDEpzzWFc8M7mTfdeWFoa
 HMaTm9VVaEQAbSQCljjeTQCOyrQTYScNRFnfPUx+/DsRXaMtCKFHFDFSQ3745/g=
X-Gm-Gg: ASbGncshX+eVCYq1KMug3FyfguU4EjluzUpuTllkUVxcIMWvU22g0Qd69aGMxexGx4A
 vrp+uXl4oFMzn9X40R98LHeaCKxUvSQu19X1ubJxKSq4ay01ZnlcHlwc6LAjDQOA+HcgP/8IY+B
 RmChxTh+GWqnYb6Ajq4mWYRl6z6qQg2sq/Ou+DGHMXbKwprSHXy51UB+nzTfmu8HFNeeUEbweAJ
 kk3YpQr1YrP4tHqVwdrD9Tk26ZyA0P7RYQwdiz7mXezi68nhKODODJHnheDhiT32GLQfypm+X6U
 CeAcgarKkjQUnCnNLwBbhAVFDOtw/m12eRaaq6XQuzDw2Ks=
X-Google-Smtp-Source: AGHT+IGlT1ukA1jbMwwSvTcNJeSfQ9ZpWZAeZEzYscuw2hkZ6zyCLpFa1cLRIlIwBB9gpCeXrZuDzg==
X-Received: by 2002:a05:6402:34c7:b0:5e5:ba77:6f24 with SMTP id
 4fb4d7f45d1cf-5e5e22d4c66mr8934967a12.16.1741359054974; 
 Fri, 07 Mar 2025 06:50:54 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c745c552sm2726825a12.17.2025.03.07.06.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 06:50:54 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 27D825F90C;
 Fri,  7 Mar 2025 14:50:53 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org,  manos.pitsidianakis@linaro.org,  Marcelo Tosatti
 <mtosatti@redhat.com>
Subject: Re: [PATCH 5/7] hw/hyperv/syndbg: common compilation unit
In-Reply-To: <95a6f718-8fab-434c-9b02-6812f7afbcc3@maciej.szmigiero.name>
 (Maciej S. Szmigiero's message of "Fri, 7 Mar 2025 12:07:25 +0100")
References: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
 <20250306064118.3879213-6-pierrick.bouvier@linaro.org>
 <353b36fd-2265-43c3-8072-3055e5bd7057@linaro.org>
 <35c2c7a5-5b12-4c21-a40a-375caae60d0c@linaro.org>
 <d62743f5-ca79-47c0-a72b-c36308574bdd@linaro.org>
 <6556fdd8-83ea-4cc6-9a3b-3822fdc8cb5d@linaro.org>
 <95a6f718-8fab-434c-9b02-6812f7afbcc3@maciej.szmigiero.name>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Fri, 07 Mar 2025 14:50:53 +0000
Message-ID: <87o6yc3nea.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> On 6.03.2025 23:56, Pierrick Bouvier wrote:
>> On 3/6/25 09:58, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 6/3/25 17:23, Pierrick Bouvier wrote:
>>>> On 3/6/25 08:19, Richard Henderson wrote:
>>>>> On 3/5/25 22:41, Pierrick Bouvier wrote:
>>>>>> Replace TARGET_PAGE.* by runtime calls
>>>>>>
>>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>>> ---
>>>>>> =C2=A0=C2=A0=C2=A0 hw/hyperv/syndbg.c=C2=A0=C2=A0=C2=A0 | 7 ++++---
>>>>>> =C2=A0=C2=A0=C2=A0 hw/hyperv/meson.build | 2 +-
>>>>>> =C2=A0=C2=A0=C2=A0 2 files changed, 5 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
>>>>>> index d3e39170772..f9382202ed3 100644
>>>>>> --- a/hw/hyperv/syndbg.c
>>>>>> +++ b/hw/hyperv/syndbg.c
>>>>>> @@ -14,7 +14,7 @@
>>>>>> =C2=A0=C2=A0=C2=A0 #include "migration/vmstate.h"
>>>>>> =C2=A0=C2=A0=C2=A0 #include "hw/qdev-properties.h"
>>>>>> =C2=A0=C2=A0=C2=A0 #include "hw/loader.h"
>>>>>> -#include "cpu.h"
>>>>>> +#include "exec/target_page.h"
>>>>>> =C2=A0=C2=A0=C2=A0 #include "hw/hyperv/hyperv.h"
>>>>>> =C2=A0=C2=A0=C2=A0 #include "hw/hyperv/vmbus-bridge.h"
>>>>>> =C2=A0=C2=A0=C2=A0 #include "hw/hyperv/hyperv-proto.h"
>>>>>> @@ -188,7 +188,8 @@ static uint16_t handle_recv_msg(HvSynDbg *syndbg,
>>>>>> uint64_t outgpa,
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint6=
4_t timeout, uint32_t
>>>>>> *retrieved_count)
>>>>>> =C2=A0=C2=A0=C2=A0 {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t ret;
>>>>>> -=C2=A0=C2=A0=C2=A0 uint8_t data_buf[TARGET_PAGE_SIZE - UDP_PKT_HEAD=
ER_SIZE];
>>>>>> +=C2=A0=C2=A0=C2=A0 const size_t buf_size =3D qemu_target_page_size(=
) -
>>>>>> UDP_PKT_HEADER_SIZE;
>>>>>> +=C2=A0=C2=A0=C2=A0 uint8_t *data_buf =3D g_alloca(buf_size);
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwaddr out_len;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *out_data;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ssize_t recv_byte_count;
>>>>>
>>>>> We've purged the code base of VLAs, and those are preferable to alloc=
a.
>>>>> Just use g_malloc and g_autofree.
>>>>>
>>>>
>>>> I hesitated, due to potential performance considerations for people
>>>> reviewing the patch. I'll switch to heap based storage.
>>>
>>> OTOH hyperv is x86-only, so we could do:
>>>
>>> #define BUFSZ (4 * KiB)
>>>
>>> handle_recv_msg()
>>> {
>>> =C2=A0=C2=A0=C2=A0 uint8_t data_buf[BUFSZ - UDP_PKT_HEADER_SIZE];
>>> =C2=A0=C2=A0=C2=A0 ...
>>>
>>> hv_syndbg_class_init()
>>> {
>>> =C2=A0=C2=A0=C2=A0 assert(BUFSZ > qemu_target_page_size());
>>> =C2=A0=C2=A0=C2=A0 ...
>>>
>>> and call it a day.
>> Could be possible for now yes.
>> Any opinion from concerned maintainers?
>
> I think essentially hardcoding 4k pages in hyperv is okay
> (with an appropriate checking/enforcement asserts() of course),
> since even if this gets ported to ARM64 at some point
> it is going to need *a lot* of changes anyway.

There was a talk at last years KVM Forum about porting WHPX for Windows
on Arm:

  https://kvm-forum.qemu.org/2024/Qemu_support_for_Windows_on_Arm_GgKlLjf.p=
df

but am I right in thinking all the hyperv code in QEMU is about
providing guest facing enlightenments for Windows guests under KVM? I
guess no one is working on that at the moment.


>
> Thanks,
> Maciej

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

