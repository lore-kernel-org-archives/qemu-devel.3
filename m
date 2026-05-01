Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61ABCCD13DA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 02:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIdsk-0007D3-3d; Thu, 30 Apr 2026 22:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wIdsi-0007Cd-1h
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 22:45:32 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wIdse-0002LH-1q
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 22:45:31 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-7baee75f874so22694087b3.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 19:45:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777603525; cv=none;
 d=google.com; s=arc-20240605;
 b=NEGRr0s1oH9RqvZtCjNbFRABkblA+N7sDkHv3oRsud015JOGj6VQEJt5U+HfdK4iCS
 QPpNc5AkYfPg9u/aWG6MWU5ObQNTCrLN3SuKjv8rfgtyLzT/fi035Zc17/7lMY9odGYW
 F0NfkIvYPZtEHQWb8QA1PsLyROL3q/ExI6lIztcQONgT4iaRafK9HP+6C6QlPb5KxCrs
 PB3O8dx5qltBwzihST35py3iA818LqJyT23QS2kC6ZhnLjdIWG5zIerc5qc7zai9FfzW
 mLbn+Lp2PLvJ6minoKcegiGxhvDHq/A86NWPP6Zi0em3Es+EdoZLezFBe1qBY5LUDS8A
 L0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NAGS0de9HuIcgnOg3X7Gb6jxgLOiyv8d+qV5WFxJq7I=;
 fh=hsNSekl5FsvnqnPJJH5n8DhXHXLtCVs7VnnE55BliBA=;
 b=PiOw2D7eFKL3OYBPSOcpw9xXQEjzgz3GwubZ2kYG/udNlKEJg2L4lSlY2ZjZJ68ZR+
 DZFs0V10DXepmbCJB0sxSp8v1SK2MA7Cefq5hQMuF3kd20TPHG47bBLvlq5Rdu87Gsfs
 +b8usmUZ8ExLo0fnjkDv1rXDSyPu8EGYbb8eSNnXs/Qp7I/eov5k7cCx0ana57aNB0Mb
 ixsgUuTSc5/4WR1AqQkeo+wogbNAium5XZaiwDjv7BIXgnqjqGzymkCfBgF2tmkoDNfX
 bQiXUJWuJDIxhr7fuaYjWunDW55lWeCVmgWNuFDIJNTNJOYw37eLlUhIgQoxm5ckoBOE
 2UsA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777603525; x=1778208325;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NAGS0de9HuIcgnOg3X7Gb6jxgLOiyv8d+qV5WFxJq7I=;
 b=rr6F/aORzqVDjhZwvuMJoXP74MpYHWXoRogPLrTR2kaKhAURhmtseqiWTdyaJ9Niv6
 fkD9BLERIL4xJsq3Ig0MjRaha+06XSQrYIE2A8+3cjBTNpJL+s34rPoGvXDB+9mrZZib
 Vdmf9DrrT2EKmpGdy/vHDIVZI8po5uDxRRmV6/JsRbw8KXeF1BlS65VaRYJ1uYOEFWFr
 2xV7eF4SksOnbjC1XHOC2ky5GSOe08ZnCCrHxnjIydANXYrj8aVbUiBhBceq46w7smcv
 SD3PwcePEYc1LMECj6B8FLLj36kd8KQ6vj2XTsp/vqgjdcOE5QgSFCFXE2yTBhVQ0c5F
 d5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777603525; x=1778208325;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAGS0de9HuIcgnOg3X7Gb6jxgLOiyv8d+qV5WFxJq7I=;
 b=XUWxy/IDmxBhEdZ45ROUt5DZdrFNrwCmmpc/3ZCFJBMdBDSUc9vun4kyKi4uEuwooe
 s3lJoRdcPQqAVlv6Wp4r7EYCfiSsaCA3xiKJDYmVzKWpowek0Ct2U9JnG6EM4IRxTqZ0
 FUzX8lq7SI+5ewgvKdj3NJDhaPCPPSvpvn/nxycozWLuerwuawS8e58jT9rugCp60eVR
 z1KXRJ1fYHVqsWVAQ7bTgPyhtJO27qdEvktgyQY/k924D79IMt+z+A+AUo2STyZ1XScD
 /Gfg4GrbjWKGWaxxMmJomZ6EkrVkcuS2ArcB2/8XXyu5/tG1P0QnzVcrY657bqDdhgOb
 BU0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ96nO7Y4DY1tXeRlIlbhX3UJos2pLNcUZrQ1q1Y1QIdce9rmqAY054/xm4NNvdcPmSHGoV1fPnJZiBT@nongnu.org
