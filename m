Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B965C61DC7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzW6r-0006uS-6x; Thu, 27 Aug 2026 05:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzW6q-0006u7-1m
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 05:09:20 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzW6o-0003yI-Ib
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 05:09:19 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-836c8bde2dcso27158667b3.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 02:09:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787821757; cv=none;
 d=google.com; s=arc-20260327;
 b=EHs101bnX5JZix5O7Sw1ruczhjMYVJKZSJmi9eQ6QqS54Kr+96TXN3pBg5jMhrwCc+
 2y2huTpw1AaHCe04mD6jIE4+5JWuAHWWxpLKb8QsG+v06gMS5UuM6TaThddzb5JI4EQM
 DY2SMrGXETMzrXWTBceKJ5B4aCa4KOENIE2x4gKQsBNFl2srMdIXPB1tOdi1N63QHxsD
 8FkssDJOZnbR7FfAncFflq0nG3a/2aDkppigotMTJaJ3+ZGFWVDLHGyz0VijmEfgwoab
 7AkXtRI1j7izH/T6VbCcBCo7y8aOj21PJZ8rY4gO+1icQ6cvTlFFvS/7iH2XcXuw0iL8
 rnKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nNeSuIzM80Ev2zL1czOqBtBwyX2vwQaGwFcIup6MpMc=;
 fh=ZRYhF6Rp+Cnb3RB0wrwVZZJ9P0OjTlPcRm8z4vqZvQc=;
 b=TX4cacWunELSeDMbzYhgvff+mvCjWNGbeQqfivg52Nm2E6GgMFCA8VDNEyZPl/VzwV
 LxROcyEK3BhQ6hMvFiXIwEzKAcTXUgvTcDky45EwmN6nlTQETIDngV60hwziZdvbGvxo
 XpFFOSbR0QT3WIOUjvliOBMqaehB9J4r5EWKpdLJ0klBgcS0lFviVna9VBLgDUIQU1/l
 R+h4niI8f+7eiLNlsZvLH6aVE/3Zf3GJs6CjBXA58AuuXvH6lnkYch7EiBdXC743iwSc
 8dKfEu0Th7OjZMfHkgpH27o2JD7Gc2E8haXG1bJkeoLF/5l9DvuXke3sR7rCYGTdAKKj
 d9wg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787821757; x=1788426557; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nNeSuIzM80Ev2zL1czOqBtBwyX2vwQaGwFcIup6MpMc=;
 b=bKsmKm40vAYP9eywegBEbRofOu4J7D1RP3cinMGo4GMEzH7UI1lsnhqzsn5EBLNwxB
 bJCSd0wT/WF2byPuMELKcE+hel1eR1vjLC9P8677cFeZyL3m1f4F7HZSmsAOL2or8ulA
 z9gtP4QNHDgsfXeutKNHST3QCAfaPZVkX8H7sGnzYcTqiKwgAXFi8cO/Zr4SL6hSjjGX
 Nq12MBmPvZjL8HU52CyKzIS2r2iq1SOVc6gHdggI2gRCs/w4D5YQw1/NwP9xW4Q+5mfg
 hVuRx4q5yAful3KLnszXe6QbYpSfa9l/ki7lML/mbt8fGPygwiO4UDOyfw695jWVrU1o
 HalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787821757; x=1788426557;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nNeSuIzM80Ev2zL1czOqBtBwyX2vwQaGwFcIup6MpMc=;
 b=HOEI//ME+S9D+KEPs5yi4ywxBHpvX2SgFz7iqwhFvtPnO//p1FoYNulXfT9PMXWNjI
 lfDZskJknS4iR6eiW3yG7wkZl74WmvX8QZAsf4OO9IzitEqwOh/MT7JN9j/BRw913Qnb
 7pZwWGMgKeFSZrYFhNDQB4uph+jlCVtSOSTkR6P0FEpZHr6KQkHzCCnGtTbcAIMDXj7M
 vTU5M6zfaeLqJ4qla2UHqGhY+7D1wbiJyK0KXcUTlf3d5evgApjI/IAjNqzNbuX7Bcz0
 MHSI2VEJYwrWwAQN3qPlRWPcSs/zKVtFf+2E1LAimzkbCV4g7bltrmTqpKpuyrCS2fvl
 z5cg==
