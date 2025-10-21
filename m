Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D11CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 14:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBDjx-0005Ct-UQ; Tue, 21 Oct 2025 10:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBDjq-00059y-H7
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:53:28 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBDjo-0007YY-68
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:53:26 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6360397e8c7so5795130d50.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761058402; x=1761663202; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LQAijONfUONASIqkcmGwsLwEJ3D0Z+GzArhZwaGXdDU=;
 b=Pr/rvAnhIqGiTzXc5sQcglpy/0/MldGpu68QsgZOxZH+Ls/iifHdPrU640X9G/HvA5
 GkRgILsruBdKlMUQkJt4ibUMOUctkcQ64uVwkNkaLoiHMb4T+U3924P9IR7AmxgUt8Pg
 QGvhyGGji85C4cY4Ab/lMVNojcWkSJGL5zJ7BAmfD5yhWYBXPoxsvtxLfYEsZJVY7LEC
 KRoeNc5Oee+UJYYp40HlN2NjK7J6lIT3BKPK/SFKlIT5UUAnnrkeRNsAOdB4X1TLPitQ
 3muZUr5+eiBsjAKd+4przBxkc3m58lKxZUcg+yfiFhuRRjjeu36vPxtyCnBy78ioiaUo
 OYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761058402; x=1761663202;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LQAijONfUONASIqkcmGwsLwEJ3D0Z+GzArhZwaGXdDU=;
 b=vZjrxLLEhymXpmZNQcQdJ0slTKPDJXXnoUEFDt0API0C2KvsLgSY2JGJyYDvVt5J3A
 oIachgay03Wi8qzjefZJ8luvA9T9XOdxhqkjisyIusR8VWzL1qnJh8ivOXpbJ5DcED7l
 Fb4dWjBfxoWWGHeUASZJSrEyGsYb2Nv1oDMVfFVSR+vXQycxpb7eZwk7O4BQssYO6cAC
 N3pEJmTyFZYJQknIh+4Ga7g0v9W4OqyMCiZ8/hNypCXwI460Mk5/IePYL7zDRvXilHIj
 +8qB9DTw9t1h/PlLvS7nlhL8NOPo+j9MHFs24C/wBcBMBDsBjoKexEIXPvATcU3tUVcP
 FYfw==
X-Gm-Message-State: AOJu0Yx/5wbeo7TRgQ6D6i/tm5iU++oVGl3oJYYjgYUhR6QrbKAQX0++
 DyiFRLoEMuNUitA6ARr0GGZSBqWZM2OopgZu0KlBOJU+C1mWWN10eth6OE9uZfapSO8Nu5/mVNu
 XE7WKd4F4u9isWAYZ+zywT9VdE0Emljw3kqI3rZt+PQ==
X-Gm-Gg: ASbGnctIarEzS9jGCdVnOkHPZDzYp0TIj3t5OasdewkCRm8N2UywBmi6/8JgoyJ3Hag
 pccylvRDx3m/LiYcrYUDSD7IKCrrtKP4wL7pclbjqcXSbp9aaMDMeNMUCp6UN6dvqM0c0EDg2+4
 iuceBfbkFIbLtjAjXVa94JyYGP1kkqoyaRpyTmqjFpxeFpWxD7ZOp5U/o41jUuAhfqR3WUISyzz
 XkP9Z/UboiwUv6ZH/x8yFS8/IShJXYF6tpm4LLG0LvT6o0lzzRVSSkDvJaMRmqeF3KHesaZ
X-Google-Smtp-Source: AGHT+IFI4Uv121disECUGdA7/+pzfei0K0/ylQViD+enFkurDbUDurw4Z8DWwAOepxv6pCXehukq+O9Egdxt/bk4cWI=
X-Received: by 2002:a05:690e:1405:b0:63e:33d1:72d1 with SMTP id
 956f58d0204a3-63e33d1762cmr7010472d50.66.1761058402447; Tue, 21 Oct 2025
 07:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20251003153948.1304776-1-peterx@redhat.com>
 <20251003153948.1304776-24-peterx@redhat.com>
In-Reply-To: <20251003153948.1304776-24-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Oct 2025 15:53:11 +0100
X-Gm-Features: AS18NWDre70ZP06hzXnwJxmvgNV4_Ci_aIWizrlgnxZLBBN_qoON3DW88Jl2HBs
Message-ID: <CAFEAcA9otBWtR7rPQ0Y9aBm+7ZWJzd4VWpXrAmGr8XspPn+zpw@mail.gmail.com>
Subject: Re: [PULL 23/45] migration: Capture error in
 postcopy_ram_listen_thread()
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Fri, 3 Oct 2025 at 16:40, Peter Xu <peterx@redhat.com> wrote:
>
> From: Arun Menon <armenon@redhat.com>
>
> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> postcopy_ram_listen_thread() calls qemu_loadvm_state_main()
> to load the vm, and in case of a failure, it should set the error
> in the migration object.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> Tested-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-23-36f11=
a6fb9d3@redhat.com
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Hi; Coverity reports a memory leak (CID 1641390) as a
result of this change:

>  migration/savevm.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 34b7a28d38..996673b679 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2095,6 +2095,7 @@ static void *postcopy_ram_listen_thread(void *opaqu=
e)
>      QEMUFile *f =3D mis->from_src_file;
>      int load_res;
>      MigrationState *migr =3D migrate_get_current();
> +    Error *local_err =3D NULL;
>
>      object_ref(OBJECT(migr));
>
> @@ -2111,7 +2112,7 @@ static void *postcopy_ram_listen_thread(void *opaqu=
e)
>      qemu_file_set_blocking(f, true, &error_fatal);
>
>      /* TODO: sanity check that only postcopiable data will be loaded her=
e */
> -    load_res =3D qemu_loadvm_state_main(f, mis, &error_fatal);
> +    load_res =3D qemu_loadvm_state_main(f, mis, &local_err);

Here, a failure in this function will allocate an Error
object and set local_err to point to it.

>
>      /*
>       * This is tricky, but, mis->from_src_file can change after it
> @@ -2137,7 +2138,10 @@ static void *postcopy_ram_listen_thread(void *opaq=
ue)
>                           __func__, load_res);
>              load_res =3D 0; /* prevent further exit() */
>          } else {
> -            error_report("%s: loadvm failed: %d", __func__, load_res);
> +            error_prepend(&local_err,
> +                          "loadvm failed during postcopy: %d: ", load_re=
s);
> +            migrate_set_error(migr, local_err);
> +            error_report_err(local_err);
>              migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACT=
IVE,
>                                             MIGRATION_STATUS_FAILED);

In this brach of the if(), we error_report_err(), which will
free the error object. But in the other branch of the
if(), we never do anything with local_err, and so we never free
the error object.

I think the true-branch of the if() needs to either
incorporate the error into something, or else error_free() it.

thanks
-- PMM

