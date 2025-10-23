Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605F0CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 09:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBs5T-0000Wu-6j; Thu, 23 Oct 2025 05:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBs5R-0000Wl-JG
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 05:58:25 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBs5P-0002pn-Gr
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 05:58:25 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-780fe76f457so6672497b3.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 02:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761213501; x=1761818301; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2uCZYUUy2pPaW+WI53ENBf6uxgXbiMMJyi4oRoJmj/I=;
 b=gkPPcvEYacvbTMpseyGKOrMCBqcJBAon/DNBDGMtRGui9DJ4UQPkf8xgKrLdoFD/bL
 y7ZwKn+k3HDXsD/2A4ImqVx/6x0LUQrtbl9XWOt3e4mlbQZbP4XvfTdtjLBEjBuyVIBY
 wqPcofMACpNzBmNI8uz8rEO5v66rom/TR7psfy+WkCn7YSN0m1jAksgDCZnqUnuKJBtR
 BNP4iiU2VXXtGzgdQIXxuxdmS07F7Y9xrbsR+DXeB3A1iLgzrgq7B64xLuXp6scGymgB
 kfvSJgI6VHIguyR6tl4PDFkdDZ+n76fHuvwZMAXp/d91Nip+TXfghsGK0xrwoDOfg4al
 b8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761213501; x=1761818301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2uCZYUUy2pPaW+WI53ENBf6uxgXbiMMJyi4oRoJmj/I=;
 b=MmQJI8FsI7k3ijQS+0MY1uYJhR4QFdbJqo5C7Qkqeu2GWRRL7HBbZoyH/h1YgvTjih
 zaapWh4gSBvQbntjzeftuH7qRIeaKNALtvG7+PEwdnlBOiQimOlVnYyTQZmDfrzaDckr
 3Gz1KgPmX6JmYtrxSmsIr3cdVKpSTtIAQFvxZawGvZY0f6axPub/81Whv6O7nm73Byg0
 ubaWUkTRz8ckuC5iB+XEH8sXdyDwzyVAle1Hn9wWBPEeOYZCwQwMnTa+9MLrXf22awLT
 ehlB7wEOJsY8PY2f5yLtrVh4/51JliHGRoYvYdKZE6V6yUjFR7eGBoDZJTeSxeFHGE5b
 q7Fw==
X-Gm-Message-State: AOJu0YxYAWFf/dV328EDaTL8AZ2FEWZ7atDKFdB7xBlQgZa8NKgLBCP+
 s9eAniXqDzXdamiuKavR2zwlAoZrh4DDgVWEZ0H0CmKgM4eSd/rc2zDASQL461dqcQBXHx43x5M
 ChPbr+XHA2trjsse6+61faiq+ghz+vTCxEOeN7YICmw==
X-Gm-Gg: ASbGncu8CqLEXdUTpMsGiq4YeV0lT5fmRzKcLuIp2vn4cP7x4EI4lkHmDj5nuzOj8o5
 JcaWnPFOqNLwb7gjzwDtCXTJB7UOOJoRodibjrj/yyTs/XJ7si4mHr0pCsLdtgzLXzA3Zdl9uPy
 Q1PiPmPBXENOT+ydsiDekNMiD6XvIO6JyTNinWqgkg/J2yjPkSqVFyw5qL/VC5Hg36mSX31NVQP
 DwT7FTFM2kpNt5DSmJClTo0NhItP5BXZhCt831Vkz6NRhArjAxrFxivyTH4zkPGWTdgEE9f
X-Google-Smtp-Source: AGHT+IHGdFE1vaRM/LwHh2b/SkXWVv6uOP2079WMrEPY2/Lnv5iEm6RyBmmKEVDJFWzAcvfe8dvixv9vzcXjTU+e1AI=
X-Received: by 2002:a05:690c:6901:b0:783:7143:d826 with SMTP id
 00721157ae682-7837143e02emr373269267b3.29.1761213501337; Thu, 23 Oct 2025
 02:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20251005194734.4084726-1-samuel.thibault@ens-lyon.org>
 <20251005194734.4084726-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20251005194734.4084726-2-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Oct 2025 10:58:10 +0100
X-Gm-Features: AS18NWDu7BoC5j1Y6x1Y5u34B8z3AnBEez0HpBArB-jBjNO64An1_ejkOv4DKAY
Message-ID: <CAFEAcA_P2=kv_WZZP7k_5TRvTmzo1NMUq8r+sMFCRBApORXkKA@mail.gmail.com>
Subject: Re: [PULL 1/1] Add a feature for mapping a host unix socket to a
 guest tcp socket
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, Viktor Kurilko <murlockkinght@gmail.com>,
 stefanha@redhat.com, jan.kiszka@siemens.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Sun, 5 Oct 2025 at 20:48, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> From: Viktor Kurilko <murlockkinght@gmail.com>
>
> This patch adds the ability to map a host unix socket to a guest tcp socket when
> using the slirp backend. This feature was added in libslirp version 4.7.0.
>
> A new syntax for unix socket: -hostfwd=unix:hostpath-[guestaddr]:guestport
>
> Signed-off-by: Viktor Kurilko <murlockkinght@gmail.com>
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Message-ID: <20250808143904.363907-1-murlockkinght@gmail.com>
> ---

Coverity worries here about a possible time-of-check-time-of-use
bug (CID 1641394). This is a heuristic that tends to fire even
when there's no interesting attack possible, but I don't
know what this code is doing so I raise it here:

> +#if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
> +    if (is_unix) {
> +        if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
> +            fail_reason = "Missing - separator";
> +            goto fail_syntax;
> +        }
> +        if (buf[0] == '\0') {
> +            fail_reason = "Missing unix socket path";
> +            goto fail_syntax;
> +        }
> +        if (buf[0] != '/') {
> +            fail_reason = "unix socket path must be absolute";
> +            goto fail_syntax;
> +        }
> +
> +        size_t path_len = strlen(buf);
> +        if (path_len > sizeof(host_addr.un.sun_path) - 1) {
> +            fail_reason = "Unix socket path is too long";
> +            goto fail_syntax;
> +        }
> +
> +        struct stat st;
> +        if (stat(buf, &st) == 0) {

Coverity notes that we do a check on the filename here
with stat()...

> +            if (!S_ISSOCK(st.st_mode)) {
> +                fail_reason = "file exists and it's not unix socket";
> +                goto fail_syntax;
> +            }
> +
> +            if (unlink(buf) < 0) {

...and then later we do an unlink() if it's a unix socket.
But Coverity points out that an attacker could change what
the filename points to between the stat and the unlink,
causing us to unlink some non-socket file.

Do we care ?

> +                error_setg_errno(errp, errno, "Failed to unlink '%s'", buf);
> +                goto fail_syntax;
> +            }
> +        }
> +        host_addr.un.sun_family = AF_UNIX;
> +        memcpy(host_addr.un.sun_path, buf, path_len);
> +        host_addr_size = sizeof(host_addr.un);
> +    } else

thanks
-- PMM

