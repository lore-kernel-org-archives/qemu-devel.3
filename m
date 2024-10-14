Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790B9D1627D
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 14:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0MDi-0000IZ-Q4; Mon, 14 Oct 2024 10:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0MDf-0000AM-RW
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 10:38:48 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0MDd-0003CS-Tk
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 10:38:47 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c94c4ad9d8so4089114a12.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 07:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728916724; x=1729521524; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IVSJW0KTv1P2GvafknXAVPQOGKmIQUuPLzZbFR5Miko=;
 b=r6MLiFc5zhU6kt6J0Y3vDKENJpntxJcgVG9bqSZ2OsL3MoIrwVUSjm2PWOeAsGkFj2
 JVfS9osTxpQWGCNnE6trLQbm9e/aj2Dnae5Wb1kaV1+hsxbeiXYkc+S3q5VbuYHYSHoq
 nzreZ90gQiCWFzjWlpL0fODb09u5AMnvpYiB0KS+9WFhI7Bv5ge/7KFaRYILZRMnACwE
 SpMFhC8DaoGZo9tiy+T8Vp03HQHZzLTBaKz5XrXhFBgfiwjjIsSvJ5fMeaMKYQv31PGH
 pOfZ1A9dJhV+PQqKajLkEf1Dtwj4c13DnCPq/0fVohIjiT3/jHPtWHgAg5Sq/28Q4q52
 xZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728916724; x=1729521524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IVSJW0KTv1P2GvafknXAVPQOGKmIQUuPLzZbFR5Miko=;
 b=CmKCVgA2ticsvOygqoZ3D4yYtkPZTYpE/P25Fy5gyhiYKo3mOgYuZ3enOekRb4hwtk
 wkaVdkB/zqIk8CYIZV7GT9AVw7ir1H5APFvtL9JqW9kz/S1vw3vF0zTtHBTvp9D48Wpo
 A025Z7Ju47WqTFfkINnkswmBcoPzrBehoHWpt6S8ta7Dtk9I22XXM9huj36OpurL88hP
 CO4G7c52U/CtR6q6GhC24q09tSvJ7htsYTkQU52qHBegu0wxgSbps71vur4s8aXRanWz
 OhbwAGyCIVQUAfa0JTvYAGk7TAVcLb2D5Dl+Quww9ao/9rzuhJTZnOSGNiVAClEMMbl+
 zCOg==
X-Gm-Message-State: AOJu0YxZtJvL+luZsHmaiTsFNJXK1uIH145ylU0deZDiI2G0jFSWLge0
 oyH9AnKA2MHVE7I7gK8f51YVG/mfFlSNI/Qr+hZo6lMl1M59p2uvTQv/x6m2bm3DKIkXRwLT7nG
 uTevqOB+PeP+uwVHUJPftu3tiFUCctRrpV65wdQ==
X-Google-Smtp-Source: AGHT+IGwHuQZGbvD/79e7IDnGxJEmaIAeil4d0kHI5AwZgvwa0qB0dKgngIXmiPFmDZCi3k9zewUchZMRsmnG5YmxEg=
X-Received: by 2002:a05:6402:3547:b0:5c9:76f3:7d61 with SMTP id
 4fb4d7f45d1cf-5c976f3816amr3189625a12.21.1728916723710; Mon, 14 Oct 2024
 07:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20241014143640.196735-1-pbonzini@redhat.com>
In-Reply-To: <20241014143640.196735-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2024 15:38:31 +0100
Message-ID: <CAFEAcA_GgntHgo9tP70L1tHVhxXcsgJ0hne-sqHHH2-B+E4oCQ@mail.gmail.com>
Subject: Re: [PATCH] meson: check in main meson.build for native Rust compiler
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
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

On Mon, 14 Oct 2024 at 15:36, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> A working native Rust compiler is always needed in order to compile Rust
> code, even when cross compiling, in order to build the procedural macros
> that QEMU uses.
>
> Right now, the check is done in rust/qemu-api-macros/meson.build, but this
> has two disadvantages.  First, it makes the build fail when the Meson "rust"
> option is set to "auto" (instead, Rust support should be disabled).  Second,
> add_languages() is one of the few functions that are executed even by
> "meson introspect", except that "meson introspect" executes both branches
> of "if" statements!  Therefore, "meson introspect" tries to look for a
> Rust compiler even if the option is disabled---and then fails because
> the compiler is required by rust/qemu-api-macros/meson.build.  This is
> visible for example if the compilation host has a stale
> scripts/meson-buildoptions.sh and no rustc installed.
>
> Both issues can be fixed by moving the check to the main meson.build,
> together with the check for the cross compiler.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  meson.build                      | 3 ++-
>  rust/qemu-api-macros/meson.build | 2 --
>  2 files changed, 2 insertions(+), 3 deletions(-)

Missing Signed-off-by: line ?


>
> diff --git a/meson.build b/meson.build
> index aecc381932d..c85f964bed4 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -71,7 +71,8 @@ if host_os == 'darwin' and \
>    objc = meson.get_compiler('objc')
>  endif
>  have_rust = false
> -if not get_option('rust').disabled() and add_languages('rust', required: get_option('rust'), native: false)
> +if not get_option('rust').disabled() and add_languages('rust', required: get_option('rust'), native: false) \
> +    and add_languages('rust', required: get_option('rust'), native: true)
>    rustc = meson.get_compiler('rust')
>    have_rust = true
>    if rustc.version().version_compare('<1.80.0')
> diff --git a/rust/qemu-api-macros/meson.build b/rust/qemu-api-macros/meson.build
> index 48af91ed389..517b9a4d2d5 100644
> --- a/rust/qemu-api-macros/meson.build
> +++ b/rust/qemu-api-macros/meson.build
> @@ -1,5 +1,3 @@
> -add_languages('rust', required: true, native: true)
> -
>  quote_dep = dependency('quote-1-rs', native: true)
>  syn_dep = dependency('syn-2-rs', native: true)
>  proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
> --
> 2.46.


thanks
-- PMM

