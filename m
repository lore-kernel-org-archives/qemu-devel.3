Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82D4FF8867
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 03:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHYyV-0007Ul-F2; Mon, 27 Apr 2026 23:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHYyT-0007UI-Vc
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 23:19:02 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHYyS-0007Oy-5Y
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 23:19:01 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bad54961385so770437366b.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 20:18:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777346338; cv=none;
 d=google.com; s=arc-20240605;
 b=L/FHmpZ5Z88EA8q7PWHyVHw44C+SanGtCaoKSUPi0F+fgFV/9Quc4n8M7zRns0/J2k
 xeEyPbDVfc9m/rwsJAYyzoyxUH706h0PW9vK10OALQWnDcAr/qLN+GV/w7h24tceeqZn
 S/La2MYRlycxMShgqbdb8Z5CjTPxDh4rEkDB2Q/LGnG3nkYP956oQBpDtOnfcN/xfIOi
 3MBTzFJbT6VV3fFRjYghGth8jqn9J0kHlawq6v0f0k8dsD5GIld9wLiiY7RZTO2iJPb0
 FxbBNLdAYfXQb5dmJcazfcZ8oSzGP4MNJZnFzugpf8SlLIqrQWzfP5vNOwe1qExAPFst
 2fdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mSD+0BVNigxnV5IVuHOgPy56vS2FASO6+YWtPipPXsc=;
 fh=PivOCLvsQE3LN87aVkcQPB0fR6LTCeyMhSuv631uwKg=;
 b=WbqJ74GH8u+EoVZdIGrlwvOo8ePJ0Y2NOfbAJhQN/vfPi+yQze67N2yHx94oFip2KK
 /JBRPF/c76XNi+BOwvaEaJf/NfPXNzsEU1MrvsBlEsicxjkNAngQ8xbDU7hsmSsnK9lW
 ISN5zaUUkdT3RfwtaOgIbkjBcZcWNhaFNuoU4MJ+s9YYupOC/TVYP0vJTicYPLwmKrf8
 Nuhrn6WTe8CWVBsGYIRXoAkpHa8IxHgzCrllox0yOnYZ21x0Apzu3paOL0qo9ZKjVP/Z
 bJBqvwlgTEPhOTewT0lOvErmPpkepeCjGYr3tEOHk1+1CxNvnHtwateo+hjptJvgxhq4
 +4Fw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777346338; x=1777951138; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSD+0BVNigxnV5IVuHOgPy56vS2FASO6+YWtPipPXsc=;
 b=R8QBTjiqi1ydKWnkfyllwo4G73T2yAVeSlew/n4/tHq8GFohDuFX6bbBfLAgTAxTJH
 xyGyUkP4WRyO22dSu6IjK+dpvWi5Vrpb7h2EogFIBCL/Kbc/U1JhADOhJn/m+uJC1KIB
 bh8YWnCX4GAx202nhE9XbKZMEtPpxuH3afBpdocMgx34Vl7DFnCp4EwQPn6LFmgYcK/j
 3+5bANSeTIm31f9tiwvf4Bo+nM9J1thf6XArdDdD3ekaGJz4O3kLC3bGEjy4HIYGYHI7
 xUtXq67YQ7UP+U7iVCmx2ze/P824zy24ghPcGxuRt54TIHJYufBB0Om4+dh744bXTRCa
 jt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777346338; x=1777951138;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mSD+0BVNigxnV5IVuHOgPy56vS2FASO6+YWtPipPXsc=;
 b=sPkV1bk3JoGk5KttVws2WtW8+1r9bOOHFgAefI2VUpVbx39dRZPHfFb3sbINm21efF
 ypyA8HXazsQ63k8QIxPdEyHRcKhbVWh/WRqik0EQVJ2z+oQltLxr9gOciTo/pYPt+SV5
 9q79tNBq/e0wM6oHWtbMCznV2kNSPDhhoILOxkQKIQSMFds28qtK5vNfohfz5t607HJj
 RHP8cN3nu7ztc8slP4Qoc6vSlxPPwwfB4QSwqaJVLdfnmYbffn+i6rBndc5sjHBdJevP
 aWqjXMImbkPLTa/0ZNVwplQyQ/Cwh+RxoaaCxjUilRWcZGGYJf/Mho2pePceE6KiSdjJ
 JedA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8F8jT0uAyqfZV0J1JRdZJfKFWfkg9nNUyl8GZ3Y4PO/EnhzdhxUosFRazXMGhHdbxXDcfJDUy6hrkP@nongnu.org
