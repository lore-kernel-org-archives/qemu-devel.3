Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7165DC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 09:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiqQI-0008Fv-B6; Sun, 12 Jul 2026 05:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wiqQF-0008FH-J0
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 05:24:27 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wiqQ8-000382-EW
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 05:24:23 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c15e0c3f395so265701266b.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 02:24:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783848257; cv=none;
 d=google.com; s=arc-20260327;
 b=MrSHeEXWOMXDzMcJtxBPTcgdsQOvmrrx202IXA5WFDDEZAjZUPsX1PpxvTJuTXqH3f
 Xh1vi51o1KOW5rgKv4lQPtu14oW9aR0fctm8zmrn012ovnERtdbO0JyKekdm4p+hiKy7
 AHVKrXJyuZLHthVwxF0uQSZIVnRX4aUpNaIZLx3Gtx9fiPLW7EMCT0wc6bd3YvrUPBFZ
 Xsz2IwhJqhwDdsQUZNwLYf1dqu0jRHvZ41BTowIoEh6ZNA0qUvP331b/UG30ixgENUke
 6ow+lKQns+9Oa6NT0sQMJ05NnHtovSA+VMTX2Zn/CDBA80HEV5YKfiFX+EoSX4maFfKl
 v3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HnIobeCO9RFfEeOZf8KX3PSFquu3Jeny+cYOu6i244Y=;
 fh=af79raycFL9degfbvGeZPHoxfI73Q/0OB8yOXwIxf3M=;
 b=fNiigrx+kKwQJZnQhM8M8LWjzDYgl1VS13QapPVanKQgnHoo/JOJcrC9aQUMBPWg5q
 WjDqcNlDDziLG2uHR1ePTjJVdB6u9CSLcBJ7EStrNf0DoHQblELkkq7KYB5VD/3aGSc9
 JTOYdxcqMfB+AGEaD3ffh0HmoqHQ3pFFF6bxneLh0zXs4uoWl6NSNmQhW9yUF+o6SMfu
 Ppg8bfB1SH6s2SuDziK4+7LPMEnEb3cRHX/+K0mZTD6qVUysr5Rl+RmggvPhdEcwUJGe
 4pwAcQlOOXPm1/j8CGpwowxMnUS1fp6wdqqOC+QneEJt90yzF6OuMYnN5fMJlFbDN1wg
 JcuA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783848257; x=1784453057; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HnIobeCO9RFfEeOZf8KX3PSFquu3Jeny+cYOu6i244Y=;
 b=bAYxAEWTv4YIJ0aFI5xT9Bpy7uBv0wFOI/sb1QvyOJzSMlU6GV18o/WT4sVIOgkbf9
 ePCvmUPQJD+edDGovLrB2aAXQlWyrq87/LfE3/AtQyXoVx/56mhggduFNob5n8dCe4lq
 Hmq8BvyXpUvz1TMozBblFo3FdM8T2FUWiafoiYAItwObWrsWlEUZ3akAN6ym9Dp76RNS
 cpfWfil1W8n+tQ8dyKJ83C8TY+gtnR+OKHBxr8SX9d/CAdCFwjBSGDZ6HIVfQS3Z/uVL
 0RllP7Sotf/IE1c8hFbbnmNSBB43q/GkYpRM8GBWWAbw+qICahhIzxTMUYGr6/gIga7H
 DHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783848257; x=1784453057;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HnIobeCO9RFfEeOZf8KX3PSFquu3Jeny+cYOu6i244Y=;
 b=f91CEBnxQyqzHSLYNMxkBYK74LuctuB/c1u7c7LAw/dBs6bAloyncdASRZM5bAaL+/
 jiEIdJOqISMD4+kCKIAEUvTnEz51vQdCxskddfn8OZ+j26Bk8UZ8OkwuPrSLqUd1KofP
 RWr6yonVlImZmbF0uuidwGmlX04iC1Plc0o/A+WJUQLti6Yw/MJtcSGw1to9U0FpokZk
 JERy+xhCkFJ8jTkGpHKMJLDjjPryEPPcXIdV/GXwX0A5DLSGzpvDzCAnoDzuSzHR/zCw
 tBE6WSIq+LEe+1MN8wMcz36mvp/JhpfoYrkt9VeXOSacdoaeA6SwyCZcQmbob5SYjRhv
 HUAg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp45i40a47LhPvT2j4+w9cm2iSk6y2PWqp//QKxdNdTZ/tpqEoo9IKNAVgH1esmReKIGStv/2+CVy0g@nongnu.org
X-Gm-Message-State: AOJu0Yy+jhZGxipokofi0gpoE/PRnCYNMnG7TsVZzFIjBz3PRO8wkXet
 3Dhsgl2kbzYyhnFZj9FKCKBWfleSy/nucZrp2UbwUJCfWh3EL658LyFwQy/RQkiSuxcedA4gKLx
 pi+/Eq3Jwn5nYA6Nz+BW3m/1ydgLACFI0uRC9mqi0yA==
X-Gm-Gg: AfdE7cngLjH8SKlEnywO3KK4QSmlBn2xjO3iZaDuqBN4LtQgaVqYvBdeGBpoQObB+GH
 vr/8tIxE0fDvNj6j6tO2ko7dhv1VmxOhQTiCSuRv9bhrKhEU6zVK8A0TBWbZMcDIYk+kkcjG6Et
 0yXNhJCZZ350mOKG+ucT7Q2WBzyp4jaMYR4gF/dXfCOfTUysPg/mxAxanO99Hmcs5RqMkmQxJAe
 0CnGgSBGfs859c2ULho4szhf7a85JF/msHF52g7mj+qRMCTcRaYu5o/SBqMX00vst+nNv3KOo0=
