Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFED1EEB565
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 09:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sofof-0004Tf-Oi; Thu, 12 Sep 2024 05:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sofoe-0004QW-UJ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 05:08:40 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sofod-000268-0n
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 05:08:40 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c26a52cf82so420970a12.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 02:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726132116; x=1726736916; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TtPmkgukprf5foEWlVAICHJYSmGJopSX45aRQsDZ0GQ=;
 b=Rd/zUrhEQ/ErGhWLrnmwxFQQJJZ4LjG3QSfBAa9D7axw3VA1+vI48WrtreqTuizEF2
 0k9qsSGIkEo1KlIIRt0En940MM0LNZMIWMLtO5bld/pEP00vIS1yQl7VPEENFNZ/3mmR
 Gd7OaRXhZlxIwwNRtP5YgNlfdCSLP1LyNCB9qGGj86t5Y6K8+3utvj7SB2ZA7vKiCYI0
 njS+/XbKICQ6PHUaCje4naBpSmoCQlKYLCPEGPwpcvxXdjHGldVvnq2bfFAmbXxfDEoh
 nbK93h9BW6KOWjQz77tMtgyPXi0zBniUe60188ilIb9e5ZcCthdTsBpZVEPsVy89Wmdh
 2unw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726132116; x=1726736916;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TtPmkgukprf5foEWlVAICHJYSmGJopSX45aRQsDZ0GQ=;
 b=VcahQ4Rh5lSmZUDs5awiXGx85wL44TJpKQHaaMHuBjLTI1WE8e9/IQjx5Lj3KPEloU
 O9x8EknXPUU0InbpNfc6aFp0KQFe75R0v1N4nNLc+a0sqzlyGW7q2K7KSGZV/BJgpmpR
 dHpZQ+FZJXcs5ZJblFvEcAaoMkT6lMZK1QDxYg1v4MYGcCOmx3VG9YF9eJ4v9A7+WRTH
 ZUF9VUFHfnvultAx47mb7SFPv9Xfx23vD7M2ChXaKZ6aCMuxKEWd/DabdJFrUrMbMH8S
 zpcB3lNYG7grT5MrrfBcCiDr5MKyG2SeyHKtvrAiVcVXH+Wj6cie4fPeHZ3GvV+FIdIM
 zUlA==
X-Gm-Message-State: AOJu0YzJvU7dXQW+cAydy8qYftmf/GVzSPpfMwDzYPbmJ/Ic25U5y2hm
 WBew7ZEC7bPMrdHKk31I4zw5PmdKJhta++2Qcxu6YuyLddTVM0osUtYTHKleKRGBKgWdHTJX36X
 CJ4DSWVvfPACCFYrc1lMfUKGgzeWSU2LJvUz+Vw==
X-Google-Smtp-Source: AGHT+IHRUtiDk3pKHXmCsRaAl0PIgAbCRiTM9N8cfE2n53vXkaZV8nq/fEFZNprqu2t141DXQEUALlchNDUE8XBXL60=
X-Received: by 2002:a05:6402:13d5:b0:5c3:c296:1bc9 with SMTP id
 4fb4d7f45d1cf-5c413e5f072mr2221252a12.29.1726132116055; Thu, 12 Sep 2024
 02:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240911093426.287808-1-thuth@redhat.com>
In-Reply-To: <20240911093426.287808-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Sep 2024 10:08:24 +0100
Message-ID: <CAFEAcA_V_hcgUSw6ChMxs-SuUqzBLZa7_6995seEy6xxQ+5bNA@mail.gmail.com>
Subject: Re: [PULL v2 00/24] Tests and misc patches
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Wed, 11 Sept 2024 at 10:34, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter!
>
> The following changes since commit a66f28df650166ae8b50c992eea45e7b247f4143:
>
>   Merge tag 'migration-20240909-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-09-10 11:19:22 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-09-11
>
> for you to fetch changes up to b4358ed4fd29c21c69e492d814f0926c58caa10f:
>
>   Update FreeBSD CI jobs FreeBSD 14.1 (2024-09-11 11:26:41 +0200)
>
> ----------------------------------------------------------------
> * Split --enable-sanitizers to --enable-{asan, ubsan}
> * Build MSYS2 job using multiple CPUs
> * Fix "make distclean" wrt contrib/plugins/
> * Convert more Avocado tests to plain standalone functional tests
> * Fix bug that breaks "make check-functional" when tesseract is missing
> * Use builtin hashlib of Python in the functional tests
> * Update the FreeBSD CI jobs to 14.1
>
> v2:
>  - Use python hashlib instead of external programs
>  - Update FreeBSD CI jobs FreeBSD 14.1
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

