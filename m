Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFABFCA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 07:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqRJ0-0006nj-C2; Mon, 25 Aug 2025 03:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqRIu-0006mt-QX
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:07:45 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqRIl-0008NV-An
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:07:41 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-61c325a4d83so2452534a12.0
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 00:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756105649; x=1756710449; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7vW7F6LUYnKOokC6djP2A9cwOrsAFe4hCulfiVDRVk=;
 b=vdAom+T/3zJPgjjTuTLfXZdcTCQ9K7qes7qhNfXMp8Dd0PLt4FNAVJ+FvDIi/72JG9
 ri9/4LSSBQQJytURefS2mDIOQNF1rGPNorWbPQbrmrW+JCRmmYc9JxMoObefL/7xU9AL
 s/Xma2frj2a3e/achnUuUEFxUD8q5W2pfnTBdRBPjc5Ut/piXz5Rpu/W3QzhuW8xUXR+
 HDfjExafM+x4tD1lTanp9PGv8Y6QxbQ9h6tWOJOipoZ21irkMLxiRyK0SpJee/Oen9yf
 jOnbpV9SduudLPF+HmT6GYAzrI8h3zfeyBZzGx2h1safRw1Z5aBaviQvHKjvd2tpUFxV
 j5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756105649; x=1756710449;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q7vW7F6LUYnKOokC6djP2A9cwOrsAFe4hCulfiVDRVk=;
 b=C1Le/w72EmRfDtAEofsslPi//LXVn3xk4LRQrG6eAFk1eUk9ip8bugwxhZ17UnKPe+
 sYgwec/wzAyExAhAJnmboPT55HWcvXNMdB+6/QyQMkqK+OmSh+gul4T5NYZRFeq0n3wH
 hFZgFkGQQjMzrsvbkjtvYNrOmIj3+A/v/hqHWK1HSbf+sYUAHXnrll6pEPbZ56rrh7Mw
 GODvIdC8uK9Dx8LpK7u7YlTp8/GczNMDotRYnXE1xQcjYKvSu2e9zxCaDanktgk6Gaw7
 L/Ooptkv3sllv3tg1aCjCkzXyaKeG9U6qPz4bRwDERdPHsqx37tl3QVyKd6WeLD9h1YJ
 AQ6w==
X-Gm-Message-State: AOJu0YxKVSvPssvlE1fQw23Nt/muP549KDoEj5IbaJVgC2eO9VVyXVUw
 Q0tNcWvDkdVGyCMETq85ziI8MPYoIiACrwDbr2Io62Wb/BnkVvBwOn6PJJA422hL0GxCKOvPUI9
 dkk0sWOxAWIIEeuy7SshKZlcIjG6CNsVD7IS/dSySYw==
X-Gm-Gg: ASbGncv+nNfnVeTtOeZtaUvkXC/Hj0au3cwO/alR3qt5JZAWM1h7AFZK2k3yKRPh7WG
 rhKMMUPK6y19LGodlrlvGDVKylw3D9emJ37Ld5F/lwWfyZSJnLhUt1W/jHhWuGB+jZ/AlN3q0rY
 E2Kn53WFzmigrIQrZsDMhBo68kanWqOyKQWLopHQDiAhUW1Y434Rz1lqzp8Jqln35TKc/Z+memM
 Qc6YKrt
X-Google-Smtp-Source: AGHT+IFH0Y77ulmMnuWo5UcYL13aKO1+TRkRnciLlHIYvjX9EBSQgjh3X1zvMax82t/iqFkGMJD94O5q8bLhsSIWQxU=
X-Received: by 2002:a05:6402:2686:b0:617:d155:bc9d with SMTP id
 4fb4d7f45d1cf-61c1b5ec8camr8915106a12.21.1756105648714; Mon, 25 Aug 2025
 00:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-12-pbonzini@redhat.com>
In-Reply-To: <20250822122655.1353197-12-pbonzini@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 25 Aug 2025 10:07:02 +0300
X-Gm-Features: Ac12FXwU2A0PJ9nJN2lWJnt5G473ao6xXu77BYC1rRVmVgfCqRWEGodMlugX4TA
Message-ID: <CAAjaMXZHZj5YxyPS=FQyfHLCmRh0btoBJvEBCiXEHFhq08pv4w@mail.gmail.com>
Subject: Re: [PATCH 11/14] log: change qemu_loglevel to unsigned
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tanishdesai37@gmail.com, stefanha@redhat.com, 
 berrange@redhat.com, mads@ynddal.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x530.google.com
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

