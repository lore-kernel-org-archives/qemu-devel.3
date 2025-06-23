Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5F7C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 13:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTgr2-0002xK-I3; Mon, 23 Jun 2025 09:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uTgr1-0002xB-OZ
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:04:55 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uTgqx-0006cZ-Eq
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:04:55 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-60780d74c8cso6506719a12.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 06:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750683888; x=1751288688; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hB1GwDwor1lbwdCpTmF/on09VL0vbNv4OwyBpcJr7ig=;
 b=QI0JSXShjKvHZ8IaLnf6Ldunavi7FZv7idPlS7H9ca0T43dkh18ecWehi/pClEXahs
 kWgGq2tvE66WYHiMMv2S2Yg2m4aApXyUhT9amgrnsLhjAN1+iWPE3Xdj2h7Xr1TQYV+S
 DvRcNVygQPknXqThfhsMnXFxX+8LdfdxEKE2tZXH4JqC/wjaKWzfgBJcAXUTspN5r7FW
 6RVXZ3lle1zyq0B9uOmXtouwQqHm28+Gnz58SVUWh1/Yt0iT56V+nfbU/UFyKFj3mGdv
 Ce+fZHlrH4rqw6AiGqKhHDcPY67YuVc/CMxJQPsPgf8eHQ17CTpUC7c8vlmPrTZjgSgm
 2EFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750683888; x=1751288688;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hB1GwDwor1lbwdCpTmF/on09VL0vbNv4OwyBpcJr7ig=;
 b=D82ly57UcawR82Ld6oZHTgwX0PGCuVu+dXwJo8WrkwKS2j2L6mrL/JAIotjhAcXHRw
 HZ6Y6QTIVFMN2LdehIUqe3gDbqwN5z7jxAXm1QcHS5+E3NmZ7/8j16yPVDQCJbVtysYy
 Gf+sh9i1N1l/X1dWyUzpQR4BMp5PWRADyHxz2f0RWreVmQ1Ycu/9ktIWC4vbMKnFBDNe
 eLRNoHosmkqNZn7VH10qJ5zJ2Ut1JnNyXnc0EyWKTW2ltP00eDf0GDmnQjq04/zXfzDE
 Bd+uv/4cKkfaCJrsNZ+q862JCapQdCTqyJ1amLIwoSaEj1r+0qctKbzYYDFwfp7U9fWm
 XWVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIZJmdz5zL87hz6u5tMVdkdgDz/yhiPwDhX3Zspq0dDzrixGM6/N4Lr4FlBBY0BO8zzhiKeVBA37i1@nongnu.org
X-Gm-Message-State: AOJu0YyFozCWYRDlqe25SXDjrtA4n5AXCNNNHFNrjMfH4kZ9Z9PDmhPX
 XBzQTWObIblT6959bTcEw37Txrz2qxM9ZqWliDCY8+EcKEfJNmVOOlFgNvK5nCeqo7XlZXbcUIV
 z1Z8M5VVUDJPfiuIMlGZDORUxYziyWiM=
X-Gm-Gg: ASbGncsQOty9CqoqRvAFdL36shf3oz79dmrd8hWBv9Bl0zD9oC1jaR3dswzMZXcQb1A
 u0a7V8YC9ibtky08Ve1a8LYuEDG/bYj0YDasMTLAPJP9wjLRIWAwHT9E6HHZCLal+EDZNiOpJHt
 bWZvk/AvLKODe69OSZpvWB8npqEgJVzb0XQOxMMVVBrA==
X-Google-Smtp-Source: AGHT+IHCz/d1BOzwbZt9wnG+3xIkNth37vwvpC2zYpnUOkb42nLNXCzFleJpMwhroaUVWxsGru8vuB3exhBypvAuvgg=
X-Received: by 2002:a17:907:1c89:b0:ade:405:9e38 with SMTP id
 a640c23a62f3a-ae057abd271mr1169305666b.24.1750683886597; Mon, 23 Jun 2025
 06:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250620164053.579416-1-pbonzini@redhat.com>
 <20250620164053.579416-25-pbonzini@redhat.com>
 <b8171c39-6a92-4078-a59a-a63d7452e1e9@kaod.org>
 <4ffdb62b-8fe4-4b34-9efa-aecff7f8e77b@intel.com>
 <aFkKL-TQTcrBtXuK@redhat.com>
