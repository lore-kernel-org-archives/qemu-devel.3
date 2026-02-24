Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBF2F4BB63
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 17:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuwU5-0002Yw-QL; Tue, 24 Feb 2026 12:46:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vuwU4-0002YX-GT
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:46:08 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vuwU2-00059y-CJ
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:46:08 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-65f812e0c83so254375a12.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 09:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771955164; x=1772559964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5RLC1ozp8VlYH1iK5hCOQvJdqWCnxu8KVh6aWLAUs5g=;
 b=yltLxDikwf8pLQkfvh6QCmSpB2t6l18DvPeJHi3wVzO+u1DClU8RA1bIDWGF8jtgMF
 aREx86pNgM4PCu8V9tCTJBHNA9I2JfYS8RXpEwWPVOdP0ZHUpx810vI94m3K7VceWZzR
 nVOTvuvtgu+vaqt24xPywkIQTmHjn6RLqkKCdQOmHvkhOzLvcb9hyfHzuB8MqLtQk/SB
 qJG3VHa25SeTJtVmTubTJ3L7cIaXTaaP2SrIAjCfVuLqhBUZzHjSXWs3K89x3127cN0t
 V+ptwp0KX52r6FENyI8GGDnSLSIRQiRNswSC+elbYi2KrVKZbM74X9Aimz5FMNGrfyI/
 pugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771955164; x=1772559964;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5RLC1ozp8VlYH1iK5hCOQvJdqWCnxu8KVh6aWLAUs5g=;
 b=pztPYLyF9isY2+kbOBro+Fd5LUNtI04zzc+ncG7VR0+TPIY++DH+k+9jAuy8kjBffI
 xrjknNRA+UsvSPw1iEcUENMkJMi10WSo1v/32W7Q/lbdQYNN/Y2vLYz7eGjKQ8iTXfGZ
 z8JpcP+9SnKbBy0GbWTNoeYx8xzqIspTkihM26AdHEIrCjVjqtNz9+GGyPCBk6EjkLfg
 6S27wqqR/4CHzQn5XbLIHOArfSVAyGEyunwXA+qSP0I5j2sHFGBFq5KDkmNu439Jx6V9
 KN7uhsoiycvzH/yXWcYMhvinvEU7fI/z6U0xjqReIExyU80u1HAvEYVUdwrFoeoNz1Pz
 c9hg==
X-Gm-Message-State: AOJu0YzJzy/HaqKWDFnWOa4K9THHgEm00qnsefr9bolOu/PFa9f4nUJh
 Aa6LX7q7gS4tMPLofzE1dovPviEwLuXs56S4PY1XBT8KYp121W6USp05m9J8OXT+cr7BQGM64Ej
 rqEIv
X-Gm-Gg: ATEYQzzdFs2oY0O62GR1EK59G5LD7YFvoz/Xqyndqd5/RQ3FcQwVuAO1qbn2pcIUsQM
 FEcCZgJgmT54x8ycnbpjDdl7D0Pzps9s9Z/aJXBSGAndpHxpGfvga1Pyu8rVFdg2UmENlXuxd6J
 wVBpy4NjCozmEAI7AfTGsnpSs+qtaGxA3+C7pM+i30vH/tjmg0gMssieNjMAg4ZcfN1EaeGHOvi
 +dplvYyKdb+6+MvW9YfhxQnG0H9YJedeH9RPvS/6fuhMrohlJWiWfa0awjOoD4YLus5jRIbh+7v
 z7Z9RGk9nHy3ZVhLY+FMQfsTwVBrB3dpvEgfS3Umvr6F73FPvFOkHV0QYHAxSp3k4dsR22M/nBX
 +FagXA/9gjJn4KKFZUFOZGtihIm/NF5rU/5zaBsPNjX5rAuXI6qSOLUNrB+sXl8TJEAfgncDyTR
 g+MZ6MUqqipfZ6bfrk5FEUW+HkiKp3gLa0JQ==
X-Received: by 2002:a05:6402:3646:b0:65c:c0b:cb9d with SMTP id
 4fb4d7f45d1cf-65ea4f03bbcmr5500446a12.23.1771955164321; 
 Tue, 24 Feb 2026 09:46:04 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65eaba13866sm3500536a12.18.2026.02.24.09.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 09:46:03 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C53025F7B4;
 Tue, 24 Feb 2026 17:46:01 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org,  laurent@vivier.eu,  imp@bsdimp.com,
 berrange@redhat.com
Subject: Re: [PATCH v4 3/7] plugins: add PC diversion API function
In-Reply-To: <33eb2408-b4c3-4ca4-9555-b2015fa38630@epfl.ch> (Florian
 Hofhammer's message of "Tue, 24 Feb 2026 16:51:36 +0100")
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <33eb2408-b4c3-4ca4-9555-b2015fa38630@epfl.ch>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Tue, 24 Feb 2026 17:46:01 +0000
Message-ID: <87wm022fxi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

Florian Hofhammer <florian.hofhammer@epfl.ch> writes:

> This patch adds a plugin API function that allows diverting the program
> counter during execution. A potential use case for this functionality is
> to skip over parts of the code, e.g., by hooking into a specific
> instruction and setting the PC to the next instruction in the callback.
>
> Link: https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg00656.h=
tml
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
>  include/plugins/qemu-plugin.h | 13 +++++++++++++
>  plugins/api.c                 | 13 +++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
> index a6ec8e275d..04c884e82b 100644
> --- a/include/plugins/qemu-plugin.h
> +++ b/include/plugins/qemu-plugin.h
> @@ -76,6 +76,7 @@ typedef uint64_t qemu_plugin_id_t;
>   *
>   * version 6:
>   * - changed return value of qemu_plugin_{read,write}_register from int =
to bool
> + * - added qemu_plugin_set_pc
>   */
>=20=20
>  extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
> @@ -1042,6 +1043,18 @@ QEMU_PLUGIN_API
>  bool qemu_plugin_write_register(struct qemu_plugin_register *handle,
>                                  GByteArray *buf);
>=20=20
> +/**
> + * qemu_plugin_set_pc() - set the program counter for the current vCPU
> + *
> + * @vaddr: the new virtual (guest) address for the program counter
> + *
> + * This function sets the program counter for the current vCPU to @vaddr=
 and
> + * resumes execution at that address. This function only returns in case=
 of
> + * errors.
> + */
> +QEMU_PLUGIN_API
> +void qemu_plugin_set_pc(uint64_t vaddr);
> +
>  /**
>   * qemu_plugin_read_memory_vaddr() - read from memory using a virtual ad=
dress
>   *
> diff --git a/plugins/api.c b/plugins/api.c
> index e754b7c69c..ca3e93a194 100644
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
> @@ -466,6 +467,18 @@ bool qemu_plugin_write_register(struct qemu_plugin_r=
egister *reg,
>      return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(r=
eg) - 1) > 0);
>  }
>=20=20
> +void qemu_plugin_set_pc(uint64_t vaddr)
> +{
> +    g_assert(current_cpu);
> +
> +    if (qemu_plugin_get_cb_flags() !=3D QEMU_PLUGIN_CB_RW_REGS_PC) {
> +        return;
> +    }

I think its fine to assert() here - we do it elsewhere in the api, if
the user is holding it wrong we should exit now rather than leave the
plugin more confused in the future.

> +
> +    cpu_set_pc(current_cpu, vaddr);
> +    cpu_loop_exit(current_cpu);
> +}
> +
>  bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size=
_t len)
>  {
>      g_assert(current_cpu);

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

