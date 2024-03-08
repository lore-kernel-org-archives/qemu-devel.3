Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F991C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riayj-00032S-NX; Fri, 08 Mar 2024 09:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riayh-00031e-V8
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:13:39 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riayg-0001J4-9Y
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:13:39 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5658082d2c4so2719515a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 06:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709907216; x=1710512016; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0PivzpFMniHKxzKSpOFML5NeUGZuWOGl1mbti4m5fJM=;
 b=ow1GxIvpgMkrhZIwCIbLqdPETN03U5toOAMwK65zPCglY8qrtz5rk3fjbQtm8nPZpy
 UrYUD4S3aLry3xWJCwjhPVAYrvPCHOL07TVP3wuUpsQKL4pjLxMn0iWl+zhfNuaWV7Gh
 pvkWMGJx7x4rH22eUaW1q4XMKjMKtCs428F6uyJ80CE3O374vKNDbhqxPGsLG7RG0oiK
 /LcKsLxXuHP5YiNX3A8kjJRvb0M/AFfewMKMkc0IBNWY8gvkvWAxDqSm2p+v/78b/KS0
 mtDoc//St8yyOrE6qXGPgU09ZIKQpsNYWitVGXtdt83cB4Kz2rsnxBh0xx+9LPIKHtcT
 usEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709907216; x=1710512016;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0PivzpFMniHKxzKSpOFML5NeUGZuWOGl1mbti4m5fJM=;
 b=HNHafKi2B95RJihCNcJzZJPYehG+Vn4ioE6qwwi8cbSO+kylOzRYBfNSavFs7apYOo
 QdxCFB7ahfSC+TAJFIzbPYP9Rb2kq0QqKmZWSuB507OnBPCfrVX3ibeqUcUY7ZIrZDj6
 568QD6/mW5QkZ4+i6IEbZ0Rx2b4OblA+GWQjLbw8QzvHq5Q3idt1+zhH4BAa29AvF502
 DjbVn8v/jKQIywVfmCUt+/jZ1nr3H98VHjHBBoj1sdsx5PHgAbNqL3a3t+6R2Meqk1es
 MmoF1+Xhni0AvEmIwJqlv9jBoYctXI2TjGiFfWq0OgraA/iuzCHr+r+9mvQYdLEm/YiK
 7cjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSvPniJL4bO2uUYWau1qGhZNySyxTjM9wjPr18yhJzfdIAh/teQbzNiawXjkWmlMdPJRxUiwRYtLi4mMICy3kK/jyL9aw=
X-Gm-Message-State: AOJu0Yx1QoxzaQgl7dfPzRbQd0YO7pmVrtPHnQqadb2v8U1ovJVZz8ES
 V7VwM0yu9+YuvBO/JgsHG5THQ1VnU7FYyeVhVQGSDYY9HDCaPvqOvECTVp4gh9Gd8L2yWdqeLJn
 pXjg6fCQlbEQPUTvP4vPmzY9vlHYwGqP06ZvTow==
X-Google-Smtp-Source: AGHT+IGgn3sBqvJ0cGkxblPaSHwGNVKXgxeYmmHlYhsUby/8MdyEUIYpgrGMND8hosBomlA7duXrhV0eCXtFPwnoMXQ=
X-Received: by 2002:a50:d559:0:b0:566:18ba:6b80 with SMTP id
 f25-20020a50d559000000b0056618ba6b80mr2025257edj.31.1709907216521; Fri, 08
 Mar 2024 06:13:36 -0800 (PST)
MIME-Version: 1.0
References: <20240307181105.4081793-1-alex.bennee@linaro.org>
 <20240307181105.4081793-2-alex.bennee@linaro.org> <ZerA34BH9NNf_K1Y@x1n>
 <87msr9taac.fsf@draig.linaro.org> <ZerK2iI7FAGuQH1O@x1n>
 <9b70c85e-0c4f-47f6-ade2-a227c5b70401@redhat.com>
In-Reply-To: <9b70c85e-0c4f-47f6-ade2-a227c5b70401@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2024 14:13:24 +0000
Message-ID: <CAFEAcA8YPW6nUDGUK0Afr9mOUVaBPVo6Xu+0yC9GovmoyfOLhg@mail.gmail.com>
Subject: Re: [PATCH 1/5] scripts/kernel-doc: teach kdoc about QLIST_ macros
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Juan Quintela <quintela@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 8 Mar 2024 at 08:49, Thomas Huth <thuth@redhat.com> wrote:
>
> On 08/03/2024 09.22, Peter Xu wrote:
> > On Fri, Mar 08, 2024 at 08:09:15AM +0000, Alex Benn=C3=A9e wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >>
> >>> On Thu, Mar 07, 2024 at 06:11:01PM +0000, Alex Benn=C3=A9e wrote:
> >>>> The kernel-doc script does some pre-processing on structure
> >>>> definitions before parsing for names. Teach it about QLIST and repla=
ce
> >>>> with simplified structures representing the base type.
> >>>>
> >>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >>>> ---
> >>>>   scripts/kernel-doc | 9 ++++++++-
> >>>>   1 file changed, 8 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> >>>> index 240923d509a..26c47562e79 100755
> >>>> --- a/scripts/kernel-doc
> >>>> +++ b/scripts/kernel-doc
> >>>> @@ -1226,7 +1226,14 @@ sub dump_struct($$) {
> >>>>    # replace DECLARE_KFIFO_PTR
> >>>>    $members =3D~ s/DECLARE_KFIFO_PTR\s*\(([^,)]+),\s*([^,)]+)\)/$2 \=
*$1/gos;
> >>>>
> >>>> -  my $declaration =3D $members;
> >>>> +        # QEMU Specific Macros
> >>>> +
> >>>> +        # replace QLIST_ENTRY with base type and variable name
> >>>> +        $members =3D~ s/QLIST_ENTRY\(([^)]+)\)\s+([^;]+)/$1 \*$2/go=
s;
> >>>> +        # replace QLIST_HEAD, optionally capturing an anonymous str=
uct marker, and capture type and variable name
> >>>> +        $members =3D~ s/QLIST_HEAD\(\s*,\s*([^)]+)\)\s+([^;]+)/stru=
ct { $1 *lh_first; } $2/gos;
> >>>> +
> >>>> +        my $declaration =3D $members;
> >>>
> >>> May need a "tabify" here..
> >>
> >> Ugg that file is a mess. Any idea what we should use for perl, tabs or
> >> spaces? I can update editorconfig.
> >
> > Indeed.. not perl expert here.
> >
> > For this one it might be still good to keep the same with the code arou=
nd
> > before an attempt to clean it up.
>
> I think this file originate from the Linux kernel repo, so it might be a
> good idea to keep it in sync with the version from there?

Yes; we should avoid divergence where we can. We already
have one script (checkpatch) that has diverged too far
for easy resyncing, it would be good to avoid this one
going in the same direction. We last did a resync in 2020.

thanks
-- PMM