X-Received: by 2002:a17:907:3cc5:b0:c12:dd72:933c with SMTP id
 a640c23a62f3a-c161f353b50mr242872266b.33.1783848257178; Sun, 12 Jul 2026
 02:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260707091039.2574638-1-frank.chang@sifive.com>
 <CAKmqyKNVo-rdOtN0t9XzRB3teF6nNEgh_twkf9s8zX2q0dPU=w@mail.gmail.com>
 <CAE_xrPiD1d8jRfz9fcjZaNGEp1uuDn8PMO-=RzMLipt3CnBGPw@mail.gmail.com>
 <55cce2d7f992ac95719f04b6b8d8923c95900df5.camel@wdc.com>
In-Reply-To: <55cce2d7f992ac95719f04b6b8d8923c95900df5.camel@wdc.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Sun, 12 Jul 2026 17:24:04 +0800
X-Gm-Features: AUfX_mxdEVVyZymw86KAwwCKZo2IPPY1IbHS4tubD9cyIlbRuDIPrmzvAAzVAyg
Message-ID: <CAE_xrPirgG8eN8O8njdP8_pqjEQUBdmAmRjNZ=G+9G-jj_qcew@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] target/riscv: Support the true Zicclsm extension
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, 
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>, 
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>, 
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "liwei1518@gmail.com" <liwei1518@gmail.com>, 
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="000000000000b3de6e065666891e"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=frank.chang@sifive.com; helo=mail-ej1-x62b.google.com
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

--000000000000b3de6e065666891e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 7:23=E2=80=AFPM Alistair Francis <Alistair.Francis@=
wdc.com>
wrote:

