Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAAB4CD3423
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 16:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIqep-0006pQ-Qe; Fri, 01 May 2026 12:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamedaymanworkspace@gmail.com>)
 id 1wIqen-0006p1-Ol
 for qemu-devel@nongnu.org; Fri, 01 May 2026 12:24:01 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mohamedaymanworkspace@gmail.com>)
 id 1wIqel-0006v6-25
 for qemu-devel@nongnu.org; Fri, 01 May 2026 12:24:01 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-40946982a78so852903fac.2
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 09:23:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777652638; cv=none;
 d=google.com; s=arc-20240605;
 b=H3fSnGyU2Aopecq3r9FpqW9zZFQU8vXkcUyH1u52rgB0/NzhEBDhGjdDiScE8MgVBu
 jwIfJzy+tHcqTOjIJa4SJdjt7yMCedAhg01ePpKfB9i4wCgPYZJl9eGYxDvecXaVKgFn
 k1s5Mi+0i6+G5m0WfL1WLnC2UVrKMg1KOR30hY1vW/qX2UgqMiRHZLR2k4JdAC0Z2I3D
 bUKov7KCQSFXvuLO8tRX0XQWkRHs82ycFUrOYK8ANZ8OHx7T5iVBnv7yn6CyJ504txQj
 N63BGEVuBbtOTTM5D7ziJCbXIR6dzhPxe3JfWE2IMGRmd4X1kYWEKnd8s7XzQijJKrMh
 Jwiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ga+zPIhmaSQezr93rr/R5HfGmV9wyQ0JthZlaEd3mFE=;
 fh=Ri1P0IvMKhm9dR44NIDPoog2Q4oDuqqMhchhVpwJv7E=;
 b=gtOSumnlCzoUEx2asvf84/SK9cOqrTebds9dg9LsKidd2cOK0LjV481Ki1a/V3xZuU
 Cv9fCiHUk1vYkokpF405y7eTqg9TpOsBp9fBzwMhkibqQ7jEByAOKsuPAdS6wXVo1DwU
 8Vm3eI6KjkRXTyeDk8coXCx+0YUFmCz3l3KxHhA6pcATDzaiutIUozUVfjjmFGiipZvK
 7j+X25/TSFT7XBcWybUxCyf+YKgG0+zzxICGwj/X6z0csF80rsGGf3uKQf7l6ulIKK2H
 AiwzGedPeEXZUYw6H58F1lahc0TQQqdnLfm0Kw1IMzUKL6D6Fzj6Pal8Hsn78DOc8ZYB
 2UOQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777652638; x=1778257438; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ga+zPIhmaSQezr93rr/R5HfGmV9wyQ0JthZlaEd3mFE=;
 b=j7X2zEP9IJOUAPvby1CM9GTn1YA5UW9htyawzDjybOlIvnG9uJvr0BI4AMW5Ph7mpw
 yZM4TP5P3AeUJhwEWQIyLhkmImt4aowy1PeU2+IYKnkeI/zqEWqqJddEooNNfp59SRHb
 wom4datwarjrWnaXxyX+UQclG/Q9fZa2VZ2m9gDo5TfDk7naaXCo7XYkX96BqY7XmAmk
 vq3BLeGaxZbOEpGSvquMSJxvsOd8VgojgeD9jYWuEBFr0ttH8O9GwsjPI2wYh+1NxDbk
 ggI1Mpl3GgzhN7IYudsnGXtNP00djGJxOyGTBC7sOMUmthNmP+xrfg/rOGXf1qz4MQDd
 fTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777652638; x=1778257438;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ga+zPIhmaSQezr93rr/R5HfGmV9wyQ0JthZlaEd3mFE=;
 b=COBeMVDghJVUMoK/1LAHMINAXd8Nw3owIYf1r0WdQIhoTYmXvR6j+AkNOgwfpHGuph
 3ZIMZpMWDkgS2MmG3xsk3Jb4i9Fa37db2u2zIjNVwtnTMOe1f8uDeS8sViI+rdYXSEZy
 L8rTGsG8LKwUTdWVUImA6/FK/3IY/NMkCdWdT2IbVaPiJoyXtnIEaJBhxMW2PHAcgsIg
 tCTnLdQuobO1/WdmAzdGetIDCQ/dcbPzEx1jBlY+h/+kF0sJ8VqTUUrLmTb/wCnITx4T
 PEurxoKvZ8NBBrpipsU7jwH2nO3ocIHeaw4rmxIgTLQ4RqfeOe77BbD42Aln6MabvXc7
 cfkQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vk8khxWIYBC/MqPSdNEz+TIB7BEmpbf+dMEQ1/YiGXzb0/TdJ2HxBBpBSvg6xc/SC1uPq7nLQSa3K@nongnu.org