In-Reply-To: <aFkKL-TQTcrBtXuK@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 23 Jun 2025 09:04:33 -0400
X-Gm-Features: AX0GCFsUUr5X3M1CJ-v5EzDGJGE7FdqJfojKssymHnPO8hATHggOCn5FO3BzMAA
Message-ID: <CAJSP0QUgirgNX71MwGgYbdDhVUrd3MWsetx66_+GsER8BfoSbg@mail.gmail.com>
Subject: Re: [PULL 24/24] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x532.google.com
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

On Mon, Jun 23, 2025 at 4:04=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Mon, Jun 23, 2025 at 03:03:19PM +0800, Xiaoyao Li wrote:
> > On 6/23/2025 2:43 PM, C=C3=A9dric Le Goater wrote:
> > > Hello,
> > >
> > > On 6/20/25 18:40, Paolo Bonzini wrote:
> > > > From: Isaku Yamahata <isaku.yamahata@intel.com>
> > > >
> > > > Add property "quote-generation-socket" to tdx-guest, which is a pro=
perty
> > > > of type SocketAddress to specify Quote Generation Service(QGS).
> > > >
> > > > On request of GetQuote, it connects to the QGS socket, read request
> > > > data from shared guest memory, send the request data to the QGS,
> > > > and store the response into shared guest memory, at last notify
> > > > TD guest by interrupt.
> > > >
> > > > command line example:
> > > >    qemu-system-x86_64 \
> > > >      -object '{"qom-type":"tdx-guest","id":"tdx0","quote-generation=
-
> > > > socket":{"type":"unix", "path":"/var/run/tdx-qgs/qgs.socket"}}' \
> > > >      -machine confidential-guest-support=3Dtdx0
> > > >
> > > > Note, above example uses the unix socket. It can be other types,
> > > > like vsock,
> > > > which depends on the implementation of QGS.
> > > >
> > > > To avoid no response from QGS server, setup a timer for the transac=
tion.
> > > > If timeout, make it an error and interrupt guest. Define the thresh=
old of
> > > > time to 30s at present, maybe change to other value if not appropri=
ate.
> > > >
> > > > Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > > > Co-developed-by: Chenyi Qiang <chenyi.qiang@intel.com>
> > > > Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> > > > Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > Tested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > > ---
> > > >   qapi/qom.json                         |   8 +-
> > > >   target/i386/kvm/tdx-quote-generator.h |  82 +++++++
> > > >   target/i386/kvm/tdx.h                 |  10 +
> > > >   target/i386/kvm/kvm.c                 |   3 +
> > > >   target/i386/kvm/tdx-quote-generator.c | 300 +++++++++++++++++++++=
+++++
> > > >   target/i386/kvm/tdx-stub.c            |   4 +
> > > >   target/i386/kvm/tdx.c                 | 176 ++++++++++++++-
> > > >   target/i386/kvm/meson.build           |   2 +-
> > > >   8 files changed, 582 insertions(+), 3 deletions(-)
> > > >   create mode 100644 target/i386/kvm/tdx-quote-generator.h
> > > >   create mode 100644 target/i386/kvm/tdx-quote-generator.c
> > >
> > > These changes broke the build on 32-bit host.
> > >
> > > Could you please send a patch to avoid compiling TDX in such environm=
ent ?
> >
> > Paolo is on vacation.
> >
> > I would like to help, but I don't have 32-bit host environment on hand.=
 Do
> > you know how to set up such environment quickly? (I tried to set up wit=
hin a
> > 32-bit VM but the 32-bit OS is too old and I didn't get it work to inst=
all
> > the required package for building QEMU)
>
> You should be able to use QEMU's docker containers to get yourself a
> Debian i386 container, on a x86_64 host.

The cross-i686-system (Debian) build CI job succeeded:
https://gitlab.com/qemu-project/qemu/-/jobs/10423776600

I wonder why the CI didn't catch the issue?

Stefan

