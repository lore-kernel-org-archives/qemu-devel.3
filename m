Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134CCC77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 15:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU5Bh-0007J3-Ud; Tue, 24 Jun 2025 11:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uU5Bc-0007I1-NC
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 11:03:48 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uU5BS-0002D0-AJ
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 11:03:48 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6077d0b9bbeso9260040a12.3
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750777413; x=1751382213; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OTtv62vkM+6xU7usSj+6NDw1p4tN228alkkORd0v9dc=;
 b=dlx4rlmhjj7mzLqOhzu+ImeR0gidoH9OtO3ZBDS4yNsxUyonWP4U1cKCTv1HcKq4I7
 YUfZ4dIDXKPNzcIbE6KdBqTAENmZMXD7h+PRJtLr63f9n6+kArmctfGvFN/mp0BtkozM
 aOgLk19hdojVsJzGR9bQ2nc6z2mvJEbdopMd0ZIKY9UmgdHzVykbgB1biLUB/Mco5i4/
 AU6fpzdsH2mVjBwHSsEaEt994GxcWZZuhPndGpQ8puGhPjrNl9JieSq4QAZzZLo6YLSp
 Y1kfqSNXne9EJUGDc2A9tqDn/sGXe3UhV04SKosARtMDPHaUvpebDtwhTd+JP5JhvvSI
 CNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750777413; x=1751382213;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OTtv62vkM+6xU7usSj+6NDw1p4tN228alkkORd0v9dc=;
 b=bAEsTbpTQ/9WDuTzlnWrgVm6GMy66PzW2U+OWGH1QKBEHDIPdDOc8M8J6ajV2vn4eE
 0DJ0fN9Y9J5CuvzV41d0YuOpyMCTykNvisBtZ4Hj2SaZokTe0apsxoZApqSqDTosrLCP
 SgrAMYL01sekH2DsfTTMyx04XFyLsDzOnDQ1+wU74LyXM8a7dtGRX5fKZVYStOrSQZtm
 DmJ6xBITqCkno5zd/x7jeGaDw1w9nDGAcZEZ00anThGyRGbZEAeiIXzOKqt0uwxo+dSb
 5a2rMma1HqLfHUz5Ksl6nEGKlnnU+BWYIN3cXwSan/89WRaU9dg3UdiTJbD5uYwkV9JG
 X5QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULsIwQz+ewevE8v8G1FSC2mQJVZtRyD4sAvYGh49a+EFtMeeTUmYNtVaK3GOt4eMtkvQKQxMwgdaiv@nongnu.org
X-Gm-Message-State: AOJu0YxXtxt2k4Sgs6Qij8cDIWl3TybiybmheI21z0CoJOc6Nr7r6Vzo
 MpgTrM8mT90i9loWUnc3yeCUg7eIltjRfRHu3FtYz45chXRHS/4m7zhy/MVy09iV+dq8H5wqICT
 GHMrzk4cuPDKRLlqu9MG+hmeFDIn8NAs=
X-Gm-Gg: ASbGncuachJrxyNi2t/KJiLnqavy3UxT2kpPJ2ZEms5KZf1tUFKQS/7rUkugVUhc8NV
 LHNI0gdmFWabKW6Y5Q1iRGmHUJHcBfMx342sHZXkuvcFTUou9PrrHDD8RQj3gP9eWtqctRWSDov
 JyvgA7mZ2VvOxWeTchpFPfdJHkJbsxWCADxkdS1wlqZg==
X-Google-Smtp-Source: AGHT+IFNf7pDL83rQo24LmD16bcLcr5AXlcFJxqxY/kPwc2k5UEOyqGH8GnKs9G7rykN/EXTUaFezZqMjGeoksmyxCo=
X-Received: by 2002:a05:6402:27ce:b0:607:f513:480a with SMTP id
 4fb4d7f45d1cf-60a1cd1a383mr13694605a12.5.1750777411683; Tue, 24 Jun 2025
 08:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250620164053.579416-1-pbonzini@redhat.com>
 <20250620164053.579416-25-pbonzini@redhat.com>
 <b8171c39-6a92-4078-a59a-a63d7452e1e9@kaod.org>
 <4ffdb62b-8fe4-4b34-9efa-aecff7f8e77b@intel.com>
 <aFkKL-TQTcrBtXuK@redhat.com>
 <CAJSP0QUgirgNX71MwGgYbdDhVUrd3MWsetx66_+GsER8BfoSbg@mail.gmail.com>
 <aFlR6CTLRzSpS1fr@redhat.com>
 <CAJSP0QUVuXRK9nyXw=HcEV6Qi5HaE+TzVp1QOiGp7c7pX=Z=Hw@mail.gmail.com>
 <32c86014-8e28-4100-bb87-9072acdc01cb@kaod.org>
In-Reply-To: <32c86014-8e28-4100-bb87-9072acdc01cb@kaod.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 24 Jun 2025 11:03:19 -0400
X-Gm-Features: Ac12FXysq5bNMac3mHbgq8-8H32b-Gdr3CmhMqLVgP_31Iob0NQR5_euHSrxh7o
Message-ID: <CAJSP0QXnXSBy9bDetUL4SEOxP=tLaGZZ+5qEQCp=SU3KDNmg5A@mail.gmail.com>
Subject: Re: [PULL 24/24] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Isaku Yamahata <isaku.yamahata@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52f.google.com
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

