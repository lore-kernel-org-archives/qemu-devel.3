Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86487CA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 16:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFDrN-00039s-RL; Fri, 09 Oct 2026 12:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <namangulati@google.com>)
 id 1xFDrM-00039X-10
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 12:54:16 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <namangulati@google.com>)
 id 1xFDrJ-00006f-QJ
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 12:54:15 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a021c28046so47625e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 09:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791564850; cv=none;
 d=google.com; s=arc-20260327;
 b=YihZvyPfeeJh//74cEq8l5fyl640fl+DA1YOsnjHiNYVyj5fK3jwViPUppkAfQvwpb
 5Gfa+6PUTlRS7DV9v6lESCgm3BLBbEXCArWJ1FPtiHcSVGq+nBQHIVl04vC8jQ+gxW+j
 SmDxsHrrr4gO47VU/G4V3eOYYBAAovebAdQ0P4JLf0ZlLq39xeCEgo6gDpqgfHSKwh25
 zEcoVflfB9kEG0GM3UeOjOhWsN4MssLmzU1bZlmKrivmWREybpxYR8hQHwCcJyBhxT1q
 loJ0UP7Mvi2Ym6MHjJI0FSPrIPRU2jpbyfxZH6+sgXnAkO+Hc1I/kck8jqqahTpiNnyz
 Qteg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9ll7CfR+LouhS3MJXdh3uKfiv12hpi7tqWGIz7Aq1Ng=;
 fh=kIMaH1p4WQKPaRtcLyk8jxVqnyj9ufCg+8lQuf1IepY=;
 b=ebllrrnQiiYl0XLqR89NqdRNZaX871TaWrN27LAzDKVGawU1+xx/H64yAxV7qt0MXl
 JQIYpVmVLvjCZNBy8Qm4uWjFeIoufj8muPg1TAPF910Ofln6nLE+w1YyA192GWJsbtdq
 q4cpvQxdGfttotjaiNyZpq9vkoeQAhYwrDVid+Nt3en4C092F6rUY7KUgb8jYEoV3RMb
 j0Rdz3vL83195rOAuunjtGOyNOlPDK4usKglxWmGLvUx+EeG9S9N0J5NNlZ0vSzYYPSm
 JMLmUDl24LekR/xhiwqRjjFiZbPxmuHGd+fMlhEygWhCZEybkbmzOmEdAe6pv/Jo0TSn
 0VVA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791564850; x=1792169650; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9ll7CfR+LouhS3MJXdh3uKfiv12hpi7tqWGIz7Aq1Ng=;
 b=IMjxE8+qUEC81udJr62UNXsPWK8U5EF47HK7VlcLzq/K4R/gYpxC26Xh9D3H/4YF6R
 pnoUFputsfOLLoVh/aPPrGeJwlB7Mcji0/1Ob4mEdODsFkvPUkNIzzkBL2QWuzOBZ8lz
 qcfN1UMD4dr+T2m/pm8WZUujOlojc090vZIsOBX+lYe791OMINhmD2PINFYGiOuW/Bxb
 xRVegIbePiDTO3yXN5aT2EoAqqKIkTrkk2ou5HPnfrWKLZcLaa6Gki1MjX50AGFUOLEu
 L8kWj4ihxmiGYrQCHVg6CtGJQ0tqw6ejtlsJ/Ovm43PCCnIU3KZad7VcgN6/2Bg8JzOA
 bkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791564850; x=1792169650;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9ll7CfR+LouhS3MJXdh3uKfiv12hpi7tqWGIz7Aq1Ng=;
 b=D1nKYAMGIfleIK8FMs7Xvh6iClmkUF0tg7lPw4RSmrFV+NGdHyMjNX9MKO5ScoEeWq
 Vk3c9gXhvhnlrvzlWOaopI+7SaL2detR6HtQjqKR5iDrwfCIzNdjKx8o8PVCzUM1AEPH
 uRewZmpYoNlTLiLdS7tFjIsYbbwbVPxC7UAAF83+c5/1y68s5xugZaXxVnLNyINXXDdx
 R0PKWP59udBMs2DCKQsl/CSB5S99TXbmFZRpi9EejaokK0IpQCZW283sAVsS34opk3Xu
 2omQYd2TGA3Szk3NvrstNnj+RCOFPcMJ2Ej2Fan0TcOjUYCjhs9uLUtWEGCwU9+cB6IO
 5Uiw==
