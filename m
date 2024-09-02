Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A913CA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 10:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl4WN-0002ww-IE; Mon, 02 Sep 2024 06:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sl4WL-0002wI-6m
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 06:42:53 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sl4WJ-00026s-DF
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 06:42:52 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a8696e9bd24so470850766b.0
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 03:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725273766; x=1725878566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FC6cnz1odTNarmYDEQZ/0oawF/naRkcUtHkDn0zSLec=;
 b=uohsM6twxzG213qyMrnSf1L5IfxPQFAMUGMQozN0cjv+tebbnRhP1RJKF5mcF/GqaV
 ZoZy9qQOmGFEYul57EMuD72/NNDaSwucHHSk0SsNbE5NFYiDp0vplKMwWj8WJatePRF9
 QFRZjYJEhFlmsuoR7PfHn5tcnLpS/Rf0f3kUUNeCXXJHl+cVGzHaQQUDe8TCX+lZn8RQ
 kA7+kE+Y1e9Wd7XCgyZzC0Ujn8U7hLyzJri2nmSlIwPi4Yo8+wAspGMPLpVEC5G2erJR
 FDif02nsREeOL17WWzrgIA8xu9s00Sli5nu3mUpTVyF5VPAI+GrYr5u2xyPGEOofArde
 u0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725273766; x=1725878566;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FC6cnz1odTNarmYDEQZ/0oawF/naRkcUtHkDn0zSLec=;
 b=jGixThgQ+Yr8Exe9lxTLjncLjeo9kqnElgLHMylvmIPIz7UPY3wn+FrK4/IawuM4+A
 OtiOcC2QFptZPg64+1tlrkOn9/mldM9LJJ5l6MVUQBKjL3LE+f3GjAQ6/ONbOU8AZnz6
 bS4J9HQUUieFjsTtQsDlEqBMuEtGgEg5F34VWoAPseGhu84lJ/JC7BSje/mxIBhykx2Q
 r4akmQHwFP3L95LjNcrXZp9GZ4Rkr5IqwYWpjUMdgngDf94SaSzhZkBP5kUlJMSN677p
 rKgExnZ2LjlTflxovFJ+jayxj3IK4Uc/bPN30qNTpZ/gKEx6XXSgjsSLEGoPwKNsZss9
 liZw==
X-Gm-Message-State: AOJu0YzC7Rh/Sh3BKw7/avhLyButofiXtsDTITs05ayKs199iR6cOImH
 9rUGSJU6l4zMPtZAPbE6HKUL/juLeYmtKyWaB876uYVuRW+tOMNy0tTAJZRbJnU=
X-Google-Smtp-Source: AGHT+IGptrtKPSiFhLYA3e2Q+uaOrfQw04rZUO4QWyWMZRhKRBmp3n69M49zaq5aQPBPdTqmHHvwFQ==
X-Received: by 2002:a17:906:fe4c:b0:a80:d913:be07 with SMTP id
 a640c23a62f3a-a897f930bb1mr1126982766b.36.1725273765620; 
 Mon, 02 Sep 2024 03:42:45 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8988bdcf57sm542596266b.0.2024.09.02.03.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 03:42:45 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 205E85F835;
 Mon,  2 Sep 2024 11:42:44 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Xingran Wang <wangxingran123456@outlook.com>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH] plugins: add two events for cpu_restore_state_from_tb()
 and cpu_io_recompile()
In-Reply-To: <SY8P282MB4322879DBA2E5E3E3B72B383A1912@SY8P282MB4322.AUSP282.PROD.OUTLOOK.COM>
 (Xingran Wang's message of "Mon, 2 Sep 2024 00:34:06 +0800")
References: <SY8P282MB4322879DBA2E5E3E3B72B383A1912@SY8P282MB4322.AUSP282.PROD.OUTLOOK.COM>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 02 Sep 2024 11:42:44 +0100
Message-ID: <87mskqcp5n.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

Xingran Wang <wangxingran123456@outlook.com> writes:

> Currently, the instruction count obtained by plugins using the translation
> block execution callback is larger than the actual value. Adding callbacks
> in cpu_restore_state_from_tb() and cpu_io_recompile() allows plugins to
> correct the instruction count when exiting a translation block
> mid-execution, properly subtracting the excess unexecuted
> instructions.

This smells like exposing two much of the TCG internals to the plugin
mechanism. You can already detect when we don't reach the end of a block
of instructions by instrumentation as I did in:

  Message-Id: <20240718145958.1315270-1-alex.bennee@linaro.org>
  Date: Thu, 18 Jul 2024 15:59:58 +0100
  Subject: [RFC PATCH v3] contrib/plugins: control flow plugin
  From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.org>

So what exactly are we trying to achieve here? A more efficient
detection of short blocks?

>
> Signed-off-by: Xingran Wang <wangxingran123456@outlook.com>
> ---
>  accel/tcg/translate-all.c    |  27 ++++++++
>  include/qemu/plugin-event.h  |   2 +
>  include/qemu/plugin.h        |  24 +++++++
>  include/qemu/qemu-plugin.h   | 131 +++++++++++++++++++++++++++++++++++
>  plugins/api.c                |  78 +++++++++++++++++++++
>  plugins/core.c               |  42 +++++++++++
>  plugins/qemu-plugins.symbols |  10 +++
>  tests/tcg/plugins/bb.c       |  25 +++++++
>  8 files changed, 339 insertions(+)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index fdf6d8ac19..642f684372 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -65,6 +65,7 @@
>  #include "internal-target.h"
>  #include "tcg/perf.h"
>  #include "tcg/insn-start-words.h"
> +#include "qemu/plugin.h"
>=20=20
>  TBContext tb_ctx;
>=20=20
> @@ -218,6 +219,19 @@ void cpu_restore_state_from_tb(CPUState *cpu, Transl=
ationBlock *tb,
>          cpu->neg.icount_decr.u16.low +=3D insns_left;
>      }
>=20=20
> +#ifdef CONFIG_PLUGIN
> +    /*
> +     * Notify the plugin with the relevant information
> +     * when restoring the execution state of a TB.
> +     */
> +    struct qemu_plugin_tb_restore ptb_restore;
> +    ptb_restore.cpu_index =3D cpu->cpu_index;
> +    ptb_restore.insns_left =3D insns_left;
> +    ptb_restore.tb_n =3D tb->icount;
> +    ptb_restore.tb_pc =3D tb->pc;
> +    qemu_plugin_tb_restore_cb(cpu, &ptb_restore);
> +#endif
> +

See also the unwind patches which is a more generic approach to ensuring
"special" registers are synced at midpoint when using the register API:

  Message-Id: <20240606032926.83599-1-richard.henderson@linaro.org>
  Date: Wed,  5 Jun 2024 20:29:17 -0700
  Subject: [PATCH v2 0/9] plugins: Use unwind info for special gdb registers
  From: Richard Henderson <richard.henderson@linaro.org>

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

