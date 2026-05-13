Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E17CD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 18:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNEPt-0002Px-5I; Wed, 13 May 2026 14:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1wNEPj-0002OJ-VI
 for qemu-devel@nongnu.org; Wed, 13 May 2026 14:34:37 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1wNEPh-0007Er-Af
 for qemu-devel@nongnu.org; Wed, 13 May 2026 14:34:35 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2b4650d5f5cso28509585ad.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 11:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778697271; x=1779302071; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xuU+IB841m2ffNgmpLllBWpa9Uu+SAePg8yCzUdaE2A=;
 b=pmOS0vgefrUC1P2owYAKhb/kvQQLcbJiC51pf4LwsIwSsStjIj9Q4EsO7wf6qr7mNx
 py3la6wiIujKKO78fQxxaMYJbM4qQMp8VW0LOwDz6Jt71H8jET394fdQ2dNe6knevIqd
 qivjAuuFozcK15ZkZ9IFcVMzEvnvhA5xFyFfrAlZK+VsV7uKW8jsaxUnCo3ENi6vdKdy
 lbe15UMKL7uPW+XuaacvTRmlBEWCGWVbby3y8AKDpCu6nfXbpKNvmS6AVpTbGD7+d6PF
 RrQavJ2KuLFmSuaGCVvH3BBA2o8dBtf2tYmS/KbzvqGzE13kx2/VnW38WJDkcyoC+f4i
 xfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778697271; x=1779302071;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xuU+IB841m2ffNgmpLllBWpa9Uu+SAePg8yCzUdaE2A=;
 b=jMwhnJom7eSBKfHTEu/Eeeerqz+66IEFGlAxljh7t1LOZPsdNKtZ5tp6euZfU5wIza
 CNx3E1Vz/bbkdyVTmFMhfE5s2nhVaekjtAixbWCCvOVF30bGBgCpaQTDEYbzw0mUCvgH
 xS7ws0Lvxy5LXOa1bX/kgVBUmcP8HWkoddLd05mN2g2RQdBq7/bRc9sT5ECdFUVznobr
 Ef0ig8zOG44Vm10bqLkO1rb+AElmGl9ItwoWa+297lWdJoCShR8oiCKWtSEJETWV1pVd
 O/IT6P4eIBOGA0mfBMdv9/VmLurqE8QXLDm2z4T3P+K74FkPck2/nKjSC4WMRYkqvnxd
 G62g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/gRijTIA4C73GXQUxhs8ntIQ9bnY/tp2l3BUMt3StCjcLesJS0rMt/xQj2iGW0NZSrSYqP8EsPoVCe@nongnu.org
X-Gm-Message-State: AOJu0YwSZ/UUqI3y4TjqfMRdDHFvQRVAyMqovrscKcF4fZNsSAOrQFPT
 G6/1KH3PHTh0Nzp5Q8NKhx4RFdwtylm767pSCM8bp2jKJ+uIyPt25R6q
X-Gm-Gg: Acq92OF/Sn95SMM8Hp0iDb/wndNhssgDzf4sWfNPkSwf6pPxMHo9ef31px1zVFycYhd
 v+sbogmUz1tswYmR1q0k9ihgujxeWJe4PD2NMaSZ/gYWzQf6S4Pr0wsyeunfWO+9dMjj4DQ40QL
 lRWZnt5Wa6+3QGVPjyxUJxz55fFv053zdlDmfLRAjjribxrcKtCMXwGAyxlq5lqq2llZeldavDj
 DO6N0IuXXilIlkQEfoCNUOr7e4lqKmIRE+KbLuvPG833KuKY+6h++U+GBiuYLCJiMmmMPQMd1/G
 ydDDEXN1Ji/JFMpNTsu2JtQQHshjT/NMbIfIbaTIZWwpYV2kXD5pLu6JGqfRt5uThRHATWaeQTO
 JFR4/UdwIW0TvtW3doipAPc9UBcvn1XT61mrJZOnLRgKwe6TJvfJnXYpKDZlJfpLpt86GrL5BXY
 JUiEH+XAdDiy0wX9x85nYB76qrslSVri7bxJa5YCrqoSSwOi8=
