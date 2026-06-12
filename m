Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC445CD98CC
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 04:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXtxm-00033V-Jz; Fri, 12 Jun 2026 00:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wXtxk-00033F-No
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 00:57:48 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wXtxg-0000Lh-Mv
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 00:57:47 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-68d234218bcso961410a12.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 21:57:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781240263; cv=none;
 d=google.com; s=arc-20240605;
 b=HlZePxhCQZOc0bF7Hsmu9eTHUGWnN2D6tmtmfn4ftL5lGerJuDWreUNzEHAro6EyqD
 9yMWb7d9r91ZTlq69C99mbjaLYY+eIG01cnwn4ael2KhvYwfQE69rVMtC1iNp7Umildb
 SoZ8zSWXPupf0uvRP5bpJ0+U/yd5e3JtM6619JMBaOIaEvX2UavHXUQlPtCIPLiQTRhZ
 ppgxwasKtD8MXfcduhtn+wHdyYcWYouPv9eu8d+1hNU5cr7YOacOAQihNGZJOwOEbImu
 hl1Q5DUdfDqQdFWRu0t67Tw00k2SJ8ODUaMuvwFAkL7zIp31C5MGZY+VKGfO3wsReJd2
 rjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GrWsgLLE0QF9Y5SzQ9tCmrMtpXKzoSOeSixVmsHiDiE=;
 fh=XErS4XjkAQDBkClscxjQUC7TY1MVaIkgq5whaEGujtU=;
 b=SqwWqKKIaNbYwHViSpG9w0KpiyeQvCbSF3OkaP1KM4eZTFAp5ZyvIjxksj++wbz8dc
 wEEtXEHxkZ7fZagl/VW/jh0Jfk/RV/Le0m0TbUOJpWHnciDBCbHZNL+dM1TwOBUmAsf7
 i+Er4cwjFi6o1NGsqhg53uYPR5CQVFnmRr7VnkdKA5pCeHKPYnXdt/hU241JrAwmO68J
 +FC5vpHowwNIrSqZMW4RlYnAhpnV441NjBjvtFJTETL+O66c5REpCPicoFl+CgOtJOnd
 o8HLUn4ggTo1S5y0DKI+EZxvcJTHaJQ3aEsuuAa5TxrJc8lD1Fu4Wvo5WDk0wGslHU3a
 1IqQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781240263; x=1781845063; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GrWsgLLE0QF9Y5SzQ9tCmrMtpXKzoSOeSixVmsHiDiE=;
 b=pc37tFVhcwZJ8UuAl4mp+Ajp35P/lTG4RipDTtDmivFnTMZadu2KEWpkFJUnjAdLyL
 R7U5hVMr57ol9Gf8tNeXdN0KLks1PGeixcBV1h8S9WwqSv6e17ynxR/aWNZzMIcv9KHw
 fFbSNi2EnMNiratU3A7mzIgX3qJCZPxD/oVzzBjQztbEd+NNokcTPavY5GoPBaBw70ls
 2F0y9KYZYxFA1QkYnF7suL2edq5OANLxX9eEOTg7RLGmNciOOcF8bmSGwHXH1H7G0msU
 rW//cBJrE3ylAvFi8sS1VTi2bfUJgvksYUFBoBRdhFAxuCOa6MZcAsaD9mVsrvv5+O2A
 WwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781240263; x=1781845063;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GrWsgLLE0QF9Y5SzQ9tCmrMtpXKzoSOeSixVmsHiDiE=;
 b=MkrJaz5VMgC1kdQHk1mcWfrIHf2kW95+ynZo7L6fOeD5idwqLhvpZKwjKU8SxK4lZX
 MboCaom8hepwKd8yKyDS1n0dI7BA1OElRCY0Sk75BlSyV4Nc8GLmLqL6pwA/xG9OEmxd
 UGTYfzQGcPRGCedFd4ZhA9nCeBF1VsifkHzXuUWb827MaoB8IO6IV1KDfYYcgm68ZCQ0
 8qyC2mH9j8uAooNP2cLSHdxBztEBhmgKeaO9+HLYNPpOUokwuvu3AS30mO4M77v0tXI6
 0ehw1C3On7etILZvSGZR6z5UxG7PLjw1BC46ukMe4nTjdhOLZEG2qp2aq9usqIWi62Sw
 y7uQ==
