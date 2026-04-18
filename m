Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29B2F99C89
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 15:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wE7N6-0004vU-Rv; Sat, 18 Apr 2026 11:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wE7N4-0004vI-Qs
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 11:14:10 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wE7N2-0002xC-Qv
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 11:14:10 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7947cf097c1so14425257b3.2
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2026 08:14:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776525247; cv=none;
 d=google.com; s=arc-20240605;
 b=PCzWhYua4IBVEDCHGmTWYyF4fC6M7RERlaTN2T6DkRhW8JXi7fM4L8yeJmdM1IAjE/
 01B1u77QJD6PKZtWPmyfjU0QmM3528kuQNxJcUQvPGq9JaZq7UwIWOHHstp5ma038LbO
 61X3TJpGrpAdxSnvnT1R6JM9OHq+/f+QrIWKIu7kU+072/HpjYAQwiXKLhp1LLkgc3Hd
 Mq9b70A+9OeUUbk1L3rqGkco91jrWnDwdwKagnYzcD+19CA1TFFv39Cbnw0m/dwpc2Uo
 PQTJI2DG6lGrzdkT05ekpkrBOjtWMP/HioDm/ffhC0YkP5APZaehFps/8dhF2ZF5pdo2
 acJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JotdqhCLC3RWhzCY0VF8TfDWQpSZiqN1wI5LkIQnkEo=;
 fh=wKVqvMNt0AiJNNYTjWZOveR6Ru3lORxepIdjx1rFDAU=;
 b=NO/s/iIC8bOI/CaWGs60V5tUVkMbassz2J2v5eCKD+iBcwaLeV4WDJ6Ub8yQ1MKrlZ
 MTdK8gST3e5i2Fs0/sRpozxErhFMnxI3jCmPr5lPpq1NWEtcpk0uNbwRGFYNBpWs3OwF
 cZw1lLOVmvaWPdaKE4eRsxZuLzj8KctT70fnGbm++Q3z1ohB20So+6ueYGC9Cc0tf1ES
 id9LDTHjWM5n0Dwtf0wI/xmBg/bkDA7aL5N1Agr+vML01wq3TzX71rrJD0wJktQXth2u
 h+Yjf6zw/R5NNmblN2Qk+4A2SrNiwFe/adlqR1xsE1gihQhHQtLy1i9Le2YXIOOtUWQH
 949g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776525247; x=1777130047; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JotdqhCLC3RWhzCY0VF8TfDWQpSZiqN1wI5LkIQnkEo=;
 b=w1jISSLYj3+MJnXbb282RB7BLdvEwzt/Cio7POFkejdCU841jgWbcmyQutLhy10Lcn
 Bwdfs+nQGrNV5bJp7mPLPAAvnEqyg+mowNhIxpUCOumK7gJmXU1EWkviUoYKXOUe3LpT
 8XaAqP9PyIPEZOY3ERfKD2jVkb38HQva2oVd3xKjGBBEHVNp681ppR32J00ypDMLSksh
 LrIt5kuX2rEhvpSZSkgFS0FRY5sZIw0GOgF5DLBjCQkgZTYNXz250+eFYDZlJgqqNfxa
 oFhbmOK5uTmYynvuYqlrEg7RIzYerPheVd6LA6jr/9GX47ipBdeAiy7lJEoReLWZ9+3H
 dNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776525247; x=1777130047;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JotdqhCLC3RWhzCY0VF8TfDWQpSZiqN1wI5LkIQnkEo=;
 b=TkKW7Xg9dxc55mNyDeB8Mz1PSJwRGpenwEHBMDRSNzp00cW968sl6C96yV6ptLntLi
 HfVfZOP8UU7XK1g7MkrqL7jqvWPVwLpgYbvTYVF50uf+GAqlpqg/WRHjR687tBOqUln3
 sOc+c9+oVWXAZLxlkfw/UAxgRb5hpf5zKozY+MrZ6Sxxq97j8OeBC2djCQgp7j2eQ2QC
 P9ApIf1yzW33cJCh5avmQ1ohklTmZENi5sCnH9YJNQEIWbonb6A/mLGnR520FVas0gd6
 fd33vt6gHxctkJU1r+ydn1xPbIjQGqcaH9hbTHBk4GP6fSWwherUlkI2I4H55xXmDyzs
 1VtA==