X-Received: by 2002:a17:903:1b28:b0:2bc:6784:525f with SMTP id
 d9443c01a7336-2bd2f4f863dmr43434035ad.15.1778697271385; 
 Wed, 13 May 2026 11:34:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1e66970sm174724785ad.56.2026.05.13.11.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 11:34:30 -0700 (PDT)
Date: Wed, 13 May 2026 11:34:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH 1/3] target/sh4: Re-allow unaligned access on system
 emulation
Message-ID: <11d2cf4d-303c-4778-abed-cf2bdef7804d@roeck-us.net>
References: <20260513065438.8680-1-philmd@linaro.org>
 <20260513065438.8680-2-philmd@linaro.org>
 <d9bf52a2-f100-4bbf-b015-1bd303f5fe34@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9bf52a2-f100-4bbf-b015-1bd303f5fe34@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, May 13, 2026 at 11:24:27AM -0700, Richard Henderson wrote:
> On 5/12/26 23:54, Philippe Mathieu-Daudé wrote:
> > The change 0 -> MO_ALIGN in commit eb978e50e42 ("target/sh4: Use
> > MO_ALIGN for system UNALIGN()") would have been correct if it was
> > merged before commit 1fceff9c3ca ("tcg: Remove TARGET_ALIGNED_ONLY")
> > which defined MO_UNALN -> 0. What we really want here now is
> > MO_UNALN (MO_ALIGN is dealt with in commit 03a0d87e8dd "target/sh4:
> > Use MO_ALIGN where required").
> 
> Not correct.  All system mode accesses are aligned, or trap.
> 
> All of the UNALIGN are unaligned for linux-user only, in that those are the
> insns that the linux kernel emulates.  Since the linux kernel does not
> emulate all insns, all other insns must be aligned -- that's what
> 03a0d87e8dd is about.
> 
> > Use the correct definition, otherwise we get when booting Linux:
> > 
> >    ok 14 bitfields
> >        KTAP version 1
> >        # Subtest: blackholedev
> >        # module: blackhole_dev_kunit
> >        1..1
> >    delay-slot-insn faulting in handle_unaligned_delayslot: 0000 [#1]
> >    Modules linked in:
> >    CPU: 0 UID: 0 PID: 298 Comm: kunit_try_catch Tainted: G                 N
> >    6.17.0-12907-g8765f467912f #1 NONE
> >    Tainted: [N]=TEST
> >    PC is at test_blackholedev+0xc6/0x1c8
> >    PR is at test_blackholedev+0xca/0x1c8
> >    PC  : 8c228d16 SP  : 8d40bed0 SR  : 40008001 TEA : 8cce4026
> >    R0  : 00000000 R1  : 00000000 R2  : 000000d2 R3  : 8cc77b80
> >    R4  : 8cc77b40 R5  : 0000000e R6  : 8c228cea R7  : 8cce400e
> >    R8  : 8cc77b40 R9  : 8cc77bbc R10 : 8cc77bbe R11 : 8c4b46b0
> >    R12 : 8c78310c R13 : 8cc29cf4 R14 : 8c6e3a88
> >    MACH: 0000d80d MACL: e554cb0f GBR : 00000000 PR  : 8c228d1a
> >    Call trace:
> >     [<8c05b378>] pick_next_task_fair+0x94/0x164
> >     [<8c5c2bce>] __schedule+0x306/0x6ec
> >     [<8c21fa68>] kunit_try_run_case+0x58/0x174
> >    ...
> 
> That would be a kernel bug then.

It is interesting that no one reported this against real hardware,
but then who knows if anyone still runs that hardware and/or that set
of tests.

If I recall correctly, there were other problems when running the sh4
emulation with eb978e50e42f3 in the tree. I have reverted that patch in
my downstream version of qemu, and I'll be happy to carry the revert
along, so from my perspective it is ok to not address the problem in qemu.

Guenter

