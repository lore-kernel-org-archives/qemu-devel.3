Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C1FC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 14:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryuVO-0000nu-C6; Mon, 22 Apr 2024 10:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1ryuVM-0000i4-HA
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 10:18:48 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1ryuVK-0006q1-9R
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 10:18:47 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a55b93f5540so117514366b.1
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 07:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1713795524; x=1714400324;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HEjrY/tHBtAmdIxQI2YcasxXeb63ob1ZNEbW9sS8ch0=;
 b=d7IYZeC35l2NM3M1tKq3rOzU3WB3SpQsjQaGcd7lpiN0kX1g62BIe+hx2PFjAXXEiw
 QJHH3+12WkCO3GP9ULDohXRG3r1Db8Y/MpIjTC5m3RHQykI/FwpCYRMICjUPHztuIwU1
 gzpH8lCCUJTg0wO7GukPnhEzu8gOJ6zYxNPA+Dq8bF1kUa0qQg+i81BxSILfRcnuRBxq
 jfjCLhzyZN9Oz2uR1ZRgX1D7P60nP0GkZJt47yEXi2FMjCUfS95uhqXN0qvHDD7HnZd7
 2ehcjtpLHEt2Jb3BbA/w3V/y9fXQqnt34f2eRTumWjgMamsSAGUmAnV8DDXZLZCUD4j0
 4stA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713795524; x=1714400324;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HEjrY/tHBtAmdIxQI2YcasxXeb63ob1ZNEbW9sS8ch0=;
 b=mjDdMLyXysrRyaGWxSO7VXj0zsB33i8G9MAuybuRse/ZZFxhxwChGm4W0lKg0Zyk/x
 EPtZY4MtMoDdtuYrrkJoNR7twWavVp12tzbzIvnVbyciId8VkEh5tvtIyQlJ6Uw5+6Gu
 omRK5LOh9OfydgQhUuhfjT609q4PXBQKllNN2S4uK1ufc+ByblxBb9vI7h7s1pVGIzJt
 5HFgxxQ4kJwVmbbveCqPWnTsZ5nLoCi3+rgmsqwvBr6WLRBfb6y9gk4JoP2JrEIOycYK
 1asaY/d/SprLgdjb1nPYJ1KKHMaAZqCdmXZD5Lt2rCDQkf84mGkldxYHBQb4XL07bRat
 /RaA==
X-Gm-Message-State: AOJu0YyUTFFFXY50kWeJPNGyYSOszqLF/OPmuVGgvp2n6iz7rdoRPjoQ
 yCQOEnpvqxiYcoD88yVjpxkVYbmnxA8wTIlvKRR+VxCg8OOroUOTLImMcxqw5fRdQLCN8iLPXPY
 lCB7jaNfafX71dBbu2QVznWh9bCVvSe8M2WFvyPZ7eVUkf845
X-Google-Smtp-Source: AGHT+IEHUxRmNXWelaByC2p51CgLZHa67QGjHRPevG9ItqQ33L/rVhDejF1DVvkYKEAuat/flZIkZsToITcdJD0lY4w=
X-Received: by 2002:a17:906:fcb1:b0:a58:7239:4cf2 with SMTP id
 qw17-20020a170906fcb100b00a5872394cf2mr374835ejb.52.1713795524280; Mon, 22
 Apr 2024 07:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240422135116.53247-1-andrew@daynix.com>
In-Reply-To: <20240422135116.53247-1-andrew@daynix.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Mon, 22 Apr 2024 16:52:24 +0300
Message-ID: <CABcq3pG0n81jNV+0RMnrxNFTTXL=BnVq8aEhv9Uu7rOJFauR=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ebpf: Added traces back. Changed source set for
 eBPF to 'system'.
To: jasowang@redhat.com, yuri.benditovich@daynix.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::631;
 envelope-from=andrew@daynix.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hello, everyone.
Was added missed "trace.h"

Best regards.

