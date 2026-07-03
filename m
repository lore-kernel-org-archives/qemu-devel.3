Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E797C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfZnt-00083A-U7; Fri, 03 Jul 2026 05:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfZnp-00080p-QA
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:03:17 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfZno-0005Jf-6M
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:03:17 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-6626b5ace23so2006757d50.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 02:03:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783069395; cv=none;
 d=google.com; s=arc-20260327;
 b=IFYg7UEjETqSKiCHi0q0YTF6rJs9dTZPCaLQOlrrV6yBWQvAecmOUt7Ni/f+BbZUIw
 KUytgIalQ4spS72b3thRB04bHi0qXROIDSBfqTID1cN+Q8pqsxF7AKL6zemqAVPlmCEX
 HasYpr2UWC75EgIR4VxQWOpag5cz5muYzCZTurPvoT4GOpJJvbipPwTq50CaHh/0ffcK
 ET9hV+ZufnyKPJsMRFpfyy2Avie9aJZ1l0pCYiu3SxD74YtOl8yOq8ufts5MGv0+DdSt
 4vtolZnUqs6ipl8dgGpc7QRSm6ZKJwzMCSHz3iRWPdHZeIPV4pMSzTcKasEBtp0e8qLs
 Ky3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=99FcNxZGE/TustT4vWYmn9Bnmg1VvhSwGRnN9PBEo18=;
 fh=HGXODa9OB5cWNbRQVqE+1o6+6x5YQ0NZnehMepI0wS8=;
 b=IZFyasFyHzLukEk8IezZsunBoru+mpJBAoyHrP15ESNAIcMj/CrvGTT84rMdrxtwhr
 f3HpN2PHO5i8OZTWgCGjyGDZGShoAPlRPZ3OdPpEeMOhvC3FxB1SEFugLbtkZEFx4vXG
 6MJsgfhDVsmowskDIHcw+Jizfa71LInJljjtYqDZc2hVPFfaRmB9g4F0ahqSkbRaUZEh
 9xIPxtyjFA6f/ILa3rddebMhq2/wacON0/PPLK+rvx5HXjPJYAUrXmeb+2/98GKoO6KA
 zo5EW8v8pINWjtMnWUolFz7+82eTCF3IiQ97I7RPNDUqJjYlGVJqW0wE08eiqIYNCNCy
 opUA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783069395; x=1783674195; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=99FcNxZGE/TustT4vWYmn9Bnmg1VvhSwGRnN9PBEo18=;
 b=H4iPpJ80th7xXIzL67aupxjJpV3VDJhAKLIViZhC/e5ivrrz8G9n6CJIdM3GN9Mkx6
 PiP+tOuo9rkTQ/4kUvAGiV26OHQ8DvwSSK23sT/+/EGdIyY3LHaZYJRKPT8k/O8rRVIF
 sV85IspHO79fkTHAcZn9gCA3/fRrhst+7uSJqketKggVBUpQeBHLliBPTc4e7pxX7ssb
 5wwz24i4XUiv7gXE9kXTtBulMuSqCxhPi2M7Qcm7pTBKNlN/Yrx8TRQ/pm5EMB9tK9Vb
 H8JC82Mp6VMq2rCK6cav/xh9Y7wRVEzCdZXcBFvx8kM/4wfGVe0pER8XubqJrHx47obc
 5VSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783069395; x=1783674195;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=99FcNxZGE/TustT4vWYmn9Bnmg1VvhSwGRnN9PBEo18=;
 b=QEgREKrEcAhmGuwIRBj50XJ7osMC9Causqj0AOUN6seZpyGJSWyXOSClCNVk8opAgB
 SM3nYMrxS1PWAKz4HwQqKQnEpKvYpHAtw7yotpFiLdbCT1rX3tgnK+vqJwAxuaCAALO9
 UIPFtIDVvWqa2Ch8JHNW0sPfu5o2uZnYdGjYQBcoEhb/DnkO7Nt9+++cmKJpTbUpHIpk
 HLsT3/kt5sNzrGF7Sv3hMY+hBa0frsnyaI3vAipBFr37hQmXlQcTfrITZBt4pWUoGAhj
 U5UH5WFy2PEiRBTP9ZZIJmyhT8owLGcyI8BJRhcE1tN9MmsDMfcj9V8TIIASagKP6SO+
 RXIw==
