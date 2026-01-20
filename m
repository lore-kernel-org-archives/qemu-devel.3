Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9B4D2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 13:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viBSw-0004Nl-NC; Tue, 20 Jan 2026 08:08:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viBSu-0004Lr-G3
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 08:08:12 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viBSs-0007cc-FE
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 08:08:12 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-79274e0e56bso50354427b3.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 05:08:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768914489; cv=none;
 d=google.com; s=arc-20240605;
 b=E4ziCvQC3JN4ZVEjnGV4YL1btDdOlNL9Dbury9IeKCvlFusnD3pEhqpup/xuG2LyFy
 oEAGQjCK8Nzeq2W5agXlW2AFY8qumGoS75qHFLvcEXCUaxP0rvqjAcW1vbNr251//wTN
 78qoJK/o/KDrPF5ULyUc3vDuyHtmt+6pEFHzr1qdY9Zh2W6gxk2pBLIja802v8yH8kVO
 mnzBa9UNC41zOie1QuU/b0FpmH/iydHAxYRjOuZFNZgyUu6Qym2fEAX8Br4/45SQTqE8
 p4AGjLyP1DZqO0vI8kzdDD/BR1uE8sDHHRKTMdYS86a4tIrDqkBxUbX97lj70jMQguCe
 aYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dODhUpJGsHLm41elCWu3sdnGJv6GIOiv5rNtn8qylng=;
 fh=ea5iynPX0c3PeNaJDpBz488PRwtBvVAI4RKUDWzUnsI=;
 b=FS2sASYkMddPsmJpgcsYZp3KI5qwGK0Enfc40O7PxGr4HMbENzhoDjER7xl0g8AeO1
 sgDfwJ/fhVOew8xLXZaPPQUGvxJsi5+RJYzXD+tdYd8KUj6qp8TqiDZRsdJfCOEhAnza
 MbuffCHHAAyQ0Qw5rhE66ZvZkC5zuBlzBDrH48rxxamKMBG45EYFrco2Hbt/qFPJJUzV
 mKtzBkMTjNpCLPHQKD1uGB53HR9YqBFdI/0nmlK57O2mkF+3QAUlcLcH0ZRU5UlFmJ2R
 QaHrq9LOFFdPLHNAOETSyVpw2tHmHWEu7JjfTBuIrQdclUf/3HAx4lTlKr6KxxVJmyFg
 +96g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768914489; x=1769519289; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dODhUpJGsHLm41elCWu3sdnGJv6GIOiv5rNtn8qylng=;
 b=RqT/HsT6WVfVbNURlXzKe2FByx0o6H0ykiUHJb/t0CupauNuv+DjUtyTqllWzeIMsE
 Et2c+fI2wHDjhp4bqq0wOpj6RQXY6m5utEsA8FfLRfOBXbCSGyE1yUumUgHfk6UOWBIT
 oXeCymd53jPISYa7zallyTxOThnJ8sLFOEkxNWGGhlVNuIsKy2XfB2PjSM5n++SExWV8
 GkvrZls+94UaXSHZFGQ13khhiJDUtyujQGu3IRow0HBfv5zbkWMW4CziHuwq8Wbe7DMG
 pN8brP6KtHP7xK0mmrmd4tXHW08xCrPbWLGmZZtS7r1DSVVLpztbFTFYWBo2UFi1AOQo
 hjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768914489; x=1769519289;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dODhUpJGsHLm41elCWu3sdnGJv6GIOiv5rNtn8qylng=;
 b=W5SEAuNpa8Du7KFMkKDyPH1LGAs8Mma8lzRw69l/0eA/5wK1pwHUgNr/wuOrMT04EA
 G38VkXML44wPnZPhzhcQoNjwUyce9KHKA1V5vucPRFM0qlZhA4FM6NvHKhruIMjuNMY5
 85WRs0GX9AnggKzNq2h7nQiRQAejMOdP8m5P3zD4t5qQu4i58mvheOhX+eyoBfKrODVK
 5XrpSMOxliYvL7tox2i1Mhm4omC56RvzPBeLSMWvtXIgrS1UdMBMfdr0qHCGYuM9OifP
 GmxHlQVtG5+PzeIMO5rhvZTcXEHJKzq8gAKUQK53x33ZHcptoUFeuGNGZjJ8zDH7oa57
 Yzsw==
X-Gm-Message-State: AOJu0YwOBhtasChv0yNXDmDKv7BcK7QAmKVRt0THtekWmoAVzA7YOrzR
 e6bz6EKDc96GOdkiYzYtUuY44g5MZbpHn7l8OLO/LJzONGRoLVzAt8tKZjzKF3pGR2DbB6rqSkq
 UQHuObQ1jaUMIBp/5lMjcncZHd6M5bSkSz73mCqjmtQ==