X-Gm-Message-State: AFuF++kJLrkxC+EmxhayAb96ipK3jpye2qhyQtuCb+cACYUBDnbrC7lF
 izQpsOmplNh4K2SkGQHJ/qsj8GTRIq5v0mLU8zJygcXRjATPWyOQY6bq0HD3i5p3Ofl3/fhzD6s
 WeVfvDvDZn18ezAO2f1hqg3nNvetZFTnQTeh78VopGQ==
X-Gm-Gg: AR+sD12jklIlaf8CYpWfdNXzPW3nbVgX4bGOQa8ceI5G5zonsBo3uXxfojgFEsrHik2
 rkZVlACKYN+vHdf/vqJ6Jzvnxzsq4BbsenTnqV2r8jotfoV51kYYi8SIbIhx0pUiDUAg5q1yNF1
 Kg3Yz89iZYr0PO7pydARFs0JF68Cmp9xzaagyQxsaE4xBt52j9SRvKLa47DZPiZZfSaxItuhUU9
 PCU8m+wn7X1Je8Xct57/a2g2+7pmweXDlVFyOm8dUtEF8pmUX2zsAMoXz2EP8efVE7+jW0dMRyy
 jJK5CT8pLzPoyEk6Aogpqlc6Ww/H+l0ArLJzUVuCH4w4P+HNhWMTnjowSDcjnAeSaMW8OeMDPLd
 aqrRXgARFb5R1NndFme/uGlKGa76aeiMh8toa9mY=
X-Received: by 2002:a05:690c:c50f:b0:858:d554:79e4 with SMTP id
 00721157ae682-858d5547cd3mr37363137b3.20.1787821752523; Thu, 27 Aug 2026
 02:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260825040452.1322251-1-stephensportia@gmail.com>
 <20260825040452.1322251-4-stephensportia@gmail.com>
In-Reply-To: <20260825040452.1322251-4-stephensportia@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2026 10:09:01 +0100
X-Gm-Features: AcwNN1Xaft9WTF2mwWCVxtI7CYhEOz70afodYE300sE0wIN3NECIiYZJsbmOtus
Message-ID: <CAFEAcA8h4JwFFxnTQwxgC2HPAE_YA8CnLSgJo6pdhFcJeLyGmg@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/arm/strongarm: Fix dropped upper byte of ssi
 transfer
To: stephensportia@gmail.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-ppc@nongnu.org, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 Troy Lee <leetroy@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org, 
 Tyrone Ting <kfting@nuvoton.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Aditya Gupta <adityag@linux.ibm.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, Joel Stanley <joel@jms.id.au>,
 Hao Wu <wuhaotsh@google.com>, Glenn Miles <milesg@linux.ibm.com>,
 qemu-riscv@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Portia Stephens <portias@oss.tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Tue, 25 Aug 2026 at 05:05, <stephensportia@gmail.com> wrote:
>
> From: Portia Stephens <portias@oss.tenstorrent.com>
>
> The strongarm model intends to transfer a 16-bit value over SSI. There
> is no machine using this model with a peripheral attached so it is
> impossible to know what the intended SSI peripheral is.
> There is no in-tree peripheral support for 16-bit transfer, update to
> use 8-bit transfer.

This is the strongarm synchronous serial port; the manual says it
"is used to interface to a variety of analog-to-digital converters,
audio and telecom codecs, memory chips and keypad controllers
as well as other miscellaneous serial devices". I don't know
if it's actually connected to anything on real 'collie' hardware,
but if it is then  I don't think QEMU's ever emulated the connected
hardware.

The data is between 4 and 16 bits long. I think the intention
both for this hardware and for QEMU's ssi_transfer() API
is that the guest software is supposed to know what the device
on the other end of the SSI connection is, and program the
controller appropriately. If it programs the controller to
transfer 16 bits to a device that only expects 8 then things
will go wrong in both hardware and QEMU; conversely if it
sends 8 bits to a device that needs 16 that will also break.

-- PMM

