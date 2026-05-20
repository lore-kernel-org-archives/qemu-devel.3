Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E76CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlah-0000sO-TT; Wed, 20 May 2026 14:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wPlaX-0000gi-Co
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:24:16 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wPlaT-0001HF-Dg
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:24:13 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-835c98b659eso4571026b3a.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:24:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779301447; cv=none;
 d=google.com; s=arc-20240605;
 b=Zgv8tQ/CzKkR21XpFnoEGe6va0Wd7TnLnMMJIv5bpnx6MgHdI+/3+W8MTUDjoscK1T
 EvSKyoRaf+G0rnUjU2gjL63Nz0ic0eAB5gyx5sqmT+pmTT19P/pciARCoHXP07hE6StJ
 H9Y1fdAIgZPdLUQTXXNF6k0M3FXKe7MZzRtITKa23lYowm+Zg0urAK7HXyyRLWEjIcs5
 dpdykhL8SgKP5f1zvTu3lWZ1R0QPbFyblFSCXdL2vyizqrVOfj72/1xmIj9Gc+8fOTX6
 issj8AzajyFy9Wej2BssGokzokXJUNUxqa99lJpH4gXU7OdIU53sp9/ZaxSpb3ajsvtE
 u4uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qGALzNLJlMs4qbzH6clgU2otML4AF0niaQtSbCxMFEA=;
 fh=55zC4bIfnth6IrZl+xqOWSwSXzYBzli4CDnNHPiVLzY=;
 b=hZtrF5CTsbw7YcGW4r4Wcvl9jC2/q8ncg0DLBJ/PviakxoUkRoSxvmorao6DRoi+VV
 I+dqQmqx9zvEvon+KEZ6u+5UM+Tk7qc87/q1HtZASdymtAUXagh1qchzhR0L7T4fKYFD
 d6gr3LFJNlFKMJtFBBkKC7YBEfHjUADDTCa6g3ap78xVTwEdFsIdEmCq7VA7ZcxoGV2A
 7aRLkRu+HJ1Q6DRgjXcHIONWVs5IDq7ryblyMOeU9AS+DNsV6zdfL9vsZnnrjjPfYddb
 xIV/eZyWsgC6XvnQPe2X4rD77eRgjKjRKINIVCwUXMHrHfHAXG6Z0fzcrwCaBgycdcyT
 RW9Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779301447; x=1779906247; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qGALzNLJlMs4qbzH6clgU2otML4AF0niaQtSbCxMFEA=;
 b=QYUp35o0fUfvsvXmHe40/izlNN/LHIxcnjXAmGYhmHaV8I8bP7fuTSNMy8HZMcUPhg
 x59DqJQucUzJF6QW7VevLT5cSCcc+wtOKfo35P3vKN/q0ZlwqMgFkaUmWTZ25pXQ69Le
 3rTCBCDDPRskYLekS3Ic79jPvzRZfjESnSOapitLQjpHlvktM3XNoo9cGT/Nz/SiqJpZ
 kd96zYK30RRS5AxoDKas1sgg1PvMjmdZYbAPYeSdKoK1FDyk9RQLmPc52QS7QR8euEr9
 33maQZ7rAmtaR4lWvXyKE2JX/GJWo5w8cx6kv7T96kGyqmhQDI8aFTa8W6nzL+wnbC3a
 r9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301447; x=1779906247;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qGALzNLJlMs4qbzH6clgU2otML4AF0niaQtSbCxMFEA=;
 b=MObuBoVA2MeOARO2uN1vWTLeOCwKfPkHFTCRKBzDoskT3N9OAFnAOXldnoLFsOzzh3
 BJAGEhKa0MHWg+F2VxLiFpE4IoPMa5pdRp0pbVQLdEzNhFIjxj+BICNahq20HEW0SKMW
 WGiUUDWdU2bT1db6QR7zL8YklmUrZCUmutdxmXu/CGTA00JKYKR2uE/mH2enw35x5z/t
 flFIGFMsWJrsivp71t5EI3Qvbe9klJIQLq8v633oA2ReHIuX3n78CcpTznkVnKmy4N8C
 A7z5i5s1zXbqHetxaFzKZSPIboplw5jU6gWPFP3TTsnwRK5a4wmFmYl9FOnXaP8TKojm
 tNQw==
