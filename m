Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8EEC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 04:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whgqA-0003GU-Ps; Thu, 09 Jul 2026 00:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1whgq9-0003Fs-0M
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 00:58:25 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1whgq6-0002Ob-VU
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 00:58:24 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6983f20a8bfso751764a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 21:58:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783573098; cv=none;
 d=google.com; s=arc-20260327;
 b=BAdRDEEmihrrj43t9LPHbej3ElcUcUtKSMtQbX9cnFfV7mCI7eko906JDle8hVCORV
 Q36TRdHHMX7xenbQikn9u4saYTO5gGO/cB9FX73EBJARcrDi5wJzuo9KtGXNzLe/XSPq
 KLH4TyQ1zWq+0ZcCWgAfPYfSq6vc8H7Rh702k8t3r3qDsuDIvlJK64GeAGAaKP3+qcnY
 W4HXXaunnE7gLc0kvHi3VVozNs/RGAOhgCNtPEKYNeG9XeElDhZdAJBZyq3zLy5yinIc
 dbbGWY9L3rzrNTDZFOSyqWlwQhwrtWzAp51tT601xEPC0efWRGjtUVlC9uQmSttczW8r
 Qa8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6M7152Ey+cLEt8trzGQhwm7E7uUgPw9+yf5f13TRVxQ=;
 fh=kCLCvglG9lddGd1nqQDQ+3KB3zssA+mVcU6CE1qr+iA=;
 b=O9GtMdJVcbZMW+DFbUm5mJ1si/4nNwhuZyUsCWr8DGl46ZPnZcLfcA0LqDd2EM9N2g
 ff7DHf7uX5+pn/8gqrOC9F+OV7BLr3Sa6WcH0OMLmfsyURC8+JyswwVttwQgdnhubT+Y
 T9/v9FkOyIWDBnVt7rgjyWr/SPSiFBWR4G7nKpTi0WNk5wdGDbNx5LW+7Q3cGElFnQJV
 qpCCLBQfQUPO+9EdloMwe2YoEf29fi9g6EENo8dul7iOm2vA4Nura3olfurZvwU5cxYL
 iKoL0LWT+GV1ZN+7Pt2QpaHq406G1IcEFBaEcpXXd1hf3+/UYSaX9dnzkXGed6xpNQmS
 N9tw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783573098; x=1784177898; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6M7152Ey+cLEt8trzGQhwm7E7uUgPw9+yf5f13TRVxQ=;
 b=O5GwlWK+n5sB4tu95eA6RDoJqf7+Yt+xJmRkmbMBIlZL1k+5lVHw8eIKAXK7rKXZbP
 UCqw1CkuHv/cKLkLpmxS3FfMbD2gl5rXAanP1iSbKDlNJXJe3cOn1Sf58N1rNocPHR+E
 7VmJHBAHuCEkIhITQ/dwtfs5OTedsOg5qTVAAAGYnIBoPoTPS3lqQOtxxPdFFWeQeKbO
 UpkSzXMZqyi1Df1px7EiqjUxtTCoRpEYKgL+KOtJTh+kg4FGH8w3anKHCjM0W7V9wmbj
 bCh29nFr0ghG3WbqKrGa0TH0nkPZlKpBn/QsT9m523A+efAaNQWiQmg84gNFZaXMFOGe
 2s1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783573098; x=1784177898;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6M7152Ey+cLEt8trzGQhwm7E7uUgPw9+yf5f13TRVxQ=;
 b=Hhm3EkDnf8eKzUS5RrWdKL+cepJ4IlNvLiIzAfnyJciyoYG8H4cxw3hq4SoGKhlD6b
 J8UHdsMo1UHkEtSKFVQ9ALY/rcdzc4+3r72QavJ8lTnN0uNBhM6waolpe4hg8ZuZlpW1
 FgVcUl/gTk/+WDK1fJnUtIW2RPreDY6ciqKcKX/BQByRDSNEmB9uSSDMpUBFRU/9GqTQ
 ygxNlfndIY/gDzKkG5omqLzjV2LT5vU5nwjngAhC/W149KitvZmzL4HgquLZDUux8dZn
 O95GjaN/6d3CY30ig9kyzmykTVszMeo6EaVlLqU/Cx1zEVu5fYwdz4iss0zfDGVFc8G/
 vjTg==
X-Gm-Message-State: AOJu0YwMGG7FJmRV4y4yrth9jaV9kny5ccF3NTG0oxuh0rOvIUda2cAF
 5SknNrIx4cbEQnMtwgsZaRgj2k2iOUGSxSZG3F5CetKw3HLx9/c/+CLcaX7T6yA/8K8BNlan2NQ
 28FgZdNpxcO0u1R3MHlGC+/56pbgqWJU=
