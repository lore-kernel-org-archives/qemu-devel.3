Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE38EC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 11:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9kG2-0005C6-6i; Wed, 22 May 2024 07:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9kFx-0005BM-Ob
 for qemu-devel@nongnu.org; Wed, 22 May 2024 07:35:42 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9kFw-0003Tj-3b
 for qemu-devel@nongnu.org; Wed, 22 May 2024 07:35:41 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-572af0b12b8so9797366a12.2
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 04:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716377738; x=1716982538; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Oj0hYS3BTRER1PX4gT/3sjvwrV41mkExy8kKD+nrBEI=;
 b=IH/Xc/8c4oLp3kkdQZ5vzcJNXSVde6/0LxlBBdrhQabUvcW53jtjvndN6fxd7y7Ur8
 zmdQpP4wV9GklHAla2j+pLCETA5gq4J07gVpNqVW48A8GIBLGEm1zQgjxIki+quUwO2g
 MUYzyxojBBi5sB0zO9kf95MvxIbwscHd+JT6qVueHJLefr1kVgaOCoIF97KuRXj8cAS+
 Dich/B1S8txhzvobqZtTSzvsY7MsQ6yZW29N/RbEDyBvY1bpjM/UU7N+SsLRFOEavdxp
 yYLExwLULgrTYtlXAferecBceFJsPakaEGWzTs7kYu36LBYUCc15LVSF82hMqUKkn6Dh
 qTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716377738; x=1716982538;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oj0hYS3BTRER1PX4gT/3sjvwrV41mkExy8kKD+nrBEI=;
 b=hjDh2WUId/EOVeX1UXhzFM5KiWiT+H7fI3mphtC888xV6VRbgNB1819wA1zJZkRQ+j
 hPG56YTfLakyJZZGnG37spCDbEvZbshFnSV77JFPB9ybKY0HnBf3wLotbi1x/SrZmTG3
 4vhBpZWTsG4JiCPlJbh3DyDL0HYa2lm8HdiKtSFQxGUGDa1nAxUbDrxZfBPR6idllFpI
 Ss+2txTuWsuHlYvgu3Y9TOkiNkou+xJ7yHoHpMHh1xc3mZZjBih+gEuiJz3qZ26dFL8g
 HFtYc/g553GSAVdyfF0jlWCr9wMPU6btsVq3x2m44ZKdX1t4wg4DMMrUNepJxHF+4qdH
 57+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV48LaQY24TwqASqZp6ex1Sa9MElLfimYduRhtUhel7Yi4Py5s/q/U4Q1j0Wg61uwuJPjez1ofd5VN/44Kmy0Vkkcboe6Q=
X-Gm-Message-State: AOJu0YwTLWvGhXUshc3lc/CPotEUkL6weTJ67IbegV7NrrjidIcI16fd
 Kl1834R5qGYSN3/04iEFsSF3zpUDBRPL1qb2HlhAFkCR15nQon+o03B8mb74K0fxVcfPMIKrH7P
 0vsbNL8lII56Te7LqPhDMphRNzHFG04jyqz7vNg==
X-Google-Smtp-Source: AGHT+IEozem+eUnU6sgbUstKlQYDYbSKvESOnyAQcUu9blnCio+iaety5OjWfIUqBpm3ZVGtgCNfFos+de7BMPaTetA=
X-Received: by 2002:a50:d74b:0:b0:574:eb80:3308 with SMTP id
 4fb4d7f45d1cf-57832a0e7d1mr1023641a12.9.1716377737240; Wed, 22 May 2024
 04:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240522-xkb-v3-0-c429de860fa1@daynix.com>
 <20240522-xkb-v3-1-c429de860fa1@daynix.com>
In-Reply-To: <20240522-xkb-v3-1-c429de860fa1@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 May 2024 12:35:23 +0100
Message-ID: <CAFEAcA_Sm=j_Q-gP=gaAKpmaMwA1-rO+JLAijzzuuhQOEFyfXA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] qemu-keymap: Free xkb allocations
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, 
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Wed, 22 May 2024 at 11:49, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> This fixes LeakSanitizer complaints with xkbcommon 1.6.0.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  qemu-keymap.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/qemu-keymap.c b/qemu-keymap.c
> index 8c80f7a4ed65..7a9f38cf9863 100644
> --- a/qemu-keymap.c
> +++ b/qemu-keymap.c
> @@ -237,6 +237,9 @@ int main(int argc, char *argv[])
>      xkb_state_unref(state);
>      state = NULL;
>
> +    xkb_keymap_unref(map);
> +    xkb_context_unref(ctx);
> +
>      /* add quirks */
>      fprintf(outfile,
>              "\n"

This is surely a sanitizer bug. We're unconditionally about
to exit() the program here, where everything is freed, so nothing
is leaked.

thanks
-- PMM

