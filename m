Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE97D29C2E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 15:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhqq0-0008HY-UK; Mon, 19 Jan 2026 10:06:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vhqpz-0008FN-IO
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 10:06:39 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vhqpx-0003nH-Oe
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 10:06:39 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-78fc3572431so45870017b3.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 07:06:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768835196; cv=none;
 d=google.com; s=arc-20240605;
 b=KkEH3rp2SDsRe2AkyrpOECcxOwMSNloijdgaXT2EuNq3CdEQNksPMbK5tcCDyR9/pN
 QovMKeZ0h7qY2TMhWxKdqlsl0CEqFeDPkfOZTKrjr1fe/WxnJ9hOUrK0xenUk7+MtNWI
 i5J0C7K5Ezq0u+du9MeYi7sDmrFkUUesFhVOFlpUZ2Ke8pm9RkQYMsorZLSztxHSieUP
 7vDYu/s3yr1FYupDtWVccNj5RM7ipksQ3H38qQyb7WvLskRtb7rsy++ndvDbRd1zOkuA
 +RWal9v/C7mOckp7Wz5zKdji2ga4+W6zEApPo9Sm9g48LmZZmnTtCajxiW4qcHY7TcUq
 54pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=p4W1gG0X4bCYXfbzKfBWZgtjQlTtkMq+GzMIfsy9dYg=;
 fh=ea5iynPX0c3PeNaJDpBz488PRwtBvVAI4RKUDWzUnsI=;
 b=SAluKjHburYvBsv+XBEH8gw9cLHbUbFsDRH5Ty79fM4KUlEeL7x3tIqcOhp7mHkqhT
 9uKXOV++IoEOq0yCV0qVdxooPyf6KTuRhC8LT7RIoR1u8PnEtdQjrg+FdAigbHA/ac1/
 W2NXVOG9hyHLyMT9aq/JlXkm+jbG6PesOxD2pGX6nzqANxbgOVaJdjZGFMcOhhM+53Bv
 16Mcp1qRcNoVeMNItHKSgtsPtY6mHIX3sD7NG06QDNHHEgXXdLnfhlci4G6AywEi8C8G
 gRuhXI3OUCFQ9mstxJXxAIOBahcsNWRsGAWHNslxyuaLDUTVBOPKtO9h2Gh21z4dkASu
 ugng==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768835196; x=1769439996; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p4W1gG0X4bCYXfbzKfBWZgtjQlTtkMq+GzMIfsy9dYg=;
 b=AQ/ZuFUVp4C3+gikJeAP1e5uZWmMa7mav78og1bNBDL+nNOKjZKN/hfAcC7raCKug0
 dloLZVrB5EF0AeN/ixZAv0rOIeliCMbv0go2F8yfemRgMNb68sswppLYxEIk/Z5gctWy
 1YcNDtOxssxQO7DFSNi8cnClqeqz7lM3Sfxp7Wi+/dA6Jx3WHHQ1f8ZFLM9sUHQyrZrX
 LdafLp3ccowZFUYsyaURjbbj1MJoCtR6yFGYXSd24+4f9Ir2OeK8wFow3qz2X7FbnC7S
 RkPgAsdsN8WfGZIJd+kc5ESCtflNuTm7796SkqGfAPQ3H1mFTInXKKXxSdJC0lJqLOfB
 /VcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768835196; x=1769439996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p4W1gG0X4bCYXfbzKfBWZgtjQlTtkMq+GzMIfsy9dYg=;
 b=GkS+TBgNGAX6Is1bZPOdI9544ilRfEO5mksfTFEYRminalgYSSxPAzyJGSuzhPg1OP
 27mOMcGwniImmHr1TYaU5V1tb0k3ej/1pXXLwHryjZggzKuQHsBJ+1FxZfzuZCMGoK4Y
 ku1nmm1g+JHZW0Wne+11dU1UvyrswpRC5sn//0D7mw/PRcwYn+zV9S8MRiogbwb+/biS
 Wv7nf1PdNvFFN2i2NpUlJ722uNg2EyCl3qCdJg4gKHe+OgD/yqMJHWAvUSGxbhxZ8Hf0
 vGPBXLO/Drz7O+J14zVqIWxRbUtwUrRHuzgU1tJshqYP7Jtt7eagOsHCskKidfyyI8ho
 XKJw==
X-Gm-Message-State: AOJu0YzFQqXovTrnC7vND7S6KO1bOBaEOAENcok39anXd5Ndgde+aT8J
 LVCp5Hmi54VChjnV9VRCds6RuB3zdCHqcUwO6xKGwSaa93op1+F8t5Kx/BS0wTwvQL7c9X7nTnL
 HDfVOxeMOWu3KpaLIjdjsluwzKR8haShNOOVp62Rh1w==
