Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F04FCDE002
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 22:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcWP9-0001QX-7q; Wed, 24 Jun 2026 18:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcWP8-0001Pc-6t
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 18:49:10 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcWP6-00073E-OS
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 18:49:09 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c0868ca8738so265342166b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 15:49:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782341347; cv=none;
 d=google.com; s=arc-20240605;
 b=jH8ZDwCamRF8V3Pkm3RQ1T7vFhaDrBe9n8P61QcH68aCet3yOLA8WyU+L1P8GXzBlE
 r7PgteaLYandNZM5a63z9febDDUNz1fvtHDOW0X1RD0KvwHGQT/S/6pslwqGeu63FI+H
 e3jgH/+r2J62iGpw3kmeBOrA8s8dlDf/mn6HGfIBDik8C5u/bP4XroogJyRjQPmv6vo+
 LVW19FMl6p+necvp7fH6ZV3DP/4duy/6v8vlbnoz7dFxhUpM2yU9u7FVjE2Nx9EM4hT5
 taqzvgrgo+YllZl+5mwvLdPQmXb99SYIzQRpCNHRE5q5i0dimBNqZwyDhJovBTsyrrMO
 Cxlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ExDSGjqgbfHxBtaFFK7Otwja6OanufXG0dVYkSjoL38=;
 fh=dEcCJoizW0PIXIsgsrNAtfPedPj0hmKZvH/dXrAI1HE=;
 b=SBSMm8oOKMk/7gevaDff1ZdcGwpuHZFwg5Y1Mt6NaNJWv8k1YkvZyOI9UdX3umbhCU
 nFFV9lOp29Th9s5fdLWeItD9rlJ7vBrH/aZGBvB526dI2mfPXcb5nd2YHd5xdVy7mrhg
 eDn1RBolRNeyGaG5YOu6PqP7DWwfnopFy4vBBKjYPOD62okPGRZOg1FWXrFKwr5M+HSt
 bwCx7MeMDVm65I/1ArJFOFW/HmAFAzhHAlBDNbCmSIDqoolntmz6WN0190RGYf84weRz
 ftW3v5jh4ITj1vJOinwWMR6tQJ1KVcULMYRRTzU1gBNUhxvCb+o7nTgXa/tfakLgxbDH
 9JnQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782341347; x=1782946147; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ExDSGjqgbfHxBtaFFK7Otwja6OanufXG0dVYkSjoL38=;
 b=s+TOti60XtrE7fllGSQ4mU8LxT/zTMG4OLEJcWCaboYsjAm+Bxd+COl3aM/u/dsZ16
 lOSKkFE/DXnaigiy0j5sZjN45Nv8epNSJCFAzgrziQxPlofRmAwM5442+3HiTRonp1IW
 DXMvIcJS0w0asR57w2l5MSjZ1uab1Lu4qW20790mW0rUJjPBrVU7ZBBalC7/fDnN9Etj
 UYpNKlJMPtQhzByFyc2fP501EysCw3rsH6vrSfDVSVOu25/rjq5kBBfcejFH3XbwGDmR
 Voz0ly/bkIsS3ejGf9CRettuXyVb7FIoXOOLGYJZk7GMZ0rjG/aYrbhE6eKcXWiR+h/E
 CVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782341347; x=1782946147;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ExDSGjqgbfHxBtaFFK7Otwja6OanufXG0dVYkSjoL38=;
 b=UQaHWoHizdaX0PlqC1U39TgIvXON72KzHy65RxxC/93xjZi/m9y/4eUKZ8fovNcqeM
 qDVdGNcf+rVojvZYit9YFVZXuI0bhHP99DCq49HoPPV+cOkdG7g9DWq+mN/K41qZisym
 SH01CjIZMXj1LhQpnjeYWZoWa+PLlWqihzxSiwtE44NCzlxPT3aQuMCXNG/jfClPwUYe
 Ju8cpvVSNluOnlYzhszSylvCRnKllmKYxv1d8Xcd1FXZavUYwgY5PUQU2wBdVxwh2xFK
 JKlN2dlCnceebabgTi3WerUge8f5CxZHCsjO/uPCkypejoC5WhOJyNOnTx6FlxG/ZK24
 ggbg==
X-Gm-Message-State: AOJu0Yxs/6HDqRgyNwgn7Z2QrtunGwQ2R1kmEO74IkQI2T9y9arIH7dt
 CZs2me+hIt15s1MQ5CcndTNPUhEooPO5K2LtWCBhaUoqliC1OEZlqIzpkeOkDFRHXQ1TAEzS2Is
 cigfdR1oaPs4D2eiiZwBqCssHy50+ReU=
X-Gm-Gg: AfdE7cnPWcAv24bwOTPXIuteP4m14Nr1D2OyaYuyP5v9+1HjdEO8WJvNv/FnK9vkJiA
 yUP9TIrG8c203puYTORBd7dsvGQFB1R5YBuxA+8ATfoqqTAX7tzY41bJDGxt5F3LKq68/78W2Uc
 aOIH3+V6zWv1cbCmdHZ9ruboWILxwHz3pSY5vMWMwm/7C34S8X/SCkFi+mzk78ZS1E3FNk+n6nt
 JmaWj14uFGiWbMFeAOzxnK8JNNaJRQBalmk64VOuLlaKs5jwZyCizToYbgL9rSUrbqPREQj
X-Received: by 2002:a17:907:3e13:b0:bef:12f:346b with SMTP id
 a640c23a62f3a-c119d75f9demr289865866b.15.1782341346647; Wed, 24 Jun 2026
 15:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260624070851.13342-1-zhangckid@gmail.com>
 <20260624070851.13342-4-zhangckid@gmail.com>
 <20260624171008.GB109308@fedora>
In-Reply-To: <20260624171008.GB109308@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 25 Jun 2026 06:48:30 +0800
X-Gm-Features: AVVi8CfldkSX3_R57o_ZWUZT0a7PDxNwLW4WfBTYIM2a6UgBtBpF8mcLr9yRStM
Message-ID: <CAK3tnvJ3bHVBrBqgDwRE0nZoV9J8LLqScUh5M-Jmbu9nC6Rmtw@mail.gmail.com>
Subject: Re: [PATCH V9 03/17] iothread: tracking iothread users with holder
 name
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62a.google.com
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

On Thu, Jun 25, 2026 at 2:33=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Wed, Jun 24, 2026 at 03:08:37PM +0800, Zhang Chen wrote:
> > @@ -70,6 +71,9 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
> >  char *iothread_get_id(IOThread *iothread);
> >  IOThread *iothread_by_id(const char *id);
> >  AioContext *iothread_get_aio_context(IOThread *iothread);
> > +AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
> > +                                             const IOThreadHolder *hol=
der);
> > +void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder=
 *holder);
>
> There should be doc comments for these new APIs. One constraint that
> should be documented is that these APIs are not thread-safe and must be
> called under the Big QEMU Lock (BQL) (this is necessary both to avoid
> holders list race conditions and because object_unref() can invoke
> finalize callbacks that expect to run under the BQL).

OK, I will add comments like this in next version:
 + /*
 +  * The iothread_get_aio_context() and iothread_put_aio_context() are not
 +  * thread-safe and must be called under the Big QEMU Lock (BQL).
 +  */

Thanks
Chen

