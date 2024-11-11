Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C2DD2E9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 12:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tATtn-0004ds-NT; Mon, 11 Nov 2024 07:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tATtj-0004dd-Ac
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 07:52:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tATth-0004ge-FV
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 07:52:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731329519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x7kdfKYghpMxpcAfUWIgBcc9NkXNJ5wGHoe5byYILq8=;
 b=GSAdPN979Cdz0/oYojgjm/xRDyIzgxZh9gIowNOao2Z1idD+Ay0XT+oG6EgpeJWQCvw9Qd
 dzwrTFmFXHPBQ+2jVClI4rbqc0fkDm6mm4tk+vLw49PX5ZrAoeICFVHvuqZ8mDjJYWBNuU
 vUmAIsBI6AvP9OBP2OIELnF6h8mmywY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-aL8fVU_GMWeQ0kXaXj_IMw-1; Mon, 11 Nov 2024 07:51:56 -0500
X-MC-Unique: aL8fVU_GMWeQ0kXaXj_IMw-1
X-Mimecast-MFC-AGG-ID: aL8fVU_GMWeQ0kXaXj_IMw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43159603c92so31842905e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 04:51:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731329515; x=1731934315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x7kdfKYghpMxpcAfUWIgBcc9NkXNJ5wGHoe5byYILq8=;
 b=S7EdSBmY3SyldLHshCvZWoKzfGWd9ygUFBcAtkejVp7La+L4pLGocf9hetI3Iq27Ch
 sJGcy4PpF6u5cxsi0bomksKcl46QLsceB3yrbxBOkugZxvpceBHffDkxi84coQ/ZP2ZF
 UC2lRoaqCs9MwGPAKmhjeqdOr0i9dN8zi240kHq8qlISi3ImLqSEP0te6UW/z+ul9sdx
 UaNAJ/8TPIc1pmM02BLGxhHlkbRNZyCRlYuhOQW7eUjJ3DEJl4UgW/W2fLM2NTzZKp3P
 CwLyJFjIvARth4f3RQ3QnKbnngUI5USPvBY30dZra6AqxfqgJFHKsnD2vp8G9REEg8jE
 vk0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVohSztWVIUgC6yd+NB8GvnI9GXoTGUDtOPREmpYS7v2ALNwHsPZINX1SRrHTupDtsVhe9l3AZIM8r0@nongnu.org
X-Gm-Message-State: AOJu0Yz5rovIyuqHxXoSze2uItC9nTpC3TugEIq5rlCziQYGV2pFcFgY
 BOdW6z0I8pkUPGbmfm2UNzQjbcRnAApDwgODuvaTV2omZ4wceKa3zVvnHRJnVUXcyzxHUA3YVMa
 VhO1C2YEdGoiSo/hGJX8EKSTZwMhuu8XdaSd1MrjzseA+13lxRhDcDzzLxOKPiUqALeAZ6Rdtd5
 6Lt7A55fRvp9CdyNEAc8G03U5kLTA=
X-Received: by 2002:a05:600c:1d0e:b0:42d:a024:d6bb with SMTP id
 5b1f17b1804b1-432b7517ac2mr96382945e9.20.1731329515490; 
 Mon, 11 Nov 2024 04:51:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IED4O6fI8z7ZRHxPdAY2JtgF7U6teQ5XA7GE8YsrL8K95/hXBjDNSFps6SQamDJFOQmYejPcrTWf744DwXtHWc=
X-Received: by 2002:a05:600c:1d0e:b0:42d:a024:d6bb with SMTP id
 5b1f17b1804b1-432b7517ac2mr96382555e9.20.1731329514600; Mon, 11 Nov 2024
 04:51:54 -0800 (PST)
MIME-Version: 1.0
References: <20241111090534.66439-2-frolov@swemel.ru>
 <CAE8KmOw75c9Vja5dnGy50b2Dqp9wgfMfxRWjHDdqEUkLBUcP+A@mail.gmail.com>
 <60535722-1a11-42f9-a678-d103e227942f@swemel.ru>
In-Reply-To: <60535722-1a11-42f9-a678-d103e227942f@swemel.ru>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 11 Nov 2024 18:21:38 +0530
Message-ID: <CAE8KmOyvCJoOHAw7+Y=2-pDD3co5kcwshJCjGfdsmEpsQLRgow@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest: fix heap-use-after-free
To: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
Cc: farosas@suse.de, lvivier@redhat.com, sdl.qemu@linuxtesting.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.671,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 11 Nov 2024 at 17:41, =D0=94=D0=BC=D0=B8=D1=82=D1=80=D0=B8=D0=B9 =
=D0=A4=D1=80=D0=BE=D0=BB=D0=BE=D0=B2 <frolov@swemel.ru> wrote:
> Above loop dereferences the pointer env, which is pointing to
> the memory area, which is not allowed to read.

* Not allowed to read environment variables? Is it because
Debian/clang does not support the '**envp' parameter? Is '**envp' set
to NULL on Debian? If '**envp' is not supported, then the compiler
should throw an error at build time, no?

> I am pointing on 2 facts:
> 1. "env" is Microsoft`s extension, not a standard
> 2. There is exact example, where standards violation raises
> undefined behavior: debian13/clang16
>

* If this is about Debian not supporting '**envp' parameter, then
it'll help if the commit message says "...Debian does not support this
non-standard extension and crashes QEMU". The asan error makes it
sound like the patch fixes the use-after-free issue. What happens if
the -lasan is not used? Does it still crash QEMUt?

Thank you.
---
  - Prasad


