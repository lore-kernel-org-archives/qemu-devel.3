Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B192CFF60E7
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 08:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7UKC-0001St-Ok; Tue, 31 Mar 2026 04:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7UK4-0001SP-SO
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 04:19:43 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7UK2-0003TU-RH
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 04:19:40 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6500eae6d2fso5086813d50.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 01:19:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774945176; cv=none;
 d=google.com; s=arc-20240605;
 b=Zm3fJDXvgtX3VgqJ2Tuw0IHeQFLPMlIMVLus8nL07br3SdBZNKD0eNhORTHIsvH4Zo
 kr72MoL1irTTiOIH5J/cJBve1il+BA7fQo9bbHLK1VPHEh/+mMid/NdGdPF/UnjZDvYY
 /1rwpsQCz9WFESkyRosTw6AqKw5nzesy8NmMcgQuzopb5TPmFOZKtFGT0DL2Hmm8G2QT
 42fkl4xrFJQ7fnEf76rTPTG5llkx7FV03p3XZecyvzjkbaa8TiKOPbwa3nlJ7zdoyyNH
 6KBHvDcrFmzFiZgFd4GVmX/ARXk1Zr+koNG6tnwGFCAMxqh9hyaPbgN23T8hmjS+pOEo
 dbrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZJLhuz8Mi4qYBbJljsmWW7v/SyDPWBk4EE+2g9THPAE=;
 fh=3mGmKpkESGHX1P/4WX0w7j3pc1fd4twTohnp7LmW8Uk=;
 b=frjZPIJkbv5ncNe8VQO/9QwtbePB4hR6khOgJ9r/o4zW5q0wLs25mRv/YyI1pyKzmO
 r68fzYQ+aquCfEdMRi+fZ6ryJJnxQc39Zb0HgKJhve9F4D9/8BzhgeB6ss4bEIwGtDPD
 cgwNqYRphM52ZTf1li/sqErJzWuxuwFQDff1/pZ1uUuM+SdgnKDYYVTKuCJgE9aQ3/AF
 HTmj2X8dpT1L10Q3yli15x6occhaw0C/psZiNQ1O5Wuv023jGD8l1oP2XSG9Pv+4xZe6
 yCRb/MBrE4aprmmGCeZEWAHA02LmSjaprzs+sNG87+52AuRj/5lNb1XxIsogQgOwBdMy
 noZw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774945176; x=1775549976; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZJLhuz8Mi4qYBbJljsmWW7v/SyDPWBk4EE+2g9THPAE=;
 b=MLtCs7X+XspjjQzZqg8YI5FovH4wijxKWemKjvqoLtybQJycSvlZWO2dUXk7OLKjjN
 hpyPirDcj1RuwkhTD2w0MBeX4xe7PAtezKnIDynU3N6qeQnypru2ZzqRvCckdahqiGyj
 lOqI7TvPOmvvJEJecESvaT/zxzl9ON6QDP1HAzKsf8LNiidWyJlSwKUTV4MseoK9YLE1
 DXyBYR0ZWZ0AC6nCxPrDKmy/bO0+VXvqYB3QMqBdWDyL5J294J+K+HYW7TI7e8x2aFfd
 JSSQWhJ3aSoO1OmJgosWoD4aP24ffn9IwoTcXPoAVJCn57SzRBLlihkwCFERwZWknXY+
 MnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774945176; x=1775549976;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZJLhuz8Mi4qYBbJljsmWW7v/SyDPWBk4EE+2g9THPAE=;
 b=Yt8PyLto/t1AMSFRV+Vrc9PbH6lIpoOv1F9zPA+wNerfpLy7KX+0tJCQHfjYNGTJUk
 DbREyHN3WvogPa0ABdzMh5Na2Jp4LS7ARZsgfwJzGFxfI6r3ntmon2jPs0gsKh4Bjc5y
 ewnW96VxMAT7+dtzx4gsB8lnNLYOhCYQ7BL1Nap4j7LViAEBR/NNEAaMDLdBsHIYKGhK
 NnJEDX9BV1ZzK1UFZty02cvScDkunQNF+vEd8BSu71NSlUiOZxtD6uOqjS6YaUtmqnHX
 n7/YdeS0na/o3IQtnAOiLcZ27WTlWwa49sPTecwkf9pq4Rs13GzRVlyc7FLAMtlsM2VP
 w65w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXz2S+3WbBb8MrZKeqwCl+LoK4PgLIxI/Su5h2urSS+X9oMZH1ybCiP4Rl3SRUFT99/18EWuwPl5FCN@nongnu.org
