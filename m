Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CC0CAC5BB
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 02:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6gh9-0002Jv-UL; Wed, 08 Oct 2025 22:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v6gh8-0002Je-NL
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 22:47:54 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v6gh6-0001AP-IB
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 22:47:54 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6349e3578adso875406a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 19:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759978070; x=1760582870; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KBDPu9U8rfqI59tDQ9okmWRueZVMy9I/82Szwtb82IE=;
 b=NprnpO5QzrlGrDZC1mGfWtdv+nSXDVwCIhW/vscSAq4Rd2p1y5Q8sRw1/WBOmTCoaD
 2sCjsxNFtIEZZkw/LQVYLzoVt49ZAN3A0gODfa1Ve8NWnivUyp7qpWIul198WCjxwa7O
 jiUrtaPWlYiXBIDYwbAcmdQbkexV0bW2z4CZAJhgZBfiGnpCOYhHevjAoyMowt+HDAag
 h/zSx/+f5t23xT32PgYX4qqVw9QtltKqsPp1ntWf6H4z0qYYE+PLuJK2vS7x32h1cdBu
 +lcuDOrMtMpTZoVLdgYuGLxslnbckVODtIgQ7yxCoRxLet5Txln5iN66XV5ZW+BuHH1D
 IEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759978070; x=1760582870;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KBDPu9U8rfqI59tDQ9okmWRueZVMy9I/82Szwtb82IE=;
 b=k6IfgDQeEVrIJx9nAFkhE65YUSnEOYHlv8wRq6DZzACMWgIDDD2ATGSOYT2jGljOSS
 u47+cVU+j5Dq9+gGfUH1cUqYs1AFGAVbX7pAc3xXf6Hdf7i6Csl+4fK3yljW6Eg21//g
 P4ktGk13dJlzUHQqYnLsQl8vJ9Q2ZXvWF82jJTU8b0fKBLQQV/Of4ZE14KBmZDPBAhBW
 T78BKGvO6l1ATtfbAhJpuYVHR6pk5K6oLcv2dHn+NGCyRoVfzRMs1wFbAoDI4BqAfzgz
 E9awBSuWDttRen2hIofN+Gs9VSu6DllLoadzIHWJ1ZF2YSfK3wakaYPr2pmZuPCA6E1M
 XWXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhQV5eRcfWY1/JRYdYoyzCWkkZyt9TejdBCbs8B4KnrTr8B3SLqkeSQ/qibr15MPV+ai/+2bMFwB6j@nongnu.org
X-Gm-Message-State: AOJu0YwGg64gs8gt2VttgPpZgUAtshycURVE3a1q7H9cYaWg1nJ64iwJ
 5SD0A+JakqVMsTfmo8mXvHQAm+XkWAPIp2W3DqhfTac7DUbr5oNfR5jQIIqok93C7ZFchr/9+Id
 zsUQzNOYBSBMk49SPHxCgDLQllKhOZgU=
X-Gm-Gg: ASbGncurY2r+gmDhCVLnctjpus7IzPdzubV4rYyYtT8PNlXfOLWCA2jJWaIjetlMwSk
 ICFA8R+TLFUw0z6QYKEncR3UFD3g6VBAv437XTjyKuFoFGnUQZPZ5L8oExt2PR/b2yktUb4j4Ov
 zNEL/rv5sofEFUPEkusPi6vebGRQjEGYz9Xs3StEA3UMb5l5sn8xtrCl/dCl/EVc+IagvrNlZ1X
 44+wPcXf2PFT+DD3WtUPJu7RJldT2ub0fHhwZaLn61Go0TXfemrIVux/3rpEg==
X-Google-Smtp-Source: AGHT+IGM7mdq1YVGPMwSbLlX7rwmbFNl9vmsFGK1fNnJgnsoX19DKOjNkaCL9ekVB5FAFfYpwx+GRyZuM43nZRR1Hfk=
X-Received: by 2002:a05:6402:34d5:b0:632:4e65:d2da with SMTP id
 4fb4d7f45d1cf-639d5c75d6fmr5498580a12.35.1759978069916; Wed, 08 Oct 2025
 19:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20251003113945.87962-2-wilfred.opensource@gmail.com>
 <aOTJ2QLZhaLJl3-3@AALNPWKJENSEN.aal.scsc.local>
In-Reply-To: <aOTJ2QLZhaLJl3-3@AALNPWKJENSEN.aal.scsc.local>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Oct 2025 12:47:23 +1000
X-Gm-Features: AS18NWABcdw8oycQTqSl78N86ItTee6Gz74NUbObzQzKSGkz-ly13tO96LAaHnM
Message-ID: <CAKmqyKMwN8tA9YnSjteet+sd5DgQbD4PSyj0ZMFy3AL_qMgyOw@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] NVMe: Add SPDM over the storage transport support
To: Klaus Jensen <its@irrelevant.dk>
Cc: Wilfred Mallawa <wilfred.opensource@gmail.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Keith Busch <kbusch@kernel.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, qemu-devel@nongnu.org, 
 qemu-block@nongnu.org, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Oct 7, 2025 at 6:06=E2=80=AFPM Klaus Jensen <its@irrelevant.dk> wro=
