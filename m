Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F4ECD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 19:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL4qq-0006Q1-Fs; Thu, 07 May 2026 15:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL4qo-0006Ps-Kv
 for qemu-devel@nongnu.org; Thu, 07 May 2026 15:57:38 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL4qm-00010V-PH
 for qemu-devel@nongnu.org; Thu, 07 May 2026 15:57:38 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65c37eafcbeso1541427d50.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 12:57:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778183855; cv=none;
 d=google.com; s=arc-20240605;
 b=VoMHPvPXVgxd/AzyYIaT9DNmDufNP2rbTFx9O7jAjF/atl8orCbpRH/E+pWe5DiS6L
 dPJeTyPjPro/cQL+60smzIWXM+ESRxv9mMsWTCtj9EPrf9Hlo5iWdjBp+O0nym3eRNvc
 v1uwvZ+qJdmpYFRaL1G1i3OSB/d7Ly1cxIWCgnTCLtzUGugj+5tw+SLDlXGEUttliJ1u
 E//JnGG/c655dUTH8nMNAcUGpn76P1MY+R5v6vuhz01Fd6c0UJMW7yPjCBusC3V9BPRw
 a14JstZ10cKSzNe7QSOZ84VoqH7UxXw9kFp9bbLRMeLP+OZwUailiUWQlA8FeFMg/J9k
 4CmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JxpJZfrVRmJOSp5G9KZjW21FKVIqMLCMiL97D1mfnaE=;
 fh=Zy8f29HJFJfjn54T4OIGQBQXkI5p+92xlVl4K44vjn4=;
 b=DpsMSToEWuaMuuM7Fv37fVb0fG5SxllWoJGKjp8PrIB2gvbcbXRBycbruLTgL2TShI
 lTXhwEX/ZJmMwDqKQJtWFGCXFLMWQk20u4wzbKXGjbQSj7Qdn9s59+HDAhCWV40wquou
 KRxq6p0YCQTwfF3gJqFKcrNiDmjj088soCx6HJwkDrhiqpGSLxNleeBX0J8/+9tyaX4H
 0eqc7BBinfotcc6hQ/THq2KbYaQkjdVL0oJi7j/moD2R0NUvBy4FiP4mce4W1yjGruOz
 q0AVEiaFr55qsaFfaqfxdUGWx9L9/sP8GkcBIV56bTLE8HHFawBUnGTHy3oP7kxo0pCl
 jFoQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778183855; x=1778788655; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JxpJZfrVRmJOSp5G9KZjW21FKVIqMLCMiL97D1mfnaE=;
 b=cQVJnVstuOOtb9UEhpn2zvusq6UvrRtPFIwKlr3MOhJbJUh1/zBdxUjsCbrK5vLVjb
 wi3wXx2iDxfS+CFjCkV5PgmdGLIWEYywK5iLqp47tNwAt1censkhf+/Lw47nV4oVBxs7
 UynXRwBQ0WqYzj6UevnNwFdAXeMMJcrCXg56iM40MytMdosyj769CCxi6EUCozeaU0bI
 Jz+8appZ3qSjkKyNdvkS8j7tptRIWbVKB1Hdyy6I/4tqI+kFbjDFWZWHiFd4O02eeP4N
 at3xS/vDUMZeXuK5kTW9mHV/Ss0daxAjnrI3guorCfCvM+icXHRjEu93lxwmmkINpcMD
 S9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778183855; x=1778788655;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JxpJZfrVRmJOSp5G9KZjW21FKVIqMLCMiL97D1mfnaE=;
 b=dsRYITlOL2rVO3Au4zgzhMYjj7ylHiB8U81co5dnPotZR41ImCKIwZn2XFSyZfs4cj
 qKnfSB/ui+cXH9b/3CB10B6jiOlllk4crEgoNIL613w5YBfKfG57gB5zhwHbmnNgMqnP
 CjAKUq9R9ijl2cQRKvmoSSwwhDv+TPjYWRj6MGJhSzGWsyjYx9R4IhYVZ2nrJSRDz06t
 xnfU2DZduEyY5gJ62HIjqtd78eIhRectONgvQ1vvs/Ge8YJD5DR+ImnqswKNAeLHpNvW
 5ORVkXq/gZzjK+0PPAriyFxkxO0gxqM8o2Vbrf/y8GrOOFSyukrfqt4Fgv+DNPOz6MHt
 f6Kw==
X-Gm-Message-State: AOJu0Yzryyrk7Sm7oZE0hEH9epNUC0tLtukwdLgOZzYefb+QZpHhrRWn
 LX0CO6rFH58lFn9ofAuVSOohiVidc5sgWbVfK1WneslAVWP6lnsQr1Qi7OaFHVDArto6HJKfqrV
 FmsRjyA/o3Gnf9FMwxEOHZ9WA45s1PVmuAzQqJ8axzQ==
X-Gm-Gg: Acq92OHzITwrW1i6gfYTAx+hIfKnzbkvjF8nMT0dUqogt3C1Nttct4jLW0p94Ln2yEE
 GKOC1oi+mtLIW/TSMvh5QnvjSZdbV9hnEm32LKkaoJHxqqt9dMDATrek1Z0NoZ9DO8G91l/ppNx
 yas9Vj8GexBzIj5BpLpYTfCWTZSUsoYcgtLVogQSuzZsEP1ExOrTNwSsXMS/okgr8RrO0mDQx9d
 mOHTIMnU+2/tbN8lWaxL7O3gMW/54CK7qax4hxsGw6SMqpPL4aYLWF60AxfuLa7hfP4FgO5dP3I
 dloF3buMe9rLfnXMZx95ZY9sLp0mp0DQ1uAcVAYaFpf6uuIviwP/XI/LpNz9X+rSz2VBch/yJem
 vJA==
