Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC365CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 10:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umrOB-0002Lt-Mx; Fri, 15 Aug 2025 06:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umrOA-0002Lh-Gn
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 06:10:22 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umrO8-0003H1-A5
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 06:10:22 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e931cdd64d1so1885087276.3
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 03:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755252619; x=1755857419; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mG8ga8i1OE7tqY0nsKH05iJWEjtucZ+9Sfy2Pj4VskU=;
 b=OdpxQi6qs0EJHySiCXiOCfMzf0ig8gB3jcvqWwBVkU7JhpTO94Xb4N+QFjNpLYK2ys
 fuCJyY5PG1FMKp4EqRl/E0/mYQ+TTh/NL5C4JyZIpu5lIhUg6yqTeFMIV+HVy5L4i4yB
 Idgc7vJKxGqcLnLoNWxyboCp76WXqxB+EcWqTyuJb8nHrIbJ/jkOz0RvY/EpblShKIhc
 8gSchR3vqyvtLAF+0gmlKPelQcRywLBXk5h8CHsSxLOTWfzBR3g6H2qS4HwJuIPScCbq
 aWd87pM+rgo39B4dBgKerBK9TmxRMe+QzJEqcE/Cl81Me6VOnCxIx6Niiu/Ds4OxH5QW
 WSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755252619; x=1755857419;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mG8ga8i1OE7tqY0nsKH05iJWEjtucZ+9Sfy2Pj4VskU=;
 b=hrdOaU5SW8lRDvOikPNectUsD5SyN0l9c/eG4s2qUGiEI6u396AEnUUAvDhnerLXtu
 ogj8MlHGjf24tKkF9FNrY8zK8h6llfpd2fl4F+aIjvJJ/bwchAj5o9LyBTfWm4rRLBWk
 gdwwwFOGVEW3vUJwL+25ud4d6FSQ2ooKH8ft8wHIP1pdrg6QViODX9JarYJk4cZ0oaFJ
 VxAfVroB4kcaSouhihXknB4lJfJV7loRcdYXdZWPVwL3aDByWjsybuMjr5rMVfyUbskG
 H2x1xeOCLvToUd0zKISiK6hNPh3AM2JolO60Bqx1MrvcjQ36tGt5RepOLNcP95Rie5sG
 pYwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJj4mlLjGckU1SKAnTzOYp4l2Xlk21EH7AnqGsl7hs34rBzo6rokIUaPytpV5z2n3/gbOpqZFBkRhb@nongnu.org
X-Gm-Message-State: AOJu0YwuuG6ZH6qPTsMY3bBXwe6oUGkUyltyE8o6SUkl6PVXt+HSbcoi
 x3jtOFi2x7TMO04k2k1zmtOEIGu3P44nwu9FsQtJ79PHFVnGrGlBrmXjkFWJZ0DNvL5gQkZbuS3
 9ZXmWtJoftfvJs/vbFRo0rexNZn7YgippQs5OyZVu5A==
X-Gm-Gg: ASbGncuiX3/GF/UspxSz5oi9aZIJCF+8rL3oc3gN+7grhODApNbdhHIDYtCVeoltG/D
 tisolxsjLu5nr/OBCM6wNuYsL6LGIKoGOkboGbfmqVDz0fyW53jJJ+X/DeOoU0h8QJFJaBueXRI
 C9EmAHj95vk9ee5gprX7hBXw1S48kjJsG0/u3OCXY0pS3TPigOXoBE+KIAKWmTgVwiDWyUB3OX5
 MDw+cYE
X-Google-Smtp-Source: AGHT+IEm3zk2iCJQzkhZfEMOl9SjNp6gxFzqaU2CGHotC9iILm6O4Mm8YW8GWqnl0aooGr0/VugHMl1bdyfqnsTOZWk=
X-Received: by 2002:a05:690c:74c8:b0:71a:17fa:bf07 with SMTP id
 00721157ae682-71e6ddb64f0mr16433787b3.40.1755252618567; Fri, 15 Aug 2025
 03:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250814171324.1614516-1-peter.maydell@linaro.org>
 <20250815101109.00006bcd@huawei.com> <20250815113931.7f4f60e7@foz.lan>
