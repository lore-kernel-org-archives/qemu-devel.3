Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE4CD44166
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 10:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU0jj-000864-25; Fri, 12 Dec 2025 05:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vU0jh-00085U-DY
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 05:50:57 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vU0jf-0007bf-RR
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 05:50:57 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-787d5555274so10662407b3.1
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 02:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765536654; x=1766141454; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qxws8ka21ttXeCW4oYk8itW09Z7jkXtxCGVc34Etq6w=;
 b=U9Yddgjdu2vGD26LyOkWNEnBkU/fQQy5zCgBr7i2o8rE1zJkGbGQK8Q8o3wYt/Ly8M
 uCuheytD/Gy+TjlZrdm41KIWY8MkV5yX8Vq0r3Uch9j+zYrzugZHJWOMQwVhb6EeNkoM
 ZKdMOXc8OM194yJkfyuDMx6BGbs2UlWXfYvY20oVeseZW2SItU2lSbucTm9fcar2emJH
 /VdvPg8m65o1Ey6MO+lZ6OAlNmgLuhjevPoIK/T6lIR/an2bKE6DXrHb+iuozc2+0d6/
 GV4hgsO76QVjXWNA3PCiwxKOXoyLHlE4duZliprSrU6YCD0+pmTtN7Q56NgsamIiaGE0
 vYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765536654; x=1766141454;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qxws8ka21ttXeCW4oYk8itW09Z7jkXtxCGVc34Etq6w=;
 b=AMZSNWahMkEg9UjOPNE6yVpv/FgfFpYPsa+j51YIz+cTp5brnzWKuAcm6w6ON/pRwT
 3AOki3jIKk/GrN7IQTGhvlGsQFzdvPs3WOsd2RvXxIsMuXTEd7WCHn09udYWYnAwA0jz
 d1PWtkpp3MXCZQ45fBqtekperoPv7aiTkJn9aj72jaVvRejk2CY7DTHQ4NjZiaroG9c3
 uoKiPpcWQciP+m2dNhuOsc9UQcUP0boHg5kn3PE32xKYXrga7yZn1/vxMVa3RfE10sis
 8wZ2wtUnPuFP7e8W7eYawy0uZsiGujYayW4Ld4qDJUKvND4Cb0kNX59lrHgP3x8cgFj6
 Qg4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyw8/YImkUl0RyF79/5jXwl+plVcrRMLPNiTfjzXVP92fz54e963O3BddRa42cd9UNmAIiqm+PtWCS@nongnu.org
X-Gm-Message-State: AOJu0YxZxAMErwi9irE1ntss+jIMLmSOjBiv2C0c9Xol/R9ijpXZGCv1
 eeiPevMMB+oSdEmULaOyl1D/8JjaEW7aoPQyRlNDBZtUcgURBvv3wYVsgrB2oz7MnKKKET53ZoP
 xEEh8X7ls/ztnJayvdUHSj9C7RIBol9ZkSnUi2hKbjw==
X-Gm-Gg: AY/fxX7VYqQS3+Re4he2xTSAk88q0xXkzVmCez/oc50zyDRXnikMD4LXw0E0vBMcvS3
 xgenUycyeCOySxxsLLdgmXAtDWvdloJziqa3EHbHVRREq3YDxFlpZxcdd5RnDGf158zlN+XYYTH
 PsHfBTUlw6feqFqQSm8OCYWrCE46axOZIM0+nuOl+xpEXt+LT9R6q/gpHYqu60e2CtiAMAbRplP
 tmEOZMHbDDtSgt3Mp/JdPqlccClk7bN623tH8RqK4jEJ5MEC65Bv0ElOf1yTmQ/kUaKpJMI
X-Google-Smtp-Source: AGHT+IH1Hl17F3VP+vn+4468w5RKbCuKd2KO9s7WfFQ8WaQCT/Z2rr2Shp5IwTZIxhIBNYS7/LQGv05k8ZjInsrwkpk=
X-Received: by 2002:a05:690c:4d41:b0:78c:2db5:c40f with SMTP id
 00721157ae682-78e66d4d37fmr12129477b3.7.1765536654477; Fri, 12 Dec 2025
 02:50:54 -0800 (PST)
MIME-Version: 1.0
References: <20251211221715.2206662-1-pierrick.bouvier@linaro.org>
 <87a479e9-21eb-4c4c-8e64-32744eea1f96@linaro.org>
In-Reply-To: <87a479e9-21eb-4c4c-8e64-32744eea1f96@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Dec 2025 10:50:43 +0000
X-Gm-Features: AQt7F2qVzsx6GaEHa2U0We30s5xQdtv60XW0t2uskNdTHLjDb1juxI0OM5LC514
Message-ID: <CAFEAcA9cd+v5GrWK3KPjQ9ZURHbNzx+_SywcBaZdeAxYEk_NBA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/smmu: add memory regions as property for an SMMU
 instance
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, tangtao1634@phytium.com.cn, 
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 12 Dec 2025 at 06:16, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Pierrick,
>
> On 11/12/25 23:17, Pierrick Bouvier wrote:
> > This will be used to access non-secure and secure memory. Secure suppor=
t
> > and Granule Protection Check (for RME) for SMMU need to access secure
> > memory.
>
> Sorry yesterday it was late for me and I forgot to post the similar
> patch :/
>
> >
> > As well, it allows to remove usage of global address_space_memory,
> > allowing different SMMU instances to have a specific view of memory.
> >
> > Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > ---
> >   include/hw/arm/smmu-common.h |  4 ++++
> >   hw/arm/sbsa-ref.c            | 16 ++++++++++++----
> >   hw/arm/smmu-common.c         | 24 ++++++++++++++++++++++++
> >   hw/arm/virt.c                | 16 +++++++++++-----
> >   4 files changed, 51 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.=
h
> > index a6bdb67a983..0f08ae080c9 100644
> > --- a/include/hw/arm/smmu-common.h
> > +++ b/include/hw/arm/smmu-common.h
> > @@ -227,6 +227,10 @@ struct SMMUState {
> >       uint8_t bus_num;
> >       PCIBus *primary_bus;
> >       bool smmu_per_bus; /* SMMU is specific to the primary_bus */
> > +    MemoryRegion *memory;
> > +    AddressSpace as_memory;
> > +    MemoryRegion *secure_memory;
> > +    AddressSpace as_secure_memory;
>
> Has SMMU concept of "secure memory"?

Yes -- IHI0070G.b section 3.10.2: when SMMU_S_IDR1.SECURE_IMPL=3D1
"the SMMU can generate transactions to the memory system, to Secure
PA space (NS=3D0) and Non-secure PA space (NS=3D1)".

When the SMMU has Realm support then further (3.10.3)
the output PA space can be Realm, and also GPT checks are
always done to the Root address space.

So an SMMU with Secure and Realm support can emit transactions
to any of the 4 address spaces, the same as a CPU with those
features.

Separately from that, at the moment the way we model Realm
and Root is by using the same QEMU MemoryRegion trees we
have for NS and S and just using MemTxAttrs::space to distinguish,
because we don't have any need for devices that appear only in
Realm and not NS, or only in Root and not S. So for CPUs we
collapse the 4 architectural address spaces down into two QEMU
ones.

For the SMMU we can presumably follow the CPU there
(with an equivalent "give me the AddressSpace I should
use for these MemTxAttrs" function as arm_addressspace()).

> My understanding is just a
> different memory to access GPT, so I'd name it "gpt_memory".

I would prefer that we use the architecturally standard
terminology here.

thanks
-- PMM

