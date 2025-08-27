Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078D5CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 14:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urH9o-0002EK-Hr; Wed, 27 Aug 2025 10:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <markjdb@gmail.com>) id 1urH9m-0002DF-E1
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 10:29:46 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <markjdb@gmail.com>) id 1urH9j-0007dO-Ps
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 10:29:46 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4b1258a3d71so75525741cf.2
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 07:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756304981; x=1756909781; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=FCnDtMWUMNm1PUNBujMkFqMHYkiylWt3v7uSMDVVdzA=;
 b=NhJlTl/N+23fIPhSqtb9+5QzT+LUivkpopXsmcCos7RPkHTp/I1A3nnAWy015eOHnt
 Jcqvc5kzJbdrBzfFoMD30t9z7gklcEaDSMHLoO31liQapm0oDKifbr4GJ1ZPze1PHBf4
 KzwRrhWz/0PnFVWhNWNvzu4yg8DsRe0upqE3xWJOHfP/MbyJPyGQlrWqNi47N2XHH3cK
 PtQl4RRAJUqSwOia4VBbSluQp9FrgSKQs2Bo9w1097fsWKXajUjw3sq6FSdqh03fJggJ
 j1jl7p60QEbQA84GYqR/M0afN/6+H3UYagWzZBhA+Y39tnZAcgcYwX6WWklcqpSCkfmI
 NAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756304981; x=1756909781;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FCnDtMWUMNm1PUNBujMkFqMHYkiylWt3v7uSMDVVdzA=;
 b=nTJh8IR0enxucALTaeDtEWGUsyP+qRxfupXeLIBY7UzJm3xL3SREUxwNY03WKgswHG
 XB5/SSwii5Xru62gq+lK2kRxWZMThCfuIAhks0Q7UCZ9GkP5T0RIKoL5yzVKrUtcXS6B
 61M6yG2Nlu8cqA4mnoO0DCyO68dJ7TLj4p+V4fJb3MP2NhRoomCOotZOf7txKoXqoF1j
 lfXs82QFA7GpBV/zSXH8y5IghqmRL9UjlSBnYiq9tUmrYt7moKIQ+rHNoyT8Gy9K2NK6
 /ZmNph5a53rDmSsOu9jr3imX6ObhNruSFtQN5dZaId96kI8FuuC5Wq8OtS+9uxOu/3N6
 rCDw==
X-Gm-Message-State: AOJu0YzAMwqJHyoJaqEFyRYkMW09TjXuNPQ8d85dBxhzBpwtsJC3TD92
 oHiMpNh4FiQKP26mDvMJ8T+x0rcggHHHliWJVnTQiICxTvOfzoX7AVD5
X-Gm-Gg: ASbGncueh8c16ukWCbkOAHW+vW2kfUPPeBH7yyj/s4keUzXF3CAm6+kpzTBFREbQeun
 LPBMQmHmHvKw82SgDQOZLrZUGl5I6vu1I0FssG6vhBqDZuxMsM4ojcKArFC+1zgnF4juhsCyWr2
 M9xSglaJuEoZtM2uVBA5dp4yOgsjPkEU8qDMf4QGoLVbN0Qu0UuYzqa9iPqQpp6TefI24goeg05
 voRBVwgU9UL+rpni7HGVP3L8cB7s11koKXAP7BgkT+CkUGT+YsYN+XYc9X0p0s8/6xH3jdS8esr
 KlUavCRIMt8+lRIT1zAZe9EJOMjAa+dcMc9AjjtZ4djBzlRGCrGzXp0lLr9cr76jFOy8blUd4Jz
 8+J5RxLuRCJguMXz0U8LzQsniOTmCpI55xSX+9yOyDTknmtSgeYee0GDg/Q==
X-Google-Smtp-Source: AGHT+IELtIcPtSOQQ1TvX3ATwVXE6ifuNW9Xo+sGfQnBr5PSRpIqhXlPkp6cipIqAVVIO0iw5t6hKA==
X-Received: by 2002:a05:622a:130e:b0:4b0:7f93:3cdb with SMTP id
 d75a77b69052e-4b2aab0d457mr199631311cf.43.1756304981088; 
 Wed, 27 Aug 2025 07:29:41 -0700 (PDT)
