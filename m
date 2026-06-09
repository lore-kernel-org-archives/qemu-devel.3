Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A17FCD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 18:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX1XZ-0003jX-8i; Tue, 09 Jun 2026 14:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wX1XX-0003jE-La
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 14:51:07 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wX1XV-000564-WC
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 14:51:07 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-68c3421b009so9868420a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 11:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781031064; cv=none;
 d=google.com; s=arc-20240605;
 b=KQtrj08pGoK4GQM73qIrp8Y9j9O1xhvigsp8niVXq+IqNCNCM79GPffFXHH1oY8okq
 GwANvuTUhnGJ5ScOlPz6GpOQpi41azxJ9UoooD0EnoPIP6X87p67Z3cz766efBPbcuMR
 i2rzqONHj1xxYxfSiKHKLbs3VrAMbbz7g7ZDZAmono1aFu3qTs1zv2XAI9wOxGRQ2G75
 ZCHNt5H8EIpEs3DmNOFN/uipIYyNZosCoM1xi5+mfk6CjyKGI6XmE2RkWEoa3AwKAVFh
 IjKql3fY9XHIGQFt77mRcsek73W56oFmZE3z/KWXyzXkHwk+df+ZLLVsJUPBkc4Uj6Kz
 O0AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0GRwCW4VTvxL6H7r8+dUHJzh8tKbj1LjZha0xXEEmmE=;
 fh=VnsTS3LT9PzDgUOG97Vk548DoA0Lnec22qsR74lex+4=;
 b=aeHkAnbaPjq4QdPIC2xmKexp8PxWBekAePdoG4uXIIqyQTlT1Bi97y/uMhWKq4cqyr
 rGG0EyJcxuMmxMdb8xZqfhbAwpXTH1XlEfVvDFZySGLwqgS+fUXe5TEowY53gvUFBB41
 eN6pmWdRSEPOsSpfkQnF8lVTZZxnps62FVh4qkaT3xoSQa8/3w8JZvB5U/nO+bLyS/kt
 9yaDYKQMXf34fgm9mTAisMc2vZ+1VEq2XFMOl8Es1EuzN7JWkAqUlG2s3j0WZu/HGm+g
 kM70R1apkVsFQx3WJiRk3nufxQyp9LWQCKVO/PChBlZS80Ww3exMQkPXx9MNPdDdmqkN
 3yGA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781031064; x=1781635864; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0GRwCW4VTvxL6H7r8+dUHJzh8tKbj1LjZha0xXEEmmE=;
 b=pYXaXrP53f14sq3GriGkUGjne96wn3yqkAHJMcJIhBnorOx48uaseBH5xeDjFUtlaS
 BgJLExpMZVUJrQcZAw04/8mpXQAA+xldZb9b+kU2RYBIkysKzmT/5Nit8pJmQl3/kUBd
 I+RzU2rqK9+JYXSIismnIVYhe49ke6TicXs9QJSW0fN2ErucPs0wpZzUceSOmmeJI99c
 zMU0qfvzM1nS5kjMJjtJKiDC9TzZeMd1lCkGnKlBoXV0imbQFujSkc6qtzSIP04OrYuw
 FCUFf1EFWZPTU3NuXxyaeywVvYvjokI0o0SzpqilFXUhCTntMSuUaT/0cIrSWxDvtZJW
 Pi/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781031064; x=1781635864;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0GRwCW4VTvxL6H7r8+dUHJzh8tKbj1LjZha0xXEEmmE=;
 b=V9e3n7LeOEMR4ENAt3ZdD2O+kXENTsFOUCPuozFks6i2BPrUQgS5hmCQewp/XJuFLo
 z2H2VxdqFdR2HJnBKqaVI8hpM2eSwCdByU7nnzIdwwONEpYf4XYD8Io+/TmVZW5MynAa
 341PbDPpb4VuvY8YnN3DVLK3ot5Pt/WYyGyVNSjWeC4o1bg0nvSVNjzMznmwpx26h2gG
 ydUTZYYMF4gJpCGRi3VKwYoZ4ajXTjydYwqNCP4aqkQUslGMAVZRzmz9orp34lePTut5
 qYUC9Jz6f8Pc3b4QoADtTctZfJghYoHd7+uIfGnxiL50ZNiXYH3TZMNPV2beAJVgBjHN
 X1bg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3Oeh28lAx3Hgt+sOGl7Lz2gVc4C3AXyWXyKV52ptvJypum8OBd6YeqO9PK6CsVngx+n7wKUeTHwfs@nongnu.org
X-Gm-Message-State: AOJu0YwRUA4AP3JI/nEyVo16R+7Ybqvv1BWE8LATIf7XMTNrnZkOhbZE
 8WaJjkaZFRj5pqE2WTzaKl+mPicYQJu7q4OSw8FyAqxeaXFNo+etsbv15lGEOHkXgzBmgCrr7iw
 D6M6j6H4yF4x70XcPzI0Y1udWkwFFWDptdBT7yjlwDWBrMnwii1dp
X-Gm-Gg: Acq92OH0wP+f1L+9JyYLUEamKmHxxqJ6PVMofvasAGGpl7MVBIEw5WFiZwXVfOG8TTN
 A3BziuNYyUayujjx624VYd6RvcDL68hw8LcxACL41/8B1OUVOlPUUzkshvcfv7Jfg/wsFfejdGi
 RDVH8vu1nHJ10op7ZMiTzGDBaGrEBU07J/N1WxeVj5OQWj6DXH2+5/dXLbSdtBuEKKd6P+GjKMT
 1CylZOThCRkW0UzjCj87P+pEjrxGRhEPFtt55kL3cJNrH6AZ+5wUZOmLW36KMt3F1nOmFd3pRbb
 t5x7L/cFgBBRb/vgFVCcyUvfNi+vAdO8WFk0d4VhXzFo4uqnnq/Yuy39cpRBsr29L8tFtHaHBgb
 c9g==
X-Received: by 2002:a17:907:60d1:b0:bd8:fc89:cda0 with SMTP id
 a640c23a62f3a-bf3a8a0cdbamr869373966b.24.1781031063613; Tue, 09 Jun 2026
 11:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <874ijtz038.fsf@draig.linaro.org>
 <CADSE00+RdBUhFVBDSXtVd1J5SaccqWy+RBxqnxuLKUYcitFMPw@mail.gmail.com>
 <20260601083628-mutt-send-email-mst@kernel.org>
 <CADSE00+kRnEC08LLVu6H065u2KaxBm-KnSN_8y6+964-FLbJMA@mail.gmail.com>
 <20260601090953-mutt-send-email-mst@kernel.org>
 <CAJSP0QV4W=5MJsSGggACv-tqxDtiieKc0YzEn8t-R=RD94KJaQ@mail.gmail.com>
 <CADSE00+ziHc8W2FqNT-aJU0Lt4sZ=NfQLc65m16vpT++pZM+xQ@mail.gmail.com>
 <20260601151815.GC411459@fedora>
 <20260601160352-mutt-send-email-mst@kernel.org>
 <CACzuRyxedVMHNGkRf7AVyPWUTMgBMa6_DBnSHn+V6H7wN7XzWw@mail.gmail.com>
 <20260604162853.GC115597@fedora>
 <CAJSP0QXR6MyqoE1Uh-X7DzsOabbbN69TUyxf8r6ghUDCQnrP=w@mail.gmail.com>
In-Reply-To: <CAJSP0QXR6MyqoE1Uh-X7DzsOabbbN69TUyxf8r6ghUDCQnrP=w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 19:50:50 +0100
X-Gm-Features: AVVi8CfQj_nH0lFQpKFY0AcZc7EddA4az3DfVHrY1pYqnmsUTdc_WL6_mHIxyNw
Message-ID: <CAFEAcA_Kd5_k+XyagUbB2+YVEMB0Sb0AB=oUZu6bGDot9TaFrQ@mail.gmail.com>
Subject: Re: Where should the vhost-user specification live?
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Dorinda Bassey <dbassey@redhat.com>,
 Albert Esteve <aesteve@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev, 
 dev@lists.cloudhypervisor.org, rust-vmm@lists.opendev.org, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Demi Marie Obenour <demi@invisiblethingslab.com>, Alyssa Ross <hi@alyssa.is>, 
 Mark Burton <MBURTON@qti.qualcomm.com>, Matti Moell <matti@qti.qualcomm.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Sergio Lopez <slp@redhat.com>, 
 Vishwanath Seshagiri <vishs@meta.com>, Rob Bradford <rbradford@meta.com>, 
 Zhengyu Zhao <zhaozhengyu@bytedance.com>,
 "Jorge E. Moreira" <jemoreira@google.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Tue, 9 Jun 2026 at 19:00, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> I'm not sure if anyone brought up this topic on qemu-devel and with
> Michael before. As I mentioned in my reply, there are ways to avoid
> blocking vhost-user spec changes when qemu.git is frozen:
>
> The simplest approach is to keep merging vhost-user.rst changes during
> freeze since it does not jeopardize the release or introduce
> instability.

I'm not enthusiastic about having "this one document is an
exception to our freeze and release process". Because it is
only documentation, it is in the same "we can be relatively
relaxed about allowing in documentation changes" boat as
most of the rest of the docs. But docs changes can break the
build (e.g. if you mess up a rST syntax thing), so as we
get closer to the final release we are going to get more
strict about "is this change really necessary or can it
wait a few weeks?", and they must at a minimum continue to obey
the "no changes of any kind between the last RC and the final
release" rule. And definitely if a patchseries has both
QEMU code changes and documentation updates then that is
going to not get applied during freeze if the code changes
don't follow the freeze rules.

"There are going to be three well-advertised periods every year
of about three weeks in length when you can't get an update into
the spec document" doesn't seem particularly unworkable to me.
But if following QEMU's release process is too awkward for this
document, then I think the right thing is to make it an
independent document, like the virtio spec.

thanks
-- PMM

