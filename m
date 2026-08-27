Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C179BC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 17:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzdyI-00036z-SL; Thu, 27 Aug 2026 13:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzdyF-00036h-T2
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:32:59 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzdyE-0000ff-7Y
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:32:59 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-836c8bdac50so1541727b3.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 10:32:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787851976; cv=none;
 d=google.com; s=arc-20260327;
 b=cFXIAwQfmGif8jnv8GWuiua+4ZhUfJGDIyR3i4QQiYpikDD2HQbPXoFt0DKQuT0l0W
 75AE2UcRdt7CaOI3Vv9rIleat2AQnslZ10Xki6GYsV7fCW0dRHtVTescWI4J2VgAKwJs
 sNcmnE/rD6ulsnaeA63EoIEscq0/fJ301ueWt6Do+HOeI0sjAIDkbJ75T0dAWOKbVVp2
 qWNTDiUjT41UogFl3OhuJhLuN5kazHLchTsWmxZd46tmRS8+WaBDkus0DKvc5UlnF8Jt
 c8orUtV/RbsyR7nAn9/16FURaqBlLa5qIE4sruZEkzGKS9eZ8i0EH2bdirzxoKlcciEO
 bSkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lrWflAAXTaqDYzJS52W4TqVeq8OYWt3FrREuDezLNWA=;
 fh=iTNIOyzUloF6F5QDsXHH9yAZr7IBSBnKEuTDbCMDV4I=;
 b=pMd0Ms4V9HZpU6em0JVJ1nEDycfvRASAuD2saErQjdakKRbDlHljKjRNGaqDGTxthA
 07iFVkeR/zlrON+4ICFwYLBX1ukT51D8gFID8E2/k9iNiO+hI2A5refvleA9YKhr2Zz+
 VPGJjuZAlc/MR1tCMYhwXNLD31qU9t5+lELkWenmJNjPyZtbf3FbouBx4/SLywz+dnxX
 e0J6sDEyxVlo/Vzzxh94Fti1F5/vG1LIrJ8T0e4qCJP8Pk+FZwK6PCcXNKR+KgyftysC
 Y1LQmy8TGZsNifnDOCkYX9Yk6sBpsIrb7ueMz5DLvd5Wv+QbykOMhWwrtAeQ/dGmn5BC
 v29Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787851976; x=1788456776; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lrWflAAXTaqDYzJS52W4TqVeq8OYWt3FrREuDezLNWA=;
 b=QaZy2+j9Smi9sNjdpCJG7FCeEMDo7YEPH53v8ENYNmA4bqhmwYd1lwd0x0+dZtTfy9
 XRaxN0kNjmn1WKX8pzU/TRpKVmiMHp55KFs5rpczJ6MKMNhKItwTNjBwXmypfTwW4IJE
 Y7/iHDyi/6GNp7FD+k+A3j7ryPRE3KzlA34XQYkP3h3wXgiys31dMC6p7JIlBGvBHXqu
 JJmQ+de1q5Fk9xGwR5unDjqWF4zN1yJ94F+IIYBKV2hX04/yWqsmA6v6SYTvmfebE4Hy
 HpuIBd+eb3nB2/iB8cPvg5EP5r5UwVr5LyVD35Gx4Ddi/isT+S++akzNjEwx05+3bF2B
 0kYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787851976; x=1788456776;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lrWflAAXTaqDYzJS52W4TqVeq8OYWt3FrREuDezLNWA=;
 b=JCx9SeiqZfp7Uu20LAnqR0JcnY3itshvhWQr2V3lt2aVJ35dhPckExEkuVUSTldLJa
 bJbDImgr2vicP1eneOinQuAOqEDJ0O1QRhBrDc4xjB+jvOTSp5ApVuHG3R2EX8X0yT7a
 Jo0e6cdDJ723iQaCb/iGW9/dqjuknF0+0qPq9Fx+XHkUhc83H1i+2ZtX/8xk4E4irZEZ
 +yrUE1+HkFePBVwzYqRAAFfnV/OPFfkwzvMNh8yrPFv8G8PJfP2ogEpSS3CJ7qvK1nj7
 j9aSSirtynprcxmGr14bji06clw8OhbVzatLxe5lQeYEuA6KHROhXGXaNglUM9PQCdyW
 DdxA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrd0yDpzasjbA1gKMr1LHoZWRGAMQiM2X46gzEP1im9Kh5CVHDP54lExkp6Ny+csKlXTjDH+Sna+KL7@nongnu.org
