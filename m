Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17613C43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 11:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfcGr-0003La-3p; Fri, 03 Jul 2026 07:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wfcGp-0003L9-9p
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 07:41:23 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wfcGn-00082H-Le
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 07:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=pOLDR/CB0dS5d8cneXI0O+PzSGSOzQC1FUxlt5CpwZg=; b=vwNi9Rku+SiCayrTmGNp9LMIVe
 R3Sr1im1NaZ0nrZoP9v/M+ygskWS2H0aqexBoXcU5UH+Mgdoj0mH9+wvfZubMlHQGTXxR90Wc3z0o
 ZDDWyogmmOZsuJW3KF4MByxjAucRHMRBM7tR995T5YO9TzBGnBhJ2P4pqB+ikqLlN/+m5G9GLEFMt
 kQQcsby7dzEHNF6++BZrpvKgkBY09PZcg5QdLuPtT6/78Fs5V5DC5UB1/6o7IQGS68ZLI9lZF8iro
 JVdd4H+ipbwbdWyTZGQ5BQ9ixinvMEI/5f/ytiErQslzm6fns8tMwSee9XS/FBnhMaCi8Uf//ukde
 nPyDoQkVGBqo70t2L4bY7NHQsL+DWuZC3Xn2xClNN03oL6wmV1bxlibeUAsYGfatQEWmkR0wQ5TIK
 gl0FPveGaFzpvkp/ZtBaByeiRK8ZyP1XVnxz8QysBoN9ghsc/qto0wUKEyH7ArToXd1vXZejSrWHh
 73RUCcy4RB/0vZKCpmyfR3jaNzp5+o8lFHt3vGh8NxQiztzT/E8lVhoNIZp1cRvCPHk9n2xI9g2pV
 qIOCBSVr8shYwpKKzNSBLlliElBY13EyWUI4nuCO+tUKy3wmPflILtXnBSwqvVe8U5VK/XWsbkXB0
 ZY3oliLmuQyN1SXnChSe4zWv1wFyVZrRpwCmd5zXI=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PULL 3/9] 9pfs: local : Introduce local_fid_fd() helper
Date: Fri, 03 Jul 2026 13:41:17 +0200
Message-ID: <23160010.EfDdHjke4D@weasel>
In-Reply-To: <CAFEAcA9h2QXi=9tTUpzSHVx8p+ZxtZYxFNiCQUHOu68W15buCQ@mail.gmail.com>
References: <cover.1746438650.git.qemu_oss@crudebyte.com>
 <4f82ce8cd94f2601fb2b2e4cfe0cf5b44131817e.1746438650.git.qemu_oss@crudebyte.com>
 <CAFEAcA9h2QXi=9tTUpzSHVx8p+ZxtZYxFNiCQUHOu68W15buCQ@mail.gmail.com>
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

On Friday, 3 July 2026 12:52:24 CEST Peter Maydell wrote:
> On Mon, 5 May 2025 at 10:54, Christian Schoenebeck
> 
> <qemu_oss@crudebyte.com> wrote:
> > From: Greg Kurz <groug@kaod.org>
> > 
> > Factor out duplicated code to a single helper. More users to come.
> 
> Hi; Coverity complains about the callsites of this new
> 
> helper (CID 1660923, 1660924, 1660925):

Hi Peter,

I have seen these new CID reports. CID 1660926 (test code only) is a valid one
where I already have a small patch prepared to be sent in the next few days.

However CID 1660923, 1660924, 1660925 are false positives AFAICS:

> > +static int local_fid_fd(int fid_type, V9fsFidOpenState *fs)
> > +{
> > +    if (fid_type == P9_FID_DIR) {
> > +        return dirfd(fs->dir.stream);
> > +    } else {
> > +        return fs->fd;
> > +    }
> > +}
> 
> dirfd() can fail and return -1, so this function is "returns a
> file descriptor, or -1 on error"...

That's the *old* helper function. Apparently you were replying on the wrong PR
series (from 2025!).

CID 1660923, 1660924, 1660925 were triggered by this change
(9p queue 2026-06-29, [PULL 23/23] hw/9pfs/local: harden local_fid_fd() on FID
types) [1]:

[1] https://lore.kernel.org/qemu-devel/75893c058b21d87d1ec66bbd4e8bf84e1fd616d1.1782739719.git.qemu_oss@crudebyte.com/

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 4708e170a4..ee592b62f8 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -775,8 +775,11 @@ static int local_fid_fd(int fid_type, V9fsFidOpenState *fs)
 {
     if (fid_type == P9_FID_DIR) {
         return dirfd(fs->dir.stream);
-    } else {
+    } else if (fid_type == P9_FID_FILE) {
         return fs->fd;
+    } else {
+        errno = EBADF;
+        return -1;
     }
 }

However, that is just a last resort safety net! In 9p.c we are already
checking via fid_has_valid_file_handle(), and in the local fs backend via
local_has_valid_file_handle(), and in both cases would leave via error path. I
have not identified any call path where we would not guard this, so we should
never end up passing -1 as FD to a syscall.

So this new EBADF / -1 path in local_fid_fd() is just to avoid undefined
behaviour as a last resort measure, in case a guard was forgotten in future
changes.

> > +
> > 
> >  static int local_fstat(FsContext *fs_ctx, int fid_type,
> >  
> >                         V9fsFidOpenState *fs, struct stat *stbuf)
> >  
> >  {
> > 
> > -    int err, fd;
> > -
> > -    if (fid_type == P9_FID_DIR) {
> > -        fd = dirfd(fs->dir.stream);
> > -    } else {
> > -        fd = fs->fd;
> > -    }
> > +    int err, fd = local_fid_fd(fid_type, fs);
> > 
> >      err = fstat(fd, stbuf);
> 
> ...but the callsites don't check for error, and instead can
> feed -1 into fstat() or other functions, which isn't a valid
> filedescriptor.

But even then, a syscall receiving -1 for a FD argument would handle this
gracefully by returning -1 and errno EBADF.

/Christian



