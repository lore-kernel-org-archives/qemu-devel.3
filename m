Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF4EC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 03:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj7lT-0001hu-AT; Sun, 12 Jul 2026 23:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wj7lR-0001hd-Gl
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 23:55:29 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wj7lN-0001rk-BY
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 23:55:29 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-69532288224so4905955a12.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 20:55:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783914922; cv=none;
 d=google.com; s=arc-20260327;
 b=ce/gzn3qj5GrwsUrA05gDyEYgJbArR43jrHfvBcwPbzpUMYM7+RQesTetej2MoFUlA
 2QYrIbcGPQiq7h2FqqDC8d7pSFAPH9C9Z8c98Z2p+Dd6S9MFRSiL85RVjTxijOjORCwT
 fOgGmVJLBD8WbVfFkS53QAILCgqsoicadXDObjOfoMmnOARV9uqzluDkAkeJQ9stSMHf
 Pps1/HMxucSC2U2W46Pb9UqOUztVOm7o7ABgFiFRdFzTM51q4v9ew1dNX+SqqasGwj9b
 qlCza8fPzv69/IXQkmTr/3KOxjJbrTxbGQHb1MJgROdzl+7KFubEvDeo4sAM9Ugpw0/x
 nilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=enZRM52KwBUjwK6NVbj8LRRqgUdPuNqOKPo8kpNe0U8=;
 fh=3CWwe2/2qe+etgt7/ZYRkyynIjv9klKjcmNFgO3N5zQ=;
 b=p1KPs1Ol0qNOLiUFaiYN+kH03juzhoQJhydP5lZ7Z4wk0GsIRMMOmj9jMUZD3jr4eR
 sQQB6wP8gw99I9VJAoUSKdvy6zs2hZYuwNWx0sDYa8ZDeZSsvk1mXzi+nnpQD9zaygZp
 YmD0Vm10gPaB4iqe+GiQdXRuNYnjKe/3RCdeGKR6mbi3DRq3OvW5ViWRx3yrtPDADSvX
 ZSfltG0yeXs69jphrgRvkU2fKJESZmizA9mDap6bUkHHnkrbzqEpara/NTmsY1HtO6MM
 SDAyHKdy6EY783ZnPAT1qTm7oe7T1FFZcI9hXN+B8ZjqiLElZqlRBTvf8qdG2UHnfWL6
 YetQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783914922; x=1784519722; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=enZRM52KwBUjwK6NVbj8LRRqgUdPuNqOKPo8kpNe0U8=;
 b=C9XVCkDpRe3xP92MEzDsq8Wkww7rsRv3MO2ZXWYpZ/KA70KYTy9RYzVuwl1kBkWglN
 Q5AM8f5wDL3QMqVHtbvJQJWq1swFTgVI4wbIE0cLwyPmYPWFbkAnCs2qei7OL0olJjW4
 oWOHRZ4XCeItoFaYkj1gBjzvqmPsM80zKDjQo83kcGv+YuqKV6IQvf0ndJe52+GsG9hw
 aYKKjT2OQoOy161+wkB7Fi90wE7qvmO+vK3FT5/QBo8V4lCaGqEM1nETiccV08HyMnfy
 WjmqMJXG8iiaLb1IihVwVU7auhLQC8hMI5lgbEZawHK0SmKggkUVs5xjIe6qtRfVeXm/
 4B0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783914922; x=1784519722;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=enZRM52KwBUjwK6NVbj8LRRqgUdPuNqOKPo8kpNe0U8=;
 b=qgnxnvPuPTQnmnTRI7GxWakXiLF119Q+IWwpL+sTthWba5rJNV5DxM5Cakn1XQu//Z
 nPO78n6qgQg0xAKFh/ZNqU/PYKSznG6EsG82Y8OdSd73SOe3PVk+VUfjKmUHxjDA+oub
 Eh4UcnfzbPQFzr2C+qzmdQSDMEVbi+E3B2irrwfXCLUHibn8v8F/2gne9+HeVnq3A24i
 su33Ca/IgVGkVnNYUr3ICQfgoY7mXLbeFrpLnpBnD2vJrnW8WKfyI3I05J4QNvgqZu6z
 QfESz9duCx7lzjThOVx2xsCHRk5/9jwFOPwuEkqBN5LF1H0zNKwNCkNtG8GWRWTZRR41
 S0qQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5CXE1Cp5lkVEQlcuEMHsdaGCtyA0np7siW2L4qSoVIOXt8gRBI4sxiyxK35zfLJ62vljbcntCpsKL@nongnu.org
X-Gm-Message-State: AOJu0YwMIqLHjb+0yG996dr+9fZUSNZn2eRhOlitMky9Hyn7pY+zRBWW
 U9dTrA4NOtiwLAn38VQ/un9i5CpsD/c6ablzawcluQ0DDdwiLBgYGtxoIF55rSxQTSKKg+lEIkD
 5j4GoAvWVcbpbeKQK9/PhCv2nAMTUSCkftME0WK9cQQ==
X-Gm-Gg: AfdE7cn5iSfPeYhd8pQS6aWk0rHLCs3tBnQPj41CHZ50NsW2IcbOnx98BoJgulDWB0R
 UCTkT8qTLojeEu4SZs2W6QAgGRc+y7v3DfS2W1EWyQa+AbXawYGUBwUstUj+dXZxW2S4ab/UOrm
 fkHskxy7XscG+cdZgb+e8auAyvKOXhuYDzBoEWSDXgQSx39TJ0AFUtZwTqaCur662/VL9AV9XPJ
 HbXJ0FquRvJ+E1rcFcwA4zdZSh5Oo6FvNmUAO0bFyaCE4Cgpb+lyzXcoC0iVbbL0xKCgcvTpJo=
X-Received: by 2002:a17:906:6a0f:b0:c12:a16f:6864 with SMTP id
 a640c23a62f3a-c161f36d23dmr306194966b.48.1783914921781; Sun, 12 Jul 2026
 20:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260707091039.2574638-1-frank.chang@sifive.com>
 <CAKmqyKNVo-rdOtN0t9XzRB3teF6nNEgh_twkf9s8zX2q0dPU=w@mail.gmail.com>
 <CAE_xrPiD1d8jRfz9fcjZaNGEp1uuDn8PMO-=RzMLipt3CnBGPw@mail.gmail.com>
 <55cce2d7f992ac95719f04b6b8d8923c95900df5.camel@wdc.com>
 <CAE_xrPirgG8eN8O8njdP8_pqjEQUBdmAmRjNZ=G+9G-jj_qcew@mail.gmail.com>
 <5e049bf829be888454d95c8817c029e285fbc3fe.camel@wdc.com>
