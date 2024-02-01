Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36256C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 13:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVXVa-0007PB-LN; Thu, 01 Feb 2024 08:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVXVX-0007Od-IS
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 08:53:35 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVXVO-0003cU-Ps
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 08:53:34 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-55a9008c185so1679551a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 05:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706795602; x=1707400402; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L1SjIdc3K5/vc5em8IlvbJr3OvupsKU2PCUxUgJAu+A=;
 b=m9dFoiNAvx1iPupRL/BUL5g4BgHUmYOLVgfEGt3mKyz6zjIF7n3ZxBI3kaaKz2dV9S
 a/JW49maCUaZLVCIMaKakrJRmeNbeJ/v3GJq/I5OAlF1+vjoR5X1gOiqewhObdfPFcI+
 YbfNpRHObVdnU5OYGXsHWNFLDMhBZydMHSTLKLCLkFgrtR9lQVXJPWIYd09VMQ738JqR
 oZXtRcZABq/pG84XJlKV5+mD7beXhqqpjaLGcG+jSBPWvBUyc2lPOLXETJc9Mm8HHtuj
 rMD4Qnt+n2XG53wMor2IJjkO6XBrp4X0opENvSOTRiFJ52Oqy2mX2rLel2CXpBGES48q
 tPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706795602; x=1707400402;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L1SjIdc3K5/vc5em8IlvbJr3OvupsKU2PCUxUgJAu+A=;
 b=rQZ+2uXsv06vv3Uc1pjthiuCKEElzEOmPutGDbubu4Ar+HBBq+YEkA4wYRkm8xbphL
 VVpbTuluketSQEabbvDFA95RVJ1S6kQZjU073H/zBFV2oxb1mwej+pnNaHErxPvUfp8x
 GqlBoIVkj3RtdweIH8lbreyCej5eUv76V4lGL4Dtcm0I//uPqcPjK3ThnMjqATz4L6xG
 znhmIpzoy2tjoBAnY5RQ/TYQq8tnWSLVpkxvQHEygkW+dM8zRk6lYNvNyrqJe6Wv8lip
 iEJnuhgrDaQTV6PzeqoeT/AS1DkICC/K6P5DiYnSwqULDsPhmGoD7DfAhg0eWYEurXTF
 pm4w==
X-Gm-Message-State: AOJu0YyMdAaJr0X41YZaqScLztMvX2BDE4l7VS4SqGtlEquYV8Ua6UDC
 /mhNu7ddFB2l94FEcPX6BatdzQhM04IDoujQI6c9Zu7F9aq4/Kpf/xYi8q4abSceYaVoFaatvKR
 jCE7KfB+F4btEeXSHAcAhsi4wUuW/UmXgQIHqAQ==
X-Google-Smtp-Source: AGHT+IGPSJ9By4g6YMHReYiwLhd8isC4XoqtQQOWkfNW3qSYQGRdAWjHhyEcLoZ9oOb3zrhhWYFsobCS2pG4wpN+/5s=
X-Received: by 2002:a50:9f43:0:b0:55f:ccb4:ec84 with SMTP id
 b61-20020a509f43000000b0055fccb4ec84mr690625edf.1.1706795602233; Thu, 01 Feb
 2024 05:53:22 -0800 (PST)
MIME-Version: 1.0
References: <20240130190348.682912-1-dwmw2@infradead.org>
In-Reply-To: <20240130190348.682912-1-dwmw2@infradead.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 13:53:11 +0000
Message-ID: <CAFEAcA8GVPjeyc2dxvmh0NtB-bp0yzXH25fpnWrjxzMEjzOLBQ@mail.gmail.com>
Subject: Re: [PATCH v4] doc/sphinx/hxtool.py: add optional label argument to
 SRST directive
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw@amazon.co.uk>,
 Paul Durrant <paul@xen.org>
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

On Tue, 30 Jan 2024 at 19:04, David Woodhouse <dwmw2@infradead.org> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> We can't just embed labels directly into files like qemu-options.hx which
> are included from multiple top-level rST files, because Sphinx sees the
> labels as duplicate: https://github.com/sphinx-doc/sphinx/issues/9707
>
> So add an optional argument to the SRST directive which causes a label
> of the form '.. _DOCNAME-HXFILE-LABEL:' to be emitted, where 'DOCNAME'
> is the name of the top level rST file, 'HXFILE' is the filename of the
> .hx file, and 'LABEL' is the text provided within the 'SRST()' directive.
> Using the DOCNAME of the top-level rST document means that it is unique
> even when the .hx file is included from two different documents, as is
> the case for qemu-options.hx
>
> Now where the Xen PV documentation refers to the documentation for the
> -initrd command line option, it can emit a link directly to it as
> '<system/invocation-qemu-options-initrd>'.
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Reviewed-by: Paul Durrant <paul@xen.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v4:
>  =E2=80=A2 Wrap long lines to shut checkpatch up

Applied to target-arm.next, thanks.

PS: for checkpatch long lines, note that our coding style doc
permits line lengths which checkpatch will warn about, if
it would be "obviously less readable" than wrapping. So
that particular warning is more of a "look at this and see
if it could be written in a different way" rather than a
"definitely change this to get rid of the warning" one.

(At some point I might try to go back and get the discrepancy
between what our coding style doc says checkpatch complains
about and what it actually complains about straightened out.
The underlying issue is that there's no consensus between
whether it's better that:
 * checkpatch produces a warning on code that's in a "grey
   area" where we might be OK with it but it might be better
   to change it, so that the patch submitter is prompted to
   look at that part of the change and consider altering it
 * checkpatch doesn't warn about "grey area" situations,
   so that we don't have "checkpatch complains but we're
   actually happy with the patch and wouldn't want it changed"
   situations
)

-- PMM