On Mon, Apr 22, 2024 at 5:17=E2=80=AFPM Andrew Melnychenko <andrew@daynix.c=
om> wrote:
>
> There was an issue with Qemu build with "--disable-system".
> The traces could be generated and the build fails.
> The traces were 'cut out' for previous patches, and overall,
> the 'system' source set should be used like in pre-'eBPF blob' patches.
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>  ebpf/ebpf_rss.c  | 7 +++++++
>  ebpf/meson.build | 2 +-
>  ebpf/trace.h     | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)
>  create mode 100644 ebpf/trace.h
>
> diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
> index d102f3dd092..87f0714910e 100644
> --- a/ebpf/ebpf_rss.c
> +++ b/ebpf/ebpf_rss.c
> @@ -25,6 +25,8 @@
>  #include "ebpf/rss.bpf.skeleton.h"
>  #include "ebpf/ebpf.h"
>
> +#include "trace.h"
> +
>  void ebpf_rss_init(struct EBPFRSSContext *ctx)
>  {
>      if (ctx !=3D NULL) {
> @@ -55,18 +57,21 @@ static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
>                                     PROT_READ | PROT_WRITE, MAP_SHARED,
>                                     ctx->map_configuration, 0);
>      if (ctx->mmap_configuration =3D=3D MAP_FAILED) {
> +        trace_ebpf_error("eBPF RSS", "can not mmap eBPF configuration ar=
ray");
>          return false;
>      }
>      ctx->mmap_toeplitz_key =3D mmap(NULL, qemu_real_host_page_size(),
>                                     PROT_READ | PROT_WRITE, MAP_SHARED,
>                                     ctx->map_toeplitz_key, 0);
>      if (ctx->mmap_toeplitz_key =3D=3D MAP_FAILED) {
> +        trace_ebpf_error("eBPF RSS", "can not mmap eBPF toeplitz key");
>          goto toeplitz_fail;
>      }
>      ctx->mmap_indirections_table =3D mmap(NULL, qemu_real_host_page_size=
(),
>                                     PROT_READ | PROT_WRITE, MAP_SHARED,
>                                     ctx->map_indirections_table, 0);
>      if (ctx->mmap_indirections_table =3D=3D MAP_FAILED) {
> +        trace_ebpf_error("eBPF RSS", "can not mmap eBPF indirection tabl=
e");
>          goto indirection_fail;
>      }
>
> @@ -108,12 +113,14 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
>
>      rss_bpf_ctx =3D rss_bpf__open();
>      if (rss_bpf_ctx =3D=3D NULL) {
> +        trace_ebpf_error("eBPF RSS", "can not open eBPF RSS object");
>          goto error;
>      }
>
>      bpf_program__set_type(rss_bpf_ctx->progs.tun_rss_steering_prog, BPF_=
PROG_TYPE_SOCKET_FILTER);
>
>      if (rss_bpf__load(rss_bpf_ctx)) {
> +        trace_ebpf_error("eBPF RSS", "can not load RSS program");
>          goto error;
>      }
>
> diff --git a/ebpf/meson.build b/ebpf/meson.build
> index c5bf9295a20..bff6156f518 100644
> --- a/ebpf/meson.build
> +++ b/ebpf/meson.build
> @@ -1 +1 @@
> -common_ss.add(when: libbpf, if_true: files('ebpf.c', 'ebpf_rss.c'), if_f=
alse: files('ebpf_rss-stub.c'))
> +system_ss.add(when: libbpf, if_true: files('ebpf.c', 'ebpf_rss.c'), if_f=
alse: files('ebpf_rss-stub.c'))
> diff --git a/ebpf/trace.h b/ebpf/trace.h
> new file mode 100644
> index 00000000000..abefc46ab10
> --- /dev/null
> +++ b/ebpf/trace.h
> @@ -0,0 +1 @@
> +#include "trace/trace-ebpf.h"
> --
> 2.44.0
>

