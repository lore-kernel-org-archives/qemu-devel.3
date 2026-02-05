Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BC8ECD980
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 16:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo1x3-00006T-Cf; Thu, 05 Feb 2026 11:11:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vo1x2-00006B-G9
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:11:28 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vo1x1-00026W-08
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:11:28 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6594382a264so2354616a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 08:11:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770307885; cv=none;
 d=google.com; s=arc-20240605;
 b=bTOSb0ZSfNLU71EP46JxKCSTbIECoUs7NIyA15MsqREAN8Y5BsdQYHhzimvHmn2BH5
 H0CISLJbNwQ3WGnlbP7XNZizM2uWeVfNG7Q2jwPx2YbWLu15o2XbRT34KVa6c32iOAxq
 4lhao7EeWc05JZcx6XcscWfKXYt4R2j+LB0YbvqL2pmM/DZCh2a2oP4CPoPhheu9/p44
 Yo0vKe32m0J/Vpd+PB5t5g0cz1HqTjgZaNyrctBU3qv+Dpu5CALs+nTU4lOB/cnhVgSs
 01rRKfXOc5mSctLJUeP3yTgDacIZX+lHNymUpRt2aJqi+ko1AaxBisuD6+dT7zTufniU
 G56g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZodA6au8gAzZw05Pd/QZNurvhKhX6fWfkQaz+xZeCXk=;
 fh=30rw4qnSN8oaVlmU4JTRQtGnXmvUslDYe6VJB4BfjUg=;
 b=iR094md/Y9BN4Pkvs/0p0XSfZTNqtkgVpx28WD9DMIqwDJfbbjX4ZujcgoDafYNzQL
 4F/GiubMICQNuVqPr8xJC4+j83a1jQ1XostDWE2vS+cJUXQOAXOATgIhBGiRwBpfG4ug
 yPUWmV8DGbSl20TmG3nkNVt7RuHddcca6mYY4yxU/L3VITl2VCk9doJy9jc7hgmwmLNM
 tjFoBHY9TpmYvjvZ5qCnp3lMHPBc5AjCifd/Gq64Ya1ehgjy5dt8NjzBoDjL+7L3oWIB
 u2w1YIx5G4V2jZ11Zv7MLLH2sN+KwXp9V0xVxuCbva/mj+VTuwCstxRNBiJ4AHG7nqX8
 U3pQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770307885; x=1770912685; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZodA6au8gAzZw05Pd/QZNurvhKhX6fWfkQaz+xZeCXk=;
 b=VIUGVgmFzGRSxcyoLchfna0IRiVwTS9bFi+kffprA/g5D3crKS6xBnkN9UyRT/oNBq
 vG59MMAEkinQNY8IqbtejcCy8omZ0DVy7KKqdQJazHbLnOX7k51CDQ615hvrxVBeVJuO
 WicdW1lgxRSoVjp7Hw7upoBUXoOICZ5dslPmTZGVocikph9x6KCGfM95SJVzgjPmU6fj
 NF2NIHmysYh4grIZ+6bJqodMufbjQEX8CshU9DcgJL1KDDspO0FvDIvKDwAGGlKhcpUt
 237Lu5aW/NTk+FiqhYP1Fyp+n0MtKShwhC6HlvMb+05msfr8FfzU8Mx47SB6XuDcVzhp
 0qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770307885; x=1770912685;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZodA6au8gAzZw05Pd/QZNurvhKhX6fWfkQaz+xZeCXk=;
 b=V404OY9JXiRV2twgS9CQsr99qZNvVpfkwRq4TaPnW8zVLqry5xd1wFSKVrmjE/otzd
 5vm5Rse/JNcCkYRQqEO42Cxj7MHmkaTMeck9VzOcDnPg3axCk9FHZsMTvU0ONHm6yrse
 UQalCxYwzRvw5xoCgzhUXdKPDvrEYcJA3jFTcqLX0JQT3pvvUIXNq0AhyMVDEcKYG4IC
 XofVglW7t6U+4sylG54RIChX/oTmS4vJehln/6MNt9ZewonSkL77AvMRWd/jvuhFssVr
 nQUHXwOAhIpjcm2QVjWCRrv1aYkPU15bFb0Tvc5Wi0ASGL1mf8CQfYnwBcvDtQbTAU4y
 /0EQ==
