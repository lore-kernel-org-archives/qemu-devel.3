Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8F0D68BC8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tByTK-0005Ab-02; Fri, 15 Nov 2024 10:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tByTI-0005AS-Cd
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:42:56 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tByTG-0000eX-TT
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:42:56 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a99f3a5a44cso254990666b.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731685373; x=1732290173; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z+U8gMIen0AfRQdrD3Ww4SMkarJerb+9ZA3TqXNEmjg=;
 b=lvSCp2ezMA5olmwPsAVDgZQTRudVgemQpQ9DLMjVdTY3mhTK6THK4LdgC/no0tSAWj
 a9geSZ70RwYGJ7v/Hx3g49kUSzQGWstovcYtEJWMoOYkEfIChZKu+ka9Ede1CL76hZKv
 ekDfqdOQVpDECyPG8wS3ySjUXYJeiD83/fKRyswwLVDX3pd53sNx5ENfigPLDOke6yoa
 4nPefGouIh5p3jwbNyjgxG0ZBc/Dy6bvrtV6ZHgSz3L88LkLUEmFplC3ZqG6NVCZGDgp
 5KHzL603urPVYMFCXWFUwUyppp1nJeznXeFfpq0hlz7HXLR0bOw89l90BL6aZFz4SoTV
 eO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731685373; x=1732290173;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z+U8gMIen0AfRQdrD3Ww4SMkarJerb+9ZA3TqXNEmjg=;
 b=B47cfLUZiEcmJyXGQu5kKneVFCfZG/SOlR7YiIeyrNSjQlogVhGEZjOiO2AJVz52+X
 GaqeZBgrKIfjJ/6Vzp8OVWVfffhUPNRGBQIhT+EYWIzGMu6P597sdR7oRC4QUU3xCVQV
 gKQgOAa50GYG0QbVIGW2CwYgLPDNLaiNnLbr4fHbcpWsWrsAg/bZ7Nm4ztrTZuE3kEum
 pdGnxOOV+PWs14WdfF8rUBtxD3JiePjIO7+spW+M7lAuXyVFkImT33YG7vO4TTQnKknn
 LrlkFCGBYjNB4BcTqYnq4GeobApCFBShmJIyXJi/toOXinghiEbfnycNUzWuAZnIcToe
 5a2Q==
X-Gm-Message-State: AOJu0YzApgWjPRwoLsw3uuFmFig2HFIWiOeb9tEyqEBpX+8CjLrbXIrV
 PLhNUbR2c+n6CJS57QXJkeKWt4AucWyIbgI/vTpgjJGlIlTGFkzUn/OZUUT3ugURS3SefDHqXC+
 406htVhfAvw0w5F9Od8prj6oOJUyHUEPfEP1B9A==
X-Google-Smtp-Source: AGHT+IG+XTeMQeA4bo8V6/3YfygIb686VUwXQNdBO3Y8MwVMoOSSxWCn2Q0ewuvSQlD0ABYlR+JUbxIUFVA77znDa2o=
X-Received: by 2002:a17:906:fe01:b0:a99:ffdb:6fef with SMTP id
 a640c23a62f3a-aa483526a0cmr263697666b.46.1731685373123; Fri, 15 Nov 2024
 07:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20241115152053.66442-1-philmd@linaro.org>
 <20241115152053.66442-4-philmd@linaro.org>
In-Reply-To: <20241115152053.66442-4-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Nov 2024 15:42:42 +0000
Message-ID: <CAFEAcA-+J-FFTTc_mzgmrsN9b-vrEQq5=F=nwxO1NxAakhAbLg@mail.gmail.com>
Subject: Re: [PATCH 03/10] target/sparc: Move sparc_restore_state_to_opc() to
 cpu.c
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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

On Fri, 15 Nov 2024 at 15:22, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Most targets define their restore_state_to_opc() handler in cpu.c.
> In order to keep SPARC aligned, move sparc_restore_state_to_opc()
> from translate.c to cpu.c.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/sparc/cpu.h       | 11 ++++++++---
>  target/sparc/cpu.c       | 23 +++++++++++++++++++++++
>  target/sparc/translate.c | 32 --------------------------------
>  3 files changed, 31 insertions(+), 35 deletions(-)
>
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index f517e5a383..bcb3566a92 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -607,12 +607,17 @@ int sparc_cpu_memory_rw_debug(CPUState *cpu, vaddr =
addr,
>                                uint8_t *buf, int len, bool is_write);
>  #endif
>
> +/* Dynamic PC, must exit to main loop. */
> +#define DYNAMIC_PC         1
> +/* Dynamic PC, one of two values according to jump_pc[T2]. */
> +#define JUMP_PC            2
> +/* Dynamic PC, may lookup next TB. */
> +#define DYNAMIC_PC_LOOKUP  3
> +
> +#define DISAS_EXIT  DISAS_TARGET_0

Why move the definition of DISAS_EXIT ?
sparc_restore_state_to_opc() doesn't use it, and
the DISAS_ constants are a translate-time-only concept.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

