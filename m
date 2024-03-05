Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A440AC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 17:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhYbF-00086R-4v; Tue, 05 Mar 2024 12:29:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhYbC-00085o-Sm
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 12:29:06 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhYbB-0001TV-6w
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 12:29:06 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-565ef8af2f5so7451407a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 09:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709659743; x=1710264543; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q59/oPCWELUo9Z8GZCwWJ9DbjcYAWGtyL/5c+5zpGtg=;
 b=ouyzcRZvCJZNCbaR4W1dFJp2zVCOkBmGqy9TTPleD5ggw8ArWbAlyBNMLsupM2Cw+2
 0SsC82rbViu5EBy6oPmwCLmBRNU0THLZBGyve5QZWxq+k4EuyLBOShPlJpGZkBVe7SRy
 n9pJTtQyDluIPA6WGpiUccXfq6a6Cv1g87BNGPgbZyXHfyr+a6QfyrJOgHkK/qwtb+P/
 4/VVBqHZV237R2pPFjPy3sI1ZOBhjs8jiR1fA1G00vSckV8Vaw2g9vxIdbfhktykVRXL
 bNX9ennJSnlgiLCHrmteSDvzM0EAJdg6SfRX7/wWf5uVgyEoQlzLMhYuLiApkWqns/CK
 c4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709659743; x=1710264543;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q59/oPCWELUo9Z8GZCwWJ9DbjcYAWGtyL/5c+5zpGtg=;
 b=Va5+7kvhG2T/EVY1uMGihweVTpSZ4CQYX21FrjAlQB6W0vxknuRa0VrgoB9QHuzNp5
 4bsH6kEV0WNOr/OnDFqXcgku8lft9D5eW2AkooqSbbq+kvipo1BUPsjk3+eLZawJypeE
 0DyjERgVfxGKlMfuobpQFP19BWwhE2C8CJSZ6CF/kbIuOJIErJZHd8bWikmSNeZgNXkL
 udNAUdN4Q45ITde/kGVmoeofCE1LZ1JLUVucXh1CJdoNxlXJm1rDW+PVdBBg1Fbnozcf
 xKTaBc8fjpfXmMV9owIXUL2KVKrv3nb8F1UeI1M+R7EdZObyVkwVAgwtcTfCTurrregF
 E/Lg==
X-Gm-Message-State: AOJu0YzAiNDh6gTWEox7xFrNhuA3rizGEnxlvX1oKZMGDX9XlXWeQs47
 Sf7b5MPiJasRxOMYXLrcy6hGdToNN1j9hSR7/pw9ku/hCXkz6dNVSaEXsEjIGvKcAKzdBjoDqY7
 i6iwI6gh5sudk8XFzxUPcl2mAxskBmFDX8W6DjA==
X-Google-Smtp-Source: AGHT+IGZaLxpxaNNhAkc5X+AchnZMCB3Z8hUgA3gN+vk/wbE547kCrDp8WuinlNvvoNmhSq6H9nPzG9z7j3PKR7ieH8=
X-Received: by 2002:a05:6402:22c2:b0:565:edd9:1acb with SMTP id
 dm2-20020a05640222c200b00565edd91acbmr9296637edb.23.1709659743399; Tue, 05
 Mar 2024 09:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20240305171218.3621274-1-alex.bennee@linaro.org>
In-Reply-To: <20240305171218.3621274-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 17:28:52 +0000
Message-ID: <CAFEAcA8O4Gu=nmpndLqxSz5grwy6=HuhbkQFQUBvyfMQnfq=OA@mail.gmail.com>
Subject: Re: [RFC PATCH] plugins: filter out the PC from the register list
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 5 Mar 2024 at 17:13, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> QEMU's handling of the program counter is special in so far as the
> translator avoids setting it whenever possible. As the PC is available
> at translation time lets avoid confusion by just filtering the program
> counter from the list of available registers.
>
> Update the documentation with some notes about the register access and
> calling out the behaviour of the PC.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2208
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/devel/tcg-plugins.rst | 15 +++++++++++++++
>  plugins/api.c              |  5 +++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
> index 9cc09d8c3da..656df012e77 100644
> --- a/docs/devel/tcg-plugins.rst
> +++ b/docs/devel/tcg-plugins.rst
> @@ -151,6 +151,21 @@ Unsuccessful operations (i.e. faults) will not be vi=
sible to memory
>  instrumentation although the execution side effects can be observed
>  (e.g. entering a exception handler).
>
> +Register Values
> ++++++++++++++++
> +
> +Callbacks registered with the ``QEMU_PLUGIN_CB_R_REGS`` flags can read
> +the current register values of the system. The plugin need to request
> +the list of available registers after a vcpu has initialised by
> +calling ``qemu_plugin_get_registers`` and using the supplied handle to
> +query the values when executing the callback.
> +
> +.. Note:: the program counter (PC) is not available through this
> +          interface but can be queried at translation time by using
> +          the ``qemu_plugin_insn_vaddr`` and
> +          ``qemu_plugin_insn_haddr`` on the instruction handle.
> +
> +
>  System Idle and Resume States
>  +++++++++++++++++++++++++++++
>
> diff --git a/plugins/api.c b/plugins/api.c
> index 8fa5a600ac3..fc3477acf2d 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -448,6 +448,11 @@ static GArray *create_register_handles(GArray *gdbst=
ub_regs)
>              continue;
>          }
>
> +        /* skip the program counter */
> +        if (g_ascii_strncasecmp(grd->name, "pc", 2) =3D=3D 0) {
> +            continue;
> +        }

Is the program counter always named "pc"? For instance
gdb-xml/microblaze-core.xml suggests it's named "rpc" there.
And on x86-64 I think from the gdb protocol point of view it
is named "rip" and the gdb "$pc" alias is handled on the gdb
side, but maybe I'm wrong.

Does the same problem apply to other registers whose value
we fix up after-the-fact via the restore_state_to_opc hook,
like the SPARC npc register, or the 32-bit Arm Thumb
IT bits in the CPSR?

thanks
-- PMM

