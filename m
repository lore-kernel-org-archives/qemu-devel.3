Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9B0108B8F1
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 10:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3XY7-0004aw-7w; Fri, 20 Mar 2026 06:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3XY1-0004al-Ta
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 06:57:47 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3XXz-0000ZM-6t
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 06:57:44 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64ae222d978so2113778d50.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 03:57:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774004262; cv=none;
 d=google.com; s=arc-20240605;
 b=Nl2rCfZV3kLp25TGX12+k0iH+O0RJ6dPlSNvEO65rji2+H/gunTZlvffeg+0Rmg9F5
 2Ghg7O9LfSFbS/NxjfmvP33nE+1ie+ag2vaZD6Corakg3qkvbkXlikmgb32iAel9lYVG
 twKn6BQznCMpkTCaXkDmU1QDHZlSGrq1sZ0uo6oEPNfoFV+GfmLQ6h4Z63QWmatbCBmj
 2+LS6+Bhq0kBUn6sQybSey1IcFOOZBREu2zvSRXK2m/Jk37+ma2Rf6y1dHUWHxkS/5Cz
 tsuv69xKALveXUAp5u+00aIMM3VUTRN6ZdYC7ZGRvoq/SIHk5jIm29ZR6XW/lJLDd+xx
 gGQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5NAeb+r0K9g62kSlsVSXkfafDvekb8iDMpL3/jTEgwg=;
 fh=wSwtMC/fXdDmr5GTT/JTfnBwPCKr9UxCbllAKlLTOsw=;
 b=TXHrDkL8qjvkmydmsHxIE/ROvUr7+xnmqqyMSqnl8rtxetTEoOYnxfD1WyM2VTHgyo
 ivUi5s53R5cXWWTbcRMDUe0C9/h9afuzl523huQJBuRcAduackpEyPE6tUPkkSK0uaE2
 VLnph6RhDePlEstqPGIapI1YouucwQnCz1hHFwkb7HTVsCYuaxaV02KZDozA4ZNoJUnT
 8Og/KQrJbVq0DJfApdkEEttOlPzbmglM+P5nh2Q1BlrDjF4rwibLRBH0l6qGKXY3gexe
 vnJDL83IX2NIrAXjHly/P8F0ifVr61K5B/e7i6ak+364kMLPSpr0LzJKigBkC46g6pl7
 d0bg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774004262; x=1774609062; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5NAeb+r0K9g62kSlsVSXkfafDvekb8iDMpL3/jTEgwg=;
 b=Qk/BELUQlVpIhcS2PU1Bj+L6UoRn+rz6+KquScA57B+vvtr9GazBwY/ZWDDu2tcioW
 RtAkNhnqMfVQrlUnenl1MRlCwqTQF8uWE+Ni8ZZ3rT5Bv5eAXijYgBm+uW564wpFc3+D
 Anc8Ka3AZlKaMmJtefZF/3Zp2pZUf4u8R+QmsnQU9Qw/KG5k6HvecpJ2HCbISxsgEOfS
 yDN4CZEq1wFskfJua2FeDj+TxybyZb1Sf50sVv/KGyrQWmgmRzTqhdaG65IOE0CanpnZ
 C8ag4+Gbcrzkh/Nf3+CO4ZavMAkof8jsVakO5GyO6NPs2P8ZbJebHT2rMmC5FmG8NXsP
 QxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774004262; x=1774609062;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5NAeb+r0K9g62kSlsVSXkfafDvekb8iDMpL3/jTEgwg=;
 b=PnE2CNdC14iFtt9CO8ZrmopOQasfKK5AdbsZMy9AyuQzNLQmEtH9dY8S/4X4JRG4QC
 Cd/Udfa5eEN0NXNx/kHNAEKKx+4AbYVbJ06MXOtwZjG43C8EkxDcnaZ0tdGqOKxtq5DF
 UcebPtjhxhXssylLVNBn6i38jE4EdrouEYY/gxHR+NLf9RD8Wzj6Et0CzStnvtquoxpT
 NwsJBRS2y46lZQb9cz2CCDab2iaTbXZmNkqNNuepE/Hbk5ZwtUGzfFrMbja+L25NwChs
 iSrsMtWIaqJ38lq0vb/v86FV6nKNgxdTAiizDbMFQoJoa6vDboG0Sz4LxyCODRjVx/Lz
 3SDA==
