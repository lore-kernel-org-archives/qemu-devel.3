Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07840CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 17:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut835-0006ng-3V; Mon, 01 Sep 2025 13:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut82f-000691-4h
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 13:10:09 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut82Y-0007ua-Uh
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 13:10:04 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e931cad1fd8so3642617276.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 10:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756746598; x=1757351398; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mWm75LlarvNPNkG/j1YdIDdAaspy5HO2BeQIm0j5o6s=;
 b=dOjtOV51wilE0mMhI7NU9a2fx06noC/7PFixlFhgavWfpcM5K7F5AitEexcFeexlNH
 mpJBjP2Utx0G2bYTvGmuWR9BGExgQdymutc7mYTKyLi55Z59bOuKrWgnmQR4tEr0CuId
 B7b9ZpUiMMgvH9PkrBWZ0OYx8oWfrF/7mIoNQW5k1gIEEQvUKvmAcNvyoDXa4vEM+aRq
 ypdrDtu3xJUEMEN7vs+Bn0LuOx0MRHSTeMwNtQ294jfp0rDZh2/5QKZJ99GRIMs7k3fG
 JElberhyRUrj1OZPssGaPK25UaEJ9NT5rnuJRv5geaThBoBh7acvMWFixeBNkGPIkj1V
 gLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756746598; x=1757351398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mWm75LlarvNPNkG/j1YdIDdAaspy5HO2BeQIm0j5o6s=;
 b=tzVyZ7uePbZprODD0Y11ZM3FZSsACr/814se3R0ZCaMRZrTqhTzpXOo+i02B8guyY/
 cEFkjhFClxQBzReNttOnGIOp1SGmh3Lz/f8EssYAbeE2QwkJsCNvP7/4fsHuLl+V9ndc
 3F05JgQPdOBjEg1sJEHPoLMhiPUGsTgYMpAuR0wwKlZRhD+dPB+6MTVypceG7U71M1XO
 u/nRC9vfflExa4LPTjWjz9wqnb6kR8BXbU+g7jBOjFGqTEzW/bzjGsesDll8gCL2AYAV
 VcGF/PXSSptoPT4vlKg0vO2HYML6KOrZkNji+C0c0sZLDL3jEzNclyRIAC2ZvDbXzcM8
 F/cQ==
X-Gm-Message-State: AOJu0YyA7pZN3iIy+iVM2mRopmUHb4pjlF69CEMnMv3sBpo1B/+sJw2c
 Vfr/cycqah1t0V5JAWMZ7bXUGJORn8Q++jJrrtXOUqXnAI63t2kmgYEqprKgwCu/pYna0Ec6SGV
 b+TM1e88tB92ieIUYIS8o8QQhGeXcDhJMhYxzdatNng==
X-Gm-Gg: ASbGnctyx9N56vIQf54F9F1dj9E9YbnpqrpLOHFvAnbFQAXn5LDBPUE/75q731sFFDU
 +D+i5wHAZ7F1PC5xCbVo7SLc/lKkRHLGltwwk9Sz44gDi0C37zI6kM0EXcwrEW5wF3+Bw2Q4EPC
 4YYz7yNq6CM6LdHenvCl2uRqjCxmD5Ad6aVVFQXu63Wxq1JbRxKPrE7BeMLVcshdbJ+wx9Gf/9U
 QNOKAWT
X-Google-Smtp-Source: AGHT+IERTXHqlXXU39mvv5axTI9DNn+sVagnssYa+KVH5QXxHSA0PR8s+lbWdjQfl/g6dqIX3J7EdL/C2hw6Y+v7CeA=
X-Received: by 2002:a05:690c:61ca:b0:723:89bb:7c63 with SMTP id
 00721157ae682-72389bb8b40mr41845077b3.14.1756746597452; Mon, 01 Sep 2025
 10:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250822092410.25833-1-cjchen@igel.co.jp>
 <20250822092410.25833-2-cjchen@igel.co.jp>
