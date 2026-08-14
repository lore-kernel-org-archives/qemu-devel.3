Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41F6C5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 19:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuxtl-0005Jw-Uh; Fri, 14 Aug 2026 15:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <namangulati@google.com>)
 id 1wuxtc-0005Jc-9G
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 15:48:52 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <namangulati@google.com>)
 id 1wuxtZ-0002Z1-Vz
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 15:48:51 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-51c01c79467so407891cf.0
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 12:48:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786736925; cv=none;
 d=google.com; s=arc-20260327;
 b=kqB5GtXyN8ehDXGZoJ53EdMpMXZa3/NDLPCJIip9b3A2Rd4DK9Cu2tRWprDIL6zjEX
 lxBwFm2RVqmwStz09hxX0Le+DNvg2Ve4DxqJdfCiTrAArwXnHoRKsAPobSy7tHxLQOYZ
 4qfwIxpOoVu5VWoyDGgmdzJSX/QV27DA4FdYgZyfCwvel9bZRjlPCn9wYotF0590x856
 tSDxgld6RTbZO3IemSSLVgCa+50qr2rOjncxNnP1CYSVotsiWwmmIsxX2TWHr7uY57CV
 tzvbo3mNljGfxPufnScypxCmaMTOCAJOrxz+ec97yvd/w7Gf53oaoqbXbvYz+3gl6k6K
 0AqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=I2lqsO5oKjCZ7s5kCbZWjaP+PxzkZebv+r03ncmo7GY=;
 fh=YS4A6F1b1ot+kZu5BBsPfS1SwdI68YoyhJjtHsaJcMw=;
 b=PIi/bjyNhYEEg6KNJdlevOEODCdprIp18yWAjRudCZ9xzUYtjhmiEE6IEO7PsGrsiS
 rzWheSzFk8gBFU6SdyKtcp+FXTjkAQw4AE3L8mH3+4uqkr/8KlQa7/19eGA+w5GJeB5H
 WIwa3NgPLlfCNaXbtf3OaUAfNUeS8s6imRGzwavdQvZzf+JGbpweACCiOR/nEoiP56S8
 WWtaiquJJ+M9oW6qX/j8wboC4nNT2WX7QLOttALNlM8G+CqNsbBVXosj8HGQAQZ3R87C
 Sezdy6eq9BCvQwDeYJd7rnwL+lzGWvDtKBUN3ngTROyUQBeZKX6rhlB9qQosf2MiOoW+
 4+tA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786736925; x=1787341725; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I2lqsO5oKjCZ7s5kCbZWjaP+PxzkZebv+r03ncmo7GY=;
 b=pDdTQOrfFb9JJ6fbI/X1uyeky+mJKZtvsJGYy7GhtJT2bQ2QnowYU2RfRxs4HtujJZ
 /8/wbd7YnPzrCGG1PFLdzYB9I0Soe2gPV5RtAcS/o0joU+hpKcmG0TdF4SPhkz+G3fPd
 lPqme9kW6F0afaY7B0lo8O/Vd7OW34kOt5SUfMVoYf0AuUucoUbmhi8vzEJ2+42ubx7n
 56Wry3vzbvqtq9cJ8m0ery2PYVpiFqGDQNTpf3pA734ZbfWwkOyEdZXTgUqprDhc/owv
 u4nCTv8DUXFTEtQy45v98NIMWiQWgtpi9AAawd4YbY/rqRcLG4oT/xT47aAZS5qcfo8l
 jhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786736925; x=1787341725;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I2lqsO5oKjCZ7s5kCbZWjaP+PxzkZebv+r03ncmo7GY=;
 b=ceeDzcgoW0+BLn36IevsPy83qtxbbU0yOyf+p0j26rbEjcCJrKgiuMxjQA9jb1HmEh
 takGBTb12Anx9YRNVDiCJb4GS9oLX5eCDei+rE/P7AcOKZ6UV3hsUorCjUVIuKecsfCt
 HW5LwD4D50DZToGXLdK6I5pszmRvJR5QxLifxRkSJ8gfKCcFVGCMP92JHFihJZCmZJUi
 INWPYrKXwEiKyUSdIztXaOEwhRZ4ZHVzyo91sHO/y6iG1481ffoindL5FeNPd2NEv4AA
 kEAElBdgkfS3nRq8zp8vuxS6E4rpMtFK48hFaBCYtr0fuYItTlgFhfmeVVeLGGnBUXzw
 wi+w==
X-Gm-Message-State: AOJu0Yzy25eL/dLVPQP2WjPkmxx9KMEJWc7UfVpEViD1ewArJJACds6I
 hfo2WpEXwhujAq05TZq8nrDIqOMNEMpSS2jiuhA6YRc6hAq3AM5ywihvjQVCy67EaUcOaJFRvtM
 9IIz54RNx6UAz+/0jlKHiHVBj/gnA8NDcPl65AMRy
