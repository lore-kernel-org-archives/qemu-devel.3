Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF51AC3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 10:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPfs5-0006jx-F4; Fri, 05 Jul 2024 06:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPfs3-0006jC-7y
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:08:51 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPfs0-0005iQ-3r
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:08:50 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a77cb7c106dso65337066b.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 03:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720174126; x=1720778926; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+LAIVN7rrbTPh0fHFqivhxykULiUQ1NLO2ql5KaY924=;
 b=R0UUYoBosOM0YVn2URA+BuvavIObrrnvCJjTK0xf6EGa6xABHeBzwbnR78JeK2+qmX
 849lopyRif2NchTMlVEjSrysQ0Y+UcvlD9qUu3xHzojstjmDBhoG7tdmbVqLAKVoCtqT
 GhsKs4bapSPqWSeBpErNBt/0ATL4kCduPmgqf6GD0aXZUvJ2o93y9cIeXlBU6HFuR98m
 /HA1qzBkgsbf2yZOnYrogR5OGaRXePEWTG/Af87GxAPHxBsghL6+2viKLXzrqKbStG08
 7xvO9HTMCCAdqgLoqcnX8gx7MgOrPF1NZCI5sA9YJg0R6o5kIscWTsHb7MVgxVaHalI0
 DbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720174126; x=1720778926;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+LAIVN7rrbTPh0fHFqivhxykULiUQ1NLO2ql5KaY924=;
 b=ahBVjbwzHgB+XQtILgE98AwFldtonAIzlv5qgBc7GI2OlaCAfd4aS4AR1t6ZK9G73V
 eDiZvglCDc7GFZfZ6Xh3OpGugGUF1eeNC87IZhaVv0/LpvZrMUpkrsSd0S4fKo7XKmSP
 gbhL+R74PEGTHWeuUsjp+5iYE7eo8jvxGUWkapAbf+OBHKDFvvT7cASLWmaI24aYdh6l
 w7DhDkOstJoVGKxv8WioKLGTKkBc2zCl4+Im+ybCLz6RSdcWGwsQioFNP29f7oTc0Ve/
 Vel1b1qwMp+vuICdlgbTwQ3H/tW1zpyQRw7A4wQEYKcvKLOawKc6LhWwnCXFYzCJcwoi
 Qwlg==
X-Gm-Message-State: AOJu0YzoL/dq2vVPCM+Wm4+qGJQ+kLKOlvidGQgVMmXNOLyFS5FpWUyn
 hTBQ8ncFMkRYwB4lNqn000E9Yjt+t3Kmv5IMYn4UgVfpswZzUc2zkxbiu+onG1K/scrzZdtxKyy
 EnkikjUR1TVttaP46M0iN4njJIlNKlDoypXTQzA==
X-Google-Smtp-Source: AGHT+IHNDVxDH803a6lPOst1HWZNIbH1XCGrT+/jAvJ9rh7Qq3Wln9V3f2mgdmD5J3aOkpN1F4vnuFulqDdsAFq3c4A=
X-Received: by 2002:a17:907:6e87:b0:a6f:12:8c45 with SMTP id
 a640c23a62f3a-a77ba7295f2mr364790766b.72.1720174126333; Fri, 05 Jul 2024
 03:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240705084047.857176-1-alex.bennee@linaro.org>
 <20240705084047.857176-38-alex.bennee@linaro.org>
In-Reply-To: <20240705084047.857176-38-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 5 Jul 2024 13:08:30 +0300
Message-ID: <CAAjaMXYPrgH5zdvcHjDHDijvwSsNxDdNn76EwFNuRA-SAh1m2Q@mail.gmail.com>
Subject: Re: [PATCH v2 37/40] gdbstub: Pass CPU context to command handler
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, 
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 Gustavo Romero <gustavo.romero@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62c.google.com
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

On Fri, 5 Jul 2024 at 11:47, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> From: Gustavo Romero <gustavo.romero@linaro.org>
>
> Allow passing the current CPU context to command handlers via user_ctx
> when the handler requires it.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20240628050850.536447-9-gustavo.romero@linaro.org>
> ---
>  include/gdbstub/commands.h | 3 +++
>  gdbstub/gdbstub.c          | 7 ++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/include/gdbstub/commands.h b/include/gdbstub/commands.h
> index e51f276b40..f3058f9dda 100644
> --- a/include/gdbstub/commands.h
> +++ b/include/gdbstub/commands.h
> @@ -54,6 +54,8 @@ typedef union GdbCmdVariant {
>   * "stop reply" packet. The list of commands that accept such response i=
s
>   * defined at the GDB Remote Serial Protocol documentation. See:
>   * https://sourceware.org/gdb/onlinedocs/gdb/Stop-Reply-Packets.html#Sto=
p-Reply-Packets.
> + *
> + * @need_cpu_context: Pass current CPU context to command handler via us=
er_ctx.
>   */
>  typedef struct GdbCmdParseEntry {
>      GdbCmdHandler handler;
> @@ -61,6 +63,7 @@ typedef struct GdbCmdParseEntry {
>      bool cmd_startswith;
>      const char *schema;
>      bool allow_stop_reply;
> +    bool need_cpu_context;
>  } GdbCmdParseEntry;
>
>  /**
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index b1ca253f97..5c1612ed2a 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -938,6 +938,7 @@ static bool process_string_cmd(const char *data,
>
>      for (i =3D 0; i < num_cmds; i++) {
>          const GdbCmdParseEntry *cmd =3D &cmds[i];
> +        void *user_ctx =3D NULL;
>          g_assert(cmd->handler && cmd->cmd);
>
>          if ((cmd->cmd_startswith && !startswith(data, cmd->cmd)) ||
> @@ -952,8 +953,12 @@ static bool process_string_cmd(const char *data,
>              }
>          }
>
> +        if (cmd->need_cpu_context) {
> +            user_ctx =3D (void *)gdbserver_state.g_cpu;
> +        }
> +
>          gdbserver_state.allow_stop_reply =3D cmd->allow_stop_reply;
> -        cmd->handler(params, NULL);
> +        cmd->handler(params, user_ctx);
>          return true;
>      }
>
> --
> 2.39.2
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

