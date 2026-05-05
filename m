Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18FBFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 04:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK7pk-0006GL-0m; Tue, 05 May 2026 00:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wK7pf-0006G3-IH
 for qemu-devel@nongnu.org; Tue, 05 May 2026 00:56:31 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wK7pa-00082v-S0
 for qemu-devel@nongnu.org; Tue, 05 May 2026 00:56:31 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65c21049dafso4497594d50.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 21:56:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777956983; cv=none;
 d=google.com; s=arc-20240605;
 b=fgT8PvFbhZqo4I55fQD07IfLovGfMCqS1+5Pn7vxGTsmzl/gLkb7FOfSfRw/LZO7QH
 o/yvAzCwrmElFiBWFEIt1yzYRxTxfe1zXFV+/jUwnckWVCn8ErYrXuzZ6BwilNtPLXVu
 myH6ClgvspzB+Skzw5Haq0YtmQUwr9WywX8JYnaVjBbH65+w140QxH8sE1+XCs1YXQoO
 Bk07+t274a+neLGHTlhUS5ZbupnVy6W1aP38ml5ngBZPRDpNrJYiuDVDZDX9aDLK26KK
 d6FNWzjXzJkXro8DDjm4ROysyBGeb06PL427UxkT7BIZrunuTqBE1AM4jL6mA3CEpCN6
 FNhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zObzg3jmykNCUK9mgy8SDM7EiA/I1VAbSEZnJyYaUUc=;
 fh=32rTikYoxWReoet/dSw6UH/gwTzCdfJlNK4r89VDMms=;
 b=Z5H2zeLt2tiw87QVQEEU5vSXw4n8oIJ+1WXYHr7U0s+e8FXPMl083aD4CxulMgqWv6
 DwalS+8c3ugIgVwlIreAXx/q0VMW+mqDT+W4bZmszV3yvJ2O+qkrA72QS3G84ec8/UQI
 cWJoiXH7mcTOXb6/hqoC+0beP56DVXp2RiTyNJipxrYIAeQNpJqO6rPUqd2YO0l3Qpme
 yPf28AstMti+HNZ0ndU43UK36Wk6L7KaXqH6sm9A9eKi5wAUcvTYEGqVI1lf4dq/sruD
 B3vXPmpCWr6GnYTH9yBGGRJCsJ6gBRMdztiFFwpK7p4bZ9ATMTM87xAoJsYb2d2yh1BA
 RtUA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777956983; x=1778561783;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zObzg3jmykNCUK9mgy8SDM7EiA/I1VAbSEZnJyYaUUc=;
 b=AGzkq62PpOo+PkCG3cFooP51N8vFNB9DPhOasi1usKgRh7JBT9PN25xgdmAkdfNSMx
 Jmd27McGr7EQFGnEUDfFsDsD8HWv/LjTbrYU6c/9xtZ/nj+W3Cn5/PY4KZyoAfwfN83K
 pTDNk2uVB//4ahE3uYQjMCtxdvdmMkGcWQnVjaiKPtQR8PAXynXsfg9CAM+7KRfbFJ+O
 XC4pdSTncrsKjb2TFSirwgprIvoM6odCizI/cHob9c0W8RNtNLl48d6xWjjyAKR18GQs
 o9zaw0zUd1Vn8VQDrcOzN4K6cM+xxQE3DK+5SuAvgwdcs+rtKZXAeRsq2jBvvDYYxqA1
 ohhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777956983; x=1778561783;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zObzg3jmykNCUK9mgy8SDM7EiA/I1VAbSEZnJyYaUUc=;
 b=G19V+g6qXY7onMMy1YXT02BQdCFx7eAhHJaCU4IQRjkRgILOK9Ca5odzH2PQlmH/J/
 P1ewAVuxz90L+mzcn5m2RbE0HuO1Cw6UuSxhOqsMSw1AMUx3Yl7hw23dVKL0YfPkbtW7
 uLhoO3kG7z1p/ClLZMQv/7S1u+wGNCvMwArGOo+/pmVFGo6yM8Do0Mttvutgfkpz+ZEN
 kP8DNfelUzllAsDo3rH4zP3obJCfPqn3fQwjsNU+qS7Ge/9Xum+VLCadnJhqBWkc4zG8
 653Z5LG9vdKqJaftpNXyFeqZKjauViXBnENiSr+zF6ZtrqyzYX9E7rxsb/o1cNWqojLs
 LGfA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9uaBZLTGyoM3COdcmeSL0iQD08FvCHn7Qf1SZ7KNws5xmoS5ZhZDMFI3GuIIyQCBPCe2jXq3Unb2ps@nongnu.org
X-Gm-Message-State: AOJu0YxOduGh3eUO4U5N6rXSxcMcRDiHll8SfqBWhylQ2xBUR5GGxHpN
 iGX/aUr3OeY4BGbDKSlil1W2VRVhWar/1ZJ2C26uakCA7OwX1rHvPpxpHeYN6sG4dmk9R368GqD
 UmV8JHxgKWtWheqWPMBqWY6fH57lJdOlkW32hv9Imkw==
X-Gm-Gg: AeBDiesBY8vOcqpW8mOOJREE0Ou1NheRX5UNEVeITl3k0jPo+GYpCCo3mNtTw0vuIR3
 VbCmEh6G9UnECXPywDSErnrwYk5LT3JV53/NwRf5SlVFGnySDEQnlZsoKbCykKbObwcKY1S4PBy
 RIqpBTwlDA1duZ2lm74D5MzL/OeOW8JMgjJG76p+8gC4uY3vljvWZXQw9uP3jmUt6LjE61+ERGx
 YAVh53Cp9BkAiuZD9uJonTnBDcsU24A0gQyQakP7fQObJHobZjrvLonZmbiT74uYEMUttUQjmI6
 9Qk7in3PpGrCjl6Syg==
X-Received: by 2002:a05:690e:4194:b0:65c:67fa:b424 with SMTP id
 956f58d0204a3-65c67fabaf3mr2247441d50.3.1777956983337; Mon, 04 May 2026
 21:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260430162941.584960-1-mohamedaymanworkspace@gmail.com>
 <20260501161106.818373-1-mohamedaymanworkspace@gmail.com>
 <CABWZVhocw-5+RmijZVdOvfCJQfLw3pe+Td+wbgoT48yUQh69QQ@mail.gmail.com>
In-Reply-To: <CABWZVhocw-5+RmijZVdOvfCJQfLw3pe+Td+wbgoT48yUQh69QQ@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 4 May 2026 22:56:11 -0600
X-Gm-Features: AVHnY4JdEFeHROq9EvDB-6tCrwtWrwG22_wNVokQrkeEHxnreh1GLNBCr26dLMo
Message-ID: <CANCZdfo9=eX6ga-i6a8L_AT5cJaU+aUXNN9sWVeV9VdmEyqZKQ@mail.gmail.com>
Subject: Re: [PATCH v2] bsd-user: remove cached host page size and rely on
 qemu_real_host_page_size()
