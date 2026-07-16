Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB5BC44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkNP2-0007dI-5Y; Thu, 16 Jul 2026 10:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNOz-0007cv-VE
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:49:30 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNOy-00016o-0v
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:49:29 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-81ed27fe974so17458687b3.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 07:49:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784213367; cv=none;
 d=google.com; s=arc-20260327;
 b=Eo+ZauoBT7mhPxLNXcMfFMZugCkWZna/F3zbIwJA2z0NEGqT6UqksnYDvMbIwb77as
 AW5qkC3xmXKeN3p9gP4aty11CDm8r9O5DqRa5aVelKsP/CT1/BZfZtToNV3kWHDEIB4X
 3VHUaTFGbCPtVDOXR2FIIniQqgtxO7Kkwxp1avBQkntZGaEFUVeNmWY2q+hfdikQBH3S
 I7tX+Xti79y+pGySAPnPUqY9KgBa71QqCVdmpn+IXgF5Jg4hhK9r1cYniNQUpu12JdG4
 xzEhUN4j4eHpuItW+wmX0qvm82zgnwCTBXR05lDer/gzuIPkxZf/8KvdMLxuVUdDtsfW
 1sqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7+doK6yfhRRsqjlaGQ0F62Ez9tSlFrpo+S//xlHkHuk=;
 fh=XlSsuloH83uiYGd5wjFfxhBlTtHH/VsvoyCW8PyiI6I=;
 b=SNWMzdXB3J5YzzDR7ki4VMJA60THdRKlXBZ/iSFCNo8IqZQ2GrmuMqQBDlhhIMO54Z
 uIoSYCFWDx5s5IWeLaUVLSNvbhFuE2MG+kn3vc+gpD2EzZKCBcEMVHOBLBD2MJefriVh
 PhPGi+LOvSE8tZbEesTDkWadIoswT54brNnB6UB+08NmB4rk2PEzFHkrePUJe0jpApY1
 rTpfMD7SMfWLsj2hb7V615iNIhIru+dqE0BcGxyZ6WOgyRNQitTFZ54hcZ31bkWc92lh
 CbM2n1ewMMja4hyxFxc+mcsNgME2p1hnf3oNgZ1vSoNyZamoaRlS3hfm7oI1M/db1N6Q
 9Mog==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784213367; x=1784818167; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7+doK6yfhRRsqjlaGQ0F62Ez9tSlFrpo+S//xlHkHuk=;
 b=ZH5rysfQhw1ixEO6ppaJggHO8KjuLBRW6iRW19MnMe4zzv5YhtX9eQLuTxB0v4Mi9j
 8RIuxHWlVcH16+zvR0WPzgfinfx8MsNG9FmI1HJgzY7q9qSp8KfAWXsIywPn1qbDbCHg
 PTVkBKdOlF/x5OL4xBccgftgaA+lhZL1hYHnTOxS5KNrHcxKfstdKNXpLyuzNfwN76JA
 QAZmCYJ8FlsuD1SygZh926uglr9A3Eiw6SIXfp031eKHHgBme/N7Kzz3cFbzzSCEoYWz
 ubvKvWU/LjC70ghIdWmXbKpm3RZSVGbd7jc2089FggdIh/QyRgPUVenKTvn/suOP6yUj
 hSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784213367; x=1784818167;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7+doK6yfhRRsqjlaGQ0F62Ez9tSlFrpo+S//xlHkHuk=;
 b=NQ0Tpn4a/qHm2z+8UUV4eK53W3XEjFsx9CDYCCkOPV4Av7IeyTqrvQjPnm0lVEdqzq
 c5Qy7SKwkv6nsZ+5Gy7FMICyAzRSqayZQfIS7q4BR2OBazDGLE/+AgrJESXVamYhKL0V
 ZvhTaUdRQqJ3C9D2/k86kRs/+omYXABZCPBgsxfGDoQkV73bgcd6+yKZyQsxmCZpJy40
 OXmF/vyj7HTyKaGkEt8D/Qhw+2EbMqklLoG9fU30J7mxBKfhbn6nGY2MWTfqV/thIUux
 /Fq989m/iOEt/oBYV3qYJvRTSw2dwHBJxHvLhAOx91CHepjqjdEvTaE3JUPbCkoUMTxT
 uSJw==
X-Gm-Message-State: AOJu0Yw3rIBii57xzQupHI2HAv8Ch3j2FRukszhmogx549ok/fNy6MJP
 H7Wtz/WMU/ErFqljxj1w86cl9RVU2WK2L6OIuTRW8/nWVNMBIx94MTyMH3oTY/YWhGO7ff3UwEX
 u47XM47p06d4dWkayie8+Y/d/CqmzvHE=
