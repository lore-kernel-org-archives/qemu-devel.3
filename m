Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56439FD88F3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Ahq-0006rx-Db; Tue, 10 Mar 2026 23:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1w0Aho-0006rF-Jf
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:57:56 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1w0Ahn-0003l8-4p
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:57:56 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64ad79df972so13486448d50.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:57:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773201474; cv=none;
 d=google.com; s=arc-20240605;
 b=eyOZoyJmv3GndFDUQhTRIn34qlYUGBMRjSGEuDm2FS7zW0ukgGAI9kv2/rmL2l7aA3
 V/7qIDoODFOqPCUo0Ns98i45PG4OTJLOBn80g1wVmZbSHUaxHn5mo2CYn5pjM5xzG0x6
 +AtC7MkxFFcjIlGxg+/1XgAEvkygtkGuNA2xm1kpvbwpgOIvDtwjRX5g+MXCz1Uk+NIX
 rwBkY60edOPniEN2AV4BDYEXSEsybNuioO5LDXhECM+GVBggyn9/a+dkWdcO4yOJF8KJ
 sjTe9IstkSyR1g5VWTcrcIXhFvJaZzb83WSCGerI26ac5b65ValQrQryYU17TP5/DUPT
 RTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WfZj43aIpko65vM1bhmVEBkwI2hum/6K8POZ2+Z1rBk=;
 fh=S71a0lYwoWXq4t9FAFD7GWOVPzG9lHXJpjMbM3+d0D8=;
 b=UGaIktzZAaStuaioTMJTKqSkeNwD6WaaK+FZwrepdvZc/uc8zPAX/fKX9JaY5hqqaO
 m0xVdW0V9RWxmvLVEZ51zKB7u4sSAmyy6WPdyU3ddLAJhZtpW5pjqKdvIqtSI5l9kE35
 0NjuQzpw6KcmngxzvILh7B3yDeFAVF14j52/FYNmthKdWxW+vWxyeinpv4PZa90KUPLi
 d4depxwkT2yxaOeXtS0dyoiCUPNm5cAC7FQ7IFvzoFY0SrEsh5+giMUAOtwdbWARqon4
 /0kIjIGIg6nP0cJ1OA3yYAhnEdAmJKmQBLQ2NnKVBdi3iE+/UcxWgW0kDgXNLaZcM9Ki
 /Rjg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1773201474; x=1773806274; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WfZj43aIpko65vM1bhmVEBkwI2hum/6K8POZ2+Z1rBk=;
 b=hvF44+8Ov0lp48OfzdvjKQZ3Wl/8v3dEuoji4cSmxzYxqw2wd5A0Fxjy2JkUBAczPV
 fpQa/vGQSBBV8yUpu9mXPk50Itegji8yempBCG1yhYFQuVuOKFsmCXcaJ6YfINKAVfzB
 1stSaIpShozOpLIv6e6i3dyPxX2dil8iWU2q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773201474; x=1773806274;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WfZj43aIpko65vM1bhmVEBkwI2hum/6K8POZ2+Z1rBk=;
 b=Iq9vd5Dmj/RPOc8s2H7S466dkoA37gEFOC3RvpiD+B/EmNvmCU2/lwKJfftRbk/Uju
 POlC4IVLwUVietHxuFIDyvhWPzMH/qrmFn3eUQOezV+WA1gA9vJi9tiEYDRLh8uKOiKH
 8+uo7LxEBJZtjDAxTBdJEgATL7vsZFxNOe7RjGUH7qUpG6ansgsU2CC0RlC7UGZBH8NJ
 GK/K+PPuJECjIgqfa5zsCKE5/Tupm6LDme6PNMV84atDm1LCSxTeCjMfrJRi9o5Wz2nK
 80Wdz4x6qlt02Tl2ahGEpclWk/x2KO808SLiuTb8g8r1moqcHgNOku2u+hXfM66WvSFS
 mHAA==
