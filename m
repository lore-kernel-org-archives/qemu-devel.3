Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F236CD5BB1
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 03:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQccy-0003BB-Sx; Fri, 22 May 2026 23:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wQccx-0003Az-TF
 for qemu-devel@nongnu.org; Fri, 22 May 2026 23:02:15 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wQccw-0007XO-9J
 for qemu-devel@nongnu.org; Fri, 22 May 2026 23:02:15 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5a40b2bc96dso2523230e87.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 20:02:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779505330; cv=none;
 d=google.com; s=arc-20240605;
 b=P5yn1nxTg21iCtiVUh60WYDgBp5TNV043GHyANu1FiM7bOiRTsV+BpQFn9IOl+LKlU
 r6J6C+R6WZdQ70sfzBmzCaRiLFkiADjZJvJyaV40xkz2XAbRIem2s9c/0QZWzSmk1192
 bmdN9uAPgk3y67DD+nmgvp2d2KCLfLQdwFTvJ38dCnYabVu1th15oex+34IVRiiNFQaG
 ek9c5/Ag7eDrK64QTsZMnWgNfXWpkI40wZAndUDzwJYfm4UwzNs6//kRxnaEP+x9SLDE
 cY0L265KffqwW2JYSkYrEwuQoe10k8X8pfHE3rob2G+yMni9gKojhzKTghA3WZ0taj1D
 Kh4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9OrXoH+s67rqxADLLuN3uOKdYzvNoqv5MOaNwiN8L2E=;
 fh=5rq+NvCvbvAOcXIJg0LMYJyR9Gfg1ZTvjJ/iB5Irlf4=;
 b=X4VyrwSnTQg8+v2YdmUQ+4OYXgxphSMTt6E6S0PhAJ76/OjRX1Oles5zDIYIWkm0+a
 fn2/H7vh/kdpaUFCjaGDAXgSeAvHhXUo5bw7w70R1KPM/rB5RCsThEyCywQ6nehQh6L5
 VSw8Lc5Rz0P4Nw/dz1+IYJCBlAVk13wf3KZ8kRGNh+6BIm6Wf1/wyw7rt1CAA6KYPXHr
 IzUqM/4Vnb2LtGkvv7NW7iB0pRfD4/FOkkTemHjr78fnddQzLo1nVgBlW9CYJVwtK6Gf
 9sAlsFZ7UVIWlw6cTHx96mS3+0MNB22IFALLaQbiAxNkeSTEccfDjWJ+XGVTeJZ9zLDM
 oCLg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779505330; x=1780110130; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9OrXoH+s67rqxADLLuN3uOKdYzvNoqv5MOaNwiN8L2E=;
 b=N+rS3CX36FaJRw5CCf8HGIPCG1M4OU4krL7SzVKT/47mXs+EGcx9FsQEfWGmOKGfeP
 svtoZb3DdmhTWn3JBUJluzmSNJ81jCJ1tlGzazGYDf/GWF6qDkS9MrQ6hxjemD4BcYM/
 qUMkBvPpa5O5rTxBB4OnqwatppKu2z8qI8WpczjeObDC6vlGcjqeypEOOCzDibxpF/Fw
 AWeoyNtLjJg9qOohLElQhcjqDO6naISr07SMC8QPxIhHmQmZkLnJY0cnihgYG+qGTpE7
 rj0d1U9hbwUI2hqs2ADRxeSrae+vb7p1nOyBK00t4r+/f3iqe+j7sNqxHk1s4hDPUQTv
 oBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779505330; x=1780110130;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9OrXoH+s67rqxADLLuN3uOKdYzvNoqv5MOaNwiN8L2E=;
 b=U0m6emQYHlqZ+IieaErvbSYg2jgUXtJ8rGBRrnqH0FWH3plEIXXpUZO/+MRHnFVnEP
 QASuOSOOibK82U4u15PDkBPpRyZ0Qxn5Ohgv61DX4hqUGxiONO3T3dI4nN0h/DtGfq1i
 UVEuyX7vJHAQyEeE2q0EH81x6Zu10FGd+/xVyKzYbc2XfbzduVHuTB1rkgUsiuR4Lpow
 P/FJPpSwyMx3pk1mw8sClB9eo6sK1/ttQY+uH7p+8s5yyLk0Tqy0HVYHDNjaNjcpNWZF
 SorvNILYW9HNs0bNPAXkEL18bWDjRcgmOyDNxgAbiXE2KhMyyvegYRQAPYjbD+nUGgb6
 WdFA==
X-Gm-Message-State: AOJu0YwDBv5O5lfPCUM24oHf2M1X4ZksSfNF1lzNQ4pZJ6IIjf1XMmkk
 jz6symGs9S9amA+e7eXWb3BDwAsNyVtuzGdRDrJTyP/Mfj/BPotzP6IYQOu80JXnykJbXDa25EO
 DS6XDOviq7v8omOnqYj27BjAWftOVa3U=
