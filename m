Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B57CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCfWQ-0008GJ-FR; Fri, 02 Oct 2026 11:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCfWG-0008Fe-TT
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 11:49:57 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCfWF-0001pH-00
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 11:49:56 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a9bd4db6ccso1971649a12.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 08:49:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790956193; cv=none;
 d=google.com; s=arc-20260327;
 b=pnFFvSgcsmQJ8VniVFstUm7iCmU0h/LOlv0iC1ZaB1kSznpQKOF2D3ErBNA7yy4cWu
 MHA2VE511xTSf8jnyO4uSFjzDRL/QoVG13EhudjA8Ivhq++Ck1h3W3UKJ9AXyDc2eZUZ
 AQrRvO9cjhU9BRLB0hS0Pdli2YV+cypdXBHnbL5XuV+hpgAWxksK+Bouh1YgkMlO5ChX
 lLj/DHdEmI9b/5WrFTjTzi/o6VfuNjQPOtTfdIgIEwhrQeHfNSADFgOht7kC8GzR8BNg
 bb3DxFecm6WmIrG/8W1YL83fSx8vr1KdtgTnufBjGksgaLuT79CDbBylARAxXwcK+Kx4
 qyPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=hgX3GQtTU23oI8pNSxCO4WEcw3pufykvm6TGinRAB1g=;
 fh=hkc8OPPa11x5ivs07gMDsWQzRaRS8yqyKOiel3xrIHc=;
 b=fxfQqkV2fFmgR5XlVYoUcLxW9XlNE8MY+HKh7VzJO0Lob8/vGxrGzDVJcUm4b28M9z
 NU21u5Plru6hRi13QeeRhOt1Tqu6ISsQ4a2x8cHKmIG1GByx5NZpdADwArpIKhrUR4/D
 SwBQ182Ht+RHPQE0bM60HDe3xxw1HANqgc2bJn78rpV8Y3LJNntJLejurikcy7neidMG
 eG6/JT8jscG2ufCpJ9/REM8AUBPsuw8yO6z4jxcQGgwWM4elPxr02JgRgEYY9u+lHUQw
 zB3CFFPVvwQ9sqQCiZJn3GRnHmS/kO3gB6pfnxkPcMJGIC0j2bOsRgyRhFS1Dk2lB/ld
 i+5g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790956193; x=1791560993; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hgX3GQtTU23oI8pNSxCO4WEcw3pufykvm6TGinRAB1g=;
 b=k0R4mmWIG5LT/Q28xavprBIo1/IOEef5ZaUHdqgKs78tS0Xj8+gfnvxifX45EoeGFD
 fKqAbl4pvZ4BAI5/QIoFj5o/Xz6jGjcHpqlVAivMbL4iM6W+9wdYw1Y4Tq6z8uIpQgl2
 542s+qw6LtYKq3UKBno+muQGpMKKfTfdyt1pA+iMxHMNflp+EXOuzEe5fsGNipKLS3eX
 RUkYh1hSMOuJL/2MnVFsJXuIdeOpuCQOAHNUpS7TW0K/dt09oQc+KSVEuCNKK0p01zh3
 rM21GOU3vMaAVdguOlkW4Sejjk+Kitcq8GaP7NkYebK9aELuf/RvXdn1D9ielVWDJeeg
 p4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790956193; x=1791560993;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hgX3GQtTU23oI8pNSxCO4WEcw3pufykvm6TGinRAB1g=;
 b=G97F6SKwFipTvtTWUDCtVaOiwWKFQ/XMUpE4dgzfOCCVNgieP9pL06mfK/DN4HJQ5R
 JnK540Bn5xpYxSgvTx0Q3gjnAbOiRPFnKEOBs3uGPKOGq2R+z3R/g9+xL95ayDLm9/ix
 PWbpOFzZm8sAFrO/8V4xFCEHsFPS6eImcxL3PDvZWMOtmryx/aH7UJj6aBGab6TWgOi2
 Z9jihqcBnSl0z3aAwA/k8yjemCguDq0MPgr2RY43lM7csIxph6cSciigonYFwlnTB6fL
 NVkVI2kay+1yd5MBR0oM7OwAR2GTioyX6KyeNOJ0qNJ3j4bnGHIhnPK09+XvivNAl+eH
 QJew==
X-Forwarded-Encrypted: i=1;
 AKwUvBwHQDSeU4oX8ZX5aGZ7TmkPdIgikLiu/Wz9LktV9B4LLRkJfDXKsOLUvHUwWffNQd6pAaE4GvLaTzv8@nongnu.org
