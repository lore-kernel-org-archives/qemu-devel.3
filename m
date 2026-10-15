Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDAFCC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ2v-0001Tl-LD; Thu, 15 Oct 2026 06:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHJ2s-0001TS-1A
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:50:46 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHJ2n-0007dq-BF
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:50:45 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c2e5e090746so498693266b.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:50:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792061430; cv=none;
 d=google.com; s=arc-20260327;
 b=phKxNhjPVYoH35/jl84SmoC0AG0jhKasmv33MrVoqoB/SOlwndIAPu/gBU7PabPHuD
 R0OPR6tAmxse+LQGW/jpKvP8yJbypOI/bEG9movtpEgIjQoshSOy3B5h1IekhZqfubzg
 F7xo+5cujFWOSvy6Zl4jfPALLO6qGy9k/z0dmzFpEe5sXOJ9rqbMJH/Avbfsl4YZb14c
 L+t16IkwOGP/dJytQ05B/V73RV2wTRlaqRFBIJbX5YCIAE4FACTzZ38u54dRQb6ftc7Q
 nYFyGyaD1a2UJaQYwLXBkpEYhPU/gbwh3zMQHMdlZQjjlPN38XERzuZunLeCN60gXJvF
 jeXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Q4AO9bxH+tgTrPhIoG66FprxezF6tidCBv/9483EfV8=;
 fh=v5Pz5jMnFlDUzdWcGlSvnGgj7VBaTiGDEqlonFsWKGY=;
 b=Y4xXGYw5RoZu5RrtDE2obWNGMU48eFEF45iPqZrMCPLGZdU5Uzk8R9u4ToBxO/p/WO
 B1SNtBXpi9HmaMUiGYfg2a4AHDtIWJMKqK+6RNawpYvEKycIE6IElyHKEAjjWcA2zWzC
 wdct1fvztJX87pd46/ofxTn7TzGnxHIKB5NVNhYugOq3YCraMVTyCUStp1ZyiO8ncarz
 V3gX7QhzzS9Hl8qk5YRjf8yhoQ+2+Ty0j4aKjWbUtCa/DqhMdGb7XBO1Ypaojuk3baUI
 +qcNNcdcSP/uKiXZHo+GjwToWPckzG+Ety1nt1LraVxBwmXrDLhIFbmrpaWVjq7CPD9K
 qR/Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792061430; x=1792666230; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q4AO9bxH+tgTrPhIoG66FprxezF6tidCBv/9483EfV8=;
 b=TQRo9IGqn3T0Hz0OZQGo50lo6ZANMArCbFceJ00Mb2ZFJCBcGeKFExiVwyVZJMfbpZ
 q/f6VPN2ZUJEz0nXjovMt4BdQH364QjyzcHJrHz1P2JMWR3wamUyhqsiiTasYERb9d3i
 4uQiX7xXfC3xFFx6ARjm2nzE41z88f1HWi6bO5J2le3QddkIL0OFTFZmiC/USxg6fGzC
 z1xHb/uE6ZAe2nChlV6vHWf7mKdUhgjYp8ZJNAL1t9D0te62IywFElVIa8+Ni+jRyV5W
 TuJh3h8iJRFVPCwVqAvp4VLwl9yITi78uhTNsIgr+JmZYAOTUkAv5Cn6M+hLP8eeIuZF
 cD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061430; x=1792666230;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q4AO9bxH+tgTrPhIoG66FprxezF6tidCBv/9483EfV8=;
 b=Eq5TsfkIqiRNsy+Xq8E7/KdvC9FY/jNcqey7EvtKhhqBKiaadig5dN3+i+1tmU3x/I
 lSpsxla2wAg6Sb4L36/LJf7Y2Qs8siUe94WIN7dMRlFJe3YfWV3zV/5oOolg5C8XrmUO
 iBwalFbVTi7EZ5tL2tOsYC5O4VnxLDPjk94nxLSUMuotkGpu2VCzIyAud7H9YvPleUyX
 Jfhs+a8E6ECzq8tpVslXiYEWWcLXfF31mQTyuqtivgwKvHd9moE5y5vzOj9gCUySgoQz
 gkU0/cyG3NwJdZjOQPQL95dFiedKz+Ub7NCbemyQwvXppXjNZuLJFZeOL6u5kHeT8/Hn
 3j4A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzEWZtm0pRXIQW4VeCA98y3EqxlkymMqVNgWV0jrrCN2QgIvz/ddzWszhEtVt672lgUPat/AXnf5iL3@nongnu.org