X-Gm-Message-State: AFuF++mfuaQ+bpxBMTjrLao8UFMvZSpUN2AuvT6PI3358NzEVyAMhMq4
 lOkxvFWs/hi51hDlyCaDw8lXnEI1OKEUYUzAXo/KYfQze9HHEHXNqFUtDOxaCZLX69HiaSFCADA
 8WyHdjqnMwAruGh0bNLy4puG3q8A1lImkImOVp8e9NQ==
X-Gm-Gg: AR+sD12jHBTgT0lWiHWkYLux9sE7eTk4euYQhi63b4O2YcK2TeKjI2NZcmN1C6TTQzN
 gDZJ8akf35HtHqVsCOwtyiX7FDW0Qe1OOvJnN45RGMWx7tzEfPJ8cWXJyUJAZSeY9uSyNmZLGuZ
 c58hAqkd0pzDWXgHmQ3Pry6+pl+Kke8uUzcRxs8ehcD5cd+3Dro6Qqt1m5gGU2oBNA0QVtsgxRj
 iQXfuTmTbWIbfpplpOtqQO8b+77YFDH8/brb/UybZcIey8IWcFr0Plt+u/aILUzWu7//lYNkN53
 TP3lXIEAZo8TslkG28xCsZk6kWM/jYBsORz4MMzm0uectwbOV447yMKsLC640ZSfJSMV7qcSekA
 TlI5iyjPK2s/sc1kEql0BtWPmXtzpssAP35OUQXk=
X-Received: by 2002:a05:690c:a4d6:b0:81e:c736:acce with SMTP id
 00721157ae682-85d6e827e2bmr3776067b3.32.1787851976096; Thu, 27 Aug 2026
 10:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231007072313.22108-1-huth@tuxfamily.org>
 <1826b106-2b9a-41e2-81a4-8a3439f9c511@ilande.co.uk>
 <bf3036ba-0259-4757-a249-68e2a15af1ea@redhat.com>
 <74883723-8f58-404c-9bab-ddb9a4aef4a8@oss.qualcomm.com>
In-Reply-To: <74883723-8f58-404c-9bab-ddb9a4aef4a8@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2026 18:32:43 +0100
X-Gm-Features: AcwNN1X3aTD0qq0SCfio-ZAXvc8dgowHZW99i3mvHZu3pFqSAkRBuG03-6IoQ3s
Message-ID: <CAFEAcA_ALPTQLQwA_XzqOr=Zuc4_K9=LPNXN9jN_i0fyouqwxQ@mail.gmail.com>
Subject: Re: [PATCH] docs/about: Deprecate the 'next-cube' m68k machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, Natalia Portillo <claunia@claunia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Thu, 27 Aug 2026 at 17:09, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Hi Thomas,
>
> On 27/8/26 14:54, Thomas Huth wrote:
> > On 09/10/2023 21.39, Mark Cave-Ayland wrote:
> >> On 07/10/2023 08:23, Thomas Huth wrote:
> >>
> >> (added Natalia who was the GSoC mentor for the NeXT cube work)
> >>
> >>> The machine is incomplete, and unfortunately the hoped-for improvemen=
ts
> >>> never happened. So it's maybe best if we mark this machine as depreca=
ted
> >>> and finally remove it again in case it gets into the way of a code
> >>> refactoring or other reasons.

> >> I'm torn a bit by this one - on the one hand the NeXT code could do
> >> with some love, but then given that the code already uses qdev/QOM
> >> then there isn't really much in the way of maintenance burden. The
> >> main concern for me at the moment is the use of the old-style memory
> >> accessors that pre-date the memory API.
> >>
> >> With my latest ESP patches I think it shouldn't be too hard to update
> >> the NeXT DMA controller to get SCSI working, so perhaps we can leave
> >> it for now if it doesn't cause too many problems?

> > Almost three years later, the world changed quite a bit. We're getting
> > flooded with AI-generated bug reports now, and of course people are
> > discovering problems in this old and neglected code, e.g.:
> >
> >   https://gitlab.com/qemu-project/qemu/-/work_items/4303
> >   https://gitlab.com/qemu-project/qemu/-/work_items/4304
> >   https://gitlab.com/qemu-project/qemu/-/work_items/4305
>
> Hobbyist motivated machine emulations never committed to be
> secure. While I appreciate these bug reports for the overall
> quality of the project, I'm taking these one as lowest priority.
> I wouldn't even mind of closing them as WONTFIX "Thanks ...".

I agree, but also they can prompt us to look and say "actually
this machine is no longer used / never got sufficiently
implemented to be useful / has no maintainer" (cf musicpal).
So the questions here are:
 * is the machine's functionality better than it was in 2023:
   can we boot something beyond just the firmware now?
 * is anybody planning to actively work on it?
 * is anybody using it?

-- PMM

