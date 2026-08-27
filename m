Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4598C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 04:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzSBj-0003RQ-VJ; Thu, 27 Aug 2026 00:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wzSBh-0003RE-Sm
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:58:05 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wzSBg-0000uw-BI
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:58:05 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5b0231a3e86so1585215e87.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:58:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787806683; cv=none;
 d=google.com; s=arc-20260327;
 b=hNlICqpP1MiwAPi+komqicIuVngxncVuRXctHw9c+cNQr0EMl4chTVXUTEwvk31YFz
 gsZL6+7/qcVOAbJTEbkC8h6x+3AW6pUDf73Li27k4zmG6uulrSn/TM+I/YYSkmTC57bw
 DqSx3N2uQQqn9u4vI/6XkLRJH7j1814zDwYLJcCWKk5ObsFgubiPrUedFlSjRN2Mjy+S
 ZV96DzNTATcN+F4ZwZEmit6qcYGtvwRvqF+uEjvOjymueexHNluKFnRd7aL9DQ+7hvYK
 QhrTFvaXl87ZLhLy1XuJ3gZk1SLJU6sz6xYHJrNSBd1/HBouM5zEEnckAu+liFgu6kQu
 EzHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ra3VUeTQ+90Xz80S0tbH/wzwxEa0svSPzY6j4HcnEXw=;
 fh=QVe/7zv5OrYmrprO28ljpRmhYeOlvvTBoRQtHWn+3sI=;
 b=loQqRTsYBdLTrJs0oBPQ4v1vlD+SnhLdLDDik4dPpq3TKJul0AP//iMLVR2Zqaqd4G
 H/ajJ44uVI/oSuApkhczEVXx7somrUIl87OGra5j5Oe3ilkmDEu9e8zIecHcmw6NNTBw
 SPwpYKxW8MpnNeV7FBMHPfoSdKwE6QngLOG7jTXM1KH4zEONbXfxrXfoAD6XNGGkUWOd
 ghPeBBx0XQYnYuutLLLBena4v1ruO+TOtcubECKmyFDrRtIL2tD6v2m1QniGMV224tk/
 MidZqrm21StmK4n3JV3VeAcmsROeX7ndqVsZxpTFHvb9IoEoIUEqnf53jkEg4kFsAwYF
 4HpA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787806682; x=1788411482; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ra3VUeTQ+90Xz80S0tbH/wzwxEa0svSPzY6j4HcnEXw=;
 b=J9yi83OkvHNY1zX63g7pkhP8uMoHCbjPQpBh0Uv28k6p72BFC5W6XXpTJyZb0BiR71
 HHrWbGQYEL7OokFj6cS2l+6/1ooaBd2pzaAlA8y3IXEh+FZUR8s5p720qGsMY3qEWgWW
 x9KjsyBJdRsbM2VymFx0dHiPfoKq5TSAzqTw36jiosLEXKTKqEtwrscCvc2NWwKbs+Xr
 z3XrghkqKIQ5DJCfKROP1j/RahsIbnONIASMnJoPmXJKoU1i0CJ84ePU2E6Irhvl0niO
 JJP2gBaLpiRBz0TCrNBjQmHdC+iaTv0OnB9C7LPoy4llOg4MgRoPqX/dVktqCX/1CvzB
 fERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787806683; x=1788411483;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ra3VUeTQ+90Xz80S0tbH/wzwxEa0svSPzY6j4HcnEXw=;
 b=jhfWmb0XyMUK4dEZcce0t42KLbgyaFsgP6XlHJVpqxpaBm441PlnVSYWzE1BtGRlF1
 PlRZYkZL7SADcyOVEMGdEVTcL0ZYtDk/e8ISV7Gk3h6NZ38JB8bk7D3K7KYztsbadae+
 XIDTXK8HqsaIDRmnitXlYblfTH9ywMnR+oEFwErH/Rzxa5ksN5p3oJczRIRbG5Lxco/M
 v43WqK3D+ko7VxZ+l0jrWdDtxZd2hwHUSwTgYAcEa49+smV2JAHFI/FBFZl5gqeR4vjT
 qk8mtLTCeVLuls5nwwVMTu89PbpK3tBl4SEyro3AQgayD4nxpZCj2jqTFzCxS7U8LEAa
 6FbA==
X-Gm-Message-State: AFuF++lK3O5ch16YOj0kLG+Rh9ZPHe987SOUg27qYTr/id/BiuB3wQqG
 JADnmRbqYxd9g5v9ROY4iFVtWYxUc1dapPJk2oxcW4KadArRBrTAX9kYT90gbDbGZK8zf0T3X2M
 Dbl2e2JphEcc8/6JRAr5s3asV1/N5H8U=
