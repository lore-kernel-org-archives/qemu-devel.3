Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259DFCA0EED
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 06:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqQsf-0008T6-Sl; Mon, 25 Aug 2025 02:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqQsd-0008SW-R1
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 02:40:35 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqQsa-00058p-Jb
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 02:40:35 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-61c325a4d18so2798605a12.0
 for <qemu-devel@nongnu.org>; Sun, 24 Aug 2025 23:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756104027; x=1756708827; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNLyJ6pKs3Dl7uFCsBXk8Xnojnmb0ojvB8uY6u5ID6E=;
 b=f3YGZaMJ6SzUWGipbNEqkxpCX95H+e1+tIWDtKZSoRXFXcjGOKwvEkVzdXr2HUosPU
 PoX7mBeQ1YeXKCtym2iDCP339hOfFdkyDPAtndgcYNRfw8YswO6E04Y19reOW0o57kue
 Cd4qFgDBU9UDlqMzPOW5X/6w60cZIh1orbFo2OX6QaWwWhmPCwQfOmcR8NRvMvOP5NUZ
 28P/z5VURjXQZWtXqfe/Fvf53Ig+UUtLQZrYZ/0b/uyn/Jk9V/fNqkCqvjwC+GYz7NFe
 ObzfwQtzcWehKkiHbk+hJKJvIqQ28f4J21QNhtViskTvItGS2eVTVTIOQwmclUf6ML8I
 KvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756104027; x=1756708827;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aNLyJ6pKs3Dl7uFCsBXk8Xnojnmb0ojvB8uY6u5ID6E=;
 b=XkWyVqkVvZNe8z0ebJ881fFfvjnuUT6fYdEZIxHZ0NSPcsgtjuHC8TOBh8Zhd2Chts
 zIgBj7h+Efm+PfRKxg4mgG2r35ppAlDUsZeOjrU93b0XvPGI/RR9RAOTZteUhM/W2igo
 xzlQFba0G6hHiQpzKNbAb36Z9vmaLtL/GLP+EcG2JI4YQpGb29ywDvR9oTGXTngEYduu
 SsrhIr6V7bJP6UP1XVzII0X7faaDJQNW2J1l1yCw300fel6G0KPVQ5UmLxnkR7JST+KI
 alGkcA61kOxy6BaiQsNQBMeFWTuYJzh2ZekKQNSW7N3p950rMnkbC+mj21MvJzzlqGfz
 w69w==
X-Gm-Message-State: AOJu0YzzGaXGCrMUwi8zzI5JBUkQxTHr165Z9jrTLb6ZA4oHOQLEVsBU
 iTiQvC/o3NAIp3EW9GWg9rhA8Dksl6S52x2z9EQhp2amW28whbH5WfF9ufFZS7mUq5bW+kD64sc
 GvmRpH4dN9klEEqo/RewOIJRa8uJWlHMryw4BZqCohw==
X-Gm-Gg: ASbGncu4/Yt7omTCD/8Osg3ukw4ZDYnR7pOz55PxpAjkiu0H2O4/iVAOqWX/saebQ3t
 Yz1FyF6jTSc8Dz9nHLwNc99sZmVHSJqgAl4lEfRsPachSOkICs0Qmy2zNSR4+S2K7us20idVllf
 lzvEXRY9o6MGN1uEUt4s3nJOOL/Q2fp5FtF6w4r5wCGnpDMCH0q4vB0SoMcWRWr6AGM8oGhER0p
 Y2ZuykTej0hBIbufV8=
X-Google-Smtp-Source: AGHT+IG+KfdIguG4Yjz/WcZlCD9UfD7DdlKtZkIImOPF2LMoQTDlSSrkGBioEgNBmBngAeGtLIJcMmeFr3iNiWFgRwM=
X-Received: by 2002:a05:6402:5192:b0:61c:3848:8a51 with SMTP id
 4fb4d7f45d1cf-61c3857cf1emr6029289a12.37.1756104027405; Sun, 24 Aug 2025
 23:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-2-pbonzini@redhat.com>
