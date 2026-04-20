Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDA4F5A8C7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 21:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEwFD-0005o7-3g; Mon, 20 Apr 2026 17:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wEviH-00080S-5r
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:59:25 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wEviE-0000RY-MY
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:59:24 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5a40d02b58bso3183714e87.3
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 13:59:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776718757; cv=none;
 d=google.com; s=arc-20240605;
 b=MCsLZB2+uAWqO0zbC4SfqJ3p7A9tmWblKsbSP6aLateqAPkiUjhVCUWImVvMDYXILW
 PH8uisFzHVlDJNsFVDmdp6RsYiFnz6hRJy1ccRmmFhGyWeA0Y8pgZFqXakWvw4LYBPhX
 M8uEbVt0SG0Vb+0/YcsscoW2GpCMDTJOVEeFTrEEM1JRQcfoSfvZB/cVwPR84xzNZ3SP
 1nUXS3sbrQ8LS4GnTJpF2BbejwuawD9bZ/4aIQuWaGMt+jMsDNYDeob28K3hFhyBrmNJ
 LGLIaqUutOHTzGAFL8/lp8bH3XSbkLeGaJ4zOAdTA6VSeLeL1yDheYUPALluqqGs394H
 Gx9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3Hbo4lhV8KQv9BBnat4jcnFf+MxiN/zXPKwHWPMPZI4=;
 fh=MKfvnBSFAo1lRO8aAhRbzRExhIFiMgvzar7P+wAD6SM=;
 b=XSyO3th6VDsaMnG7GnkTQJAsOE8vmtXOVeG1osI3C/Y5DcR+XPsQ3MLarbKD419qZc
 pYPW51Z8nAA+P5r/udb7rTnnf28QEPHCyNKTCa57wDvEWpWQneVOxaN9RpaUpgFGUqrV
 hs+A8Rxy8hpX1A0HMbIYXRgRRGukUGLKbwgNhT7+nSBISYZpjKToONkCeDUClOn8PVbs
 rJOvbK6aliLBei4ibCAvMsBpLSF08JvbiCubwZWRro802Bus9mCO67wjzpZZOa0EjQAk
 8MXduEC51Pt1el68nj97/Lik7EN9RiXQAKOuz4pxsTSpS9wqmbqpC55CEyZREX64U6h9
 c2ag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776718757; x=1777323557; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Hbo4lhV8KQv9BBnat4jcnFf+MxiN/zXPKwHWPMPZI4=;
 b=IVhq5PjmFXFv26r9T/pMZfC4rq5ivohFqr1AkK83Auu3QXGAMbxfsBIYO+1XIoy97P
 v+dpPnG6gb23b3V4Ai9Cdsa8UxlV7p93Z+H2UvUkGmaBKqGMPbnFAAYa9VLYeEAh9MG9
 ozbvAIM/eMmyWI1FwZaNdftjAYvH+Aqxyh0VzEcGFIIy9xdcZr5123TghQoYlrLyBfao
 atvp6TBYrjPtqUA18elQguxF59bs8RlLcbQSYGbLAvF7HITfNovvLZpEtqbKW1tmJGUW
 qSmKo4ufExwvl1Pvce2X8iC9CokjugSf4pyIVHGu8CyOTr86LQuzrOY1e/U+Sa+q3PBX
 WBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776718757; x=1777323557;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3Hbo4lhV8KQv9BBnat4jcnFf+MxiN/zXPKwHWPMPZI4=;
 b=XjPny7FHu2CzCqN3043P3Mud3Q9OwBjUIKhONk+DLvwS+Rt2uC5DGVQN8m1khz9Itb
 EjJfIGwl1ZIW78CyQYI6orT+ud5gut4D/6cPHMr0XSq5MODAalCFHuaD1J/gDUX2F0DL
 oyvn1MejfhzAdyJ/tHf628DszptmWqC/zUBrhcX5MC7khKyuDKPKFJ6eoaOpxfAxPp5F
 AouiDAx8DiukGjowcgR+eLMUR+nds2iNybg/jI03UmTpQ8FOp1Vc71iOkdQMPog3tkfL
 jKSisbXFuPkjfy16ncMZ+i/MMtyu4ew53AiEW7c4yNljhIcT8nzqUtZdOCHbNjLpOeE5
 dN7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9WF2e3E/wf7LaMoea5+3AC2OneNqhizaWySqMji+Q6LbUx0C+w4ym7r7OT4m3ygdsRCBqtIrMBT2fT@nongnu.org
