Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557C4C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 15:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZBM9-0004bx-Lv; Wed, 31 Jul 2024 11:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philipp.reisner@linbit.com>)
 id 1sZBM8-0004Wc-AF
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:35:12 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philipp.reisner@linbit.com>)
 id 1sZBM5-0002QU-Nz
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:35:12 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e087c7ef68bso4075912276.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 08:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1722440108; x=1723044908;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f6RbHDfKaxYJB3noPfKcMBAMCooWeWRPc8kq2NOualc=;
 b=LGpxIHNkn/nrP78JdsMQjTalNSDPGA9UuD/UCE9dtKb42rYY9aOv9G9N2ToZPLOOt+
 xOjFFMM5imjMr2RuqGIoVDESrWA2CBsBe98Xqei+1tpCM+FNcVvWdrNdZV+jA830/bng
 FhYMZU1DCY0cqhtWIzQECtZTBR0qt3WPKEl4culO17/ABW+lZOfszM2b+mLxGk5z5OI1
 qjfUYqvlVpScXzWlrXxf1Diar0rohGkwLCgo9IXn0+ok6gt78o/3ZBZYA8MovBkkTNsk
 yqLnMLf87Ocq6+DbNtlTYIZ4hI4PI0vfLgsHZxXucLZZ5/xBlMrt5qspyfe7RuOEoV5B
 yZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722440108; x=1723044908;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f6RbHDfKaxYJB3noPfKcMBAMCooWeWRPc8kq2NOualc=;
 b=jU5bvXs1FvCC9qSR/eqTuO94hAtHIUbTmgtUhvkII0cnRxjaE4JVANL0iXP65eaqRg
 ksazmdy2rWmCcditdUWg8+uQSFOCEyowf7+Y4L9YoHAWs5jvGYXdYRwfI5CttCWKILlQ
 nyNMOLCpTEOpOy0H+fcbSb30k5Ekf6t4ekV/3QChEp3G4esd+tNCr9htwKLlqOBz/MKd
 stumXs/sKOPSiGZhtUeVuIkFqztS8993lFDVhRzJ0zS+ve6pvKwfgJnA5pW85UVPmZE/
 KrjSnLGuVxPnqSGwUtfiwRkM15c4Uomx2fMf455pgcknZZnSgflnkgupCR8pry5EwFLA
 whFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnRsZWCYx9PwUJD0Yi0HEp2RGtOP1xR3q+PiGTMsY3HbqRobecknl6LSI2ASQri4Px4uokVaFLHBPYRRpnJaP7vzN/EJs=
X-Gm-Message-State: AOJu0YxnDT1xbizCc1gTrzJ80dHa6vzpOXEYmh5P9p6BFyCYxtxs8K7A
 quIMulj0BmvKElzUxVsc64ab+yJFTdR5LTZvU16VDhNawbAgaejaqnamqiknaodUbnEJYjexrRk
 EDirdXy/cAnErZ2RAIT2qAV3LnnEnDvuISjKIlg==
X-Google-Smtp-Source: AGHT+IF1OAJzjfd3aEXm3aiYLLoPo7/RVSj18GnELS6+I+TuaDDeAcpBivKUfbiLCWQ4wNAZKxqsWIEHl4CvwFIGozw=
X-Received: by 2002:a05:6902:1029:b0:e08:7950:5d2c with SMTP id
 3f1490d57ef6-e0b545e3cb5mr17850298276.49.1722440108248; Wed, 31 Jul 2024
 08:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240731132524.308273-1-philipp.reisner@linbit.com>
 <ZqpF6VoZgFsfhhl7@redhat.com>
 <CAFEAcA9J37Z1JJb34zyRDo=ow0h1QgOq9bm10dCc0u5bMyQKpg@mail.gmail.com>
 <ZqpWYfst2jsG3TB1@redhat.com>
In-Reply-To: <ZqpWYfst2jsG3TB1@redhat.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Wed, 31 Jul 2024 17:34:57 +0200
Message-ID: <CADGDV=W78U_MZDXaib1kXtnNgkefPaQURsnCE2mbsbhho0h-Mw@mail.gmail.com>
Subject: Re: [PATCH] util: retry open() when it gets interrupted by a signal
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=philipp.reisner@linbit.com; helo=mail-yb1-xb2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Daniel,

> > > > The experienced logfile entry is:
> > > >
> > > > qemu-system-x86_64: -device virtio-blk-pci,bus=pci.0,addr=0x7,drive=libvirt-2-format,id=virtio-disk0,bootindex=2,write-cache=on,serial=1b990c4d13b74a4e90ea: Could not open '/dev/drbd1003': Interrupted system call
>
> What is the actual signal you are seeing that impacts QEMU
> in this way ?
>

I do not know at this point. This only reproduces on a customer's
system we do not have access to. We do not see it in our in-house lab.
And qemu is called through libvirt through ApacheCloudStack. And it
affects only about 10%-20% of the VM start operations.

I will wrap my head around bpftrace and see if I can instruct the
customer to run that on his systems. So, maybe I can answer the
question regarding the signal in a few days. Maybe next week.

The backing device we use (drbd) does an "auto promote" action in its
open implementation. That involves exchanging some packets with some
peers on the local network. I guess that takes between 1ms to 10ms.
So, it exposes a larger time window than other backing block devices,
which probably have a shorter running open implementation.

So this is why we see it sometimes.

with regards,
 Philipp

