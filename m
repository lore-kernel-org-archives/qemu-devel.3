Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED21CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDf8E-0003T4-2A; Mon, 05 Oct 2026 05:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xDf85-0003Qz-FY
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 05:37:05 -0400
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xDf84-0005eK-0B
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 05:37:05 -0400
Received: by mail-dy2-x0f.google.com with SMTP id
 5a478bee46e88-33e46a15703so1966219eec.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 02:37:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791193022; cv=none;
 d=google.com; s=arc-20260327;
 b=GpDuwKzyAZdSO9IWph3ggssS9sZVCd13/4mCmwfaRFVwA7IXv9UsAgzCzflY/Y8HBZ
 qq9+KpjMHcFNyt75uoEs8TWbELJfEz3mAUUnmeXD5U2SQUmKv1kyqp0Qv/5a8iTzAKjb
 ZbuT+o+6H275HChvOyCIg8QcNCILkyH2eXyHF83+aAnrTdVgbH0ua8BMvsjimuaiX1Na
 3uViGBn6J5SpFTm/w4mmxbKI/9aFpmYoT/pMi5i82SYykpj9ArcV7uCh5b3sL2FRei9j
 Xap14g4W/yTR9b867v+kzYT+G2+i8j/5bS/sPQKwNN6Sthl47WRs0JjVm407Ez+3swCa
 iwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GTiv1fhRPhDWp7ImGaHkQ46p+yAlbqb7SWzac+1K0Fg=;
 fh=9hR4O5oy0K5smMLTrzKjtWd1Oz3OjunuLWhYbui8T0U=;
 b=SSnRL9taR4MvddptnJ/ofLKKZX3w0hyVtxdUd/n6voW+glxOzOpCGL6PTuQN+4Qfq8
 OhF97JaZIC8Vn1MTlevEUG1JxxL4XHxCG5GmPjNpSmM8joQwm5yOkQdHIhW0sypVqrVQ
 +WPPdDSgzjbaHYCSzrGwEr370GtyO+3iIvFMbq9krbDPLoLoD/yhdk18tp5zS76oQ0/w
 /uQf6uDe5JAb4KsyAXpx4u84CEzReuwowXM043+7WbHQUODND0r7+8E8MRoKRmQRHwHe
 JUanC5jTinPOIGKqQQ/IqFnDJiil+4nFILnhH689+YMK3JgkAbXHVWg8R+h2tFWHvGJq
 627g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791193022; x=1791797822; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GTiv1fhRPhDWp7ImGaHkQ46p+yAlbqb7SWzac+1K0Fg=;
 b=av7Bg6R8Siw0yVP5Y0E3DO2TFT01j7MdxN+LSRKEF7RM2+RzI73IdSc2SklbaZorka
 gKv1yBK8QN6WTQnzUSUqz2tApcoWEGkMU6oj+yeGAyh2N98iPpHESBgWPFxJyYWng80z
 0RPcpWZNvIz/UdcPRkzMZYyxT6E3gdNn5Or+zc/DQRmkr4/1QnEHO66kiQ4opsehbyUq
 dtLjm7vM8xW9GlijvHBPKyjaQHe94u9+oE6ranLneru60D0B1LN19yjpGXvcUHAW3RPl
 g0iZ8itYeBDYYq3exw4mp2A1O6euVENidvkQml0znfA8KtFtu/5SlClI4WyW+PoOcBAY
 6Wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791193022; x=1791797822;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GTiv1fhRPhDWp7ImGaHkQ46p+yAlbqb7SWzac+1K0Fg=;
 b=EUNo6YQTHBHQfWq5cfIDFcmuYnt/inLM43+LrrudlRIj/anb+NxCOfE31te6bVj7nk
 6/BNA61k0VsLWMk20pKZZwPS2EfGMKupAb4gZFMi2L/D4mFMTlan9SRsyGOETRaA0znB
 1nADuZe3pLzT2M9FDs67V4E78E7FvkBX2aQ1UhkRC4rT/T/Rw6M8bOO0zrBq7FyQBwP5
 dagNl1GnP3sovM4Ze6VQAUlim2gqdbOi52vLIvcmFdIlPwOyojLFhIVJl+hqsdmIe6eK
 V7gB3MtebsJMnwyazg4YTblJz49hYnnw/Vnxi1VsS926ZL0OvklSIEidqYtSOJZUI5fj
 tAUg==
X-Gm-Message-State: AFuF++lipDrVuzg9vSldbRUQWp6MN3u17hznWPc3ZE69zxrK3tgTy87X
 vZ1dATI9AJ2yxzXTsqMMTjJRMFUu+9YXi0xlyvEqhDAedXnm9J/BjdKIjLnuWBRS0swnwYzcOEm
 Jq0s+hdrPaibNtW7CRKzAlah+b/QMyhY=
X-Gm-Gg: AYBFou3UbY+0JnPSnoxST14cOsDHN87sEjeRMPjNskMl2t1gzmGDaTDW8qKRlDj/NOW
 EjLL5G70GzceWDteJk44AtgCKLWqz4uhxOvFBue3fcV7NoDgLCOmEzR9/1FNh/3hIkpNEYZNjt2
 vG4H6YJNPpCIeuQ7gW/4uVpho7Ekr5s9k74JNY2oqIGS0Wxp71wrtNIwGbyfh5Ezuk5g+++Kir0
 Qqmjep+JfcnF2lOg4gvosoes597mkR30cbkr+FMyy5zQZZgXYLNyp/vnI43s98jY9/1ysiZX1sT
 3qozqU4xqqYgNGN/Jo6uEYBRboLug4IkrY/QtTFMpV0ipEPF1WWalwpTiJiEpQ4Zqfmc//Qh6SG
 X9jt9sy7oqNs=
X-Received: by 2002:a05:7300:ea0e:b0:33a:f8c8:1d47 with SMTP id
 5a478bee46e88-34f2185d25bmr12282175eec.28.1791193022335; Mon, 05 Oct 2026
 02:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
 <20261004-issue-4560-v1-25-ccbef537cbeb@redhat.com>
 <CAFEAcA_SEJr+ZC-SgZxzY2x8Tuu9HzW_HVDrbu4yzAj2G44Q3A@mail.gmail.com>
In-Reply-To: <CAFEAcA_SEJr+ZC-SgZxzY2x8Tuu9HzW_HVDrbu4yzAj2G44Q3A@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 5 Oct 2026 13:36:49 +0400
X-Gm-Features: AclHuK_pDZ4-5c9AO15iPGFzHjlyLBx1Ztu9N2pAIagNeXfyb3JSlBMlFWUdkQA
Message-ID: <CAJ+F1CKXC1WL=ndgi=ddEuuuqSiP-46TC=FiYq_Myyqd0GCx2g@mail.gmail.com>
Subject: Re: [PATCH 25/63] hw/audio/gusemu_mixer: use unsigned literal for IRQ
 bit shifts
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Pavee Hui <phui@google.com>, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:36::f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy2-x0f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Mon, Oct 5, 2026 at 1:29=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Sun, 4 Oct 2026 at 11:26, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Voice ranges up to 31 (NumVoices & 31), so 1 << 31 is undefined
> > behavior in C as it shifts into the sign bit of a signed int.
> > Use 1U to make the shift well-defined.
>
>
> This is *not* undefined behaviour for QEMU, because we use
> -fwrapv specifically to avoid it being UB. The change is
> reasonable enough, but we wouldn't be doing it for UB reasons.

Right, I'll adjust the commit message. And also update gusemu_hal.c
for similar correctness fix
thanks

