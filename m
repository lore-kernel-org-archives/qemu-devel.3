Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15B3CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 10:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWWud-000740-TL; Mon, 08 Jun 2026 06:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWWuc-00073i-FC
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 06:08:54 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWWua-0006j4-J9
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 06:08:54 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-66077c46c5cso3396420d50.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 03:08:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780913331; cv=none;
 d=google.com; s=arc-20240605;
 b=cyVivMUV8skclsUi21j1tnxp1+UnJH2h0+GJOjrNqYTfFM/W4nxboZCVbZiW+S4YuS
 QpCzIL/281kL5Ys357F97fPXOqjgg83laXTuOUyZoXsR6+fMvyXgWgmEbCVwrFtNVZap
 JTMiE9BjnPUm8ZcC3MqvamW0gFXEgSNkTKyFFkK7lWekZ8zFs3yA5oFlVltE20PibXFQ
 uopFxmjcKVJ673Es5bqyedETgLTwqnDTDHSOFTDPuQ0TJiTEQ/wptfNh7UsVOzC7xt6N
 8pnBep7Chk+NN2keUqkx1ZEzTsujRrMQ7fHFtulA8QkW/KYqwwXl5kbu4vEJ0kQTB2sx
 VDcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eWDh39lodGtkJgTWysmUwRdHa2KkFM9ejskwDU75dQo=;
 fh=0Yr8oJaBK5cFJ0k5qmLByBDTX3eKRYQ53ouvGuISXf4=;
 b=X/D8sB/GvkQkHYiadSMVOMa6lyCc0vGF8teZlFmPlaNGWfGrughjlbAnJYfZVvkSAQ
 jrn9caifn69LJEthOUdPk86oEVKI1W/QE3yt69GaeDQWKv0cwPv44fVUjpcdGvEOIC4E
 /bewhHy8yjKY+DnZiBuAI5k0ag4++zn5/HpD36Zt1tUjJeD+3NqbA+760vtUVfur/QFM
 MQK8DqdR47JOJN9TYgWUkvi6qsIhgraQiNpmH46wSudoZKPkuoS7i1JAEjiFLbEoiycZ
 b9gJJadfXz05hqBtibPKysRMA9S1gV1oWgaQE3OWURdZcmnEqE2weTx3RDCQiEC0VZS1
 C3yA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780913331; x=1781518131; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eWDh39lodGtkJgTWysmUwRdHa2KkFM9ejskwDU75dQo=;
 b=UYdgdnwyojnMWanuG0XmlimPU1AQ+/7hISZ1QdmGUqNMm994Zc/LDxX3/UWkkyAgZC
 dt1af4B3o9A738AJPyv2dALi0hJGoa3rUD3+WLKsQ05CDRBWejHr0lF7PT7dkq/qISCQ
 QKqrJKfsScsebaWfOOosrlmBWavpZLkpZlgrkkSLmBYK3q7OzaLcH+nwV2V/04a5uSjK
 1JApoi+Z1UF7DgFLr2bZIAKjQA+Ag1Wx+S7cazt9gQ1rqJO/c/tUDZBda6hAGwKPh7xO
 RyqCRI6iCwgy+JrkUV9sodaqk0zvi/HG+jFDDIQq3juWnkG/fLbOdFvbpzhRqa4xnKE8
 djcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780913331; x=1781518131;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eWDh39lodGtkJgTWysmUwRdHa2KkFM9ejskwDU75dQo=;
 b=EixqoOkWL1jWs2Fjuauij/aR89PPGQQ/CwUWl7ZlOiJ52mA8dhgNRERhYdVF8sa4D/
 s/ecsbEd9xGkv/U1SkrfkIQ9dttlQcyZmKRJW8TiAXZa9XE9LRj0iBQSZ1ojap0Nbx0H
 S/nLHdT/nCc7BbEbxxE+e1NHBS/RAWA3Qh48tU2ODGdUxhLUGU+J57+KRKTAyCotwSS+
 8XO5JCxD7e2LYRVZ7iW9aT5olev2mYTbq91HIPqza6hkKcFCO5mHGXrHOQEMzV8DyowT
 oilyYcimCYUqDL/WX6iM/leqbBqsOOeoxvQIb1+3DJbx3V81PGVDxJ7rPIRfQ3OlSmt3
 5UMg==
