Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F017DC79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3yD8-0003vG-2D; Tue, 08 Sep 2026 11:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3yD6-0003uu-Rt
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:58:12 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3yD5-0000ql-9j
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:58:12 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-87f4e914a45so640937b3.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 08:58:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788883090; cv=none;
 d=google.com; s=arc-20260327;
 b=L2TPNI691CyltgTydrbYsCbjxEo4bN339KFIPxK9Blbbexys0dYRFzn5CUaAdklgQl
 2VNxA/+bmf4yW5MiGfWbPR4wVbiqlDJ0YjAYmxRR8/3HnIXeAOr6/J8E4BoAvxfd98xm
 pDpFIlVjbhR5+7FIR71K43WX8J9F4SXQbcb1p7TlVGhvv5ALH4MBZLgKauPXtYW7cGva
 H5gcsnJ5CBxwmPEGCx8J4I10/Is+3EYOwnNZ3DjS0pNMO0luS5fLgPVzbBhMQt7d/TTN
 ZixsHXS3F9L+BR/ewJ+wddnV3se1lYrgWOtD0h8R7AJSNGolCF5kexn/EB+EtOeVomw0
 QbMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9U0azSGD0ntwc/h5lCEy4R7LeO4m6e1+YMN+Y5mfMV4=;
 fh=IP+qajjPTDI9C2cKteyw2RunymSfkr9sh851BX9wYSM=;
 b=CE4j2JIOR0SJhtBZBFj/0QCq2MpysL5HbFVcnt2aLe9O4gf6GL7r+krP4+uDHHD6vh
 M7QRMrzBmKTvmvlOAAeOFh+xqpmGvTE+cYnQTWpCy9rEy9b14riEAdRx7qBgNHGhMyZP
 I0sVYbno8pkUFRW4mpLZY9l0zDJo8/y/MIZCaNiRkBHarpwD7fo9KMhM4D40oPVZ4FQL
 qXHUs9cs6h+qdGSmz3TsG9vz89AxTVVYW6InYFueF+iHDfWBlghGIivdBeuKh7NPsOZe
 Cl+7BLaJXSa9bRUYR8ZefA1GakG+g4LFk+4/B59pSXf0BFTmJ5g0xJ0iGekeythN+DMc
 WL7A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788883090; x=1789487890; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9U0azSGD0ntwc/h5lCEy4R7LeO4m6e1+YMN+Y5mfMV4=;
 b=a9tVTZs68dP4SBmc502pd7TqdUT7PbMjrtqydgDb6b3vtkKCrqeoYiAKFhB5TMzLyK
 j6qN8+P3pbWramhHksu4qL4/N9eFaZHSyLFeA/v2g6d8+RquaNzcbV2IXT/tWb17fVxC
 U676N+ZPRFaB0tKyB2T3v8ivnpaLsdXtWivm4AAbLv/+QPi9hGKUuxHScN3PgCywEefM
 PEi+phn1n0bvgQIosWzM0yXW9iFEEDXV0+AwogK6ZIG2hSgP0bZ/LuxEZO3ZSCuk8Y+g
 5SyqVCnjQg0SdpBVdIJMrbaLR5hXTLLcC8WnJo7+MOyrfqLsSrjQq/LKSPqrALEpLkRn
 8NKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788883090; x=1789487890;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9U0azSGD0ntwc/h5lCEy4R7LeO4m6e1+YMN+Y5mfMV4=;
 b=b5dd4BtJGRa3We7DaqJdTJ1Kn4iSJqV7dN0QACgGbsjdfAVN7b3AtxDJQ201rlEFyN
 Iwt57qTUMmsfYYsd9XIthbPejwB/+xcypVXnHvJORGbbRKOTfIOA4BpUEUOvlsInt4Rz
 YpuMDrHilv9uGt40v+yLZj8VOarKgNfGktYhNSDcqbX3MMhehV6/Uq9xDW1b4ps3RxVr
 IHl7w0pz9HqtbMM63ynhZlw3+sWN0iUV91YHZmjknphXJZnuneS5RGCPkpRmV4W5yr9Z
 kiMgNdezErojKJCduw9NSAibAxUXEBpVPdGjdAz6en97/VLrRW2WZDjueppCS0861Dvs
 nFEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKeCvDFdx8grzH+Gg08zPsfhBqweGP4jB9lTrNzbk1BPCvZOkrhhhEen6JyiAlrq621vwf3dIPmYIn@nongnu.org
X-Gm-Message-State: AFuF++lVrn2L22cf6T7XaYtLp7msvof+qyzOsLVISeVi11u2PFNvInmb
 NcWngghJgvU6mVE7nTGe5OZ6RC2xRzT35dP5ewVh7ckAZ3UEe5mAJI7BGOql7D4DXga3XVxPKWt
 I3ICmw9jeffhzCKtY6hXQJkVYb9GpCRzSy0wqeoOQLg==