X-Gm-Gg: AR+sD12FVq/3RD+87aUNusuePQw/mAJHkht2TZtyML3gfI8bdaPA1Q9aiUlgePxvmfP
 DdSMSczvqAKOd5mT3WNgyNqI3clIpy3cD6ldUktZXun9jN16kPZUdvkL6/PWj4EPHWAD5hnsw6J
 tSQtfiWyGpvJrKrE5DARyUlZRwkrqD6D+sS5mhlyOD4JaCipM/Hu0cNi5IWe8KEpJj/qWgLXeP4
 LbmF979gu3anWz+K2VZrCB9WQi098iObC8Cb2GdMjFvPqLsS7PFkPeP88UDJIJMTqrvaNaUc4uM
 VIzF7zNVUrPXW0vPlejckDSTKNYfQZ08yrgBOeDQXPrl6D8dBTgKtn4HqMcxvvTPTWRX0v0ATe+
 big==
X-Received: by 2002:a05:622a:310:b0:51b:ff0a:2048 with SMTP id
 d75a77b69052e-52d862b772fmr21319271cf.3.1786736924179; Fri, 14 Aug 2026
 12:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260811233930.401797-1-namangulati@google.com>
 <20260811233930.401797-3-namangulati@google.com> <an7XMMoApuo3ye1d@lent>
In-Reply-To: <an7XMMoApuo3ye1d@lent>
From: Naman Gulati <namangulati@google.com>
Date: Fri, 14 Aug 2026 12:48:30 -0700
X-Gm-Features: AcwNN1WeXLDx2-tdxg4Eo2n-jwvw3nghqkc7bggMuoA8S_HjVxiJpDNZHr2KE44
Message-ID: <CAMP57yU0_0YbnuAGt7iAv4p3qW9cX=1TkpsesAVTs06Y9ZJtbQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] vfio: mmap sparse regions backed by multiple FDs
To: John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Matt Evans <matt@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=namangulati@google.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Fri, Aug 14, 2026 at 1:52=E2=80=AFAM John Levon <john.levon@nutanix.com>=
 wrote:
>
> On Tue, Aug 11, 2026 at 11:39:29PM +0000, Naman Gulati wrote:
>
> > Generalize QEMU's VFIO core layer to support mapping sparse memory
> > subregions from distinct file descriptors within a single device
> > region.
> >
> > Replace list of region_fds in VFIODevice with a collection of struct
> > VFIORegionFDs that internally holds a collection of FDs to mmap per
> > region.
>
> This is getting a bit non-obvious to me, we now have a region_fds array w=
here
> each member is also an array.
>
> Given that you've introduced a dependency on VFIORegion in the
> include/hw/vfio/vfio-device.h for the other callback, I'm wondering why w=
e don't
> just store an array of VFIORegions in VFIODevice instead of reginfo+regio=
n_fds ?

I tried to maintain the idiom that the VFIORegion region is synonymous
with one single BAR region. As before each VFIORegion has multiple
mmap areas underneath, the fd for each is now held in the region_fds
list.

>
> And I'm wondering if we really have to have two separate callbacks for ge=
tting
> region info.
>
>
> > @@ -184,6 +184,12 @@ static int vfio_user_device_io_get_region_info(VFI=
ODevice *vbasedev,
> >          return ret;
> >      }
> >
> > +    if (fds.recv_fds > 0 && info->index < vbasedev->num_initial_region=
s) {
> > +        vbasedev->region_fds[info->index].fds =3D g_new0(int, 1);
> > +        vbasedev->region_fds[info->index].nr_fds =3D 1;
> > +        vbasedev->region_fds[info->index].fds[0] =3D fd;
> > +    }
> > +
>
> This seems quite surprising behaviour in particular - if we happen to be =
asking
> about a "standard" region, then we'll store its fd info in vbasedev. But =
we
> might not be setting device->reginfo[index] at the same time.
>
> I'd expect vbasedev to be const in these callbacks.
>
> And what about the special regions > num_initial_regions?
>
> I feel like this callback should be passing in a VFIORegion to be filled =
in,
> then the caller can do as they wish with it. We could even embed the
> vfio_region_info into VFIORegion for convenience for the callers that wan=
t caps
> etc.

This approach makes sense to me I can refactor accordingly & respin.

>
> Alternatively, if we don't want to do this, then at least get_region_info=
()
> should take a VFIORegionFds out parameter, that the caller can then do wh=
at they
> like with.
>
> Thoughts C=C3=A9dric ?
>
> I'm also not sure why we have a sparse mmaps callback - why can't that be
> generic code that handles both capabilities? Are you concerned about the =
cap
> number clashing in future vfio kernel versions perhaps?

Yes I wanted to encapsulate vfio-user specific handling within the
vfio-user logic so that it doesn't conflict with the pure vfio device
handling. It felt odd to me to introduce generic handling of a
capability that's only exposed by one flavor of device and not the
other. However, no strong opinions, I can refactor and generalize the
cap handling if that's preferred, and the risks of cap number clashes
are okay.

>
> regards
> john