In-Reply-To: <5e049bf829be888454d95c8817c029e285fbc3fe.camel@wdc.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Mon, 13 Jul 2026 11:55:10 +0800
X-Gm-Features: AUfX_mzkt7knaSUr_yX-v8nSns-DghAob-lb5pjp2y3o6pAjXY0HhDT-7p41Kds
Message-ID: <CAE_xrPgS8j22nCUmWpZY9UsOb_o=ayo9woJ4qVEHm9EWucG+vQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] target/riscv: Support the true Zicclsm extension
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>, 
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, 
 "liwei1518@gmail.com" <liwei1518@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000003903570656760f0c"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=frank.chang@sifive.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
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

--0000000000003903570656760f0c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 7:48=E2=80=AFAM Alistair Francis <Alistair.Francis@=
wdc.com>
wrote:

> On Sun, 2026-07-12 at 17:24 +0800, Frank Chang wrote:
> > On Fri, Jul 10, 2026 at 7:23=E2=80=AFPM Alistair Francis
> > <Alistair.Francis@wdc.com> wrote:
> > > On Fri, 2026-07-10 at 12:39 +0800, Frank Chang wrote:
> > > > On Thu, Jul 9, 2026 at 12:58=E2=80=AFPM Alistair Francis
> > > > <alistair23@gmail.com> wrote:
> > > > > On Tue, Jul 7, 2026 at 7:11=E2=80=AFPM <frank.chang@sifive.com> w=
rote:
> > > > > >
> > > > > > From: Frank Chang <frank.chang@sifive.com>
> > > > > >
> > > > > > Support the true Zicclsm extension so that we can trap
> > > > > > misaligned
> > > > > > accesses
> > > > > > when Zicclsm is disabled.
> > > > > >
> > > > > > To enable/disable Zicclsm, simply set zicclsm=3D[true|false],
> > > > > > e.g.:
> > > > > >    -cpu rv64,zicclsm=3D[true|false]
> > > > > >
> > > > > > QEMU will raise a misaligned load/store exception when
> > > > > > executing
> > > > > > misaligned
> > > > > > load/store instructions if Zicclsm is disabled.
> > > > > >
> > > > > > Changelog:
> > > > > >    v4:
> > > > > >      * Align ROM reset vector data at 8-byte aligned offsets.
> > > > > >    v3:
> > > > > >      * Enable Zicclsm for the compatible CPUs.
> > > > > >      * Rebase to the latest riscv-to-apply.next.
> > > > > >    v2:
> > > > > >      * Use (size_memop(size) | mo_endian_env(env)) to
> > > > > > calculate
> > > > > > MemOp.
> > > > > >      * Use (log2_esz << MO_ASHIFT) to calculate aligment
> > > > > > MemOp
> > > > > > for
> > > > > >        vector load/store whole register instructions.
> > > > > >
> > > > > > Frank Chang (6):
> > > > > >    target/riscv: Add Zicclsm CPU option
> > > > > >    target/riscv: Support raising misaligned exceptions for
> > > > > > scalar
> > > > > >      loads/stores
> > > > > >    target/riscv: Support raising misaligned exceptions for
> > > > > > vector
> > > > > >      loads/stores
> > > > > >    target/riscv: Enable Zicclsm for the compatible CPUs
> > > > > >    hw/riscv: sifive_u: Align ROM reset vector data
> > > > > >    target/riscv: Update Zicclsm ISA string and expose it as a
> > > > > > CPU
> > > > > >      property
> > > > >
> > > > > Hmmm.... Still seeing failures
> > > > >
> > > > > 556/556 qemu:func-quick+func-riscv64 / func-riscv64-opensbi
> > > > >                TIMEOUT         90.02s   killed by signal 15
> > > > > SIGTERM
> > > > > > > > LD_LIBRARY_PATH=3D/var/mnt/scratch/alistair/software/qemu/b
> > > > > > > > uild
> > > > > > > > /contrib/plugins:/var/mnt/scratch/alistair/software/qemu/
> > > > > > > > buil
> > > > > > > > d/tests/tcg/plugins MSAN_OPTIO
> > > > > NS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print=
_stack
> > > > > trac
> > > > > e=3D1
> > > > > QEMU_TEST_QEMU_BINARY=3D/var/mnt/scratch/alistair/software/qemu/b
> > > > > uild
> > > > > /qemu-system-riscv
> > > > > 64 RUST_BACKTRACE=3D1
> > > > > MESON_BUILD_ROOT=3D/var/mnt/scratch/alistair/software/qemu/build
> > > > > UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summar=
y=3D1:
> > > > > prin
> > > > > t_stac
> > > > > ktrace=3D1
> > > > > ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=
=3D1
> > > > > MESON_TEST_ITERATION=3D1 MALLOC_PERTURB_=3D7
> > > > > QEMU_TEST_QEMU_IMG=3D/var/mnt/scratch/alistair
> > > > > /software/qemu/build/qemu-img QEMU_TEST_GDB=3D/usr/bin/gdb
> > > > > PYTHONPATH=3D/var/mnt/scratch/alistair/software/qemu/python:/var/
> > > > > mnt/
> > > > > scratch/alistair/software/qemu/t
> > > > > ests/functional
> > > > > /var/mnt/scratch/alistair/software/qemu/build/pyvenv/bin/python
> > > > > 3
> > > > > /var/mnt/scratch/alistair/software/qemu/tests/functional/riscv6
> > > > > 4/te
> > > > > st_opens
> > > > > bi.py
> > > > >
> > > > >
> > > > > Summary of Failures:
> > > > >
> > > > > 556/556 qemu:func-quick+func-riscv64 / func-riscv64-opensbi
> > > > >       TIMEOUT         90.02s   killed by signal 15 SIGTERM
> > > > >
> > > > >
> > > >
> > > >
> > > > Hi Alistair,
> > > >
> > > > That's weird.
> > > >
> > > > I ran:
> > > > $ meson test -C build qemu:func-riscv64-opensbi -v --print-
> > > > errorlog
> > > >
> > > > .....
> > > >
> > > > =E2=96=B6 1/1 test_opensbi.RiscvOpenSBI.test_riscv_sifive_u        =
    OK
> > > >
> > > >
> > > > =E2=96=B6 1/1 test_opensbi.RiscvOpenSBI.test_riscv_spike           =
    OK
> > > >
> > > >
> > > > =E2=96=B6 1/1 test_opensbi.RiscvOpenSBI.test_riscv_tt_atlantis     =
    OK
