Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0EEC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 05:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi40u-0001ie-0o; Fri, 10 Jul 2026 01:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wi40k-0001fm-4A
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:42:54 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wi40i-0007a6-EM
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:42:53 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-698562f10e7so755633a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 22:42:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783662171; cv=none;
 d=google.com; s=arc-20260327;
 b=Z2rXByKbTqcGbzRHq0PI8ixVn5a6npRbrOUXc+NWERzA1MQ7oXSpAm1TCQp6KI+eyp
 LRImrB2BGWke3Ji+esV15TQ2XhV3dSTBsJXxfwgk2YyI+c2pmsAKv6ZnJgfmLxGG0+Yn
 AHQZj6FWGdE21lXLZhHhsL6jbu7euvvJ2MeJmQ6GpQiMy1IBFJrWhkqN0i0xHvRYXYFy
 3DP/LehMqAREw/wJC4mAjcFWr7F4USyZBqjue/BvTW+gn4YCstIcQHjDH/PTAgACbv1/
 Qo2qQRGoXKigGf+YVt/l7gAmizZKXkTZvMb1WyWzY9/4RHdJY44tmT6C9CVNjkfeiTYQ
 CbnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZvqSk2WtakIsnZCpRVqdcI3UDUYGElslsEYp7H/tD2s=;
 fh=Kw+eD1KruI2lssGou8hIWaiTbnwUmhFY4lL+cFAm5Yw=;
 b=l3dFwPBuh1pwlIdm0+nJKxTvuDxfsHx2g0AvrEtz4eHzWbLFJEz00mlGkAUcWeIGOz
 3o0AryGB6VWNLsjO5cX8n/59uevHJ4w5iboZF5N7QFWKnqGPgRaWRRySN7/GS6lKwaI7
 6CofCXcz8WyxhOpXPRoeuCBeMoLw49QOk5isTp5AcDsuotexTTwuSjIKfooYfvz4hyh5
 gZIhTGWj6BVJ+HbIDHTONyUioDVGOASF6ZTgGSn3pATiEUt941Blk/ZFeQlwm5oRJD3d
 dv0hPJK9cy+wbANvZTVUWLKFdQlQIWmi/xE+vMeY/eeubpSHkImfaPqsJ+el4wVgk1tF
 32nw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783662171; x=1784266971; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZvqSk2WtakIsnZCpRVqdcI3UDUYGElslsEYp7H/tD2s=;
 b=HZ4QJdD2Ou3WlgYnxwwmXVF9cG4HiwfcogVEpfJWUEqDoRpiAzZAYj0SzMgzYhjmGc
 X8EsUc5q+iv97Sb6VC/q7ebGxguqjd2b2Aa3IiX7XyG06Z60N0rno/vMbxgFs5AqUpjm
 vkOe0el1JQKlJ6DJPW6GrBYGVMLmgVk/GHMR8exiU81Lh7ImduzedtwOKJZyt9teIv/m
 ttiJK01USzhmZO0ciOUBLjm8H4lUdrydx+y9GErEFrHFZ8aQAOId37j6an7XaKAfkaAB
 htCPYdCuYAGzbb/lTQZmoaqUEwHLVhu7ytbhcPeN/PSrhd9vB3u/MFhEj32TbFfwjbNz
 EAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783662171; x=1784266971;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZvqSk2WtakIsnZCpRVqdcI3UDUYGElslsEYp7H/tD2s=;
 b=UIbwh/BmMqvfWx3+qOyCX8xg9VbV/oMV0P5nub3nB+RlGtbPelydF7F11dVp2HZBoR
 tYBUVoYlZB27kJx0pTa9ooEUIwoRpMGV4ANJazliz1ulHuXWwAiCN6KYjPhRma3ShVr1
 NsEUqqERQBuFpsXckPtW/N88iBJpvne5wehv2FFGqXDeZ+Aa6UxCLfZe5DxSyijhrSS1
 41dcU20vatnD1UDlF7ai4XqgfiS+nhN7ATOrO+WdicUp1kSpcY6gxmGMWBwU85T2eOgX
 MKneLJ4rDWq0lSTIkoBr/c8X7+RJIEgWyTNSrudrqQwfZgOuogmdzwE5JPhm9IZMnIpG
 2aQw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoDovEsVnWxpR64vMh6DVb2afgmbTmtNeIHvmeau1CQ1wjsPLvHPK+3DI2oi+VqYPh3+Ax8fTsEOxHd@nongnu.org
