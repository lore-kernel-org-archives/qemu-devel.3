Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4658EC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfdKc-0002ft-WE; Fri, 03 Jul 2026 08:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wfdKR-0002dJ-TH
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 08:49:12 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wfdKQ-0006Wh-9i
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 08:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=7k02wn9H5OxlusR4rmESg5JXg7Dy0kQTJkZfM1tpxuE=; b=BuIJnZcee1wfsdFCgEaODR9Ggh
 9JzAYCIp/HV8249icbXM9wj19Z8yGjSAaqXz/Rju3CNA7js8ZGz19SkiwNSeOHw57knPfa1881T7B
 XCOfeWsIj1j+8gUV75yyeqrYJD/yrp6DCfhACs2lKiDWSdgEO42DgSjcY2PbqZpBo3sjSO9/2dvLp
 2Ldq7wavKg3k/bpswDrNIesFSq2LsTsgdc2oT1oFA/jgexT2j2PRXHSzpVs49irNLhNi0HkXPLXE1
 5LziO8S3fyce6UVoiIlXUKRnCqPWEWxYV3+ifOhlLL0r1V3oIp/gqP7NQ/y0OXQQzloP03ozdsvRS
 il3omHlkeJ04v97wSMx+mpW0q5wu4gapEAufIH3aISM4LraKUYaV15P9o28ZKuMk3oP+eunGC8T0F
 F9lv048nHra5MlBk9bJoxJVF3f8+1Ojw6oUcCyGK7zD+t63uACrCFsiNjYaJwa1dSHmtPQG/v2e6N
 4xBkQg2DvEtePSrqlK985x0mBa8TVfi6vqWiX/D+kDWka1LMi49cyC7iG2DqAvrFHdpZ0QWsJYtEh
 eDrYETYYOjtBbzNkN/OzmZ3iKg5I+Fh7HpLaim4zevR3FVPBFO0rdzkthe7tdxKIhYE+NIC8K4svQ
 izvfwn/Nl0p1r+cSxtRhLOw9Jx9O8uDBX/ATpVbYA=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 3/9] 9pfs: local : Introduce local_fid_fd() helper
Date: Fri, 03 Jul 2026 14:49:07 +0200
Message-ID: <1964729.CQOukoFCf9@weasel>
In-Reply-To: <CAFEAcA-qtuM51VCzAr+VgsTVkEg1+CsgUNQofVZ0B_zzfodsxA@mail.gmail.com>
References: <cover.1746438650.git.qemu_oss@crudebyte.com>
 <23160010.EfDdHjke4D@weasel>
 <CAFEAcA-qtuM51VCzAr+VgsTVkEg1+CsgUNQofVZ0B_zzfodsxA@mail.gmail.com>
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

On Friday, 3 July 2026 14:21:29 CEST Peter Maydell wrote:
> On Fri, 3 Jul 2026 at 12:41, Christian Schoenebeck
> 
> <qemu_oss@crudebyte.com> wrote:
> > On Friday, 3 July 2026 12:52:24 CEST Peter Maydell wrote:
[...]
> > diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> > index 4708e170a4..ee592b62f8 100644
> > --- a/hw/9pfs/9p-local.c
> > +++ b/hw/9pfs/9p-local.c
> > @@ -775,8 +775,11 @@ static int local_fid_fd(int fid_type,
> > V9fsFidOpenState *fs)> 
> >  {
> >  
> >      if (fid_type == P9_FID_DIR) {
> >      
> >          return dirfd(fs->dir.stream);
> > 
> > -    } else {
> > +    } else if (fid_type == P9_FID_FILE) {
> > 
> >          return fs->fd;
> > 
> > +    } else {
> > +        errno = EBADF;
> > +        return -1;
> > 
> >      }
> >  
> >  }
> > 
> > However, that is just a last resort safety net! In 9p.c we are already
> > checking via fid_has_valid_file_handle(), and in the local fs backend via
> > local_has_valid_file_handle(), and in both cases would leave via error
> > path. I have not identified any call path where we would not guard this,
> > so we should never end up passing -1 as FD to a syscall.
> > 
> > So this new EBADF / -1 path in local_fid_fd() is just to avoid undefined
> > behaviour as a last resort measure, in case a guard was forgotten in
> > future
> > changes.
> 
> That part is fine. What Coverity is warning about is the callsites:

I know, this is just the change that triggered Coverity's warning, because it 
made Coverity think that this function might return -1, even though this 
branch is actually *never* executed.

> > > > +
> > > > 
> > > >  static int local_fstat(FsContext *fs_ctx, int fid_type,
> > > >  
> > > >                         V9fsFidOpenState *fs, struct stat *stbuf)
> > > >  
> > > >  {
> > > > 
> > > > -    int err, fd;
> > > > -
> > > > -    if (fid_type == P9_FID_DIR) {
> > > > -        fd = dirfd(fs->dir.stream);
> > > > -    } else {
> > > > -        fd = fs->fd;
> > > > -    }
> > > > +    int err, fd = local_fid_fd(fid_type, fs);
> > > > 
> > > >      err = fstat(fd, stbuf);
> > > 
> > > ...but the callsites don't check for error, and instead can
> > > feed -1 into fstat() or other functions, which isn't a valid
> > > filedescriptor.
> > 
> > But even then, a syscall receiving -1 for a FD argument would handle this
> > gracefully by returning -1 and errno EBADF.
> 
> In practice, yes, but it's not a valid file descriptor. Coverity
> warns about it because it tends to mean "missing error handling",
> as here.

Yes, -1 is defined by POSIX as "invalid file descriptor". And that's the point 
why the helper function would return it as last-resort result, because -1 is 
well defined by POSIX to not be interchanged with a real file descriptor.

To make this clear: before this change, this helper could potentially return 
garbage.

And yes, you can check for every -1 file descriptor just before passing it to 
a syscall, even though I already explained that a) you never ever get there 
because this check is already made at the higher level call stack, and b) that 
every syscall handles -1 as file descriptor gracefully.

If you still think this was not a false positive, you are welcome to send a 
patch.

Thank you!

/Christian