> > > >
> > > >
> > > > =E2=96=B6 1/1 test_opensbi.RiscvOpenSBI.test_riscv_virt            =
    OK
> > > >
> > > >
> > > > 1/1 func-quick+func-riscv64 - qemu:func-riscv64-opensbi        OK
> > > >
> > > >          1.53s   4 subtests passed
> > > >
> > > >
> > > > Ok:                1
> > > > Fail:              0
> > > >
> > > > func-riscv64-opensbi test passed.
> > > >
> > > > However, I did find another issue when I ran:
> > > > $ meson test -C build "qemu:*riscv*"
> > > >
> > > > [1/9] Generating qemu-version.h with a custom command (wrapped by
> > > > meson to capture output)
> > > >  1/39 func-quick+func-riscv64 - qemu:func-riscv64-linters
> > > >
> > > >             SKIP             0.15s   0 subtests passed
> > > >  2/39 func-quick+func-riscv64 - qemu:func-riscv64-empty_cpu_model
> > > >
> > > >             OK               0.21s   1 subtests passed
> > > >  3/39 func-quick+func-riscv64 - qemu:func-riscv64-version
> > > >
> > > >             OK               0.25s   1 subtests passed
> > > >  4/39 func-quick+func-riscv32 - qemu:func-riscv32-linters
> > > >
> > > >             SKIP             0.23s   0 subtests passed
> > > >  5/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/machine-none-test
> > > >
> > > >              OK               0.17s   1 subtests passed
> > > >  6/39 func-quick+func-riscv64 - qemu:func-riscv64-info_usernet
> > > >
> > > >              OK               0.33s   1 subtests passed
> > > >  7/39 func-quick+func-riscv32 - qemu:func-riscv32-empty_cpu_model
> > > >
> > > >             OK               0.29s   1 subtests passed
> > > >  8/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/readconfig-test
> > > >
> > > >              OK               0.19s   1 subtests passed
> > > >  9/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/cdrom-test
> > > >
> > > >             OK               0.41s   1 subtests passed
> > > > 10/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/cdrom-test
> > > >
> > > >             OK               0.41s   1 subtests passed
> > > > 11/39 func-quick+func-riscv32 - qemu:func-riscv32-info_usernet
> > > >
> > > >              OK               0.31s   1 subtests passed
> > > > 12/39 func-quick+func-riscv32 - qemu:func-riscv32-version
> > > >
> > > >             OK               0.29s   1 subtests passed
> > > > 13/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/riscv-csr-test
> > > >
> > > >             OK               0.30s   1 subtests passed
> > > > 14/39 func-quick+func-riscv64 - qemu:func-riscv64-vnc
> > > >
> > > >             SKIP             0.39s   0 subtests passed
> > > > 15/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/machine-none-test
> > > >
> > > >              OK               0.15s   1 subtests passed
> > > > 16/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/readconfig-test
> > > >
> > > >              OK               0.13s   1 subtests passed
> > > > 17/39 func-quick+func-riscv32 - qemu:func-riscv32-vnc
> > > >
> > > >             SKIP             0.40s   0 subtests passed
> > > > 18/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/qmp-test
> > > >
> > > >             OK               0.54s   4 subtests passed
> > > > 19/39 func-quick+func-riscv64 - qemu:func-riscv64-migration
> > > >
> > > >             OK               0.80s   3 subtests passed
> > > > 20/39 func-quick+func-riscv32 - qemu:func-riscv32-migration
> > > >
> > > >             OK               0.77s   3 subtests passed
> > > > 21/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/qmp-test
> > > >
> > > >             OK               0.52s   4 subtests passed
> > > > 22/39 func-quick+func-riscv64 - qemu:func-riscv64-opensbi
> > > >
> > > >             OK               0.85s   3 subtests passed
> > > > 23/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/iommu-riscv-test
> > > >
> > > >             OK               0.76s   4 subtests passed
> > > > 24/39 func-quick+func-riscv32 - qemu:func-riscv32-opensbi
> > > >
> > > >             OK               0.87s   3 subtests passed
> > > > 25/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/k230-wdt-test
> > > >
> > > >              OK               1.06s   7 subtests passed
> > > > 26/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/sifive-e-aon-
> > > > watchdog-
> > > > test         OK               1.29s   10 subtests passed
> > > > 27/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/qom-test
> > > >
> > > >             OK               2.22s   8 subtests passed
> > > > 28/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/device-introspect-
> > > > test
> > > >             OK               2.28s   6 subtests passed
> > > > 29/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/device-introspect-
> > > > test
> > > >             OK               2.58s   6 subtests passed
> > > > 30/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/test-hmp
> > > >
> > > >             OK               3.26s   8 subtests passed
> > > > 31/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/netdev-socket
> > > >
> > > >              OK               3.32s   10 subtests passed
> > > > 32/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/netdev-socket
> > > >
> > > >              OK               3.30s   10 subtests passed
> > > > 33/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/qom-test
> > > >
> > > >             OK               3.80s   12 subtests passed
> > > > 34/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/test-hmp
> > > >
> > > >             OK               5.48s   12 subtests passed
> > > > 35/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/qmp-cmd-test
> > > >
> > > >             OK               8.44s   64 subtests passed
> > > > 36/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/qmp-cmd-test
> > > >
> > > >             OK               8.43s   64 subtests passed
> > > > 37/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/bios-tables-test
> > > >
> > > >             ERROR           17.02s   killed by signal 6 SIGABRT
> > > > > > > MESON_TEST_ITERATION=3D1
> > > > > > > PYTHON=3D/scratch3/yihaoc/sifive/qemu/build/pyvenv/bin/python
> > > > > > > 3
> > > > > > > QTEST_QEMU_IMG=3D./qemu-img
> > > > > > > ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_sum=
mary
> > > > > > > =3D1
> > > > > > > MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_sum=
mary
> > > > > > > =3D1:p
> > > > > > > rint_stacktrace=3D1
> > > > > > > G_TEST_DBUS_DAEMON=3D/scratch3/yihaoc/sifive/qemu/tests/dbus-
> > > > > > > daemon.sh QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-
> > > > > > > daemon/qemu-storage-daemon
> > > > > > > UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_su=
mmar
> > > > > > > y=3D1:
> > > > > > > print_stacktrace=3D1 RUST_BACKTRACE=3D1 MALLOC_PERTURB_=3D162
> > > > > > > QTEST_QEMU_BINARY=3D./qemu-system-riscv64
> > > > > > > /scratch3/yihaoc/sifive/qemu/build/tests/qtest/bios-tables-
> > > > > > > test
> > > > > > > --tap -k
> > > >
> > > > 38/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/qos-test
> > > >
> > > >             OK              43.47s   191 subtests passed
> > > > 39/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/qos-test
> > > >
> > > >             OK              43.82s   191 subtests passed
> > > >
> > > > Ok:                34
> > > > Fail:              1
> > > > Skipped:           4
> > > >
> > > > The failure is because Zicclsm is mandatory in the
> > > > RVA22U64 profile.
> > > > But before this patchset, ZIcclsm was enabled automatically when
> > > > has_priv_1_11 was true.
> > > > With this patchset, Zicclsm must be explicitly added to the
> > > > RVA22U64
> > > > profile's extension list.
> > > >
> > > > After the fix, running:
> > > > $ meson test -C build "qemu:*riscv*"
> > > >
> > > > [1/9] Generating qemu-version.h with a custom command (wrapped by
> > > > meson to capture output)
> > > >  1/41 func-quick+func-riscv64 - qemu:func-riscv64-linters
> > > >
> > > >             SKIP             0.15s   0 subtests passed
> > > >  2/41 func-quick+func-riscv64 - qemu:func-riscv64-empty_cpu_model
> > > >
> > > >             OK               0.19s   1 subtests passed
> > > >  3/41 func-quick+func-riscv64 - qemu:func-riscv64-info_usernet
> > > >
> > > >              OK               0.26s   1 subtests passed
> > > >  4/41 func-quick+func-riscv32 - qemu:func-riscv32-linters
> > > >
> > > >             SKIP             0.21s   0 subtests passed
> > > >  5/41 func-quick+func-riscv32 - qemu:func-riscv32-empty_cpu_model
> > > >
> > > >             OK               0.24s   1 subtests passed
> > > >  6/41 func-quick+func-riscv64 - qemu:func-riscv64-version
> > > >
> > > >             OK               0.30s   1 subtests passed
> > > >  7/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/cdrom-test
> > > >
> > > >             OK               0.39s   1 subtests passed
> > > >  8/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/machine-none-test
> > > >
> > > >              OK               0.17s   1 subtests passed
> > > >  9/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/cdrom-test
> > > >
> > > >             OK               0.42s   1 subtests passed
> > > > 10/41 func-quick+func-riscv32 - qemu:func-riscv32-version
> > > >
> > > >             OK               0.28s   1 subtests passed
> > > > 11/41 func-quick+func-riscv32 - qemu:func-riscv32-info_usernet
> > > >
> > > >              OK               0.32s   1 subtests passed
> > > > 12/41 func-quick+func-riscv64 - qemu:func-riscv64-vnc
> > > >
> > > >             SKIP             0.35s   0 subtests passed
> > > > 13/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/riscv-csr-test
> > > >
> > > >             OK               0.30s   1 subtests passed
> > > > 14/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/readconfig-test
> > > >
> > > >              OK               0.15s   1 subtests passed
> > > > 15/41 func-quick+func-riscv32 - qemu:func-riscv32-vnc
> > > >
> > > >             SKIP             0.33s   0 subtests passed
> > > > 16/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/machine-none-test
> > > >
> > > >              OK               0.14s   1 subtests passed
> > > > 17/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/readconfig-test
> > > >
> > > >              OK               0.14s   1 subtests passed
> > > > 18/41 func-quick+func-riscv64 - qemu:func-riscv64-migration
> > > >
> > > >             OK               0.75s   3 subtests passed
> > > > 19/41 func-quick+func-riscv32 - qemu:func-riscv32-migration
> > > >
> > > >             OK               0.78s   3 subtests passed
> > > > 20/41 func-quick+func-riscv32 - qemu:func-riscv32-opensbi
> > > >
> > > >             OK               0.84s   3 subtests passed
> > > > 21/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/iommu-riscv-test
> > > >
> > > >             OK               0.78s   4 subtests passed
> > > > 22/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/k230-wdt-test
> > > >
> > > >              OK               1.08s   7 subtests passed
> > > > 23/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/qmp-test
> > > >
> > > >             OK               1.16s   9 subtests passed
> > > > 24/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/qmp-test
> > > >
> > > >             OK               1.14s   9 subtests passed
> > > > 25/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/sifive-e-aon-
> > > > watchdog-
> > > > test         OK               1.28s   10 subtests passed
> > > > 26/41 func-quick+func-riscv64 - qemu:func-riscv64-opensbi
> > > >
> > > >             OK               1.81s   4 subtests passed
> > > > 27/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/qom-test
> > > >
> > > >             OK               2.06s   8 subtests passed
> > > > 28/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/device-introspect-
> > > > test
> > > >             OK               2.19s   6 subtests passed
> > > > 29/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/device-introspect-
> > > > test
> > > >             OK               2.48s   6 subtests passed
> > > > 30/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/test-hmp
> > > >
> > > >             OK               3.27s   8 subtests passed
> > > > 31/41 func-quick+func-riscv32 - qemu:func-riscv32-monitor_hotplug
> > > >
> > > >             OK               3.46s   7 subtests passed
> > > > 32/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/netdev-socket
> > > >
> > > >              OK               3.32s   10 subtests passed
> > > > 33/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/netdev-socket
> > > >
> > > >              OK               3.31s   10 subtests passed
> > > > 34/41 func-quick+func-riscv64 - qemu:func-riscv64-monitor_hotplug
> > > >
> > > >             OK               4.00s   7 subtests passed
> > > > 35/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/qom-test
> > > >
> > > >             OK               4.40s   13 subtests passed
> > > > 36/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/test-hmp
> > > >
> > > >             OK               6.63s   13 subtests passed
> > > > 37/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/qmp-cmd-test
> > > >
> > > >             OK               8.45s   64 subtests passed
> > > > 38/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/qmp-cmd-test
> > > >
> > > >             OK               8.50s   64 subtests passed
> > > > 39/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/bios-tables-test
> > > >
> > > >             OK              35.13s   3 subtests passed
> > > > 40/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/qos-test
> > > >
> > > >             OK              46.41s   192 subtests passed
> > > > 41/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/qos-test
> > > >
> > > >             OK              46.45s   192 subtests passed
> > > >
> > > > Ok:                37
> > > > Fail:              0
> > > > Skipped:           4
> > > >
> > > > All the tests passed.
> > > >
> > > > I will send out the v5 patchset to fix the issue.
> > > >
> > > > BTW, I noticed you ran more tests than I did.
> > > > Could you please share your test command so I can reproduce it on
> > > > my
> > > > end?
> > >
> > > I'm just running `make check`.
> > >
> > > Even your v5 is failing make check on the `target/riscv: Support
> > > raising misaligned exceptions for scalar loads/stores` patch
> > >
> >
> >
> > Hi Alistair,
> >
> > Does every single patch in the patchset need to pass `make check`, or
> > is it enough for the final patchset to pass?
>
> Every single patch needs to pass all tests and checks
>