X-Gm-Message-State: AOJu0YxPDPDfilKo/BQgpPqnWW+bvZzroatMUdpO0hIlbG/ZoAEuBTOJ
 H648l3lKAGQj/Ed6OWmY0RiGquKI8nCLXBo8uY/8S54PehQsaKQP+m2HuOVMyQBbyru6RwA+RA6
 VJOMHr3axgvI8CwPPKqYNZJialEY/xdY=
X-Gm-Gg: AfdE7cka39V7a5TZ5PSA038Pb9Tuq9tKFwSPlixRJMCAagxYTF/GT9yZ84JH1UhdDrM
 miaxJt+DxLcRYWXD0LvxJ+2LphWUF7r5ARfF0MnrgakOcSXLy8FTSm1CxIBWCBeEe80xACgAsfm
 5WbTuIWdGKb+Rh1+digaQhM6JyPCBkF4wKfFJvy+s0OXUKYZez7G5O1KDQXeHqd83IwdXBl56yb
 FkE5V7IEzjofUIbHaW2DEgkIuhBOjnnylzSBPNpXS+Vj9FX/5ymQhLkRv1vZuGWCmMA/JDixhNx
 DSGR5ldl2xw2x5a3RdYAnh7wEGptSf4=
X-Received: by 2002:a05:6402:51c6:b0:69a:9c13:a2a2 with SMTP id
 4fb4d7f45d1cf-69ab44ab465mr4237978a12.41.1783662170396; Thu, 09 Jul 2026
 22:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <CH4PR02MB1068109FAF2014DE3A545D5EFB8E92@CH4PR02MB10681.namprd02.prod.outlook.com>
 <CAJSP0QX+aJJKes6zbxKZ0+NEhYydXhK61+cva26jTFw3dLRZMA@mail.gmail.com>
 <ba6246ab-38ad-4d32-be51-51c1c99d2569@oss.qualcomm.com>
 <CAJSP0QV9rQSmcb-K609iSje4VHgs_NK88YXKv5-LtaLGOh-nZQ@mail.gmail.com>
 <CAEqNhNZqEFz9oh2jY7EDx_ZWBgzTVstQjtZL4O3xSbK7LRwBZg@mail.gmail.com>
In-Reply-To: <CAEqNhNZqEFz9oh2jY7EDx_ZWBgzTVstQjtZL4O3xSbK7LRwBZg@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 10 Jul 2026 07:42:38 +0200
X-Gm-Features: AUfX_mxaX06tgN_y2kG2qmt3BFUy5zIGnyvGL8tGnkaAueYXPUsezqIRK2xIFd4
Message-ID: <CAJSP0QWuBjxE1g7a7xbERBRcOdbwKUjOvPxDuyBg9heXVtzS=A@mail.gmail.com>
Subject: Re: new roms/ content for hexagon: h2
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: Brian Cain <bcain@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "deller@gmx.de" <deller@gmx.de>, "thuth@redhat.com" <thuth@redhat.com>, 
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "berrange@redhat.com" <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52c.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 9, 2026 at 6:31=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm.=
com> wrote:
>
> On Thu, Jul 9, 2026 at 2:51=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
> >
> > On Wed, Jul 1, 2026 at 10:21=E2=80=AFPM Brian Cain <brian.cain@oss.qual=
comm.com> wrote:
> > > On 6/30/2026 11:01 AM, Stefan Hajnoczi wrote:
> > > > On Sun, Jun 28, 2026 at 9:46=E2=80=AFPM Brian Cain <bcain@quicinc.c=
om> wrote:
> > > >> I'm working on upstreaming support for hexagon system emulation an=
d it'd be useful to add the h2 vmm to QEMU's roms/ in order to simplify boo=
ting OSs like Linux.
> > > >>
> > > >> To that end, I think the initial step in the process is to mirror =
the repo in the qemu-project?  https://github.com/qualcomm/hexagon-hypervis=
or/ is where the code is hosted now.  And once that is done I suppose I wou=
ld add QEMU patches to add the build process and build output into roms/.  =
Can one of you do that mirror step or suggest how I can do it?
> > > > Hi Brian,
> > > > I have created a mirror of the stable branch here:
> > > > https://gitlab.com/qemu-project/hexagon-hypervisor
> > > >
> > > > Please take a look and let me know if you need any changes.
> > >
> > >
> > > Excellent, thanks!
> > >
> > >
> > > I have a feeling that the 'stable' branch of this repo was a 'good
> > > intention' that does not have a process by which it gets updated.  I'=
ve
> > > asked the maintainers if they plan to keep this branch active or prun=
e
> > > it.  And I'll ask if they can generate a tag/release that we could us=
e
> > > as a basis.
> >
> > Hi Brian,
> > Would you like me to change the mirroring configuration to follow
> > "master" instead of "stable"?
>
> Yes, please do.

Done.

Stefan

