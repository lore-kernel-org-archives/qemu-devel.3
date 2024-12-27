Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B54EE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 23:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRJyk-00012a-JB; Fri, 27 Dec 2024 18:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tRJyi-00011N-BS
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 18:42:48 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tRJyg-0001FD-Gs
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 18:42:48 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aab9e281bc0so1327407666b.3
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2024 15:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735342961; x=1735947761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CeHqPtKRdkusRhZWBT4Z4qnn/ZmNQ8VL2ZQ7cJD4NgY=;
 b=tfU+SGTP/mim+3Rv3NS+5gosYO8Zlrgdqe13P57Jo8BdDj5PJuNiSoa27W4LVcO5/H
 IAPeH56a0dNMiQHb62TeDs6PvSdrlr0HpMAPy5F2+Wf8EIVG2MZYdwL+2SLJaIvqpIBp
 QCkk50BbKLymSX2u9aGiWLzLIrh1CP0i+w6Wk+MSQ9sNWbb3I31U73rJwCzOOxp9GsNb
 jN5DpZ/iD5n+dcRfh4OBvRCwJBYq+s/efwbknz+oaaMtsMBE8biebZJDBZAn86rT8u9D
 zJaCs50a0KQCp5SynsPaOM8yQmStiVGwVyUYs0/ck+4klCQbWQrcyafBh4jiCq+Fa/8C
 kMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735342961; x=1735947761;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CeHqPtKRdkusRhZWBT4Z4qnn/ZmNQ8VL2ZQ7cJD4NgY=;
 b=hpZvPWogEYYzygPCqDn4wM1jUqGhYfR+o8SVbliSTuVLuAawSd9I1EktfRK/ICQ8Up
 vWip5ytlcD7ClUXvPPCTFvXNdAxg18d5e/fJyBejOchOdr8S+rLT4dCFlJewaIhiCY2F
 cKapj28NGd2/uUC26qmempb0mkMtPrsPQzt2D2CqhjDnpVk7e2xU8je1lN7sBv6UBr+6
 C3EzcT810xH4YZDlIelmBIMDU88GZqN5wY+iWt3mC8/lSU2bPsf+mkoi3IgqoGYSXayO
 p0B0HnpjDU7FYMFNHAGCQ/hS7HKiCNOIe2VIfsACCM0SACT0d4tSZcYUfYMDGQxe7ahM
 0nFQ==
X-Gm-Message-State: AOJu0Yy8Bv+iA60R7gOG8iI5p7kmgPdFrZqOTrkiOPUjRZS8T6M0I+Fj
 hau3QM0oQIj+7CMwcPCvjNyvnS4WLVHVM9Z9b2t5PAwzgpUQTxdigHAngTXenAM=
X-Gm-Gg: ASbGncsqyClA+X5hj1BmRMPoFna+9S8t2B9BQCJawDJ7boBBkIoytqSzta+gDKkH0wp
 XL0l28qhZnSeaTiKVvOvUvi+vkDO+dPfJar+OcgbSf585OYQZnhWNIpvvQ3nTZBCDuDoqcVaEbG
 n04K09PAXw1hEjxBPuA+s4mdHsCQA63p8VmBVl2RGThkWKv5AxlsmIXrkHIW6gT2rIVVqRxCFQz
 dvKbE0RwyZ9MG78aleBAF58jusG8SqT+/0pha3pxueye1RPHuLx4ko=
X-Google-Smtp-Source: AGHT+IGgcu4a3OEtLs3246M8b8Ex9GUNsttt3Csoku/cBw9X9YBjN56hLXHZEINk8ibUgbFC2JsrnA==
X-Received: by 2002:a17:907:7d9e:b0:aab:7588:f411 with SMTP id
 a640c23a62f3a-aac2b94645amr2632043866b.25.1735342961317; 
 Fri, 27 Dec 2024 15:42:41 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0efe497dsm1173484466b.132.2024.12.27.15.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Dec 2024 15:42:40 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B005F5F792;
 Fri, 27 Dec 2024 23:42:39 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  qemu-trivial@nongnu.org
Subject: Re: [PATCH] gdbstub/user-target: fix gdbserver int format (%d -> %x)
In-Reply-To: <20241227170413.72438-1-dominik.b.czarnota@gmail.com> (Dominik
 Czarnota's message of "Fri, 27 Dec 2024 18:04:13 +0100")
References: <20241227170413.72438-1-dominik.b.czarnota@gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 27 Dec 2024 23:42:39 +0000
Message-ID: <87bjwwlmkw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com> writes:

> From: disconnect3d <dominik.b.czarnota@gmail.com>

You might want to fix your author attribution here.

>
> This commit fixes an incorrect format string for formatting integers
> provided to GDB when debugging a target run in QEMU user mode.
>
> The correct format is hexadecimal for both success and errno values,
> some of which can be seen here [0].
>
> [0]
> https://github.com/bminor/binutils-gdb/blob/e65a355022d0dc6b5707310876a72=
b5693ec0aa5/gdbserver/hostio.cc#L196-L213

The spec isn't totally clear on this but it seems the match
remote_hostio_parse_result() as well:

  /* Check for ",errno".  */
  if (*p =3D=3D ',')
    {
      errno =3D 0;
      *remote_errno =3D (fileio_error) strtol (p + 1, &p2, 16);
      if (errno !=3D 0 || p + 1 =3D=3D p2)
	return -1;
      p =3D p2;
    }

So: Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


You are also missing a s-o-b: https://qemu.readthedocs.io/en/master/devel/s=
ubmitting-a-patch.html#id29


> ---
>  gdbstub/user-target.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
> index 22bf4008c0..4bfcf78aaa 100644
> --- a/gdbstub/user-target.c
> +++ b/gdbstub/user-target.c
> @@ -317,9 +317,9 @@ void gdb_handle_v_file_open(GArray *params, void *use=
r_ctx)
>      int fd =3D open(filename, flags, mode);
>  #endif
>      if (fd < 0) {
> -        g_string_printf(gdbserver_state.str_buf, "F-1,%d", errno);
> +        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
>      } else {
> -        g_string_printf(gdbserver_state.str_buf, "F%d", fd);
> +        g_string_printf(gdbserver_state.str_buf, "F%x", fd);
>      }
>      gdb_put_strbuf();
>  }
> @@ -329,7 +329,7 @@ void gdb_handle_v_file_close(GArray *params, void *us=
er_ctx)
>      int fd =3D gdb_get_cmd_param(params, 0)->val_ul;
>=20=20
>      if (close(fd) =3D=3D -1) {
> -        g_string_printf(gdbserver_state.str_buf, "F-1,%d", errno);
> +        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
>          gdb_put_strbuf();
>          return;
>      }
> @@ -352,7 +352,7 @@ void gdb_handle_v_file_pread(GArray *params, void *us=
er_ctx)
>=20=20
>      ssize_t n =3D pread(fd, buf, bufsiz, offset);
>      if (n < 0) {
> -        g_string_printf(gdbserver_state.str_buf, "F-1,%d", errno);
> +        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
>          gdb_put_strbuf();
>          return;
>      }
> @@ -375,7 +375,7 @@ void gdb_handle_v_file_readlink(GArray *params, void =
*user_ctx)
>      ssize_t n =3D readlink(filename, buf, BUFSIZ);
>  #endif
>      if (n < 0) {
> -        g_string_printf(gdbserver_state.str_buf, "F-1,%d", errno);
> +        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
>          gdb_put_strbuf();
>          return;
>      }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

