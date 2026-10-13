Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DDBCA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGaAy-00076Y-UT; Tue, 13 Oct 2026 06:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGaAu-00076E-N9
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:56:04 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGaAs-0006iW-3J
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:56:04 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8ab37e44643so16431657b3.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 03:56:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791888961; cv=none;
 d=google.com; s=arc-20260327;
 b=igk6KGWA4SIi9cwiGjOl5ht+ejVwAG5J7/l80sg1Nmuab/fxt9LOG+Ov2kTH/A++EY
 yVgPfaktNzngZ4+9jsUjD5N12bZwotf4zsPmj4Qt8gcTbWQR4Dbe3zax07Elgh0XyNZE
 rsmrh4lmXSLgJMjLjKOk2vc2S1yzsE/WJIEosmEpPy9hosay8LfpRYGTOLH6H28kp1v0
 ya+EwCIhfFiOfrl0AcJdGkCNPh+OEWecFXfJ0nEm9wAWt0MYLXTgLcc/SG1OrdiFpAGy
 S3lfv5huFIoWlnuWY5EIotS26B6S74KRLWlucp39AIpg7PjeX7QPAez9V6biGI6BqalJ
 VQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=REilIdBelrBb+TZiqUm1RFAvyaJOeo6FbBK1F5cRl58=;
 fh=3XcdnKPPujWCgsoSlfyTIC7mLtr3DNVpLRjg7tPS1Nk=;
 b=Ekg7DmfVN822yikAtF2XzwYu4i/rLkLe420dK8vhLU9tcAougiVI94R/+WU4fctOwN
 X+OfHRKGki0B6e5uNCf9eFxlp6Y9fv3K0V5tg2G96oRV2BajfLyhY71vhrD3B+egYRY4
 o7ZFOJXWldC+UFM8aUw5KUhcMBAfo8KvVYKHrQNeA8lvr1qJVjZ57rI3dfUwv4X/UbXw
 /PiRrWimBo8n6t7t73Mx/YGC2617hDEInz7FCaUJoSJpipR8sO1KcJ9PkCSnhKsTmBz9
 KAIfrM3/ZmAMBAxTopcobXjVT+CNtPdxfOynbnEQnP2qF9Jq5egi2nukzZ2NueYjFvb1
 hg2Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791888961; x=1792493761; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=REilIdBelrBb+TZiqUm1RFAvyaJOeo6FbBK1F5cRl58=;
 b=YIUZ5Q4GD035rFXa5ktck7yAH+j/GF4ZQzYGTN9nWn8FTarpx1m9JGKdPwyyE8dFmr
 nR6VtaPi96e8FF72Df0quo2gTDvOzjyDV3f1bfG6I0N6LmyMj3GhsKVlywJYUDl6bUfS
 49tkkzGR7Ie71TQbvttYuAyZruuKQeH9AP+ngqrBl2rL15oXi1LjSiE6eB8pQi8SYzH/
 PLn8qd1gsKXu4wsYhYtRsZQE0m/9FARA2XFcJXkm5lStnAUb4l/gC4T7R81TbOmN+b8P
 Y+vft7kNW+U2I+8hAv0yNOZMxuvHj2c/mU2kgTO/Dv/MePkLnAAperZduYuzIvtgl6Db
 IGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791888961; x=1792493761;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=REilIdBelrBb+TZiqUm1RFAvyaJOeo6FbBK1F5cRl58=;
 b=dDz6p+c4gCiupVYzLR1DChbPtJjkdKeriihNWJWcw/bW6vtRJC4Ne9yD/Pi0VGMutr
 Ww613ugbg4F3ew2Ouq0FkMyKeoqDmdNwS4vKvVhzIpkF6qsCvPxYON5GmPug/EA9vd6x
 3R/w8qrND7DEA6KlzlBEHZohlbejzMPFLcOdw84taWYnq4bV8iAR1NyFHTBGDhWWINdQ
 7W2xoFs9vdjSZ4q1IE/SVAgvjB7GEIsiOVYRkfDmkVsssdq6tRv6uPoU3lcMdTDFpsLu
 lIomrF42XksDwpePmSgrPkNaNKNYsGRQfXaX8ILV9Heref5oQM7yA+29KSCfHknDxGsR
 fRrA==
X-Gm-Message-State: AFq9FYIdDdZukmhoD33fzrm/tvIbUI7SfW0TRuyx5USiYLuXUqFTPfMS
 G64O461wCs6aKnCtep3PkDQeXbN3WfFgGk3qv65D67GEFekP4MnbR/6rfwhOK7uEa2X2sPhYYFS
 bcFHVebHUJcFNDQ0TKrmJsdJ7tSV+H1Wquekpchq9lrjguK8C9Hr8rio=
