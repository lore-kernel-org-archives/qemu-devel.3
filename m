Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AF1CA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 12:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqstF-0006jq-2A; Tue, 26 Aug 2025 08:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1uqstA-0006iw-2u
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 08:35:02 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1uqst7-0001Xg-13
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 08:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=5usHI9/Y7xqQrMQ/SJPLIiC7Bb3/zLQrSkR6dw3AVPc=; b=SP1txKsnFU/gjUbfOz4CohE4Fo
 QeL1HdHvbf+E4sXIuCLNV4hNWZWnDnMB70t2JAjlfoFnbzEHIuqhJh3eo3HNQGYM4d8uSDxuHC0n5
 w7V1DaESE3bqNlDXbFtporzLAJg5thTU+ofHprRcDKsMn3j5B4mMGo5lz0CWj+4DjMzcVNT+q0XSa
 GDWXGsK537qp7CPDhnaTOE713BKzVwQzIglTltlKIFmtWghoTvUhngGJoYKwFGW88m9fifigYfGEQ
 qcoMpTvn4NcSPqMONQ7PwnY3iDye2mX7BBDgdihgb0s+BuuB8/KvCa9xXc8jBC+RpbWatHl2zvQjW
 9Ry1AGUs5zsjhbeKYS45bsu7wy38YZ91unlnpWxglThPrkiqkwH+HlpYJeySIUd+/hdnpLap3ckd7
 t64hONdWUxJ0tLKAerc5KzffQvutDtnpsjXHB+vgmJtEpEYI9VU1woAEfWT5Fc5pELZLzlFRC7uma
 GsTZr4w/AE55n3hv74SK0ew23cWfqCEaTO32S2ACqPRncRZiFSvwl7TvQwh+dTbXgfU2MhwXAr/V3
 Fy2rX66MJltVZVN2e9spgl9dx3qJ+8jgu3qu6Hqui7mkA34uVThfOdzD8zI/p7HueZuWY5rjmSs42
 L2FrsmjV1vPbQCzP7P6cNgio5TOEQ/+ZticRZ4HiY=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Mark Johnston <markj@freebsd.org>
Cc: Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Marc=2DAndr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] 9pfs: Add FreeBSD support
Date: Tue, 26 Aug 2025 14:34:45 +0200
Message-ID: <12113631.YhV4tvpBIu@silver>
In-Reply-To: <aKxcsmP6MI5p9OPe@nuc>
References: <aJOWhHB2p-fbueAm@nuc> <2602995.s6eulQLtdm@silver>
 <aKxcsmP6MI5p9OPe@nuc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Monday, August 25, 2025 2:53:06 PM CEST Mark Johnston wrote:
> On Thu, Aug 21, 2025 at 01:24:04PM +0200, Christian Schoenebeck wrote:
> > On Wednesday, August 6, 2025 7:53:08 PM CEST Mark Johnston wrote:
[...]
> > Not forgotten. I just hoped there were other reviewers or testers in the
> > meantime, but be it.
> > 
> > Like I said, I don't have FreeBSD system here to test this, so I am taking
> > your word for now that you tested this and plan to bring this into QEMU
> > when master re-opens for new features soon.
> 
> Thank you very much!
> 
> In case I missed somewhat, what testing would you typically do
> otherwise?  So far I had run the QEMU test suite (which indeed found
> some bugs in the initial version) and tried mounting a 9pfs share from
> Linux and FreeBSD guests and doing a bit of manual testing.

Apart from QEMU's test cases, I also use guest systems running 9p as root file 
system [1], run software compilations there among some things. That proofed to 
be quite a useful test environment to spot edge cases, concurrency and 
performance issues and such.

[1] https://wiki.qemu.org/Documentation/9p_root_fs

Greg was running some general purpose file system stress test suite in the 
past, but I currently can't recall what that was.

> > If you have some time to adjust the commit log message above, that would
> > be
> > great, otherwise I can also handle this on my end later on. Looks like
> > that
> > comment is not adjusted for v2 yet (i.e. "user." and not mentioning
> > "system.").
> 
> Here's an amended commit log message.  Please let me know if this is
> better submitted as a v3.
> 
> commit b79bf1b7d42025e3e14da86a7c08d269038cd3ed
> Author: Mark Johnston <markj@FreeBSD.org>
> Date:   Wed Jul 16 20:32:05 2025 +0000
> 
>     9pfs: Add FreeBSD support
> 
>     This is largely derived from existing Darwin support.  FreeBSD
>     apparently has better support for *at() system calls so doesn't require
>     workarounds for a missing mknodat().  The implementation has a couple of
> warts however:
>     - The extattr(2) system calls don't support anything akin to
>       XATTR_CREATE or XATTR_REPLACE, so a racy workaround is implemented.
>     - Attribute names cannot begin with "user." or "system." on ZFS, so
>       these prefixes are trimmed off.  FreeBSD's extattr system calls sport
>       an extra "namespace" identifier, and attributes created by the 9pfs
>       backend live in the universal user and system namespaces, so this
>       seems innocent enough.
> 
>     The 9pfs tests were verified to pass on the UFS, ZFS and tmpfs
>     filesystems.
> 
>     Signed-off-by: Mark Johnston <markj@FreeBSD.org>

Almost. Maybe something like this to make it a bit more clear?

- Attribute names cannot begin with "user." or "system." on ZFS. However
  FreeBSD's extattr(2) system supports two dedicated namespaces for these
  two. So "user." or "system." prefixes are trimmed off from attribute
  names and instead EXTATTR_NAMESPACE_USER or EXTATTR_NAMESPACE_SYSTEM
  are picked and passed to extattr system calls instead accordingly.

/Christian



