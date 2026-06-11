Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1298CD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 13:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXfd8-0001OO-Tj; Thu, 11 Jun 2026 09:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wXfd7-0001NV-IF
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 09:39:33 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wXfd5-0005Za-Pu
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 09:39:33 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6914a658115so7693157a12.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 06:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781185170; cv=none;
 d=google.com; s=arc-20240605;
 b=SD36qHzw05MzC1RPpRbtRv9lLNVhZaIvw3PtWbaso9gtJfkYrNtAgy+PZ+ljc88MzT
 gRY1PjQV9pgAUjn9L184Tnj6xcBgij3ODabTh6xIB27TnwRlZXCRkOHbRUpRFyq9Lfiz
 CwozuwJ58PFXibc/xgVFL9JYtcczbeGuuwz9caxGAfva/DyoFIMN88ARw8kzFLXy6FOB
 f8RK2fGSZMLqPhnJl/ayFumqcyan4J63sGxlX77HFh8UNA+kGu039A4QF3JR8DVFOQRC
 3opjOBaM8iG9U47HCpsEVXAkw00HIL/MGfIn+lDfZyadsWdmAht0obI8MRKz2bRJ7pBB
 1jcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d843nBiDtDCTxzQ8Jv4xQNcAeQVgmuNxcgSIK3lLSHo=;
 fh=BJxahEH8suyfbByZfu9o6Xn8V/V1E8GSMTtT013s50M=;
 b=WZJ6BNVfaqSE3Tk41dgPckGy1eQSgBU84cMeI4/VTWHlaAHDvJTmhA9djd/dV1ZMj4
 /1byj17xwnc5zgd3aeZHt6lAX/l7VwKEEyIvLO2tnDY3mh3UrFd1GB30/wFuVJIe9sGu
 NcIgsyauz1aD1pqZBDYuOtDkPvXyAhpjTGOsh6Ddv+JOJu9B+RXd3J11NZDj3t01VQk9
 73O7zz7WzNhhCHyUQRiVedvbh/97waQH+n3uRjcSHW0Efb1+utSQl3nXfxQFuID7SIfT
 ytoePy4nGXbRwr7dmF/35gKSWC17t65UkgGd1p3gEFMGHsqK2E9ZP/YyjOUKk/T4DxLV
 UmAA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781185170; x=1781789970; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d843nBiDtDCTxzQ8Jv4xQNcAeQVgmuNxcgSIK3lLSHo=;
 b=sk4KN+0zao5sG4irGxVLH1YLnEFn1qxY7bjIUNqiN3swxBeezWxm/2FsxZrmWYwNo4
 IiRY9J/elHGSX+T+2aNAtgtkvkai6KZ4d4Gf8xXSOioPGDYZ94jhPfiLSknWPh+mb6qO
 Dx6nspk21qslf3QJfmxiv/esV7WN/8CxQvsxf1qXVq4oUdCLX5Kl8GAU422/dkRO9WGc
 dIVGUxgJwRjQ8rI72qkkMtcafYrWBVFWjCXUzg9GeXEpBF05Qow60zN4W1HKbPtYbU7B
 0+9MpUPPWSSjCLiK0wVxzZjr5U6KCPbCS3cQ96Z1x1N7tnjGP29lusffewty1qx2ho3V
 q+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781185170; x=1781789970;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d843nBiDtDCTxzQ8Jv4xQNcAeQVgmuNxcgSIK3lLSHo=;
 b=IYyR0gW8cGzXYqgyGlyjVu6f4LBA9xSoSRbhawcCE53Fga5aQTaH6isv6FMK+2JK5e
 WUWl0PYj3gV8eioDUakCBGB33TEAcOHQNn38VdYZZYmTm9rhwWYs7LrUUq307RIwVypM
 gGvx24i9Rbh6yRNR03zgnir++Yv+ZRPHWf4Kkx+UEHvjGXFPTZB+M6Xm1NPkf9w2rXh4
 Z0iUfkse6dtrffG69Zxsg5PwsrgHeKsfXXQkPwdcp+Pu7asSdBmP/J/nMRm+Oo14rr4Z
 bO6auhZLnjWRdBju6G2UO+fx40jXgay6PG6Gy6C+MWKqjdLz1iLq8kX3pohymYXWl8wa
 FRNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+HFroqPLwxs0/65Oy59xmKhRk1Y0rUrUYWi1VOSqjoWdXpWcT6f1DTd3m/0tEJp/os6LmC23RHJYCp@nongnu.org
