Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32ADAEE021F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 09:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soJHt-0002J5-BP; Wed, 11 Sep 2024 05:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1soJHr-0002I5-Li
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:05:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1soJHp-0002yK-Vr
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726045516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P1uC7dev0gnhSlqUqS+VfXesNI03n/7m3jW8yni+Z4A=;
 b=GzJuXdbsyvcbvH5Oqu33y/CKqAMd+p9zhuXydFb6OyPhemZq/8xRQqAyMww6hHFUPM0GS0
 jHjeO1oMrJxk+M9pl8kCAGdSLJ4rVaVkczZbPH86brTalq6bfKfUCWEH1ZnTbQVZoKTvoK
 2EmAimNEE+H9Mh2BpkoODFkOEV/8JWk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-bC7eyvBCPaqi8ULYVkXCxQ-1; Wed, 11 Sep 2024 05:05:15 -0400
X-MC-Unique: bC7eyvBCPaqi8ULYVkXCxQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6d6bb05f2e9so29966087b3.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 02:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726045515; x=1726650315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P1uC7dev0gnhSlqUqS+VfXesNI03n/7m3jW8yni+Z4A=;
 b=CjgTXNKx41pvr6/wILzEgoefoX2t0SnLvNopnUsj5dWSeRn8KgBn9DSwUMi1hlcvWe
 TGQQCSN85aBxR0iyO3palb9jaAIeR8NVuxmIkUqa+3Qsm/OhuKSSQAq4vt3XbnfAplIK
 QeN9kommsTZ+TrYCCx/8Zkidgej5udD2Sf4edFfLhPZffv1KNnvGffOslfKYBfgPNbtm
 DwFeUH75sP/UppdU7QtGmety7OgGLn2AcBCFOrbpoLIQIvPp0+SKwnkVcza2R/Zurjlk
 0IPm6tIWPBWRhNP/7YFC5PJeejSc0OUGhH4+GHbfSkKhzAys5amuxWNJT3VS0HO2ggqp
 TxJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqLE8gXvwBgjqd/x4auaq87tBcV+DA10iioT+W9oaDnFuWv7RViNq0I0VfddTEM7hK91/RVbKYBSDi@nongnu.org
X-Gm-Message-State: AOJu0Yxpe39GI98JANEiGnvZ4GY8YlXlQMXCesWclzlvO8cpkWGyiSjb
 6/huYB22JIyvw1iUU4ZqVcg6mUu2n7p7DdBoHrFMfhhxuNRSBMPziwzm6fHmz8lP+GRr4Pk/e6X
 l6QrbIGT0/4LJLiF522ssRPN3XP3Wk0+LhbzdwVIN/pZ/EVIj7jWrXwRNnmwl/z4tKcAgF26pI/
 bfw5t5wKgl6hxttrUYHmrjndpU3sY=
X-Received: by 2002:a05:690c:25c6:b0:6c8:1e30:5136 with SMTP id
 00721157ae682-6dba6d99993mr23947317b3.16.1726045514851; 
 Wed, 11 Sep 2024 02:05:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkUDUKyEE/xw6DMYoZbSc1U4ON0tWWbas0SM+mzPmynd4NzSHuzhW0jD9lsq6SZlkoR8JKWgfObPzaGhspIxY=
X-Received: by 2002:a05:690c:25c6:b0:6c8:1e30:5136 with SMTP id
 00721157ae682-6dba6d99993mr23947197b3.16.1726045514567; Wed, 11 Sep 2024
 02:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240129132407.1474202-1-eperezma@redhat.com>
 <CACGkMEvXNSkMy=WAv-Eiy4M_7kmqJFkv7RgDwqrgry_O2eT2hA@mail.gmail.com>
 <1559bdcb-315e-4411-a996-89c6be430d4f@oracle.com>
 <CACGkMEveP-MMN0qGRZEL_VwtJeA+9qiYq_5X9CsOpzTsCLNEuw@mail.gmail.com>
