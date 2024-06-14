Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717E1C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 11:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI5CV-0005DN-Tl; Fri, 14 Jun 2024 07:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sI5CS-0005Ck-5H
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 07:34:32 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sI5CQ-0005Nn-Dy
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 07:34:31 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52c89d6b4adso1921327e87.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 04:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718364868; x=1718969668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=glJcENnAii1/45p9syJSsYSGPWI+QShtjqgqnZwXHI0=;
 b=LIABr2w+wNwIJo4fxIXmkkxgPiPI0SoJCuGCmLrun9g24xF6r/gOk0ARIKePbKnnCE
 zKAP4Y90oLTwXFo+WUR2VFFI8xY/mcCih0SlRJoT/e2R9g4wdLu/87tiDxm8YuwThwWg
 WSK1f4I7Ki4ygd/CAQ5qCSPwDVrEaRuJlAHgkFw3cy9no4UBIOg3jyve9dudR0aUvke+
 KsNL0xeWIZyWvocKGx/jjS3jg5A0HjUF4sJ1PRPtOh4td3yogrbwvkTsQYMjKUEXyhnj
 HxGYqARlteS+Gtowxa60Y2YLW4yue9fHwyoJQXvZTHbKu9tU6u9m+zC8f6wH7Gx3InT4
 3h1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718364868; x=1718969668;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=glJcENnAii1/45p9syJSsYSGPWI+QShtjqgqnZwXHI0=;
 b=xGO6+v9aJndOQmmUfuAzFxQQBGss1U55ov/FKcOohpA+rM4vSMUGxbI5QTbj+n3fk0
 ehI3P/xP+koBBhOM6LrV2FGrWPetBs/nwyeVxzBEu10VST54Qxo3zddKiEzZxdEm7162
 GMVGUvjMs5WwB9873+aOb6qbm1nO0ukN8PIOWUtyNKw/k1fL0mV8fVi0FkQyRN8nJte2
 wuDrt37rDIYlhW6DWQ9BxFhnILYv2FJGokLW+PRkPH/Nn8cKHQpBRxsmy3Y6I1nUymwd
 NdhEYhQGK4hkK9+34wr7HRgFVM9AxLSHwfThjXMg3ZiTp+so0iffdTy68pheP+AW6lcj
 CrgA==
X-Gm-Message-State: AOJu0Yw6SGHY5PiY68LJodvlrzRa7KEBA2crG3vu0A5Q8VAMl0J5p4ER
 xaif5kUmUm/X95Rjc5ZfNhfHtmxD2V1AynpZLsHGKjJAB1DDiFWsa065NTixLFU=
X-Google-Smtp-Source: AGHT+IGJMW3Z3KclfrOvF2bWnZuaWgk/ZM4kgKqo6YjTQ4mnHN+p3i5OzicZfTHJoxFT+dd8WSYD8w==
X-Received: by 2002:a05:6512:2255:b0:52c:89b5:27bc with SMTP id
 2adb3069b0e04-52ca6e90a24mr2022248e87.42.1718364867738; 
 Fri, 14 Jun 2024 04:34:27 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075114e86sm4141194f8f.115.2024.06.14.04.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 04:34:27 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D39D75F794;
 Fri, 14 Jun 2024 12:34:26 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  peter.maydell@linaro.org,
 richard.henderson@linaro.org
Subject: Re: [PATCH v2 7/9] gdbstub: Make get cpu and hex conversion
 functions non-internal
In-Reply-To: <20240613172103.2987519-8-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Thu, 13 Jun 2024 17:21:01 +0000")
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
 <20240613172103.2987519-8-gustavo.romero@linaro.org>
Date: Fri, 14 Jun 2024 12:34:26 +0100
Message-ID: <87sexfu5a5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x136.google.com
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Make the gdb_first_attached_cpu and gdb_hextomem non-internal so they
> are not confined to use only in gdbstub.c.

so they can be used by architecture extensions to the gdbstub?

we don't want everyone using these functions, or if we do maybe we
should consider moving them to cutils?

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  gdbstub/internals.h        | 2 --
>  include/exec/gdbstub.h     | 5 +++++
>  include/gdbstub/commands.h | 6 ++++++
>  3 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/gdbstub/internals.h b/gdbstub/internals.h
> index 34121dc61a..81875abf5f 100644
> --- a/gdbstub/internals.h
> +++ b/gdbstub/internals.h
> @@ -107,7 +107,6 @@ static inline int tohex(int v)
>=20=20
>  void gdb_put_strbuf(void);
>  int gdb_put_packet_binary(const char *buf, int len, bool dump);
> -void gdb_hextomem(GByteArray *mem, const char *buf, int len);
>  void gdb_memtohex(GString *buf, const uint8_t *mem, int len);
>  void gdb_memtox(GString *buf, const char *mem, int len);
>  void gdb_read_byte(uint8_t ch);
> @@ -130,7 +129,6 @@ bool gdb_got_immediate_ack(void);
>  /* utility helpers */
>  GDBProcess *gdb_get_process(uint32_t pid);
>  CPUState *gdb_get_first_cpu_in_process(GDBProcess *process);
> -CPUState *gdb_first_attached_cpu(void);
>  void gdb_append_thread_id(CPUState *cpu, GString *buf);
>  int gdb_get_cpu_index(CPUState *cpu);
>  unsigned int gdb_get_max_cpus(void); /* both */
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index 1bd2c4ec2a..77e5ec9a5b 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -135,4 +135,9 @@ void gdb_set_stop_cpu(CPUState *cpu);
>  /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
>  extern const GDBFeature gdb_static_features[];
>=20=20
> +/**
> + * Return the first attached CPU
> + */
> +CPUState *gdb_first_attached_cpu(void);
> +
>  #endif /* GDBSTUB_H */
> diff --git a/include/gdbstub/commands.h b/include/gdbstub/commands.h
> index 2204c3ddbe..914b6d7313 100644
> --- a/include/gdbstub/commands.h
> +++ b/include/gdbstub/commands.h
> @@ -93,4 +93,10 @@ void gdb_extend_set_table(GdbCmdParseEntry *table, int=
 size);
>   */
>  void gdb_extend_qsupported_features(char *qsupported_features);
>=20=20
> +/**
> + * Convert a hex string to bytes. Conversion is done per byte, so 2 hex =
digits
> + * are converted to 1 byte. Invalid hex digits are treated as 0 digits.
> + */
> +void gdb_hextomem(GByteArray *mem, const char *buf, int len);
> +
>  #endif /* GDBSTUB_COMMANDS_H */

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