On Mon, Jun 23, 2025 at 4:37=E2=80=AFPM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:
>
> On 6/23/25 20:57, Stefan Hajnoczi wrote:
> > On Mon, Jun 23, 2025 at 9:09=E2=80=AFAM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com> wrote:
> >>
> >> On Mon, Jun 23, 2025 at 09:04:33AM -0400, Stefan Hajnoczi wrote:
> >>> On Mon, Jun 23, 2025 at 4:04=E2=80=AFAM Daniel P. Berrang=C3=A9 <berr=
ange@redhat.com> wrote:
> >>>>
> >>>> On Mon, Jun 23, 2025 at 03:03:19PM +0800, Xiaoyao Li wrote:
> >>>>> On 6/23/2025 2:43 PM, C=C3=A9dric Le Goater wrote:
> >>>>>> Hello,
> >>>>>>
> >>>>>> On 6/20/25 18:40, Paolo Bonzini wrote:
> >>>>>>> From: Isaku Yamahata <isaku.yamahata@intel.com>
> >>>>>>>
> >>>>>>> Add property "quote-generation-socket" to tdx-guest, which is a p=
roperty
> >>>>>>> of type SocketAddress to specify Quote Generation Service(QGS).
> >>>>>>>
> >>>>>>> On request of GetQuote, it connects to the QGS socket, read reque=
st
> >>>>>>> data from shared guest memory, send the request data to the QGS,
> >>>>>>> and store the response into shared guest memory, at last notify
> >>>>>>> TD guest by interrupt.
> >>>>>>>
> >>>>>>> command line example:
> >>>>>>>     qemu-system-x86_64 \
> >>>>>>>       -object '{"qom-type":"tdx-guest","id":"tdx0","quote-generat=
ion-
> >>>>>>> socket":{"type":"unix", "path":"/var/run/tdx-qgs/qgs.socket"}}' \
> >>>>>>>       -machine confidential-guest-support=3Dtdx0
> >>>>>>>
> >>>>>>> Note, above example uses the unix socket. It can be other types,
> >>>>>>> like vsock,
> >>>>>>> which depends on the implementation of QGS.
> >>>>>>>
> >>>>>>> To avoid no response from QGS server, setup a timer for the trans=
action.
> >>>>>>> If timeout, make it an error and interrupt guest. Define the thre=
shold of
> >>>>>>> time to 30s at present, maybe change to other value if not approp=
riate.
> >>>>>>>
> >>>>>>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> >>>>>>> Co-developed-by: Chenyi Qiang <chenyi.qiang@intel.com>
> >>>>>>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> >>>>>>> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> >>>>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> >>>>>>> Tested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> >>>>>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >>>>>>> ---
> >>>>>>>    qapi/qom.json                         |   8 +-
> >>>>>>>    target/i386/kvm/tdx-quote-generator.h |  82 +++++++
> >>>>>>>    target/i386/kvm/tdx.h                 |  10 +
> >>>>>>>    target/i386/kvm/kvm.c                 |   3 +
> >>>>>>>    target/i386/kvm/tdx-quote-generator.c | 300 ++++++++++++++++++=
++++++++
> >>>>>>>    target/i386/kvm/tdx-stub.c            |   4 +
> >>>>>>>    target/i386/kvm/tdx.c                 | 176 ++++++++++++++-
> >>>>>>>    target/i386/kvm/meson.build           |   2 +-
> >>>>>>>    8 files changed, 582 insertions(+), 3 deletions(-)
> >>>>>>>    create mode 100644 target/i386/kvm/tdx-quote-generator.h
> >>>>>>>    create mode 100644 target/i386/kvm/tdx-quote-generator.c
> >>>>>>
> >>>>>> These changes broke the build on 32-bit host.
> >>>>>>
> >>>>>> Could you please send a patch to avoid compiling TDX in such envir=
onment ?
> >>>>>
> >>>>> Paolo is on vacation.
> >>>>>
> >>>>> I would like to help, but I don't have 32-bit host environment on h=
and. Do
> >>>>> you know how to set up such environment quickly? (I tried to set up=
 within a
> >>>>> 32-bit VM but the 32-bit OS is too old and I didn't get it work to =
install
> >>>>> the required package for building QEMU)
> >>>>
> >>>> You should be able to use QEMU's docker containers to get yourself a
> >>>> Debian i386 container, on a x86_64 host.
> >>>
> >>> The cross-i686-system (Debian) build CI job succeeded:
> >>> https://gitlab.com/qemu-project/qemu/-/jobs/10423776600
> >>>
> >>> I wonder why the CI didn't catch the issue?
> >>
> >> It didn't build the x86_64 target:
> >>
> >>    --target-list-exclude=3D"arm-softmmu i386-softmmu microblaze-softmm=
u mips-softmmu mipsel-softmmu mips64-softmmu ppc-softmmu riscv32-softmmu sh=
4-softmmu sparc-softmmu xtensa-softmmu $CROSS_SKIP_TARGETS"
> >>
> >> so in turn didn't build any TDX code
> >
> > Here are the targets that were built by the CI job:
> >
> >    target list : avr-softmmu m68k-softmmu microblazeel-softmmu
> > or1k-softmmu rx-softmmu sh4eb-softmmu tricore-softmmu xtensaeb-softmmu
> >
> > 64-bit targets are not supported on 32-bit hosts since commit
> > acce728cbc6c ("meson: Disallow 64-bit on 32-bit emulation"). I don't
> > think the x86_64 target can be built on 32-bit hosts.
> >
> > But notice that i386-softmmu is missing from the target list. That
> > could be why the CI job succeeded.
> >
> > C=C3=A9dric: What were your ./configure options?
>
> Just :
>
>    --target-list=3Darm-softmmu,ppc-softmmu,i386-softmmu

cross-i686-tci builds i386-softmmu on debian-i686-cross with
--disable-kvm, but the TDX code isn't compiled:
https://gitlab.com/qemu-project/qemu/-/jobs/10440424393

A new CI job could be added to cover TDX on 32-bit hosts if you think
it's worthwhile. Maybe it's a corner case and not worth spending CI
cycles on?

Stefan

