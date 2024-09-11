Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5079AEE0206
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 17:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soRUv-0008Fn-Dc; Wed, 11 Sep 2024 13:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1soRUu-0008FE-1C
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 13:51:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1soRUl-00033d-EW
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 13:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726076936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NtRyoT8imVfWHUxxNaEqmS41NCXM90jR3LO6HC7znm0=;
 b=UDj/BggGyOgVSpBYaAY50spSytv1ooihnUGPmEEhBgjxNdNxCRGnuXMCP2wclXMXAqYqRy
 cwz7CNHcd/kSgOC73AB8tIpVKDiuSB3UUxahYA+sGQsJ2zv4edIWKKJuIp/DOF+brK5oYa
 1t1DHHJ+/EjiSM1VXzieDDzgVPdmVWw=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-W_qfDstXM1KWq0tqAAT8ow-1; Wed, 11 Sep 2024 13:48:55 -0400
X-MC-Unique: W_qfDstXM1KWq0tqAAT8ow-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-6d73dd8ac65so4004087b3.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 10:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726076935; x=1726681735;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NtRyoT8imVfWHUxxNaEqmS41NCXM90jR3LO6HC7znm0=;
 b=J/4CvmEIkvrXo6ijqFvkpkRjPxLU+HpDLRY11vz1HSar4dPSpjTR7sEjp5U4mFKshm
 HgL/WWhGcbCI3BNedML11OboGG22tuzIjPvWssRMw4/Hq1pIUQFQ2jk8aYO6H7jgNHHw
 Sf+kuOYWrda9tZR5ZVlh1okWFv7BJ92L4dUSp6rdfLa5b/ALbmDpRQZGH3ZvIgVJSZSS
 mvo8qA7cUS4D5RGLC7xcvcc2iykHQxbhN4LM+LGx3LaRAkuooJ4kzLd3HjWAi1fsAB3/
 +y9C7tSMe1+kO+ZctGPYtx1rfYQ9V1uJLO6T59r2LiIhu0Or35dEYXPvRvkuUdBnAISR
 Hz8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsWIKkt5h9vw8XcLKNLBkIYU5LbhyqWky0rQ/lZOKSqzPmv8E/5jTr/+FcYlgIfDJdlvv7NRhCxuw6@nongnu.org
X-Gm-Message-State: AOJu0Yxbwu0c+UHQm9leBhZ5DcJpJ7ltydwJvlQqEgryMFoVMxWopFyW
 WRD/GsW3zS7FCjq6Rzno5bhhDj8LLCNqry1QAPZFGl8sNG6G6f6BWnlCe+zqcaLA1NmoOHu+3D8
 BsymUPZ2W2r8Xd7UTzYWo/S9x/WkL1U4wUYa3A8omvAN1J1eyXZktNmeVRxbAZz9dIO1jkhcoQz
 PvxoXcekapYtp6CHGJRULcqUbdVQE=
X-Received: by 2002:a05:690c:385:b0:6db:aef5:aff2 with SMTP id
 00721157ae682-6dbb6b44984mr3607397b3.25.1726076935156; 
 Wed, 11 Sep 2024 10:48:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2opakMN+Ym5jUi2zG14/8thiXhlS9JZKuwpg4ZxKTg4CN9FSWbcAkrf75joPztLMUpFpF0ivpWOAD8iGLoo8=
X-Received: by 2002:a05:690c:385:b0:6db:aef5:aff2 with SMTP id
 00721157ae682-6dbb6b44984mr3607217b3.25.1726076934844; Wed, 11 Sep 2024
 10:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240129132407.1474202-1-eperezma@redhat.com>
 <CACGkMEvXNSkMy=WAv-Eiy4M_7kmqJFkv7RgDwqrgry_O2eT2hA@mail.gmail.com>
 <1559bdcb-315e-4411-a996-89c6be430d4f@oracle.com>
 <CACGkMEveP-MMN0qGRZEL_VwtJeA+9qiYq_5X9CsOpzTsCLNEuw@mail.gmail.com>
 <CAJaqyWecQRN_2JX0Wef+JOhyfcrAsvi36d=48z4OT55ga-UZCA@mail.gmail.com>
