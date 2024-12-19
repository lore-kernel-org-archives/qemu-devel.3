Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCFBE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 07:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBQ8-0004Fm-63; Thu, 19 Dec 2024 02:58:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1tOBQ7-0004FN-6o
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 02:58:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1tOBQ5-000569-8x
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 02:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734595083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kPqSE+K01vTmJUiHO5/T15LGW1H+7EafOxEsbsIOrgY=;
 b=YlpNuLaDNMMD92eEMSvCCV2EdJzKNzV1mZw/uId0T/Krh+mjEizNtUl9HyI+ABoIrrhKEH
 CjeWxzmM+0JUsRWefcLO/EpjAgsadEMaoSQpltbNhAl/ETR2Cyke9ZBEZFNKzDQn5csPbr
 v0/9+7xmTiBG1xJq6LX9GEYCHUMl5O8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-6k87rtrqM_OK9z7wQKZCdQ-1; Thu, 19 Dec 2024 02:55:58 -0500
X-MC-Unique: 6k87rtrqM_OK9z7wQKZCdQ-1
X-Mimecast-MFC-AGG-ID: 6k87rtrqM_OK9z7wQKZCdQ
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-71e16481433so498712a34.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 23:55:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734594957; x=1735199757;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kPqSE+K01vTmJUiHO5/T15LGW1H+7EafOxEsbsIOrgY=;
 b=pAA2ZlF7oKVpjSRtisS2enzGXlzvHUv+fy2XweQcSkdnnRHBEGQr4Y2W3GMLo/WWdC
 YXraS09nfL5kz6FPhmhc7MCkoIyMsjjSoytyyPAhEljDbw+pwmuzMPYz0FRseZ+6y1od
 cOkvG3iscqGBKWNOLiTYSzbDMwtlF6MnYNpIhx0jBQyAciUZ+5S2h7UrYBldVotyG6zN
 ryIl+sGvp2u9kQI+lIEqlo4i3RL3bTLGrDiNQ0/bPBGOh/ZKV0O9cOAa5SDhfbAj2Eec
 /oPfpdtD8QtuIvp+g7O1Deig44e5FbUAcUkhnFqxfnmbMobPHrtYt0GL3QNoHc+ojcMU
 EF5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5Adv0c0up/DFdNelTH31UIuBW9B2Aat3AXisxjFUxVLZJzw0NHtsLOxmzImgivV52W8j19hASyWrR@nongnu.org
X-Gm-Message-State: AOJu0Yw0u8cC/Lat/Pzf7mcfzU01DBNhTE3V9ihbjrl/MEBiSoHfNA3d
 Uf3qpo8/pAGu7Ss+I71zCNUTfJNNGLMS2CpShIxdZxPtwxIoMgbF11INwftm9Z/txtyOx1YPu1h
 n4ulAFNU0aUJRNoarhGKnzK4fqK/XNEhKv6FRy9OkFrcFfyvxyMqlFgS73PF89FxtjY8S6Z1Szw
 Df8WN8sXWftCBR06eyxpudhi8zd/A=
X-Gm-Gg: ASbGncv2UaWa4kjkTKR9M66irQu87VejbHK720Rpe6YGimMk/blRxP/7cZfZ76PZewn
 nsrQlyVv7CRGIkGr8LoEJYFkUIKiAe0GYEsxbcbQ=
X-Received: by 2002:a9d:775a:0:b0:71d:fa9e:9ca7 with SMTP id
 46e09a7af769-71fc59cef2fmr1302528a34.7.1734594957217; 
 Wed, 18 Dec 2024 23:55:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyJ+fAQZFQDIho1rCA+L4EzXL3EVpuDKxdiaNN8ispSjJhw4rWkvVIgiKq2E9dW+dzLp27bJHgYcV09v+v57c=
X-Received: by 2002:a9d:775a:0:b0:71d:fa9e:9ca7 with SMTP id
 46e09a7af769-71fc59cef2fmr1302521a34.7.1734594956905; Wed, 18 Dec 2024
 23:55:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <Z1CpIA7_o7s-NzJ_@x1n>
 <23398782-6d92-48ae-99f3-855b405f366f@maciej.szmigiero.name>
 <Z1N4qYOsEcfsC-H5@x1n>
 <5c6a0bc3-ab9a-4514-8feb-f3c17978d3af@maciej.szmigiero.name>
 <Z1se0X6eq1DRYLa0@x1n>