X-Gm-Message-State: AOJu0YxHsmbkZOza0MvQcsBaCpDNscLykZg2+bnHA39TVx8YhbNA6Ewm
 MzLjwiK71etpaWlw6Pg9+lB/ztLIRjCeDJFUvDMMeoQpgd36jii05Co3fUaJal/goGZGb6suL1R
 AApCRcdCxJ28hsJHL5e1cx/2GdJD/ch2GJBfuCw1m1w==
X-Gm-Gg: AfdE7cmtMKSMJSa1df12bI3jxruwZz51QarjnH4ogIQ1fcWZ/jrMQ1IvY6RLNXMG+RA
 Gtpb2+I+oRkspojDERGwPkCmpHWdKxP3c3t0c6/sDRZk1hzCXXifG+9LstUJYQCFhQN3xB/lh/1
 jGOEOVhpqTSCCeXKEetuEweO2T9Fwvl9NtQ6kuFK3aWU/4eZfEQJbQJemapCcf8wlUoZL5xDiHA
 eQ2BP/119IKL6ubBUVEo6w6E0VYLHkw0Vxp91jT5LLMGyOkIL6ZTUomKmWJtgNnesQnUyRA5ioe
 zCJF9cbD4/9pGN0+cCx478H5D44d+njkO55pOyLFvdkZUC962hYNYiBx
X-Received: by 2002:a05:690e:42cd:b0:664:f662:5ee7 with SMTP id
 956f58d0204a3-66636bb2462mr1820350d50.47.1783069393900; Fri, 03 Jul 2026
 02:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260701213359.1855870-1-keith@techtravels.org>
 <20260701213359.1855870-4-keith@techtravels.org>
 <CAFEAcA_3vf5vrwoO0cGcdTsykU8uTf8386oyWki3iQ3Bje9Trw@mail.gmail.com>
 <8d3f679a-3039-404e-879d-b97e1b58e090@techtravels.org>
In-Reply-To: <8d3f679a-3039-404e-879d-b97e1b58e090@techtravels.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 10:03:02 +0100
X-Gm-Features: AVVi8Cc9R1eVVbXofwe35SLDgZ1NvDbElr9dTHMeWnJW70EJqfnQtK5s8d3aM3A
Message-ID: <CAFEAcA-s2xYKG5PiUqFufdgJgMxD1OccbHO9zcCH2+aXwkK70Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] hw/scsi/ncr53c710: rewrite the SCRIPTS engine
To: Keith Monahan <keith@techtravels.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Thu, 2 Jul 2026 at 22:49, Keith Monahan <keith@techtravels.org> wrote:
>
> Peter,
>
> Thanks for going through it. I raised this originally in the v1 thread
> and I am not sure it reached you, so let me lay it out here.
>
> The size is real, but the more useful thing to flag is that reading this
> as a diff against the old model will not give you an accurate view of
> the change, because these are not two versions of one model. They are
> two different implementations, and git is aligning text between them
> that never shared any code.

And yet, when I look at the diff I see clear things that are
just individual fixes or changes to the existing code.
Yes, there's a big change to the core, but it would be much
easier to see what that core change is if it was not all
thrown in with all the other parts too. (Just to check I
had another scroll through and there really is a ton of stuff
in there which is changes like "variable name changed from
'operator' to 'xoperator' or "the constant names in all the
case statements lost their _REG suffix".)

Incidentally, even for "here is a completely new device model"
I would recommend structuring it as multiple patches, not a
single "here is the device" patch, when the device is this
complex.

-- PMM

