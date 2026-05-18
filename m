Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2704CCD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 01:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmvT-0005Lp-DE; Sun, 17 May 2026 21:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmvR-0005Kw-A0
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:37:45 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmvP-0007oz-HK
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:37:45 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-67cd93d8affso2237274a12.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 18:37:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779068262; cv=none;
 d=google.com; s=arc-20240605;
 b=FFVFSDyTVggLpbyBSPwMd1/3vULRYEGJADSuxisxAUgu6YhTJryMgWLE/UV4BMgO19
 UHOZG6Mjaef/DXcMhR1btEoEgHG7bBSvBA6RDy71rwiN9IEGsZF4SqRBF/o4aSHLht18
 AjnLRH13MEqd3LZWm0+Yx05ICAUviNkMA7C2EaP4KWwiqlROf9Cdkofq7An1o27+aVNL
 xfcrz+tZKlWq5RRKdh1eqwZGqVSVHB198mGj4DrwagjQ6pmlUkLz5uUCSBhD86gvZFC1
 PVblZrbc39R2aYiPIV6LfVECfhRfZaZIVAIppC4LnBFB5BPD27CDnx4xzpPNXlfTYfId
 cAVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7hKWJrpBh3x+vJM/Z7tyPOayxeNL99NcPlGWE71D6Fk=;
 fh=DvxIri4+0K8SkfgnTc9mXHonJQMqusekyRNY5M1DsMw=;
 b=OUt1fgQRmdE3wjHgJvF8rNCi302cf1pylKgm59vQA/sJJA+Z2YBZ8Kf8VHyl0wxXg4
 LlaJL55ALdcVYLDhvMW/qsrlfK15hh6KREkCu2Ux2/76YfYfsR738WniN1nL/2/59/Fo
 equZpcixoC6ajCLKj01oY43cXXHCYOIClAyd+ENVdrvrQJv5G9ZBqT6P5CkrzShpMAXv
 25ygf0sLBBOj3UZ9cxfzlkBas0M89BAwi7qF5vEyIYKFgN7nnmKTA8GqkQW+g7FQbOSs
 Vyu+7eFCiSrtE90m/GoBSmqdm64g+BRtwMBh2QSenJhkACCEx5EvdbtM7SaACtpb0+wL
 Y89w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779068262; x=1779673062; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7hKWJrpBh3x+vJM/Z7tyPOayxeNL99NcPlGWE71D6Fk=;
 b=fjxTCOIYeXVvMNTWaX+muv6eMCd5hvs3p+Ybyx0IM+USHVHDwero8kYbDxilylx+jg
 mdxfyZYiCva1FfTnK7D5LF5fi4aVdh0JoqweJ+unokSzGt9FASFaHJjj8TOKkLq3hvz2
 h/lvyW7pa3DuvYCYmv5PmP5sjBLYw4C5lUxRvEeAGAcmJMdPHi0MZ/UHfi1XYiNQgigJ
 i7PSI83FyEjzve/L00Tvwe925LH3/y0cTwAxs+kXaAk9z8sO0t7CT+vxz+2MJBTQvn0g
 bXV1ZtSEzVVle+uxzd1B4bE54g1AUjvk+YXkwxRRBWGulTj1miwpYpTsvEpXFZt+bdDc
 FxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779068262; x=1779673062;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7hKWJrpBh3x+vJM/Z7tyPOayxeNL99NcPlGWE71D6Fk=;
 b=ow4KfW8jTuYk+XAWbWN4Zdn9rC/+7yMjcDCB4xq0zzid5ikaoIJ8RW4oYiitgoKbTm
 3ZhJ7itqukGTsVCP6h7jCDyDcQDVe8vIPjGEFfQHit3GiB1Prn6ij/9aHa+bcCl1RsCf
 KWRm1y6FMFWOizCiE1F4iVUTGldsrPTN0yciZDwC/iSfL+fQj8DaAHjya0LJHEDFVYp3
 jtcWvILtF21oaqOjYx/j5HSRM2S79YVtBKynDUfnrnrGZ8VyTKiWnQ4IA7n1U564NT0d
 QepQm52V3H/WL2dmyZt52X5uMAieezASCyNUuclMz6pwVNFnjPZXT+LhX5Dp3FrhIAPO
 vAvA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8SQ5nATY99ggIgaHP6zM9D9F5sgYWkdX4iqb/0o2nD5UDnLn6rEp5vpv1RgBZccjn47utafQvQVf+U@nongnu.org