X-Gm-Gg: AZuq6aL2Jh7nYCS2oh6nToyKhRJ1zW/aV/+znvK0MjWrPxLeRArlktmqXUQ203kyXzK
 QlHg5GCeOS6Ml9YDN0ke8PCdUGVLZv83lgt2pXMuwqg9ToQkSrNFWAIiF7lVZI6JVe5xuMZKrao
 W6QgbWbYvCsoJAE6AOBGGwZGwg9r0FVVoy15UsczcQhF1vcDU2+di2p0NQRLYlHS4xgdd1st8Ux
 5Bq/glW/I1Tn/maKrziG9ArDH/PrFUD4yTUui9dFWO+tfj08Wz/w/x5EKUcEy6mufwrww==
X-Received: by 2002:a05:690c:6f10:b0:793:afdd:e63e with SMTP id
 00721157ae682-793c544d6ddmr93068357b3.33.1768835196310; Mon, 19 Jan 2026
 07:06:36 -0800 (PST)
MIME-Version: 1.0
References: <20260115142629.665319-1-peter.maydell@linaro.org>
 <20260115142629.665319-4-peter.maydell@linaro.org>
 <87o6mplkjk.fsf@pond.sub.org>
In-Reply-To: <87o6mplkjk.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jan 2026 15:06:24 +0000
X-Gm-Features: AZwV_QidmhmSX8kE_OXSmWALCJdlXsjeBViVCQwt6m-P4sfLAZipWrMX0Nnq6ok
Message-ID: <CAFEAcA8=psrFCnssVUdSwUrw16x3rBRjB=BV0VmGc1MiMDxPZA@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Mon, 19 Jan 2026 at 14:55, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > A few entries in qemu-options.hx use the syntax "my-option=@var{name}"
> > when documenting an option that takes an argument. This syntax isn't
> > consistently used, and the documentation generation has no support for
> > it: it just appears literally in the HTML output.
>
> TexInfo leftovers?
>
> > Switch these uses to the more common "my-option=<name>". This also
> > doesn't have any particular support in the documentation generation
> > and so appears literally in the output, but it is a little less odd
> > looking to the end-user.
>
> Note for later: rewrite 1 is from KEY=@var{VALUE} to KEY=<VALUE>.

More generally, any uses of @var{} to KEY=<VALUE>.

> > The other common pattern we have is "my-option=name" with no marking
> > at all that the right hand side of the '=' is not literal text;
> > using <> seems preferable to me, as it makes it more distinct from
> > cases where the right hand side is documenting that only certain
> > values are permitted, as in "my-option=on|off".
>
> Rewrite 2 is from KEY=VALUE to KEY=<VALUE>.

This patch is not trying to do any rewrite 2; this part of
the commit message is just noting that we are not consistent
about KEY=<VALUE> currently, and so we had another option for
how to fix the @var{} usage, and explaining why I didn't take
that other option.

> > We don't change the uses of @var in the colo-compare documentation,
> > as that part deserves a slightly more wide-ranging overhaul that
> > is better in its own commit.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  qemu-options.hx | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index ec92723f10..aca9dba8b9 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -36,7 +36,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
> >      "                dea-key-wrap=on|off controls support for DEA key wrapping (default=on)\n"
> >      "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
> >      "                nvdimm=on|off controls NVDIMM support (default=off)\n"
> > -    "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
> > +    "                memory-encryption=<id> memory encryption object to use (default=none)\n"
>
> This is rewrite 1, except you additionally make up a missing VALUE.

The key=<value> syntax requires one, or it wouldn't be that syntax.

> >      "                hmat=on|off controls ACPI HMAT support (default=off)\n"
> >      "                spcr=on|off controls ACPI SPCR support (default=on)\n"
> >  #ifdef CONFIG_POSIX
> > @@ -100,7 +100,7 @@ SRST
> >      ``nvdimm=on|off``
> >          Enables or disables NVDIMM support. The default is off.
> >
> > -    ``memory-encryption=``
> > +    ``memory-encryption=<id>``
> >          Memory encryption object to use. The default is none.
>
> This is rewrite 2, except you additionally make up a missing VALUE.

This is just because we changed the memory-encryption suboption
in the --help output text above and so also should fix it up
in the RST docs here.

> This patch and the next apply rewrite 1 exhaustively.
>
> Not the case for rewrite 2, e.g. there's still
>
>     "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
>
> where the value size is not literal.  Many more.
>
> So, what this patch actually does is rewrite 1 plus add missing values.
> Could be separate patches, up to you.  Regardless, the commit message
> should match what the patch does.

I think it does. Perhaps it could be more clearly stated...

-- PMM

