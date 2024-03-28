Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0A5C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 14:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpqgl-00084z-EI; Thu, 28 Mar 2024 10:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rpqgg-00084J-W4
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:25:03 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rpqge-0008Qc-S3
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:25:02 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-29b7164eef6so836274a91.2
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 07:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1711635899; x=1712240699; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4IRasTilP2oTqS/RMUvzxI7kIcw6mJ+Dh562x7zpG4w=;
 b=JicMZkW5BWhX4fW1GGODRo9261lcXiSoEKF/N3Oj76i3rlZjcsHc1K0FS3YhyoOzkk
 VpDgzmfv4iflFRO5iSiB2xJZAILl9m84nIzW37Q7ISiKIFaTDaTQpCAm1Rjad3qqLqF9
 w4sS5IuzAryGpJ77iXu/RZhrtnQY51QqZptxyOsN13p+2VvYhOAqxzK0jLGDVfrHEapf
 wsnzhe8tXIE5XiUdO7ByMimRRyfp/zRBADGbBh6yK8fjobSkKzyRyFRixSzKb+NP9+AS
 +SL3DEQMtDUidGLxmGXCJTak03pG+BPUMyhPjkkQ44V0BbeTeXrSHnjFmrDyusJqMMBP
 oonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711635899; x=1712240699;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4IRasTilP2oTqS/RMUvzxI7kIcw6mJ+Dh562x7zpG4w=;
 b=tOvYuurFjQ1WziThtNuyk1QB8uqYmd11QEL2DndH5fexDyNzGyxKmnZfQ1oDuSJmnW
 zYEyhn79XNkGDGZMljmnYbUA+BhOdgvRUODkbFot/H2zV2uqFUny9bMJ+zBjRwwYCZVL
 zaLGlaxwTGFdRGS70kpFPWBR2igchp81pFIzcczyRYjbJe2SQ3gW3VeN0bxlpDj+Xnu7
 KJFw6dVk57cmAcIN/mCVNMolD9XRtz2w6KqNYc1LUB4zw5p8WIQSTkJQXgfQ3/+YLVhD
 VeJEPhScd8wWuRQPhJ1iZV/ggiLNfq2SLW2A3j6riq8miBs3tLsehMSoZ6SNfaAWtWRw
 s+zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF2PnBUqEWgTOvaSivIGcobzOLFC5OLcD5Pd5UCGgmDmCCQRnGpiyIFTApb1GYdix5pz/jjQH3DpLQg/zRf6ln5B3KVtQ=
X-Gm-Message-State: AOJu0YyY4uLVSUmpeXjY1X8p/VlUUczseeRtOsTCXZ61Cvy6vLgVyp+1
 m7Aplfd9GGz5iA2tEShUm6C7s4SRHTyACo6MvC5kzZDaf0cKQO27yfzkmcAVvRYAmnQiHRVDD7h
 AkqVEoOfojnSORmHCGcupa8m8UZmaFWnn+qKYVg==
X-Google-Smtp-Source: AGHT+IGEKkXys88TdvdTAoCJXBJzfaAcn9iKKZiEN/4BDYsx/Jq1YLq1e2haflRN0iCScvWuyXLczzT0RwHFwQbzs5o=
X-Received: by 2002:a17:90b:4f81:b0:29b:307a:d5ed with SMTP id
 qe1-20020a17090b4f8100b0029b307ad5edmr2824257pjb.10.1711635898969; Thu, 28
 Mar 2024 07:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240204054228.651-1-zhiwei_liu@linux.alibaba.com>
 <20240204054228.651-3-zhiwei_liu@linux.alibaba.com>
 <CAKmqyKNGMjLg+JjJZAp+EsmfaWAyT7XiHZzBXZxeghS0hv6REg@mail.gmail.com>
 <CAEg0e7i6zaEhyfhRFKcTYjkCqRCzJ5eB+0EHUDVA6t-ypL78eg@mail.gmail.com>
 <CAKmqyKPgAQ4JaSNRmFfR-=w3daDkag-ORz0Ckn7r1JNmf8X2oA@mail.gmail.com>
 <20240327-overrun-outcast-795708a30e8c@spud>
 <CAKmqyKP8kE=BDv2NzLeU+B3WNMJyke41__yOdVVcwe7k=9wpwA@mail.gmail.com>