> On Fri, 2026-07-10 at 12:39 +0800, Frank Chang wrote:
> > On Thu, Jul 9, 2026 at 12:58=E2=80=AFPM Alistair Francis
> > <alistair23@gmail.com> wrote:
> > > On Tue, Jul 7, 2026 at 7:11=E2=80=AFPM <frank.chang@sifive.com> wrote=
:
> > > >
> > > > From: Frank Chang <frank.chang@sifive.com>
> > > >
> > > > Support the true Zicclsm extension so that we can trap misaligned
> > > > accesses
> > > > when Zicclsm is disabled.
> > > >
> > > > To enable/disable Zicclsm, simply set zicclsm=3D[true|false], e.g.:
> > > >    -cpu rv64,zicclsm=3D[true|false]
> > > >
> > > > QEMU will raise a misaligned load/store exception when executing
> > > > misaligned
> > > > load/store instructions if Zicclsm is disabled.
> > > >
> > > > Changelog:
> > > >    v4:
> > > >      * Align ROM reset vector data at 8-byte aligned offsets.
> > > >    v3:
> > > >      * Enable Zicclsm for the compatible CPUs.
> > > >      * Rebase to the latest riscv-to-apply.next.
> > > >    v2:
> > > >      * Use (size_memop(size) | mo_endian_env(env)) to calculate
> > > > MemOp.
> > > >      * Use (log2_esz << MO_ASHIFT) to calculate aligment MemOp
> > > > for
> > > >        vector load/store whole register instructions.
> > > >
> > > > Frank Chang (6):
> > > >    target/riscv: Add Zicclsm CPU option
> > > >    target/riscv: Support raising misaligned exceptions for scalar
> > > >      loads/stores
> > > >    target/riscv: Support raising misaligned exceptions for vector
> > > >      loads/stores
> > > >    target/riscv: Enable Zicclsm for the compatible CPUs
> > > >    hw/riscv: sifive_u: Align ROM reset vector data
> > > >    target/riscv: Update Zicclsm ISA string and expose it as a CPU
> > > >      property
> > >
> > > Hmmm.... Still seeing failures
> > >
> > > 556/556 qemu:func-quick+func-riscv64 / func-riscv64-opensbi
> > >                TIMEOUT         90.02s   killed by signal 15 SIGTERM
> > > > > > LD_LIBRARY_PATH=3D/var/mnt/scratch/alistair/software/qemu/build
> > > > > > /contrib/plugins:/var/mnt/scratch/alistair/software/qemu/buil
> > > > > > d/tests/tcg/plugins MSAN_OPTIO
> > > NS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print_sta=
cktrac
> > > e=3D1
> > > QEMU_TEST_QEMU_BINARY=3D/var/mnt/scratch/alistair/software/qemu/build
> > > /qemu-system-riscv
> > > 64 RUST_BACKTRACE=3D1
> > > MESON_BUILD_ROOT=3D/var/mnt/scratch/alistair/software/qemu/build
> > > UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D=
1:prin
> > > t_stac
> > > ktrace=3D1
> > > ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1
> > > MESON_TEST_ITERATION=3D1 MALLOC_PERTURB_=3D7
> > > QEMU_TEST_QEMU_IMG=3D/var/mnt/scratch/alistair
> > > /software/qemu/build/qemu-img QEMU_TEST_GDB=3D/usr/bin/gdb
> > > PYTHONPATH=3D/var/mnt/scratch/alistair/software/qemu/python:/var/mnt/
> > > scratch/alistair/software/qemu/t
> > > ests/functional
> > > /var/mnt/scratch/alistair/software/qemu/build/pyvenv/bin/python3
> > > /var/mnt/scratch/alistair/software/qemu/tests/functional/riscv64/te
> > > st_opens
> > > bi.py
> > >
> > >
> > > Summary of Failures:
> > >
> > > 556/556 qemu:func-quick+func-riscv64 / func-riscv64-opensbi
> > >       TIMEOUT         90.02s   killed by signal 15 SIGTERM
> > >
> > >
> >
> >
> > Hi Alistair,
> >
> > That's weird.
> >
> > I ran:
> > $ meson test -C build qemu:func-riscv64-opensbi -v --print-errorlog
> >
> > .....
> >
> > =E2=96=B6 1/1 test_opensbi.RiscvOpenSBI.test_riscv_sifive_u            =
OK
> >
> > =E2=96=B6 1/1 test_opensbi.RiscvOpenSBI.test_riscv_spike               =
OK
> >
> > =E2=96=B6 1/1 test_opensbi.RiscvOpenSBI.test_riscv_tt_atlantis         =
OK
> >
> > =E2=96=B6 1/1 test_opensbi.RiscvOpenSBI.test_riscv_virt                =
OK
> >
> > 1/1 func-quick+func-riscv64 - qemu:func-riscv64-opensbi        OK
> >          1.53s   4 subtests passed
> >
> >
> > Ok:                1
> > Fail:              0
> >
> > func-riscv64-opensbi test passed.
> >
> > However, I did find another issue when I ran:
> > $ meson test -C build "qemu:*riscv*"
> >
> > [1/9] Generating qemu-version.h with a custom command (wrapped by
> > meson to capture output)
> >  1/39 func-quick+func-riscv64 - qemu:func-riscv64-linters
> >             SKIP             0.15s   0 subtests passed
> >  2/39 func-quick+func-riscv64 - qemu:func-riscv64-empty_cpu_model
> >             OK               0.21s   1 subtests passed
> >  3/39 func-quick+func-riscv64 - qemu:func-riscv64-version
> >             OK               0.25s   1 subtests passed
> >  4/39 func-quick+func-riscv32 - qemu:func-riscv32-linters
> >             SKIP             0.23s   0 subtests passed
> >  5/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/machine-none-test
> >              OK               0.17s   1 subtests passed
> >  6/39 func-quick+func-riscv64 - qemu:func-riscv64-info_usernet
> >              OK               0.33s   1 subtests passed
> >  7/39 func-quick+func-riscv32 - qemu:func-riscv32-empty_cpu_model
> >             OK               0.29s   1 subtests passed
> >  8/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/readconfig-test
> >              OK               0.19s   1 subtests passed
> >  9/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/cdrom-test
> >             OK               0.41s   1 subtests passed
> > 10/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/cdrom-test
> >             OK               0.41s   1 subtests passed
> > 11/39 func-quick+func-riscv32 - qemu:func-riscv32-info_usernet
> >              OK               0.31s   1 subtests passed
> > 12/39 func-quick+func-riscv32 - qemu:func-riscv32-version
> >             OK               0.29s   1 subtests passed
> > 13/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/riscv-csr-test
> >             OK               0.30s   1 subtests passed
> > 14/39 func-quick+func-riscv64 - qemu:func-riscv64-vnc
> >             SKIP             0.39s   0 subtests passed
> > 15/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/machine-none-test
> >              OK               0.15s   1 subtests passed
> > 16/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/readconfig-test
> >              OK               0.13s   1 subtests passed
> > 17/39 func-quick+func-riscv32 - qemu:func-riscv32-vnc
> >             SKIP             0.40s   0 subtests passed
> > 18/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/qmp-test
> >             OK               0.54s   4 subtests passed
> > 19/39 func-quick+func-riscv64 - qemu:func-riscv64-migration
> >             OK               0.80s   3 subtests passed
> > 20/39 func-quick+func-riscv32 - qemu:func-riscv32-migration
> >             OK               0.77s   3 subtests passed
> > 21/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/qmp-test
> >             OK               0.52s   4 subtests passed
> > 22/39 func-quick+func-riscv64 - qemu:func-riscv64-opensbi
> >             OK               0.85s   3 subtests passed
> > 23/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/iommu-riscv-test
> >             OK               0.76s   4 subtests passed
> > 24/39 func-quick+func-riscv32 - qemu:func-riscv32-opensbi
> >             OK               0.87s   3 subtests passed
> > 25/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/k230-wdt-test
> >              OK               1.06s   7 subtests passed
> > 26/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/sifive-e-aon-watchdog-
> > test         OK               1.29s   10 subtests passed
> > 27/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/qom-test
> >             OK               2.22s   8 subtests passed
> > 28/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/device-introspect-test
> >             OK               2.28s   6 subtests passed
> > 29/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/device-introspect-test
> >             OK               2.58s   6 subtests passed
> > 30/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/test-hmp
> >             OK               3.26s   8 subtests passed
> > 31/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/netdev-socket
> >              OK               3.32s   10 subtests passed
> > 32/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/netdev-socket
> >              OK               3.30s   10 subtests passed
> > 33/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/qom-test
> >             OK               3.80s   12 subtests passed
> > 34/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/test-hmp
> >             OK               5.48s   12 subtests passed
> > 35/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/qmp-cmd-test
> >             OK               8.44s   64 subtests passed
> > 36/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/qmp-cmd-test
> >             OK               8.43s   64 subtests passed
> > 37/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/bios-tables-test
> >             ERROR           17.02s   killed by signal 6 SIGABRT
> > > > > MESON_TEST_ITERATION=3D1
> > > > > PYTHON=3D/scratch3/yihaoc/sifive/qemu/build/pyvenv/bin/python3
> > > > > QTEST_QEMU_IMG=3D./qemu-img
> > > > > ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=
=3D1
> > > > > MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=
=3D1:p
> > > > > rint_stacktrace=3D1
> > > > > G_TEST_DBUS_DAEMON=3D/scratch3/yihaoc/sifive/qemu/tests/dbus-
> > > > > daemon.sh QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-
> > > > > daemon/qemu-storage-daemon
> > > > > UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summar=
y=3D1:
> > > > > print_stacktrace=3D1 RUST_BACKTRACE=3D1 MALLOC_PERTURB_=3D162
> > > > > QTEST_QEMU_BINARY=3D./qemu-system-riscv64
> > > > > /scratch3/yihaoc/sifive/qemu/build/tests/qtest/bios-tables-test
> > > > > --tap -k
> >
> > 38/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/qos-test
> >             OK              43.47s   191 subtests passed
> > 39/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/qos-test
> >             OK              43.82s   191 subtests passed
> >
> > Ok:                34
> > Fail:              1
> > Skipped:           4
> >
> > The failure is because Zicclsm is mandatory in the RVA22U64 profile.
> > But before this patchset, ZIcclsm was enabled automatically when
> > has_priv_1_11 was true.
> > With this patchset, Zicclsm must be explicitly added to the RVA22U64
> > profile's extension list.
> >
> > After the fix, running:
> > $ meson test -C build "qemu:*riscv*"
> >
> > [1/9] Generating qemu-version.h with a custom command (wrapped by
> > meson to capture output)
> >  1/41 func-quick+func-riscv64 - qemu:func-riscv64-linters
> >             SKIP             0.15s   0 subtests passed
> >  2/41 func-quick+func-riscv64 - qemu:func-riscv64-empty_cpu_model
> >             OK               0.19s   1 subtests passed
> >  3/41 func-quick+func-riscv64 - qemu:func-riscv64-info_usernet
> >              OK               0.26s   1 subtests passed
> >  4/41 func-quick+func-riscv32 - qemu:func-riscv32-linters
> >             SKIP             0.21s   0 subtests passed
> >  5/41 func-quick+func-riscv32 - qemu:func-riscv32-empty_cpu_model
> >             OK               0.24s   1 subtests passed
> >  6/41 func-quick+func-riscv64 - qemu:func-riscv64-version
> >             OK               0.30s   1 subtests passed
> >  7/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/cdrom-test
> >             OK               0.39s   1 subtests passed
> >  8/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/machine-none-test
> >              OK               0.17s   1 subtests passed
> >  9/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/cdrom-test
> >             OK               0.42s   1 subtests passed
> > 10/41 func-quick+func-riscv32 - qemu:func-riscv32-version
> >             OK               0.28s   1 subtests passed
> > 11/41 func-quick+func-riscv32 - qemu:func-riscv32-info_usernet
> >              OK               0.32s   1 subtests passed
> > 12/41 func-quick+func-riscv64 - qemu:func-riscv64-vnc
> >             SKIP             0.35s   0 subtests passed
> > 13/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/riscv-csr-test
> >             OK               0.30s   1 subtests passed
> > 14/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/readconfig-test
> >              OK               0.15s   1 subtests passed
> > 15/41 func-quick+func-riscv32 - qemu:func-riscv32-vnc
> >             SKIP             0.33s   0 subtests passed
> > 16/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/machine-none-test
> >              OK               0.14s   1 subtests passed
> > 17/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/readconfig-test
> >              OK               0.14s   1 subtests passed
> > 18/41 func-quick+func-riscv64 - qemu:func-riscv64-migration
> >             OK               0.75s   3 subtests passed
> > 19/41 func-quick+func-riscv32 - qemu:func-riscv32-migration
> >             OK               0.78s   3 subtests passed
> > 20/41 func-quick+func-riscv32 - qemu:func-riscv32-opensbi
> >             OK               0.84s   3 subtests passed
> > 21/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/iommu-riscv-test
> >             OK               0.78s   4 subtests passed
> > 22/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/k230-wdt-test
> >              OK               1.08s   7 subtests passed
> > 23/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/qmp-test
> >             OK               1.16s   9 subtests passed
> > 24/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/qmp-test
> >             OK               1.14s   9 subtests passed
> > 25/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/sifive-e-aon-watchdog-
> > test         OK               1.28s   10 subtests passed
> > 26/41 func-quick+func-riscv64 - qemu:func-riscv64-opensbi
> >             OK               1.81s   4 subtests passed
> > 27/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/qom-test
> >             OK               2.06s   8 subtests passed
> > 28/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/device-introspect-test
> >             OK               2.19s   6 subtests passed
> > 29/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/device-introspect-test
> >             OK               2.48s   6 subtests passed
> > 30/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/test-hmp
> >             OK               3.27s   8 subtests passed
> > 31/41 func-quick+func-riscv32 - qemu:func-riscv32-monitor_hotplug
> >             OK               3.46s   7 subtests passed
> > 32/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/netdev-socket
> >              OK               3.32s   10 subtests passed
> > 33/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/netdev-socket
> >              OK               3.31s   10 subtests passed
> > 34/41 func-quick+func-riscv64 - qemu:func-riscv64-monitor_hotplug
> >             OK               4.00s   7 subtests passed
> > 35/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/qom-test
> >             OK               4.40s   13 subtests passed
> > 36/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/test-hmp
> >             OK               6.63s   13 subtests passed
> > 37/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/qmp-cmd-test
> >             OK               8.45s   64 subtests passed
> > 38/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/qmp-cmd-test
> >             OK               8.50s   64 subtests passed
> > 39/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/bios-tables-test
> >             OK              35.13s   3 subtests passed
> > 40/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/qos-test
> >             OK              46.41s   192 subtests passed
> > 41/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/qos-test
> >             OK              46.45s   192 subtests passed
> >
> > Ok:                37
> > Fail:              0
> > Skipped:           4
> >
> > All the tests passed.
> >
> > I will send out the v5 patchset to fix the issue.
> >
> > BTW, I noticed you ran more tests than I did.
> > Could you please share your test command so I can reproduce it on my
> > end?
>
> I'm just running `make check`.
>
> Even your v5 is failing make check on the `target/riscv: Support
> raising misaligned exceptions for scalar loads/stores` patch
>

