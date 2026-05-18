Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5284BCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 11:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOvi7-0006RM-LY; Mon, 18 May 2026 07:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wOvhr-0006R0-Tu
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:00:20 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wOvhp-0004xB-Dg
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:00:19 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-65c2cd216c9so1854627d50.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 04:00:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779102015; cv=none;
 d=google.com; s=arc-20240605;
 b=P8gj4Z6m6jzLZTcIjHqa/t/FrbZS8j/YdqLF7K5LUb1ix6ZI7KXJimmqfrNgIn0jvY
 I1TvqRWquS+/HeUAnwRyeNY8DTlrbIUblx3bwAc2lL7zakNvy7AhJSHxoHVIOKx491rq
 skEF5rU+kvuatJh3LHI1rQkrnRrSNiCj/zHqnQm6gpeSiL0FWa//UQWgRXc6quHjeEHM
 aCh94OOc3FCWnUrZeWNMslQSBgt7S4CnmJWldMETBaPqdX1qY+35iIrFuCydvUmJARj7
 BNoHGBYn65op7jq6kPPcMcCp1Zn6JxSsAU7xvA9GvShLZmF/21iYQ8bu2XZ7W0/ckq0Q
 Qi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PGC3ezoKj70j6AkUxqCV4ul1+p6UXKWlRiYyn58bg9g=;
 fh=J9Ka3wuyVk7hluH/2HTyjFtnPDr4YJO0X4S4IBk+inA=;
 b=V19/QYIQLVKd15VARSsiYWtbVgIxny3XtYVTjd5AliQWmem/TBO63GbSy0NkBLuNc/
 zboXsuOBX7BqpXX7tjkQ0Jknq+SyV9lFDy4r2LxH32nBxjJwcEB4Ip4f8pcTWhYxdA6y
 VlakrP2HfJrbZck5MjVFQJH6TQ8KSdb71G0T6g9vdOPw5zjWtdmr4fFGMigv0YpI4hWj
 QoCV5om56tUeUNCGR+BtP65D7I3j+CEx1LA1Zh/5tbVuCD+gHLrgrm5S6Pa4R2F8kzTt
 DYvg3SyR6btAOvjjbbqL8YMzVOH/IbtIq6uM4x6ihVdWw1mz6mlrAxCFORy9mVj5sImD
 wzUg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779102015; x=1779706815; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGC3ezoKj70j6AkUxqCV4ul1+p6UXKWlRiYyn58bg9g=;
 b=ido6Oh3c/CpjkWSxxbCzUGzteEytzRJWbqnGmAvmrcYQtl6IMVgNK4MH+Ed/46ePZu
 ww01rpYe9ufNgZIZJllxg6DYXoohxBgC2Z67LBojM/fcaiX03Y8euKsf3PPtPpIqWbCH
 P2XefMjiYArW4nRznftQK7zNkGOmnAZ/pHdX+bjYzPp3o51Y6zL9NbLXQBvwjHPFTpdo
 rJD6VrijmfskKuyEVm5IDkm48BEoFE1xGTvEq63TVJBux/kpaEZmXeojhJqOKc/Y01+A
 FTZpSzMiqWfB4AUbMXMIdTNZPzb/ucpsEeZJHfdk66I3xDujG4qIwc8YEcKjxSs9zjqk
 2wAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779102015; x=1779706815;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PGC3ezoKj70j6AkUxqCV4ul1+p6UXKWlRiYyn58bg9g=;
 b=aQ2LnyZIfHTvcNYgIQySRQ3lp0vqdFpbH7QzQEBxqYf1VYsgZ/8Ny/pvO6PnHiVtG9
 gDluUl5ZhZxVC/f+QKhyEzo8O9pRCBPo4pxlMcpZJ20m6JdDXrFsS0JV8OM+ZfDa2NjO
 kUrhVvxKt2dWHYVwl3Bl6cz/tHqIeuR0s8PWLrFYWloiULUWBBWKfxb7oI3Y8/DYpCNJ
 KYMxLUZAiZHYKURuiWoqxtWRbrLLPvSD//sNRjwdBOUMNLHjilCUYcmyLw2EMmlj6z2X
 Lt8gQnm/2mreRt+s6INdwYJzbfChfdBpvy/sUYb0tyGFIPO0CmEfvy59yBDOtUAkAAel
 vX0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8y7ikOOr9LqYoOyfZYprMBzH5wiCInRfmqY11+S+3x+Sfiapgi44lYPsiUn1kUI2wntj3xahDorCfJ@nongnu.org
