Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED29DC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rma4y-0003WC-4E; Tue, 19 Mar 2024 10:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rma4s-0003QB-Du
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:04:30 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rma4d-0007sW-Sm
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:04:29 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a46aaf6081fso399440166b.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710857052; x=1711461852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vrZ7HwaNTkrShRf5kjtf7bdXIPHLyXYiECWytiHWVGY=;
 b=MtaMunoWQ4jmXvmlgvK6ZLMH7QL/KjvQWGjY7kQHWxbRsTsIgHHAR/RGM++ZBRSVZF
 SZAlH5jdWrS/Vl/NHIs4xn44132U6Ct8g/PLXddQCT4a2jQCR5JWe/EcuOiBk7YgJTpQ
 kkzgimNKlmFE7nJeJfuyaeqscG9rOrzGI6mIwo7beLQBGopZ5YRGe+5iSbvYj1/IidxS
 NyuqYp8+4qxszZJE+DDdvRZvq95iDmQ7sLM4quiQJKsH9DcVdoA7juNAYAYIsuu0UKIB
 Or/2jVWd6tRSYFQepgwMyanq0bcxn0s2PGp9J/9N1AkxJe7IvcpgEqNtZChTUntQo7i4
 7snA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710857053; x=1711461853;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vrZ7HwaNTkrShRf5kjtf7bdXIPHLyXYiECWytiHWVGY=;
 b=pNE/3jXb5PwhFLLWUcnTxzmoDFZtoKbQCp5ijnN9UZoiLjTDpdENY6BOVNiwLDqu91
 4GC3W7z5mNitS7qtFDsZnKDfOUIvO10G8ZCLQNGB7AKts2Ny7mvzAXZfm+NOqpipTLy9
 ieEV6pFYxJNTJ80B4M97u9V87x+36qbXF9cWQMlsfJ/p0mKIyi3zJMd/aGGJH+Jd9ALW
 vIiDZN3YOSRc6QboZPiczXfnt0fHx/WyhRbc7yMD5CGl1Y/L5Fozh+XfBG3gd02hfQB/
 3COrpHI0+rmoCb02jCjjoL3hhycMIpzbc0JmO9A+YiKEPj0w/Mr/RcbqgvK34KcsaG3b
 V+dg==
X-Gm-Message-State: AOJu0YzpgJxkF7O5UdjT6S4S+XvC2HVO/G6iwMNRVac9yWQhWX23Tg4V
 JZ9vKXjJ0zvWPH+rHXeuQo40ToUwcJCUKEfiCxJMway2oXfwORUJKmhag3mQ30U=
X-Google-Smtp-Source: AGHT+IEoBFAfB0fMaxMbILq+KTngP3OKjjxio6Xt3sZeRku1sNLua+/QvjXkLWMZSwTuealyhlcbOw==
X-Received: by 2002:a17:906:6958:b0:a46:7794:2c00 with SMTP id
 c24-20020a170906695800b00a4677942c00mr1812374ejs.40.1710857052615; 
 Tue, 19 Mar 2024 07:04:12 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l3-20020a1709061c4300b00a46a3ad035esm4166467ejg.179.2024.03.19.07.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 07:04:12 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 890625F8A2;
 Tue, 19 Mar 2024 14:04:11 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH 01/22] tcg: Add TCGContext.emit_before_op
In-Reply-To: <20240316015720.3661236-2-richard.henderson@linaro.org> (Richard
 Henderson's message of "Fri, 15 Mar 2024 15:56:59 -1000")
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-2-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.2; emacs 29.2
Date: Tue, 19 Mar 2024 14:04:11 +0000
Message-ID: <871q865ndw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Allow operations to be emitted via normal expanders
> into the middle of the opcode stream.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg.h |  1 +
>  tcg/tcg.c         | 14 ++++++++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index 451f3fec41..e9d05f40b0 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -552,6 +552,7 @@ struct TCGContext {
>=20=20
>      QTAILQ_HEAD(, TCGOp) ops, free_ops;
>      QSIMPLEQ_HEAD(, TCGLabel) labels;
> +    TCGOp *emit_before_op;

Could we add some kdoc comments to the TCGContext describing what each
variables is for. Is this just a list of ops to emit before the current
instruction emulation? Is it cleared between instruction boundaries?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

