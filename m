Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159E0C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 14:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKIvv-0001se-Nb; Thu, 20 Jun 2024 10:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKIvu-0001sT-8B
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 10:38:38 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKIvs-0000Nl-Du
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 10:38:37 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a6ef64b092cso110713266b.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 07:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718894315; x=1719499115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iElAmEo3T5RsQWLfF18q2hOUhZq4EQiy1QYQ63VIg40=;
 b=dhA1zCgMTNODEmvwr1UpqXS9HSiPKCO1ALvnvbAnfvkbiTFJZGBkfZtattpv+OYgS2
 sgdf8KkWuWWXGYkxK28vn+oyiAHJYhYvk1MrWevNjZS3gbOzU0zc3c5i6qXcMz/TV1u7
 mJN66aFN3bFmdh7shzEi9DsXmmNZXjwVh+O7po1l2j70RvEyPke5Y/MrBbGCObGnYHDY
 4qKfP/NkR0iQwWdBaMnxSw8mD5rdgxzmhL+vFWxsSnz8xVuV5ZhOUTE59yx5RmhlNqNY
 EbXkkTvYGjUfQDiY1ZcnsQTAKRqSlrMeOTta50kyY4HSydyVsXUKLf+j4yI48ejc34ow
 wSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718894315; x=1719499115;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iElAmEo3T5RsQWLfF18q2hOUhZq4EQiy1QYQ63VIg40=;
 b=DghXLovIHwM8qyXNdM9vHzsKacv3yIWSgfEPA9W+LpONx4c7faOfaiA7h7po9NET8M
 ifFbNsokmuTQqyrvMJJVEhYU83mFU/yjI2lnyW1xRRf+0IJ8rapjsFI08aushM/d9GTj
 A7zeNksvmqNrLkwBDF9ILb76pF2odLIDBN5FoVauNN68DgycvvacNHNNgJB70zQ0M9Cs
 IWew2L/ou8AmLAkzrKkExp7lQR87P2N8RHoBerXEVxHCiQzTputWNY/oxyzaKydfVdGO
 tJ92CIo+g5DJOeuOy2DmDaihgySs4vkPtKejFgw9bg9QxPbs/f4VTkHJxbQwPlhx0Lq3
 BI4A==
X-Gm-Message-State: AOJu0Yww4CoKRKgN5h7xYoyWuRdOoKXh8L1FCBcixn0y/emYQ+ghx6w1
 r7Y/lAjgOFd4bueLyyoIwfzm71PmRdxjQaMhO2e/oF4hsSu4EU9p4aSrKwUvmgBoGI/g5oOgzW+
 T
X-Google-Smtp-Source: AGHT+IGk/t/pnZa59+vPS2lx4ibbRUkppPokdqq+lhuZfCy+czZWdazFMlAUAClDfPBMvwg6ShnFpw==
X-Received: by 2002:a17:906:329b:b0:a6e:2a27:5669 with SMTP id
 a640c23a62f3a-a6fab62bc77mr366635966b.23.1718894314317; 
 Thu, 20 Jun 2024 07:38:34 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56f42badsm772593466b.184.2024.06.20.07.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 07:38:30 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 21DF65F7B1;
 Thu, 20 Jun 2024 15:38:30 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Fabio D'Urso" <fdurso@google.com>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] linux-user: open_self_stat: Implement num_threads
In-Reply-To: <20240619194109.248066-1-fdurso@google.com> (Fabio D'Urso's
 message of "Wed, 19 Jun 2024 21:41:09 +0200")
References: <20240619194109.248066-1-fdurso@google.com>
Date: Thu, 20 Jun 2024 15:38:30 +0100
Message-ID: <87plsbbrx5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

"Fabio D'Urso" <fdurso@google.com> writes:

> The num_threads field reports the total number of threads in the
> process. In QEMU, this is equal to the number of CPU instances.
>
> Signed-off-by: Fabio D'Urso <fdurso@google.com>
> ---
>  linux-user/syscall.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index b9b5a387b3..a47b2eeb65 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8171,6 +8171,16 @@ static int open_self_stat(CPUArchState *cpu_env, i=
nt fd)
>          } else if (i =3D=3D 3) {
>              /* ppid */
>              g_string_printf(buf, FMT_pid " ", getppid());
> +        } else if (i =3D=3D 19) {
> +            /* num_threads */
> +            int cpus =3D 0;
> +            WITH_RCU_READ_LOCK_GUARD() {
> +                CPUState *cpu_iter;
> +                CPU_FOREACH(cpu_iter) {
> +                    cpus++;
> +                }
> +            }
> +            g_string_printf(buf, "%d ", cpus);

Looks ok to me.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