On Fri, Aug 22, 2025 at 3:28=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Bindgen makes the LOG_* constants unsigned, even if they are defined as
> (1 << 15):
>
>    pub const LOG_TRACE: u32 =3D 32768;
>
> Make them unsigned in C as well, and also change the type of the variable
> that they are used with.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  include/qemu/log-for-trace.h |  4 ++--
>  include/qemu/log.h           | 44 ++++++++++++++++++------------------
>  util/log.c                   |  2 +-
>  rust/qemu-api/src/log.rs     |  2 +-
>  4 files changed, 26 insertions(+), 26 deletions(-)
>
> diff --git a/include/qemu/log-for-trace.h b/include/qemu/log-for-trace.h
> index d47c9cd4462..f3a8791f1d4 100644
> --- a/include/qemu/log-for-trace.h
> +++ b/include/qemu/log-for-trace.h
> @@ -19,9 +19,9 @@
>  #define QEMU_LOG_FOR_TRACE_H
>
>  /* Private global variable, don't use */
> -extern int qemu_loglevel;
> +extern unsigned qemu_loglevel;
>
> -#define LOG_TRACE          (1 << 15)
> +#define LOG_TRACE          (1u << 15)
>
>  /* Returns true if a bit is set in the current loglevel mask */
>  static inline bool qemu_loglevel_mask(int mask)
> diff --git a/include/qemu/log.h b/include/qemu/log.h
> index aae72985f0d..7effba4da4c 100644
> --- a/include/qemu/log.h
> +++ b/include/qemu/log.h
> @@ -14,30 +14,30 @@ bool qemu_log_enabled(void);
>  /* Returns true if qemu_log() will write somewhere other than stderr. */
>  bool qemu_log_separate(void);
>
> -#define CPU_LOG_TB_OUT_ASM (1 << 0)
> -#define CPU_LOG_TB_IN_ASM  (1 << 1)
> -#define CPU_LOG_TB_OP      (1 << 2)
> -#define CPU_LOG_TB_OP_OPT  (1 << 3)
> -#define CPU_LOG_INT        (1 << 4)
> -#define CPU_LOG_EXEC       (1 << 5)
> -#define CPU_LOG_PCALL      (1 << 6)
> -#define CPU_LOG_TB_CPU     (1 << 8)
> -#define CPU_LOG_RESET      (1 << 9)
> -#define LOG_UNIMP          (1 << 10)
> -#define LOG_GUEST_ERROR    (1 << 11)
> -#define CPU_LOG_MMU        (1 << 12)
> -#define CPU_LOG_TB_NOCHAIN (1 << 13)
> -#define CPU_LOG_PAGE       (1 << 14)
> +#define CPU_LOG_TB_OUT_ASM (1u << 0)
> +#define CPU_LOG_TB_IN_ASM  (1u << 1)
> +#define CPU_LOG_TB_OP      (1u << 2)
> +#define CPU_LOG_TB_OP_OPT  (1u << 3)
> +#define CPU_LOG_INT        (1u << 4)
> +#define CPU_LOG_EXEC       (1u << 5)
> +#define CPU_LOG_PCALL      (1u << 6)
> +#define CPU_LOG_TB_CPU     (1u << 8)
> +#define CPU_LOG_RESET      (1u << 9)
> +#define LOG_UNIMP          (1u << 10)
> +#define LOG_GUEST_ERROR    (1u << 11)
> +#define CPU_LOG_MMU        (1u << 12)
> +#define CPU_LOG_TB_NOCHAIN (1u << 13)
> +#define CPU_LOG_PAGE       (1u << 14)
>  /* LOG_TRACE (1 << 15) is defined in log-for-trace.h */
> -#define CPU_LOG_TB_OP_IND  (1 << 16)
> -#define CPU_LOG_TB_FPU     (1 << 17)
> -#define CPU_LOG_PLUGIN     (1 << 18)
> +#define CPU_LOG_TB_OP_IND  (1u << 16)
> +#define CPU_LOG_TB_FPU     (1u << 17)
> +#define CPU_LOG_PLUGIN     (1u << 18)
>  /* LOG_STRACE is used for user-mode strace logging. */
> -#define LOG_STRACE         (1 << 19)
> -#define LOG_PER_THREAD     (1 << 20)
> -#define CPU_LOG_TB_VPU     (1 << 21)
> -#define LOG_TB_OP_PLUGIN   (1 << 22)
> -#define LOG_INVALID_MEM    (1 << 23)
> +#define LOG_STRACE         (1u << 19)
> +#define LOG_PER_THREAD     (1u << 20)
> +#define CPU_LOG_TB_VPU     (1u << 21)
> +#define LOG_TB_OP_PLUGIN   (1u << 22)
> +#define LOG_INVALID_MEM    (1u << 23)
>
>  /* Lock/unlock output. */
>
> diff --git a/util/log.c b/util/log.c
> index abdcb6b3111..41f78ce86b2 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -44,7 +44,7 @@ static FILE *global_file;
>  static __thread FILE *thread_file;
>  static __thread Notifier qemu_log_thread_cleanup_notifier;
>
> -int qemu_loglevel;
> +unsigned qemu_loglevel;
>  static bool log_per_thread;
>  static GArray *debug_regions;
>
> diff --git a/rust/qemu-api/src/log.rs b/rust/qemu-api/src/log.rs
> index a441b8c1f2e..fe43e30104c 100644
> --- a/rust/qemu-api/src/log.rs
> +++ b/rust/qemu-api/src/log.rs
> @@ -140,7 +140,7 @@ macro_rules! log_mask_ln {
>          let _: Log =3D $mask;
>
>          if unsafe {
> -            (::qemu_api::bindings::qemu_loglevel & ($mask as std::os::ra=
w::c_int)) !=3D 0
> +            (::qemu_api::bindings::qemu_loglevel & ($mask as std::os::ra=
w::c_uint)) !=3D 0
>          } {
>              _ =3D ::qemu_api::log::LogGuard::log_fmt(
>                  format_args!("{}\n", format_args!($fmt $($args)*)));
> --
> 2.50.1
>
>