X-Gm-Gg: AYBFou3tFIrYtIGrav6clpH9AqqvDbzfAlVgSgz65aT+YDDsOxsyiAa64wFSp/plEgu
 kobpvTe1BGhG9UaAbS46+UEeznE8f6mHoP/sZqeUj0fCO4Zq+DgvhqRwVdy4RcA26preKv7DMBh
 LB2QgpLE8Eomar0SBiOaXADS3tfXr37HnPrdLcL7vodoxS1RR5yrwSuyEtc0LcmdfgmwZmr6oHb
 k76Gv4QUwbQhcVMP7Bg4sw9pKNPap6CfdJ64najmFRcNFupXE4XNzAdlAall8W9uTD6UiuDiNc6
 hmWq31JPDq7WhaNUUsbkUJ5myaLqrQYlHGTI7NWfCNIjgdxfwuh9tTGx0UksigQllKUZBT8q6Mv
 e/5r2OZQfzpW6M7oGSKuApZEygy+y
X-Received: by 2002:a05:690c:7:b0:85e:688f:3c52 with SMTP id
 00721157ae682-871290a4c74mr101887797b3.33.1788883089642; Tue, 08 Sep 2026
 08:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260905004800.5B560C92F2@bambi.snowrabbit.org>
 <0AC93E1E-4050-4B69-BE26-6FCC99A0E886@unpredictable.fr>
 <6A1F99FD-8C96-49EA-B678-BB6997F3EF79@unpredictable.fr>
In-Reply-To: <6A1F99FD-8C96-49EA-B678-BB6997F3EF79@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 16:57:57 +0100
X-Gm-Features: AcwNN1WF-8tk50h_gGpVoC3CoogjV9lDby3pY06bDZe1DewX8HCQfPmLMOoH2Xw
Message-ID: <CAFEAcA9nfjLsz1iU1BPFaAgcPGDAXWh8uUHOZXNheG3U_Lyriw@mail.gmail.com>
Subject: Re: [PATCH] target/arm/hvf: implement MDCCSR_EL0 as RAZ
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Showta Ishizaki <zakinko@snowrabbit.org>, qemu-devel@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Sat, 5 Sept 2026 at 07:40, Mohamed Mediouni <mohamed@unpredictable.fr> w=
rote:
>
>
>
> > On 5. Sep 2026, at 08:37, Mohamed Mediouni <mohamed@unpredictable.fr> w=
rote:
> >
> >
> >
> >> On 5. Sep 2026, at 02:48, Showta Ishizaki <zakinko@snowrabbit.org> wro=
te:
> >>
> >>
> >> A guest that reads MDCCSR_EL0 under hvf is killed.  The register has n=
o
> >> case in hvf_sysreg_read(), so it reaches the unhandled path and hvf
> >> injects an undefined instruction:
> >>
> >>   trace_hvf_unhandled_sysreg_read(env->pc, reg, ...);
> >>   hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized(), 1);
> >>
> >> The TCG path does not do this.  debug_helper.c defines MDCCSR_EL0 as
> >> ARM_CP_CONST with resetvalue 0, and the comment on the neighbouring DC=
C
> >> registers gives the reason:
> >>
> >>   However we implement RAZ/WI behaviour with trapping to prevent
> >>   spurious SIGILLs if the guest OS does access them as the support
> >>   cannot be probed for.
> >>
> >> That argument holds for hvf as much as for TCG, so do the same there.
> >>
> >> The read only reaches QEMU since 37863fff59 ("hvf: arm: enable vGIC by
> >> default for virt-11.1 and later").  With -M virt,kernel-irqchip=3Doff =
the
> >> trace point does not fire at all, so before that change the register w=
as
> >> never trapped out.
> >>
> >> NetBSD/aarch64 hits this on every boot.  vmt(4) probes for the VMware
> >> backdoor, which on arm64 is a read of MDCCSR_EL0 with a magic value in
> >> x7, and the injected undefined instruction is fatal in kernel mode:
> >>
> >>   [   1.0000000] cpu0 at acpi0: unknown CPU (ID =3D 0x610f0000), id 0x=
0
> >>   [   1.0000000] panic: Trap: fatal Unknown Reason (Illegal Instructio=
n):
> >>     pc=3Dffffc000003fa318 sp=3Dffffc000010262e0 esr=3D02000000
> >>   [   1.0000000] fp ffffc000010262f0 vmt_probe() at netbsd:vmt_probe+0=
x3c
> >>   [   1.0000000] fp ffffc00001026340 vmt_match() at netbsd:vmt_match+0=
x1c
> >>
> >> The pc in the panic is the same pc the trace point reports, and the
> >> encoding it reports is MDCCSR_EL0:
> >>
> >>   hvf_unhandled_sysreg_read unhandled sysreg read at pc=3D0xffffc00000=
3fa318:
> >>     0x0020c002 (op0=3D2 op1=3D3 crn=3D0 crm=3D1 op2=3D0)
> >>
> >> With this patch the same image boots to login on -M virt -accel hvf, a=
nd
> >> the trace point does not fire.
> >>
> >> Fixes: 37863fff59e0 ("hvf: arm: enable vGIC by default for virt-11.1 a=
nd later")
> >> Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
> >
> > Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> *Reviewed-by
>
> Oops.
>
> Will submit this as part of a rollup series or it=E2=80=99ll be taken on =
its own.
> >> ---


Applied to target-arm.next, thanks. I've added a cc:stable tag
since we run into this with a netbsd guest.

-- PMM