X-Gm-Message-State: AOJu0Yx/PdHQha4n1lBScOPeBO1+h5u6o0ROKJjCxZPE/7I2QZQJqcco
 ZolmtQAuxBfQMImDPqkBf0nMOUnZIIjzT/TnouWfu27m4f9tk3doRotbT33VN3WF6YBgPtF7Xrp
 lFP3HkpUpmLTGrDBnJ/LTuJP/F6pI3AtiLFrdZmZEpw==
X-Gm-Gg: Acq92OFkbbHcJoxrYAW4SmKAX+Dl01WY6AmuI9pLoqw8X771v/PtCPb8ZDg+QIpP3yS
 h2a2PMY4+sDu/+fbvmPK6xmgzyXwT8pYnVMTWAskQHk1wEz60Pohjbl9/TCIEOdikd6ojx0yFtH
 tsp44FBoDhElZUyRVdwxgFX2glijfdk2a7mKWU9do5NPICCwhfpjXCH3odbNOmjT1BR242Db0lS
 Jcx6qSwDP9AhQLGd1lEd+qTfX6pnKlpI2+Dj2hDnFFbYK2WHgj9HfFvd+0LFK8Pw8rh+58GTRPj
 A/1FHmfboaGGgO0nUEQqUrc1a+hGVEZj42X9mXDkgH1FqgrtiK10E1dioaasA3hm4iE=
X-Received: by 2002:a53:d008:0:b0:65c:7352:7afc with SMTP id
 956f58d0204a3-65e227babf7mr13094966d50.31.1779102014534; Mon, 18 May 2026
 04:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <agRC56rkfb4z6zSO@redhat.com>
 <CAFEAcA9_Xmy8FukkMDGVzU8LvE9giSp9zgrpiGvbxn=wNjJp-g@mail.gmail.com>
 <agrtSFk-XGA-EcQd@sirius.home.kraxel.org>
In-Reply-To: <agrtSFk-XGA-EcQd@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 May 2026 12:00:02 +0100
X-Gm-Features: AVHnY4Iy-uZaS3MLlUf9yiLA1KofOOD673eSo9NDGOwyxZqT--hhUBiwW0WybTY
Message-ID: <CAFEAcA9b2oeZaZtGkn5YPMKOXWDdZQEvdoBj5mGVh51aKi-BYw@mail.gmail.com>
Subject: Re: Limit USB 1.0 (UHCI/OCHI) and 2.0 (EHCI) to non-virt use cases
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, devel@lists.libvirt.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Mon, 18 May 2026 at 11:53, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Fri, May 15, 2026 at 08:49:24AM +0100, Peter Maydell wrote:
> > On Wed, 13 May 2026 at 10:23, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
>
> > > The XHCI controller (specifically the hcd-xhci.c variant) would remai=
n
> > > as our only option for the virtualization use case, with security pro=
cess
> > > applied to bugs & eligible for CVE assignment:
> >
> > I support this; I don't think there's any reason to use anything
> > except XHCI in a modern VM, and the others are useful now
> > largely in the emulation and retrocomputing areas.
>
> I fully support that too, recommending xhci since 2018 ;)
>
> https://www.kraxel.org/blog/2018/08/qemu-usb-tips/
>
> Except for the claim that windows 7 is in widespread use this
> still applies today.

Is it still the case that the "-usb" QEMU option gives you the
old OHCI/UHCI controller? (My quick look at the source code suggests
it is.) If so, that's an unfortunate default, since it makes it very
easy to pick the non-security-supported bad config by accident.
Could we make "-usb" give the PC machines an XHCI controller for new
machine version types ?

thanks
-- PMM