Thanks Alistair,

I've reordered and squashed the patches so that every single patch could
pass `make check` in the v6 patchset:
https://lore.kernel.org/qemu-riscv/20260713035135.3996990-1-frank.chang@sif=
ive.com/

Regards,
Frank Chang


>
> Alistair
>

--0000000000003903570656760f0c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><span style=3D"background-color:transpare=
nt">On Mon, Jul 13, 2026 at 7:48=E2=80=AFAM Alistair Francis &lt;<a href=3D=
"mailto:Alistair.Francis@wdc.com">Alistair.Francis@wdc.com</a>&gt; wrote:</=
span></div><div class=3D"gmail_quote gmail_quote_container"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">On Sun, 2026-07-12 at 17:24 +0800, Frank=
 Chang wrote:<br>
&gt; On Fri, Jul 10, 2026 at 7:23=E2=80=AFPM Alistair Francis<br>
&gt; &lt;<a href=3D"mailto:Alistair.Francis@wdc.com" target=3D"_blank">Alis=
tair.Francis@wdc.com</a>&gt; wrote:<br>
&gt; &gt; On Fri, 2026-07-10 at 12:39 +0800, Frank Chang wrote:<br>
&gt; &gt; &gt; On Thu, Jul 9, 2026 at 12:58=E2=80=AFPM Alistair Francis<br>
&gt; &gt; &gt; &lt;<a href=3D"mailto:alistair23@gmail.com" target=3D"_blank=
">alistair23@gmail.com</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; On Tue, Jul 7, 2026 at 7:11=E2=80=AFPM &lt;<a href=3D"m=
ailto:frank.chang@sifive.com" target=3D"_blank">frank.chang@sifive.com</a>&=
gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; From: Frank Chang &lt;<a href=3D"mailto:frank.chan=
g@sifive.com" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; Support the true Zicclsm extension so that we can =
trap<br>
&gt; &gt; &gt; &gt; &gt; misaligned<br>
&gt; &gt; &gt; &gt; &gt; accesses<br>
&gt; &gt; &gt; &gt; &gt; when Zicclsm is disabled.<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; To enable/disable Zicclsm, simply set zicclsm=3D[t=
rue|false],<br>
&gt; &gt; &gt; &gt; &gt; e.g.:<br>
&gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0-cpu rv64,zicclsm=3D[true|false]<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; QEMU will raise a misaligned load/store exception =
when<br>
&gt; &gt; &gt; &gt; &gt; executing<br>
&gt; &gt; &gt; &gt; &gt; misaligned<br>
&gt; &gt; &gt; &gt; &gt; load/store instructions if Zicclsm is disabled.<br=
>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; Changelog:<br>
&gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0v4:<br>
&gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0* Align ROM reset vector data =
at 8-byte aligned offsets.<br>
&gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0v3:<br>
&gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0* Enable Zicclsm for the compa=
tible CPUs.<br>
&gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0* Rebase to the latest riscv-t=
o-apply.next.<br>
&gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0v2:<br>
&gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0* Use (size_memop(size) | mo_e=
ndian_env(env)) to<br>
&gt; &gt; &gt; &gt; &gt; calculate<br>
&gt; &gt; &gt; &gt; &gt; MemOp.<br>
&gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0* Use (log2_esz &lt;&lt; MO_AS=
HIFT) to calculate aligment<br>
&gt; &gt; &gt; &gt; &gt; MemOp<br>
&gt; &gt; &gt; &gt; &gt; for<br>
&gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0vector load/store whole=
 register instructions.<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; Frank Chang (6):<br>
&gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0target/riscv: Add Zicclsm CPU option<=
br>
&gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0target/riscv: Support raising misalig=
ned exceptions for<br>
&gt; &gt; &gt; &gt; &gt; scalar<br>
&gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0loads/stores<br>
&gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0target/riscv: Support raising misalig=
ned exceptions for<br>
&gt; &gt; &gt; &gt; &gt; vector<br>
&gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0loads/stores<br>
&gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0target/riscv: Enable Zicclsm for the =
compatible CPUs<br>
&gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0hw/riscv: sifive_u: Align ROM reset v=
ector data<br>
&gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0target/riscv: Update Zicclsm ISA stri=
ng and expose it as a<br>
&gt; &gt; &gt; &gt; &gt; CPU<br>
&gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0property<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Hmmm.... Still seeing failures<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; 556/556 qemu:func-quick+func-riscv64 / func-riscv64-ope=
nsbi<br>
&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
TIMEOUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A090.02s=C2=A0 =C2=A0killed by signa=
l 15<br>
&gt; &gt; &gt; &gt; SIGTERM<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; LD_LIBRARY_PATH=3D/var/mnt/scratch/alist=
air/software/qemu/b<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; uild<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; /contrib/plugins:/var/mnt/scratch/alista=
ir/software/qemu/<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; buil<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; d/tests/tcg/plugins MSAN_OPTIO<br>
&gt; &gt; &gt; &gt; NS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=
=3D1:print_stack<br>
&gt; &gt; &gt; &gt; trac<br>
&gt; &gt; &gt; &gt; e=3D1<br>
&gt; &gt; &gt; &gt; QEMU_TEST_QEMU_BINARY=3D/var/mnt/scratch/alistair/softw=
are/qemu/b<br>
&gt; &gt; &gt; &gt; uild<br>
&gt; &gt; &gt; &gt; /qemu-system-riscv<br>
&gt; &gt; &gt; &gt; 64 RUST_BACKTRACE=3D1<br>
&gt; &gt; &gt; &gt; MESON_BUILD_ROOT=3D/var/mnt/scratch/alistair/software/q=
emu/build<br>
&gt; &gt; &gt; &gt; UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:pr=
int_summary=3D1:<br>
&gt; &gt; &gt; &gt; prin<br>
&gt; &gt; &gt; &gt; t_stac<br>
&gt; &gt; &gt; &gt; ktrace=3D1<br>
&gt; &gt; &gt; &gt; ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:pri=
nt_summary=3D1<br>
&gt; &gt; &gt; &gt; MESON_TEST_ITERATION=3D1 MALLOC_PERTURB_=3D7<br>
&gt; &gt; &gt; &gt; QEMU_TEST_QEMU_IMG=3D/var/mnt/scratch/alistair<br>
&gt; &gt; &gt; &gt; /software/qemu/build/qemu-img QEMU_TEST_GDB=3D/usr/bin/=
gdb<br>
&gt; &gt; &gt; &gt; PYTHONPATH=3D/var/mnt/scratch/alistair/software/qemu/py=
thon:/var/<br>
&gt; &gt; &gt; &gt; mnt/<br>
&gt; &gt; &gt; &gt; scratch/alistair/software/qemu/t<br>
&gt; &gt; &gt; &gt; ests/functional<br>
&gt; &gt; &gt; &gt; /var/mnt/scratch/alistair/software/qemu/build/pyvenv/bi=
n/python<br>
&gt; &gt; &gt; &gt; 3<br>
&gt; &gt; &gt; &gt; /var/mnt/scratch/alistair/software/qemu/tests/functiona=
l/riscv6<br>
&gt; &gt; &gt; &gt; 4/te<br>
&gt; &gt; &gt; &gt; st_opens<br>
&gt; &gt; &gt; &gt; bi.py<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Summary of Failures:<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; 556/556 qemu:func-quick+func-riscv64 / func-riscv64-ope=
nsbi<br>
&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 TIMEOUT=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A090.02s=C2=A0 =C2=A0killed by signal 15 SIGTERM<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Hi Alistair,<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; That&#39;s weird.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; I ran:<br>
&gt; &gt; &gt; $ meson test -C build qemu:func-riscv64-opensbi -v --print-<=
br>
&gt; &gt; &gt; errorlog<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; .....<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; =E2=96=B6 1/1 test_opensbi.RiscvOpenSBI.test_riscv_sifive_u =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =E2=96=B6 1/1 test_opensbi.RiscvOpenSBI.test_riscv_spike =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =E2=96=B6 1/1 test_opensbi.RiscvOpenSBI.test_riscv_tt_atlant=
is =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =E2=96=B6 1/1 test_opensbi.RiscvOpenSBI.test_riscv_virt =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; 1/1 func-quick+func-riscv64 - qemu:func-riscv64-opensbi =C2=
=A0 =C2=A0 =C2=A0 =C2=A0OK<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01.53s =C2=A0 4 subtests pa=
ssed<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Ok: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01=
 =C2=A0 <br>