X-Gm-Gg: Acq92OE4M6VfNAFZf9rXeMAUBvgvU6SnxeF7tHzkswJJrUWBLE5ALgOdPNNioV6WYFR
 cwTwZpVWfuwiWOOBfsnBotQFxM75euvr/K+sQ2n7pcbAfSoevjgjVix6PudOtsfmHsPbuv1tiDB
 Biy8gyGxO/V+W/PP5i/kTiaBFFwuiesOT/QtSGhfaQLJVuNQNDztb4GZ1D9IVpFlDlWXlTFrFa2
 i2fU+UpyO+ffXnmfscSLL9qLryl2pqX7Frn44jXUpHUsjeuIYqErlAHxrKmLwISsyczIlV2A4IC
 WpBAUeF/dtTxx8A0eVNtVCYcEj5x1HRa+kbImsM=
X-Received: by 2002:ac2:532c:0:b0:5a8:7425:565b with SMTP id
 2adb3069b0e04-5aa32369eaamr1539050e87.7.1779505330177; Fri, 22 May 2026
 20:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260514075136.301706-2-aadeshveer07@gmail.com>
 <ag4PFEdJ9yIhtB_E@x1.local>
In-Reply-To: <ag4PFEdJ9yIhtB_E@x1.local>
From: Aadeshveer Singh <aadeshveer07@gmail.com>
Date: Sat, 23 May 2026 08:31:57 +0530
X-Gm-Features: AVHnY4JuhOGksK9nBPYk4ww95_nSgplZPZ7pp0dbwJywNueaO7rrTKkyZ1e7Bbc
Message-ID: <CA++cPvJzHL9buo_TRk1no6Hju61xSuxrG5bebpz0KNhJtSEGFg@mail.gmail.com>
Subject: Re: [PATCH] migration: use eventfd functions instead of bare
 read/write
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=aadeshveer07@gmail.com; helo=mail-lf1-x132.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Peter

Understood about the windows build issue. I will drop this patch for
now and focus on the main GSoC project as suggested.

Thank you,
Aadeshveer

On Thu, May 21, 2026 at 1:14=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, May 14, 2026 at 01:21:37PM +0530, Aadeshveer Singh wrote:
> > Replace read() and write() syscalls on eventfd with glibc wrappers
> > eventfd_read() and eventfd_write(), to make code more robust, readable
> > and future-proof.
> >
> > Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> > ---
> >  migration/postcopy-ram.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index f5ef93f193..16113b166d 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -1330,12 +1330,12 @@ static void *postcopy_ram_fault_thread(void *op=
aque)
> >          }
> >
> >          if (pfd[1].revents) {
> > -            uint64_t tmp64 =3D 0;
> > +            eventfd_t tmp_event =3D 0;
> >
> >              /* Consume the signal */
> > -            if (read(mis->userfault_event_fd, &tmp64, 8) !=3D 8) {
> > +            if (eventfd_read(mis->userfault_event_fd, &tmp_event)) {
> >                  /* Nothing obviously nicer than posting this error. */
> > -                error_report("%s: read() failed", __func__);
> > +                error_report("%s: eventfd_read() failed", __func__);
> >              }
> >
> >              if (qatomic_read(&mis->fault_thread_quit)) {
> > @@ -1773,13 +1773,11 @@ void postcopy_temp_page_reset(PostcopyTmpPage *=
tmp_page)
> >
> >  void postcopy_fault_thread_notify(MigrationIncomingState *mis)
> >  {
> > -    uint64_t tmp64 =3D 1;
> > -
> >      /*
> >       * Wakeup the fault_thread.  It's an eventfd that should currently
> >       * be at 0, we're going to increment it to 1
> >       */
> > -    if (write(mis->userfault_event_fd, &tmp64, 8) !=3D 8) {
> > +    if (eventfd_write(mis->userfault_event_fd, 1)) {
> >          /* Not much we can do here, but may as well report it */
> >          error_report("%s: incrementing failed: %s", __func__,
> >                       strerror(errno));
> > --
> > 2.54.0
> >
>
> Unfortunately this will break win builds.  It's because these functions a=
re
> compiled even for windows, and windows doesn't have eventfd.
>
> Ideally we shouldn't compile postcopy code in windows at all.  So it's no=
t
> really this patch's problem.  But fixing that would either need temporary
> CONFIG_LINUX check here just to use the glibc API or a larger refactor to
> opt-out compilation of postcopy.
>
> I'll drop this patch for now.  Aadeshveer, if you want you can try to hav=
e
> a look later on how to not compile postcopy code for windows.  For now, I
> suggest you stick with the gsoc project.
>
> Thanks,
>
> --
> Peter Xu
>