te:
>
> Alistair,
>
> I'm ready to merge this. Are you OK with me sending the pull request
> including the SPDM changes, or do you want to take that part through
> your tree?

Great!

Please go ahead and send the pull request including the SPDM changes.
Keeping it all together is much simpler.

Alistair

>
> On Oct  3 21:39, Wilfred Mallawa wrote:
> > From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> >
> > This series extends the existing SPDM support in QEMU to support the DS=
P0286
> > SPDM Storage Transport [1] for NVMe. SPDM Storage Transport uses the NV=
Me
> > Admin Security Send/Receive commands, as such, support for these comman=
ds have
> > also been added.
> >
> > With the addition of a new `spdm-trans` CLI argument for NVMe controlle=
rs,
> > users can specify `spdm_trans=3Dnvme` or `spdm_trans=3Ddoe`. This allow=
s for the
> > selection of the SPDM transport. The `doe` option is the current defaul=
t,
> > `nvme` would select SPDM Storage Transport for the controller, where SP=
DM
> > communication happens over the NVMe Admin Security Send/Receive command=
s.
> >
> > Support for DSP0286 already exists in `libspdm` [2] and support for the=
 QEMU
> > SPDM server is being upstreamed for `spdm-utils` [3]. This series was t=
ested by
> > using `spdm-utils` as the qemu SPDM server with SPDM Storage Transport =
support
> > built with `libspdm` v3.8.0, and `spdm-utils` also as the SPDM requeste=
r.
> >
> > Changes V1 -> V2:
> >       - spdm_socket_rsp() now uses the new spdm_socket_send/receive()
> >        functions. spdm_socket_command_valid() is added to parse the
> >        command value incase some bytes were received (result =3D true) =
but
> >        with an invalid command.
> >
> >       - Added inline comments to describe fields of
> >        StorageSpdmTransportHeader. Checkpatch generates warnings, but l=
ots of
> >        existing code does this. The QEMU_PACKED attribute now follows t=
he
> >        StorageSpdmTransportHeader struct definition.
> >
> >       - Use extract32() instead of manual shifting/masking in
> >        nvme_sec_prot_spdm_send/recv().
> >
> >       - Use g_autofree for send/recv buffer allocation
> >        in nvme_sec_prot_spdm_send/recv().
> >
> >       - Added explicit fallthrough comment for checking `secp` in
> >        nvme_security_receive()
> >
> >       - Added enum support for SPDM transport type, such that a user de=
fined
> >        transport type string, can be mapped to the respective enum for
> >        internal use.
> >
> > Changes V2 -> V3:
> >       - Fixed up the incorrect use of `NVME_NO_COMPLETE` to more approp=
riate
> >        NVMe error codes in Patch [3/5]. Note that DSP0286 does not defi=
ne
> >        error codes for transport level failures.
> >
> >       - Removed NULL check for g_malloc0(). Should abort instead.
> >
> > Changes V3 -> V4:
> >     - Added integer overflow and MDTS checking for spdm_sends
> >     - Use g_try_malloc0() over g_malloc0()
> >     - Fixed up endian conversion for command status received from
> >       the server.
> >     - Added check to only accept SPDM send/receive if the socket
> >       has been setup.
> >     - Only show SPDM as a supported protocol if the socket
> >       has been setup.
> >
> > Changes V4 -> V5:
> >     - Init spdm_socket fd to -1 for NVMe. Allow 0 to be a valid file de=
scriptor
> >       for the socket.
> >     - Move transport definitions to the patches they are used in.
> >     - Avoid splitting SPSP0/SPSP1. Use a uint16 instead.
> >     - Fixup up incorrect (uint8_t *) casting in calls to
> >       spdm_socket_receive/send().
> >     - Default to SPDM over DoE if transport is not specified.
> >     - Fixup alignment (style).
> >
> > Changes V5 -> V6:
> >     - Minor comment style fixup for the description of StorageSpdmTrans=
portHeader
> >     - Change spdm_socket_rsp() to directly return spdm_socket_receive()
> >
> > Changes V6 -> V7:
> >     - Added an assert() to check that only one spdm socket was setup in
> >       nvme_exit().
> >     - Merged spdm_socket_close() calls into an else if for DoE/NVMe.
> >
> > Changes V7 -> V8:
> >     - Added specification references for StorageSpdmTransportHeader
> >
> > Wilfred Mallawa (5):
> >   spdm-socket: add seperate send/recv functions
> >   spdm: add spdm storage transport virtual header
> >   hw/nvme: add NVMe Admin Security SPDM support
> >   spdm: define SPDM transport enum types
> >   hw/nvme: connect SPDM over NVMe Security Send/Recv
> >
> >  backends/spdm-socket.c       |  79 +++++++++--
> >  docs/specs/spdm.rst          |  10 +-
> >  hw/nvme/ctrl.c               | 257 +++++++++++++++++++++++++++++++++--
> >  hw/nvme/nvme.h               |   5 +
> >  include/block/nvme.h         |  15 ++
> >  include/hw/pci/pci_device.h  |   2 +
> >  include/system/spdm-socket.h |  65 ++++++++-
> >  7 files changed, 404 insertions(+), 29 deletions(-)
> >
> > --
> > 2.51.0
> >
> >

