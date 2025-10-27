Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D8DCCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 13:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDNFY-00046o-Ac; Mon, 27 Oct 2025 09:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDNFP-00046Q-Lx
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:26:55 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDNFK-00067V-34
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:26:55 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-785bf425f96so64924977b3.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 06:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761571603; x=1762176403; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2JlZ40rh/4ufe0hpy/2q9P+F5rcOVJ+uTTMetF3tVtY=;
 b=xIJ92dsufm+R+SYTBRLpaEnOQ0UjZti7nN2i11GPLSFByUtRUs2ObQ3R6/MKJDg7RD
 C0i3Ylsd94FDoEE0w/i/pb0abb2z0ttpyS2Mu97lw6beXEvu5e8Wtn35hsufiqHIeDCV
 uC9R6JfdRd3k6sO6H8p0GeI93gsqVd+HXnt2mgRgywymG8FxYHj/iC09e05GO53Jvt1N
 FfUPkEIITniEH0v5BMP9e4OALpznDyWFFx8M2enIyTVexmJPIsCJ7i/OEd7HB0QUbOde
 fs/7Pc9TivgqalCBd+C4YTT/BEAj65BQV1aPnCPJEN8Ohjinz7jymercsqMYHeN7CX0J
 ow/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761571603; x=1762176403;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2JlZ40rh/4ufe0hpy/2q9P+F5rcOVJ+uTTMetF3tVtY=;
 b=YSOkvBAzBGhaTq6Bv9gB1TiSWjh4Ib5QVxwlS9wbWabuehJJPBRo93xP/vxLvnVofh
 dWq7Gb5zYx3nKNOC3xWvuElBGWGTR4AYCnlV4pAnSnqOXfYBhdKv88PSolkW/AXvD/DW
 WAabHSwLwaGOLZ+7G9lmrD0uO/XyY3Z2wc3je496lnz/xpSC0wu0jF7ZvHfVrMnm85Y5
 UvFvHaKRXtMYxXBIsE2HZyMLv6b3VDkxsDz14YwdwOQsx/Vo5D0gDrmPnikst5PMwDl4
 8xaDEpoctrcYu+VnkyCZepOPHt/kVLD5RsPCpYDI6GU/syhKQR+gfGP3dpGIxs59Y/Kr
 8vpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLiCkDvI9X50RKorzwI0FdwfUAAdlWrGJZSmlB9viR/09A0GW4lHXjGqDbJGwIxdvu32TA5W/0wYWx@nongnu.org
X-Gm-Message-State: AOJu0YxRut/7WJNHKURltm2547OY3JHoZuy0rtxW4HSXpNt6Co/CHB3P
 EE39ZOs0kqgXDndVms1fHRocpuJmIBmjKyTrnpr3KCg9kJkLHVRCO/fy5URYhnxgXZjMBVE9th2
 wgiETMx9PECM+RDBtuHuqklWKX4UlsDGIHD+6LjxZRg==
X-Gm-Gg: ASbGncsE5MQqrCIOLkCt5ag5TiZzrxJNZyD45jHYopkcg3ronIjIRDtt4oxmcREWRvN
 POAQqIp1AAmSjVyomapq3VpsB4+Uuno4ftrfzEUopO7zOS39GJCo0zivoSTInkR5V4VSCPzCsSP
 0fi85K8N0edVCqIC3n+y3/kabJAeKvXflNueZDHfCyLqmPzo3t1nXcEKYw6GaSXjS+hzaOBUPlZ
 /Fui5vCWIK+lI0dvsdeJNCXm60X2+2Pj+sQgRyQ8TlakEtE2E8bSpTUU0mWl32b4B2ah40h
X-Google-Smtp-Source: AGHT+IFk7Uj8LN/dt+aIDo255N2Isb21PA09nzUH/ysHk7N5SlWLcjUArW+QRMC8xnVqzH6u+yc5oUdvGxIRpg+AdB8=
X-Received: by 2002:a05:690e:1281:b0:63f:471b:c949 with SMTP id
 956f58d0204a3-63f471bca5bmr7909122d50.8.1761571603210; Mon, 27 Oct 2025
 06:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20251027123644.63487-1-philmd@linaro.org>
 <87pla8xzd2.fsf@draig.linaro.org>
In-Reply-To: <87pla8xzd2.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Oct 2025 13:26:31 +0000
X-Gm-Features: AWmQ_bkpx50CfK5BteaU9RbSYcG8QV48fHlVzImH5ClM6PbG9BO1ljkCejP4EK8
Message-ID: <CAFEAcA-hWZei6ytAik5sjFcsYqbKaM6K5mzHepmGQpggAdbQmw@mail.gmail.com>
Subject: Re: [PATCH 0/6] hw: Log unassigned MMIO accesses with
 unassigned_mem_ops
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 David Hildenbrand <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Troy Lee <leetroy@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Peter Xu <peterx@redhat.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 27 Oct 2025 at 13:12, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>
> > Do not log unassigned MMIO accesses as I/O ones:
> > expose unassigned_mem_ops then use it instead of
> > unassigned_io_ops.
>
> But why? Is it because ioport.c is a x86 io thing?


There is a behaviour difference: unassigned_mem_ops
will fault (because of unassigned_mem_accepts()),
but unassigned_io_ops will be "reads as -1, writes
are ignored". This patch series doesn't mention any
intention of introducing a behaviour difference, so
I suspect this is not intended...

There are a couple of different but related concepts
here that we need to keep straight:

(1) x86 I/O ops, which are different CPU instructions
that talk to a different memory-space than MMIO
accesses. In QEMU we model these as accesses to the
address_space_io AddressSpace. I believe no other
target CPU has an equivalent to this.

(2) PCI "I/O" BARs. PCI devices can have both MMIO
and IO BARs. A PCI controller on x86 maps IO BARs
into the IO space, I think. On non-x86 the IO BARs
typically appear in a different window for MMIO
accesses. Behaviour of PCI I/O accesses to unimplemented
regions is probably defined by the PCI spec somewhere.
Behaviour of PCI accesses to unimplemented MMIO
window areas is I think technically left unspecified
by the PCI standard, but "write ignore/read -1" is
what x86 does and what most software expects, so
hardware that implements something else is making
its life unnecessarily difficult.

I suspect we entangle the PCI IO BAR concept and
implementation a bit more with the x86 I/O ops
implementation than we ideally ought to.

-- PMM