&gt; &gt; &gt; Fail: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; func-riscv64-opensbi test=C2=A0passed.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; However, I did find another issue when I ran:<br>
&gt; &gt; &gt; $=C2=A0meson test -C build &quot;qemu:*riscv*&quot;<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; [1/9] Generating qemu-version.h with a custom command (wrapp=
ed by<br>
&gt; &gt; &gt; meson to capture output)<br>
&gt; &gt; &gt; =C2=A01/39 func-quick+func-riscv64 - qemu:func-riscv64-linte=
rs =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKIP =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.15s =C2=A0 0 subtests passed<br>
&gt; &gt; &gt; =C2=A02/39 func-quick+func-riscv64 - qemu:func-riscv64-empty=
_cpu_model<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.21s =C2=A0 1 subtests passed<br>
&gt; &gt; &gt; =C2=A03/39 func-quick+func-riscv64 - qemu:func-riscv64-versi=
on =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.25s =C2=A0 1 subtests passed<br>
&gt; &gt; &gt; =C2=A04/39 func-quick+func-riscv32 - qemu:func-riscv32-linte=
rs =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKIP =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.23s =C2=A0 0 subtests passed<br>
&gt; &gt; &gt; =C2=A05/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/machine-=
none-test<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.17s =C2=A0 1 subtests passed<br=
>
&gt; &gt; &gt; =C2=A06/39 func-quick+func-riscv64 - qemu:func-riscv64-info_=
usernet =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.33s =C2=A0 1 subtests passed<br=
>
&gt; &gt; &gt; =C2=A07/39 func-quick+func-riscv32 - qemu:func-riscv32-empty=
_cpu_model<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.29s =C2=A0 1 subtests passed<br>
&gt; &gt; &gt; =C2=A08/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/readconf=
ig-test =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.19s =C2=A0 1 subtests passed<br=
>
&gt; &gt; &gt; =C2=A09/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/cdrom-te=
st =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.41s =C2=A0 1 subtests passed<br>
&gt; &gt; &gt; 10/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/cdrom-test =
=C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.41s =C2=A0 1 subtests passed<br>
&gt; &gt; &gt; 11/39 func-quick+func-riscv32 - qemu:func-riscv32-info_usern=
et =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.31s =C2=A0 1 subtests passed<br=
>
&gt; &gt; &gt; 12/39 func-quick+func-riscv32 - qemu:func-riscv32-version =
=C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.29s =C2=A0 1 subtests passed<br>
&gt; &gt; &gt; 13/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/riscv-csr-tes=
t =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.30s =C2=A0 1 subtests passed<br>
&gt; &gt; &gt; 14/39 func-quick+func-riscv64 - qemu:func-riscv64-vnc =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKIP =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.39s =C2=A0 0 subtests passed<br>
&gt; &gt; &gt; 15/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/machine-none-=
test<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.15s =C2=A0 1 subtests passed<br=
>
&gt; &gt; &gt; 16/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/readconfig-te=
st =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.13s =C2=A0 1 subtests passed<br=
>
&gt; &gt; &gt; 17/39 func-quick+func-riscv32 - qemu:func-riscv32-vnc =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKIP =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.40s =C2=A0 0 subtests passed<br>
&gt; &gt; &gt; 18/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/qmp-test =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.54s =C2=A0 4 subtests passed<br>
&gt; &gt; &gt; 19/39 func-quick+func-riscv64 - qemu:func-riscv64-migration =
=C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.80s =C2=A0 3 subtests passed<br>
&gt; &gt; &gt; 20/39 func-quick+func-riscv32 - qemu:func-riscv32-migration =
=C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.77s =C2=A0 3 subtests passed<br>
&gt; &gt; &gt; 21/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/qmp-test =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.52s =C2=A0 4 subtests passed<br>
&gt; &gt; &gt; 22/39 func-quick+func-riscv64 - qemu:func-riscv64-opensbi =
=C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.85s =C2=A0 3 subtests passed<br>
&gt; &gt; &gt; 23/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/iommu-riscv-t=
est =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.76s =C2=A0 4 subtests passed<br>
&gt; &gt; &gt; 24/39 func-quick+func-riscv32 - qemu:func-riscv32-opensbi =
=C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.87s =C2=A0 3 subtests passed<br>
&gt; &gt; &gt; 25/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/k230-wdt-test=
 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1.06s =C2=A0 7 subtests passed<br=
