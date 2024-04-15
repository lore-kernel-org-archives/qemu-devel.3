Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F98C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 20:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwSWa-00082i-9W; Mon, 15 Apr 2024 16:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1rwQuH-0004zK-Vt
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 14:18:18 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1rwQuD-0005VT-1A
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 14:18:17 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d718ee7344so34864511fa.2
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 11:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713205090; x=1713809890; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kVIuQvNWbFay6L4rdMSFHCSF1ccIB+Fo5jWkybNc94c=;
 b=Wx98Jkj/mWo5s91bzSBL+nzz1hnRbv5AJAxFqZVxcrS8bo/nsb5M5AQ7HP4p5Ea7Q3
 iGM7ovmVLgiZ3z/6AfYiVi/HCObcvQd00VMdSST6xUX2AQ+rUSbXjnk/jwvhM8rfYVGM
 ZtLd6Lvkbqkt7offqk1AS1G4bCC9lDDr7bnlPlLi4ifAYbxlKjTSuBuK17E8/WB68X4y
 jFKwehCgYtCoHbfKkS+0MLqtW1uZtMbkUp/3zNf3kJaMeAQIgMHfW9miP8ehD9KIpCVF
 6sMvSSQ6NedG3IpTZfqmJlAjneNguVrtAOMpgNN886lbf5LI7u9AamyXTMo+alVcdjxG
 75zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713205090; x=1713809890;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kVIuQvNWbFay6L4rdMSFHCSF1ccIB+Fo5jWkybNc94c=;
 b=GTnx4lJCO1wj1oYa2OHEYpzsJ6R5uc4aU5SIuXwPYFRoGzlOjrXouJ3K5wC8KslW8p
 WMgQ8g+XRDtVKhWgbfR12eVfJyNdSFK2gqbhtXpt9dO8dmCz+CpQ2CeIMrPYFER1P3NT
 MfNv4utxKOrX0bcF1VGFE6060kyKOt1OCP5MRHmbyPche/E8qXfiDQzc4Y5z4ztIqIn9
 PngB0ADFzZL6tL9s00maZFwBai3BFHpj1DP4zU3WQr97/vqpyyOpXZHZZLeVsjRTIbTK
 5wS0JwXy+jRa9MSUqFs8L0lnPBG5etBUoQKNOPlT2+alxPFgnGw+3fUyXQX5TlH6OTZh
 6Osg==
X-Gm-Message-State: AOJu0YwQwGiQjRKLXgfentOo6IMZqun2MaaYX5qApkYcxhPsdmpqrRI7
 bzXWTx8lXh+R6TVmQRf3VMX8fvAxgxhuwiGuiNnQShWWeuAOsvmwlsif47jZfRbyLZ6jDslsXsL
 t3q/HTc93qV1q5Tqijq2VSrXtyEI=
X-Google-Smtp-Source: AGHT+IGp4q7T8f7G2w0oDOosV0O9OXP9BuK741+Sn2tRN5SEa0W9F4XiMHX9zydATm5RgZ3V6xBuK1GesQFE+85p2qs=
X-Received: by 2002:a2e:681a:0:b0:2d8:57a4:968d with SMTP id
 c26-20020a2e681a000000b002d857a4968dmr7759533lja.12.1713205089596; Mon, 15
 Apr 2024 11:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAFfO_h6LZF4T1zfTWh9qhJLcMZWxZ5VAPx-pgO66pXbWiWhNtw@mail.gmail.com>
 <CAFEAcA_PTpGqm3Zco3zydpR=tU-MOgAW3ZNExBuUDCk6gcwHTw@mail.gmail.com>
In-Reply-To: <CAFEAcA_PTpGqm3Zco3zydpR=tU-MOgAW3ZNExBuUDCk6gcwHTw@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Tue, 16 Apr 2024 00:17:57 +0600
Message-ID: <CAFfO_h4kbH0BdvUOTaq-g3Z+afej9XhqzS1b+kJf7O1DTi4VCA@mail.gmail.com>
Subject: Re: Questions about "QEMU gives wrong MPIDR value for Arm CPU types
 with MT=1" (gitlab issue #1608)
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=dorjoychy111@gmail.com; helo=mail-lj1-x234.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 15 Apr 2024 16:01:53 -0400
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