X-Gm-Message-State: AOJu0Yz3E9S5zQi0EKJbLQVajtvnnJ1ErqOFfS7Qy/d2B+qxCLgaepL5
 bDSIOvMR5fOqc4lWLF3gwfvAqJet5yxEe9ApFKHLiDe2xES+1GO5ePTn5/q9S4KwkDHeikQ9oze
 mRCqvQmqTh+KVy3Kblcbh8gN6tK1aWWtIhbgvDhKUZJDlQzjb329o
X-Gm-Gg: ATEYQzyKUW9rM+zLt1VEg3f2eQU9XPrx7ZGpoj+FLo02ThKJAucf/H2SHHjM1LhVh8s
 F8Iz5Rtc2Bez3TlBM1V3s4K2rjMDkMSuu7V8V94DFF1M2KosY6Ql3uDHFz4JEyAxGkOX/yXn+XD
 W1Ho8xJ9hz1axTqXw7zJNydBm/xXR1fpAC5Tz5dIpFAWutoiPO+pUjhi+wtrqyPb7cybeZi//xY
 tZxhX4ON8TBzLUYfcS729LsbJRZqKW/pbgV/iRBRamMxaVwB+FlbAJnrIPJ2lgkry+sOvSYO4Br
 vgxONFEwekoyqCkcVA38KdJ4SdHxY52zm1343xCD/pUX52QFh7N9RaQJi2RMpSbzgXg=
X-Received: by 2002:a05:690e:688:b0:64e:adba:f419 with SMTP id
 956f58d0204a3-64eadbb0af1mr812314d50.72.1774004261735; Fri, 20 Mar 2026
 03:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260309171258.1905205-1-peter.maydell@linaro.org>
In-Reply-To: <20260309171258.1905205-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2026 10:57:29 +0000
X-Gm-Features: AaiRm51nQm4T_iRcRVli7vpuisC9wMzBU6r9Nux3XptwzfnzuY1KIJQC-VRjYdg
Message-ID: <CAFEAcA-nHH3CzHTkAaumtSwXmkohSxJ3G6gVC5HJpckMDzeGdw@mail.gmail.com>
Subject: Re: [PATCH] hw/isa/piix: Embed i8259 irq in device state instead of
 allocating
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Mon, 9 Mar 2026 at 17:12, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The pci_piix_realize() function's use of qemu_allocate_irqs()
> results in a memory leak:
>
> Direct leak of 8 byte(s) in 1 object(s) allocated from:
>     #0 0x61045c7a1a43 in malloc (/home/pm215/qemu/build/san/qemu-system-mips+0x16f8a43) (BuildId: aa43d3865e0f1991b1fc04422b5570fe522b6fa7)
>     #1 0x724cc3095ac9 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #2 0x61045db72134 in qemu_extend_irqs /home/pm215/qemu/build/san/../../hw/core/irq.c:77:51
>     #3 0x61045cd7bf49 in pci_piix_realize /home/pm215/qemu/build/san/../../hw/isa/piix.c:318:35
>     #4 0x61045cf4533e in pci_qdev_realize /home/pm215/qemu/build/san/../../hw/pci/pci.c:2308:9
>     #5 0x61045db6cbca in device_set_realized /home/pm215/qemu/build/san/../../hw/core/qdev.c:523:13
>     #6 0x61045db86bd9 in property_set_bool /home/pm215/qemu/build/san/../../qom/object.c:2376:5
>     #7 0x61045db81c5e in object_property_set /home/pm215/qemu/build/san/../../qom/object.c:1450:5
>     #8 0x61045db8e2fc in object_property_set_qobject /home/pm215/qemu/build/san/../../qom/qom-qobject.c:28:10
>     #9 0x61045db8258f in object_property_set_bool /home/pm215/qemu/build/san/../../qom/object.c:1520:15
>     #10 0x61045db687aa in qdev_realize_and_unref /home/pm215/qemu/build/san/../../hw/core/qdev.c:283:11
>     #11 0x61045d892e21 in mips_malta_init /home/pm215/qemu/build/san/../../hw/mips/malta.c:1239:5
>
> (The i386 PC sets the has-pic property to 'false', so this only
> affects the MIPS Malta board.)
>
> Fix this by embedding the i8259 irq in the device state instead of
> allocating it.  This is a similar fix to the one we used for vt82c686
> in commit 2225dc562a93dc, except that we use qemu_init_irq_child()
> instead of qemu_init_irq().  The behaviour is identical except that
> the _child() version avoids what would be a leak if we ever
> unrealized the device.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

I'll take this via target-arm.next; thanks for the reviews.

-- PMM