>
&gt; &gt; &gt; 26/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/sifive-e-aon-=
<br>
&gt; &gt; &gt; watchdog-<br>
&gt; &gt; &gt; test =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 1.29s =C2=A0 10 subtests passed<br>
&gt; &gt; &gt; 27/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/qom-test =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2.22s =C2=A0 8 subtests passed<br>
&gt; &gt; &gt; 28/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/device-intros=
pect-<br>
&gt; &gt; &gt; test<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2.28s =C2=A0 6 subtests passed<br>
&gt; &gt; &gt; 29/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/device-intros=
pect-<br>
&gt; &gt; &gt; test<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2.58s =C2=A0 6 subtests passed<br>
&gt; &gt; &gt; 30/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/test-hmp =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.26s =C2=A0 8 subtests passed<br>
&gt; &gt; &gt; 31/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/netdev-socket=
 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.32s =C2=A0 10 subtests passed<b=
r>
&gt; &gt; &gt; 32/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/netdev-socket=
 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.30s =C2=A0 10 subtests passed<b=
r>
&gt; &gt; &gt; 33/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/qom-test =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.80s =C2=A0 12 subtests passed<br>
&gt; &gt; &gt; 34/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/test-hmp =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5.48s =C2=A0 12 subtests passed<br>
&gt; &gt; &gt; 35/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/qmp-cmd-test =
=C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8.44s =C2=A0 64 subtests passed<br>
&gt; &gt; &gt; 36/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/qmp-cmd-test =
=C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8.43s =C2=A0 64 subtests passed<br>
&gt; &gt; &gt; 37/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/bios-tables-t=
est =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERROR =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 17.02s =C2=A0 killed by signal 6 SIGABRT<br>
&gt; &gt; &gt; &gt; &gt; &gt; MESON_TEST_ITERATION=3D1<br>
&gt; &gt; &gt; &gt; &gt; &gt; PYTHON=3D/scratch3/yihaoc/sifive/qemu/build/p=
yvenv/bin/python<br>
&gt; &gt; &gt; &gt; &gt; &gt; 3<br>
&gt; &gt; &gt; &gt; &gt; &gt; QTEST_QEMU_IMG=3D./qemu-img<br>
&gt; &gt; &gt; &gt; &gt; &gt; ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_err=
or=3D1:print_summary<br>
&gt; &gt; &gt; &gt; &gt; &gt; =3D1<br>
&gt; &gt; &gt; &gt; &gt; &gt; MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_err=
or=3D1:print_summary<br>
&gt; &gt; &gt; &gt; &gt; &gt; =3D1:p<br>
&gt; &gt; &gt; &gt; &gt; &gt; rint_stacktrace=3D1<br>
&gt; &gt; &gt; &gt; &gt; &gt; G_TEST_DBUS_DAEMON=3D/scratch3/yihaoc/sifive/=
qemu/tests/dbus-<br>
&gt; &gt; &gt; &gt; &gt; &gt; daemon.sh QTEST_QEMU_STORAGE_DAEMON_BINARY=3D=
./storage-<br>
&gt; &gt; &gt; &gt; &gt; &gt; daemon/qemu-storage-daemon<br>
&gt; &gt; &gt; &gt; &gt; &gt; UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_er=
ror=3D1:print_summar<br>
&gt; &gt; &gt; &gt; &gt; &gt; y=3D1:<br>
&gt; &gt; &gt; &gt; &gt; &gt; print_stacktrace=3D1 RUST_BACKTRACE=3D1 MALLO=
C_PERTURB_=3D162<br>
&gt; &gt; &gt; &gt; &gt; &gt; QTEST_QEMU_BINARY=3D./qemu-system-riscv64<br>
&gt; &gt; &gt; &gt; &gt; &gt; /scratch3/yihaoc/sifive/qemu/build/tests/qtes=
t/bios-tables-<br>
&gt; &gt; &gt; &gt; &gt; &gt; test<br>
&gt; &gt; &gt; &gt; &gt; &gt; --tap -k<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; 38/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/qos-test =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A043.47s =C2=A0 191 subtests passed<br>
&gt; &gt; &gt; 39/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/qos-test =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A043.82s =C2=A0 191 subtests passed<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Ok: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03=
4 =C2=A0<br>
&gt; &gt; &gt; Fail: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=
=A0 <br>
&gt; &gt; &gt; Skipped: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4=C2=A0=C2=A0<br=
>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; The failure is because=C2=A0Zicclsm is mandatory in the<br>
&gt; &gt; &gt; RVA22U64=C2=A0profile.<br>
&gt; &gt; &gt; But before this patchset, ZIcclsm was enabled=C2=A0automatic=
ally when<br>
&gt; &gt; &gt; has_priv_1_11 was true.<br>
&gt; &gt; &gt; With this patchset, Zicclsm must be=C2=A0explicitly added to=
 the<br>