X-Gm-Message-State: AOJu0Yzv2DbWRzGirbyU2hfYcCubV5FMRke43k1IpQXsBI+ZckhRHjjn
 pjcVhn/kyEH7pCBUAmzEhSxXTJ0iCdZozbNjUhel+rVX/AC0qESXW6HMKlkrF9/NPaxZ3YXF99o
 ittNHB3+9E3uDSqlVuCQBOJnquOVfq77UBAXcQeo6fA==
X-Gm-Gg: AeBDies5FvftKXdlTHwkCuP4SPSsuZVrQuF+V97H/AQqEw8l93Hkyjjt3OWFSC6Kx/k
 szQNAbEGq4/R4aiXzDV7obydUQ62OiYPyRWd06XnOVgBc8XzbmMaxwE75McEwKtKRxv3CCvno3b
 DQZGxmRRd+UZByEgHAaN1bcDYAVcyr+lsueefqGDzykMqycqisVsirvF5QjV3jFEoAvRo/73cf4
 2rv1CMODSYD9Cn8aPb/G27+uzjTeMxHqY8YphV0gKCsqN4XqotW9m6K5j6KtaKgOK/X+LBiaXeG
 zOHLhNP2tl9hKNnL5w==
X-Received: by 2002:a05:690e:244f:b0:65c:308c:a157 with SMTP id
 956f58d0204a3-65c308cab87mr897448d50.12.1777603525275; Thu, 30 Apr 2026
 19:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260430162941.584960-1-mohamedaymanworkspace@gmail.com>
In-Reply-To: <20260430162941.584960-1-mohamedaymanworkspace@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 30 Apr 2026 20:45:10 -0600
X-Gm-Features: AVHnY4I7RHSvtR7o0fL3vaNY1U9kWX4aEwPXILN8gGYoAY4ZAsyLFivUQMH7JLE
Message-ID: <CANCZdfqCgsfagTSPPyU=pMOHLsCjN6KK52vWGoskS-L0dph4dg@mail.gmail.com>
Subject: Re: [PATCH] bsd-user: remove cached host page size and rely on
 qemu_real_host_page_size()
To: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
Cc: Kyle Evans <kevans@freebsd.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000ad03080650b8924b"
Received-SPF: none client-ip=2607:f8b0:4864:20::1129;
 envelope-from=wlosh@bsdimp.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000ad03080650b8924b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 10:29=E2=80=AFAM Mohamed Ayman <
mohamedaymanworkspace@gmail.com> wrote:

> The bsd-user implementation previously cached host page size and mask
> in global variables (qemu_host_page_size and qemu_host_page_mask),
> which duplicated information already available through
> qemu_real_host_page_size().
>
> This introduces unnecessary global state and potential inconsistencies
> if the host page size is queried or changes during initialization.
>
> Replace all usages of qemu_host_page_size and qemu_host_page_mask with
> qemu_real_host_page_size() and derived expressions, and update all
> alignment and masking logic accordingly.
>
> This simplifies the code and ensures a single source of truth for host
> page size handling across bsd-user memory management paths.
>
> No functional change intended.
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
,
> struct image_info *info,
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
> @@ -239,27 +239,10 @@ static void padzero(abi_ulong elf_bss, abi_ulong
> last_bss)
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

