Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC7EC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 14:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWzDw-0004rp-RJ; Thu, 25 Jul 2024 10:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWzDs-0004pw-8x
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 10:13:37 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWzDq-0006fw-Kf
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 10:13:36 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-369cb9f086aso608746f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 07:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721916813; x=1722521613; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MhaQHPxEUXRm9BJ+jDoFhbXwUq/0jmn/JQd/gOROiGQ=;
 b=AizZqBw8dp279hmv/2/Txmah/Nc86VqVC9GHaYzi4EwykEMcU1Py6e4UtsjKDFlv4t
 Nurwh7JAXV47js330KvKVhSjrjk/t1sn/ub9uWmULBN9kUTJyDLQIICqvFjfnR8/2Xpj
 gdLdR1upl9H139dbaANFBp99YqpXLTZRwnxONdw215RfF4J6yU72LRm0xEnlxAuoO/h+
 f3wm3WqRGJoIpiz+jaiD1sFbvbw58ZMSvziX0ZF24HlOezO1ET130pPpAFp6ixBJFWnA
 CxL4RnkXTCqO9uoGvVTMlVwnI6+st8iybQgXEQBbEVgoCfcEROoBu1rXgvnm6sServ4H
 SR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721916813; x=1722521613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MhaQHPxEUXRm9BJ+jDoFhbXwUq/0jmn/JQd/gOROiGQ=;
 b=F7xSRSpAH26EgQhlebH702i7DKH4/jhax5tM/QaGMksjRVTSMjcQvZ8KO5wso4iG17
 ZyRohmwf1gwB5oUb0NKEcm0VzagleJtD3GowBzTWjCl+ZlBpyGdcmtsAC5jz0peGc75R
 pQLQmVUvO84J8bxEmnMF63PbpADqclGpnDaohXVBFk84rdZVdSKpldN4yHrwMww8LCFS
 NxgRo/fscZWP0f9JpOIvG0t3gWiDlYFdnk479N5ock93OG5F1WtvwC5uc8kWSBT5rN0v
 mw3LmCyJwiJSddbyCVgu4cF6ANrlAFivd+r9MptHCpAg/kQqBKU/vIU0miZH8XnaMDDa
 y5zw==
X-Gm-Message-State: AOJu0Ywc/kxyDZF5S3kaSXayt9slbLCuu2xJvL4omk6AzOl1oHtUZFSq
 aCpziD9wa71XBPP1jW+DyHqzvaPvFmnAREk/N5Qtvwd7NNixB2ArKCkcohJ2hOEiHXyA1sHADV2
 A3FvMHH0iSLhaC9eNnJo4pQXauGi7MawJWXzRDQ==
X-Google-Smtp-Source: AGHT+IF7i/uLXoNhU7qpEJZPkP7GqGq17PejVmREnBNIR3RE2g92VaP7NyEzzPe00U3DRNleTY+ow9tjbf6jZ6P0ia8=
X-Received: by 2002:a05:6000:12cf:b0:367:9088:fecc with SMTP id
 ffacd0b85a97d-36b31ac9b9dmr1984076f8f.7.1721916812656; Thu, 25 Jul 2024
 07:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230302123029.153265-1-pbonzini@redhat.com>
 <20230302123029.153265-58-pbonzini@redhat.com>
 <CAFEAcA92Rd7f3Ngn8_nYZCxJptAD2DcP+oHCiXii6vTHMCUamQ@mail.gmail.com>
In-Reply-To: <CAFEAcA92Rd7f3Ngn8_nYZCxJptAD2DcP+oHCiXii6vTHMCUamQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jul 2024 15:12:51 +0100
Message-ID: <CAFEAcA9g=eQo7kO+Z76+zHH8Vo+=bh_yRej1-N+-0iCnsuSr_A@mail.gmail.com>
Subject: Re: [PULL 57/62] hw/xen: Support MSI mapping to PIRQ
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw@amazon.co.uk>,
 Paul Durrant <paul@xen.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 19 Dec 2023 at 13:36, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 2 Mar 2023 at 12:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > From: David Woodhouse <dwmw@amazon.co.uk>
> >
> > The way that Xen handles MSI PIRQs is kind of awful.
> >
> > There is a special MSI message which targets a PIRQ. The vector in the
> > low bits of data must be zero. The low 8 bits of the PIRQ# are in the
> > destination ID field, the extended destination ID field is unused, and
> > instead the high bits of the PIRQ# are in the high 32 bits of the address.
>
> Hi; Coverity thinks this change introduced a locking error
> (CID 1527403):
>
>
> > @@ -1226,21 +1256,54 @@ int xen_evtchn_bind_pirq_op(struct evtchn_bind_pirq *pirq)
> >          return -EINVAL;
> >      }
> >
> > -    QEMU_LOCK_GUARD(&s->port_lock);
> > +    QEMU_IOTHREAD_LOCK_GUARD();
>
> We used to take the port_lock before looking at s->pirq[pirq->pirq].port,
> but now we don't...
>
> >      if (s->pirq[pirq->pirq].port) {
> >          return -EBUSY;
> >      }
> >
> > +    qemu_mutex_lock(&s->port_lock);
>
> ...until down here after that "exit if already allocated" check.
> So Coverity thinks that two threads might both get into
> the "take the lock, allocate a port, set the port field in the
> struct" codepath simultaneously.
>
> > +
> >      ret = allocate_port(s, 0, EVTCHNSTAT_pirq, pirq->pirq,
> >                          &pirq->port);
> >      if (ret) {
> > +        qemu_mutex_unlock(&s->port_lock);
> >          return ret;
> >      }
> >
> >      s->pirq[pirq->pirq].port = pirq->port;
> >      trace_kvm_xen_bind_pirq(pirq->pirq, pirq->port);
> >
> > +    qemu_mutex_unlock(&s->port_lock);
> > +
>
> I think in practice the iothread-lock guard will prevent this,
> but it does look rather odd. Is there a reason not to have
> the port lock for the whole stretch of "check whether we've
> already allocated this, and if not then allocate it" code ?

Ping? This is still in Coverity's list of untriaged issues.
I'm inclined to say we should take the port_lock before the
EBUSY check. Using the WITH_QEMU_LOCK_GUARD(&s->port_lock) {...}
would make this straightforward and avoid having to do
explicit unlock in the early-return codepath (both here and
in the allocate_port() failed codepath).

thanks
-- PMM