X-Gm-Gg: AfdE7clk7wKBSSQSOXlWF+tpK6E00fC/MWBJL1dYpi9E8wW7nvRzqv+ty6vg+1DjSRg
 MBbxJaKBAJjCCGqBmYIIna6N4ZGi4noIbiCiVD6nEwvm06oT8YgnmQTLkXVbd6zY3gXExWeK3ls
 kCNL7+KXobdbdefyiLVoeZDB77RFa8mUdX1ZgReKxQhnUDrUCb0ZDKDBVYmfNpnIRxnnSBhwAXz
 +Hd9sUd3XfDX4fjnGxh9rQXh1rxw+IIfDZV4npDBw6rhB889I6l6gs/QWhlqKPULTnQeV/N6cEw
 4jOfGydyGW1y++q4aI6hI2dwlOkSw0stE5H2EQ==
X-Received: by 2002:a05:6402:320c:b0:698:b9ca:e662 with SMTP id
 4fb4d7f45d1cf-69ab4453bb1mr2302494a12.6.1783573097867; Wed, 08 Jul 2026
 21:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260707091039.2574638-1-frank.chang@sifive.com>
In-Reply-To: <20260707091039.2574638-1-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Jul 2026 14:57:51 +1000
X-Gm-Features: AUfX_myY6X8vr7HbYLrAXMhBWylHKAwonF1jcsVNDJOdMVgSaySvkcpL-cA3kWc
Message-ID: <CAKmqyKNVo-rdOtN0t9XzRB3teF6nNEgh_twkf9s8zX2q0dPU=w@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] target/riscv: Support the true Zicclsm extension
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jul 7, 2026 at 7:11=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> Support the true Zicclsm extension so that we can trap misaligned accesse=
s
> when Zicclsm is disabled.
>
> To enable/disable Zicclsm, simply set zicclsm=3D[true|false], e.g.:
>   -cpu rv64,zicclsm=3D[true|false]
>
> QEMU will raise a misaligned load/store exception when executing misalign=
ed
> load/store instructions if Zicclsm is disabled.
>
> Changelog:
>   v4:
>     * Align ROM reset vector data at 8-byte aligned offsets.
>   v3:
>     * Enable Zicclsm for the compatible CPUs.
>     * Rebase to the latest riscv-to-apply.next.
>   v2:
>     * Use (size_memop(size) | mo_endian_env(env)) to calculate MemOp.
>     * Use (log2_esz << MO_ASHIFT) to calculate aligment MemOp for
>       vector load/store whole register instructions.
>
> Frank Chang (6):
>   target/riscv: Add Zicclsm CPU option
>   target/riscv: Support raising misaligned exceptions for scalar
>     loads/stores
>   target/riscv: Support raising misaligned exceptions for vector
>     loads/stores
>   target/riscv: Enable Zicclsm for the compatible CPUs
>   hw/riscv: sifive_u: Align ROM reset vector data
>   target/riscv: Update Zicclsm ISA string and expose it as a CPU
>     property

Hmmm.... Still seeing failures

556/556 qemu:func-quick+func-riscv64 / func-riscv64-opensbi
               TIMEOUT         90.02s   killed by signal 15 SIGTERM
>>> LD_LIBRARY_PATH=3D/var/mnt/scratch/alistair/software/qemu/build/contrib=
/plugins:/var/mnt/scratch/alistair/software/qemu/build/tests/tcg/plugins MS=
AN_OPTIO
NS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print_stacktrac=
e=3D1
QEMU_TEST_QEMU_BINARY=3D/var/mnt/scratch/alistair/software/qemu/build/qemu-=
system-riscv
64 RUST_BACKTRACE=3D1
MESON_BUILD_ROOT=3D/var/mnt/scratch/alistair/software/qemu/build
UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:prin=
t_stac
ktrace=3D1 ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summar=
y=3D1
MESON_TEST_ITERATION=3D1 MALLOC_PERTURB_=3D7
QEMU_TEST_QEMU_IMG=3D/var/mnt/scratch/alistair
/software/qemu/build/qemu-img QEMU_TEST_GDB=3D/usr/bin/gdb
PYTHONPATH=3D/var/mnt/scratch/alistair/software/qemu/python:/var/mnt/scratc=
h/alistair/software/qemu/t
ests/functional
/var/mnt/scratch/alistair/software/qemu/build/pyvenv/bin/python3
/var/mnt/scratch/alistair/software/qemu/tests/functional/riscv64/test_opens
bi.py


Summary of Failures:

556/556 qemu:func-quick+func-riscv64 / func-riscv64-opensbi
      TIMEOUT         90.02s   killed by signal 15 SIGTERM


Alistair

>
>  hw/riscv/sifive_u.c                     | 11 +++--
>  target/riscv/cpu.c                      |  9 +++-
>  target/riscv/cpu_cfg_fields.h.inc       |  2 +
>  target/riscv/insn_trans/trans_rvi.c.inc |  6 +++
>  target/riscv/insn_trans/trans_rvv.c.inc | 18 +++++--
>  target/riscv/vector_helper.c            | 65 +++++++++++++++++++------
>  6 files changed, 87 insertions(+), 24 deletions(-)
>
> --
> 2.43.0
>
>