X-Gm-Message-State: AOJu0YyjameWDLVBe7tQVCV1vPjJiOFNsW96g5zG/ljlCTs2ykNe7SgR
 CqVfhVWO18h04yDf5CBzUugy1TQJMX+FUjKceY4xAp4+dZJ4P1I5lZcc3KfNtja/ApM8f9QQeFQ
 x/Y1S87cJenl1BkI/OGx6m3VyyUKnz2g=
X-Gm-Gg: ATEYQzx/EU9JBD08ookCX9qixQf7nXdQtK5ogjysW8f3VlC2Fc4UAnGeStGFqIPEhvs
 qZ2V47Dn/ydaDp4QtY20aiNVOdKoebuxSrWMngxZwIqP/1eEOigYyYngy+WMEjUj2k6t9FzRXzx
 hylyQe2R39RlNfzkBQdsHBW4jxkDriCXodbG+RopB1YsVkvcIrO4tPDZdUTejIwW+Lp0lPAly+A
 gjCQoi5BpJZADJbc0gPLe/GppIt6Mh9kUR4MKtI4zzdvxppfvK6igFkF5fcLl3dkgzAK8Vv3FaC
 bEkAiLZHhP2OP80AtL/sQNRgZbmz92UK4n2wwd/itxMSj4PDDnFFkZbWazxE4PKEwSeg
X-Received: by 2002:a05:690c:34c9:b0:796:44e0:abd5 with SMTP id
 00721157ae682-79917f05efamr10400417b3.27.1773201473969; Tue, 10 Mar 2026
 20:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260109123211.368869-1-joel@jms.id.au>
 <CAFEAcA9JW+1f+mRKXtFoFwGUKzBM0mypjMFc5ToukRyKqCWy0Q@mail.gmail.com>
In-Reply-To: <CAFEAcA9JW+1f+mRKXtFoFwGUKzBM0mypjMFc5ToukRyKqCWy0Q@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 11 Mar 2026 14:27:42 +1030
X-Gm-Features: AaiRm52w1HJxviiMXqBgcIj2dUWFKdTJklLulTJTqXIS5vRuOEpz5NOTpBoT-HE
Message-ID: <CACPK8XdK-+PYsek3JFx3cn6J1DjOaDGWJod_j4Mj__Uut7xyLw@mail.gmail.com>
Subject: Re: [PATCH] hw/i2c: Add designware i2c controller
To: Peter Maydell <peter.maydell@linaro.org>, alanosong@163.com
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Chris Rauer <crauer@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=joel.stan@gmail.com; helo=mail-yx1-xb12f.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hello Alano and Peter,

On Fri, 16 Jan 2026 at 03:17, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 9 Jan 2026 at 12:33, Joel Stanley <joel@jms.id.au> wrote:
> >
> > From: Chris Rauer <crauer@google.com>
> >
> > Reviewed-by: Hao Wu <wuhaotsh@google.com>
> > Signed-off-by: Chris Rauer <crauer@google.com>
> > Link: https://lore.kernel.org/qemu-devel/20220110214755.810343-2-venture@google.com
> > [jms: rebase and minor build fixes for class_init and reset callback]
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> > This is a re-submission of the model with Chris' permission, with a
> > light touch of updates to make it build with qemu master.
> >
> > It will be used by the Tenstorrent Atlantis machine, which will include
> > a functional test for i2c devices attached to the controller.
> >
> > Daniel suggested that Alistair would take it through the riscv tree as
> > a (soft) pre-req for the Atlantis machine.
>
> Hi -- what relation does this model have to the
> patch posted by Alano Song a few days earlier?
>  https://lore.kernel.org/qemu-devel/20260106131253.16192-1-AlanoSong@163.com/
> Are these independent re-implementations? Do we
> have any particular reason to prefer one over the other?

A race condition I think. I grabbed the patch from the list a few
months back, but didn't post my series until January. It seems Alano
posted this in the meantime.

Alano, is there anything missing from this version that your model
supports? Are you okay with using this version?

Cheers,

Joel