In-Reply-To: <Z1se0X6eq1DRYLa0@x1n>
From: Yanghang Liu <yanghliu@redhat.com>
Date: Thu, 19 Dec 2024 15:55:45 +0800
Message-ID: <CAGYh1E89i-AeHMOt5ddmB_-oGVYqBHr1Oj55OUDyhpzor9bDuQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v3_00=2F24=5D_Multifd_=F0=9F=94=80_device_state_trans?=
 =?UTF-8?Q?fer_support_with_VFIO_consumer?=
To: Peter Xu <peterx@redhat.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Fabiano Rosas <farosas@suse.de>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org, Chao Yang <chayang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=yanghliu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

FYI.  The following data comes from the first ping-pong mlx VF
migration after rebooting the host.


1. Test for multifd=3D0:

1.1 Outgoing migration:
VF number:                     1 VF                           4 VF
Time elapsed:             10194 ms                   10650 ms
Memory processed:    903.911 MiB             783.698 MiB
Memory bandwidth:    108.722 MiB/s          101.978 MiB/s
Iteration:                               4                              6
Normal data:                881.297 MiB             747.613 MiB
Total downtime                358ms                       518ms
Setup time                        52ms                        450ms

1.2 In coming migration:
VF number:                       1 VF                            4 VF
Time elapsed:                10161 ms                    10569 ms
Memory processed:     903.881 MiB                785.400 MiB
Memory bandwidth:     107.952 MiB/s             100.512 MiB/s
Iteration:                               4                                7
Normal data:                 881.262 MiB               749.297 MiB
Total downtime                315ms                        513ms
Setup time                        47ms                         414ms


2. Test for multifd=3D1:

2.1 Outgoing migration:
VF number                     1 VF                           1 VF
Channel number               4                                  5
Time elapsed:              10962 ms                  10071 ms
Memory processed:     908.968 MiB             908.424 MiB
Memory bandwidth:     108.378 MiB/s         110.109 MiB/s
Iteration:                               4
  4
Normal data:               882.852 MiB              882.566 MiB
Total downtime                318ms                       255ms
Setup time                         54ms                        43ms


VF number                    4 VFs                        4 VFs
Channel number             8                               16
Time elapsed:            10805 ms                  10943 ms
Setup time                   445 ms                       463ms
Memory processed:  786.334 MiB            784.926 MiB
Memory bandwidth   109.062 MiB/s         108.610 MiB/s
Iteration:                              5                           7
Normal data:            746.758 MiB             744.938 MiB
Total downtime            344 ms                     335ms


2.2 Incoming migration:
VF number                       1 VF                      1 VF
Channel number                4                            5
Time elapsed:                10064ms               10072 ms
Memory processed:     909.786 MiB           923.746 MiB
Memory bandwidth:      109.997 MiB/s       111.308 MiB/s
Iteration:                               4                          4
Normal data:               883.664 MiB            897.848 MiB
Total downtime                 313ms                   328ms
Setup time                        46ms                      47ms

VF number                   4 VFs                        4 VFs
Channel number             8                              16
Time elapsed:             10126 ms                 9941 ms
Memory processed:   791.308 MiB           779.560 MiB
Memory bandwidth:  108.876 MiB/s         110.170 MiB/s
Iteration:                          7                               5
 Normal data:             751.672 MiB           739.680 MiB
Total downtime             304 ms                    309ms
Setup time                    442 ms                    446ms


Best Regards,
Yanghang Liu




On Fri, Dec 13, 2024 at 1:36=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Dec 11, 2024 at 12:06:04AM +0100, Maciej S. Szmigiero wrote:
> > On 6.12.2024 23:20, Peter Xu wrote:
> > > On Fri, Dec 06, 2024 at 07:03:36PM +0100, Maciej S. Szmigiero wrote:
> > > > On 4.12.2024 20:10, Peter Xu wrote:
> > > > > On Sun, Nov 17, 2024 at 08:19:55PM +0100, Maciej S. Szmigiero wro=
te:
> > > > > > Important note:
> > > > > > 4 VF benchmarks were done with commit 5504a8126115
> > > > > > ("KVM: Dynamic sized kvm memslots array") and its revert-depend=
encies
> > > > > > reverted since this seems to improve performance in this VM con=
fig if the
> > > > > > multifd transfer is enabled: the downtime performance with this=
 commit