X-Gm-Message-State: AFuF++nIDxye8eMb7PLEPCiVALOrouSjB9Pfw8geRAaGynWI3y2Uf3hr
 VE/BAzHN+pANYL5rmP0ysMx2B2m4ecX7+u7b3RUUJBC+OdKc8Tg+jqr5hETkQljV+2UaU8bNfrC
 bAfmDzjNbqyVc0lOcR3qIWbIfNyWc+rpN76Nx06gh
X-Gm-Gg: AYBFou3vGofsf/sa8z4sVuLpLHSOVs3/cKkZS92HurMXMBfSJlL3cWs+ppCfu4IgNMQ
 p7vgiz04cs3dB3x8S/NxT50/4MfTnO9gamAJzsZL5GvePaUt6ZuzNdJNp/0KBZe6qGdottr0eP7
 d7subKXW7VUxn6x67fpVHmvlFNsIzJuOULa2mjjxyQqoBrLhjRT88mSVH7Jn4rP8Yj7uTIBnwfe
 S0KUGn2elrZXT+WbNDDLf5qE5V2kFZxjmwRGdaYqcA8M+RRAkV/HCA2AqIbgm8A74MM43RC41aK
 TbZqEeBlofFqxvRlTgA/z7C54h4dMjRIULVdEbnB1su28OXC8h/2DLzh
X-Received: by 2002:a05:600c:c047:b0:4a1:63f1:937e with SMTP id
 5b1f17b1804b1-4a18df547e0mr471195e9.11.1791564849990; Fri, 09 Oct 2026
 09:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20261007000833.2445641-1-namangulati@google.com>
 <20261007000833.2445641-2-namangulati@google.com>
 <IA0PR02MB9462517F10C4C9915364ADB98B922@IA0PR02MB9462.namprd02.prod.outlook.com>
In-Reply-To: <IA0PR02MB9462517F10C4C9915364ADB98B922@IA0PR02MB9462.namprd02.prod.outlook.com>
From: Naman Gulati <namangulati@google.com>
Date: Fri, 9 Oct 2026 09:53:57 -0700
X-Gm-Features: AclHuK_pZtbDHFfRSYil-2VPFaHOGI7O3_oIr1FdSKZJPbbWLxfjZei_mNNaH7E
Message-ID: <CAMP57yUa93O1mUprFJnzoNfpd2L3mOYmbgAc2wcZ4mcpOyy+cQ@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND 1/4] vfio-user: add multi-fd region mmap
 capability
To: Thanos Makatos <thanos.makatos@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 John Levon <john.levon@nutanix.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Matt Evans <matt@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=namangulati@google.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5, USER_IN_DEF_SPF_WL=-7.5,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 8, 2026 at 11:06=E2=80=AFPM Thanos Makatos
<thanos.makatos@nutanix.com> wrote:
>
> > -----Original Message-----
> > From: Naman Gulati <namangulati@google.com>
> > Sent: 07 October 2026 01:09
> > To: qemu-devel@nongnu.org
> > Cc: John Levon <john.levon@nutanix.com>; Thanos Makatos
> > <thanos.makatos@nutanix.com>; C=C3=A9dric Le Goater <clg@redhat.com>; A=
lex
> > Williamson <alex@shazbot.org>; Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com>; Matt Evans <matt@ozlabs.org>;
> > Naman Gulati <namangulati@google.com>
> > Subject: [PATCH v3 RESEND 1/4] vfio-user: add multi-fd region mmap
> > capability
> >
> > !-------------------------------------------------------------------|
> >   CAUTION: External Email
> >
> > |-------------------------------------------------------------------!
> >
> > Extend the vfio-user protocol specification to allow servers to pass
> > multiple file descriptors for different sparse memory areas within a
> > single device region with capability
> > VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS.
> >
> > VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS defines an array of sparse mmap
> > areas where each area contains:
> > - offset: Start of the area within the device region (BAR).
> > - fd_offset: Start of the mapping within the backing file descriptor.
> > - size: Size of the mappable area.
> > - fd_index: Zero-based index into the array of file descriptors
> >   received in the SCM_RIGHTS ancillary data of the
> >   VFIO_USER_DEVICE_GET_REGION_INFO reply message.
>
> Don't we need a new capability in VFIO_USER_VERSION so that the server kn=
ows whether the client supports VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS before=
 even sending it?

