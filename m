Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB65C54798
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 01:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfrY8-0005kb-Es; Thu, 29 Feb 2024 20:18:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rfrY6-0005kB-4S
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 20:18:54 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rfrY3-0000Es-Dp
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 20:18:53 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5661b7b1f51so2603012a12.2
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 17:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1709255924; x=1709860724; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WbckPofn63288zTR5R85xx/mAIEUoM/+AppMBxvTwkQ=;
 b=FQ38wv0IpfWZAz+uLg1SoJ8ML6IEm0U8Z0Wu4VMSMjmJK/745/21+Nt8IAzCNM8HBs
 dZlg7tgY/MS9PK4x8uHbhmB+bJWmgMdBLGvUZNPDfovHYU6fWsTR2s/BSDNzea9Ks3Lf
 nezcfdK5OYOreeCotq2da8uC2iNSeDPQpI+7NXqa7mN/nOlEPynKqpmob9KbqDnE4xvY
 LonaommohsmskQLf3ZXLF7DAHG6eMEpVxcTW/roMJNhsSTJ3bzSUgXKtZ7aRl0pWkehw
 6ikBUeqBXLUB/m/0m+aXXMDNt8pT4x2kztbf7o/OtxWY8IigsJzfYZj+Z3DiJNmDb2nm
 PgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709255924; x=1709860724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WbckPofn63288zTR5R85xx/mAIEUoM/+AppMBxvTwkQ=;
 b=ODFLnCM584RF+q+Z4yYCRO5UKoJxeqkY3K+lcg+/jkMvGW6jI7vWr6yYXBXWt//OKi
 Fbh0lhTqZM6DUmor0g/WhKup32LbZ4NNwcZsJxq2VVAJXWbhtllJ7+0mNrBuFlfjGubw
 wKWvNzwnUcD6pSonHQRT0W77TdLKOQZsJs1KDyz3K4du8ZUcrCDS9TWdTvohNJHvbXbb
 zITQBdoMB3PRFOYf+Y6zLQOJbcOpT5lA6xLZyzBD3U5gQmivxcXsXmeDLew6lKb/rOgd
 iRF2bDHYP7UO3P2Ea7cRMjjuf0l9QdL1GOuBzzOE7y1FYGsvbSN/LUIxCktpTwP0Kgz6
 SpiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9eOLbyNBxF+PBnWhsTt0fKHtD7LXF0cOBArdZXyoXbwoKaiuLMSqyA8qnxuqm1rKlCfchm+7lLNM9zd/wFg/9jY9628o=
X-Gm-Message-State: AOJu0YxaIpNruDbPJe1MAOIlY0DN70nOcz81wkmhnGrL0OCGLQYijrif
 13i7l2rlPZ/PwaPvwANFrUdiavsDh8d18m6hVJi3pUiYw69jODdCCKEHyq1hjGxsMAY+0zDOJEh
 hthPrTC/JPrRT8n+BwKl9UeHiZXdL4glOWqZS4g==
X-Google-Smtp-Source: AGHT+IEj3jY9QxK+YCw7M0PvaT4PeZkiukfEFSw97vQVAxAu4VbxLvXNxOneM3rmn8VycxIzrO80tHwwM5wGTzkBDOw=
X-Received: by 2002:aa7:d9d2:0:b0:566:cde6:3ee4 with SMTP id
 v18-20020aa7d9d2000000b00566cde63ee4mr174202eds.24.1709255924349; Thu, 29 Feb
 2024 17:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20240226195654.934709-1-hao.xiang@bytedance.com>
 <20240226195654.934709-7-hao.xiang@bytedance.com>
 <87wmqozzjn.fsf@pond.sub.org>
 <CAAYibXicsMkZ+QaFtjgSbjk_eL3waOp1fiJQ7M9b5SRXCRa+ig@mail.gmail.com>
 <875xy7u7vb.fsf@pond.sub.org>
