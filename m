Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5885CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 13:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDN1o-0006mA-9h; Mon, 27 Oct 2025 09:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDN1c-0006l3-5c
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:12:40 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDN1W-0003Ie-G3
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:12:38 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b64cdbb949cso1049901366b.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 06:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761570747; x=1762175547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BWo+5gPcqX9uNc+sUS39zUVj44E9phbewlddhUfkawQ=;
 b=cnlE1r5dELh6EllqtG8CLL6Ata0t0LlcmeZGBFVqEKj09P+RNTuzQvyCL6rN2IVZSs
 9zm4ZWiT7Fcsk4ctpAnNN+yPmjPZ0t0yrxOS0zu5OrQjkFFZOsF3zoQ8e0zmM+s74qnk
 kqEBvwzb6X0EK93JmfA6ICcoZfs4ArNriKxnpyDStWZYBPQ9p+b3X4JgY60dZn+KH8So
 UXKkOaGVL9uYrl4hcZNzonWrTq0gl1+JLvUhX1dcm0wVX54uvrKY4pQ8OWKpX+aNJ25W
 dYJCZqVnYMo6njlQumBLVce5g8wl+dK3kP4ScyHoovwWM1Av12ZjIitg4CsXVBnEmMLA
 qMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761570747; x=1762175547;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BWo+5gPcqX9uNc+sUS39zUVj44E9phbewlddhUfkawQ=;
 b=CCNdgje/xjETL8lgNt93zWHiN7NOzeu0qhFH6b35J20q8mW9QUwYu8zzFCrnd6xSu7
 nn2nwJ2/VwvdhAXakd6torp1DwD5b7Xiin/pt6/pJc3CyMBrvTl5gJXOP7jQdcuNcDaK
 lsyUrJTTCKk9AzIB+PkmRijI8EiLtQQQfdGkeU54MY93vxOT5pKP1hdoDYTgxki9z36L
 mfsW+xW+zc3uzD5+S+49esEKRrheaijOsjSj2foFkshhy10re+voTH6Rfw6VxIsvDH82
 q1BFPqzepRNSsbkB5nywVz3a+Pd8k5yyPX0WmzxPTOIGldhkwDiEB6Jl66uBr6hXvMxP
 JrxQ==
X-Gm-Message-State: AOJu0YzozcKzooetxDAlidh3Mq2v8S0YFBl2pAqsJiyo0qFeDXdEZPt4
 DEDSO8+1jC+wXrgGfQ03qQJGZDsPIbiuwAK1m+8tbcY4uRxHetErYntlFpse+f5oqlA=
X-Gm-Gg: ASbGnctHk9OfB8cno9oVnte4l1K94XrzHOQMHj2h68d44r/ZFuSiTgymISADVazF2Qu
 BSxQrcEwM/gr6MGPBgQIWiudQn6DHHzAyDGZmYWQBRgxNvoOCPmOAWK1/eQ2DfcoaWYIfJchSOI
 60D7/mtKHjbvKG2zGvN+6/scpG7D2dQP7qboVgo/J3BinKvZ7VjoI+ERuOvFsZ6cz3lxxy1AYuB
 p1aFXQMPKKR3Q4Mz41WFSsd4R9DJoQI8tYrsViBOSRl8QvgNJ4l1lm/WUQ7fArVotxpv5OvBzzF
 tDJlpBG4Jw4p2LSJje+SzJkLnhh1W/P5+ACsfN2uEcqwrjL7fgyw4cAjv6B+AROkvJH3qH1m2kD
 AtmVsDIE6ba2MtWW/GIli5jo9UzgjlADgklLXn/sjHtb2SX9Hm3pUjWSDP08t+juzb+d3qSWwWv
 aM
X-Google-Smtp-Source: AGHT+IERPsJSD/g2t5a29OFpAPhtaDqWSOrkfAqr9rqLYBO5nwEroImSJyGb0DI9xMLYYJhJ5o51TA==
X-Received: by 2002:a17:907:7291:b0:b6d:3f8c:a2ff with SMTP id
 a640c23a62f3a-b6d6ff24b7fmr1304857766b.41.1761570747182; 
 Mon, 27 Oct 2025 06:12:27 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85359687sm762958766b.23.2025.10.27.06.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 06:12:26 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B15E95F8CD;
 Mon, 27 Oct 2025 13:12:25 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 David Hildenbrand
 <david@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Troy Lee <leetroy@gmail.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Helge Deller <deller@gmx.de>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Richard Henderson
 <richard.henderson@linaro.org>,  Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,  Peter Xu
 <peterx@redhat.com>,  Artyom Tarasenko <atar4qemu@gmail.com>,  Jamin Lin
 <jamin_lin@aspeedtech.com>
Subject: Re: [PATCH 0/6] hw: Log unassigned MMIO accesses with
 unassigned_mem_ops
In-Reply-To: <20251027123644.63487-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 27 Oct 2025 13:36:37
 +0100")
References: <20251027123644.63487-1-philmd@linaro.org>
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Mon, 27 Oct 2025 13:12:25 +0000
Message-ID: <87pla8xzd2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Do not log unassigned MMIO accesses as I/O ones:
> expose unassigned_mem_ops then use it instead of
> unassigned_io_ops.

But why? Is it because ioport.c is a x86 io thing?

>
> Philippe Mathieu-Daud=C3=A9 (6):
>   system/memory: Expose unassigned_mem_ops symbol
>   hw/display/vga: Log unassigned MMIO accesses with unassigned_mem_ops
>   hw/pci-host/gpex: Log unassigned MMIO accesses with unassigned_mem_ops
>   hw/pci-host/aspeed: Log unassigned MMIO accesses with
>     unassigned_mem_ops
>   hw/pci-host/astro: Log unassigned MMIO accesses with
>     unassigned_mem_ops
>   hw/sparc64/ebus: Log unassigned MMIO accesses with unassigned_mem_ops
>
>  include/system/memory.h    | 2 ++
>  system/memory-internal.h   | 2 --
>  hw/display/bochs-display.c | 2 +-
>  hw/display/vga-pci.c       | 4 ++--
>  hw/pci-host/aspeed_pcie.c  | 2 +-
>  hw/pci-host/astro.c        | 2 +-
>  hw/pci-host/gpex.c         | 2 +-
>  hw/sparc64/sun4u.c         | 2 +-
>  8 files changed, 9 insertions(+), 9 deletions(-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