Hi Alistair,

Does every single patch in the patchset need to pass `make check`, or is it
enough for the final patchset to pass?

I only ran the `make check` for the final patchset:

---

345/352 softfloat+softfloat-ops - qemu:fp-test-log2
          OK               0.11s
346/352 qapi-schema+qapi-frontend - qemu:QAPI schema regression tests
          OK               0.14s
347/352 tracetool - qemu:dtrace
          OK               0.22s
348/352 tracetool - qemu:ftrace
          OK               0.11s
349/352 tracetool - qemu:log
           OK               0.12s
350/352 tracetool - qemu:simple
          OK               0.12s
351/352 tracetool - qemu:syslog
          OK               0.12s
352/352 tracetool - qemu:ust
           OK               0.14s

Ok:                341
Fail:              0
Skipped:           11

---

If we need to pass every single patch in the patchset,
then I'll have to move patch #4, #5, #7 before patch #2 in v5 patchset,
so that everything is ready before Zicclsm is implemented.


Regards,
Frank Chang


>
> Alistair
>

--000000000000b3de6e065666891e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><span style=3D"backgroun=
d-color:transparent">On Fri, Jul 10, 2026 at 7:23=E2=80=AFPM Alistair Franc=
is &lt;</span><a href=3D"mailto:Alistair.Francis@wdc.com" target=3D"_blank"=
 style=3D"background-color:transparent">Alistair.Francis@wdc.com</a><span s=
