Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8869C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 14:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wffAy-0005kL-5H; Fri, 03 Jul 2026 10:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wffAk-0005dz-05
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 10:47:20 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wffAi-0006Tj-4C
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 10:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Cc:
 Content-ID:Content-Description;
 bh=Xka4EkTrD4VdVEjZT5kNqstJyB1dBT3a5pJj6AHZyQc=; b=tpxk3NMMEdTl8XHzMDDpypxsac
 1il4/YsN/0iLIA6L3YE6Oe/jb8t8ZJGzAxhCXVLT/uuktHA3YOofP3IJZuemwEZdo4aPNSt/MvwIq
 u06bZNk6Z8ujhUyJMJ54dofjpXHiRwYZQQH3Qz/gRBmKXT8LqrCZOYsWOyrDhyULXM76dFBKYxuk2
 3m4c1y16dEWeCVIZvRII8EdhMB56aKh9i7yJRBAbJj+AskKKpY3Ytf9D8H6q3ecAlauTuBhY8Vfcp
 fYVA5CVFsIAajqhYuzqelgVBT226vDp8X2FnzVpQf1ECNwt+GRtCr1fGjD35+U+04xvCWsAGrDLOT
 e932/hgEvawV0RQar1sgHtCb9PptXW3rGBG/RIwFh/DQVXP30k2L10sm5/DMXvB8vFsF1SHQKipm5
 oet4xZLMlXaDkhoEMI3vnxmHjc5AB/gVOOX7cdfdArLE+1l26mJdkR9wFUqimxIEVvtIF3ccjR2z3
 BzU9AoSZMft046LpgY06zSR+skwLCQDfMooqXsfg2YZxhvVYbJoOTgAr6KnmbqEfULO2MSddjxq8s
 k4pwqKLlLy3QixD980B8i7cD66jTkdy3RTI6n+CsOmkdyshFCifiqem2/aSi3Yx6wNJehWE07nsX2
 olE3IwVPyWb5Bp7PCHqkYyZFAc8/nfcmWB53IhOqU=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 3/9] 9pfs: local : Introduce local_fid_fd() helper
Date: Fri, 03 Jul 2026 16:47:12 +0200
Message-ID: <9693848.rMLUfLXkoz@weasel>
In-Reply-To: <CAFEAcA_c9fgub436R+7u-Chmon3a=cfuLhzywi77XpLSRXPPPw@mail.gmail.com>
References: <cover.1746438650.git.qemu_oss@crudebyte.com>
 <1964729.CQOukoFCf9@weasel>
 <CAFEAcA_c9fgub436R+7u-Chmon3a=cfuLhzywi77XpLSRXPPPw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Friday, 3 July 2026 15:15:35 CEST Peter Maydell wrote:
> On Fri, 3 Jul 2026 at 13:49, Christian Schoenebeck
[...]
> We don't need to check before every syscall. We just need to
> check the error return from functions that can fail after we
> call them. This function can fail (because dirfd() can fail), so
> we should explicitly check that.

In practice, no. dirfd() only fails if either dirp argument is invalid or if 
the underlying system does not support the concept of file streams.

In both cases we have already catched them by checking via 
has_valid_file_handle().

So it is a pure theoretical issue (cannot happen, and would not cause any 
harm).

> >, even though I already explained that a) you never ever get there
> >
> > because this check is already made at the higher level call stack
> 
> If fid_type cannot possibly be anything other than one of the
> two valid values (i.e. anything else would be a bug elsewhere in
> QEMU), then maybe we should have
> 
>    switch (fid_type) {
>        case P9_FID_DIR:
>            return dirfd(fs->dir.stream);
>        case P9_FID_FILE:
>            return fs->fd;
>        default:
>            g_assert_not_reached();
>    }
> 
> ? That's the standard way we write "this isn't possible" and
> avoid it turning into doing weird stuff if it ever does happen.

That would turn an already graceful handled case (no harm, client receiving a 
clear and appropriate error) into a DoS.

You could add an error_report_once() though.

> > , and b) that
> > every syscall handles -1 as file descriptor gracefully.
> > 
> > If you still think this was not a false positive, you are welcome to send
> > a
> > patch.
> 
> I'll do that.

Thanks!

/Christian





