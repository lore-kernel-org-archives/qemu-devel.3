Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05308C54E41
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 23:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rijLG-0007KQ-OK; Fri, 08 Mar 2024 18:09:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmatlack@google.com>)
 id 1rie8i-0005Ty-Dk
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:36:14 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmatlack@google.com>)
 id 1rie8g-0007rH-EL
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:36:12 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a45ecef71deso116252466b.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 09:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1709919368; x=1710524168; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BLQqEflG3oKsA3aPOWUhkr0esXHDoToF4yiF8NeiiXk=;
 b=inUBUjCC3FlrD0L4CjFC+OYaZv8VGx8lYZWBGnthYFJ+qpkTDSGdl9xQpB4BldniIM
 D786om8Vrr5myJo764C/LEDqOM8Upjq8QVLgDaOr+9qSrHT0IRgAiDaXOD/SXIe7wrti
 XAyb17v6bWXZiP6hJtiEt9zM7JvM1SCROaLMbQ7vNskOurTS8/FAnE6QL5NIWayCLlLD
 YM3+ohVVEEWC3pg6a+3393uROQ1vIRK1zcPyEsl/GN0dPD6fjsxBx92p47pHFaINmE0m
 TLC3CUbn0fGJnQ9IWNNE+yKqA11WASkQAdYFBOU4DioiMhI75iefWFWESjwt1gfO0PoJ
 n+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709919368; x=1710524168;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BLQqEflG3oKsA3aPOWUhkr0esXHDoToF4yiF8NeiiXk=;
 b=e7X7m41e0ywnA58aLCGJUvrXLTaVzoKqoygv0a4XfK+CkM6tBTHF7C83rQA6kAtLQx
 Y+HQyHteuY5nztemd2PQeff7RdKcMJs6HMJEReJltv1WtR/8hick8yL+k+HFtr3Dubcs
 DmIqTljL0uyOXSs1fXkxEvhOVsS+k5gL3BfKuYoVv6+8yKnBbawl88KVBfri+zHjmCGi
 3gZhXTfnY8qQTzev3kZ8ZYrWhwgYbdjJT45lzig3l57qCxKI8s9tqgih7jBRuLOyZONw
 wk1Ul+gs5Zb8YJh5CdC0t9IjN73aU3WhEUfaTB90qFYebZay9uIOBHRMMYT/aQBz0Pn0
 k+dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW03vum+e5Hfg01hoklG5wQoWyBDVUkvRafUjrj33e52M5OUSemmlP/CFoKwtJvbw6029wNhD5e6R1o9egxXpz2TGTg+OY=
X-Gm-Message-State: AOJu0YwR7uA16VUCp+AxokiVSi5GwQ1LLEYso0CW9kHShCV+shUp5sGx
 agWiR4BfojR9nnnM7vjq2U6pDJEEclZsNRSRoLLIktrUr8rt7e0dqFR96HRh8UzqUw4Clfo7TEt
 WWUOPCrgSYaBk0kSd650LiIhkuKW9wUsKMjtX
X-Google-Smtp-Source: AGHT+IGceX9beSvLegicFsUM7bVnbHkalYe9JD/77bNVUNdVA+Xl4w4FIFSUu9uJ12/JV7uxpjfKrXnAPKcZF463m/U=
X-Received: by 2002:a17:907:d38b:b0:a45:e3ab:152f with SMTP id
 vh11-20020a170907d38b00b00a45e3ab152fmr3755078ejc.21.1709919368333; Fri, 08
 Mar 2024 09:36:08 -0800 (PST)
MIME-Version: 1.0
References: <cc1bb8e9bc3e1ab637700a4d3defeec95b55060a.camel@amazon.com>
 <CA+i-1C34VT5oFQL7en1n+MdRrO7AXaAMdNVvjFPxOaTDGXu9Dw@mail.gmail.com>
In-Reply-To: <CA+i-1C34VT5oFQL7en1n+MdRrO7AXaAMdNVvjFPxOaTDGXu9Dw@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 8 Mar 2024 09:35:39 -0800
Message-ID: <CALzav=fO2hpaErSRHGCJCKTrJKD7b9F5oEg7Ljhb0u1gB=VKwg@mail.gmail.com>
Subject: Re: Unmapping KVM Guest Memory from Host Kernel
To: Brendan Jackman <jackmanb@google.com>
Cc: "Gowans, James" <jgowans@amazon.com>,
 "seanjc@google.com" <seanjc@google.com>, 
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Roy,
 Patrick" <roypat@amazon.co.uk>, 
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>, "Manwaring,
 Derek" <derekmn@amazon.com>, "rppt@kernel.org" <rppt@kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, 
 "Woodhouse, David" <dwmw@amazon.co.uk>, "Kalyazin,
 Nikita" <kalyazin@amazon.co.uk>, 
 "lstoakes@gmail.com" <lstoakes@gmail.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, 
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "vbabka@suse.cz" <vbabka@suse.cz>, 
 "mst@redhat.com" <mst@redhat.com>, "somlo@cmu.edu" <somlo@cmu.edu>, "Graf (AWS),
 Alexander" <graf@amazon.de>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=dmatlack@google.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 08 Mar 2024 18:09:24 -0500
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

On Fri, Mar 8, 2024 at 8:25=E2=80=AFAM Brendan Jackman <jackmanb@google.com=
> wrote:
>
> Hi James
>
> On Fri, 8 Mar 2024 at 16:50, Gowans, James <jgowans@amazon.com> wrote:
> > Our goal is to more completely address the class of issues whose leak
> > origin is categorized as "Mapped memory" [1].
>
> Did you forget a link below? I'm interested in hearing about that
> categorisation.
>
> > ... what=E2=80=99s the best way to solve getting guest RAM out of
> > the direct map?
>
> It's perhaps a bigger hammer than you are looking for, but the
> solution we're working on at Google is "Address Space Isolation" (ASI)
> - the latest posting about that is [2].
>
> The sense in which it's a bigger hammer is that it doesn't only
> support removing guest memory from the direct map, but rather
> arbitrary data from arbitrary kernel mappings.

I'm not sure if ASI provides a solution to the problem James is trying
to solve. ASI creates a separate "restricted" address spaces where, yes,
guest memory can be not mapped. But any access to guest memory is
 still allowed. An access will trigger a page fault, the kernel will
switch to the "full" kernel address space (flushing hardware buffers
along the way to prevent speculation), and then proceed. i.e. ASI
doesn't not prevent accessing guest memory through the
direct map, it just prevents speculation of guest memory through the
direct map.

I think what James is looking for (and what we are also interested
in), is _eliminating_ the ability to access guest memory from the
direct map entirely. And in general, eliminate the ability to access
guest memory in as many ways as possible.

For that goal, I have been thinking about guest_memfd as a
solution. Yes guest_memfd today is backed by pages of memory that are
mapped in the direct map. But what we can do is add the ability to
back guest_memfd by pages of memory that aren't in the direct map. I
haven't thought it fully through yet but something like... Hide the
majority of RAM from Linux (I believe there are kernel parameters to
do this) and hand it off to guest_memfd to allocate from as a source
of guest memory. Then the only way to access guest memory is to mmap()
a guest_memfd (e.g. for PV userspace devices).