In-Reply-To: <20250822122655.1353197-2-pbonzini@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 25 Aug 2025 09:40:00 +0300
X-Gm-Features: Ac12FXx_zk9ZBUOpH0aU25xT3UvzefFjiZCmhJsja5Es-MC9US5SeJ661EqajmI
Message-ID: <CAAjaMXZbYXTiy5jQ-iNrWersX8Ggdd6M7FhrOUYvt6hjY4PbRA@mail.gmail.com>
Subject: Re: [PATCH 01/14] treewide: write "unsigned long int" instead of
 "long unsigned int"
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tanishdesai37@gmail.com, stefanha@redhat.com, 
 berrange@redhat.com, mads@ynddal.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52b.google.com
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
> Putting "unsigned" in anything but the first position is weird.  As such,
> tracetool's Rust type conversion will not support it.  Remove it from
> the whole of QEMU's source code, not just trace-events.
>

Hm weird C quirk indeed.

Why can't tracetool support this? Can't we just add the permutations
in the C_TO_RUST_TYPE_MAP dict in "[PATCH 06/14] tracetool: Add Rust
format support"?

+    "unsigned long long": "std::ffi::c_ulonglong",
+    "long unsigned long": "std::ffi::c_ulonglong",
+    "long long unsigned": "std::ffi::c_ulonglong",



> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  crypto/pbkdf-gcrypt.c        | 2 +-
>  crypto/pbkdf-gnutls.c        | 2 +-
>  crypto/pbkdf-nettle.c        | 2 +-
>  hw/display/exynos4210_fimd.c | 2 +-
>  hw/misc/imx7_src.c           | 4 ++--
>  hw/net/can/can_sja1000.c     | 4 ++--
>  hw/xen/trace-events          | 4 ++--
>  7 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/crypto/pbkdf-gcrypt.c b/crypto/pbkdf-gcrypt.c
> index e89b8b1c768..f93996f674c 100644
> --- a/crypto/pbkdf-gcrypt.c
> +++ b/crypto/pbkdf-gcrypt.c
> @@ -66,7 +66,7 @@ int qcrypto_pbkdf2(QCryptoHashAlgo hash,
>      if (iterations > ULONG_MAX) {
>          error_setg_errno(errp, ERANGE,
>                           "PBKDF iterations %llu must be less than %lu",
> -                         (long long unsigned)iterations, ULONG_MAX);
> +                         (unsigned long long)iterations, ULONG_MAX);
>          return -1;
>      }
>
> diff --git a/crypto/pbkdf-gnutls.c b/crypto/pbkdf-gnutls.c
> index f34423f918b..46a3a869994 100644
> --- a/crypto/pbkdf-gnutls.c
> +++ b/crypto/pbkdf-gnutls.c
> @@ -62,7 +62,7 @@ int qcrypto_pbkdf2(QCryptoHashAlgo hash,
>      if (iterations > ULONG_MAX) {
>          error_setg_errno(errp, ERANGE,
>                           "PBKDF iterations %llu must be less than %lu",
> -                         (long long unsigned)iterations, ULONG_MAX);
> +                         (unsigned long long)iterations, ULONG_MAX);
>          return -1;
>      }
>
> diff --git a/crypto/pbkdf-nettle.c b/crypto/pbkdf-nettle.c
> index 3ef9c1b52c4..3c8bbaf9f17 100644
> --- a/crypto/pbkdf-nettle.c
> +++ b/crypto/pbkdf-nettle.c
> @@ -66,7 +66,7 @@ int qcrypto_pbkdf2(QCryptoHashAlgo hash,
>      if (iterations > UINT_MAX) {
>          error_setg_errno(errp, ERANGE,
>                           "PBKDF iterations %llu must be less than %u",
> -                         (long long unsigned)iterations, UINT_MAX);
> +                         (unsigned long long)iterations, ULONG_MAX);
>          return -1;
>      }
>
> diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
> index c61e0280a7c..5632aa1388c 100644
> --- a/hw/display/exynos4210_fimd.c
> +++ b/hw/display/exynos4210_fimd.c
> @@ -1380,7 +1380,7 @@ static void exynos4210_fimd_write(void *opaque, hwa=
ddr offset,
>      uint32_t old_value;
>
>      DPRINT_L2("write offset 0x%08x, value=3D%llu(0x%08llx)\n", offset,
> -            (long long unsigned int)val, (long long unsigned int)val);
> +            (unsigned long long)val, (unsigned long long)val);
>
>      switch (offset) {
>      case FIMD_VIDCON0:
> diff --git a/hw/misc/imx7_src.c b/hw/misc/imx7_src.c
> index df0b0a69057..817c95bf65b 100644
> --- a/hw/misc/imx7_src.c
> +++ b/hw/misc/imx7_src.c
> @@ -169,7 +169,7 @@ static void imx7_src_write(void *opaque, hwaddr offse=
t, uint64_t value,
>  {
>      IMX7SRCState *s =3D (IMX7SRCState *)opaque;
>      uint32_t index =3D offset >> 2;
> -    long unsigned int change_mask;
> +    uint32_t change_mask;
>      uint32_t current_value =3D value;
>
>      if (index >=3D SRC_MAX) {
> @@ -180,7 +180,7 @@ static void imx7_src_write(void *opaque, hwaddr offse=
t, uint64_t value,
>
>      trace_imx7_src_write(imx7_src_reg_name(SRC_A7RCR0), s->regs[SRC_A7RC=
R0]);
>
> -    change_mask =3D s->regs[index] ^ (uint32_t)current_value;
> +    change_mask =3D s->regs[index] ^ current_value;
>
>      switch (index) {
>      case SRC_A7RCR0:
> diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
> index 5b6ba9df6c4..545c520c3b4 100644
> --- a/hw/net/can/can_sja1000.c
> +++ b/hw/net/can/can_sja1000.c
> @@ -750,8 +750,8 @@ uint64_t can_sja_mem_read(CanSJA1000State *s, hwaddr =
addr, unsigned size)
>              break;
>          }
>      }
> -    DPRINTF("read addr 0x%02x, %d bytes, content 0x%02lx\n",
> -            (int)addr, size, (long unsigned int)temp);
> +    DPRINTF("read addr 0x%02x, %d bytes, content 0x%02x\n",
> +            (int)addr, size, (unsigned)temp);
>
>      return temp;
>  }
> diff --git a/hw/xen/trace-events b/hw/xen/trace-events
> index b67942d07b4..3b71ee641ff 100644
> --- a/hw/xen/trace-events
> +++ b/hw/xen/trace-events
> @@ -57,8 +57,8 @@ cpu_ioreq_config_read(void *req, uint32_t sbdf, uint32_=
t reg, uint32_t size, uin
>  cpu_ioreq_config_write(void *req, uint32_t sbdf, uint32_t reg, uint32_t =
size, uint32_t data) "I/O=3D%p sbdf=3D0x%x reg=3D%u size=3D%u data=3D0x%x"
>  cpu_get_ioreq_from_shared_memory_req_not_ready(int state, int data_is_pt=
r, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O reques=
t not ready: 0x%x, ptr: 0x%x, port: 0x%"PRIx64", data: 0x%"PRIx64", count: =
%u, size: %u"
>  xen_main_loop_prepare_init_cpu(int id, void *cpu) "cpu_by_vcpu_id[%d]=3D=
%p"
> -xen_map_ioreq_server_shared_page(long unsigned int ioreq_pfn) "shared pa=
ge at pfn 0x%lx"
> -xen_map_ioreq_server_buffered_io_page(long unsigned int ioreq_pfn) "buff=
ered io page at pfn 0x%lx"
> +xen_map_ioreq_server_shared_page(unsigned long int ioreq_pfn) "shared pa=
ge at pfn 0x%lx"
> +xen_map_ioreq_server_buffered_io_page(unsigned long int ioreq_pfn) "buff=
ered io page at pfn 0x%lx"
>  xen_map_ioreq_server_buffered_io_evtchn(int bufioreq_evtchn) "buffered i=
o evtchn is 0x%x"
>  destroy_hvm_domain_cannot_acquire_handle(void) "Cannot acquire xenctrl h=
andle"
>  destroy_hvm_domain_failed_action(const char *action, int sts, char *errn=
o_s) "xc_domain_shutdown failed to issue %s, sts %d, %s"
> --
> 2.50.1
>
>

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