X-Gm-Message-State: AOJu0Yzi2LEexqxRO+rCAELkvKInZflwFGYZO+rfy0b7VVHQ9iDx2I0w
 Td/zbuI8EjpNy8Q17KiAxzi3q5sYoOUiTAT5poLOyQLL9UhAxS7Fa8OwGDZdPltwwqHLxkZD0yX
 iZecfNk6jLRm/a3ukuqPskC+BA9TPqIXRVjkeei1KVw==
X-Gm-Gg: Acq92OEIWpi+a+yFmktUC83FvXdx2dK17vAdlJFIQrz18YqaKTk8B2ufjCu1aJAg6ou
 PDbcAe2gf0C3m3ho2MNuIXYD+M4yszXTr4bBHaf0m9Ob+SIwiFLtguOVtYdk9Q5cGBubbwY2ZOA
 Z3UwSiu3zFL7LxYmFJ0NyHOoactiKmUqDrvOkF2DG7X66/JGY/Ci4xxq/5LbFBjVeiTTm98wtRQ
 dFgMkPDc/4c6rWNogE5w/YTxiQ1CUmh4kbQ515hHujzFdkc/OgvfyJOn4Oj8YKhJmEFVV116Gud
 wbjGdTq2TrDS77TxQ1XMVFyfDgpZ2suLXI1j+PtFC5TGMljwpBWl6z9ofpX8dsSWg3qBycZwK4b
 3ug==
X-Received: by 2002:a05:690e:480b:b0:657:a0f4:ac1d with SMTP id
 956f58d0204a3-66106dda5abmr9045258d50.12.1780913330800; Mon, 08 Jun 2026
 03:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260602190857.1506939-1-daniel.barboza@oss.qualcomm.com>
 <CAFEAcA9WZLV_fsFRN7g9-3NdJ0ecXGYqJHbp6kPPpSAiwM5PnQ@mail.gmail.com>
 <98b5f348-aac4-4be9-a897-95da11c19aa5@oss.qualcomm.com>