X-Gm-Gg: AYBFou3nI1Xx2KWql8sm7GJUn1AdA8vHxoD4oUlOFU/E/LKbcKJUtC5IBT0SgijXpq5
 XhDBUDtNCk0c+PwN2tx1wySyEpGCx9eZTEDPsqZAw9cEEOIO7lmayGmKPsLwDuzfs3WArYHV9+M
 x41u6+fJvXLU41sNTqMbJqmjEdwxNBlSR+VycA/uD/msHUmf0FAZxDGEfIdrP3taGmeAngCRjSp
 pBWhGWJT3gcmDosD6FgpfCVicenzVq/peNsgggEst/FSqNj+7nFae24Ss5p65D617KWamW0lRL5
 /tttbfqeO0XxrnD4c2D4d9a1njV826kuNYkO5iP74jjndLlHCaY8FGjxq/Ey1RzS+OkHTp5QLRa
 /m5u5RFilqHUuzxgldJfSsAMxkDp010V8TbyvgqPsarN71QMxeA==
X-Received: by 2002:a05:690c:660e:b0:8b0:b12d:6c3f with SMTP id
 00721157ae682-8b0b12d727emr10040427b3.53.1791888960747; Tue, 13 Oct 2026
 03:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
 <20260507155154.1886557-39-peter.maydell@linaro.org>
 <220d3e91-fa4b-45dc-a8b5-8a6ee04e1ba5@oss.qualcomm.com>
In-Reply-To: <220d3e91-fa4b-45dc-a8b5-8a6ee04e1ba5@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 11:55:49 +0100
X-Gm-Features: AclHuK_Uwo7qfyFHplpveJ2XObnAFPXuiP8zYPc683_Pf3phw5ndz1FxO6E9P9Q
Message-ID: <CAFEAcA_Yw_vLHdDOF57Yzo_39+J0TBPUrJwT-UKu=Wf++H6V5g@mail.gmail.com>
Subject: Re: [PULL 38/67] target/arm: GICv5 cpuif: Implement PPI pending
 status registers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Tue, 13 Oct 2026 at 11:07, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 7/5/26 17:51, Peter Maydell wrote:
> > The GICv5 PPI pending status is handled by two registers, one of
> > which is write-1-to-set and one of which is write-1-to-clear.  The
> > pending state is read-only for PPIs where the handling mode is Edge.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Message-id: 20260327111700.795099-39-peter.maydell@linaro.org
> > ---
> >   target/arm/cpu.h             |  1 +
> >   target/arm/tcg/gicv5-cpuif.c | 44 +++++++++++++++++++++++++++++++++++=
+
> >   2 files changed, 45 insertions(+)
>
>
> >   static const ARMCPRegInfo gicv5_cpuif_reginfo[] =3D {
> >       /*
> >        * Barrier: wait until the effects of a cpuif system register
> > @@ -314,6 +334,30 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] =
=3D {
> >           .fieldoffset =3D offsetof(CPUARMState, gicv5_cpuif.ppi_hm[1])=
,
> >           .resetvalue =3D PPI_HMR1_RESET,
> >       },
> > +    {   .name =3D "ICC_PPI_CPENDR0_EL1", .state =3D ARM_CP_STATE_AA64,
> > +        .opc0 =3D 3, .opc1 =3D 0, .crn =3D 12, .crm =3D 13, .opc2 =3D =
4,
> > +        .access =3D PL1_RW, .type =3D ARM_CP_ALIAS | ARM_CP_IO | ARM_C=
P_NO_RAW,
> > +        .fieldoffset =3D offsetof(CPUARMState, gicv5_cpuif.ppi_pend[0]=
),
> > +        .writefn =3D gic_ppi_cpend_write,
> > +    },
> > +    {   .name =3D "ICC_PPI_CPENDR1_EL1", .state =3D ARM_CP_STATE_AA64,
> > +        .opc0 =3D 3, .opc1 =3D 0, .crn =3D 12, .crm =3D 13, .opc2 =3D =
5,
> > +        .access =3D PL1_RW, .type =3D ARM_CP_ALIAS | ARM_CP_IO | ARM_C=
P_NO_RAW,
> > +        .fieldoffset =3D offsetof(CPUARMState, gicv5_cpuif.ppi_pend[1]=
),
> > +        .writefn =3D gic_ppi_cpend_write,
> > +    },
> > +    {   .name =3D "ICC_PPI_SPENDR0_EL1", .state =3D ARM_CP_STATE_AA64,
> > +        .opc0 =3D 3, .opc1 =3D 0, .crn =3D 12, .crm =3D 13, .opc2 =3D =
6,
> > +        .access =3D PL1_RW, .type =3D ARM_CP_IO | ARM_CP_NO_RAW,
> > +        .fieldoffset =3D offsetof(CPUARMState, gicv5_cpuif.ppi_pend[0]=
),
> > +        .writefn =3D gic_ppi_spend_write,
> > +    },
> > +    {   .name =3D "ICC_PPI_SPENDR0_EL1", .state =3D ARM_CP_STATE_AA64,
>
> ICC_PPI_SPENDR1_EL1 typo?

Yep; no visible effect as these regs aren't exposed to the gdbstub.
I'll send a patch.

-- PMM