Received: from nuc (192-0-220-237.cpe.teksavvy.com. [192.0.220.237])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7f20e555603sm531552785a.26.2025.08.27.07.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 07:29:40 -0700 (PDT)
Date: Wed, 27 Aug 2025 10:29:37 -0400
From: Mark Johnston <markj@freebsd.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] 9pfs: Add FreeBSD support
Message-ID: <aK8WUWSIV6Bz526v@nuc>
References: <aJOWhHB2p-fbueAm@nuc> <2602995.s6eulQLtdm@silver>
 <aKxcsmP6MI5p9OPe@nuc> <12113631.YhV4tvpBIu@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12113631.YhV4tvpBIu@silver>
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=markjdb@gmail.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 HK_RANDOM_ENVFROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Aug 26, 2025 at 02:34:45PM +0200, Christian Schoenebeck wrote:
> On Monday, August 25, 2025 2:53:06 PM CEST Mark Johnston wrote:
> > On Thu, Aug 21, 2025 at 01:24:04PM +0200, Christian Schoenebeck wrote:
> > > On Wednesday, August 6, 2025 7:53:08 PM CEST Mark Johnston wrote:
> [...]
> > > Not forgotten. I just hoped there were other reviewers or testers in the
> > > meantime, but be it.
> > > 
> > > Like I said, I don't have FreeBSD system here to test this, so I am taking
> > > your word for now that you tested this and plan to bring this into QEMU
> > > when master re-opens for new features soon.
> > 
> > Thank you very much!
> > 
> > In case I missed somewhat, what testing would you typically do
> > otherwise?  So far I had run the QEMU test suite (which indeed found
> > some bugs in the initial version) and tried mounting a 9pfs share from
> > Linux and FreeBSD guests and doing a bit of manual testing.
> 
> Apart from QEMU's test cases, I also use guest systems running 9p as root file 
> system [1], run software compilations there among some things. That proofed to 
> be quite a useful test environment to spot edge cases, concurrency and 
> performance issues and such.
> 
> [1] https://wiki.qemu.org/Documentation/9p_root_fs

Thanks, I'll give this a try.

> Greg was running some general purpose file system stress test suite in the 
> past, but I currently can't recall what that was.
> 
> > > If you have some time to adjust the commit log message above, that would
> > > be
> > > great, otherwise I can also handle this on my end later on. Looks like
> > > that
> > > comment is not adjusted for v2 yet (i.e. "user." and not mentioning
> > > "system.").
> > 
> > Here's an amended commit log message.  Please let me know if this is
> > better submitted as a v3.
> > 
> > commit b79bf1b7d42025e3e14da86a7c08d269038cd3ed
> > Author: Mark Johnston <markj@FreeBSD.org>
> > Date:   Wed Jul 16 20:32:05 2025 +0000
> > 
> >     9pfs: Add FreeBSD support
> > 
> >     This is largely derived from existing Darwin support.  FreeBSD
> >     apparently has better support for *at() system calls so doesn't require
> >     workarounds for a missing mknodat().  The implementation has a couple of
> > warts however:
> >     - The extattr(2) system calls don't support anything akin to
> >       XATTR_CREATE or XATTR_REPLACE, so a racy workaround is implemented.
> >     - Attribute names cannot begin with "user." or "system." on ZFS, so
> >       these prefixes are trimmed off.  FreeBSD's extattr system calls sport
> >       an extra "namespace" identifier, and attributes created by the 9pfs
> >       backend live in the universal user and system namespaces, so this
> >       seems innocent enough.
> > 
> >     The 9pfs tests were verified to pass on the UFS, ZFS and tmpfs
> >     filesystems.
> > 
> >     Signed-off-by: Mark Johnston <markj@FreeBSD.org>
> 
> Almost. Maybe something like this to make it a bit more clear?
> 
> - Attribute names cannot begin with "user." or "system." on ZFS. However
>   FreeBSD's extattr(2) system supports two dedicated namespaces for these
>   two. So "user." or "system." prefixes are trimmed off from attribute
>   names and instead EXTATTR_NAMESPACE_USER or EXTATTR_NAMESPACE_SYSTEM
>   are picked and passed to extattr system calls instead accordingly.

I folded your suggestion in with a couple of minor tweaks:

commit 61de78986912b03f08354a177caf603857b531b5
Author: Mark Johnston <markj@FreeBSD.org>
Date:   Wed Jul 16 20:32:05 2025 +0000

    9pfs: Add FreeBSD support
    
    This is largely derived from existing Darwin support.  FreeBSD
    apparently has better support for *at() system calls so doesn't require
    workarounds for a missing mknodat().  The implementation has a couple of
    warts however:
    - The extattr(2) system calls don't support anything akin to
      XATTR_CREATE or XATTR_REPLACE, so a racy workaround is implemented.
    - Attribute names cannot begin with "user." or "system." on ZFS.
      However FreeBSD's extattr(2) system calls support two dedicated
      namespaces for these two.  So "user." or "system." prefixes are
      trimmed off from attribute names and instead EXTATTR_NAMESPACE_USER or
      EXTATTR_NAMESPACE_SYSTEM are picked and passed to extattr system calls
      accordingly.
    
    The 9pfs tests were verified to pass on the UFS, ZFS and tmpfs
    filesystems.
    
    Signed-off-by: Mark Johnston <markj@FreeBSD.org>