tyle=3D"background-color:transparent">&gt; wrote:</span></div><div class=3D=
"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, 202=
6-07-10 at 12:39 +0800, Frank Chang wrote:<br>
&gt; On Thu, Jul 9, 2026 at 12:58=E2=80=AFPM Alistair Francis<br>
&gt; &lt;<a href=3D"mailto:alistair23@gmail.com" target=3D"_blank">alistair=
23@gmail.com</a>&gt; wrote:<br>
&gt; &gt; On Tue, Jul 7, 2026 at 7:11=E2=80=AFPM &lt;<a href=3D"mailto:fran=
k.chang@sifive.com" target=3D"_blank">frank.chang@sifive.com</a>&gt; wrote:=
<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.c=
om" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Support the true Zicclsm extension so that we can trap misal=
igned<br>
&gt; &gt; &gt; accesses<br>
&gt; &gt; &gt; when Zicclsm is disabled.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; To enable/disable Zicclsm, simply set zicclsm=3D[true|false]=
, e.g.:<br>
&gt; &gt; &gt; =C2=A0 =C2=A0-cpu rv64,zicclsm=3D[true|false]<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; QEMU will raise a misaligned load/store exception when execu=
ting<br>
&gt; &gt; &gt; misaligned<br>
&gt; &gt; &gt; load/store instructions if Zicclsm is disabled.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Changelog:<br>
&gt; &gt; &gt; =C2=A0 =C2=A0v4:<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0* Align ROM reset vector data at 8-byte =
aligned offsets.<br>
&gt; &gt; &gt; =C2=A0 =C2=A0v3:<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0* Enable Zicclsm for the compatible CPUs=
.<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0* Rebase to the latest riscv-to-apply.ne=
xt.<br>
&gt; &gt; &gt; =C2=A0 =C2=A0v2:<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0* Use (size_memop(size) | mo_endian_env(=
env)) to calculate<br>
&gt; &gt; &gt; MemOp.<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0* Use (log2_esz &lt;&lt; MO_ASHIFT) to c=
alculate aligment MemOp<br>
&gt; &gt; &gt; for<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0vector load/store whole register =
instructions.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Frank Chang (6):<br>
&gt; &gt; &gt; =C2=A0 =C2=A0target/riscv: Add Zicclsm CPU option<br>
&gt; &gt; &gt; =C2=A0 =C2=A0target/riscv: Support raising misaligned except=
ions for scalar<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0loads/stores<br>
&gt; &gt; &gt; =C2=A0 =C2=A0target/riscv: Support raising misaligned except=
ions for vector<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0loads/stores<br>
&gt; &gt; &gt; =C2=A0 =C2=A0target/riscv: Enable Zicclsm for the compatible=
 CPUs<br>
&gt; &gt; &gt; =C2=A0 =C2=A0hw/riscv: sifive_u: Align ROM reset vector data=
<br>
&gt; &gt; &gt; =C2=A0 =C2=A0target/riscv: Update Zicclsm ISA string and exp=
ose it as a CPU<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0property<br>
&gt; &gt; <br>
&gt; &gt; Hmmm.... Still seeing failures<br>
&gt; &gt; <br>
&gt; &gt; 556/556 qemu:func-quick+func-riscv64 / func-riscv64-opensbi<br>
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TIMEOUT=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A090.02s=C2=A0 =C2=A0killed by signal 15 SIGTE=
RM<br>
&gt; &gt; &gt; &gt; &gt; LD_LIBRARY_PATH=3D/var/mnt/scratch/alistair/softwa=
re/qemu/build<br>
&gt; &gt; &gt; &gt; &gt; /contrib/plugins:/var/mnt/scratch/alistair/softwar=
e/qemu/buil<br>
&gt; &gt; &gt; &gt; &gt; d/tests/tcg/plugins MSAN_OPTIO<br>
&gt; &gt; NS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print=
_stacktrac<br>
&gt; &gt; e=3D1<br>
&gt; &gt; QEMU_TEST_QEMU_BINARY=3D/var/mnt/scratch/alistair/software/qemu/b=
uild<br>
&gt; &gt; /qemu-system-riscv<br>
&gt; &gt; 64 RUST_BACKTRACE=3D1<br>
&gt; &gt; MESON_BUILD_ROOT=3D/var/mnt/scratch/alistair/software/qemu/build<=
br>
&gt; &gt; UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summar=
y=3D1:prin<br>
&gt; &gt; t_stac<br>
&gt; &gt; ktrace=3D1<br>
&gt; &gt; ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=
=3D1<br>
&gt; &gt; MESON_TEST_ITERATION=3D1 MALLOC_PERTURB_=3D7<br>
&gt; &gt; QEMU_TEST_QEMU_IMG=3D/var/mnt/scratch/alistair<br>
&gt; &gt; /software/qemu/build/qemu-img QEMU_TEST_GDB=3D/usr/bin/gdb<br>
&gt; &gt; PYTHONPATH=3D/var/mnt/scratch/alistair/software/qemu/python:/var/=
mnt/<br>
&gt; &gt; scratch/alistair/software/qemu/t<br>
&gt; &gt; ests/functional<br>
&gt; &gt; /var/mnt/scratch/alistair/software/qemu/build/pyvenv/bin/python3<=
br>
&gt; &gt; /var/mnt/scratch/alistair/software/qemu/tests/functional/riscv64/=
te<br>
&gt; &gt; st_opens<br>
&gt; &gt; bi.py<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; Summary of Failures:<br>
&gt; &gt; <br>
&gt; &gt; 556/556 qemu:func-quick+func-riscv64 / func-riscv64-opensbi<br>
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 TIMEOUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A090.=
02s=C2=A0 =C2=A0killed by signal 15 SIGTERM<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; <br>
&gt; <br>
&gt; Hi Alistair,<br>
&gt; <br>
&gt; That&#39;s weird.<br>
&gt; <br>
&gt; I ran:<br>
&gt; $ meson test -C build qemu:func-riscv64-opensbi -v --print-errorlog<br=
>
&gt; <br>
&gt; .....<br>
&gt; <br>
&gt; =E2=96=B6 1/1 test_opensbi.RiscvOpenSBI.test_riscv_sifive_u =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =E2=96=B6 1/1 test_opensbi.RiscvOpenSBI.test_riscv_spike =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =E2=96=B6 1/1 test_opensbi.RiscvOpenSBI.test_riscv_tt_atlantis =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =E2=96=B6 1/1 test_opensbi.RiscvOpenSBI.test_riscv_virt =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; 1/1 func-quick+func-riscv64 - qemu:func-riscv64-opensbi =C2=A0 =C2=A0 =
=C2=A0 =C2=A0OK =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01.53s =C2=A0 4 subtests passed<br>
&gt; <br>
&gt; <br>
&gt; Ok: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 <b=
r>
&gt; Fail: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
&gt; <br>
&gt; func-riscv64-opensbi test=C2=A0passed.<br>
&gt; <br>
&gt; However, I did find another issue when I ran:<br>
&gt; $=C2=A0meson test -C build &quot;qemu:*riscv*&quot;<br>
&gt; <br>
&gt; [1/9] Generating qemu-version.h with a custom command (wrapped by<br>
&gt; meson to capture output)<br>
&gt; =C2=A01/39 func-quick+func-riscv64 - qemu:func-riscv64-linters =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKIP =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0.15s =C2=A0 0 subtests passed<br>
&gt; =C2=A02/39 func-quick+func-riscv64 - qemu:func-riscv64-empty_cpu_model=
 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.21s =C2=A0 1 subtests passed<br>
