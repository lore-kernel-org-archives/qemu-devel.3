Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CD9D6101C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 14:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlSqw-0001xC-Kv; Thu, 29 Jan 2026 09:18:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vlSqu-0001vO-J5
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 09:18:32 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vlSqr-0007x6-VT
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 09:18:32 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so169674266b.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 06:18:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769696307; cv=none;
 d=google.com; s=arc-20240605;
 b=g1V9O1N8LKhsFmE15v0bpnk0y2gKBKM5idpgDZV2MSHHf204WATD4MvnUr2h7roLe+
 2RSXLImFQjR01Bc9Z/eGyjg8JDiaVg4cDVyZp1IA35bq0XC1DfnozMO9/3zceQMX5+HU
 XFzqx2SLiA7oMrxb76kvhrNqofgGeLwm7V8WswNjUQS3aMMluDqPb+5q7dqNXFQ3ot/w
 DLl9oeZtdIIcvMpnlOrHBZmsusyRWFLRDudqYKH11XOY6FDEPCDZcy3Yh1DaiajhErKA
 yqX5/E97s4xip1avxugreKJtbvCO0daCHp4J8tAj+D78Ow0twRQ+Z4Lbkwz0bj0Pr9pX
 xnOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UEKVTrz8YDzYQ5uy4I6bYgzbq3mb2bYtUnu63D5lJFw=;
 fh=x5HMi2bFcpW5plFmeTH1wxKaF74BkwSYZQXa5+amB5c=;
 b=WsjaxqVGq4XlTJ0JVN61GssI0Zua1dIEGRLP0PVUO3Aek0bpGz9AQFuKwIpZ7E9yR5
 xXhtWMAfxarExQ3HUcQO5dq0P5Nb83E0op7QgKq3DiG6Ry0kfSS5mZESTUVV9+pXJ5RS
 7/O6hiabFeBvThlcO0tV40RUgmeBh+A8rE91DNROjw1Sl3P7R+jnEUymuHcoQ7W4Q/S+
 gJxTX8ogPsABHO02gZ39pR+NvZ/8JKFKwOoIDiJXVKzDOKMSXQYDyP74O3WaaJYmvIUr
 xafR2CYIsLFRRP5uqxdH5FRd7dJ5c8Gu/0Y0izF8Vf0u6AiVmswOeb44CgwgkoywR2kI
 7Dug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769696307; x=1770301107; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UEKVTrz8YDzYQ5uy4I6bYgzbq3mb2bYtUnu63D5lJFw=;
 b=mQduS01ZNp647QEIY8GCVL38yJ7O4GiTw3WtS4Rrb7iFgzJezj+57W7G4g8Nq2cAEZ
 ex5/V5WK8CeNwvDaJXICWMgljUGA5nrtSCpwB1eDfs4Z4EfCfoK29mHF0PQHpboUhOcw
 FVOhm6BME9enUtFG+e3vUTAVp5xw+YzPTpA1+wlctRh9T7KSur0iSESUzsIImPJe+IjC
 Pz2G4cyi2BvOABYzmayNkuBgkA2A7lNUoULcKIRdHMcsC3WikRzve5mVkSFS+SuQP1Ui
 jslqVznmTH6IExKtLa5Dpf/Kyq8T3fKgo/V4sJ74YYZBie9/M5wvL0pXCcbEzQ5SG1ab
 VfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769696307; x=1770301107;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UEKVTrz8YDzYQ5uy4I6bYgzbq3mb2bYtUnu63D5lJFw=;
 b=NBEjYJ6/VgKcXNFfQf1raJZsVlCe/8Z+XbJ0Knt38B8h6vIdXgQXrM8rAT1vV/jYy+
 1/obfhwv0Necjzp8/NJW5oKoPdJ97rEFUE857vNZb9iPKS22qEkd4DtrJYprrdUOGhzg
 xE5ieK5J6TRNLZsOecrB4UiV0cqEuQSSw7jXNB6fTmRrfpLLTlmCeW/zNqieV+F5ThTA
 QCEqlw84cBQk6v+A+qzfWdSn6e8+VZnuqwSKuvXBXUfpOFE1mOlomnLx+N8gCATu9olI
 VUmezWqKe+UsfVmXl+Y7MOSla+G0MEs1T3FAhq+ZGT1TT8NCC5I5/N+yLL9JiMPmubcP
 Aovw==
