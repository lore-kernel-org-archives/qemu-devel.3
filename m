Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26352106FD63
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 01:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0r2q-0005IE-FF; Thu, 12 Mar 2026 21:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0r2p-0005Hx-Hm
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 21:10:27 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0r2n-00025I-HB
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 21:10:27 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-66391baf250so1187549a12.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 18:10:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773364223; cv=none;
 d=google.com; s=arc-20240605;
 b=QQE0CBou2e8h/U0ywvHkP+2bX0vwQdVWyWpOK2XHqUpHS6u6zbaC7z1d8+Ezdmu/uf
 AHp1PHJwb58vew72YOmlFNrD951RvOiPQh+4c4WdNgOzy4VQY2wLB9k2tNfixyFBx4p3
 eFigXtZru3mwcXILuiit12pMwWXyL3uHZd9CK465oFD1zC4KOzjF3qrcyOJumz84YZFr
 9h5VEYRHEbK7fBZqcQKk8T+jhn60luUiTlIMx+VFVS5+7RCes+Epu+2hN5N5IoqU4YAv
 DlmqFnOj95Mm7jgOPUvwLWT50c/uRYrpoNjAvfB51k2qt32yeCv0zEEVFScCy3+QOidC
 tssw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0Hyh/lMcKuIFQfIR4UpKUL2ZxXZ8F//Dg8EFbXTrrUk=;
 fh=XErS4XjkAQDBkClscxjQUC7TY1MVaIkgq5whaEGujtU=;
 b=hG22ClgTEEiatP+kRxG1Nwc22d/IGHgNt2OUOU/kt8YYN1nIc4L0kI3QVpXGPyapiI
 GXe/hAA02zNzjiFRWmOW3QoaIbDqKxs+660DepQFnNx4S3xG/WxxzC75c7A7BGKMPIJt
 u/ySMzD0FKPzdz7OKxeZwPWSL3OZrENGY0601i95KY4kRNGoLJ3Gx2pXmP3XVyewqdmJ
 GKK3HUvCya10iaeWspblvj+Gn5sOo4DwCuFp9cEttxCIBcX6v/eNAG3Aj3Auun+Fj3mE
 XASmypkm0RiCraV03dK63t3X8AR+zRZJrwRIHssQZEj2DTLQuroBkfJ9whBxt3RCmazY
 3S5w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773364223; x=1773969023; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Hyh/lMcKuIFQfIR4UpKUL2ZxXZ8F//Dg8EFbXTrrUk=;
 b=UN2cLuTRzBXcnartZ7QHeDM7GLOTD3iuWYKD6XYTnsatHhAEzcmLAY4tpBu+WKRqVt
 3YnN+b1j/p6Gcw+jzNxm8KxwmNWk7S0+Dvvv4IdN3yrj3o6H+zKdnDFTzf0LE2T0xAcW
 mBLdVqLbCycBRXqxFGesXiDEO4a2mVYDkuEGBVUCYDz5dH2IPM8IMapBkd9FkP5XU5tJ
 vKLwI/9N5ZrDPORNx5Mc1RCi09RbQuq43+rQ9qh1AOBvqbte69EwU/JPnNvemBNyaGGu
 We91RTngAjKr+8t/Pwlb3bVZq2qBrkSOxD3JiaOe6V5Bq1EtSf2KqV4JI705van4hr0X
 ZAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773364223; x=1773969023;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0Hyh/lMcKuIFQfIR4UpKUL2ZxXZ8F//Dg8EFbXTrrUk=;
 b=XiNHxvL6Eas7kxGzs172yEir6fdybLIL6axwtyDIzfDXGOA4HBKHVdl/NXZrjGcFop
 YOxoUXQtHQqMN786TDbgG0HSfY0Pc1MrKZHyx5rzzOt7ON5gcEmI7MBT32LupX/Sp6y1
 sYKl23a2lvJu1U4FeAzIKyOYXEfvHWrv8laBQqyMtXR5YSBF8YMtct56GL0umbrULRjX
 aYCY6SxJdecpVz1MPgYISOjFC9WJzSAC0S2mv5k7IP9of5oYa5ZbWF3VMMaPBVWG25ZB
 QSEXSDjsmsEpw225SxZ6DLDlv6Sv76rD+fdoUeWy313i1vE+yZkL1KeBF4JUE1UIcJ6w
 ZWRg==
X-Gm-Message-State: AOJu0YxRloDVN9DEKI8DcKZ0wkDjZ5MgWxvXUDxjORfe40wJEcuo5BNx
 WE7umG3yXVa6j2Hfg8SInGuZIOUOO8vRTuuumaVwxQ8FLCdzVBUCXJttjJqLNdV0FBPYp8vgbdV
 UemxFTRqICjubcRhd5nP1qInhHDrGYsM=