X-Gm-Gg: AZuq6aJ+nAx0FbxbDfIEaqFnnAuk4Kl4JB6WkmStS4hHiRAJgJeRNiv7wKcK5/SQw08
 q25hnCkNwfYI2k8ttWenrLlRcSruxNpB10g2iuLXR2uwk9lY7PzYRdraTtMHn2ep27z+G4v64/x
 4iyQizu/FexfYssoz0knZT45A8DcojPevVNhd9zfmqwQUeux8GZCJdC6u1fKMhkRS4oP/BwDM2t
 aZGFfYKM2Q2Uy9KSKoAJYQ+1rp2SDIOLYn1Tfbo1d6sVewBmbcRdeQgNPBOsCrBQYHGNQ==
X-Received: by 2002:a05:690c:1a:b0:793:8eec:3a7a with SMTP id
 00721157ae682-7940a161317mr13225147b3.29.1768914488692; Tue, 20 Jan 2026
 05:08:08 -0800 (PST)
MIME-Version: 1.0
References: <20260115142629.665319-1-peter.maydell@linaro.org>
 <20260115142629.665319-4-peter.maydell@linaro.org>
 <87o6mplkjk.fsf@pond.sub.org>
 <CAFEAcA8=psrFCnssVUdSwUrw16x3rBRjB=BV0VmGc1MiMDxPZA@mail.gmail.com>
In-Reply-To: <CAFEAcA8=psrFCnssVUdSwUrw16x3rBRjB=BV0VmGc1MiMDxPZA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jan 2026 13:07:57 +0000
X-Gm-Features: AZwV_Qii-MWOBSOs2Cbua5dAcixHq58Y54pquAV9X53p-HsuVsRiJZwKUfAFPPQ
Message-ID: <CAFEAcA8GamFCGxPwptjQS5XKGVU=sX1t4yjZWLZDVq+uoAWNdA@mail.gmail.com>
Subject: Re: [PATCH 3/4] qemu-options.hx: Drop uses of @var
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Mon, 19 Jan 2026 at 15:06, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 19 Jan 2026 at 14:55, Markus Armbruster <armbru@redhat.com> wrote:
> >
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >
> > > A few entries in qemu-options.hx use the syntax "my-option=@var{name}"
> > > when documenting an option that takes an argument. This syntax isn't
> > > consistently used, and the documentation generation has no support for
> > > it: it just appears literally in the HTML output.
> >
> > TexInfo leftovers?
> >
> > > Switch these uses to the more common "my-option=<name>". This also
> > > doesn't have any particular support in the documentation generation
> > > and so appears literally in the output, but it is a little less odd
> > > looking to the end-user.
> >
> > Note for later: rewrite 1 is from KEY=@var{VALUE} to KEY=<VALUE>.
>
> More generally, any uses of @var{} to KEY=<VALUE>.
>
> > > The other common pattern we have is "my-option=name" with no marking
> > > at all that the right hand side of the '=' is not literal text;
> > > using <> seems preferable to me, as it makes it more distinct from
> > > cases where the right hand side is documenting that only certain
> > > values are permitted, as in "my-option=on|off".
> >
> > Rewrite 2 is from KEY=VALUE to KEY=<VALUE>.
>
> This patch is not trying to do any rewrite 2; this part of
> the commit message is just noting that we are not consistent
> about KEY=<VALUE> currently, and so we had another option for
> how to fix the @var{} usage, and explaining why I didn't take
> that other option.
>
> > > We don't change the uses of @var in the colo-compare documentation,
> > > as that part deserves a slightly more wide-ranging overhaul that
> > > is better in its own commit.
> > >


> > So, what this patch actually does is rewrite 1 plus add missing values.
> > Could be separate patches, up to you.  Regardless, the commit message
> > should match what the patch does.
>
> I think it does. Perhaps it could be more clearly stated...

So if we make the commit message be this:

===begin===
A few entries in qemu-options.hx use the syntax "my-option=@var{name}"
(or @var{} with no name specified) when documenting an option that takes
an argument. This syntax isn't consistently used, and the documentation
generation has no support for it: it just appears literally in the
HTML output.

Switch these uses to the more common "my-option=<name>". This also
doesn't have any particular support in the documentation generation
and so appears literally in the output, but it is a little less odd
looking to the end-user.

The other common pattern we have is "my-option=name" with no marking
at all that the right hand side of the '=' is not literal text;
using <> seems preferable to me, as it makes it more distinct from
cases where the right hand side is documenting that only certain
values are permitted, as in "my-option=on|off". This patch doesn't
do anything about existing uses of this pattern (except in one case
which was so confused as to use "my-option=@var{}" in the --help
output and "my-option=" in the RST output, where we change both
for consistency), but prefers not to add more of them.

We don't change the uses of @var in the colo-compare documentation,
as that part deserves a slightly more wide-ranging overhaul that
is better in its own commit.
===endit===

is that clearer ?

thanks
-- PMM