In-Reply-To: <CAKmqyKP8kE=BDv2NzLeU+B3WNMJyke41__yOdVVcwe7k=9wpwA@mail.gmail.com>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Thu, 28 Mar 2024 15:24:47 +0100
Message-ID: <CAEg0e7g68Y1+26T=6iTcqfe3suXP0N3D5uyp87D+yJWuCE-1Rg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] target/riscv: Support xtheadmaee for thead-c906
To: Alistair Francis <alistair23@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-devel@nongnu.org, Alistair.Francis@wdc.com, palmer@dabbelt.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 qemu-riscv@nongnu.org, bjorn@kernel.org, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Mar 28, 2024 at 2:19=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Wed, Mar 27, 2024 at 9:19=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > Christoph linked here on his submission to Linux of a fix for this, so =
I
> > am reviving this to leave a couple comments :)
> >
> > On Thu, Feb 15, 2024 at 02:24:02PM +1000, Alistair Francis wrote:
> > > On Mon, Feb 5, 2024 at 6:37=E2=80=AFPM Christoph M=C3=BCllner
> > > <christoph.muellner@vrull.eu> wrote:
> > > > On Mon, Feb 5, 2024 at 3:42=E2=80=AFAM Alistair Francis <alistair23=
@gmail.com> wrote:
> > > > > On Sun, Feb 4, 2024 at 3:44=E2=80=AFPM LIU Zhiwei <zhiwei_liu@lin=
ux.alibaba.com> wrote:
> >
> > > > > >              ppn =3D (pte & (target_ulong)PTE_PPN_MASK) >> PTE_=
PPN_SHIFT;
> > > > >
> > > > > Unfortunately we won't be able to take this upstream. This is cor=
e
> > > > > QEMU RISC-V code that is now being changed against the spec. I th=
ink
> > > > > adding the CSR is fine, but we can't take this core change.
> > > > >
> > > > > A fix that works for everyone should be supporting the th_mxstatu=
s
> > > > > CSR, but don't support setting the TH_MXSTATUS_MAEE bit. That way
> > > > > guests can detect that the bit isn't set and not use the reserved=
 bits
> > > > > in the PTE. From my understanding the extra PTE bits are related =
to
> > > > > cache control in the hardware, which we don't need here
> > > >
> > > > Sounds good! Let me recap the overall plan:
> > > > * QEMU does not emulate MAEE, but signals that MAEE is not availabl=
e
> > > > by setting TH_MXSTATUS_MAEE to 0.
> > >
> > > Yep!
> > >
> > > > * Consequence: The c906 emulation does not enable any page-base mem=
ory
> > > > attribute mechanism.
> > >
> > > Exactly
> > >
> > > > * OpenSBI tests the TH_MXSTATUS_MAEE bit (M-mode only) and provides
> > > > that information to user-space (e.g. DTB).
> > >
> > > To the kernel, but yep!
> > >
> > > > * The current Linux errata code will be enhanced to not assume MAEE
> > > > for each core with T-Head vendor ID, but also query the MAEE bit an=
d
> > > > ensure it is set.
> > >
> > > I feel like it should already do that :)
> >
> > It doesn't quite do this right now. It only makes the assumption for
> > CPUs where marchid and mvendorid are zero. The c908, and I think Guo Re=
n
> > confirmed it will be the case going forward, sets these to non-zero
> > values. We should have always required a dt property be set, rather tha=
n
> > using m*id, but we can't go back on that for these devices. Going
> > forward, if there are more CPUs that want to use this e.g. C908 in MAEE
> > mode (it can do svpbmt too) I'm gonna require it is explicitly set in
>
> A DT node that we don't set also works fine for us

I would really like to do that, but given the page table is set up so
early in the boot process
probing via CSR is much easier to realize in the kernel than parsing the DT=
.
Therefore, I think th.sxstatus emulation + probing is the best way to
move forward.

Thanks,
Christoph

