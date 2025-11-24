Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72041CFD355
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 21:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNe1Y-0000af-8g; Mon, 24 Nov 2025 16:23:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNe1G-0000S5-Pn
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 16:22:48 -0500
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNe1F-0000TZ-6G
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 16:22:46 -0500
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-642fcb38f35so3325473d50.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 13:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764019363; x=1764624163; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hGhg3WUEZygIztlrqkQH8K69wcx1Wk5hLvPb7vzAbYw=;
 b=QI6SmTP07uy9dXg5Sa/1062Uf1n6/0BIuhxIrgXmHsulGtbB6VGz2aBXKHPE+J5ujA
 KyrjuU4jsHjEE7RxXZMqBWnbL6cv2/sXM8cpAERrs3t6W+BjIgcEOkxDpWEX7YLrcAVV
 86BDrWLIm4HCVZdNRCs5MzUxWGGIBS7eDtGx9hdzILuhTh2ObCk4yuaR9j2fJs7e9YUx
 jpWSILUr0yYR3K/VOsyIuH5Z0V22g/S+Cq/7ZFTFJhWsQWXRa2jVqbJsc3nVTcJD8P1U
 LGRbX/2gcLsnY0uBqBNAPk2DGLi53Z8w9QyVhQeNSLxRr0eFrWXkWrWNcLv/VI4AUlZF
 jKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764019363; x=1764624163;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hGhg3WUEZygIztlrqkQH8K69wcx1Wk5hLvPb7vzAbYw=;
 b=pNcc6zoVvud1uItbeMBUXhG++6yya7q8JvY5WPzfovtb+8g/CZKRQ9W6CKVbMnswnz
 p2/2QlG8CaHCHXYTN9C7a8mn6Q6hD7cmjlv1pR9O+SYcr6xILLX3J0gBUp+DTxJZDfoP
 8nptz9ipAR7+nVz9n1R9kAZ+CGnwnbF/gs1YrcLXbL2umCsJLI1SBhpoaNsVaCxScrRu
 yu+yzW8BK7fMTQMT8yay2DY4uj2cK9g27/4HhOx3DqWQ7i0uM4mbfAZkjul2JbFtmIbt
 YeFd0EjP19nAgv7xoMFzK2NdR4tCdHTjP2NgInNMGlLzo9cjti0kjQXr+Gm9OF7s3bEN
 Y/9A==
X-Gm-Message-State: AOJu0YylMXGybWMpLT6KWV2PGhL6HPQ07d4/udwOZP9uA/Lp8Uc2hChz
 fIxqEriNKBgv0g904kbNbT4gbtFQltQ+XY7YZOIA3X59oI/jaQSY3d7r/V0HSgCwv9v16Acuzk5
 Y2q+/L4Rka+ecUwp2s3+2EZDVcSwlbSYsnVeK9jVqXA==
X-Gm-Gg: ASbGncvi0xo/DLoPv0vtxl7z0GTQ2lVpPlqrirOcg1MXtALdf576HayJi3EbCrpc6vX
 mfPOVKkYpsEsCgBNeRlPOVZC7rjUsaFKeYzlDm5enCtHQxm/JAzevosRP8oqyu6yzHAKEn3WN+c
 lLP/AJ+Tb3FLCsGjYzj2aW6JDlgkt8zSkhvgdxMMUAKaombc4JPByfuVqaT+qDLHU6QqoIdqSV/
 42/6b7QC3vMNEvxx8JGDtobzEbs56YkOsGi0XjpgOCO7g+j4nwiWhfQOjfsl0wmkM1o5arP
X-Google-Smtp-Source: AGHT+IE/JhK+j2T6H+R2MKzEUcgPgteN8WiYodf4bb+zETX+HZ0Z0nxGwOeNerEyR9dZmX9heKBMI5dZc6TGuyanO4E=
X-Received: by 2002:a53:acd8:0:20b0:63f:a89c:46f9 with SMTP id
 956f58d0204a3-64302ab7bdbmr7266880d50.40.1764019363538; Mon, 24 Nov 2025
 13:22:43 -0800 (PST)
MIME-Version: 1.0
References: <20251122002656.687350-1-peterx@redhat.com>
 <20251122002656.687350-5-peterx@redhat.com>
In-Reply-To: <20251122002656.687350-5-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Nov 2025 21:22:31 +0000
X-Gm-Features: AWmQ_bn9w4Lf-0UbzLBPMS3fSxPuCDQ6-eOGGWylEo9-GujHHq-8d9vVWrh5xs8
Message-ID: <CAFEAcA9K8sFKSV+nbQ9UKJW5PNnnQwLNuuyQY7gX2LMEk8ui-g@mail.gmail.com>
Subject: Re: [PULL 4/9] migration: Use warn_reportf_err() where appropriate
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Sat, 22 Nov 2025 at 02:02, Peter Xu <peterx@redhat.com> wrote:
>
> From: Markus Armbruster <armbru@redhat.com>
>
> Replace
>
>     warn_report("...: %s", ..., error_get_pretty(err));
>
> by
>
>     warn_reportf_err(err, "...: ", ...);
>
> Prior art: commit 5217f1887a8 (error: Use error_reportf_err() where
> appropriate).
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Link: https://lore.kernel.org/r/20251115083500.2753895-3-armbru@redhat.com
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/multifd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index a529c399e4..6210454838 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -464,8 +464,8 @@ static void migration_ioc_shutdown_gracefully(QIOChannel *ioc)
>           */
>          migration_tls_channel_end(ioc, &local_err);
>          if (local_err) {
> -            warn_report("Failed to gracefully terminate TLS connection: %s",
> -                        error_get_pretty(local_err));
> +            warn_reportf_err(local_err,
> +                        "Failed to gracefully terminate TLS connection: ");
>          }
>      }

Hi; Coverity points out (CID 1643463) that this introduces a double-free
of local_err. In this function local_err is marked up as g_autoptr()
so it is automatically freed when it goes out of scope. This was needed
because error_get_pretty() doesn't free its argument. But
warn_reportf_err() *does* free its error argument, so now we free it twice.

Dropping the g_autoptr markup would be enough, I think.

The "prior art" commit 5217f1887a8 also seemed to introduce
some double-frees in hw/usb/dev-mtp.c, but it looks like we
fixed those in 562a55864 (but with a Fixes: tag that didn't
point at the commit that introduced them but at a different
blameless one).

thanks
-- PMM