In-Reply-To: <CAJaqyWecQRN_2JX0Wef+JOhyfcrAsvi36d=48z4OT55ga-UZCA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 11 Sep 2024 19:48:19 +0200
Message-ID: <CAJaqyWeUZ=R-nPsLhDCV4nsA9d7=3c14SOOU3Mr8_0JEe6fSPw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Move net backend cleanup to NIC cleanup
To: Jason Wang <jasowang@redhat.com>
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, qemu-devel@nongnu.org, mst@redhat.com, 
 leiyang@redhat.com, yajunw@nvidia.com, Ani Sinha <anisinha@redhat.com>, 
 dtatulea@nvidia.com, mcoqueli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Sep 11, 2024 at 11:04=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Tue, Sep 10, 2024 at 5:46=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Tue, Sep 10, 2024 at 11:41=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.=
com> wrote:
> > >
> > > Hi Jason,
> > >
> > > It seems this series wasn't applied successfully, I still cannot see =
it
> > > from the latest tree. Any idea?
> >
> > It breaks make check.
> >
> > Eugenio, would you want to fix and resend the series?
> >
>
> I'm trying to reproduce but with no luck :(.
>

I'm able to reproduce consistently now.

> For the record this is the failed log. Is it possible to try to
> reproduce it again in the machine / env it crashed?
>
> =E2=96=B6  10/354 ERROR:../tests/qtest/qos-test.
> c:191:subprocess_run_one_test:
> child process (/x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-net-pc=
i/virtio-net/virtio-net-tests/vhost-user/migrate/subprocess
> [1494462]) failed unexpectedly ERROR
>  10/354 qemu:qtest+qtest-x86_64 / qtest-x86_64/qos-test
>         ERROR           14.19s   killed by signal 6 SIGABRT
> >>> PYTHON=3D/home/devel/git/qemu/build/pyvenv/bin/python3 G_TEST_DBUS_DA=
EMON=3D/home/devel/git/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_STORAGE=
_DAEMON_BINARY=3D./storage-daemon/qemu-storage-daemon QTEST_QEMU_IMG=3D./qe=
mu-img QTEST_QEMU_BINARY=3D./qemu-system-x86_64 MALLOC_PERTURB_=3D82 /home/=
devel/git/qemu/build/tests/qtest/qos-test --tap -k
> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95
> =E2=9C=80  =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95
> stderr:
> Vhost user backend fails to broadcast fake RARP
> ../tests/qtest/libqtest.c:204: kill_qemu() detected QEMU death from
> signal 11 (Segmentation fault) (core dumped)
> ../tests/qtest/libqtest.c:204: kill_qemu() detected QEMU death from
> signal 11 (Segmentation fault) (core dumped)
> **
> ERROR:../tests/qtest/qos-test.c:191:subprocess_run_one_test: child
> process (/x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-net-pci/virt=
io-net/virtio-net-tests/vhost-user/migrate/subprocess
> [1494462]) failed unexpectedly
> > Thanks
> >
> > >
> > > In any case the fix LGTM.
> > >
> > > Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > >
> > > Thanks,
> > > -Siwei
> > >
> > > On 1/31/2024 9:43 PM, Jason Wang wrote:
> > > > On Mon, Jan 29, 2024 at 9:24=E2=80=AFPM Eugenio P=C3=A9rez <eperezm=
a@redhat.com> wrote:
> > > >> Commit a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net
> > > >> structures if peer nic is present") effectively delayed the backen=
d
> > > >> cleanup, allowing the frontend or the guest to access it resources=
 as
> > > >> long as the frontend NIC is still visible to the guest.
> > > >>
> > > >> However it does not clean up the resources until the qemu process =
is
> > > >> over.  This causes an effective leak if the device is deleted with
> > > >> device_del, as there is no way to close the vdpa device.  This mak=
es
> > > >> impossible to re-add that device to this or other QEMU instances u=
ntil
> > > >> the first instance of QEMU is finished.
> > > >>
> > > >> Move the cleanup from qemu_cleanup to the NIC deletion.
> > > >>
> > > >> Fixes: a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net =
structures if peer nic is present")
> > > >> Acked-by: Jason Wang <jasowang@redhat.com>
> > > >> Reported-by: Lei Yang <leiyang@redhat.com>
> > > >> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > >>
> > > >> Eugenio P=C3=A9rez (2):
> > > >>    net: parameterize the removing client from nc list
> > > >>    net: move backend cleanup to NIC cleanup
> > > >>
> > > >>   net/net.c        | 30 ++++++++++++++++++++----------
> > > >>   net/vhost-vdpa.c |  8 --------
> > > >>   2 files changed, 20 insertions(+), 18 deletions(-)
> > > >>
> > > >> --
> > > > Queued.
> > > >
> > > > Thanks
> > > >
> > >
> >