X-Gm-Gg: AR+sD13BWn5myuC4dDftEil3SsEaQT2q7uWqf6Qic6G3XT6X9nQ0HAwHfbNaabldeTB
 UKOXH8StGGvvpCT0uy0d3dduQRSNt16322kq5yzIFrJcnDN2nIcupEXxAaR2ys+2LO2gCsOp13V
 uU+/qXLZ9GyH3JZz8PBNdF5RiIwSFh8stAjFu9WGFHzyal+gfh8k/E3ha2DjMuwUxca1QBNiCNQ
 kD9v7A7Z9XMHGOSu2F1KfTGdMr327IRKDewmKs+edw7F42r+n6exVtZMQvTUQYHACusBr3YDQ5V
 9hW96rVms/4dfvmdnV4iu1PnydZAy9djO43Ou2VHLw1QuKY=
X-Received: by 2002:a05:6512:32c6:b0:5ae:b887:bb33 with SMTP id
 2adb3069b0e04-5b4a9030e05mr3584195e87.1.1787806682437; Wed, 26 Aug 2026
 21:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260822190818.1829249-1-mattst88@gmail.com>
 <20260822190818.1829249-2-mattst88@gmail.com>
 <b847a616-5d7b-484c-8065-655d33c63c13@linaro.org>
In-Reply-To: <b847a616-5d7b-484c-8065-655d33c63c13@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 27 Aug 2026 00:57:47 -0400
X-Gm-Features: AcwNN1VCTgixNUcsB5a-uuiu-vpfOwiSuG2dKI7ep5sxFxyxd3RAvPUQJSyhJQo
Message-ID: <CAEdQ38HVe=uML9CMSYDkWWvXhLgYo+kJxF90MOTBM3oR7gw2ew@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] accel/tcg: fold the dynamic cflags into
 CPUState::tcg_cflags
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@oss.qualcomm.com, 
 alex.bennee@linaro.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x129.google.com
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

On Tue, Aug 25, 2026 at 5:47=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
>
> On 8/22/26 12:08, Matt Turner wrote:
> > diff --git ./accel/tcg/tcg-all.c ./accel/tcg/tcg-all.c
> > index 7186c10cf0..c9874a286a 100644
> > --- ./accel/tcg/tcg-all.c
> > +++ ./accel/tcg/tcg-all.c
> > @@ -254,6 +254,7 @@ static void tcg_set_one_insn_per_tb(Object *obj, bo=
ol value, Error **errp)
> >       s->one_insn_per_tb =3D value;
> >       /* Set the global also: this changes the behaviour */
> >       qatomic_set(&one_insn_per_tb, value);
> > +    tcg_update_all_cflags();
> >   }
> ...
> > diff --git ./util/log.c ./util/log.c
> > index 7cffbc1bf8..3fa46a67fa 100644
> > --- ./util/log.c
> > +++ ./util/log.c
> > @@ -27,6 +27,7 @@
> >   #include "qemu/thread.h"
> >   #include "qemu/lockable.h"
> >   #include "qemu/rcu.h"
> > +#include "system/tcg.h"
> >   #ifdef CONFIG_LINUX
> >   #include <sys/syscall.h>
> >   #endif
> > @@ -301,6 +302,9 @@ static bool qemu_set_log_internal(const char *filen=
ame, bool changed_name,
> >   #endif
> >       qemu_loglevel =3D log_flags;
> >
> > +    /* CPU_LOG_TB_NOCHAIN feeds into the per-CPU cflags. */
> > +    tcg_update_all_cflags();
>
> I'm not keen on these placements.  I know they're needed for HMP, but
> I'd rather have these calls in HMP, after updating state.
>
> > +void tcg_update_cflags(CPUState *cpu)
> > +{
> > +}
> > +
> Where does this get used outside of tcg itself?  I think only
> tcg_update_all_cflags() should be stubbed, and indeed the only one
> visible outside of accel/tcg/.

cpu_single_step(), in cpu-target.c, which is in both user_ss and
system_ss and always linked. So both entry points need stubbing.

> Phil, is the stub itself better placed in accel/stubs/ or accel/tcg/?
> I'm unsure what organization you're working toward.

v4 moves it to accel/stubs/tcg-stub.c, alongside the other accelerator
stubs. Verified --disable-tcg links. Easy to move again if Phil
prefers elsewhere.

