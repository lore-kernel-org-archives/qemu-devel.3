Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29800D59F56
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 18:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8kRQ-0003HA-D6; Wed, 06 Nov 2024 13:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t8kRN-0003GQ-8P
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:07:37 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t8kRA-0005cs-EG
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:07:36 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7180c7a4e02so91017a34.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 10:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730916440; x=1731521240; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N01JVIVKV9ZJW63R9kbErdGeR/4d3O+Ot3H3QsLOb9k=;
 b=nkOseVWxoZwHgXLiZ+CbFejhI3ik5vDSRHk3jzuzbvx6eV38ANj8qz63uKuVj3GjfE
 ALJuAxds7xoffP+vaR7kjtoznlU+HgAAx25s6AVyzRX1TtDypCKi9OBgZI93HPigaslK
 j8cMjCdV8TbRLxZc7yCRtBh5SZ3M5QonGmzedqZby+Of51tNiUi9cBdnb5L5DALtvr4Z
 ryXQH4xelC2DNf5D2GrTFEJ01mj8s7ZDMqSaYzvC7Y2aVTy1l6gYYK9FB2+/Jd6zwA7o
 fwBsDrjbw163+PUXZXmCTUUMgHc7cDnLprsgH9CYkVPfDLLkw++HXStxs1OTRrwAw8XR
 iPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730916440; x=1731521240;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N01JVIVKV9ZJW63R9kbErdGeR/4d3O+Ot3H3QsLOb9k=;
 b=La51R1FwI81J5U8goRisxrapDii+C8R4Vl0C1hpFjKpfyqcU9eQtG5NjJJhm48ejAw
 nT+Z21Lc2m/bjrJjyVPlXzEp4jLmaWKvdNR4yH4+bUR/hu/xH4vXl8sj6a7UobrttzAj
 2vDGyd/FucrJvw5+NLMtseQfhLJhDB6m/Kmmx1f0Fn+4djO3SOpiw0ksgueNJljMbq9V
 uJqh0uQcHdggnshsYRSCrxXxMEphdw5662RyNF1NogfnsT4oNZGlxp/hS255RYSG0gWg
 YMdKDPABQEozb5T4YkTgmBPB/M9JE8ggX8Eg7FLW9tl0fRexHirNkM1BQpOt8+KfBR/t
 ZRhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmIPPbAqHe+5+I3a+grcSF5caiWZj/+OP72tflnH0rwwVtcQOGWvwKFmpWKi7DtGwhxy+8qVwj85mO@nongnu.org
X-Gm-Message-State: AOJu0YwL4BpabYMT88WGxJ8xlTArskTlCLjBXqmDdtPPbOVHREIEudUy
 4Hp7eBefdXGJ7K1UW+JSXpa/QOgVQum0g1Ps9t6nVrGZx1x7o38jdMyXsl7n+JTlLy+ds6h2Ze+
 JA02XBsi+YBL8BzI4uS/9GeizqBM=
X-Google-Smtp-Source: AGHT+IGIYRnSiDDaD2GsgOOHeiau4oOezud89QOFNxePUwjNln6/8qHPNfjrHpMCX1eo+K05D4Pg6pnxVDBzuZolWTs=
X-Received: by 2002:a05:6358:e4a7:b0:1c3:94:8ff9 with SMTP id
 e5c5f4694b2df-1c3f9e064edmr2047726255d.9.1730916439886; Wed, 06 Nov 2024
 10:07:19 -0800 (PST)
MIME-Version: 1.0
References: <20241106174241.556373-1-pbonzini@redhat.com>
 <04fd0b86-4371-494e-a331-3d5d735f0d77@linaro.org>
 <CABgObfajkp+5vFnQuV+V6Mp+LuP_Yo-=JtZtGUcYB_GDDbWoJQ@mail.gmail.com>
 <b463bc8a-4625-43e6-a9da-4df526aa89a3@linaro.org>
 <CABgObfZvO3txRMAwjMny73k3pyfNy_SZ=oeoAwM1hm6b9zot8Q@mail.gmail.com>
In-Reply-To: <CABgObfZvO3txRMAwjMny73k3pyfNy_SZ=oeoAwM1hm6b9zot8Q@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 7 Nov 2024 00:07:21 +0600
Message-ID: <CAFfO_h6aAKcXX4JYJ7cTgKXz0rJ4+2ULSB+CJssL1-hAiHfadg@mail.gmail.com>
Subject: Re: [PATCH] eif: cope with huge section offsets
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=dorjoychy111@gmail.com; helo=mail-ot1-x335.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Nov 6, 2024 at 11:58=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On Wed, Nov 6, 2024 at 6:54=E2=80=AFPM Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
> >
> > On 11/6/24 09:49, Paolo Bonzini wrote:
> > > On Wed, Nov 6, 2024 at 6:47=E2=80=AFPM Pierrick Bouvier
> > > <pierrick.bouvier@linaro.org> wrote:
> > >
> > >>>        for (int i =3D 0; i < MAX_SECTIONS; ++i) {
> > >>>            header->section_offsets[i] =3D be64_to_cpu(header->secti=
on_offsets[i]);
> > >>> +        if (header->section_offsets[i] > OFF_MAX) {
> > >>
> > >> Maybe we could add a comment that sections_offsets is unsigned, as i=
t
> > >> can be confusing to read value > INT_MAX without more context.
> > >
> > > It does sound like OFF_MAX is related to section_offsets[], but it's
> > > actually related to off_t.  So the comparison is with the maximum
> > > value of off_t, which is signed.
> > >
> > > The problem would happen even if section_offsets[] was signed (for
> > > example off_t could be 32-bit).
> >
> > I'm a bit confused.
> > It works because section_offsets[i] is unsigned. If it was signed, and
> > sizeof(off_t) is 8, we can never satisfy "(int64) > INT64_MAX".
>
> The fact that you cannot satisfy "int64 > INT64_MAX" just means that
> on this system that erroneous condition is unreachable, but it could
> be reachable on others. (Actually the fact that section_offsets[] is
> unsigned does matter, because otherwise you'd nede a check against 0
> as well. But it doesn't matter for the correctness of *this* check
> against OFF_MAX).
>

I think instead of putting the check for > OFF_MAX inside
read_eif_header, it would make more sense to put the check in the
read_eif_file function before the fseek line where we are actually
doing the seeking, no? What do you think?

Regards,
Dorjoy

