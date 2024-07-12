Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB28C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 14:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSH7E-000053-15; Fri, 12 Jul 2024 10:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sSH7C-0008Qk-Eo
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:19:14 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sSH78-0003up-OE
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:19:14 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-58ba3e38027so2307739a12.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 07:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720793948; x=1721398748; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t37aUeW9ye6rJBOVxrPwek6tZu/fTtWILNdTicrDpNI=;
 b=r3tC4h6MZOsS4EL4ZwRu1mdzpWj37t+CVgzLeUsJx8YlBM3iaLMhOEwywhqWyzIL9D
 tI5/htdeR9JicJ/dkLismdMeqBIjIerZRH7KM59i11XRqAe+n1qsk7AV00nF7inTloid
 a8QmaqE1Yeh1tJSpi9Gj9uzgyOP9JS6j2vOi7wQtSVOopMwje2keP2sJot0EbPuNAb33
 bk8Cm/4Vo+p8MipwdjAgLVNsDJA5F/BOEM3yAIASeDN84U3i2JZ2bGCMNT71rCJMWNI0
 mSFTyUfwhCBiZGxd0EWbMDNW7WQwjqc9MtdrG0x5EK0NsHsu07TsdrdRbOAlIQyRwttQ
 v7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720793948; x=1721398748;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t37aUeW9ye6rJBOVxrPwek6tZu/fTtWILNdTicrDpNI=;
 b=P/4sxSHZxC8TVuqQguyOdULXEKYbWDVwFRYcGCd2607eZDNFDmo9G6t+Tafu6T0bxJ
 6JMjUGmKW6z0pBqMlANKeq9Nn4gwixh57RfCRs9Hin5Q2LO7Xewrz9I1xqLPs2eyWeaS
 ieFLkXPC/lBOVkEKo0fCrnMUxWy7wEa2CTzheQAGDXdKVmxSHHALUNngH8Kcqg1X8iZl
 ITds6n4qO5VrCWO8yg4QeV/YB8pEfeP93e0NU25uqydKDG6AwtwHR2I5ca5AGg46GlqB
 bgTSJvtk5Z6zeqaygjzp5pbXjfjT9YhIuUcvLbsYrirG41ewoepVQEducXsYe5TCnGaG
 j2Kw==
X-Gm-Message-State: AOJu0Ywz5Jr9Qk0S5P0aj1RBTYg8dZN2BfUfq2XnfDXlKYfzr9aNXKyT
 c4rwpD5Tts5hE7nFi4xK4PHI0jjZocUwkDQNI90zZVz/7lxC+UcLN7/rNAQrRJf0kAlH5OACbik
 TiYHEM50t/TcCVAmi/aUh5iJ6zPwofLvsjnwqpw==
X-Google-Smtp-Source: AGHT+IH69WrN2p+J8+7S0k91o0wclcuFL3lq9JqExLi/w2oAItOrMlgwmjFuZJ+3bD5qS02Qh0V5Vv21RRBEKMyVQmg=
X-Received: by 2002:aa7:c548:0:b0:57a:33a5:9b71 with SMTP id
 4fb4d7f45d1cf-594bc7c9d69mr7336462a12.33.1720793948468; Fri, 12 Jul 2024
 07:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
 <20240705153052.1219696-40-alex.bennee@linaro.org>
In-Reply-To: <20240705153052.1219696-40-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jul 2024 15:18:57 +0100
Message-ID: <CAFEAcA8YJwWtQxdOe2wmH7i0jvjU=UV92oeB6vUzT1GrQhRsTQ@mail.gmail.com>
Subject: Re: [PULL 39/40] gdbstub: Add support for MTE in user mode
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Fri, 5 Jul 2024 at 16:37, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> From: Gustavo Romero <gustavo.romero@linaro.org>
>
> This commit implements the stubs to handle the qIsAddressTagged,
> qMemTag, and QMemTag GDB packets, allowing all GDB 'memory-tag'
> subcommands to work with QEMU gdbstub on aarch64 user mode. It also
> implements the get/set functions for the special GDB MTE register
> 'tag_ctl', used to control the MTE fault type at runtime.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Message-Id: <20240628050850.536447-11-gustavo.romero@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20240705084047.857176-40-alex.bennee@linaro.org>

Hi; Coverity thinks there's a memory leak in this function
(CID 1549757):

> +void arm_cpu_register_gdb_commands(ARMCPU *cpu)
> +{
> +    GArray *query_table =3D
> +        g_array_new(FALSE, FALSE, sizeof(GdbCmdParseEntry));
> +    GArray *set_table =3D
> +        g_array_new(FALSE, FALSE, sizeof(GdbCmdParseEntry));
> +    GString *qsupported_features =3D g_string_new(NULL);

We allocate memory for the qsupported_features GString here, but
it looks like nowhere in the function either passes it to
some other function that takes ownership of it, and we don't
free it either.

> +    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
> +    #ifdef TARGET_AARCH64
> +        aarch64_cpu_register_gdb_commands(cpu, qsupported_features, quer=
y_table,
> +                                          set_table);
> +    #endif

(PS: this ifdef/endif ought to be on the left margin, not indented.)

> +    }
> +
> +    /* Set arch-specific handlers for 'q' commands. */
> +    if (query_table->len) {
> +        gdb_extend_query_table(&g_array_index(query_table,
> +                                              GdbCmdParseEntry, 0),
> +                                              query_table->len);
> +    }
> +
> +    /* Set arch-specific handlers for 'Q' commands. */
> +    if (set_table->len) {
> +        gdb_extend_set_table(&g_array_index(set_table,
> +                             GdbCmdParseEntry, 0),
> +                             set_table->len);
> +    }
> +
> +    /* Set arch-specific qSupported feature. */
> +    if (qsupported_features->len) {
> +        gdb_extend_qsupported_features(qsupported_features->str);
> +    }
> +}

Something odd also seems to be happening with the query_table
and set_table -- we allocate them in this function, and we
rely on the memory not going away because we pass pointers
into the actual array data into gdb_extend_query_table()
and gdb_extend_set_table() which those functions retain copies
of, but we don't keep hold of the pointer to the struct GArray
itself.

The functions gdb_extend_set_table() and gdb_extend_query_table()
both seem to not quite do what their documentation says they
do. The docs say they extend the set table and the query table,
but the implementation appears to be setting an extended set
table/query table (e.g. you can't extend the table twice).

Perhaps a more natural API would be for these functions to
either:
 * be passed in the entire GArray, and take ownership of
   it and be responsible for disposing of it
 * take a copy of the entries they're passed in, so that
   the calling function can free the GArray and its
   contents after the call
?

thanks
-- PMM

