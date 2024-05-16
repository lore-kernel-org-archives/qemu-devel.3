Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AF9C25B7A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 17:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7f9K-0002jr-EA; Thu, 16 May 2024 13:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s7f9I-0002ja-C7
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:44:12 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s7f9G-00065s-8w
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:44:12 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-574ea5184abso4228217a12.3
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 10:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715881447; x=1716486247; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hUpsOZ/1QNpVHJ0C5Fa/G9tv88yej+ZWqDxCxXHd4RM=;
 b=U8EXiS+dknDs3YZaMFdgMYLzmCMcZa9CndKLFDOlm3TzLdjjNPkBrEgZShqGBvgII4
 xgezAZya1A/IO6CkOtCDkhQaDo+gTHxF1ptdCYW1YgbWz+e+zJn/fdCOjQybv/KkkRR+
 yxr50vCqRhCJjmolPBnDwxo7KcKnlhwKd+tfPbU/HPm+XZks3gBEjaGx5fVWkEKkb3ZF
 //vxUsnCYLy4p7cDgOSIVaVxuCOeC5wCPTLwN4t+AlFAfzvFEzkD+GsjWVcprdaO+/9B
 bEDBg0LoL1n9KcJu86ZJKMahRLLz+sx2vtl0dYOhrSkisvfuN08CIa9U3hn3VAQptTGN
 RmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715881447; x=1716486247;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hUpsOZ/1QNpVHJ0C5Fa/G9tv88yej+ZWqDxCxXHd4RM=;
 b=FjaK4zqVQy9VZNSASKnrdACaTsuzNTO4/7FkWbYVcPfAQhiBQHQShBkcdmx2TE0L0W
 DXeeJ8T7G7hF1dx+zimgtc0F7l2VV2pcB7EZeZKEH+9j3ORcdONPPNNl6DsjR5kl63wP
 8/xmeCOgEaBbCiFXyki5opJp/iDUQqlE+eTYsJ7VXXDQ4nIynVr0n+vwlGxUQCAtlVTp
 7JikOp4cmBc3u21S7ODY4/DiDVx0m2hFtFYDYD6l0RoVm7ZcJHpVmxDLKpy4tGUpeFk1
 KUzHXSuoZGtiK+kDvZ3GNpm0O8cHwUT0KPjEkNgu301Q82bxFz2UVNJrlsMWJns6POjB
 MunA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT9KjkiUS+b1BWlOskqn5LzavsD37YhEjELC5VSJwGtsy2UVDxjJTU09Bio3lWvoREUMw5S17eSOQsrESC2tU/KmBsFtw=
X-Gm-Message-State: AOJu0Yyw4X5OTz3aQEAK8dBtjlYY5t140AFAMwuM4hF6dd7OZUV6yza9
 PsuDsxYL3A0q2kjpt0MMoK5v9XTrhqRmQEI1/TI9zcoXyno0PFxts6JX1oRrrlVcw1a8ekMIAG1
 FiL4JmDBdZUooYWWDTbODBXKuMOyrSjxyP8LTpA==
X-Google-Smtp-Source: AGHT+IErmLpc5b3KsIys1ao2CcTGQgXdHj4GcvpYQ//rJcNsJyIkrs912LX5BRKpKwGW32JpPkHx4VzGApTu3CJJHvw=
X-Received: by 2002:a50:f69b:0:b0:56d:fdb3:bcc5 with SMTP id
 4fb4d7f45d1cf-5734d5bfbe3mr13905080a12.12.1715881447413; Thu, 16 May 2024
 10:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240516162230.937047-1-berrange@redhat.com>
 <20240516162230.937047-2-berrange@redhat.com>
 <CAFEAcA9ocOiZ5E0WSCKoR3nL+qf4LF-AQ6_4HpF9xfipAJhbog@mail.gmail.com>
 <20240516133334-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240516133334-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 May 2024 18:43:53 +0100
Message-ID: <CAFEAcA8bYowZnE8B5JivSecSRyZLwo0i3cx1tywOMLNd190Kow@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] docs: introduce dedicated page about code
 provenance / sign-off
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Thu, 16 May 2024 at 18:34, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, May 16, 2024 at 06:29:39PM +0100, Peter Maydell wrote:
> > On Thu, 16 May 2024 at 17:22, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > >
> > > Currently we have a short paragraph saying that patches must include
> > > a Signed-off-by line, and merely link to the kernel documentation.
> > > The linked kernel docs have a lot of content beyond the part about
> > > sign-off an thus are misleading/distracting to QEMU contributors.
> >
> > Thanks for this -- I've felt for ages that it was a bit awkward
> > that we didn't have a good place to link people to for the fuller
> > explanation of this.
> >
> > > This introduces a dedicated 'code-provenance' page in QEMU talking
> > > about why we require sign-off, explaining the other tags we commonly
> > > use, and what to do in some edge cases.
> >
> > The version of the kernel SubmittingPatches we used to link to
> > includes the text "sorry, no pseudonyms or anonymous contributions".
> > This new documentation doesn't say anything either way about
> > our approach to pseudonyms. I think we should probably say
> > something, but I don't know if we have an in-practice consensus
> > there, so maybe we should approach that as a separate change on
> > top of this patch.
>
>
> Well given we referred to kernel previously then I guess that's
> the concensus, no?

AIUI the kernel devs have changed their point of view on the
pseudonym question, so it's a question of whether we were
deliberately referring to that specific revision of the kernel's
practice because we agreed with it or just by chance...

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?id=3Dd4563201f33a022fc0353033d9dfeb1606a88330

is where the kernel changed to saying merely "no anonymous
contributions", dropping the 'pseudonyms' part.

-- PMM