X-Forwarded-Encrypted: i=1;
 AFNElJ84JgFSjJ2DPvO5+pgKp2sr+QD/K+PWIhXxJ6+2BzVP2XEXyvKSUAel7rwn/F2CHsh3Ec/MooOW6Wpf@nongnu.org
X-Gm-Message-State: AOJu0YxAe5CjHItmmaqWHlj1EMfSHUbh2naERjbCnx5Ct/BZIvlbm3BY
 2mUBvutmrfA9XHK9jXsdOmYXUdt9iRqYkNqisCfSTvJbuCzw5JEfNY6fxP6SQ4WwdOr7LTvvbLV
 JjyIet8zYkGLymU56q+X0J/N/Ui2Fkn4=
X-Gm-Gg: Acq92OGy4A6uGT3UEBpucmCuF9+oU6NLdnao7Kl1Sn2e1owAb8cYisdMpfpTvVUUjhS
 ekZMDTfvn/JVPgoSDepQC+EH+ey3O4QYbrY/luYFsOESveW14dpYDKZovK0qKoct6HJENCXqnVK
 qEUcglapAHDfqU+20+8AHX96pgn2KT0phivbkrg/bXqzCY0XAR0nCBAo9NDtYDn3aSxuVdFrAeA
 X1ko7xsOZ3TPEV9SCAjp2i12rcF8oT+6LkACiVYM0QV+kbKGSlcHHlDAmpXQ3CkFZvrDMaXQgPT
 hIfNs7I3Now0tN0L4UuD574yjsakeFjwiH3Qiyrzk04HR1MhyVxBvRsXdx2aai3/APDIRBsyHg=
 =
X-Received: by 2002:a05:6a00:398a:b0:82f:3a1e:5618 with SMTP id
 d2e1a72fcca58-83f33d07d33mr25395092b3a.22.1779301446948; Wed, 20 May 2026
 11:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260510175059.311814-1-faithilikerun@gmail.com>
 <20260510175059.311814-3-faithilikerun@gmail.com>
 <20260514194906.GC1535937@fedora>
 <CAAAx-8K+12SGZqzpLGsxjsr6iGAHwQu-TUXe6Z6rtZA27OpjrQ@mail.gmail.com>
 <20260519154911.GB119642@fedora>
 <CAAAx-8Jooodx88LTJvVjHQYKj-SgkCxXkMTi1=ZdR3v3cpUvUg@mail.gmail.com>
 <20260520175905.GA384978@fedora>
In-Reply-To: <20260520175905.GA384978@fedora>
From: Sam Li <faithilikerun@gmail.com>
Date: Wed, 20 May 2026 20:23:41 +0200
X-Gm-Features: AVHnY4KMimpMzcrYFEY2w1xnNCox2TDLpW9okz7nzZhRxYaAL8y516mUb-BhgaI
Message-ID: <CAAAx-8KMLBn1Fb1pMNHwsPsM2FKbJAhFFRFbjhvTvtbZ5FKfpA@mail.gmail.com>
Subject: Re: [PATCH v10 2/4] qcow2: add configurations for zoned format
 extension
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: dlemoal@kernel.org, qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, dmitry.fomichev@wdc.com, 
 Kevin Wolf <kwolf@redhat.com>, cassel@kernel.org,
 Markus Armbruster <armbru@redhat.com>, 
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, hare@suse.de,
 Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=faithilikerun@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, May 20, 2026 at 7:59=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Tue, May 19, 2026 at 11:20:18PM +0200, Sam Li wrote:
> > On Tue, May 19, 2026 at 5:49=E2=80=AFPM Stefan Hajnoczi <stefanha@redha=
t.com> wrote:
> > >
> > > On Mon, May 18, 2026 at 12:21:55AM +0200, Sam Li wrote:
> > > > On Thu, May 14, 2026 at 9:49=E2=80=AFPM Stefan Hajnoczi <stefanha@r=
edhat.com> wrote:
> > > > > On Sun, May 10, 2026 at 07:50:57PM +0200, Sam Li wrote:
> > > > > > +         48 - 55:  zonedmeta_offset
> > > > > > +                   The offset of zoned metadata structure in t=
he contained
> > > > > > +                   image, in bytes.
> > > > >
> > > > > Do you want to say anything about the order in which metadata is
> > > > > persisted to disk when zones used? I guess the data is written in=
to the
> > > > > image file first, then the non-zoned qcow2 L1/L2/refcount metadat=
a is
> > > > > updated, and finally the write pointer is written. Write pointers=
 are
> > > > > not guaranteed to be updated on disk until the write request foll=
owed by
> > > > > a flush request are both completed.
> > > >
> > > > The current ordering is not like that. The write pointer is written
> > > > persistently first, then the data writes and the non-zoned qcow2
> > > > L1/L2/refcount metadata updates. On IO failure, the corresponding
> > > > write pointer is re-read from disk. As noted in the previous commen=
t,
> > > > the wp must be updated when issuing the IO, under the assumption th=
at
> > > > the write IO will succeed.
> > > >
> > > > The ordering has been settled this way since v7 to deal with
> > > > concurrent zone append writes. If the wp was only updated after dat=
a
> > > > I/O, two concurrent appends would both have read the same wp and tr=
ied
> > > > to write to the same position.
> > > >
> > > > >
> > > > > (The idea is that the data must be visible in the qcow2 file befo=
re it
> > > > > is safe to update the write pointer. Otherwise a power failure wo=
uld
> > > > > leave the file in an inconsistent state where the write pointer h=
as
> > > > > advanced but the data was not written.)
> > > >
> > > > The crash-consistency is a concern...
> > >
> > > Yes, I'm thinking about crash-consistency. The ordering you described
> > > can result in qcow2 images where the write pointer is ahead of the
> > > actually written data after a power failure or maybe a QEMU crash.
> > >
> > > QEMU's block layer must follow the same data integrity behavior that
> > > real devices guarantee.
> >
> > I may have found a solution to deal with both cases. The fix is to
> > update wp in memory instead of flushing it before qcow2 metadata and
> > data writes. The zone append write path would become:
> >
> > On submission:
> >
> > 1) wp_lock()
> > 2) Check write alignment
> > 3) wp_update (in memory)
> > 4) wp_unlock()
> > 5) Issue write
> >
> > And on completion:
> > 1) If no error: wp_flush with locks and return success
>
> The data may not be visible in the qcow2 file yet because qcow2's L1/L2/r=
efcount
> cache is not written back to the file until a flush request. I think the
> write pointer updates should have a dependency on the qcow2 metadata so
> that write pointers are only written after qcow2 metadata.

Indeed. The qcow2 cache was also my concern. Since wp should be
persisted after corresponding data is flushed, the cache dependency
would be qcow2 metadata -> data -> wp. Can we set wp's dependency on
the data so that wp is written after data is persisted? I might be
missing something here.

>
> See block/qcow2-cache.c and qcow2_cache_set_dependency(). The idea is
> that one type of cached metadata can set a dependency on another type of
> cached metadata so that ordering is guaranteed.

Thanks, I'll check it out.

>
> > 2) else, wp_lock()
> > 3) read_wp (from disk) and use the read wp value as the current wp
> > 4) wp_unlock()
> > 5) return IO error
> >
> > Sam
> >
> > >
> > > Damien: Do real zoned block devices guarantee that the updated write
> > > pointer is persisted only after appended data has written been
> > > persisted?
> > >
> > > Stefan
> >