X-Gm-Message-State: AOJu0Yw4Ojlg4/rKmephhjBHiTzZRd0FFa2pR4V4IUZCs50rbHxHH+77
 16NkFDreOafrxkrGW/dkdBWo2pabaH5nOkg2BKcCdZDha9O9jT2hAhnWKJNgfjevAuMQ8Rn/5Cu
 HfE7XaRwp+L7ieCeVRWWpx5SEI806rRg=
X-Gm-Gg: Acq92OHn/pQ2P8wF6ini5QVzpVQgxEbjH/fTFfld+rhkX1vlKxhSoQahWtQWhLj+fS+
 qEQCDIIT7SLiCnYHqyR/tq8qhwbTPGpk4fxvBNZQT6LkpjxJPtea5gOFhG7eZ8ELpIZIbvv1pua
 GY5ZTuPX6bhl2NEZJvtIt5UiHDnKUr3Ohq/6RHVLVh4nvCfSQ5p2od6d7/J0Iwo2QwK7Qo1qDov
 r5c3pujMlvvLPks2lvtqoKcJ6sKeI9pqNi2Q8MpMd0pFWp1kKhYmBSMIADQSm8wYY76sfGZvbzR
 xS3UcTmaq17LpyLRbj/hkvYGWp5nBCMiP5GgfQ==
X-Received: by 2002:a05:6402:5005:b0:687:1c98:a19a with SMTP id
 4fb4d7f45d1cf-69378a4ba21mr441406a12.13.1781240262965; Thu, 11 Jun 2026
 21:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260611105037.157773-1-max.chou@sifive.com>
In-Reply-To: <20260611105037.157773-1-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 12 Jun 2026 14:57:15 +1000
X-Gm-Features: AVVi8CdJgddAST_SwdQTsK7KGjji_gvVr4Fxz5Bx1lATR6wdHao38tbBmLsBeHw
Message-ID: <CAKmqyKMsnxr7xEu-JarHXk6Dd6FpJFcR=FE-jvuWxJJdr6XS2g@mail.gmail.com>
Subject: Re: [PATCH 0/2] target/riscv: Fix mstatus.FS dirty tracking for FP
 exception-raising instructions
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
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

On Thu, Jun 11, 2026 at 8:52=E2=80=AFPM Max Chou <max.chou@sifive.com> wrot=
e:
>
> The RISC-V privileged architecture specification 3.1.6 defines
> mstatus.FS that
>
>   "The FS field encodes the status of the floating-point unit state,
>    including the floating-point registers f0=E2=80=93f31 and the CSRs fcs=
r,
>    frm, and fflags."
>
> Any instruction that modifies this state must transition mstatus.FS
> to dirty. In particular, fflags is part of the tracked state, so any
> instruction that sets a new bit in fflags (e.g. raises a FP exception
> flag =E2=80=94 must set mstatus.FS to dirty).
>
> But current implementation was failing to set mstatus.FS to dirty:
>
> 1. Scalar FP instructions that write integer registers (comparisons
>    and FP-to-integer conversions):
>
> Instructions such as FEQ.S, FLT.D, FLE.H, FCVT.W.S, FCVT.WU.D,
> and FCVTMOD.W.D write their results to integer registers, so
> mark_fs_dirty is correctly not called to set fs to dirty at
> translation time. However, following scalar instructions may raise FP
> exception flags:
> - Comparisons: fle/fleq/flt/fltq/feq
>   =E2=80=94 raise NV on NaN operands
> - FP-to-integer: fcvt.[w|wu|l|lu]/fcvtmod.w.d
>   =E2=80=94 raise NX on inexact or NV on out-of-range
>
> 2. Vector FP instructions (all arithmetic, comparison, conversion, and
>    reduction operations in the V extension):
>
> When a vector FP instruction raises a FP exception (e.g., vfdiv.vv
> producing a divide-by-zero, or vmflt.vv comparing NaN values), it
> modifies fflags =E2=80=94 an FP CSR =E2=80=94 but current implementation =
did not dirty
> mstatus.FS.
>
> This patchset fixes this issue by
> 1. Save float_exception_flags before the softfloat operation
> 2. Perform the operation
> 3. If any new exception bits are set, set fs to dirty
>
> Max Chou (2):
>   target/riscv: Set mstatus.FS dirty when scalar FP raises exceptions
>   target/riscv: rvv: Set mstatus.FS dirty when vector FP raises
>     exceptions

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.h           |   1 +
>  target/riscv/fpu_helper.c    | 157 +++++++++++++++++++----
>  target/riscv/vector_helper.c | 241 +++++++++++++++++++----------------
>  3 files changed, 258 insertions(+), 141 deletions(-)
>
> --
> 2.43.7
>
>

