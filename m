Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D8BCAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 10:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzYpt-00071G-Rn; Fri, 19 Sep 2025 06:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uzYps-00070u-6K
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:59:28 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uzYpo-0008KY-Ek
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:59:27 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45dd7b15a64so17474465e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 03:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758279562; x=1758884362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ge6UiqctOzW4hIEmHh3U96UtrVPRKX0oZZeYaEsPqqk=;
 b=oZ4k52E8i7XScVfu5ZVu/vzStDIqcWgToBs1tbuzjZwdJgAKUp3tsAUN7R4qOzx7Ls
 nLtqttpQ85xaM9zZMHVJ4neiy7nDpjG9PHBZrTAr8aLsCMTUemuP42lnY6P7YEEOWJkN
 Ck6UexgLvFlbcN/ULjZwktUtlqc/0RcXKLj3lyn8dUu1BoFcWufy1f4lhGOP5e7IDr/W
 xuAKRt/eFqnNJTsASOdDCXcKIhMDAcYRnAdudRfCYq1yxEMoeBmWT8ojsRPwqrqLB+FX
 Ddgbx0KFugQ1YnLjrQ3nkrOZD3EvXLpfI3zqnFWVDUYdMrTwztXxHCsNH2GrVz02m8Fj
 lTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758279563; x=1758884363;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ge6UiqctOzW4hIEmHh3U96UtrVPRKX0oZZeYaEsPqqk=;
 b=HWhluZQhIX2fM1g3JsQyKlpSeBnELCDlOrlao2m3/TDrQ7swk3v8gmq12MOFCElsSE
 Nb2fbIGAX+r3p5ozn5/UGEyiidCTuOeB5dQ1ISPw5WY4zxz4hE4DzeBwC80jj9MxdKje
 unO+gINaSn/ORa0QK+s9Y4wy25Jv9dv9WmJnTwF8vZahjMQnw9PgRIuRQ+xeKbBTdAQ+
 khVWSM1cPB9LxnHrXwkr5zDFr5aNMdOJ5UOdD91/l2e232fiQEJy1jbpZePx43R/Fatq
 vWPxIH3PRVuXC4ToA32sAOxGSxrOQnUkkbK4EZq01PQUlkQBslNLgVC9anGNYPF6cFpj
 E1Qw==
X-Gm-Message-State: AOJu0YwjHsT78OD4a0iXnFKxtRW56CcAPBqTpInwWY2y7ixStFLhSwfM
 RW0S826a3I16npMqKmC4u/4Xd68upU3506LFQZ5Vj3sIjL8OX33z/gNMcIaDe+7Te2U=
X-Gm-Gg: ASbGnctUUiNashFuGGO/EfHSfq7xUFgUpXvW9N1XiklAGrPQGEoAM93jomatSKNwPC3
 BDWRnO8GDNe4tbva0gBo8lxebe01TohPJNopcCyXynqGEZC9wv4ZDLq2L1Mo7RHwzWu6aP2+RdC
 b2+I6FnNQvAhyZsRzto4MERt7Zf0+kA8rCtzqilZUDUAJm2m4lRrOxsoiBdow5mTXbn0KSBEWhn
 y8x3cyslpcEjXQcGjd6v6H/uTujDXI6j2Gkq6hoqKOIhOyhq9Su17newUcOephsMTAqMrasgxD3
 0Sq3xLhvRiiSiuoS6/IOY0Bj/1BD/ucFfoGEYsyJl1MR+e+axNPrl71srZtoJ3HX5rwk3q18aMj
 QLpm2fRMJRUCv5IXd76KHt/s=
