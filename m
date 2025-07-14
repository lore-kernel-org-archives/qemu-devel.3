Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5F6C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 09:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubFJO-0001Qt-Lc; Mon, 14 Jul 2025 05:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubEsD-0003mL-G9
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:49:21 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubEs9-0004Dg-Kv
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:49:20 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-714067ecea3so30887717b3.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 01:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752482955; x=1753087755; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BoNB8LR2Eg0l7LMAsKTSUC90QiCrR2pXBPaam0h2ohk=;
 b=wRG/zHzIUG3H9N4LAbUHLu626qMpmTLbKJ2gWTtLKXTz1kfoVRlE3rZmzj6QR3znW2
 Ys66pV3cqS0lHzZHUwIJY1dlLlmySonXlAGKaBbyZ9RgD3NxMzd5DFOMSDDCI/J+xhrJ
 X2eULFJD/7rYEoR1wRwDMpWgZuhQ32c8+7mUiLLSHHYwsrULZ8HmUC7ONK7Z1WDJEz+S
 pZDJZJ8BYqHn0bxera0SGs+APs6aMy+ozcum31w1jyvSajUgNcg8wvZy6E7qkQL9M6Bk
 XN8/rA3xQOKKQnMWNg8v3QEy8i+EY/4GfwLQvkbJV0im6KabZ/WCNqh4ZZecf1cYka1K
 HBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752482955; x=1753087755;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BoNB8LR2Eg0l7LMAsKTSUC90QiCrR2pXBPaam0h2ohk=;
 b=ftXFPcQdAmIyP9cTZ2Ddd/Fn//iU3VDzi2QnZ3mB7VagM08hF41kVLrEQW80Qj4+Ti
 nME/o1dBR2k41a6z2EE76r6qFUCgvVVzG2gkhOoaofZIkgNR4rFBodMMnrnB+cilpaOL
 W9aP343j5Csbp6J9ic1Rql4QAJj7dFeBILsoM6vJx7BvC96aWfoyqzJZl+IRLVFgw8dj
 x18Y/jb3AdveMIDolXDGORD5qkStUawfkb43RFtwA/pKQlvtKEitxLHp9j7O5lOon3JF
 srV57jP4hrQjd43UflC1eA8Xtr5YQ3c0ui3tVKfIwavRxPeP0zxaZPf+q0OUBVZXSWO6
 8a6g==
X-Gm-Message-State: AOJu0YzSMY1O9AapbvggH4qj8aQkz7eDldT2zAcAJCIiRhmNk3aSjRHy
 6MPdGZs/Dbzlt5Tk7Vik6PjarjUoIL3eHTJ4BIS83YcOVqDNzOkPaanb0Kjq+wEVW1qilZzUEQI
 55yZyUdVZL2mUrQJ6sHvjoEvAYbTuDurTd6PMoJddpQ==
X-Gm-Gg: ASbGncuWmiwTgD5NLwAUbD2qrxyeXP5T24rtjn79SRYCmlV1QLynLmzAka9JIKqGufR
 PlrfebsIqrZ30jy5ZxJcn3jt1RFACQmL2rlNuNUgTj/JaMFakxiIdjQcP7C+4f9tKDO0BhU2id5
 FzyWp6zj2dN6hfM4Uj99mcS5EKQVFYNup+seaLKQQT19z45++8k6eXvEmzd+sCYXkjg92kKxBD5
 Bx0m+6I
X-Google-Smtp-Source: AGHT+IEYUH+hoUFWfcfV3STt4Fh2nHPuK3kNQHS3N1xzX/ndpFJjG9FPwgSu/yZvvHAS6KnZRV7KWoRfCqGKfKeTD2g=
X-Received: by 2002:a05:690c:f0f:b0:70d:ed5d:b4dd with SMTP id
 00721157ae682-717d7a115efmr180889727b3.25.1752482954887; Mon, 14 Jul 2025
 01:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250711145012.1521936-1-peter.maydell@linaro.org>
 <87ecumu09l.fsf@pond.sub.org>
In-Reply-To: <87ecumu09l.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Jul 2025 09:49:03 +0100
X-Gm-Features: Ac12FXxn6fzczMbSqirBKZfPutrP9VwjFyZCdwJrnGbciwetQTDgakwcq24A6SY
Message-ID: <CAFEAcA8+SBMqzBgOcAp-EV7m9atFXnadxynPmGgENXr_PS5=cA@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/ivshmem-pci: Improve error handling
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Fri, 11 Jul 2025 at 18:04, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Coverity points out that the ivshmem-pci code has some error handling
> > cases where it incorrectly tries to use an invalid filedescriptor.
> > These generally happen because ivshmem_recv_msg() calls
> > qemu_chr_fe_get_msgfd(), which might return -1, but the code in
> > process_msg() generally assumes that the file descriptor was provided
> > when it was supposed to be. In particular:
> >  * the error case in process_msg() only needs to close the fd
> >    if one was provided
> >  * process_msg_shmem() should fail if no fd was provided

> >      if (msg < -1 || msg > IVSHMEM_MAX_PEERS) {
> >          error_setg(errp, "server sent invalid message %" PRId64, msg);
> > -        close(fd);
> > +        if (fd >= 0) {
> > +            close(fd);
> > +        }
>
> Coverity is overly picky.  close(-1) is *fine*.  Just like free(NULL).

I think there is a distinction here. free(NULL) is documented
to be a correct program action which must have no effect.
close() on a bad file descriptor is documented to be an
error, which the implementation is supposed to diagnose.

Also, Coverity flags this kind of thing up because it tends to
indicate that whoever wrote the code was not actually thinking
about the error condition; so when it gets caught later this
is more by luck than judgement.

thanks
-- PMM

