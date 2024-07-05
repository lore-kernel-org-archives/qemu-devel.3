Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446ECC30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 10:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPfmt-0000yQ-JK; Fri, 05 Jul 2024 06:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPfms-0000s3-04
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:03:30 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPfmp-0003aw-Jh
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:03:29 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52ea5dc3c66so925355e87.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 03:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720173805; x=1720778605; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JnurMLMGJRz6i3WzinAI/njgvtPzNU9KwzuuJv4+r9I=;
 b=JzO6fX2OcQUnRHXUuux3WCX7jDx3Gw5ORMKGUMjqg3wvyCQBEjL7vW3aedBHpVZksL
 1PzEeAn97ozP4APoFxsa0uEWLtJyaUt9BW3bQYA9CZo84/xniDZE9f2yrIbAR7v3OPP5
 pN21bqAvtpTaGsKepAiqEmnnKgyZrob66IT2ArBkEnm1RVyZnaL9FYlQo2+jNWqiUDrD
 Zbbnt0XAnmS5qJaWvEXhg7QySHt39H0mw8ubqC56RcWxturIIM7+oaF17nuMRElMauxt
 6fAhkNp7jBs4yDYNimjTkH/F2u8UNRMWgs9ZwAHKUQG1faHvK+aSkSr05DeSP/M2TNBe
 ZPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720173805; x=1720778605;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JnurMLMGJRz6i3WzinAI/njgvtPzNU9KwzuuJv4+r9I=;
 b=d/EAig9sb9Q7fXGhzfLrU6aUJ1XFiZJS9C15+Xas5IJArK2URY6HHVtEBkDKrEvwk2
 SJj1H/ES5N/3sOfDFS9H5P9iFlvp3+jTiKHTKrzA0CktobXl9aiOF7LI9jXDr/bfAdwS
 WWfYY7DjWCvcnxjE4KF5PA++nbTy8mTjkJnhJRNZMHPUy1ScLyp5QQhZ+UC4DIb/vpcc
 76oqO/7H98ThIQujS+EFL6H/VjLb0asmnIQWuUP15UA3/UXXyLPNGKBTx7kxZBJn3z+j
 88fT4LyiOFmOYPStSQ9n0NoMhts8FIM4yUiikJbBVJ5c/CPEpC2za6H3iIjya8r/RAN1
 wQpQ==
X-Gm-Message-State: AOJu0YyccwQzGf0U5Egmjc8ekIgOcJb7JbjxdBX5ULlBHuaglB3g6HIr
 iASeT+X39wzZCM1a2w4J3RkCFDtekPipx+qndG7DgKLRVXeIZS/ssZVqPstbT6XSvdMu0JMXCbN
 Qmq+6umgFRQvspUxj8wdQwd3Dyu57ELeXWr2Xcg==
X-Google-Smtp-Source: AGHT+IHB/VXFxGvmTHye30oHvQtOZ96YzkIPAbwkHDp4nuYkdVZxxXVHgzo3eMdXAVfXECzCDNo1X7Y6IDLcBQzhG3Y=
X-Received: by 2002:a05:6512:313a:b0:52e:96c7:f9e4 with SMTP id
 2adb3069b0e04-52ea06c94a0mr3535118e87.68.1720173804761; Fri, 05 Jul 2024
 03:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240705084047.857176-1-alex.bennee@linaro.org>
 <20240705084047.857176-39-alex.bennee@linaro.org>
In-Reply-To: <20240705084047.857176-39-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 5 Jul 2024 13:03:08 +0300
Message-ID: <CAAjaMXahywLz+3NvKmY3HD+ryxo1yt3FcaKXbvWN=cKh8RiG1g@mail.gmail.com>
Subject: Re: [PATCH v2 38/40] gdbstub: Use true to set cmd_startswith
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
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x130.google.com
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

