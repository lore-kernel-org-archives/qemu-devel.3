Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7958C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfcui-0005Wp-24; Fri, 03 Jul 2026 08:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfcuM-0005QE-HJ
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 08:22:14 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfcuI-0004sm-Nu
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 08:22:12 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-664d530fcfdso630136d50.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 05:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783081302; cv=none;
 d=google.com; s=arc-20260327;
 b=sIXPZP7JUDCa/39crr+YVH09uc66+5z49WLbTGUB3Rn6yXOSO78rXEJmonMY2E/iVZ
 dABK0DLsBioGpl4FZ4BuzCj1+QunDuHgqNdXH78vfe9VXp71aWDMEOjal3jkF8Aqg9m6
 c/46EYJajl3rXNqtBJkCVptYjOVtqPOta698wHax/c6OlG3gGM9F+daMvnp0mtcbjP2C
 r8onuvGr/3DKeOd7K/+lG+B2qS8cgZyUHShbTqQSWciSU7hWRJMxvlNZKCGlwoRU9HQ3
 9PntouYGsIPwpqPZ3OzfcMmCH0/jTF1ZWWkOhQWmye4jUNijhM19sU8zKRqOthOmDPzv
 5z3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7PWxpkcxOXGD/d2RFOvueuaVHJ+pc1LEH5S3TbxZAMg=;
 fh=7R/RZGD+m7OAV6ynsYAfWZ1IG1hYR0cKwZ0GYuuX0rE=;
 b=MixmNTUxB/X1IWR2J4Vwv64wibG70b3SO35QpFIS8j3OGMx8y/cI6FB8H++Lgy1MJ5
 /gjGsVVewPXyeBDA6YNqFPeVAJJSXmAgumCRANYxD5upetq+lVJpLSbURFXifBZTK/5X
 ZkveS+CpW2BjeKHGl4y3FQoTETpig+SSakBPvHCPXnsKNHWgWMiFBKCyq/hXEORKq1Qn
 dNA7Z7eg8DvIsgnPJPo8qubms0WcDUJ0HKVpjWc9xSC0ptn99J2r9I7gey4le1fg03Nm
 z0M9l+DvUN/JLZRNlRWHYOH/AbuQ2Qpa4pxHYOMoccf7gRAFIICYjYJpsfeMjEgtueaY
 9wlw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783081302; x=1783686102; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7PWxpkcxOXGD/d2RFOvueuaVHJ+pc1LEH5S3TbxZAMg=;
 b=pstOgJxuPX/07EJNXjwDLsR5X4RUf6SNLxziM/R4WAy8spV6feXjQD1G6DisCc2S3Q
 uwrWTumugvBpHHI0+J8iW6OuVZNvTkdBEafzLZFduGtZQAMsN/OQYQlQDRW6Znogzwys
 FzKmZ1HGaA48YLxcY71xa+2fdXLxfUQ+0IVqCak0LAnow9mvKprT9DCap7VSUCw83jHH
 SVt/THYryBKjHP40//b42Ahqh9aiX0vnDhXBeupneSsfZoek8EqFrzZlKxtx4qZFmNNz
 Q5XJ5EXhWt5wQgszmcqmEeOvmo8+o909YxmvBXIkHWox1gGe0jh07U/tsMsNn9SpAf2N
 noSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783081302; x=1783686102;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7PWxpkcxOXGD/d2RFOvueuaVHJ+pc1LEH5S3TbxZAMg=;
 b=rekuz71lIxmvfTajmcuaXLuJJSa0nJOorY9+qP5HHKu57YjsCcRutNTyGojZvZjYj/
 VFEm6N7+Z9v9AEP9aBOLRLgC7/vOX7Ak1XQPs4lcOvXRQ1QmTRQJSor235v8ox8R2dok
 42+IFzfkfH0Nqi6dIxAPzkdFHGieE3zMjbOTeBGOqF0SKBMfueGsHKhSfqSE2DcBHXL+
 xuYbFQjCmPlWfj4s43CebVyxgMr6f0DCSqYDhkNQ+L8MjoLtRsYjd6PgguWag4Rm62Hp
 t1Z320DFczanil4HyStzBTYrsgzynH3RUT3enV/AkmrCY73FJ3jXScc1lqJ4E1DAoW4l
 s2yw==
X-Gm-Message-State: AOJu0YzwznZV1eNefWdICFAUWbtKiTBwSe49fZKBaZd3kApa12h/cTIs
 JxlX97Alyuo+vrpZqGaD9FNmr7l6hKTSVXtmnL3vZrBrTRXiwWOrV5kQ5zlyCLVv3kV7MlrzY7g
 /cjb/yh5fhI7XVW6hA1MrBLGFF6IB54VooBTCyAxciw==
X-Gm-Gg: AfdE7cn2zzp6X8egO8NEEwAtorR6DGdxPtNy+knYj8JPUQYY7sFa+5JutpcvgYxdFAa
 4E8t9Y6sIrDI28ZTorkorUB9wAJSAJWEmjiB/7Re02iELyBy0BAJBvFqsQaw3npkOTFDVqhIbXB
 02Aslbwnt44/6pITwEmPOaevT9yvRg1QddNTna7Wzv8yDG3dw7EKF5FHOKtVnEggTZeQkAQMh9S
 cSo9vBvYyyvUf0hnke27PkzQ1UVXQjc5UYelr7KWkZ3PgIFZOI8eeQHaLFe12cf7iu2XoADIMId
 iKuWgpQwX3oMB3PLofJzQfdoncRgwfUO1b706XFbTg+aitpGpP9vyo3T
