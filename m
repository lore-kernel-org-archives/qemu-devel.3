Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1ADE87841
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIZr-0005UC-0R; Tue, 03 Feb 2026 10:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnIZp-0005TF-Cz
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:44:29 -0500
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnIZn-0000sL-LN
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:44:29 -0500
Received: by mail-ej1-x644.google.com with SMTP id
 a640c23a62f3a-b883787268fso832602166b.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770133466; x=1770738266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q0WKU2JzX0ALasBma/VrQ27Ivs9nzG7RdqGlD0quZeY=;
 b=UBlulORluYWfSWk3wK4TmOxyjxh/5sktRo21meVcUrsEe3NQdmadBDirpme6BZHpfJ
 QLcb8hCys95688W5D7fz27diSoqlLhtSotlmQKBt5joNShmGsjAAQQCskq5Ttu2jSuFp
 4H4OqubJzCPgvLJu5Wfz1K/6WkwrRm7MrVbJiQputQkW0Mn86amH2cYlKSKmz/G7AuOm
 9N1wc316OHHp4vERNIQE6/YBnOs4CnYfeaNBNLF4S+j9hNEXUuowPeYjthgcZUiJ5mFQ
 PaGNoA4g5oRptaj9PJrekk+6XuuDSnZwUkVgLZyLWnvDm/C2tH1uiq0G2P09bI+4ZQiS
 jYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770133466; x=1770738266;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q0WKU2JzX0ALasBma/VrQ27Ivs9nzG7RdqGlD0quZeY=;
 b=hQTgrKFQdWsJEsr/adnFSJc/8g+BiWvzHLNS5JTXeqNsbm8lxWv7Q+ZT8DoZQOvJ+E
 ZdD1uris/wt5HFMzI1vagzqddiH0+9nkwFzmW784MQ4qox+knWSBr9Bnp9VCq94wc6jA
 IaRAkE1u0JDTz3kXNce82ULZ44sxxG0O0DCSkMMpVQUeq/AZKqUwaD3jj+P7lmL+aL3N
 AS0RH98iBnfHzEROCFNIWYTfTCtLrue8oooxn//cOrKSvuPfi2VK4+JLBkzYMX6KAHOe
 RzZhLkGFxL1G4a5q8ZUcd85Q46CVlNHh4DAOE3vJdaFpzZbofPgzl4kZd/l+v7sHz5QB
 sNoA==
X-Gm-Message-State: AOJu0Yy181cP8Cota30+bFo1fbkHDJRAhV4q7DyWMvrJspu0Yp83jST4
 7PxQGTCFjF0XGnBjM8HDy2b7nBrthvouBVz+zdQntKjLa34Rd6ohzvOGIWG0hRLoOQk=
X-Gm-Gg: AZuq6aIQTwsKMxHCmgnqstsaRqIzUl0HiuXpw5Urvmqz0PsbBHOCskAbunyytXy68vU
 0lexF8BZVi3d6WPJs02n+g8z8isv1YMEELK5AyZXawAAwxkfBk6fIQcfMLFRf/JHfCff2Cw3Nfp
 QMb2MvlSgX4VpLx7+jGnjLZ0TvCwVACaMA/ntuXnfq1MTVv+w5vFvAMPEqZu2wOPiBU94F3gy8j
 oPx2j9hc37b6rwaLB0cODVwB9Iyvu5CuTJiSEC3jCAC+qTS70CUgCHmHnGNqhl2oIFuZ3M33vNd
 2JX7b9xSAy9CYXrl7oUCPVG118jJrl4rfKQP+ZkKtdXmnYRdDRTUnFZkY+r+6jtm0iRmlZyBeb5
 lkNykQIKvssaY02f2W4CJB3RAZykJeqrm8RqbKyeSfJcHwyDVHRv6SJlYfCORz8irxvDFVFUCoy
 xslWpPleqvQ9M=
X-Received: by 2002:a17:907:6d27:b0:b87:4f80:f4ca with SMTP id
 a640c23a62f3a-b8dff899e3amr1004243466b.56.1770133465875; 
 Tue, 03 Feb 2026 07:44:25 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8dd99188adsm923226166b.50.2026.02.03.07.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 07:44:25 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 248AE5F841;
 Tue, 03 Feb 2026 15:44:24 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  qemu-arm@nongnu.org,  Markus Armbruster
 <armbru@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 David Gibson
 <david@gibson.dropbear.id.au>,  Nicholas Piggin <npiggin@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,  qemu-ppc@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Cleber Rosa <crosa@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  qemu-s390x@nongnu.org,  Thomas Huth
 <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Akihiko Odaki
 <akihiko.odaki@daynix.com>,  Daniel Henrique Barboza
 <danielhb413@gmail.com>,  David Hildenbrand <david@redhat.com>,  Ilya
 Leoshkevich <iii@linux.ibm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 06/11] gdbstub: pass GString to gdb_build_stop_packet