X-Gm-Message-State: AOJu0YyyaRsRohlm2zVvxKKystA9T0HkBv3UwW33osCgTH9jsCQVDJqL
 rXlWBxFl3pFka9701exb0w/1NWjBghrpQpgF1DjA1ZPIdwH63lBDJuTD1vNlwylWhbznOTx1C7F
 jV7geL/VkvVBU0SPK56/Ry7ytAKgqtSo=
X-Gm-Gg: AeBDiesSp7rQka7F+qGJssnAorDIqHLlb4iuJNjJgWMUMUXN2RQnZFIRkGMRx6kScHi
 hU3e725+GrQbxAmNHKPiJIoPpgbIS0Su+0hTkwQ8Nm5slGmiaQYQqqLVfqMuLs0QjkvAhIe1T/G
 qtnynLbA6fcKLIUr1atN4vnHbXPV73FkPCwmlZ9KSF3FV2aZ2jANRRTBvpI7mWSQvBSehG9OjyC
 nVQHqvBpStKeRcF+u5YZlFxZ2WWxkHhI+y/DfIE1TLWCEggv4cKgw61e7w6qedeQx9PIxMsdzQR
 Ol1qiZmtJzBM0Ct20equw1eKggwGop+GaDnDxd1IGZOtJNmU
X-Received: by 2002:a17:907:d30c:b0:bac:1263:2562 with SMTP id
 a640c23a62f3a-bb803875ba9mr75663166b.24.1777346337861; Mon, 27 Apr 2026
 20:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260415233740.3027321-1-alistair.francis@wdc.com>
In-Reply-To: <20260415233740.3027321-1-alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 28 Apr 2026 13:18:31 +1000
X-Gm-Features: AVHnY4Iku_tZjgmRwtOxyOmipr0JcE49FJF8EtoIpfYeuBbZL3ictxA7rr384N8
Message-ID: <CAKmqyKP3hf3XOH+rmOUauUV5S4TDoiyOw6f9bQQHRgHm1tEGWQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] target/riscv: A collection of bug fixes
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x634.google.com
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

On Thu, Apr 16, 2026 at 9:38=E2=80=AFAM <alistair23@gmail.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> This is a collection of patches to fix a few of the open RISC-V bugs [1].
>
> 1: https://gitlab.com/qemu-project/qemu/-/work_items?first_page_size=3D20=
&label_name%5B%5D=3Dtarget%3A%20riscv&sort=3Dcreated_date&state=3Dopened
>
> v2:
>  - Drop merged patches
>  - Fixup typos
>  - Removed read/write syscall print functions and use %p instead
>  - Rework "Don't OR mip.SEIP when mvien is one" patch
>
> Alistair Francis (4):
>   target/riscv: Generate access fault if sc comparison fails
>   linux-user/strace: Use pointer type for read and write values
>   target/riscv: Don't OR mip.SEIP when mvien is one
>   target/riscv: Use ELEN for Fractional LMUL check

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/helper.h                   |  3 +++
>  target/riscv/csr.c                      |  8 ++++++++
>  target/riscv/op_helper.c                | 14 ++++++++++++++
>  target/riscv/vector_helper.c            |  9 ++++-----
>  target/riscv/insn_trans/trans_rva.c.inc |  6 ++++++
>  linux-user/strace.list                  |  4 ++--
>  6 files changed, 37 insertions(+), 7 deletions(-)
>
> --
> 2.53.0
>