Thanks for the review. Good catch, missed adding this. Will add a
capability in the documentation, and update the code to advertise it
in v4.

>
> >
> > Signed-off-by: Naman Gulati <namangulati@google.com>
> > ---
> >  docs/interop/vfio-user.rst | 71 +++++++++++++++++++++++++++++++++++--
> > -
> >  1 file changed, 67 insertions(+), 4 deletions(-)
> >
> > diff --git a/docs/interop/vfio-user.rst b/docs/interop/vfio-user.rst
> > index 1c92f442d2..5744f58e31 100644
> > --- a/docs/interop/vfio-user.rst
> > +++ b/docs/interop/vfio-user.rst
> > @@ -125,7 +125,10 @@ Sparse Regions
> >  A region can be memory-mappable in whole or in part. When only a
> > subset of a
> >  region can be mapped by the client, a
> > ``VFIO_REGION_INFO_CAP_SPARSE_MMAP``
> >  capability is included in the region info reply. This capability
> > describes
> > -which portions can be mapped by the client.
> > +which portions can be mapped by the client. When sparse mmap areas
> > are backed
> > +by multiple distinct file descriptors, a
> > +``VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS`` capability is included in
> > the region
> > +info reply instead.
>
> It's probably obvious but I don't see any harm in clearly stating that bo=
th VFIO_REGION_INFO_CAP_SPARSE_MMAP and VFIO_REGION_INFO_CAP_SPARSE_MMAP_FD=
S cannot be specified for the same region, and that some regions can use VF=
IO_REGION_INFO_CAP_SPARSE_MMAP while others VFIO_REGION_INFO_CAP_SPARSE_MMA=
P_FDS.

Makes sense, will add that clarification, and also add a check in the
code to return an error when the user specifies
VFIO_REGION_INFO_CAP_SPARSE_MMAP and
VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS for the same region.

>
> >
> >  .. Note::
> >     For example, in a virtual NVMe controller, sparse regions can be
> > used so
> > @@ -859,9 +862,9 @@ Reply
> >    * ``VFIO_REGION_INFO_FLAG_READ`` allows client read access to the
> > region.
> >    * ``VFIO_REGION_INFO_FLAG_WRITE`` allows client write access to the
> > region.
> >    * ``VFIO_REGION_INFO_FLAG_MMAP`` specifies the client can mmap()
> > the region.
> > -    When this flag is set, the reply will include a file descriptor
> > in its
> > -    meta-data. On ``AF_UNIX`` sockets, the file descriptors will be
> > passed as
> > -    ``SCM_RIGHTS`` type ancillary data.
> > +    When this flag is set, the reply will include one or more file
> > descriptors
> > +    in its meta-data. On ``AF_UNIX`` sockets, the file descriptors
> > will be passed
> > +    as ``SCM_RIGHTS`` type ancillary data.
>
> Sending more FDs than sub-regions shouldn't be permitted, right? If so, c=
an we clarify this?

Will do.