In-Reply-To: <20260203115201.2387721-7-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?= message of "Tue, 3 Feb 2026 11:51:56 +0000")
References: <20260203115201.2387721-1-alex.bennee@linaro.org>
 <20260203115201.2387721-7-alex.bennee@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Tue, 03 Feb 2026 15:44:24 +0000
Message-ID: <87ikcdomqv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x644.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> The other functions we are going to clean-up work variously with there

their...

> own dynamically allocated GStrings or with the common shared buffer.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  gdbstub/internals.h | 5 ++++-
>  gdbstub/gdbstub.c   | 4 ++--
>  gdbstub/system.c    | 4 ++--
>  gdbstub/user.c      | 8 ++++----
>  4 files changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/gdbstub/internals.h b/gdbstub/internals.h
> index 3134a6e8eb2..9b25bf58b8e 100644
> --- a/gdbstub/internals.h
> +++ b/gdbstub/internals.h
> @@ -239,9 +239,12 @@ int gdb_target_memory_rw_debug(CPUState *cs, hwaddr =
addr,
>=20=20
>  /**
>   * gdb_build_stop_packet() - craft the stop packet
> + * @buf: GString buffer for building the packet
>   * @cs: CPUState
> + *
> + * Craft the Stop/Reply packet when we halt.
>   */
>=20=20
> -void gdb_build_stop_packet(CPUState *cs);
> +void gdb_build_stop_packet(GString *buf, CPUState *cs);
>=20=20
>  #endif /* GDBSTUB_INTERNALS_H */
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index c82fb5ad324..b45eb7c7b2b 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -1432,7 +1432,7 @@ static void handle_v_attach(GArray *params, void *u=
ser_ctx)
>          gdbserver_state.c_cpu =3D cpu;
>=20=20
>          if (gdbserver_state.allow_stop_reply) {
> -            gdb_build_stop_packet(cpu);
> +            gdb_build_stop_packet(gdbserver_state.str_buf, cpu);
>              gdbserver_state.allow_stop_reply =3D false;
>          }
>      }
> @@ -2036,7 +2036,7 @@ static void handle_gen_set(GArray *params, void *us=
er_ctx)
>  static void handle_target_halt(GArray *params, void *user_ctx)
>  {
>      if (gdbserver_state.allow_stop_reply) {
> -        gdb_build_stop_packet(gdbserver_state.c_cpu);
> +        gdb_build_stop_packet(gdbserver_state.str_buf, gdbserver_state.c=
_cpu);
>          gdbserver_state.allow_stop_reply =3D false;
>          gdb_put_strbuf();
>      }
> diff --git a/gdbstub/system.c b/gdbstub/system.c
> index 6963c930b01..8ec8b7ea336 100644
> --- a/gdbstub/system.c
> +++ b/gdbstub/system.c
> @@ -668,8 +668,8 @@ void gdb_breakpoint_remove_all(CPUState *cs)
>   *   T05core:{id};
>   */
>=20=20
> -void gdb_build_stop_packet(CPUState *cs)
> +void gdb_build_stop_packet(GString *buf, CPUState *cs)
>  {
> -    g_string_printf(gdbserver_state.str_buf,
> +    g_string_printf(buf,
>                      "T%02xcore:%02x;", GDB_SIGNAL_TRAP, gdb_get_cpu_inde=
x(cs));
>  }
> diff --git a/gdbstub/user.c b/gdbstub/user.c
> index c7a3ef947ed..a16f37616b1 100644
> --- a/gdbstub/user.c
> +++ b/gdbstub/user.c
> @@ -976,9 +976,9 @@ void gdb_handle_query_xfer_siginfo(GArray *params, vo=
id *user_ctx)
>   *   T05thread:{id};
>   */
>=20=20
> -void gdb_build_stop_packet(CPUState *cs)
> +void gdb_build_stop_packet(GString *buf, CPUState *cs)
>  {
> -    g_string_printf(gdbserver_state.str_buf, "T%02xthread:", GDB_SIGNAL_=
TRAP);
> -    gdb_append_thread_id(cs, gdbserver_state.str_buf);
> -    g_string_append_c(gdbserver_state.str_buf, ';');
> +    g_string_printf(buf, "T%02xthread:", GDB_SIGNAL_TRAP);
> +    gdb_append_thread_id(cs, buf);
> +    g_string_append_c(buf, ';');
>  }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