&gt; =C2=A03/39 func-quick+func-riscv64 - qemu:func-riscv64-version =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.25s =C2=A0 1 subtests passed<br>
&gt; =C2=A04/39 func-quick+func-riscv32 - qemu:func-riscv32-linters =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKIP =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0.23s =C2=A0 0 subtests passed<br>
&gt; =C2=A05/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/machine-none-test =
=C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.17s =C2=A0 1 subtests passed<br>
&gt; =C2=A06/39 func-quick+func-riscv64 - qemu:func-riscv64-info_usernet =
=C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.33s =C2=A0 1 subtests passed<br>
&gt; =C2=A07/39 func-quick+func-riscv32 - qemu:func-riscv32-empty_cpu_model=
 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.29s =C2=A0 1 subtests passed<br>
&gt; =C2=A08/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/readconfig-test =
=C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.19s =C2=A0 1 subtests passed<br>
&gt; =C2=A09/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/cdrom-test =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.41s =C2=A0 1 subtests passed<br>
&gt; 10/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/cdrom-test =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.41s =C2=A0 1 subtests passed<br>
&gt; 11/39 func-quick+func-riscv32 - qemu:func-riscv32-info_usernet =C2=A0 =
=C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.31s =C2=A0 1 subtests passed<br>
&gt; 12/39 func-quick+func-riscv32 - qemu:func-riscv32-version =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.29s =C2=A0 1 subtests passed<br>
&gt; 13/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/riscv-csr-test =C2=A0 =
=C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.30s =C2=A0 1 subtests passed<br>
&gt; 14/39 func-quick+func-riscv64 - qemu:func-riscv64-vnc =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKIP =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0.39s =C2=A0 0 subtests passed<br>
&gt; 15/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/machine-none-test =C2=
=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.15s =C2=A0 1 subtests passed<br>
&gt; 16/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/readconfig-test =C2=A0 =
=C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.13s =C2=A0 1 subtests passed<br>
&gt; 17/39 func-quick+func-riscv32 - qemu:func-riscv32-vnc =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKIP =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0.40s =C2=A0 0 subtests passed<br>
&gt; 18/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/qmp-test =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.54s =C2=A0 4 subtests passed<br>
&gt; 19/39 func-quick+func-riscv64 - qemu:func-riscv64-migration =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.80s =C2=A0 3 subtests passed<br>
&gt; 20/39 func-quick+func-riscv32 - qemu:func-riscv32-migration =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.77s =C2=A0 3 subtests passed<br>
&gt; 21/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/qmp-test =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.52s =C2=A0 4 subtests passed<br>
&gt; 22/39 func-quick+func-riscv64 - qemu:func-riscv64-opensbi =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.85s =C2=A0 3 subtests passed<br>
&gt; 23/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/iommu-riscv-test =C2=A0=
 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.76s =C2=A0 4 subtests passed<br>
