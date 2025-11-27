Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24F9D111A8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 17:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOfwk-0008IS-5j; Thu, 27 Nov 2025 12:38:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vOfwb-0008HR-W2
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 12:38:14 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vOfwa-0001tf-1M
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 12:38:13 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-78aa642f306so10163427b3.2
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 09:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764265091; x=1764869891; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FCMliznciGCE9CNF+xovrZQe4YDVsgTI1SwJU1aKuI0=;
 b=ylq3KV9FUgm+RMrSvLMRPs2Lh384O3AqqGDIYAUvHtzNRelXzEjAUqKxNqYJy4k22K
 dS1cEGYLCxdrwxWglUk0VtVLfDRYo8dfNaSsSCMWD5wZdsCMPOxvZpF5AZCdHPfecyRo
 mXHB1U+MheJE95C1O9R++qkz2F6rRnHF5BZjKSYZXOvhm69KBwncXFZa6kZpoh6tsKyx
 V24z92pEp3jepdZRikEKT1xwMSn0BrniJs6kEXIbKWWno1qhbV1hijY4HwekdGCakvm2
 GtKDsdqhILVM7dwOiUfzwXZncCjR768IPsr7/HT2fyKAUgSFNL/eSLkttdc3R4kvjoyM
 uczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764265091; x=1764869891;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FCMliznciGCE9CNF+xovrZQe4YDVsgTI1SwJU1aKuI0=;
 b=eiFZbWrMFXkq+DDLZDXrnMfrxe1DEJZbZOgIbcr5zCd0gURP0YQHv3ir1Ih4mEN8Cn
 vE2S3+3NX0Cm9yjvUaEjS6ZTToIk+dfoFzEEW+ptrz3i1fI57YXylf+N13TkbjBgQ9e1
 bWusAEN7pBUZzj1IbHgf2nX0wQlQ7c8Dx1PInsfEfD7wt/9aNfJv8ATxkqkpIgLjt7jY
 UE+12WjYj6GYLO6bbkzgYDg838oSFtmkPx1yyhU8MFFJvZm6U9uI2RAZA41kYmsjb3xf
 Mt8KhGv+3fb6qGDxmnuLWqg1V3Moev+3/DBKbSlEU0PM61upEY7N8pHJA5Y3eQnpP6T4
 pa9A==
X-Gm-Message-State: AOJu0Yxs3T26n3mUC2g3aH8zikCqus49yzwxwYfDi89to0E4gNDBoQ/s
 NsuWAEZcDlpHvW7NewA/D76cXr41+QlHdDYT08ExX2DYywXENXhCMdNPMjIuvcvkOubIlJSnI9v
 8qO60i9g0tvVjWZBYcfSh/GlPDYwwDEuYlqS4SphZ7A==
X-Gm-Gg: ASbGncu1mdlYrnglmceMOieoWM1Zrp0nSgqhEH2GAvafqaJue+0Hlax/XSmp0fD8guP
 X7n3rpjQKW7ziJLX3YVicLzDKG0kEXjZj4D1ApBoRCzOVNIWDoBLgIYj9rQOdHt//rhgzWynMSn
 JztkC7yipzZefYDT36JNWRo0URKyv8k48hXboxtx/tSUkwXwV652Dr8OlWh8wuXSMRzLeTcNd5D
 B/plRHs22tJB28tOaHYgHz4so3AZFUCypy9rEZbVgk9BXrgNrqBC4TuLsiatQWp4p7WjXLP
X-Google-Smtp-Source: AGHT+IEeI2T7cx8vYT579ac7MsNcBP9s4yYEHqBsqg6LoCbD9MBkbCEma2f+6Pcv9NxRn1Rz4MXPYkyQs5kY7OiDiag=
X-Received: by 2002:a05:690c:3348:b0:786:7db7:bb9d with SMTP id
 00721157ae682-78ab6dd9e5bmr101182317b3.17.1764265090754; Thu, 27 Nov 2025
 09:38:10 -0800 (PST)
MIME-Version: 1.0
References: <20251127171943.3241635-1-alex.bennee@linaro.org>
In-Reply-To: <20251127171943.3241635-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Nov 2025 17:37:58 +0000
X-Gm-Features: AWmQ_bkT6PgCnVXg3XkaW6b0QtB6RxHuyJu-2_oys0lC5L1hlv4hKSPBc3eS7FU
Message-ID: <CAFEAcA_vW=ic+YKVk78jSg67Cu86GgHe87NH8_3jgHDS_4si1A@mail.gmail.com>
Subject: Re: [RFC PATCH] target/ppc: don't overflow SR lookup with 64 bit vaddr
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Chinmay Rath <rathc@linux.ibm.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Thu, 27 Nov 2025 at 17:20, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> One of the side effects of making vaddr always 64 bits

vaddr has traditionally always been 64 bits, though.
(introduced in 2013 commit 577f42c0e11a5 as 'uint64_t').
Commit a70af12ad in February changed it the other way,
so that it is now uintptr_t instead of uint64_t, and might
be 32 bits on some hosts.

>  is there are
> places where we assume it is sized to the guest. As a result a simple
> shift might bring in extra bits.
>
> Using extract32 stops the crash in:
>
>   ./pyvenv/bin/meson test qtest-ppc/prom-env-test
>
> with TCI enabled but the test still hangs.
>
> Over to you PPC maintainers ;-)

But vaddr is an unsigned type -- why has something
sign-extended a 32-bit guest register value into it?

I think your problem is somewhere down in the callstack
where we are likely inadvertently sign-extending.

> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  target/ppc/mmu-hash32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> index 8b980a5aa90..ce9c86ceacd 100644
> --- a/target/ppc/mmu-hash32.c
> +++ b/target/ppc/mmu-hash32.c
> @@ -342,7 +342,7 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, M=
MUAccessType access_type,
>      }
>
>      /* 3. Look up the Segment Register */
> -    sr =3D env->sr[eaddr >> 28];
> +    sr =3D env->sr[extract32(eaddr, 28, 4)];
>
>      /* 4. Handle direct store segments */
>      if (sr & SR32_T) {
> --

thanks
-- PMM