X-Received: by 2002:a05:690e:c45:b0:65c:6de6:b220 with SMTP id
 956f58d0204a3-65c79922524mr9833826d50.21.1778183855529; Thu, 07 May 2026
 12:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260505202640.1011006-1-peterx@redhat.com>
 <20260505202640.1011006-14-peterx@redhat.com>
In-Reply-To: <20260505202640.1011006-14-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 May 2026 20:57:24 +0100
X-Gm-Features: AVHnY4IL8knNPEqIHIBPGbX-x-UD5Slw2KmxvdaMJI0ks5ksy-8FQEaEjezO45M
Message-ID: <CAFEAcA-MYH6C39xO0OLx4-M5pKurJpurwRsMqZe9q=W-NShAbw@mail.gmail.com>
Subject: Re: [PULL 13/23] migration: Calculate expected downtime on demand
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Tue, 5 May 2026 at 21:29, Peter Xu <peterx@redhat.com> wrote:
>
> This value does not need to be calculated as frequent.  Only calculate it
> on demand when query-migrate happened.  With that we can remove the
> variable in MigrationState.
>
> This paves way for fixing this value to include all modules (not only RAM
> but others too).
>
> Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
> Link: https://lore.kernel.org/r/20260421202110.306051-12-peterx@redhat.com
> Signed-off-by: Peter Xu <peterx@redhat.com>

Hi; I'm seeing a clang undefined-behaviour sanitizer failure
in the code introduced in this change when running the
aarch64 migration-test via "make check" on an x86-64 host.

It seems to happen fairly reliably when I do a "make check -j20",
but not when I run the test on its own, so it's probably load dependent.

Here's the backtrace:

../../migration/migration.c:1051:12: runtime error: inf is outside the
range of representable values of type 'long'
    #0 0x57b49d635c0d in migration_downtime_calc_expected
/home/pm215/qemu/build/arm-clang/../../migration/migration.c:1051:12
    #1 0x57b49d63e860 in populate_time_info
/home/pm215/qemu/build/arm-clang/../../migration/migration.c:1075:35
    #2 0x57b49d63617e in fill_source_migration_info
/home/pm215/qemu/build/arm-clang/../../migration/migration.c:1184:9
    #3 0x57b49d63617e in qmp_query_migrate
/home/pm215/qemu/build/arm-clang/../../migration/migration.c:1264:5
    #4 0x57b49e4aed75 in qmp_marshal_query_migrate
/home/pm215/qemu/build/arm-clang/qapi/qapi-commands-migration.c:48:14
    #5 0x57b49e526814 in do_qmp_dispatch_bh
/home/pm215/qemu/build/arm-clang/../../qapi/qmp-dispatch.c:128:5
    #6 0x57b49e58c35a in aio_bh_call
/home/pm215/qemu/build/arm-clang/../../util/async.c:173:5
    #7 0x57b49e58c698 in aio_bh_poll
/home/pm215/qemu/build/arm-clang/../../util/async.c:220:13
    #8 0x57b49e542fc1 in aio_dispatch
/home/pm215/qemu/build/arm-clang/../../util/aio-posix.c:390:5
    #9 0x57b49e58f10a in aio_ctx_dispatch
/home/pm215/qemu/build/arm-clang/../../util/async.c:365:5
    #10 0x7c74a09b8584
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d584) (BuildId:
116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #11 0x7c74a09b86cf in g_main_context_dispatch
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d6cf) (BuildId:
116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #12 0x57b49e5901cb in glib_pollfds_poll
/home/pm215/qemu/build/arm-clang/../../util/main-loop.c:290:9
    #13 0x57b49e5901cb in os_host_main_loop_wait
/home/pm215/qemu/build/arm-clang/../../util/main-loop.c:313:5
    #14 0x57b49e5901cb in main_loop_wait
/home/pm215/qemu/build/arm-clang/../../util/main-loop.c:592:11
    #15 0x57b49d5f5486 in qemu_main_loop
/home/pm215/qemu/build/arm-clang/../../system/runstate.c:948:9
    #16 0x57b49e42cdfb in qemu_default_main
/home/pm215/qemu/build/arm-clang/../../system/main.c:50:14
    #17 0x57b49e42cdd3 in main
/home/pm215/qemu/build/arm-clang/../../system/main.c:93:9


> +/* Return expected downtime (unit: milliseconds) */
> +int64_t migration_downtime_calc_expected(MigrationState *s)
> +{
> +    if (mig_stats.dirty_sync_count <= 1) {
> +        return migrate_downtime_limit();
> +    }
> +
> +    return mig_stats.dirty_bytes_last_sync /
> +        migration_get_switchover_bw(s) * 1000;
> +}

Presumably in this function migration_get_switchover_bw() returns 0,
so the (floating-point) division results in Infinity. That's fine
until we have to convert it to int64_t to return it, which is the
UB that the sanitizer is complaining about...

thanks
-- PMM