X-Gm-Message-State: AOJu0YxLbcYYfdNjmCWg4+vicrrZ4PEOf53UKkifRVaZir/lG0lQeuqr
 nkuc6GNBZOS4LahdiAeG+PVnzWWGGfA2rO4OzyzBCgTm5wMpjDPZGZtZAF0R3LQs1B/DeZcBAxT
 LfEY1VT4BQkpSr0wCT94fAXIwmTMw4Ck=
X-Gm-Gg: AeBDiesYUbKXWcoRsBl4e49xBkejhmvmmaj9/IYLkb406Ata+JbamvWwxVzsArsiC6l
 ucRlbECzY2Tk9jE+3vpEhkipZiuXYa2twTYiXVBtGGLkn5kjtudrW0Vo49tNTiPwtiTY9yfB8EM
 HYt/RyapiqZ+t6gznpkWtKKALdUZtErppZA0XV15xA3nZmEn82tbxiT8yEC+gYUGB70z+3AtamX
 FnSl+kB+nFhbNex44Bv93UVhQ3YHKcSm8J744PZW3f/hqkOCUm6Qv7foVc801a3j2ghZ6sUbUbt
 j509kArGRVTDxns=
X-Received: by 2002:a05:6512:3095:b0:5a3:d100:3c82 with SMTP id
 2adb3069b0e04-5a4172da106mr4943098e87.23.1776718757189; Mon, 20 Apr 2026
 13:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260414025335.2847358-1-mattst88@gmail.com>
 <20260416182527.3862296-1-mattst88@gmail.com>
 <CAFEAcA9jbwdo=a5cE7PD=YKiBv9qtCTwA=YaE6pbFf6xww0ZvA@mail.gmail.com>
In-Reply-To: <CAFEAcA9jbwdo=a5cE7PD=YKiBv9qtCTwA=YaE6pbFf6xww0ZvA@mail.gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 20 Apr 2026 16:59:05 -0400
X-Gm-Features: AQROBzBVIf8SA6i1AvpMp7XG2ZMs3s6VZM9X7hWcZddjleV-u9Hvj_EKWKAIKiI
Message-ID: <CAEdQ38Feg8HE-1t-tgDWsvM4LqJvdcm2JMB75SGXVwTwPe-5iw@mail.gmail.com>
Subject: Re: [PATCH] linux-user/ppc: Fix ppc64 rt_sigframe stack offset
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 20 Apr 2026 17:33:23 -0400
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

On Fri, Apr 17, 2026 at 4:41=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Thu, 16 Apr 2026 at 19:25, Matt Turner <mattst88@gmail.com> wrote:
> >
> > The kernel's 64-bit signal delivery (signal_64.c) uses:
> >
> >     newsp =3D frame - __SIGNAL_FRAMESIZE
> >
> > while the 32-bit path (signal_32.c) uses:
> >
> >     newsp =3D frame - (__SIGNAL_FRAMESIZE + 16)
> >
> > The extra 16 bytes in the 32-bit case is to place siginfo and ucontext
> > at the same offsets as older kernels (see the comment in signal_32.c).
> > The 64-bit rt_sigframe starts with ucontext directly and does not need
> > this adjustment.
> >
> > QEMU's setup_rt_frame() unconditionally used (SIGNAL_FRAMESIZE + 16)
> > for both 32-bit and 64-bit, placing the handler's SP 16 bytes too low
> > on ppc64. Signal delivery and return still worked because do_rt_sigretu=
rn
> > had the matching wrong offset, but the vDSO DWARF unwind info encodes
> > the correct kernel offset. This caused any DWARF unwinder (libunwind,
> > libgcc, etc.) to compute a CFA that is 16 bytes off, reading garbage
> > register values from the signal frame.
> >
> > Define RT_SIGFRAME_ADJUST (0 on ppc64, 16 on ppc32) and use it in both
> > setup_rt_frame and do_rt_sigreturn to match the kernel.
> >
> > This was verified by A/B testing with libunwind's test suite:
> >
> >   ppc64le: Gtest-bt, Ltest-bt, Gtest-concurrent, Ltest-concurrent,
> >            and Ltest-sig-context all change from FAIL to PASS.
> >   ppc64be: Gtest-bt, Ltest-bt, and Ltest-sig-context all change
> >            from FAIL to PASS.
> >
> > Signed-off-by: Matt Turner <mattst88@gmail.com>
> > ---
> >  linux-user/ppc/signal.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thanks!

I sent this to Laurent Vivier <laurent@vivier.eu> since that's what
`get_maintainer.pl` said, but I see that he hasn't committed this
year. Should I wait on him, or can you see that this gets in?

Also, I think this is probably worth including in the stable
branch(es), so I've cc'd qemu-devel@nongnu.org.

Matt