X-Gm-Message-State: AOJu0Yyw3ijCkQLMiD+B3Y/uy5dK/0Da+TXoCDPG9ZkOnmC1mVSYBKYa
 m897Wfjm0DaJNwQBOgL+fv3S4TTA5kX1pp3VhGwq5YSL1BSeXb2Y3H4dqNkkaLEJiwbIlYN2F4f
 Uf/DgzbpGGBIAhIbEXCGw3LIRabSlIqQ=
X-Gm-Gg: AZuq6aKsudmUsyrOf6u6auBVW//Rp5s0jkKwf7nGNj+uSZfLf3DuluPZSa9vhNN4BVi
 fLHTCLDGDHFNODlSgLCcG3+MuNba1rhjfwKYvWkxEq+gQfbJwfsEgxFmOxCXwOoxXA7CSvxV2Bt
 /A1Md3cDZ1OAo+T7Nd4/HrBF6hnkvjU+ufoWfMePc+xWkWhoFXiUWfmTMsUKuTSxh5ZxCqvC2A+
 6kPV75YjWb9i+IYSu7N/hQ25yyXF+IYzcSLGnzt3aT/EGNVJJoukisEHTa4flhY1sC+Fg==
X-Received: by 2002:a17:907:e10d:b0:b8d:bf4d:7463 with SMTP id
 a640c23a62f3a-b8dbf4d7744mr381360466b.31.1769696307330; Thu, 29 Jan 2026
 06:18:27 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <h4uue2ekbnlh26rylj4ilsqzyxdrfzrq7czleysrkbowlgp4q2@wtbm7zi4kev5>
In-Reply-To: <h4uue2ekbnlh26rylj4ilsqzyxdrfzrq7czleysrkbowlgp4q2@wtbm7zi4kev5>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 29 Jan 2026 09:18:15 -0500
X-Gm-Features: AZwV_QhexZCjxjmezZkXhv3H1W9i2wH_EGc7JcvsAPFpTbcdb_piPNOES6YaEUo
Message-ID: <CAJSP0QXu+fmKuOKLw=OXL0GqTQS58pM_-REtnnOCiSaZJp9=LQ@mail.gmail.com>
Subject: Re: COCONUT-SVSM project ideas for GSoC 2026
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 German Maglione <gmaglione@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, danpb@redhat.com, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x636.google.com
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

On Thu, Jan 29, 2026 at 5:46=E2=80=AFAM J=C3=B6rg R=C3=B6del <joro@8bytes.o=
rg> wrote:
>
> Hi Stefan,
>
> Thanks a lot for running this and allowing the COCONUT-SVSM project to su=
bmit
> ideas under the QEMU/KVM umbrella!
>

Welcome!

> After some discussions in the community we came up with these two project=
 ideas:
>
> =3D=3D=3D Observability Support for COCONUT-SVSM =3D=3D=3D
>
> '''Summary:''' Implement Support for COCONUT-SVSM Observability within th=
e TEE
>
> COCONUT-SVSM is a Secure Virtual machine Service Module that runs at a
> privileged level within a Confidential Virtual Machine (CVM) to provide t=
rusted
> services, such as a virtual TPM, to the guest operating system, independe=
nt of
> the host hypervisor.
>
> The goal of the project is to implement support for observability of
> COCONUT-SVSM from the guest OS. When finished the guest OS has a way to
> fetch runtime metrics and data from the COCONUT-SVSM running within the s=
ame
> TEE. Runtime data includes the log buffer, services logs, memory usage, a=
nd
> possible future extensions.
>
> The project consists of several parts:
>
> 1. Design an experimental SVSM observability protocol for exchanging metr=
ics
>    and data between COCONUT-SVSM and the Linux kernel. This protocol will=
 be an