&gt; 24/39 func-quick+func-riscv32 - qemu:func-riscv32-opensbi =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.87s =C2=A0 3 subtests passed<br>
&gt; 25/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/k230-wdt-test =C2=A0 =
=C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1.06s =C2=A0 7 subtests passed<br>
&gt; 26/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/sifive-e-aon-watchdog-<=
br>
&gt; test =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 1.29s =C2=A0 10 subtests passed<br>
&gt; 27/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/qom-test =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 2.22s =C2=A0 8 subtests passed<br>
&gt; 28/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/device-introspect-test<=
br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 2.28s =C2=A0 6 subtests passed<br>
&gt; 29/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/device-introspect-test<=
br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 2.58s =C2=A0 6 subtests passed<br>
&gt; 30/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/test-hmp =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 3.26s =C2=A0 8 subtests passed<br>
&gt; 31/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/netdev-socket =C2=A0 =
=C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.32s =C2=A0 10 subtests passed<br>
&gt; 32/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/netdev-socket =C2=A0 =
=C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.30s =C2=A0 10 subtests passed<br>
&gt; 33/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/qom-test =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 3.80s =C2=A0 12 subtests passed<br>
&gt; 34/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/test-hmp =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 5.48s =C2=A0 12 subtests passed<br>
&gt; 35/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/qmp-cmd-test =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 8.44s =C2=A0 64 subtests passed<br>
&gt; 36/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/qmp-cmd-test =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 8.43s =C2=A0 64 subtests passed<br>
&gt; 37/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/bios-tables-test =C2=A0=
 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERROR =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 17.02s =C2=A0 killed by signal 6 SIGABRT<br>
&gt; &gt; &gt; &gt; MESON_TEST_ITERATION=3D1<br>
&gt; &gt; &gt; &gt; PYTHON=3D/scratch3/yihaoc/sifive/qemu/build/pyvenv/bin/=
python3<br>
&gt; &gt; &gt; &gt; QTEST_QEMU_IMG=3D./qemu-img<br>
&gt; &gt; &gt; &gt; ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:pri=
nt_summary=3D1<br>
&gt; &gt; &gt; &gt; MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:pri=
nt_summary=3D1:p<br>
&gt; &gt; &gt; &gt; rint_stacktrace=3D1<br>
&gt; &gt; &gt; &gt; G_TEST_DBUS_DAEMON=3D/scratch3/yihaoc/sifive/qemu/tests=
/dbus-<br>
&gt; &gt; &gt; &gt; daemon.sh QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-=
<br>
&gt; &gt; &gt; &gt; daemon/qemu-storage-daemon<br>
&gt; &gt; &gt; &gt; UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:pr=
int_summary=3D1:<br>
&gt; &gt; &gt; &gt; print_stacktrace=3D1 RUST_BACKTRACE=3D1 MALLOC_PERTURB_=
=3D162<br>
&gt; &gt; &gt; &gt; QTEST_QEMU_BINARY=3D./qemu-system-riscv64<br>
&gt; &gt; &gt; &gt; /scratch3/yihaoc/sifive/qemu/build/tests/qtest/bios-tab=
les-test<br>
&gt; &gt; &gt; &gt; --tap -k<br>
&gt; <br>
&gt; 38/39 qtest+qtest-riscv32 - qemu:qtest-riscv32/qos-test =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A043.47s =C2=A0 191 subtests passed<br>
&gt; 39/39 qtest+qtest-riscv64 - qemu:qtest-riscv64/qos-test =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A043.82s =C2=A0 191 subtests passed<br>
&gt; <br>
&gt; Ok: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A034 =C2=A0<b=
r>
&gt; Fail: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 <br>
&gt; Skipped: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4=C2=A0=C2=A0<br>
&gt; <br>
&gt; The failure is because=C2=A0Zicclsm is mandatory in the RVA22U64=C2=A0=
profile.<br>
&gt; But before this patchset, ZIcclsm was enabled=C2=A0automatically when<=
br>
&gt; has_priv_1_11 was true.<br>
&gt; With this patchset, Zicclsm must be=C2=A0explicitly added to the RVA22=
U64<br>
&gt; profile&#39;s extension list.<br>
&gt; <br>
&gt; After the fix, running:<br>
&gt; $=C2=A0meson test -C build &quot;qemu:*riscv*&quot;<br>
&gt; <br>
&gt; [1/9] Generating qemu-version.h with a custom command (wrapped by<br>
&gt; meson to capture output)<br>
&gt; =C2=A01/41 func-quick+func-riscv64 - qemu:func-riscv64-linters =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKIP =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0.15s =C2=A0 0 subtests passed<br>
&gt; =C2=A02/41 func-quick+func-riscv64 - qemu:func-riscv64-empty_cpu_model=
 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.19s =C2=A0 1 subtests passed<br>
&gt; =C2=A03/41 func-quick+func-riscv64 - qemu:func-riscv64-info_usernet =
=C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.26s =C2=A0 1 subtests passed<br>
&gt; =C2=A04/41 func-quick+func-riscv32 - qemu:func-riscv32-linters =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKIP =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0.21s =C2=A0 0 subtests passed<br>
&gt; =C2=A05/41 func-quick+func-riscv32 - qemu:func-riscv32-empty_cpu_model=
 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.24s =C2=A0 1 subtests passed<br>
&gt; =C2=A06/41 func-quick+func-riscv64 - qemu:func-riscv64-version =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.30s =C2=A0 1 subtests passed<br>
&gt; =C2=A07/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/cdrom-test =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.39s =C2=A0 1 subtests passed<br>
&gt; =C2=A08/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/machine-none-test =
=C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.17s =C2=A0 1 subtests passed<br>
&gt; =C2=A09/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/cdrom-test =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.42s =C2=A0 1 subtests passed<br>
&gt; 10/41 func-quick+func-riscv32 - qemu:func-riscv32-version =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.28s =C2=A0 1 subtests passed<br>
&gt; 11/41 func-quick+func-riscv32 - qemu:func-riscv32-info_usernet =C2=A0 =
=C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.32s =C2=A0 1 subtests passed<br>
&gt; 12/41 func-quick+func-riscv64 - qemu:func-riscv64-vnc =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKIP =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0.35s =C2=A0 0 subtests passed<br>
&gt; 13/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/riscv-csr-test =C2=A0 =
=C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.30s =C2=A0 1 subtests passed<br>
&gt; 14/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/readconfig-test =C2=A0 =
=C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.15s =C2=A0 1 subtests passed<br>
&gt; 15/41 func-quick+func-riscv32 - qemu:func-riscv32-vnc =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKIP =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0.33s =C2=A0 0 subtests passed<br>
&gt; 16/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/machine-none-test =C2=
=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.14s =C2=A0 1 subtests passed<br>
&gt; 17/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/readconfig-test =C2=A0 =
=C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.14s =C2=A0 1 subtests passed<br>
&gt; 18/41 func-quick+func-riscv64 - qemu:func-riscv64-migration =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.75s =C2=A0 3 subtests passed<br>
&gt; 19/41 func-quick+func-riscv32 - qemu:func-riscv32-migration =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.78s =C2=A0 3 subtests passed<br>
&gt; 20/41 func-quick+func-riscv32 - qemu:func-riscv32-opensbi =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.84s =C2=A0 3 subtests passed<br>
&gt; 21/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/iommu-riscv-test =C2=A0=
 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.78s =C2=A0 4 subtests passed<br>