In-Reply-To: <98b5f348-aac4-4be9-a897-95da11c19aa5@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 11:08:39 +0100
X-Gm-Features: AVVi8Cf_RiRhi92v-5_OaXCnuVPkJ9oVu3-j4DDqEXs-Q28hlWWXMcZslmzzlvI
Message-ID: <CAFEAcA-P4OySVHDziG59Ln7CuqLFArHjc5v8NsAQafD9HxsuyA@mail.gmail.com>
Subject: Re: [PATCH 0/2] memory.c: make memory_region_dispatch_* report
 ACCESS_ERROR
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@mailo.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Mon, 8 Jun 2026 at 10:47, Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
>
>
> On 6/8/2026 6:09 AM, Peter Maydell wrote:
> > On Tue, 2 Jun 2026 at 20:09, Daniel Henrique Barboza
> > <daniel.barboza@oss.qualcomm.com> wrote:
> >>
> >> Hello,
> >>
> >> I decided to propose this change after working in a RISC-V gitlab bug
> >> [1].  In my proposed fix [2] I had to make assumptions about
> >> address_space_ld* error return, which is always MEMTX_DECODE_ERROR, to
> >> identify that in that particular scenario this is a permission error.
> >> In RISC-V (and from what I can see other archs like x86) an ACCESS_ERROR
> >> due to mem page permission issues will fire a different fault than other
> >> errors like page not found.
> >>
> >> The core logic is on memory_region_access_valid(), which already makes a
> >> distinction between error reasons when we look at the qemu_log_mask()
> >> errors, e.g. this is being characterized as a 'rejected':
> >>
> >> if (mr->ops->valid.accepts
> >>          && !mr->ops->valid.accepts(mr->opaque, addr, size, is_write, attrs)) {
> >>          qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
> >>                        ", size %u, region '%s', reason: rejected\n",
> >>                        is_write ? "write" : "read",
> >>                        addr, size, memory_region_name(mr));
> >
> > valid.accepts returning false isn't a  permissions error, though.
> > It's for cases like "you tried to do a byte access to this device
> > that requires 32-bit accesses only". Permissions errors are entirely
> > in the MMU, and don't appear in the MemTx APIs, which are about
> > transactions in the fabric outside the MMU. The CPU emulation
> > catches permissions errors early before it even does the
> > address_space_ld* call.
> >
> > What is the equivalent of this in the underlying hardware?
> > The current error codes are intended to roughly match the AXI
> > bus SLVERR and DECERR error responses (which are "we were
> > able to pass this memory transaction to a device, but it
> > rejected it" and "we weren't able to find the device for
> > this memory transaction at all").
> >
> > The valid.accepts callback failing is always "we know the memory
> > region but it doesn't like this", which is true for all
> > memory_region_access_valid() failures, so maybe the problem
> > here is that we return DECODE_ERROR for that case when
> > we should be returning ACCESS_ERROR ?
>
> This is the end result I'm going for.  In patch 1 I changed memory_region_access_valid()
> to return ACCESS_ERROR when the valid.accepts fails, keeping all the
> other exit code as DECODE_ERROR.  The ACCESS_ERROR will then be propagated
> as an error in target/riscv/cpu_helper.c, get_physical_address():
>
>          if (riscv_cpu_mxl(env) == MXL_RV32) {
>              pte = be ? address_space_ldl_be(cs->as, pte_addr, attrs, &res)
>                       : address_space_ldl_le(cs->as, pte_addr, attrs, &res);
>          } else {
>              pte = be ? address_space_ldq_be(cs->as, pte_addr, attrs, &res)
>                       : address_space_ldq_le(cs->as, pte_addr, attrs, &res);
>          }
>
>          if (res != MEMTX_OK) {
>              return TRANSLATE_FAIL;
>          }
>
> In this particular case 'res' will fail as ACCESS_ERROR if the pte does not have
> the right permissions and we can throw the right exception.

But what's the "right exception" here? This is, I think, the code
for "the MMU is loading the page table entry from external memory".
I'm not clear what this has to do with permissions. Generally
"permissions" is a concept that applies to virtual addresses, i.e.
"does the page table for this vaddr say we can access it?", and there's
no concept of permissions for physical addresses. The exception to
that is that you might have something like Arm's "granule protection
table" which does apply permissions to physical accesses, so an
in-guest-memory data structure defines what physical addresses can be
accessed in particular ways. In QEMU we model this as effectively
another level of page tables, so again the check happens before we
do the address_space_ld* call. For risc-v a quick look at the architecture
spec suggests that the Smepmp extension is a bit like this (but
handled via registers rather than guest-memory data structures).

The other kind of check that might need to be done in the MMU before
the load call is "is this physaddr out of range?" (e.g. CPU has
48 bit physaddrs and the L1 PTE specifies a physaddr for the L2 PTE
that is outside the 48 bit range).

Do you have a reference in the architecture spec for the check that
you're trying to implement here ?

I would be a bit surprised if the riscv architecture mandated different
MMU errors for "page table entry load failed because the physaddr is not
pointing at any device" vs "page table entry load failed because the
physaddr points at a device and the device rejected it", because it's
really up to the bus specification how clearly it distinguishes these
various kinds of external abort (or even whether it distinguishes them
synchronously vs asynchronously, given the existence of caches), and
usually architecture specifications try not to impose too much on
the implementation.

thanks
-- PMM