> > > > > > present is 1141 ms enabled / 1730 ms disabled.
> > > > > >
> > > > > > Smaller VF counts actually do seem to benefit from this commit,=
 so it's
> > > > > > likely that in the future adding some kind of a memslot pre-all=
ocation
> > > > > > bit stream message might make sense to avoid this downtime regr=
ession for
> > > > > > 4 VF configs (and likely higher VF count too).
> > > > >
> > > > > I'm confused why revert 5504a8126115 could be faster, and it affe=
cts as
> > > > > much as 600ms.  Also how that effect differs can relevant to num =
of VFs.
> > > > >
> > > > > Could you share more on this regression?  Because if that's probl=
ematic we
> > > > > need to fix it, or upstream QEMU (after this series merged) will =
still not
> > > > > work.
> > > > >
> > > >
> > > > The number of memslots that the VM uses seems to differ depending o=
n its
> > > > VF count, each VF using 2 memslots:
> > > > 2 VFs, used slots: 13
> > > > 4 VFs, used slots: 17
> > > > 5 VFs, used slots: 19
> > >
> > > It's still pretty less.
> > >
> > > >
> > > > So I suspect this performance difference is due to these higher cou=
nts
> > > > of memslots possibly benefiting from being preallocated on the prev=
ious
> > > > QEMU code (before commit 5504a8126115).
> > > >
> > > > I can see that with this commit:
> > > > > #define  KVM_MEMSLOTS_NR_ALLOC_DEFAULT                      16
> > > >
> > > > So it would explain why the difference is visible on 4 VFs only (an=
d
> > > > possibly higher VF counts, just I don't have an ability to test mig=
rating
> > > > it) since with 4 VF configs we exceed KVM_MEMSLOTS_NR_ALLOC_DEFAULT=
.
> > >
> > > I suppose it means kvm_slots_grow() is called once, but I don't under=
stand
> > > why it caused 500ms downtime!
> >
> > In this cover letter sentence:
> > > "the downtime performance with this commit present is 1141 ms enabled=
 / 1730 ms disabled"
> > "enabled" and "disabled" refer to *multifd transfer* being enabled, not
> > your patch being present (sorry for not being 100% clear there).
> >
> > So the difference that the memslot patch makes is 1141 ms - 1095ms =3D =
46 ms extra
> > downtime, not 500 ms.
> >
> > I can guess this is because of extra contention on BQL, with unfortunat=
e timing.
>
> Hmm, I wonder why the address space changed during switchover.  I was
> expecting the whole address space is updated on qemu boots up, and should
> keep as is during migration.  Especially why that matters with mulitifd a=
t
> all..  I could have overlooked something.
>
> >
> > > Not to mention, that patchset should at least reduce downtime OTOH du=
e to
> > > the small num of slots, because some of the dirty sync / clear path w=
ould
> > > need to walk the whole slot array (our lookup is pretty slow for now,=
 but
> > > probably no good reason to rework it yet if it's mostly 10-20).
> >
> > With multifd transfer being disabled your memslot patch indeed improves=
 the
> > downtime by 1900 ms - 1730 ms =3D 170 ms.
>
> That's probably the other side of the change when slots grow, comparing t=
o
> the pure win where the series definitely should speedup the dirty track
> operations quite a bit.
>
> >
> > > In general, I would still expect that dynamic memslot work to speedup
> > > (instead of slowing down) VFIO migrations.
> > >
> > > There's something off here, or something I overlooked.  I suggest we =
figure
> > > it out..  Even if we need to revert the kvm series on master, but I s=
o far
> > > doubt it.
> > >
> > > Otherwise we should at least report the number with things on the mas=
ter
> > > branch, and we evaluate merging this series with that real number, be=
cause
> > > fundamentally that's the numbers people will get when start using thi=
s
> > > feature on master later.
> >
> > Sure, that's why in the cover letter I provided the numbers with your c=
ommit
> > present, too.
>
> It seems to me we're not far away from the truth.  Anyway, feel free to
> update if you figure out the reason, or got some news on profiling.
>
> Thanks,
>
> --
> Peter Xu
>
>


