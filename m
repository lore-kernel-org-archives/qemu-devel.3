Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45770EE01ED
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 22:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so99N-0006FF-I2; Tue, 10 Sep 2024 18:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1so99G-0006ER-8C
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:15:47 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1so99E-0006Qt-6O
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:15:45 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e1cf1a4865aso5661893276.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 15:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1726006536; x=1726611336; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ymKqFoAkfaf/NVe6VKQBwubrviM3+4LPol6fNpRo70=;
 b=I0lLHCTQR4iDBnhhwdhjENJibEZrZEKL5qu5VgzqHThY27DQl85aZaONaTU5QgA3ab
 nWSTuTknpgZB+ceK6e19p7iW43K+RREPmai7A7kOkSOy1gWf+AYVjHOINKOyoF7bpOLl
 /+Xp7gyFsBGhcPQBEM+81KeVoE5WjvmNd5iorGXM0SuvQfvrUb6GYXYv1xbh/krmZCTl
 SL5x9NEedh155wTgk1lsI4WwOO09IAEmV5AFGMgJoMm1noLbyjq+geJjvCD/GKNjW276
 fpiWh4jA8xV46qfMyieFbl3+bsbWQZOuFsX9Ujcpu0vKCcwWBvADTlrk3C/lm+OP4Zp9
 oeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726006536; x=1726611336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ymKqFoAkfaf/NVe6VKQBwubrviM3+4LPol6fNpRo70=;
 b=mUwKbuQka7oTH61psJQaTOhusKoqpUwIkMaW5ABEAi1JacZXBQ1lywOVWxFCDp29oV
 tU9s//vk8OCq6jXSAdW4dtX6kKG5ZawJoEvnFtJg7bylr0hI/8oTxi4f7YTazGD9BG0B
 CfOyg1qdeiScqws0OTnQi0oeAUiPPYKLnY30jPTOzzNXhyRTlX04faD410ZvcHcVTnu7
 HjYOyNvCVRVPUyG57BuC/h2x882Rz55yZo9RrGsVhHLMVfG4H8Vk5SWQJgfnSQpw1aHv
 PHAG9w9qjePouf07/mTLltlqKebi/BXvWv+C+cxyN6QBYewSp9S/HdMMnusLwM3T7NMT
 i7Vg==
X-Gm-Message-State: AOJu0YxqOQtsyU0GiOLtWoWdiv06KAZO+d5RMbtju9MCY++jSZRqcz8x
 sETe1d/ioqSfwA3vuLqy4fW8Bp18UiMHsOMBpHkWFjlaHr5uTGaPZTT45Ljk/neu0+RZBGIsrA+
 WzXZojT5cLgMSudcJ7RsUTna4plUZhlKL26utuQ==
X-Google-Smtp-Source: AGHT+IFYogJuM2NtBbq6YeCCcU5sZcgmLNL/7AUmoZ4pqoqi8+lNSKz09HH2JQZ5TUOD9AdPka2RyoV66bvIyomDJ1w=
X-Received: by 2002:a05:6902:cc6:b0:e16:1ebf:293d with SMTP id
 3f1490d57ef6-e1d34883175mr15347112276.20.1726006535913; Tue, 10 Sep 2024
 15:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240910210450.3835123-1-peterx@redhat.com>
In-Reply-To: <20240910210450.3835123-1-peterx@redhat.com>
From: Yichen Wang <yichen.wang@bytedance.com>
Date: Tue, 10 Sep 2024 15:15:25 -0700
Message-ID: <CAHObMVZWQ1c_Ffctn+Z-finO3nyhXw_BomO1fRDiiS-BaL6qLA@mail.gmail.com>
Subject: Re: [External] [PATCH] migration/multifd: Fix build for qatzip
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Prasad Pandit <ppandit@redhat.com>, Bryan Zhang <bryan.zhang@bytedance.com>, 
 Hao Xiang <hao.xiang@linux.dev>, Yuan Liu <yuan1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=yichen.wang@bytedance.com; helo=mail-yb1-xb33.google.com
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

