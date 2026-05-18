Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199B1CD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 01:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmxV-00068u-HO; Sun, 17 May 2026 21:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmxT-00068O-Ua
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:39:51 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmxS-0000P2-Ae
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:39:51 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bd21ffaca79so377178766b.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 18:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779068389; cv=none;
 d=google.com; s=arc-20240605;
 b=Y47J2XQAMNBwErWmpY5e8CLrCs76uMCrnYLnWyPAqVqWad1knXkV2m96jEy2UqMGc1
 RKQGDmGMwogT1psW98fittTJW5OP1hM/tFlvnoiE4CAdKD+iO3q/fbSkyewnHRmdyzHt
 jG1SRfwAKhfNCaak5+nT/S0kbDaApXWzCtuClDUHHW4HX+tlkhl61FjRO3K3QPJksC4C
 rFp/jIlTaN3qWki0Nz7RVR5DISGNMNq6Gvu3cZjx7fzXFlKo9ZM6dHG7N+p4eNJKfXi/
 0INW5IOCQvtGc3u5HhfdVUXOiqvki/Pj1k9CsQISbUuxIDFRpk/mvQqRpshUK/3GcSo/
 he+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=M1pftVb7T1x/i67IsQ2Z40jc5S5LfzuNjNnUawzu0ZE=;
 fh=qScb1r1UBVPQS5ZTal0oZlbBSMfi7/t3WNwd/xd+w3o=;
 b=abI+Z9JTx2oI1K42SU06B/DEEbkMgKJqjH+cURAuldWNxE/+xto65NrshdUyPJnqKG
 nzGrYtHt9Cjb+Iy/jwXYHeNmTvWkyz85DIRKAWdMihqBbSG/IXLvN3Rc5UV1sb5ae7Zl
 hCmq4EnJoWZNWUTFKEIDdr6vfcLG3P5iGI2Dj9ZXmMVLbb8BsBsgLMUQHF1tXew8NIN3
 YWc9cHpVWSAUfPn55TGLSU3RTM0ynIf1iu+Cv6pxnc6Y2EOo18tCDCd1O86YkT0THZ8L
 7MgWIYi6uQdijbYDjOHDZD3kfLUooy2j3rpt/OTa9Xo1/bwtzncMHBgrneiml/mVv5hZ
 ASUw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779068389; x=1779673189; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M1pftVb7T1x/i67IsQ2Z40jc5S5LfzuNjNnUawzu0ZE=;
 b=osoXa8pJs8i1QPPrlLhhixPrP7EsNPTpq7wxy5HCWpWU2sQlXp5ZETzBSW+kqPdcc4
 CIw2XWARa6SyK194FLoOM8Vbk4kqlg+XPrIdgbGTEX5kDFKQNbyg2NVzYmlZR9/Xwl4H
 9QjMF1wuUZyMJARLMzsuAMZUF6ld+2SqcqdkvwE19YZHff6mpQvSW7aIJ18o0zYMptoQ
 f4lD2dN/wFoMnO7jtya/uXfYmWAG6V/MlI1RjtjrXFi7LMADHM8i6TSkvzJsKgHNHRMd
 OqASoqYMyg03Y3dGuuxADFAKsZxx3SlxOEU/A721CVwmkOZjZA4xYDwZg5N6lcjj/D7c
 Hwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779068389; x=1779673189;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M1pftVb7T1x/i67IsQ2Z40jc5S5LfzuNjNnUawzu0ZE=;
 b=R4KZ4F0g68bq1J9U5ku4XEpC2xrug9B434hiosr1KAgbmyQicrbII8FKuQEw79vhqy
 48Zb8dy5KTZawZVPB9N/kuq21N34VmIdPEGuDb2mwdQeW7pzAbqXMVjk47SkElQIjKcX
 jrMcfr17zk6pULdBlEgVtOdx8rtUoSxFmWAsYonXDMRc9DayNS/rkUHdFabfj3Tf9cZE
 RU6pX/q46dtJszac68AoRvq8VwrlNemNQvaU9gdcD0uKnrFx7/dsDEHJC0iHWa3zPYu5
 UzSu88NVZ04k9DASN1OkheW/ng+d39+EksSeAfuboiRIXM6/NXimNU4r/7VNVLH9GBsW
 mjBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xFwUMEkRfj/h4JTAQlKLMul9rNM7xZ6l5v34/98IUbYW2JG0LDl+AbUuSvj76GoWyMuxOUjxqUuIt@nongnu.org