X-Gm-Message-State: AOJu0YwqfRHCD+POBraPNkNoFHRUiZjQdArMVjvbT+QYITEVMlwvziNp
 lrhQsEAGSbGurHXqSI8iQsA3Iqsaa3stwsAJemIJLV5WfOwKsZjcxaq+hQa9Ibn6mWQ5j/+6k7f
 FiIeAvgxLRBCYk59x+c4trTwkWPoBx5k=
X-Gm-Gg: AZuq6aL8Jt/MM93HPg7BGIWaBNiksRawoAfopVDIkB3lNHVVHpjlpB0sFQUS2V8o7c/
 HiB4kMOkmq6W0Si7eeBUa0Ehz/QZxFK2ERch4QOlLcldYydmAQar1o36GoNkDzOsyAB5x/x0TnM
 aCMhEwW7ui8QhxvQ8bBlDgJMGmHnT96Xqub4vhDpx6DuuoXcgOntue1xOaq9Po+bO7gMooCB+bx
 LR7n21hfO+hyl4e+4kK+igAbZ5nThK6BK/gITVikimWlWpJjswG9rf+WbJmvmlNCEUY3g==
X-Received: by 2002:a05:6402:4316:b0:659:3ed2:13dd with SMTP id
 4fb4d7f45d1cf-65949ab242bmr4728560a12.4.1770307885174; Thu, 05 Feb 2026
 08:11:25 -0800 (PST)
MIME-Version: 1.0
References: <20260126094422.23116-1-zhangckid@gmail.com>
 <20260126094422.23116-2-zhangckid@gmail.com>
In-Reply-To: <20260126094422.23116-2-zhangckid@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 5 Feb 2026 11:11:12 -0500
X-Gm-Features: AZwV_Qiq1hmug-4VHT9_xus7Cd63rRqSnjES12IkLQP9k1TrwuMMqLEH56VLx74
Message-ID: <CAJSP0QVNJW==wVom++7WERQUXViJOsfzuraveXBxfnQ1LVzXpQ@mail.gmail.com>
Subject: Re: [RESEND PATCH V3 2/3] iothread: Introduce a new flag to show
 iothreads attached status
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
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

On Mon, Jan 26, 2026 at 4:52=E2=80=AFAM Zhang Chen <zhangckid@gmail.com> wr=
ote:
>
> QEMU Need a flag to show current iothread attached status
> when hotplug multi iothreads. For example virtio-blk.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  include/system/iothread.h | 1 +
>  iothread.c                | 5 +++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/include/system/iothread.h b/include/system/iothread.h
> index e26d13c6c7..3d00474523 100644
> --- a/include/system/iothread.h
> +++ b/include/system/iothread.h
> @@ -32,6 +32,7 @@ struct IOThread {
>      QemuSemaphore init_done_sem; /* is thread init done? */
>      bool stopping;              /* has iothread_stop() been called? */
>      bool running;               /* should iothread_run() continue? */
> +    bool attached;              /* Whether or not attached to device */
>      int thread_id;
>
>      /* AioContext poll parameters */
> diff --git a/iothread.c b/iothread.c
> index caf68e0764..38e38fb44d 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -94,6 +94,7 @@ void iothread_stop(IOThread *iothread)
>          return;
>      }
>      iothread->stopping =3D true;
> +    iothread->attached =3D false;
>      aio_bh_schedule_oneshot(iothread->ctx, iothread_stop_bh, iothread);
>      qemu_thread_join(&iothread->thread);
>  }
> @@ -199,6 +200,9 @@ static void iothread_init(EventLoopBase *base, Error =
**errp)
>       */
>      iothread_init_gcontext(iothread, thread_name);
>
> +    /* Clear iothread attached flag for init gcontext */
> +    iothread->attached =3D false;
> +
>      iothread_set_aio_context_params(base, &local_error);
>      if (local_error) {
>          error_propagate(errp, local_error);
> @@ -336,6 +340,7 @@ char *iothread_get_id(IOThread *iothread)
>
>  AioContext *iothread_get_aio_context(IOThread *iothread)
>  {
> +    iothread->attached =3D true;
>      return iothread->ctx;
>  }

This patch will still report attached =3D true after all users have gone
away. A reference counting API is needed because IOThread users can
come and go (e.g. device hot unplug or block exports being removed).

Stefan