To: MOHAMED AYMAN <mohamedaymanworkspace@gmail.com>
Cc: Kyle Evans <kevans@freebsd.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000006b02a906510adead"
Received-SPF: none client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=wlosh@bsdimp.com; helo=mail-yx1-xb12f.google.com
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

--0000000000006b02a906510adead
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 10:23=E2=80=AFAM MOHAMED AYMAN <
mohamedaymanworkspace@gmail.com> wrote:

> Hi Warner and Peter,
>
> Thanks for the review. :)
>
> Here is v2 addressing your comments:
>
> - Fixed the duplicate HOST_PAGE_MASK definition
> - HOST_PAGE_SIZE now uses:
> MAX(qemu_real_host_page_size(), TARGET_PAGE_SIZE)
>
> This preserves correct behavior for cases where the target page size
> exceeds the host page size (e.g. aarch64 16K pages on a 4K amd64 host)
>
> - Updated the commit message to clarify behavior and remove the incorrect
> "No functional change intended" wording
>
> Regarding your question, I am not currently using bsd-user in production;
> this started as a cleanup/contribution effort while working through the
> code.
>
> Thanks again for the feedback.
>

Hi Mohamed,

I was getting ready to create a pull request when I recalled you'd sent
this in. However, it looks
like you didn't attach v2 of the path. Can you please resend it? All that
was here was what appeared
to be an email quoted copy of the first patch.

Thanks a lot!

Warner


