Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C41D66BA3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 01:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG78s-0000XZ-KP; Tue, 26 Nov 2024 20:47:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tG78p-0000XJ-OC
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 20:46:55 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tG78o-0002JQ-6K
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 20:46:55 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3ea462a98b9so1574717b6e.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 17:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732672013; x=1733276813; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D57m2+QkCVoQzRvwOibMwJG0cPr9AaXpEPeMwXGPzwo=;
 b=B8l0Uu6MrSFGGBWxvf2HZHte0OjmqwKb8tUG0dKp5YkCpvqeUOzavRHbv+IjkhA4Rw
 +AFbj5q/Y0n3tnliP8362PU4VUZ3Lx0E/fRtllrB+tnFbT5kCORq7DcNWshq63AXbTmu
 Y9PnvwOsrQUAWh7qMFgxnb3CYW9tKSXuUCcbIYqWYtkT1uX2iQr1B+EFAIypbTWLlbVH
 fISHWwY1Yk9k6mtfpN3DJwhnZ4JeQUa2yzMo3+zOWpzh3aHp/kboB7C0zTGKAHWNja8V
 AXc5Of1mP4kX9Xn1XZzVuHWfdAYlZER9vsndjmOdgzinynZMQAUwxjdBycLu5SBye7Ow
 BWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732672013; x=1733276813;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=D57m2+QkCVoQzRvwOibMwJG0cPr9AaXpEPeMwXGPzwo=;
 b=RzUVAHjCPKeoQAqYcqbE5HWQv6xzw/3C8EUbxyRlZR/UWs/ZfcHTFh6ub9LTs0FIE/
 LzINZjxSZMAJG+IV8zyb3FkqwPS2/AlhCuNY52ijv2j8Ltwh3ydd9EFvQuVTc2CxVRjF
 orxmqoFCUKByumsKQqf0KWxddWRlV9vf/dFtAKZR8OD4kg8a8qHIp3u84nqc4YOWtMRL
 5BYsPWbOpBLWULKSVzaDx7fKBM7y55xOPy5jXFZddcJkzItlKEz4N1Kf6F9ygNCYB1Xo
 d7XcOsmem+NWg3NJB0j3gM82CjhjqqluMcbeVZBIABTWoPgp3z1INuVps8rane2OmmXL
 xlBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2KAE7Rqzfmm5TadOdkJdQmUmbyKHoppCNfKDWQX1LenzoBcxXo/qW+TLGchnkWlCAiuWVsmrPKT4p@nongnu.org
X-Gm-Message-State: AOJu0Yxdrjsbs2uuUPD1vrXIiX/i3ZbA2M9rZyHirTJTg7RW+eHZPRl/
 DVhDfI+Sc1H4lXVTsSo+dlOlD51q5naJx2MMvkLvhE5zkvGGVHLf
X-Gm-Gg: ASbGncuyn4K6n1f0AOYtJhm0klkXkvrk2cdH/jGGK0H6ZdU04frYNKCxWAQ4dUKmw84
 1hsD6lg6gYtAq9qLkyUSipcYPta7eTDvSsqL0vlpOeP6IMJtyyuv+d7bh9thTYLWMsd/ogV1gaz
 XcP0ILCj4+jqtbm/0OU8DyxF53zflOtllpGpXqFnX3hWjANtHCDZ23dmzJJuDryOOBxXSojsUQI
 Q9xLRP5Vs+6PokDOshHGGXpceZhorbv9iHsdCrhqsDIJKIpOwcj0HRQlADBVZgUjvzyuUU=
X-Google-Smtp-Source: AGHT+IFv5Wp/I/2uN0uqJy/DirfNOPR9zJOP1McvUcxCrMtiHzo7pNX6kB+9PP3gK0XI477hr8l+Zg==
X-Received: by 2002:a05:6808:1997:b0:3e7:f084:e4a8 with SMTP id
 5614622812f47-3ea6dd47aecmr1583529b6e.30.1732672012690; 
 Tue, 26 Nov 2024 17:46:52 -0800 (PST)
Received: from localhost (124-171-72-210.tpgi.com.au. [124.171.72.210])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fbcbfc068csm8139851a12.13.2024.11.26.17.46.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 17:46:52 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Nov 2024 11:46:47 +1000
Message-Id: <D5WKYRETXBK6.8K8YP8FQLCF7@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Marcel Apfelbaum"
 <marcel.apfelbaum@gmail.com>, "Laurent Vivier" <lvivier@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Gerd Hoffmann" <kraxel@redhat.com>
Subject: Re: [RFC PATCH 4/5] qtest/xhci: Add controller and device setup and
 ring tests
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Fabiano Rosas" <farosas@suse.de>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.18.2
References: <20241108154229.263097-1-npiggin@gmail.com>
 <20241108154229.263097-5-npiggin@gmail.com> <87msi5j0y8.fsf@suse.de>
In-Reply-To: <87msi5j0y8.fsf@suse.de>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x22d.google.com
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

On Tue Nov 12, 2024 at 12:32 AM AEST, Fabiano Rosas wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
>
> > Add tests which init the host controller registers to the point
> > where command and event rings, irqs are operational. Enumerate
> > ports and set up an attached device context that enables device
> > transfer ring to be set up and tested.
> >
> > This test does a bunch of things at once and is yet well
> > librified, but it allows testing basic mechanisms and gives a
> > starting point for further work.
>
> Please give it a pass through checkpatch when you get the chance.

Hey Fabiano,

Thanks. Unfortunately there's a bunch of register macros added here
that are copied from xhci model source, which does upset checkpatch.
It did catch a few issues though, I will fix.

>
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  tests/qtest/usb-hcd-xhci-test.h | 232 +++++++++++++++
> >  tests/qtest/usb-hcd-xhci-test.c | 506 +++++++++++++++++++++++++++++++-
> >  2 files changed, 732 insertions(+), 6 deletions(-)
> >  create mode 100644 tests/qtest/usb-hcd-xhci-test.h
> >
>
> <snip>
>
> > +static void pci_xhci_stress_rings(void)
> > +{
> > +    XHCIQState *s;
> > +    uint32_t value;
> > +    uint64_t input_context;
> > +    XHCIEvRingSeg ev_seg;
> > +    XHCITRB trb;
> > +    uint32_t hcsparams1;
> > +    uint32_t slotid;
> > +    void *mem;
> > +    int i;
> > +
> > +    mem =3D g_malloc(0x1000);
>
> This is leaking.

Good catch, thank you.

Thanks,
Nick