In-Reply-To: <875xy7u7vb.fsf@pond.sub.org>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Thu, 29 Feb 2024 17:18:33 -0800
Message-ID: <CAAYibXh_Rd0q1SnFmbH4+DUUY_Vdr5dcvawtrayRRp6ZCbOfPg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 6/7] migration/multifd: Add zero pages
 and zero bytes counter to migration status interface.
To: Markus Armbruster <armbru@redhat.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, thuth@redhat.com, 
 lvivier@redhat.com, jdenemar@redhat.com, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ed1-x52d.google.com
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

On Wed, Feb 28, 2024 at 10:01=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > On Wed, Feb 28, 2024 at 1:52=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com> wrote:
> >>
> >> Hao Xiang <hao.xiang@bytedance.com> writes:
> >>
> >> > This change extends the MigrationStatus interface to track zero page=
s
> >> > and zero bytes counter.
> >> >
> >> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> >>
> >> [...]
> >>
> >> > diff --git a/qapi/migration.json b/qapi/migration.json
> >> > index a0a85a0312..171734c07e 100644
> >> > --- a/qapi/migration.json
> >> > +++ b/qapi/migration.json
> >> > @@ -63,6 +63,10 @@
> >> >  #     between 0 and @dirty-sync-count * @multifd-channels.  (since
> >> >  #     7.1)
> >> >  #
> >> > +# @zero-pages: number of zero pages (since 9.0)
> >> > +#
> >> > +# @zero-bytes: number of zero bytes sent (since 9.0)
> >> > +#
> >>
> >> Awfully terse.  How are these two related?
> >
> > Sorry I forgot to address the same feedback from the last version.
>
> Happens :)
>
> > zero-pages are the number of pages being detected as all "zero" and
> > hence the payload isn't sent over the network. zero-bytes is basically
> > zero-pages * page_size. It's the number of bytes migrated (but not
> > actually sent through the network) because they are all "zero". These
> > two are related to the existing interface below. normal and
> > normal-bytes are the same representation of pages who are not all
> > "zero" and are actually sent through the network.
> >
> > # @normal: number of normal pages (since 1.2)
> > #
> > # @normal-bytes: number of normal bytes sent (since 1.2)
>
> We also have
>
>   # @duplicate: number of duplicate (zero) pages (since 1.2)
>   #
>   # @skipped: number of skipped zero pages. Always zero, only provided fo=
r
>   #     compatibility (since 1.5)
>
> Page skipping was introduced in 1.5, and withdrawn in 1.5.3 and 1.6.
> @skipped was formally deprecated in 8.1.  It'll soon be gone, no need to
> worry about it now.
>
> That leaves three values related to pages sent: @normal (and
> @normal-bytes), @duplicate (but no @duplicate-bytes), and @zero-pages
> (and @zero-bytes).
>
> I unwittingly created a naming inconsistency between @normal,
> @duplicate, and @zero-pages when I asked you to rename @zero to
> @zero-pages.
>
> The meaning of the three values is not obvious, and the doc comments
> don't explain them.  Can you, or anybody familiar with migration,
> explain them to me?
>
> MigrationStats return some values as bytes, some as pages, and some as
> both.  I hate that.  Can we standardize on bytes?

I added zero/zero-bytes because I thought they were not there. But it
turns out "duplicate" is for that purpose. "zero/zero-bytes" is really
additional information to "normal/normal-bytes". Peter suggested that
if we add "zero/zero-bytes" we can slowly retire "duplicate" at a
later point.
I don't know the historical reason why pages/bytes are used the way it
is today. The way I understand migration, the granularity of ram
migration is "page". There are only two types of pages 1) normal 2)
zero. Zero pages' playload are not sent through the network because we
already know what it looks like. Only the page offset is sent. Normal
pages are pages that are not zero. The entire page is sent through the
network to the target host. if a user knows the zero/normal count,
they can already calculate the zero-bytes/normal-bytes (zero/normal *
page size) but it's just convenient to see both. During development, I
check on these counters a lot and they are useful.

>
> >>
> >> >  # Features:
> >> >  #
> >> >  # @deprecated: Member @skipped is always zero since 1.5.3
> >>
> >> [...]
> >>
>