On Mon, Apr 15, 2024 at 5:35=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Sat, 13 Apr 2024 at 20:59, Dorjoy Chowdhury <dorjoychy111@gmail.com> w=
rote:
> >
> > Hi,
> > Hope everyone is doing well. I was looking at "Bite Sized" tagged QEMU
> > issues in gitlab to see if there is anything that makes sense for me
> > as a first time contributor. I see this issue "QEMU gives wrong MPIDR
> > value for Arm CPU types with MT=3D1" (gitlab URL:
> > https://gitlab.com/qemu-project/qemu/-/issues/1608 ).
> >
> > From the bug ticket description, it is very clear that I will need to
> > add a bool member variable in the "AarchCPU" struct which is in
> > "target/arm/cpu.h" file. I believe the next logical change is to set
> > this member variable to "true" in the corresponding arm cpu "initfn"
> > functions (a55, a76, noeverse_n1) which are in "target/arm/cpu64.c"
> > file. I have a few questions about the following steps as I am looking
> > through the code.
> >
> > 1. I believe I will need to update the "arm_build_mp_affinity"
> > function in "target/arm/cpu.c" file to now also take in a bool
> > parameter that will indicate if the function should instead put the
> > "core index" in the "aff1" bits instead of the existing logic of
> > "aff0" bits and the cluster id in the "aff2" bits instead of the
> > existing logic of "aff1" bits. But I see this function being invoked
> > from 3 other files: "hw/arm/sbsa-ref.c", "hw/arm/virt.c",
> > "hw/arm/npcm7xx.c". Should the function calls in these files always
> > have that corresponding argument set to "false"?
>
> This bit of the codebase has got a bit more complicated since
> I wrote up the bug report. I will look into this and get back
> to you, but my suspicion is that these calls must return the
> same value that the actual CPU MPIDR affinity values have,
> because these values are going to end up in the DTB and ACPI
> tables, and the OS will want them to match up with MPIDRs.
>

Sounds great. Let me know. It sounds like then it could make sense to
change the "arm_build_mp_affinity" function signature in file
"target/arm/cpu.c" file to be like this:

uint64_t arm_build_mp_affinity(bool has_smt, int idx, uint8_t clusterz)

I think in all the files where it is invoked it should be possible to
know the SMT status of the cpu using ARMCPU(qemu_get_cpu(cpu)) or
similar. Let me know what you think.

> > 2. As per the bug ticket description, I will also need to update the
> > "mpidr_read_val" function in the "target/arm/helper.c" file to only
> > set the MT bit (24th) to 1 if the member variable is true. I think
> > there is nothing else to be done in this function apart from checking
> > and then setting the MT bit. Is my assumption correct?
>
> Yes, that's right.
>
> > I think doing the above steps should fix the bug and probably we don't
> > need anything else. It would be great if someone can help me answer
> > the questions or any suggestion would be great if my assumptions are
> > wrong. Thanks.
>
> The other thing we need to do is check the TRM (technical reference
> manual) for the CPUs that were added since I filed that bug in
> April 2023, to see if they need to have the flag set or not. The
> ones we need to check are:
>  * cortex-a710
>  * neoverse-n2
>  * neoverse-v1
>

Good point. I have now looked at the TRMs of the a710, neoverse-n2,
neoverse-v2 and they are similar like the ones mentioned in the gitlab
bug ticket i.e., MT bit should be 1, Aff0 should be 0, Aff1 should be
core index, Aff2 should be cluster id.

> thanks
> -- PMM

Let me know what you think. If everything sounds alright, I will try
and post a patch.

Thanks and regards,
Dorjoy.

