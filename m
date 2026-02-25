Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA68F55454
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 04:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv6oS-0001LS-HD; Tue, 24 Feb 2026 23:47:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vv6oC-0001Hl-BW
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:47:39 -0500
Received: from mail-dy1-x1344.google.com ([2607:f8b0:4864:20::1344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vv6o8-00009a-5e
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:47:35 -0500
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-2bd3b0bc201so2666587eec.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 20:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771994851; x=1772599651; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pySM/gfohD0PV8JKBi+p8hFMeVi3cWWIqbke9FOS9xU=;
 b=EqYAfLescPcEn9HL5b/LSYzIF3/ULYooBTN4Jal2cHbFpUUTgq1KKBP/kGj/fjUxTh
 m5HIq78Q/DxTC9wg5/+tezNlVH9LEXI2cY+WRQ7hnHLDEq7mwLFhwEiamM0JslkeO+gU
 Qc2ifsvG5jWp0mZSp+1sMzIBhXgWV8u4QYlt6TdRHfC9b3VV9YO70o3YM9ePYIAg93i/
 PM3mBDKenRBvMu35Or0yN0YCrNhV2feV75NOPkJfiajuGoGvMxJe9/9wuD1+55AHM0iz
 yIRuP8B0n21MhxXvKiFkXg2GUYluaaLfL2eQJvlpQDRlGfpRC4llr4+CvybjHHXHplRg
 LgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771994851; x=1772599651;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pySM/gfohD0PV8JKBi+p8hFMeVi3cWWIqbke9FOS9xU=;
 b=npmrp354ZdzZOFdu2pjjOaxiRKa1sKoNDwn9XUJgZ8dqpuDr6hq+TNktzFlaLC89qO
 T0tupFh9bOGjd0vCrqsvcCgTY3PtwFErLLvtNvYzpM85hyTreV8vM+t22REZz8ZstEXG
 jf/Gw8RAs52n4ZpdFIGhNuvoMyjiv6qJFExDp8pJCW3XQBbgn1czXGrdsFZiOl4thsgk
 RYeakgOY40dJ22pClS/xxits6Ic5UIhq2wNp3xAtpj4BZyNctIZv+cF//kJ1O85GWASD
 rfBDFe219QVQJa5wVcVWXL/MrQOpgxAkjabsu2QbiBPnHl1yG9/KVxOAib5xUTFmlI5F
 vhHQ==
X-Gm-Message-State: AOJu0Yw/uAqKFeFUQ836KY9FGk8m4gheIenca4ajWJ82wQyUSW/9zb5Q
 PGlniL2bAZ9YASQwqhtrIACv2PFgaETcWws9aHLO8AA5zJcgH3EioRjr
X-Gm-Gg: ATEYQzxtWgkM1WJwtoaFfMJJgg8d/66ERYDJ3fFYBUlTSzrCALaq1A5GIGAmyAxGWph
 mjJpkE9sU+SlgvpjJQIRvlFjT5aA262nVZspbrPcZwQ00o76A/v4CpJSnjWFY81LyMdaGELBvE/
 ggBlPXYV+hzYDfay6bRIJA+b0o7J11bc7HsKt8zw/YE3m2OZ4ITVbbaSJU8qEXG+oZ4GQok2Cje
 Bv7torieE40nG4jxjhGy1a5SU2oHRojjT+0Dk7uOm2cPoCckrfKfg6my1l0ibfk88BPjv79424Y
 BhDPtltF6zO+yefzKnf/ldhxmvh4unRA/FWSPyhpCxrIT5P5bf9nDObrHXp+waVff13Qjp0udpM
 sKE6Z3QbXQDpPTZnYyqP8q7R3SbKuHobpVv/TGw85W94WNNVed04ZYXTbdCFW/Y8q7FQrNcZQWf
 HBmSB5PsmHSH7mCqZ2tDBiS8OfmYLezVI5m9OWV1RLdToNItZhzr7vgI0liC9fAU5XjMmtc/2Jf
 0BcDOqgAL+q+jpgwOzJvL5fUFkU7IloY44hJmgdVw==
X-Received: by 2002:a05:7301:4090:b0:2b7:1320:f280 with SMTP id
 5a478bee46e88-2bd7bafaeafmr6299691eec.15.1771994850575; 
 Tue, 24 Feb 2026 20:47:30 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bd7da4551csm8064837eec.3.2026.02.24.20.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 20:47:30 -0800 (PST)
Date: Wed, 25 Feb 2026 12:46:33 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2 23/50] target/riscv: Remove empty
 target_monitor_defs() symbol
Message-ID: <aZ5-mz3uUXfAM3rX@ZEVORN-PC.localdomain>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-24-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260219191955.83815-24-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1344;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Feb 19, 2026 at 08:19:25PM +0100, Philippe Mathieu-Daudé wrote:
> Prefer the stub target_monitor_defs() symbol introduced in commit
> bf957284006 ("monitor: remove target-specific code from monitor.c").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/riscv/monitor.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
> index ccb7eb44d02..a9d31114442 100644
> --- a/target/riscv/monitor.c
> +++ b/target/riscv/monitor.c
> @@ -244,19 +244,6 @@ void hmp_info_mem(Monitor *mon, const QDict *qdict)
>      mem_info_svxx(mon, env);
>  }
>  
> -/*
> - * We have way too many potential CSRs and regs being added
> - * regularly to register them in a static array.
> - *
> - * Declare an empty array instead, making get_monitor_def() use
> - * the target_get_monitor_def() API directly.
> - */
> -const MonitorDef monitor_defs[] = { { } };
> -const MonitorDef *target_monitor_defs(void)
> -{
> -    return monitor_defs;
> -}
> -
>  static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
>                                   target_ulong *val, bool is_gprh)
>  {
> -- 
> 2.52.0
> 
> 

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao

