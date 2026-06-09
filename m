Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B3ACD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 20:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX3Bh-0002YL-S2; Tue, 09 Jun 2026 16:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wX3BZ-0002SQ-0w
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 16:36:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wX3BX-0003AY-6h
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 16:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781037387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FlKJKCDdHgAj/yGhb4/RBHIw/K9PTRjbwSEY0XVYxIQ=;
 b=YaftiHVv+halOmHWKMSsjtjMbGzgmPQO7i7XAnHVEpvLuncDiYijedzGVJKb/bi63NsazX
 gJ8rDk7HJmB0WvTXLuf7gCtp5H1WRlsqIQvbll0N6if5aK4esVSPb4ewQCebuHwtEPgesw
 osAFW+6Q5520CLQJG54sQ7j8n8AFgqw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-weU6tdXlPrKxFw7ShZjsmg-1; Tue, 09 Jun 2026 16:36:26 -0400
X-MC-Unique: weU6tdXlPrKxFw7ShZjsmg-1
X-Mimecast-MFC-AGG-ID: weU6tdXlPrKxFw7ShZjsmg_1781037385
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b37e1ebfso29057735e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 13:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781037385; x=1781642185; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FlKJKCDdHgAj/yGhb4/RBHIw/K9PTRjbwSEY0XVYxIQ=;
 b=StmApI90zCF2zgl3qXqvKRuZaf9TVCuJ9eotLepfCN4u2yhDAwVMX/1i+BusTU0wsf
 KWWwUcQdxOVsR5e6IgY20zIMaQoXTrjpyAAewcJbOs2z+a2uEfZ0r3Gh1IPhTaNNwGS+
 TONj2m4SLjVMpAotIj8Xq4X0FuLK7ICSPCMSAMksikRgDgAPwgx3KpNL9j7Uhg7EKMk1
 +F4XjcH5Dsm5CwxLecwtpSLxOSxFizDUPBccjVU9hRBYiCCXyBHbMpDr0HVwuAgS1MWG
 EUw59J8P5xxRqgAoh5ulC1SXTfC6/EnPGUICiUtSodnqTuKnGb0OpCia59UoTSP5zl1U
 Or+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781037385; x=1781642185;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FlKJKCDdHgAj/yGhb4/RBHIw/K9PTRjbwSEY0XVYxIQ=;
 b=JuujT59FuFobZ6qNJX04ilAZQBUyuxcIOfCq+9D1tZfoPU6dcgsB/aMYKVVTx2vOQC
 /at6UNeTaRrnhtjevE5ch999nU96IQJXg7p7UrOkHEYgkskjnkknDm5ftFBXo9Up8J52
 vLrWAMNheXPQDCAJaIX+VZlQmuHbuijxB+caeH3Aq1p9hF7Qn5JGUp7CkCuI5lfZwOFj
 ZuqAybuJlMWNyF37LqxzAzOONCPGEZhbJy5isObQEObay4R4lb7xBg00hRhnBDvAvHu9
 T4JliJ8ERh0NjZdG/n4A5xnomDBge9G1AhJuLNASHN1umM/ihtAKXyImfexHJsEbbqiu
 nWBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YZmTdlVNDM1abmUWa7ElANUbUeAR4kH0LsL8BZpt9a9WoZNuv7W+ji/hdhxamJCkIHC3VHcUZOXRJ@nongnu.org
X-Gm-Message-State: AOJu0Yy5D/qOJ2vOt/LlyZy8hEtqm8e9qaQR0fl6uNs4vYIsTVTKis8W
 oXpNwoayvHyaPuaPpN3KVsDWMQitn5ly75At4BXUkURMHoEmm5OrZVc6HQqP5rTpFK8JyXAMKBl
 zkciPMC03SbruW6pHCSVKhxcrFN325Lzz1OaY9upatkybdsiFuv/HRmjD
X-Gm-Gg: Acq92OEW/jZQ7SsQC046FqVp5H0DaQlKWNfJAB9Ez4J/ZpMtTXUBq4trV8/lpOvL4FL
 VuyDhmPRhVsgeCc2MqR44gVoe/siJ/wz0LYdm+PXVfKJCFfsfnZvFiYUYzOhMtDlJDq/hzkryFs
 5KJXa9ejVWA+sJqQCX6V/h97RmadH0udur8tkNTlqBiBkt07fWgr0wt3Tt+EKVSbUrqZI06FQ1n
 jtkCoWNIFsL8iDKk9/aHUyuDI6A5AbQ2/EvW1o8ChYLFuU3NokAxRjrSm7PJrcgUdavg/e8dTcb
 DujqS963zy6KFZ4auXTREYgnrJeNwOg7HqpPQn7/XZLEFhNNa9NOHbFT5ECOciFw0bs5hovf3Wn
 H5IJmY/ECbUCQNSfJEi7OI4I2c+1nea+7KKuqjAjp5WvB3MKiap6SXw==
X-Received: by 2002:a05:600c:35ca:b0:490:bc46:1a58 with SMTP id
 5b1f17b1804b1-490c25dea14mr381979115e9.18.1781037384881; 
 Tue, 09 Jun 2026 13:36:24 -0700 (PDT)
X-Received: by 2002:a05:600c:35ca:b0:490:bc46:1a58 with SMTP id
 5b1f17b1804b1-490c25dea14mr381978665e9.18.1781037384360; 
 Tue, 09 Jun 2026 13:36:24 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f2710sm51175338f8f.14.2026.06.09.13.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 13:36:23 -0700 (PDT)
Date: Tue, 9 Jun 2026 16:36:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dorinda Bassey <dbassey@redhat.com>, Albert Esteve <aesteve@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev,
 dev@lists.cloudhypervisor.org, rust-vmm@lists.opendev.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Demi Marie Obenour <demi@invisiblethingslab.com>,
 Alyssa Ross <hi@alyssa.is>, Mark Burton <MBURTON@qti.qualcomm.com>,
 Matti Moell <matti@qti.qualcomm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Sergio Lopez <slp@redhat.com>,
 Vishwanath Seshagiri <vishs@meta.com>, Rob Bradford <rbradford@meta.com>,
 Zhengyu Zhao <zhaozhengyu@bytedance.com>,
 "Jorge E. Moreira" <jemoreira@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Where should the vhost-user specification live?
Message-ID: <20260609163536-mutt-send-email-mst@kernel.org>
References: <20260601090953-mutt-send-email-mst@kernel.org>
 <CAJSP0QV4W=5MJsSGggACv-tqxDtiieKc0YzEn8t-R=RD94KJaQ@mail.gmail.com>
 <CADSE00+ziHc8W2FqNT-aJU0Lt4sZ=NfQLc65m16vpT++pZM+xQ@mail.gmail.com>
 <20260601151815.GC411459@fedora>
 <20260601160352-mutt-send-email-mst@kernel.org>
 <CACzuRyxedVMHNGkRf7AVyPWUTMgBMa6_DBnSHn+V6H7wN7XzWw@mail.gmail.com>
 <20260604162853.GC115597@fedora>
 <CAJSP0QXR6MyqoE1Uh-X7DzsOabbbN69TUyxf8r6ghUDCQnrP=w@mail.gmail.com>
 <CAFEAcA_Kd5_k+XyagUbB2+YVEMB0Sb0AB=oUZu6bGDot9TaFrQ@mail.gmail.com>
 <CAJSP0QVuSvVwa1szAy_3WVtWOjGK=oYAXjqAzbg5YoEvgybRjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QVuSvVwa1szAy_3WVtWOjGK=oYAXjqAzbg5YoEvgybRjA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jun 09, 2026 at 03:44:49PM -0400, Stefan Hajnoczi wrote:
> On Tue, Jun 9, 2026 at 2:51 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Tue, 9 Jun 2026 at 19:00, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > > I'm not sure if anyone brought up this topic on qemu-devel and with
> > > Michael before. As I mentioned in my reply, there are ways to avoid
> > > blocking vhost-user spec changes when qemu.git is frozen:
> > >
> > > The simplest approach is to keep merging vhost-user.rst changes during
> > > freeze since it does not jeopardize the release or introduce
> > > instability.
> >
> > I'm not enthusiastic about having "this one document is an
> > exception to our freeze and release process". Because it is
> > only documentation, it is in the same "we can be relatively
> > relaxed about allowing in documentation changes" boat as
> > most of the rest of the docs. But docs changes can break the
> > build (e.g. if you mess up a rST syntax thing), so as we
> 
> CI prevents broken rST from being merged (there are multiple jobs with
> `--enable-docs`), so I'm not sure this can happen?
> 
> > get closer to the final release we are going to get more
> > strict about "is this change really necessary or can it
> > wait a few weeks?", and they must at a minimum continue to obey
> > the "no changes of any kind between the last RC and the final
> > release" rule.
> 
> Why is the final release candidate special?
> 
> > And definitely if a patchseries has both
> > QEMU code changes and documentation updates then that is
> > going to not get applied during freeze if the code changes
> > don't follow the freeze rules.
> 
> I agree that code changes cannot be merged.
> 
> As long as the vhost-user maintainer is confident that the spec change
> is implementable and stable, they can merge the spec change on its own
> without code changes. If they are not confident, then the spec change
> isn't ready to be merged yet.
> 
> Stefan

I personally have been confidently wrong enough times. Maybe others know
how to do better.

-- 
MST