On Fri, 5 Jul 2024 at 11:49, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> From: Gustavo Romero <gustavo.romero@linaro.org>
>
> cmd_startswith is a boolean so use 'true' to set it instead of 1.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20240628050850.536447-10-gustavo.romero@linaro.org>
> ---
>  gdbstub/gdbstub.c | 80 +++++++++++++++++++++++------------------------
>  1 file changed, 40 insertions(+), 40 deletions(-)
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 5c1612ed2a..b9ad0a063e 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -1433,26 +1433,26 @@ static const GdbCmdParseEntry gdb_v_commands_tabl=
e[] =3D {
>      {
>          .handler =3D handle_v_cont_query,
>          .cmd =3D "Cont?",
> -        .cmd_startswith =3D 1
> +        .cmd_startswith =3D true
>      },
>      {
>          .handler =3D handle_v_cont,
>          .cmd =3D "Cont",
> -        .cmd_startswith =3D 1,
> +        .cmd_startswith =3D true,
>          .allow_stop_reply =3D true,
>          .schema =3D "s0"
>      },
>      {
>          .handler =3D handle_v_attach,
>          .cmd =3D "Attach;",
> -        .cmd_startswith =3D 1,
> +        .cmd_startswith =3D true,
>          .allow_stop_reply =3D true,
>          .schema =3D "l0"
>      },
>      {
>          .handler =3D handle_v_kill,
>          .cmd =3D "Kill;",
> -        .cmd_startswith =3D 1
> +        .cmd_startswith =3D true
>      },
>  #ifdef CONFIG_USER_ONLY
>      /*
> @@ -1462,25 +1462,25 @@ static const GdbCmdParseEntry gdb_v_commands_tabl=
e[] =3D {
>      {
>          .handler =3D gdb_handle_v_file_open,
>          .cmd =3D "File:open:",
> -        .cmd_startswith =3D 1,
> +        .cmd_startswith =3D true,
>          .schema =3D "s,L,L0"
>      },
>      {
>          .handler =3D gdb_handle_v_file_close,
>          .cmd =3D "File:close:",
> -        .cmd_startswith =3D 1,
> +        .cmd_startswith =3D true,
>          .schema =3D "l0"
>      },
>      {
>          .handler =3D gdb_handle_v_file_pread,
>          .cmd =3D "File:pread:",
> -        .cmd_startswith =3D 1,
> +        .cmd_startswith =3D true,
>          .schema =3D "l,L,L0"
>      },
>      {
>          .handler =3D gdb_handle_v_file_readlink,
>          .cmd =3D "File:readlink:",
> -        .cmd_startswith =3D 1,
> +        .cmd_startswith =3D true,
>          .schema =3D "s0"
>      },
>  #endif
> @@ -1748,7 +1748,7 @@ static const GdbCmdParseEntry gdb_gen_query_set_com=
mon_table[] =3D {
>      {
>          .handler =3D handle_set_qemu_sstep,
>          .cmd =3D "qemu.sstep=3D",
> -        .cmd_startswith =3D 1,
> +        .cmd_startswith =3D true,
>          .schema =3D "l0"
>      },
>  };
> @@ -1804,7 +1804,7 @@ static const GdbCmdParseEntry gdb_gen_query_table[]=
 =3D {
>      {
>          .handler =3D handle_query_thread_extra,
>          .cmd =3D "ThreadExtraInfo,",
> -        .cmd_startswith =3D 1,
> +        .cmd_startswith =3D true,
>          .schema =3D "t0"
>      },
>  #ifdef CONFIG_USER_ONLY
> @@ -1816,14 +1816,14 @@ static const GdbCmdParseEntry gdb_gen_query_table=
[] =3D {
>      {
>          .handler =3D gdb_handle_query_rcmd,
>          .cmd =3D "Rcmd,",
> -        .cmd_startswith =3D 1,
> +        .cmd_startswith =3D true,
>          .schema =3D "s0"
>      },
>  #endif
>      {
>          .handler =3D handle_query_supported,
>          .cmd =3D "Supported:",
> -        .cmd_startswith =3D 1,
> +        .cmd_startswith =3D true,
>          .schema =3D "s0"
>      },
>      {
> @@ -1834,7 +1834,7 @@ static const GdbCmdParseEntry gdb_gen_query_table[]=
 =3D {
>      {
>          .handler =3D handle_query_xfer_features,
>          .cmd =3D "Xfer:features:read:",
> -        .cmd_startswith =3D 1,
> +        .cmd_startswith =3D true,
>          .schema =3D "s:l,l0"
>      },
>  #if defined(CONFIG_USER_ONLY)
> @@ -1842,27 +1842,27 @@ static const GdbCmdParseEntry gdb_gen_query_table=
[] =3D {
>      {
>          .handler =3D gdb_handle_query_xfer_auxv,
>          .cmd =3D "Xfer:auxv:read::",
> -        .cmd_startswith =3D 1,
> +        .cmd_startswith =3D true,
>          .schema =3D "l,l0"
>      },
>      {
>          .handler =3D gdb_handle_query_xfer_siginfo,
>          .cmd =3D "Xfer:siginfo:read::",
> -        .cmd_startswith =3D 1,
> +        .cmd_startswith =3D true,
>          .schema =3D "l,l0"
>       },
>  #endif
>      {
>          .handler =3D gdb_handle_query_xfer_exec_file,
>          .cmd =3D "Xfer:exec-file:read:",
> -        .cmd_startswith =3D 1,
> +        .cmd_startswith =3D true,
>          .schema =3D "l:l,l0"
>      },
>  #endif
>      {
>          .handler =3D gdb_handle_query_attached,
>          .cmd =3D "Attached:",
> -        .cmd_startswith =3D 1
> +        .cmd_startswith =3D true
>      },
>      {
>          .handler =3D gdb_handle_query_attached,
> @@ -1901,14 +1901,14 @@ static const GdbCmdParseEntry gdb_gen_set_table[]=
 =3D {
>      {
>          .handler =3D handle_set_qemu_sstep,
>          .cmd =3D "qemu.sstep:",
> -        .cmd_startswith =3D 1,
> +        .cmd_startswith =3D true,
>          .schema =3D "l0"
>      },
>  #ifndef CONFIG_USER_ONLY
>      {
>          .handler =3D gdb_handle_set_qemu_phy_mem_mode,
>          .cmd =3D "qemu.PhyMemMode:",
> -        .cmd_startswith =3D 1,
> +        .cmd_startswith =3D true,
>          .schema =3D "l0"
>      },
>  #endif
> @@ -1916,7 +1916,7 @@ static const GdbCmdParseEntry gdb_gen_set_table[] =
=3D {
>      {
>          .handler =3D gdb_handle_set_catch_syscalls,
>          .cmd =3D "CatchSyscalls:",
> -        .cmd_startswith =3D 1,
> +        .cmd_startswith =3D true,
>          .schema =3D "s0",
>      },
>  #endif
> @@ -2012,7 +2012,7 @@ static int gdb_handle_packet(const char *line_buf)
>              static const GdbCmdParseEntry target_halted_cmd_desc =3D {
>                  .handler =3D handle_target_halt,
>                  .cmd =3D "?",
> -                .cmd_startswith =3D 1,
> +                .cmd_startswith =3D true,
>                  .allow_stop_reply =3D true,
>              };
>              cmd_parser =3D &target_halted_cmd_desc;
> @@ -2023,7 +2023,7 @@ static int gdb_handle_packet(const char *line_buf)
>              static const GdbCmdParseEntry continue_cmd_desc =3D {
>                  .handler =3D handle_continue,
>                  .cmd =3D "c",
> -                .cmd_startswith =3D 1,
> +                .cmd_startswith =3D true,
>                  .allow_stop_reply =3D true,
>                  .schema =3D "L0"
>              };
> @@ -2035,7 +2035,7 @@ static int gdb_handle_packet(const char *line_buf)
>              static const GdbCmdParseEntry cont_with_sig_cmd_desc =3D {
>                  .handler =3D handle_cont_with_sig,
>                  .cmd =3D "C",
> -                .cmd_startswith =3D 1,
> +                .cmd_startswith =3D true,
>                  .allow_stop_reply =3D true,
>                  .schema =3D "l0"
>              };
> @@ -2047,7 +2047,7 @@ static int gdb_handle_packet(const char *line_buf)
>              static const GdbCmdParseEntry v_cmd_desc =3D {
>                  .handler =3D handle_v_commands,
>                  .cmd =3D "v",
> -                .cmd_startswith =3D 1,
> +                .cmd_startswith =3D true,
>                  .schema =3D "s0"
>              };
>              cmd_parser =3D &v_cmd_desc;
> @@ -2064,7 +2064,7 @@ static int gdb_handle_packet(const char *line_buf)
>              static const GdbCmdParseEntry detach_cmd_desc =3D {
>                  .handler =3D handle_detach,
>                  .cmd =3D "D",
> -                .cmd_startswith =3D 1,
> +                .cmd_startswith =3D true,
>                  .schema =3D "?.l0"
>              };
>              cmd_parser =3D &detach_cmd_desc;
> @@ -2075,7 +2075,7 @@ static int gdb_handle_packet(const char *line_buf)
>              static const GdbCmdParseEntry step_cmd_desc =3D {
>                  .handler =3D handle_step,
>                  .cmd =3D "s",
> -                .cmd_startswith =3D 1,
> +                .cmd_startswith =3D true,
>                  .allow_stop_reply =3D true,
>                  .schema =3D "L0"
>              };
> @@ -2087,7 +2087,7 @@ static int gdb_handle_packet(const char *line_buf)
>              static const GdbCmdParseEntry backward_cmd_desc =3D {
>                  .handler =3D handle_backward,
>                  .cmd =3D "b",
> -                .cmd_startswith =3D 1,
> +                .cmd_startswith =3D true,
>                  .allow_stop_reply =3D true,
>                  .schema =3D "o0"
>              };
> @@ -2099,7 +2099,7 @@ static int gdb_handle_packet(const char *line_buf)
>              static const GdbCmdParseEntry file_io_cmd_desc =3D {
>                  .handler =3D gdb_handle_file_io,
>                  .cmd =3D "F",
> -                .cmd_startswith =3D 1,
> +                .cmd_startswith =3D true,
>                  .schema =3D "L,L,o0"
>              };
>              cmd_parser =3D &file_io_cmd_desc;
> @@ -2110,7 +2110,7 @@ static int gdb_handle_packet(const char *line_buf)
>              static const GdbCmdParseEntry read_all_regs_cmd_desc =3D {
>                  .handler =3D handle_read_all_regs,
>                  .cmd =3D "g",
> -                .cmd_startswith =3D 1
> +                .cmd_startswith =3D true
>              };
>              cmd_parser =3D &read_all_regs_cmd_desc;
>          }
> @@ -2120,7 +2120,7 @@ static int gdb_handle_packet(const char *line_buf)
>              static const GdbCmdParseEntry write_all_regs_cmd_desc =3D {
>                  .handler =3D handle_write_all_regs,
>                  .cmd =3D "G",
> -                .cmd_startswith =3D 1,
> +                .cmd_startswith =3D true,
>                  .schema =3D "s0"
>              };
>              cmd_parser =3D &write_all_regs_cmd_desc;
> @@ -2131,7 +2131,7 @@ static int gdb_handle_packet(const char *line_buf)
>              static const GdbCmdParseEntry read_mem_cmd_desc =3D {
>                  .handler =3D handle_read_mem,
>                  .cmd =3D "m",
> -                .cmd_startswith =3D 1,
> +                .cmd_startswith =3D true,
>                  .schema =3D "L,L0"
>              };
>              cmd_parser =3D &read_mem_cmd_desc;
> @@ -2142,7 +2142,7 @@ static int gdb_handle_packet(const char *line_buf)
>              static const GdbCmdParseEntry write_mem_cmd_desc =3D {
>                  .handler =3D handle_write_mem,
>                  .cmd =3D "M",
> -                .cmd_startswith =3D 1,
> +                .cmd_startswith =3D true,
>                  .schema =3D "L,L:s0"
>              };
>              cmd_parser =3D &write_mem_cmd_desc;
> @@ -2153,7 +2153,7 @@ static int gdb_handle_packet(const char *line_buf)
>              static const GdbCmdParseEntry get_reg_cmd_desc =3D {
>                  .handler =3D handle_get_reg,
>                  .cmd =3D "p",
> -                .cmd_startswith =3D 1,
> +                .cmd_startswith =3D true,
>                  .schema =3D "L0"
>              };
>              cmd_parser =3D &get_reg_cmd_desc;
> @@ -2164,7 +2164,7 @@ static int gdb_handle_packet(const char *line_buf)
>              static const GdbCmdParseEntry set_reg_cmd_desc =3D {
>                  .handler =3D handle_set_reg,
>                  .cmd =3D "P",
> -                .cmd_startswith =3D 1,
> +                .cmd_startswith =3D true,
>                  .schema =3D "L?s0"
>              };
>              cmd_parser =3D &set_reg_cmd_desc;
> @@ -2175,7 +2175,7 @@ static int gdb_handle_packet(const char *line_buf)
>              static const GdbCmdParseEntry insert_bp_cmd_desc =3D {
>                  .handler =3D handle_insert_bp,
>                  .cmd =3D "Z",
> -                .cmd_startswith =3D 1,
> +                .cmd_startswith =3D true,
>                  .schema =3D "l?L?L0"
>              };
>              cmd_parser =3D &insert_bp_cmd_desc;
> @@ -2186,7 +2186,7 @@ static int gdb_handle_packet(const char *line_buf)
>              static const GdbCmdParseEntry remove_bp_cmd_desc =3D {
>                  .handler =3D handle_remove_bp,
>                  .cmd =3D "z",
> -                .cmd_startswith =3D 1,
> +                .cmd_startswith =3D true,
>                  .schema =3D "l?L?L0"
>              };
>              cmd_parser =3D &remove_bp_cmd_desc;
> @@ -2197,7 +2197,7 @@ static int gdb_handle_packet(const char *line_buf)
>              static const GdbCmdParseEntry set_thread_cmd_desc =3D {
>                  .handler =3D handle_set_thread,
>                  .cmd =3D "H",
> -                .cmd_startswith =3D 1,
> +                .cmd_startswith =3D true,
>                  .schema =3D "o.t0"
>              };
>              cmd_parser =3D &set_thread_cmd_desc;
> @@ -2208,7 +2208,7 @@ static int gdb_handle_packet(const char *line_buf)
>              static const GdbCmdParseEntry thread_alive_cmd_desc =3D {
>                  .handler =3D handle_thread_alive,
>                  .cmd =3D "T",
> -                .cmd_startswith =3D 1,
> +                .cmd_startswith =3D true,
>                  .schema =3D "t0"
>              };
>              cmd_parser =3D &thread_alive_cmd_desc;
> @@ -2219,7 +2219,7 @@ static int gdb_handle_packet(const char *line_buf)
>              static const GdbCmdParseEntry gen_query_cmd_desc =3D {
>                  .handler =3D handle_gen_query,
>                  .cmd =3D "q",
> -                .cmd_startswith =3D 1,
> +                .cmd_startswith =3D true,
>                  .schema =3D "s0"
>              };
>              cmd_parser =3D &gen_query_cmd_desc;
> @@ -2230,7 +2230,7 @@ static int gdb_handle_packet(const char *line_buf)
>              static const GdbCmdParseEntry gen_set_cmd_desc =3D {
>                  .handler =3D handle_gen_set,
>                  .cmd =3D "Q",
> -                .cmd_startswith =3D 1,
> +                .cmd_startswith =3D true,
>                  .schema =3D "s0"
>              };
>              cmd_parser =3D &gen_set_cmd_desc;
> --
> 2.39.2
>


Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