X-Gm-Message-State: AFq9FYI7K6DoVY2qf6JgNnSDB1bTLleDdUoVE2CfzoBq4eqel7GwZgSa
 X0o7M7AOv/jzfwVATEuEhRQstY8XscutIPacCNZckV/c4nvPaNO7NfaCawQbIENG92H3AoL5Wix
 JCNJrA78N1lJ64w5GUTxMpYgk3crtQXk=
X-Gm-Gg: AYBFou0wefJijCw1eeEj69Qc8ArwOeP6O+GkGsWfMFq4+0Yq0+niD3ruLq86yI0mehG
 2ZEkzPBNWLbxVHvePgccIDkwe/1cs5vaTLn11IJH7G8l/5kuf7PEzei+B4xwg7+Q976acAgIZYj
 yrdcUQPx50DLIbAlgUvJCcejVaN28aHjkV5K0kV/PfyE5LjdOJJQpSlaSN1PUvWNM/dXBI3MFbP
 1ftZhhr5z8k8sbHQTQW8wG3o41yhjpqo+SAPtxX6zJhacowvEwTDC61yyWfYgaFYHl/JnCTlelr
 0KVZeMjrZwKspQKE53gfupTNaeQ04p0HS4psDPAt7+CqnF/yHyaPfpo=
X-Received: by 2002:a05:6402:4557:b0:6ac:7868:b681 with SMTP id
 4fb4d7f45d1cf-6afad46bd76mr1667a12.0.1790956193313; Fri, 02 Oct 2026 08:49:53
 -0700 (PDT)
MIME-Version: 1.0
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-7-ea69b07afd31@rev.ng>
 <CAE2XoE_ag1RR_JFwgcg+9zPed+qpO2skf7W1_kiqvwB=Vf9aAQ@mail.gmail.com>
 <f8f27bc3-83ce-4ccf-ae38-a43188b2ebc5@oss.qualcomm.com>
 <ar_AzEWpF9XDGNdg@hive.localdomain>
In-Reply-To: <ar_AzEWpF9XDGNdg@hive.localdomain>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 2 Oct 2026 23:49:41 +0800
X-Gm-Features: AclHuK-vV4_b85qC2NwtEF2w63F-R1HXPxCF6BXwNlh7rP5kCXKi83A8mSyw8AM
Message-ID: <CAE2XoE-yh-1wiwSOO-OjxM43P9xHEr38hb-ccMxOrhuFNn3RNg@mail.gmail.com>
Subject: Re: [PATCH 07/18] target/riscv: Runtime register MAX and BARE CPUs
To: Anton Johansson <anjo@rev.ng>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com, 
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52e.google.com
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 2, 2026 at 11:36=E2=80=AFPM Anton Johansson <anjo@rev.ng> wrote=
:
>
> On 02/10/26, Pierrick Bouvier wrote:
> > On 10/1/2026 9:28 AM, Yonggang Luo wrote:
> > > On Thu, Oct 1, 2026 at 11:55=E2=80=AFPM Anton Johansson via qemu deve=
lopment
> > > <qemu-devel@nongnu.org> wrote:
> > >>
> > >> Moves initialization of satp and mxl fields to a class initializatio=
n
> > >> function that checks target_riscv64().
> > >>
> > >> Note: I'm aware the current iteration of this patch is rather hacky,=
 I
> > >> don't like the introduction of runtime_misa_mxl_max, but I'm keeping
> > >> this in to get the series out there and collect feedback.
> > >>
> > >> Signed-off-by: Anton Johansson <anjo@rev.ng>
> > >> ---
> > >>  target/riscv/cpu.h |  1 +
> > >>  target/riscv/cpu.c | 90 +++++++++++++++++++++++++++++++++++--------=
-----------
> > >>  2 files changed, 59 insertions(+), 32 deletions(-)
> > >>
> > >
> > > This patch is how I handle these, just for reference, not a review.
> >
> > Yonggang approach looks cleaner, I would favor this one.
>
> I'm personally not a huge fan, it still feels rather hacky. Why add a
> completely new RISCVCPUDef::target_init just to make sure fields are
> initialized before riscv_cpu_validate_misa_mxl()? Wouldn't moving the
> check to a later point, maybe .instance_init, be better? Then for
> riscv_cpu_init() we get
>
>   riscv_cpu_validate_misa_mxl(mcc);
>   env->misa_mxl =3D mcc->def->misa_mxl_max;
>
> misa_mxl_max would be verified only during instance rather than
> class initialization, which seems like a decent tradeoff for a simpler
> solution.
>

For example, we can add a max_satp_mode_choose callback, when provided
then misa_mxl_max is computed from max_satp_mode_choose
inside riscv_cpu_init(that is instance_init).
> --
> Anton Johansson
> rev.ng Labs Srl.



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