X-Gm-Message-State: AOJu0YxkPbxfaYJ8Hu3Y5cVC0ZeBDYbepRK95F/gSfgBl/fkavmKT+Xv
 gvmU3XbRweyIlkWlj8UZei+hNSR6VswsbAorDX7q+PcHuW7x/dSfdYK1DkchfJjlxdyfylPiNwL
 Kx3nbKe1zMdDFhcOax6xQvCX85VC0lxg=
X-Gm-Gg: AeBDietpapSi5+CrEYO3/6Fb1mE6wQa/KlYIL+i028nNcMzgl7aTjO1EtauArBvFa7o
 5m+tJFBDjbmCG5NpjSSGHWodWgBHLt9xImozH1YE75LY7PSQytSAgErLtM6QfnM4Fk4lni+Obzi
 MsT5Dt+OA2Os3Kzfz1a8k846viaCiDPGY+y+SWMXgysX9iXI5M0nFKmNrglFBlOkfvCrPu61K4R
 JcG7qWfGdf/GlJhAI5l9WCwVLLpefm/sDRtItHyhAZ4oVwahu1u51OZSO2abz7O/Eej323UP4pG
 Tvr4C6t2oswLQONv9f7YSh26yxSBmLDJHp2CKctMR8cRrzVb1Gt301Pez1M3JjY=
X-Received: by 2002:a05:6870:326c:b0:430:2e5:df00 with SMTP id
 586e51a60fabf-4347607c128mr135217fac.9.1777652637374; Fri, 01 May 2026
 09:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260430162941.584960-1-mohamedaymanworkspace@gmail.com>
 <20260501161106.818373-1-mohamedaymanworkspace@gmail.com>
In-Reply-To: <20260501161106.818373-1-mohamedaymanworkspace@gmail.com>
From: MOHAMED AYMAN <mohamedaymanworkspace@gmail.com>
Date: Fri, 1 May 2026 19:23:45 +0300
X-Gm-Features: AVHnY4KB2RQALlpxFEmcteZd3g1MfOnyaFF5K4rRtR61BtJO8m-9nK62AhsBYlo
Message-ID: <CABWZVhocw-5+RmijZVdOvfCJQfLw3pe+Td+wbgoT48yUQh69QQ@mail.gmail.com>
Subject: Re: [PATCH v2] bsd-user: remove cached host page size and rely on
 qemu_real_host_page_size()
To: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=mohamedaymanworkspace@gmail.com; helo=mail-oa1-x30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Warner and Peter,

Thanks for the review. :)

Here is v2 addressing your comments:

- Fixed the duplicate HOST_PAGE_MASK definition
- HOST_PAGE_SIZE now uses:
MAX(qemu_real_host_page_size(), TARGET_PAGE_SIZE)

This preserves correct behavior for cases where the target page size
exceeds the host page size (e.g. aarch64 16K pages on a 4K amd64 host)

- Updated the commit message to clarify behavior and remove the incorrect
"No functional change intended" wording

Regarding your question, I am not currently using bsd-user in production;
this started as a cleanup/contribution effort while working through the cod=
e.

Thanks again for the feedback.

Mohamed Ayman