X-Gm-Message-State: AOJu0YxQClJQ0e2pu6ayLc56jviBVZBxrxth7f144aMHD4iye4yusZdP
 lCw94Qo71+jkb3ksFHf9BntI2u7rp9E/EWuD7L6MFrdgeVSzYj89qasLgNuBWpTnaT5VscoJmhc
 zlJ+mSqNOjUSkl5FTDI0g+GohazRrJVDD4cq2QLaSYg==
X-Gm-Gg: ATEYQzx+doAUV5ZztbpykCcdI/t9SqEEFPfkGRSV45mqNsCv+pl5K/Kxa8wdC0h1DxN
 ysLfw6iVqNWxyd3ufdYjY9vb7Ibw7CAwIp8y5orC1Ycro61u6M9fy0Sls6CAbIu8nusR5CaxlG6
 8Zc9U6CiPt6NFU1k+V3ycIg8msAr4/dvDrdbUrcZWZBJ9kZFToaj1aZF5KIvcL19z/d5SxEhuxU
 D2FzxRlMUllm5K3YUnJFY5X29hzm50cI61Xm2zfg98I2smXL9k2mxG3vvrg2iHhDsH1xhs2Zb/7
 0P+9gIl6BXs65Is1mIG7e9jxjMMP2V7kgrpAzsxFk8dB7RWrOxOKU2tTwlGvfuc02HM=
X-Received: by 2002:a05:690e:d55:b0:64f:ff90:4d56 with SMTP id
 956f58d0204a3-64fff904dffmr13391095d50.61.1774945175877; Tue, 31 Mar 2026
 01:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260331040659.401397-1-tangtao1634@phytium.com.cn>
 <20260331040659.401397-2-tangtao1634@phytium.com.cn>
In-Reply-To: <20260331040659.401397-2-tangtao1634@phytium.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2026 09:19:23 +0100
X-Gm-Features: AQROBzCpdSc0PNi8CPN_7ZA8RISCWlS__jTbV8_4vCM12Mgnryb4Ykq9xFUFYJ0
Message-ID: <CAFEAcA-mePyVgVMUy6LDC3E=3HqCyFZVWP78=gY=h_x+_nocVg@mail.gmail.com>
Subject: Re: [PATCH 1/4] tests/qtest: Add attrs support to qtest server memory
 commands
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Tue, 31 Mar 2026 at 05:07, Tao Tang <tangtao1634@phytium.com.cn> wrote:
>
> Extend qtest memory access commands to accept an optional attrs argument.
>
> Supported attrs:
> - secure (x86/Arm)
> - space=non-secure|secure|root|realm (Arm-only)
>
> For memory commands, parse attrs, select the corresponding AddressSpace
> with cpu_asidx_from_attrs(), and issue accesses with the matching
> MemTxAttrs.
>
> Cover scalar and bulk memory commands, including:
> - read{b,w,l,q} / write{b,w,l,q}
> - read / write
> - b64read / b64write
> - memset
>
> Also reject invalid attrs and excessive arguments, and document the new
> command forms in qtest.c, and use qtest_send_memtx_error() to return
> ERR for memory access failures.
>
> Preserve legacy no-attrs semantics for compatibility: those commands
> continue to ignore MemTxResult and return OK.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>

> @@ -510,33 +684,38 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
>                 strcmp(words[0], "writeq") == 0) {
>          uint64_t addr;
>          uint64_t value;
> +        bool has_attrs;
> +        MemTxResult result;
> +        MemTxAttrs attrs;
> +        AddressSpace *as;
>          int ret;
>
>          g_assert(words[1] && words[2]);
> +        if (words[3] && words[4]) {
> +            qtest_send(chr, "ERR too many arguments\n");
> +            return;
> +        }
>          ret = qemu_strtou64(words[1], NULL, 0, &addr);
>          g_assert(ret == 0);
>          ret = qemu_strtou64(words[2], NULL, 0, &value);
>          g_assert(ret == 0);
> +        has_attrs = words[3] != NULL;
> +        if (!has_attrs) {
> +            qtest_write_sized(first_cpu->as, addr,
> +                              MEMTXATTRS_UNSPECIFIED,
> +                              value, words[0][5]);
> +            qtest_send(chr, "OK\n");
> +            return;
> +        }

You don't need has_attrs and this if() statement at all:
you've written qtest_parse_mem_attrs() to correctly return
MEMTXATTRS_UNSPECIFIED for the "attrs argument is a NULL pointer"
case, so the codepath below will handle that correctly. Similarly
for all the other similar places below.

thanks
-- PMM