In-Reply-To: <20250815113931.7f4f60e7@foz.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Aug 2025 11:10:05 +0100
X-Gm-Features: Ac12FXziXf-vbXDuj3hJQAvZ2cSMm-9SHqW1M9Nn08uT_1jdzAM0IJosJtwNVlk
Message-ID: <CAFEAcA8Kck0ktFOK659rrrFvSkuc7WM_PEgPtEZAjXdgHtQ+5Q@mail.gmail.com>
Subject: Re: [PATCH for-10.2 0/8] docs: Update our kernel-doc script to the
 kernel's new Python one
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Fri, 15 Aug 2025 at 10:39, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Hi Peter/Jonathan,
>
> Em Fri, 15 Aug 2025 10:11:09 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:
>
> > On Thu, 14 Aug 2025 18:13:15 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > > Earlier this year, the Linux kernel's kernel-doc script was rewritten
> > > from the old Perl version into a shiny and hopefully more maintainable
> > > Python version. This commit series updates our copy of this script
> > > to the latest kernel version. I have tested it by comparing the
> > > generated HTML documentation and checking that there are no
> > > unexpected changes.
>
> Nice! Yeah, I had a branch here doing something similar for QEMU,
> but got sidetracked by other things and didn't have time to address
> a couple of issues. I'm glad you find the time for it.
>
> > > Luckily we are carrying very few local modifications to the Perl
> > > script, so this is fairly straightforward. The structure of the
> > > patchset is:
> > >  * a minor update to the kerneldoc.py Sphinx extension so it
> > >    will work with both old and new kernel-doc script output
> > >  * a fix to a doc comment markup error that I noticed while comparing
> > >    the HTML output from the two versions of the script
> > >  * import the new Python script, unmodified from the kernel's version
> > >    (conveniently the kernel calls it kernel-doc.py, so it doesn't
> > >    clash with the existing script)
>
> > >  * make the changes to that library code that correspond to the
> > >    two local QEMU-specific changes we carry
>
> To make it easier to maintain and keep in sync with Kernel upstream,
> perhaps we can try to change Kernel upstream to make easier for QEMU
> to have a class override for the kdoc parser, allowing it to just
> sync with Linux upstream, while having its own set of rules on a
> separate file.

Mmm, this would certainly be nice, but at least so far we haven't
needed to make extensive changes, luckily (you can see how small
our local adjustments are here).

> > >  * tell sphinx to use the Python version
> > >  * delete the Perl script (I have put a diff of our local mods
> > >    to the Perl script in the commit message of this commit, for
> > >    posterity)
> > >
> > > The diffstat looks big, but almost all of it is "import the
> > > kernel's new script that we trust and don't need to review in
> > > detail" and "delete the old script".
>
> One thing that should be noticed is that Jonathan Corbet is currently
> doing several cleanups at the Python script, simplifying some
> regular expressions, avoiding them when str.replace() does the job
> and adding comments. The end goal is to make it easier for developers
> to understand and help maintaining its code.
>
> So, it is probably worth backporting Linux upstream changes after
> the end of Kernel 6.17 cycle.

Thanks for the heads-up on that one. A further sync should
be straightforward after this one, I expect.

> > > We should also update the Sphinx plugin itself (i.e.
> > > docs/sphinx/kerneldoc.py), but because I did not need to do
> > > that to update the main kernel-doc script, I have left that as
> > > a separate todo item.
>
> The Kernel Sphinx plugin after the change is IMHO (*) a lot cleaner
> than before, and hendles better kernel-doc warnings, as they are now
> using Sphinx logger class.

Also as much as anything else it's just nice for us not to
diverge if we can avoid it.

Incidentally, I'm curious if the kernel docs see problems
with docutils 0.22 -- we had a report about problems there,
at least some of which seem to be because the way kerneldoc.py
adds its rST output is triggering the new docutils to complain
if the added code doesn't have a consistent title style
hierarchy: https://sourceforge.net/p/docutils/bugs/508/
(It looks like they're trying to address this on the docutils side;
we might or might not adjust on our side too by fixing up the
title styles if that's not too awkward for us.)

> Btw, one important point to notice: if you picked the latest version
> of kernel-doc, it currently requires at least Python 3.6 (3.7 is the
> recommended minimal one). It does check that, silently bailing out
> if Python < 3.6.

QEMU already requires Python 3.9 or better; our configure checks:

check_py_version() {
    # We require python >= 3.9.
    # NB: a True python conditional creates a non-zero return code (Failure)
    "$1" -c 'import sys; sys.exit(sys.version_info < (3,9))'
}

Thanks for the confirmation that the kernel is being more
conservative on python requirements than we are; I did
wonder about this but merely assumed you probably were
rather than specifically checking :-)


On this minor output change:

> > > "Definition" sections now get output with a trailing colon:
> > >
> > > -<p><strong>Definition</strong></p>
> > > +<div class="kernelindent docutils container">
> > > +<p><strong>Definition</strong>:</p>
> > >
> > > This seems like it might be a bug in kernel-doc since the Parameters,
> > > Return, etc sections don't get the trailing colon. I don't think it's
> > > important enough to worry about.

is the extra colon intentional, or do you agree that it's
a bug? You can see it in the kernel docs output at e.g.
https://docs.kernel.org/core-api/workqueue.html#c.workqueue_attrs

where in the documentation of struct workqueue_attrs,
"Definition:" gets a kernel but the corresponding "Members"
and "Description" don't.  (Also "Description" is out-dented
there when it probably should not be, but that's separate.)

thanks
-- PMM