In-Reply-To: <CACGkMEveP-MMN0qGRZEL_VwtJeA+9qiYq_5X9CsOpzTsCLNEuw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 11 Sep 2024 11:04:38 +0200
Message-ID: <CAJaqyWecQRN_2JX0Wef+JOhyfcrAsvi36d=48z4OT55ga-UZCA@mail.gmail.com>
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
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 10, 2024 at 5:46=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Sep 10, 2024 at 11:41=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.co=
m> wrote:
> >
> > Hi Jason,
> >
> > It seems this series wasn't applied successfully, I still cannot see it
> > from the latest tree. Any idea?
>
> It breaks make check.
>
> Eugenio, would you want to fix and resend the series?
>

I'm trying to reproduce but with no luck :(.

For the record this is the failed log. Is it possible to try to
reproduce it again in the machine / env it crashed?

=E2=96=B6  10/354 ERROR:../tests/qtest/qos-test.
c:191:subprocess_run_one_test:
child process (/x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-net-pci/=
virtio-net/virtio-net-tests/vhost-user/migrate/subprocess
[1494462]) failed unexpectedly ERROR
 10/354 qemu:qtest+qtest-x86_64 / qtest-x86_64/qos-test
        ERROR           14.19s   killed by signal 6 SIGABRT
>>> PYTHON=3D/home/devel/git/qemu/build/pyvenv/bin/python3 G_TEST_DBUS_DAEM=
ON=3D/home/devel/git/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_STORAGE_D=
AEMON_BINARY=3D./storage-daemon/qemu-storage-daemon QTEST_QEMU_IMG=3D./qemu=
-img QTEST_QEMU_BINARY=3D./qemu-system-x86_64 MALLOC_PERTURB_=3D82 /home/de=
vel/git/qemu/build/tests/qtest/qos-test --tap -k
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95
=E2=9C=80  =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95
stderr:
Vhost user backend fails to broadcast fake RARP
../tests/qtest/libqtest.c:204: kill_qemu() detected QEMU death from
signal 11 (Segmentation fault) (core dumped)
../tests/qtest/libqtest.c:204: kill_qemu() detected QEMU death from
signal 11 (Segmentation fault) (core dumped)
**
ERROR:../tests/qtest/qos-test.c:191:subprocess_run_one_test: child
process (/x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-net-pci/virtio=
-net/virtio-net-tests/vhost-user/migrate/subprocess
[1494462]) failed unexpectedly
> Thanks
>
> >
> > In any case the fix LGTM.
> >
> > Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >
> > Thanks,
> > -Siwei
> >
> > On 1/31/2024 9:43 PM, Jason Wang wrote:
> > > On Mon, Jan 29, 2024 at 9:24=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@=
redhat.com> wrote:
> > >> Commit a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net
> > >> structures if peer nic is present") effectively delayed the backend
> > >> cleanup, allowing the frontend or the guest to access it resources a=
s
> > >> long as the frontend NIC is still visible to the guest.
> > >>
> > >> However it does not clean up the resources until the qemu process is
> > >> over.  This causes an effective leak if the device is deleted with
> > >> device_del, as there is no way to close the vdpa device.  This makes
> > >> impossible to re-add that device to this or other QEMU instances unt=
il
> > >> the first instance of QEMU is finished.
> > >>
> > >> Move the cleanup from qemu_cleanup to the NIC deletion.
> > >>
> > >> Fixes: a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net st=
ructures if peer nic is present")
> > >> Acked-by: Jason Wang <jasowang@redhat.com>
> > >> Reported-by: Lei Yang <leiyang@redhat.com>
> > >> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > >>
> > >> Eugenio P=C3=A9rez (2):
> > >>    net: parameterize the removing client from nc list
> > >>    net: move backend cleanup to NIC cleanup
> > >>
> > >>   net/net.c        | 30 ++++++++++++++++++++----------
> > >>   net/vhost-vdpa.c |  8 --------
> > >>   2 files changed, 20 insertions(+), 18 deletions(-)
> > >>
> > >> --
> > > Queued.
> > >
> > > Thanks
> > >
> >
>


