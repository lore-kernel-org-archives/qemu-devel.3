Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF6EC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 16:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwPL4-00044z-KU; Mon, 15 Apr 2024 12:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwPL1-00044k-9g
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 12:37:48 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwPKy-0003V7-DH
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 12:37:46 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56e477db7fbso5421744a12.3
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 09:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713199062; x=1713803862; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mbiaBcLgJ3q3jSpPgGeGxVQfX2CKh5exMIjxeglmr0g=;
 b=dAIb4E0kuRuHQHXk0nyPCr9OaUIeTsUNeriefYWht8W1+ytWMxdRG4ImU3Xa2EIdHl
 QFttHk1zwkixhyM4iGj5EH/Xz5NnDXpzw5SzctOobnribXpApi698UYDzzvTrOCYNPfV
 weWwVNAHS/+Pi05evq2sq13ZUa/MF+PZxy6xstkqhW81AVLBBuron6ZL8ihI28K93ods
 xf1DEesxYAtVEF112FZrs4bMWJ8zK/oIdi2AlbP3sH/KxK1qVfN5xlqPEJlP6muBQvSh
 vxRiyVINVxtnWuThjO6caNYH5pkM4E88ppg3NDH6MEXIp9A2N0XK8bv6JvhBGr/2K+rR
 OJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713199062; x=1713803862;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mbiaBcLgJ3q3jSpPgGeGxVQfX2CKh5exMIjxeglmr0g=;
 b=Wyb94PVtzPZXAgHwNDi3G3E2oJzT3c3W60uR5CwHhHMvGTtTxsZHEixNmq71HVIWr9
 V9sSa9dLLdj1p/eyqqIjgexHmd8kQnpxT6YfA4JmLm44Nc7rjQaYWm+jLNT8j2bMviFm
 p0BcETXGeVhUDrNEETPF9Xkr3k1fX7D9REzWla5YxAe3Aw+dUtKFk9AU4dmV7N2YPeGT
 AeUHUqi05tU8dlnmpP/sOGDQEOY693nPwt+2QlGAs/nMjMpKs2NuFtzbqhBpolZ8CIgq
 4HUx/jAL8oNE04mlUX308I8uQ8Ng6hYdOf9duEdvmt2VKPYx1aL76OUWmlpWOF754/56
 vDSQ==
X-Gm-Message-State: AOJu0Yzb+QYHCW2Xj7a8k1Rm6Uew+BbrC3cRewTUwyo/PAJKFhqZQdwt
 zj5F2D3hl9LMal4lq5YbHJAg5gj5QYr3UGM40Da/Je7oy3xUk5W1LVUWQT7zHOQmsAILlJ9LTpy
 /lPVGyRHxkrfQDdPZ0l6qObF+cyXJ5QrF2EmnOQ==
X-Google-Smtp-Source: AGHT+IGnu9Af8ARbDOqsuh3Tmh7IhlYxvA4oaxJK1OjEgWfQH0/wh/1pS9NDyEgiwvjCrup86N1MMF9nwC3c6nPgRjY=
X-Received: by 2002:a50:aadc:0:b0:568:a30c:2db5 with SMTP id
 r28-20020a50aadc000000b00568a30c2db5mr5913306edc.40.1713199061857; Mon, 15
 Apr 2024 09:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240415160818.2316599-1-porter@cs.unc.edu>
In-Reply-To: <20240415160818.2316599-1-porter@cs.unc.edu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Apr 2024 17:37:30 +0100
Message-ID: <CAFEAcA88myOeQwZ212q9R4EHBPpJbQ1qZYjuz6SS=HZbqS+NCQ@mail.gmail.com>
Subject: Re: Add 'info pg' command to monitor
To: Don Porter <porter@cs.unc.edu>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, dave@treblig.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Mon, 15 Apr 2024 at 17:09, Don Porter <porter@cs.unc.edu> wrote:
> I am a CS professor (and, newly, a second-time contributor). I have
> been using qemu in my courses for over a decade, especially a course
> that asks students to write major pieces of an OS kernel from starter
> code.
>
> I have some patches, originally from Austin Clements at MIT, that I
> have found useful over the years and that may be useful to others.  It
> would also be nice not to have to build a custom qemu each semester.  I
> have cleared upstreaming these with Austin, the original author.
>
> This patch set adds an 'info pg' command to the monitor, which prints
> a nicer view of the page tables.  A project in my graduate OS course
> involves implementing x86 page table support, and my students have
> found this helpful for debugging.

So, my issue with this is that it's x86 specific, and it adds
yet another monitor command that is doing "show some kind of debug
info related to the guest page tables", along with "info mem"
and "info tlb". Plus it is yet another lump of code that's
walking the guest page tables and interpreting them.

What I'd really like to see is some infrastructure that is
at least somewhat guest-architecture-agnostic, so we can
minimise what a guest architecture needs to implement (and
then make providing that mandatory).

The other thing I'd like to see is perhaps some investigation of
whether there's any way to implement something useful by
using/extending the existing get_phys_page_attrs_debug() and
similar functions, so that you don't have to write one lot
of page-table-walking code for QEMU to use when it's executing
guest code and a separate lot (that's bound to get out of
sync or not support new functionality/changes) that's only
handling these monitor debug commands. There's a lot of
complexity in figuring out things like permissions in a
modern architecture...

thanks
-- PMM