X-Gm-Message-State: AOJu0Yz5GrFW2v4oEgLJGWMbEiON3nUcrKodN77QXC76ayQgwghcyo1s
 5Dv4IbRD+bva50vx8jt3iUTIE6CFngmuD2fj8TTxJL7f2RYDeEf/JYaE7A/r7zzQwzeLBoxeGpz
 iHarxm3tqL6XUl0ygshqQtTDq/8BcEObGrTda
X-Gm-Gg: Acq92OFhIYAKDjcaB41Xmu5iH5MajIb3lcPt3ubyYc6gK4UQ+CpdLz3pmwAQzYj1isV
 qkOaQEB6OGLDlQ3iMDDnOEDttcfuuBNIpZXn3tHD7UEWeRgcj70ZAWVL1G62pESbSCxBstcrR2+
 Fa7SXpk3cA5n4PU7AAfwIhreWMM4KuF2Qlaeajp5Jk0arjipn5erkszA/YOXZBiE2ueY8J3vJ7Z
 hrDcoUUic/oAfn+YzumTnZFvK2iwjFSoWDoMDsVfCHZtxw0lKynUuDLkfXcC8sskCz4xPr7niT6
 FnDEi8o+k4opnzUxPK8MBwZte/7s+yMrgbcVcJGfsS81eaTl
X-Received: by 2002:a17:907:9999:b0:ba8:8094:f7af with SMTP id
 a640c23a62f3a-bd517812fdcmr622723766b.18.1779068261596; Sun, 17 May 2026
 18:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260424191129.1494381-1-daniel.barboza@oss.qualcomm.com>
 <20260424191129.1494381-4-daniel.barboza@oss.qualcomm.com>
 <CAKmqyKNZiA=rYVD6ighyFO+qmhdYVk=UgbaznBHrZ2yt1ZvOtA@mail.gmail.com>
 <CAD=n3R15=vCCgQQhEWXPRc91T-8a02JJs2t9s88dVDLqTi_QZw@mail.gmail.com>
 <CAFEAcA8ZcpUPGRPAsRgfaBd5xpXdCVuyNeoWubFKMLTdcoekSQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8ZcpUPGRPAsRgfaBd5xpXdCVuyNeoWubFKMLTdcoekSQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 11:37:15 +1000
X-Gm-Features: AVHnY4JMmKaqv73VxJcJGgHT8BNc2o3Xz7nsQbC_jpj-D__ykDzmmJN559NooCg
Message-ID: <CAKmqyKOpOezkiRYf-93fc=eqeKpe8_NFe53Ardmszro7s3FNHA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] hw/riscv: server platform reference machine
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 Fei Wu <wu.fei9@sanechips.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
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

On Sat, May 2, 2026 at 12:30=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Fri, 1 May 2026 at 15:02, Leif Lindholm
> <leif.lindholm@oss.qualcomm.com> wrote:
> >
> > On Fri, 1 May 2026 at 04:28, Alistair Francis <alistair23@gmail.com> wr=
ote:
> > > The first line of the README says:
> > >
> > > """
> > > This document is capturing discussions at the Server Platform TG.
> > > These are not official specifications and everything in this document
> > > may change.
> > > """

Ah, this was just ratified. So now there is a version 1.0 and no "this
may change at any point" notice.

> > >
> > > So this machine needs to start out with version support (like the ARM
> > > virt board)
> >
> > We ended up not doing that for sbsa-ref, partially based on advice
> > from Peter (added to cc),
> > which I can't right now bring to mind in any great detail.
> >
> > I would expect the same argument holds here. Peter?
>
> Roughly, QEMU versioned machine types are a big maintenance pain,
> so we should only have them where the use-case is that users
> really want to be able to run and migrate their workloads from
> old QEMU to new QEMU. The use case for sbsa-ref is "I am developing
> the full firmware/system software stack and I want a reference
> platform for that" -- nobody wants to be able to run the older
> version of the firmware/software stack on the newer QEMU,
> and certainly nobody is going to be doing live migration of the
> software between QEMU versions. The small population of people
> doing this development work will be running the bleeding edge of
> all the components involved anyway, and to the extent they care
> about running on an older / newer QEMU for convenience they can
> handle that in the firmware -- sbsa-ref passes the firmware a
> "machine-version-major" and "machine-version-minor" that we
> bump when we add something that would be a compat break with the
> firmware.

Now that the spec is ratified and this isn't expected to change weekly
in user breaking ways I agree, thanks Peter

Alistair

