Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DF5C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 07:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1truAk-0008RW-2T; Tue, 11 Mar 2025 03:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1truAh-0008R3-SR; Tue, 11 Mar 2025 03:37:04 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1truAf-00014p-02; Tue, 11 Mar 2025 03:37:02 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22355618fd9so94253235ad.3; 
 Tue, 11 Mar 2025 00:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741678616; x=1742283416; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wugsb/VAdBXqhsNzKeMXikme2YwhS6j+gjGQry/CF2w=;
 b=afRr8K/4T4LxLhKppepirHnKaYJqe6l4oIBNJfzuk9c1IK9gUbbx+4EDztdJ3C7+2x
 VzOiRi5KriIrQd1dvAYy4xlMnSuIfX+6yWMjqvfgqeCCcubRiN3uff1o08UbPDBzHtDz
 WsLwZA+Ht9raj34RIs52r/Rr4f/bQpV046dIvT+yixrxXAXo45wYXYqzMCCgalyz5epA
 2xwAWifmUQcFqRkbhVl+AgrXdEm+ispTThRyg8UDcXtEIykXgd5S2JJ1WMlRDe8U4nAd
 /UHGQud+nbeWtmWKa/jZE3uqyPDjIddtM3Mk4iztgaX8YhtlmIJvLStyhJzmFxlOC6q5
 2ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741678616; x=1742283416;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wugsb/VAdBXqhsNzKeMXikme2YwhS6j+gjGQry/CF2w=;
 b=KbLiZVvHnhJMuOSG1sp3cC/HIh5VII0FVvcCuJRu7B2ZlWhe7vn1HZEEhqIKiQJyaH
 tDjFwm643uJ+uYcqljeJGJw3J2pGwP1rkWs5qvVMBEorByJ47YjboxDfv7Wt62+nJXxH
 CfliEV2Ytl5kAEgMxqpcpJrT08le02aQb5ofj05brO+x36aIFG9eSt5BFfFwpRlP6NW+
 jB0Mp/3374GmqrECWnzAcYcthVV0nXYzvYBCTc9wWa2gGkWtshZMpqQ2y/zjTO/gCMQH
 +cKIPz1s+Yb69zzVQ7tGRlRqpqCidNqxRbhiv8f8r/DCAMfpuacT/mu3Yz69GUx02TWl
 cnvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6D6bf1Cvwq5I8tM0jlcXdE3aiQU4MMtYEeVHr0VEPUmlT4JjDMxH0AqfoA9usGXLG4F0VILY+jXw=@nongnu.org,
 AJvYcCWTZTDgkxKv4VFLWz0m5fWdyOz/og88e8qxKLYL3WXMmg7mBwLPialz18hNpw40ALxjn3w7r/5pJmHq@nongnu.org
X-Gm-Message-State: AOJu0YzlaPLQNmZwxl1x/DPnT6/ZKagOZBDbZkyZBwILuMJaAZlHF4M2
 0EXbMqtBdDluOvyrSiadFN6cnzx4H/kO/EPXhTZQLD3BBbteTGD4
X-Gm-Gg: ASbGncv8ls80a6NrwJiQmJM773XkpOBOqR/0+YIXhNsnyZJ/3wLCvY9Wc6yhuIs1w8h
 sFVc/WZv+PvtY/OA+OsRxPssv1YzWW1pDFo5bJAB5584OuHqRVPcUD0Mc4zzFEA4PcfpoxlW1s6
 7fjUCpA5QZcvmhVB0pyxRYWfWnp0/q2YckmARjuRLU8kvJhfgvtg5FZ5uWZ9ifztGwN6kI8q0i2
 dTyoQW8o/tXPreM2zGCslLE54Bs2r+VvhjFCB1obZq/o+EVuCUmHwEeXd0dJgzNS+qsepB0LkiH
 vDj8XXPCcBZ5xBtVG2h/4hdWqAUWUpA8dJrEus3z
X-Google-Smtp-Source: AGHT+IE87BhM4+ws4m6w1LjBbAPkgDjFtyRHfUzUYPtktsSXBSlTZAZWjc9Xd8iprqrByeP+nluIRA==
X-Received: by 2002:a05:6a00:9a1:b0:736:5504:e8b4 with SMTP id
 d2e1a72fcca58-736eb856dabmr3902645b3a.19.1741678615992; 
 Tue, 11 Mar 2025 00:36:55 -0700 (PDT)
Received: from localhost ([118.208.151.101]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73699da011asm9530371b3a.84.2025.03.11.00.36.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 00:36:55 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Mar 2025 17:36:51 +1000
Message-Id: <D8D9JGIVY9SU.3C2LLNDBGMQ0J@gmail.com>
Subject: Re: [PATCH v2 0/5] ppc/amigaone patches
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.19.0
References: <cover.1740673173.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1740673173.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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

On Fri Feb 28, 2025 at 2:39 AM AEST, BALATON Zoltan wrote:
> Hello,
>
> v2:
> - change unused read function to g_assert_not_reached()
> - new patch to add defines to constants
> - added R-b tags
>
> This series adds NVRAM and support for -kernel, -initrd and -append
> options to the amigaone machine. This makes it easier to boot AmigaOS
> and avoids a crash in the guest when it tries to access NVRAM.
>
> While the -kernel option emulates what U-Boot passes to the kernel,
> old Linux kernels for amigaone may not work with it because of two
> reasons: these come in legacy U-Boot Multi-File image format that QEMU
> cannot read and even after unpacking that and creating a kernel uimage
> it won't find PCI devices because it does not initialise them
> correctly. This works when booted from U-Boot because U-Boot inits PCI
> devices. So does my BBoot loader which can be used to load AmigaOS so
> I don't intend to emulate that part of U-Boot.
>
> I'd like this to be merged for the next release please. When merging
> please update https://wiki.qemu.org/ChangeLog/10.0 with the following:
>
> amigaone
>
> Added support for NVRAM and -kernel, -initrd, -append command line
> options. By default the NVRAM contents are not preserved between
> sessions. To make it persistent create a backing file with 'qemu-image
> create -f raw nvram.bin 4k' and add -drive
> if=3Dmtd,format=3Draw,file=3Dnvram.bin to keep NVRAM contents in the back=
ing
> file so settings stored in it will be preserved between sessions.
>
> To run AmigaOS with BBoot using the -kernel option at least BBoot
> version 0.8 is needed. Older BBoot versions only work with -device
> loader and cannot be used with -kernel on amigaone.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Regards,
>
> BALATON Zoltan (5):
>   ppc/amigaone: Simplify replacement dummy_fw
>   ppc/amigaone: Implement NVRAM emulation
>   ppc/amigaone: Add default environment
>   ppc/amigaone: Add kernel and initrd support
>   ppc/amigaone: Add #defines for memory map constants
>
>  hw/ppc/amigaone.c | 284 +++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 271 insertions(+), 13 deletions(-)