X-Gm-Message-State: AFq9FYL4TMP3edp4dC0q/RqIZAGa14o92dEkcfoHbRFQMtR7T+/OGUON
 wRU8mwIDhMjRgiDLAjeD+lB4In7F8bTsdVG6AxnKny2mzr+osLjeXxd5HR0xWqpfLPoLkDrH9OM
 INyqKJglWdNc5++Qauje+deHoBuw4NXgDBkS1htfL9Q==
X-Gm-Gg: AYBFou2UqXF4SbYuuwYzabjG2JnzIBBuDDUuFYT0m579grlpHfYU02MPnN8SLwrIjMS
 pRiEsxjz1GXv9bNcW3uatd6CZhNef8/QWqQxAiiiY8cv0cKSBgfmf5OEujt1Bwkv56GJL1DCL0u
 HwO6VZDh4YoUjA7Yeiq22jkfL2seEBA/aO2zA7IYvInWjEYliUG0RPdu7w2WhE19afbQzhmvP0F
 6lji0uRyZWXTa399TdDveFplsK+wfnwy3BlraZVJvfuiiZq7P+m20uyhZSjPaVkYOAPlVo/67+F
 4UBFgk5pVE+xvsw47PREALDrY46HlQaIuz0UN9SzH7uNNxWwDJPnDMAQaRtWL4PHE7wyhrgwFtz
 zU4qAom0xI+/qY1hYZGuyvcCP1QsZDl6Tyynk8yo=
X-Received: by 2002:a05:6938:a082:10b0:c3e:f39b:2286 with SMTP id
 a640c23a62f3a-c3ef39b2474mr118063566b.0.1792061429972; Thu, 15 Oct 2026
 03:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
 <20261013083933.1024405-57-peter.maydell@linaro.org>
 <8a030bca-4697-405a-aaa8-017baed8ab55@oss.qualcomm.com>
In-Reply-To: <8a030bca-4697-405a-aaa8-017baed8ab55@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2026 11:50:16 +0100
X-Gm-Features: AclHuK88lg45P4EkvW9HrI8lz9zJgYYWo6jTVyjchPgx-fRU5L14eo76rAgVhK0
Message-ID: <CAFEAcA9yv0GDLT5XTp_2_FRO_xRhPdGjhKbjkdfUfh=epaDNPQ@mail.gmail.com>
Subject: Re: [PATCH 56/86] hw/intc/arm_gicv5: Implement IRS_VMAP_VMR
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
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

On Tue, 13 Oct 2026 at 11:12, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 13/10/26 10:39, Peter Maydell wrote:
> > The IRS_VMAP_VMR register lets the guest mark a VM as valid.  This is
> > a 64-bit register similar in operation to IRS_VMAP_L2_VMTR.

> > @@ -1604,6 +1679,14 @@ static bool config_writel(GICv5 *s, GICv5Domain =
domain, hwaddr offset,
> >                                  deposit64(cs->irs_vmap_l2_vmtr[domain]=
,
> >                                            32, 32, data));
> >           return true;
> > +    case A_IRS_VMAP_VMR:
> > +        irs_vmap_vmr_write(s, domain,
> > +                           deposit64(cs->irs_vmap_vmr[domain], 0, 32, =
data));
> > +        return true;
> > +    case A_IRS_VMAP_VMR + 4:
> > +        irs_vmap_vmr_write(s, domain,
> > +                           deposit64(cs->irs_vmap_vmr[domain], 32, 32,=
 data));
> > +        return true;
> >       case A_IRS_SPI_SELR:
> >           cs->irs_spi_selr[domain] =3D data;
> >           return true;
> > @@ -1704,6 +1787,14 @@ static bool config_readll(GICv5 *s, GICv5Domain =
domain, hwaddr offset,
> >               *data =3D 0;
> >           }
> >           return true;
> > +    case A_IRS_VMAP_VMR:
> > +        if (gicv5_domain_has_virt(cs, domain) && s->vmt_config[domain]=
.valid) {
> > +            *data =3D cs->irs_vmap_l2_vmtr[domain];
>
> irs_vmap_l2_vmtr[] or irs_vmap_vmr[]?

Should be irs_vmap_vmr[]; silly copy-paste mistake.

thanks
-- PMM