&gt; 22/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/k230-wdt-test =C2=A0 =
=C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1.08s =C2=A0 7 subtests passed<br>
&gt; 23/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/qmp-test =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 1.16s =C2=A0 9 subtests passed<br>
&gt; 24/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/qmp-test =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 1.14s =C2=A0 9 subtests passed<br>
&gt; 25/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/sifive-e-aon-watchdog-<=
br>
&gt; test =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 1.28s =C2=A0 10 subtests passed<br>
&gt; 26/41 func-quick+func-riscv64 - qemu:func-riscv64-opensbi =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 1.81s =C2=A0 4 subtests passed<br>
&gt; 27/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/qom-test =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 2.06s =C2=A0 8 subtests passed<br>
&gt; 28/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/device-introspect-test<=
br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 2.19s =C2=A0 6 subtests passed<br>
&gt; 29/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/device-introspect-test<=
br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 2.48s =C2=A0 6 subtests passed<br>
&gt; 30/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/test-hmp =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 3.27s =C2=A0 8 subtests passed<br>
&gt; 31/41 func-quick+func-riscv32 - qemu:func-riscv32-monitor_hotplug =C2=
=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 3.46s =C2=A0 7 subtests passed<br>
&gt; 32/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/netdev-socket =C2=A0 =
=C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.32s =C2=A0 10 subtests passed<br>
&gt; 33/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/netdev-socket =C2=A0 =
=C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.31s =C2=A0 10 subtests passed<br>
&gt; 34/41 func-quick+func-riscv64 - qemu:func-riscv64-monitor_hotplug =C2=
=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 4.00s =C2=A0 7 subtests passed<br>
&gt; 35/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/qom-test =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 4.40s =C2=A0 13 subtests passed<br>
&gt; 36/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/test-hmp =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 6.63s =C2=A0 13 subtests passed<br>
&gt; 37/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/qmp-cmd-test =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 8.45s =C2=A0 64 subtests passed<br>
&gt; 38/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/qmp-cmd-test =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 8.50s =C2=A0 64 subtests passed<br>
&gt; 39/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/bios-tables-test =C2=A0=
 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A035.13s =C2=A0 3 subtests passed<br>
&gt; 40/41 qtest+qtest-riscv64 - qemu:qtest-riscv64/qos-test =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A046.41s =C2=A0 192 subtests passed<br>
&gt; 41/41 qtest+qtest-riscv32 - qemu:qtest-riscv32/qos-test =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A046.45s =C2=A0 192 subtests passed<br>
&gt; <br>
&gt; Ok: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A037 =C2=A0<b=
r>
&gt; Fail: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 <br>
&gt; Skipped: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4<br>
&gt; <br>
&gt; All the tests=C2=A0passed.<br>
&gt; <br>
&gt; I will send out=C2=A0the v5 patchset to fix the issue.<br>
&gt; <br>
&gt; BTW, I noticed you ran more tests than I did.<br>
&gt; Could you please share your test command so I can reproduce it on my<b=
r>
&gt; end?<br>
<br>
I&#39;m just running `make check`.<br>
<br>
Even your v5 is failing make check on the `target/riscv: Support<br>
raising misaligned exceptions for scalar loads/stores` patch<br></blockquot=
e><div><br></div><div>Hi Alistair,</div><div><br></div><div>Does every sing=
le patch in the patchset need to pass `make check`,=C2=A0<span style=3D"bac=
kground-color:transparent">or is it enough for the final patchset to pass?<=
/span></div><div><span style=3D"background-color:transparent"><br></span></=
div><div><span style=3D"background-color:transparent">I only ran the `make =
check` for the final patchset:</span></div><div><span style=3D"background-c=
olor:transparent"><br></span></div><div><span style=3D"background-color:tra=
nsparent">---</span></div><div><span style=3D"background-color:transparent"=
><br></span></div><div>345/352 softfloat+softfloat-ops - qemu:fp-test-log2 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0.11s<br>346/352 qapi-schema+qapi-frontend - qemu:=
QAPI schema regression tests =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.14s<br>347=
/352 tracetool - qemu:dtrace =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.22s<br>348/352 tracetool=
 - qemu:ftrace =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.11s<br>349/352 tracetool - qemu:log =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.12s<br>350/352 tracetool - qemu:simple =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0.12s<br>351/352 tracetool - qemu:syslog =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0.12s<br>352/352 tracetool - qemu:ust =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0.14s<br><br>Ok: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0341 <br>Fail: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 <=
br>Skipped: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 11=C2=A0</div><div><br></div=
><div>---</div><div><span style=3D"background-color:transparent"><br></span=
></div><div><span style=3D"background-color:transparent">If we need to pass=
 every single patch in the patchset,</span></div><div><span style=3D"backgr=
ound-color:transparent">then I&#39;ll have to move patch #4, #5, #7 before =
patch #2 in v5 patchset,</span></div><div><span style=3D"background-color:t=
ransparent">so that everything is ready before Zicclsm is implemented.</spa=
n></div><div><br></div><div><br></div><div>Regards,</div><div>Frank Chang</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Alistair<br>
</blockquote></div></div>
</div>

--000000000000b3de6e065666891e--