X-Gm-Message-State: AOJu0YzunNjdOSPaV1uDjGzlKOvFdnumDaVvLT6Ccwpr42ZRmAZ4dXyX
 xasOlnPJwbFzaFQ8X3uRAvWBXxfrv0DJFqLvx+OvL3bSJnHQmY75a1B8sVcMPDPXlbEaMD1LWNf
 wvfRpzWY/NSP/Ikxp02qnjh6l4AZJBCrdi/qz/VeHJQ==
X-Gm-Gg: AeBDietOhhQxOurhhxW37fVf/2FXgKVYdlBDLiam2YGPx08H5NPQLUPc0lt6FtnRmwz
 1cPstxGEZy+2yv4ivuobgf30PHkggNCBT4UldU9RuCaoh6i7YpUFBzsnbRdPeJ3aNhl05/9qasJ
 R4sL/0GrVi29ot7+cnUO+GCvsAXGW6hjUdfAwBBHwYPYqfs6ApW8mSmVqLwaTjk3nEUFYBmWRE/
 FPX5B+xeHtTe8hLnFE3VxnQjUw5v9ws9Ily5idBd5LXDMjiyrXlIvxiNCzry9jvvfygQNDErlqF
 UFhjo8BdfszLWuYcTTZpzVpDjt9QhDgZ8UgZwXwoSXeruIaE5JH0g4Wisq2sTnKr+NVjZ/qnYDf
 vPg==
X-Received: by 2002:a05:690c:93:b0:7b3:9175:30a4 with SMTP id
 00721157ae682-7b9ecefdb46mr71816327b3.15.1776525247135; Sat, 18 Apr 2026
 08:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260418115230.17809-1-viking4@gmail.com>
In-Reply-To: <20260418115230.17809-1-viking4@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Apr 2026 16:13:55 +0100
X-Gm-Features: AQROBzBA5tEJQXveD6CCzDtkzZ5vZDgt3CefrDOu59wWX1VgosRIXMDqdPLq0qs
Message-ID: <CAFEAcA9yq2RH226fx5vybumH=fjosPVgMSvigauAz=OK8-RWQQ@mail.gmail.com>
Subject: Re: [PATCH] chardev/msmouse: save and restore device state for
 migration and savevm
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Sat, 18 Apr 2026 at 12:53, Trieu Huynh <vikingtc4@gmail.com> wrote:
>
> From: Trieu Huynh <vikingtc4@gmail.com>
>
> MouseChardev holds state that must survive migration and savevm/loadvm:
>
>   tiocm   - serial line control (RTS/DTR).  When zero the mouse is
>             considered powered-off and all input events are silently
>             dropped.  Losing this field after migration leaves the
>             mouse in a dead state: the guest driver must toggle
>             RTS/DTR again to re-detect the mouse, which most drivers
>             (Linux sermouse, DOS ctmouse) only do at initialisation.
>
>   axis[]  - accumulated X/Y movement not yet encoded into a packet.
>
>   btns[]  - current button state.
>
>   btnc[]  - per-button change flags used for middle-button tracking.
>
>   outbuf  - Fifo8 of encoded mouse bytes waiting to be delivered to
>             the serial port receive FIFO.
>
> Add a VMStateDescription covering all five fields, registering it in
> msmouse_chr_open and unregistering it in char_msmouse_finalize.  This
> follows the same pattern used by ui/vdagent.c
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1234
>
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>

> @@ -263,6 +279,7 @@ static bool msmouse_chr_open(Chardev *chr,
>                                              &msmouse_handler);
>      mouse->tiocm = 0;
>      fifo8_create(&mouse->outbuf, MSMOUSE_BUF_SZ);
> +    vmstate_register_any(NULL, &vmstate_msmouse, mouse);

Adding a new use of vmstate_register_any() is a bit
unfortunate -- this is supposed to be a legacy function.

More generally, it seems odd that the chardev has any state
that needs to be migrated at all. The chardev should have
state corresponding to the host's situation, which is all fresh
for the migration destination. State corresponding to things the
guest has or has not done ought to be in a device model somewhere,
surely?

Put another way, why is this msmouse code in chardev/ and a subtype
of TYPE_CHARDEV, and not a device in hw/input that's a subtype
of TYPE_DEVICE? I guess that the idea is we want to be able to
plug it into any UART device, but that seems to have some issues
when it comes to migration. wctablet is probably in the same boat.

-- PMM