On Fri, May 1, 2026 at 7:11=E2=80=AFPM Mohamed Ayman
<mohamedaymanworkspace@gmail.com> wrote:
>
> The bsd-user implementation previously cached host page size and mask
> in global variables (qemu_host_page_size and qemu_host_page_mask),
> which duplicated information already available through
> qemu_real_host_page_size().
>
> This introduced unnecessary global state and potential inconsistencies
> if the host page size is queried or changes during initialization.
>
> Replace all usages of qemu_host_page_size and qemu_host_page_mask with
> HOST_PAGE_SIZE and HOST_PAGE_MASK macros defined as:
>
>   MAX(qemu_real_host_page_size(), TARGET_PAGE_SIZE)
>
> This preserves the original behavior where the effective host page size
> is the maximum of the real host page size and the target page size,
> which matters on targets like aarch64 with 16K pages running on an
> amd64 host with 4K pages.
>
> This also opens the way for renaming qemu_real_host_page_size() to
> qemu_host_page_size() now that the bsd-user globals no longer occupy
> that name.
>
> Signed-off-by: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
> ---
>  bsd-user/elfload.c |  25 ++---------
>  bsd-user/main.c    |  14 ++-----
>  bsd-user/mmap.c    | 102 ++++++++++++++++-----------------------------
>  bsd-user/qemu.h    |  10 ++---
>  4 files changed, 46 insertions(+), 105 deletions(-)
>
> diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
> index 3bca0cc9ed..00250fc3c1 100644
> --- a/bsd-user/elfload.c
> +++ b/bsd-user/elfload.c
> @@ -192,14 +192,14 @@ static void setup_arg_pages(struct bsd_binprm *bprm=
, struct image_info *info,
>       */
>      size =3D target_dflssiz;
>      stack_base =3D TARGET_USRSTACK - size;
> -    addr =3D target_mmap(stack_base , size + qemu_host_page_size,
> +    addr =3D target_mmap(stack_base , size + HOST_PAGE_SIZE,
>              PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
>      if (addr =3D=3D -1) {
>          perror("stk mmap");
>          exit(-1);
>      }
>      /* we reserve one extra page at the top of the stack as guard */
> -    target_mprotect(addr + size, qemu_host_page_size, PROT_NONE);
> +    target_mprotect(addr + size, HOST_PAGE_SIZE, PROT_NONE);
>
>      target_stksiz =3D size;
>      target_stkbas =3D addr;
> @@ -239,27 +239,10 @@ static void padzero(abi_ulong elf_bss, abi_ulong la=
st_bss)
>          return;
>      }
>
> -    /*
> -     * XXX: this is really a hack : if the real host page size is
> -     * smaller than the target page size, some pages after the end
> -     * of the file may not be mapped. A better fix would be to
> -     * patch target_mmap(), but it is more complicated as the file
> -     * size must be known.
> -     */
> -    if (qemu_real_host_page_size() < qemu_host_page_size) {
> -        abi_ulong end_addr, end_addr1;
> -        end_addr1 =3D REAL_HOST_PAGE_ALIGN(elf_bss);
> -        end_addr =3D HOST_PAGE_ALIGN(elf_bss);
> -        if (end_addr1 < end_addr) {
> -            mmap((void *)g2h_untagged(end_addr1), end_addr - end_addr1,
> -                 PROT_READ | PROT_WRITE | PROT_EXEC,
> -                 MAP_FIXED | MAP_PRIVATE | MAP_ANON, -1, 0);
> -        }
> -    }
>
> -    nbyte =3D elf_bss & (qemu_host_page_size - 1);
> +    nbyte =3D elf_bss & (HOST_PAGE_SIZE - 1);
>      if (nbyte) {
> -        nbyte =3D qemu_host_page_size - nbyte;
> +        nbyte =3D HOST_PAGE_SIZE - nbyte;
>          do {
>              /* FIXME - what to do if put_user() fails? */
>              put_user_u8(0, elf_bss);
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index 73aae8c327..3f5141e794 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -54,11 +54,6 @@
>  #include "target_arch_cpu.h"
>
>
> -/*
> - * TODO: Remove these and rely only on qemu_real_host_page_size().
> - */
> -uintptr_t qemu_host_page_size;
> -intptr_t qemu_host_page_mask;
>
>  static bool opt_one_insn_per_tb;
>  static unsigned long opt_tb_size;
> @@ -302,8 +297,6 @@ int main(int argc, char **argv)
>          (void) envlist_setenv(envlist, *wrk);
>      }
>
> -    qemu_host_page_size =3D getpagesize();
> -    qemu_host_page_size =3D MAX(qemu_host_page_size, TARGET_PAGE_SIZE);
>
>      cpu_model =3D NULL;
>
> @@ -405,7 +398,6 @@ int main(int argc, char **argv)
>          }
>      }
>
> -    qemu_host_page_mask =3D -qemu_host_page_size;
>
>      /* init debug */
>      {
> @@ -452,7 +444,7 @@ int main(int argc, char **argv)
>
>      cpu_type =3D parse_cpu_option(cpu_model);
>
> -    /* init tcg before creating CPUs and to get qemu_host_page_size */
> +    /* init tcg before creating CPUs */
>      {
>          AccelState *accel =3D current_accel();
>          AccelClass *ac =3D ACCEL_GET_CLASS(accel);
> @@ -534,7 +526,7 @@ int main(int argc, char **argv)
>       * proper page alignment for guest_base.
>       */
>      if (have_guest_base) {
> -        if (guest_base & ~qemu_host_page_mask) {
> +        if (guest_base & ~HOST_PAGE_MASK) {
>              error_report("Selected guest base not host page aligned");
>              exit(1);
>          }
> @@ -573,7 +565,7 @@ int main(int argc, char **argv)
>          /* Ensure that mmap_next_start is within range. */
>          if (reserved_va <=3D mmap_next_start) {
>              mmap_next_start =3D (reserved_va / 4 * 3)
> -                              & TARGET_PAGE_MASK & qemu_host_page_mask;
> +                              & TARGET_PAGE_MASK & HOST_PAGE_MASK;
>          }
>      }
>
> diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
> index fe77eceb48..59c70083a4 100644
> --- a/bsd-user/mmap.c
> +++ b/bsd-user/mmap.c
> @@ -84,7 +84,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int=
 prot)
>          return 0;
>
>      mmap_lock();
> -    host_start =3D start & qemu_host_page_mask;
> +    host_start =3D start & HOST_PAGE_MASK;
>      host_end =3D HOST_PAGE_ALIGN(end);
>      if (start > host_start) {
>          /* handle host page containing start */
> @@ -92,28 +92,28 @@ int target_mprotect(abi_ulong start, abi_ulong len, i=
nt prot)
>          for (addr =3D host_start; addr < start; addr +=3D TARGET_PAGE_SI=
ZE) {
>              prot1 |=3D page_get_flags(addr);
>          }
> -        if (host_end =3D=3D host_start + qemu_host_page_size) {
> +        if (host_end =3D=3D host_start + HOST_PAGE_SIZE) {
>              for (addr =3D end; addr < host_end; addr +=3D TARGET_PAGE_SI=
ZE) {
>                  prot1 |=3D page_get_flags(addr);
>              }
>              end =3D host_end;
>          }
>          ret =3D mprotect(g2h_untagged(host_start),
> -                       qemu_host_page_size, prot1 & PAGE_RWX);
> +                       HOST_PAGE_SIZE, prot1 & PAGE_RWX);
>          if (ret !=3D 0)
>              goto error;
> -        host_start +=3D qemu_host_page_size;
> +        host_start +=3D HOST_PAGE_SIZE;
>      }
>      if (end < host_end) {
>          prot1 =3D prot;
>          for (addr =3D end; addr < host_end; addr +=3D TARGET_PAGE_SIZE) =
{
>              prot1 |=3D page_get_flags(addr);
>          }
> -        ret =3D mprotect(g2h_untagged(host_end - qemu_host_page_size),
> -                       qemu_host_page_size, prot1 & PAGE_RWX);
> +        ret =3D mprotect(g2h_untagged(host_end - HOST_PAGE_SIZE),
> +                       HOST_PAGE_SIZE, prot1 & PAGE_RWX);
>          if (ret !=3D 0)
>              goto error;
> -        host_end -=3D qemu_host_page_size;
> +        host_end -=3D HOST_PAGE_SIZE;
>      }
>
>      /* handle the pages in the middle */
> @@ -193,7 +193,7 @@ static int mmap_frag(abi_ulong real_start,
>      void *host_start;
>      int prot1, prot_new;
>
> -    real_end =3D real_start + qemu_host_page_size;
> +    real_end =3D real_start + HOST_PAGE_SIZE;
>      host_start =3D g2h_untagged(real_start);
>
>      /* get the protection of the target pages outside the mapping */
> @@ -205,7 +205,7 @@ static int mmap_frag(abi_ulong real_start,
>
>      if (prot1 =3D=3D 0) {
>          /* no page was there, so we allocate one. See also above. */
> -        void *p =3D mmap(host_start, qemu_host_page_size, prot,
> +        void *p =3D mmap(host_start, HOST_PAGE_SIZE, prot,
>                         flags | ((fd !=3D -1) ? MAP_ANON : 0), -1, 0);
>          if (p =3D=3D MAP_FAILED)
>              return -1;
> @@ -223,7 +223,7 @@ static int mmap_frag(abi_ulong real_start,
>
>          /* adjust protection to be able to read */
>          if (!(prot1 & PROT_WRITE))
> -            mprotect(host_start, qemu_host_page_size, prot1 | PROT_WRITE=
);
> +            mprotect(host_start, HOST_PAGE_SIZE, prot1 | PROT_WRITE);
>
>          /* read the corresponding file data */
>          if (!mmap_pread(fd, g2h_untagged(start), end - start, offset, tr=
ue)) {
> @@ -232,10 +232,10 @@ static int mmap_frag(abi_ulong real_start,
>
>          /* put final protection */
>          if (prot_new !=3D (prot1 | PROT_WRITE))
> -            mprotect(host_start, qemu_host_page_size, prot_new);
> +            mprotect(host_start, HOST_PAGE_SIZE, prot_new);
>      } else {
>          if (prot_new !=3D prot1) {
> -            mprotect(host_start, qemu_host_page_size, prot_new);
> +            mprotect(host_start, HOST_PAGE_SIZE, prot_new);
>          }
>          if (prot_new & PROT_WRITE) {
>              memset(g2h_untagged(start), 0, end - start);
> @@ -289,7 +289,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong si=
ze, abi_ulong alignment)
>      if (start =3D=3D 0) {
>          start =3D mmap_next_start;
>      } else {
> -        start &=3D qemu_host_page_mask;
> +        start &=3D HOST_PAGE_MASK;
>      }
>
>      size =3D HOST_PAGE_ALIGN(size);
> @@ -297,7 +297,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong si=
ze, abi_ulong alignment)
>      if (reserved_va) {
>          return mmap_find_vma_reserved(start, size,
>              (alignment !=3D 0 ? 1 << alignment :
> -             MAX(qemu_host_page_size, TARGET_PAGE_SIZE)));
> +             MAX(HOST_PAGE_SIZE, TARGET_PAGE_SIZE)));
>      }
>
>      addr =3D start;
> @@ -478,8 +478,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, =
int prot,
>          goto fail;
>      }
>
> -    real_start =3D start & qemu_host_page_mask;
> -    host_offset =3D offset & qemu_host_page_mask;
> +    real_start =3D start & HOST_PAGE_MASK;
> +    host_offset =3D offset & HOST_PAGE_MASK;
>
>      /*
>       * If the user is asking for the kernel to find a location, do that
> @@ -498,38 +498,6 @@ abi_long target_mmap(abi_ulong start, abi_ulong len,=
 int prot,
>          }
>      }
>
> -    /*
> -     * When mapping files into a memory area larger than the file, acces=
ses
> -     * to pages beyond the file size will cause a SIGBUS.
> -     *
> -     * For example, if mmaping a file of 100 bytes on a host with 4K pag=
es
> -     * emulating a target with 8K pages, the target expects to be able t=
o
> -     * access the first 8K. But the host will trap us on any access beyo=
nd
> -     * 4K.
> -     *
> -     * When emulating a target with a larger page-size than the hosts, w=
e
> -     * may need to truncate file maps at EOF and add extra anonymous pag=
es
> -     * up to the targets page boundary.
> -     */
> -
> -    if ((qemu_real_host_page_size() < qemu_host_page_size) && fd !=3D -1=
) {
> -        struct stat sb;
> -
> -        if (fstat(fd, &sb) =3D=3D -1) {
> -            goto fail;
> -        }
> -
> -        /* Are we trying to create a map beyond EOF?.  */
> -        if (offset + len > sb.st_size) {
> -            /*
> -             * If so, truncate the file map at eof aligned with
> -             * the hosts real pagesize. Additional anonymous maps
> -             * will be created beyond EOF.
> -             */
> -            len =3D REAL_HOST_PAGE_ALIGN(sb.st_size - offset);
> -        }
> -    }
> -
>      if (!(flags & MAP_FIXED)) {
>          unsigned long host_start;
>          void *p;
> @@ -539,8 +507,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, =
int prot,
>
>          /*
>           * Note: we prefer to control the mapping address. It is
> -         * especially important if qemu_host_page_size >
> -         * qemu_real_host_page_size
> +         * especially important if HOST_PAGE_SIZE >
> +         * TARGET_PAGE_SIZE
>           */
>          p =3D mmap(g2h_untagged(start), host_len, prot,
>                   flags | MAP_FIXED | ((fd !=3D -1) ? MAP_ANON : 0), -1, =
0);
> @@ -581,7 +549,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, =
int prot,
>           * aligned, so we read it
>           */
>          if (fd !=3D -1 &&
> -            (offset & ~qemu_host_page_mask) !=3D (start & ~qemu_host_pag=
e_mask)) {
> +            (offset & ~HOST_PAGE_MASK) !=3D (start & ~HOST_PAGE_MASK)) {
>              /*
>               * msync() won't work here, so we return an error if write i=
s
>               * possible while it is a shared mapping
> @@ -614,7 +582,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, =
int prot,
>
>          /* handle the start of the mapping */
>          if (start > real_start) {
> -            if (real_end =3D=3D real_start + qemu_host_page_size) {
> +            if (real_end =3D=3D real_start + HOST_PAGE_SIZE) {
>                  /* one single host page */
>                  ret =3D mmap_frag(real_start, start, end,
>                                  prot, flags, fd, offset);
> @@ -622,21 +590,21 @@ abi_long target_mmap(abi_ulong start, abi_ulong len=
, int prot,
>                      goto fail;
>                  goto the_end1;
>              }
> -            ret =3D mmap_frag(real_start, start, real_start + qemu_host_=
page_size,
> +            ret =3D mmap_frag(real_start, start, real_start + HOST_PAGE_=
SIZE,
>                              prot, flags, fd, offset);
>              if (ret =3D=3D -1)
>                  goto fail;
> -            real_start +=3D qemu_host_page_size;
> +            real_start +=3D HOST_PAGE_SIZE;
>          }
>          /* handle the end of the mapping */
>          if (end < real_end) {
> -            ret =3D mmap_frag(real_end - qemu_host_page_size,
> -                            real_end - qemu_host_page_size, end,
> +            ret =3D mmap_frag(real_end - HOST_PAGE_SIZE,
> +                            real_end - HOST_PAGE_SIZE, end,
>                              prot, flags, fd,
> -                            offset + real_end - qemu_host_page_size - st=
art);
> +                            offset + real_end - HOST_PAGE_SIZE - start);
>              if (ret =3D=3D -1)
>                  goto fail;
> -            real_end -=3D qemu_host_page_size;
> +            real_end -=3D HOST_PAGE_SIZE;
>          }
>
>          /* map the middle (easier) */
> @@ -676,7 +644,7 @@ void mmap_reserve(abi_ulong start, abi_ulong size)
>      abi_ulong end;
>      int prot;
>
> -    real_start =3D start & qemu_host_page_mask;
> +    real_start =3D start & HOST_PAGE_MASK;
>      real_end =3D HOST_PAGE_ALIGN(start + size);
>      end =3D start + size;
>      if (start > real_start) {
> @@ -685,14 +653,14 @@ void mmap_reserve(abi_ulong start, abi_ulong size)
>          for (addr =3D real_start; addr < start; addr +=3D TARGET_PAGE_SI=
ZE) {
>              prot |=3D page_get_flags(addr);
>          }
> -        if (real_end =3D=3D real_start + qemu_host_page_size) {
> +        if (real_end =3D=3D real_start + HOST_PAGE_SIZE) {
>              for (addr =3D end; addr < real_end; addr +=3D TARGET_PAGE_SI=
ZE) {
>                  prot |=3D page_get_flags(addr);
>              }
>              end =3D real_end;
>          }
>          if (prot !=3D 0) {
> -            real_start +=3D qemu_host_page_size;
> +            real_start +=3D HOST_PAGE_SIZE;
>          }
>      }
>      if (end < real_end) {
> @@ -701,7 +669,7 @@ void mmap_reserve(abi_ulong start, abi_ulong size)
>              prot |=3D page_get_flags(addr);
>          }
>          if (prot !=3D 0) {
> -            real_end -=3D qemu_host_page_size;
> +            real_end -=3D HOST_PAGE_SIZE;
>          }
>      }
>      if (real_start !=3D real_end) {
> @@ -727,7 +695,7 @@ int target_munmap(abi_ulong start, abi_ulong len)
>          return -EINVAL;
>      mmap_lock();
>      end =3D start + len;
> -    real_start =3D start & qemu_host_page_mask;
> +    real_start =3D start & HOST_PAGE_MASK;
>      real_end =3D HOST_PAGE_ALIGN(end);
>
>      if (start > real_start) {
> @@ -736,14 +704,14 @@ int target_munmap(abi_ulong start, abi_ulong len)
>          for (addr =3D real_start; addr < start; addr +=3D TARGET_PAGE_SI=
ZE) {
>              prot |=3D page_get_flags(addr);
>          }
> -        if (real_end =3D=3D real_start + qemu_host_page_size) {
> +        if (real_end =3D=3D real_start + HOST_PAGE_SIZE) {
>              for (addr =3D end; addr < real_end; addr +=3D TARGET_PAGE_SI=
ZE) {
>                  prot |=3D page_get_flags(addr);
>              }
>              end =3D real_end;
>          }
>          if (prot !=3D 0)
> -            real_start +=3D qemu_host_page_size;
> +            real_start +=3D HOST_PAGE_SIZE;
>      }
>      if (end < real_end) {
>          prot =3D 0;
> @@ -751,7 +719,7 @@ int target_munmap(abi_ulong start, abi_ulong len)
>              prot |=3D page_get_flags(addr);
>          }
>          if (prot !=3D 0)
> -            real_end -=3D qemu_host_page_size;
> +            real_end -=3D HOST_PAGE_SIZE;
>      }
>
>      ret =3D 0;
> @@ -784,6 +752,6 @@ int target_msync(abi_ulong start, abi_ulong len, int =
flags)
>      if (end =3D=3D start)
>          return 0;
>
> -    start &=3D qemu_host_page_mask;
> +    start &=3D HOST_PAGE_MASK;
>      return msync(g2h_untagged(start), end - start, flags);
>  }
> diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
> index b0b2c249fb..7553ac154c 100644
> --- a/bsd-user/qemu.h
> +++ b/bsd-user/qemu.h
> @@ -44,12 +44,10 @@ extern char **environ;
>  #include "accel/tcg/vcpu-state.h"
>
>  #include "qemu-os.h"
> -/*
> - * TODO: Remove these and rely only on qemu_real_host_page_size().
> - */
> -extern uintptr_t qemu_host_page_size;
> -extern intptr_t qemu_host_page_mask;
> -#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)
> +
> +#define HOST_PAGE_SIZE        MAX(qemu_real_host_page_size(), TARGET_PAG=
E_SIZE)
> +#define HOST_PAGE_MASK        ((intptr_t)~(HOST_PAGE_SIZE - 1))
> +#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), HOST_PAGE_SIZE)
>
>  /*
>   * This struct is used to hold certain information about the image.  Bas=
ically,
> --
> 2.34.1
>