On Tue, Sep 10, 2024 at 2:05=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> The qatzip series was based on an older commit, it applied cleanly even
> though it has conflicts.  Neither CI nor myself found the build will brea=
k
> as it's skipped by default when qatzip library was missing.
>
> Fix the build issues.  No need to copy stable as it just landed 9.2.
>
> Cc: Yichen Wang <yichen.wang@bytedance.com>
> Cc: Bryan Zhang <bryan.zhang@bytedance.com>
> Cc: Hao Xiang <hao.xiang@linux.dev>
> Cc: Yuan Liu <yuan1.liu@intel.com>
> Fixes: 80484f9459 ("migration: Introduce 'qatzip' compression method")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>
> Qatzip developers: would you help me to double check whether this is the
> right fix?

It makes sense and looks good to me. Thanks a lot for correcting this.

> ---
>  migration/multifd-qatzip.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c
> index 3c787ed879..7b68397625 100644
> --- a/migration/multifd-qatzip.c
> +++ b/migration/multifd-qatzip.c
> @@ -160,7 +160,8 @@ static void qatzip_send_cleanup(MultiFDSendParams *p,=
 Error **errp)
>   */
>  static int qatzip_send_prepare(MultiFDSendParams *p, Error **errp)
>  {
> -    MultiFDPages_t *pages =3D p->pages;
> +    uint32_t page_size =3D multifd_ram_page_size();
> +    MultiFDPages_t *pages =3D &p->data->u.ram;
>      QatzipData *q =3D p->compress_data;
>      int ret;
>      unsigned int in_len, out_len;
> @@ -179,12 +180,12 @@ static int qatzip_send_prepare(MultiFDSendParams *p=
, Error **errp)
>       * implementation.
>       */
>      for (int i =3D 0; i < pages->normal_num; i++) {
> -        memcpy(q->in_buf + (i * p->page_size),
> +        memcpy(q->in_buf + (i * page_size),
>                 pages->block->host + pages->offset[i],
> -               p->page_size);
> +               page_size);
>      }
>
> -    in_len =3D pages->normal_num * p->page_size;
> +    in_len =3D pages->normal_num * page_size;
>      if (in_len > q->in_len) {
>          error_setg(errp, "multifd %u: unexpectedly large input", p->id);
>          return -1;
> @@ -197,7 +198,7 @@ static int qatzip_send_prepare(MultiFDSendParams *p, =
Error **errp)
>                     p->id, ret);
>          return -1;
>      }
> -    if (in_len !=3D pages->normal_num * p->page_size) {
> +    if (in_len !=3D pages->normal_num * page_size) {
>          error_setg(errp, "multifd %u: QATzip failed to compress all inpu=
t",
>                     p->id);
>          return -1;
> @@ -329,7 +330,8 @@ static int qatzip_recv(MultiFDRecvParams *p, Error **=
errp)
>      int ret;
>      unsigned int in_len, out_len;
>      uint32_t in_size =3D p->next_packet_size;
> -    uint32_t expected_size =3D p->normal_num * p->page_size;
> +    uint32_t page_size =3D multifd_ram_page_size();
> +    uint32_t expected_size =3D p->normal_num * page_size;
>      uint32_t flags =3D p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
>
>      if (in_size > q->in_len) {
> @@ -370,9 +372,7 @@ static int qatzip_recv(MultiFDRecvParams *p, Error **=
errp)
>
>      /* Copy each page to its appropriate location. */
>      for (int i =3D 0; i < p->normal_num; i++) {
> -        memcpy(p->host + p->normal[i],
> -               q->out_buf + p->page_size * i,
> -               p->page_size);
> +        memcpy(p->host + p->normal[i], q->out_buf + page_size * i, page_=
size);
>      }
>      return 0;
>  }
> --
> 2.45.0
>