In-Reply-To: <20250822092410.25833-2-cjchen@igel.co.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Sep 2025 18:09:45 +0100
X-Gm-Features: Ac12FXyp5aoGFJCJISjg0rWTbnKib39-xtFSHoOxLlgVVJx173cxOAbUvbrHHzc
Message-ID: <CAFEAcA8M6EAeEqSkJG-D+t=+3D4T99UoVNe94nfhRGxc80=PAw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/9] doc/devel/memory.rst: additional explanation
 for unaligned access
To: CJ Chen <cjchen@igel.co.jp>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org, 
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Tomoyuki Hirose <hrstmyk811m@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 22 Aug 2025 at 10:25, CJ Chen <cjchen@igel.co.jp> wrote:
>
> Add documentation to clarify that if `.valid.unaligned =3D true` but
> `.impl.unaligned =3D false`, QEMU=E2=80=99s memory core will automaticall=
y split
> unaligned guest accesses into multiple aligned accesses. This helps
> devices avoid implementing their own unaligned logic, but can be
> problematic for devices with side-effect-heavy registers. Also note
> that setting `.valid.unaligned =3D false` together with
> `.impl.unaligned =3D true` is invalid, as it contradicts itself and
> will trigger an assertion.
>
> Signed-off-by: CJ Chen <cjchen@igel.co.jp>
> Acked-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/devel/memory.rst | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
> index 57fb2aec76..71d7de7ae5 100644
> --- a/docs/devel/memory.rst
> +++ b/docs/devel/memory.rst
> @@ -365,6 +365,24 @@ callbacks are called:
>  - .impl.unaligned specifies that the *implementation* supports unaligned
>    accesses; if false, unaligned accesses will be emulated by two aligned
>    accesses.
> +- Additionally, if .valid.unaligned =3D true but .impl.unaligned =3D fal=
se, the
> +  memory core will emulate each unaligned guest access by splitting it i=
nto
> +  multiple aligned sub-accesses.

Can we say in more specific detail what the core handling is, please?
I should be able to read this documentation and know exactly what
extra accesses I will get to my device. (Then I can make the decision
about whether I will be OK with those or if I will need to do the
unaligned handling myself.)

Documenting the behaviour we intend to provide will also make it
easier to review the implementation and the tests in the later patches.

> This ensures that devices which only handle
> +  aligned requests do not need to implement unaligned logic themselves. =
For
> +  example, see xhci_cap_ops in hw/usb/hcd-xhci.c: it sets  .valid.unalig=
ned
> +  =3D true so guests can do unaligned reads on the xHCI Capability Regis=
ters,
> +  while keeping .impl.unaligned =3D false to rely on the core splitting =
logic.
> +  However, if a device=E2=80=99s registers have side effects on read or =
write, this
> +  extra splitting can introduce undesired behavior. Specifically, for de=
vices
> +  whose registers trigger state changes on each read/write, splitting an=
 access
> +  can lead to reading or writing bytes beyond the originally requested s=
ubrange
> +  thereby triggering repeated or otherwise unintended register side effe=
cts.
> +  In such cases, one should set .valid.unaligned =3D false to reject una=
ligned
> +  accesses entirely.

.valid.unaligned has to match what the real hardware requires.
So we should instead say something like:

 If your device must support unaligned accesses and these extra
 accesses would cause unintended side-effects, then you must set
 .impl.unaligned and handle the unaligned access cases yourself.

> +- Conversely, if .valid.unaligned =3D false but .impl.unaligned =3D true=
,
> +  that setting is considered invalid; it claims unaligned access is allo=
wed
> +  by the implementation yet disallowed for the device. QEMU enforces thi=
s with
> +  an assertion to prevent contradictory usage.
>
>  API Reference
>  -------------
> --
> 2.25.1
>

thanks
-- PMM