>    extension of the SVSM protocol specification.

Interns have 12 weeks for the project. Usually this does not leave
enough time for the intern to propose a design and reach consensus
with the community. Keep in mind they may not have much background in
COCONUT-SVSM, so it will be challenging for them to come up with a
design.

I think the mentors should provide the extension to the SVSM protocol
specification. That way the intern can start the coding period by
diving straight into the implementation and there is no risk that the
project is held up because the community does not like the design.

> 2. Implement a handler for the protocol within COCONUT-SVSM following the=
 other
>    protocols COCONUT-SVSM already implements.
> 3. Implement a Linux device driver which uses this protocol to get
>    observability data from COCONUT-SVSM and make it accessible to Linux u=
ser-mode
>    via a device file.
> 4. Implement a Linux user-space utility to fetch and save the observabili=
ty
>    data using the device driver.

2, 3, and 4 together are a significant amount of work. I think it
would help to provide more details on what the interfaces look like.
Sketch out the command-line interface for the Linux user-space
utility, a Linux chardev (ioctl?) or sysfs interface that you would
like to see, etc. These details should probably go in the development
plan linked below on the COCONUT-SVSM website.

>
> '''Links:'''
>
> * COCONUT-SVSM Repository: https://github.com/coconut-svsm/svsm/
> * Development plan: https://coconut-svsm.github.io/svsm/developer/DEVELOP=
MENT-PLAN/#observability
> * SVSM protocol specification: https://docs.amd.com/v/u/en-US/58019
>
> '''Details:'''
> Skill level: Intermediate
> Language: Rust and C
> Mentors: Stefano Garzarella <sgarzare@redhat.com>, Gerd Hoffmann <kraxel@=
redhat.com>, Joerg Roedel <joerg.roedel@amd.com>

Nice project idea. It's large but incremental, so even if the intern
doesn't complete everything, it will be possible to merge the finished
parts.

>
> --->8---
>
> =3D=3D=3D Support X86 Process Context Identifiers (PCID) in COCONUT-SVSM =
=3D=3D=3D
>
> COCONUT-SVSM is a Secure Virtual machine Service Module that runs at a
> privileged level within a Confidential Virtual Machine (CVM) to provide t=
rusted
> services, such as a virtual TPM, to the guest operating system, independe=
nt of
> the host hypervisor.
>
> The goal of the project is to enhance the COCONUT-SVSM kernel to make use=
 of
> the PCID feature on X86 to reduce the number of runtime TLB misses. The w=
ork
> consists of several steps:
>
> 1. Implement generic CPUID feature enumeration support by building a code
>    generator which automatically creates a Rust crate from the data provi=
ded by
>    the X86-CPUID project. Use that generated crate in COCONUT-SVSM for
>    detecting the PCID feature and clean up all the open coded CPUID check=
s.
> 2. Design and implement a PCID assignment strategy for tasks and threads =
in the
>    COCONUT kernel.
> 3. Apply the PCIDs in the COCONUT page-tables and adapt the TLB flushing =
code
>    to take PCIDs into account.
>
> '''Links:'''
> * AMD64 APM 2 (PCIDs, Section 5.5.1.): https://docs.amd.com/v/u/en-US/245=
93_3.43
> * X86 cpuid project: https://x86-cpuid.org/
> * COCONUT-SVSM: https://github.com/coconut-svsm/svsm/
>
> '''Details:'''
> * Skill level: Intermediate
> * Languages: Rust
> * Mentors: Joerg Roedel <joerg.roedel@amd.com>, Luigi Leonardi <leonardi@=
redhat.com>

I have added this one to the wiki. Thank you!

https://wiki.qemu.org/Google_Summer_of_Code_2026#Support_X86_Process_Contex=
t_Identifiers_(PCID)_in_COCONUT-SVSM

Stefan