>
> >    * ``VFIO_REGION_INFO_FLAG_CAPS`` indicates additional capabilities
> > found in the
> >      reply.
> >
> > @@ -950,6 +953,66 @@ The VFIO sparse mmap area is defined in
> > ``<linux/vfio.h>`` (``struct
> >  vfio_region_info_cap_sparse_mmap``).
> >
> >
> > +VFIO sparse mmap fds cap header
> > +"""""""""""""""""""""""""""""""
> > +
> > ++----------------------+--------------------------------------+
> > +| Name                 | Value                                |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > +| id                   | VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS |
> > ++----------------------+--------------------------------------+
> > +| version              | 0x1                                  |
> > ++----------------------+--------------------------------------+
> > +| next                 | <next>                               |
> > ++----------------------+--------------------------------------+
> > +| sparse mmap fds info | VFIO region info sparse mmap fds     |
> > ++----------------------+--------------------------------------+
> > +
> > +This capability is defined when a region supports direct access by
> > the client
> > +via mmap() where different sparse mmap areas are backed by distinct
> > file
> > +descriptors in the ``SCM_RIGHTS`` ancillary data array. Capability ID
> > +``VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS`` is defined as 16 (0x10) to
> > avoid
>
> I'm not sure 0x10 will avoid clashes in the future, current highest VFIO =
capability is 5 (VFIO_REGION_INFO_CAP_NVLINK2_LNKSP) so we might clash soon=
er than we think. Using a much higher value (e.g. 0x1000) could be a bit be=
tter. Ideally, we should have some agreement with the VFIO maintainers abou=
t this, how about reserving the highest bit for VFIO "extensions"?

Sounds good, I can add this capability at 0x8000. If needed I can send
a follow-up patch adding some documentation in
include/uapi/linux/vfio.h specifying that capability IDs >=3D 0x8000 are
reserved for "userspace VFIO extensions".

>
> > +clashing with kernel VFIO capabilities.
> > +
> > +VFIO region info cap sparse mmap fds
> > +""""""""""""""""""""""""""""""""""""
> > +
> > ++-----------+--------+------+
> > +| Name      | Offset | Size |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D+
> > +| nr_areas  | 0      | 4    |
> > ++-----------+--------+------+
> > +| reserved  | 4      | 4    |
> > ++-----------+--------+------+
> > +| offset    | 8      | 8    |
> > ++-----------+--------+------+
> > +| fd_offset | 16     | 8    |
> > ++-----------+--------+------+
> > +| size      | 24     | 8    |
> > ++-----------+--------+------+
> > +| fd_index  | 32     | 4    |
> > ++-----------+--------+------+
> > +| pad       | 36     | 4    |
> > ++-----------+--------+------+
> > +| ...       |        |      |
> > ++-----------+--------+------+
> > +
> > +* *nr_areas* is the number of sparse mmap areas in the region.
> > +* *offset*, *fd_offset*, *size*, and *fd_index* describe a single
> > area that can be
>
> Could you clarify that zero-sized regions are not permitted?
>
> Also, I think it's obvious but best to clarify anyway offset + size canno=
t exceed the region size.

Will do.

>
> > +  mapped by the client. There will be *nr_areas* tuples of offset,
> > fd_offset, size,
> > +  fd_index, and pad.
> > +* *offset* specifies the start of the area within the device region
> > (BAR).
> > +* *fd_offset* specifies the start of the mapping within the backing
> > file descriptor
> > +  referenced by *fd_index*.
> > +* *fd_index* is the zero-based index into the array of file
> > descriptors
> > +  received in the ``SCM_RIGHTS`` ancillary data of the
> > +  ``VFIO_USER_DEVICE_GET_REGION_INFO`` reply message.
> > +
> > +If all sparse mmap areas are backed by a single file descriptor, the
> > server
> > +may instead send ``VFIO_REGION_INFO_CAP_SPARSE_MMAP`` and exactly one
> > file
> > +descriptor in ``SCM_RIGHTS`` for compatibility with older clients.
> > +
>
> Can such areas overlap? For VFIO_REGION_INFO_CAP_SPARSE_MMAP, I don't see=
 how it could be useful but AFAIK it can't break anything, but when multipl=
e FDs are involved it's not as clear.

I don't see a reason why these regions would need to overlap and the
code already returns an error when the user specifies overlapping
regions. Will add some text enforcing that these regions do not
overlap.

>
> > +
> >  ``VFIO_USER_DEVICE_GET_REGION_IO_FDS``
> >  --------------------------------------
> >
> > --
> > 2.56.0.rc1.315.gc6ed9934b7-goog
>