The commit message says it's a noop, but this looks like it does
something. aarch64 can have 16k pages, and binaries built for
that, and amd64 has 4k page sizes. I'm curious how that would work
out.


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
> @@ -84,7 +84,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int
> prot)
>          return 0;
>
>      mmap_lock();
> -    host_start =3D start & qemu_host_page_mask;
> +    host_start =3D start & HOST_PAGE_MASK;
>      host_end =3D HOST_PAGE_ALIGN(end);
>      if (start > host_start) {
>          /* handle host page containing start */
> @@ -92,28 +92,28 @@ int target_mprotect(abi_ulong start, abi_ulong len,
> int prot)
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
>          if (!mmap_pread(fd, g2h_untagged(start), end - start, offset,
> true)) {
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
> @@ -289,7 +289,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong
> size, abi_ulong alignment)
>      if (start =3D=3D 0) {
>          start =3D mmap_next_start;
>      } else {
> -        start &=3D qemu_host_page_mask;
> +        start &=3D HOST_PAGE_MASK;
>      }
>
>      size =3D HOST_PAGE_ALIGN(size);
> @@ -297,7 +297,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong
> size, abi_ulong alignment)
>      if (reserved_va) {
>          return mmap_find_vma_reserved(start, size,
>              (alignment !=3D 0 ? 1 << alignment :
> -             MAX(qemu_host_page_size, TARGET_PAGE_SIZE)));
> +             MAX(HOST_PAGE_SIZE, TARGET_PAGE_SIZE)));
>      }
>
>      addr =3D start;
> @@ -478,8 +478,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len,
> int prot,
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
> @@ -498,38 +498,6 @@ abi_long target_mmap(abi_ulong start, abi_ulong len,
> int prot,
>          }
>      }
>
> -    /*
> -     * When mapping files into a memory area larger than the file,
> accesses
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
> @@ -539,8 +507,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len,
> int prot,
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
> @@ -581,7 +549,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len,
> int prot,
>           * aligned, so we read it
>           */
>          if (fd !=3D -1 &&
> -            (offset & ~qemu_host_page_mask) !=3D (start &
> ~qemu_host_page_mask)) {
> +            (offset & ~HOST_PAGE_MASK) !=3D (start & ~HOST_PAGE_MASK)) {
>              /*
>               * msync() won't work here, so we return an error if write i=
s
>               * possible while it is a shared mapping
> @@ -614,7 +582,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len,
> int prot,
>
>          /* handle the start of the mapping */
>          if (start > real_start) {
> -            if (real_end =3D=3D real_start + qemu_host_page_size) {
> +            if (real_end =3D=3D real_start + HOST_PAGE_SIZE) {
>                  /* one single host page */
>                  ret =3D mmap_frag(real_start, start, end,
>                                  prot, flags, fd, offset);
> @@ -622,21 +590,21 @@ abi_long target_mmap(abi_ulong start, abi_ulong len=
,
> int prot,
>                      goto fail;
>                  goto the_end1;
>              }
> -            ret =3D mmap_frag(real_start, start, real_start +
> qemu_host_page_size,
> +            ret =3D mmap_frag(real_start, start, real_start +
> HOST_PAGE_SIZE,
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
> -                            offset + real_end - qemu_host_page_size -
> start);
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
> @@ -784,6 +752,6 @@ int target_msync(abi_ulong start, abi_ulong len, int
> flags)
>      if (end =3D=3D start)
>          return 0;
>
> -    start &=3D qemu_host_page_mask;
> +    start &=3D HOST_PAGE_MASK;
>      return msync(g2h_untagged(start), end - start, flags);
>  }
> diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
> index b0b2c249fb..41ac5e3eab 100644
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
> +#define HOST_PAGE_SIZE        qemu_real_host_page_size()
> +#define HOST_PAGE_MASK        (~(HOST_PAGE_SIZE - 1))
> +#define HOST_PAGE_MASK  ((intptr_t)~(HOST_PAGE_SIZE - 1))
>

HOST_PAGE_MASK appears to be defined twice.

As I said before, I love the direction here. Thanks for working it out.

Are you using bsd-user for anything?

Warner


>  /*
>   * This struct is used to hold certain information about the image.
> Basically,
> --
> 2.34.1
>
>

--000000000000ad03080650b8924b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 30,=
 2026 at 10:29=E2=80=AFAM Mohamed Ayman &lt;<a href=3D"mailto:mohamedaymanw=
orkspace@gmail.com">mohamedaymanworkspace@gmail.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">The bsd-user implementat=
ion previously cached host page size and mask<br>
in global variables (qemu_host_page_size and qemu_host_page_mask),<br>
which duplicated information already available through<br>
qemu_real_host_page_size().<br>
<br>
This introduces unnecessary global state and potential inconsistencies<br>
if the host page size is queried or changes during initialization.<br>
<br>
Replace all usages of qemu_host_page_size and qemu_host_page_mask with<br>
qemu_real_host_page_size() and derived expressions, and update all<br>
alignment and masking logic accordingly.<br>
<br>
This simplifies the code and ensures a single source of truth for host<br>
page size handling across bsd-user memory management paths.<br>
<br>
No functional change intended.<br>
<br>
Signed-off-by: Mohamed Ayman &lt;<a href=3D"mailto:mohamedaymanworkspace@gm=
ail.com" target=3D"_blank">mohamedaymanworkspace@gmail.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/elfload.c |=C2=A0 25 ++---------<br>
=C2=A0bsd-user/main.c=C2=A0 =C2=A0 |=C2=A0 14 ++-----<br>
=C2=A0bsd-user/mmap.c=C2=A0 =C2=A0 | 102 ++++++++++++++++------------------=
-----------<br>
=C2=A0bsd-user/qemu.h=C2=A0 =C2=A0 |=C2=A0 10 ++---<br>
=C2=A04 files changed, 46 insertions(+), 105 deletions(-)<br>
<br>
diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c<br>
index 3bca0cc9ed..00250fc3c1 100644<br>
--- a/bsd-user/elfload.c<br>
+++ b/bsd-user/elfload.c<br>
@@ -192,14 +192,14 @@ static void setup_arg_pages(struct bsd_binprm *bprm, =
struct image_info *info,<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0size =3D target_dflssiz;<br>
=C2=A0 =C2=A0 =C2=A0stack_base =3D TARGET_USRSTACK - size;<br>
-=C2=A0 =C2=A0 addr =3D target_mmap(stack_base , size + qemu_host_page_size=
,<br>
+=C2=A0 =C2=A0 addr =3D target_mmap(stack_base , size + HOST_PAGE_SIZE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PROT_READ | PROT_WRITE, MAP=
_PRIVATE | MAP_ANON, -1, 0);<br>
=C2=A0 =C2=A0 =C2=A0if (addr =3D=3D -1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perror(&quot;stk mmap&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(-1);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0/* we reserve one extra page at the top of the stack as=
 guard */<br>
-=C2=A0 =C2=A0 target_mprotect(addr + size, qemu_host_page_size, PROT_NONE)=
;<br>
+=C2=A0 =C2=A0 target_mprotect(addr + size, HOST_PAGE_SIZE, PROT_NONE);<br>
<br>
=C2=A0 =C2=A0 =C2=A0target_stksiz =3D size;<br>
=C2=A0 =C2=A0 =C2=A0target_stkbas =3D addr;<br>
@@ -239,27 +239,10 @@ static void padzero(abi_ulong elf_bss, abi_ulong last=
_bss)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0* XXX: this is really a hack : if the real host page s=
ize is<br>
-=C2=A0 =C2=A0 =C2=A0* smaller than the target page size, some pages after =
the end<br>
-=C2=A0 =C2=A0 =C2=A0* of the file may not be mapped. A better fix would be=
 to<br>
-=C2=A0 =C2=A0 =C2=A0* patch target_mmap(), but it is more complicated as t=
he file<br>
-=C2=A0 =C2=A0 =C2=A0* size must be known.<br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 if (qemu_real_host_page_size() &lt; qemu_host_page_size) {<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong end_addr, end_addr1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 end_addr1 =3D REAL_HOST_PAGE_ALIGN(elf_bss);<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 end_addr =3D HOST_PAGE_ALIGN(elf_bss);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (end_addr1 &lt; end_addr) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap((void *)g2h_untagged(end_ad=
dr1), end_addr - end_addr1,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PROT_READ | =
PROT_WRITE | PROT_EXEC,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MAP_FIXED | =
MAP_PRIVATE | MAP_ANON, -1, 0);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>The commit message say=
s it&#39;s a noop, but this looks like it does</div><div>something. aarch64=
 can have 16k pages, and binaries built for</div><div>that, and amd64 has 4=
k page sizes. I&#39;m curious how that would work</div><div>out.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
-=C2=A0 =C2=A0 nbyte =3D elf_bss &amp; (qemu_host_page_size - 1);<br>
+=C2=A0 =C2=A0 nbyte =3D elf_bss &amp; (HOST_PAGE_SIZE - 1);<br>
=C2=A0 =C2=A0 =C2=A0if (nbyte) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 nbyte =3D qemu_host_page_size - nbyte;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 nbyte =3D HOST_PAGE_SIZE - nbyte;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* FIXME - what to do if pu=
t_user() fails? */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0put_user_u8(0, elf_bss);<br=
>
diff --git a/bsd-user/main.c b/bsd-user/main.c<br>
index 73aae8c327..3f5141e794 100644<br>
--- a/bsd-user/main.c<br>
+++ b/bsd-user/main.c<br>
@@ -54,11 +54,6 @@<br>
=C2=A0#include &quot;target_arch_cpu.h&quot;<br>
<br>
<br>
-/*<br>
- * TODO: Remove these and rely only on qemu_real_host_page_size().<br>
- */<br>
-uintptr_t qemu_host_page_size;<br>
-intptr_t qemu_host_page_mask;<br>
<br>
=C2=A0static bool opt_one_insn_per_tb;<br>
=C2=A0static unsigned long opt_tb_size;<br>
@@ -302,8 +297,6 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void) envlist_setenv(envlist, *wrk);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 qemu_host_page_size =3D getpagesize();<br>
-=C2=A0 =C2=A0 qemu_host_page_size =3D MAX(qemu_host_page_size, TARGET_PAGE=
_SIZE);<br>
<br>
=C2=A0 =C2=A0 =C2=A0cpu_model =3D NULL;<br>
<br>
@@ -405,7 +398,6 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 qemu_host_page_mask =3D -qemu_host_page_size;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* init debug */<br>
=C2=A0 =C2=A0 =C2=A0{<br>
@@ -452,7 +444,7 @@ int main(int argc, char **argv)<br>
<br>
=C2=A0 =C2=A0 =C2=A0cpu_type =3D parse_cpu_option(cpu_model);<br>
<br>
-=C2=A0 =C2=A0 /* init tcg before creating CPUs and to get qemu_host_page_s=
ize */<br>
+=C2=A0 =C2=A0 /* init tcg before creating CPUs */<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AccelState *accel =3D current_accel();<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AccelClass *ac =3D ACCEL_GET_CLASS(accel)=
;<br>
@@ -534,7 +526,7 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 * proper page alignment for guest_base.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if (have_guest_base) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (guest_base &amp; ~qemu_host_page_mask) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (guest_base &amp; ~HOST_PAGE_MASK) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;Selected=
 guest base not host page aligned&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -573,7 +565,7 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Ensure that mmap_next_start is within =
range. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (reserved_va &lt;=3D mmap_next_start) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmap_next_start =3D (reserv=
ed_va / 4 * 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp; TARGET_PAGE_MASK &amp; qemu_host_page=
_mask;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp; TARGET_PAGE_MASK &amp; HOST_PAGE_MASK=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c<br>
index fe77eceb48..59c70083a4 100644<br>
--- a/bsd-user/mmap.c<br>
+++ b/bsd-user/mmap.c<br>
@@ -84,7 +84,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int p=
rot)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0mmap_lock();<br>
-=C2=A0 =C2=A0 host_start =3D start &amp; qemu_host_page_mask;<br>
+=C2=A0 =C2=A0 host_start =3D start &amp; HOST_PAGE_MASK;<br>
=C2=A0 =C2=A0 =C2=A0host_end =3D HOST_PAGE_ALIGN(end);<br>
=C2=A0 =C2=A0 =C2=A0if (start &gt; host_start) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* handle host page containing start */<b=
r>
@@ -92,28 +92,28 @@ int target_mprotect(abi_ulong start, abi_ulong len, int=
 prot)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (addr =3D host_start; addr &lt; start=
; addr +=3D TARGET_PAGE_SIZE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prot1 |=3D page_get_flags(a=
ddr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host_end =3D=3D host_start + qemu_host_pag=
e_size) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host_end =3D=3D host_start + HOST_PAGE_SIZ=
E) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (addr =3D end; addr &lt=
; host_end; addr +=3D TARGET_PAGE_SIZE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prot1 |=3D pa=
ge_get_flags(addr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0end =3D host_end;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mprotect(g2h_untagged(host_start)=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0qemu_host_page_size, prot1 &amp; PAGE_RWX);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0HOST_PAGE_SIZE, prot1 &amp; PAGE_RWX);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret !=3D 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_start +=3D qemu_host_page_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_start +=3D HOST_PAGE_SIZE;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (end &lt; host_end) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prot1 =3D prot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (addr =3D end; addr &lt; host_end; ad=
dr +=3D TARGET_PAGE_SIZE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prot1 |=3D page_get_flags(a=
ddr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D mprotect(g2h_untagged(host_end - qemu_=
host_page_size),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0qemu_host_page_size, prot1 &amp; PAGE_RWX);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D mprotect(g2h_untagged(host_end - HOST_=
PAGE_SIZE),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0HOST_PAGE_SIZE, prot1 &amp; PAGE_RWX);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret !=3D 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_end -=3D qemu_host_page_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_end -=3D HOST_PAGE_SIZE;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* handle the pages in the middle */<br>
@@ -193,7 +193,7 @@ static int mmap_frag(abi_ulong real_start,<br>
=C2=A0 =C2=A0 =C2=A0void *host_start;<br>
=C2=A0 =C2=A0 =C2=A0int prot1, prot_new;<br>
<br>
-=C2=A0 =C2=A0 real_end =3D real_start + qemu_host_page_size;<br>
+=C2=A0 =C2=A0 real_end =3D real_start + HOST_PAGE_SIZE;<br>
=C2=A0 =C2=A0 =C2=A0host_start =3D g2h_untagged(real_start);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* get the protection of the target pages outside the m=
apping */<br>
@@ -205,7 +205,7 @@ static int mmap_frag(abi_ulong real_start,<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (prot1 =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* no page was there, so we allocate one.=
 See also above. */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *p =3D mmap(host_start, qemu_host_page_si=
ze, prot,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *p =3D mmap(host_start, HOST_PAGE_SIZE, p=
rot,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 flags | ((fd !=3D -1) ? MAP_ANON : 0), -1, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (p =3D=3D MAP_FAILED)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
@@ -223,7 +223,7 @@ static int mmap_frag(abi_ulong real_start,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* adjust protection to be able to read *=
/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(prot1 &amp; PROT_WRITE))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mprotect(host_start, qemu_host_p=
age_size, prot1 | PROT_WRITE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mprotect(host_start, HOST_PAGE_S=
IZE, prot1 | PROT_WRITE);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* read the corresponding file data */<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!mmap_pread(fd, g2h_untagged(start), =
end - start, offset, true)) {<br>
@@ -232,10 +232,10 @@ static int mmap_frag(abi_ulong real_start,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* put final protection */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (prot_new !=3D (prot1 | PROT_WRITE))<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mprotect(host_start, qemu_host_p=
age_size, prot_new);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mprotect(host_start, HOST_PAGE_S=
IZE, prot_new);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (prot_new !=3D prot1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mprotect(host_start, qemu_host_p=
age_size, prot_new);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mprotect(host_start, HOST_PAGE_S=
IZE, prot_new);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (prot_new &amp; PROT_WRITE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(g2h_untagged(start),=
 0, end - start);<br>
@@ -289,7 +289,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size=
, abi_ulong alignment)<br>
=C2=A0 =C2=A0 =C2=A0if (start =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0start =3D mmap_next_start;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 start &amp;=3D qemu_host_page_mask;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 start &amp;=3D HOST_PAGE_MASK;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0size =3D HOST_PAGE_ALIGN(size);<br>
@@ -297,7 +297,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size=
, abi_ulong alignment)<br>
=C2=A0 =C2=A0 =C2=A0if (reserved_va) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return mmap_find_vma_reserved(start, size=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(alignment !=3D 0 ? 1 &lt;&=
lt; alignment :<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MAX(qemu_host_page_size, T=
ARGET_PAGE_SIZE)));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MAX(HOST_PAGE_SIZE, TARGET=
_PAGE_SIZE)));<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0addr =3D start;<br>
@@ -478,8 +478,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, in=
t prot,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 real_start =3D start &amp; qemu_host_page_mask;<br>
-=C2=A0 =C2=A0 host_offset =3D offset &amp; qemu_host_page_mask;<br>
+=C2=A0 =C2=A0 real_start =3D start &amp; HOST_PAGE_MASK;<br>
+=C2=A0 =C2=A0 host_offset =3D offset &amp; HOST_PAGE_MASK;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * If the user is asking for the kernel to find a locat=
ion, do that<br>
@@ -498,38 +498,6 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, i=
nt prot,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0* When mapping files into a memory area larger than th=
e file, accesses<br>
-=C2=A0 =C2=A0 =C2=A0* to pages beyond the file size will cause a SIGBUS.<b=
r>
-=C2=A0 =C2=A0 =C2=A0*<br>
-=C2=A0 =C2=A0 =C2=A0* For example, if mmaping a file of 100 bytes on a hos=
t with 4K pages<br>
-=C2=A0 =C2=A0 =C2=A0* emulating a target with 8K pages, the target expects=
 to be able to<br>
-=C2=A0 =C2=A0 =C2=A0* access the first 8K. But the host will trap us on an=
y access beyond<br>
-=C2=A0 =C2=A0 =C2=A0* 4K.<br>
-=C2=A0 =C2=A0 =C2=A0*<br>
-=C2=A0 =C2=A0 =C2=A0* When emulating a target with a larger page-size than=
 the hosts, we<br>
-=C2=A0 =C2=A0 =C2=A0* may need to truncate file maps at EOF and add extra =
anonymous pages<br>
-=C2=A0 =C2=A0 =C2=A0* up to the targets page boundary.<br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-<br>
-=C2=A0 =C2=A0 if ((qemu_real_host_page_size() &lt; qemu_host_page_size) &a=
mp;&amp; fd !=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct stat sb;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fstat(fd, &amp;sb) =3D=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Are we trying to create a map beyond EOF?.=
=C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (offset + len &gt; sb.st_size) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If so, truncate the file=
 map at eof aligned with<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the hosts real pagesize.=
 Additional anonymous maps<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* will be created beyond E=
OF.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D REAL_HOST_PAGE_ALIGN(sb.=
st_size - offset);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0 =C2=A0if (!(flags &amp; MAP_FIXED)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long host_start;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *p;<br>
@@ -539,8 +507,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, in=
t prot,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Note: we prefer to control the mapping=
 address. It is<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* especially important if qemu_host_page=
_size &gt;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* qemu_real_host_page_size<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* especially important if HOST_PAGE_SIZE=
 &gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TARGET_PAGE_SIZE<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p =3D mmap(g2h_untagged(start), host_len,=
 prot,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags | MAP_=
FIXED | ((fd !=3D -1) ? MAP_ANON : 0), -1, 0);<br>
@@ -581,7 +549,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, in=
t prot,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * aligned, so we read it<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd !=3D -1 &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (offset &amp; ~qemu_host_page_ma=
sk) !=3D (start &amp; ~qemu_host_page_mask)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (offset &amp; ~HOST_PAGE_MASK) !=
=3D (start &amp; ~HOST_PAGE_MASK)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * msync() won&#39;t work h=
ere, so we return an error if write is<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * possible while it is a s=
hared mapping<br>
@@ -614,7 +582,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, in=
t prot,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* handle the start of the mapping */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (start &gt; real_start) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (real_end =3D=3D real_start +=
 qemu_host_page_size) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (real_end =3D=3D real_start +=
 HOST_PAGE_SIZE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* one single=
 host page */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mmap_=
frag(real_start, start, end,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prot, flags, fd, offset);<br>
@@ -622,21 +590,21 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, =
int prot,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0goto fail;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto the_end1=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D mmap_frag(real_start, st=
art, real_start + qemu_host_page_size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D mmap_frag(real_start, st=
art, real_start + HOST_PAGE_SIZE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prot, flags, fd, offset);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D -1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_start +=3D qemu_host_page_s=
ize;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_start +=3D HOST_PAGE_SIZE;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* handle the end of the mapping */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (end &lt; real_end) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D mmap_frag(real_end - qem=
u_host_page_size,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 real_end - qemu_host_page_size, end,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D mmap_frag(real_end - HOS=
T_PAGE_SIZE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 real_end - HOST_PAGE_SIZE, end,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prot, flags, fd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 offset + real_end - qemu_host_page_size - start);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 offset + real_end - HOST_PAGE_SIZE - start);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D -1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_end -=3D qemu_host_page_siz=
e;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_end -=3D HOST_PAGE_SIZE;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* map the middle (easier) */<br>
@@ -676,7 +644,7 @@ void mmap_reserve(abi_ulong start, abi_ulong size)<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong end;<br>
=C2=A0 =C2=A0 =C2=A0int prot;<br>
<br>
-=C2=A0 =C2=A0 real_start =3D start &amp; qemu_host_page_mask;<br>
+=C2=A0 =C2=A0 real_start =3D start &amp; HOST_PAGE_MASK;<br>
=C2=A0 =C2=A0 =C2=A0real_end =3D HOST_PAGE_ALIGN(start + size);<br>
=C2=A0 =C2=A0 =C2=A0end =3D start + size;<br>
=C2=A0 =C2=A0 =C2=A0if (start &gt; real_start) {<br>
@@ -685,14 +653,14 @@ void mmap_reserve(abi_ulong start, abi_ulong size)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (addr =3D real_start; addr &lt; start=
; addr +=3D TARGET_PAGE_SIZE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prot |=3D page_get_flags(ad=
dr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (real_end =3D=3D real_start + qemu_host_pag=
e_size) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (real_end =3D=3D real_start + HOST_PAGE_SIZ=
E) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (addr =3D end; addr &lt=
; real_end; addr +=3D TARGET_PAGE_SIZE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prot |=3D pag=
e_get_flags(addr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0end =3D real_end;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (prot !=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_start +=3D qemu_host_page_s=
ize;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_start +=3D HOST_PAGE_SIZE;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (end &lt; real_end) {<br>
@@ -701,7 +669,7 @@ void mmap_reserve(abi_ulong start, abi_ulong size)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prot |=3D page_get_flags(ad=
dr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (prot !=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_end -=3D qemu_host_page_siz=
e;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_end -=3D HOST_PAGE_SIZE;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (real_start !=3D real_end) {<br>
@@ -727,7 +695,7 @@ int target_munmap(abi_ulong start, abi_ulong len)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0mmap_lock();<br>
=C2=A0 =C2=A0 =C2=A0end =3D start + len;<br>
-=C2=A0 =C2=A0 real_start =3D start &amp; qemu_host_page_mask;<br>
+=C2=A0 =C2=A0 real_start =3D start &amp; HOST_PAGE_MASK;<br>
=C2=A0 =C2=A0 =C2=A0real_end =3D HOST_PAGE_ALIGN(end);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (start &gt; real_start) {<br>
@@ -736,14 +704,14 @@ int target_munmap(abi_ulong start, abi_ulong len)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (addr =3D real_start; addr &lt; start=
; addr +=3D TARGET_PAGE_SIZE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prot |=3D page_get_flags(ad=
dr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (real_end =3D=3D real_start + qemu_host_pag=
e_size) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (real_end =3D=3D real_start + HOST_PAGE_SIZ=
E) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (addr =3D end; addr &lt=
; real_end; addr +=3D TARGET_PAGE_SIZE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prot |=3D pag=
e_get_flags(addr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0end =3D real_end;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (prot !=3D 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_start +=3D qemu_host_page_s=
ize;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_start +=3D HOST_PAGE_SIZE;<=
br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (end &lt; real_end) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prot =3D 0;<br>
@@ -751,7 +719,7 @@ int target_munmap(abi_ulong start, abi_ulong len)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prot |=3D page_get_flags(ad=
dr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (prot !=3D 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_end -=3D qemu_host_page_siz=
e;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_end -=3D HOST_PAGE_SIZE;<br=
>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0ret =3D 0;<br>
@@ -784,6 +752,6 @@ int target_msync(abi_ulong start, abi_ulong len, int fl=
ags)<br>
=C2=A0 =C2=A0 =C2=A0if (end =3D=3D start)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
<br>
-=C2=A0 =C2=A0 start &amp;=3D qemu_host_page_mask;<br>
+=C2=A0 =C2=A0 start &amp;=3D HOST_PAGE_MASK;<br>
=C2=A0 =C2=A0 =C2=A0return msync(g2h_untagged(start), end - start, flags);<=
br>
=C2=A0}<br>
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h<br>
index b0b2c249fb..41ac5e3eab 100644<br>
--- a/bsd-user/qemu.h<br>
+++ b/bsd-user/qemu.h<br>
@@ -44,12 +44,10 @@ extern char **environ;<br>
=C2=A0#include &quot;accel/tcg/vcpu-state.h&quot;<br>
<br>
=C2=A0#include &quot;qemu-os.h&quot;<br>
-/*<br>
- * TODO: Remove these and rely only on qemu_real_host_page_size().<br>
- */<br>
-extern uintptr_t qemu_host_page_size;<br>
-extern intptr_t qemu_host_page_mask;<br>
-#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)<br>
+<br>
+#define HOST_PAGE_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_real_host_page_size=
()<br>
+#define HOST_PAGE_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 (~(HOST_PAGE_SIZE - 1))<=
br>
+#define HOST_PAGE_MASK=C2=A0 ((intptr_t)~(HOST_PAGE_SIZE - 1))<br></blockq=
uote><div><br></div><div>HOST_PAGE_MASK appears to be defined twice.</div><=
div><br></div><div>As I said before, I love the direction here. Thanks for =
working it out.</div><div><br></div><div>Are you using bsd-user for anythin=
g?</div><div><br></div><div>Warner</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
=C2=A0/*<br>
=C2=A0 * This struct is used to hold certain information about the image.=
=C2=A0 Basically,<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000ad03080650b8924b--

