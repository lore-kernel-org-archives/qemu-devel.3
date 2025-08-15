Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A84CA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 10:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umrXk-0004qJ-1T; Fri, 15 Aug 2025 06:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umrXi-0004ps-1Q
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 06:20:14 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umrXf-0005Fq-99
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 06:20:13 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e931cad1fd8so2049362276.1
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 03:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755253209; x=1755858009; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oMFA5cP+m5au6n62a7L66AwXlxBEScrSkxcsHVWkaE8=;
 b=Oh1taaM8uZBRqryHHNeA0/Fye3HfAeDQca4hQAK+m+xGujPodmirI/SjoA5zNQ2rC2
 6hAELEr+5ga2Oe3kso2cwml5f01s4OuP5wnzW2zoAG5VWy7A3H/YITtBLYhF66/siYXV
 CW4KtOrEpsmTy4jWCo4SyYXoRPs/ywEVyCQnZ3gNs9Y2+CZzVpUcj1c51U6I9VQTyQ+G
 9xi/PaXWkS1gpWRZnIvchWxB7z2MMC9b8126EV58RVyEUDTifhg/WFQLRnO2H5xC1I9z
 ZtRbMYhL/c3dX5rQa+X3yubmYbXICe0MVziohSZgMUmOIvcBnaQ4+40Ad0TxxgBabCqI
 TqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755253209; x=1755858009;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oMFA5cP+m5au6n62a7L66AwXlxBEScrSkxcsHVWkaE8=;
 b=pW2AthbOp4HQny5FpMIpJolf+BlD6x7ifyIaF6ELAZBfuIUGcyKi1bTVtu9RAGTPxc
 wcQPicM29fqpP9i+mgMmOK9GqdKyifB3BCiJv5EKOn6givQfziYrP0/KUKgZs1wnsTT8
 amm5s+tqsDBlCVY2Bhf0a99fC1g5nCzAaALl4WbHZula3YIfH4thIqWcM93gOJy8UY5D
 A8DYMXQr+rnaoCyib9iOIziALJtuQ9P2zjs3AGmpCSIL2P8wvlooqEoQnMWrNh4t5+kz
 ZM8lDMycUxyb3IiNxtvsPDNzuiaXDIiAKofQXuYg7BiYYRx303NTjBTA/4WPs2hIpJ0u
 obsQ==
X-Gm-Message-State: AOJu0YxSrDpzH8tpXWRrqibaE+zI4462JlNGcGUvP7bTG3Mw2GkYgh+C
 mkvNe8F1s32/eKoR9KsLv9nOKVC8x2h0ppApxOMUGjBaEIilZB6xBNCdtHqDvCxKuoPEoM2qm/E
 S2W3jpx83OJD7h+rXl2VKW7TW0FGAhYpFE7KPYGjFNj6nIOLW3WVh
X-Gm-Gg: ASbGncv0BdJMDx3DC2jjHbcWyMbIP7mHdm2HkHO7aqoyGwTKu3+k+qM+K+27IXrhGEM
 9ta0oQpLIaEsyLadMT81z+Y8V9qz7Xa/4qScA0EOjGEknBr40aoOiGg+nYSeNjbO+nxFgJXF/w3
 1SbICo+qGbkv9inMkc30egxA0HWZ2sQ1Wk5rf261z+BdGh0eoDt/pfuzLp1qVJ85oEh/2vC6KD7
 2s7LBGN
X-Google-Smtp-Source: AGHT+IGy5czY9JQUho9SPJR784G/ty3JPVqRwvrxTbUMF3DEQfb25UG89hs9EV+Z4z9/FV0UCGb/gzYYuQQ084z30Z4=
X-Received: by 2002:a05:6902:721:b0:e90:6f18:e7e2 with SMTP id
 3f1490d57ef6-e933211155bmr2128965276.0.1755253209590; Fri, 15 Aug 2025
 03:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250814171324.1614516-1-peter.maydell@linaro.org>
 <20250814171324.1614516-4-peter.maydell@linaro.org>
In-Reply-To: <20250814171324.1614516-4-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Aug 2025 11:19:57 +0100
X-Gm-Features: Ac12FXzNIZ5TR87gsAi5rLr2krSVDsyR0FY7qCqyW9SoXpqtyN26zYw1m0f3_e8
Message-ID: <CAFEAcA_cWSGXQtAKdXZwZ+SPt_ipLKBn6d+4Z3ApAj1dnEYnPQ@mail.gmail.com>
Subject: Re: [PATCH for-10.2 3/8] scripts: Import Python kerneldoc from Linux
 kernel
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Thu, 14 Aug 2025 at 18:13, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> We last synced our copy of kerneldoc with Linux back in 2020.  In the
> interim, upstream has entirely rewritten the script in Python, and
> the new Python version is split into a main script plus some
> libraries in the kernel's scripts/lib/kdoc.
>
> Import all these files.  These are the versions as of kernel commit
> 0cc53520e68be, with no local changes.
>
> We use the same lib/kdoc/ directory as the kernel does here, so we
> can avoid having to edit the top-level script just to adjust a
> pathname, even though it is probably not the naming we would have
> picked if this was a purely QEMU script.

>  scripts/kernel-doc.py           |  325 ++++++
>  scripts/lib/kdoc/kdoc_files.py  |  291 ++++++
>  scripts/lib/kdoc/kdoc_item.py   |   42 +
>  scripts/lib/kdoc/kdoc_output.py |  749 ++++++++++++++
>  scripts/lib/kdoc/kdoc_parser.py | 1669 +++++++++++++++++++++++++++++++
>  scripts/lib/kdoc/kdoc_re.py     |  270 +++++

We could alternatively put the whole thing into a subdir, e.g.:

   scripts/kdoc/kernel-doc.py
   scripts/kdoc/lib/kdoc/kdoc_files.py
   scripts/kdoc/lib/kdoc/kdoc_item.py
   etc

if we don't like having lib/ at the top level of our
scripts/ directory.  The thing the script cares about
is that the relative path from kernel-doc.py to the
lib/kdoc files is the same.

thanks
-- PMM