X-Gm-Message-State: AOJu0YwUGKcm+u41YWsKMwx9KzFlM8JPDp6AUbIpOR3G4+HLtw7cEGm4
 pvrYqxz9D9nXol7FgBGeHGiZderCC7XREwiRMJ5bDs0AiRWD/GNiKqzi54fxCfsi75uFNK0Oj6E
 Q12pSfQ9lu0eZ4iDb4I9msrjj7gAJd2g=
X-Gm-Gg: Acq92OEtK3AkVhSQu9kDQFeLv5o57uVjufbwqEG8b94J0B6JiMTzJqBM1cKDubVBJbE
 PkCHQkhG6F/j5AR6Yrfde0FXE0JhBfza6Pxr8rOrwyp7HjZOeneW45TOThfqHJyNC1S7zqJLBuX
 Fm/94vqFiVuT2sh4YXDGvTPUZs+VFpNTMKLbA6a5APutYk4yUuuPKrZTgIHCyCK+CWqvZkfSwbs
 Kiu0G5KSmHhqK8YqNEnkd5/QGTIAVpmXtX28BiaAaRfbuFMkGxm0twhBnnYNFtX2589WUluh59L
 9Q5YXoEHrBCvhl2rP7pax3IXw787SohP6c7x/SHC/7l7xhW+Db7K
X-Received: by 2002:a05:6402:1f85:b0:687:285d:44a3 with SMTP id
 4fb4d7f45d1cf-6930e31ff26mr1877729a12.15.1781185169505; Thu, 11 Jun 2026
 06:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260603193813.2327596-1-farosas@suse.de>
 <0e8ad49f-1d0e-467e-88b9-5a8462eac6a7@tls.msk.ru>
In-Reply-To: <0e8ad49f-1d0e-467e-88b9-5a8462eac6a7@tls.msk.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 11 Jun 2026 09:39:16 -0400
X-Gm-Features: AVVi8Cf1o_PMspjyeLhfGfpHpnDtMeglqe47jjbdoYu_4XPABor833JXzlFjcAA
Message-ID: <CAJSP0QX-01g9EH5dtXMOUuzscPTYspaWnUFjT08oXq78oVgScA@mail.gmail.com>
Subject: Re: [PATCH v2] qed: Don't try to flush during incoming migration
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, berrange@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x532.google.com
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

On Thu, Jun 11, 2026 at 12:08=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> w=
rote:
>
> On 03.06.2026 22:38, Fabiano Rosas wrote:
> > It's not possible to access the image file while there is an incoming
> > migration in progress, the QEMU process doesn't hold any locks to the
> > storage at this point so nodes are inactive. Attempting to flush leads
> > to an assert at bdrv_co_write_req_prepare():
> >
> >     assert(!(bs->open_flags & BDRV_O_INACTIVE))
> >
> > The issue is reproducible by running iotest 181 on a host under cpu
> > load. The migration must coincide with the header already containing
> > the QED_F_NEED_CHECK flag.
> >
> > The sequence of events is as follows, with the respective call stacks
> > referenced below:
> >
> > During block device init, bdrv_qed_attach_aio_context() starts the
> > 'need_check' timer. The timer will not fire during incoming migration
> > as it uses QEMU_CLOCK_VIRTUAL (to avoid this very issue, as the code
> > comment indicates).                                                   (=
0)
> >
> > However, there's still bdrv_qed_drain_begin() which uses the fact that
> > the timer is live to decide whether to start the
> > qed_need_check_timer_entry() directly.                                (=
1)
> >
> > The qed_need_check_timer_entry() eventually calls into
> > qed_write_header() -> bdrv_co_pwrite() leading to the assert.         (=
2)
> >
> > Skip creating the 'need_check' timer whenever the image is inactive.
> ...
> > Note that this issue is not exactly the same as what's been reported
> > in Gitlab, but given how easily this reproduces, I imagine it has to
> > be happening in that setup as well.
> >
> > Link: https://gitlab.com/qemu-project/qemu/-/work_items/3515
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> >   block/qed.c | 16 +++++++++++-----
> >   1 file changed, 11 insertions(+), 5 deletions(-)
>
> I'm picking this one up for the active qemu-stable series.
> Dunno how popular qed is these days, though - back in the day it was
> a useful alternative to qcow2, now it feels more like a toy :)

I'm not aware of users based on the lack of bug reports and patches.

Stefan