&gt; &gt; &gt; RVA22U64<br>
&gt; &gt; &gt; profile&#39;s extension list.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; After the fix, running:<br>
&gt; &gt; &gt; $=C2=A0meson test -C build &quot;qemu:*riscv*&quot;<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; [1/9] Generating qemu-version.h with a custom command (wrapp=
ed by<br>
&gt; &gt; &gt; meson to capture output)<br>
&gt; &gt; &gt; =C2=A01/41 func-quick+func-riscv64 - qemu:func-riscv64-linte=
rs =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKIP =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.15s =C2=A0 0 subtests passed<br>
&gt; &gt; &gt; =C2=A02/41 func-quick+func-riscv64 - qemu:func-riscv64-empty=
_cpu_model<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.19s =C2=A0 1 subtests passed<br>
&gt; &gt; &gt; =C2=A03/41 func-quick+func-riscv64 - qemu:func-riscv64-info_=
usernet =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.26s =C2=A0 1 subtests passed<br=
>
&gt; &gt; &gt; =C2=A04/41 func-quick+func-riscv32 - qemu:func-riscv32-linte=
rs =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKIP =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.21s =C2=A0 0 subtests passed<br>
&gt; &gt; &gt; =C2=A05/41 func-quick+func-riscv32 - qemu:func-riscv32-empty=
_cpu_model<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.24s =C2=A0 1 subtests passed<br>
&gt; &gt; &gt; =C2=A06/41 func-quick+func-riscv64 - qemu:func-riscv64-versi=
on =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.30s =C2=A0 1 subtests passed<br>
&gt; &gt; &gt; =C2=A07/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/cdrom-te=
st =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.39s =C2=A0 1 subtests passed<br>
&gt; &gt; &gt; =C2=A08/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/machine-=
none-test<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.17s =C2=A0 1 subtests passed<br=
>
&gt; &gt; &gt; =C2=A09/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/cdrom-te=
st =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.42s =C2=A0 1 subtests passed<br>
&gt; &gt; &gt; 10/41 func-quick+func-riscv32 - qemu:func-riscv32-version =
=C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.28s =C2=A0 1 subtests passed<br>
&gt; &gt; &gt; 11/41 func-quick+func-riscv32 - qemu:func-riscv32-info_usern=
et =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.32s =C2=A0 1 subtests passed<br=
>
&gt; &gt; &gt; 12/41 func-quick+func-riscv64 - qemu:func-riscv64-vnc =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKIP =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.35s =C2=A0 0 subtests passed<br>
&gt; &gt; &gt; 13/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/riscv-csr-tes=
t =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.30s =C2=A0 1 subtests passed<br>
&gt; &gt; &gt; 14/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/readconfig-te=
st =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.15s =C2=A0 1 subtests passed<br=
>
&gt; &gt; &gt; 15/41 func-quick+func-riscv32 - qemu:func-riscv32-vnc =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKIP =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.33s =C2=A0 0 subtests passed<br>
&gt; &gt; &gt; 16/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/machine-none-=
test<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.14s =C2=A0 1 subtests passed<br=
>
&gt; &gt; &gt; 17/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/readconfig-te=
st =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.14s =C2=A0 1 subtests passed<br=
>
&gt; &gt; &gt; 18/41 func-quick+func-riscv64 - qemu:func-riscv64-migration =
=C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.75s =C2=A0 3 subtests passed<br>
&gt; &gt; &gt; 19/41 func-quick+func-riscv32 - qemu:func-riscv32-migration =
=C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.78s =C2=A0 3 subtests passed<br>
&gt; &gt; &gt; 20/41 func-quick+func-riscv32 - qemu:func-riscv32-opensbi =
=C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.84s =C2=A0 3 subtests passed<br>
&gt; &gt; &gt; 21/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/iommu-riscv-t=
est =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.78s =C2=A0 4 subtests passed<br>
&gt; &gt; &gt; 22/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/k230-wdt-test=
 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1.08s =C2=A0 7 subtests passed<br=
>
&gt; &gt; &gt; 23/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/qmp-test =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1.16s =C2=A0 9 subtests passed<br>
&gt; &gt; &gt; 24/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/qmp-test =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1.14s =C2=A0 9 subtests passed<br>
&gt; &gt; &gt; 25/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/sifive-e-aon-=
<br>
&gt; &gt; &gt; watchdog-<br>
&gt; &gt; &gt; test =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 1.28s =C2=A0 10 subtests passed<br>
&gt; &gt; &gt; 26/41 func-quick+func-riscv64 - qemu:func-riscv64-opensbi =
=C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1.81s =C2=A0 4 subtests passed<br>
&gt; &gt; &gt; 27/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/qom-test =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2.06s =C2=A0 8 subtests passed<br>
&gt; &gt; &gt; 28/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/device-intros=
pect-<br>
&gt; &gt; &gt; test<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2.19s =C2=A0 6 subtests passed<br>
&gt; &gt; &gt; 29/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/device-intros=
pect-<br>
&gt; &gt; &gt; test<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2.48s =C2=A0 6 subtests passed<br>
&gt; &gt; &gt; 30/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/test-hmp =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.27s =C2=A0 8 subtests passed<br>
&gt; &gt; &gt; 31/41 func-quick+func-riscv32 - qemu:func-riscv32-monitor_ho=
tplug<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.46s =C2=A0 7 subtests passed<br>
&gt; &gt; &gt; 32/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/netdev-socket=
 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.32s =C2=A0 10 subtests passed<b=
r>
&gt; &gt; &gt; 33/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/netdev-socket=
 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.31s =C2=A0 10 subtests passed<b=
r>
&gt; &gt; &gt; 34/41 func-quick+func-riscv64 - qemu:func-riscv64-monitor_ho=
tplug<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4.00s =C2=A0 7 subtests passed<br>
&gt; &gt; &gt; 35/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/qom-test =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4.40s =C2=A0 13 subtests passed<br>
&gt; &gt; &gt; 36/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/test-hmp =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.63s =C2=A0 13 subtests passed<br>
&gt; &gt; &gt; 37/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/qmp-cmd-test =
=C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8.45s =C2=A0 64 subtests passed<br>
&gt; &gt; &gt; 38/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/qmp-cmd-test =
=C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8.50s =C2=A0 64 subtests passed<br>
&gt; &gt; &gt; 39/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/bios-tables-t=
est =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A035.13s =C2=A0 3 subtests passed<br>
&gt; &gt; &gt; 40/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/qos-test =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A046.41s =C2=A0 192 subtests passed<br>
&gt; &gt; &gt; 41/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/qos-test =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A046.45s =C2=A0 192 subtests passed<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Ok: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03=
7 =C2=A0<br>
&gt; &gt; &gt; Fail: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=
=A0 <br>
&gt; &gt; &gt; Skipped: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; All the tests=C2=A0passed.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; I will send out=C2=A0the v5 patchset to fix the issue.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; BTW, I noticed you ran more tests than I did.<br>
&gt; &gt; &gt; Could you please share your test command so I can reproduce =
it on<br>
&gt; &gt; &gt; my<br>
&gt; &gt; &gt; end?<br>
&gt; &gt; <br>
&gt; &gt; I&#39;m just running `make check`.<br>
&gt; &gt; <br>
&gt; &gt; Even your v5 is failing make check on the `target/riscv: Support<=
br>
&gt; &gt; raising misaligned exceptions for scalar loads/stores` patch<br>
&gt; &gt; <br>
&gt; <br>
&gt; <br>
&gt; Hi Alistair,<br>
&gt; <br>
&gt; Does every single patch in the patchset need to pass `make check`,=C2=
=A0or<br>
&gt; is it enough for the final patchset to pass?<br>
<br>
Every single patch needs to pass all tests and checks<br></blockquote><div>=
<br></div><div>Thanks Alistair,</div><div><br></div><div>I&#39;ve reordered=
 and squashed the patches so that every single patch could pass `make check=
` in the v6 patchset:</div><div><a href=3D"https://lore.kernel.org/qemu-ris=
cv/20260713035135.3996990-1-frank.chang@sifive.com/">https://lore.kernel.or=
g/qemu-riscv/20260713035135.3996990-1-frank.chang@sifive.com/</a></div><div=
><br></div><div>Regards,</div><div>Frank Chang</div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
Alistair<br>
</blockquote></div></div>

--0000000000003903570656760f0c--