X-Google-Smtp-Source: AGHT+IFCaB+vy+2+g+fQxLyRuPwVUz/e4Lx2MR+7PHTa5inYdWHIWoM9iQ2nxAgdGTEvLnrB6CSoFg==
X-Received: by 2002:a05:600c:4754:b0:458:b8b0:6338 with SMTP id
 5b1f17b1804b1-467a7f111b4mr33012545e9.6.1758279562580; 
 Fri, 19 Sep 2025 03:59:22 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45f320e2000sm82501235e9.1.2025.09.19.03.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Sep 2025 03:59:21 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C49545F827;
 Fri, 19 Sep 2025 11:59:19 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Warner Losh <imp@bsdimp.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH] plugins: Add PC diversion API function
In-Reply-To: <f56b02b1-3b50-424a-8b20-c5e5e3e0212a@epfl.ch> (Florian
 Hofhammer's message of "Thu, 11 Sep 2025 17:11:21 +0200")
References: <f56b02b1-3b50-424a-8b20-c5e5e3e0212a@epfl.ch>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 19 Sep 2025 11:59:19 +0100
Message-ID: <87bjn6n1x4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Florian Hofhammer <florian.hofhammer@epfl.ch> writes:

> This patch adds a plugin API function that allows diverting the program
> counter during execution. A potential use case for this functionality is
> to skip over parts of the code, e.g., by hooking into a specific
> instruction and setting the PC to the next instruction in the callback.
>
> Link:
> https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg00656.html

Thanks for taking the time to roll a proper patch. I assume this is
working for you OK?

If we were to go forward with up-streaming we would want expand a test
case to cover the new API. Maybe we could expand the syscall plugin with
an option to emulate a system call.

>
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
>  include/qemu/qemu-plugin.h | 12 ++++++++++++
>  plugins/api.c              |  9 +++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index c450106af1..fe4e053c52 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -943,6 +943,18 @@ QEMU_PLUGIN_API
>  int qemu_plugin_write_register(struct qemu_plugin_register *handle,
>                                GByteArray *buf);
>=20=20
> +/**
> + * qemu_plugin_set_pc() - set the program counter for the current vCPU
> + *
> + * @vaddr: the new virtual (guest) address for the program counter
> + *
> + * This function sets the program counter for the current vCPU to @vaddr=
 and
> + * resumes execution at that address. This function does not return.
> + */
> +QEMU_PLUGIN_API
> +G_NORETURN
> +void qemu_plugin_set_pc(uint64_t vaddr);
> +

The current potential foot guns I can see are:

  - are we called from a callback with QEMU_PLUGIN_CB_RW_REGS
  - could multiple hooks be wanting to set the PC?

Not doing the first could potentially loose you register values which
wouldn't be rectified until later in the block.

Currently we maintain the list qemu_plugin_insn.insn_cbs in the order
they are set. However if the callback that changes the flow is in the
middle we risk not calling the others.

Currently there is no protection against multiple callbacks wanting to
change the flow.

Maybe we need a new callback register that implies
QEMU_PLUGIN_CB_RW_REGS and we will always ensure is the last cb of the
chain?

>  /**
>   * qemu_plugin_read_memory_vaddr() - read from memory using a virtual ad=
dress
>   *
> diff --git a/plugins/api.c b/plugins/api.c
> index eac04cc1f6..0511b72ebb 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -41,6 +41,7 @@
>  #include "qemu/log.h"
>  #include "system/memory.h"
>  #include "tcg/tcg.h"
> +#include "exec/cpu-common.h"
>  #include "exec/gdbstub.h"
>  #include "exec/target_page.h"
>  #include "exec/translation-block.h"
> @@ -457,6 +458,14 @@ int qemu_plugin_write_register(struct qemu_plugin_re=
gister *reg,
>      return gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(re=
g) - 1);
>  }
>=20=20
> +void qemu_plugin_set_pc(uint64_t vaddr)
> +{
> +    g_assert(current_cpu);
> +
> +    cpu_set_pc(current_cpu, vaddr);
> +    cpu_loop_exit(current_cpu);
> +}
> +

As you see the actual mechanics of restarting at the new PC is the easy
bit ;-)

>  bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size=
_t len)
>  {
>      g_assert(current_cpu);

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

