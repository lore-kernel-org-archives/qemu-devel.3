Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91040C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNL7-0007Qm-Rt; Thu, 18 Jul 2024 05:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUNL5-0007J9-Sb
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:22:15 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUNL4-0000AT-2x
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:22:15 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5a10bb7bcd0so704465a12.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 02:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721294532; x=1721899332; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lRw+8fZjUhePZr8Xo0VuYMGhUhJQp4YNgo+0DPUrJtw=;
 b=NRzAQ84G21udCeU4yw2n/w2/gZrffr25HhFBr9vpwL+2SpKiCTINmi4AmVimHB+pAn
 zYL0O4gZNBl+ib0XdlN0qdikPBQYqq2JvxZ6TSkXBQZyfoYo/kSydbuMKFGsEt96fmXv
 BBIwNsZi60zq0l8l5hsNRwAyCU5pWni/1I51LRwmJAr1OEIhUOb15fwnQok0elcHTs7B
 47rf8MWPctWSRLLTEtyyxjC44aoasM+/KjliXdja7PojRYNoL1MFlUyd/KLwB2yIcr4R
 Wk5Fi7NS4e8sEm+jQGlg7jymFtKrWCy9YykLbmZmUHbWs0TQGr5dRi4eBxMGDpufSDIc
 20xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721294532; x=1721899332;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lRw+8fZjUhePZr8Xo0VuYMGhUhJQp4YNgo+0DPUrJtw=;
 b=nczwEQMbQgu3mIdpjlQ37H2hE2umRakUNia57XmNZeHrehlkA62MF4pHpGuYoDcEuf
 h2pWcTumoE/FI3pae5FcE37uq4T7QP6qTBqe62HHpXhf9Uxg7Tn9R1eGB82YApe8ohId
 1K5vpBn/w3VWvU4mm8J9Qg+/VU5boQ2TLh+ZkVWnbvaxKdeLch6qOPznKLjsqRVrD8h6
 bZrIpdTLhllAMaJAPaWPckmTxDvsgl3tF0T3Yf0nSnsqI6eK4fHd2E9kQ6oR2cR1T/eu
 mqbR4enthr4G35ehyJ9S3qEWKS29F/xDhHRcRo4rhjdSlDqYbmF/mbrGVvaxDuRTK+kd
 JJkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWneyevIaQ2BaFzxYVLbpsaNwhPuADUv+gXW8Gc3gnt8h+KP7+tKo2Mu6+U0tYJCeVET9eel/U2KDUeKv0GPnYsWJ38hO4=
X-Gm-Message-State: AOJu0YzARN7kpCpIQjg/ygNU055UkPppKwn3WaMq5QajRlYUyRSJGIP/
 HluXVE2qfy7dpcdireYKDblC5EwIeYz5mBhTM4qxqAudK91HaARSw+knCEFfcNaJ4oEenEJMnL6
 4yaUv5VtqshEJEzTsU78wPSPKOfnDyg1RD/f0NA==
X-Google-Smtp-Source: AGHT+IFVNptriV/DS/52KkWH9NygV8av02pT/K37slAK2sIRAKuNSWf7tZFGdI+0FElCK0Sl0AGGlnlBIE0a143Lv+s=
X-Received: by 2002:a05:6402:40c4:b0:5a1:c43:82bd with SMTP id
 4fb4d7f45d1cf-5a10c4386b3mr2303157a12.19.1721294532167; Thu, 18 Jul 2024
 02:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240605185050.1678102-1-tavip@google.com>
 <87r0br8bve.fsf@pond.sub.org>
In-Reply-To: <87r0br8bve.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jul 2024 10:22:01 +0100
Message-ID: <CAFEAcA8nFz_4M3s4NoWpfhJZ=pxRc92shSKfoL6iN=_Oqmc-tw@mail.gmail.com>
Subject: Re: [PATCH v3] chardev: add path option for pty backend
To: Markus Armbruster <armbru@redhat.com>
Cc: Octavian Purdila <tavip@google.com>, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, 
 eblake@redhat.com, berrange@redhat.com, Paulo Neves <ptsneves@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Thu, 18 Jul 2024 at 07:15, Markus Armbruster <armbru@redhat.com> wrote:
>
> Looks like this one fell through the cracks.
>
> Octavian Purdila <tavip@google.com> writes:
>
> > Add path option to the pty char backend which will create a symbolic
> > link to the given path that points to the allocated PTY.
> >
> > This avoids having to make QMP or HMP monitor queries to find out what
> > the new PTY device path is.
>
> QMP commands chardev-add and chardev-change return the information you
> want:
>
>     # @pty: name of the slave pseudoterminal device, present if and only
>     #     if a chardev of type 'pty' was created
>
> So does HMP command chardev-add.  HMP chardev apparently doesn't, but
> that could be fixed.
>
> So, the use case is basically the command line, right?

> The feature feels rather doubtful to me, to be honest.

The command line is an important use-case, though. Not every
user of QEMU is libvirt with a QMP/HMP connection readily
to hand that they would prefer to use for all configuration...

-- PMM