X-Gm-Gg: AfdE7ckE/jg4zkSzswnl2rN/Q3u2H2jnEj/wz9C/cx+6MCrT03fe/1slRp55wHmVt57
 1jx+9aAd5Ap/4y7X0k9iIWME82L6UmtRWjEVRu9EnZpA9nsM7OAfYYZuyLfR4jmEXZ4zVeZ8i/1
 +nTWnnVYHphWUAfjQuguG1ifrCMSA6SAcspkCUFGQ6C1B1RkktRSMWugf71vTeA/rmec6sJ12bW
 pWHz40ocpG9tChXta5mlc/1La8zyEUyVzFw6k0GotwDdzoIKIj80xHHhcgt0jUa580r25dr
X-Received: by 2002:a05:690c:6508:b0:81e:45a6:bd53 with SMTP id
 00721157ae682-81e9000f576mr172481117b3.8.1784213366553; Thu, 16 Jul 2026
 07:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260624070851.13342-1-zhangckid@gmail.com>
 <20260624070851.13342-7-zhangckid@gmail.com>
 <aj5_T__4oqt41IWv@redhat.com>
 <CAK3tnvLTwLdWm2ZHcLhHRsncHZVvEgW_B14Ua4ZS9EX6BE1Erw@mail.gmail.com>
 <aljTO75kKel2fVLx@redhat.com>
In-Reply-To: <aljTO75kKel2fVLx@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 16 Jul 2026 22:48:48 +0800
X-Gm-Features: AUfX_mxwonSqRs3HD-3OIOA6X7kg5r7kcuMDhdeRa5pm_xB6WQAv0Fnd3A1WpMU
Message-ID: <CAK3tnvJjeeQvmAK9HggNUUv6nhPbMTa=1+bEvz71O8s+csU6CA@mail.gmail.com>
Subject: Re: [PATCH V9 06/17] monitor: refactor monitor_data_init() to pass ID
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=zhangckid@gmail.com; helo=mail-yw1-x112c.google.com
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

On Thu, Jul 16, 2026 at 8:49=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Mon, Jun 29, 2026 at 04:31:56PM +0800, Zhang Chen wrote:
> > On Fri, Jun 26, 2026 at 9:32=E2=80=AFPM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com> wrote:
> > >
> > > On Wed, Jun 24, 2026 at 03:08:40PM +0800, Zhang Chen wrote:
> > > > Anonymous monitors (e.g., '-monitor stdio' or GDB stub) leave their=
 'id'
> > > > field as NULL. To allow downstream subsystems (like iothread tracki=
ng) to
> > > > identify these instances later, the initialization paths must propa=
gate
> > > > the context.
> > > >
> > > > Refactor monitor_data_init() to accept the 'id' parameters, and
> > > > update all internal QMP/HMP paths to pass these identifiers.
> > > >
> > > > For anonymous monitors, 'mon->id' remains NULL at this stage to avo=
id
> > > > namespace pollution, setting up infrastructure for subsequent patch=
es.
> > > >
> > > > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > > > ---
> > > >  chardev/char.c             | 2 +-
> > > >  gdbstub/system.c           | 3 ++-
> > > >  include/monitor/monitor.h  | 5 +++--
> > > >  monitor/hmp.c              | 5 +++--
> > > >  monitor/monitor-internal.h | 4 +++-
> > > >  monitor/monitor.c          | 9 ++++++---
> > > >  monitor/qmp-cmds.c         | 2 +-
> > > >  monitor/qmp.c              | 5 +++--
> > > >  stubs/monitor-internal.c   | 3 ++-
> > > >  9 files changed, 24 insertions(+), 14 deletions(-)
> > >
> > > This patch will significantly conflict with my series that
> > > creates QOM objects for the monitors. They will all be
> > > guaranteed to have an "id" at that point though, which
> > > addresses the problem you're trying to solve IIUC.
> > >
> > > https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg06427.html
> > >
> >
> > Thank you for your updates.
> > As Markus's help, we already know your series for create
> > QOM for the monitors. So this series V7 based on the assumption of
> > your patch merged. But for the comments:
> > "Feels like this patch should not be merged as is."
> > https://lists.gnu.org/archive/html/qemu-devel/2026-05/msg04214.html
> >
> > I have to fix it by myself.
> > I'm very happy this series based on your series, I can conveniently mak=
e
> > the monitor as a regular QOM object like others in this series.
> > If you think that OK, I will rebase my series on your QOM for monitor p=
atches
> > in next version.
>
> FYI, my monitor hotplug series is merged, so you can simply
> rebase your work onto current git HEAD.
>

Thank you, Daniel.
I rebased my series on your latest patches, it looks the same as merged ver=
sion.
    [PATCH v7 00/35] monitor: turn QMP and HMP into QOM objects
    https://lore.kernel.org/qemu-devel/20260706135824.2623960-1-berrange@re=
dhat.com/

And I have released V10 and welcome everyone to review it.

Thanks
Chen

>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>