X-Received: by 2002:a05:690e:4508:20b0:664:ae6a:e9ae with SMTP id
 956f58d0204a3-66521dbe996mr6986881d50.84.1783081301964; Fri, 03 Jul 2026
 05:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1746438650.git.qemu_oss@crudebyte.com>
 <4f82ce8cd94f2601fb2b2e4cfe0cf5b44131817e.1746438650.git.qemu_oss@crudebyte.com>
 <CAFEAcA9h2QXi=9tTUpzSHVx8p+ZxtZYxFNiCQUHOu68W15buCQ@mail.gmail.com>
 <23160010.EfDdHjke4D@weasel>
In-Reply-To: <23160010.EfDdHjke4D@weasel>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 13:21:29 +0100
X-Gm-Features: AVVi8Cdu2W_scMPRdRu8X_fzejlBn0cKYI91IfGOjD3nb4MBvnOetIBE0G1T8IU
Message-ID: <CAFEAcA-qtuM51VCzAr+VgsTVkEg1+CsgUNQofVZ0B_zzfodsxA@mail.gmail.com>
Subject: Re: [PULL 3/9] 9pfs: local : Introduce local_fid_fd() helper
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Fri, 3 Jul 2026 at 12:41, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> On Friday, 3 July 2026 12:52:24 CEST Peter Maydell wrote:
> > On Mon, 5 May 2025 at 10:54, Christian Schoenebeck
> >
> > <qemu_oss@crudebyte.com> wrote:
> > > From: Greg Kurz <groug@kaod.org>
> > >
> > > Factor out duplicated code to a single helper. More users to come.
> >
> > Hi; Coverity complains about the callsites of this new
> >
> > helper (CID 1660923, 1660924, 1660925):
>
> Hi Peter,
>
> I have seen these new CID reports. CID 1660926 (test code only) is a valid one
> where I already have a small patch prepared to be sent in the next few days.
>
> However CID 1660923, 1660924, 1660925 are false positives AFAICS:
>
> > > +static int local_fid_fd(int fid_type, V9fsFidOpenState *fs)
> > > +{
> > > +    if (fid_type == P9_FID_DIR) {
> > > +        return dirfd(fs->dir.stream);
> > > +    } else {
> > > +        return fs->fd;
> > > +    }
> > > +}
> >
> > dirfd() can fail and return -1, so this function is "returns a
> > file descriptor, or -1 on error"...
>
> That's the *old* helper function. Apparently you were replying on the wrong PR
> series (from 2025!).

Oops, yes. I usually try to find a place to reply by searching
the mailing list, and I picked the wrong result by mistake here :-)

> CID 1660923, 1660924, 1660925 were triggered by this change
> (9p queue 2026-06-29, [PULL 23/23] hw/9pfs/local: harden local_fid_fd() on FID
> types) [1]:
>
> [1] https://lore.kernel.org/qemu-devel/75893c058b21d87d1ec66bbd4e8bf84e1fd616d1.1782739719.git.qemu_oss@crudebyte.com/
>
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 4708e170a4..ee592b62f8 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -775,8 +775,11 @@ static int local_fid_fd(int fid_type, V9fsFidOpenState *fs)
>  {
>      if (fid_type == P9_FID_DIR) {
>          return dirfd(fs->dir.stream);
> -    } else {
> +    } else if (fid_type == P9_FID_FILE) {
>          return fs->fd;
> +    } else {
> +        errno = EBADF;
> +        return -1;
>      }
>  }
>
> However, that is just a last resort safety net! In 9p.c we are already
> checking via fid_has_valid_file_handle(), and in the local fs backend via
> local_has_valid_file_handle(), and in both cases would leave via error path. I
> have not identified any call path where we would not guard this, so we should
> never end up passing -1 as FD to a syscall.
>
> So this new EBADF / -1 path in local_fid_fd() is just to avoid undefined
> behaviour as a last resort measure, in case a guard was forgotten in future
> changes.

That part is fine. What Coverity is warning about is the callsites:

> > > +
> > >
> > >  static int local_fstat(FsContext *fs_ctx, int fid_type,
> > >
> > >                         V9fsFidOpenState *fs, struct stat *stbuf)
> > >
> > >  {
> > >
> > > -    int err, fd;
> > > -
> > > -    if (fid_type == P9_FID_DIR) {
> > > -        fd = dirfd(fs->dir.stream);
> > > -    } else {
> > > -        fd = fs->fd;
> > > -    }
> > > +    int err, fd = local_fid_fd(fid_type, fs);
> > >
> > >      err = fstat(fd, stbuf);
> >
> > ...but the callsites don't check for error, and instead can
> > feed -1 into fstat() or other functions, which isn't a valid
> > filedescriptor.
>
> But even then, a syscall receiving -1 for a FD argument would handle this
> gracefully by returning -1 and errno EBADF.

In practice, yes, but it's not a valid file descriptor. Coverity
warns about it because it tends to mean "missing error handling",
as here.

thanks
-- PMM