X-Gm-Message-State: AOJu0Yx/HU1V8EfeDsHVAa6eOgMvbp0VnN8KlLFjRXsnDTY0mz1BePen
 c8VXXKyCTogP7vEaX6QllnQfXpYFRfgpkjYgkOIU21GxdiuH/2cTeWE4U8uI86gWDyVCyRH+JDt
 QtadMj8VDUpmnoEnb45hZF+OkZeterdg=
X-Gm-Gg: Acq92OGkxfNkIHa9wFNKG3/tNmxMyictgnXIOQ3nyvw4LM8yQ3wWC/AjHx4RGPpInoJ
 nHSd0/ygm6qfuGVYfOHDAJ0bKnCFL3NanB3Asz9nKJ2dlKr3qCuEBLtD8Hnxs17rQbcvMYHGdZK
 YGEY2hh/2xBokA7vrK/1yV+w/aqECJoUJ9oWl0eRQMeRz+odGwWTAloa13NAZ2VU0LMeZNHJi+5
 hGEbbZvkw7ZKfG+4vFqgh+XQLwBgqBOW9ba6oYnwbOdQWjnZx7AT/OI3hlIeqtpXHVoZPCoBWAz
 diDbO87NAG4IOtZ6RVdB+OgN9C5+kN+oiE+q0A==
X-Received: by 2002:a17:906:6a26:b0:bd2:be3:572a with SMTP id
 a640c23a62f3a-bd5153896a8mr628060166b.6.1779068388630; Sun, 17 May 2026
 18:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260424191129.1494381-1-daniel.barboza@oss.qualcomm.com>
 <20260424191129.1494381-4-daniel.barboza@oss.qualcomm.com>
 <CAKmqyKNZiA=rYVD6ighyFO+qmhdYVk=UgbaznBHrZ2yt1ZvOtA@mail.gmail.com>
 <wazisnbumueun37qskfnjz7n5ioqhpshesebjsczgucjmxxhia@va7avfk77xlr>
In-Reply-To: <wazisnbumueun37qskfnjz7n5ioqhpshesebjsczgucjmxxhia@va7avfk77xlr>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 11:39:22 +1000
X-Gm-Features: AVHnY4JhLvcOYA259diP8FwAp-SKTlAGsJDjnokNfAWBYD351jZHbWG7rggFsAY
Message-ID: <CAKmqyKOPAEHCnjKqwwhqjKQ3kvQUJyV3bZx5n0MRTc0DXfe9fQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] hw/riscv: server platform reference machine
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 leif.lindholm@oss.qualcomm.com, Fei Wu <wu.fei9@sanechips.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x631.google.com
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

On Fri, May 8, 2026 at 5:24=E2=80=AFAM Andrew Jones
<andrew.jones@oss.qualcomm.com> wrote:
>
> On Fri, May 01, 2026 at 01:27:41PM +1000, Alistair Francis wrote:
> ...
> > > [1] https://github.com/riscv-non-isa/riscv-server-platform
> >
> > The first line of the README says:
> >
> > """
> > This document is capturing discussions at the Server Platform TG.
> > These are not official specifications and everything in this document
> > may change.
> > """
>
> The README should have said frozen instead of "everything may change".
> It was my fault for not having updated it. I have updated it now, though,
> but not to frozen, because v1.0 is now ratified.

Thanks, this being ratified makes a big difference here

Alistair

>
> >
> > So this machine needs to start out with version support (like the ARM
> > virt board)
> >
>
> I'm happy to follow ARM's reference board's lead on this, at least for
> now. I only wonder if we may not want to use the QEMU machine versioning
> support to bind machine model versions to ratified and experimental
> platform specifications at some point. For example,
>
>  rv-server-ref      -- new, bleeding edge platform implementation which
>                        may include experimental bits
>  rv-server-ref-v1.0 -- versioning ensures the implementation matches v1.0
>                        of the spec
>  rv-server-ref-v2.0 -- versioning ensures the implementation matches v2.0
>                        of the spec - likely backward compatible with v1.0=
,
>                        but not necessarily
>
> I'm not sure if [ab]using the QEMU machine versioning support in this way
> would cause confusion or other problems though.
>
> Thanks,
> drew