X-Gm-Gg: ATEYQzznc7i1KD62V7dk0TLpgz8MsNyR7amShu1tMGbdTBk7SRhHS39tVStD+NanA+h
 Z3Po01mGBaO/kPmbXfklKRX8K1nUqCov0i7wcKjAYqaVltXpxWiUI84cUKiLoWJdCQ6LiDYiRd9
 sFyBFq6cQtPdiGdf5BjrjbY2sM24SO7kW3jl5jY38VsQ+Sjtfuomx2xpMRZqQ8etzlnlBUPl0u+
 +0z6CH6nRhF/9+EjlbXGqIzP+CmiaUyEvbLLKJppxFACwbCtwQjipeVwRh4FjsSNnMD3yWfgJHa
 jIytf9/kkXIbr9UP7IZUWI+yNebp7TaP7ptMsInkTUljpNxI
X-Received: by 2002:a05:6402:4401:b0:660:976f:33c with SMTP id
 4fb4d7f45d1cf-663ba9c2aa8mr748035a12.5.1773364223332; Thu, 12 Mar 2026
 18:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260306071105.3328365-1-max.chou@sifive.com>
 <CAKmqyKP7VKi21xfMAiKi9nmAGaaNdrtH9u=6ktCbWBk7kiRoJA@mail.gmail.com>
 <abKfuTO7zg5d67E8@sifive.com>
In-Reply-To: <abKfuTO7zg5d67E8@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 13 Mar 2026 11:09:57 +1000
X-Gm-Features: AaiRm523wM1r-OhNPSQ74cjxIWyPTv_UC1KZkjqrP-wTe5dmdrBKkKMdD6URSe4
Message-ID: <CAKmqyKOcCKAb2w2t2qYgOevswst75FjzKfihrYP9+odRAsCQmw@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Add Zvfbfa extension support
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
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
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

On Thu, Mar 12, 2026 at 9:16=E2=80=AFPM Max Chou <max.chou@sifive.com> wrot=
e:
>
> On 2026-03-09 14:51, Alistair Francis wrote:
> > On Fri, Mar 6, 2026 at 5:13=E2=80=AFPM Max Chou <max.chou@sifive.com> w=
rote:
> > >
> > > This patch series adds support for the RISC-V Zvfbfa extension, which
> > > provides additional BF16 vector compute support.
> > >
> > > The isa spec of Zvfbfa extension is not ratified yet, so this patch
> > > series is based on the latest draft of the spec (v0.1) and make the
> > > Zvfbfa extension as an experimental extension.
> >
> > It's not only not ratified, there isn't even a draft spec. A personal
> > GitHub repo without any tags or releases is not enough for us to take
> > this unfortunately.
> >
> > >
> > > The Zvfbfa extension adds a 1-bit field, altfmt, to the vtype CSR in
> > > bit position 8.
> > > The Zvfbfa extension requires the Zve32f and Zfbfmin extensions.
> > >
> > > Specification:
> > > https://github.com/aswaterman/riscv-misc/blob/main/isa/zvfbfa.adoc
> >
> > Overall this looks ok. Once a draft spec is released we can apply it
> >
> > Alistair
> >
>
> Hi Alistair,
>
> Thanks for the review. You asked for a pointer to the standalone ISA
> spec repo for Zvfbfa =E2=80=94 I want to explain why that doesn=E2=80=99t=
 exist and
> where the spec lives instead.
>
> RVIA changed the ISA development workflow: new ISA specifications are
> no longer developed in standalone repositories. Instead, they are
> developed as forked branches of the base ISA manual repo
> (riscv/riscv-isa-manual) and merged into it upon ratification [1].

That's fine. The details you point to show forking to a RISC-V org
GitHub account. In which case it's still clearly a RISC-V spec, under
RVI. As long as it's tagged for draft releases that isn't really any
different then before.

>
> For Zvfbfa specifically, the official spec artifact under this new
> workflow is a PR against riscv-isa-manual [2], incorporating the spec
> text [3]. The PR notes that the spec has passed internal review and
> ARC review, as documented in the tech-unprivileged list thread [4].

The problem here is that there is no version control. If we merge this
series and the PR changes then suddenly we are out of sync there is no
way to track which version of the draft spec we support.

We need clear versions, like we previously have. For example version
0.7 and then 0.8. Draft versions are ok, but we need a stable target
to develop against.

>
> PR #2743 is currently open, meaning ratification is pending but not
> yet complete. Under the new workflow, merge into main of
> riscv-isa-manual is the signal that ratification is finalized. If you
> prefer to wait until that merge happens before applying this patchset,
> I completely understand. Alternatively, if you are comfortable
> accepting it as ratification-pending, I am happy to address any
> remaining technical comments.

In this case we will have to wait as there is no stable version of the
spec to point to.

Alistair

>
> Please let me know how you would like to proceed.
>
> References:
> [1] https://lists.riscv.org/g/sig-documentation/message/275
> [2] https://github.com/riscv/riscv-isa-manual/pull/2743
> [3] https://github.com/aswaterman/riscv-misc/blob/main/isa/zvfbfa.adoc
> [4] https://lists.riscv.org/g/tech-unprivileged/message/1031
>     https://lists.riscv.org/g/tech-unprivileged/message/1085
>     https://lists.riscv.org/g/tech-unprivileged/message/1109
>
> Best regards,
> rnax
>