> Mohamed Ayman
>
> On Fri, May 1, 2026 at 7:11=E2=80=AFPM Mohamed Ayman
> <mohamedaymanworkspace@gmail.com> wrote:
> >
> > The bsd-user implementation previously cached host page size and mask
> > in global variables (qemu_host_page_size and qemu_host_page_mask),
> > which duplicated information already available through
> > qemu_real_host_page_size().
> >
> > This introduced unnecessary global state and potential inconsistencies
> > if the host page size is queried or changes during initialization.
> >
> > Replace all usages of qemu_host_page_size and qemu_host_page_mask with
> > HOST_PAGE_SIZE and HOST_PAGE_MASK macros defined as:
> >
> >   MAX(qemu_real_host_page_size(), TARGET_PAGE_SIZE)
> >
> > This preserves the original behavior where the effective host page size
> > is the maximum of the real host page size and the target page size,
> > which matters on targets like aarch64 with 16K pages running on an
> > amd64 host with 4K pages.
> >
> > This also opens the way for renaming qemu_real_host_page_size() to
> > qemu_host_page_size() now that the bsd-user globals no longer occupy
> > that name.
> >
> > Signed-off-by: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
> > ---
> >  bsd-user/elfload.c |  25 ++---------
> >  bsd-user/main.c    |  14 ++-----
> >  bsd-user/mmap.c    | 102 ++++++++++++++++-----------------------------
> >  bsd-user/qemu.h    |  10 ++---
> >  4 files changed, 46 insertions(+), 105 deletions(-)
> >
> > diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
> > index 3bca0cc9ed..00250fc3c1 100644
> > --- a/bsd-user/elfload.c
> > +++ b/bsd-user/elfload.c
> > @@ -192,14 +192,14 @@ static void setup_arg_pages(struct bsd_binprm
> *bprm, struct image_info *info,
> >       */
> >      size =3D target_dflssiz;
> >      stack_base =3D TARGET_USRSTACK - size;
> > -    addr =3D target_mmap(stack_base , size + qemu_host_page_size,
> > +    addr =3D target_mmap(stack_base , size + HOST_PAGE_SIZE,
> >              PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
> >      if (addr =3D=3D -1) {
> >          perror("stk mmap");
> >          exit(-1);
> >      }
> >      /* we reserve one extra page at the top of the stack as guard */
> > -    target_mprotect(addr + size, qemu_host_page_size, PROT_NONE);
> > +    target_mprotect(addr + size, HOST_PAGE_SIZE, PROT_NONE);
> >
> >      target_stksiz =3D size;
> >      target_stkbas =3D addr;
> > @@ -239,27 +239,10 @@ static void padzero(abi_ulong elf_bss, abi_ulong
> last_bss)
> >          return;
> >      }
> >
> > -    /*
> > -     * XXX: this is really a hack : if the real host page size is
> > -     * smaller than the target page size, some pages after the end
> > -     * of the file may not be mapped. A better fix would be to
> > -     * patch target_mmap(), but it is more complicated as the file
> > -     * size must be known.
> > -     */
> > -    if (qemu_real_host_page_size() < qemu_host_page_size) {
> > -        abi_ulong end_addr, end_addr1;
> > -        end_addr1 =3D REAL_HOST_PAGE_ALIGN(elf_bss);
> > -        end_addr =3D HOST_PAGE_ALIGN(elf_bss);
> > -        if (end_addr1 < end_addr) {
> > -            mmap((void *)g2h_untagged(end_addr1), end_addr - end_addr1=
,
> > -                 PROT_READ | PROT_WRITE | PROT_EXEC,
> > -                 MAP_FIXED | MAP_PRIVATE | MAP_ANON, -1, 0);
> > -        }
> > -    }
> >
> > -    nbyte =3D elf_bss & (qemu_host_page_size - 1);
> > +    nbyte =3D elf_bss & (HOST_PAGE_SIZE - 1);
> >      if (nbyte) {
> > -        nbyte =3D qemu_host_page_size - nbyte;
> > +        nbyte =3D HOST_PAGE_SIZE - nbyte;
> >          do {
> >              /* FIXME - what to do if put_user() fails? */
> >              put_user_u8(0, elf_bss);
> > diff --git a/bsd-user/main.c b/bsd-user/main.c
> > index 73aae8c327..3f5141e794 100644
> > --- a/bsd-user/main.c
> > +++ b/bsd-user/main.c
> > @@ -54,11 +54,6 @@
> >  #include "target_arch_cpu.h"
> >
> >
> > -/*
> > - * TODO: Remove these and rely only on qemu_real_host_page_size().
> > - */
> > -uintptr_t qemu_host_page_size;
> > -intptr_t qemu_host_page_mask;
> >
> >  static bool opt_one_insn_per_tb;
> >  static unsigned long opt_tb_size;
> > @@ -302,8 +297,6 @@ int main(int argc, char **argv)
> >          (void) envlist_setenv(envlist, *wrk);
> >      }
> >
> > -    qemu_host_page_size =3D getpagesize();
> > -    qemu_host_page_size =3D MAX(qemu_host_page_size, TARGET_PAGE_SIZE)=
;
> >
> >      cpu_model =3D NULL;
> >
> > @@ -405,7 +398,6 @@ int main(int argc, char **argv)
> >          }
> >      }
> >
> > -    qemu_host_page_mask =3D -qemu_host_page_size;
> >
> >      /* init debug */
> >      {
> > @@ -452,7 +444,7 @@ int main(int argc, char **argv)
> >
> >      cpu_type =3D parse_cpu_option(cpu_model);
> >
> > -    /* init tcg before creating CPUs and to get qemu_host_page_size */
> > +    /* init tcg before creating CPUs */
> >      {
> >          AccelState *accel =3D current_accel();
> >          AccelClass *ac =3D ACCEL_GET_CLASS(accel);
> > @@ -534,7 +526,7 @@ int main(int argc, char **argv)
> >       * proper page alignment for guest_base.
> >       */
> >      if (have_guest_base) {
> > -        if (guest_base & ~qemu_host_page_mask) {
> > +        if (guest_base & ~HOST_PAGE_MASK) {
> >              error_report("Selected guest base not host page aligned");
> >              exit(1);
> >          }
> > @@ -573,7 +565,7 @@ int main(int argc, char **argv)
> >          /* Ensure that mmap_next_start is within range. */
> >          if (reserved_va <=3D mmap_next_start) {
> >              mmap_next_start =3D (reserved_va / 4 * 3)
> > -                              & TARGET_PAGE_MASK & qemu_host_page_mask=
;
> > +                              & TARGET_PAGE_MASK & HOST_PAGE_MASK;
> >          }
> >      }
> >
> > diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
> > index fe77eceb48..59c70083a4 100644
> > --- a/bsd-user/mmap.c
> > +++ b/bsd-user/mmap.c
> > @@ -84,7 +84,7 @@ int target_mprotect(abi_ulong start, abi_ulong len,
> int prot)
> >          return 0;
> >
> >      mmap_lock();
> > -    host_start =3D start & qemu_host_page_mask;
> > +    host_start =3D start & HOST_PAGE_MASK;
> >      host_end =3D HOST_PAGE_ALIGN(end);
> >      if (start > host_start) {
> >          /* handle host page containing start */
> > @@ -92,28 +92,28 @@ int target_mprotect(abi_ulong start, abi_ulong len,
> int prot)
> >          for (addr =3D host_start; addr < start; addr +=3D TARGET_PAGE_=
SIZE)
> {
> >              prot1 |=3D page_get_flags(addr);
> >          }
> > -        if (host_end =3D=3D host_start + qemu_host_page_size) {
> > +        if (host_end =3D=3D host_start + HOST_PAGE_SIZE) {
> >              for (addr =3D end; addr < host_end; addr +=3D TARGET_PAGE_=
SIZE)
> {
> >                  prot1 |=3D page_get_flags(addr);
> >              }
> >              end =3D host_end;
> >          }
> >          ret =3D mprotect(g2h_untagged(host_start),
> > -                       qemu_host_page_size, prot1 & PAGE_RWX);
> > +                       HOST_PAGE_SIZE, prot1 & PAGE_RWX);
> >          if (ret !=3D 0)
> >              goto error;
> > -        host_start +=3D qemu_host_page_size;
> > +        host_start +=3D HOST_PAGE_SIZE;
> >      }
> >      if (end < host_end) {
> >          prot1 =3D prot;
> >          for (addr =3D end; addr < host_end; addr +=3D TARGET_PAGE_SIZE=
) {
> >              prot1 |=3D page_get_flags(addr);
> >          }
> > -        ret =3D mprotect(g2h_untagged(host_end - qemu_host_page_size),
> > -                       qemu_host_page_size, prot1 & PAGE_RWX);
> > +        ret =3D mprotect(g2h_untagged(host_end - HOST_PAGE_SIZE),
> > +                       HOST_PAGE_SIZE, prot1 & PAGE_RWX);
> >          if (ret !=3D 0)
> >              goto error;
> > -        host_end -=3D qemu_host_page_size;
> > +        host_end -=3D HOST_PAGE_SIZE;
> >      }
> >
> >      /* handle the pages in the middle */
> > @@ -193,7 +193,7 @@ static int mmap_frag(abi_ulong real_start,
> >      void *host_start;
> >      int prot1, prot_new;
> >
> > -    real_end =3D real_start + qemu_host_page_size;
> > +    real_end =3D real_start + HOST_PAGE_SIZE;
> >      host_start =3D g2h_untagged(real_start);
> >
> >      /* get the protection of the target pages outside the mapping */
> > @@ -205,7 +205,7 @@ static int mmap_frag(abi_ulong real_start,
> >
> >      if (prot1 =3D=3D 0) {
> >          /* no page was there, so we allocate one. See also above. */
> > -        void *p =3D mmap(host_start, qemu_host_page_size, prot,
> > +        void *p =3D mmap(host_start, HOST_PAGE_SIZE, prot,
> >                         flags | ((fd !=3D -1) ? MAP_ANON : 0), -1, 0);
> >          if (p =3D=3D MAP_FAILED)
> >              return -1;
> > @@ -223,7 +223,7 @@ static int mmap_frag(abi_ulong real_start,
> >
> >          /* adjust protection to be able to read */
> >          if (!(prot1 & PROT_WRITE))
> > -            mprotect(host_start, qemu_host_page_size, prot1 |
> PROT_WRITE);
> > +            mprotect(host_start, HOST_PAGE_SIZE, prot1 | PROT_WRITE);
> >
> >          /* read the corresponding file data */
> >          if (!mmap_pread(fd, g2h_untagged(start), end - start, offset,
> true)) {
> > @@ -232,10 +232,10 @@ static int mmap_frag(abi_ulong real_start,
> >
> >          /* put final protection */
> >          if (prot_new !=3D (prot1 | PROT_WRITE))
> > -            mprotect(host_start, qemu_host_page_size, prot_new);
> > +            mprotect(host_start, HOST_PAGE_SIZE, prot_new);
> >      } else {
> >          if (prot_new !=3D prot1) {
> > -            mprotect(host_start, qemu_host_page_size, prot_new);
> > +            mprotect(host_start, HOST_PAGE_SIZE, prot_new);
> >          }
> >          if (prot_new & PROT_WRITE) {
> >              memset(g2h_untagged(start), 0, end - start);
> > @@ -289,7 +289,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong
> size, abi_ulong alignment)
> >      if (start =3D=3D 0) {
> >          start =3D mmap_next_start;
> >      } else {
> > -        start &=3D qemu_host_page_mask;
> > +        start &=3D HOST_PAGE_MASK;
> >      }
> >
> >      size =3D HOST_PAGE_ALIGN(size);
> > @@ -297,7 +297,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong
> size, abi_ulong alignment)
> >      if (reserved_va) {
> >          return mmap_find_vma_reserved(start, size,
> >              (alignment !=3D 0 ? 1 << alignment :
> > -             MAX(qemu_host_page_size, TARGET_PAGE_SIZE)));
> > +             MAX(HOST_PAGE_SIZE, TARGET_PAGE_SIZE)));
> >      }
> >
> >      addr =3D start;
> > @@ -478,8 +478,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len=
,
> int prot,
> >          goto fail;
> >      }
> >
> > -    real_start =3D start & qemu_host_page_mask;
> > -    host_offset =3D offset & qemu_host_page_mask;
> > +    real_start =3D start & HOST_PAGE_MASK;
> > +    host_offset =3D offset & HOST_PAGE_MASK;
> >
> >      /*
> >       * If the user is asking for the kernel to find a location, do tha=
t
> > @@ -498,38 +498,6 @@ abi_long target_mmap(abi_ulong start, abi_ulong
> len, int prot,
> >          }
> >      }
> >
> > -    /*
> > -     * When mapping files into a memory area larger than the file,
> accesses
> > -     * to pages beyond the file size will cause a SIGBUS.
> > -     *
> > -     * For example, if mmaping a file of 100 bytes on a host with 4K
> pages
> > -     * emulating a target with 8K pages, the target expects to be able
> to
> > -     * access the first 8K. But the host will trap us on any access
> beyond
> > -     * 4K.
> > -     *
> > -     * When emulating a target with a larger page-size than the hosts,
> we
> > -     * may need to truncate file maps at EOF and add extra anonymous
> pages
> > -     * up to the targets page boundary.
> > -     */
> > -
> > -    if ((qemu_real_host_page_size() < qemu_host_page_size) && fd !=3D =
-1)
> {
> > -        struct stat sb;
> > -
> > -        if (fstat(fd, &sb) =3D=3D -1) {
> > -            goto fail;
> > -        }
> > -
> > -        /* Are we trying to create a map beyond EOF?.  */
> > -        if (offset + len > sb.st_size) {
> > -            /*
> > -             * If so, truncate the file map at eof aligned with
> > -             * the hosts real pagesize. Additional anonymous maps
> > -             * will be created beyond EOF.
> > -             */
> > -            len =3D REAL_HOST_PAGE_ALIGN(sb.st_size - offset);
> > -        }
> > -    }
> > -
> >      if (!(flags & MAP_FIXED)) {
> >          unsigned long host_start;
> >          void *p;
> > @@ -539,8 +507,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len=
,
> int prot,
> >
> >          /*
> >           * Note: we prefer to control the mapping address. It is
> > -         * especially important if qemu_host_page_size >
> > -         * qemu_real_host_page_size
> > +         * especially important if HOST_PAGE_SIZE >
> > +         * TARGET_PAGE_SIZE
> >           */
> >          p =3D mmap(g2h_untagged(start), host_len, prot,
> >                   flags | MAP_FIXED | ((fd !=3D -1) ? MAP_ANON : 0), -1=
,
> 0);
> > @@ -581,7 +549,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len=
,
> int prot,
> >           * aligned, so we read it
> >           */
> >          if (fd !=3D -1 &&
> > -            (offset & ~qemu_host_page_mask) !=3D (start &
> ~qemu_host_page_mask)) {
> > +            (offset & ~HOST_PAGE_MASK) !=3D (start & ~HOST_PAGE_MASK))=
 {
> >              /*
> >               * msync() won't work here, so we return an error if write
> is
> >               * possible while it is a shared mapping
> > @@ -614,7 +582,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len=
,
> int prot,
> >
> >          /* handle the start of the mapping */
> >          if (start > real_start) {
> > -            if (real_end =3D=3D real_start + qemu_host_page_size) {
> > +            if (real_end =3D=3D real_start + HOST_PAGE_SIZE) {
> >                  /* one single host page */
> >                  ret =3D mmap_frag(real_start, start, end,
> >                                  prot, flags, fd, offset);
> > @@ -622,21 +590,21 @@ abi_long target_mmap(abi_ulong start, abi_ulong
> len, int prot,
> >                      goto fail;
> >                  goto the_end1;
> >              }
> > -            ret =3D mmap_frag(real_start, start, real_start +
> qemu_host_page_size,
> > +            ret =3D mmap_frag(real_start, start, real_start +
> HOST_PAGE_SIZE,
> >                              prot, flags, fd, offset);
> >              if (ret =3D=3D -1)
> >                  goto fail;
> > -            real_start +=3D qemu_host_page_size;
> > +            real_start +=3D HOST_PAGE_SIZE;
> >          }
> >          /* handle the end of the mapping */
> >          if (end < real_end) {
> > -            ret =3D mmap_frag(real_end - qemu_host_page_size,
> > -                            real_end - qemu_host_page_size, end,
> > +            ret =3D mmap_frag(real_end - HOST_PAGE_SIZE,
> > +                            real_end - HOST_PAGE_SIZE, end,
> >                              prot, flags, fd,
> > -                            offset + real_end - qemu_host_page_size -
> start);
> > +                            offset + real_end - HOST_PAGE_SIZE - start=
);
> >              if (ret =3D=3D -1)
> >                  goto fail;
> > -            real_end -=3D qemu_host_page_size;
> > +            real_end -=3D HOST_PAGE_SIZE;
> >          }
> >
> >          /* map the middle (easier) */
> > @@ -676,7 +644,7 @@ void mmap_reserve(abi_ulong start, abi_ulong size)
> >      abi_ulong end;
> >      int prot;
> >
> > -    real_start =3D start & qemu_host_page_mask;
> > +    real_start =3D start & HOST_PAGE_MASK;
> >      real_end =3D HOST_PAGE_ALIGN(start + size);
> >      end =3D start + size;
> >      if (start > real_start) {
> > @@ -685,14 +653,14 @@ void mmap_reserve(abi_ulong start, abi_ulong size=
)
> >          for (addr =3D real_start; addr < start; addr +=3D TARGET_PAGE_=
SIZE)
> {
> >              prot |=3D page_get_flags(addr);
> >          }
> > -        if (real_end =3D=3D real_start + qemu_host_page_size) {
> > +        if (real_end =3D=3D real_start + HOST_PAGE_SIZE) {
> >              for (addr =3D end; addr < real_end; addr +=3D TARGET_PAGE_=
SIZE)
> {
> >                  prot |=3D page_get_flags(addr);
> >              }
> >              end =3D real_end;
> >          }
> >          if (prot !=3D 0) {
> > -            real_start +=3D qemu_host_page_size;
> > +            real_start +=3D HOST_PAGE_SIZE;
> >          }
> >      }
> >      if (end < real_end) {
> > @@ -701,7 +669,7 @@ void mmap_reserve(abi_ulong start, abi_ulong size)
> >              prot |=3D page_get_flags(addr);
> >          }
> >          if (prot !=3D 0) {
> > -            real_end -=3D qemu_host_page_size;
> > +            real_end -=3D HOST_PAGE_SIZE;
> >          }
> >      }
> >      if (real_start !=3D real_end) {
> > @@ -727,7 +695,7 @@ int target_munmap(abi_ulong start, abi_ulong len)
> >          return -EINVAL;
> >      mmap_lock();
> >      end =3D start + len;
> > -    real_start =3D start & qemu_host_page_mask;
> > +    real_start =3D start & HOST_PAGE_MASK;
> >      real_end =3D HOST_PAGE_ALIGN(end);
> >
> >      if (start > real_start) {
> > @@ -736,14 +704,14 @@ int target_munmap(abi_ulong start, abi_ulong len)
> >          for (addr =3D real_start; addr < start; addr +=3D TARGET_PAGE_=
SIZE)
> {
> >              prot |=3D page_get_flags(addr);
> >          }
> > -        if (real_end =3D=3D real_start + qemu_host_page_size) {
> > +        if (real_end =3D=3D real_start + HOST_PAGE_SIZE) {
> >              for (addr =3D end; addr < real_end; addr +=3D TARGET_PAGE_=
SIZE)
> {
> >                  prot |=3D page_get_flags(addr);
> >              }
> >              end =3D real_end;
> >          }
> >          if (prot !=3D 0)
> > -            real_start +=3D qemu_host_page_size;
> > +            real_start +=3D HOST_PAGE_SIZE;
> >      }
> >      if (end < real_end) {
> >          prot =3D 0;
> > @@ -751,7 +719,7 @@ int target_munmap(abi_ulong start, abi_ulong len)
> >              prot |=3D page_get_flags(addr);
> >          }
> >          if (prot !=3D 0)
> > -            real_end -=3D qemu_host_page_size;
> > +            real_end -=3D HOST_PAGE_SIZE;
> >      }
> >
> >      ret =3D 0;
> > @@ -784,6 +752,6 @@ int target_msync(abi_ulong start, abi_ulong len, in=
t
> flags)
> >      if (end =3D=3D start)
> >          return 0;
> >
> > -    start &=3D qemu_host_page_mask;
> > +    start &=3D HOST_PAGE_MASK;
> >      return msync(g2h_untagged(start), end - start, flags);
> >  }
> > diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
> > index b0b2c249fb..7553ac154c 100644
> > --- a/bsd-user/qemu.h
> > +++ b/bsd-user/qemu.h
> > @@ -44,12 +44,10 @@ extern char **environ;
> >  #include "accel/tcg/vcpu-state.h"
> >
> >  #include "qemu-os.h"
> > -/*
> > - * TODO: Remove these and rely only on qemu_real_host_page_size().
> > - */
> > -extern uintptr_t qemu_host_page_size;
> > -extern intptr_t qemu_host_page_mask;
> > -#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)
> > +
> > +#define HOST_PAGE_SIZE        MAX(qemu_real_host_page_size(),
> TARGET_PAGE_SIZE)
> > +#define HOST_PAGE_MASK        ((intptr_t)~(HOST_PAGE_SIZE - 1))
> > +#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), HOST_PAGE_SIZE)
> >
> >  /*
> >   * This struct is used to hold certain information about the image.
> Basically,
> > --
> > 2.34.1
> >
>

--0000000000006b02a906510adead
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 1, =
2026 at 10:23=E2=80=AFAM MOHAMED AYMAN &lt;<a href=3D"mailto:mohamedaymanwo=
rkspace@gmail.com">mohamedaymanworkspace@gmail.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Hi Warner and Peter,<br>
<br>
Thanks for the review. :)<br>
<br>
Here is v2 addressing your comments:<br>
<br>
- Fixed the duplicate HOST_PAGE_MASK definition<br>
- HOST_PAGE_SIZE now uses:<br>
MAX(qemu_real_host_page_size(), TARGET_PAGE_SIZE)<br>
<br>
This preserves correct behavior for cases where the target page size<br>
exceeds the host page size (e.g. aarch64 16K pages on a 4K amd64 host)<br>
<br>
- Updated the commit message to clarify behavior and remove the incorrect<b=
r>
&quot;No functional change intended&quot; wording<br>
<br>
Regarding your question, I am not currently using bsd-user in production;<b=
r>
this started as a cleanup/contribution effort while working through the cod=
e.<br>
<br>
Thanks again for the feedback.<br></blockquote><div><br></div><div>Hi Moham=
ed,</div><div><br></div><div>I was getting ready to create a pull request=
=C2=A0when I recalled you&#39;d sent this in. However, it looks</div><div>l=
ike you didn&#39;t attach v2 of the path. Can you please resend it? All tha=
t was here was what appeared</div><div>to be an email quoted copy of the fi=
rst patch.</div><div><br></div><div>Thanks a lot!</div><div><br></div><div>=
Warner</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
Mohamed Ayman<br>
<br>
On Fri, May 1, 2026 at 7:11=E2=80=AFPM Mohamed Ayman<br>
&lt;<a href=3D"mailto:mohamedaymanworkspace@gmail.com" target=3D"_blank">mo=
hamedaymanworkspace@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; The bsd-user implementation previously cached host page size and mask<=
br>
&gt; in global variables (qemu_host_page_size and qemu_host_page_mask),<br>
&gt; which duplicated information already available through<br>
&gt; qemu_real_host_page_size().<br>
&gt;<br>
&gt; This introduced unnecessary global state and potential inconsistencies=
<br>
&gt; if the host page size is queried or changes during initialization.<br>
&gt;<br>
&gt; Replace all usages of qemu_host_page_size and qemu_host_page_mask with=
<br>
&gt; HOST_PAGE_SIZE and HOST_PAGE_MASK macros defined as:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0MAX(qemu_real_host_page_size(), TARGET_PAGE_SIZE)<br>
&gt;<br>
&gt; This preserves the original behavior where the effective host page siz=
e<br>
&gt; is the maximum of the real host page size and the target page size,<br=
>
&gt; which matters on targets like aarch64 with 16K pages running on an<br>
&gt; amd64 host with 4K pages.<br>
&gt;<br>
&gt; This also opens the way for renaming qemu_real_host_page_size() to<br>
&gt; qemu_host_page_size() now that the bsd-user globals no longer occupy<b=
r>
&gt; that name.<br>
&gt;<br>
&gt; Signed-off-by: Mohamed Ayman &lt;<a href=3D"mailto:mohamedaymanworkspa=
ce@gmail.com" target=3D"_blank">mohamedaymanworkspace@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 bsd-user/elfload.c |=C2=A0 25 ++---------<br>
&gt;=C2=A0 bsd-user/main.c=C2=A0 =C2=A0 |=C2=A0 14 ++-----<br>
&gt;=C2=A0 bsd-user/mmap.c=C2=A0 =C2=A0 | 102 ++++++++++++++++-------------=
----------------<br>
&gt;=C2=A0 bsd-user/qemu.h=C2=A0 =C2=A0 |=C2=A0 10 ++---<br>
&gt;=C2=A0 4 files changed, 46 insertions(+), 105 deletions(-)<br>
&gt;<br>
&gt; diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c<br>
&gt; index 3bca0cc9ed..00250fc3c1 100644<br>
&gt; --- a/bsd-user/elfload.c<br>
&gt; +++ b/bsd-user/elfload.c<br>
&gt; @@ -192,14 +192,14 @@ static void setup_arg_pages(struct bsd_binprm *b=
prm, struct image_info *info,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 size =3D target_dflssiz;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 stack_base =3D TARGET_USRSTACK - size;<br>
&gt; -=C2=A0 =C2=A0 addr =3D target_mmap(stack_base , size + qemu_host_page=
_size,<br>
&gt; +=C2=A0 =C2=A0 addr =3D target_mmap(stack_base , size + HOST_PAGE_SIZE=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PROT_READ | PROT_WRITE=
, MAP_PRIVATE | MAP_ANON, -1, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (addr =3D=3D -1) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 perror(&quot;stk mmap&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(-1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* we reserve one extra page at the top of the sta=
ck as guard */<br>
&gt; -=C2=A0 =C2=A0 target_mprotect(addr + size, qemu_host_page_size, PROT_=
NONE);<br>
&gt; +=C2=A0 =C2=A0 target_mprotect(addr + size, HOST_PAGE_SIZE, PROT_NONE)=
;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 target_stksiz =3D size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 target_stkbas =3D addr;<br>
&gt; @@ -239,27 +239,10 @@ static void padzero(abi_ulong elf_bss, abi_ulong=
 last_bss)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 /*<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* XXX: this is really a hack : if the real host p=
age size is<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* smaller than the target page size, some pages a=
fter the end<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* of the file may not be mapped. A better fix wou=
ld be to<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* patch target_mmap(), but it is more complicated=
 as the file<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* size must be known.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; -=C2=A0 =C2=A0 if (qemu_real_host_page_size() &lt; qemu_host_page_size=
) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong end_addr, end_addr1;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 end_addr1 =3D REAL_HOST_PAGE_ALIGN(elf_bs=
s);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 end_addr =3D HOST_PAGE_ALIGN(elf_bss);<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (end_addr1 &lt; end_addr) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap((void *)g2h_untagged(e=
nd_addr1), end_addr - end_addr1,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PROT_RE=
AD | PROT_WRITE | PROT_EXEC,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MAP_FIX=
ED | MAP_PRIVATE | MAP_ANON, -1, 0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 nbyte =3D elf_bss &amp; (qemu_host_page_size - 1);<br>
&gt; +=C2=A0 =C2=A0 nbyte =3D elf_bss &amp; (HOST_PAGE_SIZE - 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (nbyte) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 nbyte =3D qemu_host_page_size - nbyte;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 nbyte =3D HOST_PAGE_SIZE - nbyte;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* FIXME - what to do =
if put_user() fails? */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 put_user_u8(0, elf_bss=
);<br>
&gt; diff --git a/bsd-user/main.c b/bsd-user/main.c<br>
&gt; index 73aae8c327..3f5141e794 100644<br>
&gt; --- a/bsd-user/main.c<br>
&gt; +++ b/bsd-user/main.c<br>
&gt; @@ -54,11 +54,6 @@<br>
&gt;=C2=A0 #include &quot;target_arch_cpu.h&quot;<br>
&gt;<br>
&gt;<br>
&gt; -/*<br>
&gt; - * TODO: Remove these and rely only on qemu_real_host_page_size().<br=
>
&gt; - */<br>
&gt; -uintptr_t qemu_host_page_size;<br>
&gt; -intptr_t qemu_host_page_mask;<br>
&gt;<br>
&gt;=C2=A0 static bool opt_one_insn_per_tb;<br>
&gt;=C2=A0 static unsigned long opt_tb_size;<br>
&gt; @@ -302,8 +297,6 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (void) envlist_setenv(envlist, *wrk)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 qemu_host_page_size =3D getpagesize();<br>
&gt; -=C2=A0 =C2=A0 qemu_host_page_size =3D MAX(qemu_host_page_size, TARGET=
_PAGE_SIZE);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 cpu_model =3D NULL;<br>
&gt;<br>
&gt; @@ -405,7 +398,6 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 qemu_host_page_mask =3D -qemu_host_page_size;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* init debug */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 {<br>
&gt; @@ -452,7 +444,7 @@ int main(int argc, char **argv)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 cpu_type =3D parse_cpu_option(cpu_model);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 /* init tcg before creating CPUs and to get qemu_host_p=
age_size */<br>
&gt; +=C2=A0 =C2=A0 /* init tcg before creating CPUs */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AccelState *accel =3D current_accel(=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AccelClass *ac =3D ACCEL_GET_CLASS(a=
ccel);<br>
&gt; @@ -534,7 +526,7 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* proper page alignment for guest_base.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (have_guest_base) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (guest_base &amp; ~qemu_host_page_mask=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (guest_base &amp; ~HOST_PAGE_MASK) {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Sel=
ected guest base not host page aligned&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; @@ -573,7 +565,7 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Ensure that mmap_next_start is wi=
thin range. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (reserved_va &lt;=3D mmap_next_st=
art) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_next_start =3D (r=
eserved_va / 4 * 3)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp; TARGET_PAGE_MASK &amp; qemu_host_=
page_mask;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp; TARGET_PAGE_MASK &amp; HOST_PAGE_=
MASK;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c<br>
&gt; index fe77eceb48..59c70083a4 100644<br>
&gt; --- a/bsd-user/mmap.c<br>
&gt; +++ b/bsd-user/mmap.c<br>
&gt; @@ -84,7 +84,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, =
int prot)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 mmap_lock();<br>
&gt; -=C2=A0 =C2=A0 host_start =3D start &amp; qemu_host_page_mask;<br>
&gt; +=C2=A0 =C2=A0 host_start =3D start &amp; HOST_PAGE_MASK;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 host_end =3D HOST_PAGE_ALIGN(end);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (start &gt; host_start) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* handle host page containing start=
 */<br>
&gt; @@ -92,28 +92,28 @@ int target_mprotect(abi_ulong start, abi_ulong len=
, int prot)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (addr =3D host_start; addr &lt; =
start; addr +=3D TARGET_PAGE_SIZE) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prot1 |=3D page_get_fl=
ags(addr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host_end =3D=3D host_start + qemu_hos=
t_page_size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host_end =3D=3D host_start + HOST_PAG=
E_SIZE) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (addr =3D end; add=
r &lt; host_end; addr +=3D TARGET_PAGE_SIZE) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prot1 |=
=3D page_get_flags(addr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 end =3D host_end;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D mprotect(g2h_untagged(host_s=
tart),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0qemu_host_page_size, prot1 &amp; PAGE_RWX);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0HOST_PAGE_SIZE, prot1 &amp; PAGE_RWX);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret !=3D 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_start +=3D qemu_host_page_size;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_start +=3D HOST_PAGE_SIZE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (end &lt; host_end) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prot1 =3D prot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (addr =3D end; addr &lt; host_en=
d; addr +=3D TARGET_PAGE_SIZE) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prot1 |=3D page_get_fl=
ags(addr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D mprotect(g2h_untagged(host_end - =
qemu_host_page_size),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0qemu_host_page_size, prot1 &amp; PAGE_RWX);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D mprotect(g2h_untagged(host_end - =
HOST_PAGE_SIZE),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0HOST_PAGE_SIZE, prot1 &amp; PAGE_RWX);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret !=3D 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_end -=3D qemu_host_page_size;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_end -=3D HOST_PAGE_SIZE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* handle the pages in the middle */<br>
&gt; @@ -193,7 +193,7 @@ static int mmap_frag(abi_ulong real_start,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 void *host_start;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int prot1, prot_new;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 real_end =3D real_start + qemu_host_page_size;<br>
&gt; +=C2=A0 =C2=A0 real_end =3D real_start + HOST_PAGE_SIZE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 host_start =3D g2h_untagged(real_start);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* get the protection of the target pages outside =
the mapping */<br>
&gt; @@ -205,7 +205,7 @@ static int mmap_frag(abi_ulong real_start,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (prot1 =3D=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* no page was there, so we allocate=
 one. See also above. */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *p =3D mmap(host_start, qemu_host_pa=
ge_size, prot,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *p =3D mmap(host_start, HOST_PAGE_SI=
ZE, prot,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0flags | ((fd !=3D -1) ? MAP_ANON : 0), -1, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (p =3D=3D MAP_FAILED)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; @@ -223,7 +223,7 @@ static int mmap_frag(abi_ulong real_start,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* adjust protection to be able to r=
ead */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(prot1 &amp; PROT_WRITE))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mprotect(host_start, qemu_h=
ost_page_size, prot1 | PROT_WRITE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mprotect(host_start, HOST_P=
AGE_SIZE, prot1 | PROT_WRITE);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* read the corresponding file data =
*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!mmap_pread(fd, g2h_untagged(sta=
rt), end - start, offset, true)) {<br>
&gt; @@ -232,10 +232,10 @@ static int mmap_frag(abi_ulong real_start,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* put final protection */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prot_new !=3D (prot1 | PROT_WRIT=
E))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mprotect(host_start, qemu_h=
ost_page_size, prot_new);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mprotect(host_start, HOST_P=
AGE_SIZE, prot_new);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prot_new !=3D prot1) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mprotect(host_start, qemu_h=
ost_page_size, prot_new);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mprotect(host_start, HOST_P=
AGE_SIZE, prot_new);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prot_new &amp; PROT_WRITE) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(g2h_untagged(st=
art), 0, end - start);<br>
&gt; @@ -289,7 +289,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong=
 size, abi_ulong alignment)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (start =3D=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start =3D mmap_next_start;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 start &amp;=3D qemu_host_page_mask;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 start &amp;=3D HOST_PAGE_MASK;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 size =3D HOST_PAGE_ALIGN(size);<br>
&gt; @@ -297,7 +297,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong=
 size, abi_ulong alignment)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (reserved_va) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return mmap_find_vma_reserved(start,=
 size,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (alignment !=3D 0 ? 1 =
&lt;&lt; alignment :<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MAX(qemu_host_page_si=
ze, TARGET_PAGE_SIZE)));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MAX(HOST_PAGE_SIZE, T=
ARGET_PAGE_SIZE)));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 addr =3D start;<br>
&gt; @@ -478,8 +478,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong le=
n, int prot,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 real_start =3D start &amp; qemu_host_page_mask;<br>
&gt; -=C2=A0 =C2=A0 host_offset =3D offset &amp; qemu_host_page_mask;<br>
&gt; +=C2=A0 =C2=A0 real_start =3D start &amp; HOST_PAGE_MASK;<br>
&gt; +=C2=A0 =C2=A0 host_offset =3D offset &amp; HOST_PAGE_MASK;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* If the user is asking for the kernel to fi=
nd a location, do that<br>
&gt; @@ -498,38 +498,6 @@ abi_long target_mmap(abi_ulong start, abi_ulong l=
en, int prot,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 /*<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* When mapping files into a memory area larger th=
an the file, accesses<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* to pages beyond the file size will cause a SIGB=
US.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0*<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* For example, if mmaping a file of 100 bytes on =
a host with 4K pages<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* emulating a target with 8K pages, the target ex=
pects to be able to<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* access the first 8K. But the host will trap us =
on any access beyond<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* 4K.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0*<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* When emulating a target with a larger page-size=
 than the hosts, we<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* may need to truncate file maps at EOF and add e=
xtra anonymous pages<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* up to the targets page boundary.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 if ((qemu_real_host_page_size() &lt; qemu_host_page_siz=
e) &amp;&amp; fd !=3D -1) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct stat sb;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fstat(fd, &amp;sb) =3D=3D -1) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Are we trying to create a map beyond E=
OF?.=C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (offset + len &gt; sb.st_size) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If so, truncate the=
 file map at eof aligned with<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the hosts real page=
size. Additional anonymous maps<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* will be created bey=
ond EOF.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D REAL_HOST_PAGE_ALIG=
N(sb.st_size - offset);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!(flags &amp; MAP_FIXED)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long host_start;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *p;<br>
&gt; @@ -539,8 +507,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong le=
n, int prot,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Note: we prefer to control t=
he mapping address. It is<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* especially important if qemu_host=
_page_size &gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* qemu_real_host_page_size<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* especially important if HOST_PAGE=
_SIZE &gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TARGET_PAGE_SIZE<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p =3D mmap(g2h_untagged(start), host=
_len, prot,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fl=
ags | MAP_FIXED | ((fd !=3D -1) ? MAP_ANON : 0), -1, 0);<br>
&gt; @@ -581,7 +549,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong le=
n, int prot,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* aligned, so we read it<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd !=3D -1 &amp;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (offset &amp; ~qemu_host_pa=
ge_mask) !=3D (start &amp; ~qemu_host_page_mask)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (offset &amp; ~HOST_PAGE_MA=
SK) !=3D (start &amp; ~HOST_PAGE_MASK)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* msync() won&#3=
9;t work here, so we return an error if write is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* possible while=
 it is a shared mapping<br>
&gt; @@ -614,7 +582,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong le=
n, int prot,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* handle the start of the mapping *=
/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (start &gt; real_start) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (real_end =3D=3D real_st=
art + qemu_host_page_size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (real_end =3D=3D real_st=
art + HOST_PAGE_SIZE) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* one s=
ingle host page */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D =
mmap_frag(real_start, start, end,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prot, flags, fd, offset);<=
br>
&gt; @@ -622,21 +590,21 @@ abi_long target_mmap(abi_ulong start, abi_ulong =
len, int prot,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto fail;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto the=
_end1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D mmap_frag(real_star=
t, start, real_start + qemu_host_page_size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D mmap_frag(real_star=
t, start, real_start + HOST_PAGE_SIZE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prot, flags, fd, offset);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D -1)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fai=
l;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_start +=3D qemu_host_p=
age_size;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_start +=3D HOST_PAGE_S=
IZE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* handle the end of the mapping */<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (end &lt; real_end) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D mmap_frag(real_end =
- qemu_host_page_size,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_end - qemu_host_page_size, end,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D mmap_frag(real_end =
- HOST_PAGE_SIZE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_end - HOST_PAGE_SIZE, end,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prot, flags, fd,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offset + real_end - qemu_host_page_size - star=
t);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offset + real_end - HOST_PAGE_SIZE - start);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D -1)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fai=
l;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_end -=3D qemu_host_pag=
e_size;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_end -=3D HOST_PAGE_SIZ=
E;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* map the middle (easier) */<br>
&gt; @@ -676,7 +644,7 @@ void mmap_reserve(abi_ulong start, abi_ulong size)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 abi_ulong end;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int prot;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 real_start =3D start &amp; qemu_host_page_mask;<br>
&gt; +=C2=A0 =C2=A0 real_start =3D start &amp; HOST_PAGE_MASK;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 real_end =3D HOST_PAGE_ALIGN(start + size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 end =3D start + size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (start &gt; real_start) {<br>
&gt; @@ -685,14 +653,14 @@ void mmap_reserve(abi_ulong start, abi_ulong siz=
e)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (addr =3D real_start; addr &lt; =
start; addr +=3D TARGET_PAGE_SIZE) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prot |=3D page_get_fla=
gs(addr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (real_end =3D=3D real_start + qemu_hos=
t_page_size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (real_end =3D=3D real_start + HOST_PAG=
E_SIZE) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (addr =3D end; add=
r &lt; real_end; addr +=3D TARGET_PAGE_SIZE) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prot |=
=3D page_get_flags(addr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 end =3D real_end;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prot !=3D 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_start +=3D qemu_host_p=
age_size;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_start +=3D HOST_PAGE_S=
IZE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (end &lt; real_end) {<br>
&gt; @@ -701,7 +669,7 @@ void mmap_reserve(abi_ulong start, abi_ulong size)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prot |=3D page_get_fla=
gs(addr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prot !=3D 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_end -=3D qemu_host_pag=
e_size;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_end -=3D HOST_PAGE_SIZ=
E;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (real_start !=3D real_end) {<br>
&gt; @@ -727,7 +695,7 @@ int target_munmap(abi_ulong start, abi_ulong len)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 mmap_lock();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 end =3D start + len;<br>
&gt; -=C2=A0 =C2=A0 real_start =3D start &amp; qemu_host_page_mask;<br>
&gt; +=C2=A0 =C2=A0 real_start =3D start &amp; HOST_PAGE_MASK;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 real_end =3D HOST_PAGE_ALIGN(end);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (start &gt; real_start) {<br>
&gt; @@ -736,14 +704,14 @@ int target_munmap(abi_ulong start, abi_ulong len=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (addr =3D real_start; addr &lt; =
start; addr +=3D TARGET_PAGE_SIZE) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prot |=3D page_get_fla=
gs(addr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (real_end =3D=3D real_start + qemu_hos=
t_page_size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (real_end =3D=3D real_start + HOST_PAG=
E_SIZE) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (addr =3D end; add=
r &lt; real_end; addr +=3D TARGET_PAGE_SIZE) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prot |=
=3D page_get_flags(addr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 end =3D real_end;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prot !=3D 0)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_start +=3D qemu_host_p=
age_size;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_start +=3D HOST_PAGE_S=
IZE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (end &lt; real_end) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prot =3D 0;<br>
&gt; @@ -751,7 +719,7 @@ int target_munmap(abi_ulong start, abi_ulong len)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prot |=3D page_get_fla=
gs(addr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prot !=3D 0)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_end -=3D qemu_host_pag=
e_size;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 real_end -=3D HOST_PAGE_SIZ=
E;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ret =3D 0;<br>
&gt; @@ -784,6 +752,6 @@ int target_msync(abi_ulong start, abi_ulong len, i=
nt flags)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (end =3D=3D start)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 start &amp;=3D qemu_host_page_mask;<br>
&gt; +=C2=A0 =C2=A0 start &amp;=3D HOST_PAGE_MASK;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return msync(g2h_untagged(start), end - start, fla=
gs);<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h<br>
&gt; index b0b2c249fb..7553ac154c 100644<br>
&gt; --- a/bsd-user/qemu.h<br>
&gt; +++ b/bsd-user/qemu.h<br>
&gt; @@ -44,12 +44,10 @@ extern char **environ;<br>
&gt;=C2=A0 #include &quot;accel/tcg/vcpu-state.h&quot;<br>
&gt;<br>
&gt;=C2=A0 #include &quot;qemu-os.h&quot;<br>
&gt; -/*<br>
&gt; - * TODO: Remove these and rely only on qemu_real_host_page_size().<br=
>
&gt; - */<br>
&gt; -extern uintptr_t qemu_host_page_size;<br>
&gt; -extern intptr_t qemu_host_page_mask;<br>
&gt; -#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)<b=
r>
&gt; +<br>
&gt; +#define HOST_PAGE_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 MAX(qemu_real_host_=
page_size(), TARGET_PAGE_SIZE)<br>
&gt; +#define HOST_PAGE_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((intptr_t)~(HOST_P=
AGE_SIZE - 1))<br>
&gt; +#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), HOST_PAGE_SIZE)<br>
&gt;<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* This struct is used to hold certain information about th=
e image.=C2=A0 Basically,<br>
&gt; --<br>
&gt; 2.34.1<br>
&gt;<br>
</blockquote></div></div>

--0000000000006b02a906510adead--

